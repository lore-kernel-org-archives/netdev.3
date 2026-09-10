Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6802931CD;
	Thu, 10 Sep 2026 15:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053839; cv=none; b=eeMtElhgE4cJ4eLG5X3HQiya4Y/iFMOctlfBHZN/WkIghVFYYP9yBKUu9898n/2N5VGlFMONx95hQMtgJjZbwYNOgLqNjHxomjRAd9jb5Mdluf57kV9dsc4obrC+U58pvcHLj2i0iioMoVdZnCzCEkTTF8F47qs0i+x/dkOX9+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053839; c=relaxed/simple;
	bh=hMcJevfWjnoJSiqOu6NsVtstzcKgTY4rNZYzGtmdw9k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WIfedWmHm1JOeP119piuAPh5MU6mQQpb1EJuEAfUS05zwMChslkNtZWperxOOuKatTvXSTM9rl6qUDsqecjTla8ECoVU9ZJXt+MOZh0epQ6vR8J318zQNlJGiDFhHb++qoI31SuUOF2tCr6xcbF2BngkNp9rmQ/r97IeDCMNZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LN1sVdry; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LN1sVdry"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A041F000FF;
	Thu, 10 Sep 2026 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053837;
	bh=OSuV66xvBDocO51COl30gjhf09+s3jUVMuJpH2SnHPw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LN1sVdryVXe0+8owdOFneFXdLt1Q3A0+wAHHD7mzqOAqxQZ758E0X7dA9BrqLSWhN
	 FrSocPDim66XpZc5EDp3pEbmG+LOoL4LOh9FtiIpS9F2IHdEBhaL0F2ZtyGhYdkBaE
	 hY/kWU2MBTJgEz95tuZ6diXzdFJO8KIO54Dvhr+f22l/FIgJ8sJ65XQNKj9cWhSztq
	 9LU9g5QqrO8dVBJNJs4/zZcp+NOk/18Sk6Ay9XfjCZ0KkCrjwO8vEOiGw7/lrs3e42
	 axPjg4X2uyFv6bmuSVaOYjo4TW9E8DnkP69HJ1rlO5pZ/V22TIyNhCBk7ITC13b1sh
	 R1Xh6GAvHDsiw==
Subject: Re: [PATCH net-next v13 2/2] ptp: ocp: add TAP CPLD firmware upload
 for ADVA TimeCard X1
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 15:23:56 +0000
Message-ID: <178905383648.219967.14391517503747135549@kernel.org>
In-Reply-To: <20260908122328.52641-3-maimon.sagi@gmail.com>
References: <20260908122328.52641-3-maimon.sagi@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 3 · Low: 3

- [Medium] bp->cpld_cancel is a single per-device boolean cleared at
  driver-chosen points (entry of adva_cpld_prepare(), prepare()'s…
- [Medium] adva_x1_cpld_wait_ready() returns as soon as
  READ_ONCE(bp->cpld_cancel) is observed (-ECANCELED) or a status read…
- [Medium] adva_cpld_poll_complete() reports FW_UPLOAD_ERR_NONE without
  verifying that the CPLD reconfigured successfully.
- [Low] The new paragraph in Documentation/ABI/testing/sysfs-timecard
  directs userspace to program the CPLD via /sys/class/firmware/adva-…
- [Low] In adva_cpld_poll_complete() the post-REFRESH mux-reselect poll
  `read_poll_timeout(adva_x1_mux_select, err, !err, CPLD_POLL_US, 3000 *…
- [Low] adva_x1_cpld_wait_ready() exits its poll as soon as the status
  read fails (`err` is part of the termination condition) but then…

Pre-existing issues:
- [High] ptp_ocp_detach() relies on firmware_upload_unregister() to
  cancel *and* flush an in-flight upload before cpld_lock, the i2c_ctrl…

--

ptp: ocp: add TAP CPLD firmware upload for ADVA TimeCard X1

This adds an in-system programming path for the Lattice MachXO3 CPLD on the
ADVA TimeCard X1, exposed through the kernel firmware-upload subsystem as
/sys/class/firmware/adva-cpld.N/.  The prepare/write/poll_complete/cleanup
callbacks run under cpld_lock with the i2c adapter lock held, and the upload
node is unregistered first in ptp_ocp_detach().

A few questions below.

> diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
> index 70ecc15b347f..8c0d41c941ad 100644
> --- a/Documentation/ABI/testing/sysfs-timecard
> +++ b/Documentation/ABI/testing/sysfs-timecard
> @@ -30,6 +30,10 @@ Description:	(RO, root only) The status register of the TAP CPLD, in
>  		ID of the CPLD is read once at probe and reported as the
>  		fixed "cpld.id" version by devlink dev info.
>  
> +		To program new CPLD firmware use the standard kernel
> +		firmware-upload interface, registered per card at:
> +		/sys/class/firmware/adva-cpld.N/
> +		where N is the index of this ocpN device.

[Severity: Low]
Should this paragraph also state the image format the driver accepts?

adva_cpld_prepare() rejects anything that is not an exact multiple of
CPLD_PAGE_SIZE:

	if (!size || size % CPLD_PAGE_SIZE) {
		WRITE_ONCE(bp->cpld_cancel, false);
		return FW_UPLOAD_ERR_INVALID_SIZE;
	}

and adva_cpld_write() copies the bytes verbatim into the page-program
payload, so the node takes a raw page-aligned bitstream rather than a
Lattice .jed/.hex container.  The internal comment above the callbacks does
say "Userspace writes the raw binary page data directly", but the ABI text
does not, and the only feedback a user gets from a container file is the
framework's generic "invalid-file-size" in the error attribute.

[ ... ]

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 7db1dc9b94bd..6eefc3db586f 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -4500,6 +4587,55 @@ static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)
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

[Severity: Low]
Is collapsing every transport errno to -EIO here intentional?

adva_x1_cpld_read_status() returns the underlying I2C errno (-ETIMEDOUT,
-ENXIO, -EREMOTEIO, ...), and err is part of the termination condition, so
the poll exits with that errno available.  It is then replaced:

	if (err || (status & CPLD_STATUS_FAILED))
		return -EIO;

adva_cpld_err() distinguishes those categories, but by the time it is
consulted the distinction is gone:

	case -ETIMEDOUT:
		return FW_UPLOAD_ERR_TIMEOUT;
	...
	case -EIO:		/* FAILED status, or a short transfer */
		return FW_UPLOAD_ERR_HW_ERROR;

so an I2C controller timeout during a status poll is reported as "hw-error"
instead of "timeout", and a NACK as "hw-error" instead of
"read-write-error".  The same -EIO is also used for a genuine CPLD FAILED
status, so the two are indistinguishable in the error attribute.  Would
returning err when it is non-zero, and -EIO only for CPLD_STATUS_FAILED,
keep the mapping useful?

> +
> +/* Map an errno onto the category userspace reads back from
> + * /sys/class/firmware/adva-cpld.N/error.  A step aborted by cancel() must
> + * be reported as such, not as a HW error.
> + */
> +static enum fw_upload_err adva_cpld_err(struct ptp_ocp *bp, int err)
> +{
> +	if (READ_ONCE(bp->cpld_cancel))
> +		return FW_UPLOAD_ERR_CANCELED;

[ ... ]

> @@ -4572,6 +4708,234 @@ cpld_status_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_ADMIN_RO(cpld_status);
>  

[ ... ]

> +static enum fw_upload_err
> +adva_cpld_prepare(struct fw_upload *fwl, const u8 *data, u32 size)
> +{
> +	enum fw_upload_err ret = FW_UPLOAD_ERR_NONE;
> +	struct ptp_ocp *bp = fwl->dd_handle;
> +	int err;
> +
> +	/* Do not clear cpld_cancel here: fw_upload_start() queues the work
> +	 * before this runs, so a cancel may already have arrived - honour it
> +	 * before touching the hardware.  It is cleared once the upload is
> +	 * over, on every exit below and in cleanup().
> +	 */
> +	if (READ_ONCE(bp->cpld_cancel)) {
> +		WRITE_ONCE(bp->cpld_cancel, false);
> +		return FW_UPLOAD_ERR_CANCELED;
> +	}

[Severity: Medium]
Can this consume a cpld_cancel left over from the previous upload?

adva_cpld_cleanup() clears the flag and unlocks, but the framework only
returns progress to IDLE afterwards:

drivers/base/firmware_loader/sysfs_upload.c:fw_upload_main() {
	...
done:
	if (fwlp->ops->cleanup)
		fwlp->ops->cleanup(fwl);
	...
	fw_upload_prog_complete(fwlp);
}

In that window cancel_store() still accepts a cancel, since it only rejects
the IDLE state:

	mutex_lock(&fwlp->lock);
	if (fwlp->progress == FW_UPLOAD_PROG_IDLE) {
		mutex_unlock(&fwlp->lock);
		return -ENODEV;
	}

	fwlp->ops->cancel(fwlp->fw_upload);

so adva_cpld_cancel() sets cpld_cancel = true with no upload running, and
nothing clears it until the next adva_cpld_prepare(), which aborts a fresh
and unrelated upload with "user-abort".

Relatedly, adva_cpld_err() tests the same flag before looking at err, so a
cancel racing a real transfer failure reports a hardware or I2C error as a
user abort.  Would tying cancellation to an upload generation counter rather
than a bare bool cleared from several driver-side points close both cases?

> +
> +	if (!size || size % CPLD_PAGE_SIZE) {
> +		WRITE_ONCE(bp->cpld_cancel, false);
> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> +	}
> +
> +	bp->cpld_in_config_mode = false;
> +
> +	mutex_lock(&bp->cpld_lock);
> +
> +	err = adva_x1_bus_claim(bp);
> +	if (err) {
> +		ret = adva_cpld_err(bp, err);
> +		goto err_unlock;
> +	}

[ ... ]

> +	err = adva_x1_cpld_write(bp, CPLD_CMD_ERASE);
> +	if (!err)
> +		err = adva_x1_cpld_wait_ready(bp, 15000);
> +	if (err) {
> +		ret = adva_cpld_err(bp, err);
> +		goto err_deselect;
> +	}

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

[Severity: Medium]
Can DIS_CFG reach the CPLD while it is still busy erasing?

adva_x1_cpld_wait_ready() returns as soon as the cancel flag is seen, or as
soon as a status read fails, i.e. possibly with CPLD_STATUS_BUSY still
asserted:

	ret = read_poll_timeout(adva_x1_cpld_read_status, err,
				err || READ_ONCE(bp->cpld_cancel) ||
				(status & CPLD_STATUS_FAILED) ||
				!(status & CPLD_STATUS_BUSY),

A "echo 1 > cancel" during the 15 s config-sector erase therefore lands in
err_deselect with the erase in flight.  The abort path then sends DIS_CFG,
discards its result and clears the bookkeeping unconditionally:

	if (bp->cpld_in_config_mode) {
		adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG);
		bp->cpld_in_config_mode = false;
	}

before deselecting the mux and handing the TMC segment back to the
MicroBlaze.  If the ISC_DISABLE is not latched (device busy, NACK, I2C
error) the part stays in transparent configuration mode with a partially
erased configuration flash, while the driver records that it left the mode,
so nothing will issue DIS_CFG again.  adva_cpld_cleanup() has the same shape
for a canceled page write.

Would waiting for BUSY to clear under a hard deadline before DIS_CFG, and
keeping cpld_in_config_mode set when the DIS_CFG transfer itself fails, be
safer here?

> +
> +static enum fw_upload_err
> +adva_cpld_write(struct fw_upload *fwl, const u8 *data,
> +		u32 offset, u32 size, u32 *written)
> +{

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
> +	err = adva_x1_cpld_write(bp, CPLD_CMD_SET_DONE);
> +	if (!err)
> +		err = adva_x1_cpld_wait_ready(bp, 1000);
> +	if (err)
> +		return adva_cpld_err(bp, err);
> +
> +	err = adva_x1_cpld_read_status(bp, &st);
> +	if (err)
> +		return adva_cpld_err(bp, err);
> +	if (!(st & CPLD_STATUS_DONE))
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +
> +	err = adva_x1_cpld_write(bp, CPLD_CMD_REFRESH);
> +	if (err)
> +		return adva_cpld_err(bp, err);
> +
> +	/* REFRESH reboots the CPLD out of configuration mode, so cleanup()
> +	 * must not send DIS_CFG afterwards even if the checks below fail.
> +	 */
> +	bp->cpld_in_config_mode = false;
> +
> +	/* The new image is already running at this point, so a segment that
> +	 * is not back yet must not be reported as a failed update: retry the
> +	 * reselect instead of sampling the mux once at a fixed delay.
> +	 */
> +	msleep(1500);
> +	if (read_poll_timeout(adva_x1_mux_select, err, !err, CPLD_POLL_US,
> +			      3000 * USEC_PER_MSEC, false,
> +			      bp, ADVA_MUX_CHANNEL))
> +		return FW_UPLOAD_ERR_TIMEOUT;

[Severity: Low]
Should this poll also look at bp->cpld_cancel?

The exit condition is only !err, and the failure branch returns
FW_UPLOAD_ERR_TIMEOUT without going through adva_cpld_err(), so a cancel
arriving while the mux keeps failing neither ends the loop nor produces
FW_UPLOAD_ERR_CANCELED, and the flush_work() inside
firmware_upload_unregister() waits out the full 3 s on top of the preceding
msleep(1500).  The adva_x1_cpld_wait_ready() below does honour the flag, but
only once the mux answers.

> +
> +	err = adva_x1_cpld_wait_ready(bp, 3000);
> +	if (err)
> +		return adva_cpld_err(bp, err);
> +
> +	return FW_UPLOAD_ERR_NONE;
> +}

[Severity: Medium]
Is the CPLD state validated after REFRESH before reporting success?

CPLD_STATUS_DONE is only sampled before CPLD_CMD_REFRESH.  The single
post-REFRESH check is adva_x1_cpld_wait_ready(), which accepts any status
with BUSY clear and CPLD_STATUS_FAILED clear, and discards the status word,
so neither DONE nor the MachXO3 configuration error field is examined after
the device reloads the newly programmed image.  A CRC or preamble error, or
a refresh that leaves DONE deasserted, would be reported to userspace as a
successful update.

The other in-tree MachXO drivers do check both after refresh:

drivers/fpga/machxo2-spi.c:machxo2_write_complete() {
	...
		if (!test_bit(BUSY, &status) && test_bit(DONE, &status) &&
		    get_err(&status) == ENOERR)
			break;
	...
}

Would a similar DONE plus error-field check after REFRESH be appropriate
here?

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

[ ... ]

> @@ -5214,6 +5578,15 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>  {
>  	int i;
>  
> +	/* Must come first: cancels and flushes an in-flight upload while the
> +	 * I2C controller is still up, and drops cpld_lock so a cpld_status
> +	 * reader cannot stall ptp_ocp_attr_group_del() below.
> +	 */
> +	if (bp->cpld_fw_upload) {
> +		firmware_upload_unregister(bp->cpld_fw_upload);
> +		bp->cpld_fw_upload = NULL;
> +	}
> +
>  	ptp_ocp_debugfs_remove_device(bp);
>  	ptp_ocp_detach_sysfs(bp);
>  	ptp_ocp_attr_group_del(bp);

[Severity: High]
This window is not introduced by this patch, but is the cancel-and-flush
guarantee the comment relies on unconditional?

firmware_upload_unregister() skips both the cancel and the flush when it
samples IDLE:

drivers/base/firmware_loader/sysfs_upload.c:firmware_upload_unregister() {
	mutex_lock(&fw_upload_priv->lock);
	if (fw_upload_priv->progress == FW_UPLOAD_PROG_IDLE) {
		mutex_unlock(&fw_upload_priv->lock);
		goto unregister;
	}
	...
	flush_work(&fw_upload_priv->work);

unregister:
	device_unregister(&fw_sysfs->dev);
	module_put(module);
}

A "echo 0 > loading" taking the same lock immediately afterwards queues the
work:

fw_upload_start() {
	...
	fwlp->progress = FW_UPLOAD_PROG_RECEIVING;
	...
	queue_work(system_long_wq, &fwlp->work);
}

and the device_unregister() above then reaches fw_dev_release() ->
fw_upload_free(), which kfree()s fw_upload_priv, the structure embedding
that work_struct, and fw_upload itself.

A queued fw_upload_main() would then run adva_cpld_prepare() with
fwl->dd_handle == bp after ptp_ocp_detach() has done
mutex_destroy(&bp->cpld_lock) and devlink_free() has freed bp.  Since
prepare() now takes cpld_lock, the i2c root-adapter lock, an
i2c_get_adapter() reference and a kzalloc'd cpld_buf, and only drops them in
cleanup(), the same window could also leave the i2c bus lock held and the
adapter reference leaked.

The commit message states this as a guarantee:

  "The upload is unregistered first on detach, which cancels and flushes an
  in-flight programming cycle while the I2C controller is still up."

Could that be qualified, or could the driver gate adva_cpld_prepare() on its
own "detaching" flag so it does not depend on the core flushing?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908122328.52641-1-maimon.sagi%40gmail.com
