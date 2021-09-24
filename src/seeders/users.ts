import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()

const userSeeder = async () => {
  await prisma.user.deleteMany({})
  const users = await prisma.user.createMany({
    data: [
      {
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
      {
        email: 'gitongajay@gmail.com',
        firstName: 'Aria',
        lastName: 'Gitonga',
        social: {
          linkedin: 'thearia',
          github: 'thearia',
          twitter: 'thearia',
          facebook: 'thearia',
        },
      },
    ],
  })

  console.log(users)
}

export default userSeeder
