Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9322212FAD
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789173402; cv=none; b=DnfxZ5a+LAizL1pXBNqN/cXrtK67mHcrX7xFuCc/zX6E1DdYy8/ZinfV38xwrOcDKv4+iFYTR/jTU7ozbwxTEpBvBV93RkSwBep7YYjTN62wafWtuAHCpCNnnVKlFzutKXio9g74pemL4TVzYkb3YHm/9umtYOOlvPMHLlCkW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789173402; c=relaxed/simple;
	bh=LgPZibBxwsr9We1MhdSN6LfddVtbgcoClOxRnKesldk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Wgf/8d7VKyn5NUtAjDPpNf9CgBvnZPZP6ZvQX0dKXeujycmP+cXe7d6PBGZKMK04TVj5WivvjXCZzJBDQbRH0IDt4ELKbxk2jGXb7NOZ1eE4KK8ohpoQZgu2b4fwUyCXN6mYvQpeyFrLFgbmfrgnnldvAG0VIAASkfYZZyg6xgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8czRNI/; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8czRNI/"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4ab20a32so141215d50.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789173399; x=1789778199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AxyQnKjUz4YhqRWuU6gTMOmki5fFi29cToDP8KUVL50=;
        b=o8czRNI/P98pBC1MSqEKTTdcKTEzdHL9HGREFxGx+YKXTwZbmFsbvRVjlvhLoHRrSo
         66ZvR8cM9d9yDxahSKOe/k6qxziNp1cb+Zo0T2RQZmnUMlX9gXJiBTmrB9ldr24VEc6K
         MIapliNmZEhzMLQVsVMek7an7DqoT1PhLBPXG2yIk2SjNNbkcMVkQ2XUajHMPmn3MAo4
         BkAS57uu7r8wPlMxmGRCUaA2q1McO+YqO+t17hmf9KFvNHSFm3u2kLWj4Xm7Kfu0kcfG
         cztkR4K9elk8zi+V/E55ItSXcqzwU5ISHKdn51EYWgw2xVI3Fcd9NpPfRDGVJ8MatQBT
         34Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789173399; x=1789778199;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AxyQnKjUz4YhqRWuU6gTMOmki5fFi29cToDP8KUVL50=;
        b=DCeXqrdXA9qWsWJthLpT/3EygDjnLpF4DC/uOoi+rzpzLiBHxQ16T7EbHX4pYx6Ln8
         vyeE2ZjIGbtlrUh6G9IJthSNS6F8jmjfAPKkpscpNMO2+XJlnublqLbAB2R9cesJUAfT
         PPxhy06nHbWNoxxllvap9OkMNIr+yqdjmCpS72dldrHkvnccZxfArKVlu8AfTTmc8fjU
         gGW8Qn3xJo6BdvYrDySloTW5xZhMOSoylDkS1tgW12jJvT1u0XyXQ9FVz4bnx5AzO58y
         YjocmqPbp1LI/O/sCvmLgCYxHGTQE6SbQ53uoQ9tuzoo7wLd1yfc98h9nY8rGnH8Twcn
         HnGA==
X-Gm-Message-State: AFuF++lL71Ee8NznnDw/ndA6NXD9lZ6KSbuLcyWpNo86GNISQWFoldrd
	6FOQEKWw592dbmbsoa1rUKEUm2KfwmREtBdl/957FsYjBAmKQV56QlW5
X-Gm-Gg: AYBFou21MWOjlFxh6aA0Fs2jeSQzVriXnW8+miLEsoUDF1B8J8RADX9zplj10CZPe8X
	jDgsil59QIxtGuqMDoJC9/+7mMwjEo9SO21tfG6b93YV7V3168auN4lnxhTRirbbDo2SpNd8eMU
	ENiB0cZ2UykVCq/phixoVttCZv8aC2T0DVBVZl9aMgP+r4rDmEQFw8cxKgnGPZiuV2nqw9MUhqe
	GuKrkeXy+b+o67S+S6LbeH2sznc2T6eBWfopPC0pBMeNThBiEZefRYtVimNugbtjsl2chhgzbFf
	5aNnRSlQgTKr7JlebARZvn23VWYi8ZKsmm+mSshj36mFowODwBRSXgt+pbyNnB2/LdkB1UeK+xY
	BC/0paATaZaHTwozw0OB9Mt99DylbZowSGwqMqI/XjfQr4c0vwhJXtw9x0h/FTVDILBGFSOYZEf
	hnpcB6ewdjynE7Xczle2fuWMM7tAqPh5RPZrQJ6ql0awChuPZVZo4SXrZ+ZNley2YCrUY/bG7oj
	STb6Nxv8iB5Q9pv68Vby5Cc4XiGb8Ewx7Us/Z+M6GMpsRy6WYZD
X-Received: by 2002:a05:690e:11c9:b0:66f:c1bc:4078 with SMTP id 956f58d0204a3-67135aa3e70mr103084d50.59.1789173399498;
        Fri, 11 Sep 2026 17:36:39 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125e7c190sm1693841d50.17.2026.09.11.17.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:36:37 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:36:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.1571be0acb9a@gmail.com>
In-Reply-To: <178914679635.219967.4563834866783696110@kernel.org>
References: <20260910171131.2532487-4-willemdebruijn.kernel@gmail.com>
 <178914679635.219967.4563834866783696110@kernel.org>
Subject: Re: [PATCH net-next v9 3/7] net_sched: sch_fq: clear past skb->tstamp
 if offloading pacing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
> =

> - [Medium] The two new clearing sites use different predicates, and the=

>   dequeue-side one folds in a schedule the offloading device never sees=
.
> - [Low] Incomplete coverage of the new "clear an expired EDT before
>   handing the skb to a pacing-offload device" logic on FQ's internal=E2=
=80=A6
> =

> --
> =

> net_sched: sch_fq: clear past skb->tstamp if offloading pacing
> =

> When pacing offload is active, sch_fq now clears skb->tstamp for packet=
s
> whose EDT has already passed (or is within a 400 nsec slack window) so
> the device does not have to compare the timestamp against the current
> time.  The clearing is done in two places: in fq_classify() for fastpat=
h
> packets, and at the out: label of fq_dequeue() for regular flows.
> =

> A couple of questions about the coverage of the new clearing below.
> =

> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index dfc7f98b600f8..a282812c192ee 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -159,6 +159,9 @@ struct fq_sched_data {
> >  	u64		stat_allocation_errors;
> >  };
> >  =

> > +/* EDT timestamps to clear beyond now. */
> > +static const int fq_offload_slack_ns =3D 400;
> > +
> >  /* return the i-th 2-bit value ("crumb") */
> >  static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
> >  {
> > @@ -421,6 +424,10 @@ static struct fq_flow *fq_classify(struct Qdisc =
*sch, struct sk_buff *skb,
> >  			smp_store_release(&sk->sk_pacing_status,
> >  					  SK_PACING_FQ);
> >  =

> > +		if (offload_horizon &&
> > +		    fq_skb_cb(skb)->time_to_send <=3D now + fq_offload_slack_ns)
> > +			skb_set_delivery_time(skb, 0, SKB_CLOCK_REALTIME);
> > +
> >  		return &q->internal;
> >  	}
> >  =

> =

> [ ... ]
> =

> > @@ -745,7 +753,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *s=
ch)
> >  	if (skb) {
> >  		q->internal.qlen--;
> >  		fq_dequeue_skb(sch, &q->internal, skb);
> > -		goto out;
> > +		return skb;
> >  	}
> >  =

> >  	now =3D ktime_get_ns();
> =

> [Severity: Low]
> For packets on q->internal the clearing decision is now taken only once=
,
> at enqueue time in fq_classify(), using the enqueue-time now.  With the=

> goto out changed to return skb, internal-queue packets no longer reach =
the
> new block at the out: label, and they are returned before now is even
> sampled.
> =

> fq_fastpath_check() admits a packet whose txtime is up to offload_horiz=
on
> in the future:
> =

> 	if (fq_skb_cb(skb)->time_to_send > now + offload_horizon)
> 		return false;
> =

> and the internal queue is not single-slot:
> =

> 		if (q->internal.qlen >=3D 8)
> 			return false;
> =

> So a packet can be admitted with a future txtime, sit behind up to seve=
n
> others (or behind a stopped tx queue), and by the time fq_dequeue()
> returns it the txtime has expired, yet skb->tstamp is still set and the=

> device performs exactly the future-time comparison the change is meant =
to
> avoid.  Is that gap intentional, or should the internal-queue path also=

> re-test at dequeue?

Testing fast path only in fq_enqueue is intentional.
 =

> Relatedly, the second exit to the internal queue in fq_classify(), the
> allocation failure path:
> =

> 	f =3D kmem_cache_zalloc(fq_flow_cachep, GFP_ATOMIC | __GFP_NOWARN);
> 	if (unlikely(!f)) {
> 		q->stat_allocation_errors++;
> 		return &q->internal;
> 	}
> =

> does no clearing at all, so even an already-expired EDT survives to the=

> device there.  Should that path get the same treatment?
> =

> The predicate itself is conservative (nothing more than
> fq_offload_slack_ns in the future is ever cleared), so this looks like =
a
> missed optimization rather than a wrong transmit time, but the commit
> message reads as though all packets whose txtime has passed get
> skb->tstamp cleared.
> =

> > @@ -782,8 +790,8 @@ static struct sk_buff *fq_dequeue(struct Qdisc *s=
ch)
> >  =

> >  	skb =3D fq_peek(f);
> >  	if (skb) {
> > -		u64 time_next_packet =3D max_t(u64, fq_skb_cb(skb)->time_to_send,
> > -					     f->time_next_packet);
> > +		time_next_packet =3D max_t(u64, fq_skb_cb(skb)->time_to_send,
> > +					 f->time_next_packet);
> >  =

> >  		if (now + offload_horizon < time_next_packet) {
> >  			head->first =3D f->next;
> =

> [ ... ]
> =

> > @@ -862,6 +870,10 @@ static struct sk_buff *fq_dequeue(struct Qdisc *=
sch)
> >  	}
> >  =

> >  out:
> > +	if (offload_horizon &&
> > +	    time_next_packet && time_next_packet <=3D now + fq_offload_slac=
k_ns)
> > +		skb_set_delivery_time(skb, 0, SKB_CLOCK_REALTIME);
> > +
> >  	return skb;
> >  }
> =

> [Severity: Medium]
> Should this test the packet's own txtime rather than time_next_packet?

EDT calculations in FQ must use time_next_packet over skb->tstamp.

> The fq_classify() site uses fq_skb_cb(skb)->time_to_send, while here
> time_next_packet is:
> =

> 		time_next_packet =3D max_t(u64, fq_skb_cb(skb)->time_to_send,
> 					 f->time_next_packet);
> =

> f->time_next_packet is FQ's own rate-pacing schedule.  Grepping
> net/sched/sch_fq.c, skb->tstamp is only ever written by
> fq_mono_to_skb_tstamp() on the fq_enqueue() horizon-cap path, so
> f->time_next_packet is never propagated into skb->tstamp and the device=

> never sees it.
> =

> The effect shows up when FQ enforces its own rate, e.g.:
>
>   tc qdisc replace dev X root fq maxrate 1gbit offload_horizon <=3D \
>       dev->max_pacing_offload_horizon
> =

> For an EDT packet the branch that consults sk_pacing_rate is skipped:
> =

> 	if (!skb->tstamp) {
> 		if (skb->sk)
> 			rate =3D min(READ_ONCE(skb->sk->sk_pacing_rate), rate);
> =

> so rate stays at q->flow_max_rate and the previous dequeue set
> f->time_next_packet =3D now + len.  The flow is then throttled until
> f->time_next_packet - offload_horizon, so on release:
> =

> 	now + 400 < f->time_next_packet <=3D now + offload_horizon
> =

> and the predicate is false even though fq_skb_cb(skb)->time_to_send is
> already well in the past.  In that configuration the clearing never
> happens, while the fq_classify() peer site would have cleared the same
> packet.  Note fq_fastpath_check() rejects the fastpath when
> q->flow_max_rate !=3D ~0UL, so maxrate flows always take this path.
> =

> Since time_next_packet is always >=3D time_to_send, nothing with a genu=
inely
> future EDT gets cleared, so this looks like a silently ineffective
> optimization rather than a correctness problem.  Was using

The interplay of EDT and FQ maxrate is complex. A "silently
ineffective optimization" is acceptable.

> fq_skb_cb(skb)->time_to_send here considered, to keep the two sites
> consistent?
> =

> -- =

> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20260910171131.2532487-1-willemdebruijn.kernel%40gmail.com


