Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0862FD7D3
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 21:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694575; cv=none; b=gxDAQ4jreFowozmOl9M6jGeCl3f97vELYz0aO+Moupy3S65wjbCoYDcYKkIDEh+S/MDqr4sgrYAbtJi3IzvhwwDflb/G+ndoGhY6BUY52hQTvJfvUelRPOXdnsFf5klymOzJ3sSBQY8UdPg8sivRHV3PQt5MuZbRuZ/+Tlp9X5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694575; c=relaxed/simple;
	bh=7pAsJ/QDlGndasvP7wCdAesio4RU5dwDvWFvxbrB6Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UccqmWyh60sKGywNuH3pSpG8bec48ykysPZZGmGQcdKBvc9L5smGNp5TdKwL4ADBoS8LNJEmMTK20LluFZBhxRw+hxxai+VL4tn1yhbHSNBRWeBaTlK1O0K2weExgK0aPDbPe76n5fAr1FXafoxhv1qUTa+s9C0KQ2CYJNFBVBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXKAiFgD; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXKAiFgD"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c20e4487bdaso2051566b.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 14:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787694572; x=1788299372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZsRhb5Vm2g2QCmsjt5x4yfdYnsOXzLdvAro5VhEN6pQ=;
        b=JXKAiFgD1cMuMvO6kV6SXNDBrQNmJPvfDpkAUPSKAU9j5CJ7FSJyZRJ1gsyUqIkX59
         ZgMFJ1jgfvAWPDtK6zOJhXhqohkHUvi4CZCteLlh9FuFzdMX+ZCDPjy/v3SSaiTQiX53
         pQx0aOHvzox8l8Lt7MiLnELMmhzlV/xXVdZLHJCyaZ2y8g52S4Oi6xG2LUM+m/zI4jOF
         5LnmdewtvKjoVlTsWd+eJbQxT+d6BbMTCZmNF4OB8yUuwWj4DgkhqeVhVxuWg1xZwCtv
         94gcxhXd/Zu3SfxqBAgCzzZZdVMEzvy9oBvXP53ncSirCqj7UAmEsX5cHbMBXmVACoAl
         sa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694572; x=1788299372;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsRhb5Vm2g2QCmsjt5x4yfdYnsOXzLdvAro5VhEN6pQ=;
        b=G/bydKxXUfPyQ+j1Qqt/YVRFGfzpE3dndsTUXhPwfjYyDxVHPsSmhPw2O2qWC9oZ9y
         VTbfECfqaIfSYJ3E9al3R8b9e0qouvX760RrGgai0H0PoboQcfQoiiDlF4WtgVW8pKwU
         tIZX/XCu33HzPoJRlVwUMxSr4Ecy/PaWumr9SRnTSA9IBem9S2LQdNgHei/ODL54zBGJ
         8hdg155BmL6emuuenjfZTPPZhu3QvLrnP0k+sQsRdhlfWFDIk0oG4kGjxLVHuBOaeiDZ
         0IPax53m6RNCw7w5C7+Jmp5q5ghn+C3cFiezahw+IRpafE5cKz5iT+PDVXGZk07yf4VQ
         PX4w==
X-Forwarded-Encrypted: i=1; AHgh+RpxOBAs/TsIszAjXQeTHJPTZ/HdVSu83EWC6S2+2Io4I46NlPE2kZ6w1HGwP+K8ymwSS1I+/6c=@vger.kernel.org
X-Gm-Message-State: AFuF++nvZuTJ3UxjXY9JNlfEM0jK1I1bE4TDRjuwMeh6vZRBcet4NRtQ
	hwSk3XsarvMH/Td+IiQbiY3XCAeJkOtNXJxghYw8laBagOj2dkT0PenS
X-Gm-Gg: AR+sD10hOSF8yRs45WeH5fZvHmvlce2NSysm+t2Dj6U0nCmC/XvIcGkDtsuXKZeY+Ye
	lxMnbfCL+bV7WbsP2jJZ3zCouMmr0uA98cEo5fI38ROzfXb+8TXDMaRVAN3By9w1BTtukd37wHu
	3Wiy+1LnC4pMhs0DeJmtz/7/VNiOyGzt8KIXiIyiFCdHQUDFPG9TfMagwfWzEcfjH7Gy3L5UbP9
	d3VliHGbkMExAhy9aP/8R1Y0GWVzkp4EOw07iBJnaP74UzrXOnHtFqZsToIkpS95TJCNGaRpLCv
	8tvGIIwUlE4msjPHVNqUCAO7DEe5CpRMJqZEGMk5f69JAoC5ipCt3zEOzt18nzRTZY2LNiHIGAX
	h0NwwBNdXJHXs7ttMv7unv52Uj6E7R1vuV6hud/ITjT0L90M20YXHOyMvUWPNI5zWXsI8epR1MZ
	5OeP1J2RABacnMlJP0EBU0FtlLG78xIiOi/dZ3vMNp0TmvGsKpquw=
X-Received: by 2002:a17:906:fe01:b0:c21:960c:ec22 with SMTP id a640c23a62f3a-c250c3f111fmr111237066b.2.1787694572216;
        Tue, 25 Aug 2026 14:49:32 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d006:ef01:5f79:2b7f:f85a:e132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d62f7sm156065466b.2.2026.08.25.14.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:49:31 -0700 (PDT)
Date: Wed, 26 Aug 2026 00:49:28 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Patryk Biel <pbiel7@gmail.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net v2] net: pcs: enable autonegotiation for 10g-usxgmii
Message-ID: <20260825214928.rz52tysloa5yxq2y@skbuf>
References: <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com>

Hi,

On Mon, Aug 24, 2026 at 12:36:12PM +0200, Patryk Biel wrote:
> The Lynx PCS USXGMII setup programs the replicator advertisement, but
> does not explicitly enable and restart in-band autonegotiation or program
> the replicator link timers.
> 
> This leaves the PCS dependent on firmware or bootloader state. Systems
> which do not get the USXGMII replicator preconfigured before Linux may
> therefore fail to negotiate the link correctly.
> 
> After programming the USXGMII device ability, configure the replicator
> BMCR with reset, autonegotiation enable and autonegotiation restart. Also
> program the replicator link timer registers with the values used by the
> ENETC/Felix setup.
> 
> Signed-off-by: Patryk Biel <pbiel7@gmail.com>
> ---
> This is a follow-up to the discussion started here:
> 
> Link: https://lore.kernel.org/netdev/CA+DkFDaW_wJ5p9_P7pMpz-8iE6xeKkdF-MQcd2m2GcyVUE3S4Q@mail.gmail.com/
> 
> To summarize: on systems that don't rely on the U-Boot Felix switch
> driver to pre-configure 10G-QXGMII in-band autonegotiation, the Lynx
> PCS USXGMII code programs the replicator device ability but never
> actually enables/restarts autonegotiation nor sets up the replicator
> link timers. This leaves link establishment dependent on bootloader
> state that isn't guaranteed to exist.
> 
> This series only addresses the PCS side of the problem: it configures
> the USXGMII replicator BMCR (reset/AN enable/AN restart) and the link
> timer registers whenever lynx_pcs_config_usxgmii() is called, so that
> in-band AN comes up correctly regardless of what the bootloader did.
> 
> It intentionally does NOT yet remove the "only supports in-band AN for
> now" limitation, nor does it wire up neg_mode-based configuration to
> support the managed = "in-band-status" property being absent from the
> device tree. That part still needs more work/testing on my side (in
> particular the in-band-disable path isn't behaving as expected yet
> with the PHY I'm testing against), and I'd like to discuss the right
> approach for it separately before sending a follow-up series.
> 
> Feedback welcome, especially on whether this is an acceptable
> incremental step or whether it should be bundled together with the
> neg_mode/in-band-disable work
> ---
> Changes in v2:
> - Reorder local variable declarations in lynx_pcs_config_usxgmii().
> - Move USXGMII replicator link timer configuration before the autonegotiation restart.
> - Use phylink_get_link_timer_ns() instead of hardcoded USXGMII 
>   replicator link timer values, converting to 3.2 ns register step.
> - Link to v1: https://lore.kernel.org/r/20260820-b4-fix-pcs-lynx-an-v1-1-62d66391eaff@gmail.com
> ---
>  drivers/net/pcs/pcs-lynx.c | 47 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
> index a92081560e641ad2b297b7395cc72bf2f59ea16c..564c8a3d2b06fde92a249308f955566d6baac36f 100644
> --- a/drivers/net/pcs/pcs-lynx.c
> +++ b/drivers/net/pcs/pcs-lynx.c
> @@ -20,6 +20,9 @@
>  #define IF_MODE_SPEED_MSK		GENMASK(3, 2)
>  #define IF_MODE_HALF_DUPLEX		BIT(4)
>  
> +/* USXGMII replicator link timer step is 3.2 ns (312.5 MHz clock) */
> +#define USXGMII_LINK_TIMER_VAL(ns)	((u32)((ns) * 10 / 32))
> +
>  struct lynx_pcs {
>  	struct phylink_pcs pcs;
>  	struct mdio_device *mdio;
> @@ -156,6 +159,9 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
>  {
>  	struct mii_bus *bus = pcs->bus;
>  	int addr = pcs->addr;
> +	int link_timer_ns;
> +	u32 link_timer;
> +	int ret;
>  
>  	if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
>  		dev_err(&pcs->dev, "%s only supports in-band AN for now\n",
> @@ -164,10 +170,43 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
>  	}
>  
>  	/* Configure device ability for the USXGMII Replicator */
> -	return mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_ADVERTISE,
> -				 MDIO_USXGMII_10G | MDIO_USXGMII_LINK |
> -				 MDIO_USXGMII_FULL_DUPLEX |
> -				 ADVERTISE_SGMII | ADVERTISE_LPACK);
> +	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_ADVERTISE,
> +				MDIO_USXGMII_10G | MDIO_USXGMII_LINK |
> +				MDIO_USXGMII_FULL_DUPLEX |
> +				ADVERTISE_SGMII | ADVERTISE_LPACK);
> +	if (ret < 0) {
> +		dev_err(&pcs->dev, "could not set USXGMII replicator config\n");
> +		return ret;
> +	}
> +
> +	link_timer_ns = phylink_get_link_timer_ns(interface);
> +	if (link_timer_ns > 0) {
> +		link_timer = USXGMII_LINK_TIMER_VAL(link_timer_ns);
> +
> +		ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2,
> +					LINK_TIMER_LO, link_timer & 0xffff);
> +		if (ret < 0) {
> +			dev_err(&pcs->dev, "could not set USXGMII Link Timer 1\n");
> +			return ret;
> +		}
> +
> +		ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2,
> +					LINK_TIMER_HI, (link_timer >> 16) & 0x1f);
> +		if (ret < 0) {
> +			dev_err(&pcs->dev, "could not set USXGMII Link Timer 2\n");
> +			return ret;
> +		}
> +	}
> +
> +	/* Configure autonegotiation */
> +	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_BMCR,
> +				BMCR_RESET | BMCR_ANENABLE | BMCR_ANRESTART);
> +	if (ret < 0) {
> +		dev_err(&pcs->dev, "could not set USXGMII replicator control config\n");
> +		return ret;
> +	}
> +
> +	return ret;
>  }
>  
>  static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
> 
> ---
> base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
> change-id: 20260820-b4-fix-pcs-lynx-an-3fd1d5e94ce6
> 
> Best regards,
> -- 
> Patryk Biel <pbiel7@gmail.com>
> 
> 

There are some problems with this patch on
arch/arm64/boot/dts/freescale/fsl-ls1028a-qds-13bb.dtso (AQR412C PHY).

[   63.529426] mscc_felix 0000:00:00.5: Unsupported speed on port 0: -1
[   63.529454] mscc_felix 0000:00:00.5 swp0: Link is Up - Unknown/Unknown - flow control off

(and traffic doesn't pass)

There are multiple differences compared to U-Boot does. I haven't yet
been able to definitively determine the cause for regression. I'll debug
more tomorrow. Preliminary testing shows that any link timer values > 0.84 ms
will cause in-band autoneg to not complete with this combination.

To be clear, does your board work with this patch?
