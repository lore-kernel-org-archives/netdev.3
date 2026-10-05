Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8355013CB;
	Mon,  5 Oct 2026 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221614; cv=none; b=oCBxW8mwzB03T9ayr0ZXY8GKlY+J8Z0NO8wJpIIhzqdCA5neaDw47reFoh+lW2M0RFIHAtwqy0r7bL04ZCopW2KhwXkqDL6fjD3rAgRsS2+hfz5ujWBIwKPZFUNS3llledWomO3ppZzUDqmQRSWPuKHYOAPKUzyR8sJMZII2esY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221614; c=relaxed/simple;
	bh=6aruWoxyAJbibl4FN6h+ra/DorKDJ9wRQH8aV9KLJnQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dxImnewlvaDzdqfNrx79WUNfiLagyQzfmgrryqBue+kJG8pf5YChkKwu7XOlrxocrhxSRMF12sJ3HE0dyUMuMtIs6/jrmz8LEa8QHOiMKHdoODgd4IqFwtajMux6Vdursb/GDsGC5UND8owedPqwOyOKPlJ7DBeHQKfqqUFXVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cur1t4ru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cur1t4ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0301F000FF;
	Mon,  5 Oct 2026 17:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791221612;
	bh=rDVY53nUNptCtU+REvn7vqV+1GcKWpZt2JquImBzLZs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Cur1t4rujdbB0N2bSv1GJoE8jIWXhwXODAz8FOWuDBEhKbfnBM5FH1HJjl1bMmCL1
	 ZMUmP9e+8FSXJvke4wXfCkT6wVX93d+nMlDbtT/1y4tLL3xjWMN7YiAQnvbJFkwixz
	 HKRm5ClTe21TjbBjjGhPCJlz/b3ltZsIBinYPgfmX6oZvNviqQXNXWWSd+fYZsB6aS
	 jh7dg/YfLtEhgK6/VBL0sdRCBP5GGqEb7Ud9AZi/TpKXSMSoDjXITqnFjZhCTSokX+
	 0lLlvMBKhPga85nQYKS/c5Mlbq6VM264ReQJG2Ar+iQQcL9Y6FkGPUJJfFtESQ61WB
	 qOdy4ipTV5PaQ==
Subject: Re: [PATCH net-next v8 6/7] of: property: do not let "pses" block a
 consumer's probe
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 saravanak@kernel.org, corey@leavitt.info, jelonek.jonas@gmail.com,
 horms@kernel.org, olek2@wp.pl, broonie@kernel.org, lgirdwood@gmail.com,
 netdev-bot+sashiko@kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 17:33:31 +0000
Message-ID: <179122161108.434549.4299749280069396742@kernel.org>
In-Reply-To: <20261004164219.1161294-7-github@szelinsky.de>
References: <20261004164219.1161294-7-github@szelinsky.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit only, the full PHY driver probe and remove now
  run on every deferral of the MDIO bus owner while the PSE controller…
- [Medium] At this commit only, deferred probing can loop without end
  while the PSE controller is absent.
- [Low] At this commit the commit message describes phylib behaviour that
  does not exist yet.

--

of: property: do not let "pses" block a consumer's probe

This marks the "pses" supplier binding in of_supplier_bindings[] with
FWLINK_FLAG_IGNORE, so fw_devlink no longer creates a device link from a
PHY to its PSE controller. The goal is to stop a MAC or DSA switch from
binding genphy while the PHY's own driver is held back by that link,
once phylib gets PSE handles from a notifier.

> The link is not needed for correctness. PSE is not a resource the
> consumer must have before it probes: phylib looks a PI up when its
> controller becomes available and releases it when the controller goes
> away, and of_pse_control_get() is the only reader of the property.

[Severity: Low]
Is this description accurate at this point in the series?

At this commit, pse_register_notifier() in drivers/net/pse-pd/pse_core.c
has no callers. The only PSE consumer is still
fwnode_mdiobus_register_phy()->fwnode_find_pse_control(). It takes the
handle once, when the PHY is registered, and the handle is only released
in phy_device_remove():

drivers/net/phy/phy_device.c:phy_device_remove() {
    ...
	pse_control_put(phydev->psec);
    ...
}

The same applies to this later paragraph:

> binds. Both are given up on purpose: phylib's notifier takes the PI
> away on unbind and hands it back on bind without tearing the PHY driver
> down, and with no deferral left there is nothing for an autoprobe to
> wait for.

With only this patch applied, the managed link that passed a PSE
controller unbind on to the PHY driver is gone, and nothing replaces it.

The replacement comes in the final patch of the series, "net: phy: own
phydev->psec via PSE notifier and remove fwnode_mdio hook". That patch
adds phy_pse_notifier and removes fwnode_find_pse_control().

Could the message say that a later patch adds the notifier behaviour, so
it reads correctly for anyone who bisects or backports to this commit?

> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 72cf12907de03..5ec0f05b87ac3 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1564,7 +1564,10 @@ static const struct supplier_bindings of_supplier_bindings[] = {
>  	{ .parse_prop = parse_backlight, },
>  	{ .parse_prop = parse_panel, },
>  	{ .parse_prop = parse_msi_parent, },
> -	{ .parse_prop = parse_pses, },
> +	{
> +		.parse_prop = parse_pses,
> +		.fwlink_flags = FWLINK_FLAG_IGNORE,
> +	},

[Severity: Medium]
fwnode_mdio still does the PSE lookup at this point. Does that mean every
deferral of the MDIO bus owner now runs a full PHY driver probe and
remove, including the hardware setup done in probe?

With the link ignored, fw_devlink_create_devlink() returns early:

drivers/base/core.c:fw_devlink_create_devlink() {
    ...
	if (link->flags & FWLINK_FLAG_IGNORE)
		return 0;
    ...
}

So device_links_check_suppliers() no longer holds the PHY's probe back.

fwnode_mdiobus_register_phy() still registers the PHY before the lookup,
and PHY drivers are PROBE_FORCE_SYNCHRONOUS. While the PSE controller is
unbound, each retry therefore goes through:

fwnode_mdiobus_register_phy()
  fwnode_mdiobus_phy_device_register()
    phy_device_register()
      device_add()
        phy_probe()            <- deasserts reset, calls drv->probe
  fwnode_find_pse_control()
    of_pse_control_get()       <- returns -EPROBE_DEFER
  phy_device_remove()
    phy_remove()
      phy_device_reset(phydev, 1)

Some probe routines do real work here. For example, aqr107_probe() loads
firmware through aqr_firmware_load(), and that now happens again on every
retry until the PSE controller binds.

The commit message mentions the probe/remove cycle, but not the repeated
reset toggling or firmware loading.

The cycle goes away later in the series with "net: phy: own phydev->psec
via PSE notifier and remove fwnode_mdio hook". That patch removes
fwnode_find_pse_control() from fwnode_mdiobus_register_phy(). A bisect or
partial backport that stops at this commit would still hit the cycle.

[Severity: Medium]
Can this also make deferred probing loop forever while the PSE controller
is absent?

The PHY driver now binds inside device_add() during the MAC or DSA probe,
so driver_bound() fires a deferred probe trigger:

drivers/base/dd.c:driver_bound() {
    ...
	driver_deferred_probe_del(dev);
	driver_deferred_probe_trigger();
    ...
}

Next, the PSE lookup returns -EPROBE_DEFER, the PHY is removed, and the
MAC/DSA probe returns -EPROBE_DEFER. driver_probe_device() then sees that
a trigger happened while it was probing:

drivers/base/dd.c:driver_probe_device() {
    ...
		if (trigger_count != atomic_read(&deferred_trigger_count) &&
		    !defer_all_probes)
			driver_deferred_probe_trigger();
    ...
}

That puts the MAC straight back on the active list, and
deferred_probe_work_func() picks it up again.

The PSE controller may never register, for example if its driver is not
built, its probe fails, or one of its own suppliers is missing. In that
case of_pse_control_get() keeps returning -EPROBE_DEFER and the loop never
ends.

Before this patch, device_links_check_suppliers() deferred the PHY's
probe. driver_bound() therefore did not run, and the trigger count did
not change on these retries. That holds at least on buses where every
PHY with a driver has a pses link.

The final patch of the series, "net: phy: own phydev->psec via PSE
notifier and remove fwnode_mdio hook", removes the PSE lookup from
fwnode_mdiobus_register_phy(), and the loop goes with it.

Would it be better to apply this change after that patch, so that no
intermediate commit behaves like this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004164219.1161294-1-github%40szelinsky.de
