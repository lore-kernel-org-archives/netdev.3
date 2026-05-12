Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938044418F0
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573695; cv=none; b=CxEn+M//rWNIfZgjy7F76skzK9yb3ttU/CvvufGbgBo4Xc5bHa71LRucL3/akO0RM9Hse1vmd5IypN/JWJqSmVIBfFj3XgLV9VTCIfrnz2N5GsZcQD4MWdrSfDA4E2VEubdEDFBWewCn9ICtgL8BfWpEWND5SM6SI5SqKRk2jnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573695; c=relaxed/simple;
	bh=0eir7FlsXReOo5Tnl+wZQO8WXKE1W8qeetRGqtFIL/g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=eFBKTn2BcMv9vB9sWiyi/JCnBuVpeuDuYg6H53B4D634NJBKvytK34XgWKKT1FTAhvm3AJXi1QOPpgbA1jK4G3VtlB6X5a7hKARr8nHAbuCUDuyWr4rFD/czxjvuL7ZjmE3mwd9PtnqbL/70+NmkJLjkTSsbF4iiH7yVCv2lojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ELY+xwAS; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ELY+xwAS"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260512081451euoutp01df93a6fc42168ac6bea2dfeda2b001bb~uw1lx36Hx0319703197euoutp01-
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:14:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260512081451euoutp01df93a6fc42168ac6bea2dfeda2b001bb~uw1lx36Hx0319703197euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778573691;
	bh=VaBvKdS3J023SDjGn9jNjOJ0mnJO7J/mBbhmPoJ4tI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ELY+xwASgQwjHtyEv6XWKNRBBmrhOyzOpHCjckIu/WxEPRud7eCK6mwXsAE7jqs4G
	 8EndhGBDPE3OiBCT2+6aYf7e6YlzZBzrVWiT+pEl1k086j9KrC63QeAxvuI45q3W1l
	 H3OAYt0+/dUnsAiSwX8ypPV72HlaFG3B4QvorEU4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260512081451eucas1p15eb6c85b5e97e07a3a79e2719aba89c8~uw1lg5iTC2392923929eucas1p1I;
	Tue, 12 May 2026 08:14:51 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260512081450eusmtip23dba322521148fe5f23e89b7154c4ab3~uw1k9UpQI2317823178eusmtip2g;
	Tue, 12 May 2026 08:14:50 +0000 (GMT)
Date: Tue, 12 May 2026 10:14:47 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, k.domagalski@samsung.com,
	k.tegowski@samsung.com
Subject: Re: [PATCH net-next 2/3] net/stmmac/dwxgmac: Extend MTL/DMA support
 to 16 queues
Message-ID: <agLhd/gs6W1wDl7z@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <93db358a-4ff2-4cc7-ac89-a0f13ae05597@lunn.ch>
X-CMS-MailID: 20260512081451eucas1p15eb6c85b5e97e07a3a79e2719aba89c8
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="-----ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_1ee64_"
X-RootMTR: 20260511165431eucas1p28254403c5d4117b900dca4ca613bb532
X-EPHeader: CA
X-CMS-RootMailID: 20260511165431eucas1p28254403c5d4117b900dca4ca613bb532
References: <20260511165416.3093015-1-j.raczynski@samsung.com>
	<CGME20260511165431eucas1p28254403c5d4117b900dca4ca613bb532@eucas1p2.samsung.com>
	<20260511165416.3093015-3-j.raczynski@samsung.com>
	<93db358a-4ff2-4cc7-ac89-a0f13ae05597@lunn.ch>

-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_1ee64_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, May 11, 2026 at 08:05:32PM +0200, Andrew Lunn wrote:
> 
> I think
> 
> 	switch (queue):
> 	case 0 ... 3:
> 	     reg = XGMAC_MTL_RXQ_DMA_MAP0;
> 
> is more readable, and expresses in code what you had in the comment.
> 
>    Andrew
>
Sure, can apply this in v2, thanks.

-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_1ee64_
Content-Type: text/plain; charset="utf-8"


-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_1ee64_--
