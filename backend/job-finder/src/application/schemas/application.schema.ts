// application.schema.ts
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';

@Schema()
export class Application extends Document {
  @Prop({ required: true, type: Types.ObjectId, ref: 'Job' })
  job_id: string;

  @Prop({ required: true, type: Types.ObjectId, ref: 'User' })
  user_id: string;

  @Prop({ required: true, type: Types.ObjectId, ref: 'User' })
  entreprise_id: string;

  @Prop({
    required: true,
    enum: ['pending', 'contract_signed', 'started', 'finished'],
  })
  status: string;
}

export const ApplicationSchema = SchemaFactory.createForClass(Application);
