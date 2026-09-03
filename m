Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD1049365E
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435793; cv=none; b=P27HAYPE/qqeIeJB29KoUK1vWinzUr5tYrmEHzbKaBYOH2iJ+J87nd9kAIViM/udJQMAr8+npFzdhWiJqyl5SAM2rZkpuG9gYmuuCXELhUQ8bIIFPGzHh+4A/L3fqJt6/VSpc9lMq4HdJidreDUj5sxa4nfhNvBDY/nnEtCwmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435793; c=relaxed/simple;
	bh=Zg08WXWOXsJ2QVUn2MD0H7hbFnvg8gqIUMqRHXTyYHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZkNN/IJ1P223dAeNTqt2TRLeWyEgFFmdTqc0TgNITK/nph26uddy+G5biGxzSWUmY0/JhHpprZ+k3fnWtAwiOQhMFmvTA0GKLQY+8IC9+LVWxAYBULqabe7tqkQrvIEfEcHZt0YtfELU9pgN/J13S7MH+Gr3XVOQmqe5kwd3Nj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I8Dv6P+/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3pd6fzJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8Dv6P+/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3pd6fzJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788435784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zg08WXWOXsJ2QVUn2MD0H7hbFnvg8gqIUMqRHXTyYHs=;
	b=I8Dv6P+/KYygmtnGecoJa1MowJXg8CyTg2O3+DASFKlhg3p9FynLhu30vPPTeCxFTRKa2j
	LhKuQx9EJ/sLslKYa5W6UJx2IQ3oU6OK532kx94rTVT06qQRTOj3/qTT1nvhvm5jMOovVk
	qoESZazO98KJbK75h8KL5HdYuE4mo7k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-B90G4-rIO1aevHtKEpNtcQ-1; Thu, 03 Sep 2026 07:43:03 -0400
X-MC-Unique: B90G4-rIO1aevHtKEpNtcQ-1
X-Mimecast-MFC-AGG-ID: B90G4-rIO1aevHtKEpNtcQ_1788435782
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-495474a5fbcso19158105e9.1
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 04:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788435782; x=1789040582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zg08WXWOXsJ2QVUn2MD0H7hbFnvg8gqIUMqRHXTyYHs=;
        b=U3pd6fzJM8ktItiqAKyNHPSx9p4rIOIrjx0qMYPHFdzIN9fp4puv3UnAxMXKxzq8M9
         klWAwwYB9+UDSuGT8ML+o1fsxKjMfVdH/a8z8kI1oPEvJVZuYf9h+N7xh6d5Cm69NSZn
         SD9tbDKJILyVnF//bFc0HvomKT+3IIQB8VvOyIQVh47Q+Xo2OSPxzQqmDkkXgZjTeetk
         /FeESNQCvmwlYLRizJD+0MLX7WHe98MyAJDnIjO/3KO7h5GSh58Jo6E9uwknKHDu6CYc
         4JkXeR0zdBR4DoDpI8o2c4UoTJ8HLitoIraPNmcU2HJNTN44n9+FMI3JRNKwHJpxFe9j
         P2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788435782; x=1789040582;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zg08WXWOXsJ2QVUn2MD0H7hbFnvg8gqIUMqRHXTyYHs=;
        b=skkRnEPE4vtUmRir6alL+oeupjSFmCT/OZXVmvR6wYbGNTGiWQltPz80rLDCN6LEBX
         eVRhy2CJyAO9YJTMHD4eMhOW0CP3ViMbFeoH9hEeeofwqa7D2my7foa6fJbi7isiNVBd
         O0dzx+nW3hqTcUuAMGfcFxFzgpXjUcfJ6RVurmgnvHhqOWksp7qBF1oqecbswrmSzq0+
         Rht3JjIl6BpX3PoXayKv9YaJjr9Yw+i68fOSM1HITA0pCGzmS4fRaro5H9RVyJGVu2SD
         ffm1gbQqAQs4TIl75dNKnJt6ryPLA4/+/fKG7UPDBx07qk5N1dIBRbLklnFGuDBmyQVQ
         M92g==
X-Forwarded-Encrypted: i=1; AKwUvBzH2zOqrN0926FZcVc13MgDFhKmFBUoFQAYxsyW6phzsR8eAoNAkBaXJCDs49CqIz+4Bo9Qntg=@vger.kernel.org
X-Gm-Message-State: AFuF++knLLPIC5C6Wdfv9aJCBFNBckOlTaKc2xFnvMGS8F5IEDOpEpIA
	ciDj3ZPXzY3jvvkRgHBax2sBCR/YcfBgm2BOgArxa8xiQsh+epQL2MLpHdLMFPPg/mcc75akGjw
	a1yVT5Q/8R5betd8ctoBSN2lgQ069ngS9kN64O95iHD8Or7M31V9zrxZusA==
X-Gm-Gg: AYBFou3fAXTmbD6EQkbB8O7mOqGPrw7WOVouNk+Jjbm7M+K+Zcirn2ONnpp1ckRbtk0
	hvdD2WFePa3W0Vy237yAvjRM59mnNvUh9NteKfzToNFy1cJ/Ee6TEbRyMbLpnJJsb9BvSRY7xjL
	fhakMxwqHy+cftiUzhqqwhgHtxwkyr1aMYX6/ouuck2LnAT05BBnb5Vp2MGYBIfcb1ZztSY7shc
	axOfGk+vlEeAc4pt9ew12cAX1e9ot/e2hUVztvG/EI841oyBr2V+APFfNo9FlFpgtCiA6WswitE
	W+ZZ7KPlP3B51mdZDazuPxqOrrfbfzkvh9p89AqFZ3TK0IsS7hK46CXHvBbjoPJtdr9z4WDJyw4
	j8/okOBL7pwZTndtflG9lC1yCvoMtF2CQrtx5EkNOP+pq30yt+xANdyLS8c4sBiXut4Vfx0cSfg
	==
X-Received: by 2002:a05:600c:4743:b0:49c:e3b1:d826 with SMTP id 5b1f17b1804b1-49ce58195b0mr176370285e9.13.1788435781728;
        Thu, 03 Sep 2026 04:43:01 -0700 (PDT)
X-Received: by 2002:a05:600c:4743:b0:49c:e3b1:d826 with SMTP id 5b1f17b1804b1-49ce58195b0mr176369365e9.13.1788435781291;
        Thu, 03 Sep 2026 04:43:01 -0700 (PDT)
Received: from [192.168.188.218] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448e7f8f9sm13297052f8f.9.2026.09.03.04.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 04:42:59 -0700 (PDT)
Message-ID: <fce0ee5a-476a-4867-9dd2-08e55993bd90@redhat.com>
Date: Thu, 3 Sep 2026 13:42:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5] net: airoha: add HW GRO offload support
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
References: <20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260831-airoha-eth-lro-v5-1-6b0f50401121@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/31/26 8:34 AM, Lorenzo Bianconi wrote:
> Add hardware GRO offload support to the airoha_eth driver, leveraging
> the EN7581/AN7583 SoC's 8 dedicated LRO hardware queues mapped to RX
> queues 24-31. HW GRO offloading does not support Scatter-Gather (SG) so
> it is required to increase the page_pool allocation order to 2 for RX
> queues 24-31 (LRO queues).
> Since HW GRO is configured per-QDMA and shared across all devices using
> it, HW GRO is mutually exclusive with multiple devices bound to the
> same QDMA block. Call airoha_update_netdev_features() in
> airoha_dev_set_qdma() so that NETIF_F_GRO_HW availability is re-evaluated
> whenever the QDMA user count changes (device registration and runtime QDMA
> migration).
> Set CHECKSUM_PARTIAL with pseudo-header checksum on aggregated packets
> so that L3-forwarded traffic is correctly handled by the GSO/TSO path
> on the egress device.
> The HW does not report the per-segment MSS (msg3[31:16] only reports
> the max aggregated size), so the gso_size of an aggregated packet is
> just an approximation computed as DIV_ROUND_UP(data_len, agg_count).

What is the <max aggregated size> exactly? I read it as the maximum size
of the aggregated segments, am I correct?

Also any more details on how the aggregation engine works? i.e. can it
aggregate "random" segment sizes (i.e. 200 - 300 - 400) or does it
respect HW_GRO layout? (i.e. all segments except the last one must have
equal size, the can be smaller).

In the 'good' scenario, than by definition gso_size == <max aggregated
size> - <total hdr len>, and you are better off computing the gso_size
from <max aggregated size>.

Otherwise I think we can't call this HW_GRO - even if it would be more
convenient for the driver.

/P

