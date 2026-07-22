Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD4331A7E;
	Wed, 22 Jul 2026 18:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746268; cv=none; b=omaVC/cldqnUqz10XqptO+12DfWv2AUTDtDiOjwX7+5mw/B19xVTlxVDc3wGiIkvJmERwYhXjpXO3WOP5GxLRMh6Nsm4rKblx3ei5ZP6VgGPl6744yPG5JHirsMZWfywyuxKW3QP1n0pesKDxPeDTmE+u8WrrInl81tFjv4nR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746268; c=relaxed/simple;
	bh=BH7O2vXBCNmomL+k2K5LrY/MmKy1B6XfF4mg5W1S8ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyTSOgjO/8mIEnGSS+YgsJltF84aPSK1HZLTZGIACnxj4HC6ZIDyWt46s6/NPjhVi2rjzNR4DfvgIhIvB9OSz7MibrYbzBN0NRTnw2D0CnQAciCyMXdqk8rOy7DjZuAZ9vccCssshMWXcZUg9fcGY60Zd862+wtQIFhjPiE9Idw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0D456qW5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0D456qW5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Gnm8wwzEHwb0t08Gu5gsi6orQEPW9HNNjUDGYyg1FjA=; b=0D456qW5qkqDF2fHAN+rFWf88v
	zt7+O1zzQNnuHk08s+qPWdOsNw3LKRaRGKk+oQSBq2H15t6jDMUyCURcDNCXnMqHMH7qamYl4+obq
	ZvRTl4jPb/LeNeMXQksM4moLik8F6eKwT3xLYV37+F+ILy/a6m88xyBmrA7FzLeKQ9+g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmc1q-00Dg9N-Uu; Wed, 22 Jul 2026 20:50:50 +0200
Date: Wed, 22 Jul 2026 20:50:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/8] net: mdio: realtek-rtl9300: Configure
 hardware polling during probing
Message-ID: <529e93b4-c726-4a47-aba9-b5f63e273ca4@lunn.ch>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
 <20260722062356.12291-5-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722062356.12291-5-markus.stockhausen@gmx.de>

> +static int otto_emdio_notify_phy_attach(struct phy_device *phydev)
> +{
> +	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(phydev->mdio.bus);
> +	int port = otto_emdio_phy_to_port(phydev->mdio.bus, phydev->mdio.addr);
> +	int ret;
> +
> +	if (port < 0)
> +		return port;
> +
> +	scoped_guard(mutex, &priv->lock) {
> +		if (test_bit(port, priv->phy_poll))
> +			return 0;

You seem to be assuming otto_emdio_notify_phy_attach() and
otto_emdio_notify_phy_detach() are not called strictly as pairs. Does
this actually happen?

> +static int otto_emdio_init_polling(struct otto_emdio_priv *priv)
> +{
> +	int err;
> +
> +	for (int port = 0; port < priv->info->num_ports; port++) {
> +		scoped_guard(mutex, &priv->lock) {

What is this mutex protecting?

> +			err = otto_emdio_set_port_polling(priv, port, false);
> +			if (err)
> +				return err;
> +		}
> +	}
> +
> +	return 0;
> +}
> +

    Andrew

---
pw-bot: cr
