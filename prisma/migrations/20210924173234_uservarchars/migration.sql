/*
  Warnings:

  - The primary key for the `course_enrollment` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `userId` on the `course_enrollment` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `courseId` on the `course_enrollment` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `courses` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `courses` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `name` on the `courses` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - The primary key for the `test_results` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `test_results` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `testId` on the `test_results` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `studentId` on the `test_results` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `graderId` on the `test_results` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `tests` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `tests` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `name` on the `tests` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - You are about to alter the column `courseId` on the `tests` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - The primary key for the `users` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `users` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(36)`.
  - You are about to alter the column `firstName` on the `users` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.
  - You are about to alter the column `lastName` on the `users` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(100)`.

*/
-- DropForeignKey
ALTER TABLE "course_enrollment" DROP CONSTRAINT "course_enrollment_courseId_fkey";

-- DropForeignKey
ALTER TABLE "course_enrollment" DROP CONSTRAINT "course_enrollment_userId_fkey";

-- DropForeignKey
ALTER TABLE "test_results" DROP CONSTRAINT "test_results_graderId_fkey";

-- DropForeignKey
ALTER TABLE "test_results" DROP CONSTRAINT "test_results_studentId_fkey";

-- DropForeignKey
ALTER TABLE "test_results" DROP CONSTRAINT "test_results_testId_fkey";

-- DropForeignKey
ALTER TABLE "tests" DROP CONSTRAINT "tests_courseId_fkey";

-- DropIndex
DROP INDEX "courses_courseDetails_key";

-- AlterTable
ALTER TABLE "course_enrollment" DROP CONSTRAINT "course_enrollment_pkey",
ALTER COLUMN "userId" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "courseId" SET DATA TYPE VARCHAR(36),
ADD CONSTRAINT "course_enrollment_pkey" PRIMARY KEY ("userId", "courseId", "role");

-- AlterTable
ALTER TABLE "courses" DROP CONSTRAINT "courses_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "name" SET DATA TYPE VARCHAR(100),
ADD CONSTRAINT "courses_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "test_results" DROP CONSTRAINT "test_results_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "testId" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "studentId" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "graderId" SET DATA TYPE VARCHAR(36),
ADD CONSTRAINT "test_results_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "tests" DROP CONSTRAINT "tests_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "name" SET DATA TYPE VARCHAR(100),
ALTER COLUMN "courseId" SET DATA TYPE VARCHAR(36),
ADD CONSTRAINT "tests_pkey" PRIMARY KEY ("id");

-- AlterTable
ALTER TABLE "users" DROP CONSTRAINT "users_pkey",
ALTER COLUMN "id" SET DATA TYPE VARCHAR(36),
ALTER COLUMN "firstName" SET DATA TYPE VARCHAR(100),
ALTER COLUMN "lastName" SET DATA TYPE VARCHAR(100),
ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");

-- AddForeignKey
ALTER TABLE "course_enrollment" ADD CONSTRAINT "course_enrollment_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "course_enrollment" ADD CONSTRAINT "course_enrollment_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "courses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tests" ADD CONSTRAINT "tests_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "courses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "test_results" ADD CONSTRAINT "test_results_testId_fkey" FOREIGN KEY ("testId") REFERENCES "tests"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "test_results" ADD CONSTRAINT "test_results_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "test_results" ADD CONSTRAINT "test_results_graderId_fkey" FOREIGN KEY ("graderId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
