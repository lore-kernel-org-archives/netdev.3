Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EDB344056
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768967083; cv=none; b=p4gix9JS3EOl3OEHUoofdoSaOCIHuJgrcsN8/RvnN31QvkJNlgVCs3kroD21JT6ALpQV63/wBX1byP+hyGLVzA+0Ds91C4WpABV3VeU/hLSsIGvvKBkRfnOpWk01HXTd4UfISLgArDILt7fGUTtiKeVNzn5ebaTyLTo3D1oPB18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768967083; c=relaxed/simple;
	bh=gw/zexsat64Gv8TuikLKc5mSPf13yohroiifATy58+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlTT8Rnq0SfKrcJcgbVcnitXb9ZpSaPalqwvFImtqhlVeuVrPQsZ0S1wSUIm2Lbsit/MZNL4EY+QZO3R2brfuurWoiSIHDdSKiCQUny5v1zjd4E1OWgi97FMLPOU6jDyg7kmPPnPWuA81tl6uuAugUg/xxuv3c7UmFjNCi0YMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=eDyYG1ya; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="eDyYG1ya"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0a95200e8so40000375ad.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 19:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1768967080; x=1769571880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVyESZuF8vPeJbSMOEnjb9v3b+2mKVyjCwk5OYeVNdg=;
        b=eDyYG1yaTUiWmMfdhg5iTIMytTWaBVR5JiH6uCNlM6g/u3QFqmigWyMMHIzXFo+QQ9
         8sloz1a4/Vz0uaOSp2kjNNQAJOH8lbEpkvVEFB0GN/Vdvh+/yVQ/1E0mnuKHqYkBFZph
         r2NaR7BBmEViT6NvtRRaSAxfAEP4EkwP1k04B0ytxTgU9oxmBfmQrlOSPto+T+J8+er/
         PUykGS/ePPMszMe7UfyR546FPyaGWGBTAQmV3qpVY2oefhBzK9GUWrZScgl+DsUQ1nrK
         +FT3o5RuVmUa9oDDniQO8lgeJjNHaBlm7a0wGo8Fq0hCJjuuV34UKOj8IexBz3buxoYS
         qXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768967080; x=1769571880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVyESZuF8vPeJbSMOEnjb9v3b+2mKVyjCwk5OYeVNdg=;
        b=UUvBHl9rmsHmyAuc44DEe0MwUR4OtIVPaLheSZQiRufToo04K/e2H3jh+YujBs8B0r
         BGQkeUbc5pCixZYSszIR+gaZ0AA8ncrKrChzKD4Vt2XTwoV50f3+ulcRDHZDMsMkMT5u
         KU5yhwnMqs13e8p8iWydz8mjBLhPg3tlyMoTCqehbVuvd9uGLE72nWiOzjAYiDsONDqe
         fX7pLYF3b5+P0SSNnllaKF1elcyuA5LFHzQ595OQJb4PiaDZW4nTrToalSXqlQfZ0Fn3
         x3UrPsccyZOE7vtS49RsSTzItleKZIea5/MdUFJcNvxLKeFVQJtT+C7Wq/XD17OM6/1f
         zT5g==
X-Gm-Message-State: AOJu0YyBNx4vXDIrfXl0i65r1EbWSxMOe96dDvc2V5ZJi/TJCXk32VNj
	LHUf2gXEVd5avyzf1pO5YdROYHAevI4KQy77/Zv3of2bvPPWtHEtseHWVhxrTAMoGwY=
X-Gm-Gg: AZuq6aIpctLmDUDCvIUCChTUen/b+p4KAqDZ7RYTFPLJPJak/D+AxlXAFRJ2OMi2RKZ
	CEZzGeXVqcD7T7AABTFLqPZwaZCUVMAoGe5Cphxkn0v9fq1+odrXRoH1XQy1HK+OoN3lqoc0QD+
	jLiZh+TcSIud80DiCPlE/KofGktkdiNBt/t4le2WNxuHlYcLUurVXF4tt/oI4ZWzGH8cqI9XRvU
	dfaAtbqz1BHtUxiSMOJXC8bE09EmSIaczZWM54+ihHnOUoHUKloJDZbR13bjcy4caqykHWXTil/
	ZihVerFhtdJ4/bdg3jnzKzheCA2f5L17s6JuDHdiuhe02/dipMdvhWsUFxis21GgaO9LR8QsnN6
	T7uGQcNUc4DwDz7zEP6APQKDtPewdFXm9YJqkPaKls/dekdlcrTtfrZL6q740lscYC+50KyYhd1
	YeN7AjZzZA9+wn+Z7wytRydeAv86fdwu7kFmHkOpseb5fMABjlt749SUc=
X-Received: by 2002:a17:903:4b27:b0:2a0:d05c:7de3 with SMTP id d9443c01a7336-2a76923cebemr33428955ad.15.1768967080464;
        Tue, 20 Jan 2026 19:44:40 -0800 (PST)
Received: from [192.168.86.157] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a784af4269sm17959895ad.77.2026.01.20.19.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 19:44:40 -0800 (PST)
Message-ID: <11241110-6bd5-4b06-8d4c-55e52c571ff6@davidwei.uk>
Date: Tue, 20 Jan 2026 19:44:39 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 05/16] net: Proxy net_mp_{open,close}_rxq for
 leased queues
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-6-daniel@iogearbox.net>
 <20260120180402.2b9ab13a@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260120180402.2b9ab13a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-20 18:04, Jakub Kicinski wrote:
> On Thu, 15 Jan 2026 09:25:52 +0100 Daniel Borkmann wrote:
>>   	if (!netdev_need_ops_lock(dev))
>>   		return -EOPNOTSUPP;
>> -
>>   	if (rxq_idx >= dev->real_num_rx_queues) {
>>   		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>>   		return -ERANGE;
>>   	}
>> -	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>>   
>> +	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
> 
> The white space changes here look haphazard.
> 
>> +	rxq = netif_get_rx_queue_lease_locked(&dev, &rxq_idx);
> 
> I really hate this function but I don't have any great suggestion on
> how to make it better. I'd prefer if there was a clear separation
> between the case where we call directly, vs where swapped the queue.
> Instead of replacing pointers passed in by reference :| And that'd
> remove the conditional locking too.

Yeah :/ I will clean up the unnecessary whitespace changes and pull out
the checks at least. The current way makes it easier for the callers as
they don't need to distinguish between direct vs swapped. But, I do
appreciate how awful it feels.

I can try moving netif_get_rx_queue_lease_locked() out into the callers
and see how that feels instead. __net_mp_open_rxq() will then fail for
virtual netdevs.
