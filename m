Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC9476CF1
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789474274; cv=none; b=sMs8FmWWr6fneKK8II2fMPmme3k9cKWvpdl6+BbXOmcz0ooJK0T91VaCcJXIovqHLyZir96l6OenJ+pfoCGKHkoLEcb4E6tYxnDbSuZRiN2aHEY02d392tlLHcUq3j1UTnHYufnXaVAfYN1zY1UeQAx/jbmr+Itahn0tAC+3NkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789474274; c=relaxed/simple;
	bh=CjNBHLspHXg9N7GXyDTlkALGmhEwCueFaHKo6AQ4CqY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gZv29V7wKAaWGVvHZUSsxoMcFmDJ6D8wsnuBI3pEh09EtVJCDCN28XmYDeMroeNXGzrW4SBJdYBELz6zcob5xnq6olTBkW2YKbmq9V6jh708nh7c0E9zDXSS/6INDHWv6E0oh9jLDX4H4t4irjH14f7InOyZLe4ZNjKlsiE1NOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M66YJS06; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M66YJS06"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD37A1F00898;
	Tue, 15 Sep 2026 12:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789474272;
	bh=HC8uUKKDsLvkq0liUPHgpPNt/mWH+S6hdxJQ6Z0jieg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M66YJS062QyVkQtVJA7kTg6EpJztZt+hRKi65V1vxqv2rcz0xdZx68bZjO90WIM+s
	 V+pscKf68Ms8u4zo+fLJuWhMH3n20uDzdInJrQUeELlcszzO7yVy9gWtJrbvNiW+yE
	 Dls5CdLlAd8nRyPuTiWPLh/7hj1izvNZgpisXJ/ORX8eB+7phrs8g8hyElHd4MBknE
	 IbMAmnYniZyC9RDttq5Lzsr+gZhNFuzQHdXTCfGK3P7BF43iI77LYY/MU8/YQsiEJi
	 /L8jetb0YHgz6N1sWkS6DZdJ9YwyHBXP1+5luc3Ep+NMIfZ7ejU4rzorCXAJ7/Cit7
	 UNxr5cSkCK4cQ==
Subject:
 Re: [PATCH net 3/3] ip_gre: recompute erspan header lengths after a change
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Date: Tue, 15 Sep 2026 12:11:11 +0000
Message-ID: <178947427138.22033.5342566718329015642@kernel.org>
In-Reply-To: <20260912150944.3470971-4-edumazet@google.com>
References: <20260912150944.3470971-4-edumazet@google.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0

- [High] erspan_set_hlen() (net/ipv4/ip_gre.c:1371), now the single
  authority for ERSPAN tun_hlen/hlen and called from the new…
- [Medium] Commit message mischaracterizes the failure mode: the claimed
  skb_under_panic() in erspan_xmit() is not reachable, and the quoted…

Pre-existing issues:
- [Medium] erspan_changelink() (net/ipv4/ip_gre.c:1548-1550) returns
  immediately when ipgre_newlink_encap_setup() fails, and…

--

ip_gre: recompute erspan header lengths after a change

This moves the ERSPAN tun_hlen/hlen computation out of erspan_tunnel_init()
into a new erspan_set_hlen() helper, and adds erspan_link_update() so that
erspan_changelink() refreshes the header lengths, dev->needed_headroom and
the MTU after the ERSPAN version or the encapsulation changes.

A few questions below.

> erspan_xmit() calls skb_cow_head(skb, dev->needed_headroom) before
> erspan_build_header[_v2]() pushes the header. Going from version 0 to
> version 2 adds 20 bytes, so a packet with little headroom can hit
> skb_under_panic().

[Severity: Medium]
Is this description of the failure mode accurate?

erspan_xmit() cows to dev->needed_headroom, and ip_tunnel_bind_dev() always
computes that from tunnel->hlen plus the outer IP header:

net/ipv4/ip_tunnel.c:ip_tunnel_bind_dev() {
	...
	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
	...
	dev->needed_headroom = ip_tunnel_limit_headroom(t_hlen + hlen);
}

ip_tunnel_limit_headroom() only clamps at 512, so for any ERSPAN device
needed_headroom is at least 4 + 20 = 24 bytes. With a stale v0 length the
transmit path pushes at most erspan_hdr_len(2) = 12 bytes plus tun_hlen <= 8
bytes before ip_tunnel_xmit() cows again for the outer headers, i.e. at most
20 bytes into a 24 byte reserve.

Can skb_under_panic() actually be reached here? The changelog of the
preceding patch in the series states the opposite for plain GRE ("There is
no memory safety issue: ip_tunnel_xmit() computes its own headroom ... and
calls skb_cow_head() before pushing the encapsulation").

Also, going from version 0 to version 2 takes hlen from tun_hlen 4 (plus
encap) to 8 + 12 (plus encap), which is a 16 byte increase rather than 20
(20 is the total v2 push, not the delta). Could the message instead describe
the malformed GRE/ERSPAN header and the stale MTU/needed_headroom, which are
what the patch actually fixes?

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 556ebf2c5bd0d..4807fc6d2fd88 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1368,18 +1368,43 @@ static const struct net_device_ops gre_tap_netdev_ops = {
>  	.ndo_fill_metadata_dst	= gre_fill_metadata_dst,
>  };
>  
> +static void erspan_set_hlen(struct ip_tunnel *tunnel)
> +{
> +	/* Version 0 uses a 4-byte GRE header, other versions use 8 bytes. */
> +	tunnel->tun_hlen = tunnel->erspan_ver == 0 ? 4 : 8;
> +
> +	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
> +		       erspan_hdr_len(tunnel->erspan_ver);
> +}

[Severity: High]
Should this derive tun_hlen from tunnel->parms.o_flags rather than from
erspan_ver only? The sibling helper ipgre_link_update() uses
gre_calc_hlen(tunnel->parms.o_flags), and erspan_changelink() can rewrite
o_flags in the same request via ip_tunnel_flags_copy().

The writer takes its length from tun_hlen but its content from o_flags:

net/ipv4/ip_gre.c:__gre_xmit() {
	...
	gre_build_header(skb, tunnel->tun_hlen,
			 flags, proto, tunnel->parms.o_key,
	...
}

Two combinations look reachable.

First, erspan_validate() only checks the OR of the two flag attributes:

net/ipv4/ip_gre.c:erspan_validate() {
	...
	if (!data[IFLA_GRE_COLLECT_METADATA] &&
	    flags != (GRE_SEQ | GRE_KEY))
		return -EINVAL;
	...
}

so IFLA_GRE_IFLAGS = GRE_SEQ|GRE_KEY together with IFLA_GRE_OFLAGS = 0 is
accepted for v1/v2. tun_hlen then becomes 8 while o_flags is empty, and
gre_build_header() skips the option-word block entirely:

include/net/gre.h:gre_build_header() {
	...
	if (ip_tunnel_flags_intersect(flags, cond)) {
		__be32 *ptr = (__be32 *)(((u8 *)greh) + hdr_len - 4);
	...
}

Does this transmit 4 bytes of uninitialised skb headroom between the GRE
base header and the ERSPAN header, and make receivers (which size the GRE
header from the flags field) mis-parse the ERSPAN header?

Second, erspan_validate() returns early for IFLA_GRE_ERSPAN_VER == 0, so
GRE_CSUM stays permitted for version 0, and erspan_xmit() only clears
SEQ/KEY for v0:

net/ipv4/ip_gre.c:erspan_xmit() {
	...
	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
	...
		__clear_bit(IP_TUNNEL_SEQ_BIT, flags);
	...
}

After this patch, a v1/v2 -> v0 changelink with ocsum now sets tun_hlen = 4
where it previously kept 8 (which happened to match gre_calc_hlen(CSUM)).
With hdr_len == 4 the ptr computation above lands on greh itself. Can the
checksum word overwrite greh->flags and greh->protocol in that case?

>  static int erspan_tunnel_init(struct net_device *dev)
>  {
>  	struct ip_tunnel *tunnel = netdev_priv(dev);
>  
> -	if (tunnel->erspan_ver == 0)
> -		tunnel->tun_hlen = 4; /* 4-byte GRE hdr. */
> -	else
> -		tunnel->tun_hlen = 8; /* 8-byte GRE hdr. */
> +	erspan_set_hlen(tunnel);
>  
>  	tunnel->parms.iph.protocol = IPPROTO_GRE;
> -	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
> -		       erspan_hdr_len(tunnel->erspan_ver);
>  
>  	dev->features		|= GRE_FEATURES;
>  	dev->hw_features	|= GRE_FEATURES;

[ ... ]

> @@ -1525,6 +1551,16 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>  		return err;
>  
>  	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch, but since the
patch is adding a length refresh on the erspan_netlink_parms() error path,
should the ipgre_newlink_encap_setup() error path just above get similar
attention?

erspan_changelink() returns straight away there:

net/ipv4/ip_gre.c:erspan_changelink() {
	...
	err = ipgre_newlink_encap_setup(dev, data);
	if (err)
		return err;
	...
}

and ip_tunnel_encap_setup() wipes the live descriptor before validating the
requested type:

net/ipv4/ip_tunnel.c:ip_tunnel_encap_setup() {
	...
	memset(&t->encap, 0, sizeof(t->encap));

	hlen = ip_encap_hlen(ipencap);
	if (hlen < 0)
		return hlen;
	...
}

ipgre_netlink_encap_parms() takes the type from nla_get_u16() without a
range check, and ip_encap_hlen() rejects type >= MAX_IPTUN_ENCAP_OPS or an
unregistered ops pointer. Does a rejected IFLA_GRE_ENCAP_TYPE therefore
disable an active FOU/GUE encapsulation on the running tunnel while
t->encap_hlen, t->hlen, dev->needed_headroom and dev->mtu still account for
it, so the tunnel keeps the reduced MTU and starts emitting un-encapsulated
packets? Would validating before publishing in ip_tunnel_encap_setup() be
the better place to address this?

> +
> +	/* ipgre_newlink_encap_setup() has published a new encapsulation, and
> +	 * erspan_netlink_parms() a new ERSPAN version, both of which change
> +	 * the header length. Refresh the lengths before looking at @err:
> +	 * erspan_xmit() sizes its push from tunnel->erspan_ver, and both this
> +	 * error path and ip_tunnel_changelink() below leave the new
> +	 * encapsulation behind.
> +	 */
> +	erspan_link_update(dev, !tb[IFLA_MTU], old_hlen);
> +
>  	if (err < 0)
>  		return err;
>  

Note that erspan_link_update() runs here, before ip_tunnel_changelink() and
the following ip_tunnel_flags_copy() calls install the accepted o_flags, and
no further length refresh follows, which is what makes the o_flags question
above visible on the changelink path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912150944.3470971-1-edumazet%40google.com
