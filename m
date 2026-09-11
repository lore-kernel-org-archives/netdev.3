Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B393DB314
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789094665; cv=none; b=r2Ozgv2rftc9mmN6BMcmxV2Q6iVIgFY3qgSsRUxLyZj6RG7vOz8BI3VVQpqyowwvK8jAzzGdTCTqQLXlnIYMi4+v8PlQvjpdEphs6RgFI2Lz4uJzv+HI4i7bEhrZY6p1KRblc68zJ0A3XHBrvr/1E1rMYgIadHZz7Sy7Tb65LoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789094665; c=relaxed/simple;
	bh=fAwUJoCmYMbvm9CSWKZ5CUdl7hcUlR04nODsoHKGXA0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e5Jq+R3c+sk5PiTEZFTh/d5MwnVYzYHtHetn39mlV+YZpz6OZrNDAPnl3w2B30JQYboNWF6DDHK+5/wdLEeF6j22e1bMNfTGhnU29ijMWtEueloP40/ozPL3X+exc6KLq/uzhsdE00irSCTmn7XSWMEEEdovjeVjHdQfNqMFmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zsg/5zmj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zsg/5zmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8029A1F000FF;
	Fri, 11 Sep 2026 02:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789094664;
	bh=POsGfKjEdVegCkv9peR0SVsCCnv3LUIezWvezv9DMBk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Zsg/5zmjWrK4iC1WgN9zvHyXh69E5LVmwxPKoLa6XThqW7cLXgrKc2P/Q8C1M5E4z
	 iAEEDbIoHBhrPtuwWFoc842HOGkY+Nw8RJ3d9PJ+jdwkNfi+f63QUT87L/gUAqkVxV
	 btOTnfLtG5ZGgE7W9Wgch+g4NB+jqwsloLjbzxKlXonq3HX3YzAapux4ixQIHQW9yR
	 nTEHM4G6VgX9jbEvah5GU1WDxGprQPlimS1HynW4YH7Qc+7MWQLcx3g6gXUwK8njIe
	 rXrjPAdaB1j+yPO/iHBHn/Z/+z+/t0bLLHJyKAs3zWErN+ctrEKpNzJlpE0u/XM4vk
	 WdXrZwHuYGeXg==
Subject: Re: [PATCH v2 net-next 2/7] ip_tunnel: Set itn->fb_tunnel_dev to NULL
 in ip_tunnel_delete_net().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au, kuni1840@gmail.com,
 netdev@vger.kernel.org
Date: Fri, 11 Sep 2026 02:44:23 +0000
Message-ID: <178909466302.219967.15497824001043211205@kernel.org>
In-Reply-To: <20260909234422.2416506-3-kuniyu@google.com>
References: <20260909234422.2416506-3-kuniyu@google.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Commit message omits two behavioural changes that the diff
  makes to net/ipv4/ip_tunnel.c.

--

ip_tunnel: Set itn->fb_tunnel_dev to NULL in ip_tunnel_delete_net().

This drops the for_each_netdev_safe() loop from ip_tunnel_delete_net() and
instead clears itn->fb_tunnel_dev there, so the unconditional hash walk can
queue every tunnel, including the fallback device.  The matching
fb_tunnel_dev clearing in ip_tunnel_uninit() is removed.

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index e6bcf01411d0b..d29e2ba7cdd3a 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -1155,26 +1155,19 @@ void ip_tunnel_delete_net(struct net *net, unsigned int id,
>  			  struct list_head *head)
>  {
>  	struct ip_tunnel_net *itn = net_generic(net, id);
> -	struct net_device *dev, *aux;
>  	int h;
>  
>  	ASSERT_RTNL_NET(net);
>  
> -	for_each_netdev_safe(net, dev, aux)
> -		if (dev->rtnl_link_ops == ops)
> -			unregister_netdevice_queue(dev, head);
> +	WRITE_ONCE(itn->fb_tunnel_dev, NULL);

[Severity: Medium]
Could the changelog say something about the devices that only the removed
for_each_netdev_safe() loop covered?

The loop walked devices by residence (dev_net(dev) == net), while the hash
walk below covers devices by tunnel->net, i.e. the netns the ip_tunnel is
hashed in.  Those two differ when IFLA_LINK_NETNSID is used, because
ipgre_newlink() and friends pass params->link_net into ip_tunnel_newlink():

    ip -n ns1 link add gre1 link-netns ns2 type gre local X remote Y
    ip netns del ns1

Here gre1 lives in ns1 but is hashed in ns2's itn, so after this change
ip_tunnel_delete_net(ns1) does not see it and its removal is deferred to
net/core/dev.c:default_device_exit_batch():

    if (dev->rtnl_link_ops && dev->rtnl_link_ops->dellink)
            dev->rtnl_link_ops->dellink(dev, &dev_kill_list);

I traced that path and the device does get unregistered there (ipgre_link_ops
does not set netns_refund, so default_device_exit_net() leaves it alone and
the second loop calls ->dellink()), so this looks like a teardown ordering
change rather than a leak.

But it is the same path the changelog describes as unusable:

  "This also makes default_device_exit_batch() impossible to remove
   the device since it calls ->dellink()."

Since itn->fb_tunnel_dev is NULL by then, ip_tunnel_dellink() no longer skips
the device, so the statement holds only for the fallback device before the
netns is dying.  Would it be worth spelling out that teardown of tunnels
resident in the dying netns but hashed in another netns' itn now relies on
default_device_exit_batch()?

>  	for (h = 0; h < IP_TNL_HASH_SIZE; h++) {
> -		struct ip_tunnel *t;
> -		struct hlist_node *n;
>  		struct hlist_head *thead = &itn->tunnels[h];
> +		struct hlist_node *n;
> +		struct ip_tunnel *t;
>  
>  		hlist_for_each_entry_safe(t, n, thead, hash_node)
> -			/* If dev is in the same netns, it has already
> -			 * been added to the list by the previous loop.
> -			 */
> -			if (!net_eq(dev_net(t->dev), net))
> -				unregister_netdevice_queue(t->dev, head);
> +			unregister_netdevice_queue(t->dev, head);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(ip_tunnel_delete_net);
> @@ -1310,8 +1303,6 @@ void ip_tunnel_uninit(struct net_device *dev)
>  
>  	itn = net_generic(net, tunnel->ip_tnl_net_id);
>  	ip_tunnel_del(itn, netdev_priv(dev));
> -	if (itn->fb_tunnel_dev == dev)
> -		WRITE_ONCE(itn->fb_tunnel_dev, NULL);
>  
>  	dst_cache_reset(&tunnel->dst_cache);
>  }

[Severity: Medium]
This hunk partially reverts ba61539c6ae5 ("ip_tunnel: fix use-after-free in
ip_tunnel_lookup()"), and the changelog does not mention it.  Should the
reason the guard is now redundant be recorded somewhere?

As far as I can tell the new code depends on the invariant that a fallback
device can only ever be unregistered from ip_tunnel_delete_net():

  - ip_tunnel_dellink() skips it while itn->fb_tunnel_dev is set
  - ip_tunnel_ctl() refuses SIOCDELTUNNEL on it with -EPERM
  - ip_tunnel_init_net() sets netns_immutable = true, so it cannot move

That invariant does hold at this commit, so I did not find a live
use-after-free.  Two related points though:

net/ipv6/ip6_gre.c and net/ipv6/sit.c still clear fb_tunnel_dev from their
uninit paths, so the two families now differ without an explanation.

And ip_tunnel_init_net() adds the fallback device to itn->tunnels:

    ip_tunnel_add(itn, netdev_priv(itn->fb_tunnel_dev));

so the hash walk in ip_tunnel_delete_net() queues it directly anyway.  Is the
statement

  "So, ip_tunnel_delete_net() has to iterate devices in the dying netns
   and call unregister_netdevice_queue() directly."

still accurate as a description of what the fallback device needs, given the
device is reachable through the hash?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909234422.2416506-1-kuniyu%40google.com
