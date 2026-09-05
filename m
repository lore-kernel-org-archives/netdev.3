Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82338238D;
	Sat,  5 Sep 2026 01:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788570985; cv=none; b=OeP3Sp9zqto0sVWM1JmdtL0nAD2dPomYS1KRyPicDdPGgaJef+6w18uRiwp0tWZYkg9MGtP/D7GiB4Mo20yiPw6DsaTXzIZ3Zl/T7/A2z+O7pJMzRlnJFviEHxe9hXPMQh5qWuN1vYgO1tXAelHF2Ui5jtcN8AkknGSHN6mUHDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788570985; c=relaxed/simple;
	bh=tB2IpyX4dXAWMVu51m0Dmozi2sMAndrDPEGVg4go1I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYTh3fAYY6TXQ0C3RL5SlyZ1XOdIy+Gimrxu44fIhavHVVn/hWweBjvU8TuMEck4mJVmRJXreC+YMvIDoNwIy01SzO4seiaNlglpZJDeh1r/76L3o51UeGz4z/50Hh3JpNwHu1MO4Exl/+3pE6p6bNQ7qaaIp6PTB70QX+ZBvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=X+1rLl7X; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="X+1rLl7X"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4018B11D8B6;
	Sat, 05 Sep 2026 03:16:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788570977;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KD35Y7PrHp3mXRQ+ctDP9TNjuQocO5bXRaIRALZodXU=;
	b=X+1rLl7XTMmzY3XtFYWK1QrW7dXdHighihEaOpJrgtgKnFrBdIdXrvvF6MDg8T9atTVSkk
	mkuh5NBZN2a45nd63yXArxBfln68vPWhMwg9E5SOQRGwaiSAYyQtO1ysERCvhSadkPVpX+
	+4FQZVFMfudDpNrO/gwHgL6tMqVAdN4zjvf3H0lmN2bChqnLhaMMI9chUmYg9VN4I364p2
	EJmO1D0Ej9ri+w5ApXA5Odr45/ewvf+jhGwss9IFOibh84qmoXF+YXx0V0Wch1dT9uWgP+
	v9yi1b46sg0dMLdKORAuTMDh4Ss3i4BYG/Ggc5X0s+ApnjYszLSL5DaPvwgfSg==
Message-ID: <f7149e71-2c32-4f53-86c9-d1c586218fc2@nabladev.com>
Date: Sat, 5 Sep 2026 03:16:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net,PATCH v1] net: ks8851: Fix receiver error in 100BASE-TX mode
 following software power-down
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, bigeasy@linutronix.de,
 yiconghui@gmail.com, kernel@dh-electronics.com, linux-kernel@vger.kernel.org
References: <20260901173925.96183-1-marex@nabladev.com>
 <20260904003712.3484001-1-kuba@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260904003712.3484001-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 9/4/26 2:37 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch.

Sigh, a wall of generated text.

> The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: ks8851: Fix receiver error in 100BASE-TX mode following software power-down
> 
> Per the KSZ8851 errata (DS80000716D, Module 3), a software power-down
> followed by a power-on can leave the receiver circuit non-functional. This
> patch implements the documented workaround by dropping both transitions into
> PMECR_PM_SOFTDOWN, in ks8851_write_mac_addr() and ks8851_net_stop().
> 
> Link: https://ww1.microchip.com/downloads/en/DeviceDoc/80000716D.pdf
> 
>> diff --git a/drivers/net/ethernet/micrel/ks8851_common.c b/drivers/net/ethernet/micrel/ks8851_common.c
>> index 4afbb40bc0e4a..cd8dfca22720b 100644
>> --- a/drivers/net/ethernet/micrel/ks8851_common.c
>> +++ b/drivers/net/ethernet/micrel/ks8851_common.c
>> @@ -143,9 +143,6 @@ static int ks8851_write_mac_addr(struct net_device *dev)
>>   		ks8851_wrreg16(ks, KS_MAR(i), val);
>>   	}
>>   
>> -	if (!netif_running(dev))
>> -		ks8851_set_powermode(ks, PMECR_PM_SOFTDOWN);
>> -
>>   	ks8851_unlock(ks);
>>   
>>   	return 0;
> 
> [Severity: Low]
> This isn't a bug

Aha ...

>, but should the two comments describing the software
> power-down state be updated in the same patch?
> 
> After this hunk, ks8851_write_mac_addr() still carries this comment above
> its remaining ks8851_set_powermode() call:
> 
> 	/*
> 	 * Wake up chip in case it was powered off when stopped; otherwise,
> 	 * the first write to the MAC address does not take effect.
> 	 */
> 	ks8851_set_powermode(ks, PMECR_PM_NORMAL);
> 
> Nothing in the driver can put the chip into software power-down anymore, so
> the "in case it was powered off when stopped" precondition can no longer
> occur. A grep of the tree confirms PMECR_PM_SOFTDOWN has no users left,
> only its definition in ks8851.h, and the two remaining
> ks8851_set_powermode() call sites in ks8851_write_mac_addr() and
> ks8851_net_start() both write PMECR_PM_NORMAL.

The driver obviously does not exist in a vacuum and prior stage before 
Linux could have easily left the MAC in whatever powered down state. 
This is bogus feedback.

> Since the commit message uses that very call site as the argument that
> dropping the power-down here is safe, would it help to note in the comment
> that the PM_NORMAL write is kept deliberately (e.g. referencing the errata),
> so a later cleanup does not remove it or reintroduce the SOFTDOWN
> transition?
> 
>> @@ -506,8 +503,6 @@ static int ks8851_net_stop(struct net_device *dev)
>>   	/* shutdown TX process */
>>   	ks8851_wrreg16(ks, KS_TXCR, 0x0000);
>>   
>> -	/* set powermode to soft power down to save power */
>> -	ks8851_set_powermode(ks, PMECR_PM_SOFTDOWN);
>>   	ks8851_unlock(ks);
> 
> [Severity: Low]
> Related to the above: the kernel-doc for ks8851_net_stop() just above this
> function still promises the low power transition that is being removed here:
> 
> 	/**
> 	 * ks8851_net_stop - close network device
> 	 * @dev: The device being closed.
> 	 *
> 	 * Called to close down a network device which has been active. Cancel any
> 	 * work, shutdown the RX and TX process and then place the chip into a low
> 	 * power state whilst it is not being used.
> 	 */
> 
> The post-patch body only masks IER/ISR, zeroes RXCR1/TXCR, drains ks->txq
> and calls free_irq(), with no PMECR access left. Should that last sentence
> be dropped or reworded to mention the errata, so readers of
> ks8851_suspend()->ks8851_net_stop() are not told a low power transition
> happens?

What exactly should I adjust in V2 ?
