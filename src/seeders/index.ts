import { PrismaClient } from '@prisma/client'
import userSeeder from './users'
import courseSeeder from './courses'

const prisma = new PrismaClient()

const main = async () => {
  await userSeeder()
  await courseSeeder()
}

main()
  .catch((e: Error) => {
    console.log(e)
    process.exit()
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
