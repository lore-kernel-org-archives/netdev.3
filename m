Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5F3E95AB
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537525; cv=none; b=fNsz/NBdIU26eijb49WyqBQ7jEHvktl9I/yjcNoXchshKCovYVMNMoSYJ7ueI034p6WytjAulvF6J0Ef7ErunrlxZcvRhQo6CTAg9Utjg7r/rP2tMRPTyuluJcrkhf8HZI99Gj/FkYL1ItS29WjSiC53YLERTcDyZX+0ZdUOjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537525; c=relaxed/simple;
	bh=jQR0L8oGkvyT5FyhTV3i9J+AfBUo6dnE8gSuD/hs6Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CkUyE8+CgvplE9r3PnWYXL+EIuX0Uuv3nkCWG/b+PVfhUn/V7n5cdumeP1yizzA+fXr/2x0VRGSS6Ikbv9Ispn1tTjjFD/OHn535o2P3DIg/oCpFWLW4BAs0lA76pmBfoLd0dpm2Ft4rGBxymiEP7Jv9Clp4gno4a0tc8R3Vq2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Kp88jdaF; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Kp88jdaF"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c04bf4711so9455931cf.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786537523; x=1787142323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Djp33DZuJ5kk88PXRco/OjHqQCYStiOV5FS5/ccjyz4=;
        b=Kp88jdaF7KtGyR0MBNaeh5USiNRL9NDulcayFoBoA3e/vhGb4hW00F0nApw+aA6hbn
         gAOX+jf2qJ5uHhonKY0Vtc9TGnoQiid4ueuLLOS2kRfhBeDf7GFZwdFX53X27L8q8Zdd
         Fj3gthJ+f5r68xJ1jagLAYr3t/MlPGJFZsFVnOpxTJGkjHuK2pDYKq9MU0doMcLPEkM3
         pwC2KCdoJ4WZKkXhk8d2xcKNmLtqGf3yeyAeM1zDwY7jz+MUxr1NfxDZMGuQ+DUxKOsS
         ZIQ0KDoljOn2mm5ZKwbqn4El4zt0ibnh0s340gErbec9+ySMt45vMR0LOfgcg2sCLch6
         X7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537523; x=1787142323;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Djp33DZuJ5kk88PXRco/OjHqQCYStiOV5FS5/ccjyz4=;
        b=L6yLIAdH5JlMOv+fSwEfZtnuiGCMLNxYF3o55ZzwqKGlLpAvn+YIvE6cuwVwTXKGzt
         J4XS7TGShC9L5UHuC32hHR5Spi3fd1y5eap1R714PiWNoWOYc8fcb5KRuo9CRYjWWMNH
         0XS0D8qQLOa2uUA57B+kMi8RHfUtDwS5h9N8FtzMTr1ABmQZMoYs1LHwxs1FatlLbCqY
         GOYemzeRddLSQetrXYEnGT3oiQP4PosBjMN9fZCnstPKGOVkN2AURIsCuzNEYz8RGV/m
         eAc1no4I2MZtGWtFBGHYFgKn30J6Hzl7NFOlHx7M0BRGYhAGoazfbxpaWExdHcPPdQkd
         QXbA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0XT7AwUVkiggdQ4cLoL5Iy+uF8FjBiduQP01fOr1i3ltNic3ZgL+5t5Vl/6471gT5sTtFh6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4SAPSJg2f3qnpBJ65/690Z2pZh5gtLcXljtnjj424V6Hcnxa9
	AdhQ+ly7QQsNW851uMWn2fVmOw5biWRGGzCBpwafendnQbOIDfcTUu3ftpHyXwSx+XI=
X-Gm-Gg: AR+sD10xX2UyoVMLlGuzZQ1YSepbj0h6hr8FqGH/Hsf+P+NYLeoC07bgpcFQrK01Gpk
	ghBLO+sWoVJqaCGX532lY40Lf56tWsC0/Dv6bFGjgxpKCT477MyuEww+jmZvasLi7Aq9cYOnUOD
	uvhrBGvVnlYAby1/67u7ZAKSTaq3Kf1eV1HSeydL8PF856AunRiEpXSsAqcV3tBKkMIpv3xvoKx
	JMbc2ueMg6YOfmw8G22Wmx6cOFI7qIS9glU5P7T0bFs77WeEHDxHf09gMbxPYmLokJJPkaAKyJe
	/9qreNaiaPWL01lF9pmo8S/sabGNZ1F4e6WUA3Jvz/+jnzYaCXaEkIrQo5AphqNLD41vL+2bOyU
	HNOBKKVL+pPMeJCQrxKh5YnbjlsZlqSzel9TQVszw2enTwt6hCrEXO4TbzbwhcuIKC68wB1F046
	h1+LXNG0GraB8Q4pg2r5sw8igev3Rp0Nb8Z2ksR4TI9KdTG8O6dMh/XWzEvnkL
X-Received: by 2002:a05:622a:83:b0:517:8d24:64d8 with SMTP id d75a77b69052e-52d646edbedmr31554961cf.13.1786537522952;
        Wed, 12 Aug 2026 05:25:22 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d61dc9245sm16460631cf.25.2026.08.12.05.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 05:25:22 -0700 (PDT)
Message-ID: <72848f5d-768a-4d06-82d1-1168cae8c5b6@riscstar.com>
Date: Wed, 12 Aug 2026 07:25:21 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: use dma_addr_t for DMA addresses
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260811192703.1765416-1-elder@riscstar.com>
 <65494f6d-50fe-4bdb-98d9-7150d9a4fc91@bootlin.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <65494f6d-50fe-4bdb-98d9-7150d9a4fc91@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/12/26 2:23 AM, Maxime Chevallier wrote:
> Hi Alex,
> 
> On 8/11/26 21:27, Alex Elder wrote:
>> In jumbo_frm() (implemented in both "chain_mode.c" and "ring_mode.c"),
>> an unsigned integer local variable is used to hold the value returned
>> by dma_map_single().  On systems where a dma_addr_t is 64 bits, the
>> subsequent dma_mapping_error() check of the returned value operates
>> only on the low 32 bits (whose high bit won't be sign-extended).  In
>> this case, dma_mapping_error() would return 0 (no error) even if there
>> were one.
>>
>> Fix this in both spots by using a dma_addr_t for the local variable.
> 
> Thanks :)
> 
> I was wondering if it would silently hides another address size related
> issue a little bit lower, as we now have :
> 
>    dma_addr_t des2;
> 
>    des2 = dma_map_single(...);
> 
>    desc->des2 = cpu_to_le32(des2);
> 
> desc->des2 is __le32, so for 64 bit addresses we silently truncate the
> address.

I saw that too.  Everything is unsigned, and only the lower
32 bits will be used, but I'd rather see the dma_addr_t
explicitly converted to u32 before being passed to cpu_to_le32().
This should work regardless of the size of dma_addr_t:

	desc->des2 = cpu_to_le32(lower_32_bits(des2));

I didn't look, but there could be other places where this occurs.
Tell me if you'd like me to send another patch that does this
(here and in any other spots I find.)
> However I don't see how jumbo would work on 64-bits anyways as des3 is the next
> chunk of the jumbo frame...
> 
> I think this is good as-is, so
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thank you.

					-Alex

> Maxime
> 
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Link: https://lore.kernel.org/linux-devicetree/20260606010122.21A211F00899@smtp.kernel.org/
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/chain_mode.c | 3 ++-
>>   drivers/net/ethernet/stmicro/stmmac/ring_mode.c  | 3 ++-
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
>> index fc04a23342cfc..ec25193d287bb 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
>> @@ -20,9 +20,10 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>>   	unsigned int nopaged_len = skb_headlen(skb);
>>   	struct stmmac_priv *priv = tx_q->priv_data;
>>   	unsigned int entry = tx_q->cur_tx;
>> -	unsigned int bmax, buf_len, des2;
>> +	unsigned int bmax, buf_len;
>>   	unsigned int i = 1, len;
>>   	struct dma_desc *desc;
>> +	dma_addr_t des2;
>>   
>>   	desc = tx_q->dma_tx + entry;
>>   
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
>> index 78fc6aa5bbe95..664d8cfb58cdc 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
>> @@ -20,8 +20,9 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>>   	unsigned int nopaged_len = skb_headlen(skb);
>>   	struct stmmac_priv *priv = tx_q->priv_data;
>>   	unsigned int entry = tx_q->cur_tx;
>> -	unsigned int bmax, len, des2;
>> +	unsigned int bmax, len;
>>   	struct dma_desc *desc;
>> +	dma_addr_t des2;
>>   
>>   	if (priv->extend_desc)
>>   		desc = (struct dma_desc *)(tx_q->dma_etx + entry);
>>
>> base-commit: 31397cf1819210bd63fa3d2c7d8c24f7c8667d99
> 

