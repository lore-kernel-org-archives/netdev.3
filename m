Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167874A3F26;
	Mon, 19 Oct 2026 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399883; cv=none; b=iZF2TBsyGqhM3qWouVl0Hm3WU4Uci0AYPZwuhJ3WaPmD6VwhqLcnAz41IX781DpX3C2AVXHP3bsnAGUFneNIg2yHaGnES5dGS/f1SLn3snpavzNVpMIaIjP5uQjeEcG+QHX1UnZB4WjdBLADjjtNHv/bm/AX/flScNk/Rx3ZtFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399883; c=relaxed/simple;
	bh=DSvD7M82co+2oQ8ePBejMRbUYuTv8I6yGgcfswXJTVU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kC64/Q080R2Dn3HsCjSYEO/HoFyhiYRWNRJCQ1xM0HIjp+xAAluglnrZ9LyFAdSxbs6hkJVJB3m6Y8lfXnaGCpYq2kDYOt3t752p+h/f6RNtY0mXF9aFyNv2bMiuvr9WsRctgJ2OyCPQaGcwGLY5USSy+xuZ5fboYV6v2VTFK20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSuwI8nk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSuwI8nk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282A61F000C5;
	Mon, 19 Oct 2026 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792399876;
	bh=G4dhacquKYjvvGhJFJHyLVicUu8jHH6ke9PoArYboCs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jSuwI8nklYIxwV0HkRVdzALPXeXFGQPSYB1wHNtsLyrjWvlmgLSPpANpKHOsV+pCz
	 7SclLr7tPZ8c3Dj+VyO21CVzS1ZydM74+HA2PUEi5fV/WT1dZjGac6+JAKPFl7GzTL
	 iFgkbTMXGWg/SQvMYJKbhZhbIl7+SBrmC3dtyI4Ro/NF8JlWD82RI9eND77cSgupGU
	 P49OsfgoqvqJfYVvBQXHymkx1jh2SNJSBxvacn16liwD20PMpQRvvhhpmYyCrjAKox
	 f25c06WsQuBt1Isx95dSglo4pbLPhqeYot3ySFPW/j9s6/vW/NbGHyW8AHIsa8RPtW
	 VeLEDCYnNxIeQ==
Subject: Re: [PATCH net 06/10] net: pse-pd: do not tie a shared power domain
 to its creator's devres
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 piotr.kubik@adtran.com, saikrishnag@marvell.com, horms@kernel.org,
 kyle.swenson@est.tech, netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 08:51:14 +0000
Message-ID: <179239987471.3135.11859262024217714390@kernel.org>
In-Reply-To: <20261018082314.48950-7-github@szelinsky.de>
References: <20261018082314.48950-7-github@szelinsky.de>
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

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The shared power domain still depends on its creator's devres
  through its supply handle.
- [Medium] A partial failure of pse_register_pw_ds() is never unwound, so
  the left-over domains stay live and keep being reused.
- [Medium] pse_flush_pw_ds() now clears pcdev->pi[i].pw_d to NULL while
  the PI regulators are still registered.

--

net: pse-pd: do not tie a shared power domain to its creator's devres

This patch allocates PSE power domains with kzalloc() instead of devm
memory and frees them on the last kref_put(). pse_flush_pw_ds() now
clears pi[].pw_d under pcdev->lock before the put, and
pse_ethtool_set_prio() checks pw_d under that lock.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index d5f863834179c..0d1e5d5039f8a 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -898,10 +899,18 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
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

[Severity: Medium]
Can the PI regulator ops still run here and see pw_d == NULL?

The PI regulators are devm registered before the pcdevp devres entry.
That means they stay registered until after pse_controller_unregister()
returns:

pse_controller_unregister()
    pse_flush_pw_ds(pcdev);
    pse_release_pis(pcdev);

During that window a consumer, such as a PHY's pse_control driven through
ethtool, can call pse_pi_enable(). It would then skip the software power
control branch:

	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)) {
		...
	}

	ret = ops->pi_enable(pcdev, id);

So the port is powered without the PD detection gate and without a
budget charge.

The disable side has a similar gap. _pse_pi_disable() calls
pse_pi_deallocate_pw_budget(), which returns early:

	if (!pi->pw_d || !pi->pw_allocated_mW)
		return;

As a result, regulator_free_power_budget() is never called for a supply
that another controller may still share.

Before this patch, pw_d stayed valid during this window. The commit message
says "The PI regulator ops and pse_isr() use it under the same lock". Does
that cover only memory safety, and not this new no-domain state?

Separately, there is a pre-existing issue that this patch did not
introduce: pse_release_pis() frees pcdev->pi right after the flush while
the regulators are still live. The pse_isr() part does not seem to apply
to in-tree drivers. For tps23881, devm_pse_irq_helper() is registered
after the controller, so devres frees the IRQ first.

> +		if (!pw_d)
>  			continue;

[ ... ]

> @@ -974,7 +989,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
>  			continue;
>  		}
>  
> -		pw_d = devm_pse_alloc_pw_d(pcdev->dev);
> +		pw_d = pse_alloc_pw_d();
>  		if (IS_ERR(pw_d)) {
>  			ret = PTR_ERR(pw_d);
>  			goto out;
> @@ -983,6 +998,7 @@ static int pse_register_pw_ds(struct pse_controller_dev *pcdev)
>  		supply = regulator_get(&rdev->dev, rdev->supply_name);

[Severity: High]
Is the shared domain still tied to its creator through this supply handle?

The consumer device here is &rdev->dev, where rdev is a PI regulator of
the creating controller. devm_pse_pi_regulator_register() registers that
regulator with devm_regulator_register() on the creator's device.

In the regulator core, _regulator_get_common()->link_and_create_debugfs()
stores the pointer without taking a reference:

	regulator->dev = dev;

The only reference comes from the DL_FLAG_STATELESS device link, and
device_del() of the PI rdev purges that link.

With this patch, controller B can keep the domain alive after creator A
unbinds. devres then unregisters and frees A's PI regulators:

regulator_unregister()
    device_unregister(&rdev->dev)
        regulator_dev_release()

pw_d->supply stays on the supply's consumer_list with ->dev pointing at
freed memory. Reading /sys/kernel/debug/regulator/regulator_summary then
reaches regulator_summary_show_subtree():

	if (consumer->dev && consumer->dev->class == &regulator_class)

Would that be a use-after-free read of the freed struct device?

When B finally puts the domain, destroy_regulator() passes the stale
pointer to device_link_remove(regulator->dev, &rdev->dev). The address may
have been reused by another consumer of the same supply. Could that drop
that consumer's device link?

A domain left over from a failed pse_register_pw_ds() has the same stale
->dev, and it stays in pse_pw_d_map where later controllers can pick it up.

The new pse_alloc_pw_d() comment says the domain "must not be tied to the
lifetime of the controller that happened to create it". Should the supply
handle be acquired with a consumer device that the creator does not own?
The rest of the series leaves this code unchanged.

>  		if (IS_ERR(supply)) {
>  			xa_erase(&pse_pw_d_map, pw_d->id);
> +			kfree(pw_d);
>  			ret = PTR_ERR(supply);
>  			goto out;
>  		}

[Severity: Medium]
What happens to the PIs handled before the failing one?

When pse_alloc_pw_d() or regulator_get() fails for PI i, only the current
iteration is cleaned up. Each of PIs 0..i-1 did one of two things:

- took kref_get() on an existing domain, possibly another controller's
- created a new domain in pse_pw_d_map holding a supply handle

pse_controller_register() then returns without a flush:

	ret = pse_register_pw_ds(pcdev);
	if (ret)
		return ret;

devm_pse_controller_register() only calls devres_free(pcdevp), so
pse_controller_unregister()->pse_flush_pw_ds() never runs.

Does this leak the extra references on other controllers' domains, so they
can never be released?

The new domains stay in the global map. Their supply consumer's ->dev is
the failed controller's PI rdev, and devres unregisters that rdev as probe
unwinds. A later pse_register_pw_ds() can find such a domain through
regulator_is_equal() and kref_get() it, so its refcount never returns to
zero.

The commit message says:

    A domain left over from a failed pse_register_pw_ds() is now leaked
    instead of freed while still in the map.

The leaked domain is still published in the map and still carries a
dangling consumer device. Would calling pse_flush_pw_ds(pcdev) on the
pse_register_pw_ds() error path in pse_controller_register() be enough?
pcdev->lock is already initialized there, and the flush already skips PIs
whose pw_d is NULL.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018082314.48950-1-github%40szelinsky.de
