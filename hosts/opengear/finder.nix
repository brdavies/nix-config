{ config, lib, pkgs, ... }:

{
  targets.darwin.defaults."com.apple.finder" = {

    FXPreferredViewStyle = "Nlsv";

    # # 0 = None
    # # 1 = Gray
    # # 2 = Green
    # # 3 = Purple
    # # 4 = Blue
    # # 5 = Yellow
    # # 6 = Red
    # # 7 = Orange

    # "com.apple.finder" = {



    #   TagNames = [
    #     "Inbox"
    #     "Work"
    #     "Personal"
    #     "Archive"
    #   ];

    #   TagColors = [
    #     6  # Inbox -> Red
    #     4  # Work -> Blue
    #     2  # Personal -> Green
    #     1  # Archive -> Gray
    #   ];

    #   # This defines what Finder *shows* in the Favorites section (and the order)
    #   FavoriteTagNames = [
    #     "Inbox"
    #     "Work"
    #     "Personal"
    #     "Archive"
    #   ];
    # };
  };
}
