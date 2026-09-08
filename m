Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A241522F767;
	Tue,  8 Sep 2026 01:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829777; cv=none; b=p5dFvjvsYbpsXttXVOnN3FAiJ/w4Hf592mx4tA9zBNk5sfreoMvSoJ0Q15DDr4Gl5VmqSTJE2nELwY3AMANPMYHD1e8cJR9Jrml2w1xlvLGXee/vVvTASFXYF5H4OOAPSHN+XF4iygng8HWgWBaXEJ4zmwEd+8UeRZjdbSzbvnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829777; c=relaxed/simple;
	bh=lYYdr8aZ/KWIgT34+DfBgMKwjmAvf+YF0u3OH3VAQ1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWCDT6BbjFSc1Oa2cUlVlknKiIWKMhK12b3YoA1Vpnif8lvlNjU42w0jnwG2TmI0bGo6Hw+WiprO5xeNkbqYOKwyeWeeCg58CNbj7MbqkTQFBEKOwg9uQGoNClRiVJtf4JU5oxL7KGAK6dece0DmWEU2TvH04aRUlVnG19PLmyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f4EMCe6V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f4EMCe6V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3XAVswRXW6p01lIOQ9GuGtJVZM7RbmdUOwiDO1g1a9c=; b=f4EMCe6VEposk23h1RJa8aG1a7
	0F3bhcZ7Dn3RuC9IuM5IbgyoZaw1zp4iHABfVk6BqEQlGa9l4FlmWGxeRLxvBkQsnpSUumgIuglyw
	43vPWFQE8EHrLJXHNsMxl26OJ2Q7qO32CC0uU4BR+5U6CKFpRJoBV6oxgBO+Csd5gq/s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3kKv-003hMJ-UR; Tue, 08 Sep 2026 03:09:21 +0200
Date: Tue, 8 Sep 2026 03:09:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 2/2] net: phy: restore the interrupt phy_probe()
 replaced with PHY_POLL
Message-ID: <8f67d3ba-ce25-49bf-8378-c76d748879a9@lunn.ch>
References: <20260906174643.4107607-1-f@lex.la>
 <20260906174643.4107607-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906174643.4107607-3-f@lex.la>

> @@ -591,6 +591,8 @@ struct phy_oatc14_sqi_capability {
>   *      - Bits [31:24] are reserved for defining generic
>   *        PHY driver behavior.
>   * @irq: IRQ number of the PHY's interrupt (-1 if none)
> + * @irq_saved: @irq as it was before phy_probe() replaced it with PHY_POLL,
> + *             or PHY_POLL when there is nothing to restore

I don't really like this. We should bite the bullet and make
mdiobus->irq[] the source of truth. It does not look too bad:

usb/lan78xx.c has an mdiobus.

       /* if phyirq is not set, use polling mode in phylib */
        if (dev->domain_data.phyirq > 0)
                phydev->irq = dev->domain_data.phyirq;
        else
                phydev->irq = PHY_POLL;
        netdev_dbg(dev->net, "phydev->irq = %d\n", phydev->irq);

        ret = phylink_connect_phy(dev->phylink, phydev);

This can be changed to set the value in the mdio bus structure.

usb/smsc95xx.c: You have direct access to the mdiobus, the same
function just registered it.

ethernet/freescale/ucc_geth.c: This is about WoL, so no change needed.

ethernet/xscale/ixp4xx_eth.c: Appears to be pointless
ethernet/qualcomm/emac/emac-mac.c: Also pointless
ethernet/asix/ax88796c_main.c: More pointlessness
ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c: Pointless in a different way

ethernet/broadcom/asp2/bcmasp_intf.c,
ethernet/broadcom/genet/bcmmii.c, ethernet/engleder/tsnep_main.c all
set PHY_MAC_INTERRUPT. genphy should not need to touch that.

ethernet/stmicro/stmmac/stmmac_mdio.c: One of the previous types of pointless.

So please work on these.

   Andrew
