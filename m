Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2D9384CCE
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788256276; cv=none; b=b9mJHDMDKoSHLy+Ushp2BhxJGgYA8qCN+nIOobtdLikczEUh4Gnsn76o6+tzdPF3Ggl/Is1PAgz80FiMp4ooQa7A3k8lsbNIC3xYRw7X71pStvLZqGWY7ffFx2eL0lHX3Y2sqtRvP+fKP/JyLEPBMplimqlIqdhrX63etUSNhOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788256276; c=relaxed/simple;
	bh=PqcS43Kz0L3EIY3rHu337RGN1e3vUqPXpU2wBPTMRq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzT/G8L+FLluE8mR21L6RAApVED+bvb5TF3P/zVtb/TekL0iZI6wPrjcv0XdxWUKZCcoRduyfGjK73yuANTSqME6tARJw2ovPkEAH+lE3RDZ19neosDuPf8LfzdJEgDgu9/gBP89eibls7C8MP0BFY0Ymj9LJ5gecdwMZ3Q2nXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fEAKTK2k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEAKTK2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788256273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGPYUUj4p3YEROI4nFlvU0VDeo3swndiRIwBv/4inAw=;
	b=fEAKTK2kL9bp5owuqIDb9eyxaQKnj+XeU3FUiQC4ie8fGfL9L9p122GgrCy7d0dR+gwRJA
	hzk1AcOVtY8Ft64/ijDMWupjbZ1pE4elc5OvbV8A3TUPY2mf7QB5U+/nok5PVpl4EwQfsw
	IHi7HU3+rRH5G/WO4P4SthdrbORyfXc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-47--0Sj_pLAOxW15zvqP7Zvxg-1; Tue,
 01 Sept 2026 05:51:10 -0400
X-MC-Unique: -0Sj_pLAOxW15zvqP7Zvxg-1
X-Mimecast-MFC-AGG-ID: -0Sj_pLAOxW15zvqP7Zvxg_1788256268
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 59CC21944E42;
	Tue,  1 Sep 2026 09:51:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.14])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EFC9F1955F7C;
	Tue,  1 Sep 2026 09:51:04 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: victor@mojatatu.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	vega@nebusec.ai,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_route: free emptied bucket on filter move
Date: Tue,  1 Sep 2026 11:51:01 +0200
Message-ID: <20260901095101.124563-1-pabeni@redhat.com>
In-Reply-To: <20260829205422.854785-1-victor@mojatatu.com>
References: <20260829205422.854785-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net/sched: cls_route: free emptied bucket on filter move

This adds a refcount of the filters linked into a route4_bucket so the
bucket can be dropped from head->table[] and freed as soon as the last
filter leaves it, replacing the open coded scan in route4_delete().  It
also reworks the fold unlink path in route4_change() to use fold->bkt
directly instead of looking the bucket up by to_hash(fold->handle).

> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index 0d1324c90583..17b0ebb76662 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c

[ ... ]

> @@ -459,6 +452,7 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
>  		if (b == NULL)
>  			return -ENOBUFS;
>  
> +		refcount_set(&b->filters_ref, 1);
>  		rcu_assign_pointer(head->table[h1], b);
>  	} else {
>  		unsigned int h2 = from_hash(nhandle >> 16);
> @@ -468,6 +462,8 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
>  		     fp = rtnl_dereference(fp->next))
>  			if (fp->handle == f->handle)
>  				return -EEXIST;
> +
> +		refcount_inc(&b->filters_ref);
>  	}

[Severity: Medium]
Should this duplicate scan compare against nhandle rather than f->handle?

The destination bucket and chain are selected from nhandle:

net/sched/cls_route.c:route4_set_parms() {
	...
	h1 = to_hash(nhandle);
	b = rtnl_dereference(head->table[h1]);
	...
		unsigned int h2 = from_hash(nhandle >> 16);

		for (fp = rtnl_dereference(b->ht[h2]);
		     fp;
		     fp = rtnl_dereference(fp->next))
			if (fp->handle == f->handle)
				return -EEXIST;
	...
	f->handle = nhandle;
}

but for a change route4_change() has copied the old handle into f before
calling here:

net/sched/cls_route.c:route4_change() {
	...
	if (fold) {
		f->id = fold->id;
		f->iif = fold->iif;
		f->handle = fold->handle;
	...
}

and f->handle is only set to nhandle further down, after this loop.

Taking the reproducer from the changelog one step further on the patched
tree:

  tc filter add ... route from 1 to 1     -> handle 0x10001, bucket 1
  tc filter add ... route from 1 to 2     -> handle 0x10002, bucket 2
  tc filter change ... handle 0x10001 route from 1 to 2

nhandle becomes 0x10002 and new is false, so the mismatch check under
"if (handle && new)" is skipped.  Bucket 2 exists, so the scan above walks
ht[1], finds the filter with handle 0x10002, compares it to f->handle
(still 0x10001), does not match, and the new refcount_inc() is taken.

Does that leave two filters carrying handle 0x10002 in the same chain?
route4_get() returns the first match only:

net/sched/cls_route.c:route4_get() {
	...
		for (f = rtnl_dereference(b->ht[h2]);
		     f;
		     f = rtnl_dereference(f->next))
			if (f->handle == handle)
				return f;
	...
}

so get, change, delete and dump would resolve the handle by list order.

The mirror case looks affected too: an in-place change that keeps the same
to/from computes nhandle == fold->handle, the scan then finds fold itself
in the chain and returns -EEXIST, rejecting the change.

The comparison itself predates this patch, but this patch is what turns the
renumbering/bucket-move path into a supported, leak-free operation, and it
adds code immediately after the faulty comparison.  Would
"fp->handle == nhandle && fp != fold", or rejecting the handle mismatch for
existing filters as well, belong in the same change?

The refcount accounting itself looks exact in the duplicate case, since each
linked filter contributed one reference, so no premature free follows from
this.

Also, the changelog says the handle-mismatch check being gated on the 'new'
flag is what allows the move, but it does not mention that the filter's
handle visible to userspace changes as a result.  Could that be spelled out?

> @@ -560,17 +556,20 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
>  	rcu_assign_pointer(*fp, f);
>  
>  	if (fold) {
> -		th = to_hash(fold->handle);
> +		b = fold->bkt;
>  		h = from_hash(fold->handle >> 16);
> -		b = rtnl_dereference(head->table[th]);
> -		if (b) {
> -			fp = &b->ht[h];
> -			for (pfp = rtnl_dereference(*fp); pfp;
> -			     fp = &pfp->next, pfp = rtnl_dereference(*fp)) {
> -				if (pfp == fold) {
> -					rcu_assign_pointer(*fp, fold->next);
> -					break;
> +		fp = &b->ht[h];
> +		for (pfp = rtnl_dereference(*fp); pfp;
> +		     fp = &pfp->next, pfp = rtnl_dereference(*fp)) {
> +			if (pfp == fold) {
> +				rcu_assign_pointer(*fp, fold->next);
> +				if (refcount_dec_and_test(&b->filters_ref)) {
> +					unsigned int th = to_hash(fold->handle);
> +
> +					RCU_INIT_POINTER(head->table[th], NULL);
> +					kfree_rcu(b, rcu);
>  				}
> +				break;
>  			}
>  		}
>  	}

[Severity: Low]
Could a tdc case be added for the cross-bucket move this fixes?

tools/testing/selftests/tc-testing/tc-tests/filters/route.json has exactly
one test touching the replace path, "b042" ("Try to delete class referenced
by route after a replace"):

  $TC filter add dev $DEV1 parent 10: prio 1 route from 10 classid 10:1 action ok
  $TC filter replace dev $DEV1 parent 10: prio 1 route from 5 classid 10:1 action drop

With TCA_ROUTE4_TO absent, route4_set_parms() builds nhandle as
0x8000 | id << 16, so the handles are 0xA8000 and 0x58000, and to_hash() is
256 for both.  Both filters land in the same top-level bucket, and the
replaced handle 0x58000 does not exist, so *arg is NULL and the fold path
above is never entered.

That leaves both new free sites untested: this refcount_dec_and_test() plus
kfree_rcu(b, rcu) in route4_change(), and the equivalent one in
route4_delete().  Neither a return of the leak nor a premature bucket free
introduced by the new refcounting would be caught.

The reproducer in the changelog (add "from 1 to 1", change to "from 1 to 2",
delete 0x10002, then count the remaining filters) maps directly onto a tdc
case in route.json.
-- 
This is an AI-generated review.

