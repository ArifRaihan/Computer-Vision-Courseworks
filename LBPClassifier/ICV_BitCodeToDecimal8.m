function decim = ICV_BitCodeToDecimal8(bits)
    sum = 0;
    power = 7;
    for i = 1:8
        sum = sum + bits(i)*2^(power);
        power = power-1;
    end
    decim = sum;
end