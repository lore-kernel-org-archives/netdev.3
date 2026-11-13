Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582118;
	b=o7+0pZYVvu/xYnvFMbzEzi6lphB+okbpRnYsdgoF5qFt/rUXmsUcf+Q151jEfPKXnsSf
	 Fl70jk57x8Gyu9arhMHICeLwC2XBNgQUn3iGXdeY9HHVw7s0ZdhCRbTsyeNt9UTIdcGyh
	 vrhElayDhHmkrsECBAkDmhA6LvGplzJN67FoZrKbJRBqAqK78ZbSA9uUOEJvgMXMzJF+T
	 +vSkmI3SNuuWkT07uOfPG5yPcB07L84esS7uiUwE5rzj+inqk1E6J93yom0y0drFNd/Sr
	 9wPWxZxcTjyVSI1EcreWXbHAfdViwU7RNADWYA5SSkHn6zCV/h8pgroPGBKYGuQCpkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=UvJlDMmQ7OVL9Cq/+dUnsyd9giVT97n1C13659jaAwQ=;
	b=ZID+ZlkxhQGHb7wZjC3ExHjGYxU7a2QySgWUe1EwB/0gFOF44wjk1+NucQ5hAtFYiLTx
	 X7rYaoMGVyrQ6JUZVmkZqWp6XmKZvdWyPYN/VahlxrDYO/mcBr4fcFa++8Tgyc3z4I2vl
	 XW/nr50r5KvZZHu1MG09Avg8rP4agNeCeLJWfu96JPgUtqUVMOZy68DWJvj67JopFPmP6
	 ri9YWetNW1hcafAQ7usJFvXNVKHYWsZm/DJC0bBEEezAE50uYqq/d5OEx5EPm3uJRZ8eJ
	 2CXRoKUd3PYbeKhDXqdf8dDaLN/SNgVHnpPoYdVeBYsPxfr4yp6G18FCrwOvDFDJFLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=6wind.com;
	spf=pass smtp.mailfrom=6wind.com;
	dkim=pass header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=PKFa070+;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B57606A323
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 15:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8B57606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.a=rsa-sha256 header.s=google header.b=PKFa070+
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c505994e5f5so20088866b.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 07:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1794582116; x=1795186916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UvJlDMmQ7OVL9Cq/+dUnsyd9giVT97n1C13659jaAwQ=;
        b=PKFa070+aTzP6pVNOG0/VdpwIDPRcIm2Ylvnjxn2Lni96mDSOS8KRhAyOT3B8A0oMb
         zlxeqjgHpTSAzAtk9yBMKYIH74XMJYYPODsUNwlYbTwd8vU1p5gSNa1fZKMkcuRbjfhI
         isZ5YxpwyZQh8QL+HnVl7XT7H+P75oA5sOlcHxIJVfl3T8Vpr9NBhv8Q8JjPw8A805AU
         q+6TJd9PAAoz0MT+ZmrLQfS589f16Dx46hadjGXURjOH1EFLnH1XfugtXeWB5H8ygG+I
         H1qjqZf8KmDm9AnuGLnvNu1Uyv5xzEEm15oO7ortdDZqOMv5hVqRgGGovv+kLnYb9/UR
         RVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582116; x=1795186916;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UvJlDMmQ7OVL9Cq/+dUnsyd9giVT97n1C13659jaAwQ=;
        b=AJwMgX7qZFM56XamS5taBaQDYKZqBSsYZSYAg+eL65Jqabf9JaeDKWaYhDC+RwIP7W
         tF4iuRvVkm1DCiSNvhe+mnXWsjdo976HeK5cTiv1VXmsRPF6EIJuy9UVo7rTyHy3/cGU
         0zYM3bTUZlKTSx57e/UR4QHauh8AedautMzvN0vKLJDtGOIY3m9Y8HfbCV/fXIuV7+G8
         fZfapTzvbNus1mtm37YLZRJgQHaoc2fxsSpfmjlQ+jVST2JQajveuWIQznS53b7P7WMT
         r9LWpv2g7st2mtWohcdukHqDAJarbcV24IysUCnxy3EauhGIx66BE6kXOv2HOWIkbOz6
         jkjQ==
X-Forwarded-Encrypted: i=1; AL+hErHpI9vl3P4W8UJU6zeSXHTdRQpBUasZwh0uXn6dXjIQ3aAlOgyjJ5r+0KGyCe3cWfW+VSsw/Gc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+BwUIKOB/+A4dZbY3KMae98BZ/kdV263rxf5/9llOcqnEJTotm
	p95B5pMgQBLsUu51RRQfqqynSHfDbrSe48c5Eo+ID0DtgIK5yUUJzAqtucSF8z0wQ8o=
X-Gm-Gg: AYBFou0cA1CHTdUPA2aOKS5uAe9SsRdKm+Da78lqi5Uq0h1Gc6SOACLnmfJjpCMSzmE
	XPqKi3mqKfN+Yfcq7hMawfAdrGCdlwedKkMVpvbjhYJZmH4OkoqbYD7WfKVh0hrQo1kjvpn7Dtf
	Jr7ZEe8afjnja34QWV+RXW9TqBYDrEZHW9e2iWiCH1ljcOHtrCu5vIkBohv4uwQfZCyuaEO9FPY
	LirOnlaxNLU37vuQWpGZqMpgz19hoUTa2wpfXmgljCu77CE+dKRhmFeccfAvmvEUDB1TuJLpl17
	+IoU08+d4WMLSI3gkAhjOq04qh/ng+oX7b0QyR4KOhAdlJAlpeZxR8vmBASXIi9/O9pj9MGSYI/
	yVNyP8JsMxks9heNBidzqCYmhSEvTyyDpG+C5JYtZU++KPDBRcqw95vQ1zvdF9h7w6tEhput0Un
	PBAu59erlX13Wbsj/BolTcR8VOWADmgwCmXygDamTwuRUhxiPmVPdn+/rF9khfblSbLt2yyq54P
	/yEQAjhkg/OwW6U7jAA01GViryqOvmBJoq2AElAITEQwoG1w8IfDnyxn+XqOgV/q/cwERHLCo9i
	gbIJiWxEbdBY/F+rPtP8SMsZafF34/3pMa210LOU3TMMplh2v0mQ++MhRP3M9LkW32VIpnNeehf
	khhumQg==
X-Received: by 2002:a17:906:16c8:b0:c34:db91:aa1e with SMTP id a640c23a62f3a-c509634b915mr210215366b.4.1794582116183;
        Fri, 13 Nov 2026 07:01:56 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4e2esm5593279f8f.36.2026.11.13.07.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 07:01:55 -0800 (PST)
Message-ID: <1c93558a-ae19-4987-a625-4fba82867762@6wind.com>
Date: Fri, 13 Nov 2026 16:01:54 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v2] ipv4: igmp: report IFA_TARGET_NETNSID in
 multicast address dumps
To: Wenbo Sun <sunwenbo@cmss.chinamobile.com>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Hangbin Liu <hangbin.liu@linux.dev>,
 Yuyang Huang <yuyanghuang@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, 1342116488@qq.com
References: <20261112082352.152338-1-sunwenbo@cmss.chinamobile.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20261112082352.152338-1-sunwenbo@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 12/11/2026 à 09:23, Wenbo Sun a écrit :
> Commit eb4e17a1d915 ("netlink: support dumping IPv4 multicast addresses")
> extended RTM_GETMULTICAST to dump IPv4 multicast addresses by reusing
> inet_valid_dump_ifaddr_req(), which already accepts IFA_TARGET_NETNSID
> and switches to the target network namespace. However,
> inet_fill_ifmcaddr() does not include IFA_TARGET_NETNSID in the dump
> replies yet.
> 
> In contrast, IPv4 unicast dumps (inet_fill_ifaddr()), IPv6 multicast
> dumps (inet6_fill_ifmcaddr()), and AF_PACKET multicast dumps
> (dev_mc_fill_addr()) all report IFA_TARGET_NETNSID when a netns id is
> specified. Adding the same behavior to IPv4 multicast dumps aligns
> reporting across address families and helps userspace consistently
> identify target-netns replies.
> 
> Emit IFA_TARGET_NETNSID in inet_fill_ifmcaddr() when args->netnsid >= 0,
> and initialize fillargs.netnsid = -1 in inet_ifmcaddr_notify() so that
> multicast join/leave notifications do not include IFA_TARGET_NETNSID or
> exceed their preallocated skb size.
> 
> This alignment was identified with the assistance of an LLM-based code
> review tool, confirmed in a User-Mode Linux (UML) environment where AF_INET
> RTM_GETMULTICAST dumps with IFA_TARGET_NETNSID omitted the attribute while
> AF_INET6 included it, and verified in UML that AF_INET multicast dumps
> now report IFA_TARGET_NETNSID, regular dumps without netnsid continue to
> work, and multicast join/leave notifications succeed without warning.
> 
> Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
