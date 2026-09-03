Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06364A3F00;
	Thu,  3 Sep 2026 13:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440564; cv=none; b=egATCHDd+xfy5HhUa2RERAx8jPQjXChanEzE9ukwzkUROcdmB1NoUObCPDVd0zUgjUFKOIdgLAkU8DjjkPdk2Hp/gm3+G6DvlHfIeiMV1pd1+dJwKsLedAEtB+mHubs2We/nVZ/eqhefWVhGI5k8tQ4/+ZKgdH3MTYcP93ojQOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440564; c=relaxed/simple;
	bh=NsNiiOJhjJOyQBwkOa8osN/CvVc6DbJIZKeNK43iIyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kj9hjiTL4H6d7RYrbrs+puGhbhDzk+t9r6+OkRGTGg0wG6aWAS2q/mtAyGFsTl6TpXuJkf/5mwEOUnO5s9Ns1X3ke7/MD8PTmdSTXwvMz3YUJl/LG0Kz8ZklcypLRzpW/gIBwP21odvVR8u0G+9skewfKrxC65QoHz3UZaUkeUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MWJiZKsr; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MWJiZKsr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788440564; x=1819976564;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NsNiiOJhjJOyQBwkOa8osN/CvVc6DbJIZKeNK43iIyo=;
  b=MWJiZKsrWPYz5B2pnKck2rb/hoctd904XeKdNF0gM3XeRAiE9npDISA2
   j3VyngngyIRSyMLvgBVxt4XdBenZmvo6FY23C4oMELPBEgLGDmoZajf7j
   T3OqoR1ZY+kQlL+vxKN5y7xcyf7ZX6p5I/ZzX73ias6MhkcQcjZ30ID+/
   ewmm7E5pjRlK4dd3uQdSKZhwKdpOclgou1b8d4cFOxa6/GZCeMmgPjkJN
   RKhT+RhQFMrB4JaO0JNbYkYS+1O8XgXuwxHErl1wSlNgY7YgGDuhLdbUW
   OscAlAiW3jxXSGpoutkBZUXss7G2XKOwJ9f68RmVSrkhhlIFpixzXULef
   A==;
X-CSE-ConnectionGUID: oYpgwqYwQAeHdElgU6Fc/w==
X-CSE-MsgGUID: K8NdNRSjTWSMkBeIcuB0nQ==
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="63413965"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 06:02:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 3 Sep 2026 06:02:30 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 3 Sep 2026 06:02:27 -0700
Message-ID: <28cf906d-cd94-4497-9641-6220d57da3dd@microchip.com>
Date: Thu, 3 Sep 2026 18:32:26 +0530
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
 <dbb77cce-b574-42d9-8a26-a12a0446d1b9@lunn.ch>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <dbb77cce-b574-42d9-8a26-a12a0446d1b9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

Thank you for reviewing this patch series.

On 02/09/26 6:13 am, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Tue, Sep 01, 2026 at 06:39:47PM +0530, Parthiban Veerasooran wrote:
>> The integrated PHY has no dedicated interrupt line; its interrupt is
>> delivered in-band as the PHYINT bit in STATUS0, which raises the MAC-PHY
>> SPI interrupt via the extended status. phy_mac_interrupt() only triggers
>> a link-status re-read and cannot make the PHY driver read and acknowledge
>> its interrupt source registers, so expose the PHY interrupt to phylib as a
>> nested virtual IRQ instead.
>>
>> Use dummy_irq_chip as the irqchip, map a virtual IRQ and assign it to
>> phydev->irq before phy_connect_direct() so phylib enters interrupt mode
>> and uses the PHY driver's config_intr/handle_interrupt. Unmask PHYINT in
>> INT_MASK0, and when it is seen in the extended status, dispatch
>> handle_nested_irq() synchronously from the sleepable threaded IRQ. PHYINT
>> is level triggered, so acking the PHY source there clears it before the
>> next data chunk, avoiding a storm.
> 
> 
>     9.2.8.7 PHYINT
> 
>     Physical Layer Interrupt. When set, this bit indicates a service
>     request from the underlying physical layer block.  Many physical
>     layer implementations support an interrupt output for signaling
>     events to the station controller. This bit is optional and will be
>     implemented only if the underlying physical layer supports
>     generating interrupts to a higher level. When implemented, this bit
>     shall be cleared by acknowledging the underlying physical layer
>     interrupt source(s). When not implemented, this bit shall be
>     reserved with a read- only value of zero.
> 
> At the moment, phylib is polling the PHY. That is guaranteed to work.
> 
> The standard indicates this interrupt is optional. It might not be
> implemented. phylib assumes that if there is an interrupt, the
> interrupt works, and it does not poll. So any hardware which does not
> implement this interrupt is now broken.
> 
> Please find a way not to break other devices.
Thank you for pointing it out. PHYINT is optional per the OA TC6 
standard (section 9.2.8.7), and unconditionally setting up the virtual 
IRQ breaks devices that do not implement it.

I checked both the OA TC6 standard (V1.1) and the LAN8650/1 datasheet, 
and there is no capability register bit to detect PHYINT support at runtime.

The oa_tc6 driver already has a quirk_flags mechanism (enum 
oa_tc6_quirk_flag, struct oa_tc6_quirks) used for the existing 
OA_TC6_BROKEN_PHY flag. I plan to add a new flag to the same enum:

enum oa_tc6_quirk_flag {
     OA_TC6_BROKEN_PHY = BIT(0),
     OA_TC6_PHY_INT    = BIT(1),
};

The virtual IRQ setup, PHYINT unmasking, and interrupt dispatch in 
oa_tc6_process_extended_status() will all be guarded by OA_TC6_PHY_INT. 
The LAN865X driver, which always implements PHYINT, will pass the 
quirk_flags as OA_TC6_PHY_INT. Any other TC6 device that does not pass 
this flag will remain in PHY_POLL mode safely.

Hope this is fine?

Best regards,
Parthiban V
> 
> 
>      Andrew
> 
> ---
> pw-bot: cr

