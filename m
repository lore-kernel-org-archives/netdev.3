Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED659378D8A;
	Mon,  5 Oct 2026 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791244213; cv=none; b=hZ3ll1SShtSdVRRx7dTx94jKf+GX20xCO2i6uaUj5EQ6b3LPjdhPMuKDkaVoLwRm9Q04bo9okzqt1sa9nYih9PMO4eoXYAarfY3qTSD+JWuNn0UcrgmErF3EpQl+wGyb6KdjuaeuCNKjQJyzJAL/S2x2kunQV/Oerm1AVDdUTro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791244213; c=relaxed/simple;
	bh=cbJZI6Uf65g/LZcP9oQLy+dfnj0ytsCgKzbPwvSs25g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQ3ZzUtaBPin855EfYdFQGD6SdfkNF+fLMBaEUWuiswigDLN3Wef2YKLrWe2B/i0kGGqEkUiHjPl4AW4i2x95yCAGMPG8AM4eZee2udseMScVBQmuoK7rD+UVLjxnJrB+BQk4tWsIkBWG8C7JFRDgcxzkZ5XozYeMMGZyNKgHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=p1W9hGEV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="p1W9hGEV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dc5Nrd0f6InjZVJrPSXowx+WxVSmZMtqZBt/bU7zVHk=; b=p1W9hGEVMTStzHP2TrXAV7+cph
	lwBiNyKQPbGJymv/gn7F5Bbjo86VE+ZffYaLS00I2x50PgDtFepqjMImK067ECcAgC3KPAb6lVEch
	mksGqtM9gi+cNdnv+pWcsj+iMn20vhom1Ypv4fOcacNZHPeLgCEXTmDau7J86dS4wcio=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xDsRS-0099At-8G; Tue, 06 Oct 2026 01:49:58 +0200
Date: Tue, 6 Oct 2026 01:49:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Michael Stapelberg <michael@stapelberg.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
Message-ID: <6fd06ce1-e792-4ce9-a0db-711fad1ffeef@lunn.ch>
References: <20261005225028.465866-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005225028.465866-1-rosenp@gmail.com>

>  #define MII_M1011_IMASK			0x12
>  #define MII_M1011_IMASK_INIT		0x6400
>  #define MII_M1011_IMASK_CLEAR		0x0000
> +/* Bits updated by config_intr. The WoL interrupt enable is owned by
> + * set_wol, so the config_intr call from phy_init_hw() on resume does not
> + * silently disarm Wake-on-LAN.
> + */
> +#define MII_M1011_IMASK_CONFIG_MASK	(U16_MAX & ~MII_88E1318S_PHY_CSIER_WOL_EIE)

I still don't like this. The name MII_88E1318S_PHY_CSIER_ suggests
this belongs to the MII_88E1318S_PHY_CSIER register.

> +		err = phy_modify(phydev, MII_M1011_IMASK,
> +				 MII_M1011_IMASK_CONFIG_MASK,
> +				 MII_M1011_IMASK_INIT);
>  	} else {
> -		err = phy_write(phydev, MII_M1011_IMASK,
> -				MII_M1011_IMASK_CLEAR);
> +		err = phy_modify(phydev, MII_M1011_IMASK,
> +				 MII_M1011_IMASK_CONFIG_MASK,
> +				 MII_M1011_IMASK_CLEAR);

But here you apply it to the MII_M1011_IMASK register.

> +	if (!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY))) {
> +		err = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
> +		if (err < 0)
> +			goto error;
> +
> +		/* Disable the WOL interrupt, config_intr leaves it alone */
> +		err = __phy_clear_bits(phydev, MII_M1011_IMASK,
> +				       MII_88E1318S_PHY_CSIER_WOL_EIE);

And here it much more obviously looks wrong. These prefixes are there
to catch dumb typos, and somebody is going to look at this, and think
it is a dumb typo and report it.

Please fix the naming.


    Andrew

---
pw-bot: cr
