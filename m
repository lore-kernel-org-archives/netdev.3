Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8D3B2FF8;
	Mon, 31 Aug 2026 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179205; cv=none; b=GtjqJ2+ZDlRh7ZEm8+nu3Lp+X1hhnoeOXk1ywnnrD2lnrxRjKELjBEZy78MBbFoh7u4zhWhbDq+8ZLMe/EBDZ5ehYIVisQd7saimEDQNVX1dHxXD5IZfTKHV6SGKNv6Gpcdm1atbvzbILDA0so26PQ/Ddlx3jxdnpirMeCZBj6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179205; c=relaxed/simple;
	bh=g50xTyETgllwrG9mYQLSwrYP8LHnZFN7SDTKKIzChvc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=bziKVvL+IPmWklBSDCPUu6MH5UP3VIJLpaV+hPL9oDfiDbaw0xVdSPtKaHe8JCXfV73ug7H6epurMtozD4raVQX0CO4z5Jsc/IioOWU1ng+OLJ/UiWU+IoxNPue0vShrW9BE7AaqY66AZcTFUCw4mnV3NlQ9rvu5Ic+Y/6f12AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Qiu1W9Bi; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Qiu1W9Bi"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B3EA7A3C01;
	Mon, 31 Aug 2026 14:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1788179199; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=M8qwEVOrCnuxFS57aOl0YCGu5dSb4p68XufXY5WyeXU=;
	b=Qiu1W9BiZBvUrURamh+SrkfApZPN33wZIgQckXKwFgAz+cttmbo16fspc0Qv2MOv1kI6iG
	J7iNcnYqS7oFa3cyTEWfheR2yuu6GxdoanoLLeS47DgaJx57nnJe1U2DvvzwP3KY4cHisF
	CgcwVr32KXGb6LGT8QQkXw5vFPZVLoWOAyInWC2vRY9+gJwgi3VzgT4a9QyHUFtwUcuOYF
	p60pMClSaYxuBlPDMdwMi6ilGTz328T/pkuEIra4u+qzXw7eaIlRGkX88sVN0svUwy2/aj
	6W7Jse/u71ADqgxVCFTyF3TT/CYb/TR0jxzpktm6eC/Gn3GdrqTk0NN8KpD7Vg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 31 Aug 2026 14:26:36 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 thomas.petazzoni@bootlin.com, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 1/2] net: stmmac: dwmac4: Read the UC filter size
 from hardware capabilities
In-Reply-To: <480f15e2-e045-46b7-89af-1fbcefd3c4eb@bootlin.com>
References: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
 <20260831070121.349778-2-maxime.chevallier@bootlin.com>
 <2631c832d5aebc56e152628132494545@tipi-net.de>
 <480f15e2-e045-46b7-89af-1fbcefd3c4eb@bootlin.com>
Message-ID: <495059f3c43a20a48cc8c0e114ba4cc5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 31.8.2026 14:15, Maxime Chevallier wrote:
> On 8/31/26 14:04, Nicolai Buchwitz wrote:
>> Hi Maxime
>> 
>> On 31.8.2026 09:01, Maxime Chevallier wrote:
>>> dwmac4 has multiple banks of perfect filter entries, independently
>>> configurable during IP integration.
>>> 
>>> The multi_addr bank reports a number between 0 and 31 corresponding 
>>> to
>>> the actual number of entries in that bank, while the 32 and 64 banks
>>> are all-or-nothing.
>>> 
>>> Expose these caps over debugfs as well.
>>> 
>>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>>> ---
>> 
>>> [...]
>> 
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h 
>>> b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
>>> index 6382836828ba..89368e34a388 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
>>> @@ -176,7 +176,9 @@ enum power_event {
>>> 
>>>  /* MAC HW features0 bitmap */
>>>  #define GMAC_HW_FEAT_SAVLANINS        BIT(27)
>>> -#define GMAC_HW_FEAT_ADDMAC        BIT(18)
>>> +#define GMAC_HW_FEAT_MACADR64SEL    BIT(24)
>>> +#define GMAC_HW_FEAT_MACADR32SEL    BIT(23)
>>> +#define GMAC_HW_FEAT_ADDMAC        GENMASK(22, 18)
>>>  #define GMAC_HW_FEAT_RXCOESEL        BIT(16)
>>>  #define GMAC_HW_FEAT_TXCOSEL        BIT(14)
>>>  #define GMAC_HW_FEAT_EEESEL        BIT(13)
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c 
>>> b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>>> index 23ffe1adcd0d..14ac3f0e51f7 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>>> @@ -388,6 +388,8 @@ static int dwmac4_get_hw_feature(void __iomem 
>>> *ioaddr,
>>>      dma_cap->half_duplex = (hw_cap & GMAC_HW_FEAT_HDSEL) >> 2;
>>>      dma_cap->vlhash = (hw_cap & GMAC_HW_FEAT_VLHASH) >> 4;
>>>      dma_cap->multi_addr = (hw_cap & GMAC_HW_FEAT_ADDMAC) >> 18;
>> 
>> Now that ADDMAC has grown from single bit to a mask, the hardcoded 18 
>> has to match
>> dwmac4.h. So IMHO it would make sense to use FIELD_GET() here (like 
>> actphyif)?
> 
> It's hardcoded all over, if you look at how all the other fields from 
> the features
> are read. I can change it if you really think it's worth, however I'd 
> rather
> do a proper cleanup of how all the properties are read at once :)

Perfectly fine for me. Ran into a similar, but unrelated issue recently, 
so I just
wanted to flag it (for the future) :)

> 
>> 
>>> +    dma_cap->additional_32_addr = (hw_cap & 
>>> GMAC_HW_FEAT_MACADR32SEL) >> 23;
>>> +    dma_cap->additional_64_addr = (hw_cap & 
>>> GMAC_HW_FEAT_MACADR64SEL) >> 24;
>>>      dma_cap->pcs = (hw_cap & GMAC_HW_FEAT_PCSSEL) >> 3;
>>>      dma_cap->sma_mdio = (hw_cap & GMAC_HW_FEAT_SMASEL) >> 5;
>>>      dma_cap->pmt_remote_wake_up = (hw_cap & GMAC_HW_FEAT_RWKSEL) >> 
>>> 6;
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c 
>>> b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index f2fc89176654..a885f8cfef21 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -6580,6 +6580,18 @@ static int stmmac_dma_cap_show(struct seq_file 
>>> *seq, void *v)
>>>          seq_printf(seq,
>>>                 "\tNumber of Additional MAC address registers: %d\n",
>>>                 priv->dma_cap.multi_addr);
>>> +    } else if (priv->plat->core_type == DWMAC_CORE_GMAC4) {
>>> +        seq_printf(seq,
>>> +               "\tNumber of MAC address registers (1-31): %d\n",
>>> +               priv->dma_cap.multi_addr);
>>> +        seq_printf(seq,
>>> +               "\tAdditional 32 MAC address registers (32-63): 
>>> %s\n",
>>> +               priv->dma_cap.additional_32_addr ? "Y" : "N");
>>> +        seq_printf(seq,
>>> +               "\tAdditional 64 MAC address registers (64-127): 
>>> %s\n",
>>> +               priv->dma_cap.additional_64_addr ? "Y" : "N");
>>> +        seq_printf(seq, "\tHash Filter: %s\n",
>>> +               (priv->dma_cap.hash_filter) ? "Y" : "N");
>> 
>> hash_filter seems to be only set in dwmac1000_dma.c? So on dwmac4 it 
>> would always print N?
> 
> Yeah but dwmac4 has a hash filter, but same as the UC filter it's just 
> not plumbed
> in :/
> 
> Let's leave this flag here, hash filter addition for MC filtering is 
> coming-up, so let's not
> drop it now only to re-enable it after, one of the other wonderful 
> discoveries found by
> running the selftests...

Also fine with me.

> 
>> 
>>>      } else {
>>>          seq_printf(seq, "\tHash Filter: %s\n",
>>>                 (priv->dma_cap.hash_filter) ? "Y" : "N");
>> 
>> Thanks,
>> Nicolai
> 
> Maxime

With both comments addressed and agreed to keep it as is until a cleanup 
in the future:

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
