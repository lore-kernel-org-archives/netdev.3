Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809670;
	b=lJPH1AS2+CDi1+zWx00ko8QBt/Ea8s+uxpquZ9JgtvNnzTc84qzJn9fHfat+VMRBhj+F
	 3ZcA90/uxFldOCN5gLXgs069p+KSa6MfcpKTTWzLS40c/pu4M94RrNkScTa1JVipDnpiE
	 JIDds7fnoh4EMiqCXb76918RJTzJPM7DVp2tLKOqUpvlqeslddDWe7XEa8At0sRIQDREP
	 qpvHDo4cyLiymFKKbxCPSH/aHBVSQHqAnRyKQTCdD4ZUxG5fmBf4z0VqsIX2Tb75zjkpf
	 KYuiVhXAMsZNRHKzDvBFc0I5UhXt0YzaQ6x9K95qZ6Dil+ZE6+bH2vX016ln1I+sV9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809670;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=cu6cV1RAJXT2pjkVd/3sugyxa4+64+REz3NN248psQg=;
	b=cqzPCIH9vn/YUJdrS/iKmRHxoKXd1VV15cHFlKUg+WnwPvGUqRMCB0dlqqmewA6B3mFt
	 W6R9Lu7xfyGpYjvikv9jCcwPWSLx6n5BR9XA98kpTqzofXi+4j9AC9xbXEObE8HFQx0UT
	 XOdJoDzzjDWlmlcVp6EBoherFQUUns9jozWtuGH7epky/0fXw8F9lzh7f/zXgWJFgEdfa
	 mnobnMnp9OILZvyLS9Pj84UwSw6+gQ3PKf+Gny9+k4hGoeI9V0dxblaLea8eXZtjI51at
	 knFjPOvC7DdqJM1LsrKPggHSvr9RrnQA+DJSbnFqd5J6IV8eHL2wZA4d2sf9GDpJ9zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=v4+34glr;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79074606A31B;
	Wed,  4 Nov 2026 16:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79074606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=v4+34glr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=cu6cV1RAJXT2pjkVd/3sugyxa4+64+REz3NN248psQg=; b=v4
	+34glr1t4efCu4wh7nYrRIP4EMSfh4EX5rLzIYRLzznVOwZRJaELDFIIcAjLm8WSvMwVyyprsAkGj
	wShTGLtjFMM2mO7gM/6gBEyWSq9TRnaP8j0DzPZPNdGyHKTMKzY/bC+RxO9LjeB7/wQ+4s7d7YEDm
	PDPTg/oV0OSAsUI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOdpn-00ELsb-IL; Wed, 04 Nov 2026 17:27:35 +0100
Date: Wed, 4 Nov 2026 17:27:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Iustin Stolniceanu <iustin.stolniceanu@analog.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: c45: select 10BASE-T1L type when forcing
 10 Mbit/s
Message-ID: <fb774957-6e00-4d04-ae40-23e286cd691a@lunn.ch>
References: <20261104152534.1425241-1-iustin.stolniceanu@analog.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104152534.1425241-1-iustin.stolniceanu@analog.com>

>  /* BASE-T1 PMA/PMD control register */
>  #define MDIO_PMA_PMD_BT1_CTRL_STRAP		0x000F /* Type selection (Strap) */
>  #define MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000	0x0001 /* Select 1000BASE-T1 */
> +#define MDIO_PMA_PMD_BT1_CTRL_STRAP_B10L	0x0002 /* Select 10BASE-T1L */
>  #define MDIO_PMA_PMD_BT1_CTRL_CFG_MST		0x4000 /* MASTER-SLAVE config value */

I don't know where STRAP comes from, because 802.3 calls it type
selection. Version 2022 defines:

1 x x x = Reserved
0 1 1 1 = Reserved
0 1 1 0 = 10GBASE-T1
0 1 0 1 = 5GBASE-T1
0 1 0 0 = 2.5GBASE-T1
0 0 1 1 = 10BASE-T1S
0 0 1 0 = 10BASE-T1L
0 0 0 1 = 1000BASE-T1
0 0 0 0 = 100BASE-T1

It would be good to add all of these.

> @@ -182,6 +182,10 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev)
>  		bt1_ctrl = 0;
>  		if (phydev->speed == SPEED_1000)
>  			bt1_ctrl = MDIO_PMA_PMD_BT1_CTRL_STRAP_B1000;
> +		else if (phydev->speed == SPEED_10 &&
> +			 linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT,
> +					   phydev->supported))
> +			bt1_ctrl = MDIO_PMA_PMD_BT1_CTRL_STRAP_B10L;
>  
>  		ret = phy_modify_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_PMA_PMD_BT1_CTRL,
>  				     MDIO_PMA_PMD_BT1_CTRL_STRAP, bt1_ctrl);

And this should be made more generic. Maybe add a helper which takes
speed and supported, and returns the correct type selection. We don't
yet have 2.5G, 5G or 10G BaseT1, so you can skip those.

    Andrew
