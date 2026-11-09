Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235397;
	b=tUuadH0hCNjph8TagaGeMkgbXzU7AHIZhlUk19oK55pkhtkrDknSrwM9XjGhnh3thjbv
	 1tTC2qNp1p/OWXwZc3G9J5dt8Nb0mudi/Lan0JLcOHzjr7ItvIf89mPQ2e9ej2ikOilHe
	 XIljOu7IQ8a4rTQKSFqjrZyFDTJVEBHVD/zBxypXazuuK44Zjv6MusoJu1Kcu2E57k5hZ
	 gq5pWMgLKX04Lpq8YrvKhuqa4MZ9yY5nDXNDTrQY1pwpU6dxcNHyDWte2kdwOPsXuJTvm
	 YdYTvr54oPd+IsH+jUbsDN2AFadC7l5DlybhnovPqs2X+s7pGru7AmeS1DAH4Yq+4YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235397;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H9GbsQgd4Plq6EFDmaREhREbFnP7XG/lrP4WneaslFs=;
	b=A8/XSCCOdrcHHvf5IwfEZW9+9VhcfxuybWFAKWf0ACdaaiXlFbNyKJc5Qtq29JniC8XO
	 e8CLS7MmAO3S7QrhRd/FzjeGB2Kfi8vJj1eRm6UJF2nwZ0kNB3w55IKmjz6jFhp5coiwi
	 JOITOfzxYDcKbrYHsb4gX4GKSiAbShi8cdeXOq03z4inPPZqiCPeu3l0Y2r3q+YwPliK/
	 2/d0LHpL8YDboBYYw14msSkP5uDeLbeFb6tBNlKLOWZHMyK8NZ5aJjlxA2fwvEw+eaI64
	 3OIwqQJCyMq0PTeUAf19g3Il5bmqlPE/FApQds2LVm85ttnQry56AcBNkfuIQS2rzVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFenuXgZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE50606D805;
	Mon,  9 Nov 2026 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFenuXgZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF4D1F008A4;
	Mon,  9 Nov 2026 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794235397;
	bh=H9GbsQgd4Plq6EFDmaREhREbFnP7XG/lrP4WneaslFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IFenuXgZtQ4KL+mSyv4b1up4R/jp3l6uSq6skKWgEGKK7ValpptC4KnCZUp48QzZC
	 fNGetbwBMPymDcPIrq5zDGBCDk5xzS0K2Q1YcllmwYWkvtG0qVtvkiflc7ypo+x8+M
	 +zXk8AxSsKvF/6K9Ah6TwH+DVAFhrdhMtBA3bmdIRlKKxFHupxJGYeHPRe5y3OQdLo
	 OwZ4m+2kHUS4mKTTyRTPhJHPL/8g/45tkn0EiP0+jkCFihzrWgGxpzywEVqof07oyp
	 OCF2WVMHb/v9nrkDAypvDHHG2vYCFOvXqEhnr3kjtmnLNJ38JZWY56bLqKg4wfwCDq
	 fhOlZ/Y2ekIag==
Date: Mon, 9 Nov 2026 15:43:11 +0100
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH net-next 2/2] net: phy: marvell: add RGMII-to-Copper mode
 configuration
Message-ID: <avHb1O3lfPsEb0YY@solitude>
References: <20261109-marvell-phy-rgmii-v1-0-026979ef4f13@bootlin.com>
 <20261109-marvell-phy-rgmii-v1-2-026979ef4f13@bootlin.com>
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
In-Reply-To: <20261109-marvell-phy-rgmii-v1-2-026979ef4f13@bootlin.com>

On Mon, Nov 09, 2026 at 01:44:56PM +0100, Paul Louvel wrote:
> The driver currently programs it only for SGMII-to-Copper, based on the
> PHY interface mode.
> 
> Some MAC connect to the PHY via RGMII. Add code to configure the device
> in m88e1510_config_init().
> 
> Signed-off-by: Paul Louvel (Schneider Electric) <paul.louvel@bootlin.com>
> ---
>  drivers/net/phy/marvell.c | 31 +++++++------------------------
>  1 file changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index aef5f8279133..b8b466eb1c45 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -1394,31 +1394,14 @@ static int m88e1510_config_init(struct phy_device *phydev)
>  	if (err < 0)
>  		return err;
>  
> -	/* SGMII-to-Copper mode initialization */
> -	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
> -		/* Select page 18 */
> -		err = marvell_set_page(phydev, 18);
> -		if (err < 0)
> -			return err;
> -
> -		/* In reg 20, write MODE[2:0] = 0x1 (SGMII to Copper) */
> -		err = phy_modify(phydev, MII_88E1510_GEN_CTRL_REG_1,
> -				 MII_88E1510_GEN_CTRL_REG_1_MODE_MASK,
> -				 MII_88E1510_GEN_CTRL_REG_1_MODE_SGMII);
> -		if (err < 0)
> -			return err;
> -
> -		/* PHY reset is necessary after changing MODE[2:0] */
> -		err = phy_set_bits(phydev, MII_88E1510_GEN_CTRL_REG_1,
> -				   MII_88E1510_GEN_CTRL_REG_1_RESET);
> -		if (err < 0)
> -			return err;
> +	/* RGMII/SGMII-to-Copper mode initialization */
> +	if (phydev->interface == PHY_INTERFACE_MODE_SGMII)
> +		err = m88e1510_config_mode(phydev, MII_88E1510_GEN_CTRL_REG_1_MODE_SGMII);

This first part belongs either to the first patch (deduplicates the mode setting code)
or to a separate patch.

Marek

> +	else if (phy_interface_is_rgmii(phydev))
> +		err = m88e1510_config_mode(phydev, MII_88E1510_GEN_CTRL_REG_1_MODE_RGMII);
> +	if (err < 0)
> +		return err;
>  
> -		/* Reset page selection */
> -		err = marvell_set_page(phydev, MII_MARVELL_COPPER_PAGE);
> -		if (err < 0)
> -			return err;
> -	}
>  	err = m88e1011_set_downshift(phydev, 3);
>  	if (err < 0)
>  		return err;
> 
> -- 
> 2.56.0
> 
> 
