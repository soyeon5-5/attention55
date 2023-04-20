resource "aws_eip" "Nat-EIP"{
    vpc = true
    tags = {
        Name = "Nat-EIP"
    }
}

resource "aws_nat_gateway" "terra-ngw01"{
    allocation_id = aws_eip.Nat-EIP.id
    subnet_id   = aws_subnet.terra-pub-a.id
    tags = {
        Name = "terra-ngw01"
    }
}
