Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15343D5222;
	Fri,  4 Sep 2026 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507989; cv=none; b=Sgjx99B3SfbSWDnBEYNJ8UDohPCg5XTENXiG84hBhU0mMVa4CnFBmgrtgEAAmWrOw0DKqVBFauzKntwK2c7JXxVwaedQ7MopzPcrPkxLH2IQPJZsxEAtlHApxLebvDTBxJeJIpxgQI+CDj8r+rgyeIIp1rYB0yKReIPWFsWiTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507989; c=relaxed/simple;
	bh=mOseYv0LduPftfngRetQx8pyt6j2bUQzyEgumsjSZLk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pDJ9LOKY1WsVXfXNfJ8DGPyvV7PmPAQ4rnXmryermino64FiOegDDTQUiGwBBSjQvtemsilUGoDG17yD74RsvBeKNR3DzMGcD1mP8nUwOcwzN0iyMMOc8L1x84JrbfPmZfCUXeXyenLtYAM+W7J3rLZOMUAWCg1/HOnDc23cggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYgrET2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYgrET2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2641E1F00A3E;
	Fri,  4 Sep 2026 07:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788507987;
	bh=Jnmdxxs+vdIspc92hlzd1QK32+on0jTqT4z1urjxnyI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eYgrET2EdOI8/R9DyjhLvLVrIq2rJjxpmrjANI0/ae69/sVpvahOtYioNQSrbMCDh
	 hAtI5dt/7+Hur/AdXDGnp59N+iM38DZf89U9dsFMFrfM4Tzpx8y8772NA9rsJuK6Z0
	 11PSSFTZclWlq0aJcAVyUAqP1Ap3KZQHiFdM22Q6ntXbQDwGU1/2pjm8QHOiJdjKl8
	 W7Ou8BWH9MgZd9Iuv1H1LD/8FYT+vqeFcedVlOScvyfVoukhRsFs2+35Quh14J2Tvn
	 G0o7PiRY/OmYpL90yev0JoM5fJk33XEPf62cgF0L5NWzo8cXVLq2X4/wQICdVPacSE
	 LmoNfPLxKM3KA==
Subject: Re: [PATCH net-next v12 2/2] ptp: ocp: add TAP CPLD firmware upload
 for ADVA TimeCard X1
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 07:46:26 +0000
Message-ID: <178850798670.4131868.8260049809477317067@kernel.org>
In-Reply-To: <20260902044232.21188-3-maimon.sagi@gmail.com>
References: <20260902044232.21188-3-maimon.sagi@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 1 (1)

- [Medium] The upload callbacks emit firmware-upload error categories
  that contradict the meanings documented for enum fw_upload_err in…
- [Medium] bp->cpld_cancel is cleared by the driver in
  adva_cpld_cleanup() (ptp_ocp.c:4875) and on adva_cpld_prepare()'s…
- [Medium] Programming success is declared without validating the full
  MachXO3 sysCONFIG status: the driver defines only DONE/BUSY/FAILED…
- [Low] The new callback block comment states 'cancel() - set flag;
  checked at the start of each callback', but adva_cpld_prepare() does…

Pre-existing issues:
- [Low] adva_x1_bus_claim() makes a single 2 * ADVA_CPLD_XFER_MAX
  (64-byte) kzalloc and adva_x1_i2c_xfer() splits it into wbuf at offset…

--

ptp: ocp: add TAP CPLD firmware upload for ADVA TimeCard X1

This adds an in-system programming path for the Lattice MachXO3 TAP CPLD on
the ADVA TimeCard X1, driven through the kernel firmware-upload subsystem
and registered per card as adva-cpld.N.  The prepare/write/poll_complete/
cleanup sequence runs under cpld_lock while holding the i2c adapter lock.

A few questions about the new upload callbacks below.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 0c5c3ec8de5fa..86d1c1a311cc5 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -4287,6 +4317,15 @@ static const struct ocp_attr_group art_timecard_groups[] = {
>  /* Lattice LCMXO3LF ISC command codes */
>  #define CPLD_CMD_READ_ID      0xE0000000UL
>  #define CPLD_CMD_READ_STATUS  0x3C000000UL
> +#define CPLD_CMD_EN_CFG_TP    0x74   /* enable config, transparent mode */
> +#define CPLD_CMD_DIS_CFG      0x26
> +#define CPLD_CMD_ERASE        0x0E
> +#define CPLD_CMD_RESET_ADDR   0x46
> +#define CPLD_CMD_WRITE_PAGE   0x70
> +#define CPLD_CMD_SET_DONE     0x5E
> +#define CPLD_CMD_REFRESH      0x79
> +#define CPLD_PAGE_SIZE        16
> +#define CPLD_POLL_US          10000  /* status poll interval while busy */
>  
>  /* Status register bit positions (Lattice LCMXO3LF datasheet) */
>  #define CPLD_STATUS_DONE   BIT(8)

[ ... ]

> @@ -4432,7 +4472,10 @@ static int adva_x1_bus_claim(struct ptp_ocp *bp)
>  	if (!adap)
>  		return -ENODEV;
>  
> -	/* One scratch buffer per claim, not per transfer. */
> +	/* One scratch buffer per claim rather than per transfer: a firmware
> +	 * upload holds the claim for the whole image, so this is a single
> +	 * allocation instead of one for each 16-byte page.
> +	 */
>  	bp->cpld_buf = kzalloc(2 * ADVA_CPLD_XFER_MAX, GFP_KERNEL);
>  	if (!bp->cpld_buf) {
>  		i2c_put_adapter(adap);

[Severity: Low]
This isn't a bug introduced by this patch, but this patch makes the single
scratch allocation part of the documented rationale, so it seems worth
raising.  adva_x1_i2c_xfer() splits this one 64-byte allocation into two
halves:

    wbuf = bp->cpld_buf;
    rbuf = bp->cpld_buf + ADVA_CPLD_XFER_MAX;

and then marks both messages I2C_M_DMA_SAFE in the same __i2c_transfer().
Is the second half really DMA-safe in the sense that flag asserts?  With a
64-byte cacheline both halves share one line, so for the combined
write -> repeated-START -> read used by adva_x1_cpld_cmd_read() the
TO_DEVICE mapping of wbuf and the FROM_DEVICE mapping of rbuf would cover
the same line on a non-coherent master, and a writeback of the dirty
transmit half could clobber the status bytes the programming state machine
polls.

No adapter that can bind here honours the flag today (the xiic-i2c
controller instantiated by ocp_adva_x1_resource does not use DMA), so this
looks inert on this hardware.  Would separate allocations, or aligning each
half to ARCH_DMA_MINALIGN, be preferable given the flag's stated contract?

> @@ -4485,6 +4569,38 @@ static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)
>  	return 0;
>  }
>  
> +/* Poll the status register until the CPLD goes idle, or @max_ms elapses.
> + * The deadline is on wall time, so the I2C transactions count against it,
> + * and the status is read once more after it expires before giving up.
> + */
> +static int adva_x1_cpld_wait_ready(struct ptp_ocp *bp, unsigned int max_ms)
> +{
> +	u32 status = 0;
> +	int err, ret;
> +
> +	ret = read_poll_timeout(adva_x1_cpld_read_status, err,
> +				err || READ_ONCE(bp->cpld_cancel) ||
> +				(status & CPLD_STATUS_FAILED) ||
> +				!(status & CPLD_STATUS_BUSY),
> +				CPLD_POLL_US, max_ms * USEC_PER_MSEC, false,
> +				bp, &status);
> +	if (ret)
> +		return ret;
> +	if (READ_ONCE(bp->cpld_cancel))
> +		return -ECANCELED;
> +	if (err || (status & CPLD_STATUS_FAILED))
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +/* A step aborted by cancel() must be reported as such, not as a HW error. */
> +static enum fw_upload_err adva_cpld_err(struct ptp_ocp *bp)
> +{
> +	return READ_ONCE(bp->cpld_cancel) ? FW_UPLOAD_ERR_CANCELED
> +					  : FW_UPLOAD_ERR_HW_ERROR;
> +}
> +

[Severity: Medium]
Are the firmware-upload error categories chosen here the ones userspace
expects?  The values map straight onto the strings in fw_upload_err_str[]
in drivers/base/firmware_loader/sysfs_upload.c, which are what shows up in
/sys/class/firmware/adva-cpld.N/error.

adva_cpld_err() reports any transport failure as FW_UPLOAD_ERR_HW_ERROR, so
a failed __i2c_transfer() in adva_x1_i2c_xfer() never surfaces as
FW_UPLOAD_ERR_RW_ERROR, which include/linux/firmware.h documents as "read or
write to HW failed".

In adva_cpld_prepare(), every adva_x1_bus_claim() failure becomes a timeout:

    if (adva_x1_bus_claim(bp)) {
            ret = FW_UPLOAD_ERR_TIMEOUT;

but adva_x1_bus_claim() also returns -ENODEV immediately when there is no
adapter (cpld_i2c_adap_nr is -1), and -ENOMEM when the scratch kzalloc
fails.  Should those be reported as "timeout on handshake with HW"?

And in the opposite direction, the last check in adva_cpld_poll_complete():

    if (adva_x1_cpld_wait_ready(bp, 3000))
            return READ_ONCE(bp->cpld_cancel) ? FW_UPLOAD_ERR_CANCELED
                                              : FW_UPLOAD_ERR_TIMEOUT;

reports a timeout even when wait_ready() returned -EIO because
CPLD_STATUS_FAILED was asserted or the status read itself failed.

> @@ -4562,6 +4678,212 @@ cpld_status_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_ADMIN_RO(cpld_status);
>  
> +/*
> + * adva_x1 CPLD firmware-upload callbacks.
> + *
> + * The kernel firmware-upload subsystem (CONFIG_FW_UPLOAD) exposes:
> + *   /sys/class/firmware/adva-cpld.N/{data,loading,status,error,...}
> + * where N is the index of the owning ocpN device.
> + * Userspace writes the raw binary page data directly — no /lib/firmware/
> + * staging file is needed.
> + *
> + * Callback sequence driven by the framework:
> + *   prepare()      - validate size, acquire bus, enable config, erase flash
> + *   write()        - program one 16-byte page per call
> + *   poll_complete()- set DONE, REFRESH, wait for CPLD to reboot
> + *   cancel()       - set flag; checked at the start of each callback
> + *   cleanup()      - release bus resources (called on success or failure)
> + */
> +static enum fw_upload_err
> +adva_cpld_prepare(struct fw_upload *fwl, const u8 *data, u32 size)
> +{
> +	enum fw_upload_err ret = FW_UPLOAD_ERR_NONE;
> +	struct ptp_ocp *bp = fwl->dd_handle;
> +
> +	/* Do not clear cpld_cancel here: fw_upload_start() queues the work
> +	 * before this runs, so a cancel may already have arrived.  It is
> +	 * cleared once the upload is over, on every exit below and in
> +	 * cleanup().
> +	 */
> +	if (!size || size % CPLD_PAGE_SIZE) {
> +		WRITE_ONCE(bp->cpld_cancel, false);
> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> +	}

[Severity: Low]
The block comment above says cancel() sets a flag "checked at the start of
each callback", but does adva_cpld_prepare() actually check it at entry?

For an invalid size the pending cancellation is cleared here and the result
is reported as invalid-file-size rather than user-abort.

For a valid image, the bus is claimed, the mux is switched and
CPLD_CMD_EN_CFG_TP is issued before the first effective test of
bp->cpld_cancel inside adva_x1_cpld_wait_ready(), so an already-cancelled
upload still cycles the CPLD into configuration mode and back out via
DIS_CFG.  Would an explicit check before the size validation match the
comment?

> +
> +	bp->cpld_in_config_mode = false;
> +
> +	mutex_lock(&bp->cpld_lock);
> +
> +	if (adva_x1_bus_claim(bp)) {
> +		ret = FW_UPLOAD_ERR_TIMEOUT;
> +		goto err_unlock;
> +	}
> +

[ ... ]

> +err_deselect:
> +	if (bp->cpld_in_config_mode) {
> +		adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG);
> +		bp->cpld_in_config_mode = false;
> +	}
> +	adva_x1_mux_select(bp, -1);
> +err_release:
> +	adva_x1_bus_release(bp);
> +err_unlock:
> +	WRITE_ONCE(bp->cpld_cancel, false);
> +	mutex_unlock(&bp->cpld_lock);
> +	return ret;
> +}

[ ... ]

> +static enum fw_upload_err
> +adva_cpld_poll_complete(struct fw_upload *fwl)
> +{
> +	struct ptp_ocp *bp = fwl->dd_handle;
> +	int err;
> +	u32 st;
> +
> +	lockdep_assert_held(&bp->cpld_lock);
> +
> +	if (READ_ONCE(bp->cpld_cancel))
> +		return FW_UPLOAD_ERR_CANCELED;
> +
> +	if (adva_x1_cpld_write(bp, CPLD_CMD_SET_DONE) ||
> +	    adva_x1_cpld_wait_ready(bp, 1000))
> +		return adva_cpld_err(bp);
> +
> +	if (adva_x1_cpld_read_status(bp, &st) || !(st & CPLD_STATUS_DONE))
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +
> +	if (adva_x1_cpld_write(bp, CPLD_CMD_REFRESH))
> +		return FW_UPLOAD_ERR_HW_ERROR;

[Severity: Medium]
Is the post-REFRESH state checked strictly enough to call the update
successful?

DONE is sampled only before REFRESH.  After REFRESH the only remaining
check is adva_x1_cpld_wait_ready(bp, 3000), which returns 0 as soon as a
status read succeeds with BUSY and FAILED clear, so an image that reboots
with DONE clear is still reported as FW_UPLOAD_ERR_NONE.

The status bit definitions added here also cover only DONE, BUSY and
FAILED.  drivers/fpga/lattice-sysconfig.h defines a three-bit error field
for the same family:

    #define SYSCONFIG_STATUS_ERR            GENMASK(25, 23)

and lattice-sysconfig.c requires that field to be zero, DONE set and BUSY
clear before declaring programming complete.  Should this driver re-read
status after REFRESH and apply the same three conditions, so a nonzero
command or CRC error code with FAILED clear is not treated as success?

> +
> +	/* REFRESH reboots the CPLD out of configuration mode, so cleanup()
> +	 * must not send DIS_CFG afterwards even if the checks below fail.
> +	 */
> +	bp->cpld_in_config_mode = false;

[ ... ]

> +	if (adva_x1_cpld_wait_ready(bp, 3000))
> +		return READ_ONCE(bp->cpld_cancel) ? FW_UPLOAD_ERR_CANCELED
> +						  : FW_UPLOAD_ERR_TIMEOUT;
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static void
> +adva_cpld_cancel(struct fw_upload *fwl)
> +{
> +	struct ptp_ocp *bp = fwl->dd_handle;
> +
> +	WRITE_ONCE(bp->cpld_cancel, true);
> +}
> +
> +static void
> +adva_cpld_cleanup(struct fw_upload *fwl)
> +{
> +	struct ptp_ocp *bp = fwl->dd_handle;
> +
> +	__acquire(&bp->cpld_lock);	/* held since prepare() returned ok */
> +	lockdep_assert_held(&bp->cpld_lock);
> +
> +	if (bp->cpld_in_config_mode) {
> +		adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG);
> +		bp->cpld_in_config_mode = false;
> +	}
> +	adva_x1_mux_select(bp, -1);
> +	adva_x1_bus_release(bp);
> +	WRITE_ONCE(bp->cpld_cancel, false);
> +	mutex_unlock(&bp->cpld_lock);
> +}

[Severity: Medium]
Can bp->cpld_cancel survive past the upload that owns it and abort the next
one?

cleanup() clears the flag, but the core still reports the operation as
active at that point.  In fw_upload_main() (sysfs_upload.c):

    done:
            if (fwlp->ops->cleanup)
                    fwlp->ops->cleanup(fwl);
            ...
            fw_upload_prog_complete(fwlp);

progress only becomes FW_UPLOAD_PROG_IDLE in fw_upload_prog_complete(),
while cancel_store() calls ops->cancel() for any non-IDLE progress.  So:

    worker                              other task
    adva_cpld_cleanup()
      WRITE_ONCE(cpld_cancel, false)
      mutex_unlock(&bp->cpld_lock)
                                        echo 1 > cancel
                                        progress != IDLE
                                        adva_cpld_cancel()
                                          WRITE_ONCE(cpld_cancel, true)
    fw_upload_prog_complete()

Nothing clears it again, because adva_cpld_prepare() deliberately does not
reset the flag on entry.  The next upload then hits it on the first
iteration of adva_x1_cpld_wait_ready():

    err || READ_ONCE(bp->cpld_cancel) || ...

which returns -ECANCELED, and prepare() reports user-abort for an upload
nobody cancelled, after EN_CFG_TP has already put the CPLD into
configuration mode.

The err_unlock path in adva_cpld_prepare() clears the flag with the same
timing.  Since the flag's lifetime is managed entirely outside fwlp->lock,
the only lock that orders cancel delivery, READ_ONCE/WRITE_ONCE cannot
close this.  Would tying the state to an upload generation, or resetting it
under the same serialization, work better here?

> +
> +static const struct fw_upload_ops adva_cpld_upload_ops = {
> +	.prepare	 = adva_cpld_prepare,
> +	.write		 = adva_cpld_write,
> +	.poll_complete	 = adva_cpld_poll_complete,
> +	.cancel		 = adva_cpld_cancel,
> +	.cleanup	 = adva_cpld_cleanup,
> +};
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902044232.21188-1-maimon.sagi%40gmail.com
