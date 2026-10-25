Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792925429;
	b=0QMd0A5wzhQKVzQRyECNH0pmnCtB4Xg6OzNwPoZ2XQXRnKY2aNkgO44345FQuCs6kddF
	 W2pIUn5Wae4c7iOnF4PtufMZFW4XwWNNAjafF4n9Hm3T0hq6eEtNVvRLfY8ckHaDwjB7J
	 CLwwDaK7QDyFZqHaf2PwU41ksUguYpIaIwEOsJ7q+JZerEp7NHa2d/QY3+juHo9FPfuKu
	 xgS89Qok936G7sQi5Cskd96mZLQwbZL+i/uVg4fNadZvYCXElgy0pH5pZZgBW3aymdONw
	 GVK3LW+htpTkC8wzalv3MSW5hqEr6+vs5GUtJ+iGQ89rsi2nKGPsmH9V7/8IbK0b+1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792925429;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Z34xT/KTKRp/P6iMZZaSFLF0nWR84Andajbw0zEcAS8=;
	b=DENaqdKksalfVM7yzIMePfeGor67Xdahm3arpyHejZqdeiPDzmtMTzr1naUQOOFYzSpC
	 ReYAtzpnH9biNIb7nAe9Wjgi3QxfyzG7wX1gwZUku0p19tMM6NmBby/66uO7hR5kQ8jgU
	 TsfXf6x82ioU1MCenspS1pWG8Gz4X/VUY67ZLt33Pd+jKE0ttc8ANxVrXPxs7+unxzUUi
	 8mBwqb7QsZMamvlmY0qhqpfVE4fhePVbg7H9B3QfIZRt6UkqxVuh2Wc8nbE1jy1AaDrlv
	 xRMJkMJGc3chY8xPbhw4ni2tqZQUlIZ7pX2lvWtyj0jDbWvCK4HVWcTalPDKV8AQFHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFwr+M2m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15523606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFwr+M2m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9D81F031E0
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792925428;
	bh=Z34xT/KTKRp/P6iMZZaSFLF0nWR84Andajbw0zEcAS8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TFwr+M2mBb4O4usMtJFqfWff6YuKRG6P0Ln1Ol9/aUoQpuC1DNZSwTFBFiwDH/Uy0
	 v2tx5SEKg7++6Rghsiw9TjL6HrkacDHwUhJJu69SrjamP4yA9jebgjLA61YhQwd8Qa
	 L28hbw9GSdbxLAZkHfurPEEWU3O10e97QccWhSmncFqR20vMtiSy8+ay5EHFJ5oVdV
	 G79TRVCd1brZe+H8qNhScJcdwG+ABB541TtYgqwxxrPSFZL25gIUFhuB0jDd2/JJJp
	 rz0JC6DznHKjSPmeFdfS9uSGPkWhNYuPyfmjmdtLtQMb08QExr1t4n0DBrpgQFLaZl
	 XeuRF4WL1A7/Q==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-451a49abd8aso2256682fac.3
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 03:50:28 -0700 (PDT)
X-Gm-Message-State: AFq9FYKcX4H7d8tjcXYb+exrY+GDSDn8UVVkIGNx5MerE29O7CZYmDpz
	05oLghuorchSkv1eZkZtOL/MBs12PzNvXuYb+uJDWqManF8nffTcDK/54//bfglM5f6cRmrNdip
	ThcfXLCOHvKnxiwXAlxDLal5aa8dqFaI=
X-Received: by 2002:a05:6870:2c49:b0:491:520f:e6d0 with SMTP id
 586e51a60fabf-4a83f00d327mr2211468fac.4.1792925428140; Sun, 25 Oct 2026
 03:50:28 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025071729.34967-1-idosch@nvidia.com> <20261025071729.34967-2-idosch@nvidia.com>
In-Reply-To: <20261025071729.34967-2-idosch@nvidia.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 25 Oct 2026 11:50:17 +0100
X-Gmail-Original-Message-ID: <CAL4WiiovWOOQ9PBPbnPk2=rK+V5WgMpOFh814-D6_A-k5ope_A@mail.gmail.com>
X-Gm-Features: AclHuK-JgswlkfMhiZ2fs2aB1d2-JI9OOSyqjldUoMV99nSOE8B2ON7VxY1KuxE
Message-ID: <CAL4WiiovWOOQ9PBPbnPk2=rK+V5WgMpOFh814-D6_A-k5ope_A@mail.gmail.com>
Subject: Re: [PATCH net 1/2] ipmr: fully initialize the synthetic IP header in ipmr_get_route()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, 
	yoshfuji@linux-ipv6.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 25 oct. 2026 =C3=A0 08:18, Ido Schimmel <idosch@nvidia.com> a =C3=
=A9crit :
>
> For an unresolved multicast route query, ipmr_get_route() builds a
> synthetic IP header in the headroom obtained from
> skb_realloc_headroom(), which does not zero the memory it allocates.
> Only a few fields are initialized, leaving others as stale heap
> contents.
>
> ipmr_cache_report() copies this header into the IGMPMSG_NOCACHE report
> that is queued to the mroute socket, so a recvmsg() on that socket leaks
> the uninitialized bytes to user space: the 'tos' field [1] and the 'id'
> and 'frag_off' fields [2].
>
> Fix by zeroing the IP header before filling in the few fields that are
> used, so that the entire header is initialized, as in ip6mr_get_route().
>
> [1]
> BUG: KMSAN: kernel-infoleak in _copy_to_iter
>  raw_recvmsg
>
> Uninit was stored to memory at:
>  ipmr_cache_report
>  ipmr_cache_unresolved
>  ipmr_get_route
>
> Uninit was created at:
>  pskb_expand_head
>  skb_realloc_headroom
>  ipmr_get_route
>
> Byte 1 of 28 is uninitialized
>
> [2]
> BUG: KMSAN: kernel-infoleak in _copy_to_iter
>  raw_recvmsg
>
> Uninit was stored to memory at:
>  ipmr_cache_report
>  ipmr_cache_unresolved
>  ipmr_get_route
>
> Uninit was created at:
>  pskb_expand_head
>  skb_realloc_headroom
>  ipmr_get_route
>
> Bytes 4-7 of 28 are uninitialized
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <netdev-bot+sashiko@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0545f0c83f5ee=
2f6696210f87268e811ef655715.1792476357.git.zhilinz%40nebusec.ai
> Assisted-by: LLM
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/ipmr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index acacaae05cc4..eac23f251bfd 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c
> @@ -2506,6 +2506,7 @@ int ipmr_get_route(struct net *net, struct sk_buff =
*skb,
>                 skb_push(skb2, sizeof(struct iphdr));
>                 skb_reset_network_header(skb2);
>                 iph =3D ip_hdr(skb2);
> +               memset(iph, 0, sizeof(*iph));
>                 iph->ihl =3D sizeof(struct iphdr) >> 2;
>                 iph->saddr =3D saddr;
>                 iph->daddr =3D daddr;

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

SGTM, I will send this follow up as a separate patch.

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index acacaae05cc49dc15910f23f7539865432518587..8b84142fd7754d95aa1f2facf68=
ac554916efd27
100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -550,6 +550,11 @@ static netdev_tx_t reg_vif_xmit(struct sk_buff
*skb, struct net_device *dev)
        DEV_STATS_ADD(dev, tx_bytes, skb->len);
        DEV_STATS_INC(dev, tx_packets);

+       /* skb->cb[] holds qdisc/tc state at this point, not IPCB.
+        * ipmr_cache_report() reads it as IPCB to build IP_PKTINFO.
+        */
+       memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+
        /* Pairs with WRITE_ONCE() in vif_add() and vif_delete() */
        ipmr_cache_report(mrt, skb, READ_ONCE(mrt->mroute_reg_vif_num),
                          IGMPMSG_WHOLEPKT);
