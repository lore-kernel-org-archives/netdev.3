Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CBE4FDE50;
	Mon,  5 Oct 2026 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221609; cv=none; b=no0g6vOWduUteOfFy76LWtibJKlHT6tqGe26eOnZllbltTlJ6KsimWk0ZCgqyGBDzhtwPR9HhYMRyVeDMRj+EfuhBSqdNyspiyJDwae//IIYCw8XtuO1TNwV3bovElGlX1vGlCN6/pHHUyjg5VwurcyIN+9ZugcCG5+ddJuqWJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221609; c=relaxed/simple;
	bh=C5GBE9LT0wraAd+40KpHweMTUSk++Rlxtm3cLO9AWr4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FDCrjfl/RQAxSdyN+p4ubkzxHv35H/5PRV5aPwVWrRISuQ4N5Ut2ARGKHZsbfzqajKHCWAANRcz1Kxgezm0IUS16aemjiOz7j6CLbbngdaKe8NSLdTbTn2sTztVp1wbEjBNk18mpZtZT+UBuCYLBziryhpuHyUmfmza3w+Pr0I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT/vnSdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT/vnSdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020121F0089C;
	Mon,  5 Oct 2026 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791221607;
	bh=SgQpRfizg/ctZLrqeO9sbgprIheTSC5BeKia/T2ByJk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oT/vnSdVkcGoGkIsW/B/0uS1HTm2YouW0onsVnh3i2r2MvfipvKEk5RU1uZg55FQ/
	 jymoQWO4MAIBa2bdm2dY4DIxeVLsLkM8haJpLNwZ2GJ+NIDKNblvZxwKN8xlvL7IxA
	 gl9+ToW+KNOKLmLZAPxKu08m5Q6j6VQIjfeOcBm8Iqh5ndZmS9a8d7yDDa1miXe9mU
	 oMjVrN7Wx2/n9WGGUSru5j9fbJWRKMFlmzTITCrjl6Ry7Q0Ap+7JbuKj3QZ86wt0Ca
	 8Y9eOe1f6exySODEwpbLvqnjWeYfyFTdB0r1zYLE5sem0oqR/Z3cCxqBcYITK9ZdpU
	 V3oM1M4yDYSCQ==
Subject: Re: [PATCH net-next v8 2/7] net: pse-pd: fire lifecycle events on
 controller register/unregister
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 saravanak@kernel.org, corey@leavitt.info, jelonek.jonas@gmail.com,
 horms@kernel.org, olek2@wp.pl, broonie@kernel.org, lgirdwood@gmail.com,
 netdev-bot+sashiko@kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 17:33:25 +0000
Message-ID: <179122160553.434549.16806647504780466154@kernel.org>
In-Reply-To: <20261004164219.1161294-3-github@szelinsky.de>
References: <20261004164219.1161294-3-github@szelinsky.de>
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

Critical: 0 · High: 1 (2) · Medium: 1 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Work can be re-queued after cancel_work_sync() by pse_control
  holders that do not subscribe (baseline decision: discarded, fixed…
- [Medium] A port could be powered on inside PSE_UNREGISTERED while the
  irq is masked (baseline decision: discarded).
- [Low] Fixes: tag missing for the teardown race fixed by the reorder
  (baseline decision: discarded).

Pre-existing issues:
- [High] Shared PSE power domain is freed by devres while other
  controllers still use it (pre-existing).
- [High] Stale pse_control handles reach freed pcdev->pi and pcdev after
  unbind (pre-existing, baseline decision: discarded, fixed later in the…
- [Medium] disable_irq() without a matching enable on a line the PSE core
  may not own (pre-existing, baseline decision: discarded).
- [Medium] pse_controller_register() leaks memory on its error paths
  (pre-existing, baseline decision: discarded).

--

net: pse-pd: fire lifecycle events on controller register/unregister

This patch hooks up the pse_controller_notifier chain.
pse_controller_register() now fires PSE_REGISTERED once the controller is
on pse_controller_list, and pse_controller_unregister() fires
PSE_UNREGISTERED after the controller has been unlinked. It also reorders
pse_controller_unregister(): the irq is disabled and the controller is
unlinked before the event, and cancel_work_sync() and the frees move
after it.

> No subscriber exists yet, so the event itself does nothing. The
> reordering of pse_controller_unregister() around it is not a no-op,
> though: it closes a teardown race that is reachable today, with no
> subscriber involved.

[Severity: Low]
The race described here is real. In the baseline, pse_release_pis() frees
pcdev->pi while the controller is still on pse_controller_list. That lets
of_pse_control_get()->of_pse_match_pi() read the freed pcdev->pi[i].np.

The notes say a separate net series reorders the same function as a
standalone fix. That looks like the right place for a Fixes: tag, because
this commit depends on the notifier from "net: pse-pd: add notifier chain
for controller lifecycle events".

Once the net fix lands, will this paragraph be out of date? Could the
message refer to the net fix instead of saying that this commit closes
the race?

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 84c734ed4553e..dc261beb61702 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -1138,6 +1138,9 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  	list_add(&pcdev->list, &pse_controller_list);
>  	mutex_unlock(&pse_list_mutex);
>  
> +	blocking_notifier_call_chain(&pse_controller_notifier,
> +				     PSE_REGISTERED, pcdev);
> +
>  	return 0;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but the error paths in
pse_controller_register() leak memory. Every failure after this call
returns without kfifo_free():

	ret = kfifo_alloc(&pcdev->ntf_fifo, pcdev->nr_lines, GFP_KERNEL);

Failures after of_load_pse_pis() also leak pcdev->pi and its of_node
references. A partial pse_register_pw_ds() leaks pw_d krefs and supplies.

The next patch in the series, "net: pse-pd: unwind allocations when
controller registration fails", adds the free_kfifo and release_pis
labels. It also calls pse_flush_pw_ds() when pse_register_pw_ds() fails.
It still leaks the PI array on purpose once PI regulators exist.

kfifo_alloc() is sized from pcdev->nr_lines before the nr_lines = 1
default is applied. No in-tree driver registers with nr_lines below 2.
Should the kfifo be sized after that default is set?

> @@ -1148,15 +1151,41 @@ EXPORT_SYMBOL_GPL(pse_controller_register);
>   */
>  void pse_controller_unregister(struct pse_controller_dev *pcdev)
>  {
> -	pse_flush_pw_ds(pcdev);
> -	pse_release_pis(pcdev);
> +	/* Raise the interrupt's disable depth before anything is freed.
> +	 * pse_isr() queues notifications and reaches pcdev->pi, and nothing
> +	 * below re-enables it. For a driver that requests its irq after
> +	 * devm_pse_controller_register(), devres has already run free_irq()
> +	 * by the time we get here and this only bumps the depth - the
> +	 * ordering does not rely on that, so a driver requesting the irq
> +	 * earlier is covered too.
> +	 */
>  	if (pcdev->irq)
>  		disable_irq(pcdev->irq);

[Severity: Medium]
This is a pre-existing issue, but can this disable_irq() mask an
interrupt line that the PSE core never owned?

devm_pse_irq_helper() records the irq even when the request fails:

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

Suppose tps23881's request fails with -EBUSY because another device holds
the line exclusively. Probe then unwinds through
devm_pse_controller_release(), and this disable_irq() masks the other
device's interrupt. Nothing re-enables it afterwards.

The new comment is correct for the in-tree success case. tps23881 passes
irq_flags = 0, devres has already run free_irq(), and the next request
goes through irq_startup(), which resets the depth to 0.

>  
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
> +
> +	blocking_notifier_call_chain(&pse_controller_notifier,
> +				     PSE_UNREGISTERED, pcdev);

[Severity: Medium]
With disable_irq() now running before the event, can a port be powered on
from inside the PSE_UNREGISTERED walk?

A subscriber's final put can follow this path for a pending PI on the
same power domain:

__pse_control_release()
  regulator_disable()
    _pse_pi_disable()
      pse_pw_d_retry_power_delivery()
        ops->pi_enable()

That decision uses an isr_pd_detected value that can no longer change,
because the irq is already masked.

The commit message says this is intended ("so the call is legal"). In
the final series the power-on also looks brief. A PI can only be pending
after pse_pi_enable() on the exclusive psec->ps consumer, so it always
has a holder. The same walk releases every PHY holder through
__pse_control_release()->regulator_disable()->pse_pi_disable(), and that
clears admin_state_enabled.

Leaving a port powered on for good would need a pending PI with no
holder. Only an earlier failed ops->pi_disable() could produce that. Is
that case worth handling, or is the brief power-on acceptable here?

> +
> +	/* After the event, not before. A subscriber dropping the last
> +	 * pse_control reference reaches __pse_control_release() ->
> +	 * regulator_disable() -> _pse_pi_disable(), which can end up in
> +	 * pse_disable_pi_pol() and queue a notification of its own, so a
> +	 * cancel_work_sync() placed above the walk would not stay drained.
> +	 */
> +	cancel_work_sync(&pcdev->ntf_work);

[Severity: High]
At this point in the series, can ntf_work be queued again after this
drain?

Nothing here blocks pse_control holders that do not subscribe. A PHY
handle from fwnode_mdio can still take this path after
cancel_work_sync():

pse_ethtool_set_config() or pse_ethtool_set_prio()
  regulator op
    _pse_pi_disable()
      pse_disable_pi_pol()
        kfifo_in_spinlocked(&pcdev->ntf_fifo, &ntf, 1, &pcdev->ntf_fifo_lock);
        schedule_work(&pcdev->ntf_work);

The fifo and the work are freed just below. A requeued worker's
pse_control_put()->__pse_control_release() would also read the freed
pcdev->pi[psec->id].

The commit message mentions this ("The drain is not yet final on its
own"). The baseline freed pcdev->pi before cancel_work_sync(), so this
ordering is no worse.

The last patch in the series, "net: phy: own phydev->psec via PSE
notifier and remove fwnode_mdio hook", closes the window:

- The PSE_UNREGISTERED walk clears and puts every phydev->psec under
  pse_phy_lock().
- net/ethtool/pse-pd.c takes pse_phy_lock() around
  pse_get_pse_attributes() and the whole of ethnl_set_pse().
- A WARN_ON(!list_empty(&pcdev->pse_control_head)) follows the drain.

> +
> +	pse_flush_pw_ds(pcdev);

[Severity: High]
This isn't a bug introduced by this patch, but can a shared power domain
be freed here while another controller still uses it?

pse_register_pw_ds() allocates a new domain with
devm_pse_alloc_pw_d(pcdev->dev). That is a devm_kzalloc() on the device
of whichever controller (A) registered first. A second controller (B)
whose PI regulators share the same parent supply only takes a reference:

drivers/net/pse-pd/pse_core.c:pse_register_pw_ds() {
    ...
			if (regulator_is_equal(pw_d->supply, rdev->supply)) {
				present = true;
				pcdev->pi[i].pw_d = pw_d;
				break;
			}
		}
		if (present) {
			kref_get(&pw_d->refcnt);
			continue;
		}
    ...
}

When A unbinds, pse_flush_pw_ds() only drops A's own references, for
example from 2 to 1. __pse_pw_d_release() does not run, so the pw_d stays
in pse_pw_d_map and in B->pi[i].pw_d.

devm_pse_controller_register() calls devres_add() for the unregister
cookie only after pse_controller_register() returns. Devres therefore
frees the pw_d allocation right after pse_controller_unregister(A)
returns.

B and later controllers then use the freed pw_d:

- pse_pw_d_is_sw_pw_control() reads pw_d->budget_eval_strategy.
- pse_pi_allocate_pw_budget() and pse_pi_deallocate_pw_budget() use
  pw_d->supply.
- B's own pse_flush_pw_ds() does xa_load(&pse_pw_d_map,
  pcdev->pi[i].pw_d->id), then kref_put_mutex() on the freed kref.
- A third controller's pse_register_pw_ds() walks pse_pw_d_map and reads
  pw_d->supply.

The later patch "net: pse-pd: unwind allocations when controller
registration fails" says it does not fix shared power domains ("devres
frees the creator's pw_d underneath it anyway"). At the end of the series
pse_flush_pw_ds() only clears the departing controller's own pi[].pw_d.
B's pointer and the xarray entry still point at freed memory.

> +	pse_release_pis(pcdev);

[Severity: High]
This is a pre-existing issue, but at this commit, can PHY-held
pse_control handles reach the freed pcdev->pi and pcdev after unbind?

PHYs keep the handle they got from fwnode_mdio until phy_device_remove(),
and nothing subscribes to PSE_UNREGISTERED yet. Once this frees pcdev->pi
and devres frees pcdev, psec->pcdev points at freed memory.

Unprivileged users can reach this through the ETHTOOL_MSG_PSE_GET path.
pse_ethtool_get_status() dereferences pcdev->ops and pcdev->pi[psec->id].

The final pse_control_put() from phy_device_remove() also runs this on
freed memory:

drivers/net/pse-pd/pse_core.c:__pse_control_release() {
    ...
	if (psec->pcdev->pi[psec->id].admin_state_enabled)
		regulator_disable(psec->ps);
	regulator_put(psec->ps);

	module_put(psec->pcdev->owner);
    ...
}

The commit message says this stays open until phylib releases its
handles. The last patch in the series, "net: phy: own phydev->psec via
PSE notifier and remove fwnode_mdio hook", fixes it:

- fwnode_find_pse_control() is removed.
- During PSE_UNREGISTERED, phy_pse_detach_one() clears and puts each
  matching phydev->psec before cancel_work_sync() and the frees.
- pse_prepare_data(), ethnl_set_pse() and phy_device_remove() hold
  pse_phy_lock().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004164219.1161294-1-github%40szelinsky.de
