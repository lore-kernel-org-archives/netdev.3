Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873316;
	b=lPv4G+uu8pjPwTlPeq0CzZGqJzNIqMvcWPYX7R7wM4cSZFL3lz2M64e4akHUTrNKc8gg
	 2LV+nHRgVcCBf971c8U11c1bl9c1f5Ws+Zt+aJ/LkjBryVfIdhpjlU3pNvLc0tJn5/4pV
	 IOBTe0sBM23QP98g4hLM+P3fkyetYHa27WUZuV2eajuBDIKAgUqTEKejv8Hi82gqkGxK6
	 Qx6wZX3TpDIw8vBp7etzqBO7vJPg86FJ+PD3LZLuvVP8lINT2jRgc1bxQqlZ7Z/Z8mhOS
	 fYF+7X3U8P3/JD0R+We8nQVxCGajs19edNvJ3xegiayqLXZ17QytG4Ar159Bvzt3jRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873316;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=3blS2AaSN06RMOlfjEcRKApb/FeSBcT5iCSt6a6mHWo=;
	b=BdN9rjakK7VIKjKP4ZMcn/0juWLrDcwWyy8tG3LdBNamSI0Ze7S+1TKQc+r8tCsNjcms
	 SiFkmP4s9efVnyjWQJY+zWuSoiF9DgflR53Hg7iRX4YIxrldr8iULY6VN9yre6078kWjj
	 p5oG+1otjYVm23W/2NtqsuU9nt4wtI6+al44aFD4uEJyQIQ8pDvdZsGKgW/jY+QmCIk/j
	 5SBfEgOFf63475PazxKAwlsEOaZRB2VcLbVhX5yUBj74txhOPLQU+bKnPVNwaLOv1/5IF
	 cS+RP47Srom+WITc3fK1asB+v2xr/zES8jsb+gUzHNu5Iw6rt67cNknfP89cNQmReug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNnLdoBI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9148608361C;
	Thu,  5 Nov 2026 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNnLdoBI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8110F1F0093A;
	Thu,  5 Nov 2026 10:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793873315;
	bh=3blS2AaSN06RMOlfjEcRKApb/FeSBcT5iCSt6a6mHWo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CNnLdoBIxl93DkiU6x2qejAmwAxpahFEvWqsDvSJzAmT9IFhYlWT3NSKaFa52KozK
	 ym+0h9nm+TB2s6SXD2zvdc0DiSqEdZKq/QPrXWm8DuVFYABaOamKZXt2du408xlgjF
	 vaxgGg1Rza0RMHo63tQeN2UtK+6DMoY7Vfj2dDta4rzAzah744pDfzI93L6o8QOcj3
	 xTPGPNeyodz4JOe05Lh6wDrppFeAhxT6vYyDg2yCDZKY/pX4hIjgYF2q28/OKOpZTu
	 y0Sh0eS4dTboq4z9G7rBgp/hrc9xD5fOuiUjSV4UHqRREjxa1xl4tJMoxu3/L0Vgfa
	 HEfqU7gQFq4Uw==
Subject: Re: [PATCH net v3 06/14] net: pse-pd: check the PI state under the
 lock when setting a power limit
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
 maxime.chevallier@bootlin.com, kyle.swenson@est.tech, ross@r-sc.ca,
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 05 Nov 2026 10:08:34 +0000
Message-ID: <179387331403.488856.16797302256454828469@kernel.org>
In-Reply-To: <20261103220217.1131971-7-github@szelinsky.de>
References: <20261103220217.1131971-7-github@szelinsky.de>
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

Critical: 0 · High: 1 · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The check that moved under the lock does not test whether the PI
  is powered, so the bug the commit says it fixes ("budget is reserved…
- [Medium] The rollback in pse_ethtool_set_pw_limit() writes back
  previous_pw_allocated, which was read in an earlier critical section.

Pre-existing issues:
- [Medium] In pse_ethtool_set_pw_limit(), the return value of the
  rollback call to pse_pi_update_pw_budget() is ignored.
- [Medium] pse_ethtool_set_pw_limit() still runs in two phases.

--

net: pse-pd: check the PI state under the lock when setting a power limit

This moves the check for software power control, admin_state_enabled and
isr_pd_detected out of pse_ethtool_set_pw_limit() and into
pse_pi_update_pw_budget(), where it runs under pcdev->lock. It also adds an
updated out-parameter. With it, the rollback after a failed
regulator_set_current_limit() runs only when the budget was actually
changed, including a budget that started from zero.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index af9eb29792706..36f7dba8190a2 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -1821,22 +1821,35 @@ EXPORT_SYMBOL_GPL(pse_ethtool_set_config);

[ ... ]

>  static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
> -				   const unsigned int pw_req,
> +				   const unsigned int pw_req, bool *updated,
>  				   struct netlink_ext_ack *extack)
>  {

[ ... ]

>  	mutex_lock(&pcdev->lock);
> +	/* Only a PI under software power control that is enabled and has a
> +	 * PD detected gets a budget. Check this here, as pse_isr() changes
> +	 * it under the same lock.
> +	 */
> +	if (!pse_pw_d_is_sw_pw_control(pcdev, pi->pw_d) ||
> +	    !pi->admin_state_enabled || !pi->isr_pd_detected)
> +		goto out;

[Severity: High]
Does this check tell whether the PI is actually powered? Both flags can be
set while the port is off and pw_allocated_mW is 0, and no race is needed
to get there.

The first case is the admin-enable pending state. pse_set_config_isr() sets
isr_pd_detected and swallows -ERANGE:

	pcdev->pi[id].isr_pd_detected = true;
	if (pcdev->pi[id].admin_state_enabled) {
		ret = _pse_pi_delivery_power_sw_pw_ctrl(pcdev, id,
							&extack);
		if (ret == -ERANGE)
			ret = 0;
	}

pse_pi_enable() does the same for admin_state_enabled:

	if (!ret || ret == -ERANGE) {
		pcdev->pi[id].admin_state_enabled = 1;
		ret = 0;

In both cases pse_pi_allocate_pw_budget_static_prio() returned before it
set pw_allocated_mW and before ops->pi_enable() was called.

The second case is priority shedding from pse_isr(), which is the state
change the commit message refers to. pse_disable_pi_pol() calls
_pse_pi_disable(), which powers the PI off and zeroes its budget but leaves
both flags set:

	ret = ops->pi_disable(pcdev, id);
	if (ret)
		return ret;

	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);

pse_pi_is_admin_enable_pending() already deals with this by also calling
pse_pi_is_hw_enabled().

In either state, setting c33-pse-avail-pw-limit through ethtool passes this
check. regulator_request_power_budget() then reserves the new limit, and
pw_allocated_mW is set for a port that is still off.

Later, pse_pw_d_retry_power_delivery() or a new classification calls
pse_pi_allocate_pw_budget_static_prio(). That function requests the budget
again and overwrites the earlier reservation without freeing it:

	pi->pw_allocated_mW = pw_req;
	return 0;

Can this permanently leak that power from the domain?

Until the overwrite happens, the reservation also can't be shed, because
pse_disable_pi_prio() skips PIs that are not enabled in hardware. Other
ports could therefore be refused power.

Is a predicate that reflects the powered state needed here instead? For
example, pse_pi_is_hw_enabled() > 0, or a non-zero pw_allocated_mW for the
static strategy. The comment in pse_ethtool_set_pw_limit() still says "if a
Power Device is powered".

[ ... ]

> @@ -1900,21 +1915,17 @@ int pse_ethtool_set_pw_limit(struct pse_control *psec,
>  	/* Update power budget only in software power control case and
>  	 * if a Power Device is powered.
>  	 */
> -	if (pse_pw_d_is_sw_pw_control(psec->pcdev,
> -				      psec->pcdev->pi[psec->id].pw_d) &&
> -	    psec->pcdev->pi[psec->id].admin_state_enabled &&
> -	    psec->pcdev->pi[psec->id].isr_pd_detected) {
> -		ret = pse_pi_update_pw_budget(psec->pcdev, psec->id,
> -					      pw_limit, extack);
> -		if (ret < 0)
> -			return ret;
> -		previous_pw_allocated = ret;
> -	}
> +	ret = pse_pi_update_pw_budget(psec->pcdev, psec->id, pw_limit,
> +				      &updated, extack);
> +	if (ret < 0)
> +		return ret;
> +	previous_pw_allocated = ret;
>  

[Severity: Medium]
This isn't a bug introduced by this patch, but the budget update and the
hardware limit write still happen in separate pcdev->lock sections. Can
pse_isr() run between them and allocate budget based on the stale hardware
limit?

Suppose a DISCONNECTION and then a CLASSIFICATION are handled in that
window. _pse_pi_delivery_power_sw_pw_ctrl() would then use the old limit:

	if (ops->pi_get_pw_limit) {
		ret = ops->pi_get_pw_limit(pcdev, id);
		if (ret < 0)
			return ret;

		if (ret < pw_req)
			pw_req = ret;
	}

For example, when lowering the limit from 30000 mW to 15000 mW, the ISR
could reserve 30000 mW before the 15000 mW limit is programmed. The port
would stay over-reserved until the next PD event.

On the failure path, the rollback would also replace the allocation the ISR
just made with the stale value from before the call.

Simply holding pcdev->lock across regulator_set_current_limit() would not
work, because pse_pi_set_current_limit() takes that lock itself.

>  	ret = regulator_set_current_limit(psec->ps, 0, uA);
> -	if (ret < 0 && previous_pw_allocated) {
> +	if (ret < 0 && updated) {
>  		pse_pi_update_pw_budget(psec->pcdev, psec->id,
> -					previous_pw_allocated, extack);
> +					previous_pw_allocated, &updated,
> +					extack);
>  	}

[Severity: Medium]
Is previous_pw_allocated still valid when the rollback runs? It was read in
the first pse_pi_update_pw_budget() call. pcdev->lock is dropped after that
call, then taken and dropped again inside
regulator_set_current_limit()->pse_pi_set_current_limit(), and only then
taken again for the rollback.

Two things gate the rollback: updated, which describes the first call, and
the flag check. Neither notices if pw_allocated_mW changed in between.

Here is one possible interleaving on tps23881 with the static strategy:

CPU0
pse_ethtool_set_pw_limit()
  pse_pi_update_pw_budget()        /* P -> X, unlock */

CPU1
pse_isr()                          /* higher prio PI classified */
  pse_pi_allocate_pw_budget_static_prio()
    pse_disable_pi_prio()
      pse_disable_pi_pol()
        _pse_pi_disable()          /* our PI off, pw_allocated_mW = 0 */

CPU0
  regulator_set_current_limit()    /* fails */
  pse_pi_update_pw_budget()        /* flags still set, requests P */

The rollback then sets pw_allocated_mW to P for a port that is powered off.
The next retry overwrites it in pse_pi_allocate_pw_budget_static_prio()
without freeing it, so P would leak.

The new rollback-from-zero behavior adds another case:

1. A pending PI gets X reserved.
2. Retry delivery powers it inside the window with R, which leaks X.
3. The rollback to 0 frees R and sets pw_allocated_mW to 0 while the port
   is powered and drawing R.

Would it be safer to restore only when pw_allocated_mW still equals the
value this call installed?

[Severity: Medium]
This is a pre-existing issue, but the return value of the rollback
pse_pi_update_pw_budget() call is ignored.

When the limit is lowered, the first call frees (previous - new) mW and
drops pcdev->lock. Another PI can then claim that budget through
pse_isr(). Next, regulator_set_current_limit() can fail, for example with
this check in pse_pi_set_current_limit():

	if (max_uA > MAX_PI_CURRENT)
		return -ERANGE;

In that case the rollback has to request budget again, and that request can
also fail with -ERANGE.

Could pw_allocated_mW then keep the lower value while the controller still
enforces the old, higher limit, leaving the domain overcommitted?

The failed rollback would also overwrite extack with "not enough power
budget available", which hides the original error.

>  
>  	return ret;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103220217.1131971-1-github%40szelinsky.de
