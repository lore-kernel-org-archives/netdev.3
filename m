Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965923ACEF2;
	Wed,  9 Sep 2026 06:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935603; cv=none; b=BoWPr9nZUyHq2DqHe3kgnPKXMLwpfVbQfwhWQ5mC6eQMejX6WkjXvnU6pfdFeXaeV1W3XV7YmgsPPy5blLZsR/3HMfw51FUOiW5WiBfxoE/ZGcZY2mbv7Lbu42j0/twes0xe1uqbD/K36xpdz2/gtLSIZUG5NbbT0s1ywb6cK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935603; c=relaxed/simple;
	bh=2j9S89IC4Io1bxWzxIzxi4sBp4k+D8jvwhyBYB2aico=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DClXUb0iKdmpRUs6qGqddkosBWw99LUfAv+9uBZl4IdovPt8YCwDMKLkXsqlpJskIifwQewz++uuqpZW/qvXqAwhILCLQwUqcJZBkFKRcq6AP0ioK4Roa5ykJsuwvj6GetPEqRdablZT3QnhH9SNj/C1mDF1ku5SIDKFkUl5mPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9+u+oTi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9+u+oTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E111F00A3D;
	Wed,  9 Sep 2026 06:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788935601;
	bh=ytmqSmnp9R4RxGIm+XkVA8eB7FsSO2RZHebgsD6NLsk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R9+u+oTi4zZI9sj/7sEaaPrdV14pNsaXXuodS+cNzcRwjZM+15K7EeyzXGKleFy8w
	 FH2LA3UEZzT/MCB967QJswtULkK+iTQbMUH2nVM1AVdxE3D/rqcbnSQ7Msl/dz0uJj
	 Kvs6NA4yj4nBCbMEL0dQzr6BfOOq8TLTXN+qKeh01yBIFE9QgPmfpWD46e5XqXKZtd
	 dfX1rCqp04YEUH3xQ6dwa4x4PrFYZyj0k3txw1e5Cr6koKUXqDUSRjNJ4sF3YqCGxc
	 lcaATOmApxfJfGWqfmOWXUBhNKoAF5tVIvy9ikOF5lQ7LJSbPpUT4/AmocsKrqWeCG
	 DRnSA4ZiXZvsg==
Subject: Re: [PATCH net-next v6 4/5] net: phy: use a dedicated mutex instead
 of rtnl for PSE control attach
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corey@leavitt.info,
 jelonek.jonas@gmail.com, horms@kernel.org, olek2@wp.pl,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 06:33:20 +0000
Message-ID: <178893560000.219967.12262382469111881440@kernel.org>
In-Reply-To: <20260906153102.959217-5-github@szelinsky.de>
References: <20260906153102.959217-5-github@szelinsky.de>
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

Critical: 0 · High: 2 · Medium: 1 · Low: 1

- [High] At this commit, phydev->psec is released asynchronously and
  without the new lock: phy_device_remove()…
- [High] pse_phy_lock() only serialises the attach against the notifier
  callback itself, not against the controller teardown that follows it.
- [Medium] Commit message hides that the deadlock being fixed was
  introduced two patches earlier in the same series.
- [Low] The commit message wrongly lists netsec among the drivers that
  deadlock ("so any such driver (lantiq_etop, sni_ave, netsec) deadlocks…

--

net: phy: use a dedicated mutex instead of rtnl for PSE control attach

This replaces the rtnl_lock() that phy_device_register() took around
phy_try_attach_pse() with a new mutex living in pse_core, reached via
pse_phy_lock() / pse_phy_unlock(), and uses it in the PSE notifier walks
and in the ethtool PSE paths.  phy_device_register_locked() becomes
identical to phy_device_register() and is folded back in.

Link: https://lore.kernel.org/netdev/bac5e6e9-7358-4ccb-87fc-9c40baa33682@wp.pl/

A few questions on the changelog first.

> phy_device_register() took rtnl_lock() around phy_try_attach_pse() to
> serialise phydev->psec against the PSE controller notifier walk.

[Severity: Medium]
Should this say where that rtnl_lock() came from?  At the baseline commit
cef9d6804030, drivers/net/phy/phy_device.c has no rtnl in
phy_device_register() and no phy_device_register_locked() at all; both were
added by the earlier patch in this same series ("net: phy: own phydev->psec
via PSE notifier and remove fwnode_mdio hook").

As written the message reads as if the rtnl_lock() were pre-existing
upstream behaviour, and there is no Fixes: tag or note that the deadlock is
introduced inside this submission.

That also leaves the series non-bisectable: with only the earlier patches
applied, register_netdevice() holds rtnl and calls ltq_etop_init() ->
ltq_etop_mdio_init() -> mdiobus_register() -> mdiobus_scan() ->
phy_device_register() -> rtnl_lock(), and ave_init() -> of_mdiobus_register()
reaches the same recursion, so those boards hang on probe at the
intermediate commit.

Would it make sense to squash this patch (and the never-needed exported
phy_device_register_locked() API that it removes again) into the patch that
introduced the rtnl_lock()?

> so any such driver (lantiq_etop, sni_ave, netsec) deadlocks on probe.

[Severity: Low]
Does netsec belong in that list?  netsec_netdev_init(), its .ndo_init, only
allocates the TX/RX descriptor rings and resets the hardware; the MDIO bus
is registered from netsec_probe() via netsec_register_mdio(), before
register_netdev() is called, so phy_device_register() runs without rtnl
held there.  The lantiq_etop and sni_ave paths do match the described
recursion.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index f5febff4b00b8..e8d894bbfa7aa 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1181,16 +1181,16 @@ static int phy_pse_notifier_event(struct notifier_block *nb,
>  {
>  	switch (event) {
>  	case PSE_REGISTERED:
> -		rtnl_lock();
> +		pse_phy_lock();
>  		bus_for_each_dev(&mdio_bus_type, NULL, NULL,
>  				 phy_pse_attach_one);
> -		rtnl_unlock();
> +		pse_phy_unlock();
>  		return NOTIFY_OK;
>  	case PSE_UNREGISTERED:
> -		rtnl_lock();
> +		pse_phy_lock();
>  		bus_for_each_dev(&mdio_bus_type, NULL, data,
>  				 phy_pse_detach_one);
> -		rtnl_unlock();
> +		pse_phy_unlock();
>  		return NOTIFY_OK;

[Severity: High]
Can a phy that has already left mdio_bus_type keep its pse_control past the
controller teardown?

The detach walk only reaches devices still on the bus, but at this commit
phy_device_remove() does not touch phydev->psec:

drivers/net/phy/phy_device.c:phy_device_remove() {
	unregister_mii_timestamper(phydev->mii_ts);
	device_del(&phydev->mdio.dev);
	...
}

and the put is deferred to the release callback, without the new lock:

drivers/net/phy/phy_device.c:phy_device_release() {
	...
	might_sleep();
	pse_control_put(phydev->psec);
	...
}

So a phy that has been device_del()'d but is still pinned (an attached
netdev holding a reference, or an SFP-module phy waiting for
phy_device_free()) is invisible to the PSE_UNREGISTERED walk and keeps its
psec across pse_controller_unregister().  That function then frees the pi
array:

drivers/net/pse-pd/pse_core.c:pse_controller_unregister() {
	blocking_notifier_call_chain(&pse_controller_notifier,
				     PSE_UNREGISTERED, pcdev);
	pse_flush_pw_ds(pcdev);
	pse_release_pis(pcdev);		/* kfree(pcdev->pi) */
	...
}

and the later put reaches __pse_control_release(), which does
"if (psec->pcdev->pi[psec->id].admin_state_enabled) regulator_disable(psec->ps);"
on that freed memory.  This also runs outside pse_phy_lock(), which the new
kernel-doc says every phydev->psec access must hold.

The last patch of the series ("net: phy: release phydev->psec from
phy_device_remove() again") does move the put into phy_device_remove()
under pse_phy_lock() and strips it from phy_device_release(), so the end
state is fine; the concern is only about this intermediate commit, which
is also the one that documents the locking contract.

> @@ -1201,15 +1201,22 @@ static struct notifier_block phy_pse_notifier __read_mostly = {

[ ... ]

> +int phy_device_register(struct phy_device *phydev)
>  {
>  	int err;
>  
> @@ -1233,6 +1240,10 @@ static int __phy_device_register(struct phy_device *phydev)
>  		goto out;
>  	}
>  
> +	pse_phy_lock();
> +	phy_try_attach_pse(phydev);
> +	pse_phy_unlock();
> +
>  	return 0;
>  
>   out:
> @@ -1241,51 +1252,6 @@ static int __phy_device_register(struct phy_device *phydev)
>  	mdiobus_unregister_device(&phydev->mdio);
>  	return err;
>  }
> -
> -/**
> - * phy_device_register_locked - Register the phy device on the MDIO bus
> - * @phydev: phy_device structure to be added to the MDIO bus
> - *
> - * Same as phy_device_register() but caller must already hold rtnl_lock().
> - *
> - * Return: 0 on success, negative error code on failure.
> - */
> -int phy_device_register_locked(struct phy_device *phydev)
> -{
> -	int err;
> -
> -	ASSERT_RTNL();
> -
> -	err = __phy_device_register(phydev);
> -	if (err)
> -		return err;
> -
> -	phy_try_attach_pse(phydev);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL(phy_device_register_locked);

[ ... ]

>  EXPORT_SYMBOL(phy_device_register);

[ ... ]

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 611540df43bb1..b771f5a2a83fc 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -24,8 +24,54 @@ static LIST_HEAD(pse_controller_list);
>  static DEFINE_XARRAY_ALLOC(pse_pw_d_map);
>  static DEFINE_MUTEX(pse_pw_d_mutex);
>  
> +/* Serialises phydev->psec against the PSE controller lifecycle notifier and
> + * the ethtool PSE paths, in place of rtnl. The attach must not take rtnl: an

[ ... ]

> +static DEFINE_MUTEX(pse_phy_mutex);
> +
>  static BLOCKING_NOTIFIER_HEAD(pse_controller_notifier);
>  
> +/**
> + * pse_phy_lock - hold phydev->psec stable against PSE controller teardown
> + *
> + * The PSE_UNREGISTERED notifier clears phydev->psec and drops the last
> + * reference on the pse_control before the controller frees its state. Callers
> + * that attach, detach or dereference phydev->psec must hold this lock across
> + * the whole access so the detach cannot run underneath them.
> + */
> +void pse_phy_lock(void)
> +{
> +	mutex_lock(&pse_phy_mutex);
> +}
> +EXPORT_SYMBOL_GPL(pse_phy_lock);

[Severity: High]
Does this lock actually cover the teardown it claims to protect against?

phy_pse_notifier_event() drops pse_phy_mutex as soon as the detach walk
returns, and pse_controller_unregister() does the rest of the teardown with
the mutex no longer held:

drivers/net/pse-pd/pse_core.c:pse_controller_unregister() {
	blocking_notifier_call_chain(&pse_controller_notifier,
				     PSE_UNREGISTERED, pcdev);
	pse_flush_pw_ds(pcdev);
	pse_release_pis(pcdev);		/* kfree(pcdev->pi) */
	if (pcdev->irq)
		disable_irq(pcdev->irq);
	cancel_work_sync(&pcdev->ntf_work);
	kfifo_free(&pcdev->ntf_fifo);
	mutex_lock(&pse_list_mutex);
	list_del(&pcdev->list);
	mutex_unlock(&pse_list_mutex);
}

The controller stays on pse_controller_list until the very end, and the
window spans cancel_work_sync(), which can block for a queued notification
work item.

Can a concurrent phy_device_register() -> pse_phy_lock() ->
phy_try_attach_pse() -> of_pse_control_get() land in that window?
of_pse_control_get() walks pse_controller_list under pse_list_mutex only,
with no unregistering-state check, so of_pse_match_pi() reads the freed
pcdev->pi[i].np and pse_control_get_internal() then writes
pcdev->pi[index].admin_state_enabled and dereferences pcdev->pi[index].rdev.

The pse_control created that way can also never be detached, because the
PSE_UNREGISTERED walk has already finished, so its eventual put re-enters
__pse_control_release() on the freed pi array.

Would moving the list_del() ahead of pse_release_pis(), or holding
pse_phy_mutex across the whole of pse_controller_unregister(), close this?
The list_del-last ordering predates the series, but the changelog states
the new mutex protects "the phy<->controller binding against PSE controller
teardown", and the series adds both new attach sites, so the case seems
worth addressing here.  This is still present at the tip of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906153102.959217-1-github%40szelinsky.de
