Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4AA46EF6A;
	Wed, 16 Sep 2026 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546573; cv=none; b=pl4LS+oqusATqFlrjp5GEhqjL7pl5cOoDq94LupzikEoXCEzaduPre0VZ9iAvlWD35QktCIdD3cq+h53lvPbN+A0zDhkzLi6jD5Y7HniV1orqr89JDbfTANkmPQT9mnIazaTYUmLrTjhjMuol3/bo2Ie18u1OeJ5Kq5ZYvDrpzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546573; c=relaxed/simple;
	bh=/2xvqTP0mvDwFIqkv76KfwcACFaR5MjO+w+isGX9NVw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e0UqqikO0O4O8CJP8AaMbaTiFvcPQc6HEaBErB0ai/Nr6s4R2rcFWHPHuwi3RP2GBrGil1+8HbssRWBr4tV4UZ7y0eqpCgybcSwzEgBakHA+OuWgPW3cfe3x/7so9HsJVSzXRjmfRATtVcM3O3TRgBomDhWsH4EweSnExmSPgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geYsQBiM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geYsQBiM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE11B1F00893;
	Wed, 16 Sep 2026 08:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789546560;
	bh=2uCHDGI5F8P/IKm3GeZXgX7qbmwnNJFVwSbjVkxzoQs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=geYsQBiMVBRCM9ln3Sq38XdEsMSX3TXnay2f6UaneQa0ELVBY15xaVe4lZ6Zs9lik
	 +I2cOD6LzJBp62VGsvKt+DGihfjXU4MbQRG7y0EgiFdeO8wTLv+elvZlYrxHqlzux+
	 nj8uVLo4rHBtxXSjhouknEWL8rWfeZUxHw7lB07MoEuZ2tc8K9EQluAynA2whXG96t
	 ES/jCRZTe1If8WNabCkAvfGgHh0hbNDeoO4xysBAb4oYDujg8kk+o0oKwD8ueba7c7
	 mh02EpS4ZKGJcm/jSOoPGEfM7BDWIzqNV+vAW2xFQOpqW9eQtbx/1BMCPAXY2ngNCz
	 jwA0d13BAeTCQ==
Subject:
 Re: [PATCH net-next v14 4/4] ptp: ocp: add TAP CPLD flashing via devlink
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 08:15:59 +0000
Message-ID: <178954655931.22033.443056531719725611@kernel.org>
In-Reply-To: <20260914071531.11640-5-maimon.sagi@gmail.com>
References: <20260914071531.11640-5-maimon.sagi@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 8 · Low: 2

- [Medium] The new `fw.cpld` flash component only exists while the driver
  happens to hold a successfully cached CPLD IDCODE.
- [Medium] bp->cpld_id / bp->cpld_usercode are invalidated only on the
  success path of adva_x1_cpld_flash()…
- [Medium] Documentation/networking/devlink/ptp_ocp.rst (line 60) states
  "container formats such as ``.jed`` are rejected", but…
- [Medium] The CPLD "transparent configuration mode" entered by
  CPLD_CMD_EN_CFG_TP is tracked by `bp->cpld_in_config_mode`, but the…
- [Medium] adva_x1_cpld_flash() invalidates the cached CPLD identity
  (`WRITE_ONCE(bp->cpld_id, 0); WRITE_ONCE(bp->cpld_id_tried, false);…
- [Medium] The only validation applied to the user-supplied bitstream in
  adva_x1_cpld_flash() is `if (!fw->size || fw->size % CPLD_PAGE_SIZE)`…
- [Medium] The ISC command frame lengths for CPLD_CMD_EN_CFG_TP (0x74),
  CPLD_CMD_DIS_CFG (0x26) and CPLD_CMD_REFRESH (0x79) disagree with…
- [Medium] The programming sequence in adva_x1_cpld_flash() never issues
  ISC_PROGRAM_USERCODE (0xC2) - the CPLD_CMD_* table added by this patch…
- [Low] Documentation states that the CPLD identification read - which
  claims the shared I2C bus and reprograms the on-card mux - happens…
- [Low] adva_x1_cpld_read_id() publishes bp->cpld_usercode and then
  bp->cpld_id with plain WRITE_ONCE() and an explicit comment that…

--

ptp: ocp: add TAP CPLD flashing via devlink

This adds a devlink flash component named fw.cpld that programs the Lattice
MachXO3 configuration flash on ADVA TimeCard X1 boards over I2C, reusing the
TMC bus arbitration added earlier.  ->info_get() also starts publishing the
image USERCODE as the running version of that component.

A few questions on the new code below.

> diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
> index c440d8930384..6ddca452bc63 100644
> --- a/Documentation/ABI/testing/sysfs-timecard
> +++ b/Documentation/ABI/testing/sysfs-timecard
> @@ -35,6 +35,10 @@ Description:	(RO, root only) The flags set in the status register of the
>  		probe, and reported from that cached value as the fixed
>  		"cpld.id" version by devlink dev info.
>  
> +		New CPLD firmware is programmed with devlink dev flash,
> +		selecting the "fw.cpld" component; see
> +		Documentation/networking/devlink/ptp_ocp.rst.
> +

[Severity: Low]
This file still describes the identification read as a one-time event ("The
Lattice device ID of the CPLD is read once by the driver, shortly after
probe"), and ptp_ocp.rst says "the driver does that once from its own
worker".

After this patch adva_x1_cpld_flash() re-arms the one-shot gate on success:

	WRITE_ONCE(bp->cpld_id, 0);
	WRITE_ONCE(bp->cpld_id_tried, false);
	bp->cpld_id_attempts = 0;

and ptp_ocp_sync_work() only skips the read while cpld_id_tried is true, so
the bus-claiming, mux-reprogramming ID/USERCODE read runs again after every
successful CPLD update.

Should both documents be reworded now that the read is no longer once per
binding?

> diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
> index 3f997cd9f3a3..37e9f1ebd1a8 100644
> --- a/Documentation/networking/devlink/ptp_ocp.rst
> +++ b/Documentation/networking/devlink/ptp_ocp.rst

[ ... ]

> @@ -33,3 +33,38 @@ The ``ptp_ocp`` driver reports the following versions
>         reprograms the on-card mux, so the driver does that once from its
>         own worker and reports the cached value here; the version is
>         omitted until that read has succeeded.
> +   * - ``fw.cpld``
> +     - running
> +     - USERCODE of the image programmed into the TAP CPLD, formatted as
> +       ``0x%08x``.  Read together with ``cpld.id`` and reported the same
> +       way.  This is the component name to pass to ``devlink dev flash``
> +       to update the CPLD.

[ ... ]

> +   * - ``fw.cpld``
> +     - The configuration flash of the TAP CPLD on ADVA TimeCard X1 boards,
> +       programmed over I2C with the MachXO3 in-system programming commands
> +       and activated with a REFRESH, so the new image runs immediately.
> +       The image is the raw configuration bitstream, a whole number of
> +       16-byte pages; container formats such as ``.jed`` are rejected.

[Severity: Medium]
Where are container formats rejected?  The only input check in
adva_x1_cpld_flash() is the length test:

	if (!fw->size || fw->size % CPLD_PAGE_SIZE) {
		NL_SET_ERR_MSG_MOD(extack,
				   "image must be a whole number of 16-byte pages");
		return -EINVAL;
	}

There is no preamble, magic or CRC check, so any file whose size happens to
be a multiple of 16 (a 4096-byte .jed, for instance) is accepted and copied
straight into the LSC_PROG_INCR_NV frames.

Would it be better to either add a real format check or to drop the claim
that .jed files are rejected?

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 98cb26077181..58b90b2b282f 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -2158,6 +2169,17 @@ ptp_ocp_devlink_flash_update(struct devlink *devlink,
>  	const char *msg;
>  	int err;
>  
> +	if (params->component) {
> +		if (!bp->has_cpld ||
> +		    strcmp(params->component, ADVA_CPLD_COMPONENT)) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "unsupported flash component");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		return adva_x1_cpld_flash(bp, devlink, params->fw, extack);
> +	}
> +

[Severity: Medium]
This gate accepts the component whenever bp->has_cpld is set, but
ptp_ocp_devlink_info_get() only publishes the name inside a narrower
condition:

	id = READ_ONCE(bp->cpld_id);
	if (bp->has_cpld && id) {
		...
		err = devlink_info_version_running_put_ext(req, "fw.cpld", buf,
							   ver_type);

The core resolves the component name only through info_get():

net/devlink/dev.c:devlink_flash_component_get() {
	...
	if (!lookup_ctx.lookup_name_found) {
		NL_SET_ERR_MSG_ATTR(extack, nla_component,
				    "selected component is not supported by this device");
		return -EINVAL;
	}
}

so the check here never runs for a mismatched name, and the stricter
info_get() condition decides whether fw.cpld can be flashed at all.

Can that make the CPLD unflashable in the cases where flashing is the
recovery action?  ptp_ocp_sync_work() latches the one-shot read:

	if (err != -EBUSY &&
	    (!err || ++bp->cpld_id_attempts >= CPLD_ID_MAX_ATTEMPTS))
		WRITE_ONCE(bp->cpld_id_tried, true);

Once ten non-EBUSY failures have happened, cpld_id stays 0 for the lifetime
of the binding, fw.cpld is never reported, and devlink refuses the request
with -EINVAL.

Would deriving the capability from the static has_cpld board flag (or always
emitting the version string, with an unknown value when the read has not
succeeded) be more robust than deriving it from the opportunistic cache?

[ ... ]

> @@ -4522,6 +4568,48 @@ static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
>  	return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, val, NULL, 0, NULL, 0);
>  }
>  
> +/*
> + * Argument bytes that follow an ISC opcode.  Returns NULL with @nargs set
> + * when the arguments are all zero: adva_x1_i2c_xfer() zeroes the buffer.
> + */
> +static const u8 *adva_x1_cpld_args(u8 cmd, u8 *nargs)
> +{
> +	static const u8 en_cfg_tp[] = { 0x08, 0x00 };
> +	/* cfg sector only */
> +	static const u8 erase_cfg[] = { 0x04, 0x00, 0x00 };
> +
> +	switch (cmd) {
> +	case CPLD_CMD_EN_CFG_TP:
> +		*nargs = sizeof(en_cfg_tp);
> +		return en_cfg_tp;
> +	case CPLD_CMD_ERASE:
> +		*nargs = sizeof(erase_cfg);
> +		return erase_cfg;
> +	case CPLD_CMD_RESET_ADDR:
> +	case CPLD_CMD_SET_DONE:
> +		*nargs = 3;
> +		return NULL;
> +	case CPLD_CMD_DIS_CFG:
> +	case CPLD_CMD_REFRESH:
> +		*nargs = 2;
> +		return NULL;
> +	default:
> +		*nargs = 0;
> +		return NULL;
> +	}
> +}

[Severity: Medium]
Are the operand counts for 0x74, 0x26 and 0x79 right?  These three produce
3-byte frames here, while the in-tree Lattice drivers send opcode plus three
operand bytes:

drivers/fpga/machxo2-spi.c:
	#define ISC_ENABLE		{0xc6, 0x08, 0x00, 0x00}
	#define LSC_REFRESH		{0x79, 0x00, 0x00, 0x00}

drivers/fpga/lattice-sysconfig.h:
	#define	SYSCONFIG_ISC_DISABLE		{0x26, 0x00, 0x00, 0x00}
	#define	SYSCONFIG_LSC_REFRESH		{0x79, 0x00, 0x00, 0x00}

Every other frame this patch builds (READ_ID, READ_STATUS, READ_USERCODE,
ERASE {0x0e,0x04,0x00,0x00}, RESET_ADDR, SET_DONE, WRITE_PAGE) matches those
drivers byte for byte, which makes EN_CFG_TP, DIS_CFG and REFRESH the
outliers.  Could the operand counts be quoted against FPGA-TN-02055?

Related: nothing checks that configuration mode was actually entered.
adva_x1_cpld_wait_ready() looks only at BUSY and FAILED, and the ENAB bit
(bit 9, cfgena in machxo2-spi.c) is never read.  If the enable frame is not
latched, an idle part reports neither BUSY nor FAILED, the erase and page
writes are ignored, DONE is still set from the old image, and the final
DONE/!BUSY/ERR check after REFRESH passes - so the update is reported
successful with the configuration flash untouched.  Should the status be
read after EN_CFG_TP and the update fail with -EIO when ENAB is clear?

[ ... ]

> @@ -4547,14 +4635,82 @@ static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)

[ ... ]

> +/* Wait for BUSY to clear, ignoring a pending cancel.  An ISC command issued
> + * while the part is still erasing or programming may not latch, so an abort
> + * has to wait the operation out before it can leave configuration mode.
> + */
> +static int adva_x1_cpld_wait_idle(struct ptp_ocp *bp, unsigned int max_ms)
> +{

[ ... ]

> +/* Leave transparent configuration mode.  cpld_in_config_mode stays set when
> + * DIS_CFG does not get through, so a later cleanup() tries again rather than
> + * recording an exit that never happened.
> + */
> +static void adva_x1_cpld_exit_config(struct ptp_ocp *bp)
> +{
> +	int err;
> +
> +	if (!bp->cpld_in_config_mode)
> +		return;
> +
> +	adva_x1_cpld_wait_idle(bp, CPLD_ERASE_MS);
> +
> +	err = adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG);
> +	if (err)
> +		dev_warn(&bp->pdev->dev,
> +			 "CPLD left in configuration mode: %d\n", err);
> +	else
> +		bp->cpld_in_config_mode = false;
> +}

[Severity: Medium]
Which cleanup() does this comment refer to?  In this tree
cpld_in_config_mode is referenced only in the struct declaration, in
adva_x1_cpld_flash() and in this function, and adva_x1_cpld_flash() sets it
unconditionally on every entry:

	bp->cpld_in_config_mode = true;

so nothing ever observes the "stays set" state and retries the DIS_CFG.
ptp_ocp_detach() destroys cpld_lock and unregisters the device without
claiming the bus or sending DIS_CFG, so if DIS_CFG errors here the part is
left in transparent configuration mode past unbind - the state the comment
in adva_x1_cpld_flash() calls unsafe ("A stray DIS_CFG is harmless; leaving
config mode enabled is not").

Also, the comment above adva_x1_cpld_wait_idle() describes waiting "ignoring
a pending cancel" for "an abort", but there is no cancel or abort path in
this sequence - read_poll_timeout() and msleep() are uninterruptible.  Is
the only real difference from adva_x1_cpld_wait_ready() that FAILED is not
terminal?  If so, could the comments be reworded to match?

>  /*
> - * Read the Lattice device ID into bp->cpld_id.  Done once, off the
> - * unprivileged devlink path, which reports the cached value.  -EBUSY means
> - * cpld_lock is held, so the caller can retry rather than wait behind a long
> - * CPLD operation.
> + * Read the Lattice device ID and the image USERCODE under one bus claim.
> + * Done once, off the unprivileged devlink path, which reports the cached
> + * values.  -EBUSY means cpld_lock is held, so the caller can retry rather
> + * than wait behind a long CPLD operation.
>   */
>  static int adva_x1_cpld_read_id(struct ptp_ocp *bp)
>  {

[ ... ]

> @@ -4568,8 +4724,19 @@ static int adva_x1_cpld_read_id(struct ptp_ocp *bp)
>  	if (ret)
>  		goto release;
>  	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_ID, data, 4);
> -	if (!ret)
> -		WRITE_ONCE(bp->cpld_id, get_unaligned_be32(data));
> +	if (ret)
> +		goto deselect;
> +	id = get_unaligned_be32(data);
> +
> +	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_USERCODE, data, 4);
> +	if (ret)
> +		goto deselect;
> +	usercode = get_unaligned_be32(data);
> +
> +	/* cpld_id is the validity flag for both, so publish it last. */
> +	WRITE_ONCE(bp->cpld_usercode, usercode);
> +	WRITE_ONCE(bp->cpld_id, id);

[Severity: Low]
Is the publish ordering the comment relies on actually enforced?
WRITE_ONCE() gives no store-store ordering, and the reader side in
ptp_ocp_devlink_info_get() has no matching load-load ordering:

	id = READ_ONCE(bp->cpld_id);
	if (bp->has_cpld && id) {
		...
		sprintf(buf, "0x%08x", READ_ONCE(bp->cpld_usercode));

On arm64 or powerpc a concurrent devlink dev info could see a valid cpld_id
with a stale or zero cpld_usercode and print fw.cpld 0x00000000.  Would
smp_store_release()/smp_load_acquire() (or smp_wmb()/smp_rmb()) be the right
pairing here?

> @@ -4627,6 +4794,154 @@ cpld_status_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_ADMIN_RO(cpld_status);
>  
> +/*
> + * Program the CPLD configuration flash from @fw and activate it.  Selected
> + * by the "fw.cpld" flash component; the SPI flash keeps the default path.
> + * Runs under cpld_lock with the i2c adapter lock held, so an EEPROM read
> + * blocks for as long as programming takes.
> + */
> +static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
> +			      const struct firmware *fw,
> +			      struct netlink_ext_ack *extack)
> +{
> +	size_t offset;
> +	int err;
> +	u32 st;
> +
> +	if (!fw->size || fw->size % CPLD_PAGE_SIZE) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "image must be a whole number of 16-byte pages");
> +		return -EINVAL;
> +	}

[Severity: Medium]
Should there also be an upper bound here, and a cross-check against the
cached IDCODE?  Nothing limits fw->size to the configuration-flash capacity
of the part, and CPLD_CMD_RESET_ADDR is issued only once before the loop, so
the auto-incrementing ISP address pointer walks past the sector that ERASE
(operand 0x04) cleared when the image is oversized or of the wrong density.

The same missing bound makes the duration of the operation caller-chosen.
The programming loop runs fw->size / 16 iterations, each an I2C transfer plus
a sleeping status poll, with no fatal_signal_pending() or other cancellation
point, while both bp->cpld_lock and the root adapter lock taken by
adva_x1_bus_claim() are held:

	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);

so ptp_ocp_read_eeprom() and cpld_status_show() are blocked for the whole
time.  Would a size cap derived from the IDCODE plus a bail-out on a fatal
signal bound both cases?

[ ... ]

> +	devlink_flash_update_status_notify(devlink, "Erasing",
> +					   ADVA_CPLD_COMPONENT, 0, 0);
> +	err = adva_x1_cpld_write(bp, CPLD_CMD_ERASE);
> +	if (!err)
> +		err = adva_x1_cpld_wait_ready(bp, CPLD_ERASE_MS);
> +	if (err)
> +		goto exit_config;

[Severity: Medium]
Where does the new USERCODE get programmed?  The command table added by this
patch has no ISC_PROGRAM_USERCODE (0xC2), and the sequence goes EN_CFG_TP ->
ERASE {0x0e,0x04,0x00,0x00} -> RESET_ADDR -> page writes -> SET_DONE ->
REFRESH.

On MachXO2/MachXO3 the USERCODE lives in the configuration flash sector that
the ERASE CFG bit wipes, and a raw page bitstream fed to LSC_PROG_INCR_NV
does not carry it (Diamond programs it from the .jed UH field with the
dedicated command).  If that holds for this part, then after a successful
update the worker re-reads an erased USERCODE and

	err = devlink_info_version_running_put_ext(req, "fw.cpld", buf,
						   ver_type);

reports the erased pattern as the running version, which contradicts the
documented meaning of fw.cpld ("USERCODE of the image programmed into the
TAP CPLD").  I could not confirm the MachXO3 USERCODE location from the tree
- note that machxo2-spi.c likewise never programs one - so this may be worth
checking against the datasheet.  Should the flow program the USERCODE before
SET_DONE, or should the documentation stop presenting it as an image
identifier?

[ ... ]

> +	/* The image on the part changed, so the cached USERCODE has too. */
> +	WRITE_ONCE(bp->cpld_id, 0);
> +	WRITE_ONCE(bp->cpld_id_tried, false);
> +	bp->cpld_id_attempts = 0;
> +
> +exit_config:
> +	adva_x1_cpld_exit_config(bp);
> +deselect:
> +	adva_x1_mux_select(bp, -1);
> +release:
> +	adva_x1_bus_release(bp);
> +unlock:
> +	mutex_unlock(&bp->cpld_lock);

[Severity: Medium]
Does this leave stale values published on the failure paths?  The
invalidation sits after the post-REFRESH status check, so every error from
CPLD_CMD_ERASE onwards jumps to exit_config or deselect and skips it, while
the erase has already cleared the configuration sector or REFRESH has
already swapped the running image.

ptp_ocp_devlink_info_get() then keeps reporting the pre-flash IDCODE as the
fixed cpld.id and the pre-flash USERCODE as the running fw.cpld version, and
because cpld_id_tried is still true, ptp_ocp_sync_work() (gated on
!cpld_id_tried) never refreshes them:

	if (bp->has_cpld && !READ_ONCE(bp->cpld_id_tried) &&

so the stale pair is published until unbind/rebind.  Would invalidating
before ERASE, and unconditionally once REFRESH may have been accepted, be
more accurate?

[Severity: Medium]
Separately, these three stores run under cpld_lock, but the matching updates
in ptp_ocp_sync_work() do not - adva_x1_cpld_read_id() drops the mutex
before returning:

adva_x1_cpld_read_id()
out:
	mutex_unlock(&bp->cpld_lock);

ptp_ocp_sync_work()
	if (err != -EBUSY &&
	    (!err || ++bp->cpld_id_attempts >= CPLD_ID_MAX_ATTEMPTS))
		WRITE_ONCE(bp->cpld_id_tried, true);

Can the worker's store then undo this invalidation?  If the worker is
scheduled out between adva_x1_cpld_read_id() returning with a valid cpld_id
and its WRITE_ONCE(cpld_id_tried, true), a flash can complete in between and
reset the state, after which the worker's store leaves cpld_id_tried true
with cpld_id == 0.  The read is gated on !cpld_id_tried, so ID and USERCODE
are never re-read, cpld.id and fw.cpld are permanently omitted from devlink
dev info, and the core then refuses component fw.cpld until module reload.

The unsynchronized pair also makes the non-atomic ++bp->cpld_id_attempts
race with the plain bp->cpld_id_attempts = 0 store here.  Would moving the
attempts/tried bookkeeping into adva_x1_cpld_read_id(), under cpld_lock,
close both?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914071531.11640-1-maimon.sagi%40gmail.com
