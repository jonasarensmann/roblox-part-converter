import prisma from "../prisma/prismaclient";
import Joi from "joi";

const schema = Joi.object({
  parts: Joi.array()
    .items(
      Joi.object({
        position: Joi.object({
          X: Joi.number().required(),
          Y: Joi.number().required(),
          Z: Joi.number().required(),
        }).required(),
        size: Joi.object({
          X: Joi.number().required(),
          Y: Joi.number().required(),
          Z: Joi.number().required(),
        }).required(),
        rotation: Joi.object({
          X: Joi.number().required(),
          Y: Joi.number().required(),
          Z: Joi.number().required(),
        }).required(),
        color: Joi.string().required().hex(),
      }).required()
    )
    .required(),
});

export default defineEventHandler(async (event) => {
  const body = await readBody(event);
  const query = await getQuery(event);

  if (!query || !query.key) {
    throw createError({ statusCode: 400, statusMessage: "key is required" });
  }

  if (query.key !== process.env.API_KEY) {
    throw createError({ statusCode: 401, statusMessage: "invalid key" });
  }

  try {
    const value = await schema.validateAsync(body);
  } catch (error) {
    if (error instanceof Error) {
      throw createError({
        statusCode: 400,
        statusMessage: error.message,
      });
    }
  }

  const model = prisma.model.create({
    data: {
      parts: JSON.stringify(body.parts),
    },
  });

  return { statusCode: 200, body: (await model).id };
});
