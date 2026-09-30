Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E812F1643B;
	Wed, 30 Sep 2026 00:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727586; cv=none; b=qT+YvIQACBfSYci7Dq2Qv9tAujAt/uhg92tzl4Z6O6TDq/OsGlpQzYJm1saRjRqRyCAliTgxCcxzakObjOOiLYtQ/zrYmG7w4TpUxEouPYrWpUlLqjn8rrpf2QzTGpkcYq8+F0wtUb3jX9BHj0wo3qaJJyGUUOof2RlP0Z1t2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727586; c=relaxed/simple;
	bh=YK2IrupaJk8bHNuItxnKE3scpi3GNjoXud5YvwtPtTg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jEdD/3PtJ8IQzEC9AyEWplW5aPvvGRMrYpIUUZeEEdpbMT9TC0oEtpmNNrIbZvosV1Tn4/ULLnge5Eu59zOBY7LwEd2GIDuPTi8m+uQ5AhTf59Co6kOweE4446SgZO9wgl8p1NfylJJYB+fZWR5LwgEYrLdeCFqNCXx84UhkYgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGlRmDTv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGlRmDTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8238A1F000FF;
	Wed, 30 Sep 2026 00:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727584;
	bh=mRiwsDTvkFSIUogPdhuoSeAsEjGOFaCIiAcMvtHyH40=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XGlRmDTvxc1GX+MEA3t1HV8ws9CY4eX+cU59g079kH31izRu3hlFGs4X1tiweTaRZ
	 +QVarM86govavjziIoktgYXy3nSDsKOCdPYFOV2qvecvLciDEvsj3vIHjU0CB8wzAY
	 HpZxFgYjJjXS4jPYnYVFiv4ltlWiYJqEz8acckUQAVg/b/9fTQeqZlTWG+RIlNGvZk
	 2E7BG97Ac4VRu5uM50UYmj91xZYkunp4BLW0auMsk3uNtfKKgGR37GNji5alc7r2h9
	 Meku0P2ua7It+XYSmzH29XCbYP26yMU+O+WVCogI0924LMrYbqhNuzM9pnDkNC51GE
	 Hw2HWlG/b+mqQ==
Subject: Re: [PATCH net-next v7 2/5] net: pse-pd: fire lifecycle events on
 controller register/unregister
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corey@leavitt.info,
 jelonek.jonas@gmail.com, horms@kernel.org, olek2@wp.pl, broonie@kernel.org,
 lgirdwood@gmail.com, netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 00:19:43 +0000
Message-ID: <179072758307.434549.741841617381833627@kernel.org>
In-Reply-To: <20260927191850.1370515-3-github@szelinsky.de>
References: <20260927191850.1370515-3-github@szelinsky.de>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At this commit, pse_controller_unregister() unlinks the
  controller, fires PSE_UNREGISTERED (which has no subscriber yet),…
- [Low] The patch fixes a teardown use-after-free that exists today, but
  it is presented as a feature patch.
- [Low] The new comment above disable_irq() in
  pse_controller_unregister(), and the commit message's claim that…

Pre-existing issues:
- [High] pse_controller_unregister() frees pcdev->pi (pse_release_pis()
  -> kfree) while the per-PI regulators that index that array are still…

--

net: pse-pd: fire lifecycle events on controller register/unregister

This commit fires PSE_REGISTERED and PSE_UNREGISTERED on the
pse_controller_notifier chain from pse_controller_register() and
pse_controller_unregister(). It also reorders pse_controller_unregister()
so that the IRQ is disabled and the controller unlinked first. The event
fires next, then the notification worker is drained, and pw_ds,
pcdev->pi and the kfifo are freed last.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 84c734ed4553e..56cecf60c5c4c 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -1148,15 +1151,36 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
>   */
>  void pse_controller_unregister(struct pse_controller_dev *pcdev)
>  {
> -	pse_flush_pw_ds(pcdev);
> -	pse_release_pis(pcdev);
> +	/* Stop the interrupt first: pse_isr() queues notifications and
> +	 * reaches pcdev->pi, and nothing below re-enables it.
> +	 */
>  	if (pcdev->irq)
>  		disable_irq(pcdev->irq);

[Severity: Low]
Is this comment accurate for the in-tree users of devm_pse_irq_helper()?
The same question applies to the commit message claim that "until now
pse_isr() and the worker could both reach pcdev->pi[] after
pse_release_pis() had freed it".

tps23881_i2c_probe() registers the controller before it requests the IRQ:

drivers/net/pse-pd/tps23881.c:tps23881_i2c_probe() {
    ...
	ret = devm_pse_controller_register(dev, &priv->pcdev);
    ...
	return tps23881_setup_irq(priv, client->irq);
}

The call chain tps23881_setup_irq() -> devm_pse_irq_helper() ->
devm_request_threaded_irq() therefore adds the IRQ devres after the
controller's devres.

Devres unwinds in LIFO order, so free_irq() runs first and waits for any
threaded pse_isr(). Only then does devm_pse_controller_release() call
pse_controller_unregister(). By the time this disable_irq() runs, the
line has no handler, and the call only raises the disable depth.

So devres ordering, not disable_irq(), is what keeps pse_isr() away from
the frees here. Could the comment say so, so that a later change doesn't
rely on disable_irq() as the guard?

Separately, and not introduced by this patch, devm_pse_irq_helper() sets
pcdev->irq even when devm_request_threaded_irq() fails:

	if (ret)
		dev_err(pcdev->dev, "Failed to request IRQ %d\n", irq);

	pcdev->irq = irq;
	return ret;

> -	cancel_work_sync(&pcdev->ntf_work);
> -	kfifo_free(&pcdev->ntf_fifo);
> +
> +	/* Unlink before the event: of_pse_control_get() walks
> +	 * pse_controller_list and dereferences pcdev->pi[] through
> +	 * of_pse_match_pi(), so no lookup may still reach this controller
> +	 * once its teardown starts. Subscribers are handed pcdev as the
> +	 * event data, so the notifier does not need it on the list.
> +	 */
>  	mutex_lock(&pse_list_mutex);
>  	list_del(&pcdev->list);
>  	mutex_unlock(&pse_list_mutex);

[Severity: Low]
This reorder fixes a use-after-free that already exists before this
patch. It comes under a feature subject, though, with no Fixes: or
Cc: stable tags.

Before this patch, pse_controller_unregister() called pse_release_pis()
first, which does kfree(pcdev->pi), and called list_del(&pcdev->list)
last. Meanwhile of_pse_control_get() holds pse_list_mutex, walks
pse_controller_list and reads r->pi[i].np through of_pse_match_pi():

	ret = of_pse_match_pi(r, args.np);

A PSE lookup that races a controller unbind could therefore read the
freed pcdev->pi[]. One example is a PHY registered through
fwnode_mdiobus_register_phy().

The commit message says the reordering "closes a teardown race that is
reachable today, with no subscriber involved". It points to the net
series at

  https://lore.kernel.org/netdev/20260813200653.980170-1-github@szelinsky.de/

but also says the order there "leaves the unlink below cancel_work_sync()
and pse_flush_pw_ds()".

Does that net series also close the lookup-vs-free race? If it doesn't,
should the reorder go into a separate net patch with Fixes: tags for
9be9567a7c59 ("net: pse-pd: Add support for PSE PIs") and ffef61d6d273
("net: pse-pd: Add support for reporting events")? If it does, could the
commit message say that the referenced series covers the lookup race?

> +
> +	blocking_notifier_call_chain(&pse_controller_notifier,
> +				     PSE_UNREGISTERED, pcdev);
> +
> +	/* After the event, not before. A subscriber dropping the last
> +	 * pse_control reference reaches __pse_control_release() ->
> +	 * regulator_disable() -> _pse_pi_disable(), which can end up in
> +	 * pse_disable_pi_pol() and queue a notification of its own, so a
> +	 * cancel_work_sync() placed above the walk would not stay drained.
> +	 */
> +	cancel_work_sync(&pcdev->ntf_work);

[Severity: High]
Can the work be queued again after this cancel_work_sync() at this point
in the series?

PSE_UNREGISTERED has no subscriber yet, so nothing stops the existing
pse_control holders. phydev->psec is taken in fwnode_mdio.c and only put
in phy_device_remove(), so it outlives the unregister.

The ethtool PSE paths run under rtnl only, and
pse_controller_unregister() never takes rtnl or pcdev->lock. That seems
to allow this sequence:

CPU1 (ethtool)                         CPU2 (unbind)
pse_ethtool_set_prio()
                                       pse_controller_unregister()
                                         cancel_work_sync()
  pse_pw_d_retry_power_delivery()
    pse_disable_pi_pol()
      kfifo_in_spinlocked(&pcdev->ntf_fifo, ...)
      schedule_work(&pcdev->ntf_work)
                                         pse_release_pis()
                                         kfifo_free(&pcdev->ntf_fifo)

pse_ethtool_set_prio() also reads pcdev->pi[psec->id].pw_d, and
pse_ethtool_get_status() reads pcdev->pi[] as well. A late
pse_control_put() -> __pse_control_release() reads the freed array too:

	if (psec->pcdev->pi[psec->id].admin_state_enabled)
		regulator_disable(psec->ps);

Before this patch the same stale-holder problem existed, and pi[] was
freed even earlier, so this is not a new regression. Still, the commit
message describes the worker-vs-free race as closed, and it looks
reachable at this commit.

The last patch in the series, "net: phy: own phydev->psec via PSE
notifier and remove fwnode_mdio hook", appears to resolve this. Its
PSE_UNREGISTERED handler (phy_pse_detach_one) releases every phydev->psec
under pse_phy_lock(), and the ethtool PSE paths take the same lock. With
that in place, cancel_work_sync() drains everything queued before the
walk completes.

Could this commit message say that the worker race is only fully closed
once that patch is applied?

> +
> +	pse_flush_pw_ds(pcdev);
> +	pse_release_pis(pcdev);

[Severity: High]
This is a pre-existing issue, but can the PI regulators still reach
pcdev->pi[] after it is freed here?

devm_pse_pi_regulator_register() registers the PI regulators during
pse_controller_register():

	rdev = devm_regulator_register(pcdev->dev, rdesc, &rconfig);

devm_pse_controller_register() only adds its own release after
pse_controller_register() returns:

	*pcdevp = pcdev;
	devres_add(dev, pcdevp);

Every in-tree driver passes dev == pcdev->dev. On unbind, devres
therefore runs devm_pse_controller_release() ->
pse_controller_unregister() -> pse_release_pis() -> kfree(pcdev->pi)
before the regulator devres entries unregister the PI regulators.

In that window, reading /sys/class/regulator/*/state goes through
state_show() -> _regulator_is_enabled() -> pse_pi_is_enabled():

	mutex_lock(&pcdev->lock);
	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {

This reads pcdev->pi[id].pw_d from freed memory and then dereferences
it. pcdev->lock does not exclude pse_release_pis(), and pcdev->pi is not
set to NULL on this path.

The commit message says the frees "end up last". That is true inside
pse_controller_unregister(), but not across the full devres teardown.

The next patch in the series, "net: pse-pd: unwind allocations when
controller registration fails", acknowledges this read of freed memory
but does not fix it.

> +	kfifo_free(&pcdev->ntf_fifo);
>  }
>  EXPORT_SYMBOL_GPL(pse_controller_unregister);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927191850.1370515-1-github%40szelinsky.de
