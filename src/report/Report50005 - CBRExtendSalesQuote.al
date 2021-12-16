reportextension 50005 CBRExtendStandardSalesQuote extends "Standard Sales - Quote"
{
    dataset
    {
        add(Header)
        {
            column(Sell_to_Contact; "Sell-to Contact")
            {

            }
            column(ContactName; ContactName)
            {

            }
        }
    }

    requestpage
    {
        // Add changes to the requestpage here
    }
    var

        ContactName: Label 'Contact Name';
}