Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150D149EC78
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141720; cv=none; b=YNhEyaznLEHubgsRnIDBcPrpL0b6PYR8BW/p/DiBSqhTH6HK/quxbffb/HnseAhTNyGEswYjfENHVtJwMX68g9FIvcT51lfbS8jtxbou7X/qHOi9yE2foAzkXYP6f1rfGXpoHqHSxJEW7WIM91huwTT1ZEmOFAjJVstD0waIhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141720; c=relaxed/simple;
	bh=coqt+w5I95EUW0QDTkx+JS5InZ9evmeQaO462+T+Peo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOCKZX+TrpYDlAeXaR5sL6MsBSYpC34G8unAtwbns+ESKv1XMTM5LGOzvmnjDguimMz/IxyT1GKfJ2RzBH9J+odkPPfzZ7UH6x6GtMkDXz/eDwLMIaOe5dyt5y5wMNKfD+DKXC8JdXQw3buPolXvxO5jojIMEz4fGzAh5TjEM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=TNs+v4+F; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="TNs+v4+F"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cfbdac7a1so43195e9.1
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1789141716; x=1789746516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=peYwW1i7KqZv9dHnFVZzcAAAiTdfB8U1dCo82QTWVsw=;
        b=TNs+v4+FjTdJPRl5CxDWGEM74SsZpTJ6QB4C3w+hTqCvDjoniuZOt+76f9MK8yz7uz
         rxB2BSLBH2nLFs/k5iU4WkIfXDHhl1SAIVM66tZFqBuS+sQGqregc0ePtyyr5igaMPfs
         Oq6EymrlFMsL5CgXLtNe1wFrRuC9HsBbDK2Qp5o7dUMKXBQRi55CIR+unxzwB79nyLWB
         LYPHS2iXI9c16JP5ULteH/k2UuwMRz1R1FVg7qdj9VnBemcIx8O6PTq/mY3md+4Bs4Lg
         5XM+HsBc/V4TA7IU/p4QVd2VgkkVpCazpEikkSWRm1BXa4Xq0MAucgy4TjBaD8V3OFfn
         a1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141716; x=1789746516;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=peYwW1i7KqZv9dHnFVZzcAAAiTdfB8U1dCo82QTWVsw=;
        b=aWZ8Num2vDqNuVoWuhG3T3BtmC9u7qfwfqZaMHTHglgp2WE+dWI17RB1T8F1qJflE4
         +JpDLPBBuzLtXOFBw0cAnoEKKv2TbsRZebKbAmDUTxEZJmcf7p+RmaFsCOx8AxjdrRZo
         5xJFWnLD3Jdl2rOFTzLvC2zB+QdtvfGwbXvBod9KwBoM6ft/1KOMQYkLZPSAbuPudmqk
         r5x1zTTlkhzwthSKQYvZrAPnk1x64b6tStqIuQ5yYzGHugzvscg4A3hbYif6yiT0sWV1
         +uVQTixrieVjelwqyPtkH42J1BGbANMVku2RQConGAD58tgNhasZYRZMST5ffGaUbfo4
         gjQg==
X-Forwarded-Encrypted: i=1; AKwUvBx/wxduKdt75L1/yi0cnXp3Q4EfuxVsz4RkqsGF22SaGozUR0NBronGhD6oOcFapjSkvwTPmZw=@vger.kernel.org
X-Gm-Message-State: AFuF++lnBiK7ZzgHy6dNfN2n+GNwh2/ErtkXu5UyOlQgS55BxWUeceR0
	vlS0DImEqBzT5139hKd7tKkgDhpvZ6tpfaOQzO4jQFeGPkOSyb8LwdH260FABu54oXo=
X-Gm-Gg: AYBFou29TW1TiN14Int1Yw8b0zAJG+88k1vParEgPyb2hfM3PxeYpwFVBAE31Q31Rt3
	TXe1lbwR3uGlxtad2uDePpSDipVHCcnJrwqOxdv8lFZkynxMIcsAap/0Vxf7g/nauFt5xoQd+zc
	2Lw5EgKkQ9Q2ogdfsIMhaMSbswM6N1s5/2BNj73q95S05zGhHWFRCjIr3U8hMEVv4Pxgqd61Wpu
	gdpV/mi7rEL9ZRug0y8hSH04e1d2Wyb7ruZYndaYypBenAQeEd/IcoiRAT1hHSnuShrjPb+d96b
	3o2OVOF6j8jxsZoLO4v4w6nWOHe3+QqY+vaeLk9gLJsuN9dzYpV62bntLy6GslCZWZIOsSIu+2w
	TjsWl8gtOMsUPcLQsmEtjed/ngt24dRFNrgCJSPYZgGjdM4xlLpVisMAVdrK3LkYpRjyOzaFdL7
	KPyXqCWvosk1Yg28bke7QdMXdVsDwiwInUb6EucFi4S8KJRpf/V1PxjjNwgteBz8QY7ktG6iJCo
	egG+bvqHYr7fUpdMl69fQvR6TtmK7jTeJ346RMKu4b2/WFtR8BTx5V/Q9v18TH5
X-Received: by 2002:a05:600c:1c29:b0:49b:9241:7ff0 with SMTP id 5b1f17b1804b1-49e61d2e5b7mr48659495e9.0.1789141716242;
        Fri, 11 Sep 2026 08:48:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6af095d7sm3509035e9.0.2026.09.11.08.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:48:35 -0700 (PDT)
Message-ID: <15c10d97-6b05-4ff7-81a2-02e9846a1d64@6wind.com>
Date: Fri, 11 Sep 2026 17:48:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v4 3/4] netlink: specs: rt-addr: document
 AF_PACKET multicast dumps
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Ido Schimmel <idosch@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260911105103.7771-1-sigefriedhyy@gmail.com>
 <20260911105103.7771-4-sigefriedhyy@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260911105103.7771-4-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 11/09/2026 à 12:51, Yuyang Huang a écrit :
> Add the global flag, list the attributes the AF_PACKET dump uses and
> describe how ifa-family selects IPv4, IPv6 or link-layer output for
> RTM_GETMULTICAST.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
