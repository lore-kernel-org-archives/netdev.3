Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1752EBB8D
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178520; cv=none; b=pxSwb2DxqJ5kDMI6Acu8j+0hMKz0PkHxz0UYtIEsqfRVeofzn4+QfdKwOH+CfIBVT1zUhEM/h/mhC38ygGgIWITxpmOJrTo1G9Zf6+HTSjvs2Noj7J1pl6y47Cq5u8ESeOGbzSjF89z/QPUkNS0+EvzYkY0mH/7uhEaoOmZFq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178520; c=relaxed/simple;
	bh=LxUt+CnyDWGDMtzxg5Cjeq/z3ZUGbAwQZvmAAhj5b1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ma2y4aNIjoWziJbBleRfCE1QQrWvYKROPx3eUHEYn1NpNm16DFj7RroYjPB4pQMJmzVvDfpDcYfWdZ51eF/qtfSG5hpjzjx1y+5+zcSbl+PjjLPq51jVUiK6K1iaENnfQOcgLLNEsXvgzBuhoH2hr2nlgGzco3Jt+ZbIfLsIqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=x8s3e4Cn; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="x8s3e4Cn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 04FF54E41491;
	Mon, 31 Aug 2026 12:15:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CBC2F60231;
	Mon, 31 Aug 2026 12:15:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB42B11C78B4C;
	Mon, 31 Aug 2026 14:15:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788178509; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=MKHpfG9FXZBRRV2MzUmsKoBDMrVngBIFiVIQAk/+QT4=;
	b=x8s3e4Cn2x+dOCKmc9hckekz+B0vlGLGChkHD95QauWurwh9rKYWr7JDXVdiLJVK4PwPcd
	3WcNFco7+jtDi3/5GhWMW0/GFw6A6U/BCY4SR2MKIwNypKR/MDZw8DI54tdwiznnuETGWt
	ldX3FC3niPA4g3xlFrgTkf3mOlYknS2lYYJRyK34uk2+xY+A2uR5uWDmj/Kn9Iq9AP9bRx
	9hxwqEpIoTsKMHtXlE0vU8rK8/OIcf23jjAoBvJ2zSVzx7SgYn+wTpx6yJ6WzWMdRmSDSJ
	EXB8hFmiy5SG7KKp6qnIHuqMEW+oTxirjDua4lzhoknscg1f56bmGy3GNAopkA==
Message-ID: <480f15e2-e045-46b7-89af-1fbcefd3c4eb@bootlin.com>
Date: Mon, 31 Aug 2026 14:15:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: stmmac: dwmac4: Read the UC filter size
 from hardware capabilities
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
 <20260831070121.349778-2-maxime.chevallier@bootlin.com>
 <2631c832d5aebc56e152628132494545@tipi-net.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <2631c832d5aebc56e152628132494545@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 8/31/26 14:04, Nicolai Buchwitz wrote:
> Hi Maxime
> 
> On 31.8.2026 09:01, Maxime Chevallier wrote:
>> dwmac4 has multiple banks of perfect filter entries, independently
>> configurable during IP integration.
>>
>> The multi_addr bank reports a number between 0 and 31 corresponding to
>> the actual number of entries in that bank, while the 32 and 64 banks
>> are all-or-nothing.
>>
>> Expose these caps over debugfs as well.
>>
>> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>> ---
> 
>> [...]
> 
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
>> index 6382836828ba..89368e34a388 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
>> @@ -176,7 +176,9 @@ enum power_event {
>>
>>  /* MAC HW features0 bitmap */
>>  #define GMAC_HW_FEAT_SAVLANINS        BIT(27)
>> -#define GMAC_HW_FEAT_ADDMAC        BIT(18)
>> +#define GMAC_HW_FEAT_MACADR64SEL    BIT(24)
>> +#define GMAC_HW_FEAT_MACADR32SEL    BIT(23)
>> +#define GMAC_HW_FEAT_ADDMAC        GENMASK(22, 18)
>>  #define GMAC_HW_FEAT_RXCOESEL        BIT(16)
>>  #define GMAC_HW_FEAT_TXCOSEL        BIT(14)
>>  #define GMAC_HW_FEAT_EEESEL        BIT(13)
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>> index 23ffe1adcd0d..14ac3f0e51f7 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
>> @@ -388,6 +388,8 @@ static int dwmac4_get_hw_feature(void __iomem *ioaddr,
>>      dma_cap->half_duplex = (hw_cap & GMAC_HW_FEAT_HDSEL) >> 2;
>>      dma_cap->vlhash = (hw_cap & GMAC_HW_FEAT_VLHASH) >> 4;
>>      dma_cap->multi_addr = (hw_cap & GMAC_HW_FEAT_ADDMAC) >> 18;
> 
> Now that ADDMAC has grown from single bit to a mask, the hardcoded 18 has to match
> dwmac4.h. So IMHO it would make sense to use FIELD_GET() here (like actphyif)?

It's hardcoded all over, if you look at how all the other fields from the features
are read. I can change it if you really think it's worth, however I'd rather
do a proper cleanup of how all the properties are read at once :)

> 
>> +    dma_cap->additional_32_addr = (hw_cap & GMAC_HW_FEAT_MACADR32SEL) >> 23;
>> +    dma_cap->additional_64_addr = (hw_cap & GMAC_HW_FEAT_MACADR64SEL) >> 24;
>>      dma_cap->pcs = (hw_cap & GMAC_HW_FEAT_PCSSEL) >> 3;
>>      dma_cap->sma_mdio = (hw_cap & GMAC_HW_FEAT_SMASEL) >> 5;
>>      dma_cap->pmt_remote_wake_up = (hw_cap & GMAC_HW_FEAT_RWKSEL) >> 6;
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index f2fc89176654..a885f8cfef21 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -6580,6 +6580,18 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
>>          seq_printf(seq,
>>                 "\tNumber of Additional MAC address registers: %d\n",
>>                 priv->dma_cap.multi_addr);
>> +    } else if (priv->plat->core_type == DWMAC_CORE_GMAC4) {
>> +        seq_printf(seq,
>> +               "\tNumber of MAC address registers (1-31): %d\n",
>> +               priv->dma_cap.multi_addr);
>> +        seq_printf(seq,
>> +               "\tAdditional 32 MAC address registers (32-63): %s\n",
>> +               priv->dma_cap.additional_32_addr ? "Y" : "N");
>> +        seq_printf(seq,
>> +               "\tAdditional 64 MAC address registers (64-127): %s\n",
>> +               priv->dma_cap.additional_64_addr ? "Y" : "N");
>> +        seq_printf(seq, "\tHash Filter: %s\n",
>> +               (priv->dma_cap.hash_filter) ? "Y" : "N");
> 
> hash_filter seems to be only set in dwmac1000_dma.c? So on dwmac4 it would always print N?

Yeah but dwmac4 has a hash filter, but same as the UC filter it's just not plumbed
in :/

Let's leave this flag here, hash filter addition for MC filtering is coming-up, so let's not
drop it now only to re-enable it after, one of the other wonderful discoveries found by
running the selftests...

> 
>>      } else {
>>          seq_printf(seq, "\tHash Filter: %s\n",
>>                 (priv->dma_cap.hash_filter) ? "Y" : "N");
> 
> Thanks,
> Nicolai

Maxime
