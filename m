Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8B248F73
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314890; cv=pass; b=q/nvKlFE0xpi6dSjAFuz2XnoY8gA3CoHrNeO6m1SFgzrxmhYocI7z8+gVYK4OT9Tz9n6jdi4spjIe+R0Y9ufLCOwxTyDNX4SfB7v2VSZpwjyfJmJrd/aLQXUKUije3QM72lSReGuu3dguBPC24QzxqAYLDpGWdNlFjjBgYU55vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314890; c=relaxed/simple;
	bh=RXytuPnd17QZJov0eESiNLyWilUHKnFFgT2acnzV/h0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgkEz1lWLATbx09F3d80y0JIJRmbrIsHAlKzOB1pT8wKT2/SSA1Ov3rLHH24wSpgcDwl8n/pt1TvCGd5k25jgTm58Eb7uOnq+9RjQaW2rRFYNI5aa10NDL9Ur0982g++FvDXfIFCUm5/jej9WGXBIPhnPuGUX8h673YK3MClI54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dElpo+jv; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dElpo+jv"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15e592da74so1009159566b.1
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 12:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784314887; cv=none;
        d=google.com; s=arc-20260327;
        b=UlY+hqu8AHTMHWbOLPGQ4ED+al/mTxxrMggEYdXtncGoC7Qc+KRTV9Mw7hZOyvsds7
         xblrMLcoNdw4WPtlboTMJ+v0aNLP6b/KYHPJEpRQJRl2N7CCMRWuwpdWg0NZaaShieYa
         4n+MS5yOkLeYqqxV3lWHP/5YlOvWgvTWPfGow7kxdQY0akVr3Se+ndIAgnmiH/vKffvT
         H12s1HoEnfRnudzTc3rzpsQwzp0sWANRoAG7FK7NLI0lCRNRy5DWJZxM8VJLc/FzZE6C
         hKqRb/BMiQNF9bisnilFNkxefz+MPOvmWi1od6298xxT+8+V9t3H5AGUlKDpYtG9NR1L
         qVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iodf7c1umnii3FGCxh+MTkuKHGpkOX/Gh/lAx9t+9ks=;
        fh=m7VR74eUURRG4a3kkxCpuPyIkXT0WZw+o1nhYgOzoVo=;
        b=D0m6P3ut/h6TPrqFvgrVasafzZNsJEwmS2JxoAyre2vaNSBFSiHbkjUBWhsWk7zANz
         pzAQqw7C2Am/CB0jeLwst39REBxih/OsnO1E3cgL2JYuhooN0p4z+1RUowdN0YTKIn1X
         ehmV15ABB0y1z2PNBnxPI7xS/XkHnvdkKJyT1k0CfMFIw1Q7ytDld179V3wr92M9Nz4p
         pBtQctgb4MjoYC4Wo/XeJDCrMG5dqos3T/NNPxRYrXZzdWvIEfjvf/VBcMVXfBikzHWV
         xS27RX65wT5nk5BNCilCbpX57DO/6rPS0tlr7a81ygt+pl2i8q2wSLPKtw/TZ5o1HnHF
         6zxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784314887; x=1784919687; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iodf7c1umnii3FGCxh+MTkuKHGpkOX/Gh/lAx9t+9ks=;
        b=dElpo+jvjvn5QEHD2Cuhn6VQc+8+6heE/ecozorwLVXSNOXWS8WAlsItPhll92XZtg
         tcVstHImxEu1AKJYsgpug/Jyzr8AS9KKUo8qFdq+K47D26A1qrzlWSbvlEBXfLoXG/Ow
         +yIimLj6dMbHrfUyoP7aDGwV7GJjs8t9ZVYAjzFxjBmmkP/xMOUst4sxQNjUTA1mluM5
         XBgwemO/VvmIiy1HE0c764FqyLEjLF+9PHPCM7+JLBTDMvDTLNqPPDF4ch7QINB19wxX
         SwpRpl4u2M3GFMCFo1VKrUVkFYpigsbv9JzH+tbenguWpkwjnFKqZZEJCOmY+zMnXsZi
         HTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784314887; x=1784919687;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iodf7c1umnii3FGCxh+MTkuKHGpkOX/Gh/lAx9t+9ks=;
        b=gHsP//7459iAwgUUAktBf/jUUs+AVD/ANbICfTL1WvlByWu1mpbegtTtPrhAOFYFLU
         A6l5Gf+yVAnYzQ9KUDQY2mCzkjNh+5J+k7tjQi8xrJ6wDXjcA6Qm4XhplzWYUzyRN7TS
         HYikZIFA0nOZKqvPNwGXeCVzDVkElv92YASKO+h730/jUY6nAprWfzRTyKwrZApJH3AX
         RWa4ZPiw2gGtRJaPswDbqNGGfE74VJdT1wiKmHle0voHL9LUbxX0NnVNvprUkl/Q5QwT
         5qsLf6gwo6Me+vgC5M/6TbDYXy9fWTSyXZzAw/rYJhXaWnKQFju5GAWE6U/FNGt3dQKY
         s7Fg==
X-Gm-Message-State: AOJu0YypM7/2w30FOgEQ3wWhKJ9QsbclBo8BLRNVZAHBCieJtipm3xDd
	xu3GhxK8QXasGtC8RVwqpOvJWpB9VmmtY57CBnQhm9u4hB8Sn3Bhr86LmSpbNlAoYrozDn9xskX
	mIK0Ar4wM9cYppy/0esxgCYH9bjEbF8I=
X-Gm-Gg: AfdE7ck4IDPJlh1235EoXEz1ljPf/ES8cmtMq6ml8mMGWWnS1Uja1wCBbX8TJvdCpj+
	zEUqoxm8a0nZARI1BmWswUYRU9BKMBns8qLstxw3fHlsI9fYR5x6ww7ARDMDaSodHsiuOqfR+jG
	DPFFZ+02Vr6FBJ37mbaj+Po1RlBund3dzMdbq6MjjSPOcgcEZanG1/fFe7oPNvhWs392yNF+ouT
	489aHZaoaVlVcC6UW/zwPsM/8cE2Gk6kT49pghtB84m6zOg1GFvXcwHaPPoVisF+zGuakK2GDP/
	ccIyt0JenTiSmANDyg==
X-Received: by 2002:a17:907:d1f:b0:c12:7b74:7812 with SMTP id
 a640c23a62f3a-c16b48669d0mr193153266b.59.1784314886339; Fri, 17 Jul 2026
 12:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716190204.100895-2-bestswngs@gmail.com> <20260716190204.100895-4-bestswngs@gmail.com>
 <GV1P189MB1988F91A48BC981B816C2700C6C62@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <CANgPUi1QTDP5Xo9LanuBEgzDREcxbAc6KE4Ltccoz_O6DF0=3Q@mail.gmail.com>
In-Reply-To: <CANgPUi1QTDP5Xo9LanuBEgzDREcxbAc6KE4Ltccoz_O6DF0=3Q@mail.gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sat, 18 Jul 2026 03:00:49 +0800
X-Gm-Features: AUfX_mygdcqsrTAfjtZ1DCGSFgti7pozruvbZcrrsOLljDb2ki4FZhi06RRm6Qo
Message-ID: <CANgPUi31G4DvrBPDRGniPDzWTUKo_3HQL8W1nq8BMmtnp8Fa+g@mail.gmail.com>
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

Weiming Shi <bestswngs@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8818=E6=97=
=A5=E5=91=A8=E5=85=AD 02:34=E5=86=99=E9=81=93=EF=BC=9A
>
> Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B47=E6=
=9C=8817=E6=97=A5=E5=91=A8=E4=BA=94 17:48=E5=86=99=E9=81=93=EF=BC=9A
> >
> > >Subject: [PATCH net v4 2/2] tipc: fix NULL deref in tipc_named_node_up=
() on
> > >empty publication list
> > >
> > >named_distribute() ends by stamping the last_bulk flag on the tail skb=
 via
> > >buf_msg(skb_peek_tail(list)). When the publication list is empty no sk=
b is
> > >enqueued, skb_peek_tail() returns NULL, and buf_msg(NULL) is dereferen=
ced.
> > >
> > >tipc_named_node_up() runs this on &nt->cluster_scope. With a node-id
> > >configuration cluster_scope is populated only later by tipc_net_finali=
ze(), so a
> > >peer link that comes up first reaches named_distribute() with an empty=
 list. It
> > >is reachable by an unprivileged user (TIPC genl ops use
> > >GENL_UNS_ADMIN_PERM) over a UDP bearer in a user+net namespace:
> > >
> > > KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000df=
]
> > > RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
> > >  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.c:=
221)
> > >  tipc_node_write_unlock (net/tipc/node.c:428)
> > >  tipc_rcv (net/tipc/node.c:2185)
> > >  tipc_udp_recv (net/tipc/udp_media.c:392)  Kernel panic - not syncing=
: Fatal
> > >exception in interrupt
> > >
> > >The peer holds back this node's later name updates until it sees a bul=
k with the
> > >last_bulk flag, so simply skipping the send would stall it. Emit an it=
em-less bulk
> > >when the publication list is empty, so the peer still receives the las=
t_bulk flag
> > >and opens.
> > >
> > >Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
> > >Reported-by: Xiang Mei <xmei5@asu.edu>
> > >Assisted-by: Claude:claude-opus-4-8
> > >Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > >---
> > > net/tipc/name_distr.c | 14 ++++++++++++++
> > > 1 file changed, 14 insertions(+)
> > >
> > >diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
> > >ba4f4906e13b..a8bb7bd101ea 100644
> > >--- a/net/tipc/name_distr.c
> > >+++ b/net/tipc/name_distr.c
> > >@@ -192,6 +192,20 @@ static void named_distribute(struct net *net, str=
uct
> > >sk_buff_head *list,
> > >               skb_trim(skb, INT_H_SIZE + (msg_dsz - msg_rem));
> > >               __skb_queue_tail(list, skb);
> > >       }
> > >+
> > >+      if (skb_queue_empty(list)) {
> > >+              skb =3D named_prepare_buf(net, PUBLICATION, 0, dnode);
> > >+              if (!skb) {
> > >+                      pr_warn("Bulk publication failure\n");
> > >+                      return;
> > >+              }
> > >+              hdr =3D buf_msg(skb);
> > >+              msg_set_bc_ack_invalid(hdr, true);
> > >+              msg_set_bulk(hdr);
> > >+              msg_set_non_legacy(hdr);
> > >+              __skb_queue_tail(list, skb);
> > >+      }
> > As I explained before, this approach is wrong because
> > 1. It does not handle memory allocation failure.
> > 2. It breaks receiving peer by  sending non-data message to that peer i=
n case skb is not NULL.
> >
> > Could you please test below patch to see if it fixes the NULL dereferen=
ce issue you reported ?
>
> Hi ,
> Tested your patch, it fixes the NULL dereference I reported. No more
> panic with an empty cluster_scope .
>
> One new bug found during testing: if tipc_nametbl_publish() fails in
> tipc_net_finalize(), the node is
> still marked finalized, so the deferred worker wakes up and calls
> named_distribute() with an empty list,
> hitting the same NULL dereference.
>
> I have the fix ready and sent it out:
>
> https://lore.kernel.org/all/20260717183047.2725959-1-bestswngs@gmail.com/
> https://lore.kernel.org/all/20260717183047.2725959-2-bestswngs@gmail.com/
> https://lore.kernel.org/all/20260717183047.2725959-3-bestswngs@gmail.com/
>
> Thanks,
> Weiming Shi
>

Hi,
The v5 I sent earlier was incomplete. It only carried the two
follow-up patches and depended on Tung's
patch from this thread as its base, which made the series hard to
apply on its own.

I have resent the series as v6:
https://lore.kernel.org/all/20260717185701.2828080-1-bestswngs@gmail.com/

Sorry for the noise.
> >
> > ---
> >  net/tipc/core.c       |  1 +
> >  net/tipc/core.h       |  2 ++
> >  net/tipc/name_distr.c | 48 +++++++++++++++++++++++++++++++++++++++----
> >  net/tipc/name_distr.h |  3 ++-
> >  net/tipc/net.c        |  2 ++
> >  net/tipc/node.c       | 34 ++++++++++++++++++++++++++++--
> >  6 files changed, 83 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/tipc/core.c b/net/tipc/core.c
> > index 315975c3be81..9e81be4f01cf 100644
> > --- a/net/tipc/core.c
> > +++ b/net/tipc/core.c
> > @@ -61,6 +61,7 @@ static int __net_init tipc_init_net(struct net *net)
> >         tn->trial_addr =3D 0;
> >         tn->addr_trial_end =3D 0;
> >         tn->capabilities =3D TIPC_NODE_CAPABILITIES;
> > +       atomic_set(&tn->finalized, 0);
> >         INIT_WORK(&tn->work, tipc_net_finalize_work);
> >         memset(tn->node_id, 0, sizeof(tn->node_id));
> >         memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
> > diff --git a/net/tipc/core.h b/net/tipc/core.h
> > index 9ce5f9ff6cc0..76768844c808 100644
> > --- a/net/tipc/core.h
> > +++ b/net/tipc/core.h
> > @@ -145,6 +145,8 @@ struct tipc_net {
> >         struct work_struct work;
> >         /* The numbers of work queues in schedule */
> >         atomic_t wq_count;
> > +       /* flag to indicate work has finished */
> > +       atomic_t finalized;
> >  };
> >
> >  static inline struct tipc_net *tipc_net(struct net *net)
> > diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> > index ba5f4906e13b..8a1692dbd243 100644
> > --- a/net/tipc/name_distr.c
> > +++ b/net/tipc/name_distr.c
> > @@ -147,7 +147,7 @@ struct sk_buff *tipc_named_withdraw(struct net *net=
, struct publication *p)
> >   * @pls: linked list of publication items to be packed into buffer cha=
in
> >   * @seqno: sequence number for this message
> >   */
> > -static void named_distribute(struct net *net, struct sk_buff_head *lis=
t,
> > +static int named_distribute(struct net *net, struct sk_buff_head *list=
,
> >                              u32 dnode, struct list_head *pls, u16 seqn=
o)
> >  {
> >         struct publication *publ;
> > @@ -164,8 +164,9 @@ static void named_distribute(struct net *net, struc=
t sk_buff_head *list,
> >                         skb =3D named_prepare_buf(net, PUBLICATION, msg=
_rem,
> >                                                 dnode);
> >                         if (!skb) {
> > +                               __skb_queue_purge(list);
> >                                 pr_warn("Bulk publication failure\n");
> > -                               return;
> > +                               return 1;
> >                         }
> >                         hdr =3D buf_msg(skb);
> >                         msg_set_bc_ack_invalid(hdr, true);
> > @@ -195,6 +196,8 @@ static void named_distribute(struct net *net, struc=
t sk_buff_head *list,
> >         hdr =3D buf_msg(skb_peek_tail(list));
> >         msg_set_last_bulk(hdr);
> >         msg_set_named_seqno(hdr, seqno);
> > +
> > +       return 0;
> >  }
> >
> >  /**
> > @@ -203,7 +206,7 @@ static void named_distribute(struct net *net, struc=
t sk_buff_head *list,
> >   * @dnode: destination node
> >   * @capabilities: peer node's capabilities
> >   */
> > -void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
> > +int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
> >  {
> >         struct name_table *nt =3D tipc_name_table(net);
> >         struct tipc_net *tn =3D tipc_net(net);
> > @@ -218,9 +221,46 @@ void tipc_named_node_up(struct net *net, u32 dnode=
, u16 capabilities)
> >         spin_unlock_bh(&tn->nametbl_lock);
> >
> >         read_lock_bh(&nt->cluster_scope_lock);
> > -       named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
> > +       /* tipc_net_finalize_work() has not finished inserting self add=
ress to
> > +         * name table yet.
> > +         */
> > +       if (unlikely(list_empty(&nt->cluster_scope))) {
> > +               read_unlock_bh(&nt->cluster_scope_lock);
> > +               return 1;
> > +       }
> > +
> > +       if (named_distribute(net, &head, dnode, &nt->cluster_scope, seq=
no)) {
> > +               read_unlock_bh(&nt->cluster_scope_lock);
> > +               return -ENOBUFS;
> > +       }
> > +
> >         tipc_node_xmit(net, &head, dnode, 0);
> >         read_unlock_bh(&nt->cluster_scope_lock);
> > +       return 0;
> > +}
> > +
> > +int tipc_named_dist_cluster_scope(struct net *net, u32 dnode)
> > +{
> > +       struct name_table *nt =3D tipc_name_table(net);
> > +       struct tipc_net *tn =3D tipc_net(net);
> > +       struct sk_buff_head head;
> > +       u16 seqno;
> > +
> > +       __skb_queue_head_init(&head);
> > +       wait_var_event(&tn->finalized, atomic_read(&tn->finalized));
> > +       spin_lock_bh(&tn->nametbl_lock);
> > +       seqno =3D nt->snd_nxt;
> > +       spin_unlock_bh(&tn->nametbl_lock);
> > +
> > +       read_lock_bh(&nt->cluster_scope_lock);
> > +       if (named_distribute(net, &head, dnode, &nt->cluster_scope, seq=
no)) {
> > +               read_unlock_bh(&nt->cluster_scope_lock);
> > +               return -ENOBUFS;
> > +       }
> > +       tipc_node_xmit(net, &head, dnode, 0);
> > +       read_unlock_bh(&nt->cluster_scope_lock);
> > +
> > +       return 0;
> >  }
> >
> >  /**
> > diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
> > index c677f6f082df..cadf4e8c3e66 100644
> > --- a/net/tipc/name_distr.h
> > +++ b/net/tipc/name_distr.h
> > @@ -69,7 +69,8 @@ struct distr_item {
> >
> >  struct sk_buff *tipc_named_publish(struct net *net, struct publication=
 *publ);
> >  struct sk_buff *tipc_named_withdraw(struct net *net, struct publicatio=
n *publ);
> > -void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
> > +int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
> > +int tipc_named_dist_cluster_scope(struct net *net, u32 dnode);
> >  void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
> >                     u16 *rcv_nxt, bool *open);
> >  void tipc_named_reinit(struct net *net);
> > diff --git a/net/tipc/net.c b/net/tipc/net.c
> > index 7e65d0b0c4a8..4c144e720ac1 100644
> > --- a/net/tipc/net.c
> > +++ b/net/tipc/net.c
> > @@ -139,6 +139,8 @@ static void tipc_net_finalize(struct net *net, u32 =
addr)
> >         tipc_sk_reinit(net);
> >         tipc_mon_reinit_self(net);
> >         tipc_nametbl_publish(net, &ua, &sk, addr);
> > +       atomic_inc(&tn->finalized);
> > +       wake_up_var(&tn->finalized);
> >  }
> >
> >  void tipc_net_finalize_work(struct work_struct *work)
> > diff --git a/net/tipc/node.c b/net/tipc/node.c
> > index 8e4ef2630ae4..c5b0a98324c3 100644
> > --- a/net/tipc/node.c
> > +++ b/net/tipc/node.c
> > @@ -145,6 +145,8 @@ struct tipc_node {
> >  #ifdef CONFIG_TIPC_CRYPTO
> >         struct tipc_crypto *crypto_rx;
> >  #endif
> > +       /* Work item for bulk distribution of cluster scope publication=
s */
> > +       struct work_struct work;
> >  };
> >
> >  /* Node FSM states and events:
> > @@ -303,6 +305,7 @@ static void tipc_node_free(struct rcu_head *rp)
> >  #ifdef CONFIG_TIPC_CRYPTO
> >         tipc_crypto_stop(&n->crypto_rx);
> >  #endif
> > +       cancel_work_sync(&n->work);
> >         kfree(n);
> >  }
> >
> > @@ -393,6 +396,19 @@ static void tipc_node_write_unlock_fast(struct tip=
c_node *n)
> >         write_unlock_bh(&n->lock);
> >  }
> >
> > +static void tipc_node_dist_bulk(struct work_struct *work)
> > +{
> > +       struct tipc_node *node =3D container_of(work, struct tipc_node,=
 work);
> > +
> > +       if (tipc_named_dist_cluster_scope(node->net, node->addr) < 0) {
> > +               u32 bearer_id =3D node->link_id & 0xffff;
> > +
> > +               tipc_node_link_down(node, bearer_id, false);
> > +       }
> > +
> > +       tipc_node_put(node);
> > +}
> > +
> > static void tipc_node_write_unlock(struct tipc_node *n)
> >         __releases(n->lock)
> >  {
> > @@ -424,8 +440,21 @@ static void tipc_node_write_unlock(struct tipc_nod=
e *n)
> >         if (flags & TIPC_NOTIFY_NODE_DOWN)
> >                 tipc_publ_notify(net, publ_list, node, n->capabilities)=
;
> >
> > -       if (flags & TIPC_NOTIFY_NODE_UP)
> > -               tipc_named_node_up(net, node, n->capabilities);
> > +       if (flags & TIPC_NOTIFY_NODE_UP) {
> > +               int rc =3D 0;
> > +
> > +               rc =3D tipc_named_node_up(net, node, n->capabilities);
> > +               /* Defer bulk distribution to work queue */
> > +               if (rc > 0) {
> > +                       tipc_node_get(n);
> > +                       schedule_work(&n->work);
> > +               } else if (rc < 0) {
> > +                       /* Bring the link down to start over bulk distr=
ibution
> > +                        * when the link is up again.
> > +                        */
> > +                       tipc_node_link_down(n, bearer_id, false);
> > +               }
> > +       }
> >
> >         if (flags & TIPC_NOTIFY_LINK_UP) {
> >                 tipc_mon_peer_up(net, node, bearer_id);
> > @@ -564,6 +593,7 @@ struct tipc_node *tipc_node_create(struct net *net,=
 u32 addr, u8 *peer_id,
> >         INIT_LIST_HEAD(&n->list);
> >         INIT_LIST_HEAD(&n->publ_list);
> >         INIT_LIST_HEAD(&n->conn_sks);
> > +       INIT_WORK(&n->work, tipc_node_dist_bulk);
> >         skb_queue_head_init(&n->bc_entry.namedq);
> >         skb_queue_head_init(&n->bc_entry.inputq1);
> >         __skb_queue_head_init(&n->bc_entry.arrvq);
