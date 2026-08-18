Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E33A641F
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 14:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064360; cv=none; b=HGWlBgNIDscUvOf2ASgjEvsvJ83eEwDm2t3Km/FEF1b74E5Un/2H4ov9SNBR214Wp3muE8XgX10R2BH4goeaGIsy/Xgjl0p0NpAT6uvZw4BjzJpDKvFGJDyLlLonMnjxblHDtEDFlghh6RztBG+Vq4jYvyAcpis9SxBISZGvw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064360; c=relaxed/simple;
	bh=0FQbJHW7AurjhwQOLkDMV+ncEldqI856h0Ld9RBIa2U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o63nTKMpvuAF3qMR/yhWrQN31YueV9lzz1i+7etHrQbg1ToiQtQqcjin9wL0zXNBTei+MWtdV7+y4Mbq01Kk/nDeoT9YOzFNPf2Ox0PDg9k4y6wYW9bERJE3hvmUooqpPjn8/TpsRqLqgvLEdF+mRu3XBDopfq7lR7/m6jsKjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=giQbvSrR; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="giQbvSrR"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f7872abb6so2679999f8f.3
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 07:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1787064357; x=1787669157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=75cy4pdMpPQco440xxfjThx3YDct50m5fV83t3H3aRA=;
        b=giQbvSrRyf/m978OixpK1PKuDkl+sHDazfmpoMYG4pDkbIeWeR9O/Sb7k5mcRWBsEh
         vpLgvJWAHmWw2sNbX8kTynEliblrTimQb3X88EcJ1e7WQohsUMMfKc/pyS1OmAmVKOqK
         G8XFvHi8DlE/jBawZSFP+x1mLWZujXpZBG+sdStVXReHWkyKn+tKHjfIctVxwMzBQULE
         As+UICz/YP7TH6cUJ1EZh6+zk1HHWvE+e2k10etDmaTFTwGMf812oGjTzDKw0sItgnXZ
         gteAm16Lf9pxCyTPh8yh+rUCAbPTHscF77IhYtWW5tbu/OtnQwFfxLGPhuydLWSZ8miK
         SW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787064357; x=1787669157;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=75cy4pdMpPQco440xxfjThx3YDct50m5fV83t3H3aRA=;
        b=WQXqBDCoVg53xzVRZQ49eJ6mjgNwWnyUCW4AS7a/cHh/jyUljOj6r/NP/3xhf6GQ7v
         2Qy6DllaysahM9cgHVDof7a78YZeAv05yz+gncw4UsPmBOuUlXDyMYLzvks1AR9K+lgc
         UQLhyznVQilrLpYZ4aQMJZXDWRh4SyGtD4T/7T76Okrhwi/HLVUIYrUH32I0HlYVcbRh
         6CoZdBUkH2IAgGmdG9sxCS4ZH0s1vcmAvgzUpbKjnfgGm1emkB7I2NOLHR1/S757hv88
         XK+AcHHqoc6zXtRarxYJhUT0kRhMubiZTcv0F4tgpv95GPGcArzQaT8ZGv6BdtJF5RjP
         eacA==
X-Gm-Message-State: AOJu0YwrB+JkQnufMRP2caqwTWXQLLjtCWS7Kf1RQDfNu+jkmA2p9mrr
	ZVQ6KVNuqtBuNjTSgf2Nqvv2a68JeehuOWAsHNNmWHifww9dBvXLVkvUpyCOpFB6cFK1KUp7895
	/QVkw
X-Gm-Gg: AR+sD12GjjMosaa5EC+rYPbZhcrTqqXVqSBeaxOMPSrqKxrDTMHlL2EHvdfiv8R+c8M
	2qMFoabDgJPd1Elg3uJ43NuHxCv3GXxbvpTkZA0woPWbMW9I+fpTgrWL+OYsAWWz22DstliF21N
	WYsdyUMGfJ/OxEguDcBtub/hSCNWCsak7gNyw33+SBY8tEAtyU4BQMT/RfP5o7jgbLSl9ubwqmp
	14UY4dElUQkGzJz6Gw9ylS8Ue0I7F8f7PlT9GOJvnJzPbjw+Z+3yyFGsls6UwOIviXkS76ZYnPZ
	WU6U73AKFOMpUGFqEqdVuL76qpxb1TgsUT1rdPRiPyRm2AMXhg1XFqBwDDi2mCD6nyvaOs9jV85
	9CkZNTCDMNO00H9We+O1G1VZGBhCheD6TfxhGwYRzmg6RgZzlK+hXKLJiZGRIFCs7LVNjFAbmb5
	IzV6HXWj9xo9+d6AerAb3ahzAxd6YkN7MF9N+8k6mGx6lTmD21lLk3pvHh3dh9jaXJTc0DILUcU
	MT5dJ34WyjqLXgN25CN6jmSKJcKZA==
X-Received: by 2002:a05:6000:46cc:b0:47f:f3f9:ae37 with SMTP id ffacd0b85a97d-48160705704mr38770799f8f.7.1787064356707;
        Tue, 18 Aug 2026 07:45:56 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3158asm12955103f8f.7.2026.08.18.07.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 07:45:56 -0700 (PDT)
Message-ID: <c1e62798-d1ab-4ec7-b50f-c54b360f96bd@blackwall.org>
Date: Tue, 18 Aug 2026 17:45:55 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] bridge/vxlan: fix reading neigh ha without
 synchronization
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, roopa@nvidia.com,
 bridge@lists.linux.dev, andrew+netdev@lunn.ch
References: <20260817143613.685769-1-razor@blackwall.org>
 <0543351c-2c7f-48db-891b-4d8a60776b3d@blackwall.org>
In-Reply-To: <0543351c-2c7f-48db-891b-4d8a60776b3d@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 17/08/2026 18:25, Nikolay Aleksandrov wrote:
> On 17/08/2026 17:36, Nikolay Aleksandrov wrote:
>> Hi,
>> Neigh ha address must be read using the seqlock to get a stable snapshot.
>> Both the bridge and vxlan read it directly and can see partial updates.
>> I reproduced both issues with running neigh updates and exercising these
>> paths in parallel and saw partial addresses, e.g. updating between
>> neigh A: 02:00:00:00:00:00 neigh B: fe:ff:ff:ff:ff:ff was able to observe
>> 02:00:ff:ff:ff:ff and fe:ff:00:00:00:00 in packets. Noticed this initially
>> in the bridge, then checked vxlan and its arp/neigh_reduce functions have
>> the same bug, route_shortcircuit is doing the right thing already.
>>
>> Cheers,
>>   Nik
>>
>> Nikolay Aleksandrov (2):
>>    net: bridge: arp/nd proxy: fix reading neigh ha
>>    vxlan: fix reading neigh ha
>>
>>   drivers/net/vxlan/vxlan_core.c | 20 +++++++++++++-------
>>   net/bridge/br_arp_nd_proxy.c   | 24 ++++++++++++++----------
>>   2 files changed, 27 insertions(+), 17 deletions(-)
>>
> 
> (-CC bouncing emails)
> 
> Hmm perhaps it's better to use ETH_ALEN instead of MAX_ADDR_LEN to explicitly
> show the expected len everywhere, it cannot be different anyway.
> I'll do it for v2 after 24h.
> 
> Cheers,
>   Nik
> 
> 
> 

Sashiko brought up valid alignment questions (ether_addr_copy expects 2-byte align).
I'll fix that up before sending v2.

Thanks,
  Nik

