
# private
resource "aws_subnet" "terra-web-a"{
    vpc_id  = aws_vpc.terra-vpc.id
    cidr_block  = "10.0.3.0/24"
    availability_zone = "ap-south-1a"

    tags = {
        Name = "terra-web-a"
    }

}
resource "aws_subnet" "terra-web-c"{
    vpc_id  = aws_vpc.terra-vpc.id
    cidr_block  = "10.0.4.0/24"
    availability_zone = "ap-south-1c"

    tags = {
        Name = "terra-web-c"
    }

}

resource "aws_subnet" "terra-was-a"{
    vpc_id  = aws_vpc.terra-vpc.id
    cidr_block  = "10.0.5.0/24"
    availability_zone = "ap-south-1a"

    tags = {
        Name = "terra-was-a"
    }

}
resource "aws_subnet" "terra-was-c"{
    vpc_id  = aws_vpc.terra-vpc.id
    cidr_block  = "10.0.6.0/24"
    availability_zone = "ap-south-1c"

    tags = {
        Name = "terra-was-c"
    }

}

resource "aws_subnet" "terra-db-a"{
    vpc_id  = aws_vpc.terra-vpc.id
    cidr_block  = "10.0.7.0/24"
    availability_zone = "ap-south-1a"

    tags = {
        Name = "terra-db-a"
    }

}
resource "aws_subnet" "terra-db-c"{
    vpc_id  = aws_vpc.terra-vpc.id
    cidr_block  = "10.0.8.0/24"
    availability_zone = "ap-south-1c"

    tags = {
        Name = "terra-db-c"
    }

}
