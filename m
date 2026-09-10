Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D388B370AC7;
	Thu, 10 Sep 2026 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053838; cv=none; b=t6LvHNW+SxXzhb0KeJDxWWymC1TWf8uA3t22TXRbyQIwxWLzFHtZJ14FPTObHrRC7sv9rFXmBYW+cGHjFRT08bCcM2X1Q8jnY51PTO/hlriuE6Gs//Q5gYkFOMrRtiXZXQiOhoZzx1LC4fVWhwy3EBUm9OCyPPnAtydv9jPfJ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053838; c=relaxed/simple;
	bh=pu5/tz3wV8/okY0fkj4xrT8QHWVvwLpkHFvkP52yv74=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mWQmLuqj2c2u2Nv5Rry+PYOaKBIxIMB2ClK77PqWVc3uBDN/VnvkiZq7txl0h8iOuqX3BdnSOPNyzZ+sBj9Nmdn34H+/1vRkeOslpWCKpjDPTk2xYKyBcSriE7aEn6cb1tB4R6vmAt2jOo11yq+dIvWKaZXygLEz758hLd6npSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czaf/MEF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czaf/MEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8461F00893;
	Thu, 10 Sep 2026 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789053836;
	bh=1blk8XFZRv3vLtqIMKA4rhgLEGOFjy5Rjzb6diRm8Cg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Czaf/MEF6fdbIiMT2eoBQgR1BN/tkLMHrTAiYR5bSD3KkOZiaw/K2Adg96KD7+WVC
	 O7ExhgV1tFFXlxBMsubt7SyjTxJ5cvp31PBg3C4UQOH2B0iUoaeTl2fhnW0HS1Ni5f
	 NoKxkPZOQB4MBuDR+kQwFONYWquGqpYSZ15Wg/ztk8v3c8OmwCI43EM2tvtSuCEdIe
	 2vCEDlkheQHz4a5QSQpZOmphjPWin9PwUkGi8+lASNVR0I3Yi7TqXtxs93e1ZOoPTE
	 1xzLVzGm4hnbCZPhI9dWTQ6iwPIbOKU+hdlrkyzuSPq4lTJXZGFsi5zETFtu6zAWlh
	 /djBD59czbjiQ==
Subject: Re: [PATCH net-next v13 1/2] ptp: ocp: add TAP CPLD access for ADVA
 TimeCard X1
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 15:23:55 +0000
Message-ID: <178905383532.219967.4546424154870042444@kernel.org>
In-Reply-To: <20260908122328.52641-2-maimon.sagi@gmail.com>
References: <20260908122328.52641-2-maimon.sagi@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 3 (1) · Low: 5

- [Medium] ptp_ocp_probe() silently fixes a pre-existing devlink teardown
  bug.
- [Medium] In ptp_ocp_sync_work() (drivers/ptp/ptp_ocp.c:5406-5409) the
  one-shot flag bp->cpld_id_tried is latched for every return value of…
- [Medium] The grant hand-back is fire-and-forget.
- [Low] The comment above adva_x1_cpld_read_id()
  (drivers/ptp/ptp_ocp.c:4503-4508) states "Returns -EBUSY if the bus is…
- [Low] ptp_ocp_i2c_notifier_call() (drivers/ptp/ptp_ocp.c:5590-5602)
  publishes and invalidates bp->cpld_i2c_adap_nr for *any* i2c adapter…
- [Low] The new Documentation/ABI/testing/sysfs-timecard entry for
  cpld_status states "The Lattice device ID of the CPLD is read once at…
- [Low] Documentation/networking/devlink/ptp_ocp.rst claims to describe
  "the devlink features implemented by the ptp_ocp device driver" and is…
- [Low] bp->cpld_id is written by adva_x1_cpld_read_id()
  (drivers/ptp/ptp_ocp.c:4525) from the sync worker under cpld_lock, but…

Pre-existing issues:
- [High] In ptp_ocp_probe(), if any dpll_pin_get() or dpll_pin_register()
  fails after dpll_device_register() succeeded, the out_dpll path…
- [Medium] In ptp_ocp_probe(), when dpll_device_register() fails (line
  5493-5494) the code jumps to the new out_devlink label, which calls…

--

ptp: ocp: add TAP CPLD access for ADVA TimeCard X1

This adds a request/grant handshake that re-routes the host I2C controller
from the config EEPROMs onto the TMC bus, plus read-only access to the
Lattice CPLD behind the PCA9548 on that bus.  The CPLD device ID is read
once from the sync worker and reported as the fixed devlink version
"cpld.id", and a new root-only cpld_status sysfs attribute reports the
CPLD status register.

A few questions below.

> diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
> index 3ae41b7634ac..70ecc15b347f 100644
> --- a/Documentation/ABI/testing/sysfs-timecard
> +++ b/Documentation/ABI/testing/sysfs-timecard
> @@ -11,6 +11,26 @@ Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
>  Description:	This directory contains the attributes of the Nth timecard
>  		registered.
>  
> +What:		/sys/class/timecard/ocpN/cpld_status
> +Date:		July 2026
> +Contact:	Sagi Maimon <maimon.sagi@gmail.com>
> +Description:	(RO, root only) The status register of the TAP CPLD, in
> +		human-readable form:
> +
> +		  done=<0|1> busy=<0|1> failed=<0|1>
> +
> +		Only present on ADVA x1 TAP boards (PCI ID 0xad5a:0x0410).
> +
> +		done=1 indicates the configuration flash was successfully
> +		programmed and is active.  busy=1 means an internal operation
> +		is in progress.  failed=1 means the last ISC operation failed.
> +
> +		A read arbitrates for the shared I2C bus and reprograms the
> +		on-card mux, so it is restricted to root.  The Lattice device
> +		ID of the CPLD is read once at probe and reported as the
> +		fixed "cpld.id" version by devlink dev info.

[Severity: Low]
Is the "read once at probe" wording accurate?  ptp_ocp_probe() only
initialises cpld_lock and sets cpld_i2c_adap_nr = -1; the only caller of
adva_x1_cpld_read_id() is ptp_ocp_sync_work(), so the earliest the ID can
be read is one sync_work tick (HZ) after probe returns, and only once the
adapter number has been cached by the notifier.

Documentation/networking/devlink/ptp_ocp.rst added by the same patch says
the opposite:

  so the driver does that once from its
  own worker and reports the cached value here

Should the ABI text be reworded to match, so the two files agree?

> diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
> new file mode 100644
> index 000000000000..3f997cd9f3a3
> --- /dev/null
> +++ b/Documentation/networking/devlink/ptp_ocp.rst
> @@ -0,0 +1,35 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +========================
> +ptp_ocp devlink support
> +========================
> +
> +This document describes the devlink features implemented by the ``ptp_ocp``
> +device driver.
> +
> +Info versions
> +=============

[Severity: Low]
The file states it describes "the devlink features implemented by the
ptp_ocp device driver", and index.rst says each driver file documents
"parameters, info versions, and other features it supports", but only info
versions are covered here.

ptp_ocp_devlink_ops also implements flash update:

	.flash_update = ptp_ocp_devlink_flash_update,
	.info_get = ptp_ocp_devlink_info_get,

Would it make sense to add a flash update section, or to narrow the
introductory sentence to info versions?

[ ... ]

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 3d26ec1f7b9e..7db1dc9b94bd 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -2166,6 +2187,17 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
>  	if (err)
>  		return err;
>  
> +	/* Read by the worker, not here: this command is unprivileged and
> +	 * reading the ID claims the I2C bus.  0 means unread - skip it
> +	 * rather than fail, devlink discards the whole reply on error.
> +	 */
> +	if (bp->cpld_id) {
> +		sprintf(buf, "0x%08x", bp->cpld_id);
> +		err = devlink_info_version_fixed_put(req, "cpld.id", buf);
> +		if (err)
> +			return err;
> +	}

[Severity: Low]
Should these two reads of bp->cpld_id use READ_ONCE()?

The field is written in adva_x1_cpld_read_id() under cpld_lock:

	if (!ret)
		bp->cpld_id = get_unaligned_be32(data);

while this path reads it with no lock at all, so the test and the sprintf()
argument are two independent plain loads that the compiler may reload.
Today the value only ever transitions 0 -> ID once, so the effect is limited
to a KCSAN report, but the neighbouring lock-free field is already annotated
(READ_ONCE(bp->cpld_i2c_adap_nr) / WRITE_ONCE()), so the asymmetry stands
out.  bp->cpld_id_tried is a plain read/write as well.

[ ... ]

> @@ -4226,6 +4259,319 @@ static const struct ocp_attr_group art_timecard_groups[] = {
>  	{ },
>  };
>  

[ ... ]

> +static void adva_x1_mblaze_release(struct ptp_ocp *bp)
> +{
> +	if (bp->pps_select)
> +		iowrite32(MBLAZE_RELEASE, &bp->pps_select->i2c_bus_ctrl);
> +}
> +
> +/* Acquire the shared I2C bus from the MicroBlaze firmware.  Returns with no
> + * request outstanding on failure, so the firmware is never left granting a
> + * segment to a host that has given up waiting for it.
> + */
> +static int adva_x1_mblaze_acquire(struct ptp_ocp *bp)
> +{
> +	u32 val;
> +	int i;
> +
> +	if (!bp->pps_select)
> +		return -ENODEV;
> +
> +	/* Drop a request left by a caller that died mid-sequence; cpld_lock
> +	 * keeps live ones out.  The read back only flushes the posted write.
> +	 */
> +	iowrite32(0, &bp->pps_select->i2c_bus_ctrl);
> +	ioread32(&bp->pps_select->i2c_bus_ctrl);
> +
> +	iowrite32(MBLAZE_REQUEST, &bp->pps_select->i2c_bus_ctrl);
> +	for (i = 0; i < MBLAZE_RETRIES; i++) {
> +		usleep_range(MBLAZE_RETRY_US, MBLAZE_RETRY_US + 1000);
> +		val = ioread32(&bp->pps_select->i2c_bus_ctrl);
> +		if (val == MBLAZE_GRANTED)
> +			return 0;
> +	}
> +
> +	adva_x1_mblaze_release(bp);
> +	return -ETIMEDOUT;
> +}
> +
> +/* Route the host controller back to the EEPROMs and release the adapter.
> + * Safe after a failed claim: it also clears a request that was never granted.
> + */
> +static void adva_x1_bus_release(struct ptp_ocp *bp)
> +{
> +	struct i2c_adapter *adap = bp->cpld_adap;
> +
> +	if (!adap)
> +		return;
> +
> +	adva_x1_mblaze_release(bp);
> +	bp->cpld_adap = NULL;
> +	kfree(bp->cpld_buf);
> +	bp->cpld_buf = NULL;
> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> +	i2c_put_adapter(adap);
> +}

[Severity: Medium]
Can I2C traffic be issued on the TMC bus after the release?

The acquire direction of this handshake is fully synchronised: the posted
write is flushed with ioread32() and then the grant is polled for up to
200 x 10 ms.  The release direction in adva_x1_mblaze_release() is a bare
iowrite32(MBLAZE_RELEASE, ...) with no read-back to flush it, and
adva_x1_bus_release() then calls i2c_unlock_bus() immediately, without
polling for confirmation that the MicroBlaze has re-routed the 0x150000
controller back to the EEPROM segment.

As soon as i2c_unlock_bus() returns, a waiting ptp_ocp_read_eeprom(), an
nvmem attribute read or an at24 sysfs transfer can start clocking out
transactions:

	adva_x1_mblaze_release(bp);	/* posted, not flushed */
	...
	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);

If the firmware's re-route latency is non-zero, would those transactions
land on the TMC bus, i.e. the exact wrong-bus traffic the commit message
says the adapter lock exists to prevent?  An EEPROM read could then fill
bp->serial / bp->board_id from an unrelated TMC slave, and an at24 write
could be delivered to one.  Since the acquire path treats this register
transition as slow enough to need a flush plus a 2 s poll, should the
release path flush and confirm too?

[ ... ]

> +/*
> + * Read the Lattice device ID into bp->cpld_id.  Done once, off the
> + * unprivileged devlink path, which reports the cached value only.
> + * Returns -EBUSY if the bus is busy, so the caller can retry rather than
> + * wait out a firmware upload.  The LCMXO3LF-2100 IDCODE is 0xe12bc043.
> + */
> +static int adva_x1_cpld_read_id(struct ptp_ocp *bp)
> +{
> +	u8 data[4];
> +	int ret;
> +
> +	if (!mutex_trylock(&bp->cpld_lock))
> +		return -EBUSY;

[Severity: Low]
The comment says "Returns -EBUSY if the bus is busy, so the caller can
retry rather than wait", but the only source of -EBUSY is this
mutex_trylock() on cpld_lock.  Actual I2C bus contention is handled with a
blocking lock inside adva_x1_bus_claim():

	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);

so when ptp_ocp_read_eeprom(), an nvmem attribute or an at24 transfer holds
the root adapter lock, the sync worker waits there instead of returning
-EBUSY.  Could the comment say cpld_lock rather than "the bus"?  The
reference to waiting out a firmware upload only becomes meaningful with the
later "add TAP CPLD firmware upload for ADVA TimeCard X1" patch, which adds
a long-running cpld_lock holder.

> +	ret = adva_x1_bus_claim(bp);
> +	if (ret)
> +		goto out;
> +	ret = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
> +	if (ret)
> +		goto release;
> +	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_ID, data, 4);
> +	if (!ret)
> +		bp->cpld_id = get_unaligned_be32(data);
> +	adva_x1_mux_select(bp, -1);
> +release:
> +	adva_x1_bus_release(bp);
> +out:
> +	mutex_unlock(&bp->cpld_lock);
> +	if (ret)
> +		dev_dbg(&bp->pdev->dev,
> +			"CPLD device ID unavailable: %d\n", ret);
> +
> +	return ret;
> +}

[ ... ]

> @@ -5052,6 +5400,14 @@ ptp_ocp_sync_work(struct work_struct *work)
>  
>  	bp->sync = sync;
>  
> +	/* The i2c adapter is registered after probe returns, so the ID is
> +	 * read from here, once, as soon as the adapter shows up.
> +	 */
> +	if (bp->has_cpld && !bp->cpld_id_tried &&
> +	    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0 &&
> +	    adva_x1_cpld_read_id(bp) != -EBUSY)
> +		bp->cpld_id_tried = true;
> +
>  	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
>  }

[Severity: Medium]
Should transient failures also keep the retry alive here?  Only -EBUSY
avoids latching cpld_id_tried, and -EBUSY comes solely from the
mutex_trylock() in adva_x1_cpld_read_id().  Every other failure looks
transient:

  - -ETIMEDOUT from adva_x1_mblaze_acquire() when the MicroBlaze does not
    grant the TMC segment within the 200 x 10 ms poll (e.g. busy firmware
    right after power-up)
  - -ENOMEM from the kzalloc() in adva_x1_bus_claim()
  - the controller errno or -EIO from __i2c_transfer()

Any one of those on the single attempt leaves bp->cpld_id == 0 for the life
of the card, so the "if (bp->cpld_id)" test in ptp_ocp_devlink_info_get()
never becomes true and cpld.id is omitted permanently, with only a dev_dbg()
to show why.

Documentation/networking/devlink/ptp_ocp.rst says:

  the version is
  omitted until that read has succeeded.

which reads as though the driver keeps trying.  Would treating -ETIMEDOUT
and -ENOMEM the same way as -EBUSY match that description?

> @@ -5119,12 +5486,12 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(bp->dpll)) {
>  		err = PTR_ERR(bp->dpll);
>  		dev_err(&pdev->dev, "dpll_device_alloc failed\n");
> -		goto out;
> +		goto out_devlink;
>  	}
>  
>  	err = dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp);
>  	if (err)
> -		goto out;
> +		goto out_devlink;

[Severity: Medium]
These two redirects look like a fix for a separate, existing bug rather than
part of the CPLD feature.

devlink_register(devlink) runs before both call sites, and in the baseline
both used "goto out", reaching ptp_ocp_detach() and then
devlink_free(devlink) with the instance still registered.  devlink_free()
starts with:

net/devlink/core.c:devlink_free() {
	ASSERT_DEVLINK_NOT_REGISTERED(devlink);
	...
}

so the old paths would trip that assertion.  The new comment on the label
attributes the change to cpld_lock teardown instead:

	/* detach() destroys cpld_lock; no devlink op may still reach it */

Could this be split out as its own patch with a Fixes: tag, so it can be
reviewed and backported independently of the CPLD work?

[Severity: Medium]
This isn't a bug introduced by this patch (the baseline used "goto out"
here, which skipped the same call), but since these gotos are being rewritten
anyway: on the dpll_device_register() failure path, is the reference taken a
few lines earlier by dpll_device_get(clkid, 0, THIS_MODULE, &bp->tracker)
ever dropped?

out_devlink falls into "out: ptp_ocp_detach(bp)", ptp_ocp_detach() does not
touch bp->dpll, and only out_dpll calls dpll_device_put().  So a failing
dpll_device_register() (-ENOMEM or -EEXIST) leaves the dpll_device in
dpll_device_xa with a leaked reference and a stale ref-tracker entry.

>  
>  	for (i = 0; i < OCP_SMA_NUM; i++) {
>  		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE,
> @@ -5151,6 +5518,9 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		dpll_pin_put(bp->sma[i].dpll_pin, &bp->sma[i].tracker);
>  	}
>  	dpll_device_put(bp->dpll, &bp->tracker);
> +out_devlink:
> +	/* detach() destroys cpld_lock; no devlink op may still reach it */
> +	devlink_unregister(devlink);
>  out:
>  	ptp_ocp_detach(bp);
>  out_disable:

[Severity: High]
This is a pre-existing issue and not introduced by this patch (the same code
is in the baseline; the patch only redirects the earlier gotos), but it sits
directly in the path being edited.

Should out_dpll call dpll_device_unregister(bp->dpll, &dpll_ops, bp) before
dpll_device_put()?  dpll_device_register() takes a second reference and
stores bp:

drivers/dpll/dpll_core.c:dpll_device_register() {
	...
	reg->ops = ops;
	reg->priv = priv;
	dpll->type = type;
	__dpll_device_hold(dpll, &reg->tracker);
	...
}

and only dpll_device_unregister() drops it:

drivers/dpll/dpll_core.c:dpll_device_unregister() {
	...
	list_del(&reg->list);
	__dpll_device_put(dpll, &reg->tracker);
	kfree(reg);
	...
}

If a dpll_pin_get() or dpll_pin_register() fails after dpll_device_register()
succeeded, out_dpll drops only bp->tracker, so the device stays registered
and visible to userspace with reg->priv still pointing at bp, while probe
continues to ptp_ocp_detach() and devlink_free(devlink), which frees the
storage holding bp.  Can a later dpll netlink get or dump then call the
dpll_ops callbacks on freed memory, in addition to leaking the registration
object?

> @@ -5219,11 +5589,17 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
>  
>  found:
>  	bp = dev_get_drvdata(dev);
> -	if (add)
> +	if (add) {
>  		ptp_ocp_symlink(bp, child, "i2c");
> -	else
> +		/* Cache the number; adva_x1_bus_claim() takes the reference
> +		 * and re-checks the parent, as the number can be recycled.
> +		 */
> +		WRITE_ONCE(bp->cpld_i2c_adap_nr, i2c_verify_adapter(child)->nr);
> +	} else {
> +		/* invalidate before free */
> +		WRITE_ONCE(bp->cpld_i2c_adap_nr, -1);
>  		sysfs_remove_link(&bp->dev.kobj, "i2c");
> -
> +	}
>  	return 0;
>  }

[Severity: Low]
Should this side apply the same identity check that the consumer applies?

The notifier publishes and invalidates cpld_i2c_adap_nr for any i2c adapter
whose ancestor walk reaches a device bound to ptp_ocp, while
adva_x1_bus_claim() insists on the card's own controller:

	if (!bp->i2c_ctrl || adap->dev.parent != &bp->i2c_ctrl->dev) {
		i2c_put_adapter(adap);
		return -ENODEV;
	}

i2c-mux child adapters pass the notifier filter but fail that test, because
i2c_mux_add_adapter() sets:

	priv->adap.dev.parent = &parent->dev;

so if root instantiates a mux on the card's adapter (writing "pca9548 0x74"
to new_device), each child's ADD notification overwrites cpld_i2c_adap_nr
with the mux segment number and every later claim returns -ENODEV; a child's
DEL notification writes -1 while the card's own controller is still alive.
There is no re-arm path in either case, so cpld_status and the one-shot
cpld.id read stay disabled for the life of the card.  Would testing
i2c_verify_adapter(child)->dev.parent == &bp->i2c_ctrl->dev here avoid that?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908122328.52641-1-maimon.sagi%40gmail.com
