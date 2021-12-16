tableextension 50000 ExtendItem extends Item
{
    fields
    {
        field(50000; "Qty. Avail"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. Avail';
            DecimalPlaces = 0 : 5;
        }
    }
    fieldgroups
    {

    }

    var
        myInt: Integer;




}