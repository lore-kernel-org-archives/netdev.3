Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD833D512;
	Tue, 29 Sep 2026 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790693314; cv=none; b=lIj6q8Kne11Pp5d3nDeUu+9ctDf1r20n5OtAOpgGdorAEVcKSCro7CThJj/6ksfbCN/402rPaOBe3GYx49oBiOc54fUpy/XVfrZVIQmBLopaLF+0A3qk77b2lUt1uYshM1ptliKQVeTBIY8P8uKZcUgjCOoxGP4ZGPNNUaJr+p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790693314; c=relaxed/simple;
	bh=NDu4M0kZOKOrt9+9JCIT2AepNE4F7VsXIjsuT1CNR2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eOIG5WufOuPP9nFvYqeoM7rBrqdsm7hymjjNblOvcM1jj5D21lCmE94o1ORRE3EA0SyAVjXs9BCXB6a5YIVxjfWeh4M4PaOTBZKmJVgl+QhnwyvKslw60l2g2MYKt+cNmFYRvfmW2Sorfl+aO3QN+VAe+A7ax/SOt81ydcqYCcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OCOkIor3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OCOkIor3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A60521A1062;
	Tue, 29 Sep 2026 14:48:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6C932601BD;
	Tue, 29 Sep 2026 14:48:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D9F710329572;
	Tue, 29 Sep 2026 16:48:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790693305; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fCafFHWhPYsRxNTfyjiRHEDy7bTCAxI/LbWiWAoWyZI=;
	b=OCOkIor3lNGhu9rgg1YAA7Imzg2OVP+0KN7DtTgbaE0QxWMHXOMVA/LXqyQe0r7kZMxV4X
	gQ423VoCvGBOpPLsoi7mfBsGqKEel/m6GqPPRjSejY69DsV/R+uq6CfIih8ifH4ndmq2VP
	065CYV9fK3GjnPWwaoLV3FF750II1hrMox8J3vfj26oh9kkudsLIXWhHouqnXOlMFGAGiH
	W5TkEgMOPp/qArsObvezUrk7BDjtMUyF9ZBoQbX+b3v2OJGKcC5UtdwXeDfmPV11C9P621
	8T6tinQc+lssTclwkNDu6JP0kTEOcYWLJvmSy1K+eTozZiFueuHbgmqIfS7G9g==
Message-ID: <5e4d7332-e756-4014-98f8-22edd2a36802@bootlin.com>
Date: Tue, 29 Sep 2026 16:48:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 07/11] net: dsa: microchip: extract
 compute_width
To: netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260925-ksz-perout-v4-7-d675bd21ce49@bootlin.com>
 <179068488049.434549.2405268057372474748@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <179068488049.434549.2405268057372474748@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi all,

On 9/29/26 2:28 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new check in ksz_ptp_compute_perout_cycle() does not fully
>    stop the divide-by-zero on restart that the commit message says it…
> - [Medium] The new `request->period.sec < 0` check in
>    ksz_ptp_compute_perout_cycle() fixes a crash that userspace can…
> 
> --
> 
> net: dsa: microchip: extract compute_width
> 
> This moves the period and pulse width calculation out of
> ksz_ptp_enable_perout() into a new helper, ksz_ptp_compute_perout_cycle().
> The helper will be reused later for KSZ8463 periodic output support. It
> also adds checks that reject negative or zero periods, so that a restart
> of the periodic output cannot divide by zero.
> 
>> diff --git a/drivers/net/dsa/microchip/ksz_ptp.c b/drivers/net/dsa/microchip/ksz_ptp.c
>> index 79520d345efcf..4b57cf076bb4f 100644
>> --- a/drivers/net/dsa/microchip/ksz_ptp.c
>> +++ b/drivers/net/dsa/microchip/ksz_ptp.c
>> @@ -203,12 +203,50 @@ static int ksz_ptp_get_pin(struct ksz_device *dev,
>>   	return pin;
>>   }
>>   
>> +static int ksz_ptp_compute_perout_cycle(struct ksz_device *dev,
>> +					struct ptp_perout_request const *request,
>> +					u64 max_pulse_width,
>> +					u64 *cycle_width_ns,
>> +					u64 *pulse_width_ns)
>> +{
>> +	struct timespec64 tmp;
>> +
>> +	if (request->period.sec < 0)
>> +		return -EINVAL;
> 
> [Severity: Medium]
> Is this check fixing a crash in the existing code? If so, should it go to
> net with a Fixes: tag?
> 

I added these checks to address Sashiko comments from last iteration. I 
don't think they worth a fix in net.

[...]

> 
> [Severity: High]
> Can a zero cycle width still get through here on 32-bit kernels?
> 
> ptp_perout_request.period.nsec is a __u32. Neither ptp_perout_request()
> nor the sysfs period_store() checks that it is below NSEC_PER_SEC. On
> 32-bit, struct timespec64.tv_nsec is a signed 32-bit long, so the
> assignment to tmp.tv_nsec can wrap to a negative value.
> 
> Take period.sec = 1 and period.nsec = 3294967296 (0xC4653600). Both new
> checks pass. tmp.tv_nsec becomes -1000000000, so timespec64_to_ns()
> returns 0, and the TRIG_CYCLE_WIDTH_M check accepts 0. The pair
> sec = 2, nsec = 2962947296 also gives 0.
> 

In these two cases the nsec field is greater than one second, it seems 
very unlikely to me to receive this kind of request.


Best regards,
Bastien
