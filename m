Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F54A8FF9
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443236; cv=none; b=bdaG7QTkMVtmi9YvnzdzpaEBhJsunXGr7r8KeaLnnpuyHuXS7yDryCMzTx7ti0Eo0l1xzmuel02SHVWJ7xhPYAHa11LuF/xq4NRE7Ymss2TBRmnui4ANrTxae6zf9A5zaNtc+gE5X4ABfNanchbheb+Uc6t6SRB7ZlCzy6D6jH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443236; c=relaxed/simple;
	bh=/xy3ICTx9MWMWANSlH8m+2K+yQ0z0Hc6wTXnD6Ky7AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UtlEFJGdHZytZFwS/gBWF3XYuJnXNmeFdHEg5atrLj/2OCtjhzFGsdAj/GElq1dy1BbaL3zZQxc6R1jBeN4WkDBs3vsnTcinVuKo5z/iDQe3794oGQby5b5pxd1C2EY3JwQS9J1Zg4bvwvUXXvJcnJ+ouFIQCvMyoziVfdO4LZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cScZUp+U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Erp1otKZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cScZUp+U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Erp1otKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788443217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Tb/L+VGBd0B4nk4cyFUET4v3yYKRPvEqokLayHQsa4=;
	b=cScZUp+Ua+CZhRDakr94DgwspW94Gz9Cm92RMg5HpQ1aGrsconHPj8VdbeFj3UJY7u1Wfj
	0ZEXKl+2/jZesf5Np/+xdzLPbabIg3Y66QhAE3/zYg8ZKMN+AAL90MRCrc7yiXsK8ydNUA
	rKkreNhSyDmg0OJWWJYtuJ9bC5oFxTg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-uAvnXbBIMO6eiCkuSaL9GQ-1; Thu, 03 Sep 2026 09:46:55 -0400
X-MC-Unique: uAvnXbBIMO6eiCkuSaL9GQ-1
X-Mimecast-MFC-AGG-ID: uAvnXbBIMO6eiCkuSaL9GQ_1788443214
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48439ef42d8so2119092f8f.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788443214; x=1789048014; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Tb/L+VGBd0B4nk4cyFUET4v3yYKRPvEqokLayHQsa4=;
        b=Erp1otKZfKhtRdDKe1B+ZLYWlZuKBz1a88sNZbn93tS5hgF9Rbh+vT622sw1Qobk4O
         h8QAb15dAP3mYQ6v0v1naAVxRjKyP5zGlqziTXLGROw62CKLHzU9qKhCG9ZHKaPWSY6O
         SPlPaA+WJLlnzanplYLGA49Cxpu1JeK823aiJe6TDIB3gYbfFEFG8GjQXm23zE1baMp6
         5wZ2cY/zjJ9AoS+38VGv/i0VQ/Eff5ukwNbDLByYGlxjFU1TH1O2k49eW9hq1tBfDJki
         q7m1jvFxM9hT1J/QUPq0VEMUVmKyPpEdc/32D+T67sAZcugEpGh0HE63BJ8LVfqchnqR
         FJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788443214; x=1789048014;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Tb/L+VGBd0B4nk4cyFUET4v3yYKRPvEqokLayHQsa4=;
        b=qw13VVu+L/b1+kiLdZfHC1gFOydihJNjdaviIp7RDWemzUxwdmvgPrbhIRdgKKtUgn
         Qzgs+UMEwZdiRP/leXSTq2buXyUNdy2Y0WJ0t0yJpUA8KprsNaH2TykmPDn5D74uB/Gh
         oQ0U0tU9HdJNFrEcKnRov2ZZgygysrNxW3kQ0wSQJS9YrCF3s0kGPRNrN4v2Q86y6oBX
         wORRVpNYyyg40O2PQnnf04Kfx0zLXI5vDy153cWYCyNGt5aOsWBhD/FKqhl/g8JyxSXi
         Np1wRCIHeTDPj8Nk3btGNhdX7Jii//RHCBldlyCdSyEDegS9523aLzg7qSZYPMvpMBam
         M4GQ==
X-Forwarded-Encrypted: i=1; AKwUvBymO/xgM5oou79Pe10DnZ7dZdbl4zzmoMCv5hBJZs9YiQx8aZ8qklQrRbhSQ1C8JioRipAiKes=@vger.kernel.org
X-Gm-Message-State: AFuF++lQetHDcSQgi63RfMwJlXrsDZdOnYYsY5O+z3fF4WBloNWb+PC9
	jxxib7ZcDT4RU/OwX/l0uD8T5lz4BzsXgVaPf/djGhLNAEhDpCtoXYsVWEafoHfySaIr5fYHppy
	Y80QjA5o71bdR4uZhvZiOEVpQ0VGFo9OCpXc8CKtASAzGoBTHzjVJuGAUzg==
X-Gm-Gg: AYBFou262pIdo2uh3XpiNJnCyYrC7V9ZA6eiD3JJ71uhOtfR9EONvBFtX1q6WHJxZPe
	DUK9djdpxXzepgoC/vlp2iQdWJSwPnxL8S7XgNxG273sbcInl40s7J1biNWP29tEGvpqkbvy6WF
	6FnIb0pJlyu725qdR1nM9AhDK8q832tyhxrErTNpcHyBBH7YInTNKLc4iLupTEILAX9eBGQgiPQ
	yCNPRnUYLP8DjhWmEQBN9qN+FTPW/bvYNPp17gtOvZWeNIz/WFRQotdyJL6tB5BBmXNlphchG/6
	/LzQKU1+ZLFs9jBiw/Cbi6tuUpWUf62XdCxFkSq8YnFIRJMsr/MAgbG1P4QsmdPz9x/9IYsFanP
	Jsn7EPnQDkYWffap6cd2H/vergwDjIa64HLktjDVaBsEHea8/KSjTZLEoKU4=
X-Received: by 2002:a05:600c:4592:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49ce5828104mr200759325e9.7.1788443214242;
        Thu, 03 Sep 2026 06:46:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4592:b0:496:c1f3:e8f8 with SMTP id 5b1f17b1804b1-49ce5828104mr200758365e9.7.1788443213792;
        Thu, 03 Sep 2026 06:46:53 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5dadddsm87661595e9.9.2026.09.03.06.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 06:46:52 -0700 (PDT)
Message-ID: <1ef90408-99b6-42fb-a7c6-7e5bca20c46d@redhat.com>
Date: Thu, 3 Sep 2026 15:46:51 +0200
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aplpllPidmCjhSmA@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/26 2:35 PM, Lorenzo Bianconi wrote:
>> On 8/31/26 8:34 AM, Lorenzo Bianconi wrote:
>>> Add hardware GRO offload support to the airoha_eth driver, leveraging
>>> the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues mapped to RX
>>> queues 24-31. HW GRO offloading does not support Scatter-Gather (SG) so
>>> it is required to increase the page_pool allocation order to 2 for RX
>>> queues 24-31 (LRO queues).
>>> Since HW GRO is configured per-QDMA and shared across all devices using
>>> it, HW GRO is mutually exclusive with multiple devices bound to the
>>> same QDMA block. Call airoha_update_netdev_features() in
>>> airoha_dev_set_qdma() so that NETIF_F_GRO_HW availability is re-evaluated
>>> whenever the QDMA user count changes (device registration and runtime QDMA
>>> migration).
>>> Set CHECKSUM_PARTIAL with pseudo-header checksum on aggregated packets
>>> so that L3-forwarded traffic is correctly handled by the GSO/TSO path
>>> on the egress device.
>>> The HW does not report the per-segment MSS (msg3[31:16] only reports
>>> the max aggregated size), so the gso_size of an aggregated packet is
>>> just an approximation computed as DIV_ROUND_UP(data_len, agg_count).
>>
>> What is the <max aggregated size> exactly? I read it as the maximum size
>> of the aggregated segments, am I correct?
> 
> Hi Paolo,
> 
> with "max aggregated size" I refer to the length of the aggregated TCP
> packet (composed by multiple segments). This value is reported via
> QDMA_DESC_LEN_MASK field in the DMA descriptor. Moreover, the hw reports
> the exact number of the aggregated segments via QDMA_ETH_RXMSG_AGG_COUNT_MASK
> field.
> 
>>
>> Also any more details on how the aggregation engine works? i.e. can it
>> aggregate "random" segment sizes (i.e. 200 - 300 - 400) or does it
>> respect HW_GRO layout? (i.e. all segments except the last one must have
>> equal size, the can be smaller).
> 
> The hw engine, for each LRO queue, is configured with:
> 
> - CDM_LRO_AGG_NUM_MASK: max number of segments for each aggregated TCP packet
>                         (64 in the current configuration).
> - CDM_LRO_AGG_SIZE_MASK: max size of the aggregated TCP packet (composed by
>                          multiple segments). 16KB in the current configuration.
> - CDM_LRO_AGG_TIME_MASK: max timeout to compose the aggregated TCP packet.
> 
> In order to validate the scenario, I run the following test:
> 
> TCP client:
> ------------
> - disable TSO/GSO
> - set MSS to 256 bytes (iperf3 -M option)
> 
> I can see multiple 310 bytes TCP segments on the wire
> 
> TCP server: (where rx-gro-hw is enabled):
> -------------------------------------------
> - the engine aggregates ~64 segments in a ~16Kbyes TCP packet
> 
>   so gso_size ~ 16KB / 64 ~ 256B
> 
> I guess this would be the behaviour even if the original packets
> have different size (not sure if it is a real use-case).
Lacking more details from the vendor, I think you need to use a
pktdrill-like sender, explicitly sets the segment lengths to some not
mergeable (like, i.e. 200-300-400) but otherwise fitting a GRO packet
(i.e. same hdr except for the sequence number and push flag allowed only
in the last packet), ensure that the aggregation timeout lasts long
enough to receive all of them, and check if the engine really aggregates
them or not.

/P

