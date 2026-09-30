Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B0282F2A;
	Wed, 30 Sep 2026 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727590; cv=none; b=o40G1jOJybYX61LjxbRgZO88FCky/M/vuZ0JNfluracqt/AeKm3KA//7PuCtc4O6j264lYL1Vt0AKQ+c6lmXAMD0dF3wTwJhOqGs7peoL0Ix7LOlveH5kQVZxaMjzSyMYGmS4S0fFnwyc6DjVx7KvQNR13IpkDQS+0es17AiHEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727590; c=relaxed/simple;
	bh=BD4bpbXMi2qw3IQ8UI4qzL8VUU7IgcBVZZBnfuGRQ2M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XtVl3GhcinfAIs0shhdyDrgrrWK7IINg6EJEpnRmPzkcgJWk729z68pAWeLVWvYrFKP4CEDR+EZdpOe6nsgDTxTrafM3iubbiM8UuLneqWkR9KY1i6pS2eAnqqMgE2jC3Cq2iObgf1d6iPIGJTYK5qKTt1N5S8KAKd1UDB1LLe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeAkN9Iy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeAkN9Iy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4DB1F00893;
	Wed, 30 Sep 2026 00:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727589;
	bh=EUypl45H5PxTD0pKq0uykWNw38mhgBvscYisZO0BaNU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MeAkN9IytBtb4R+ReM9eCJsgjgO9lTBdRDBt4EmgJXnREMVXjaz9woOgpItZtgE/5
	 paL9QJ+wqma2nx/oX4EzAXbQpsLSDWGy2NlB7E7fHW1tQh3aWNnxCqHbTXNFcv3s7C
	 YE9RdmgfhClDHb9WUp3DSy5zl1s5ug1TfEVCN/uF5o4ubl+fnhh2994vvkPW+pHToa
	 qzvaJcZl0eidtgzbHYiGfAfugwWV+NYQ6Uxbav+XXPv19WX58pVT4eFjbUdqdiCERh
	 KuQ6K/lwa9ASDS/yJAKcy8Tv3KquREqBrBTzTCJbz6diqluDqxL1+fAa6jLsKzS8KN
	 6FV6Ha2FphArg==
Subject: Re: [PATCH net-next v7 5/5] net: phy: own phydev->psec via PSE
 notifier and remove fwnode_mdio hook
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corey@leavitt.info,
 jelonek.jonas@gmail.com, horms@kernel.org, olek2@wp.pl, broonie@kernel.org,
 lgirdwood@gmail.com, netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 00:19:47 +0000
Message-ID: <179072758764.434549.7951104338764700396@kernel.org>
In-Reply-To: <20260927191850.1370515-6-github@szelinsky.de>
References: <20260927191850.1370515-6-github@szelinsky.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 3 (1) · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] phy_try_attach_pse() drops -EPROBE_DEFER silently on the
  assumption that a later PSE_REGISTERED event will retry.
- [Medium] PHY registration now succeeds before the PSE controller
  exists, but fw_devlink still treats `pses` as a supplier (parse_pses…
- [Medium] PHY attach now runs synchronously from PSE_REGISTERED inside
  pse_controller_register(), which the PSE driver calls in the middle of…
- [Low] The commit message says the patch fixes user-visible problems: a
  deferred-probe retry storm, and PHYs or DSA switches that never…
- [Low] The comment above phy_try_attach_pse() says 'Any other error
  means a broken binding'.
- [Low] pd692x0_i2c_probe() registers the PSE controller even when
  fw_state is PD692X0_FW_BROKEN or PD692X0_FW_NEED_UPDATE.

Pre-existing issues:
- [High] struct pse_control stores a raw `attached_phydev` pointer and
  holds no device reference on it.
- [Medium] pse_control_get_internal() leaks a module reference.

--

net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio hook

This patch moves ownership of phydev->psec from
fwnode_mdiobus_register_phy() into phylib. The handle is attached from
phy_device_register() and from the PSE_REGISTERED notifier walk. It is
released from phy_device_remove() and from the PSE_UNREGISTERED walk.

A new pse_phy_mutex in pse_core serialises phydev->psec access in place of
rtnl, and the ethtool PSE paths take it as well.

Link: https://lore.kernel.org/netdev/20260703071025.100797-1-pabeni@redhat.com/

> diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
> index ba70915182654..7bd979b59f496 100644
> --- a/drivers/net/mdio/fwnode_mdio.c
> +++ b/drivers/net/mdio/fwnode_mdio.c

[ ... ]

> @@ -159,14 +136,6 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>  			goto clean_phy;
>  	}
>  
> -	psec = fwnode_find_pse_control(child, phy);
> -	if (IS_ERR(psec)) {
> -		rc = PTR_ERR(psec);
> -		goto unregister_phy;
> -	}
> -
> -	phy->psec = psec;
> -

[Severity: Low]
The commit message describes a user-visible deferred probe retry storm, and
there are Reported-by and Closes tags, but no Fixes: tag. The -EPROBE_DEFER
pass-through removed here came from commit 5e82147de1cb ("net: mdiobus:
search for PSE nodes by parsing PHY nodes.").

Should a Fixes: tag be added? Leaving it out may be intentional. The earlier
patches in the series suggest it targets net-next. A Fixes: tag could also
pull this patch into stable without the patches it depends on.

[ ... ]

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 5b13a74e2fa92..971d9326d2265 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1012,9 +1013,111 @@ struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
>  }
>  EXPORT_SYMBOL(get_phy_device);
>  
> +/* Best-effort attach of phydev->psec from a DT `pses = <&...>` phandle.
> + * Caller must hold pse_phy_lock(). A missing phandle (-ENOENT) or a
> + * not-yet-registered controller (-EPROBE_DEFER) is silent; the notifier
> + * retries the latter at PSE_REGISTERED time. Any other error means a broken
> + * binding and is warned about, but left non-fatal so the phy still registers.

[Severity: Low]
This isn't a bug, but is "Any other error means a broken binding" accurate?

of_pse_control_get() -> pse_control_get_internal() can also fail with:

  - -ENOMEM from the allocation
  - errors from pse_pi_is_hw_enabled() -> ops->pi_get_admin_state(), such
    as i2c failures or a firmware-unavailable code
  - regulator_get_exclusive() errors such as -EBUSY or -EPERM

The commit message itself calls these transient failures.

> + *
> + * A phy with psec_detached set is skipped: it is either not registered yet
> + * or on its way out, and nothing would release a handle attached now.
> + */
> +static void phy_try_attach_pse(struct phy_device *phydev)
> +{

[ ... ]

> +	psec = of_pse_control_get(np, phydev);
> +	if (IS_ERR(psec)) {
> +		if (PTR_ERR(psec) != -EPROBE_DEFER && PTR_ERR(psec) != -ENOENT)

[Severity: Medium]
Can a controller that is already registered still return -EPROBE_DEFER
here? The commit message says:

  -EPROBE_DEFER stays silent because the notifier retries it at
  PSE_REGISTERED time, and the preceding patch makes sure an already
  registered controller cannot keep returning it.

pse_control_get_internal() can still defer through the PI's vpwr supply:

pse_control_get_internal()
  regulator_get_exclusive()
    _regulator_get_common()
      regulator_resolve_supply()

drivers/regulator/core.c:regulator_resolve_supply() {
    ...
	if (r->dev.parent && r->dev.parent != rdev->dev.parent) {
		if (!device_is_bound(r->dev.parent)) {
			put_device(&r->dev);
			ret = -EPROBE_DEFER;
			goto out;
		}
	}
    ...
}

The preceding patch adds the pse_pi_check_supply() pre-check. That check
only calls of_regulator_get_optional(), which does not look at
device_is_bound(). That patch's message also says "a PSE probe
interleaving with the provider's own probe can still pass the check and
resolve late".

In that case PSE_REGISTERED fires, the lookup defers, and the phy is
skipped with no message. When the supply resolves later, nothing triggers
another PSE_REGISTERED or phy registration.

Would the port then stay at "No PSE is attached" for the rest of the boot?
Before this patch, deferred probe of the MDIO bus would have retried it.

> +			phydev_warn(phydev, "failed to get PSE control: %pe\n",
> +				    psec);
> +		return;
> +	}

[Severity: Low]
This isn't a regression, because the commit message documents it and the
failure is logged. There is one case where no later retry ever comes,
though.

pd692x0_i2c_probe() registers the controller while fw_state is still
PD692X0_FW_BROKEN or PD692X0_FW_NEED_UPDATE, and firmware_upload_register()
runs after that. The PSE_REGISTERED walk gets the pd692x0_fw_unavailable()
error from pi_get_admin_state() and gives up here.

After a successful firmware upload, pd692x0_fw_poll_complete() only does:

	priv->fw_state = PD692X0_FW_OK;
	return FW_UPLOAD_ERR_NONE;

Nothing re-runs the attach, so the phys stay without PSE until the PSE or
MAC driver is rebound. Is that the intended behaviour?

> +
> +	phydev->psec = psec;
> +}

[ ... ]

> +static int phy_pse_detach_one(struct device *dev, void *data)
> +{

[ ... ]

> +	phydev->psec = NULL;
> +	pse_control_put(psec);
> +	return 0;
> +}

[Severity: Medium]
Can this power down ports when a PSE driver fails later in its own probe?

The PSE_REGISTERED walk now runs synchronously inside
pse_controller_register(), partway through the PSE driver's probe. For a
PI that the hardware already has powered, pse_control_get_internal() sets
admin_state_enabled from pse_pi_is_hw_enabled(), and
regulator_get_exclusive() sets use_count to 1.

If a later probe step fails, devm unwinding calls
pse_controller_unregister(), and this walk drops the last reference:

phy_pse_detach_one()
  pse_control_put()
    __pse_control_release()
      if (psec->pcdev->pi[psec->id].admin_state_enabled)
          regulator_disable(psec->ps);
            -> pse_pi_disable() -> ops->pi_disable()

For example, tps23881_i2c_probe() calls tps23881_setup_irq() after
devm_pse_controller_register(), and that returns -EINVAL when client->irq
is 0:

	if (!irq) {
		dev_err(&client->dev, "interrupt is missing");
		return -EINVAL;
	}

pd692x0 can fail the same way in firmware_upload_register().

On a tps23881 board with no interrupt in DT, would every boot switch off
ports that were delivering power before the probe began? Before this
patch, a failed PSE probe left those ports alone. A normal unbind now also
powers down every PI attached to a phy.

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

[Severity: Medium]
This is a pre-existing issue, but does this retry make a module reference
leak in pse_control_get_internal() easier to hit?

After try_module_get(pcdev->owner) succeeds, two error paths jump past
the module_put(): the !pcdev->ops->pi_get_admin_state branch and the
pse_pi_is_hw_enabled() failure:

	ret = pse_pi_is_hw_enabled(pcdev, index);
	if (ret < 0)
		goto free_psec;

The put_module label sits above free_psec, so it is skipped.

The lookup is now best effort. It is repeated for every unattached phy on
each PSE_REGISTERED walk, and again in phy_device_register(). Each attach
that hits a failing pi_get_admin_state() (an i2c error, or a pd692x0
firmware-unavailable code) would leak one reference. The PSE driver
module could then no longer be unloaded.

Should those paths use goto put_module instead?

[ ... ]

> @@ -1034,12 +1137,25 @@ int phy_device_register(struct phy_device *phydev)

[ ... ]

> +	pse_phy_lock();
> +	phydev->psec_detached = false;
> +	phy_try_attach_pse(phydev);
> +	pse_phy_unlock();
> +
>  	return 0;

[Severity: Medium]
Could this leave the phy bound to the generic driver? Registration now
succeeds before the PSE controller exists, but fw_devlink still treats
pses as a supplier:

drivers/of/property.c:of_supplier_bindings[] {
	...
	{ .parse_prop = parse_pses, },
	...
}

With fw_devlink enforcing, device_links_check_suppliers() defers the phy's
own driver probe until the PSE device binds. If the MAC or DSA switch
connects to the phy in that window, phy_attach_direct() falls back to the
generic driver:

	if (!d->driver) {
		if (phydev->is_c45)
			d->driver = &genphy_c45_driver.mdiodrv.driver;
		else
			d->driver = &genphy_driver.mdiodrv.driver;
		phydev->is_genphy_driven = 1;
	}

device_bind_driver() -> device_links_force_bind() then binds it despite
the pending supplier link.

When the PSE module loads later, the notifier only attaches phydev->psec.
Would the phy then stay on genphy until a reboot or rebind?

Before this patch, phy registration itself deferred until the PSE
controller registered, so this window did not exist. The trigger is the
modular PSE case this patch is aimed at.

> @@ -1061,8 +1177,22 @@ EXPORT_SYMBOL(phy_device_register);

[ ... ]

> +	pse_phy_lock();
> +	psec = phydev->psec;
> +	phydev->psec = NULL;
> +	phydev->psec_detached = true;
> +	pse_control_put(psec);
> +	pse_phy_unlock();
> +
>  	device_del(&phydev->mdio.dev);

[Severity: High]
This is a pre-existing issue, but psec->attached_phydev is a raw pointer
that holds no device reference. Neither this path nor phy_pse_detach_one()
clears it.

Can pse_send_ntf_worker() still use it after the phy has been freed?

pse_send_ntf_worker()
  psec = pse_control_find_by_id(pcdev, ntf.id);
      (takes a kref, then drops pse_list_mutex)
  rtnl_lock();
      (may block)
  netdev = pse_control_get_netdev(psec);
      return psec->attached_phydev->attached_dev;

Suppose the netdev detaches the phy and the MDIO bus is torn down while
the worker waits on rtnl. This put drops the count from 2 to 1, then
device_del() and phy_device_free() free the phy_device. The worker then
reads freed memory.

There is a second route when two phys resolve the same PI id.
pse_control_get_internal() returns the existing psec with a kref_get(),
but it only sets attached_phydev when it creates a new psec. After the
first phy is removed, the surviving phy's psec still points at the freed
phy.

The worker never takes pse_phy_lock(), so the new lock does not cover
this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927191850.1370515-1-github%40szelinsky.de
