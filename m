Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE233BCD26
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 11:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786532441; cv=none; b=WWnBhQ9QjVr+0oQGWto8QjSlEJy6+8dk9YwBQexO3xdjG4hkXCaR01W1AI0SQlJS7AkNtBG/w7rtoU2dM9JJMzOZP0VATHEGZxXfgp0kyyJfzBJxiOu97A5X/1DmcbHKvEcJ/sR1jOQ2iBYqU9h2OkrkhD+sLcs42LO5oZvAF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786532441; c=relaxed/simple;
	bh=sEn9yBwVz9Dwu3R1Eqs5zQW2s30OkTVvp5AgqTpKIrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TrYRpKMS0dDEkH1xF0Qd1rCH372ITgQRenR6ziUy1iFulqGa/ehy1jNj4IaUL7ahoX3GDdF2bqe4Yy5fluvro40T6exSVWgyxeg3g9ElXAsjaFEaVmBrlgnj7sqV4sLSi+2Yz1MHBWD49e4oj/V1pazpQ3AmXYuLfcLbqLgL0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJGroeZK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJGroeZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786532438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xVToQ3uHnRPP07YMgbfL9vmFMIzga0qS0jpxd+o5wYA=;
	b=JJGroeZKdzql+iKAUmX2guU1KC50HUJHPTpF9znrlt+rddV9i9pWobZaun8ckMUnCN87l5
	y+0ZFxkNhZh/TYUTcytR5jYFWyhaRGytantloSy8i468v8IE/gOKBXdBC0aMpNfsQRsOsi
	s5WK6a4SRdrGMeinfK9DwPLR1BIykzE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-7Cc236glNOejAZtqcGw6wQ-1; Wed,
 12 Aug 2026 07:00:35 -0400
X-MC-Unique: 7Cc236glNOejAZtqcGw6wQ-1
X-Mimecast-MFC-AGG-ID: 7Cc236glNOejAZtqcGw6wQ_1786532433
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF0321956054;
	Wed, 12 Aug 2026 11:00:32 +0000 (UTC)
Received: from [10.44.32.148] (unknown [10.44.32.148])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4F8B426;
	Wed, 12 Aug 2026 11:00:29 +0000 (UTC)
Message-ID: <00e79095-fc1c-47f5-8e7f-4e976f4954c8@redhat.com>
Date: Wed, 12 Aug 2026 13:00:28 +0200
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
 <452e52d5-c80a-498b-b12a-ab539ed9a2db@redhat.com>
 <add0f48e-90a2-42c4-8445-754d85072e6e@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <add0f48e-90a2-42c4-8445-754d85072e6e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 8/12/26 12:04 PM, Vadim Fedorenko wrote:
> On 12/08/2026 07:57, Ivan Vecera wrote:
>> Sashiko findings. Replies inline.
>>
>>  > Could a transient hardware error bring down the system here?
>>  >
>>  > If an I2C/SPI bus glitch causes the device to return 0xFF, the SEM
>>  > bit will be set and the CMD field will hit this default case. On
>>  > systems with panic_on_warn, using WARN_ON for validating external
>>  > hardware states turns recoverable bus errors into fatal kernel panics.
>>
>> The SEM-first check already handles the most common bus glitch (0x00
>> return). For 0xFF: the CMD field is only written by the driver, never
>> by firmware, so an unknown CMD with SEM set indicates either a bus
>> error or firmware misbehavior that warrants attention. The switch
>> structure with WARN_ON in the default case was requested by Vadim
>> in his v4 review. Systems that enable panic_on_warn accept this
>> trade-off.
>>
>>  > Will this sleep-based polling loop destroy the timestamp's precision?
>>  >
>>  > Should the postts be captured immediately after the trigger command
>>  > in zl3073x_chan_tod_ctrl() instead?
>>
>> The hardware latches the ToD value when it processes the command,
>> which completes when the semaphore clears. The post-timestamp must
>> be taken after the semaphore clears to guarantee the window contains
>> the actual latch event. Moving it before the wait would risk the
>> timestamp window not containing the latch moment.
>>
>>  > Could this loop exhaust its retries and return -EBUSY prematurely?
>>  >
>>  > The loop spins without an explicit wait [...] On fast SPI/I2C buses,
>>  > it will execute all 20 reads in a few milliseconds
>>
>> Testing on I2C at both 100 kHz and 400 kHz bus speeds shows that a
>> single iteration of the loop body (two ToD reads, each involving a
>> ready-wait, command write, second ready-wait and data reads) takes
>> approximately 17-19 ms regardless of bus speed. The iteration time
>> is dominated by the device's internal processing, not bus transfer
>> time. With 20 retries the budget is 340-380 ms, well beyond the
>> 20 ms margin window.
>>
>>  > Is it safe to use WARN_ON to validate user-controlled input?
>>  >
>>  > Since delta_ns originates from the clock_adjtime syscall's tx.offset
>>  > (via the adjphase PTP callback) [...]
>>
>> The PTP core already validates the input via getmaxphase, which
>> returns NSEC_PER_SEC - 1, rejecting values with magnitude >=
>> NSEC_PER_SEC before the driver callback is invoked. The WARN_ON is
>> a defensive check for a condition that should never be reached
>> through normal code paths, not user input validation.
> 
> AFAIR, the general rule is not to write defensive code in kernel if you 
> know that the core has already validated inputs.

Yes, but this low-level helper zl3073x_chan_tie_write() is called from
multiple places and current code-paths are OK. But in future, if another
caller will be introduced or existing code will be refactored this WARN
immediately detects potential bug.

The same is also valid for WARN in zl3073x_chan_tod_ready_wait()... new
TOD command starts to be used but someone forget to update this function
accordingly.

Thanks,
Ivan

