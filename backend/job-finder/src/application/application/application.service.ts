import { Injectable, NotFoundException } from '@nestjs/common';
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
import { Application } from '../schemas/application.schema';
import Job from 'src/job/schemas/job.schema';
import { ApplicationWithJobUser } from '../schemas/fullapp.schema';
import { User } from 'src/auth/schemas/user.schema';

@Injectable()
export class ApplicationService {
  constructor(
    @InjectModel(Application.name)
    private readonly applicationModel: Model<Application>,
    @InjectModel(Job.name)
    private readonly jobModel: Model<Job>,
    @InjectModel(User.name)
    private readonly userModel,
  ) {}

  async getAllApplications(): Promise<ApplicationWithJobUser[]> {
    const applications = await this.applicationModel.find().exec();

    const applicationData: ApplicationWithJobUser[] = [];

    for (const application of applications) {
      const job = await this.jobModel.findById(application.job_id).exec();
      const applicant = await this.userModel
        .findById(application.user_id)
        .exec();
      const publisher = await this.userModel
        .findById(application.entreprise_id)
        .exec();

      if (job && applicant && publisher) {
        const applicationWithJobUser: ApplicationWithJobUser = {
          id: application._id,
          application: application,
          job: job,
          applicant: applicant,
          publisher: publisher,
        };

        applicationData.push(applicationWithJobUser);
      }
    }

    return applicationData;
  }

  async getApplicationsByApplicantId(
    applicantId: string,
  ): Promise<ApplicationWithJobUser[]> {
    const applications = await this.applicationModel
      .find({ user_id: applicantId })
      .exec();

    const applicationData: ApplicationWithJobUser[] = [];

    for (const application of applications) {
      const job = await this.jobModel.findById(application.job_id).exec();
      const applicant = await this.userModel
        .findById(application.user_id)
        .exec();
      const publisher = await this.userModel
        .findById(application.entreprise_id)
        .exec();

      if (job && applicant && publisher) {
        const applicationWithJobUser: ApplicationWithJobUser = {
          id: application._id,
          application: application,
          job: job,
          applicant: applicant,
          publisher: publisher,
        };

        applicationData.push(applicationWithJobUser);
      }
    }

    return applicationData;
  }
  async getApplicationsByEntrepriseId(
    entrepriseId: string,
  ): Promise<ApplicationWithJobUser[]> {
    const applications = await this.applicationModel
      .find({ entreprise_id: entrepriseId })
      .exec();

    const applicationData: ApplicationWithJobUser[] = [];

    for (const application of applications) {
      const job = await this.jobModel.findById(application.job_id).exec();
      const applicant = await this.userModel
        .findById(application.user_id)
        .exec();
      const publisher = await this.userModel
        .findById(application.entreprise_id)
        .exec();

      if (job && applicant && publisher) {
        const applicationWithJobUser: ApplicationWithJobUser = {
          id: application._id,
          application: application,
          job: job,
          applicant: applicant,
          publisher: publisher,
        };

        applicationData.push(applicationWithJobUser);
      }
    }

    return applicationData;
  }
  async getApplicationById(
    applicationId: string,
  ): Promise<ApplicationWithJobUser | null> {
    const application = await this.applicationModel
      .findById(applicationId)
      .exec();

    if (!application) {
      throw new NotFoundException('Application not found');
    }

    const job = await this.jobModel.findById(application.job_id).exec();
    const applicant = await this.userModel.findById(application.user_id).exec();
    const publisher = await this.userModel
      .findById(application.entreprise_id)
      .exec();

    if (!job || !applicant || !publisher) {
      throw new NotFoundException('Related data not found');
    }

    return {
      id: application._id,
      application: application,
      job: job,
      applicant: applicant,
      publisher: publisher,
    };
  }

  async applyForJob(applicationData: any): Promise<Application> {
    const application = new this.applicationModel(applicationData);
    const savedApplication = await application.save();

    // Update the job's applicants_ids with the user's ID
    await this.updateJobApplicants(
      savedApplication.job_id,
      savedApplication.user_id,
    );
    return savedApplication;
  }
  private async updateJobApplicants(
    jobId: string,
    userId: string,
  ): Promise<void> {
    const job = await this.jobModel.findById(jobId).exec();
    if (!job) {
      throw new NotFoundException('Job not found');
    }

    // Update the applicants_ids in the job
    job.applicants_ids.push(userId);
    await job.save();
  }
  async getApplicationsByJobId(jobId: string): Promise<Application[]> {
    return this.applicationModel.find({ job_id: jobId }).exec();
  }
  async getApplicationsByStatus(
    status: string,
  ): Promise<ApplicationWithJobUser[]> {
    const applications = await this.applicationModel.find({ status }).exec();

    const applicationData: ApplicationWithJobUser[] = [];

    for (const application of applications) {
      const job = await this.jobModel.findById(application.job_id).exec();
      const applicant = await this.userModel
        .findById(application.user_id)
        .exec();
      const publisher = await this.userModel
        .findById(application.entreprise_id)
        .exec();

      if (job && applicant && publisher) {
        const applicationWithJobUser: ApplicationWithJobUser = {
          id: application._id,
          application: application,
          job: job,
          applicant: applicant,
          publisher: publisher,
        };

        applicationData.push(applicationWithJobUser);
      }
    }

    return applicationData;
  }
  async getApplicationsByUserId(userId: string): Promise<Application[]> {
    return this.applicationModel.find({ user_id: userId }).exec();
  }
}
