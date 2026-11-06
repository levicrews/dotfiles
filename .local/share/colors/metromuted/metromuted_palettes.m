function palettes = metromuted_palettes()
%METROMUTED_PALETTES Metromuted colour system; rows are RGB values in [0, 1].
palettes.name = 'Metromuted';
palettes.background = [250 250 250] / 255;
palettes.white = [255 255 255] / 255;
palettes.off_white = [248 248 245] / 255;
palettes.light_gray = [228 231 232] / 255;
palettes.mid_gray = [115 123 126] / 255;
palettes.dark_gray = [38 50 56] / 255;
palettes.categorical = hex2rgb({'B71E2E','E68B28','E9A508','4B8EC2','14364C','227763'});
palettes.sequential = hex2rgb({'E9A508','56A841','15866F','2C6671','3F4274','5B176C'});
palettes.diverging = hex2rgb({'C7352C','EA8F2F','FCD35E','A4D6E9','278EE8','2A36A0'});
end

function rgb = hex2rgb(colors)
rgb = zeros(numel(colors), 3);
for i = 1:numel(colors)
    rgb(i,:) = sscanf(colors{i}, '%2x%2x%2x', [1 3])' / 255;
end
end
