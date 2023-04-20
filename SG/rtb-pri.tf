# private > nat
resource "aws_route_table" "terra-rt-pri"{
    vpc_id = aws_vpc.terra-vpc.id
    
    tags = {
       Name = "terra-rt-pri"
   }
}

resource "aws_route" "terra-r-pri-web"{
    route_table_id = aws_route_table.terra-rt-pri.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.terra-ngw01.id
}


resource "aws_route_table_association" "terra-rtass-pri-a-web"{
    subnet_id = aws_subnet.terra-web-a.id
    route_table_id = aws_route_table.terra-rt-pri.id
}

resource "aws_route_table_association" "terra-rtass-pri-c-web"{
    subnet_id = aws_subnet.terra-web-c.id
    route_table_id = aws_route_table.terra-rt-pri.id
}



resource "aws_route_table_association" "terra-rtass-pri-a-was"{
    subnet_id = aws_subnet.terra-was-a.id
    route_table_id = aws_route_table.terra-rt-pri.id
}

resource "aws_route_table_association" "terra-rtass-pri-c-was"{
    subnet_id = aws_subnet.terra-was-c.id
    route_table_id = aws_route_table.terra-rt-pri.id
}




resource "aws_route_table_association" "terra-rtass-pri-a-RDB"{
    subnet_id = aws_subnet.terra-db-a.id
    route_table_id = aws_route_table.terra-rt-pri.id
}

resource "aws_route_table_association" "terra-rtass-pri-c-redis"{
    subnet_id = aws_subnet.terra-db-c.id
    route_table_id = aws_route_table.terra-rt-pri.id
}


