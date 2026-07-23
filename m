Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B90F45D1B9
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784820320; cv=none; b=ttG3RZZ2TLiOk9WZgpdUWF0KRGSInM3AYVdvC7r1JM3/64BfB5FpvPsEP6+x9/IfE1vZwkhXKqLU6Q3nE85pTeKP8noyCmB7oY1FBUpXYGS48X5Xt7JxUx2NT55v3HVV8el4QYITo+UJlYEkLql7BOOuudKzMBjGpo5ISPyPZbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784820320; c=relaxed/simple;
	bh=Py6CtLkrEJf8+hBOqlig8mK+czVDXTyv+40w7gLWTXs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=JcZqdNKR3W8rsq9jiG5LQnkWdSOZur/RJWdpCPCTftMxXgc3PR4baHt086MUN9ABDt5ZPBRs7crIa4K6isCNx8kqZXZt94l4P5/S7xq5PRZmmqL0JB+dCyXctcKlugS+LfELo5Ci4Zzat8pyh1FeZUVFXKLlea2oQaMEIkGVY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Z53GhoWT; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z53GhoWT"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260723152507euoutp02584acc3a0633e04f9939e6d346e0c0a6~E9Jz-hgYD2698326983euoutp02L
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 15:25:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260723152507euoutp02584acc3a0633e04f9939e6d346e0c0a6~E9Jz-hgYD2698326983euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784820307;
	bh=r0+Dds94k3kKFRsIETTe3NLyFQQqe/ZYPqy6VWenGsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z53GhoWTtFb8HbB+vpPW1apeC/v+bvuMgmaqwFvovB1tCAvU9yF0ZkqPxlTqPIcnX
	 UKptLoXaTf/ha80lztFsIJQTgx7ZQvMpdnO7iBYxw3MWnOfD+C0uz9zM7PzB6ztGsK
	 tbJcmcNnNM/9iZq4FuLnSeOZUDGaQG7jFz1g8wnA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260723152506eucas1p1a29e976831a01873f677f02fe9d05669~E9JzicgTr1906719067eucas1p1F;
	Thu, 23 Jul 2026 15:25:06 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260723152506eusmtip17ad2aedb5e984e537272d33d6d72f158~E9JzFZs-v0480504805eusmtip1f;
	Thu, 23 Jul 2026 15:25:06 +0000 (GMT)
Date: Thu, 23 Jul 2026 17:24:58 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v3 0/2] net/stmmac: Secure against failures of DMA
 memory allocation
Message-ID: <amIySsYvx+ZhOXzm@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260723072352.6db4df7f@kernel.org>
X-CMS-MailID: 20260723152506eucas1p1a29e976831a01873f677f02fe9d05669
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----F80QVkSs0AhR68Zg0oSW-b5-i4-oaHVRPVEJevbh2s58A1oD=_81ef1_"
X-RootMTR: 20260715123609eucas1p276498c4701060ffbb6789cb096696a31
X-EPHeader: CA
X-CMS-RootMailID: 20260715123609eucas1p276498c4701060ffbb6789cb096696a31
References: <CGME20260715123609eucas1p276498c4701060ffbb6789cb096696a31@eucas1p2.samsung.com>
	<20260715123602.51950-1-j.raczynski@samsung.com>
	<20260723072352.6db4df7f@kernel.org>

------F80QVkSs0AhR68Zg0oSW-b5-i4-oaHVRPVEJevbh2s58A1oD=_81ef1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Thu, Jul 23, 2026 at 07:23:52AM -0700, Jakub Kicinski wrote:
> On Wed, 15 Jul 2026 14:36:00 +0200 Jakub Raczynski wrote:
> > This series fixing two issues related to fails of
> > __alloc_dma_rx_desc_resources(). Original issue from 1st patch is related to
> > page_pool that has happened in testing env, while second was requested by
> > Sashiko to have similar change for DMA allocation. 
> > To have complete fix for all failures of __alloc_dma_rx_desc_resources(),
> > merge two fixes into series.
> 
> Clashiko is not impressed by the second patch.
> Is it possible to avoid calling the functions in semi-consistent state?

Again clash against AI lost, damn you AI. Although I cannot say its wrong.
My bad I didn't really respond to it sooner, especially 13 character Fixes tag,
wonder how that slipped past internal review...

Now being serious, regarding calling in semi-consistent, it is matter of
symmetry between open/close or alloc/dealloc paths.
Since __alloc_dma_{tx/rx}_desc_resources does full initialization,
__free_dma_{tx/rx}_desc_resources should be able to handle whole cycle.
So if __alloc_ failed in the middle, __free_ should handle that state,
whatever it might be.

One thing I will say that AI review is not even about patches themselves,
but about
"If the intent is to make __free_dma_rx_desc_resources() safe to
run twice on the same queue, [...]",
which is the point, although original patch was generated by
real issue that occured. Other issues it reports are valid but did not
trigger.

So AI is right that everything should be handled in one patchset when
this is touched, but funnily it didn't report it previous review.
Will send another version that will fix all these issues/complains
at some point.

BR
Jakub Raczynski

------F80QVkSs0AhR68Zg0oSW-b5-i4-oaHVRPVEJevbh2s58A1oD=_81ef1_
Content-Type: text/plain; charset="utf-8"


------F80QVkSs0AhR68Zg0oSW-b5-i4-oaHVRPVEJevbh2s58A1oD=_81ef1_--
