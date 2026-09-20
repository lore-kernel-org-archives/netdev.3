Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88E3EFFA9
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789901311; cv=none; b=dEZmZA0W+eAnY/TLaA2G5fsuxGsQ1G/nrQrkrhv7HNaYIuD+RZYdbuJx6zGnBGa3Yq0RNeyZYiB4qZkJZE43YwgsKhG3uNaBwc5B7MaTpbq4gmwUwKwR6XyvBZ9qd9NHuNm6eZKg17QX3a1k3rIZC7JzDDGQhophhl7Xad/ARQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789901311; c=relaxed/simple;
	bh=I0KNCju7z2T0qiSNsg2E3201xxf+ilfTQzUK+lOOzlU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rZOC0FMHZfK5uzjdZtzJUj1rp2F6xl7sAt7/ftjJX/mooZB2dDvpuT5sBZaaY6U2ES9hwO7UQ+kvG4qF+vRFVZju/QoIM5YzVTVO3dMK3Dlj93G+AbTZnZoDjodYMV4m43ffaK0G5nrZ39WH4vqJiFnMVyL9QzoWDEqofHnjf/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKiyAbgX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKiyAbgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE751F00898;
	Sun, 20 Sep 2026 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789901309;
	bh=DaBdbzFTExtkN9JDuxpOTLYfxlMNcOMEFJVPP5fThsM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oKiyAbgXlcnJwH3f85Ya+dJyN6GmAUcgwqGmTAOESg/O1mJnA1wDNw2xCOOYpem/U
	 L2boY7UyDDE5Tg3bmFm8vx4+qN7W9ttJpTuUKILGsFzihG8BgWCAHd0c+2BVh3HtLf
	 ZsSr59g+6IsGqhjCE5rQbkFW260sRa2D4NWfffo3aeziRFzOvxb8XNf06jBNiQWn8W
	 rRJReKr81sn0iDf2LK9IZ/p0UHzUhZql/j9JJP65B7gRUMP79JIy5XGX+rgYeEpifV
	 2HGW+jNy9RyNSjsLO3ufeLcZ/lqVDbK6izgiilyyjHNqlilP7HfJxhTR8jcQJTo9tb
	 Enf+uacUI5u5A==
Subject: Re: [PATCH net v2 3/5] ip_gre: compute tunnel lengths absolutely
 instead of by delta
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Date: Sun, 20 Sep 2026 10:48:28 +0000
Message-ID: <178990130838.2160803.12719751217036872420@kernel.org>
In-Reply-To: <20260916100155.1398403-4-edumazet@google.com>
References: <20260916100155.1398403-4-edumazet@google.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (3)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Compensating GRE-flag and encapsulation changes submitted
  together with a link/fwmark change leave dev->mtu computed from an…

Pre-existing issues:
- [Low] Claimed incomplete fix: erspan_changelink() (and ipip.c/sit.c
  changelink) publish a new encapsulation through…
- [Low] Claimed stale hlen-derived limit: dev->max_mtu is fixed from the
  creation-time tunnel->hlen by ip_tunnel_create()/ip_tunnel_newlink()…
- [Low] Claimed error-path state inconsistency: when IFLA_MTU is present
  and ipgre_changelink() succeeds, set_mtu is false so the MTU refresh…

--

ip_gre: compute tunnel lengths absolutely instead of by delta

This replaces the delta arithmetic in ipgre_link_update() with an absolute
recomputation of tunnel->hlen from tun_hlen and encap_hlen, and adds
ip_tunnel_refresh_lengths() so ip_tunnel_bind_dev() becomes the only writer
of dev->needed_headroom and dev->mtu. ipgre_changelink() now also refreshes
the lengths on its error paths, since the new encapsulation is already
published at that point.

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index dad3d054bd156..ced57cbeaad49 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -789,23 +789,36 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
>  	return NETDEV_TX_OK;
>  }
>  
> -static void ipgre_link_update(struct net_device *dev, bool set_mtu)
> +/* tunnel->hlen depends on tunnel->parms.o_flags and on tunnel->encap_hlen,
> + * both of which ipgre_changelink() can change. Recompute it the way
> + * __gre_tunnel_init() does, then let ip_tunnel_bind_dev() derive the device
> + * lengths from it.
> + *
> + * @old_hlen is only used to tell whether the MTU became stale, never as a
> + * difference to apply, so it can not make the lengths drift. It must be
> + * sampled before ip_tunnel_encap_setup(), which already publishes the new
> + * tunnel->hlen for us.
> + */
> +static void ipgre_link_update(struct net_device *dev, bool set_mtu,
> +			      int old_hlen)
>  {
>  	struct ip_tunnel *tunnel = netdev_priv(dev);
> -	int len;
>  
> -	len = tunnel->tun_hlen;
>  	tunnel->tun_hlen = gre_calc_hlen(tunnel->parms.o_flags);
> -	len = tunnel->tun_hlen - len;
> -	tunnel->hlen = tunnel->hlen + len;
> +	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen;
>  
> -	if (dev->header_ops)
> -		dev->hard_header_len += len;
> -	else
> -		dev->needed_headroom += len;
> +	/* For the ARPHRD_IPGRE devices installing ipgre_header_ops,
> +	 * dev->hard_header_len is the outer IP + GRE header, as set by
> +	 * ipgre_tunnel_init(). ip_tunnel_bind_dev() does not maintain it:
> +	 * it only subtracts it from the MTU, and only for ARPHRD_ETHER.
> +	 */
> +	if (dev->header_ops == &ipgre_header_ops)
> +		dev->hard_header_len = tunnel->hlen + sizeof(struct iphdr);
>  
> -	if (set_mtu)
> -		WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - len, 68));
> +	/* Only reset a MTU that the header length just invalidated, so that
> +	 * a MTU configured by the user survives an unrelated change.
> +	 */
> +	ip_tunnel_refresh_lengths(dev, set_mtu && tunnel->hlen != old_hlen);

[Severity: Medium]

Can this predicate leave dev->mtu at a value computed from an intermediate
tunnel->hlen?

In ipgre_changelink() the encapsulation is published before the flags are
applied:

  ipgre_newlink_encap_setup()
    ip_tunnel_encap_setup()
      t->encap_hlen = hlen;
      t->hlen = t->encap_hlen + t->tun_hlen;   /* still the old tun_hlen */

ip_tunnel_changelink() then calls ip_tunnel_update(itn, t, dev, p,
!tb[IFLA_MTU], fwmark), which writes the MTU from that intermediate hlen when
the link or the fwmark changed:

  if (t->parms.link != p->link || t->fwmark != fwmark) {
	...
	mtu = ip_tunnel_bind_dev(dev);
	if (set_mtu)
		WRITE_ONCE(dev->mtu, mtu);

Only afterwards does ipgre_link_update() compute the final tunnel->hlen and
compare it with old_hlen, which was sampled at the entry of
ipgre_changelink().

For a gre device with tun_hlen 4 and encap fou (encap_hlen 8, hlen 12) over a
1500 byte lower device, the correct MTU is 1468. A single request asking for
"encap none" plus csum plus key plus a new fwmark gives an intermediate hlen
of 4, so ip_tunnel_update() writes dev->mtu = 1500 - 24 = 1476. The final hlen
is 12 + 0, equal to old_hlen, so the refresh above is suppressed and dev->mtu
stays 1476, eight bytes too large. The reverse combination (adding fou while
removing csum and key) leaves it eight bytes too small.

The previous delta code corrected exactly this case, since it applied
dev->mtu -= len on top of what ip_tunnel_update() had written (1476 - 8 =
1468).

Would refreshing unconditionally when set_mtu is true, rather than gating on
tunnel->hlen != old_hlen, avoid this?

>  
>  	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags) ||
>  	    (test_bit(IP_TUNNEL_CSUM_BIT, tunnel->parms.o_flags) &&

[ ... ]

> @@ -1485,18 +1499,27 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
>  
>  	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
>  	if (err < 0)
> -		return err;
> +		goto link_update;
>  
>  	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
>  	if (err < 0)
> -		return err;
> +		goto link_update;
>  
>  	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
>  	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);
>  
> -	ipgre_link_update(dev, !tb[IFLA_MTU]);
> +link_update:
> +	/* ipgre_newlink_encap_setup() has published a new encapsulation even
> +	 * if the rest of the request failed, so the lengths must be refreshed
> +	 * on the error paths as well. This has to come last, because
> +	 * ipgre_link_update() needs the flags copied above.
> +	 *
> +	 * IFLA_MTU only defers the MTU to do_setlink(), which rtnl_changelink()
> +	 * does not reach if we return an error, so it must not hold it back.
> +	 */
> +	ipgre_link_update(dev, err || !tb[IFLA_MTU], old_hlen);

[Severity: Low]

This isn't a bug introduced by this patch, but the IFLA_MTU deferral here has
a window where the header length change is committed with a stale MTU.

When IFLA_MTU is present and ipgre_changelink() succeeds, set_mtu is false and
the MTU is left to do_setlink(). If the rest of the rtnetlink request then
fails (IFLA_INFO_SLAVE_DATA handling, dev_validate_mtu() rejecting the
requested value, or a NETDEV_CHANGEMTU notifier), nothing rolls back the
header length change:

net/core/rtnetlink.c:rtnl_changelink() {
	...
	err = ops->changelink(dev, tb, data, extack);
	if (err < 0)
		return err;
	...
}

The baseline already passed !tb[IFLA_MTU] and rtnl_changelink() has always
called ops->changelink() first without rollback, so this is unchanged by the
patch. Is it worth noting as a known limitation?

>  
> -	return 0;
> +	return err;
>  }
>  
>  static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],

[Severity: Low]

This is a pre-existing issue and not introduced by this patch, but the same
symptom the changelog describes ("adding encap fou to an existing gre device
keeps the MTU of a bare tunnel") is still reachable through other changelink
handlers that publish a new encapsulation without refreshing the lengths:

  erspan_changelink()  -> ipgre_newlink_encap_setup() -> ip_tunnel_encap_setup()
  ipip_changelink()    -> ip_tunnel_encap_setup()
  ipip6_changelink()   -> ip_tunnel_encap_setup()

ip_tunnel_update() only rebinds the device when the link or the fwmark
changed:

net/ipv4/ip_tunnel.c:ip_tunnel_update() {
	...
	if (t->parms.link != p->link || t->fwmark != fwmark) {
		...
		mtu = ip_tunnel_bind_dev(dev);
	...
}

For erspan this is handled by the following patch in the series, "ip_gre:
recompute erspan header lengths after a change", which adds erspan_set_hlen()
and erspan_link_update() with the same link_update label and error path
refresh. Are ipip.c and sit.c intentionally left for a separate change?

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 2a313b18134e2..dd1b2f719f216 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -326,6 +326,23 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
>  	return mtu;
>  }
>  
> +/* Recompute dev->needed_headroom and dev->mtu after tunnel->hlen changed.
> + *
> + * Both are derived from tunnel->hlen, so they must be recomputed from it
> + * rather than adjusted by the difference: ip_tunnel_bind_dev() is also
> + * called from ip_tunnel_create(), ip_tunnel_newlink(), ip_tunnel_init_net()
> + * and ip_tunnel_update(), and a caller adding its own delta on top would
> + * double count it.
> + */
> +void ip_tunnel_refresh_lengths(struct net_device *dev, bool set_mtu)
> +{
> +	int mtu = ip_tunnel_bind_dev(dev);
> +
> +	if (set_mtu)
> +		WRITE_ONCE(dev->mtu, mtu);
> +}
> +EXPORT_SYMBOL_GPL(ip_tunnel_refresh_lengths);

[Severity: Low]

This is a pre-existing issue rather than something this patch introduces, but
the new helper writes dev->mtu while dev->max_mtu keeps the value derived from
the creation-time tunnel->hlen:

net/ipv4/ip_tunnel.c:ip_tunnel_create() {
	...
	t_hlen = nt->hlen + sizeof(struct iphdr);
	dev->min_mtu = ETH_MIN_MTU;
	dev->max_mtu = IP_MAX_MTU - t_hlen;
	...
}

Nothing in ipgre_link_update() or ip_tunnel_refresh_lengths() updates
dev->max_mtu, while ip_tunnel_change_mtu() validates against the live
tunnel->hlen:

net/ipv4/ip_tunnel.c:ip_tunnel_change_mtu() {
	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
	int max_mtu = IP_MAX_MTU - t_hlen;
	...
}

So dev_validate_mtu() can reject an MTU that ip_tunnel_change_mtu() would
accept, and the refreshed dev->mtu can exceed the advertised dev->max_mtu (for
example a device created with hlen 8 whose csum flag is later removed on a
65535 byte lower device ends up with dev->mtu 65511 against dev->max_mtu
65507). The old delta code produced the same value, so this is not a change in
behaviour. Should dev->max_mtu be refreshed alongside dev->mtu here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916100155.1398403-1-edumazet%40google.com
