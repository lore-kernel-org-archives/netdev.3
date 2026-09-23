Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C356C649
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 22:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200985; cv=none; b=Q5qXtVlVV+v7ySGdz9drjm2DnIsChjesOevThv72R1oEwehQKz3moKzvYKEY2yBT6WEMBp8NAe5RbFguBO6VAWZkFXs+dq3Ne2D5XP/23DuIxt+abqi9wG0zhT57DsKaC+BKH1gyn85+83HYfWLyl6TCO1uYx0lSD7Ydc9KMXI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200985; c=relaxed/simple;
	bh=yYk+cQEBmyKfgs9xVMV9+LxohJjRqhY3MpybhWajaDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5XpGF4UUnq7Y6V5SyG09TglOPk5HyyRCPcE9Au1MV4plrT1C0TN3sShFtk1jmu7FnFag0b1uQ6qqgu9d9W4zDz8il3pjMwujKnM/mNCn+YC59QkrvCXeLj8QV8E7AS0n/Ws4cOc6kK9adfayyotRryEEE7JjDml9pUpyq9Ibjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=vfM6B4vx; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="vfM6B4vx"
Received: (wp-smtpd smtp.wp.pl 43382 invoked from network); 24 Sep 2026 00:02:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1790200979; bh=vUCplD0X6fqWM+xkXKjirMnMQB20bZX0XrUCXeaoiHU=;
          h=Subject:To:Cc:From;
          b=vfM6B4vxbGCrj5e/xi11X8fMncIq3S9qtyvRsUyBB7O9cqZjzr9eoEWHLFVH+qhVO
           96o2NvvHcqqgq3iAsAwiHIKYGBtl4mjFKRQpxl589HeQo5bzcKJKT/w31T5fmGtFZm
           vvVlWc/tYEjwdhlhPZhHoG0ANiVXTLEsZONwM1ec3wRPedvZRDS275Q3NqBGTZOIZS
           /nJt5uGo7wAJoLba37DNruiqSYubpG+JLaIgwAgY//rBdJrs4U24WeKQFZrprouUP5
           42soO7QpDZaXv4QBNzk+Ypk+JLz1D2gkPBUFKAVY/mXxIYuZGlmQrc7vNwuQsejgog
           V9CBuQsMncDCA==
Received: from [192.168.3.224] (83.5.247.11.ipv4.supernova.orange.pl [83.5.247.11])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 24 Sep 2026 00:02:59 +0200
Message-ID: <a174b2c7-3778-4f8c-be5a-2bd94bfe09ed@wp.pl>
Date: Thu, 24 Sep 2026 00:03:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: marvell: add support for PHY LEDs
 polarity modes
To: Andrew Lunn <andrew@lunn.ch>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260923204614.471409-1-olek2@wp.pl>
 <ac224909-5f7d-447e-a0f9-be0d1565a700@lunn.ch>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <ac224909-5f7d-447e-a0f9-be0d1565a700@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: b2294191e6751152fe326610682cdc87
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [QSJM]                               

Hi Andrew,

On 23/09/2026 23:07, Andrew Lunn wrote:
> On Wed, Sep 23, 2026 at 10:45:24PM +0200, Aleksander Jan Bajkowski wrote:
>> Add the led_polarity_set callback for setting LED polarity. Implement
>> this callback for the 88E1318 and 88E1510 PHYs. This should also work on
>> other Marvell PHYs, but I don't have access to the TRM or the hardware.
>>
>> Tested on Adapteva Paralella board with Marvell 88E1318 PHY.
>>
>> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
>> ---
>> Changes in v2:
>>   - add suppoer for PHY_LED_INACTIVE_HIGH_IMPEDANCE mode
>> ---
>>   drivers/net/phy/marvell.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
>> index f71cffa88406..d57fcabfec2b 100644
>> --- a/drivers/net/phy/marvell.c
>> +++ b/drivers/net/phy/marvell.c
>> @@ -149,6 +149,9 @@
>>   #define MII_88E1318S_PHY_LED_FUNC_ON		(0x9)
>>   #define MII_88E1318S_PHY_LED_FUNC_HI_Z		(0xa)
>>   #define MII_88E1318S_PHY_LED_FUNC_BLINK		(0xb)
>> +#define MII_88E1318S_PHY_LED_POL		0x11
>> +#define MII_88E1318S_PHY_LED_POL_ACT_HIGH(idx)	BIT(2 * (idx))
>> +#define MII_88E1318S_PHY_LED_POL_HIGH_IMP(idx)	BIT(2 * (idx) + 1)
>>   #define MII_88E1318S_PHY_LED_TCR		0x12
>>   #define MII_88E1318S_PHY_LED_TCR_FORCE_INT	BIT(15)
>>   #define MII_88E1318S_PHY_LED_TCR_INTn_ENABLE	BIT(7)
>> @@ -304,6 +307,8 @@
>>   #define NB_FIBER_STATS	1
>>   #define NB_STAT_MAX	3
>>   
>> +#define M88E1318S_MAX_LEDS	3
> Why the M88E1318S prefix?

The number of LEDs depends on the PHY variant:
88E1112 -> 4
88E1116R -> 3
88E1240 -> 4
88E1318S -> 3
88E1510 -> 3
88E1545 -> 4
88E1548P -> 4
All of these PHYs likely have the same polarity register layout.

>
> The naming is a bit odd in this file, but maybe NB_MAX_LEDS?
NB_MAX_LEDS might be confusing since the number of LEDs can
vary, but I don't have a preference and can change M88E1318S to 
NB_MAX_LEDS.
>
>      Andrew
