Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800205908DE;
	Thu, 17 Sep 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657345; cv=none; b=bBKBNNq2I629KDwmFdFUU+OiXMmudtTZWDoI+IIaZmo0mauN54H7j9REmAr2o2fhHgrKJk1RyvUZz7wNL81qqcW6NSzpTOrEfxvH2w0NSnFsW+YUnS7tK3tNw6oEPRT/hQymSxGRPBvBYd6Z742u8ZnxHLwyaqSArsnnbjua+58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657345; c=relaxed/simple;
	bh=F1IRr00BthHTI+WG4cb6J7Jf/el2k5jfy0/7x2wK8xY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qtSGVUsMOO/dGLgR300IxmQtbrlfD4U4eyapkxRzAPsNMDIrIXfqjV6KJKzV7GnGrS+Ji5jtJza4twk0voPNM86RiPYLUrHdK2GtXDX88fuX8ZUH8bSWCjcrodYEuGIOz0Kmtpj9L2jiH7MAO48mXGdcHQXml7BQuuGoOVQqWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZ9zjHy8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZ9zjHy8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AB31F008A6;
	Thu, 17 Sep 2026 15:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657320;
	bh=ZR2bmETt+9EVHcEj8ZEi1hwZv2AMgPZTlOOKdbZ8fsI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MZ9zjHy8Zjbno3SteF12V6y2L7ycL1GJfiu9Wvot0gXmKFQF4G1kSiksxwP7FFKp/
	 w0ww1piqnChVxzK1ABanBC27CzyarzRPwAcqaRhL7TbL/FN2Y/L+rsys/+Jux7c+QU
	 NehgssKplbenZKJ+LkN0mLQec+niu6wC7hrKbgnnbyLTQ2VeBBn1rIJu5p/BZGO9NO
	 gu/lGR8LzfGMfxcUSL4LjlQgmh1Q5he+YnjsL5e29ZxDXqwOhGocCE9+UokBsw7XuO
	 dvHVoD8t68YEqXY4O0Hl3a+TGgE/W6h9heU57YgQcb7I4D2yYPTOuf83HgwSBFFTiW
	 TtVRHCCnWUdWA==
Subject: Re: [PATCH net-next v9 14/15] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
From: netdev-bot+sashiko@kernel.org
To: arouhi@sitime.com
Cc: jiri@resnulli.us, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, ivecera@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, cjubran@nvidia.com,
 pabeni@redhat.com, Oleg.Zadorozhnyi@devoxsoftware.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Thu, 17 Sep 2026 15:01:59 +0000
Message-ID: <178965731938.22033.14423120959317442752@kernel.org>
In-Reply-To: <20260915000015.80480-15-arouhi@sitime.com>
References: <20260915000015.80480-15-arouhi@sitime.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 3 · Low: 3

- [High] Unbalanced acquire/release of the exclusive INTSYNC net:
  sit9531x_intsync_enable()/disable() never record ownership; the only…
- [High] The new sit9531x_dpll_intsync_dst_pin_ops wires .prio_set =
  sit9531x_dpll_input_pin_prio_set, which ends with 'while…
- [Medium] sit9531x_intsync_enable() and sit9531x_intsync_disable() write
  the per-page debug key (offset SIT9531X_PLL_REG_DEBUG = 0xBD, value…
- [Medium] Source misattribution after a partially failed disable:
  sit9531x_intsync_disable() clears and commits the global enable bit…
- [Medium] The new source-side loopback check can be bypassed through a
  stale cache: a failed INTSYNC destination removal still rebuilds…
- [Low] The patch adds a second, identical prototype for
  sit9531x_input_prio_present() to core.h; the same declaration already…
- [Low] The patch contains a comment-only rewrite of the
  sit9531x_output_phase_adjust_set() kerneldoc (slot-vs-logical-index…
- [Low] sit9531x_dpll_intsync_dst_state_on_dpll_set() calls
  sit9531x_input_prio_add(), which returns -ENOSPC when the priority…

--

dpll: sit9531x: model the inter-PLL sync net as a pair of pins

The patch exposes the chip's internal inter-PLL sync (INTSYNC) net as two
DPLL pins: an output pin on the PLL that drives the net and an input pin on
each PLL that can select it as a reference.  New core helpers program the
source PLL's EXT page and a detector re-reads which PLL currently drives the
net into sitdev->intsync_src.

A few questions below about the ownership bookkeeping, the debug-key
handling and the new destination pin ops.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index 88bfa63b29755..b15859890caa7 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c
> @@ -2024,12 +2024,13 @@ int sit9531x_output_freq_get(struct sit9531x_dev *sitdev, u8 out_idx,
>   *   base + 3  PROG3  PRG_RST_DELAY[15:8]
>   *   base + 4  PROG2  PRG_RST_DELAY[7:0]
>   *
> - * Outputs 0-5 live on Page 3, outputs 6-11 on Page 4, with each
> - * output's block at base = 0x15 + 16 * (out_idx % 6).
> + * Slots 0-5 live on Page 3, slots 6-11 on Page 4, with each slot's
> + * block at base = 0x15 + 16 * (slot % 6); the slot is the physical
> + * output position from clkout_map[], not the logical output index.
>   *
> - * The chip only supports unsigned positive delay.  A negative phase
> - * adjustment (advance) is wrapped to (T_out - |phase|) modulo one
> - * output period, which is identical for a periodic signal.
> + * The chip only supports unsigned positive delay.  Requests are folded
> + * modulo one output period: positive delays wrap naturally and a negative
> + * phase adjustment (advance) is rendered as (T_out - |phase|).
>   */

[Severity: Low]
This isn't a bug, but is this hunk meant to be part of this patch?  It only
rewrites the documentation block above sit9531x_output_phase_adjust_set()
(slot versus logical index, phase folding wording) and no code in that
function changes, while the commit message describes only the INTSYNC pin
model.  Could it move to its own patch so a reader does not have to check
whether phase-adjust behaviour changed here?

> @@ -2282,6 +2283,225 @@ int sit9531x_clear_notifications(struct sit9531x_dev *sitdev)
>  	return 0;
>  }
>  

[ ... ]

> +int sit9531x_intsync_src_detect(struct sit9531x_dev *sitdev)
> +{
> +	s8 src = -1;
> +	u8 global;
> +	u8 pll, ext_page;
> +	int rc, i;
> +
> +	lockdep_assert_held(&sitdev->multiop_lock);
> +
> +	rc = sit9531x_read_u8(sitdev, SIT9531X_REG_INTSYNC_GLOBAL, &global);
> +	if (rc)
> +		return rc;
> +
> +	if (!(global & BIT(SIT9531X_INTSYNC_EN_BIT))) {
> +		sitdev->intsync_src = -1;
> +		return 0;
> +	}
> +
> +	for (pll = 0; pll < SIT9531X_NUM_PLLS; pll++) {
> +		ext_page = SIT9531X_PLL_EXT_PAGE(pll);
> +
> +		for (i = 0; i < ARRAY_SIZE(intsync_config); i++) {
> +			u16 reg;
> +			u8 val;
> +
> +			reg = SIT9531X_REG(ext_page, intsync_config[i].offset);
> +
> +			rc = sit9531x_read_u8(sitdev, reg, &val);
> +			if (rc)
> +				return rc;
> +			if (val != intsync_config[i].en_val)
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(intsync_config)) {
> +			/*
> +			 * Only one PLL can drive the net.  If a second
> +			 * one matches, the registers are not describing
> +			 * a state this driver put the device in, so say
> +			 * so rather than pick silently.
> +			 */
> +			if (src < 0)
> +				src = pll;
> +			else
> +				dev_warn(sitdev->dev,
> +					 "PLL%c also matches the INTSYNC source pattern; keeping PLL%c\n",
> +					 'A' + pll, 'A' + src);
> +		}
> +	}
> +
> +	sitdev->intsync_src = src;
> +
> +	return 0;
> +}

[Severity: Medium]
Can a partially failed disable make this detector attribute the net to the
wrong PLL?

sit9531x_intsync_disable() clears and commits the global enable bit first,
and only afterwards unlocks the EXT page and writes the eight dis_val
bytes, each with a bare "if (rc) return rc;".  If one of those writes
fails, that PLL's EXT page still holds the complete en_val pattern.

sit9531x_intsync_src_detect() then sees the cleared global bit:

	if (!(global & BIT(SIT9531X_INTSYNC_EN_BIT))) {
		sitdev->intsync_src = -1;
		return 0;
	}

so the leftover pattern is never noticed, and a retry of DISCONNECTED in
sit9531x_dpll_intsync_src_state_on_dpll_set() short-circuits on
"if (sitdev->intsync_src != sitdpll->id) break;".

When a later CONNECTED on another PLL re-asserts the global bit, the loop
here keeps the first matching PLL, so the stale lower-numbered PLL shadows
the PLL that was actually enabled: the newly connected pin reports
DISCONNECTED and cannot be disconnected, an unrelated PLL's source pin
reports CONNECTED, and two PLLs carry the source pattern for one net.
Would clearing the EXT page before the global bit, or recording an
"unknown/needs cleanup" state, be preferable to only warning here?

> +
> +/*
> + * sit9531x_intsync_enable - enable inter-PLL synchronization
> + * @src_pll_idx: source (frequency) PLL index (0-3)
> + *
> + * Enables INTSYNC global bit, unlocks the source PLL's EXT page
> + * debug registers, writes configuration, and triggers a small
> + * update on the source PLL.
> + *
> + * Caller must hold sitdev->multiop_lock.
> + */
> +int sit9531x_intsync_enable(struct sit9531x_dev *sitdev, u8 src_pll_idx)
> +{

[ ... ]

> +	/* Unlock debug on EXT page */
> +	rc = sit9531x_write_u8(sitdev, SIT9531X_REG(ext_page, SIT9531X_PLL_REG_DEBUG),
> +			       SIT9531X_PLL_DEBUG_UNLOCK);
> +	if (rc)
> +		goto err_disable;

[Severity: Medium]
Should the debug key be written back to SIT9531X_PLL_DEBUG_LOCK before
returning?  Both sit9531x_intsync_enable() and sit9531x_intsync_disable()
write SIT9531X_PLL_DEBUG_UNLOCK to SIT9531X_PLL_REG_DEBUG on the source
PLL's EXT page and never restore the lock value, on success or on any error
path (the enable error path calls disable(), which also only unlocks), so
that page's protected debug registers stay open for the lifetime of the
device after any INTSYNC source set or clear.

The existing sit9531x_phase_offset_read() in the same file always closes
the window again:

relock:
	/*
	 * Close the debug window again.  The key register opens every debug
	 * register on this PLL while it holds the unlock value ...
	 */
	lock_rc = sit9531x_write_pll_u8(sitdev, pll_idx,
					SIT9531X_PLL_REG_DEBUG,
					SIT9531X_PLL_DEBUG_LOCK);

Is there a reason the INTSYNC helpers do not follow the same unlock/relock
protocol?

> +
> +	for (i = 0; i < ARRAY_SIZE(intsync_config); i++) {
> +		rc = sit9531x_write_u8(sitdev,
> +				       SIT9531X_REG(ext_page,
> +						    intsync_config[i].offset),
> +				       intsync_config[i].en_val);
> +		if (rc)
> +			goto err_disable;
> +	}
> +
> +	/* Small update on source PLL */
> +	rc = sit9531x_write_pll_u8(sitdev, src_pll_idx,
> +				   SIT9531X_PLL_REG_SMALL_UPDATE,
> +				   SIT9531X_SMALL_UPDATE_CMD);
> +	if (rc)
> +		goto err_disable;
> +
> +	return 0;
> +
> +err_disable:
> +	/*
> +	 * The global enable is already set at this point.  The caller only
> +	 * records the source PLL when this function succeeds, so nothing
> +	 * else will ever clear the bit: undo it here rather than leave the
> +	 * net asserted with a half-written EXT page.
> +	 */

[Severity: High]
Is the caller contract described in this comment actually implemented?
"The caller only records the source PLL when this function succeeds"
suggests the caller assigns sitdev->intsync_src on success, but
sit9531x_dpll_intsync_src_state_on_dpll_set() never assigns it; the only
writer of the field is sit9531x_intsync_src_detect(), whose failure is
downgraded to a dev_warn() there.  See the comment on that call site below.

[ ... ]

> +int sit9531x_intsync_disable(struct sit9531x_dev *sitdev, u8 src_pll_idx)
> +{

[ ... ]

> +	for (i = 0; i < ARRAY_SIZE(intsync_config); i++) {
> +		rc = sit9531x_write_u8(sitdev,
> +				       SIT9531X_REG(ext_page,
> +						    intsync_config[i].offset),
> +				       intsync_config[i].dis_val);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	/* Small update on source PLL */
> +	rc = sit9531x_write_pll_u8(sitdev, src_pll_idx,
> +				   SIT9531X_PLL_REG_SMALL_UPDATE,
> +				   SIT9531X_SMALL_UPDATE_CMD);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
> index 1f77ff28ec814..5275733a3b4a9 100644
> --- a/drivers/dpll/sit9531x/core.h
> +++ b/drivers/dpll/sit9531x/core.h
> @@ -252,6 +252,8 @@ int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,
>  			    u8 input_idx, u8 prio);
>  int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,
>  			    u8 input_idx, u8 *prio);
> +bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev,
> +				 u8 pll_idx, u8 input_idx);
>  int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,
>  			       u8 input_idx);

[Severity: Low]
This isn't a bug, but core.h already declares sit9531x_input_prio_present()
with exactly this prototype a few lines above, under the input priority
comment, before this patch.  Is this second declaration left over from a
rebase?  It can be dropped.

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> index 2a973364a9cd2..3efe6fc90701d 100644
> --- a/drivers/dpll/sit9531x/dpll.c
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -792,8 +806,222 @@ sit9531x_dpll_output_pin_direction_get(const struct dpll_pin *pin,

[ ... ]

> +	switch (state) {
> +	case DPLL_PIN_STATE_CONNECTED:
> +		if (sitdev->intsync_src == sitdpll->id)
> +			break;
> +		if (sitdev->intsync_src >= 0) {
> +			NL_SET_ERR_MSG(extack,
> +				       "INTSYNC is already sourced by another PLL");
> +			rc = -EBUSY;
> +			break;
> +		}
> +		/*
> +		 * A PLL that already lists INTSYNC among its references must
> +		 * not also drive it: the destination side refuses the mirror
> +		 * of this, and without the check here the net could be routed
> +		 * back into the PLL feeding it.
> +		 */
> +		if (sit9531x_input_prio_present(sitdev, sitdpll->id,
> +						sit9531x_input_hw_src(SIT9531X_INTSYNC_PIN_ID))) {
> +			NL_SET_ERR_MSG(extack,
> +				       "PLL selects INTSYNC as a reference; it cannot drive it");
> +			rc = -EBUSY;
> +			break;
> +		}
> +		rc = sit9531x_intsync_enable(sitdev, sitdpll->id);
> +		break;

[Severity: Medium]
Can this loopback check be bypassed by a stale priority mask?

sit9531x_input_prio_present() reads only chan->prio_mask:

	return !!(sitdev->chan[pll_idx].prio_mask & BIT(input_idx));

and sit9531x_prio_table_commit() rebuilds that mask from the *intended*
table even when a slot write failed:

	sit9531x_prio_mask_build(sitdev, pll_idx, srcs);

So after a failed DISCONNECTED on the INTSYNC destination pin of a PLL
(sit9531x_dpll_intsync_dst_state_on_dpll_set() -> sit9531x_input_prio_remove()
-> sit9531x_prio_table_commit()), the mask says INTSYNC is absent while the
hardware slot still holds it.  A CONNECTED request on the same PLL's source
pin before the next periodic sit9531x_chan_state_fetch() re-read then passes
this check and calls sit9531x_intsync_enable(), which is the self-reference
the check exists to prevent.  Would reading the table back here, or not
updating the mask on a partial commit, close that window?

> +	case DPLL_PIN_STATE_DISCONNECTED:
> +		if (sitdev->intsync_src != sitdpll->id)
> +			break;
> +		rc = sit9531x_intsync_disable(sitdev, sitdpll->id);
> +		break;
> +	default:
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	/*
> +	 * Re-scan hardware after source state transitions so cache follows
> +	 * partially failed enable/disable paths as closely as possible.
> +	 */
> +	if (state == DPLL_PIN_STATE_CONNECTED ||
> +	    state == DPLL_PIN_STATE_DISCONNECTED)
> +		detect_rc = sit9531x_intsync_src_detect(sitdev);
> +	/*
> +	 * The refresh only re-reads what the device now shows.  Failing
> +	 * the request because that read hit a bus error would tell
> +	 * userspace the enable did not happen when it did.
> +	 */
> +	if (detect_rc)
> +		dev_warn(sitdev->dev,
> +			 "INTSYNC source cache not refreshed: %d\n",
> +			 detect_rc);

[Severity: High]
Can the net become impossible to release when this refresh fails?

sit9531x_intsync_enable() and sit9531x_intsync_disable() never touch
sitdev->intsync_src, so this detect call is the only thing that records
ownership.  In sit9531x_intsync_src_detect() any read error returns before
the assignment:

			rc = sit9531x_read_u8(sitdev, reg, &val);
			if (rc)
				return rc;
	...
	sitdev->intsync_src = src;

So one i2c read error after a successful enable leaves intsync_src == -1
while the hardware drives the net.  From then on:

  - the source pin's state_on_dpll_get reports DISCONNECTED,
  - a DISCONNECTED request hits "if (sitdev->intsync_src != sitdpll->id)
    break;" and never calls sit9531x_intsync_disable(),
  - the "already sourced by another PLL" check passes, so a second PLL can
    be programmed onto the same single net,
  - the destination-side "PLL cannot lock to the INTSYNC it drives" guard
    stops matching.

sit9531x_dev_periodic_work() refreshes only ref[] and chan[] and never
re-runs the INTSYNC detect, so the divergence is not repaired later.  The
mirror case (successful disable, failed detect) keeps a stale positive
value and refuses every other PLL with -EBUSY.

Would recording ownership directly in the enable/disable helpers on success
(and clearing it on success of disable), instead of relying on a fallible
readback whose error is only warned about, avoid this?

>  /* ---- INTSYNC destination (input) pin ---- */
>  

[ ... ]

> +	switch (state) {
> +	case DPLL_PIN_STATE_DISCONNECTED:
> +		rc = sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);
> +		break;
> +	case DPLL_PIN_STATE_CONNECTED:
> +		NL_SET_ERR_MSG(extack,
> +			       "Device selects its reference by priority; use selectable");
> +		rc = -EOPNOTSUPP;
> +		break;
> +	case DPLL_PIN_STATE_SELECTABLE:
> +		if (sitdev->intsync_src == sitdpll->id) {
> +			NL_SET_ERR_MSG(extack,
> +				       "PLL cannot lock to the INTSYNC it drives");
> +			rc = -EINVAL;
> +			break;
> +		}
> +		rc = sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);
> +		break;
> +	default:
> +		rc = -EINVAL;
> +		break;
> +	}
> +
> +	mutex_unlock(&sitdev->multiop_lock);
> +
> +	if (rc == -EBUSY)
> +		NL_SET_ERR_MSG(extack,
> +			       "Only source left in the priority table; it cannot be emptied");
> +	else if (rc && rc != -EINVAL && rc != -EOPNOTSUPP)
> +		NL_SET_ERR_MSG(extack, "Failed to set INTSYNC input state");

[Severity: Low]
Should -ENOSPC get its own message here?  sit9531x_input_prio_add()
returns -ENOSPC when the priority table is full of unique sources, and this
tail reports that as "Failed to set INTSYNC input state", which reads like
a bus failure.

The physical-input peer, sit9531x_dpll_input_pin_state_on_dpll_set(), calls
the same helper and maps it explicitly:

	else if (rc == -ENOSPC)
		NL_SET_ERR_MSG(extack,
			       "Priority table is full of unique sources on this PLL");

The comment above this function says it "accepts and refuses what a
physical input does", so is the divergence intentional?

> +
> +	return rc;
> +}
> +
> +/*
> + * Do not add .frequency_get / the generic input state getter here: the
> + * destination pin id is SIT9531X_INTSYNC_PIN_ID, one past the end of the
> + * ref[] array (INTSYNC is an internal net with no ref[] entry).  The ops
> + * below only ever key on chan[] and the priority table, never ref[id].
> + */
> +static const struct dpll_pin_ops sit9531x_dpll_intsync_dst_pin_ops = {
> +	.direction_get		= sit9531x_dpll_input_pin_direction_get,
> +	.state_on_dpll_get	= sit9531x_dpll_intsync_dst_state_on_dpll_get,
> +	.state_on_dpll_set	= sit9531x_dpll_intsync_dst_state_on_dpll_set,
> +	.prio_get		= sit9531x_dpll_input_pin_prio_get,
> +	.prio_set		= sit9531x_dpll_input_pin_prio_set,
> +};

[Severity: High]
Does wiring .prio_set here make a recursive dpll_lock acquisition reachable
on four more pins?

sit9531x_dpll_input_pin_prio_set() ends with:

	while (changed_cnt--)
		dpll_pin_change_ntf(changed[changed_cnt]);

and dpll_pin_change_ntf() takes the lock itself:

int dpll_pin_change_ntf(struct dpll_pin *pin)
{
	int ret;

	mutex_lock(&dpll_lock);

but every dpll_pin_ops callback already runs with dpll_lock held:
DPLL_CMD_PIN_SET uses .pre_doit = dpll_pin_pre_doit, which does
mutex_lock(&dpll_lock) and returns with it held until dpll_pin_post_doit(),
and dpll_pin_set_from_nlattr() -> dpll_pin_prio_set() invokes ops->prio_set
under it.  A DPLL_CMD_PIN_SET carrying DPLL_A_PIN_PRIO would then
re-acquire a non-recursive mutex the task already holds.

The path was introduced earlier in this series by "dpll: sit9531x: add
support to get and set priority on input pins", and this patch attaches the
same prio_set to the INTSYNC destination pin of each PLL, and makes that
pin a sibling candidate in the loop that fills changed[], so it can also
raise changed_cnt for the physical input pins.  Note the driver's own
comment in sit9531x_dev_periodic_work() states that "Those notification
helpers take DPLL-subsystem locks that are already held when our callbacks
are invoked from netlink context".

Would __dpll_pin_change_ntf(), which has lockdep_assert_held(&dpll_lock),
be the right helper here, or should the notification not be emitted from
inside the callback at all?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915000015.80480-1-arouhi%40sitime.com
