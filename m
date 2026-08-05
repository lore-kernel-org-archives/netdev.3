Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D823436F42D
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 10:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926785; cv=none; b=UezmB5tpubld+bokGU6E8p/bB08FQs7pHTSSHDDvgbASyc0BVkKsLg8scd1HynaO7u0KnsfufbNYW9FFkvEXr89lBkfPMsS6eYjORx1DvN1JTQ2qZAQWYWOwzxyPnSGgnq0KsrfW7mix/aZ3Op1gWSwflOikZKkCD2XbZv042aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926785; c=relaxed/simple;
	bh=kbVs+FmFCjQ3hfPyF/yxTShzmDkjl0zM5IPKc6rOaxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyR/9zKwADlIkozxoe14tJOmBJSHAysZbQ5YA4g6/fzKjK1FLUoXH+vGVnLYS1/K8BkJFvKskqVsU+WJdbq1Jq+t4qIFOL8JJ1C3Fl5QPo9HD/d8xynkW/tE/ey15mvHy7+1mOvkWh5ZEGPgkCyc8A7ZCBNHgYYLuzjO12VJI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gv+96amm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gv+96amm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785926782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtntRxA6O/rhXYFEshwuz+YgvPBzndTokOGzB8BnW3M=;
	b=gv+96amm+01ISntUnkcqIBQNisNkMaMc0VeWWpiXc+oCUr3CIX4tPtu93P49K+p5C+5zjA
	AIOffMnPITLzFQBhVjGmjBYsH0ftVLEAtilnI9meNhqZHjSf031ZaJ4MoJwb9+4qh8L7MF
	QM6GHe6BmMaGGMFR1ktP9F1umd6OAYY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-1jANVDrnPOGmdZlo748Krw-1; Wed,
 05 Aug 2026 06:46:19 -0400
X-MC-Unique: 1jANVDrnPOGmdZlo748Krw-1
X-Mimecast-MFC-AGG-ID: 1jANVDrnPOGmdZlo748Krw_1785926778
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26E4B1956040;
	Wed,  5 Aug 2026 10:46:17 +0000 (UTC)
Received: from [10.44.32.154] (unknown [10.44.32.154])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A29F1800598;
	Wed,  5 Aug 2026 10:46:13 +0000 (UTC)
Message-ID: <ce492b1d-b31e-4695-ab5d-4107491fd59d@redhat.com>
Date: Wed, 5 Aug 2026 12:46:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Paolo Abeni <pabeni@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
References: <20260803140637.102339-1-ivecera@redhat.com>
 <20260803140637.102339-2-ivecera@redhat.com>
 <bc5060c8-7709-4354-aa48-7f64b857c00c@linux.dev>
 <14086fc7-b8f3-47a4-87a4-5e02882b6bf1@redhat.com>
 <9124c698-2506-4fe6-893a-60e9f0cb241d@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <9124c698-2506-4fe6-893a-60e9f0cb241d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 8/5/26 12:03 PM, Vadim Fedorenko wrote:
> On 05/08/2026 10:48, Ivan Vecera wrote:
>> On 8/5/26 1:07 AM, Vadim Fedorenko wrote:
>>> On 03/08/2026 15:06, Ivan Vecera wrote:
>>>> Add low-level DPLL channel operations for ToD read/write/adjust,
>>>> output phase step, delta frequency offset write and TIE (Time
>>>> Interval Error) write. These serve as building blocks for the PTP
>>>> clock callbacks added in the next patch.
>>>>
>>>> ToD operations use a wait-before-write pattern to avoid blocking
>>>> after each operation.
>>>>
>>>> The tod_ready_wait helper selects the poll timeout based on the
>>>> current ToD command - write operations use a longer timeout (1000 ms)
>>>> than reads (30 ms).
>>>>
>>>> The ToD read captures system timestamps (ptp_system_timestamp) around
>>>> the HW command and completion poll to support cross-timestamping.
>>>>
>>>> The TIE write operation provides sub-picosecond resolution phase
>>>> adjustment for modes where the DPLL is tracking a reference
>>>> (AUTO and REFLOCK).
>>>>
>>>> Add output step-time mask to struct zl3073x_dev and
>>>> zl3073x_dev_out_is_stepped() helper to check if an output
>>>> participates in step-time operations.
>>>>
>>>> Reviewed-by: Petr Oros <poros@redhat.com>
>>>> Tested-by: Chris du Quesnay <Chris.duQuesnay@microchip.com>
>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>> ---
>>>>   drivers/dpll/zl3073x/chan.c | 310 ++++++++++++++++++++++++++++++++ 
>>>> +++-
>>>>   drivers/dpll/zl3073x/chan.h |  32 ++++
>>>>   drivers/dpll/zl3073x/core.c |  13 ++
>>>>   drivers/dpll/zl3073x/core.h |  23 +++
>>>>   drivers/dpll/zl3073x/regs.h |  52 ++++++
>>>>   5 files changed, 428 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/dpll/zl3073x/chan.c b/drivers/dpll/zl3073x/chan.c
>>>> index 4ec2cf53dad468..79874a9fdb4962 100644
>>>> --- a/drivers/dpll/zl3073x/chan.c
>>>> +++ b/drivers/dpll/zl3073x/chan.c
>>>> @@ -3,6 +3,7 @@
>>>>   #include <linux/cleanup.h>
>>>>   #include <linux/delay.h>
>>>>   #include <linux/dev_printk.h>
>>>> +#include <linux/ptp_clock_kernel.h>
>>>>   #include <linux/string.h>
>>>>   #include <linux/types.h>
>>>> @@ -162,8 +163,8 @@ int zl3073x_chan_nco_mode_set(struct zl3073x_dev 
>>>> *zldev, u8 index)
>>>>    * @zldev: pointer to zl3073x_dev structure
>>>>    * @index: DPLL channel index to fetch state for
>>>>    *
>>>> - * Reads the mode_refsel register and reference priority registers for
>>>> - * the given DPLL channel and stores the raw values for later use.
>>>> + * Reads the mode_refsel, status and reference priority registers for
>>>> + * the given DPLL channel and stores the values for later use.
>>>>    *
>>>>    * Return: 0 on success, <0 on error
>>>>    */
>>>> @@ -234,6 +235,311 @@ const struct zl3073x_chan 
>>>> *zl3073x_chan_state_get(struct zl3073x_dev *zldev,
>>>>       return &zldev->chan[index];
>>>>   }
>>>> +/**
>>>> + * zl3073x_chan_tod_ready_wait - wait for ToD semaphore to clear
>>>> + * @zldev: pointer to zl3073x device
>>>> + * @ch: DPLL channel index
>>>> + *
>>>> + * Polls the ToD control register until the semaphore bit is cleared,
>>>> + * indicating the device has completed the previous ToD operation.
>>>> + *
>>>> + * Return: 0 on success, -EBUSY if semaphore not cleared, <0 on error
>>>> + */
>>>> +int zl3073x_chan_tod_ready_wait(struct zl3073x_dev *zldev, u8 ch)
>>>> +{
>>>> +    unsigned int timeout;
>>>> +    u8 tod_ctrl;
>>>> +    int rc;
>>>> +
>>>> +    rc = zl3073x_read_u8(zldev, ZL_REG_DPLL_TOD_CTRL(ch), &tod_ctrl);
>>>> +    if (rc)
>>>> +        return rc;
>>>> +
>>>> +    switch (FIELD_GET(ZL_DPLL_TOD_CTRL_CMD, tod_ctrl)) {
>>>> +    case ZL_DPLL_TOD_CTRL_CMD_WR_NEXT_1HZ:
>>>> +        timeout = ZL_POLL_TOD_WR_TIMEOUT_US;
>>>> +        break;
>>>> +    default:
>>>> +        timeout = ZL_POLL_TOD_RD_TIMEOUT_US;
>>>> +        break;
>>>> +    }
>>>
>>> there are 3 cmds defined, but FIELD_GET(ZL_DPLL_TOD_CTRL_CMD) can return
>>> up to 16 possible values. I would explicitly put defined commands in
>>> cases and make default to ENOTSUPP..
>>
>> Hi Vadim,
>> the ZL_DPLL_TOD_CTRL_CMD bits are never filled by firmware (only the
>> semaphore bit) so the driver knows what it writes. So such check is not
>> necessary but if you want it I can add something like:
>>
>> ...
>>      case ZL_DPLL_TOD_CTRL_CMD_RD_CURRENT:
>>      case ZL_DPLL_TOD_CTRL_CMD_RD_NEXT_1HZ:
>>          timeout = ZL_POLL_TOD_RD_TIMEOUT_US;
>>          break;
>>      default:
>>          WARN_ON(1); /* this is really unexpected */
>>          return -ENOTSUPP;
>> ...
> 
> This looks a bit more safe, especially now while the driver is in active
> development. Let's add this part.
> 
> Thanks

OK, will update in v5.

Thanks,
Ivan

