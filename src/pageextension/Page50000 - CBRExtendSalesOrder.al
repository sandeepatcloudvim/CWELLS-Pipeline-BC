pageextension 50000 CBRExtendSalesOrder extends "Sales Order"
{
    layout
    {
        modify("Payment Terms Code")
        {
            ApplicationArea = All;
            ShowMandatory = true;
        }

        modify("Shipment Method Code")
        {
            ApplicationArea = All;
            ShowMandatory = true;
        }
        modify("Salesperson Code")
        {
            ApplicationArea = All;
            ShowMandatory = true;
        }
        modify("Tax Area Code")
        {
            ApplicationArea = All;
            ShowMandatory = true;
        }


        moveafter(General; "Shipping and Billing")
    }

    actions
    {
        addafter("Pick Instruction")
        {
            action("CBR Packing Slip")
            {
                ApplicationArea = All;
                Caption = 'Packing Slip';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category11;
                ToolTip = 'Print a Packing Slip.';
                trigger OnAction()
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    REPORT.RUN(50000, TRUE, FALSE, Rec);
                    rec.RESET;
                end;
            }
        }
    }

    var
        myInt: Integer;
}