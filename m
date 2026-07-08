Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0533E7BBB
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783495645; cv=none; b=Omi3c9GXveRHJLpzSBUkQP0OQxA3sa80H/7DwCMB1VU4LvT69bhh/d2hJfNY3/5pPRWDGHv6mV4mlO1/2uVc3LdUQrLRVXU4d0s+R6s4PN8dLYz5MNLCcbYkqfdR7/5Rg8bU+N30IDQDwOexehZIGdlUhG/UZhdUxh8mtOjnC7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783495645; c=relaxed/simple;
	bh=8TwkcMAicouAmlLicdqCdPqx48WWKC4JL5vHmeBaaEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=gV7ffOeZPeglZrlKG9tGGLWupaB649rBqpmmLTBgE6rCtwnxNuD1W+EECTeqQCdr+qaQN0WPZljBmZqmm84TyQyhCdI6XcA6ExyTgdR3/3nqaUL3TgaCcJFQ2h6uX+YLvUnu3BJoENBfO35JU4z16BEi8eHxY97pCnBCICEy1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=C8KSUpY/; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C8KSUpY/"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260708072708euoutp020ddce7b5481265a080b4b868f3931eff~AP9MdpT7m1814218142euoutp02o
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 07:27:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260708072708euoutp020ddce7b5481265a080b4b868f3931eff~AP9MdpT7m1814218142euoutp02o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783495628;
	bh=AAT0vxHvZGnQFghigS3BsjoKQVyxGb6u1tpbTaYnWoA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C8KSUpY/JfVGmDRu7STwuADaSziCHaNIIg1/sjBVa/o2LhIGB2vi/x8rLiSD37/+P
	 AsJTC2cxhc9t7lo1v9hzAt5Wbf5vAiBxaBUMYDdJYBxwHVSlg8iYZiuKIVnnITnGV5
	 uWFPg3H7vc9UzQq6aaST3GlttX+WpMuJlX4wjFVc=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260708072707eucas1p2dce9de593df0be3855839c4f41f61f2c~AP9Lj3STQ0421304213eucas1p2m;
	Wed,  8 Jul 2026 07:27:07 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260708072706eusmtip1a9d4958030b6902d17d42dbb46221419~AP9KjxNiX1151911519eusmtip1i;
	Wed,  8 Jul 2026 07:27:06 +0000 (GMT)
Date: Wed, 8 Jul 2026 09:27:06 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, k.tegowski@samsung.com,
	k.domagalski@samsung.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net/stmmac: Verify provided DTS AXI setup
Message-ID: <ak37yhQjA32gI0kr@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ee504cab-b1da-4584-8693-70ed5cd943c7@lunn.ch>
X-CMS-MailID: 20260708072707eucas1p2dce9de593df0be3855839c4f41f61f2c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----FoLMw5K6Fe9t5vMBf.HRV6LBdzA_42JMttv_zc4dtfIAKr8-=_130f8b_"
X-RootMTR: 20260707174439eucas1p153ea592df5c1c7a50e947022a80a1056
X-EPHeader: CA
X-CMS-RootMailID: 20260707174439eucas1p153ea592df5c1c7a50e947022a80a1056
References: <20260707174431.1264520-1-j.raczynski@samsung.com>
	<CGME20260707174439eucas1p153ea592df5c1c7a50e947022a80a1056@eucas1p1.samsung.com>
	<20260707174431.1264520-3-j.raczynski@samsung.com>
	<ee504cab-b1da-4584-8693-70ed5cd943c7@lunn.ch>

------FoLMw5K6Fe9t5vMBf.HRV6LBdzA_42JMttv_zc4dtfIAKr8-=_130f8b_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jul 07, 2026 at 09:04:00PM +0200, Andrew Lunn wrote:
> On Tue, Jul 07, 2026 at 07:44:31PM +0200, Jakub Raczynski wrote:
> > During parsing of AXI setup, there are few issues:
> > - 'axi_blen' array is uninitialized value on stack without zero-init stack
> >   configured. This can result in random AXI burst length config if
> >   DTS config provides shorter array than AXI_BLEN.
> 
> What does the DT blinding say about the length? Is it allowed to be
> short?
> 
> Are we talking about:
> 
>       snps,blen:
>         $ref: /schemas/types.yaml#/definitions/uint32-array
>         description:
>           this is a vector of supported burst length.
>         minItems: 7
>         maxItems: 7
> 
> So it should be 7. Are there any in kernel DT blobs which don't pass
> 7? Can we just error out when it is not 7?

Erroring would be fine, as wrong amount will pass.
Same as previous answer, I start to agree more and more that code should give
more errors rather silent fix stuff.
This is mostly Sashiko complaining but I have seen this being incorrect in
some internal forks.
But, as a code is currently written, this does not have to be 7 and
documentation is merely a suggestions. I doubt wrong DTS would pass to
mainline linux so it is merely 'internal' fix.

> 
> > - In case of failed memory allocation for AXI and error, there is no handling
> >   of that. Fix it by checking if AXI config is error and return if so,
> >   as this can only lack of memory. No AXI config, although is probably
> >   wrong in most cases, is not treated as error, as generic config is mostly
> >   provided in drivers.
> 
> This seems like a different fix. Maybe put it into a patch of its own.
> 

Got that.

> > Fixes: afea03656add ("stmmac: rework DMA bus setting and introduce new platform AXI structure")
> 
> Again, does this bother anybody? At least axi_blen issue seems to be
> that the DT blob is broken, so i doubt it actually does. Are there
> reports of memory allocation error and resulting Opps.
> 

Only internal and quickly fixed. No public reports.

BR
Jakub Raczynski

------FoLMw5K6Fe9t5vMBf.HRV6LBdzA_42JMttv_zc4dtfIAKr8-=_130f8b_
Content-Type: text/plain; charset="utf-8"


------FoLMw5K6Fe9t5vMBf.HRV6LBdzA_42JMttv_zc4dtfIAKr8-=_130f8b_--
