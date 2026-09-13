Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE0B3A963B
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 06:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789282616; cv=none; b=pJBQUioTjxZFIcGEg0FhLHgN/Ucl3iUYYBIp8O6UKD8U9CHHHAVerDv5WfD6UX591OSAHfvUZAUjBk6dhGibgYB2UdJulm0t4hchgxIR8QoQQtqXWPXhLWeeDEO2Tc7zPeBLMN56c3qh3oRgc9xLUhpxPTe+KIlCi8z1XomX2Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789282616; c=relaxed/simple;
	bh=oiS2jewzdPKj/6jIPFXw8M3ztv49TOAXErEPpum1RF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nll1ZBMY1Y2EbwYUtCuCbHAc3RaK5RTR0uvay8e5sLTV26k5cCP8RhLNRQQ2tKX4buUH4w6x/rI3Frkgs//FTjDNj+V0rqJN4huQk5S3R51/ZDYfSoQo9tiZa7sgIazx+CBuL9a0VIR3Lf7dCoh5U5NDtJ7pLNOn8mthJbkSS4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B2kHd5kI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B2kHd5kI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3CF784E4049A;
	Sun, 13 Sep 2026 06:56:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E903E60435;
	Sun, 13 Sep 2026 06:56:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E880111C7AFCC;
	Sun, 13 Sep 2026 08:56:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789282607; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=b5I9g1zp8n9vjy1Bhi+svCxeKGvGM7VWX/Ux3SZ9tqg=;
	b=B2kHd5kIir+SEiNt/X3A1dJcazq2E7eNDtCsdzU/tbzBmjH2LdyQMWm6bDIZ8UCiDAMNVe
	yPzmShRxrPFt7P84VPBPoyT8HZKWM49K9cFSy1b09CkkpluFc0Km6os9bmTs1f5BS00/wt
	nsPAvHl8udEtbyIwY9RBfYR80/iGx+WULPNQRMjAnYVbz8BXfSDog98ar92dwnENQEgH7J
	Y5RsKScJyoSvHHgwdxGyrvjZ3/yRzonRyM0whyDojsHAMNQJQ/jE78RyyNgVgQp2YGeft6
	w2IvKd2SIF8LZUXtz/Y/xjraxufQy+TWCpjyaKFxVRbpbXI+fh7MkF1U/58shA==
Message-ID: <9c483965-beee-4fd6-adad-5ff1c9eae163@bootlin.com>
Date: Sun, 13 Sep 2026 08:56:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: marvell: wake the system only from the
 WoL event
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260912235125.151370-1-rosenp@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260912235125.151370-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Rosen,

On 9/13/26 01:51, Rosen Penev wrote:
> Enable waking the system from a WoL event on the 88E1318S/88E1510.
> 
> When WoL is enabled, m88e1318_set_wol() now calls enable_irq_wake()
> on the PHY's IRQ and marks the MDIO device as a wakeup source so the
> underlying GPIO interrupt raises the system from suspend, and reverses
> both on disable.
> 
> With WoL active the PHY must stay powered to detect a magic packet,
> but without masking, phy_suspend() would leave every interrupt
> enabled, so a link status change or any other PHY event would assert
> INTn and spuriously wake the system. Set PHY_ALWAYS_CALL_SUSPEND on
> the 88E1318S/88E1510 drivers so that phy_suspend() still calls their
> suspend callbacks with WoL enabled, and have those callbacks keep the
> PHY awake while writing the interrupt enable register (CSIER/IMASK)
> down to only the WoL event bit.
> 
> marvell_config_intr() rewrites the whole CSIER register with
> MII_M1011_IMASK_INIT on resume, clearing the WoL enable bit. Re-arm
> WOL_EIE in the resume callbacks so the WoL interrupt stays active for
> the next sleep cycle.
> 
> Assisted-by: LLM
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/phy/marvell.c | 145 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 138 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index f71cffa88406..70aaa09f2047 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -30,6 +30,8 @@
>  #include <linux/ethtool_netlink.h>
>  #include <linux/phy.h>
>  #include <linux/phy_port.h>
> +#include <linux/pm_wakeirq.h>
> +#include <linux/property.h>
>  #include <linux/marvell_phy.h>
>  #include <linux/bitfield.h>
>  #include <linux/of.h>
> @@ -1902,6 +1904,61 @@ static int marvell_resume(struct phy_device *phydev)
>  	return err;
>  }
>  
> +/* marvell_wol_suspend_intrs
> + *
> + * With WoL enabled the PHY has to stay powered to keep detecting a WoL
> + * packet, so instead of entering low power mode, mask all interrupt
> + * sources except the WoL event. On the 88E1318S/88E1510 the interrupt
> + * mask (MII_M1011_IMASK) is the same register as the Copper Specific
> + * Interrupt Enable Register (MII_88E1318S_PHY_CSIER), so writing only
> + * the WoL event enable bit unmask just that event.
> + */

Please tone down the verbosity of the LLM used, this explanation is
repeated in lots of introduced comments. The code is explicit enough
TBH, I don't think these comments add much value.

Same goes on all function docs added in this patch :/

> +static int marvell_wol_suspend_intrs(struct phy_device *phydev)
> +{
> +	int oldpage, ret;
> +
> +	oldpage = phy_save_page(phydev);
> +	if (oldpage < 0)
> +		return oldpage;
> +
> +	ret = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = __phy_write(phydev, MII_88E1318S_PHY_CSIER,
> +			  MII_88E1318S_PHY_CSIER_WOL_EIE);
> +out:
> +	return phy_restore_page(phydev, oldpage, ret);
> +}
> +
> +/* marvell_wol_resume_intrs
> + *
> + * marvell_config_intr() rewrites the whole MII_M1011_IMASK register
> + * (which is MII_88E1318S_PHY_CSIER) with MII_M1011_IMASK_INIT on
> + * resume, clearing the WoL event interrupt enable bit. Re-arm it if
> + * WoL is still enabled so a later WoL event keeps waking the system.
> + */
> +static int marvell_wol_resume_intrs(struct phy_device *phydev)
> +{
> +	int oldpage, ret;
> +
> +	if (!phydev->wol_enabled)
> +		return 0;
> +
> +	oldpage = phy_save_page(phydev);
> +	if (oldpage < 0)
> +		return oldpage;
> +
> +	ret = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = __phy_set_bits(phydev, MII_88E1318S_PHY_CSIER,
> +			     MII_88E1318S_PHY_CSIER_WOL_EIE);
> +out:
> +	return phy_restore_page(phydev, oldpage, ret);
> +}
> +
>  /* m88e1510_resume
>   *
>   * The 88e1510 PHY has an erratum where the phy downshift counter is not cleared
> @@ -1934,9 +1991,25 @@ static int m88e1510_resume(struct phy_device *phydev)
>  
>  		/* downshift enabled, with previous counter value */
>  		err = m88e1011_set_downshift(phydev, cnt);
> +		if (err < 0)
> +			return err;
>  	}
>  
> -	return err;
> +	return marvell_wol_resume_intrs(phydev);
> +}
> +
> +/* m88e1510_suspend
> + *
> + * If WoL is enabled the PHY receiver has to keep running to detect a
> + * magic packet, so keep it awake and unmask only the WoL event at the
> + * PHY. Otherwise suspend both the fiber and copper interfaces as usual.
> + */
> +static int m88e1510_suspend(struct phy_device *phydev)
> +{
> +	if (phydev->wol_enabled)
> +		return marvell_wol_suspend_intrs(phydev);
> +
> +	return marvell_suspend(phydev);
>  }
>  
>  static int marvell_aneg_done(struct phy_device *phydev)
> @@ -1969,8 +2042,12 @@ static void m88e1318_get_wol(struct phy_device *phydev,
>  static int m88e1318_set_wol(struct phy_device *phydev,
>  			    struct ethtool_wolinfo *wol)
>  {
> +	struct device *dev = &phydev->mdio.dev;
> +	bool wol_enable;
>  	int err = 0, oldpage;
>  
> +	wol_enable = !!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY));
> +
>  	oldpage = phy_save_page(phydev);
>  	if (oldpage < 0)
>  		goto error;
> @@ -2075,7 +2152,49 @@ static int m88e1318_set_wol(struct phy_device *phydev,
>  	}
>  
>  error:
> -	return phy_restore_page(phydev, oldpage, err);
> +	err = phy_restore_page(phydev, oldpage, err);
> +	if (err < 0)
> +		return err;
> +
> +	if (device_can_wakeup(dev) && wol_enable != device_may_wakeup(dev)) {
> +		err = device_set_wakeup_enable(dev, wol_enable);
> +		if (err < 0) {
> +			/* Roll back the PHY WoL config if the PM state update failed */
> +			struct ethtool_wolinfo wol_off = { .wolopts = 0 };
> +			int rollback_err = m88e1318_set_wol(phydev, &wol_off);
> +
> +			if (rollback_err < 0)
> +				phydev_err(phydev,
> +					   "Failed to disable WoL after wakeup enable error %d\n",
> +					   rollback_err);
> +		}
> +	}

It's unusual to recurse for error handling. If you need to run some
parts of this WoL config logic to disable WoL, put that logic in a separate
helper.

And this can be split into a dedicated patch, as this doesn't seem to be
related to the issue at stake here ?

Maxime

