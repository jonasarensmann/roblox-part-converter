-- CreateTable
CREATE TABLE "Model" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "parts" JSONB NOT NULL,

    CONSTRAINT "Model_pkey" PRIMARY KEY ("id")
);
