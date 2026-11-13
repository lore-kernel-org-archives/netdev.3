Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577877;
	b=3o4YJdzKcKxKZOF0RMRO8oNCCyi3Y+e8yv2hosKyDhR8WGkL9/VNWSrQpYGJiQAoqSOs
	 0GkH84sRVjuiCgoBU7+3g0D8M5caOPRDLpP6whqdH35RBEgzQLlvPw1C/WiNVVPk7TiAp
	 w9TiuNfcVftqc2+ClykWpZsxoQL+A2kxS4HeccE6dgAByn6xXgCjq5cTq7Ueml7rGGEMX
	 dinR0YUG+5c47ekupJperY4vTjfrjYN1eyhg9W2Xlzjw9lJ1/nG+yKr8RWsTEZ2nGGEpi
	 gRlGxVGBhXX5Z+3LxGsEyQMCTerEZWNSuabFyhYhPqwHiJfD02y0UO+ea6jNoTfTomg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577877;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=3tiE8wCVjWqKiSQHj9hDK/7ujfubXxT9LOiydm/3ZXE=;
	b=Cz6J6B6iFoyyiWhyBjFoolZvaWe6vy1h+GNCtLLsKOGx04PS0nAwa6rDhL0Cb6vxTyY3
	 2ht1RxThvSua5FSCRxbz4tLBA2xae2/kOjD+RvOAFJCagz490YGNrcM0AshfxUAeOsCPC
	 4nZ+Sk/hYRhvb63zsRR8KTKVs4PXPGrc9kZzIHtsdps25/Mwou9U4FT/N5xR8scbUhr7w
	 R7m8JlLH1spAr2wImhPf7dRW0XFNgeI2w+9Twm4PaNdjCJo52M/AbM5BfP6wKkvhM2ZFV
	 Qq0oAUmqkHG2wtCXnhqJK0DSqLQ/5gyLT7e/s1N/L3rjpFB6cgRSRZ+LaOQsulMeRcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KaGmI2fz;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB94606B1A1;
	Fri, 13 Nov 2026 13:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EB94606B1A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=KaGmI2fz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3tiE8wCVjWqKiSQHj9hDK/7ujfubXxT9LOiydm/3ZXE=; b=KaGmI2fzPhwM+U913Lq9k8ysvi
	jljRrFge2AhRak87PzNhgHSnDOuVyVHrjIgbTRLu52GGseFhLFZ/Mr6sG3NfeKXdsMWuJDaV2wSDF
	MS9UFsTqyZ2mV74HZVf4U4OwhSsMdy52Ko8yDV6R1oXz34gSh8l+fQC0ZEK6wLLGUPfY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRrgA-00GHmY-AD; Fri, 13 Nov 2026 14:50:58 +0100
Date: Fri, 13 Nov 2026 14:50:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, rosenp@gmail.com,
	jacob.e.keller@intel.com, daniel.machon@microchip.com,
	chunkeey@gmail.com, kees+treewide@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net] net: ibm: emac: attach the fixed-link PHY with
 of_phy_connect()
Message-ID: <ef2eb733-4b94-4c2e-9165-0b324733a482@lunn.ch>
References: <20261112075321.3903875-1-xiaolinkui@126.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112075321.3903875-1-xiaolinkui@126.com>

On Thu, Nov 12, 2026 at 03:53:21PM +0800, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> emac_init_phy() handles a "fixed-link" property by registering a fixed
> PHY for the MAC's own OF node and then assigning net_device->phydev to
> it by hand:
> 
> 	res = of_phy_register_fixed_link(np);
> 	ndev->phydev = of_phy_find_device(np);
> 	if (res || !ndev->phydev)
> 		return res ? res : -EINVAL;
> 	emac_adjust_link(dev->ndev);
> 	put_device(&ndev->phydev->mdio.dev);
> 
> net_device->phydev is meant to be set by phy_attach_direct(), which is
> what the of_phy_connect() helper reaches. Assigning it by hand skips
> everything attach does: phydev->attached_dev stays NULL, no link change
> handler is wired up, the PHY never enters the netdev's phy_link_topology,
> and the put_device() drops the reference the driver just took, so the
> phy_device is kept alive afterwards only by the fixed MDIO bus it is
> registered on.
> 
> The missing topology entry is what prompted this. ethnl_req_get_phydev()
> returns dev->phydev as-is when an ethtool netlink request carries no
> phy-index, so ETHTOOL_MSG_PHY_GET on an EMAC port with a fixed-link finds
> a phydev and then looks it up in a link_topo that was never allocated:
> 
> 	struct phy_link_topology *topo = reply_data->dev->link_topo;
> 	pdn = xa_load(&topo->phys, phydev->phyindex);
> 
> which dereferences NULL in phy_prepare_data().
> 
> Every other phylib driver with fixed-link support registers the fixed PHY
> and then passes the MAC's own OF node to of_phy_connect(): gianfar, fec,
> davinci_emac and nixge all do it, and so does emac_dt_phy_connect() for
> the phy-handle case. Do the same here. of_phy_connect() takes the attach
> reference and drops the of_phy_find_device() one, so the explicit
> put_device() goes away. emac_adjust_link() is still called once by hand
> afterwards and the PHY state machine is still not started, because a
> fixed link does not change. The rest of the driver already treats
> dev->phy.address < 0 as "no PHY to poll" and never reaches
> dev->phy.def->ops, so nothing else changes.
> 
> The hand assignment itself dates back to commit 08e39982ef64 ("net: emac:
> fix fixed-link setup for the RTL8363SB switch"), but it only started
> affecting the net_device when commit baab9de385a8 ("net: ibm: emac: use
> netdev's phydev directly") moved the pointer from the driver private
> dev->phy_dev into ndev->phydev, so that is the commit fixed here.
> 
> No in-tree DTS pairs "ibm,emac" with a "fixed-link" property, so this is
> latent in mainline; it is out-of-tree users such as the Netgear WNDAP620
> that hit it. There is no such hardware here, so the change is verified by
> cross compilation and inspection only.
> 
> emac_remove() still does not call phy_disconnect(), which the phy-handle
> path gets wrong today as well. That is left to a separate change.

This commit message is overly verbose and contains a lot of irrelevant
information. That is typical of LMM generated commit messages.

Please try writing the commit message by hand. Its O.K. to write it in
your first language and use a LLM to translate it to English.

The commit message is about "Why?". And it is there to answer
questions the reviewer might have. This last sentence about
phy_disconnect() was one of the things i thought about while looking
at the change, but because the commit messages was so long, i had
given up reading it....

> Fixes: baab9de385a8 ("net: ibm: emac: use netdev's phydev directly")
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/ibm/emac/core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index 640618c..6e8b711 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -2674,11 +2674,14 @@ static int emac_init_phy(struct emac_instance *dev)
>  				return res;
>  
>  			res = of_phy_register_fixed_link(np);
> -			ndev->phydev = of_phy_find_device(np);
> -			if (res || !ndev->phydev)
> -				return res ? res : -EINVAL;
> -			emac_adjust_link(dev->ndev);
> -			put_device(&ndev->phydev->mdio.dev);
> +			if (res)
> +				return res;
> +
> +			if (!of_phy_connect(ndev, np, &emac_adjust_link, 0,
> +					    dev->phy_mode))
> +				return -EINVAL;
> +
> +			emac_adjust_link(ndev);

Why is emacs_adjust_link() still called?

    Andrew

---
pw-bot: cr
