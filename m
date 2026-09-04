Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66903B5837;
	Fri,  4 Sep 2026 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507988; cv=none; b=ljPD8vFrtspH6ncsl1cL7VY5RgQS7pim46vRm3dnyOWSj3XVxF+CBs70hkZS8g3bThJaajlBETavXJdFSrkIuGSOxx5vnHtRYtSiCpDRtyEChzhDUphJOlgGBw5CFxPCyAXspW1xPCqQWjZ4bIiyCQ8AeuE74AuP+QFYAscF01w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507988; c=relaxed/simple;
	bh=Af5N8hm/xRPq6zEHnEqArpN2A7uUcanC8hHsxnOQIfQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aryq0atYBEL7YnAB282SUQFhGZ7oPcAd/+F7PO+yJbdZErMufOrhWuMqnKG44t/H6tmVlbE4Y716RFcIlLZICJ0Sl05oEIVsxUR5z+f8khZ0VGHhUURcWmz4KVAaYKHTh3keeUxC5SPajnXNdNpTjabmmxrDED3yOMEToly4npM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7MeiSOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7MeiSOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0089C1F00A3D;
	Fri,  4 Sep 2026 07:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788507986;
	bh=QSXTGowi8t/gozr1gkzan/NGkzS0kW8mWtVoTk0TFmo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B7MeiSOLBYIcYmLY7Y3Z/OvuWJOQS3XQQNryQSG7DWMUJaxBDZfoLflq51P2oV3xU
	 Ifzz11K1s/cTRr2pb0OK6KbkUlp3qWzWZnO2mHYh53aRPulBXWqm3SfKDRe5SYd3cK
	 hGs+UlP2mZnr8Sno2VVAvHjpZ0uUV+ac1cDnE2j/DTvGbSIS7UWC8TOE9xU22DnuyK
	 9gIn9ZEmARAZlEy4r4vsuDQRvM+Yyzr02o9pDsEx3A4pBGa+Oo3FNz8yvOPeBSA9/h
	 S/c4y38jaCOrsoqazz4JQNG0c0iiW2DNkoLL9za2vAQZgfphSFdzE+oYXvroJhc03C
	 AHgOLZsaSIqFA==
Subject: Re: [PATCH net-next v12 1/2] ptp: ocp: add TAP CPLD access for ADVA
 TimeCard X1
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 richardcochran@gmail.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 07:46:25 +0000
Message-ID: <178850798552.4131868.12299042910188690542@kernel.org>
In-Reply-To: <20260902044232.21188-2-maimon.sagi@gmail.com>
References: <20260902044232.21188-2-maimon.sagi@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 5 · Low: 2

- [High] The CPLD bus-arbitration/mux-reprogramming operation that the
  patch deliberately restricts to root via…
- [High] `ptp_ocp_devlink_info_get()` propagates any failure of the new
  `adva_x1_cpld_device_id()` read out of the `->info_get()` callback…
- [Medium] `adva_x1_i2c_xfer()` marks both messages `I2C_M_DMA_SAFE`
  (`.flags = I2C_M_DMA_SAFE` for the write and `I2C_M_RD |…
- [Medium] The new `cpld.id` reporting block is appended at the end of
  `ptp_ocp_devlink_info_get()`, i.e. after the pre-existing `if…
- [Medium] `adva_x1_bus_claim()` resolves the I2C adapter from a cached
  adapter *number* (`i2c_get_adapter(READ_ONCE(bp->cpld_i2c_adap_nr))`)…
- [Medium] `ptp_ocp_detach()` now calls `mutex_destroy(&bp->cpld_lock)`,
  but on the probe error paths detach runs while the devlink instance is…
- [Medium] Acquiring the shared I2C segment is a polled firmware
  handshake (`iowrite32(MBLAZE_REQUEST)` then up to 200 x 10 ms polling…
- [Low] Several new comments in this patch document a CPLD firmware-
  upload path that does not exist in the tree at this commit: the struct…
- [Low] The patch introduces the driver-specific devlink version name
  `cpld.id` without the driver-specific devlink documentation that…

--

ptp: ocp: add TAP CPLD access for ADVA TimeCard X1

This adds a MicroBlaze request/grant handshake that re-routes the host I2C
controller of the ADVA TimeCard X1 from the config EEPROMs onto the TMC bus,
plus read-only accessors for the Lattice CPLD behind the PCA9548 there.  The
CPLD device ID is exported as the fixed devlink version cpld.id and the status
register as a new root-only cpld_status sysfs attribute.

A few questions below.

> diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
> index 3ae41b7634ac9..b384e837c5e64 100644
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
> +		ID of the CPLD is reported as the fixed "cpld.id" version by
> +		devlink dev info.
> +
> +
>  What:		/sys/class/timecard/ocpN/available_clock_sources
>  Date:		September 2021
>  Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 3d26ec1f7b9ec..0c5c3ec8de5fa 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -85,6 +87,7 @@ struct ptp_ocp_adva_info {
>  	u8				signals_nr;
>  	u8				freq_in_nr;
>  	const struct ocp_attr_group	*attr_groups;
> +	bool				has_cpld; /* x1: supports CPLD firmware upload */
>  };

[Severity: Low]

This isn't a bug, but the comment describes a firmware upload path that does
not exist yet at this commit.  Here has_cpld only gates the devlink cpld.id
version and the cpld_status attribute.

Two other new comments have the same forward reference.  In
adva_x1_bus_claim():

	 * EEPROMs.  A firmware upload holds it across the whole prepare/write/poll
	 * sequence, so an EEPROM read blocks for as long as programming takes.

and in ptp_ocp_i2c_notifier_call():

		/* Cache adapter nr; used by the CPLD status/id/upload paths

The follow-up patch in the series that adds firmware_upload_register() and
the prepare/write/poll_complete ops makes all three accurate, so this is only
about patch 1 reading on its own.  At this commit the longest hold of the
adapter lock is the ~2s MBLAZE_RETRIES timeout, not a programming cycle.

[ ... ]

> @@ -416,6 +420,13 @@ struct ptp_ocp {
>  	dpll_tracker tracker;
>  	int signals_nr;
>  	int freq_in_nr;
> +	/* adva_x1 CPLD I2C (internal use only) */
> +	struct mutex		cpld_lock;            /* serialises CPLD operations */
> +	int			cpld_i2c_adap_nr;     /* I2C adapter nr; -1 if absent */
> +	struct i2c_adapter	*cpld_adap;           /* claimed adapter; valid under cpld_lock */
> +	u8			*cpld_buf;            /* DMA-safe scratch; valid under cpld_lock */
> +	u32			cpld_id;              /* cached Lattice device ID; 0 if unread */
> +	bool			has_cpld;             /* x1 TAP CPLD present */
>  };

[ ... ]

> @@ -2185,6 +2198,19 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
>  	if (err)
>  		return err;
>  
> +	if (bp->has_cpld) {
> +		u32 id;
> +
> +		err = adva_x1_cpld_device_id(bp, &id);

[Severity: High]

The same hardware operation is root-only through sysfs:

	static DEVICE_ATTR_ADMIN_RO(cpld_status);

and the new ABI text says "A read arbitrates for the shared I2C bus and
reprograms the on-card mux, so it is restricted to root."

Is that restriction bypassed here?  DEVLINK_CMD_INFO_GET is registered in
net/devlink/netlink_gen.c with only .flags = GENL_CMD_CAP_DO and
GENL_CMD_CAP_DUMP, without GENL_ADMIN_PERM, so any user can walk:

devlink dev info
  devlink_nl_info_get_doit()
    ptp_ocp_devlink_info_get()
      adva_x1_cpld_device_id()
        adva_x1_bus_claim()
          i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER)
          adva_x1_mblaze_acquire()

adva_x1_mblaze_acquire() then sleeps in a 200 x usleep_range(10000, 11000)
loop while the adapter lock is held and the controller is routed away from the
EEPROMs.

Since bp->cpld_id is assigned only on a successful read, a card where the
handshake does not complete repeats the whole ~2s arbitration on every call:

	if (bp->cpld_id) {
		*id = bp->cpld_id;
		return 0;
	}

Can an unprivileged loop over devlink dev info keep the EEPROM, nvmem and at24
paths off the controller indefinitely this way, and should the devlink path
either use a value cached at probe time or be gated the way cpld_status is?

> +		if (err)
> +			return err;
> +

[Severity: High]

Should a failure of this optional version string abort the entire info reply?
devlink discards the message when ->info_get() returns non-zero, so the fw
version, serial number and board id that were already put above are lost.

For the dump form, devlink_nl_info_get_dump_one() tolerates exactly one errno:

	if (err == -EOPNOTSUPP)
		err = 0;
	return err;

so -ENODEV, -ENOMEM, -ETIMEDOUT or -ERESTARTSYS coming out of the new path
aborts devlink dev info for every devlink instance on the host, not just this
card.

-ENODEV is reachable in an ordinary configuration rather than a race:
bp->cpld_i2c_adap_nr keeps the -1 sentinel written in ptp_ocp_probe() whenever
no i2c adapter device ever appears (xiic-i2c not built or not bound, or the
i2c resource skipped), and adva_x1_bus_claim() starts with

	adap = i2c_get_adapter(READ_ONCE(bp->cpld_i2c_adap_nr));
	if (!adap)
		return -ENODEV;

Would skipping the cpld.id put on error be better here, matching how the
function already degrades for missing EEPROM data?

> +		sprintf(buf, "0x%08x", id);
> +		err = devlink_info_version_fixed_put(req, "cpld.id", buf);
> +		if (err)
> +			return err;
> +	}
> +
>  	return 0;
>  }

[Severity: Medium]

This block is appended after the pre-existing early return earlier in the same
function:

	if (!bp->has_eeprom_data) {
		ptp_ocp_read_eeprom(bp);
		if (!bp->has_eeprom_data)
			return 0;
	}

The CPLD id is read over the TMC I2C bus and has no dependency on bp->serial
or bp->board_id, yet ptp_ocp_read_eeprom() takes its fail: path when
ptp_ocp_nvmem_device_get() returns an error pointer (at24/nvmem provider not
bound) or nvmem_device_read() returns a short count, leaving has_eeprom_data
false.

On such a card devlink dev info succeeds but never reports cpld.id, while the
new ABI entry states:

		The Lattice device
		ID of the CPLD is reported as the fixed "cpld.id" version by
		devlink dev info.

Should the cpld.id put happen before the EEPROM early return?

[Severity: Low]

cpld.id is a driver-specific devlink version name.
Documentation/networking/devlink/devlink-info.rst says that driver-specific
names are a last resort and "should be documented in the driver-specific
file", but there is no ptp_ocp file under Documentation/networking/devlink/
and no entry for one in its index.  The only description of cpld.id is the
prose inside the sysfs-timecard entry for cpld_status.  Could a devlink
driver documentation file be added for it?

[ ... ]

> @@ -4226,6 +4253,315 @@ static const struct ocp_attr_group art_timecard_groups[] = {
>  	{ },
>  };
>  
> +/*
> + * Internal helpers for the adva_x1 TAP CPLD (Lattice LCMXO3LF-2100).

[ ... ]

> +/*
> + * adva_x1_i2c_xfer() - issue a single I2C transaction on the TMC bus.
> + *
> + * Writes @cmd when it is not negative, followed by @wlen bytes of @wdata,
> + * then reads @rlen bytes if asked.  A NULL @wdata sends zeros.
> + *
> + * The message is assembled in the scratch buffer taken by
> + * adva_x1_bus_claim(), which the Xilinx controller needs for DMA safety:
> + * an opcode and its arguments are copied exactly once.
> + *
> + * Caller must hold that claim, hence __i2c_transfer() over i2c_transfer().
> + */
> +static int adva_x1_i2c_xfer(struct ptp_ocp *bp, u8 addr, int cmd,
> +			    const void *wdata, u8 wlen,
> +			    void *rdata, u8 rlen)
> +{

[ ... ]

> +	wbuf = bp->cpld_buf;
> +	rbuf = bp->cpld_buf + ADVA_CPLD_XFER_MAX;
> +
> +	if (hdr + wlen) {
> +		if (hdr)
> +			wbuf[0] = cmd;
> +		if (wdata)
> +			memcpy(wbuf + hdr, wdata, wlen);
> +		else
> +			memset(wbuf + hdr, 0, wlen);
> +		msgs[nmsgs++] = (struct i2c_msg){
> +			.addr  = addr,
> +			.flags = I2C_M_DMA_SAFE,
> +			.len   = hdr + wlen,
> +			.buf   = wbuf,
> +		};
> +	}
> +	if (rlen) {
> +		msgs[nmsgs++] = (struct i2c_msg){
> +			.addr  = addr,
> +			.flags = I2C_M_RD | I2C_M_DMA_SAFE,
> +			.len   = rlen,
> +			.buf   = rbuf,
> +		};
> +	}

[Severity: Medium]

Do these two buffers really satisfy the I2C_M_DMA_SAFE contract?  Both are
halves of a single 64-byte allocation made in adva_x1_bus_claim():

	bp->cpld_buf = kzalloc(2 * ADVA_CPLD_XFER_MAX, GFP_KERNEL);

with rbuf = bp->cpld_buf + 32.  Setting I2C_M_DMA_SAFE tells the core the
buffer can be handed straight to the adapter's DMA mapping:

drivers/i2c/i2c-core-base.c:i2c_get_dma_safe_msg_buf() {
	if (msg->flags & I2C_M_DMA_SAFE)
		return msg->buf;
	...
}

so no bounce buffer is allocated and the interior pointer is used as is.
kmalloc only guarantees alignment for the start of the allocation, so
cpld_buf + 32 is merely 32-byte aligned and shares a cacheline with the write
half on any architecture with a 64-byte or larger cacheline.  That puts the
DMA_TO_DEVICE and DMA_FROM_DEVICE buffers of the same transfer in one line.

The justification in the comment above also does not seem to hold:
drivers/i2c/busses/i2c-xiic.c has no dma_map_single(), no
i2c_get_dma_safe_msg_buf() and no dmaengine use at all, so nothing behind this
card needs the flag.  Would dropping I2C_M_DMA_SAFE (letting the core bounce
if a future adapter does DMA), or using two separate allocations, be the
better option?

[ ... ]

> +static void adva_x1_mblaze_release(struct ptp_ocp *bp)
> +{
> +	if (bp->pps_select)
> +		iowrite32(MBLAZE_RELEASE, &bp->pps_select->i2c_bus_ctrl);
> +}

[Severity: Medium]

Acquiring the segment is a polled handshake, but releasing it is a single
fire-and-forget write with no wait for the MicroBlaze to route controller
0x00150000 back to the EEPROM segment.  adva_x1_bus_release() unlocks the
adapter immediately after:

	adva_x1_mblaze_release(bp);
	bp->cpld_adap = NULL;
	kfree(bp->cpld_buf);
	bp->cpld_buf = NULL;
	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);

Can the first EEPROM/nvmem/at24 transfer that was queued behind the CPLD
operation be issued while routing is still on the TMC bus?  That is the window
the commit message says the adapter lock closes:

    an operation
    takes the i2c core adapter lock for the whole grant window and uses
    __i2c_transfer() internally; without that, a concurrent transfer from
    ptp_ocp_read_eeprom(), from the nvmem attributes or from the at24 sysfs
    files would be issued onto the TMC bus instead of to the EEPROM.

Depending on hardware latency the result would be either a NAK surfacing as
"could not read eeprom", or a reply from an unrelated TMC device that gets
cached as serial number / board id.

There is a related question about the register values.  MBLAZE_RELEASE
(0x55550000) leaves the 0x5555 half that MBLAZE_GRANTED (0x5555aaaa) encodes
as the grant, and the next acquire writes 0 over that firmware-owned field
and discards the read-back:

	iowrite32(0, &bp->pps_select->i2c_bus_ctrl);
	ioread32(&bp->pps_select->i2c_bus_ctrl);

If that half is not host-writable, can the exact-match test val ==
MBLAZE_GRANTED be satisfied on the first poll by a stale grant?  Would polling
with a bounded timeout until the grant pattern is gone, before unlocking the
adapter, be more robust?

> +
> +/* Acquire the shared I2C bus from the MicroBlaze firmware.  Returns with no
> + * request outstanding on failure, so the firmware is never left granting a
> + * segment to a host that has given up waiting for it.
> + */
> +static int adva_x1_mblaze_acquire(struct ptp_ocp *bp)
> +{

[ ... ]

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

[ ... ]

> +static int adva_x1_bus_claim(struct ptp_ocp *bp)
> +{
> +	struct i2c_adapter *adap;
> +	int ret;
> +
> +	lockdep_assert_held(&bp->cpld_lock);
> +
> +	adap = i2c_get_adapter(READ_ONCE(bp->cpld_i2c_adap_nr));
> +	if (!adap)
> +		return -ENODEV;

[Severity: Medium]

Is the adapter identity guaranteed here?  The number is snapshotted first and
the reference is taken afterwards inside i2c_get_adapter(), which blocks on
the i2c core_lock that i2c_del_adapter() and i2c_add_adapter() hold while
releasing and allocating adapter numbers.  i2c_del_adapter() frees the idr
slot before device_del() fires the notifier that resets the cached number:

drivers/i2c/i2c-core-base.c:i2c_del_adapter() {
	found = idr_find(&i2c_adapter_idr, adap->nr);
	if (found == adap)
		idr_replace(&i2c_adapter_idr, NULL, adap->nr);
	...
}

and only later does the driver see:

		WRITE_ONCE(bp->cpld_i2c_adap_nr, -1); /* invalidate before free */

So if the card's xiic-i2c adapter is unbound after the snapshot and the number
is recycled by an unrelated adapter, can this claim return that foreign
adapter?  adva_x1_mux_select() and adva_x1_cpld_cmd_read() would then write a
PCA9548 channel select to 0x74 and Lattice ISC opcodes to 0x40 on somebody
else's bus while holding its root adapter lock.

Nothing re-validates ownership (for example adap->dev.parent ==
&bp->i2c_ctrl->dev), so the notifier comment describing this as
"reference-counted unbind-safe adapter access" does not seem to match.  Would
storing a refcounted adapter pointer from the notifier, or checking the
parent after i2c_get_adapter(), close this?

> +
> +	/* One scratch buffer per claim, not per transfer. */
> +	bp->cpld_buf = kzalloc(2 * ADVA_CPLD_XFER_MAX, GFP_KERNEL);
> +	if (!bp->cpld_buf) {
> +		i2c_put_adapter(adap);
> +		return -ENOMEM;
> +	}
> +
> +	i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> +	bp->cpld_adap = adap;
> +
> +	ret = adva_x1_mblaze_acquire(bp);
> +	if (ret)
> +		adva_x1_bus_release(bp);
> +
> +	return ret;
> +}

[ ... ]

> +static DEVICE_ATTR_ADMIN_RO(cpld_status);
> +
>  static struct attribute *adva_timecard_attrs[] = {

[ ... ]

> @@ -4904,6 +5241,7 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>  		clk_hw_unregister_fixed_rate(bp->i2c_clk);
>  	if (bp->n_irqs)
>  		pci_free_irq_vectors(bp->pdev);
> +	mutex_destroy(&bp->cpld_lock);
>  	device_unregister(&bp->dev);
>  }

[Severity: Medium]

Is cpld_lock still reachable when it is destroyed here?  On the probe error
paths ptp_ocp_detach() runs while the devlink instance is still registered:
ptp_ocp_probe() calls devlink_register(devlink) and the later failures of
dpll_device_get(), dpll_device_register() and dpll_pin_register() fall through
to

out:
	ptp_ocp_detach(bp);
out_disable:
	pci_disable_device(pdev);
out_free:
	devlink_free(devlink);

with no devlink_unregister() in between.  The remove path does the right
ordering, calling devlink_unregister() before ptp_ocp_detach().

Since this patch makes ptp_ocp_devlink_info_get() take cpld_lock and then
touch bp->pps_select MMIO and claim the i2c adapter, and
DEVLINK_CMD_INFO_GET needs no privilege, can a concurrent devlink dev info in
that window lock a mutex that mutex_destroy() has already reset, and drive a
device whose i2c controller and IRQ vectors detach has released?

The comment added at the mutex_init() site reasons only about destroying an
initialised mutex:

	/* Must be before the first error path that calls ptp_ocp_detach(),
	 * so mutex_destroy() always runs on an initialised mutex.

Would unregistering devlink on the probe error path before detach, or moving
mutex_destroy() after all users are drained, be the fix?

> @@ -5219,11 +5568,16 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
>  
>  found:
>  	bp = dev_get_drvdata(dev);
> -	if (add)
> +	if (add) {
>  		ptp_ocp_symlink(bp, child, "i2c");
> -	else
> +		/* Cache adapter nr; used by the CPLD status/id/upload paths
> +		 * for reference-counted unbind-safe adapter access.
> +		 */
> +		WRITE_ONCE(bp->cpld_i2c_adap_nr, i2c_verify_adapter(child)->nr);
> +	} else {
> +		WRITE_ONCE(bp->cpld_i2c_adap_nr, -1); /* invalidate before free */
>  		sysfs_remove_link(&bp->dev.kobj, "i2c");
> -
> +	}
>  	return 0;
>  }

Thanks.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902044232.21188-1-maimon.sagi%40gmail.com
