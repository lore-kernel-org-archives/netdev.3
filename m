Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDB46D2AC;
	Wed, 16 Sep 2026 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546579; cv=none; b=upnQ16atGbpr/5rP1fPe50lOjslbuAmxJG1ZHnVJZpOmuUQHB97tZYB5aOrRF4vkW/fAD8Jv8Y2n8sOgtLLwfkDCjWwegsYqLZZDA+j1krrhbwQBuwf3wCAEbcGAVofsbameW2sayp6jFIkQfKftJE1ndHc95uXXLCyoRTBCduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546579; c=relaxed/simple;
	bh=9C+buMh1A2W5iJhEdAOkVTtarTzV6swX+ZZ+4AJDYdc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OhInaiphvEe4vWDwHIH2BFziJyJaO4y8LY6R4K5kWX2Gr2fUDJdYsKANoIao7Ay9422Jn2rIciFLdBPwOwAbyiCFS1MTxH6yo6joAvV8a3+TrORbsaZ18bwCX6cltkl2W2WijrstG8/K+E4pPP8SicC+i303PSwLfdGnZHKVW8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUksON9U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUksON9U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151C01F000FF;
	Wed, 16 Sep 2026 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789546559;
	bh=/Od+57+k43rHq4QfblUn+Osm9v5McaPdc0Y+ZbjieiY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UUksON9U54KGeBXCq7/jkhOHmWh8rtu8UIXdZzHGstn1XaJgBcTzVDvxOIAnrTIrt
	 OOg3KKNqmCbFUFo6YuvROI+Y9iLsvuKXccJd8DQwCj3NpTWq0VGhuzTjvOyNE0XWFQ
	 0OaAerP3V6vSiZtoFXuX2SOUOTblQLG/QEGxQ5OrgYqRx5gQozEZuduGhYrTrX+RAL
	 2KWBRpFY9fgkk9zg9kc2DobLZoXMw5q02BGMaPOpWmbPwzle/7wZyWXnzxJ4kJuzCn
	 bW5JPfpq4kW7nlycCHD365x2xTvOpYUYY2+7Wlch0CoJjXqGxMiX4cX/V+4yPIGJaB
	 DovAkOFLEJghg==
Subject: Re: [PATCH net-next v14 3/4] ptp: ocp: add TAP CPLD access for ADVA
 TimeCard X1
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 08:15:57 +0000
Message-ID: <178954655751.22033.1449062072421212704@kernel.org>
In-Reply-To: <20260914071531.11640-4-maimon.sagi@gmail.com>
References: <20260914071531.11640-4-maimon.sagi@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 3 · Low: 2

- [Medium] adva_x1_mblaze_release() (drivers/ptp/ptp_ocp.c:4375-4393)
  detects that the MicroBlaze firmware never dropped the grant, but only…
- [Medium] adva_x1_mblaze_release() (drivers/ptp/ptp_ocp.c:4382-4390)
  writes MBLAZE_RELEASE (0x55550000) to pps_select->i2c_bus_ctrl and…
- [Medium] bp->cpld_i2c_adap_nr has two unsynchronized writers -
  ptp_ocp_i2c_notifier_call() (drivers/ptp/ptp_ocp.c:5981-5986) and…
- [Low] This commit adds #include <linux/iopoll.h>
  (drivers/ptp/ptp_ocp.c:23) and #include <linux/firmware.h> (line 30),…
- [Low] In both adva_x1_cpld_read_id() and cpld_status_show(), a failure
  of adva_x1_mux_select(bp, ADVA_MUX_CHANNEL) takes 'goto release',…

--

ptp: ocp: add TAP CPLD access for ADVA TimeCard X1

This adds a request/grant handshake with the on-card MicroBlaze firmware so
the host I2C controller can be re-routed onto the TMC bus, where the PCA9548
and the Lattice TAP CPLD live.  On top of that it adds a root-only
cpld_status sysfs attribute and reports the Lattice device ID as the fixed
devlink version cpld.id, read once from the driver's own worker.

A few questions on the arbitration and on the adapter-number caching below.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index f4299878c27c..98cb26077181 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -20,10 +20,14 @@
>  #include <linux/spi/altera.h>
>  #include <net/devlink.h>
>  #include <linux/i2c.h>
> +#include <linux/iopoll.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/nvmem-consumer.h>
>  #include <linux/crc16.h>
>  #include <linux/dpll.h>
> +#include <linux/unaligned.h>
> +#include <linux/delay.h>
> +#include <linux/firmware.h>

[Severity: Low]
This isn't a bug, but is linux/iopoll.h used by anything in this commit?
There is no read_poll_timeout() or readx_poll_timeout() caller here; the
first one, adva_x1_cpld_wait_idle(), arrives with the next patch in the
series.

The same applies to the comments in adva_x1_i2c_xfer() and
adva_x1_bus_claim() that justify the per-claim scratch buffer with an image
upload:

	/* One scratch buffer per claim rather than per transfer: an upload
	 * holds the claim for the whole image.
	 */

There is no upload path in this patch either.  Would it be tidier to move
the include (and possibly those sentences) to the patch that introduces the
flashing code?

[ ... ]

> @@ -4226,6 +4266,367 @@ static const struct ocp_attr_group art_timecard_groups[] = {
>  	{ },
>  };
>  
> +/*
> + * adva_x1 TAP CPLD (Lattice LCMXO3LF-2100) helpers.
> + *
> + * The card has two I2C controllers; Linux registers only 0x00150000.
> + * The i2c_bus_ctrl handshake re-routes what each is wired to:
> + *
> + *   grant 0:  0x150000 -> EEPROMs     0x120000 -> TMC or M.2, MB's choice
> + *   grant 1:  0x150000 -> TMC bus     0x120000 -> M.2
> + *
> + * The PCA9548 at 0x74 and the CPLD at 0x40 behind its channel 0 are on the
> + * TMC bus, reachable only while the grant is held.  The EEPROMs are not
> + * behind the adapter for that window, so a CPLD operation holds cpld_lock
> + * and the adapter lock to keep the EEPROM and nvmem paths off it.
> + */
> +
> +#define ADVA_MUX_ADDR     0x74
> +#define ADVA_CPLD_ADDR    0x40
> +#define ADVA_MUX_CHANNEL  0
> +
> +/* Longest command or reply; bounds each half of the per-claim scratch. */
> +#define ADVA_CPLD_XFER_MAX 32
> +
> +#define MBLAZE_REQUEST    0x0000aaaaU
> +#define MBLAZE_GRANTED    0x5555aaaaU
> +#define MBLAZE_RELEASE    0x55550000U
> +#define MBLAZE_RETRIES    200
> +#define MBLAZE_RETRY_US   10000

[ ... ]

> +/* Hand the segment back, and wait for the firmware to drop the grant before
> + * the caller unlocks the adapter: a transfer queued behind us would
> + * otherwise be clocked out while the controller is still on the TMC bus,
> + * which is what holding the adapter lock across the grant exists to stop.
> + */
> +static void adva_x1_mblaze_release(struct ptp_ocp *bp)
> +{
> +	int i;
> +
> +	if (!bp->pps_select)
> +		return;
> +
> +	iowrite32(MBLAZE_RELEASE, &bp->pps_select->i2c_bus_ctrl);
> +	/* Flush the posted write, as the acquire path does. */
> +	ioread32(&bp->pps_select->i2c_bus_ctrl);
> +
> +	for (i = 0; i < MBLAZE_RETRIES; i++) {
> +		if (ioread32(&bp->pps_select->i2c_bus_ctrl) != MBLAZE_GRANTED)
> +			return;
> +		usleep_range(MBLAZE_RETRY_US, MBLAZE_RETRY_US + 1000);
> +	}

[Severity: Medium]
Can this loop ever iterate more than once?

The three magic values look like a host-owned low half (0xaaaa = request) and
a firmware-owned high half (0x5555 = grant):

	MBLAZE_REQUEST    0x0000aaaa
	MBLAZE_GRANTED    0x5555aaaa
	MBLAZE_RELEASE    0x55550000

adva_x1_mblaze_acquire() writes 0x0000aaaa and waits for the composite
0x5555aaaa, so the value read back includes the request bits the host itself
wrote.

If the readback here behaves the same way, then writing 0x55550000 clears the
low half, the very first ioread32() returns something other than 0x5555aaaa,
and adva_x1_mblaze_release() returns straight away - even while the firmware
still has the controller wired to the TMC bus.  The dev_warn() below would
then be unreachable.

Should the predicate look only at the firmware-owned field, for example
waiting for (val & 0xffff0000) == 0, rather than comparing against a value
that contains the host's own request bits?

Or is i2c_bus_ctrl a write-only mailbox whose readback returns firmware state
alone?  If so it would be worth saying that in the comment, since the
guarantee stated in the changelog ("The hand-back waits for the firmware to
drop the grant before the adapter lock is released") rests entirely on this
loop.

> +
> +	dev_warn(&bp->pdev->dev, "TMC bus still granted after release\n");
> +}

[ ... ]

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
When the hand-back times out, adva_x1_mblaze_release() only logs "TMC bus
still granted after release" and returns void, so adva_x1_bus_release() has
no way to learn about it and drops i2c_unlock_bus() / i2c_put_adapter()
anyway.

What happens to the next transfer on that adapter if the controller is still
routed to the TMC segment?  ptp_ocp_read_eeprom() is reachable from the
unprivileged DEVLINK_CMD_INFO_GET path:

	if (!bp->has_eeprom_data) {
		ptp_ocp_read_eeprom(bp);

and also from serialnum_show() and the at24 / nvmem sysfs files.  Since an
at24 read starts with an address-byte write to 0x50 or 0x58, this would not
just return TMC data as EEPROM content but also clock writes at whatever sits
at those addresses on the TMC segment.

Would it make sense for adva_x1_mblaze_release() to return an error and for
adva_x1_bus_release() to keep the adapter locked (or otherwise stop using it)
when the grant was never dropped?

[ ... ]

> +/*
> + * Cache the adapter the CPLD hangs off.  ptp_ocp_i2c_notifier_call() misses
> + * it when the i2c controller driver is already loaded: the adapter is then
> + * added from inside platform_device_register(), before bp->i2c_ctrl is set.
> + * Only direct children are searched, so a mux adapter cannot match.
> + */
> +static void adva_x1_cache_i2c_adap(struct ptp_ocp *bp)
> +{
> +	struct device *child;
> +
> +	if (!bp->has_cpld || !bp->i2c_ctrl ||
> +	    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)
> +		return;
> +
> +	child = device_find_child(&bp->i2c_ctrl->dev, NULL,
> +				  adva_x1_i2c_adap_match);
> +	if (!child)
> +		return;
> +
> +	WRITE_ONCE(bp->cpld_i2c_adap_nr, i2c_verify_adapter(child)->nr);
> +	put_device(child);
> +}

[Severity: Medium]
bp->cpld_i2c_adap_nr now has two unlocked writers doing check-then-act:
this function from probe, and ptp_ocp_i2c_notifier_call().  Can both miss?

device_add() emits the notification before linking the device to its parent:

drivers/base/core.c:device_add() {
	...
	bus_notify(dev, BUS_NOTIFY_ADD_DEVICE);
	...
	if (parent)
		klist_add_tail(&dev->p->knode_parent,
			       &parent->p->klist_children);
	...
}

and bp->i2c_ctrl is only assigned after platform_device_register() returns.
So if the adapter's device_add() is in flight on another thread
(asynchronous probing via driver_async_probe= or the modprobe async_probe
parameter), the notifier skips its store because bp->i2c_ctrl is still NULL,
while device_find_child(&bp->i2c_ctrl->dev, ...) here does not see the
not-yet-linked adapter.

Nothing re-runs adva_x1_cache_i2c_adap(), and ptp_ocp_sync_work() gates on

	READ_ONCE(bp->cpld_i2c_adap_nr) >= 0

so cpld_i2c_adap_nr would stay -1 for the lifetime of the device: cpld.id
never reported, cpld_status returning -ENODEV.

The reverse interleaving looks possible too - this function publishing a
number after a BUS_NOTIFY_DEL_DEVICE has already set it to -1 - in which case
the stale number makes adva_x1_bus_claim() fail its parent re-check ten times
and latch cpld_id_tried.

READ_ONCE()/WRITE_ONCE() stop tearing but do not make the test and the store
atomic here.  Would serializing both writers under cpld_lock, or retrying the
lookup from the worker instead of only once at probe, close this?

> +
> +/*
> + * Claim the TMC bus.  The adapter lock is held across the handshake to keep
> + * the EEPROM, nvmem and at24 paths off the controller while it is routed
> + * away from the EEPROMs; an EEPROM read blocks until the claim is dropped.
> + */
> +static int adva_x1_bus_claim(struct ptp_ocp *bp)

[ ... ]

> +/* Select a mux channel, or deselect all with ch < 0 - the power-on state.
> + * The mux is on the TMC bus, so what it is left set to never affects the
> + * EEPROM paths.
> + */
> +static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
> +{
> +	u8 val = (ch >= 0) ? BIT(ch) : 0;
> +
> +	return adva_x1_i2c_xfer(bp, ADVA_MUX_ADDR, val, NULL, 0, NULL, 0);
> +}

[ ... ]

> +static int adva_x1_cpld_read_id(struct ptp_ocp *bp)
> +{
> +	u8 data[4];
> +	int ret;
> +
> +	if (!mutex_trylock(&bp->cpld_lock))
> +		return -EBUSY;
> +
> +	ret = adva_x1_bus_claim(bp);
> +	if (ret)
> +		goto out;
> +	ret = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
> +	if (ret)
> +		goto release;
> +	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_ID, data, 4);
> +	if (!ret)
> +		WRITE_ONCE(bp->cpld_id, get_unaligned_be32(data));
> +	adva_x1_mux_select(bp, -1);
> +release:
> +	adva_x1_bus_release(bp);

[Severity: Low]
When adva_x1_mux_select(bp, ADVA_MUX_CHANNEL) fails, the goto release jumps
past the matching adva_x1_mux_select(bp, -1), so the PCA9548 at 0x74 is
handed back to the MicroBlaze with channel 0 possibly still enabled.  An I2C
transfer can be reported as failed after the mux control byte was already
acknowledged (controller timeout or arbitration handling), so a non-zero
return does not prove the register was not written.

The comment on adva_x1_mux_select() describes deselect-all as the state the
driver restores, so should the select-failure path deselect as well?

On the success path the return value of adva_x1_mux_select(bp, -1) is
discarded, so a failed deselect also leaves channel 0 open with no
indication.  cpld_status_show() has the same two paths.

> +out:
> +	mutex_unlock(&bp->cpld_lock);
> +	if (ret)
> +		dev_dbg(&bp->pdev->dev,
> +			"CPLD device ID unavailable: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +/* cpld_status - show the flags set in the TAP CPLD status register. */
> +static ssize_t
> +cpld_status_show(struct device *dev, struct device_attribute *attr,
> +		 char *buf)
> +{

[ ... ]

> +	ret = adva_x1_bus_claim(bp);
> +	if (ret)
> +		goto out;
> +	ret = adva_x1_mux_select(bp, ADVA_MUX_CHANNEL);
> +	if (ret)
> +		goto release;
> +	ret = adva_x1_cpld_read_status(bp, &st);
> +	adva_x1_mux_select(bp, -1);
> +release:
> +	adva_x1_bus_release(bp);

[ ... ]

> @@ -5052,6 +5455,20 @@ ptp_ocp_sync_work(struct work_struct *work)
>  
>  	bp->sync = sync;
>  
> +	/* The adapter can appear after probe, so read the ID from here once
> +	 * it has.  A claim can fail transiently - the firmware may not grant
> +	 * the segment straight after power-up - so retry a bounded number of
> +	 * times.  -EBUSY means cpld_lock is held and does not count.
> +	 */
> +	if (bp->has_cpld && !READ_ONCE(bp->cpld_id_tried) &&
> +	    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0) {
> +		int err = adva_x1_cpld_read_id(bp);
> +
> +		if (err != -EBUSY &&
> +		    (!err || ++bp->cpld_id_attempts >= CPLD_ID_MAX_ATTEMPTS))
> +			WRITE_ONCE(bp->cpld_id_tried, true);
> +	}
> +
>  	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
>  }

[ ... ]

> @@ -5227,11 +5656,21 @@ ptp_ocp_i2c_notifier_call(struct notifier_block *nb,
>  
>  found:
>  	bp = dev_get_drvdata(dev);
> -	if (add)
> +	adap = i2c_verify_adapter(child);
> +	if (add) {
>  		ptp_ocp_symlink(bp, child, "i2c");
> -	else
> +		/* Only the card's own controller: a mux child added on it
> +		 * reaches ptp_ocp through the same walk.  Numbers are
> +		 * recycled, so the claim re-checks the parent itself.
> +		 */
> +		if (bp->i2c_ctrl && adap->dev.parent == &bp->i2c_ctrl->dev)
> +			WRITE_ONCE(bp->cpld_i2c_adap_nr, adap->nr);
> +	} else {
> +		/* invalidate before free, but only for the cached adapter */
> +		if (READ_ONCE(bp->cpld_i2c_adap_nr) == adap->nr)
> +			WRITE_ONCE(bp->cpld_i2c_adap_nr, -1);
>  		sysfs_remove_link(&bp->dev.kobj, "i2c");
> -
> +	}
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914071531.11640-1-maimon.sagi%40gmail.com
