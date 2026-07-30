Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8750D43E4B5;
	Thu, 30 Jul 2026 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785424996; cv=none; b=ESXy0h45gWbKElsVd/gkxahOyAvWjglPHKlrwWEy/xVvupjbSb6c3mBJ8g9QW1y7nruQpFVzinLcBFdrIOG550eshjSvKMeZMO/cUku5jh19POMEgm0/flQQAEy+2jOcv9sCa3yH8fXxgEMRdw9tgGZWKU2JqGoLF0cjFwEp6Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785424996; c=relaxed/simple;
	bh=Db4vA4aUvVWwI7W3Nxy4MAnyyprKf3UyYROSrrdd8SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuffagZPJ0Ank1CeFgUQX6lfYUpIh5ItByTmfIMiT0B4UTcZGUpey2J4EOMJQCUPbZ7PdJXXGkgpxbn3eodiUWESskKBHrDJ5gUnlX8V9jEc3SYHAx/qV3zsO6rvrh5gb9X+TuZsuQ/C8PxZxHlIM5o++JVGf4KlsF6MtYiD3Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=i0JLIpi0; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="i0JLIpi0"
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 3437760194;
	Thu, 30 Jul 2026 17:23:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1785424992;
	bh=+VXFPS0Wn0M0LrMiKNlzTgCsnQESTB/C+oBKrrzXNJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0JLIpi0ecrkxAEKX49xLzmTihQhLhVFyncN1xAfjYAxYQev1aOJFztWLTMTmuV/f
	 hIIiuVi68RKA0fEoIy1usKFAOaxVaqzgihenHHP4KWweCAB+6PnDcqX1/bpOf/ZFRY
	 XwAQFGE1wHki/PKQUdsEy4oRy17NrEZAEWqtI/HbbEkWI7Op+3vvXj/8RPBlJfp12s
	 DbXz/nD+PYGqo9jdx2Gp6N3UIPuzMWUWSbfqhJa7sAqp+ON44TfuslCIKhZc74nLJu
	 1ScOYF0ru9t8eILCk3Xk7hsDrvM1bwDqTMqJnMaQ5YuXMshFrwufwDOUA/iAvEa3B3
	 Ob9S1myIfzUhQ==
Date: Thu, 30 Jul 2026 17:23:09 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Xiang Mei <xmei5@asu.edu>, Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ryoga Saito <contact@proelbtn.com>,
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
	kys@microsoft.com, stefano.salsano@uniroma2.it,
	justin.iurman@gmail.com
Subject: Re: [PATCH net] seg6: fix NULL deref in
 input_action_end_dx{4,6}_finish() after nf hook
Message-ID: <amtsXXZlig9diWeP@chamomile>
References: <20260720204430.1886091-1-xmei5@asu.edu>
 <20260723100949.4443811e@kernel.org>
 <20260724151100.16b60b15db7c6353b4fedf99@uniroma2.it>
 <CAPpSM+QNoS4VQ51UTM2idgG-V_5cNgJ5rf=k9uN0ya7UR2n27Q@mail.gmail.com>
 <20260730171610.fd26496925644598ab9a3297@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730171610.fd26496925644598ab9a3297@uniroma2.it>

On Thu, Jul 30, 2026 at 05:16:10PM +0200, Andrea Mayer wrote:
> On Tue, 28 Jul 2026 14:49:08 -0700
> Xiang Mei <xmei5@asu.edu> wrote:
> 
> > [snip]
> >
> > You are right. Following your hint, I also found seg6_local_input_core(),
> > which has the same shape. v2 is a series of two patches and covers all
> > five sites:
> >
> > seg6_local.c:
> >   seg6_local_input_core()        LOCAL_IN
> >   input_action_end_dx4_finish()  PRE_ROUTING
> >   input_action_end_dx6_finish()  PRE_ROUTING
> > seg6_iptunnel.c
> >   seg6_input_core()              POST_ROUTING
> >   seg6_output_core()             POST_ROUTING
> 
> Thanks for covering all five sites.
> 
> I ran into this pattern during the MUP v2 review [1] and have been
> working on the skb_ext approach since. My work covers these sites and
> also includes selftests for DNAT. I will post it as an RFC for
> net-next.
> 
> > [snip]
> >
> > So an skb extension really would do it. SKB_EXT_* is refcounted, rides
> > with the skb, and nf_queue leaves it alone. I want to be clear that your
> > suggestion is workable; I just did not take it in this series.
> >
> > My reasoning is scope. It means a new skb_ext type plus an lwtstate
> > reference on every seg6 packet, which feels like net-next material.
> 
> As things stand, preserving state across the hook needs new machinery,
> so type-check and drop is a reasonable fix for net.
> 
> > There is also one open question. I want your view on it, and that of
> > the other maintainers.
> >
> > Say a DNAT rule in PRE_ROUTING rewrites the inner packet's destination,
> > and End.DX4 then runs with its state preserved. Then which one is intended:
> >
> > 1) send the packet to slwt->nh4, the nexthop from the SRv6 route.
> >      This ignores the DNAT rule the admin installed.
> >
> >  2) route on the new destination instead. This ignores the nexthop the
> >      SRv6 route asked for.
> >
> > v2 does neither. It drops the packet. If you have a suggestion for
> > this, I can do it in v3.
> 
> For net, dropping is the safe choice. Before the fix, the same scenario
> panics the kernel (NULL deref), so a clean drop is not a regression.
> I will look at v2.

I would go for dropping the packet too, it is a simple fix for this crash.

> With the lwtstate preserved (e.g., the skb_ext approach), the existing
> code already handles both cases. Indeed, End.DX4 does
> nhaddr = slwt->nh4.s_addr ?: iph->daddr, so a configured nexthop takes
> precedence over the rewritten address, while an unconfigured one lets
> the DNAT destination drive the lookup. End.DX6 follows the same pattern
> through seg6_lookup_nexthop.

What is the usecase for a hook to clear lwtstate information?

> > I left the "different instance of the same type" case alone for the same
> > reason. The type test passes, and the behavior uses another route's
> > parameters. It is wrong, but it is not a memory bug, and it predates the
> > crash.
> 
> Without saving the original lwtstate before NF_HOOK, in theory there is
> no guarantee that the instance is the same after the hook returns. The
> skb_ext approach addresses this too, since it preserves the original
> lwtstate rather than re-reading it from the current dst.
> 
> [1] https://lore.kernel.org/netdev/20260516182556.66af27a9c63208435911990b@uniroma2.it/
> 
> > Thanks again,
> > Xiang
> 
> Thanks,
> 
> Ciao,
> Andrea
