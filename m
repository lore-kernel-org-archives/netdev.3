Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743217;
	b=mm6qIgyxF17N6Xm4dbUXftHMuOhQO8a/K0GDPKB4q2/xX8YT2uvVNqhdu6YFNlVoRuip
	 nuasHc20xx1Nb9WoDXc6F9rj3WVxQq9H7e9WRYw1VeIxzUmcLbN0PJZk/3pPNByBCl9Ao
	 FluolEgNOeXFqCI3pN1EzuRicqwpCXgSIrIdmum1ZComAqdu5ZNz3vLh3h+XgfZXqM6TO
	 SmGGvfvJekGCkFK/xN71F8OpSi9KNkZdTi7+gWt0FNAoLFcaOMsN01+2QN4GxNYZZdrvA
	 UXf1ZqcYPXeurkE9FPIlSvQOUeINx/X3GLjovbPo86XgelT6mCvY1gbzksG/cc2t+NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743217;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xy/icg2FgLnwhxYRw7WOqFpBG1mDn+HJbXpbcFTIaWo=;
	b=2aui23v0BPpCjcgC3l+edQehKLW3ko1N3SyNrttUUR9Xwg8/5i2HZtfZ1qt4/tymNKV+
	 2D1H/Fy+UJ7J/rbsTMg0pnTMMre62IaXliL5vC4JgW7RZ1RlVh5W9MWJ+6AsRNRL8fWlz
	 v+UiU+w9BFzNUYAFvOGEGhN8sNetIfFXtJ2nC4uvvmUeIXWiyyT3Y54rGSnVm4R8Atcxg
	 SDoHtNitWCGmctDOt3dE8PP44aJNSSYmdUPI52s8KZ7g4LZWZaxBf6eoB49/wlJOr1YyE
	 26ySNPUuQP33pTtamMMfWuGC5B10yMntJ7QLCwxPou0AIqYxkqpOC9ETQ0YPC3ZT+DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D8b7AQCV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E5606A32A;
	Fri, 23 Oct 2026 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D8b7AQCV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E86E1F031E2;
	Fri, 23 Oct 2026 08:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743217;
	bh=xy/icg2FgLnwhxYRw7WOqFpBG1mDn+HJbXpbcFTIaWo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D8b7AQCVJx38VP95XIiQ/Gn72ayw+yQLKLXeNPzrLkEcOqw6K+NjG7RZwAeJZ8K6l
	 VNPA2C0RxNMbLtRROVyBvjfl9yLyQLiXkOwongO6mv2Q58QlavglOgt3s6NAEW+fDq
	 R3AhS/T30gSkmclGaI2Jvg7rlIDBLWjK9bHX/SJTamfqqRPq+ykZ/4ut8kw/hHaBkv
	 pzHTBBOfcSp7/pLMKPpGUXBDYKVdn084G1QJ2ild9oI0FRPRB4bkusSPYpBCgBVYdw
	 gQoWroyxJUoHwLV3vgRAgmALK2G+XzUeM//WlZ1FOAVgUZ11QBz+CEBz8LPav1zSQj
	 ZTmf+KyXv//AQ==
Subject: Re: [PATCH net v2 07/14] net: pse-pd: do not tie a shared power
 domain to its creator's devres
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kyle.swenson@est.tech, ross@r-sc.ca,
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 08:13:35 +0000
Message-ID: <179274321586.3134.1876025605279648825@kernel.org>
In-Reply-To: <20261020171249.853085-8-github@szelinsky.de>
References: <20261020171249.853085-8-github@szelinsky.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At this commit, the shared power domain still depends on its
  creator's lifetime through pw_d->supply.
- [Medium] At this commit, a partial failure in pse_register_pw_ds()
  leaks the power domains that were already set up.

Pre-existing issues:
- [High] At this commit, pse_controller_unregister() calls
  pse_flush_pw_ds() and then pse_release_pis(), which kfree()s pcdev->pi…
- [Low] pse_register_pw_ds() publishes pcdev->pi[i].pw_d (line 978 for a
  shared domain, line 1007 for a new one) holding only pse_pw_d_mutex,…

--

net: pse-pd: do not tie a shared power domain to its creator's devres

This commit allocates PSE power domains with kzalloc() instead of
devm_kzalloc(), and frees them from __pse_pw_d_release() on the last
kref_put(). pse_flush_pw_ds() now clears pi[].pw_d under pcdev->lock
before the put, and pse_ethtool_set_prio() checks pw_d under that lock.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 36f7dba8190a2..13d6bd29525f3 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -893,10 +894,18 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
>  	int i;
>  
>  	for (i = 0; i < pcdev->nr_lines; i++) {
> -		if (!pcdev->pi[i].pw_d)
> +		/* Clear it before the put that may free the domain. The PI
> +		 * regulator ops and pse_isr() hold pcdev->lock while they
> +		 * use it.
> +		 */
> +		mutex_lock(&pcdev->lock);
> +		pw_d = pcdev->pi[i].pw_d;
> +		pcdev->pi[i].pw_d = NULL;
> +		mutex_unlock(&pcdev->lock);

[Severity: High]
This is a pre-existing issue, but pcdev->lock here protects the pw_d
pointer, not the pcdev->pi array that holds it. Can the PI regulator ops
or pse_isr() still reach a freed pcdev->pi after this?

pse_controller_unregister() does:

	pse_flush_pw_ds(pcdev);
	pse_release_pis(pcdev);
	if (pcdev->irq)
		disable_irq(pcdev->irq);

pse_release_pis() ends with kfree(pcdev->pi) and does not take
pcdev->lock.

The IRQ is disabled only after the free. The devm-registered PI
regulators are unregistered even later by devres, because
devm_pse_controller_release() runs before them in reverse devres order.

In that window, a sysfs "state" read or a consumer's regulator_disable()
can reach pse_pi_is_enabled() or pse_pi_disable(). They do:

	mutex_lock(&pcdev->lock);
	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {

and that reads the freed array. If the driver's IRQ outlives unregister,
pse_isr() also reads pcdev->pi[i] under the same lock.

Later commits in the series fix this. "net: pse-pd: stop async event
sources before freeing PI data in unregister" moves disable_irq() and
cancel_work_sync() to the start. "net: pse-pd: keep the PI data until the
PI regulators are gone" frees pcdev->pi from a devm action registered
before the PI regulators, and sets pcdev->unregistering under
pcdev->lock. One of those commit messages shows a KASAN
slab-use-after-free in pse_pi_is_enabled().

[Severity: Low]
This is also a pre-existing issue. The comment says pw_d users rely on
pcdev->lock, but the writer in pse_register_pw_ds() doesn't take it. It
publishes the pointer while holding only pse_pw_d_mutex:

		if (pcdev->supp_budget_eval_strategies)
			pw_d->budget_eval_strategy = pcdev->supp_budget_eval_strategies;
		else
			pw_d->budget_eval_strategy = PSE_BUDGET_EVAL_STRAT_DISABLED;
		kref_init(&pw_d->refcnt);
		pcdev->pi[i].pw_d = pw_d;

The shared-domain branch does the same with pcdev->pi[i].pw_d = pw_d.

devm_pse_pi_regulator_register() has already registered the PI
regulators earlier in pse_controller_register().

So a concurrent sysfs "state" read could run pse_pi_is_enabled() and see
a non-NULL pw_d with a stale budget_eval_strategy. Would it then fall back
to the pse_pi_is_hw_enabled() path?

The impact looks limited to one wrong is_enabled answer during probe. The
publish path is still unlocked at the end of the series.

>  			continue;
>  
> -		pw_d = xa_load(&pse_pw_d_map, pcdev->pi[i].pw_d->id);
> +		pw_d = xa_load(&pse_pw_d_map, pw_d->id);

[ ... ]

> @@ -969,7 +984,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
>  			continue;
>  		}
>  
> -		pw_d = devm_pse_alloc_pw_d(pcdev->dev);
> +		pw_d = pse_alloc_pw_d();
>  		if (IS_ERR(pw_d)) {
>  			ret = PTR_ERR(pw_d);
>  			goto out;
> @@ -978,6 +993,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
>  		supply = regulator_get(&rdev->dev, rdev->supply_name);

[Severity: High]
Is the shared domain still tied to its creator's lifetime through
pw_d->supply?

regulator_get() is called with &rdev->dev, and rdev is this controller's
devm-registered PI regulator. The regulator core records rdev->dev as the
consumer device and adds the handle to the parent supply's consumer_list.
The handle is then stored in pw_d->supply.

With this patch the domain can outlive its creator. Suppose the creating
controller unbinds while another controller still holds a reference. Its
PI rdev is unregistered and freed, but pw_d->supply->dev still points to
it.

Would a read of the debugfs regulator_summary then dereference the freed
device through consumer->dev in regulator_summary_show_subtree()? And
would the final put also use the stale dev pointer?

__pse_pw_d_release()
  regulator_put(pw_d->supply)
    destroy_regulator()

This conflicts with the new kernel-doc on pse_alloc_pw_d(), which says
the domain "must not be tied to the lifetime of the controller that
happened to create it".

The later commit "net: pse-pd: use each PI's own supply handle for the
power budget" removes the supply member from struct pse_power_domain. Its
commit message shows a KASAN slab-use-after-free in
regulator_summary_show_subtree().

>  		if (IS_ERR(supply)) {
>  			xa_erase(&pse_pw_d_map, pw_d->id);
> +			kfree(pw_d);
>  			ret = PTR_ERR(supply);
>  			goto out;
>  		}

[Severity: Medium]
Does a failure partway through this loop leak the domains already set up
for earlier PIs?

Each earlier iteration either kref_init()s a new kzalloc'd domain or
kref_get()s a shared one, and stores it in pcdev->pi[j].pw_d. If
pse_alloc_pw_d() or regulator_get() then fails for a later PI, the code
jumps to:

out:
	mutex_unlock(&pse_pw_d_mutex);
	return ret;

That label does no unwinding, and pse_controller_register() returns
without calling pse_flush_pw_ds():

	ret = pse_register_pw_ds(pcdev);
	if (ret)
		return ret;

The domain is no longer devm memory, so nothing frees it. The struct, its
supply handle and its xarray slot all leak, and a shared domain keeps one
extra reference.

The commit message mentions this ("is now leaked instead of freed while
still in the map"). The later commit "net: pse-pd: unwind allocations
when controller registration fails" adds an unwind loop using
pse_pi_take_pw_d() and pse_pw_d_leave() before pse_pw_d_mutex is dropped.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020171249.853085-1-github%40szelinsky.de
