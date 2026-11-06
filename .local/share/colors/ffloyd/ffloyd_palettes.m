function palettes = ffloyd_palettes()
%FFLOYD_PALETTES Warm Cream colour system; rows are RGB values in [0, 1].
palettes.name = 'Warm Cream';
palettes.background = [237 232 217] / 255;
palettes.text = [37 96 111] / 255;
palettes.heading = [22 76 103] / 255;
palettes.categorical = hex2rgb({'CB8A28','008464','427EAF','C05B43','7864A0','B4567C','788238','164C67'});
palettes.sequential = hex2rgb({'EBD495','C2C16F','86B26E','3E9F77','1C847C','0F6779','164C67'});
palettes.diverging = hex2rgb({'6E3223','A94C2E','CD7F51','DDBC95','F4F0E4','A6CBC7','5EA2A8','21778D','164C67'});
end

function rgb = hex2rgb(colors)
rgb = zeros(numel(colors), 3);
for i = 1:numel(colors)
    rgb(i,:) = sscanf(colors{i}, '%2x%2x%2x', [1 3])' / 255;
end
end
