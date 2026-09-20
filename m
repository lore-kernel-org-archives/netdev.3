Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38523F58DC
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789901312; cv=none; b=At9g7QSgWcZorLYOBOXO6tVs6oFaMwlVpSextu86eBHj8CHMMZkyE8xRVkI9biDPUnzB8VnptuPAYWVdR4kwX/TFyZwAuVqRBRGZzort+Nzu2+Xv0ahXo03gVdkWb209Umcyxt2ZZpx+F8EzKxE+W+HMRJ+Dh7hPhX6bYv/fUKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789901312; c=relaxed/simple;
	bh=gQ4VbNLpzGnwWjitFd3g6EkH20qHEaJD9wiNbYcHhLc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mFFCLDgkOWxCnljkl+LK7c0BvTmzpACAOcTKwpr2jsldRycNM320oIVN405MnpUbI2F7M6LqEwXEE2dhZVLKNaFiJOEqOiMou4c6A89o8HusSL4x40oUSOc7BviGP42svmXUMY0I75gd1y74xGXhT7GoK6kVe9VLUCMq3xFN9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMR4n+Zb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMR4n+Zb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0931F000FF;
	Sun, 20 Sep 2026 10:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789901310;
	bh=zSbIO/sETRsGPgG5gEG1fuY4nvb6LzjCjXNsalg/mro=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mMR4n+ZbIWkPWl7HbL/4zRAAij8o3HaMM3dqRQBFrWOEmoTccdnf8OHJaHT0be7yg
	 uwlMx+m6xBOMvgxm4bk+ZtZWVM6zcg3db0Ja82fVrAVsuVzqb7SO7F9btVPojHFUC6
	 FkNArQI9cpDGXmaKvQM81qo+ooDyR4l4vdXEzOQzMak5XB5bVjz3c7aZrGjJOXhfLq
	 W3VLorImB5AUsivfD1etmaP1ydpz/bASxe0gTaUYU4kMs0kIjjhzxt3yTWEswo7wYx
	 A4NHEUODpFXxWMlcytKyvWe56P2GwOa+5h72mbVeK3Bm/uoH92ek8+hijRbCiraZyU
	 Ch9MQsxDiO73Q==
Subject:
 Re: [PATCH net v2 4/5] ip_gre: recompute erspan header lengths after a change
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Date: Sun, 20 Sep 2026 10:48:29 +0000
Message-ID: <178990130949.2160803.334551153943457141@kernel.org>
In-Reply-To: <20260916100155.1398403-5-edumazet@google.com>
References: <20260916100155.1398403-5-edumazet@google.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] erspan_set_hlen() (net/ipv4/ip_gre.c:1382) derives
  tunnel->tun_hlen from tunnel->erspan_ver alone (4 for version 0, 8…
- [High] erspan_changelink() now publishes the new ERSPAN version (inside
  erspan_netlink_parms(), 'All attributes parsed here have been…
- [Medium] erspan_changelink() publishes tunnel->erspan_ver (in
  erspan_netlink_parms()) and tunnel->tun_hlen / tunnel->hlen (in the…

Pre-existing issues:
- [Low] Reported by earlier stages, judged a non-issue during
  verification (baseline decision: false).

--

ip_gre: recompute erspan header lengths after a change

The patch factors the ERSPAN GRE/tunnel header length computation out of
erspan_tunnel_init() into erspan_set_hlen(), and adds erspan_link_update()
so that erspan_changelink() refreshes tunnel->tun_hlen, tunnel->hlen,
dev->needed_headroom and the MTU after a version or encapsulation change.
erspan_set_hlen() is also called before ip_tunnel_changelink() so that
ip_tunnel_update() and erspan_xmit() observe the new lengths.

A few questions about the new length computation and about the ordering on
the change path.

> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index ced57cbeaad49..696884f53cdcc 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -1379,18 +1379,43 @@ static const struct net_device_ops gre_tap_netdev_ops = {
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
Should this length also account for tunnel->parms.o_flags, the way
ipgre_link_update() does via gre_calc_hlen(o_flags)?

erspan_validate() returns early as soon as the request carries
IFLA_GRE_ERSPAN_VER == 0:

	if (data[IFLA_GRE_ERSPAN_VER] &&
	    nla_get_u8(data[IFLA_GRE_ERSPAN_VER]) == 0)
		return 0;

so the "only GRE sequence and key flag" restriction is skipped and GRE_CSUM
can end up in tunnel->parms.o_flags for a version-0 device.

erspan_xmit() then copies o_flags and clears only SEQ (version 0) and KEY:

	ip_tunnel_flags_copy(flags, tunnel->parms.o_flags);
	if (tunnel->erspan_ver == 0) {
		proto = htons(ETH_P_ERSPAN);
		__clear_bit(IP_TUNNEL_SEQ_BIT, flags);
	...
	__clear_bit(IP_TUNNEL_KEY_BIT, flags);
	__gre_xmit(skb, dev, &tunnel->parms.iph, proto, flags);

With IP_TUNNEL_CSUM_BIT still set and tun_hlen == 4, gre_build_header()
computes ptr == greh:

include/net/gre.h:gre_build_header() {
	...
	if (ip_tunnel_flags_intersect(flags, cond)) {
		__be32 *ptr = (__be32 *)(((u8 *)greh) + hdr_len - 4);
	...
		if (test_bit(IP_TUNNEL_CSUM_BIT, flags) && ...) {
			*ptr = 0;
			if (skb->ip_summed == CHECKSUM_PARTIAL) {
				*(__sum16 *)ptr = csum_fold(lco_csum(skb));
			} else {
				skb->ip_summed = CHECKSUM_PARTIAL;
				skb->csum_start = skb_transport_header(skb) - skb->head;
				skb->csum_offset = sizeof(*greh);
			}
		}
	}
}

Can this overwrite greh->flags and greh->protocol that were just written,
and in the CHECKSUM_NONE case place the GRE checksum 4 bytes past the
4-byte GRE header, i.e. inside the mirrored frame?

For an "erspan_ver 0 ocsum" device this configuration was previously
consistent after a version 1/2 -> 0 change, because tun_hlen stayed at 8,
which happens to match the CSUM layout. Does the new erspan_set_hlen(t)
call on the change path turn that into a 4-byte tun_hlen with CSUM still
set?

[ ... ]

> @@ -1529,6 +1554,7 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>  	struct ip_tunnel *t = netdev_priv(dev);
>  	struct ip_tunnel_parm_kern p;
>  	__u32 fwmark = t->fwmark;
> +	int old_hlen = t->hlen;
>  	int err;
>  
>  	if (!rtnl_dev_link_net_capable(dev, t->net))
> @@ -1540,16 +1566,29 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
>  
>  	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
>  	if (err < 0)
> -		return err;
> +		goto link_update;
> +
> +	erspan_set_hlen(t);
>  
>  	err = ip_tunnel_changelink(dev, tb, &p, fwmark);
>  	if (err < 0)
> -		return err;
> +		goto link_update;
>  
>  	ip_tunnel_flags_copy(t->parms.i_flags, p.i_flags);
>  	ip_tunnel_flags_copy(t->parms.o_flags, p.o_flags);

[Severity: High]
Here the new version (published inside erspan_netlink_parms() by
"All attributes parsed here have been validated, we can change @t") and the
new tun_hlen/hlen are committed before ip_tunnel_changelink(), while
o_flags is copied only on success. Can the failure path leave the two out of
sync?

ip_tunnel_changelink() can fail after both are already published:

net/ipv4/ip_tunnel.c:ip_tunnel_changelink() {
	t = ip_tunnel_find(itn, p, dev->type);

	if (t) {
		if (t->dev != dev)
			return -EEXIST;
	...
}

For example, with ers0 created as "type erspan erspan_ver 0 key 100 local A
remote B" and ersX as "type erspan erspan_ver 2 seq key 1000 local A remote
C", then:

	ip link set ers0 type erspan erspan_ver 2 seq key 1000 local A remote C

ip_tunnel_find() locates ersX, t->dev != dev, so -EEXIST is returned after
t->erspan_ver = 2 and tun_hlen = 8 have been stored, and o_flags keeps the
old value.

On the next transmit erspan_xmit() pushes the 12-byte v2 header and calls
__gre_xmit() -> gre_build_header(skb, 8, old_flags). If the old flags
contain neither SEQ nor CSUM (and KEY is cleared by erspan_xmit()), then
ip_tunnel_flags_intersect() is false and gre_build_header() only initialises
the 4-byte base header after having pushed 8 bytes.

Does that put 4 bytes of uninitialised skb headroom on the wire, with the
ERSPAN header offset by 4 bytes for the receiver? Before this patch the same
failed change left tun_hlen == 4, so exactly the pushed bytes were written.
Would it be better for the error path to reconcile version, GRE length and
flags together, or to roll the version back, rather than only refreshing
lengths?

[Severity: Medium]
A second question about the same two stores: t->erspan_ver is published
inside erspan_netlink_parms() and tun_hlen/hlen only on the following
statement, while erspan_xmit() and __gre_xmit() read all three locklessly
from ndo_start_xmit under RTNL-free conditions.

	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);   /* t->erspan_ver = 2 */
	if (err < 0)
		goto link_update;

	erspan_set_hlen(t);                                       /* tun_hlen = 8 */

A transmit landing between the two would read:

net/ipv4/ip_gre.c:erspan_xmit() {
	} else if (tunnel->erspan_ver == 2) {
		erspan_build_header_v2(...);          /* pushes 12 bytes */
	...
	__gre_xmit(skb, dev, &tunnel->parms.iph, proto, flags);
}

net/ipv4/ip_gre.c:__gre_xmit() {
	gre_build_header(skb, tunnel->tun_hlen,      /* still 4 */
			 flags, proto, tunnel->parms.o_key, ...);
}

which is the same greh + 4 - 4 write over greh->flags/greh->protocol the
commit message describes, and for a 2 -> 0 change the mirror image (8 bytes
pushed, 4 initialised). Is a consistent snapshot of the (version, tun_hlen)
pair, or at least WRITE_ONCE() plus ordering, worth adding here? The same
publish-then-recompute window exists in ipgre_changelink() for
o_flags/tun_hlen, so this may be a known residual rather than something new,
but the commit message states erspan_xmit() "sees a matching tun_hlen".

>  
> -	return 0;
> +link_update:
> +	/* ipgre_newlink_encap_setup() has published a new encapsulation, and
> +	 * erspan_netlink_parms() a new ERSPAN version, both of which change
> +	 * the header length. Refresh the lengths on the error paths as well,
> +	 * since both leave the new encapsulation or version behind.
> +	 *
> +	 * As in ipgre_changelink(), IFLA_MTU must not hold the MTU back if we
> +	 * return an error, because do_setlink() will not apply it then.
> +	 */
> +	erspan_link_update(dev, err || !tb[IFLA_MTU], old_hlen);
> +
> +	return err;
>  }

[Severity: Low]
This is a pre-existing behaviour and not introduced by the patch, but on a
successful change carrying IFLA_MTU the automatic refresh is suppressed and
the MTU is left to do_setlink(), which can still fail:

net/core/rtnetlink.c:do_setlink() {
	if (tb[IFLA_MTU]) {
		err = netif_set_mtu_ext(dev, nla_get_u32(tb[IFLA_MTU]), extack);
		if (err < 0)
			goto errout;
	...
}

In that case the device keeps an MTU derived from the old, shorter header
(for instance 65497 from a version-0 device while the bound computed by
ip_tunnel_change_mtu() drops to 65481 for version 2). The
"set_mtu = !tb[IFLA_MTU]" convention is what ip_tunnel_changelink() already
passes to ip_tunnel_update(), and tnl_update_pmtu() re-derives the limit on
every transmit, so nothing malformed goes out. Mentioning it only in case
the deferred-MTU failure is worth handling here.

Also, the new comment above erspan_link_update() says both
tunnel->erspan_ver and tunnel->encap_hlen "feed tunnel->hlen"; given the
first question above, would it be accurate to mention tunnel->parms.o_flags
as an input to the GRE header length as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916100155.1398403-1-edumazet%40google.com
