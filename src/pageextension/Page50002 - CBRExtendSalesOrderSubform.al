pageextension 50002 ExtendSalesOrderSubform extends "Sales Order Subform"
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

        modify("Unit Price")
        {
            ApplicationArea = All;
            trigger OnAfterValidate()
            var
            begin
                if Rec.Type = Rec.Type::Item then
                    if Rec."Unit Price" < StandardCost then
                        Message('You have entered a selling price below the replacement cost. Please confirm the selling price.');
            end;
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