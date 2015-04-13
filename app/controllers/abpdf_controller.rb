class AbpdfController < ApplicationController

  def summary
    report = PDFSummary.create Summary.all
    send_data report.generate,
      :type        => "application/pdf",
      :filename    => "summary.pdf",
      :disposition => "inline"
  end

  def balance
    report = PDFBalance.create Balance.all
    send_data report.generate,
      :type        => "application/pdf",
      :filename    => "balance.pdf",
      :disposition => "inline"
  end

end
