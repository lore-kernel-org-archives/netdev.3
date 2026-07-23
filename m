Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E920A5C4
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826927; cv=none; b=TA/+wNdzGIILhHcKBjkcpo5W4jgz96/tBT7gQjAsdazW0fS2yKL7zRTXBEQVRE5m8tV5DqkSxxZVFDO2amEj2f9PZUwxoyYwKT/izYXXKFaQgRlAaQlgNcO4MkCGiOOX/8qTGnKtGJULPxhnyT7LCY7gitU4FSEDH8WwZWq+k4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826927; c=relaxed/simple;
	bh=Ee6YIU2DsopfzroTgVEmyK2G1S+RiwdIefKeawvDtNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgVHrKEWJpRRnmGDcV7xqawdI5rQonlfsYf2lQO565r5EsiJPQbF6LIq2IoSzzhLKvBsWOKvPnoV0NuaBuE8PrYfXq5hIJn2TPTzk+WOvapF0fj/nf5wfD0sv/P/YVfBtbrMTszEiHmOlNte6E8RZAN/Rihy10Ra/EpeI98qZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdmXhkv6; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdmXhkv6"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2cf452def93so6189595ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 10:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784826925; x=1785431725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ee6YIU2DsopfzroTgVEmyK2G1S+RiwdIefKeawvDtNY=;
        b=EdmXhkv6YJYiO8iGA8XTSUTNNV63HeRZ5xFlun2Q5xBVAMjvtkqFzVGMZ8k1z5aUqf
         6k6Hs6HwxjxYrH5ZTRBWzKkQeTON9uEbBVKKXShcXO4Nm3k5XqGJz/eh45m1CIpWSc6Z
         M+rDV73WAQDCpQwYcNiHv1+74Cz9f4NU9++j/3qlyQAT9X2YTr7C2NEhyRFo1feZhhbD
         j6m2QNPhEY45AnGLeVz3tGTj5EXAndOw+XZzPHeHBU+FV+xzo8ryosKwyaTtvTwQUhN9
         r/PgjkCaV2YUU8c4Zq7Z7laPoHoavxTkRjaesPb7p+Lmf/TH+/5vpj4l0iB+nI2pOuCj
         8btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784826925; x=1785431725;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ee6YIU2DsopfzroTgVEmyK2G1S+RiwdIefKeawvDtNY=;
        b=niPxq9wSUPyvolVLrjmFZfoRy0mLOhUnCgVXRtENlz/UPGi3QZNAZ0gETVOS39cn5d
         P18OZq8+s4zVup5FAMRTZN+LK7/q3Oq3cKRIeBHqMOYG6tgg6XweaiAxBRhABqxuOx+b
         9P/8vk/CYOYGTCcuoFeka2x5/OS4BdKEk9zZMyzsherHp8f16ckadUb7Nww8Wzux89St
         vRMrJoSie5tISB1yjmxIMc4rwS6AYLmaWQczgMX+PpGhWE/G1YEGTO5luYIuIKwI9uUO
         w9h1latv2c7gXP3dpq1OZnDtI5Cwf1zLalwNzHACQGLpIgqJFZq8IIUT8ysxRLGhQ8Bf
         LH5A==
X-Forwarded-Encrypted: i=1; AHgh+RotvZYFRL68cdg5FqF7SGf0+aeDNDiLrInskeEDO0NGiLMFmZTejcOwBZsKuPNbjpcSKExU+K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTiI9doQrqq3SavfW2fLtdgQUg9wt3DERSzH0aukwlk75R56e
	oHf54r5ZjlrcnMILw/50PSXriDN3p3oYphNpOqNmTsODIanNDnHjcSz3
X-Gm-Gg: AR+sD133nHHG7Pe5T+LDZt2XhMiFVM3Qy3Lus0Qn/AURkEDjTUPYp/uI0y17G1HtLdE
	Yflxa/ZDBgxcC5Kviz4t8yCiNAX29M6xlFgAQmCeAe0RYee7mnpPkJLRvyXiqmemet1vEiP2O1U
	aHYAR3ODoSgbBPwrUGDe3ISVJVKsxbHA9H61mYAAXmZ8Evh6ID7a/6K8lZYj2MrRH6ucjn3XYV8
	bOXPlCH5rTdbEltiM8f8zQqJ/oyev/nlUqi0N0WREi+WP7RD+n4ZUNcdDnrP9X0WExyX4FSpg9R
	E6JHd5lCuI281b+8ZQpBbHMbf3kENIlzq8O1RiARvZbNsFShEPFtwTP0eSGwkx8Qo5mhvqH/MPq
	qd2biG1bWlCMJfnz+lM5FkGwKwrriSGrdIleFBUjleQmkiN6Ve0yak0w+vYYrm91KVYbj8PPXIQ
	Z8B3PnaA==
X-Received: by 2002:a17:903:3c4f:b0:2bd:2c3a:2a36 with SMTP id d9443c01a7336-2cfa91afa22mr36738945ad.0.1784826924966;
        Thu, 23 Jul 2026 10:15:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfa57542e0sm19075315ad.67.2026.07.23.10.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:15:23 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:14:08 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Cen Zhang <blbllhy@gmail.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	magnus.karlsson@intel.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, sdf@fomichev.me, horms@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net v2] xsk: reject undersized tx_metadata at runtime
 validation
Message-ID: <amJL1sP8pQb7dPsO@devvm7509.cco0.facebook.com>
References: <20260722041326.75199-1-blbllhy@gmail.com>
 <amEBJTKhUJHaAsBG@devvm7509.cco0.facebook.com>
 <amHuIvHN1zY4wYpt@boxer>
 <CAB8m9WjDoHb67ixPVs=6XgFfGP2D4kqM_SSUj5as=xegF63NMQ@mail.gmail.com>
 <amIGs3ek+0vOp5cd@boxer>
 <CAB8m9WjVdbq4Nr4poHZ6nP761rSFS8sQ=rYe1PNyEjS_u5sNtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8m9WjVdbq4Nr4poHZ6nP761rSFS8sQ=rYe1PNyEjS_u5sNtQ@mail.gmail.com>

On 07/23, Cen Zhang wrote:
> Not at all! Thanks for both your suggestion and Stanislav's rewrite!

SG, I can take it over..
