report 50003 "CBR Daily Sales Summary"
{
    DefaultLayout = RDLC;
    Caption = 'Daily Sales Summary';
    RDLCLayout = './DailySalesSummary.rdl';

    dataset
    {
        dataitem("Sales Invoice Line"; "Sales Invoice Line")
        {
            DataItemTableView = SORTING("Document No.", "Line No.") ORDER(Ascending);
            RequestFilterFields = "Posting Date";
            column(PostingDateCaption; PostingDateCaption)
            {
            }
            column(TotalSaleCaption; TotalSaleCaption)
            {
            }
            column(TotalCostCaption; TotalCostCaption)
            {
            }
            column(ProfitCaption; ProfitCaption)
            {
            }
            column(GrossMarCaption; GrossMarCaption)
            {
            }
            column(PaceCaption; PaceCaption)
            {
            }
            column(ProfitPaceCaption; ProfitPaceCaption)
            {
            }
            column(PostingDate_SalesInvLine; "Sales Invoice Line"."Posting Date")
            {
            }
            column(Quantity_SalesInvLine; "Sales Invoice Line".Quantity)
            {
            }
            column(LineAmount_SalesInvLine; "Sales Invoice Line"."Line Amount")
            {
            }
            column(TotalSales; TotalSales)
            {
            }
            column(TotalSalesAmount; TotalSalesAmount)
            {

            }
            column(TotalCost; TotalCost)
            {
            }
            column(TotalSalesCost; TotalSalesCost)
            {

            }
            column(PriorSales; PriorSales)
            {
            }
            column(PriorCost; PriorCost)
            {
            }
            column(TotalPace; TotalPace)
            {
            }
            column(TotalPaceProfit; TotalPaceProfit)
            {
            }
            column(TotalProfit; TotalProfit)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(TotalCost);
                Clear(TotalSales);
                Clear(PriorSales);
                Clear(PriorCost);
                Clear(TotalProfit);
                Clear(TotalSalesAmount);
                Clear(TotalSalesCost);

                if "Sales Invoice Line"."Posting Date" <> PrevPostingDate then begin

                    recSalesInvLine.Reset;
                    recSalesInvLine.SetFilter("Posting Date", '%1', CalcDate('-1D', "Sales Invoice Line"."Posting Date"));
                    if recSalesInvLine.FindFirst then begin
                        repeat
                            PriorSales := PriorSales + (recSalesInvLine.Quantity * recSalesInvLine."Unit Price");
                            //PriorCost := PriorCost + (recSalesInvLine.Quantity * recSalesInvLine."Unit Cost");
                            if recSalesInvLine.Quantity <> 0 then
                                PriorCost := PriorCost + (CostCalcMgt.CalcSalesInvLineCostLCY(recSalesInvLine) / recSalesInvLine.Quantity);
                        until recSalesInvLine.Next = 0;
                    end;

                    recSalesInvLine1.Reset;
                    recSalesInvLine1.SetRange("Posting Date", "Sales Invoice Line"."Posting Date");
                    if recSalesInvLine1.FindSet then begin
                        repeat
                            TotalSales := TotalSales + (recSalesInvLine1.Quantity * recSalesInvLine1."Unit Price");
                            //TotalCost := TotalCost + (recSalesInvLine1.Quantity * recSalesInvLine1."Unit Cost");
                            if recSalesInvLine1.Quantity <> 0 then
                                TotalCost := TotalCost + (CostCalcMgt.CalcSalesInvLineCostLCY(recSalesInvLine1) / recSalesInvLine1.Quantity);
                            TotalProfit := (TotalSales - TotalCost);
                        until recSalesInvLine1.Next = 0;

                        PrevPostingDate := "Sales Invoice Line"."Posting Date";
                        Clear(TotalPace);
                        Clear(TotalPaceProfit);
                        TotalPace := (TotalSales - TotalCost) - (PriorSales - PriorCost);

                    end;
                    if "Sales Invoice Line"."Posting Date" <> 0D then begin
                        recSalesInvLine2.Reset;
                        recSalesInvLine2.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
                        if recSalesInvLine2.FindSet then begin
                            repeat
                                TotalSalesAmount := TotalSalesAmount + (recSalesInvLine2.Quantity * recSalesInvLine2."Unit Price");
                                //TotalSalesCost := TotalSalesCost + (recSalesInvLine2.Quantity * recSalesInvLine2."Unit Cost");
                                if recSalesInvLine2.Quantity <> 0 then
                                    TotalSalesCost := TotalSalesCost + (CostCalcMgt.CalcSalesInvLineCostLCY(recSalesInvLine2) / recSalesInvLine2.Quantity);
                            until recSalesInvLine2.Next = 0;

                        end;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                PrevPostingDate := 0D;
                StartDate := GetRangeMin("Sales Invoice Line"."Posting Date");
                EndDate := GetRangeMax("Sales Invoice Line"."Posting Date");

            end;

        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        TXT_SHEET: Label 'Daily Sales Summary';
        PostingDateCaption: Label 'Posting Date';
        TotalSaleCaption: Label 'Total Sales';
        TotalCostCaption: Label 'Total Cost';
        ProfitCaption: Label 'Profit';
        GrossMarCaption: Label 'Gross Margin %';
        PaceCaption: Label 'Pace';
        ProfitPaceCaption: Label 'Profit Pace';
        PrintToExcel: Boolean;
        recSalesInvLine: Record "Sales Invoice Line";
        recSalesInvLine2: Record "Sales Invoice Line";
        recItem: Record Item;
        TotalSales: Decimal;
        TotalSalesAmount: Decimal;
        TotalSalesCost: Decimal;
        TotalCost: Decimal;
        StartDate: Date;
        EndDate: Date;
        TotalPace: Decimal;
        MinDate: Date;
        MaxDate: Date;
        PriorSales: Decimal;
        PriorCost: Decimal;
        recSalesInvLine1: Record "Sales Invoice Line";
        TotalSalesPrice: Decimal;
        TotalCostPrice: Decimal;
        PriorDateFound: Boolean;
        PrevPostingDate: Date;
        TotalPaceProfit: Decimal;
        TotalProfit: Decimal;
        CostCalcMgt: Codeunit "Cost Calculation Management";
}

