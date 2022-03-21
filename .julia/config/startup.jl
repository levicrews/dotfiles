try
    using OhMyREPL
    colorscheme!("Base16MaterialDarker")
catch err
    @warn "Could not load startup packages"
end
