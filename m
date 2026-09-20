Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC073859C3;
	Sun, 20 Sep 2026 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789916484; cv=none; b=h+kPb3gNkc2EYzk5NVPz6NlCtDyoeZx8AOouEtl5GVbJBPmmUuW9r4YpYIXED2UmdMILYCsy556Jm3gtlXf13Z1JJfWsrMWhKY5ZHNmaLzeIBG5lkVs+B+aDJBTINYH4EXVqfcPx8RNd5cxr4Ae2yN91HfOEZvY52VjHDkAc554=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789916484; c=relaxed/simple;
	bh=n3YL/iM9+Gmc1Qa2fbUI8Km6zVeFd6tc6Mo0EX0Yo3o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QpiYRilbYb0ZIKEsUJiHsARC4KfTbndiY69VJf2nKnrBSuV4o6P6G+md6GZK4WB5AUlEvq1gi35snqg54pR+TK1bfrs1hk7cCpmsSkEZ9ijquUbA+bw/vqtG9gKvDQOjwWrVM8vt+g+P5VYgOv1htRHZQrNi83BhRqil6n21KdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFetdDqZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFetdDqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03F21F000FF;
	Sun, 20 Sep 2026 15:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789916482;
	bh=NDegZ5HMiYkgEu/feOwuz5djh+po2Ql2JdgM9ZKDax8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IFetdDqZdPlytYzbOXjSIPTVumSCC3M1T07kEEClKGh86FcWuvaBg8/OZfdQMy9iW
	 bqG03zN+NETw/r78VcZ6nmMBC7eClRij/qu/cJ+CEqx6AGm7pvl5VRepbCGUCW9yrR
	 i444Nn3tG2MG7TSl0o0XPVkOluyYcQT5phPJPvbk52xNMz6TTwq9cRdaZrU0seKSTH
	 rsf1o6Lzz8Up9wRhPPm79CmOSV2xnzKcI0G/j+klpYBXkhDkELtT2spj38Undx3Tw5
	 vMiN5V8mix0MKqyA0aY5ETluHtb0Syt5ZH64/hspKgy6NOm8mYjhi9ugggg+ULHIN4
	 coITblYsVciNA==
Subject: Re: [PATCH net-next v15 3/4] ptp: ocp: add TAP CPLD access for ADVA
 TimeCard X1
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 15:01:21 +0000
Message-ID: <178991648135.2160803.1131127618501750446@kernel.org>
In-Reply-To: <20260916153242.157171-4-sagi.maimon@adtran.com>
References: <20260916153242.157171-4-sagi.maimon@adtran.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] adva_x1_bus_release() drops the i2c root-adapter lock and
  forgets the claim even when adva_x1_mblaze_release() returned…
- [Medium] The one-shot CPLD ID read is executed from
  ptp_ocp_sync_work(), the driver's 1 Hz in-sync status poller.
- [Low] On an acquire timeout the MicroBlaze hand-back handshake is
  executed twice: adva_x1_mblaze_acquire() already writes MBLAZE_RELEASE…
- [Low] adva_x1_bus_claim() returns -ENODEV when i2c_get_adapter() finds
  nothing for the cached number, without clearing bp->cpld_i2c_adap_nr.
- [Low] The new struct ptp_ocp member comments overstate the locking:
  cpld_i2c_adap_nr is documented as 'Under cpld_adap_lock' and…

--

ptp: ocp: add TAP CPLD access for ADVA TimeCard X1

This adds a request/grant handshake that re-routes the registered x1 I2C
controller from the config EEPROMs onto the TMC bus, so the PCA9548 and the
Lattice CPLD behind its channel 0 can be reached.  On top of that it adds a
root-only cpld_status attribute and reports the Lattice device ID as the
fixed devlink version cpld.id, read once from the driver's sync worker.

A few questions about the new arbitration and its bookkeeping below.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index f4299878c27ce..998ea9c6b3817 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -416,6 +421,25 @@ struct ptp_ocp {
>  	dpll_tracker tracker;
>  	int signals_nr;
>  	int freq_in_nr;
> +	/* adva_x1 CPLD I2C (internal use only) */
> +	/* serialises CPLD operations */
> +	struct mutex		cpld_lock;
> +	/* guards cpld_i2c_adap_nr against the bus notifier */
> +	spinlock_t		cpld_adap_lock;
> +	/* I2C adapter nr; -1 if absent.  Under cpld_adap_lock */
> +	int			cpld_i2c_adap_nr;

[Severity: Low]
This isn't a bug, but do these member comments match the code?  The field
is documented as "Under cpld_adap_lock", yet all three readers take no
lock:

	adva_x1_cache_i2c_adap()
		if (!bp->has_cpld || !bp->i2c_ctrl ||
		    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)

	adva_x1_bus_claim()
		adap = i2c_get_adapter(READ_ONCE(bp->cpld_i2c_adap_nr));

	ptp_ocp_sync_work()
		if (bp->has_cpld && !READ_ONCE(bp->cpld_id_tried) &&
		    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)

The same applies to cpld_id_tried, documented as "under cpld_lock" and read
lockless in ptp_ocp_sync_work().  Would it be clearer to describe the
actual design, that writes are serialised while readers may observe a stale
value and re-validate it on the parent check?

> +	/* claimed adapter; valid under cpld_lock */
> +	struct i2c_adapter	*cpld_adap;
> +	/* scratch, write half then read half; valid under cpld_lock */
> +	u8			*cpld_buf;
> +	/* Lattice device ID; 0 if unread */
> +	u32			cpld_id;
> +	/* one-shot ID read finished, successfully or not; under cpld_lock */
> +	bool			cpld_id_tried;
> +	/* failed ID read attempts so far; under cpld_lock */
> +	unsigned int		cpld_id_attempts;
> +	/* x1 TAP CPLD present */
> +	bool			has_cpld;
>  };

[ ... ]

> @@ -4226,6 +4266,434 @@ static const struct ocp_attr_group art_timecard_groups[] = {

[ ... ]

> +/* Hand the segment back, and wait for the firmware to drop the grant before
> + * the caller unlocks the adapter: a transfer queued behind us would
> + * otherwise be clocked out while the controller is still on the TMC bus,
> + * which is what holding the adapter lock across the grant exists to stop.
> + */
> +static int adva_x1_mblaze_release(struct ptp_ocp *bp)
> +{
> +	u32 val = 0;
> +	int i;
> +
> +	if (!bp->pps_select)
> +		return 0;
> +
> +	iowrite32(MBLAZE_RELEASE, &bp->pps_select->i2c_bus_ctrl);
> +	/* Flush the posted write, as the acquire path does. */
> +	ioread32(&bp->pps_select->i2c_bus_ctrl);
> +
> +	for (i = 0; i < MBLAZE_RETRIES; i++) {
> +		val = ioread32(&bp->pps_select->i2c_bus_ctrl);
> +		if ((val & MBLAZE_GRANT_MASK) != MBLAZE_GRANT)
> +			return 0;
> +		usleep_range(MBLAZE_RETRY_US, MBLAZE_RETRY_US + 1000);
> +	}
> +
> +	dev_err(&bp->pdev->dev,
> +		"TMC bus still granted after release, i2c_bus_ctrl 0x%08x\n",
> +		val);
> +
> +	return -ETIMEDOUT;
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
> +	/* Drop the request we gave up on.  Any error from the hand-back is
> +	 * subsumed by the -ETIMEDOUT we are already returning.
> +	 */
> +	adva_x1_mblaze_release(bp);
> +	return -ETIMEDOUT;
> +}

[Severity: Low]
Is the hand-back run twice for a single failed acquire?  This path already
writes MBLAZE_RELEASE and runs the full poll loop, and then
adva_x1_bus_claim() calls it again for the same error:

	ret = adva_x1_mblaze_acquire(bp);
	if (ret)
		adva_x1_bus_release(bp);	/* keeps the acquire error */

Both run with the i2c root-adapter lock held, and each loop is
MBLAZE_RETRIES x MBLAZE_RETRY_US, so when the firmware keeps the grant
asserted a single failed claim can hold the shared adapter lock for roughly
half again as long and log "TMC bus still granted after release" twice.
Is one of the two hand-backs superfluous?

> +
> +/* Route the host controller back to the EEPROMs and release the adapter.
> + * Safe after a failed claim: it also clears a request that was never granted.
> + *
> + * The adapter is unlocked even when the hand-back timed out: keeping the
> + * root lock would stall every other user of the controller for good, with
> + * no way to recover it.  The error is returned instead, so the operation
> + * that held the claim fails rather than reporting success over a bus that
> + * may still be routed to the TMC segment.
> + */
> +static int adva_x1_bus_release(struct ptp_ocp *bp)
> +{
> +	struct i2c_adapter *adap = bp->cpld_adap;
> +	int err;
> +
> +	if (!adap)
> +		return 0;
> +
> +	err = adva_x1_mblaze_release(bp);
> +	bp->cpld_adap = NULL;
> +	kfree(bp->cpld_buf);
> +	bp->cpld_buf = NULL;
> +	i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER);
> +	i2c_put_adapter(adap);
> +
> +	return err;
> +}

[Severity: High]
Can this leave the shared controller routed to the TMC segment with nothing
holding later users off it?

When adva_x1_mblaze_release() returns -ETIMEDOUT the grant field still
reads MBLAZE_GRANT, so the firmware has not taken the segment back.  This
function nevertheless drops the claim and unlocks unconditionally.  For a
plain (non-mux) adapter both lock levels are the same rt_mutex:

drivers/i2c/i2c-core-base.c
	static void i2c_adapter_unlock_bus(struct i2c_adapter *adapter,
					   unsigned int flags)
	{
		rt_mutex_unlock(&adapter->bus_lock);
	}

so every waiter resumes immediately, and only the errno reaches the CPLD
operation that held the claim.  Nothing latches the "routing unknown"
state, re-drives the hand-back, or gates the next transfer.

The commit message says a transfer issued in that window "would be issued
onto the TMC bus instead of to the EEPROM".  ptp_ocp_read_eeprom() then
caches whatever came back with no validation:

		ret = nvmem_device_read(nvmem, map->off, map->len,
					BP_MAP_ENTRY_ADDR(bp, map));
		if (ret != map->len)
			goto fail;
	}

	bp->has_eeprom_data = true;

and that becomes bp->serial / bp->board_id, republished over the
unprivileged DEVLINK_CMD_INFO_GET path.  An nvmem or at24 write in the same
window would be delivered to whatever answers 0x50/0x58 on the TMC bus.

The comment argues that keeping the lock forever is worse, which is fair,
but should a sticky flag (or a retried hand-back) fence later transfers
until the grant is confirmed dropped, instead of only returning the errno
to the CPLD caller?

[ ... ]

> +/*
> + * Claim the TMC bus.  The adapter lock is held across the handshake to keep
> + * the EEPROM, nvmem and at24 paths off the controller while it is routed
> + * away from the EEPROMs; an EEPROM read blocks until the claim is dropped.
> + */
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

[Severity: Low]
Should this path also forget the cached number?  When the lookup fails,
bp->cpld_i2c_adap_nr stays >= 0, so adva_x1_cache_i2c_adap() bails out at
its first test and never re-resolves the adapter, while every
ptp_ocp_sync_work() tick burns one retry until cpld_id_tried is set for
good in adva_x1_cpld_read_id():

	if (!ret || ++bp->cpld_id_attempts >= CPLD_ID_MAX_ATTEMPTS)
		bp->cpld_id_tried = true;

A stale number can be published in the first place because
adva_x1_cache_i2c_adap() only re-tests cpld_i2c_adap_nr < 0 after
device_find_child() has returned, so a delete notification for that adapter
in the same window still ends up cached.

And a re-added adapter updates the number but resets neither flag:

		if (bp->i2c_ctrl && adap->dev.parent == &bp->i2c_ctrl->dev) {
			scoped_guard(spinlock, &bp->cpld_adap_lock)
				bp->cpld_i2c_adap_nr = adap->nr;
		}

so cpld.id is then absent for the lifetime of the binding.  The comment
above the parent check below states that a bad number is rejected "on the
parent check and forgets it, and the next tick looks again" - does that hold
when i2c_get_adapter() returns NULL rather than a mismatched adapter?

> +
> +	/* The number is freed before the notifier clears it, so it can
> +	 * already be another adapter's.  Check this is still ours, and drop
> +	 * a number that is not: otherwise every later claim fails the same
> +	 * way, where forgetting it lets the worker look the adapter up again.
> +	 */
> +	if (!bp->i2c_ctrl || adap->dev.parent != &bp->i2c_ctrl->dev) {
> +		scoped_guard(spinlock, &bp->cpld_adap_lock) {
> +			if (bp->cpld_i2c_adap_nr == adap->nr)
> +				bp->cpld_i2c_adap_nr = -1;
> +		}
> +		i2c_put_adapter(adap);
> +		return -ENODEV;
> +	}

[ ... ]

> @@ -5052,6 +5522,17 @@ ptp_ocp_sync_work(struct work_struct *work)
>  
>  	bp->sync = sync;
>  
> +	/* Resolve the adapter here rather than once in probe, where it can
> +	 * race the adapter's own registration, and read the ID as soon as it
> +	 * turns up.  A claim can fail transiently - the firmware may not
> +	 * grant the segment straight after power-up - so adva_x1_cpld_read_id()
> +	 * retries a bounded number of times before giving up.
> +	 */
> +	adva_x1_cache_i2c_adap(bp);
> +	if (bp->has_cpld && !READ_ONCE(bp->cpld_id_tried) &&
> +	    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)
> +		adva_x1_cpld_read_id(bp);
> +
>  	queue_delayed_work(system_power_efficient_wq, &bp->sync_work, HZ);
>  }

[Severity: Medium]
Is the 1 Hz sync poller the right place for a claim that can block for
seconds?  adva_x1_mblaze_acquire() sleeps MBLAZE_RETRIES x MBLAZE_RETRY_US
(200 x 10 ms), and on the timeout path the hand-back poll loop runs too, so
one failed attempt can occupy this work item for several seconds, repeated
once per tick until CPLD_ID_MAX_ATTEMPTS is reached.

Does that delay the bp->sync update and the dpll change notification by the
same amount?  ptp_ocp_remove() and .shutdown start with
cancel_delayed_work_sync(&bp->sync_work), so unbind and reboot would block
for the duration as well.

Once cpld_id_attempts reaches 10, cpld_id_tried stays set for the lifetime
of the binding and cpld.id is silently absent, with both new interfaces
read-only and no way to retrigger the read.  Would it be worth mentioning
these effects in the commit message, or moving the read to its own work
item?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916153242.157171-1-sagi.maimon%40adtran.com
