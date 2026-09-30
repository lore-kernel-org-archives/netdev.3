Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59008393DC8;
	Wed, 30 Sep 2026 03:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790740140; cv=none; b=u2pgv75HyyiFKq3/m0nuIz/14PxEzH8CXqvKpDpGR53LG0tGmjqeaBCem1dBdrSBwUyuWVNP+4XGuH/hpTr+GnDgeSlmKf9ulOwVYrLAlje1Scrm2L6bi5OEbyOnL4iNRNYmiuGeiBwJQSQ0t9ExJjMUv2FVsp6zlLhVLgbbm6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790740140; c=relaxed/simple;
	bh=/9qpDu0P3jj7HLfFC4jYcIUtttLwEQUtAOVLV5N9Ozc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qpfyKs/6RJXBLvU7N919NMpiv21blh6uDeYBMN4RWRaIxWzN+fyp/oRAKeqeU1T7HuFOrTufa7q5Z/UmnV1ykp79fiHb9oYCm2jCVOCHK2fTRZFPeF0q1jeQ5Yxoz54dLyM3+eGrFva7x0VSG78REqpeUZK1zJpMXAiXDmK1vz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEnLJXpP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEnLJXpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D011F000FF;
	Wed, 30 Sep 2026 03:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790740134;
	bh=uevZBHTyTiY8c7E2Eidyu1jKyUuQnMBh9gw2yX8D8S8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WEnLJXpPHGEETly8lKzWjRhdW8UOaJim7hzg4L/d9jhTqehybx7lQKzUnPqaoY6Iu
	 jOU7XzLyUtaELHT2XbkMzUqv1uP2GXHbKrdWCHB08ZpQJC3IOpiaCmiRQ1t6fB6Abu
	 a8foArUr4NN+rzhcZS8bM1uviLUtI61ZaGPBpeljPgT1CIWl2D1UWtdmYKpVJwlbBq
	 BEzTSaNDKLlZc0NmWr03+Rwcvx5FGP+GGX9vcE0OxW0hxx6HlnulZgnesWexVfhT3/
	 yeBInI7KdwsOw1ewB3qcofDZTl2j7BBbxQNDNgWU10N4Y0J+6Ic1dtn1aEV3Fba/PE
	 34Hr3wYnLPnPA==
Subject: Re: [PATCH net-next v18 5/6] net: dsa: mxl862xx: recover switch stuck
 in MCUboot rescue mode
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Wed, 30 Sep 2026 03:48:52 +0000
Message-ID: <179074013268.434549.5448699370361714190@kernel.org>
In-Reply-To: =?utf-8?q?=3Cfecb0bd175621d6967f725f0e0405341d600e8e8=2E1790426?=
 =?utf-8?q?599=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cfecb0bd175621d6967f725f0e0405341d600e8e8=2E17904265?=
 =?utf-8?q?99=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mxl862xx_setup() now runs mxl862xx_rescue_mode_detect(priv,
  false) before any clause-45 access and returns any negative result…
- [Medium] mxl862xx_rescue_drain() takes STAT==0 to mean "feed the next
  byte" even when it is the loader's post-verify "image good" verdict.
- [Medium] mxl862xx_setup_rescue() queues rescue_heal_work on the non-
  freezable system_long_wq.
- [Low] In the READY branch of mxl862xx_rescue_mode_detect(), `if (rb ==
  -ETIMEDOUT) rb = -ENXIO;` also rewrites a real MDIO bus -ETIMEDOUT.
- [Low] While MCUboot programs or verifies a slice, STAT holds the host's
  byte count.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the patch
  rewrites the surrounding CRC handling.

--

net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode

At setup, and before any clause-45 access, this patch detects the MCUboot
loader over the clause-22 SB PDI mailbox. In rescue mode it registers the
switch without user ports, so devlink can still reflash it. A background
work item drains a download interrupted mid-payload one byte at a time and
then reprobes; CRC error handling is also changed so quiet commands do not
arm the CRC-error work.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> index 9a3db7d43c733..236dc79460f71 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c

[ ... ]

> @@ -218,6 +268,384 @@ static void mxl862xx_flash_notify(struct devlink *dl, const char *status,

[ ... ]

> +static int mxl862xx_rescue_drain_finish(struct mxl862xx_priv *priv, u32 chunk)
> +{

[ ... ]

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
> +
> +	return -EAGAIN;
> +}

[ ... ]

> +static int mxl862xx_rescue_drain(struct mxl862xx_priv *priv)
> +{

[ ... ]

> +	while (chunk < max_chunks) {
> +		/* Teardown can interrupt this long drain. */
> +		if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
> +			return -ECANCELED;
> +
> +		stat = mxl862xx_sb_pdi_poll_drain(priv, MXL862XX_SB_PDI_POLL_US,
> +						  MXL862XX_SB_PDI_STEP_MS);
> +		if (stat < 0)
> +			return stat;
> +		if (stat == MXL862XX_SB_PDI_READY)
> +			return 0;
> +
> +		if (stat) {
> +			ret = mxl862xx_rescue_drain_finish(priv, chunk);
> +			if (ret != -EAGAIN)
> +				return ret;
> +		}
> +
> +		/* Feed one zero byte; reset cleared the write latch. */
> +		ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
> +					   MXL862XX_SB_PDI_CTRL_WR);
> +		if (ret < 0)
> +			return ret;
> +		ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA, 0x0000);
> +		if (ret < 0)
> +			return ret;
> +		ret = mxl862xx_sb_pdi_reset(priv);
> +		if (ret < 0)
> +			return ret;
> +		ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_STAT,
> +					   MXL862XX_DRAIN_CHUNK_BYTES);
> +		if (ret < 0)
> +			return ret;
> +		chunk++;

[Severity: Medium]

Can this loop turn a bootable image into a permanent rescue_failed state?

STAT == 0 is also the loader's "image verified" verdict. The comment on
mxl862xx_sb_pdi_poll_drain() says one more chunk after a verdict cannot
underflow anything. In that case, though, the drain writes STAT = 1 into a
loader that has already left its receive loop.

Suppose the loader then boots the image and the firmware does not
overwrite STAT. The next poll times out still holding 1, and
mxl862xx_rescue_drain_finish() with chunk > 0 matches this check:

    if (stat == MXL862XX_SB_PDI_VERIFY_BAD) {
        ...
        return -EIO;
    }

That is because MXL862XX_SB_PDI_VERIFY_BAD and MXL862XX_DRAIN_CHUNK_BYTES
are both 1. mxl862xx_rescue_heal_work_fn() then sets rescue_failed and
never schedules the reprobe. The commit message relies on that reprobe to
pick up a bootable image.

A related case: the 1-byte slice-advance in mxl862xx_rescue_mode_detect()
may feed the last outstanding byte, and the image may boot before the heal
work's first poll. The drain then sees a non-zero firmware status word
with chunk == 0. mxl862xx_rescue_drain_finish() waits out the 300 s erase
window and returns -EIO with "loader still busy after the erase window".

The "firmware booted while draining" branch cannot be reached in that
case, because chunk does not count the byte that detect already fed.

Should either path end in a reprobe instead of rescue_failed?

[ ... ]

> +int mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv, bool settle)
> +{

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

Can the byte count of a slice still being programmed match one of these
magic values?

While the loader programs or verifies a slice, STAT holds the count the
host wrote. mxl862xx_sb_pdi_flush_last() writes a final count anywhere
from 1 to 65520. That range includes 0xc33c (49980), 0xc55c (50524),
0xf48f (62607) and 0xf490 (62608).

These checks run on the first STAT read, before the settle logic. Probe
could run while such a final slice is still being processed, for example
after a fast host reboot mid-flash. Depending on the count:

  - 0xc33c fails probe with -EOPNOTSUPP
  - 0xc55c starts the register-read challenge and writes 0xe2c0 into
    STAT
  - 0xf48f/0xf490 set rescue_failed permanently

Could the loader get one step to publish its next state before these
values are treated as terminal?

> +
> +	/* Console loop at READY: confirm the live mailbox with the register-read
> +	 * challenge (consumes the marker from DATA and re-arms READY).
> +	 */
> +	if ((u16)stat == MXL862XX_SB_PDI_READY) {

[ ... ]

> +		rb = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_READY,
> +					       MXL862XX_SB_PDI_STEP_MS);
> +		dat = mxl862xx_smdio_read(priv, MXL862XX_SB_PDI_DATA);
> +		ret = mxl862xx_sb_pdi_reset(priv);
> +		/* Never re-arming READY fails the challenge like any other
> +		 * unserviced command; report it as such rather than as a bus
> +		 * timeout the bus never saw.
> +		 */
> +		if (rb == -ETIMEDOUT)
> +			rb = -ENXIO;
> +		if (rb < 0)
> +			return rb;

[Severity: Low]

Does this also rewrite a real MDIO bus timeout?

mxl862xx_sb_pdi_poll_stat() returns the raw mxl862xx_smdio_read() error
through the same return value as the poll timeout:

    if (val < 0)
        return val;
    return ret;

Some MDIO controllers return -ETIMEDOUT themselves, for example
mtk_mdio_busy_wait() in mtk_eth_soc. A bus failure during the challenge
would then be reported as -ENXIO. The kernel-doc reserves -ENXIO for a
READY loader that fails the challenge and lists the SMDIO bus error
separately.

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> index 4b3956a518cfe..6d9ff283969ab 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c

[ ... ]

> @@ -492,6 +494,15 @@ int mxl862xx_api_wrap(struct mxl862xx_priv *priv, u16 cmd, void *_data,
>  	dev_dbg(&priv->mdiodev->dev, "RET %d DATA %*ph\n", ret, size, data);
>  
>  out:
> +	/* A quiet command is expected to go unanswered by a switch still
> +	 * booting or sitting in its loader, so it does not arm the shutdown.
> +	 */
> +	if (ret == -EBADMSG) {
> +		if (!quiet &&
> +		    !test_and_set_bit(MXL862XX_FLAG_CRC_ERR, &priv->flags))
> +			schedule_work(&priv->crc_err_work);
> +		ret = -EIO;
> +	}

[Severity: Medium]

This is a pre-existing issue and was not introduced by this patch, but it
is relevant since the CRC handling is being reworked here.

mxl862xx_set_data(), mxl862xx_get_data() and mxl862xx_rst_data() return
the raw result of mxl862xx_issue_cmd():

    return mxl862xx_issue_cmd(priv, cmd,
                              MXL862XX_MMD_REG_DATA_MAX_SIZE * sizeof(u16));

Only mxl862xx_send_cmd() maps MXL862XX_FW_CRC6_ERR (-1024) and
MXL862XX_FW_CRC16_ERR (-1023) to -EBADMSG. A firmware-reported CRC failure
on one of the buffer commands during a multi-batch transfer therefore
skips this block. mxl862xx_api_wrap() returns -1024 or -1023 to its DSA
callers, and crc_err_work is never armed.

A local CRC-6 mismatch from these helpers is handled, since
mxl862xx_issue_cmd() now returns -EBADMSG.

Should the firmware CRC codes be mapped here as well?

>  	mutex_unlock(&priv->mdiodev->bus->mdio_lock);
>  
>  	return ret;

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx.c b/drivers/net/dsa/mxl862xx/mxl862xx.c
> index 8f8bd519de987..f16e3e33a0464 100644
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

[Severity: Medium]

What happens to this drain across system suspend?

system_long_wq is not freezable and the driver has no PM callbacks.
MXL862XX_FLAG_WORK_STOPPED is only set on teardown and flash. So the drain
keeps making SMDIO accesses for what can be tens of minutes, including
through a suspend.

If the host MDIO controller is suspended or clock-gated during that time,
the SMDIO error ends mxl862xx_rescue_drain().
mxl862xx_rescue_heal_work_fn() then makes the failure permanent:

    dev_err(dev, "flash: download recovery failed: %pe\n",
            ERR_PTR(ret));
    WRITE_ONCE(priv->rescue_failed, true);
    return;

The loader may also be left between the DATA write and the STAT count
write. From then on, devlink dev flash returns -EIO until a manual rebind.

Would a freezable workqueue, or pausing the drain across suspend, avoid
this?

> +
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
> +		dev_err(ds->dev, "switch state detection failed: %pe\n",
> +			ERR_PTR(rescue));
> +		return rescue;
> +	}

[Severity: Medium]

Can this stop a switch with working firmware from probing?

Before this patch, probe only needed clause-45, and SB PDI was only
touched during a devlink flash. Now any error from
mxl862xx_rescue_mode_detect() fails probe, and
mxl862xx_reset()/mxl862xx_wait_ready() is never tried.

A few cases where that seems possible:

  - on a host MDIO bus without clause-22 accessors, __mdiobus_write()
    returns -EOPNOTSUPP, so the first mxl862xx_sb_pdi_reset() fails
  - a switch whose OTP moves the SB PDI window away from 0xe100..0xe103
    gets -ENODEV, and the scratch writes land in whatever sits at those
    offsets
  - a running firmware whose status word happens to be 0xc55c gets
    -ENXIO (the READY branch comment says it "looks exactly like
    this"), and one at 0xc33c gets -EOPNOTSUPP

The commit message says:

  "or the switch is absent or has its SB PDI window elsewhere (-ENODEV)"

It does not mention that such switches, and switches on C45-only buses,
bound and forwarded before this change.

Would falling back to the clause-45 path on detection errors keep the old
behaviour for these setups?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790426599.git.daniel%40makrotopia.org
