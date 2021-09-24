import { PrismaClient } from '@prisma/client'
import { add } from 'date-fns'

const prisma = new PrismaClient()

const weekFromNow = add(new Date(), { days: 7 })
const twoWeeksFromNow = add(new Date(), { days: 14 })
const monthFromNow = add(new Date(), { days: 28 })

const courseSeeder = async () => {
  await prisma.test.deleteMany({})
  await prisma.course.deleteMany({})
  const course = await prisma.course.create({
    data: {
      name: 'Engineering 001',
      courseDetails: 'Engineering Basics',
      tests: {
        create: [
          {
            date: weekFromNow,
            name: 'Novice Engineering',
          },
          {
            date: twoWeeksFromNow,
            name: 'Basic Engineering',
          },
          {
            date: monthFromNow,
            name: 'Intermediate Engineering',
          },
        ],
      },
    },
    include: { tests: true },
  })

  console.log(course)
}

export default courseSeeder
