Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F13AA9E2;
	Tue, 18 Aug 2026 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070369; cv=none; b=RE2T1RkqSxQJlGCRg8hDBHP71jKtHrusdoyKyvrwCcybfpHkfO5hL5+x2i4hpEzcCg+yOU+WT3mFXH0JPPuIMoRfa47AjY03GlW7V+otvIZcXOVXvA5Lxv/L0vSc9mVFRwxDMqip1NJkw7fHbXm8EP51CL9bta4C3hL3lB0AgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070369; c=relaxed/simple;
	bh=zXWV3/CaLpptbI7jPvsvFULCzH5RCbRhdJVv7HCrP50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfLUbQ6tjxa8WtlmiX860xKirBdBfN08zHHlsLhZUIa2bi1T/5PMdo8MqIRgw8y7Vbu9anyxPiJtKq8c79X6+W58S+OYX+mAtjI/S/Npb38PZUj9f0tCzQGS9ojFd7c4BljZhBTXoBKPTP0O0I9y637TvvdDgsRsynx/D4TFfTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mol+ptA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mol+ptA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870161F000E9;
	Tue, 18 Aug 2026 16:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787070368;
	bh=FPCeKlYbwSQ45TtE8YpWgJHlXGVdV3UlGioFQSJk/Io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mol+ptA8gIZnFkntBzjGhytkdQVnDykbgeQ16l+PrqhaCsYBajoOw09Dw9yWBfjfa
	 BpIkTCaKTRQcnMvfd0cGmT3lxLeoFnJKBuh4FRVjulSf3tPBLQvZAa5fdTk/dkDpo2
	 5YzfVWw1sVcSpHyCBtZWqMNHd2sCfg3xUqcRenPQikemh7PzNfjAj9CPWOoSz9oD0f
	 vhNHcOwLMetP76dLtBssYj8uGOXSNFcs+64KSIUJZvcGrQBkUj49LkPTOVwyOQBaAd
	 qVvCi96WViRapbkXmamwOMMsKEfOF9aocJvEBUhM5SwlDLvxW4gJriS8qSKL9QnI0U
	 vGMFi1INLTBXg==
From: Jakub Kicinski <kuba@kernel.org>
To: github@szelinsky.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jelonek.jonas@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/3] net: pse-pd: guard regulator ops against freed PI data during unregister
Date: Tue, 18 Aug 2026 09:26:06 -0700
Message-ID: <20260818162606.3981504-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813200653.980170-3-github@szelinsky.de>
References: <20260813200653.980170-3-github@szelinsky.de>
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
net: pse-pd: guard regulator ops against freed PI data during unregister

This clears pcdev->pi after freeing it in pse_release_pis() and adds a
NULL check to pse_pi_is_enabled(), pse_pi_enable() and pse_pi_disable(),
with the kfree()/NULL store and the reads both done under pcdev->lock.
The stated goal is to avoid a use-after-free when the regulator core
calls into these ops after the controller has been unregistered.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 6045b6c399c26..21ccb51466160 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -144,7 +144,13 @@ static void pse_release_pis(struct pse_controller_dev *pcdev)
>  		of_node_put(pcdev->pi[i].pairset[1].np);
>  		of_node_put(pcdev->pi[i].np);
>  	}
> +	/* Free under the lock so the NULL store is authoritative against
> +	 * the regulator ops that read pcdev->pi under pcdev->lock.
> +	 */
> +	mutex_lock(&pcdev->lock);
>  	kfree(pcdev->pi);
> +	pcdev->pi = NULL;
> +	mutex_unlock(&pcdev->lock);
>  }

[Severity: High]
Now that pcdev->pi can legitimately be NULL, do the other readers of
pcdev->pi in this file need the same guard?  Only the three regulator ops
were updated, but the consumer-facing paths still index the array
unconditionally:

drivers/net/pse-pd/pse_core.c:__pse_control_release() {
	...
	if (psec->pcdev->pi[psec->id].admin_state_enabled)
		regulator_disable(psec->ps);
	...
}

The same unguarded read appears in pse_get_sw_admin_state(),
pse_ethtool_get_status(), pse_ethtool_set_config() (four times),
pse_pi_update_pw_budget(), pse_ethtool_set_pw_limit() and
pse_ethtool_set_prio().

Can these run after pse_release_pis()?  pse_controller_unregister() does
not drain pcdev->pse_control_head, and a pse_control only takes
try_module_get(pcdev->owner) in pse_control_get_internal(), which blocks
module unload but not driver unbind.  The handle lives in phydev->psec and
is dropped only by phy_device_remove() -> pse_control_put().  So after
unbinding the PSE controller driver, an ethtool PSE request on the still
registered interface, or a later PHY removal, would reach these reads with
pcdev->pi == NULL.

Before this change those reads were a use-after-free of the freed array;
with the NULL store they become a NULL + offset dereference, so the oops
becomes deterministic rather than going away.

Two of the lock-holding readers also sample the pointer before acquiring
pcdev->lock, so the lock-mediated NULL store cannot be observed by them:

drivers/net/pse-pd/pse_core.c:pse_ethtool_get_status() {
	...
	pi = &pcdev->pi[psec->id];
	mutex_lock(&pcdev->lock);
	if (pi->pw_d) {
	...
}

pse_pi_update_pw_budget() does the same with
struct pse_pi *pi = &pcdev->pi[id];

Does the invariant described in the commit message ("read pcdev->pi under
the same lock in the ops") hold for those two?

[Severity: High]
This isn't a bug introduced by this patch, but the ordering in
pse_controller_unregister() looks like it leaves part of the window the
commit message claims to close still open:

drivers/net/pse-pd/pse_core.c:pse_controller_unregister() {
	...
	cancel_work_sync(&pcdev->ntf_work);
	pse_flush_pw_ds(pcdev);
	pse_release_pis(pcdev);
	...
}

pse_flush_pw_ds() drops the power-domain kref, and __pse_pw_d_release()
calls regulator_put(pw_d->supply) plus xa_erase() without clearing the
pcdev->pi[i].pw_d back-pointers and without taking pcdev->lock.

In the interval between pse_flush_pw_ds() and the kfree()/NULL store,
pcdev->pi is still non-NULL, so the new guards pass and the ops proceed to
the released supply:

pse_pi_disable() -> _pse_pi_disable() -> pse_pi_deallocate_pw_budget() {
	regulator_free_power_budget(pi->pw_d->supply, pi->pw_allocated_mW);
}

and via pse_pw_d_retry_power_delivery() ->
pse_pi_allocate_pw_budget_static_prio() ->
regulator_request_power_budget(pi->pw_d->supply, ...).

Both helpers write rdev->pw_requested_mW, so this would be a
use-after-free write through a freed struct regulator.  Does the stated
guarantee ("the op either sees the live array or returns without touching
freed memory") cover the case where the array is live but the supply it
points at is already released?

[ ... ]

> @@ -702,15 +718,20 @@ static int pse_pi_enable(struct regulator_dev *rdev)
>  static int pse_pi_disable(struct regulator_dev *rdev)
>  {
>  	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
> -	struct pse_pi *pi;
>  	int id, ret;
>  
>  	id = rdev_get_id(rdev);
> -	pi = &pcdev->pi[id];
>  	mutex_lock(&pcdev->lock);
> +	/* Reached via the regulator core's deferred-disable flush after
> +	 * pcdev->pi is freed on unregister.
> +	 */
> +	if (!pcdev->pi) {
> +		mutex_unlock(&pcdev->lock);
> +		return 0;
> +	}

[Severity: Medium]
Should this path return success without ever de-energizing the port?
Taking the early exit means ops->pi_disable() is never called, so the PSE
chip is not told to stop sourcing power, and pse_pi_deallocate_pw_budget()
is skipped, so the mW reserved on the shared power-domain supply are not
returned via regulator_free_power_budget().

The reachable trigger looks like a race rather than the deferred-disable
flush named in the comment: pse_ethtool_set_config() reads
pcdev->pi[psec->id].admin_state_enabled while the array is live,
pse_release_pis() then frees and NULLs it on the detaching CPU, and the
consumer's regulator_disable() lands here and returns 0.  Before this
change the same sequence still issued the ops->pi_disable() register write.

pcdev->ops and the driver private state are released later in devres LIFO
order, and id comes from rdev_get_id(rdev), so is there a reason the
hardware disable cannot still be issued here?

Also, pse_pi_enable() returns -ENODEV for the same condition while this one
returns 0.  Is the asymmetry intended?

>  	ret = _pse_pi_disable(pcdev, id);
>  	if (!ret)
> -		pi->admin_state_enabled = 0;
> +		pcdev->pi[id].admin_state_enabled = 0;
>  
>  	mutex_unlock(&pcdev->lock);
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but since these lines are being
reworked anyway: should ret be returned here instead of 0?

_pse_pi_disable() returns -EOPNOTSUPP when ops->pi_disable is absent, and
otherwise propagates the driver error from the port-off register write
(for example an I2C failure in tps23881_pi_disable() or
pd692x0_pi_disable()).

With 0 returned, _regulator_do_disable() treats the disable as successful,
_regulator_disable() sets rdev->use_count = 0 and the consumer's
enable_count is decremented, while the hardware is still sourcing power
and pcdev->pi[id].admin_state_enabled stays at 1 because the assignment is
skipped on exactly that error path.

The ethtool "admin-state disabled" request then reports success with the
port still energized, pse_ethtool_set_config() will not re-enable it since
if (!admin_state_enabled) is false, and a further disable attempt calls
regulator_disable() with use_count == 0, which the regulator core rejects
with a WARN and -EIO.

[Severity: High]
One more pre-existing item, not introduced by this patch, in
pse_controller_register() in the same file: there is no error unwinding
after the early allocations.

After kfifo_alloc(&pcdev->ntf_fifo, ...) succeeds, the mandatory callback
check returns without kfifo_free():

drivers/net/pse-pd/pse_core.c:pse_controller_register() {
	...
	if (!pcdev->ops->pi_get_admin_state ||
	    !pcdev->ops->pi_get_pw_status) {
		dev_err(...);
		return -EINVAL;
	}
	...
}

Once of_load_pse_pis() has allocated pcdev->pi and taken OF node
references, the later failures (ops->setup_pi_matrix(), the devm_kzalloc()
of the regulator name, devm_pse_pi_regulator_register(),
pse_register_pw_ds()) also return directly without pse_release_pis(), so
the non-devm PI array and the of_node_get() references leak.

Can a failure inside pse_register_pw_ds() leave a dangling global entry?
An earlier iteration may already have inserted a devm_kzalloc()-backed
pse_power_domain into pse_pw_d_map via devm_pse_alloc_pw_d() -> xa_alloc()
and taken a regulator_get() reference.  devm_pse_controller_register() only
does devres_free(pcdevp) on failure, so nothing erases that entry; devres
then frees the pw_d while the xarray still points at it, and the next
registration walks xa_for_each(&pse_pw_d_map, index, pw_d) and calls
regulator_is_equal(pw_d->supply, ...) on freed memory.
-- 
pw-bot: cr
