Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FC23542D1
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777232598; cv=none; b=AMYJc2DriEgjeeOaugZyRG6Ez9pHYjxDXCnm0Z8StDaTqrK904UzsYDFR+/KEZkgtQwJ9yTq1GSEg1Xs+WX8HxOtuvpFqFKIfjIur84wk7IG2QMvCU+XYchFkI0T+p/UKbzR5+Y7sx/nvTY+5JumLeTCNhombLs6nkMhALS/dYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777232598; c=relaxed/simple;
	bh=T+mxDie/2SaX4jvh8Isd+njvb/CGPq8D3xjqupQ/GZo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8peLu7cHd0vEoNVxSKl6SlQOazDjt22NY5rK+Ph275K3Xeh5Zya+BaH1tBpEiwKku798jkXr1W/zOTRoqMNt3gRE/S0Xj5RwzCuVkKWu55KDD6+q969IlpuDBw43j2DzHX7/dtQ7XUDzI1pou8pu40xMNlIKps9sl4sYq0gohU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=Y7FKMqpY; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="Y7FKMqpY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail3; t=1777232585; x=1777491785;
	bh=/2XKW15+uCUqJELfllQEweH+U+U6x7xmYmX7tfUzQNo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Y7FKMqpY5Aa0WeANoB+kV08PZhAUohAjDq884xAkOEBQfjxA2CUHE1/3J0daVllPT
	 1dVYCw9CCagLt4o82WXp3p7UruRU4QjiD6ol8KcHZwwNhC+zAMo5meSvKD56CySjWq
	 KqugM1g0w4BpOftP7HgiuD4yFcjbNBADRRZYEJ7YQsigbQncLrQ5fhqF/3zuDnkYr+
	 NpHbazKaTfz87VUC/n3TP59h5hmUWoeA5VcXr8h+QmH66/Odb2YDhdwSHfooXYSTrM
	 63xy377MyQzkKU2tJ77WFvwFhARMMe5hNGqggOqsExlkbbS8hV49sih636D36C7kgm
	 P2ZgK0cxhTatQ==
Date: Sun, 26 Apr 2026 19:43:00 +0000
To: Jamal Hadi Salim <jhs@mojatatu.com>
From: William Liu <will@willsroot.io>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, stephen@networkplumber.org, victor@mojatatu.com, savy@syst3mfailure.io, xmei5@asu.edu, pctammela@mojatatu.com, kuniyu@google.com, toke@toke.dk, willemdebruijnkernel@gmail.com, hxzene@gmail.com
Subject: Re: [PATCH net 4/9] net/sched: fix packet loop on netem when duplicate is on
Message-ID: <PUHC-453MlMVz98UOKJL9XQn9lt4GvN3H9GJ3nR0VnwJmZEHpNuGqUND6bAfANVEu_58JuuVIzlpcrOZWV3WdhNUgKnpjo_lldrBB4dpEdw=@willsroot.io>
In-Reply-To: <20260426190916.128489-5-jhs@mojatatu.com>
References: <20260426190916.128489-1-jhs@mojatatu.com> <20260426190916.128489-5-jhs@mojatatu.com>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 6a0085da8496bdbe459beef0124fbca6c5edb1f3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: William Liu <will@willsroot.io>

On Sunday, April 26th, 2026 at 7:09 PM, Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:

> When netem duplicates a packet it re-enqueues the copy at the root qdisc.
> If another netem sits in the tree the copy can be duplicated
> again, recursing until the stack or memory is exhausted.
>=20
> The original duplication guard temporarily zeroed q->duplicate around
> the re-enqueue, but that does not cover all cases because it is
> per-qdisc state shared across all concurrent enqueue paths
> and is not safe without additional locking.
>=20
> Use the skb tc_depth field introduced in an earlier patch:
>  - increment it on the duplicate before re-enqueue
>  - skip duplication for any skb whose tc_depth is already non-zero.
>=20
> This marks the packet itself rather than mutating qdisc state,
> therefore it is safe regardless of tree topology or concurrency.
>=20
> Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
> Reported-by: William Liu <will@willsroot.io>
> Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
> Closes: https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc=
1ilxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=
=3D@willsroot.io/
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  net/sched/sch_netem.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
> index 8c6dea196089..d595eb03dca8 100644
> --- a/net/sched/sch_netem.c
> +++ b/net/sched/sch_netem.c
> @@ -461,7 +461,8 @@ static int netem_enqueue(struct sk_buff *skb, struct =
Qdisc *sch,
>  =09skb->prev =3D NULL;
>=20
>  =09/* Random duplication */
> -=09if (q->duplicate && q->duplicate >=3D get_crandom(&q->dup_cor, &q->pr=
ng))
> +=09if (q->duplicate && skb->tc_depth =3D=3D 0 &&
> +=09    q->duplicate >=3D get_crandom(&q->dup_cor, &q->prng))
>  =09=09++count;
>=20
>  =09/* Drop packet? */
> @@ -540,11 +541,9 @@ static int netem_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>  =09 */
>  =09if (skb2) {
>  =09=09struct Qdisc *rootq =3D qdisc_root_bh(sch);
> -=09=09u32 dupsave =3D q->duplicate; /* prevent duplicating a dup... */
>=20
> -=09=09q->duplicate =3D 0;
> +=09=09skb2->tc_depth++; /* prevent duplicating a dup... */
>  =09=09rootq->enqueue(skb2, rootq, to_free);
> -=09=09q->duplicate =3D dupsave;
>  =09=09skb2 =3D NULL;
>  =09}
>=20
> --
> 2.34.1
>=20
> 
