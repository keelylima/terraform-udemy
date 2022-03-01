# -- networking/main.tf -- #

resource "random_integer" "random" {
  min = 1
  max = 100
}

resource "aws_vpc" "mtc_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "mtc_vpc_${random_integer.random.id}"
  }
}

resource "aws_subnet" "mtc_public_subnet" {
  # ele vai criar baseado na quantidade que passei de cidrs no root
  count  = var.public_sn_count
  vpc_id = aws_vpc.mtc_vpc.id
  # com count.index ele vai pegar o primeiro da lista na primeira iteração, depois o segundo da lista
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = ["us-east-1a", "us-east-1b", "us-east-1c"][count.index]

  tags = {
    Name = "mtc_public_${count.index + 1}"
  }
}

resource "aws_subnet" "mtc_private_subnet" {
  count             = var.private_sn_count
  vpc_id            = aws_vpc.mtc_vpc.id
  cidr_block        = var.private_cidrs[count.index]
  availability_zone = ["us-east-1a", "us-east-1b", "us-east-1c"][count.index]

  tags = {
    Name = "mtc_private_${count.index + 1}"
  }

}