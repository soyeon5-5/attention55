# 퍼블릭 서브넷 생성
resource "aws_subnet" "terra-pub-a"{
    vpc_id  = aws_vpc.terra-vpc.id
    cidr_block  = "10.1.1.0/24"
    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "terra-pub-a"
    }

}
resource "aws_subnet" "terra-pub-c"{
    vpc_id  = aws_vpc.terra-vpc.id
    cidr_block  = "10.1.2.0/24"
    availability_zone = "ap-northeast-2c"

    tags = {
        Name = "terra-pub-c"
    }

}


# 퍼블릭 라우팅 테이블 + IGW
resource "aws_route_table" "terra-rt-pub01" {
    vpc_id = aws_vpc.terra-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.terra-igw.id
    }
    tags = {
        Name = "terra-rt-pub01"
    }
}

# public subnet을 public route table에 연결
resource "aws_route_table_association" "terra-pub-a-rt"{   
    subnet_id = aws_subnet.terra-pub-a.id
    route_table_id = aws_route_table.terra-rt-pub01.id
}
 

resource "aws_route_table_association" "terra-pub-c-rt"{
    subnet_id = aws_subnet.terra-pub-c.id
    route_table_id = aws_route_table.terra-rt-pub01.id
}

