Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD948E0E5;
	Mon, 28 Sep 2026 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588650; cv=none; b=SqiByzjubSAsofBF226QvWVEZdpu1bYAgpSxApta33R/OEwlGFCFev+JRc4zkrNjylnKWC4RSFb+fWtiXZdZQ+KdcE8TZ9AtJXHtaDbWouELkoWbBg1QmQIj05NgQl4tbL84gVHW2ch2xX50jDpk+twqvD5IMVeqQO2YV3MPBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588650; c=relaxed/simple;
	bh=9oI1czUh0cwvr1F2T9NdXQl3oHhA/WcEE5sckh4PtQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyE9ZBwiHp0SOZhi6XOPQ1gwkAnfVkzt69IVsLIJmp6wn+D3eShFRDpiGlROUsYP8gtLRTbhTQ+m5JCpkpOBK8sk8onZwKX0jB6YgN/hsejH5Jp11gS1jVjjDqa38eHqPXUeCCH6aTclFHi/u47MMzpaFgQMSRZOEBhydEso4hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpezNjq1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpezNjq1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29651F00893;
	Mon, 28 Sep 2026 09:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588648;
	bh=1d72FXy6Ds/mCGvDXGUr8cCY+vsQcBo1Jgmr46RzDGc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VpezNjq1C4ufk0Cx1GKX0WFllmH0CSQV6lRjpdJLjpnmpVT0FUClxKstgoK1f08vS
	 33QINGym5FnbX9KPxJZ3O59J3hzc/5r/VsJPTGHIdPpcF436W9WjZ9NM6pwtgUUvqr
	 e9HVmO6z3Lu0ln5NVtsvbW32+ur30AKsQxGpWJAcDElQq+WjTVD+Qibbh2Vlwuj5Ci
	 WVz8NjDfS7FZMzwv70kglgPxbDcLj7MQQaeK1tX0cdC/ZsAHeLWmFPwVYcgDbJTRNo
	 H7PKRL+pOxc9tcKDHMM9K3pWYwzPKPIRLMolTiov7Fdrj9a/+BzhyYZMdIJ3ENQSlV
	 bd/S28yDRSFmQ==
Message-ID: <b6801200-ec97-48c2-9c0b-2b929c1b1198@kernel.org>
Date: Mon, 28 Sep 2026 11:43:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 07/10] net: phy: phy_link_topology: Add a
 helper to retrieve ports
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?Q?Nicol=C3=B2_Veronese?= <nicveronese@gmail.com>,
 Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
 Romain Gantois <romain.gantois@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
 Frank Wunderlich <frank.wunderlich@linux.dev>,
 Pietro Ameruoso <p.ameruoso@live.it>, Aleksei Sviridkin <f@lex.la>
References: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
 <20260927133619.955236-8-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260927133619.955236-8-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/09/2026 à 15:36, Maxime Chevallier a écrit :
> In order to allow netlink access to phy_ports, let's add a helper to
> retrieve them. When handling a port coming from phy_link_topology, the
> caller must hold rtnl until it's done with it.
> 
> We don't really support PHY and phy_port operation on ops-locked devices
> yet, warn when we try to do so on such an interface.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Aleksei Sviridkin <f@lex.la>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/net/phy/phy_link_topology.c |  8 ++++++++
>   include/linux/phy_link_topology.h   | 25 +++++++++++++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 28c5bf3a8849..214ccce23cf6 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -65,6 +65,14 @@ int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port)
>   	struct phy_link_topology *topo;
>   	int ret;
>   
> +	/* Ports can now be queried without rtnl for ops-locked devices, which
> +	 * we don't support now as port retrieval is done under rtnl.
> +	 * We don't have phy_port enabled devices yet, let's make sure
> +	 * we are loudly warned about that when it happens.
> +	 */
> +	if (WARN_ON_ONCE(dev->netdev_ops && netdev_need_ops_lock(dev)))
> +		return -EOPNOTSUPP;
> +
>   	topo = phy_link_topo_get_or_alloc(dev);
>   	if (IS_ERR(topo))
>   		return PTR_ERR(topo);
> diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
> index 296ee514ba46..f2e493c433ff 100644
> --- a/include/linux/phy_link_topology.h
> +++ b/include/linux/phy_link_topology.h
> @@ -13,6 +13,7 @@
>   
>   #include <linux/ethtool.h>
>   #include <linux/netdevice.h>
> +#include <linux/rtnetlink.h>
>   
>   struct xarray;
>   struct phy_device;
> @@ -71,6 +72,24 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
>   	return NULL;
>   }
>   
> +static inline struct phy_port *
> +phy_link_topo_get_port(struct net_device *dev, u32 port_id)
> +{
> +	struct phy_link_topology *topo = dev->link_topo;
> +
> +	if (!topo)
> +		return NULL;
> +
> +	/* ports in the topo are RTNL protected, but may be accessed under
> +	 * netdev_lock for ops-locked devices. For now keep them under rtnl
> +	 * protection, as no ops-locked devices have phy_port capabilities
> +	 * yet.
> +	 */
> +	ASSERT_RTNL();
> +
> +	return xa_load(&topo->ports, port_id);
> +}
> +
>   #else
>   static inline int phy_link_topo_add_phy(struct net_device *dev,
>   					struct phy_device *phy,
> @@ -100,6 +119,12 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
>   {
>   	return NULL;
>   }
> +
> +static inline struct phy_port *
> +phy_link_topo_get_port(struct net_device *dev, u32 port_id)
> +{
> +	return NULL;
> +}
>   #endif
>   
>   #endif /* __PHY_LINK_TOPOLOGY_H */

