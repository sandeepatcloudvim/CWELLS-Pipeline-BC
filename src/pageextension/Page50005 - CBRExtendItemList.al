pageextension 50005 ExtendItemList extends "Item List"
{

    layout
    {
        addafter(InventoryField)
        {
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = All;
            }
            field(TotalValue; TotalValue)
            {
                ApplicationArea = All;
                Caption = 'Total Value';
            }
            field("Qty. Avail"; AvailableQty)
            {
                ApplicationArea = All;
                Caption = 'Qty. Avail';
            }
        }
    }

    actions
    {
        addafter("BOM Level")
        {
            action("Inventory Stock Status")
            {
                Caption = 'Inventory Stock Status';
                ApplicationArea = All;
                Image = Inventory;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = report "Inventory Stock Status";
            }
        }
    }

    var
        myInt: Integer;
        AvailableQty: Decimal;
        TotalValue: Decimal;

    trigger OnAfterGetRecord()
    var
    begin
        Clear(AvailableQty);
        Rec.CalcFields("Qty. on Sales Order", Inventory);
        AvailableQty := Rec.Inventory - Rec."Qty. on Sales Order";
        TotalValue := (Rec."Unit Cost" * Rec.Inventory);
    end;
}