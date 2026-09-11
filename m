Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B2B494824
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141495; cv=none; b=N/mBBp8rVHiy9aA6RIIYv72F1qqxUjZ3sq4emtXgr0y2wxZfGI6RZQelVYCNY3FMEQJkL3hS7+sKzHOD/yLDAGDZKmkD30rxK6U2AG+0YVz25u92qqmfqtNj08jndjeACDeSA9d2QpIW44hHnJVdIYyiVK21bMKeK0hO9Hs44io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141495; c=relaxed/simple;
	bh=mmTb3omMSKk79oaBdbfhFPddSgi2tQARhX5tD0VeCPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WhT99pkRWe+ap1ikXetNLjVlcIgm4wUxeKcNNC0Y0ofeheGpMBrEFB+f0YTP27ShAr7bfeuo+MC4jjx4LoHFduMQggDXUFJVa2wngCYlbZ8z+uHIELATptvKE94gs7XOCuAy6XoEbxiOIUvcv3wfIkNCz2TfTpazKOQcTqTaQ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=LYFe8zN0; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="LYFe8zN0"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-499db1740f2so23785e9.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1789141491; x=1789746291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fmKbcth3Cgu8DzPZBrBYeoO4fcpCEJAvt3C9XzTqgyI=;
        b=LYFe8zN0p6h98dBa4AVduWw+a6hqGLgplXHwgG0TJxNx3fFhs3CJT6K13uUAOYfIUg
         L4R3JrwyJQuCd7ePKoTlCgIhWZFltYkkLfd4e1NNzuSecUBf+0iShqdhDGR+4P3o1BWa
         drusHiYk2g6NO96RIeJzXowjj8u0PecbToS+m9e0kJmHekgT0pEbb6DGyNOjvWqytSpn
         NyhBxWzY5TUpLefrAMHXQgIMs971zgfDBQMZpRTai2WRi7sPn2l03HFBnTEtVOXj/rnw
         XZjVR17gmwCsA7OzxB4x0sYq9pFKOdzf4r9Vv/sCASucAkA6pfI8XpqEl82jGgOsDLyr
         5UTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789141491; x=1789746291;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fmKbcth3Cgu8DzPZBrBYeoO4fcpCEJAvt3C9XzTqgyI=;
        b=Vzl6ZDFwFoxAjeTXvGtxJ7CymOPCyd4nhfX3XD3ci3oBo6nXPyoNJJ1PHrIL1bDkh6
         KP7NBQyO9A31hsZuUooKmhp4GBn+v640CyEul70koA0gkl7B84FttCugAFG6jl9Paw0c
         RX4ZfnL7hdU1IFw896bVMTIE6Os13E1VyUsBgJ7Uhez4IlwHlhCPv5yKHU7tP9bTnRti
         ZW22+IaAGSJ7hPtJsL/cyyYazf6FP9VjgpbSjSytgKijy2n05uu+z0thtA6Y2M2w8yuN
         Im6U6qM3uXKheZg3OmZXP7mj8wyji8O8UkguDa5AkvogDczNazXSUer2eYmTa/XuR5Gi
         wmnA==
X-Forwarded-Encrypted: i=1; AKwUvBzZrlLP38Mxl/s7LnHg9gVW8+zSXA7PXVFGV+otsrsWgMvC93EvYcqsMizt5c+0HuAP8EdmQiw=@vger.kernel.org
X-Gm-Message-State: AFuF++nZfxxnJUGpgMcssGz0hrF6X0iHhhHTxphxioZtzTk9q8BYoa2l
	2ze4ymLbZTj81atCFe0nb8oOHmEVGnQL3zd6+m4KtHkjsB8vyC1n0o1zSBlYlHM3mOo=
X-Gm-Gg: AYBFou0iyUH/uwmnLcJp/ME4R+gruvfBUHPLyKVklefo3lRTtK8y11wxQ7pGltvgoL/
	aOZ8ShcoKfYzKBY8rHGkfYFqiKBS/0a3EbixVtEpmSsCpQ5pMidZZIDSPRmucEasjq0blP4ywjT
	HQPO0V5N5fVSCnzqHVxo0b/+82baTohTWtOXGOBxHakKD+J0lzz+MEvDiPZnl1uPywPsyLTxabQ
	Pw5pDVDSpQpNLMG2/9yQMgaXEklHyM3UNiOlIJQu3hNGaAuVev2rmBPjeQS9laCHtNlVH34mWK1
	Pv7qCP8yur+aV1rfR0+BgGmrt+0u1vwpmI8JjYNDCLFoII/4BwvTzJEM9c0egDONvHPv6PX9Nds
	IuiEMOztmqcHZIEiQmSYx0kOyJsQ3H9EBucpZBrEYK500Xh2UcQnpKFb7vFvks1PpEcswVyVoMp
	u4HY2mNDTHr5ea7Gc5B2J5K0S9+Dw8VueSNUVP8RoEhjxbGQ9maQzynqSUDLkw7SJlWBU+nEkyp
	d/XnAOJWn5Y7SgV9/hBaNMd2ZrFyKr7RGyZ2Id6GIjk0JUM09UN
X-Received: by 2002:a05:600c:46d1:b0:49d:798:67a4 with SMTP id 5b1f17b1804b1-49e61640f73mr50975385e9.0.1789141491401;
        Fri, 11 Sep 2026 08:44:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26b7332asm161865175e9.0.2026.09.11.08.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 08:44:50 -0700 (PDT)
Message-ID: <23770b2b-d5d7-476f-9c25-285e6bd50fea@6wind.com>
Date: Fri, 11 Sep 2026 17:44:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v4 2/4] rtnetlink: add AF_PACKET multicast dumps
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
 <20260911105103.7771-3-sigefriedhyy@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260911105103.7771-3-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Le 11/09/2026 à 12:51, Yuyang Huang a écrit :
> RTM_GETMULTICAST dumps IPv4 and IPv6 multicast group memberships, but
> the device multicast list (dev->mc) is only available through
> /proc/net/dev_mcast, so "ip maddr show" still has to parse procfs for
> its link-layer entries.
> 
> Handle RTM_GETMULTICAST dumps with ifa_family set to AF_PACKET and
> report every entry of dev->mc in the existing ifaddrmsg format:
> 
>   - IFA_MULTICAST carries the raw link-layer address
>   - IFA_MC_USERS carries the entry reference count
>   - IFA_F_GLOBAL in IFA_FLAGS reports netdev_hw_addr::global_use, set
>     by dev_mc_add_global() (SIOCADDMULTI) and dev_mc_add_excl()
>     ("bridge fdb add ... self"), i.e. entries added explicitly rather
>     than by a protocol join. This is the static column of
>     /proc/net/dev_mcast
>   - ifa_scope is RT_SCOPE_LINK
> 
> This covers every column of /proc/net/dev_mcast. AF_PACKET is the
> family iproute2 already uses for link-layer addresses ("ip -0").
> 
> The default FDB dump also walks dev->mc, but only for Ethernet devices
> without an ndo_fdb_dump of their own, so bridge, vxlan or macvlan
> devices never show their multicast filter there, and it has no users
> count or global_use bit. Extending it would change "bridge fdb show"
> output and add NDA_* attributes.
> 
> There are no legacy users of AF_PACKET requests, so they are always
> validated: prefixlen, flags and scope must be zero and a non-zero
> ifa_index restricts the dump to that device. IFA_TARGET_NETNSID selects
> another netns like the IPv4 and IPv6 dumps and is the only attribute
> accepted. The dump runs under RCU and netif_addr_lock_bh() and does not
> need RTNL.
> 
> Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
