Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337F485508;
	Mon, 19 Oct 2026 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398940; cv=none; b=NhLL9Ep8SESIZTFxNDDP5c0pz2qqFm1O+/h3jZZkunjfqZdkhPD5TZvLaKZTo5ttBovx7bjAxzSYVdU3eAYJ+KhmhwEJ/zjG1O0Wv9MrI3Pgft4L7bSRNADa1T2SXK0HS7nbEwFyqEgIals+L35dHmT4w3xw62PDVMtQCc/jeSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398940; c=relaxed/simple;
	bh=lGDQ9s7Sd912EAMUCxG8LFd2AuAtFwCU9oQFX/ad9Eo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SEWsiYDksl6CJvAwOLkHURdN40220kruYtlxJAnmAjz9kZ2UDYQgcrhq2Sf9HqK7tPR7Fj0zVMTPiIcoooLP50saLtDpBgqKbOP32MfujklYYPWX26fcTUIwHd72ZkcCLKMKnvBmE2pgtLTaHOdHnYZFXWB+cSgfxJ42TgDP/F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ymj3x06Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ymj3x06Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1E61F000C5;
	Mon, 19 Oct 2026 08:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792398939;
	bh=tSSlpwlW3dXVAsGZXI6/lbf0Fx4YOLHrJWmH0s8voSU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ymj3x06YToZCTLSrry6+6NssIkI+BzsrGgI0GPLMApYp1djRlNr7ICpqfhsIzA+Sv
	 fO2MO5aUHDz3nZowCWY0Fs8IVPyKf16gU6fSMaNyrKQyfVEorgPk8IRiErTnCW0Qir
	 QREmQKk2QtLKCFQdSPGExbFxfqpUVqYXcnCYiEKGCjT3moZqLQZXRQUCs8YK59mSSM
	 zWqj9lZ4smpT3opSeUlqvtxu8CxeiVAZXenP0RXquNQZKShBJSLNqRe78G7MNWBDYP
	 VmfCcOCOXtCspPwPJ1UGVE58hamxUrxlVfPTrxpyiZWP5eC1WD/IbzSEH39K9OQCHh
	 4QtaXK7Cqso9Q==
Subject: Re: [PATCH net-next 2/4] net: pse-pd: unwind allocations when
 controller registration fails
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 broonie@kernel.org, lgirdwood@gmail.com, corey@leavitt.info,
 kyle.swenson@est.tech, horms@kernel.org, netdev-bot+sashiko@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 08:35:37 +0000
Message-ID: <179239893785.3135.13786246432250454158@kernel.org>
In-Reply-To: <20261018081853.47484-3-github@szelinsky.de>
References: <20261018081853.47484-3-github@szelinsky.de>
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

Critical: 0 · High: 0 (2) · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In pse_controller_register(), every failure after the PI
  regulator loop starts goes to free_kfifo, which skips…
- [Medium] The patch makes pcdev->lock the rule for pi[].pw_d:
  pse_pi_take_pw_d() clears it under the lock before the reference is…
- [Low] The commit fixes a real use-after-free that exists before this
  patch, but it carries no Fixes: tag.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the normal
  unregister path breaks the lifetime rule the patch states.
- [High] This problem wasn't introduced by this patch, but a PSE power
  domain shared by several controllers is still allocated with…
- [Medium] This problem wasn't introduced by this patch, but the driver's
  setup_pi_matrix() side effects are never undone when…

--

net: pse-pd: unwind allocations when controller registration fails

This adds error unwinding to pse_controller_register(), so the
notification kfifo, the PI array and the OF node references are released
when registration fails. pse_register_pw_ds() now undoes its own power
domains under pse_pw_d_mutex when it fails part way. pi[].pw_d is now
cleared under pcdev->lock, and the pw_d checks in pse_ethtool_set_prio()
and pse_pi_update_pw_budget() are done under that lock.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 364acc0250971..05b02d736931c 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -899,10 +921,11 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
>  	int i;
>  
>  	for (i = 0; i < pcdev->nr_lines; i++) {
> -		if (!pcdev->pi[i].pw_d)
> +		pw_d = pse_pi_take_pw_d(pcdev, i);
> +		if (!pw_d)
>  			continue;
>  
> -		pw_d = xa_load(&pse_pw_d_map, pcdev->pi[i].pw_d->id);
> +		pw_d = xa_load(&pse_pw_d_map, pw_d->id);
>  		if (!pw_d)
>  			continue;
>  

[Severity: High]
This is a pre-existing issue, but it sits next to this teardown code.
devm_pse_alloc_pw_d() still allocates the power domain against the
controller that creates it:

	pw_d = devm_kzalloc(dev, sizeof(*pw_d), GFP_KERNEL);

Other controllers then borrow it in pse_register_pw_ds() through
regulator_is_equal() and kref_get().

Say controller A creates the domain and controller B borrows it. When A
unbinds, pse_flush_pw_ds() drops only A's reference (2 -> 1), so
pse_pw_d_release_locked() and xa_erase() don't run. A's devres then frees
the pw_d memory while it is still in pse_pw_d_map and still referenced
from B's pcdev->pi[].pw_d.

Can B then read freed memory from pse_ethtool_get_status(),
pse_ethtool_set_prio(), pse_ethtool_set_pw_limit(), its PI regulator ops
or pse_isr()? Two other paths look affected too:

- A later controller's pse_register_pw_ds() calls
  regulator_is_equal(pw_d->supply, ...) on it.
- B's own pse_flush_pw_ds() or unwind kref_put() writes to it.

The commit message says this is fixed separately on net. That fix is not
in this tree or in this series.

[ ... ]

> @@ -998,6 +1021,13 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
>  	}
>  
>  out:
> +	/* Undo this call's domains before another controller can find them. */
> +	while (ret && i--) {
> +		struct pse_power_domain *pw_d = pse_pi_take_pw_d(pcdev, i);
> +
> +		if (pw_d)
> +			kref_put(&pw_d->refcnt, pse_pw_d_release_locked);
> +	}
>  	mutex_unlock(&pse_pw_d_mutex);
>  	return ret;
>  }

[Severity: Low]
This fixes a use-after-free that exists before this patch. Before, a
failure of devm_pse_alloc_pw_d() or regulator_get() at PI i jumped to out
and only dropped pse_pw_d_mutex.

The domains created for PIs 0..i-1 stayed in pse_pw_d_map. Their
regulator_get() and kref_get() references were never dropped, and devres
then freed them. The next pse_register_pw_ds() call then walks freed
memory in xa_for_each() and regulator_is_equal().

The kfifo leak on the early error returns, and the PI and OF node leak
after a setup_pi_matrix() failure, are older too.

Should this patch carry a Fixes: tag, at least for the commit that added
PSE power domains and pse_register_pw_ds()? Without one, stable tooling
won't pick up the use-after-free fix. The commit message also says the
related shared-domain fix goes to net, while this one does not.

> @@ -1058,17 +1088,18 @@ int pse_controller_register(struct pse_controller_dev *pcdev)

[ ... ]

>  	if (pcdev->ops->setup_pi_matrix) {
>  		ret = pcdev->ops->setup_pi_matrix(pcdev);
>  		if (ret)
> -			return ret;
> +			goto release_pis;
>  	}
>  
>  	/* Each regulator name len is pcdev dev name + 7 char +
> @@ -1076,7 +1107,9 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  	 */
>  	reg_name_len = strlen(dev_name(pcdev->dev)) + 18;
>  
> -	/* Register PI regulators */
> +	/* Register PI regulators. Their ops index pcdev->pi[] until devres
> +	 * unregisters them, so failures from here on must not free it.
> +	 */

[Severity: High]
This is a pre-existing issue, but does the normal unregister path follow
the rule in this comment?

In devm_pse_controller_register(), the PI regulators' devres entries are
added inside pse_controller_register(). The controller's own entry is
added after that:

	ret = pse_controller_register(pcdev);
	...
	*pcdevp = pcdev;
	devres_add(dev, pcdevp);

Devres releases in LIFO order. On unbind, devm_pse_controller_release()
-> pse_controller_unregister() therefore runs before devm_rdev_release()
for the PI regulators:

	pse_flush_pw_ds(pcdev);
	pse_release_pis(pcdev);
	kfifo_free(&pcdev->ntf_fifo);

pse_release_pis() calls kfree(pcdev->pi), but the PI regulators are
still registered with driver_data = pcdev.

Can a read of the regulator sysfs state attribute in that window reach
pse_pi_is_enabled() and index the freed pcdev->pi[id]? Two other paths
look like they could do the same:

- flush_work(&rdev->disable_work) in regulator_unregister().
- Ethtool callers that still hold a psec.

The new pse_pi_take_pw_d() call in pse_flush_pw_ds() expects PI
regulator ops to run during teardown. The array those ops index is freed
right after it.

>  	for (i = 0; i < pcdev->nr_lines; i++) {
>  		char *reg_name;
>  
> @@ -1085,26 +1118,38 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  			continue;
>  
>  		reg_name = devm_kzalloc(pcdev->dev, reg_name_len, GFP_KERNEL);
> -		if (!reg_name)
> -			return -ENOMEM;
> +		if (!reg_name) {
> +			ret = -ENOMEM;
> +			goto free_kfifo;
> +		}
>  
>  		snprintf(reg_name, reg_name_len, "pse-%s_pi%d",
>  			 dev_name(pcdev->dev), i);
>  
>  		ret = devm_pse_pi_regulator_register(pcdev, reg_name, i);
>  		if (ret)
> -			return ret;
> +			goto free_kfifo;
>  	}
>  
>  	ret = pse_register_pw_ds(pcdev);
>  	if (ret)
> -		return ret;
> +		goto free_kfifo;

[Severity: Medium]
Do these goto free_kfifo paths leak the OF node references held in
pcdev->pi[]?

Three failures skip pse_release_pis(): the reg_name allocation, the
devm_pse_pi_regulator_register() call and the pse_register_pw_ds() call.
pse_release_pis() is the only place that drops pi[i].np (taken with
of_node_get() in of_load_pse_pis()) and pi[i].pairset[0/1].np (taken with
of_parse_phandle()):

	of_node_put(pcdev->pi[i].pairset[0].np);
	of_node_put(pcdev->pi[i].pairset[1].np);
	of_node_put(pcdev->pi[i].np);

On failure, devm_pse_controller_register() calls devres_free(pcdevp), so
nothing drops these references later.

The commit message says the OF node reference leak is fixed, and names
only the PI array as still leaked. The reason given for keeping pi[]
doesn't seem to cover these references:

- regulator_register() takes its own reference on the PI node.
- The pairset nodes are only used by setup_pi_matrix(), which has
  already run.
- A failed controller is never added to pse_controller_list.

Could the node references be put and the pointers cleared without
freeing the array? Also, if the first reg_name allocation fails, no PI
regulator exists yet. Could the array itself be freed in that case?

>  
>  	mutex_lock(&pse_list_mutex);
>  	list_add(&pcdev->list, &pse_controller_list);
>  	mutex_unlock(&pse_list_mutex);
>  
>  	return 0;
> +
> +release_pis:
> +	pse_release_pis(pcdev);
> +	pcdev->pi = NULL;
> +
> +free_kfifo:
> +	cancel_work_sync(&pcdev->ntf_work);
> +	kfifo_free(&pcdev->ntf_fifo);
> +
> +	return ret;
>  }

[Severity: Medium]
This is a pre-existing issue, but none of the error paths after a
successful setup_pi_matrix() undo what the driver did in that callback.

For pd692x0, pd692x0_setup_pi_matrix() reserves budget on each manager's
upstream supply in pd692x0_req_managers_pw_budget():

	ret = regulator_request_power_budget(supply, pw_budget);

If a later step in pse_controller_register() fails, pd692x0_i2c_probe()
just returns the error from devm_pse_controller_register().
pd692x0_managers_free_pw_budget() is only called from the error labels in
setup_pi_matrix() and from pd692x0_i2c_remove(). Remove does not run
after a failed probe.

Does this leave the reservation on the supply's regulator_dev, so the
next probe attempt sees less budget, possibly none? pse_controller_ops
has no callback to undo setup_pi_matrix(), so the core can't roll this
back by itself.

>  EXPORT_SYMBOL_GPL(pse_controller_register);
>  
> @@ -1820,6 +1865,10 @@ static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
>  	 * power budget update
>  	 */
>  	mutex_lock(&pcdev->lock);
> +	/* pi->pw_d may have been cleared since the caller looked. */
> +	if (!pi->pw_d)
> +		goto out;
> +

[Severity: Medium]
This recheck covers pse_pi_update_pw_budget() itself. Doesn't
pse_ethtool_set_pw_limit() still read pw_d and the PI state without
pcdev->lock before it calls this function?

	if (pse_pw_d_is_sw_pw_control(psec->pcdev,
				      psec->pcdev->pi[psec->id].pw_d) &&
	    psec->pcdev->pi[psec->id].admin_state_enabled &&
	    psec->pcdev->pi[psec->id].isr_pd_detected) {
		ret = pse_pi_update_pw_budget(psec->pcdev, psec->id,
					      pw_limit, extack);

pse_pw_d_is_sw_pw_control() dereferences pw_d->budget_eval_strategy. A
concurrent pse_controller_unregister() -> pse_flush_pw_ds() can clear
pw_d through pse_pi_take_pw_d() and drop the last reference between that
unlocked load and the dereference.

There is a second race that needs no unbind. pse_isr() ->
pse_set_config_isr() can release the PI's budget and clear
isr_pd_detected under pcdev->lock after the unlocked checks above.
pse_pi_update_pw_budget() then finds pw_d non-NULL and requests budget
again for a PI that is disconnected.

Should admin_state_enabled and isr_pd_detected be rechecked here as
well, or should the whole check in pse_ethtool_set_pw_limit() move under
the lock?

The merge notes mention a net fix, "check the PI state under the lock
when setting a power limit", which may cover this. That fix is not in
this tree or in this series.

>  	previous_pw_allocated = pi->pw_allocated_mW;
>  	pw_diff = pw_req - previous_pw_allocated;
>  	if (!pw_diff) {

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018081853.47484-1-github%40szelinsky.de
