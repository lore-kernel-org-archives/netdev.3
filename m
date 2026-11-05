Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891245;
	b=O9N2d/C6uJyxf69cGPxA5Nwx+47PTuxC0uq4phVVz7IGm9mFoyZijDS9rqqUmnjM9T/V
	 BbN/kI2UXG6zZx0Kdsk6t9ZR9Zp3X7kCgLomPj8MLg/vnD36xHLVdi+Auga87yYFNsiEO
	 w2wa41QptBqF5tTWO1G2cdMUMlxNKgCTFTrd/QX1SAo58h3OTndLPvZ1XP+xN78r53OTL
	 82zwbLQFxS/9yn4V2CdrD3XFUnIY4/zCjxrWSCG7zT6+Jb73r8iqrKA1MFd5r/rPidzDb
	 YNb9opzPSoPC9E7KccWmh4I7yQsWEDRtXQhMcbskFnTfIvLd0574hCsphvKJHfHcNwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891245;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=/LZVYkE9SzcHKEGbGD/UnXJb3GHGzdlrPARxMed/c3c=;
	b=b8xprGCeOYKqBOIxWN48Pxk2nlyNeom+HzT5YpV+hGx1FvonYRxxCaVgCHuVrBXffRZ2
	 zcO7e/jLfGTpbssPGHDbi0FKi2tIhBKHrV5yyMLt3cN5q20TdMS/0LZaHB6XMyJsrrHjI
	 q0bTyGnLd0GgO7XT/LPeS6/Tg8k7i18AEkPL9KUGAgFxrJAiL//b1MxFRecG0c46LoMPE
	 oF//L146c9XV58QOiCIZW2BRABZp4Us7+XpJR9G6Glvcd/KgdvVaH6l4GuGOIgtU+PnVu
	 3Z55HMt0ZRnw2lKwxt44IR8mpxcYTb86dhXwEUO+FtIMGRR9MJC/K8APWvpRxIcAheQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=cd5XF6gB;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211D4606A31B;
	Thu,  5 Nov 2026 15:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 211D4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=cd5XF6gB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/LZVYkE9SzcHKEGbGD/UnXJb3GHGzdlrPARxMed/c3c=; b=cd5XF6gBDAaFibb32JHXh71irU
	eV4fR1YrT8BEZN6OjopseAnf1YIy96cpaqk5lqFpr9OsRCUnalkJyirs2jKLpM34yvIYpg22vlmoo
	nP4xkXhN9iMxVhFcV+7ZnKPz5KhZeOgASBcsz9W9ix/zn+6pgGVRXzEjkpZ88qK/ClHo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xOz3b-00EalB-SD; Thu, 05 Nov 2026 16:07:15 +0100
Date: Thu, 5 Nov 2026 16:07:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: isasmendi.agus@gmail.com
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: add driver for the ZTE ZX279128S
 internal Gigabit PHY
Message-ID: <b38a7a97-c88c-44fa-ab0f-89d1e809e21e@lunn.ch>
References: <20261105-phy-submit-v1-1-eb382681a76a@gmail.com>
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
In-Reply-To: <20261105-phy-submit-v1-1-eb382681a76a@gmail.com>

> +static int zte_gephy_config_init(struct phy_device *phydev)
> +{
> +	int ret, i, ldo;

Given how minimal this driver is, there are some potential traps we
could fall into later when we find out more about the device. To
reduce the risk a bit, please could you add a test here:

       if (phydev->interface != PHY_INTERFACE_MODE_INTERNAL)
         	  return -EINVAL;

> +static struct phy_driver zte_gephy_driver[] = {
> +	{
> +		PHY_ID_MATCH_MODEL(ZTE_GEPHY_PHY_ID),
> +		.name			= "ZTE ZX279128S Gigabit PHY",
> +		.flags			= PHY_IS_INTERNAL,
> +		.config_init		= zte_gephy_config_init,
> +		/* The boot firmware hands over with BMCR_PDOWN set. No
> +		 * .suspend: powering the analog domain down and up at runtime
> +		 * has not been tested.
> +		 */
> +		.resume			= genphy_resume,

It looks odd with just resume, it makes it look like a workaround.

Why not have config_init() take it out of power down?

    Andrew
