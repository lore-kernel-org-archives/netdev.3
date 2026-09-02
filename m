Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87321A76BB;
	Wed,  2 Sep 2026 00:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308092; cv=none; b=a9jQd7ihPgn+0RlrIoZR7hlxNG50B3P6uSHkN3XDlPwF5BGeKMZrLNXD7BtvTeSy5UOKJAeIM2gKbNJUglIsGY6i0bP7uRCbeIQFUOz6/3u0mOiFmpVK1SLwjlrsEuuEcH2D5zC9EPfVxf+Fy1TlD8aLw5sev9cRiaRyHghMqJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308092; c=relaxed/simple;
	bh=bK6D4moCpeozjgIFHVriu+oL/R/KzKhg76No4giueds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itTwrZp/hTKwouOrfZrDHMIi5I3Io3G8sGRSXn0Fkx1SrzOLiHqda78g1fejtCU28kIIik/QyAIVI7gNITNjDGORDWerTfR4lT4dQoVYHcH265WgE4+ARKJ3FrIaJ0eRBAS/w56WuHF9dYBpCvTDOBiZ0MfaKD/aHkNYyA3UoMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=E2lbScEr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="E2lbScEr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3LHiLpAv9mEK9G2ytcBmzGNBUCb2pydqRuAzdsB2gP4=; b=E2lbScErMzvC8afW8gh5aA1QK1
	AYXS+b5rPxKwIsar6X4wLKLqtpriTrhAOpe4ctccfQl1gY7VnqJqSV2VTHve96LsOfRH0HwODUxFa
	kYcqizQ7FHEe3ei/aIzm7XKwq20vvYNv8OBLHegScypAaGLoa6dNDmQ7DIPG3BYIw1lE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1Yce-002Ram-NM; Wed, 02 Sep 2026 02:14:36 +0200
Date: Wed, 2 Sep 2026 02:14:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v15 07/13] net: mdio: realtek-rtl9300: Configure
 hardware polling during probing
Message-ID: <78a22d1d-cb7c-4b6f-b821-ec5a5830c4ba@lunn.ch>
References: <20260831143439.2404484-1-markus.stockhausen@gmx.de>
 <20260831143439.2404484-8-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831143439.2404484-8-markus.stockhausen@gmx.de>

On Mon, Aug 31, 2026 at 04:34:33PM +0200, Markus Stockhausen wrote:
> During PHY probing and configuration complex configuration sequences
> might be issued and firmware might be loaded. Hardware polling can
> interfere badly with that. E.g. a hardware polling MMD c45 over c22
> request might break an ongoing firmware loading sequence.
> 
> To avoid such issues the polling of the Realtek Otto switches can be
> (de)activated with one or two 32 bit mask registers. Each bit enables
> (=1) or disables (=0) the polling of the corresponding port. Make use
> of this as follows:
> 
> - Disable polling for all ports when the MDIO driver starts.
> - Reenable polling just after the PHY has been attached.
> - Disable polling just before the PHY is being detached.
> 
> This synchronizes the kernel and hardware polling to some extent. It
> gracefully handles deferred probing of PHYs in case the driver is
> loaded asynchronously during boot. Additionally it brings the hardware
> polling into a consistent operation mode for devices where U-Boot does
> not take care.
> 
> Important notes about the implementation:
> 
> Realtek is very inconsistent about its register naming. RTL930x uses
> SMI_POLL_CTRL for polling control while it is SMI_PORT_POLLING_CTRL
> on RTL931x. Keep these vendor names.
> 
> These devices do not support power management for the whole system.
> So mdio_bus_phy_resume() is not used and it is not required to
> disable/enable hardware polling for that usecase.
> 
> These devices have no CPU MAC to PHY design. Thus abort phy_attach()
> in case PHYs are not mapped to valid switch ports. All MDIO bus
> commands will fail afterwards, leaving it in an unusable state.
> 
> Enabling/disabling hardware polling is a simple regmap bit access.
> For this it is enough to rely on the regmap internal lock.
> 
> This polling enabling/disabling does not solve the current inability
> of the driver to handle C45-over-C22 access during normal operation.
> For all existing designs this is not needed.
> 
> [1] https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/files-6.18/drivers/net/mdio/mdio-realtek-otto.c#L818
> [2] https://lore.kernel.org/netdev/680696024a8648535ce6dee771fe4de67802e0e8.1769053496.git.daniel@makrotopia.org/
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
