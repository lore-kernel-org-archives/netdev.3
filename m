Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504E2439F9B
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832503; cv=none; b=kLgezGT9GGFQypox+YwFvdZ/YDG2UtMlAlZDu0/nAmnBIPCvwGpBP5b+wkalTzYU6g/qr7fzD+ol1+v3vTHGuA2TX6qBQAFch/ZC6HIZ3RCYmdORvOKGbnjv6pcVSLUWgd1mGn7QsN8V1pP34H4fRzPpPDq1XJSxhWQqp4+QWZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832503; c=relaxed/simple;
	bh=WlbobLIJvsf8qkxUUjtiZYtMaK/c0NYs3Rbab+OKYP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGEDq1r/OoIOixT5d5LMFS/04NNJi+CAKpUWHxaojGPUN5Yis/wFXC3CD65YlQqA5j4HNcXAUhi9g/QNADY938u40lfcfLVwJ+i4S7HONSXfHBE+Kf3XLZlQqgFCE+4TLmt6fMJL+ij68YE1sVbXiks5VC/rk9aqbEiaouNidI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BjcNE1gI; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BjcNE1gI"
Message-ID: <e61a9951-cbe7-4e08-aa97-4acd4274f8f7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785832499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gX2HFnPqRid6rFofyF1DFIu+An+pGBAekYy49Pvufg=;
	b=BjcNE1gIJYmxCHwNdWnY78g/BVN2jETBEjsKA2lEOEIRIZXSFP1d0L4U0X7Ewspjv1d/08
	tsx586laKmcTkoMi/qfnZnoFSBRISGOiCJaM0aqYuy5KTOmY9Uo81Hcnl/hHQz7HBMeUfu
	ciuIfkFp9QXEay+Am2nLK5osm7z/8nQ=
Date: Tue, 4 Aug 2026 16:33:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: phy: dp83640: fix per-bus clock lifetime
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, richardcochran@gmail.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 Xuanqiang Luo <luoxuanqiang@kylinos.cn>
References: <20260730064451.32261-1-xuanqiang.luo@linux.dev>
 <20260803190044.274355ea@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: luoxuanqiang <xuanqiang.luo@linux.dev>
In-Reply-To: <20260803190044.274355ea@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2026/8/4 10:00, Jakub Kicinski 写道:

> On Thu, 30 Jul 2026 14:44:51 +0800 xuanqiang.luo@linux.dev wrote:
>>
>> Embed the pin configuration in the package private data so the final
>> package leave releases all clock storage.
>>
>> Fixes: 42e2a9e11a1d ("net: phy: dp83640: improve phydev and driver removal handling")
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> No need to add Suggested-by tags for review comments.
> Only if the v1 was suggested by the person.
>
Understood, I will drop it in v3.

>> +static int dp83640_probe(struct phy_device *phydev)
>> +{
>>   	struct dp83640_private *dp83640;
>> +	struct dp83640_clock *clock;
>>   	int err = -ENOMEM, i;
>>   
>>   	if (phydev->mdio.addr == BROADCAST_ADDR)
>>   		return 0;
>>   
>> -	clock = dp83640_clock_get_bus(phydev->mdio.bus);
>> -	if (!clock)
>> +	err = devm_phy_package_join(&phydev->mdio.dev, phydev,
>> +				    BROADCAST_ADDR, sizeof(*clock));
>> +	if (err)
>>   		goto no_clock;
>>   
>> +	clock = phy_package_get_priv(phydev);
>> +	/* Ensure other PHY probes wait for shared clock initialization. */
>> +	mutex_lock(&phydev->mdio.bus->shared_lock);
>> +	if (phy_package_probe_once(phydev))
>> +		dp83640_clock_init(clock);
>> +	mutex_unlock(&phydev->mdio.bus->shared_lock);
>> +
>> +	mutex_lock(&clock->clock_lock);
>> +
>>   	dp83640 = kzalloc_obj(struct dp83640_private);
>>   	if (!dp83640)
> AI reviewer points out that this error path is now missing setting
> the err variable. Please clean this up as part of your change.
> Remove the init to -ENOMEM and have every goto x; path set err
> if it needs to

Thanks, this is a serious oversight. I will fix it in v3.

>>   	
>> -	if (remove_clock) {
>> -		mutex_lock(&phyter_clocks_lock);
>> -		list_del(&clock->list);
>> -		mutex_unlock(&phyter_clocks_lock);
>> -
>> -		mutex_destroy(&clock->extreg_lock);
>> -		mutex_destroy(&clock->clock_lock);
>> -		put_device(&clock->bus->dev);
>> -		kfree(clock->caps.pin_config);
>> -		kfree(clock);
>> -	}
>> +	devm_release_action(&phydev->mdio.dev, dp83640_phy_release, dp83640);
> Why the explicit call? if you're using devm_ you should let it handle
> the unwind.. If you want to have an explicit call, don't use dev_ APIs.

I used the explicit call because I was concerned about leaving the
entire unwind to devres. After the driver's .remove() callback returns,
phylib asserts reset, and the subsequent devres cleanup calls
ptp_clock_unregister(), which may issue MDIO writes while disabling PTP
events.

However, the same ordering can also occur when the driver .probe()
succeeds but later PHY core initialization fails: phy_probe() asserts
reset before devres cleanup unregisters the PTP clock.

As you point out, explicitly releasing a managed action makes the
cleanup semantics awkward, and I currently have no evidence that the
post-reset MDIO writes cause an actual problem. I will therefore drop
the explicit release in v3 and let devres handle the cleanup.

Thanks,
Xuanqiang

