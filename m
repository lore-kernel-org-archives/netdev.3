Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880FD3D5C32
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882672; cv=none; b=euxK4KUhBpUxaCGQRSSkOEo/EEIaVfTFTl4BUSZIKKHHTBS7WtJYmpv/i8RmhNgzIpdfEl50hhew4A44ZF328/jzK6Af9iZNfLAU7hm40Yt+Vb3F50yLjt55LFTngmKRZz+Uhx7T9GtARnCtfe1MX13RrFsPGpX+KDnS93c/2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882672; c=relaxed/simple;
	bh=vE/ssJjKOjx/tkp4IFJnQPyODlHvtSzviZkW70EJfqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FPBFWjE2qZgBaKJx+2ldKFGH1D66Xb6Bfji80LxiBc1lbApOcmXbISNTZjmF8PF9ReskOwhgQpliSWY2BZ1dlBkQ1vL1HPtla0N86ugcxHtbAcvwjwUfX8Jk4LqNvr+U1skPlYI67BQOyLj2y7MfWDtAv8FeGV+c4Jvd4VKCxoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZsJiMY9e; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ge312uUz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsJiMY9e";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ge312uUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791882669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JU9tnBcMkdVR8l7gnZ/QWr9koE1ti0o+ukqfCAcEac=;
	b=ZsJiMY9eDRnZvmX3sl8BCDhV7GVF2RNNYcpk2DAVZpeQndbHmNfDdb0Lu3mzo+cy3bdTg0
	DMIklb19IKvtPjqnkglTFhSWVK4a/7oot8MlbKsdR35x6Lk7hPNnOT5oJvEkZ6x+jYDq/8
	XF88q/v4rPDWDcoGCUH2/MWhyPL7gpI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-WDpcR_s6OPm9jVISgsOXfA-1; Tue, 13 Oct 2026 09:11:08 +0000
X-MC-Unique: WDpcR_s6OPm9jVISgsOXfA-1
X-Mimecast-MFC-AGG-ID: WDpcR_s6OPm9jVISgsOXfA_1791882667
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c54e690c5so1939558f8f.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 02:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791882667; x=1792487467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1JU9tnBcMkdVR8l7gnZ/QWr9koE1ti0o+ukqfCAcEac=;
        b=ge312uUzZyV3ujzjhABULHgPPK17RXyvY4f8f1gmE+cAsTxtUl76HnKBbFylAZLsx5
         d2UkvkJ7AeMPdZkcQ1rzWmI4tkWnx4xoDHjFUF4uILHlwb3b9MJlratdF6SJee+rWdc6
         55jBLrc7elwpczBxAQ0p0j3BqXCJrnU1C+zpZMxdgZecY7WQJV+iP1aGNTjDPZsczvCH
         mD7QaaJetjV/J/xIA16ExPHcRBPfyG8Ew//YPafWq2IL8K6tan0wCQ4EA5AlSWjSzred
         bpKh/0S5nmZovdoA7Th4Z3muRZoV4weVrakwO8x2PuY8tx/aNdipScDaDdYKVBUlLIBV
         73qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791882667; x=1792487467;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1JU9tnBcMkdVR8l7gnZ/QWr9koE1ti0o+ukqfCAcEac=;
        b=vicqDW4KbODhBm0GES7vAnGbsJcQtU+H7DNdr+zfCdGhHYReWBgvxbIXHMBw+3w/cN
         GPku9ugEVUKqHoAUA7byw6tOyjNQD8PNJAl1ydgw01a3SkLydkiLweguJhbDUg9eKowc
         Jn5sunVVz4ThcLmHciCDzf8n0166O/sWI/PUm33jDTbO+qR+xhph6FM6hNZa/gsoyH30
         DnExKh3iRh2kDetvFbRYEjbeEJtnNCSJx2xmM+GJbQr4P352CybuC6OxxHvJ9AomnWUI
         PX/99NYi6fX58LzX6diq3zJ6agPqpiWIMEKksyyUI/qPxEjVYx7zj9E53jKH5PsDVHAT
         h6Aw==
X-Forwarded-Encrypted: i=1; AKwUvBy6k94/J9vmiTSlk4sjW0f74r4Z89aVuTjaKP7rxDcl68pnKjGGfndeuCPyLwMDwe7r8XgMV0I=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkr2mzb0QG++C1vM+hN7fXGpZL2wuEu1V2u2lNr8BIMwbk6Zuj
	mTCP3zC/tjc2RL6Rd0oQYrcwDHgHCpJdSgqQ4ffKYIrr78OMmfq5pGZKUlYQrzCZIf5HosCV32g
	X9OKYAGh/bKtsIlalsGu2Fsx0OEultZLgEC7GHBGJVeBPyRnWahT+9qW7R5gsNHKnZw==
X-Gm-Gg: AYBFou1yZnpCdtW/XbVL+FM9D8EoiLn972WjGmmm2K2Wrr91ID9D5Bfk1MIi57LVCZa
	c71nkM8lc+s0X3M1WYnyjDSnyXbK2XjXtX6hJaErlw1XKZ84IrpRh+TkXufvrqGraXpIIw8/7VS
	ZZCDO0nys7nJosFsdpKHC0ReqPE0PPtoYtsPLRsoYF83ldxJPiP1U81UcMFUvNZV/p88gpmtKmR
	/6YT0Gj7AJfwjVEhHMlP8JoUOEfH79RQ8nmbrnrK/HlXCeD/lRo/crbZCFETF05AkMa4r/CTcei
	qrbB3f9iLkN0uAz4KCf4YBPtgZqTQ8Ffv9JWjKTS+mCqIZj7wo26GhDm1mrDZVaeXEMiTTnzXVG
	GOS3WtFPFdNQKYW13wRtkhGNg0ZnUuE4hHsuMBmbEPeXqeR/6EW7//fWkzP5KwRbtgVaTu7/I/g
	==
X-Received: by 2002:a05:6000:4312:b0:487:27f6:a4e4 with SMTP id ffacd0b85a97d-48dbad489d1mr22038164f8f.52.1791882666662;
        Tue, 13 Oct 2026 02:11:06 -0700 (PDT)
X-Received: by 2002:a05:6000:4312:b0:487:27f6:a4e4 with SMTP id ffacd0b85a97d-48dbad489d1mr22038100f8f.52.1791882666124;
        Tue, 13 Oct 2026 02:11:06 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0967acasm3324636f8f.2.2026.10.13.02.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 02:11:05 -0700 (PDT)
Message-ID: <b1fae6df-5e69-4e53-9f35-9bfc47c9a500@redhat.com>
Date: Tue, 13 Oct 2026 11:11:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in preemptible
 context
To: Alan Stern <stern@rowland.harvard.edu>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?=C3=96mer_Mete_Kaya?=
 <omermetekaya0@gmail.com>, oneukum@suse.com, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 david.laight.linux@gmail.com,
 syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
 <20261007200049.079aeb75@kernel.org>
 <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
 <20261008094338.301a75fa@kernel.org>
 <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
 <2026100910-petition-embattled-94cb@gregkh>
 <20261012194902.aEq58Q6b@linutronix.de>
 <8545800a-a37f-482a-9b06-cbdd70312b7a@rowland.harvard.edu>
 <20261012212527.5sFqlGYu@linutronix.de>
 <41af30de-4725-4913-9ad8-54d1dea2d4b8@rowland.harvard.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <41af30de-4725-4913-9ad8-54d1dea2d4b8@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/26 04:09, Alan Stern wrote:
> On Mon, Oct 12, 2026 at 11:25:27PM +0200, Sebastian Andrzej Siewior wrote:
>> On 2026-10-12 16:26:28 [-0400], Alan Stern wrote:
>>> On Mon, Oct 12, 2026 at 09:49:02PM +0200, Sebastian Andrzej Siewior wrote:
>>>> On 2026-10-09 13:31:17 [+0200], Greg Kroah-Hartman wrote:
>>>>>> As far as I am aware, there aren't really any guarantees on the
>>>>>> context of a USB URB-completion callback.  The kerneldoc for struct urb
>>>>>> in include/linux/usb.h says "The completion callback is made
>>>>>> in_interrupt()", but that is most definitely out of date.
>>>>>
>>>>> I don't think so, I think some platforms still have those callbacks in
>>>>> irq context, unless we changed to threaded irq handlers everywhere?  I
>>>>> could have missed that, but we should still write the callbacks to
>>>>> assume that and then we should be fine even if we aren't in irq context,
>>>>> right?
>>>>
>>>> The HCD invokes the completion callback usually in IRQ context. I think
>>>> the VHCI is an exception here.
>>>> For the forced-threaded mode we disable BH before the IRQ handler is
>>>> invoked. I think even dummy_hcd invokes them from the timer if my memory
>>>> is right.
>>>>
>>>>>> Drivers shouldn't rely on any particular context guarantees.  Not even
>>>>>> whether local irqs are enabled/disabled.
>>>>>
>>>>> Agreed.
>>>>
>>>> I would suggest to make VHCI invoke the completion callback with BH
>>>> disabled. usbnet's tx_complete() does also defer_bh() which schedules a
>>>> BH worker via queue_work(). While this works without disabling BH it
>>>> leads to waking ksoftirqd and an additional context switch which we
>>>> could avoid by dealing with it directly.
>>>
>>> Today you fix VHCI, tomorrow some other virtual HCD will cause problems.
>>
>> We don't have other virtual HCDs, do we?
> 
> Well, we've got dummy-hcd.  And just recently there was an RFC post with
> a virtio USB HCD implementation.  It wouldn't be surprising to encounter
> other ones.
> 
> Also, don't forget, URBs can complete in several different ways.
> There's normal completion, explicit unlinking, unlinking because the
> device was unplugged, unlinking because the device or HC is going into
> suspend, and so on.  And there's a difference between URBs sent to
> root hubs as opposed to devices actually on the bus.  Not to mention
> that in some cases completions may occur synchronously with submission
> or unlinking, even though they usually are asynchronous.
> 
>> The other driver is drivers/net/mctp/mctp-usb.c.
>> mctp_usb_out_complete() -> … -> mctp_usblib_tx_stats_update() does
>> get_cpu_ptr() for stats. But mctp_usb_in_complete() has
>> mctp_usblib_rx_complete() -> mctp_usblib_rx_stats_single_drop() and
>> mctp_usblib_rx() which do just this_cpu_ptr(). Plus the queue wakes &
>> netif_rx() which wake ksoftirqd.
>>
>> That makes two drivers from a quick grep. But I guess it is just
>> networking for the per-CPU stats.
>>
>>> Should we document any requirements that all HCDs will have to follow
>>> and that all completion handlers can rely on?
>>
>> It used to complete in IRQ context. Then you added the possibility to
>> complete BH for those HCDs marked as such (except for the RH). I think
>> it was always reasonable to assume that it is either IRQ-context
>> (force-threaded or not for !HCD_BH) or BH (for HCD_BH). It makes hardly
>> a difference, BH is always off and networking uses to rely on it.
>> So yes, documenting would make sense.
>>
>> Do you want to document it yourself and have me do the VHCI bits?
> 
> At the moment, the only thing I think we can actually guarantee is that
> completion handlers will be called with local interrupts disabled.  No
> commitments about process context vs. interrupt context vs. BH context
> or anything else.
> 
> Of course, in special cases you might know more about how a particular
> HCD works.  But except for platform-specific settings, it's hard to be
> certain that your driver will always be used with that one particular
> HCD.
> 
> If this is okay with you, I can write a documentation patch.
Please help me wrapping this up. I read the above as a more generic
patch is under discussion, am I correct?

Thanks,

Paolo

