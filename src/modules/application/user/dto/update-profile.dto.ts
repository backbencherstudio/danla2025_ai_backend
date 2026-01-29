import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsNumber, IsOptional, Min, Max } from 'class-validator';

export class UpdatePhysicalStatsDto {
  @IsNotEmpty()
  @IsNumber()
  @Min(50)
  @Max(300)
  @ApiProperty({ description: 'Height in cm', example: 170 })
  height_cm?: number;

  @IsNotEmpty()
  @IsNumber()
  @Min(20)
  @Max(300)
  @ApiProperty({ description: 'Weight in kg', example: 65 })
  weight_kg?: number;

  @IsNotEmpty()
  @IsNumber()
  @Min(1)
  @Max(120)
  @ApiProperty({ description: 'Age', example: 25 })
  age?: number;
}
