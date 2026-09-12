Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB32287518;
	Sat, 12 Sep 2026 00:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789172939; cv=none; b=GIorBAOaJTNdz0VRNGZPXKS6XdM3s+qlPAD8rOi2ROy1azeJzK/s7pT4E06ikMIRLQ9mCJZXHmoB+1VykTioZPwuBIjAeLe4y1aP1IrXRW7TobqUMFOyjV22HUSSk8lZGLWCBs8ezHxeEQ2WqjpSz9iPeiYLaPVkGIOea9HN2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789172939; c=relaxed/simple;
	bh=s7G11paDjFpsVaz2XwV78H67cL6QKSBj29+De38RXDU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nRMZHqh3IZn/RUnBdRyZOz9XY5sAT/JrHksQEA3u4pYTTHrVAlpe4E8mI7A/FcfxzTJm/dyBqzszRixiQTxav2rvmnYJWSXmIWWRyKsOdcC3bmaSb4XapjOe13+BgeCvpwmv6oc9n+qJM4QV1eGPY8Zhb5DiDgYK4POuuxQTMKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA3xEcWr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA3xEcWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8ED21F000FF;
	Sat, 12 Sep 2026 00:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789172937;
	bh=1DUv7brlRMzeWa7Rkb0k29OtDqUJfE93cd+2I0DTrQM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bA3xEcWrqxeHWee0ONsuzNl4r/SdjTJ71WtJjtZYNW9KmR5QvRcCt+j0UyW2P97V4
	 23dBjxYgxU55vRaCoWmgt6PPsHGfUeEx8++Figpi4AhoTBSLpT88Jxifs7VgF9H7+l
	 DvYkCH6U19UmVq4JVAChojz2yDM1MVxGj5WtHwGBTuHbsEe5n9LAUtFhAQdqmDl906
	 TtI1+fHn0bARZdqDAK3YeawFgsMfd0RUZNbglbsXSe43Dd9fRmnp7GGzWykZO/XYxw
	 VEZlrnoNygzjmFVcuteRSIo1ibStZgNIZUqH+Ul7R3unU0ostH2iMTXkXPm9iSeIav
	 Tz5P0GP0ahhEw==
Subject: Re: [PATCH net-next v14 4/6] net: dsa: mxl862xx: add devlink
 flash_update and info_get
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Sat, 12 Sep 2026 00:28:56 +0000
Message-ID: <178917293624.219967.1596425447722739945@kernel.org>
In-Reply-To: =?utf-8?q?=3C88154e67987195ab7c5199fa0269ab6a5e80d2a7=2E1788976?=
 =?utf-8?q?064=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C88154e67987195ab7c5199fa0269ab6a5e80d2a7=2E17889760?=
 =?utf-8?q?64=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

- [Medium] priv->flash_reading is documented (kernel-doc for struct
  mxl862xx_priv and the in-function comment in mxl862xx_api_wrap()) as…
- [Medium] In mxl862xx_flash_firmware() the return value of the final,
  purely optional END (0x3cc3) STAT write is propagated as the result of…

Pre-existing issues:
- [High] mxl862xx_remove() stops the periodic stats poll with
  set_bit(MXL862XX_FLAG_WORK_STOPPED) followed by…

--

net: dsa: mxl862xx: add devlink flash_update and info_get

This adds runtime firmware upgrade through "devlink dev flash" and version
reporting through "devlink dev info" for the mxl862xx DSA driver. The flash
path closes the user and conduit interfaces, blocks firmware API commands,
transfers the image over the SB PDI protocol and then schedules a deferred
re-probe.

A few questions about the new code below.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> new file mode 100644
> index 0000000000000..e8913954b2bae
> --- /dev/null
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> @@ -0,0 +1,642 @@

[ ... ]

> +	mxl862xx_flash_notify(dl, "Flashing", payload_size, payload_size);
> +
> +	/* Success: the loader has left the receive loop at r_remain == 0 and
> +	 * verified the image, so END(0x3cc3) is a finalise/boot request rather
> +	 * than a byte count. Signal it here -- and only here -- to boot the new
> +	 * image without waiting out the loader's 2 s END timeout.
> +	 */
> +	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
> +				   MXL862XX_SB_PDI_END);
> +	msleep(MXL862XX_FW_REBOOT_DELAY_MS);
> +	return ret;

[Severity: Medium]
Should the status of this last END write really decide the outcome of the
whole flash?

At this point mxl862xx_sb_pdi_flush_last() has already returned 0, which per
its own logic only happens after the loader published
MXL862XX_SB_PDI_VERIFY_OK, so the image is fully transferred, verified and
will be booted. The comment above the write and the file's protocol comment
both say END is optional because the loader finalises on its own 2 s timeout.

mxl862xx_smdio_write() forwards __mdiobus_write()'s return, so it can fail
with -ETIMEDOUT or -EIO from the bus driver. In that case
mxl862xx_devlink_flash_update() takes the failure path: the
mxl862xx_wait_ready() confirmation is skipped, priv->fw_version, asic_id and
asic_rev are zeroed, and a retry is refused with -EBUSY since skip_teardown
is now set. So a successful update is reported as a transfer failure and
"devlink dev info" reports no versions at all until the re-probe runs.

Would it make sense to log the END write failure and still return success
here, given the verdict has already been read?

[ ... ]

> +int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
> +				  struct devlink_flash_update_params *params,
> +				  struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
> +	disable_delayed_work_sync(&priv->stats_work);
> +	cancel_work_sync(&priv->crc_err_work);
> +	for (i = 0; i < ds->num_ports; i++)
> +		cancel_work_sync(&priv->ports[i].host_flood_work);

[Severity: High]
This isn't a bug introduced by this patch, but the same stats_work re-arm
race that disable_delayed_work_sync() closes here is still open in
mxl862xx_remove(), which uses the plain cancel:

drivers/net/dsa/mxl862xx/mxl862xx.c:mxl862xx_remove() {
	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
	cancel_delayed_work_sync(&priv->stats_work);

	dsa_unregister_switch(ds);
	...
}

The reader side tests the flag locklessly:

drivers/net/dsa/mxl862xx/mxl862xx.c:mxl862xx_get_stats64() {
	...
	if (!test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
		schedule_delayed_work(&priv->stats_work, 0);
}

Can a get_stats64() caller that already passed the test_bit() re-arm the work
after cancel_delayed_work_sync() has returned? cancel_delayed_work_sync()
only dequeues and waits, it does not make a later schedule_delayed_work() a
no-op, and no further cancel follows, so mxl862xx_stats_work_fn() would then
iterate dsa_switch_for_each_available_port() over ports released by
dsa_unregister_switch() and dereference the devm-allocated priv and ds after
mxl862xx_remove() returns.

The user netdevs are still registered at that point, so the racing reader can
be something as ordinary as "ip -s link" during an unbind. Would converting
remove() to disable_delayed_work_sync() as well be appropriate, either here
or as a separate fix?

> +
> +	ret = mxl862xx_flash_firmware(priv, params->fw, payload_size,
> +				      ds->devlink);
> +	if (ret)
> +		NL_SET_ERR_MSG_MOD(extack, "firmware transfer failed");
> +
> +	if (!ret) {
> +		mutex_lock_nested(&priv->mdiodev->bus->mdio_lock,
> +				  MDIO_MUTEX_NESTED);
> +		/* Keep block_host set so host writes stay blocked, but let the
> +		 * readiness poll below read the freshly booted firmware.
> +		 */
> +		priv->flash_reading = true;
> +		mutex_unlock(&priv->mdiodev->bus->mdio_lock);
> +
> +		/* Refresh the cached versions so the flash update only
> +		 * completes once the new firmware is confirmed running and
> +		 * devlink dev info reports it. Must happen before setting
> +		 * skip_teardown, which discards all firmware API reads.
> +		 */
> +		ret = mxl862xx_wait_ready(ds);

[Severity: Medium]
Does priv->flash_reading actually restrict the bypass to the flash path?

The gate it feeds only looks at the direction of the command:

drivers/net/dsa/mxl862xx/mxl862xx-host.c:mxl862xx_api_wrap() {
	...
	if (priv->block_host && cmd != SYS_MISC_FW_UPDATE &&
	    !(priv->flash_reading && read)) {
		ret = -EBUSY;
		goto out;
	}
	...
}

There is no check of the calling context and no narrowing to
SYS_MISC_FW_VERSION or MXL862XX_COMMON_CFGGET, so while the flag is set every
read-type firmware API command from any context reaches the switch: the
ethtool MAC/RMON/pause stat handlers, mxl862xx_port_fdb_dump(), the
MXL862XX_MAC_TABLEENTRYQUERY half of mxl862xx_port_mdb_add() and
mxl862xx_port_mdb_del(), MXL862XX_COMMON_CFGGET and INT_GPHY_READ.

The window is not short either. mxl862xx_wait_ready() starts with
msleep(2000) and polls up to MXL862XX_READY_TIMEOUT_MS, and rtnl is dropped
by then, while the user netdevs are only closed and detached, still
registered. So "ethtool -S swp0" or "bridge fdb show" in that window issues
admitted reads against the freshly booted firmware.

There is a second effect for read-modify-write sequences: mdb_add() gets its
MXL862XX_MAC_TABLEENTRYQUERY read admitted and then hits -EBUSY on the
following MXL862XX_MAC_TABLEENTRYADD write, so it fails half executed rather
than being refused up front.

Should the bypass be keyed on the flash path itself, for instance on the
specific commands the readiness poll issues?

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> index 11759fa6069b1..caa4f74a86cf1 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> @@ -340,6 +341,21 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
>  
>  	mutex_lock_nested(&priv->mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
>  
> +	if (priv->skip_teardown) {
> +		ret = read ? -ENODEV : 0;
> +		goto out;
> +	}
> +
> +	/* During the post-flash readiness poll block_host stays set, but the
> +	 * flash path's own firmware version reads must reach the new image;
> +	 * host writes stay blocked so stale resource IDs cannot corrupt it.
> +	 */
> +	if (priv->block_host && cmd != SYS_MISC_FW_UPDATE &&
> +	    !(priv->flash_reading && read)) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +

The comment here says "the flash path's own firmware version reads", but the
condition admits any read from any caller, as noted above.

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
> index 432a5f3f2e08e..7231ed6c9187c 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.h
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
> @@ -319,6 +323,12 @@ struct mxl862xx_fw_version {
>   * @evlan_ingress_size: per-port ingress Extended VLAN block size
>   * @evlan_egress_size:  per-port egress Extended VLAN block size
>   * @vf_block_size:      per-port VLAN Filter block size
> + * @block_host:         reject firmware API commands (except FW_UPDATE)
> + *                      during a firmware flash
> + * @flash_reading:      let the flash path's own firmware reads through
> + *                      block_host while polling the freshly booted image

The kernel-doc for @flash_reading documents the same flash-path-only
restriction that the predicate in mxl862xx_api_wrap() does not implement.
Should either the wording or the check be adjusted so the two agree?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788976064.git.daniel%40makrotopia.org
