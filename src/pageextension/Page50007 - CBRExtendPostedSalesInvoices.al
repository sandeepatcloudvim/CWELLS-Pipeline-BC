pageextension 50007 ExtendPostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Customer)
        {
            action("Sales Invoice Detail Page")
            {
                Caption = 'Sales Invoice Detail Page';
                ApplicationArea = All;
                Image = SalesInvoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "CBR Sales Invoice Detail Page";
            }

            action("Daily Sales Summary")
            {
                Caption = 'Daily Sales Summary';
                ApplicationArea = All;
                Image = SalesInvoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = report "CBR Daily Sales Summary";
            }
        }
    }

    var
        myInt: Integer;
}