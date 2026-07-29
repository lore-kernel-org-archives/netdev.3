Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B761C4C0409
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349611; cv=none; b=XKFgYBw6SNxCOlwPDGh2nWHcrXk0vElJHi+F1A1PmIkNyEx7+Ra0Lr8jcz3TAnI2ZLCR4O3v945pMI8hlsnUEQXpslBM34/f0UuGu6Nh5ybKN9kx4Z0GRLdkUuYegniuMOaM+GHxOfbNmIEIj7CUx3kdzKgQLo5cONSQgpuj6EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349611; c=relaxed/simple;
	bh=QZSwQsEhLEeQC07YvqI5LXZIBwG7ZRpeFP26EP0NB1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDSI3BQnXUK+7MnCZoeAiX5kLZIMmtvzHjpvbeC0pW9Ug+DcBwjtb0JHj2tliYMl13dpwJomvog/Jkc5/ikjLxj3vstNcTPo7EtO8DgP9fIl2SGkOJP/VXJX0oiEa2TG6HAejtD1eRYN1XieHYNm1CCGMyxSrX1ACv0PxhMzh/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuVvdGvw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuVvdGvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785349602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DW4EBNNtXYA8kfr1lBF6FaFUMRgu6pG06BqytYKR0hc=;
	b=DuVvdGvwJn0ZOd+curWcQ7xR/JsNG7YtS2KxCRs3DSRdYiBLqrbCNbCJQip8gy6O4I7RAO
	+CmKp5ZLe2JTYz9EuBaXDhma2vkak4x+D7LungstX6lv+H2Xs6uDB983Hdinc1EeacIP3P
	4PWpgCcaQieLvDB8BdlhB5m9ze0wtF4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-hbid72w7OGOfAarX0C2CAA-1; Wed,
 29 Jul 2026 14:26:38 -0400
X-MC-Unique: hbid72w7OGOfAarX0C2CAA-1
X-Mimecast-MFC-AGG-ID: hbid72w7OGOfAarX0C2CAA_1785349596
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C8B31956089;
	Wed, 29 Jul 2026 18:26:36 +0000 (UTC)
Received: from [10.44.48.170] (unknown [10.44.48.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84A67180044F;
	Wed, 29 Jul 2026 18:26:31 +0000 (UTC)
Message-ID: <3238d14f-2843-4595-b49c-d914a6c1009d@redhat.com>
Date: Wed, 29 Jul 2026 20:26:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Chris.duQuesnay@microchip.com,
 arkadiusz.kubalewski@intel.com, davem@davemloft.net, jiri@resnulli.us,
 mschmidt@redhat.com, pabeni@redhat.com, pvaanane@redhat.com,
 poros@redhat.com, Prathosh.Satish@microchip.com, richardcochran@gmail.com,
 horms@kernel.org, vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org
References: <20260713103739.1553284-2-ivecera@redhat.com>
 <20260722205440.385494-1-kuba@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260722205440.385494-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 7/22/26 10:54 PM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> --- Patch [1]: [PATCH net-next v2 1/2] dpll: zl3073x: add channel ToD, phase step and TIE operations ---
> commit 4829f83428b4a90e412f8bc573a84b3869b68edb
> Author: Ivan Vecera <ivecera@redhat.com>
> 
> dpll: zl3073x: add channel ToD, phase step and TIE operations
> 
> Add low-level DPLL channel operations for ToD read/write/adjust, output phase
> step, delta frequency offset write and TIE write. These serve as building
> blocks for the PTP clock callbacks.
> 
>> diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
>> index 4ec2cf53dad46..53032e782fd4a 100644
>> --- a/drivers/dpll/zl3073x/chan.c
>> +++ b/drivers/dpll/zl3073x/chan.c
> [ ... ]
>> @@ -234,6 +240,307 @@ const struct zl3073x_chan *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
> [ ... ]
>> +int zl3073x_chan_tod_read(struct zl3073x_dev *zldev, u8 ch,
>> +			  bool next_hz, struct timespec64 *ts,
>> +			  struct ptp_system_timestamp *sts)
>> +{
> [ ... ]
>> +	ptp_read_system_prets(sts);
>> +	rc = zl3073x_chan_tod_ctrl(zldev, ch, cmd);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = zl3073x_chan_tod_ready_wait(zldev, ch);
>> +	if (rc)
>> +		return rc;
>> +	ptp_read_system_postts(sts);
> 
> [Severity: High]
> Does this artificially inflate the cross-timestamp window?
> 
> For accurate PTP cross-timestamping, the prets and postts must closely bound
> the exact moment the hardware latches the timestamp. The postts is captured
> after zl3073x_chan_tod_ready_wait(), which can poll the device over I2C/SPI
> for up to 30ms.
> 
> Including this transaction and polling delay inside the timestamping bracket
> introduces significant jitter, destroying the precision of the
> cross-timestamp.
> 
> [ ... ]

Yes, unfortunately the hardware does not latch the system time at the
moment of the ToD capture. The prets/postts bracket necessarily includes
the I2C/SPI round-trip for issuing the command and polling for
completion. This is a hardware limitation - there is no interrupt for
ToD read completion. The resulting window is comparable to other
I2C/SPI-attached PTP devices (e.g. ptp_clockmatrix).

>> +int zl3073x_chan_tod_adjust(struct zl3073x_dev *zldev, u8 ch,
>> +			    struct timespec64 delta)
>> +{
> [ ... ]
>> +	/* Read current ToD to determine remaining margin */
>> +	rc = zl3073x_chan_tod_read(zldev, ch, false, &ts_cur, NULL);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* If too close to (or past) the next rollover, wait it out */
>> +	diff = timespec64_sub(ts_next, ts_cur);
>> +	if (diff.tv_sec < 0 || (!diff.tv_sec && diff.tv_nsec < threshold_ns)) {
>> +		if (!diff.tv_sec && diff.tv_nsec)
>> +			fsleep((unsigned long)diff.tv_nsec / NSEC_PER_USEC + 1);
>> +		ts_next.tv_sec++;
>> +	}
> 
> [Severity: High]
> Is this adjustment vulnerable to thread preemption?
> 
> The code assumes exactly one 1Hz rollover occurred between reading ts_next and
> ts_cur, and simply increments ts_next.tv_sec by 1. If the thread is preempted
> for multiple seconds between the reads or before writing, multiple rollovers
> will have occurred.
> 
> Incrementing by just 1 would leave the target ToD in the past, and writing it
> back could cause the DPLL ToD to abruptly jump backwards, breaking PTP
> synchronization.
> 
> [ ... ]

In theory yes - a multi-second preemption between the two ToD reads
could cause the written value to be stale. In practice this is
unrealistic: the two reads are microseconds apart over I2C/SPI, and
the function runs under zldpll->lock serializing all channel
operations. A preemption long enough to span multiple 1 Hz rollovers
would indicate a system-level problem far beyond PTP accuracy. The PTP
servo would recover from a one-time ToD discontinuity in any case.

>> +int zl3073x_chan_df_offset_set(struct zl3073x_dev *zldev, u8 ch, s64 offset)
>> +{
>> +	int rc;
>> +
>> +	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_DF_OFFSET(ch), offset);
>> +	if (!rc)
>> +		zldev->chan[ch].df_offset = offset;
> 
> [Severity: Medium]
> Can this lead to torn reads on 32-bit platforms?
> 
> The 64-bit chan->df_offset is updated locklessly here, and can be read
> concurrently by the driver's background monitor thread via
> zl3073x_chan_df_offset_get().
> 
> Since 64-bit reads and writes are not atomic on 32-bit architectures, a torn
> read could result in incorrect frequency offset calculations and spurious
> netlink notifications.
> 
> [ ... ]

No. Both the write in zl3073x_chan_df_offset_set() and the read in the
periodic monitor happen under zldpll->lock, so concurrent access is not
possible.

>> +int zl3073x_chan_tie_write(struct zl3073x_dev *zldev, u8 ch, s64 delta_ns)
>> +{
> [ ... ]
>> +	/* Convert ns to TIE units (0.01 ps = 10^-14 s) */
>> +	tie_data = delta_ns * 100000LL;
>> +
>> +	rc = zl3073x_write_u48(zldev, ZL_REG_DPLL_TIE_DATA(ch), tie_data);
> 
> [Severity: High]
> Does this calculation overflow the 48-bit signed hardware register for large
> positive phase adjustments?
> 
> There is no programmatic bounds check enforcing the +-1s limit on delta_ns.
> A positive phase adjustment exceeding ~1.4 seconds will produce a tie_data
> value that exceeds the maximum positive 48-bit signed integer.
> 
> This sets bit 47 to 1. Because the value still fits within an unsigned 48-bit
> integer, it bypasses the bounds check in zl3073x_write_u48(). The hardware
> treats bit 47 as a sign bit, which would cause a massive negative phase jump
> instead of a positive adjustment.
> 
> [ ... ]

The callers enforce the bounds:
- adjphase passes an s32 (max +-2.1s, but getmaxphase limits it to
   +-999999999 ns)
- adjtime passes only the sub-second remainder after splitting
   multi-second deltas into a ToD read-modify-write

Both are well within the 48-bit signed range (max ~1.4s). Adding an
explicit clamp would be misleading since the PTP core already enforces
getmaxphase.

>> diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
>> index 78dc208f3eea2..2dc836d0c8f6b 100644
>> --- a/drivers/dpll/zl3073x/core.h
>> +++ b/drivers/dpll/zl3073x/core.h
>> @@ -26,6 +26,10 @@ struct zl3073x_dpll;
>>   #define ZL_POLL_HWREG_TIMEOUT_US	(50 * USEC_PER_MSEC)
>>   #define ZL_POLL_MB_TIMEOUT_US		(30 * USEC_PER_MSEC)
>>   #define ZL_POLL_PHASE_ERR_TIMEOUT_US	(50 * USEC_PER_MSEC)
>> +#define ZL_POLL_PHASE_STEP_TIMEOUT_US	(3000 * USEC_PER_MSEC)
>> +#define ZL_POLL_TIE_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)
>> +#define ZL_POLL_TOD_RD_TIMEOUT_US	(30 * USEC_PER_MSEC)
>> +#define ZL_POLL_TOD_WR_TIMEOUT_US	(1000 * USEC_PER_MSEC)
> 
> [Severity: High]
> Will these multi-second timeouts flood the communication bus and stall the CPU?
> 
> These timeout values are passed to zl3073x_poll_zero_u8(), which uses
> regmap_read_poll_timeout() with a hardcoded sleep interval of 10 microseconds.
> 
> A sleep of 10us typically translates to a busy-wait via udelay(10) or triggers
> extremely rapid back-to-back I2C/SPI transactions. Looping like this for up to
> 3 seconds will completely flood the communication bus and cause a massive CPU
> stall for the duration of the timeout.

regmap_read_poll_timeout() uses usleep_range() internally, not udelay(). 
The polling interval (10 us min sleep) yields cooperative scheduling,
not busy-waiting. This is the standard pattern used across the driver
and other regmap-based polling in the kernel.

Thanks,
Ivan

