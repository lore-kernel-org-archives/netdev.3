Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAA3AB28D;
	Wed,  9 Sep 2026 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935604; cv=none; b=emSyJX4HYLb96ODQv1E5ED8Yx5gVZHooc8Lri7OS1ryIcDgBXXgeQHYLApzk/ZFXtg8nOirqs7vDuXj7JZFETtiFRJRxeN1NHSL0/zsE9ltc0lDYXja49koXXNXC4XKYhNAKD+hubbWAwVJsKHfuGjRUtvRmfl88LV9Xc1w4uwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935604; c=relaxed/simple;
	bh=1oY0lUZFS58y/nRPk09bnTUKONvvIzoY/b09ILGgkDM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZIA0unxCvr9WFjWr0eI6WsaALdfhUJgf/jt2dzVsN6Rj4UJGJBNO1bBMiy6O9EUEVb67vuXY70Hv07CC37DCLOfUHUYfT42hu91bk8WJZgKXPAFeYLTvBybu9ScnLn9mxVel/S9kfngChDdyGyed3hzlfnaD3mxOCFNc95Tvd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtDmcdHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtDmcdHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0831F00A3A;
	Wed,  9 Sep 2026 06:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935602;
	bh=6vArauM+vSzXzZz67RSyA0Eapj1t9miTelCnPUy4yGo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GtDmcdHUI3UTrA+5cLL76PHVR/RpqBc9cVJIxPSOYo8cX7CXnkicQ2SXzPPf0aY+X
	 Yl74BdnyvNKUFkAoyEQBDncVKDqZSYefY3qKUUjGIgBvzuvUYgmz9di5sbDneVvcYZ
	 y5ghpDX8HWsz0fAp1J3dm7t/jMdlFnqFOdoxK82YabbnzS/GdXiXi5Z1ip/0RrvCiH
	 PjOeE5bWadHD7HhzgSkQbXeECDKz8UYlimHJ5mITRaqZN6+0AfuFv4bi+WFbTZx+gj
	 PZPyEfMlrpHG1vFpz9Qf6BONNAYzRh8qeLx6pS0wLIR8XxM4+rsfCDkcGYA18EtxdH
	 t+sWCnfbwHBuw==
Subject: Re: [PATCH net-next v6 5/5] net: phy: release phydev->psec from
 phy_device_remove() again
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corey@leavitt.info,
 jelonek.jonas@gmail.com, horms@kernel.org, olek2@wp.pl,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 06:33:21 +0000
Message-ID: <178893560151.219967.4509880385605166044@kernel.org>
In-Reply-To: <20260906153102.959217-6-github@szelinsky.de>
References: <20260906153102.959217-6-github@szelinsky.de>
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
issue(s) to consider:

Critical: 0 · High: 2 (1) · Medium: 2 · Low: 0

- [High] The commit claims that after this change phydev->psec "can no
  longer outlive the PSE controller", but the same freed-array sink…
- [High] phy_device_remove() now drops phydev->psec and releases
  pse_phy_lock() *before* device_del(), i.e. before the phy leaves the…
- [Medium] In-series regression fixed by a later patch of the same
  series, with no attribution.
- [Medium] Memory leak of pse_control on the error path of
  phy_device_register() if device_add() fails.

Pre-existing issues:
- [High] phylib clears only the forward link on detach (phydev->psec =
  NULL in phy_pse_detach_one() and in the newly added block in…

--

net: phy: release phydev->psec from phy_device_remove() again

This moves the final pse_control_put() of phydev->psec out of
phy_device_release() and back into phy_device_remove(), where it now runs
under pse_phy_lock() just before device_del().  The stated reason is that a
device_del()'d but still pinned phy is invisible to the PSE_UNREGISTERED
bus walk, so a deferred put could outlive the PSE controller.

Link: https://lore.kernel.org/netdev/20260703071025.100797-1-pabeni@redhat.com/

A few questions below.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index e8d894bbfa7aa..bb120045c406e 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -223,19 +223,8 @@ static void phy_mdio_device_free(struct mdio_device *mdiodev)
>  
>  static void phy_device_release(struct device *dev)
>  {
> -	struct phy_device *phydev = to_phy_device(dev);
> -
> -	/* bus_for_each_dev() holds get_device() across each iteration
> -	 * step, deferring this release callback until any in-flight PSE
> -	 * notifier walk has advanced past this phy. pse_control_put()
> -	 * takes pse_list_mutex, so this path must run in sleepable
> -	 * context.
> -	 */
> -	might_sleep();
> -	pse_control_put(phydev->psec);
> -
>  	fwnode_handle_put(dev->fwnode);
> -	kfree(phydev);
> +	kfree(to_phy_device(dev));
>  }

[Severity: Medium]
With the put gone from the release callback, phy_device_remove() is
the only place phylib ever drops phydev->psec.  Do the error paths of
phy_device_register() still reach it?

As far as I can tell they do not: if device_add() fails,
phy_device_register() logs "failed to add", jumps to out:, asserts the
reset and calls mdiobus_unregister_device(), then returns the error to
the caller, which typically just phy_device_free()s the phy.
phy_device_remove() is never invoked, and phy_device_release() is now
only fwnode_handle_put() plus kfree().

The window matters because device_add() puts the device on the
mdio_bus_type klist in bus_add_device() before dpm_sysfs_add() and the
remaining steps, any of which can still fail and roll back.  While the
phy sits on that klist a concurrent PSE_REGISTERED walk
(bus_for_each_dev(&mdio_bus_type, ..., phy_pse_attach_one) under
pse_phy_lock()) can see it, and phy_try_attach_pse() will set
phydev->psec via of_pse_control_get() because psec is still NULL.  On
the failure return nothing puts that reference: the struct pse_control
stays on pcdev->pse_control_head with attached_phydev pointing at
memory that is about to be kfree()d, and the try_module_get(pcdev->owner)
taken in pse_control_get_internal() is never dropped, pinning the PSE
driver module for the lifetime of the system.  Keeping the put in
phy_device_release() happened to cover this case for free.

This is a cold path, but could the same locked put be factored into a
small helper (say phy_pse_detach(phydev)) and called from both
phy_device_remove() and the out: label of phy_device_register()?  Or
do you consider a put in the release callback still warranted as a
backstop for phys that never reach phy_device_remove() at all?

Related question: if phy_device_register() itself attaches the psec
before any of its remaining failure points, the leak would not even
need a concurrent notifier walk -- can you confirm the ordering there?

[Severity: Medium]
Is the use-after-free described in the changelog reachable in any released
tree?  In the baseline this series applies to, phy_device_remove() already
contained:

	unregister_mii_timestamper(phydev->mii_ts);
	pse_control_put(phydev->psec);

and phy_device_release() had no PSE put at all.  The deferral being undone
here was added earlier in this same submission by "net: phy: own
phydev->psec via PSE notifier and remove fwnode_mdio hook", whose own
changelog says the put "moves from phy_device_remove() to
phy_device_release()".

Should this hunk simply be folded into that patch instead of appearing as a
separate commit?  As posted, the two intermediate commits of the series
carry the live use-after-free on pcdev->pi[] that this commit removes, so
bisecting an unrelated phy or PSE problem into that window hits it.

The two sibling patches are referenced by quoted title only, with no SHA,
no Fixes: tag and no statement that they belong to the same series.  Could
that be made explicit either way, so a maintainer or stable backporter can
tell whether a Fixes:/backport is needed here?  If the commits do stay
separate, the introducing patch's changelog is left permanently documenting
a deferral rationale that no longer matches the tree.

> @@ -1265,6 +1254,16 @@ EXPORT_SYMBOL(phy_device_register);
>  void phy_device_remove(struct phy_device *phydev)
>  {
>  	unregister_mii_timestamper(phydev->mii_ts);
> +
> +	/* Detach synchronously, before the phy leaves the bus, so the put cannot
> +	 * outlive the PSE controller (an off-bus but still-pinned phy is missed by
> +	 * the PSE_UNREGISTERED walk). pse_phy_lock() serialises against that walk.
> +	 */
> +	pse_phy_lock();
> +	pse_control_put(phydev->psec);
> +	phydev->psec = NULL;
> +	pse_phy_unlock();
> +
>  	device_del(&phydev->mdio.dev);

[Severity: High]
Can a concurrent PSE_REGISTERED walk re-attach a psec to this phy after the
put has already run?

The lock is dropped here, and the phy only leaves the mdio_bus_type klist
much later, inside device_del() -> bus_remove_device():

drivers/base/bus.c:bus_remove_device() {
	...
	if (klist_node_attached(&dev->p->knode_bus))
		klist_del(&dev->p->knode_bus);
	...
}

bus_for_each_dev() does not skip devices whose device_del() is in progress,
so throughout kill_device(), BUS_NOTIFY_DEL_DEVICE, dpm_sysfs_remove() and
the sysfs teardown the phy is still reachable from:

phy_pse_notifier_event() {
	case PSE_REGISTERED:
		pse_phy_lock();
		bus_for_each_dev(&mdio_bus_type, NULL, NULL,
				 phy_pse_attach_one);
		pse_phy_unlock();
}

phy_pse_attach_one() -> phy_try_attach_pse() then sees dev->type ==
&mdio_bus_phy_type, of_node still set, and psec == NULL because this hunk
just cleared it:

	if (phydev->psec)
		return;

	psec = of_pse_control_get(np, phydev);
	...
	phydev->psec = psec;

Which path releases that new reference?  phy_pse_detach_one() can no longer
see the phy once it is off the klist, the put in phy_device_remove() has
already run, and phy_device_release() is now just fwnode_handle_put() plus
kfree().  That looks like a leaked struct pse_control left on
pcdev->pse_control_head with attached_phydev pointing at freed memory, plus
the try_module_get(pcdev->owner) reference taken in
pse_control_get_internal(), which would pin the PSE driver module for good.

The changelog says "whichever runs first clears phydev->psec, the other sees
NULL".  Does that hold for PSE_REGISTERED, which creates a reference rather
than clearing one?

Would placing the locked put after device_del(), still synchronously in
phy_device_remove(), close this?  Then either the put wins and the walk
cannot see the off-klist phy, or the walk wins and the put releases whatever
it attached.

[Severity: High]
The changelog states the put "can no longer outlive the PSE controller".  Is
that accurate given the attach side?

pse_controller_unregister() fires the notifier, frees pcdev->pi[], and only
then removes the controller from the list:

drivers/net/pse-pd/pse_core.c:pse_controller_unregister() {
	blocking_notifier_call_chain(&pse_controller_notifier,
				     PSE_UNREGISTERED, pcdev);

	pse_flush_pw_ds(pcdev);
	pse_release_pis(pcdev);
	...
	mutex_lock(&pse_list_mutex);
	list_del(&pcdev->list);
	mutex_unlock(&pse_list_mutex);
}

pse_release_pis() does kfree(pcdev->pi) without clearing pcdev->pi or
pcdev->nr_lines.  pse_phy_lock() is held only for the duration of the
notifier walk inside phy_pse_notifier_event(), which ends before
pse_release_pis() runs, so between the end of the walk and that list_del the
controller is still resolvable:

phy_device_register() -> phy_try_attach_pse() -> of_pse_control_get()

of_pse_match_pi() then reads pcdev->pi[i].np out of the freed array, and
pse_control_get_internal() reads and writes it:

	pcdev->pi[index].admin_state_enabled = ret;
	psec->ps = devm_regulator_get_exclusive(pcdev->dev,
						rdev_get_name(pcdev->pi[index].rdev));

The resulting psec lands in phydev->psec, and its eventual put reaches the
same freed-array dereference the changelog says is eliminated:

drivers/net/pse-pd/pse_core.c:__pse_control_release() {
	if (psec->pcdev->pi[psec->id].admin_state_enabled)
		regulator_disable(psec->ps);
}

The documented contract in include/linux/pse-pd/pse.h says subscribers "must
not acquire new references for it" after PSE_UNREGISTERED, but nothing on
the subscriber side can enforce that while the controller stays on
pse_controller_list.

Would making the controller unresolvable before pse_release_pis() (list_del,
or an unregistering flag tested under pse_list_mutex), and having
pse_release_pis() NULL out pcdev->pi and zero nr_lines, be needed for the
claim to hold?

[Severity: High]
This isn't a bug introduced by this patch, but only the forward link is
cleared here; nothing in phylib ever invalidates the reverse link
psec->attached_phydev.  pse_core sets it once, and only when it allocates a
fresh psec:

drivers/net/pse-pd/pse_core.c:pse_control_get_internal() {
	psec->attached_phydev = phydev;
}

An existing psec at the same PI index is merely kref_get()'d and the new
phydev pointer discarded, so the back-pointer stays bound to whichever phy
attached first and survives that phy's detach.  It is dereferenced here:

drivers/net/pse-pd/pse_core.c:pse_control_get_netdev() {
	ASSERT_RTNL();

	if (!psec || !psec->attached_phydev)
		return NULL;

	return psec->attached_phydev->attached_dev;
}

The NULL check cannot detect a freed phy.  pse_send_ntf_worker() takes a
transient reference and then blocks:

	psec = pse_control_find_by_id(pcdev, ntf.id);
	rtnl_lock();
	netdev = pse_control_get_netdev(psec);

If the phy removal completes in that window (this put drops phylib's
reference while the psec stays alive on the worker's kref, then
phy_mdio_device_free() -> put_device() -> phy_device_release() -> kfree()),
does the worker dereference the freed phy_device and hand a garbage
net_device pointer to ethnl_pse_send_ntf()?

Same window existed with the put in phy_device_release() and in the
baseline, so this is not a new problem, but should phylib also clear
psec->attached_phydev on detach?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906153102.959217-1-github%40szelinsky.de
