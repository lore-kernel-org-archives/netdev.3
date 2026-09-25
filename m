Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DC3CFF44;
	Fri, 25 Sep 2026 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790314465; cv=none; b=kGIqKx8UqP7mPLBKdFDP+WJzXF6GL+YQZom1dCcmXqzWfKGdmBIbzXCwWa50y/73jAH3/7ldeZTiGp+xuW7FgBr5hLyoK77nFXEa8OW571h7uP4/IHVW0AcIxprvn6gxDw20lg8RTmCE27CqtviPsMtiTKzpLd5b4vPgCPCD/bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790314465; c=relaxed/simple;
	bh=SBPmEYWRj7FesvnmSMCjuo+IHA5a1Kuen9nGJyHdsHE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q5OOpsoUzCGKvV2LYDHZhlotq2vMr2W6qe4TOefqIDcW8HGbL3kqxwwC+IUEzKnGNB35psLZ25GSwpZByVeAHxr4UBbeHUoGI79bDXLQKk8u2WNkkFaL90olY57qDzvydA1ZVxuE5+vmec9PzLQSENoK7a97xlkKcSh4gyBQ3ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQGePuXs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQGePuXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D641F000FF;
	Fri, 25 Sep 2026 05:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790314463;
	bh=OlsLchOVxsGXMo2CJJd9paaBhJbScpiX2qYT/uYAl1w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BQGePuXsTuIF+qAfWC32j9gxhVjRZ3GGQdE2DBrsfjYV8Usq2aLtfGmOz3Rvt29fo
	 6FVmDwuUpM2k1yF5gVo7QV6uYqmpuSRuTdLy1JJjYxYFH+GQ+QytKcS3+wicY7ALT8
	 tvN917OuJKsdb9AnNF7OKT8Uk8K/wyxVxc6mNxCw0qirpkqAePxlyTctdhMPBkuOl+
	 WKvxDDib9B+QpSrJ1YO9iI8atudmpr3b2Fk3oSjopIo0pQed3w0sW5EmlKSbHjJxxy
	 Bhkvlv+gIAzBjRycvxq4OF7kXQLXFKaAGeOG0ed7msL5c7I0al9QrMily4UJo4sy9N
	 dQb75LntNAI/g==
Subject: Re: [PATCH net-next v17 5/6] net: dsa: mxl862xx: recover switch stuck
 in MCUboot rescue mode
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Fri, 25 Sep 2026 05:34:22 +0000
Message-ID: <179031446208.2160803.5824341179821498261@kernel.org>
In-Reply-To: =?utf-8?q?=3Cf5e7d88800d34d3ff8462039409d9b3e6b645bc4=2E1790130?=
 =?utf-8?q?482=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cf5e7d88800d34d3ff8462039409d9b3e6b645bc4=2E17901304?=
 =?utf-8?q?82=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 6

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] mxl862xx_setup() now runs mxl862xx_rescue_mode_detect(priv,
  false) on every probe, before any clause-45 access.
- [Medium] mxl862xx_rescue_mode_detect(priv, true) can never return
  MXL862XX_NOT_RESCUE.
- [Medium] mxl862xx_rescue_drain() starts chunk at 0 on every run (line
  379).
- [Medium] In rescue mode the CPU port and conduit are set up, so DSA's
  conduit ethtool override stays installed.
- [Low] At probe time, rescue_failed can only be set by the START/ACK
  branch of mxl862xx_rescue_mode_detect().
- [Low] The patch made mxl862xx_port_mdb_add() also return 0 on -ENODEV
  when READ_ONCE(priv->rescue_mode) is set.
- [Low] The @flags kernel-doc in struct mxl862xx_priv still says
  MXL862XX_FLAG_WORK_STOPPED "is set before cancelling stats_work to…
- [Low] The file header says the loader leaves the host's byte count in
  STAT while it programs a chunk.
- [Low] In rescue mode, mxl862xx_devlink_info_get() reports the zeroed
  fw_version cache ("0.0.0") with devlink_info_version_stored_put() as…
- [Low] mxl862xx_setup_rescue() queues rescue_heal_work on
  system_long_wq, which is not freezable.

--

net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode

At setup, this patch detects the MCUboot loader over clause-22 SB PDI,
before any clause-45 access. If the loader is found, the switch is
registered with only its CPU port so devlink can reflash it, and devlink
dev info reports 0.0.0. A background work item drains an interrupted
download one byte at a time and then schedules a re-probe.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> index 7a506d110c8da..0761132120b1a 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c

[ ... ]

> @@ -218,6 +268,379 @@ static void mxl862xx_flash_notify(struct devlink *dl, const char *status,

[ ... ]

> +static int mxl862xx_sb_pdi_poll_drain(struct mxl862xx_priv *priv,
> +				      unsigned long sleep_us,
> +				      unsigned long timeout_ms)
> +{
> +	int val;
> +
> +	read_poll_timeout(mxl862xx_smdio_read, val,
> +			  val < 0 || (u16)val == MXL862XX_SB_PDI_READY ||
> +			  (u16)val == 0 ||
> +			  test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags),
> +			  sleep_us, timeout_ms * 1000, false,
> +			  priv, MXL862XX_SB_PDI_STAT);
> +	if (val < 0)
> +		return val;
> +	if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
> +		return -ECANCELED;
> +	return (u16)val;
> +}

[Severity: Low]
This isn't a bug, but the @flags kernel-doc in struct mxl862xx_priv still
says MXL862XX_FLAG_WORK_STOPPED "is set before cancelling stats_work to
prevent rescheduling during teardown".

The flag now has a second job. It cancels the drain here and in
mxl862xx_rescue_drain(), and it also skips the reprobe hand-off in
mxl862xx_rescue_heal_work_fn(). Unbind and shutdown rely on it to stop a
long drain.

Should the kernel-doc mention this as well?

[ ... ]

> +static int mxl862xx_rescue_drain_finish(struct mxl862xx_priv *priv, u32 chunk)
> +{

[ ... ]

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
Can the "firmware booted while draining" branch be reached when
chunk == 0?

mxl862xx_rescue_drain() starts with chunk = 0 on every run. It does not
count the 1-byte slice-advance that mxl862xx_rescue_mode_detect() already
sent, or the settle wait.

Suppose WSP firmware boots before the worker feeds its first byte. That
can happen if detect's advance completed the image, or on the settle path
after mxl862xx_wait_ready() failed. Wouldn't this then poll for 300 s,
return -EIO and set rescue_failed?

After that there is no reprobe, and rescue_mode stays true, so
mxl862xx_api_wrap() returns -ENODEV for every command. In rescue mode,
mxl862xx_port_setup() also returned before mxl862xx_port_state(false) and
the single-port bridge setup.

Would the running firmware then forward traffic with its default setup
while the driver treats the switch as an inert loader, until someone
rebinds it by hand?

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

[Severity: Low]
The file header says the loader keeps the host's byte count in STAT while
it programs a chunk. For the final slice, mxl862xx_sb_pdi_flush_last()
writes data_written, which can be any value from 1 to 65520. The values
0xc33c, 0xc55c, 0xf48f and 0xf490 all fall in that range.

Can detection misread STAT if probe runs while an interrupted host's
final chunk of one of these sizes is still being programmed or verified?
These checks run before any settle wait:

  0xc33c: probe fails with -EOPNOTSUPP
  0xc55c: the RDREG challenge goes to a loader outside its console loop,
          and probe fails with -ENXIO
  0xf48f/0xf490: rescue_failed is set, although the loader would finish
                 on its own

[ ... ]

> +	if ((u16)stat == MXL862XX_SB_PDI_START ||
> +	    (u16)stat == MXL862XX_SB_PDI_START + 1) {
> +		WRITE_ONCE(priv->rescue_failed, true);
> +		return MXL862XX_IN_RESCUE;
> +	}

[Severity: Low]
At probe time this is the only place that sets rescue_failed, and no
drain has run yet. rescue_heal_work is only queued after the
rescue_failed check in mxl862xx_setup_rescue().

Even so, mxl862xx_setup_rescue() logs "download recovery gave up", and
mxl862xx_devlink_flash_update() returns the extack "download recovery
failed".

Could these messages say that the download handshake is stuck, rather
than pointing at a recovery that never ran?

[ ... ]

> @@ -486,6 +911,25 @@ int mxl862xx_devlink_info_get(struct dsa_switch *ds,
>  	char buf[16];
>  	int ret;
>  
> +	/* No chip-id/revision in MCUboot (needs the firmware MMD mailbox). The
> +	 * fw version doubles as the "ready to flash" signal: report it only
> +	 * once the loader is at a clean READY, nothing while still draining.
> +	 */
> +	if (READ_ONCE(priv->rescue_mode)) {
> +		if (!READ_ONCE(priv->rescue_ready))
> +			return 0;
> +
> +		snprintf(buf, sizeof(buf), "%u.%u.%u",
> +			 priv->fw_version.major, priv->fw_version.minor,
> +			 priv->fw_version.revision);
> +		ret = devlink_info_version_running_put(req,
> +				DEVLINK_INFO_VERSION_GENERIC_FW, buf);
> +		if (ret)
> +			return ret;
> +		return devlink_info_version_stored_put(req,
> +				DEVLINK_INFO_VERSION_GENERIC_FW, buf);
> +	}

[Severity: Low]
Documentation/networking/devlink/devlink-info.rst defines the stored group
as the versions in device flash. It also says a device that cannot keep
those versions accurate must not report them.

The file header says MCUboot is also entered through the sticky rescue
bit, so the flash may still hold a valid image with a real version.

Is it intended to report stored 0.0.0 here? That value means "ready to
flash" rather than describing what is in flash.

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> index 4b3956a518cfe..694c22d2dd094 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c

[ ... ]

> @@ -347,6 +348,11 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
>  		goto out;
>  	}
>  
> +	if (priv->rescue_mode) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +

[Severity: Medium]
In rescue mode the CPU port and the conduit are still set up, so DSA's
conduit ethtool override stays in place. ETHTOOL_GSTATS needs no
CAP_NET_ADMIN, so any local user can reach this path:

ethtool -S <conduit>
  dsa_conduit_get_ethtool_stats()
    dsa_conduit_append_port_stats()
      mxl862xx_get_ethtool_stats(ds, cpu_port)
        mxl862xx_read_rmon()
          mxl862xx_api_wrap() returns -ENODEV here

mxl862xx_get_ethtool_stats() then does this, with no ratelimit:

	ret = mxl862xx_read_rmon(ds, port, &cnt);
	if (ret) {
		dev_err(ds->dev, "failed to read RMON stats on port %d\n", port);
		return;
	}

Rescue mode can last indefinitely: a stuck handshake, a long drain, or a
loader waiting for a flash. Can an unprivileged user flood the kernel log
this way?

port_enable/disable, stp_state_set and mdb_add/del now have rescue_mode
guards. Should the stats callbacks get one too?

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index 33a7cdb8edd31..911114579f100 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
> @@ -667,27 +667,85 @@ static void mxl862xx_free_bridge(struct dsa_switch *ds,
>  	priv->bridges[bridge->num] = 0;
>  }
>  
> +static void mxl862xx_setup_rescue(struct dsa_switch *ds)
> +{

[ ... ]

> +	/* Drain the wedged download in the background so it never holds the
> +	 * devlink lock; info and flash become available once ready.
> +	 */
> +	dev_warn(ds->dev,
> +		 "switch in MCUboot with an interrupted download, recovering in background\n");
> +	queue_work(system_long_wq, &priv->rescue_heal_work);
> +}

[Severity: Low]
system_long_wq is not freezable. The driver also has no PM callback that
sets MXL862XX_FLAG_WORK_STOPPED or cancels this work.

Can a drain that runs for tens of minutes keep accessing the MDIO bus
while the bus controller suspends? Any bus error in that window makes
mxl862xx_rescue_heal_work_fn() set rescue_failed with no retry. After
that, devlink flash returns -EIO until the driver is rebound.

device_schedule_reprobe() uses system_freezable_wq. Would a freezable
workqueue fit better here as well?

>  static int mxl862xx_setup(struct dsa_switch *ds)
>  {
>  	struct mxl862xx_priv *priv = ds->priv;
>  	int n_user_ports = 0, max_vlans;
>  	int ingress_finals, vid_rules;
>  	struct dsa_port *dp;
> -	int ret, i;
> +	int ret, i, rescue;
>  
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
> +		dev_err(ds->dev, "switch state detection failed: %pe\n",
> +			ERR_PTR(rescue));
> +		return rescue;
> +	}

[Severity: High]
Can this break probe on switches that worked before this patch?

Previously the driver only used clause-45 accesses, so a switch with
working firmware probed even when SB PDI was unusable. Now any negative
return from mxl862xx_rescue_mode_detect() fails setup before
mxl862xx_reset() or mxl862xx_wait_ready() is tried.

These cases return an error here:

- The host MDIO bus has no clause-22 ops. In that case
  mxl862xx_smdio_write() -> __mdiobus_write() returns -EOPNOTSUPP because
  bus->write is NULL. For example, mvmdio in BUS_TYPE_XSMI mode sets only
  read_c45/write_c45.

- The ADDR/DATA scratch readback does not match. The kernel-doc says this
  includes "one whose SB PDI window is not at the offsets above". The file
  header says the 0xe1xx offsets are only the OTP reset defaults.

- STAT reads 0xc33c (-EOPNOTSUPP), or it reads 0xc55c and the marker is
  left untouched (-ENXIO).

Every normal boot also writes to the SB PDI mailbox now. If STAT reads 0,
detect sends a 1-byte download chunk and returns MXL862XX_IN_RESCUE
whatever follows. That relies on 0 being "the one value a running
firmware never holds". Is that guaranteed?

Would it be safer to fall back to the clause-45 path when detection
fails, instead of failing probe?

The commit message only says "Detect the loader over SB PDI at setup,
ahead of any clause-45 access". The v10 and v16 changelog notes say the
message was extended to cover the scratch writes to a running firmware,
the -ENODEV/-ENXIO outcomes and the handshake outcome. That text is not
in the final commit message. Could it be added back?

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

[Severity: Medium]
Can mxl862xx_rescue_mode_detect(priv, true) ever return
MXL862XX_NOT_RESCUE? With settle set, each branch returns either an error
or MXL862XX_IN_RESCUE:

  DL_READY: -EOPNOTSUPP
  READY: IN_RESCUE or -ENXIO
  START/ACK: IN_RESCUE
  other non-zero: the !settle return is skipped. The poll then returns
                  IN_RESCUE for READY or non-zero, or falls into the
                  STAT == 0 path, which also returns IN_RESCUE

If so, this check is dead code, and the -ETIMEDOUT from
mxl862xx_wait_ready() is always dropped.

Take a firmware that is present but fails mxl862xx_wait_ready(): for
example, it boots slower than the timeout, reports iv_major == 0, or
fails CFGGET. It holds a stable non-zero STAT word. Wouldn't it be
classified as rescue, bound with all user ports unused, and have
rescue_heal_work queued?

The drain then calls mxl862xx_rescue_drain_finish(priv, 0), waits 300 s,
returns -EIO and sets rescue_failed. Before this patch, probe simply
failed with -ETIMEDOUT.

> +		}
> +	}

[ ... ]

> @@ -1603,7 +1677,8 @@ static int mxl862xx_port_mdb_add(struct dsa_switch *ds, int port,
>  	 * rebuilds the configuration. See mxl862xx_port_mdb_del().
>  	 */
>  	if ((ret == -EBUSY && priv->block_host) ||
> -	    (ret == -ENODEV && priv->skip_teardown))
> +	    (ret == -ENODEV &&
> +	     (priv->skip_teardown || READ_ONCE(priv->rescue_mode))))
>  		return 0;
>  	if (ret)
>  		return ret;

[Severity: Low]
This isn't a bug, but the comment above still mentions only the flash
cases ("A flash blocks the API (-EBUSY) and its teardown drops the MAC
table (-ENODEV)"). The comment in mxl862xx_port_mdb_del() was updated to
say "its teardown or MCUboot drops the MAC table". Should this comment
be updated to match?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790130482.git.daniel%40makrotopia.org
