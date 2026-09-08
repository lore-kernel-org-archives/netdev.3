Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7C54854E;
	Tue,  8 Sep 2026 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871534; cv=none; b=K0aBo1CxEnhsknnQYt9FbmCDmYEdRqGMg+uEMTjUlSfXWgZNt9Xx0xNrMK3FlLjMEBq0AA2XIv1fJX9CiclCc1TbGwq+KMZejT9W99xDwQxkqMQBNLqDbDJG8HNyULZMrAzotO59EvGuvfsaJO7h7+qGcgzS1TPuFQZ5YxNGInk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871534; c=relaxed/simple;
	bh=qWxrKkRktJlipaCFV6BnCpcQlsI6gf95nCc9DsaXUl0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WP16QZE2Mq113V3XM1UJQlWS1HK4y1UzM9Hrl026cGuojTnyp+YTvT75kuVa6BnOScNeLDNEQ18BkCTcsRcpMA5h85G0b/i+68Hg+iDTpD4EUs7MnUm0/9+KSRVbiAaIIyVTd/MPRK/9866ulDlBguIGAggju0/C2dm38nIlqCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCydSy+6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCydSy+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDEB1F00A3A;
	Tue,  8 Sep 2026 12:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871531;
	bh=Ql6AaNeN8xUnMvtzo/EPPblpYT+zOocvur1B59e26+Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XCydSy+6D0t424342OG9H248P1EMIMZG9mZWLt+BneMczVRR1sidJyyXx8v8qj8Jm
	 PoRARJG4+S0g1wK5ero69711leGHdSR6ZBJf0jZPZ2oaoNaFFnNG9di9a3u/95p50R
	 cuK8FfP6eV4FLYmUug39Udm4G+XP9E1dOZJx+lVBSzjiJfqHTibHYMp5I1AreB0FHx
	 HAwsl4oSe+rf6rcm8XP7EmnWIbM1rUsiYPvu1h4K0B+qoWtDJI0uBIYl99XOpWv5Oq
	 XUbXIT9SDYKV4fu5IA3JrGSD1+FHea+ejNmdr8hYivlwibduC9zXLOgg16r0CibNQA
	 /yu2L4Jm33A0A==
Subject: Re: [PATCH net-next v8 14/15] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 Oleg.Zadorozhnyi@devoxsoftware.com, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 08 Sep 2026 12:45:28 +0000
Message-ID: <178887152869.219967.4994728950594018497@kernel.org>
In-Reply-To: <20260902214030.20955-15-arouhi@sitime.com>
References: <20260902214030.20955-15-arouhi@sitime.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 4 · Low: 1 (1)

- [High] The INTSYNC net owner is tracked only by the software field
  sitdev->intsync_src, which is never reconciled with the hardware.
- [Medium] The commit message claims this patch models INTSYNC as a pair
  of pins, but the model and the pin registration already exist in the…
- [Medium] The new INTSYNC destination pin reports the hardware's
  automatic selection through DPLL_A_PIN_STATE instead of preserving the…
- [Medium] A partially failed disable leaves the cached owner naming a
  PLL that no longer drives the net, and the natural retry is a silent…
- [Medium] sit9531x_intsync_enable()'s err_disable label calls
  sit9531x_intsync_disable() and discards its return code…
- [Low] sit9531x_dpll_intsync_src_state_on_dpll_set() rejects
  DPLL_PIN_STATE_SELECTABLE with -EINVAL from the default case as…

Pre-existing issues:
- [Low] The new INTSYNC destination ops expose the generic priority
  getter, which reports an out-of-contract priority value when the…

--

dpll: sit9531x: model the inter-PLL sync net as a pair of pins

This adds the register sequences that enable and disable the chip's
internal inter-PLL sync net (INTSYNC), plus two specialized dpll_pin_ops
tables: an output pin on the PLL that drives the net and an input pin on
each PLL that can select it.  Ownership of the net is tracked in the
software field sitdev->intsync_src.

No Link: tags in the commit header.

A few questions below about the ownership tracking and the failure paths.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index bd251ab60eee..c3d7c4851549 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -1686,6 +1686,160 @@ int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)
>  	return 0;
>  }
>  
> +/*
> + * INTSYNC configuration register values.
> + * These are written to the source PLL's EXT page to enable/disable
> + * inter-PLL synchronization (lock frequency PLL to phase PLL).
> + */
> +struct sit9531x_intsync_reg {
> +	u8 offset;
> +	u8 en_val;
> +	u8 dis_val;
> +};
> +
> +static const struct sit9531x_intsync_reg intsync_config[] = {
> +	{ 0x2D, 0x02, 0x00 },
> +	{ 0x50, 0x08, 0x00 },
> +	{ 0x51, 0x04, 0x00 },
> +	{ 0x54, 0x02, 0x00 },
> +	{ 0x55, 0x28, 0x20 },
> +	{ 0x5C, 0x0F, 0x00 },
> +	{ 0x5D, 0xFF, 0x00 },
> +	{ 0x6C, 0xDD, 0x00 },
> +};

[ ... ]

> +int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx)
> +{

[ ... ]

> +	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);
> +	if (rc)
> +		return rc;
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,
> +			       val | BIT(SIT9531X_INTSYNC_EN_BIT));
> +	if (rc)
> +		return rc;

[ ... ]

> +	for (i = 0; i < ARRAY_SIZE(intsync_config); i++) {
> +		rc = sit9531x_write_u8(sitdev,
> +				       SIT9531X_REG(ext_page,
> +						    intsync_config[i].offset),
> +				       intsync_config[i].en_val);
> +		if (rc)
> +			goto err_disable;
> +	}

[ ... ]

> +	return 0;
> +
> +err_disable:
> +	/*
> +	 * The global enable is already set at this point.  The caller only
> +	 * records the source PLL when this function succeeds, so nothing
> +	 * else will ever clear the bit: undo it here rather than leave the
> +	 * net asserted with a half-written EXT page.
> +	 */
> +	sit9531x_intsync_disable(sitdev, src_pll_idx);
> +
> +	return rc;
> +}

[Severity: Medium]
The comment says nothing else will ever clear the global bit, but the
rollback's own return code is discarded here.  Can the bit be stranded when
the rollback itself fails?

err_disable is only reached because a register access on this I2C bus just
failed, and sit9531x_intsync_disable() begins with two accesses on the same
bus:

	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);
	if (rc)
		return rc;
	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,
			       val & ~BIT(SIT9531X_INTSYNC_EN_BIT));
	if (rc)
		return rc;

If either fails, the global enable bit is still set on return.  The caller in
sit9531x_dpll_intsync_src_state_on_dpll_set() records the owner only on
success:

		rc = sit9531x_intsync_enable(sitdev, sitdpll->id);
		if (!rc)
			sitdev->intsync_src = sitdpll->id;

so intsync_src stays -1, and the DISCONNECTED branch short-circuits on
"if (sitdev->intsync_src != sitdpll->id) break;".  Since these two helpers
are the only writers of that bit and both are reached only through paths
keyed on intsync_src, is there any path left that can clear it?

A later CONNECTED request on a different PLL then passes the
"if (sitdev->intsync_src >= 0)" gate and programs that PLL's EXT page while
the first PLL's EXT page still holds the partially applied enable values
(0x2D/0x50/0x51/0x54/0x55/0x5C/0x5D/0x6C), so two PLLs end up configured
toward the same single-driver net.  Would propagating the rollback's error,
or recording the attempted owner, make that recoverable?

Separately, this rollback is not a restore: it writes the fixed dis_val to
all eight intsync_config entries, including the ones the aborted enable
never touched (0x20 to offset 0x55, 0x00 to 0x5C/0x5D/0x6C).  A failure at
i == 0 therefore overwrites eight EXT-page registers that still held their
power-on/NVM values with hardcoded constants.  Is that intended?

> +int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx)
> +{

[ ... ]

> +	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &val);
> +	if (rc)
> +		return rc;
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL,
> +			       val & ~BIT(SIT9531X_INTSYNC_EN_BIT));
> +	if (rc)
> +		return rc;
> +
> +	/* Small update on Page 0 */
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,
> +			       SIT9531X_SMALL_UPDATE_CMD);
> +	if (rc)
> +		return rc;
> +
> +	/* Unlock debug on EXT page */
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(ext_page, SIT9531X_PLL_REG_DEBUG),
> +			       SIT9531X_PLL_DEBUG_UNLOCK);
> +	if (rc)
> +		return rc;
> +
> +	for (i = 0; i < ARRAY_SIZE(intsync_config); i++) {
> +		rc = sit9531x_write_u8(sitdev,
> +				       SIT9531X_REG(ext_page,
> +						    intsync_config[i].offset),
> +				       intsync_config[i].dis_val);
> +		if (rc)
> +			return rc;
> +	}

[Severity: Medium]
The authoritative enable bit is cleared and committed by the first three
accesses here, then roughly ten more accesses follow, each returning early
with no rollback.  What state is the driver in if one of the later ones
fails?

The net is already off in hardware, but the caller keeps the cached owner:

	case DPLL_PIN_STATE_DISCONNECTED:
		if (sitdev->intsync_src != sitdpll->id)
			break;
		rc = sit9531x_intsync_disable(sitdev, sitdpll->id);
		if (!rc)
			sitdev->intsync_src = -1;

So intsync_src still names this PLL while it no longer drives the net.
sit9531x_dpll_intsync_src_state_on_dpll_get() then reports CONNECTED,
sit9531x_dpll_intsync_dst_state_on_dpll_get() reports DISCONNECTED for the
same PLL, and sit9531x_dpll_intsync_dst_state_on_dpll_set() refuses
SELECTABLE with "PLL cannot lock to the INTSYNC it drives".

Re-issuing CONNECTED on that PLL cannot repair it either, because the fast
path "if (sitdev->intsync_src == sitdpll->id) break;" returns 0 without
touching hardware, and every other PLL is refused with -EBUSY.  Is a second
DISCONNECTED really the only way to converge, and would clearing the cache
unconditionally (or on the first committed write) be preferable?

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 1a14255e89a8..993a991d5b25 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c

[ ... ]

> @@ -717,8 +731,214 @@ sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,
>  				       enum dpll_pin_direction *direction,
>  				       struct netlink_ext_ack *extack);
>  
> +static int
> +sit9531x_dpll_intsync_src_state_on_dpll_get(const struct dpll_pin *pin,
> +					    void *pin_priv,
> +					    const struct dpll_device *dpll,
> +					    void *dpll_priv,
> +					    enum dpll_pin_state *state,
> +					    struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +	if (sitdev->intsync_src == sitdpll->id)
> +		*state = DPLL_PIN_STATE_CONNECTED;
> +	else
> +		*state = DPLL_PIN_STATE_DISCONNECTED;
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	return 0;
> +}

[Severity: High]
Is intsync_src ever reconciled with the hardware?  sit9531x_dev_probe() does

	sitdev->intsync_src = -1;

and grep shows SIT9531X_REG_INTSYNC_GLOBAL is read only inside
sit9531x_intsync_enable() and sit9531x_intsync_disable(), so neither probe,
sit9531x_dev_state_fetch() nor the periodic poller samples it.
sit9531x_i2c_driver also defines only .probe, with no .remove or .shutdown,
so an enable done through the new source pin stays programmed in the chip
across unbind.

Concrete sequence: set the SYNCOUT pin CONNECTED on PLL A (hardware enabled,
intsync_src == 0), then unbind and rebind the i2c device.  The chip is still
driving the net while probe forces intsync_src back to -1.  In that state:

- this getter reports DISCONNECTED on all four DPLLs while the net is driven;

- a CONNECTED request on PLL B passes

		if (sitdev->intsync_src >= 0) {

  and programs B's EXT page while A's EXT page still drives the same net;

- a DISCONNECTED request on the real source hits

		if (sitdev->intsync_src != sitdpll->id)
			break;

  and returns success without touching a register;

- the mirror guard "PLL cannot lock to the INTSYNC it drives" no longer
  applies to the real source, so SRC_INTSYNC can be added to the driving
  PLL's own priority table.

The same divergence appears at first probe on boards whose efuse/NVM blob
boots with an INTSYNC PLL already configured, which the driver documents
elsewhere in core.c ("some configs (e.g. an INTSYNC PLL) run a VCO that
Fref*DIVN does not reproduce"), since probe deliberately never resets the
chip.  Could intsync_src be seeded from the global enable bit plus the
per-PLL EXT configuration at probe (or the disable sequence run once at
init), and INTSYNC disabled at teardown?

The core.h comment describes the field as "PLL index currently sourcing
inter-PLL synchronization (INTSYNC), or -1 when disabled", which is what the
code does not currently guarantee.

> +
> +/*
> + * sit9531x_dpll_intsync_src_state_on_dpll_set - drive INTSYNC from a PLL
> + *
> + *   CONNECTED    -> this PLL drives the INTSYNC net
> + *   DISCONNECTED -> stop driving INTSYNC if this PLL drives it
> + *
> + * SELECTABLE is rejected: driving the net is an explicit output routing,
> + * not an automatic-selection candidate, matching the regular output pin.
> + */

[ ... ]

> +	default:
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	if (rc && rc != -EBUSY)
> +		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC source state");
> +
> +	return rc;
> +}

[Severity: Low]
A SELECTABLE request is a documented policy rejection returning -EINVAL from
the default case, but this filter only excludes -EBUSY, so userspace gets the
hardware-failure text "Failed to set INTSYNC source state" for it.  Should
the policy errno be excluded here as the two peer setters in this file do?

sit9531x_dpll_intsync_dst_state_on_dpll_set() uses

	else if (rc && rc != -EINVAL && rc != -EOPNOTSUPP)

and sit9531x_dpll_input_pin_state_on_dpll_set() uses

	else if (rc && rc != -EOPNOTSUPP && rc != -EINVAL)

> +
> +static const struct dpll_pin_ops sit9531x_dpll_intsync_src_pin_ops = {
> +	.direction_get		= sit9531x_dpll_output_pin_direction_get,
> +	.state_on_dpll_get	= sit9531x_dpll_intsync_src_state_on_dpll_get,
> +	.state_on_dpll_set	= sit9531x_dpll_intsync_src_state_on_dpll_set,
> +};
> +
>  /* ---- INTSYNC destination (input) pin ---- */
>  
> +/*
> + * sit9531x_dpll_intsync_dst_state_on_dpll_get - INTSYNC reference state
> + *
> + * Selection role, so the contract above decides this exactly as it does
> + * for a physical input: the priority table is the eligibility record, and
> + * whether a source PLL happens to be driving the net right now is no more
> + * a state than a momentary LOS is on an external reference.  The one
> + * addition is that the PLL driving INTSYNC is never its own destination.
> + */
> +static int
> +sit9531x_dpll_intsync_dst_state_on_dpll_get(const struct dpll_pin *pin,
> +					    void *pin_priv,
> +					    const struct dpll_device *dpll,
> +					    void *dpll_priv,
> +					    enum dpll_pin_state *state,
> +					    struct netlink_ext_ack *extack)
> +{
> +	struct sit9531x_dpll *sitdpll = dpll_priv;
> +	struct sit9531x_dev *sitdev = sitdpll->dev;
> +
> +	mutex_lock(&sitdev->multiop_lock);
> +	if (sitdev->intsync_src == sitdpll->id)
> +		*state = DPLL_PIN_STATE_DISCONNECTED;
> +	else
> +		sit9531x_dpll_selection_state_get(sitdev, sitdpll,
> +						  SIT9531X_INTSYNC_PIN_ID,
> +						  state);
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	return 0;
> +}

[Severity: Medium]
Should the hardware's current selection be reported through
DPLL_A_PIN_OPERSTATE rather than DPLL_A_PIN_STATE here?

Documentation/driver-api/dpll.rst says "Pin state (DPLL_A_PIN_STATE)
reflects the administrative intent set by the user. Pin operational state
(DPLL_A_PIN_OPERSTATE) reflects what the hardware is actually doing with the
pin", and in automatic mode the user may request only SELECTABLE or
DISCONNECTED.

The setter honours that (it rejects CONNECTED with -EOPNOTSUPP), but this
getter delegates to sit9531x_dpll_selection_state_get(), which returns
CONNECTED when

	active_input = !chan->mode && chan->locked && !chan->inner_lol &&
		       chan->selected_ref == pin_id;

So a user sets SELECTABLE and reads back CONNECTED, a value the setter
refuses, and autonomous re-selection generates state notifications for
unchanged administrative intent.  sit9531x_dpll_intsync_dst_pin_ops also has
no .operstate_on_dpll_get, so the actual-selection information has no
attribute of its own.

zl3073x_dpll_input_pin_state_on_dpll_get() returns SELECTABLE in AUTO mode
and reports the active reference from
zl3073x_dpll_input_pin_operstate_on_dpll_get() instead.

> +
> +/*
> + * sit9531x_dpll_intsync_dst_state_on_dpll_set - lock a PLL to INTSYNC

[ ... ]

> +	case DPLL_PIN_STATE_CONNECTED:
> +		NL_SET_ERR_MSG(extack,
> +			       "Device selects its reference by priority; use selectable");
> +		rc = -EOPNOTSUPP;
> +		break;

[ ... ]

> +static const struct dpll_pin_ops sit9531x_dpll_intsync_dst_pin_ops = {
> +	.direction_get		= sit9531x_dpll_input_pin_direction_get,
> +	.state_on_dpll_get	= sit9531x_dpll_intsync_dst_state_on_dpll_get,
> +	.state_on_dpll_set	= sit9531x_dpll_intsync_dst_state_on_dpll_set,
> +	.prio_get		= sit9531x_dpll_input_pin_prio_get,
> +	.prio_set		= sit9531x_dpll_input_pin_prio_set,
> +};

[Severity: Low]
This isn't a bug introduced by this patch, but reusing the generic priority
getter for the new pin also inherits its out-of-contract return value when
the source is absent from the PLL's priority table.

sit9531x_input_prio_get() uses an in-band sentinel:

	*prio = SIT9531X_PRIO_MAX_SLOTS;
	return 0;

and sit9531x_dpll_input_pin_prio_get() passes it on as a successful result:

	dpin->prio = slot;
	*prio = slot;
	return 0;

so DPLL_A_PIN_PRIO reports 11 for a disconnected INTSYNC destination, while
sit9531x_dpll_input_pin_prio_set() rejects that value:

	if (prio >= SIT9531X_PRIO_MAX_SLOTS) {
		NL_SET_ERR_MSG(extack, "Priority out of range (0-10)");
		return -EINVAL;
	}

The sentinel-leaking getter came in with the earlier priority patch in this
series and applies to all physical input pins as well.

> @@ -1044,8 +1264,13 @@ static const struct dpll_pin_ops sit9531x_dpll_output_pin_ops = {
>  const struct dpll_pin_ops *
>  sit9531x_dpll_pin_ops_get(const struct sit9531x_dpll_pin *pin)
>  {
> -	if (!sit9531x_dpll_is_input_pin(pin))
> +	if (!sit9531x_dpll_is_input_pin(pin)) {
> +		if (sit9531x_dpll_is_intsync_src_pin(pin))
> +			return &sit9531x_dpll_intsync_src_pin_ops;
>  		return &sit9531x_dpll_output_pin_ops;
> +	}
> +	if (sit9531x_dpll_is_intsync_pin(pin))
> +		return &sit9531x_dpll_intsync_dst_pin_ops;
>  	if (sit9531x_dpll_is_xo_pin(pin))
>  		return &sit9531x_dpll_xo_pin_ops;
>  	return &sit9531x_dpll_input_pin_ops;

[Severity: Medium]
The commit message says the two ends "are two pins rather than one: an
output pin on the source and an input pin on each destination", but is that
model actually introduced here?

At the parent revision core.h already defines

	#define SIT9531X_INTSYNC_PIN_ID		(SIT9531X_MAX_INPUTS + 1)
	#define SIT9531X_INTSYNC_OUT_PIN_ID	SIT9531X_MAX_OUTPUTS

and sit9531x_dpll_pin_is_registrable() already returns true for both:

	if (dir == DPLL_PIN_DIRECTION_INPUT) {
		/* The internal INTSYNC and XO pins are always registrable */
		if (index == SIT9531X_INTSYNC_PIN_ID ||
		    index == SIT9531X_MAX_INPUTS)
			return true;

What this patch adds is the dispatch above.  Without it, the destination pin
gets sit9531x_dpll_input_pin_ops and the source pin gets
sit9531x_dpll_output_pin_ops, and those handlers index arrays by pin id:

	struct sit9531x_ref *ref = &sitdev->ref[dpin->id];

	actual_pll = sitdev->out[dpin->id].pll_idx;

ref[] is sized SIT9531X_MAX_INPUTS + 1 and out[] is sized
SIT9531X_MAX_OUTPUTS, so both INTSYNC ids are one past the end.  The new
comment above sit9531x_dpll_intsync_dst_pin_ops notes the same thing ("one
past the end of the ref[] array").

Does that mean every bisect point between the pin-registration patch and
this one lets a DPLL_CMD_PIN_SET on the INTSYNC pins read past ref[] or
out[]?  Would reordering or squashing the registration and the specialized
ops avoid that, and could the message say it adds the ops for an already
registered pair rather than introducing the model?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902214030.20955-1-arouhi%40sitime.com
