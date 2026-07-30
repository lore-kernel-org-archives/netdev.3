Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D543217723;
	Thu, 30 Jul 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424633; cv=none; b=Gv9YxAMR/D43aWkRSC6nC7WFGCiLgOilNMtWQIQ+dgwFb09Ck7TeZuEiqdqY4CdU0x1wUaHszBKqI1i03pmcw/V9MqJo8yaW/nNlsLGsnVoCJZpRZYU3XnM6NOWexwU2zWR29fJg7DVQOReH0o5Jr+2ZkHomMfOO8UZUqoGDy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424633; c=relaxed/simple;
	bh=jz6jD8LWvDFjIjhJZV98OLq1NFIlyUmZTqcVrNTuIQY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hodXoP0ElZTXpJIowgtrGMxI8EzPMuyGKdHyvPrC+kZ+NlRUPRp8VNHGnxjP2xbbbI4s1remOmY6n4SB9xmK19xv7ZZniHQ0ZjnU/8KO5JMZDeyUroEVO5ZfMeFC7E0q00W08K+ESmBHVYDu6uuYPRULpteRNczgzlLo5e4lZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=0IF5WYCZ; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=qzcyP2OG; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="0IF5WYCZ";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="qzcyP2OG"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 66UFGFTt022965;
	Thu, 30 Jul 2026 17:16:20 +0200
Received: from lubuntu-18.04 (unknown [139.28.148.6])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 83E6B122984;
	Thu, 30 Jul 2026 17:16:10 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1785424570; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLdEfZMWSPHJh2FLnlcHKOXFLswyMvzaQtEfSHP/Aog=;
	b=0IF5WYCZWi5Ffd37H9LHdPlJF47dyCdGZkLtlTOYV1E27YP4wFG7S0XykOmN8hWbaMlQCC
	IV48e5MBRLoUqMCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1785424570; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLdEfZMWSPHJh2FLnlcHKOXFLswyMvzaQtEfSHP/Aog=;
	b=qzcyP2OGz9K9fx1QlfoNhAQ+BRpYVrA/PRkYgPFBFwRm8wfGsheq/flExTRHi55XmAcyR6
	Zseab6U9MekdjC3vWNvgJANRtZSKqOa+Hcw+C0NQwvoJYuso6TyvMVALbYRjWfK9bTt/cC
	ya8WP2gU6TNhe3h5LtWnhldpRrvYm6viAFQlIdh3C9yXzKSJps0QVI5GNAM4cp8ODgItSG
	ycCEhqobnTGqXthDvMRiOsup927Og1j337v66IJAKXMk0wCorB4H/vODz8xiJm7Yub6vo/
	NF/UN+UI4Z6uyLbCaPA/GuQsqSPIREEzUFGje3SuYOMlNMtoZN356jo6K0Ogqw==
Date: Thu, 30 Jul 2026 17:16:10 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Xiang Mei <xmei5@asu.edu>
Cc: Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pablo Neira Ayuso
 <pablo@netfilter.org>,
        Ryoga Saito <contact@proelbtn.com>,
        AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
        kys@microsoft.com, stefano.salsano@uniroma2.it,
        justin.iurman@gmail.com, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] seg6: fix NULL deref in
 input_action_end_dx{4,6}_finish() after nf hook
Message-Id: <20260730171610.fd26496925644598ab9a3297@uniroma2.it>
In-Reply-To: <CAPpSM+QNoS4VQ51UTM2idgG-V_5cNgJ5rf=k9uN0ya7UR2n27Q@mail.gmail.com>
References: <20260720204430.1886091-1-xmei5@asu.edu>
	<20260723100949.4443811e@kernel.org>
	<20260724151100.16b60b15db7c6353b4fedf99@uniroma2.it>
	<CAPpSM+QNoS4VQ51UTM2idgG-V_5cNgJ5rf=k9uN0ya7UR2n27Q@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Tue, 28 Jul 2026 14:49:08 -0700
Xiang Mei <xmei5@asu.edu> wrote:

> [snip]
>
> You are right. Following your hint, I also found seg6_local_input_core(),
> which has the same shape. v2 is a series of two patches and covers all
> five sites:
>
> seg6_local.c:
>   seg6_local_input_core()        LOCAL_IN
>   input_action_end_dx4_finish()  PRE_ROUTING
>   input_action_end_dx6_finish()  PRE_ROUTING
> seg6_iptunnel.c
>   seg6_input_core()              POST_ROUTING
>   seg6_output_core()             POST_ROUTING

Thanks for covering all five sites.

I ran into this pattern during the MUP v2 review [1] and have been
working on the skb_ext approach since. My work covers these sites and
also includes selftests for DNAT. I will post it as an RFC for
net-next.

> [snip]
>
> So an skb extension really would do it. SKB_EXT_* is refcounted, rides
> with the skb, and nf_queue leaves it alone. I want to be clear that your
> suggestion is workable; I just did not take it in this series.
>
> My reasoning is scope. It means a new skb_ext type plus an lwtstate
> reference on every seg6 packet, which feels like net-next material.

As things stand, preserving state across the hook needs new machinery,
so type-check and drop is a reasonable fix for net.

> There is also one open question. I want your view on it, and that of
> the other maintainers.
>
> Say a DNAT rule in PRE_ROUTING rewrites the inner packet's destination,
> and End.DX4 then runs with its state preserved. Then which one is intended:
>
> 1) send the packet to slwt->nh4, the nexthop from the SRv6 route.
>      This ignores the DNAT rule the admin installed.
>
>  2) route on the new destination instead. This ignores the nexthop the
>      SRv6 route asked for.
>
> v2 does neither. It drops the packet. If you have a suggestion for
> this, I can do it in v3.

For net, dropping is the safe choice. Before the fix, the same scenario
panics the kernel (NULL deref), so a clean drop is not a regression.
I will look at v2.

With the lwtstate preserved (e.g., the skb_ext approach), the existing
code already handles both cases. Indeed, End.DX4 does
nhaddr = slwt->nh4.s_addr ?: iph->daddr, so a configured nexthop takes
precedence over the rewritten address, while an unconfigured one lets
the DNAT destination drive the lookup. End.DX6 follows the same pattern
through seg6_lookup_nexthop.

> I left the "different instance of the same type" case alone for the same
> reason. The type test passes, and the behavior uses another route's
> parameters. It is wrong, but it is not a memory bug, and it predates the
> crash.

Without saving the original lwtstate before NF_HOOK, in theory there is
no guarantee that the instance is the same after the hook returns. The
skb_ext approach addresses this too, since it preserves the original
lwtstate rather than re-reading it from the current dst.

[1] https://lore.kernel.org/netdev/20260516182556.66af27a9c63208435911990b@uniroma2.it/

> Thanks again,
> Xiang

Thanks,

Ciao,
Andrea
