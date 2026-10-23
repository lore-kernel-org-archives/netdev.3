Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743220;
	b=TqC5sprhXXVWzXetJnGEI6stAnE8Ep3ZCNtBgs6A1yrtODrS2b+MvpIgRHnbGbtsIHH3
	 IGa5a3tx3YHRi3dKAdaA0LFaylJpJEyXyFQRYuzTM5+mq4JENDNhUV4GXw73xsNcjL0h3
	 bUiexNI+vuRgthlLd174lPhrSot2d10KLpcjtHfV8+aDVmziIup/swnD8JdxChTH2X6L6
	 QVbG3144f0kNS1XpWQlgPwk9TNr0UyENnz06Xu8gIpqEmGDDi5tFEuds39sejABebvRWn
	 pE2jEpN1t//xgZ5XIJ162a11P9jepoU+T55lW6WLdtD7YCoLGT1JERKRV8T+6FTZFlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743220;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=27SXA+vmEGuB/iEyIhBUtt3xXLRW8UU2/MI+0coluyY=;
	b=IP0EpbnDmX2ULNxiqqw1OXiU5xdYElIKlBOpyYMefPuoiCRBOl/rGJzElDKU9vhcCHsl
	 qrr7Pc4UP/9zyzPrAmKtO7u3sWoLONiq44l7tn5FsbfFqKQ0o4AVl6t56iUasJC7IfZcj
	 FRl40r5M4j2d3HjQs0Uk8JT16W0wuuhiCf7RhHAYDsiVS7r9SnjpqKUqpadxBi30Z0V0F
	 EeA+DAC1NOogfSPdzhzN1XhbpBJVj/fuuYciTh+vcFEkq09kPaDX/5A5Ryohaglhk7RnH
	 GaOPKOLSsng4iKPTQl3m1fEIhPRyVZY4H/FLCWgjrfpPiVYTHEynD8BSL9Ql/MxfS+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqK7yQj4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09431606A33C;
	Fri, 23 Oct 2026 08:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cqK7yQj4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E972D1F031E5;
	Fri, 23 Oct 2026 08:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743219;
	bh=27SXA+vmEGuB/iEyIhBUtt3xXLRW8UU2/MI+0coluyY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cqK7yQj4UCJaAbbQleOvboM7kEt7dB+RBWAU/xf4tVlEfNfIhrAJBMODPCG7PZrR0
	 83jKIxTDFqSQ+7p3HcSgHql079xOvmEP7WaQn1+6NmMSZ2I6jZjfTf+3y/e1YZZRqE
	 qmPV+4DDWC2Pe//vbVlEQxNIc6ggTUSlE19O/46KoxhwequqJdyY+86OP5P7/8fu/0
	 S0/UD+d0h6S9S7ijifdgDl9txFFqFt3ML2efNjjdakaP+14SxSyEzXHiCbaYc2HOKi
	 +ycyi03f3vhoCBl3P1kxLBPKd8SRg37xdFAb4fxY2+L587ePqx5K46GHx71dtGr5Uu
	 nPfz0bcdjZwBA==
Subject: Re: [PATCH net v2 10/14] net: pse-pd: keep the PI data until the PI
 regulators are gone
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kyle.swenson@est.tech, ross@r-sc.ca,
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 08:13:38 +0000
Message-ID: <179274321851.3134.15617739337399120885@kernel.org>
In-Reply-To: <20261020171249.853085-11-github@szelinsky.de>
References: <20261020171249.853085-11-github@szelinsky.de>
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

- [High] New AB-BA deadlock between controller unbind and a concurrent
  consumer regulator_enable()/regulator_disable() on a PI.
- [Medium] If pi_disable() fails during unbind, the budget kept on the
  supply can never be given back.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch does
  not fix it either.
- [Low] pse_controller_register() returns without kfifo_free() on every
  failure after kfifo_alloc() (missing callbacks, of_load_pse_pis(), the…

--

net: pse-pd: keep the PI data until the PI regulators are gone

This patch moves the free of the PSE PI array into a devm action that is
registered before the PI regulators, so the regulator ops no longer read
freed memory during unbind. It adds a pcdev->unregistering flag, and once
unregistration starts the PI enable paths fail with -ENODEV. It also makes
pse_flush_pw_ds() switch off each PI that holds power budget and give that
budget back to the supply.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index f266cc24f6a27..63217a4808e3f 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -884,6 +901,27 @@ static void __pse_pw_d_release(struct kref *kref)
>  	kfree(pw_d);
>  }
>  
> +/* A PI that holds budget is under software power control, and nothing
> + * controls it once its controller is gone: switch it off, then give the
> + * budget back. If it cannot be switched off, keep the budget reserved,
> + * as the PI may still draw it.
> + */
> +static void pse_pi_power_off(struct pse_controller_dev *pcdev, int id)
> +{
> +	int ret;
> +
> +	if (!pcdev->pi[id].pw_allocated_mW)
> +		return;
> +
> +	ret = pcdev->ops->pi_disable ? pcdev->ops->pi_disable(pcdev, id) :
> +				       -EOPNOTSUPP;
> +	if (ret) {
> +		dev_warn(pcdev->dev, "PI %d: cannot switch off: %d\n", id, ret);
> +		return;
> +	}

[Severity: Medium]
If pi_disable() fails here, can anything release this budget later?

pse_flush_pw_ds() clears pw_d right after this returns, whether or not the
switch-off worked:

	pse_pi_power_off(pcdev, i);
	pw_d = pcdev->pi[i].pw_d;
	pcdev->pi[i].pw_d = NULL;

After that, pse_pi_deallocate_pw_budget() always returns early:

	if (!pi->pw_d || !pi->pw_allocated_mW)
		return;

So neither a later successful _pse_pi_disable() nor a rebind gives the
budget back to the supply. regulator_put() does not touch
pw_requested_mW either.

Also, is "the PI may still draw it" true for tps23881?
tps23881_pi_disable() first writes PWOFF to TPS23881_REG_PW_EN. Only after
that does it do several I2C read-modify-writes (DISC_EN, DET_CLA_EN,
power policy). If any of those fails, it returns an error even though the
port is already unpowered.

pse_pi_take_pw_d() still handles it the same way at the end of the series.

> +	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);
> +}
> +
>  /**
>   * pse_flush_pw_ds - flush all PSE power domains of a PSE
>   * @pcdev: a pointer to the initialized PSE controller device
> @@ -899,6 +937,7 @@ static void pse_flush_pw_ds(struct pse_controller_dev *pcdev)
>  		 * use it.
>  		 */
>  		mutex_lock(&pcdev->lock);
> +		pse_pi_power_off(pcdev, i);
>  		pw_d = pcdev->pi[i].pw_d;
>  		pcdev->pi[i].pw_d = NULL;
>  		mutex_unlock(&pcdev->lock);

[Severity: High]
Can this deadlock with a consumer that calls regulator_disable() on the
same PI?

When a PI has pw_allocated_mW set, this takes the supply regulator lock
while pcdev->lock is held:

pse_flush_pw_ds()
  mutex_lock(&pcdev->lock)
  pse_pi_power_off()
    pse_pi_deallocate_pw_budget()
      regulator_free_power_budget(pi->pw_d->supply, ...)
        regulator_lock(rdev)

The regulator core takes the same locks in the other order. One example
is an ethtool admin disable, which runs with rtnl held:

pse_ethtool_c33_set_config()
  regulator_disable(psec->ps)
    regulator_lock_dependent()
      regulator_lock_recursive()   /* PI rdev, then supply rdev */
    _regulator_disable()
      pse_pi_disable()
        mutex_lock(&pcdev->lock)

Suppose the ethtool task holds the PI and supply rdev locks and waits on
pcdev->lock, while the unbind holds pcdev->lock and waits in
regulator_lock() for the supply rdev. Then neither task can make
progress. regulator_lock() passes a NULL ww_acquire_ctx, so there is no
-EDEADLK back-off, and the ethtool task keeps holding rtnl.

pse_controller_unregister() does not remove the PHY's pse_control, so
this consumer call can run during the unbind. __pse_control_release()
on PHY removal also calls regulator_disable().

pse_isr() and pse_pi_update_pw_budget() already take these locks in this
order, but this adds a new case on the teardown path. At the end of the
series pse_pi_take_pw_d() still calls pse_pi_power_off() under
pcdev->lock, and the supply handle it uses is the same supply rdev.

> @@ -1088,6 +1127,13 @@ int pse_controller_register(struct pse_controller_dev *pcdev)
>  	if (ret)
>  		return ret;
>  
> +	/* The PI regulator ops use pcdev->pi until devres unregisters the
> +	 * regulators, so free it from devres too, after them.
> +	 */
> +	ret = devm_add_action_or_reset(pcdev->dev, devm_pse_release_pis, pcdev);
> +	if (ret)
> +		return ret;

[Severity: Low]
This is a pre-existing issue, but this new return skips
kfifo_free(&pcdev->ntf_fifo), as do the other error returns after
kfifo_alloc() in pse_controller_register(). devm_pse_controller_register()
does not call pse_controller_unregister() when registration fails. Does
that leak the ntf_fifo buffer on every probe failure, including
-EPROBE_DEFER retries?

This seems to be fixed later in the series by "net: pse-pd: unwind
allocations when controller registration fails", where every error path
goes to free_kfifo.

[ ... ]

> @@ -1152,7 +1205,6 @@ void pse_controller_unregister(struct pse_controller_dev *pcdev)
>  	mutex_unlock(&pse_list_mutex);
>  	cancel_work_sync(&pcdev->ntf_work);
>  	pse_flush_pw_ds(pcdev);
> -	pse_release_pis(pcdev);
>  	kfifo_free(&pcdev->ntf_fifo);
>  }

[Severity: High]
This isn't a bug introduced by this patch, and the patch doesn't fix it
either: pse_control objects that a PHY still holds after the controller
unbinds.

pse_controller_unregister() only takes pcdev off pse_controller_list. It
never walks pcdev->pse_control_head, so each psec keeps its psec->pcdev
pointer.

After the unbind, devres frees pcdev->pi through devm_pse_release_pis().
It also frees the driver private data that contains pcdev. The psec is
only dropped later, in phy_device_remove()->pse_control_put().

Can a later ETHTOOL_MSG_PSE_GET then access freed memory? That command
has no admin permission flag, and it reaches:

pse_get_pse_attributes()
  pse_ethtool_get_status()
    pi = &pcdev->pi[psec->id];
    mutex_lock(&pcdev->lock);

It then calls ops function pointers loaded from the freed pcdev.

Removing the PHY later has the same problem. __pse_control_release()
reads psec->pcdev->pi[psec->id].admin_state_enabled and calls
regulator_disable()/regulator_put() on a regulator whose rdev has
already been unregistered.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020171249.853085-1-github%40szelinsky.de
