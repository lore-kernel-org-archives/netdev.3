Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743216;
	b=OITjaO5/KKim/Hp65pZS1ISvfbPESKF78vjwp5+8eVbrmSWluyzjvnhoE+a7lmBjlfAG
	 lqugX/SOZYwdec7wFLEo24UO0BGU5PYtroB7hdBmi3llNivEYRp/gymfIVhM25zP0BvXt
	 +R2gdwANR6qjtujDKgnleTQu+OlFXxM6rRFjauIGAVXZErLkjtqYPCXrcVdPCg+z3Ieth
	 3KpSlDfsPWhqgcqw5rT0S/w+dvW1l6xXT9s2LkPa3qGk/Bdl78vp9TxS5MSoOHDq5GxMA
	 n60FebtOImI6S3moiTfkizgfY89Ci1bLe4pYX59VV0g1doSe5hQ+aXFGkA7c/dorabw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743216;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7NexUVuvDPnYcH5TpaHV6T3xbSzprjsyYDQbk6xgnow=;
	b=O2pQY0gjHeM9VsBXkFJSJRXbOyKN+VgCOrmwC2xIk1nWecqsJRA1FKZyFcnx8z0v6hcd
	 a24JIM2IpnGkY9mpuKqJQ4toypKv1hSaqbvH4hUFBsyTr7JrFz2QNJ0NixIJlIsveo4sg
	 oS8izjor5j3bME86cRLxY5sTGdZDUC4NL+a8dXUIw16Yb/2093kyXkm3HsUK9EwEeeMYP
	 0FAzL1v+0c/uxakdHQSQB/53Mcs/6XaG47paWnw6ZSL6QxVEo+SvaaTH3ZDZwudWl/Tjx
	 nzeXO+OBBITjoVuQOFhgK/QiyyaI5gugV96TyXwyD8QVG132q30i09NDw3tIq3GFOvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6zoDF6v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234CA606A31D;
	Fri, 23 Oct 2026 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6zoDF6v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F531F031E0;
	Fri, 23 Oct 2026 08:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792743215;
	bh=7NexUVuvDPnYcH5TpaHV6T3xbSzprjsyYDQbk6xgnow=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O6zoDF6veRo/4X7SMn9BvzY4eYV0ROzr3LFec0b1+F30A+6RBO6vTcX4j3wWtkj/H
	 gghQ+vl6w7Vn/i9RNCthu1bHgVZ2U6P4BJMmdzW329iX3qsZIbVIf+oYS8tPgFsTJP
	 b4teXZhbkAU/1CoNXJWOAluAHCQQFQXsc0fxwaCPwmu/Qb8cMlX/pE+VYpSMREIuXQ
	 G4HTLiBw9w1LZUr/ReeY5LERfBEA2mEbH5or4Qvc6ryXQtx0qpH5tPzx58XEi/nW4I
	 xdgf0UIn1+0SyotOPEuOYJKMJSJ6aeveQFElYegc5r69C9paPmr5LcyddDrrVRb4gA
	 LcdLr08QkB6qg==
Subject: Re: [PATCH net v2 06/14] net: pse-pd: check the PI state under the
 lock when setting a power limit
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kyle.swenson@est.tech, ross@r-sc.ca,
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 23 Oct 2026 08:13:34 +0000
Message-ID: <179274321449.3134.2737207729630977183@kernel.org>
In-Reply-To: <20261020171249.853085-7-github@szelinsky.de>
References: <20261020171249.853085-7-github@szelinsky.de>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new check in pse_pi_update_pw_budget() (drivers/net/pse-
  pd/pse_core.c:1849-1851) only tests `pse_pw_d_is_sw_pw_control() &&…
- [Medium] pse_ethtool_set_pw_limit() still races pse_isr() after the
  change.
- [Low] The new eligibility check in pse_pi_update_pw_budget() also
  applies to the rollback call, so the rollback can be skipped while the…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is an
  AB-BA deadlock between pcdev->lock and the supply regulator's ww_mutex.
- [Medium] This problem wasn't introduced by this patch, but the rollback
  call to pse_pi_update_pw_budget() in pse_ethtool_set_pw_limit() (lines…

--

net: pse-pd: check the PI state under the lock when setting a power limit

This patch moves the "PI is powered" check from pse_ethtool_set_pw_limit()
into pse_pi_update_pw_budget(), where it runs under pcdev->lock. The helper
now reports through a new updated argument whether the budget changed. The
rollback after a failed regulator_set_current_limit() uses that flag
instead of a non-zero previous allocation.

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
>  	struct pse_pi *pi = &pcdev->pi[id];
>  	int previous_pw_allocated;
>  	int pw_diff, ret = 0;
>  
> +	*updated = false;
> +
>  	/* We don't want pw_allocated_mW value change in the middle of an
>  	 * power budget update
>  	 */
>  	mutex_lock(&pcdev->lock);
> +	/* Only a PI under software power control that is enabled and has a
> +	 * PD detected gets a budget. Check this here, as pse_isr() changes
> +	 * it under the same lock.
> +	 */
> +	if (!pse_pw_d_is_sw_pw_control(pcdev, pi->pw_d) ||
> +	    !pi->admin_state_enabled || !pi->isr_pd_detected)
> +		goto out;

[Severity: High]
Do admin_state_enabled and isr_pd_detected really mean the PI is powered?

Both flags can stay set while the port is off in hardware.
pse_set_config_isr() hides -ERANGE from the static budget allocation:

	pcdev->pi[id].isr_pd_detected = true;
	if (pcdev->pi[id].admin_state_enabled) {
		ret = _pse_pi_delivery_power_sw_pw_ctrl(pcdev, id,
							&extack);
		if (ret == -ERANGE)
			ret = 0;
	}

pse_pi_enable() also sets admin_state_enabled on -ERANGE. In both cases
the PI is left pending, with pw_allocated_mW == 0 and pi_enable() never
called.

pse_disable_pi_pol() is another case. It turns off a powered PI through
_pse_pi_disable() to shed budget, but it leaves both flags set.

The core already treats this as a separate state in
pse_pi_is_admin_enable_pending():

	if (!pcdev->pi[id].admin_state_enabled ||
	    !pcdev->pi[id].isr_pd_detected)
		return false;

	ret = pse_pi_is_hw_enabled(pcdev, id);
	/* PSE PI is already enabled at hardware level */
	if (ret == 1)
		return false;

A pending PI passes this check. regulator_request_power_budget() then
reserves pw_limit, and pi->pw_allocated_mW is set to pw_limit, while no
power is delivered.

pse_pw_d_retry_power_delivery() can power the port later. It is called
from _pse_pi_disable() of another PI and from pse_ethtool_set_prio(). The
path is _pse_pi_delivery_power_sw_pw_ctrl() ->
pse_pi_allocate_pw_budget_static_prio():

	while (regulator_request_power_budget(pi->pw_d->supply, pw_req) == -ERANGE) {
	...
	pi->pw_allocated_mW = pw_req;

This requests the full pw_req again and overwrites pw_allocated_mW. The
earlier ethtool reservation is never freed. pse_pi_deallocate_pw_budget()
only frees the overwritten value.

Does the pw_limit reserved through ethtool then stay charged to the supply
for good?

The commit message says the patch stops budget being reserved "for a port
that is no longer powered". That still seems possible, for example right
after pse_disable_pi_pol() turns a port off. The same flag test existed
before the patch, outside the lock.

Would checking pse_pi_is_hw_enabled() == 1 here, under the lock, close
this?

The comment kept in pse_ethtool_set_pw_limit() ("if a Power Device is
powered") also doesn't match what this check tests.

[Severity: Low]
The rollback call in pse_ethtool_set_pw_limit() also goes through this
check. Can the rollback be skipped while the increased reservation is still
held?

pse_ethtool_set_pw_limit()
  pse_pi_update_pw_budget()      raises P -> L, updated = true, unlock

pse_isr()                        DISCONNECTION
  pse_set_config_isr()
    _pse_pi_disable()
      ops->pi_disable() fails (e.g. an I2C error), returns before
      pse_pi_deallocate_pw_budget()
    pcdev->pi[id].isr_pd_detected = false;

pse_ethtool_set_pw_limit()
  regulator_set_current_limit()  fails
  pse_pi_update_pw_budget(previous_pw_allocated)
    !pi->isr_pd_detected -> goto out

pw_allocated_mW then stays at L. The pre-patch rollback would have restored
it to P. Failing this check doesn't always mean the PI's reservation has
been released.

> +
>  	previous_pw_allocated = pi->pw_allocated_mW;
>  	pw_diff = pw_req - previous_pw_allocated;
>  	if (!pw_diff) {
> @@ -1854,6 +1867,7 @@ static int pse_pi_update_pw_budget(struct pse_controller_dev *pcdev, int id,
>  		regulator_free_power_budget(pi->pw_d->supply, -pw_diff);
>  	}

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. Is
there an AB-BA deadlock between pcdev->lock and the supply regulator's
lock?

Path A, ethtool set_config under rtnl:

pse_ethtool_c33_set_config()
  regulator_enable(psec->ps)
    regulator_lock_dependent()
      regulator_lock_recursive()    locks PI rdev, then its supply rdev
    _regulator_enable()->_regulator_do_enable()
      pse_pi_enable()
        mutex_lock(&pcdev->lock)

regulator_disable() -> pse_pi_disable() takes the locks in the same order.

Path B, the threaded IRQ:

pse_isr()
  mutex_lock(&pcdev->lock)
  pse_set_config_isr()
    _pse_pi_delivery_power_sw_pw_ctrl()
      pse_pi_allocate_pw_budget_static_prio()
        regulator_request_power_budget(pi->pw_d->supply)
          regulator_lock(supply rdev)

On DISCONNECTION, _pse_pi_disable() -> regulator_free_power_budget() takes
the same supply lock.

pw_d->supply comes from regulator_get(&rdev->dev, rdev->supply_name). It
is the same supply rdev that path A already holds.

If A holds the supply rdev and waits for pcdev->lock, while B holds
pcdev->lock and waits for the supply rdev, both tasks hang for good. A
also holds rtnl_lock.

pse_pi_update_pw_budget(), including its new rollback use, keeps the same
pcdev->lock -> supply order.

>  	pi->pw_allocated_mW = pw_req;
> +	*updated = true;
>  	ret = previous_pw_allocated;
>  
>  out:

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
>  	ret = regulator_set_current_limit(psec->ps, 0, uA);
> -	if (ret < 0 && previous_pw_allocated) {
> +	if (ret < 0 && updated) {
>  		pse_pi_update_pw_budget(psec->pcdev, psec->id,
> -					previous_pw_allocated, extack);
> +					previous_pw_allocated, &updated,
> +					extack);
>  	}

[Severity: Medium]
pcdev->lock is still dropped between three steps: the budget update,
regulator_set_current_limit() (which takes the lock again in
pse_pi_set_current_limit()), and the rollback.

Can updated and previous_pw_allocated be stale by the time the rollback
runs? The rollback also applies an absolute value to whatever PD session
exists at that point.

Two interleavings with pse_isr() look possible.

(a) After the budget update, pse_isr() handles DISCONNECTION, which frees
the budget, and then CLASSIFICATION. _pse_pi_delivery_power_sw_pw_ctrl()
budgets the new PD as min(pi_get_pw_req, pi_get_pw_limit), using the old
hardware limit.

If regulator_set_current_limit() then fails, the rollback forces the new
session's allocation back to the old session's value.

The patch adds a rollback-from-zero case (previous_pw_allocated == 0 and
updated == true, e.g. for a pending PI). In that case the rollback can
free the new PD's whole budget while the PD is powered, so the supply is
oversubscribed.

(b) A PD is classified between the budget update and the hardware limit
write. It is budgeted from the old limit, and then the new, higher limit
is programmed. The hardware then allows more power than is reserved.

These windows existed before the patch. The rollback driven by updated is
new.

The commit message describes the pse_isr() race. Would it make sense to do
the budget update and the hardware limit write in one pcdev->lock section,
so that race is fully closed?

[Severity: Medium]
This isn't a bug introduced by this patch, but the return value of the
rollback pse_pi_update_pw_budget() call is ignored. What happens if the
rollback's re-request fails?

When the limit is lowered from P to L, the first call frees P - L mW and
drops pcdev->lock. A concurrent pse_isr() on another PI in the same domain
can take that freed budget.

regulator_set_current_limit() can then fail.
pse_pi_set_current_limit() returns -ERANGE for max_uA > MAX_PI_CURRENT or a
null voltage, and ops->pi_set_pw_limit() can also fail. The rollback's
regulator_request_power_budget(P - L) then returns -ERANGE.

pw_allocated_mW stays at L, but the hardware keeps the old limit P.

The rollback also overwrites extack with "not enough power budget
available". That hides the real regulator_set_current_limit() error.

>  
>  	return ret;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020171249.853085-1-github%40szelinsky.de
