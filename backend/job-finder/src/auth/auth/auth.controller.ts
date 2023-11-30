import {
  Controller,
  Post,
  Body,
  UseGuards,
  Get,
  Param,
  NotFoundException,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { User } from 'src/auth/schemas/user.schema';
import { AuthGuard } from '@nestjs/passport';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('/signup')
  async signUp(
    @Body() signupData: { user: User; resume: any },
  ): Promise<{ token: string; userId: string }> {
    return this.authService.signUp(signupData);
  }
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
  @Get(':id')
  @UseGuards(AuthGuard())
  async getUserById(@Param('id') id: string): Promise<User> {
    const user = await this.authService.getUserById(id);

    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    return user;
  }
}
