Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B42C41685B;
	Sat, 10 Oct 2026 05:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791610999; cv=none; b=K3gw6PcdcZwy91qVWS4+Q8pPosp4tvGkgW6BpKBxOolcrWp8IvhEebFWiHsD988J4ScCAYqyWe6cajhw91d5e0K74DyIzDt+GXEXgC/kR26Jl5TKvQC4RZ8SiWr3hdGLcE6TdUc2FcU8wxNAxP3AToKPHu+9gmbRU+geN/6nTIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791610999; c=relaxed/simple;
	bh=8BhOSnSMCRkF3FQEx0oTAwy5ksfS2nVozJ7vYVBCq3g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jz7hsAti2lmQE66Bvgzd9/lcAnvuxZUV3uyjG2P99hvjCQ84bcwDFnBWTwvIxNt9mzsMpfdE4Hz10Va53htuY9jB0ST5ld8Vpq5idKWi3qqD1HOJVQtI47/3A7cD7vZzW3V6NVHztCw5lut6QHEdqjpiD5uww2/OsTl5i5/96gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhIQZOtJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhIQZOtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251A71F00898;
	Sat, 10 Oct 2026 05:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791610997;
	bh=bC/XxRo9bENL0ZUgs308rvTZG0rWTKpDwqPA9XVdEYs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BhIQZOtJYPWK+/qTRAjRDFeuDuVUxIVxcg8Cdyv5w+xBIbozaihQ4+yZhBAlR/1yJ
	 Qe3ssAbZe1NkxcR111lNSSeiCA0niELDE/08YISAcncrvt/7z01xD1hz3hf96xDA1o
	 5Ougvz49K6FMaLIpNoc8D8sjlJyn8FYb3oSp3anERr1K329TCNxU2Vy7cIF138dYtC
	 w0PDcRzK9Ajp3ATbD21qHHoUZAlAZuxFD+JpB2Z3H5Y65+8n/VmcTAWWMq0Zf8bzoI
	 m2XTgs8cJkDmfqLvib8W3kdsnZ8VtbPJKxxXjMUJsftdUj+Yk163731cL/3pzfLDCK
	 jOIa9gnoFlv0w==
Subject:
 Re: [PATCH net v3 3/3] ipv6: initialize temporary ifaddr before publication
From: netdev-bot+sashiko@kernel.org
To: 4ncienth@gmail.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 05:43:16 +0000
Message-ID: <179161099665.434549.5858601179492551889@kernel.org>
In-Reply-To: <20261009054042.272944-4-4ncienth@gmail.com>
References: <20261009054042.272944-4-4ncienth@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch makes the temporary ifaddr visible to
  manage_tempaddrs() before ipv6_create_tempaddr() has finished setting…

--

ipv6: initialize temporary ifaddr before publication

This patch passes the public ifaddr to ipv6_add_addr() through
ifa6_config, so ift->ifpub is set before the temporary address goes on
the hash and per-device lists. That closes a window where
addrconf_ifdown() could remove the temporary address while ifpub was
still NULL and leak the public ifaddr reference.

Link: https://lore.kernel.org/r/20261007164548.GA1153540@shredder

> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 5a7e7129d4346..699d058f5c786 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1159,6 +1159,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>  	ifa->tokenized = false;
>  
>  	ifa->rt = f6i;
> +	ifa->ifpub = cfg->ifpub;
>  
>  	ifa->idev = idev;
>  	in6_dev_hold(idev);

[ ... ]

> @@ -1504,7 +1506,6 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp, bool block)
>  	}
>  
>  	spin_lock_bh(&ift->lock);
> -	ift->ifpub = ifp;
>  	ift->cstamp = now;
>  	ift->tstamp = tmp_tstamp;
>  	spin_unlock_bh(&ift->lock);

[Severity: Medium]

Now that ifpub is set before publication, can manage_tempaddrs() find the
new ift before these cstamp and tstamp stores run?

Before this patch, ifpub stayed NULL until this ift->lock section.
manage_tempaddrs() skips entries that don't match ifpub, so it ignored the
new address until all three fields were final:

net/ipv6/addrconf.c:manage_tempaddrs() {
    ...
	list_for_each_entry(ift, &idev->tempaddr_list, tmp_list) {
		...
		if (ifp != ift->ifpub)
			continue;
    ...
		ift->valid_lft = valid_lft;
		ift->prefered_lft = prefered_lft;
		ift->tstamp = now;
    ...
}

There is now a window between write_unlock_bh(&idev->lock) in
ipv6_add_addr() and the spin_lock_bh(&ift->lock) above. The NETDEV_UP
inet6addr notifier chain also runs inside this window.

The RA softirq path does not hold RTNL. It doesn't seem to be serialized
against ipv6_create_tempaddr() callers such as addrconf_verify_rtnl() or
addrconf_dad_stop():

CPU1
ipv6_create_tempaddr(ifp)
  tmp_tstamp = ifp->tstamp;
  ipv6_add_addr()
    ift published with ift->ifpub == ifp

CPU2 (RA softirq)
addrconf_prefix_rcv_add_addr()
  WRITE_ONCE(ifp->tstamp, now);
  manage_tempaddrs(in6_dev, ifp, valid_lft, prefered_lft, create, now)
    ift->valid_lft = valid_lft;
    ift->prefered_lft = prefered_lft;
    ift->tstamp = now;

CPU1
  ift->cstamp = now;
  ift->tstamp = tmp_tstamp;

Would ift then have lifetimes computed relative to CPU2's now, but a
tstamp taken from the older tmp_tstamp?

If so, the temporary address loses (now - tmp_tstamp) seconds of preferred
and valid lifetime. addrconf_verify() would then deprecate, regenerate or
expire it early.

Could cstamp and tstamp also be set before publication? One way is to
pass the timestamp through ifa6_config, or to set it in ipv6_add_addr()
next to ifpub. Then nothing in ift is written after it becomes reachable.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009054042.272944-1-4ncienth%40gmail.com
