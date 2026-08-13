Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D9A23EAB0
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613223; cv=none; b=ay554SiAnozuTPjL5DoIPjEedRkFVV43mzJkOCtWx1BPVNp+FwOMs61+xcsJ+wqE8hvPxJpVBvoMM65dRHTWoqQmQtjIB9z8ea1/qGTgnsPIQ+PNwL+8dfz/y8osEVZ+9fihn649+9d9x0u+pHpx3WWHe0MLinNO/oXfrZMU4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613223; c=relaxed/simple;
	bh=HVFYHe1cO56Fqs8t5vNa3oD0aqTdyREtrJuRsH2lyZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EpgnGkvwCzvTXce1abaQ31yumypaLGWHfU9q8U0xH6iI+anmZBLdXFz8/sw3vOEfeMt1zQaHTnaOG7jvMZZj2YaiLBBUXp1hNSmeKFzLuPGV3gD9bRRaHtmtzh8tsyt6NOgB7WDdov5bdnxZTuJAQqDkFsYqdjHjNrpzTQqAS0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIJDbwQ3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jjIeRkc6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIJDbwQ3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jjIeRkc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786613220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olvOxTrv4YnBNgv+BD/U939Ug/C+Fyeg9JeE5DXp5dQ=;
	b=GIJDbwQ3pab4rqNrkHWHPa+kxdX+T/Lgvk1e+Tf1krsgArpwMNyeb16O2s0JyCj0hyjYN8
	51Zpu+Z7VZqMotsHnFoLNJ6yBERMpEeIAZ1hYinQe5mr7eUKT5yoZ0eFUJ1jS0O318pbFB
	7PwIY5u94JJ0S5dgdBjunXv1vgxC+4M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-7N0QQzO0OS-dgW73iUOYUg-1; Thu, 13 Aug 2026 05:26:58 -0400
X-MC-Unique: 7N0QQzO0OS-dgW73iUOYUg-1
X-Mimecast-MFC-AGG-ID: 7N0QQzO0OS-dgW73iUOYUg_1786613217
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47faa02f707so581141f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786613217; x=1787218017; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=olvOxTrv4YnBNgv+BD/U939Ug/C+Fyeg9JeE5DXp5dQ=;
        b=jjIeRkc6Elob5iEf3otyNLLw/Lam9DUOCEgo+2z0e9+arWWEqgpu8AgN7oPMY68zh4
         WjNmyfBrY1pq1iEUzsFdoslOB22r7mCLu+tu+NWPeKwI8JfObaivxxRc8w7pXJX+DMum
         kP7JfEdEtH7IK1vxIyazvI1uBhSaHWo3MHt02Il1nwIB7j2JPSy2el+l6N1PLhMPhSFD
         bfc82zqcvxg8eHz86bD4INdqX1c00Zq/XtDj7iqHI3epk/ber/mU/p9bau8ZFRSK2l/F
         fyerXNF+fhGRNjWsSPdmNEcaAW0BLZrbKxN+bL6t43/ydD2UfB+k8+vmMREQcKKkCtgP
         mS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613217; x=1787218017;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=olvOxTrv4YnBNgv+BD/U939Ug/C+Fyeg9JeE5DXp5dQ=;
        b=abOzvyYsjgrbtm7e20wMke8+6kgBxTcb2VcLBCZ5InvXNkp1/pU46MYk1fJXM5+U26
         cgCIrGWzCpSE/l/EMsot+vBWCsZrSAcluWDDQD8cVLugzdHBH/UijBz2jeN6bwJyOvgP
         po+DACgzV+axySQMLd3WsEABcVgGfyuIy08NjGYicowNsjkeI6Jf8cPV5ZhOUFSZpl8Z
         Pbreppo3S2l1gI1YsMZi/ib9SIzf7ccYa8l1HYEQldr0x5gizJmpeRxdzraL8XQELHlR
         MsLSJ/cyakAT14ByCsQzAQh8ZV3LZhZ6K2ZfWwqGd7VooRx6qLATERchZAIwnX4gUuT3
         ebkg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4fOaPlItaaZkdHwpj5vnaR3d4RltG2X0CuLrdUW4NmKU+DnHm+2IRf25DEz5ra8Roj2RwgOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGd9WpTc0EEn3FdG0VezKPZhMPdvM9UGgbJM/qZPINY3iX8ci1
	7L6X4LtqSamPCE+DXuIWX9Ka3RXhmUjPPGTr+YFTWK9t734Rfn/1xapRcwUtmj75NL9kjFx5hk+
	Qs4eB6qGjLlS7sYr12U3mZtLMo4OtG+c5RniNE2xhRNgj/3/gxgO/h7FUkQ==
X-Gm-Gg: AR+sD10LAneXXmDFq4MqRpQOmqfYt19ONbGXcBJ79az2qDUbjoAzqN1T/deKr7BbeI1
	hUJXxxmTEHk2f9aNLTRlyR0u1L3D+mijgPJk3TJjROSNC7e7Jt/z6MF9sN0DvQvH0DxH34GeHSx
	Fy29f8MkzAEJiu+2Z0IltygCvFof3Km3Rlzx4pVqmH2GTCLM8EHHHsi3YOSGVou+GaniRJbdEKY
	vwHxqugadA1DxItOzVSJeW8Nw8V1VX2BeFn5duuql4NcXDTGNCGQ9L6ITJF8bBBWndTvwyViDru
	U+9mMo0uFFflu61hDFMQLePt87qnYaiRxCDjkegnmIgJrDDFg9RZ9TfDlm0OUFVgB7RzlTbs+Sr
	moEQZxSVoaSrqdvUWU2NYpg6EUxNNN8kMYr92/iYIDbgr9/WxQ+aFICDfrK+QGdA3B72r7yd/0f
	o=
X-Received: by 2002:a05:6000:2210:b0:481:50ae:df9a with SMTP id ffacd0b85a97d-4815a52bce0mr5525477f8f.9.1786613217326;
        Thu, 13 Aug 2026 02:26:57 -0700 (PDT)
X-Received: by 2002:a05:6000:2210:b0:481:50ae:df9a with SMTP id ffacd0b85a97d-4815a52bce0mr5525393f8f.9.1786613216887;
        Thu, 13 Aug 2026 02:26:56 -0700 (PDT)
Received: from [192.168.188.103] (ip239-44-231-195.pool-bba.aruba.it. [195.231.44.239])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a56133csm4902762f8f.7.2026.08.13.02.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 02:26:56 -0700 (PDT)
Message-ID: <60ca9ce8-27d8-4876-b66f-a4bf9824d607@redhat.com>
Date: Thu, 13 Aug 2026 11:26:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net: airoha: add HW GRO offload support
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
References: <20260807-airoha-eth-lro-v4-1-12d11ecb77d4@oss.qualcomm.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260807-airoha-eth-lro-v4-1-12d11ecb77d4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 11:18 AM, Lorenzo Bianconi wrote:
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> 
> Add hardware GRO offload support to the airoha_eth driver, leveraging
> the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues mapped to RX
> queues 24-31. HW GRO offloading does not support Scatter-Gather (SG) so
> it is required to increase the page_pool allocation order to 2 for RX
> queues 24-31 (LRO queues).
> Since HW GRO is configured per-QDMA and shared across all devices using
> it, HW GRO is mutually exclusive with multiple devices bound to the
> same QDMA block. Call netdev_update_features() in airoha_dev_set_qdma()
> so that NETIF_F_GRO_HW availability is re-evaluated whenever the QDMA
> user count changes (device registration and runtime QDMA migration).
> Set CHECKSUM_PARTIAL with pseudo-header checksum on aggregated packets
> so that L3-forwarded traffic is correctly handled by the GSO/TSO path
> on the egress device.
> 
> Performance comparison between GRO and HW GRO has been carried out using
> a 10Gbps NIC:
> GRO:    ~2.7 Gbps
> HW GRO: ~8.2 Gbps
> 
> Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Sashiko nipa has still something to say:

https://netdev-ai.bots.linux.dev/sashiko/#/log/9407

/P


