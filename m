Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380FE3AC0E6;
	Wed,  9 Sep 2026 06:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935601; cv=none; b=rPH0z1DVku70y45fjQsMBYhkZTQnulYA5zREq/pehxSGrFti+vg2td9WaeWJ0vrwQuIn0b2wxQ53hbRKYvITqi678epb8E5uoK35ybNMjph/RhXfEkNldbIlff+8pFJYvlQtlgswucXviEaHhC5X5XBHkUm64DFObwDBXtdT+eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935601; c=relaxed/simple;
	bh=0Yp2tDXqzgKfDblVbAR/F0GvL+QCAYXcZx++Hn8W19Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i8lZh52MzJfrlMnHY50wktTQfbtN0qJNJq0F7cnR3N8vpaH3kNJaA8gjA1wjtj0j79r0N9J+l+vDKInm7i3/YLB4UJZL4Q+CJauSc4hKxjIA+a173ArK/bOOvEbfft+eFtbe0N637lZRKBE0P8X0UR7YjNN2yfVlDwKed3ddQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVMXX3DZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVMXX3DZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF17B1F00A3A;
	Wed,  9 Sep 2026 06:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935599;
	bh=WYEXltSevrTooHvRjuD7s08FKOWZImYPvvtR+MzSfm4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LVMXX3DZKF3R0r3VRIsZFroElp428FJ2BMmxwzw7b8PXSevw7q5Cet9z/D4OHk95K
	 LfnbcIAs15J3yU+NpeX2t9vRAK3ilmS8dKsA8pdn9x8+itCgZv48ngumzkFtsoONXH
	 c3TR6PQI3WigPzqrssUWh3p0gxkOjXTzzYQwJ53ad8eBE7VhEEW2IrY9CAlqOqGnLD
	 XaH1WxDw+qYMT+nHaotOH7Tfi1pyMZasj/fRFpf/MulZc4WXGj0pFr+/vNG/Tx02Ft
	 8YddKSgKycmW/RxLvchkPu1lQ5k+MsNCWg9QaHak9zDgdWc5qH4BCWxfDflcvbGPag
	 u6LEhbM1/iIdA==
Subject: Re: [PATCH net-next v6 3/5] net: phy: own phydev->psec via PSE
 notifier and remove fwnode_mdio hook
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corey@leavitt.info,
 jelonek.jonas@gmail.com, horms@kernel.org, olek2@wp.pl,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 06:33:18 +0000
Message-ID: <178893559852.219967.17408171091451392990@kernel.org>
In-Reply-To: <20260906153102.959217-4-github@szelinsky.de>
References: <20260906153102.959217-4-github@szelinsky.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 2 · Low: 2

- [High] Deferred psec put vs. bus-walk-based detach: moving the final
  pse_control_put(phydev->psec) from phy_device_remove() to…
- [High] The PSE_UNREGISTERED detach walk does not actually close the
  use-after-free class the commit claims to fix: the notifier callback…
- [Medium] pse_controller_unregister() frees the PI storage before
  quiescing the notification worker, and the new PSE_UNREGISTERED detach…
- [Medium] phy_try_attach_pse() treats every of_pse_control_get() error
  other than -ENOENT/-EPROBE_DEFER as permanent and warn-only, but that…
- [Low] The commit message claims that without the new PSE_UNREGISTERED
  detach walk "the PSE driver module could not finish unloading while…
- [Low] The patch fixes a reported, user-visible regression (boot-time
  probe-retry storm / PHYs failing to register when the PSE controller…

--

net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio hook

This moves ownership of phydev->psec from fwnode_mdio into phylib, which
now subscribes to the pse-pd notifier chain and attaches/detaches psec on
PSE controller register/unregister events. phy_device_register() is split
into a public form that takes rtnl around the attach and a
phy_device_register_locked() form for callers already holding rtnl, and
the final pse_control_put() moves from phy_device_remove() to
phy_device_release().

Closes: https://lore.kernel.org/netdev/e00048dd-1ed3-40c3-9912-59bccf015ad5@gmail.com/

A couple of questions on the changelog first.

[Severity: Low]

>       - On PSE_UNREGISTERED: an rtnl-guarded bus walk releases every
>         phydev->psec that targets the departing controller before
>         pse_release_pis() frees pcdev->pi. Without this, a phy still
>         holding a pse_control reference would cause a use-after-free in
>         __pse_control_release()'s pcdev->pi[psec->id] access, and the PSE
>         driver module could not finish unloading while any phy still held a
>         reference.

Is the module unload part of this rationale the right way round?

pse_control_get_internal() pins the controller driver for every psec:

	if (!try_module_get(pcdev->owner)) {
		ret = -ENODEV;
		goto free_psec;
	}

and the matching module_put() only happens in __pse_control_release().
While a phy holds a psec the module refcount is non-zero, so
delete_module() fails with -EWOULDBLOCK before the module exit path (and
therefore pse_controller_unregister(), the only emitter of
PSE_UNREGISTERED) is ever entered.

The detach walk does help for driver unbind and device removal, where
pse_controller_unregister() is reached with the module still loaded, but
it cannot make an rmmod that was already refused succeed. Could that
sentence be reworded to talk about unbind/removal instead?

[Severity: Low]

>     Reported-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>     Closes: https://lore.kernel.org/netdev/e00048dd-1ed3-40c3-9912-59bccf015ad5@gmail.com/

This carries Reported-by:, Closes: and Tested-by: for a user-visible
regression (PHYs failing to register / probe-retry storm with a modular
PSE controller driver), but there is no Fixes: tag and no indication of
the target tree.

git blame on the removed lookup in fwnode_mdiobus_register_phy() points at
5e82147de1cbd7 for the original PSE lookup, later touched by
fa2f0454174c2f, so the affected releases can be named. Could a Fixes: tag
be added, and could the intended tree (net vs net-next) be stated given
the size of the refactor and the new exported symbol?

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 0615228459ef4..f5febff4b00b8 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -223,8 +223,19 @@ static void phy_mdio_device_free(struct mdio_device *mdiodev)
>  
>  static void phy_device_release(struct device *dev)
>  {
> +	struct phy_device *phydev = to_phy_device(dev);
> +
> +	/* bus_for_each_dev() holds get_device() across each iteration
> +	 * step, deferring this release callback until any in-flight PSE
> +	 * notifier walk has advanced past this phy. pse_control_put()
> +	 * takes pse_list_mutex, so this path must run in sleepable
> +	 * context.
> +	 */
> +	might_sleep();
> +	pse_control_put(phydev->psec);
> +
>  	fwnode_handle_put(dev->fwnode);
> -	kfree(to_phy_device(dev));
> +	kfree(phydev);
>  }

[Severity: High]

Can a psec survive here past the point where the detach walk can find it?

Once phy_device_remove() has run, device_del() -> bus_remove_device() ->
klist_del() takes the phy off the mdio_bus_type klist, but the phy itself
can still be pinned by a get_device() from phy_attach_direct() or
of_phy_find_device(). The detach is driven only by the klist walk:

	case PSE_UNREGISTERED:
		rtnl_lock();
		bus_for_each_dev(&mdio_bus_type, NULL, data,
				 phy_pse_detach_one);

so an off-bus phy keeps its psec, while pse_controller_unregister()
continues straight on:

	blocking_notifier_call_chain(&pse_controller_notifier,
				     PSE_UNREGISTERED, pcdev);
	pse_flush_pw_ds(pcdev);
	pse_release_pis(pcdev);		/* kfree(pcdev->pi) */

When the last device reference finally drops and this release callback
runs, __pse_control_release() does:

	if (psec->pcdev->pi[psec->id].admin_state_enabled)
		regulator_disable(psec->ps);

which reads the freed pi array and may act on it.

The last patch of this series ("net: phy: release phydev->psec from
phy_device_remove() again") restores the put plus phydev->psec = NULL
under pse_phy_lock() in phy_device_remove() before device_del(), which is
the ordering that avoids this. Would it be better to keep the put in
phy_device_remove() from this patch onwards so the intermediate tree is
not left with the window open?

> @@ -1102,11 +1113,103 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
>  }
>  EXPORT_SYMBOL(get_phy_device);
>  
> -/**
> - * phy_device_register - Register the phy device on the MDIO bus
> - * @phydev: phy_device structure to be added to the MDIO bus
> +/* Best-effort attach of phydev->psec from a DT `pses = <&...>` phandle.
> + * Caller must hold rtnl. A missing phandle (-ENOENT) or a not-yet-registered
> + * controller (-EPROBE_DEFER) is silent; the notifier retries the latter at
> + * PSE_REGISTERED time. Any other error means a broken binding and is warned
> + * about, but left non-fatal so the phy still registers.
>   */
> -int phy_device_register(struct phy_device *phydev)
> +static void phy_try_attach_pse(struct phy_device *phydev)
> +{
> +	struct pse_control *psec;
> +	struct device_node *np;
> +
> +	ASSERT_RTNL();
> +
> +	np = phydev->mdio.dev.of_node;
> +	if (!np)
> +		return;
> +
> +	if (phydev->psec)
> +		return;
> +
> +	psec = of_pse_control_get(np, phydev);
> +	if (IS_ERR(psec)) {
> +		if (PTR_ERR(psec) != -EPROBE_DEFER && PTR_ERR(psec) != -ENOENT)
> +			phydev_warn(phydev, "failed to get PSE control: %pe\n",
> +				    psec);
> +		return;
> +	}
> +
> +	phydev->psec = psec;
> +}

[Severity: Medium]

Is every error other than -ENOENT and -EPROBE_DEFER really a broken
binding? of_pse_control_get() does hardware traffic on this path:

drivers/net/pse-pd/pse_core.c:pse_control_get_internal() {
	...
	ret = pse_pi_is_hw_enabled(pcdev, index);
	if (ret < 0)
		goto free_psec;
	pcdev->pi[index].admin_state_enabled = ret;
	...
	psec->ps = devm_regulator_get_exclusive(...);
}

pse_pi_is_hw_enabled() calls pcdev->ops->pi_get_admin_state(), which is an
I2C/SMBus read on tps23881, si3474 and pd692x0, so a transient -EIO,
-EBUSY or -ENOMEM is possible. Here that is only warned about, phydev->psec
stays NULL, and the only retry left is a fresh PSE_REGISTERED event.

That is aggravated by PSE_REGISTERED firing synchronously from the tail of
pse_controller_register(), i.e. mid-probe of the controller driver:

drivers/net/pse-pd/tps23881.c:tps23881_probe() {
	...
	ret = devm_pse_controller_register(dev, &priv->pcdev);
	...
	ret = tps23881_setup_irq(priv, client->irq);
}

Previously the same failure propagated out of fwnode_mdiobus_register_phy()
and deferred probe retried it. With this change, does a single transient
bus error permanently lose the PSE binding for that port, leaving the PI
without a consumer and unreachable from ethtool even though
admin_state_enabled may have been seeded from the chip?

> +
> +static int phy_pse_attach_one(struct device *dev, void *data __maybe_unused)
> +{
> +	ASSERT_RTNL();
> +
> +	if (dev->type != &mdio_bus_phy_type)
> +		return 0;
> +
> +	phy_try_attach_pse(to_phy_device(dev));
> +	return 0;
> +}
> +
> +static int phy_pse_detach_one(struct device *dev, void *data)
> +{
> +	struct pse_controller_dev *pcdev = data;
> +	struct phy_device *phydev;
> +	struct pse_control *psec;
> +
> +	ASSERT_RTNL();
> +
> +	if (dev->type != &mdio_bus_phy_type)
> +		return 0;
> +
> +	phydev = to_phy_device(dev);
> +	psec = phydev->psec;
> +	if (!psec || !pse_control_matches_pcdev(psec, pcdev))
> +		return 0;
> +
> +	phydev->psec = NULL;
> +	pse_control_put(psec);
> +	return 0;
> +}

[Severity: Medium]

Once this walk drops the phy's reference, can the notification worker end
up being the last holder of the psec?

pse_send_ntf_worker() takes its own reference and then blocks on rtnl:

	psec = pse_control_find_by_id(pcdev, ntf.id);
	rtnl_lock();
	netdev = pse_control_get_netdev(psec);
	...
	rtnl_unlock();
	pse_control_put(psec);

The detach walk runs under rtnl, so it can complete in that window and the
psec then survives only on the worker's reference. Meanwhile
pse_controller_unregister() frees the PI storage before quiescing the
worker:

	pse_release_pis(pcdev);		/* kfree(pcdev->pi) */
	if (pcdev->irq)
		disable_irq(pcdev->irq);
	cancel_work_sync(&pcdev->ntf_work);

so the worker's pse_control_put() reaches __pse_control_release() and reads
psec->pcdev->pi[psec->id].admin_state_enabled after the array is gone. The
still-enabled IRQ can also queue more notification work before
cancel_work_sync(). Should disable_irq() and cancel_work_sync() move ahead
of pse_flush_pw_ds()/pse_release_pis()?

> +
> +static int phy_pse_notifier_event(struct notifier_block *nb,
> +				  unsigned long event, void *data)
> +{
> +	switch (event) {
> +	case PSE_REGISTERED:
> +		rtnl_lock();
> +		bus_for_each_dev(&mdio_bus_type, NULL, NULL,
> +				 phy_pse_attach_one);
> +		rtnl_unlock();
> +		return NOTIFY_OK;
> +	case PSE_UNREGISTERED:
> +		rtnl_lock();
> +		bus_for_each_dev(&mdio_bus_type, NULL, data,
> +				 phy_pse_detach_one);
> +		rtnl_unlock();
> +		return NOTIFY_OK;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +}

[Severity: High]

Does the detach walk actually close the use-after-free the changelog
describes, given that rtnl is dropped before the notifier returns?

pse_controller_unregister() unlinks the controller last:

	blocking_notifier_call_chain(&pse_controller_notifier,
				     PSE_UNREGISTERED, pcdev);
	pse_flush_pw_ds(pcdev);
	pse_release_pis(pcdev);		/* kfree(pcdev->pi) */
	...
	mutex_lock(&pse_list_mutex);
	list_del(&pcdev->list);

In the window after the notifier returns and before that list_del(), a phy
registering on another CPU runs phy_device_register() ->
phy_try_attach_pse() -> of_pse_control_get(), still finds the departing
pcdev on pse_controller_list, and creates a fresh psec on it. That path
touches the already freed pi array: of_pse_match_pi() reads
pcdev->pi[i].np, and pse_control_get_internal() reads pcdev->pi[index].rdev
and writes pcdev->pi[index].admin_state_enabled = ret.

Since the attach decision is taken under rtnl but the rest of the teardown
is not, this looks like a check-then-attach race against controller
teardown. Would unlinking pcdev from pse_controller_list before the
notifier fires, or publishing a "dying" state under the same lock the
attach uses, be needed here?

> @@ -1152,8 +1299,6 @@ EXPORT_SYMBOL(phy_device_register);
>  void phy_device_remove(struct phy_device *phydev)
>  {
>  	unregister_mii_timestamper(phydev->mii_ts);
> -	pse_control_put(phydev->psec);
> -
>  	device_del(&phydev->mdio.dev);
>  
>  	/* Assert the reset signal */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906153102.959217-1-github%40szelinsky.de
