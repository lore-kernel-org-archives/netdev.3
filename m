Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557EF350A35;
	Wed, 22 Jul 2026 20:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753683; cv=none; b=nllT/jgrZfLwKBRqSxtUqVglnxxqYYPKzCRi6S9RTYhcP1v0j21eDHmsDY8gcizvYALbfss+xQhbgiaNGJt0kYT8se37OoIalE2sI4u/PsOe34ROSgasv2NAPldJzK4ibsFZ4I8PZuqOsmMQF6+ADgXeZPxhGD+gJLHAHzNZmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753683; c=relaxed/simple;
	bh=69IbI2Kk/XnoLSVTOaqCyk4ju4V9qqX3hOycRK2d1rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIMkNkYpWbbefoxHAz4bsLWrc6y+0PKJC7Qdl/vB9FojT7MSUyoncF93vhBPYwEbO1fJb2Vgm+2NyFNXMOUqcOx2RJsQZ8uy04xU/1cc7XRP67MQYq7gm2s8Gam71a1zTaZx5Ygc6pmA2hiYlWIJsjvpc0DSI6kkAkug020L4v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db0nH/RE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db0nH/RE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71971F000E9;
	Wed, 22 Jul 2026 20:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784753682;
	bh=bQfXBRUXbjqh//8saXkb/n/f7dVGrUFiIarwOBQg3vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=db0nH/REsstKsepoHGYXZFwucbafeEvF3iDBReUCwQDUbrgETsrm3LEZ0nIDtjtVh
	 MnHCKGmeK38ZYhfydFJP735MRWGu8S3ljAuxzuBw+ywlbX78c5ZJJys2dgZtfseS3C
	 KTs3ErthbookKdbHmDlHefbeisY0rC1icmJILT4+L3z7qiZ2xz8CZv6hwORusJkizn
	 rqm4ojLkdNy7oVus/e8rmOqbSV9xL5IlIA4pqhyuOBa/GEt91V+SDxeAbyjYiX32SV
	 QABnlqxwQcTKkTx2vpPF0/Nn2Alpby9h8bRdrZFbePL2eSBQYZqZ8M1xquTGJRqTPf
	 zcSGxtOLyUYig==
From: Jakub Kicinski <kuba@kernel.org>
To: ivecera@redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Chris.duQuesnay@microchip.com,
	arkadiusz.kubalewski@intel.com,
	davem@davemloft.net,
	jiri@resnulli.us,
	mschmidt@redhat.com,
	pabeni@redhat.com,
	pvaanane@redhat.com,
	poros@redhat.com,
	Prathosh.Satish@microchip.com,
	richardcochran@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] dpll: zl3073x: add channel ToD, phase step and TIE operations
Date: Wed, 22 Jul 2026 13:54:40 -0700
Message-ID: <20260722205440.385494-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713103739.1553284-2-ivecera@redhat.com>
References: <20260713103739.1553284-2-ivecera@redhat.com>
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
--- Patch [1]: [PATCH net-next v2 1/2] dpll: zl3073x: add channel ToD, phase step and TIE operations ---
commit 4829f83428b4a90e412f8bc573a84b3869b68edb
Author: Ivan Vecera <ivecera@redhat.com>

dpll: zl3073x: add channel ToD, phase step and TIE operations

Add low-level DPLL channel operations for ToD read/write/adjust, output phase
step, delta frequency offset write and TIE write. These serve as building
blocks for the PTP clock callbacks.

> diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
> index 4ec2cf53dad46..53032e782fd4a 100644
> --- a/drivers/dpll/zl3073x/chan.c
> +++ b/drivers/dpll/zl3073x/chan.c
[ ... ]
> @@ -234,6 +240,307 @@ const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
[ ... ]
> +int zl3073x_chan_tod_read(struct zl3073x_dev *zldev, u8 ch,
> +			  bool next_hz, struct timespec64 *ts,
> +			  struct ptp_system_timestamp *sts)
> +{
[ ... ]
> +	ptp_read_system_prets(sts);
> +	rc = zl3073x_chan_tod_ctrl(zldev, ch, cmd);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
> +	if (rc)
> +		return rc;
> +	ptp_read_system_postts(sts);

[Severity: High]
Does this artificially inflate the cross-timestamp window?

For accurate PTP cross-timestamping, the prets and postts must closely bound
the exact moment the hardware latches the timestamp. The postts is captured
after zl3073x_chan_tod_ready_wait(), which can poll the device over I2C/SPI
for up to 30ms.

Including this transaction and polling delay inside the timestamping bracket
introduces significant jitter, destroying the precision of the
cross-timestamp.

[ ... ]
> +int zl3073x_chan_tod_adjust(struct zl3073x_dev *zldev, u8 ch,
> +			    struct timespec64 delta)
> +{
[ ... ]
> +	/* Read current ToD to determine remaining margin */
> +	rc = zl3073x_chan_tod_read(zldev, ch, false, &ts_cur, NULL);
> +	if (rc)
> +		return rc;
> +
> +	/* If too close to (or past) the next rollover, wait it out */
> +	diff = timespec64_sub(ts_next, ts_cur);
> +	if (diff.tv_sec < 0 || (!diff.tv_sec && diff.tv_nsec < threshold_ns)) {
> +		if (!diff.tv_sec && diff.tv_nsec)
> +			fsleep((unsigned long)diff.tv_nsec / NSEC_PER_USEC + 1);
> +		ts_next.tv_sec++;
> +	}

[Severity: High]
Is this adjustment vulnerable to thread preemption?

The code assumes exactly one 1Hz rollover occurred between reading ts_next and
ts_cur, and simply increments ts_next.tv_sec by 1. If the thread is preempted
for multiple seconds between the reads or before writing, multiple rollovers
will have occurred.

Incrementing by just 1 would leave the target ToD in the past, and writing it
back could cause the DPLL ToD to abruptly jump backwards, breaking PTP
synchronization.

[ ... ]
> +int zl3073x_chan_df_offset_set(struct zl3073x_dev *zldev, u8 ch, s64 offset)
> +{
> +	int rc;
> +
> +	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_DF_OFFSET(ch), offset);
> +	if (!rc)
> +		zldev->chan[ch].df_offset = offset;

[Severity: Medium]
Can this lead to torn reads on 32-bit platforms?

The 64-bit chan->df_offset is updated locklessly here, and can be read
concurrently by the driver's background monitor thread via
zl3073x_chan_df_offset_get().

Since 64-bit reads and writes are not atomic on 32-bit architectures, a torn
read could result in incorrect frequency offset calculations and spurious
netlink notifications.

[ ... ]
> +int zl3073x_chan_tie_write(struct zl3073x_dev *zldev, u8 ch, s64 delta_ns)
> +{
[ ... ]
> +	/* Convert ns to TIE units (0.01 ps = 10^-14 s) */
> +	tie_data = delta_ns * 100000LL;
> +
> +	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_TIE_DATA(ch), tie_data);

[Severity: High]
Does this calculation overflow the 48-bit signed hardware register for large
positive phase adjustments?

There is no programmatic bounds check enforcing the +-1s limit on delta_ns.
A positive phase adjustment exceeding ~1.4 seconds will produce a tie_data
value that exceeds the maximum positive 48-bit signed integer.

This sets bit 47 to 1. Because the value still fits within an unsigned 48-bit
integer, it bypasses the bounds check in zl3073x_write_u48(). The hardware
treats bit 47 as a sign bit, which would cause a massive negative phase jump
instead of a positive adjustment.

[ ... ]
> diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
> index 78dc208f3eea2..2dc836d0c8f6b 100644
> --- a/drivers/dpll/zl3073x/core.h
> +++ b/drivers/dpll/zl3073x/core.h
> @@ -26,6 +26,10 @@ struct zl3073x_dpll;
>  #define ZL_POLL_HWREG_TIMEOUT_US	(50 * USEC_PER_MSEC)
>  #define ZL_POLL_MB_TIMEOUT_US		(30 * USEC_PER_MSEC)
>  #define ZL_POLL_PHASE_ERR_TIMEOUT_US	(50 * USEC_PER_MSEC)
> +#define ZL_POLL_PHASE_STEP_TIMEOUT_US	(3000 * USEC_PER_MSEC)
> +#define ZL_POLL_TIE_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)
> +#define ZL_POLL_TOD_RD_TIMEOUT_US	(30 * USEC_PER_MSEC)
> +#define ZL_POLL_TOD_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)

[Severity: High]
Will these multi-second timeouts flood the communication bus and stall the CPU?

These timeout values are passed to zl3073x_poll_zero_u8(), which uses
regmap_read_poll_timeout() with a hardcoded sleep interval of 10 microseconds.

A sleep of 10us typically translates to a busy-wait via udelay(10) or triggers
extremely rapid back-to-back I2C/SPI transactions. Looping like this for up to
3 seconds will completely flood the communication bus and cause a massive CPU
stall for the duration of the timeout.
-- 
pw-bot: cr
