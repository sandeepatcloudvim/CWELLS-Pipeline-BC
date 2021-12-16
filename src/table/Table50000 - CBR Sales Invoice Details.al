table 50000 "CBR Sales Invoice Details"
{
    Caption = 'Sales Invoice Details';

    fields
    {
        field(1; "Invoive No."; Code[20])
        {
            Caption = 'Invoive No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(4; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
            DataClassification = ToBeClassified;
        }
        field(5; "Customer ID"; Code[20])
        {
            Caption = 'Customer ID';
            DataClassification = ToBeClassified;
        }
        field(6; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(7; "External Document No."; Code[35])
        {
            Caption = 'External Document No.';
            DataClassification = ToBeClassified;
        }
        field(8; "Salesperson Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Item Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Qty Invoiced"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(12; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Extended Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Extended Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Profit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Profit Percentage"; Decimal)
        {
            Caption = 'Profit %';
            DataClassification = ToBeClassified;
        }
        field(18; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            DataClassification = ToBeClassified;
        }
        field(19; "Adjusted Cost"; Decimal)
        {
            Caption = 'Adjusted Cost ($)';
            DataClassification = ToBeClassified;
        }
        field(20; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Invoive No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        ShowDialog: Dialog;
        AdjustCost: Decimal;
        AmountLCY: Decimal;

    procedure FillTempTable()
    var
        recSalesInvHeader: Record "Sales Invoice Header";
        recSalesInvDetail: Record "CBR Sales Invoice Details";
        SalesInvDetail: Record "CBR Sales Invoice Details";
        SalesInvoiceDetail: Query "CBR Sales Invoice Details";
    begin
        DeleteAll;
        ShowDialog.Open('Processing data ..');
        SalesInvoiceDetail.Open;
        while SalesInvoiceDetail.Read do begin
            if SalesInvoiceDetail.No <> '' then begin
                recSalesInvDetail.Init;
                recSalesInvDetail."Invoive No." := SalesInvoiceDetail.Document_No;
                recSalesInvDetail."Line No." := SalesInvoiceDetail.Line_No;
                recSalesInvDetail."Posting Date" := SalesInvoiceDetail.Posting_Date;
                recSalesInvDetail."Sales Order No." := SalesInvoiceDetail.Order_No;
                recSalesInvDetail."Customer ID" := SalesInvoiceDetail.Sell_to_Customer_No;
                recSalesInvDetail."Item No." := SalesInvoiceDetail.No;
                recSalesInvDetail."Item Description" := SalesInvoiceDetail.Description;
                recSalesInvDetail."Variant Code" := SalesInvoiceDetail.Variant_Code;
                recSalesInvDetail."Qty Invoiced" := SalesInvoiceDetail.Quantity;
                recSalesInvDetail."Unit Cost" := SalesInvoiceDetail.Unit_Cost;
                recSalesInvDetail."Unit Price" := SalesInvoiceDetail.Unit_Price;
                recSalesInvDetail."Line Amount" := GetSalesAmount(SalesInvoiceDetail.Document_No, SalesInvoiceDetail.Amount);
                recSalesInvDetail."Extended Price" := (SalesInvoiceDetail.Quantity * SalesInvoiceDetail.Unit_Price);
                recSalesInvDetail."Extended Cost" := GetAdjustedCost(SalesInvoiceDetail.Document_No, SalesInvoiceDetail.Line_No);
                if SalesInvoiceDetail.Quantity <> 0 then
                    recSalesInvDetail."Adjusted Cost" := GetAdjustedCost(SalesInvoiceDetail.Document_No, SalesInvoiceDetail.Line_No) / SalesInvoiceDetail.Quantity;


                if recSalesInvHeader.Get(SalesInvoiceDetail.Document_No) then begin
                    recSalesInvDetail."Customer Name" := recSalesInvHeader."Sell-to Customer Name";
                    recSalesInvDetail."Salesperson Code" := recSalesInvHeader."Salesperson Code";
                    recSalesInvDetail."External Document No." := recSalesInvHeader."External Document No.";
                end;
                if recSalesInvDetail.Insert then;

                if SalesInvDetail.Get(recSalesInvDetail."Invoive No.", recSalesInvDetail."Line No.") then begin
                    SalesInvDetail."Profit Amount" := (SalesInvDetail."Line Amount" - SalesInvDetail."Extended Cost");
                    if SalesInvDetail."Line Amount" <> 0 then
                        SalesInvDetail."Profit Percentage" := ROUND(100 * (SalesInvDetail."Line Amount" - SalesInvDetail."Extended Cost") / SalesInvDetail."Line Amount", 0.1);
                    SalesInvDetail.Modify(false);
                end;

            end;
        end;
        ShowDialog.Close;
    end;

    procedure GetAdjustedCost(InvoiceDocNo: Code[20]; InvoiceLineNo: Integer): Decimal
    var
        recSalesInvoiceLine: Record "Sales Invoice Line";
        CostCalcMgt: Codeunit "Cost Calculation Management";
    begin
        if recSalesInvoiceLine.get(InvoiceDocNo, InvoiceLineNo) then begin
            AdjustCost := CostCalcMgt.CalcSalesInvLineCostLCY(recSalesInvoiceLine);
            exit(AdjustCost);
        end;
    end;

    procedure GetSalesAmount(InvDocNo: Code[20]; LineAmount: Decimal): Decimal
    var
        recSalesInvHeader: Record "Sales Invoice Header";
        CurrExchRate: Record "Currency Exchange Rate";
    begin
        if recSalesInvHeader.get(InvDocNo) then begin
            IF recSalesInvHeader."Currency Code" = '' THEN
                AmountLCY := LineAmount
            ELSE
                AmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(WORKDATE, recSalesInvHeader."Currency Code", LineAmount, recSalesInvHeader."Currency Factor");
            exit(AmountLCY);
        end;
    end;
}

