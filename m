Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1599348CD4F;
	Mon, 19 Oct 2026 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398939; cv=none; b=FrcLhgy83kHsGRJkGTvdFALAbEiUyoWqdq7gS3JJX0P8i4k3alp616OMmGGmFEu53NkNho6Vsanv4GAQ94LCAoA0DHvsSoLiaQlQ/Gix+64LwNLhVJhWh9KN4FOYzjWEcIhf3Vv2qDrwzC/qwIsaVQLxPz0B0+3XvrnK13sTMKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398939; c=relaxed/simple;
	bh=mxaw5nMtMGcXESu9aLEvR+wb7lXOxWcCS/OgbTIAoZE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FzglbtrtCz8OFHLQF+Yj+UrCEgkiI/MPLigeIbqDoKHt9E2n5xcvHg0xIx/25lvZGmCfTSbahkxueg/OCC1jX5Gl1wCUT4FDyICgo1Fk2cIMR1keAkCg6VpQvUrVkpDSk2OxD2vJE/7h/k+bB71xkJYW9omszJqZ+s5FqnWyKAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KI6rpr6r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KI6rpr6r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC07D1F000C6;
	Mon, 19 Oct 2026 08:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792398937;
	bh=dIKLkQ8AQ/8Xncx3oP1XoRFZji3UsUEliReu8NaRwPk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KI6rpr6rEGb2gABEmmJZAmOVyQwTgz2wI9ve+eVlMQp/u/zjapiiJCcX4lXXlZTds
	 sRj67TfZ1v+Ag+w5eMAqD5wgMGo3GCdE/faSFC2I0d5rTBmRY4H8ixbLnLjpePt7uy
	 SnG55kgweteIKZKIulh1VmZnldazJXuI0VehbJH1QRp2C2d7M1OIs8mpn96+Yf1ygY
	 QNcHZjduGTXtduuq0Ntv0JVLS/uYq8X7KPu5YnCLHYisQA0sSNxKGqUGiYIxPrKe+j
	 XFSEdzKRz+HZOUuv9mFoC+YVNwo6k9iOPPDUoFKGMZLI8UabWJ4MBpfp7vxQG/BPFt
	 m4+eWcv30N4SQ==
Subject: Re: [PATCH net-next 1/4] net: pse-pd: unlink the controller before
 freeing its PI data
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 broonie@kernel.org, lgirdwood@gmail.com, corey@leavitt.info,
 kyle.swenson@est.tech, horms@kernel.org, netdev-bot+sashiko@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 08:35:36 +0000
Message-ID: <179239893644.3135.4909831916521856844@kernel.org>
In-Reply-To: <20261018081853.47484-2-github@szelinsky.de>
References: <20261018081853.47484-2-github@szelinsky.de>
X-sashiko-severity: High
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

Critical: 0 · High: 3 · Medium: 0 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the PI regulators still use pcdev->pi after it
  is freed.
- [High] Incomplete fix: pse_control handles that consumers already hold
  keep using pcdev->pi, and pcdev, after unregister.
- [High] Race: ntf_work can be re-queued after cancel_work_sync(), so
  'stop the worker first' does not hold.
- [Low] Missing Fixes: tag.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  devm_pse_irq_helper() and pse_controller_unregister() disagree about…

--

net: pse-pd: unlink the controller before freeing its PI data

This commit reorders pse_controller_unregister(). The IRQ is now disabled,
the controller is taken off pse_controller_list and the notification
worker is cancelled before the PI array, the power domains and the kfifo
are freed. The goal is to stop of_pse_control_get(), pse_isr() and the
worker from reading the freed PI array.

> Signed-off-by: Carlo Szelinsky <github@szelinsky.de>

[Severity: Low]
Should this have a Fixes: tag? Before this patch,
of_pse_control_get() -> of_pse_match_pi() can read the freed pcdev->pi
while the controller is still on pse_controller_list.

pse_release_pis() was placed before list_del() by 9be9567a7c59 ("net:
pse-pd: Add support for PSE PIs"). The IRQ and worker teardown that runs
after the free came from ffef61d6d273. pse_flush_pw_ds() came from
50f8b341d268.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index a5e6d7b26b9fd..364acc0250971 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -1114,15 +1114,19 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
>   */
>  void pse_controller_unregister(struct pse_controller_dev *pcdev)
>  {
> -	pse_flush_pw_ds(pcdev);
> -	pse_release_pis(pcdev);
> +	/* Stop the IRQ, new lookups and the worker before freeing pcdev->pi. */
>  	if (pcdev->irq)
>  		disable_irq(pcdev->irq);

[Severity: Medium]
This isn't a bug introduced by this patch, but is the IRQ passed to
disable_irq() here always one the controller owns?

devm_pse_irq_helper() records the IRQ even when the request fails:

drivers/net/pse-pd/pse_core.c:devm_pse_irq_helper() {
    ...
	ret = devm_request_threaded_irq(dev, irq, NULL, pse_isr,
					IRQF_ONESHOT | irq_flags,
					irq_name, h);
	if (ret)
		dev_err(pcdev->dev, "Failed to request IRQ %d\n", irq);

	pcdev->irq = irq;
	return ret;
}

Say the request in tps23881_setup_irq() fails with -EBUSY because another
device already owns the line. tps23881 probe then fails and devres runs:

devm_pse_controller_release()
  pse_controller_unregister()
    disable_irq(pcdev->irq)

Could this leave the other device's interrupt masked, with no matching
enable_irq()?

In the normal devm flow, the IRQ is requested after the controller is
registered. Devres therefore frees it before pse_controller_unregister()
runs, and disable_irq() acts on a line that is already freed. That is
harmless for a non-shared IRQ.

Would it leave the line disabled for the other sharers if a driver passed
IRQF_SHARED?

> -	cancel_work_sync(&pcdev->ntf_work);
> -	kfifo_free(&pcdev->ntf_fifo);
> +
>  	mutex_lock(&pse_list_mutex);
>  	list_del(&pcdev->list);
>  	mutex_unlock(&pse_list_mutex);

[Severity: High]
Unlinking from pse_controller_list blocks new of_pse_control_get()
lookups. What about the pse_control handles that consumers already hold?

A PHY that got phydev->psec earlier keeps psec->pcdev and psec->id.

pse_controller_unregister() does not walk or invalidate
pcdev->pse_control_head. It also does not take pcdev->lock to keep out
operations already in progress.

pse_control_get_internal() only pins the module with try_module_get(),
and that does not prevent a sysfs unbind.

After an unbind, can an ETHTOOL_MSG_PSE_GET request still reach the freed
array through the stale handle?

pse_get_pse_attributes()
  pse_ethtool_get_status(phydev->psec, ...)
    pi = &pcdev->pi[psec->id];
    ...
    if (pi->pw_d) {
        status->pw_d_id = pi->pw_d->id;

pse_get_sw_admin_state() reads the same array.

pse_ethtool_c33_set_config(), pse_ethtool_podl_set_config(),
pse_ethtool_set_pw_limit() and pse_ethtool_set_prio() read and write
pcdev->pi[psec->id]. They also call regulator_enable() and
regulator_disable().

The final put from the PHY looks affected as well:

phy_device_remove()
  pse_control_put(phydev->psec)
    __pse_control_release()
      if (psec->pcdev->pi[psec->id].admin_state_enabled)
          regulator_disable(psec->ps);
      ...
      module_put(psec->pcdev->owner);

Once the remaining devres entries run, pcdev itself is gone too, since it
is embedded in the driver's devm-allocated private data.

This lifetime problem also exists without this patch. However, the commit
message says "Only then free the PI data", which suggests the reorder
makes the free safe.

Would a complete fix need to revoke and drain the existing controls, or
keep the PI data alive until they are released? Nothing later in the
series seems to change this.

> +
> +	cancel_work_sync(&pcdev->ntf_work);

[Severity: High]
Can ntf_work be queued again after this cancel_work_sync()?

pse_isr() is not the only producer. pse_disable_pi_pol() runs in process
context under pcdev->lock and does:

drivers/net/pse-pd/pse_core.c:pse_disable_pi_pol() {
    ...
	kfifo_in_spinlocked(&pcdev->ntf_fifo, &ntf, 1, &pcdev->ntf_fifo_lock);
	schedule_work(&pcdev->ntf_work);
    ...
}

disable_irq() does not stop this. Take a controller that uses
PSE_BUDGET_EVAL_STRAT_STATIC with software power control, such as
tps23881. There, the regulator op, which is still registered, can reach
it:

pse_pi_enable()
  _pse_pi_delivery_power_sw_pw_ctrl()
    pse_pi_allocate_pw_budget()
      pse_pi_allocate_pw_budget_static_prio()
        pse_disable_pi_prio()
          pse_disable_pi_pol()

An existing psec can also reach it, through either of these:

pse_ethtool_set_prio() -> pse_pw_d_retry_power_delivery()
  -> _pse_pi_delivery_power_sw_pw_ctrl()

_pse_pi_disable() -> pse_pw_d_retry_power_delivery()

pse_controller_unregister() never takes pcdev->lock and never waits for
these callers. Is this interleaving possible?

CPU1 (unbind)                       CPU0 (pse_pi_enable() or set-prio)
pse_controller_unregister()
  disable_irq()
  list_del()
  cancel_work_sync()
                                    mutex_lock(&pcdev->lock)
                                    ...
                                    pse_disable_pi_pol()
                                      kfifo_in_spinlocked()
                                      schedule_work(&pcdev->ntf_work)
  pse_release_pis()
  kfifo_free()

The work would then be pending on a pcdev whose pi array is freed. The
devm private data that contains pcdev is freed shortly after.

If the worker's pse_control_put() drops the last reference,
__pse_control_release() reads psec->pcdev->pi[] from freed memory.

This looks like the worker case the commit message says is fixed. Nothing
later in the series adds a dead-state check or locking here.

> +
> +	pse_flush_pw_ds(pcdev);
> +	pse_release_pis(pcdev);
> +	kfifo_free(&pcdev->ntf_fifo);

[Severity: High]
Can the PI regulators still use pcdev->pi after pse_release_pis() frees
it here?

devm_pse_pi_regulator_register() registers each PI regulator with
devm_regulator_register(pcdev->dev, ...) from inside
pse_controller_register(). devm_pse_controller_register() adds its own
devres entry only after that call returns:

drivers/net/pse-pd/pse_core.c:devm_pse_controller_register() {
    ...
	ret = pse_controller_register(pcdev);
	...
	*pcdevp = pcdev;
	devres_add(dev, pcdevp);
    ...
}

Devres releases entries in LIFO order. So on unbind or rmmod,
devm_pse_controller_release() -> pse_controller_unregister() frees
pcdev->pi first, and the regulators are unregistered after that.

In that window, any user can reach pse_pi_is_enabled() by reading the
regulator's world-readable sysfs state attribute
(state_show() -> ops->is_enabled). It reads:

	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
		ret = pcdev->pi[id].admin_state_enabled;

pse_pi_enable() and pse_pi_disable() also write
pcdev->pi[id].admin_state_enabled. That happens when a consumer holding
psec->ps calls regulator_enable() or regulator_disable().

The next patch in the series, "net: pse-pd: unwind allocations when
controller registration fails", says the regulator ops use the PI array
until devres unregisters them. Yet pse_controller_unregister() still
frees the array before that point, and nothing later in the series
changes this.

Should the free move to after the regulators are unregistered, or should
the regulators be torn down first?

>  }
>  EXPORT_SYMBOL_GPL(pse_controller_unregister);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018081853.47484-1-github%40szelinsky.de
