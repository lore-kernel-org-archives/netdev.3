Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689659;
	b=NedDZrvFc8u+E5Basal1E/n1qfOCAkBcKvKiSoN+lomK70cs4VE/N1y0zLJBiOKGvrVo
	 +GOPPSP9QAPBRrUsQsLM3qEBm0JDbiT69gG5qLwGDnhcRzKVpDxqKIDlDCv8ATMbxW4Nq
	 P385QbGfSZSP3dLmFY9H5fm3WZKaxTCOUgh4gVfJ+wnO0FfmSIpECNT7SXMEGK7qeCXoU
	 RJpGTk90ockUacp4tdx3xbQvFUL3P/p3vP84SkneIKSDHGcvA5FlbIlERvyRB4KQAx2yO
	 NzQLxZi9AwC2jdUYG+lxnNQ7ojUDGMq5JkodGow82VMfz9P0Yj87pHzfWnS4fevAsIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689659;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=dMUwdNNlX47GZDregQd1aU44dhCXXAKv5Dr+YMUKeZM=;
	b=b1ss0Nwick0M2xtkOanV0ET1HPgGLphYwSnQkp4fIdcg7rA4D+Lzd25Z6dT2JQKlVqNP
	 9IhKCothzL/vky23n4la2ujlA1PlI2A/yQ15+bYImQhyLkc3rwCaJFMulFC36WISuJ24C
	 TJxO6YNV9nuJXtP6DhCep8yV9InMJ4SthKHafskCJwH8q0MS3/Q0zsFvYQ2/nbmcJXvoI
	 BhOdtwFi74j6ahHArkD6RqKxc2eel3iPHmWoFapl+0+Cmp1NZsW1xfVbimk5dL5b8PB9s
	 c2QmZridwH1pZ1oMO1aUIWITim9VtxTnFj5Ur9mIAgpNY4Ph0EEmjLZ9rj0fX7FECZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKt9hsN6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632E606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKt9hsN6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803431F031E0
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792689658;
	bh=dMUwdNNlX47GZDregQd1aU44dhCXXAKv5Dr+YMUKeZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EKt9hsN6+QlaQlXb3P5LlOvTa9SI9XXwkm8go83sjLImRym9h3iIEQfNKwWc0a5fB
	 TjWrRTzeX1z+yv2nUL5e/fxIHi29hrwP3I9i9sY2wMk6v0xAezPcmfBTWqpO1HSFJb
	 Sn7gcdL+NDApcRr41wm3s37DJqD5ZLsbFlCZM3f6rNtguY4zsVm1BztPTT6SPB+x5y
	 FClSksaawhVSQbFiTNl7WEGh6046jrcSbZfEnh4+qcKyuHGYcyh5SXq8EUN3b+BXnq
	 6ebjmPynUK8CQxnRKfymtJ5DXjBIrDhdSZLjzIZlNt7HnMFNgFiwznlB1k5odDWOrJ
	 7WxJG5XTjOefA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ab35e31f6dso10281471fa.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 10:20:58 -0700 (PDT)
X-Gm-Message-State: AFq9FYJQUm901DmmIK82yFLtZYLxwSEXMy+DqbZsWe2NUUr67LVpc0L0
	R6nxenTav3V1D9k63tMOxil+tPSYsag5JTfwM9sAZ0G9L9qGEFMlZVoQSjzSy/Ps7JejyokWfM6
	UD6CaAGkDMjP8eNGhONTNM0s6lROi26Y=
X-Received: by 2002:a05:651c:345c:b0:3a9:8775:5f11 with SMTP id
 38308e7fff4ca-3ac510bec21mr8824021fa.4.1792689657196; Thu, 22 Oct 2026
 10:20:57 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022011539.6882-1-tung.quang.nguyen@est.tech>
In-Reply-To: <20261022011539.6882-1-tung.quang.nguyen@est.tech>
From: Eric Dumazet <edumazet@kernel.org>
Date: Thu, 22 Oct 2026 19:20:43 +0200
X-Gmail-Original-Message-ID: <CAL4WiiogRi0-zhfw1vHxQMsf30TTb-vFZymQQgCwiCpTs_Ca+g@mail.gmail.com>
X-Gm-Features: AclHuK-56Zydd_GeAy-1gWfJYTA5OtsO83acQye9DAJXnz3sd6lhVU7KKN_WBGY
Message-ID: <CAL4WiiogRi0-zhfw1vHxQMsf30TTb-vFZymQQgCwiCpTs_Ca+g@mail.gmail.com>
Subject: Re: [PATCH net v3] tipc: fix refcount panic in tipc_rcv() when
 receiving shared skb
To: Tung Nguyen <tung.quang.nguyen@est.tech>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, jmaloy@redhat.com, horms@kernel.org, 
	tipc-discussion@lists.sourceforge.net, 
	syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com, 
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 22 oct. 2026 =C3=A0 03:15, Tung Nguyen <tung.quang.nguyen@est.tech>=
 a =C3=A9crit :
>
> TIPC assumes that the received skb is not shared with other users.
> However, syzbot reports a bug triggered by receiving a shared skb:
>
> ...
> RIP: 0010:pskb_expand_head+0x135a/0x13a0 net/core/skbuff.c:2308
> __pskb_pull_tail+0x111/0x1870 net/core/skbuff.c:2890
> skb_cow_data+0x2ed/0xc50 net/core/skbuff.c:5398
> tipc_aead_decrypt net/tipc/crypto.c:892 [inline]
> tipc_crypto_rcv+0x346/0x23d0 net/tipc/crypto.c:1843
> tipc_rcv+0x4b7/0x1040 net/tipc/node.c:2119
> tipc_l2_rcv_msg+0x2d9/0x470 net/tipc/bearer.c:669
> deliver_ptype_list_skb net/core/dev.c:2533 [inline]
> ...
>
> The root cause is that local delivery hooks in the kernel (e.g.,
> deliver_skb()) may increment the skb's reference count (`users`) before
> TIPC processes it on ingress.
>
> Fix this by calling skb_share_check() to ensure exclusive ownership
> before passing the skb to tipc_rcv(). As TIPC needs to modify the skb's
> data, the cloned skb needs to be uncloned in tipc_sk_conn_proto_rcv(),
> tipc_sk_filter_connect(), tipc_msg_lookup_dest() and tipc_link_tnl_rcv().
>
> Reported-by: syzbot+0017742620a9d06f06ef@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0017742620a9d06f06ef
> Closes: https://lore.kernel.org/all/20261018145928.58317-1-ngocthang2710.=
1999@gmail.com/T/
> Fixes: 6e967adf798a ("tipc: relocate common functions from media to beare=
r")

This commit only moved recv_msg() from eth_media.c to bearer.c,
the bug was there from day 0.

Fixes: b97bf3fd8f6a ("[TIPC] Initial merge")

> Co-developed-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> ---
> v3: Use skb_share_check() to unshare the skb and unclone that skb
>     when needed.
> v2: https://lore.kernel.org/all/20261020104852.90350-1-tung.quang.nguyen@=
est.tech/
> v1: https://lore.kernel.org/all/20261019050648.287309-1-tung.quang.nguyen=
@est.tech/
>
>  net/tipc/bearer.c |  4 ++++
>  net/tipc/link.c   |  7 +++++++
>  net/tipc/msg.c    |  3 +++
>  net/tipc/socket.c | 10 ++++++++++
>  4 files changed, 24 insertions(+)
>
> diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
> index 05dcd2f9e887..5e7e220fa7f5 100644
> --- a/net/tipc/bearer.c
> +++ b/net/tipc/bearer.c
> @@ -659,6 +659,10 @@ static int tipc_l2_rcv_msg(struct sk_buff *skb, stru=
ct net_device *dev,
>  {
>         struct tipc_bearer *b;
>
> +       skb =3D skb_share_check(skb, GFP_ATOMIC);
> +       if (!skb)
> +               return NET_RX_DROP;
> +

This part is fine, and is what other L3 handlers do.

The skb_unclone() parts are addressing a different (and older) issue:
TIPC already receives cloned skbs today, as soon as a packet tap
(tcpdump) is active, since af_packet clones the shared skb.

Please split this into two patches: the skb_share_check() one
(small, easy to backport), and a second one dealing with cloned skbs.

Some comments on the second part:


>         rcu_read_lock();
>         b =3D rcu_dereference(dev->tipc_ptr) ?:
>                 rcu_dereference(orig_dev->tipc_ptr);
> diff --git a/net/tipc/link.c b/net/tipc/link.c
> index 6427c69f8929..d7ce384d3b89 100644
> --- a/net/tipc/link.c
> +++ b/net/tipc/link.c
> @@ -1363,6 +1363,13 @@ static int tipc_link_tnl_rcv(struct tipc_link *l, =
struct sk_buff *skb,
>                 }
>                 kfree_skb(skb);
>         } else {
> +               if (skb_unclone(skb, GFP_ATOMIC) =3D=3D -ENOMEM) {
> +                       kfree_skb(skb);
> +                       return tipc_link_fsm_evt(l, LINK_FAILURE_EVT);
> +               }
> +
> +               hdr =3D buf_msg(skb);
> +
>                 /* Set fragment type for buf_append */
>                 if (msg_fragm_no(hdr) =3D=3D 1)
>                         msg_set_type(hdr, FIRST_FRAGMENT);
> diff --git a/net/tipc/msg.c b/net/tipc/msg.c
> index b0bba0feef56..9a222e15ed31 100644
> --- a/net/tipc/msg.c
> +++ b/net/tipc/msg.c
> @@ -736,6 +736,9 @@ bool tipc_msg_lookup_dest(struct net *net, struct sk_=
buff *skb, int *err)
>         sk.node =3D tipc_scope2node(net, scope);
>         if (!tipc_nametbl_lookup_anycast(net, &ua, &sk))
>                 return false;
> +       if (skb_unclone(skb, GFP_ATOMIC) =3D=3D -ENOMEM)
> +               return false;
> +       msg =3D buf_msg(skb);
>         msg_incr_reroute_cnt(msg);
>         if (sk.node !=3D self)
>                 msg_set_prevnode(msg, self);
> diff --git a/net/tipc/socket.c b/net/tipc/socket.c
> index d5d70eb230b5..9789d1ce6bd4 100644
> --- a/net/tipc/socket.c
> +++ b/net/tipc/socket.c
> @@ -1345,6 +1345,10 @@ static void tipc_sk_conn_proto_rcv(struct tipc_soc=
k *tsk, struct sk_buff *skb,
>                                       tsk_peer_port(tsk));
>                 sk->sk_state_change(sk);
>
> +               if (skb_unclone(skb, GFP_ATOMIC) =3D=3D -ENOMEM)
> +                       goto exit;
> +               hdr =3D buf_msg(skb);
> +
>                 /* State change is ignored if socket already awake,
>                  * - convert msg to abort msg and add to inqueue
>                  */
> @@ -1359,6 +1363,9 @@ static void tipc_sk_conn_proto_rcv(struct tipc_sock=
 *tsk, struct sk_buff *skb,
>         tsk->probe_unacked =3D false;
>
>         if (mtyp =3D=3D CONN_PROBE) {
> +               if (skb_unclone(skb, GFP_ATOMIC) =3D=3D -ENOMEM)
> +                       goto exit;

tipc_msg_reverse() always allocates a new skb, so there is no need
to unclone here. Simply set the type on the new skb:

if (tipc_msg_reverse(onode, &skb, TIPC_OK)) {
    msg_set_type(buf_msg(skb), CONN_PROBE_REPLY);
    __skb_queue_tail(xmitq, skb);
}


> +               hdr =3D buf_msg(skb);
>                 msg_set_type(hdr, CONN_PROBE_REPLY);
>                 if (tipc_msg_reverse(onode, &skb, TIPC_OK))
>                         __skb_queue_tail(xmitq, skb);
> @@ -2223,6 +2230,9 @@ static bool tipc_sk_filter_connect(struct tipc_sock=
 *tsk, struct sk_buff *skb,
>                                 return true;
>                         /* Empty ACK-, - wake up sleeping connect() and d=
rop */
>                         sk->sk_state_change(sk);
> +                       if (skb_unclone(skb, GFP_ATOMIC) =3D=3D -ENOMEM)
> +                               break;

The break leads to the "Abort connection setup attempt" path, after
tipc_sk_finish_conn() was already called. A memory allocation failure
should not abort a connection that was just established.

msg_set_dest_droppable() is only used here to ask the caller to
silently drop the packet. Now that the skb is not shared, a bit in
TIPC_SKB_CB() (or a different return value) would avoid both the
header write and this new error path.


> +                       hdr =3D buf_msg(skb);
>                         msg_set_dest_droppable(hdr, 1);
>                         return false;
>                 }
> --
> 2.53.0
>

skb_unclone() returns 0 or -ENOMEM, the usual form is:

if (skb_unclone(skb, GFP_ATOMIC))

Because it is very possible that in the future skb_unclone() start
returning other error codes instead of crashing with BUG_ON()

pw-bot: cr
