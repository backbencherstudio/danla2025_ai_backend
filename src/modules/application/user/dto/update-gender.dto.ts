import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsNotEmpty } from 'class-validator';
import { Gender } from 'prisma/generated/enums';

export class UpdateGenderDto {
  @IsNotEmpty()
  @IsEnum(Gender)
  @ApiProperty({
    description: 'Gender',
    example: 'MALE',
  })
  gender: Gender;
}
