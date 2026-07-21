Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4670946D0A4;
	Tue, 21 Jul 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657752; cv=none; b=B9flX62b4mArISRzVYt0djK39PIvGibAcSWqErA6eXXgfT8Fh7WsR1nPhI8rdl6PxuzAet6QK8pPMU+8e944vZQ/1lEVUPKPD0QHuecaGvlNHjEEC+U0iIu+uf4FRxonUCLldHyGduvvPm/h2G4NAr22eBsAOOktjxROIUTAaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657752; c=relaxed/simple;
	bh=hEQevN26E6Z9UAnsqdJrMSAmty7HmHofAFCloe3fgqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TX1/krh7/u8CJjy/0hrUy31dP5WpEYzwheoIxQ4VBbjFGhJOYKzY32S9sZPHxs3kai5xPUtA/J0gZaURWMz1XIFhUpsPSU9FYHkGXUbaUcHh1J/tDwVnbAGO/ajpz075Q5GZuN7kLi/j/BIsY9gdZERvEJHtQ8f7VmvvxHf17uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrewB49o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrewB49o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972961F000E9;
	Tue, 21 Jul 2026 18:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784657751;
	bh=urT5y5EAJjMdGtHsau6woy6OxvKIj1WGknrNaSMwgck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JrewB49otg5/EyBZ+njwsN4OOkzcapP3um6QjlGEVneVWPocZ7lxdY9m6yT5bfnXa
	 0G5uUe0dCq3sS9jELb25NoHJeu8jBbX8vn87Q/TCAe07HrWhHCz/fRHCMHjp+3iOZL
	 ezwyc6Ar1g02RtMBaCiNxM+1cMkmZ0LVQ7dqrZNVbj04xhGbTVuqUDsZzD/+IRITjd
	 4sTr9QEeGvA1cX2u/Am0U+A8I/YtD6xKYPWvIacaLDwvWXl12kIErd/vtHR4Wk/f9s
	 wNnSsH8bGI7NLXVTP3mqHqTzuFvbc/EQ6kWysKll9qCXJbP5XcUNBSVBDqEu1+B+6S
	 QYlNB7KOhZaFg==
From: Jakub Kicinski <kuba@kernel.org>
To: markus.stockhausen@gmx.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 3/8] net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus
Date: Tue, 21 Jul 2026 11:15:49 -0700
Message-ID: <20260721181549.855625-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709064157.2865063-4-markus.stockhausen@gmx.de>
References: <20260709064157.2865063-4-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: phy: add (*notify_phy_attach/detach)() hooks to struct mii_bus

This commit adds two new function pointers to struct mii_bus,
notify_phy_attach and notify_phy_detach, invoked from phy_attach_direct()
after phy_init_hw() and from phy_detach() at entry, so MDIO bus drivers
(e.g. RealTek switch SoCs) can program PHY polling registers based on the
attached PHY type.

Link: https://github.com/openwrt/openwrt/pull/21515#discussion_r2714069716
Link: https://lore.kernel.org/netdev/cover.1769053496.git.daniel@makrotopia.org/

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 0615228459ef..676cbf183350 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1876,6 +1876,12 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
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

[Medium]
Is the pairing between notify_phy_attach and notify_phy_detach
symmetric on all failure paths?

The new attach hook is called after phy_init_hw(), and a nonzero
return jumps to the error: label:

	err = phy_init_hw(phydev);
	if (err)
		goto error;

	if (phydev->mdio.bus->notify_phy_attach) {
		err = phydev->mdio.bus->notify_phy_attach(phydev);
		if (err)
			goto error;
	}
	...
error:
	/* phy_detach() does all of the cleanup below */
	phy_detach(phydev);

Earlier failure sites in phy_attach_direct() also funnel into the same
error: label (the attached_dev EBUSY check, phy_link_topo_add_phy()
failure, and phy_init_hw() failure), all before notify_phy_attach is
ever called.

> @@ -1919,6 +1925,9 @@ void phy_detach(struct phy_device *phydev)
>  	struct module *ndev_owner = NULL;
>  	struct mii_bus *bus;
>  
> +	if (phydev->mdio.bus->notify_phy_detach)
> +		phydev->mdio.bus->notify_phy_detach(phydev);
> +
>  	if (phydev->devlink) {
>  		device_link_del(phydev->devlink);
>  		phydev->devlink = NULL;

[Medium]
Since phy_detach() invokes notify_phy_detach unconditionally at entry,
can it fire in the following two cases?

  a) An earlier step in phy_attach_direct() (EBUSY, phy_link_topo_add_phy,
     phy_init_hw) failed, so notify_phy_attach was never called, but
     phy_detach() is now called from the error: label.

  b) notify_phy_attach itself returned nonzero, so the attach was
     rejected, but phy_detach() from the error: label still calls
     notify_phy_detach.

Would a future bus driver that follows the natural allocate-on-attach /
free-on-detach pattern hit a NULL deref, double free, or refcount
underflow in these paths?

Would it be worth tracking whether notify_phy_attach ran successfully
(e.g. via a phydev flag) and only calling notify_phy_detach in that
case, so the two hooks are strictly paired?

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 199a7aaa341b..3160ca99deab 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -376,6 +376,10 @@ struct mii_bus {
>  			 int regnum, u16 val);
>  	/** @reset: Perform a reset of the bus */
>  	int (*reset)(struct mii_bus *bus);
> +	/** @notify_phy_attach: Perform post-attach handling */
> +	int (*notify_phy_attach)(struct phy_device *phydev);
> +	/** @notify_phy_detach: Perform pre-detach handling */
> +	void (*notify_phy_detach)(struct phy_device *phydev);

[Low]
Could the kernel-doc for these two callbacks spell out the contract in
more detail, since struct mii_bus is included by every MDIO bus driver?

Points that seem worth documenting:

  - The state phydev is in at call time (notify_phy_attach runs before
    phy_resume(), so the PHY is still suspended from the bus driver's
    point of view; attached_dev may be NULL for standalone PHYs).

  - Which locks (if any) are held on entry, and whether the hook may
    sleep.

  - That a nonzero return from notify_phy_attach aborts the attach and
    triggers phy_detach(), which will then also invoke
    notify_phy_detach.

  - That notify_phy_detach may be called for a phydev whose
    notify_phy_attach never ran (or returned an error), so
    implementations must tolerate that case.
-- 
pw-bot: cr
