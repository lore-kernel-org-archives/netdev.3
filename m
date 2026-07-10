Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EA12E03EA
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695741; cv=none; b=jPwsWL9V3TTapKhbnIkLR+V3eEQSccYNgWxoo5Ikcy0yn2yTEgGISJ1ZqhMf/5HIjBTM2fey+s44Tw6WN2k7uaaZNVi5ohxu4GCIhL57THqsPRF2ZXivqudQo3qYFz5BEdgqOBM+Gj50Xw25ro6vAB1RUWa91lXODJDcBi4GRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695741; c=relaxed/simple;
	bh=VC2aLt5xGqWCaeFX3gaGSh8cQ0EvEjrjNxPJpbEFU6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhLJpyjw96sPHjw0Qto+AO9js0EFpAiE52c8EjUdNQoXze3H9Zn5E7uqgIvZ9Yglz1jhjGLLWWkN6D57So87Q+IvhrhZ0NawsO8j2V92BENhdlHc5AT67KJn7Iw0JSiwIhvxwio1XKkBcp+bYSh8Zbwxn/aI9TZ1c6BGC6VbXwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A/qvinZg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/qvinZg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783695738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UIG2WLp08SIydSpxG+p7zgGosCQ7dncVretYiXtFIxQ=;
	b=A/qvinZgsy3ukzbRL9mx7RHnRA9kl7xBLioUPRlnw0pnB7/hxHzBNKACEVZWLOJIlo/5/8
	BFRetDPQHMRgnEYYPBEjATOSjIfEg8Cz+4YueZBfQrSdDCOQog+cQnurn/QOmrQU4x3qWc
	WRsn8CDA6LBdfezEp1RXrURaRPlVZC0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-MEGIOh-eMUyvyYNgvbFudw-1; Fri,
 10 Jul 2026 11:02:14 -0400
X-MC-Unique: MEGIOh-eMUyvyYNgvbFudw-1
X-Mimecast-MFC-AGG-ID: MEGIOh-eMUyvyYNgvbFudw_1783695732
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB8D218009CC;
	Fri, 10 Jul 2026 15:02:11 +0000 (UTC)
Received: from [10.44.48.68] (unknown [10.44.48.68])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D9469414;
	Fri, 10 Jul 2026 15:02:07 +0000 (UTC)
Message-ID: <f5cab4c5-e2dd-46ca-b788-af0c7c4f77b3@redhat.com>
Date: Fri, 10 Jul 2026 17:02:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] dpll: zl3073x: add channel ToD and phase
 step operations
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Michal Schmidt <mschmidt@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Pasi Vaananen <pvaanane@redhat.com>,
 Petr Oros <poros@redhat.com>, Prathosh Satish
 <Prathosh.Satish@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20260708170527.916035-1-ivecera@redhat.com>
 <20260708170527.916035-2-ivecera@redhat.com>
 <c66e433b-654d-4c14-ad73-e3a93314d8d8@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <c66e433b-654d-4c14-ad73-e3a93314d8d8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95


On 7/10/26 2:56 PM, Vadim Fedorenko wrote:
> On 08/07/2026 18:05, Ivan Vecera wrote:
>> Add low-level DPLL channel operations for ToD read/write/adjust,
>> delta frequency offset write and output phase step. ToD operations
>> use a wait-before-write pattern to avoid blocking after each
>> operation. tod_adjust additionally waits for completion since callers
>> may follow with phase step operations.
>>
>> The tod_ready_wait helper selects the poll timeout based on the
>> current ToD command - write operations use a longer timeout (1000 ms)
>> than reads (30 ms).
>>
>> The ToD read captures system timestamps (ptp_system_timestamp) around
>> the HW command and completion poll to support cross-timestamping.
>>
>> Add output step-time mask invariant to zl3073x_chan and
>> zl3073x_chan_is_out_stepped() helper to check if an output
>> participates in step-time operations.
>>
> 
> [...]
> 
>> +/**
>> + * zl3073x_chan_tod_read - read ToD registers after issuing a command
>> + * @zldev: pointer to zl3073x device
>> + * @ch: DPLL channel index
>> + * @next_hz: if true, read predicted ToD at next 1 Hz; otherwise read 
>> current
>> + * @ts: timespec to store the result
>> + * @sts: optional system timestamp pair for cross-timestamping
>> + *
>> + * Context: Caller must serialize all zl3073x_chan_tod_* calls 
>> externally.
>> + * Return: 0 on success, <0 on error
>> + */
>> +int zl3073x_chan_tod_read(struct zl3073x_dev *zldev, u8 ch,
>> +              bool next_hz, struct timespec64 *ts,
>> +              struct ptp_system_timestamp *sts)
>> +{
>> +    u32 nsec;
>> +    u64 sec;
>> +    u8 cmd;
>> +    int rc;
>> +
>> +    if (next_hz)
>> +        cmd = ZL_DPLL_TOD_CTRL_CMD_RD_NEXT_1HZ;
>> +    else
>> +        cmd = ZL_DPLL_TOD_CTRL_CMD_RD_CURRENT;
>> +
>> +    /* Wait for any previous ToD operation to complete */
>> +    rc = zl3073x_chan_tod_ready_wait(zldev, ch);
>> +    if (rc)
>> +        return rc;
>> +
>> +    ptp_read_system_prets(sts);
>> +    rc = zl3073x_chan_tod_ctrl(zldev, ch, cmd);
>> +    if (rc)
>> +        return rc;
>> +
>> +    rc = zl3073x_chan_tod_ready_wait(zldev, ch);
>> +    if (rc)
>> +        return rc;
>> +    ptp_read_system_postts(sts);
> 
> AFAIU, this code means that the ToD value was somewhere between tod_ctrl
> command and tod_ready read value 0 of the register. How does it work
> with "predicted ToD at next 1 Hz"?

The ptp_system_timestamp is only used by the gettimex64 callback which
always calls tod_read with next_hz=false (current ToD). The next_hz=true
path is only used internally by tod_adjust() which passes sts=NULL.

So in practice, system timestamps are never captured around a predicted
ToD read. The function accepts both options through the same interface
for simplicity, but the sts parameter is only meaningful with
next_hz=false.

Thanks,
Ivan

