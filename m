Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663737;
	b=ctB8H1/ki0HfIJ0ZBSYPapskVvXUmEfq0i4BV/fC9vL/RDIi3ktKh+SC/+XLNfbRozS/
	 4y3SLZgHKpeuz0Tfe40DCIoNUDBdUjFvMBAVYIGExCJtqycQfM/aaVCuqZtXy2EjWydKg
	 q89u0YZ8q6DoMhDG+uZzlRdDsOpAbvggB3J2JMnl+b2RNMprI0qRuDHHqLbwVIw6e3ZsZ
	 S+1JZnDAdF3pTlQGn9lV+vJGtULaAbLd7VBq8hYj+PvefL5YQeBLbB+PWrwRLreYPLx1x
	 4asF4srpgxov3StjUz3K90Rj00GZPzBSuruylwgdPNK0kRqBOvlFZLRusic1l/4iRkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663737;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zoTTxBF60ZcKsSjl7de0FhmB0fx7cpHitLamAY8HR6E=;
	b=qNRltO8AOJ4uFhpImdE8vP9QjqUxhGbSoEXzpwJ4kSlD2BL5gTkvl0zRuY9Xhs7u4dmk
	 FNuDCxJ1ZEtFnd26KsgzSaMQG+efW1txsvKL/zjvjNCPrgaAi86YE26va3qLoBI5X+XAC
	 Zgtc4wdh+0nLlAyEMu53+mOxfSQ+YqKwkOVn5GfNmKjWl3WZA8nYAZVANvIXgFVDHD8cP
	 F3tqjM+c5wnHtaMZI3R5wuPqIV6yjwdSyUh4iMRwsW3LjTq2nMhBkgrbzhXYXwcD28Et6
	 HnbUtpHLA9eqBaG1lHXMY/UYwA3a0iffRyPhTNCH0MTU3Ug8xkVt0hhtrGZryUPFxHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvHqZVHW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D09A606A31A;
	Thu, 22 Oct 2026 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvHqZVHW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359C51F000C1;
	Thu, 22 Oct 2026 10:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792663736;
	bh=zoTTxBF60ZcKsSjl7de0FhmB0fx7cpHitLamAY8HR6E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QvHqZVHWDxMjU3wNPWjaA0JophSLQv1RlltUrfYZW0GmJG2reOQASvOSw/4eiOW3f
	 N4tRCb1x53XBCELz8jG77LU0DP6SGQ6reyof/RJvJCEmazpCPo00woKSr8bezRHJIl
	 tZteh2CLWuoYm1oqjpedpmxbhYz90rTDA+kaNyfuc2Xf6OZXCboBIk+q/kkW2fexTD
	 6ZRND0WhUafIpHo3bfVn4nsseTiwow91WWBtGDirNhKEuYmfJBdUsLJSiz6HiHq2Sd
	 Bw5y5ZhnDfKPOmyejaCeQ9dqbPbgU+WTVfdShpC6wZIDNf4GF0LX7v6t1e3BLdU5q3
	 dHR1xwWmynW5Q==
Subject:
 Re: [PATCH net v2] net: pse-pd: don't enable a PI again while disabling it
From: netdev-bot+sashiko@kernel.org
To: ross@r-sc.ca
Cc: netdev@vger.kernel.org, kory.maincent@bootlin.com, github@szelinsky.de,
 o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 10:08:55 +0000
Message-ID: <179266373570.3135.5306089916848589884@kernel.org>
In-Reply-To: <20261019220835.613-1-ross@r-sc.ca>
References: <20261019220835.613-1-ross@r-sc.ca>
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

Critical: 0 · High: 1 · Medium: 0 (4) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: the PI being disabled is still enabled
  again, and the power budget still leaks, on the priority-eviction path.

Pre-existing issues:
- [Medium] The priority cut-off in pse_pw_d_retry_power_delivery()
  (drivers/net/pse-pd/pse_core.c) never takes effect.
- [Medium] pse_set_config_isr() (drivers/net/pse-pd/pse_core.c line 1211)
  tests `notifs & PSE_BUDGET_EVAL_STRAT_DYNAMIC`.
- [Medium] pse_pi_disable() (drivers/net/pse-pd/pse_core.c lines 701-719)
  always returns 0, even when _pse_pi_disable() fails (for example an…
- [Medium] In the disconnection branch of pse_set_config_isr()
  (drivers/net/pse-pd/pse_core.c lines 1233-1243), isr_pd_detected is…

--

net: pse-pd: don't enable a PI again while disabling it

This patch moves the power domain retry out of _pse_pi_disable() and into
its callers. pse_pi_disable() and the disconnection path of
pse_set_config_isr() now retry only after they clear admin_state_enabled or
isr_pd_detected. pse_disable_pi_pol() still retries right after the
disable.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index a5e6d7b26b9f..c71acfd5337c 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -493,6 +490,8 @@ static int pse_disable_pi_pol(struct pse_controller_dev *pcdev, int id)
>  	ret = _pse_pi_disable(pcdev, id);
>  	if (ret)
>  		notifs |= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR;
> +	else if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d))
> +		pse_pw_d_retry_power_delivery(pcdev, pcdev->pi[id].pw_d);

[Severity: High]
Can this retry still enable the PI that is being disabled? pse_disable_pi_pol()
is only reached through pse_disable_pi_prio(), from inside
pse_pi_allocate_pw_budget_static_prio(), while a higher priority PI (H) is
waiting for budget.

The evicted PI (L) still has admin_state_enabled and isr_pd_detected set. Once
its hardware is off, pse_pi_is_admin_enable_pending() returns true for L, and
that is the condition the subject line says is removed.

H is pending here too. On the classification path, pse_set_config_isr() sets
isr_pd_detected = true before calling _pse_pi_delivery_power_sw_pw_ctrl(), and
H is admin enabled:

pse_set_config_isr()                      /* CLASSIFICATION for H */
  _pse_pi_delivery_power_sw_pw_ctrl(H)
    pse_pi_allocate_pw_budget_static_prio(H)
      pse_disable_pi_prio()
        pse_disable_pi_pol(L)
          _pse_pi_disable(L)
          pse_pw_d_retry_power_delivery()
            _pse_pi_delivery_power_sw_pw_ctrl(H or L)

The retry scans in index order. If H has a lower index than L, the nested
retry allocates H's budget and enables H. Back in
pse_pi_allocate_pw_budget_static_prio(), the loop then asks for H's budget a
second time:

	while (regulator_request_power_budget(pi->pw_d->supply, pw_req) == -ERANGE) {
		...
		ret = pse_disable_pi_prio(pcdev, pi->pw_d, _prio);
		...
		_prio--;
	}

	pi->pw_allocated_mW = pw_req;

regulator_request_power_budget() adds to rdev->pw_requested_mW, so H is
reserved twice but only one reservation is recorded. Take a 25W budget, with L
(prio 2) holding 20W and H (prio 0) asking for 10W. H ends up with 20W
reserved and only 10W recorded, so the other 10W can never be freed. Isn't
this the same growing budget the commit message says is fixed?

If L has a lower index than H, the retry gives L back the budget it just
released. The ETHTOOL_PSE_EVENT_OVER_BUDGET notification is queued after the
retry, so user space hears that L was turned off for over budget while L is
already powered again.

In that same ordering, the nested _pse_pi_delivery_power_sw_pw_ctrl(H) can
get -ERANGE and evict L again through pse_disable_pi_prio() and
pse_disable_pi_pol(). That retries, enables L again, and recurses into H.
What bounds this recursion when pi_get_admin_state() reflects the change
immediately? If the hardware status lags instead, L would stay powered and H
would be refused, which inverts the priorities.

The v2 changelog says the retry powering such a PI again right away is left
for a separate patch. It doesn't mention the double allocation for the
requesting PI or the recursion. Should the eviction path be handled as part
of this fix?

>  
>  	ntf.notifs = notifs;
>  	ntf.id = id;
> @@ -709,8 +708,11 @@ static int pse_pi_disable(struct regulator_dev *rdev)
>  	pi = &pcdev->pi[id];
>  	mutex_lock(&pcdev->lock);
>  	ret = _pse_pi_disable(pcdev, id);
> -	if (!ret)
> +	if (!ret) {
>  		pi->admin_state_enabled = 0;
> +		if (pse_pw_d_is_sw_pw_control(pcdev, pi->pw_d))
> +			pse_pw_d_retry_power_delivery(pcdev, pi->pw_d);

[Severity: Medium]
This isn't a bug introduced by this patch, but this patch now calls
pse_pw_d_retry_power_delivery() directly from three places. Does the
prio_max cut-off in that function ever take effect?

	for (i = 0; i < pcdev->nr_lines; i++) {
		int prio_max = pcdev->nr_lines;
		...
		if (pcdev->pi[i].prio > prio_max)
			continue;

		ret = _pse_pi_delivery_power_sw_pw_ctrl(pcdev, i, &extack);
		if (ret == -ERANGE)
			prio_max = pcdev->pi[i].prio;
	}

prio_max is reset at the top of every iteration, so the value written after
-ERANGE is never read. A lower priority PI can still take freed budget after a
higher priority PI has failed. That goes against the comment "Do not try to
enable PI with a lower prio (higher value) than one which already can't be
enabled."

Should prio_max be declared outside the loop?

> +	}
>  
>  	mutex_unlock(&pcdev->lock);
>  	return 0;

[Severity: Medium]
This is a pre-existing issue, but pse_pi_disable() returns 0 even when
_pse_pi_disable() fails, for example when ops->pi_disable() gets an I2C error.

The regulator core then treats the disable as done and drops the consumer
enable count to 0. The PI stays powered, admin_state_enabled stays 1 and its
budget stays allocated, and user space is told the disable succeeded.

A later pse_ethtool_c33_set_config() with DISABLED sees admin_state_enabled
set and calls regulator_disable() again:

	case ETHTOOL_C33_PSE_ADMIN_STATE_DISABLED:
		if (psec->pcdev->pi[psec->id].admin_state_enabled)
			err = regulator_disable(psec->ps);

With the enable count already at zero, that call fails, so the disable can't
be retried. Should this return ret instead of 0?

> @@ -1229,10 +1231,16 @@ static int pse_set_config_isr(struct pse_controller_dev *pcdev, int id,
>  				ret = 0;
>  		}
>  	} else if (notifs & ETHTOOL_C33_PSE_EVENT_DISCONNECTION) {

[Severity: Medium]
This is a pre-existing issue, but can this disconnection branch be skipped
entirely? Earlier in pse_set_config_isr():

	if (notifs & PSE_BUDGET_EVAL_STRAT_DYNAMIC)
		return 0;

PSE_BUDGET_EVAL_STRAT_DYNAMIC is a budget strategy value (1 << 2), not an
event bit. It has the same value as ETHTOOL_C33_PSE_EVENT_DETECTION (4), so
any batch of events that includes DETECTION returns 0 early.

tps23881_irq_event_handler() reads TPS23881_REG_DET_EVENT once. It can report
both DETECTION and CLASSIFICATION into the same notifs[i] through
tps23881_set_notifs_helper(). When that happens, isr_pd_detected is not set
and the PD is not powered.

A DETECTION | DISCONNECTION batch also skips the -EINVAL consistency check and
this branch. The disable, budget free and retry changed by this patch then
never run.

Was this check meant to test the domain's budget_eval_strategy rather than
notifs?

> -		if (pcdev->pi[id].admin_state_enabled &&
> -		    pcdev->pi[id].isr_pd_detected)
> +		struct pse_pi *pi = &pcdev->pi[id];
> +		bool disable = pi->admin_state_enabled && pi->isr_pd_detected;
> +
> +		/* Cleared first, so that the retry doesn't enable it again */
> +		pi->isr_pd_detected = false;
> +		if (disable) {
>  			ret = _pse_pi_disable(pcdev, id);

[Severity: Medium]
This is a pre-existing issue, since the old code also cleared isr_pd_detected
whatever the result was. What happens to this PI's budget if
_pse_pi_disable() fails here?

When ops->pi_disable() fails, _pse_pi_disable() returns before it calls
pse_pi_deallocate_pw_budget(), so pw_allocated_mW keeps the old reservation.
isr_pd_detected is already cleared, so later disconnection events compute
disable as false and never retry.

When the PD reconnects, the classification path calls
_pse_pi_delivery_power_sw_pw_ctrl() again. regulator_request_power_budget()
adds a new reservation, and pse_pi_allocate_pw_budget_static_prio()
overwrites the recorded amount:

	pi->pw_allocated_mW = pw_req;

Does the earlier reservation for this PI leak at that point? Could
isr_pd_detected be restored when _pse_pi_disable() fails?

> -		pcdev->pi[id].isr_pd_detected = false;
> +			if (!ret)
> +				pse_pw_d_retry_power_delivery(pcdev, pi->pw_d);
> +		}
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019220835.613-1-ross%40r-sc.ca
