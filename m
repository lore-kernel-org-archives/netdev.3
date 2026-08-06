Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395EA3264EA
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026432; cv=none; b=HGggqcWKfcweLAqH+rVuMW9z4hjMVPlJivBD9IG1qpRxIx2wKP1rh2wDpLjTC+mhwOI6id9rNr6tt6VmQyK0M3J0bIYbxXPdebwlwkYuXGDyGLxav57DegEqConaknxEYnCpzcJgS5VsF7DPuBWnS+LX3TmPWd9xgVf7h/yVjTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026432; c=relaxed/simple;
	bh=OdYvo27cYJmTskeFS42f3AHx5tmQV7Xz+MWbEZm47A4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aBjaKmenPV6duL+damRk0GNOmckvlj3F3khL2Qp7xFG/Ffw090E25CJGW7FSUz864YmNctYvbX6/oCSXESGc78ZtuOJEx0yUQL89aYLxzxjStSDKcJeGUqfYDb+cNLVxKBkCvi6BkhiBIm2QF/RbFt4dd2D31apWCYVJcUip1Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAIh2uQ5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAIh2uQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786026430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/C4nRa34lKyttedwF2kyD7o9MlTFizHhgzhDb4TIVHc=;
	b=YAIh2uQ5PWPzIcwzpi5UsN7bZBRbMVhalI7ufZpnkas4Nap1kezkYn+nRw/UaeFK2chLnW
	LFKpgNp1y8mUBrbssnlBRpO3puaZaHHqwWuUCVfraEG8vn3SbJY4nTlbjM/ZEfSzqJEBWH
	WL3p4FK9XJZqmcVSy6gaPZecVwcA+kE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-45pxtHBJMP-kUBYt1l_zwQ-1; Thu,
 06 Aug 2026 10:27:06 -0400
X-MC-Unique: 45pxtHBJMP-kUBYt1l_zwQ-1
X-Mimecast-MFC-AGG-ID: 45pxtHBJMP-kUBYt1l_zwQ_1786026425
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2EAD1800879;
	Thu,  6 Aug 2026 14:27:04 +0000 (UTC)
Received: from [10.44.33.193] (unknown [10.44.33.193])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7E3C630002E9;
	Thu,  6 Aug 2026 14:27:00 +0000 (UTC)
Message-ID: <baa0fe21-4c07-49a3-b6c6-2071a59b2f55@redhat.com>
Date: Thu, 6 Aug 2026 16:26:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] dpll: zl3073x: add PTP clock support
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Paolo Abeni <pabeni@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260803140637.102339-1-ivecera@redhat.com>
 <20260803140637.102339-3-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260803140637.102339-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Sashiko findings with replies...

 > Do these three depends on lines remove the driver from configurations 
that
 > have CONFIG_PTP_1588_CLOCK=n? [...]
 > Is the hard dependency needed? [...] Would [PTP_1588_CLOCK_OPTIONAL] be a
 > better fit here?

This was explicitly requested by Jakub in his v2 review [1]. The driver's
PTP support is a core feature, not optional functionality.

[1] https://lore.kernel.org/netdev/20260722135848.2d401ada@kernel.org/

 > div_s64() truncates toward zero [...] does a delta smaller than one synth
 > period end up as a 0-cycle step?
 >
 > For a 100 MHz synth, a 5 ns request gives step_cycles == 0 [...]
 > Would it make sense to route the truncated residual through one of 
the finer
 > mechanisms [...]?

The synthesizer frequency range is 187.5-750 MHz, giving a step
resolution of 1.3-5.3 ns. The maximum truncation loss is therefore
one synthesizer period (~5 ns worst case), which is well below the
noise floor of any PTP servo. The servo will compensate for this
residual in the next correction cycle. Adding a secondary adjustment
path for a sub-5 ns residual would complicate the code for no
practical benefit.

 > When the phase step for the second or a later synth group fails, this 
returns
 > 0 after the warning. Does that leave the outputs of the remaining
 > synthesizers skewed from the ToD?
 >
 > [...] Would propagating the error, or retrying the remaining groups, be
 > preferable to reporting success here?

This is intentional. At this point the seconds have already been
committed via ToD and the first synth group has been stepped with
tod_step=true. Propagating the error would cause the PTP servo to
retry the full delta, applying the seconds component a second time -
a much worse outcome than leaving some outputs with a sub-second skew.
A regmap/bus error at this stage indicates a serious hardware problem
that dev_warn() surfaces appropriately. Retrying would likely hit the
same bus error.

 > Which synth period does the firmware really use for this ToD-only step?
 >
 > The doc block says "the FW uses the lowest-ID synth's period for the
 > conversion", but first_synth_freq is latched from the first synth 
that is both
 > enabled and assigned to this channel [...]

The comment is wrong, the code is right. first_synth_freq is the first
enabled synth assigned to this DPLL channel, not the globally lowest-ID
synth. I will fix the comment.

 > Is it intended that zldpll->lock is held across the multi-second hardware
 > waits that follow?
 >
 > [...] So one clock_adjtime() can park dpll_lock behind zldpll->lock 
for up
 > to seconds, which blocks dpll netlink operations [...]

This is intentional and follows the standard PTP driver pattern. The
lock serializes all DPLL and PTP operations for a given channel. The
timeouts are worst-case values - normal operations complete in
milliseconds (ToD reads ~1 ms, phase step completes within one synth
period). The tod_ready_wait for WR_NEXT_1HZ is the only one that
genuinely waits up to ~500 ms on average, but this only occurs for
multi-second adjtime calls (>= 1 s delta), which are rare one-shot
corrections. Splitting the lock would require re-validating channel
state between operations and introduce race conditions with mode
changes.

 > Should sec_adjusted be set before this tod_ready_wait() error return?
 >
 > [...] ptp_clock_adjtime() passes the error to userspace unchanged, so a
 > servo or tool that retries the same offset applies the whole-seconds
 > component a second time and the clock jumps by twice the seconds part.

The current ordering is correct. If tod_ready_wait() fails, we cannot
be certain that the WR_NEXT_1HZ was actually applied - the semaphore
timeout means we do not know whether the hardware committed the
seconds or not. Returning the error and letting the servo handle the
retry is the right behavior, because setting sec_adjusted = true
before confirmation would mask a genuine hardware failure and silently
report success when the adjustment may not have been applied at all.

 > Both mechanisms are asynchronous here, so can a gettimex64() right after
 > adjtime() observe a ToD that has not been stepped yet?
 >
 > [...] Should the phase step and TIE write get an equivalent wait before
 > success is returned to the PTP core?

In practice this is not a problem. PTP servos wait for the next sync
interval (typically 1-8 s) before reading the clock again. The phase
step completes within one synthesizer period (1.3-5.3 ns) and TIE
write settles within the DPLL loop bandwidth. A completion wait would
add up to 3 seconds of latency to every adjtime call for no practical
benefit - the sub-nanosecond residual from an in-flight phase step is
orders of magnitude below the servo's measurement noise.

 > Can this multiplication overflow s64 for a value the core lets through?
 >
 > [...] Since 125 is invertible modulo 2^64, a tx->freq around 10^17 can be
 > chosen so the wrapped ppb passes the max_adj test.

This is a pre-existing issue in the PTP core's scaled_ppm_to_ppb()
helper, not in this driver. For in-range values (bounded by max_adj =
10^7 ppb, |scaled_ppm| up to ~6.6e8), the product is ~4.4e16 which
is well within s64 range. Exploiting the wrap in scaled_ppm_to_ppb()
requires deliberately constructed tx->freq values around 10^17 and
CAP_SYS_TIME privilege. A driver-side guard would be papering over
a core bug.

 > The kernel-doc just above says "Return: 0 on success, -EOPNOTSUPP if 
NCO pin
 > is not connected", but this returns 0 for a non-NCO channel whenever
 > scaled_ppm == 0. [...]
 >
 > zl3073x_dpll_ptp_adjphase() has the same mismatch [...]

This is intentional - a zero adjustment is a no-op and succeeds
regardless of mode. Will update the kernel-doc to reflect this
behavior.

 > The name is built only from the per-device channel index, so two ZL3073x
 > chips in one system expose PTP clocks with identical ptp_clock_info.name
 > [...] Should dev_name(zldev->dev) be part of the PTP clock name too?

Good catch. Will include dev_name() in the PTP clock name, consistent
with the kworker naming pattern.

Thanks,
Ivan

