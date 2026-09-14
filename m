Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F3396565;
	Mon, 14 Sep 2026 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789410903; cv=none; b=LZLbk+AH2qwyZwJxQEaI9cUpHwWxfqDi5wfuloZkDXTvpO/oiM3YcLY00gP2Uqoa2S2Uncuf3GN3CDiS2C9wnNM1U08B6P0dhN5B5qQ4gg5eIQJW0RaucY0F+8OQODwybiU8uDs4k5AoNOA9Uo2Km9CGYS/zKfcdzn56DXqqwEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789410903; c=relaxed/simple;
	bh=8Gyxvwf8kx1IowtRI/PKQ8rjc3xdQ+z/+eGYk5gG5Lk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TDn8t/fLsrQ1fFMaZr6PgmjRFlktonTcDMBTkp1F6HeHu1t574biOczWUVfnC5FwCc78ISANa6mMR/c5Z077jPVW+Xzc5rm2nX9eNL9dKGtq3HLqHQZnkXrtjrPGtL7TeY/CB8uQd+jDpjXGk0Zh214M/YO+J3BmBxS67RfAh/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apzLBovR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apzLBovR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A561F00899;
	Mon, 14 Sep 2026 18:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789410898;
	bh=BSP4m0I5q0VOdSemQ4tu48j3pxknW6V2l9YCvtSFDm8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=apzLBovRtkUB49EN4MaAoMCVijzin9NkJ4gOhYMFfVdDabBzhTV/RDa0WtdOWHOzA
	 tfRUMOaIsyBviKf5aSnvcppgC/xDImUR5WayTMz0NLv5i5VBnbbM9mIA7Ul/e3x3mf
	 EAMifPffIeLVLHBj/RukPH6uM7pPzQ9vPD4HIrj8YT8XVPO8lY11xckskP8ikFVc1w
	 URgOvaz9MAoRlt+nDqJtnjJWd9eW6zUemXgQCht510U2PsjTZwNkEvB4Lby9ocRH2C
	 ZvOWKZyu8zC7+7bGG+Up6vVKZ+RoSbiTtKploFztUdZEQMQDGXTLuS30/YsWmBj6HC
	 DOogoNivDtsDw==
Subject: Re: [PATCH net-next v15 5/6] net: dsa: mxl862xx: recover switch stuck
 in MCUboot rescue mode
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Mon, 14 Sep 2026 18:34:56 +0000
Message-ID: <178941089675.22033.4191173896423195861@kernel.org>
In-Reply-To: =?utf-8?q?=3C76f2d4150cffd8188a5b945bb0bd227fa453b99e=2E1789175?=
 =?utf-8?q?618=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C76f2d4150cffd8188a5b945bb0bd227fa453b99e=2E17891756?=
 =?utf-8?q?18=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: High
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

Critical: 0 · High: 2 · Medium: 3 · Low: 1

- [High] ABBA deadlock between device_lock(dev) and
  cancel_work_sync(&priv->rescue_heal_work).
- [High] Rescue detection cannot tell a loader that is still erasing or
  programming from a running firmware, because the 'settle' window is…
- [Medium] mxl862xx_phylink_get_caps() still derives the SerDes interface
  capabilities from priv->fw_version, which rescue mode never populates.
- [Medium] priv->rescue_failed is latched for the STAT==START/START+1
  handshake state and is never cleared for the life of the binding, so…
- [Medium] In mxl862xx_devlink_flash_update() the failure of
  device_schedule_reprobe() (e.g. -ENOMEM from its internal allocation)…
- [Low] Kernel-doc return sets do not match the code for the new
  -ECANCELED path.

--

net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode

This adds SB PDI (clause-22) probing at setup time so a switch left in its
MCUboot loader is detected before any clause-45 access, and lets the driver
bind in a reduced "rescue mode" where devlink can reflash it.  A wedged
mid-download loader is drained back to a ready state by a background work
item, which then hands off to device_schedule_reprobe() so probe-time
detection can re-classify the switch.

A few questions below about the new detection and self-heal paths.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> index 119792eb7bd58..457830c9f51f4 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c

[ ... ]

> @@ -219,6 +266,371 @@ static void mxl862xx_flash_notify(struct devlink *dl, const char *status,
>  	devlink_flash_update_status_notify(dl, status, NULL, done, total);
>  }
>  

[ ... ]

> +/* Wait for the loader to ask for the next chunk (STAT 0) or to come back to its
> + * command loop (STAT READY), and return the STAT value either way. On timeout
> + * that is whatever STAT still holds, which carries no further information: the
> + * loader keeps the count we wrote visible while it programs the chunk, and that
> + * is the same value it publishes as the "image rejected" verdict once the
> + * counter reaches zero.

[ ... ]

> +static int mxl862xx_sb_pdi_poll_drain(struct mxl862xx_priv *priv,
> +				      unsigned long timeout_ms)
> +{
> +	int val;
> +
> +	read_poll_timeout(mxl862xx_smdio_read, val,
> +			  val < 0 || (u16)val == MXL862XX_SB_PDI_READY ||
> +			  (u16)val == 0 ||
> +			  test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags),
> +			  50, timeout_ms * 1000, false,
> +			  priv, MXL862XX_SB_PDI_STAT);
> +	if (val < 0)
> +		return val;
> +	if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
> +		return -ECANCELED;
> +	return (u16)val;
> +}
> +
> +/* The loader is not asking for a chunk: it may still be programming the last
> + * one, or the counter has reached zero and it is verifying the image and
> + * resetting into READY. Wait that out -- STAT cannot tell the two apart, and
> + * guessing would mean writing END into a live receive loop.
> + *
> + * Return: 0 once the loader has left the loop, -EAGAIN if it asks for another
> + * chunk after all, -EIO for a loader still holding the count when the verify
> + * window expires, or an SMDIO bus error.
> + */

[Severity: Low]
The comment on mxl862xx_sb_pdi_poll_drain() says it returns "the STAT value
either way", but there is a fourth outcome:

	if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
		return -ECANCELED;

Should the documented return sets mention -ECANCELED?
mxl862xx_rescue_drain_finish() forwards it through its "if (stat < 0) return
stat;" while its Return: list names only 0, -EAGAIN, -EIO and an SMDIO bus
error, and the Return: list of mxl862xx_rescue_mode_detect() (IN_RESCUE,
NOT_RESCUE, -ENODEV, -EOPNOTSUPP, -ENXIO, SMDIO bus error) leaves it out too,
even though both of its mxl862xx_sb_pdi_poll_drain() calls can produce it.

> +static int mxl862xx_rescue_drain_finish(struct mxl862xx_priv *priv, u32 chunk)
> +{

[ ... ]

> +/* Background self-heal: drain a wedged download off the devlink flash path, so
> + * the long recovery never holds the devlink lock. Scheduled from probe;
> + * reprobes on success so the probe-time detection re-classifies the switch.
> + */
> +void mxl862xx_rescue_heal_work_fn(struct work_struct *work)
> +{
> +	struct mxl862xx_priv *priv =
> +		container_of(work, struct mxl862xx_priv, rescue_heal_work);
> +	struct device *dev = &priv->mdiodev->dev;
> +	int ret;
> +
> +	ret = mxl862xx_rescue_drain(priv);
> +	if (ret == -ECANCELED)
> +		return;

[ ... ]

> +	if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
> +		return;
> +
> +	if (device_schedule_reprobe(dev, MXL862XX_FW_REPROBE_DELAY_MS))
> +		WRITE_ONCE(priv->rescue_failed, true);
> +}

[Severity: High]
Can this work item deadlock against teardown?

device_schedule_reprobe() takes the device lock of the same device:

drivers/base/dd.c:device_schedule_reprobe() {
	...
	device_lock(dev);
	parent = dev->parent;
	if (!dev->bus || !dev->p || dev->p->dead ||
	    !device_is_registered(dev) || !dev->driver) {
	...
}

and this patch adds a synchronous cancel of the same work to the teardown
path:

drivers/net/dsa/mxl862xx/mxl862xx-host.c:mxl862xx_host_shutdown() {
	cancel_work_sync(&priv->crc_err_work);
	cancel_work_sync(&priv->rescue_heal_work);
}

mxl862xx_host_shutdown() is reached from mxl862xx_remove(),
mxl862xx_shutdown() and the dsa_register_switch() failure path of
mxl862xx_probe(), all of which the driver core invokes with device_lock(dev)
already held, e.g.:

drivers/base/core.c:device_shutdown() {
	...
	device_lock(dev);
	...
	} else if (dev->driver && dev->driver->shutdown) {
		dev->driver->shutdown(dev);
	...
}

So is this interleaving possible?

  heal work				teardown thread
  mxl862xx_rescue_drain() == 0
  test_bit(WORK_STOPPED) == false
					device_lock(dev)   (core)
					mxl862xx_host_shutdown()
  device_schedule_reprobe()
    device_lock(dev)  -> blocks
					cancel_work_sync(&rescue_heal_work)
					  -> waits for the work

The test_bit(MXL862XX_FLAG_WORK_STOPPED) check above is a check, not mutual
exclusion, and in mxl862xx_remove() the flag is set well before the cancel
(dsa_unregister_switch() runs in between), so the work has time to reach the
blocking device_lock().  If that happens, does unbind ever return, and does a
reboot hang inside device_shutdown() holding the device lock?  The probe error
path looks similar: setup() queues the work, the drain can return quickly when
the loader is already at READY, and probe still holds the device lock for the
rest of dsa_register_switch().

Would deferring the reprobe hand-off to something that does not take
device_lock() from the work, or dropping the sync cancel in favour of the
core's own "device is going away" handling, avoid this?

> +
> +/* Detect MCUboot rescue mode over clause-22 SMDIO alone, so the caller can rule
> + * the loader out before any C45 API request (which spews CRC errors when no WSP
> + * firmware answers). A scratch write to ADDR/DATA must latch or the chip is
> + * absent (-ENODEV); the mailbox is reset first, or a transfer interrupted with
> + * CTRL=WR would take that write as a payload word instead of latching it. STAT
> + * then classifies the state, poked destructively only when 0, the one value a
> + * running firmware never holds:

[ ... ]

> +int mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv, bool settle)
> +{

[ ... ]

> +	/* The download handshake lives in STAT too and outlives a mailbox
> +	 * reset, so an aborted transfer leaves the loader waiting for a
> +	 * header no later session can supply: only a power cycle clears it.
> +	 */
> +	if ((u16)stat == MXL862XX_SB_PDI_START ||
> +	    (u16)stat == MXL862XX_SB_PDI_START + 1) {
> +		WRITE_ONCE(priv->rescue_failed, true);
> +		return MXL862XX_IN_RESCUE;
> +	}

[Severity: Medium]
Is this state reachable from the driver's own flash path, and is the resulting
refusal permanent?

mxl862xx_flash_firmware() publishes START and then waits for the ACK:

	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
				   MXL862XX_SB_PDI_START);
	...
	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_START + 1,
					MXL862XX_FW_ACK_TIMEOUT_MS);
	if (ret) {
		...
		goto no_end;
	}

An SMDIO error, an ACK timeout or a host interruption in that window leaves
STAT at START/ACK and the loader is not returned to READY, so the post-flash
reprobe lands in the branch above and latches rescue_failed.  Nothing clears
rescue_failed for the life of the binding, and mxl862xx_devlink_flash_update()
tests it first:

	if (READ_ONCE(priv->rescue_failed)) {
		NL_SET_ERR_MSG_MOD(extack,
				   "download recovery failed, power cycle the switch");
		return -EIO;
	}

That looks at odds with the commit message:

    after a failed one the switch is still in MCUboot, rescue mode
    is detected again, and the user can retry.

Also, does a power cycle alone (as the extack suggests) restore flashability?
The still-bound driver keeps rescue_mode and rescue_failed set, so
mxl862xx_api_wrap() keeps short-circuiting to -ENODEV and user ports stay
unused until an unbind/rebind.  Should the extack and the commit message
mention the rebind, and should the START/ACK case be listed among the
detection outcomes the commit message enumerates?

> +
> +	/* Any other non-zero value is a running firmware, not a loader -- but
> +	 * the loader also holds the count of a chunk it is still programming,
> +	 * so let a caller that has ruled the firmware out wait that out.
> +	 */
> +	if (stat) {
> +		if (!settle)
> +			return MXL862XX_NOT_RESCUE;
> +
> +		stat = mxl862xx_sb_pdi_poll_drain(priv,
> +						  MXL862XX_SB_PDI_STEP_MS);
> +		if (stat < 0)
> +			return stat;
> +		if (stat == MXL862XX_SB_PDI_READY) {
> +			WRITE_ONCE(priv->rescue_ready, true);
> +			return MXL862XX_IN_RESCUE;
> +		}
> +		if (stat)
> +			return MXL862XX_NOT_RESCUE;
> +	}

[Severity: High]
Is a 2 s settle window (MXL862XX_SB_PDI_STEP_MS) long enough to tell a busy
loader from a running firmware?

The driver's own bounds for those loader phases are much longer:

	#define MXL862XX_FW_ERASE_TIMEOUT_MS	300000
	#define MXL862XX_FW_WRITE_TIMEOUT_MS	60000

During an erase the loader keeps the count it was given in STAT
(mxl862xx_flash_firmware() writes STAT=MXL862XX_FW_HDR_SIZE, polls for
HDR_SIZE + 1, then polls for STAT == 0 with MXL862XX_FW_ERASE_TIMEOUT_MS), and
while a slice is being programmed STAT holds data_written.  Both are non-zero
and neither is a magic value.

So if the host dies during the erase or a slice write, does the next probe take
this "other non-zero => running firmware" branch?  mxl862xx_setup() first calls
mxl862xx_rescue_mode_detect(priv, false), which returns NOT_RESCUE, then runs
mxl862xx_reset() and mxl862xx_wait_ready() over clause-45, and the follow-up
mxl862xx_rescue_mode_detect(priv, true) waits only 2 s before returning
NOT_RESCUE again, leaving probe to fail with the -ETIMEDOUT from
mxl862xx_wait_ready().

That is the outcome the commit message says is removed:

    The clause-45 MMD API never comes up, so probe
    would fail with -ETIMEDOUT

    The first
    three enter rescue mode or normal operation, the last two fail probe
    cleanly with -EOPNOTSUPP and -ENODEV instead of a CRC-error storm.

Should the settle window be sized against MXL862XX_FW_ERASE_TIMEOUT_MS /
MXL862XX_FW_WRITE_TIMEOUT_MS instead, or should the erase/program counts be
classified explicitly?

> +
> +	/* STAT == 0: a wedged receive loop takes a 1-byte slice-advance (feed
> +	 * one DATA word first, like a drain chunk) and asks for the next chunk
> +	 * by publishing 0 again.

[ ... ]

> @@ -559,9 +992,28 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
>  		return ret;
>  	}
>  
> -	dev_info(ds->dev, "flash: running firmware %u.%u.%u\n",
> -		 priv->fw_version.major, priv->fw_version.minor,
> -		 priv->fw_version.revision);
> +	/* Refuse to flash while the background self-heal is still draining, and
> +	 * for good once it has given up on the loader.
> +	 */
> +	if (READ_ONCE(priv->rescue_failed)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "download recovery failed, power cycle the switch");
> +		return -EIO;
> +	}
> +
> +	if (READ_ONCE(priv->rescue_mode) && !READ_ONCE(priv->rescue_ready)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "switch is recovering an interrupted download, retry shortly");
> +		return -EBUSY;
> +	}

[ ... ]

> @@ -608,6 +1060,7 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
>  		 * readiness poll below read the freshly booted firmware.
>  		 */
>  		priv->flash_owner = current;
> +		WRITE_ONCE(priv->rescue_mode, false);
>  		mutex_unlock(&priv->mdiodev->bus->mdio_lock);
>  
>  		/* Refresh the cached versions so the flash update only

[Severity: Medium]
This isn't introduced here alone, but the rescue-mode flash path makes it
reachable in one more way: what happens at the tail of
mxl862xx_devlink_flash_update() when the reprobe hand-off fails?

	priv->skip_teardown = true;
	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
	...
	err = device_schedule_reprobe(ds->dev, MXL862XX_FW_REPROBE_DELAY_MS);

	return ret ? ret : err;

device_schedule_reprobe() returns -ENOMEM when its allocation fails, and the
function returns that without restoring skip_teardown, clearing
MXL862XX_FLAG_WORK_STOPPED, re-arming the stats/CRC/flood workers or reopening
the ports, and with no reprobe queued to rebuild any of it.  Every later flash
attempt then hits the earlier guard:

	if (priv->skip_teardown) {
		NL_SET_ERR_MSG_MOD(extack,
				   "device is reinitializing, retry later");
		return -EBUSY;
	}

Does that leave the instance quiesced and unflashable until a manual
unbind/rebind?

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
> index b689652aa9b92..6fde3a58939d0 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-phylink.c
> @@ -406,6 +406,8 @@ mxl862xx_phylink_mac_select_pcs(struct phylink_config *config,
>  
>  	switch (port) {
>  	case 9 ... 16:
> +		if (READ_ONCE(priv->rescue_mode))
> +			return NULL;
>  		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84)) {
>  			dev_warn_once(dp->ds->dev,
>  				      "SerDes PCS unsupported on old firmware.\n");

[Severity: Medium]
mac_select_pcs() gets a rescue_mode escape here, but should
mxl862xx_phylink_get_caps() get one too?  It still derives the interface mask
from the cached firmware version:

drivers/net/dsa/mxl862xx/mxl862xx-phylink.c:mxl862xx_phylink_get_caps() {
	...
	case 10 ... 12:
	case 14 ... 16:
		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84))
			break;
		__set_bit(PHY_INTERFACE_MODE_QSGMII, config->supported_interfaces);
		__set_bit(PHY_INTERFACE_MODE_10G_QXGMII, config->supported_interfaces);
	...
}

In rescue mode mxl862xx_setup() returns before mxl862xx_wait_ready(), which is
the only writer of priv->fw_version, so the version stays 0.0.0 and
MXL862XX_FW_VER_MIN(priv, 1, 0, 84) is false.  For ports 10-12 and 14-16 that
leaves supported_interfaces empty, and phylink rejects that:

drivers/net/phy/phylink.c:phylink_create() {
	...
	if (phy_interface_empty(config->supported_interfaces)) {
		dev_err(config->dev, "phylink: error: empty supported_interfaces\n");
		return ERR_PTR(-EINVAL);
	}
	...
}

Since dsa_tree_setup_ports() has no as-unused fallback for CPU/DSA ports:

net/dsa/dsa.c:dsa_tree_setup_ports() {
	...
	if (dsa_port_is_dsa(dp) || dsa_port_is_cpu(dp)) {
		err = dsa_port_setup(dp);
		if (err)
			goto teardown;
	}
	...
}

does a shared or CPU port in that index range fail the whole probe instead of
binding in rescue mode?  This is the opposite of what the commit message
describes:

    user ports fail port_setup with -ENODEV (the DSA core
    re-registers them as unused) while shared and CPU ports succeed, and the
    CPU port works on its fixed link with mac_select_pcs returning no PCS.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index 2f112d69f7887..3048073d02f98 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
> @@ -674,21 +674,68 @@ static int mxl862xx_setup(struct dsa_switch *ds)

[ ... ]

> +	rescue = mxl862xx_rescue_mode_detect(priv, false);
> +	if (rescue < 0) {
> +		dev_err(ds->dev, "switch state detection failed: %pe\n",
> +			ERR_PTR(rescue));
> +		return rescue;
> +	}
>  
> -	ret = mxl862xx_wait_ready(ds);
> -	if (ret)
> -		return ret;
> +	if (rescue == MXL862XX_NOT_RESCUE) {
> +		ret = mxl862xx_reset(priv);
> +		if (ret)
> +			return ret;
> +
> +		ret = mxl862xx_wait_ready(ds);
> +		if (ret) {
> +			/* the reset may only now have triggered rescue mode */
> +			rescue = mxl862xx_rescue_mode_detect(priv, true);
> +			if (rescue < 0) {
> +				dev_err(ds->dev,
> +					"switch not responding after reset: %pe\n",
> +					ERR_PTR(rescue));
> +				return rescue;
> +			}
> +			if (rescue == MXL862XX_NOT_RESCUE)
> +				return ret;
> +		}
> +	}
>  
> +	priv->rescue_mode = rescue;
> +
> +	/* Software-only SerDes state, needed before anything can reach phylink,
> +	 * including a rescue-mode flash clearing rescue_mode ahead of reprobe.
> +	 */
>  	mutex_init(&priv->serdes_lock);
>  	for (i = 0; i < ARRAY_SIZE(priv->serdes_ports); i++)
>  		mxl862xx_setup_pcs(priv, &priv->serdes_ports[i],
>  				   i + MXL862XX_FIRST_SERDES_PORT);
>  
> +	if (priv->rescue_mode) {
> +		if (priv->rescue_ready) {
> +			dev_warn(ds->dev,
> +				 "switch in MCUboot rescue mode, use devlink to flash new firmware\n");
> +		} else if (priv->rescue_failed) {
> +			dev_warn(ds->dev,
> +				 "switch in MCUboot with an unfinishable download, power cycle it\n");
> +		} else {

[ ... ]

> +			queue_work(system_long_wq, &priv->rescue_heal_work);
> +		}
> +		return 0;
> +	}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789175618.git.daniel%40makrotopia.org
