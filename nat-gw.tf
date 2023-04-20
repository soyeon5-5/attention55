resource "aws_eip" "Nat-EIP01"{
    vpc = true
    tags = {
        Name = "Nat-EIP01"
    }
}

resource "aws_nat_gateway" "terra-ngw01"{
    allocation_id = aws_eip.Nat-EIP01.id
    subnet_id   = aws_subnet.terra-pub-a.id
    tags = {
        Name = "terra-ngw01"
    }
}


resource "aws_eip" "Nat-EIP02"{
    vpc = true
    tags = {
        Name = "Nat-EIP02"
    }
}

resource "aws_nat_gateway" "terra-ngw02"{
    allocation_id = aws_eip.Nat-EIP02.id
    subnet_id   = aws_subnet.terra-pub-c.id
    tags = {
        Name = "terra-ngw02"
    }
}

resource "aws_eip" "bastion-EIP"{
    instance = aws_instance.terra-bastion-ubuntu.id
    vpc = true
    tags = {
        Name = "bastion-EIP"
    }
}
