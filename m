Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0EE48A2D7
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461881; cv=pass; b=sxw1QGBixhe7Kq1QTlys4QFYfNM0LMeD4Lv49MMsMBwLrXq88EhJuRlFcB7fx6vLQOBKYR8vS0uggRhY8ZqlupZPQjchul41JFT2GgqdIqprAbXD0HCOwWY+bqR+pghpBu23edYTf5tLu13UX8cY0Kz0VOskNsJRHv4POkeQuNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461881; c=relaxed/simple;
	bh=ynlE/SWWrcsYw4ABHbPbxqg7K6Zct9W6Wy47ALFH99U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2caAKBhkL41ppK4oJ1yFa2SIXBD4rZKQXP3ImjB6PeCMuiU2KXzWS8DjEyme+CKhZuinWTwQ9tK1E4tjUo8OTlSZ75bNby/3b8aNu9mAhOn82gmqri4IszoIe5kUiTmoaJ/I5vnV8hB0qNHLCTXJDOxCy0UniVASf3TWUv1too=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Z6hhbRpG; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Z6hhbRpG"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-868b3248b2cso2252534b3a.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 05:17:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791461879; cv=none;
        d=google.com; s=arc-20260327;
        b=ozFDl5WW2soB1orUm/sv4O9xqnhluL4kKfcWxhRIM708WTMFloZBU5gQk561lRiTbt
         DTKgHL0wp+8axevnAfrMledgRE8U2DfZfGylsgvY5bQe4ibL4murjsFPm3oP7VFDF0/Q
         i6ZccxtX6e0ltMritiARHhy/XcNXRvHiP2cpSTvoq9dGjNRDrxjbMEW4LGnfLmmuk9IU
         MB3RZR8g54uG6YOwkw5DFjW8vTtulXtxnNBkM3F0eVnAIthyKyD//7c12nTfDvUnVnMF
         qjWxgPJzAu8/LAo5j64bSvBbK3qNGBlS+nQjk+oMX0P08Vi/2MZqtE9RdPHJ4JuzM2mn
         jb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M2WT0JKZwEDOLnPzaszKYQRsSbuzXXJG5MpcBlmWQp8=;
        fh=/KNHanBKvb0UpdGuR+44c0O9Rlfl/GH50TXZciVvwTQ=;
        b=ZJyyKfIek/WftGVJii0sw132nyqnSRkBRq/6U3poVskerjovmbExpudfUylNoYuIat
         tkvVJ4FIkgBrIsjo6/iJUxKvdkv61VGtCzwhoiJBcJpVN9/1+7/ODRPOGRUnFe1g88hr
         gaRcjHW071jXNH5DQ4JBTEyJxdD4vivWMHaAAIXTs9nV2XKF8Rvm78RfRFSHtoPM08Bd
         JMAGjKC7GTXzK+D+V+yQv91IdPmGsFJO2TK0tI4ZDS3DIxcdEJUQU040XYKiuljRAYWz
         ENxzZC9OxQXOu11V24EsM+EkawGd5bNiUcpBZDUYi53hvz9QfRzg/JTeRmGOMYHxh/lZ
         +VfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791461879; x=1792066679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M2WT0JKZwEDOLnPzaszKYQRsSbuzXXJG5MpcBlmWQp8=;
        b=Z6hhbRpGyZqhOUyjKZQ3GdGPuvo4e0wG/Z9PPZCOEgZYJvv1d+72dV1UwT6upoNvRy
         vbQ398+1sQARzLefViL2C0Y8n8aLGM3x2AQ/G0g7xnMAvL5EewGde+ioBew+yyrAccfY
         5nTO/uKnYNXdohf0S2Xsq32qbfK7biQaeqYRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791461879; x=1792066679;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M2WT0JKZwEDOLnPzaszKYQRsSbuzXXJG5MpcBlmWQp8=;
        b=e+u/wYPBiga4EBLffPZpVa/oOCsgkVQ/q5rogza1Twh2jwYxDIqkXoMaSf7p33EGJy
         eNfyvKn2+YZ541kcBKDV7YKfvVTWHKyQNG5DQVX5csNsvxN1yutFrNPoiU+UFoRuSxn1
         eA4zLl1Yw4+neazRy7jWxHMYvN7FUxk7ty+T1bG1xP/Z1Zx976EyT5LsHXM8ms7nSXBG
         iYVOH0f4IatuCHe4K3bW12+8f1gdKkwD7FFjAVOSc7WOwOebXqg2ifxRekGBpX0WErO+
         nKL/128RNbX9yoLC5aX/4ZH/AbS5wCa+93Ian8edyDDixG/bx8c75YoUyldxACkHN05v
         2lRA==
X-Gm-Message-State: AFuF++kBHM0+YZCf8pE+AZPyATaYxbicNKEhzURxiliiVmP7c9RwHQQD
	fDvp2//gH0070EHJM9nvrDkVDJ1K7FnS8TqCXba6Xt9pwgekgVn3VU/XvoMvQ+LwM8tfL68c3/0
	PZKJcH/qcn5J7OYf7PvNA5TBGc3RI9826gJFC7hpV
X-Gm-Gg: AYBFou0BzWDGpb8mOYweM7O4cuYSmD7BAxT6H3+uED3dekewA3B1pouPspV9iUcjN2a
	HblCO7nqMep6oROlvzRrzEjWmttuifWIvRROFicyc4c7fjP+ss+hgNEXAH4W30CEUji586femiY
	Fmwu2VwVCPfCNXtKA2dhZINSxdD3CGFTOX0SwTGhnOIDdDqKysuthTyQJ8z9D7tTF83/0N0igJW
	kwyKjECqpMzQzpcr7+yNxCIrCMVdMXKM/sDM1EuLaMh6sbfFWQhGa/HDq/L9vyKY4RhayKF6YlT
	KSGDW2A/0Dg/sj6Xcg8QUyaPCHs24FRcvA3g0YXDFNXWQlOQc2JgiBSbrNz19Hq73r28q6VnIrk
	9aEcSCPsyB5aT26X+zh4qzNtwIHmQABFBNb42XI8=
X-Received: by 2002:a05:6a00:37c4:b0:892:597f:37d8 with SMTP id
 d2e1a72fcca58-892597f3814mr3610084b3a.15.1791461879228; Thu, 08 Oct 2026
 05:17:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <QDISC-BA27.v5.20261007171509@mojatatu.com> <87a4oottcj.fsf@toke.dk>
In-Reply-To: <87a4oottcj.fsf@toke.dk>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 8 Oct 2026 08:17:47 -0400
X-Gm-Features: AclHuK8XNtFRNjRvxFCSTrhybiQzTRjawx2i8ZtjcIlPD2lhimmqpObukZNvn8k
Message-ID: <CAM0EoMmYEr4DLrjuM5hdPR5Lf1c=mU6WNpYydbzkGnWjqFxMrw@mail.gmail.com>
Subject: Re: [PATCH net-next v5] net/sched: cap the accounted backlog before
 it can wrap
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Victor Nogueira <victor@mojatatu.com>, moeller0@gmx.de, cake@lists.bufferbloat.net, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 6:29=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@toke.dk> wrote:
>
> > This is a follow-up to an issue found by Sashiko (nipa) during review o=
f
> > commit d9ebd8f9aa8b ("net/sched: fq_codel: clamp default quantum and
> > mtu"), part of the quantum/mtu overflow series merged as a687f2ae995f.
> > Clamping the per-flow quantum and the CoDel mtu does not bound the
> > accounted backlog, so the per-flow backlog wrap the review flagged
> > remained.
>
> This, and the rest of the commit message is obtuse LLM vomit, and close
> to unreadable. Please rewrite the commit message without the verbosity,
> so it's actually something a human reader can comprehend. For the cake
> bits in particular:
>

Ok, but there is a dilemma: The verbosity is an attempt to appease the
sashikos. The other day it complained that i didnt have a space after
a semi colon.
The more stuff i add the less it slows me back. It picks on the
accuracy of the commit text _and changelogs_ and prescribes what i
said or should have said. I can understand a future AI review would
benefit from that; there are probably a few humans that read the
commit logs after the patch has gone in.
So:
I have been more targetting the AI more than humans in these comments.


> [..]
>
> > CAKE's SPLIT_GSO path accounts the sum of the segment lengths, which a
> > stab recomputes from skb->len and can exceed the pre-split
> > qdisc_pkt_len(). The list is summed before any segment is linked and
> > rejected as a whole before any flow state is resolved: the flow/host ke=
ys
> > are computed from the unsegmented packet, but the set-associative
> > resolution that commits q->tags[], the flow host indices, the way
> > counters and the host bulk-flow counts runs only after the whole
> > segment-sum admission test passes. A packet rejected by that test
> > therefore leaves no persistent state behind. The whole list is dropped
> > via to_free so the tail segment's sock_wfree() never runs under the qdi=
sc
> > lock. A fraglist GSO is the exception: skb_segment_list() returns the
> > original skb as the list head carrying an extra reference, so segs =3D=
=3D
> > skb; dropping the caller's reference and queueing the list once avoids
> > self-linking *to_free, which would otherwise free the same skb repeated=
ly
> > in the deferred teardown.
>
> I read this paragraph multiple times, and it's still not clear to me
> what it's trying to say.
>

In plain english, it says three things (applies to :
1) Splitting a GSO skb can account for more bytes than the original
packet, so we sum the whole segment list and test the total against
the ceiling before any segment is linked.
2) If it is over, we drop the entire list, and because no flow state
(tags, hash indices, counters) has been resolved yet, the reject
leaves nothing behind.
3) The fraglist sentence only picks which reference to drop for the
case skb_segment_list() returns the original skb, so the same skb is
not freed twice.

This text also applies to the codel piece.
Does re-writting as above sound better? I may please you but then
sashiko would ask me to change something in the wording ;->

> Also:
>
> >  net/sched/sch_cake.c      | 198 ++++++++++++++++++++++++++++----------
>
> You're changing hundreds of lines of code which is partly a refactor,
> partly a fix for the actual overflow issue, and partly unrelated
> changes. Please split them into separate patches.
>
> [..]
>
> > +/* Compute the flow/host hash keys from the packet as received. Must r=
un
> > + * before skb_gso_segment(), which rewrites an encapsulated GSO packet=
's
> > + * headers to the inner ones and would change the keys. Reads only the=
 skb
> > + * and commits no qdisc state, so it may run before admission is known=
.
> > + */
>
> And drop the weird LLM comments, please. If you split the series
> properly they are not needed.
>

Like I said, it's a dilemma.

> [..]
> > -             skb_list_walk_safe(segs, segs, nskb) {
> > -                     skb_mark_not_on_list(segs);
> > -                     qdisc_skb_cb(segs)->pkt_len =3D segs->len;
> > -                     qdisc_skb_cb(segs)->pkt_segs =3D 1;
> > -                     cobalt_set_enqueue_time(segs, now);
> > -                     get_cobalt_cb(segs)->adjusted_len =3D cake_overhe=
ad(q,
> > -                                                                      =
 segs);
> > -                     flow_queue_add(flow, segs);
> > +             skb_list_walk_safe(segs, seg, nskb) {
>
> The skb_list_walk_safe(segs, segs) thing is admittedly a bit weird, and
> fixing it is fine. But that's the "separate fix" I was referring to
> above, so split it out; it's just making the actual fix harder to
> comprehend here.


We have literally have about 100 followups to review from complaints
of "re-exsting issues" by sashikos and other ai officianados (there
are at least another 10 on cake) and the hard part is sifting through
and picking what is important enough to submit. And then deal with the
fallback from the sashikos turning transforming into bike-shedders.
I am trying to avoid sending many patches. But i could split this into:

- 0001 (prep, no behavior change): extract cake_tcf_classify() and the
fq_codel_classify() rewrite.
- 0002 (prep, no behavior change): skb_list_walk_safe(segs, seg) rename.
- 0003 (fix): the enqueue ceiling guard across fq_codel / codel / pie
/ fq_pie / dualpi2 / pfifo / RED / cake, plus the
qdisc_pkt_len_segs_init() producer clamp. pfifo stays here - RED reads
a grafted child's backlog, so it is the same overflow, not a separate
bug.
- 0004 (cake restructure): the cake_hash_keys() / cake_hash_resolve()
split and the split-GSO relocation.

Would that work?

cheers,
jamal
>
> pw-bot: cr
