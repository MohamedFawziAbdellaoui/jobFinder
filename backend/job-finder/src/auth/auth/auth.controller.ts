import {
  Controller,
  Post,
  Body,
  UseGuards,
  UseInterceptors,
  Get,
  Param,
  NotFoundException,
  UploadedFile,
  StreamableFile,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { User } from 'src/auth/schemas/user.schema';
import { AuthGuard } from '@nestjs/passport';
import { FileInterceptor } from '@nestjs/platform-express/multer';
import { diskStorage } from 'multer';
import * as path from 'path';
import { v4 as uuidv4 } from 'uuid';
import * as fs from 'fs';
import { promisify } from 'util';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}
  @Post('login')
  async login(@Body() loginData: { email: string; password: string }) {
    try {
      const { email, password } = loginData;
      const result = await this.authService.login(email, password);
      return result;
    } catch (error) {
      throw error;
    }
  }
  @Post('signup')
  async signUp(
    @Body() user: User,
  ): Promise<{ token: string; userId: string; type: string }> {
    // console.log(signupData);
    return this.authService.signUp(user);
  }
  @Post('/upload-avatar')
  @UseInterceptors(
    FileInterceptor('avatar', {
      storage: diskStorage({
        destination: './uploads/avatars',
        filename: (req, file, cb) => {
          const filename = `${uuidv4()}${file.originalname}`;
          cb(null, filename);
        },
      }),
    }),
  )
  async uploadAvatar(
    @UploadedFile() avatar: Express.Multer.File,
  ): Promise<{ avatarPath: string }> {
    const avatarPath = avatar ? `/uploads/avatars/${avatar.filename}` : null;
    return { avatarPath };
  }

  @Post('/upload-identity-pic')
  @UseInterceptors(
    FileInterceptor('identityPic', {
      storage: diskStorage({
        destination: './uploads/identities',
        filename: (req, file, cb) => {
          const filename = `${uuidv4()}${file.originalname}`;
          cb(null, filename);
        },
      }),
    }),
  )
  async uploadIdentityPic(
    @UploadedFile() identityPic: Express.Multer.File,
  ): Promise<{ identityPicPath: string }> {
    const identityPicPath = identityPic
      ? `/uploads/identities/${identityPic.filename}`
      : null;
    return { identityPicPath };
  }

  @Get('avatar/:path')
  async getAvatarByPath(
    @Param('path') imagePath: string,
  ): Promise<StreamableFile> {
    if (!imagePath) {
      throw new NotFoundException('Image path parameter is missing');
    }
    const fullPath = path.join(process.cwd(), 'uploads/avatars/', imagePath);

    // Check if the file exists
    if (!fs.existsSync(fullPath)) {
      throw new NotFoundException(`Image at path ${imagePath} not found`);
    }
    // Use promisified fs.readFile to send the file
    const readFile = promisify(fs.readFile);

    try {
      const imageBuffer = await readFile(fullPath);
      return new StreamableFile(imageBuffer);
    } catch (error) {
      throw new NotFoundException(`Error reading image at path ${imagePath}`);
    }
  }
  @Get('identityPic/:path')
  async getIdentiyPicByPath(
    @Param('path') imagePath: string,
  ): Promise<StreamableFile> {
    if (!imagePath) {
      throw new NotFoundException('Image path parameter is missing');
    }
    const fullPath = path.join(process.cwd(), 'uploads/identities/', imagePath);

    // Check if the file exists
    if (!fs.existsSync(fullPath)) {
      throw new NotFoundException(`Image at path ${imagePath} not found`);
    }
    // Use promisified fs.readFile to send the file
    const readFile = promisify(fs.readFile);

    try {
      const imageBuffer = await readFile(fullPath);
      return new StreamableFile(imageBuffer);
    } catch (error) {
      throw new NotFoundException(`Error reading image at path ${imagePath}`);
    }
  }
  @Get('user/:id')
  @UseGuards(AuthGuard())
  async getUserById(@Param('id') id: string): Promise<User> {
    const user = await this.authService.getUserById(id);
    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    return user;
  }
}
