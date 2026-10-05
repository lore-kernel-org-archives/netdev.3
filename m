Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607F5038FE;
	Mon,  5 Oct 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221616; cv=none; b=oEZbP8zzh1w4hhorXZmR7iY4mFgasyWnRfu9TxnsZf9B8emRgDquk3/rUaofeshOnjx/E1AAor7kCIIcOQWOW68m3AQ0NEaikKabVq5Ji9SZQzyDu6ziMbbOWyDLaWdv4JeO/cQW3N5q4eEiiwWoZT9aX9374pO8Iuzph+K/0Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221616; c=relaxed/simple;
	bh=2oGbf7x2Whw7rfp8sLsBTksCIRx08bfMHwCwxIQyDcE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RcEo2wUYFrEdR3Vfe8EuhKe1bDjRLTQXsqkMFTrKjZ8ALaSmweegDSTHQiafWBtGPUaC3eXVq/iDyH+AZ6CICvYr6pm5llwPmsjKYKfspzSziwzYCwG7rQ5AZRkCt1nIBOc7nOTACoNdVol0493gIBQe5zZwfTy0Hw9D8vt2aFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glBCt1GQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glBCt1GQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280DC1F00898;
	Mon,  5 Oct 2026 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791221614;
	bh=Zo6OosAOp++XGKHJ+z6voKimvySKQBhp/73wphdmxYU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=glBCt1GQe8DEfkEGALuob+Qobdw+0x8wqUN2zBRng15ImeG6Zq5V2sAtTewvKVe1M
	 Qp/ZCfno2uORxCE2Z+JVZUsBXyafmfo89dnUfbO0Ua7lxLmkUgaAHaFDWmhEE5FJpY
	 DNu7utDuFlC6rNWbn57B3hvWpvLbOytmmwQm38MNRQbkqNyQSXxyynrR+MvGHkAziY
	 XViLWO4Cgg1izm6s2nYywmQ8K/GJK1HxWRLobYCWBwuf7eN/bt/wAb2VfXKNtLQNuv
	 Rud72DWJHWH60tUPEcRihufE5V8U4rH1ksAiggAm3ogqA06M8HnwnGj32xLVbW85Od
	 x8FM1qEcJZgWA==
Subject: Re: [PATCH net-next v8 7/7] net: phy: own phydev->psec via PSE
 notifier and remove fwnode_mdio hook
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 saravanak@kernel.org, corey@leavitt.info, jelonek.jonas@gmail.com,
 horms@kernel.org, olek2@wp.pl, broonie@kernel.org, lgirdwood@gmail.com,
 netdev-bot+sashiko@kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 17:33:32 +0000
Message-ID: <179122161274.434549.2931247814591983963@kernel.org>
In-Reply-To: <20261004164219.1161294-8-github@szelinsky.de>
References: <20261004164219.1161294-8-github@szelinsky.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] pse_control_get_internal() leaks a reference on the PSE
  controller module whenever pse_pi_is_hw_enabled() fails.
- [Medium] phy_try_attach_pse() drops -EPROBE_DEFER silently and relies
  on a later PSE_REGISTERED event to retry.
- [Medium] The PSE_REGISTERED walk now attaches PHY handles from inside
  pse_controller_register(), partway through the PSE driver's probe.
- [Low] The commit fixes two reported, user-visible problems, both
  recorded with Reported-by/Closes: the deferred-probe storm in which…

Pre-existing issues:
- [High] Use-after-free of phy_device in the PSE notification worker.
- [High] This problem wasn't introduced by this patch, but
  pse_controller_unregister() still frees pcdev->pi (pse_release_pis()…

--

net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio hook

This patch takes the pses phandle lookup out of
fwnode_mdiobus_register_phy() and gives ownership of phydev->psec to
phylib. Handles are now attached and released from the PSE controller
lifecycle notifier and from phy_device_register()/phy_device_remove(),
serialised by a new pse_phy_lock() mutex in pse_core. The goal is to stop
the -EPROBE_DEFER retry storm seen with modular PSE controller drivers.

Link: https://lore.kernel.org/netdev/20260703071025.100797-1-pabeni@redhat.com/

> Reported-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> Closes: https://lore.kernel.org/netdev/e00048dd-1ed3-40c3-9912-59bccf015ad5@gmail.com/
> Reported-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> Closes: https://lore.kernel.org/netdev/bac5e6e9-7358-4ccb-87fc-9c40baa33682@wp.pl/

[Severity: Low]
Should this have a Fixes: tag? Both Closes: reports describe the deferred
probe storm. That storm comes from the register-then-remove-on-defer code
in fwnode_mdiobus_register_phy(), which was added by commit fa2f0454174c
("net: pse-pd: Introduce attached_phydev to pse control"). The
phy->psec = psec assignment itself goes back to 5e82147de1cb.

This fix also depends on earlier patches in the series:

  net: pse-pd: add notifier chain for controller lifecycle events
  net: pse-pd: fire lifecycle events on controller register/unregister
  net: pse-pd: check the PI vpwr supply before registering the controller
  of: property: do not let "pses" block a consumer's probe

None of them has a Fixes or stable marker either, so backporters have no
sign that the series must be taken together. If this is meant for
net-next only, could the commit message say so?

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 5b13a74e2fa92..497cf179398bd 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1012,9 +1013,116 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)

[ ... ]

> +static void phy_try_attach_pse(struct phy_device *phydev)
> +{
> +	struct pse_control *psec;
> +	struct device_node *np;
> +
> +	pse_phy_lock_assert_held();
> +
> +	np = phydev->mdio.dev.of_node;
> +	if (!np)
> +		return;
> +
> +	if (phydev->psec || phydev->psec_detached)
> +		return;
> +
> +	psec = of_pse_control_get(np, phydev);
> +	if (IS_ERR(psec)) {
> +		if (PTR_ERR(psec) != -EPROBE_DEFER && PTR_ERR(psec) != -ENOENT)
> +			phydev_warn(phydev, "failed to get PSE control: %pe\n",
> +				    psec);
> +		return;
> +	}

[Severity: Medium]
Can this retry leak a reference on the PSE controller module? When
pse_pi_is_hw_enabled() fails, pse_control_get_internal() jumps past
module_put():

drivers/net/pse-pd/pse_core.c:pse_control_get_internal() {
	...
	if (!try_module_get(pcdev->owner)) {
		ret = -ENODEV;
		goto free_psec;
	}

	if (!pcdev->ops->pi_get_admin_state) {
		ret = -EOPNOTSUPP;
		goto free_psec;
	}
	...
	ret = pse_pi_is_hw_enabled(pcdev, index);
	if (ret < 0)
		goto free_psec;
	...
put_module:
	module_put(pcdev->owner);
free_psec:
	kfree(psec);
	...
}

The missing module_put() is older than this patch. What changes here is
that the error only produces a warning and phydev->psec stays NULL. The
same phy is then tried again on every phy_device_register() and, through
phy_pse_attach_one(), on every PSE_REGISTERED walk, including walks for
unrelated controllers. Each attempt leaks another module reference.

pd692x0 hits this every time. It registers the controller even when its
firmware is broken or needs an update, and pd692x0_pi_get_admin_state()
then returns an error from pd692x0_fw_unavailable(). Bus errors on
tps23881, si3474 or realtek-pse-mcu would have the same effect.

Should the pi_get_admin_state check and the pse_pi_is_hw_enabled() error
path jump to put_module instead?

[Severity: Medium]
Does a later PSE_REGISTERED event really retry every -EPROBE_DEFER? A
controller that is already registered and matched can still return it:

pse_control_get_internal()
  regulator_get_exclusive()
    _regulator_get_common()
      regulator_resolve_supply()
        if (!device_is_bound(r->dev.parent)) {
            ...
            ret = -EPROBE_DEFER;

This happens when the vpwr provider has registered its regulator but has
not finished binding. pse_pi_check_supply() uses
of_regulator_get_optional(), which does not check binding, so the
controller registers anyway.

When the provider finishes binding, nothing calls phy_try_attach_pse()
again. The port then reports "No PSE is attached" until another PSE
controller registers or the phy is re-registered.

Before this patch, the same -EPROBE_DEFER came back out of
fwnode_mdiobus_register_phy(), and the MAC/DSA probe recovered once the
provider was bound. The commit message mentions this case. Is there a way
to retry it, for example when the supply becomes available?

> +
> +	phydev->psec = psec;
> +}

[ ... ]

> +static int phy_pse_notifier_event(struct notifier_block *nb,
> +				  unsigned long event, void *data)
> +{
> +	switch (event) {
> +	case PSE_REGISTERED:
> +		pse_phy_lock();
> +		bus_for_each_dev(&mdio_bus_type, NULL, NULL,
> +				 phy_pse_attach_one);
> +		pse_phy_unlock();
> +		return NOTIFY_OK;
> +	case PSE_UNREGISTERED:
> +		pse_phy_lock();
> +		bus_for_each_dev(&mdio_bus_type, NULL, data,
> +				 phy_pse_detach_one);
> +		pse_phy_unlock();
> +		return NOTIFY_OK;

[Severity: Medium]
Can a failed PSE driver probe now power down a port that was already
live? The PSE_REGISTERED walk runs synchronously inside
pse_controller_register(), so it attaches handles before the PSE driver's
probe has finished. For a PI the hardware already reports as powered,
pse_control_get_internal() sets pcdev->pi[index].admin_state_enabled.

The probe can still fail after registration. One example is
tps23881_i2c_probe():

	ret = devm_pse_controller_register(dev, &priv->pcdev);
	...
	return tps23881_setup_irq(priv, client->irq);

Another is firmware_upload_register() in pd692x0. In that case devres runs
pse_controller_unregister(), the PSE_UNREGISTERED walk drops the last
reference, and __pse_control_release() does:

	if (psec->pcdev->pi[psec->id].admin_state_enabled)
		regulator_disable(psec->ps);

That reaches ops->pi_disable() and cuts PoE power on the port. Before this
patch, a failed PSE probe did not power down a port this way.

The commit message documents this behaviour. Could handles be attached
only after the PSE driver's probe has completed?

> +	default:
> +		return NOTIFY_DONE;
> +	}
> +}

[ ... ]

> @@ -1061,8 +1182,22 @@ EXPORT_SYMBOL(phy_device_register);
>   */
>  void phy_device_remove(struct phy_device *phydev)
>  {
> +	struct pse_control *psec;
> +
>  	unregister_mii_timestamper(phydev->mii_ts);
> -	pse_control_put(phydev->psec);
> +

[ ... ]

> +	pse_phy_lock();
> +	psec = phydev->psec;
> +	phydev->psec = NULL;
> +	phydev->psec_detached = true;
> +	pse_control_put(psec);
> +	pse_phy_unlock();
>  
>  	device_del(&phydev->mdio.dev);

[Severity: High]
This isn't a bug introduced by this patch, but the new pse_phy_lock()
scheme does not cover psec->attached_phydev. Can pse_send_ntf_worker()
read a freed phy_device here?

The worker holds only a transient kref and rtnl:

pse_send_ntf_worker()
  psec = pse_control_find_by_id(pcdev, ntf.id);
  rtnl_lock();
  netdev = pse_control_get_netdev(psec);
    return psec->attached_phydev->attached_dev;

phy_device_remove() can run at the same time outside rtnl, for example
from mdiobus_unregister() in a MAC's remove after unregister_netdev().
The pse_control_put() above is then not the final put, because the worker
still holds a reference. psec survives with attached_phydev still pointing
at this phy, and device_del() followed by phy_device_free() frees the
phydev while the worker can still dereference it.

Nothing clears psec->attached_phydev when the owning phy drops its
reference. Also, when two phys share a PI, pse_control_get_internal()
returns the existing psec through kref_get() and leaves attached_phydev
unchanged.

[ ... ]

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index e560833ad0340..bfa025e2194bb 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -1345,6 +1392,13 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev)
>  	 */
>  	cancel_work_sync(&pcdev->ntf_work);
>  
> +	/* Every handle should be gone here: subscribers drop theirs in the
> +	 * event above, and the worker's transient one goes with the drain.
> +	 * The controller is off the list and the irq is off, so nothing can
> +	 * add one. Anything left is a holder nobody accounted for.
> +	 */
> +	WARN_ON(!list_empty(&pcdev->pse_control_head));
> +
>  	pse_flush_pw_ds(pcdev);
>  	pse_release_pis(pcdev);
>  	kfifo_free(&pcdev->ntf_fifo);

[Severity: High]
This is a pre-existing issue, but pse_release_pis() still frees pcdev->pi
here while the PI regulators that index it are registered. Can a read of
a PI regulator's state attribute touch the freed array?

devm_pse_pi_regulator_register() calls devm_regulator_register(pcdev->dev,
...) from inside pse_controller_register(). devm_pse_controller_register()
adds its own devres after that. Because devres releases in reverse order,
devm_pse_controller_release() runs and frees pcdev->pi before the
regulators are unregistered.

During that window, reading /sys/class/regulator/*/state for one of these
PIs reaches:

pse_pi_is_enabled()
	...
	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {

That reads pw_d and admin_state_enabled from freed memory. The earlier
series patch "net: pse-pd: unwind allocations when controller
registration fails" mentions this read of freed memory but does not fix
it. The new PSE_UNREGISTERED walk and WARN_ON clean up the control
handles, but the PI array still does not outlive the regulators.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004164219.1161294-1-github%40szelinsky.de
