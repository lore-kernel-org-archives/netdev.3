Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B87B78F2B;
	Sun,  9 Aug 2026 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786313771; cv=none; b=bj53sFROEZPZF/Qa26D34920xTcZK82j6uCTjojz8am0ZURsrtmKRswupJh2uItgIJsC9XP2vhIMd0ysrSk2H1h0uq3jS2C2winPy2P7nEWmX74TK1uAuqqUQjTyOA2be1QLuy/ArooOQxMpww9W++PGLN/drhgVJky6avBlbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786313771; c=relaxed/simple;
	bh=I2Z83duViEIg4XPGQzEdz159TOf87756TjSS5gqliII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7q2wXkvIznYhJMpzUl5vF0NjPIOU4/Fmypf6AhzRuW8LkUFQpYcsN9h80a+aTRMuMK9/Ry8hyuFlrt6MnV2yDDw81/Ts9QqoysS2czFyNeHaGd7l8BkVTc0mAKoQnvhkNSG4PdYXQBQ24nldVY0tOF5BqP5cLN9nT4VIkrqtKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Fd7z7g2L; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fd7z7g2L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7k1jyJemPlKCxwerRRIhwGNrpwN1AjU8NhaVyzp/wLQ=; b=Fd7z7g2LKDj0PUZsKoOzzx9baX
	PFCb2NfEXIhhMfSRdsRVTdkeF+PyOBpvmMy2tA6gCSMzqGOp0zyUzXz4aMC325vOMVLaisXJokwOH
	GAtuDxD+qfxoPpWdhnGFU2sHJXhhtQUTdDTj2llZOwigpTfeER4T7SiwsGc/YKIG7Uvo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wtBoC-00GrMx-AK; Mon, 10 Aug 2026 00:15:56 +0200
Date: Mon, 10 Aug 2026 00:15:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v13 09/11] net: mdio: realtek-rtl9300: Add
 support for RTL838x
Message-ID: <fbc693a0-37f8-4816-a655-ab7578aada02@lunn.ch>
References: <20260807171058.522833-1-markus.stockhausen@gmx.de>
 <20260807171058.522833-10-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807171058.522833-10-markus.stockhausen@gmx.de>

On Fri, Aug 07, 2026 at 07:10:56PM +0200, Markus Stockhausen wrote:
> The MDIO driver has been prepared for multiple device support. Add all
> required bits for the RTL838x (aka maple) series. This is straightforward
> but some things are worth mentioning.
> 
> - The device has a lot in common with the RTL930x series. It has 28 ports,
>   4096 (Realtek) pages and 4 MMIO registers. With this a lot of the
>   existing RTL9300 defines could be reused. But to avoid confusion and
>   for better readability duplicate the defines with a proper prefix.
> - The MDIO engine has no fail bit. Thus the mask is set to zero.
> - There is only one SMI bus for 1G PHYs. No bus_map_base register exists.
> - The setup_controller() function needs no C45 setup but must activate
>   the PHY access.
> 
> As per the SDK the PHYs on a RTl83xx bus are mainly C22 driven. The
> polling unit works in C22 mode and the devicetree usually does not
> make use of the ethernet-phy-ieee802.3-c45 flag. Nevertheless there are
> some PHY MMD registers (e.g. EEE) that might be of interest for the
> future development of the hardware. Until that is really needed keep
> the C45 read/write helpers out of the driver.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
