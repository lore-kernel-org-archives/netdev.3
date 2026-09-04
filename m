Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888A835AC24;
	Fri,  4 Sep 2026 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788482940; cv=none; b=WgKvzDKqtCoZyeL50X1nowVNZabVJywLnxrfbwDa/CpHg6dl1vYYhChQr3riS2jTooSqLvzMdoQ74gcu7vYEOqQConzwwldrN/5zrLIiH/rX3EPjHSaPKZ4xMSATDyJ9HJ05m6YIBjCbdhQ9PawmFyl06wQTMY2p/1rp+7m7920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788482940; c=relaxed/simple;
	bh=0NfL1FBn5PRUp3I7PHFGrui/+g0BRt71Xm1Aj63k5yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lusS+Ta30/7X9YC78Gw3HEAoFv8hU6IjvZIGT8rope7uMxpkT/bzNcchdF149Qd6IQargE4qfhd23ZMFCJI8pkdpSb/pXmWzg/jiXAr0bylpe8sBPf1CQG3RSFnSsOFP7wIblq7w9PstLE9EV09yZbL0fXpiRbIzr6kP8NSa3k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MT73j7U1; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MT73j7U1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MX0fU1qaIXjuWZjxnNPM585nVmSPQH32gHlipzrnk7A=; b=MT73j7U1n6pkOAi1i/uxe/9gSH
	Dc8r27Fh0Pkl7NtfWQFFEuMIoTLEPkYADD0OV2GhEGF6+CpGUyr2uR/CSGHoVpDk1NfI1LzHrUpD+
	31QxNyCP05uKiAyJxDLHskO64TcZVehS8NddaslxMMn9ozEPSx80pjcKwsoi4MusYaQE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2I6s-002pHJ-Fb; Fri, 04 Sep 2026 02:48:50 +0200
Date: Fri, 4 Sep 2026 02:48:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 3/9] net: phy: air: type the buckpbus core
 on the bus and address
Message-ID: <31659b56-3dd5-4942-a921-4fee9cea73fd@lunn.ch>
References: <20260829052546.1152446-1-f@lex.la>
 <20260829052546.1152446-4-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260829052546.1152446-4-f@lex.la>

On Sat, Aug 29, 2026 at 05:25:40AM +0000, Aleksei Sviridkin wrote:
> The buckpbus accessors only need an MDIO bus and an address, but they
> take a phy_device, which ties them to a probed PHY. An upcoming MDIO
> device driver needs the same register access before any phy_device
> exists, since it runs precisely to make the PHY presentable.
> 
> Retype the internal helpers onto (mii_bus, addr) and keep the exported
> phy_device API as page-selecting wrappers around them. The file
> already carries an mdio_device-typed accessor for the AN8811HB pbus,
> so this follows an existing direction rather than opening a new one.
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
>  drivers/net/phy/air_phy_lib.c | 85 +++++++++++++++++++----------------
>  1 file changed, 46 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/net/phy/air_phy_lib.c b/drivers/net/phy/air_phy_lib.c
> index 5141db19fa5e..e0fca5f285d2 100644
> --- a/drivers/net/phy/air_phy_lib.c
> +++ b/drivers/net/phy/air_phy_lib.c
> @@ -14,31 +14,32 @@
>  
>  #include "air_phy_lib.h"
>  
> -static int __air_buckpbus_reg_read(struct phy_device *phydev,
> +static int __air_buckpbus_reg_read(struct mii_bus *bus, int addr,
>  				   u32 pbus_address, u32 *pbus_data)
>  {
>  	int pbus_data_low, pbus_data_high;
>  	int ret;
>  
> -	ret = __phy_write(phydev, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_FIXED);
> +	ret = __mdiobus_write(bus, addr, AIR_BPBUS_MODE,
> +			      AIR_BPBUS_MODE_ADDR_FIXED);

We have mdiodev_read() and mdiodev_write:

static inline int mdiodev_read(struct mdio_device *mdiodev, u32 regnum)
{
	return mdiobus_read(mdiodev->bus, mdiodev->addr, regnum);
}

static inline int mdiodev_write(struct mdio_device *mdiodev, u32 regnum,
				u16 val)
{
	return mdiobus_write(mdiodev->bus, mdiodev->addr, regnum, val);
}

A PHY is a superset of an mdiodev....

struct phy_device {
	struct mdio_device mdio;

	/* Information about the PHY type */
	/* And management functions */
	const struct phy_driver *drv;

So it might look better to add __mdiodev_read()/__mdiodev_write(), and
have the PHY driver pass &phydev->mdio, and the firmware download
driver can directly use its mdiodev.

	Andrew
