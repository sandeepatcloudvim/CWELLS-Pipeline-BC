pageextension 50001 ExtedItemCard extends "Item Card"
{
    layout
    {
        modify("Standard Cost")
        {
            ApplicationArea = All;
            Enabled = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}