/**
 * Macro Calculator Helper
 * Calculates daily calorie and macro goals based on user profile
 * Using Mifflin-St Jeor formula for BMR and adjustments for activity level and diet goal
 */

export enum ActivityLevel {
  SEDENTARY = 'SEDENTARY', // Little or no exercise
  LIGHTLY_ACTIVE = 'LIGHTLY_ACTIVE', // Exercise 1-3 days/week
  MODERATELY_ACTIVE = 'MODERATELY_ACTIVE', // Exercise 3-5 days/week
  VERY_ACTIVE = 'VERY_ACTIVE', // Exercise 6-7 days/week
  EXTREMELY_ACTIVE = 'EXTREMELY_ACTIVE', // Physical job or training twice per day
}

export enum Gender {
  MALE = 'MALE',
  FEMALE = 'FEMALE',
}

export enum DietGoalType {
  WEIGHT_LOSS = 'WEIGHT_LOSS',
  MAINTENANCE = 'MAINTENANCE',
  MUSCLE_GAIN = 'MUSCLE_GAIN',
}

export interface UserMacroInput {
  weight_kg: number;
  height_cm: number;
  age: number;
  gender: Gender;
  activity_level: ActivityLevel;
  diet_goal: DietGoalType;
}

export interface MacroGoals {
  daily_calorie_goal: number;
  daily_protein_goal: number;
  daily_carbs_goal: number;
  daily_fat_goal: number;
}

/**
 * Calculate BMR (Basal Metabolic Rate) using Mifflin-St Jeor formula
 * @param weight_kg - Weight in kilograms
 * @param height_cm - Height in centimeters
 * @param age - Age in years
 * @param gender - Gender (MALE or FEMALE)
 * @returns BMR in calories
 */
function calculateBMR(
  weight_kg: number,
  height_cm: number,
  age: number,
  gender: Gender,
): number {
  let bmr: number;

  if (gender === Gender.MALE) {
    bmr = 10 * weight_kg + 6.25 * height_cm - 5 * age + 5;
  } else {
    bmr = 10 * weight_kg + 6.25 * height_cm - 5 * age - 161;
  }

  return Math.round(bmr);
}

/**
 * Get activity level multiplier
 * @param activity_level - Activity level enum
 * @returns Multiplier for TDEE calculation
 */
function getActivityMultiplier(activity_level: ActivityLevel): number {
  const multipliers = {
    [ActivityLevel.SEDENTARY]: 1.2,
    [ActivityLevel.LIGHTLY_ACTIVE]: 1.375,
    [ActivityLevel.MODERATELY_ACTIVE]: 1.55,
    [ActivityLevel.VERY_ACTIVE]: 1.725,
    [ActivityLevel.EXTREMELY_ACTIVE]: 1.9,
  };
  return multipliers[activity_level];
}

/**
 * Get diet goal adjustment multiplier
 * @param diet_goal - Diet goal enum
 * @returns Multiplier for calorie adjustment
 */
function getDietGoalMultiplier(diet_goal: DietGoalType): number {
  const multipliers = {
    [DietGoalType.WEIGHT_LOSS]: 0.85, // 15% deficit
    [DietGoalType.MAINTENANCE]: 1.0,
    [DietGoalType.MUSCLE_GAIN]: 1.1, // 10% surplus
  };
  return multipliers[diet_goal];
}

/**
 * Calculate daily macro goals
 * @param input - User profile input
 * @returns Calculated macro goals
 */
export function calculateMacroGoals(input: UserMacroInput): MacroGoals {
  // Step 1: Calculate BMR
  const bmr = calculateBMR(
    input.weight_kg,
    input.height_cm,
    input.age,
    input.gender,
  );

  // Step 2: Calculate TDEE (Total Daily Energy Expenditure)
  const activityMultiplier = getActivityMultiplier(input.activity_level);
  const tdee = Math.round(bmr * activityMultiplier);

  // Step 3: Adjust for diet goal
  const dietGoalMultiplier = getDietGoalMultiplier(input.diet_goal);
  const daily_calorie_goal = Math.round(tdee * dietGoalMultiplier);

  // Step 4: Calculate macro distribution
  // Protein: 30% of calories (4 cal/gram)
  // Carbs: 45% of calories (4 cal/gram)
  // Fat: 25% of calories (9 cal/gram)
  const daily_protein_goal = Math.round((daily_calorie_goal * 0.3) / 4);
  const daily_carbs_goal = Math.round((daily_calorie_goal * 0.45) / 4);
  const daily_fat_goal = Math.round((daily_calorie_goal * 0.25) / 9);

  return {
    daily_calorie_goal,
    daily_protein_goal,
    daily_carbs_goal,
    daily_fat_goal,
  };
}

/**
 * Get macro calculation details (for debugging/logging)
 * @param input - User profile input
 * @returns Detailed calculation breakdown
 */
export function getMacroCalculationDetails(
  input: UserMacroInput,
): {
  bmr: number;
  tdee: number;
  adjusted_calorie: number;
  macros: MacroGoals;
} {
  const bmr = calculateBMR(
    input.weight_kg,
    input.height_cm,
    input.age,
    input.gender,
  );

  const activityMultiplier = getActivityMultiplier(input.activity_level);
  const tdee = Math.round(bmr * activityMultiplier);

  const dietGoalMultiplier = getDietGoalMultiplier(input.diet_goal);
  const adjusted_calorie = Math.round(tdee * dietGoalMultiplier);

  const macros = {
    daily_calorie_goal: adjusted_calorie,
    daily_protein_goal: Math.round((adjusted_calorie * 0.3) / 4),
    daily_carbs_goal: Math.round((adjusted_calorie * 0.45) / 4),
    daily_fat_goal: Math.round((adjusted_calorie * 0.25) / 9),
  };

  return {
    bmr,
    tdee,
    adjusted_calorie,
    macros,
  };
}
