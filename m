Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B8E44605E
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385022; cv=none; b=Ve7yik0Gq6A/y6nVodm8zc/b6/xHf9aFePhNV3r+d1LPNcex+5xMOQZYwikrZRtY/xbET/TxEX2xpNCo2on20U638PbZKF2dwVHWaDn2ctVO4R5BoSGDElmitY0py6NJrWE9IT56HnlgC1RhUzGWKOMAyTQy0ZkneGDW8LHhc/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385022; c=relaxed/simple;
	bh=TK2cRi4Qw+UhPK9QoB6niFeTwi3yGvQHJHbQPYWSBkw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqxjxaT8zwoF9pTrzKdxQAHv/ZG9i3JERC1pxohJqgax0/bhXPgGVWtBKapKvrIcBE0xCs25lSlPw5o5VtZuirU9toriBynMwcGtipR5/PsbU2sCOoGNlnf7OId3lYS1SIXR3NgzaPQp0KNT0/byrHEVsVOrGRS+Qn52NUk68T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ptV7sQBs; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ptV7sQBs"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A681020758;
	Mon, 14 Sep 2026 13:23:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9nu7SWvYf7Xy; Mon, 14 Sep 2026 13:23:34 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D692520754;
	Mon, 14 Sep 2026 13:23:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D692520754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1789385014;
	bh=wmW4DFy0DvYGUe06ij/9kgUhx+OSXYUWY9cOivkkpm0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=ptV7sQBsRiOS/VJea7paPn/WYlx4ghb9+bIZidaQm7uuqcA1C8k/fthtEFBsxpdrW
	 RRBzQHkowXErELtf+2Yj+d9VwM0KlaSq//2m+TuFbi1esUp2ocRg2u24T2PNrSdsyr
	 d/yw5TPPERb0oJ3XtB/s6pA4noJ/fU9yQPFC4IC3ZUhumD/IN32eZxsMAklWEzr6u1
	 eZnUB3FjLJhRdCH/ThZW9ZiqBbbjidnNQ9zuqrZDTrwijBtFoLK2P/G1LHHu00Yb0s
	 u0BTbfa83lK4Cjoumqslp3PEgZr+2Zv3hEnM6xaXWifAbak+9iB/QJ2K/mkxztWtVs
	 RwFELFSs5+Yrg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 14 Sep
 2026 13:23:34 +0200
Received: (nullmailer pid 1958502 invoked by uid 1000);
	Mon, 14 Sep 2026 11:23:33 -0000
Date: Mon, 14 Sep 2026 13:23:33 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>, Chengfeng Ye <nicoyip.dev@gmail.com>
Subject: Re: [PATCH 02/12] xfrm: serialize state GC with device state flush
Message-ID: <aqfZNeR58HLm2x1o@secunet.com>
References: <20260907093020.2228346-3-steffen.klassert@secunet.com>
 <20260908224854.1591115-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908224854.1591115-1-kuba@kernel.org>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

Ccing Author of the patch.

On Tue, Sep 08, 2026 at 03:48:54PM -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> xfrm: serialize state GC with device state flush
> 
> This adds a global mutex, xfrm_state_gc_mutex, taken by the state GC worker
> around xfrm_state_gc_destroy() and by the deferred-device pass of
> xfrm_dev_state_flush(), so the two paths no longer run xfrm_dev_state_free()
> on the same state concurrently.  The KASAN slab-use-after-free reported in
> xfrm_dev_state_free() from xfrm_dev_state_flush() is addressed by that
> serialization.
> 
> > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> > index 36a4f6793edef..de097bba803b7 100644
> > --- a/net/xfrm/xfrm_state.c
> > +++ b/net/xfrm/xfrm_state.c
> > @@ -226,6 +226,7 @@ static struct xfrm_state_afinfo __rcu *xfrm_state_afinfo[NPROTO];
> >  
> >  static DEFINE_SPINLOCK(xfrm_state_gc_lock);
> >  static DEFINE_SPINLOCK(xfrm_state_dev_gc_lock);
> > +static DEFINE_MUTEX(xfrm_state_gc_mutex);
> >  
> >  int __xfrm_state_delete(struct xfrm_state *x);
> >  
> > @@ -632,8 +633,10 @@ static void xfrm_state_gc_task(struct work_struct *work)
> >  
> >  	synchronize_rcu();
> >  
> > +	mutex_lock(&xfrm_state_gc_mutex);
> >  	hlist_for_each_entry_safe(x, tmp, &gc_list, gclist)
> >  		xfrm_state_gc_destroy(x);
> > +	mutex_unlock(&xfrm_state_gc_mutex);
> >  }
> >  
> >  static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
> > @@ -1000,6 +1003,7 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
> >  out:
> >  	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
> >  
> > +	mutex_lock(&xfrm_state_gc_mutex);
> >  	spin_lock_bh(&xfrm_state_dev_gc_lock);
> >  restart_gc:
> >  	hlist_for_each_entry_safe(x, tmp, &xfrm_state_dev_gc_list, dev_gclist) {
> 
> [Severity: High]
> Is the new mutex enough to cover every xfrm_dev_state_free() caller?  There
> is a third caller in the acquire path in xfrm_state_find() that takes
> neither the new mutex nor RTNL:
> 
> net/xfrm/xfrm_state.c:xfrm_state_find() {
> 	...
> #ifdef CONFIG_XFRM_OFFLOAD
> 		struct xfrm_dev_offload *xso = &x->xso;
> 
> 		if (xso->type == XFRM_DEV_OFFLOAD_PACKET) {
> 			xfrm_dev_state_delete(x);
> 			xfrm_dev_state_free(x);
> 		}
> #endif
> 	...
> }
> 
> That code runs inside the rcu_read_lock() taken earlier in
> xfrm_state_find() (it uses xfrm_state_hold_rcu() on the found state), so it
> cannot take a sleeping mutex even if one were added there.

That just pointed me to the xfrm_dev_state_free callback of the bonding driver,
it uses a mutex. But this is a different issue.

> 
> xfrm_dev_state_delete() publishes x on the global, reference-less device GC
> list while xso->dev is still set:
> 
> net/xfrm/xfrm_state.c:xfrm_dev_state_delete() {
> 	if (dev) {
> 		dev->xfrmdev_ops->xdo_dev_state_delete(dev, x);
> 		spin_lock_bh(&xfrm_state_dev_gc_lock);
> 		hlist_add_head(&x->dev_gclist, &xfrm_state_dev_gc_list);
> 		spin_unlock_bh(&xfrm_state_dev_gc_lock);
> 	}
> }
> 
> so the deferred pass added here, which matches only on xso->dev == dev, can
> pick up the same state and call xfrm_dev_state_free() on it in parallel:
> 
>   CPU 0 (xfrm_state_find(), packet offload, km_query() failed)
>   xfrm_dev_state_delete(x)		/* x now on xfrm_state_dev_gc_list */
>   xfrm_dev_state_free(x)
>     dev = READ_ONCE(xso->dev)		/* non-NULL */
> 
>   CPU 1 (xfrm_dev_event() -> xfrm_dev_state_flush(), same dev)
>   mutex_lock(&xfrm_state_gc_mutex)
>   finds x, xso->dev == dev
>   spin_unlock_bh(&xfrm_state_dev_gc_lock)
>   xfrm_dev_state_free(x)
>     dev = READ_ONCE(xso->dev)		/* also non-NULL */
> 
> Can both CPUs then run the driver callback and the device put twice?
> 
> net/xfrm/xfrm_state.c:xfrm_dev_state_free() {
> 	if (dev && dev->xfrmdev_ops) {
> 		spin_lock_bh(&xfrm_state_dev_gc_lock);
> 		if (!hlist_unhashed(&x->dev_gclist))
> 			hlist_del(&x->dev_gclist);
> 		spin_unlock_bh(&xfrm_state_dev_gc_lock);
> 
> 		if (dev->xfrmdev_ops->xdo_dev_state_free)
> 			dev->xfrmdev_ops->xdo_dev_state_free(dev, x);
> 		WRITE_ONCE(xso->dev, NULL);
> 		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
> 		netdev_put(dev, &xso->dev_tracker);
> 	}
> }
> 
> The hlist_unhashed() test only guards the list removal, not
> xdo_dev_state_free() or netdev_put(), and dev is sampled before the
> spinlock, so a double driver teardown and a net_device refcount underflow
> look possible.
> 
> Also, since hlist_del() is used rather than hlist_del_init(), does the
> second caller see the poisoned pprev as still hashed and call __hlist_del()
> again, writing through LIST_POISON2?
> 
> This is the same failure mode the commit message describes:
> 
>   "Both paths can invoke the driver callback and drop the device reference."
> 
> Would addressing the root cause the commit message names -- "The device GC
> list does not hold an xfrm_state reference" -- be a better fit, either by
> taking an xfrm_state reference for the device GC list, or by making the
> release in xfrm_dev_state_free() idempotent (test-and-clear of xso->dev plus
> hlist_del_init() under xfrm_state_dev_gc_lock)?  That would also cover the
> xfrm_state_find() caller, which cannot participate in a mutex-based scheme.

This approach can indeed not solve the problem completely. I tend to
revert this one in favor of a fix with the above approach. This is
the destruction path, so a refcount would probably not harm too
much.

Chengfeng, can you have a look at this?
