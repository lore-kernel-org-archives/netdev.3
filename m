Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECB83C583A;
	Sun,  4 Oct 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129400; cv=none; b=HC5Zf+yQywYbOLHU8MG8iSB0OgKfvozZOQ5aGcoDkRuDNAAPhme3l5LaW7TgXSmanviKpDI1FrmWkQXW/Q0rLCmz0fNF0K+N/USxeyqbxzM1jiiCNYnQYLSezpV0wDN7JM7/uGtyVipUJPji3PD5KlyKtMjKoxf/mE/VHT7X07M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129400; c=relaxed/simple;
	bh=cWkxOvqOMGGOQ7435rjRkM/R2eVydcjgJWo4U7eufjw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L8sm6fvcQ2EjddwcRmE5n+Hr6voVGrqByHaMpoS/oSXROdrKT1HqLfhBymfRP4nbJfF+w8pnFi0ZytpUoDdGLfMV7GRlnKIgMVo028u6ULyEbf6dg6GIEFoY0s/ohmI5KxXMWT/ej6ZDqTBONumObJqOUMxq8iOPYILo/MfteVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOgx/ks7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOgx/ks7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA621F000FF;
	Sun,  4 Oct 2026 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791129398;
	bh=wWQJjYknhTuhuDN8nLmdKkqfWkhyF7aeU3FOiUha0NQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lOgx/ks7sELBW0sMFhnUMzsBF7Bnvq7MVhZd9ZubTXq+2BOrPHwmzMPluMb6H1W74
	 lknWKrp5ASZQ1L5e6vJlGabbPYiedR2vUMvl9S82bVRHfBP7VGMj5yK2VBPY8VdtMg
	 RLJstETDqkgDq601JCfWSs8vnfQKdywUey4vN7kz//289vgBqxpqldEqIcaVRSMYFM
	 Z37o8b8nIRGdQSojvaqQVfQTwPIYV8tSGg560ITBVMUkc1OdZeuq9Gs1iHCC9U2gw8
	 tmu89vMca78Z8/LN3R2QXoSaDsDfUzlDf8bdm8XSKdBRAYzCkP78Pap84YT9sH04NT
	 oA/h3/O3LYpRw==
Subject: Re: [PATCH net-next v19 4/6] net: dsa: mxl862xx: add devlink
 flash_update and info_get
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Sun, 04 Oct 2026 15:56:36 +0000
Message-ID: <179112939668.434549.2375428617012489937@kernel.org>
In-Reply-To: =?utf-8?q?=3C6bf133505781800d1f64ea736e72c557759bb03e=2E1791035?=
 =?utf-8?q?885=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C6bf133505781800d1f64ea736e72c557759bb03e=2E17910358?=
 =?utf-8?q?85=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
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

- [Low] In this patch, mxl862xx_devlink_flash_update() never checks that
  the host MDIO bus can do clause-22 transactions before sending the…

--

net: dsa: mxl862xx: add devlink flash_update and info_get

This patch adds devlink dev info, which reports the asic.id, asic.rev
and firmware version. It also adds devlink dev flash, which reboots the
switch into its MCUboot loader with SYS_MISC_FW_UPDATE and sends the
image over the clause-22 SB PDI SMDIO protocol. After the flash, the
driver reinitialises through a deferred re-probe.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> new file mode 100644
> index 0000000000000..eae7048707870
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c

[ ... ]

> +static int mxl862xx_flash_firmware(struct mxl862xx_priv *priv,
> +				   const struct firmware *fw,
> +				   u32 payload_size, struct devlink *dl)
> +{
> +	const u8 *payload = fw->data + MXL862XX_FW_HDR_SIZE;
> +	u32 word_idx = 0, data_written = 0, idx = 0;
> +	unsigned long next_notify = jiffies - 1;
> +	u16 word, fdata;
> +	int ret, val, i;
> +
> +	/* Step 1: reboot the firmware into MCUboot rescue mode */
> +	ret = mxl862xx_api_wrap(priv, SYS_MISC_FW_UPDATE, NULL, 0,
> +				false, false);
> +	if (ret) {
> +		dev_err(&priv->mdiodev->dev,
> +			"flash: FW_UPDATE command failed: %pe\n",
> +			ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	/* Step 2: wait for bootloader ready */
> +	mxl862xx_flash_notify(dl, "Waiting for bootloader", 0, 0);
> +	ret = mxl862xx_sb_pdi_reset(priv);
> +	if (ret < 0)
> +		goto write_err;

[Severity: Low]
What happens here if the host MDIO bus only supports clause-45?

The normal firmware command path uses only clause-45 accessors:

drivers/net/dsa/mxl862xx/mxl862xx-host.c:mxl862xx_reg_read() {
	return __mdiodev_c45_read(priv->mdiodev, MDIO_MMD_VEND1, addr);
}

So in this patch the driver can bind and run on a bus that has no
bus->read or bus->write. The SB PDI path goes through clause-22 instead:

mxl862xx_sb_pdi_reset()
  mxl862xx_smdio_write()
    __mdiobus_write()

and __mdiobus_write() does:

	if (bus->write)
		err = bus->write(bus, addr, regnum, val);
	else
		err = -EOPNOTSUPP;

On such a bus, the first SB PDI access fails with -EOPNOTSUPP. By then
SYS_MISC_FW_UPDATE has already set the sticky rescue bit and rebooted
the switch into MCUboot. MCUboot only offers the clause-22 SB PDI
window, so the driver has no way to reach the switch again.

Could the clause-22 capability be checked before the irreversible
SYS_MISC_FW_UPDATE is sent, for example in
mxl862xx_devlink_flash_update() before any ports are closed?

The next patch in the series, "net: dsa: mxl862xx: recover switch stuck
in MCUboot rescue mode", appears to make this unreachable.
mxl862xx_setup() there calls mxl862xx_rescue_mode_detect() over SMDIO
before any clause-45 access. On a clause-45-only bus that fails, setup
returns an error ("switch in an unusable state"), and the driver never
binds. So the problem only shows up when bisecting to this patch.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791035885.git.daniel%40makrotopia.org
