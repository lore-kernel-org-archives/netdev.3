Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1930E3264FD
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784313293; cv=pass; b=EaDXZeqryfeh0UckFdsYuGzgFhrT1i4j8WOZYXKPdOceflyfQ0QuDytk1AnLGJgisnPFZ9g4zn/V1I8sN/uKhT3ETldXZugU7Fo+syLPBDK1eJAEmB2/O5jOgGtioNgKh3RMWEBBO6V6dlmNOjF/BeGigdKe7fWRQ7fT/JW5TgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784313293; c=relaxed/simple;
	bh=4doU/krDDo/yjIzyBX+f1X51plYYlkh35R6jr8TjCZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hW6u0us+lDPUbk7h553o5JlrMR+um318AauZASMHgW6NpJTY8qCoA0EmK35nyMDNOGLM2oZTd2kj0P0o2ZyvQRUP+efWt5JuG4T+DuMSYXup6p7Dbds+uMZ6/9X/oDkcfhpnIte1MVNRBvUlmip6fJRA+kKwhSwVKl4Mjx0b2yA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTWfAUD5; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTWfAUD5"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so11855559a12.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:34:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784313289; cv=none;
        d=google.com; s=arc-20260327;
        b=fj8ertsYTgtIhERKaZs+17M0MWnEp1jf9xxdxTlHJKZPJqgXiIIlHRKH7bo3JOmX10
         mM814KK0wftsOhEg4DMua/8AjhChDFSHhGCCm/lMTF3Qtw2RA8tvoEk9mBy+P9zBotAo
         Qdh7NllEWVv13pCOUnNDzNr9va8SGqc1v62zMPmd6z99oZbeOdZRnO9tpXAW9vxAsh35
         0Bbt6hFJS8cqTwQrU2kAksZ8BggtXVOPO7uUUlOYE4QMy/O5I81MieZPKGK58eMPMo6M
         ntiFX1SLooo4b/bAC3pykLcgYryzGUgU4Suc6/y9dHAyFx/AEcAg6faPeCxEFnTBIcOS
         PHrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iy28mwVFBi9XbBqW29ltPaIZQlTg/KmuB3/L+w1pkvY=;
        fh=m7VR74eUURRG4a3kkxCpuPyIkXT0WZw+o1nhYgOzoVo=;
        b=qIbDyYMTh7ZIvLsFxgAt+R6pBlKq/5IYfUHC/3KVN5+pWDrSjt6QSowy7feu2ZYomv
         VEjhzcaw4eAnqzK8sLrclqcCWlJwRQHgnxDAi/yy537zIMrl07Dj+ueBNeD0MRxmRh4N
         5vEvf9HhE3PaUxtOgup95cAYMacNt4uNlXyGlqCHdbrZTOIKn5XRutoM1msRJ8aDKHJ/
         0mDNCPPpkTJYS6iXbOJGTlFrY9b6ADLBFxAPNgQxMGUvWMUwXs/AEbqOLGEo9G1Q04vV
         Tdnb5+lIoRWEjDnrp/eemtNNTi0mcpj2h+K3MSx/cD8AKBhHEfkWLGWeGZ+zlTGM04oZ
         Ywxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784313289; x=1784918089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iy28mwVFBi9XbBqW29ltPaIZQlTg/KmuB3/L+w1pkvY=;
        b=UTWfAUD5e6ratea6LGE6r5bot4DrnOwCUYEym0gWJF7tjOZK0M9gbxh9ebV9BIWTug
         /yMdPDlGNMjLJmmspfttKxPBOMkp74sfGgmZYQUQRgaAs2+sxEfLKJShw584OQn5/F3f
         KOnDMbOlAkB0xKGYu+2UwQxl2GlcArOTlo/ZYqT9/kDrJ2lbo06dnA5ocM+EInKc3eTl
         /fB+jwNTseabDq4pnVUtginGDK0F0JtJodAYWINXMRew0jNqhAxJkL0jCrLAMFyZoQGb
         ++F1Mu5AE2AVeXNmvdweiZpXN6wf18WUItCyKE2T+evErixtJM2IhLoSdtbBgrUa8qV/
         59rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784313289; x=1784918089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iy28mwVFBi9XbBqW29ltPaIZQlTg/KmuB3/L+w1pkvY=;
        b=oxJ0qs7AgglhVFXjSzZgc24427PK+bQv4DCIAWOWW1/9YAADM57/LcPVCF0g32/tpb
         swvntA34czTU81009dyLzAywAqtSUBtiABd3ibtksrXOJe0j+cpdEbOB2FL8ysYo8Z6+
         CcxvWeANR/HXCaISUGMD1L+ul+cjATZul9KxfvyLSCBYDe0Yq34b/FpLv2Vq8I6pCaIc
         81nUUNyijHM7nnQ7zJ1uwXCqOda6yqNR8JXeIUVn0sqdmoX6oBJ5ymufMaUHbLbz12fq
         zApS/sTSdY4h16Li2hipyTlvC+bHMFfc12DFe6JwQR1g5cp2Mdw4xud68L0sv+jBU7Yw
         i4jw==
X-Gm-Message-State: AOJu0YyHpLKeMpxr8wX89OjiZmLARszh981NqtZTkP+ZAbCzehc2+lae
	Sw0M7PSByJ18uwdB7js6M3vzFvhpS4SdUBQ79V4pkB5/JV4bg0OidRoa0JV0bY4UoPnotH0rIR8
	o044vw/AYLMjq+oQeY4JHhXc43kfHfRU=
X-Gm-Gg: AfdE7ckzdIYXjZIdRtItti5aj1E9Kc8T4rAFwH1eQIIsFdRu1PfK93YvPXCNZaGQi1q
	dgHDO30s4YAzD5B47bBcP1C0eVV9L2lxnninx3ONxPKLdQv31s2mGlnFQ59vgvdxtpO8eenK2ar
	nNgJ30vx+keSmmzXgThmOAm1dfYCa7U13mvria8APJezVtYZ5TkJS0HyZIt/MzqjnasNlL/D5t0
	oY/0wCxUglwkneJbTeOoQy9ppSDbcCYkvQGOhdz1e0SZtKgObLKhixB5ZuOqmCBOhzv72ctOSmk
	WyGl0CGrjbjWiTO7Ag==
X-Received: by 2002:a17:907:d50d:b0:bec:2ad0:cba5 with SMTP id
 a640c23a62f3a-c16b470d83fmr164467666b.29.1784313289083; Fri, 17 Jul 2026
 11:34:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716190204.100895-2-bestswngs@gmail.com> <20260716190204.100895-4-bestswngs@gmail.com>
 <GV1P189MB1988F91A48BC981B816C2700C6C62@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988F91A48BC981B816C2700C6C62@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sat, 18 Jul 2026 02:34:12 +0800
X-Gm-Features: AUfX_mzSMhJaWg5pIfK7QAOpfuxRvbiOd6168JeTIdzpEIGrNN4-MpOkUlMsM8M
Message-ID: <CANgPUi1QTDP5Xo9LanuBEgzDREcxbAc6KE4Ltccoz_O6DF0=3Q@mail.gmail.com>
Subject: Re: [PATCH net v4 2/2] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "xmei5@asu.edu" <xmei5@asu.edu>, 
	Jon Maloy <jmaloy@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=8817=E6=97=A5=E5=91=A8=E4=BA=94 17:48=E5=86=99=E9=81=93=EF=BC=9A
>
> >Subject: [PATCH net v4 2/2] tipc: fix NULL deref in tipc_named_node_up()=
 on
> >empty publication list
> >
> >named_distribute() ends by stamping the last_bulk flag on the tail skb v=
ia
> >buf_msg(skb_peek_tail(list)). When the publication list is empty no skb =
is
> >enqueued, skb_peek_tail() returns NULL, and buf_msg(NULL) is dereference=
d.
> >
> >tipc_named_node_up() runs this on &nt->cluster_scope. With a node-id
> >configuration cluster_scope is populated only later by tipc_net_finalize=
(), so a
> >peer link that comes up first reaches named_distribute() with an empty l=
ist. It
> >is reachable by an unprivileged user (TIPC genl ops use
> >GENL_UNS_ADMIN_PERM) over a UDP bearer in a user+net namespace:
> >
> > KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df]
> > RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
> >  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:22=
1)
> >  tipc_node_write_unlock (net/tipc/node.c:428)
> >  tipc_rcv (net/tipc/node.c:2185)
> >  tipc_udp_recv (net/tipc/udp_media.c:392)  Kernel panic - not syncing: =
Fatal
> >exception in interrupt
> >
> >The peer holds back this node's later name updates until it sees a bulk =
with the
> >last_bulk flag, so simply skipping the send would stall it. Emit an item=
-less bulk
> >when the publication list is empty, so the peer still receives the last_=
bulk flag
> >and opens.
> >
> >Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
> >Reported-by: Xiang Mei <xmei5@asu.edu>
> >Assisted-by: Claude:claude-opus-4-8
> >Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >---
> > net/tipc/name_distr.c | 14 ++++++++++++++
> > 1 file changed, 14 insertions(+)
> >
> >diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
> >ba4f4906e13b..a8bb7bd101ea 100644
> >--- a/net/tipc/name_distr.c
> >+++ b/net/tipc/name_distr.c
> >@@ -192,6 +192,20 @@ static void named_distribute(struct net *net, struc=
t
> >sk_buff_head *list,
> >               skb_trim(skb, INT_H_SIZE + (msg_dsz - msg_rem));
> >               __skb_queue_tail(list, skb);
> >       }
> >+
> >+      if (skb_queue_empty(list)) {
> >+              skb =3D named_prepare_buf(net, PUBLICATION, 0, dnode);
> >+              if (!skb) {
> >+                      pr_warn("Bulk publication failure\n");
> >+                      return;
> >+              }
> >+              hdr =3D buf_msg(skb);
> >+              msg_set_bc_ack_invalid(hdr, true);
> >+              msg_set_bulk(hdr);
> >+              msg_set_non_legacy(hdr);
> >+              __skb_queue_tail(list, skb);
> >+      }
> As I explained before, this approach is wrong because
> 1. It does not handle memory allocation failure.
> 2. It breaks receiving peer by  sending non-data message to that peer in =
case skb is not NULL.
>
> Could you please test below patch to see if it fixes the NULL dereference=
 issue you reported ?

Hi ,
Tested your patch, it fixes the NULL dereference I reported. No more
panic with an empty cluster_scope .

One new bug found during testing: if tipc_nametbl_publish() fails in
tipc_net_finalize(), the node is
still marked finalized, so the deferred worker wakes up and calls
named_distribute() with an empty list,
hitting the same NULL dereference.

I have the fix ready and sent it out:

https://lore.kernel.org/all/20260717183047.2725959-1-bestswngs@gmail.com/
https://lore.kernel.org/all/20260717183047.2725959-2-bestswngs@gmail.com/
https://lore.kernel.org/all/20260717183047.2725959-3-bestswngs@gmail.com/

Thanks,
Weiming Shi

>
> ---
>  net/tipc/core.c       |  1 +
>  net/tipc/core.h       |  2 ++
>  net/tipc/name_distr.c | 48 +++++++++++++++++++++++++++++++++++++++----
>  net/tipc/name_distr.h |  3 ++-
>  net/tipc/net.c        |  2 ++
>  net/tipc/node.c       | 34 ++++++++++++++++++++++++++++--
>  6 files changed, 83 insertions(+), 7 deletions(-)
>
> diff --git a/net/tipc/core.c b/net/tipc/core.c
> index 315975c3be81..9e81be4f01cf 100644
> --- a/net/tipc/core.c
> +++ b/net/tipc/core.c
> @@ -61,6 +61,7 @@ static int __net_init tipc_init_net(struct net *net)
>         tn->trial_addr =3D 0;
>         tn->addr_trial_end =3D 0;
>         tn->capabilities =3D TIPC_NODE_CAPABILITIES;
> +       atomic_set(&tn->finalized, 0);
>         INIT_WORK(&tn->work, tipc_net_finalize_work);
>         memset(tn->node_id, 0, sizeof(tn->node_id));
>         memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
> diff --git a/net/tipc/core.h b/net/tipc/core.h
> index 9ce5f9ff6cc0..76768844c808 100644
> --- a/net/tipc/core.h
> +++ b/net/tipc/core.h
> @@ -145,6 +145,8 @@ struct tipc_net {
>         struct work_struct work;
>         /* The numbers of work queues in schedule */
>         atomic_t wq_count;
> +       /* flag to indicate work has finished */
> +       atomic_t finalized;
>  };
>
>  static inline struct tipc_net *tipc_net(struct net *net)
> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index ba5f4906e13b..8a1692dbd243 100644
> --- a/net/tipc/name_distr.c
> +++ b/net/tipc/name_distr.c
> @@ -147,7 +147,7 @@ struct sk_buff *tipc_named_withdraw(struct net *net, =
struct publication *p)
>   * @pls: linked list of publication items to be packed into buffer chain
>   * @seqno: sequence number for this message
>   */
> -static void named_distribute(struct net *net, struct sk_buff_head *list,
> +static int named_distribute(struct net *net, struct sk_buff_head *list,
>                              u32 dnode, struct list_head *pls, u16 seqno)
>  {
>         struct publication *publ;
> @@ -164,8 +164,9 @@ static void named_distribute(struct net *net, struct =
sk_buff_head *list,
>                         skb =3D named_prepare_buf(net, PUBLICATION, msg_r=
em,
>                                                 dnode);
>                         if (!skb) {
> +                               __skb_queue_purge(list);
>                                 pr_warn("Bulk publication failure\n");
> -                               return;
> +                               return 1;
>                         }
>                         hdr =3D buf_msg(skb);
>                         msg_set_bc_ack_invalid(hdr, true);
> @@ -195,6 +196,8 @@ static void named_distribute(struct net *net, struct =
sk_buff_head *list,
>         hdr =3D buf_msg(skb_peek_tail(list));
>         msg_set_last_bulk(hdr);
>         msg_set_named_seqno(hdr, seqno);
> +
> +       return 0;
>  }
>
>  /**
> @@ -203,7 +206,7 @@ static void named_distribute(struct net *net, struct =
sk_buff_head *list,
>   * @dnode: destination node
>   * @capabilities: peer node's capabilities
>   */
> -void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
> +int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
>  {
>         struct name_table *nt =3D tipc_name_table(net);
>         struct tipc_net *tn =3D tipc_net(net);
> @@ -218,9 +221,46 @@ void tipc_named_node_up(struct net *net, u32 dnode, =
u16 capabilities)
>         spin_unlock_bh(&tn->nametbl_lock);
>
>         read_lock_bh(&nt->cluster_scope_lock);
> -       named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
> +       /* tipc_net_finalize_work() has not finished inserting self addre=
ss to
> +         * name table yet.
> +         */
> +       if (unlikely(list_empty(&nt->cluster_scope))) {
> +               read_unlock_bh(&nt->cluster_scope_lock);
> +               return 1;
> +       }
> +
> +       if (named_distribute(net, &head, dnode, &nt->cluster_scope, seqno=
)) {
> +               read_unlock_bh(&nt->cluster_scope_lock);
> +               return -ENOBUFS;
> +       }
> +
>         tipc_node_xmit(net, &head, dnode, 0);
>         read_unlock_bh(&nt->cluster_scope_lock);
> +       return 0;
> +}
> +
> +int tipc_named_dist_cluster_scope(struct net *net, u32 dnode)
> +{
> +       struct name_table *nt =3D tipc_name_table(net);
> +       struct tipc_net *tn =3D tipc_net(net);
> +       struct sk_buff_head head;
> +       u16 seqno;
> +
> +       __skb_queue_head_init(&head);
> +       wait_var_event(&tn->finalized, atomic_read(&tn->finalized));
> +       spin_lock_bh(&tn->nametbl_lock);
> +       seqno =3D nt->snd_nxt;
> +       spin_unlock_bh(&tn->nametbl_lock);
> +
> +       read_lock_bh(&nt->cluster_scope_lock);
> +       if (named_distribute(net, &head, dnode, &nt->cluster_scope, seqno=
)) {
> +               read_unlock_bh(&nt->cluster_scope_lock);
> +               return -ENOBUFS;
> +       }
> +       tipc_node_xmit(net, &head, dnode, 0);
> +       read_unlock_bh(&nt->cluster_scope_lock);
> +
> +       return 0;
>  }
>
>  /**
> diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
> index c677f6f082df..cadf4e8c3e66 100644
> --- a/net/tipc/name_distr.h
> +++ b/net/tipc/name_distr.h
> @@ -69,7 +69,8 @@ struct distr_item {
>
>  struct sk_buff *tipc_named_publish(struct net *net, struct publication *=
publ);
>  struct sk_buff *tipc_named_withdraw(struct net *net, struct publication =
*publ);
> -void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
> +int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
> +int tipc_named_dist_cluster_scope(struct net *net, u32 dnode);
>  void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
>                     u16 *rcv_nxt, bool *open);
>  void tipc_named_reinit(struct net *net);
> diff --git a/net/tipc/net.c b/net/tipc/net.c
> index 7e65d0b0c4a8..4c144e720ac1 100644
> --- a/net/tipc/net.c
> +++ b/net/tipc/net.c
> @@ -139,6 +139,8 @@ static void tipc_net_finalize(struct net *net, u32 ad=
dr)
>         tipc_sk_reinit(net);
>         tipc_mon_reinit_self(net);
>         tipc_nametbl_publish(net, &ua, &sk, addr);
> +       atomic_inc(&tn->finalized);
> +       wake_up_var(&tn->finalized);
>  }
>
>  void tipc_net_finalize_work(struct work_struct *work)
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 8e4ef2630ae4..c5b0a98324c3 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -145,6 +145,8 @@ struct tipc_node {
>  #ifdef CONFIG_TIPC_CRYPTO
>         struct tipc_crypto *crypto_rx;
>  #endif
> +       /* Work item for bulk distribution of cluster scope publications =
*/
> +       struct work_struct work;
>  };
>
>  /* Node FSM states and events:
> @@ -303,6 +305,7 @@ static void tipc_node_free(struct rcu_head *rp)
>  #ifdef CONFIG_TIPC_CRYPTO
>         tipc_crypto_stop(&n->crypto_rx);
>  #endif
> +       cancel_work_sync(&n->work);
>         kfree(n);
>  }
>
> @@ -393,6 +396,19 @@ static void tipc_node_write_unlock_fast(struct tipc_=
node *n)
>         write_unlock_bh(&n->lock);
>  }
>
> +static void tipc_node_dist_bulk(struct work_struct *work)
> +{
> +       struct tipc_node *node =3D container_of(work, struct tipc_node, w=
ork);
> +
> +       if (tipc_named_dist_cluster_scope(node->net, node->addr) < 0) {
> +               u32 bearer_id =3D node->link_id & 0xffff;
> +
> +               tipc_node_link_down(node, bearer_id, false);
> +       }
> +
> +       tipc_node_put(node);
> +}
> +
> static void tipc_node_write_unlock(struct tipc_node *n)
>         __releases(n->lock)
>  {
> @@ -424,8 +440,21 @@ static void tipc_node_write_unlock(struct tipc_node =
*n)
>         if (flags & TIPC_NOTIFY_NODE_DOWN)
>                 tipc_publ_notify(net, publ_list, node, n->capabilities);
>
> -       if (flags & TIPC_NOTIFY_NODE_UP)
> -               tipc_named_node_up(net, node, n->capabilities);
> +       if (flags & TIPC_NOTIFY_NODE_UP) {
> +               int rc =3D 0;
> +
> +               rc =3D tipc_named_node_up(net, node, n->capabilities);
> +               /* Defer bulk distribution to work queue */
> +               if (rc > 0) {
> +                       tipc_node_get(n);
> +                       schedule_work(&n->work);
> +               } else if (rc < 0) {
> +                       /* Bring the link down to start over bulk distrib=
ution
> +                        * when the link is up again.
> +                        */
> +                       tipc_node_link_down(n, bearer_id, false);
> +               }
> +       }
>
>         if (flags & TIPC_NOTIFY_LINK_UP) {
>                 tipc_mon_peer_up(net, node, bearer_id);
> @@ -564,6 +593,7 @@ struct tipc_node *tipc_node_create(struct net *net, u=
32 addr, u8 *peer_id,
>         INIT_LIST_HEAD(&n->list);
>         INIT_LIST_HEAD(&n->publ_list);
>         INIT_LIST_HEAD(&n->conn_sks);
> +       INIT_WORK(&n->work, tipc_node_dist_bulk);
>         skb_queue_head_init(&n->bc_entry.namedq);
>         skb_queue_head_init(&n->bc_entry.inputq1);
>         __skb_queue_head_init(&n->bc_entry.arrvq);
