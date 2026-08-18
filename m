Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA547424F;
	Tue, 18 Aug 2026 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069374; cv=none; b=YON8p3vHSVa903JAc3fcOozV5GTqhhYwz/cmSpMC9bgRZunBGf4RTL/zMzaLaCJswC45nXWjsfI5HlTkLT02AxwHLt06oBi4baXxo0Jvt2UsrsuS7B5tDCFcs0kMI9x5/y10FmQW4UV08DNbj83nPNQbD39snVjchcRpOrTvjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069374; c=relaxed/simple;
	bh=90IbsFrqq9PjhMIbRSL5Per/L0dch4TeSRtiQHnHfr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLFHNmDW39F5axJWfeKLwgfKKahvYRYCWCbPyr7vSpePTAGGCZWZc3gGfm23yfvQy6OFu7HJ5b5cdgPqzE7zWMj5FUsd3yVExS10VKH1KfpGp6L55d9shdfSI6FzBrLrd4caduG/jQF3RW0xTxfEUPigX4xkCuEtdzl0u0kmAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+gLsFdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+gLsFdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698021F000E9;
	Tue, 18 Aug 2026 16:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787069373;
	bh=1BpCwfoFKG1M1zWAN2Yo2OAev7vyhHyfh8Se75n+cnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h+gLsFdIB9dMX9nE9pzNOnDbDesDkVX/55ot9iGQsxHymx4+s5tNVGCskH5bh/EbP
	 DfMqVgTF7i4Cn2uSyDRa3Yq8HsFdK3aO1JDX1dSeDH7oncBEj53fNB5nPsjEoJ+830
	 YSEG0lyCw0PDUSovevZfcBfOX4z/hIi+MLqnadfkOeDiZ4VYULF53Au9FMC+n7EE/c
	 LRI2l6I0eoaBJwvR/tf7gwfHxC/mu47EvN2KrvVzrqMrAVpvC1wq45qFq5z0WZeYNE
	 BkBE1b0tZBeohsYR84ZQSeBcvqjmIkJq3Sj0iC/svZJk8KBs+zB3rJ1pMLJ862sRun
	 l2CQZigE0eLlg==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanqiang.luo@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	luoxuanqiang@kylinos.cn
Subject: Re: [PATCH net v2 3/5] net: phy: restore device state after probe failure
Date: Tue, 18 Aug 2026 09:09:31 -0700
Message-ID: <20260818160931.3968694-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813132946.116176-4-xuanqiang.luo@linux.dev>
References: <20260813132946.116176-4-xuanqiang.luo@linux.dev>
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
net: phy: restore device state after probe failure

phy_probe() sets phydev->drv up front and PHY_READY before calling
of_phy_leds(), but never undoes either if a later step fails. The patch
clears phydev->drv on the common error path and resets the state to
PHY_DOWN when LED setup fails.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 9c7ed9c61e6d5..c9e75bd3b81a2 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3821,6 +3821,8 @@ static int phy_probe(struct device *dev)
>  	if (!phydev->is_on_sfp_module)
>  		phy_led_triggers_unregister(phydev);
>  
> +	phydev->state = PHY_DOWN;
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but since the subject says the
device state is restored after probe failure, is the set of fields being
restored complete?

Earlier in phy_probe() a few fields that describe the hardware are
overwritten based on the matched driver:

	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;

	if (phydrv->flags & PHY_IS_INTERNAL)
		phydev->is_internal = true;

and later:

	if (!linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
			       phydev->supported))
		phydev->autoneg = 0;

None of these are undone here. phydev->irq is only ever derived from
bus->irq[addr] in phy_device_create(), and phy_attach_direct() can only
force it to PHY_POLL again:

	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;

So if a driver's probe fails after those assignments and the same phydev is
later bound again (genphy fallback in phy_attach_direct(), or another module
matching the same phy_id), does the PHY stay stuck in polling mode, keep the
is_internal flag from the failed driver, and keep autoneg disabled?

>  out_ports:
>  	phy_sfp_release(phydev);
>  	phy_cleanup_ports(phydev);
> @@ -3828,6 +3830,7 @@ static int phy_probe(struct device *dev)
>  out_reset:
>  	/* Re-assert the reset signal on error */
>  	phy_device_reset(phydev, 1);
> +	phydev->drv = NULL;

[Severity: Medium]
Can this store race with a concurrent phy_attach_direct() and produce a
NULL dereference?

At this point phydev->mdio.dev.driver is still set: really_probe() only
clears dev->driver later in device_unbind_cleanup(), after the
BUS_NOTIFY_DRIVER_NOT_BOUND notifiers, device_links_no_driver() and
devres_release_all(). Meanwhile phydev->drv is already NULL.

phy_attach_direct() decides on the genphy fallback using the other field:

	if (!d->driver) {
		...
		phydev->is_genphy_driven = 1;
	}

so in that window it skips the fallback probe (nothing repopulates
phydev->drv) and then does:

	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;

with phy_drv_supports_irq() dereferencing unconditionally:

	static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
	{
		return phydrv->config_intr && phydrv->handle_interrupt;
	}

phy_attach_direct() holds only RTNL, not device_lock() and not phydev->lock,
and phy_probe() takes no phylib lock either. Before this patch the same race
read a stale but non-NULL pointer, so it did not oops.

Related: devres-registered interfaces created by the PHY driver's own probe
(hwmon, PTP) stay live until devres_release_all(), i.e. after this store,
and the paged register helpers dereference phydev->drv unconditionally:

	drivers/net/phy/phy-core.c:__phy_read_page() {
		if (WARN_ONCE(!phydev->drv->read_page,
			      "read_page callback not available, PHY driver not loaded?\n"))
			return -EOPNOTSUPP;

		return phydev->drv->read_page(phydev);
	}

That ordering already exists in phy_remove(), but does this patch newly
extend it to the probe-failure path?

[Severity: Medium]
This is a pre-existing issue and phy_attach_direct() is not touched by this
patch, but while looking at error-path symmetry in phy_probe(): is there any
unwind for a successful phy_probe() followed by a failed
device_bind_driver()?

	drivers/net/phy/phy_device.c:phy_attach_direct() {
		if (phydev->is_genphy_driven) {
			err = d->driver->probe(d);
			if (err >= 0)
				err = device_bind_driver(d);

			if (err)
				goto error_module_put;
		}
	...
	error_module_put:
		module_put(d->driver->owner);
		phydev->is_genphy_driven = 0;
		d->driver = NULL;
	error_put_device:
		put_device(d);
	}

Since the device was never bound, the driver core never calls phy_remove(),
and this path only does module_put()/put_device(). Does that leak the
kmalloc'ed phy->led_link_trigger and phy->phy_led_triggers[] objects that
phy_led_triggers_register() published into the global LED trigger list, plus
the phy_port objects from phy_setup_ports() and any SFP upstream
registration, while drv->remove() is never called?

phydev->drv and PHY_READY are also left set for an unbound device, and a
later attach re-runs phy_probe() which overwrites phy->phy_led_triggers and
phy->led_link_trigger. Would that orphan the earlier registrations in the
global trigger list?

>  
>  	return err;
>  }
-- 
pw-bot: cr
