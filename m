Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2752397E9A
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632610; cv=none; b=oYWQBgO8wBbZy8wngtix0+MQKBBIrDEvwWuJwsxvaeOGyR3NQrIRJjn2/lQJIK0LkY6+asH+vUInRM3V6Duw/gcl4bhycj4jZ+yN+jJPHg8a2GoZQnbEz8KUiO3j3vJhJ5VTAVi6rc68GdybIKfq0VyFi87kzBHasabEAsfr2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632610; c=relaxed/simple;
	bh=0SQHCz9X6Ktmc5E1mSbfi3WO/dnU0X7emYSvL0OHUxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DukliJnSUvh+gBS1ZfOYh22051JsONGmQtn30YUVPjE+vGdaWb/JR/UvQvRJNpr+r57npyAhT1TvO73Go3y9tfwyM1D2/gEXQ8EPYX6M9euebk/sZOa6FUnAgtKFnTDzPHsUOUyY19g+r/CfP/LI43u0KGSXyDF4vQtffSEAcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fEYNUORw; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fEYNUORw"
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-6b1b766bf01so79514eaf.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790632603; x=1791237403;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=31LnXNpedys/1BrWFIRmbLYL9goxpyg8z+C/5if56BE=;
        b=zkPJ7ejZveQmI8W51p4WudkLHgXf6Yw+yD5SXgFbwO7ZwAOWRQOB00TcMm6ldcgIJy
         7utG5nT+nYVsqZWk3y/6eO85DWdHrgoi/KtE1I+AMevKtPtWkjwkgscwOnmfP3xHeVRa
         SqmdV6/ipIQ0X/MHsEAuiHs639RTSKdcvT0T/x2s0OR5HkxyuAGn9qAKSYXtcqr+JgGH
         UJPnwfkhfCuSWeiV1ZdibtLqDh9WSkR2UFlMLHueXFWhM5lnB97mLvcyapTWSpm3eMuw
         o4Utupf1XQJeisWuPwCvBJHa2g4/XzhuTyGkcw1T5kGjdANUzlXAnrczi/ZQMwFlO/LV
         ysVQ==
X-Gm-Message-State: AFuF++k+pp3K2GZldZlY23cO7X0u4MUucMuP0adKRL+FcPKs5FG33wJV
	ikJPug8SfldtYBMVIzcn2Uij5T5MBuF62R8k4QkoDYWmv9B2wAU+xgowhFUlM3q1d8/WyzRzjeS
	2KeUfQQHsVxd/lRBYHfwb1diwERddQL3ewXNf/18Tq6LK9nrfup6UMp4RHsD8lRFYk6J8y74BUg
	QAnNcueUW28W4ZtXMBa6Xzy1Ph5wBTtjYMVCgwPG/9AwsKnfhXO3CslduPtgs74i932UJeSiHE4
	rFnR8dELA==
X-Gm-Gg: AYBFou26oHRme1Cc7jtWdfHxNQiSUlh0+5ki4cDhaQvHwKr+p6aItarlTt5ZY8haNWF
	a4lpeV1PV8c7HB+r6fa77dtwxwKSptoJaxZsZjfhrqrE5vBTq6uUgB1Idnq6ssSpddzjlYbzBMB
	pag/U3pR9hWbtnh5EdMeihG2KpD4l2gUmjitc1L6Wmn2MD1yf7iLZ7MB8SJsKaXWpz2Z6TWE9i2
	/MRfYo5D/LELoBH6Uw4yRzTmB/EzYLEPsTepM1yQnhN/WTaukssFoAwHkzsYV1SA9WbIsWBBq4Q
	sWHKkAuecW+ikBNTnpo+rbYHUTt4kpohVpMx68/TdXVgkogqjE6LTmLVPXp/nnCJyUJ+csDnKtn
	orvnNUBIPXo8vV3/pT/6WsQSn1WUgxdZtCJnzXwVyzfj0wvMDAt5tIN+ZhJINUgsoztusBTSMQV
	rcc8DKiB/LqbQHK1ZXEHMYOPPD8/2EOS3Rr4Zs
X-Received: by 2002:a05:6820:1ca3:b0:6d9:ec:235b with SMTP id 006d021491bc7-6d900fb69dbmr3349666eaf.67.1790632602635;
        Mon, 28 Sep 2026 14:56:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-81d58a13607sm830900a34.7.2026.09.28.14.56.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 14:56:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-349ffa249bdso2024618eec.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 14:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790632601; x=1791237401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=31LnXNpedys/1BrWFIRmbLYL9goxpyg8z+C/5if56BE=;
        b=fEYNUORwZMNOV771esXbEv6DRPRkwAmw5AP1eEEptUZsYqw6jbZN9K6fqQSSjURAkF
         55sZ329XWczoBkFxOrO1FuwBn2FIXRxz4guYOf7jFbdGwrjHdDo2AeJVXHqbMBcwGyxq
         iixI6y+YxRLjNfK8ZoonX5ocXLs1xb/2tX5rs=
X-Received: by 2002:a05:693c:881c:20b0:341:6552:8c3b with SMTP id 5a478bee46e88-343c025e6f8mr7904691eec.30.1790632600830;
        Mon, 28 Sep 2026 14:56:40 -0700 (PDT)
X-Received: by 2002:a05:693c:881c:20b0:341:6552:8c3b with SMTP id 5a478bee46e88-343c025e6f8mr7904663eec.30.1790632600141;
        Mon, 28 Sep 2026 14:56:40 -0700 (PDT)
Received: from [10.14.4.122] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-343580930e2sm21272897eec.16.2026.09.28.14.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 14:56:39 -0700 (PDT)
Message-ID: <bbbb6f23-44b6-4794-8bc4-6de58c7fb191@broadcom.com>
Date: Mon, 28 Sep 2026 14:56:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmasp: fix lost TX wakeup race with lockless
 queue API
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, florian.fainelli@broadcom.com
References: <20260928201816.3935530-1-justin.chen@broadcom.com>
 <a65f6e3445b1ea32becb8d974bc147ad@tipi-net.de>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <a65f6e3445b1ea32becb8d974bc147ad@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 9/28/26 2:35 PM, Nicolai Buchwitz wrote:
> Hi Justin
> 
> On 28.9.2026 22:18, justin.chen@broadcom.com wrote:
>> From: Justin Chen <justin.chen@broadcom.com>
>>
>> netif_stop_queue() in bcmasp_xmit() raced with netif_wake_queue() in
>> bcmasp_tx_poll(): a reclaim landing between the ring-full check and
>> the stop call left the queue stopped despite free descriptors,
>> hanging TX until timeout.
>>
>> Switch to netif_txq_maybe_stop()/netif_txq_completed_wake() (the
>> lockless TX queue API, which also brings in BQL), replace
>> tx_spb_ring_full() with a live bcmasp_tx_avail() count.
>>
>> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet 
>> controller")
>> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
>> Assisted-by: Claude:claude-sonnet-5
>> ---
>>  .../net/ethernet/broadcom/asp2/bcmasp_intf.c  | 68 +++++++++++--------
> 
>> [...]
> 
>>  static struct sk_buff *bcmasp_csum_offload(struct net_device *dev,
>> @@ -241,16 +239,18 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff 
>> *skb, struct net_device *dev)
>>      struct bcmasp_tx_cb *txcb;
>>      dma_addr_t mapping, valid;
>>      struct bcmasp_desc *desc;
>> +    struct netdev_queue *txq;
>>      bool csum_hw = false;
>>      struct device *kdev;
>>      skb_frag_t *frag;
>>
>>      kdev = &intf->parent->pdev->dev;
>> +    txq = netdev_get_tx_queue(dev, 0);
>>
>>      nr_frags = skb_shinfo(skb)->nr_frags;
>>
>> -    if (tx_spb_ring_full(intf, nr_frags + 1)) {
>> -        netif_stop_queue(dev);
>> +    if (unlikely(bcmasp_tx_avail(intf) < nr_frags + 1)) {
>> +        netif_tx_stop_queue(txq);
> 
> nit: AFAIU this is unreachable for now, but to prevent future races maybe
> better use netif_txq_try_stop()?

Will use netif_txq_try_stop() in v2. My understanding is this is still 
reachable since the maybe_stop call at the end of the xmit may have 
false wake ups when the ring is full. That is what is documented in the 
function header description for netif_txq_try_stop().

Thanks,
Justin
> 
>> [...]
> 
> Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
> 
> Thanks,
> Nicolai

