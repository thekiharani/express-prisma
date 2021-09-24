-- AlterTable
ALTER TABLE "courses" ALTER COLUMN "courseDetails" DROP NOT NULL;

-- CreateIndex
CREATE INDEX "course_enrollment_userId_role_idx" ON "course_enrollment"("userId", "role");
