Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12103FBA7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867350; cv=none; b=gl/X/qHtG6FMzVuzaUB5C0OZxNRnJpA+HwWdoo/pVmZWdB7TguuXaCZ4QSfnmlfuCjOqe01fMqTqmytSeih/ecdJ8VNuJDviWXWbtrK0muGJ49iWx17k87hkCE0DxMpWHqVplsh9BjM6i1EmK2QvWybV0DVezzbAIbdjcVS8eXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867350; c=relaxed/simple;
	bh=BdKKhsnJvWWH0+JuV5Q03Ag5Jz82pO9hLgWrPM42paQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=UYMr47Li3LPh1hLhnM69mEQNfMnEhXkOQ9QovGDs8YcrzcCESC7Mz/9lptr+g5tGeClfUHT61nmKg91pxnVWN6WXlXwepJm2ldfkGwe0S/OeokhGWEODCQ0EhnlNDMOXC0GPN/qTKCA5P192X6gkrrjuO34k/5O2I885H+ePXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mKyXyrF+; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mKyXyrF+"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260422141541euoutp019f20df1a4e6c9e09461b1b9dce344963~os2659odm1806718067euoutp01J
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 14:15:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260422141541euoutp019f20df1a4e6c9e09461b1b9dce344963~os2659odm1806718067euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776867341;
	bh=5TRuoEZ4QJYPP3Pw1mvOMEiOGYnpwQfSAA/hUqjUCNs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mKyXyrF+n82XA33u0SGIGDQNCQ7dH4KodlRrt6FXUzWSF6QPl8bvHAsUact8qmSnZ
	 wxrjTmsd8LIJIYuvXAkJHtDuCedpM9ZitVWIQXmJlhfF1w8XLIDD8hDZOLjJw0dXt0
	 CwovohvKHA/dR35P7HtELGDB93JflxGk6YroA+xg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260422141540eucas1p1f97c4c7a893f2fe7e8e847952e3b6f09~os26mX52C1742517425eucas1p1K;
	Wed, 22 Apr 2026 14:15:40 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260422141540eusmtip28d405d9149856677d74e51eae49a63a2~os26KFPAN1791517915eusmtip29;
	Wed, 22 Apr 2026 14:15:40 +0000 (GMT)
Date: Wed, 22 Apr 2026 16:15:37 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, andrew+netdev@lunn.ch, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] net/stmmac: Fix typos: 'tx_undeflow_irq' ->
 'tx_underflow_irq'
Message-ID: <aejYCYObZyFPpLat@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f1d51362-ca8f-481a-b9c1-400ab6422686@lunn.ch>
X-CMS-MailID: 20260422141540eucas1p1f97c4c7a893f2fe7e8e847952e3b6f09
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----hExaTKD8pSV4C1.mHO0xNjZioIzStKhMnOXfyxqZoi0.l2l2=_277a9_"
X-RootMTR: 20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6
X-EPHeader: CA
X-CMS-RootMailID: 20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6
References: <CGME20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6@eucas1p1.samsung.com>
	<20260421115008.2690541-1-j.raczynski@samsung.com>
	<7eb9e4d4-909c-4203-833d-bd8b664fdfbc@lunn.ch>
	<aeiJ3zr4WJAm1UCk@AMDC4622.eu.corp.samsungelectronics.net>
	<f1d51362-ca8f-481a-b9c1-400ab6422686@lunn.ch>

------hExaTKD8pSV4C1.mHO0xNjZioIzStKhMnOXfyxqZoi0.l2l2=_277a9_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Apr 22, 2026 at 02:47:38PM +0200, Andrew Lunn wrote:
> > I don't see anything wrong with it?
> > - naming is correct, same as stmmac_extra_stats from common.h, as it
> >   wouldn't compile otherwise
> > - string length is ok, as max name length is ETH_GSTRING_LEN=32 and it is
> >   not close
> > - ethtool just polls data from driver and in my tests it is ok
> > - all instances of 'undeflow' are changed
> > - 'underflow' semantic is ok, 'undeflow' is just not correct
> > 
> > Please correct me if I am wrong, but imo no issues with this patch.
> 
> ABI
> 
> This name is published as part of the kAPI. You are changing its
> name. User space could be looking for this name, even thought it has a
> typo in it.
> 
>      Andrew
>
I don't think it is? This part of extra stats (struct stmmac_extra_stats) and
is not part of standard ABI from
Documentation/ABI/testing/sysfs-class-net-statistics
nor is mentioned in
Documentation/networking/device_drivers/ethernet/stmicro/stmmac.rst

These extra stats are specific to stmmac driver and most of these are more
than standard
https://www.kernel.org/doc/html/v7.0/networking/statistics.html#c.rtnl_link_stats64
This name does not exist outside stmmac driver, so while some application may
expect this (stmmac specific app), question is should this typo stick?

This type of typo is even mentioned in scripts/spelling.txt.

Regards
Jakub Raczynski

------hExaTKD8pSV4C1.mHO0xNjZioIzStKhMnOXfyxqZoi0.l2l2=_277a9_
Content-Type: text/plain; charset="utf-8"


------hExaTKD8pSV4C1.mHO0xNjZioIzStKhMnOXfyxqZoi0.l2l2=_277a9_--
