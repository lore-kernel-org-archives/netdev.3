Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB921CC59
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 19:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787425685; cv=none; b=sGRm/p60p+WYL2+kpN/vY65ej2DkP562rq+WUOmZtbXYLg//l/GDs3pm4nHr6LmsTXjGz4F16tt9/plGcijJT84mq1dMJquy531uZd1XssQQDxFjOUWF4ifDxuHOMR2ZVluyeFRz6yX5LQQ8MowRFd/hV1c00SrkmiQvPqvp43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787425685; c=relaxed/simple;
	bh=nlzD+HI2CotqBoDg2cfbRpxIBRaCDNa+5SBfJRxQEb0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=QjJZ7mJ0bPOYdvu16OoC2FOpuj4eLY+qc4lhUEj0d0vdZ2XVwUk+LwwnluupLu79Q5rKmhimQmfBtChG/Mcngr1LUCwbPh8DuvX8bK99+0VBT6TTA3n/o7AjEXi9siFSReHqb1bxpiFChhne84sgXs3ksd/xSaPd2Zk2wx9+lmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXuaU91B; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXuaU91B"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-836c436a6b3so30551867b3.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 12:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787425683; x=1788030483; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VU6sQhTOFVKq3VZMPwUehZTnjPKLxnr9SGeCgOw4ldw=;
        b=YXuaU91Bpe/zf3Qn/oXfZkLfXRaTR9kjGv+E8RhhIp9EpMZCkufXSF75x4bsBuACMj
         IMQ2dgRkyDmCnSDVgZtQFecLA+QL0ABVahGe61jWIVu2Q8gNHNZjYqobYKLvpCdEOtyF
         aegAPYACeMUy+GD0GB6xzvhy/mmLLy28CXSZhcbd0BUOWz70bCk5KFkPuSLFumYXEjnl
         pBYyfuUo5Je7jYtR8uuUbPiuMKEhCypAqm4QTvXa6l8/0gS9+r1ycrw9/+01X3oV/v6+
         maPd5YpEzdiO8g1tNt4qCglWrWluHz9mcIMtjVBNs/QTfovP9rmp64AtG8qeaVXJni/d
         7O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787425683; x=1788030483;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VU6sQhTOFVKq3VZMPwUehZTnjPKLxnr9SGeCgOw4ldw=;
        b=kOu2UUfWzCUCdYKy5czTojH3MsWQtveHFOTgABZa0jAHu5lSJT1mgqIdiqxhYaRRzu
         AZQiVrtL5jcon+LbIyUAIJ7zCNw4YDU39pQmMAx64b4Is4SNUWfogP+ZDDHNpRUQyBex
         3g92oDNkSTJlTNVieigZ1e07fTLgSyqyAl14myBn2sxDdU7v7PeZ6N2AlhGf5AoWP3YV
         UDazwzfWmZAU0f0HGhn1ZGCDZH3+X69KKCxHcdS3ac6KArKXTcTVYiQWJjatClxFdo4A
         dXuDdwTM9RSHCdE0WHox6P/klCXVAtFSGYI+1wSJBFltM5rc0PusaRZ/OXjddJe6WZzE
         MmXw==
X-Forwarded-Encrypted: i=1; AHgh+Rokuv7wuXDRXF8LlttWozfevL1bEVH+9Q0BNn6u7FO2c8oaKWSyHYE/WQm8wyWSkjUbgTZ5kxg=@vger.kernel.org
X-Gm-Message-State: AFuF++kCwG5cveeYpn5tINyAsCaVsIT4bv/Lh+A3eAHoqOmLIoIJJkux
	lUoXGNMQpgm2V+gSusvdRZPPwKVskfmP5emrZe0KDGxYlfb45ApE1cA2
X-Gm-Gg: AR+sD133cj9gDZrJSFB3r6reDbfe6oaFXiT7HdnGXfk7WTvDpnuTCrcNORvDDf6D/pm
	Ie3UrKbECWErB5Pbj1DZCbBUKd4kJlCQYDQbSuyyAljV7BY5HlOhNitmKb4cxHDExYBOFdbY6Ht
	/XX1cYXU4VOnE7DpyJvDRdwt2bYYFjRX0sBS3YYC4BTQpeKT1b9HA7Yc6z8KMKv6GWdDpJ+k4aG
	zalNe2UA7MSTQ3p16ScC26QJqc25YhDHq41Sbtaxsm+lPS5L52rpXxjXVE8jXdBlfkBdwk5UcjN
	d+j9IyCLDC/TVJspLVhh2Eqx9hRen3ZiAgkY6in0yY5G1ZdL8GXWNHarQNe1tm3smMOZoUQfzbq
	G1JZSs6sxNzqFuQl41GtJ8SQfdqlOcjutvwhCjdlIP1XBwtF6ckfTWYdf3amyGkCO6SeXoh1UbY
	J5f1JLQPKXNFOUiw3SxlcFv3f4bTTZrqWRJPHYLWYafQX3pY4OrXGwwr5xW6JmmB6axyj7u+Lbo
	n50O2GOOEesgogivpERX4kH/YOp11Oibi/qDoe+Rw==
X-Received: by 2002:a05:690c:a9e:b0:845:ddf4:a3a7 with SMTP id 00721157ae682-849f2456e27mr68814897b3.16.1787425683281;
        Sat, 22 Aug 2026 12:08:03 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84caabb9e7bsm13507527b3.28.2026.08.22.12.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:08:02 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:08:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mariano Baragiola <mbaragiola@linux.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 willemb@google.com, 
 kuniyu@google.com, 
 littlesmilingcloud@gmail.com, 
 Mariano Baragiola <mbaragiola@linux.com>
Message-ID: <willemdebruijn.kernel.13d69ffd770f1@gmail.com>
In-Reply-To: <20260815141128.1564949-1-mbaragiola@linux.com>
References: <20260815141128.1564949-1-mbaragiola@linux.com>
Subject: Re: [PATCH] udp: resubmit encapsulation packets on all multicast
 listeners
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mariano Baragiola wrote:
> UDP encapsulation handlers (FOU/GUE and similar) return a positive
> protocol number from udp_queue_rcv_skb()/udpv6_queue_rcv_skb() when the
> UDP header has been consumed and the packet must be resubmitted to the
> IP protocol handler. Unicast paths already propagate that return value.
> 
> Multicast delivery called consume_skb() on every positive return, so the
> inner packet was dropped instead of being reinjected.
> 
> Commit 3cb8d4b9bfeb ("udp: fix encapsulation packet resubmit in multicast
> deliver") fixed only the primary ("first") socket path on net-next and is
> not yet in net.

It is now, so this will conflict.

> Secondary listeners still clone the skb and drop it on a
> positive return, and net itself still drops the primary socket path too.

When I asked about additional listeners Anton responded:

"
The clone loop is not reachable for encapsulation sockets, so there is
no remaining gap.

FOU/GUE tunnel sockets are created via udp_sock_create() /
setup_udp_tunnel_sock() and do not set SO_REUSEADDR or SO_REUSEPORT.
Without either, a UDP socket cannot share its port, so an encap socket
is always the only socket bound to its port. In
__udp[46]_lib_mcast_deliver() it is therefore always delivered as
'first', and the clone loop -- which handles the second and subsequent
sockets in the group -- never runs for it. The positive (resubmit)
return from udp_queue_rcv_skb() only happens for encap sockets; plain
UDP sockets return 0 or a negative value there. So the resubmit case
in the clone loop cannot occur.
"
https://lore.kernel.org/netdev/alAAXv60KUZ9KYx1@dau-home-pc/

> Resubmit secondary clones inline via ip_protocol_deliver_rcu() /

So is this a real path?

Small caveat on the SO_REUSEADDR/SO_REUSEPORT: SO_BINDTODEVICE
is another way to skip the equality check in udp_lib_lport_inuse2.
> ip6_protocol_deliver_rcu() (matching the GSO segment path in
> udp_queue_rcv_skb()/udpv6_queue_rcv_skb()), and propagate the primary
> socket return value with the same IPv4/IPv6 sign convention as the
> unicast helpers.
> 
> Fixes: ca065d0cf80f ("udp: no longer use SLAB_DESTROY_BY_RCU")

Fixes should be the above patch if that is incomplete.

> Signed-off-by: Mariano Baragiola <mbaragiola@linux.com>
> ---
>  net/ipv4/udp.c | 16 ++++++++++++----
>  net/ipv6/udp.c | 16 ++++++++++++----
>  2 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 70f6cbd4ef73..d6a17b0462b6 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2475,6 +2475,7 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
>  	struct udp_hslot *hslot;
>  	struct sk_buff *nskb;
>  	bool use_hash2;
> +	int ret;
>  
>  	hash2_any = 0;
>  	hash2 = 0;
> @@ -2508,8 +2509,13 @@ static int __udp4_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
>  			__UDP_INC_STATS(net, UDP_MIB_INERRORS);
>  			continue;
>  		}
> -		if (udp_queue_rcv_skb(sk, nskb) > 0)
> -			consume_skb(nskb);
> +		/* >0 means the encap handler wants IP-level resubmit. Do that
> +		 * inline for secondary listeners; only the first socket can
> +		 * propagate the protocol number to the caller.
> +		 */
> +		ret = udp_queue_rcv_skb(sk, nskb);
> +		if (ret > 0)
> +			ip_protocol_deliver_rcu(net, nskb, ret);
>  	}
