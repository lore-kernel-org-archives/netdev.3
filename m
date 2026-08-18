Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCD847AF69;
	Tue, 18 Aug 2026 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071070; cv=none; b=Zk4TaNewsFqxqkKqusZ7F3vxVMU7/RvhUQ6BaNaDdzaLqihBOqq3s4Va9VUh6d8PPHkc1A7Ya3O7mU2Mp7DBef69rJeDXgITeFrs4Gkl+jyrMmiHWVSIsgZanRSDm6PrlRHfwoM55NjhANnbT3lXeIZCdIOiXivZv7ZWnwcASTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071070; c=relaxed/simple;
	bh=GNMQv5XVJ4jGtFAPOVbHWhcl1wbgzDdwpAW+bYkhhFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nw42pdpbpOsnT9NiAwk1xsJznzmtGB1u21BZRK3upcbdHwMJT4DsejUd+U69anpBhUjr8qL+JHS+gVvqHqjRRNWMeM3w9Pxcp+FPi3X/nGClMnKbmybKgmzGXMXarkesARJZAvafp5u8epSxdT9FVl2HbnzW/G6PtDsQNVWvzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnelE7Fi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnelE7Fi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0766E1F000E9;
	Tue, 18 Aug 2026 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787071068;
	bh=JnlVQUZ0wlNkhm1fR085QloIqRViqzCYfDya/FK6Smw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SnelE7FiVmN9tDpQSU77XJiXpMsRUgZQhr8uedFHOchztgjlVjdEomTIpZxLBE7e2
	 h7OYH4sbYhjeCJEl4ixydGyuB6EMVriYeoCRDWz1hv+iHaasxTS9aJx6v08bK5Fdkt
	 Leu6tcYQ6wKZUcJjw86oOI8bp8/SvGEXa0BnBedU687likq2qor0wogocASwWeye1R
	 b2mG6q+kEU7hN1qGK4kAYzlPZEjYmW5lDPFivbAQjIRvTHsUkL39y8TF5KHcph+63c
	 u6fQfIG1TwLE3X+tB2l68508hF1K0ZaqLXZ3DmO1hNteBx63OzC0mb1SOGxQR9KSZX
	 OvqjODFkccIWg==
From: Jakub Kicinski <kuba@kernel.org>
To: ivecera@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	poros@redhat.com,
	vadim.fedorenko@linux.dev,
	Chris.duQuesnay@microchip.com,
	arkadiusz.kubalewski@intel.com,
	jiri@resnulli.us,
	min.li@microchip.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 2/3] dpll: zl3073x: add channel ToD, phase step and TIE operations
Date: Tue, 18 Aug 2026 09:37:46 -0700
Message-ID: <20260818163746.3988829-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814082656.306534-3-ivecera@redhat.com>
References: <20260814082656.306534-3-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
dpll: zl3073x: add channel ToD, phase step and TIE operations

Adds low-level DPLL channel helpers for ToD read/write/adjust, output phase
step, delta frequency offset write and TIE write, plus a device-global
output step-time mask.  These are used by the PTP clock callbacks added in
the following patch.

> diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
> index 4ec2cf53dad46..ba4d303d41b47 100644
> --- a/drivers/dpll/zl3073x/chan.c
> +++ b/drivers/dpll/zl3073x/chan.c

[ ... ]

> @@ -234,6 +235,322 @@ const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
>  	return &zldev->chan[index];
>  }
>  
> +/**
> + * zl3073x_chan_tod_ready_wait - wait for ToD semaphore to clear
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + *
> + * Checks the ToD control register semaphore bit. If clear, returns
> + * immediately. Otherwise polls until the bit is cleared by the device.
> + *
> + * Return:
> + * * 0			- success
> + * * %-EBUSY		- timeout
> + * * %-EOPNOTSUPP	- unknown command detected
> + * * negative		- other error
> + */
> +int zl3073x_chan_tod_ready_wait(struct zl3073x_dev *zldev, u8 ch)
> +{
> +	unsigned int timeout;
> +	u8 tod_ctrl;
> +	int rc;
> +
> +	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch), &tod_ctrl);
> +	if (rc)
> +		return rc;
> +
> +	if (!(tod_ctrl & ZL_DPLL_TOD_CTRL_SEM))
> +		return 0;

[ ... ]

> +int zl3073x_chan_tod_adjust(struct zl3073x_dev *zldev, u8 ch,
> +			    struct timespec64 delta)
> +{
> +#define ZL_TOD_MAX_RETRIES	20
> +	static const long threshold_ns = 20 * NSEC_PER_MSEC;
> +	struct timespec64 ts_next, ts_cur, diff;
> +	int rc, i;
> +
> +	for (i = 0; i < ZL_TOD_MAX_RETRIES; i++) {
> +		rc = zl3073x_chan_tod_read(zldev, ch, true, &ts_next, NULL);
> +		if (rc)
> +			return rc;
> +
> +		rc = zl3073x_chan_tod_read(zldev, ch, false, &ts_cur, NULL);
> +		if (rc)
> +			return rc;
> +
> +		/* Ensure the 1 Hz tick did not cross between the two reads
> +		 * and that enough margin remains to complete the write.
> +		 */
> +		diff = timespec64_sub(ts_next, ts_cur);
> +		if (diff.tv_sec > 0 ||
> +		    (!diff.tv_sec && diff.tv_nsec >= threshold_ns))
> +			break;
> +	}
> +	if (i == ZL_TOD_MAX_RETRIES) {
> +		dev_warn(zldev->dev,
> +			 "DPLL%u ToD adjust failed to get stable margin\n",
> +			 ch);
> +		return -EBUSY;
> +	}

[Severity: Medium]

Can this loop spin out its retry budget without ever giving the condition a
chance to become true?

The value being tested, diff = ts_next - ts_cur, is the time remaining until
the next 1 Hz edge.  When the call lands in the last 20 ms of a second, the
loop can only succeed once that residual has elapsed, but nothing in the
loop body waits.  zl3073x_chan_tod_ready_wait() returns straight away when
the semaphore is already clear:

	if (!(tod_ctrl & ZL_DPLL_TOD_CTRL_SEM))
		return 0;

and regmap_read_poll_timeout() inside zl3073x_poll_zero_u8() does its first
read before any usleep_range().  On a fast bus where the ToD command
completes before the semaphore is re-read, all 20 iterations can finish well
inside the 20 ms window, so i == ZL_TOD_MAX_RETRIES and the adjustment is
rejected with -EBUSY plus an unratelimited dev_warn() rather than being
retried a few milliseconds later.

In the next patch this propagates directly to userspace:

drivers/dpll/zl3073x/dpll.c:zl3073x_dpll_ptp_adjtime() {
	...
	return zl3073x_chan_tod_adjust(zldev, zldpll->id,
				       ns_to_timespec64(delta));
}

so clock_adjtime(ADJ_SETOFFSET) sees the -EBUSY.

Would it make sense to sleep for the remaining margin (or a fixed few
milliseconds) between iterations, so the loop actually waits out the
rollover window instead of burning the retries inside it?

[ ... ]

> +int zl3073x_chan_tie_write(struct zl3073x_dev *zldev, u8 ch, s64 delta_ns)
> +{
> +	s64 tie_data;
> +	int rc;
> +
> +	guard(mutex)(&zldev->tie_lock);
> +
> +	/* Wait for any previous TIE operation to complete */
> +	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_TIE_CTRL,
> +				  ZL_DPLL_TIE_CTRL_OP,
> +				  ZL_POLL_TIE_WR_TIMEOUT_US);
> +	if (rc)
> +		return rc;
> +
> +	/* Convert ns to TIE units (0.01 ps = 10^-14 s) */
> +	tie_data = delta_ns * 100000LL;
> +
> +	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_TIE_DATA(ch), tie_data);
> +	if (rc)
> +		return rc;

[Severity: Low]

This isn't a bug with the current callers, but the kerneldoc for
zl3073x_chan_tie_write() states delta_ns "must be in (-1s, 1s)" and nothing
in the function enforces it.  For |delta_ns| >= about 1.4e9 the product
overflows the signed 48-bit TIE field, and zl3073x_write_u48() accepts the
union of the signed and unsigned 48-bit ranges:

drivers/dpll/zl3073x/core.c:zl3073x_write_u48() {
	if (val > GENMASK_ULL(47, 0) && val < GENMASK_ULL(63, 47)) {
		dev_err(zldev->dev, "Value 0x%0llx out of range\n", val);
		return -EINVAL;
	}
	...
}

so a positive tie_data in [2^47, 2^48) would be programmed with the sign bit
set.

Both in-tree callers do bound the input: zl3073x_dpll_ptp_adjphase() is
gated by ptp_clock_adjtime(), which rejects offsets beyond
getmaxphase() == NSEC_PER_SEC - 1, and zl3073x_dpll_ptp_adjtime() passes
only the sub-second remainder from div_s64_rem(delta, NSEC_PER_SEC, ...).

Would an explicit range check on delta_ns be worth adding here so the
documented precondition is enforced by the helper itself?
-- 
pw-bot: cr
