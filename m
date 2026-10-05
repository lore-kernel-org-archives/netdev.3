Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A44FECDD;
	Mon,  5 Oct 2026 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221612; cv=none; b=EoVB4VLfYxqky/dp4/k+I+8FTKCsl3e8a9l3vlacAzsYonsVSjwBZ7B90ZvpgAwXktyXfraQPQ/xq521dNiGl2FQo/mJFJw8pZ2AbLaZjaYagFaEJ8zdD8/lrbN5ChBjpVxMSpTk8RqBq5/pGpIHHm3UQgcM5doAXfS2T5KaZ6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221612; c=relaxed/simple;
	bh=mqYzfIvBXrk96YZ+Xm2JcUulqGz24Ml+FQW94KWbbKw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m9BxZ2IHY3jdezaJU9mpGpDBRDFi5Llcjjhd+EY+RdPG0+lb99Svtd2wuhjKNrFVAZMDBr0v53AwAwuZybbZTz0B6VOsoRETmSX8tvQZnBosUFUFNIiw2NlPH9jCoOsB+wora0PGsqFUV6WQd3qUDJDkCrGq6Ltwxr1A6Zfh3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDQ35PjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDQ35PjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3E41F00893;
	Mon,  5 Oct 2026 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791221610;
	bh=XAWmypQokeqTnRyLPnZ3zNIdC/RJLaNd+9RRnPbQSAQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aDQ35PjIhg1iyY4mAlI0l9cqnhH41+nvxhu5AOksPsFkq63jJGnqprnBN+IZmleft
	 6nQE+gStdrVwL0QJMxLIcd1g4vhw7gaCXvetAfFM9YAML7AluLTpnGRHAGioNGQEOQ
	 vAAM0RkZs/m0byh7Hs9ZTdl8PqA4JLhtOqRwNeW6iG3k/fK11Y5V8GgT6I9zRMQchI
	 548p2emgM7mWncIqAWq/9tp0CGqtMGb+JQuCBEn0frESvmc7wuxqoHu09j9f+lW6kz
	 9/i6cpQDI8XTMPm4ktLCBwb3evuqNoWCJFZqnnIVnH49P4EGpPOqUUl7+2IPJA8wNS
	 PsJdWljhy+pAA==
Subject: Re: [PATCH net-next v8 5/7] net: pse-pd: check the PI vpwr supply
 before registering the controller
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 saravanak@kernel.org, corey@leavitt.info, jelonek.jonas@gmail.com,
 horms@kernel.org, olek2@wp.pl, broonie@kernel.org, lgirdwood@gmail.com,
 netdev-bot+sashiko@kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 17:33:29 +0000
Message-ID: <179122160924.434549.13478805521146010203@kernel.org>
In-Reply-To: <20261004164219.1161294-6-github@szelinsky.de>
References: <20261004164219.1161294-6-github@szelinsky.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The supply pre-check can still pass when the regulator core
  will defer the same PI.
- [Medium] This patch adds an -EPROBE_DEFER exit in
  pse_controller_register() (pse_core.c:1226-1227 and 1238-1240) that…
- [Low] The commit message leaves out a present-day behaviour change.
- [Low] The concern says the commit message relies on an unreachable
  premise: no in-tree consumer retries only on PSE_REGISTERED, and…

--

net: pse-pd: check the PI vpwr supply before registering the controller

pse_controller_register() now checks each PI's vpwr supply after
setup_pi_matrix() and before any PI regulator is registered. A missing
provider therefore makes the PSE driver's own probe defer. Like
regulator_resolve_supply(), the check looks at the PI node first and then
at the controller device.

> That leaves pse_controller_register() completing for a controller whose
> PIs cannot be handed out: regulator_get_exclusive() in
> pse_control_get_internal() resolves the supply itself and returns
> -EPROBE_DEFER until the provider appears, so of_pse_control_get() keeps
> failing for this PI even though the controller is registered. A
> consumer that only retries when a controller registers - which is what
> phylib becomes once it attaches from the PSE notifier - then never gets
> its PI.

[Severity: Low]
This isn't a bug, but the commit message only describes the future
phylib notifier case. It leaves out a change that applies today.

Before this patch, a PI whose vpwr provider was not registered yet when
pse_controller_register() ran got a PI regulator with
rdev->supply == NULL. pse_register_pw_ds() is called only once, and it
skips that PI:

	if (!rdev || !rdev->supply)
		continue;

So pcdev->pi[i].pw_d stayed NULL for good. That disabled budget
evaluation, power allocation and priority for that PI:
pse_pw_d_is_sw_pw_control() returns false, and pse_ethtool_set_prio()
returns -EOPNOTSUPP with "no power domain attached". This happened even
with the current fwnode_mdio consumer, which does get the PI once the
provider appears.

With the new check the controller defers until the supply is there, so
these PIs now get a power domain.

Could the commit message mention this? It matters when deciding on a
Fixes: tag or a stable backport.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index eeefbf25e6716..e560833ad0340 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -860,6 +861,98 @@ static const struct regulator_ops pse_pi_ops = {

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
Can this check pass while the PI regulator registration still defers its
supply?

of_regulator_get_optional() here, and regulator_get_optional() in
pse_controller_check_supply(), both go through _regulator_get_common().
That path never checks whether the provider's parent device is bound.
The resolution done when the PI regulator is registered does check it:

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

Consider a PSE probe that overlaps the probe of an external vpwr
provider. The provider has called regulator_register() but
driver_bound() has not run yet, or the provider later fails its probe
and unregisters. This check then returns 0, and the PI regulators
register with rdev->supply == NULL. PSE_REGISTERED then fires, and
of_pse_control_get()->regulator_get_exclusive() returns -EPROBE_DEFER
for that PI.

Later in the series, "net: phy: own phydev->psec via PSE notifier and
remove fwnode_mdio hook" makes phylib retry only on PSE_REGISTERED.
Wouldn't phylib then miss this PI until the next PSE_REGISTERED or a PHY
re-registration? Later patches in the series do not change these check
functions.

The commit message mentions this window, but not a second effect that
does not go away on its own. pse_register_pw_ds() is called only once,
from pse_controller_register(), and skips a PI whose supply is not
resolved:

	if (!rdev || !rdev->supply)
		continue;

Does pcdev->pi[i].pw_d then stay NULL for that PI even after the
regulator core resolves the supply later? Budget, power allocation and
priority handling would stay off until the controller is re-bound.

The tps23881 and si3474 bindings put vpwr-supply in the pse-pi nodes.
As the commit message notes, that only creates a SYNC_STATE_ONLY
fw_devlink link, which does not hold back the controller's probe. Async
probing or module loads on different CPUs could reach this.

[ ... ]

> @@ -1116,6 +1210,38 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  			goto release_pis;
>  	}
>  
> +	/* Check every PI supply before any regulator of ours is registered:

[ ... ]

> +	for (i = 0; i < pcdev->nr_lines; i++) {
> +		ret = pse_pi_check_supply(pcdev, i);
> +		if (ret < 0)
> +			goto release_pis;

[Severity: Medium]
Does this new -EPROBE_DEFER exit leak the pd692x0 power budget claimed on
the vmain regulator?

This exit, and the one after pse_controller_check_supply(), run after
pcdev->ops->setup_pi_matrix(). On pd692x0, setup_pi_matrix() has already
done two things that release_pis does not undo:

pd692x0_setup_pi_matrix()
  pd692x0_req_managers_pw_budget()
    regulator_request_power_budget(supply, pw_budget)

Also, when !priv->cfg_saved, it programs the MCU power bank and port
matrix and saves the user byte.

The budget is released only from setup_pi_matrix()'s own error labels or
from pd692x0_i2c_remove(). pd692x0_i2c_probe() just returns the error:

	ret = devm_pse_controller_register(dev, &priv->pcdev);
	if (ret)
		return dev_err_probe(dev, ret,

Regulator put and unregister do not lower rdev->pw_requested_mW; only
regulator_free_power_budget() does. So each deferred retry adds another
claim on vmain.

Suppose vmain has regulator-power-budget-milliwatt set. On retry,
regulator_get_unclaimed_power_budget() returns 0, so manager_pw_budget[i]
stays 0. cfg_saved is now true, so the MCU is not reprogrammed and keeps
the first attempt's budget, and the driver and hardware disagree. With
PSE_BUDGET_EVAL_STRAT_DYNAMIC, could enabling any PI whose supply chains
through a manager to vmain then fail with -ERANGE in
regulator_request_power_budget()?

The documented binding points each pse-pi vpwr-supply at the driver's
own manager regulators, so it does not hit this. The schema does not
restrict the phandle target, though. A pd692x0 board with one PI on an
external provider that has not probed yet would hit this on every retry.

The commit message acknowledges this and leaves the cleanup to the
driver. This patch adds a deferral at this point that is retried by
design. Should the pd692x0 budget cleanup come with it in this series?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004164219.1161294-1-github%40szelinsky.de
