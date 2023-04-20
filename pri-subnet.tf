# 프라이빗 서브넷 생성
resource "aws_subnet" "terra-web-a"{
    vpc_id  = aws_vpc.terra-vpc.id
    cidr_block  = "10.1.3.0/24"
    availability_zone = "ap-south-1a"

    tags = {
        Name = "terra-web-a"
    }

}
resource "aws_subnet" "terra-web-c"{
    vpc_id  = aws_vpc.terra-vpc.id
    cidr_block  = "10.1.4.0/24"
    availability_zone = "ap-south-1c"

    tags = {
        Name = "terra-web-c"
    }

}

resource "aws_subnet" "terra-db-a"{
    vpc_id  = aws_vpc.terra-vpc.id
    cidr_block  = "10.1.5.0/24"
    availability_zone = "ap-south-1a"

    tags = {
        Name = "terra-db-a"
    }

}
resource "aws_subnet" "terra-db-c"{
    vpc_id  = aws_vpc.terra-vpc.id
    cidr_block  = "10.1.6.0/24"
    availability_zone = "ap-south-1c"

    tags = {
        Name = "terra-db-c"
    }

}



# 프라이빗 라우팅 테이블 + NGW + 프라이빗 서브넷 연결
resource "aws_route_table" "terra-rt-pri01"{
    vpc_id = aws_vpc.terra-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.terra-ngw01.id
    }

    tags = {
       Name = "terra-rt-pri01"
   }
}


resource "aws_route_table" "terra-rt-pri02"{
    vpc_id = aws_vpc.terra-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.terra-ngw02.id
    }

    tags = {
       Name = "terra-rt-pri02"
   }
}



resource "aws_route_table_association" "terra-web-a-rt"{
    subnet_id = aws_subnet.terra-web-a.id
    route_table_id = aws_route_table.terra-rt-pri01.id
}

resource "aws_route_table_association" "terra-db-a-rt"{
    subnet_id = aws_subnet.terra-db-a.id
    route_table_id = aws_route_table.terra-rt-pri01.id
}



resource "aws_route_table_association" "terra-web-c-rt"{
    subnet_id = aws_subnet.terra-web-c.id
    route_table_id = aws_route_table.terra-rt-pri02.id
}

resource "aws_route_table_association" "terra-db-c-rt"{
    subnet_id = aws_subnet.terra-db-c.id
    route_table_id = aws_route_table.terra-rt-pri02.id
}
