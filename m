Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FCF3B27E3;
	Mon, 10 Aug 2026 23:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786403650; cv=none; b=b/rRkK/nr/5VnaoXgc99Ir0MF3ZzUuFhWig6dGpzuHGtsZ9x6W/SEcXLnlSg3WBhae6pB07uyHSu+UVhYvkyhPocQtYLRAQ0+RNLOoqhAjfJnFpMkzrglYUHm9g4BZTfpB/jB6Y5mB94JPufGOwL5kph2zW2gc428bb2nqB+Kes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786403650; c=relaxed/simple;
	bh=KFOB/oYx4Ujyek+eeQvclOjF4abVxKS8/m/hC3j62Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icFkWixpeAtyJuOXIxn2jproKwUKxHSDm0UKLLIaXGXfLWI7Lp604DUEqnZam9cCyvUg0Ekw5qkkOtzQVxUM5n9y7g8CfmuUoK0kbTWXltROP9OgU+8aNFduuWEs13168gYMCrPMODfU7hJX9SB0QfyI4D6pjsZwauPYHdycfB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI17j/Mn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI17j/Mn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3541F000E9;
	Mon, 10 Aug 2026 23:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786403648;
	bh=eVs60nQv+Pd3y3ll326K75+Yr0ygLDnknPDuU48dTe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aI17j/MnZ077MEGI2JsQAuk+b0s9QJC662FifziQaTLMG4MMSPzN/yKHrGBULRSH1
	 ndp2x9E7hJ+6yc0qmaOVLz8mWfYLeHo9kVSXdsbEYPoh9z/bhEi5uhRft7ienqW6zI
	 3eWiOuqHE2+BMUPOfClZLN7CSdjnHo4Fb4qelOAURzrgf1wpsymGoxVxwO8rC50XcW
	 Ttsr408PYyisACEH/6igfDVNTrBNBoY5L2Cm5ZZyJgV+WAaFND9WosbeR4T4Lok5Ko
	 Wj4uw3Wx7Md+qrV5nFOVLAFiWAlcC4e21BjD9rrk0AaPmO6Mh8TXsvISYXvAMn9dU6
	 cWj4hi1uHbTaA==
From: Jakub Kicinski <kuba@kernel.org>
To: maimon.sagi@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v10] ptp: ocp: add CPLD ISP support for ADVA TimeCard X1
Date: Mon, 10 Aug 2026 16:07:35 -0700
Message-ID: <20260810230735.955188-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805083154.3821-1-maimon.sagi@gmail.com>
References: <20260805083154.3821-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ptp: ocp: add CPLD ISP support for ADVA TimeCard X1

This adds Lattice MachXO3 CPLD in-system-programming support for the ADVA
TimeCard X1 over the card's I2C bus, arbitrated with the on-card MicroBlaze
firmware.  Two new read-only sysfs attributes (cpld_device_id, cpld_status)
are added along with firmware-upload callbacks for reflashing the CPLD.

A few questions about the new code below.

First, on the commit message:

    The CPLD is connected to a secondary I2C bus shared with the onboard
    MicroBlaze soft CPU.

    All CPLD operations are serialized and coordinated with the MicroBlaze
    firmware to ensure exclusive access to the shared I2C bus.

[Severity: Low]
Which bus is the "secondary" one here?  ocp_adva_x1_resource[] registers
only one I2C controller (OCP_I2C_RESOURCE(i2c_ctrl), xiic-i2c at
0x00150000), and that same adapter carries the on-card EEPROMs:

	{ I2C_BOARD_INFO("24c02", 0x50) },
	{ I2C_BOARD_INFO("24mac402", 0x58), .platform_data = "mac" },

adva_x1_i2c_xfer() then uses bp->cpld_i2c_adap_nr, which the notifier fills
in from that single adapter.

If it is the same adapter, is the "exclusive access" claim complete?  The
pre-existing EEPROM traffic (serialnum_show() -> ptp_ocp_read_eeprom(), and
the nvmem read paths) does not acquire MicroBlaze ownership, and it is not
aware that the CPLD paths leave the PCA9548 with all channels deselected
via adva_x1_mux_select(bp, -1).

> diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
> index 3ae41b7634ac9..f7c9955acb0a9 100644
> --- a/Documentation/ABI/testing/sysfs-timecard
> +++ b/Documentation/ABI/testing/sysfs-timecard
> @@ -11,6 +11,40 @@ Contact:	Jonathan Lemon <jonathan.lemon@gmail.com>
>  Description:	This directory contains the attributes of the Nth timecard
>  		registered.
>  
> +What:		/sys/class/timecard/ocpN/cpld_device_id
> +Date:		July 2026
> +Contact:	Sagi Maimon <maimon.sagi@gmail.com>
> +Description:	(RO) The 32-bit Lattice device ID of the TAP CPLD, reported as
> +		a hex string, e.g. "0xe12bc043".
> +
> +		Only present on ADVA x1 TAP boards (PCI ID 0xad5a:0x0410).
> +		The Lattice LCMXO3LF-210 reports 0xe12bc043.

[Severity: Low]
Which of the two documented IDCODEs is the right one?  This file says the
LCMXO3LF-210 reports 0xe12bc043 (twice, including the example output),
while the comment above cpld_device_id_show() in the same patch says:

	 * Returns the 32-bit ID as a hex string, e.g. "0x612bc043\n".
	 * Lattice LCMXO3LF-210 reports 0x612BC043.

Userspace that validates the attribute against the documented constant can
only match one of them.  The leading 0xe looks like it came from the
CPLD_CMD_READ_ID opcode 0xE0000000.

[ ... ]

> +		The driver acquires the MicroBlaze I2C bus internally; no bus
> +		arbitration is required from userspace.
> +
> +		To program new CPLD firmware use the standard kernel
> +		firmware-upload interface registered at:
> +		/sys/class/firmware/adva-cpld/
> +

[Severity: Medium]
Is this path documented unconditionally on purpose?  PTP_1588_CLOCK_OCP in
drivers/ptp/Kconfig selects NET_DEVLINK, CRC16 and DPLL, but not FW_UPLOAD,
and this patch does not touch any Kconfig file.

With CONFIG_FW_UPLOAD=n, firmware_upload_register() is the inline stub in
include/linux/firmware.h that returns ERR_PTR(-EINVAL), so
ptp_ocp_adva_board_init() only prints the dev_warn() and
/sys/class/firmware/adva-cpld/ never appears, while the upload callbacks
become dead code.  Should PTP_1588_CLOCK_OCP select FW_UPLOAD?

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 35e911f1ad78c..cb259413042b8 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -416,6 +421,12 @@ struct ptp_ocp {
>  	dpll_tracker tracker;
>  	int signals_nr;
>  	int freq_in_nr;
> +	/* adva_x1 CPLD I2C (internal use only) */
> +	struct mutex		cpld_lock;            /* serialises CPLD operations */
> +	int			cpld_i2c_adap_nr;     /* I2C adapter nr; -1 if absent */
> +	struct fw_upload	*cpld_fw_upload;      /* firmware upload handle; NULL if absent */
> +	bool			cpld_cancel;          /* cancellation requested */
> +	bool			cpld_in_config_mode;  /* EN_CFG_TP issued but not yet REFRESH'd */
>  };

[ ... ]

> @@ -3197,6 +3211,20 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>  		return err;
>  	ptp_ocp_sma_init(bp);
>  
> +	if (info->has_cpld) {
> +		struct fw_upload *fwl;
> +
> +		fwl = firmware_upload_register(THIS_MODULE, &bp->pdev->dev,
> +					       "adva-cpld",
> +					       &adva_cpld_upload_ops, bp);
> +		if (IS_ERR(fwl))
> +			dev_warn(&bp->pdev->dev,
> +				 "CPLD firmware upload unavailable: %pe\n",
> +				 fwl);
> +		else
> +			bp->cpld_fw_upload = fwl;
> +	}
> +

[Severity: Medium]
What happens with two X1 cards in the same host?  The name passed here is
the fixed string "adva-cpld", and firmware_upload_register() ->
fw_create_instance() does:

	dev_set_name(f_dev, "%s", fw_name);
	f_dev->parent = device;
	f_dev->class = &firmware_class;

so /sys/class/firmware/adva-cpld can only be created once and the second
device_add() should fail with -EEXIST.  Since the failure is only a
dev_warn() here, the second card loses the documented update path silently.
Every other interface of this driver is per-card (ocpN); would an
instance-qualified name be better here?

>  	return ptp_ocp_init_clock(bp, &info->servo);
>  }
>  
> @@ -4224,6 +4252,442 @@ static const struct ocp_attr_group art_timecard_groups[] = {
>  	{ },
>  };
>  

[ ... ]

> +/*
> + * adva_x1_i2c_xfer() - issue a single I2C transaction on the CPLD bus.
> + *
> + * All buffers are heap-allocated internally to guarantee DMA safety for
> + * the Xilinx I2C controller.  Caller must hold bp->cpld_lock.
> + */
> +static int adva_x1_i2c_xfer(struct ptp_ocp *bp,
> +			    u8 addr, const void *wdata, u8 wlen,
> +			    void *rdata, u8 rlen, bool nostart)
> +{

[Severity: Low]
This isn't a bug, but the "Caller must hold bp->cpld_lock" contract is not
expressed to the tools.  adva_cpld_prepare() returns with the mutex held
and adva_cpld_cleanup() unlocks a mutex it never took, and since
mutex_lock()/mutex_unlock() carry __acquires()/__releases() annotations,
sparse reports a context imbalance for both.  Would
__acquires(&bp->cpld_lock)/__releases(&bp->cpld_lock) plus
lockdep_assert_held(&bp->cpld_lock) in adva_x1_i2c_xfer(),
adva_cpld_write() and adva_cpld_poll_complete() make the contract
enforceable?

[ ... ]

> +	if (rlen) {
> +		rbuf = kzalloc(rlen, GFP_KERNEL);
> +		if (!rbuf) {
> +			ret = -ENOMEM;
> +			goto put;
> +		}
> +		msgs[nmsgs++] = (struct i2c_msg){
> +			.addr  = addr,
> +			.flags = I2C_M_RD | I2C_M_DMA_SAFE |
> +				 (nostart ? I2C_M_NOSTART : 0),
> +			.len   = rlen,
> +			.buf   = rbuf,
> +		};
> +	}

[Severity: Low]
Is I2C_M_NOSTART the flag that was intended here?  The only caller that
passes nostart=true is adva_x1_cpld_cmd_read(), whose comment says:

	 * Send a 4-byte command then read data back without an intermediate STOP
	 * (Lattice combined write→repeated-START→read).

I2C_M_NOSTART asks the adapter to skip the (re)START and to not resend the
slave address with the R/W bit, which is the opposite of a repeated-START
read, and it requires the adapter to advertise I2C_FUNC_NOSTART.  The
xiic-i2c controller this driver instantiates advertises only:

	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_SMBUS_BLOCK_DATA;

and never looks at I2C_M_NOSTART, and the core does not reject unsupported
protocol-mangling flags, so the flag is silently dropped and the transfer
becomes the plain write + repeated-START read that the ISC protocol wants.
On an adapter that does honour the flag (i2c-algo-bit, i2c-gpio, tegra,
brcmstb, pxa, bcm-kona) the read would return bus garbage as an ISC status
word, and i2c-bcm-iproc rejects it outright.  Two messages with no
NOSTART flag express the intended sequence; alternatively, should this
check i2c_check_functionality(adap, I2C_FUNC_NOSTART)?

[ ... ]

> +/* Acquire the shared I2C bus from the MicroBlaze firmware. */
> +static int adva_x1_mblaze_acquire(struct ptp_ocp *bp)
> +{
> +	u32 val;
> +	int i;
> +
> +	if (!bp->pps_select)
> +		return -ENODEV;
> +
> +	/* Release any stale grant left by a previous crashed caller. */
> +	iowrite32(0, &bp->pps_select->i2c_bus_ctrl);
> +	val = ioread32(&bp->pps_select->i2c_bus_ctrl);
> +	if (val != 0)
> +		return -EBUSY;

[Severity: Medium]
Can this -EBUSY check ever mean anything?  The register is overwritten with
0 before it is read, so the read only observes the value this function just
wrote, and a non-zero result means the MicroBlaze wrote something in
between rather than "bus busy".

Two consequences worth confirming:

The comment says the write clears a stale grant from a crashed caller, but
the code cannot distinguish that from a grant the MicroBlaze is currently
relying on, since it never inspects the register first.

Back-to-back reads of cpld_status/cpld_device_id can spuriously return
-EBUSY if the MicroBlaze has not yet consumed the MBLAZE_RELEASE written
by adva_x1_mblaze_release(), which is fire-and-forget with no
acknowledgement.

bp->cpld_lock only serialises the host side, so what provides exclusion
against the MicroBlaze in this window?

> +
> +	iowrite32(MBLAZE_REQUEST, &bp->pps_select->i2c_bus_ctrl);
> +	for (i = 0; i < MBLAZE_RETRIES; i++) {
> +		usleep_range(MBLAZE_RETRY_US, MBLAZE_RETRY_US + 1000);
> +		val = ioread32(&bp->pps_select->i2c_bus_ctrl);
> +		if (val == MBLAZE_GRANTED)
> +			return 0;
> +	}
> +	return -ETIMEDOUT;
> +}

[Severity: Medium]
Should the pending MBLAZE_REQUEST be withdrawn on this timeout path?  The
request stays in i2c_bus_ctrl when -ETIMEDOUT is returned, and none of the
three callers releases it:

cpld_device_id_show() and cpld_status_show():

	ret = adva_x1_mblaze_acquire(bp);
	if (ret)
		goto out;		/* skips the release: label */

adva_cpld_prepare():

	if (adva_x1_mblaze_acquire(bp)) {
		ret = FW_UPLOAD_ERR_TIMEOUT;
		goto err_unlock;	/* skips err_release */
	}

So adva_x1_mblaze_release() is never called and the MicroBlaze still sees a
host request after the host gave up.  If it later grants it, it believes the
host owns the segment while nothing on the host side will ever send
MBLAZE_RELEASE.  The only recovery is the unconditional iowrite32(0) at the
top of some later acquire, which writes 0 rather than MBLAZE_RELEASE and
depends on another CPLD operation being requested at all.

[ ... ]

> +static int adva_x1_cpld_wait_ready(struct ptp_ocp *bp, unsigned int max_ms)
> +{
> +	unsigned int elapsed = 0;
> +	u32 status;
> +
> +	while (elapsed < max_ms) {
> +		if (adva_x1_cpld_read_status(bp, &status))
> +			return -EIO;
> +		if (status & CPLD_STATUS_FAILED)
> +			return -EIO;
> +		if (!(status & CPLD_STATUS_BUSY))
> +			return 0;
> +		usleep_range(100000, 101000);
> +		elapsed += 100;
> +	}
> +	return -ETIMEDOUT;
> +}

[Severity: High]
Does this loop poll one time too few?  The sleep and the elapsed update are
the last statements of the iteration, so the status is never re-read after
the final sleep and the loop performs floor(max_ms / 100) reads.

With the 100 ms budget used per page in adva_cpld_write() that means
exactly one read:

	elapsed = 0
	adva_x1_cpld_read_status()	-> BUSY set
	usleep_range(100000, 101000)
	elapsed = 100
	while (elapsed < 100)		-> false
	return -ETIMEDOUT;

adva_cpld_write() turns that into FW_UPLOAD_ERR_HW_ERROR and
fw_upload_main() aborts the upload, but adva_cpld_prepare() has already run
CPLD_CMD_ERASE, so the configuration flash is left erased and only
partially programmed with DONE clear.  A page program that legitimately
asserts BUSY for tPROG at that single poll would fail on the very first
page.

The same off-by-one shortens the 5000/15000/1000/3000 ms budgets by one
poll, and elapsed does not account for the time spent in the I2C status
transaction itself.  Should the status be re-checked after the last sleep?

[Jakub] Please use standard iopoll.h helpers or gate the timeout on a
jiffies-based deadline, not just loop count. And check before return
like the AI suggests..

> +
> +/*
> + * cpld_device_id - show the Lattice device ID of the TAP CPLD.
> + *
> + * Returns the 32-bit ID as a hex string, e.g. "0x612bc043\n".
> + * Lattice LCMXO3LF-210 reports 0x612BC043.
> + */
> +static ssize_t
> +cpld_device_id_show(struct device *dev, struct device_attribute *attr,
> +		    char *buf)
> +{
> +	struct ptp_ocp *bp = dev_get_drvdata(dev);
> +	u8 data[4];
> +	u32 id = 0;
> +	int ret;
> +
> +	mutex_lock(&bp->cpld_lock);

[Severity: Medium]
Can this block uninterruptibly for the whole duration of an upload?
bp->cpld_lock is taken in adva_cpld_prepare() and only dropped in
adva_cpld_cleanup(), covering the 15000 ms erase wait, one page write plus
wait per 16 bytes of image, SET_DONE (1000 ms), msleep(1500) and the
3000 ms post-REFRESH wait.

Both show() functions use plain mutex_lock(), so a "cat
/sys/class/timecard/ocpN/cpld_status" sits in TASK_UNINTERRUPTIBLE and is
unkillable for that whole time, which can also trip the hung-task detector.
kernfs drains in-flight attribute readers, so that stuck reader also stalls
ptp_ocp_attr_group_del() and device removal.  Would
mutex_lock_interruptible(), or a trylock returning -EBUSY while an upload
is in progress, be preferable here?

[Jakub] you seem to be doing multiple things in one patch, please make this
a patch series and separate the FW flashing form the rest. 

[ ... ]

> +static DEVICE_ATTR_RO(cpld_device_id);

[Severity: Medium]
Should these two attributes be world readable?  DEVICE_ATTR_RO() gives mode
0444 for both cpld_device_id and cpld_status, and they are added
unconditionally to adva_timecard_x1_attrs[].  A read is not a passive
register access: it takes bp->cpld_lock, overwrites the shared
host/MicroBlaze arbitration register with iowrite32(0, ...) before checking
ownership, sleeps up to MBLAZE_RETRIES * ~10 ms (about 2.2 s) inside
adva_x1_mblaze_acquire() while holding the mutex, and reprograms the shared
PCA9548 (select channel 0, then deselect all channels).

So any local user can loop on cpld_status and repeatedly clobber the
arbitration state the card firmware relies on, change mux state other I2C
clients on the same adapter depend on, and block uninterruptibly for the
length of a root-initiated upload.  Would 0400/0440 be more appropriate?

[Jakub] why is this not reported in devlink info? If it's the SKU/device id
of the CPLD it should be a "fixed" version?
I'll stop reviewing now, rest of the AI comments sent without checking...

[ ... ]

> +static enum fw_upload_err
> +adva_cpld_prepare(struct fw_upload *fwl, const u8 *data, u32 size)
> +{

[ ... ]

> +	if (!size || size % CPLD_PAGE_SIZE)
> +		return FW_UPLOAD_ERR_INVALID_SIZE;
> +
> +	bp->cpld_cancel		= false;
> +	bp->cpld_in_config_mode	= false;
> +
> +	mutex_lock(&bp->cpld_lock);

[Severity: Medium]
Can this reset discard a cancel request that has already arrived?
fw_upload_start() sets progress = FW_UPLOAD_PROG_RECEIVING and queues the
work before dropping fwlp->lock, and cancel_store() /
firmware_upload_unregister() only refuse to call ops->cancel() when
progress == FW_UPLOAD_PROG_IDLE:

	cancel_store()/firmware_upload_unregister()
	    adva_cpld_cancel()
	        bp->cpld_cancel = true;

	worker
	    adva_cpld_prepare()
	        bp->cpld_cancel = false;	/* request lost */

In the unregister path that matters: firmware_upload_unregister() calls
cancel() and then flush_work(), so with the request lost, unbind/PCI remove
waits for the full erase (up to 15 s) plus every 16-byte page program.

Two related points: bp->cpld_cancel is a plain bool shared between the
worker and the cancelling task with no READ_ONCE/WRITE_ONCE, atomic or
lock, and it is written here outside bp->cpld_lock; and it is never checked
inside adva_x1_cpld_wait_ready(), so a cancel arriving during the 15 s
erase or a page wait is not observed at all.

[ ... ]

> +	if (adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP, en_args, 2) ||
> +	    adva_x1_cpld_wait_ready(bp, 5000)) {
> +		ret = FW_UPLOAD_ERR_HW_ERROR;
> +		goto err_deselect;
> +	}
> +	bp->cpld_in_config_mode = true;

[Severity: Medium]
Is the flag set too late here?  The short-circuit means
adva_x1_cpld_wait_ready() only runs when the EN_CFG_TP write already
succeeded, so on a wait failure (BUSY timeout, FAILED bit, or an I2C error
in the status read) the CPLD has accepted enable-configuration while
bp->cpld_in_config_mode is still false.

err_deselect is guarded by that flag:

	err_deselect:
		if (bp->cpld_in_config_mode) {
			adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG, dis_args, 2);

so CPLD_CMD_DIS_CFG is never sent, the mux is deselected, the bus is handed
back and the CPLD stays in ISC transparent configuration mode.
fw_upload_main() does not call cleanup() when prepare() fails, so there is
no second chance to send DIS_CFG, and the next upload attempt issues
EN_CFG_TP to an already-enabled device.

[ ... ]

> +static enum fw_upload_err
> +adva_cpld_write(struct fw_upload *fwl, const u8 *data,
> +		u32 offset, u32 size, u32 *written)
> +{

[ ... ]

> +	if (adva_x1_cpld_write(bp, CPLD_CMD_WRITE_PAGE,
> +			       page_args, 3 + CPLD_PAGE_SIZE) ||
> +	    adva_x1_cpld_wait_ready(bp, 100))
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +
> +	*written = CPLD_PAGE_SIZE;
> +	return FW_UPLOAD_ERR_NONE;
> +}
> +
> +static enum fw_upload_err
> +adva_cpld_poll_complete(struct fw_upload *fwl)
> +{

[ ... ]

> +	if (adva_x1_cpld_write(bp, CPLD_CMD_REFRESH, ref_args, 2))
> +		return FW_UPLOAD_ERR_HW_ERROR;
> +
> +	/* CPLD reboots after REFRESH; re-select mux once it comes back up */
> +	msleep(1500);
> +	adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
> +	if (adva_x1_cpld_wait_ready(bp, 3000))
> +		return FW_UPLOAD_ERR_TIMEOUT;
> +
> +	bp->cpld_in_config_mode = false;
> +	return FW_UPLOAD_ERR_NONE;
> +}

[Severity: Medium]
Can this report a failure for an update that actually succeeded?  The
adva_x1_mux_select() return value is discarded, so if the segment is not
responsive at exactly the 1500 ms mark the mux write is NAKed silently and
the following READ_STATUS goes to a bus with no channel enabled:

	adva_x1_cpld_wait_ready(bp, 3000)
	    adva_x1_cpld_read_status()	-> I2C error
	    return -EIO
	return FW_UPLOAD_ERR_TIMEOUT;

At that point DONE was already verified set and REFRESH was accepted, so
the new image is running, yet userspace sees a failed update and is likely
to erase and reprogram again.  Would a bounded retry of the post-reset mux
reselect help here?

Also, bp->cpld_in_config_mode is still true on this return path, so
adva_cpld_cleanup() then sends DIS_CFG to a device that already left
configuration mode.

[ ... ]

> @@ -4902,6 +5368,11 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>  		clk_hw_unregister_fixed_rate(bp->i2c_clk);
>  	if (bp->n_irqs)
>  		pci_free_irq_vectors(bp->pdev);
> +	if (bp->cpld_fw_upload) {
> +		firmware_upload_unregister(bp->cpld_fw_upload);
> +		bp->cpld_fw_upload = NULL;
> +	}
> +	mutex_destroy(&bp->cpld_lock);
>  	device_unregister(&bp->dev);
>  }

[Severity: Low]
This isn't a use-after-free: platform_device_unregister(bp->i2c_ctrl) ->
xiic_i2c_remove() -> i2c_del_adapter() does

	init_completion(&adap->dev_released);
	device_unregister(&adap->dev);
	wait_for_completion(&adap->dev_released);

so the adapter cannot go away while adva_x1_i2c_xfer() holds the
i2c_get_adapter() reference, and later lookups just return NULL so the
helper returns -ENODEV.

Would it still be cleaner to move firmware_upload_unregister() above
platform_device_unregister(bp->i2c_ctrl) and pci_free_irq_vectors()?  As
written, an in-flight upload aborts mid-programming with -ENODEV instead of
being cancelled and flushed first, and i2c_del_adapter() blocks for the
duration of whatever transfer is in flight.

>  
> @@ -5217,11 +5699,16 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
>  
>  found:
>  	bp = dev_get_drvdata(dev);
> -	if (add)
> +	if (add) {
>  		ptp_ocp_symlink(bp, child, "i2c");
> -	else
> +		/* Cache adapter nr; used by cpld_device_id/cpld_status/cpld_program
> +		 * for reference-counted unbind-safe adapter access.
> +		 */

[Severity: Low]
What is cpld_program?  adva_timecard_x1_attrs[] only gains
&dev_attr_cpld_device_id.attr and &dev_attr_cpld_status.attr, and
programming goes through the fw_upload_ops callbacks, so no such attribute
or function exists in the tree.  Looks like a leftover from an earlier
revision.

> +		WRITE_ONCE(bp->cpld_i2c_adap_nr, i2c_verify_adapter(child)->nr);
> +	} else {
> +		WRITE_ONCE(bp->cpld_i2c_adap_nr, -1); /* invalidate before free */
>  		sysfs_remove_link(&bp->dev.kobj, "i2c");
> -
> +	}
>  	return 0;
>  }
