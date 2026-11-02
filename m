Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608244;
	b=1i798FJcaX3d+5B4Sy59dmZibPQHzA1qS2OKbhm6B4JUW+LyB/jBdASRG+aJAUyAMcI6
	 R6qwOiGdZ0X+pgKXlA29MTnppu7QbjEE5Xpake81jAE1tQUmNXxPTk2OiAVkhr9RvJtMR
	 dwcW5KnKcIESa7BYGo3qnFUf8+PpAhCBJ218gX9sp5CJzXNuhwnjGNv8ln2S2La+uvvsv
	 WQNmtM4eHixh1j6ru8+BTUFI7054zOzht542c/Kc9u6PCdvfv30ENjOh1FZ5yZPoB5ri4
	 Obmd2Un/5paRuey6HKPBw1oHmQHULj4QYV3REy5MXR2E18oXoC6BzmLbUmTN9opPxWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608244;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5s76/dPbnbGsFp3iD/3eY/lNo7HD3Wsji3799x/Jvuo=;
	b=R3SM+H5Xt0lkC+zlif4GMlNkMIe1qv/JyWMlCg8TTPL9c9uf8j0nLchbVvukd7gaxeeC
	 XlHzzOKCSqL+1URMg8/8op9BA5+2wLyEXI854sWUe+h6IbHh0CKyeE7pDbQiS06EhgWAn
	 K8iYzBwrwFZgOo4k/5vChvRTer3cPKNIuPKcy6M7IJI14L+Ai1nPNn+7c2ivVLu4i5BI3
	 dcf7ElBEYDLiRRVhkvx/29HFY1xCeDhqGuN+oyWIhubeIlp2z+xHi8xkg9rlXK2rwJekw
	 U+FWl/QUFUU5X7/C5qhe2R3oQJZiqfx6y94nsOmldBCfOwQyfftFneDANCXBNODxavg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMZg+Tkw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B301606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMZg+Tkw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A2A1F00A1A
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608244;
	bh=5s76/dPbnbGsFp3iD/3eY/lNo7HD3Wsji3799x/Jvuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CMZg+Tkw5Jo+9xUCXuDsaRYcVX5newUDEVbN7bvQWktuPdRWnKttM3yQSdCu8nI/q
	 MjuUMxhZQBDu6FMj6yJsvZpezYKozaGjeZuM+RaZl10ACEc/0e5PQx5nMRh1Wmcr4f
	 HgWFnAQGRfsihWw7TkDc0I/mp8vULrWV5qB5F3fJRd4TXKR5+7kdixnI6tw54qxR39
	 XBwkbo9vocOTrvDWIapIyyPV9ewotZFQCkezNgyaD/xzeYLjRmXeWc2Y9o4rjn9nry
	 3rq/WsF63MV9ne7YMuFta1jnyTmcY2wmyKsKQH3Ng2+cE62EvZITjErBfO4v7lnyXs
	 uiiTkPlQAyfKA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6df0b02fe91so2843927eaf.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 00:30:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByBCgYoOLw2y7kRh/gB4HEiXTKSQPEr5iYnEjTyPzhqGoehO/LkT7uHSi6C84GahvqqRqRx7c4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLGjAW7PeAUGmJxs8zn3QDOnOKMXhSZ774hDyn+s5pAbukst9Xs
	CRxqa+1RCMrdsnBluvsxanGGkdlmeuhjPFEmH6zTq5R3BswoAytivgdXhi/i4ONq9X/VGb1E2fH
	GfIwDsiX5PCIYDf3yUEFU1vrzB/ItHco=
X-Received: by 2002:a05:6820:1608:b0:70a:347e:4ec2 with SMTP id
 006d021491bc7-714de00bf06mr6432803eaf.68.1793608243486; Mon, 02 Nov 2026
 00:30:43 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102075441.3771550-1-edumazet@kernel.org>
In-Reply-To: <20261102075441.3771550-1-edumazet@kernel.org>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 2 Nov 2026 09:30:32 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiq+jyCzpW3j_tNiMpgA0SXvqRg9yzOPDj7pBJPcrb8TGg@mail.gmail.com>
X-Gm-Features: AclHuK_UgdCkLiyNYFt1950dQSLPmdeGhwHHn3lACIRH2qw8xutu-XASgKphia8
Message-ID: <CAL4Wiiq+jyCzpW3j_tNiMpgA0SXvqRg9yzOPDj7pBJPcrb8TGg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ipv6: do not read ireq->pktopts from tcp_v6_send_synack()
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Anvik Loitongbam <permissiontogallop@gmail.com>, Yingjie Wang <x-professor@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 2 nov. 2026 =C3=A0 08:54, Eric Dumazet <edumazet@kernel.org> a =C3=
=A9crit :
>
> When IPV6_FL_F_REFLECT is set on a listener, or the
> net.ipv6.flowlabel_reflect sysctl has FLOWLABEL_REFLECT_ESTABLISHED,
> tcp_v6_send_synack() reflects the flowlabel of the SYN packet,
> reading it from the skb stored in ireq->pktopts.
>
> Since commit 079096f103fa ("tcp/dccp: install syn_recv requests
> into ehash table"), request sockets are processed without holding
> the listener lock. A cpu can then process a retransmitted SYN for a
> request socket, and send a SYNACK from tcp_check_req(), while another
> cpu receives the ACK completing the 3WHS. tcp_v6_syn_recv_sock()
> consumes ireq->pktopts when it wins the hashdance, and the first cpu
> reads a freed skb:
>
>   BUG: KASAN: slab-use-after-free in tcp_v6_send_synack (include/linux/sk=
buff.h:3152 include/linux/ipv6.h:110 net/ipv6/tcp_ipv6.c:582)
>   Read of size 8 at addr ffff88802b08b608 by task poc-ipv6-pktopt/5076
>
>   Call Trace:
>    <IRQ>
>    tcp_v6_send_synack (include/linux/skbuff.h:3152 include/linux/ipv6.h:1=
10 net/ipv6/tcp_ipv6.c:582)
>    tcp_rtx_synack (net/ipv4/tcp_output.c:4719)
>    tcp_check_req (net/ipv4/tcp_minisocks.c:762)
>    tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1826)
>    ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
>    ip6_input_finish (net/ipv6/ip6_input.c:534)
>    ip6_input (include/linux/netfilter.h:325 include/linux/netfilter.h:319=
 net/ipv6/ip6_input.c:545)
>    ipv6_rcv (include/net/dst.h:481 net/ipv6/ip6_input.c:119 include/linux=
/netfilter.h:325 include/linux/netfilter.h:319 net/ipv6/ip6_input.c:351)
>
>   Freed by task 5074 on cpu 0 at 15.412249s:
>    kmem_cache_free (include/linux/kasan.h:235 mm/slub.c:2780 mm/slub.c:66=
30 mm/slub.c:6757)
>    tcp_v6_syn_recv_sock (net/ipv6/tcp_ipv6.c:1528)
>    tcp_check_req (net/ipv4/tcp_minisocks.c:934)
>    tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1826)
>    ip6_protocol_deliver_rcu (net/ipv6/ip6_input.c:479)
>    ip6_input_finish (net/ipv6/ip6_input.c:534)
>
> Request socket migration has the same issue: reqsk_migrate_reset()
> transfers ireq->pktopts to the clone, which can be freed while
> another cpu holding a reference on the old request socket is still
> sending a SYNACK.
>
> The SYNACK timer itself is not an issue, because
> inet_csk_reqsk_queue_drop() calls timer_delete_sync().
>
> Save the flowlabel of the SYN in the request socket instead, so that
> tcp_v6_send_synack() no longer needs ireq->pktopts.
>
> As a side effect, the flowlabel is also reflected for SYN packets
> reusing a TIME_WAIT socket, as ireq->pktopts is not set in this case.
>
> Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
> Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash tabl=
e")
> Fixes: c905dee62232 ("tcp: Migrate TCP_NEW_SYN_RECV requests at retransmi=
tting SYN+ACKs.")
> Reported-by: Anvik Loitongbam <permissiontogallop@gmail.com>
> Reported-by: Yingjie Wang <x-professor@outlook.com>
> Closes: https://lore.kernel.org/netdev/82c31e4d5043f3dbd11b44177cfba779d3=
35aae3.1793599929.git.x-professor@outlook.com/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> ---
> Initially reported to security@ mailing list by Anvik Loitongbam, with a =
patch.
> Anvik Loitongbam provided a reproducer.
> I was able to trigger the ASAN warning before the patch, and checked
> the warning can no longer trigger.
>
> Yingjie Wang also sent a public patch later, very similar to Anvik's one.
>
>  include/linux/tcp.h | 3 +++
>  net/ipv6/tcp_ipv6.c | 5 +++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index d18f7bc1e5d0f73c1c7452fbc573fa7cb38b206f..5a4c61fc240ec2d4554795cea=
7bbd65bbea0ef02 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -179,6 +179,9 @@ struct tcp_request_sock {
>         u8                              ao_rcv_next;
>         bool                            used_tcp_ao;
>  #endif
> +#if IS_ENABLED(CONFIG_IPV6)
> +       __be32                          syn_flowlabel;
> +#endif
>  };
>
>  #define tcp_rsk(ptr) container_of_const(ptr, struct tcp_request_sock, re=
q.req)
> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360eae1b43a4d53173b46b931ae668825..d406cd3c8ceabfdbb66f3e1b4=
f9e9a74754e8d0b 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -578,8 +578,8 @@ static int tcp_v6_send_synack(const struct sock *sk, =
struct dst_entry *dst,
>                                     &ireq->ir_v6_rmt_addr);
>
>                 fl6->daddr =3D ireq->ir_v6_rmt_addr;
> -               if (inet6_test_bit(REPFLOW, sk) && ireq->pktopts)
> -                       fl6->flowlabel =3D ip6_flowlabel(ipv6_hdr(ireq->p=
ktopts));
> +               if (inet6_test_bit(REPFLOW, sk))
> +                       fl6->flowlabel =3D tcp_rsk(req)->syn_flowlabel;
>
>                 tclass =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_reflec=
t_tos) ?
>                                 (tcp_rsk(req)->syn_tos & ~INET_ECN_MASK) =
|
> @@ -789,6 +789,7 @@ static void tcp_v6_init_req(struct request_sock *req,
>         ireq->ir_v6_loc_addr =3D ipv6_hdr(skb)->daddr;
>         ireq->ir_rmt_addr =3D LOOPBACK4_IPV6;
>         ireq->ir_loc_addr =3D LOOPBACK4_IPV6;
> +       tcp_rsk(req)->syn_flowlabel =3D ip6_flowlabel(ipv6_hdr(skb));
>
>         /* So that link locals have meaning */
>         if ((!sk_listener->sk_bound_dev_if || l3_slave) &&
> --
> 2.53.0
>

It seems we also can drop REPFLOW condition from tcp_v6_init_req()
This means each pending request on a REPFLOW-only listener would no
longer pin a full SYN skb.

I will send for net-next:

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index d406cd3c8ceabfdbb66f3e1b4f9e9a74754e8d0b..8ad5f13d4a74f025bc47a4336f3=
c518cca773315
100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -800,7 +800,7 @@ static void tcp_v6_init_req(struct request_sock *req,
            (ipv6_opt_accepted(sk_listener, skb, &TCP_SKB_CB(skb)->header.h=
6) ||
             np->rxopt.bits.rxinfo ||
             np->rxopt.bits.rxoinfo || np->rxopt.bits.rxhlim ||
-            np->rxopt.bits.rxohlim || inet6_test_bit(REPFLOW, sk_listener)=
)) {
+            np->rxopt.bits.rxohlim)) {
                refcount_inc(&skb->users);
                ireq->pktopts =3D skb;
        }
