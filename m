Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7F6368D62;
	Wed,  2 Sep 2026 05:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327400; cv=none; b=p6ramWdVMp/ueVLnnO/rXjH/oFOc8oLsKbuQ1w3YBw4RzwQZ/LhFvdIoTOut6ofRioV90iL5q0Wd+I6eb2Y7yPPla5igNHiwrA8ZVYLm0dp80wDsOxizFMERguYD8n5mZwhQOyJWla9Y/A5lTSV19UviK3OAsWUlxzaxHds0OSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327400; c=relaxed/simple;
	bh=jZv9BvWfZt6o5tU/TnaMsZst6MrKpWoV+Xd2dTyXipE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=chTS438Rit9cTIBSolDaFTMgyBpUbnwrKJnwJQAwXYqPTcliYFDCzeP84vU6kn+JuD//s+8PWvv8Ckapt2C7cPcybVyRYsmatYUwoN8E7NzE+pEbC8pdPv6tmIAJHVFQ3skHrMs2MCnX93IO6MusAYp5X9zkW/7/ghfsGkT254A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpCuTXxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpCuTXxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7531F00A3A;
	Wed,  2 Sep 2026 05:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327399;
	bh=x2pDQ1F/3h98B9XgJrGcL2vwmSgngL3cOhtSuTq6fes=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SpCuTXxkfRiGUQOlznHKKMa2RZwzTtvpxp1Dd3nGwrW0LCsKdqhR6Huz3xRDSV1px
	 X1WmX0+uVOlVAd742XzLqFeLLdOf7zRcUB21bBoZoVgsK7nwddAc4XVYeCbvFsAekm
	 YsSlxZvAPE7A+4sMEqiYaGkIZa9go/fz479I09Og4EF70b1jbnuPTmyHCHGPgYTb16
	 PtNQ8iRwOcBTD8IMmjvazYBGJYXXM/Tl0dCqDjlb6lvpjzRaR8ccg8rwZQMFdhAADC
	 ZI0lnYd998CWCGPu5vMU7zBHaAJhnehhjSzCWpcilMboxJplHGDPZspzJw0n9nMmxh
	 fiyVR3zKmwthg==
Subject: Re: [net-next,v15,05/13] net: phy: add (*notify_phy_attach/detach)()
 hooks to struct mii_bus
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 02 Sep 2026 05:36:37 +0000
Message-ID: <178832739788.3394541.12957364785529278050@kernel.org>
In-Reply-To: <20260831143439.2404484-6-markus.stockhausen@gmx.de>
References: <20260831143439.2404484-6-markus.stockhausen@gmx.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] New struct mii_bus callbacks (notify_phy_attach /
  notify_phy_detach) and their core call sites in phy_attach_direct() /…

--

net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus

This adds two optional callbacks to struct mii_bus so an MDIO bus driver
can be told when a PHY is attached or detached. notify_phy_attach() is
invoked in phy_attach_direct() after phy_init_hw() and before
phy_resume(), and notify_phy_detach() is invoked from phy_detach() right
after phy_suspend(). phy_detach_internal() gains a notify_bus argument so
the attach error path does not emit a detach notification.

References from the commit message:
[1] https://github.com/openwrt/openwrt/pull/21515#discussion_r2714069716
[2] https://lore.kernel.org/netdev/cover.1769053496.git.daniel@makrotopia.org/
[3] https://lore.kernel.org/netdev/9e40f50b-357a-4a93-9f59-94847850835d@lunn.ch/#t

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 69b04a92b7766..41d1b20cde2c0 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1997,6 +2003,12 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  	if (err)
>  		goto error;
>  
> +	if (phydev->mdio.bus->notify_phy_attach) {
> +		err = phydev->mdio.bus->notify_phy_attach(phydev);
> +		if (err)
> +			goto error;
> +	}
> +
>  	phy_resume(phydev);

[ ... ]

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 5f8d65868e0ff..3d8afe6b7f1c5 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -376,6 +376,24 @@ struct mii_bus {
>  			 int regnum, u16 val);
>  	/** @reset: Perform a reset of the bus */
>  	int (*reset)(struct mii_bus *bus);
> +	/**
> +	 * @notify_phy_attach: Perform post-attach handling for MDIO bus
> +	 * drivers. Optional and independent of @notify_phy_detach. Called
> +	 * in phy_attach_direct() right before phy_resume(). Runs in process
> +	 * context, may sleep and may be called with RTNL held. Must not
> +	 * acquire or rely on RTNL. Returns 0 on success or negative errno
> +	 * on failure. Must unwind its own state on error as attachment is
> +	 * aborted.
> +	 */
> +	int (*notify_phy_attach)(struct phy_device *phydev);
> +	/**
> +	 * @notify_phy_detach: Perform pre-detach handling for MDIO bus
> +	 * drivers. Optional and independent of @notify_phy_attach. Called
> +	 * in phy_detach() right after phy_suspend(). Runs in process context,
> +	 * may sleep and may be called with RTNL held. Must not acquire or
> +	 * rely on RTNL.
> +	 */
> +	void (*notify_phy_detach)(struct phy_device *phydev);

[Severity: Low]
This isn't a bug, but at this commit nothing in the tree assigns
mii_bus::notify_phy_attach or mii_bus::notify_phy_detach, so both new
members and the two call sites in phy_attach_direct() and
phy_detach_internal() are inert here. Both call sites are NULL-checked, so
there is no misbehaviour.

Checking the rest of the series, the first user does arrive later:
drivers/net/mdio/mdio-realtek-rtl9300.c adds
otto_emdio_notify_phy_attach()/otto_emdio_notify_phy_detach() and wires
them up in otto_emdio_probe_one():

	bus->notify_phy_attach = otto_emdio_notify_phy_attach;
	bus->notify_phy_detach = otto_emdio_notify_phy_detach;

Would it be worth mentioning in the changelog that the first consumer of
these hooks is added by the following patch in the same series ("net: mdio:
realtek-rtl9300: Configure hardware polling during probing"), so readers of
this commit alone know the API is not left without a user?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831143439.2404484-1-markus.stockhausen%40gmx.de
