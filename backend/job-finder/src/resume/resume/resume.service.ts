import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Resume, ResumeDocument } from '../schemas/resume.schema';
import { Model } from 'mongoose';
import { Education } from '../schemas/education.schema';
import { WorkExperience } from '../schemas/workexperience.schema';
import { Language } from '../schemas/language.schema';
import { Skills } from '../schemas/skill.schema';
import { Certification } from '../schemas/certification.schema';
import { PopulatedResume } from '../schemas/populated-resume.interface'; // Adjust the path as needed

@Injectable()
export class ResumeService {
  constructor(
    @InjectModel(Resume.name)
    private readonly resumeModel: Model<ResumeDocument>,
    @InjectModel(Education.name)
    private readonly educationModel: Model<Education>,
    @InjectModel(WorkExperience.name)
    private readonly workExperienceModel: Model<WorkExperience>,
    @InjectModel(Language.name) private readonly languageModel: Model<Language>,
    @InjectModel(Skills.name) private readonly skillsModel: Model<Skills>,
    @InjectModel(Certification.name)
    private readonly certificationModel: Model<Certification>,
    @InjectModel(Language.name)
    private readonly langModel: Model<Language>,
  ) {}
  async createResume(data: any): Promise<Resume> {
    if (
      data.file &&
      !(
        data.education ||
        data.workExperience ||
        data.skills ||
        data.certifications ||
        data.languages
      )
    ) {
      return await new this.resumeModel(data);
    } else if (
      data.education ||
      data.workExperience ||
      data.skills ||
      data.certifications ||
      data.languages
    ) {
      const educationIds: string[] = [];
      const workIds: string[] = [];
      const skillIds: string[] = [];
      const certifIds: string[] = [];
      const languageIds: string[] = [];

      for (const ed of data.education) {
        const newEd = await this.educationModel.create(ed);
        educationIds.push(newEd._id.toString());
      }

      for (const work of data.workExperience) {
        const newWork = await this.workExperienceModel.create(work);
        workIds.push(newWork._id.toString());
      }
      for (const skill of data.skills) {
        const newSkill = await this.skillsModel.create(skill);
        skillIds.push(newSkill._id.toString());
      }

      for (const cert of data.certifications) {
        const newCert = await this.certificationModel.create(cert);
        certifIds.push(newCert._id.toString());
      }

      for (const lang of data.languages) {
        const newLang = await this.languageModel.create(lang);
        languageIds.push(newLang._id.toString());
      }
      // Update the data object with the collected IDs
      data.education = educationIds;
      data.workExperience = workIds;
      data.skills = skillIds;
      data.certifications = certifIds;
      data.languages = languageIds;
      // Create the resume
      return await this.resumeModel.create(data);
    }
  }

  async getResumesByUserId(userId: string): Promise<PopulatedResume | null> {
    const resume = await this.resumeModel.findOne({ userId }).exec();
    if (!resume) {
      return null; // Handle the case where no resume is found for the user
    }
    // Fetch the associated subdocuments
    const education = await this.educationModel
      .find({ _id: { $in: resume.education } })
      .exec();
    const workExperience = await this.workExperienceModel
      .find({ _id: { $in: resume.workExperience } })
      .exec();
    const skills = await this.skillsModel
      .find({ _id: { $in: resume.skills } })
      .exec();
    const certifications = await this.certificationModel
      .find({ _id: { $in: resume.certifications } })
      .exec();
    const languages = await this.langModel
      .find({ _id: { $in: resume.languages } })
      .exec();
    return {
      ...resume.toObject(),
      education,
      workExperience,
      skills,
      certifications,
      languages,
    };
  }

  async getResumeById(id: string): Promise<Resume | null> {
    return this.resumeModel
      .findById(id)
      .populate('education workExperience skills certifications languages')
      .exec();
  }

  async updateResume(
    id: string,
    updateData: Partial<Resume>,
  ): Promise<Resume | null> {
    return this.resumeModel
      .findByIdAndUpdate(id, updateData, { new: true })
      .exec();
  }

  async deleteResume(id: string): Promise<Resume | null> {
    return this.resumeModel.findByIdAndDelete(id).exec();
  }
}
