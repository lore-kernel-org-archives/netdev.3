Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22151DB07;
	Wed, 30 Sep 2026 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803866; cv=none; b=bVilx3lPgfJWotWTD1zVpLkNEWpbA3goWdPx5C1baNWfFZ2uDS2bYSMYaJ01oB5hEWqvxqXWA7GGFVGSyP7U7Pvh966wDa2CxPr4I2TreJVYfSAZ7t7bIfSJ3N1oitWTTi884OWdIP2QLoTncuq9gyCozU6xXXnW6AwKiqkQ7vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803866; c=relaxed/simple;
	bh=s7TcCMMT30iWMh1Otmnr7PaMjo1h+twJcjoFLl5YcAQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNoirdOaHDtjN1Fo005286F+wkpTRghRd2ZvjLNQiCTuR5ugBl/mReoKo64DIyRH3wOroq+dbqkFMCKmepTC42ON1yO54pzFoG7aGODAyRN+8SW72DODCmIo8qnjTzEKiDyL+0Bk/PYgryTUNMMobOiWtro0MgAalQyzZHMcuSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCUy7UW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCUy7UW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95211F000FF;
	Wed, 30 Sep 2026 21:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803863;
	bh=pnYPUKbs01lzfaAajMMYrOW9q8PQl08NY56wG0JNEMw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PCUy7UW2KlW4r8nTfhSItbJRxaKK9LNR0RzLglExrp88Pn6d+J9Cg3saceQSoRryS
	 0/ELYeMI8m0yNGw9dfTiOFN1w/1jivkHlDXiJ+ZueDKlExSU5cLaEx2KWOV801Iani
	 wYIkQ7FXbSL6dV9nNldWqqxIsifLEr8cyMeaguUTpIreVe5A/uHGvcbXpkp+Qq+rOj
	 Hzsig+hP6qIwMLev+g8srb/sWo9r3MRIGvLoT4z00V+XOI9qWHQz9LdjE3+ex9Ucig
	 UyzIpnCiviHoDpgWfJlPafimJIQRz+2oEuvXcJu32lQ9Ei9/+QF3OCh+b72UFg59gD
	 yUZAAuYKEQPZA==
Subject:
 Re: [PATCH net-next v3 2/2] net: pse-pd: Add LTC4266 PSE controller driver
From: netdev-bot+sashiko@kernel.org
To: kyle.swenson@est.tech
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, roland.kovacs@est.tech, david.nystrom@est.tech
Date: Wed, 30 Sep 2026 21:31:02 +0000
Message-ID: <179080386247.434549.15817042587071985098@kernel.org>
In-Reply-To: <20260927212929.593366-3-kyle.swenson@est.tech>
References: <20260927212929.593366-3-kyle.swenson@est.tech>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 6 (3) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] If a PI's vpwr-supply is described in DT but not yet registered
  when the LTC4266 probes, ltc4266_pi_nominal_uv() carries on (warn plus…
- [Medium] ltc4266_pi_get_pw_class() reports the wrong power class to
  userspace.
- [Medium] ltc4266_pi_nominal_uv() swallows -EPROBE_DEFER from
  of_regulator_get_optional().
- [Medium] ltc4266_map_event() loses hardware events on every error exit.
- [Medium] ltc4266_pi_set_pw_limit() treats every negative
  ltc4266_port_get_class() result as 'not classified', including…
- [Medium] ltc4266_map_event() reports
  ETHTOOL_C33_PSE_EVENT_CLASSIFICATION whenever the detevn high nibble…
- [Medium] ltc4266_pi_disable() is carried out by ltc4266_port_init(),
  whose first write (RSTPB = BIT(chan)) removes power from the port.
- [Low] The LTC4266 binding sets maxItems: 1 for pse-pi 'pairsets' but
  does not list it as required, and pse-controller.yaml requires only…
- [Low] ltc4266_regmap_config sets only reg_bits, val_bits and
  max_register (0x5F), with no precious_reg or readable_reg callbacks.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new driver
  makes it easy to hit.
- [High] This problem wasn't introduced by this patch, but the new driver
  opts into the affected path.
- [Medium] This problem wasn't introduced by this patch, but: when
  ops->setup_pi_matrix() fails, pse_controller_register() returns…
- [Medium] This problem wasn't introduced by this patch, but:
  pse_controller_unregister() calls pse_release_pis() (kfree(pcdev->pi))…
- [Medium] This problem wasn't introduced by this patch, but:
  pse_control_get_internal() calls try_module_get(pcdev->owner) and…

--

net: pse-pd: Add LTC4266 PSE controller driver

This commit adds a new I2C driver for the Linear Technology LTC4266 PoE PSE
controller and hooks it into the PSE controller core. The driver runs the
chip in semi-auto mode and maps PSE PIs to delivery channels from the
device tree. It uses the chip interrupt together with the static power
budget evaluation strategy.

> diff --git a/drivers/net/pse-pd/ltc4266.c b/drivers/net/pse-pd/ltc4266.c
> new file mode 100644
> index 0000000000000..37dea467811a4
> --- /dev/null
> +++ b/drivers/net/pse-pd/ltc4266.c
> @@ -0,0 +1,1386 @@

[ ... ]

> +static int ltc4266_pi_disable(struct pse_controller_dev *pcdev, int id)
> +{
> +	struct ltc4266_port *port = ltc4266_pi_port(pcdev, id);
> +
> +	/* Resetting the port (RSTPB, issued at the start of ltc4266_port_init)
> +	 * removes power, disables detection and classification, and clears the
> +	 * port's status register. Re-init the port so that detection and
> +	 * classification can happen again.
> +	 */
> +	return ltc4266_port_init(port);
> +}

[Severity: Medium]
What happens if one of the writes after the RSTPB reset in
ltc4266_port_init() fails?

The first write in ltc4266_port_init() has already removed power from the
port. A later failure in the OPMD, HPEN, HPMD, TLIM, DISENA or DETPB write
is still returned as a failed disable, and _pse_pi_disable() then skips
the budget release:

drivers/net/pse-pd/pse_core.c:_pse_pi_disable() {
    ...
	ret = ops->pi_disable(pcdev, id);
	if (ret)
		return ret;

	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);
    ...
}

Would the core then keep budget allocated and admin_state_enabled set for
a port that has no power? DETPB was never written, so detection stays off.
No later classification interrupt would arrive to resync the state.

[ ... ]

> +static int ltc4266_pi_get_admin_state(struct pse_controller_dev *pcdev, int id,
> +				      struct pse_admin_state *admin_state)
> +{

[ ... ]

> +	ret = regmap_read(port->ltc4266->regmap, LTC4266_REG_STATPWR, &val);
> +	if (ret < 0)
> +		return ret;

[Severity: Medium]
This isn't a bug introduced by this patch, but an I2C error returned here
reaches a module reference leak that already exists in the PSE core.
pse_control_get_internal() calls try_module_get(pcdev->owner) and then
does this:

drivers/net/pse-pd/pse_core.c:pse_control_get_internal() {
    ...
	ret = pse_pi_is_hw_enabled(pcdev, index);
	if (ret < 0)
		goto free_psec;
    ...
}

That jump skips the put_module label. If an I2C error happens while a PHY
is acquiring its PSE control, does the ltc4266 module stay pinned?

[ ... ]

> +static int ltc4266_pi_get_pw_class(struct pse_controller_dev *pcdev, int id)
> +{
> +	int ret = ltc4266_port_get_class(ltc4266_pi_port(pcdev, id));
> +

[ ... ]

> +	if (ret == 0)
> +		ret = 3;
> +	if (ret < 0)
> +		ret = 0;
> +	return ret;
> +}

[Severity: Medium]
Does this report the wrong power class to userspace?

A PD that has a valid detection signature but no class signature (statp
class code 0x6, which is class 0 in ltc4266_class_map[]) is reported as
class 3.

Every negative result from ltc4266_port_get_class() becomes 0. That
covers regmap I2C errors, -EAGAIN (classification not finished), -EINVAL
(detection not good) and -ERANGE.

pse_ethtool_get_status() stores the value in status->c33_pw_class, and
pse_fill_reply() only emits it when it is greater than zero:

net/ethtool/pse-pd.c:pse_fill_reply() {
    ...
	if (st->c33_pw_class > 0 &&
	    nla_put_u32(skb, ETHTOOL_A_C33_PSE_PW_CLASS,
    ...
}

So ethtool --show-pse would show class 3 for a class 0 PD, and an I2C
failure would look the same as no PD at all. Other drivers, such as
tps23881_pi_get_pw_class(), return the raw class and propagate errors.

ltc4266_class_pw[] and pi_get_pw_req already treat class 0 like class 3
for power budgeting. Could this callback report the real class instead?
If the rewrite stays, could the commit message mention it?

[ ... ]

> +static int ltc4266_pi_set_pw_limit(struct pse_controller_dev *pcdev,
> +				   int id, int max_mw)
> +{

[ ... ]

> +	class = ltc4266_port_get_class(port);
> +	if (class >= 0) {
> +		icut = ltc4266_pw_limit_to_icut(port, max_mw, class);
> +		if (icut < 0)
> +			return icut;
> +
> +		ret = ltc4266_port_set_icut(port, icut);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	port->pw_limit = max_mw;
> +
> +	return 0;

[Severity: Medium]
Should a regmap_read() failure inside ltc4266_port_get_class() be treated
the same as "not classified" here?

On a powered port, a transient I2C error skips ltc4266_port_set_icut(),
but port->pw_limit is still updated and 0 is returned.
pse_ethtool_set_pw_limit() has already updated the power budget and only
rolls it back on an error return. The core budget and the reported limit
would then show the new value while the hardware keeps enforcing the old
I_CUT.

[ ... ]

> +static int ltc4266_pi_nominal_uv(struct ltc4266 *ltc4266, struct device_node *np)
> +{
> +	struct regulator *vpwr;
> +	int uv;
> +
> +	vpwr = of_regulator_get_optional(ltc4266->dev, np, "vpwr");
> +	if (IS_ERR(vpwr)) {
> +		/* -ENODEV means the PI describes no vpwr-supply at all, which
> +		 * is the case the fallback exists for. -EPROBE_DEFER means the
> +		 * rail _is_ described but has not registered yet, so the
> +		 * fallback is wrong for it. Asking for a probe retry is not an
> +		 * option from here: we run from setup_pi_matrix(), and
> +		 * pse_controller_register() unwinds neither its notification
> +		 * fifo nor its pse_pi array when that fails, so every retry
> +		 * would leak. Warn instead so the assumed voltage is visible.
> +		 */
> +		if (PTR_ERR(vpwr) == -EPROBE_DEFER)
> +			dev_warn(ltc4266->dev,
> +				 "%pOF: vpwr-supply is not registered yet, assuming %d uV\n",
> +				 np, LTC4266_VPORT_NOMINAL_UV);
> +
> +		return LTC4266_VPORT_NOMINAL_UV;
> +	}

[Severity: Medium]
Does swallowing -EPROBE_DEFER here actually avoid the leak described in
the comment?

ltc4266_setup_pi_matrix() still has many other error returns that go
through the same unwind gap in pse_controller_register(): DT validation in
ltc4266_get_of_channels() and ltc4266_map_pis(), -ENOMEM, and I2C errors
from ltc4266_port_init().

drivers/net/pse-pd/pse_core.c:pse_controller_register() {
    ...
	if (pcdev->ops->setup_pi_matrix) {
		ret = pcdev->ops->setup_pi_matrix(pcdev);
		if (ret)
			return ret;
	}
    ...
}

In the deferred case, the 50 V nominal voltage stays for the whole life
of the binding. ltc4266_pw_limit_to_icut() uses it whenever an admin limit
is set on an unpowered port.

The deferral can happen in practice. fw_devlink only creates
SYNC_STATE_ONLY links for suppliers referenced from child nodes, such as
the pse-pi nodes, so the supply does not hold back this probe.

Could the unwind in pse_controller_register() be fixed in a prerequisite
patch? Alternatively, the supplies could be resolved before
devm_pse_controller_register() so that probe can return -EPROBE_DEFER.

[Severity: High]
Continuing with a deferred vpwr-supply also has a functional effect. Can
the PI end up with no PSE power domain for good?

If the supply is not registered yet, regulator_resolve_supply() returns
-EPROBE_DEFER and regulator_register() leaves rdev->supply NULL for the PI
regulator. pse_register_pw_ds() runs only once, from
pse_controller_register():

drivers/net/pse-pd/pse_core.c:pse_register_pw_ds() {
    ...
		if (!rdev || !rdev->supply)
			continue;
    ...
}

So pi->pw_d stays NULL even after the supply resolves, and
pse_pw_d_is_sw_pw_control() returns false for this PI. Two things follow.

First, pse_isr() never calls pse_set_config_isr(). The CLASSIFICATION and
DISCONNECTION events from ltc4266_map_event() then never power the port
or re-arm it.

Second, on admin enable pse_pi_enable() calls ltc4266_pi_enable()
directly. That fails in ltc4266_port_get_class() with -EINVAL or -EAGAIN
when no PD has been classified.

The chip runs in semi-auto mode and never powers a port without a PWRPB
write. Would a PD that is plugged in later stay unpowered until the
driver is rebound?

This only affects a supply that is described but deferred. When
vpwr-supply is missing entirely, the dummy regulator is used and a power
domain is still created.

[ ... ]

> +		if (!pi->pairset[0].np)
> +			return dev_err_probe(ltc4266->dev, -EINVAL,
> +					     "%pOF has no pairsets\n", pi->np);

[Severity: Low]
The lltc,ltc4266.yaml binding gives pairsets maxItems: 1 for each pse-pi
node but does not list it as required. pse-controller.yaml only requires
reg and #pse-cells, and of_load_pse_pis() also accepts a PI without
pairsets.

Should the binding list pairsets as required? Otherwise a DT that passes
dt_binding_check fails probe here.

[ ... ]

> +	ret = ltc4266_get_of_channels(ltc4266, chans);
> +	if (!ret)
> +		ret = ltc4266_map_pis(ltc4266, chans);
> +
> +	for (i = 0; i < LTC4266_MAX_PORTS; i++)
> +		of_node_put(chans[i].np);
> +
> +	if (ret)
> +		return ret;

[Severity: Medium]
This is a pre-existing issue, but every error return from
ltc4266_setup_pi_matrix() runs into it.

When setup_pi_matrix() fails, pse_controller_register() returns without
calling kfifo_free(&pcdev->ntf_fifo) or pse_release_pis(), and
devm_pse_controller_register() only calls devres_free(). Would each
failed probe leak the pcdev->pi array and the of_node references on the
PI and pairset nodes?

[ ... ]

> +		if (detevn & LTC4266_EVN_HI(chan)) {
> +			int class = ltc4266_port_get_class(port);
> +
> +			if (class >= 0) {
> +				notifs[i] |= ETHTOOL_C33_PSE_EVENT_CLASSIFICATION;
> +				*notifs_mask |= BIT(i);
> +			}
> +		}

[Severity: Medium]
Should this check whether the port is already powered before reporting a
classification event?

For an admin-enabled PI, pse_set_config_isr() calls
_pse_pi_delivery_power_sw_pw_ctrl() on every CLASSIFICATION event.
pse_pi_allocate_pw_budget_static_prio() does not check for an existing
allocation: it requests budget again and overwrites pi->pw_allocated_mW.
ltc4266_pi_enable() then rewrites ILIM, ICUT and PWRPB on the live port.

Here is one way this could happen. pse_pi_enable() powers the port while
holding pcdev->lock, and a class event is latched at the same time. The
IRQ thread waits for pcdev->lock and then reads the stale DETEVN for a
port that is now powered. A classification that completes between the
DETEVN_COR read and the PWRPB write in the ISR would have the same
effect.

Could this leak the first budget allocation and shut off lower-priority
ports for no reason? It depends on whether the chip raises a new class
event for an unchanged result while MCONF.detchg is set.

> +	}
> +
> +done:
> +	return ltc4266_enable_interrupts(ltc4266);
> +
> +err:
> +	/* (Attempt to) clear any remaining event registers that we might've
> +	 * missed in the event a previous read has failed.
> +	 */
> +	ret = regmap_write(ltc4266->regmap, LTC4266_REG_RSTPB, LTC4266_RSTPB_INTCLR);
> +	if (ret)
> +		dev_warn(&ltc4266->client->dev, "Failed to clear pending interrupts, err=%d\n",
> +			 ret);
> +
> +	return ltc4266_enable_interrupts(ltc4266);
> +}

[Severity: Medium]
Can this error path lose hardware events?

PWREVN_COR, FLTEVN_COR, TSEVN_COR and DETEVN_COR clear on read. When a
later read fails, the latches read before it (for example a tCUT bit in
fltevn or a PG-lost bit in pwrevn) have already been cleared, and their
values are thrown away.

The RSTPB_INTCLR write then clears the latched events on every channel,
including ones that were never read. ltc4266_enable_interrupts() normally
returns 0, so pse_isr() sees success with an empty mask and does nothing.

The reverse case is also a problem. If the INTMASK write in
ltc4266_enable_interrupts() fails after decoding, pse_isr() throws away
the notifications because of the nonzero return:

drivers/net/pse-pd/pse_core.c:pse_isr() {
    ...
	ret = desc->map_event(irq, pcdev, h->notifs, h->notifs_mask);
	if (ret || bitmap_empty(h->notifs_mask, pcdev->nr_lines)) {
		mutex_unlock(&pcdev->lock);
		return IRQ_NONE;
    ...
}

INTMASK also stays at 0 from the ltc4266_disable_interrupts() call at
entry, so no further interrupts would arrive.

With detchg set, a lost classification is not raised again. A lost fault
or PG-loss leaves the core thinking the port is delivering, with its
budget still allocated.

Is there any way for the driver to resync after one I2C error in the IRQ
thread?

> +
> +static const struct regmap_config ltc4266_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x5F,
> +};

[Severity: Low]
Should a precious_reg callback mark the clear-on-read event registers
(0x03, 0x05, 0x07, 0x09, 0x0B) as precious? Without it, a regmap debugfs
registers dump reads them and clears pending detect, class and fault
latches before the IRQ handler sees them. A readable_reg callback would
also stop the dump from reading the reserved addresses in the gaps of the
register map.

[ ... ]

> +	ltc4266->pcdev.owner = THIS_MODULE;
> +	ltc4266->pcdev.ops = &ltc4266_ops;
> +	ltc4266->pcdev.dev = &client->dev;
> +	ltc4266->pcdev.types = ETHTOOL_PSE_C33;
> +	ltc4266->pcdev.nr_lines = LTC4266_MAX_PORTS;
> +	ltc4266->pcdev.supp_budget_eval_strategies = PSE_BUDGET_EVAL_STRAT_STATIC;

[Severity: High]
This isn't a bug introduced by this patch, but choosing the static budget
strategy exposes a lock ordering problem that already exists in the PSE
core.

pse_isr() holds pcdev->lock and ends up taking the supply regulator lock:

pse_isr()
  pse_set_config_isr()
    _pse_pi_delivery_power_sw_pw_ctrl()
      pse_pi_allocate_pw_budget_static_prio()
        regulator_request_power_budget(pw_d->supply)
          regulator_lock(rdev)

An admin enable running at the same time takes the locks in the opposite
order:

regulator_enable(psec->ps)
  regulator_lock_dependent()    (PI rdev, then its supply rdev)
    _regulator_enable()
      pse_pi_is_enabled() / pse_pi_enable()
        mutex_lock(&pcdev->lock)

Can a classification interrupt on one PI, racing with an admin enable of
another PI on the same supply, deadlock both the IRQ thread and the
ethtool task? The ww_mutex scheme cannot break a cycle that includes the
plain pcdev->lock mutex.

> +
> +	ret = devm_pse_controller_register(ltc4266->dev, &ltc4266->pcdev);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to register PSE controller\n");

[Severity: High]
This is a pre-existing issue in the PSE core, but boards with more than
one LTC4266 are likely to hit it.

devm_pse_alloc_pw_d() allocates the power domain with
devm_kzalloc(pcdev->dev) and publishes it in the global pse_pw_d_map.
pse_register_pw_ds() then gives the same object to any other controller
whose PI supply matches:

drivers/net/pse-pd/pse_core.c:pse_register_pw_ds() {
    ...
			if (regulator_is_equal(pw_d->supply, rdev->supply)) {
				present = true;
				pcdev->pi[i].pw_d = pw_d;
    ...
}

Consider all PIs pointing at one shared supply, as in the binding
example, or sharing the dummy regulator when vpwr-supply is omitted.
Unbinding the first controller frees the memory through devres, but the
xarray entry and the other controller's pointers remain.

Would the second controller's pse_flush_pw_ds() then read pw_d->id and
call kref_put_mutex() on freed memory? pse_isr()->
pse_pw_d_is_sw_pw_control() would use the same dangling pointer.

[Severity: Medium]
This is a pre-existing issue, but the teardown order in
pse_controller_unregister() looks unsafe:

drivers/net/pse-pd/pse_core.c:pse_controller_unregister() {
    ...
	pse_flush_pw_ds(pcdev);
	pse_release_pis(pcdev);
	if (pcdev->irq)
		disable_irq(pcdev->irq);
	cancel_work_sync(&pcdev->ntf_work);
    ...
}

pse_send_ntf_worker() takes a psec reference with
pse_control_find_by_id() and drops it with pse_control_put(). If that is
the last reference, __pse_control_release() reads
psec->pcdev->pi[psec->id].admin_state_enabled after pse_release_pis() has
freed the array.

Could the work be cancelled before the PI array is released?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927212929.593366-1-kyle.swenson%40est.tech
