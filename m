Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9F25B084;
	Sun, 20 Sep 2026 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789916486; cv=none; b=a11MEIsrJAeMlzSEsIPjs4gy5ackQgh4bhSxpMdTqCsI44/JSToT5+ITgwLbT06qZzpMopOotq6suonmZBG334ZzG/BnKDwuAL8TGcUAw94mo0b+BwU16IQgdHfC+nGYKXXdV3ZQWcIX3Zv4YJZLYVbNLQVk7NhhBn7XIA+RkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789916486; c=relaxed/simple;
	bh=p/vHXEYtbzCnd0DV9k9V8a/hkQythhLRQysXv2TvBV0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aM6t6CLFh0xoKq0lfClDIwyMxWheD0mjTHJ2mam+Q4wvlePFbrNju6atuJ/dRGVB9Q/EV20oe7oYVn/Fg7+j1X0dly01IMzwhWt29LFkxiT9yvQlLoR5l+FeQY6tX6YtXXhQHIgGsoF+V8yFWbW1x64JHLU2ksuHso/Z42512n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAdPJNuL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAdPJNuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF651F00893;
	Sun, 20 Sep 2026 15:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789916484;
	bh=w39XaWSQlrCKNDhz5hcOiQMFVsVMHTKTkl7o2B0RR5s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RAdPJNuLanTa4ySZtFX4b2pa+HgRNBZDQsuPqz2gXLgZE1WZ5LQcfK4Hk8Mt9o8YX
	 3Gd447YotFiKuDUI6+7e0g74g77LfsWYe8rtIZLGqCJaGEig6niJflYfRHBXuNIULd
	 Q11U6qhe4AMBmtijJBPMiDZObYtUoBmUSZLtJxNi4vx5D74f1cbJojxZNGaHleop4t
	 7c7rB5N+bhpNoUMy0W0GDPRYsToX6f3T92klpHkvLS3X8b8/B03qI//LlF231gFe8L
	 MwQUr0JJSdAq6zvKWkXMmUT9D7NTXJsLqO1wf5MiE9b3MorkqBwWYdE55bHv2rfHNS
	 8DuaQhwy6f6SQ==
Subject:
 Re: [PATCH net-next v15 4/4] ptp: ocp: add TAP CPLD flashing via devlink
From: netdev-bot+sashiko@kernel.org
To: maimon.sagi@gmail.com
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, corbet@lwn.net, rdunlap@infradead.org,
 skhan@linuxfoundation.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 15:01:22 +0000
Message-ID: <178991648294.2160803.18070095713191970409@kernel.org>
In-Reply-To: <20260916153242.157171-5-sagi.maimon@adtran.com>
References: <20260916153242.157171-5-sagi.maimon@adtran.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 9 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 6 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ptp_ocp_devlink_info_get() publishes the literal string
  "unknown" as the devlink *running version* value for the fw.cpld…
- [Medium] adva_x1_cpld_flash() invalidates the cached CPLD identity
  (WRITE_ONCE(bp->cpld_id, 0), WRITE_ONCE(bp->cpld_usercode_ok, false),…
- [Medium] In adva_x1_cpld_flash() the first status wait after EN_CFG_TP
  uses adva_x1_cpld_wait_ready() (drivers/ptp/ptp_ocp.c:4958-4962),…
- [Medium] adva_x1_cpld_flash() invalidates the cached CPLD identity only
  after *both* the ERASE write and its completion wait succeed…
- [Medium] adva_x1_cpld_flash() holds bp->cpld_lock (mutex_lock() at
  drivers/ptp/ptp_ocp.c:4933) and the I2C root adapter lock (taken by…
- [Medium] The driver clears its configuration-mode bookkeeping from an
  I2C ACK alone, and its post-REFRESH success predicate cannot detect a…
- [Low] Documentation/networking/devlink/ptp_ocp.rst states for fw.cpld:
  "The only check the driver makes is that its length is a non-zero…
- [Low] The periodic progress notification in adva_x1_cpld_flash()'s page
  loop is emitted *after* the page at fw->data + offset has been written…
- [Low] adva_x1_cpld_flash() resets the ID-read bookkeeping with plain
  stores (`bp->cpld_id_tried = false; bp->cpld_id_attempts = 0;` at…

--

ptp: ocp: add TAP CPLD flashing via devlink

This adds a second devlink flash target to ptp_ocp: the "fw.cpld"
component programs the Lattice MachXO3 configuration flash on ADVA
TimeCard X1 boards over I2C and activates it with a REFRESH.  ->info_get()
now also reports the CPLD USERCODE as a running version, which is what
lets the core accept the component name.

A few questions about the new code and the documentation added with it.

> diff --git a/Documentation/ABI/testing/sysfs-timecard b/Documentation/ABI/testing/sysfs-timecard
> index e58824e0cdcdf..4ba45c6ee4a36 100644
> --- a/Documentation/ABI/testing/sysfs-timecard
> +++ b/Documentation/ABI/testing/sysfs-timecard
> @@ -31,9 +31,14 @@ Description:	(RO, root only) The flags set in the status register of the
>  
>  		A read arbitrates for the shared I2C bus and reprograms the
>  		on-card mux, so it is restricted to root.  The Lattice device
> -		ID of the CPLD is read once by the driver, shortly after
> -		probe, and reported from that cached value as the fixed
> -		"cpld.id" version by devlink dev info.
> +		ID of the CPLD is read by the driver shortly after probe,
> +		and again after a successful CPLD update, and reported from
> +		that cached value as the fixed "cpld.id" version by
> +		devlink dev info.

[Severity: Medium]
Does the code match "again after a successful CPLD update"?

adva_x1_cpld_flash() drops the cached identity as soon as the erase wait
returns, on every attempt that gets that far:

	WRITE_ONCE(bp->cpld_id, 0);
	WRITE_ONCE(bp->cpld_usercode_ok, false);
	bp->cpld_id_tried = false;
	bp->cpld_id_attempts = 0;

Any later failure - a page write error, the new -EINTR abort, SET_DONE or
REFRESH failing - still returns an error, but cpld.id is already gone from
devlink dev info.

Recovery then depends on adva_x1_cpld_read_id() succeeding within
CPLD_ID_MAX_ATTEMPTS sync_work ticks, after which cpld_id_tried latches
and the worker stops trying.

Since the Lattice IDCODE cannot change when the configuration flash is
erased, should cpld.id survive a failed update, or should the documentation
say the identity is dropped on any attempt that reaches the erase?

> +
> +		New CPLD firmware is programmed with devlink dev flash,
> +		selecting the "fw.cpld" component; see
> +		Documentation/networking/devlink/ptp_ocp.rst.
>  
>  What:		/sys/class/timecard/ocpN/available_clock_sources
>  Date:		September 2021
> diff --git a/Documentation/networking/devlink/ptp_ocp.rst b/Documentation/networking/devlink/ptp_ocp.rst
> index 3f997cd9f3a3f..f94b759d9cd65 100644
> --- a/Documentation/networking/devlink/ptp_ocp.rst
> +++ b/Documentation/networking/devlink/ptp_ocp.rst

[ ... ]

> @@ -30,6 +30,46 @@ The ``ptp_ocp`` driver reports the following versions
>       - Lattice device ID (IDCODE) of the TAP CPLD, formatted as ``0x%08x``.
>         Only present on ADVA TimeCard X1 boards, which are the only ones
>         carrying that CPLD.  Reading it claims the shared I2C bus and
> -       reprograms the on-card mux, so the driver does that once from its
> -       own worker and reports the cached value here; the version is
> -       omitted until that read has succeeded.
> +       reprograms the on-card mux, so the driver does that from its own
> +       worker and reports the cached value here; the version is omitted
> +       until that read has succeeded.  The read is made once per binding
> +       and again after a successful CPLD update.
> +   * - ``fw.cpld``
> +     - running
> +     - USERCODE of the image programmed into the TAP CPLD, formatted as
> +       ``0x%08x``.  Read together with ``cpld.id`` and reported the same
> +       way.  This is the component name to pass to ``devlink dev flash``
> +       to update the CPLD.

[ ... ]

> +   * - ``fw.cpld``
> +     - The configuration flash of the TAP CPLD on ADVA TimeCard X1 boards,
> +       programmed over I2C with the MachXO3 in-system programming commands
> +       and activated with a REFRESH, so the new image runs immediately.
> +       The image is the raw configuration bitstream.  The only check the
> +       driver makes is that its length is a non-zero multiple of the
> +       16-byte page size, so a container such as ``.jed`` has to be
> +       converted first rather than passed through - one whose length
> +       happens to be a multiple of 16 would be programmed as if it were
> +       a bitstream.

[Severity: Low]
Is "the only check the driver makes" accurate?  adva_x1_cpld_flash() also
rejects large images:

	if (fw->size > CPLD_MAX_IMAGE_SZ) {
		NL_SET_ERR_MSG_MOD(extack, "image too large for this part");
		return -EINVAL;
	}

with CPLD_MAX_IMAGE_SZ being 256 KiB.

Should the failure semantics be documented here as well?  After the erase
the configuration flash is blank, so any mid-sequence failure - including
the new fatal_signal_pending() abort, whose own comment says "The part is
left unconfigured" - leaves the CPLD unconfigured until a valid image is
written again.

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 998ea9c6b3817..2802989e84947 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -2192,14 +2224,35 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
> +		/* The flashable component.  Naming it here is what lets
> +		 * "devlink dev flash ... component fw.cpld" through, as the
> +		 * core matches the name against the versions reported here,
> +		 * so it is reported for every board that has the part and not
> +		 * only once its USERCODE has been read: a part left holding a
> +		 * bad image answers neither, and gating the component on the
> +		 * read would make that state unrecoverable.
> +		 */
> +		if (smp_load_acquire(&bp->cpld_usercode_ok))
> +			sprintf(buf, "0x%08x", READ_ONCE(bp->cpld_usercode));
> +		else
> +			strscpy(buf, "unknown", sizeof(buf));
> +		err = devlink_info_version_running_put_ext(req, "fw.cpld", buf,
> +							   ver_type);

[Severity: Medium]
Should the string "unknown" be published as a devlink running version
value?

The changelog says ->info_get() "publishes the USERCODE of the image
currently in the part", and the .rst entry added by this patch says
fw.cpld is the "USERCODE ... formatted as ``0x%08x``.  Read together with
``cpld.id`` and reported the same way" - and cpld.id is skipped entirely
while unread.

The window is not narrow: every devlink dev info between probe and the
first successful worker read, and permanently after a flash that erased
but did not finish, since adva_x1_cpld_flash() clears cpld_usercode_ok and
the worker gives up after CPLD_ID_MAX_ATTEMPTS.

Does naming the component actually need a value?  In
devlink_info_version_put() the callback runs before the empty-value
early-out:

net/devlink/dev.c:devlink_info_version_put() {
	...
	if (req->version_cb)
		req->version_cb(version_name, version_type,
				req->version_cb_priv);

	if (!req->msg || !*version_value)
		return 0;
	...
}

so passing "" would still register the name for
devlink_flash_component_get() while emitting no version attribute, which
is the behaviour the .rst describes.

[ ... ]

> @@ -4596,11 +4720,86 @@ static int adva_x1_cpld_read_status(struct ptp_ocp *bp, u32 *status)
>  	return 0;
>  }
>  
> +/* Poll the status register until the CPLD goes idle, or @max_ms elapses.
> + * The deadline is on wall time, so the I2C transactions count against it,
> + * and the status is read once more after it expires before giving up.
> + */
> +static int adva_x1_cpld_wait_ready(struct ptp_ocp *bp, unsigned int max_ms)
> +{
> +	u32 status = 0;
> +	int err = 0, ret;
> +
> +	ret = read_poll_timeout(adva_x1_cpld_read_status, err,
> +				err || (status & CPLD_STATUS_FAILED) ||
> +				!(status & CPLD_STATUS_BUSY),
> +				CPLD_POLL_US, max_ms * USEC_PER_MSEC, false,
> +				bp, &status);
> +	if (ret)
> +		return ret;
> +	/* Keep the transport errno so it reaches userspace as-is; -EIO is
> +	 * reserved for the CPLD itself reporting FAILED.
> +	 */
> +	if (err)
> +		return err;
> +	if (status & CPLD_STATUS_FAILED)
> +		return -EIO;
> +
> +	return 0;
> +}

[ ... ]

> +static void adva_x1_cpld_exit_config(struct ptp_ocp *bp)
> +{
> +	int err, i;
> +
> +	if (!bp->cpld_in_config_mode)
> +		return;
> +
> +	for (i = 0; i < CPLD_EXIT_CFG_TRIES; i++) {
> +		err = adva_x1_cpld_wait_idle(bp, CPLD_ERASE_MS);
> +		if (!err)
> +			err = adva_x1_cpld_write(bp, CPLD_CMD_DIS_CFG);
> +		if (!err) {
> +			bp->cpld_in_config_mode = false;
> +			return;
> +		}
> +	}
> +
> +	dev_err(&bp->pdev->dev, "CPLD left in configuration mode: %d\n", err);
> +}

[ ... ]

> @@ -4694,6 +4906,207 @@ cpld_status_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_ADMIN_RO(cpld_status);
>  
> +/*
> + * Program the CPLD configuration flash from @fw and activate it.  Selected
> + * by the "fw.cpld" flash component; the SPI flash keeps the default path.
> + * Runs under cpld_lock with the i2c adapter lock held, so an EEPROM read
> + * blocks for as long as programming takes.
> + */
> +static int adva_x1_cpld_flash(struct ptp_ocp *bp, struct devlink *devlink,
> +			      const struct firmware *fw,
> +			      struct netlink_ext_ack *extack)
> +{

[ ... ]

> +	mutex_lock(&bp->cpld_lock);
> +
> +	err = adva_x1_bus_claim(bp);
> +	if (err)
> +		goto unlock;

[Severity: Medium]
Can this trip the hung-task detector for other users of the adapter?

adva_x1_bus_claim() takes the root adapter lock with
i2c_lock_bus(adap, I2C_LOCK_ROOT_ADAPTER), which is an uninterruptible,
non-killable acquisition for everyone else, and it is held here together
with cpld_lock for the whole cycle:

  EN_CFG wait			5 s
  ERASE wait			CPLD_ERASE_MS (15 s)
  page loop			100 ms per 16-byte page, up to
				CPLD_MAX_IMAGE_SZ / 16 = 16384 pages
  SET_DONE wait			1 s
  msleep(1500) + mux poll	1.5 s + 3 s
  post-REFRESH wait		3 s
  failure path			CPLD_EXIT_CFG_TRIES * CPLD_ERASE_MS (45 s)

Meanwhile the at24/nvmem EEPROM read reached from ptp_ocp_read_eeprom()
(also called from the unprivileged ptp_ocp_devlink_info_get() path) and any
other client of that adapter waits in i2c_lock_bus() and cannot be killed.

The changelog does say "an EEPROM read blocks for as long as programming
takes", but with the worst case above that exceeds the 120 s hung-task
threshold.  Would releasing the bus between phases, or bounding the total
hold, be preferable to the size cap whose comment claims it "Bounds how
long a claim can hold the i2c root lock"?

The new fatal_signal_pending() check only helps the flashing task, not the
waiters - is that the intent?

[ ... ]

> +	err = adva_x1_cpld_write(bp, CPLD_CMD_EN_CFG_TP);
> +	if (!err)
> +		err = adva_x1_cpld_wait_ready(bp, 5000);
> +	if (err)
> +		goto exit_config;

[Severity: Medium]
Is adva_x1_cpld_wait_ready() the right wait for the enable step?

It turns a set CPLD_STATUS_FAILED into -EIO, and the driver's own comment
above adva_x1_cpld_wait_idle() says FAILED is latched across operations
("an ISC command issued while the part is still erasing or programming may
not latch, so the operation has to be waited out whatever its outcome").

Nothing in the driver clears it: the failure path
adva_x1_cpld_exit_config() only sends DIS_CFG.

So if FAILED survives a DIS_CFG plus a fresh EN_CFG_TP, does every later
devlink dev flash ... component fw.cpld return -EIO here, before reaching
the ERASE/REFRESH that would put the part back into a defined state?  That
would contradict the comment in the page loop saying the state "is
recoverable: fw.cpld stays advertised so the image can be written again".

For comparison, machxo2_write_init() in drivers/fpga/machxo2-spi.c tests
FAIL only after ISC_ENABLE and ISC_ERASE, and machxo2_cleanup() recovers
with ISC_ERASE followed by LSC_REFRESH.

[ ... ]

> +	devlink_flash_update_status_notify(devlink, "Erasing",
> +					   ADVA_CPLD_COMPONENT, 0, 0);
> +	err = adva_x1_cpld_write(bp, CPLD_CMD_ERASE);
> +	if (!err)
> +		err = adva_x1_cpld_wait_ready(bp, CPLD_ERASE_MS);
> +	if (err)
> +		goto exit_config;

[Severity: Medium]
Does this leave stale identity published when the erase is under way but
the wait fails?

If adva_x1_cpld_write(CPLD_CMD_ERASE) is ACKed, the erase is running in
hardware.  If adva_x1_cpld_wait_ready() then returns -ETIMEDOUT, -EIO for
a latched FAILED, or a transport errno, this goto skips the invalidation
below entirely.

bp->cpld_id keeps its old value, cpld_usercode_ok stays true, and
cpld_id_tried stays true from the probe-time read, so the
!READ_ONCE(bp->cpld_id_tried) gate in ptp_ocp_sync_work() never re-reads.
ptp_ocp_devlink_info_get() then keeps publishing cpld.id and an fw.cpld
USERCODE for an image that is no longer in the part, for the rest of the
binding.

Would invalidating before issuing the ERASE (or right after the write
returns 0) match the comment below, "stop reporting its identity even if
the rest of the sequence fails"?

> +
> +	/* The old image is gone from here on, so stop reporting its
> +	 * identity even if the rest of the sequence fails.  Written under
> +	 * cpld_lock, which adva_x1_cpld_read_id() also holds across its own
> +	 * bookkeeping, so the worker cannot resurrect any of it.
> +	 */
> +	WRITE_ONCE(bp->cpld_id, 0);
> +	WRITE_ONCE(bp->cpld_usercode_ok, false);
> +	bp->cpld_id_tried = false;
> +	bp->cpld_id_attempts = 0;

[Severity: Low]
Should these two be WRITE_ONCE() as well?

ptp_ocp_sync_work() reads the flag without cpld_lock:

	if (bp->has_cpld && !READ_ONCE(bp->cpld_id_tried) &&
	    READ_ONCE(bp->cpld_i2c_adap_nr) >= 0)
		adva_x1_cpld_read_id(bp);

so the writer holds cpld_lock and the reader holds nothing, which is a
plain-store versus marked-load pair that KCSAN would report.

The comment here says "Written under cpld_lock, which
adva_x1_cpld_read_id() also holds across its own bookkeeping, so the worker
cannot resurrect any of it", and the struct field comment says
"under cpld_lock", but neither covers the worker's unlocked gate.  The
effect looks benign, since the racing read_id() attempt just gets -EBUSY
from mutex_trylock().

[ ... ]

> +		if (!err)
> +			err = adva_x1_cpld_wait_ready(bp, 100);
> +		if (err)
> +			goto exit_config;
> +
> +		if (!(offset % (CPLD_PAGE_SIZE * 64)))
> +			devlink_flash_update_status_notify(devlink,
> +							   "Programming",
> +							   ADVA_CPLD_COMPONENT,
> +							   offset, fw->size);

[Severity: Low]
Should this report offset + CPLD_PAGE_SIZE?

The page at fw->data + offset has already been written and waited for at
this point, so the first notification says 0 bytes done and each periodic
one is a page behind.  Moving the notify above the page write would work
too.

[ ... ]

> +	devlink_flash_update_status_notify(devlink, "Activating",
> +					   ADVA_CPLD_COMPONENT, 0, 0);
> +	err = adva_x1_cpld_write(bp, CPLD_CMD_REFRESH);
> +	if (err)
> +		goto exit_config;
> +
> +	/* REFRESH reboots the CPLD out of configuration mode, so the exit
> +	 * path must not send DIS_CFG afterwards even if a check below fails.
> +	 */
> +	bp->cpld_in_config_mode = false;

[Severity: Medium]
Can an ACKed but unlatched REFRESH be reported as a successful update?

The I2C ACK alone clears cpld_in_config_mode here, and the final check
after the reselect only looks at:

	if (!(st & CPLD_STATUS_DONE) || (st & CPLD_STATUS_BUSY) ||
	    (st & CPLD_STATUS_ERR)) {

Those three conditions are already satisfied by the state left by SET_DONE,
so if the REFRESH frame does not latch, the part stays in configuration
mode running the old image and devlink dev flash still returns 0 - while
the .rst says "the new image runs immediately".

CPLD_STATUS_ENAB is defined by this patch and tested after EN_CFG_TP, but
never after REFRESH.  Would checking ENAB here (and retrying REFRESH, as
machxo2_write_complete() does up to MACHXO2_MAX_REFRESH_LOOP times) be
worthwhile?

The same question applies to adva_x1_cpld_exit_config(), which clears
cpld_in_config_mode as soon as the DIS_CFG write is ACKed without reading
ENAB back.  Since the recovery call at the start of adva_x1_cpld_flash() is
gated on that flag, does one false-positive exit make a part stuck in
configuration mode unreachable by that recovery?

> +
> +	/* The new image is already running, so a segment that is not back
> +	 * yet must not be reported as a failed update: retry the reselect
> +	 * rather than sampling the mux once at a fixed delay.
> +	 */
> +	msleep(1500);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916153242.157171-1-sagi.maimon%40adtran.com
