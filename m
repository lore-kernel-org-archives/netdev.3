Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794155817;
	b=s3+agaSO8hyxdHGJxBQP7ph6A7KZ/43ACV2WswSfvXnLAE9ZtYxLFPc8HSpzPNsBt8uz
	 oVdyaGXeGp4xifMqtznw4dxIY5K2YxcsakiwlOizRDJQox/BReyIRrYxt9BwJv6bW3Kyb
	 7s16LQzS7AC8d10mLrJJuVUS+6oA1TzKzM9FcLKPiwAieRS8sDZs629M5wJA0qLP3yP5D
	 BuSSyArHroej0e1bnEtwDJPNeSc6vOoXowKakBSzzcKzOOmnkJFDrA0rO1013nE9H2O+Z
	 3J/vTQmVmnFtoZvv8hUMZgMc0LBxga5ZoCNKo4nLU5q4cWfdkuC90WluOvKC0rH5lvA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794155817;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XUDsqFBt9kYtJFsOROdmI+3zDRQUI+qCWiQ5KGdClLQ=;
	b=LtB9ADubUxm+ujBrOO1BXE2SBdXiofsR2OoUVct3gOOVm0jznmYzik9a6WzAdC980SXR
	 T2AsrsPaILwzFSyOvMHr8DaoNLp5itT5sAmdvepfRg4m+NHlDcBOqKRbBPhV+EH4FVt9C
	 3coZ0ALZv3BF+QqaHlSidl0wFFSJo2qelKPbj8zf7o+KZlDhbeoN9j1qLvz9zB+7DpajT
	 ipGTl1EAfrNAq2XyzKQX8bI5HdTRxWnGyc85Hr019tx5+nTZURsDLEh+C4KNwRJrLndUV
	 CROKd/44lqVmphImHic4ufS9y33fOxm2pxsriNjJEqAqNmESd585KVlTYTsIlNTliPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=copperfault.com;
	spf=pass smtp.mailfrom=copperfault.com;
	dkim=pass header.d=copperfault.com header.i=@copperfault.com header.a=rsa-sha256 header.s=google header.b=ZyRyXVI2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A1606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 16:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF2A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=copperfault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=copperfault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=copperfault.com header.i=@copperfault.com header.a=rsa-sha256 header.s=google header.b=ZyRyXVI2
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b360828905so1054367b3.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 08:36:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794155816; cv=none;
        d=google.com; s=arc-20260327;
        b=SuwiP+MOXB3TogzHTvFKnusX0EHdp851TLL9FbrDFyRjp6J1KvZAPFu6W9CrX+wR/j
         x+w22HZy3epyxns8iJcYvNQLNtlmCmZNW1aX5IPwPPTTRmnA8jtfu+HX36wuC0xL2W+A
         To9jH0/rqvhkOTUx0gFtn9Rm/Ig/Wa3NfulJxSlbMPe+ulGhk+SwzvY3n6tx1PR42Ulu
         vRj+UxA2q/wVfCBntgFWWBDLAgNFFcMwEgVOfmAwQ/eywoZmJUomfM+u7AvTtwafLAlJ
         Gcthy03xxsVXDJgVEMCDfRwsTR/9xNNm2Am276JyFiADVoe8MffVgeDHqEN7BT4VjGP1
         J11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XUDsqFBt9kYtJFsOROdmI+3zDRQUI+qCWiQ5KGdClLQ=;
        fh=l9EW6u9UgnXg2ZhmfU0oWS+xx92v+Z+nqlvASg0DsNg=;
        b=ltoyh6IU1RW4EnV/p1ffZq1aClD0tuYE4GfaGgnvFx+Za4/HPkxS5DX4rCvQfuIFif
         DbiuMH1GTIvkF7LWn6+qyHDk68RQLawLG7CYCahImh8+46WzAsXyFC2dHwnSyazHofTT
         oyxO46Fg2SNaN+H2YeDAuogmjNFD0U6K2scr4dxSYrCn2JP6zKVs2dPlkDY65TX/rIh9
         XUhfYPAEkZalEskFd50uroK9Uiay0SWT5Y0UHPJZVVZNj0yXldch1nPcVMVp2eC7fEsP
         vW6TFMpmt97W+jIkII4KesVr0RHTLVXG1DhGbo5H5iB3YsMHVZHAI1uA6A/gguZ/rtyD
         4XNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=copperfault.com; s=google; t=1794155816; x=1794760616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XUDsqFBt9kYtJFsOROdmI+3zDRQUI+qCWiQ5KGdClLQ=;
        b=ZyRyXVI2nyAauWjNHQu4hAPX0AGavbOIuafXPIwy73ONE5BADjgGhJdl8xYp3tVqYQ
         yT3Pdbgo6foikU88vA5wp5Qd/iOaPzIEzpiXVps3NG/CtBWDg6bPSaReWpELRlkzBvkX
         TI6cc6WSy0mBIDubdgbsj6Ruqe8LR1SruErg8d5aGc9J22Wh3jYs/sBltf37jG8eFktL
         hEpLNTcg3YRnUI0a5SR0xX8oc8azxlksXR32BiNVdBYqy0go5aXE5fq4fx6NzVJ0hJe0
         1sc9gxeXKH3RPinkCZ5QmfBJpgNJdD35GeRlEICNy3wOU9BcbYmt4Q1PuOFR5SCI9VPY
         FWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794155816; x=1794760616;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XUDsqFBt9kYtJFsOROdmI+3zDRQUI+qCWiQ5KGdClLQ=;
        b=m/3ABpDb/w5qYr1e/YTidlyR0Omdb7URdH0ryYnKIqKVSI3YxurUPl5s5xwHq3Nmw5
         Trw+940xQEqlQ9sZwHaXo1NboqukxGGqEaaY4AcnTG8RoadccXSV4SeIi7andaiHWYhq
         5BrTrEDKf/Uz/7pyOfelVg/ePcIs6LOF43lAvZVSqfwfARtiHfl8IMg0Fhg4o9+xRjds
         yhu1evAh/z1+yFvly5kCJBD1p4YVGGktgTMhr7NXUpj2iZfAmHK/XI6PpxWyIK90HyJG
         u/ELvkDaV1H2IzT0txGtE+9LAbz+YgGiXjvnBHuEgToi7kk0eOJ0Xp3MdEx84HQfS7j1
         WOUA==
X-Forwarded-Encrypted: i=1; AL+hErEGBIf/irkrJ49du5GR0hFDOcQMJpOurv7S6nVxARq4wwzXC/ugVlLEkQWJdaBuUWknH/bobjg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8YYz2lbAMYQQxZAY/FndRn5xxZkfMeG714Or5W0tcfO9JhZ4j2
	VRMwqDAnPgakSXgZ1jzSNfb1QD8KLukmn3rSWw9Uskoa3LOLmwFjqiwaLKOURDivvhM3//JmESO
	QVrHp28KdpULgBHiXCEeB72Om61kalnuDvztpYn5aIFM=
X-Gm-Gg: AYBFou1EWrfsce1PQPWOhNtJsABJ3RtxQDqp+v4coV78ZlFF6q55Ghq7DU1GBuigIEI
	JaxhK1e7IWV/N4ks4RemGSMC7HMte/0DxufTF2OqWCKqNg9AypcR607Ob5qcqfuZo+SUGOceopH
	PekBPy29LRj8KUcZslJ3eYAToQor3nzI7pmkbhNS9Nc3IR0uyhE5cQJT/onPAVMCC9ml2+aR5K8
	5HGc1DHnVkFSpeCQcR+a3iEau5Hps6ttMYpqHroUbLY2afZtsKWx0XwccebEzBZWEwNOEN8C41p
	I6zDrvRNbwkkPotHSCDbfuI2g0O3HqKNPZEvVELy/iM4Y7n6ngk2p34Xd62c0D3A/lGMku36E5v
	Ao39QIXOqfTeFmDkkH1EEoWbNWHa8tVVIMFfSM+QVxojp7GFGjRIVpPGqDg==
X-Received: by 2002:a05:690c:c50d:b0:8b0:adb0:b5ee with SMTP id
 00721157ae682-8b36ca78669mr9025067b3.63.1794155815470; Sun, 08 Nov 2026
 08:36:55 -0800 (PST)
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
 <CACZtLCt0VhHq+6gfd_iRoz5v=n4qQ-YJdZ6m67BWg-mPD7bRCQ@mail.gmail.com>
In-Reply-To: <CACZtLCt0VhHq+6gfd_iRoz5v=n4qQ-YJdZ6m67BWg-mPD7bRCQ@mail.gmail.com>
From: Copperfault Security <security@copperfault.com>
Date: Sun, 8 Nov 2026 08:36:42 -0800
X-Gm-Features: AclHuK8sYBSWlvXAd1mgp7Mt2MpnaOkhfM9OgVzV0X-WwEpPbO3g5TA6uPi2jEE
Message-ID: <CACZtLCvS+4sriwKNkQphhO4QGMX4bZZ_xQcbiTu-MgQ229txSQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: etf: propagate dequeue drops to parents
To: netdev-bot+sashiko@kernel.org
Cc: vinicius.gomes@intel.com, netdev@vger.kernel.org, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Following up on my last mail: after working through the parent-side fix, th=
e
right change turns out to be in qfq_dequeue() itself - guarding the case wh=
ere
qfq_choose_next_agg() returns NULL before qfq_peek_skb() - not anything in =
ETF.
Cong Wang has already posted exactly that patch ("net_sched: Check the retu=
rn
value of qfq_choose_next_agg()", Fixes: 462dbc9101ac, part of his netem
duplicate series), so the crash I was addressing from the ETF side is alrea=
dy
being handled in qfq where it belongs.

So please drop this ETF patch - I won't be resending it. The non-work-conse=
rving
behaviour the review noted is real, but ETF shouldn't paper over it by noti=
fying
parents from inside its dequeue; the qfq-side NULL check is the correct fix=
.

Thanks for the review.

pw-bot: reject

On Sun, Nov 8, 2026 at 7:54=E2=80=AFAM Copperfault Security
<security@copperfault.com> wrote:
>
> Thanks for the review. I checked all four points against net (d8a4f4c59da=
5)
> and they hold up; I'll respin.
>
> - [Critical, HTB loop] Confirmed. Two sibling ETF leaves under HTB in the
>   same row, one with only expired packets and one holding a single
>   future-txtime packet: ETF's drop calls qdisc_tree_reduce_backlog() ->
>   htb_qlen_notify() -> htb_deactivate(), which removes the class from the
>   row while htb_dequeue_tree() is walking it. The class is dequeued via t=
he
>   skb =3D=3D NULL path, not the top "qlen =3D=3D 0" branch, so the
>   "if (cl =3D=3D start) start =3D next" fixup never runs; 'start' is left=
 pointing
>   at the removed class and "while (cl !=3D start)" never terminates. The =
sibling
>   never empties (its packet is not yet eligible) and never yields a packe=
t, so
>   the loop spins holding the root qdisc lock with BH disabled. That is wo=
rse
>   than the NULL deref this patch is trying to fix.
>
> - [High, QFQ] Confirmed. In Root_QFQ -> Child_QFQ -> ETF, the notify fire=
d
>   from inside the child dequeue drives Child_QFQ's qlen to 0 (qfq_dequeue=
()
>   has already done qdisc_qlen_dec() around the child dequeue) and deactiv=
ates
>   its class in Root_QFQ, so qfq_deactivate_agg() nulls q->in_serv_agg whi=
le
>   Root_QFQ's qfq_dequeue() still holds the old in_serv_agg in a local. Ro=
ot is
>   left with qlen =3D=3D 1 and no in-service aggregate, skips the "qlen =
=3D=3D 0" early
>   return, and qfq_choose_next_agg() -> NULL -> qfq_peek_skb(NULL). The pa=
tch
>   moves the exact panic it fixes up one level rather than removing the cl=
ass.
>
> - [Medium, DRR/ETS/HFSC over QFQ] Confirmed. qfq_dequeue() lowers its own=
 qlen
>   around the child dequeue, so reducing it by the full drop count underfl=
ows to
>   ~0U transiently; notify at the grandparent hop is then false and the st=
ale
>   QFQ class is left on the grandparent's active list. The commit message'=
s
>   "classful ancestors see the removal" does not hold with QFQ in the midd=
le.
>
> - [Medium, taprio] Confirmed. taprio_graft() sets TCQ_F_NOPARENT on the c=
hild
>   in software and txtime-assist mode, so qdisc_tree_reduce_backlog() brea=
ks on
>   the first hop and never reaches taprio. For the usual software-ETF pare=
nt the
>   patch is a no-op, and taprio's qlen/backlog still grow with every expir=
ed
>   packet.
>
> More broadly this is the same hazard that 52f1da34c9f4, 097f6fc7b1 and
> 15cd0c93bf ("net/sched: {codel,fq_codel,dualpi2}: Do not call
> qdisc_tree_reduce_backlog during peek before restoring qlen", Jun 2026)
> addressed: calling qdisc_tree_reduce_backlog() from a child's dequeue/pee=
k can
> deactivate the parent's class underneath the parent's own dequeue. ETF hi=
ts it
> deterministically because it empties via drops and returns NULL. A codel-=
style
> "defer until the qlen is restored" is not enough here, since ETF returns =
NULL
> after dropping and the class is still deactivated mid-walk.
>
> So I don't think ETF can safely propagate these drops inline. The origina=
l
> qfq_peek_skb() NULL deref looks like it wants a parent-side fix - qfq_deq=
ueue()
> / qfq_peek_skb() tolerating in_serv_agg becoming NULL during a child dequ=
eue -
> and htb_dequeue_tree() has the same latent exposure to a class self-deact=
ivating
> mid-walk (the codel family can hit it too, just rarely). I'll rework in t=
hat
> direction. If you'd prefer the fix live in the parents (qfq/htb) or be ha=
ndled a
> different way in etf, I'm happy to follow your steer.
>
> pw-bot: cr
>
> On Sun, Nov 8, 2026 at 6:57=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
> >
> > Thank you for your contribution! Sashiko AI review found 3 potential
> > issue(s) to consider.
> >
> > Critical: 1 =C2=B7 High: 1 =C2=B7 Medium: 1 (1) =C2=B7 Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Critical] This patch adds a call to qdisc_tree_reduce_backlog() insi=
de
> >   ETF's ->dequeue().
> > - [High] net/sched: etf: timesortedlist_drop() corrupts parent
> >   qfq_dequeue() state
> > - [Medium] The fix does not reach taprio, which is the usual parent for
> >   software-mode ETF, so taprio keeps counting packets that no longer=E2=
=80=A6
> >
> > Pre-existing issues:
> > - [Medium] When QFQ sits between ETF and another classful qdisc (DRR, E=
TS
> >   or HFSC above QFQ), the grandparent is never told that QFQ became=E2=
=80=A6
> >
> > --
> >
> > net/sched: etf: propagate dequeue drops to parents
> >
> > This patch makes timesortedlist_drop() count the expired packets and
> > bytes it drops on ETF's dequeue path. It then calls
> > qdisc_tree_reduce_backlog() so that classful parents update their qlen
> > and backlog. The goal is to fix a NULL dereference in qfq_peek_skb() wh=
en
> > ETF sits below QFQ.
> >
> > > diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
> > > index aaafcf640bc7e..7e7532ea099eb 100644
> > > --- a/net/sched/sch_etf.c
> > > +++ b/net/sched/sch_etf.c
> >
> > [ ... ]
> >
> > > @@ -227,6 +230,7 @@ static void timesortedlist_drop(struct Qdisc *sch=
, struct sk_buff *skb,
> > >       }
> > >
> > >       kfree_skb_list(to_free);
> > > +     qdisc_tree_reduce_backlog(sch, dropped_pkts, dropped_bytes);
> > >  }
> >
> > [Severity: High]
> > Does this fully close the qfq_peek_skb() NULL dereference, or does it
> > only move it to other QFQ topologies? The new call runs from inside
> > the parent's dequeue. qfq_dequeue() in net/sched/sch_qfq.c does not
> > expect its own qlen and aggregate state to change underneath it.
> >
> > The first problem is that qfq_dequeue() lowers its qlen around the
> > child dequeue:
> >
> >         qdisc_qlen_dec(sch);
> >
> >         skb =3D agg_dequeue(in_serv_agg, cl, len);
> >
> >         if (!skb) {
> >                 qdisc_qlen_inc(sch);
> >                 return NULL;
> >         }
> >
> > Take Root_QFQ -> Child_QFQ -> ETF. ETF holds one expired packet and
> > one packet whose txtime is in the future, so both QFQ instances have
> > qlen =3D=3D 2. Root_QFQ peeks Child_QFQ through qdisc_peek_dequeued(),
> > which runs qfq_dequeue() on Child_QFQ. etf_peek_timesortedlist()
> > returns the expired head without looking at its txtime, so Child_QFQ
> > sees len > 0 and continues:
> >
> > qfq_dequeue(Root_QFQ)
> >   qfq_peek_skb()
> >     qdisc_peek_dequeued(Child_QFQ)
> >       qfq_dequeue(Child_QFQ)        /* Child qlen 2 -> 1 */
> >         agg_dequeue()
> >           etf_dequeue_timesortedlist()
> >             timesortedlist_drop()
> >               qdisc_tree_reduce_backlog()
> >                                     /* Child qlen 1 -> 0 */
> >                 qfq_qlen_notify()   /* deactivates Child's class */
> >                                     /* Root qlen 2 -> 1 */
> >       qdisc_qlen_inc()              /* Child qlen 0 -> 1 */
> >
> > Child_QFQ still holds the future packet. However, notify was computed
> > from its temporarily lowered qlen, so Root_QFQ deactivated the class
> > anyway, and qfq_deactivate_agg() set q->in_serv_agg to NULL. Root_QFQ
> > is left with qlen =3D=3D 1 and no active aggregate.
> >
> > Back in Root_QFQ's qfq_dequeue(), len is 0 and the active list of the
> > local in_serv_agg is empty. The "sch->q.qlen =3D=3D 0" early return is
> > skipped, qfq_choose_next_agg() returns NULL, and qfq_peek_skb()
> > dereferences it. That is the panic the commit message describes, one
> > level further up.
> >
> > The reverse happens when the drops empty Child_QFQ. Its qlen wraps to
> > 0xFFFFFFFF during the walk, so notify is false at the next level and
> > the ancestor keeps an empty class active.
> >
> > The second problem is the local in_serv_agg in qfq_dequeue(). Take an
> > intermediate qdisc that uses qdisc_peek_dequeued(), for example
> > QFQ -> TBF -> ETF. There the drop happens during QFQ's own
> > qfq_peek_skb() instead of inside agg_dequeue().
> >
> > Suppose that drop drains TBF and the in-service aggregate agg1.
> > qfq_qlen_notify() then reaches qfq_deactivate_agg(), which already
> > moves q->in_serv_agg to the next aggregate, agg2, through
> > qfq_choose_next_agg(). qfq_dequeue() still has agg1 in its local
> > variable. It sees len =3D=3D 0, an empty active list and a nonzero qlen=
,
> > so it calls qfq_choose_next_agg() a second time. agg2 has already been
> > removed from the schedule. Without a third aggregate this call returns
> > NULL, and the next qfq_peek_skb() dereferences it.
> >
> > The same unprivileged user can build both topologies in its own
> > namespaces, just like QFQ -> ETF. Should qfq_dequeue() be changed to
> > cope with drops reported from inside a child's dequeue or peek? For
> > example, it could lower qlen only after agg_dequeue() succeeds and
> > reload q->in_serv_agg after qfq_peek_skb(). Or should ETF report these
> > drops in a way that does not re-enter the parent while the parent is
> > in the middle of its own dequeue?
> >
> > [Severity: Critical]
> > This call now runs from inside ETF's ->dequeue(). If the drops leave ET=
F
> > empty, the parent's qlen_notify runs while the parent is still inside i=
ts
> > own dequeue. Can this make htb_dequeue_tree() in net/sched/sch_htb.c lo=
op
> > forever?
> >
> > Take two HTB leaf classes, A and B, in the same row (level 0, same prio=
,
> > HTB_CAN_SEND). Each has an ETF child. All of A's packets have expired
> > (delta=3D0 guarantees this). B holds one packet with a txtime far in th=
e
> > future. hprio->ptr points at A.
> >
> > htb_dequeue_tree() picks start once:
> >
> >         start =3D cl =3D htb_lookup_leaf(hprio, prio);
> >
> > A's qlen is nonzero, so the "fix start if we just deleted it" branch is
> > skipped. HTB then calls A's dequeue:
> >
> > htb_dequeue_tree()
> >   etf_dequeue_timesortedlist()
> >     timesortedlist_drop()
> >       qdisc_tree_reduce_backlog()      /* ETF qlen is 0, notify =3D tru=
e */
> >         htb_qlen_notify()
> >           htb_deactivate()
> >             htb_deactivate_prios()
> >               htb_remove_class_from_row()   /* A is erased from the row=
 */
> >
> > ETF returns NULL. HTB advances ptr, and htb_lookup_leaf() returns B. B'=
s
> > ETF also returns NULL because its packet is not yet eligible. ptr then
> > reaches NULL, and htb_lookup_leaf() goes back to the leftmost class, wh=
ich
> > is B again.
> >
> > A is no longer in the row, so this condition never becomes false:
> >
> >         } while (cl !=3D start);
> >
> > The loop holds the root qdisc lock with BH disabled. It only ends when =
B's
> > head packet becomes eligible, and is_packet_valid() puts no upper limit=
 on
> > txtime.
> >
> > Before this patch, A stayed in the row during the walk. The loop went
> > A -> B -> A =3D=3D start and exited.
> >
> > The commit message says an unprivileged user can put ETF under a classf=
ul
> > parent inside its own namespaces. Doesn't that make this HTB lockup
> > reachable in the same way as the QFQ NULL dereference being fixed?
> >
> > In principle, other children that notify from dequeue (the codel family=
)
> > can hit the same HTB pattern. Codel rarely empties its queue through dr=
ops,
> > though, while ETF does so every time under these conditions.
> >
> > [Severity: Medium]
> > This is a pre-existing issue and was not introduced by this patch. Does=
 the
> > walk still miss the grandparent when QFQ is the intermediate qdisc, for
> > example DRR -> QFQ -> ETF?
> >
> > qfq_dequeue() temporarily lowers its own qlen around the child dequeue:
> >
> >         qdisc_qlen_dec(sch);
> >
> >         skb =3D agg_dequeue(in_serv_agg, cl, len);
> >
> >         if (!skb) {
> >                 qdisc_qlen_inc(sch);
> >                 return NULL;
> >         }
> >
> > Suppose ETF's expired packets are all of QFQ's backlog (QFQ qlen =3D=3D=
 n).
> > qdisc_tree_reduce_backlog() then notifies QFQ correctly and sets QFQ's =
qlen
> > to (n - 1) - n =3D 0xFFFFFFFF. On the next hop it computes:
> >
> >         notify =3D !sch->q.qlen;
> >
> > which is false. The grandparent's qlen and backlog are reduced, but it =
gets
> > no qlen_notify. After qfq_dequeue() puts QFQ's qlen back to 0, the
> > grandparent still has the QFQ class on its active list.
> >
> > drr_dequeue() peeks the first active class and qfq_dequeue() returns NU=
LL,
> > so the code takes the goto out path:
> >
> >         skb =3D cl->qdisc->ops->peek(cl->qdisc);
> >         if (skb =3D=3D NULL) {
> >                 qdisc_warn_nonwc(__func__, cl->qdisc);
> >                 goto out;
> >         }
> >
> > The other DRR classes with queued packets then starve until new traffic
> > reaches the QFQ class. ETS non-strict bands and HFSC appear to stall on=
 the
> > stale class in the same way.
> >
> > ETF did not notify the grandparent before this patch either, so the
> > behaviour is no worse. Does the statement "so classful ancestors see th=
e
> > removal" still hold when QFQ is in the middle?
> >
> > [Severity: Medium]
> > Does this new call reach taprio, which is the usual parent for
> > software-mode ETF?
> >
> > taprio_graft() always sets TCQ_F_NOPARENT on the child, including in
> > software and txtime-assist mode:
> >
> >         new->flags |=3D TCQ_F_ONETXQUEUE | TCQ_F_NOPARENT;
> >
> > In those modes, taprio_enqueue_one() increments taprio's own qlen and
> > backlog. taprio_dequeue_from_txq() decrements them only when the child
> > returns an skb:
> >
> >         skb =3D qdisc_dequeue_peeked(child);
> >         if (unlikely(!skb))
> >                 return NULL;
> >
> >         qdisc_bstats_update(sch, skb);
> >         qdisc_qstats_backlog_dec(sch, skb);
> >         qdisc_qlen_dec(sch);
> >
> > When timesortedlist_drop() runs under taprio, the new walk stops at onc=
e in
> > qdisc_tree_reduce_backlog():
> >
> >         if (sch->flags & TCQ_F_NOPARENT)
> >                 break;
> >
> > ETF then returns NULL, so taprio's sch->q.qlen and qstats.backlog grow =
with
> > every expired packet. The visible result is wrong tc statistics, not a
> > crash, because taprio does not use its qlen for scheduling.
> >
> > The commit message says a parent will no longer "keep accounting packet=
s
> > that no longer exist". Would taprio need a change too, such as not sett=
ing
> > TCQ_F_NOPARENT in software mode, or computing taprio's qlen from its
> > children instead of keeping a separate count?
> >
> > --
> > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20261104135707.725-1-me%40riley.kitchen
