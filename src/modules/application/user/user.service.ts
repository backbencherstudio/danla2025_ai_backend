import { Injectable } from '@nestjs/common';
import { PrismaService } from '../../../prisma/prisma.service';
import { Gender, NutritionalPreferenceLevel } from 'prisma/generated/enums';

@Injectable()
export class UserService {
  constructor(private readonly prisma: PrismaService) {}

  async updateGender(userId: string, gender: Gender) {
    try {
      const user = await this.prisma.user.findFirst({
        where: { id: userId },
        select: { id: true },
      });

      if (!user) {
        return {
          success: false,
          message: 'User not found',
        };
      }

      await this.prisma.user.update({
        where: { id: userId },
        data: { gender },
      });

      return {
        success: true,
        message: 'Gender updated successfully',
      };
    } catch (error) {
      return {
        success: false,
        message: error.message,
      };
    }
  }
  async updatePhysicalStats(
    userId: string,
    data: { height_cm?: number; weight_kg?: number; age?: number },
  ) {
    try {
      const user = await this.prisma.user.findFirst({
        where: { id: userId },
        select: { id: true },
      });
      if (!user) {
        return {
          success: false,
          message: 'User not found',
        };
      }
      await this.prisma.user.update({
        where: { id: userId },
        data: {
          ...(data.height_cm !== undefined
            ? { height_cm: data.height_cm }
            : {}),
          ...(data.weight_kg !== undefined
            ? { weight_kg: data.weight_kg }
            : {}),
          ...(data.age !== undefined ? { age: data.age } : {}),
        },
      });
      return {
        success: true,
        message: 'Physical stats updated successfully',
      };
    } catch (error) {
      return {
        success: false,
        message: error.message,
      };
    }
  }

  async updateNutritionPreference(
    userId: string,
    data: {
      carbohydrates_pref?: NutritionalPreferenceLevel;
      sodium_pref?: NutritionalPreferenceLevel;
      fat_pref?: NutritionalPreferenceLevel;
      sugar_pref?: NutritionalPreferenceLevel;
      protein_pref?: NutritionalPreferenceLevel;
    },
  ) {
    try {
      const user = await this.prisma.user.findFirst({
        where: { id: userId },
        select: { id: true },
      });
      if (!user) {
        return {
          success: false,
          message: 'User not found',
        };
      }
      await this.prisma.user.update({
        where: { id: userId },
        data: {
          ...(data.carbohydrates_pref !== undefined
            ? { carbohydrates_pref: data.carbohydrates_pref }
            : {}),
          ...(data.sodium_pref !== undefined
            ? { sodium_pref: data.sodium_pref }
            : {}),
          ...(data.fat_pref !== undefined ? { fat_pref: data.fat_pref } : {}),
          ...(data.sugar_pref !== undefined
            ? { sugar_pref: data.sugar_pref }
            : {}),
          ...(data.protein_pref !== undefined
            ? { protein_pref: data.protein_pref }
            : {}),
        },
      });
      return {
        success: true,
        message: 'Nutrition preferences updated successfully',
      };
    } catch (error) {
      return {
        success: false,
        message: error.message,
      };
    }
  }
}
