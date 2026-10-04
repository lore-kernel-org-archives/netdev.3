Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693741F348
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791154944; cv=none; b=ntD1+ElsSnqXM7Tqf0ZrzY0wu/dZBZSWDzKcE6fLqnHLQTlxvnfkvTZq41tokSo0IrvoOJ1sPvljHwa5FKizeWjusi4G4IvR2VVWPI3GNfPbdZi8eCnefTbtGcwsdQc49SbFIZxnNCvOfrU6l2G91AFG9BSMmS5y3RR9tFCx9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791154944; c=relaxed/simple;
	bh=IWFMpSmEs64GMhJSU/QWeoGO+s6FIikpgeHx6V80Z7A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tIAO0dzEVnXUxcHlhVwh6KvtSDdjWxeVbKVy/pMB5mMnOzEO4sjpdoU7JWRqqDXfYwzlBj7iI/jlTlGXIe30UYqfglG+WpawEzgOjQDj7tlY28Opokog/1txQxlyUbp1c9q4frLNgwBTEfPZRZ8Pf+RkC0W5bYVCALf53KMYGAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMRcZOLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMRcZOLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6BB1F00893;
	Sun,  4 Oct 2026 23:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791154942;
	bh=PF6ZldOhE4EtYRZ5ARAbrZrZchjK2h+8z0yDyRo1A5Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IMRcZOLDjus/Y1FWV/8I53gHwOcMJ+0DZo9Np+NnlBrTc2bcwrMzxsaITxIX85BYQ
	 2g0+gbylpB3of08bDxE67Vc4bOSO/6I2IdoTbrapkBmTuSp3MbM7tu3enSN5IEJH8L
	 LOC2yru0FR5MdZqJK0v98hPfiH+Vn6PHX8WGa+ENWiwc5CPHN0X+NYeonJvwCcioCm
	 nTfdL55QzOLRz2zgTFbvVmEAmX3jV6v0sYJCf1YqEZZQJyQqvp/kf2qyxP3BYzu2X7
	 0PLjqjLc/DYwhp+MLRJLafNHIg/APnPycqZ4tgb9ZReGbwQBEfOtaT0kaL9vuo6fUS
	 i5nwSl25hbpgg==
Subject: Re: [PATCH v3 net-next 2/6] ipv4: Inline inet_blackhole_dev_init() to
 devinet_init().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: dsahern@kernel.org, idosch@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, carges@cloudflare.com, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Sun, 04 Oct 2026 23:02:21 +0000
Message-ID: <179115494132.434549.9428418689627598557@kernel.org>
In-Reply-To: <20261001204752.2572265-3-kuniyu@google.com>
References: <20261001204752.2572265-3-kuniyu@google.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In net/ipv4/devinet.c, devinet_init() now panics when
  inetdev_init(blackhole_netdev) returns an ERR_PTR.

Pre-existing issues:
- [Low] If alloc_netdev() fails in blackhole_netdev_init()
  (drivers/net/loopback.c, subsys_initcall_sync), the function returns…

--

ipv4: Inline inet_blackhole_dev_init() to devinet_init().

This commit removes the late_initcall inet_blackhole_dev_init(). The
in_device for blackhole_netdev is now allocated directly from
devinet_init(), because blackhole_netdev is allocated before inet_init().

> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index e84d3cf922474..2ed4c706ca9e3 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -340,18 +340,6 @@ static void inetdev_destroy(struct in_device *in_dev)
>  	in_dev_put(in_dev);
>  }
>  
> -static int __init inet_blackhole_dev_init(void)
> -{
> -	struct in_device *in_dev;
> -
> -	rtnl_lock();
> -	in_dev = inetdev_init(blackhole_netdev);
> -	rtnl_unlock();
> -
> -	return PTR_ERR_OR_ZERO(in_dev);
> -}
> -late_initcall(inet_blackhole_dev_init);
> -

[ ... ]

> @@ -2974,4 +2962,9 @@ void __init devinet_init(void)
>  		panic("Unable to register inet_af_ops\n");
>  
>  	rtnl_register_many(devinet_rtnl_msg_handlers);
> +
> +	rtnl_lock();
> +	if (IS_ERR(inetdev_init(blackhole_netdev)))
> +		panic("IP: failed to allocate in_device for blackhole_netdev\n");

[Severity: Low]
This isn't a bug, but should the commit message say that this failure is
now fatal?

The removed inet_blackhole_dev_init() returned PTR_ERR_OR_ZERO(in_dev).
On an inetdev_init() failure, the initcall core only logged the error,
and boot continued with blackhole_netdev->ip_ptr still NULL. After this
change, the same failure panics.

Panicking here matches how devinet_init() already handles a
rtnl_af_register() failure a few lines above. The only ways this call can
fail are the kzalloc_obj() and neigh_parms_alloc() allocations in
inetdev_init(). Even so, the commit message only says:

    Let's inline inet_blackhole_dev_init() to devinet_init().

Could a sentence be added noting that an allocation failure here now
panics instead of being ignored?

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch, but
what happens if blackhole_netdev is NULL at this point?

drivers/net/loopback.c:blackhole_netdev_init() {
	blackhole_netdev = alloc_netdev(0, "blackhole_dev", NET_NAME_UNKNOWN,
					blackhole_netdev_setup);
	if (!blackhole_netdev)
		return -ENOMEM;
	...
}

The initcall core ignores that -ENOMEM, so blackhole_netdev stays NULL.
inetdev_init() then dereferences it through dev_net(dev) on its first
line. That would oops before the new panic message is printed.

The removed late_initcall had no NULL check either, and addrconf_init()
also calls ipv6_add_dev(blackhole_netdev) without one. This patch just
moves an existing early-boot crash from late_initcall time to fs_initcall
time.

> +	rtnl_unlock();
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001204752.2572265-1-kuniyu%40google.com
