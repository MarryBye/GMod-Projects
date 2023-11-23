clrs = {}

clrs['TRANSPARENT'] = Color(0, 0, 0, 0)
clrs['BLACK'] = Color(0, 0, 0, 255)
clrs['WHITE'] = Color(225, 225, 225, 255)
clrs['RED'] = Color(225, 55, 0, 255)
clrs['GREEN'] = Color(0, 128, 0, 255)
clrs['BLUE'] = Color(0, 55, 225, 255)
clrs['GRAY'] = Color(55, 55, 55, 255)
clrs['CYAN'] = Color(0, 255, 255, 255)
clrs['TEAL'] = Color(0, 128, 128, 255)
clrs['VIOLET'] = Color(238, 130, 238, 255)
clrs['PURPLE'] = Color(128, 0, 128, 255)
clrs['SLATEBLUE'] = Color(106, 90, 205, 255)
clrs['YELLOW'] = Color(255, 255, 0, 255)
clrs['ORANGE'] = Color(255, 155, 175, 255)
clrs['LIME'] = Color(0, 255, 0, 255)
clrs['NAVY'] = Color(0, 0, 128, 255)

local colorMeta = FindMetaTable('Color')

function colorMeta:colorAlphaChange(a)

    return Color(self.r, self.g, self.b, a)

end

function colorMeta:colorInversion()

    return Color(255 - self.r, 255 - self.g, 255 - self.b, self.a)

end