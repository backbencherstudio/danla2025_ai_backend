/*
  Warnings:

  - The `gender` column on the `users` table would be dropped and recreated. This will lead to data loss if there is data in the column.

*/
-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE');

-- CreateEnum
CREATE TYPE "MealType" AS ENUM ('BREAKFAST', 'LUNCH', 'DINNER', 'SNACK');

-- CreateEnum
CREATE TYPE "SourceType" AS ENUM ('APP_RECIPE', 'RESTAURANT', 'CUSTOM');

-- CreateEnum
CREATE TYPE "RestrictionType" AS ENUM ('INTOLERANCE', 'DISLIKE');

-- CreateEnum
CREATE TYPE "MoodLevel" AS ENUM ('LOW', 'NEUTRAL', 'HIGH');

-- CreateEnum
CREATE TYPE "EnergyLevel" AS ENUM ('LOW', 'NEUTRAL', 'HIGH');

-- CreateEnum
CREATE TYPE "DigestionLevel" AS ENUM ('POOR', 'OK', 'GOOD');

-- CreateEnum
CREATE TYPE "AllergyType" AS ENUM ('PEANUTS', 'TREE_NUTS', 'DAIRY', 'EGGS', 'SOY', 'WHEAT_GLUTEN', 'FISH');

-- CreateEnum
CREATE TYPE "CuisineType" AS ENUM ('ITALIAN', 'MEXICAN', 'JAPANESE', 'THAI', 'INDIAN', 'MEDITERRANEAN', 'AMERICAN');

-- CreateEnum
CREATE TYPE "NutritionalPreferenceLevel" AS ENUM ('LOW', 'MODERATE', 'HIGH');

-- AlterTable
ALTER TABLE "users" ADD COLUMN     "activity_level" TEXT,
ADD COLUMN     "age" INTEGER,
ADD COLUMN     "budget" INTEGER,
ADD COLUMN     "carbohydrates_pref" "NutritionalPreferenceLevel" DEFAULT 'MODERATE',
ADD COLUMN     "diet_goal_id" TEXT,
ADD COLUMN     "diet_plan_id" TEXT,
ADD COLUMN     "fat_pref" "NutritionalPreferenceLevel" DEFAULT 'MODERATE',
ADD COLUMN     "fitness_goal_id" TEXT,
ADD COLUMN     "height_cm" INTEGER,
ADD COLUMN     "kitchen_access" BOOLEAN,
ADD COLUMN     "meal_schedule" JSONB,
ADD COLUMN     "notification_prefs" JSONB,
ADD COLUMN     "protein_pref" "NutritionalPreferenceLevel" DEFAULT 'MODERATE',
ADD COLUMN     "sodium_pref" "NutritionalPreferenceLevel" DEFAULT 'MODERATE',
ADD COLUMN     "spice_level_id" TEXT,
ADD COLUMN     "subscription_status" TEXT,
ADD COLUMN     "sugar_pref" "NutritionalPreferenceLevel" DEFAULT 'MODERATE',
ADD COLUMN     "target_rate" DECIMAL(65,30),
ADD COLUMN     "trial_ends_at" TIMESTAMP(3),
ADD COLUMN     "weight_kg" DECIMAL(65,30),
DROP COLUMN "gender",
ADD COLUMN     "gender" "Gender";

-- CreateTable
CREATE TABLE "fitness_goals" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "icon" TEXT,
    "slug" TEXT NOT NULL,
    "sort_order" INTEGER DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "fitness_goals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "diet_goals" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "icon" TEXT,
    "slug" TEXT NOT NULL,
    "sort_order" INTEGER DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "diet_goals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "diets" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "icon" TEXT,
    "slug" TEXT NOT NULL,
    "sort_order" INTEGER DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "diets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "allergies" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "icon" TEXT,
    "slug" TEXT NOT NULL,
    "sort_order" INTEGER DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "allergies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_allergies" (
    "user_id" TEXT NOT NULL,
    "allergy_id" TEXT NOT NULL,

    CONSTRAINT "user_allergies_pkey" PRIMARY KEY ("user_id","allergy_id")
);

-- CreateTable
CREATE TABLE "cuisines" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "icon" TEXT,
    "slug" TEXT NOT NULL,
    "sort_order" INTEGER DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "cuisines_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_cuisines" (
    "user_id" TEXT NOT NULL,
    "cuisine_id" TEXT NOT NULL,

    CONSTRAINT "user_cuisines_pkey" PRIMARY KEY ("user_id","cuisine_id")
);

-- CreateTable
CREATE TABLE "spice_levels" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "title" TEXT NOT NULL,
    "description" TEXT,
    "icon" TEXT,
    "slug" TEXT NOT NULL,
    "sort_order" INTEGER DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "spice_levels_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "restaurants" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "cuisine" TEXT,
    "price_tier" INTEGER,
    "lat" DECIMAL(65,30),
    "lng" DECIMAL(65,30),
    "hours" JSONB,

    CONSTRAINT "restaurants_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "menu_items" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "cuisine" TEXT,
    "meal_type" "MealType" NOT NULL,
    "calories" INTEGER NOT NULL,
    "protein" INTEGER NOT NULL,
    "carbs" INTEGER NOT NULL,
    "fat" INTEGER NOT NULL,
    "tags" TEXT[],
    "allergens" TEXT[],
    "ingredients" TEXT[],
    "source" "SourceType" NOT NULL,
    "restaurant_id" TEXT,

    CONSTRAINT "menu_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "menu_item_matches" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,
    "menu_item_id" TEXT NOT NULL,
    "match_score" INTEGER NOT NULL,
    "reasons" JSONB,
    "avoid_flag" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "menu_item_matches_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "meal_logs" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,
    "menu_item_id" TEXT,
    "custom_name" TEXT,
    "portion_size" DECIMAL(65,30),
    "portion_unit" TEXT,
    "meal_type" "MealType" NOT NULL,
    "served_at" TIMESTAMP(3) NOT NULL,
    "calories" INTEGER NOT NULL,
    "protein" INTEGER NOT NULL,
    "carbs" INTEGER NOT NULL,
    "fat" INTEGER NOT NULL,
    "source" "SourceType" NOT NULL,
    "restaurant_id" TEXT,
    "notes" TEXT,

    CONSTRAINT "meal_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "feedbacks" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "meal_log_id" TEXT NOT NULL,
    "mood" "MoodLevel",
    "energy" "EnergyLevel",
    "digestion" "DigestionLevel",
    "taste_rating" INTEGER,
    "notes" TEXT,

    CONSTRAINT "feedbacks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "score_meals" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "meal_log_id" TEXT NOT NULL,
    "total_score" INTEGER NOT NULL,
    "diet_compliance" INTEGER NOT NULL,
    "calorie_balance" INTEGER NOT NULL,
    "macro_balance" INTEGER NOT NULL,
    "allergen_safety" INTEGER NOT NULL,
    "meal_timing" INTEGER NOT NULL,
    "food_quality" INTEGER NOT NULL,
    "mood_energy" INTEGER NOT NULL,

    CONSTRAINT "score_meals_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "score_dailies" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "nai_score" INTEGER NOT NULL,
    "diet_compliance" INTEGER NOT NULL,
    "calorie_balance" INTEGER NOT NULL,
    "macro_balance" INTEGER NOT NULL,
    "allergen_safety" INTEGER NOT NULL,
    "meal_timing" INTEGER NOT NULL,
    "food_quality" INTEGER NOT NULL,
    "mood_energy" INTEGER NOT NULL,
    "calorie_delta" INTEGER,
    "protein_delta" INTEGER,
    "flags" JSONB,

    CONSTRAINT "score_dailies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "location_visits" (
    "id" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "user_id" TEXT NOT NULL,
    "restaurant_id" TEXT NOT NULL,
    "visited_at" TIMESTAMP(3) NOT NULL,
    "meal_log_id" TEXT,

    CONSTRAINT "location_visits_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "fitness_goals_title_key" ON "fitness_goals"("title");

-- CreateIndex
CREATE UNIQUE INDEX "fitness_goals_slug_key" ON "fitness_goals"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "diet_goals_title_key" ON "diet_goals"("title");

-- CreateIndex
CREATE UNIQUE INDEX "diet_goals_slug_key" ON "diet_goals"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "diets_title_key" ON "diets"("title");

-- CreateIndex
CREATE UNIQUE INDEX "diets_slug_key" ON "diets"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "allergies_title_key" ON "allergies"("title");

-- CreateIndex
CREATE UNIQUE INDEX "allergies_slug_key" ON "allergies"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "cuisines_title_key" ON "cuisines"("title");

-- CreateIndex
CREATE UNIQUE INDEX "cuisines_slug_key" ON "cuisines"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "spice_levels_title_key" ON "spice_levels"("title");

-- CreateIndex
CREATE UNIQUE INDEX "spice_levels_slug_key" ON "spice_levels"("slug");

-- CreateIndex
CREATE UNIQUE INDEX "menu_item_matches_user_id_menu_item_id_key" ON "menu_item_matches"("user_id", "menu_item_id");

-- CreateIndex
CREATE UNIQUE INDEX "feedbacks_meal_log_id_key" ON "feedbacks"("meal_log_id");

-- CreateIndex
CREATE UNIQUE INDEX "score_meals_meal_log_id_key" ON "score_meals"("meal_log_id");

-- CreateIndex
CREATE UNIQUE INDEX "score_dailies_user_id_date_key" ON "score_dailies"("user_id", "date");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_fitness_goal_id_fkey" FOREIGN KEY ("fitness_goal_id") REFERENCES "fitness_goals"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_diet_goal_id_fkey" FOREIGN KEY ("diet_goal_id") REFERENCES "diet_goals"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_diet_plan_id_fkey" FOREIGN KEY ("diet_plan_id") REFERENCES "diets"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_spice_level_id_fkey" FOREIGN KEY ("spice_level_id") REFERENCES "spice_levels"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_allergies" ADD CONSTRAINT "user_allergies_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_allergies" ADD CONSTRAINT "user_allergies_allergy_id_fkey" FOREIGN KEY ("allergy_id") REFERENCES "allergies"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_cuisines" ADD CONSTRAINT "user_cuisines_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_cuisines" ADD CONSTRAINT "user_cuisines_cuisine_id_fkey" FOREIGN KEY ("cuisine_id") REFERENCES "cuisines"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "menu_items" ADD CONSTRAINT "menu_items_restaurant_id_fkey" FOREIGN KEY ("restaurant_id") REFERENCES "restaurants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "menu_item_matches" ADD CONSTRAINT "menu_item_matches_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "menu_item_matches" ADD CONSTRAINT "menu_item_matches_menu_item_id_fkey" FOREIGN KEY ("menu_item_id") REFERENCES "menu_items"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "meal_logs" ADD CONSTRAINT "meal_logs_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "meal_logs" ADD CONSTRAINT "meal_logs_menu_item_id_fkey" FOREIGN KEY ("menu_item_id") REFERENCES "menu_items"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "meal_logs" ADD CONSTRAINT "meal_logs_restaurant_id_fkey" FOREIGN KEY ("restaurant_id") REFERENCES "restaurants"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "feedbacks" ADD CONSTRAINT "feedbacks_meal_log_id_fkey" FOREIGN KEY ("meal_log_id") REFERENCES "meal_logs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "score_meals" ADD CONSTRAINT "score_meals_meal_log_id_fkey" FOREIGN KEY ("meal_log_id") REFERENCES "meal_logs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "score_dailies" ADD CONSTRAINT "score_dailies_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location_visits" ADD CONSTRAINT "location_visits_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location_visits" ADD CONSTRAINT "location_visits_restaurant_id_fkey" FOREIGN KEY ("restaurant_id") REFERENCES "restaurants"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "location_visits" ADD CONSTRAINT "location_visits_meal_log_id_fkey" FOREIGN KEY ("meal_log_id") REFERENCES "meal_logs"("id") ON DELETE SET NULL ON UPDATE CASCADE;
