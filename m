Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF65B494A10;
	Thu,  1 Oct 2026 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790857267; cv=none; b=nEbJIEJzVtp4abRdacE1J5Swanan2/4rwRM97KO3CDURgZk7O1SWjRqwX53gHOoQ0uVuo0Akonw/nxzke9U5zwUlLwqrbLQel+G0bUI9ledNpKEi0eWLdBvXudGTp3A45H0SMJvvXmZMlCAB6L+DC/hCj+FkcVx+GoVwFtWE4os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790857267; c=relaxed/simple;
	bh=VnqBlR8aQErsJp+68ga18nZBKpa+tlAFSjSc+hIcAPo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M+01yqTTeMSArSs5mI1caz/KqaDsx8aZJXdDc8rzqpvsE+olNTeV0OAnGpL+a1TPozV3idOT7mI7QRv4UMAQaO+Rbuix3QIVfrr6ak/YznY/BFwEE7xEb4vmmdPS2JAK9Tp2yl1ljulbLBzUDFBJFgqhhpTo76nUWarmjOjIgRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3b578wM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3b578wM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD711F00898;
	Thu,  1 Oct 2026 12:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790857265;
	bh=S+iGV3zlyxybtoEyH66OUvED/IvoG6h1BK3dsOLdOoU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=S3b578wM5wfbZ+5LOUf57MLw7GQ2kNtiQQJlUxeCK52ndL2chJtl9rXn+1ZYDXkHj
	 d3fQKaoa1CyE5qInmwuQTfz1JSqtlAbsUhvs6LkmdQQwa4M3NKnJRpO+JwDQc1WxUM
	 hJSXIaGSeZyo+x3T22SM5+VBC6o7fo1ouVDYYXRAnEuGbaLDhJfV+rUWl1yKg+qPQ4
	 IxtUTHYRGNXt8q+/UNMKrRK0FsLayODDQirIJNZNMj3ihyvmES+z4it7lH71P3SX05
	 gI+rIjIEI8iBhjeO1FEpPxCZcBTB09KofwzdlKbPJ8mFdjETGUzScoyk/BTxY8TZ3F
	 XJ/FkUrMD1hpA==
Subject: Re: [PATCH net-next v1 1/1] net: phy: realtek: add MDI-X support for
 RTL8365MB-VC
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: linusw@kernel.org, luizluca@gmail.com, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 alvin.sipraga@analog.com
Date: Thu, 01 Oct 2026 12:21:04 +0000
Message-ID: <179085726415.434549.9532496066289384267@kernel.org>
In-Reply-To: <20260929092007.1184843-1-o.rempel@pengutronix.de>
References: <20260929092007.1184843-1-o.rempel@pengutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Changing MDI/MDI-X on a port that is forced to 10 or 100 Mb/s
  does not restart the link, so the new setting is not applied.

--

net: phy: realtek: add MDI-X support for RTL8365MB-VC

This commit adds config_aneg and read_status hooks for the RTL8365MB-VC
internal PHY. They let the MDI/MDI-X crossover mode be forced through a
chip-specific control register and report the resolved MDI-X state to
ethtool.

> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 3b3352e2cdc6a..e14960192e791 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c

[ ... ]

> @@ -3058,6 +3068,74 @@ static irqreturn_t rtl8221b_handle_interrupt(struct phy_device *phydev)
>  	return IRQ_HANDLED;
>  }
>  
> +static int rtl8365mb_config_mdix(struct phy_device *phydev)
> +{

[ ... ]

> +	return phy_modify_changed(phydev, RTL8365MB_VC_PHYCR1,
> +				  RTL8365MB_VC_PHYCR1_MDIX_FORCE |
> +				  RTL8365MB_VC_PHYCR1_MDI, val);
> +}
> +
> +static int rtl8365mb_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = rtl8365mb_config_mdix(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* The pair assignment is only evaluated while the link is brought up,
> +	 * so renegotiate if the crossover configuration changed.
> +	 */
> +	return __genphy_config_aneg(phydev, ret);

[Severity: Medium]
Does this renegotiate when the port is forced to 10 or 100 Mb/s?

When autoneg is disabled and the speed is below SPEED_1000,
__genphy_config_aneg() returns early and drops the changed argument:

drivers/net/phy/phy_device.c:__genphy_config_aneg() {
    ...
	} else if (phydev->speed < SPEED_1000) {
		return genphy_setup_forced(phydev);
	} else {
    ...
	return genphy_check_and_restart_aneg(phydev, changed);
}

genphy_setup_forced() only calls phy_modify() on MII_BMCR. If speed and
duplex are unchanged, __mdiobus_modify_changed() skips the write. Nothing
then restarts the link: there is no ANRESTART, no soft reset and no power
cycle.

For example, take a link that is up at a forced 100/full:

  ethtool -s <dev> autoneg off speed 100 duplex full
  ethtool -s <dev> mdix on

This goes through:

phy_ethtool_ksettings_set()->phy_start_aneg()->rtl8365mb_config_aneg()->
    __genphy_config_aneg()->genphy_setup_forced()

PHYCR1 bits 9:8 get updated. According to the comment above, though, the
pair assignment is not re-evaluated until the link drops for some other
reason. This part depends on the hardware behaviour that comment describes.

In the meantime, rtl8365mb_read_status() reads the new mode back from
PHYCR1 and reports it as mdix_ctrl. That no longer matches the pair
assignment actually in use.

The eth_tp_mdix_ctrl description in include/uapi/linux/ethtool.h says:
"When written successfully, the link should be renegotiated if necessary."

Would it help to handle the forced case the way marvell.c does? That
driver calls genphy_soft_reset() when "phydev->autoneg != AUTONEG_ENABLE ||
changed".

> +}
> +
> +static int rtl8365mb_read_status(struct phy_device *phydev)
> +{

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929092007.1184843-1-o.rempel%40pengutronix.de
