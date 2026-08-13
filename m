Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580E2E7F2C;
	Thu, 13 Aug 2026 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786580921; cv=none; b=KfSGFOofDEAuK5xPO3RSwUXLEL9HOBEji29aOmJ+UYLX/eBPtyeD2y+PSYeIXoMtmhtvsPxvmmVbEdzx1p7H1lefnEkQq46wZHRcjzMuJOHbJBfWv/KpuaghmpAn67u0G2n+YpF0IKWdTcMBeIYbDj1XKQRNeDmaayrsgkmBKfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786580921; c=relaxed/simple;
	bh=H/ebTlFxInjK7fM6SornXlXjsO8QPIMpwAbdEajg8Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qd5fKS5sSyvZqtnkvFnChORZf/d7nOQfWNXFNXVjmSO/NfegO5otP+kB+Rodrp1UV2pwTkC7KldjK1eOFGyw6SZBYKJ4Ppl4nBvKwgfPpNQ5oLDOwXxWVfP98MYTWIlKJKMtqNzxGMd735XoIt1VpdVNzfq9AoQjadz2GStBf/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXGJFbZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXGJFbZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CAE1F000E9;
	Thu, 13 Aug 2026 00:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786580917;
	bh=qqcMGsJFAEdodLfyBLNvxsNHdwEdDO235U3MgKO0YHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXGJFbZh+btJJxuA/GU6wi8iDsyO2euWPXmXkMWIfYCxzh+PzX5UCtJiTGIYNGeRm
	 zs14t1td1OYBsBGHIJspubY74tfuLqoiR1n9eUWRBUCFOOrKRC4jLBxv/zEGwA/OwM
	 sC8blG/Ua1q6UR43GSmvOmZ5MxNAFpQs5BW+JC56MpsCokksHfDaMYjZvI1dgItqZL
	 yr4ehTHNkOZJGjP6chbaqt3mBvxSRK+4j4MO/BMo+GYMqPcDd6/y+pOD4KFFVpTqcx
	 oqH9p+N3yRxCHFVjJPyLNQx0QfAIkTiVRJbybT2a3VBnAyDkuHcbkCc1SKquapVJkD
	 WU3iquW2L0SPA==
From: Jakub Kicinski <kuba@kernel.org>
To: shivajikant@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	praan@google.com,
	almasrymina@google.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	bobbyeshleman@meta.com,
	sdf@fomichev.me,
	dtatulea@nvidia.com,
	kees@kernel.org,
	devnexen@gmail.com,
	yuehaibing@huawei.com,
	daniel@iogearbox.net,
	razor@blackwall.org,
	dw@davidwei.uk,
	maoyixie.tju@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: convert netdev_nl_sock bindings list to xarray
Date: Wed, 12 Aug 2026 17:28:36 -0700
Message-ID: <20260813002836.2247842-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811142958.160088-1-shivajikant@google.com>
References: <20260811142958.160088-1-shivajikant@google.com>
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
net: convert netdev_nl_sock bindings list to xarray

This converts netdev_nl_sock.bindings from a struct list_head to a struct
xarray keyed by binding->id, replaces binding->list with a back pointer
binding->sock_priv, and removes the per-socket priv->lock mutex from the
bind-rx, bind-tx and sock priv init/destroy paths.

Link (v1): https://lore.kernel.org/all/20260810065759.3735934-1-shivajikant@google.com/

A few questions below.

> Since list modifications and iterations are not concurrency-safe,
> priv->lock was introduced to serialize operations on priv->bindings.
> However, xarray manages its own internal locking (xa_lock) for store,
> erase, and iteration operations.

[Severity: Low]
Is the "iteration" part of this accurate?  xa_for_each() in the rewritten
netdev_nl_sock_priv_destroy() expands to xa_find()/xa_find_after(), which
take and drop only rcu_read_lock() internally and hold no lock at all
across the caller's loop body:

lib/xarray.c:xa_find() {
	...
	rcu_read_lock();
	do { ... } while (xas_retry(&xas, entry));
	rcu_read_unlock();
	...
}

The loop body in netdev_nl_sock_priv_destroy() sleeps:

	xa_for_each(&priv->bindings, xa_idx, binding) {
		mutex_lock(&binding->lock);
		...
		netdev_lock(dev);
		net_devmem_unbind_dmabuf(binding);   /* synchronize_net() */

so xa_lock does not cover any of that.

Also, in the baseline priv->lock was taken before
netdev_get_by_index_lock() and dropped only after the whole bind sequence
(net_devmem_bind_dmabuf() plus the entire net_devmem_bind_dmabuf_to_queue()
loop), i.e. it serialized the complete bind operation rather than just the
list insertion.

Could the changelog say that the serialization scope of the whole doit is
being reduced, instead of describing this as a mechanical list-to-xarray
conversion?

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index f4d60654ce7f..c620d986c418 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -136,8 +136,8 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  	 */
>  	synchronize_net();
>  
> -	if (binding->list.next)
> -		list_del(&binding->list);
> +	if (binding->sock_priv)
> +		xa_erase(&binding->sock_priv->bindings, binding->id);

[Severity: Low]
Can this erase remove a different binding's entry?  priv->bindings is now
keyed by the global ID allocated in net_devmem_bind_dmabuf():

	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
			      binding, xa_limit_32b, &id_alloc_next,
			      GFP_KERNEL);

and net_devmem_unbind_dmabuf() releases that global ID first:

	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
	synchronize_net();
	if (binding->sock_priv)
		xa_erase(&binding->sock_priv->bindings, binding->id);

Between the global xa_erase() and the per-socket xa_erase() the ID is a
free slot in the global allocator, and synchronize_net() sleeps in that
window.  If a concurrent bind on the same socket is handed the recycled ID,
its xa_store(&priv->bindings, binding->id, binding, GFP_KERNEL) overwrites
the dying binding's entry (the returned old entry is only tested with
xa_is_err()), and the dying binding's xa_erase() then drops the new
binding from priv->bindings.  The new binding would no longer be visible to
netdev_nl_sock_priv_destroy(), leaving the dma-buf attachment and the rx
queue memory provider installed, and binding->sock_priv dangling once the
netlink sock priv is freed.

With the embedded list_head, list_del(&binding->list) operated on the
binding's own node, so unlinking a different binding was not possible.

Reaching this requires the cyclic allocator to wrap the 32-bit ID space
(__xa_alloc_cyclic() searches [*next, UINT_MAX] before falling back to
limit.min), so it is hard to hit in practice.  Would erasing from
priv->bindings before releasing the global ID, and clearing
binding->sock_priv, make the ordering safe regardless?

[ ... ]

> @@ -332,10 +333,17 @@ net_devmem_bind_dmabuf(struct net_device *dev, void *vdev,
>  	if (err < 0)
>  		goto err_free_chunks;
>  
> -	list_add(&binding->list, &priv->bindings);
> +	binding->sock_priv = priv;
> +	res = xa_store(&priv->bindings, binding->id, binding, GFP_KERNEL);
> +	if (xa_is_err(res)) {
> +		err = xa_err(res);
> +		goto err_erase_dmabuf_bindings;
> +	}
>  
>  	return binding;
>  
> +err_erase_dmabuf_bindings:
> +	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
>  err_free_chunks:
>  	gen_pool_for_each_chunk(binding->chunk_pool,
>  				net_devmem_dmabuf_free_chunk_owner, NULL);

[Severity: High]
Can this new error path free a binding that is still reachable by a
concurrent lookup?

At the point xa_store() runs, the preceding xa_alloc_cyclic() has already
published the binding in the global net_devmem_dmabuf_bindings xarray, so
net_devmem_lookup_dmabuf() can find it:

net/core/devmem.c:net_devmem_lookup_dmabuf() {
	rcu_read_lock();
	binding = xa_load(&net_devmem_dmabuf_bindings, id);
	if (binding) {
		if (!net_devmem_dmabuf_binding_get(binding))
			binding = NULL;
	}
	rcu_read_unlock();
	...
}

This is reached from tcp_sendmsg_locked() via net_devmem_get_binding() with
a user supplied dmabuf id.

err_erase_dmabuf_bindings only does a bare xa_erase() and then falls into
the pre-publish teardown ladder: gen_pool_destroy(), kvfree(tx_vec),
dma_buf_unmap_attachment_unlocked(), dma_buf_detach(),
percpu_ref_exit(&binding->ref), kfree(binding).  There is no
synchronize_net() and no percpu_ref_kill(), which is exactly what
net_devmem_unbind_dmabuf() documents as required for a published binding:

net/core/devmem.c:net_devmem_unbind_dmabuf() {
	xa_erase(&net_devmem_dmabuf_bindings, binding->id);

	/* Ensure no tx net_devmem_lookup_dmabuf() are in flight after the
	 * erase.
	 */
	synchronize_net();
	...
	percpu_ref_kill(&binding->ref);
}

Since the ref is never killed, a racing lookup's percpu_ref_tryget()
succeeds, and since the free is immediate the racing thread can touch
&binding->ref after kfree(), later call net_devmem_dmabuf_binding_put() on
an already percpu_ref_exit()ed and freed ref, and for a tx binding walk a
freed tx_vec whose DMA mapping is already torn down.

The failure point is new: before this patch list_add() could not fail, so
there was no error exit between xa_alloc_cyclic() and the successful
return.  Should this path call net_devmem_unbind_dmabuf(binding) instead,
or store into priv->bindings before publishing the binding globally?

Entering the path needs the GFP_KERNEL xarray node allocation to fail, so
it takes memory pressure in addition to the race.

[ ... ]
-- 
pw-bot: cr
