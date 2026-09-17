Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC4C40099B;
	Thu, 17 Sep 2026 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789629495; cv=none; b=ICqN3suo2dbuUeFdk8D8oyOzZQsnLXpFQbdjLmzI8VOYerw84jyIw1rgh4v4VlK81IVld9s6zL9yoRrbXAX6oBAiiwW3Kp08hmMUPYiUjjrz1pxGzJtXry7zKUJ0iH/YNVga5qSVs6VP+oXcn+hUKSGNlOLMhkOjp5wlj6TW/Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789629495; c=relaxed/simple;
	bh=ZC6md3bmLBgcfp7eJkLqqavkXbJdlcm0uaqZF9bgaik=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u5KY+WrDLeZ1xapz3SeSxIt3Hteo6EVMAnV9y/Lv+GcL5B3ptGLtOCZvgQxqytCpcaKSXV2N0DXjD4sH/MnTcdGyN5gJaXDL8XsXPFVTmLNq19nTStn0VIgBDE1Yke9+WIRe8cCO7QOcV9KH8PGCt97dFTksVBt2hzB4Fglz+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDjdnktF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDjdnktF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BECC1F000FF;
	Thu, 17 Sep 2026 07:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789629494;
	bh=zQn0Kuu3A86UORUXxYi1t9ARAs8CbzOo9YCoZIac5fo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lDjdnktFGXlHE6LGkTeiTM3YVHiuMJHAlavMVTqDhj0Ck+MbWn9MA8Z24GL+33Py7
	 8zoEeClAiTXDmZAf8U+uFEwSG+u0iKqQZI60OQzrqvzrBwDP01qh03E2Puikx4KFnn
	 SdEOiT+Nz+8iKaE3AKZFciPJgHf8akKczfpk/ug/uAM74ZwqRDoZHJiSDKGBcHc8PE
	 WPYvOiECGKRN8VPv7LWyeVeGIIiQHPy7hpz8prJU6Zhk/h6zYWtIlS/px066ElsJvo
	 xzv5OpT/lYYa1UOtBYhRHVCAwk5WSmNMvSBHJgBvc168ef3ndTyKjfb1tAKxeY8NOF
	 13z++SKe9VeCQ==
Subject: Re: [PATCH net v2] ipv4: fib: fix data-race and stale genid check
 around nh->nh_saddr
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn
Date: Thu, 17 Sep 2026 07:18:12 +0000
Message-ID: <178962949299.22033.4111144579519364166@kernel.org>
In-Reply-To: <20260915071503.465875-1-xiaolinkui@126.com>
References: <20260915071503.465875-1-xiaolinkui@126.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] In fib_select_multipath() (net/ipv4/fib_semantics.c), the newly
  added `READ_ONCE(nexthop_nh->nh_saddr_genid) == genid` test treats a…

--

ipv4: fib: fix data-race and stale genid check around nh->nh_saddr

This adds READ_ONCE() to the two lockless reads of nh->nh_saddr and
nh->nh_saddr_genid in fib_select_multipath(), and additionally requires the
cached nh_saddr_genid to equal a snapshot of net->ipv4.dev_addr_genid before
the source-address match can add its scoring bonus.  The stated intent is to
mirror fib_result_prefsrc().

> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
> index 7a362f2e2c2bd..e2bfc11aea09c 100644
> --- a/net/ipv4/fib_semantics.c
> +++ b/net/ipv4/fib_semantics.c
> @@ -2192,6 +2193,7 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  
>  	use_neigh = READ_ONCE(net->ipv4.sysctl_fib_multipath_use_neigh);
>  	saddr = fl4 ? fl4->saddr : 0;
> +	genid = saddr ? atomic_read(&net->ipv4.dev_addr_genid) : 0;
>  
>  	change_nexthops(fi) {
>  		int nh_upper_bound, nh_score = 0;
> @@ -2204,7 +2206,9 @@ void fib_select_multipath(struct fib_result *res, int hash,
>  		    (use_neigh && !fib_good_nh(nexthop_nh)))
>  			continue;
>  
> -		if (saddr && nexthop_nh->nh_saddr == saddr)
> +		if (saddr &&
> +		    READ_ONCE(nexthop_nh->nh_saddr_genid) == genid &&
> +		    READ_ONCE(nexthop_nh->nh_saddr) == saddr)
>  			nh_score += 2;

[Severity: High]
Does this genid check turn a cache miss into a permanent disqualification,
so that the source-address preference from 32607a332cfe stops working after
any address event in the netns?

The function the commit message says is being mirrored treats a genid
mismatch as a miss and repopulates the cache:

net/ipv4/fib_semantics.c:fib_result_prefsrc() {
	...
		if (READ_ONCE(nh->nh_saddr_genid) ==
		    atomic_read(&net->ipv4.dev_addr_genid))
			return READ_ONCE(nh->nh_saddr);
	}

	return fib_info_update_nhc_saddr(net, nhc, res->fi->fib_scope);
}

fib_select_multipath() has no such fallback: on mismatch the nexthop simply
loses nh_score += 2, and nothing recomputes nh_saddr for it.

nh_saddr_genid is only stamped in fib_create_info() (once per fib_info at
route creation, for all nexthops), at nexthop object creation in
net/ipv4/nexthop.c, and by fib_result_prefsrc() for res->nhc alone.
Meanwhile dev_addr_genid is a per-netns counter bumped for any IPv4 address
event on any device:

net/ipv4/fib_frontend.c:fib_inetaddr_event() {
	...
		atomic_inc(&net->ipv4.dev_addr_genid);
		rt_cache_flush(net);

The same pattern appears for NETDEV_DOWN and in fib_netdev_event().  So after
one unrelated ip addr add/del, DHCP renew or NETDEV_UP, every fib_nh in the
netns has a stale nh_saddr_genid, and the accompanying rt_cache_flush()
forces established sockets into fresh lookups that already carry
fl4->saddr != 0.

Is there anything on that path that would refresh the cache?  The only lazy
refresher reachable from here is gated on the opposite condition:

net/ipv4/fib_semantics.c:fib_select_path() {
	...
check_saddr:
	if (!fl4->saddr) {
		...
			fl4->saddr = fib_result_prefsrc(net, res);

That block is skipped exactly when saddr is non-zero, which is the only case
the new check governs, and even when it does run it refreshes res->nhc only,
not the sibling nexthops walked by the scoring loop.  The other caller,
ip_mkroute_input() in net/ipv4/route.c, passes fl4 == NULL, so saddr is 0
there and the check has no effect on forwarding.

With that in place, for every output lookup that already has a source
address (socket bound before connect(), UDP or raw sendmsg with a fixed
source, and the post-flush re-lookups), does the +2 bonus become
unreachable, making nh_score == 3 impossible and reducing selection to plain
hash ECMP?  That would let a flow sourced from veth0's address egress via
veth1, which is the behaviour 32607a332cfe was written to avoid.

Would calling fib_info_update_nhc_saddr() on mismatch, or restricting this
patch to the READ_ONCE() annotations that the KCSAN report actually
justifies, be preferable here?  As it stands the Fixes: tag would carry this
behavioural change into stable.

[Severity: Low]
On the commit message wording:

    fib_info_update_nhc_saddr() stores a new value from another CPU as soon
    as the preferred source address of the egress device changes.

Is that accurate?  fib_info_update_nhc_saddr() is only called on demand
(from fib_result_prefsrc() on a genid mismatch, and at route creation), not
from the address-change notifier itself, which only bumps dev_addr_genid.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915071503.465875-1-xiaolinkui%40126.com
