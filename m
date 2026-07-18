Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE434403A
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784366970; cv=pass; b=llPFzXW4HrEafS6EA1YYEvewBkaSHfaUZnwPAIUWw7HEJXtOX3XBnz9eBejbrFe2enBnLU0eyA6kvKe0R7C/ya40McxUUj2kLqrclCQmBE0p4mzt2PmY1n/9rzIqeMrnG5E1bTC/rP71tStSxtVJRpB21uUzG9RdE7PEKr6woT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784366970; c=relaxed/simple;
	bh=bqAVjvIOIEbCz7eSUYn/1GFTviCbwPu2UydSTbrW/M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIwzISrd5U+3xzLzdHlYjKPQNRSfWsozbnvm4DhvitYrsLNHpANksVNbD03R1dJQz/9vrbkcbOY0zz8KL8zllYooy7Y9Jwx+HBs+AIVjND+87ay6GwZRZrMY9DUsM2EgnmpYXPMQqUYlpR0cY3UFv7WGOBxqwrQzCzyX3JF/DKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5MPMJHZ; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5MPMJHZ"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so700661066b.1
        for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 02:29:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784366967; cv=none;
        d=google.com; s=arc-20260327;
        b=AITE7dpikgXQyLx/nvnppiOQoq6O5GsVySvsUZUXKTgqtdWoC4bhzNrAP3HgccCwNG
         ADFgFHbV0lg+SUx49IBKzpTXbQND9NRAKKoicT6fErdSVJa5BoV5mwwJSSQp6ikJSPff
         GYtqGVGE+Dm6oBAg/CNPDZad5sD8KGOMiME4Jd+EWwXu2e80KAnnhNJQl40i6FG2xSHM
         ntzVJ+4WwdKXdcSWO6spVVPInyOiXXYbKkEegX8yyFG9vcDEpOzRa7/m1mr5ms0KD5iG
         lhBEdOtj0zS+anQHVwT9bydYYRrXnQmSiRBMB5ScdXnBaKac/3u42tjMxgRrpz8SZsUD
         pNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XWU/6uAuD+n6JZz/CCPUCLX/l1MLCNr23fgGJNyzOmI=;
        fh=m7VR74eUURRG4a3kkxCpuPyIkXT0WZw+o1nhYgOzoVo=;
        b=G9N/W5pqMq4TR5jq5rdXqRtCcNCxMlcLpsosfw2vTUG+pVO4zGW2WKYp5yy/yTAQBF
         DJe0UuVYA5ZDoEK5Jp1JmRwisOPnv4SHlNA0KGIYSAotdcypV/CEVwmnZZlEZWIaFMwK
         sUBOgE/ZzC4tzvLyFsiFohgu2tKbk+Bl7MDOR/5jtKNckrEOhNIzES0KD2qH9X41qFbd
         9OjUelOZFVe5nrc3tIn5BkPYssLVc0DmTcggz37si3rkq8rL7WVev051v36hPLOizKwE
         O4yRhtk3iWEFbvhG67Q9YxDeBM7v3r4w/SeONBc6LxuQUBNKKo+xKaBpCYCF5eyzGSm0
         aehg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784366967; x=1784971767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XWU/6uAuD+n6JZz/CCPUCLX/l1MLCNr23fgGJNyzOmI=;
        b=Z5MPMJHZ9rxeUfQ+vFYDqdoixkSMcospZmkXoHX5pYF1ydE0yBhyJwmzjN0s5NzQTq
         QgnI42cavRVZalfpUu91XVRIQodiEQqlhI6ZNya1t3foY9XF+KpQ7gOECtd1zOk8wLxk
         mSdMHID8eHDqPK2B26BXsprAMIE/THiZFitxdU52G07OU1Sdv+o3Q5o+tK8Yb9dUqTV8
         Yf3v2lCBS+heNq1B/p+6BWCiSU/DZsxlYQ+6qygJGlSwsEPYqZLs6obl8zvaN1S1I86y
         JtX/NU5pdySQlHyuxCUXaVLOeMWCyxn2/+TeFV/UHD4+JAlOocledCGF4mNLKauwZmKg
         tIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784366967; x=1784971767;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XWU/6uAuD+n6JZz/CCPUCLX/l1MLCNr23fgGJNyzOmI=;
        b=BtjAgOHTHHTtVDWiVodigciQRFrdZP+kvrZSxBfBSDR8E85vglr6k8PvWANvkOiK3f
         wvISVHOxLEpNnn0J+1gH3h0amZMvYQuBftExHCiST+b8FAdWgMBYCJn7p/65b5oEtUbm
         jmA3gFFb7JjtD8vEpN4waMxdUp6YnjOCNB3+KGnYOVgGVEBdDErCmZw3b+QGCa6lpzOb
         tv1BQsUCf43ucB8TJoBvd7CtmqmpV/fnp+RWOqKvXg2Ad0zJIjPeMeDvlCyOSc9HAQ8m
         5nfUUdH/dwWvxfBunwW4sDKA6WyZhb6FkQjFxBIi0+4sh+X6JS0kKXtNtHWrVh6ZAVzE
         gO6g==
X-Gm-Message-State: AOJu0YzLHHYtL0ogu3RZxVh2WCbmcly97d1/go2EjU8FVz7dEwzag1sC
	FgntocMd0/3mYkEPg+kOQkksohvdDtv9mI2x1G7R5IhI9l0mTS9yvEYbWEI/oZSHFPzdVwH7Zu9
	seppG3fdhFAZPT2eRBUi/+EAuIFssArQ=
X-Gm-Gg: AfdE7cn4/QNjG6MtF9TwBP6tqmG8JYGrTfYtETvrqq920e5hDhpO6w002Zdr7SXQEue
	RbZLV4mU6w8lA2QMbHZP73RZRu4iziw/xtmK000NB9syf70eQ2RjXOPT9LUnGRh+OxpLreQOlL5
	oMXKehznYF3TfSge5VJBG3rVqQZdW7qUgYXFGL1K6zAeQiYUQwl7Fq26p0Y3L9MgkPLy1OQE2Po
	y5s0vL//lDX3/4nCunem1fNKXjmY90bTkk67TQhfKuGoVi+5T8r20KCvQetJJF8SgJAAVTIGdV8
	HAUFuwdNJ9wnvDlGBhgnkpvC3wKl
X-Received: by 2002:a17:907:3cc8:b0:c16:589d:c965 with SMTP id
 a640c23a62f3a-c16b487da50mr297105766b.46.1784366966767; Sat, 18 Jul 2026
 02:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716190204.100895-2-bestswngs@gmail.com> <20260716190204.100895-4-bestswngs@gmail.com>
 <GV1P189MB1988F91A48BC981B816C2700C6C62@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <CANgPUi1QTDP5Xo9LanuBEgzDREcxbAc6KE4Ltccoz_O6DF0=3Q@mail.gmail.com> <CANgPUi31G4DvrBPDRGniPDzWTUKo_3HQL8W1nq8BMmtnp8Fa+g@mail.gmail.com>
In-Reply-To: <CANgPUi31G4DvrBPDRGniPDzWTUKo_3HQL8W1nq8BMmtnp8Fa+g@mail.gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
Date: Sat, 18 Jul 2026 17:28:47 +0800
X-Gm-Features: AUfX_mzNb-5cOmwpRPR8e5f49Ku4mPCWomkzqHr4LTR2D0fWEsqmTTEMrVYRASo
Message-ID: <CANgPUi1hVNPTrH08XUTxxoSuC3oROz_SpZOga88X1ihoFzyE6Q@mail.gmail.com>
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
=A5=E5=91=A8=E5=85=AD 03:00=E5=86=99=E9=81=93=EF=BC=9A
>
> Weiming Shi <bestswngs@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=8818=E6=
=97=A5=E5=91=A8=E5=85=AD 02:34=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Tung Quang Nguyen <tung.quang.nguyen@est.tech> =E4=BA=8E2026=E5=B9=B47=
=E6=9C=8817=E6=97=A5=E5=91=A8=E4=BA=94 17:48=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > >Subject: [PATCH net v4 2/2] tipc: fix NULL deref in tipc_named_node_=
up() on
> > > >empty publication list
> > > >
> > > >named_distribute() ends by stamping the last_bulk flag on the tail s=
kb via
> > > >buf_msg(skb_peek_tail(list)). When the publication list is empty no =
skb is
> > > >enqueued, skb_peek_tail() returns NULL, and buf_msg(NULL) is derefer=
enced.
> > > >
> > > >tipc_named_node_up() runs this on &nt->cluster_scope. With a node-id
> > > >configuration cluster_scope is populated only later by tipc_net_fina=
lize(), so a
> > > >peer link that comes up first reaches named_distribute() with an emp=
ty list. It
> > > >is reachable by an unprivileged user (TIPC genl ops use
> > > >GENL_UNS_ADMIN_PERM) over a UDP bearer in a user+net namespace:
> > > >
> > > > KASAN: null-ptr-deref in range [0x00000000000000d8-0x00000000000000=
df]
> > > > RIP: 0010:tipc_named_node_up (net/tipc/name_distr.c:196)
> > > >  tipc_named_node_up (net/tipc/name_distr.c:196 net/tipc/name_distr.=
c:221)
> > > >  tipc_node_write_unlock (net/tipc/node.c:428)
> > > >  tipc_rcv (net/tipc/node.c:2185)
> > > >  tipc_udp_recv (net/tipc/udp_media.c:392)  Kernel panic - not synci=
ng: Fatal
> > > >exception in interrupt
> > > >
> > > >The peer holds back this node's later name updates until it sees a b=
ulk with the
> > > >last_bulk flag, so simply skipping the send would stall it. Emit an =
item-less bulk
> > > >when the publication list is empty, so the peer still receives the l=
ast_bulk flag
> > > >and opens.
> > > >
> > > >Fixes: cad2929dc432 ("tipc: update a binding service via broadcast")
> > > >Reported-by: Xiang Mei <xmei5@asu.edu>
> > > >Assisted-by: Claude:claude-opus-4-8
> > > >Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > > >---
> > > > net/tipc/name_distr.c | 14 ++++++++++++++
> > > > 1 file changed, 14 insertions(+)
> > > >
> > > >diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c index
> > > >ba4f4906e13b..a8bb7bd101ea 100644
> > > >--- a/net/tipc/name_distr.c
> > > >+++ b/net/tipc/name_distr.c
> > > >@@ -192,6 +192,20 @@ static void named_distribute(struct net *net, s=
truct
> > > >sk_buff_head *list,
> > > >               skb_trim(skb, INT_H_SIZE + (msg_dsz - msg_rem));
> > > >               __skb_queue_tail(list, skb);
> > > >       }
> > > >+
> > > >+      if (skb_queue_empty(list)) {
> > > >+              skb =3D named_prepare_buf(net, PUBLICATION, 0, dnode)=
;
> > > >+              if (!skb) {
> > > >+                      pr_warn("Bulk publication failure\n");
> > > >+                      return;
> > > >+              }
> > > >+              hdr =3D buf_msg(skb);
> > > >+              msg_set_bc_ack_invalid(hdr, true);
> > > >+              msg_set_bulk(hdr);
> > > >+              msg_set_non_legacy(hdr);
> > > >+              __skb_queue_tail(list, skb);
> > > >+      }
> > > As I explained before, this approach is wrong because
> > > 1. It does not handle memory allocation failure.
> > > 2. It breaks receiving peer by  sending non-data message to that peer=
 in case skb is not NULL.
> > >
> > > Could you please test below patch to see if it fixes the NULL derefer=
ence issue you reported ?
> >
> > Hi ,
> > Tested your patch, it fixes the NULL dereference I reported. No more
> > panic with an empty cluster_scope .
> >
> > One new bug found during testing: if tipc_nametbl_publish() fails in
> > tipc_net_finalize(), the node is
> > still marked finalized, so the deferred worker wakes up and calls
> > named_distribute() with an empty list,
> > hitting the same NULL dereference.
> >
> > I have the fix ready and sent it out:
> >
> > https://lore.kernel.org/all/20260717183047.2725959-1-bestswngs@gmail.co=
m/
> > https://lore.kernel.org/all/20260717183047.2725959-2-bestswngs@gmail.co=
m/
> > https://lore.kernel.org/all/20260717183047.2725959-3-bestswngs@gmail.co=
m/
> >
> > Thanks,
> > Weiming Shi
> >
>
> Hi,
> The v5 I sent earlier was incomplete. It only carried the two
> follow-up patches and depended on Tung's
> patch from this thread as its base, which made the series hard to
> apply on its own.
>
> I have resent the series as v6:
> https://lore.kernel.org/all/20260717185701.2828080-1-bestswngs@gmail.com/
>
> Sorry for the noise.

Sorry for the noise. This is the latest version, with some modifications ma=
de.

https://lore.kernel.org/all/20260718092544.785289-1-bestswngs@gmail.com/
> > >
> > > ---
> > >  net/tipc/core.c       |  1 +
> > >  net/tipc/core.h       |  2 ++
> > >  net/tipc/name_distr.c | 48 +++++++++++++++++++++++++++++++++++++++--=
--
> > >  net/tipc/name_distr.h |  3 ++-
> > >  net/tipc/net.c        |  2 ++
> > >  net/tipc/node.c       | 34 ++++++++++++++++++++++++++++--
> > >  6 files changed, 83 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/net/tipc/core.c b/net/tipc/core.c
> > > index 315975c3be81..9e81be4f01cf 100644
> > > --- a/net/tipc/core.c
> > > +++ b/net/tipc/core.c
> > > @@ -61,6 +61,7 @@ static int __net_init tipc_init_net(struct net *net=
)
> > >         tn->trial_addr =3D 0;
> > >         tn->addr_trial_end =3D 0;
> > >         tn->capabilities =3D TIPC_NODE_CAPABILITIES;
> > > +       atomic_set(&tn->finalized, 0);
> > >         INIT_WORK(&tn->work, tipc_net_finalize_work);
> > >         memset(tn->node_id, 0, sizeof(tn->node_id));
> > >         memset(tn->node_id_string, 0, sizeof(tn->node_id_string));
> > > diff --git a/net/tipc/core.h b/net/tipc/core.h
> > > index 9ce5f9ff6cc0..76768844c808 100644
> > > --- a/net/tipc/core.h
> > > +++ b/net/tipc/core.h
> > > @@ -145,6 +145,8 @@ struct tipc_net {
> > >         struct work_struct work;
> > >         /* The numbers of work queues in schedule */
> > >         atomic_t wq_count;
> > > +       /* flag to indicate work has finished */
> > > +       atomic_t finalized;
> > >  };
> > >
> > >  static inline struct tipc_net *tipc_net(struct net *net)
> > > diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> > > index ba5f4906e13b..8a1692dbd243 100644
> > > --- a/net/tipc/name_distr.c
> > > +++ b/net/tipc/name_distr.c
> > > @@ -147,7 +147,7 @@ struct sk_buff *tipc_named_withdraw(struct net *n=
et, struct publication *p)
> > >   * @pls: linked list of publication items to be packed into buffer c=
hain
> > >   * @seqno: sequence number for this message
> > >   */
> > > -static void named_distribute(struct net *net, struct sk_buff_head *l=
ist,
> > > +static int named_distribute(struct net *net, struct sk_buff_head *li=
st,
> > >                              u32 dnode, struct list_head *pls, u16 se=
qno)
> > >  {
> > >         struct publication *publ;
> > > @@ -164,8 +164,9 @@ static void named_distribute(struct net *net, str=
uct sk_buff_head *list,
> > >                         skb =3D named_prepare_buf(net, PUBLICATION, m=
sg_rem,
> > >                                                 dnode);
> > >                         if (!skb) {
> > > +                               __skb_queue_purge(list);
> > >                                 pr_warn("Bulk publication failure\n")=
;
> > > -                               return;
> > > +                               return 1;
> > >                         }
> > >                         hdr =3D buf_msg(skb);
> > >                         msg_set_bc_ack_invalid(hdr, true);
> > > @@ -195,6 +196,8 @@ static void named_distribute(struct net *net, str=
uct sk_buff_head *list,
> > >         hdr =3D buf_msg(skb_peek_tail(list));
> > >         msg_set_last_bulk(hdr);
> > >         msg_set_named_seqno(hdr, seqno);
> > > +
> > > +       return 0;
> > >  }
> > >
> > >  /**
> > > @@ -203,7 +206,7 @@ static void named_distribute(struct net *net, str=
uct sk_buff_head *list,
> > >   * @dnode: destination node
> > >   * @capabilities: peer node's capabilities
> > >   */
> > > -void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities=
)
> > > +int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
> > >  {
> > >         struct name_table *nt =3D tipc_name_table(net);
> > >         struct tipc_net *tn =3D tipc_net(net);
> > > @@ -218,9 +221,46 @@ void tipc_named_node_up(struct net *net, u32 dno=
de, u16 capabilities)
> > >         spin_unlock_bh(&tn->nametbl_lock);
> > >
> > >         read_lock_bh(&nt->cluster_scope_lock);
> > > -       named_distribute(net, &head, dnode, &nt->cluster_scope, seqno=
);
> > > +       /* tipc_net_finalize_work() has not finished inserting self a=
ddress to
> > > +         * name table yet.
> > > +         */
> > > +       if (unlikely(list_empty(&nt->cluster_scope))) {
> > > +               read_unlock_bh(&nt->cluster_scope_lock);
> > > +               return 1;
> > > +       }
> > > +
> > > +       if (named_distribute(net, &head, dnode, &nt->cluster_scope, s=
eqno)) {
> > > +               read_unlock_bh(&nt->cluster_scope_lock);
> > > +               return -ENOBUFS;
> > > +       }
> > > +
> > >         tipc_node_xmit(net, &head, dnode, 0);
> > >         read_unlock_bh(&nt->cluster_scope_lock);
> > > +       return 0;
> > > +}
> > > +
> > > +int tipc_named_dist_cluster_scope(struct net *net, u32 dnode)
> > > +{
> > > +       struct name_table *nt =3D tipc_name_table(net);
> > > +       struct tipc_net *tn =3D tipc_net(net);
> > > +       struct sk_buff_head head;
> > > +       u16 seqno;
> > > +
> > > +       __skb_queue_head_init(&head);
> > > +       wait_var_event(&tn->finalized, atomic_read(&tn->finalized));
> > > +       spin_lock_bh(&tn->nametbl_lock);
> > > +       seqno =3D nt->snd_nxt;
> > > +       spin_unlock_bh(&tn->nametbl_lock);
> > > +
> > > +       read_lock_bh(&nt->cluster_scope_lock);
> > > +       if (named_distribute(net, &head, dnode, &nt->cluster_scope, s=
eqno)) {
> > > +               read_unlock_bh(&nt->cluster_scope_lock);
> > > +               return -ENOBUFS;
> > > +       }
> > > +       tipc_node_xmit(net, &head, dnode, 0);
> > > +       read_unlock_bh(&nt->cluster_scope_lock);
> > > +
> > > +       return 0;
> > >  }
> > >
> > >  /**
> > > diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
> > > index c677f6f082df..cadf4e8c3e66 100644
> > > --- a/net/tipc/name_distr.h
> > > +++ b/net/tipc/name_distr.h
> > > @@ -69,7 +69,8 @@ struct distr_item {
> > >
> > >  struct sk_buff *tipc_named_publish(struct net *net, struct publicati=
on *publ);
> > >  struct sk_buff *tipc_named_withdraw(struct net *net, struct publicat=
ion *publ);
> > > -void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities=
);
> > > +int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)=
;
> > > +int tipc_named_dist_cluster_scope(struct net *net, u32 dnode);
> > >  void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
> > >                     u16 *rcv_nxt, bool *open);
> > >  void tipc_named_reinit(struct net *net);
> > > diff --git a/net/tipc/net.c b/net/tipc/net.c
> > > index 7e65d0b0c4a8..4c144e720ac1 100644
> > > --- a/net/tipc/net.c
> > > +++ b/net/tipc/net.c
> > > @@ -139,6 +139,8 @@ static void tipc_net_finalize(struct net *net, u3=
2 addr)
> > >         tipc_sk_reinit(net);
> > >         tipc_mon_reinit_self(net);
> > >         tipc_nametbl_publish(net, &ua, &sk, addr);
> > > +       atomic_inc(&tn->finalized);
> > > +       wake_up_var(&tn->finalized);
> > >  }
> > >
> > >  void tipc_net_finalize_work(struct work_struct *work)
> > > diff --git a/net/tipc/node.c b/net/tipc/node.c
> > > index 8e4ef2630ae4..c5b0a98324c3 100644
> > > --- a/net/tipc/node.c
> > > +++ b/net/tipc/node.c
> > > @@ -145,6 +145,8 @@ struct tipc_node {
> > >  #ifdef CONFIG_TIPC_CRYPTO
> > >         struct tipc_crypto *crypto_rx;
> > >  #endif
> > > +       /* Work item for bulk distribution of cluster scope publicati=
ons */
> > > +       struct work_struct work;
> > >  };
> > >
> > >  /* Node FSM states and events:
> > > @@ -303,6 +305,7 @@ static void tipc_node_free(struct rcu_head *rp)
> > >  #ifdef CONFIG_TIPC_CRYPTO
> > >         tipc_crypto_stop(&n->crypto_rx);
> > >  #endif
> > > +       cancel_work_sync(&n->work);
> > >         kfree(n);
> > >  }
> > >
> > > @@ -393,6 +396,19 @@ static void tipc_node_write_unlock_fast(struct t=
ipc_node *n)
> > >         write_unlock_bh(&n->lock);
> > >  }
> > >
> > > +static void tipc_node_dist_bulk(struct work_struct *work)
> > > +{
> > > +       struct tipc_node *node =3D container_of(work, struct tipc_nod=
e, work);
> > > +
> > > +       if (tipc_named_dist_cluster_scope(node->net, node->addr) < 0)=
 {
> > > +               u32 bearer_id =3D node->link_id & 0xffff;
> > > +
> > > +               tipc_node_link_down(node, bearer_id, false);
> > > +       }
> > > +
> > > +       tipc_node_put(node);
> > > +}
> > > +
> > > static void tipc_node_write_unlock(struct tipc_node *n)
> > >         __releases(n->lock)
> > >  {
> > > @@ -424,8 +440,21 @@ static void tipc_node_write_unlock(struct tipc_n=
ode *n)
> > >         if (flags & TIPC_NOTIFY_NODE_DOWN)
> > >                 tipc_publ_notify(net, publ_list, node, n->capabilitie=
s);
> > >
> > > -       if (flags & TIPC_NOTIFY_NODE_UP)
> > > -               tipc_named_node_up(net, node, n->capabilities);
> > > +       if (flags & TIPC_NOTIFY_NODE_UP) {
> > > +               int rc =3D 0;
> > > +
> > > +               rc =3D tipc_named_node_up(net, node, n->capabilities)=
;
> > > +               /* Defer bulk distribution to work queue */
> > > +               if (rc > 0) {
> > > +                       tipc_node_get(n);
> > > +                       schedule_work(&n->work);
> > > +               } else if (rc < 0) {
> > > +                       /* Bring the link down to start over bulk dis=
tribution
> > > +                        * when the link is up again.
> > > +                        */
> > > +                       tipc_node_link_down(n, bearer_id, false);
> > > +               }
> > > +       }
> > >
> > >         if (flags & TIPC_NOTIFY_LINK_UP) {
> > >                 tipc_mon_peer_up(net, node, bearer_id);
> > > @@ -564,6 +593,7 @@ struct tipc_node *tipc_node_create(struct net *ne=
t, u32 addr, u8 *peer_id,
> > >         INIT_LIST_HEAD(&n->list);
> > >         INIT_LIST_HEAD(&n->publ_list);
> > >         INIT_LIST_HEAD(&n->conn_sks);
> > > +       INIT_WORK(&n->work, tipc_node_dist_bulk);
> > >         skb_queue_head_init(&n->bc_entry.namedq);
> > >         skb_queue_head_init(&n->bc_entry.inputq1);
> > >         __skb_queue_head_init(&n->bc_entry.arrvq);
