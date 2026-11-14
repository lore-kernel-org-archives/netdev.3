Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629807;
	b=nLqYGxvNWRYFpXNUczG2HObJQGEK8QRWvPtQ6TsRxjH1jwKKXyJkrKljUQi0r7ye7Cwf
	 bLwqw698rWTVRQ7k98/Fz7lF28+kGz8gTXin0I3v497wDoteezxbpJGQUgnNXxWubWMfQ
	 fZnQdDBJCJdeNq3ucmPXBnDgqkof1cM/R16Kg2QtLvaW3Q9LBAN5/VulklFyPIjstaebG
	 dZDoerwZTZBQ3mtjxDQe2bnNbDZUtKAP/JNr0x6C0WsPD6GsCsAb1/5/dRPH3HaQ25cmp
	 q/p4qiDBi3azVNotmwNNR26Qr85aexZaAbDzIG9Jh6/4US1suabb4vO0BdPJYja5OnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629807;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=bJZ49mA/2fv/eo9vW0sZHgqgFD/tfUpaTmYh5t4KpuM=;
	b=pkh4LlwzlmHVtMwY467uwEqO+XKzCn/XwYr7RB0quFlh6qzbM9wGuxn0NtnhnTeja9te
	 MScN+62WHrGjfswa+6jJwING2FcKwhUSGkMIUuyHB6CVMbXh+bbl2y5Z/ZXvPjrLV92Tt
	 VmgL8hygaEPfG9Js8qBqm9QgzKjJS2EpSGjCSn/NX0192wD+0SkZhncdKlXxARRRtNQHv
	 TLQeCOWKt4ysDcxtYDyRygMtSnF9syERuahNhwcnZrX23ddsil56tYLh7ln0ccU9eqKqy
	 B6hyy/S5XVH4jDdMwGvnxmgW6rQg7r+SctH8cD7IyF2TER1JmVhzoaVeWjOXBM8hjoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rMvn67HJ;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6327606A329
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6327606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rMvn67HJ
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36f8cdd30beso1194509eec.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794629806; x=1795234606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bJZ49mA/2fv/eo9vW0sZHgqgFD/tfUpaTmYh5t4KpuM=;
        b=rMvn67HJ/4qTLn1Cw9eXe5ua4+5psKuBSIMYHqjmgeBPkMW2rBX5FnPrG7wf+Z3km5
         TVdD+/kUfJLEih8Bmit8nB26HVnW/TgGxs8yIqjVP4/uENO/LqSLpVmC23Avj38Yszww
         sx5QHdfP6LemiNXwKLvWJqyoBLhtumwSlpD4sUN+O2tmVo2GM+G0euvRk0WgEjMwNGEN
         wHo11NQlg0zFCIQFOIXMZe05XI+eRGgyEfrfUwJ3INR1qJcSBytrW3kQ2YBshaJIDzYu
         ZUN+7A+AGOcdpg/3pgbm+CwG0o3bMdER5Ite6AVnRsfUzEf2k2iuoqO/fG4jkfF3vjlr
         vWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794629806; x=1795234606;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJZ49mA/2fv/eo9vW0sZHgqgFD/tfUpaTmYh5t4KpuM=;
        b=qmpAT9iL+7Hd7TfSPu5H+XqJJZ4y+Q2I45NWWbQaemKVRcX0wrMVbIIXLhDlPWys/Z
         KJmsqfi8ViD1G/Go7bkh4mfryct0qIXNPa5ee0U1ZZANg61I6BuaXK7WahCbvuZiLFTf
         qC1mN9iuO1d30uGgkK2I7d89lvTHsottFgwyLegdO8iua/GUnzTUHQV0mI4oV3C/4qGW
         V0lqKcWT4ZIRXSlcK5O8IZ30OKgjlVm5Hq1DiU7MhS0PeanZe0OsVsMGHeY6+HpFAHk9
         Xuz4zGvcqbXwCSgAgCtRdKTZfX1rmq2C4ZskdJtRcRb2q9MYu61EnTGf1eb1eNudC1Hz
         YhAw==
X-Forwarded-Encrypted: i=1; AL+hErFi/Rzs70pzXeb4eupo7Zg2QLT3TRSMcEbnp4OqwVqpfqn0Opg8h/bNhMd6wMxWSO38OQdcrRo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GgQYXpTY8ILsDYdjmGjqanss18z0YjwxWHEjd0fgWxYhU+Hv7
	J2MDsrjIUeMmkdOvoxhcx2GKR1+hJdNuZUc+tJCVEpBYXvJueBQgsG94
X-Gm-Gg: AYBFou0G8sFZvGOnU8GEps8bP9T9+c79ZeflHwqTVwmc1p40WB4ThPyOuIjaGq/FkiL
	baAlQsO1PwPU6Jr27jo8/+yAMC4TuDQeqU/mVefvezV+3Kqc+7TS51RtQMZrSxj8YiwIrbkMWs4
	PdZcbqnVtTOPsKVsLzgD/UexfI0Hk1TLAvpOCeXCFilLBfjKa2H8ASdez1gJ8kl3lASBdNnXeDf
	KcCZhYaRxXT+/1Lhed/65ExsvuggLUUi8BuWBWBiLt9zVNzSuMoh4BbSAMQyqvk0I1nbikfWIwv
	UjR7Kx8vVRPnCqEUif4SCo+/jZOaCJuNaHBP2sBO3wuGMGd3PF5ZGaOp708bscwjUbTSL7oglU3
	+1N8EtScLOQIJ7rMCP08bNNbrAhHI+jWiKzuMyHSKtpskLb+njbf8Z+uDI0kP1eDet4Yld0csU+
	3c8XQmd4fooTXyKDqLfflFctl+MumRsjbxdhrYcbK6EnVOljwis3++BmN8yIejUffBG54KqP2hv
	YgTZPVPzmTbqSCq//S6S2vk0m2ZyesevaDfllBO5B6Gbo3R1ERBozsOL3MTCxMNVbKJI+cxEy5q
	AVUL9Vvav6H26sx+KL0lO9mh65NrkJVIKb9l6VFOOQ15/zaO8Q/SgynniwAOSN+GpJZz0sVjLbK
	x
X-Received: by 2002:a05:693c:6293:b0:378:314:4033 with SMTP id 5a478bee46e88-379679e29f2mr4158766eec.32.1794629805701;
        Fri, 13 Nov 2026 20:16:45 -0800 (PST)
Received: from [192.168.10.3] (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f01d68sm11849406eec.17.2026.11.13.20.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 20:16:43 -0800 (PST)
Message-ID: <34ffee4c-c5f6-4050-b76c-637fc48d1030@gmail.com>
Date: Fri, 13 Nov 2026 20:16:41 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random
 changes
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, openwrt-devel@lists.openwrt.org,
 bcm-kernel-feedback-list@broadcom.com
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
 <CACRpkdahWm9aP+UasDx=s3th+vyjAfuWrKB5HS9BKEbz90ZmKw@mail.gmail.com>
 <ec17c6c8-e697-4a5a-a705-bff24daae7b2@gmail.com>
 <CACRpkdZp=4sP_1a=u6c7DGbPWA8WRee4J8Wpsw7Y57S2FT5GFw@mail.gmail.com>
 <92190d04-9b43-47ad-9dd0-4b85bb60f8ef@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <92190d04-9b43-47ad-9dd0-4b85bb60f8ef@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Rafal!

On 11/29/2023 1:42 PM, Florian Fainelli wrote:
> On 11/29/23 13:33, Linus Walleij wrote:
>> On Wed, Nov 29, 2023 at 10:20 PM Rafał Miłecki <zajec5@gmail.com> wrote:
>>
>>> Here comes more interesting experiment though. Putting there:
>>>
>>> if (!(foo++ % 10000)) {
>>>          pr_info("[%s] arm_pm_idle:%ps\n", __func__, arm_pm_idle);
>>> }
>>>
>>> doesn't seem to help.
>>>
>>>
>>> Putting following however seems to make kernel/device stable:
>>>
>>> if (!(foo++ % 100)) {
>>>          pr_info("[%s] arm_pm_idle:%ps\n", __func__, arm_pm_idle);
>>> }
>>
>> That's just too weird.
> 
> It does seem to indicate that idling for too long wrecks havoc, but it 
> is indeed not making much sense. Not having proper documentation for 
> this SoC, it is hard to figure out what impact does stopping the ARM CPU 
> clock has on the rest of the memory subsystem, especially outside of the 
> CPU. I do not believe that this SoC has any form of PLL clock gating or 
> pulse skipping.
> 
>>
>>> I think I'm just going to assume those chipsets are simply hw broken.
>>
>> If disabling CPU idle on these altogether stabilize them, then maybe that
>> is what we need to do?
> 
> Yes, please try booting with "nohlt" set on the kernel command line and 
> see how that fares.
> 
> Also useful would be to dump the L2 CTLR and L2 ECTLR, this is a 
> complete shot in the dark, though was initially wondering if there could 
> be some retention issues, and would have recommended disabling the L2 
> retention policy completely just for testing.
> 
> MRC p15, 1, <Rt>, c9, c0, 2;
> 
> of particular interest here would be bit at position 0, try to see if 
> changing it to 1 (3 cycles) or 0 (2 cycles) changes anything.
> 
> MRC p15, 1, <Rt>, c9, c0, 3;
> 
> the lower bits are reserved, so I would not necessarily expect them to 
> be mapping to configurable latencies, but if you see non-zero values in 
> bits [28:0], try changing them to 0 and see if that changes anything.
> 
> Thanks for your persistence!

Thankfully now we have MCPs and it did not take look to identify a lead 
that was actually documented into an internal bug tracker! Would you be 
able to test this branch:

https://github.com/ffainelli/linux/pull/new/rfc/bcm53573-counter-wa
-- 
Florian

