Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF733B52F8;
	Sun,  4 Oct 2026 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129403; cv=none; b=gUmxEkxc35hUBZn46Vb+ojA+X09wIUH9+Sn3cf1fM9cehPJU4v1NUNiFsnzy9pBAUDOHTba81YZo5tSj2jAqrRDJas5E+Bo+WUKVwwv5B0I0oZuDjgjmQwt6AxwSw4IJy+RPhMIKbP0c93/mAbXPQh9/Jwuji3/D9eR2FtnmnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129403; c=relaxed/simple;
	bh=ByvCKZ4zDglpJYIRWVFt3I1uWJR3TRVbRW6Qk0tMoZE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQZ/Uz6B+t+Jci1er0fVzHC6z9koh1uaQUuoOzYkItQhOc5ch5p+ANzP7e597gV5zNDKUZWv6yGoBcIjpsuCgU+bVVMpb6uGC+1tQSTD7LFWmb7Fehq7xLY8a1JcCdfdi9gXYMu2WctfOgkbZQRFI1/hZBZOlCOz1UvKIPhAfg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr3CZkOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr3CZkOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCD31F00893;
	Sun,  4 Oct 2026 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791129400;
	bh=HE4/EjmbUxYNEVKES2AEbMvto2+RxAF9YnEpSTTBP4c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lr3CZkODHpaf5zn9xJsmZfEaICTD5m/IBqLpAaVxZ4kOH5Lqiz5Guzm1V6Wrm/9lQ
	 6E9wqSIgDFIjhgwmqSdwDIrcP1QgPrQaQknrC+URgUwb/ZLIr80HUsFdogV47cflRJ
	 W8s2+F5bLbOCoLKiOwBx3tJZI1wUfz8p7PZV+BxQhja8ZLi4pJaQ5InDYqWBBc2GnX
	 NOv+kOhIBnAZ7aeatm64LDUEtYSAQgZ5B94H3wL+Q8MRjKo6AxMfG34EZzLeDID0YT
	 Dts8MBlNeSjHiVZ44UYs9mAa7szzusr3FLEbGBAR55WHqhJAqCMp8Z/dOsDBjvxHg4
	 wJ+M5aJbk/xgQ==
Subject: Re: [PATCH net-next v19 5/6] net: dsa: mxl862xx: recover switch stuck
 in MCUboot rescue mode
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Sun, 04 Oct 2026 15:56:38 +0000
Message-ID: <179112939850.434549.8902297675518024292@kernel.org>
In-Reply-To: =?utf-8?q?=3Cdd243fa0df46b0cee4caf155b0388ea1702853ba=2E1791035?=
 =?utf-8?q?885=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cdd243fa0df46b0cee4caf155b0388ea1702853ba=2E17910358?=
 =?utf-8?q?85=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Every probe now depends on clause-22 SB PDI access, even on a
  switch with healthy firmware.
- [Medium] The drain relies on the claim that 'the drained image never
  boots, since its zero fill fails the loader's CRC gate' (comment on…
- [Medium] mxl862xx_setup_rescue() queues the drain on system_long_wq,
  created as alloc_workqueue("events_long", WQ_PERCPU, 0) and therefore…
- [Medium] mxl862xx_rescue_mode_detect() takes a single STAT sample as a
  definite magic before considering that it could be an outstanding byte…
- [Low] The patch folds a fix for an existing defect in the running-
  firmware CRC path into a 660-line feature patch, with no Fixes: tag.
- [Low] The 'Rescue lifecycle' section of the mxl862xx-fw.c file header
  says flash_update returns '-EIO for good once the loader cannot accept…

--

net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode

At setup, this patch checks over the clause-22 SB PDI mailbox whether the
switch is sitting in its MCUboot loader, and does this before any
clause-45 access. In rescue mode the switch is registered without user
ports, so devlink can still reflash it. If a download was interrupted
mid-payload, a background work item drains the loader back to READY and
then re-probes.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> index eae7048707870..eb48fbf7c7115 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c

[ ... ]

> + * Rescue lifecycle (devlink): probe runs mxl862xx_rescue_mode_detect(); a
> + * wedged loader is drained back to READY by a background self-heal
> + * (rescue_heal_work), so the long recovery never holds the devlink lock.
> + * devlink dev info exposes the fw version (the "flashable" signal) only once at
> + * READY; flash_update returns -EBUSY until then, -EIO for good once the
> + * loader cannot accept a download (a failed recovery, or a handshake no
> + * session can finish), and reprobes to WSP firmware on success.

[Severity: Low]
This isn't a bug, but does this list of -EIO causes match the code?

mxl862xx_rescue_heal_work_fn() also sets rescue_failed after a drain that
succeeded, when device_schedule_reprobe() fails with anything other than
-EINVAL. At that point the loader is at a clean READY and can accept a
download. What is lost is only the binding's ability to reclassify the
switch.

The @rescue_failed kernel-doc in mxl862xx.h does list this third cause
("a re-probe that could not be scheduled"). The file header leaves it
out, and "the loader cannot accept a download" is not the reason in that
case.

[ ... ]

> +/* The loader is not asking for a chunk: it may still be programming the last
> + * one, or the counter has reached zero and it is verifying the image and
> + * resetting into READY. Before the first chunk it may also still be erasing
> + * for the session that died, which no verify window covers. Wait that out:
> + * STAT cannot tell the cases apart, and guessing would mean writing END into a
> + * live receive loop. The drained image never boots, since its zero fill fails
> + * the loader's CRC gate, so a count outliving the window is a loader that has
> + * stopped servicing the mailbox.

[Severity: Medium]
Is it guaranteed that the zero fill fails the CRC gate?

Suppose every byte not yet committed when the host died was zero, for
example zero padding at the end of image 2. The zero-filled image then
matches its CRC32. The loader publishes VERIFY_OK (STAT=0), waits for END
and boots the image.

mxl862xx_sb_pdi_poll_drain() treats STAT == 0 as "asks for a chunk", so
the sequence would be:

mxl862xx_rescue_heal_work_fn()
  mxl862xx_rescue_drain()
    mxl862xx_sb_pdi_poll_drain() returns 0 (the VERIFY_OK verdict)
    feeds one more byte (CTRL=WR, DATA=0, reset, STAT=1)
    mxl862xx_sb_pdi_poll_drain() sees STAT=1 or the firmware's status word
    mxl862xx_rescue_drain_finish(priv, chunk) with chunk > 0
      polls 15 s, logs "loader stuck after %u chunks, power cycle it"
      returns -EIO
  WRITE_ONCE(priv->rescue_failed, true), and no re-probe

Probe can hit the same path. If the STAT == 0 slice-advance in
mxl862xx_rescue_mode_detect() supplies the last outstanding byte, rb is
0, the switch is IN_RESCUE without rescue_ready, and the heal work then
takes the path above.

Wouldn't the driver then stay bound with no user ports, and devlink flash
keep returning -EIO, while the switch runs a verified image? Whether real
images can end in enough zero bytes depends on the image format.

[ ... ]

> +	stat = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_STAT);
> +	if (stat < 0)
> +		return stat;
> +
> +	/* Flashless-download loop (MxL86281S tier): this driver does not
> +	 * support it -- the console flash path expects READY. Treat it as an
> +	 * unusable configuration, like any other unsupported state.
> +	 */
> +	if ((u16)stat == MXL862XX_SB_PDI_DL_READY)
> +		return -EOPNOTSUPP;

[ ... ]

> +	if ((u16)stat == MXL862XX_SB_PDI_START ||
> +	    (u16)stat == MXL862XX_SB_PDI_START + 1) {
> +		WRITE_ONCE(priv->rescue_failed, true);
> +		return MXL862XX_IN_RESCUE;
> +	}

[Severity: Medium]
Could this single STAT sample be a byte count the loader is still showing,
rather than a magic value?

The loader keeps the host's count in STAT while it programs a chunk and
verifies the image. In mxl862xx_flash_firmware(), the final slice count
that mxl862xx_sb_pdi_flush_last() writes can be anything from 1 to 65520.
That range includes 0xc33c (49980), 0xc55c (50524), 0xf48f (62607) and
0xf490 (62608).

Take a flush_last that fails on an SMDIO read error or its 75 s timeout
while the loader is still programming or verifying the final slice. The
flash path then schedules a re-probe 500 ms later, and setup() runs
detection:

  0xc33c fails probe with -EOPNOTSUPP
  0xf48f / 0xf490 set rescue_failed for the rest of the binding
  0xc55c sends the RDREG challenge to a loader that is not in its
         command loop

These checks run before the settle handling and do not depend on it.
Should a count still on display be ruled out before these values are
taken as magics?

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> index b229c4512b82c..744bbb8d6a24e 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c

[ ... ]

> @@ -503,6 +511,15 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
>  	dev_dbg(&priv->mdiodev->dev, "RET %d DATA %*ph\n", ret, size, data);
>  
>  out:
> +	/* A quiet command is expected to go unanswered by a switch still
> +	 * booting or sitting in its loader, so it does not arm the shutdown.
> +	 */
> +	if (mxl862xx_crc_failed(ret)) {
> +		if (!quiet &&
> +		    !test_and_set_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags))
> +			schedule_work(&priv->crc_err_work);
> +		ret = -EIO;
> +	}
>  	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
>  
>  	return ret;

[Severity: Low]
This isn't a bug, but this hunk also fixes behaviour that already exists
in the driver.

In the current code (from commit a319d0c8c8ce), mxl862xx_set_data(),
mxl862xx_get_data() and mxl862xx_rst_data() return mxl862xx_issue_cmd()'s
fw_result unchanged. mxl862xx_api_wrap() then returns it through
"if (ret < 0) goto out". Only mxl862xx_send_cmd() mapped firmware errors
to -EIO.

So a firmware CRC code (-1024/-1023) reported during a multi-chunk
transfer or RST_DATA reached callers as a raw errno, and it never armed
crc_err_work.

Could the central mapping go in as a separate fix with a Fixes: tag, so
it can be backported on its own? The same hunk also stops quiet commands
(the mxl862xx_wait_ready() polls) from arming the CRC shutdown. Before
this patch they did arm it.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index e6f710c676e65..9097b0c559256 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c

[ ... ]

> +	/* Drain the wedged download in the background so it never holds the
> +	 * devlink lock; info and flash become available once ready.
> +	 */
> +	dev_warn(ds->dev,
> +		 "switch in MCUboot with an interrupted download, recovering in background\n");
> +	queue_work(system_long_wq, &priv->rescue_heal_work);
> +}

[Severity: Medium]
What happens if the system suspends while this drain is running?

system_long_wq is created with alloc_workqueue("events_long", WQ_PERCPU, 0),
so it is not freezable. The driver has no suspend/resume handling. The
drain can run for tens of minutes, with four SMDIO writes and a STAT poll
for every byte.

During suspend, the driver core suspends the mdio_device first, then the
mii_bus, then the MDIO controller, while the kworker keeps issuing bus
accesses.

If one of those accesses returns a bus error, mxl862xx_rescue_drain()
passes it up. mxl862xx_rescue_heal_work_fn() then sets rescue_failed, and
devlink flash returns -EIO until a rebind. On controllers where an access
to a clock-gated block stalls or aborts, the result could be worse.

The work behind device_schedule_reprobe(), which runs right after the
drain, is freezable. Would a freezable workqueue, or some PM coordination,
fit the drain as well?

>  static int mxl862xx_setup(struct dsa_switch *ds)
>  {

[ ... ]

> -	ret = mxl862xx_reset(priv);
> -	if (ret)
> -		return ret;
> +	/* Detect the loader over SB PDI first: it needs no firmware, unlike the
> +	 * C45 API (mxl862xx_reset/wait_ready), which spends its whole 10 s
> +	 * window on a mailbox nobody answers. Touch C45 only once rescue is
> +	 * ruled out.
> +	 */
> +	rescue = mxl862xx_rescue_mode_detect(priv, false);
> +	if (rescue < 0) {
> +		dev_err(ds->dev, "switch in an unusable state: %pe\n",
> +			ERR_PTR(rescue));
> +		return rescue;
> +	}

[Severity: Medium]
Does this make every probe depend on clause-22 SB PDI access, even for a
switch with healthy firmware?

Before this patch, setup() used only clause-45, through mxl862xx_reset()
and mxl862xx_wait_ready(). Three setups that probe today would now fail.

First, an MDIO host without a ->write callback. __mdiobus_write() returns
-EOPNOTSUPP, and detection passes that straight up:

drivers/net/phy/mdio_bus.c:__mdiobus_write() {
    ...
	if (bus->write)
		err = bus->write(bus, addr, regnum, val);
	else
		err = -EOPNOTSUPP;
    ...
}

Second, a switch whose SB PDI window has been moved by OTP. The file
header says "the 0xe1xx register offsets are the OTP reset defaults and
the only layout supported here". In that case the ADDR/DATA scratch latch
fails and detection returns -ENODEV.

Third, a single failed clause-22 transfer during the presence check.
wait_ready() used to retry quietly in that situation.

The commit message lists -ENODEV for a switch that "has its SB PDI window
elsewhere". It doesn't mention that this now fails probe for a switch
that works today.

Could -ENODEV or -EOPNOTSUPP from this first detection be treated as
"not in rescue", so probe continues on the clause-45 path?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791035885.git.daniel%40makrotopia.org
