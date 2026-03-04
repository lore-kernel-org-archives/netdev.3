Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBCD373BF5;
	Wed,  4 Mar 2026 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658421; cv=none; b=pUAPPYKj7CrPy4OFFk2i/3sHX2BiuAhrPcsZGwDxnscLNMhD61KKJyDF1KIYkuUXLFBc7j6ux5Nu890Zi4cH6qroPXlRrBXjA5p0/Us4W4ZQVw9/+WH8JT3+mwcr/osxkteuLhsutzpUHYiR9bwTPUIH1Mb8P9f0cPBcW+en9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658421; c=relaxed/simple;
	bh=OP+RBHgHYvejrWEZCt/HTNw2zR66Wz18oi9+00mMvgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGQ3K6p1T1FQKitWIbbM48B01q4HPdE9dHiOkapZKhAv7aVn2vMOSN/Qzt1K+mUusuLaS1ff6vPxe1fZf1GbdDLBvgMSi7dRr7ND6GaAXYfN86MRc5Atzu6NnenjP0so1PVa4UCfG6NalAfRQBnQMTUMrMci7644A5TuXu+Voq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bts4mfUW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bts4mfUW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=clDA5CykP+PmNMythbvTV2Fm5hdOkewoD5K3MJS/+wg=; b=bts4mfUWa5uGa3NcZMB73JECy4
	zn0I2b8Jc+bn8SWfEi25R8AJk8V4wTZNTwaQRYMpilcLSmefTYRpZiYzV53N+DRuivXXC8QvShk+E
	h0P2E/ho9usIqNXiTSo7OuxOB5BtMT6bG50x+WkTtUq1/F+1W2Xr7Zkwj9SOAOiUNKD8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxtQg-00AAtm-LF; Wed, 04 Mar 2026 22:06:50 +0100
Date: Wed, 4 Mar 2026 22:06:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, alexander.stein@ew.tq-group.com,
	aziz.sellami@nxp.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net] net: enetc: fix fallback PHY address handling and do
 not skip setting for addr 0
Message-ID: <2746e5d8-b471-44c2-9625-b009e6f1581b@lunn.ch>
References: <20260303103047.228005-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303103047.228005-1-wei.fang@nxp.com>

On Tue, Mar 03, 2026 at 06:30:47PM +0800, Wei Fang wrote:
> The current netc_get_phy_addr() implementation falls back to PHY address
> 0 when the "mdio" node or any PHY child node is missing. On i.MX95, this
> causes failures when a real PHY is actually assigned address 0 and is
> managed through the EMDIO interface, the bit 0 of phy_mask becomes set,
> leading imx95_enetc_mdio_phyaddr_config() to return an error, and the
> netc_blk_ctrl driver probe subsequently fails. Fix this by returning
> -ENODEV when neither an "mdio" node nor any PHY node is present.
> 
> Given that some platforms may use PHY address 0 (I suppose the PHY may
> not treat address 0 as a broadcast address or default response address).
> It is possible for some boards to connect multiple PHYs to a single
> ENETC MAC, for example:
> 
>   - a SGMII PHY with a non-zero address (selected via DTS_A)
>   - a RGMII PHY with address 0 (selected via DTS_B)
> 
> For the case where the ENETC port MDIO is used to manage the PHY, when
> switching from DTS_A to DTS_B via soft reboot, LaBCR[MDIO_PHYAD_PRTAD]
> must be updated to 0 because the NETCMIX block is not reset during soft
> reboot. However, the current driver explicitly skips configuring address
> 0, which leaves the hardware in an inconsistent state.
> 
> Therefore, remove the special-case skip of PHY address 0 so that valid
> configurations using address 0 are properly supported.

Please can you break this patch up. I've not looked at all the details, but:

> diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> index 7fd39f895290..92a0f824dae7 100644
> --- a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> @@ -333,11 +333,13 @@ static int netc_get_phy_addr(struct device_node *np)
>  
>  	mdio_node = of_get_child_by_name(np, "mdio");
>  	if (!mdio_node)
> -		return 0;
> +		return -ENODEV;
>  
>  	phy_node = of_get_next_child(mdio_node, NULL);
> -	if (!phy_node)
> +	if (!phy_node) {
> +		err = -ENODEV;
>  		goto of_put_mdio_node;
> +	}

This looks like it could be one patch.

> @@ -423,6 +425,9 @@ static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
>  
>  			addr = netc_get_phy_addr(gchild);
>  			if (addr < 0) {
> +				if (addr == -ENODEV)
> +					continue;
> +

This seems like a patch when combined with the if (addr < 0) hunk
below.

> @@ -433,12 +438,6 @@ static int imx95_enetc_mdio_phyaddr_config(struct platform_device *pdev)
>  				return -EINVAL;
>  			}
>  
> -			/* The default value of LaBCR[MDIO_PHYAD_PRTAD ] is
> -			 * 0, so no need to set the register.
> -			 */
> -			if (!addr)
> -				continue;
> -

This can be a patch, along with the same delete in the last section of
this patch.

The point of having lots of small patches is that it makes to find
regressions. If something does break, git bisect will quickly tell you
which patch is was. The less a patch does, the more git bisect is
useful.

    Andrew

---
pw-bot: cr
