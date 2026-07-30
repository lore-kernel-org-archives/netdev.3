Received: from smtp.uniroma2.it (smtp-2015.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CEA3DA7ED;
	Thu, 30 Jul 2026 22:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785451888; cv=none; b=IVVOPCyXlIZH4bONUyKnqjKLBrXBwn9Ix0ryMv1RsuYxs6rSz+q8nq7itUsygrSf3DoKiRTejapovujk4BtWE+JkAdGTUv61XLsuQb9T5DjVgtBLk6XYtFdct004IFxhlbag76HBUF/pZyCX0vhk0XVxkNPPDDS/6K+JoxFeMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785451888; c=relaxed/simple;
	bh=/BlB5938A7RRwhWU/2MVQzljKv9ZFGt9z+zd9qSeBhI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ctl6PmgKc4TzcP6/C6fM40Ti061SKeIYDaCznwp7Qxb0mib8zX1jNiQf+bUuahUbfarcms2HuZPeCLSsC0VMtD89F6OrVAgDLVSTW0RTuP0nYU/rHCbBebUELyE5KvB9RvKjx9nbNDOoNDV9i3/yEuqG4lADs0ybnTeg9K0FlmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=ec8xrgkW; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=xv0TyBpr; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="ec8xrgkW";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="xv0TyBpr"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 66UMoa4L020359;
	Fri, 31 Jul 2026 00:50:42 +0200
Received: from lubuntu-18.04 (host-82-61-152-174.retail.telecomitalia.it [82.61.152.174])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 122621208B1;
	Fri, 31 Jul 2026 00:50:32 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1785451832; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vokTv6XUsv2O3YSdSwi5MO6bT8/S9BT6dPhKfA3q7hY=;
	b=ec8xrgkWbR0PPDRg9nynrDFWErFPxi79/HAUzRwBRCdN+V0shoChUOOJ2c0uMhm+iqBD7G
	nvmC3h4qsWfpc3Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1785451832; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vokTv6XUsv2O3YSdSwi5MO6bT8/S9BT6dPhKfA3q7hY=;
	b=xv0TyBprEeSnY+zA5Tl/jLoXw0Ip1XSctDfA+1D52lIUsWYgdQo8YsUpf3QTF3AmnZayEL
	D92WINLlPAwi6XkuI1Ucl2BBQsLg5eLz7Nkwmusi9SOeGEkkc6njUsxiWPoLhQ4GUpAjPc
	5Br1cppe/yG7G8DebOU/z5Sbovs2nIz7C1DtwokPgkDYofIKgCUPn+3/HTJpRtwrCx/hEb
	XHnv2qaBxpZ9OjivOF06w0e3juBvHjaWkfOj5lkKsb3IPWED+1oOYESZblFLxx/rtV0q39
	+aZ/8kFOG1QI5oN/bkdKgrr7LvP5MjS1nZuX7aHqPPq9bYk4oD8c9XPt0amrCQ==
Date: Fri, 31 Jul 2026 00:50:31 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Xiang Mei <xmei5@asu.edu>, Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ryoga Saito <contact@proelbtn.com>,
        AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
        kys@microsoft.com, stefano.salsano@uniroma2.it,
        justin.iurman@gmail.com, Andrea Mayer
 <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] seg6: fix NULL deref in
 input_action_end_dx{4,6}_finish() after nf hook
Message-Id: <20260731005031.9e3cc5752afdbc782fa3b73a@uniroma2.it>
In-Reply-To: <amtsXXZlig9diWeP@chamomile>
References: <20260720204430.1886091-1-xmei5@asu.edu>
	<20260723100949.4443811e@kernel.org>
	<20260724151100.16b60b15db7c6353b4fedf99@uniroma2.it>
	<CAPpSM+QNoS4VQ51UTM2idgG-V_5cNgJ5rf=k9uN0ya7UR2n27Q@mail.gmail.com>
	<20260730171610.fd26496925644598ab9a3297@uniroma2.it>
	<amtsXXZlig9diWeP@chamomile>
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

On Thu, 30 Jul 2026 17:23:09 +0200
Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> [snip]
>
> > For net, dropping is the safe choice. Before the fix, the same scenario
> > panics the kernel (NULL deref), so a clean drop is not a regression.
> > I will look at v2.
>
> I would go for dropping the packet too, it is a simple fix for this crash.
>
> > With the lwtstate preserved (e.g., the skb_ext approach), the existing
> > code already handles both cases. Indeed, End.DX4 does
> > nhaddr = slwt->nh4.s_addr ?: iph->daddr, so a configured nexthop takes
> > precedence over the rewritten address, while an unconfigured one lets
> > the DNAT destination drive the lookup. End.DX6 follows the same pattern
> > through seg6_lookup_nexthop.
>
> What is the usecase for a hook to clear lwtstate information?

Re-routing after NAT. DNAT changes the destination and the dst is dropped.
SNAT changes the source and, with a matching XFRM policy, the dst is
replaced. The lwtstate is not involved, it just lives on the dst.

seg6_local and seg6_iptunnel call NF_HOOK from inside lwtunnel processing,
and their okfns then read the per-route state from skb_dst(skb)->lwtstate.
The relevant part of the configuration that produces the crash:

  # SRv6 ingress node
  ip -4 route add 10.0.0.99/32 \
          encap seg6 mode encap segs fc00:12:100::6004 dev veth0

  # SRv6 egress node
  sysctl -w net.netfilter.nf_hooks_lwtunnel=1
  ip -6 route add fc00:12:100::6004/128 \
          encap seg6local action End.DX4 nh4 10.0.0.2 dev veth-t100
  iptables -t nat -A PREROUTING -d 10.0.0.99 \
          -j DNAT --to-destination 10.0.0.222

End.DX4 decapsulates the inner IPv4 packet, then runs the PRE_ROUTING chain
on it with input_action_end_dx4_finish() as the okfn. The packet enters the
chain with the dst of the SID route still attached. The DNAT rule matches,
so the dst is dropped, and the okfn then dereferences NULL. That dst is
where it reads the lwtstate holding the End.DX4 parameters, nh4 among them.

In seg6_iptunnel the same happens at POST_ROUTING, where the okfns are
seg6_input_core() and seg6_output_core(). With SNAT and a matching XFRM
policy they find a valid dst whose lwtstate is NULL.

In the current tree seg6_local and seg6_iptunnel are the only lwtunnels
that call NF_HOOK, so this is not a general lwtunnel problem. I think the
fix belongs on the SRv6 side.

Ciao,
Andrea
