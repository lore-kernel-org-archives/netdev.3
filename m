Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FFE378838;
	Fri,  4 Sep 2026 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788501949; cv=none; b=hLzE8ZTY4J5zhKR0GfrB7pcbkM8yL3Vj9fcRcfRG46nzNQH0XqaEG2J8RtG72LOoGta4ZJDmWyuNT5aUHl1FfpTcTb4MBfAMitMzcvn1cKCGiJ4WYTeoI06XX5xPQHFNN65ERYTAn1Y1wG5jsJan4x0v5PBP9LQk3liD7Kg7+Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788501949; c=relaxed/simple;
	bh=pRLUxm9WhfxBSGvT32fKsSjS59ea8stQa5vwLn/FUq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PNqhaDZ6yqXG4BHHYv8ktD84zaE1Ryagn431Uh3kQ5i7uLVLZ/dTZ7+ln/pHfHJz3+YJ4pDBzpxwHC9CLS1a3OITvulA2mbRIFow7YXHRmq7ZfnknSkzWIOkknKIhYGPhhDNsS29/UjigCzfg9CeAxHWV1LPrLfZ4mOgAGFUNLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iGBwGfCp; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iGBwGfCp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788501947; x=1820037947;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pRLUxm9WhfxBSGvT32fKsSjS59ea8stQa5vwLn/FUq8=;
  b=iGBwGfCp+v8PnI2CfshKY2nHZPAikJwWeftYTxNuPW0QQTzOpmu4kVin
   mHKOO+e4wJiS0cwZ0l3HS5fcqVLa8t8kMGMzNyxfh+yRz6BmUS+OpRiuD
   VFVMRP2orhz4Y7a5SEiFiH1rpuxRruLeg2ReVG7resaEoOS/ay6Phn6BQ
   UW8qwEAlhnFMbuGDLPjQ+kfBEBci6p8IsFJZu5/YoOSJ6dgSLYDfZseZo
   Hd9gk9OfUqWDEtvgB8kZfvrTA1DrWzBnlLZlWoOw9nlV2gte9YtfctdGF
   IqeXiUx64XL6EKEJ5F2/oMVU5hzlGBm0pYtCfLZDLUm/Peb00ZXe2hCAU
   w==;
X-CSE-ConnectionGUID: 0H+Mr+euQ+eD33vhoggmKA==
X-CSE-MsgGUID: o9y2ZRPwRaWo7vSRq8NU4Q==
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="62241439"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2026 23:05:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 3 Sep 2026 23:05:46 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 3 Sep 2026 23:05:42 -0700
Message-ID: <a01b3780-b36d-4544-a372-9daa3be20a9f@microchip.com>
Date: Fri, 4 Sep 2026 11:35:41 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 2/3] net: ethernet: oa_tc6: deliver the PHY
 interrupt to phylib
To: Andrew Lunn <andrew@lunn.ch>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>
References: <20260901130948.212914-1-parthiban.veerasooran@microchip.com>
 <20260901130948.212914-3-parthiban.veerasooran@microchip.com>
 <713d8963-6aa6-460e-83dc-157d37d66662@lunn.ch>
 <624254b3-2aa3-47e9-aae1-d62b2dc3f5f7@microchip.com>
 <2d313e42-3fbe-4fc9-bd57-23a951d997b9@lunn.ch>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <2d313e42-3fbe-4fc9-bd57-23a951d997b9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/26 7:44 pm, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Thu, Sep 03, 2026 at 06:53:40PM +0530, Parthiban Veerasooran wrote:
>> Hi Andrew,
>>
>> On 02/09/26 6:00 am, Andrew Lunn wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>>> @@ -600,6 +642,16 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
>>>>                 return -ENODEV;
>>>>         }
>>>>
>>>> +     ret = oa_tc6_phy_irq_setup(tc6);
>>>> +     if (ret) {
>>>> +             oa_tc6_mdiobus_unregister(tc6);
>>>> +             return ret;
>>>> +     }
>>>> +
>>>> +     /* Deliver the PHY interrupt through the nested virtual IRQ. Set before
>>>> +      * phy_connect_direct() so phylib enters interrupt mode.
>>>> +      */
>>>> +     tc6->phydev->irq = tc6->phy_virq;
>>>
>>> I don't know how messy it will be, but it is better to set
>>> mii_bus->irq[] to the interrupt number. phy_device_create() will then
>>> copy it into phydev->irq.
> 
>> Thanks for the suggestion. To use mii_bus->irq[] so that phy_device_create()
>> picks it up, we would need to set mii_bus->irq[addr] with created virtual
>> irq number before mdiobus_register(). However, the PHY MDIO address is not
>> known until phy_find_first() returns, so we cannot pre-populate
>> mii_bus->irq[addr] before the bus scan runs.
> 
> This is why i made the comment, i did not know how messy it would be.
> 
> Where it becomes interesting is the recent patch:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20260902080511.2211261-3-f@lex.la/
> 
> It just seems a bit brittle, phydev->irq says one thing, mii_bus->irq[]
> says something else.
> 
> Maybe set all member of mii_bus->irq[]?
Thanks for pointing to that patch. Now the concern is clear: 
mdiobus_alloc() initialises all bus->irq[] entries to PHY_POLL, so if 
phydev->irq is set directly without updating mii_bus->irq[], 
phy_restore_genphy_irq() would restore phydev->irq back to PHY_POLL if 
the generic driver ever binds.

So the fix would be to move oa_tc6_phy_irq_setup() before 
mdiobus_register(), populate all mii_bus->irq[] entries with the virtual 
IRQ, and drop the direct phydev->irq assignment. phy_device_create() 
then copies the correct value from bus->irq[addr] during the bus scan, 
keeping both tables consistent.

+     /* Populate all irq[] entries before registration so
+      * phy_device_create() picks up the virtual IRQ regardless of
+      * the PHY's MDIO address.
+      */
+     for (i = 0; i < PHY_MAX_ADDR; i++)
+             tc6->mdiobus->irq[i] = tc6->phy_virq;

       ret = mdiobus_register(tc6->mdiobus);
       if (ret) {
               netdev_err(tc6->netdev, "Could not register MDIO bus\n");
               mdiobus_free(tc6->mdiobus);
               return ret;
       }

Hope this is what expected?

Best regards,
Parthiban V
> 
>        Andrew

