Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8393B14D6
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474273; cv=none; b=U+sbgHX+QI/QDDrqyLAJbQxQEXInEEdF67zxasf0x/xtF86AcBirQnsOgJ3J4orhvO5G8LYJQPBarJrIXN5jCdDivi+qAi98peauFM0nqRvLcmb1EoscEncmHxnPCThSGJtNGAyM0F/MtohRcImRF2rIZl4Oi9IacMT/nvk25pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474273; c=relaxed/simple;
	bh=f/6ZZ2j7veBQ4EIY7x/KAJQBVDS3T3safaXiML9LZbs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZAHNmmL+hgNF6EysGOhQxMQmTVsTC7Ffv8bEQB1nUTn2bRcDVYCitY+Dl1jaGYEpEVAU0JEGvGTqe2WxH3DxgiixwCaPsjMokk+IAfQHBvPn3lfW41MP1WsFaCIu3k8CxfGbvKIYxaz458iUx/dYtve0azAl3pzh4t9aV0xPqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P29LRHZ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P29LRHZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B303B1F00893;
	Tue, 15 Sep 2026 12:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474271;
	bh=zIW7lhOLMujuHTAApOJ66B+uJxbNCUmtfjcA9o5QuGg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P29LRHZ66Abfi4OXEM7UUgU6i8KTTVdW1JjJNGLFifXaSsV78JDa4c+BwGTdQB9jw
	 /wshr5DMACYEuc0erqKDd5eGZAJJKARp7kucWfwVwFba3/WyEe4kKzXfgC7Bjl+ojO
	 30CCkDKNZYy3fA9vTbuk8RPbjJhps57iHgjPYGKaGwSOGFsPlpaUolVO2bcfVlIW14
	 Av44wpeZnaFUGCvMbhSuDydW8Zp5dXgjUptrhNJj4v0Clrp3ceaVm4aq3uAJTSRIPR
	 Ova6uQtcneWXrJxCkPDs6IlFLHVXwszXdRC24UxhERgJ48u8T3aiXgycDMzJigiKVg
	 KwFBtWNAnTW3w==
Subject: Re: [PATCH net 2/3] ip_gre: compute tunnel lengths absolutely instead
 of by delta
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Date: Tue, 15 Sep 2026 12:11:10 +0000
Message-ID: <178947427027.22033.1329061879641565657@kernel.org>
In-Reply-To: <20260912150944.3470971-3-edumazet@google.com>
References: <20260912150944.3470971-3-edumazet@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 3 (1)

- [High] Removing the `if (dev->header_ops) dev->hard_header_len += len;`
  branch from ipgre_link_update() (net/ipv4/ip_gre.c:802-816) leaves…
- [Medium] ipgre_changelink() (and erspan_changelink()) still return
  immediately when ipgre_newlink_encap_setup() fails, which is the one…
- [Low] In ipgre_changelink() the refresh at the new `link_update:` label
  passes set_mtu = !tb[IFLA_MTU], so the mere presence of IFLA_MTU…
- [Low] The new predicate `set_mtu && tunnel->hlen != old_hlen` in
  ipgre_link_update() (net/ipv4/ip_gre.c:813) compares the final hlen…
- [Low] The new comment on ip_tunnel_refresh_lengths()
  (net/ipv4/ip_tunnel.c:329-335) states that "ip_tunnel_bind_dev() is…

Pre-existing issues:
- [Low] erspan_changelink() publishes a new encapsulation
  (ipgre_newlink_encap_setup() -> ip_tunnel_encap_setup(), which sets…

--

ip_gre: compute tunnel lengths absolutely instead of by delta

This replaces the delta-based length adjustment in ipgre_link_update() with
a full recomputation of tunnel->hlen from tun_hlen and encap_hlen, and adds
ip_tunnel_refresh_lengths() so that ip_tunnel_bind_dev() becomes the only
writer of dev->needed_headroom and dev->mtu.  ipgre_changelink() now also
refreshes the lengths on its error paths.

A few questions about the new code below.

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 40b922362a7ca..556ebf2c5bd0d 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -789,23 +789,28 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
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
> -
> -	if (dev->header_ops)
> -		dev->hard_header_len += len;
> -	else
> -		dev->needed_headroom += len;
> +	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen;

[Severity: High]
Was dropping the dev->hard_header_len update intended here?  That branch
was the only thing keeping dev->hard_header_len in sync for ARPHRD_IPGRE
devices that install ipgre_header_ops.

ipgre_tunnel_init() sets it up as the outer IP+GRE header for those
devices:

	} else if (!tunnel->collect_md) {
		dev->header_ops = &ipgre_header_ops;
		dev->hard_header_len = tunnel->hlen + sizeof(*iph);
		dev->needed_headroom = 0;
	}

and ipgre_xmit() consumes exactly that many bytes:

	if (dev->header_ops) {
		int pull_len = tunnel->hlen + sizeof(struct iphdr);
		...
		if (!pskb_may_pull(skb, pull_len))
			goto free_skb;
		...
		skb_pull(skb, pull_len);

After this change, an o_flags change through ipgre_changelink() or
SIOCCHGTUNNEL updates tunnel->tun_hlen and tunnel->hlen and, via
ip_tunnel_refresh_lengths() -> ip_tunnel_bind_dev(), dev->needed_headroom
and dev->mtu, but nothing writes dev->hard_header_len again.
ip_tunnel_bind_dev() only reads it, and only for ARPHRD_ETHER:

	dev->needed_headroom = ip_tunnel_limit_headroom(t_hlen + hlen);
	mtu -= t_hlen + (dev->type == ARPHRD_ETHER ? dev->hard_header_len : 0);

So with

	ip link add gre1 type gre local 10.0.0.1
	ip link set gre1 type gre local 10.0.0.1 okey 1 ikey 1

tunnel->hlen becomes 8 while dev->hard_header_len stays 24, permanently.

Does that break AF_PACKET senders on such a device?  ipgre_header_ops has
no .validate callback:

	static const struct header_ops ipgre_header_ops = {
		.create	= ipgre_header,
		.parse	= ipgre_header_parse,
	};

so dev_validate_header() rejects a correctly sized raw link header once
hlen shrinks (nocsum/nokey), and when hlen grows (okey/oseq) a header
built to the advertised, now too small, hard_header_len passes validation
while ipgre_xmit() still pulls tunnel->hlen + sizeof(struct iphdr) bytes,
taking payload bytes into the header.

The commit message says:

    The dev->header_ops branch is removed rather than converted:
    ip_tunnel_bind_dev() does not add to dev->hard_header_len, it subtracts
    it from the MTU as the inner Ethernet header.

Is that statement only true for gretap (ARPHRD_ETHER)?  For the
ipgre_header_ops devices, dev->hard_header_len is the outer IP+GRE length,
not an inner Ethernet header.

>  
> -	if (set_mtu)
> -		WRITE_ONCE(dev->mtu, max_t(int, dev->mtu - len, 68));
> +	/* Only reset a MTU that the header length just invalidated, so that
> +	 * a MTU configured by the user survives an unrelated change.
> +	 */
> +	ip_tunnel_refresh_lengths(dev, set_mtu && tunnel->hlen != old_hlen);

[Severity: Low]
Can this predicate miss a stale MTU when a single request changes the
encapsulation, the GRE flags and the link at once?  @old_hlen is the hlen
sampled before the request, not the hlen that dev->mtu was actually
computed from.

ip_tunnel_encap_setup() publishes an intermediate length first:

	t->encap_hlen = hlen;
	t->hlen = t->encap_hlen + t->tun_hlen;

then ip_tunnel_changelink() -> ip_tunnel_update() writes the MTU from that
intermediate value:

	if (t->parms.link != p->link || t->fwmark != fwmark) {
		...
		mtu = ip_tunnel_bind_dev(dev);
		if (set_mtu)
			WRITE_ONCE(dev->mtu, mtu);
	}

For a device with csum|key (tun_hlen 12, encap_hlen 0, hlen 12) and

	ip link set gre1 type gre ... nocsum nokey encap fou \
		encap-sport A encap-dport B dev <other>

encap_hlen becomes 8 and the MTU is written from hlen 20.  ipgre_link_update()
then computes tun_hlen 4 and hlen 12, which equals @old_hlen, so the
corrective MTU write is suppressed and dev->mtu stays 8 bytes below the
correct value.  dev->needed_headroom is fine, since
ip_tunnel_refresh_lengths() always calls ip_tunnel_bind_dev().

The deleted delta code did correct this case, so does

    @old_hlen survives only as a predicate telling whether the MTU became
    stale, never as a difference, so it can not make the lengths drift.

still hold for dev->mtu here?

>  
>  	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags) ||
>  	    (test_bit(IP_TUNNEL_CSUM_BIT, tunnel->parms.o_flags) &&

[ ... ]

> @@ -1471,6 +1476,7 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
>  	struct ip_tunnel *t = netdev_priv(dev);
>  	struct ip_tunnel_parm_kern p;
>  	__u32 fwmark = t->fwmark;
> +	int old_hlen = t->hlen;
>  	int err;
>  
>  	if (!rtnl_dev_link_net_capable(dev, t->net))
> @@ -1482,18 +1488,24 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
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
> +	 */
> +	ipgre_link_update(dev, !tb[IFLA_MTU], old_hlen);

[Severity: Low]
Should set_mtu still be !tb[IFLA_MTU] when arriving here from an error
path?  On the error paths the requested MTU is never applied, because
rtnl_changelink() returns as soon as changelink fails:

	err = ops->changelink(dev, tb, data, extack);
	if (err < 0)
		return err;

so do_setlink() does not run.  The mere presence of IFLA_MTU then
suppresses the recomputation, and ip_tunnel_refresh_lengths() throws the
computed value away:

	void ip_tunnel_refresh_lengths(struct net_device *dev, bool set_mtu)
	{
		int mtu = ip_tunnel_bind_dev(dev);

		if (set_mtu)
			WRITE_ONCE(dev->mtu, mtu);
	}

With, for instance,

	ip link set gre1 type gre encap fou encap-sport 1 encap-dport 2 \
		pmtudisc ignore-df mtu 1400

the encapsulation is committed, ipgre_netlink_parms() returns -EINVAL for
the IFLA_GRE_IGNORE_DF plus DF combination, and the goto runs with
set_mtu false, leaving dev->needed_headroom derived from the new header
length and dev->mtu from the old one.

>  
> -	return 0;
> +	return err;
>  }

[Severity: Medium]
There is one error return left above the new label that also runs after
the encapsulation was mutated:

	err = ipgre_newlink_encap_setup(dev, data);
	if (err)
		return err;

ip_tunnel_encap_setup() zeroes the live encapsulation before it validates
the candidate:

	memset(&t->encap, 0, sizeof(t->encap));

	hlen = ip_encap_hlen(ipencap);
	if (hlen < 0)
		return hlen;

so on failure the device keeps encap.type == TUNNEL_ENCAP_NONE while
t->encap_hlen and t->hlen still account for the previous encapsulation, and
this return skips the new refresh entirely.

Does the tunnel then stop encapsulating while keeping the encap-derived
lengths?  ip_tunnel_xmit() derives its work from tunnel->encap:

	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)

while dev->mtu stays reduced and dev->needed_headroom inflated for an
encapsulation that no longer exists, and the GSO decision in
ipgre_link_update() is not re-evaluated:

	if (test_bit(IP_TUNNEL_SEQ_BIT, tunnel->parms.o_flags) ||
	    (test_bit(IP_TUNNEL_CSUM_BIT, tunnel->parms.o_flags) &&
	     tunnel->encap.type != TUNNEL_ENCAP_NONE)) {

A later successful changelink recomputes tunnel->hlen = tun_hlen +
encap_hlen from the stale encap_hlen, so the wrong length is carried
forward rather than corrected.  Reproducer on a device that already has
encap fou: re-issue an encap request with the fou module unavailable, or
pass an IFLA_GRE_ENCAP_TYPE >= MAX_IPTUN_ENCAP_OPS, so ip_encap_hlen()
returns -EINVAL after the memset.  Would validating before the memset, or
clearing encap_hlen/hlen on failure, be preferable to refreshing here?

>  
>  static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],

[Severity: Low]
This isn't a bug introduced by this patch, but erspan_changelink() has the
same shape and also publishes a new encapsulation through
ipgre_newlink_encap_setup() -> ip_tunnel_encap_setup(), which sets

	t->encap_hlen = hlen;
	t->hlen = t->encap_hlen + t->tun_hlen;

dropping erspan_hdr_len() from t->hlen, and never refreshes
dev->needed_headroom or dev->mtu, so the defect described in this commit
message remains reachable there in this intermediate state:

	ip link set erspanX type erspan ... encap fou ...

The follow-up patch of this series, "ip_gre: recompute erspan header
lengths after a change", adds erspan_set_hlen()/erspan_link_update() and
calls erspan_link_update(dev, !tb[IFLA_MTU], old_hlen) from
erspan_changelink(), so this is closed by the end of the series and is
mentioned only for completeness.

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index e6bcf01411d0b..6b93c1fda4948 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -326,6 +326,22 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
>  	return mtu;
>  }
>  
> +/* Recompute dev->needed_headroom and dev->mtu after tunnel->hlen changed.
> + *
> + * Both are derived from tunnel->hlen, so they must be recomputed from it
> + * rather than adjusted by the difference: ip_tunnel_bind_dev() is also
> + * called from ndo_init() and from ip_tunnel_update(), and a driver adding
> + * its own delta on top would double count it.
> + */

[Severity: Low]
Is the ndo_init() part of this comment accurate?  ip_tunnel_bind_dev() is
static to net/ipv4/ip_tunnel.c, and after this patch its callers are
ip_tunnel_refresh_lengths(), ip_tunnel_create(), ip_tunnel_update(),
ip_tunnel_init_net() and ip_tunnel_newlink().  The ndo_init helper shared
by ip_gre/ipip/sit is __ip_tunnel_init(), which does not call it, and since
the function is static no driver outside this file can call it either.
Could the rationale be reworded to name the actual callers?

> +void ip_tunnel_refresh_lengths(struct net_device *dev, bool set_mtu)
> +{
> +	int mtu = ip_tunnel_bind_dev(dev);
> +
> +	if (set_mtu)
> +		WRITE_ONCE(dev->mtu, mtu);
> +}
> +EXPORT_SYMBOL_GPL(ip_tunnel_refresh_lengths);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912150944.3470971-1-edumazet%40google.com
