Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E90357D1A
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522754; cv=none; b=kBs4gZ02EpqOA3ZIqBtXfN/Tua/GQ7jqgUDtZ1KVLggT0qsI6L2md/KJ63ZdkmOJG53gGz39X2g31JtbW80LfjC8C9ccEUpJIKIVq579AvB7DPnMEyo3r+2JXEmt4DClfrRYxhKQ8rDQel/0WXuhVZn7fQXr3rBwv/J1jXvXBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522754; c=relaxed/simple;
	bh=bEOr01HocXDAqRG+q99yycPHud0SKzNFTdPYQ4BVHps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MigN6Lr7ZcqDTsHeK9Cd2ZijZ61UfKdUjHIBr1bbHUXee972HLys/EcX5e30F7y4OPrMWwy57BI7WxcWY6Gq2GxfnRRPiT811+OtoGnzWgwzN5+VyL6M5zZs4yqJwUyv1Ua9IyukIOv++83rQMuaCuFuJLYL0IHqhfcN5j/0AOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnETKm5m; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnETKm5m"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1712a04ddaso116656466b.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 01:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786522751; x=1787127551; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuiaRqE2K+qZOLkd807fL363LSKM/Mttn0VBtRmG7WY=;
        b=bnETKm5ms8WniZ7sJ7RXWvrUXkLGQx5J4FbrCBXQefSGuExYu5g4QMkEWQRDxhbOfh
         mph1gT+fk5/CLHnxScPKwNbn4CGDUVFMX+Jf6Btnevlg5ie3gjVuf1qUYiv/bYXfSWWN
         sVbygcCGZIEs2KMRl9KqKHe0Plgb4CA2mvu5Eekai7jeCqQC67UlgpI+F+XMt9AnUnzm
         lJrcVzcdozvacyevTopiNXYI7K69yaEU56NkjRFtdeT2gfBiTUEkFj4kRaMGGI7omwvg
         R6z6UI0XC29F5tVMJpc+/1uq9OYpztd6PTd6H8Jpr8qM1VDPP8gIdUqazADqaBqcZT8W
         RMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522751; x=1787127551;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FuiaRqE2K+qZOLkd807fL363LSKM/Mttn0VBtRmG7WY=;
        b=O5OGuUJnZuvT+tKMP/+NwufXduMXLeOg5RnLT8fa2C/DH0IhW8h6w3z4urXd2qOL/k
         509ULTFhkUa3JNN3fGRIXf/t7PFXtOGbNwj9oRh8S0QHCGvHFtAudGtUUy9UDvVPz4j5
         iznox/L+0MNOh5NhmYp/6hxizyQYpFtJWqk+njo7GXPeUGX+O+sSs8I4SqipGjP8qyFy
         B7MJm8wPHxC6/YfKCw/Tx2RHOocEPZZ24KWDAt4vos1jdkOlcUHS6c/Gl6V5UUx9ZkW/
         1napEUrMG1mmaWw4K0wF7h5gJro+vFJ2l1opDpGwFs4qqIq2ELjXRl9yv9L55CA4PK61
         hzZg==
X-Forwarded-Encrypted: i=1; AHgh+RqEa8VUL1iSXi88L1p5a4YPQtS0p1A4sMIP4AWz8faq7pZvKwRgRNP+ZX5X538pB7TTtc0rDuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWrFTeEzfiIaUXeBqflAOOXJNM6E897bGq7SuxZKEQIi1W7PZv
	z5wqvpko4NcLKdesipT/2m6JVaz9gYJQ9OSEP7Gd3ZGnT7idmbF+PpbB
X-Gm-Gg: AR+sD12oHy6h9PPwaZfwoRVzAVhfnZfFTySSuJafRjB88sa+ieNGMLMFRHg19dAqt8G
	ohCFVDQdtCFO3FpLlCaRnfoh4C6knF9+mHpQxK7/vIaU6S1bwja93Sq9kys+lSR1BHzrY+Tq53e
	hA6etJrDHDC/3LWt0hWBEEpPc3tKOVfhA03M4aGYr1XZkyrGs9utTQoZcVwwz7wVQS0zYrd545i
	cxP2OPL84EO0leVHoxfANYzBTqjf0tGoPqPgrhCDBjronvJGMrOL6BysmUXh8LpetGvqRSAw76o
	QHXyYQaViIm3r9Sa00sHqKO9gK7W+3e0agDZ4gHxvc34uLKrycDJ2FfR+oV1QM8D1nBnzrBMQ+2
	of11yfoXhK6LswbIoVkXU5Z/Nmdyydlk46++DHLZYmf5IKS7/PyTt2qk/eDibeBFnd4ECRTlydd
	MJR5zAQIYT5wEjId0im//hFMiI893VhhcwConAabQjX5/5iMuaZqnyBxMsyEthkSrVJL26L5r0B
	YGFj0exmYz0SB4HZw6V3T9VXPwFWFd9ilR9Qvlexigz+j0tpv/cxC7UdzMm1kuVXAsUQ7ffl68e
	56H/cKE9FLV13m1WVTuqL2qBVjUUZIBKHAqZoyp6uH66db0fNFzWZIQmyePPojQZBe9yuCQMD1d
	wDA==
X-Received: by 2002:a17:907:3cc5:b0:c20:191e:89de with SMTP id a640c23a62f3a-c20f301112bmr170570066b.25.1786522750932;
        Wed, 12 Aug 2026 01:19:10 -0700 (PDT)
Received: from [192.168.100.51] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20f0acf633sm62154366b.42.2026.08.12.01.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 01:19:10 -0700 (PDT)
Message-ID: <8a15a6d9-20b0-4fe2-b96e-9b9371eb1831@gmail.com>
Date: Wed, 12 Aug 2026 10:19:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] RDMA/core: Reject unregistering netdevs in
 ib_get_eth_speed
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com,
 syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
References: <20260810133124.44513-1-krystianmkaniewski@gmail.com>
 <20260810113308.5db6937e@kernel.org> <20260810183902.GD507588@ziepe.ca>
 <de87c6a6-44c9-4b78-991b-ff858e21e806@gmail.com>
 <20260811163025.GM544626@ziepe.ca>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <20260811163025.GM544626@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks. I have sent v4 patch rebased on top of for-next branch just a 
moment ago.

On 8/11/2026 6:30 PM, Jason Gunthorpe wrote:
> On Tue, Aug 11, 2026 at 11:21:19AM +0200, Krystian Kaniewski wrote:
>> Thanks for your comments. It's my first contribution really, so I'm still
>> learning on how to do it properly.
>>
>> I'll do the requested changes by both of you.
>>
>> Should I rebase the v4 patch on top of any specific branches for rdma?
>>
>> I found "for-rc" branch while looking at
>> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git, would it be a
>> good target?
> At this point the for-next branch is a better choice
>
> Jason
