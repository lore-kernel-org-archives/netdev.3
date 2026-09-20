Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303D33557D
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789901308; cv=none; b=ZMV34xW5MW5WVtzGGD+lpihiBDMFX+5p7L7aiOJRlaFJXnR9OjPXm2CEL2qqk8CdLelJ6z9ovnvLRbzlT2a2CExF2HgRge+av1sHodvdxjBPjPyseDMTPnT9J+tfmYBkd8Jr1j/58FPRnGwk3Ef0cgI1GsK9ViPyedZPAY9L/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789901308; c=relaxed/simple;
	bh=KgCiz3Uv+cP5eV3OoEORlq5INiRtsJDsCENqAaHrPs0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GbTxJFdYtSJ3C4AwPluIv60qD0GhP5hVbZ0pq97I+SmLoSDUMwD7RYhZzwzfO7AMeFcGIk+2IzkEkMnM4aMylyPiDrnZw20uFHG0ImreCaxp+8NZZkh0uOBIVbX5MyYlqOuthWem8qMXWik4uKLDM1LDKZ2zwJspSFcFmruPR5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8Tenykg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8Tenykg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55FF1F000FF;
	Sun, 20 Sep 2026 10:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789901307;
	bh=Xtb5/eTIh4fhm5fkM58uXM35TJtrjXmBGLXLmhEHpyU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j8TenykgmOw/p+KFkhITBbPHTeQWEHjBIc6vQ9dS+3FG1ZpXpO7YyRcgj2qPHeJs5
	 5QqdKAlwj6PlH2Gn2cA2VQDdJhNzRjCKsMBfoh482vcZfacDs6N/+suH2JILl/WR5y
	 qGdGZvRbqDlAN4xGZr9XjfZOTFEjQzj4S8Uu21+BDnKMldI0HcTTWhQ7j2o98HERTi
	 kLbhkrTZK8Q5YQWpjxmNZxe6JVkBfbFNeGbzE1BSPjooZRdfazk/vH+EyOr90gaelJ
	 mfjY/T9Y+jMHNXVrGcFhCAo2TifGNK/+Heee3SFdDdfNSCjeegyLrqThZpvPKzhn7j
	 OhVKel4tCGY6A==
Subject: Re: [PATCH net v2 1/5] ip_tunnel: do not clear the active encap
 before validating the new one
From: netdev-bot+sashiko@kernel.org
To: edumazet@google.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Date: Sun, 20 Sep 2026 10:48:26 +0000
Message-ID: <178990130628.2160803.10741018985602463967@kernel.org>
In-Reply-To: <20260916100155.1398403-2-edumazet@google.com>
References: <20260916100155.1398403-2-edumazet@google.com>
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
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the commit message claims that removing the
  memset() makes it so that "a failed changelink leaves the active…

Pre-existing issues:
- [Medium] ip_tunnel_encap_setup() (net/ipv4/ip_tunnel.c:498-504) and
  ip6_tnl_encap_setup() (net/ipv6/ip6_tunnel.c:1825-1831) publish…

--

ip_tunnel: do not clear the active encap before validating the new one

This removes the memset() of t->encap from ip_tunnel_encap_setup() and
ip6_tnl_encap_setup() so that a failing ip_encap_hlen() / ip6_encap_hlen()
no longer leaves the tunnel with TUNNEL_ENCAP_NONE while encap_hlen and
hlen keep their old values.

> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index e6bcf01411d0b..2a313b18134e2 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -491,8 +491,6 @@ int ip_tunnel_encap_setup(struct ip_tunnel *t,
>  {
>  	int hlen;
>  
> -	memset(&t->encap, 0, sizeof(t->encap));
> -
>  	hlen = ip_encap_hlen(ipencap);
>  	if (hlen < 0)
>  		return hlen;

[Severity: High]
The changelog says the result is that "a failed changelink leaves the
active encapsulation untouched".  Is that true for the callers, though?

ip_tunnel_encap_setup() and ip6_tnl_encap_setup() still write directly
into the live tunnel (t->encap.{type,sport,dport,flags}, t->encap_hlen
and t->hlen), and every changelink caller runs them before the rest of
the netlink request is validated.  For example ip6_tnl_changelink():

	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
		int err = ip6_tnl_encap_setup(t, &ipencap);

		if (err < 0)
			return err;
	}
	ip6_tnl_netlink_parms(data, &p);
	if (p.collect_md)
		return -EINVAL;

	t = ip6_tnl_locate(net, &p, 0);
	if (!IS_ERR(t)) {
		if (t->dev != dev)
			return -EEXIST;

The same ordering exists in ipip_changelink() and ipip6_changelink()
(both call ip_tunnel_encap_setup() and then reject the request with
-EINVAL for collect_md / the IFF_POINTOPOINT vs p.iph.daddr mismatch,
or -EEXIST from ip_tunnel_changelink() / ipip6_tunnel_locate(), or an
error from ipip6_tunnel_update_6rd()), in ip6gre_changelink_common()
(commits encap, then can return ERR_PTR(-EEXIST)), and in
ipgre_changelink() / erspan_changelink() via
ipgre_newlink_encap_setup() before the parsers run.

Can that still disable FOU/GUE on a working tunnel with a rejected
request?  ip_tunnel_netlink_encap_parms() returns true for any of
IFLA_IPTUN_ENCAP_TYPE/FLAGS/SPORT/DPORT and memsets the parsed struct
first:

	memset(encap, 0, sizeof(*encap));
	...
	if (data[IFLA_IPTUN_ENCAP_SPORT]) {
		ret = true;
		encap->sport = nla_get_be16(data[IFLA_IPTUN_ENCAP_SPORT]);
	}

so a message carrying only ENCAP_SPORT (or ENCAP_TYPE=0) reaches
encap_setup with type == TUNNEL_ENCAP_NONE, where ip[6]_encap_hlen()
returns 0 and the store always succeeds.  Combine that with an
attribute set that is rejected afterwards (collect_md, or a
local/remote pair colliding with another tunnel giving -EEXIST) and the
tunnel loses its encapsulation and gets t->hlen recomputed while
userspace is told the request failed.

For ipip, sit, ip6_tunnel and ip6_gre no length refresh runs on those
error paths either, so dev->mtu and dev->needed_headroom keep the values
derived from the old encapsulated header length, which is the mismatched
state described in the changelog.

Would it make more sense to validate the requested encapsulation into a
temporary struct and apply it to the tunnel only after all the other
checks have passed, rather than only dropping the memset()?

For reference, at the end of this series the ordering is unchanged for
ipip, sit, ip6_tunnel and ip6_gre, and the later patch "ip_gre: validate
netlink attributes before changing the tunnel" states that
ip_tunnel_encap_setup() still runs before the parsers.

> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index d5ff50a2ac017..c918c2b0ad81b 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1818,8 +1818,6 @@ int ip6_tnl_encap_setup(struct ip6_tnl *t,
>  {
>  	int hlen;
>  
> -	memset(&t->encap, 0, sizeof(t->encap));
> -
>  	hlen = ip6_encap_hlen(ipencap);
>  	if (hlen < 0)
>  		return hlen;

[Severity: Medium]
This is a pre-existing issue and not something introduced here, but while
these two functions are being touched: is the publication of the new
encapsulation to the lockless transmit path worth annotating in the same
patch?

ip_tunnel_encap_setup() and ip6_tnl_encap_setup() store the four
t->encap fields plus t->encap_hlen and t->hlen with plain writes under
RTNL:

	t->encap.type = ipencap->type;
	t->encap.sport = ipencap->sport;
	t->encap.dport = ipencap->dport;
	t->encap.flags = ipencap->flags;

	t->encap_hlen = hlen;
	t->hlen = t->encap_hlen + t->tun_hlen;

while ip_encap_hlen() / ip_tunnel_encap() in include/net/ip_tunnels.h and
ip6_encap_hlen() / ip6_tnl_encap() in include/net/ip6_tunnel.h read them
in softirq context with no lock held, e.g.:

	rcu_read_lock();
	ops = rcu_dereference(ip6tun_encaps[t->encap.type]);
	if (likely(ops && ops->build_header))
		ret = ops->build_header(skb, &t->encap, protocol, fl6);

Can a packet already in ip_tunnel_xmit() / ip6_tnl_xmit() see the new
encap.type together with the stale sport/dport/flags, or the new type
together with the stale encap_hlen/hlen used for headroom and MTU
accounting?

The changelog notes that net-next commit 88b84cae6b94 ("ip_tunnel: use
WRITE_ONCE in ip_tunnel_encap_setup") covers the IPv4 side there; the
IPv6 side has no equivalent, and no reader uses READ_ONCE(), so these
stay plain data races that KCSAN can report.  The array index itself is
fine, since ip[6]_encap_hlen() rejects any type >= MAX_IPTUN_ENCAP_OPS
before the store, so iptun_encaps[] / ip6tun_encaps[] cannot be indexed
out of bounds.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916100155.1398403-1-edumazet%40google.com
