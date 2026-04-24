Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956B3CEB9F
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777034187; cv=none; b=VeLyfSlZUz0ntmVLMuSP/kHtNC3mRjUpHkVI6fgF5EOterYDdAPiaBxUoMkxSfxFZNZ/Ue+oN/YlXuZvSLEwzWSVXtZuN/PEtpUA6MUylUe950mXpniwURTx5fIAXWJTmmrImMcB5bUqlk5IhagjxqHj2Cb12D0Rd835ZkYGdTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777034187; c=relaxed/simple;
	bh=gxWumiCJCpeXt9x50ql7v5zeB8+ofgYmO/9NRVvuUI4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSKQnwOHMpXIDXLWiMjwWzrDyJPa573w2i4VwaAxOg3r98K/4jH083we12nZiaZlPWbbKylaeLeOq8/57zHCNIsr2MxIpFaxdjvjtkQB8youW3otTC5PUpFBLwH9NL8rjKkHMK+AdlCKUraJl0EavUHEmlg0EDo/DXKDn+sGHFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R5NKlaaB; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R5NKlaaB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1F2F71A33F8;
	Fri, 24 Apr 2026 12:36:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E04B3604EB;
	Fri, 24 Apr 2026 12:36:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AF4A91072080A;
	Fri, 24 Apr 2026 14:36:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777034182; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=l/Z7RaBfk4abnuZIMA2JBc8wyVjjcleD84iRjwCiDZ0=;
	b=R5NKlaaB9SQtMd/C7N9zedU+KBASICGSlRLBmGUPW+n1G2rBAtrSsKjCQ9CzTkKdnz15ub
	3engU3+2FY2wZe408AsJKPlzmKW6bJdougmej8oAMc6UFRd7oTLJ2meNatO91nKse/OGOX
	VsEOMhdjqbVZpy3+W2++Y1tZVBGqDVYMD/n+9ocePYO1EyjIKTfCsxl/4QNQVfHONzhGy2
	9YILOpYou4Z3qvDuhn/uW6mLzEgK3/STs72C0DCP7cn++6CRIckRkcLUhDJVTbhRDe0xpF
	D/62Nz5uVvEuP5PLByZn5LpMsehwp2tK9Pt20i8zQFtENZ9uc0nejXo4gRXdFg==
Date: Fri, 24 Apr 2026 14:36:16 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Corey Leavitt via B4 Relay <devnull+corey.leavitt.info@kernel.org>
Cc: corey@leavitt.info, Oleksij Rempel <o.rempel@pengutronix.de>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 4/4] net: phy: own phydev->psec via PSE
 notifier and remove fwnode_mdio hook
Message-ID: <20260424143616.54d747a8@kmaincent-XPS-13-7390>
In-Reply-To: <20260423-pse-notifier-decouple-v1-4-86ed750a9d62@leavitt.info>
References: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
	<20260423-pse-notifier-decouple-v1-4-86ed750a9d62@leavitt.info>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 23 Apr 2026 01:42:17 -0600
Corey Leavitt via B4 Relay <devnull+corey.leavitt.info@kernel.org> wrote:

> From: Corey Leavitt <corey@leavitt.info>
>=20
> Transfer ownership of phydev->psec from fwnode_mdio to the phy
> subsystem itself. The phy subsystem now subscribes to the pse-pd
> notifier chain and manages psec attach/detach in response to PSE
> controller lifecycle events, while fwnode_mdio loses its PSE
> awareness entirely.
>=20
> Split phy_device_register() into a public entry point that takes
> rtnl_lock() and a phy_device_register_locked() variant that assumes
> rtnl is already held. Callers that already hold rtnl (the SFP
> module state machine via __sfp_sm_event) use the _locked form to
> avoid deadlock; all other callers use the unchanged public API.
> This pair mirrors the register_netdevice() / register_netdev()
> split convention already established in the core networking stack.
> rtnl must span the full registration sequence through device_add(),
> not just phy_try_attach_pse(): a PSE_REGISTERED event firing between
> a narrow attach lock and device_add() would walk mdio_bus_type, find
> the phy not yet on the bus, and leave it permanently unattached.
>=20
> With rtnl held across the full registration sequence:
>=20
>   - At phy_device_register_locked(), phy_try_attach_pse() attempts
>     an of_pse_control_get() for phys whose DT pses phandle resolves
>     now. If the controller is already registered, psec is attached
>     before device_add() makes the phy visible on mdio_bus_type.
>     If the controller is not yet registered, the swallow-error path
>     leaves psec NULL and relies on the subsequent notifier event.
>=20
>   - On PSE_REGISTERED: an rtnl-guarded bus walk retries the attach
>     for every registered phy whose psec is still NULL. This is the
>     "phy was enumerated before the PSE controller loaded" case,
>     which is the root cause of the boot-time probe-retry storm on
>     systems with a modular PSE controller driver. Because the
>     pse_controller_notifier is fired synchronously, a concurrent
>     pse_controller_register() either (a) completes list_add and
>     releases pse_list_mutex before this function takes rtnl, in
>     which case phy_try_attach_pse() finds the controller in the
>     list and attaches; or (b) fires its notifier during this
>     function, in which case the callback blocks on rtnl until this
>     function returns, then walks the bus and finds the phy fully
>     registered (attaching if psec is still NULL).
>=20
>   - On PSE_UNREGISTERED: an rtnl-guarded bus walk releases every
>     phydev->psec that targets the departing controller before
>     pse_release_pis() frees pcdev->pi. Without this, a phy still
>     holding a pse_control reference would cause a use-after-free
>     in __pse_control_release's pcdev->pi[psec->id] access, and the
>     PSE driver module could not finish unloading while any phy
>     still held a reference via module_put().
>=20
> Introduce phy_try_attach_pse() as the rtnl-guarded helper used by
> both the register path and the notifier walk. Holding rtnl across
> of_pse_control_get() is safe because pse_list_mutex is never held
> in the opposite order.
>=20
> Expose pse_control_matches_pcdev() as a predicate so subscribers
> can identify which of their held pse_control references target a
> given controller, without leaking the struct pse_controller_dev *
> out of pse_control opacity.
>=20
> Move the final pse_control_put() of phydev->psec from
> phy_device_remove() to phy_device_release(). The kobject release
> callback runs only after every reference on the device has been
> dropped, including the bus iterator references taken by
> bus_for_each_dev() in the notifier walk, which means by the time
> release fires no concurrent reader or writer of phydev->psec can
> exist. The mdio_bus_type klist is set up in bus_register() with
> klist_devices_get() / klist_devices_put() (drivers/base/bus.c),
> which bracket each iteration step with get_device() / put_device()
> on the underlying struct device; that reference defers the release
> callback from firing until the walk has advanced past this phy.
> Keeping phy_device_remove() unchanged avoids introducing a new
> locking contract on its many callers (sfp, fixed_phy, xgbe, hns,
> netsec, bcm_sf2, mdiobus_unregister).
>=20
> Finally, delete fwnode_find_pse_control() and its call site in
> fwnode_mdiobus_register_phy(), and drop the PSE header from
> fwnode_mdio.c. This removes the probe-time -EPROBE_DEFER coupling
> between mdio and pse-pd that caused the boot-hang regression on
> systems with a modular PSE controller driver and a DT phy with a
> pses phandle: the MDIO/DSA probe no longer sees any PSE-originated
> -EPROBE_DEFER, so the probe-retry storm is gone. fwnode_mdio is
> now PSE-agnostic.
>=20
> Fixes: fa2f0454174c ("net: pse-pd: Introduce attached_phydev to pse contr=
ol")

This patch depends on the other patches (2 and 3) which do not have any fix=
es
tag. So either all of them have the fixes tag or none of them have it.

Except from this, your design seems a great idea!
The only thing that puzzle me is to have the RTNLOCK hold in the
phy_device_register function. This is an important change but I am not a ne=
tdev
sufficient expert to know if that could break things.
Jakub, Russell what do you think?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
