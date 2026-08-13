Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2C748CD6D
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635165; cv=none; b=mWjC/wnVhQvlJbzpkP82q3WHsSbxBtNm5wfY3yq25IeGVTL5y+ovcBgYhyurPZW0yCsjtanBddXJWiqMuBtZdSjpcZMSL/O9NOIwfUmOcakGj7IagY24tD/ZtRSpF3FQdwCLbe8mX0OgAtuToSfjH+NL9BjkxAhKlOISpoCsj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635165; c=relaxed/simple;
	bh=5nyFkcfGjO2nKdnt4MrFfYvSJkGNB+5t+uK+n+vVHSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQN9b7T/S+nMfqH32JE7otHT9efGwaUD1l2CUSuUfMvksDp5yWKgRtJGVzVTMyM9iMvTaXODJB/1qlL/wnFgXQJevqZC2V563/H6oFhfk4TvuE/QpH7JKBfmy32Z68s0Q25A0KJvNdqBsJD6Ri2m5uSfhxo4bbf44nIBnPUYz4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=LAMLe8Kq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="LAMLe8Kq"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4815bce4652so495691f8f.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1786635161; x=1787239961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hh0SUndwLfny2gaCNFFJUY/mRRIT8t3cH6db2/oiz+M=;
        b=LAMLe8KqEpBEz1HgpevPJ9xjZZJP71bdLj67jVTpstJS4oOCxuWsBD/+nM2EvNcpwz
         k9kwGFWYBRYRQG6tz/PK53Z8gonMa3ttrDWDgAD35gf5KgWv9B7kmvw8wZwy7VB0GEZs
         e81ix2rlOlKf37AtK1KNYweCfG0HMDDGqqOSFYKRDd8VR7Dns3l9avP3rUejuF3m3U+K
         SmiWxhx42QeIVHNQ8/6weVKZADdYNegHlTBtPcBfVOTKw1iG+XtS56Gj5yUWkEkkwK6x
         FWl5X3c3T6LscikQl8ml22w27lfLtO2lTJJj+paC/bqOenk7KhgzrIGdFBwEFnX2PTmx
         9wgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635161; x=1787239961;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hh0SUndwLfny2gaCNFFJUY/mRRIT8t3cH6db2/oiz+M=;
        b=HfdkP7uBMxNBAk53lNcS04khdlwbmPkWgZOa9zJOlb7eFtAgE6tX/kJbjMGVIa86SU
         O2VADUxI+eoTQmePjfkOnRZIEKv98omOosEUTyFPljzOHSXwWChm/yVIxmbi/Gqpn/wz
         2UARLyTolsGp70/PDLrh7XHT5LOsmo9M8Osxhzark7hI9mVGtDV0BGmtL0euEChZON1j
         lGDZnWowBBFEVT+AJFaDpFM8VO0PJncUdQ/l3JhvDrlHt02H3OdeKd7U8ZwJ8jMW+baZ
         DdCgHBnnU57Mk+qsBfdrf/QVl1P+kkVcbjpHQTWTGOmcD/rGTmdNg0GJG2YkkD8oL/bJ
         DLCw==
X-Forwarded-Encrypted: i=1; AHgh+RrdwvfPYIERqlbSmm6CjUPj+iS8DnhBGbo6R15sUjmv7JL6Me54VKIOB4XBty2MikREKGzH5F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHkkoP4dcP7KX+FSZLSZ3MH+8nW6X0XA6eEehn+mKy5l3QIAGW
	UmHHVb1uGlozoXO5SxomudFfXWR+Rp5CKVH4o/q6pJSA25U0/GgVoQCgu30M8a+5k+Y4IrxFHQx
	ZKo3kRR0=
X-Gm-Gg: AR+sD114sQxwvKuhNVI6BSQq1XbmbKTwXyqg+Jo1pfoKscKP59Fe6/rKY4njU6bnrhT
	EpepHxOOr2EMLPIKRGdO2ccf0EPAiMruO+/sunglSnn/ZfZgLHzWpIXI9lho+qPV9l8/ALkqmUH
	2OHlBDoaT3gXssJqOZhSsUD/pU/VdEvUlOtEEXXM252sPXDAKW5Moximl861KMzNtcitQii533G
	g1Cfppa9Kx/90KTaJsmkysz4xX5Rw+Xe300D/KJUSp+elc6m9eD2qKnoIwAWyRRvQNJubT1jvpO
	t/HUj5ZxtFM3L28/L9KtXfSmnD8UcnHBfP8bdD3U7sGxcy8oOfLta4nffyl6DiKNu/fEXrsA4XR
	yoLe+l4C20Ym5AgdQtsIIkWwLiDKGHLMIiF1Geth3OSsbN6Yho/k54x9pKwU3URnPaY60IoYI1/
	xVI9d4RUTRM6FvEw1FfUVdYWXfiYzh+LQDSU8D5SbG/diOrVb/Xrt3M+ulr0zPjQcFp2FoSqSQ/
	jV49XtPT6BZpdLWxy0=
X-Received: by 2002:a05:6000:46c9:b0:481:4fe8:696b with SMTP id ffacd0b85a97d-4815a05274dmr7972451f8f.29.1786635160907;
        Thu, 13 Aug 2026 08:32:40 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f15b946sm278396f8f.0.2026.08.13.08.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 08:32:40 -0700 (PDT)
Message-ID: <5276bb00-388b-4d44-ab02-022fd8119b55@blackwall.org>
Date: Thu, 13 Aug 2026 18:32:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 00/15] neighbour: Namespacify arp_tbl and
 nd_tbl.
Content-Language: en-US, bg
To: Kuniyuki Iwashima <kuniyu@google.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20260813080248.407680-1-kuniyu@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260813080248.407680-1-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2026 11:02, Kuniyuki Iwashima wrote:
> The neighbour subsystem is almost ready to drop RTNL.
> 
> However, the control paths are serialised by the global
> per-table lock.
> 
> This series converts arp_tbl and nd_tbl to per-netns table.
> 
> With the series, /proc/sys/net/ipv{4,6}/neigh/default/ can
> be configured per netns, which was only configurable in
> init_net.
> 
> To avoid potential regression, all the settings are inherited
> from init_net by default, and this behaviour is controlled by
> a new sysctl knob, net.core.neigh_inherit_init_net:
> 
>    # sysctl net.core.neigh_inherit_init_net
>    net.core.neigh_inherit_init_net = 1
>    # sysctl net.ipv4.neigh.default.gc_thresh1
>    net.ipv4.neigh.default.gc_thresh1 = 128
>    # sysctl net.ipv4.neigh.default.gc_thresh1=129
>    net.ipv4.neigh.default.gc_thresh1 = 129
>    # unshare -n sysctl net.ipv4.neigh.default.gc_thresh1
>    net.ipv4.neigh.default.gc_thresh1 = 129
> 
> If it is turned off, all settings are reset in the new netns:
> 
>    # sysctl net.core.neigh_inherit_init_net=0
>    net.core.neigh_inherit_init_net = 0
>    # unshare -n sysctl net.ipv4.neigh.default.gc_thresh1
>    net.ipv4.neigh.default.gc_thresh1 = 128
> 
> Series overview:
> 
>    Patch 1 deflakes test_neigh.sh.
> 
>    Patch 2 ~ 3 are misc cleanup.
> 
>    Patch 4 ~ 7 store arp_tbl/nd_tbl to net->neigh_tables[] and
>    remove the global neigh_tables[].
> 
>    Patch 8 ~ 9 replace the direct access to arp_tbl/nd_tbl to
>    net->neigh_tables[] using new helpers.
> 
>    Patch 10 ~ 12 finally replace the global table with per-netns
>    table.
> 
>    Patch 13 ~ 14 clean up unnecessary net_eq().
> 
>    Patch 15 updates test_neigh.sh.
> 
> Note that some buggy drivers access nd_tbl without checking
> disable_ipv6_mod, so nd_tbl's extern definition is still left.
> 
> 
> Changes:
>    v4:
>      * Patch 12
>        * Add sysctl knob, net.core.neigh_inherit_init_net
>        * Inherit all neigh parms by default
> 
>    v3: https://lore.kernel.org/netdev/20260811022448.116235-1-kuniyu@google.com/
>      * Add Patch 1 & 11
>      * Patch 12
>        * Remove timer_shutdown_sync() in neigh_flush_one() and
>          rely on tbl->entries (Patch 11) to free it in neigh_table_free().
>      * Patch 15
>        * Remove stale comments
> 
>    v2: https://lore.kernel.org/netdev/20260807232932.3986667-1-kuniyu@google.com/
>      * Add Patch 11 & 13
>      * Patch 7
>        * Add note about mlx5e_tc_update_neigh_used_value()
>      * Patch 9
>        * Add __maybe_unused to net in neigh_table_clear()
>      * Patch 10
>        * panic() when register_pernet_subsys(&arp_net_ops) fails
>        * Add timer_shutdown_sync() in neigh_flush_one()
>      * Patch 11
>        * Split from the next patch
>        * Remove net comparison in pneigh_dump_table()
>        * Remove net arg of pneigh_create(), pneigh_delete(), and
>          pneigh_lookup()
> 
>    v1: https://lore.kernel.org/netdev/20260806011152.1170012-1-kuniyu@google.com/
> 
> 
> Kuniyuki Iwashima (15):
>    selftest: net: Deflake Periodic GC test in test_neigh.sh.
>    neighbour: Remove __neigh_for_each_release().
>    neighbour: Remove lock dance for neigh_update_{gc,managed}_list().
>    neighbour: Remove unnecessary EXPORT_SYMBOL().
>    neighbour: Remove __rcu from neigh_tables[].
>    neighbour: Store arp_tbl and nd_tbl in net->neigh_tables[].
>    neighbour: Remove neigh_tables[].
>    ipv4: Replace &arp_tbl with arp_table(net).
>    ipv6: Replace &nd_tbl with nd_table(net).
>    neighbour: Clean up neigh_table_init() and neigh_table_clear().
>    neighbour: Convert neigh_table.entries to refcount_t.
>    neighbour: Namespacify neigh_tables.
>    neighbour: Don't store net in struct pneigh_entry.
>    neighbour: Remove unnecessary net_eq().
>    selftest: net: Specify netns for ip ntable in test_neigh.sh.
> 
>   Documentation/admin-guide/sysctl/net.rst      |  14 +
>   drivers/infiniband/ulp/ipoib/ipoib_main.c     |  27 +-
>   .../marvell/prestera/prestera_router.c        |  10 +-
>   .../mellanox/mlx5/core/en/rep/neigh.c         |  29 +-
>   .../mellanox/mlx5/core/en/tc_tun_encap.c      |  23 +-
>   .../mellanox/mlx5/core/en_accel/ipsec.c       |   6 +-
>   .../ethernet/mellanox/mlxsw/spectrum_router.c |  31 +-
>   .../ethernet/mellanox/mlxsw/spectrum_span.c   |  10 +-
>   .../netronome/nfp/flower/tunnel_conf.c        |  14 +-
>   drivers/net/ethernet/rocker/rocker_main.c     |   2 +-
>   drivers/net/ethernet/rocker/rocker_ofdpa.c    |   2 +-
>   drivers/net/ethernet/sfc/tc_counters.c        |   8 +-
>   drivers/net/ethernet/sfc/tc_encap_actions.c   |   4 +-
>   drivers/net/vrf.c                             |   2 +-
>   drivers/net/vxlan/vxlan_core.c                |  16 +-
>   include/net/arp.h                             |  10 +-
>   include/net/ndisc.h                           |  20 +-
>   include/net/neighbour.h                       |  22 +-
>   include/net/net_namespace.h                   |   4 +
>   include/net/route.h                           |   7 +-
>   net/bridge/br_arp_nd_proxy.c                  |   4 +-
>   net/core/neighbour.c                          | 400 +++++++++---------
>   net/core/sysctl_net_core.c                    |  12 +
>   net/ieee802154/6lowpan/tx.c                   |   3 +-
>   net/ipv4/arp.c                                | 131 ++++--
>   net/ipv4/devinet.c                            |  18 +-
>   net/ipv4/fib_semantics.c                      |   7 +-
>   net/ipv4/route.c                              |   2 +-
>   net/ipv6/addrconf.c                           |  17 +-
>   net/ipv6/ip6_output.c                         |   4 +-
>   net/ipv6/ndisc.c                              | 146 ++++---
>   net/ipv6/route.c                              |  18 +-
>   tools/testing/selftests/net/test_neigh.sh     |  66 +--
>   33 files changed, 620 insertions(+), 469 deletions(-)
> 

Nice work! With init_net inherit as default, for the set:
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

Cheers,
  Nik

