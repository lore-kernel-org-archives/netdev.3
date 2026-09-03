Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794E4AC156;
	Thu,  3 Sep 2026 13:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441838; cv=none; b=M17rTg5VGwnmtaiGNt/DifEJZso5CIjbONFSg0KxgXUDMKhU04dEdbvviwpHW/PTWAsi/880T6pl4QnxCVIuLbVBU82JUSToPtsE99ey48NIxT51snK1OA9neikWMmDwDBJwt1qsAANVblg3kfXrJLTy9UyyhKNPIAidC1iy8XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441838; c=relaxed/simple;
	bh=frub2VQMr+ZJRruxm6y4R7F+JuPpLhtEq2GgjHBY4FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qTF5gS19GL6hyecOYFrJekK2obFQPHh/DEK6qOUbNDLojYkBU/mA1qaWCHO+b99zku77yKzJAJtOY67jdpJK1202y/m6DCfGb1UTVj/EjDaRWy2T+27bmkw6iVJXv9rZl8xOPVz2I00prtEUyRlFeKIJuRV8oNcOprKL5LzmGqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WLcAzEmy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WLcAzEmy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788441828; x=1819977828;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=frub2VQMr+ZJRruxm6y4R7F+JuPpLhtEq2GgjHBY4FI=;
  b=WLcAzEmyq6TB/FjbsdD/ADjO2X47KZdV+Rp2Wt0Wl27cdfRpjTOVYOiG
   KoVJXgaaaDyQV45LUgp/INTpAg/oIazUps5ORiI39IohDLQBVMyp5h1ML
   DsniXlVSoKe/MZ51rH+rIu77eHncRywn8mU9eD+PFJCb42rrD6UE9Dwym
   r4qF4tItHImZgco1bTxh3Z6/K7HFFAWmL0T5ITpcWiezDWmJtfdAr0PXX
   RTErcdXHzQ/gX3DfVszzc85sdM8IVavLNvch2RVVl8ucdfQazKLRcNPi8
   cLgZh8nkuBXDdIey44AOYOa0c6WdSS6gcz7E7GT1k4fOZA7+bAZQCRmlC
   Q==;
X-CSE-ConnectionGUID: 3tsOSTnORXaX8fAyO9KQPg==
X-CSE-MsgGUID: n3GK5IbnQhO9ADXdvkm4Fg==
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="62192746"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2026 06:23:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 3 Sep 2026 06:23:44 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 3 Sep 2026 06:23:41 -0700
Message-ID: <624254b3-2aa3-47e9-aae1-d62b2dc3f5f7@microchip.com>
Date: Thu, 3 Sep 2026 18:53:40 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <713d8963-6aa6-460e-83dc-157d37d66662@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 02/09/26 6:00 am, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
>> @@ -600,6 +642,16 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
>>                return -ENODEV;
>>        }
>>
>> +     ret = oa_tc6_phy_irq_setup(tc6);
>> +     if (ret) {
>> +             oa_tc6_mdiobus_unregister(tc6);
>> +             return ret;
>> +     }
>> +
>> +     /* Deliver the PHY interrupt through the nested virtual IRQ. Set before
>> +      * phy_connect_direct() so phylib enters interrupt mode.
>> +      */
>> +     tc6->phydev->irq = tc6->phy_virq;
> 
> I don't know how messy it will be, but it is better to set
> mii_bus->irq[] to the interrupt number. phy_device_create() will then
> copy it into phydev->irq.
Thanks for the suggestion. To use mii_bus->irq[] so that 
phy_device_create() picks it up, we would need to set mii_bus->irq[addr] 
with created virtual irq number before mdiobus_register(). However, the 
PHY MDIO address is not known until phy_find_first() returns, so we 
cannot pre-populate mii_bus->irq[addr] before the bus scan runs.

Am I misunderstanding your suggestion? Happy to rework if there's a 
cleaner way.

Best regards,
Parthiban V
> 
>          Andrew

