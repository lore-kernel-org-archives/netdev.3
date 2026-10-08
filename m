Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32523BB130;
	Thu,  8 Oct 2026 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451175; cv=none; b=GqB0xCF/D3VJ6sOiZ2Ya0DovS7wj/JoyhZ2biJqPcIkbfp++APckoW3Fb1a1j5bz1KDtQQJ2ncJsPhE115PYWI0uc9lTbXQcuYyGs+WKE/tR8EoOQSqtvIEPhAWTgYwZL0wRPUu07w313Q2IjSyFUDc/orLv+uiBGW3CVC+i2VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451175; c=relaxed/simple;
	bh=oEsORVwhMiT5sbAk7DzWvYEw+G8J2qu3/NGjKjCwggU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdpadSprJJD0+gnAWQpARdCqpsHZ1UovlelI6BPsq9uD/R9VjQAYqXancEokoAj3A8ftNrxljyJGdGvBBntekIwrP5IRIMbPE+JrY10XngHxDpzg0QvCIl1TQgz5aPJBqVaVKR9BfP6F8mIR7tE+IZYPtgh8/MMfi3qN1SYr6Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I2YO4Lc3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I2YO4Lc3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A9A564E4114B;
	Thu,  8 Oct 2026 09:19:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 76AB960341;
	Thu,  8 Oct 2026 09:19:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BE4F51033385F;
	Thu,  8 Oct 2026 11:19:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791451161; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fc5888mWb8lAIOg0TPjlG3hoHc4rEV/sI/NmUpZbsXM=;
	b=I2YO4Lc3oGxBcjpnypvPP2m5eoAqnV5yHOuPpXJs+ZvGq9mSflpuzoPAKVleiaY4DpENdj
	AwtJoXh154tQcYDLQRPhI5/KeGXkSCru9B5Gb1YrYz91aI0jDcCsGs1W9sPFJ1/GFG51tf
	/fIs5vgPG8VJ5fyUzVIPLdYU82cVZzQK//PqivS7uQ1ZDbMgmtcQbhCNrQtGR6A2In5ZoM
	xnmYUVOhYP2tA+jjBtk+vuk13KuU1JDzi0zCWUhBqVPOvRlkWl4MEfZK6ooq2NfX/RP07f
	HrOQquYfSRy2ahaKs+bptqRbINy795st+vAgYc3ZADx4wMxYymAHX0tZ+aIHqQ==
Message-ID: <7128e50a-20f9-44c6-89d2-6322706ab6e7@bootlin.com>
Date: Thu, 8 Oct 2026 11:19:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: ptp: switch to gettimex64()
 interface
To: Nicolai Buchwitz <nb@tipi-net.de>, James Clark <jjc@jclark.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261006103610.98277-1-jjc@jclark.com>
 <573ab838519f1fcfc19b5c03c23aa72f@tipi-net.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <573ab838519f1fcfc19b5c03c23aa72f@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 10/8/26 09:44, Nicolai Buchwitz wrote:
> Hi James
> 
> On 6.10.2026 12:36, James Clark wrote:
>> The stmmac PTP support currently implements the gettime64 callback to
>> retrieve the hardware clock time. Update the implementation to provide
>> the gettimex64 callback instead, adding support for the
>> PTP_SYS_OFFSET_EXTENDED ioctl.
>>
>> The system clock readings are taken around the read of the nanoseconds
>> register in get_systime(), so get_systime() gains a ptp_system_timestamp
>> argument. rmb() is used to ensure proper ordering on weakly ordered
>> architectures.
>>
>> Assisted-by: LLM
>> Signed-off-by: James Clark <jjc@jclark.com>
>> ---
>> Tested on a Radxa ZERO 3E (RK3566, DWMAC 4/5) running net-next.
>> Width of the interval between the two system clock readings
>> bracketing each PHC read (2000 calls of 25 samples each):
>>
>>                                          min      median
>> Before patch (PTP_SYS_OFFSET):           875 ns   1167 ns
>> After patch (PTP_SYS_OFFSET_EXTENDED):   291 ns    584 ns
>>
>> On this board the 24 MHz arch timer counter advances in steps of 7
>> (~292 ns), so all intervals are multiples of that.
> 
>> [...]
> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
> 
>> [...]
> 
>> @@ -191,8 +192,14 @@ static void get_systime(void __iomem *ioaddr, u64 *systime)
>>      sec1 = readl_relaxed(ioaddr + PTP_STSR);
>>      do {
>>          sec0 = sec1;
>> +        ptp_read_system_prets(sts);
>> +        if (sts)
>> +            rmb();
>>          /* Get the TSSS value */
>>          ns = readl_relaxed(ioaddr + PTP_STNSR);
>> +        if (sts)
>> +            rmb();
>> +        ptp_read_system_postts(sts);
> 
> Additional thought while testing on my stm32mp2:
> 
> Would a plain readl() for PTP_STNSR be enough? readl() completes before
> a following delay loop, which is the counter read postts does. That would
> drop both barriers, like igb/ice/bnxt. Fine either way though, macb has
> the same rmb() pattern.
> 
> Maxime (Chevallier), what do you think?

I agree yes, I was also wondering about just going to non-relaxed accessor
and drop the barriers.

Maxime

> 
>> [...]
> 
> Thanks,
> Nicolai

