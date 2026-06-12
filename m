Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923862C235E
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304797; cv=none; b=dXyQEp33D87eAouXD50b1qfHO7wmOzt3tEn9Xi8eg6rQkuoo7BW2CsazG+EaYnjgeRDS2hgzwCNIRaGbXfupDUrjemyYO2unZeu+NYA1bSvHu+i8uGQlmL4C6UfNojDMEfCWIYTlNB+uBQgXR4yf4+NyYZR5hA6DJlNvBzUtkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304797; c=relaxed/simple;
	bh=lc8r1rFn8eBxAbeGTtTqwCG7psnv0CNzD5JeZJ/5Ln8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbGs/Wr6WWK8mlKb9+CWFn/wWFoAfRNPOE/wjEqL/d0vTbIQanEeBtPvOTsYnpm+HNGrBCHivhWkj4GZznCpY56gOn0Kbqisb7htSL50Ugw2oEqCQ+88MthQ8m6QIMJLNCKOF3Nnm55EndOfvgPHMwWdhb/uwhYrU90xuYyuy+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LToTIL5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LToTIL5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901001F000E9;
	Fri, 12 Jun 2026 22:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781304796;
	bh=4u+DZbtFQ7C60Ue/EAb983KPS1VUW8Nf9lSnRAY8TLw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LToTIL5xIi3aM003C4maFEOHPmfBrYJf+gDMERjHC6amA/T4d3JLB2JdVVBKju5SQ
	 Mf9C5eSdyE51eRvHr2j1DZnacU3PeIp9Bua8hLZsX5ZRmZZvg6W5MDaJUV6zbWI7WT
	 hhcJ2Fpq/f2zziR+TObO47xHzTBjzkfB070ywvPr7NB2qHf8xhchNWWjs5fQ4Rzd4O
	 PajlXTaX24QLW/hiwmIrv7o6qjsU5oEShYXRjjM4gJBFPhrKrGGmjjryQwDqzQL9DB
	 xMyNVOnOL6lx+J1qByOmn7ZfUGJiXjwJos2HXelzxwMvJt4tYgGrJ8aqW6I/RjQhcP
	 qWF6loeYsJSjg==
From: Jakub Kicinski <kuba@kernel.org>
To: edumazet@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	jv@jvosburgh.net,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH v3 net-next] bonding: no longer rely on RTNL in bond_fill_info()
Date: Fri, 12 Jun 2026 15:53:13 -0700
Message-ID: <20260612225313.2617858-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610031946.466417-1-edumazet@google.com>
References: <20260610031946.466417-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
bonding: no longer rely on RTNL in bond_fill_info()

This commit removes the RTNL lock dependency in bond_fill_info(), replacing
it with RCU protection and READ_ONCE()/WRITE_ONCE() annotations for reading
bond configuration fields.

> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 90365d3f7ebff..aa1725e6a3776 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c

[ ... ]

> @@ -674,53 +674,58 @@ static size_t bond_get_size(const struct net_device *bond_dev)

[ ... ]

>  static int bond_fill_info(struct sk_buff *skb,
>  			  const struct net_device *bond_dev)
>  {
> -	struct bonding *bond = netdev_priv(bond_dev);
> -	unsigned int packets_per_slave;
> -	int ifindex, i, targets_added;
> +	const struct bonding *bond = netdev_priv(bond_dev);
> +	int i, targets_added, miimon, mode;
> +	const struct slave *primary;
>  	struct nlattr *targets;
> -	struct slave *primary;
>  
> -	if (nla_put_u8(skb, IFLA_BOND_MODE, BOND_MODE(bond)))
> +	rcu_read_lock();
> +	mode = READ_ONCE(bond->params.mode);

[ ... ]

> -	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
> +	if (mode == BOND_MODE_8023AD) {
>  		struct ad_info info;
>  
>  		if (capable(CAP_NET_ADMIN)) {
>  			if (nla_put_u16(skb, IFLA_BOND_AD_ACTOR_SYS_PRIO,
> -					bond->params.ad_actor_sys_prio))
> +					READ_ONCE(bond->params.ad_actor_sys_prio)))
>  				goto nla_put_failure;
>  
>  			if (nla_put_u16(skb, IFLA_BOND_AD_USER_PORT_KEY,
> -					bond->params.ad_user_port_key))
> +					READ_ONCE(bond->params.ad_user_port_key)))
>  				goto nla_put_failure;
>  
> +			/* Small race here, this is a minor trade off. */
>  			if (nla_put(skb, IFLA_BOND_AD_ACTOR_SYSTEM,
>  				    ETH_ALEN, &bond->params.ad_actor_system))
>  				goto nla_put_failure;
>  		}
> -		if (!bond_3ad_get_active_agg_info(bond, &info)) {
> +		if (!__bond_3ad_get_active_agg_info(bond, &info)) {
        ^^^^

[Severity: Critical]
Is it possible for a concurrent mode change to cause a NULL pointer
dereference here?

Since bond_fill_info() no longer holds the RTNL lock, another thread could
concurrently change the bonding mode from BOND_MODE_8023AD to
BOND_MODE_ACTIVEBACKUP and immediately enslave a new device.

During bond_alloc_slave(), if the new mode is ACTIVEBACKUP, slave->ad_info
is not allocated and remains NULL. The slave is then added to the
RCU-protected bond->slave_list.

Because bond_fill_info() cached the mode earlier as BOND_MODE_8023AD:

    mode = READ_ONCE(bond->params.mode);

It will still enter this block and call __bond_3ad_get_active_agg_info().
That function iterates over the slave list and attempts to dereference the
newly added slave's ad_info without checking if it is NULL:

drivers/net/bonding/bond_3ad.c:__bond_3ad_get_active_agg_info() {
        ...
        bond_for_each_slave_rcu(bond, slave, iter) {
                port = &(SLAVE_AD_INFO(slave)->port);
                tmp = rcu_dereference(port->aggregator);
        ...
}

Could this be addressed by adding a NULL check for SLAVE_AD_INFO(slave) in
__bond_3ad_get_active_agg_info(), or by re-evaluating the mode?

>  			struct nlattr *nest;
>  
>  			nest = nla_nest_start_noflag(skb, IFLA_BOND_AD_INFO);
-- 
pw-bot: cr
