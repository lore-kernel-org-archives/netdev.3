Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344322;
	b=zdkTGu9pcWE7K5EhqQWHPXzUc3gSAh2TIv9wcQXNndj1c4KKcDQ5JPlYRPYplMG7ZcT1
	 qwfoWTjFA7NZ+Zve6u/4BUI+w9kkVJagrs2SwLE7CKDqxhki2apqU+OB8dIN7PmiwWZk+
	 8NUZS4C5jRC0FVDVU31V/OtmNT1WFyhflTZ/TrHu2sGw33oTZ8qMjds1dqCEfydx/5OzL
	 +IQ6YwI0vPqv/YLNH3JkPQZRLSDH7+zNFNkHZyp9jo2rC9NHnpYGZCb1pmFh8ueFGkgH5
	 VJB1gwvY/XPPrqVZBz069l29RY50jyFt+LuLqoLmezn4HJ5Ip6l14p8tNX37juGxrgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344322;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ab1Y4a2opdPjndxb5YBYW98/QiDJ0m0oBjPEITs6l+E=;
	b=ljUWyIpi4WSalZ76kvjy5JuKKCAFUwQIA0zkXM2jeaubRHD8GTj6s4VgaUzWkDtlqhVe
	 2euX3fQClkk3UB8bBeok07dbimiDZ4BuvQNYHroMI8CqswGZmQH6FWCHnmtJCm0BEArog
	 vA66Nbi8KJJBSV38wAJ3AFIc9V4YKKUMkvvzDWQRCzEAy0PfcaFZcLcdqFb+5WpbiF1Dq
	 OBXkYbf9A8QSEauzMd4rak+bLKrQcY3jb1EuggKLg5U3W/yYp1u0JA4v0hdUQDX5HVkvT
	 9DiIKlnokCFFkO1ylP1kJyDr6qQ17PV6Gj+7MNWakZozjXyCB7Jtk2NVo3aiU12odsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1+s5ZC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7A606A32E;
	Tue, 10 Nov 2026 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D1+s5ZC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88A31F0089F;
	Tue, 10 Nov 2026 20:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344321;
	bh=ab1Y4a2opdPjndxb5YBYW98/QiDJ0m0oBjPEITs6l+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D1+s5ZC9NaCe/pXn8/7c8nfH560r5x6nbafR5BAbOh5MxKbPeY4ZNopGSNnaKhUUl
	 VrxX4Jx3PS/6ICacp+7wf+T7g/r78U5oiDMxJ+2e/TFRPOO5JctOKnZBkdy5uebWE0
	 UXT8GoiGsd1q/NKQpjh3hDmsU1DZGAy/yfR2x4RRMF84LQZKut9WvVRAcLtIfCvMPJ
	 hwHIzAC/DzFFD4cs94VDUlYwN09iksM7LI+mXvkJJHSyBQbHnap7ByyuIFuLWDB4Rc
	 Jr6BTSvxFmJ0rAaOBHfOOxfN2tZVUs+4W+inKTcVZJr2BYe2pcwCmfKPvCbOjp1Kvg
	 uAgQX7yytUrQQ==
From: Jakub Kicinski <kuba@kernel.org>
To: yanxia@cmss.chinamobile.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	kuniyu@google.com,
	xeb@mail.ru,
	yana06070@163.com,
	netdev-bot+sashiko@kernel.org
Subject: Re: [PATCH net-next v2] ip6_gre: fix changelink conflict checks for L2 tunnels
Date: Tue, 10 Nov 2026 12:58:38 -0800
Message-ID: <20261110205838.2246603-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104150330.70963-1-yanxia@cmss.chinamobile.com>
References: <20261104150330.70963-1-yanxia@cmss.chinamobile.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ip6_gre: fix changelink conflict checks for L2 tunnels

This commit changes ip6gre_changelink_common() to use ip6gre_tunnel_find()
with dev->type instead of ip6gre_tunnel_locate(). That way, L2 tunnels are
checked against tunnels of their own type. It also makes
ip6gre_tunnel_find() skip collect_md entries while walking the bucket.

> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index b5d6ed8f0c369..07f7220df938f 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -306,6 +306,9 @@ static struct ip6_tnl *ip6gre_tunnel_find(struct net *net,
>  	head = __ip6gre_bucket(ign, parms);
>  
>  	hlist_for_each_entry(t, head, hash_node) {
> +		if (t->parms.collect_md)
> +			continue;
> +

[Severity: Medium]
Could skipping collect_md entries here reopen the misdelivery this commit
is meant to close, in the case where the other tunnel is collect_md?

ip6gre_tunnel_link() still links collect_md tunnels into the hash buckets
with hlist_add_head_rcu(). The receive walk in ip6gre_tunnel_lookup()
never checks collect_md:

	head = &ign->tunnels_wc[h1];
	hlist_for_each_entry_rcu(t, head, hash_node) {
		if (t->parms.i_key != key ||
		    !(t->dev->flags & IFF_UP))
			continue;

		if (ip6gre_tunnel_match(t, dev_type, link, &cand_score, &cand))
			return cand;
	}

When two entries score the same, the first one in the bucket wins. That
is normally the one linked most recently.

For example:

  ip link add md0 type ip6gretap external
  ip link add tap1 type ip6gretap

Before this patch, the second command failed with EEXIST because
ip6gre_tunnel_find(..., ARPHRD_ETHER) matched md0. Changing an existing
ordinary ip6gretap to zero params with changelink was rejected too,
because locate matched ip6gre0.

With this patch both succeed. tap1 ends up at the head of tunnels_wc[0]
and takes the keyless traffic md0 used to get, without the metadata dst.

The same looks possible for ip6erspan. It also looks possible for L3
ip6gre collect_md tunnels with explicit params, through
SIOCADDTUNNEL/SIOCCHGTUNNEL and ip6gre_tunnel_locate().

The commit message says:

  Skip collect_md entries while walking the bucket: they can coexist with
  ordinary tunnels with the same lookup parameters

That holds for the per-net collect_md_tun pointers. Does it also hold for
the receive demux in ip6gre_tunnel_lookup()?

Before this patch, that coexistence could only happen if the ordinary
tunnel was created first.

[Severity: Medium]
The subject and message describe a change to changelink only:

  ip6_gre: fix changelink conflict checks for L2 tunnels
  ...
  Use ip6gre_tunnel_find() with dev->type, as the newlink paths do.

The skip is in the shared helper, though. Doesn't it also change
ip6gre_newlink(), ip6erspan_newlink(), and every legacy ioctl that goes
through ip6gre_tunnel_locate()?

These are some differences users can see:

- newlink of an ordinary tunnel whose laddr/raddr/i_key/link/type match an
  existing collect_md tunnel used to fail with -EEXIST. It now succeeds.

- SIOCADDTUNNEL with params that match a collect_md ip6gre device used to
  return -ENOBUFS through this code in ip6gre_tunnel_locate():

	t = ip6gre_tunnel_find(net, parms, ARPHRD_IP6GRE);
	if (t && create)
		return NULL;

  It now registers a new ip6gre%d device.

- SIOCDELTUNNEL on the fallback device with params that match a
  collect_md device used to delete that device. It now returns -ENOENT,
  or -EPERM for zero params, because the lookup finds ip6gre0 itself.

- SIOCGETTUNNEL on the fallback device used to return the collect_md
  tunnel's parms. It now returns the fallback device's own parms.

This also differs from ip_tunnel_find() in net/ipv4/ip_tunnel.c, which
does not skip collect_md entries.

If only changelink should ignore collect_md entries, could the skip go at
that call site, or behind a parameter? If not, could the commit message
describe the newlink and ioctl changes?

[ ... ]

> @@ -2055,7 +2058,7 @@ ip6gre_changelink_common(struct net_device *dev, struct nlattr *tb[],
>  
>  	ip6gre_netlink_parms(data, p_p);
>  
> -	t = ip6gre_tunnel_locate(net, p_p, 0);
> +	t = ip6gre_tunnel_find(net, p_p, dev->type);
>  
>  	if (t) {
>  		if (t->dev != dev)

[Severity: High]
Can this return -EEXIST when a collect_md device changes its own
parameters?

ip6gre_tunnel_find() now skips every collect_md entry. A collect_md
device therefore no longer matches its own hash entry, and the walk moves
on to the next entries.

In every netns, the fallback ip6gre0 sits in tunnels_wc[0] with all-zero
parms and dev->type set to ARPHRD_IP6GRE:

net/ipv6/ip6_gre.c:ip6gre_init_net() {
    ...
	t = netdev_priv(ign->fb_tunnel_dev);
	hlist_add_head_rcu(&t->hash_node, &ign->tunnels_wc[0]);
    ...
}

ip6gre_newlink() never calls ip6gre_tunnel_find() for collect_md devices:

	if (nt->parms.collect_md) {
		if (rtnl_dereference(ign->collect_md_tun))
			err = -EEXIST;
	} else {
		if (ip6gre_tunnel_find(net, &nt->parms, dev->type))
			err = -EEXIST;
	}

So "ip link add md0 type ip6gre external" creates md0 with zero params
and links it into tunnels_wc[0] ahead of ip6gre0. A later
"ip link set md0 type ip6gre external ..." then goes:

ip6gre_changelink()
  ip6gre_changelink_common()
    ip6gre_tunnel_find(net, p_p, ARPHRD_IP6GRE)
      skips md0, matches ip6gre0
    t->dev != dev -> ERR_PTR(-EEXIST)

Before this patch, ip6gre_tunnel_locate() found md0 first, so
t->dev == dev and the update succeeded.

SIOCCHGTUNNEL on md0 looks affected the same way. In
ip6gre_tunnel_siocdevprivate(), ip6gre_tunnel_locate(net, &p1, 0) now
returns the fallback tunnel, and the t->dev != dev branch sets -EEXIST.

The L2 kinds can hit this too, when a collect_md ip6gretap or ip6erspan
device shares lookup params with an ordinary L2 tunnel. newlink allows
that.

Would it work to skip the ordinary duplicate search when
nt->parms.collect_md is set, as newlink does? Another option is to accept
a match on the device's own entry.
-- 
pw-bot: cr
