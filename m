Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EFF524AFD
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865257; cv=none; b=rg11tWe6KoTqheEmihJmoFfNU8pSha124zhUs4w2vxB6BlgkpDrvXp7591onvAe9PSgpTqgy7tAbdIjaOqtUWvbNRuYWxVi2br8eduf+RKucQNu/CQHkfAyfwGZCjjDUYxViVK4RRmcr8RIxOUkOY2Nc5Rb8pJuPHolVAeymYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865257; c=relaxed/simple;
	bh=2WYa+70zipbJmwLAYdIgl1t9QXrMVetzHFv8RvSLBN0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pBGYmkhNHUOtEDck9qLt9CREzpkHD4sXxzgR0QIlUMrNbRcL8S4/en+vsi5C6Vl43ACUGUmcYVSTay2mngEIR7tot5ftKpPNYbq3PhxvearIQ84OOe0wRVqf5i2xiRWxj3UuUcs8eK9pLu566zx6EpZ4VlMxkdrOAh1Vxmnxyug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMmGLG5X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMmGLG5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9121F00A3D;
	Tue,  8 Sep 2026 11:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788865255;
	bh=1pnczMZRvepZTmBqV77S/5s+cBlfFiVKME0NQnP8GsE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lMmGLG5Xb5jcevPgQA8YLXTaNS3zjl1h3M0CFwTcM+DjunFb74g6tc+aT1WUS50r8
	 Q+kCllRdNZjrlC59jQ52qyCMTcZ+G8OocePJzNS+An+XUPNwOIw4E/1noZx3RBhev8
	 +TtMzjS7TDsgULrJ+WbKt0UrQ8Remrskt4qT09fwpMekCKxfSIAdbQCTmVn7+jZ0iE
	 KSGFHpQOoM3mvdR1bUzdli1XSPIUADrMGZ/JBkFc0ffqvcjamo2HaQLb+gNR1asPBv
	 ZrP1i1yAa5zq1rid+dO5kEbjMEt8WLh7ubCSRwP6mCt7sgA8bnLE6e24D5xx7vN3WY
	 JOuwyihuMpusg==
Subject:
 Re: [PATCH net-next 3/9] ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, idosch@nvidia.com, kuniyu@google.com,
 lorenzo.bianconi@oss.qualcomm.com, iprintercanon@gmail.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Date: Tue, 08 Sep 2026 11:00:53 +0000
Message-ID: <178886525392.219967.1699334103836779845@kernel.org>
In-Reply-To: <20260907075846.2913645-4-edumazet@google.com>
References: <20260907075846.2913645-4-edumazet@google.com>
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

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0

- [Medium] The mirror helper ip6_tnl_encap_setup()
  (net/ipv6/ip6_tunnel.c:1816) is left unconverted, so the exact bug…

Pre-existing issues:
- [Medium] ip_tunnel_encap_setup() recomputes t->hlen as 'hlen +
  t->tun_hlen' (net/ipv4/ip_tunnel.c:504), which disagrees with the…
- [Medium] The six encap/hlen fields are published as independent
  WRITE_ONCE() stores with no seqcount, RCU pointer swap or release…

--

ip_tunnel: use WRITE_ONCE in ip_tunnel_encap_setup

This converts the encap field and hlen stores in ip_tunnel_encap_setup()
to WRITE_ONCE() so lockless readers such as fill_info cannot observe torn
values.  It also drops the memset() of t->encap, which both removed a
transient all-zero window for readers and stopped leaving t->encap cleared
when ip_encap_hlen() fails.

No Link: tags present in the commit header.

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index e6bcf01411d0b..13b5e35e8790b 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -491,19 +491,17 @@ int ip_tunnel_encap_setup(struct ip_tunnel *t,
>  {
>  	int hlen;
>  
> -	memset(&t->encap, 0, sizeof(t->encap));
> -
>  	hlen = ip_encap_hlen(ipencap);
>  	if (hlen < 0)
>  		return hlen;

[Severity: Medium]
Should the IPv6 twin get the same treatment?  ip6_tnl_encap_setup() in
net/ipv6/ip6_tunnel.c still has the original shape at this commit:

net/ipv6/ip6_tunnel.c:ip6_tnl_encap_setup() {
	memset(&t->encap, 0, sizeof(t->encap));

	hlen = ip6_encap_hlen(ipencap);
	if (hlen < 0)
		return hlen;

	t->encap.type = ipencap->type;
	t->encap.sport = ipencap->sport;
	t->encap.dport = ipencap->dport;
	t->encap.flags = ipencap->flags;

	t->encap_hlen = hlen;
	t->hlen = t->encap_hlen + t->tun_hlen;
}

So the "t->encap was left cleared even if ip_encap_hlen() failed" case
described in the changelog is still reachable for ip6tnl and ip6gre, on
already configured tunnels:

ip6_tnl_changelink()
    ip6_tnl_encap_setup(t, &ipencap)   /* t is live */
        memset(&t->encap, 0, ...)
        ip6_encap_hlen() returns -EINVAL   /* e.g. fou6 ops not registered,
                                              or type >= MAX_IPTUN_ENCAP_OPS */
        return hlen

ip6gre_changelink_common() reaches the same helper the same way.  The
netlink command fails, but the live tunnel's encapsulation configuration
has already been wiped.

The plain stores after the memset in ip6_tnl_encap_setup() also leave the
transient all-zero encap visible to ip6_tnl_fill_info()/ip6gre_fill_info(),
which run without RTNL since RTM_GETLINK is registered with
RTNL_FLAG_DOIT_UNLOCKED | RTNL_FLAG_DUMP_UNLOCKED in
net/core/rtnetlink.c, and to the ip6 xmit path.

>  
> -	t->encap.type = ipencap->type;
> -	t->encap.sport = ipencap->sport;
> -	t->encap.dport = ipencap->dport;
> -	t->encap.flags = ipencap->flags;
> +	WRITE_ONCE(t->encap.type, ipencap->type);
> +	WRITE_ONCE(t->encap.sport, ipencap->sport);
> +	WRITE_ONCE(t->encap.dport, ipencap->dport);
> +	WRITE_ONCE(t->encap.flags, ipencap->flags);

[Severity: Medium]
This is a pre-existing issue, not something this patch introduces, but is
it worth noting in the changelog that WRITE_ONCE() only removes torn reads
and does not give readers a coherent snapshot?

encap.type, the field that gates encapsulation, is still published first,
with no seqcount or RCU pointer swap, so a reader can pair the new type
with the stale sport/dport/flags or with the stale (smaller) encap_hlen and
hlen.  The same ordering existed before the patch (with zeroes instead of
stale values), so nothing gets worse here.

On the transmit side the two reads are separated:

net/ipv6/sit.c:ipip6_tunnel_xmit() {
	int t_hlen = tunnel->hlen + sizeof(struct iphdr);
	...
	max_headroom = LL_RESERVED_SPACE(tdev) + t_hlen;
	if (skb_headroom(skb) < max_headroom || ...)
		new_skb = skb_realloc_headroom(skb, max_headroom);
	...
	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0) {
}

The headroom comes from the earlier hlen snapshot while ip_tunnel_encap()
reads the live tunnel->encap, and fou_build_udp()/__gue_build_header() use
skb_push().  I could not show that the reserved headroom is actually
exceeded, since skb_realloc_headroom()/__skb_cow() round expansions up, so
this part is speculative.

>  
> -	t->encap_hlen = hlen;
> -	t->hlen = t->encap_hlen + t->tun_hlen;
> +	WRITE_ONCE(t->encap_hlen, hlen);
> +	WRITE_ONCE(t->hlen, hlen + t->tun_hlen);

[Severity: Medium]
This isn't a bug introduced by this patch, since the formula is unchanged
(t->encap_hlen + t->tun_hlen before, hlen + t->tun_hlen after), but does
this hlen formula disagree with the ERSPAN one?

net/ipv4/ip_gre.c:erspan_tunnel_init() {
	tunnel->hlen = tunnel->tun_hlen + tunnel->encap_hlen +
		       erspan_hdr_len(tunnel->erspan_ver);
}

erspan_changelink() reaches this helper on an already initialised device:

erspan_changelink()
    ipgre_newlink_encap_setup()
        ip_tunnel_encap_setup()      /* last writer of t->hlen */

ndo_init does not run again on that path, so an
"ip link set <erspan> type erspan encap ..." command appears to drop
erspan_hdr_len() (12 bytes for v1, 16 for v2) from t->hlen.
ip_tunnel_bind_dev() then derives both the MTU and

	dev->needed_headroom = ip_tunnel_limit_headroom(t_hlen + hlen);

from the smaller value, while erspan_xmit() only does
skb_cow_head(skb, dev->needed_headroom) before pushing the erspan header,
the GRE header, the encap header and the outer IPv4 header.

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907075846.2913645-1-edumazet%40google.com
