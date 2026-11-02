Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793627273;
	b=gxN8PlTnTaFZt2CtTiPUPCsoEj6ZlfBVkcslYiqJx5lpR/9VRMdzH85ygg8aa8UbnbzJ
	 /tcQyr2v3nT1v/G/DTiHHfYdiYWPQ4Z/klyXItG6D9f2VTK8rUr/7Hs1ZzdvluMic1C4V
	 zH9i92uPBoKmqG/kGcfiDccZE/CCsvOyxwrCpc3el4uL+l/DSMigP6P2H/HMC+NDtd1n+
	 HzTCxlFnoXqIOoV4PfehPgVGJss8kqgscoM6iS2TCD61wS1OVhLqdIIWzEjc0XkUarGCx
	 mRL0agumxBCU0o4WD1VkWvi79MxR/xwbTT4lkckgk/RoLj0XLIzYlipUW9Bx4e3GkEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+mldpVLPlQnq3/x+KOthd6iJipy1y8q2lgK6yPhxf6Q=;
	b=Rbh5LlMtZE8FWCAPAl9KuB5fxq5hXU1lJO1RQb+rnM71FvBOjHOlHKzhz5KujB3Eg1Y9
	 o2yaEikeem3EKqI90n2+StdznddqtheUxGxogT+h8lETPZItNQ7pOTMgU9tip2MI2UudM
	 O4ikFKjqQ6PlbjN8NjAsrrYfHe/Itr6aX1TGeA/78O9W5PRNnySabn4lBaPq2g/61b/IG
	 cfRR87/qpbYdSsj0U2B+Z0VxUDt4VZ2eWIIZIXdzaKj290AkfHzlVnBoxrZSAm00P9aYK
	 AbTeyaPbnqXhp4rQg3gGMeaxTLzRhIpc5vrAfJW5cThlGcxJf9EbzOgX5YMuLXwozXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Wsf/18cS";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE21606A327
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 13:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE21606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wsf/18cS
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-535f598d126so394641cf.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 05:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793627272; cv=none;
        d=google.com; s=arc-20260327;
        b=E2a3vtdRP0EjIqKz35RCZBEuUWMZVXfiw6QElsKC3DlkmPq8JFYQVsDevTqbGSFqmY
         VrIDDfW4S9bKV4vnhw8eaUVbNh/IVUE/ZXvVLKyVWfgkiDMnwz10LO9P7v/BMLGTxXAj
         S8V5uI+cSSwqWd5hdsXO9WbHCTZCHZGJfDkKVh31FxLuKMWDJnUtWT0luKM31GKaWutE
         e55zJCGx9irLaeXjjeHVBFgsPyGYkLrfigRx6lVXBxiCzKv3E3cCDcASDSmpaXrYpmHu
         mYW2xLF/x9Doc7V/FXPXwNWKxlRAr21eijjyWRKLDPX+FjDDjlk3db4+MT88tCGHLB8J
         eF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+mldpVLPlQnq3/x+KOthd6iJipy1y8q2lgK6yPhxf6Q=;
        fh=hgW0gBkT2nnrRopC7u4gQGWtBfo03QyBb8cZg8Roz3o=;
        b=m0S/OHnrFG2arlcm5MWUh2fG8U2zN+eKIGFJWzEnmFvV3WE83bNp8KjglAJvS2OAtc
         /DKzb5XCYPp9FbNkVOSDR+WvJimWFkUgs3jZQPS/EaNyr+9bCCp8IOyXWO069eW05VwV
         JUnO9BizGboghosJXJDb/L94RNdobUSswFVlxH7LfITCPLnrhZcw7qJXAsRu17YCpJ+P
         iOKs/pb4LddJcrGaS3s9Wo75O1UDiQvYZ3ihWdr/qByk4SDkxmOlspkoGOJkDwttxWoI
         f35GhP8gYIqtpLXz0Rw1FjzPHorrihIcujWeGxZo/FnD5qOS5Luix2wSnNFXBOHn3y+L
         ULww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793627272; x=1794232072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+mldpVLPlQnq3/x+KOthd6iJipy1y8q2lgK6yPhxf6Q=;
        b=Wsf/18cSS20mc1Io2LTD3dhhoX7YJljM3FU26R6KwV+JFfAq6VHrv1FkWO8KeNYE3i
         g253MpFPvIGyfsds9yg/4HhRHVnwGhCLJtzTPqwPjatEVdRJcjfvAY5W1Z7n28OB5vTV
         pCatGRw9AKpTAN+fIcL+TlrSbd8CUbU/Eyw/9VxF8aEYGHurHAndR+KiDmXIAIsM4I3H
         TvOXgWrqL8UsQQi3sGjwl4lKI9j8gd8MTWN3dlSaZwjzGSOVjEQX7+yNnllULr4IvQs/
         9YD9vRAoUMN5BSj/48DzvMceFzgEmvGiyv7KresgB+w3mtpy1XMivQ3aLpZAcFWAnJoZ
         fmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793627272; x=1794232072;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+mldpVLPlQnq3/x+KOthd6iJipy1y8q2lgK6yPhxf6Q=;
        b=D3S9RFsvRplrPdMxgg9PykAMXcjawDeVAQJEDvR8XvPKxkabuuj8w5JQM2m8gwc3va
         m13GUEY5KDAhgitztPRFk5XTZBeD+k5ibrcdW1lW0NCxrzttQa/KHPxm0p/MJDkT/yhQ
         5VTBNNmwbENueDxcPLb7Muq4TSy3tLJWkhawuz2+A+ADDGK0g/pyqYv37jm/DlT6bmuK
         WiA2F2wO7b5YwEXxZ/3Olsm2vWTCGj6odENb4vO6GiGyUUCuKfr1j81BeUF5yI8Cu3PS
         k4iT6Cw+htlgnKbGAUR9j2SITQqLipJfIRQHu2L/WFa4hIQX3JQGbQE09WAcZDkCSbc6
         dwiA==
X-Forwarded-Encrypted: i=1; AKwUvByRk3uOiT/UoiO62wJTiwnGAmG5LiCG6rJG2MzrXIEmtXJg2yLZOy/EPUWhfQ909P6GAkKibJs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiiRrhU4WpGCdLvkXvGeCcQPJ2uAxwTmlkJpn+fCqg0wYAqvbT
	zx7s8rQfzzXSxvVF4GfIapcF7ozFAJErdPC9sqgZyJAJa+CPJIKY0aTsnZi1jTqQnbIjpD+ap8y
	Vxk3+2tBCCnW62vJWzjbhBEPptmktq427FT35MhUN
X-Gm-Gg: AYBFou1RTkRofzTq3hznuxW88yhIohm8cAsZ6ax2tgUCWdJrV6dZkBhJQBc6W1lXv4O
	YJWAUOzQE3q1CWG7Owi/EsM8KIESfkDs/X9sI8Mo0KIf5K7ctRplIhxUxJKZfB3BpkjnG+zCW6k
	qkoleVz1jjQhLv90646fmj+0ATqGDgbefrTpvAnPT5M10P0c/vOt8xqwu2+QWJYMs5NcgiYRoa2
	rew7IrVIc14CamXXDixfXOCA2nmUUZSIa93EJ/NkqrI/+zQo8dqdG3EnG5YaIyOrwLjddY/soNw
	6vUGVRXQygYZQPriBBs9EqhE/41yTg2cYs44yumtbjQBUW+wno/n6fufNkZYnBhPOVsefEb3Rye
	uWIEoe/LUJZolVFy+jXUnPxlwk0cNDdtQoXoaQb53b2VJlLnM8k9pzfSMxVQJcvUiVJ2IB5QYtS
	1GfmJuoxCQFAUMb1jbIV/DU2XW6gNr6GmZS4Ye6TBK0YU70sPb
X-Received: by 2002:a05:622a:2608:b0:536:3d22:fb83 with SMTP id
 d75a77b69052e-5414e501b6dmr90077681cf.13.1793627270156; Mon, 02 Nov 2026
 05:47:50 -0800 (PST)
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
From: Neal Cardwell <ncardwell@google.com>
Date: Mon, 2 Nov 2026 08:47:32 -0500
X-Gm-Features: AclHuK9LNgZCDHMup2z-73ziA1Fju_XmQdSBMyRa5EWMrMkhcPyzGKY_DeQX83s
Message-ID: <CADVnQy=yWFLCMYyoTDUJBLciiM_N17H6DT4mvLq92N=ZC3UmkA@mail.gmail.com>
Subject: Re: [PATCH net] tcp: ipv6: do not read ireq->pktopts from tcp_v6_send_synack()
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Anvik Loitongbam <permissiontogallop@gmail.com>, 
	Yingjie Wang <x-professor@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:54=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> w=
rote:
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

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric! The fix looks correct to me, and I ran it through two
frontier LLMs, and they agreed that the fix was correct. They also
suggested your follow-up change of:

-            np->rxopt.bits.rxohlim || inet6_test_bit(REPFLOW, sk_listener)=
)) {
+            np->rxopt.bits.rxohlim)) {

So that follow-up looks good to me and the models.

The models suggested two tweaks to the changelog. AFAICT their
suggested changelog tweaks are correct, so I'm including them below
for discussion and completeness, in case it is worth respinning the
patches to update the changelog:

(a) The changelog says: "The SYNACK timer itself is not an issue,
    because inet_csk_reqsk_queue_drop() calls timer_delete_sync()."

    This looks carried over from e3f33b0a1d89 ("ipv4: free inet_opt and
    ireq_opt after an RCU grace period"). It is true there, because
    ireq_opt is handed to the child, and the child cannot be freed
    before timer_delete_sync().

    It is not true for pktopts:
    - tcp_v6_syn_recv_sock() frees pktopts immediately with
      consume_skb() (tcp_ipv6.c:1528).
    - tcp_check_req() calls ->syn_recv_sock() at tcp_minisocks.c:934.
    - Only afterward does it reach inet_csk_complete_hashdance()
      (tcp_minisocks.c:952), then inet_csk_reqsk_queue_drop(), then
      timer_delete_sync() (inet_connection_sock.c:1016).
    - The MPTCP rsk_drop_req() path has the same ordering.

    So the timer path (reqsk_timer_handler() -> tcp_rtx_synack() ->
    tcp_v6_send_synack()) running on another CPU races with that
    consume_skb() just like the dup-SYN path. The patch fixes this too,
    since pktopts is no longer read, but the sentence should
    ideally be corrected. Suggested wording:

      "The SYNACK timer has the same issue: tcp_v6_syn_recv_sock()
       frees pktopts before inet_csk_complete_hashdance() reaches
       timer_delete_sync()."

(b) Missing side effect: after this commit, TFO SYN-ACKs will now
    correctly carry the reflected flow label.
    - With TFO, the child is created and pktopts consumed
      (tcp_try_fastopen() -> tcp_fastopen_create_child() ->
      tcp_v6_syn_recv_sock()) *before* tcp_conn_request() sends the TFO
      SYN-ACK.
    - So today, TFO SYN-ACKs, including retransmits from
      tcp_fastopen_synack_timer(), never reflect the label.
    The new behavior is the correct one. But it changes what
    goes on the wire, so it would be good to add
    a sentence next to the TIME_WAIT note.

Thanks!
neal
