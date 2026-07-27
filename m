Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3803921C3
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166195; cv=none; b=hKJid30GaGxCOT5zrwgRAXx2orXCequWWUZU55rCF20hKyb7h6g6NlUsDS+yKdBfyoc3T9CSU8XY5zmdEWA4/XMYfgz7TkbYry3cYiSCQIgrYycvKZZitWXThBphKgNZkVuTB7Pvw5bnVKcUlWI0vmMuU7pk6PDoa9LiPmLP1Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166195; c=relaxed/simple;
	bh=I/NhP5JBdaUaGxYXMds0uw+Ox/KW4RdR+azuwJW9+oo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=l2oVR7gMDvrJNUglnz/j8U/UABJGXz35TiyWkeCTXM2QXqup4LitqP3z8ZpRal3W1Zwx4jaOtPmcQzbvz17Bb6+iJasCQVPhx1NVMv1o5crnmOP2mhFefvXGUlWBwHKPZ69RvDAGGEW96nP50lL8LhCsPuzMxMa/yfv+dhgra/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YLVx715I; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YLVx715I"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260727152950euoutp02ddadba436c40e5ba7d659c12cf711507~GLzEdHhj73162931629euoutp02m
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 15:29:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260727152950euoutp02ddadba436c40e5ba7d659c12cf711507~GLzEdHhj73162931629euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1785166190;
	bh=tzE/OIn1Tay8h/zGuVWlDIRcDbJgWktvdWGG0ocimEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YLVx715I29DQ0HgDsb8KBWlloZYZFTwqf03EVYSw4UY2b75LkhVjeTnYHwhnyvUl0
	 N07FslQBB1gbIx0JwuIfWgstvA75t2PpD9jtv+pz0GyJgeKE492+KIwfRgXQNh6ram
	 PqtFG0AqsKBPK3Qti9j3EMULSr2uA7zwPU315luc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260727152949eucas1p2a8679cd740d0bccf89db7d0af8904225~GLzD_LPhR0209002090eucas1p21;
	Mon, 27 Jul 2026 15:29:49 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260727152949eusmtip2fc87d328d97108676a708182a310cbbe~GLzDpDCZB2760827608eusmtip2U;
	Mon, 27 Jul 2026 15:29:49 +0000 (GMT)
Date: Mon, 27 Jul 2026 17:29:46 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, rohan.g.thomas@altera.com, pabeni@redhat.com,
	rmk+kernel@armlinux.org.uk, richardcochran@gmail.com
Subject: Re: [PATCH net] net: stmmac: Fix E2E delay mechanism
Message-ID: <amd5aoSrOSPrcB5e@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260727022524.7521-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
X-CMS-MailID: 20260727152949eucas1p2a8679cd740d0bccf89db7d0af8904225
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----BPbw8mQRoEt0u-7Bumi.mWTL05vKK99i-nO8JDZ4gq6NpdnW=_9c09f_"
X-RootMTR: 20260727152949eucas1p2a8679cd740d0bccf89db7d0af8904225
X-EPHeader: CA
X-CMS-RootMailID: 20260727152949eucas1p2a8679cd740d0bccf89db7d0af8904225
References: <20260727022524.7521-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<CGME20260727152949eucas1p2a8679cd740d0bccf89db7d0af8904225@eucas1p2.samsung.com>

------BPbw8mQRoEt0u-7Bumi.mWTL05vKK99i-nO8JDZ4gq6NpdnW=_9c09f_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Sun, Jul 26, 2026 at 07:25:24PM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2a0d7eff88d3..24d8c6e9f1df 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -755,7 +755,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
>  			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
>  			ptp_v2 = PTP_TCR_TSVER2ENA;
>  			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
> -			if (priv->synopsys_id < DWMAC_CORE_4_10)
> +			if (priv->synopsys_id < DWMAC_CORE_3_70 &&
> +			    !priv->plat->has_xgmac)

This change does not compile, as has_xgmac no longer exists
since 26ab9830beabd. Please check patchwork for more details.

But on my test kernel 6.18 from a while ago where E2E is broken,
it fixes the issue.
So Tested-by me but not really.

BR
Jakub Raczynski

------BPbw8mQRoEt0u-7Bumi.mWTL05vKK99i-nO8JDZ4gq6NpdnW=_9c09f_
Content-Type: text/plain; charset="utf-8"


------BPbw8mQRoEt0u-7Bumi.mWTL05vKK99i-nO8JDZ4gq6NpdnW=_9c09f_--
