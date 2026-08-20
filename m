Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F91E344DB7
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191825; cv=none; b=Nc+msRb6Nl5j1cFw9RgzqDkE0PJ86Eg3LYNN3uLvtPnCAKEMsdgaCwtj1jO7VwzA9t7s/zg0lSzuJvQneJn3v7lilxG61hldRbJ9SjISdz91eUUy6nkHlHWpAGA3GIRWsETNPYQx2Lw4MsFM1xc/BA2nVEjVSQPpKAEXPx7O4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191825; c=relaxed/simple;
	bh=bFlOFiUtD5KyboL8QGPglsuDq20OQFgcf6G/3R4+Pgs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=O7cEaPTY82cKH6IBBbmYRmfSQOpYDVWzFmLD5XylKsOVl8W/R7GwRT2125Poehosjc+IcibKtYXdNuYrWJbQkYVBDewHmJjZ85OydUBiTlrxC0o9Mk7NCenb4jLaNz6DMzOXETR55nDzjoQkdM239ZE2LgqRmKWNbL5ak6dqMeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6OVlh1J; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6OVlh1J"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-836c4474028so22505017b3.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 19:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787191822; x=1787796622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=scXYbrHUiFNlEC4GgFIcwL7foru8hjhiQNRfOQh2l6k=;
        b=T6OVlh1JcaLg48OKoj4PJ0ykdTNeTWigkWGe5BTkJNJrIaUw9Q5zpGHHRa2lBdn5Xx
         gGU4MIH5rS0C772nIg6f0F6gY5objZ+sLiyMmHOixURCLiZXQJwqXT2nHUfz0nLYK4O1
         DKl17qaOkB4bM18gF2NkVMGeAEDpeBsoWcj57SmWWAV69i2x/pBM0p+ixvl9E8+ign9A
         0Yn7MRD+N+Dw4mpehYRx4A1LR2MB5ha+ztCLbGwGwKnSf+/JwfSnoFt8y/jUysDNGXOk
         mBnD4pgS7mGInkE+NjFJlCEmW2Zbi12KuQMqov5Cy8w3neeZWQrEOdCnjkUhnikavPXK
         QOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787191822; x=1787796622;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=scXYbrHUiFNlEC4GgFIcwL7foru8hjhiQNRfOQh2l6k=;
        b=MRaQpFaDVdkCBmyXqPbXf3IXR+em6xEuWUAFXioDaxi/1ukzmAfmlm/uWoD0mEy8UJ
         4S9WF9rKMMkWxpLIhWVMXE77zHc4wbEQUFcLOnZHVINQPCpp64LyPgRPiRCPedv23TEq
         YoM95q6hpyvEKNo3PCYITwOx48NxYIKbS0Rt8lr8TUhDJb/FbqwRy25/zVX7TXhijAJ3
         UDhpZUFZTH6BosbZB6hE1xAqpBe80kSvnY2T64ih2qZtoQ6QlS0cKLcfhkO0K2B1O2Vb
         iTA5Q8YtiWLy6wRJVGA6Ld+LvliKJdmUjfhJLKOyWP9M1oSVuYZGnQIxEdF0WrvHtShI
         vHcQ==
X-Forwarded-Encrypted: i=1; AHgh+RpY6pSiICoB8R+m4uMgC+jbIcaVl8XSydbItXvc+jj5PKsDmAi/oD/hen0GKeg5Hrr81w8Ir+w=@vger.kernel.org
X-Gm-Message-State: AFuF++nUO201VuBgA+vWkU5TIUFyRifFuHGCPkdB/geknkIg2ftd+4Nz
	j/t/3nIycLakFJV866OdIaFHvV9DOSxUR+sIImyhbaBnuGUMHegwHmdc80ebTQ==
X-Gm-Gg: AR+sD10U+hRLxffnUzTClJrR+6ACur01gXZE4qdGEY9rPmdSZltuYz8sDfIOUX8Qg+w
	rEZuikuPDHM1gYUCNb19Hx/e0yyV1I7w/T2OXUUOjuqvxuWQbdDjZrvUiPvBs1yl+mjwUAWNk9r
	PWhgBVqt/LXJ2rNnssKbUi5Uq3GqwGXz78lhctpJNViTnI4RTrkfyBrVy8pOjC5AzyB0Gfa8jap
	FXWUh4dA8UDJ0hCd6k7viKYg6eshtv9SM3sPC1Gly5DoX2ezFz6ZHHzhkYY0A7U1UYv+pCnsYTb
	JT+mKjtV/R4HcIzB66oRtkaozcAf0QlbtLDA8A0jJm8F1tzSw6s4S0QiyikAPwqrn+LERosLHEx
	CyJrSJxbQhmAvRgEgMyfD0wloiKrhZ+9qPkuhgbfNOfCC7KyDAsYt6P8Yaqa11QL/gbodv32n7B
	XBV4t08EUBNzgv0+p0fjxf07yLlIe/vsvpRlIuJRV5CjVChPspoM8Za7N4CQQSWNH7YBigm3Aix
	x9Kt5RfipZHHzK3f00X8EVi3tzPlovVn5gXiXA6UA==
X-Received: by 2002:a05:690c:6609:b0:847:d995:e013 with SMTP id 00721157ae682-847d995e28cmr3636587b3.22.1787191822270;
        Wed, 19 Aug 2026 19:10:22 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84518aa1f1csm17804167b3.42.2026.08.19.19.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 19:10:21 -0700 (PDT)
Date: Wed, 19 Aug 2026 22:10:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Kyle Zeng <kylebot@openai.com>, 
 netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Muhammad_Hazley_SAMSUDIN_from.TP@tech.gov.sg, 
 Kyle Zeng <kylebot@openai.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2b15884313bc5@gmail.com>
In-Reply-To: <willemdebruijn.kernel.30254a97eb38@gmail.com>
References: <20260816235646.76500-1-kylebot@openai.com>
 <willemdebruijn.kernel.30254a97eb38@gmail.com>
Subject: Re: [PATCH net v2] net/packet: defer vmalloc TX_RING free until skbs
 finish
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Kyle Zeng wrote:
> > AF_PACKET TX_RING skbs keep a raw pointer to their ring frame. The skb
> > page references preserve page-backed ring blocks after pg_vec is freed,
> > but they do not preserve a vmalloc mapping.
> 
> Claude shows an interesting case where this page-backed statement does
> not hold: if the entire skb is linear. Not for this patch, but a
> similar case.
>  
> > tpacket_destruct_skb() currently drops the pending reference before
> > writing the timestamp and TP_STATUS_AVAILABLE to the frame. Move the
> > decrement after those stores. The smp_wmb() in __packet_set_status()
> > orders the frame stores before the decrement.
> > 
> > Also recheck pending TX frames under pg_vec_lock before non-closing
> > ring replacement, so a racing send cannot add a pending skb between
> > the initial check and the ring swap.
> > 
> > Ring allocation can produce a mixture of page-backed and vmalloc-backed
> > blocks. Allocate deferred-work storage during TX ring setup when the
> > first vmalloc-backed block is encountered, and keep its pointer in the
> > pg_vec allocation header. If allocation fails, return -ENOMEM from ring
> > setup. On socket close, a non-NULL pointer identifies a vmalloc-backed
> > vector without a scan. If TX skbs remain, defer the whole vector to
> > system_long_wq.
> > 
> > After pg_vec is detached, a late destructor can skip the pending
> > decrement. Use socket write-memory accounting as the deferred lifetime
> > gate instead: an skb remains charged through its final sock_wfree(),
> > after all ring-frame accesses. The delayed work retains a socket
> > reference and reschedules itself until no TX skbs remain.
> > 
> > Move pending_refcnt release to packet_sock_destruct() so late skb
> > destructors and deferred cleanup can safely use it after
> > packet_release(). Page-backed teardown remains synchronous, and no lock
> > is added to the TX completion hot path.
> 
> This one patch combines multiple fixes. If and only if a respin is
> needed, it may be good to break it up to help understanding.
> 
> > Fixes: b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/netdev/20260721015824.45829-1-kylebot@openai.com/
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Assisted-by: Codex:gpt-5.6-sol
> 
> > +struct packet_pg_vec {
> > +	struct packet_pg_vec_free *deferred;
> > +	unsigned int order;
> > +	unsigned int len;
> > +	struct pgv pg_vec[] __counted_by(len);
> > +};
> > +
> > +struct packet_pg_vec_free {
> > +	struct delayed_work work;
> > +	struct sock *sk;
> > +	struct packet_pg_vec *vec;
> > +};
> 
> > @@ -4382,7 +4399,46 @@ static void free_pg_vec(struct pgv *pg_vec, unsigned int order,
> > +static void packet_free_pg_vec_work(struct work_struct *work)
> > +{
> > +	struct packet_pg_vec_free *deferred;
> > +	struct packet_pg_vec *vec;
> > +	struct sock *sk;
> > +
> > +	deferred = container_of_const(to_delayed_work(work),
> > +				      struct packet_pg_vec_free, work);
> > +	vec = deferred->vec;
> > +	sk = deferred->sk;
> > +	if (sk_wmem_alloc_get(sk)) {
> > +		queue_delayed_work(system_long_wq, &deferred->work, 1);
> 
> Can this keep requeueing itself? Claude suggests using pending ring
> count as gate.
> 
> > +static void packet_free_tx_ring(struct sock *sk, struct pgv *pg_vec,
> > +				unsigned int order, unsigned int len)
> > +{
> > +	struct packet_pg_vec_free *deferred;
> > +	struct packet_pg_vec *vec;
> > +
> > +	vec = container_of_const(pg_vec, struct packet_pg_vec, pg_vec[0]);
> > +	deferred = vec->deferred;
> > +	if (!deferred || !sk_wmem_alloc_get(sk)) {
> > +		free_pg_vec(pg_vec, order, len);
> > +		return;
> > +	}
> > +
> > +	/* A detached ring's pending count can miss late skb destructors. */
> > +	deferred->sk = sk;
> > +	sock_hold(sk);
> > +	queue_delayed_work(system_long_wq, &deferred->work, 0);
> >  }
> >  
> >  static char *alloc_one_pg_vec_page(unsigned long order)
> > @@ -4410,20 +4466,35 @@ static char *alloc_one_pg_vec_page(unsigned long order)
> >  	return NULL;
> >  }
> >  
> > -static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order)
> > +static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring)
> >  {
> >  	unsigned int block_nr = req->tp_block_nr;
> > +	struct packet_pg_vec *vec;
> >  	struct pgv *pg_vec;
> >  	int i;
> >  
> > -	pg_vec = kzalloc_objs(struct pgv, block_nr, GFP_KERNEL | __GFP_NOWARN);
> > -	if (unlikely(!pg_vec))
> > -		goto out;
> > +	vec = kzalloc_flex(*vec, pg_vec, block_nr, GFP_KERNEL | __GFP_NOWARN);
> > +	if (unlikely(!vec))
> > +		return NULL;
> > +	vec->order = order;
> > +	vec->len = block_nr;
> > +	pg_vec = vec->pg_vec;
> >  
> >  	for (i = 0; i < block_nr; i++) {
> >  		pg_vec[i].buffer = alloc_one_pg_vec_page(order);
> >  		if (unlikely(!pg_vec[i].buffer))
> >  			goto out_free_pgvec;
> > +
> > +		if (tx_ring && !vec->deferred &&
> > +		    is_vmalloc_addr(pg_vec[i].buffer)) {
> > +			vec->deferred = kzalloc_obj(*vec->deferred,
> > +						    GFP_KERNEL | __GFP_NOWARN);
> > +			if (!vec->deferred)
> > +				goto out_free_pgvec;
> > +			vec->deferred->vec = vec;
> 
> The nested structures are fairly complex.
> 
> Would it make sense to avoid the separate packet_pg_vec_free, fold
> that into packet_pg_vec and use a different field to identify
> whether vmalloc backed pages are used. Maybe sk, or even a new
> boolean field has_vmalloc, for readability

To be clear, these are questions, not blocking issues.

Reviewed-by: Willem de Bruijn <willemb@google.com>

