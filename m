Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA61A3C3C19;
	Thu, 24 Sep 2026 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260173; cv=none; b=KQELH+yn0cHTM5yHyIculPi8nchuXMNOqfh/j6pVdznCXXNFu/kenUeLvkeaTbwE18iK287gAPABWsbG3ElSKpAGjoNYRnuYfBJF37sra3JkcLiMV1Dh+PUn2SPNmMk/GGHwk37W/I3HjTC3qnBCejwJEltvdpGfBvGueR+FHPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260173; c=relaxed/simple;
	bh=M/eVI3GT2Qx3mwyqSrlBVBqTfy5pDdgY+b+W/osSVEw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bOvetR/0WU8G40uTGAhLSkCQh8LOaikC4hGbdUb6CStg4W1nLFbLD9XdI8hMu4ks6V/a9lO+VCdt7toZqx8yT+Og2l18bX4+J61is4tnxm+DTVm72jpn1AyYWIs/NgRRqw63jbmsKqMm1QXhqoQmGbBfhdBQRBvXtMHX8ssQzls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAH2OUua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAH2OUua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83861F000FF;
	Thu, 24 Sep 2026 14:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260165;
	bh=IJSSFJHh2/h+tOxCzY/0ZdCc/J3X1Gp4H97GJOMbqw0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZAH2OUuafN8GwTc2Rmhr6y3B4PluSDF6UPunw1OZ3JvlZeryoTABZHvCxttR/0TN0
	 7YwiT6AKF1wwwWAzKK0v1a6eEF0Rf/+doHV9oDbBykJwKuziT/sbuxRJe4mIbyfSpq
	 wxbKB8c5lBOH3D5CfEQHeA4aSX/PTRpWaB164wNVmkjtMPmFakYGtAZ7m5SMkuIrgy
	 HJ2UhP+qtTx8zgBVeY75tuuf8e1yq9HO4eJpaRBcKZbOzZcSGQucEdIuYPR+hbYm8u
	 2wl199hbMI2v/L3UEblNp6AfA8HHr0IMBRH8E9wnYsy00ofMXdx037siBQLP1ZwI+8
	 GFXvHkSwFicAQ==
Subject: Re: [PATCH net-next 2/9] ptp: ocp: do not cache EEPROM content after
 a failed TMC bus hand-back
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 14:29:24 +0000
Message-ID: <179026016433.2160803.12377107504343292644@kernel.org>
In-Reply-To: <20260922142829.57740-3-maimon.sagi@gmail.com>
References: <20260922142829.57740-3-maimon.sagi@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] TOCTOU: the new `cpld_bus_stuck` gate in `ptp_ocp_read_eeprom()`
  (drivers/ptp/ptp_ocp.c:2033) is a single snapshot taken before any I2C…
- [Medium] `cpld_bus_stuck` is latched on a single hand-back timeout
  (drivers/ptp/ptp_ocp.c:4555) and is cleared in exactly one place:…
- [Medium] The two driver-owned publishers of the cached EEPROM identity
  now disagree about the new "read refused" outcome, and the patch…

--

ptp: ocp: do not cache EEPROM content after a failed TMC bus hand-back

Adds a cpld_bus_stuck flag to struct ptp_ocp which is set when
adva_x1_mblaze_release() fails to get the TMC segment handed back, and
cleared when a later adva_x1_bus_claim() is granted.  While the flag is
set, ptp_ocp_read_eeprom() returns without reading, so the driver does
not cache or publish a serial number and board id it may have read off
the TMC segment.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 4a58bcc146487..510083dc750a5 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -2022,6 +2024,18 @@ ptp_ocp_read_eeprom(struct ptp_ocp *bp)
>  	if (!bp->i2c_ctrl)
>  		return;
>  
> +	/* A hand-back that timed out leaves the controller possibly still
> +	 * routed to the TMC segment.  Reading now would latch whatever
> +	 * answers 0x50/0x58 there as the serial and board id, and those are
> +	 * published over the unprivileged devlink info path, so refuse
> +	 * rather than cache something that was never read from the EEPROMs.
> +	 */
> +	if (READ_ONCE(bp->cpld_bus_stuck)) {
> +		dev_dbg(&bp->pdev->dev,
> +			"skipping EEPROM read, TMC bus routing unknown\n");
> +		return;
> +	}
> +

[Severity: High]
Can this test still let the bad value be cached?  The flag is sampled
once here, before any transfer, and neither caller of
ptp_ocp_read_eeprom() holds bp->cpld_lock, so nothing keeps the answer
valid for the duration of the nvmem_device_read() loop that follows.

What actually keeps EEPROM traffic off a TMC-routed controller is the
i2c root adapter lock, and the comment above adva_x1_bus_claim() says so:

drivers/ptp/ptp_ocp.c:
/*
 * Claim the TMC bus.  The adapter lock is held across the handshake to keep
 * the EEPROM, nvmem and at24 paths off the controller while it is routed
 * away from the EEPROMs; an EEPROM read blocks until the claim is dropped.
 */

So doesn't this ordering remain reachable?

CPU0 ptp_ocp_devlink_info_get() / serialnum_show()
  ptp_ocp_read_eeprom()
    READ_ONCE(bp->cpld_bus_stuck)   /* false, passes the gate */
    nvmem_device_read()             /* blocks on the adapter lock */

CPU1 ptp_ocp_cpld_work() -> adva_x1_cpld_read_id()
  adva_x1_bus_claim()
    i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER)
    adva_x1_mblaze_acquire()        /* granted, routing on TMC */
  adva_x1_bus_release()
    adva_x1_mblaze_release()        /* -ETIMEDOUT */
    WRITE_ONCE(bp->cpld_bus_stuck, true)
    i2c_unlock_bus(adap, I2C_LOCK_ROOT_ADAPTER)   /* releases CPU0 */

CPU0 then completes its transfers over a controller the driver has just
declared possibly still routed to the TMC segment, stores the bytes into
bp->serial and bp->board_id through BP_MAP_ENTRY_ADDR() and sets
bp->has_eeprom_data = true.  Since both callers only call in while
!has_eeprom_data, is there anything that can correct that value later?

The same window also exists between two iterations of the map loop, where
the flag can flip to true after the first nvmem_device_read() has already
returned.

Would checking the flag (or the MBLAZE_GRANT bits) under bp->cpld_lock,
or re-checking it before setting has_eeprom_data, close this?

[Severity: Medium]
The two driver-owned publishers of the cached identity now behave
differently on this new "read refused" outcome.
ptp_ocp_devlink_info_get() re-tests the flag and emits nothing:

	if (!bp->has_eeprom_data) {
		ptp_ocp_read_eeprom(bp);
		if (!bp->has_eeprom_data)
			return 0;
	}

serialnum_show() does not:

	if (!bp->has_eeprom_data)
		ptp_ocp_read_eeprom(bp);

	return sysfs_emit(buf, "%pM\n", bp->serial);

So when the new gate skips the read, doesn't /sys/class/timecard/ocpN/serialnum
still print 00:00:00:00:00:00, or bytes left behind by a partially completed
read?  ptp_ocp_read_eeprom() writes each map entry directly into
bp->serial/bp->board_id and its fail: path only logs, leaving the entries
already stored in place while has_eeprom_data stays false.

Documentation/ABI/testing/sysfs-timecard describes the attribute as
"(RO) Provides the serial number of the timecard." with no encoding for an
unknown value.

The unconditional sysfs_emit() itself predates this patch and is unchanged
at the baseline, so this is not a new code path - but with the new outcome
the emitted value is one the driver itself now considers invalid.  Should
serialnum_show() also test has_eeprom_data before emitting, given the
commit aims to stop the driver publishing a value that was never read from
the EEPROMs?

> @@ -4537,6 +4551,8 @@ static int adva_x1_bus_release(struct ptp_ocp *bp)
>  		return 0;
>  
>  	err = adva_x1_mblaze_release(bp);
> +	if (err)
> +		WRITE_ONCE(bp->cpld_bus_stuck, true);
>  	bp->cpld_adap = NULL;
>  	kfree(bp->cpld_buf);
>  	bp->cpld_buf = NULL;

[ ... ]

> @@ -4632,10 +4648,17 @@ static int adva_x1_bus_claim(struct ptp_ocp *bp)
>  	bp->cpld_adap = adap;
>  
>  	ret = adva_x1_mblaze_acquire(bp);
> -	if (ret)
> +	if (ret) {
>  		adva_x1_bus_release(bp);	/* keeps the acquire error */
> +		return ret;
> +	}
>  
> -	return ret;
> +	/* The firmware granted the segment, so it is answering the handshake
> +	 * again and the routing is known once more.
> +	 */
> +	WRITE_ONCE(bp->cpld_bus_stuck, false);
> +
> +	return 0;
>  }

[Severity: Medium]
Is the flag recoverable in practice?  It is latched on one hand-back
timeout and cleared in exactly one place, after a fully successful claim.

Two cases seem to leave it set forever.

First, a hand-back that demonstrably succeeded does not clear it.  On the
acquire failure path above, adva_x1_bus_release() runs
adva_x1_mblaze_release(), which may return 0 - meaning it observed the
firmware drop the grant and the controller is back on the EEPROM segment -
and then the function returns the acquire error before reaching the
WRITE_ONCE(bp->cpld_bus_stuck, false).

Second, nothing re-validates the hardware indicator.
adva_x1_mblaze_release() answers the question with a single register read:

	val = ioread32(&bp->pps_select->i2c_bus_ctrl);
	if ((val & MBLAZE_GRANT_MASK) != MBLAZE_GRANT)
		return 0;

but ptp_ocp_read_eeprom() consults only the sticky bool.

Claims are issued by ptp_ocp_cpld_work(), which stops rescheduling once
the one-shot identification is settled:

	if (!READ_ONCE(bp->cpld_id_tried))
		queue_delayed_work(system_power_efficient_wq, &bp->cpld_work,
				   HZ);

and otherwise only by the root-only cpld_status_show() and the privileged
devlink flash.  So after a single transient -ETIMEDOUT with cpld_id_tried
already set, doesn't the driver's EEPROM read stay suppressed for the rest
of the binding, with devlink info silently omitting the serial number and
board id and serialnum printing 00:00:00:00:00:00, and only a dev_dbg() to
explain it?

Relatedly, the commit message says:

    A later claim that the firmware grants proves the
    handshake is working again and clears it.

Given that the only source of later claims is the one-shot worker plus two
privileged paths, is that recovery generally available, and should the
possibility of a permanently suppressed read be mentioned?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922142829.57740-1-maimon.sagi%40gmail.com
