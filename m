Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CA3C9EE0;
	Mon, 12 Oct 2026 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806608; cv=none; b=s4Zeo+EmgCdCQ08y6LXYZIlDqzXJ8jYRsTz6qcgLi7kA4bKjZUhBsKcnhUcF/6rETjV3Prqg1J7xt7lvaTx3/0A6fCIhS0wVw9v5qOzqC4wRmZ3DDDvN9kSacXppAykJZ/GwJxQVRd8ISRqrBK/IGagReEV6lmNh1sOpExf66Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806608; c=relaxed/simple;
	bh=/ZZ0fgr8G0s902ax4FUxuZ1iYpydpIsNtcAH8jejZ4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp6ZWz88F+bhCiXC8W3U8lhgAJNFXM95GYJbdpeOELCbwewig0Wikdju/IleO6mP68OUp6kv4aE3QmmxFFdoAnjYq7XS9cPdx0278ijGoJmDF3ZUrE5iDv/5xKhER/hSgDfCuxuVzNb5Jphqkk+8a++9hQRbJs2N5UdcanBX17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=w66lYjJY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="w66lYjJY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0nZec0j/vltLFTiegdvyacQqA6mcFK7PhOPa5liUkac=; b=w66lYjJYMm4H8JjWbHnCKPaVIi
	MqR3rdrl5tSSqZW5rCo7d7xvD4zFqR7cMZMuix6HuR7karG9jLP69hGWlbAr4CuQukNMsgBcfqvbK
	QsfFdLOklb7DH4pkAOgB8QrxQctmxKbi3IPEUwS9NuOtUz2/5Ou/Wpt8m8t9RPkKOrKg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGEkM-00AJjG-9E; Mon, 12 Oct 2026 14:03:14 +0200
Date: Mon, 12 Oct 2026 14:03:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: James Clark <jjc@jclark.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>, Nicolai Buchwitz <nb@tipi-net.de>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	Conor Dooley <conor.dooley@microchip.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement
 timestamped MDIO writes
Message-ID: <2554f883-89f4-4688-95ae-aded7a84592b@lunn.ch>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-6-jjc@jclark.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009143506.2507607-6-jjc@jclark.com>

> +static int unimac_mdio_sts_delays(struct unimac_mdio_priv *priv,
> +				  u64 *pre_ns, u64 *post_ns)
> +{
> +	u32 cmd, config, divisor;
> +	int ret;
> +
> +	/* The delays assume the controller is idle. */
> +	ret = read_poll_timeout(unimac_mdio_readl, cmd,
> +				!(cmd & MDIO_START_BUSY),
> +				1, 1000, false, priv, MDIO_CMD);
> +	if (ret)
> +		return ret;
> +
> +	config = unimac_mdio_readl(priv, MDIO_CFG);
> +	if (config & MDIO_SUPP_PREAMBLE)

The preample has a fixed size, so you can take this into account,
reduce your 64 to 32.

> @@ -138,19 +192,38 @@ static int unimac_mdio_write(struct mii_bus *bus, int phy_id,
>  	if (ret)
>  		return ret;
>  
> +	if (sts) {
> +		ret = unimac_mdio_sts_delays(priv, &pre_ns, &post_ns);
> +		if (ret)
> +			goto out;
> +	}
> +

Maybe just repeat unimac_mdio_write(), rather than try and squeeze all
this sts stuff into what is a simple function.

	Andrew
