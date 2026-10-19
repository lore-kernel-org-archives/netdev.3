Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F96B4A99C6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792401746; cv=none; b=tZLK2bvu4PvrX80Wbk1kaM4ZTIpYvZOEjyJwvnQjAbxs0vXYSDJkNFXP/IEzmVSnlcs2Fybe7kv3OF3pRTtjJBhnJQlRArejH4y3xmDsGBW+ZllSB7wWDzK/c7i88+AGRqukDEEHs/5U/GxXhAxdiAAeTeJb5jUFxsHm43CVF1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792401746; c=relaxed/simple;
	bh=J5u6sWaFs1aIdBznEzlz0gzVqKHDPrr3ucBX/oe3SKg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=FMRVFcaH7uAfHXKoWJkpZUkdvNWigS03bKmpbGHNBVOaadBxlOU5/tHL88sW8aS2pKTyLJw0Ya/vubdet/XD8gZ8/ZMnjap1aCxDr4jcn4S/GxcHwvIoNsie2igRRRkAgxW+5VruqbmFJwI5zav0CkpI7IySgQrGjv7G+blB0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pWpArA8a; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pWpArA8a"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261019092220euoutp02f6e411de2dc1ecf34d3cc8040d383343~f4_LkbKsL0579705797euoutp02k
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:22:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261019092220euoutp02f6e411de2dc1ecf34d3cc8040d383343~f4_LkbKsL0579705797euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1792401740;
	bh=v2HVMRDXjkeD++qT8O5sU//IhqXywOmYn/Fh/Fdivpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pWpArA8adCY0weZo06h5l7f+VKdwx4bquomWpvYh9iJveXLQISPiB1M5/C0fPFs6P
	 zdzEWpmLaORbBtXLFjLaDxDEA04nZJi4Yk7HAE6TuCAlSRgCBkpQZdQyYANL4aH+M0
	 UutmKxFlA9EDm9mTYWRYD4ByP24c0ZYOlr5oTAYo=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261019092219eucas1p22ca50383cc0e4c3f1eb14d4d334983b4~f4_K8T5X92231722317eucas1p2L;
	Mon, 19 Oct 2026 09:22:19 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261019092218eusmtip2172e5354d5c27789ffe4a60232b45023~f4_KBOKXV2833928339eusmtip27;
	Mon, 19 Oct 2026 09:22:18 +0000 (GMT)
Date: Mon, 19 Oct 2026 11:22:15 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, k.domagalski@samsung.com,
	k.tegowski@samsung.com, cs0617.lee@samsung.com,
	abhishek.chauhan@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
	sarosh.hasan@oss.qualcomm.com, hongmei.xu@oss.qualcomm.com
Subject: Re: [PATCH net-next] net/stmmac/dwxgmac: Extend MTL/DMA support to
 16 queues
Message-ID: <atXhR0sgdW84YxcQ@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016193823.2711773-1-sagar.cheluvegowda@oss.qualcomm.com>
X-CMS-MailID: 20261019092219eucas1p22ca50383cc0e4c3f1eb14d4d334983b4
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----6Yzir0.DT2R1UiBbNh0_rPWXcRyD2CU8yss_stBlwropLZCy=_18d29d_"
X-RootMTR: 20261016193835eucas1p128cb1712afce0314b1ecb65b0c0fc841
X-EPHeader: CA
X-CMS-RootMailID: 20261016193835eucas1p128cb1712afce0314b1ecb65b0c0fc841
References: <CGME20261016193835eucas1p128cb1712afce0314b1ecb65b0c0fc841@eucas1p1.samsung.com>
	<20261016193823.2711773-1-sagar.cheluvegowda@oss.qualcomm.com>

------6Yzir0.DT2R1UiBbNh0_rPWXcRyD2CU8yss_stBlwropLZCy=_18d29d_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Oct 16, 2026 at 12:38:23PM -0700, Sagar Cheluvegowda wrote:
> From: Jakub Raczynski <j.raczynski@samsung.com>
> 
> Patch 2/3 of Jakub's v2 series:
> https://lore.kernel.org/netdev/20260601162537.553512-3-j.raczynski@samsung.com/
> 
> Jakub has confirmed he will not be continuing this series, so we are
> posting this patch on its own. We need it for Qualcomm Nord, a
> 25GMAC-based SoC that implements 12 MTL/DMA queues. Jakub's authorship
> and sign-offs are kept.
> 
> Changes vs v2 2/3:
> - Replace the netdev_err() + return in the default case with
>   WARN_ON() + return, following the review feedback on 1/3 against
>   message-only failures in void callbacks.
> 
> Tested on Qualcomm Nord with 12 queues: the MAP0..MAP2 registers were
> checked to hold the expected RX queue to DMA channel mapping. The MAP3
> register (queues 12-15) is carried over unchanged from v2 and is not
> exercised on that hardware.
> 
> This is needed for XGMAC-based hardware with more than 8 MTL/DMA
> queues (Qualcomm Nord has 12).
> 
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |  2 ++

Thanks for including me as signed-off.

But I am not sure I like this patch being sent on its own. I checked Sashiko
review on patchwork and there are no comments and that is actually (not)
impressive by Sashiko.
Issues I have are:
- Does it work if macro MTL_MAX_{TX/RX}_QUEUES is not increased?
- My patch 1/3 was doing some prep since new XGMAC have unique setup where
  number of DMA channels differ from number of TC's.

  How does it look like in your hardware? 12 DMA and (8 or 12) TC's?

  I agree with comment by Jakub Kicinski on my patchset 1/3 that I should have
  implemented it better, but never finally did. Issue is, stmmac driver
  assumes number of DMA = TC and uses {tx/rx}_queues_to_use everywhere.
  So proper implementation would be spliting DMA count and TC count,
  where both can be verified by stmmac_get_hw_features().

  Of course, above applies if DMA!=TC in your hardware.

BR
Jakub Raczynski

------6Yzir0.DT2R1UiBbNh0_rPWXcRyD2CU8yss_stBlwropLZCy=_18d29d_
Content-Type: text/plain; charset="utf-8"


------6Yzir0.DT2R1UiBbNh0_rPWXcRyD2CU8yss_stBlwropLZCy=_18d29d_--
