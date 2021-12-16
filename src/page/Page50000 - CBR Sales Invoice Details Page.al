page 50000 "CBR Sales Invoice Detail Page"
{
    Editable = false;
    Caption = 'Sales Invoice Details';
    PageType = List;
    SourceTable = "CBR Sales Invoice Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Invoive No."; Rec."Invoive No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Customer ID"; Rec."Customer ID")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Salesperson Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("Qty Invoiced"; Rec."Qty Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Extended Price"; Rec."Extended Price")
                {
                    ApplicationArea = All;
                }
                // field("Unit Cost"; Rec."Unit Cost")
                // {
                //     ApplicationArea = All;
                // }
                field("Adjusted Cost"; Rec."Adjusted Cost")
                {
                    ApplicationArea = All;
                }
                field("Extended Cost"; Rec."Extended Cost")
                {
                    ApplicationArea = All;
                }

                field("Profit Amount"; Rec."Profit Amount")
                {
                    ApplicationArea = All;
                }
                field("Profit Percentage"; Rec."Profit Percentage")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        Rec.FillTempTable;
    end;
}

