pageextension 50008 CBRExtendSalesQuote extends "Sales Quote"
{
    layout
    {
        moveafter(General; "Shipping and Billing")

        modify("Salesperson Code")
        {
            ShowMandatory = true;
            ApplicationArea = All;
        }
        modify("Ship-to Code")
        {
            ShowMandatory = true;
            ApplicationArea = All;
        }

    }

    actions
    {
        modify(Release)
        {
            ApplicationArea = All;
            trigger OnBeforeAction()
            begin
                Rec.TestField(Rec."Salesperson Code");
                Rec.TestField(Rec."Ship-to Code");
            end;
        }
        modify(MakeOrder)
        {
            ApplicationArea = All;
            trigger OnBeforeAction()
            begin
                Rec.TestField(Rec."Salesperson Code");
                Rec.TestField(Rec."Ship-to Code");
            end;
        }
        modify(MakeInvoice)
        {
            ApplicationArea = All;
            trigger OnBeforeAction()
            begin
                Rec.TestField(Rec."Salesperson Code");
                Rec.TestField(Rec."Ship-to Code");
            end;
        }

    }

    var
        myInt: Integer;
}