Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12EE439332;
	Wed, 16 Sep 2026 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543020; cv=none; b=EvQ++AtmygskYuGd4LkZzhxzKA5xFrt+HShwLioj2fJ/Je4vIM9ipemnXLoaiqrSntCFjeRV3aOE1EgkoLA2gcSiuiiPz72DhjIgC+eJPcQMpNFw5KIySpx+Rzc62SdAOl6MKN66XyMnkKRM5oJF5UEh8T8XUhgR7xELYm0wCsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543020; c=relaxed/simple;
	bh=Xm0wxNOTesBvKOlzCRQ+VysXWKctGmVlgJh17tvTUVQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jFCIGH4Vi6rVZldz9wtn0eiz8tcDd/uLNf88WT2Dfo57enFlxrZTSLr83K9E1OPjHXL2LbOMWzKThN2YGz87vHBqRKh3FPmVWzMRLyAOLGl9OaJ+F2MTOFHFL9DjZz3UxQmVYuDg3melQZA3ZH44uFd9ZaJDXJWERlgk0Fc+ftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hb+I5ZRE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hb+I5ZRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963A41F00893;
	Wed, 16 Sep 2026 07:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789543018;
	bh=JtTpxpIzoVEpmb8UYd6VpsPF1cGSusaJSLGBfG0QNEU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Hb+I5ZRE6W4DT+l71ekhVwLpludZTCjKvBnqhI9tEdkiTc+bgizCca4iLQkANcHix
	 HstZOS4xnwyAIjwp515lLj+MRE9BLJ5YzAaVhZOM0BMwn9qfsq+V+uhGeGWQJFVT/k
	 rJ0jVnRKqXybE2QULNi/J+//lNy+7PAYiKFC91qg1DSSqaJ1dKIANSvfiNYk7jow69
	 NY3nzPZUCUzTp8sF5uFzol1x5uskUv5sGYCEeMCSHvvnKjQXvR929Y9sIE6wMIe5N0
	 8U1QNOGL3AEZasuhn4Ab2/0gKe1NVWVliqjxUJPhTDa//2ZR4fj3vbmc30V0bDCaiC
	 0Na/wjfpZeySQ==
Subject:
 Re: [PATCH net-next v14 4/4] ptp: ocp: add TAP CPLD flashing via devlink
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 07:16:57 +0000
Message-ID: <178954301717.22033.9985871066743767845@kernel.org>
In-Reply-To: <20260914071555.11684-5-maimon.sagi@gmail.com>
References: <20260914071555.11684-5-maimon.sagi@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 7 · Low: 3

- [Medium] The `fw.cpld` flash component is only reachable while the
  cached CPLD identity is valid.
- [Medium] Documentation/networking/devlink/ptp_ocp.rst states for
  `fw.cpld` that "The image is the raw configuration bitstream, a whole…
- [Medium] `bp->cpld_id` / `bp->cpld_usercode` are invalidated only on
  the fully successful path of `adva_x1_cpld_flash()`…
- [Medium] In `adva_x1_cpld_read_id()` the newly added USERCODE
  transaction failing throws away the device ID that was already read…
- [Medium] `adva_x1_cpld_exit_config()` (drivers/ptp/ptp_ocp.c:4688-4703)
  discards the return value of `adva_x1_cpld_wait_idle(bp,…
- [Medium] `adva_x1_cpld_flash()` invalidates the cached CPLD identity
  (`WRITE_ONCE(bp->cpld_id, 0); WRITE_ONCE(bp->cpld_id_tried, false);…
- [Medium] The ISP sequence in `adva_x1_cpld_flash()` programs the
  configuration flash (EN_CFG_TP 0x74, ERASE 0x0E with operand 0x04 =…
- [Low] Inconsistent devlink error/status reporting between the two
  components of the same `->flash_update()` implementation.
- [Low] The comment on `adva_x1_cpld_wait_idle()`
  (drivers/ptp/ptp_ocp.c:4665) says it waits "for BUSY to clear,…
- [Low] `adva_x1_cpld_read_id()` publishes `cpld_usercode` and then
  `cpld_id` with plain `WRITE_ONCE()` and documents the dependency…

--

ptp: ocp: add TAP CPLD flashing via devlink

This adds a devlink flash component named fw.cpld that programs the Lattice
MachXO3 CPLD on ADVA TimeCard X1 boards over I2C using the in-system
programming commands, then activates the image with REFRESH.  The same
patch starts reporting the image USERCODE as a running version from
->info_get(), which is also what makes the component name acceptable to the
devlink core.  A few questions below about the component gating, the cached
identity and the configuration-mode exit path.

> diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
> index 3f997cd9f3a3..37e9f1ebd1a8 100644
> --- a/Documentation/networking/devlink/ptp_ocp.rst
> +++ b/Documentation/networking/devlink/ptp_ocp.rst

[ ... ]

> @@ -33,3 +33,38 @@ The ``ptp_ocp`` driver reports the following versions
> +   * - ``fw.cpld``
> +     - The configuration flash of the TAP CPLD on ADVA TimeCard X1 boards,
> +       programmed over I2C with the MachXO3 in-system programming commands
> +       and activated with a REFRESH, so the new image runs immediately.
> +       The image is the raw configuration bitstream, a whole number of
> +       16-byte pages; container formats such as ``.jed`` are rejected.

[Severity: Medium]
Where are container formats such as .jed rejected?  The only validation in
adva_x1_cpld_flash() is a length check:

	if (!fw->size || fw->size % CPLD_PAGE_SIZE) {
		NL_SET_ERR_MSG_MOD(extack,
				   "image must be a whole number of 16-byte pages");
		return -EINVAL;
	}

There is no format or container detection anywhere in the function, so a
.jed or .bit file whose byte length happens to be a multiple of 16 passes,
the configuration sector is erased by CPLD_CMD_ERASE and the container bytes
are programmed as configuration frames.  Should the documentation be
narrowed to describe only the length check, or should the code inspect the
image format?

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 98cb26077181..58b90b2b282f 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -2158,6 +2169,17 @@ ptp_ocp_devlink_flash_update(struct devlink *devlink,
>  	const char *msg;
>  	int err;
>  
> +	if (params->component) {
> +		if (!bp->has_cpld ||
> +		    strcmp(params->component, ADVA_CPLD_COMPONENT)) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "unsupported flash component");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		return adva_x1_cpld_flash(bp, devlink, params->fw, extack);
> +	}
> +
>  	dev = ptp_ocp_find_flash(bp);
>  	if (!dev) {
>  		dev_err(&bp->pdev->dev, "Can't find Flash SPI adapter\n");

[ ... ]

> @@ -2202,6 +2226,16 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
>  		err = devlink_info_version_fixed_put(req, "cpld.id", buf);
>  		if (err)
>  			return err;
> +
> +		/* The flashable component: naming it here is what lets
> +		 * "devlink dev flash ... component fw.cpld" through, as the
> +		 * core matches the name against the versions reported here.
> +		 */
> +		sprintf(buf, "0x%08x", READ_ONCE(bp->cpld_usercode));
> +		err = devlink_info_version_running_put_ext(req, "fw.cpld", buf,
> +							   ver_type);
> +		if (err)
> +			return err;
>  	}

[Severity: Medium]
Is the fw.cpld component reachable when the cached CPLD identity is not
valid?  The version is only emitted inside:

	id = READ_ONCE(bp->cpld_id);
	if (bp->has_cpld && id) {

and the core requires the name to have been reported:

net/devlink/dev.c:devlink_flash_component_get() {
	...
	if (!lookup_ctx.lookup_name_found) {
		NL_SET_ERR_MSG_ATTR(extack, nla_component,
				    "selected component is not supported by this device");
		return -EINVAL;
	}
	...
}

The handler above accepts the component on the weaker condition
bp->has_cpld alone, so the two sides disagree and the -EOPNOTSUPP branch
cannot be reached for a name the core already rejected.

Two states the driver creates itself leave cpld_id at 0:

  - adva_x1_cpld_flash() ends its success path with
    WRITE_ONCE(bp->cpld_id, 0), so a flash issued before ptp_ocp_sync_work()
    manages the next read gets -EINVAL from the core.

  - ptp_ocp_sync_work() abandons the one-shot read after
    CPLD_ID_MAX_ATTEMPTS non-EBUSY failures:

	if (err != -EBUSY &&
	    (!err || ++bp->cpld_id_attempts >= CPLD_ID_MAX_ATTEMPTS))
		WRITE_ONCE(bp->cpld_id_tried, true);

    after which fw.cpld is never advertised again for the life of the
    binding, and the documented flash command is unavailable even though
    adva_x1_cpld_flash() would run.

Should the component be advertised independently of the cached identity, so
that recovering from a bad image does not depend on a successful ID read?

[ ... ]

> @@ -4522,6 +4568,48 @@ static int adva_x1_mux_select(struct ptp_ocp *bp, int ch)
> +static const u8 *adva_x1_cpld_args(u8 cmd, u8 *nargs)
> +{
> +	static const u8 en_cfg_tp[] = { 0x08, 0x00 };
> +	/* cfg sector only */
> +	static const u8 erase_cfg[] = { 0x04, 0x00, 0x00 };
> +
> +	switch (cmd) {
> +	case CPLD_CMD_EN_CFG_TP:
> +		*nargs = sizeof(en_cfg_tp);
> +		return en_cfg_tp;
> +	case CPLD_CMD_ERASE:
> +		*nargs = sizeof(erase_cfg);
> +		return erase_cfg;
> +	case CPLD_CMD_RESET_ADDR:
> +	case CPLD_CMD_SET_DONE:
> +		*nargs = 3;
> +		return NULL;
> +	case CPLD_CMD_DIS_CFG:
> +	case CPLD_CMD_REFRESH:
> +		*nargs = 2;
> +		return NULL;
> +	default:
> +		*nargs = 0;
> +		return NULL;
> +	}
> +}

[Severity: Medium]
Where does the sequence program the USERCODE?  This switch enumerates every
ISC opcode the driver can emit and there is no ISC_PROGRAM_USERCODE (0xC2)
entry, and adva_x1_cpld_flash() never writes a usercode either.

The USERCODE field lives in the configuration flash that CPLD_CMD_ERASE with
operand { 0x04, 0x00, 0x00 } wipes, and it has its own read opcode
(CPLD_CMD_READ_USERCODE, 0xC0).  If the page writes issued with
CPLD_CMD_WRITE_PAGE do not carry it, then the value read back by
adva_x1_cpld_read_id() after a successful flash is the erased value rather
than the USERCODE of the image just programmed.

That is the value the patch publishes as the fw.cpld running version, and
the commit message describes it as "the USERCODE of the image currently in
the part".  Can you confirm whether the incremental program frames restore
the usercode field on this part?

> @@ -4547,14 +4635,82 @@ static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)

[ ... ]

> +/* Wait for BUSY to clear, ignoring a pending cancel.  An ISC command issued
> + * while the part is still erasing or programming may not latch, so an abort
> + * has to wait the operation out before it can leave configuration mode.
> + */
> +static int adva_x1_cpld_wait_idle(struct ptp_ocp *bp, unsigned int max_ms)

[Severity: Low]
This isn't a bug, but what is the "pending cancel" the comment refers to?
There is no cancel, abort or signal check anywhere in the CPLD code; a grep
for cancel, signal_pending and fatal_signal in this file finds only this
comment, an unrelated flash status string and cancel_delayed_work_sync() in
ptp_ocp_remove().

adva_x1_cpld_wait_ready() is equally uninterruptible; the only actual
difference is that it also treats CPLD_STATUS_FAILED as an error, which the
comment does not mention.  Could the comment state that difference instead?

> +/* Leave transparent configuration mode.  cpld_in_config_mode stays set when
> + * DIS_CFG does not get through, so a later cleanup() tries again rather than
> + * recording an exit that never happened.
> + */
> +static void adva_x1_cpld_exit_config(struct ptp_ocp *bp)
> +{
> +	int err;
> +
> +	if (!bp->cpld_in_config_mode)
> +		return;
> +
> +	adva_x1_cpld_wait_idle(bp, CPLD_ERASE_MS);
> +
> +	err = adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG);
> +	if (err)
> +		dev_warn(&bp->pdev->dev,
> +			 "CPLD left in configuration mode: %d\n", err);
> +	else
> +		bp->cpld_in_config_mode = false;
> +}

[Severity: Medium]
Which "later cleanup()" retries the exit?  bp->cpld_in_config_mode is read
only by this function, and its only caller is adva_x1_cpld_flash().
ptp_ocp_remove()/ptp_ocp_detach(), cpld_status_show() and
adva_x1_cpld_read_id() never look at it, so when DIS_CFG returns an error
the flag stays set and nothing ever sends it again - the part can stay
latched in transparent configuration mode across module unload.

The discarded return value looks related: if
adva_x1_cpld_wait_idle(bp, CPLD_ERASE_MS) timed out with the part still
BUSY, then by this function's own reasoning the DIS_CFG opcode probably did
not latch, yet an ACKed write still clears cpld_in_config_mode.  Should the
wait_idle() result gate the flag update, and should the teardown path
attempt the release?

>  /*
> - * Read the Lattice device ID into bp->cpld_id.  Done once, off the
[ ... ]
>  static int adva_x1_cpld_read_id(struct ptp_ocp *bp)
>  {
> +	u32 id, usercode;
>  	u8 data[4];
>  	int ret;
>  
> @@ -4568,8 +4724,19 @@ static int adva_x1_cpld_read_id(struct ptp_ocp *bp)
>  	if (ret)
>  		goto release;
>  	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_ID, data, 4);
> -	if (!ret)
> -		WRITE_ONCE(bp->cpld_id, get_unaligned_be32(data));
> +	if (ret)
> +		goto deselect;
> +	id = get_unaligned_be32(data);
> +
> +	ret = adva_x1_cpld_cmd_read(bp, CPLD_CMD_READ_USERCODE, data, 4);
> +	if (ret)
> +		goto deselect;
> +	usercode = get_unaligned_be32(data);

[Severity: Medium]
Does a failing USERCODE read throw away the device ID that was just read
successfully?  Before this patch a successful READ_ID alone set
bp->cpld_id; now the goto skips both stores, so an I2C NAK or a part that
does not answer the 0xC0 opcode leaves cpld_id at 0.

Since the read is a bounded one-shot, ptp_ocp_sync_work() latches
cpld_id_tried after CPLD_ID_MAX_ATTEMPTS failures and never retries, so a
persistent USERCODE failure permanently removes the pre-existing cpld.id
version as well - and with it the fw.cpld entry that gates flashing, as both
come out of the same if (bp->has_cpld && id) block.

Would publishing the ID before attempting the USERCODE read keep the older
behaviour intact?

> +
> +	/* cpld_id is the validity flag for both, so publish it last. */
> +	WRITE_ONCE(bp->cpld_usercode, usercode);
> +	WRITE_ONCE(bp->cpld_id, id);
> +deselect:

[Severity: Low]
Do these accessors give the ordering the comment relies on?  WRITE_ONCE()
and READ_ONCE() only prevent compiler tearing, they add no store-store or
load-load ordering, and the reader's control dependency on id does not order
the following load:

	id = READ_ONCE(bp->cpld_id);
	if (bp->has_cpld && id) {
		...
		sprintf(buf, "0x%08x", READ_ONCE(bp->cpld_usercode));

On a weakly ordered machine can ptp_ocp_devlink_info_get() observe a valid
cpld_id together with a stale or zero cpld_usercode and report fw.cpld as
0x00000000?  smp_store_release()/smp_load_acquire() would express the
publish pattern the comment describes.

> @@ -4627,6 +4794,154 @@ cpld_status_show(struct device *dev, struct device_attribute *attr,

[ ... ]

> +	err = adva_x1_cpld_write(bp, CPLD_CMD_SET_DONE);
> +	if (!err)
> +		err = adva_x1_cpld_wait_ready(bp, 1000);
> +	if (err)
> +		goto exit_config;
> +
> +	err = adva_x1_cpld_read_status(bp, &st);
> +	if (err)
> +		goto exit_config;
> +	if (!(st & CPLD_STATUS_DONE)) {
> +		err = -EIO;
> +		goto exit_config;
> +	}

[Severity: Low]
Why does this DONE check report differently from the identical one after
REFRESH?  Here userspace gets a bare -EIO with extack untouched and nothing
in the log, while the post-refresh check sets both:

	dev_err(&bp->pdev->dev,
		"CPLD refresh left status 0x%08x\n", st);
	NL_SET_ERR_MSG_MOD(extack, "CPLD did not come back configured");

Related: the CPLD path emits "Erasing"/"Programming"/"Activating" but never a
terminal notification, whereas the SPI path in
ptp_ocp_devlink_flash_update() finishes with:

	msg = err ? "Flash error" : "Flash complete";
	devlink_flash_update_status_notify(devlink, msg, NULL, 0, 0);

Should the CPLD component report a terminal status too, given the new
documentation says progress "is reported with the standard devlink status
notifications"?

[ ... ]

> +	/* The image on the part changed, so the cached USERCODE has too. */
> +	WRITE_ONCE(bp->cpld_id, 0);
> +	WRITE_ONCE(bp->cpld_id_tried, false);
> +	bp->cpld_id_attempts = 0;
> +
> +exit_config:
> +	adva_x1_cpld_exit_config(bp);
> +deselect:
> +	adva_x1_mux_select(bp, -1);
> +release:
> +	adva_x1_bus_release(bp);
> +unlock:
> +	mutex_unlock(&bp->cpld_lock);

[Severity: Medium]
Should the cache also be invalidated on the failure paths?  This block is
reached only when every post-refresh check passed.  Every failure taken after
CPLD_CMD_ERASE completed - a page write error, SET_DONE failure, DONE not
set, the REFRESH write failing, the mux reselect timing out, or the
post-refresh status check - jumps to exit_config or deselect and skips it.

The boot-time read has already latched cpld_id_tried, and
ptp_ocp_sync_work() gates the re-read on that flag:

	if (bp->has_cpld && !READ_ONCE(bp->cpld_id_tried) &&
	    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0) {

so ptp_ocp_devlink_info_get() keeps publishing cpld.id and the fw.cpld
running version of an image that has been erased or only partially
rewritten, for the life of the binding.  Would invalidating immediately
after the erase is issued be more accurate than after final verification?

[Severity: Medium]
Can ptp_ocp_sync_work() clobber this invalidation?  These three fields are
written here under cpld_lock, but the worker writes the same fields with no
lock held - adva_x1_cpld_read_id() takes and drops cpld_lock internally, so
the bookkeeping that follows it runs unprotected:

ptp_ocp_sync_work()
	err = adva_x1_cpld_read_id(bp);	/* takes and releases cpld_lock */
	if (err != -EBUSY &&
	    (!err || ++bp->cpld_id_attempts >= CPLD_ID_MAX_ATTEMPTS))
		WRITE_ONCE(bp->cpld_id_tried, true);

Interleaving:

worker		adva_x1_cpld_read_id() succeeds, cpld_lock released,
		preempted before WRITE_ONCE(cpld_id_tried, true)

flash		mutex_lock(&bp->cpld_lock), programs for tens of seconds,
		WRITE_ONCE(bp->cpld_id, 0)
		WRITE_ONCE(bp->cpld_id_tried, false)
		bp->cpld_id_attempts = 0
		mutex_unlock(&bp->cpld_lock)

worker		WRITE_ONCE(bp->cpld_id_tried, true)

That leaves cpld_id == 0 with tried latched, so the worker never re-reads,
info_get() permanently omits cpld.id and fw.cpld, and further
devlink dev flash ... component fw.cpld requests are rejected by
devlink_flash_component_get() until the driver is rebound.  The plain
bp->cpld_id_attempts = 0 store here also races with the worker's
++bp->cpld_id_attempts.  Would moving the tried/attempts bookkeeping inside
adva_x1_cpld_read_id(), under cpld_lock, close this?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914071555.11684-1-maimon.sagi%40gmail.com
