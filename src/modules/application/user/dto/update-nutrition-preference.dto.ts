import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsNotEmpty, IsOptional } from 'class-validator';
import { NutritionalPreferenceLevel } from 'prisma/generated/enums';

export class UpdateNutritionPreferenceDto {
  @IsNotEmpty()
  @IsEnum(NutritionalPreferenceLevel)
  @ApiProperty({ enum: NutritionalPreferenceLevel, example: 'MODERATE' })
  carbohydrates_pref?: NutritionalPreferenceLevel;

  @IsNotEmpty()
  @IsEnum(NutritionalPreferenceLevel)
  @ApiProperty({ enum: NutritionalPreferenceLevel, example: 'MODERATE' })
  sodium_pref?: NutritionalPreferenceLevel;

  @IsNotEmpty()
  @IsEnum(NutritionalPreferenceLevel)
  @ApiProperty({ enum: NutritionalPreferenceLevel, example: 'MODERATE' })
  fat_pref?: NutritionalPreferenceLevel;

  @IsNotEmpty()
  @IsEnum(NutritionalPreferenceLevel)
  @ApiProperty({ enum: NutritionalPreferenceLevel, example: 'MODERATE' })
  sugar_pref?: NutritionalPreferenceLevel;

  @IsNotEmpty()
  @IsEnum(NutritionalPreferenceLevel)
  @ApiProperty({ enum: NutritionalPreferenceLevel, example: 'MODERATE' })
  protein_pref?: NutritionalPreferenceLevel;
}
