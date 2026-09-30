Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A1770809;
	Wed, 30 Sep 2026 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727587; cv=none; b=fRBnhtb+WCJPPoHhyTTmplvXOaTz62B4pKeVoBcXVr/TQ4A62gK9CgmR8X+SOtzem8pkeZMA3hhvF8pAHyW4F+gubHn0p5cbKnR2c1iX4jBp7HjayaQ8mxbPdgkbn+Fw6qOBsgBA9IwxMQjiVUOR6dZ/EHFDMf+t7WKGiz9zmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727587; c=relaxed/simple;
	bh=+m3nDGpLrkebrZM1TSXMETJk7DPVkwhZ10JLDsUhxf4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=afhNlzdWJoWOxCOhLmCXLnXW5nEQz4l52aZBdagyur6iV5/NWS98YW+LzfShAs1JSQgZFz8+MOCVO2dWk+yJ8zbeDqfDwwmrk/FMihv+etN2wvR3hyap99YqTlwV963/sTywhgZ5ILaKU+xNRyv/yvT+7OSxJlDI25zfkLA8ZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keiyppiF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keiyppiF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2551F00893;
	Wed, 30 Sep 2026 00:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727586;
	bh=62r13JD3pV0kKIy3yezzGAetvqL9ps9zMUGGJS46Nng=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=keiyppiF8J7AC9Yh5LUMFua1J4zgsPY2O/8wUOBLCxFTWSy6CR84nM6HfHzEYJ4bX
	 rKfmO2k84BgE93oBSxUwDJSobUXuCWkyrMqi4qf+3A/PzQ6pE18exqDvBCQtd64+i2
	 5cU0t8fgmj4v9cqhU4dfpNmia+EQeIgfF9bvf0hiT0A/A022vrzqDCF2oVknpXx14e
	 IqmdKEMFrOKM7a4fVGKlwIbtJ92gm/qMKX6jkQlLLV5BBa/PV8uI1QvWeOL14uU5aM
	 mS78uBeONBaQTZc4Klev9f2PHeKuR2Qm9TFx6uz+3TbuD+/9O87Xa+G+7ei8sx88rV
	 gzk2+0jAXuZ4w==
Subject: Re: [PATCH net-next v7 3/5] net: pse-pd: unwind allocations when
 controller registration fails
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corey@leavitt.info,
 jelonek.jonas@gmail.com, horms@kernel.org, olek2@wp.pl, broonie@kernel.org,
 lgirdwood@gmail.com, netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 00:19:44 +0000
Message-ID: <179072758462.434549.6040448570480387158@kernel.org>
In-Reply-To: <20260927191850.1370515-4-github@szelinsky.de>
References: <20260927191850.1370515-4-github@szelinsky.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] pse_flush_pw_ds() runs after pse_register_pw_ds() has already
  dropped pse_pw_d_mutex, so the new flush_pw_ds unwind can race with…
- [Medium] The new flush_pw_ds unwind in pse_controller_register()
  releases the power domains while the PI regulators are still…
- [Medium] Failures in the PI-regulator loop (devm_kzalloc of reg_name,
  devm_pse_pi_regulator_register()) and in pse_register_pw_ds() still…
- [Low] The patch fixes a use-after-free and several leaks that are in
  released kernels, but it has no Fixes: tag, no stable Cc, and it goes…
- [Low] The commit message says the PI array is released on
  'setup_pi_matrix() and the supply check', but at this commit…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  pse_controller_register() calls kfifo_alloc(&pcdev->ntf_fifo,…
- [High] This problem wasn't introduced by this patch, but
  pse_controller_unregister() frees pcdev->pi through pse_release_pis()…

--

net: pse-pd: unwind allocations when controller registration fails

This patch adds error unwinding to pse_controller_register(). A failed
registration now frees the notification kfifo and flushes any partially
created power domains. The PI array is released only on failures that
happen before the first PI regulator is registered.

> A partial pse_register_pw_ds() is worse than a leak. The power domains it
> already created are devm-allocated but live in the global pse_pw_d_map,
> so the failed probe frees them while that xarray still points at them,
> and the next controller to register walks into freed memory in
> regulator_is_equal().

[Severity: Low]
This fixes a use-after-free and several leaks that exist in released
kernels. However, the patch has no Fixes: tags and no stable Cc, and it
goes to net-next inside a feature series. Should it carry tags such as:

Fixes: 50f8b341d268 ("net: pse-pd: Add support for PSE power domains")
Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Fixes: 29e28d1d7a16 ("net: pse-pd: Add support for setup_pi_matrix callback")
Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")

The first covers the pse_register_pw_ds() use-after-free, the second the
kfifo leak, and the last two the PI array and OF reference leaks. The
unwind depends on the rest of the series only through a
blocking_notifier_call_chain() context line.

> reach those ops. So the array is released on the failures that happen
> while it exists and before the first PI regulator does: setup_pi_matrix()
> and the supply check.

[Severity: Low]
At this commit, setup_pi_matrix() is the only failure that jumps to
release_pis. pse_controller_register() has no supply check yet. The
supply check that unwinds to release_pis comes in the next patch:

"net: pse-pd: check the PI vpwr supply before registering the controller"

Could the message for this patch describe only the code it contains?

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 56cecf60c5c4c..16d75b4babf34 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -1092,17 +1092,18 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  	    !pcdev->ops->pi_get_pw_status) {
>  		dev_err(pcdev->dev,
>  			"Mandatory status report callbacks are missing");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto free_kfifo;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but just above this hunk the
kfifo is sized before nr_lines is normalized:

pse_controller_register() {
    ...
	ret = kfifo_alloc(&pcdev->ntf_fifo, pcdev->nr_lines, GFP_KERNEL);
	...
	if (!pcdev->nr_lines)
		pcdev->nr_lines = 1;
    ...
}

pse_reg_probe() in drivers/net/pse-pd/pse_regulator.c never sets
nr_lines, so kfifo_alloc() is passed 0. __kfifo_alloc_node() then calls
roundup_pow_of_two(0), which evaluates 1UL << BITS_PER_LONG. That shift is
undefined, and either possible result fails the size < 2 check, so
kfifo_alloc() returns -EINVAL.

Does this mean the podl-pse-regulator controller can never finish
pse_controller_register()?

Moving the normalization above kfifo_alloc() would not be enough on its
own, because a capacity of 1 is also rejected. The fifo size would need
to be at least 2.

[ ... ]

> @@ -1119,20 +1125,22 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
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

[Severity: Medium]
Do these failure paths leak the OF node references taken in
of_load_pse_pis()?

Three paths end at free_kfifo: the reg_name allocation failure, the
devm_pse_pi_regulator_register() failure and the flush_pw_ds path. On
all of them, the of_node_get() on each PI node and the of_parse_phandle()
reference on each pairset are never dropped.

devm_pse_controller_register() frees only its devres cookie, so these
references leak on every failed probe. The commit message lists "an OF
reference per described PI" among the leaks it fixes.

The reason given for keeping the array does not seem to cover these
references:

- none of the pse_pi_ops touch pi[].np or pairset[].np
- the regulator core takes its own reference with
  of_node_get(config->of_node)
- of_pse_match_pi() is reachable only through pse_controller_list, which
  a failed controller never joins

Could the node references be put, and their pointers cleared, on these
paths without freeing the array?

Also, as the commit message notes, a reg_name failure in the first
iteration happens before any PI regulator exists. Releasing the whole
array would still be safe there.

>  
>  	ret = pse_register_pw_ds(pcdev);
>  	if (ret)
> -		return ret;
> +		goto flush_pw_ds;

[Severity: High]
Can the flush_pw_ds unwind race with another controller that registers
on the same supply?

pse_register_pw_ds() drops pse_pw_d_mutex at its out: label while the
domains it already created are still published in pse_pw_d_map.
pse_flush_pw_ds() runs only afterwards, outside that lock:

CPU1 (controller A)                  CPU2 (controller B, same supply)
pse_register_pw_ds()
  devm_pse_alloc_pw_d() for PI 0
    /* published in pse_pw_d_map */
  later iteration fails
  out: mutex_unlock(&pse_pw_d_mutex)
                                     pse_register_pw_ds()
                                       regulator_is_equal() matches A's pw_d
                                       pcdev->pi[i].pw_d = pw_d;
                                       kref_get(&pw_d->refcnt);
flush_pw_ds:
  pse_flush_pw_ds()
    kref_put_mutex()  /* 2 -> 1 */
probe fails, devres frees pw_d

The refcount only drops from 2 to 1, so __pse_pw_d_release() never runs
and there is no xa_erase() or regulator_put(). The pw_d lifetime comes
from devres on A's device, not from the kref. After the failed probe,
both pse_pw_d_map and B's pi[i].pw_d point at freed memory.

Would the next registration then still read freed memory in
regulator_is_equal()? B's pse_pw_d_is_sw_pw_control() and
pse_pi_allocate_pw_budget*() would also read the freed domain. That looks
like the same use-after-free the commit message describes.

Does this need the unwind to happen inside the mutex-held section of
pse_register_pw_ds()? The alternative would be to stop devm-allocating
the shared, refcounted domain.

[ ... ]

> @@ -1142,6 +1150,19 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  				     PSE_REGISTERED, pcdev);
>  
>  	return 0;
> +
> +flush_pw_ds:
> +	pse_flush_pw_ds(pcdev);
> +	goto free_kfifo;

[Severity: Medium]
Does this leave pcdev->pi[i].pw_d dangling while the PI regulators are
still live?

pse_flush_pw_ds() calls __pse_pw_d_release(), which does
regulator_put(pw_d->supply) and xa_erase(). pcdev->pi[i].pw_d is not
cleared.

The pw_d itself was devm_kzalloc()ed after the PI regulators were
devm-registered. When the failed probe unwinds, devres therefore frees it
before it unregisters the regulators.

In that window, the regulator state attribute or regulator_late_cleanup()
can reach:

pse_pi_is_enabled()
    pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)
        pw_d->budget_eval_strategy   /* freed */

pse_pi_deallocate_pw_budget() and pse_pi_allocate_pw_budget_static_prio()
would also still use the already released pw_d->supply.

The devres ordering window existed before this patch. What is new is that
the flush drops the supply while pi[].pw_d still points at it.

The comment added above the regulator loop says the live regulators must
not be handed a freed pointer. Would setting pcdev->pi[i].pw_d = NULL
after pse_flush_pw_ds() on this path cover it? The ops already treat a
NULL pw_d as no domain.

> +
> +release_pis:
> +	pse_release_pis(pcdev);
> +	pcdev->pi = NULL;

[Severity: High]
This is a pre-existing issue, and the commit message mentions it, but
pse_controller_unregister() still ends with:

	pse_flush_pw_ds(pcdev);
	pse_release_pis(pcdev);
	kfifo_free(&pcdev->ntf_fifo);

devm_pse_controller_register() adds its devres node after the PI
regulators and pw_d allocations. On unbind, devres therefore calls
pse_controller_unregister() first, and pse_release_pis() frees pcdev->pi
while every PI regulator is still registered:

devm_pse_controller_release()
    pse_controller_unregister()
        pse_release_pis()
            kfree(pcdev->pi)

Can a read of /sys/class/regulator/regulator.N/state (mode 0444) that
races with the unbind then reach this, before devres unregisters the
regulators?

pse_pi_is_enabled()
    pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)

That would dereference a pw_d read from the freed array. The commit
message defers the fix to a pending net teardown patch, and the problem
is still present at the end of this series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927191850.1370515-1-github%40szelinsky.de
