Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4761526AA9
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865261; cv=none; b=JMCSc2m8wVDOx9M71n44W0IBIDs1V7TmOl0sKIAfK/IgD6pGNldslS58K1SsDcg5hMvg1xtQEFBYERS+fWgx+nFPZs+x90Euna1H2ixytQgZOjC6qn5S8a87UEfjTiWEXdsIUZV6YzB2fAY7cn8UdOnwACZM9vPKrzJ1Tr84h5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865261; c=relaxed/simple;
	bh=aRaKqrPX+aZFwqzf+oJZuvUCLj1tqbNXlTHLMOK9Ctc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FFjChua3jNvaF70dKpv0PgCn2rmemMr+8RDGQ39sgI9+o4wWCA3GLwaql2FlZ18pyMQqWEXZQ+VQ3D1ELbMtFp5DAytpCUd67a4x9gakFc12avHCfIW6qmJytFkvjwzowvWruoLPomkhk582yozOOPHL6dSBcMYKcxBJ2kNa2r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3dfKzRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3dfKzRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EFC91F00A3D;
	Tue,  8 Sep 2026 11:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788865259;
	bh=U7HN5Mhvdo22dPGOAXjlA+fSOXCCAhc5zOw6KTi8ctM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=H3dfKzRb1UgKjVj2b+7itZ7OgFUwH13KrNL9j/bew40sB/GGYi6othA2srUXZ8OQs
	 LH0AjR8VT1UNZf7Nxy1JtWkY8mCRpxLV6uYM+cmO9RHP4OEIGkeeIcX8cDQT58Kq3m
	 iKv0LXeqOTukaoj6NnJGT4WNGZz/xJNCEx8p+AZsf0siDRWnFqgU4d7Jh3JrGloBAE
	 5tu7qlPbzztaCXJcHaYBzbapYqzS6oMeg7H+C4UHJKWFNQEQlYhGFObdrcIndJPB6J
	 G3v8osQa50PjU2mpxB0ORFsSjUfrytqJxAJmOfEOcssjH+vfzODwRH/TNzBCP+sn9r
	 l6PFK+7VnuQtQ==
Subject:
 Re: [PATCH net-next 7/9] sit: dynamically allocate struct ip_tunnel_parm_kern
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com,
 lorenzo.bianconi@oss.qualcomm.com, iprintercanon@gmail.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 08 Sep 2026 11:00:57 +0000
Message-ID: <178886525794.219967.6858049479362932625@kernel.org>
In-Reply-To: <20260907075846.2913645-8-edumazet@google.com>
References: <20260907075846.2913645-8-edumazet@google.com>
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

- [Medium] Intermediate-state use-after-free in net/ipv6/sit.c:
  ipip6_tunnel_update() publishes the freshly allocated parameter block…
- [Low] Missing publication barrier / unannotated lockless pointer: in
  this commit `sit_parms` is a plain (non-__rcu) pointer in struct…

--

sit: dynamically allocate struct ip_tunnel_parm_kern

This moves the SIT configuration parameters out of the embedded
ip_tunnel.parms into a separately allocated struct ip_tunnel_parm_kern
reachable through the new ip_tunnel.sit_parms pointer, in preparation for
converting them to RCU.  All readers and writers in net/ipv6/sit.c are
switched over to the new pointer.

A couple of questions about the intermediate state this commit leaves the
tree in.

> diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
> index 7fff59bab53b6..f464c4480edaf 100644
> --- a/include/net/ip_tunnels.h
> +++ b/include/net/ip_tunnels.h
> @@ -190,6 +190,7 @@ struct ip_tunnel {
>  #endif
>  	struct ip_tunnel_prl_entry __rcu *prl;	/* potential router list */
>  	unsigned int		prl_count;	/* # of entries in PRL */
> +	struct ip_tunnel_parm_kern *sit_parms;
      ^^^^

[Severity: Low]
Should this member already carry the __rcu annotation in this commit?  It
is read from softirq packet paths (ipip6_tunnel_lookup(), ipip6_rcv(),
sit_tunnel_rcv(), ipip6_tunnel_xmit(), sit_tunnel_xmit__()) without RTNL,
while ipip6_tunnel_update() replaces it with a plain store.  As a plain
pointer, sparse cannot flag the unprotected dereferences, the publish has
no release semantics, and the loads are plain data races for KCSAN.

The following patch in the series, "sit: convert configuration to RCU
protection", changes this to struct ip_tunnel_parm_kern __rcu *sit_parms
and converts publication to rcu_assign_pointer(), so the window is limited
to this single commit.  Would it be worth folding the annotation in here?

>  	unsigned int		ip_tnl_net_id;
>  	struct gro_cells	gro_cells;
>  	__u32			fwmark;
> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index 35c6695909014..dc37c7109af53 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c
> @@ -108,24 +108,24 @@ static struct ip_tunnel *ipip6_tunnel_lookup(struct net *net,
>  	int ifindex = dev ? dev->ifindex : 0;
>  
>  	for_each_ip_tunnel_rcu(t, sitn->tunnels_r_l[h0 ^ h1]) {
> -		if (local == t->parms.iph.saddr &&
> -		    remote == t->parms.iph.daddr &&
> -		    (!dev || !t->parms.link || ifindex == t->parms.link ||
> -		     sifindex == t->parms.link) &&
> +		if (local == t->sit_parms->iph.saddr &&
> +		    remote == t->sit_parms->iph.daddr &&
> +		    (!dev || !t->sit_parms->link || ifindex == t->sit_parms->link ||
> +		     sifindex == t->sit_parms->link) &&
        ^^^^

[Severity: Low]
Can this mix fields from two different parameter blocks?  t->sit_parms is
reloaded up to four times inside one match decision here, and
ipip6_tunnel_update() swaps the pointer concurrently, so saddr/daddr could
come from the old block and link from the new one.

The next patch caches a single rcu_dereference(t->sit_parms) in a local
parms variable per candidate, which removes this; could that be done here
instead?

>  		    (t->dev->flags & IFF_UP))
>  			return t;
>  	}

[ ... ]

> @@ -938,9 +942,9 @@ static netdev_tx_t ipip6_tunnel_xmit(struct sk_buff *skb,
>  				     struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel = netdev_priv(dev);
> -	const struct iphdr  *tiph = &tunnel->parms.iph;
> +	const struct iphdr  *tiph = &tunnel->sit_parms->iph;
>  	const struct ipv6hdr *iph6 = ipv6_hdr(skb);
> -	u8     tos = tunnel->parms.iph.tos;
> +	u8     tos = tunnel->sit_parms->iph.tos;
        ^^^^

[Severity: Medium]
Can this read freed memory?  ipip6_tunnel_xmit() reaches the tunnel via
netdev_priv(dev), never through the sitn->tunnels[] buckets, and it keeps
the interior pointer tiph across the route lookup, the PMTU handling, the
headroom reallocation and iptunnel_xmit().

Meanwhile ipip6_tunnel_update() frees the block the pointer points into:

net/ipv6/sit.c:ipip6_tunnel_update() {
	...
	ipip6_tunnel_unlink(sitn, t);
	synchronize_net();
	t->sit_parms = new_p;
	...
	kfree(old_p);
	return 0;
}

The synchronize_net() runs before the new pointer is published and only
drains readers that came in through the hash buckets, so it does not cover
this path.  dev->lltx is set for sit, so nothing else serializes a
SIOCCHGTUNNEL or RTM_NEWLINK change against traffic on the same device.
The values read out of the freed block (tiph->saddr, tos, ttl, frag_off)
end up in the outer IPv4 header.

The immediately following patch, "sit: convert configuration to RCU
protection", wraps the transmit path in rcu_read_lock() and uses
kfree_rcu(old_p, rcu), so this hazard exists only between the two commits
(a concern for bisection and partial backports).

>  	__be16 df = tiph->frag_off;
>  	struct rtable *rt;		/* Route to the other host */
>  	struct net_device *tdev;	/* Device to other host */

[ ... ]

> @@ -1083,7 +1087,7 @@ static netdev_tx_t sit_tunnel_xmit__(struct sk_buff *skb,
>  				     struct net_device *dev, u8 ipproto)
>  {
>  	struct ip_tunnel *tunnel = netdev_priv(dev);
> -	const struct iphdr  *tiph = &tunnel->parms.iph;
> +	const struct iphdr  *tiph = &tunnel->sit_parms->iph;
        ^^^^

[Severity: Medium]
Same question here: this hands an interior pointer of the freeable
parameter block to ip_tunnel_xmit() with no reference and no RCU section
held, so a concurrent ipip6_tunnel_update() can kfree() it underneath.

>  
>  	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
>  		goto tx_error;

[ ... ]

> @@ -1171,30 +1175,41 @@ static void ipip6_tunnel_bind_dev(struct net_device *dev)
>  	dev->needed_headroom = ip_tunnel_limit_headroom(t_hlen + hlen);
>  }
>  
> -static void ipip6_tunnel_update(struct ip_tunnel *t,
> -				struct ip_tunnel_parm_kern *p,
> -				__u32 fwmark)
> +static int ipip6_tunnel_update(struct ip_tunnel *t,
> +			       struct ip_tunnel_parm_kern *p,
> +			       __u32 fwmark)
>  {
>  	struct net *net = t->net;
>  	struct sit_net *sitn = net_generic(net, sit_net_id);
> +	struct ip_tunnel_parm_kern *new_p, *old_p;
>  
> +	old_p = t->sit_parms;
> +	new_p = kmalloc_obj(*new_p);
> +	if (!new_p)
> +		return -ENOMEM;
> +	*new_p = *old_p;
> +	new_p->iph.saddr = p->iph.saddr;
> +	new_p->iph.daddr = p->iph.daddr;
> +	new_p->iph.ttl = p->iph.ttl;
> +	new_p->iph.tos = p->iph.tos;
> +	new_p->iph.frag_off = p->iph.frag_off;
> +	new_p->link = p->link;
>  	ipip6_tunnel_unlink(sitn, t);
>  	synchronize_net();
> -	t->parms.iph.saddr = p->iph.saddr;
> -	t->parms.iph.daddr = p->iph.daddr;
> +	t->sit_parms = new_p;
        ^^^^

[Severity: Medium]
Is the ordering here intentional?  The grace period happens before the new
pointer is published, so nothing separates the store of new_p from the
kfree(old_p) below for readers that already loaded the old pointer.

> +	t->parms.iph = new_p->iph;
> +	WRITE_ONCE(t->parms.link, new_p->link);
>  	__dev_addr_set(t->dev, &p->iph.saddr, 4);
>  	memcpy(t->dev->broadcast, &p->iph.daddr, 4);
>  	ipip6_tunnel_link(sitn, t);
> -	t->parms.iph.ttl = p->iph.ttl;
> -	t->parms.iph.tos = p->iph.tos;
> -	t->parms.iph.frag_off = p->iph.frag_off;
> -	if (t->parms.link != p->link || t->fwmark != fwmark) {
> -		t->parms.link = p->link;
> +	if (old_p->link != p->link || t->fwmark != fwmark) {
>  		WRITE_ONCE(t->fwmark, fwmark);
>  		ipip6_tunnel_bind_dev(t->dev);
>  	}
>  	dst_cache_reset(&t->dst_cache);
>  	netdev_state_change(t->dev);
> +	kfree(old_p);
        ^^^^

[Severity: Medium]
Would kfree_rcu() be needed here, given that ipip6_tunnel_xmit(),
sit_tunnel_xmit__() and ipip6_get_iflink() all reach sit_parms through
netdev_priv(dev) rather than through the hash buckets?

The next patch in the series adds a struct rcu_head to
ip_tunnel_parm_kern and turns this into kfree_rcu(old_p, rcu).

> +	return 0;
>  }

[ ... ]

> @@ -1448,7 +1465,7 @@ static int ipip6_get_iflink(const struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel = netdev_priv(dev);
>  
> -	return READ_ONCE(tunnel->parms.link);
> +	return READ_ONCE(tunnel->sit_parms->link);
        ^^^^

[Severity: Medium]
Here the READ_ONCE() now covers only the link field, not the pointer load
itself.  Since this accessor can run without RTNL, can it dereference the
block that ipip6_tunnel_update() is about to kfree()?  The following patch
adds an rcu_read_lock() section and an rcu_dereference() here.

>  }
>  
>  static const struct net_device_ops ipip6_netdev_ops = {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907075846.2913645-1-edumazet%40google.com
