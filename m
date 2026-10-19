Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792435323;
	b=O3B8a4bKkJHwcu9U3DElMs8ambcVKypVrPRVrIwFU7YWuHlkc0FDvuXJP4v1zcq3bMr/
	 RtLaddkhAPEUPMdJeiu1Vlfqqe7IvVq20NaNdBRaS57EsvGWldy5kVvGCZDMNnYVYy/6R
	 Je9WZi5ydBecpTKXKIN6FRCXNaJ7+eIs/eczRJUcdRvwPjq8o35Sg2+dt+9+YMxlk0hvl
	 NrMKXKNJKMRCJuoBZTasRF9hWXqrWHAEeVcjViKKj+l9oYxjRnoBCX2uq91RgZDQ6Jhyh
	 p9EdkyxxYEaPbISsLj8CGUxsh1Cnx0EvW8k/usvnjTeCg6xNSq0YMGDjLIJ0BlANs3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435323;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DBaYILr5yPrj7vHaTN/bXGKctCfgNdn8sIt81WZsMvE=;
	b=rAFzHddIc4dPHrb4zrbPj1Notj6O806NHN5iUAO1PLlvIfW4FYsw9WgkpCpichywttcB
	 kCDx3DkSKvLEvioPgb/SLaJXHfWC6oxTcc6bi9JssYibRIP/stSRURuFEVqu/wd6miAFP
	 t0XRSs+es1KZZEukRovRfbdQ55phN4qutSfAwXaqe5L8MlD5i9eyqSKReMKkDMSe+YHWx
	 77Cv7RKrry17eFsYtWmpi47Vr1sf2b9W/LDhdjFc8O8IZ9XkLcRny4UmWNvQ3Rux1OAc+
	 KUNXKijL8lUehC36IdudQtxG5VcISvWIXRBdRs+jwhDkhF14a8V2JN2QHnvenxpg+eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUffoNsL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D446606A319;
	Mon, 19 Oct 2026 18:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUffoNsL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA5E1F000C4;
	Mon, 19 Oct 2026 18:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792435322;
	bh=DBaYILr5yPrj7vHaTN/bXGKctCfgNdn8sIt81WZsMvE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FUffoNsLPX/alWwlHjQ1RwdBORgG+Y+vBGUEZkLwRpVIt8EwBVWeKfEdt4KW/rRYp
	 8kWbd8b9PhDBJlIdI9d3uchDLxTtn3KtHTxqL0wUBIohpZtxpiVDATF1jDPN2En13+
	 7i6D5CXdBIBGo1n93fUaE83qCbQ/kK+7gSXZU/vCWztyOxRc2qerLkn5HAWIUMJZnJ
	 IkJUBcg/YYD9syn4c8n+6AVfIVPGEVTRqe65x7vZ7nvyD0L/RiCz5Pbwy3IJcebtSV
	 lPiBfA//tLOpYQ1AvbdWE7o3sZvyj66Jr8sjT2Tns9BzrTKGyvWg3BDItZOfIXb/LD
	 Z393D8EBN+N5Q==
Subject:
 Re: [PATCH net] net: pse-pd: don't enable a PI again while disabling it
From: netdev-bot+sashiko@kernel.org
To: ross@r-sc.ca
Cc: netdev@vger.kernel.org, o.rempel@pengutronix.de, kory.maincent@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 18:42:01 +0000
Message-ID: <179243532177.3135.6604862508015344848@kernel.org>
In-Reply-To: <20261018182005.1193-1-ross@r-sc.ca>
References: <20261018182005.1193-1-ross@r-sc.ca>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (5) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch removes the power-domain retry from
  pse_disable_pi_pol().

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  pse_pi_disable() drops the error from _pse_pi_disable() and always…
- [Medium] This problem wasn't introduced by this patch, but in the
  DISCONNECTION branch of pse_set_config_isr() isr_pd_detected is…
- [Medium] This problem wasn't introduced by this patch, but
  pse_pi_is_admin_enable_pending() returns false only when…
- [Medium] This problem wasn't introduced by this patch, but
  pse_set_config_isr() starts with 'if (notifs &…
- [Medium] This problem wasn't introduced by this patch, but
  pse_ethtool_set_pw_limit() reads admin_state_enabled and…
- [Low] This problem wasn't introduced by this patch, but in
  pse_pw_d_retry_power_delivery() the variable 'int prio_max =…

--

net: pse-pd: don't enable a PI again while disabling it

This patch splits _pse_pi_disable() in two. __pse_pi_disable() disables
the PI and frees its budget, and _pse_pi_disable() also retries power
delivery in the power domain. Admin state and PD detection are now cleared
before _pse_pi_disable() runs, and pse_disable_pi_pol() no longer retries
the power domain.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index a5e6d7b26b9fd..b46e3a13a3108 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> +static int _pse_pi_disable(struct pse_controller_dev *pcdev, int id)
> +{
> +	int ret;
> +
> +	ret = __pse_pi_disable(pcdev, id);
> +	if (ret)
> +		return ret;
> +
>  	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d))
>  		pse_pw_d_retry_power_delivery(pcdev, pcdev->pi[id].pw_d);

[Severity: Medium]
This is a pre-existing issue, but pse_pi_is_admin_enable_pending() only
treats a PI as not pending when pse_pi_is_hw_enabled() returns exactly 1:

	ret = pse_pi_is_hw_enabled(pcdev, id);
	/* PSE PI is already enabled at hardware level */
	if (ret == 1)
		return false;

	return true;

If ops->pi_get_admin_state() fails, a negative error is treated as
pending. One example is a failed i2c_smbus_read_word_data() of
TPS23881_REG_PW_STATUS in tps23881_pi_get_admin_state().

Can the retry loop then call _pse_pi_delivery_power_sw_pw_ctrl() on a PI
that is already powered? That would request its budget a second time.
pse_pi_allocate_pw_budget_static_prio() then overwrites
pi->pw_allocated_mW, which leaks the earlier allocation.

[Severity: Low]
This isn't a bug introduced by this patch, but in
pse_pw_d_retry_power_delivery() prio_max is declared inside the loop body:

	for (i = 0; i < pcdev->nr_lines; i++) {
		int prio_max = pcdev->nr_lines;
		...
		if (pcdev->pi[i].prio > prio_max)
			continue;

		ret = _pse_pi_delivery_power_sw_pw_ctrl(pcdev, i, &extack);
		if (ret == -ERANGE)
			prio_max = pcdev->pi[i].prio;
	}

The value saved after -ERANGE is lost on the next iteration. For the
static strategy, pse_ethtool_set_prio() rejects prio >= nr_lines, so can
the prio > prio_max check ever be true?

The comment "Do not try to enable PI with a lower prio (higher value)
than one which already can't be enabled" describes a cut-off that never
seems to happen. Should prio_max be declared outside the loop?

[ ... ]

> @@ -490,7 +513,10 @@ static int pse_disable_pi_pol(struct pse_controller_dev *pcdev, int id)
>  
>  	dev_dbg(pcdev->dev, "Disabling PI %d to free power budget\n", id);
>  
> -	ret = _pse_pi_disable(pcdev, id);
> +	/* The power freed is for the PI being allocated, and this PI waits
> +	 * for power again: no retry of the power domain here.
> +	 */
> +	ret = __pse_pi_disable(pcdev, id);

[Severity: High]
With the retry removed here, what powers the evicted PI back on when the
allocation that evicted it doesn't use all of the freed budget?

The evicted PI is left with admin_state_enabled = 1 and
isr_pd_detected = true, but it is off in hardware with
pw_allocated_mW = 0. pse_pw_d_retry_power_delivery() is only called from
_pse_pi_disable() and pse_ethtool_set_prio(). Nothing retries the domain
after the outer allocation finishes.

There seem to be two ways to get there. First,
pse_pi_allocate_pw_budget_static_prio() can return -ERANGE after it has
already turned off lower-priority PIs:

	while (regulator_request_power_budget(pi->pw_d->supply, pw_req) == -ERANGE) {
		if (_prio <= pi->prio) {
			...
			return -ERANGE;
		}

		ret = pse_disable_pi_prio(pcdev, pi->pw_d, _prio);
		...
		_prio--;
	}

For example, take a 60 W budget with H0 (prio 0) holding 30 W and L1
(prio 1) holding 30 W. A new prio 0 PD H2 asks for 40 W. L1 is turned off
and 30 W is freed, but the request still fails. L1 then stays off while
30 W is unused.

Second, pse_disable_pi_prio() turns off every hardware-enabled PI at a
priority level, not just as many as the request needs. With two prio 1
PIs at 30 W each and a 30 W prio 0 request, both prio 1 PIs go off. One
30 W share stays free, and neither PI is powered again.

The callers don't retry afterwards either. The CLASSIFICATION path of
pse_set_config_isr() and pse_pi_enable() both turn -ERANGE into success.
_pse_pi_delivery_power_sw_pw_ctrl() returns without a retry on both
success and failure.

Given this, is the new comment accurate? The commit message also says:

  That PI stays waiting for power and is retried when budget is freed
  later.

In these cases the budget may already be free. The evicted PIs only come
back after an unrelated event, such as an admin disable or unplug of
another PI in the domain, or pse_ethtool_set_prio().

TPS23881 may recover by chance, because tps23881_pi_disable() re-arms
detection and classification. The core doesn't require pi_disable to do
that, so other controllers might not recover. The RTL8239 driver named
in the commit message is one example.

Could the domain retry be deferred until the outer allocation finishes,
or could the evictions be undone when the allocation fails?

[ ... ]

> @@ -703,14 +729,18 @@ static int pse_pi_disable(struct regulator_dev *rdev)
>  {
>  	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
>  	struct pse_pi *pi;
> +	bool enabled;
>  	int id, ret;
>  
>  	id = rdev_get_id(rdev);
>  	pi = &pcdev->pi[id];
>  	mutex_lock(&pcdev->lock);
> +	/* Disabled before _pse_pi_disable() retries the power domain */
> +	enabled = pi->admin_state_enabled;
> +	pi->admin_state_enabled = 0;
>  	ret = _pse_pi_disable(pcdev, id);
> -	if (!ret)
> -		pi->admin_state_enabled = 0;
> +	if (ret)
> +		pi->admin_state_enabled = enabled;
>  
>  	mutex_unlock(&pcdev->lock);
>  	return 0;

[Severity: Medium]
This is a pre-existing issue, but pse_pi_disable() still returns 0 when
_pse_pi_disable() fails. admin_state_enabled is restored on error, yet
the regulator core sees success. _regulator_disable() then drops
rdev->use_count and the consumer's enable_count.

If ops->pi_disable() fails, can the PSE state and the regulator state
get out of sync? An I2C write error in tps23881_pi_disable() would do it.

A later admin enable in pse_ethtool_c33_set_config() does nothing,
because admin_state_enabled is still 1. A later admin disable goes
through:

	case ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED:
		if (psec->pcdev->pi[psec->id].admin_state_enabled)
			err = regulator_disable(psec->ps);

and hits this in _regulator_disable():

	if (WARN(regulator->enable_count == 0,
		 "unbalanced disables for %s\n", rdev_get_name(rdev)))
		return -EIO;

Should pse_pi_disable() return ret here?

> @@ -1229,10 +1259,12 @@ static int pse_set_config_isr(struct pse_controller_dev *pcdev, int id,
>  				ret = 0;
>  		}

[Severity: Medium]
This isn't a bug introduced by this patch, but pse_set_config_isr()
starts with:

	if (notifs & PSE_BUDGET_EVAL_STRAT_DYNAMIC)
		return 0;

PSE_BUDGET_EVAL_STRAT_DYNAMIC is a budget strategy value (1 << 2), not
an event mask. It has the same value as ETHTOOL_C33_PSE_EVENT_DETECTION
(4). tps23881_set_notifs_helper() ORs events together, so detection and
classification can arrive in the same notification.

Does a DETECTION | CLASSIFICATION notification return early here? That
would skip setting isr_pd_detected and skip power delivery for that PD
in the classification branch.

>  	} else if (notifs & ETHTOOL_C33_PSE_EVENT_DISCONNECTION) {
> -		if (pcdev->pi[id].admin_state_enabled &&
> -		    pcdev->pi[id].isr_pd_detected)
> -			ret = _pse_pi_disable(pcdev, id);
> +		bool pd_detected = pcdev->pi[id].isr_pd_detected;
> +
> +		/* Gone before _pse_pi_disable() retries the power domain */
>  		pcdev->pi[id].isr_pd_detected = false;
> +		if (pcdev->pi[id].admin_state_enabled && pd_detected)
> +			ret = _pse_pi_disable(pcdev, id);

[Severity: Medium]
This is a pre-existing issue, but isr_pd_detected is cleared here
whatever _pse_pi_disable() returns. If ops->pi_disable() fails,
__pse_pi_disable() returns before it calls pse_pi_deallocate_pw_budget().
pi->pw_allocated_mW then stays non-zero while isr_pd_detected is false.

A later DISCONNECTION skips the disable. The next CLASSIFICATION goes
through
_pse_pi_delivery_power_sw_pw_ctrl()->pse_pi_allocate_pw_budget_static_prio(),
which does:

	pi->pw_allocated_mW = pw_req;

without freeing the old allocation. Is that budget lost from the supply
for good?

Simply restoring isr_pd_detected on error would let the retry re-enable
the empty port. The fix may belong in how pw_allocated_mW is tracked
instead.

[Severity: Medium]
This is a pre-existing issue, but pse_ethtool_set_pw_limit() checks
admin_state_enabled and isr_pd_detected without holding pcdev->lock:

	    psec->pcdev->pi[psec->id].admin_state_enabled &&
	    psec->pcdev->pi[psec->id].isr_pd_detected) {
		ret = pse_pi_update_pw_budget(psec->pcdev, psec->id,
					      pw_limit, extack);

pse_pi_update_pw_budget() takes the lock but doesn't check them again.
Can an ethtool power limit change race with this disconnection path?

CPU1
pse_ethtool_set_pw_limit()
    sees admin_state_enabled && isr_pd_detected

CPU2
pse_isr()->pse_set_config_isr()
    isr_pd_detected = false
    _pse_pi_disable()
        pw_allocated_mW = 0

CPU1
pse_pi_update_pw_budget()
    pw_diff = pw_req - 0
    regulator_request_power_budget() for the empty port

Later disconnections do nothing, because isr_pd_detected is already
false. The next classification overwrites pw_allocated_mW in
pse_pi_allocate_pw_budget_static_prio(). Would that requested budget
leak?

>  	}
>  
>  	return ret;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018182005.1193-1-ross%40r-sc.ca
