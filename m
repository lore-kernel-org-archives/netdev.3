Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A993EC81F;
	Mon,  7 Sep 2026 04:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753771; cv=none; b=WHoJ5fSov0C/TeWJEelZYNVB2ebT+FHpVBhIr/A7n6LtuA+6pmeiD44KJFPjxL0cdnu25hcIamUuxU8xE76gYRdF3bCqk+typA8WT2ga7jU2Toc/RoGpgOIMY3iE16elbUaFbxkYmhQV7XC1Kdyw/5MjKqcsmiDmFRF3KUF1ny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753771; c=relaxed/simple;
	bh=7bZ9ueJcnettW+aBUjwEodtcUi8JIXG3WGgB1oFPyk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IwxMIrQJEMkaAs2HwmMIat7qJKyeHAd+Ha3tz9Wzj0wqNH+QuWHf20pKfFUeAeXZ3q6Lx5i3zg3C0QBSQ1riBSrsNf8UdEp7i/bEtGRRdjordZU1weMlqcrOD6I9RdITRsb3e0cBMcl3AhOeuIfvUFwrsUUbq2Z0WJ23hWYOaxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=a2y2BKYP; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="a2y2BKYP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788753770; x=1820289770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7bZ9ueJcnettW+aBUjwEodtcUi8JIXG3WGgB1oFPyk8=;
  b=a2y2BKYPbRq7nRhptGqN24A6YPByRAQHs0g9IkmDlW6o0o68X2zuaQHX
   QTbx9/Wp/QiSoxlGjByBIQBIn6pvCFa1f6Rrc7t8fbd54BwNFATe275iQ
   /d37qprnr5yt0OYqHi/5xagpxrbVQVWxFGpWLGuHZoTl/3Sa8ISL2JNZB
   y23ssHT5SymxRe7wH8Hoz7IVfY589T1xc0cRhjzgWtSLz2G3tA8erPXpA
   W4CZDaSyGYJBqiUF2mmikedj5B9sHHVxq4/vCP4rT3D1fTg+1hvflV1Xt
   eJkrF8SHyUu87hLPQk9LzUGJ2WxOJWI1kGpEVo2u5T8zAi8qvryvT+mNp
   w==;
X-CSE-ConnectionGUID: BWI1/n8BQXWiufWaVsbH9A==
X-CSE-MsgGUID: BiJKOKs4Q7CMxtZ8J5CiFw==
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="63233718"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2026 21:02:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 6 Sep 2026 21:02:43 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Sun, 6 Sep 2026 21:02:39 -0700
Message-ID: <23c470ae-95b8-4391-a3a1-0c9996ce48dc@microchip.com>
Date: Mon, 7 Sep 2026 09:32:38 +0530
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
 <a01b3780-b36d-4544-a372-9daa3be20a9f@microchip.com>
 <844a369e-3e52-4489-b8b1-d359789bfcb3@lunn.ch>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <844a369e-3e52-4489-b8b1-d359789bfcb3@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/26 6:37 pm, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
>> +     /* Populate all irq[] entries before registration so
>> +      * phy_device_create() picks up the virtual IRQ regardless of
>> +      * the PHY's MDIO address.
>> +      */
>> +     for (i = 0; i < PHY_MAX_ADDR; i++)
>> +             tc6->mdiobus->irq[i] = tc6->phy_virq;
> 
> Yes, or just a memcpy().
Thank you for the suggestion and confirmation. I do not think memcpy() 
would fit here since we are assigning the same value to all entries 
rather than copying from another buffer. But I will also check whether 
any helper would be appropriate here. If not will keep this loop as-is.

Best regards,
Parthiban V>
>       Andrew

