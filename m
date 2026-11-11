Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369220;
	b=oF/bo1QN6rZt/5YFhR8d8CXzYhK/jPw8BFfzaj41Ce+QaNmAMLm+ZaYocJ2FlsZspZs/
	 7Q3tR5KwG0qbj6tq4DaOgZT0CBjS5dlJKyKd1kt4jDXAunVgDq9N8IlNf9A4nAoMmvbCt
	 l7dYpC6GbFuTOc0hOk8auB3IQZ+Gg3KZZi0nOlS/87M355no8Ov7i1OLiexwBGn+ac+Fe
	 0lLrgMAG8dLmYdT81M8PuknMEa+HG5/M1Xc0JOxczqcIwJilWMPsdzWEMmUJBhdLOd80x
	 7NxSV/L6W1GtgxFjNr2QF4zumTokX7Sgoz7brFCw1+zPeIZ22eSnX/KokQrMryzgtSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369220;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Q27sCdgw5KbTydJOFwO5gJVQdyRu6rjlWeERILgdeAY=;
	b=a0+8kOHXCFZLHJSRuYtCR4lmtAwky/znaelKACgkFX4pRMg7y1poVbVOo4TsDVmNmrjF
	 yJgmAKnfg3yWBf0FwVNicFT9Ao7LK4148wZWmvtrwWOETR/Bks1C+YBfMZCWaHFkJwPYX
	 BnRyV538fdrIkXUmgC4lr4CSGpDVudJxgggg0sHX0J9Tkq1XmTSkG3bhDREOxrMHsrgEl
	 ADJ4I7WeThcm78NVi91Ac8icUwCv19fttQZ9YUdS8OIxTt8GwdjAwFjD9L8ehFqQ1/uky
	 4HgSL4WdztBibkDk8QTg5NNQxrwjBsHUqpoTfsPpx/LbsejOng5b29kL8APbIG0Wq0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL4jG5ni;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1A606A31C;
	Wed, 11 Nov 2026 03:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hL4jG5ni
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A9D1F0089F;
	Wed, 11 Nov 2026 03:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794369220;
	bh=Q27sCdgw5KbTydJOFwO5gJVQdyRu6rjlWeERILgdeAY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hL4jG5ni2rK845OegRRFfXwmi03Zz2cFWIW49ds1r9HnmzWVfjb9idlGoYNDulpDp
	 LN9pQkqg+wGaKi4yIvhKdm/qZPoRHmfMyohljjKNc/UImBZdvwCzkgn/rCpOIv8vKi
	 YHf5aT1dxc5fAI+ttkIUkgZNlXE39KDQinMkD4KT63a1UKTguT9VVSA32BtFzw+fDT
	 tjrwngcdymNhjpJBJfDGRWKQyiUugdhLR2z626wpah6LvnaNowELL8dmlaauSB1qsX
	 HoGeC2zgWZ5WXKlidemQbSNqyReEizLy81FjC6SBC88Swbpwy3taP6D3trTvoMVgng
	 Golt5mPZdumDw==
Subject: Re: [PATCH net-next] ipv6: reset all.force_forwarding when disabling
 all.forwarding
From: netdev-bot+sashiko@kernel.org
To: g.goller@proxmox.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 03:53:39 +0000
Message-ID: <179436921928.2199510.2583920348009853721@kernel.org>
In-Reply-To: <20261109-ipv6_reset_all-v1-1-815dfd508246@proxmox.com>
References: <20261109-ipv6_reset_all-v1-1-815dfd508246@proxmox.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In net/ipv6/addrconf.c, addrconf_fixup_forwarding() (lines
  908-915) now sends inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,…
- [Medium] ipv6: missing NETCONFA_FORCE_FORWARDING in
  inet6_netconf_fill_devconf()
- [Low] The patch fixes a user-visible bug but has no Fixes: tag.

--

ipv6: reset all.force_forwarding when disabling all.forwarding

When all.forwarding is disabled, this patch also clears
all.force_forwarding, so that writing 1 to all.force_forwarding later
re-enables the interfaces. It also sends a netconf notification for the
change.

> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index d9d13e78bf13b..9007a58039e65 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -905,6 +905,14 @@ static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int
>  						     net->ipv6.devconf_dflt);
>  
>  		addrconf_forward_change(net, newf);
> +		/* Disabling all.forwarding also resets all.force_forwarding */
> +		if (newf == 0 && net->ipv6.devconf_all->force_forwarding) {
> +			WRITE_ONCE(net->ipv6.devconf_all->force_forwarding, 0);

[Severity: Low]
Should this patch carry a Fixes: tag for commit f24987ef6959, the commit
that added the force_forwarding sysctl?

That commit added the per-interface reset in addrconf_forward_change():

    if (newf == 0)
        WRITE_ONCE(idev->cnf.force_forwarding, 0);

It did not reset devconf_all->force_forwarding. Because
addrconf_sysctl_force_forwarding() only acts on a write when
old_val != new_val, writing 1 again does nothing.

Without the tag, stable kernels that have force_forwarding may not pick
up this fix.

> +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
> +						     NETCONFA_FORCE_FORWARDING,
> +						     NETCONFA_IFINDEX_ALL,
> +						     net->ipv6.devconf_all);

[Severity: Medium]
Does this notification carry the force_forwarding value at all?

inet6_netconf_notify_devconf() sizes the skb with
inet6_netconf_msgsize_devconf(type) and fills it with
inet6_netconf_fill_devconf(). Neither helper handles
NETCONFA_FORCE_FORWARDING. They only know about NETCONFA_FORWARDING,
NETCONFA_MC_FORWARDING, NETCONFA_PROXY_NEIGH and
NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN.

So when all.forwarding is set to 0 while all.force_forwarding is set,
RTNLGRP_IPV6_NETCONF listeners get an RTM_NEWNETCONF for
NETCONFA_IFINDEX_ALL that contains only NETCONFA_IFINDEX. The size and
fill helpers agree with each other, so WARN_ON(err == -EMSGSIZE) in
inet6_netconf_notify_devconf() never fires. The message without a
value goes out silently.

An RTM_GETNETCONF request that ends up with all set in
inet6_netconf_fill_devconf() also omits force_forwarding. A listener
therefore cannot recover the new state by querying afterwards either.

The commit message says netconf listeners are notified. With this
message they cannot tell what changed or what the new value is.

The gap predates this patch. The existing force_forwarding
notifications in addrconf_sysctl_force_forwarding() and
addrconf_force_forward_change() have the same problem. This patch adds
one more caller that depends on that path.

Could NETCONFA_FORCE_FORWARDING handling be added to
inet6_netconf_msgsize_devconf() and inet6_netconf_fill_devconf(),
either as a preceding patch or in the same series?

[Severity: Medium]
Does this notification actually carry the new force_forwarding value?

inet6_netconf_fill_devconf() only puts NETCONFA_FORWARDING,
NETCONFA_MC_FORWARDING, NETCONFA_PROXY_NEIGH and
NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN. It has no branch for
NETCONFA_FORCE_FORWARDING, so for this type it emits only the ifindex:

net/ipv6/addrconf.c:inet6_netconf_fill_devconf() {
    ...
	if ((all || type == NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN) &&
	    nla_put_s32(skb, NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
			READ_ONCE(devconf->ignore_routes_with_linkdown)) < 0)
		goto nla_put_failure;

out:
	nlmsg_end(skb, nlh);
    ...
}

inet6_netconf_msgsize_devconf() reserves no space for it either. The two
helpers agree, so no WARN fires.

As a result, RTNLGRP_IPV6_NETCONF listeners get an RTM_NEWNETCONF for
"all" with no NETCONFA_FORCE_FORWARDING attribute.

The commit message says "Reset all.force_forwarding too and notify netconf
listeners", but listeners cannot tell from this message what changed or
what the new value is.

The missing fill support dates back to f24987ef6959. The existing
force_forwarding notifications in addrconf_sysctl_force_forwarding() and
addrconf_force_forward_change() have the same gap. This patch adds one more
caller that depends on that path.

Could NETCONFA_FORCE_FORWARDING branches be added to both
inet6_netconf_msgsize_devconf() and inet6_netconf_fill_devconf(), either
as a prerequisite or in the same series?

> +		}
>  		if ((!newf) ^ (!old))
>  			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
>  						     NETCONFA_FORWARDING,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-ipv6_reset_all-v1-1-815dfd508246%40proxmox.com
