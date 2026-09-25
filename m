Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301BE412C0D;
	Fri, 25 Sep 2026 05:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314463; cv=none; b=OTaZPxlCZu8kAIgQFfKJVEBhy+j3QDREeUQ8cZEzBlAh8WUuNLmOdF3Tad29ks9x6ougL1xqL6a3G2QTOK0cd3kEFqM1yCD1B9PtnKJ8wHP7R8Z7V4NNi9ZQVM+pMNCs0g9IfO95FEoZBQXFQW1Q5/vrRasUNA0SRG9b6/a8bpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314463; c=relaxed/simple;
	bh=oXAA8SjdQnumCwzVY9sdEV3aDC8MaRO9uGj/5zw0+oA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=euy2V+ZtqZTg8T6zcqSb0F+IygZ4Yr6drqkO4Rm/EWRd1Qp9PwmQlqZL1c4wJn1Z7RbRh4TRt5NUtVj34qv/2HSUi34M9E1pOo8Lp0VBYE14K3RmC6zSkn4gwdDcdsnLCTOpCqHgkiDDhJpiUCTuB8sKXVY2tsrCX74uGVl2Onc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKmnFyNb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKmnFyNb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BCB1F00893;
	Fri, 25 Sep 2026 05:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790314461;
	bh=PYeOfjKtRZRbMeYOkspCymqLbzQNJLxAV+uF3DjfoAU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FKmnFyNbUzE3S/hiTXY6UXLHaU+aLkvg5la/x8sNZ0nDUTiz3KiQ/O6auCrC9Hw08
	 1GtFtxqyKixl6OqoPNYnxFHt3Afi2PZHdPn+L0qKkaGgJNLUSHB5yZYJRSRFNX5Lrx
	 xg4Iy1DrwFbXbkELD6XA4lHnWgKVwDIj+5fDrcjDmIg9JhFYFN/ZeRTIBIkxZB6Kj1
	 3iaa3CA5SGKey1HDGC/B3z8QZ6EBsqZrGZWQqAdSAQy3VvnBCNMxsb/8jdnvAu3gB3
	 qmZJS1wpxIPSQmCEQq11e8pp/M0Tb5bHgiPevCXmAn7TIwM0hNRZY5eEx0V0C4gEps
	 1pimBGkY9wisw==
Subject: Re: [PATCH net-next v17 4/6] net: dsa: mxl862xx: add devlink
 flash_update and info_get
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Fri, 25 Sep 2026 05:34:20 +0000
Message-ID: <179031446039.2160803.7361896493328823357@kernel.org>
In-Reply-To: =?utf-8?q?=3C4e9a8b6062f8dccfa5564400b4f80dda983e4c33=2E1790130?=
 =?utf-8?q?482=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C4e9a8b6062f8dccfa5564400b4f80dda983e4c33=2E17901304?=
 =?utf-8?q?82=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
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

- [Medium] After a failed transfer in mxl862xx_devlink_flash_update()
  (drivers/net/dsa/mxl862xx/mxl862xx-fw.c), the driver sets…
- [Medium] mxl862xx_port_mdb_add() and mxl862xx_port_mdb_del()
  (drivers/net/dsa/mxl862xx/mxl862xx.c) decide whether a failed…
- [Medium] In mxl862xx_devlink_flash_update()
  (drivers/net/dsa/mxl862xx/mxl862xx-fw.c), the…
- [Medium] After writing STAT := 20 to hand over the header,
  mxl862xx_flash_firmware() waits for the header ACK with…
- [Low] The commit message says the post-flash re-probe scheduled through
  device_schedule_reprobe() 'runs in the driver core off the devlink…
- [Low] The kernel-doc no longer matches how the cached identity fields
  are handled at runtime.

--

net: dsa: mxl862xx: add devlink flash_update and info_get

This patch adds devlink info_get and flash_update support to the mxl862xx
DSA driver. A flash reboots the switch into its MCUboot loader, streams the
image over the SB PDI clause-22 SMDIO protocol, and then schedules a
deferred re-probe through device_schedule_reprobe() to reinitialise the
driver. Firmware API access is blocked while the flash runs, and
->shutdown() and .remove() take the devlink instance lock so they wait for
a flash that is already in progress.

> MCUboot offers no in-place path back, so the driver reinitialises with a
> deferred re-probe scheduled through device_schedule_reprobe() from the
> previous patch, which runs in the driver core off the devlink caller's
> locks and without holding a module or device reference. ->shutdown() and

[Severity: Low]
Is the part about the device reference accurate? device_schedule_reprobe()
takes one:

drivers/base/dd.c:device_schedule_reprobe() {
    ...
	rp->dev = get_device(dev);
	rp->drv = drv;
    ...
}

device_reprobe_work_fn() drops it with put_device(dev) after the attach, so
only the module reference is avoided. Could this sentence be reworded?

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> new file mode 100644
> index 0000000000000..7a506d110c8da
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> @@ -0,0 +1,680 @@

[ ... ]

> +	/* the byte count in STAT triggers the erase */
> +	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
> +				   MXL862XX_FW_HDR_SIZE);
> +	if (ret < 0)
> +		goto write_err;
> +
> +	/* ACK is byte count + 1 */
> +	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_FW_HDR_SIZE + 1,
> +					MXL862XX_FW_ACK_TIMEOUT_MS);
> +	if (ret) {
> +		dev_err(&priv->mdiodev->dev,
> +			"flash: header ACK failed: %pe\n", ERR_PTR(ret));
> +		goto no_end;
> +	}

[Severity: Medium]
Can this poll miss the header ACK? The protocol description at the top of
this file says STAT only holds 21 until the erase finishes:

 *                          <-------------- STAT=21 (len+1), then STAT=0
 *                                          (erased)

mxl862xx_sb_pdi_poll_stat() only accepts an exact match, and its reads come
2.5 to 10 ms apart, each read being two MDIO transactions. STAT can go from
21 to 0 between two samples, for example with a short erase, preemption, or
a wait on mdio_lock. The poll then sees 0 until the 5 s ACK timeout runs
out, logs "header ACK failed" and jumps to no_end. By then the loader has
accepted the header, erased the flash and is waiting in its receive loop.

mxl862xx_sb_pdi_flush_last() in the same file avoids this by waiting for
STAT to change away from the value the host wrote. Could the header ACK
poll accept either 21 or 0 in the same way?

At this commit, a missed ACK leaves the switch in MCUboot with its flash
erased. The poll is unchanged later in the series, where a missed ACK leads
to the rescue-mode drain. That drain feeds one byte at a time and can take
tens of minutes.

[ ... ]

> +write_err:
> +	dev_err(&priv->mdiodev->dev, "flash: SMDIO write failed: %pe\n",
> +		ERR_PTR(ret));
> +no_end:
> +	/* A failure leaves the loader mid transfer; do not signal END (a STAT
> +	 * write is a byte count then, and END would be misread as one, risking
> +	 * a receive-counter underflow). Return the error; the caller reprobes.
> +	 */
> +	return ret;
> +}

[Severity: Medium]
Does the reprobe recover the device at this point in the series? After a
failed transfer the switch is still in MCUboot, but at this commit
mxl862xx_setup() goes straight to the clause-45 firmware API:

	ret = mxl862xx_reset(priv);
	if (ret)
		return ret;

	ret = mxl862xx_wait_ready(ds);

MCUboot does not answer that API, so the re-probe fails and
device_reprobe_work_fn() logs "re-probe failed, device left unbound". Once
the device is unbound, no devlink instance is left to retry the flash from.
The loader also stays resident across a power cycle, because the flash is
erased or half written.

The next patch in the series, "net: dsa: mxl862xx: recover switch stuck in
MCUboot rescue mode", fixes this by calling mxl862xx_rescue_mode_detect()
at the top of mxl862xx_setup(). So the gap only affects bisection within
the series. Could the patches be reordered, or the "the caller reprobes"
comment and the commit message be adjusted until the rescue-mode patch
lands?

[ ... ]

> +	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	priv->flash_owner = NULL;
> +	priv->block_host = false;
> +	priv->skip_teardown = true;
> +	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
> +
> +	/* Reinitialise through a deferred re-probe: remove() runs with
> +	 * skip_teardown set, then a fresh probe() starts against whatever
> +	 * the switch now runs. The core skips the re-probe if the device
> +	 * is unbound or shut down before it fires.
> +	 */
> +	err = device_schedule_reprobe(ds->dev, MXL862XX_FW_REPROBE_DELAY_MS);
> +	if (!ret && err)
> +		dev_err(ds->dev,
> +			"flash: new firmware is running but re-probe could not be scheduled (%pe); unbind and rebind to reinitialise\n",
> +			ERR_PTR(err));
> +
> +	return ret ? ret : err;
> +}

[Severity: Medium]
What happens if the transfer fails and device_schedule_reprobe() also
fails, for example with -ENOMEM from kzalloc_obj() or kstrdup()?

The scheduling error is only logged when ret is 0, and the return
statement drops it otherwise. By this point the user ports are closed and
detached, the conduit is closed, stats_work is disabled and skip_teardown
is set. Only the reprobe undoes any of that.

The device then stays bound, but every firmware read fails with -ENODEV
and every write is dropped. Nothing in the log says that an unbind and
rebind is needed.

A retry of devlink dev flash then hits the early check in
mxl862xx_devlink_flash_update():

	if (priv->skip_teardown) {
		NL_SET_ERR_MSG_MOD(extack,
				   "a previous flash awaits its reprobe");
		return -EBUSY;
	}

That check fails even though no reprobe is pending. The path is still the
same at the end of the series, where the rescue-mode reprobe would
otherwise recover the switch.

Should the scheduling failure also be logged, and possibly returned, when
the transfer failed?

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index e05ad52cd297e..33a7cdb8edd31 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c

[ ... ]

> @@ -222,7 +230,45 @@ static int mxl862xx_phy_write_c45_mii_bus(struct mii_bus *bus, int addr,

[ ... ]

> +/**
> + * mxl862xx_wait_ready - wait for the switch firmware to become operational
> + * @ds: DSA switch instance
> + *
> + * Poll the firmware until it reports its version and accepts
> + * configuration commands, then cache the firmware version and chip ID.
> + * Takes at least two seconds.
> + *
> + * Return: 0 on success or a negative error code.
> + */
> +int mxl862xx_wait_ready(struct dsa_switch *ds)
>  {

[ ... ]

> @@ -254,6 +300,11 @@ static int mxl862xx_wait_ready(struct dsa_switch *ds)
>  		priv->fw_version.major = ver.iv_major;
>  		priv->fw_version.minor = ver.iv_minor;
>  		priv->fw_version.revision = le16_to_cpu(ver.iv_revision);
> +
> +		ret = mxl862xx_read_chip_id(priv);
> +		if (ret)
> +			dev_warn(ds->dev, "failed to read chip ID: %pe\n",
> +				 ERR_PTR(ret));
>  		return 0;

[Severity: Low]
This isn't a bug, but the kernel-doc here and in struct mxl862xx_priv no
longer quite matches the code.

The mxl862xx_wait_ready() kernel-doc says it will "cache the firmware
version and chip ID". However, a failed mxl862xx_read_chip_id() is only
logged and the function still returns 0. If SYS_MISC_REG_RD fails after a
successful flash, asic_id and asic_rev keep their pre-flash values, and
mxl862xx_devlink_flash_update() treats the 0 return as a complete refresh.

The @fw_version comment in mxl862xx.h still says:

 * @fw_version:         cached firmware version, populated at probe and
 *                      compared with MXL862XX_FW_VER_MIN()

mxl862xx_devlink_flash_update() now also rewrites fw_version at runtime,
through mxl862xx_wait_ready() after a successful flash and with memset()
after a failed one. So MXL862XX_FW_VER_MIN() checks can see 0.0.0 until
the reprobe.

Could these comments be updated?

[ ... ]

> @@ -1547,6 +1598,13 @@ static int mxl862xx_port_mdb_add(struct dsa_switch *ds, int port,
>  	qparam.tci = cpu_to_le16(FIELD_PREP(MXL862XX_TCI_VLAN_ID, mdb->vid));
>  
>  	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);
> +	/* A flash blocks the API (-EBUSY) and its teardown drops the MAC
> +	 * table (-ENODEV); there is then nothing to program, and the reprobe
> +	 * rebuilds the configuration. See mxl862xx_port_mdb_del().
> +	 */
> +	if ((ret == -EBUSY && priv->block_host) ||
> +	    (ret == -ENODEV && priv->skip_teardown))
> +		return 0;
>  	if (ret)
>  		return ret;

[Severity: Medium]
Can this check race with the end of a flash? mxl862xx_api_wrap() returns
-EBUSY while holding mdio_lock with block_host set. Here, though,
block_host and skip_teardown are read again after that lock has been
released. mxl862xx_devlink_flash_update() changes both flags in a single
critical section:

	priv->flash_owner = NULL;
	priv->block_host = false;
	priv->skip_teardown = true;

If that runs between api_wrap() returning and this check, neither
condition matches:

CPU1 (MDB add/del)                     CPU2 (flash task)
mxl862xx_api_wrap()
  block_host set -> -EBUSY
  mutex_unlock(mdio_lock)
                                       mutex_lock(mdio_lock)
                                       block_host = false
                                       skip_teardown = true
                                       mutex_unlock(mdio_lock)
ret == -EBUSY && block_host   -> false
ret == -ENODEV && ...         -> false
return -EBUSY

The flash task holds only the devlink lock at this point, so an MDB change
from a bridge teardown can run at the same time.

For a CPU port, dsa_port_do_mdb_del() in net/dsa/switch.c then keeps the
entry on dp->mdbs:

	err = ds->ops->port_mdb_del(ds, port, mdb, db);
	trace_dsa_mdb_del_hw(dp, mdb->addr, mdb->vid, &db, err);
	if (err) {
		refcount_set(&a->refcount, 1);
		goto out;
	}

The entry stays until dsa_switch_release_ports() in the reprobe cleans it
up. In the add direction, port_mdb_add() reports a failure that should not
happen. The v17 changelog and the comment above both say this case is
handled.

The change from block_host to skip_teardown only goes one way. Would it
work to treat either errno as success whenever block_host or skip_teardown
is set? Another option is for mxl862xx_api_wrap() to return a distinct
result for a command blocked by a flash. The same check in
mxl862xx_port_mdb_del() has the same window.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790130482.git.daniel%40makrotopia.org
