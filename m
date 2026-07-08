Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C41E3ACF1D
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495114; cv=none; b=YIiqLiA3iN5jPGwNnrdX32r1eos5MjbeXksd7MsuLlF2lb0x+srFTS1kBoN5EaQTf8EExN9etj8kk2UDR4U0RdjKL7yzBoKWqNa4+yoNKWON2Uh5PzccnZodQruRPYaroKVVsiYPAMcEa3JSqlWlcOyzqAv4AZEWeiK5bB3C+90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495114; c=relaxed/simple;
	bh=tc5P6XvtSNcAFKVcTcvXExZuQxIKi/5PDLgdqL28+9A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=gE+KjyFeP3fa/XN8WH9BV6ay/VtmqbdCusW6e2Dubn2FPBIV2HPRoQTvi9MofBBbq9PikMwl8cfKvssTuAANDEZmpn3sOhR3KTJGIGQaeJi/qrDnJoGXTD97OHw9X3E5oxGPdZa/6CPSDTBNSP30pHZFmIVM6B/P232u7J3HTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dqgy0tx6; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dqgy0tx6"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260708071821euoutp02b786dda0d5ccfdc629ed862bb7b32d6b~AP1h0-xhp0587605876euoutp029
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 07:18:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260708071821euoutp02b786dda0d5ccfdc629ed862bb7b32d6b~AP1h0-xhp0587605876euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783495101;
	bh=NtEIand9GnbkU6Gmk6cHJc/OJJrgfSZv10wVu3h9OTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dqgy0tx6XfSS9ZQOmJv6oBqEiBm18HkmXtHwlF7mqVY+2G9fPOU4A7YwzY/BuPI+g
	 R2WivM4MbVng3qen7ibHCFcwIDme3asMvIy6ZRahvtdLWQdQiAzRV3Yw0KMzd8X8Sr
	 plnn1GtrAunRxeJ1NVIECjQgsaLmaU30x+99Ef3c=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260708071821eucas1p1781d839e4c171db030e3cc100140a18b~AP1hX0Igg1688916889eucas1p1b;
	Wed,  8 Jul 2026 07:18:21 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260708071820eusmtip236a9c2dfa6bc4bffa3c1d0aa81ba9c6d~AP1gt38kQ3160531605eusmtip2G;
	Wed,  8 Jul 2026 07:18:20 +0000 (GMT)
Date: Wed, 8 Jul 2026 09:18:17 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, k.tegowski@samsung.com,
	k.domagalski@samsung.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net/stmmac: Protect against zero queue DTS
 config
Message-ID: <ak35uSDb8YGJDixt@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d4fb7a9f-c0bb-4ced-8428-14bd2aa66d85@lunn.ch>
X-CMS-MailID: 20260708071821eucas1p1781d839e4c171db030e3cc100140a18b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_131043_"
X-RootMTR: 20260707174438eucas1p132b5c02ceed2493cc7de98ab28c390ee
X-EPHeader: CA
X-CMS-RootMailID: 20260707174438eucas1p132b5c02ceed2493cc7de98ab28c390ee
References: <20260707174431.1264520-1-j.raczynski@samsung.com>
	<CGME20260707174438eucas1p132b5c02ceed2493cc7de98ab28c390ee@eucas1p1.samsung.com>
	<20260707174431.1264520-2-j.raczynski@samsung.com>
	<d4fb7a9f-c0bb-4ced-8428-14bd2aa66d85@lunn.ch>

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_131043_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jul 07, 2026 at 08:57:28PM +0200, Andrew Lunn wrote:
> On Tue, Jul 07, 2026 at 07:44:30PM +0200, Jakub Raczynski wrote:
> > Commit 8a7bca6de6de protected against inputing number of tx/rx_queues_to_use
> > over kernel supported limit in DTS config. AI review mentioned that we also
> > should protect against zero queue input, because this would cause issues
> > down the line. Missing config is not an issue as stmmac_plat_dat_alloc()
> > does apply '1' by default.
> > 
> > Fix this by adding check for zero queues input during DTS parsing
> > 
> > Fixes: 8a7bca6de6de ("net/stmmac: Apply MTL_MAX queue limit if config missing")
> 
> I'm not sure a Fixes: is justified here. Does this bother somebody? As
> far as i understand, for this to actually do something the system is
> broken anyway?

Yes, more below

> 
> >  	if (!of_property_read_u32(rx_node, "snps,rx-queues-to-use", &value)) {
> >  		if (value > MTL_MAX_RX_QUEUES)
> >  			value = MTL_MAX_RX_QUEUES;
> > +		else if (value == 0)
> > +			value = 1;
> 
> If the DT is broken, don't we want it to be fixed? -EINVAL would make
> it obvious.
> 
>     Andrew
>

EINVAL would be better, I agree.

Mentioned patch changed U8_MAX -> MTL_MAX_RX_QUEUES (and TX), because
inputing more just panicked kernel and there was already verification for
that, so it was fixed by silent fix of incorrect value.
We triggered this while were testing XGMAC hardware that supports 16 queues
(current driver limit is 8). Original fix having EINVAL would also be good.

Inputing 0 is much less honest mistake but rather some testing how kernel
handles other/incorrect values. So at the very least, this should not be able
to panic kernel. But as above, I agree EINVAL actually would fit better here,
that will be for V2, and so it would for original 8a7bca6de6de.

Whether it justifies Fixes or not, I am not sure, it is real possibility to
trigger panic if system has dynamic DTS loading (CONFIG_OF_OVERLAY) on
system with wrong permissions.

BR
Jakub Raczynski

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_131043_
Content-Type: text/plain; charset="utf-8"


------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_131043_--
