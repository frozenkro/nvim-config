return function(nonNix, nix)
  if vim.g.nix == true then
    print('nix mode')
    return nix
  else
    return nonNix
  end
end
