Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152DD341ADD
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777878; cv=none; b=I2FLgkV203YVmRc/fg5RhQXPrYj8Jvunkka/TcqkxXxLvFxtIt3YcBgGyp+3JTX2FckKodPn85rqEPggOiMrCAQrgMdpzmjgkAKHaipVzAT5NbfZZbG85ngUzPezSFff4SszhPCyAc/ZnaACLChwPfxiLtvEaShM0vIt+b4SfyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777878; c=relaxed/simple;
	bh=7z3tE4RDzZiB4iP6lbOw0bLf3cfAd4QmDLT1ytztOiM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=lKGfgAzYllrRrOsPcVA1sCYUUhLvo4RO4buwP6UblzxKZc/7UegJtq0b/AjMujfyg/ovUFTLa14hi4f9Yi0HVyM1CwAn8N4V6ZWDCoKfUVJdhncSevGtaJ9/BV+DGDm498FMW2El6gRTGdWjmO3ovt4dgWI3r9y4PXzq0mZPnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=2vMQt6wA; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="2vMQt6wA"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 05F6BA5005;
	Tue, 17 Mar 2026 21:04:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1773777874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Y/VS7wK5yL9YZIkaHv5AIW1qw6pQGtMlgrcSqK5tcpU=;
	b=2vMQt6wATbTiYYPlXWeITaGNghjM8WRSNvRn08hhiTKo6yFWl+ZLpa8oOTfPZzOFMliwjL
	sbQ8LoLVug6wQCmnliYu2Ie22dftNbuewRjo6j+3oG7pcRgKquBk60HOmOMcxuv2hgBMY9
	qH5Yas/1R2qqZImVyDSjL6Zx6Qjqy16pE8qVtK3KeQV7vfXc2ikNZTCPSbgkyfzntnBu1H
	yIHQpbby+O83m4OODji/oAb59ocbEzhnEQjWfksy6flkQ0HRdI99MQDx+242/ga3MmGe2S
	WJsljwCZ3ZNtv2YH9vnoDIq9Qm59F55oJQwPZgIhiWK+XeUAXgKQ9/519uNCnA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Mar 2026 21:04:32 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Breno Leitao <leitao@debian.org>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the interface
 is running
In-Reply-To: <abmtcI4NX_zFyAwA@gmail.com>
References: <20260316092720.39198-1-nb@tipi-net.de>
 <abmtcI4NX_zFyAwA@gmail.com>
Message-ID: <237dbfc3991654f15a328ba267e67a4b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 17.3.2026 20:42, Breno Leitao wrote:
> On Mon, Mar 16, 2026 at 10:27:20AM +0100, Nicolai Buchwitz wrote:
>> macb_change_mtu() currently returns -EBUSY if the interface is 
>> running,
>> requiring users to bring the interface down before changing the MTU. 
>> This
>> is unnecessarily restrictive.
>> 
>> Instead, close and reopen the interface around the MTU change so that 
>> RX
>> DMA buffers are reallocated for the new MTU. This is the same approach
>> used by many other network drivers (e.g. igb, tg3, stmmac).
>> 
>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
>> ---
>>  drivers/net/ethernet/cadence/macb_main.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/cadence/macb_main.c 
>> b/drivers/net/ethernet/cadence/macb_main.c
>> index 5e27e0e87a55..8dd01031250d 100644
>> --- a/drivers/net/ethernet/cadence/macb_main.c
>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>> @@ -3262,11 +3262,16 @@ static int macb_close(struct net_device *dev)
>> 
>>  static int macb_change_mtu(struct net_device *dev, int new_mtu)
>>  {
>> -	if (netif_running(dev))
>> -		return -EBUSY;
>> +	bool was_running = netif_running(dev);
>> +
>> +	if (was_running)
>> +		macb_close(dev);
>> 
>>  	WRITE_ONCE(dev->mtu, new_mtu);
>> 
>> +	if (was_running)
>> +		return macb_open(dev);
> 
> Would you like to keep the new_mtu set, even if macb_open() fails?

I think keeping the new MTU even if macb_open() fails is fine. The 
interface is down at that point anyway?
igb does the same and even discards the igb_up() return value entirely. 
At least we propagate the error.

> 
> Other than that, it looks good to me.
> --breno

Thanks
Nicolai
