Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B24A3877
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450971; cv=none; b=Kxbqm4xOLZRUpRgxX1eu0yz092FfQ36lWeWNGoQr6Ha2yqYixFEztEaavNsdB2xpxtwtNT5C3AJxUsHUvP3apRymtvizzJcX9mI3FUafslz6OwIOMsq9E2zJn32ZKZH9w2JzbFGLZ7CrWYFOWqYwPEQITWyY1A33ORIQ0Yj7IgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450971; c=relaxed/simple;
	bh=+JVjLj8FZxlIaN3BMIEy+BrBP9wqnBxiXEh2S0ZvNgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKh5fRoeSQml4h8EcjaGk/HAso/TEYYUkJYGt797LbqpQWlCshgZHEh0G9f2a17mWmtVsAB5LycX85LMNIfLzhOMdUi1hIKTFBLZJTvgsvBZCxP53lehFNKiwvel49Ubtu7dnd+EZc01FJtxuiQn0yXGB/VOiMbYo0MFAZjWaKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7DkRh35; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=khYWlYJh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7DkRh35";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="khYWlYJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788450968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fbz/owPnKRrMjXILn4+/+C7V6jFSyrt1XBCIFCXBvC8=;
	b=Z7DkRh35Sm3hAqEQJdY7THKOKbN9mGtEzU9+QRW1gP5u5guZVfM7JKqbNTtG7aevoyNZFX
	pI7YZQsYdClnM9hwx0BG53fKSsKVsLJjr8pR4HCvMpfPe0X5TOcCvKrNdyciJ9vQo5ZLzB
	ZUVkRkTFeebJSRyNARq10nO8XaI8nTQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-B_v3gtHLP96iCilauqFsRg-1; Thu, 03 Sep 2026 11:56:07 -0400
X-MC-Unique: B_v3gtHLP96iCilauqFsRg-1
X-Mimecast-MFC-AGG-ID: B_v3gtHLP96iCilauqFsRg_1788450966
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-472c330e555so8699f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788450966; x=1789055766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fbz/owPnKRrMjXILn4+/+C7V6jFSyrt1XBCIFCXBvC8=;
        b=khYWlYJhcecg7ckTPQQqkkfpKWmdmSySVHxiRf5GARmf9Bzk79oFwjeQnHm9z03pn4
         G1shO3diPg0TKm3HlliiPai/LgOt2lGFyB/m88Y2Hz2Fby9CwTDXOFtLaR5xBzcNyHFp
         LgjPRDSWH6w8x7I15YebC+HDgOV5UMvCMXgSa/LafUQripaxBSDsBw7a33Hs49LOtrD6
         Dy+Hf53psXpAyB2B53cy6+T01GyvViCkhNNrSQwsfQyM2RgAAq1AS+CSVvG/G05oTTgG
         DHq7ewVGBaMROY8GKT67CXYWCsxgfTFxaSLfvbn7ozrtxNqavI13AYfQcQaJsgYsElCZ
         3/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450966; x=1789055766;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fbz/owPnKRrMjXILn4+/+C7V6jFSyrt1XBCIFCXBvC8=;
        b=jZ2vAHtyIgQBJXLSaPN9Zh2m8fQnXUHz8CPfezVFDQ8F9pHx/vui/w2ygYf8sS6wiO
         lMuCADVLxGw8z8IPxvUfjXPKg+aecVhqC2vbagPIImv3V1WDI+ZiZLLG+1ZL9fep0f/9
         atGeLnMCF4W4o9xKfR6ZkRDXv2RD+pWY6WPwH80UZ9U8RQOUpHDkuo95GHI44Kq5BFLa
         PIGa+OqaX1EOhHeG+Ugs+4cOhlJi6pYSZEm3SYvn31WTZTG6DezkYDfD3lFMhpUF6Kv9
         HtAbpQuj9xV5Kglap3fAUxWs9O5cIi6v0Azh1M/YQRGA3OFNUJ7n7DHJSyjwuCyRWncW
         tM7w==
X-Forwarded-Encrypted: i=1; AKwUvByd6M3xckAi8TZ1E7sfLNbHLoKPif24XJe1AJgUlixcRMdlPKBC4ggETmr8XfCnfNzmWj3gGYs=@vger.kernel.org
X-Gm-Message-State: AFuF++n1qevHX0qDjK6vXytZV7kSC4exoJPdAbU7pMZe55eNlIei0WF5
	r+PQPciUujhTtMjXUSJS2tIFnQSUT9LKGt5TuQ70lcgTWNHKmGc+CP3EQAdGOomOAqawZIDn5Tv
	ZjHTP1sVWvQzIwbtNrrk5qNqwQs4htBt46OVWRUlWIDtXvuUoMPeEaGrenw==
X-Gm-Gg: AYBFou1setk2R5vVDmDuA4BxgixM8V+sT0MeQ72zb+TKANT3jIK5N11pECgsxMyp6SJ
	HNJH6Z15HzvJitBlKbUJPdFLTHk3rRc7sGrC/shMJyu0ecGh2TVKwzuDWKjgW3QvmjzTi7CFT5Q
	GXS9WaZtE3C4w3xYpxEg3gM7YreGsU+Yqu6/m30LmIEJSKbX8V16oyLCMBRKvNoRYN1i63QpSvI
	QxrtBW6NnppDyIRdMULhiZ9KDzzSqkU5uu3NOkX4H514RMPH/BAslSKraBqBNW+DilPnmkUXNoc
	rF/S2Xk454b5ESStIdzaIksM1ZGXBnrv8TrcwRA2MNiYKhZpX5CiHKRs/hEpaoMzoAP/zcmCij0
	AuCAEEvzyzVGMGsIezOR6tYClGfxQn95crllV2nxAB/giEcBIa5TOJlnA/NsJHgwHnDMmU3YznA
	==
X-Received: by 2002:a05:600d:4:b0:49c:e9c1:25ca with SMTP id 5b1f17b1804b1-49ce9c12778mr188520435e9.3.1788450966079;
        Thu, 03 Sep 2026 08:56:06 -0700 (PDT)
X-Received: by 2002:a05:600d:4:b0:49c:e9c1:25ca with SMTP id 5b1f17b1804b1-49ce9c12778mr188519615e9.3.1788450965620;
        Thu, 03 Sep 2026 08:56:05 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5e589bsm74190425e9.13.2026.09.03.08.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 08:56:03 -0700 (PDT)
Message-ID: <0ca33b49-07d9-4cea-a9da-1ccdd6a40cea@redhat.com>
Date: Thu, 3 Sep 2026 17:56:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: airoha: add HW GRO offload support
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
References: <20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org>
 <fce0ee5a-476a-4867-9dd2-08e55993bd90@redhat.com>
 <aplpllPidmCjhSmA@lore-desk>
 <1ef90408-99b6-42fb-a7c6-7e5bca20c46d@redhat.com>
 <apmWLtgcUXRrOTFj@lore-desk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <apmWLtgcUXRrOTFj@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 5:45 PM, Lorenzo Bianconi wrote:
> On Sep 03, Paolo Abeni wrote:
>> On 9/3/26 2:35 PM, Lorenzo Bianconi wrote:
>>>> On 8/31/26 8:34 AM, Lorenzo Bianconi wrote:
>>>>> Add hardware GRO offload support to the airoha_eth driver, leveraging
>>>>> the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues mapped to RX
>>>>> queues 24-31. HW GRO offloading does not support Scatter-Gather (SG) so
>>>>> it is required to increase the page_pool allocation order to 2 for RX
>>>>> queues 24-31 (LRO queues).
>>>>> Since HW GRO is configured per-QDMA and shared across all devices using
>>>>> it, HW GRO is mutually exclusive with multiple devices bound to the
>>>>> same QDMA block. Call airoha_update_netdev_features() in
>>>>> airoha_dev_set_qdma() so that NETIF_F_GRO_HW availability is re-evaluated
>>>>> whenever the QDMA user count changes (device registration and runtime QDMA
>>>>> migration).
>>>>> Set CHECKSUM_PARTIAL with pseudo-header checksum on aggregated packets
>>>>> so that L3-forwarded traffic is correctly handled by the GSO/TSO path
>>>>> on the egress device.
>>>>> The HW does not report the per-segment MSS (msg3[31:16] only reports
>>>>> the max aggregated size), so the gso_size of an aggregated packet is
>>>>> just an approximation computed as DIV_ROUND_UP(data_len, agg_count).
>>>>
>>>> What is the <max aggregated size> exactly? I read it as the maximum size
>>>> of the aggregated segments, am I correct?
>>>
>>> Hi Paolo,
>>>
>>> with "max aggregated size" I refer to the length of the aggregated TCP
>>> packet (composed by multiple segments). This value is reported via
>>> QDMA_DESC_LEN_MASK field in the DMA descriptor. Moreover, the hw reports
>>> the exact number of the aggregated segments via QDMA_ETH_RXMSG_AGG_COUNT_MASK
>>> field.
>>>
>>>>
>>>> Also any more details on how the aggregation engine works? i.e. can it
>>>> aggregate "random" segment sizes (i.e. 200 - 300 - 400) or does it
>>>> respect HW_GRO layout? (i.e. all segments except the last one must have
>>>> equal size, the can be smaller).
>>>
>>> The hw engine, for each LRO queue, is configured with:
>>>
>>> - CDM_LRO_AGG_NUM_MASK: max number of segments for each aggregated TCP packet
>>>                         (64 in the current configuration).
>>> - CDM_LRO_AGG_SIZE_MASK: max size of the aggregated TCP packet (composed by
>>>                          multiple segments). 16KB in the current configuration.
>>> - CDM_LRO_AGG_TIME_MASK: max timeout to compose the aggregated TCP packet.
>>>
>>> In order to validate the scenario, I run the following test:
>>>
>>> TCP client:
>>> ------------
>>> - disable TSO/GSO
>>> - set MSS to 256 bytes (iperf3 -M option)
>>>
>>> I can see multiple 310 bytes TCP segments on the wire
>>>
>>> TCP server: (where rx-gro-hw is enabled):
>>> -------------------------------------------
>>> - the engine aggregates ~64 segments in a ~16Kbyes TCP packet
>>>
>>>   so gso_size ~ 16KB / 64 ~ 256B
>>>
>>> I guess this would be the behaviour even if the original packets
>>> have different size (not sure if it is a real use-case).
>> Lacking more details from the vendor, I think you need to use a
>> pktdrill-like sender, explicitly sets the segment lengths to some not
>> mergeable (like, i.e. 200-300-400) but otherwise fitting a GRO packet
>> (i.e. same hdr except for the sequence number and push flag allowed only
>> in the last packet), ensure that the aggregation timeout lasts long
>> enough to receive all of them, and check if the engine really aggregates
>> them or not.
> 
> I think in the example you pointed out (length 200,300,400) the hw engine will
> create a single TCP packet composed by 3 segments (with gso_size = 300) while
> sw GRO will just push sigle skbs. I agree this is just a GRO approximation.
> If it is not enough I am fine to switch back to LRO implementation.
In such a case I think LRO should be needed. I suggest to explicitly
validate the statement, it should be feasible, and the possible gain
relevant (should the engine instead do the right thing).

/P

