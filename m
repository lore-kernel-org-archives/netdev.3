Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7613803D7;
	Tue, 29 Sep 2026 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790642315; cv=none; b=KwkKWswG59EpKjk4+LsmYKx+k1EqdoOXjNj/fW+ucp21eCeaSY3mjctLvZkRPizmsPD0aYlNj4u4pRNtu2WDTZRnnU/8eMHY8urMUOctVr51aCyC4KT6d7lsWosI3kvzWZQwrkAOCN/Vnfc6p8KvtGare68kyjRXSBt24bik3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790642315; c=relaxed/simple;
	bh=u1qNzmdYnGPZRudytcOo4/YvE76QSeW3BiKBiS2q4FU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tJXb8houkH3gak/4IWxQrd1JuzRU01/MTMgh7ky3bHixgPT4icLWG1Qc7RGko4lrmQeIBKRwjqU+cDBJyXYEr1BaXE35CTasjTd7Ll9PFBZbKQX1XaVaDoNnhVqUjRWkEWH7xOtCJ6MS4rvz61Iim3SKUXp5Gy5tYasR1iK0bKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rm2eH/WX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rm2eH/WX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC0C1F00893;
	Tue, 29 Sep 2026 00:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790642311;
	bh=2qZEWsjI6nrtWOM3TwU/zTl443CJGwIcv5kuObM97q8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rm2eH/WXx0cvsyzzjm58uBciiyXIo8vboGRmTEsQehEtnDq6IhsQHJ0hTsqHvwI/K
	 vyJV6uPcWVZ4wKJTJCT7aQIGVlBJn0EN6/uBBSWM/0g3VYl0Jk0ja9DJE8U+OYH7qD
	 AVJ8q7LlTi+MhWQaZxoqY2AEYMUGifhgmluNtX5yIBsE4M3vokHNs8DFYxJt0XFRAi
	 ylTqX/z9y6lcnUrU5hBhaiELf3YWG+d6iJqIL28qSnvKiv1AMPHNFwMmgrUBtkQ9Ro
	 BH6DijdlaZiIisFyn5qK1XVVBE5MCjbeZIeC0DI1QyryRRkat2QdW8AGtx0hjMppVQ
	 LhKNuv50WU4ew==
Subject: Re: [PATCH net-next v18 01/10] net: phy: phy_link_topology: Add a
 helper for opportunistic alloc
From: netdev-bot+sashiko@kernel.org
To: maxime.chevallier@bootlin.com
Cc: davem@davemloft.net, andrew@lunn.ch, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, hkallweit1@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, christophe.leroy@csgroup.eu,
 herve.codina@bootlin.com, f.fainelli@gmail.com, vladimir.oltean@nxp.com,
 kory.maincent@bootlin.com, kabel@kernel.org, o.rempel@pengutronix.de,
 nicveronese@gmail.com, horms@kernel.org, mwojtas@chromium.org,
 romain.gantois@bootlin.com, daniel@makrotopia.org,
 dimitri.fedrau@liebherr.com, frank.wunderlich@linux.dev, p.ameruoso@live.it,
 f@lex.la
Date: Tue, 29 Sep 2026 00:38:29 +0000
Message-ID: <179064230932.3145.9260154404781275100@kernel.org>
In-Reply-To: <20260927133619.955236-2-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-2-maxime.chevallier@bootlin.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new comment in phy_link_topo_get_or_alloc()
  (drivers/net/phy/phy_link_topology.c) lists the contexts the helper…

Pre-existing issues:
- [Low] Documentation/networking/phy-link-topology.rst (API section) says
  struct phy_link_topology "is a per-netdevice resource, that gets…

--

net: phy: phy_link_topology: Add a helper for opportunistic alloc

This commit moves the lazy allocation of dev->link_topo out of
phy_link_topo_add_phy() and into a new helper,
phy_link_topo_get_or_alloc(). The helper returns the existing topology
or allocates a new one. It prepares for tracking phy_port objects in
the topology.

> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 4134de7ae313d..0462283c80202 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -28,11 +28,39 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
>  	return 0;
>  }
>  
> +static struct phy_link_topology *phy_link_topo_get_or_alloc(struct net_device *dev)
> +{
> +	int ret;
> +
> +	if (dev->link_topo)
> +		return dev->link_topo;
> +
> +	/* The topology is allocated the first time we add an object to it.
> +	 * It is freed alongside the netdev. It can be called on multiple
> +	 * contexts:
> +	 *  - It can be called from .probe() : No rtnl, no netdev_lock
> +	 *  - .ndo_open() : rtnl and possibly netdev_lock

[Severity: Low]
Can phy_link_topo_get_or_alloc() actually be reached with netdev_lock
held?

At this commit, the only caller is phy_link_topo_add_phy(). It returns
early for ops-locked devices before it calls the helper:

phy_link_topo_add_phy() {
    ...
	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
		return -EOPNOTSUPP;
    ...
}

Later in the series, phy_link_topo_add_port() rejects the same devices
with WARN_ON_ONCE(dev->netdev_ops && netdev_need_ops_lock(dev)).

On the open path, dev_open() only takes netdev_lock through
netdev_lock_ops():

include/net/netdev_lock.h:netdev_lock_ops() {
	if (netdev_need_ops_lock(dev))
		netdev_lock(dev);
}

That means netdev_lock is held only for the devices that both callers
reject. Would it be more accurate to drop "possibly netdev_lock" from
the .ndo_open() line?

This comment also mentions ports and the SFP cage port, which don't
exist yet at this commit. struct phy_link_topology only has phys and
next_phy_index. The rest of the series fixes that. "net: phy:
phy_link_topology: Track ports in phy_link_topology" adds the ports
xarray and phy_link_topo_add_port(). Later patches add
phylink_create_sfp_cage_port(), phylink_add_sfp_mod_port() and
phy_add_sfp_mod_port(). By the end of the series, only the netdev_lock
part is still inaccurate.

> +	 *  - SFP state machine : rtnl held or not
> +	 *
> +	 *  However, we can't really have races :
> +	 *  - If we have a PHY, phy_link_topo_add_phy() will always run first
> +	 *    and trigger the alloc. Only then the ports can be added through
> +	 *    phylib or sfp.
> +	 *  - If we don't, the SFP port for the cage is registered first, and
> +	 *    only then other ports/PHYs can be registered.
> +	 */
> +	ret = netdev_alloc_phy_link_topology(dev);
> +	if (ret)
> +		return ERR_PTR(ret);

[Severity: Low]
This is a pre-existing issue, not something this patch introduced. The
API section of Documentation/networking/phy-link-topology.rst still
says struct phy_link_topology "is a per-netdevice resource, that gets
initialized at netdevice creation".

The code allocates dev->link_topo only when the first object is added.
phy_link_topo_empty() and phy_link_topo_get_phy() both handle a NULL
dev->link_topo.

The baseline already did this allocation inline in
phy_link_topo_add_phy(). The last patch in the series, "Documentation:
networking: Update the phy_port infrastructure description", leaves
that sentence unchanged.

Could the documentation say that the topology is allocated when the
first object is added?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927133619.955236-1-maxime.chevallier%40bootlin.com
