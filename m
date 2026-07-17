Received: from shout01.mail.de (shout01.mail.de [62.201.172.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852F175A5
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327009; cv=none; b=fHjqbgY0Y49kFFsamxEm1pfrtE3EEayhpCB+SJ1J9NGT2U2HGTSf9tL8YCcFDUiAAu7lL6QScTNsnLpX0jW9Mmn3O1ZNtWhx5cbeIGXUy57b2TMAzcWF/Mf+ryyja1PiqTeaoUq324c67W7mfSv3fDtauv47TFzPMkA+19MOo14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327009; c=relaxed/simple;
	bh=f/oHtAt/y3/iqCjQpthBZ+aHUL63qReO3B6X+T0FTvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mjFrTJj76X8EiTVjsXA50RUeb5ENXcFrPz7bf56Q/m8ltc+WhhEkvYWekZoJhgMGpJWTNo6HOWZwhFJPNXvQzs/n7W+1Pjp9yFHqTMWQqIXeRoRb5n6210Or48xt7OQY4iq2zAFewfJO57egD5w6RIQhi4CEDR1V9iLbwqRZBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=Jg8qXnIO; arc=none smtp.client-ip=62.201.172.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="Jg8qXnIO"
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout01.mail.de (Postfix) with ESMTP id 439EE240764;
	Sat, 18 Jul 2026 00:23:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1784327006;
	bh=f/oHtAt/y3/iqCjQpthBZ+aHUL63qReO3B6X+T0FTvs=;
	h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
	b=Jg8qXnIOOCsw4ccZVBvZtBOaXrcaYyNaRPCP0fMLqxnc9vBhNG46kHHwI97ul4aAp
	 WELqnG10U/Q3YlUHN2dmUlytABCtM2T8X9AkvMD5yACCT+N8iWoRw7jfmChKv8Yeqd
	 qPZk2vA+JPwa//7DTzAIT/6EBwRT5lRvMmt0PCvJpFZPzsDHzcgWxkomfn99amlOgg
	 fNHpOxPRiybg2D1WQulIJyKyhc/AE4xDg5FDRdxOSISXSvSqlwTU39xrNnC6bEKeLl
	 EZRLOLT8zqJLkTc7DztIv0fO0ZxC2trnHHzURpzKVwfguZd6vqtGY/CLX47ylmPQKZ
	 Gash1H/E4SHug==
Received: from smtp01.mail.de (smtp03.bt.mail.de [10.0.121.213])
	by postfix02.mail.de (Postfix) with ESMTP id 20DA32400F2;
	Sat, 18 Jul 2026 00:23:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 6E45724064F;
	Sat, 18 Jul 2026 00:23:24 +0200 (CEST)
Message-ID: <8f6aca6d-6619-401c-bed7-8d42732d166a@mail.de>
Date: Sat, 18 Jul 2026 00:23:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
 rmk+kernel@armlinux.org.uk, kuba@kernel.org,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
 <72b91ec7-202c-4301-bcd8-b818cf8d72a0@mail.de>
 <21068662-c44b-4266-b634-24e5eac8cd96@lunn.ch>
Content-Language: en-US
From: tresonic <tresonic@mail.de>
In-Reply-To: <21068662-c44b-4266-b634-24e5eac8cd96@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2800
X-purgate-ID: 154282::1784327006-0EEE8C36-780B7890/0/0

On 7/17/26 5:40 PM, Andrew Lunn wrote:
>> I tested the changes as you suggested and it seems DMA_CHAN_INTR_ENA_RPS in DMA_CHAN_INTR_ABNORMAL_4_10 broke it.
>> With this change on master suspend is working:
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
>> index 43b036d4e95b..e907142c9ee2 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
>> @@ -121,7 +121,6 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
>>                                          DMA_CHAN_INTR_ENA_TIE)
>>  
>>  #define DMA_CHAN_INTR_ABNORMAL_4_10    (DMA_CHAN_INTR_ENA_AIE_4_10 | \
>> -                                        DMA_CHAN_INTR_ENA_RPS | \
>>                                          DMA_CHAN_INTR_ENA_RBU | \
>>                                          DMA_CHAN_INTR_ENA_FBE)
>>  /* DMA default interrupt mask for 4.10a */
> 
> OK, that narrows it down a bit.
> 
> I made the guess it is an interrupt storm during suspend, because
> interrupts are not disabled. DMA_CHAN_INTR_ABNORMAL_4_10 is written to
> hardware in dwmac410_dma_init_channel(). However, i don't see anywhere
> these interrupts are clear? struct stmmac_dma_ops has an init_chan
> operation, but there is no opposite operation to reset a channel?
> There is however disable_dma_irq. Maybe DMA_CHAN_INTR_ENA_RPS can be
> cleared there?
> 
> But i'm also having trouble finding where dwmac4_disable_dma_irq() is
> actually called. It is called from stmmac_disable_rx_queue() and
> stmmac_disable_tx_queue() but they only seem to be used in the XDP
> code.
> 
> Are the DMAs being stopped during suspend? I don't know this driver
> well enough to answer that.
> 
> Can you scatter some printk() around and see what actually happens on
> suspend. See if you can find somewhere to disable that one interrupt?
> 
> 	 Andrew
It seems your assumptions are correct. If i do

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index a0249715fafa..487efc746b20 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -129,6 +129,8 @@ void dwmac4_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
        const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
        u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 
+       value &= ~DMA_CHAN_INTR_ENA_RPS;
+
        if (rx)
                value &= ~DMA_CHAN_INTR_ENA_RIE;
        if (tx)

I can suspend and resume!
Could it be sufficient to just do this and reenable on dwmac4_enable_dma_irq?

tresonic
