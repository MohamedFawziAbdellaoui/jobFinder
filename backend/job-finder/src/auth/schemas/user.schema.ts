import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';
import { Resume } from 'src/resume/schemas/resume.schema';

export type UserDocument = User & Document;

@Schema()
export class User {
  @Prop({ required: true })
  name: string;

  @Prop({ required: true, unique: true })
  email: string;

  @Prop({ required: true })
  password: string;
  @Prop()
  phoneNumber: string;

  @Prop()
  avatar: string;

  @Prop()
  cinOrPassport: string;

  @Prop()
  identityPic: string;

  @Prop({ required: true, enum: ['entreprise', 'employee'] })
  type: string;
  @Prop({ type: Types.ObjectId, ref: 'Resume' })
  resume: Resume;
}

export const UserSchema = SchemaFactory.createForClass(User);
