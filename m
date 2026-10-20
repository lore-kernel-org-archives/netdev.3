Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518332;
	b=IabxyzaMgt/9QiY3HePeCcz967Kl+mohuKPdCNA/wMQWveSQl0snsl0Y6gdk7kfPpm1B
	 mEOmr1Bvn9tQaHAVsnJ3VA49Lvq3K85QCttzRQUTBD7zumJeQG4jlE/gVe2z5EUp8EsFm
	 6+iJe5yQo5n0QJK8fku5/RKv7YhQzh2Al6rZhegqU9ExhZ0y3XVoaKIoy25BEGopWcL0t
	 4btjqGlbXjLEt6rE3wpdP2QKUyuBsg8VLHShWtf3H+Lfaz8slwohf3FegaV2g8z5WBxc9
	 wHQ3/RSUpUoMuQb1x5A3zu4PhSH4OhaGGaczyEMVSY+xXdPhdTzwgd6g0uF9KgRGn8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518332;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cyKu2JIBSJUnhgMWBwDQKpk8fK4vwAgYU+eQK8Lufxc=;
	b=fBgNJ2bwWfa5YS2sLY5mssTVW2H4Iwix5F7UweIiWBSkFOA+Us/WPExIvJHF+HUu0ZM4
	 /TWwxE9hc9B5XZu80xpkTjeA33HFTXMW2llL9pNDd1rzX03WNJNJSNOxy/tnZ6jY09FtS
	 VQLuqsYCorTRH7CScXpdRcJkAHjVH0MOzPXetzULtUb99WOnPghzP9X92xxedqW96RDvK
	 GjMq9Lu3VZ1sd9RPz5u8PnFnr7FyrdjDvWfmHh/JJ6dvrWvuTUwrUtvaZaPKsOoseSJq9
	 F0YVL1hYmKBW+dfoA6cMwnX68PWOfy/LhwhKsh3aHFcXcFx+ZebhnuyowJ1nr79PlBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2D606A329
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 17:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FA2D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v8 1/4] net/sched: cake: return the classifier
 result to the caller
In-Reply-To: <QDISC-BA27.v8.r0.20261020063241-1@mojatatu.com>
References: <QDISC-BA27.v8.r0.20261020063241@mojatatu.com>
 <QDISC-BA27.v8.r0.20261020063241-1@mojatatu.com>
Date: Tue, 20 Oct 2026 19:45:29 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87cxt4tgee.fsf@toke.dk>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> The Fix:
> cake runs an optional external classifier from its enqueue path and then
> computes the flow hash inside the helper. Have the helper return the
> filter's overrides instead, so the caller owns the flow selection.
>
> This is preparation for the accounting changes that follow. Packet
> classification and flow selection are unchanged.
>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

One nit below, in case you need to respin for other reasons; but I guess
I can live with it as-is, so:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>


> ---
>
> v7 -> v8: cake-only.  fq_codel_classify() is line-for-line the same as
> fq_pie_classify() and fq_pie is not changed by this series, so fq_codel
> keeps its original classify shape; the fq_codel backlog guard is placed
> inline in sch_fq_codel.c in 0003 instead.  (Toke H=C3=B8iland-J=C3=B8rgen=
sen, v7
> review)
> ---
>  net/sched/sch_cake.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dc93267029e7..6432d10c992e 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1712,18 +1712,24 @@ static struct cake_tin_data *cake_select_tin(stru=
ct Qdisc *sch,
>  	return &qd->tins[tin];
>  }
>=20=20
> -static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
> -			 struct sk_buff *skb, int flow_mode, int *qerr)
> +/* Run the qdisc's optional external classifier. Returns true when a
> + * terminal TC action consumed the packet, with the reason in *qerr;
> + * otherwise *flow and *host hold the filter's overrides (0 if none).
> + */

nit: I still think this comment is superfluous and should just be removed :/

> +static bool cake_tcf_classify(struct Qdisc *sch, struct sk_buff *skb,
> +			      u16 *flow, u16 *host, int *qerr)
>  {
>  	struct cake_sched_data *q =3D qdisc_priv(sch);
>  	struct tcf_proto *filter;
>  	struct tcf_result res;
> -	u16 flow =3D 0, host =3D 0;
>  	int result;
>=20=20
> +	*flow =3D 0;
> +	*host =3D 0;
> +
>  	filter =3D rcu_dereference_bh(q->filter_list);
>  	if (!filter)
> -		goto hash;
> +		return false;
>=20=20
>  	*qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
>  	result =3D tcf_classify_qdisc(skb, filter, &res, false);
> @@ -1737,17 +1743,15 @@ static u32 cake_classify(struct Qdisc *sch, struc=
t cake_tin_data **t,
>  			*qerr =3D NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
>  			fallthrough;
>  		case TC_ACT_SHOT:
> -			return 0;
> +			return true;
>  		}
>  #endif
>  		if (TC_H_MIN(res.classid) <=3D CAKE_QUEUES)
> -			flow =3D TC_H_MIN(res.classid);
> +			*flow =3D TC_H_MIN(res.classid);
>  		if (TC_H_MAJ(res.classid) <=3D (CAKE_QUEUES << 16))
> -			host =3D TC_H_MAJ(res.classid) >> 16;
> +			*host =3D TC_H_MAJ(res.classid) >> 16;
>  	}
> -hash:
> -	*t =3D cake_select_tin(sch, skb);
> -	return cake_hash(*t, skb, flow_mode, flow, host) + 1;
> +	return false;
>  }
>=20=20
>  static void cake_reconfigure(struct Qdisc *sch);
> @@ -1758,20 +1762,25 @@ static s32 cake_enqueue(struct sk_buff *skb, stru=
ct Qdisc *sch,
>  	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
>  	struct cake_sched_data *q =3D qdisc_priv(sch);
>  	int len =3D qdisc_pkt_len(skb), ret;
> +	u16 flow_override, host_override;
>  	struct sk_buff *ack =3D NULL;
>  	ktime_t now =3D ktime_get();
>  	struct cake_tin_data *b;
>  	struct cake_flow *flow;
>  	bool same_flow =3D false;
>=20=20
> -	/* choose flow to insert into */
> -	idx =3D cake_classify(sch, &b, skb, q->config->flow_mode, &ret);
> -	if (idx =3D=3D 0) {
> +	/* Classify first: a terminal TC action consumes the packet. */
> +	if (cake_tcf_classify(sch, skb, &flow_override, &host_override, &ret)) {
>  		if (ret & __NET_XMIT_BYPASS)
>  			qdisc_qstats_drop(sch);
>  		__qdisc_drop(skb, to_free);
>  		return ret;
>  	}
> +
> +	/* choose flow to insert into */
> +	b =3D cake_select_tin(sch, skb);
> +	idx =3D cake_hash(b, skb, q->config->flow_mode, flow_override,
> +			host_override) + 1;
>  	tin =3D (u32)(b - q->tins);
>  	idx--;
>  	flow =3D &b->flows[idx];
> --=20
> 2.43.0
