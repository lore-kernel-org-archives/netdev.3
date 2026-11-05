Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873319;
	b=PdmLJcgcfHVIa2EyCGipfGTEe81pk6fln4syTQsOLAK2M5G3pLb3sYt57KvM2pK6TbUC
	 sKJ7aocBI4cR1YBGQdbVSbHnByIKOoxEZKr2Fe38KSaN1jbcEnMS5tqs5nTPOp60yfG9U
	 RmNK2d/h5IsUFPZCFX1RfpNzgCZ0qtny+5tHtPl9ctYDyIh/q7Vmhxxfp+ggSr1niu6Tn
	 DwAXXxjZCzx9ZO8jNXxbDrtC51i38SIOPV3SKaJNXpbIbygIP0KapnTnQYDYqpEmu2LS6
	 W1L3LgWr9vxwg3DJo8X3Ra7ez42Lc3ZXA7phsNCAwv+Ue37M2Z2GRgty2dL97Uyjtwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873319;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=OdwrZcbYsRV+5ZTU+xWngMpTg+lnAb5qG+LNLsQLWls=;
	b=ebh/W0iZj4kNtjnvPv2o3//yvQliLqZvezIvyLYeqFzyt5gXPinybfGH10oZR5m4nnji
	 e8PNqtYOYoVfneKEpBN9saxS2w5X0g68oCsM2usQXWAPqJ3vJKq2fLL9TaGwIu1JOkpTW
	 Z3OZyzQ6bG+cVjXCENTQxlaTcD62Ps0PIH/NNewChrzLrpMthixAAJB95gBEidNTBlg7H
	 +wQjiqzheapJLm7Dtxd86b19pgFPe7H4/Fwfsg3CpBGez5ivcKbzneKi2PqNGE8jLddU9
	 f8t8k/ojMzpT4dQmOtdK0K7qv0yalyVfNDVhoaChZP83g60Uju+AJ0N9DZ7BMoeX46g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Puam2CQm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B16083638;
	Thu,  5 Nov 2026 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Puam2CQm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABA01F00919;
	Thu,  5 Nov 2026 10:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793873318;
	bh=OdwrZcbYsRV+5ZTU+xWngMpTg+lnAb5qG+LNLsQLWls=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Puam2CQmtzryM1xU82tRqOD1E1mcOY3rTPDXuSj8qPWbbkJyU5uMsTnPToxZqBSlW
	 slJX+9JS0SlYtuMfwbeZTNkPwrOEsrO3VGkNEupST7gsDHxOEZ+JeW52XZGbIUiEXK
	 6ZRJGD0P7xXWR4DTqpvRyBgRYoC86CWYklBviNodkKBa+9zXGCXnl4i1OoPXc/F1RJ
	 I+BBHuzI3apMazWYa4LqaIifo+ON3ETggmGmriRGb7B9dF0lkbKHrzCO34eXCGYQlj
	 vqtaekfBz+sZdGa7kyjjhjgRnoHwJMmMyPOZOH4Wfm3qwM8fr2UPrP6HMjQ7hiWtoP
	 jJLjX8BVz/5Ug==
Subject: Re: [PATCH net v3 10/14] net: pse-pd: keep the PI data until the PI
 regulators are gone
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
 maxime.chevallier@bootlin.com, kyle.swenson@est.tech, ross@r-sc.ca,
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 05 Nov 2026 10:08:37 +0000
Message-ID: <179387331728.488856.8945406807366704385@kernel.org>
In-Reply-To: <20261103220217.1131971-11-github@szelinsky.de>
References: <20261103220217.1131971-11-github@szelinsky.de>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch frees pcdev->pi from a devm action.
- [Low] The commit message has only 'Fixes: d83e13761d5b' and does not
  mention that the fix depends on two earlier patches in the series:…

--

net: pse-pd: keep the PI data until the PI regulators are gone

This patch stops freeing the PSE PI array in pse_controller_unregister().
The array is now freed from a devm action that is registered before the
PI regulators, so devres frees it after the regulators are unregistered.
This also fixes a leak of the PI array when registration fails.

> Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE framework")

[Severity: Low]

Should the commit message say that this patch depends on two earlier
patches in the series?

  "net: pse-pd: do not tie a shared power domain to its creator's devres"
  "net: pse-pd: stop async event sources before freeing PI data in
  unregister"

On the baseline, pse_flush_pw_ds() does not clear pcdev->pi[i].pw_d. The
domain is allocated with devm_kzalloc() in pse_register_pw_ds(), and that
runs after the PI regulators are registered. So devres frees the domain
before it unregisters the regulators.

Suppose this patch is backported without the power domain patch. The
reproducer in the message would then still go through:

pse_pi_is_enabled()
  pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d)

It would read pw_d->budget_eval_strategy from freed devm memory, so the
use-after-free would just move from pi[] to pi[].pw_d.

The unregistering gate has the same kind of dependency. Without it, a
consumer enable after unregister would get past the pi[] access and into
pse_disable_pi_pol(). That function uses the kfifo and the work item,
and unregister has already torn both down.

Both prerequisites have their own Fixes tags (50f8b341d268 and
ffef61d6d273), so this only matters for a partial stable backport.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index 43f6e304fe5e6..eccbdb3acbee8 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -1123,6 +1128,13 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  	if (ret)
>  		return ret;
>  
> +	/* The PI regulator ops use pcdev->pi until devres unregisters the
> +	 * regulators, so free it from devres too, after them.
> +	 */
> +	ret = devm_add_action_or_reset(pcdev->dev, devm_pse_release_pis, pcdev);
> +	if (ret)
> +		return ret;
> +

[Severity: High]

Does this devres ordering cover the case where a consumer enables or
disables the PI, which the commit message also mentions?

regulator_unregister() does not take the rdev lock and does not wait for
consumer calls that are already running. If consumers still hold handles,
it only does WARN_ON(rdev->open_count).

pse_control_get_internal() takes the PSE consumer handle with the
non-devm regulator_get_exclusive():

    psec->ps = regulator_get_exclusive(pcdev->dev,
                       rdev_get_name(pcdev->pi[index].rdev));

The PHY only drops that handle in phy_device_remove()->pse_control_put().
pse_controller_unregister() never walks pcdev->pse_control_head, so these
handles survive the controller unbind.

I can see two ways to hit this. The first is a consumer disable racing
with the unbind:

CPU0 (for example ethtool PSE admin-disable)
pse_ethtool_set_config()
  regulator_disable(psec->ps)
    pse_pi_disable()
      pi = &pcdev->pi[id];
      mutex_lock(&pcdev->lock);
      _pse_pi_disable()
        ops->pi_disable()   /* sleeps on I2C */

CPU1 (unbind)
devres release
  regulator_unregister()
  devm_pse_release_pis()
    kfree(pcdev->pi)        /* without pcdev->lock */
  frees the driver priv that embeds pcdev

When CPU0 returns from ops->pi_disable(), it runs:

      pi->admin_state_enabled = 0;
      mutex_unlock(&pcdev->lock);

Would that write into freed memory? pse_pi_disable() has no
pcdev->unregistering check.

The second needs no race. If the PHY is removed after the controller has
unbound, __pse_control_release() runs:

    if (psec->pcdev->pi[psec->id].admin_state_enabled)
        regulator_disable(psec->ps);

That reads the freed pi array through the freed pcdev. regulator_disable()
then reaches pse_pi_disable(), which uses the same freed data.

pcdev itself is freed in the same teardown. Can any ordering of the PI
array free close these paths? Would the existing pse_control objects have
to be revoked in pse_controller_unregister(), or pcdev refcounted, before
the consumer case is fixed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103220217.1131971-1-github%40szelinsky.de
