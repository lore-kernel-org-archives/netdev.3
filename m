Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5C30DEB8
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575076; cv=none; b=nR53S2WDikyBROcVsZyzmrdjzAcl0JNzGBjsZdzp7iGJPFf8gACe+S1RfqmN3O4r9HK50tA52Pxvabf4RcojkX6Z2U9wUI4RU9koB9s9fDXWo3Y7F2ZFY4G5x7bw4OKChHST1Jh3PiU+c2Fcml8VkZfVGngv4RcxF6+G+8TSsvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575076; c=relaxed/simple;
	bh=Z2cAAIkr6iMWfJpguX929CHX4z3mxExtUL7mVN9afKM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=Hf4h2h8etrA5FwLCZZgxbUun2dL2cHFbDPfjJQ4HsYtQh/s2MklDyrJZr9LT8WXWpd1MAc9u0G29h+sMHhxkps48tc2HVE1xd+P+pyMeuKEfhzhTIxPq5dFyRJsbnP+gI0/FOzzKzeNMKoc6C7FGYbu6s/fLRrId0izwjaiEp6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E5AwiwDA; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E5AwiwDA"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260512083751euoutp02adb5e865a0d8c40fa0716e7d6a2b7b78~uxJrBYWjP1153011530euoutp02R
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:37:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260512083751euoutp02adb5e865a0d8c40fa0716e7d6a2b7b78~uxJrBYWjP1153011530euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778575071;
	bh=P+WzoEiF7scbrcGL30MDai0Mqm4NhhCQaJizIZE8db0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E5AwiwDAMGB7RSWPZLRxM0BZ9Y+v/VfoAWWo3XaYvlObtQLlmKj3fqIOltyNjcqOx
	 Z2w8Fa9Zr9D/vp1R0er3vkWyoCH7L+QCLp3aJW+1wWWVZLwBW9iQkPdMvA/UEH/K89
	 dPbxNW3Ls3pFdGTg91Bt0omKwgJJ8d8w2Xv9eVAA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260512083751eucas1p293e684cc51c2fef348703824f0efe447~uxJqqzJvr1439714397eucas1p2d;
	Tue, 12 May 2026 08:37:51 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260512083750eusmtip138caf2d0ef97dcdc9ce9f285e0bfe8bd~uxJqGshoK3069330693eusmtip1j;
	Tue, 12 May 2026 08:37:50 +0000 (GMT)
Date: Tue, 12 May 2026 10:37:50 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, k.domagalski@samsung.com,
	k.tegowski@samsung.com
Subject: Re: [PATCH net-next 1/3] net/stmmac/dwxgmac: Modify DMA functions
 for future hardware
Message-ID: <agLm3rvbVp4MpHT7@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5b94f49e-5f1a-40fb-af34-f4a9d4738502@lunn.ch>
X-CMS-MailID: 20260512083751eucas1p293e684cc51c2fef348703824f0efe447
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="-----ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_1f670_"
X-RootMTR: 20260511165431eucas1p1450bdea6486a72257f6463d5f40abc50
X-EPHeader: CA
X-CMS-RootMailID: 20260511165431eucas1p1450bdea6486a72257f6463d5f40abc50
References: <20260511165416.3093015-1-j.raczynski@samsung.com>
	<CGME20260511165431eucas1p1450bdea6486a72257f6463d5f40abc50@eucas1p1.samsung.com>
	<20260511165416.3093015-2-j.raczynski@samsung.com>
	<5b94f49e-5f1a-40fb-af34-f4a9d4738502@lunn.ch>

-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_1f670_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, May 11, 2026 at 08:02:14PM +0200, Andrew Lunn wrote:
> > +	/* Newer XGMAC hardware does support up to 16 MTL/DMA queues but
> > +	 * only 8 traffic class queues. Redirect these, but this is error in
> > +	 * configuration.
> > +	 */
> 
> If this is an error in configuration why not return -EINVAL when the
> configuration is requested?
> 
> 	Andrew
> 
Because is generally would not change a thing and would probably cause more
problems.

Parent function of stmmac_set_dma_operation_mode() -> stmmac_dma_tx_mode()
does not have any error handling. So we end up in situation where
tx_queues_to_use from DTS is still at its value, so we still have situation
where amount of DMA/MTL queueus is higher than number of TC's.

So then in case of XGMAC 3.20a/3.40a, we would have 8 DMA/MTL queues that
have assigned TC and 8 that don't. I cannot speak for older/other XGMAC if
there were ever a case like that where number of DMA/MTL != number of TC's.

So we will get many unusable MTL queues, eg. NAPI does use tx_queues_to_use in
its initialization, these queues will still be visible in system and can
be sent to. Leaving them unconfigured will very much likely lead to
'Tx queue timeout' and endless loop of interface restart via
stmmac_reset_subtask().

I think it is just simplier to leave warning that configuration is wrong,
handling error would be quite big change to make.

BR
Jakub Raczynski

-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_1f670_
Content-Type: text/plain; charset="utf-8"


-------ovPTPTVSqDshbadlcck0r4M7-N_rZ7qlFcbt45lvJNOWX_g=_1f670_--
