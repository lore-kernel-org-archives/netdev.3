Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8F11D95A3
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785298760; cv=pass; b=LO1AfSsFySx75Ia6HQSMwkMYztlkcVZKXzCD1o81TeLDaIKIV0p89Nl8GbHoMoX4LCXzB7IlYXL4MQ6k0kgXHG8f0wJ+lWZ4qWtGJOWqc7kIBLpcfzIs3pVzaC3M9crhP2guqimopkS9ceQ71RzpIs+1UzStyRV7tKQVnOQhj4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785298760; c=relaxed/simple;
	bh=XnRJfDfdgLM8WJvghmYEXNJnZLY6h7VgZOrpAh5JgEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktX03EzIb91pHGLz74XCXxfhdx2cRy9H3B7x1/itmt8Br71sqs5s4bG+PpGFzy/AgWY36l/hhVL+BTwt59hLy/yZb/8bKVFKRc8Yea8iHCgMhZoVlZg6eJ0rOVltwf6Z2UGpdy29SRpn1MTIKq5yov53ilm3JavFSH4HUYNsEGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvK2lVLm; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvK2lVLm"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c167bda216fso72476166b.2
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785298755; cv=none;
        d=google.com; s=arc-20260327;
        b=RlcAKmz3lCHs7gKSPJ28fbnMyuFtJufBmPblhmR0gKc8Hpenvvtvqw9W5TyOWUrAK3
         Pf3S+xNjE9e+fnPLxA0amhVYkqGHJGZAWVL3XRsztFCUHnQ8U6loWMwRw8bzjfJN9rB/
         MQpCxmhyZoZgZk0ajGr6YTrTnYzijStNAMwUhy3ccDiy9gP2bUNVVRAzwlfSxMvKY7yZ
         nUC2X2Rv0B5ujvLAcsiF7/fSWa6ZEQhBSWHVH+vNVROrgcf+AF/aAdGF7IT/D6jFmV1H
         7KiToEzCJp6T8U/QtkavWGwPd5uJpKUMxrKznxilp0JeD/efEFhbsB0aRoU1Y6zRQQ4z
         MsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hkLA6W0PUdV91Pw6d1+RRyVHtsCnspPWU+MRWCHNwvY=;
        fh=cPfl0VfrQLAuyjbM+SMlf8nd/BZI8Bld/q/9ZESkpRo=;
        b=b89JC1woSQ9oaa0xCmEe0VaG4ATXERtNvjsHyVW4m8Y8qoB51xGv5sa5o4VqHLjvl8
         hsGEULgd4psIgFYBXPWoafgR7Rmb+pXwtUdWjSFpKbq4V5n4gH9njy4UWjpFAsNmWTBM
         2TfG54FSmkOlfdXxgVjLpXxqx/0Dp+dFQLp4/JRRYMbmbgbDDlW+GvusaqZp8m+2QVmE
         bo0abHr9nyXOEftEAvJs5pXuZvvkBkEdqfjQ84UVKePbbOwfVGwEqicbiEkwjYjMLF7T
         djKTttNjoz3gSd4h1BWeTfL7cFIXOMmxRA7xJLlS2LoLni8djHWLnlPzgd/1Nf3m6iGO
         /zlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785298755; x=1785903555; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hkLA6W0PUdV91Pw6d1+RRyVHtsCnspPWU+MRWCHNwvY=;
        b=WvK2lVLm04YAh3tU6fVPcc/nM93Er5kz4t8fqQfp+vK3F3xPdaB4UucF2NBHyE7Rs1
         DyR5nED3ndNd58k9VWZAefld+ZaxN0FvLN5Sdlfae2DHU/7CC7pZQW8lJMczLARtEtdV
         nZQpLW5zljMQuqx6M0k5BynpcTw82/7faiJY+IkQzXhGofXOI5ZIpCXIrnUTm9eAVYm2
         K9QHG5suQqavNMBidOs/BHeh20n+zUvWnFI5oV09U3Mq67lCx6IU3L/PARkdYOUjs9et
         vG6Syhpy/Lsij+a4aCkbjLtLHi9dJ5gRzUVKpkjrFRi2OsKp1r8lXbXG8t9syDhtjXPH
         NhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785298755; x=1785903555;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hkLA6W0PUdV91Pw6d1+RRyVHtsCnspPWU+MRWCHNwvY=;
        b=cqj9aMEE3UEKEQIBi7vhSrr9DxERvldXGiUk7x9u6bM9pOaWTNNt5Scw2C0fP8mWCn
         xwEuqmXT8AGWs709MxcHQULwaeQ+TjiJlMRF8dA4+lQ/lHW0KB6KfAh5qUWUzDuCpDBE
         ZWtDsmdY2EHAiBVPhJqBYTBKefGbRMS1fDVb62Q9d7qm5JaEtm0PtkGl9YRNek04F8kD
         qiRuAxVIZ2eHekgFxShkbUAOjcq9N8/39uhScWH6/37Bjw/2Z38eOaSPz7A3Za8JoSMd
         DEXOJuq+fEv+jrug9OXLb7fkqwz9QIP6o2WcrAwQh4QifRAkwpZg96g4WFi5E46+7ZI5
         vgKw==
X-Forwarded-Encrypted: i=1; AHgh+RpFdWGUbFIGHqDp2So6eBQpchdpXJ+w9VIh3Z/ql+X36/XvHrhkXoRVo7XY72gRcVgmh4y3yoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMyKwvcbkcNkvV0pNzOFtTWME6EDDrxo6IKUPlh8tqdDursF2K
	enWVw8UC9Xs2UqfIOSMYgVqb7q3Hz5sbvulIkz36Lgsa2cmp2l/nbkW0AhVaMxe+IpQs4kRRE+m
	jc2xtNZAYuM0c10yDUo4fL9Y824Va0I4=
X-Gm-Gg: AR+sD12MQRCFTvDA5e4fGVdNE9ufz1qEfQa5NtVFoZlyrQS49KjJGruWQ34Kc0qGsy3
	+k7j6CW+DFBNZu1gRkjmI3hG/dYbx5s5QBD/2q6hBMNjQe1XvxIfxukaC0wWw4P2Tl0+WNsVAc3
	1LmXbxfZXpQ+grHieQISc6q4MKsR6gk32k9ox9+hqP10sCbkZsxUYcX5gyQH5nKciqvZ8mlpo/1
	ns8sjajaDXJXr0wmxLnGsvVE5d+86E0ZISj2587EkHMoS6hTK2+2n3vzoqUSQTrywSHRn8OWY+R
	mOXzzwviyYf9nGnET4h9OBb3VuvkMb9MRuBQ0VkWwS/Thj32fwjvLS387IVi5d9vwEJcrDUQ1Q=
	=
X-Received: by 2002:a17:907:3d4f:b0:c16:2139:dae4 with SMTP id
 a640c23a62f3a-c1f71d2c1ddmr256152366b.6.1785298754928; Tue, 28 Jul 2026
 21:19:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718092544.785289-1-bestswngs@gmail.com> <20260718092544.785289-2-bestswngs@gmail.com>
 <GV1P189MB1988EC5A7F5CB5DD69F331AEC6C32@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <CANgPUi2hfRO8OebwBFm2f8240DYmqdPYNQtWyQL0VOP8beeSFQ@mail.gmail.com>
 <GV1P189MB1988CB4E92D2BDFB80894B4BC6C22@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <CANgPUi2bEtnuW3P2epaX+Mat7Szj=Pb6L6o_RL5C8BiHcVkYKg@mail.gmail.com>
 <GV1P189MB1988EAC59F2BA9A44B9174C2C6CB2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <CANgPUi23ZtxEwmrHJiqsnCm=ZcTd-Afc9WyqV_3=k24e5U-8DQ@mail.gmail.com> <GV1P189MB19883DC2E5A103040A4AEC06C6CA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB19883DC2E5A103040A4AEC06C6CA2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Weiming Shi <thebestswings@gmail.com>
Date: Wed, 29 Jul 2026 12:18:38 +0800
X-Gm-Features: AUfX_mz64vvdv8fBdosM-51TPzGbArVVm5O_mKINSBR2MvVCQpogFxrkEAQTZds
Message-ID: <CANgPUi3K+aqcUSHwQMoRzs5nt9_TnWR8YasRSxZiS=V_wN_m8Q@mail.gmail.com>
Subject: Re: [PATCH net v8 1/3] tipc: fix NULL deref in tipc_named_node_up()
 on empty publication list
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Xiang Mei <xmei5@asu.edu>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Maloy <jmaloy@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"tipc-discussion@lists.sourceforge.net" <tipc-discussion@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=8829=E6=97=A5=E5=91=A8=E4=B8=89 11:50=E5=86=99=E9=81=93=EF=BC=9A
>
> >It looks like the limit check also needs to skip NODE_STATE, LINK_STATE =
and
> >TOP_SRV, as the counter update does.
> I fixed the missing skip for these protocol service types and another cou=
nter leak in below updated patch.
> Could you please verify it ?
>
> Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> ---
>  net/tipc/core.c       |   3 ++
>  net/tipc/core.h       |   4 ++
>  net/tipc/name_distr.c |  91 +++++++++++++++++++++++++++++----
>  net/tipc/name_distr.h |   3 +-
>  net/tipc/name_table.c |  30 +++++++++--
>  net/tipc/net.c        |   5 ++
>  net/tipc/node.c       | 115 ++++++++++++++++++++++++++++++++++++++++--
>  net/tipc/node.h       |   1 +
>  8 files changed, 234 insertions(+), 18 deletions(-)
>
> diff --git a/net/tipc/core.c b/net/tipc/core.c
> index 315975c3be81..1e1fe78cc4ee 100644
> --- a/net/tipc/core.c
> +++ b/net/tipc/core.c
> @@ -61,6 +61,8 @@ static int __net_init tipc_init_net(struct net *net)
>         tn->trial_addr =3D 0;
>         tn->addr_trial_end =3D 0;
>         tn->capabilities =3D TIPC_NODE_CAPABILITIES;
> +       atomic_set(&tn->node_wq_count, 0);
> +       atomic_set(&tn->finalized, 0);
>         INIT_WORK(&tn->work, tipc_net_finalize_work);
>         memset(tn->node_id, 0, sizeof(tn->node_id));
>         memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
> @@ -119,6 +121,7 @@ static void __net_exit tipc_exit_net(struct net *net)
>  #ifdef CONFIG_TIPC_CRYPTO
>         tipc_crypto_stop(&tipc_net(net)->crypto_tx);
>  #endif
> +       wait_var_event(&tn->node_wq_count, !atomic_read(&tn->node_wq_coun=
t));
>         wait_var_event(&tn->wq_count, atomic_read(&tn->wq_count) =3D=3D 0=
);
>  }
>
> diff --git a/net/tipc/core.h b/net/tipc/core.h
> index 9ce5f9ff6cc0..be335ce83389 100644
> --- a/net/tipc/core.h
> +++ b/net/tipc/core.h
> @@ -145,6 +145,10 @@ struct tipc_net {
>         struct work_struct work;
>         /* The numbers of work queues in schedule */
>         atomic_t wq_count;
> +       /* The numbers of works of created nodes in schedule */
> +       atomic_t node_wq_count;
> +       /* flag to wake up scheduled works of created nodes */
> +       atomic_t finalized;
>  };
>
>  static inline struct tipc_net *tipc_net(struct net *net)
> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index ba4f4906e13b..e701824bbb2a 100644
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
> @@ -212,15 +214,86 @@ void tipc_named_node_up(struct net *net, u32 dnode,=
 u16 capabilities)
>
>         __skb_queue_head_init(&head);
>         spin_lock_bh(&tn->nametbl_lock);
> -       if (!(capabilities & TIPC_NAMED_BCAST))
> -               nt->rc_dests++;
>         seqno =3D nt->snd_nxt;
>         spin_unlock_bh(&tn->nametbl_lock);
>
>         read_lock_bh(&nt->cluster_scope_lock);
> -       named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
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
> +       spin_lock_bh(&tn->nametbl_lock);
> +       if (!(capabilities & TIPC_NAMED_BCAST))
> +               nt->rc_dests++;
> +       spin_unlock_bh(&tn->nametbl_lock);
> +
> +       read_lock_bh(&nt->cluster_scope_lock);
> +       /* 1. tipc_net_finalize_work() is not scheduled because of namesp=
ace
> +        *    teardown.
> +        * 2. Or tipc_net_finalize() ---> tipc_nametbl_publish() has fail=
ed
> +        *    to insert node self address publication to nt->cluster_scop=
e
> +        *    due to memory allocation failure.
> +        * 3. Or tipc_net_finalize() ---> tipc_nametbl_publish() has not
> +        *    executed yet.
> +        */
> +       if (unlikely(list_empty(&nt->cluster_scope))) {
> +               read_unlock_bh(&nt->cluster_scope_lock);
> +               return 1;
> +       }
> +       read_unlock_bh(&nt->cluster_scope_lock);
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
> +       struct name_table *nt =3D tipc_name_table(net);
> +       bool reinsert =3D false;
> +
> +       read_lock_bh(&nt->cluster_scope_lock);
> +       if (unlikely(list_empty(&nt->cluster_scope)))
> +               reinsert =3D true;
> +       read_unlock_bh(&nt->cluster_scope_lock);
> +       /* tipc_net_finalize() ---> tipc_nametbl_publish() has failed to =
insert
> +        * node self address publication to nt->cluster_scope due to memo=
ry
> +        * allocation failure. So, reinsert this publication.
> +        */
> +       if (reinsert) {
> +               struct tipc_net *tn =3D tipc_net(net);
> +               struct tipc_socket_addr sk;
> +               struct tipc_uaddr ua;
> +
> +               sk.ref =3D 0;
> +               sk.node =3D tn->node_addr;
> +               tipc_uaddr(&ua, TIPC_SERVICE_RANGE, TIPC_CLUSTER_SCOPE,
> +                          TIPC_NODE_STATE, tn->node_addr, tn->node_addr)=
;
> +               if (!tipc_nametbl_publish(net, &ua, &sk, tn->node_addr))
> +                       return -ENOBUFS;
> +       }
> +
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
> diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
> index 253c72d1366e..d651605f95f2 100644
> --- a/net/tipc/name_table.c
> +++ b/net/tipc/name_table.c
> @@ -763,21 +763,40 @@ struct publication *tipc_nametbl_publish(struct net=
 *net, struct tipc_uaddr *ua,
>                                          struct tipc_socket_addr *sk, u32=
 key)
>  {
>         struct name_table *nt =3D tipc_name_table(net);
> +       u32 max_user_pub =3D TIPC_MAX_PUBL - 1;
>         struct tipc_net *tn =3D tipc_net(net);
>         struct publication *p =3D NULL;
>         struct sk_buff *skb =3D NULL;
> +       bool protocol_type =3D false;
>         u32 rc_dests;
>
> +       if (ua->sr.type =3D=3D TIPC_NODE_STATE || ua->sr.type =3D=3D TIPC=
_LINK_STATE ||
> +           ua->sr.type =3D=3D TIPC_TOP_SRV)
> +               protocol_type =3D true;
> +
>         spin_lock_bh(&tn->nametbl_lock);
> +       if (protocol_type)
> +               goto insert;
>
> -       if (nt->local_publ_count >=3D TIPC_MAX_PUBL) {
> -               pr_warn("Bind failed, max limit %u reached\n", TIPC_MAX_P=
UBL);
> +       /* Reserve one entry for node state service type because it has c=
luster
> +        * scope and it is distributed in bulk. So, the maximum number of=
 user's
> +        * publications is (TIPC_MAX_PUBL - 1).
> +        */
> +       if (nt->local_publ_count >=3D max_user_pub) {
> +               pr_warn("Bind failed, max limit %u reached\n", max_user_p=
ub);
>                 goto exit;
>         }
>
> +insert:
>         p =3D tipc_nametbl_insert_publ(net, ua, sk, key);
>         if (p) {
> -               nt->local_publ_count++;
> +               /* Not count node state, link state and topology server t=
ypes
> +                * so that maximum nt->local_publ_count does not prevent
> +                * protocol service types from being inserted to the name
> +                * table.
> +                */
> +               if (!protocol_type)
> +                       nt->local_publ_count++;
>                 skb =3D tipc_named_publish(net, p);
>         }
>         rc_dests =3D nt->rc_dests;
> @@ -810,7 +829,10 @@ void tipc_nametbl_withdraw(struct net *net, struct t=
ipc_uaddr *ua,
>
>         p =3D tipc_nametbl_remove_publ(net, ua, sk, key);
>         if (p) {
> -               nt->local_publ_count--;
> +               if (p->sr.type !=3D TIPC_NODE_STATE &&
> +                   p->sr.type !=3D TIPC_LINK_STATE &&
> +                   p->sr.type !=3D TIPC_TOP_SRV)
> +                       nt->local_publ_count--;
>                 skb =3D tipc_named_withdraw(net, p);
>                 list_del_init(&p->binding_sock);
>                 kfree_rcu(p, rcu);
> diff --git a/net/tipc/net.c b/net/tipc/net.c
> index 7e65d0b0c4a8..75ac4e3cd01a 100644
> --- a/net/tipc/net.c
> +++ b/net/tipc/net.c
> @@ -139,6 +139,11 @@ static void tipc_net_finalize(struct net *net, u32 a=
ddr)
>         tipc_sk_reinit(net);
>         tipc_mon_reinit_self(net);
>         tipc_nametbl_publish(net, &ua, &sk, addr);
> +       atomic_set(&tn->finalized, 1);
> +       /* Wake up nodes waiting for distributing bulk of publications
> +        * if applicable.
> +        */
> +       tipc_node_wakeup(net);
>  }
>
>  void tipc_net_finalize_work(struct work_struct *work)
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 8e4ef2630ae4..ae7be02a65a9 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -111,6 +111,9 @@ struct tipc_bclink_entry {
>   * @peer_net: peer's net namespace
>   * @peer_hash_mix: hash for this peer (FIXME)
>   * @crypto_rx: RX crypto handler
> + * @work: work item for bulk distribution of cluster scope publications
> + * @work_scheduled: flag to indicate the work has been scheduled
> + * @finalized: flag to wake up scheduled work
>   */
>  struct tipc_node {
>         u32 addr;
> @@ -145,6 +148,9 @@ struct tipc_node {
>  #ifdef CONFIG_TIPC_CRYPTO
>         struct tipc_crypto *crypto_rx;
>  #endif
> +       struct work_struct work;
> +       atomic_t work_scheduled;
> +       atomic_t finalized;
>  };
>
>  /* Node FSM states and events:
> @@ -393,6 +399,62 @@ static void tipc_node_write_unlock_fast(struct tipc_=
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
> +       struct tipc_net *tn =3D tipc_net(node->net);
> +
> +       wait_var_event(&node->finalized, atomic_read(&node->finalized));
> +
> +       /* node is down */
> +       if (!atomic_read(&node->work_scheduled))
> +               goto exit;
> +
> +       /* Stop waking up work in tipc_node_timeout() */
> +       atomic_set(&node->work_scheduled, 0);
> +
> +       if (tipc_named_dist_cluster_scope(node->net, node->addr) < 0)
> +               tipc_node_down(node);
> +
> +exit:
> +       if (atomic_dec_and_test(&tn->node_wq_count))
> +               wake_up_var(&tn->node_wq_count);
> +
> +       tipc_node_put(node);
> +}
> +
> +static void tipc_node_cancel_work(struct tipc_node *node)
> +{
> +       if (atomic_read(&node->work_scheduled)) {
> +               struct tipc_net *tn =3D tipc_net(node->net);
> +
> +               /* Wake up scheduled work if it is waiting. */
> +               if (!atomic_read(&node->finalized)) {
> +                       atomic_set(&node->work_scheduled, 0);
> +                       atomic_set(&node->finalized, 1);
> +                       wake_up_var(&node->finalized);
> +               }
> +
> +               /* Work is pending */
> +               if (cancel_work(&node->work)) {
> +                       if (atomic_dec_and_test(&tn->node_wq_count))
> +                               wake_up_var(&tn->node_wq_count);
> +                       tipc_node_put(node);
> +               }
> +       }
> +}
> +
>  static void tipc_node_write_unlock(struct tipc_node *n)
>         __releases(n->lock)
>  {
> @@ -421,11 +483,32 @@ static void tipc_node_write_unlock(struct tipc_node=
 *n)
>
>         write_unlock_bh(&n->lock);
>
> -       if (flags & TIPC_NOTIFY_NODE_DOWN)
> +       if (flags & TIPC_NOTIFY_NODE_DOWN) {
>                 tipc_publ_notify(net, publ_list, node, n->capabilities);
> -
> -       if (flags & TIPC_NOTIFY_NODE_UP)
> -               tipc_named_node_up(net, node, n->capabilities);
> +               tipc_node_cancel_work(n);
> +       }
> +
> +       if (flags & TIPC_NOTIFY_NODE_UP) {
> +               struct tipc_net *tn =3D tipc_net(net);
> +               int rc =3D 0;
> +
> +               rc =3D tipc_named_node_up(net, node, n->capabilities);
> +               /* Defer bulk distribution to work queue */
> +               if (rc > 0) {
> +                       atomic_set(&n->work_scheduled, 1);
> +                       atomic_inc(&tn->node_wq_count);
> +                       tipc_node_get(n);
> +                       if (!schedule_work(&n->work)) {
> +                               atomic_dec(&tn->node_wq_count);
> +                               tipc_node_put(n);
> +                       }
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
> @@ -564,6 +647,9 @@ struct tipc_node *tipc_node_create(struct net *net, u=
32 addr, u8 *peer_id,
>         INIT_LIST_HEAD(&n->list);
>         INIT_LIST_HEAD(&n->publ_list);
>         INIT_LIST_HEAD(&n->conn_sks);
> +       INIT_WORK(&n->work, tipc_node_dist_bulk);
> +       atomic_set(&n->work_scheduled, 0);
> +       atomic_set(&n->finalized, 0);
>         skb_queue_head_init(&n->bc_entry.namedq);
>         skb_queue_head_init(&n->bc_entry.inputq1);
>         __skb_queue_head_init(&n->bc_entry.arrvq);
> @@ -653,6 +739,21 @@ void tipc_node_stop(struct net *net)
>         spin_unlock_bh(&tn->node_list_lock);
>  }
>
> +void tipc_node_wakeup(struct net *net)
> +{
> +       struct tipc_net *tn =3D tipc_net(net);
> +       struct tipc_node *node;
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(node, &tn->node_list, list) {
> +               if (atomic_read(&node->work_scheduled)) {
> +                       atomic_set(&node->finalized, 1);
> +                       wake_up_var(&node->finalized);
> +               }
> +       }
> +       rcu_read_unlock();
> +}
> +
>  void tipc_node_subscribe(struct net *net, struct list_head *subscr, u32 =
addr)
>  {
>         struct tipc_node *n;
> @@ -801,6 +902,7 @@ static bool tipc_node_cleanup(struct tipc_node *peer)
>  static void tipc_node_timeout(struct timer_list *t)
>  {
>         struct tipc_node *n =3D timer_container_of(n, t, timer);
> +       struct tipc_net *tn =3D tipc_net(n->net);
>         struct tipc_link_entry *le;
>         struct sk_buff_head xmitq;
>         int remains =3D n->link_cnt;
> @@ -814,6 +916,11 @@ static void tipc_node_timeout(struct timer_list *t)
>                 return;
>         }
>
> +       if (atomic_read(&tn->finalized) && atomic_read(&n->work_scheduled=
)) {
> +               atomic_set(&n->finalized, 1);
> +               wake_up_var(&n->finalized);
> +       }
> +
>  #ifdef CONFIG_TIPC_CRYPTO
>         /* Take any crypto key related actions first */
>         tipc_crypto_timeout(n->crypto_rx);
> diff --git a/net/tipc/node.h b/net/tipc/node.h
> index 154a5bbb0d29..c7bc3bc05328 100644
> --- a/net/tipc/node.h
> +++ b/net/tipc/node.h
> @@ -75,6 +75,7 @@ enum {
>  #define INVALID_BEARER_ID -1
>
>  void tipc_node_stop(struct net *net);
> +void tipc_node_wakeup(struct net *net);
>  bool tipc_node_get_id(struct net *net, u32 addr, u8 *id);
>  u32 tipc_node_get_addr(struct tipc_node *node);
>  char *tipc_node_get_id_str(struct tipc_node *node);
> --
> 2.43.0
>

Hi Tung,

I tested the updated patch on v7.2-rc5 with the same reproducer.
The reproducer completed the full 400-second run without publication
errors, crashes, hung tasks, or netns teardown issues.

Tested-by: Weiming Shi <bestswngs@gmail.com>

Also, please remember to add the following tag when posting the patch:
Reported-by: Xiang Mei <xmei5@asu.edu>

Thanks for your work on this.
Weiming Shi
