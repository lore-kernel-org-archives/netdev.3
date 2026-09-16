Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C24A8FFE;
	Wed, 16 Sep 2026 09:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550800; cv=none; b=AtaPHwLoLJOfsjC/KiJuwpt40lgJbLLg89WetGrdC9QL4QsHBtyT4ZXwKITW9i1xNn+/n5rG2LgDb5ArS5lwDW88SYZ38UN7+v58lDtQKpasJO9mS4LbMg+WSiEjq8PpcbmKFKueN45O4nhC10fqRvVkeGPgpjs9qaTe1FZXzFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550800; c=relaxed/simple;
	bh=C5FGUF+PRI41zQAK8bvUACKSF73rkiGrdRbOOJatSew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKRGwZhqSwOwriVn5JVuLHnq2J1E6aPqaaL0lH5n8k/SDCT2IS211vmjM0sAz9wHYoQwj9BPCvORL+zMmE/7FittQEFYD2+epUsMTOqImhRuG86dOwrylRDYLCl9QLL/JD5XJRvErit3/tvMO0rOSlGpf4anNP6X29d/ZAVBNEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Y1/NzFiF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Y1/NzFiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F041F000FF;
	Wed, 16 Sep 2026 09:26:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=Y1/NzFiF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1789550782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PtlHtwIG4pv+W9xhPsusT4EJ1S00TAe8zhG6Y8xxYWk=;
	b=Y1/NzFiFpPTZ6x6FibTU62lW3TlgiKgNv/JHKtD1grj11j8QK77dhETrucfNT4r/+wejZC
	TIRRHB4G1gFUOVPLxhwVFWlKE0zjw51zWO9pewZkF+SD8vCJn3QQYvmT/dsr4htwaTpPwR
	KWxdBa5kfjN2nYsBkO2MeObIKs5d6FM=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 9dcbb453 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Sep 2026 09:26:22 +0000 (UTC)
Date: Wed, 16 Sep 2026 11:26:19 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Ramses <ramses@well-founded.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Wireguard <wireguard@lists.zx2c4.com>,
	Netdev <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] wireguard: queueing: preserve tstamp_type in
 wg_reset_packet()
Message-ID: <aqpgu23iotZeyGgv@zx2c4.com>
References: <20260827-wg-tstamp-v1-1-4acfebb855ef@well-founded.dev>
 <apT0H7qIwFW-JCLn@zx2c4.com>
 <P0MLDmd--F-9@well-founded.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <P0MLDmd--F-9@well-founded.dev>

On Mon, Aug 31, 2026 at 12:24:15PM +0200, Ramses wrote:
> Aug 31, 2026, 05:25 by Jason@zx2c4.com:
> 
> > Hi Ramses,
> >
> > On Thu, Aug 27, 2026 at 01:52:56PM +0200, Ramses de Norre via B4 Relay wrote:
> >
> >> From: Ramses de Norre <ramses@well-founded.dev>
> >>
> >> Sending traffic through a wireguard tunnel on a host using the fq
> >> qdisc fills the log with:
> >>
> >>  fq: likely mono tstamp with tstamp_type 0
> >>
> >> An skb carries a timestamp in skb->tstamp and, separately, a
> >> skb->tstamp_type field recording which clock that timestamp came from.
> >> The two have to agree.
> >>
> >> When wireguard encapsulates a packet it calls wg_reset_packet(), which
> >> clears the fields that must not leak from the inner packet into the
> >> tunnel packet. It does so in two steps:
> >>
> >>  skb_scrub_packet(skb, true);
> >>  memset(&skb->headers, 0, sizeof(skb->headers));
> >>
> >> skb_scrub_packet() deliberately keeps skb->tstamp when it holds a
> >> monotonic timestamp: that value is the time the packet is scheduled to
> >> be sent, and the qdisc still needs it. The memset then zeroes
> >> skb->tstamp_type, because that field sits inside the headers group
> >> while skb->tstamp does not. The packet therefore leaves wireguard
> >> carrying a monotonic timestamp labelled as a realtime one.
> >>
> >> Nothing noticed until commit c4f796c4f16b ("net_sched: sch_fq: convert
> >> skb->tstamp if not monotonic"): fq used to assume every timestamp was
> >> monotonic. It now consults tstamp_type, spots the mismatch, warns, and
> >> falls back to treating the value as monotonic. Pacing still ends up
> >> correct, so the log spam is the actual problem.
> >>
> >> Save tstamp_type before the memset and restore it when encapsulating,
> >> next to the hash fields that are already carried over this way. When
> >> decapsulating it stays zeroed, which is right: an incoming packet's
> >> timestamp is a realtime receive timestamp.
> >>
> >> Fixes: de799101519a ("net: Add skb_clear_tstamp() to keep the mono delivery_time")
> >> Signed-off-by: Ramses de Norre <ramses@well-founded.dev>
> >>
> >
> > Thanks for this. I've queued this up in the wireguard tree.
> >
> > One thing I'm wondering is whether your Fixes: line is correct. Would
> > c4f796c4f16b be a better candidate than de799101519a? Or maybe even
> > 4d25ca2d6801 is best?
> >
> > Jason
> >
> Hi Jason
> 
> I think you are right, but I think d98d58a00261 is actually the commit that introduced the issue then (but no warnings were logged yet at that point).
> The patch doesn't apply cleanly to that version though, I think it only applies starting from 6.11 because of a rename, so we can't backport all the way back. It's probably fine though, since the warnings weren't being logged yet at that point.
> Do you want me to send an updated patch, or will you just fix this up in your tree?

I'll fix it in my tree to be:
   Fixes: d98d58a00261 ("net: Set skb->mono_delivery_time and clear it after sch_handle_ingress()")

