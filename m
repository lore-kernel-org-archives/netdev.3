Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE6A373C1A
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299783; cv=none; b=Sm/wAYt7HflzYMPZvsKjlmZ6oZAJ0xE1EzkgEeHU1s+Wd7ATtE0GsxYHeEMMlmvkY+ylP0hPBALtooXPYNQ2yyxPPtBOZcuHfcXqA6g/LU0mKwlNIKUYT6dce3lT7ow5SOhvUykrIBvcxWxRTiT7hCQBK/nJLtrDllrtron6GqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299783; c=relaxed/simple;
	bh=mtIiJqwqJ5mvXxzTwOuORacuIEDSYBlWw3WChdH1rXE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PSvNR5zj134pcJ5iBCgBuafTjqeEHr4cDQaKxgeX04ZvCsvJFwbN+g1VKWCsZPfWCdHuSGlW1zzacdWYiUbncgQRPR4M4SYHvOlHPqsrTxHRfF8D09uEaNWzUJB3OZONUMn3shPMjZy8AOYSc/gPzNToHLGhQnAi41pPq1AME1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDRsuBuD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDRsuBuD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786299780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scMyVWvoXyL/VuKW66NWEYrXv8U7Cnr2Dq8xlsoBFsU=;
	b=KDRsuBuDbw8vO8jxuxzuEZAsQ14ZJDLMW3K/MH0+6OxjCj5fR9pPZVVdMWmHfG7R7mYErb
	V5f+sC1ulp9Ajjx+tj1FeRf5jldrmaOMedp1wPHJ/4QQCVhVSq30+altffTOXiU+pILi9b
	Cr3XBDTdOdIlwKODRqrTa0D4vpyj80Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-LbVeloBoOTWel8o5qOAC7w-1; Sun,
 09 Aug 2026 14:22:45 -0400
X-MC-Unique: LbVeloBoOTWel8o5qOAC7w-1
X-Mimecast-MFC-AGG-ID: LbVeloBoOTWel8o5qOAC7w_1786299763
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 89B06180034F;
	Sun,  9 Aug 2026 18:22:43 +0000 (UTC)
Received: from [10.44.32.36] (unknown [10.44.32.36])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 324491800347;
	Sun,  9 Aug 2026 18:22:39 +0000 (UTC)
Message-ID: <667c004b-6181-41c5-bea1-0a66e354bc96@redhat.com>
Date: Sun, 9 Aug 2026 20:22:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/3] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-kernel@vger.kernel.org
References: <20260807095826.386756-1-ivecera@redhat.com>
 <20260807095826.386756-3-ivecera@redhat.com>
Content-Language: en-US
In-Reply-To: <20260807095826.386756-3-ivecera@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 8/7/26 11:58 AM, Ivan Vecera wrote:
> Add low-level DPLL channel operations for ToD read/write/adjust,
> output phase step, delta frequency offset write and TIE (Time
> Interval Error) write. These serve as building blocks for the PTP
> clock callbacks added in the next patch.
> 
> ToD operations use a wait-before-write pattern to avoid blocking
> after each operation.
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
> Add output step-time mask to struct zl3073x_dev and
> zl3073x_dev_out_is_stepped() helper to check if an output
> participates in step-time operations.
> 
> Reviewed-by: Petr Oros <poros@redhat.com>
> Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/dpll/zl3073x/chan.c | 321 +++++++++++++++++++++++++++++++++++-
>   drivers/dpll/zl3073x/chan.h |  32 ++++
>   drivers/dpll/zl3073x/core.c |  13 ++
>   drivers/dpll/zl3073x/core.h |  23 +++
>   drivers/dpll/zl3073x/regs.h |  52 ++++++
>   5 files changed, 439 insertions(+), 2 deletions(-)
> 
> ...
> +/**
> + * zl3073x_chan_tod_adjust - atomic ToD read-modify-write with rollover guard
> + * @zldev: pointer to zl3073x device
> + * @ch: DPLL channel index
> + * @delta: time adjustment to apply
> + *
> + * Reads the next-Hz ToD and current ToD, then checks whether enough time
> + * remains before the next 1 Hz rollover to safely complete the write.
> + * Re-reads if the 1 Hz tick crossed between the two reads or if less
> + * than 20 ms remains before the next rollover. Applies @delta and writes
> + * the result back.
> + *
> + * Context: Caller must serialize all zl3073x_chan_tod_* calls externally.
> + * Return: 0 on success, <0 on error
> + */
> +#define ZL_TOD_MAX_RETRIES	20
> +int zl3073x_chan_tod_adjust(struct zl3073x_dev *zldev, u8 ch,
> +			    struct timespec64 delta)
> +{

Oops, wrongly placed macro causing...


/logs/build/1142084/14736686/kdoc/stdout 0 ok |
raw

Warnings before patch:
files: ['drivers/dpll/zl3073x/chan.c', 'drivers/dpll/zl3073x/chan.h', 
'drivers/dpll/zl3073x/core.c', 'drivers/dpll/zl3073x/core.h', 
'drivers/dpll/zl3073x/regs.h']

Current warnings:
files: ['drivers/dpll/zl3073x/chan.c', 'drivers/dpll/zl3073x/chan.h', 
'drivers/dpll/zl3073x/core.c', 'drivers/dpll/zl3073x/core.h', 
'drivers/dpll/zl3073x/regs.h']
Warning: drivers/dpll/zl3073x/chan.c:399 expecting prototype for 
zl3073x_chan_tod_adjust(). Prototype was for ZL_TOD_MAX_RETRIES() instead

Warnings before: 0 after: 1 (add: 1)

New warnings added:
Warning: drivers/dpll/zl3073x/chan.c:399 expecting prototype for 
zl3073x_chan_tod_adjust(). Prototype was for ZL_TOD_MAX_RETRIES() instead
Per-file breakdown:
      1 drivers/dpll/zl3073x/chan.c


Will fix in v6.

Ivan

