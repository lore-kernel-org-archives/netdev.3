Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09154322F7
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694841; cv=none; b=byWDM/L2ExAJcZk6InrsMa9pYSmqlDEyQ9W9i3dVofGGcEfW4nVcQe6lGYqrVFPwD2cJNZ7EIGf8fHlpur2TSrEw3U+MQRuFm2sz5r8kcoHb+gqGc1VlG07FXd3mzbXlUWWiuSuwIwxz9fPxIYAnKpJiRRW5jTJPHRlPhRVoPR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694841; c=relaxed/simple;
	bh=lozlP9L3eAY8D2lHlsSzUNCV3D/66XCaVi1LGP3HanI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYKN678EsO5FdH6uaB+fd5abfTN/gmBUJolJvU6s5DFygl37EdPhmP57R9lIEUDAPbC6UAQsM08RqDzr10w/UQgO/UUK+fhIj9//hUBUEOkJBnvL/N8Ihr8/ews7i+tkdHvdxTV6uTZDNbAusNgyh2kH9aCtYF3Jxs6ytedTBjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IQ96MLZb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQ96MLZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786694838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIAD1LGu+O2XyRQe94lFbXJERGzEOqBmE4EAxJP+aNc=;
	b=IQ96MLZbQABp7TjHbRoMpbzJlqCD7EEp/HZdHiNCi9CKHYKsGq//4mLg+4Ia76QCc+ChfU
	X0WnPC2EzE1DIaWHduD7qleW1qbIAUwyYO5JKIMTADn4lLU2EGa6iBdsDoY/A72ow4qKW4
	QOqB94GluCmlSjp+UZI/kl1ZwouEbkw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-zbEVyS8-NjyajH5-aXNWbQ-1; Fri,
 14 Aug 2026 04:07:15 -0400
X-MC-Unique: zbEVyS8-NjyajH5-aXNWbQ-1
X-Mimecast-MFC-AGG-ID: zbEVyS8-NjyajH5-aXNWbQ_1786694833
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 032DE180074B;
	Fri, 14 Aug 2026 08:07:13 +0000 (UTC)
Received: from [10.44.32.131] (unknown [10.44.32.131])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AE723180049F;
	Fri, 14 Aug 2026 08:07:09 +0000 (UTC)
Message-ID: <49dd691c-088f-41f9-8334-a6319096caed@redhat.com>
Date: Fri, 14 Aug 2026 10:07:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/3] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Min Li <min.li@microchip.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-kernel@vger.kernel.org
References: <20260811134700.1211010-1-ivecera@redhat.com>
 <20260811134700.1211010-3-ivecera@redhat.com>
 <dfbb7647-8c39-4620-9eb6-74d84b066f19@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <dfbb7647-8c39-4620-9eb6-74d84b066f19@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 8/13/26 11:21 PM, Vadim Fedorenko wrote:
> On 11/08/2026 14:46, Ivan Vecera wrote:
> 
> [...]
> 
>> + * zl3073x_chan_tod_adjust - atomic ToD read-modify-write with 
>> rollover guard
>> + * @zldev: pointer to zl3073x device
>> + * @ch: DPLL channel index
>> + * @delta: time adjustment to apply
>> + *
>> + * Reads the next-Hz ToD and current ToD, then checks whether enough 
>> time
>> + * remains before the next 1 Hz rollover to safely complete the write.
>> + * Re-reads if the 1 Hz tick crossed between the two reads or if less
>> + * than 20 ms remains before the next rollover. Applies @delta and 
>> writes
>> + * the result back.
> 
> you keep 20ms threshold based on the avg read/write transaction time (I
> assume), but it may happen, that this call will be preempted in between
> reads and write, and 20ms will not be enough before 1Hz rollover. Have
> you though about such option?

Yes, this is a possibility. The 20 ms threshold provides margin for
the write sequence (ready-wait + three register writes + command)
which normally completes in single-digit milliseconds, but a
scheduling delay could consume the remaining margin.

If that happens, the hardware applies the written value at the
following 1 Hz edge instead of the intended one, resulting in a
1 second ToD offset. The PTP servo detects and corrects this in the
next cycle. There is no atomic ToD update command in the hardware,
so this trade-off is inherent to the device's register interface.

I tried to run 1000x times loop with comparing jiffies after ToD read
and after ToD write. The testptp that adjusted ToD has been pinned to
single CPU and parallel stress CPU program on the same CPU during
testing. The average time for write-tod operation was 9ms with maximum
of 10ms.

> 
>> + *
>> + * Context: Caller must serialize all zl3073x_chan_tod_* calls 
>> externally.
>> + * Return: 0 on success, <0 on error
>> + */
>> +int zl3073x_chan_tod_adjust(struct zl3073x_dev *zldev, u8 ch,
>> +                struct timespec64 delta)
>> +{
>> +#define ZL_TOD_MAX_RETRIES    20
>> +    static const long threshold_ns = 20 * NSEC_PER_MSEC;
>> +    struct timespec64 ts_next, ts_cur, diff;
>> +    int rc, i;
>> +
>> +    for (i = 0; i < ZL_TOD_MAX_RETRIES; i++) {
>> +        rc = zl3073x_chan_tod_read(zldev, ch, true, &ts_next, NULL);
>> +        if (rc)
>> +            return rc;
>> +
>> +        rc = zl3073x_chan_tod_read(zldev, ch, false, &ts_cur, NULL);
>> +        if (rc)
>> +            return rc;
>> +
>> +        /* Ensure the 1 Hz tick did not cross between the two reads
>> +         * and that enough margin remains to complete the write.
>> +         */
>> +        diff = timespec64_sub(ts_next, ts_cur);
>> +        if (diff.tv_sec > 0 ||
>> +            (!diff.tv_sec && diff.tv_nsec >= threshold_ns))
>> +            break;
>> +    }
>> +    if (i == ZL_TOD_MAX_RETRIES) {
>> +        dev_warn(zldev->dev,
>> +             "DPLL%u ToD adjust failed to get stable margin\n",
>> +             ch);
>> +        return -EBUSY;
>> +    }
>> +
>> +    /* Apply delta to the next-Hz ToD */
>> +    ts_next = timespec64_add(ts_next, delta);
>> +    if (!timespec64_valid(&ts_next))
> 
> maybe timespec64_valid_settod() will be better as the code is about
> modifying ToD?

Good point. Will switch to timespec64_valid_settod() in v8.

Ivan

