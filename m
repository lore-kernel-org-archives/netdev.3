Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794153255;
	b=cnQQ29ysIwzdXcJ94SlT+RG5HFMPr6A6OO7Cnh8J9RYCiDlkriX6ck0hE3vL1RmMcrqP
	 NrwMHZj1skB9SrlSQ8wlOYPfi31FwqxKbggbw4TFx2fFGVBBn5nT2Lvw7L0EIavwLkCeo
	 xHqrU872PpDltvRcizWI/QwWFbaJc/KQC+42CiBuZUeKOiZX/jvMd67TNolvm7flSwf7K
	 qZgvRLd/LdCTi/7QX+y2UX+p63B7KUl2+eoduU4ZAKKheoHe7iCyXoaTmzsl5xHGjq5O1
	 HBFxXoTwhNUz6f3pS1hqUoAaOMTdRf7naqaO2MWpZKMQuL3KCiPaBC7xLP8Q2UCRQcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yZljxxtDfRO1wZbBPZeXprNl/Gb7QIZiIUyKm0qR9lw=;
	b=jNL4EiZhabWoMh8lkRIMVr2ii5I8nX1LRodO3sIB7dm+KsJjGkg17zdtp23ngR0RMyVy
	 Df2Cujjz6L/5HtYmbgFfWSKq5fRo6ZoxXOHFFd2jqxB8YgMhf9CIj3q4hGyMO6uv+cxMH
	 nvIFk9PnWGvpyH+FRWVqXnjH+PFhrXWrcVnIhJkmQ9kS1rspQildcI7zsC6jw1CofPNBZ
	 j22zWNHpd57dHiLzF12km5qL97G7XHAJFGRVIOkTweb7AuEiEvLwJPOGAC2P7Kmp6snjg
	 KPEboNP6d51nvhWL0G0FQP7EAA2e3sd4L4YNW0eJu7bPNMNf6DVTYxmL7tbwJzeS5AA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=copperfault.com;
	spf=pass smtp.mailfrom=copperfault.com;
	dkim=pass header.d=copperfault.com header.i=@copperfault.com header.a=rsa-sha256 header.s=google header.b=ufFwrB4u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F4606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 15:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B86F4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=copperfault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=copperfault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=copperfault.com header.i=@copperfault.com header.a=rsa-sha256 header.s=google header.b=ufFwrB4u
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso1602867b3.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 07:54:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794153253; cv=none;
        d=google.com; s=arc-20260327;
        b=AO9oS4QG+6IAtvPtsL2BCuvGAIirplPPv5ejasy1n1W1r//IkNML10FXMZV5LjXwuA
         UhNyhYUyWzpBSCdhSSW38DM8ed8yEqBC/nt50VPKqr0ZKiO9vTl2NBN75pWP9pck3Ktc
         o9Sa2HF37AXn+rwv6NWDLFnFpZd2NBc+Ge8Fv5yDTCaCd7CgrGPcmMog9TcjjRSk1i9r
         WcUEe7UuRf5Z1hBi2wUh6+otI9VKSbpvjVlibVRbXrUDDK0n88zcPyIKB5B5rCJkwDgw
         jYrBbuw7UhdOxD63OQJpzC5ynvGuBpAtRQZ3W4o1Y8E36727ucCwJeA69as6JNhZxuIw
         jcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yZljxxtDfRO1wZbBPZeXprNl/Gb7QIZiIUyKm0qR9lw=;
        fh=KDKUlulek0azZE0H932prUEFn0ugF8GfcaB90GetFIA=;
        b=gQInhL5zEFvNgNeTDuttoPEtzmPw3mlT0mSgEdvMBI6zLaYUylNmzxYsrZZ94CN2Ji
         pqJZmLp4eqd92VN09Sj61s0GQnCgpM0WjLC0+wx05sZK1iB4cSU4O1topKpR+0AkW1rw
         7PeU/q1SkV+tnDJQ0QQBjVadv9iZgQVr11cU1jfdZUD2/TmzDrjtxrT7MWTgN6gHoKuA
         jgDfbU41OHkvmbD48HMX3rDgZ6I/NYUhIYEpvBNpxt7+NVYIK95NiYuGuYK/viHAyVee
         N099kYiudu1ywrdwnMEmaj4dhgqzq5ryP1LZqkoxY3C9G/PlvETasb3FXKoPNXgBnMkP
         tJig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=copperfault.com; s=google; t=1794153253; x=1794758053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yZljxxtDfRO1wZbBPZeXprNl/Gb7QIZiIUyKm0qR9lw=;
        b=ufFwrB4u1T71wxTmgz6vvLW9sZIN0y4kxmo4MtQ8ZvD0+Fub7/DwprrslI3bZPmabq
         Kb8XGudO3JYK6WX4Vn96AqX8RV8hRis+CuDlfIpH+0TCAsXitwKTEkVDL/biz8YdRn0r
         aWIB1wg8D29XqnLrOWVatYz0+uNJjjoDVqLaaEBUkrZHrpK94zfsXFdYsniKvdP/Nh0h
         6L8VO1j93JqdUuwWM0kzg3JqdjNgEtnirSiNMstZo0KHt/exTudvJcv+5nloi5lNL9Uz
         6eodQA7WsjZVgLdmGkyfukWveIDyqaB0HZQKe+H/Du9kDz1/Mxvzun+E0kOIFwdBR4vl
         zV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794153253; x=1794758053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yZljxxtDfRO1wZbBPZeXprNl/Gb7QIZiIUyKm0qR9lw=;
        b=k9GYNyspfNRFGu9Bhzf2EDqzQxHpdClpnkb3e1s5Fpixux8BKTUiUTZbXv9GgZSlpi
         hKnOHEqC3XDmUoXr0t+RYi0L0jq/r47cp/9cMQl+Ns3IRuXh5Mz7DrfoNeIICxHd7Rix
         7Und6mVxm7XczmMVfe0qF1XvhmzcQD6/FYhx/Xhg9MUsgdaD6dimTxWv85bvHoOy1XGB
         PABEOem1Z7HIyX5TfizabuaOvk5C02NAQtWlIWh8sxiBkUkYHHdL8ne5Beter9S3eCXJ
         ySaLaoUCErUyrrrATUMfA0fVM+k5rzvqiphmBIE/6RrnzDmG0I+eeeaMM6PiqRqKF7x7
         VF2w==
X-Forwarded-Encrypted: i=1; AL+hErG9Wrm2xXUCtgcWC4J1V+nAnPF9Gzv11HN30uf5NdWiFxYTld9tHv13tiCJ2s5K6EV2EDQqWBM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qQ9+5g1ppZpVa6iaFQg9WTp2Hciqs4V46kZaTRud95wNLRoqJ
	+m9gEA3V/6mzABeLnTR7U/4vs60YYcA8UsjPLRUDOEinQ3hZFZkB1ae9yV4mUBIvQKMjIeJ0Wu8
	8/OiA0D6uTio+XEv6rVvz8rPQoOKjtoM9+AdjicRn+vU=
X-Gm-Gg: AYBFou0I1iZQx2LvOZXTvKMRGX8ltJ3MC0He0zMXVPNISc0hW0Gnd7f6epJLwNy6xuJ
	JFwNdF8jW2tFEInPUQi+YJkj6wt+eXYlTFULYK5YcrVeC857a74vOph/1BEqRExJhRGM+8B68Cf
	sTPzPLBdRWCVTvqdDiEw8GJN2o+WFRc2JhSOEWGRycmp6vf1/UqoSanCgtfhkw/khk2H/WBKLDm
	wYJ9INMAk5TmYCE8gMI3jr+bzMOZsJMjp/TCFZLdUdaOIltYopMapycVG0dD/CS7pNwE8FBp3LQ
	Z+IzgLy5j6iJtJ4UYOx5B1wJlEdYmFWwtBiJZ11/wt6BIiJTq1wL6h0xuxMeYWY/l6e02+4CGoX
	HgO2NCLdoKQlg3Aj/HYOCWwWTbcJ1B6yIsbIq
X-Received: by 2002:a05:690c:e3c6:b0:8b3:527b:d18f with SMTP id
 00721157ae682-8b36c9bbd42mr10048647b3.11.1794153253503; Sun, 08 Nov 2026
 07:54:13 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104135707.725-1-me@riley.kitchen> <179414983550.994134.16842767568883283385@kernel.org>
In-Reply-To: <179414983550.994134.16842767568883283385@kernel.org>
From: Copperfault Security <security@copperfault.com>
Date: Sun, 8 Nov 2026 07:54:01 -0800
X-Gm-Features: AclHuK_9bJGINzFJdLerSjL5er83bsXTWWAlDzCRIxIQrJWa0p2Yivf37KIlSW4
Message-ID: <CACZtLCt0VhHq+6gfd_iRoz5v=n4qQ-YJdZ6m67BWg-mPD7bRCQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: etf: propagate dequeue drops to parents
To: netdev-bot+sashiko@kernel.org
Cc: vinicius.gomes@intel.com, netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the review. I checked all four points against net (d8a4f4c59da5)
and they hold up; I'll respin.

- [Critical, HTB loop] Confirmed. Two sibling ETF leaves under HTB in the
  same row, one with only expired packets and one holding a single
  future-txtime packet: ETF's drop calls qdisc_tree_reduce_backlog() ->
  htb_qlen_notify() -> htb_deactivate(), which removes the class from the
  row while htb_dequeue_tree() is walking it. The class is dequeued via the
  skb =3D=3D NULL path, not the top "qlen =3D=3D 0" branch, so the
  "if (cl =3D=3D start) start =3D next" fixup never runs; 'start' is left p=
ointing
  at the removed class and "while (cl !=3D start)" never terminates. The si=
bling
  never empties (its packet is not yet eligible) and never yields a packet,=
 so
  the loop spins holding the root qdisc lock with BH disabled. That is wors=
e
  than the NULL deref this patch is trying to fix.

- [High, QFQ] Confirmed. In Root_QFQ -> Child_QFQ -> ETF, the notify fired
  from inside the child dequeue drives Child_QFQ's qlen to 0 (qfq_dequeue()
  has already done qdisc_qlen_dec() around the child dequeue) and deactivat=
es
  its class in Root_QFQ, so qfq_deactivate_agg() nulls q->in_serv_agg while
  Root_QFQ's qfq_dequeue() still holds the old in_serv_agg in a local. Root=
 is
  left with qlen =3D=3D 1 and no in-service aggregate, skips the "qlen =3D=
=3D 0" early
  return, and qfq_choose_next_agg() -> NULL -> qfq_peek_skb(NULL). The patc=
h
  moves the exact panic it fixes up one level rather than removing the clas=
s.

- [Medium, DRR/ETS/HFSC over QFQ] Confirmed. qfq_dequeue() lowers its own q=
len
  around the child dequeue, so reducing it by the full drop count underflow=
s to
  ~0U transiently; notify at the grandparent hop is then false and the stal=
e
  QFQ class is left on the grandparent's active list. The commit message's
  "classful ancestors see the removal" does not hold with QFQ in the middle=
.

- [Medium, taprio] Confirmed. taprio_graft() sets TCQ_F_NOPARENT on the chi=
ld
  in software and txtime-assist mode, so qdisc_tree_reduce_backlog() breaks=
 on
  the first hop and never reaches taprio. For the usual software-ETF parent=
 the
  patch is a no-op, and taprio's qlen/backlog still grow with every expired
  packet.

More broadly this is the same hazard that 52f1da34c9f4, 097f6fc7b1 and
15cd0c93bf ("net/sched: {codel,fq_codel,dualpi2}: Do not call
qdisc_tree_reduce_backlog during peek before restoring qlen", Jun 2026)
addressed: calling qdisc_tree_reduce_backlog() from a child's dequeue/peek =
can
deactivate the parent's class underneath the parent's own dequeue. ETF hits=
 it
deterministically because it empties via drops and returns NULL. A codel-st=
yle
"defer until the qlen is restored" is not enough here, since ETF returns NU=
LL
after dropping and the class is still deactivated mid-walk.

So I don't think ETF can safely propagate these drops inline. The original
qfq_peek_skb() NULL deref looks like it wants a parent-side fix - qfq_deque=
ue()
/ qfq_peek_skb() tolerating in_serv_agg becoming NULL during a child dequeu=
e -
and htb_dequeue_tree() has the same latent exposure to a class self-deactiv=
ating
mid-walk (the codel family can hit it too, just rarely). I'll rework in tha=
t
direction. If you'd prefer the fix live in the parents (qfq/htb) or be hand=
led a
different way in etf, I'm happy to follow your steer.

pw-bot: cr

On Sun, Nov 8, 2026 at 6:57=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 1 =C2=B7 High: 1 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Critical] This patch adds a call to qdisc_tree_reduce_backlog() inside
>   ETF's ->dequeue().
> - [High] net/sched: etf: timesortedlist_drop() corrupts parent
>   qfq_dequeue() state
> - [Medium] The fix does not reach taprio, which is the usual parent for
>   software-mode ETF, so taprio keeps counting packets that no longer=E2=
=80=A6
>
> Pre-existing issues:
> - [Medium] When QFQ sits between ETF and another classful qdisc (DRR, ETS
>   or HFSC above QFQ), the grandparent is never told that QFQ became=E2=80=
=A6
>
> --
>
> net/sched: etf: propagate dequeue drops to parents
>
> This patch makes timesortedlist_drop() count the expired packets and
> bytes it drops on ETF's dequeue path. It then calls
> qdisc_tree_reduce_backlog() so that classful parents update their qlen
> and backlog. The goal is to fix a NULL dereference in qfq_peek_skb() when
> ETF sits below QFQ.
>
> > diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
> > index aaafcf640bc7e..7e7532ea099eb 100644
> > --- a/net/sched/sch_etf.c
> > +++ b/net/sched/sch_etf.c
>
> [ ... ]
>
> > @@ -227,6 +230,7 @@ static void timesortedlist_drop(struct Qdisc *sch, =
struct sk_buff *skb,
> >       }
> >
> >       kfree_skb_list(to_free);
> > +     qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
> >  }
>
> [Severity: High]
> Does this fully close the qfq_peek_skb() NULL dereference, or does it
> only move it to other QFQ topologies? The new call runs from inside
> the parent's dequeue. qfq_dequeue() in net/sched/sch_qfq.c does not
> expect its own qlen and aggregate state to change underneath it.
>
> The first problem is that qfq_dequeue() lowers its qlen around the
> child dequeue:
>
>         qdisc_qlen_dec(sch);
>
>         skb =3D agg_dequeue(in_serv_agg, cl, len);
>
>         if (!skb) {
>                 qdisc_qlen_inc(sch);
>                 return NULL;
>         }
>
> Take Root_QFQ -> Child_QFQ -> ETF. ETF holds one expired packet and
> one packet whose txtime is in the future, so both QFQ instances have
> qlen =3D=3D 2. Root_QFQ peeks Child_QFQ through qdisc_peek_dequeued(),
> which runs qfq_dequeue() on Child_QFQ. etf_peek_timesortedlist()
> returns the expired head without looking at its txtime, so Child_QFQ
> sees len > 0 and continues:
>
> qfq_dequeue(Root_QFQ)
>   qfq_peek_skb()
>     qdisc_peek_dequeued(Child_QFQ)
>       qfq_dequeue(Child_QFQ)        /* Child qlen 2 -> 1 */
>         agg_dequeue()
>           etf_dequeue_timesortedlist()
>             timesortedlist_drop()
>               qdisc_tree_reduce_backlog()
>                                     /* Child qlen 1 -> 0 */
>                 qfq_qlen_notify()   /* deactivates Child's class */
>                                     /* Root qlen 2 -> 1 */
>       qdisc_qlen_inc()              /* Child qlen 0 -> 1 */
>
> Child_QFQ still holds the future packet. However, notify was computed
> from its temporarily lowered qlen, so Root_QFQ deactivated the class
> anyway, and qfq_deactivate_agg() set q->in_serv_agg to NULL. Root_QFQ
> is left with qlen =3D=3D 1 and no active aggregate.
>
> Back in Root_QFQ's qfq_dequeue(), len is 0 and the active list of the
> local in_serv_agg is empty. The "sch->q.qlen =3D=3D 0" early return is
> skipped, qfq_choose_next_agg() returns NULL, and qfq_peek_skb()
> dereferences it. That is the panic the commit message describes, one
> level further up.
>
> The reverse happens when the drops empty Child_QFQ. Its qlen wraps to
> 0xFFFFFFFF during the walk, so notify is false at the next level and
> the ancestor keeps an empty class active.
>
> The second problem is the local in_serv_agg in qfq_dequeue(). Take an
> intermediate qdisc that uses qdisc_peek_dequeued(), for example
> QFQ -> TBF -> ETF. There the drop happens during QFQ's own
> qfq_peek_skb() instead of inside agg_dequeue().
>
> Suppose that drop drains TBF and the in-service aggregate agg1.
> qfq_qlen_notify() then reaches qfq_deactivate_agg(), which already
> moves q->in_serv_agg to the next aggregate, agg2, through
> qfq_choose_next_agg(). qfq_dequeue() still has agg1 in its local
> variable. It sees len =3D=3D 0, an empty active list and a nonzero qlen,
> so it calls qfq_choose_next_agg() a second time. agg2 has already been
> removed from the schedule. Without a third aggregate this call returns
> NULL, and the next qfq_peek_skb() dereferences it.
>
> The same unprivileged user can build both topologies in its own
> namespaces, just like QFQ -> ETF. Should qfq_dequeue() be changed to
> cope with drops reported from inside a child's dequeue or peek? For
> example, it could lower qlen only after agg_dequeue() succeeds and
> reload q->in_serv_agg after qfq_peek_skb(). Or should ETF report these
> drops in a way that does not re-enter the parent while the parent is
> in the middle of its own dequeue?
>
> [Severity: Critical]
> This call now runs from inside ETF's ->dequeue(). If the drops leave ETF
> empty, the parent's qlen_notify runs while the parent is still inside its
> own dequeue. Can this make htb_dequeue_tree() in net/sched/sch_htb.c loop
> forever?
>
> Take two HTB leaf classes, A and B, in the same row (level 0, same prio,
> HTB_CAN_SEND). Each has an ETF child. All of A's packets have expired
> (delta=3D0 guarantees this). B holds one packet with a txtime far in the
> future. hprio->ptr points at A.
>
> htb_dequeue_tree() picks start once:
>
>         start =3D cl =3D htb_lookup_leaf(hprio, prio);
>
> A's qlen is nonzero, so the "fix start if we just deleted it" branch is
> skipped. HTB then calls A's dequeue:
>
> htb_dequeue_tree()
>   etf_dequeue_timesortedlist()
>     timesortedlist_drop()
>       qdisc_tree_reduce_backlog()      /* ETF qlen is 0, notify =3D true =
*/
>         htb_qlen_notify()
>           htb_deactivate()
>             htb_deactivate_prios()
>               htb_remove_class_from_row()   /* A is erased from the row *=
/
>
> ETF returns NULL. HTB advances ptr, and htb_lookup_leaf() returns B. B's
> ETF also returns NULL because its packet is not yet eligible. ptr then
> reaches NULL, and htb_lookup_leaf() goes back to the leftmost class, whic=
h
> is B again.
>
> A is no longer in the row, so this condition never becomes false:
>
>         } while (cl !=3D start);
>
> The loop holds the root qdisc lock with BH disabled. It only ends when B'=
s
> head packet becomes eligible, and is_packet_valid() puts no upper limit o=
n
> txtime.
>
> Before this patch, A stayed in the row during the walk. The loop went
> A -> B -> A =3D=3D start and exited.
>
> The commit message says an unprivileged user can put ETF under a classful
> parent inside its own namespaces. Doesn't that make this HTB lockup
> reachable in the same way as the QFQ NULL dereference being fixed?
>
> In principle, other children that notify from dequeue (the codel family)
> can hit the same HTB pattern. Codel rarely empties its queue through drop=
s,
> though, while ETF does so every time under these conditions.
>
> [Severity: Medium]
> This is a pre-existing issue and was not introduced by this patch. Does t=
he
> walk still miss the grandparent when QFQ is the intermediate qdisc, for
> example DRR -> QFQ -> ETF?
>
> qfq_dequeue() temporarily lowers its own qlen around the child dequeue:
>
>         qdisc_qlen_dec(sch);
>
>         skb =3D agg_dequeue(in_serv_agg, cl, len);
>
>         if (!skb) {
>                 qdisc_qlen_inc(sch);
>                 return NULL;
>         }
>
> Suppose ETF's expired packets are all of QFQ's backlog (QFQ qlen =3D=3D n=
).
> qdisc_tree_reduce_backlog() then notifies QFQ correctly and sets QFQ's ql=
en
> to (n - 1) - n =3D 0xFFFFFFFF. On the next hop it computes:
>
>         notify =3D !sch->q.qlen;
>
> which is false. The grandparent's qlen and backlog are reduced, but it ge=
ts
> no qlen_notify. After qfq_dequeue() puts QFQ's qlen back to 0, the
> grandparent still has the QFQ class on its active list.
>
> drr_dequeue() peeks the first active class and qfq_dequeue() returns NULL=
,
> so the code takes the goto out path:
>
>         skb =3D cl->qdisc->ops->peek(cl->qdisc);
>         if (skb =3D=3D NULL) {
>                 qdisc_warn_nonwc(__func__, cl->qdisc);
>                 goto out;
>         }
>
> The other DRR classes with queued packets then starve until new traffic
> reaches the QFQ class. ETS non-strict bands and HFSC appear to stall on t=
he
> stale class in the same way.
>
> ETF did not notify the grandparent before this patch either, so the
> behaviour is no worse. Does the statement "so classful ancestors see the
> removal" still hold when QFQ is in the middle?
>
> [Severity: Medium]
> Does this new call reach taprio, which is the usual parent for
> software-mode ETF?
>
> taprio_graft() always sets TCQ_F_NOPARENT on the child, including in
> software and txtime-assist mode:
>
>         new->flags |=3D TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
>
> In those modes, taprio_enqueue_one() increments taprio's own qlen and
> backlog. taprio_dequeue_from_txq() decrements them only when the child
> returns an skb:
>
>         skb =3D qdisc_dequeue_peeked(child);
>         if (unlikely(!skb))
>                 return NULL;
>
>         qdisc_bstats_update(sch, skb);
>         qdisc_qstats_backlog_dec(sch, skb);
>         qdisc_qlen_dec(sch);
>
> When timesortedlist_drop() runs under taprio, the new walk stops at once =
in
> qdisc_tree_reduce_backlog():
>
>         if (sch->flags & TCQ_F_NOPARENT)
>                 break;
>
> ETF then returns NULL, so taprio's sch->q.qlen and qstats.backlog grow wi=
th
> every expired packet. The visible result is wrong tc statistics, not a
> crash, because taprio does not use its qlen for scheduling.
>
> The commit message says a parent will no longer "keep accounting packets
> that no longer exist". Would taprio need a change too, such as not settin=
g
> TCQ_F_NOPARENT in software mode, or computing taprio's qlen from its
> children instead of keeping a separate count?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261104135707.725-1-me%40riley.kitchen
