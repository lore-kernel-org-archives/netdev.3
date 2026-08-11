Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79B32AD00
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786451509; cv=none; b=SKTP0RZn+Pgy8eSn5FH1OJdeE7775mKNgrAss2kXXxxslZzMx3/PqhNSqJHKW2oEJAyCQbc9X2usiPG2hgMTT+W47IheQxEigX5cVT9HCFY1Jws1w7Dl2axt4nPwb6CGQn3aLWTe1vlyu+N47lQnNtardpQ0fowT5qrFdi5CivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786451509; c=relaxed/simple;
	bh=8SMsIpyxnr4qcnu7GtvW3K2mKstememluJphmb508wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G7UKTDrREWyTBQ1JkX9DOunOpZe65vwQqpfUjHyQ+Ujsw94HCSz9X3wuFevso/HWbzzIu5bjSUSqboJx8c5/j0Elpwnrtw/sE259SXhGtdYqAWtZuOCIhN0E4EZ6AgwQm0dTFzV5UOfoosJqHsB37TqpXZUfYiTHogrPIwf++bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=fQf81eHm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="fQf81eHm"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4956869750eso20321215e9.2
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 05:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786451505; x=1787056305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PPlIxhoJp52uogiw2DViKRa4+JoT2+Ra2kLb/fmBTqk=;
        b=fQf81eHmvWvXD1UnPDIbt+rxNr8gA6DNv1aG+Xc4CWaxe5AHt9jNuSzkdqvu2buk4V
         72736Uah3uu2ATgrt3NyaXvkkGQN6IkEIZjW4tVuUt7SK6JYODjMVEMruKWszTpNXksR
         mdXGvdAe0vP4ZvA2NQjc7Exguu9K2wLxLFedeMzgU33osjgY7oaDLzvLjPNvtNhnhCgI
         M+MAWKn8955JbKzuVFK9XOIuQR8RZJHZW2ZwW/s7f+ll11fyGEoZTyC+/O7w/3CTNj0p
         P5/xgcqVo84caeFrRnqBI8AOs5pASNx+qsJxCkkly+muvSqu7xCbPDXqi9MF7shAJl5w
         tvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786451505; x=1787056305;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PPlIxhoJp52uogiw2DViKRa4+JoT2+Ra2kLb/fmBTqk=;
        b=Wf3O06Pc/vYWF2kbN9BADKVeTxCImbDCXd1i2uw7fn5O0KCcaz3FR0Ql13HwV36+m9
         Z/iPCLu4uwB5BUZowa/l/5eo84IaiXrlaq+0J7XUKrqKcsL/RJCuoav5Ye5NU0YtC6W1
         8QNz5xUcIMHHN2EDRW5yKcXf2xwu9SJrnsujeeSwUsGWX89yaHGpa/awMbLsvvZhwaTd
         bUR+QZQzXFuhA27ft+Ij3Nv/TmKWubcSJefA46NH5jZPa30Crthdg27vY5fSH2EYVYnY
         wbpW+nZ8DjHWnb3axYe+QdEEjBULPDKWluS8jZUCHowj8iTvKAaMF8S668Hph0QyKOcz
         v+ag==
X-Forwarded-Encrypted: i=1; AHgh+RpBicAH9n0rZKMV+hzEfgSnVr+leQQDysmlkE1JychRE0HTVtAhvesl+4wO1IiyNnSDbSiKVZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeya8rOZniJxB9RROC1NewedrETdJ+VDf5BQRHK3nALKFWAUJw
	WGEUiHXwi/MOWkkLEgnnPpPunhhko7LJRHb4AXihtK0Enuwr/nn2rb2Xvf/G0OMtBtE=
X-Gm-Gg: AR+sD11/NfZZCgF4aGiB0y2RWqM4PZsP0EoTkmR9YAB9SU4sZu98K/0EHmpAqkirQFY
	P444Brh/zqxpZNMpahKVDK0X1s2riBlnOm7Ro0Ys1/wTuXSMbM6DSmeCr1+0nCy56cBhAhshRtB
	UHS1pGvK1JpZTk+QD4GTaWLCSrfWugkXPGXSn2Cp8PirKOKB/T92cnuw1eoN3jCBMwyuOUmheLT
	oF0fkbEB8/Sry712fPmJoQxfetJWdF8bufoBVAAt41WzFhCTBF6a+AKJQiwrkAxf9Qv8hO6M5BP
	q4zf+6Q9m40xVGKrr3TGFlE/F+kv6kZPfpVRxeD++8Iebbb/XoDGoV7KCEAgvoD06Uks5DZREnb
	6Aa1Br707LIxDThdAgifeikGJgt5i+IYLHBPARhe7RnxiFWEANfe0TtjooRWqkHQCx1qOttaZST
	XucbiQ34ruYZdaMUcGncS4C6VYy5BP3bzuLi/qMWDzamNofj7gBDRM1S6RG1ZSd45ppMrcLWkp8
	li4DHR41f5CPj4DC9A=
X-Received: by 2002:a05:600c:3506:b0:499:737c:f24b with SMTP id 5b1f17b1804b1-49978433c06mr40959895e9.5.1786451505183;
        Tue, 11 Aug 2026 05:31:45 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997889c2bcsm54019495e9.3.2026.08.11.05.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 05:31:44 -0700 (PDT)
Message-ID: <de31b3d7-a0cf-4808-9bd5-8124a97a16b9@blackwall.org>
Date: Tue, 11 Aug 2026 15:31:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 08/15] ipv4: Replace &arp_tbl with
 arp_table(net).
Content-Language: en-US, bg
To: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Elad Nachman <enachman@marvell.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, Jiri Pirko <jiri@resnulli.us>,
 Edward Cree <ecree.xilinx@gmail.com>
References: <20260811022448.116235-1-kuniyu@google.com>
 <20260811022448.116235-9-kuniyu@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260811022448.116235-9-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/08/2026 05:23, Kuniyuki Iwashima wrote:
> We will allocate per-netns neigh_table in net->neigh_tables[].
> 
> Let's replace &arp_tbl with arp_table(net) and remove extern
> definition for arp_tbl.
> 
> Three notes:
> 
>    1. mlx5e_rep_netevent_event() and nfp_tun_neigh_event_handler()
>       have code assuming neigh_table other than &arp_tbl and
>       &nb_tbl, and the part is removed as it will be false once
>       per-netns table is allocated.
> 
>    2. prestera and rocker uses init_net because they set
>       dev->netns_immutable to true.
> 
>    3. mlx5e_tc_update_neigh_used_value() dereferences nhe->neigh_dev
>       in trace_mlx5e_tc_update_neigh_used_value().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Add note about mlx5e_tc_update_neigh_used_value()
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Elad Nachman <enachman@marvell.com>
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> Cc: Tariq Toukan <tariqt@nvidia.com>
> Cc: Mark Bloch <mbloch@nvidia.com>
> Cc: Boris Pismenny <borisp@nvidia.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: Edward Cree <ecree.xilinx@gmail.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>   drivers/infiniband/ulp/ipoib/ipoib_main.c     | 27 ++++--
>   .../marvell/prestera/prestera_router.c        | 10 ++-
>   .../mellanox/mlx5/core/en/rep/neigh.c         | 22 ++---
>   .../mellanox/mlx5/core/en/tc_tun_encap.c      | 23 ++---
>   .../mellanox/mlx5/core/en_accel/ipsec.c       |  6 +-
>   .../ethernet/mellanox/mlxsw/spectrum_router.c | 18 ++--
>   .../ethernet/mellanox/mlxsw/spectrum_span.c   |  5 +-
>   .../netronome/nfp/flower/tunnel_conf.c        | 10 +--
>   drivers/net/ethernet/rocker/rocker_main.c     |  2 +-
>   drivers/net/ethernet/rocker/rocker_ofdpa.c    |  2 +-
>   drivers/net/ethernet/sfc/tc_counters.c        |  6 +-
>   drivers/net/ethernet/sfc/tc_encap_actions.c   |  2 +-
>   drivers/net/vxlan/vxlan_core.c                | 10 ++-
>   include/net/arp.h                             |  6 +-
>   include/net/route.h                           |  7 +-
>   net/bridge/br_arp_nd_proxy.c                  |  2 +-
>   net/ipv4/arp.c                                | 88 +++++++++++--------
>   net/ipv4/devinet.c                            | 18 ++--
>   net/ipv4/fib_semantics.c                      |  5 +-
>   net/ipv4/route.c                              |  2 +-
>   20 files changed, 159 insertions(+), 112 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

