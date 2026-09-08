Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B19F52B1DF
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865262; cv=none; b=Id9oBoMCA721em1pe+dBN8TIAmzVxLO982gW3bIrNsoIA/JR8iGi8pxSgL3rd1j70krJt/89QI44KMefAduvOyODf5ptYKsy/VGQoUTKHYhBSuqvESo6pj2Wi4JIUU9tdWvG5ThEcRjltO781x7aaKVRB8PDfygzkl5pmI8fXuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865262; c=relaxed/simple;
	bh=sYa4uRk0cc2fOiYzCY8tWZJe6l9+ABP+CuAwygOVd3s=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pwZP8VF6AhwhDRl4o+PRe9wLyg+IP+HNrGAbzyVIklExmX0IqLAwEGwXef5RAeuNMQW0fLKicxns8jbtMul0X4wwelisAhB+UPdLrELNhWdsPNPfH4JaV1RjrEu2HHohrduOib5wrmx/ts5KlP8Eems0jENZVoIHr2k5nvGDZf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUmblF8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUmblF8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3841F00A3E;
	Tue,  8 Sep 2026 11:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788865260;
	bh=+05QaMx6gjaGpTczhFpPMckLS7UGjLEZYKCyVcaYVmw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QUmblF8IEspWRytlJKNc3PD6P6QmcjwDf4NK3EiDBTMRVgeBGsnTdiEkzd1y9waRp
	 4VSHcPMyb07fNqMx5WXHgsu19pIgO7OurZ6M+zPbDD43d6UNjhLY8oa1Z62d/KcD9X
	 5rdTfHOV7RRiSazHHVmOMTPAMJRLBCtGOuLRWvOiZoqHe+XautRRvagExyz7PD30Yg
	 O+IuNR5UWiC0M+oJLP2mZ7kBzxl9IDh63LrIWM6ocYhouVQJvIOjYuO4UNXVe6sDnM
	 ksHaFsTS1JiHGUk7PM29qB7y8Ny2G7U+M4INOvgprLCJAu6ypq7ruC79c6ksEyHd8j
	 QulDhg7VTplMA==
Subject: Re: [PATCH net-next 8/9] sit: convert configuration to RCU protection
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com,
 lorenzo.bianconi@oss.qualcomm.com, iprintercanon@gmail.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 08 Sep 2026 11:00:59 +0000
Message-ID: <178886525919.219967.16743451973276511375@kernel.org>
In-Reply-To: <20260907075846.2913645-9-edumazet@google.com>
References: <20260907075846.2913645-9-edumazet@google.com>
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

- [Medium] SIT tunnel parameters are now read from two objects that live
  in different synchronization domains, and ipip6_tunnel_update()…

--

sit: convert configuration to RCU protection

This converts tunnel->sit_parms into an RCU-protected pointer, so that
ipip6_tunnel_update() publishes a freshly allocated parameter block with
rcu_assign_pointer() and frees the old one with kfree_rcu(). The unlink /
re-link plus synchronize_net() are now skipped when neither saddr nor daddr
changed.

> diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
> index dc37c7109af53..c9049ab87e010 100644
> --- a/net/ipv6/sit.c
> +++ b/net/ipv6/sit.c

[ ... ]

> @@ -1087,13 +1119,17 @@ static netdev_tx_t sit_tunnel_xmit__(struct sk_buff *skb,
>  				     struct net_device *dev, u8 ipproto)
>  {
>  	struct ip_tunnel *tunnel = netdev_priv(dev);
> -	const struct iphdr  *tiph = &tunnel->sit_parms->iph;
> +	const struct ip_tunnel_parm_kern *parms;
> +	const struct iphdr  *tiph;
>  
>  	if (iptunnel_handle_offloads(skb, SKB_GSO_IPXIP4))
>  		goto tx_error;
>  
>  	skb_set_inner_ipproto(skb, ipproto);
>  
> +	parms = rcu_dereference(tunnel->sit_parms);
> +	tiph = &parms->iph;
> +
>  	ip_tunnel_xmit(skb, dev, tiph, ipproto);
>  	return NETDEV_TX_OK;
>  tx_error:

[ ... ]

> @@ -1194,21 +1235,29 @@ static int ipip6_tunnel_update(struct ip_tunnel *t,
>  	new_p->iph.tos = p->iph.tos;
>  	new_p->iph.frag_off = p->iph.frag_off;
>  	new_p->link = p->link;
> -	ipip6_tunnel_unlink(sitn, t);
> -	synchronize_net();
> -	t->sit_parms = new_p;
> +	move = old_p->iph.saddr != p->iph.saddr ||
> +	       old_p->iph.daddr != p->iph.daddr;
> +
> +	if (move)
> +		ipip6_tunnel_unlink(sitn, t);
> +
>  	t->parms.iph = new_p->iph;
>  	WRITE_ONCE(t->parms.link, new_p->link);
> -	__dev_addr_set(t->dev, &p->iph.saddr, 4);
> -	memcpy(t->dev->broadcast, &p->iph.daddr, 4);
> -	ipip6_tunnel_link(sitn, t);
> +	rcu_assign_pointer(t->sit_parms, new_p);

[Severity: Medium]
After this change, are the SIT transmit parameters read from two objects
that are no longer updated together?

ipip6_tunnel_update() now performs two separate stores here:

	t->parms.iph = new_p->iph;		/* plain struct copy */
	WRITE_ONCE(t->parms.link, new_p->link);
	rcu_assign_pointer(t->sit_parms, new_p);	/* published */

On the transmit side, sit_tunnel_xmit__() takes the header out of the
RCU-published block:

	parms = rcu_dereference(tunnel->sit_parms);
	tiph = &parms->iph;

	ip_tunnel_xmit(skb, dev, tiph, ipproto);

but ip_tunnel_xmit() in net/ipv4/ip_tunnel.c mixes that with the shadow
copy that is not RCU protected:

	connected = (tunnel->parms.iph.daddr != 0);
	...
	dst = tnl_params->daddr;
	...
		rt = connected ? dst_cache_get_ip4(&tunnel->dst_cache,
						&fl4.saddr) : NULL;
	...
		else if (!md && connected)
			dst_cache_set_ip4(&tunnel->dst_cache, &rt->dst,
					  fl4.saddr);

Since sit_tunnel_xmit() runs locklessly, can it observe the two objects
from different generations, e.g. sit_parms with daddr == 0 (so dst is
derived per packet from the skb/neighbour) while tunnel->parms.iph.daddr
already holds the new address, making connected true?  In that case
ip_tunnel_xmit() would consult and populate tunnel->dst_cache for a
destination-specific route on a tunnel that the header says is NBMA, so a
burst of packets could be routed via the cached entry.  The reverse pairing
(old shadow daddr, new sit_parms daddr) looks possible too where the plain
tunnel->parms.iph.daddr load can be reordered against the rcu_dereference().

Independently of the ordering question, is the plain struct assignment
t->parms.iph = new_p->iph a data race?  It writes roughly twenty bytes
without any annotation while the xmit path is reading ttl, tos, frag_off
and daddr from tunnel->parms, which KCSAN should flag and which can hand
the transmit path a mixture of old and new field values.

The synchronize_net() in the move case only runs after publication, so it
bounds but does not close the window for a reader that entered right at the
grace period boundary.

Would it make sense for ip_tunnel_xmit() to derive connected and link from
the same parameter block that tiph came from, so that only one object is
consulted per packet?

>  
> +	if (move) {
> +		synchronize_net();
> +		__dev_addr_set(t->dev, &p->iph.saddr, 4);
> +		memcpy(t->dev->broadcast, &p->iph.daddr, 4);
> +		ipip6_tunnel_link(sitn, t);
> +	}
>  	if (old_p->link != p->link || t->fwmark != fwmark) {
>  		WRITE_ONCE(t->fwmark, fwmark);
>  		ipip6_tunnel_bind_dev(t->dev);
>  	}
>  	dst_cache_reset(&t->dst_cache);
>  	netdev_state_change(t->dev);
> -	kfree(old_p);
> +	kfree_rcu(old_p, rcu);
>  	return 0;
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907075846.2913645-1-edumazet%40google.com
