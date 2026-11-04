Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793826973;
	b=ulYtFqmglGpgML9VckQuU40lvKP7pQWSKXQz0oX8GdukuMhgYINpktixWHCOasAnxsWj
	 7Ek62SIvJSDlVIDdtfNRhpX+PmBlGpIWaTlt5Id/GXD4Cojxc4PqohtBjkwP0cWojhMT7
	 TAIsfxvBtx/OwNeXdvnl4GHZCFbmTXapZvAMwzH6gR+nbK1x8EF1l2tPNlV+2OjI1riT4
	 JoUfhnNehi8HO+oP8S8UwrTU8dgpEf5sRU5Ja9BODfLhfOgy8RMuOtYursctqmMjQQTjF
	 9A3dkgL5MzKmZvEJeQIuHunE+TdjKUPYWcKDym2ee59hXxSysvKqIvU3Of61F7HXQaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826973;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=E0amS/985lEuA/641nlWSjwLQ/LPYEzaMW2+uW18C48=;
	b=VesdSblhAdjjGaxgBP1o3r9aV/RO+A2WufU13+iitdRdRL3MdD+9P+d6tIFwRnW8k6lK
	 ZoIUxWJV0UGXkbaYoWBoQ6m1cw/JH3Vdz+h3YwZNQwJyL0NSF2ws7YRzqWCEBsMNzpN6N
	 hrcNB/GzJbBH61GKGUj71CfeCAkb/8j+Bznk2HDttgpvFcZILLS52WSa1qEaku5SA3vUw
	 NXRokC4Y7+ycQ+a4I7U1z25aqwDckuxXeAYnGsm5RSFa6nfJeSGIgun5HLWnhnGDzicfp
	 PyU2+Q+/jkpzCEKzxt4A2+HX6ATK+JbWTBEd8+UXw2Dj4dtp5RPXbAg8ucYlRJwteqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=kIyTVelH;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBD860BC548;
	Wed,  4 Nov 2026 21:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BBD860BC548
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=kIyTVelH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=E0amS/985lEuA/641nlWSjwLQ/LPYEzaMW2+uW18C48=; b=kIyTVelHs7ZyeksgK64eNJxXc7
	7XDnyK5BAGb07K70+4umsiUIAQa0uMwlx+epvyMTi5GaAEWEiF5OCBqhwJ6MsdfZYSReQVKOV5sbw
	HfPDyWC8Jb7wpGA9JGU/Mb3QAfYhDvyc2rptefd8TI/PZthm8wUp9bZ0Nh10LOn/a76Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOiKx-00EOD1-CE; Wed, 04 Nov 2026 22:16:03 +0100
Date: Wed, 4 Nov 2026 22:16:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: Iustin Stolniceanu <iustin.stolniceanu@analog.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ciprian Regus <ciprian.regus@analog.com>
Subject: Re: [PATCH net-next 5/5] net: phy: adin1100: Skip the soft reset on
 ADIN1110/ADIN2111
Message-ID: <309a1eb9-8255-42f0-a510-b40bf3302bbd@lunn.ch>
References: <20261103160918.409701-1-iustin.stolniceanu@analog.com>
 <20261103160918.409701-6-iustin.stolniceanu@analog.com>
 <autAidTgykOObtzp@analog.com>
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
In-Reply-To: <autAidTgykOObtzp@analog.com>

> > @@ -232,6 +232,15 @@ static int adin_soft_reset(struct phy_device *phydev)
> >  {
> >  	int ret;
> >  
> > +	/* On the ADIN1110/ADIN2111 MAC-PHYs, CRSM_SFT_RST resets the whole
> > +	 * chip, undoing the MAC driver's setup, and MDIO reads return stale
> > +	 * data until it completes. The MAC driver has already reset the
> > +	 * chip, so skip it here.
> > +	 */
> > +	if (phy_id_compare_model(phydev->phy_id, PHY_ID_ADIN1110) ||
> > +	    phy_id_compare_model(phydev->phy_id, PHY_ID_ADIN2111))
> > +		return 0;
> 
> It seems more common to have a separate struct phy_driver entry in the
> array passed to module_phy_driver() with a more precise
> phy_id/mask. Then for ADIN1110/ADIN2111 you'd omit the
> .soft_reset. Maybe Andrew knows what is preferred here?

Humm...

#define PHY_ID_ADIN1100				0x0283bc81
#define PHY_ID_ADIN1110				0x0283bc91
#define PHY_ID_ADIN2111				0x0283bca1

static struct phy_driver adin_driver[] = {
	{
		.phy_id			= PHY_ID_ADIN1100,
		.phy_id_mask		= 0xffffffcf,
		.name			= "ADIN1100",

That phy_id_mask is funky.

static const struct mdio_device_id __maybe_unused adin_tbl[] = {
	{ PHY_ID_MATCH_MODEL(PHY_ID_ADIN1100) },
	{ PHY_ID_MATCH_MODEL(PHY_ID_ADIN1110) },
	{ PHY_ID_MATCH_MODEL(PHY_ID_ADIN2111) },
	{ }

And this contradicts it.

Please leaf through the datasheet for these devices and check how the
ID is defined. Often the lowest nibble is the revision, so 0x0283bc81
and 0x0283bc8f would be the same device, just different bugs.
However, they can be different devices. This is why we have:

#define PHY_ID_MATCH_EXACT(id) .phy_id = (id), .phy_id_mask = PHY_ID_MATCH_EXTACT_MASK
#define PHY_ID_MATCH_MODEL(id) .phy_id = (id), .phy_id_mask = PHY_ID_MATCH_MODEL_MASK
#define PHY_ID_MATCH_VENDOR(id) .phy_id = (id), .phy_id_mask = PHY_ID_MATCH_VENDOR_MASK

Since they are different devices, it would be good to have multiple
struct phy_driver, if that can be done without breaking backwards
compatibility.

	Andrew
