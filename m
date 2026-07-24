Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985DA25B08C;
	Fri, 24 Jul 2026 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901108; cv=none; b=ZGrkNi80G+kxI3eSfL2kscS9i78ahNrwpDZkhTGam/zTn+cGq01h9KAYe2Git5jSXfDgCX8ectJ1p1GM+BvQHtmx12Ya9vzzobZexuKmF/Ogsx4uZlYqiu4NlVVRuRe+bqlOlbq8ojBOjg3wMM4St5lQRxsPdTR+83cOt8QRG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901108; c=relaxed/simple;
	bh=8sZEWlVt1ZJmC9Bn3o4Y7V3HHm8eSB++IT0z2FDVmpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptjOQHelwjDIclosOHc0r0jybVgieBN9wl3tbLK9lWX7ZTdUy/ySLWQH85GZ054qhZRQ9TBPzFXz1lzu0j7s7cxD+SmVuEUOV6QSHkM8T/QtmFe39Ula7Pl5n0wcvo41IpeLj2taMI2U0opCUP+WnbpdEyHOadyMHxIQqvLGKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SyiNbaxK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SyiNbaxK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fZDbhl4UibAgTEpmyPxtbMjlPxjC0LAo/V4ng++sd+U=; b=SyiNbaxKQ74vpNdh5kG64iYz1a
	VLCDKjvUNI2582451IfR86TG0X0aOeqzqDuI7wV7CGVuPCkzY5f2uVLPHlLI7+A8XmMBQkOKhU1Uo
	UQT3FmAjs0ZZ1XDXs9KlUXHY8Tde9IMaLjdB3l+ca35KnWc6Ff1F3MvSC+3JvZgx81XA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnGJO-00E0Fm-0U; Fri, 24 Jul 2026 15:51:38 +0200
Date: Fri, 24 Jul 2026 15:51:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
Message-ID: <d3541378-6a47-4c2e-8a81-c45473a66ff7@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-13-bdde4f905883@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724-ax88179a-v3-13-bdde4f905883@birger-koblitz.de>

> +static int asix_ax88279_read_status(struct phy_device *phydev)
> +{
> +	int ret, val;
> +
> +	ret = genphy_update_link(phydev);
> +	if (ret)
> +		return ret;
> +
> +	phydev->master_slave_get = MASTER_SLAVE_CFG_UNSUPPORTED;
> +	phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
> +	phydev->speed = SPEED_UNKNOWN;
> +	phydev->duplex = DUPLEX_UNKNOWN;
> +	phydev->pause = 0;
> +	phydev->asym_pause = 0;

Is it possible to call genphy_read_status(), and then do extra things?
That would save some code.

> +static int asix_ax88279_config_aneg(struct phy_device *phydev)
> +{
> +	bool changed = false;
> +	int ret;
> +	u32 adv;
> +
> +	if (phydev->autoneg == AUTONEG_DISABLE) {
> +		phydev_warn(phydev, "Disabling autoneg is not supported\n");
> +		return -EINVAL;
> +	}

Does the PHY say it supports autoneg? genphy_read_abilities()? If it
does, you should clear the bit from supported.

	Andrew
