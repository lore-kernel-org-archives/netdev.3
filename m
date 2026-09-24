Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC59237A485;
	Thu, 24 Sep 2026 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260184; cv=none; b=kT0qIngtT/+k2zvorw100wds9820mBrEFKOBew71Jh/RGKKqkKwgCNCmE7Chdvglslu4CjXCB/ABRM7/a+jLlg22KCfSk8ONibEAXiCi0XjDyaqtfQd9BCbHHtbFwOXXjRl85nwpN4C9QGNjfaFr7IL229jNB20lDqjKYX62qiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260184; c=relaxed/simple;
	bh=nbQjcfbros5RKndWRvHSDXEmBSL4JMgcLKsdpgeVSZ4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c/gwdDm+FYhSlWvTObfhmpe9V7c7i9ccN3By1YmgjxKSpwQ8Y/CCb/L3EjBJHZNk6bVv9qqXiCeZ/vzqzjpvCJwrQyYEbPChD1Uk+lkVqXTGjeVtWopgETH5tRiRK3U1zNWDuXQ9nJ3Yd6a0c0ID4jEnQzeGjNH226+/Y/dVI5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brGrT7QM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brGrT7QM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCED1F00899;
	Thu, 24 Sep 2026 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790260172;
	bh=863SkkIH7ejiTbqQcURRvBC5J1wM5DZa2edw0qS8o5M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=brGrT7QMkw4pLbZLlfXoSJRN/TY5bzvzYOOqFqTchNsAZIElzT5tmJUuueZdM7J5f
	 gleJgTtF4lhvzCGKFBMx4UTPIOze56yy9IxKeKFzGSEqlRJjVHeoVhnMmULqUlJpUu
	 JvP5/HL8c5waGrYOrFRIp6/WAIPG1xaUaIZONDEZ+FMuv+2tfhik+gTxkvJTcTUUNG
	 nWjJANmtjm9ENPrEsdbLbgocR5wYgVw6xdXdRGjXtuAjmASXm6vn2eG0okUf14oNsj
	 bjqCZR4D3u57VGoke6TQOske0kqSRBqtTO68GUMUlLRykE6ro8KWfRsnOb/pSBFKyM
	 /sC8jA2qM+kIw==
Subject: Re: [PATCH net-next 7/9] ptp: ocp: drop only the USERCODE when
 flashing, and drop it before erasing
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 14:29:31 +0000
Message-ID: <179026017164.2160803.11172810729232597287@kernel.org>
In-Reply-To: <20260922142829.57740-8-maimon.sagi@gmail.com>
References: <20260922142829.57740-8-maimon.sagi@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] adva_x1_cpld_flash() invalidates the cached CPLD identification
  state (WRITE_ONCE(bp->cpld_usercode_ok, false);…
- [Medium] The patch adds to Documentation/networking/devlink/ptp_ocp.rst
  that the driver "checks only that its length is a non-zero multiple of…
- [Low] The new paragraph in Documentation/networking/devlink/ptp_ocp.rst
  states unconditionally that "The erase clears the configuration flash…
- [Low] The patch adds to the "Info versions" table in
  Documentation/networking/devlink/ptp_ocp.rst that for fw.cpld "the…

--

ptp: ocp: drop only the USERCODE when flashing, and drop it before erasing

This moves the invalidation of the cached CPLD identification in
adva_x1_cpld_flash() to before the ERASE command is issued, stops clearing
cpld_id (the Lattice IDCODE), and rewrites the matching documentation in
Documentation/ABI/testing/sysfs-timecard and
Documentation/networking/devlink/ptp_ocp.rst.

A few questions below about the new invalidation point and the new wording.

[ ... Documentation/ABI/testing/sysfs-timecard hunk snipped ... ]

> diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
> index f94b759d9cd65..249ca63eebf61 100644
> --- a/Documentation/networking/devlink/ptp_ocp.rst
> +++ b/Documentation/networking/devlink/ptp_ocp.rst
> @@ -32,14 +32,17 @@ The ``ptp_ocp`` driver reports the following versions

[ ... ]

>     * - ``fw.cpld``
>       - running
>       - USERCODE of the image programmed into the TAP CPLD, formatted as
>         ``0x%08x``.  Read together with ``cpld.id`` and reported the same
> -       way.  This is the component name to pass to ``devlink dev flash``
> -       to update the CPLD.
> +       way; it is dropped when an update erases the part and reported
> +       again once the new image has been read back.  This is the

[Severity: High]
Which code path performs the read back this sentence describes?

adva_x1_cpld_read_id() is the only writer that sets cpld_usercode_ok back
to true:

drivers/ptp/ptp_ocp.c:adva_x1_cpld_read_id() {
	...
	smp_store_release(&bp->cpld_usercode_ok, true);
	...
}

and its only caller is ptp_ocp_cpld_work(), which requeues itself only from
inside its own run:

drivers/ptp/ptp_ocp.c:ptp_ocp_cpld_work() {
	adva_x1_cache_i2c_adap(bp);
	if (READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)
		adva_x1_cpld_read_id(bp);

	if (!READ_ONCE(bp->cpld_id_tried))
		queue_delayed_work(system_power_efficient_wq, &bp->cpld_work,
				   HZ);
}

The other queue site is ptp_ocp_probe(), once per binding:

	if (bp->has_cpld)
		queue_delayed_work(system_power_efficient_wq, &bp->cpld_work,
				   HZ);

In the normal case the probe-time read succeeds, adva_x1_cpld_read_id() sets
cpld_id_tried true, and the worker chain stops about a second after probe.
Neither adva_x1_cpld_flash() nor the devlink flash entry point queues
cpld_work again, and ptp_ocp_i2c_notifier_call() only updates
cpld_i2c_adap_nr.

So after any flash that reaches the new invalidation point - including a
fully successful one - does cpld_usercode_ok stay false until unbind/rebind,
making ptp_ocp_devlink_info_get() take the empty-value branch:

drivers/ptp/ptp_ocp.c:ptp_ocp_devlink_info_get() {
	...
		if (smp_load_acquire(&bp->cpld_usercode_ok))
			sprintf(buf, "0x%08x", READ_ONCE(bp->cpld_usercode));
		else
			buf[0] = '\0';
	...
}

and devlink_info_version_put() then drops the attribute entirely:

net/devlink/dev.c:devlink_info_version_put() {
	...
	if (!req->msg || !*version_value)
		return 0;
	...
}

If that is right, is the fw.cpld running version permanently omitted after a
successful CPLD update, and is the clearing of cpld_id_tried in the flash
path a dead store since nothing re-evaluates the requeue condition?

Would pairing the invalidation with a mod_delayed_work() on bp->cpld_work
after the bus is released (outside cpld_lock, so the worker's lock
acquisition can succeed), or an inline USERCODE re-read at the end of the
flash sequence, match what this documentation now promises?  Otherwise
should the text say the value stays absent until rebind?

> +       component name to pass to ``devlink dev flash`` to update the
> +       CPLD, and the name is reported even while the value is not, so a
> +       part left holding a bad image can still be reflashed.

[Severity: Low]
This isn't a bug, but in a table describing what devlink dev info shows,
is "the name is reported even while the value is not" the right wording?

With an empty value, devlink_info_version_put() hands the name to
req->version_cb and then returns before opening the nest:

net/devlink/dev.c:devlink_info_version_put() {
	...
	if (req->version_cb)
		req->version_cb(version_name, version_type,
				req->version_cb_priv);

	if (!req->msg || !*version_value)
		return 0;
	...
}

so neither DEVLINK_ATTR_INFO_VERSION_NAME nor _VALUE is emitted; the name
only reaches devlink_flash_component_lookup_cb() so that the component stays
selectable for flashing.  The driver's own comment in
ptp_ocp_devlink_info_get() already says "nothing is published".

Could this say the component stays selectable for flashing rather than that
its name is reported?

> @@ -59,12 +62,17 @@ selected with the component name.
>       - The configuration flash of the TAP CPLD on ADVA TimeCard X1 boards,
>         programmed over I2C with the MachXO3 in-system programming commands
>         and activated with a REFRESH, so the new image runs immediately.
> -       The image is the raw configuration bitstream.  The only check the
> -       driver makes is that its length is a non-zero multiple of the
> -       16-byte page size, so a container such as ``.jed`` has to be
> -       converted first rather than passed through - one whose length
> -       happens to be a multiple of 16 would be programmed as if it were
> -       a bitstream.
> +       The image is the raw configuration bitstream.  The driver checks
> +       only that its length is a non-zero multiple of the 16-byte page
> +       size and that it is not larger than the part takes, so a container

[Severity: Medium]
Does "not larger than the part takes" describe the check that is actually
made?  The only other size test in adva_x1_cpld_flash() is:

	if (fw->size > CPLD_MAX_IMAGE_SZ) {
		NL_SET_ERR_MSG_MOD(extack, "image too large for this part");
		return -EINVAL;
	}

and the constant's own comment says it is not a capacity check:

/* Bounds how long a claim can hold the i2c root lock, not image validity:
 * far above any bitstream this part takes.
 */
#define CPLD_MAX_IMAGE_SZ     (256 * 1024)

An image several times larger than the configuration flash, but under
256 KiB and a multiple of 16, passes both tests and is erased and written
page by page.  The tree then carries two contradictory statements about the
same limit.

Should the documentation describe it as an upper bound on how long the I2C
bus is held rather than a part-capacity check (and possibly the extack
string reworded to match)?

> +       such as ``.jed`` has to be converted first rather than passed
> +       through - one whose length happens to be a multiple of 16 would be
> +       programmed as if it were a bitstream.
> +
> +       The erase clears the configuration flash before the first page is
> +       written, so any failure from that point on - including an abort on
> +       a fatal signal - leaves the CPLD unconfigured until a valid image
> +       is written.  The component stays available for that.

[Severity: Low]
Is "any failure from that point on ... leaves the CPLD unconfigured" true at
both ends of the sequence?

After a successful REFRESH the new image is already running:

drivers/ptp/ptp_ocp.c:adva_x1_cpld_flash() {
	...
	err = adva_x1_cpld_write(bp, CPLD_CMD_REFRESH);
	if (err)
		goto exit_config;

	bp->cpld_in_config_mode = false;
	...
}

yet a failure of the mux reselect retry loop, of adva_x1_cpld_wait_ready(),
of the status read, or of the bus release still returns an error with the new
configuration active and DONE set.

At the other end, the driver enters ISP with

#define CPLD_CMD_EN_CFG_TP    0x74   /* enable config, transparent mode */

and erases the configuration sector only:

	/* cfg sector only */
	static const u8 erase_cfg[] = { 0x04, 0x00, 0x00 };

while the failure path calls adva_x1_cpld_exit_config(), which sends DIS_CFG
rather than REFRESH.  On MachXO2/XO3 transparent mode the loaded design keeps
running until a REFRESH or power cycle, so a page-write failure or fatal
signal abort appears to leave the old design running with an invalid boot
image.

Would it be more accurate to say a failure after the erase can leave an
invalid boot image, and that whether the old or the new design is active
depends on whether REFRESH was issued?

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 4ce86df6e1968..0d6d0c02882c1 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -5043,6 +5043,21 @@ static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
>  		goto exit_config;
>  	}
>  
> +	/* Once the erase is issued the image is gone whatever happens next -
> +	 * an ACKed ERASE runs in the part even if the wait for it fails - so
> +	 * stop reporting the USERCODE before sending it rather than after
> +	 * the whole sequence has succeeded.
> +	 *
> +	 * cpld.id is left alone: it is the Lattice IDCODE, a property of the
> +	 * silicon that erasing the configuration flash cannot change, so
> +	 * dropping it on a failed update only hid information that was still
> +	 * correct.  Written under cpld_lock, which adva_x1_cpld_read_id()
> +	 * also holds across its own bookkeeping.
> +	 */
> +	WRITE_ONCE(bp->cpld_usercode_ok, false);
> +	WRITE_ONCE(bp->cpld_id_tried, false);
> +	bp->cpld_id_attempts = 0;

[Severity: High]
This is the same concern as above, at the code that raises it.

Moving the invalidation ahead of the ERASE also means it now runs before the
command is even sent.  If the ERASE write is NAKed and the part never acted
on it, a still-correct USERCODE has been dropped - and with the worker
already retired there is no path that reads it again.

Is there a reason not to queue bp->cpld_work (or re-read the USERCODE
inline) once the bus has been released, so that cpld_usercode_ok can become
true again within the same binding?

>  	devlink_flash_update_status_notify(devlink, "Erasing",
>  					   ADVA_CPLD_COMPONENT, 0, 0);
>  	err = adva_x1_cpld_write(bp, CPLD_CMD_ERASE);
> @@ -5051,16 +5066,6 @@ static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
>  	if (err)
>  		goto exit_config;
>  
> -	/* The old image is gone from here on, so stop reporting its
> -	 * identity even if the rest of the sequence fails.  Written under
> -	 * cpld_lock, which adva_x1_cpld_read_id() also holds across its own
> -	 * bookkeeping, so the worker cannot resurrect any of it.
> -	 */
> -	WRITE_ONCE(bp->cpld_id, 0);
> -	WRITE_ONCE(bp->cpld_usercode_ok, false);
> -	WRITE_ONCE(bp->cpld_id_tried, false);
> -	bp->cpld_id_attempts = 0;
> -
>  	err = adva_x1_cpld_write(bp, CPLD_CMD_RESET_ADDR);
>  	if (err)
>  		goto exit_config;

Also, the commit message says the documentation should "describe what is
actually dropped and restored".  With no code path restoring
cpld_usercode_ok after a flash, is there anything restored to describe?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922142829.57740-1-maimon.sagi%40gmail.com
