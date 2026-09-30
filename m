Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9626FDBF;
	Wed, 30 Sep 2026 00:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727589; cv=none; b=lgihIbt9O2Xi422KEq33vpc8qyL0p7Pt/RLh58X+reCLcR+qA6ltj7NctL7K7M4AZzNGMDgf0cX2989CrolVJ3NOb6kLIUCOqK4H0KoIAWwVXPb1/SOOxQzVfFrIiqB5Y4qWD9U50qmrz1M3xa2tTScGw4T3I+S4szDHSvulVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727589; c=relaxed/simple;
	bh=xDISW1HctfUZrFMPk0y+ZpklBqofAWPJbB2+Ng+xiPk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TnJiwZ37EQ5Z32Zwbke3pTLySvDW6Kf+q6zc+HusBso+OcXKlaLUg+/xKr1Zq1AoI+H66cY0DMBsn9euplbAsen5k63McSTixNhZ9nNaN0HG5BVxkNPKPrN+5IBPIMNnOzVhSq5mbSQBdZzIQdTL/LvqXBamMjEb5HUYDWwvq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV0iikGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV0iikGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8898B1F000FF;
	Wed, 30 Sep 2026 00:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727587;
	bh=9Gdyf+vQrLvZeIfpZq8IWNELAWuqnmrMlMkvWK3eCFQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FV0iikGFXQ7NqDeQup8GZajl340TvaNAfcEVHj1VuALwB1Bm0qq6085r1WK7nODmA
	 t0lopziBZjd7025zNIarBgZ2G6vczpgccrAQf5A184u0MxJZ8K4AssWYDSzCSPIWcx
	 kZRt6rhQRaI/ZTTg5lUfcxybYXBrpkSyMBa0BRMoQnObTt4yVdbI9VQSuoumfEn008
	 kQbAV2DDDaMvT3C+b2IzKpVT+zJMYuwKVk/awMebHc5l/YholvuSB6y4RQGsibUy47
	 DgQxUhG+Oors07Noc9P8BsuXLCJZ/Yyq7Pw1zkuQfykOdp0FGT2ERKG97OYD9xOF4Q
	 h9Dq4ZN1Nnkdw==
Subject: Re: [PATCH net-next v7 4/5] net: pse-pd: check the PI vpwr supply
 before registering the controller
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corey@leavitt.info,
 jelonek.jonas@gmail.com, horms@kernel.org, olek2@wp.pl, broonie@kernel.org,
 lgirdwood@gmail.com, netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 00:19:46 +0000
Message-ID: <179072758613.434549.2612517847459175334@kernel.org>
In-Reply-To: <20260927191850.1370515-5-github@szelinsky.de>
References: <20260927191850.1370515-5-github@szelinsky.de>
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

- [High] In pse_pi_check_supply() (drivers/net/pse-pd/pse_core.c), the
  first lookup does not search the same places the regulator core…
- [Medium] The new check loop in pse_controller_register()
  (pse_core.c:1180-1183) runs after pcdev->ops->setup_pi_matrix().
- [Medium] Between the check and the registration, nothing holds the
  provider, and the second resolution applies a condition the check…

--

net: pse-pd: check the PI vpwr supply before registering the controller

This commit adds pse_pi_check_supply(), which looks up each PI's vpwr
supply before any PI regulator is registered. It checks the PI node
first and then the controller device. If a lookup fails with
-EPROBE_DEFER or another error, pse_controller_register() fails, so the
PSE driver's own probe defers instead of registering a controller whose
PIs cannot be handed out.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 16d75b4babf34..457eef5784f8b 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -860,6 +861,67 @@ static const struct regulator_ops pse_pi_ops = {
>  	.set_current_limit = pse_pi_set_current_limit,
>  };
>  
> +/* The regulator core treats an unresolved "vpwr" supply as non-fatal and
> + * retries it on its own later, which would leave this controller able to
> + * register while of_pse_control_get() still fails with -EPROBE_DEFER for
> + * this PI, and nothing to retry the consumer's attach. Check the supply
> + * up front so the PSE driver's own probe defers instead.
> + *
> + * of_regulator_get_optional() reports a PI with no vpwr-supply described
> + * as -ENODEV rather than falling back to the dummy regulator, and has a
> + * stub for CONFIG_OF=n. Those PIs keep their existing behaviour: the
> + * regulator core resolves them to the dummy when the PI regulator is
> + * registered.
> + */
> +static int pse_pi_check_supply(struct pse_controller_dev *pcdev, int id)
> +{

[ ... ]

> +	if (pcdev->pi[id].np) {
> +		supply = of_regulator_get_optional(pcdev->dev,
> +						   pcdev->pi[id].np, "vpwr");
> +		if (!IS_ERR(supply)) {
> +			regulator_put(supply);
> +			return 0;
> +		}

[Severity: High]
Can this stage-one lookup pick up a sibling PI's supply instead of this
PI's?

of_regulator_get_optional(pcdev->dev, pi_np, "vpwr") ends up in
of_get_regulator(). When the node it is given has no match, it falls
back to the device's node, not to that node:

drivers/regulator/of_regulator.c:of_get_regulator() {
    ...
	regnode = of_parse_phandle(node, prop_name, 0);
	if (regnode)
		return regnode;

	regnode = of_get_child_regulator(dev->of_node, prop_name);
    ...
}

Here dev->of_node is the controller node. If pse-pi@N has no vpwr-supply
of its own, the fallback walks pse-pis and every sibling pse-pi node and
returns the first vpwr-supply it finds.

The core resolves the PI regulator's supply in a different order. The
PI rdev's of_node is the PI node. regulator_resolve_supply() first calls
regulator_dt_lookup(&rdev->dev, ...), which searches only the PI
subtree. It then calls regulator_dev_lookup(pcdev->dev, ...), which
reads the controller node's own vpwr-supply first.

Take a DT where the controller has vpwr-supply = <&main> and main has
not probed yet, pse-pi@0 has vpwr-supply = <&aux> and aux is registered,
and pse-pi@1 has no vpwr-supply:

pse_pi_check_supply(pcdev, 1)
  of_regulator_get_optional(pcdev->dev, pi1_np, "vpwr")
    of_get_child_regulator(controller_np, ...) finds &aux via pse-pi@0
  regulator_put(); return 0;

devm_pse_pi_regulator_register(pcdev, ..., 1)
  regulator_register()
    regulator_resolve_supply()
      resolves to &main -> -EPROBE_DEFER, ignored

The controller then fires PSE_REGISTERED, but regulator_get_exclusive()
in pse_control_get_internal() keeps returning -EPROBE_DEFER for PI 1.

With the later phy patch in this series, phy_try_attach_pse() drops
-EPROBE_DEFER without a warning and retries only on PSE_REGISTERED. Does
that port then never get its PSE control? This looks like the
controller-level vpwr-supply case that the commit message says this
patch closes.

The comment above the function says that of_regulator_get_optional()
"reports a PI with no vpwr-supply described as -ENODEV". That doesn't
hold when any sibling PI has a vpwr-supply.

Would it work to call of_regulator_get_optional() only when
of_property_present(pcdev->pi[id].np, "vpwr-supply") is true, and
otherwise go straight to the controller-level lookup? Doing the lookup
through a device whose of_node is the PI node would also work.

> +
> +		ret = PTR_ERR(supply);
> +		if (ret != -ENODEV)
> +			return dev_err_probe(pcdev->dev, ret,
> +					     "PI %d: failed to get vpwr supply\n",
> +					     id);
> +	}
> +
> +	/* A vpwr-supply on the controller node covers every PI, and is
> +	 * where a PI without a node of its own resolves too.
> +	 */
> +	supply = regulator_get_optional(pcdev->dev, "vpwr");
> +	if (!IS_ERR(supply)) {
> +		regulator_put(supply);
> +		return 0;
> +	}

[Severity: Medium]
Is there still a window here where the check passes but PI registration
defers?

regulator_put() drops the supply handle right away. Nothing holds the
provider until devm_pse_pi_regulator_register() resolves the supply
again.

That second resolution also runs a check that the consumer-get path used
here skips:

drivers/regulator/core.c:regulator_resolve_supply() {
    ...
	if (r->dev.parent && r->dev.parent != rdev->dev.parent) {
		if (!device_is_bound(r->dev.parent)) {
			put_device(&r->dev);
			ret = -EPROBE_DEFER;
			goto out;
		}
    ...
}

regulator_register() then ignores the result:

		ret = regulator_resolve_supply(rdev);
		if (ret)
			rdev_dbg(rdev,
				 "unable to resolve supply (ignoring): %pe\n",
				 ERR_PTR(ret));

Two cases pass pse_pi_check_supply() here:

- a provider whose rdev is registered but whose probe has not finished,
  for example with async probing or several regulators registered in a
  loop
- a provider that unregisters its rdev after this check, for example
  because its own probe later defers

In both cases pse_controller_register() adds the controller to the list
and fires PSE_REGISTERED. of_pse_control_get() for that PI still returns
-EPROBE_DEFER.

The commit message calls this a narrower, known window. However, the
final phy patch in the series ("net: phy: own phydev->psec via PSE
notifier and remove fwnode_mdio hook") ignores -EPROBE_DEFER and retries
only on PSE_REGISTERED. Its commit message says "the preceding patch
makes sure an already registered controller cannot keep returning it".

Doesn't this window break that guarantee and leave the PHY without its
PSE control when it is hit?

[ ... ]

> @@ -1111,6 +1173,16 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  	 */
>  	reg_name_len = strlen(dev_name(pcdev->dev)) + 18;
>  
> +	/* Check every PI supply before registering any regulator: a provider
> +	 * that has not probed yet is the ordinary -EPROBE_DEFER case, and
> +	 * unwinding it must not leave PI regulators behind.
> +	 */
> +	for (i = 0; i < pcdev->nr_lines; i++) {
> +		ret = pse_pi_check_supply(pcdev, i);
> +		if (ret)
> +			goto release_pis;
> +	}

[Severity: Medium]
Does this new failure exit leak what setup_pi_matrix() has already done?

This loop runs after pcdev->ops->setup_pi_matrix() has succeeded.
release_pis frees only the PI array, the OF node references and the
kfifo.

For pd692x0, pd692x0_setup_pi_matrix() has already done this by the time
of the new deferral point:

pd692x0_register_managers_regulator()
  devm_regulator_bulk_get_enable(&rdev->dev, ...)    /* aux rails on */
pd692x0_req_managers_pw_budget()
  regulator_request_power_budget(supply, pw_budget)  /* claim on vmain */

pw_requested_mW is lowered only by regulator_free_power_budget().
regulator_put() and regulator_unregister() leave it alone.

pd692x0_managers_free_pw_budget() is called only from
setup_pi_matrix()'s own error labels and from pd692x0_i2c_remove(). When
devm_pse_controller_register() fails, pd692x0_i2c_probe() just returns
dev_err_probe().

If pse_pi_check_supply() returns -EPROBE_DEFER here, does the vmain
budget stay claimed by a probe instance that no longer exists?

On the retry, regulator_get_unclaimed_power_budget() would return the
reduced value, or 0. The new instance would then record
manager_pw_budget[i] = 0 and skip SET_POWER_BANK in later
pd692x0_hw_conf_init() calls, for example after a firmware upload.

Later budget requests through vmain, such as those from
pse_pi_update_pw_budget(), could fail with -ERANGE. The aux rails are
also turned on and off on every deferred retry.

The same leak already existed for rarer failures after
setup_pi_matrix(). This patch adds a failure point that can repeat on
every deferred probe.

The commit message says "Doing all the checks before the registration
loop also keeps the common deferral on the unwind path", but that
doesn't cover setup_pi_matrix() side effects.

Moving the check ahead of setup_pi_matrix() doesn't look possible,
because pd692x0 PIs normally take vpwr from manager regulators
registered inside it. Would this need a driver unwind hook, or a
devm-managed release of the budget in pd692x0?

> +
>  	/* Register PI regulators. Once one of these exists, pse_pi_ops index
>  	 * pcdev->pi[] and nothing here can unregister it again, so the array
>  	 * must outlive this function. Failures below therefore unwind to

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927191850.1370515-1-github%40szelinsky.de
