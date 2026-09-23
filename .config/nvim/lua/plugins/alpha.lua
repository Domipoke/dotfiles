
return {
    "goolord/alpha-nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.startify")
  
      dashboard.section.header.val = {
        [[             ....                                             .                                    ..           ]],      
        [[   .xH888888Hx.                                        @88>                            < .z@8"`                 ]],
        [[ .H8888888888888:           u.      ..    .     :      %8P    .d``                u.    !@88E                   ]],
        [[ 888*"""?""*88888X    ...ue888b   .888: x888  x888.     .     @8Ne.   .u    ...ue888b   '888E   u         .u    ]],
        [['f     d8x.   ^%88k   888R Y888r ~`8888~'888X`?888f`  .@88u   %8888:u@88N   888R Y888r   888E u@8NL    ud8888.  ]],
        [['>    <88888X   '?8   888R I888>   X888  888X '888>  ''888E`   `888I  888.  888R I888>   888E`"88*"  :888'8888. ]],
        [[ `:..:`888888>    8>  888R I888>   X888  888X '888>    888E     888I  888I  888R I888>   888E .dN.   d888 '88%" ]],
        [[        `"*88     X   888R I888>   X888  888X '888>    888E     888I  888I  888R I888>   888E~8888   8888.+"    ]],
        [[   .xHHhx.."      !  u8888cJ888    X888  888X '888>    888E   uW888L  888' u8888cJ888    888E '888&  8888L      ]],
        [[  X88888888hx. ..!    "*888*P"    "*88%""*88" '888!`   888&  '*88888Nu88P   "*888*P"     888E  9888. '8888c. .+ ]],
        [[ !   "*888888888"       'Y"         `~    "    `"`     R888" ~ '88888F`       'Y"      '"888*" 4888"  "88888%   ]],
        [[        ^"***"`                                         ""      888 ^                     ""    ""      "YP'    ]],
        [[                                                                *8E                                             ]],
        [[                                                                '8>                                             ]],
        [[                                                                 "                                              ]]
      }
  
      alpha.setup(dashboard.opts)
    end,
  }
  
