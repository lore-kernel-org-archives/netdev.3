Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06E30F924
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 19:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203815; cv=pass; b=V0ZE/OmiT5yvonPkJquxCxoYaFD3ZmAgAMcBj1WnB3Yd6RASyFaa0P9IOa2D89hyT/XiokzAz/j8ryNtICzwH43R2yK/eHx2ck1J+xceVtESD3MrXx3lJg669rap8M9IXLzSV/cYeXdSle00lKhbSJS/1XrgituGKbth9RHP+9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203815; c=relaxed/simple;
	bh=A3S+U7J2OdwNyfma0wnLOklR/XimcGFT8VWX+qv2kXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F4PZmwL4B+D6ZViQOO+SIdZ1hMaZ6lIoY/KS4/qiJ+bXLgeLqgFa4++ZixNZi4KDrHsNFN/rhLShWDo+5gWJEeWtXkxDDQsSAEXhzbsngrd8gi70Jyr1g/3nfMa6FjEAOOI6c8B656mpqzWkewSIDCVgwL5KjC0HDLMPE66B9rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2UUAFqp; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2UUAFqp"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a5f91ae397so1881a12.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 12:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788203812; cv=none;
        d=google.com; s=arc-20260327;
        b=LXeU3VzB1IyScJIGO1dm93pW4gCLirTX8T1EkN7JY4qzCbymNS9WmZ+R2+lMlAzZZS
         9KPQkKDRA9c99z0AzgpCki12Wa1rt+5kA+gwKSeXD16aPZ/2V9qHMQ0fdGCUJF4QuXLL
         0o3UGhMNYW7eACVjnFsQCACZMosLAJ5NvepDVv3QeQZ/FxCvcEXT5JMMLskJaqPqhkUO
         TUh3lRYNdaIsuw6iBLu3vJSq7yVgr9wQjVzfzFko/YVcsec/yelI1dbHXZmYJTNoZBQN
         2iLCtELX0uQT7FusAvgVJHT1XFrwomOM0FJ1HgJ5Bw07sMVNufcBGWi2Hjhya5y/6GTe
         J6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2j1aLdCw891zGxvM8nmdzD+khl40rKBnJPhJm/y1Ofw=;
        fh=HK5M50itCqtFR2A9vLw+FuDk4FUXgzExy62DCoCmzlk=;
        b=WOFP/JGSQ7z21ydJfho6k6Zn1kTqna2S5nZOvZxtTJ1xlq1YQM1dWj1RzslbKKZAii
         qUEDvFAOallC3HyCaCDa2VKgShFYf92NmuO3Qx7dJvZ+4BEddlEEQ12YIdDdf8bPjfSW
         GL8WrOX7+cVvw9Dn9+K3opq1fpz7Veg/i1KMq/4IKQ20C1iZu8MOAQi0yjH9A1uL39JW
         7bCtv0BDOWBl1IFhH6lkXHszQ4QtddN8Z2On0rRECAIbNm3mIHQ1QNWvB0UAx4ZFltuA
         rgn0ynwr7XCL6byIpGJjwft6gcC2k94BHY19fDaxlMyqGyNP4k0xrqQ4dHTC5m1z0dmX
         lrEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788203812; x=1788808612; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2j1aLdCw891zGxvM8nmdzD+khl40rKBnJPhJm/y1Ofw=;
        b=q2UUAFqpPnhDYj6uS6A7QB2epKZAqd/snHVuP+xAcxeBbvd1rIfDOyaqrC0GZj30KQ
         GfmjRTQpMrmIOYEOt6RVEPnnuPAVEy0Gigt6nAWXw1zNcQL2W83T/PRIt0hnoGsWl9L4
         HZAKhF3bfAn9EQbMDtNqNTPiICxcZrez4hVgGV1+0dnckAuFK3LLUP2qLLHJl40mNmT8
         LB1VmWlVNc72DuJmqWfYXdkY2KlLqQ3DMlu7qZletMM60q0HRsuqv8eNkjgH/s4k4Xc8
         Fy1HefLIAs279a3LgyVuUGoq6Q6CB4y9WhKnwP/iydUUblLqyiEGwBanFQ2warXUHpe8
         9QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788203812; x=1788808612;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2j1aLdCw891zGxvM8nmdzD+khl40rKBnJPhJm/y1Ofw=;
        b=jbfyfRfb4PTFr4I8O/INWZQp5CQi+6pewvLQGfwsuAPS2O1lqhGPBi/dQ7BiqiQ091
         Z3sLhcSJYip5R2Wt0Et3L8MUtX997CV8zVL/EKRuFtnV+YRClg7F7+39AKUd+RuGlVHb
         5pJ0TXie97VOAaiDo6T9cjg9BEq9kDtg/m/2TylcCYG7C7R/KhF+OaYI9j4F3hBN466+
         gwTB5KiFiFMzTnWuQ16wYYx2q0PEy6ClZdIx9LVNayLOgNQ6vQVD/j7N35VN9dDX7Azd
         4IpOJ2XWcA9ZJhbCN1/9OM3J6OAfzLYYoNPO70sha/Lat3YgLD/0djhtNSjIsVFLKxZz
         J0ng==
X-Gm-Message-State: AFuF++ngzpi+hm7ot9Zm178ykMC1Zm5pPJ0xuMJ2I3gzs0UixujOsvpK
	+J4VJL40/cOKl4o2xxyFUKwYF/qF7hwuZPASq2JyRKtkZok67Vv3JpTsql6EX0BGVY35TQIICHG
	s4vSLaezWz0z0JVWjRp3liDVLOV13AQHvUILJIa/P
X-Gm-Gg: AYBFou3cawGM+hkUFTx2jIbEILZKIw7vsKwbU98FdDfOg1kJO8tr+DnJyGEN6OIopIc
	i/NBqrzT83sCJWx0b0IhfXCUPWeLgeDvnvMfkqv4enE14WZ5IBs3YTtOvCnXj1WjUDAHsG4ewoa
	m+vJtGFS43KOdD07cQh0ctaGpMr40qgElMzrm3Gr/QhTeJRUMj6js1Tl42OmhhaZiW723NS1RUn
	yp9oiLqmlElk1NrKsaWvukkvAWQvJLkR8fP0IcFxeIXGfB4Zv/W85yEuc6cAegY0jeARr8rDpcw
	n5DbEYw9qcmILapBnFOmduH82uj5dasqOPiYGamYzAy2Hw9m6i6UN7fWg3/e6ULS9qAFSdTV0zk
	=
X-Received: by 2002:a05:6402:4044:20b0:68a:e1ba:9cc0 with SMTP id
 4fb4d7f45d1cf-6a66a1783a9mr5047a12.8.1788203811129; Mon, 31 Aug 2026 12:16:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831183529.2517322-1-sdf@fomichev.me>
In-Reply-To: <20260831183529.2517322-1-sdf@fomichev.me>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 31 Aug 2026 12:16:39 -0700
X-Gm-Features: AcwNN1XnKk8Q1yV8OPLja8nclDBYAhbaAMUtHpnN3C_oaUd1cu504Lsi8H-QCvc
Message-ID: <CAHS8izM5+CrZG77PxKpfG9k5kEWYMgN=uAuYvy21aabyztBt0w@mail.gmail.com>
Subject: Re: [PATCH net-next 0/2] net: devmem: remove gen_pool from dma-buf allocations
To: Stanislav Fomichev <sdf.kernel@gmail.com>, Kaifeng Wang <kaifengw@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	bobbyeshleman@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 11:35=E2=80=AFAM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> Replace devmem's gen_pool based fixed-size allocator with a binding-level
> freelist similar to the one used by io_uring zero-copy receive.
>
> This is motivated by allocation latency observed in the NAPI receive path=
:
>
>   [ 1036.228913]  ? gen_pool_create+0x90/0x90
>   [ 1036.228915]  net_devmem_alloc_dmabuf+0x1f/0x60
>   [ 1036.228918]  mp_dmabuf_devmem_alloc_netmems+0x17/0x80
>   [ 1036.228920]  mlx5e_post_rx_mpwqes+0xdbe/0xdd0
>   [ 1036.228926]  mlx5e_napi_poll+0x113/0x830
>   [ 1036.228928]  ? sched_clock+0x5/0x10
>   [ 1036.228931]  ? wake_up_process+0x778/0x14b0
>   [ 1036.228933]  net_rx_action+0x15d/0x570
>   [ 1036.228934]  ? update_rq_clock+0x31/0x240
>   [ 1036.228937]  ? __napi_schedule+0x55/0xa0
>   [ 1036.228938]  ? mlx5_eq_comp_int+0x137/0x230
>   [ 1036.228940]  ? atomic_notifier_call_chain+0x36/0x90
>   [ 1036.228943]  ? sched_clock+0x5/0x10
>   [ 1036.228944]  ? sched_clock_cpu+0xc/0x170
>   [ 1036.228947]  irq_exit_rcu+0x12b/0x370
>   [ 1036.228950]  common_interrupt+0x85/0x90
>
> udmabuf can create a very large number of SG entries. In the worst case,
> devmem ends up adding one gen_pool chunk for each net_iov allocation
> unit backed by those entries. The gen_pool allocation path then has to
> traverse a linked list that can become too long for this hot path.
>
> Patch 1 removes the gen_pool and replaces it with a simple freelist of
> net_iov pointers protected by the same spin_lock_bh() pattern used by
> io_uring zcrx. Patch 2 removes the now-unnecessary chunk owner wrapper by
> embedding the net_iov_area directly in the dma-buf binding.
>

Oh boy, this is going to be a bit tricky.

I ran into this exact horrible perf bug (sorry for it in the first
place), but my solution was different. My solution [1] was to coalesce
the SG entries that are contigious (and they usually are in practice),
and I got 'acceptable' perf after that. Kaifeng is actually working on
cleaning up my hacky patch up to send it upstream now.

Now I don't know which approach is better. Thinking about the pros and
cons of your approach:

+ your approach is much simpler, and removes gen_pool overheads for a
single queue case. It should be (much?) faster for that case.
- your approach adds a lock and allocations from multiple queues in
parallel will contend on this lock. There should be some value of # of
queues N where your approach starts to completely trash. gen_pool is
lockless so I wouldn't expect it to degrade significantly in the
multi-queue case.

The question for me is what the performance is for a real use case
(NCCL all-to-all for example) over a realistic number of shared queues
(it's 4-8 for me). I need that perf data to be honest before judging
this.

The io_uring zcrx comparision is not completely valid. io_uring zcrx
is built from the ground up to be one-buffer-is-bound-to-one-rx-queue,
and devmem tcp is built from the ground up to be
one-buffer-can-be-bound-to-N-rx-queues.

Are you able to get NCCL all-to-all tests for N=3D4/8 yourself?
Otherwise please wait for me to backport this to my release kernel and
test it. ETA sometime this week, I hope.

But please no merge without real perf data. This has potential to be
great, but is very risky :(


[1] patch:
commit 7bb6d32e21b6e ("net: devmem: coalesce sg chunks before feeding
into gen_pool")
Author: Mina Almasry <almasrymina@google.com>
Date:   Mon Dec 8 01:44:39 2025 +0000

    net: devmem: coalesce sg chunks before feeding into gen_pool

    On dma_buf_map_attachment drivers typically return an sglist where each
    sg is of size 64KB. When mapping a very large dmabuf (like 4GB or so),
    this results in an sglist of 62500 entries, but usually they all map to
    a contiguous range.

    The current implementation inserts each sg as a separate chunk into the
    gen_pool. This results in much slower gen_pool_alloc and gen_pool_free
    performance due to the gen_pool actually looping through all the chunks
    and trying to free/alloc from each of them.

    There is no reason to insert each individual sg into a gen_pool chunk.
    Instead, detect that the next sg starts at the dma_addr of the current
    chunk and coalesce them.

    This results in a huge improvement in all-to-all devmem collectives, fo=
r
    example sweeping 1G and 2G message sizes:

    Before:

           0     0x0         AlltoAll  1073741824       8388608
float    none      -1   289212    3.71    3.60      0 1796277    0.60
  0.58    N/A
           0     0x0         AlltoAll  2147483648      16777216
float    none      -1 4242107    0.51    0.49      0 6301030    0.34
 0.33    N/A

    After:

           0     0x0         AlltoAll  1073741824       8388608
float    none      -1   284860    3.77    3.65      0   252456    4.25
   4.12    N/A
           0     0x0         AlltoAll  2147483648      16777216
float    none      -1   569225    3.77    3.65      0   553717    3.88
   3.76    N/A

    Signed-off-by: Mina Almasry <almasrymina@google.com>

    TEST=3DTested using the all-to-all devmem collective outlined above.

    Reviewed-by: Eric Dumazet <edumazet@google.com>
    Reviewed-by: Kevin Berry <kpberry@google.com>

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 606e556d1935b..07ba32b177390 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -274,6 +274,18 @@ net_devmem_bind_dmabuf(struct net_device *dev,
                size_t len =3D sg_dma_len(sg);
                struct net_iov *niov;

+               /* Detect contiguous sg's and coalesce them. This improves =
the
+                * gen_pool allocs/frees with O(GB) dmabufs, because the
+                * gen_pool code attempts 1 allocation/free per chunk in a
+                * list_for_each_entry_rcu.
+                */
+               while (sg_idx < binding->sgt->orig_nents - 1 &&
+                      dma_addr + len =3D=3D sg_dma_address(sg_next(sg))) {
+                       len +=3D sg_dma_len(sg_next(sg));
+                       sg =3D sg_next(sg);
+                       sg_idx++;
+               }
+
                owner =3D kzalloc_node(sizeof(*owner), GFP_KERNEL,
                                     dev_to_node(&dev->dev));
                if (!owner) {
> Stanislav Fomichev (2):
>   net: devmem: replace gen_pool with freelist
>   net: devmem: embed net_iov_area in binding
>
>  net/Kconfig       |   1 -
>  net/core/devmem.c | 158 ++++++++++++++++++----------------------------
>  net/core/devmem.h |  38 ++++-------
>  3 files changed, 72 insertions(+), 125 deletions(-)
>
> --
> 2.53.0-Meta
>


--=20
Thanks,
Mina
