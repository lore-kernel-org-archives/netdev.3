Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB236DA1A;
	Sat, 26 Sep 2026 02:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390087; cv=none; b=S6gsBkOIK4bokX8r1voTL5BlVqHgKX6iwoZxYPsbGOWq9yjsv5R+g+3S7SGJlRyolvET4XYF/38gcK7x+2/4E1C8FETqjxGFqFtWK7e6OU9QvDUYUikOdzdBGz8byK3RsCMxvi+1m3aPOLYmueS3Kljn2rh4ZwfINtWJqqQSy9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390087; c=relaxed/simple;
	bh=AARqjVEDcavtnbknQomUJ67HKkoLkCdOmefuyAJL1XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rlt/ZB9RTD59asJ7+RPU+IrKNFY08h2abHNzMWvHRL89OC7SU+OakHmEKtO/vVfG2ajwZrAQMaoD5+PU8B0fim6KzRR6+0Bnlrodl/0hfFWNTG3ySnuXuCMcJYlK5D8vfqSAKHjrLaOmRPGJN7rEkoctkI4O4pBeKAg3hgK6090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl/bsSlc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl/bsSlc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DA61F00893;
	Sat, 26 Sep 2026 02:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390085;
	bh=BvLRVmoicuTWEFgqhLbMPuS9baXklf/czmT+bqzxR7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nl/bsSlc4injszo25HrbMcAwxeq+QjL5JaXaxPXu+zr5+auP3NkUdNhrcbPyqjgfM
	 iul06kxgkLuHXc1zLOU72PT88OxNgmfUIvOBqmfw53rpbjcK5+CLUKzA9wLDIFgBcV
	 V8t0QmizkTz5ZPDTVstnECs5mLPjATF17iLE1UiqWRLPzzm9TNYRaYtrpDNun6zBXJ
	 xAXQ3lW+QjWskI2l6P4ub0Jhjancm8m+TS5lxlQKivSNyGLb+m2a4yRyAvbWrKkTnZ
	 ywUQmjh8JD1DSk2iBj/YJl5y8wp/U9+40k3IyG1vgP45kOxxe2NC+/GlSypmcBoJ/L
	 a8YHX4RiextcQ==
From: Jakub Kicinski <kuba@kernel.org>
To: arouhi@sitime.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	ivecera@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	pabeni@redhat.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/14] dpll: sit9531x: register DPLL devices and pins
Date: Fri, 25 Sep 2026 19:34:44 -0700
Message-ID: <20260926023444.1567660-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-6-arouhi@sitime.com>
References: <20260921201108.42676-6-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpll: sit9531x: register DPLL devices and pins

This patch registers each of the four SiT9531x PLLs as a DPLL device.
Each device gets lock status and mode callbacks, and the crystal is
registered as a permanently connected input pin on each one.

A kthread worker polls PLL and input state twice a second into a cache.
It notifies the DPLL core when something changes, and the optional INTRB
interrupt can kick it early.

The clock_id is built from the chip variant, the I2C address and the low
eight bits of the adapter number.

> diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c
> index cf1cda87fa52c..6f19dab89beeb 100644
> --- a/drivers/dpll/sit9531x/core.c
> +++ b/drivers/dpll/sit9531x/core.c

[ ... ]

> +/*
> + * Report whether a slot is currently forced into Hi-Z, i.e. the driver
> + * (or the blob) took control of the Hi-Z state (MASK bit set) and drives
> + * it low (STATE bit clear).  Either register pair muting the slot counts,
> + * mirroring what sit9531x_output_disable() programs.
> + */
> +static int sit9531x_output_forced_hiz(struct sit9531x_dev *sitdev,
> +				      u8 out_idx, bool *muted)

[ ... ]

> +	 * Read the pair that belongs to the way this output is wired.
> +	 * Testing both and taking either as proof of a mute answers
> +	 * from a register nothing drives, and disagrees with itself
> +	 * when a mute lands on one pair and fails on the other.
>  	 */

[Severity: Low]
This isn't a bug, but several comments added in this patch don't match
the code.

The header comment says that either register pair muting the slot counts.
The body reads only the pair chosen by out->cmos, and its own comment
rejects the either-pair approach. Also, sit9531x_output_disable() does not
exist yet in this commit.

Some others in the same patch:

sit9531x_ref_state_fetch() is documented as "Reads LOS and OOF status for
the given input lane from the Page 0x06 clock monitor registers". It
actually reads the Page 0x02 force/state registers through
sit9531x_input_get_regs(), and it only sets ref->enabled.

The kernel-doc blocks for sit9531x_chan_state_fetch and sit9531x_dev_start
sit above sit9531x_pll_is_active() and sit9531x_eeprom_state_report(). They
end up documenting the wrong functions.

In struct sit9531x_chan, @locked is described as "PLL is locked (raw status
register bit)". sit9531x_chan_state_fetch() computes it as
active && !outer_lol. The new irq_ack_fails member of struct sit9531x_dev
has no kernel-doc entry.

The "Pin-state contract" comment in dpll.c describes five pin ops tables
with get/set rules. This commit has three tables and no set callbacks.

The commit message says:

    Output state is not polled: it changes only through a request, and
    the getter reads the device again when one could not be confirmed.

This patch has no output state getter and no state_stale handling. Both
arrive with the output-state patch later in the series.

Several constants and fields are not used in this commit:
SIT9531X_REG_XO2_GENERIC, the SIT9531X_FVCO_* bands, SIT9531X_DIVO_MAX,
the INTSYNC, debug and GPIO_FUNC_CTRL1 registers,
SIT9531X_OUT_PLL_UNMAPPED, and intsync_src. That doesn't match this note in
the v10 changelog:

    declared each helper in the patch that defines it.

The mismatches in sit9531x_ref_state_fetch() and
sit9531x_output_forced_hiz(), and the misplaced kernel-doc blocks, are
still there at the end of the series.

[ ... ]

> +struct sit9531x_dpll *sit9531x_dpll_alloc(struct sit9531x_dev *sitdev, u8 ch)
> +{
> +	struct sit9531x_dpll *sitdpll;
> +
> +	sitdpll = kzalloc_obj(*sitdpll, GFP_KERNEL);
> +	if (!sitdpll)
> +		return ERR_PTR(-ENOMEM);
> +
> +	sitdpll->dev = sitdev;
> +	sitdpll->id = ch;
> +	sitdpll->lock_status = DPLL_LOCK_STATUS_UNLOCKED;
> +	INIT_LIST_HEAD(&sitdpll->pins);

[Severity: Low]
Should lock_status_error be initialized here as well?

It stays at 0 from kzalloc_obj(), which is not a valid enum
dpll_lock_status_error value; DPLL_LOCK_STATUS_ERROR_NONE is 1.
sit9531x_dpll_lock_status_get() always writes at least
DPLL_LOCK_STATUS_ERROR_NONE, so this test in
sit9531x_dpll_changes_check() is true on the first tick:

	if (sitdpll->lock_status != lock_status ||
	    sitdpll->lock_status_error != status_error) {

As a result, every DPLL sends dpll_device_change_ntf() right after probe,
even when nothing has changed.

pin->pin_state has the same problem. It starts at 0, while
DPLL_PIN_STATE_CONNECTED is 1. Once input pins are registered later in
the series, each polled pin would send a spurious dpll_pin_change_ntf() on
the first tick. Both fields are still uninitialized at the end of the
series.

[ ... ]

> +static u64 sit9531x_derive_clock_id(struct sit9531x_dev *sitdev)
> +{
> +	u64 clkid;
> +
> +	clkid  = SIT9531X_OUI << 24;
> +	clkid |= (u64)(i2c_adapter_id(sitdev->client->adapter) & 0xff) << 16;

[Severity: Medium]
The commit message says:

    That needs a machine with more than 256 I2C adapters and the same
    part twice at the same address on two of them

Is that accurate? Bus numbers are not limited by the number of adapters.

i2c_add_adapter() takes the bus number from the DT "i2c" alias through
of_alias_get_id(). i2c_init() then sets __i2c_first_dynamic_bus_num to the
highest alias + 1. That means a board with only a few adapters can still
have both bus 0 and bus 256.

Two parts of the same variant at the same address on those buses would get
the same clock_id. dpll_device_get() and dpll_pin_get() match on clock_id,
index and module. The second chip would therefore be folded onto the first
chip's DPLL and pin objects.

Could the commit message be corrected, or could the identifier be built so
that the adapter number is not truncated?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h
> index 230b21b9e2381..3a12e1c6b3309 100644
> --- a/drivers/dpll/sit9531x/core.h
> +++ b/drivers/dpll/sit9531x/core.h

[ ... ]

> @@ -105,13 +179,83 @@ struct sit9531x_dev {

[ ... ]

> +	/* Optional DT board-config overrides */
> +	u64			pll_fvco[SIT9531X_NUM_PLLS];
> +	u8			out_pll_map[SIT9531X_MAX_OUTPUTS];
> +	bool			out_pll_map_valid;

[Severity: Low]
This isn't a bug, but nothing in this commit reads the "sitime,pll-fvco"
or "sitime,output-pll-map" properties. In this commit
sit9531x_out_state_fetch() takes routing only from the OUT_MAP registers.

These fields and their kernel-doc describe behaviour that only arrives
with the last patch in the series, "dpll: sit9531x: allow the device tree
to override two board facts". Could they be moved into that patch?

[ ... ]

> diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c
> new file mode 100644
> index 0000000000000..63c72bba51bfe
> --- /dev/null
> +++ b/drivers/dpll/sit9531x/dpll.c
> @@ -0,0 +1,450 @@

[ ... ]

> +static int
> +sit9531x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,

[ ... ]

> +	} else if (chan->locked) {
> +		/*
> +		 * HO_ACQ is locked *and* holdover memory acquired, so it needs
> +		 * the holdover-valid bit rather than following from the lock.
> +		 */
> +		if (chan->ho_valid)
> +			*status = DPLL_LOCK_STATUS_LOCKED_HO_ACQ;
> +		else
> +			*status = DPLL_LOCK_STATUS_LOCKED;
> +	} else if (chan->ho_freeze) {
> +		*status = DPLL_LOCK_STATUS_HOLDOVER;
> +	} else {
> +		*status = DPLL_LOCK_STATUS_UNLOCKED;
> +	}
> +
> +	/* Report inner LOL as an error condition */
> +	if (status_error && chan->inner_lol)
> +		*status_error = DPLL_LOCK_STATUS_ERROR_UNDEFINED;

[Severity: Medium]
Should an inner loss of lock affect the reported status here?

chan->locked only reflects active && !outer_lol. With chan->inner_lol set
and the outer LOL bit clear, this function reports
DPLL_LOCK_STATUS_LOCKED or DPLL_LOCK_STATUS_LOCKED_HO_ACQ. The core then
drops the error for those states:

drivers/dpll/dpll_netlink.c:dpll_msg_add_lock_status() {
    ...
	if (status_error &&
	    (status == DPLL_LOCK_STATUS_UNLOCKED ||
	     status == DPLL_LOCK_STATUS_HOLDOVER) &&
	    nla_put_u32(msg, DPLL_A_LOCK_STATUS_ERROR, status_error))
		return -EMSGSIZE;
    ...
}

So userspace would see a locked DPLL while the inner loop is unlocked.

The pin-state contract comment later in this file defines L as
chan->locked && !chan->inner_lol, which disagrees with this getter.

In the same case, sit9531x_dpll_changes_check() sends
dpll_device_change_ntf() when only the error changes. With a locked status
that notification carries no visible change.

[ ... ]

> + * The device could implement real MANUAL: MISCINNER_PLL (PLL page reg
> + * 0x18) bit 5 switches a PLL from priority-based to manual active select,
> + * and GPIO_INPUT_FUNC_CTRL5..8 (page 0, regs 0xE8-0xEB) bit 4 makes the
> + * choice come from the register's own low nibble instead of the GPIO
> + * pins, which pins one reference while the loop keeps running.  Wiring

[ ... ]

> + */
> +static int
> +sit9531x_dpll_mode_get(const struct dpll_device *dpll, void *dpll_priv,
> +		       enum dpll_mode *mode, struct netlink_ext_ack *extack)
> +{
> +	*mode = DPLL_MODE_AUTOMATIC;
> +
> +	return 0;
> +}

[Severity: Medium]
What happens if the loaded profile already has a PLL in manual active
select?

The comment above describes two such controls: MISCINNER_PLL bit 5, and
bit 4 of GPIO_INPUT_FUNC_CTRL5..8, either of which can pin a reference.
Probe never reads or resets either of them, and
sit9531x_dpll_mode_get() always returns DPLL_MODE_AUTOMATIC.

A profile that uses manual selection would therefore be reported as
automatic. Requesting DPLL_MODE_AUTOMATIC would not fix that: the core
skips same-mode requests, and sit9531x_dpll_mode_set() only clears
SIT9531X_PLL_STATUS_OUTER_DIS.

Would it make sense to read reg 0x18 bit 5 here, or at least warn at probe
when it is set?

> +
> +/*
> + * sit9531x_dpll_mode_set - put the PLL in automatic selection mode

[ ... ]

> +static int
> +sit9531x_dpll_mode_set(const struct dpll_device *dpll, void *dpll_priv,
> +		       enum dpll_mode mode, struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	if (!(status & SIT9531X_PLL_STATUS_OUTER_DIS)) {
> +		sitdev->chan[sitdpll->id].mode = 0;
> +		goto unlock;
> +	}
> +
> +	rc = sit9531x_update_pll_u8(sitdev, sitdpll->id,
> +				    SIT9531X_PLL_REG_STATUS,
> +				    SIT9531X_PLL_STATUS_OUTER_DIS, 0);

[Severity: Medium]
Can sit9531x_dpll_mode_set() ever be reached?

sit9531x_dpll_mode_get() always returns DPLL_MODE_AUTOMATIC, and
sit9531x_dpll_supported_modes_get() advertises only DPLL_MODE_AUTOMATIC.
In the core:

drivers/dpll/dpll_netlink.c:dpll_mode_set() {
    ...
	ret = ops->mode_get(dpll, dpll_priv(dpll), &old_mode, extack);
    ...
	if (mode == old_mode)
		return 0;
    ...
	if (!test_bit(mode, modes)) {
    ...
}

A DPLL_MODE_AUTOMATIC request returns before ops->mode_set is called. Any
other mode is rejected by the test_bit() check.

That makes the OUTER_DIS read, the clear, the small-update latch, the
restore and the cache update look unreachable. A PLL left free-running by
the loaded profile would stay that way, while userspace gets success for
its DPLL_MODE_AUTOMATIC request. This is still the case at the end of the
series.

Should mode_get report something other than DPLL_MODE_AUTOMATIC when
OUTER_DIS is set, or should this recovery happen some other way?

[ ... ]
