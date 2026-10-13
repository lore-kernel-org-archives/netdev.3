Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62057339389;
	Tue, 13 Oct 2026 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853711; cv=none; b=l7A8cIZiKlEd2Kabry6Z//lo4bf3OoZcpxsOITlPl8P3MKSCxrIZVMkeJz4VsweUQvYpkznZJ3ZLqOnlwT5wjMkbI8BC+J7k4CNHDflPdUGmP0p7YtQKUZxKMFIu5WU9JLeL+Bl/9dZ7jG7H3olNn2P6TEso+G5nLIs1Mz6oNvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853711; c=relaxed/simple;
	bh=XN4FQ38iSN2N7cJATCv+jXxvOlcBNpfQApRQ2xz/Cr0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jQctfyQ4zGqdldyygssF3ODv+ZPspv+YTDPhLSC76ExaE0SEV/xQqny/FKBbIGsKbCiUQSZVkLkrrluSw6L5XCLPc36v3FqE4Yzi7rliB7/ySs0V51jdXPAB4XJfXIGbLp3paXDyTgdpscY2v3CmPasskaaRgmuDovudpPGgzGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTWIBXkh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTWIBXkh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870C91F008A1;
	Tue, 13 Oct 2026 01:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791853710;
	bh=zM0/TWOF2qkzkvQYZM+50sKgOzvwb8gNblpbCl5iaNI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZTWIBXkhaKegUtN2XFlgZ0DYGHvAMifzXr/MicY4dTtcMIpEsVMGL4GOlUhIzhxZQ
	 03FXjyWYa1y14Ci4YoGDiL6jzjCsjJ90mRm82DUJhNcdZQNZKxkn37l+OdoBbVvxFw
	 uw11o5QosYCfReQo66rF9So5qnJLfqdvbmrU0Kpky2lx9WHDDMiCd3iJnsAibJ6G5Q
	 w7t7Nc1RChE6Qh41dLLS16X5CPr/KdttFFvSBtn/bTqGj7FrqsIf71pgrh9De3oIob
	 2agK1R3nYkLNTLAFpcnUjstqzeZRhiWsTyEIQqxrRfN5jk023bRM3MRmTyin3g2i0y
	 xIMom7AsFmJbQ==
Subject: Re: [PATCH net-next v4 4/9] net: dsa: realtek: rtl8365mb: set RGMII
 mode for family D
From: netdev-bot+sashiko@kernel.org
To: namiltd@yahoo.com
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, luizluca@gmail.com, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 01:08:29 +0000
Message-ID: <179185370913.434549.1834502511257239861@kernel.org>
In-Reply-To: <a79f1f46-625a-4aaf-931c-65737f8552fa@yahoo.com>
References: <a79f1f46-625a-4aaf-931c-65737f8552fa@yahoo.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] On family D, rtl8365mb_ext_config_rgmii()
  (drivers/net/dsa/realtek/rtl8365mb_main.c) reads TOP_CON0 for extint…

--

net: dsa: realtek: rtl8365mb: set RGMII mode for family D

For family D chips using RGMII on extension interface 1, this patch
clears the EXT1 RGMII TX clock delay field in EXT_TXC_DLY. If MAC4 is
not occupying extension 1, it also binds the RGMII/MII pins to MAC7 in
TOP_CON0. SerDes 1, which shares the pins, is always disabled.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
> index 2dabc4da861f4..996ba2e39302c 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c

[ ... ]

> @@ -1270,6 +1291,35 @@ static int rtl8365mb_ext_config_rgmii(struct realtek_priv *priv, int port,
>  	if (ret)
>  		return ret;
>  
> +	if (rtl8365mb_get_family(priv) == RTL8365MB_FAMILY_D &&
> +	    extint->id == 1) {
> +		ret = regmap_update_bits(priv->map,
> +					 RTL8365MB_D_REG_EXT_TXC_DLY,
> +					 RTL8365MB_D_EXT1_RGMII_TX_DLY_MASK, 0);
> +		if (ret)
> +			return ret;
> +		/* Configure RGMII/MII mux to port 7 if UTP_PORT4 is not in
> +		 * RGMII mode
> +		 */
> +		ret = regmap_read(priv->map, RTL8365MB_D_REG_TOP_CON0, &data);
> +		if (ret)
> +			return ret;
> +		if ((data & RTL8365MB_D_MAC4_SEL_EXT1_MASK) == 0) {
> +			ret = regmap_update_bits(priv->map,
> +						 RTL8365MB_D_REG_TOP_CON0,
> +						 RTL8365MB_D_MAC7_SEL_EXT1_MASK,
> +						 RTL8365MB_D_MAC7_SEL_EXT1_MASK);
> +			if (ret)
> +				return ret;
> +		}

[Severity: Low]
What happens in rtl8365mb_ext_config_rgmii() when strap or EEPROM has
already set RTL8365MB_D_MAC4_SEL_EXT1_MASK in TOP_CON0? In that case MAC4
owns the EXT1 pins, so MAC7_SEL_EXT1 is not set. The function still runs
the SDS1_MISC0 write below and returns 0.

By the time this check runs, these EXT1 registers have already been
changed for port 7:

    RTL8365MB_EXT_RGMXF_REG(extint->id) TX/RX delays from port 7's DT
    RTL8365MB_DIGITAL_INTERFACE_SELECT_REG(extint->id) set to RGMII
    RTL8365MB_D_REG_EXT_TXC_DLY bits [5:3] cleared

If the pins belong to MAC4, could these writes change the RGMII timing
that the MAC4 path depends on?

The only caller, rtl8365mb_phylink_mac_config(), logs a message only on a
non-zero return:

    ret = rtl8365mb_ext_config_rgmii(priv, port, state->interface);
    if (ret)
        dev_err(priv->dev,
            "failed to configure RGMII mode on port %d: %pe\n",
            port, ERR_PTR(ret));

So when the DT describes port 7 as RGMII but the strap gives EXT1 to
MAC4, port 7 appears to be configured but carries no traffic, and
nothing is logged.

Since the code already detects this state, would it be better to return
an error such as -EBUSY before touching the shared EXT1 registers, or at
least print a warning?

> +		ret = regmap_update_bits(priv->map,
> +					 RTL8365MB_D_REG_SDS1_MISC0,
> +					 RTL8365MB_D_SDS_MISC_MODE_FIELD_MASK,
> +					 RTL8365MB_D_PORT_SDS_MODE_DISABLE);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/38872e6f-1264-4a93-9f81-8212173e909d%40yahoo.com
