Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C2151C327
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865261; cv=none; b=izvwcvvBEvyb5/7KJGYT39uNg4D5xTW4zNbA70qdwFUpe6s450UZUq0B9hbUG0VoDrRnpgVGrd2uHwlYN2kM+7TLl6kFh0yIHekyDMosKAb2UvUQSiYn7GLaxhsn0exAXsb+v7df/lsVPqsD0mFxIwub4+/eXVUn+jb7JRoyv7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865261; c=relaxed/simple;
	bh=QmjmzhnTF9yeShJst5IQPnojVYwCDzW7/R481Mm8U/E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8vP/D0ENQveLRFlz4BYoJW8a+z23vHmL0jTVyW8Y6txBqTXQrBb19l0hoGrTxn8JwWqeTguEW2ewJcCiOxDXK38MXbtVBfSgXIxuVO7lDF6QMYFb8w7ABP9ZVd83EoLAEwYrpM/jevnbQj6z0Xv8I4CJEJ7tXQc7Kfo0BqVdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFK2EZ0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFK2EZ0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FE41F00AC4;
	Tue,  8 Sep 2026 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788865257;
	bh=XXoRBcYyTzGTdSnYwilKEX8/viaTQYgmVhLQGTPixYE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oFK2EZ0+pGw/VcQyyi2P9RCUjnsQwbkT3iLkFb+5ye0jMl8aZS32l396oMN8ugdid
	 rOxInvhz9TpNYLqG7OS4lubaRE2ViRB6Z3jq9qgzia7PUIjftkMNJ8efjm27QpmCji
	 oWa/5xs5X7kktSlSa7QgVHw/6ZL5FDqJZLUVUIWR+dgi46ljjDaPMFxdV20ht7moY0
	 E/WF9XIcfGamUA5WIGKWoSmNg+yApYFMOFN8Sl2Jlq9YlulqoS/7byLehzQCZ9TMNA
	 0fCyMz1WeGmixKvM0S3bV7mBzUPe0JfO7ZOiPPrJOhaPYedBVezE4yIqIoRVSfO5bc
	 RiiXJSfK1zoYA==
Subject:
 Re: [PATCH net-next 5/9] sit: convert 6RD configuration to RCU protection
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com,
 lorenzo.bianconi@oss.qualcomm.com, iprintercanon@gmail.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 08 Sep 2026 11:00:56 +0000
Message-ID: <178886525638.219967.1123018385192132296@kernel.org>
In-Reply-To: <20260907075846.2913645-6-edumazet@google.com>
References: <20260907075846.2913645-6-edumazet@google.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] check_6rd() now performs `ip6rd =
  rcu_dereference(tunnel->ip6rd)` (net/ipv6/sit.c:849), but check_6rd()…
- [Low] The patch changes SIOCDEL6RD behaviour beyond the advertised RCU
  conversion: ipip6_tunnel_clone_6rd() now, when an old 6RD…

--

sit: convert 6RD configuration to RCU protection

This converts tunnel->ip6rd from an embedded struct into an RCU protected
pointer, so updates via ipip6_tunnel_update_6rd() and
ipip6_tunnel_clone_6rd() allocate a new struct ip_tunnel_6rd_parm, publish
it with rcu_assign_pointer() and free the old one with kfree_rcu().
Readers in check_6rd(), only_dnatted(), ipip6_tunnel_get6rd() and
ipip6_fill_info() are updated accordingly.

> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index e85fa80e80d1a..7cabcd3afbc4f 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -183,21 +183,47 @@ static void ipip6_tunnel_link(struct sit_net *sitn, struct ip_tunnel *t)
>  	rcu_assign_pointer(*tp, t);
>  }
>  
> -static void ipip6_tunnel_clone_6rd(struct net_device *dev, struct sit_net *sitn)
> +static int ipip6_tunnel_clone_6rd(struct net_device *dev, struct sit_net *sitn)
>  {
>  #ifdef CONFIG_IPV6_SIT_6RD
>  	struct ip_tunnel *t = netdev_priv(dev);
> +	struct ip_tunnel_6rd_parm *new_6rd, *old_6rd;
> +
> +	new_6rd = kmalloc_obj(*new_6rd);
> +	if (!new_6rd)
> +		return -ENOMEM;
>  
>  	if (dev == sitn->fb_tunnel_dev || !sitn->fb_tunnel_dev) {
> -		ipv6_addr_set(&t->ip6rd.prefix, htonl(0x20020000), 0, 0, 0);
> -		t->ip6rd.relay_prefix = 0;
> -		t->ip6rd.prefixlen = 16;
> -		t->ip6rd.relay_prefixlen = 0;
> +		ipv6_addr_set(&new_6rd->prefix, htonl(0x20020000), 0, 0, 0);
> +		new_6rd->relay_prefix = 0;
> +		new_6rd->prefixlen = 16;
> +		new_6rd->relay_prefixlen = 0;
>  	} else {
>  		struct ip_tunnel *t0 = netdev_priv(sitn->fb_tunnel_dev);
> -		memcpy(&t->ip6rd, &t0->ip6rd, sizeof(t->ip6rd));
> +		struct ip_tunnel_6rd_parm *t0_6rd;
> +
> +		t0_6rd = rtnl_dereference(t0->ip6rd);
> +		if (t0_6rd) {
> +			*new_6rd = *t0_6rd;
> +		} else {
> +			ipv6_addr_set(&new_6rd->prefix, htonl(0x20020000), 0, 0, 0);
> +			new_6rd->relay_prefix = 0;
> +			new_6rd->prefixlen = 16;
> +			new_6rd->relay_prefixlen = 0;
> +		}
> +	}
> +
> +	old_6rd = rcu_dereference_protected(t->ip6rd,
> +					    lockdep_rtnl_is_held() ||
> +					    dev->reg_state == NETREG_UNINITIALIZED);
> +	rcu_assign_pointer(t->ip6rd, new_6rd);
> +	if (old_6rd) {
> +		dst_cache_reset(&t->dst_cache);
> +		netdev_state_change(t->dev);
> +		kfree_rcu(old_6rd, rcu);
>  	}
>  #endif
> +	return 0;
>  }

[Severity: Low]
Is the new dst_cache_reset() plus netdev_state_change() in
ipip6_tunnel_clone_6rd() intended as part of this conversion?

Before this patch, the SIOCDEL6RD path did neither:

  ipip6_tunnel_6rdctl()
    ipip6_tunnel_clone_6rd()   /* just overwrote t->ip6rd fields */

Only ipip6_tunnel_update_6rd() invalidated the destination cache and
notified userspace.  Since ipip6_tunnel_xmit() derives the IPv4
destination from the 6RD configuration via try_6rd() and then consults
dst_cache_get_ip4(&tunnel->dst_cache, ...), the added reset changes where
packets go after a 6RD deletion, and netdev_state_change() ->
netif_state_change() emits an extra NETDEV_CHANGE plus RTM_NEWLINK that
link watchers will see.

Would it make sense to split that out into its own patch, with a Fixes:
tag if it is fixing stale routing after SIOCDEL6RD?  The changelog
currently only describes the allocation and publish conversion.

[ ... ]

> @@ -810,25 +844,28 @@ static bool check_6rd(struct ip_tunnel *tunnel, const struct in6_addr *v6dst,
>  		      __be32 *v4dst)
>  {
>  #ifdef CONFIG_IPV6_SIT_6RD
> -	if (ipv6_prefix_equal(v6dst, &tunnel->ip6rd.prefix,
> -			      tunnel->ip6rd.prefixlen)) {
> +	const struct ip_tunnel_6rd_parm *ip6rd;
> +
> +	ip6rd = rcu_dereference(tunnel->ip6rd);
> +	if (ip6rd && ipv6_prefix_equal(v6dst, &ip6rd->prefix,
> +				       ip6rd->prefixlen)) {

[Severity: Medium]
Is plain rcu_dereference() the right accessor here?  The changelog says:

  "Readers in check_6rd() and only_dnatted() use rcu_dereference() under
   existing RCU read lock"

That holds for the receive path, but check_6rd() is also reached from
transmit:

  netdev_start_xmit()
    sit_tunnel_xmit()
      ipip6_tunnel_xmit()
        try_6rd()
          check_6rd()
            rcu_dereference(tunnel->ip6rd)

and the xmit callers do not hold rcu_read_lock().  __dev_queue_xmit()
takes rcu_read_lock_bh(), which acquires rcu_bh_lock_map, and the
AF_PACKET qdisc bypass path __dev_direct_xmit() only does
local_bh_disable():

net/core/dev.c:__dev_direct_xmit() {
	...
	local_bh_disable();

	dev_xmit_recursion_inc();
	HARD_TX_LOCK(dev, txq, smp_processor_id());
	...
}

rcu_dereference() expands to rcu_dereference_check(p, 0), whose condition
is rcu_read_lock_held():

kernel/rcu/update.c:rcu_read_lock_held() {
	...
	return lock_is_held(&rcu_lock_map);
}

so on a CONFIG_PROVE_RCU kernel, would sending a packet on a sit device
from these contexts produce a "suspicious rcu_dereference_check() usage"
splat?  Object lifetime looks fine, since BH-disabled regions are RCU
read-side sections, but the annotation seems off.

Would rcu_dereference_bh() (or rcu_dereference_check() with
rcu_read_lock_bh_held()) be more accurate, or alternatively an explicit
rcu_read_lock() in ipip6_tunnel_xmit(), like vxlan_xmit() does before its
RCU lookups?  The same question applies to the new rcu_dereference() in
only_dnatted().

[ ... ]

> @@ -1222,20 +1276,16 @@ ipip6_tunnel_6rdctl(struct net_device *dev, struct ip_tunnel_6rd __user *data,
>  {
>  	struct ip_tunnel *t = netdev_priv(dev);
>  	struct ip_tunnel_6rd ip6rd;
> -	int err;
>  
>  	if (!ns_capable(t->net->user_ns, CAP_NET_ADMIN))
>  		return -EPERM;
>  	if (copy_from_user(&ip6rd, data, sizeof(ip6rd)))
>  		return -EFAULT;
>  
> -	if (cmd != SIOCDEL6RD) {
> -		err = ipip6_tunnel_update_6rd(t, &ip6rd);
> -		if (err < 0)
> -			return err;
> -	} else
> -		ipip6_tunnel_clone_6rd(dev, dev_to_sit_net(dev));
> -	return 0;
> +	if (cmd != SIOCDEL6RD)
> +		return ipip6_tunnel_update_6rd(t, &ip6rd);
> +
> +	return ipip6_tunnel_clone_6rd(dev, dev_to_sit_net(dev));
>  }

Related to the comment above: SIOCDEL6RD can now also fail with -ENOMEM,
where it previously always returned 0.  Is that intentional?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907075846.2913645-1-edumazet%40google.com
