Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C081D3E5578;
	Mon, 15 Jun 2026 11:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781523867; cv=none; b=CZwcBlL+GxB/RxRwSyvPxek8ppcpMrETis5m3/J4dHNaxA1VoRZqeQJtVslrx4Nn/K6VKzUmJxrpUQu8NUEI0xEh1XjHiDAD/nc0OlYnlgK5em1+T08WwjixYrlOSdCuPIqsxE1dOZl710IIosN1tJHX5ZotbNDjqZ0vGKNy0gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781523867; c=relaxed/simple;
	bh=QzEQ8bmQRcac/cdT+HGYuruEQVR11ZuItIOQrzpOmVk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UJPCeDPFPg1v8MdXLVG61jjDLYWGDUVuFLrMZ3bwmsA7VPQTtmdvmq3Z3EpWOPi11FxQhSfoXb0y5bQFIKkBhf1zLaVXxaGQb6YRLeA71woupFKZbAZLzciLXLCEyr2znaRtwu5HWbQM3YY3WRGjqY1LntCrkaH5+yzM9pciplg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=n4eepFDb; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="n4eepFDb"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E6E2A4B51;
	Mon, 15 Jun 2026 13:35:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781523360; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vcQo2gA7ahzyNWTX7sbWOasW0OaO/03aDK6BDJtgCBk=;
	b=n4eepFDbySOqpEaPs8y8xch/b32ovHXoy6YC2tV9ekCiWvfOekjgnSr4rEwqVfIvDp5Ana
	/IRJCL9kQIJrHbxs0K4ChL6KMN4pvhbddP+4GcfIIR11WbDIt0O34YKY8T1I8fPhUWcJHZ
	zEIBA6dtw+3C0wTCSj5yECmORAI97gQn47kzkmdI0RRTi01oZgMaAX4kcqpCkGBPJiBRDV
	NM/Crds8cV+K7wncHQ9II3yAEGIJyz9v4vS6bvg3dTki58dWDN+yZBm8dQFYTYcaoBTjuZ
	XFTt/f/Vut7ZfzrwWMWHsblKTYWEzbNv4bZWo4/oxH51hcl7/Ea2BNf7aDG2Qg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jun 2026 13:35:57 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Justin Chen <justin.chen@broadcom.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: bcmgenet: collapse TX priority queues
In-Reply-To: <20260613145745.36c5403e@kernel.org>
References: <20260612205915.3156127-1-nb@tipi-net.de>
 <20260613145745.36c5403e@kernel.org>
Message-ID: <59249267ef946bb39b647fb9cc816c98@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub

On 13.6.2026 23:57, Jakub Kicinski wrote:
> On Fri, 12 Jun 2026 22:59:12 +0200 Nicolai Buchwitz wrote:
>> Tested on Raspberry Pi CM4 (BCM2711):
>>   - Ovidiu's reproducer (iperf3 -u -b0 -P16 -t60) no longer trips
>>     NETDEV_WATCHDOG.
>>   - UDP sustains 956 Mbit/s line rate over 60 s with 0 datagrams
>>     lost (0/4952890).
>>   - Single-stream TCP throughput unchanged at 943 Mbit/s.
> 
> Of course it has no impact on a single TCP stream test, since TCP
> stream can only use one queue. If anything it should help.
> The testing here is not very convincing. At least install a realistic
> qdisc (fq/fq_codel/cake) and run multi-stream test with multiple cores?
> What's the CPU idle delta in such a test?

Fair. Tests I ran with fq_codel:

   # TCP
   iperf3 -c <remote> -P 16
   # UDP
   iperf3 -c <remote> -u -b 1000M -P 16
   # RR
   iperf3 -c <remote> -t 60 &
   netperf -H <remote> -t TCP_RR -l 30 -- -r 1,1

With the following results (all based on net-next with PP):
                               PP       PP+WRR    PP+series
   TCP -P16 Mbit/s               938       941        941
   TCP retransmits             56228     57679      48606
   UDP -b1000M -P16 Mbit/s       956       956        956
   TCP_RR under TCP load       451.7     453.8      596.8
   CPU idle                    91.55%   90.53%     90.97%
   CPU0 softirq                32.6%    33.4%      33.5%
   CPU1-3 idle (avg)           97.6%    97.7%      97.7%

So WRR fixes the watchdog issue, otherwise is within noise. This series
adds ~31% TCP_RR under load and reduces retransmits by ~14%. Note, that
bcmgenet on BCM2711 has only two IRQs and no per-queue affinity, so all
HW interrupts are handled by one core regardless of queue count.

> 
> The reason for this change is not coming thru from the submission.
> Ovidiu's patch makes much more intuitive sense. I'll apply that,
> please rebase.

Will rebase and resend with a hopefully better reasoning :)

Thanks
Nicolai
