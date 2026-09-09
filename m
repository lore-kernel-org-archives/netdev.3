Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEAB30BF4F
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 01:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919125; cv=none; b=LxscMSwmR9OXPp3Y0RUfNrzCK89Flo6j0mmTaw3RpZJjhoq80MYT7PKYQ/LV1UO7WV6RQdLt5ZEeDDsEJk9dT15neIsQQ8Hfff9QGruQepkVi+DYcnNFZc25Xs7k+efoOSXWEfjMh7884Fy/t3oikPd1qnNfTqrUJeMG94+m7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919125; c=relaxed/simple;
	bh=gMgDqr6JHKPg2F1GWGpAgIhwBTw+yLFc9ix3NWkBBx8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PhaokVcqo4H6s86XpIFmZUgKv8Emjxql+Qnj06/hhf+wEf6wUkWmzkkFjQbz0V1bMF5BcH0MLE57a7ZsOsP+XF7e3Fr4qq1MsqciPRtLVslt/9jlYdgNnr763gfJFJu3XgJh3h9B4kOKsoySQa+b2q/w2/+W8CWkSwF6CwrjqXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhyn4Nsu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhyn4Nsu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308881F00A3A;
	Wed,  9 Sep 2026 01:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788919122;
	bh=Lz6q4/QAPSE/kp+GYzdCNnZThCcjkjYV1BoWokYtZ0s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jhyn4NsuYD8AjskH8Yiw02lRPfaIUqV4Qhl5Amn4xbLY9MnaPLnlYDxBG1dby5QRF
	 +Hb2k+uKgeVTiSnO0GV5XyUlhYz00e5MfCnfjBwpK6DMpFhqB7OYbCEt/vLc89FGmQ
	 ZSUA9fy7+PTxBna5R/lEf0uWUG5TzpcO+FYDpOOh9yeVBQ9m6HWDnXxx0Nbf2LHk6P
	 t3rVxqykrzTZ9RcbNedeuno8jkpTs16aU0NK7tT3LBhoABbCGXpsWrJbSUMDK+m4x7
	 NSX4AKmZ+falPincWpapLu9XHhMkzpffpmRxLrYHQ1iLLugJyrvaRbT0kpzAo6BoId
	 jTIxHXr88a7iQ==
Subject: Re: [PATCH v1 net-next 7/7] ip_tunnel: Support per-netns device
 unregistration.
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Wed, 09 Sep 2026 01:58:41 +0000
Message-ID: <178891912177.219967.15134714866444953265@kernel.org>
In-Reply-To: <20260907225846.3787676-8-kuniyu@google.com>
References: <20260907225846.3787676-8-kuniyu@google.com>
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

- [High] ip_tunnel_ctl()'s SIOCADDTUNNEL arm can register a brand-new
  netdevice into, and re-hash a tunnel in, an ip_tunnel_net that…

--

ip_tunnel: Support per-netns device unregistration.

This switches __ip_tunnel_dellink() to unregister_netdevice_queue_net() so
ip_tunnel devices living in a different netns than the dying link_net are
queued per-netns, and adds an ip_tunnel_unregistering() guard to the
SIOCCHGTUNNEL and SIOCDELTUNNEL arms of ip_tunnel_ctl(), to
ip_tunnel_dellink() and to ip_tunnel_changelink().

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 9ad63f1af37a6..051d7fd689029 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c

[ ... ]

> @@ -895,20 +900,22 @@ static void ip_tunnel_update(struct ip_tunnel_net *itn,
>  	netdev_state_change(dev);
>  }
>  
> -static void __ip_tunnel_dellink(struct net_device *dev, struct list_head *head)
> +static void __ip_tunnel_dellink(struct net *net, struct net_device *dev,
> +				struct list_head *head)
>  {
>  	struct ip_tunnel *tunnel = netdev_priv(dev);
>  	struct ip_tunnel_net *itn;
>  
>  	itn = net_generic(tunnel->net, tunnel->ip_tnl_net_id);
>  	ip_tunnel_del(itn, tunnel);
> -	unregister_netdevice_queue(dev, head);
> +	unregister_netdevice_queue_net(net, dev, head);
>  }
>  
>  int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
>  		  int cmd)
>  {
>  	struct ip_tunnel *t = netdev_priv(dev);
> +	struct net *orig_net = dev_net(dev);
>  	struct ip_tunnel_net *itn;
>  	LIST_HEAD(dev_kill_list);
>  	struct net *net = t->net;
> @@ -979,7 +986,7 @@ int ip_tunnel_ctl(struct net_device *dev, struct ip_tunnel_parm_kern *p,
>  			}
>  		}
>  
> -		if (t) {
> +		if (t && !ip_tunnel_unregistering(t)) {
>  			err = 0;
>  			ip_tunnel_update(itn, t, dev, p, true, 0);
>  		} else {

[Severity: High]
The SIOCCHGTUNNEL arm now consults ip_tunnel_unregistering(), and so do
SIOCDELTUNNEL, ip_tunnel_dellink() and ip_tunnel_changelink().  Should the
creation arm just above in ip_tunnel_ctl() get an equivalent check?  It is
the only path that mutates itn and registers a device with no liveness test:

net/ipv4/ip_tunnel.c:ip_tunnel_ctl() {
	...
	itn = net_generic(net, t->ip_tnl_net_id);   /* net == t->net */
	...
		t = ip_tunnel_find(itn, p, itn->type);

		if (cmd == SIOCADDTUNNEL) {
			if (!t) {
				t = ip_tunnel_create(net, itn, p);
	...
}

ip_tunnel_create() -> __ip_tunnel_create() does dev_net_set(dev, net) plus
register_netdevice(), then ip_tunnel_add(itn, nt) re-populates the hash.

Can that happen after ip_tunnel_delete_net() has already made its final
pass over the same itn?  With CONFIG_DEBUG_NET_SMALL_RTNL=y, this is the
sequence the commit message itself demonstrates with gre1:

cleanup_net()
  ops_undo_list() -> ipgre_exit_rtnl(ns2)
    ip_tunnel_delete_net(ns2)
      WRITE_ONCE(itn->fb_tunnel_dev, NULL);
      __ip_tunnel_dellink(ns2, gre1, head)
        unregister_netdevice_queue_net(ns2, gre1, head)

Since dev_net(gre1) is ns1 and not ns2, unregister_netdevice_queue_net()
only queues the device:

net/core/dev.c:unregister_netdevice_queue_net() {
	...
	list_add_tail(&dev->unreg_list_net, &net->dev_unreg_head);
	rtnl_net_queue_work(net);
	...
}

so gre1 stays registered after ops_exit_rtnl_list() drops RTNL, exactly as
the bpftrace output shows (gre1 is torn down later from
rtnl_net_work_func).  While it is still registered, an ioctl in ns1 can
reach ip_tunnel_ctl(gre1, p, SIOCADDTUNNEL) holding only
rtnl_net_lock(ns1):

dev_ioctl() -> dev_ifsioc() -> dev_siocdevprivate()
  -> ip_tunnel_siocdevprivate() -> ndo_tunnel_ctl -> ip_tunnel_ctl()

ip_tunnel_ctl() then uses net = t->net = ns2 and itn = net_generic(ns2, id),
the itn that was just drained.  ip_tunnel_find() returns NULL on the empty
hash, so a new device is registered into ns2 and hashed into that itn.

Does anything reclaim that device afterwards?  The last sweep of ns2's
device list is in default_device_exit_batch():

net/core/dev.c:default_device_exit_batch() {
	...
	unregister_netdevice_many(&dev_kill_list);
	rtnl_unlock();

	rtnl_net_flush_workqueue();
	...
}

The scan and rtnl_unlock() precede rtnl_net_flush_workqueue(), and gre1's
unregistration is still pending at that point, so an ioctl winning RTNL in
that gap can create a device in ns2 after the final sweep.  ops_free_list()
would then kfree() ns2's ip_tunnel_net while the new tunnel is hashed in
it, and cleanup_net() would free ns2's net->gen and struct net while a
registered netdevice still points at them through dev_net()/dev_list, since
netdevices hold no netns reference.

The per-tunnel guard added here, hlist_unhashed(&t->hash_node), cannot
cover a tunnel that does not exist yet.  Would a separate "this itn is
dying" test work here, for instance keying off the marker
ip_tunnel_delete_net() already publishes with
WRITE_ONCE(itn->fb_tunnel_dev, NULL)?

[ ... ]

> @@ -1194,7 +1204,7 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
>  		struct ip_tunnel *t;
>  
>  		hlist_for_each_entry_safe(t, n, thead, hash_node)
> -			__ip_tunnel_dellink(t->dev, head);
> +			__ip_tunnel_dellink(net, t->dev, head);
>  	}
>  
>  	mutex_unlock(&itn->tunnels_lock);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907225846.3787676-1-kuniyu%40google.com
