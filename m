Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE763E63AA
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 02:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789094670; cv=none; b=OS85S6NlP/eTPtoEMbs8lc+6gv6yy0CP9s9pJjQ6ehhK32KbqjIm95vldRXW2Jlf+86YYShmQ+YHvhl/9A9me5uNEOGkrxzBu1487qIQ2Zi8frLkOdkNDnW2U6vG/iudfZwGWGmSsE+38zkc7iWRm5HqyaMVB6BzYdF7UINib6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789094670; c=relaxed/simple;
	bh=q0T7KSoMvzWce4yYqzIQfBdIiA/Pouy0ii1az/yI7DE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A+DBEGWAPJR+FR7kzjm/lhwOyEbZZ/fGFX1ULcPmBrrEUYI3xkxn230DpkMyJ1IatezcRFLdBIDd8fBW8SxDEEAOaMctT3DAdoKETnjo5o1+KY55o8dQImk6LtaXu5xck6aL/hU6fgpSRoI78v4rARhlqv0oT9+hXI4S/IwskEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGz3N/9p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGz3N/9p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92921F000FF;
	Fri, 11 Sep 2026 02:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789094666;
	bh=CSXwYmMdbbSlMrZ5kOVXAyWGSwPp4HZHBFvclQjJmG8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aGz3N/9pJIMwdHoY8pRppN+slLTo0YRKXtEqqh/2JIlc9QDbyVG9EKCzr7t4pGvTT
	 lTnNGN8j98RJ0F/BjdDZzVSEFzqV6H4KH/2xi1HcCLsKWyKZ/liy/bgn61P6Kg8POB
	 UTp+QNj1Fks0LwyNiUrsVQSwHaD0dd5rOQe+taOTHLVYJMZNuACJI+yaZ/6famGFcw
	 sLTlK7JFcGJdSMqum6MjAodMp6OOkKDbN2HvSld72ZIRscU8lwp7OIbIkIJ+Colif/
	 kDd9c8yikxze5q7XzRWGacv7rTaXEbkXOrDO+uE0cXtLYQ2w9BVH87Pr/zFGCOfYHo
	 BErYpzzQHMusQ==
Subject: Re: [PATCH v2 net-next 7/7] ip_tunnel: Support per-netns device
 unregistration.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Fri, 11 Sep 2026 02:44:25 +0000
Message-ID: <178909466550.219967.12590792953773467699@kernel.org>
In-Reply-To: <20260909234422.2416506-8-kuniyu@google.com>
References: <20260909234422.2416506-8-kuniyu@google.com>
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

- [High] In `ip_tunnel_ctl()` (net/ipv4/ip_tunnel.c:930-933) the newly
  added gate `if (!itn->fb_tunnel_dev) { err = -EBUSY; goto done; }`…

--

ip_tunnel: Support per-netns device unregistration.

This switches __ip_tunnel_dellink() to unregister_netdevice_queue_net() so
ip_tunnel_delete_net() can queue cross-netns devices for per-netns
unregistration, and adds ip_tunnel_unregistering() checks so
ip_tunnel_changelink()/ip_tunnel_dellink()/ip_tunnel_ctl() skip devices
that are already queued.  It also adds a NULL check on itn->fb_tunnel_dev
in ip_tunnel_ctl().

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 9ad63f1af37a6..b07cc453e28be 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c

[ ... ]

> @@ -920,6 +927,11 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
>  
>  	mutex_lock(&itn->tunnels_lock);
>  
> +	if (!itn->fb_tunnel_dev) {
> +		err = -EBUSY;
> +		goto done;
> +	}
> +

[Severity: High]
Is itn->fb_tunnel_dev == NULL a reliable indicator that the netns is
dying?

ip_tunnel_init_net() leaves fb_tunnel_dev permanently NULL for a perfectly
live netns:

net/ipv4/ip_tunnel.c:ip_tunnel_init_net() {
	...
	if (!ops || !net_has_fallback_tunnels(net)) {
		struct ip_tunnel_net *it_init_net;

		it_init_net = net_generic(&init_net, ip_tnl_net_id);
		itn->type = it_init_net->type;
		itn->fb_tunnel_dev = NULL;
		return 0;
	}
	...
}

net_has_fallback_tunnels() returns false for all non-init netns when
net.core.fb_tunnels_only_for_init_net == 1, and for every netns including
init_net when it is 2 (or the fb_tunnels=none boot arg is used).  That
sysctl is mode 0644 in net/core/sysctl_net_core.c, so it is runtime
settable.

In those configurations, does this new gate make all four legacy ioctls
fail with -EBUSY on ipip/gre/gretap/erspan/vti devices?  On the parent
commit, with fb_tunnel_dev == NULL:

  - SIOCGETTUNNEL skips the "dev == itn->fb_tunnel_dev" branch and does
    memcpy(p, &t->parms, sizeof(*p)) with t = netdev_priv(dev)
  - SIOCADDTUNNEL reaches ip_tunnel_create(net, itn, p), which only needs
    itn->rtnl_link_ops (assigned before the early return above)
  - SIOCCHGTUNNEL takes the "dev != itn->fb_tunnel_dev" branch
  - SIOCDELTUNNEL reaches __ip_tunnel_dellink()

The path is reachable per device without any fallback device existing,
since ipgre_netdev_ops, ipip_netdev_ops and vti_netdev_ops all install
.ndo_siocdevprivate = ip_tunnel_siocdevprivate:

ioctl(fd, SIOCGETTUNNEL, {ifr_name="gre1"})
  -> ip_tunnel_siocdevprivate()
    -> dev->netdev_ops->ndo_tunnel_ctl(dev, &p, cmd)
      -> ip_tunnel_ctl()

So does "ip tunnel show/add/change/del" on a netlink-created device stop
working after this change when fallback tunnels are disabled?  The
SIOCGETTUNNEL branch has no capability check, so this is reachable
unprivileged as well.

Is the gate needed for NULL-safety at all?  Every remaining dereference
of itn->fb_tunnel_dev inside ip_tunnel_ctl() is guarded by a
"dev == itn->fb_tunnel_dev" comparison, so its only role appears to be the
dying-netns policy described in the commit message.

Would an explicit "itn is being destroyed" flag (or the
ip_tunnel_unregistering() semantics added by this same patch) work better
here, given that fb_tunnel_dev == NULL cannot distinguish "this netns
never had a fallback device" from "this netns is going away"?

Other in-tree code already treats a NULL fb_tunnel_dev as a normal state
for a healthy netns:

net/ipv4/ip_vti.c:vti_init_net() {
	...
	itn = net_generic(net, vti_net_id);
	if (itn->fb_tunnel_dev)
		vti_fb_tunnel_init(itn->fb_tunnel_dev);
	...
}

>  	switch (cmd) {
>  	case SIOCGETTUNNEL:
>  		if (dev == itn->fb_tunnel_dev) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909234422.2416506-1-kuniyu%40google.com
