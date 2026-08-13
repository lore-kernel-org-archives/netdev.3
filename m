Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32C543E09A
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654676; cv=none; b=TcBf4iEE2QSFT8oMGvKyOaMYsN4lNlvvqX0cRpmzepEOiSSqaBa/awJVgRiFkxjBybZMzHAR/uzIdiitWeaXfJKM8JP899cWqNDZhkwbL4NW5XQ27IKNs0/lZtdtO78+lX7KQOy7JJ/2yBtkW47oUxqjv4njVpWbnltk20Wohlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654676; c=relaxed/simple;
	bh=C+mAfYN7usfptg+2rVKnEV1It9gK1qTi0ScNF5o4l74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzoeRIJybEYvBp7vEFsihDMpb88dq7gYLdgcAkSA8fkB5cWuKJQKxYmdga+uCAxOuw+gZ9J29fxCcY+RU4fIKNbUI9QhOuMQ5IjjxOoaiWRgMU9IcdNoS+yZoMRMjGmtpmgIyN482CT0Oeen3oFSDufttP9636uts6YLoHt7ZMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B/WGa/jz; arc=none smtp.client-ip=95.215.58.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B/WGa/jz"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C+mAfYN7usfptg+2rVKnEV1It9gK1qTi0ScNF5o4l74=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786654672; v=1; x=1787259472;
 b=B/WGa/jzoa1XOsXteQonhUOv0bfEE1rfGVZjXavkupA2Ch15G6BQ+MAYVMjbI4zSvMXyBQTk
 PPp1p4IqqJRT53l/Owm638snzAmY9nM2qDah20fssiCxLp8pouE75yBHtX+PBaDzF4A8SyBY2jc
 s2yYaiWXE88Pwb4j22FVYH64=
X-Envelope-To: netdev@vger.kernel.org
Received: from [192.168.1.24] (64.43.42.247)
	by smtp.migadu.com with ESMTPS id fbb310ab94a2c10a;
	Thu, 13 Aug 2026 20:57:42 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <41ca9a38-fb3d-402e-b7e2-365194a1634f@linux.dev>
Date: Thu, 13 Aug 2026 21:57:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/3] dpll: zl3073x: add channel ToD, phase
 step and TIE operations
To: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: Petr Oros <poros@redhat.com>,
 Chris du Quesnay <Chris.duQuesnay@microchip.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Min Li <min.li@microchip.com>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20260811134700.1211010-1-ivecera@redhat.com>
 <20260811134700.1211010-3-ivecera@redhat.com>
 <452e52d5-c80a-498b-b12a-ab539ed9a2db@redhat.com>
 <add0f48e-90a2-42c4-8445-754d85072e6e@linux.dev>
 <00e79095-fc1c-47f5-8e7f-4e976f4954c8@redhat.com>
 <72681461-21c8-4a87-ba75-d281894aea1d@linux.dev>
 <51E4CAF3-6C37-411B-8143-0BB8E6F235A3@redhat.com>
Content-Language: en-US
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <51E4CAF3-6C37-411B-8143-0BB8E6F235A3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/08/2026 21:51, Ivan Vecera wrote:
> 
> 
> 13. srpna 2026 22:38:55 SELČ, Vadim Fedorenko <vadim.fedorenko@linux.dev> napsal:
>> On 12/08/2026 12:00, Ivan Vecera wrote:
>>> On 8/12/26 12:04 PM, Vadim Fedorenko wrote:
>>>> On 12/08/2026 07:57, Ivan Vecera wrote:
>>>>> Sashiko findings. Replies inline.
>>>>>
>>>>>   > Could a transient hardware error bring down the system here?
>>>>>   >
>>>>>   > If an I2C/SPI bus glitch causes the device to return 0xFF, the SEM
>>>>>   > bit will be set and the CMD field will hit this default case. On
>>>>>   > systems with panic_on_warn, using WARN_ON for validating external
>>>>>   > hardware states turns recoverable bus errors into fatal kernel panics.
>>>>>
>>>>> The SEM-first check already handles the most common bus glitch (0x00
>>>>> return). For 0xFF: the CMD field is only written by the driver, never
>>>>> by firmware, so an unknown CMD with SEM set indicates either a bus
>>>>> error or firmware misbehavior that warrants attention. The switch
>>>>> structure with WARN_ON in the default case was requested by Vadim
>>>>> in his v4 review. Systems that enable panic_on_warn accept this
>>>>> trade-off.
>>>>>
>>>>>   > Will this sleep-based polling loop destroy the timestamp's precision?
>>>>>   >
>>>>>   > Should the postts be captured immediately after the trigger command
>>>>>   > in zl3073x_chan_tod_ctrl() instead?
>>>>>
>>>>> The hardware latches the ToD value when it processes the command,
>>>>> which completes when the semaphore clears. The post-timestamp must
>>>>> be taken after the semaphore clears to guarantee the window contains
>>>>> the actual latch event. Moving it before the wait would risk the
>>>>> timestamp window not containing the latch moment.
>>>>>
>>>>>   > Could this loop exhaust its retries and return -EBUSY prematurely?
>>>>>   >
>>>>>   > The loop spins without an explicit wait [...] On fast SPI/I2C buses,
>>>>>   > it will execute all 20 reads in a few milliseconds
>>>>>
>>>>> Testing on I2C at both 100 kHz and 400 kHz bus speeds shows that a
>>>>> single iteration of the loop body (two ToD reads, each involving a
>>>>> ready-wait, command write, second ready-wait and data reads) takes
>>>>> approximately 17-19 ms regardless of bus speed. The iteration time
>>>>> is dominated by the device's internal processing, not bus transfer
>>>>> time. With 20 retries the budget is 340-380 ms, well beyond the
>>>>> 20 ms margin window.
>>>>>
>>>>>   > Is it safe to use WARN_ON to validate user-controlled input?
>>>>>   >
>>>>>   > Since delta_ns originates from the clock_adjtime syscall's tx.offset
>>>>>   > (via the adjphase PTP callback) [...]
>>>>>
>>>>> The PTP core already validates the input via getmaxphase, which
>>>>> returns NSEC_PER_SEC - 1, rejecting values with magnitude >=
>>>>> NSEC_PER_SEC before the driver callback is invoked. The WARN_ON is
>>>>> a defensive check for a condition that should never be reached
>>>>> through normal code paths, not user input validation.
>>>>
>>>> AFAIR, the general rule is not to write defensive code in kernel if you know that the core has already validated inputs.
>>>
>>> Yes, but this low-level helper zl3073x_chan_tie_write() is called from
>>> multiple places and current code-paths are OK. But in future, if another
>>> caller will be introduced or existing code will be refactored this WARN
>>> immediately detects potential bug.
>>>
>>> The same is also valid for WARN in zl3073x_chan_tod_ready_wait()... new
>>> TOD command starts to be used but someone forget to update this function
>>> accordingly.
>>
>> That's a little bit weak and goes against "trust internal APIs". It's
>> currently called from adjtime and adjphase callbacks, what do you expect
>> to have in the future?
>>
> 
> No idea
> I will drop it...

ack
