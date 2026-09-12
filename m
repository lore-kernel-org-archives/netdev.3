Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662062BCF7F;
	Sat, 12 Sep 2026 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789172946; cv=none; b=m+iI8fbn3RMhH4sCbx/bX8qrv3rfllq1fXskXqODTwGftSVo3yUEw5O+NvCLZxYCqlQq3mNi9oCYL7Xw+t2Phhvwi73jrESfOTOfIoKI/dXiShWAj5y9ldI6eyUVms2EcsTh+IFPbByRC0JNeduitadR8I0+p4af4c7SHHiBatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789172946; c=relaxed/simple;
	bh=G3Pi6UhKBF0fIpwIX35B8iV4CClZQCcFqfjIPOs5IyU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iOBeIS5SKZJtBiUGIllLzWG3lnstTcHP6C1kdmwf2Zk7pBL8v7AMe9ye/2BfOIT2FZYQvUpGB84Ir7r4swFcA20LN5gLWDUvRR3XGIL/8LsiMZwOc+DrgRA/i1BoJOJme4cMNJmOgNnUn9r2hZBEWu+vuhLJGwT+xZmH/aVSXOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiqYeQD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiqYeQD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE231F00898;
	Sat, 12 Sep 2026 00:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789172939;
	bh=bNuGpLdNUIqdLPTJ8MiJBre87z3YX17baMPKrMx/PFI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZiqYeQD8ZHPpAz5tznOf4GuS26kOFAT7Mp5prq0BgutT3mQioVClfdTDqoalsU5c5
	 4/V26rIWI1IwD5ZKHOZX4T3KZuuXWfT/3Njb8Cj9/iHvJ4Bu7Emls6453rgg7Sc661
	 vasQREjLZQV9LYTQotFOLZQiAQUoP92/HyKhFBpRyDea3Cow5YPIhBkWlx3kXFi8w+
	 y+UCTlsukLLQxpK/kr7JsLAounAuFoCt3e7Y0hkcohGoGAreOfgKMReCazxukgXgWF
	 wJBUVn2NTqBNNnFlNYqFaKJ6PPXPnM7f1WgqiQjf68fS25goPC0Nhp5bkLbKqZQ4X4
	 ktNK/h/4jo7wg==
Subject: Re: [PATCH net-next v14 5/6] net: dsa: mxl862xx: recover switch stuck
 in MCUboot rescue mode
From: netdev-bot+sashiko@kernel.org
To: daniel@makrotopia.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Date: Sat, 12 Sep 2026 00:28:57 +0000
Message-ID: <178917293786.219967.6720618074821278877@kernel.org>
In-Reply-To: =?utf-8?q?=3Cd86b8833a198030c39dce8e4d4b20a2e47f75573=2E1788976?=
 =?utf-8?q?064=2Egit=2Edaniel=40makrotopia=2Eorg=3E?=
References: =?utf-8?q?=3Cd86b8833a198030c39dce8e4d4b20a2e47f75573=2E17889760?=
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] The new `rescue_heal_work` drain can block driver unbind and
  system shutdown for ~17 s: `mxl862xx_rescue_drain()` tests…
- [Medium] `mxl862xx_rescue_mode_detect()` recognises only READY
  (0xc55c), DL_READY (0xc33c) and 0; every other non-zero STAT is…
- [Low] `priv->rescue_mode` is cleared as a plain store under
  `priv->mdiodev->bus->mdio_lock` in `mxl862xx_devlink_flash_update()`,…

--

net: dsa: mxl862xx: recover switch stuck in MCUboot rescue mode

This adds probe-time detection of a switch left in its MCUboot loader over
the clause-22 SMDIO mailbox, registers the switch in a reduced "rescue
mode" so devlink stays usable, and drains an interrupted download back to a
clean loader state from a background work item.

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> index e8913954b2bae..042a4eee6af81 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-fw.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-fw.c

[ ... ]

> @@ -218,6 +265,338 @@ static void mxl862xx_flash_notify(struct devlink *dl, const char *status,
>  	devlink_flash_update_status_notify(dl, status, NULL, done, total);
>  }
>  

[ ... ]

> +/* The loader is not asking for a chunk: it may still be programming the last
> + * one, or the counter has reached zero and it is verifying the image and
> + * resetting into READY. Wait that out -- STAT cannot tell the two apart, and
> + * guessing would mean writing END into a live receive loop.
> + *
> + * Return: 0 once the loader has left the loop, -EAGAIN if it asks for another
> + * chunk after all, -EIO for a loader still holding the count when the verify
> + * window expires, or an SMDIO bus error.
> + */
> +static int mxl862xx_rescue_drain_finish(struct mxl862xx_priv *priv, u32 chunk)
> +{
> +	struct device *dev = &priv->mdiodev->dev;
> +	int stat;
> +
> +	stat = mxl862xx_sb_pdi_poll_drain(priv, MXL862XX_SB_PDI_VERIFY_MS);

[ ... ]

> +static int mxl862xx_rescue_drain(struct mxl862xx_priv *priv)
> +{
> +	struct device *dev = &priv->mdiodev->dev;
> +	/* Bound: twice the loader's 16 MiB image cap, one byte per chunk. */
> +	u32 max_chunks = 2u * (16u << 20) / MXL862XX_DRAIN_CHUNK_BYTES;
> +	u32 chunk = 0;
> +	int ret, stat;
> +
> +	while (chunk < max_chunks) {
> +		/* Teardown can interrupt this long drain. */
> +		if (test_bit(MXL862XX_FLAG_WORK_STOPPED, &priv->flags))
> +			return -ECANCELED;
> +
> +		stat = mxl862xx_sb_pdi_poll_drain(priv, MXL862XX_SB_PDI_STEP_MS);
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

[Severity: Medium]
The MXL862XX_FLAG_WORK_STOPPED test only runs at the top of each chunk
iteration, but neither poll that follows it re-tests the flag.

mxl862xx_sb_pdi_poll_drain() sleeps up to MXL862XX_SB_PDI_STEP_MS (2000 ms)
and, when STAT still holds a count, mxl862xx_rescue_drain_finish() sleeps up
to MXL862XX_SB_PDI_VERIFY_MS (15000 ms) on top of that, with the stop flag
in neither poll condition.

The join point is synchronous:

drivers/net/dsa/mxl862xx/mxl862xx-host.c:mxl862xx_host_shutdown() {
	cancel_work_sync(&priv->crc_err_work);
	cancel_work_sync(&priv->rescue_heal_work);
}

Can this stall driver unbind and, via mxl862xx_shutdown(), reboot and
poweroff for roughly 17 s whenever the switch is in the wedged-download
state that rescue_heal_work exists to handle?

Would it be reasonable to fold the stop flag into the poll conditions of
mxl862xx_sb_pdi_poll_drain() so the wait aborts as soon as teardown asks
for it?

[ ... ]

> +/* Detect MCUboot rescue mode over clause-22 SMDIO alone, so the caller can rule
> + * the loader out before any C45 API request (which spews CRC errors when no WSP
> + * firmware answers). A scratch write to ADDR/DATA must latch or the chip is
> + * absent (-ENODEV); the mailbox is reset first, or a transfer interrupted with
> + * CTRL=WR would take that write as a payload word instead of latching it. STAT
> + * then classifies the state, poked destructively only when 0, the one value a
> + * running firmware never holds:
> + *
> + *  - 0xc33c: flashless loop; recognised but not supported here.
> + *  - 0xc55c: console loop, if the register-read challenge is serviced.
> + *  - other non-zero: running firmware, left unpoked.
> + *  - 0: wedged receive loop; the 1-byte slice-advance then says whether it
> + *    still needs draining or has just finished.

[ ... ]

> +int mxl862xx_rescue_mode_detect(struct mxl862xx_priv *priv)
> +{

[ ... ]

> +	/* Any other non-zero value is a running firmware, not a loader. */
> +	if (stat)
> +		return MXL862XX_NOT_RESCUE;

[Severity: Medium]
STAT is also where the download handshake lives, and it is host-writable.
Are the loader's handshake wait states covered by this catch-all?

mxl862xx_sb_pdi_reset() writes CTRL, ADDR and DATA only, so a value already
in STAT survives it:

drivers/net/dsa/mxl862xx/mxl862xx-fw.c:mxl862xx_sb_pdi_reset() {
	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_CTRL,
				   MXL862XX_SB_PDI_CTRL_RST);
	...
	ret = mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_ADDR,
				   MXL862XX_SB_PDI_CTRL_RST);
	...
	return mxl862xx_smdio_write(priv, MXL862XX_SB_PDI_DATA,
				    MXL862XX_SB_PDI_CTRL_RST);
}

In mxl862xx_flash_firmware() there is a window between the START handshake
and the header byte count where STAT holds 0xf48f (written by the host) or
0xf490 (published by the loader while it waits for the header words and
their count):

	ret = mxl862xx_sb_pdi_poll_stat(priv, MXL862XX_SB_PDI_START + 1,
					MXL862XX_FW_ACK_TIMEOUT_MS);
	...
	for (i = 0; i < MXL862XX_FW_HDR_SIZE / 2; i++) {
		...
		if (ret < 0)
			goto write_err;
	}

Any SMDIO error there takes the write_err/no_end paths, which return without
advancing or aborting the loader; a host crash in the same burst has the same
effect. On the next probe, detection sees 0xf48f or 0xf490 and returns
MXL862XX_NOT_RESCUE, so mxl862xx_setup() runs mxl862xx_reset() and
mxl862xx_wait_ready() over clause-45 against a switch with no firmware,
re-runs detection, gets NOT_RESCUE again and fails probe with -ETIMEDOUT.

That is the CRC-error storm plus probe abort this patch sets out to avoid,
and it also conflicts with the commit message:

    after a failed one the switch is still in MCUboot, rescue mode
    is detected again, and the user can retry.

Should the handshake magics (START, ACK, and a lingering host-written count)
be classified as a loader rather than as running firmware, or should STAT be
reset out of the handshake before the flash path returns an error?

[ ... ]

> @@ -602,6 +1021,7 @@ int mxl862xx_devlink_flash_update(struct dsa_switch *ds,
>  		 * readiness poll below read the freshly booted firmware.
>  		 */
>  		priv->flash_reading = true;
> +		priv->rescue_mode = false;
>  		mutex_unlock(&priv->mdiodev->bus->mdio_lock);

[Severity: Low]
This is the only post-registration writer of rescue_mode, and it is a plain
store under mdio_lock. mxl862xx_api_wrap() reads it under the same lock, but
the readers this patch adds run in a different lock domain (rtnl_lock, or no
lock at all) and use neither mdio_lock nor READ_ONCE():

mxl862xx_port_enable()
mxl862xx_port_disable()
mxl862xx_port_stp_state_set()
mxl862xx_port_mdb_del()
mxl862xx_phylink_mac_select_pcs()

rtnl_lock and mdio_lock do not order these against the store, so a reader can
observe a stale value indefinitely. Would WRITE_ONCE()/READ_ONCE() pairing be
worth adding here, matching what the same patch already does for the sibling
rescue_ready and rescue_failed flags?

mxl862xx_port_mdb_del() has a second ordering detail: the flag is read after
mxl862xx_api_wrap() has already dropped mdio_lock, so the -ENODEV
classification can use a value that changed in between:

	ret = MXL862XX_API_READ(priv, MXL862XX_MAC_TABLEENTRYQUERY, qparam);
	...
	if (ret == -ENODEV && (priv->skip_teardown || priv->rescue_mode))
		return 0;

[ ... ]

> diff --git a/drivers/net/dsa/mxl862xx/mxl862xx-host.c b/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> index caa4f74a86cf1..23e5dfe81e364 100644
> --- a/drivers/net/dsa/mxl862xx/mxl862xx-host.c
> +++ b/drivers/net/dsa/mxl862xx/mxl862xx-host.c

[ ... ]

> @@ -554,9 +560,11 @@ int mxl862xx_smdio_write(struct mxl862xx_priv *priv, u32 addr, u16 val)
>  void mxl862xx_host_init(struct mxl862xx_priv *priv)
>  {
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

Thanks for the detailed protocol comments in mxl862xx-fw.c, they made the
state machine much easier to follow while reading this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1788976064.git.daniel%40makrotopia.org
