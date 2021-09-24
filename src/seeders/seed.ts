import { PrismaClient } from '@prisma/client'
import { add } from 'date-fns'

const prisma = new PrismaClient()

const weekFromNow = add(new Date(), { days: 7 })
const twoWeeksFromNow = add(new Date(), { days: 14 })
const monthFromNow = add(new Date(), { days: 28 })

const main = async () => {
  await prisma.courseEnrollment.deleteMany({})
  await prisma.testResult.deleteMany({})
  await prisma.user.deleteMany({})
  await prisma.testResult.deleteMany({})
  await prisma.test.deleteMany({})
  await prisma.course.deleteMany({})

  const joe = await prisma.user.create({
    data: {
      email: 'thekiharani@gmail.com',
      firstName: 'Joe',
      lastName: 'Gitonga',
      social: {
        linkedin: 'thekiharani',
        github: 'thekiharani',
        twitter: 'thekiharani',
        facebook: 'thekiharani',
      },
    },
  })

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
      members: {
        create: {
          role: 'TEACHER',
          user: {
            connect: { email: joe.email },
          },
        },
      },
    },
    include: {
      tests: true,
      members: { include: { user: true } },
    },
  })

  const aria = await prisma.user.create({
    data: {
      email: 'thearia@gmail.com',
      firstName: 'Aria',
      lastName: 'Gitonga',
      social: {
        linkedin: 'thearia',
        github: 'thearia',
        twitter: 'thearia',
        facebook: 'thearia',
      },
      courses: {
        create: {
          role: 'STUDENT',
          course: {
            connect: { id: course.id },
          },
        },
      },
    },
  })

  const jayson = await prisma.user.create({
    data: {
      email: 'thejay@gmail.com',
      firstName: 'Jayson',
      lastName: 'Kariuki',
      social: {
        linkedin: 'thejay',
        github: 'thejay',
        twitter: 'thejay',
        facebook: 'thejay',
      },
      courses: {
        create: {
          role: 'STUDENT',
          course: {
            connect: { id: course.id },
          },
        },
      },
    },
  })

  // test results
  const ariaResults = [850, 780, 920]
  let ariaCounter = 0

  for (let test of course.tests) {
    await prisma.testResult.create({
      data: {
        gradedBy: { connect: { email: joe.email } },
        student: { connect: { email: aria.email } },
        test: { connect: { id: test.id } },
        result: ariaResults[ariaCounter],
      },
    })
    ariaCounter++
  }

  const ariaAggregate = await prisma.testResult.aggregate({
    where: { studentId: aria.id },
    _avg: { result: true },
    _max: { result: true },
    _min: { result: true },
    _count: true,
  })

  console.log(ariaAggregate)

  const jayResults = [780, 755, 890]
  let jayCounter = 0

  for (let test of course.tests) {
    await prisma.testResult.create({
      data: {
        gradedBy: { connect: { email: joe.email } },
        student: { connect: { email: jayson.email } },
        test: { connect: { id: test.id } },
        result: jayResults[jayCounter],
      },
    })
    jayCounter++
  }

  const jayAggregate = await prisma.testResult.aggregate({
    where: { studentId: jayson.id },
    _avg: { result: true },
    _max: { result: true },
    _min: { result: true },
    _count: true,
  })

  console.log(jayAggregate)
}

main()
  .catch((e: Error) => {
    console.log(e)
    process.exit()
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
