Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113C22BEC5F
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785981227; cv=none; b=KOVsWcIsDXFKa/hX+iwWTmloYLXhuzCDaGFEEIlDEdMw5y+9QQAqfj0pb5i0dzB+wfpizahZQJqihfq1wfWAgTcY35XovuF9msQyy1R6RtJcpfuH+P4AaNoNDcgbPY9kasvcFkoUisroeH5iJON7JQNFuBSWAw85rg2gGymk+jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785981227; c=relaxed/simple;
	bh=qiAe58bwoG0yMy4v6d4zXasEjmeYvjK45Quvf1nQ5Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2YHVj4uzR7uPXISnQGrc+o1gLoVmLylVhVem3QjKvhrMNnpFiZt3yFiYFpK18XUiXAW+p5aAZqYh0PMImGixr1TclrnQAEZHcx4uu498hdcEOckbuiI62OkxFOQ6gNPLhC2MtDxgm0gkYtuqeMIDfW2fFMpNajTH0nZgICLA5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oQw5MLfc; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oQw5MLfc"
Message-ID: <384a323e-406d-4e5e-a26e-e08a04d66051@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785981222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJo+xZSABlRIgsNhdcfg044YyHG0kWDFR2wlY0JGpNA=;
	b=oQw5MLfcwJ578cRpz8rw+HG0zaYit5vfA1jxHZYajU3zIFbwQipS7MY94+0GuRorkhY/kz
	HBSJQNOw66iIhitZhF0UBnET5prg5FxH5P/b/0hKGtzMPD2kKwmfkBpgrTVEyB9Sl8yR0Y
	ldZrMsMe6coxHZvFHqHZUJS9owM0E9A=
Date: Thu, 6 Aug 2026 09:53:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] net: phy: dp83640: fix per-bus clock lifetime
To: Andrew Lunn <andrew@lunn.ch>
Cc: kuba@kernel.org, richardcochran@gmail.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260805072725.169431-1-xuanqiang.luo@linux.dev>
 <19f04c24-cf3d-4730-ae15-ab7f2f7bc3f1@lunn.ch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <19f04c24-cf3d-4730-ae15-ab7f2f7bc3f1@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Andrew,

在 2026/8/5 20:11, Andrew Lunn 写道:
>> +static void dp83640_clock_init(struct dp83640_clock *clock)
>>   {
>> -	INIT_LIST_HEAD(&clock->list);
>> -	clock->bus = bus;
>>   	mutex_init(&clock->extreg_lock);
>>   	mutex_init(&clock->clock_lock);
>>   	INIT_LIST_HEAD(&clock->phylist);
>> +	clock->caps.pin_config = clock->pin_config;
> Can this patch be split up a bit? It is not clear to my why this is
> needed. If you have lots of small patches, each with good commit
> messages, you can explain "Why?" this is needed.

You're right. I'll split the changes into small, independently reviewable
patches.

>>   	clock->caps.owner = THIS_MODULE;
>>   	sprintf(clock->caps.name, "dp83640 timer");
>>   	clock->caps.max_adj	= 1953124;
>> @@ -977,14 +971,8 @@ static void dp83640_clock_init(struct dp83640_clock *clock, struct mii_bus *bus)
>>   	clock->caps.settime64	= ptp_dp83640_settime;
>>   	clock->caps.enable	= ptp_dp83640_enable;
>>   	clock->caps.verify	= ptp_dp83640_verify;
>> -	/*
>> -	 * Convert the module param defaults into a dynamic pin configuration.
>> -	 */
>> +	/* Convert the module param defaults into the pin configuration. */
>>   	dp83640_gpio_defaults(clock->caps.pin_config);
> Why is this no longer dynamic?

Sorry, the updated comment is misleading.

The pin configuration is no longer dynamically allocated, but it can
still be changed at runtime via ptp_set_pinfunc().

I'll fix the comment and move this change into a separate patch,
since it can be reviewed independently.

>> +	clock = phy_package_get_priv(phydev);
>> +	/* Ensure other PHY probes wait for shared clock initialization. */
>> +	mutex_lock(&phydev->mdio.bus->shared_lock);
> Please add phy_package_lock() and phy_package_unlock().
>
I'll add phy_package_lock() and phy_package_unlock().

Thanks,
Xuanqiang

