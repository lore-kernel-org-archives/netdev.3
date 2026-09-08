Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F39459D63F
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907744; cv=none; b=s/Y1tnNAlmUKJWXoNur9eyx6Fb947sYbsOMduYm/x7B8sNDD5itlNkGEsWHwHeZVxvV9T4B+mj3No5+lI+Yyi0ETpQctp6L/E67JppUVXT0m7styQOI96n2RayghPCf6VvWwSX15McqoQGTI5fct27jElkH19w8pmfqQtd5ImX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907744; c=relaxed/simple;
	bh=fU2u7hy3bOUzEcv0iSH0XfbQyxzGXEH4rCehpMOpSzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYFhDUz+r7RtAZM9g4Eu8a/XSL2JIUPR0Zp6lDbnpk0hkJCLcd/Ey6F+BHOY59W61wjX4dkMUtEFgsI9+yE8EC1U0DT3szwfQ28vub+RCzZ4Va24urNG1msHNi50A/+QYTPcjIISnfGC+Jt+tJLMaTKvaUJtVaMfIX1HE7+FrRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0yjPGkx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0yjPGkx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124EF1F00A3D;
	Tue,  8 Sep 2026 22:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907735;
	bh=2QfZk9RfFjFZuTm5Thf1TLno1ktUCon+oFASO1azv0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q0yjPGkx54JFX5A+x1uPQZWXiPL+2iWhN1EAgdz0wzlbWnDoclZ5Ryi4IafWLSKQe
	 ofsrsG57a5J25b1v1cs3EWKceLH0HALc6t/SKbnMoyq3BwXokvu3ujRWvyh7BBLAD8
	 HTS2DtQInXe/zxLecavyfrm94GmI/KN7TzyZS3JOUVky57gv/DK3juA3i1iNTHTAt2
	 UqXeuX2qOwyDhFvqcmiw8oAtSqoFfTZwWq23l+wWZk/HZmmxl4SCW1zqavYM5H/gOY
	 /9rLqAtIOv/4SReua1vxto5mfDQb+qhtgSLm3jZzGCatgl4AhJJpke8w2v2R3+cq7/
	 98HfTe0VTMv4w==
From: Jakub Kicinski <kuba@kernel.org>
To: steffen.klassert@secunet.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	herbert@gondor.apana.org.au,
	netdev@vger.kernel.org
Subject: Re: [PATCH 02/12] xfrm: serialize state GC with device state flush
Date: Tue,  8 Sep 2026 15:48:54 -0700
Message-ID: <20260908224854.1591115-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907093020.2228346-3-steffen.klassert@secunet.com>
References: <20260907093020.2228346-3-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
xfrm: serialize state GC with device state flush

This adds a global mutex, xfrm_state_gc_mutex, taken by the state GC worker
around xfrm_state_gc_destroy() and by the deferred-device pass of
xfrm_dev_state_flush(), so the two paths no longer run xfrm_dev_state_free()
on the same state concurrently.  The KASAN slab-use-after-free reported in
xfrm_dev_state_free() from xfrm_dev_state_flush() is addressed by that
serialization.

> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 36a4f6793edef..de097bba803b7 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -226,6 +226,7 @@ static struct xfrm_state_afinfo __rcu *xfrm_state_afinfo[NPROTO];
>  
>  static DEFINE_SPINLOCK(xfrm_state_gc_lock);
>  static DEFINE_SPINLOCK(xfrm_state_dev_gc_lock);
> +static DEFINE_MUTEX(xfrm_state_gc_mutex);
>  
>  int __xfrm_state_delete(struct xfrm_state *x);
>  
> @@ -632,8 +633,10 @@ static void xfrm_state_gc_task(struct work_struct *work)
>  
>  	synchronize_rcu();
>  
> +	mutex_lock(&xfrm_state_gc_mutex);
>  	hlist_for_each_entry_safe(x, tmp, &gc_list, gclist)
>  		xfrm_state_gc_destroy(x);
> +	mutex_unlock(&xfrm_state_gc_mutex);
>  }
>  
>  static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
> @@ -1000,6 +1003,7 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
>  out:
>  	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
>  
> +	mutex_lock(&xfrm_state_gc_mutex);
>  	spin_lock_bh(&xfrm_state_dev_gc_lock);
>  restart_gc:
>  	hlist_for_each_entry_safe(x, tmp, &xfrm_state_dev_gc_list, dev_gclist) {

[Severity: High]
Is the new mutex enough to cover every xfrm_dev_state_free() caller?  There
is a third caller in the acquire path in xfrm_state_find() that takes
neither the new mutex nor RTNL:

net/xfrm/xfrm_state.c:xfrm_state_find() {
	...
#ifdef CONFIG_XFRM_OFFLOAD
		struct xfrm_dev_offload *xso = &x->xso;

		if (xso->type == XFRM_DEV_OFFLOAD_PACKET) {
			xfrm_dev_state_delete(x);
			xfrm_dev_state_free(x);
		}
#endif
	...
}

That code runs inside the rcu_read_lock() taken earlier in
xfrm_state_find() (it uses xfrm_state_hold_rcu() on the found state), so it
cannot take a sleeping mutex even if one were added there.

xfrm_dev_state_delete() publishes x on the global, reference-less device GC
list while xso->dev is still set:

net/xfrm/xfrm_state.c:xfrm_dev_state_delete() {
	if (dev) {
		dev->xfrmdev_ops->xdo_dev_state_delete(dev, x);
		spin_lock_bh(&xfrm_state_dev_gc_lock);
		hlist_add_head(&x->dev_gclist, &xfrm_state_dev_gc_list);
		spin_unlock_bh(&xfrm_state_dev_gc_lock);
	}
}

so the deferred pass added here, which matches only on xso->dev == dev, can
pick up the same state and call xfrm_dev_state_free() on it in parallel:

  CPU 0 (xfrm_state_find(), packet offload, km_query() failed)
  xfrm_dev_state_delete(x)		/* x now on xfrm_state_dev_gc_list */
  xfrm_dev_state_free(x)
    dev = READ_ONCE(xso->dev)		/* non-NULL */

  CPU 1 (xfrm_dev_event() -> xfrm_dev_state_flush(), same dev)
  mutex_lock(&xfrm_state_gc_mutex)
  finds x, xso->dev == dev
  spin_unlock_bh(&xfrm_state_dev_gc_lock)
  xfrm_dev_state_free(x)
    dev = READ_ONCE(xso->dev)		/* also non-NULL */

Can both CPUs then run the driver callback and the device put twice?

net/xfrm/xfrm_state.c:xfrm_dev_state_free() {
	if (dev && dev->xfrmdev_ops) {
		spin_lock_bh(&xfrm_state_dev_gc_lock);
		if (!hlist_unhashed(&x->dev_gclist))
			hlist_del(&x->dev_gclist);
		spin_unlock_bh(&xfrm_state_dev_gc_lock);

		if (dev->xfrmdev_ops->xdo_dev_state_free)
			dev->xfrmdev_ops->xdo_dev_state_free(dev, x);
		WRITE_ONCE(xso->dev, NULL);
		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
		netdev_put(dev, &xso->dev_tracker);
	}
}

The hlist_unhashed() test only guards the list removal, not
xdo_dev_state_free() or netdev_put(), and dev is sampled before the
spinlock, so a double driver teardown and a net_device refcount underflow
look possible.

Also, since hlist_del() is used rather than hlist_del_init(), does the
second caller see the poisoned pprev as still hashed and call __hlist_del()
again, writing through LIST_POISON2?

This is the same failure mode the commit message describes:

  "Both paths can invoke the driver callback and drop the device reference."

Would addressing the root cause the commit message names -- "The device GC
list does not hold an xfrm_state reference" -- be a better fit, either by
taking an xfrm_state reference for the device GC list, or by making the
release in xfrm_dev_state_free() idempotent (test-and-clear of xso->dev plus
hlist_del_init() under xfrm_state_dev_gc_lock)?  That would also cover the
xfrm_state_find() caller, which cannot participate in a mutex-based scheme.

For reference, no later commit in this series through 231bb4a13161 changes
xfrm_dev_state_free(), xfrm_dev_state_delete() or the xfrm_state_find() call
site.

> @@ -1014,6 +1018,7 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
>  
>  	}
>  	spin_unlock_bh(&xfrm_state_dev_gc_lock);
> +	mutex_unlock(&xfrm_state_gc_mutex);
>  
>  	xfrm_flush_gc();
>
