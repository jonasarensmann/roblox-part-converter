import prisma from "../prisma/prismaclient";

export default defineEventHandler(async (event) => {
  const query = await getQuery(event);
  if (!query || !query.id) {
    return { statusCode: 200, body: await prisma.model.findMany() };
  }

  if (typeof query.id !== "string")
    return { statusCode: 400, body: "id must be a string" };

  const id = parseInt(query.id);

  const model = await prisma.model.findFirst({
    where: {
      id,
    },
  });
  return { statusCode: 200, body: model };
});
