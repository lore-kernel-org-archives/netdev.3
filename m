Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9D14AC155
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 17:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369734; cv=none; b=RleIFGNB0JcTZpi7rlajevMibLFByMpofX9eW/HKQWcRHtFSSZiLbxulIDt3E/TjWs+VSslv9XoZCNehQA+ZZ9O+WJW/v55+uPmJdSDw4kTUd1+6/uceLGjc9ELh0O+lcRb58DmDGn+dsqEecIZgXzBONXFBkeRSEjb+biwShSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369734; c=relaxed/simple;
	bh=Q5DK1G97KTMlUErFw1CUNFPSTqbW4BDX8xhS3lMwgEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fuh4Hyv0nwwPaWFxS9vxXWUs5YwYnTkE8y/TLAF6wZl+DqTYtGgkyyG4k2wta2h7Aczbk67jCBpnlwGRLbcS5IsZwG8XHLrNBSGpR0hEBTvq3UO3Xig23HqzIyREyQ7lFoOuSZq+kbpCcR5qc1b89VgJa2lv9RZ5nyxwTZTrR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=gUSREt7/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="gUSREt7/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so11227155e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 10:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788369730; x=1788974530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O3/eSEpY/gP/GSNY8aB6oKR8wAN8w8cFh3G1lwGQkJI=;
        b=gUSREt7/QOoUle7NmJk+fVMvENLribpmh7SJOySrJCNLIUxEEz3CRotmRmBx/GxoRO
         l+W23S8tM/ValnRT3WHPm9cCx0GonWGKEawqKA+7AovBZAKTXC/38p+Na71mb3TUUl/O
         7tINMaXDyJiysemVkLjA5kEjYKNdCL+/I3SbZx5kYMyK0TIMDHZYoewi3T8jozs9nR6Q
         qcNbwNUAVvSLPYgtYoYGEzzLJFcxqa0RKdkuUankAu6lPSadTJI2B5P4r0DdQQVUKFN+
         dCeU3gBHNxMvHbYGcC7imR1bK45+n6X87DCo0WoOjy6zjVJ2euJXx6xaGmuYOwBoWYqd
         Zu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369730; x=1788974530;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3/eSEpY/gP/GSNY8aB6oKR8wAN8w8cFh3G1lwGQkJI=;
        b=J0fKz0H4f7GGRw9Q4LZjUy4Xxoy8kkiDFcbX1jD7L+4gsEVxjjTw+0DXD22TVO/qrA
         0nBuMycWHb/ls+uUAeYlxc1INz80ErMnGRcuPa1kK8hgrtqNG2MUGiv8pkSQnQe9ZttC
         5wcSqp7Oh9qAp0wmLeJqKZAL5BJALNYwJcmSejDrHs0UFYsUMe+Uz4NCbtW8OWy8NP1N
         BNot917hDax7jhrXLUbotuUhNcYvIP07NM7AM73doudEVPn9czhpXJKpSv8SUABJyQgX
         sUZqecETJNnceDZOb/YKcu2/7U3zBh3x6tpEShOrLiN0/dnQryB6LFLEBu9eKZl8BbSp
         LoMg==
X-Gm-Message-State: AFuF++krMnPmryWrsYEGIvz31Oo85Ye05YD9SWNAaupBLcoCDsyr9kxZ
	+FDzW/wVAIUwCKb5afQ8rN4PAMmx0UFMLnR/3KF5fzo0b/iqEyaFCwlvLtbZPzgY7OLbFKzNB04
	4R6rQlBc=
X-Gm-Gg: AR+sD11ma7pTgdqWNNWEAHDQZr0MT7MP9/UZi1Oa/N3H1m5Aq8lIODyLdX1mf06iQBi
	wFhBjl1XxgDoJA0zg49ToWllMJf3C3EXoy6IOIlavso13Kceo4SPH5JULwvVxL1VlD4UBqND/ah
	sOJ8VfMHzMEqEh9cimhLNTJi0dcMPNsW5Bc7FqE+Tp2AS1Q+Ve4/FHchNkXZ8z9TxR76nxEfpFR
	rmFRWfSGR+4OjhbTR6N3haEhR17JvvPxnTL/L1k2vOj98QUxw5agnIhS0Z+DUoQgRAxnTE21cNE
	+8yE50iDR2rAxAfVtrhytMqnp4IRSbGgin6lsWyp19UY3sotHNOO3Qo7RCmYu5iBqAhAVMRj5Mb
	YSuDVTQqQ6jeKcszQYSibv3SHbgT/OhzCmTMyp9xg1Ald8X298YgjNi5M1Il6tfHhXw1ak16cQU
	bC4Sy27oqltjUtUretA5gNDG8BEb1sRzRJcV/iV/hzpHO1vKNnn+AUKW3wpsG6wLqss7Mtnvr0V
	TCxks4A+tyeV4y0eCs=
X-Received: by 2002:a05:600c:4e8f:b0:499:bf0e:95c8 with SMTP id 5b1f17b1804b1-49ce57f5647mr97861815e9.1.1788369729740;
        Wed, 02 Sep 2026 10:22:09 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee60bae6sm6684765e9.9.2026.09.02.10.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 10:22:08 -0700 (PDT)
Message-ID: <239e8a53-fb02-4021-8f74-6c232e9c9b6f@blackwall.org>
Date: Wed, 2 Sep 2026 20:22:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] net: bridge: vlan: minor cleanups and
 annotations
Content-Language: en-US, bg
To: netdev@vger.kernel.org
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bridge@lists.linux.dev
References: <20260901120721.747908-1-razor@blackwall.org>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260901120721.747908-1-razor@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/09/2026 15:07, Nikolay Aleksandrov wrote:
> Hi,
> In preparation for a complete vlan fast-path re-work, this set cleans up
> a few minor things - removing legacy code barriers that don't help,
>                       annotating lockless accesses and using proper helpers.
> No functional changes are intended. Sashiko will find many pre-existing
> problems, none of them are related to this set. I will try to fix
> everything pre-existing separately in -net, there will probably be a few
> critical items. So if there are missed places to annotate, or if there're
> actual functional changes, these obviously should be addressed in this set.
> 
> Thanks,
>   Nik
> 
> Nikolay Aleksandrov (9):
>    net: bridge: vlan: drop legacy memory barriers
>    net: bridge: vlan: annotate lockless pvid use
>    net: bridge: mst: use br_get_pvid helper
>    net: bridge: vlan: annotate lockless vlan flags use
>    net: bridge: vlan: annotate lockless use of private flags
>    net: bridge: vlan: annotate lockless use of num_vlans
>    net: bridge: vlan: annotate lockless use of msti
>    net: bridge: vlan: add missing tinfo.tunnel_id annotations
>    net: bridge: vlan: use br_vlan_get_state to get vlan state
> 
>   net/bridge/br_arp_nd_proxy.c   |  6 ++++--
>   net/bridge/br_mst.c            | 12 ++++++-----
>   net/bridge/br_multicast.c      | 18 ++++++++++------
>   net/bridge/br_netlink.c        | 10 ++++-----
>   net/bridge/br_netlink_tunnel.c | 12 +++++------
>   net/bridge/br_private.h        | 16 ++++++++------
>   net/bridge/br_vlan.c           | 39 +++++++++++++++++-----------------
>   net/bridge/br_vlan_options.c   |  6 ++++--
>   net/bridge/br_vlan_tunnel.c    |  2 +-
>   9 files changed, 67 insertions(+), 54 deletions(-)
> 

Me and Ido had a chat and he commented that patch 09 is far from done, I missed state
accesses outside of br_vlan.c, silly mistake. Anyway, I'll fix it up and post v2.

Cheers,
  Nik

---
pw-bot: cr
