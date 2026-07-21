Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E23371899
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784603230; cv=pass; b=EuZIcWy9YMZ7hGMsqQqAds8jRIOWxoBcy18Qmsavp1AjlJkVsUQFPisY5rk/kRsHb0vYb9uk9vI2QU4YpuPzl5XKlVCSyyJ04O6j4eN83NNzd/SL2zHZTvaie5J6h/CX/rMvLlBdgi2DyUthvhNLzCV/0vcvKp5ne8r9rT4VDHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784603230; c=relaxed/simple;
	bh=0c0MLH16+EU4rqoBTDllIkQ/iY3Vx54JLbfsWcHlobU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fyu7LQlkH8yvgkVIibkKjF8z7cj8wVGNLGiS/PlXOidjdB2lNMKAdRlB7X4xjAk3TC8r/TuFOTDzlKP0d9csVzjJev+VgWxjM1N7IazuZLG5NENkLsJe/y8t4+/YLpXa7ON0aeM7c9nuVDDmA3qyNPyhRcA1s4vGJU4ITA8B0b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqoLtK+g; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqoLtK+g"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c197f968b3cso213730566b.2
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 20:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784603225; cv=none;
        d=google.com; s=arc-20260327;
        b=EpbmIpSiMCj9UcD+FgSW+gFDkavNFiyc9n6bX6IlS7lVx8t35t7z9XNLdFZ9QyWclE
         JRgpDIpjmlEn8sfVVe86Gsec2DUTQJqm52TxDzBWEHUukfssfnm4rGXwptcyvUlcWpQP
         BsEZS+nn4MPTpPp20bNqxPs4LwbsKFiawDwhKMe8cc7tAMLZjSJy4W5y6J3YoQfEabiA
         ThyKEJxA70StaI7amHf4xsdVTcLRt+BSTHEyjtj8o99PQ8jHnymc9zVT3qhoEIayNC+1
         HE0HUO7B5PWouMRpDyDibZyqLEw4bCzBncVS/6EpY5PB+SbmxKlJjnx7OEkU9j+RsTyT
         jN4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R6KhGb2ez0SefO20ZaXIeqGCAHPXmcwanm0mrrwEC2A=;
        fh=e3uZFzGIMf6eJMUPSbVxxDwydeqRd8IjVUoIik5TFBo=;
        b=WKP+rtx6pValUoTtsNA4zbsXuc3il1gjM0dyBwvGbJhUQTlSbjqg4G4qEFb7GIG6dq
         HmgMkeeIVsfXPzj8Lq9upagiS1FvM6AXLumRWhc/PDrjZ74IDCxEEosRWO6FhZZnYFmH
         UoxSYrgnPz3JB6kIHJYbBsNxicYL1+KopbbVWgIxgjOXS6eMmkClHvrE7b4lALdvMqO2
         l7hJvVyQmRl9om0RnCrpeZAhj5sA7phkA5m3mG/PqOn1hbNkROvs2mmcMknG38Dxv+u4
         eZtmmplCojOCqmZ2eXYST+vGUu9RiooY4QsUK02nvwEkO40cAwKR8v633898Y8fCQBXn
         EpCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784603225; x=1785208025; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R6KhGb2ez0SefO20ZaXIeqGCAHPXmcwanm0mrrwEC2A=;
        b=aqoLtK+gM/bkwX4djq3AuIPcOS0jHB9Ir+wDX2OEvybXKsEvUiwXCxYGAUoQab2Rrs
         5lZSMYU5z2l22fWvfe4h7tFRULc5QTQ/WnmBr2UpiEVpI+CW+x/fRER4Ct803NcWFKJw
         rc6EkLQRMZNBTLejiRMEJ1OtauUdRXY3cTfJa/RIOYespxA5ZTv4w2ZSESOBhMxtRYZe
         Bwt2LL1mk9ir51hsi1BaHo412x6TCSVfzOokGvKRhx/1qkRqmm8yZUTnamkz+8bXMGwn
         uDqyMe6LwEGIkZiagDO8kvsv4CmhedMlZA2R4Pb+IU01nOmTYm0M6kyIPp9Eg9qJNASG
         J09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784603225; x=1785208025;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R6KhGb2ez0SefO20ZaXIeqGCAHPXmcwanm0mrrwEC2A=;
        b=oOEAXRODnCyR5zgSGzIiMDX3mt+NTaiJSbGfWB79A0jC3w8RD5n/c/e4rk80hFwsUd
         pdVKZCmaCve9otaYZNUo/4xa8oKtQEqf1lw/6RwalPbeWLW+v79NOlFuTf0qS2dId0df
         DFjzbq70LWykCsqBOye4KL+HGsYtyECaPw+gSgP2WF39VYSmHjEEMsigVfuji0LDMQkf
         WaA8VXRIv+GeqydFz+JkJR//CdDQFuoPAaPqA42+NgVljLC5DszSoX+VVNXx6iEnI6dC
         6g1j15hSYz+dXJ2u18FIoK1yeDx3WOr1yUOb4Qc43aqrxHYqHJq1v3L3BII7aZzWr0z4
         zLnw==
X-Forwarded-Encrypted: i=1; AHgh+RrJlttKqutF559EixtdlDFmgzyUQeFls8r3mCzb8nJ674RV5BBzVho5g7iH67nC6iwkVBbWcXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIo9wGilulgmn4WB3KoWawHdN2MakBN29qCM/OpBkfmPror7HL
	BBhTu+QiB3jM0BK9zgOMVI1Gx6knRrxSt01MJtxRbcybhEjS/7HXB50eaiBxjysihudpkdU3D4V
	ss5F9SK9rHQMXsfhE+BrpMM1LjcPkoyI=
X-Gm-Gg: AfdE7cm8Btn5On8Qfzmkc0vcsO+p9x9pxOL0q6ySE5yeOVj+X5JOoPW2mB7X4LCnP22
	DpF1twCXGvcVBzUToQEDpt8/5WQar3wHQKZo8ToDH7/6iBCNQpkByrTND0dRWjvpJgV5R2bN2+l
	Uyfb9brEuYZ8/u7l8EoJmkHVhyey4QypKmaTvh0AwEdwlcWO7P1kZiqRcNOuXRvsSzBftx9kybX
	6aVIMHrJgENwVivVjvJkNPccwSVuUxwLI8BtQ3tAisMy4kUykf0kpJgZPCSk2u1i+aTdyGiZRUm
	MqysbYjtWU3ZIIXQCeDf7yTGHvD8
X-Received: by 2002:a17:907:3e93:b0:c15:e118:9b99 with SMTP id
 a640c23a62f3a-c16b46a7a30mr660742366b.23.1784603224733; Mon, 20 Jul 2026
 20:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718092544.785289-1-bestswngs@gmail.com> <20260718092544.785289-2-bestswngs@gmail.com>
 <GV1P189MB1988EC5A7F5CB5DD69F331AEC6C32@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988EC5A7F5CB5DD69F331AEC6C32@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Weiming Shi <bestswngs@gmail.com>
Date: Tue, 21 Jul 2026 11:06:27 +0800
X-Gm-Features: AUfX_mxlBnvF60Q3NAlvCWwOWumttTPgo5WPdvADVUKajwQL-vL2GmOZERNT3nQ
Message-ID: <CANgPUi2hfRO8OebwBFm2f8240DYmqdPYNQtWyQL0VOP8beeSFQ@mail.gmail.com>
Subject: Re: [PATCH net v8 1/3] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Xiang Mei <xmei5@asu.edu>, kernel test robot <lkp@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=8820=E6=97=A5=E5=91=A8=E4=B8=80 23:41=E5=86=99=E9=81=93=EF=BC=9A
>
> >Subject: [PATCH net v8 1/3] tipc: fix NULL deref in tipc_named_node_up()=
 on
> >empty publication list
> >
> >[The defer-to-workqueue approach is by Tung Nguyen. He posted it  on the
> >thread and asked us to test it, as the replacement for the  item-less bu=
lk
> >approach. Since the RFC only exists as an inline  diff in the thread, it=
 is folded
> >into this series so the fix is  self-contained.]
> >
> >named_distribute() stamps the last_bulk flag on the tail skb of the publ=
ication
> >list. When the list is empty no skb is enqueued and the tail access dere=
ferences
> >NULL. tipc_named_node_up() hits this on an empty cluster_scope, which
> >happens with a node-id configuration where cluster_scope is populated on=
ly
> >later by tipc_net_finalize(). It is reachable by an unprivileged user ov=
er a UDP
> >bearer in a user+net namespace. The reported crash:
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
> >When cluster_scope is empty at node-up, defer the bulk distribution to a
> >workqueue and wait for tipc_net_finalize() to publish the node-state nam=
e, so
> >named_distribute() always runs on a non-empty list. On allocation failur=
e,
> >purge the partially built queue and bring the link down so the bulk dist=
ribution
> >restarts when the link comes up again.
> >
> >Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
> >Reported-by: Xiang Mei <xmei5@asu.edu>
> >Reported-by: kernel test robot <lkp@intel.com>
> >Closes: https://lore.kernel.org/oe-kbuild-all/202607180730.TwVgASDI-
> >lkp@intel.com/
> >Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> >Tested-by: Weiming Shi <bestswngs@gmail.com>
> >Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> >---
> sashiko reports many critical/high issues: https://sashiko.dev/#/patchset=
/20260718092544.785289-1-bestswngs%40gmail.com
>
> I address all in below patch=E4=B8=8B=E9=9D=A2=E7=9A=84=E8=A1=A5=E4=B8=81=
. Could you please test it ?
>
> ---
>  net/tipc/core.c       |  2 ++
>  net/tipc/core.h       |  4 +++
>  net/tipc/name_distr.c | 67 +++++++++++++++++++++++++++++++++++++------
>  net/tipc/name_distr.h |  3 +-
>  net/tipc/net.c        | 15 +++++++++-
>  net/tipc/node.c       | 61 +++++++++++++++++++++++++++++++++++++--
>  6 files changed, 139 insertions(+), 13 deletions(-)
>
> diff --git a/net/tipc/core.c b/net/tipc/core.c
> index 315975c3be81..52544b805dcc 100644
> --- a/net/tipc/core.c
> +++ b/net/tipc/core.c
> @@ -61,6 +61,8 @@ static int __net_init tipc_init_net(struct net *net)
>         tn->trial_addr =3D 0;
>         tn->addr_trial_end =3D 0;
>         tn->capabilities =3D TIPC_NODE_CAPABILITIES;
> +       atomic_set(&tn->finalized, 0);
> +       atomic_set(&tn-&tn->work_rescheduled, 0);
>         INIT_WORK(&tn-&tn->work, tipc_net_finalize_work);
>         memset(tn->node_id, 0, sizeof(tn->node_id));
>         memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
> diff --git a/net/tipc/core.h b/net/tipc/core.h
> index 9ce5f9ff6cc0..52fdb9189cc3 100644
> --- a/net/tipc/core.h
> +++ b/net/tipc/core.h
> @@ -145,6 +145,10 @@ struct tipc_net {
>         struct work_struct work;
>         /* The numbers of work queues in schedule */
>         atomic_t wq_count;
> +       /* flag to indicate work has finished */
> +       atomic_t finalized;
> +       /* flag to reschedule work */
> +       atomic_t work_rescheduled;
>  };
>
>  static inline struct tipc_net *tipc_net(struct net *net)
> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index ba4f4906e13b..3e32445cfbd0 100644
> --- a/net/tipc/name_distr.c
> +++ b/net/tipc/name_distr.c
> @@ -147,8 +147,8 @@ struct sk_buff *tipc_named_withdraw(struct net *net, =
struct publication *p)
>   * @pls: linked list of publication items to be packed into buffer chain
>   * @seqno: sequence number for this message
>   */
> -static void named_distribute(struct net *net, struct sk_buff_head *list,
> -                            u32 dnode, struct list_head *pls, u16 seqno)
> +static int named_distribute(struct net *net, struct sk_buff_head *list,
> +                           u32 dnode, struct list_head *pls, u16 seqno)
>  {
>         struct publication *publ;
>         struct sk_buff *skb =3D NULL;
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
> @@ -195,15 +196,16 @@ static void named_distribute(struct net *net, struc=
t sk_buff_head *list,
>         hdr =3D buf_msg(skb_peek_tail(list));
>         msg_set_last_bulk(hdr);
>         msg_set_named_seqno(hdr, seqno);
> +
> +       return 0;
>  }
>
>  /**
> - * tipc_named_node_up - tell specified node about all publications by th=
is node
> + * tipc_named_distribute - distribute all publications to specified node
>   * @net: the associated network namespace
>   * @dnode: destination node
> - * @capabilities: peer node's capabilities
>   */
> -void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
> +static int tipc_named_distribute(struct net *net, u32 dnode)
>  {
>         struct name_table *nt =3D tipc_name_table(net);
>         struct tipc_net *tn =3D tipc_net(net);
> @@ -212,15 +214,62 @@ void tipc_named_node_up(struct net *net, u32 dnode,=
 u16 capabilities)
>
>         __skb_queue_head_init(&head);
>         spin_lock_bh(&tn-&tn->nametbl_lock);
> -       if (!(capabilities & TIPC_NAMED_BCAST))
> -               nt->rc_dests++;
>         seqno =3D nt->snd_nxt;
>         spin_unlock_bh(&tn-&tn->nametbl_lock);
>
>         read_lock_bh(&nt->cluster_scope_lock);
> -       named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
> +       /* 1. tipc_net_finalize_work() is not scheduled because of namesp=
ace
> +        *    teardown.
> +        * 2. Or tipc_net_finalize() ---> tipc_nametbl_publish() has fail=
ed
> +        *    to insert node self address publication to nt->cluster_scop=
e.
> +        * 3. Or tipc_net_finalize() ---> tipc_nametbl_publish() has not
> +        *    executed yet.
> +        */
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
>         tipc_node_xmit(net, &head, dnode, 0);
>         read_unlock_bh(&nt->cluster_scope_lock);
> +
> +       return 0;
> +}
> +
> +/**
> + * tipc_named_node_up - tell specified node about all publications by th=
is node
> + * @net: the associated network namespace
> + * @dnode: destination node
> + * @capabilities: peer node's capabilities
> + */
> +int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
> +{
> +       struct name_table *nt =3D tipc_name_table(net);
> +       struct tipc_net *tn =3D tipc_net(net);
> +
> +       spin_lock_bh(&tn-&tn->nametbl_lock);
> +       if (!(capabilities & TIPC_NAMED_BCAST))
> +               nt->rc_dests++;
> +       spin_unlock_bh(&tn-&tn->nametbl_lock);
> +
> +       return tipc_named_distribute(net, dnode);
> +}
> +
> +/**
> + * tipc_named_dist_cluster_scope - distribute all publications to specif=
ied node
> + * @net: the associated network namespace
> + * @dnode: destination node
> + */
> +int tipc_named_dist_cluster_scope(struct net *net, u32 dnode)
> +{
> +       struct tipc_net *tn =3D tipc_net(net);
> +
> +       wait_var_event(&tn->finalized, atomic_read(&tn->finalized));
> +       return tipc_named_distribute(net, dnode);
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
> index 7e65d0b0c4a8..78418515277e 100644
> --- a/net/tipc/net.c
> +++ b/net/tipc/net.c
> @@ -132,13 +132,26 @@ static void tipc_net_finalize(struct net *net, u32 =
addr)
>         tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
>                    TIPC_NODE_STATE, addr, addr);
>
> +       if (atomic_read(&tn-&tn->work_rescheduled))
> +               goto publish;
> +
>         if (cmpxchg(&tn-&tn->node_addr, 0, addr))
>                 return;
>         tipc_set_node_addr(net, addr);
>         tipc_named_reinit(net);
>         tipc_sk_reinit(net);
>         tipc_mon_reinit_self(net);
> -       tipc_nametbl_publish(net, &ua, &sk, addr);
> +
> +publish:
> +       if (!tipc_nametbl_publish(net, &ua, &sk, addr)) {
> +               tn->trial_addr =3D addr;
> +               atomic_set(&tn-&tn->work_rescheduled, 1);
> +               schedule_work(&tn-&tn->work);
> +               return;
> +       }
> +       atomic_set(&tn-&tn->work_rescheduled, 0);
> +       atomic_set(&tn->finalized, 1);
> +       wake_up_var(&tn->finalized);
>  }
>
>  void tipc_net_finalize_work(struct work_struct *work)
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 8e4ef2630ae4..afed72894722 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -111,6 +111,8 @@ struct tipc_bclink_entry {
>   * @peer_net: peer's net namespace
>   * @peer_hash_mix: hash for this peer (FIXME)
>   * @crypto_rx: RX crypto handler
> + * @work: work item for bulk distribution of cluster scope publications
> + * @work_scheduled: flag to indicate the work has been scheduled
>   */
>  struct tipc_node {
>         u32 addr;
> @@ -145,6 +147,8 @@ struct tipc_node {
>  #ifdef CONFIG_TIPC_CRYPTO
>         struct tipc_crypto *crypto_rx;
>  #endif
> +       struct work_struct work;
> +       atomic_t work_scheduled;
>  };
>
>  /* Node FSM states and events:
> @@ -393,6 +397,27 @@ static void tipc_node_write_unlock_fast(struct tipc_=
node *n)
>         write_unlock_bh(&n->lock);
>  }
>
> +static void tipc_node_down(struct tipc_node *n)
> +{
> +       u32 bearer_id, bearer_cnt;
> +
> +       tipc_node_read_lock(n);
> +       bearer_cnt =3D n->link_cnt;
> +       tipc_node_read_unlock(n);
> +       for (bearer_id =3D 0; bearer_id < bearer_cnt; bearer_id++)
> +               tipc_node_link_down(n, bearer_id, false);
> +}
> +
> +static void tipc_node_dist_bulk(struct work_struct *work)
> +{
> +       struct tipc_node *node =3D container_of(work, struct tipc_node, w=
ork);
> +
> +       if (tipc_named_dist_cluster_scope(node->net, node->addr) < 0)
> +               tipc_node_down(node);
> +
> +       tipc_node_put(node);
> +}
> +
>  static void tipc_node_write_unlock(struct tipc_node *n)
>         __releases(n->lock)
>  {
> @@ -424,8 +449,23 @@ static void tipc_node_write_unlock(struct tipc_node =
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
> +                       atomic_set(&n->work_scheduled, 1);
> +                       tipc_node_get(n);
> +                       if (!schedule_work(&n->work))
> +                               tipc_node_put(n);
> +               } else if (rc < 0) {
> +                       /* Bring the node down to start over bulk distrib=
ution
> +                        * when the first link is up again.
> +                        */
> +                       tipc_node_down(n);
> +               }
> +       }
>
>         if (flags & TIPC_NOTIFY_LINK_UP) {
>                 tipc_mon_peer_up(net, node, bearer_id);
> @@ -564,6 +604,8 @@ struct tipc_node *tipc_node_create(struct net *net, u=
32 addr, u8 *peer_id,
>         INIT_LIST_HEAD(&n->list);
>         INIT_LIST_HEAD(&n->publ_list);
>         INIT_LIST_HEAD(&n->conn_sks);
> +       INIT_WORK(&n->work, tipc_node_dist_bulk);
> +       atomic_set(&n->work_scheduled, 0);
>         skb_queue_head_init(&n->bc_entry.namedq);
>         skb_queue_head_init(&n->bc_entry.inputq1);
>         __skb_queue_head_init(&n->bc_entry.arrvq);
> @@ -635,10 +677,25 @@ static void tipc_node_delete_from_list(struct tipc_=
node *node)
>
>  static void tipc_node_delete(struct tipc_node *node)
>  {
> +       struct tipc_net *tn =3D tipc_net(node->net);
> +
>         trace_tipc_node_delete(node, true, " ");
>         tipc_node_delete_from_list(node);
>
>         timer_delete_sync(&node->timer);
> +
> +       /* Wake up node work queue if tipc_net_finalize_work() is not
> +        * scheduled yet.
> +        */
> +       if (atomic_read(&node->work_scheduled)) {
> +               if (!atomic_read(&tn->finalized)) {
> +                       atomic_set(&tn->finalized, 1);
> +                       wake_up_var(&tn->finalized);
> +               }
> +
> +               cancel_work_sync(&node->work);
> +       }
> +
>         tipc_node_put(node);
>  }
>
> --
> 2.43.0




Hi Tung,

I tested this on v7.1-rc5 with the two-node setup (UDP bearers,
node-id addressing), as an unprivileged user and as root.
The original NULL deref is fixed, and the sashiko findings look addressed.

But I found one path the patch misses: tipc_node_cleanup(). It removes
a stale node with tipc_node_delete_from_list() directly, without the
wake/cancel
you added in tipc_node_delete(). If a deferred worker is still parked
when the stale timer fires, the node is removed from the list while
the worker is
sleeping in wait_var_event(). Since the node is off the list, the wake
in tipc_node_delete() can no longer reach it. The worker stays in D
state and
keeps its node reference, so the node struct leaks as well.

This state is reachable from userspace without any kernel change:
filling local_publ_count to TIPC_MAX_PUBL with node-scope binds makes
tipc_net_finalize()'s publish fail, and the work_rescheduled retry
then keeps finalized at 0, so the link-up defers the worker for as
long as the table
stays full. (The retry also=E4=B9=9F=E9=87=8D=E8=AF=95 busy-loops, printing=
 "tipc: Bind
failed, max limit 65535 reached" each round.) Bringing the link down
makes the peer node go
stale NODE_CLEANUP_AFTER (300s) later, with the worker still parked.
The hung task watchdog flags it:

```
     [  370.440401] INFO: task kworker/0:0:9 blocked for more than 245 seco=
nds.
     [  370.441580] Workqueue: events tipc_node_dist_bulk
     [  370.442803] Call Trace:
     [  370.443151]  __schedule+0x18bf/0x4680
     [  370.444293]  tipc_named_dist_cluster_scope+0x1a0/0x220
     [  370.446076]  tipc_node_dist_bulk+0x6d/0x1b0
     [  370.446218]  process_one_work+0x845/0x1a60
```

With a test-only marker printk in tipc_node_cleanup() I can see the
stale timer remove both nodes at ~368s and ~375s, i.e. while the
workers above are
still parked. Nothing wakes them on that path; in this run they only
exit because killing the reproducer closes the bind sockets, so the
next retry's
publish succeeds. With a persistent failure source (e.g. memory
pressure) the worker would stay parked across the netns teardown as
well.


```
[  247.560544] INFO: task kworker/0:0:9 blocked for more than 122 seconds.
     [  247.568089] INFO: task kworker/0:2:67 blocked for more than 122 sec=
onds.

     [  370.440401] INFO: task kworker/0:0:9 blocked for more than 245 seco=
nds.
     [  370.441580] Workqueue: events tipc_node_dist_bulk
     [  370.442803] Call Trace:
     [  370.443151]  __schedule+0x18bf/0x4680
     [  370.444293]  tipc_named_dist_cluster_scope+0x1a0/0x220     =E2=86=
=90
wait_var_event =E7=9D=A1=E7=9C=A0=E7=82=B9
     [  370.446076]  tipc_node_dist_bulk+0x6d/0x1b0
     [  370.446218]  process_one_work+0x845/0x1a60

```


The Configs and reproducer =EF=BC=9A
```
CONFIG_TIPC=3Dy,
CONFIG_TIPC_MEDIA_UDP=3Dy, CONFIG_USER_NS=3Dy, CONFIG_NET_NS=3Dy,
CONFIG_KASAN=3Dy (crash on the unpatched kernel),
CONFIG_DETECT_HUNG_TASK=3Dy
```

```c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <sched.h>
#include <fcntl.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/genetlink.h>
#include <linux/if_link.h>
#include <linux/veth.h>
#include <linux/tipc.h>

#ifndef AF_TIPC
#define AF_TIPC 30
#endif
#ifndef SOCK_RDM
#define SOCK_RDM 4
#endif

#ifndef VETH_INFO_PEER
#define VETH_INFO_PEER 1
#endif

#define TIPC_GENL_V2_NAME "TIPCv2"

enum {
        TIPC_NL_UNSPEC,
        TIPC_NL_LEGACY,
        TIPC_NL_BEARER_DISABLE,
        TIPC_NL_BEARER_ENABLE,
        TIPC_NL_BEARER_GET,
        TIPC_NL_BEARER_SET,
        TIPC_NL_SOCK_GET,
        TIPC_NL_PUBL_GET,
        TIPC_NL_LINK_GET,
        TIPC_NL_LINK_SET,
        TIPC_NL_LINK_RESET_STATS,
        TIPC_NL_MEDIA_GET,
        TIPC_NL_MEDIA_SET,
        TIPC_NL_NODE_GET,
        TIPC_NL_NET_GET,
        TIPC_NL_NET_SET,
};

enum {
        TIPC_NLA_UNSPEC,
        TIPC_NLA_BEARER,
        TIPC_NLA_SOCK,
        TIPC_NLA_PUBL,
        TIPC_NLA_LINK,
        TIPC_NLA_MEDIA,
        TIPC_NLA_NODE,
        TIPC_NLA_NET,
};

enum {
        TIPC_NLA_BEARER_UNSPEC,
        TIPC_NLA_BEARER_NAME,
        TIPC_NLA_BEARER_PROP,
        TIPC_NLA_BEARER_DOMAIN,
        TIPC_NLA_BEARER_UDP_OPTS,
};

enum {
        TIPC_NLA_UDP_UNSPEC,
        TIPC_NLA_UDP_LOCAL,
        TIPC_NLA_UDP_REMOTE,
        TIPC_NLA_UDP_MULTI_REMOTEIP,
};

enum {
        TIPC_NLA_NET_UNSPEC,
        TIPC_NLA_NET_ID,
        TIPC_NLA_NET_ADDR,
        TIPC_NLA_NET_NODEID,
        TIPC_NLA_NET_NODEID_W1,
};

#define TIPC_UDP_PORT 6118
#define NLA_ALIGNTO 4
#define MY_NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))

static int tipc_family;

static int nl_open(int protocol)
{
        int fd =3D socket(AF_NETLINK, SOCK_RAW, protocol);
        if (fd < 0) { perror("socket(NETLINK)"); exit(1); }
        struct sockaddr_nl sa =3D { .nl_family =3D AF_NETLINK };
        if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
                perror("bind(NETLINK)"); exit(1);
        }
        return fd;
}

static void *nla_put(char *buf, int *off, int type, const void *data, int l=
en)
{
        struct nlattr *a =3D (struct nlattr *)(buf + *off);
        a->nla_type =3D type;
        a->nla_len =3D NLA_HDRLEN + len;
        if (len)
                memcpy((char *)a + NLA_HDRLEN, data, len);
        *off +=3D MY_NLA_ALIGN(a->nla_len);
        return a;
}

static struct nlattr *nla_nest_start(char *buf, int *off, int type)
{
        struct nlattr *a =3D (struct nlattr *)(buf + *off);
        a->nla_type =3D type | NLA_F_NESTED;
        *off +=3D NLA_HDRLEN;
        return a;
}

static void nla_nest_end(char *buf, int *off, struct nlattr *start)
{
        start->nla_len =3D (buf + *off) - (char *)start;
}

static int genl_resolve_family(int fd, const char *name)
{
        char buf[1024];
        memset(buf, 0, sizeof(buf));
        struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
        struct genlmsghdrgenlmsghdr *gh =3D (struct genlmsghdrgenlmsghdr
*)NLMSG_DATA(nlh);
        int off =3D NLMSG_HDRLEN + GENL_HDRLEN;

        nlh->nlmsg_type =3D GENL_ID_CTRL;
        nlh->nlmsg_flags =3D NLM_F_REQUEST;
        nlh->nlmsg_seq =3D 1;
        gh->cmd =3D CTRL_CMD_GETFAMILY;
        gh->version =3D 1;
        nla_put(buf, &off, CTRL_ATTR_FAMILY_NAME, name, strlen(name) + 1);
        nlh->nlmsg_len =3D off;

        if (send(fd, buf, nlh->nlmsg_len, 0) < 0) { perror("send genl
resolve"); exit(1); }

        char rbuf[4096];
        int n =3D recv(fd, rbuf, sizeof(rbuf), 0);
        if (n < 0) { perror("recv genl resolve"); exit(1); }

        struct nlmsghdr *rh =3D (struct nlmsghdr *)rbuf;
        if (rh->nlmsg_type =3D=3D NLMSG_ERROR)
                return -1;
        struct nlattr *a =3D (struct nlattr *)((char *)NLMSG_DATA(rh) +
GENL_HDRLEN);
        int alen=E9=98=BF=E4=BC=A6 =3D rh->nlmsg_len - NLMSG_HDRLEN - GENL_=
HDRLEN;
        while (alen > 0) {
                if (a->nla_type =3D=3D CTRL_ATTR_FAMILY_ID)
                        return *(uint16_t *)((char *)a + NLA_HDRLEN);
                int step =3D MY_NLA_ALIGN(a->nla_len);
                alen -=3D step;
                a =3D (struct nlattr *)((char *)a + step);
        }
        return -1;
}

static int nl_recv_ack(int fd, const char *what)
{
        char rbuf[8192];
        int n =3D recv(fd, rbuf, sizeof(rbuf), 0);
        if (n < 0) { fprintf(stderr, "recv ack (%s): %s\n", what,
strerror(errno)); return -1; }
        struct nlmsghdr *rh =3D (struct nlmsghdr *)rbuf;
        if (rh->nlmsg_type =3D=3D NLMSG_ERROR) {
                struct nlmsgerr *e =3D NLMSG_DATA(rh);
                if (e->error !=3D 0)
                        fprintf(stderr, "[%s] netlink error: %d
(%s)\n", what, e->error, strerror(-e->error));
                return e->error;
        }
        return 0;
}

static void *rta_put(char *buf, int *off, int type, const void *data, int l=
en)
{
        struct rtattr *a =3D (struct rtattr *)(buf + *off);
        a->rta_type =3D type;
        a->rta_len =3D RTA_LENGTH(len);
        if (len) memcpy(RTA_DATA(a), data, len);
        *off +=3D RTA_ALIGN(a->rta_len);
        return a;
}

static struct rtattr *rta_nest(char *buf, int *off, int type)
{
        struct rtattr *a =3D (struct rtattr *)(buf + *off);
        a->rta_type =3D type | NLA_F_NESTED;
        *off +=3D RTA_LENGTH(0);
        return a;
}

static void rta_nest_end(char *buf, int *off, struct rtattr *start)
{
        start->rta_len =3D (buf + *off) - (char *)start;
}

static void create_veth(int fd, const char *n0, const char *n1, int peer_ns=
fd)
{
        char buf[2048];
        memset(buf, 0, sizeof(buf));
        struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
        struct ifinfomsg *ifi =3D NLMSG_DATA(nlh);
        int off =3D NLMSG_HDRLEN + sizeof(*ifi);

        nlh->nlmsg_type =3D RTM_NEWLINK;
        nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE |
NLM_F_EXCL;
        nlh->nlmsg_seq =3D 10;
        ifi->ifi_family =3D AF_UNSPEC;

        rta_put(buf, &off, IFLA_IFNAME, n0, strlen(n0) + 1);
        struct rtattr *linfo =3D rta_nest(buf, &off, IFLA_LINKINFO);
        rta_put(buf, &off, IFLA_INFO_KIND, "veth", 5);
        struct rtattr *idata =3D rta_nest(buf, &off, IFLA_INFO_DATA);
        struct rtattr *peer =3D rta_nest(buf, &off, VETH_INFO_PEER);
        struct ifinfomsg *pifi =3D (struct ifinfomsg *)(buf + off);
        memset(pifi, 0, sizeof(*pifi));
        off +=3D sizeof(*pifi);
        rta_put(buf, &off, IFLA_IFNAME, n1, strlen(n1) + 1);
        rta_put(buf, &off, IFLA_NET_NS_FD, &peer_nsfd, sizeof(peer_nsfd));
        rta_nest_end(buf, &off, peer);
        rta_nest_end(buf, &off, idata);
        rta_nest_end(buf, &off, linfo);
        nlh->nlmsg_len =3D off;

        if (send(fd, buf, nlh->nlmsg_len, 0) < 0) { perror("send
veth"); exit(1); }
        int e =3D nl_recv_ack(fd, "create_veth");
        if (e && e !=3D -EEXIST) { fprintf(stderr, "veth create failed:
%d\n", e); exit(1); }
}

static void set_if_up(int fd, const char *name)
{
        char buf[512];
        memset(buf, 0, sizeof(buf));
        struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
        struct ifinfomsg *ifi =3D NLMSG_DATA(nlh);
        int off =3D NLMSG_HDRLEN + sizeof(*ifi);
        nlh->nlmsg_type =3D RTM_NEWLINK;
        nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
        nlh->nlmsg_seq =3D 20;
        ifi->ifi_family =3D AF_UNSPEC;
        ifi->ifi_index =3D if_nametoindex(name);
        ifi->ifi_flags =3D IFF_UP;
        ifi->ifi_change =3D IFF_UP;
        nlh->nlmsg_len =3D off;
        if (send(fd, buf, nlh->nlmsg_len, 0) < 0) { perror("send up");
exit(1); }
        nl_recv_ack(fd, "set_if_up");
}

static void add_ipv4(int fd, const char *name, const char *ip, int prefix)
{
        char buf[512];
        memset(buf, 0, sizeof(buf));
        struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
        struct ifaddrmsg *ifa =3D NLMSG_DATA(nlh);
        int off =3D NLMSG_HDRLEN + sizeof(*ifa);
        nlh->nlmsg_type =3D RTM_NEWADDR;
        nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE |
NLM_F_REPLACE;
        nlh->nlmsg_seq =3D 30;
        ifa->ifa_family =3D AF_INET;
        ifa->ifa_prefixlen =3D prefix;
        ifa->ifa_scope =3D 0;
        ifa->ifa_index =3D if_nametoindex(name);

        struct in_addr a;
        inet_pton(AF_INET, ip, &a);
        rta_put(buf, &off, IFA_LOCAL, &a, 4);
        rta_put(buf, &off, IFA_ADDRESS, &a, 4);
        nlh->nlmsg_len =3D off;
        if (send(fd, buf, nlh->nlmsg_len, 0) < 0) { perror("send
addr"); exit(1); }
        nl_recv_ack(fd, "add_ipv4");
}

static void tipc_set_node_id(int fd, uint64_t w0, uint64_t w1)
{
        char buf[1024];
        memset(buf, 0, sizeof(buf));
        struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
        struct genlmsghdrgenlmsghdr *gh =3D (struct genlmsghdrgenlmsghdr
*)NLMSG_DATA(nlh);
        int off =3D NLMSG_HDRLEN + GENL_HDRLEN;
        nlh->nlmsg_type =3D tipc_family;
        nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
        nlh->nlmsg_seq =3D 40;
        gh->cmd =3D TIPC_NL_NET_SET;
        gh->version =3D 1;

        struct nlattr *net =3D nla_nest_start(buf, &off, TIPC_NLA_NET);
        nla_put(buf, &off, TIPC_NLA_NET_NODEID, &w0, sizeof(w0));
        nla_put(buf, &off, TIPC_NLA_NET_NODEID_W1, &w1, sizeof(w1));
        nla_nest_end(buf, &off, net);
        nlh->nlmsg_len =3D off;

        if (send(fd, buf, nlh->nlmsg_len, 0) < 0) { perror("send
net_set"); exit(1); }
        int e =3D nl_recv_ack(fd, "tipc_set_node_id");
        if (e) fprintf(stderr, "net_set(nodeid) returned %d\n", e);
}

static void put_sockaddr_storage_v4(char *buf, int *off, int type,
const char *ip, int port)
{
        struct sockaddr_storage ss;
        memset(&ss, 0, sizeof(ss));
        struct sockaddr_in *sin =3D (struct sockaddr_in *)&ss;
        sin->sin_family =3D AF_INET;
        sin->sin_port =3D htons(port);
        inet_pton(AF_INET, ip, &sin->sin_addr);
        nla_put(buf, off, type, &ss, sizeof(ss));
}

static void tipc_udp_bearer(int fd, int cmd, const char *bname,
                            const char *local_ip, const char *remote_ip)
{
        char buf[2048];
        memset(buf, 0, sizeof(buf));
        struct nlmsghdr *nlh =3D (struct nlmsghdr *)buf;
        struct genlmsghdrgenlmsghdr *gh =3D (struct genlmsghdrgenlmsghdr
*)NLMSG_DATA(nlh);
        int off =3D NLMSG_HDRLEN + GENL_HDRLEN;
        nlh->nlmsg_type =3D tipc_family;
        nlh->nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK;
        nlh->nlmsg_seq =3D 50;
        gh->cmd =3D cmd;
        gh->version =3D 1;

        struct nlattr *bearer =3D nla_nest_start(buf, &off, TIPC_NLA_BEARER=
);
        nla_put(buf, &off, TIPC_NLA_BEARER_NAME, bname=E5=90=8D=E7=A7=B0, s=
trlen(bname=E5=90=8D=E7=A7=B0) + 1);
        if (cmd =3D=3D TIPC_NL_BEARER_ENABLE) {
                struct nlattr *udp =3D nla_nest_start(buf, &off,
TIPC_NLA_BEARER_UDP_OPTS);
                put_sockaddr_storage_v4(buf, &off, TIPC_NLA_UDP_LOCAL,
local_ip, TIPC_UDP_PORT);
                put_sockaddr_storage_v4(buf, &off,
TIPC_NLA_UDP_REMOTE, remote_ip, TIPC_UDP_PORT);
                nla_nest_end(buf, &off, udp);
        }
        nla_nest_end(buf, &off, bearer);
        nlh->nlmsg_len =3D off;

        if (send(fd, buf, nlh->nlmsg_len, 0) < 0) { perror("send
bearer"); exit(1); }
        int e =3D nl_recv_ack(fd, "tipc_udp_bearer");
        if (e) fprintf(stderr, "bearer cmd %d (%s) returned %d\n",
cmd, bname=E5=90=8D=E7=A7=B0, e);
}

static int write_file(const char *path, const char *val)
{
        int fd =3D open(path, O_WRONLY);
        if (fd < 0) return -1;
        int r =3D write(fd, val, strlen(val));
        close(fd);
        return r;
}

static int bindfill_node_scope(int target)
{
        int fd =3D socket(AF_TIPC, SOCK_RDM, 0);
        if (fd < 0) { perror("socket(AF_TIPC)"); exit(1); }
        int ok =3D 0, fail =3D 0;
        for (int i =3D 0; i < target + 1000; i++) {
                struct sockaddr_tipc sa;
                memset(&sa, 0, sizeof(sa));
                sa.family =3D AF_TIPC;
                sa.addrtype =3D TIPC_SERVICE_ADDR;
                sa.scope =3D TIPC_NODE_SCOPE;
                sa.addr.nameseq.type =3D 100000 + i;
                sa.addr.nameseq.lower =3D 100000 + i;
                sa.addr.nameseq.upper =3D 100000 + i;
                if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) =3D=3D 0) =
{
                        ok++;
                        fail =3D 0;
                } else if (++fail > 100) {
                        break;
                }
        }
        fprintf(stderr, "[*] bound %d node-scope publications (cap
reached)\n", ok);
        if (ok < 65000) { fprintf(stderr, "bindfill shortfall\n"); exit(1);=
 }
        return fd;
}

static void child_main(int sync_rd, int sync_wr)
{
        char c;
        write(sync_wr, "R", 1);
        if (read(sync_rd, &c, 1) !=3D 1) _exit(1);

        int rfd =3D nl_open(NETLINK_ROUTE);
        set_if_up(rfd, "lo");
        set_if_up(rfd, "veth1");
        add_ipv4(rfd, "veth1", "10.0.0.2", 24);

        int gfd =3D nl_open(NETLINK_GENERIC);
        tipc_family =3D genl_resolve_family(gfd, TIPC_GENL_V2_NAME);
        if (tipc_family < 0) _exit(1);

        int bfd =3D bindfill_node_scope(65535);
        tipc_set_node_id(gfd, 0x2222222222222222ULL, 0x2222222222222222ULL)=
;
        tipc_udp_bearer(gfd, TIPC_NL_BEARER_ENABLE, "udp:b1",
"10.0.0.2", "10.0.0.1");
        write(sync_wr, "C", 1);

        sleep(35);
        tipc_udp_bearer(gfd, TIPC_NL_BEARER_DISABLE, "udp:b1", NULL, NULL);
        fprintf(stderr, "[child] b1 disabled, keeping it down\n");
        (void)bfd;
        for (;;) pause();
}

int main(void)
{
        setvbuf(stdout, NULL, _IONBF, 0);
        setvbuf(stderr, NULL, _IONBF, 0);

        uid_t uid =3D getuid();
        gid_t gid =3D getgid();

        if (unshare(CLONE_NEWUSER | CLONE_NEWNET) =3D=3D 0) {
                write_file("/proc/self/setgroups", "deny");
                char m[64];
                snprintf(m, sizeof(m), "0 %d 1", uid);
                write_file("/proc/self/uid_map", m);
                snprintf(m, sizeof(m), "0 %d 1", gid);
                write_file("/proc/self/gid_map", m);
        } else if (unshare(CLONE_NEWNET) < 0) {
                perror("unshare");
                return 1;
        }

        int p2c[2], c2p[2];
        if (pipe(p2c) < 0 || pipe(c2p) < 0) { perror("pipe"); return 1; }

        pid_t pid =3D fork();
        if (pid =3D=3D 0) {
                close(p2c[1]);
                close(c2p[0]);
                if (unshare(CLONE_NEWNET) < 0) _exit(1);
                child_main(p2c[0], c2p[1]);
                _exit(0);
        }
        close(p2c[0]);
        close(c2p[1]);

        char c;
        if (read(c2p[0], &c, 1) !=3D 1) { fprintf(stderr, "child not
ready\n"); return 1; }

        char nspath[64];
        snprintf(nspath, sizeof(nspath), "/proc/%d/ns/net", pid);
        int nsfd =3D open(nspath, O_RDONLY);
        if (nsfd < 0) { perror("open ns"); return 1; }

        int rfd =3D nl_open(NETLINK_ROUTE);
        create_veth(rfd, "veth0", "veth1", nsfd);
        close(nsfd);
        set_if_up(rfd, "lo");
        set_if_up(rfd, "veth0");
        add_ipv4(rfd, "veth0", "10.0.0.1", 24);
        write(p2c[1], "G", 1);

        int gfd =3D nl_open(NETLINK_GENERIC);
        tipc_family =3D genl_resolve_family(gfd, TIPC_GENL_V2_NAME);
        if (tipc_family < 0) return 1;
        int bfd =3D bindfill_node_scope(65535);
        tipc_set_node_id(gfd, 0x1111111111111111ULL, 0x1111111111111111ULL)=
;

        if (read(c2p[0], &c, 1) !=3D 1)
                fprintf(stderr, "child config sync missed\n");
        tipc_udp_bearer(gfd, TIPC_NL_BEARER_ENABLE, "udp:b0",
"10.0.0.1", "10.0.0.2");

        fprintf(stderr, "[*] nodes configured; waiting for stale cleanup\n"=
);
        (void)bfd;
        sleep(400);
        kill(pid, SIGKILL);
        waitpid(pid, NULL, 0);
        fprintf(stderr, "[*] done\n");
        return 0;
}

```


Do you think tipc_node_cleanup() should go through the same wake logic
as tipc_node_delete()? Happy to test the next version.

Thanks,
Weiming
