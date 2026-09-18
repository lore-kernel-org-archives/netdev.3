Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D939274FE3;
	Fri, 18 Sep 2026 02:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697148; cv=none; b=qpdU2rC7Hodq8z+LxqR/F6skVj9EzYojDpnWqlxf29cnMn/Gmnh92zXIRJn71SjtVrB106DkfWkCIZqU4M94Ux5f0eX5toS+xLARWzIMqcCpbFrhk3aGsO+cq/n0223FcdUy+32mJMN605WgOwCq0JpV3teQnFlKR/AJrkpcTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697148; c=relaxed/simple;
	bh=fGpoYLdZ41d0tFhRKmenhpPMK/bDHssfC0ONNUAm53s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSMpN7MgeFEWTvaBsLPE5pR8PmeSYvG1+v5Ft/SgUL1ukY0l2cGJ8EGgk/FIx5ko0KbvcmVbUgJyK7El3W/5tZ+h20Yi5jMINRlC1kyMcBdJuscElmouObeHFK/0ipn0gxrkMnTjtl1NWyUL2LUW1y+kes998bWAAgHsjxuS4XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xjpj5GYs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xjpj5GYs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UXIPYTzbXNJwJbfl1Qo9b3rso/BuNEE9ZA2tivDFk5U=; b=xjpj5GYsO7djcq0k7DWwaX38La
	BQe5WZViaU0ZD7vbE9kDfkPfpg4o52muffHnZY3xd6swPjEC/fdauTgAcaDiIr+x4s+3/GmPa2T4I
	qN5HGSHYJ5JnvjkmQfrlGkT3jbZdz/nByj6BL6LSxKuBbsfO8Zx3RD69yOVjNB49Q7cg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7Nyp-005mgK-OQ; Fri, 18 Sep 2026 04:05:35 +0200
Date: Fri, 18 Sep 2026 04:05:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	olteanv@gmail.com, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v8 2/4] net: usb: smsc95xx: register the PHY
 interrupt with the MDIO bus
Message-ID: <6e14d6b7-2a5a-40e2-920e-fc69a6e85173@lunn.ch>
References: <20260918015029.2518425-1-f@lex.la>
 <20260918015029.2518425-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918015029.2518425-3-f@lex.la>

On Fri, Sep 18, 2026 at 04:50:27AM +0300, Aleksei Sviridkin wrote:
> The interrupt this driver maps for its PHY is written only into
> phydev->irq, while the bus table mdiobus->irq[] keeps reading PHY_POLL
> for the same address. That table is where phylib records what the bus
> described - phy_device_create() seeds phydev->irq from it - so the
> number lives only as long as nothing else writes that one field.
> 
> The bus is the one this function registered a few lines earlier, so
> record the number there as well.
> 
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
> 
> Notes:
>     Compile-tested only; I have no LAN95xx device.
>     
>     No Fixes: tag, for the same reason as patch 1: the write has no reader until
>     patch 3 lands.
>     
>     Teardown order keeps the number live for as long as it is read:
>     smsc95xx_unbind() disconnects the PHY before it disposes the interrupt
>     mapping.
> 
>  drivers/net/usb/smsc95xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
> index 42e4048b574b..130a460c1f54 100644
> --- a/drivers/net/usb/smsc95xx.c
> +++ b/drivers/net/usb/smsc95xx.c
> @@ -1252,6 +1252,7 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
>  		goto unregister_mdio;
>  	}
>  
> +	pdata->mdiobus->irq[pdata->phydev->mdio.addr] = phy_irq;
>  	pdata->phydev->irq = phy_irq;

Looking at just the information here it looks like this line can be deleted?

	Andrew
