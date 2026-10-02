Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFEA3DE45A
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971202; cv=none; b=f/pytf7AQyZtODjuHRGkOWZLoCY1uqiEvh30IM3RpnRVzkGyQC0IiTsE4togKs4tC+3TQhoAER4mKuBHhSy00kaiob+hG0K4eiebl63iDmcfKUYp7H/sGCJg7pdy4hKM2TB309gUscKh3XGACf38G8c0Iv4OGwo+kfJBGxolkwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971202; c=relaxed/simple;
	bh=bdiQLzVnx2a+F/wPqBLr4YiITMZ5yz7T1A6LJ/0pfnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCFckjWNb5v/GyGMQ40mJp2ThyURWkEmblnB8xk8cBb+b5EcHX5UloLp7VQ8eoGlG04crf1PNeCk6J7faV2/7rXoV3G6VYbY2evcLvgGFy7+Nj1HIak/Rtwr/rZ0+LurOTuFEVztrmfoYQ8wpFp7eileb0TB69dUqwQU7NwCCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=XdSvubHQ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="XdSvubHQ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a022e9cbebso2079435e9.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1790971199; x=1791575999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tdi1g/9HctPzl2xgKw5LeRr2kShiiRFjAD27/Ur/UmA=;
        b=XdSvubHQzom8p6N6XmTFrMClUPZsUpbbNToM8tR0eXsOCaL3I+AYI7Dnmdthx6LI/k
         D9iCu4OuJfd0KO0P9MGJPosvXjSIM9JqqSqluCcUs5tpGcRov/v9UOQAcGsOZ96np5MG
         g1jAiW+roNlvCChYvaRrQZUUc/Q+2rMC1Ny6ZETTsHL9CCdW31PuiYD5juPP68aFZVwL
         eTbyNaDoV1sIMQDMOx7Y/Poqx1oVHw8R3Tb/B6UOBEvGdPevHIbTMn7QiKSsaPiuBe+B
         XaP3drGIbToZEU2SvQ56+yaV32GEzk/ZT+fIH2N5pVES1iTGudej5NcISfBLZpBemYv9
         ZJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790971199; x=1791575999;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tdi1g/9HctPzl2xgKw5LeRr2kShiiRFjAD27/Ur/UmA=;
        b=WpbrMNe2z0MLV/O5xsEw1jpLIOLdPgQzQyc7V20kX2R1UtDyI6Os7QHhIFTWsbMK07
         u6GpMTb5ZkipDYfhDFotmky49YQqSwpZGamDK9qbxMU9MmhUVbemryfTuHgdaq67qZvn
         rFG5MVVYkx54KlN0yQLzBlQsHO2syOj9rJnHC+0peY7JcXV2k0qBlh4xyV+cuHU04i2r
         OpeUbLtIv4HORqmiJBboWCr4s9AYdffwUsF2b8jHWzhfw/8HobhClIwBiUB5Yz+3NuxK
         6QyYLlM3KXSpbPIb81a95qBjOQK667scQdGeLCfw1wnGfFz8GRLfP3pShHdAqMimlUHM
         CCvA==
X-Forwarded-Encrypted: i=1; AKwUvBz4dHNGgG9n+hzifbYNI8xDl6vg712rYIFdJQZ+tpdZxkesFzEcu/PEHoZtYp03N4upSu6t2qM=@vger.kernel.org
X-Gm-Message-State: AFuF++mP1MG3zFJUh5SsLuYH2iAXOaJ2zJwA8PfIURTUsiuTkgWKHtgY
	IGFEIWRRsiAIs/tEP6CrpGfF3ydoOl0xtBe56/9ov/ht9EObSEUjZUkUtIsjEr+pPT4bH/Eu1MT
	M/zM1
X-Gm-Gg: AYBFou3qtGFOKDaCgFaAzmp5ip6R8jdyGxrLwPYctNECbjI9fHA8UFBikEmSpNbkvJg
	wTnVG2EFPyKIdBZ7u1ci0x5xmcKHD7gGdcLN8OVLCokHoX2CCwbBwrLsXy3lXsNySjXNlupuWmK
	uT/a0HNM43ZrnVEVhCEbX5F3jzRTGkWfNrJkOdKexpRJxb9Gi9hsMO0VLolJNPKvoZggdQhI/wW
	ve290At1tXIeP7uNK5dU9xDyCxjztIVKDGjr7tV/QYmwtyY8e9TbF/63hFmfsx7KDzq0HAja4i/
	3pOVXdJewe6SCyjXH8Cls3fcdyTNRdfsY7rRPfnojjSaw6v7fNgw+t3Zw8IzfPJV+x+nlZw0Ace
	ti8X2HRj8rLCl6/kqK1XzJlHhPvPy0b0yoEUv3qCTGXz9+fBj+rTkkqaXSNmvk7trMB4AkC7ZBa
	r/IoFooXw0xOHFXFzF3w6P0apTBw3N1WFOO0PLOrZKCUPvBZVZXrBXdlifsrFClNtS4RTUCMTue
	Yr5UuuMXn6EFOSWjebrXtdViWD9cg==
X-Received: by 2002:a05:600c:548c:b0:4a0:1eb1:133b with SMTP id 5b1f17b1804b1-4a0275599aamr64108765e9.12.1790971198949;
        Fri, 02 Oct 2026 12:59:58 -0700 (PDT)
Received: from [192.168.0.161] (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a039505568sm92985945e9.3.2026.10.02.12.59.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 12:59:58 -0700 (PDT)
Message-ID: <29eac8d5-4b2a-4f34-8792-76eecaefa184@blackwall.org>
Date: Fri, 2 Oct 2026 22:59:57 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 08/12] net: bridge: vlan: quiesce readers before
 freeing port VLANs
Content-Language: en-US, bg
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, bridge@lists.linux.dev
References: <20260930071411.2786201-9-razor@blackwall.org>
 <179085595119.434549.4421493167752460988@kernel.org>
 <f529d8a9-a4ab-4398-8754-d6c7528133c7@blackwall.org>
 <20261002125005.15b6b56e@kernel.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20261002125005.15b6b56e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/2026 22:50, Jakub Kicinski wrote:
> On Thu, 1 Oct 2026 15:07:21 +0300 Nikolay Aleksandrov wrote:
>> - Yes, they can be batched and I had them batched initially but when
>>    I ran my tests I didn't notice any problems deleting a full VLAN
>>    range. It took 79ms on my host to delete 4k VLANs. As I've stated in
>>    my cover letter - the complexity is not worth it, so I dropped that
>>    patch.
> 
> For the 79ms number - how big was the system and was it busy?

It was a VM with 3 vCPUs, not load. The baseline (without patches) was ~25% faster.
This is still a slow path and deleting 4k VLANs is not a common thing. :)

Note that flushing all VLANs usually happens when a port is being deleted and
that is still fast as before (it doesn't wait a gp for every VLAN).


