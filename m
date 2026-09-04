Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C638B7D4;
	Fri,  4 Sep 2026 06:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788501783; cv=none; b=GR/fTlvfwG7qd3zlRozRCDahi8iYr3RzLq/zq+b+Aoc2v1O8W3q3oHPr9ZGViHcHMnpj6Q3PnUdsiaAI6VFP6KfGJ9ERUhKQ/lj8jizFs6fVTtvbtO2InFHAGP+HpwIsFWEv61rHmHqag1wXGolWRCtYtinIqgOTg4a2cL1O94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788501783; c=relaxed/simple;
	bh=dZwf146yjYnJuybOpC/hSEzpcgtrkMvvqhILrSjyusk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JsV+8mFLnuxvOeVnok2XN7jiGv7epY8a7Jh5JcPaqO8En77c2//EpKHDQ9fY2MWaFnxn/hCvDkWtZSU2sEYuNIuG9NR3GAm8ctPfH4ljuEMGn/zED5qV2zbPhPquJ6tO1QSrwp5/IB5O7Nt8+OkQP6y0EDJIW+jWFJob4hhF22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=eXXJmI8x; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="eXXJmI8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788501782; x=1820037782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dZwf146yjYnJuybOpC/hSEzpcgtrkMvvqhILrSjyusk=;
  b=eXXJmI8xQzQp8m+C5SVcUemIxH0zzEpzbljN+GCSKi8AVn63URu3FP8v
   ecJZrML5jnXLi4TTSm6nQBXuGz953Xt2zetlRRHr9ABSsKnPU0WhPAWY3
   DncOlKqChzcIV3lM7xy7kiezkIymrhtGBuhfKKSo8m1GjslVV+ansd/nG
   kw0oDJET2V7FFEfXzxL6gBbrDFQlEEE2Vuf20unXEImSibDMjqTGNcffl
   H+Ov/XAjwgaVyB+9CmMY1YgdjaPDf0Jhc3qo1fCo8Lq6iwdJzoby80l9R
   zKQ0kZ1Jn8If/QapRR4rQVqiDx0EphmvGJXyw3YIkY9tf87OGqrlvEXcw
   g==;
X-CSE-ConnectionGUID: qGZcB4xfSDiJ6SMpmfALPQ==
X-CSE-MsgGUID: XPmTujQeRX6wDxkc2b2WLQ==
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="63151664"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 23:02:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Thu, 3 Sep 2026 23:02:53 -0700
Received: from [10.40.24.197] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 3 Sep 2026 23:02:50 -0700
Message-ID: <f7f2b901-e452-4c64-a782-c5151c78fa84@microchip.com>
Date: Fri, 4 Sep 2026 11:32:49 +0530
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
 <dbb77cce-b574-42d9-8a26-a12a0446d1b9@lunn.ch>
 <28cf906d-cd94-4497-9641-6220d57da3dd@microchip.com>
 <b7386bf3-dfd0-4ddf-8a14-76c29cb8ac9b@lunn.ch>
Content-Language: en-US
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
In-Reply-To: <b7386bf3-dfd0-4ddf-8a14-76c29cb8ac9b@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/26 7:24 pm, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Thu, Sep 03, 2026 at 06:32:26PM +0530, Parthiban Veerasooran wrote:
>> Hi Andrew,
>>
>> Thank you for reviewing this patch series.
>>
>> On 02/09/26 6:13 am, Andrew Lunn wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On Tue, Sep 01, 2026 at 06:39:47PM +0530, Parthiban Veerasooran wrote:
>>>> The integrated PHY has no dedicated interrupt line; its interrupt is
>>>> delivered in-band as the PHYINT bit in STATUS0, which raises the MAC-PHY
>>>> SPI interrupt via the extended status. phy_mac_interrupt() only triggers
>>>> a link-status re-read and cannot make the PHY driver read and acknowledge
>>>> its interrupt source registers, so expose the PHY interrupt to phylib as a
>>>> nested virtual IRQ instead.
>>>>
>>>> Use dummy_irq_chip as the irqchip, map a virtual IRQ and assign it to
>>>> phydev->irq before phy_connect_direct() so phylib enters interrupt mode
>>>> and uses the PHY driver's config_intr/handle_interrupt. Unmask PHYINT in
>>>> INT_MASK0, and when it is seen in the extended status, dispatch
>>>> handle_nested_irq() synchronously from the sleepable threaded IRQ. PHYINT
>>>> is level triggered, so acking the PHY source there clears it before the
>>>> next data chunk, avoiding a storm.
>>>
>>>
>>>      9.2.8.7 PHYINT
>>>
>>>      Physical Layer Interrupt. When set, this bit indicates a service
>>>      request from the underlying physical layer block.  Many physical
>>>      layer implementations support an interrupt output for signaling
>>>      events to the station controller. This bit is optional and will be
>>>      implemented only if the underlying physical layer supports
>>>      generating interrupts to a higher level. When implemented, this bit
>>>      shall be cleared by acknowledging the underlying physical layer
>>>      interrupt source(s). When not implemented, this bit shall be
>>>      reserved with a read- only value of zero.
>>>
>>> At the moment, phylib is polling the PHY. That is guaranteed to work.
>>>
>>> The standard indicates this interrupt is optional. It might not be
>>> implemented. phylib assumes that if there is an interrupt, the
>>> interrupt works, and it does not poll. So any hardware which does not
>>> implement this interrupt is now broken.
>>>
>>> Please find a way not to break other devices.
>> Thank you for pointing it out. PHYINT is optional per the OA TC6 standard
>> (section 9.2.8.7), and unconditionally setting up the virtual IRQ breaks
>> devices that do not implement it.
>>
>> I checked both the OA TC6 standard (V1.1) and the LAN8650/1 datasheet, and
>> there is no capability register bit to detect PHYINT support at runtime.
> 
> I also did a quick check of the standard and could not find an
> indication if interrupts were support. So a quirks flag does seem to
> be the correct solution.
Thank you for the confirmation. I will implement it in the next version.

Best regards,
Parthiban V>
>     Andrew

