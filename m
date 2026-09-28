Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542548FF71;
	Mon, 28 Sep 2026 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588214; cv=none; b=X3qb4Bn4lQnmyvVazZNPEVLoA97JalcR4yiMXazS7hhYG2YB/Rxq0F+8ort+OQ++LO25V1fMEXx9pygmP59tNAUpiVSlRjeu2vFSnbZHM+9pV1O5LdQp43N9VGApYp7iN1VZpcohBukFGjdKyK77jlHW5iVE5rJyveu0+wUUXe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588214; c=relaxed/simple;
	bh=//nOTnYqXvv9mHBNLoDhlpaQb/GlxlZG72oCbkhThgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6h5T19bSR8awo6oqPYVHGGX+D3hUmACZahXZU8ljMFfYp3dIrgN/xdB66gCvhr5X39REAIfoF9P7rCoG2eXI6V4354f3mNK/ijnrLnb4+LQ8T9ifPltUl/W3QDzvsnv3MCuoVBs+pEmuWe2/rYIw4WXZFDTd7XbihcChevG1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAKVZFBi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAKVZFBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E480F1F000FF;
	Mon, 28 Sep 2026 09:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588213;
	bh=ET3SDBOudBYKjNEuJ5fVpICh7BoHoXqCMUNtaznOzPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KAKVZFBiJ9BVIyZQqwhPizfAXyDUemIkTV41TmAltgPiGM/vlq6PTsJ3fUaEhCM+i
	 ZIZXIJkq+9C125Rxs1a/RyN5/h0YgZjvqBSjC+TqN6sCe7G+WUePfz+IC+7gkcrCRc
	 ZQedBaHTe/qO+wYjcsHBrAtzfimuY3JbnZLiu62m2f7IGYtKloDM21RI3GRDTrK8Ve
	 tuvzCsHgoKVPvbnWadio1rUaFjwxHfWRq8BEEcmLTJStE5w6TUTwPUVL8HEzb/G+IV
	 K+LdBiUONmvC6zFWssjWceVgK/bBJAtbO9gosNlwW8Vj0IoVROi6rhA5JALrfJ7Grd
	 KmcvkApMaWSCw==
Message-ID: <b8d31194-5b9b-49cc-9585-fa5f40ca9895@kernel.org>
Date: Mon, 28 Sep 2026 11:36:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 01/10] net: phy: phy_link_topology: Add a
 helper for opportunistic alloc
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
 <20260927133619.955236-2-maxime.chevallier@bootlin.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260927133619.955236-2-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 27/09/2026 à 15:36, Maxime Chevallier a écrit :
> The phy_link_topology structure stores information about the PHY-related
> components connected to a net_device. It is opportunistically allocated,
> when we add the first item to the topology, as this is not relevant for
> all kinds of net_devices.
> 
> In preparation for the addition of phy_port tracking in the topology,
> let's make a dedicated helper for that allocation sequence.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Aleksei Sviridkin <f@lex.la>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

> ---
>   drivers/net/phy/phy_link_topology.c | 40 +++++++++++++++++++++++------
>   1 file changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> index 4134de7ae313..0462283c8020 100644
> --- a/drivers/net/phy/phy_link_topology.c
> +++ b/drivers/net/phy/phy_link_topology.c
> @@ -28,11 +28,39 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
>   	return 0;
>   }
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
> +
> +	return dev->link_topo;
> +}
> +
>   int phy_link_topo_add_phy(struct net_device *dev,
>   			  struct phy_device *phy,
>   			  enum phy_upstream upt, void *upstream)
>   {
> -	struct phy_link_topology *topo = dev->link_topo;
> +	struct phy_link_topology *topo;
>   	struct phy_device_node *pdn;
>   	int ret;
>   
> @@ -45,13 +73,9 @@ int phy_link_topo_add_phy(struct net_device *dev,
>   	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
>   		return -EOPNOTSUPP;
>   
> -	if (!topo) {
> -		ret = netdev_alloc_phy_link_topology(dev);
> -		if (ret)
> -			return ret;
> -
> -		topo = dev->link_topo;
> -	}
> +	topo = phy_link_topo_get_or_alloc(dev);
> +	if (IS_ERR(topo))
> +		return PTR_ERR(topo);
>   
>   	pdn = kzalloc_obj(*pdn);
>   	if (!pdn)

