import { Module } from '@nestjs/common';
import { JobModule } from './job/job.module';
import { MongooseModule } from '@nestjs/mongoose';
import { ConfigModule } from '@nestjs/config';
import { ResumeModule } from './resume/resume.module';
import { AuthModule } from './auth/auth.module';
import { ApplicationModule } from './application/application.module';

@Module({
  imports: [
    ConfigModule.forRoot({ envFilePath: '.env', isGlobal: true }),
    MongooseModule.forRoot(process.env.DB_URI),
    JobModule,
    ResumeModule,
    AuthModule,
    ApplicationModule,
  ],
})
export class AppModule {}
