Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74730F548
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538032; cv=none; b=YWr0YBkAnEWQ13w9CF9GGkwhu3ja1YH3G7A9d0HIgDUuJnkxR2SdnJI10TRGEuK22qvU8ivFY2SfqH+tql5Wji3Jkt2rYAGCr6NGk2ynWPIPNHa68fCOEImjYOUcFi4u/2qUG/JG4aikE+KaZXEETPgK1Zdkg7ALW9k6/8+iltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538032; c=relaxed/simple;
	bh=OS/a1VJZjiXsl1cXke3UKUtE1VRudfo3qYuC4AcwSIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfhwkntoQ0EG0AeeLrqMv4GD6VxivGKMgEjW0gHfQ3cohfTug2dpPRHFAGNM7rlnMlxw+AhdyKvrR8TmyfVLsj5sU3gqERS2mnhDQVw+eEFNRgUrAh25sviE8zGEbYOR0VY3sm8RSx6T16Gz90QGFYzQP3UpSSrUEOO+1nhsD5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qWEyFnhK; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qWEyFnhK"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 086EA1A15A0;
	Wed, 12 Aug 2026 12:33:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CF9026045E;
	Wed, 12 Aug 2026 12:33:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B23111C48F6F;
	Wed, 12 Aug 2026 14:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786538020; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ky4ujpdFUrBoeVyTnNyym1tbNd1LG9e7N6vAuh+mNkM=;
	b=qWEyFnhKGgeFpd626FTrych5MuMWMPuEtLRsuzVYDBm2f8PyE1UORGE1TD1swuHzEaMfZk
	/cOiG4PQYQ4t8iImsjHDd2vX/VgwFl9NYwKep/4Zbz6+1xBu2YIHNJeI/x2Co7Kouxb1d4
	qNRvw0HDWyWgWBF1TFi9/EDGNRxCDcIHLgQ6M1zISoRA+N06/Mwfw5rprEpU4Db4nz1YG4
	Qk7uqdNUABQx7LSn5gqvkinraledsjT2F66hMvAWK7HZMU1VhiX2RUCNmodbfBgzYDqYvC
	xCSUc7eUmZovR/rB52N4N14bWSAb7nxPK8vnlJczsNyVMWXuboS633vUd2d8fw==
Message-ID: <a15dda96-9a91-4055-b394-618ebd99b4df@bootlin.com>
Date: Wed, 12 Aug 2026 14:33:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: use dma_addr_t for DMA addresses
To: Alex Elder <elder@riscstar.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260811192703.1765416-1-elder@riscstar.com>
 <65494f6d-50fe-4bdb-98d9-7150d9a4fc91@bootlin.com>
 <72848f5d-768a-4d06-82d1-1168cae8c5b6@riscstar.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <72848f5d-768a-4d06-82d1-1168cae8c5b6@riscstar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/12/26 14:25, Alex Elder wrote:
> On 8/12/26 2:23 AM, Maxime Chevallier wrote:
>> Hi Alex,
>>
>> On 8/11/26 21:27, Alex Elder wrote:
>>> In jumbo_frm() (implemented in both "chain_mode.c" and "ring_mode.c"),
>>> an unsigned integer local variable is used to hold the value returned
>>> by dma_map_single().  On systems where a dma_addr_t is 64 bits, the
>>> subsequent dma_mapping_error() check of the returned value operates
>>> only on the low 32 bits (whose high bit won't be sign-extended).  In
>>> this case, dma_mapping_error() would return 0 (no error) even if there
>>> were one.
>>>
>>> Fix this in both spots by using a dma_addr_t for the local variable.
>>
>> Thanks :)
>>
>> I was wondering if it would silently hides another address size related
>> issue a little bit lower, as we now have :
>>
>>    dma_addr_t des2;
>>
>>    des2 = dma_map_single(...);
>>
>>    desc->des2 = cpu_to_le32(des2);
>>
>> desc->des2 is __le32, so for 64 bit addresses we silently truncate the
>> address.
> 
> I saw that too.  Everything is unsigned, and only the lower
> 32 bits will be used, but I'd rather see the dma_addr_t
> explicitly converted to u32 before being passed to cpu_to_le32().
> This should work regardless of the size of dma_addr_t:
> 
>     desc->des2 = cpu_to_le32(lower_32_bits(des2));

Fine by me, if you add that in V2 feel free to keep my review tag :)

Maxime

> 
> I didn't look, but there could be other places where this occurs.
> Tell me if you'd like me to send another patch that does this
> (here and in any other spots I find.)
>> However I don't see how jumbo would work on 64-bits anyways as des3 is the next
>> chunk of the jumbo frame...
>>
>> I think this is good as-is, so
>>
>> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Thank you.
> 
>                     -Alex
> 
>> Maxime
>>
>>>
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Link: https://lore.kernel.org/linux-devicetree/20260606010122.21A211F00899@smtp.kernel.org/
>>> Signed-off-by: Alex Elder <elder@riscstar.com>
>>> ---
>>>   drivers/net/ethernet/stmicro/stmmac/chain_mode.c | 3 ++-
>>>   drivers/net/ethernet/stmicro/stmmac/ring_mode.c  | 3 ++-
>>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
>>> index fc04a23342cfc..ec25193d287bb 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
>>> @@ -20,9 +20,10 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>>>       unsigned int nopaged_len = skb_headlen(skb);
>>>       struct stmmac_priv *priv = tx_q->priv_data;
>>>       unsigned int entry = tx_q->cur_tx;
>>> -    unsigned int bmax, buf_len, des2;
>>> +    unsigned int bmax, buf_len;
>>>       unsigned int i = 1, len;
>>>       struct dma_desc *desc;
>>> +    dma_addr_t des2;
>>>         desc = tx_q->dma_tx + entry;
>>>   diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
>>> index 78fc6aa5bbe95..664d8cfb58cdc 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
>>> @@ -20,8 +20,9 @@ static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
>>>       unsigned int nopaged_len = skb_headlen(skb);
>>>       struct stmmac_priv *priv = tx_q->priv_data;
>>>       unsigned int entry = tx_q->cur_tx;
>>> -    unsigned int bmax, len, des2;
>>> +    unsigned int bmax, len;
>>>       struct dma_desc *desc;
>>> +    dma_addr_t des2;
>>>         if (priv->extend_desc)
>>>           desc = (struct dma_desc *)(tx_q->dma_etx + entry);
>>>
>>> base-commit: 31397cf1819210bd63fa3d2c7d8c24f7c8667d99
>>
> 

