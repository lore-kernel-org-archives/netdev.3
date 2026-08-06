Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8913CE4B5
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015659; cv=none; b=rREXD4PAG91UC6P/Byt10Oo5/txEOYGngMVrYKIcJI+4Yry9yns4YCSMWnH5NdjkE6JX72AuO2+zYRZT9eWPv77q4GsVK8Sy7MLXa6dxRibegkXMNFEz6MsNwGW93BE0LNCamEwuzSv0kzvo9meAgpNDnMvt5CxHIJOwUADGeK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015659; c=relaxed/simple;
	bh=Sk4Xync+U0R8W444aDL+fxvdzWwMUKwCOPmnDU1Cxs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKwv9ZMmBut7383PtcC4ne4KMdWoacFlRoK420ZxNw4t+n3+m0UH7gcJYtaXLXzTgEgncZcYENFq5l5YYj3atvm/0AWadG6GRFb36hT45U73eO7MYcVSi8YqJDNfZISGaU+l/C6dDzd5UBPFRCAqYl+MlQY3FMsPYMVWt9GtGBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jAe5sB5G; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAe5sB5G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786015655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Df7Lh8E/1nhhFl5adt/fXKbI1jshiRH5XoIybKFRgzo=;
	b=jAe5sB5G8lC79gZFAA0VyXHye92IIULSYUFKSF+De/qNmKAc2gEXcF/3/re/ZEA8ckGNfh
	Bwm0nN6ok9AU4ZZigFF1eHcpcVwylQ6JkRZ0Nt4Eo65+K+H5ztyZK2pAnt0q3rzVzyryUq
	Np6536Iz0h4NZgdJFvjk5VPMnprnOxY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-G5HI6QazOqKPQk48ZBF21A-1; Thu,
 06 Aug 2026 07:27:32 -0400
X-MC-Unique: G5HI6QazOqKPQk48ZBF21A-1
X-Mimecast-MFC-AGG-ID: G5HI6QazOqKPQk48ZBF21A_1786015650
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CC651944A83;
	Thu,  6 Aug 2026 11:26:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.33.123])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D714B1956094;
	Thu,  6 Aug 2026 11:26:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: daniel@makrotopia.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v9 4/5] net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode
Date: Thu,  6 Aug 2026 13:26:21 +0200
Message-ID: <20260806112621.164297-1-pabeni@redhat.com>
In-Reply-To: <6ab6dd06b95c01e30cf3a7387817a53cdb5e84f9.1785728574.git.daniel@makrotopia.org>
References: <6ab6dd06b95c01e30cf3a7387817a53cdb5e84f9.1785728574.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [4]: [PATCH net-next v9 4/5] net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode ---
commit c3cc712743add1015d17df863b9f273b60dce171
Author: Daniel Golle <daniel@makrotopia.org>

net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode

This adds a clause-22 SB PDI probe at setup time that classifies whether the
switch is running firmware or sitting in its MCUboot loader, registers the
switch in a reduced "rescue mode" when only the loader answers, and adds a
background work item that drains an interrupted download one byte at a time
before devlink dev flash is allowed to recover the switch.

A few questions on the new detection and drain paths below.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> index 8caaf68c7569..94aa658a62db 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c

[ ... ]

> @@ -124,6 +166,10 @@
>  #define MXL862XX_FW_WRITE_TIMEOUT_MS	120000
>  #define MXL862XX_FW_REBOOT_DELAY_MS	5000
>  #define MXL862XX_FW_REPROBE_DELAY_MS	500
> +#define MXL862XX_RESCUE_READY_TIMEOUT_MS 1000
> +#define MXL862XX_DRAIN_POLL_MS		2000
> +/* Covers the loader's END wait, verification and the reset into READY */
> +#define MXL862XX_DRAIN_DONE_MS		15000

[ ... ]

> @@ -260,6 +306,323 @@ static struct mxl862xx_reprobe *mxl862xx_reprobe_alloc(struct device *dev)
>  	return rp;
>  }
>  
> +/* Byte-count of each chunk fed to the loader during drain. It MUST be 1: the
> + * loader only lets us observe "counter == 0", never "counter < step", so any
> + * step > 1 can subtract past zero, underflow the 32-bit counter and wedge the
> + * loader for ~2^32 more bytes (a state only a power cycle clears). Stepping by
> + * 1 walks the counter through every value and is guaranteed to land on zero
> + * whatever its (possibly odd) start. A 1-byte chunk is a path the loader
> + * already handles: the normal transfer ends with a single trailing byte for
> + * odd-sized images (see Step 6).
> + */
> +#define MXL862XX_DRAIN_CHUNK_BYTES	1

[ ... ]

> +static int mxl862xx_sb_pdi_poll_drain(struct mxl862xx_priv *priv,
> +				      unsigned long timeout_ms)
> +{
> +	int val;
> +
> +	read_poll_timeout(mxl862xx_smdio_read, val,
> +			  val < 0 || (u16)val == MXL862XX_SB_PDI_READY ||
> +			  (u16)val == 0,
> +			  50, timeout_ms * 1000, false,
> +			  priv, MXL862XX_SB_PDI_STAT);
> +	if (val < 0)
> +		return val;
> +	return (u16)val;
> +}

[Severity: Medium]
[Finding: main-3-5]
[Sources: opus-5]

Is STAT == 0 unambiguous enough to act on here?  The file header says the
loader publishes 0 both to ask for the next slice and as the "image verified
OK" verdict, and this patch encodes the latter as
MXL862XX_SB_PDI_VERIFY_OK == 0.  It is also the value the mailbox word holds
after a reset, since mxl862xx_sb_pdi_reset() only writes CTRL/ADDR/DATA.

mxl862xx_sb_pdi_poll_drain() breaks on "(u16)val == 0" and returns 0 for all
of those states, and mxl862xx_rescue_drain() returns early only on READY or a
non-zero STAT:

	stat = mxl862xx_sb_pdi_poll_drain(priv, MXL862XX_DRAIN_POLL_MS);
	...
	if (stat == MXL862XX_SB_PDI_READY)
		return 0;

	if (stat) {
		ret = mxl862xx_rescue_drain_finish(priv, chunk);
		...
	}

	/* Feed one zero byte; reset cleared the write latch. */
	...
	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
				   MXL862XX_DRAIN_CHUNK_BYTES);

So when the last outstanding byte has just been consumed and the loader has
left the receive loop publishing verdict 0, does this write another count with
nothing outstanding?  That is the case the MXL862XX_DRAIN_CHUNK_BYTES comment
describes as underflowing the loader's counter "for ~2^32 more bytes (a state
only a power cycle clears)", and it also contradicts the header rule that "a
STAT write is a command only once the loader has left the loop".

The alternative outcome looks equally unpleasant: STAT stays latched at 1,
which the next poll plus mxl862xx_rescue_drain_finish() read as
MXL862XX_SB_PDI_VERIFY_BAD and turn into -EIO, latching priv->rescue_failed
for a switch that actually finished cleanly.

The same single interpretation is applied in mxl862xx_rescue_mode_detect()'s
STAT == 0 branch, with no liveness confirmation (unlike the READY path with
its RDREG challenge), and its second call site in mxl862xx_setup() runs right
after mxl862xx_reset() has software-reset the switch:

		ret = mxl862xx_wait_ready(ds);
		if (ret) {
			/* the reset may only now have triggered rescue mode */
			rescue = mxl862xx_rescue_mode_detect(priv);

Can STAT read its reset value 0 there while the MCU is still booting, after
which the driver writes a payload word plus a bogus count and queues an
hours-long drain against a chip that is not in a receive loop at all?

> +
> +/* The loader is not asking for a chunk: it may still be programming the last
> + * one, or the counter has reached zero and it is verifying the image and
> + * resetting into READY. Wait that out -- STAT cannot tell the two apart, and
> + * guessing would mean writing END into a live receive loop. Returns 0 once the
> + * loader has left the loop, -EAGAIN if it asks for another chunk after all.
> + */
> +static int mxl862xx_rescue_drain_finish(struct mxl862xx_priv *priv, u32 chunk)
> +{
> +	struct device *dev = &priv->mdiodev->dev;
> +	int stat;
> +
> +	stat = mxl862xx_sb_pdi_poll_drain(priv, MXL862XX_DRAIN_DONE_MS);
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

[Severity: Medium]
[Finding: main-1-1]
[Sources: opus-5]

The new drain path and the existing flash path seem to disagree by about 8x on
how long the same loader step may take, and on what a lingering STAT == 1
means.

mxl862xx_sb_pdi_flush_last() gives the count 120 s to disappear and treats a
lingering 1 as the documented "image rejected" verdict:

	ret = read_poll_timeout(mxl862xx_smdio_read, val,
				val < 0 || (u16)val != (u16)data_written,
				10000, MXL862XX_FW_WRITE_TIMEOUT_MS * 1000, ...);
	...
	if ((u16)val == MXL862XX_SB_PDI_VERIFY_BAD) { ... return -EBADMSG; }

Here the budget is MXL862XX_DRAIN_POLL_MS (2 s) plus MXL862XX_DRAIN_DONE_MS
(15 s), and the same value is declared a permanent wedge.  Given that the
drain writes STAT = MXL862XX_DRAIN_CHUNK_BYTES == 1, that 1 is also
MXL862XX_SB_PDI_VERIFY_BAD, and that the file header states "the loader leaves
the count in STAT while it programs the chunk, so a lingering count does not
distinguish 'busy' from 'verdict'", can a loader that is merely slow to verify
a multi-MiB image be misclassified here?

The verdict is then sticky for the rest of the binding: mxl862xx_rescue_heal_work_fn()
does WRITE_ONCE(priv->rescue_failed, true), mxl862xx_devlink_flash_update()
answers -EIO with "download recovery failed, power cycle the switch", and
nothing ever clears rescue_failed.  Would a longer budget matching
MXL862XX_FW_WRITE_TIMEOUT_MS, or a retry rather than a latched flag, fit the
protocol better?

[ ... ]

> +void mxl862xx_rescue_heal_work_fn(struct work_struct *work)
> +{
> +	struct mxl862xx_priv *priv =
> +		container_of(work, struct mxl862xx_priv, rescue_heal_work);
> +	struct device *dev = &priv->mdiodev->dev;
> +	struct mxl862xx_reprobe *ko;
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
> +
[ ... ]
> +	mutex_lock(&priv->heal_lock);
> +	if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
> +		goto out;
> +	if (!try_module_get(THIS_MODULE))
> +		goto out;
> +	get_device(dev);
> +	ko = mxl862xx_reprobe_alloc(dev);
> +	if (!ko) {
> +		put_device(dev);
> +		module_put(THIS_MODULE);
> +		goto out;
> +	}

[Severity: Medium]
[Finding: main-3-6]
[Sources: opus-5]

After a successful drain, recovery is handed entirely to the queued reprobe
and priv->rescue_ready is never set.  What happens to the switch if
try_module_get() fails or mxl862xx_reprobe_alloc() returns NULL?

Both take "goto out" with rescue_ready == false, rescue_failed == false and no
log line, while the loader is sitting at a clean READY and would accept a
flash.  From then on devlink reports nothing:

mxl862xx_devlink_info_get()
		if (!READ_ONCE(priv->rescue_ready))
			return 0;

and every flash attempt is refused:

mxl862xx_devlink_flash_update()
	if (priv->rescue_mode && !READ_ONCE(priv->rescue_ready)) {
		NL_SET_ERR_MSG_MOD(extack,
				   "switch is recovering an interrupted download, retry shortly");
		return -EBUSY;
	}

Since nothing re-queues rescue_heal_work or re-runs
mxl862xx_rescue_mode_detect() while the driver stays bound, does a single
-ENOMEM here leave the switch unflashable until a manual unbind/rebind?  Would
setting rescue_ready on a successful drain before the reprobe is queued cover
this?

> +	queue_delayed_work(system_long_wq, &ko->work,
> +			   msecs_to_jiffies(MXL862XX_FW_REPROBE_DELAY_MS));
> +out:
> +	mutex_unlock(&priv->heal_lock);
> +}

[Severity: High]
[Finding: main-4-7]
[Sources: opus-5]

The reprobe queued here cannot be cancelled by anything in the driver:
heal_lock only makes the WORK_STOPPED test and the queueing atomic against
mxl862xx_stop_work(), and mxl862xx_host_shutdown() cancels rescue_heal_work
itself but not the delayed work it may have queued.  What happens if the heal
work wins that race and drops heal_lock just before teardown sets the flag?

For unbind it re-binds a device that was deliberately unbound.  For shutdown
the sequence looks worse:

mxl862xx_shutdown()
	dsa_switch_shutdown(ds);	/* leaves ds linked in dst->ports */
	mxl862xx_stop_work(priv);	/* too late */
	mxl862xx_host_shutdown(priv);	/* cancels only rescue_heal_work */
	...
	dev_set_drvdata(&mdiodev->dev, NULL);

500 ms later the reprobe runs device_reprobe(), which detaches first:

mxl862xx_remove()
	if (!ds)
		return;		/* drvdata was cleared, so no dsa_unregister_switch() */

devres then frees the devm-allocated priv/ds while the DSA tree still holds
dsa_ports whose dp->ds points at it, and the re-attach walks exactly those:

net/dsa/dsa.c:dsa_switch_find() {
		list_for_each_entry(dp, &dst->ports, list) {
			if (dp->ds->index != sw_index)
				continue;
			return dp->ds;
		}
}

Is that a use-after-free read of the freed dsa_switch, reached via
mxl862xx_probe() -> dsa_register_switch() -> dsa_switch_parse_of() ->
dsa_switch_find()?  A failed dsa_register_switch() after
mxl862xx_setup() queued the heal work looks able to lose the same race.

The uncancellable reprobe mechanism itself came in earlier in this series with
"net: dsa: mxl862xx: add devlink flash_update and info_get"; what this patch
adds is a second trigger that is not user-initiated and can fire tens of
minutes after probe.  Could the reprobe re-validate dev->driver before
re-binding, or be made cancellable from teardown?

> +
> +/* Detect MCUboot rescue mode over clause-22 SMDIO alone, so the caller can rule
[ ... ]
> + * Return: MXL862XX_IN_RESCUE, MXL862XX_NOT_RESCUE, -ENODEV when nothing
> + * answers, -EOPNOTSUPP for the flashless loop, -ENXIO for a READY loader whose
> + * mailbox fails the challenge, or an SMDIO bus error.
> + */

[Severity: Low]
[Finding: main-2-4]
[Sources: opus-5]

This isn't a bug, but the documented return set does not quite match the code.
The main way the challenge fails is the loader never re-arming STAT=READY, and
then mxl862xx_sb_pdi_poll_stat() returns the read_poll_timeout() result:

		rb = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_READY,
					       MXL862XX_RESCUE_READY_TIMEOUT_MS);
		...
		if (rb < 0)
			return rb;

That propagates -ETIMEDOUT, which is neither -ENXIO nor an SMDIO bus error.
-ENXIO is only reached when READY was seen but DATA still holds the marker.

The comment on mxl862xx_rescue_drain_finish() has the same mismatch: it
documents only 0 and -EAGAIN while the body also returns -EIO and propagated
SMDIO bus errors.

> +int mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv)
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
[Finding: main-1-0]
[Sources: opus-5]

The commit message says a running firmware "is left untouched":

  "a running firmware, which answers with its own non-zero status word
  (0x0003 on the firmware tested) and is left untouched"

Does that hold?  mxl862xx_sb_pdi_reset() writes CTRL/ADDR/DATA and the two
scratch writes above land in the mailbox before STAT is read, so they reach a
switch whose firmware is alive and well.

The second half of the same paragraph says -ENODEV covers only:

  "a switch that does not answer at all -- absent, unpowered, or misdescribed
  in the device tree (wrong address or bus, or a reset GPIO with inverted
  polarity)"

But the read-back compare above also returns -ENODEV for a live switch whose
SB PDI window is not at the offsets this file documents as "the OTP reset
defaults and the only layout supported here", and mxl862xx_setup() turns that
into a probe failure:

	rescue = mxl862xx_rescue_mode_detect(priv);
	if (rescue < 0) {
		dev_err(ds->dev, "switch state detection failed: %pe\n",
			ERR_PTR(rescue));
		return rescue;
	}

So a board that bound and worked before this patch would now fail to probe.
Should the presence probe only be consulted after the clause-45 path has
failed, or should the commit message describe these two behaviours?

[ ... ]

> +	/* Console loop at READY: confirm the live mailbox with the register-read
> +	 * challenge (consumes the marker from DATA and re-arms READY).
> +	 */
> +	if ((u16)stat == MXL862XX_SB_PDI_READY) {
[ ... ]
> +		if (!rb && (u16)dat != MXL862XX_SB_PDI_RDREG_MARK) {
> +			WRITE_ONCE(priv->rescue_ready, true);
> +			return MXL862XX_IN_RESCUE;
> +		}
> +		return -ENXIO;
> +	}

[Severity: Medium]
[Finding: main-1-2]
[Sources: opus-5]

The commit message presents the classification as exhaustive:

  "The first three enter rescue mode or normal operation, the last two fail
  probe cleanly with -EOPNOTSUPP and -ENODEV instead of a CRC-error storm."

Is there not a sixth outcome here?  A loader idle in the console loop at
STAT == MXL862XX_SB_PDI_READY that does not service the register-read
challenge ends up at this -ENXIO (or at the raw poll error), and
mxl862xx_setup() propagates it as a fatal probe error.

That is a switch genuinely in MCUboot rescue mode, the state this patch exists
to recover, and the driver then refuses to bind, so no devlink instance is
created and the documented devlink dev flash recovery is unreachable.  Given
that RDREG is an undocumented loader command whose reply the header describes
as coming from "loader BSS, not a chip id", should a loader that ignores it
still be treated as flashable rather than as a probe failure?

[ ... ]

> @@ -596,6 +980,21 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
>  		return ret;
>  	}
>  
> +	/* Refuse to flash while the background self-heal is still draining, and
> +	 * for good once it has given up on the loader.
> +	 */
> +	if (READ_ONCE(priv->rescue_failed)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "download recovery failed, power cycle the switch");
> +		return -EIO;
> +	}
> +
> +	if (priv->rescue_mode && !READ_ONCE(priv->rescue_ready)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "switch is recovering an interrupted download, retry shortly");
> +		return -EBUSY;
> +	}
> +

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> index 76f5a78566d9..469ba1b2a2e1 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c

[ ... ]

> @@ -548,10 +554,13 @@ int mxl862xx_smdio_write(struct mxl862xx_priv *priv, u32 addr, u16 val)
>  
>  void mxl862xx_host_init(struct mxl862xx_priv *priv)
>  {
> +	mutex_init(&priv->heal_lock);
>  	INIT_WORK(&priv->crc_err_work, mxl862xx_crc_err_work_fn);
> +	INIT_WORK(&priv->rescue_heal_work, mxl862xx_rescue_heal_work_fn);
>  }
>  
>  void mxl862xx_host_shutdown(struct mxl862xx_priv *priv)
>  {
>  	cancel_work_sync(&priv->crc_err_work);
> +	cancel_work_sync(&priv->rescue_heal_work);
>  }

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index 8634a86c4168..300eb19a344e 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.c
> @@ -674,21 +674,66 @@ static int mxl862xx_setup(struct dsa_switch *ds)
[ ... ]
> +	rescue = mxl862xx_rescue_mode_detect(priv);
> +	if (rescue < 0) {
> +		dev_err(ds->dev, "switch state detection failed: %pe\n",
> +			ERR_PTR(rescue));
> +		return rescue;
> +	}
> +
> +	if (rescue == MXL862XX_NOT_RESCUE) {
> +		ret = mxl862xx_reset(priv);
> +		if (ret)
> +			return ret;
> +
> +		ret = mxl862xx_wait_ready(ds);
> +		if (ret) {
> +			/* the reset may only now have triggered rescue mode */
> +			rescue = mxl862xx_rescue_mode_detect(priv);
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
> +
> +	priv->rescue_mode = rescue;
> +
> +	if (priv->rescue_mode) {
> +		if (priv->rescue_ready) {
> +			dev_warn(ds->dev,
> +				 "switch in MCUboot rescue mode, use devlink to flash new firmware\n");
> +		} else {
> +			/* Drain the wedged download in the background so it
> +			 * never holds the devlink lock; info and flash become
> +			 * available once ready.
> +			 */
> +			dev_warn(ds->dev,
> +				 "switch in MCUboot with an interrupted download, recovering in background\n");
> +			queue_work(system_long_wq, &priv->rescue_heal_work);
> +		}
> +		return 0;
> +	}
> +

[ ... ]

> @@ -2245,7 +2309,7 @@ static void mxl862xx_shutdown(struct mdio_device *mdiodev)
>  
>  	dsa_switch_shutdown(ds);
>  
> -	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
> +	mxl862xx_stop_work(priv);
>  	cancel_delayed_work_sync(&priv->stats_work);
>  
>  	mxl862xx_host_shutdown(priv);

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.h b/drivers/net/dsa/mxl862xx/mxl862xx.h
> index 66989280c59d..da45d24de7cf 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx.h
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx.h

[ ... ]

> +/* Stop the background workers. The flag is set under heal_lock, which the
> + * rescue self-heal also holds across its own flag test and the queueing of its
> + * reprobe, so no reprobe can slip past a teardown that has begun.
> + */
> +static inline void mxl862xx_stop_work(struct mxl862xx_priv *priv)
> +{
> +	mutex_lock(&priv->heal_lock);
> +	set_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags);
> +	mutex_unlock(&priv->heal_lock);
> +}
> +

The comment says "no reprobe can slip past a teardown that has begun", but the
mutex only orders the flag store against the heal work's flag test.  If the
heal work tested the flag first and queued the reprobe, does anything here
stop that reprobe from running after teardown completes?  See the question at
mxl862xx_rescue_heal_work_fn() above.
-- 
This is an AI-generated review.

