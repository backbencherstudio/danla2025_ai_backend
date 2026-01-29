import { UpdatePhysicalStatsDto } from './dto/update-profile.dto';
import { Body, Controller, Patch, Req, UseGuards } from '@nestjs/common';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';
import { Request } from 'express';
import { JwtAuthGuard } from '../../auth/guards/jwt-auth.guard';
import { UpdateGenderDto } from './dto/update-gender.dto';
import { UserService } from './user.service';
import { UpdateNutritionPreferenceDto } from './dto/update-nutrition-preference.dto';

@ApiTags('User')
@Controller('application/user')
export class UserController {
  constructor(private readonly userService: UserService) {}

  @ApiOperation({ summary: 'Update gender' })
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @Patch('gender')
  async updateGender(@Req() req: Request, @Body() data: UpdateGenderDto) {
    try {
      const user_id = req.user.userId;
      return await this.userService.updateGender(user_id, data.gender);
    } catch (error) {
      return {
        success: false,
        message: 'Failed to update gender',
      };
    }
  }

  @ApiOperation({ summary: 'Update height, weight, and age' })
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @Patch('physical-stats')
  async updatePhysicalStats(
    @Req() req: Request,
    @Body() data: UpdatePhysicalStatsDto,
  ) {
    try {
      const user_id = req.user.userId;
      return await this.userService.updatePhysicalStats(user_id, data);
    } catch (error) {
      return {
        success: false,
        message: 'Failed to update physical stats',
      };
    }
  }

    @ApiOperation({ summary: 'Update nutrition preferences' })
  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @Patch('nutrition-preference')
  async updateNutritionPreference(
    @Req() req: Request,
    @Body() data: UpdateNutritionPreferenceDto,
  ) {
    try {
      const user_id = req.user.userId;
      return await this.userService.updateNutritionPreference(user_id, data);
    } catch (error) {
      return {
        success: false,
        message: 'Failed to update nutrition preferences',
      };
    }
  }
}
