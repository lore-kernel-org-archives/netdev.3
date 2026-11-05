Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881345;
	b=tASc17/UChmDO3LMRT0S0FRFSP9Qp0cKTa7om6KFaT1S1NJGAHX6+BImwitz34WtR3Tn
	 cD7zexHrxVUwhELZ2hDLSPGkcEI1/Uhxy0u+BzJQPErd8xnSZJxfBLtrDh3J/MqXrsvmA
	 I05p+7Q0f73PCwsbbgek5CpJzFE9ETd0SJMaFRZ8ef47pGSHEpJgqZcXipoOJvoxBky2T
	 sYgdWecZWDJpBaontcnkvs8F+FRzjOCMHUrJyyFRHyrk1S5yMR2r4H+/VmP0MtfLCL87U
	 ZRCWf3j4c8No8jP/FxEMYeyJ3DcHhWczEWqMGypA0ueBpEhLXArZEanQLIE0QsE4IQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881345;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yLhO2b9NPmhZ4KLmzmsWyTeeW08C0qwOWfqTw7Ia0xs=;
	b=Ey/He8uH+ohRs7suSAjnqaShW1HTs5JM1fQEbg4XsbFdENqVdrCCxBcVMJt21ar5m7V1
	 WZbg1mCElCc05UD/LSyKabo4utUpagB2zUXZKWPpBGBDQ1ZtvbTZnk36qPw/zbOqwCu3g
	 +USdd/HWJ1+UgN4gU+Fl+Lex33ODpomGvttc+uzQQRgrCKPwybLp1aLuATwmJ2TMnGv68
	 jITPsjJIKUJk1rAW0aI+3pqWzy5AmXxNkDECPOvXdRxBgzj4gIe/stzga+b1L1+CEl2lI
	 Bgn7JDWXYw55AzoyKPPiDkGIY1tEX5ToCtKoc9R8nTHN2oyiteTglFvGiBxRlBag6QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oElCJt5Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C776606A332
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oElCJt5Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B201F0093A
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881345;
	bh=yLhO2b9NPmhZ4KLmzmsWyTeeW08C0qwOWfqTw7Ia0xs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=oElCJt5Qpi5F0XbVyp5tG+UGIxl4E0K/Ms1JtRBERyJf4wmMRr37j13IXSEA3X/lf
	 o3Eab33dZPtI8zflhvV8x9K7HNtFfvPzbm3w5FZjQOQEYgteuGpvjRbKQX+qQxba/c
	 7ZNnJt9EoEpfjOMBJrKJ+vqD9e/ehmYqg0lYVMkCDYygg/aKbKkIZTR7bMXBXAq2dp
	 5uey+3T9jUz5ygRLAs9J+8tvbyL9MIf8Jsb9873ZnngQiN34/NLNoCZBNYOZL7Eidx
	 PJQEHzMaGlaB9BVF83Su0MVXovCWPrYHc/fuZhdk2ub2Daq6guJ92JTDGUBLi9bxOP
	 S/31038KXn66Q==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-705cb6ceebaso1191845eaf.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 04:22:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwYwcoyQPLi2lBgCMXe9iXuV4lNy6X5V8BvjDpNwpxBtEY84QH1nqedBwZ2XAflW3O71ihxqPY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+mPk54XCha/DDguKkLGS9pmuxjXYUPR6XBJsdawVMbKgcQvowm
	HRTb5Q/xZrguyDkC62BvTqnK4z/pEP39Ig39PA1EfK22LFQ1I6zpmnbATwLZ///9LHihoRzzYhx
	lmB+CY89eixCmZ2FKD4fv/xswoSgOvgo=
X-Received: by 2002:a05:6820:a283:20b0:70b:8148:94f with SMTP id
 006d021491bc7-716bde2405fmr2610039eaf.76.1793881344396; Thu, 05 Nov 2026
 04:22:24 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <auxx1bK0QJfUvcB7@v4bel>
In-Reply-To: <auxx1bK0QJfUvcB7@v4bel>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 5 Nov 2026 13:22:12 +0100
X-Gmail-Original-Message-ID: <CAL4Wiir3EBEfr6JWxRnp5UM1+MSqsFQcu-8PMtMBxsrvoEkk8w@mail.gmail.com>
X-Gm-Features: AclHuK8Afmgo3vQ3nRDJezgd_eM1mV4Q0Q4jkLPLXxVFMB7LPPqrW80gLpVe-3Q
Message-ID: <CAL4Wiir3EBEfr6JWxRnp5UM1+MSqsFQcu-8PMtMBxsrvoEkk8w@mail.gmail.com>
Subject: Re: [PATCH net] tcp: do not coalesce segments after FIN
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, john.fastabend@gmail.com, sd@queasysnail.net, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 5 nov. 2026 =C3=A0 13:09, Hyunwoo Kim <imv4bel@gmail.com> a =C3=A9c=
rit :
>
> A FIN consumes a sequence number. If another FIN segment is coalesced
> into an skb that already carries FIN, end_seq advances to account for
> the additional FIN, but tcp_flags still contains only one FIN bit.
>

Yeah, we have been working lately on this issue (initial report from
Chris Mason)

For some reason Kuniyuki has not sent his patch yet.

> When the preceding gap is filled and tcp_ofo_queue() processes the
> coalesced skb, rcv_nxt advances to the skb's end_seq. When the receive
> path consumes all data in the skb, copied_seq advances by the data
> length and one sequence number for FIN. If three or more FIN segments
> have been coalesced into one skb, tcp_inq() can still return a positive
> value after the receive queue becomes empty and the SOCK_DONE adjustment
> is applied.
>
> Software kTLS receive is one consumer affected by this state. When
> strp->copy_mode is false, tls_strp_msg_consume() calls the TCP helper
> tcp_read_done() to consume the current TLS record. In the reproducer,
> tcp_read_done() consumed the record data and one FIN before freeing the
> receive skb.
>

TCP_ZEROCOPY_RECEIVE is another one: tcp_zerocopy_receive() takes its
length from tcp_inq() and follows skb->next without checking for the
end of the receive queue. Please mention it in the changelog.


> When kTLS looked for the next record, tcp_inq() reported at least
> TLS_HEADER_SIZE bytes even though the receive queue was empty.
> tcp_recv_skb() returned NULL, so tls_strp_load_anchor_with_queue() hit
> WARN_ON_ONCE() and returned without updating the anchor.
>
> Since tcp_inq() had reported at least TLS_HEADER_SIZE,
> tls_strp_read_sock() proceeded to tls_strp_check_queue_ok().
> skb_shinfo(strp->anchor)->frag_list still pointed to the freed receive
> skb. tls_strp_check_queue_ok() then read TCP_SKB_CB(first)->seq through
> the stale pointer, causing a use-after-free.
>
> The reproducer followed this call path:
>
>   tls_rx_rec_done()
>     tls_strp_msg_consume()
>       tcp_read_done()                       // frees the receive skb
>     tls_strp_check_rcv()
>       tls_strp_read_sock()
>         tls_strp_load_anchor_with_queue()   // returns after WARN_ON_ONCE=
()
>           tcp_recv_skb() =3D=3D NULL
>         tls_strp_check_queue_ok()
>           TCP_SKB_CB(first)->seq            // reads the freed receive sk=
b
>
> KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in tls_strp_check_queue_ok.isra.0+0x5f/=
0x100
>   Read of size 4 at addr ffff888103169ca8 by task ktls-server/71
>   ...
>   Call Trace:
>    <TASK>
>    ...
>    tls_strp_check_queue_ok.isra.0+0x5f/0x100
>    tls_strp_check_rcv+0x2a9/0x400
>    ...
>    tls_sw_recvmsg+0x3ce/0xa10
>    ...
>    sock_recvmsg+0xea/0x100
>    __sys_recvfrom+0x142/0x1f0
>    ...
>    __x64_sys_recvfrom+0x76/0x90
>    do_syscall_64+0xdd/0x4a0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    ...
>    </TASK>
>   ...
>   Freed by task 71:
>    ...
>    napi_skb_cache_put+0x24/0xf0
>    skb_attempt_defer_free+0x183/0x3b0
>    tcp_read_done+0x2d4/0x340
>    tls_strp_msg_consume+0x45/0x80
>    tls_sw_recvmsg+0x3c4/0xa10
>    ...
>
> In tcp_ooo_try_coalesce() and tcp_add_backlog(), skip coalescing when
> the destination skb already carries FIN. This still allows a FIN
> segment to be coalesced into an skb without FIN when the other
> coalescing checks pass.
>
> Fixes: e93a0435f809 ("tcp: allow segment with FIN in tcp_try_coalesce()")
> Fixes: 4f693b55c3d2 ("tcp: implement coalescing on backlog queue")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 3 ++-
>  net/ipv4/tcp_ipv4.c  | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index e1f2d9765f810..1f9f86028da73 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5314,7 +5314,8 @@ static bool tcp_ooo_try_coalesce(struct sock *sk,
>                              struct sk_buff *from,
>                              bool *fragstolen)
>  {
> -       bool res =3D tcp_try_coalesce(sk, to, from, fragstolen);
> +       bool res =3D !(TCP_SKB_CB(to)->tcp_flags & TCPHDR_FIN) &&
> +                  tcp_try_coalesce(sk, to, from, fragstolen);

Please put the check in tcp_try_coalesce() itself.

The receive queue callers can not hit this today (tcp_fin() purges
the ofo queue, and tcp_rcv_state_process() drops anything at or after
rcv_nxt in CLOSE_WAIT/CLOSING/LAST_ACK), but the check costs nothing
there, and it keeps the rule "nothing coalesces after a FIN" in one
place.

Also, since TCP_SKB_CB(to)->tcp_flags & TCPHDR_FIN should almost never
be true, it should come after the more relevant tests, just before
skb_try_coalesce():

        if (TCP_SKB_CB(from)->seq !=3D TCP_SKB_CB(to)->end_seq)
                return false;

        if (!tcp_skb_can_collapse_rx(to, from))
                return false;

        /* Nothing follows a FIN. */
        if (unlikely(TCP_SKB_CB(to)->tcp_flags & TCPHDR_FIN))
                return false;

        if (!skb_try_coalesce(to, from, fragstolen, &delta))
                return false;


>
>         /* In case tcp_drop_reason() is called later, update to->gso_segs=
 */
>         if (res) {
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a7f9242f1e429..ef01768292fbc 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1949,6 +1949,7 @@ enum skb_drop_reason tcp_add_backlog(struct sock *s=
k, struct sk_buff *skb)
>         thtail =3D (struct tcphdr *)tail->data;
>
>         if (TCP_SKB_CB(tail)->end_seq !=3D TCP_SKB_CB(skb)->seq ||
> +           (TCP_SKB_CB(tail)->tcp_flags & TCPHDR_FIN) ||


Same remark: please move this after the other tcp_flags tests, with a
short comment:

            /* Nothing follows a FIN, see tcp_try_coalesce() */
            (TCP_SKB_CB(tail)->tcp_flags & TCPHDR_FIN) ||

Checking only the tail is the right thing to do. It keeps the common
case where the last data+FIN segment is merged onto a data tail,
which happens on every connection close while the socket is owned by
the user.

Separately, tls_strp_load_anchor_with_queue() hits WARN_ON_ONCE() and
returns without telling its caller, which then uses a stale frag_list.
kTLS should probably not trust tcp_inq() that much, but this can be
handled in a follow-up patch.

Thanks.

>             TCP_SKB_CB(tail)->ip_dsfield !=3D TCP_SKB_CB(skb)->ip_dsfield=
 ||
>             ((TCP_SKB_CB(tail)->tcp_flags |
>               TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_SYN | TCPHDR_RST | TC=
PHDR_URG)) ||
> --
> 2.43.0
