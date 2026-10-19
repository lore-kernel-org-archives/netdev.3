Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7653F211A
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415245; cv=none; b=aSt9GZ9XZlpB2NUzZKojdOqVeiUQn/vpMEUo+Npie28V4h1Sqaz+sORxK2YXK0x73LS7TnZM3PupKfV67rV/ThCi0l3dxL/hEl02pPfeZ7LznvoKKzYpwj/1/HR2ovz1tBYm6fSqxtxxPIgzNl7SpHbEDGWqX4Vw3OYe21Nf+dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415245; c=relaxed/simple;
	bh=girE4eB9jc+UMlprl9avn4w2td3J0bcuABlQ1YcSCAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Oq9ehbjdqAPKmT7x7ExyA4+Ermcpt+gWVo43Z9w89QL03aVEERPjvB2LjBSu13HaSB+KTbsf/KRvOjeWmsZ700DOO2H32iElZWISv1tBODzf2MIUOhAqC46rKRiqjGb/Njx1lrzKDfM2pl0g5YTKGaFztUo2Gd3J+aokJFTv7Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NE+LqfSp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NE+LqfSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36E21F000C4;
	Mon, 19 Oct 2026 13:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415244;
	bh=zOZ/+u7vpmO0B2bFLnoT2X1xYfa0Bwt6zvCREsn7wCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NE+LqfSpKiif9lz8yshJHciN3IvqkNplfNYZc0Q8sO1T6emgH+4lerxtV5qNS+5WL
	 9SZRNDGNHOq9MI1cEXM+1YrIBXjKyBIco8pZuCpDS9Frzg97+YvnxS9CwKgbY9FumR
	 +1+5u7oJeGqs2sdL2dFcCHH3JgeQxC2CT56U5Mir2gJ+n4KbroEvMqYQcByiCte9cV
	 kZfu99PQvQ4gynadNHrBQIeygzxwNshUbvxDDrMld4Z1bNvqEkvZ5DsZF7gf76QERY
	 03DlPeZtybNUsHItdfzuEJdmT3oUOpWPZanPGtpqeRdf96Erqhf4A8kNDkuWqWpuNH
	 PQHt74EfvcAcg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen?=
 <toke@toke.dk>, Jiri Pirko <jiri@resnulli.us>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, cake@lists.bufferbloat.net, Victor Nogueira
 <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v2 1/4] net/sched/sch_cake: serialize
 reconfiguration with the datapath
In-Reply-To: <QDISC-5RTM.v2.r0.20261015051735-1@mojatatu.com>
References: <QDISC-5RTM.v2.r0.20261015051735@mojatatu.com>
 <QDISC-5RTM.v2.r0.20261015051735-1@mojatatu.com>
Date: Mon, 19 Oct 2026 15:07:20 +0200
Message-ID: <87ld7t3kl3.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> This is a follow-up to commit 7cbfb180945c ("net/sched: sch_cake: fix
> autorate reconfiguration throttling").  That change only stored
> last_reconfig_time; it did not address the concurrency between the
> autorate rate update in cake_enqueue() and the netlink reconfiguration
> path, which the original review flagged.
>
> The issue:
>
> cake_change() -> cake_config_change() updates the fields of the shared
> struct cake_sched_config under RTNL but not under the qdisc lock: it only
> took sch_tree_lock() later, around cake_reconfigure().  The datapath in
> turn serializes cake_enqueue() with itself under the qdisc lock, and its
> autorate-ingress path stores the estimated rate into
> q->config->rate_bps.  Two writers therefore update the same rate with no
> common lock:
>
>   CPU0: cake_enqueue() sees CAKE_FLAG_AUTORATE_INGRESS, computes an
>         estimate, and is about to store it.
>   CPU1: 'tc qdisc change ... bandwidth X' clears autorate in its local
>         rate_flags, writes rate_bps =3D X, publishes the cleared flag, and
>         waits in sch_tree_lock().
>   CPU0: stores the estimate, calls cake_reconfigure(), and unlocks.
>   CPU1: reconfigures from the estimate and returns.
>
> The qdisc is left with autorate disabled but with the estimate installed
> instead of X.
>
> The fix:
>
> Commit the parsed configuration and reconfigure while holding the same
> qdisc lock that serializes the datapath, so the netlink writer and the
> autorate writer can no longer interleave.  rate_bps needs no atomic: it is
> only ever loaded and stored, so plain READ_ONCE()/WRITE_ONCE() annotations
> cover the readers that run outside the lock (cake_config_dump(), which is
> not serialized, and the cake_mq shared config, observed under different
> child locks).
>
> Conditions to recreate the bug: build with CONFIG_KCSAN=3Dy.  Two distinct
> effects are reachable.  (a) The lost update of the installed rate is
> reproducible without a sanitizer: put cake in autorate-ingress on a
> device, drive bursty traffic with gaps so the 250ms autorate
> reconfiguration fires, and concurrently loop 'tc qdisc change dev ...
> cake bandwidth <N>kbit autorate-ingress', then read the installed rate
> back and observe the estimate instead of the configured rate.  (b) The
> non-atomic 64-bit store that KCSAN reports needs a 32-bit machine, where
> the torn store of rate_bps is observable; on 64-bit the value is written
> atomically and KCSAN flags only the unsynchronized access.
>
> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260816012109.2865223-1-ooonea@gmai=
l.com
> Link: https://lore.kernel.org/netdev/20260816012109.2865223-1-ooonea@gmai=
l.com/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_cake.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dc93267029e7..a05da73b5f84 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1906,7 +1906,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
>  			if (ktime_after(now,
>  					ktime_add_ms(q->last_reconfig_time,
>  						     250))) {
> -				q->config->rate_bps =3D (q->avg_peak_bandwidth * 15) >> 4;
> +				WRITE_ONCE(q->config->rate_bps,
> +					   (q->avg_peak_bandwidth * 15) >> 4);
>  				q->last_reconfig_time =3D now;
>  				cake_reconfigure(sch);
>  			}
> @@ -2021,7 +2022,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
>  	    now - q->last_checked_active >=3D q->config->sync_time) {
>  		struct net_device *dev =3D qdisc_dev(sch);
>  		struct cake_sched_data *other_priv;
> -		u64 new_rate =3D q->config->rate_bps;
> +		u64 new_rate =3D READ_ONCE(q->config->rate_bps);

Messing up reverse xmas tree.

>  		u64 other_qlen, other_last_active;
>  		struct Qdisc *other_sch;
>  		u32 num_active_qs =3D 1;
> @@ -2042,7 +2043,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
>  		}
>=20=20
>  		if (num_active_qs > 1)
> -			new_rate =3D div64_u64(q->config->rate_bps, num_active_qs);
> +			new_rate =3D div64_u64(READ_ONCE(q->config->rate_bps),
> +					     num_active_qs);

Just use new_rate, instead of a new READ_ONCE().

>=20=20
>  		cake_configure_rates(sch, new_rate, true);
>  		q->last_checked_active =3D now;
> @@ -2626,12 +2628,12 @@ static void cake_reconfigure(struct Qdisc *sch)
>  	struct cake_sched_config *q =3D qd->config;
>  	u32 buffer_limit;
>=20=20
> -	cake_configure_rates(sch, qd->config->rate_bps, false);
> +	cake_configure_rates(sch, READ_ONCE(qd->config->rate_bps),
> false);

Maybe just introduce a u64 rate_bps =3D READ_ONCE(...), and use here...=20
>=20=20
>  	if (q->buffer_config_limit) {
>  		buffer_limit =3D q->buffer_config_limit;
> -	} else if (q->rate_bps) {
> -		u64 t =3D q->rate_bps * q->interval;
> +	} else if (READ_ONCE(q->rate_bps)) {

...and here...

> +		u64 t =3D READ_ONCE(q->rate_bps) * q->interval;

and here.


Bj=C3=B6rn
