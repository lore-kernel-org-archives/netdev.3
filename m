Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.136.29.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487552;
	b=CwcnpBcfTyZjVI/EozQVIWn1NMfuoXhO4QaWzrcQ9d+6UsxQS2a8vY3U7g+vLq5D74ua
	 DkvjJiDqFmev7KP5WVFYwRh9hSF34QjlVonbElivY/+eeoR/9rsgWfQFzlFmOlwkvwHNo
	 R8Y7lJG8nRBrTkPZjpKwO3az4N6osw883PkYEMX07v4uQOtPwlJ5gLkNLOEcpeOfodfK4
	 PX0ykooU1tgySzf8pB9p6gJt8LJ8gFy1oJ3vxYuLcaj+onhtRpL8TMmPGIzmLapD4Kizz
	 6XA7Un9xVx5GzWeDb2K30k0Z1qQ+FX3nss1C/vyVLxue+WNXvGmHp0zPLgZISSZgTNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487552;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:User-Agent:X-Bm-Milter-Handled:
	 X-Bm-Transport-Timestamp;
	bh=fkuD8USi293M2GyM1a4ma7QYzKDoDimjsvNM+ReEAsc=;
	b=ELgtsApgpcTtGKhGG21D5WRG0g1T25nW82Ez4fHkPkaVI9Ebfa2x7wRF+2ILe5w5aJvU
	 4b5iWlogBGtb+WZak9EfnZN7/IkLh0c7tzZgyqQZfuhuqa/LjDD7P7G2QmJkSFDednApS
	 59CZoXjJdeF0CILcQQBGwfDqKhNCmWFxWosqs08+XeehY4SM9OuH1Fe0T9bkfAf+uEvnF
	 hSY8Lo8QkWylfopra66y20g7ym1IfuGgB1T5PamrB3piA/X39ClmQvoDsCj6yGQIX5YXw
	 8pPg6R/Y0lvb56uvIWFZH3KOgLYRs25VJtpsJO83cbtszQYpqSFjbjWAmRJ6h9YQpUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=proxmox.com;
	spf=pass smtp.mailfrom=proxmox.com;
	arc=none smtp.remote-ip=94.136.29.106
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBCE606A323;
	Thu, 12 Nov 2026 12:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCBCE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 040824832C;
	Thu, 12 Nov 2026 13:45:43 +0100 (CET)
Date: Thu, 12 Nov 2026 13:45:34 +0100
From: Gabriel Goller <g.goller@proxmox.com>
To: netdev-bot+sashiko@kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: reset all.force_forwarding when disabling
 all.forwarding
Message-ID: <avW0C4_kHRv9v3Lr@luna.proxmox.com>
References: <20261109-ipv6_reset_all-v1-1-815dfd508246@proxmox.com>
 <179436921928.2199510.2583920348009853721@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179436921928.2199510.2583920348009853721@kernel.org>
User-Agent: NeoMutt/20260504
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1794487536000

On 11.11.2026 03:53, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In net/ipv6/addrconf.c, addrconf_fixup_forwarding() (lines
>   908-915) now sends inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,…
> - [Medium] ipv6: missing NETCONFA_FORCE_FORWARDING in
>   inet6_netconf_fill_devconf()
> - [Low] The patch fixes a user-visible bug but has no Fixes: tag.
> 
> --
> 
> ipv6: reset all.force_forwarding when disabling all.forwarding
> 
> When all.forwarding is disabled, this patch also clears
> all.force_forwarding, so that writing 1 to all.force_forwarding later
> re-enables the interfaces. It also sends a netconf notification for the
> change.
> 
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index d9d13e78bf13b..9007a58039e65 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -905,6 +905,14 @@ static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int
> >  						     net->ipv6.devconf_dflt);
> >  
> >  		addrconf_forward_change(net, newf);
> > +		/* Disabling all.forwarding also resets all.force_forwarding */
> > +		if (newf == 0 && net->ipv6.devconf_all->force_forwarding) {
> > +			WRITE_ONCE(net->ipv6.devconf_all->force_forwarding, 0);
> 
> [Severity: Low]
> Should this patch carry a Fixes: tag for commit f24987ef6959, the commit
> that added the force_forwarding sysctl?
> 
> That commit added the per-interface reset in addrconf_forward_change():
> 
>     if (newf == 0)
>         WRITE_ONCE(idev->cnf.force_forwarding, 0);
> 
> It did not reset devconf_all->force_forwarding. Because
> addrconf_sysctl_force_forwarding() only acts on a write when
> old_val != new_val, writing 1 again does nothing.
> 
> Without the tag, stable kernels that have force_forwarding may not pick
> up this fix.

Hmm not sure about this one. If I make a new version I'll add it.

> > +			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
> > +						     NETCONFA_FORCE_FORWARDING,
> > +						     NETCONFA_IFINDEX_ALL,
> > +						     net->ipv6.devconf_all);
> 
> [Severity: Medium]
> Does this notification carry the force_forwarding value at all?
> 
> inet6_netconf_notify_devconf() sizes the skb with
> inet6_netconf_msgsize_devconf(type) and fills it with
> inet6_netconf_fill_devconf(). Neither helper handles
> NETCONFA_FORCE_FORWARDING. They only know about NETCONFA_FORWARDING,
> NETCONFA_MC_FORWARDING, NETCONFA_PROXY_NEIGH and
> NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN.
> 
> So when all.forwarding is set to 0 while all.force_forwarding is set,
> RTNLGRP_IPV6_NETCONF listeners get an RTM_NEWNETCONF for
> NETCONFA_IFINDEX_ALL that contains only NETCONFA_IFINDEX. The size and
> fill helpers agree with each other, so WARN_ON(err == -EMSGSIZE) in
> inet6_netconf_notify_devconf() never fires. The message without a
> value goes out silently.
> 
> An RTM_GETNETCONF request that ends up with all set in
> inet6_netconf_fill_devconf() also omits force_forwarding. A listener
> therefore cannot recover the new state by querying afterwards either.
> 
> The commit message says netconf listeners are notified. With this
> message they cannot tell what changed or what the new value is.
> 
> The gap predates this patch. The existing force_forwarding
> notifications in addrconf_sysctl_force_forwarding() and
> addrconf_force_forward_change() have the same problem. This patch adds
> one more caller that depends on that path.
> 
> Could NETCONFA_FORCE_FORWARDING handling be added to
> inet6_netconf_msgsize_devconf() and inet6_netconf_fill_devconf(),
> either as a preceding patch or in the same series?

This is fixed by this commit:
2d916a8c307c ("ipv6: Add NETCONFA_FORCE_FORWARDING to netconf messages")

> [Severity: Medium]
> Does this notification actually carry the new force_forwarding value?
> 
> inet6_netconf_fill_devconf() only puts NETCONFA_FORWARDING,
> NETCONFA_MC_FORWARDING, NETCONFA_PROXY_NEIGH and
> NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN. It has no branch for
> NETCONFA_FORCE_FORWARDING, so for this type it emits only the ifindex:
> 
> net/ipv6/addrconf.c:inet6_netconf_fill_devconf() {
>     ...
> 	if ((all || type == NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN) &&
> 	    nla_put_s32(skb, NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
> 			READ_ONCE(devconf->ignore_routes_with_linkdown)) < 0)
> 		goto nla_put_failure;
> 
> out:
> 	nlmsg_end(skb, nlh);
>     ...
> }
> 
> inet6_netconf_msgsize_devconf() reserves no space for it either. The two
> helpers agree, so no WARN fires.
> 
> As a result, RTNLGRP_IPV6_NETCONF listeners get an RTM_NEWNETCONF for
> "all" with no NETCONFA_FORCE_FORWARDING attribute.
> 
> The commit message says "Reset all.force_forwarding too and notify netconf
> listeners", but listeners cannot tell from this message what changed or
> what the new value is.
> 
> The missing fill support dates back to f24987ef6959. The existing
> force_forwarding notifications in addrconf_sysctl_force_forwarding() and
> addrconf_force_forward_change() have the same gap. This patch adds one more
> caller that depends on that path.
> 
> Could NETCONFA_FORCE_FORWARDING branches be added to both
> inet6_netconf_msgsize_devconf() and inet6_netconf_fill_devconf(), either
> as a prerequisite or in the same series?

Same as above, already fixed.

> > +		}
> >  		if ((!newf) ^ (!old))
> >  			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
> >  						     NETCONFA_FORWARDING,
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109-ipv6_reset_all-v1-1-815dfd508246%40proxmox.com

