Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F363B8921
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775509; cv=none; b=XWasSOEuRsVnauISo1TDdZrXrQRuEjNfRWIgqs8If5E1gjWSgqm0JGNTyWgAgqG9UDZQOUGCti3AJNkSrtHvBsvjWoKeFL/DYxiSldPUG+pzTMNl7MIY/tbLMg+Ufn1Iwe37UaRLHiPYSLPLP8PKIgfJbyBfriCGtKjEqC55IWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775509; c=relaxed/simple;
	bh=yadccA8Y6X6gEhGSsFFXym3WRAST7jhOhkqB+cahZhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njHh9vcAGAVx8WyyQiLMG+CgRXdwXGFx9JWhgmQ6vkSgtREJDZ/YO9A9Kd1ygv4E6wDoIma7AUXtQjITdWsHbdx3gbRfdLmz4gDrPWZOdIIvgeL+u8RJmjbuWak6G8e/IDRlOTtSmkIVsUpYerHayMBkaPQHualtFhn0NlM+PTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=GFkZAIFL; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="GFkZAIFL"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b0dd3e1d0so767675e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1788775506; x=1789380306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MBwNwB4tSi0lfcElavIFKCL9MzO/HTm98YozgmZjyJc=;
        b=GFkZAIFLD68IVeDseu2ktKXQg7BrL2a9DJDtJw8TPAr89K8Vrjozzq4NND0nzWYIpJ
         3nxaPto++nkFMX+PrnEnlAkErz4+TbAhw+wmfzEXKfVvpxymU5o2h5cOQdtkkqZBlJpL
         BDNccYtY2Ptu7RbsU91dR6zSmucuzzo15myQkkWSUvouJZyGOhQnURHU4I5y8azkvQZY
         DPs6fYx0rE1UWitkTJ1HGyT4YSVSCvM/sDvCz8HOcMAFKCLeyAkYuCHU4KjWhReXSd24
         ZCtaCH8KoZ3cJ33A3i2xe+Gcum39dfSccb52fWKcdaH0KGLTXvWJGqkkAZQRAwfj6La2
         aBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788775506; x=1789380306;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MBwNwB4tSi0lfcElavIFKCL9MzO/HTm98YozgmZjyJc=;
        b=bj3E3366QTPav5Vb4qwg/1knb9hFAMYD3tQay23eBHgNSv0CyxROl+q1kGdqd+tFUr
         6FQAwTcxYJrJOOFB/OcecnOLKt4vLlJzVt4G8KeLY4Ruy+MPCKWfGOi7iSf1YeY8T77k
         ICtPeYgQoVasNRJKlXQEz0PqYJcNwDAagaNrZD9f1qXJgLc7XgP/0Jzslua93p3nslsI
         TFTH9QOwP85ueJ6+j/gzYu14M460eZzN7bnpmiIxtUVChq1SBbiPhvenGPY2xp/7rXXn
         oho2ekE43pE5Lan3cHwxNud8JRKsS27GDJmqOF9BjASF/S1uomUUQ3mI0Ifqb8sqUT/A
         6ZVw==
X-Gm-Message-State: AFuF++lvpxNAGA1SsXubM0thYlv282Izj3/0ooml4RyWsfvRJj4EXtK6
	fRJNKOtJWWZ04Ud0yjSwLeyDabhXkrsc0FdXroD0f+ioc8qjG4e1be+lBhw7B2pKBfY=
X-Gm-Gg: AYBFou1t2vJ9Gd6ugYQIXOcrckZGii5oh3jUoapNReNN+tjbjs2k5IEPcfUvCkRh4Wg
	sDnzWDcuS8jA6U+5ddyUZc0wBc2J1glyihI61rVjIGmC8xaA/M2TN0IyXX1bvs5NnYu/S9c+xxG
	JmgGoRjfwp01fDTmlwpmNyN5CKgv22xTwaGHLCMXiFfXcmpVOJo0SMUjgO0P84EjLvKii6+S0gN
	8bebmJpOTUtgaQjRQ7in0FJQcoRF7guoim0VPxdIBJC4X+4rpCuH6C2rZtrdDLjpzLZxPKMbELz
	wcdUDnxSOModp5PblfJD+VbJ8A5WfRL+d9pRgpZ53wiXjqNyW3LOLIZJLrIgAJIztekEpfV8Kuz
	ArpAebOoXyLReT5lNLtc7Y8CTuI2DfcB8CHECSlQn9agi3/r2NswcYhvFt/qAu8kB4N+o3O9ioh
	DkcACljUlId6uEYX6qBMagui8gZqOR0X8GzpFTTqKY8lensrZ44FWIG6UJDgo4NyOWs473qKBmy
	lpiN0CyRf0n7rPrG/jxIYWeoIRHQGfn3Po4QB11Zw==
X-Received: by 2002:a05:600c:860b:b0:49c:f9b8:bae0 with SMTP id 5b1f17b1804b1-49d01dd6b62mr111886625e9.2.1788775505887;
        Mon, 07 Sep 2026 03:05:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d00031c95sm258895095e9.11.2026.09.07.03.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 03:05:05 -0700 (PDT)
Message-ID: <db69500b-3ac4-4ab2-8b1e-21cabb3649d8@6wind.com>
Date: Mon, 7 Sep 2026 12:05:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next 2/3] netlink: specs: fou: local-v4 and peer-v4
 are big endian
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 kuniyu@google.com
References: <20260904191412.3872344-1-kuba@kernel.org>
 <20260904191412.3872344-3-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260904191412.3872344-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 04/09/2026 à 21:14, Jakub Kicinski a écrit :
> fou_core.c uses nla_get_in_addr() / nla_put_in_addr() on both, i.e.
> they are __be32, and port / peer-port in the same spec are already
> annotated. Without byte-order YNL swaps them on little endian hosts.
> 
> The generated policy goes from NLA_U32 to NLA_BE32, which changes
> nothing: lib/nlattr.c gives the two the same length in nla_attr_len[]
> and the same range handling, and neither attribute has a range check.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
