pageextension 50004 ExtendItemLedgerEntries extends "Item Ledger Entries"
{
    layout
    {
        addafter("Location Code")
        {
            field(CustomerNo; CustomerNo)
            {
                ApplicationArea = All;
                Caption = 'Customer No.';
            }
            field(CustomerName; CustomerName)
            {
                ApplicationArea = All;
                Caption = 'Customer Name';
            }
            field(SellingPrice; SellingPrice)
            {
                ApplicationArea = All;
                Caption = 'Selling Price';
            }
            field(ExtendedPrice; ExtendedPrice)
            {
                ApplicationArea = All;
                Caption = 'Extending Price';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        CustomerNo: code[20];
        CustomerName: text[150];
        SellingPrice: Decimal;
        ExtendedPrice: Decimal;

    trigger OnAfterGetRecord()
    var
        recItem: Record Item;
        recCustomer: Record Customer;
    begin
        Clear(CustomerNo);
        Clear(CustomerName);
        Clear(SellingPrice);
        Clear(ExtendedPrice);

        if Rec."Entry Type" = Rec."Entry Type"::Sale then begin
            if recItem.Get(Rec."Item No.") then begin
                SellingPrice := recItem."Unit Price";
                ExtendedPrice := ABS(Rec.Quantity * recItem."Unit Price");
            end;
            if recCustomer.Get(Rec."Source No.") then begin
                CustomerNo := recCustomer."No.";
                CustomerName := recCustomer.Name;
            end;

        end;

    end;
}