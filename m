Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC02F84F
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792032557; cv=none; b=E/RmK9VbPQD0J9f0TAhj5nULqE+gLU9eQOmLhANHpJR1s9BYl3H+FQbIedIx8Ozdcqv3zhHxhh9bqjAVnhRHvNKSnzSl8b90oafTrDrmiI8Waq95gB7/nPZAHQy1Syp7vp+fawIPQa3L3u45pxrADJAicFZYy6fw+UKN1wjz7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792032557; c=relaxed/simple;
	bh=8V8yPSbMw8apmNIJjJAl4vBZi2BIixdWgWO4jufkzQQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Y030kjc+cPA1MBvKa2o3Xoxfr06SksT8SMBH4V2+CjxcrIYBq8ISpVpK0lBh/Bf/RhYkXdZMovixsQp9O12e1iYh9nwVdwMPeWlsx6pgl0aOd4fA+dH8smQvV/ZkSJkdBN2SDllwbPOCKzTjqcXZzW+FrcJAWNtAi+vWvxoX06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=glJ5AhqG; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glJ5AhqG"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5e6b5794d26so3721280e0c.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792032555; x=1792637355; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TnNQqUDr8SKFHy59cY2mWfkC4N5kb7edfWV3cIhUTxs=;
        b=glJ5AhqGh96jVbRrQWgQeClc7pRzE23jGbJRnF4Bwl+ewd1CKnnyh7VCnwGEdFlhXS
         CEK6PyRNRmGEEZ987M7cGLhD30NjpOVHR+6a9i2UCWlzhspbTi3HsCVo75CI6C5reIFB
         QFKLQYbEbeKXkcvHFQAdvgbAuTsdDFWmjt24lQ+LHDxHFvUDR2ITdBK8cmEPU6VlO9SG
         LHD+gWDySBsc+nCQwcOxrpuk0tKKXZMAgU3C6VHstg8aZx4V0kBrHJEWdgizT5+t4tSZ
         J65DA0tG4seShv88H++0UPD0NphG6j1YWfkBplb1VQuJiO271PfYf21a6YMmd0hZ01DQ
         LtHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792032555; x=1792637355;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TnNQqUDr8SKFHy59cY2mWfkC4N5kb7edfWV3cIhUTxs=;
        b=C7Ii9cbkw+DBJevpFOtqR5njIaGS30uILOVyoMo9VHIMPXOFGZaK/dBOVx5mCjzjZu
         V2hDAqloBBxF5QeEhxkIhGX0EcG+oSgTLbbSfXPzyRJGauxbGVtj5DHxIDQicBQBQ84i
         8uum6ghs/OYwRQWm0svas9xLx0PtnrYci9TZfoWweK5NV4MeB8Zklos562FCggtKzPPg
         AlACupSdUEOn6T+ubkZMhb+R1OE3bjVRazSopqQBTGp6ZwwKS3CrgPneI4Wcb9eWvb27
         4RPDOiZH1vVXizf5Qw0PNcVNSNxCuE8XqGbLc5VXOVa9eMib/zHS2TPEi7K+JRZ+6xdZ
         8Fdw==
X-Gm-Message-State: AFq9FYL/WUYN6kMJIz42NQZaesQ0g/9VyDKy4VZN91cneaqVOzxml0t4
	1vdOv7zViyTayqh7QzUr7DQtc4p+iCtCCZ/sZSCgz4KqOFSrFEnUM2Zz
X-Gm-Gg: AYBFou1WOVkhM5a3BNrkoXQ/E/J/SnKnF0xlk2vjRlFGORm4+sk0zTJKpvGQ7sXrdnC
	VWowbgiV8zYx9TKNhYK16l1yhKBkASz7AD519KcpMLXu6UE/SQcv7NwYv7pvy9SI8qNcFI1/ts4
	CWP3NvzkUbn15sHNuzAclFEaotsTWsY8NTd6NUgUsuL0I5yuPgr99XmxdLGNnll3cUlDiIh0uqt
	x5FZH7ST7ia5DvfodNSxxGSWeT6SRfXpcuIhWdHi8x/ZTzj8NHxnes3sWB4f5jz8fNB0WVbp2Bv
	0giI8ds91uZNrFJ2C4Fsag/sj2saboPIA+q5Uqn5xEShG4Fymk8ypJsb2Y9O2BN0sDlVYYYx32q
	Aabup+C0o+yPyYuVDYgN85riJh7CtM9L1h0O4KvWXs6f3VhOLf6QstsKaPtLkIHzDngDHWzLyGN
	unufXjjX+eGieCqoaBhsB4/N6rTnA5rzIYd703MfZeK+Lwu1BuJUOKYRgEOqp1oMnfhWCODRVCp
	GfRCwqrdcRAnGVMepDwZrnzu8CVeCiYx6vv6YBouNPYi5G+MH6e5xDiB3vZu2hFbxTAh9TFUw7H
	nb7tUxElbT9s2At5znyW+RLTdAWV4XjMat4U6Ko=
X-Received: by 2002:a05:6122:d0b:b0:5d3:9cb7:f723 with SMTP id 71dfb90a1353d-5e91f45eeb1mr4583576e0c.5.1792032554895;
        Wed, 14 Oct 2026 19:49:14 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cab4a97sm12928147e0c.6.2026.10.14.19.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:49:14 -0700 (PDT)
Date: Wed, 14 Oct 2026 22:49:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Boyan Liu <yymhvert@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 co+98d7de09cd94fec5@bugs.sh, 
 Boyan Liu <yymhvert@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2a345d6bd54c5@gmail.com>
In-Reply-To: <20261010073015.7665-1-yymhvert@gmail.com>
References: <20261010073015.7665-1-yymhvert@gmail.com>
Subject: Re: [PATCH net] udp: Fix out-of-bounds read with unset mac header in
 unexpected GSO path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Boyan Liu wrote:
> udp_queue_rcv_skb() and udpv6_queue_rcv_skb() re-segment an
> unexpected GSO packet after restoring skb->data to the mac
> header with __skb_push(skb, -skb_mac_offset(skb)), assuming
> the mac header is valid.
> 
> SRv6 End.DT4/End.DT6 VRF decapsulation calls
> skb_unset_mac_header(). iptunnel_pull_offloads() can leave an
> inner UDP GSO type (SKB_GSO_UDP_L4 or SKB_GSO_FRAGLIST)
> behind, so a socket that does not accept that GRO type runs
> the unexpected GSO path with mac_header == 0xffff.
> skb_mac_offset() then returns a large positive value, which
> the unsigned __skb_push() argument turns into a huge length:
> skb->data moves far outside the buffer and skb->len is
> corrupted, so segmentation reads out of bounds:
> 
>     BUG: KASAN: slab-out-of-bounds in inet_gso_segment (net/ipv4/af_inet.c:1383)
>     Read of size 1 at addr ffff88800da7ffff by task exploit/149
>     Call Trace:
>      inet_gso_segment (net/ipv4/af_inet.c:1383)
>      skb_mac_gso_segment (net/core/gso.c:53)
>      __skb_gso_segment (net/core/gso.c:124)
>      udp_queue_rcv_skb (net/ipv4/udp.c:2476 net/ipv4/udp.c:2466)
>      udp_unicast_rcv_skb (net/ipv4/udp.c:2620)
>      ip_local_deliver (net/ipv4/ip_input.c:262)
>      seg6_local_input_core (net/ipv6/seg6_local.c:1640)
>      lwtunnel_input (net/core/lwtunnel.c:465)
>      ipv6_rcv (net/ipv6/ip6_input.c:351)
> 
> __skb_gso_segment() resets the mac header to wherever
> skb->data points, so the push target only needs to be a valid
> header start. Fall back to the network header when the mac
> header was never set.

I wonder if the right fix here is to not call skb_unset_mac_header in
the first place.

There are plenty of L3 device type with no L2 header. They still have
a valid skb_mac_header.

This fix may be papering over a tunnel doing something non-standard.

> Fixes: cf329aa42b66 ("udp: cope with UDP GRO packet misdirection")
> Cc: stable@vger.kernel.org
> Reported-by: co+98d7de09cd94fec5@bugs.sh
> Signed-off-by: Boyan Liu <yymhvert@gmail.com>
> ---
>  net/ipv4/udp.c | 5 ++++-
>  net/ipv6/udp.c | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index bb8cfc62c..fe5a23f1c 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2441,7 +2441,10 @@ static int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  		return udp_queue_rcv_one_skb(sk, skb);
>  
>  	BUILD_BUG_ON(sizeof(struct udp_skb_cb) > SKB_GSO_CB_OFFSET);
> -	__skb_push(skb, -skb_mac_offset(skb));
> +	if (skb_mac_header_was_set(skb))
> +		__skb_push(skb, -skb_mac_offset(skb));
> +	else
> +		__skb_push(skb, -skb_network_offset(skb));
>  	segs = udp_rcv_segment(sk, skb, true);
>  	skb_list_walk_safe(segs, skb, next) {
>  		__skb_pull(skb, skb_transport_offset(skb));
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 93478d1ad..8db4e2869 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -895,7 +895,10 @@ static int udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  	if (likely(!udp_unexpected_gso(sk, skb)))
>  		return udpv6_queue_rcv_one_skb(sk, skb);
>  
> -	__skb_push(skb, -skb_mac_offset(skb));
> +	if (skb_mac_header_was_set(skb))
> +		__skb_push(skb, -skb_mac_offset(skb));
> +	else
> +		__skb_push(skb, -skb_network_offset(skb));
>  	segs = udp_rcv_segment(sk, skb, false);
>  	skb_list_walk_safe(segs, skb, next) {
>  		__skb_pull(skb, skb_transport_offset(skb));
> -- 
> 2.43.0
> 


