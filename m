Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B833AA9DA
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261465; cv=pass; b=VmVsQ19X8xtXXeH12LMyFTi6vOdTV2WPea3O/7YRNvvFS+F4/WwBQmIhRCMO/pd+4Pk8dYUTwNsjj5bDS3jg6JPRCcnFj4imP1skDcGrtTpbSgAIijUV/nWKsFd64clgvtUWnYRbkVukYEQt5PK0mR/PrGJ/3m8oMSfgV1iyLag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261465; c=relaxed/simple;
	bh=KTgiSLqMXSnyZUkGXGfwA6nAuT/soad+HY+YNvIdmBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qfe/kQcyNmAAj/ihI1v6PN2GOhF0wrauynEo4hNtF8N/fMNt2lJba5tlHDedgqM8wlHqDpZ+RageiWwuiHs6fhCmi3miDU17KGhGg/KOZJstElVlOdiqoyeMy0FQrJCQyhyx1a0SC8UbAoX7H4eBOjJkn+t9A1dQcYC/gid1FZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m37bWmWW; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m37bWmWW"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c12614b81c9so18760466b.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 10:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785261461; cv=none;
        d=google.com; s=arc-20260327;
        b=ezbQnvDqdkO5UrHGzZEcvwNMzDHLBr5m79cUiE8tBcswCUeNsKV16lloirR195Cgjm
         POInbVbL6fU820rk7IiKfzjAvdepTJAYP/1XPKvRlRGYFXDzfthHsn/DYolncKPbRMKA
         iVf078uLUh4IYO6SV+w1os71ocd0FpNowcbHcuawpPSVvSEWS37BUOT/kg+bj+ercjZ4
         KiDG3AmS/lhdVkgb15QMDwNS+YT07HYSBGdGXvgGCCIQaHcvHnKiaBtUx5BjhvRwMVu/
         cfTRBiaCwMhcapI8IBAEeoaVfL1YeitAq31S0/bJ7Gw1cK+WlmqtTv21nvWQ04ZO/FnK
         Erxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VM9GKxvv9vw1+Bck3TPyRWHdupvJpJXJR9Jdu2y9h78=;
        fh=c3SZcjTp4AAXQeIoDsTohIDe1gTarQycPN8Pa1dvR8g=;
        b=Gn7yHPYVl/RAHR2V+2Oke/v75JwerJ4JtnEkPwVRcOKBk40hBf5prAAeKBjTC8JQym
         2/C6lfh3Slyg1zLZrbpGjKCtJugl0PH5PipgVMkj6Z/J5Qt9hMoSAzzOoYVdeRi9Tuf6
         WigdfzWA1tGsNHxf0DFiIJynvQZgq8VOreD/yTNdx9wHoMyreREkU0ku2pv+rIC3Sojq
         ovcNbbPFXnAQ3SbMEGbYZN/Idgj8pwplLviikPJaKu7RyBM1NOm+MyMoBUO679gUe5O0
         7AP9DV1WKtxBHFNB98lNBSKFci0GrcK+tdNJMDxlRy23/qkChYjR623nfo8V4v6usCon
         v/gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785261461; x=1785866261; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VM9GKxvv9vw1+Bck3TPyRWHdupvJpJXJR9Jdu2y9h78=;
        b=m37bWmWWr5/rm4WYic9ykcI9/RV1PW4QSqvZJRFn0fBxlZTh5AyRcbi3SEJaaYW1cw
         DafCiwCb66WuxlCfUc2PLl3IwnMskvZruh1WricCvMXEsXM87S3HWQ+BE+CwghAvqcD5
         BMS+2SM2MVyDtAdkP0KsocUx0vfr3h7ISP4eaZK0rTUJWywQKfaYe0qYtNoSVxQANY7a
         Idf7VqFyUfjOO6ATpYMBXB7s84ids3yc6e06zTgllP/RNK9Oag9ONlqTtcZIUV5W8Vk1
         Sx317WOvcVQH1njw3V2vqvBQ5v/nUnXI2D8iOEpNo8d+t+8nUhDidAG9FXtY7Cu5K67I
         jD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785261461; x=1785866261;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VM9GKxvv9vw1+Bck3TPyRWHdupvJpJXJR9Jdu2y9h78=;
        b=Vi3rdSEhSxnZD32bc9M/3SaOyABmXnSfpYMWG0TkQwE4a0sAhbOzsStJjqzUuT0cX3
         GwIUTynQnnjQ2mK+lEntlg+Puyu44fE5kil2riBHlHUpkEf/ybdFcjx6BHml74X2AEfW
         a3Orxcmbv+VTajWZhvqIhm+UJLJPBoq4sGIv0C0itDl53Vz9rRO+Zc1ptjFXP/z9AJiH
         6voi83uShDCpvbkjIe2twzbGAjCoNy3L4eQRrOywJJQmmlnCcNFSzYcUBA8ocNOZXi2c
         pBS2yumcTROmjnnD4Tt+9J9FtFjidG0xwgHIn0diJLKLO2sqaHSxIjVe0/o+f8wKHlRM
         QawQ==
X-Forwarded-Encrypted: i=1; AHgh+RraTNFeI/G5PRQBD1hfM6x138xbO1dYgqYb3bJAItxyv9iKdTyy2XSOV1bE6K5G1U0dK10mF4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTJmDnIoV6ZrgF9rp0Co1fH9NuuF+lDhZscxoPDQiWMnudRd8J
	aR2DE6K2DGrDlJoaa+SuuO++cS3lpdHbU/yyw9pQJJITH7jT1X6LmQmGCv7CcjyPgd7mf0L+QyA
	qfXcUHOarckZx8BdEhe/+U+JU5brSejU=
X-Gm-Gg: AR+sD132T8tXw9Mc8Eodc2fFGbEjCWeEwobulpu6uqqvvPlTdhpf5dRAAjMikpy7fFx
	8gS5OU+lvY2gmo/yFt8W04G8LLValDEvJWzfPRrjH9wz5XJmVIXxsKZqQCIMrjMycqAgYOKjZjW
	ps+EJ44cd/tP4vukm0vy/OvcZ4zYvl/id2cOLUpvE9oJgWb5XjnOfmpb1OrLh9pcRnArgA1eP+3
	dbZYMVK3lDMz3taz8TuQgIqwOI2jzpKqQk/NufSZHZCpYmze5B3Ero6B4w9S+zQ4iskNNMOSKr3
	lmKtWvMLofRdJmKj
X-Received: by 2002:a17:907:6d02:b0:c12:631c:67c6 with SMTP id
 a640c23a62f3a-c1f71d2e0bamr163385166b.1.1785261461056; Tue, 28 Jul 2026
 10:57:41 -0700 (PDT)
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
 <CANgPUi2bEtnuW3P2epaX+Mat7Szj=Pb6L6o_RL5C8BiHcVkYKg@mail.gmail.com> <GV1P189MB1988EAC59F2BA9A44B9174C2C6CB2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <GV1P189MB1988EAC59F2BA9A44B9174C2C6CB2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
From: Weiming Shi <thebestswings@gmail.com>
Date: Wed, 29 Jul 2026 01:57:04 +0800
X-Gm-Features: AUfX_mzUio_UviWzOAu7o-hv3pqZn7T0t1ICGH3WCsy_-DUf6oOkUguR0j844Qw
Message-ID: <CANgPUi23ZtxEwmrHJiqsnCm=ZcTd-Afc9WyqV_3=k24e5U-8DQ@mail.gmail.com>
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
=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C 20:52=E5=86=99=E9=81=93=EF=BC=9A
>
> >Hi Tung,
> >
> >Just following up on the issue. Let me know if you need any help from my=
 side
> >with testing or validation.
> Could you please verify below patch to see if it fixes all observed issue=
s ?
>
> Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
> ---
>  net/tipc/core.c       |   3 ++
>  net/tipc/core.h       |   4 ++
>  net/tipc/name_distr.c |  91 ++++++++++++++++++++++++++++++----
>  net/tipc/name_distr.h |   3 +-
>  net/tipc/name_table.c |  24 +++++++--
>  net/tipc/net.c        |   5 ++
>  net/tipc/node.c       | 113 ++++++++++++++++++++++++++++++++++++++++--
>  net/tipc/node.h       |   1 +
>  8 files changed, 226 insertions(+), 18 deletions(-)
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
> index 253c72d1366e..d44d65fa524e 100644
> --- a/net/tipc/name_table.c
> +++ b/net/tipc/name_table.c
> @@ -763,6 +763,7 @@ struct publication *tipc_nametbl_publish(struct net *=
net, struct tipc_uaddr *ua,
>                                          struct tipc_socket_addr *sk, u32=
 key)
>  {
>         struct name_table *nt =3D tipc_name_table(net);
> +       u32 max_user_pub =3D TIPC_MAX_PUBL - 1;
>         struct tipc_net *tn =3D tipc_net(net);
>         struct publication *p =3D NULL;
>         struct sk_buff *skb =3D NULL;
> @@ -770,14 +771,26 @@ struct publication *tipc_nametbl_publish(struct net=
 *net, struct tipc_uaddr *ua,
>
>         spin_lock_bh(&tn->nametbl_lock);
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
>         p =3D tipc_nametbl_insert_publ(net, ua, sk, key);
>         if (p) {
> -               nt->local_publ_count++;
> +               /* Not count node state, link state and topology server t=
ypes
> +                * so that maximum nt->local_publ_count does not prevent
> +                * protocol service types from being inserted to the name
> +                * table.
> +                */
> +               if (ua->sr.type !=3D TIPC_NODE_STATE &&
> +                   ua->sr.type !=3D TIPC_LINK_STATE &&
> +                   ua->sr.type !=3D TIPC_TOP_SRV)
> +                       nt->local_publ_count++;
>                 skb =3D tipc_named_publish(net, p);
>         }
>         rc_dests =3D nt->rc_dests;
> @@ -810,7 +823,10 @@ void tipc_nametbl_withdraw(struct net *net, struct t=
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
> index 8e4ef2630ae4..cbe398f888b9 100644
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
> @@ -421,11 +483,30 @@ static void tipc_node_write_unlock(struct tipc_node=
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
> @@ -564,6 +645,9 @@ struct tipc_node *tipc_node_create(struct net *net, u=
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
> @@ -653,6 +737,21 @@ void tipc_node_stop(struct net *net)
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
> @@ -801,6 +900,7 @@ static bool tipc_node_cleanup(struct tipc_node *peer)
>  static void tipc_node_timeout(struct timer_list *t)
>  {
>         struct tipc_node *n =3D timer_container_of(n, t, timer);
> +       struct tipc_net *tn =3D tipc_net(n->net);
>         struct tipc_link_entry *le;
>         struct sk_buff_head xmitq;
>         int remains =3D n->link_cnt;
> @@ -814,6 +914,11 @@ static void tipc_node_timeout(struct timer_list *t)
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

Hi Tung,

I tested this on v7.2-rc5 with the same reproducer from my previous
mail. The NULL dereference is fixed, and the reproducer completed the
full 400-second run. I did not see the parked worker or hung-task
report after bringing the bearer down.

But I found one remaining issue in the name table change. Once
local_publ_count reaches 65534, this check rejects all publications,
including TIPC_NODE_STATE:

        if (nt->local_publ_count >=3D max_user_pub)
                goto exit;

The protocol type check only happens later when updating the counter,
so the reserved slot cannot actually be used.

I see this immediately after both node numbers are assigned:

[    4.023556] tipc: Node number set to 572662306
[    4.028422] tipc: Bind failed, max limit 65534 reached
[    4.029343] tipc: Node number set to 286331153
[    4.033912] tipc: Bind failed, max limit 65534 reached

After that, the bind failure repeats together with type-2
"Failed to remove unknown binding" messages.

It looks like the limit check also needs to skip NODE_STATE,
LINK_STATE and TOP_SRV, as the counter update does.

Thanks,
Weiming Shi
