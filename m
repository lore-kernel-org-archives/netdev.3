Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BA6484887;
	Thu, 17 Sep 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661493; cv=none; b=CTe3iZsrc+H5SDm6beLFmIe9pnHJ15LKNZ4zoSCEU8+u7KIHXSVYJX6kniRAfO2w7tdH0MVqy2+fhW5OAYQhjXBTpac82YUEPPlTVoYCq5w4GzUtQyelMXRftV8/udYoN5bv+OFfxAL/V3d+XMfNIEnc2+Tvu+I4hhjVZuunsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661493; c=relaxed/simple;
	bh=XLq14amChtVLngFo7FeTSWjQHy+Obkh+WCgmm2oxHMc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pWyKO8SB0SqTtCri/AiGTsu2hlT1nO0fERAYL06HsycqaMtJeilD/JmxRAc/ArJV9vYVhULY6rH0dWqum97ZXkH9KMGDmS6foU6OOlR/0kTAm9iRSp/hLUKhIXw3kXg8L7SA+n5tsI6tT99wx14jzczhwILGutonO7Py35p41TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5weQJSP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5weQJSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5E21F00893;
	Thu, 17 Sep 2026 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661491;
	bh=/OQVXbZ93H+3QSEAtwzj3ljgELqCMLc3VT6YdacFU4k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B5weQJSP8V6Visa/kHLA06nPztj/wPEcskitFHaO9ubuaSbQ9iqEiWD/jAuF3FmiB
	 dGqhhavruo3mkhZ5WgHM7rsZDAzIouGfYSz43Cj5socIXgFl540QAYsAWai4y3rKU9
	 XwxtLhUQDNncgMGoUmK9Cn+Tnd/4KY6eNgiHkHhVnVYso3mDHORKCVuWV2m7BHUuJo
	 PY0gCeHtflfnk4+xP/weq/sCbrCBrTMYZPLXka9LTIU9s/wPlkOZOffN7bSJxsQBK/
	 uIL4sGW2Kou37zdQQR7vE35juMLTNZQDG4xRyXBauGre7Eb3PKSg7Dja7/w+nTCNty
	 R8MEN4oMI7FtA==
Subject: Re: [PATCH net-next v16 5/6] net: dsa: mxl862xx: recover switch stuck
 in MCUboot rescue mode
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Thu, 17 Sep 2026 16:11:29 +0000
Message-ID: <178966148996.22033.4317503843038112442@kernel.org>
In-Reply-To: =?utf-8?q?=3C1b6f092c5c93f34b6905e5f66f8498bdab6eeb23=2E1789477?=
 =?utf-8?q?568=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3C1b6f092c5c93f34b6905e5f66f8498bdab6eeb23=2E17894775?=
 =?utf-8?q?68=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
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

Critical: 0 · High: 0 · Medium: 4 · Low: 1

- [Medium] Rescue mode leaves priv->fw_version at 0.0.0, so
  mxl862xx_phylink_get_caps() (drivers/net/dsa/mxl862xx/mxl862xx-…
- [Medium] mxl862xx_setup() now calls mxl862xx_rescue_mode_detect() as
  the very first switch access and returns its errno verbatim, so…
- [Medium] mxl862xx_rescue_drain_finish() orders its checks so that `if
  (!chunk)` pre-empts the 'a firmware is answering ... an image survived…
- [Medium] mxl862xx_setup_rescue() queues the multi-minute (up to hours)
  drain with queue_work(system_long_wq, &priv->rescue_heal_work).
- [Low] struct mxl862xx_priv's kernel-doc documents @rescue_failed as
  '(rescue_mode) the self-heal gave up or cannot run; the loader needs a…

--

net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode

This adds probe-time detection of the MCUboot loader over the clause-22
SB PDI mailbox, registers the switch in a reduced "rescue mode" so
devlink stays usable, and adds a background work item that drains a
download an interrupted host left wedged in the loader's receive loop.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> index 139c14adf2d98..d001a884e6fc6 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c

[ ... ]

> @@ -219,6 +269,379 @@ static void mxl862xx_flash_notify(struct devlink *dl, const char *status,
>  	devlink_flash_update_status_notify(dl, status, NULL, done, total);
>  }
>  

[ ... ]

> +/* The loader is not asking for a chunk: it may still be programming the last
> + * one, or the counter has reached zero and it is verifying the image and
> + * resetting into READY. Before the first chunk it may also still be erasing
> + * for the session that died, which no verify window covers. Wait that out --
> + * STAT cannot tell the cases apart, and guessing would mean writing END into a
> + * live receive loop.
> + *
> + * Return: 0 once the loader has left the loop, -EAGAIN if it asks for another
> + * chunk after all, -EIO for a loader still holding the count when the window
> + * expires, -ECANCELED on teardown, or an SMDIO bus error.
> + */
> +static int mxl862xx_rescue_drain_finish(struct mxl862xx_priv *priv, u32 chunk)
> +{
> +	struct device *dev = &priv->mdiodev->dev;
> +	int stat;
> +
> +	if (chunk)
> +		stat = mxl862xx_sb_pdi_poll_drain(priv, MXL862XX_SB_PDI_POLL_US,
> +						  MXL862XX_SB_PDI_VERIFY_MS);
> +	else
> +		stat = mxl862xx_sb_pdi_poll_drain(priv,
> +						  MXL862XX_SB_PDI_SLOW_POLL_US,
> +						  MXL862XX_FW_ERASE_TIMEOUT_MS);
> +	if (stat < 0)
> +		return stat;
> +	if (stat == MXL862XX_SB_PDI_READY)
> +		return 0;
> +	if (stat == MXL862XX_SB_PDI_VERIFY_BAD) {
> +		dev_err(dev,
> +			"flash: loader stuck after %u chunks, power cycle it\n",
> +			chunk);
> +		return -EIO;
> +	}
> +	if (stat) {
> +		if (!chunk) {
> +			dev_err(dev,
> +				"flash: loader still busy after the erase window\n");
> +			return -EIO;
> +		}
> +		/* A firmware is answering, not the loader: an image survived
> +		 * in flash and booted.
> +		 */
> +		dev_info(dev, "flash: firmware booted while draining\n");
> +		return 0;
> +	}

[Severity: Medium]

Is the ordering of the chunk == 0 test against the "firmware booted"
case here intentional?  The same non-zero, non-READY STAT value returns
-EIO when chunk == 0 and 0 ("firmware booted while draining") when
chunk > 0.

There seems to be a path that reaches the chunk == 0 arm with a real
firmware status word in STAT.  mxl862xx_rescue_mode_detect() already
feeds one advance byte in its STAT == 0 branch:

	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
				   MXL862XX_DRAIN_CHUNK_BYTES);
	...
	rb = mxl862xx_sb_pdi_poll_drain(priv, MXL862XX_SB_PDI_POLL_US,
					MXL862XX_SB_PDI_STEP_MS);

If that byte was the last one outstanding and the loader's verify plus
reset outlasts MXL862XX_SB_PDI_STEP_MS, detection returns
MXL862XX_IN_RESCUE with rescue_ready still false.  The heal work then
starts its drain, its first mxl862xx_sb_pdi_poll_drain() sees the
lingering count, and mxl862xx_rescue_drain_finish(priv, 0) waits up to
MXL862XX_FW_ERASE_TIMEOUT_MS -- during which the freshly booted
firmware publishes its own status word, which lands in the chunk == 0
arm and returns -EIO.

mxl862xx_rescue_heal_work_fn() then latches rescue_failed and skips the
reprobe, so priv->rescue_mode stays set for the life of the binding:
mxl862xx_api_wrap() keeps returning -ENODEV, devlink dev info reports
nothing and devlink dev flash returns -EIO, on a switch that is running
firmware.

Does that conflict with the commit message?

  "a valid image that a last-moment interruption left bootable comes up
   as running firmware, with no second-guessing in the drain path"

Would moving the chunk == 0 check after the "firmware booted"
classification, or distinguishing the two by the STAT value rather than
by chunk, cover this?

[ ... ]

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
> +	if (ret) {
> +		/* Nothing retries this, so say so: rescue_ready stays clear
> +		 * and devlink dev flash reports why it refuses.
> +		 */
> +		dev_err(dev, "flash: download recovery failed: %pe\n",
> +			ERR_PTR(ret));
> +		WRITE_ONCE(priv->rescue_failed, true);
> +		return;
> +	}

[ ... ]

> +	if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
> +		return;
> +
> +	if (device_schedule_reprobe(dev, MXL862XX_FW_REPROBE_DELAY_MS))
> +		WRITE_ONCE(priv->rescue_failed, true);
> +}

[ ... ]

> +int mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv, bool settle)
> +{
> +	int stat, dat, ret, rb, a, d;
> +
> +	/* rescue_ready gates flashing; a wedged loader needs the drain first. */
> +	WRITE_ONCE(priv->rescue_ready, false);
> +
> +	ret = mxl862xx_sb_pdi_reset(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Presence: a live chip latches the scratch write, an absent one floats. */
> +	a = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_ADDR,
> +				 MXL862XX_SB_PDI_PROBE_A);
> +	if (a < 0)
> +		return a;
> +	d = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA,
> +				 MXL862XX_SB_PDI_PROBE_D);
> +	if (d < 0)
> +		return d;
> +	a = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_ADDR);
> +	if (a < 0)
> +		return a;
> +	d = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_DATA);
> +	if (d < 0)
> +		return d;
> +	if ((u16)a != MXL862XX_SB_PDI_PROBE_A ||
> +	    (u16)d != MXL862XX_SB_PDI_PROBE_D)
> +		return -ENODEV;

[Severity: Medium]

Should a failure of the SB PDI probe be fatal to binding?  The rescue
channel is an addition, but mxl862xx_setup() now runs this first and
propagates the errno:

	rescue = mxl862xx_rescue_mode_detect(priv, false);
	if (rescue < 0) {
		dev_err(ds->dev, "switch state detection failed: %pe\n",
			ERR_PTR(rescue));
		return rescue;
	}

so a part whose clause-45 mailbox works fine, but which does not latch
0x5a5a/0xa5a5 at MXL862XX_SB_PDI_ADDR/DATA, now fails probe with -ENODEV
and exposes no interfaces at all.  The file header states the offsets are
not guaranteed:

  * The SMDIO PHY address comes from the device tree; the 0xe1xx register
  *   offsets are the OTP reset defaults and the only layout supported here.

Would treating a detection failure as "no rescue support available" and
falling through to mxl862xx_reset()/mxl862xx_wait_ready() be safer than
refusing to bind?

The STAT classification rests on the same single sample.  The commit
message says a running firmware "answers with its own non-zero status
word (0x0003 on the firmware tested)", and the STAT == 0 branch below
calls 0 "the one value a running firmware never holds".  A firmware
whose status word reads 0 gets the destructive CTRL=WR / DATA=0 / STAT=1
poke and is then registered in rescue mode with every user port
re-registered as unused.  Is that assumption documented anywhere outside
the tested image?

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index 5668aac9ef7a1..d5e29fd74adbc 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
> @@ -667,27 +667,85 @@ static void mxl862xx_free_bridge(struct dsa_switch *ds,
>  	priv->bridges[bridge->num] = 0;
>  }
>  
> +static void mxl862xx_setup_rescue(struct dsa_switch *ds)
> +{
> +	struct mxl862xx_priv *priv = ds->priv;
> +
> +	if (priv->rescue_ready) {
> +		dev_warn(ds->dev,
> +			 "switch in MCUboot rescue mode, use devlink to flash new firmware\n");
> +		return;
> +	}
> +
> +	if (priv->rescue_failed) {
> +		dev_warn(ds->dev,
> +			 "switch in MCUboot with an unfinishable download, power cycle it\n");
> +		return;
> +	}
> +
> +	/* Drain the wedged download in the background so it never holds the
> +	 * devlink lock; info and flash become available once ready.
> +	 */
> +	dev_warn(ds->dev,
> +		 "switch in MCUboot with an interrupted download, recovering in background\n");
> +	queue_work(system_long_wq, &priv->rescue_heal_work);
> +}

[Severity: Medium]

What happens to this work item across a system suspend?  system_long_wq
is not WQ_FREEZABLE, and the only abort condition inside
mxl862xx_rescue_drain() and mxl862xx_sb_pdi_poll_drain() is
MXL862XX_FLAG_WORK_STOPPED, which is set from the probe error path,
remove(), shutdown() and the flash path, but not from any PM transition.

The commit message says the drain "takes tens of minutes for a large
image", so a suspend landing inside it does not look exotic.  The worker
would keep issuing mxl862xx_smdio_read()/mxl862xx_smdio_write() while the
MDIO controller or conduit driver suspends, and a negative return from
those propagates out of mxl862xx_rescue_drain() into
mxl862xx_rescue_heal_work_fn():

	if (ret) {
		dev_err(dev, "flash: download recovery failed: %pe\n",
			ERR_PTR(ret));
		WRITE_ONCE(priv->rescue_failed, true);
		return;
	}

which then refuses devlink dev flash with -EIO for the rest of the
binding, even though the loader is still drainable.  Would a freezable
workqueue, or a PM notifier that sets MXL862XX_FLAG_WORK_STOPPED and
requeues afterwards, fit better here?  device_schedule_reprobe() already
uses system_freezable_wq for the same reason.

>  static int mxl862xx_setup(struct dsa_switch *ds)
>  {

[ ... ]

> +	priv->rescue_mode = rescue;
>  
> +	/* Software-only SerDes state, needed before anything can reach phylink,
> +	 * including a rescue-mode flash clearing rescue_mode ahead of reprobe.
> +	 */
>  	mutex_init(&priv->serdes_lock);
>  	for (i = 0; i < ARRAY_SIZE(priv->serdes_ports); i++)
>  		mxl862xx_setup_pcs(priv, &priv->serdes_ports[i],
>  				   i + MXL862XX_FIRST_SERDES_PORT);
>  
> +	if (priv->rescue_mode) {
> +		mxl862xx_setup_rescue(ds);
> +		return 0;
> +	}
> +

[Severity: Medium]

This path returns success with priv->fw_version still all zeros, since
mxl862xx_wait_ready() -- the only writer of fw_version -- never runs in
rescue mode.  Does that break phylink creation for the CPU port on some
boards?

mxl862xx_phylink_get_caps() gates the SerDes interfaces on the cached
version:

	case 10 ... 12:
	case 14 ... 16:
		if (!MXL862XX_FW_VER_MIN(priv, 1, 0, 84))
			break;
		__set_bit(PHY_INTERFACE_MODE_QSGMII, config->supported_interfaces);

With 0.0.0 the gate is always false, so ports 10-12 and 14-16 end up with
no supported_interfaces bit set at all, and ports 9/13 lose QSGMII and
10G_QXGMII.  phylink_create() rejects that outright:

net/phy/phylink.c:phylink_create() {
	if (phy_interface_empty(config->supported_interfaces)) {
		dev_err(config->dev,
			"phylink: error: empty supported_interfaces\n");
		return ERR_PTR(-EINVAL);
	...
}

and CPU ports have no unused-port fallback:

net/dsa/dsa.c:dsa_tree_setup_ports() {
		if (dsa_port_is_dsa(dp) || dsa_port_is_cpu(dp)) {
			err = dsa_port_setup(dp);
			if (err)
				goto teardown;
	...
}

So on a board whose CPU port is one of 10-12/14-16, or is 9/13 with
phy-mode qsgmii or 10g-qxgmii, probe would fail with -EINVAL and rescue
mode could never be entered.  The patch adds the rescue-mode bypass in
mxl862xx_phylink_mac_select_pcs() -- should mxl862xx_phylink_get_caps()
get the same treatment for its firmware-version gate?

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
> index 2d38885ecfdab..4ed2fd5cbca7c 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.h
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.h
> @@ -332,6 +338,16 @@ struct mxl862xx_fw_version {

[ ... ]

> + * @rescue_ready:       (rescue_mode) loader is at a clean READY and will accept
> + *                      a flash; false while rescue_heal_work is draining
> + * @rescue_failed:      (rescue_mode) the self-heal gave up or cannot run; the
> + *                      loader needs a power cycle and no flash can be accepted

[Severity: Low]

This isn't a bug, but does "the loader needs a power cycle" hold for
every producer of this flag?  mxl862xx_rescue_heal_work_fn() also sets it
after a fully successful drain, purely because the hand-off failed:

	if (device_schedule_reprobe(dev, MXL862XX_FW_REPROBE_DELAY_MS))
		WRITE_ONCE(priv->rescue_failed, true);

In that case the loader sits at a clean READY and only a driver rebind is
needed, which is what the devlink documentation added later in this
series says ("a completed drain whose reprobe could not be scheduled ...
need only a driver rebind").

A third producer is the START/ACK branch of
mxl862xx_rescue_mode_detect(), where rescue_heal_work is never queued at
all, so "the self-heal gave up or cannot run" does not describe it
either.  All three collapse into the same -EIO and "download recovery
failed" extack in mxl862xx_devlink_flash_update().  Could the kernel-doc
just say the loader cannot accept a flash, and leave the per-cause
remedies to the documentation?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1789477568.git.daniel%40makrotopia.org
