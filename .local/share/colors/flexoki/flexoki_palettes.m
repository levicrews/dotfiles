function palettes = flexoki_palettes()
%FLEXOKI_PALETTES Flexoki colour system; rows are RGB values in [0, 1].
palettes.name = 'Flexoki';
palettes.background = [255 252 240] / 255;
palettes.ink = [40 39 38] / 255;
palettes.categorical = hex2rgb({'AF3029','BC5215','AD8301','66800B','24837B','205EA6','5E409D','A02F6F'});
palettes.sequential = hex2rgb({'F6E2A0','B6BA62','7F993D','408B65','22758B','1E5697','163B66'});
palettes.diverging = hex2rgb({'942822','C03E35','DA702C','F9AE77','E6E4D9','92BFDB','4385BE','3171B2','163B66'});
end

function rgb = hex2rgb(colors)
rgb = zeros(numel(colors), 3);
for i = 1:numel(colors)
    rgb(i,:) = sscanf(colors{i}, '%2x%2x%2x', [1 3])' / 255;
end
end
