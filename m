Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDFC1922F5
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453634; cv=none; b=aR4F/BOQ3Zk9SVCDbOHj7VWzjNg+IB5Z+fI5mjoEIl0rP9E/vA9QBj/ZlzI/5pbRjVXpJlMZprODzMI0EUfjjgeAg6ark53RB+XYQJW5muIP6Y1oBFgpfJHE4QA9QNrDo+Yf2d7pkDZF4diIpLwwuqFcCLVZFa7Oyxo6CPHSetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453634; c=relaxed/simple;
	bh=YZ1BBUCn7l/hlMERPlM7zretjZDMJC2TFYZP1ju51R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KDp1JpM0cNeF+I26ctbjpi2etS+OI/RlbiEuSqRQQn+WZeAPYAfZLEX73B9+t6KKXc//PE1vxbJr4flquOwo3ohkLV5pDsokiZZGCDx69NmMXTIMr2NQkZXUaV0G0X8CPTSHW16qszen9nXDpG6s2iX77vpPGv503WnrSGLPdeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=kkCYt5sW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="kkCYt5sW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49553515a8bso48317525e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 06:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786453631; x=1787058431; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4xPvfqxhOS6C9wbuJGDPW41NaehObmlNxx70BnRN1t8=;
        b=kkCYt5sWbdWDweArknD5SRTSh53w2bLS0OqAo12IaoLcW00hP4nztUJHR2E/mEBl1q
         QwCzvdkA9y812BnSxw7mmlbb7LduDQYTgwLU25/YaNkO5Kg0CIsxk2Wtmnl0kB8E/j0Q
         N//R5WiokEa+12a8xJQxnmW+pQK12LO+arHBY8QJz7ADUt368ydrZUHdmY/Pk1y7tBs3
         cPn4xV03iQ5kpqU+VKcbMeK6x1M3CZWVi5VGMcU8cjo0lTR69kLoLl559F2XAGSWcXnF
         9aJYuI1IPj3+/W2X7H9TGiB9QCkYoUL7XW4D71K3/cDuPB0ONJCWNcgt8ZmIewQhfXUO
         v6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786453631; x=1787058431;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4xPvfqxhOS6C9wbuJGDPW41NaehObmlNxx70BnRN1t8=;
        b=Tjk8VL9/kNj+7Lr6gN3jOkqdmAxDd6vQX4Ep4BIUxE/eecgzkAxkrcxX/xX99AKCMl
         UK77zB8o9LzmFInPttITfMNS3jc5tPTolRBxODyeWU+PcyD+4293IOHIVug3T7VGMzPo
         JP1AObY5zbQHnC0BxQQrZu9AjzCB9lgHgYsU0f7QeTNv0hgsUcj/cHbPINtXNixLb2Lw
         5c5JZpJR8GvoFLz1q6eSegVDIoM+GhylFJTR6D1WnnorQ4/+rtc3sX4A4QntwCuUlyZH
         /lF0NNnn2juZvNMG3+D3+Vcd7+Q8l4TlL1+i4vcVRsavhzq48mlULWNekBteMipblsWv
         BYpA==
X-Forwarded-Encrypted: i=1; AHgh+RqmD3V/4Ff9n8mnRjG6OK52HnsiZbVpFHzs0Y/xh2je2K+i602drR5zQpErKy18Fq7yZUkYLco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1139nMZ0Qg1exxbUssQ2kNf89ra36iKEBUTt+oqadY8TvAbE
	aDr/N6pIsBZWVYKWD3Ub35crybcGHdVD2TOvJBrdKrlEzGi/7uIDmuIFF8LF5we1kb0=
X-Gm-Gg: AR+sD13JCa8wIvLLMC992QypkPH4M5Ax6FcLkXxWaX3NtR5T+KkZsOvvmzxQ8NQznRN
	D/CBIKz4rltl/Bxuh723mmUUQhiKTQwlaQ1qOFT6cRbVx5ZCj8nDeL3WMhfFT9BGTjaYMpatdwW
	BEbHcFxZ1wBFunso0fCAotob/cPIQN6FwBSXkOETKYA5rslxAhZuFYHr16es3v5AvV8DaGI4qUB
	qoxbB+LjA/gnHTTTEcrZXrX5yZLTG8bljVLoFwjNP1Os3GENoJxtdYoiPUuJ958u359ZB2anwgT
	4pD9132YJxo5JvoR3Rw4lA4EYe4+2UKVNgjDsixCrChvI4AH94E6nztJmk4mnqQUQlWNojeW3zs
	Y27joPb04KnqJFhFLUUyHoBER5zeSTzMi4kYWd9LvTWe93Mam4lSJjz0YbjrDVL8u6wVQZMWlQt
	MeAlX2ebfl6BJVBm7UWRAogWIMROvZbhsGdRN0s6iAqilxkSeh82A0Y7vqpOgwUvGFwPKqBBaV6
	hagOg3ne8ggTC/H8V4=
X-Received: by 2002:a05:600c:6088:b0:496:ca1f:a428 with SMTP id 5b1f17b1804b1-49978475c11mr57265765e9.19.1786453630951;
        Tue, 11 Aug 2026 06:07:10 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499740c5e0esm60461485e9.6.2026.08.11.06.07.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 06:07:10 -0700 (PDT)
Message-ID: <8d20c7e0-d44d-4c07-bca5-ff3c9793af99@blackwall.org>
Date: Tue, 11 Aug 2026 16:07:08 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 09/15] ipv6: Replace &nd_tbl with
 nd_table(net).
Content-Language: en-US, bg
To: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Edward Cree <ecree.xilinx@gmail.com>, Alexander Aring
 <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>
References: <20260811022448.116235-1-kuniyu@google.com>
 <20260811022448.116235-10-kuniyu@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260811022448.116235-10-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 05:23, Kuniyuki Iwashima wrote:
> We will allocate per-netns neigh_table in net->neigh_tables[].
> 
> Let's replace &nd_tbl with nd_table(net).
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Mark Bloch <mbloch@nvidia.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: Edward Cree <ecree.xilinx@gmail.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Alexander Aring <alex.aring@gmail.com>
> Cc: Stefan Schmidt <stefan@datenfreihafen.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>   .../mellanox/mlx5/core/en/rep/neigh.c         |  7 +-
>   .../mellanox/mlx5/core/en/tc_tun_encap.c      |  2 +-
>   .../ethernet/mellanox/mlxsw/spectrum_router.c | 13 ++-
>   .../ethernet/mellanox/mlxsw/spectrum_span.c   |  5 +-
>   .../netronome/nfp/flower/tunnel_conf.c        |  4 +-
>   drivers/net/ethernet/sfc/tc_counters.c        |  2 +-
>   drivers/net/ethernet/sfc/tc_encap_actions.c   |  2 +-
>   drivers/net/vrf.c                             |  2 +-
>   drivers/net/vxlan/vxlan_core.c                |  6 +-
>   include/net/ndisc.h                           | 11 ++-
>   net/bridge/br_arp_nd_proxy.c                  |  2 +-
>   net/ieee802154/6lowpan/tx.c                   |  3 +-
>   net/ipv4/fib_semantics.c                      |  2 +-
>   net/ipv6/addrconf.c                           | 17 ++--
>   net/ipv6/ip6_output.c                         |  4 +-
>   net/ipv6/ndisc.c                              | 91 ++++++++++---------
>   net/ipv6/route.c                              | 18 ++--
>   17 files changed, 112 insertions(+), 79 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

