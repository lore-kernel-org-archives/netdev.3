Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8E42AFB2
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815980; cv=none; b=ZkYMy1+8V5GkddBTOd4IUgfxpbbAMcnrPNCeRbK3j2xfSnpW05GombVdCo0TudLxxXs6x5HrW+9NCeq3k8Ypeh6exLKdhCcNvS8aNfJ+w4Nx2rrU4NNXidBeQsXJcnb9BsMoAwzgiWJKtFQQ+IptAjexUlgi4hFVYDx44eKE4J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815980; c=relaxed/simple;
	bh=RvA1+CXHpz+XeH5m2e5ys4iiJ5g2DwMHECAho1Z6Bv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpGEy9e7A4rPUMPyd+7kBxmHn+ECJmq6dCvmvn2jVvUug+3T5u/aE30jConaVQM1VqV6PTDpH9f2dbpQ/oCXnyP1OU258Zy/8vutCSltQbJD3oCxiRdCCokMcGM16QTexTR8NColKewXRh7aoHVLdQbme8fpd2T9/h/E1sNJyHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8F/QHVl; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8F/QHVl"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso421924a34.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784815974; x=1785420774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yH40SRIUlQ4Wwh60WsdpxlUjQfkhuEARTuWzh2fWHOQ=;
        b=b8F/QHVlz3TVaCE4QYV5oec/VDXr03F6Eu1/fpcovfcsdDUwEuPt8atnQb0Xb9SffT
         49okZx/Njg1cx0vVHOwQpqdofE3HVTjBPb16lzMb2n/EdtbtXgi5vlBuOZigAJ/1mLEh
         AipcKhT1ZVtq39zTPRz6ExYYNrsDFUcpeg+fuWK1NjtMlCamivJsGusESDvD33yzPLl+
         W4Rbgpcn7xk2es7MGXvSW2TKTAQeC4Q8/ZetTwBBpdH/TkudNnnHCj0tqL0Kb8FTEirO
         5KEZDofLuti0d89PPfVJSRep28FbQhnwUn6SLRR6Jfezzup6eF537jD80ltHUq9jVSx0
         euBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815974; x=1785420774;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yH40SRIUlQ4Wwh60WsdpxlUjQfkhuEARTuWzh2fWHOQ=;
        b=BAHh8SVHfJmnCmzwRb8FmBNqjAxBM6nnAW4piqZiluNcZWqRCaNmz1cGiFDi4EXu1D
         TPawVIGG85fL/j42yGNyJz2a36Gxq7Id1uSJ0FgGtfxGvSUKQ0YkJow0D0h/sIg2DoNM
         gDX8KIGXgbP0LcBLXuL8QIXgeZvcKw3uMmxme+0nAcoZAK+uZ90/b1bO2RCAMRCMmYFn
         An7HhOwPVCdUonpbvgPLdAxS7WxCV+FLHWPTTGjRwKQG5isajBWtXIDbTaZ+o94+r1PQ
         faed9E4wyprdMQR4cbP6g9p/cvELjSpCkaROlGptWGegLlsH5/ZwJLb7ZB5VLropzq6e
         6pTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9KtMeS4pczNq80VeKfqC0yGVuFVZ68o7p0H0JE7r7wKK9q7CQU4PCXhsaK8l/XCbQZxgZyAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3oylevxAcjjWfehl+INRcOFuYW8A961kTQxBE1aVgwHhDAUm
	ORweIAjZebo3ImO1DO7oVy5aQu0BFldAoohb9iL3CjlQgdkv9dUTJ0MN
X-Gm-Gg: AR+sD12FJFR7hM9cT8sOTPIkc6294HGSfc8gdo1DX3yaigvoWybcSQZTzqBdh6chr+f
	kUV8y6iw+Y4YN95yDA+GKoBL2r2L5+kZglk+TMOjveXNvVUfH6zBuzPYEGiDw5onRAq0rOctnhS
	fvMt8y2oJehd1txQa/q0sU0Gh/o2UfBrDA7K6tFHEGryK2A0/1GWWrIj9g5DTpFsB6EcPlUrv3s
	v78kPS0vSFfNeyA6MqtsRh2fQ3/mlYIYRDXuasKAQ+gi0H2E//K5h2SzXtJasn47wo4/qX7tbrn
	nlVYFNbVITQ4AGodFZ7gkEQS2PIxxkKbqhYjFMGctlO+NA0fnD77Cw7p1FRTMfPM2gjvj4LnpCb
	RIs8h8EaMlhf9pAWSToWEWB2ynodmVr7x22RqTcRzNxgiITIasVEjAK0E4CZeXZbaaqRlBGzaJi
	r1MJudaP9pfPrYzMr7S3D9KrDrZUlk08PEITeXxBcRYXyVyxuaMw==
X-Received: by 2002:a05:6830:1e8e:b0:7e9:e288:5d45 with SMTP id 46e09a7af769-7ee471e9725mr894527a34.18.1784815973643;
        Thu, 23 Jul 2026 07:12:53 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::10db? ([2620:10d:c090:400::5:1ca2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ee2a03d316sm3740471a34.15.2026.07.23.07.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 07:12:53 -0700 (PDT)
Message-ID: <dfb1615c-18b3-4d05-990a-7c4db3139524@gmail.com>
Date: Thu, 23 Jul 2026 07:12:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] hardware pacing offload
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 Willem de Bruijn <willemb@google.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/22/26 1:43 PM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Enable safe hardware pacing offload on a first device (idpf), plus support.
> 
> - Add ethtool support for admin control over the device feature
> - Add device support to the idpf driver
> 
> Besides the main feature, also
> 
> - Small optimization to FQ offload: avoid unnecessary ktime_.._get().
> - Expand so_txtime drv-net test with hw offload testcases.
> - Expand pktgen with txtime feature.
> 
> Details in the individual patches.

Hi Willem,
Thanks for this. It'll definitely be useful for other drivers with 
native device EDT support. I left a few minor comments on the individual 
patches.
> 
> v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/
> 
> Willem de Bruijn (7):
>    net: ethtool: add hardware pacing offload support to rings
>    net_sched: sch_fq: clear past skb->tstamp if offloading pacing
>    idpf: support pacing offload
>    selftests: drv-net: refactor so_txtime errqueue handling
>    selftests: drv-net: in so_txtime tell apart sw from hw pacing
>    selftests: drv-net: extend so_txtime with hw offload
>    net: pktgen: add support for SO_TXTIME
> 
>   Documentation/netlink/specs/ethtool.yaml      |   6 +
>   .../networking/net_cachelines/net_device.rst  |   3 +-
>   .../net/ethernet/intel/idpf/idpf_ethtool.c    |   3 +-
>   drivers/net/ethernet/intel/idpf/idpf_lib.c    |   5 +
>   drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  65 +++++++-
>   drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   2 +
>   include/linux/ethtool.h                       |   6 +
>   include/linux/netdevice.h                     |   6 +-
>   .../uapi/linux/ethtool_netlink_generated.h    |   2 +
>   net/core/pktgen.c                             |  93 ++++++++++-
>   net/core/rtnetlink.c                          |   2 +-
>   net/ethtool/common.c                          |   3 +
>   net/ethtool/netlink.h                         |   2 +-
>   net/ethtool/rings.c                           |  30 +++-
>   net/sched/sch_fq.c                            |  21 ++-
>   tools/testing/selftests/drivers/net/settings  |   1 +
>   .../testing/selftests/drivers/net/so_txtime.c | 147 +++++++++++++-----
>   .../selftests/drivers/net/so_txtime.py        |  72 ++++++++-
>   18 files changed, 408 insertions(+), 61 deletions(-)
>   create mode 100644 tools/testing/selftests/drivers/net/settings
> 

