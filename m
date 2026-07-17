Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD8336403D
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 08:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277717; cv=none; b=P7xKmRAdTRbMOAs8Qn3LkIBFmVGPRtnxmw4o1CGmZINqMNcZdEL2fpyQpRTibCXD4strtP5ZMIEhiAZTurjkTKYzenCs4Dx6i/ITOEI1cab34uSvG/SfnGNMKoVoRB8lDwxJPoQhtDRX2juWkXmq3U8Ea+0Q9SmYKkZJRzHeE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277717; c=relaxed/simple;
	bh=NaP1YHOmx6TR+O2m815RwV6a15+3JIjJExgFyMiMudI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpU6TF7ww97eUr2e52tz9Xi6WF2x2byYxkeRKkWv/yeJSyahl0+NgcOvjL+UXkwkYsZT1LCaOX47Q/u0BNEPqe7Vi0cfJTl8Vr48wXQyb9E1JhZPvjoEd9fexUEAU/CkNPlanLdv578UgLjl4n0x3wpHdzmsDepNfHR+QiV6Z54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOrLIch+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ipZkGqAZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOrLIch+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipZkGqAZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784277713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ni/V57Hwqx3x3R2n9E/iowBQcgMUSGwdNKn3ucTXYLI=;
	b=SOrLIch+pA4qnhF2WMUWXNLwIH7exrSeKI/J62ta1VTLIt9vux+L7LwWB7xaBxcYVHjynT
	4Pe6ngXrgb5fFR+M10rMCk91qc22MbZRjh6kDk3IG3r6WveaKXWs1gBjJE6NNS2UoP/aTU
	E7XebJbTG0rq13ceak95/oimM0bu9fs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-oxCPYvB8OBSEUPK9jlwgBQ-1; Fri, 17 Jul 2026 04:41:52 -0400
X-MC-Unique: oxCPYvB8OBSEUPK9jlwgBQ-1
X-Mimecast-MFC-AGG-ID: oxCPYvB8OBSEUPK9jlwgBQ_1784277711
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493ce08a6b4so68562835e9.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 01:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784277711; x=1784882511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ni/V57Hwqx3x3R2n9E/iowBQcgMUSGwdNKn3ucTXYLI=;
        b=ipZkGqAZamBINWKTBBWXc69U0/hbOCbrhxMBP5TBjoPOUDVmkK6i1GvMv9ZKnaDiv4
         R8IeutW1dS5Anazv0m9GRTKv7DeZtqBlq0y7i3uAm4FZuocuKKfhfN1OPC/XmyCIdr3b
         e8evkWC7ek+p/ktsGNHget0VQxTg+TrZENQR2WLcU1h2Ft1Dreb4qmaLA591dv5h1MV/
         H8rk5zgu504pEuVwH7GEpp8vR0hkNvpD2KCxwFvvlk6/drjH1aojSuMuP6D/qRbO/VZj
         OirJ5Zq/smSpreWJGb/ISOmZNO1PH1FzQzgWwdEHC4kwyvF5rhS4QWNWhtAO6V+Rl2G4
         5aGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784277711; x=1784882511;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ni/V57Hwqx3x3R2n9E/iowBQcgMUSGwdNKn3ucTXYLI=;
        b=R6BscJ4yAUduBkkg477k40/txRtSAfQJ4XfoIkJCqn0SYUeh3QEY8BIBj5yLYR4W1Q
         p5k4ylzPGs3dZOO/m9kX1Rj2p0QwtGvP6E23H3UDO6VT/4T6TYNyRzzQAgC7si789mal
         6XmZg0tNho7ay5hbbZ0XETzKdF5TIwC5s6nQDanUuJMPRzsUPc7xmsZ2YSpbflVSZh8A
         Ni7C2OxPD/ZiMlImatJdcvwCxo30s73Dus/4rV/P+/5yfKhXh5B3TQW+x6eO+TZAIHIp
         G9n8U92IiudNJCK0/T7orT+30Fhqvoa/ztUmR7/ew+uLJpWf6JtSFs7DrJbhUdJKutPA
         amVw==
X-Forwarded-Encrypted: i=1; AHgh+RrxUwa5ympCs/sK+ywcMISsqNchbdgnclizuRo+LNKJTsAynpQjN3MBko3VORqhOaxsT1CHjXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Kfe6z3yy4/s5ed0Kcog5G8X2AbXvq+CNcy8xrxIH+TfKfUzg
	mvHyhrC65g1JxnVXVBpS4BiK7vf5kEl2tX+cEkYB95vPKenz9n2LsTgGVsHT/ybK06i5ziHTU77
	MfSAiOrlP3wxWVRLJ4r8rX+37F6dCvDdImifIhvStqDargf5fmp03G1gb2LHEf4HwrVa2
X-Gm-Gg: AfdE7clj9zvTEluW47SX717A26gWGUzPed0Cm+H6scmIO6q/k0gsO4qbfuPrpdmpAUM
	LyWDXiHNMuGPC9Qx4yn1imRPP2tbptomBmT0wrvEfBZsSN1bY6kWBGkdEn4WlNeYnZSfVgiUi9a
	dB6AVpubpovW7LbPrrSwjAxP0QqOhzL07AVnARigUNytaZ2rrkW1Bf3vzx9VP5yAVPdb8ztObHn
	8jhouPA+urJSeJstxcI1ADIr7DOxP95jV9Gc13aRVb6+WfK+PikHVTgxU1+wPgzlvQ8dvzhVPmu
	74sAqpzDcC3fGEwLJcRtrBo5U7X/Re7PorZadHXi6Tk2414gwzJducZjeFlZNzGiWvIoiPnfSEQ
	=
X-Received: by 2002:a05:600c:6298:b0:493:c182:6b08 with SMTP id 5b1f17b1804b1-4954a5125a0mr18923185e9.36.1784277710775;
        Fri, 17 Jul 2026 01:41:50 -0700 (PDT)
X-Received: by 2002:a05:600c:6298:b0:493:c182:6b08 with SMTP id 5b1f17b1804b1-4954a5125a0mr18922445e9.36.1784277710135;
        Fri, 17 Jul 2026 01:41:50 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm29821645e9.3.2026.07.17.01.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 01:41:49 -0700 (PDT)
Message-ID: <6f547bbb-596b-4937-8a3d-3d59d9b5ca96@redhat.com>
Date: Fri, 17 Jul 2026 10:41:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org
Cc: Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260713103739.1553284-1-ivecera@redhat.com>
 <20260713103739.1553284-2-ivecera@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260713103739.1553284-2-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/13/26 12:37, Ivan Vecera wrote:
> Add low-level DPLL channel operations for ToD read/write/adjust,
> output phase step, delta frequency offset write and TIE (Time
> Interval Error) write. These serve as building blocks for the PTP
> clock callbacks added in the next patch.
>
> ToD operations use a wait-before-write pattern to avoid blocking
> after each operation. tod_adjust additionally waits for completion
> since callers may follow with phase step operations.
>
> The tod_ready_wait helper selects the poll timeout based on the
> current ToD command - write operations use a longer timeout (1000 ms)
> than reads (30 ms).
>
> The ToD read captures system timestamps (ptp_system_timestamp) around
> the HW command and completion poll to support cross-timestamping.
>
> The TIE write operation provides sub-picosecond resolution phase
> adjustment for modes where the DPLL is tracking a reference
> (AUTO and REFLOCK).
>
> Add output step-time mask invariant to zl3073x_chan and
> zl3073x_chan_is_out_stepped() helper to check if an output
> participates in step-time operations.
>
> Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/chan.c | 307 ++++++++++++++++++++++++++++++++++++
>   drivers/dpll/zl3073x/chan.h |  48 ++++++
>   drivers/dpll/zl3073x/core.c |   8 +
>   drivers/dpll/zl3073x/core.h |   8 +
>   drivers/dpll/zl3073x/regs.h |  56 +++++++
>   5 files changed, 427 insertions(+)
>
> diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
> index 4ec2cf53dad46..53032e782fd4a 100644
> --- a/drivers/dpll/zl3073x/chan.c
> +++ b/drivers/dpll/zl3073x/chan.c
> @@ -3,6 +3,7 @@
>   #include <linux/cleanup.h>
>   #include <linux/delay.h>
>   #include <linux/dev_printk.h>
> +#include <linux/ptp_clock_kernel.h>
>   #include <linux/string.h>
>   #include <linux/types.h>
>   
> @@ -202,6 +203,11 @@ int zl3073x_chan_state_fetch(struct zl3073x_dev *zldev, u8 index)
>   		zl3073x_chan_refsel_state_get(chan),
>   		zl3073x_chan_refsel_ref_get(chan));
>   
> +	rc = zl3073x_read_u16(zldev, ZL_REG_OUTPUT_STEP_TIME_MASK,
> +			      &chan->out_step_time_mask);
> +	if (rc)
> +		return rc;
> +
>   	guard(mutex)(&zldev->multiop_lock);
>   
>   	/* Read DPLL configuration from mailbox */
> @@ -234,6 +240,307 @@ const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
>   	return &zldev->chan[index];
>   }
>   
> +/**
> + * zl3073x_chan_tod_ready_wait - wait for ToD semaphore to clear
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + *
> + * Polls the ToD control register until the semaphore bit is cleared,
> + * indicating the device has completed the previous ToD operation.
> + *
> + * Return: 0 on success, -EBUSY if semaphore not cleared, <0 on error
> + */
> +static int zl3073x_chan_tod_ready_wait(struct zl3073x_dev *zldev, u8 ch)
> +{
> +	unsigned int timeout;
> +	u8 tod_ctrl;
> +	int rc;
> +
> +	rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch), &tod_ctrl);
> +	if (rc)
> +		return rc;
> +
> +	switch (FIELD_GET(ZL_DPLL_TOD_CTRL_CMD, tod_ctrl)) {
> +	case ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ:
> +		timeout = ZL_POLL_TOD_WR_TIMEOUT_US;
> +		break;
> +	default:
> +		timeout = ZL_POLL_TOD_RD_TIMEOUT_US;
> +		break;
> +	}
> +
> +	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch),
> +				  ZL_DPLL_TOD_CTRL_SEM, timeout);
> +
> +	return rc == -ETIMEDOUT ? -EBUSY : rc;
> +}
> +
> +/**
> + * zl3073x_chan_tod_ctrl - issue ToD command
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + * @cmd: ToD command to execute
> + *
> + * Writes the semaphore and command to dpll_tod_ctrl. The caller must
> + * ensure the device is ready (semaphore clear) before calling and
> + * must wait for completion if needed.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +static int zl3073x_chan_tod_ctrl(struct zl3073x_dev *zldev, u8 ch, u8 cmd)
> +{
> +	return zl3073x_write_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch),
> +				ZL_DPLL_TOD_CTRL_SEM | cmd);
> +}
> +
> +/**
> + * zl3073x_chan_tod_read - read ToD registers after issuing a command
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + * @next_hz: if true, read predicted ToD at next 1 Hz; otherwise read current
> + * @ts: timespec to store the result
> + * @sts: optional system timestamp pair for cross-timestamping
> + *
> + * Context: Caller must serialize all zl3073x_chan_tod_* calls externally.
> + * Return: 0 on success, <0 on error
> + */
> +int zl3073x_chan_tod_read(struct zl3073x_dev *zldev, u8 ch,
> +			  bool next_hz, struct timespec64 *ts,
> +			  struct ptp_system_timestamp *sts)
> +{
> +	u32 nsec;
> +	u64 sec;
> +	u8 cmd;
> +	int rc;
> +
> +	if (next_hz)
> +		cmd = ZL_DPLL_TOD_CTRL_CMD_RD_NEXT_1HZ;
> +	else
> +		cmd = ZL_DPLL_TOD_CTRL_CMD_RD_CURRENT;
> +
> +	/* Wait for any previous ToD operation to complete */
> +	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
> +	if (rc)
> +		return rc;
> +
> +	ptp_read_system_prets(sts);
> +	rc = zl3073x_chan_tod_ctrl(zldev, ch, cmd);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
> +	if (rc)
> +		return rc;
> +	ptp_read_system_postts(sts);
> +
> +	rc = zl3073x_read_u48(zldev, ZL_REG_DPLL_TOD_SEC(ch), &sec);
> +	if (rc)
> +		return rc;
> +
> +	/* HW nanoseconds are always in [0, NSEC_PER_SEC) range */
> +	rc = zl3073x_read_u32(zldev, ZL_REG_DPLL_TOD_NS(ch), &nsec);
> +	if (rc)
> +		return rc;
> +
> +	ts->tv_sec = sec;
> +	ts->tv_nsec = nsec;
> +
> +	return 0;
> +}
> +
> +/**
> + * zl3073x_chan_tod_write - write ToD registers and trigger 1 Hz update
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + * @ts: time to set
> + *
> + * Context: Caller must serialize all zl3073x_chan_tod_* calls externally.
> + * Return: 0 on success, <0 on error
> + */
> +int zl3073x_chan_tod_write(struct zl3073x_dev *zldev, u8 ch,
> +			   struct timespec64 ts)
> +{
> +	int rc;
> +
> +	/* Wait for any previous ToD operation to complete */
> +	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_TOD_SEC(ch), ts.tv_sec);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_write_u32(zldev, ZL_REG_DPLL_TOD_NS(ch), ts.tv_nsec);
> +	if (rc)
> +		return rc;
> +
> +	return zl3073x_chan_tod_ctrl(zldev, ch,
> +				    ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ);
> +}
> +
> +/**
> + * zl3073x_chan_tod_adjust - atomic ToD read-modify-write with rollover guard
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + * @delta: time adjustment to apply
> + *
> + * Reads the next-Hz ToD and current ToD, then checks whether enough time
> + * remains before the next 1 Hz rollover to safely complete the write.
> + * If less than 20 ms remains, waits for the rollover and increments the
> + * next-Hz seconds by one. Applies @delta and writes the result back.
> + *
> + * Context: Caller must serialize all zl3073x_chan_tod_* calls externally.
> + * Return: 0 on success, <0 on error
> + */
> +int zl3073x_chan_tod_adjust(struct zl3073x_dev *zldev, u8 ch,
> +			    struct timespec64 delta)
> +{
> +	static const long threshold_ns = 20 * NSEC_PER_MSEC;
> +	struct timespec64 ts_next, ts_cur, diff;
> +	int rc;
> +
> +	/* Read predicted ToD at next 1 Hz tick */
> +	rc = zl3073x_chan_tod_read(zldev, ch, true, &ts_next, NULL);
> +	if (rc)
> +		return rc;
> +
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
> +
> +	/* Apply delta to the next-Hz ToD */
> +	ts_next = timespec64_add(ts_next, delta);
> +	if (!timespec64_valid(&ts_next))
> +		return -EINVAL;
> +
> +	/* Write adjusted ToD back and wait for completion */
> +	rc = zl3073x_chan_tod_write(zldev, ch, ts_next);
> +	if (rc)
> +		return rc;
> +
> +	return zl3073x_chan_tod_ready_wait(zldev, ch);
> +}
> +
> +/**
> + * zl3073x_chan_df_offset_set - write delta frequency offset to hardware
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + * @offset: frequency offset in 2^-48 steps
> + *
> + * Return: 0 on success, <0 on error
> + */
> +int zl3073x_chan_df_offset_set(struct zl3073x_dev *zldev, u8 ch, s64 offset)
> +{
> +	int rc;
> +
> +	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_DF_OFFSET(ch), offset);
> +	if (!rc)
> +		zldev->chan[ch].df_offset = offset;
> +
> +	return rc;
> +}
> +
> +/**
> + * zl3073x_chan_tie_write - adjust DPLL phase using TIE write
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + * @delta_ns: phase adjustment in nanoseconds (must be within +-1s)
> + *
> + * Converts nanoseconds to TIE units (0.01 ps) and writes TIE data
> + * to the specified channel.
> + *
> + * Return: 0 on success, <0 on error
> + */
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
> +
> +	rc = zl3073x_write_u8(zldev, ZL_REG_DPLL_TIE_CTRL_MASK, BIT(ch));
> +	if (rc)
> +		return rc;
> +
> +	return zl3073x_write_u8(zldev, ZL_REG_DPLL_TIE_CTRL,
> +				ZL_DPLL_TIE_CTRL_OP_WR);
> +}
> +
> +/**
> + * zl3073x_chan_phase_step - execute one output phase step operation
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + * @out_mask: bitmask of outputs to step
> + * @step_cycles: phase step in synthesizer clock cycles
> + * @tod_step: also step the ToD counter
> + *
> + * All masked outputs must use synthesizers of the same frequency since
> + * the step value is in synthesizer clock cycles.
> + *
> + * Return: 0 on success, <0 on error
> + */
> +int zl3073x_chan_phase_step(struct zl3073x_dev *zldev, u8 ch,
> +			    u16 out_mask, s32 step_cycles,
> +			    bool tod_step)
> +{
> +	u8 ctrl;
> +	int rc;
> +
> +	guard(mutex)(&zldev->phase_step_lock);
> +
> +	/* Wait for any previous phase step operation to complete */
> +	rc = zl3073x_poll_zero_u8(zldev, ZL_REG_OUTPUT_PHASE_STEP_CTRL,
> +				  ZL_OUTPUT_PHASE_STEP_CTRL_OP,
> +				  ZL_POLL_PHASE_STEP_TIMEOUT_US);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_write_u32(zldev, ZL_REG_OUTPUT_PHASE_STEP_DATA,
> +			       step_cycles);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_write_u16(zldev, ZL_REG_OUTPUT_PHASE_STEP_MASK, out_mask);
> +	if (rc)
> +		return rc;
> +
> +	rc = zl3073x_write_u8(zldev, ZL_REG_OUTPUT_PHASE_STEP_NUMBER, 1);
> +	if (rc)
> +		return rc;
> +
> +	ctrl = FIELD_PREP(ZL_OUTPUT_PHASE_STEP_CTRL_DPLL, ch) |
> +	       FIELD_PREP(ZL_OUTPUT_PHASE_STEP_CTRL_OP,
> +			  ZL_OUTPUT_PHASE_STEP_CTRL_OP_WRITE);
> +	if (tod_step)
> +		ctrl |= ZL_OUTPUT_PHASE_STEP_CTRL_TOD_STEP;
> +
> +	return zl3073x_write_u8(zldev, ZL_REG_OUTPUT_PHASE_STEP_CTRL, ctrl);
> +}
> +
>   /**
>    * zl3073x_chan_state_set - commit DPLL channel state changes to hardware
>    * @zldev: pointer to zl3073x_dev structure
> diff --git a/drivers/dpll/zl3073x/chan.h b/drivers/dpll/zl3073x/chan.h
> index dc9c6d95bdee7..9dc5a3f1991f1 100644
> --- a/drivers/dpll/zl3073x/chan.h
> +++ b/drivers/dpll/zl3073x/chan.h
> @@ -5,10 +5,12 @@
>   
>   #include <linux/bitfield.h>
>   #include <linux/stddef.h>
> +#include <linux/time64.h>
>   #include <linux/types.h>
>   
>   #include "regs.h"
>   
> +struct ptp_system_timestamp;
>   struct zl3073x_dev;
>   
>   /**
> @@ -16,6 +18,7 @@ struct zl3073x_dev;
>    * @ctrl: DPLL control register value
>    * @mode_refsel: mode and reference selection register value
>    * @ref_prio: reference priority registers (4 bits per ref, P/N packed)
> + * @out_step_time_mask: output step-time mask
>    * @mon_status: monitor status register value
>    * @refsel_status: reference selection status register value
>    * @df_offset: frequency offset vs tracked reference in 2^-48 steps
> @@ -26,6 +29,9 @@ struct zl3073x_chan {
>   		u8	mode_refsel;
>   		u8	ref_prio[ZL3073X_NUM_REFS / 2];
>   	);
> +	struct_group(inv, /* Invariants */
> +		u16	out_step_time_mask;
> +	);
>   	struct_group(stat,
>   		u8	mon_status;
>   		u8	refsel_status;
> @@ -42,6 +48,20 @@ int zl3073x_chan_state_set(struct zl3073x_dev *zldev, u8 index,
>   int zl3073x_chan_state_update(struct zl3073x_dev *zldev, u8 index);
>   int zl3073x_chan_nco_mode_set(struct zl3073x_dev *zldev, u8 index);
>   
> +int zl3073x_chan_tod_read(struct zl3073x_dev *zldev, u8 ch,
> +			  bool next_hz, struct timespec64 *ts,
> +			  struct ptp_system_timestamp *sts);
> +int zl3073x_chan_tod_write(struct zl3073x_dev *zldev, u8 ch,
> +			   struct timespec64 ts);
> +int zl3073x_chan_tod_adjust(struct zl3073x_dev *zldev, u8 ch,
> +			    struct timespec64 delta);
> +int zl3073x_chan_phase_step(struct zl3073x_dev *zldev, u8 ch,
> +			    u16 out_mask, s32 step_cycles, bool tod_step);
> +
> +int zl3073x_chan_df_offset_set(struct zl3073x_dev *zldev, u8 ch, s64 offset);
> +
> +int zl3073x_chan_tie_write(struct zl3073x_dev *zldev, u8 ch, s64 delta_ns);
> +
>   /**
>    * zl3073x_chan_df_offset_get - get cached df_offset vs tracked reference
>    * @chan: pointer to channel state
> @@ -200,6 +220,21 @@ static inline bool zl3073x_chan_mode_is_reflock(const struct zl3073x_chan *chan)
>   	return zl3073x_chan_mode_get(chan) == ZL_DPLL_MODE_REFSEL_MODE_REFLOCK;
>   }
>   
> +/**
> + * zl3073x_chan_mode_supports_tie - check if channel mode supports TIE write
> + * @chan: pointer to channel state
> + *
> + * TIE write is supported in AUTO and REFLOCK modes regardless of lock state.
> + *
> + * Return: true if TIE write is supported, false otherwise
> + */
> +static inline bool
> +zl3073x_chan_mode_supports_tie(const struct zl3073x_chan *chan)
> +{
> +	return zl3073x_chan_mode_is_auto(chan) ||
> +		zl3073x_chan_mode_is_reflock(chan);
> +}
> +
>   /**
>    * zl3073x_chan_is_ho_ready - check if holdover is ready
>    * @chan: pointer to channel state
> @@ -233,4 +268,17 @@ static inline u8 zl3073x_chan_refsel_ref_get(const struct zl3073x_chan *chan)
>   	return FIELD_GET(ZL_DPLL_REFSEL_STATUS_REFSEL, chan->refsel_status);
>   }
>   
> +/**
> + * zl3073x_chan_is_out_stepped - check if output is in step-time mask
> + * @chan: pointer to channel state
> + * @out: output index
> + *
> + * Return: true if output is affected by step-time operations
> + */
> +static inline bool
> +zl3073x_chan_is_out_stepped(const struct zl3073x_chan *chan, u8 out)
> +{
> +	return !!(chan->out_step_time_mask & BIT(out));
> +}
> +
>   #endif /* _ZL3073X_CHAN_H */
> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index 7f5afaaae6342..b2f9fc97fd1b6 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c
> @@ -1033,6 +1033,14 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev)
>   	 * and/or polls are required to be done atomically.
>   	 */
>   	rc = devm_mutex_init(zldev->dev, &zldev->multiop_lock);
> +	if (rc)
> +		return dev_err_probe(zldev->dev, rc,
> +				     "Failed to initialize mutex\n");
> +	rc = devm_mutex_init(zldev->dev, &zldev->phase_step_lock);
> +	if (rc)
> +		return dev_err_probe(zldev->dev, rc,
> +				     "Failed to initialize mutex\n");
> +	rc = devm_mutex_init(zldev->dev, &zldev->tie_lock);
>   	if (rc)
>   		return dev_err_probe(zldev->dev, rc,
>   				     "Failed to initialize mutex\n");
> diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
> index 78dc208f3eea2..2dc836d0c8f6b 100644
> --- a/drivers/dpll/zl3073x/core.h
> +++ b/drivers/dpll/zl3073x/core.h
> @@ -26,6 +26,10 @@ struct zl3073x_dpll;
>   #define ZL_POLL_HWREG_TIMEOUT_US	(50 * USEC_PER_MSEC)
>   #define ZL_POLL_MB_TIMEOUT_US		(30 * USEC_PER_MSEC)
>   #define ZL_POLL_PHASE_ERR_TIMEOUT_US	(50 * USEC_PER_MSEC)
> +#define ZL_POLL_PHASE_STEP_TIMEOUT_US	(3000 * USEC_PER_MSEC)
> +#define ZL_POLL_TIE_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)
> +#define ZL_POLL_TOD_RD_TIMEOUT_US	(30 * USEC_PER_MSEC)
> +#define ZL_POLL_TOD_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)
>   
>   enum zl3073x_flags {
>   	ZL3073X_FLAG_REF_PHASE_COMP_32_BIT,
> @@ -55,6 +59,8 @@ struct zl3073x_chip_info {
>    * @regmap: regmap to access device registers
>    * @info: detected chip info
>    * @multiop_lock: to serialize multiple register operations
> + * @tie_lock: to serialize TIE write operations
> + * @phase_step_lock: to serialize output phase step operations
>    * @ref: array of input references' invariants
>    * @out: array of outs' invariants
>    * @synth: array of synths' invariants
> @@ -71,6 +77,8 @@ struct zl3073x_dev {
>   	struct regmap			*regmap;
>   	const struct zl3073x_chip_info	*info;
>   	struct mutex			multiop_lock;
> +	struct mutex			tie_lock;
> +	struct mutex			phase_step_lock;
>   
>   	/* Invariants */
>   	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
> diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
> index b70ead7d4495b..447757e99845d 100644
> --- a/drivers/dpll/zl3073x/regs.h
> +++ b/drivers/dpll/zl3073x/regs.h
> @@ -179,6 +179,20 @@
>   #define ZL_DPLL_DF_READ_CMD			GENMASK(2, 0)
>   #define ZL_DPLL_DF_READ_CMD_ACC_I		4
>   
> +#define ZL_REG_DPLL_TIE_CTRL			ZL_REG(5, 0x30, 1)
> +#define ZL_DPLL_TIE_CTRL_OP			GENMASK(2, 0)
> +#define ZL_DPLL_TIE_CTRL_OP_WR			4
> +
> +#define ZL_REG_DPLL_TIE_CTRL_MASK		ZL_REG(5, 0x31, 1)
> +
> +#define ZL_REG_DPLL_TOD_CTRL(_idx)					\
> +	ZL_REG_IDX(_idx, 5, 0x38, 1, 8, 1)
> +#define ZL_DPLL_TOD_CTRL_SEM			BIT(4)
> +#define ZL_DPLL_TOD_CTRL_CMD			GENMASK(3, 0)
> +#define ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ	1
> +#define ZL_DPLL_TOD_CTRL_CMD_RD_CURRENT	8
> +#define ZL_DPLL_TOD_CTRL_CMD_RD_NEXT_1HZ	9
> +
>   #define ZL_REG_DPLL_MEAS_CTRL			ZL_REG(5, 0x50, 1)
>   #define ZL_DPLL_MEAS_CTRL_EN			BIT(0)
>   #define ZL_DPLL_MEAS_CTRL_AVG_FACTOR		GENMASK(7, 4)
> @@ -193,6 +207,9 @@
>   
>   /*******************************
>    * Register Pages 6-7, DPLL Data
> + *
> + * Per-channel registers with stride 0x20. Channels 0-3 reside on page 6,
> + * channel 4 on page 7.
>    *******************************/
>   
>   #define ZL_REG_DPLL_DF_OFFSET_03(_idx)					\
> @@ -202,6 +219,24 @@
>   	((_idx) < 4 ? ZL_REG_DPLL_DF_OFFSET_03(_idx) : ZL_REG_DPLL_DF_OFFSET_4)
>   #define ZL_DPLL_DF_OFFSET_UNKNOWN	S64_MIN
>   
> +#define ZL_REG_DPLL_TIE_DATA_03(_idx)					\
> +	ZL_REG_IDX(_idx, 6, 0x0C, 6, 4, 0x20)
> +#define ZL_REG_DPLL_TIE_DATA_4			ZL_REG(7, 0x0C, 6)
> +#define ZL_REG_DPLL_TIE_DATA(_idx)					\
> +	((_idx) < 4 ? ZL_REG_DPLL_TIE_DATA_03(_idx) : ZL_REG_DPLL_TIE_DATA_4)
> +
> +#define ZL_REG_DPLL_TOD_SEC_03(_idx)					\
> +	ZL_REG_IDX(_idx, 6, 0x12, 6, 4, 0x20)
> +#define ZL_REG_DPLL_TOD_SEC_4			ZL_REG(7, 0x12, 6)
> +#define ZL_REG_DPLL_TOD_SEC(_idx)					\
> +	((_idx) < 4 ? ZL_REG_DPLL_TOD_SEC_03(_idx) : ZL_REG_DPLL_TOD_SEC_4)
> +
> +#define ZL_REG_DPLL_TOD_NS_03(_idx)					\
> +	ZL_REG_IDX(_idx, 6, 0x18, 4, 4, 0x20)
> +#define ZL_REG_DPLL_TOD_NS_4			ZL_REG(7, 0x18, 4)
> +#define ZL_REG_DPLL_TOD_NS(_idx)					\
> +	((_idx) < 4 ? ZL_REG_DPLL_TOD_NS_03(_idx) : ZL_REG_DPLL_TOD_NS_4)
> +
>   /***********************************
>    * Register Page 9, Synth and Output
>    ***********************************/
> @@ -221,6 +256,8 @@
>   #define ZL_OUTPUT_CTRL_EN			BIT(0)
>   #define ZL_OUTPUT_CTRL_SYNTH_SEL		GENMASK(6, 4)
>   
> +#define ZL_REG_OUTPUT_STEP_TIME_MASK		ZL_REG(9, 0x36, 2)
> +
>   /*******************************
>    * Register Page 10, Ref Mailbox
>    *******************************/
> @@ -316,6 +353,25 @@
>   #define ZL_REG_OUTPUT_ESYNC_WIDTH		ZL_REG(14, 0x18, 4)
>   #define ZL_REG_OUTPUT_PHASE_COMP		ZL_REG(14, 0x20, 4)
>   
> +/***********************************
> + * Register Page 9, Output Phase Step
> + ***********************************/
> +
> +#define ZL_REG_OUTPUT_PHASE_STEP_CTRL		ZL_REG(9, 0x38, 1)
> +#define ZL_OUTPUT_PHASE_STEP_CTRL_DPLL		GENMASK(6, 4)
> +#define ZL_OUTPUT_PHASE_STEP_CTRL_TOD_STEP	BIT(3)
> +#define ZL_OUTPUT_PHASE_STEP_CTRL_OP		GENMASK(1, 0)
> +#define ZL_OUTPUT_PHASE_STEP_CTRL_OP_NONE	0
> +#define ZL_OUTPUT_PHASE_STEP_CTRL_OP_RESET	1
> +#define ZL_OUTPUT_PHASE_STEP_CTRL_OP_READ	2
> +#define ZL_OUTPUT_PHASE_STEP_CTRL_OP_WRITE	3
> +
> +#define ZL_REG_OUTPUT_PHASE_STEP_NUMBER		ZL_REG(9, 0x39, 1)
> +
> +#define ZL_REG_OUTPUT_PHASE_STEP_MASK		ZL_REG(9, 0x3a, 2)
> +
> +#define ZL_REG_OUTPUT_PHASE_STEP_DATA		ZL_REG(9, 0x3c, 4)
> +
>   /*
>    * Register Page 255 - HW registers access
>    */

lgtm,

Reviewed-by: Petr Oros <poros@redhat.com>


