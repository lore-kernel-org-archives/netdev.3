Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2532557F747
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 14:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963775; cv=none; b=i0+EZG6CEQkKP4+7FsDQEdO2dk+Em/mINFiYfuN/0FYMbmur9gn9HcfhSrh2p8Jt+FEmBaZDdPKpQa/UzqxCyOKv1jBoAKZrtIxgzo7BNuRib3lnPFTSIqVYpTAOYPEaw1nKQvxJQacLfWCGMZsFkDL+Kwh+gOrTRb09qPmNKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963775; c=relaxed/simple;
	bh=8UyRz0pNRbKuhOPAv+GQ+lFd/A7kot7/Ib2oI3fHECM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OS43lqbgzCiBKzSyaDxtfTG5p8B5e5IE2s3fjsbdS/cxnkXvlSmO4PJgoWfkrPldPS30VO/DhOm+HZRU5kXqq++3rYmY+rrBLPwVTIHq0Or7e1i/aKArtC1SLptTNzsWG2Y6hpKYw1KLvnKIMzHAcWE8A0ygsdL9W1TYXOKZtU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=F1acJ/ZM; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="F1acJ/ZM"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-499db1740e4so2765225e9.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1788963771; x=1789568571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HaWevtsqS/j7ikipn8DTmG2iP8U3mJM88NAd/Ru8qKk=;
        b=F1acJ/ZMQyUM+hJ3oG1KZk5gUg0+FdwNbDuubDmn0XmasJ86L1oEA5Ckmck+XowzLk
         JY1AKf1mNCEUK8xavvJnbjxPaPPWHfgpEaQV3Aj8D9p9EBCveOvvtbY8Jbvvb3SYQID7
         Fs2V5m6BP0X0bV8WB+if1iM++9TldQKuiNir4Ahjek8NYt/yavN9H1gCdwD64kAVT4z2
         1iy+YtcP34istnpOpShhDn9XJugjvKSNd+CEbkUBxNzm01N9ey6KIZh1ovLR3Bhugw8P
         YgeIjVG0EXQhHHuv+PUi2JYmJLZCz4c4WnpOyI9tlOJQ4drAehizpaxpBda1o8fP7GMV
         xMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788963771; x=1789568571;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HaWevtsqS/j7ikipn8DTmG2iP8U3mJM88NAd/Ru8qKk=;
        b=VpskU1B0uCyIAkKrdoDIBSpl++S5tXcC2bmBHnvCPh2NrdD47TrVdYiAljaPxyV5cO
         NxVlgMHm/Yj4b8YDlQrGuwDvr/MqK8dBK5H+cFoBcFwOmYxepoi2tLOREhuECpYXTiSF
         taoIa6Vbr2/oa5rQ8uGcrcuZcVD60WrmAAEtsTZbRjM5yNWBPl8GdkIgY+MbgaVroyoE
         FO7hCkBhekSNUvP7eXOccjsVDMZnRNZfcYRgC5u8HkC0KO7Nvw+60cGOX/ncGoojjHHX
         6jTnlOtkHNqFGvAHl2ZLngvhsPxQ+ejfBwsvv4yPp9fbO6ic+5ij92V5NXYAo5kbP4E3
         skJA==
X-Forwarded-Encrypted: i=1; AKwUvBxe9EEDgLd3rCDiNNXPt6yFwDfOwt+UcB/H1vSW62+HS0gSxPU3325++MAgfVPBHm4UDwd9KDQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n7037EUih9oC+gZCdfDeh/6qrW7pZ50VvnJOOJQuHmIQVrqm/y
	CCTzUs+lJiQeuu3+6mQnFXy6nUAEPWRQDiYds+XKY3++a1/1p9AS01R+s3fK0PyIcmw=
X-Gm-Gg: AYBFou3feIlTrtEB/AMMBmlmhxmXlMFtP8TgCYjdkRh9W4LGOiQF3ur0jJ9exEQpaNO
	ReIQzOckesjFQoFi1rszhhxJjwwYUNNUOaviK7Vi9eZHUIJaBydqOYykfRZmJJpMYgRsEUBo0yf
	6h3TvYRUTCrWEXj+I/IOE4uXHUxgxz30NtfqmJbP4vLUcGBGaVxcavBp7Az1o4hHumMz0Iro6++
	liAtlRI9vSbKjALCNz2rQ6IBvHWmSh8C2nzm9P0qRfKScXqynQx5vyyrgzNAlyvueqdSy8VrSXB
	nAoJas/LFkhqht4L1VThL6HwsVSoFWyD71K3zn8YpegvGb4iygazsyqrS3CVzdOVJH14WDTC29W
	lbhRLYsSX64+sn4c/8ozj2IOsQ9J5797VnWo7dH+1UvkT2Yt35+3KOgh/UyHua/ozpQmeqMBv1k
	bSkkZtvf1w1RPQJanNfn8ZMY6TzCnuz7766Kx9zUdqEnaGZRy2Pj9ujzKHZ9q97/KCkmrvzXIT+
	IzRLhD7gr1fCxnJXknQeGx5G/Ur8f9BEXmgs1uhnzKDhR1BQKJx
X-Received: by 2002:a05:600c:4f48:b0:49d:798:67a4 with SMTP id 5b1f17b1804b1-49d079867f5mr258909655e9.0.1788963771271;
        Wed, 09 Sep 2026 07:22:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:ab7:2110:6a1d:efff:fe52:1959? ([2a01:e0a:ab7:2110:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588390e30sm42712069f8f.7.2026.09.09.07.22.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 07:22:50 -0700 (PDT)
Message-ID: <ab826712-6255-4e9b-b6fb-f6f8c380e779@6wind.com>
Date: Wed, 9 Sep 2026 16:22:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v3 0/4] rtnetlink: dump link-layer multicast
 addresses
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Nikolaos Gkarlis <nickgarlis@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Sabrina Dubroca <sd@queasysnail.net>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf.kernel@gmail.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260909133247.113923-1-sigefriedhyy@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260909133247.113923-1-sigefriedhyy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 09/09/2026 à 15:32, Yuyang Huang a écrit :
> "ip maddr show" prints three kinds of entries: link-layer, IPv4 and
> IPv6. The IPv4 and IPv6 ones can be read over netlink today: IPv6 has
> had RTM_GETMULTICAST for a long time and IPv4 got it in eb4e17a1d915
> ("netlink: support dumping IPv4 multicast addresses"), with IFA_MC_USERS
> added later so the user count no longer has to come from procfs.
> 
> The link-layer list is the missing piece. dev->mc, the addresses
> programmed into the device filter, is only exported via
> /proc/net/dev_mcast, so iproute2 still carries a procfs parser just for
> that. This series closes the gap so that "ip maddr show" can be served
> from rtnetlink alone.
> 
> Patch 1 fixes the type of target-netnsid in the rt-addr spec. Patch 2
> handles RTM_GETMULTICAST dumps with ifa_family set to AF_PACKET and
> walks dev->mc under netif_addr_lock_bh(), no RTNL. The reply reuses
> the ifaddrmsg format of the IPv4 and IPv6 dumps: IFA_MULTICAST carries
> the raw link-layer address, IFA_MC_USERS the reference count, and a new
> IFA_F_GLOBAL flag in IFA_FLAGS marks entries added explicitly, which is
> the "static" column /proc/net/dev_mcast has and "ip maddr" prints. A
> non-zero ifa_index limits the dump to one device and IFA_TARGET_NETNSID
> selects another netns, like the IPv4 and IPv6 dumps.
> 
> Patch 3 updates the rt-addr spec and patch 4 adds a selftest that
> checks the filter, the user count, the global flag and target-netnsid.
> 
> Nothing changes for other families. AF_PACKET dumps returned
> -EOPNOTSUPP before, so iproute2 can keep the procfs fallback for older
> kernels. I have the iproute2 side ready and will post it once this is
> in; with it, "ip maddr show" does not open /proc/net at all.
> 
> Changes in v3:
Please, wait 24 hours before sending a new version:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/maintainer-netdev.rst#n15
