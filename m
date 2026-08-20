Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83F039769B
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787251354; cv=none; b=AQMwvN83IQ4a2v8k6EjRfvhyX4ISodShiM10JM3x1/2ru7MTCDOAmi8d8C9d06+iy6O4V+A+n3SUC29cdB4VuraLWRjQQPbfh1eA7ueTHsa6zewQ7MQa1f4Uz31AnXP2e0LsLbTCKMaJ477NpO2i/TVjoaaNvX1j4n4B2a1Nh5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787251354; c=relaxed/simple;
	bh=SYX+JlrGNTDEXjKAoWcQL6ELgpKDbWRqmiR8KoABcNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kjvlV92Cw7BRBDH390/hnA2+p8dIEoiSba7bVxScPAI8qFYs0Wbcg7VI+SEcSNT4iVXkB6eOiFUUshbgMKQQ2fgRwDhmNVres0APif8WbZ+GT/9glbPTbSdiTgjBQjajmj5geO51KeIH3gx1fAJMap0f0QCEyFQO4vSQiVMuR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EFoC2iyL; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EFoC2iyL"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso129726a91.3
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787251352; x=1787856152;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fEKZKwe8xin78Zky0TWTYOaM5koa7MSpaMH+Oal8e4c=;
        b=m043ISoBLGPBgK/QJxI0xZKNnJHfDV379R1+2ou5bbdQl2joDBGOLV+EHt69LCnc5X
         q3iYgkgx3r4xdNYkyZ4NJfZGSeVVAAH0f0ig7iUVsRTrYZXN1l5Hb3hXjNjaHLimqd8N
         0PhdidNQ0WXoMdOwDpkcS93aAqvCZXfKuYdYzd0qt5h0YMJPW6MzIZvYoDVJ4+nfqKKC
         yai9yCghp4AQvzTC73lrwupiJDICRGWcNODzP8jomR3FuvXcZ2+raFUNzKw/IE1xWELa
         WJYz1lpmRY4qxYw8YiT7iMChTvBJe4yBF0s/ucZb3kx4H/LZNX3QBGQIHyuU+wVfHmDi
         V3kw==
X-Forwarded-Encrypted: i=1; AHgh+RrUBEWZR3deo3cA3Wz3Ylqw3zL0vOGKpDGHjIzJo9goWRIf0f955ncF55TeqzJGUf5HjTvtdjI=@vger.kernel.org
X-Gm-Message-State: AFuF++nmFYtKOsDyGb6Oj9I5lRUuJAJjhrwR9TYp66Io6ELMVxo/7TAY
	CmTeNNXWzEd3Nhy2hLgZyqmyfIrk8xUFGmu3GAItpNKriG5CzUUsul1t3qna01HBkyrw9R3DqMT
	rtDfVJoqWET0R37QPLVGgeLlXkBnFY6S4clGHBLbGe2XLllc6AJaIkfEEeKjgEd4TMycPJjy8PU
	DOtpJychd/Xz6y9tLlz9cBaY2VOwGSPuGGF8/fWtFHQ/MifmlTpqpaUCzBnLB7UKoN3kr9odbG0
	QoQPUrSbw==
X-Gm-Gg: AR+sD13OwnxLmWaXxLsY3jXvx4hZIwuEAyP6MmAwcd7P66tef4Jh+ov7EC9QPPPg5lY
	K13z05EQ0FbWHNk9fwXGdiVlCd3x63AgMEdgeFUtOJl9pYds3beGM+qB3aeoT8ejyAY+NM5hs4A
	pnOk7jVTvoskOMezbsJt0X0lA9a4KOAR881NR6t6agoAzdLAG/dlggUMHYomXBj1PslrNFwxO1W
	KaH2e1cF9b9ceqL9Se0AyAG4LpwtnQAci62tv50UVjC5X2uAVC/khArrza2eJECgbXnKPjh7ODJ
	/5gMhbhYRMOw+0OykGUydepgNoBG2q2RNoXKTYJY4Bc3OkxEzDDkuOfC7x1Qfg0BnoH4N1SdYn2
	CiX9dbeShfft/AJ/V8GZGqm1wrxlkeSZWmJusMwg7ynVUNiGdJrVzDjXwWVqQyy43PlWOs0Knkn
	KXSHeptDFFChcFzaRRrdGe60onnF4EQ+3vfw==
X-Received: by 2002:a17:90b:4c8e:b0:38d:fda6:4873 with SMTP id 98e67ed59e1d1-395c352aee9mr926388a91.10.1787251351876;
        Thu, 20 Aug 2026 11:42:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-1416ac220b5sm467904c88.5.2026.08.20.11.42.31
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2026 11:42:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90410c668adso2376786d6.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 11:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787251350; x=1787856150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fEKZKwe8xin78Zky0TWTYOaM5koa7MSpaMH+Oal8e4c=;
        b=EFoC2iyLRY7Bk+U7ReY85lzmeomUvwoHMvQyrFNL30fy1lIx3OYvUIVIH3OGhvZs4n
         /mMbn8ql7H/+danzRE+GtcTDOHu1DVRdXXiFV9nk3DowLxH8ppCNIZAm5VEQofovwVKn
         bKJFsnXf8ysU0RmDn2eAqXOnKxfld0YIkQKgU=
X-Forwarded-Encrypted: i=1; AHgh+Rq6tQ+nkjksbGFPgcBnTsQV/V+o2tcJ/IG78xNgLFx/z+vbWPMjAlSPS+QUJOtOjzc8CUygyrc=@vger.kernel.org
X-Received: by 2002:a05:6214:124d:b0:8ee:5e59:7b04 with SMTP id 6a1803df08f44-90c80e00b57mr2004766d6.18.1787251350417;
        Thu, 20 Aug 2026 11:42:30 -0700 (PDT)
X-Received: by 2002:a05:6214:124d:b0:8ee:5e59:7b04 with SMTP id 6a1803df08f44-90c80e00b57mr2003896d6.18.1787251349742;
        Thu, 20 Aug 2026 11:42:29 -0700 (PDT)
Received: from [10.69.70.219] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2906afsm44099346d6.25.2026.08.20.11.42.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 11:42:29 -0700 (PDT)
Message-ID: <1958a140-a3ff-4f0c-8982-9695d1dbd8a1@broadcom.com>
Date: Thu, 20 Aug 2026 11:42:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] net: broadcom: Improve IRQ error handling
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 Paolo Abeni <pabeni@redhat.com>, phucduc.bui@gmail.com,
 Doug Berger <opendmb@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260820111456.97947-1-phucduc.bui@gmail.com>
 <a618bdba-c370-4f16-ac09-0f7ceb742d42@redhat.com>
 <cc18ef57-4f5b-4459-b110-b29bf2c8b8eb@broadcom.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <cc18ef57-4f5b-4459-b110-b29bf2c8b8eb@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 8/20/26 9:45 AM, Florian Fainelli wrote:
> On 8/20/26 06:30, Paolo Abeni wrote:
>> On 8/20/26 1:14 PM, phucduc.bui@gmail.com wrote:
>>> From: bui duc phuc <phucduc.bui@gmail.com>
>>>
>>> Hi all,
>>>
>>> This series improves IRQ error handling in several Broadcom Ethernet
>>> drivers by propagating IRQ lookup and request errors instead of
>>> silently ignoring them.
>>>
>>> The changes were found by manual code inspection and compile-tested
>>> only.
>> ## Form letter - net-next-closed
>>
>> We have already submitted our pull request with net-next material for 
>> v7.3,
>> and therefore net-next is closed for new drivers, features, code 
>> refactoring
>> and optimizations. We are currently accepting bug fixes only.
>>
>> Please repost when net-next reopens after Aug 31st.
>>
>> RFC patches sent for review only are obviously welcome at any time.
>>
>> See: https://www.kernel.org/doc/html/next/process/maintainer- 
>> netdev.html#development-cycle
>>
> 
> Not seeing much value in these patches, to be honest.

Agreed. I prefer the current behavior. Even if the optional WoL IRQ 
exist, but fails to initialize correctly, the rest of the network 
functions will still work. No need to take down everything in this case.

Thanks,
Justin

