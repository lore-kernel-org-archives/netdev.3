Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553B143F0AF;
	Mon, 31 Aug 2026 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184752; cv=none; b=GbymQrLIqFuZXJw98rHTCFAylv+ConcD2MYd/pELYPvy1K/M/MzzdUSz64KWHSwIOr0N0dykEs0LBCcX6tgOoZ0h4/KhlPQG77B+WdEAIsG6YYT4lXDuhdyNk2mdt1gG+YKk5TPVBBbB2UXWjO6vIlPjzQ8JumOMINDmDtGraUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184752; c=relaxed/simple;
	bh=qaQh23dqmsSX3FZ2dUrM7Ssv89P0qxYqkeTIbGm/qt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvWsheS+OFxcOYi1ttWF3iPL/0s4rtjLkaMjUNWTCoB/1PolL1TIO91H0WdfD6LG9jwvnH/cvhx4tFzON1Ih4/JCDegyld8nSknLbVOhdk1sM1WggzfE3UyEURzoSn+BM+wh0XsqPSlja3h1YvyMziabTPdvCjAulkuji2DA4Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A75M4ymw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A75M4ymw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A3F1F00A3D;
	Mon, 31 Aug 2026 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788184750;
	bh=ZKnDlB1HUQJqQiZvJyHW1hGyr+sVXeRGpXQLw8ojNlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A75M4ymwDcH8rADmdD3c6D192xZlke7Up0Oi1+b9NVl+YLy+ptdwrOiuqb0mpXDwp
	 /0JOYR2zRMUCb5K9fmzqodpCdGuiPTPymCSMcyR57oDxfLbtaU3gEh+QTqbXydYDiD
	 XUWKjaJhWrKXbDIBkzQQ3L0O51t3AEhI8vfUrWbdnAmblgDS4etWBE7A7wjHgU4p/P
	 KSxDYd3nUvnJfP7clxv9WZGhyG2DmLhg2bbcMrfNmujYLnSOHUU/5VZk9Q+Q22RSD9
	 PaJm0qGXUFX+7PNlcmFCVBeNoXyKhFLZSD3y/wZdqxu4Fs3h5YpsfxoQJjurkDdivu
	 R4+s9xnlnZwVw==
Date: Mon, 31 Aug 2026 15:58:53 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Peter Hunt <peter.hunt@opengear.com>
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com, 
	johannes@sipsolutions.net, netdev@vger.kernel.org, mhi@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] bus: mhi: host: pci_generic: enumerate
 IP_CTRL channel for Sierra EM919x/EM929x
Message-ID: <mpuhiovkvqajyt243lig5xemdbcnolhnorgkpqh3fwynue5gz3@bni7wgoemn6g>
References: <20260816121705.858013-1-peter.hunt@opengear.com>
 <20260816121705.858013-3-peter.hunt@opengear.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260816121705.858013-3-peter.hunt@opengear.com>

On Sun, Aug 16, 2026 at 06:17:04AM -0600, Peter Hunt wrote:
> IP_CTRL is a standard Qualcomm MHI control channel (channels 18/19) that
> carries the host serial control lines (DTR/RTS) to the modem; it is not
> Sierra-specific. It was not enumerated for any device in pci_generic, so
> the host had no way to drive those signals.
> 
> Enumerate it in the Sierra em919x channel config (shared by the EM919x
> and EM929x) using the control event ring. This is the device the change
> was tested against; other Qualcomm modem configs that expose IP_CTRL can
> enable it the same way, since the mhi_wwan_ctrl DTR support that consumes
> it, added by the following patch in this series, is device-agnostic and
> binds purely by channel name.
> 
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Peter Hunt <peter.hunt@opengear.com>

Applied to mhi-next!

- Mani
-- 
மணிவண்ணன் சதாசிவம்
