Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDE64CB8A0
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789019; cv=none; b=VkG3IaM2jAsP7454C4hl4nKw5TBq/2j25sfsfIEE6aKQ3YgZBNoNnxcavgHHmQmdUKc9bhZQu1jnK3g04kWG4im3OL63ntqFtbtaCFWVXJA/XtfJI1cwI710nVDfHfhtuRK2GNc2tuZbmDt2Ybh36ip1t11m8e63eMHccs1CeBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789019; c=relaxed/simple;
	bh=gt9uyYj4GZqB2F/RxjOPyyNBlfGZg0cQlhP3q3hNeyY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l9QnxqbjYBtVbf01CQR+hoxQNrn/yACn8Jyqo0v4YuEdZZZyY7Bs+mLDfEo6zRcXz9vVlAR/SvnTqiARGmbOtqa6NxekVpcxOCXfu2FfWEu/++D/CpSufDqjwl03x0Z62en7lirrPX1Z4mkR1M7WVMj9wSQB1i6pBYugk8ZrLAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=b/YVRnUS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="b/YVRnUS"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso33832665e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788789015; x=1789393815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HIF6gPEve0xVQ8D+U1UpgzUc5DE7tim1x6TuIJ198zc=;
        b=b/YVRnUSX2y9vKAbWAuWyKOzhQ+CwxFE0xisOUxMoSchsIJdGA6/YoKFkTlwW7OSX4
         Vclc/fr/uGe0wsyNC3lf8zqYtkJ+hh4NzfZRCuyjS8aYoG4RHik7N7Jpv3S5NYMvTgy6
         6bRFwdZx3P8lhAehqmr5g1PavuD5ITgdLY0KQeA5lzVCoELCLefPnv9DiGZ75oUjD1FE
         SnZ/qbHh9Ucnjo1DN3X8XjTe+hTORKCspwYgA4r1+2jqMhiSW6PWz4okFDIqjSEI6BlY
         lPhswKhAyfLEi40lmV/yI2kKTzwM90VusGBv1CkePxOpvpXlNk4hvDFpBJEy2wGCAxXy
         fY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788789015; x=1789393815;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HIF6gPEve0xVQ8D+U1UpgzUc5DE7tim1x6TuIJ198zc=;
        b=GE1xMnUDy86RC9SotvWsfCiA+a+8JwQasoDWVXJp/VN+yuiRilcoYLXUVOmE6KxgsH
         NWDT6RbkBozopt+7Pw18aDXq7Hzkaf+En4eYH/HHU8rf48yRve11c9i8dGRfHsEGG9xj
         DEzNRWV3lE8sXZBb37oRjZksKJo6ghFj5jBOLdpgBNltl1LzZZo4gOc+DZGzQGlyUxtS
         DzQQvtPmvfIgw2x5CZSLbKCOP8YZxeDJwfEUMh0w39HYjZnQj3dP/TMFYYr+fOF47Ilg
         sHaYoh2p1m3Tyni3C/SXm13eNHfj+FITzj8WVwNNUwQOdhsrvCyPqXVbUtGLmj5WBByr
         B0TA==
X-Gm-Message-State: AFuF++nwI/7aaX2cckaHrOx0biDNQnHuAjhtRflCBDhgwmY9TKmHwC71
	K8HRVkGF7UNw8TO6RsmEBeSzuGiRlt4BuF4LD29aIQmMJItXZRSmpgAvq39kQ5zYVlWACvxLSTP
	yqbzjtE8=
X-Gm-Gg: AYBFou38e+K+97J8fmfpMCDvTZBXy7jds/i/EnxvGICKLy2OIclEiZPWhSSbE/vONzO
	RJZKwBVytL9S/9FN3By9zzk6JI7dl6Zf7qnz1I+l0LboTOOiOHN+lRndQEHZRK5NHGAIroRg6yE
	kBThT4/kCs5DznUllwc8wuHPgD3Ck7HdEa1vFsY5soIjWp+g2KX9exhKaSNflO2VzCrX/wT45cy
	/oAD4Br+A5ueNDBR48o72Rdb0EyoDq3jAGGFEecqT0nuYjNATZzRxoxnmMr7g+p21B7MzeWevWK
	0s0kDnIRALD5ealS5Fu+NcvYTKBsbIxO5QiaWm+Ci5igUPXDKjiVWsHMVL2qzV2sJBKTGN7e3uj
	21cbEBlGXVz0rYgS7GzYucQ3GicBVLI8RCr7HDOBQc+Ff3Nl+fAnhKp2M+O05JLCti5axWIrHGv
	GrRPrqkxwIgXk4ogBPohKyyrSVDU6WhYxl7EX7327kmF2Gf0p4F7U++MjnjCJZp6xeb5ZkTNhtu
	caLFxDBb2+v0Ct8Ur8=
X-Received: by 2002:a05:600c:a4f:b0:49c:f13d:ffe8 with SMTP id 5b1f17b1804b1-49cf13e05acmr274813835e9.12.1788789015091;
        Mon, 07 Sep 2026 06:50:15 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883a9b49sm24459531f8f.17.2026.09.07.06.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 06:50:14 -0700 (PDT)
Message-ID: <c30bdd74-d655-4e6f-a13b-ef55285b705e@blackwall.org>
Date: Mon, 7 Sep 2026 16:50:13 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bridge: bound the port VLAN lists in the
 IFLA_AF_SPEC nest
Content-Language: en-US, bg
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Artem Lytkin <iprintercanon@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev,
 Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, "David S. Miller" <davem@davemloft.net>
References: <20260906224246.21719-1-iprintercanon@gmail.com>
 <ba2dcdb6-923d-4fc1-9c92-7a77c0b61a09@blackwall.org>
 <20260907133505.5291-1-iprintercanon@gmail.com>
 <76e98b59-9371-4700-92bf-20e41aaf0210@blackwall.org>
In-Reply-To: <76e98b59-9371-4700-92bf-20e41aaf0210@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/09/2026 16:46, Nikolay Aleksandrov wrote:
> On 07/09/2026 16:35, Artem Lytkin wrote:
>> On Mon, Sep 07, 2026 at 11:47:24AM +0300, Nikolay Aleksandrov wrote:
>>> I prefer a more explicit path - return error for both (RTM_GETLINK and notifications)
>>> you'll have to plumb down extack but then user-space will know there are too many objects or lost
>>> RTNL_LINK notifications and it should resync (e.g. use RTM_GETVLAN to dump the vlans if needed).
>>
>> OK, v2 will do that: br_fill_ifinfo() fails with -E2BIG once the nest
>> would pass 65535, kept distinct from -EMSGSIZE so the WARN_ON in
>> br_info_notify() still means what it means today and the error goes to
>> rtnl_set_sk_err(). For the dump, rtnl_bridge_getlink() can turn -E2BIG
>> into the extack message itself, which keeps ndo_bridge_getlink() as it
>> is; or do you want extack plumbed through the ndo? The size clamp and
>> the doc text go away.
>>
>> Artem
> 
> I'd prefer to plumb down the extack so the bridge can set it itself and be specific
> if needed. Others might want to fill it with something different, there are only
> a few drivers that implement it and some may decide to return user-friendly errors.
> Please make sure to split the patches well, don't do everything in a single patch.
> 
> Thanks,
>   Nik
> 

And to be more explicit - please don't add so much llm slop to the commit messages,
this can be explained clearly and much more concisely.
