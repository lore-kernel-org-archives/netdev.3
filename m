Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337B361971
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838152; cv=none; b=qy/j47d7SNokCCUApUKk80l6x7adUQH5JVS3e4lx2KsOpzs7hb+/aNLwNHzY0rwVC/Ka7KrQM9ce9Kvg2hEh14CSpe4NQ7UwulbJdhsCk8oK5chDhL4+/nbtm77jAruMINAqrWWNCYfbHW5USqXfi7qUzNeontKs7AX46c9iCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838152; c=relaxed/simple;
	bh=Jnsta+rzeP4pRDS9BbJWgQj9SR1Ch/rWz4YgMi4AxB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFswvYa/a8Hp+Cv0NH0zkixLgi94dEo8ryDQGerQs9rWD0wOwKp+e93tdjicjPu60cA9wHsEyXq60Z4poAG0TPoiM3V/vei06iUjKfTiVQ/N34H4R8M9UfdnwNaNPfll1x4ztW8qESvX5DEDX3Embf+ozMPi8k5rbMLjQwN1Ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aCx4hCQO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KV5R70wM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCx4hCQO";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KV5R70wM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787838150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lAk+QMGNNJtgvFGVN0ymbgGSoDsKOby2WpfQYyiXVyM=;
	b=aCx4hCQOzMVspeRtuYe7ra6ocTo+h4zHbLDR4hl5CQ6j5H48dq7CAZg6YFv0zKzV7fvkWM
	MhDpszz8hYcNq93O+kM+kuzw9r+IwAhNf0uLDgf1PIIB0Tj7R+jGjUi+TwttNtLUzugAcv
	qRxLhyfB5d5U7EG4YOn+zSSAKdqCA/8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-UGfZFHJ_MmqLXMwQNXktsA-1; Thu, 27 Aug 2026 09:42:28 -0400
X-MC-Unique: UGfZFHJ_MmqLXMwQNXktsA-1
X-Mimecast-MFC-AGG-ID: UGfZFHJ_MmqLXMwQNXktsA_1787838147
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49554715277so7199755e9.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 06:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787838147; x=1788442947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lAk+QMGNNJtgvFGVN0ymbgGSoDsKOby2WpfQYyiXVyM=;
        b=KV5R70wM+ov76+p5f2kalpHwpxX4ZmriNQvvtZ0XaM/GlbHhe4B8ZlMGMVzPEWSXCj
         HLhHBnd0MlvHPw+AfsfLFXJ2FH5LLlZxRPflcn4qwwkZc0XyeZLbXsxYA/L59+NOtk7K
         JIYoH2F9MYy4ydLDBSzB0QdhZ3nN4Zpl1mnk7Wr+gGFudLGi+OsUFEJ2utEmAWLrz4pJ
         v1bfxHqz7/4Sh/TbSUpXgA9dVAj3t0tY4xeBwVV/SGHhAtyaH3L9ZpTHpfdha7bN7Evi
         lnK4+o94SllnACSvCgN+jIlHfTO/sI8XuwZJGEOip4Kog/ckGPn6aZqIyCYHWeVz1fhw
         8g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787838147; x=1788442947;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lAk+QMGNNJtgvFGVN0ymbgGSoDsKOby2WpfQYyiXVyM=;
        b=bSrmHR35veUugSW5T0vQ0VbTZ9XA4g3NJqyagEubLSEklkPgacuXNfQWSGylU8B3f5
         WTjw9lOzQfOLTy4INCVkju4Ks65zh3BcWd367oIFRV03J8KDVkJwvqwBWHLNceGcqYOO
         yuWH7kIommk31yshkGTuyFT0yE3Jotrh1SmoBdlLa0+PY4XcaK/W1FzMGtYMW5QRTkqI
         tJbCBQt/1pRnH6kAzoZqdGC3L3HVbe5a6BxUPx5QXVcdoU3P/NLcxf6wffE+Y9IkvUby
         seIF3Xj8R0laBarP9mFBWHNLIoSv4LE8qN8aGYjDvnfhuWp448VpfKTLxXNueef33FRi
         zViQ==
X-Gm-Message-State: AFuF++mZRQv6Zkt3BxgeIkrPsYJhFlmbpIUYmnehhh8Z6hFyd5TompPc
	pB9C/edzt1475pzoR75iJbn0ntcXzchKKYCEVAvwwQRd7SYemkmH3P022qc/ebH40rRhYIaIXFV
	AdL4ECrK9cYPAnOa6i/K8uTKV5j/WadOE6Ns7QADKQwOr9FuiTAe+4atJ9w==
X-Gm-Gg: AR+sD12kDLqaSYOl5fKC0tILX9cd93iCNycbdRgJGgqsIebVbnAC1RR9MQe8Pas7bEr
	D2w8BtVY26T2mKfj9g1EPfTdhPe0iumWxiLdGpZdLpsZ1xkThyCSN5zgcPuZOYIVRqQZmHaxpOX
	oRhlIkgffRMlDX2s1thyZ098hANfckaXvcsqU9R/HR9uRO3/RcSm0UwOtMb8UZrFMVPiC9O+VXo
	EOpFhE73ZmXsuNMasAJsSp1Bijuxj9URsaAaeT/3Wxcjq7Tb7Knhf8XzIdVKuIUJHUfg4NzzwJh
	l0mjjlQwMYcQaHtBL66nPAgG1aSFJIbB6KfH1GpHWa4CCZgoA3B/pZgpRFKBe3cdKGo1HXnGHRQ
	BrEjFuI04mRE9xeGJXhbZgRoAQmSY14xFkBnlmhp2dfeqn2pVuxJPduawvkDxjLNDgjiYK54=
X-Received: by 2002:a05:600c:3513:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-499dc82c0d7mr177474485e9.12.1787838147126;
        Thu, 27 Aug 2026 06:42:27 -0700 (PDT)
X-Received: by 2002:a05:600c:3513:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-499dc82c0d7mr177473885e9.12.1787838146709;
        Thu, 27 Aug 2026 06:42:26 -0700 (PDT)
Received: from [192.168.188.103] (ip46-47-231-195.pool-bba.aruba.it. [195.231.47.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499e7170b72sm107302285e9.0.2026.08.27.06.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 06:42:25 -0700 (PDT)
Message-ID: <d045bf04-be89-41ad-bd0a-b62fe4de8dfe@redhat.com>
Date: Thu, 27 Aug 2026 15:42:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/2] bonding: fix u32 overflow in compute_gap()
To: Hangbin Liu <hangbin.liu@linux.dev>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hangbin Liu <liuhangbin@kylinos.cn>
References: <20260825-bond_overflow-v5-0-7a800de133f1@kylinos.cn>
 <20260825-bond_overflow-v5-2-7a800de133f1@kylinos.cn>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260825-bond_overflow-v5-2-7a800de133f1@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/25/26 3:01 AM, Hangbin Liu wrote:
> From: Hangbin Liu <liuhangbin@kylinos.cn>
> 
> The TLB load-tracking fields tx_bytes, load_history, load, and
> unbalanced_load are all u32. At sustained throughput above ~3.2 Gbit/s
> over the 10-second rebalance interval the byte counters wrap, causing
> compute_gap() to produce incorrect gap values and mis-select slaves.
> Such speeds are common on modern NICs under heavy traffic.
> 
> Widen these fields to u64. Use u64_stats_sync to protect the per-cpu
> unbalanced_load_stats against tearing on 32-bit architectures, and
> div_u64() for the 64-bit divisions. The tx_bytes and load_history
> are protected in spin_lock. Also protect the slave load writing in
> bond_alb_monitor() with spin_lock in case of tear on 32-bit.
> 
> Rework compute_gap() to use s64 arithmetic throughout. Return LLONG_MIN
> when the speed is unknown.
> 
> Detected by AI code review.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
> ---
>  drivers/net/bonding/bond_alb.c | 52 ++++++++++++++++++++++++++++++------------
>  include/net/bond_alb.h         | 11 +++++----
>  2 files changed, 44 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index 0afed2c39231..9a43a1f47893 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -6,6 +6,7 @@
>  #include <linux/skbuff.h>
>  #include <linux/netdevice.h>
>  #include <linux/etherdevice.h>
> +#include <linux/ethtool.h>
>  #include <linux/pkt_sched.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
> @@ -74,8 +75,8 @@ static inline u8 _simple_hash(const u8 *hash_start, int hash_size)
>  static inline void tlb_init_table_entry(struct tlb_client_info *entry, int save_load)
>  {
>  	if (save_load) {
> -		entry->load_history = 1 + entry->tx_bytes /
> -				      BOND_TLB_REBALANCE_INTERVAL;
> +		entry->load_history = 1 + div_u64(entry->tx_bytes,
> +				      BOND_TLB_REBALANCE_INTERVAL);
>  		entry->tx_bytes = 0;
>  	}
>  
> @@ -133,7 +134,7 @@ static int tlb_initialize(struct bonding *bond)
>  	if (!new_hashtbl)
>  		return -ENOMEM;
>  
> -	bond_info->unbalanced_load = alloc_percpu(struct unbalanced_load_stats);
> +	bond_info->unbalanced_load = netdev_alloc_pcpu_stats(struct unbalanced_load_stats);
>  	if (!bond_info->unbalanced_load)
>  		goto out;
>  
> @@ -170,8 +171,14 @@ static void tlb_deinitialize(struct bonding *bond)
>  
>  static long long compute_gap(struct slave *slave)
>  {
> -	return (s64) (slave->speed << 20) - /* Convert to Megabit per sec */
> -	       (s64) (SLAVE_TLB_INFO(slave).load << 3); /* Bytes to bits */
> +	u32 raw_speed = READ_ONCE(slave->speed);
> +
> +	/* It's meaningless to compare gap on unknown speed NIC */
> +	if (raw_speed == (u32)SPEED_UNKNOWN)
> +		return LLONG_MIN;

Sashiko noted the above could entirely disable:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260825-bond_overflow-v5-0-7a800de133f1%40kylinos.cn

I think the v2 code for the above should be fine.

All other comments look noise to me.

/P

