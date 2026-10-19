Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF96496D42;
	Mon, 19 Oct 2026 08:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398947; cv=none; b=XRAoflpF2pUzirYocF24ldMdhI0AQvI31TunG6C/3zi+LVj1O6TGJiQtbxiCH2SldDgwLUrNghkhk556zEYssMCZNCHQSy3UDJqWe+4cGMPb9Le07jR46IITXA+ivzkL98rS51HX7hc/Cd6iR0blhK5Xmae+fsyyBpaBupZLliA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398947; c=relaxed/simple;
	bh=AItxRKL6AHBiP/i2xbQZRDK5kzPJWyVTBc+7XEhEn0Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B5kNVhUnb6kJwMrkSi5Exi7eGF3zSM8VICtAt38PkyAQlKTSm861M4DztYwwa+2lN5j/Jo3qlvxmDKNW6ZCztzQSD2I5Kgp3BDTigiKhQY8x9vHn0HOTtdLvWr2e54D9QDA9BpBvxwgNxPkyH29TWybcFAkck6AnAqLLFyAmP1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAaJpgt3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAaJpgt3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53381F000C6;
	Mon, 19 Oct 2026 08:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792398940;
	bh=FSR6lM5TwgxF46Sv1mTSAvTxKmfhTreFiPWuXT3YZ+g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kAaJpgt35zvDgVcOMTlk6L2CKKcwfruHQt3qJdhOEBdxlRtbkR+QY9nFaLbgOaHzJ
	 o32MnoEArpS2dXhBRqQFunq0mV+Awn+B7XzQkcS1+FqaXHKQhHipTbhrGFHm04ucu4
	 WAAAGG1C6ATuP0IQ9Yn2wWb3fOY7tv4Kgn8LQYrMsjFNKIeRGmWwwNIOGmGOg3eDUS
	 JYDt/0CF1PeYaUGe6F6+5xb+0jrJsFgs0D1yRp4PZeyHGLpHjnMnl2beQyQb+sC0fg
	 n/Pqm5lWQsU4Bs9RX8egdDh1d7AvJ+sfCFmTqMKp5NRHhGmEX11lzuV2b8QIopkhPD
	 3hXvUjozC7YZQ==
Subject: Re: [PATCH net-next 4/4] net: pse-pd: check the PI vpwr supply before
 registering the controller
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 broonie@kernel.org, lgirdwood@gmail.com, corey@leavitt.info,
 kyle.swenson@est.tech, horms@kernel.org, netdev-bot+sashiko@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 08:35:39 +0000
Message-ID: <179239893933.3135.9046263155258328713@kernel.org>
In-Reply-To: <20261018081853.47484-5-github@szelinsky.de>
References: <20261018081853.47484-5-github@szelinsky.de>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new check in pse_pi_check_supply() and
  pse_controller_check_supply() is weaker than what the regulator core…
- [Medium] The new check loop in pse_controller_register() can fail
  (typically with -EPROBE_DEFER) after pcdev->ops->setup_pi_matrix() has…
- [Low] The comment above pse_controller_check_supply() says the core's
  fallback is 'a vpwr-supply on the controller node'.

--

net: pse-pd: check the PI vpwr supply before registering the controller

This commit adds a check to pse_controller_register(). After
setup_pi_matrix() and before the PI regulators are registered, it looks
up each PI's vpwr supply, or the controller's fallback vpwr supply. If a
supply is missing, the PSE driver's probe is deferred, so that a consumer
that looks a PI up when the controller registers does not get
-EPROBE_DEFER.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 05b02d736931c..44986749600e3 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -826,6 +827,65 @@ static const struct regulator_ops pse_pi_ops = {
>  	.set_current_limit = pse_pi_set_current_limit,
>  };
>  

[ ... ]

> +static int pse_pi_check_supply(struct pse_controller_dev *pcdev, int id)
> +{

[ ... ]

> +	of_node_put(np);
> +	supply = of_regulator_get_optional(pcdev->dev, pcdev->pi[id].np,
> +					   "vpwr");
> +	if (!IS_ERR(supply)) {
> +		regulator_put(supply);
> +		return 0;
> +	}

[Severity: Medium]

Can this check pass even though resolving the PI's supply later still
defers?

of_regulator_get_optional() and regulator_get_optional() both go through
_regulator_get_common(). That calls regulator_resolve_supply() on the
supply rdev itself, which only resolves the supply's own upstream supply.
So the check never asks whether the supply's parent device is bound.
pse_controller_check_supply() accepts the supply under the same
condition.

When devm_pse_pi_regulator_register() registers the PI regulator,
regulator_resolve_supply() on the PI rdev does run that bound check:

drivers/regulator/core.c:regulator_resolve_supply() {
    ...
	if (r->dev.parent && r->dev.parent != rdev->dev.parent) {
		if (!device_is_bound(r->dev.parent)) {
			put_device(&r->dev);
			ret = -EPROBE_DEFER;
			goto out;
		}
	}
    ...
}

regulator_register() ignores that error, which leaves the PI rdev with
rdev->supply == NULL. pse_register_pw_ds() then skips the PI, and the
controller is still added to pse_controller_list.

A PI lookup in that window still returns -EPROBE_DEFER:

pse_control_get_internal()
  regulator_get_exclusive()
    _regulator_get_common()
      regulator_resolve_supply()

The window opens when the supplier driver has called regulator_register()
but its probe has not returned yet. Examples are async probing,
fw_devlink=permissive or off, or a supplier probe that registers the
regulator and then defers. regulator_put() runs right after the check, so
nothing holds the supplier in place between the check and PI
registration.

The commit message says:

  a supply that is registered, but whose device is not bound yet, still
  passes, and that PI then gets no power domain.

In this case, wouldn't PI lookups also keep returning -EPROBE_DEFER after
the controller has registered? That looks like the failure the commit
message gives as its motivation, for a consumer such as the planned
phylib PSE notifier that only looks a PI up when a controller registers.

Also, pse_register_pw_ds() only runs at registration. Would that PI then
never get a power domain?

> +
> +	ret = PTR_ERR(supply);
> +	if (ret == -ENODEV)
> +		return 1;
> +
> +	return dev_err_probe(pcdev->dev, ret,
> +			     "PI %d: failed to get vpwr supply\n", id);
> +}
> +
> +/* The core's fallback: a vpwr-supply on the controller node. */

[Severity: Low]

This isn't a bug, but is this comment accurate? The lookup goes
regulator_get_optional(pcdev->dev, "vpwr")->regulator_dev_lookup()->
regulator_dt_lookup()->of_get_regulator(). If the controller node has no
vpwr-supply property, of_get_regulator() does this:

	regnode = of_get_child_regulator(dev->of_node, prop_name);

That walks every descendant node, including sibling pse-pi nodes, before
it falls back to the supply map and the lookup by name.

This matches what the regulator core does. However, the comment on
pse_pi_check_supply() names the sibling PI fallback as the hazard it
avoids.

Could this comment say that the fallback also walks the controller's
child nodes?

> +static int pse_controller_check_supply(struct pse_controller_dev *pcdev)
> +{

[ ... ]

> @@ -1102,6 +1163,26 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  			goto release_pis;
>  	}
>  
> +	/* Check vpwr supplies while pcdev->pi can still be freed. Not before
> +	 * setup_pi_matrix(): pd692x0 registers the regulators its PIs name
> +	 * there.
> +	 */
> +	for (i = 0; i < pcdev->nr_lines; i++) {
> +		ret = pse_pi_check_supply(pcdev, i);
> +		if (ret < 0)
> +			goto release_pis;

[Severity: Medium]

Does this new exit, and the pse_controller_check_supply() exit just
below it, leak the vmain power budget that pd692x0 reserved in
setup_pi_matrix()?

By this point pd692x0_setup_pi_matrix() has already returned success,
after this call chain:

pd692x0_setup_pi_matrix()
  pd692x0_req_managers_pw_budget()
    regulator_request_power_budget(supply, pw_budget);

That raises rdev->pw_requested_mW on vmain. The reservation is released
only by pd692x0_managers_free_pw_budget(), and that is called only from:

  - the error labels inside pd692x0_setup_pi_matrix()
  - pd692x0_i2c_remove(), which does not run when probe fails

release_pis only calls pse_release_pis(), and no driver hook undoes
setup_pi_matrix(). When devm unregisters the manager regulators, it puts
the vmain consumer handle, but that does not lower pw_requested_mW
either.

On the next probe attempt, regulator_get_unclaimed_power_budget() returns
the reduced value, possibly 0, so manager_pw_budget[i] comes out smaller.
cfg_saved is already true, so the hardware power bank is not
reprogrammed. The first reservation can never be freed, because remove
only frees manager_pw_budget[i].

This can happen when a pd692x0 PI's vpwr-supply points at a regulator
that is late or missing, so pse_pi_check_supply() returns -EPROBE_DEFER.

Would it make sense to give drivers a way to undo setup_pi_matrix() on
this error path?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018081853.47484-1-github%40szelinsky.de
