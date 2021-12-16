codeunit 50000 EventSubscriber
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeManualReleaseSalesDoc', '', false, false)]
    local procedure ManualReleaseSalesDoc(VAR SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            SalesHeader.TestField("Payment Terms Code");
            SalesHeader.TestField("Shipment Method Code");
            SalesHeader.TestField("Salesperson Code");
            SalesHeader.TestField("Tax Area Code");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure ReleaseSalesDoc(VAR SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            SalesHeader.TestField("Payment Terms Code");
            SalesHeader.TestField("Shipment Method Code");
            SalesHeader.TestField("Salesperson Code");
            SalesHeader.TestField("Tax Area Code");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Return Authorization" then
            NewReportId := Report::"CBR Return Authorization";
    end;
}