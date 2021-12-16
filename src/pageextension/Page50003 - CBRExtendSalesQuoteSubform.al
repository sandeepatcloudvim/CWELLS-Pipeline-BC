pageextension 50003 ExtendSalesQuoteSubform extends "Sales Quote Subform"
{
    layout
    {
        addafter("Unit of Measure Code")
        {
            field(StandardCost; StandardCost)
            {
                ApplicationArea = All;
                Caption = 'Standard Cost';
                Editable = false;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        recItem: Record Item;
        StandardCost: Decimal;

    trigger OnAfterGetRecord()
    var
    begin
        if recItem.Get(rec."No.") then
            StandardCost := recItem."Standard Cost";

    end;

}