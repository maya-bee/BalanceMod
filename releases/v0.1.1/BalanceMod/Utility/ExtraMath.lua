local a={}a.TileLength=40;function a:TilesToUnits(b)return b*a.TileLength end;function a:UnitsToTiles(c)return c/a.TileLength end;function a:Clamp(d,e,f)if d<e then return e elseif d>f then return f end;return d end;function a:Round(g)local h=2^52;if math.abs(g)>h then return g end;return g<0 and g-h+h or g+h-h end;return a