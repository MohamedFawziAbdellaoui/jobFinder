import {
  Injectable,
  InternalServerErrorException,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { User } from 'src/auth/schemas/user.schema';
import * as bcrypt from 'bcryptjs';
import { JwtService } from '@nestjs/jwt';
import { ResumeService } from 'src/resume/resume/resume.service';
import { createWriteStream } from 'fs';

@Injectable()
export class AuthService {
  constructor(
    @InjectModel(User.name)
    private userModel: Model<User>,
    private jwtService: JwtService,
    private resumeService: ResumeService,
  ) {}

  async signUp(signupData: {
    user: User;
    resume: any;
  }): Promise<{ token: string; userId: string }> {
    const { user, resume } = signupData;

    const existingUser = await this.userModel.findOne({ email: user.email });
    if (existingUser) {
      new InternalServerErrorException('User with this email already exists');
    }

    // Hash the user's password
    const hashedPassword = await bcrypt.hash(user.password, 10);
    user.password = hashedPassword;
    // Handle file uploads for avatar
    if (user.avatar) {
      const avatarFileName = ``;
      await createWriteStream(`./uploads/avatars/${avatarFileName}`).write(
        user.avatar,
      );
      user.avatar = `uploads/avatars/${avatarFileName}`;
    }

    // Handle file uploads for identityPic
    if (user.identityPic) {
      const identityPicFileName = `identityPic.${user.identityPic}`;
      await createWriteStream(
        `./uploads/identityPics/${identityPicFileName}`,
      ).write(user.identityPic);
      user.identityPic = `uploads/identityPics/${identityPicFileName}`;
    }

    // Create the user
    const createdUser = await this.userModel.create(user);

    if (user.type === 'employee') {
      // Set the user ID in the resume data
      resume.userId = createdUser._id.toString();
      // Create the resume
      const createdResume = await this.resumeService.createResume(resume);
    }
    // Sign a JWT token for the user
    const token = this.jwtService.sign({
      id: createdUser._id,
      type: user.type,
    });

    return { token, userId: createdUser._id.toString() };
  }
  async login(email, password) {
    try {
      // Find the user by email
      const user = await this.userModel.findOne({ email });

      if (!user) {
        throw new Error('User not found');
      }

      // Check if the provided password matches the stored hashed password
      const passwordMatch = await bcrypt.compare(password, user.password);

      if (!passwordMatch) {
        // throw a 401 Unauthorized error for incorrect password
        throw new Error('Incorrect password');
      }

      // If email and password are valid, generate a JWT token
      const token = this.jwtService.sign({ id: user._id, type: user.type });

      return { token, userId: user._id.toString() };
    } catch (error) {
      // Handle errors and throw the appropriate status code
      if (error.message === 'User not found') {
        throw new NotFoundException('User not found');
      } else if (error.message === 'Incorrect password') {
        throw new UnauthorizedException('Incorrect password');
      } else {
        // Handle other errors as needed
        throw new InternalServerErrorException('Internal server error');
      }
    }
  }
  async getUserById(id: string): Promise<User | null> {
    return this.userModel.findById(id).exec();
  }
}
