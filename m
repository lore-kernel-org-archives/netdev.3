Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125C2576EB5
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970034; cv=pass; b=a/jnj6BXJWJXnzSpkjiToaRCBhMohkcuybmnrYJZS2/kqJ4ebcHYP3hy9SF0QhDSUEQxABFRs2VcgCPbq150C9gclSqRNMNJIQjzLuw2bZO9uZwp5S2AMkKv7MR4MYNq6WQVvADIr4Y1WDnoc7FD0D3pg93Zbj/d3eqHIBhtkXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970034; c=relaxed/simple;
	bh=MKCSmzG+mmiHp1RSdzilQ2MMIn2OYW/LdktmIFMming=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlhy42YYDJDFoy3c/bavaoengrkqYrWMYVdK9qSu1/JB5TexsoLz4j+gRAGu4wLz4uP/4E3wF/ICZovXR0JgTWJZ+6OgCRGKICzkvlbIy1HcAxy6eNyaKCuodF0X/cyMatSfZCPt2XuJFvplQgMt2OVdVVPRDpWW9nwvvoWDyxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RsxFLdFg; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RsxFLdFg"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a613a6bcd8so12134a12.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 09:07:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788970030; cv=none;
        d=google.com; s=arc-20260327;
        b=C7tCmdUzoVn0wYzZRZfyqmyzRY7S3rIegiwA+ed2Afg2cuIA6VBmGsbZZprM0ul/nm
         JmpaL61w/TPIazVKtVjLbP4R38o1bGZXThfN7qZsplFm3uw1K1idn6RHFXyW8FrIB7LK
         1e/RpU26hlAPTR5DIt0O0i7mtBn/MhoRpurCpbPAm6sboXQDK6CxP6hcmKlf08kh9mq0
         EQ//267xOm4VF8JekjBLnrbtYW+Z+Ng8MpUoidT4VrB1Fm8e6pERYCwKHAy5lN6oS2vO
         gjTF2z2pE4aMch9jl10G6CvR0qfmLWxlsHc63SoPeimgUomRMX+cCe8Dloeo3JBrc/E+
         rjnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CnRxXWbeRnl6PzdWQmJBxR6Pu8ITF5skNlZsyk3ysJU=;
        fh=zEwzjFPLu3eI2Q9wfk1O4RKSoWFa4KPimr5y4l8iXdw=;
        b=YMUw1zLO0gv54/yhN/3r7B8/r8n6JvXd5AInHkp5clfnjZREgHUOW85LbC4htSjrYg
         nPtaIPig9lNQ1ZoAEp7KXc1XPofeUURW7Kd9Q17bmlfRupkduxGTSFQJvmsvdVKg/1uq
         zr3jndNpgZfaKBZD/dlFXqD4BPJY4f2RJkny4lwEwxmf84vzS7mbStC0vHvruFoknNwQ
         HDMoHUHbZx1Y1UC2Q9Tiga3B5Kg/ysIHz5o5tb6MIM17XErDl9+8/aVyXebCI/gq7Fsa
         zIyz3rFzFWfSh+tGDLivuI3MekOZZW4ulbrka/9nWW+I2/pgEWPTTj2s8XII9nR6DHJ7
         7SFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788970030; x=1789574830; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CnRxXWbeRnl6PzdWQmJBxR6Pu8ITF5skNlZsyk3ysJU=;
        b=RsxFLdFgl+k/ROM2wAieUFZa+l5Sv/tNdUTrThap/jJ923VjnSLiwpuekt0ytf+Lz7
         fqVrHOWpqCZdfV+1oNLftbWTDXVXny6JWKnPYGqr+2wvdL5pTOvxE5hLc2tlnMnKq+98
         vYdiNP5fqICVoXwdKwSQ7OiYYu6j02ABvECy5t4R/kKW6mA/hiHwp4Rsx+M31Lk6Slo0
         pF63dsDnw9J7s+qYX7FUOubPDO9d6v0ST8ij8YB1IpeKO3120lA5LrWpI8nb3J+QUahf
         T30/FZDPgBM0Nyq0gpzdW5GgeWo1J7kd1ZJx/Qk1HfmjoroNeiVwh2eF3YeGGaTRKkZM
         xMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788970030; x=1789574830;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnRxXWbeRnl6PzdWQmJBxR6Pu8ITF5skNlZsyk3ysJU=;
        b=mAqBVZr0srNdOA8G/kOIoXzcyuZFgFo4zobz2pHk/A/60vOYJdg+esjNe0rF96bdgU
         miEanhqCz6wTdnZhz7yTtDKtweq7d9eJbc4LZmVk4hTC9axi9s+VYAlfd+yxx1ftOmjv
         B4NB+ET7vQy2R6MEnHKm8JPy/LXG9ra5noFBQ9Aeb264VJdGQH3gazFCLIMFSOVcFc/F
         37dqlc09W+nIsPQs37+HCuTR1T8ItAjcJAoxN6Mbpf9dp+Axf3zgqroAm/Ldxb9ceymR
         J8X7N/G+x80XoPy8SQSS+F+/PGDXZk2oV+CxtVeeooKUm1+SZTbCs7Niw4ER6BJ3EMqz
         ZqcA==
X-Forwarded-Encrypted: i=1; AKwUvBwdUaFZzvzXNX/Jcqce1ygH6AuquPH9kOWnMTpSbVvY3e/j4Yu4e2myhJXfF6iOSe0RqCuNrlU=@vger.kernel.org
X-Gm-Message-State: AFuF++n/dfswb6fUu5ng9nNltIbWX6v/2xLrq+qgG9jZlia/rcwwsbk8
	cxj/7ypgpaOmp2ERDvdNd1Hw7HOpCNypg2IwzHevw6kAtT2hSKhyaTF8SP1ntHEPc4Bc2HRp2PY
	ddarPWUUn3jM76Er0TKp2zb5CRaR6T/5unYWlPygj
X-Gm-Gg: AYBFou06FVNoY9W1rbZ1i/mMchuceDjcwNDOXKKqHfxGSguqHS2wz1/L/o4RpMDwWcU
	0rerxiNP0Fupn8cZaz9Tjr0X66VIW1OO4meiNjGZltQrTlp32DBDZMxXZvr0dW1CXitIqzdpk8J
	4MGGWdL4AswrHa4B1FiI+rhYEWo6nnYdqOX2TCTRAVG/M4NjMLtEpU67/dLZ0UvABbZQM1y2EWh
	Ec01/N66t2QAcbHOd6qgwWZii5JD8Nih+0jZ2xtHN3hRJvcreByYSN+8eI5ornYxVHW7ZspRKt+
	1I76l8Iwo3Bwn3V7Zsuar4zXpxg4CVgP1VtYcRKWXSn1TcChmVTE
X-Received: by 2002:a05:6402:2081:20b0:6a6:7385:3eac with SMTP id
 4fb4d7f45d1cf-6a99347d86bmr30789a12.11.1788970029279; Wed, 09 Sep 2026
 09:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831183529.2517322-1-sdf@fomichev.me> <CAHS8izM5+CrZG77PxKpfG9k5kEWYMgN=uAuYvy21aabyztBt0w@mail.gmail.com>
 <aphk-b52PGfESvjL@devvm7509.cco0.facebook.com>
In-Reply-To: <aphk-b52PGfESvjL@devvm7509.cco0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 9 Sep 2026 09:06:57 -0700
X-Gm-Features: AcwNN1UNfhOLZYENFOH-MMzII8uEmjay9oCkuW5NlbKnvUALQiEYrCsKpGGfW_s
Message-ID: <CAHS8izPRSRFz=s6q1smaKKscZshg=kRkYtXzSpSXA4KmVoh=Fw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: devmem: remove gen_pool from dma-buf allocations
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Kaifeng Wang <kaifengw@google.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	sdf@fomichev.me, bobbyeshleman@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 11:37=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> On 08/31, Mina Almasry wrote:
> > On Mon, Aug 31, 2026 at 11:35=E2=80=AFAM Stanislav Fomichev
> > <sdf.kernel@gmail.com> wrote:
> > >
> > > Replace devmem's gen_pool based fixed-size allocator with a binding-l=
evel
> > > freelist similar to the one used by io_uring zero-copy receive.
> > >
> > > This is motivated by allocation latency observed in the NAPI receive =
path:
> > >
> > >   [ 1036.228913]  ? gen_pool_create+0x90/0x90
> > >   [ 1036.228915]  net_devmem_alloc_dmabuf+0x1f/0x60
> > >   [ 1036.228918]  mp_dmabuf_devmem_alloc_netmems+0x17/0x80
> > >   [ 1036.228920]  mlx5e_post_rx_mpwqes+0xdbe/0xdd0
> > >   [ 1036.228926]  mlx5e_napi_poll+0x113/0x830
> > >   [ 1036.228928]  ? sched_clock+0x5/0x10
> > >   [ 1036.228931]  ? wake_up_process+0x778/0x14b0
> > >   [ 1036.228933]  net_rx_action+0x15d/0x570
> > >   [ 1036.228934]  ? update_rq_clock+0x31/0x240
> > >   [ 1036.228937]  ? __napi_schedule+0x55/0xa0
> > >   [ 1036.228938]  ? mlx5_eq_comp_int+0x137/0x230
> > >   [ 1036.228940]  ? atomic_notifier_call_chain+0x36/0x90
> > >   [ 1036.228943]  ? sched_clock+0x5/0x10
> > >   [ 1036.228944]  ? sched_clock_cpu+0xc/0x170
> > >   [ 1036.228947]  irq_exit_rcu+0x12b/0x370
> > >   [ 1036.228950]  common_interrupt+0x85/0x90
> > >
> > > udmabuf can create a very large number of SG entries. In the worst ca=
se,
> > > devmem ends up adding one gen_pool chunk for each net_iov allocation
> > > unit backed by those entries. The gen_pool allocation path then has t=
o
> > > traverse a linked list that can become too long for this hot path.
> > >
> > > Patch 1 removes the gen_pool and replaces it with a simple freelist o=
f
> > > net_iov pointers protected by the same spin_lock_bh() pattern used by
> > > io_uring zcrx. Patch 2 removes the now-unnecessary chunk owner wrappe=
r by
> > > embedding the net_iov_area directly in the dma-buf binding.
> > >
> >
> > Oh boy, this is going to be a bit tricky.
> >
> > I ran into this exact horrible perf bug (sorry for it in the first
> > place), but my solution was different. My solution [1] was to coalesce
> > the SG entries that are contigious (and they usually are in practice),
> > and I got 'acceptable' perf after that. Kaifeng is actually working on
> > cleaning up my hacky patch up to send it upstream now.
>

Sorry for the late reply. We got some perf data. Not complete perf
data but we ran the workload that detected this issue.

Basically your fix and my fix produce the same results. Surprisingly,
the batching doesn't help.

I think to be honest we want the fix with the batching. It seems
brutally stupid to me that we refill the cache one netmem at a time
when filling 64 at a time should in theory be so much better,
especially if we're not paying a gen_pool_alloc cost every time.

I'm a bit unsure about this as the version with the gen_pool fix is so
much more verified in our production. I would welcome discussion. It
would be nice to know the maintainers are open to switching back to
gen_pool if this causes us issues in production. In testing and
benchmarks it's fine.

I'll go through the patch to see if I have any other feedback besides
perhaps including the batching.

> As you mention, coalescing might happen to work or it might not :-(
> I'd like us to have something that's less probabilistic.
>

Honestly it's not that hard to get a contingous pages. We usually
alloc GPU mem at boot when there is no fragmentation, and also I think
underlying, the CUDA will use huge pages and if end up with a handful
of chunks, the perf is still good.

> > Now I don't know which approach is better. Thinking about the pros and
> > cons of your approach:
> >
> > + your approach is much simpler, and removes gen_pool overheads for a
> > single queue case. It should be (much?) faster for that case.
> > - your approach adds a lock and allocations from multiple queues in
> > parallel will contend on this lock. There should be some value of # of
> > queues N where your approach starts to completely trash. gen_pool is
> > lockless so I wouldn't expect it to degrade significantly in the
> > multi-queue case.
> >
> > The question for me is what the performance is for a real use case
> > (NCCL all-to-all for example) over a realistic number of shared queues
> > (it's 4-8 for me). I need that perf data to be honest before judging
> > this.
> >
> > The io_uring zcrx comparision is not completely valid. io_uring zcrx
> > is built from the ground up to be one-buffer-is-bound-to-one-rx-queue,
> > and devmem tcp is built from the ground up to be
> > one-buffer-can-be-bound-to-N-rx-queues.
>
> What if we add batching similar to io_pp_zc_alloc_netmems? So we don't
> have to spin lock on every netmem (and move PP_ALLOC_CACHE_REFILL-worth
> of chunks). Untested, on top of this series:
>
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 84d6c30516c8..5a1c996ba515 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -58,25 +58,25 @@ void __net_devmem_dmabuf_binding_free(struct work_str=
uct *wq)
>         kfree(binding);
>  }
>
> -struct net_iov *
> -net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
> +static unsigned int
> +net_devmem_alloc_dmabuf_bulk(struct net_devmem_dmabuf_binding *binding,
> +                            netmem_ref *netmems, unsigned int count)
>  {
> -       struct net_iov *niov;
> +       unsigned int i;
> +
>         spin_lock_bh(&binding->freelist_lock);
> -       if (unlikely(!binding->free_count)) {
> -               spin_unlock_bh(&binding->freelist_lock);
> -               return NULL;
> +
> +       count =3D min_t(size_t, count, binding->free_count);
> +       for (i =3D 0; i < count; i++) {
> +               struct net_iov *niov =3D binding->freelist[--binding->fre=
e_count];
> +
> +               binding->freelist[binding->free_count] =3D NULL;
> +               netmems[i] =3D net_iov_to_netmem(niov);
>         }
>
> -       niov =3D binding->freelist[--binding->free_count];
> -       binding->freelist[binding->free_count] =3D NULL;
>         spin_unlock_bh(&binding->freelist_lock);
>
> -       niov->desc.pp_magic =3D 0;
> -       niov->desc.pp =3D NULL;
> -       atomic_long_set(&niov->desc.pp_ref_count, 0);
> -
> -       return niov;
> +       return count;
>  }
>
>  void net_devmem_free_dmabuf(struct net_iov *niov)
> @@ -433,20 +433,35 @@ int mp_dmabuf_devmem_init(struct page_pool *pool)
>  netmem_ref mp_dmabuf_devmem_alloc_netmems(struct page_pool *pool, gfp_t =
gfp)
>  {
>         struct net_devmem_dmabuf_binding *binding =3D pool->mp_priv;
> -       struct net_iov *niov;
> -       netmem_ref netmem;
> +       netmem_ref *netmems =3D pool->alloc.cache;
> +       unsigned int allocated, i;
> +
> +       if (WARN_ON_ONCE(pool->alloc.count))
> +               return 0;
>
> -       niov =3D net_devmem_alloc_dmabuf(binding);
> -       if (!niov)
> +       allocated =3D net_devmem_alloc_dmabuf_bulk(binding, netmems,
> +                                                PP_ALLOC_CACHE_REFILL);
> +       if (unlikely(!allocated))
>                 return 0;
>
> -       netmem =3D net_iov_to_netmem(niov);
> +       for (i =3D 0; i < allocated; i++) {
> +               struct net_iov *niov =3D netmem_to_net_iov(netmems[i]);
>
> -       page_pool_set_pp_info(pool, netmem);
> +               niov->desc.pp_magic =3D 0;
> +               niov->desc.pp =3D NULL;
> +               atomic_long_set(&niov->desc.pp_ref_count, 0);
> +
> +               page_pool_set_pp_info(pool, netmems[i]);
> +
> +               pool->pages_state_hold_cnt++;
> +               trace_page_pool_state_hold(pool, netmems[i],
> +                                          pool->pages_state_hold_cnt);
> +       }
>
> -       pool->pages_state_hold_cnt++;
> -       trace_page_pool_state_hold(pool, netmem, pool->pages_state_hold_c=
nt);
> -       return netmem;
> +       /* Return the last one, the rest stay in the page_pool cache. */
> +       allocated--;
> +       pool->alloc.count =3D allocated;
> +       return netmems[allocated];
>  }
>
>  void mp_dmabuf_devmem_destroy(struct page_pool *pool)
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 20a3eb90ea7f..7195769b8bd1 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -133,8 +133,6 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmabu=
f_binding *binding)
>  void net_devmem_get_net_iov(struct net_iov *niov);
>  void net_devmem_put_net_iov(struct net_iov *niov);
>
> -struct net_iov *
> -net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding);
>  void net_devmem_free_dmabuf(struct net_iov *ppiov);
>
>
> @@ -191,12 +189,6 @@ net_devmem_bind_dmabuf_to_queue(struct net_device *d=
ev, u32 rxq_idx,
>         return -EOPNOTSUPP;
>  }
>
> -static inline struct net_iov *
> -net_devmem_alloc_dmabuf(struct net_devmem_dmabuf_binding *binding)
> -{
> -       return NULL;
> -}
> -
>  static inline void net_devmem_free_dmabuf(struct net_iov *ppiov)
>  {
>  }
>
>
> > Are you able to get NCCL all-to-all tests for N=3D4/8 yourself?
> > Otherwise please wait for me to backport this to my release kernel and
> > test it. ETA sometime this week, I hope.
>
> I can definitely wait for you to access the perf impact on your side. Won=
der
> if we need to have a selftest to do that properly in NIPA. Doesn't have t=
o
> be a red/green signal, but some number for humans to compare
> before-after (specifically this bind one dmabuf to multiple queues and pa=
ss
> a lot of traffic). I can probably sketch something..

Selftest in NIPA is nice, but NIPA would need access to a real GPU to
run NCCL tests, AFAIK. I don't know how to make those run on udmabuf
without O(months) of work.

--=20
Thanks,
Mina
