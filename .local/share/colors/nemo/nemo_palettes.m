function palettes = nemo_palettes()
%NEMO_PALETTES Nemo colour system; rows are RGB values in [0, 1].
palettes.name = 'Nemo';
palettes.background = [251 250 247] / 255;
palettes.categorical = hex2rgb({'6182B5','AF3127','90A954','D99C37','112A3C','3E7C73','756889','C5B868'});
palettes.sequential = hex2rgb({'FAC764','9EAD56','619165','3E757A','335677','1F3E56','112A3C'});
palettes.diverging = hex2rgb({'8D211D','AF3127','C86D3C','DAC0A6','F4F1EA','C4C2D1','91A4BE','6182B5','112A3C'});
end

function rgb = hex2rgb(colors)
rgb = zeros(numel(colors), 3);
for i = 1:numel(colors)
    rgb(i,:) = sscanf(colors{i}, '%2x%2x%2x', [1 3])' / 255;
end
end
