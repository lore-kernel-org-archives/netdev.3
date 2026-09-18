Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873D4AE8D2
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 08:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721395; cv=none; b=q93HFxGr7zNnHpfG5WwXPVzN6egNGLsSoJ0g2XmmcDqWxYkchTt5mA/eDK3HhVUjOhricGvUgFWcRvIQEQN07ruI1gC4xa4OXxYb8ehDPw1ubGTxxRCt154jXI7ZUVqnRZ6cnUabN1jYiJ+yaC4+p5f6sMpEtyRQQhuQ+Hghho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721395; c=relaxed/simple;
	bh=ne5pV0b3NmbGQn0lL6xAtGEOg7z70gJ6LRIvCmFWkN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAM5zofAh0nIMiBXfBf5JXiRz4g+LV3GCbMeVsIm+RUuews4xrpU66rHbJMy0suVdJJgWjUo93h1t+MRr/pHbayV6DY2k2I62316FGHep8wNWxivd/hZqXN02zv4ao9H7Tav51J9YA61OmXBQvXvMW9WQ3WorbeoBRfSU+RjZck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OB2lkrNa; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OB2lkrNa"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AA1C64E408C8;
	Fri, 18 Sep 2026 08:49:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7592D60649;
	Fri, 18 Sep 2026 08:49:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CF9610328A4C;
	Fri, 18 Sep 2026 10:49:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789721381; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rF3oWfGzFnTY0SoCjVn3gmsNgNzzK1a/ublsZkNPNl4=;
	b=OB2lkrNa0BtH49xDYO8RkPEalsTzlrnCb2g4M98IMO7BOpLVOL4JL2bzA8IgN2gdVA7oRX
	gqAWz2Dxvh6c2HKzjU8N6KCHESSaz+8YovTYHY0se498AxMnNzmUmmGy1KbotSJX8VfgfV
	t+LikhJTj3vI1WcW9h28jx4TEVamx1XdUJriSDKhn4b1QtG9Ui39RR723jkScpB/Ia7tLs
	V7voptBHkjrEI94ojFBIpJ5ATMMYb0QbW9um8F9v1rPQNZ1sbJzkvS11tP6bft2XuzeNlz
	KFajEVQ0uVm3zop6WB4+upKqDmq8uzwfJ/ChUQKeGGxoZ9VwoOdnZW0ZpHyNzw==
Message-ID: <f765bde3-0527-472a-a706-49d7ad7aed79@bootlin.com>
Date: Fri, 18 Sep 2026 10:49:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net] net: bcmgenet: add hwtstamp callbacks to restore PHY
 timestamping
To: Nicolai Buchwitz <nb@tipi-net.de>, James Clark <jjc@jclark.com>
Cc: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Richard Cochran <richardcochran@gmail.com>
References: <20260918030149.80398-1-jjc@jclark.com>
 <fe0a80d1f1f6aa553c1ea838cea52c18@tipi-net.de>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <fe0a80d1f1f6aa553c1ea838cea52c18@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/18/26 10:20, Nicolai Buchwitz wrote:
> Hi James
> 
> On 18.9.2026 05:01, James Clark wrote:
>> Hardware timestamp configuration fails with EOPNOTSUPP on BCMGENET
>> interfaces connected to a timestamp-capable PHY. On a Raspberry Pi
>> CM4, "hwstamp_ctl -i eth0 -t 1 -r 12" fails with "SIOCSHWTSTAMP failed:
>> Operation not supported", preventing ptp4l from using hardware
>> timestamping.
>>
>> Commit 5062245a5a7f ("net: remove legacy way to get/set HW timestamp
>> config") removed the legacy ioctl fallback, assuming that all MAC
>> drivers supporting hardware timestamping implement ndo_hwtstamp_get()
>> and ndo_hwtstamp_set(), even when timestamping is provided only by
>> an attached PHY. BCMGENET does not implement these callbacks, so the
>> core rejects timestamp configuration requests before they reach
>> the PHY.
>>
>> Add ndo_hwtstamp_get() and ndo_hwtstamp_set() callbacks so the core
>> can dispatch timestamp configuration requests through its phylib
>> helpers. Both callbacks return -EOPNOTSUPP because the MAC itself
>> does not support hardware timestamping; requests for the PHY are
>> handled by the core without invoking these callbacks.
> 
> I've tested with and without your patch and can reproduce the issue / fix.
> IMHO the commit message should mention that 'get' isn't restored - it was
> already broken as the legacy path through phy_mii_ioctl() only handled
> SIOCSHWTSTAMP.
> 
>>
>> Fixes: 5062245a5a7f ("net: remove legacy way to get/set HW timestamp 
>> config")
>> Assisted-by: LLM
>> Signed-off-by: James Clark <jjc@jclark.com>
>> ---
>>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/ 
>> net/ethernet/broadcom/genet/bcmgenet.c
>> index a2305e642..8ead37ff9 100644
>> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
>> @@ -3712,6 +3712,19 @@ static int bcmgenet_change_carrier(struct 
>> net_device *dev, bool new_carrier)
>>      return 0;
>>  }
>>
>> +static int bcmgenet_hwtstamp_get(struct net_device *dev,
>> +                 struct kernel_hwtstamp_config *cfg)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +static int bcmgenet_hwtstamp_set(struct net_device *dev,
>> +                 struct kernel_hwtstamp_config *cfg,
>> +                 struct netlink_ext_ack *extack)
>> +{
>> +    return -EOPNOTSUPP;
>> +}
> 
> The check that rejects the request is in dev_set_hwtstamp():
> 
>          if (!ops->ndo_hwtstamp_set)
>                  return -EOPNOTSUPP;
> 
> It runs before dev_set_hwtstamp_phylib() checks phy_is_default_hwtstamp()
> and nothing about this is specific to bcmgenet. Personally, I think this 
> should
> be better handled by the core than adding -EOPNOTSUPP stubs to the drivers.
> 
> I will send a patch for this.

I agree. Now that the legacy ioctl fallback has been removed from all 
NIC drivers we don't need this check to verify its support anymore.

Regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

