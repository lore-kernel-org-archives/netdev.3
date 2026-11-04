Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779841;
	b=QAiPWkukgcSEAj+cccDe6BcVGad8QDktqbyWJSN7zkPJRMfMgG1CwPjlZehIUVl/2FD8
	 7nR1CpKy4A2KyeuLcR04vmRLCuKHWm9LsqHNAWuh3de5PrdccotN8Z9X/2Fphsgguh9gV
	 x6B2RI6yGbsKWugi+RlvFSpgEltITsHr3Cv2FrW7Vx+NobQwGdaM2anjxcRDyRuZEDcLp
	 jRL7UKhcCYyL9EvC4CpShJLdl+ETPJP5kurWu2ZM5MrnDERCt3GIMraAQqYv7UN19crwM
	 yLc6s2bmutlMEaGqVTZIwhqQ4aHSCrUeqkGwqgJGdpPpOiXcSv7mY2Xc5QHa5QVCjfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779841;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=AIXih/+g+9WTOCjrd3v2llW1L1i6Jm4IJcUxf1FA9ws=;
	b=pvAisuc2LKtEf58VGWI/NE1G2S9IHupdd4hCUxM+IHl5HJarkB2vglBI9yxyjAY8rU7I
	 bno0XkXgvVrPwrAqHA5lj/Xpx/YvnaUYln8MoB+RUrGncXLT7gRzps02P9uM8LuCb8X/z
	 M6hqra39m0YBDuNrTeizhfTW3Kne6DAyQKkl5RN1xd0XE5QCwtmD920Ho11ToQxm5ejzE
	 Q9XkSVnLBv/D9nARh1/PNXGlXSS8/rVLhc5g1aOA6d1AKnfAnEJOwMuTRxrFnYQGqjjR4
	 MEyn2+1XkDBkVz0S2o6B3Bu1rRehywehuxrFyT8Tip2XA7DUlZh47M+0EJ5BaYpTqxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BfssRooC;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=h56TphMe;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9315F606A32D
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 08:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9315F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BfssRooC;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=h56TphMe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793779839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AIXih/+g+9WTOCjrd3v2llW1L1i6Jm4IJcUxf1FA9ws=;
	b=BfssRooC5UFgIECUtCytQtm25wzxNrUZdc/+TUBauFqbZtl34J183AjfVT2j4XJykLb7vF
	UgtixEUBB9r6JmwU/HhGz1LGmHk7+90ioEenJLjALabxEfRoTx+iE6dfsgk5/4CnJOGOQO
	8Oo5u/ugCfXhIOrWc6GUgRhBPiBK0A4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-1j6AjlEgNIawzKzGWuzGbQ-1; Wed, 04 Nov 2026 03:10:38 -0500
X-MC-Unique: 1j6AjlEgNIawzKzGWuzGbQ-1
X-Mimecast-MFC-AGG-ID: 1j6AjlEgNIawzKzGWuzGbQ_1793779837
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-49034831bb3so193058f8f.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 00:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793779837; x=1794384637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AIXih/+g+9WTOCjrd3v2llW1L1i6Jm4IJcUxf1FA9ws=;
        b=h56TphMeazGFab3XJ5SBMl+iJ45Yb80vSGCPMbVFEIGmQYcRU/nOViZvvQkcako54G
         eqKr9ulvIpeug/TB2FLfbP6GTPqT+RKhFEVLIhBKCrq299+HrCGgtcZ+1HtNQv2gEAoH
         Sp0QFRk1xy8eW+dFZauJYGqd97dwZsPcO//MofnckUw7QXxLNuU2bJ9pW6ejHcbUUa/+
         gOa2xq+m2P4SeanDXJjfAtV7ZQeirGA0328AuAtc+6qPbwtMI0EOpITi7g/X9NBKX1bv
         aGJPlfDJP+OAUw9hXLgT188vR4ZIaHgTamf+BCaIO6WFBuspvd8IfDtsCY4ATqN+EumI
         adDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793779837; x=1794384637;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AIXih/+g+9WTOCjrd3v2llW1L1i6Jm4IJcUxf1FA9ws=;
        b=SHdyba6opnPSC9npQWZdQIrHso8Fx9/bU8j1uD8ZADQmOGRb8ipf0T2G7DOA6zwJKe
         zTFllDwxw/DWvAOKfRUfvyYwXObPB72ZOfy8FDAmPUxI+vNTgZ4bj4kWZTZEps3ox1zG
         fbV1krze+L3+h5GC56sXHIca+sQLiAGxPjsW571Pd5sU/o2Gs2jwtzjHqjA6vm6JU40O
         hpiLinfmg2DDqoa/Wm67qRsAtRML5plroahkOdHlB48dMydR5twIO0+yMVeQmph+FtZb
         hZYwI3eAGJNpDJS5s4FN+inTcD96s181sPc3Rn7POw4C56K7qeIwJLZIBeYLo9fYfIOF
         o5Yg==
X-Forwarded-Encrypted: i=1; AKwUvBwEs5bk4LfI/huI0CZfVj/DFZVpB46tzisTdIw4WH47gVJXnDKon1SiUkW5PYIEqlruN/wq+qU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cKGB1buCGJ2w9qgO+YeSdaRscuib/Xcl0IynLJCYT3jUkkfNG
	+Cuv/7wR78mfCQOeNXqTHnTJ+5NsjERJRr3LqW8f0namczbu1MvIvMR2eo3XzhUAFpqE9gmV579
	hj0bMcVAP6kEGl6AGHu0mwRcHV6M4WAzDIpoMGRtD401HxCaw3+59+ncDUA==
X-Gm-Gg: AYBFou1q4t8KfFETZKUnrXB0U1j7cvHFE68Wkcm8bPomeaxo6QDyZjli1cqYR/FJ/PO
	sLLEQR1QTcEZM6XKIBJpUnddQrK9fiFMzHpoqTU/Rx/mIDAf8zJzJieVXCchSDmnfFydPO227v3
	VqdUmIrsOi1JCa6IOLEr58WleIin/rqRt15ECRRL76WAU7IPRfDB/2N4fPQ5re+jPiAkkKvO+Vs
	DCmEZlVJmX1gO1maD/5y0TEgbCFH8RrvgA+4cjwDOtMFrf43QxJXzF0xJffoZ3EKmqC0iGRSNth
	kiwa51i3STOJ+/4dt7UxU7wUufaDvgBiqvauNfYavfJ+MT1KQOC1VzJhUwabMCtnGpo/Ilc+9gc
	eYOrkm8fBaCHGq30YYLbzO6WnhLRJSNCdPb7EEsmikC/ZaWmfVYlnKlOf0lodujh4D5A0hAo5Vy
	/P78BL7M9ufPvufSL5DSE7K8aJkxLC8tobC62FiiWHFr4=
X-Received: by 2002:a05:6000:40dc:b0:48e:412:3829 with SMTP id ffacd0b85a97d-48e6e3071f9mr35514456f8f.15.1793779837103;
        Wed, 04 Nov 2026 00:10:37 -0800 (PST)
X-Received: by 2002:a05:6000:40dc:b0:48e:412:3829 with SMTP id ffacd0b85a97d-48e6e3071f9mr35514390f8f.15.1793779836215;
        Wed, 04 Nov 2026 00:10:36 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fece99b33sm2302373f8f.23.2026.11.04.00.10.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:10:35 -0800 (PST)
Message-ID: <1e517947-48cb-4733-9e51-8a165d3ba534@redhat.com>
Date: Wed, 4 Nov 2026 09:10:34 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/sched: fix rate estimator use-after-free when
 clearing NOLOCK
To: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com
References: <20261030030453.31928-1-cenzhang@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261030030453.31928-1-cenzhang@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 04:04, Cen Zhang (Microsoft) wrote:
> qdisc_create() creates the rate estimator requested by TCA_RATE before
> qdisc_graft() converts a lockless child of a locking parent. The
> conversion in qdisc_clear_nolock() frees the per-CPU statistics, but
> the estimator keeps its own copy of the cpu_bstats pointer and its
> timer keeps reading the freed per-CPU memory on every estimator tick.
> 
> An unprivileged local user can trigger this. The estimator timer can
> access freed per-CPU statistics in softirq context and panic the kernel:
> 
>    BUG: unable to handle page fault for address: ff9d8b20ffa47920
>    RIP: 0010:gnet_stats_add_basic+0x77/0xc0
>    Call Trace:
>     <IRQ>
>     est_fetch_counters+0x31/0x50
>     est_timer+0x52/0x170
>     call_timer_fn+0x9f/0x210
>     run_timer_softirq+0x6e/0xb0
>     </IRQ>
>    Kernel panic - not syncing: Fatal exception in interrupt
> 
> Fix by doing the NOLOCK conversion in qdisc_create(), right before
> the estimator is created, instead of in qdisc_graft(), so that the
> estimator captures the final statistics pointer. Removing the
> conversion from qdisc_graft() is safe: a new qdisc is created by
> qdisc_create() with the parent it is grafted under, and since
> commit bc50835e83f6 ("net: sched: Disallow replacing of child qdisc
> from one parent to another") an existing qdisc can only be grafted
> again under its original parent. Either way the qdisc was already
> converted for that parent at creation.
> 
> Fixes: 8a53e616de29 ("net: sched: when clearing NOLOCK, clear TCQ_F_CPUSTATS, too")
> Cc: stable@vger.kernel.org
> Cc: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
> ---
> 
> The bug was found and this fix was developed with the assistance of an
> LLM-based code analysis tool.
> 
> Backport note: trees without commit bc50835e83f6 (v6.14) still allow
> regrafting an existing child qdisc under a different parent and need
> an additional fix for that path, for example cherry-picking that
> commit as well.
> 
>   net/sched/sch_api.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index f36c41224bcc..d89f3f0a3c5f 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -1247,10 +1247,6 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
>   		unsigned long cl;
>   		int err;
>   
> -		/* Only support running class lockless if parent is lockless */
> -		if (new && (new->flags & TCQ_F_NOLOCK) && !(parent->flags & TCQ_F_NOLOCK))
> -			qdisc_clear_nolock(new);
> -
>   		if (!cops || !cops->graft)
>   			return -EOPNOTSUPP;
>   
> @@ -1327,6 +1323,7 @@ static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
>   
>   static struct Qdisc *qdisc_create(struct net_device *dev,
>   				  struct netdev_queue *dev_queue,
> +				  struct Qdisc *parent_qdisc,
>   				  u32 parent, u32 handle,
>   				  struct nlattr **tca, int *errp,
>   				  struct netlink_ext_ack *extack)
> @@ -1405,6 +1402,11 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>   			goto err_out4;
>   	}
>   
> +	/* Only support running class lockless if parent is lockless */
> +	if ((sch->flags & TCQ_F_NOLOCK) && parent_qdisc &&
> +	    !(parent_qdisc->flags & TCQ_F_NOLOCK))
> +		qdisc_clear_nolock(sch);
> +
>   	if (tca[TCA_RATE]) {
>   		err = -EOPNOTSUPP;
>   		if (sch->flags & TCQ_F_MQROOT) {
> @@ -1817,7 +1819,7 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>   create_n_graft2:
>   	if (clid == TC_H_INGRESS) {
>   		if (dev_ingress_queue(dev)) {
> -			q = qdisc_create(dev, dev_ingress_queue(dev),
> +			q = qdisc_create(dev, dev_ingress_queue(dev), NULL,
>   					 tcm->tcm_parent, tcm->tcm_parent,
>   					 tca, &err, extack);
>   		} else {
> @@ -1834,7 +1836,7 @@ static int __tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
>   		else
>   			dev_queue = netdev_get_tx_queue(dev, 0);
>   
> -		q = qdisc_create(dev, dev_queue,
> +		q = qdisc_create(dev, dev_queue, p,
>   				 tcm->tcm_parent, tcm->tcm_handle,
>   				 tca, &err, extack);
>   	}

Jamal: could you please have a look?

Side note: I'm not sure if you are aware but we process the pending patches
in this order:

https://netdev.bots.linux.dev/suie.html?delegate=netdev

And you can restrict the list to the tc subsystem selecting the appropriate
filter with the funnel icon in the top right.

/P

