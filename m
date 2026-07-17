Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830C3D9544
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289982; cv=none; b=GnIo6x5kbpAk+GEhuHHPM+m5n48/XyFRHGPHZEh2xA4wUU88u/hGhz41GaqwFmsYL1WaAvnBX0dQig9ExMsdUypRmO6HOLoOCVWSeJGJQDz6eynO2OEQRGka8bcNjaCUMF+mNS1zoQ+SXchToKC2pnkqF0BUtAiQwX3i76QggCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289982; c=relaxed/simple;
	bh=DehYR9GSpet4gvKNkoPP7w0Cevm/tQFt57PX1BoEUW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ek7EoEs3CMS2WRgargSnU5n9hsOrgBPX9j+fVayOQiac5CgGakGToMgaSPU4Bq0fd8k/kWZCxk1jOYvtYWG9mLosa9hd+tfciBx+F5hn6IHoSa5ZpuphHbyAwoaksSBPJ/mvRYQIa9RDqXFqTm4/T2NxLMj4Gf4bmgbA1yq1CuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UIsJTKLw; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UIsJTKLw"
Message-ID: <eee42ee1-386e-996f-b9d8-8aa2e820d311@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784289968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q96A+H28+hAMrLim84hNXn4qwzFbgTA3nkkzS6l341k=;
	b=UIsJTKLwPU2Agemm5e6rrxM7iiERp/vLuH/P8EJS1dG3R5eAp4UdNiU+M9McUU180yCnmg
	2YbWg6ZllTQAGQknOx49AujDT5V8ZSVIZguSukNMiwZWO7Vu/9dO5L+LSJiVwjBmcz6MkL
	VHd0CEZLiXff+IoJAfBJqcg5Q8zES9w=
Date: Fri, 17 Jul 2026 08:05:59 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2] net: dpaa: fix mode setting
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Michael Walle <mwalle@kernel.org>,
 Madalin Bucur <madalin.bucur@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710143430.2276141-1-mwalle@kernel.org>
 <a5c5b8a6-85a8-7830-e19b-ffd5de750e3c@linux.dev>
 <DJUZ1VG8U9SL.2W0CJM7NSMK2@kernel.org>
 <2c8f63f5-f04a-4abc-9508-4c47a80da543@redhat.com>
 <DK0RLUBEKFVS.168UHY5BP8D4E@kernel.org>
 <26cb3349-5344-48c0-b0b7-37133b4e0662@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <26cb3349-5344-48c0-b0b7-37133b4e0662@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/17/26 07:11, Paolo Abeni wrote:
> On 7/17/26 12:13 PM, Michael Walle wrote:
>> On Fri Jul 17, 2026 at 12:01 PM CEST, Paolo Abeni wrote:
>>> On 7/10/26 4:47 PM, Michael Walle wrote:
>>>> On Fri Jul 10, 2026 at 4:39 PM CEST, Sean Anderson wrote:
>>>>> On 7/10/26 10:22, Michael Walle wrote:
>>>>>> Before converting to the phylink interface, the init function would have
>>>>>> set the correct I/F mode depending on the maximum link speed of an
>>>>>> interface. After converting to phylink, the established link speed
>>>>>> is used to determine this setting and is set in the .link_up()
>>>>>> callback. The callback isn't called because the link is never
>>>>>> established between the PCS and a connected SGMII PHY.
>>>>>> To fix it, don't use the current speed, but set the mode depending on
>>>>>> the interface (which implies the maximum speed) in .mac_config().
>>>>>>
>>>>>> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
>>>>>> Suggested-by: Sean Anderson <sean.anderson@linux.dev>
>>>>>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>>>>>> ---
>>>>>> FWIW, I dropped setting a non-reserved mode in init(). The hardware
>>>>>> default is 0 and the mac_config() will set a valid mode anyway.
>>>>>>
>>>>>> Changes in v2:
>>>>>>    - the setting is/was based on the maximum speed, not the current
>>>>>>      speed. thus, move the setting into mac_config().
>>>>>>    - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwalle@kernel.org/
>>>>>>
>>>>>>    .../net/ethernet/freescale/fman/fman_dtsec.c  | 26 ++++++++++---------
>>>>>>    1 file changed, 14 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>>>>> index fe35703c509e..7075f93bab49 100644
>>>>>> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>>>>> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>>>>>> @@ -900,22 +900,28 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
>>>>>>    {
>>>>>>    	struct mac_device *mac_dev = fman_config_to_mac(config);
>>>>>>    	struct dtsec_regs __iomem *regs = mac_dev->fman_mac->regs;
>>>>>> -	u32 tmp;
>>>>>> +	u32 ecntrl, maccfg2;
>>>>>> +
>>>>>> +	maccfg2 = ioread32be(&regs->maccfg2);
>>>>>> +	maccfg2 &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
>>>>>>    
>>>>>>    	switch (state->interface) {
>>>>>>    	case PHY_INTERFACE_MODE_RMII:
>>>>>> -		tmp = DTSEC_ECNTRL_RMM;
>>>>>> +		ecntrl = DTSEC_ECNTRL_RMM;
>>>>>> +		maccfg2 |= MACCFG2_NIBBLE_MODE;
>>>>>>    		break;
>>>>>>    	case PHY_INTERFACE_MODE_RGMII:
>>>>>>    	case PHY_INTERFACE_MODE_RGMII_ID:
>>>>>>    	case PHY_INTERFACE_MODE_RGMII_RXID:
>>>>>>    	case PHY_INTERFACE_MODE_RGMII_TXID:
>>>>>> -		tmp = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>>>>>> +		ecntrl = DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>>>>>> +		maccfg2 |= MACCFG2_BYTE_MODE;
>>>>>>    		break;
>>>>>>    	case PHY_INTERFACE_MODE_SGMII:
>>>>>>    	case PHY_INTERFACE_MODE_1000BASEX:
>>>>>>    	case PHY_INTERFACE_MODE_2500BASEX:
>>>>>> -		tmp = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>>>>>> +		ecntrl = DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>>>>>> +		maccfg2 |= MACCFG2_BYTE_MODE;
>>>>>>    		break;
>>>>>>    	default:
>>>>>>    		dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
>>>>>> @@ -923,7 +929,8 @@ static void dtsec_mac_config(struct phylink_config *config, unsigned int mode,
>>>>>>    		return;
>>>>>>    	}
>>>>>>    
>>>>>> -	iowrite32be(tmp, &regs->ecntrl);
>>>>>> +	iowrite32be(ecntrl, &regs->ecntrl);
>>>>>> +	iowrite32be(maccfg2, &regs->maccfg2);
>>>>>>    }
>>>>>>    
>>>>>>    static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,
>>>>>> @@ -948,15 +955,10 @@ static void dtsec_link_up(struct phylink_config *config, struct phy_device *phy,
>>>>>>    	iowrite32be(tmp, &regs->ecntrl);
>>>>>>    
>>>>>>    	tmp = ioread32be(&regs->maccfg2);
>>>>>> -	tmp &= ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE | MACCFG2_FULL_DUPLEX);
>>>>>> -	if (speed >= SPEED_1000)
>>>>>> -		tmp |= MACCFG2_BYTE_MODE;
>>>>>> -	else
>>>>>> -		tmp |= MACCFG2_NIBBLE_MODE;
>>>>>> -
>>>>>>    	if (duplex == DUPLEX_FULL)
>>>>>>    		tmp |= MACCFG2_FULL_DUPLEX;
>>>>>> -
>>>>>> +	else
>>>>>> +		tmp &= ~MACCFG2_FULL_DUPLEX;
>>>>>
>>>>> Did you test this when forcing 10/100 speed?
>>>>
>>>> No I didn't. Well I can't. I have a very weird board which only
>>>> supports 1000base-X (and copper SFPs in 1000basex autoneg mode). On
>>>> top of that there is a Marvell 88E1112 in between the SFP and the
>>>> MAC, for which the PHY driver is completely broken. Long story
>>>> short, I'm not able to test that (yet/at all? Not sure).
>>> FTR, sashiko suspect this patch will broke such setup:
>>> https://sashiko.dev/#/patchset/20260710143430.2276141-1-mwalle%40kernel.org
>>
>> I've seen that, but.. that was the actual change between v1 and v2
>> as suggested by Sean. It does not depend on the actual link speed,
>> but the maximum link speed. So it is not relevant if the link
>> negotiates to a slower speed or not. At least that now matches the
>> behavior prior to the phylink conversion. If that was working -
>> that I can't tell you.
> 
> I'm sorry, following all cross revision discussion is a bit hard here.
> 
> I don't understand if the 'link never established' is specific of your
> board, or it a constant with this driver. Could you please clarify?

I think we should set byte/nibble mode in link_up as well as mac_config. That
should fix the problem where the link never comes up (possibly broken since
the phylink conversion). I think it's unlikely that this config is supposed
to match the phy interface speed and not the link speed, but you never know...

--Sean
