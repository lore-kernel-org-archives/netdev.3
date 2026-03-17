Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486373932F0
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 11:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746898; cv=none; b=YFnwqqhNyXSRSneOoQUXW8jDrdqg4s/w/sdapgHiIB3836457QV9w2icfX9YPe02ILuhmBZtBJK+cRdVqs54f1sQ8KyWicW9tDADR7yVbWqs0WNf1FSrH7E4QcfrgUTiqCUe/lQn7A4AQFOnouiLVUFxTzBrbBBHyr1Ga+6UZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746898; c=relaxed/simple;
	bh=w/dJ58IgCVpshKP6UPHntiQM4ytcAyWRbjOfkYO8NYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pkKdmqrP1cNDit2uRGJyYCYbZeAgypXodVVZ6K9Aq9BgqeYGg7+Cn6hud3zhOpjoBDOAppdEr6SAjTXo+s8zcf1ygySOdZhLL32d/onok0vHHd/jiKIlj9xTyMdpSb4kZ15R+C5UqCg+8I+F/mnPf+6rTnexhgcVjWEbL7ZAb1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=suStUPmP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IhFOkXiY; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="suStUPmP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IhFOkXiY"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5E0827A01CB;
	Tue, 17 Mar 2026 07:28:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 17 Mar 2026 07:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773746894; x=
	1773833294; bh=AuVMHT4ZPAVI6cSYmav71CqmTZ6hhsuQgZVYsv9wEPM=; b=s
	uStUPmP9RWo8BaHWRDLgIt915kaK4Sw9gcWkfMoFtSiWjRxE7Qx/8DN4VAwkDF+X
	hCshP1lOmN7I6taN/is4Ps1ZJMGVxRqQzX44cL19xyfvBeFFZuj7FpHnF2KtDZlh
	I9vrOWpsOOdXLBQDqGDkChcXd3zYI58qRBeRE0YxS8C4W8UXN4Tc3IArwKx7eAEi
	J9t/kCP7Ec0ANSek9wdA6j/PfOTLeQhT9STcKPqQ2Q41sjDKYk9JnxM0KZ1WxiEs
	hIVH/aOVmaihcE0KbHf+uP0m1L4VGEO1AZgAFXoe/qWDHXqlfmK6In83PYEqz79D
	3GTIF0sEx/ilNNQlhBkvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773746894; x=1773833294; bh=AuVMHT4ZPAVI6cSYmav71CqmTZ6hhsuQgZV
	Ysv9wEPM=; b=IhFOkXiYoUEwADycWWh6OSAG6yfigIIg2q4t+PfBh5xWkbyq5N8
	n8ElK10rlvkyhNy60aU6dNpP6lcQuS2gyFwPFXcHuad41TEptz3ZKr/aM0dtf8i6
	E5DbS9fEIcvAzfFDBE92ElbuoKlTxcG5cGgg9T5NCg3P4eTWPuVJ2VpAzK9hBfEb
	WHQkOfZWka/g2SgzorZW6OVIQ3DMX4SAHY0noAdDegK8/HfHimtDfT72pl2MfMfa
	vz2AslnI6OocWppXq/X1qEpoQHUzlkfjPpNr+aRdRS6ZJr4XHuj0jQ1n4nc+Z0x3
	bDg/NBQJXwgGKPsqF2lY0y2QejJPbpn/gEQ==
X-ME-Sender: <xms:zTq5aTBxQRUzjOINihNgjQ73sqBc17wlDDYv_dg118fMQ1WPUI7fdg>
    <xme:zTq5aQY4--uYV7tZdN3cU7aCNpYAGubkYayNL-9TLG9anbF_j_meL0dSZrgqWTa-R
    z1XriCeJWRY7vQ8FFp4FRucgEF9Pkbs_sBgISDYwiPH_xRHcVdG_aY>
X-ME-Received: <xmr:zTq5aW7R5qouh_pXJQHbj1ODW1Gqjp4Hi6whCXL8R0ge_6QeH9xcT4Nzs1ym>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepmhhmihgvthhusheljeeshigrhhhoohdrtghomhdprhgtphhtthhopehn
    vghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrshhonhesiiigvdgtgedrtghomh
X-ME-Proxy: <xmx:zTq5aRYqeR8lbuHvMWKHw6XDeOJYeHIRi-CvnMwbaNlsJq1oOCxWTw>
    <xmx:zTq5aVhsxFdhobRZpiubaqKYDAgtciPEYcF9ia59ITODofQ-svoifA>
    <xmx:zTq5aS-LFQ0zpIFXK_8V1-turNSObOIG2DLJcj3bQpA2W_Ybsrc-eg>
    <xmx:zTq5aQrFxVTA-5BVPsgFtpZyKya991MsIFg_1hsFzfKtNTA-wiKUfg>
    <xmx:zjq5aXpskPoagc_8DbxTUvwzDJdMZypoK79oPcnBa3pdxwyP78bqcnMV>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 07:28:13 -0400 (EDT)
Date: Tue, 17 Mar 2026 12:28:10 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Marek Mietus <mmietus97@yahoo.com>, netdev@vger.kernel.org,
	kuba@kernel.org, Jason@zx2c4.com
Subject: Re: [PATCH net-next v5 00/11] net: tunnel: introduce noref xmit
 flows for tunnels
Message-ID: <abk6yhfnry2NzkZh@krikkit>
References: <20260113162954.5948-1-mmietus97.ref@yahoo.com>
 <20260113162954.5948-1-mmietus97@yahoo.com>
 <89df6470-027b-4d86-98a1-72042ca819ed@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89df6470-027b-4d86-98a1-72042ca819ed@redhat.com>

2026-03-17, 12:02:30 +0100, Paolo Abeni wrote:
> On 1/13/26 5:29 PM, Marek Mietus wrote:
> > Currently, tunnel xmit flows always take a reference on the dst_entry
> > for each xmitted packet. These atomic operations are redundant in some
> > flows.
> > 
> > This patchset introduces the infrastructure required for converting
> > the tunnel xmit flows to noref, and converts them where possible.
> > 
> > These changes improve tunnel performance, since less atomic operations
> > are used.
> > 
> > There are already noref optimizations in both ipv4 and ip6.
> > (See __ip_queue_xmit, inet6_csk_xmit)
> > This patchset implements similar optimizations in ip and udp tunnels.
> > 
> > Benchmarks:
> > I used a vxlan tunnel over a pair of veth peers and measured the average
> > throughput over multiple samples.
> > 
> > I ran 100 samples on a clean build, and another 100 on a patched
> > build. Each sample ran for 120 seconds. These were my results:
> > 
> > clean:      71.95 mb/sec, stddev = 1.71
> > patched:    74.92 mb/sec, stddev = 1.35
> > 
> > TL;DR - This patchset results in a 4% improvement in throughput for
> > vxlan. It's safe to assume that we might see similar results when testing
> > other tunnels.
> 
> IMHO this performance delta is not enough to justify this amount of
> changes.
> 
> Additionally, the measured impact of removing the dst_hold/dst_release
> does not fit with my direct experience on the same matter: it should be
> below noise level in practice, as dst are per-cpu and and no
> contention/false sharing is expected in a good setup.
> 
> I think you are observing larger impact because in the veth test
> dst_release can happen on a remote CPU. Note that this setup (vxlan over
> veth) is not very relevant in practice.
> 
> I'm sorry I'm not applying this series.

This is probably fine for everybody who's been following this series,
but you answered v5 (from January) instead of v8 (posted last week).

-- 
Sabrina
