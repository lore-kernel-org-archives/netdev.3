Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7BA35FF58
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786690170; cv=pass; b=m+kNmUfTks3Uqec0fdz76/G+n3rnwOnqq/75QfUzek5yPovcdpjE7NgMgCXGLwyqBWfgGAP9eMcxFPGllxZ+zap5Ji5C/ml1RKJb1mmBvwmqBLK2XnRxyVe9L+yRwezo1+Aa1HhwLxmYrotNFZJhAxMR7zYVdV3P5LtHwekbdAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786690170; c=relaxed/simple;
	bh=vcptvnOtm4+OHwZFFsFDoq6lXcBXtklPeZ6XXfS1mrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zk6mu9fgC1jA2QivxgNiT1yXjhTqqxhLqlzP77JLp7SBLfZyNil56az4jj23n287vphxCaTIvgTrP2FxMowP9rqyj4+DmWdVHKJAVzTKiUUFJIFP+d7q1DQQyyecK9jmOZ3EGVTXSWiLSjHSI894/zJjLTZMkn3gkzELhBNvyzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CIgTbRoZ; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CIgTbRoZ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c10ed63c0so118551cf.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 23:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786690166; cv=none;
        d=google.com; s=arc-20260327;
        b=XeK3N4yCe4Zl3GrCnSBO8yRUUG6mYRHkl8b2klEuSwFqZAdWqORkDMzm79atbOceAw
         bMCzzGy5fxEDA9s41Khe0ZgurKrG6D/WD/ADCcd1JYjBTZy+cfEXelfi+3tjKAqBsi78
         bTzLD6VUX5+W7nqVWLuuxGkAcwXAKajCsekdO/t52W1zcGqs21q3FuHAWIVjgic3hYVV
         QfPvwQptcVZ/muQv/NLO5NjoyL853SQ/kTpC4iHBU3HjA9e6EzVJHVtT96bIbZr4eeK2
         hTATgCWVfnagylP50mcuaLfwOVAsD0vhGXnYm3r2xD3BrniC+jm3lhRV1ijZX33+BlS+
         bLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AR0O0UjY0VwXQvIaVF3zP5j5SN6QerzKiz0VCpKHqng=;
        fh=K08BrjtsNcucDMd9rawKzKlrtbwKxseUGCaoJja/cy4=;
        b=gspmzZHM25ggyKZIb2LXAbfE38gIidP1f57p9d5//9E86NcUUyRsQGvUU4HoByIB0O
         uwc7QBanIq+ywPTOS3Z551ckxUBhP6+SX2imNw+QKzMW9AVhJ2gmHFix2DsP7cbvZm9N
         9aXThbemCYQ5bKAStyMAccOJu1P4BPxplPtKeAomFLBlPUEwvds6oUTs+cI3SPfO00j+
         fGPwss9ll1GGQ9uLL63wdxC4eb5/YiQLvbo3PrVdIdVvnpGu+kqt8pkb1KlfNTT8qm0b
         BbpecH8ngmh1mbZj8vR7IPUnDSBfHUpzb7eNhVj7Vkhi9XY0kDQL25pMtd20gkgkuucd
         iC7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786690166; x=1787294966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AR0O0UjY0VwXQvIaVF3zP5j5SN6QerzKiz0VCpKHqng=;
        b=CIgTbRoZD3H0elpRyjT9dIi+67BpfPjl9J2fbSyr7DFZ5CLVGfYWeFSqQqeaBu0Q2P
         +Xmw0ve8RlnEmrj/JWltDao2ItrkUsrZKz3PAfx1aWcvmuFNs2dMKJgwF/0C0mFqHVb3
         zgGvQH/LAHFpXReqLajnkFBTTWuhG8hJVT0XE+omQuGJ6NetT7rfVqgFmFaB3V57L2Ja
         7rV6O3u7kjc/rbhscb+9DWxYmgRV4KKETrfV9EemqYE5GYuHcQvta5f6vM7SwhxJgZHh
         4zWVe1CPJzWpKDiXLEG3wG7HBRkDLYl1XLM1gtpiEr1bxwZps6X9m0vIZlBYQlT388Cy
         jpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786690166; x=1787294966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AR0O0UjY0VwXQvIaVF3zP5j5SN6QerzKiz0VCpKHqng=;
        b=iCyG+dYswHDBXWDdIeAb+nZPdYUz5/fwTrKor6Bx3asoklWWGeSviGIk5kU5dsfVt1
         65P4UiSaVXsPDIofNmYqi7JE+3KspcSlnHbXBPWTCLZqEByYk4uNVxtFvHzq5SoyrNV3
         +YBtlKzz5nKhKaAtKOySkrMmZFxjz4VwP46kOQbcuZ1VmouzWteY7mZi1BxUlfK9rYr9
         8+4iSZtOj1oiFPU7/yJ4CdT0j6InGmcV8fSkGYP+1GT9Xos7cGsvr27PwL6VxijgM0BG
         4geZA6uDxdkoiDGJDt+jP40ZPG3bGuTTIsGnB92mUfGyeH3NaiHEydP6xyapiQqovcSp
         MwZg==
X-Gm-Message-State: AOJu0Yzpn8vP2zWs2uJO50T40LzqO4oGzqbhsdbGTaQkqyq8EEG0YMOu
	H/Uf178C3mmiej60fajRGjbG45e/0S+Jaoyzcq/HILXsW1ibkqzX+tKiTcr/Y51wXPpCKXVHH3P
	OJQ/efSgpntPIxw+/4D05UqmRs5np+eR4k8iZLCgt
X-Gm-Gg: AR+sD109Qn31AaRozzgaHJhMAX5s8Vz+YvBvxWX/OsVhoy5DCGeYkriPLFZVT10smmF
	ltSikwx4KNTgnnr+u9BJ2VRgDt0OnEOD9EQxRbuIz1myJoxDoLqVF7kYwv9UsQKn1TRfqgtKPw+
	iKal6wAtySJt9TGeukMh6dS86LrGRUMp0IcxYTeJ1a4KYMptPNjzVaHmVEhtiLmuSvPkLnr3dGY
	zkte59zOe8kSxFbdLfLbOlfnpH0Cju4qUuaCp2QqyagyB4yFep6skl1WJ21l2xdbgjOwduWeTzB
	9AgT6+O4gSNQ12VKfI2nTXyWzW09Kljd9yO/NIvI39kIL+XNW9t75orYudQlH29huH4H29nUybV
	dBhPlW0n3geTKXQHwNBh3yWY9E3skKc620A==
X-Received: by 2002:a05:622a:2597:b0:51c:ad5:93be with SMTP id
 d75a77b69052e-52d8476b6c0mr13156411cf.8.1786690165896; Thu, 13 Aug 2026
 23:49:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811142958.160088-1-shivajikant@google.com> <20260813002836.2247842-1-kuba@kernel.org>
In-Reply-To: <20260813002836.2247842-1-kuba@kernel.org>
From: Shivaji Kant <shivajikant@google.com>
Date: Fri, 14 Aug 2026 12:19:14 +0530
X-Gm-Features: AUfX_mwkDFnvtAfQcrti6SS5ovM24hZeJYznk3lsCDO-qOp-2cCBxEYvX9otrdY
Message-ID: <CAMEhMpkqRYUaf39bRObW2NAFErii+_HENBZc9m+jW5UULKpqGA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: convert netdev_nl_sock bindings list to xarray
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, praan@google.com, almasrymina@google.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	bobbyeshleman@meta.com, sdf@fomichev.me, dtatulea@nvidia.com, kees@kernel.org, 
	devnexen@gmail.com, yuehaibing@huawei.com, daniel@iogearbox.net, 
	razor@blackwall.org, dw@davidwei.uk, maoyixie.tju@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 5:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> net: convert netdev_nl_sock bindings list to xarray
>
> This converts netdev_nl_sock.bindings from a struct list_head to a struct
> xarray keyed by binding->id, replaces binding->list with a back pointer
> binding->sock_priv, and removes the per-socket priv->lock mutex from the
> bind-rx, bind-tx and sock priv init/destroy paths.
>
> Link (v1): https://lore.kernel.org/all/20260810065759.3735934-1-shivajika=
nt@google.com/
>
> A few questions below.
>
> > Since list modifications and iterations are not concurrency-safe,
> > priv->lock was introduced to serialize operations on priv->bindings.
> > However, xarray manages its own internal locking (xa_lock) for store,
> > erase, and iteration operations.
>
> [Severity: Low]
> Is the "iteration" part of this accurate?  xa_for_each() in the rewritten
> netdev_nl_sock_priv_destroy() expands to xa_find()/xa_find_after(), which
> take and drop only rcu_read_lock() internally and hold no lock at all
> across the caller's loop body:
>
> lib/xarray.c:xa_find() {
>         ...
>         rcu_read_lock();
>         do { ... } while (xas_retry(&xas, entry));
>         rcu_read_unlock();
>         ...
> }
>
> The loop body in netdev_nl_sock_priv_destroy() sleeps:
>
>         xa_for_each(&priv->bindings, xa_idx, binding) {
>                 mutex_lock(&binding->lock);
>                 ...
>                 netdev_lock(dev);
>                 net_devmem_unbind_dmabuf(binding);   /* synchronize_net()=
 */
>
> so xa_lock does not cover any of that.
>
> Also, in the baseline priv->lock was taken before
> netdev_get_by_index_lock() and dropped only after the whole bind sequence
> (net_devmem_bind_dmabuf() plus the entire net_devmem_bind_dmabuf_to_queue=
()
> loop), i.e. it serialized the complete bind operation rather than just th=
e
> list insertion.
>
> Could the changelog say that the serialization scope of the whole doit is
> being reduced, instead of describing this as a mechanical list-to-xarray
> conversion?
>

The observation that the loop body sleeps without holding the xarray
lock is exactly why this conversion provides a functional benefit. I
can reword the changelog in v3 to make it clear that the intentional
goal is to reduce the serialization scope of the entire doit sequence.

> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index f4d60654ce7f..c620d986c418 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -136,8 +136,8 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dma=
buf_binding *binding)
> >        */
> >       synchronize_net();
> >
> > -     if (binding->list.next)
> > -             list_del(&binding->list);
> > +     if (binding->sock_priv)
> > +             xa_erase(&binding->sock_priv->bindings, binding->id);
>
> [Severity: Low]
> Can this erase remove a different binding's entry?  priv->bindings is now
> keyed by the global ID allocated in net_devmem_bind_dmabuf():
>
>         err =3D xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id=
,
>                               binding, xa_limit_32b, &id_alloc_next,
>                               GFP_KERNEL);
>
> and net_devmem_unbind_dmabuf() releases that global ID first:
>
>         xa_erase(&net_devmem_dmabuf_bindings, binding->id);
>         synchronize_net();
>         if (binding->sock_priv)
>                 xa_erase(&binding->sock_priv->bindings, binding->id);
>
> Between the global xa_erase() and the per-socket xa_erase() the ID is a
> free slot in the global allocator, and synchronize_net() sleeps in that
> window.  If a concurrent bind on the same socket is handed the recycled I=
D,
> its xa_store(&priv->bindings, binding->id, binding, GFP_KERNEL) overwrite=
s
> the dying binding's entry (the returned old entry is only tested with
> xa_is_err()), and the dying binding's xa_erase() then drops the new
> binding from priv->bindings.  The new binding would no longer be visible =
to
> netdev_nl_sock_priv_destroy(), leaving the dma-buf attachment and the rx
> queue memory provider installed, and binding->sock_priv dangling once the
> netlink sock priv is freed.
>
> With the embedded list_head, list_del(&binding->list) operated on the
> binding's own node, so unlinking a different binding was not possible.
>
> Reaching this requires the cyclic allocator to wrap the 32-bit ID space
> (__xa_alloc_cyclic() searches [*next, UINT_MAX] before falling back to
> limit.min), so it is hard to hit in practice.  Would erasing from
> priv->bindings before releasing the global ID, and clearing
> binding->sock_priv, make the ordering safe regardless?
>
> [ ... ]

Ack. While wrapping the 32 bit ID space exactly during the
synchronize_net() window is highly unlikely, it is possible and the
dangling pointer would be nasty. Reversing the erase ordering (erasing
from priv->bindings first) will guarantee this specific race cannot
happen. I will include this ordering fix in v3.

>
> > @@ -332,10 +333,17 @@ net_devmem_bind_dmabuf(struct net_device *dev, vo=
id *vdev,
> >       if (err < 0)
> >               goto err_free_chunks;
> >
> > -     list_add(&binding->list, &priv->bindings);
> > +     binding->sock_priv =3D priv;
> > +     res =3D xa_store(&priv->bindings, binding->id, binding, GFP_KERNE=
L);
> > +     if (xa_is_err(res)) {
> > +             err =3D xa_err(res);
> > +             goto err_erase_dmabuf_bindings;
> > +     }
> >
> >       return binding;
> >
> > +err_erase_dmabuf_bindings:
> > +     xa_erase(&net_devmem_dmabuf_bindings, binding->id);
> >  err_free_chunks:
> >       gen_pool_for_each_chunk(binding->chunk_pool,
> >                               net_devmem_dmabuf_free_chunk_owner, NULL)=
;
>
> [Severity: High]
> Can this new error path free a binding that is still reachable by a
> concurrent lookup?
>
> At the point xa_store() runs, the preceding xa_alloc_cyclic() has already
> published the binding in the global net_devmem_dmabuf_bindings xarray, so
> net_devmem_lookup_dmabuf() can find it:
>
> net/core/devmem.c:net_devmem_lookup_dmabuf() {
>         rcu_read_lock();
>         binding =3D xa_load(&net_devmem_dmabuf_bindings, id);
>         if (binding) {
>                 if (!net_devmem_dmabuf_binding_get(binding))
>                         binding =3D NULL;
>         }
>         rcu_read_unlock();
>         ...
> }
>
> This is reached from tcp_sendmsg_locked() via net_devmem_get_binding() wi=
th
> a user supplied dmabuf id.
>
> err_erase_dmabuf_bindings only does a bare xa_erase() and then falls into
> the pre-publish teardown ladder: gen_pool_destroy(), kvfree(tx_vec),
> dma_buf_unmap_attachment_unlocked(), dma_buf_detach(),
> percpu_ref_exit(&binding->ref), kfree(binding).  There is no
> synchronize_net() and no percpu_ref_kill(), which is exactly what
> net_devmem_unbind_dmabuf() documents as required for a published binding:
>
> net/core/devmem.c:net_devmem_unbind_dmabuf() {
>         xa_erase(&net_devmem_dmabuf_bindings, binding->id);
>
>         /* Ensure no tx net_devmem_lookup_dmabuf() are in flight after th=
e
>          * erase.
>          */
>         synchronize_net();
>         ...
>         percpu_ref_kill(&binding->ref);
> }
>
> Since the ref is never killed, a racing lookup's percpu_ref_tryget()
> succeeds, and since the free is immediate the racing thread can touch
> &binding->ref after kfree(), later call net_devmem_dmabuf_binding_put() o=
n
> an already percpu_ref_exit()ed and freed ref, and for a tx binding walk a
> freed tx_vec whose DMA mapping is already torn down.
>
> The failure point is new: before this patch list_add() could not fail, so
> there was no error exit between xa_alloc_cyclic() and the successful
> return.  Should this path call net_devmem_unbind_dmabuf(binding) instead,
> or store into priv->bindings before publishing the binding globally?
>
> Entering the path needs the GFP_KERNEL xarray node allocation to fail, so
> it takes memory pressure in addition to the race.
>
> [ ... ]

Missing the percpu_ref_kill() and synchronize_net() on the fast error
route indeed exposes a Use-After-Free if xa_store() fails and
net_devmem_lookup_dmabuf races it.
As suggested, explicitly calling net_devmem_unbind_dmabuf(binding) on
this error path should be the cleanest fix. It will pull the binding
out of the global registry and delegate the heavy teardown (and RCU
wait) to the async worker while correctly handling the reference
counts. I will route the xa_store() failure to
net_devmem_unbind_dmabuf(binding) in v3 to ensure it is handled
safely.

> --
> pw-bot: cr
