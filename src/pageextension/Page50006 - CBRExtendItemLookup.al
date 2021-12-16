pageextension 50006 ExtendItemLookup extends "Item Lookup"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("Qty. Avail"; AvailableQty)
            {
                ApplicationArea = All;
                Caption = 'Qty. Avail';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        AvailableQty: Decimal;

    trigger OnAfterGetRecord()
    var
    begin
        Clear(AvailableQty);
        Rec.CalcFields("Qty. on Sales Order", Inventory);
        AvailableQty := Rec.Inventory - Rec."Qty. on Sales Order";
    end;
}