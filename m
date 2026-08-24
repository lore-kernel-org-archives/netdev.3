Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB24417BF8
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572771; cv=pass; b=pot36RRhIc9UPcAiTMQGiQQlI1rdzca9fg2n1KLgL1pFSOCs7nTmmqyF5gV0dpW3waPA5v0IvAfNeu2gzY8r6YMF+yB74sBa6jHJ1c88c6fIND1JoT+JNlooWF/nqMceomTHYJmIzIDpTxPbNgabiXThZKY4OdyYpGkNBxQnEqE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572771; c=relaxed/simple;
	bh=n8XaB57aaEQ6dDjJctc+o5dgV+QNULbMJaGUIBH9NIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPRY5a7+k7FFc5JZKQ7Q6IeTFMON+jl76dn1MthUU6QX/VkdKpTQoyaCd0vBw+Owa6XoOqbvlzzXfgpWBImxzUUdubKsRKrmCC2t+U5jCL9ewWYLpzKlm4yrJxy5c1tKING9ATGj4PBbTvG97F6XmDEHdnl65fijVf4aKgabpe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ5AmSUk; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ5AmSUk"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69a33fb0031so534944a12.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 04:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787572768; cv=none;
        d=google.com; s=arc-20260327;
        b=NuCmEP7k0th6ns+M3OZ11FptMGB8Qchg7GKo0675lgPBeoqgTGN/Q8149Psx/QSm8w
         pEyqEhTPfTtRexxaSpDe/2wZ0PJ34IaZG2baij/8cid916KGVRG0XBTHv4ssVHdHIKz3
         mDTI3lePl73OrRF/e66fBqa8J+MnDjfWy00tjk2ekFQuSjc5+Q4nQlbGwLzz82YBxZrJ
         GwHpBezauapr2IiPKH9o9gcOxioFPJCXpcoVZJe0EwXQDjrpAoJiIzVjIjIkuT/albVO
         pNoyYWchWoVJU0WNLIwPMgOVjTVuBwQTsUaZKbWlaiWAdanV+H3uBiuFbMkOorj2kDRC
         ov9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VaSBoohYncBwZi2t/vY0TkG12zTaDc0RNLikLupkjjM=;
        fh=CoohORbCy1ZiYcL9EtYQpuj+Arx7IPijlLrLXfHrSGw=;
        b=cOKC+v5oU1E6gSi7eqjlNYiBVYz63piRTkqnqEn0WK27JULqnWgPYeIfkf94Rw5Az0
         vS2G7Z1sZDMMw1aFfV6icI5SR9ia+Nv0sJ+SExIl7r0pf96fkfcpTT+eGz0auyztRPv6
         kPzCBWvIE1nAejZT2ZD8Ng1r6E86vpEr+KbJfJpY+PYWsGN63CWiNtezLxlET5Ohv9pc
         VIPLrMIvGRDlzTlqtbQpXlDiuREV2xdL/gOTUio4NJjPf1r1GRJXUCLBtS6jOPC2lE2z
         cM8jMfonrJ/0Sa60A3hEDj2n3qmBO2GxPdTuNChx/XuGwiavFIgwB+Xnm9EnoZQRs3Jc
         ZC9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787572768; x=1788177568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VaSBoohYncBwZi2t/vY0TkG12zTaDc0RNLikLupkjjM=;
        b=BZ5AmSUkJ5yxV+may0ef+2QrEFR1pBQPe1a1dbhYaZhFnkjIE3Phw03LLmUR6xdICc
         sKb79QaFuVITaHXQd0Nyg5bgwN3lMap7sZcpqcD8Jx48jO2bVZz1j7KIPeWap/a+aLYQ
         P1aBZ6zAnN9MOG9sbMGoriFU8q4VbYNVPx4qRdAtsTWG7UIJnEQzWxM6nqx0JJ4MdhwM
         9Xwgf1HhE0HAtAzLn9T0y5QmSIyZl9BRXotqSV5LKxDkK0qcA7E4JSi4StrAHWJ32C5h
         uXjSZ8XqNp9YRWHKGhJh+yE6NJhsBk2T68E8EBR6gLXgSE/6RqY3NP/BkjX9yOI9gN6g
         FNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787572768; x=1788177568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VaSBoohYncBwZi2t/vY0TkG12zTaDc0RNLikLupkjjM=;
        b=ffRM106ev0RdMBl/DcBiO/gi5JpTqXZZJwoIuG4RboM57yK80CCwJpvw/XCJ/VQZUk
         w2Hf3znaP9e7fDEO7QMBIzUVxQqUhuEBbfz6CcKH9lytOrSyrSTDU1C8Wk1ZbnpLyjYA
         laj8zfbBt+iuGIJIfrhJfx2UO8qc6muZ+HKGGpWt+25kixOMaYA51y+/qBQkZs8RMDVp
         7oJ6DSTK+JTsXLaEVo7283S0zKGPRRANn+xX1H39xP608q8+2XIjRr6+RQmkhQYAo8OO
         Nn19RNcHERwaqTh6F1kLwActWaYTGA4ZusYIbeDQhG87/DzDtYatj3Ogr3IqWnqty1RE
         xYAw==
X-Forwarded-Encrypted: i=1; AHgh+RqBBiKAWPSTHVWCKz4BsJ1TrbW4X/0peBVtuG9Wjsk7ovYpuBd73RYEmdygTRYxUjVYGcGDheA=@vger.kernel.org
X-Gm-Message-State: AFuF++nGl54RZ0eIfEeYxjVN+9G6fVwvVKWN+O2fOsgGOMqCMw0puKar
	MljVF4R3rAn1U2EVmo68zhTbw0X/uwf9Csk5KJL3ApEm5bsKKuLznW61DAKQwid/RbIR7WLrf6g
	gbFyFEzbnDawcrpD1Nngf1q0tsQRavFU=
X-Gm-Gg: AR+sD13ijd7SfXu/Py4pOsNP7iH272al8LZpo0SBZGDDdZI3J4SsERspVp4lCaNYe2n
	PSCTLm0r3+u+0qbyqORgKhJXpuXT8UeK7vYvl6H998m711arHvjFj3DyfhKfdHPzrtYOQoiCGIq
	1eI/X4UWY6sAvG3BW0rUvh3okhc8jK2ahBdeIpVELDvrVvlxuHK/buYCBivWdvB7//FIwO5Frzn
	0n3vOWmrD638+JdR6eNBG89bl8Qq5kDwzCHqaDL4clptPZvXgQPvycJERNH1wUkBvL1UNxErp1T
	PO/ftsfLrOO5eoSzpEKncNGPbEp/YU0nPgDtuC52YQkW3zZByihL5GYPrRbLaOOdQgZ3BWIbbA=
	=
X-Received: by 2002:a05:6402:5d0:b0:6a1:d68:338a with SMTP id
 4fb4d7f45d1cf-6a42eeaf432mr15119654a12.0.1787572767546; Mon, 24 Aug 2026
 04:59:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824115829.205118-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260824115829.205118-1-nicoyip.dev@gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Mon, 24 Aug 2026 19:59:16 +0800
X-Gm-Features: AcwNN1WTzhohN6-hUdDub7gQv1MygGWzS4zJTIG38EfpsCoxvH0teMV9z17ZSPU
Message-ID: <CAAo+4rUzuEZAPOBj06+Djo6WnhFOv2UJz7Rj=nrLzpNsR=RD+g@mail.gmail.com>
Subject: Re: [PATCH] netfilter: flowtable: flush delete work after final GC
To: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Paul Blakey <paulb@mellanox.com>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 7:58=E2=80=AFPM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> nf_flow_table_offload_flush_cleanup() drains delete work before its final
> garbage-collection pass. That pass can itself queue more delete work.
>
> During teardown, one possible interleaving is:
>
>   teardown worker                         delete worker
>   first GC: work allocation fails
>     leave flow retryable
>   drain delete workqueue
>   final GC: allocation succeeds
>     queue FLOW_CLS_DESTROY work
>   destroy rhashtable
>   free flowtable
>                                           read flowtable->net
>
> nf_flow_table_offload_flush_cleanup() flushes only the delete work that
> was queued before the final GC. NF_FLOW_HW_DYING is set only after
> successful work allocation, so a GFP_ATOMIC allocation failure during the
> first GC leaves the entry eligible for retry. If that retry later succeed=
s
> in the final GC, it queues new destroy work after the earlier flush, and
> that work can retain a stale flowtable pointer past the free.
>
> This was reproducible with failslab forcing the initial GFP_ATOMIC
> allocation failure, and KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in flow_offload_work_handler+0xbe8/0xe3=
0
>   Read of size 8 at addr ffff888109c9fd98 by task kworker/u16:3/397
>   Workqueue: nf_ft_offload_del flow_offload_work_handler
>   Call Trace:
>    print_report+0xd0/0x630
>    kasan_report+0xce/0x100
>    flow_offload_work_handler+0xbe8/0xe30
>    process_one_work+0x63a/0x1070
>    worker_thread+0x45b/0xd10
>    kthread+0x2c6/0x3b0
>    ret_from_fork+0x36e/0x5a0
>   Allocated by task 87:
>    nf_tables_newflowtable+0x5d0/0x22f0
>    nfnetlink_rcv_batch+0x1396/0x1d00
>    netlink_unicast+0x5f5/0x860
>    netlink_sendmsg+0x70a/0xba0
>   Freed by task 11:
>    kfree+0x131/0x3c0
>    nf_tables_trans_destroy_work+0xb26/0xeb0
>    process_one_work+0x63a/0x1070
>    worker_thread+0x45b/0xd10
>   Last potentially related work creation:
>    __queue_work+0x68e/0x1030
>    flow_offload_del+0x74c/0xad0
>    nf_flow_offload_gc_step+0x264/0x8e0
>    nf_flow_table_gc_run+0xcd/0x150
>    nf_flow_table_offload_flush_cleanup+0x5c/0x70
>    nf_flow_table_free+0x280/0x350
>    nf_tables_flowtable_destroy+0x71/0x270
>
> Flush the delete workqueue again after the final GC. This keeps every
> successfully queued destroy operation within the flowtable lifetime.
>
> Fixes: c921ffe85333 ("netfilter: flowtable: Fix flushing of offloaded flo=
ws on free")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/netfilter/nf_flow_table_offload.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flo=
w_table_offload.c
> index 801a3dd9ceea..0fd09554b9ce 100644
> --- a/net/netfilter/nf_flow_table_offload.c
> +++ b/net/netfilter/nf_flow_table_offload.c
> @@ -1167,6 +1167,7 @@ void nf_flow_table_offload_flush_cleanup(struct nf_=
flowtable *flowtable)
>         if (nf_flowtable_hw_offload(flowtable)) {
>                 flush_workqueue(nf_flow_offload_del_wq);
>                 nf_flow_table_gc_run(flowtable);
> +               flush_workqueue(nf_flow_offload_del_wq);
>         }
>  }
>
> --
> 2.43.0
>

Here is the full KASAN report:

[    9.294240] BUG: KASAN: slab-use-after-free in
flow_offload_work_handler+0xbe8/0xe30
[    9.294696] Read of size 8 at addr ffff888109c9fd98 by task kworker/u16:=
3/397
[    9.295085]
[    9.295185] CPU: 1 UID: 0 PID: 397 Comm: kworker/u16:3 Not tainted
7.1.0-rc1-00124-g3c4c99630206-dirty #133 PREEMPT(lazy)
[    9.295189] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX,
arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    9.295191] Workqueue: nf_ft_offload_del flow_offload_work_handler
[    9.295197] Call Trace:
[    9.295200]  <TASK>
[    9.295202]  dump_stack_lvl+0x53/0x70
[    9.295223]  print_report+0xd0/0x630
[    9.295239]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[    9.295245]  ? irqentry_exit+0xcb/0x560
[    9.295247]  ? flow_offload_work_handler+0xbe8/0xe30
[    9.295249]  kasan_report+0xce/0x100
[    9.295251]  ? flow_offload_work_handler+0xbe8/0xe30
[    9.295254]  flow_offload_work_handler+0xbe8/0xe30
[    9.295256]  ? __pfx_pick_next_task_fair+0x10/0x10
[    9.295271]  ? __pfx_flow_offload_work_handler+0x10/0x10
[    9.295274]  ? finish_task_switch.isra.0+0x1e2/0x9c0
[    9.295280]  ? __schedule+0x1693/0x4250
[    9.295282]  process_one_work+0x63a/0x1070
[    9.295289]  ? __pfx_flow_offload_work_handler+0x10/0x10
[    9.295291]  ? assign_work+0x11d/0x370
[    9.295293]  worker_thread+0x45b/0xd10
[    9.295295]  ? __pfx_worker_thread+0x10/0x10
[    9.295297]  ? __pfx_worker_thread+0x10/0x10
[    9.295299]  kthread+0x2c6/0x3b0
[    9.295302]  ? recalc_sigpending+0x15c/0x1e0
[    9.295308]  ? __pfx_kthread+0x10/0x10
[    9.295310]  ret_from_fork+0x36e/0x5a0
[    9.295319]  ? __pfx_ret_from_fork+0x10/0x10
[    9.295320]  ? __switch_to+0x572/0xde0
[    9.295326]  ? __pfx_kthread+0x10/0x10
[    9.295329]  ret_from_fork_asm+0x1a/0x30
[    9.295336]  </TASK>
[    9.295337]
[    9.303596] Allocated by task 87:
[    9.303789]  kasan_save_stack+0x33/0x60
[    9.304010]  kasan_save_track+0x14/0x30
[    9.304226]  __kasan_kmalloc+0x8f/0xa0
[    9.304440]  nf_tables_newflowtable+0x5d0/0x22f0
[    9.304702]  nfnetlink_rcv_batch+0x1396/0x1d00
[    9.304954]  nfnetlink_rcv+0x2dd/0x360
[    9.305165]  netlink_unicast+0x5f5/0x860
[    9.305392]  netlink_sendmsg+0x70a/0xba0
[    9.305613]  ____sys_sendmsg+0x77a/0x900
[    9.305840]  ___sys_sendmsg+0xff/0x180
[    9.306052]  __sys_sendmsg+0x11f/0x1b0
[    9.306265]  do_syscall_64+0xf9/0x540
[    9.306476]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    9.306756]
[    9.306850] Freed by task 11:
[    9.307021]  kasan_save_stack+0x33/0x60
[    9.307237]  kasan_save_track+0x14/0x30
[    9.307455]  kasan_save_free_info+0x3b/0x60
[    9.307689]  __kasan_slab_free+0x43/0x70
[    9.307909]  kfree+0x131/0x3c0
[    9.308087]  nf_tables_trans_destroy_work+0xb26/0xeb0
[    9.308368]  process_one_work+0x63a/0x1070
[    9.308598]  worker_thread+0x45b/0xd10
[    9.308809]  kthread+0x2c6/0x3b0
[    9.308993]  ret_from_fork+0x36e/0x5a0
[    9.309205]  ret_from_fork_asm+0x1a/0x30
[    9.309426]
[    9.309521] Last potentially related work creation:
[    9.309791]  kasan_save_stack+0x33/0x60
[    9.310007]  kasan_record_aux_stack+0x8c/0xa0
[    9.310251]  __queue_work+0x68e/0x1030
[    9.310465]  queue_work_on+0x5d/0x70
[    9.310671]  flow_offload_del+0x74c/0xad0
[    9.310895]  nf_flow_offload_gc_step+0x264/0x8e0
[    9.311152]  nf_flow_table_gc_run+0xcd/0x150
[    9.311394]  nf_flow_table_offload_flush_cleanup+0x5c/0x70
[    9.311695]  nf_flow_table_free+0x280/0x350
[    9.311928]  nf_tables_flowtable_destroy+0x71/0x270
[    9.312198]  nf_tables_trans_destroy_work+0xb26/0xeb0
[    9.312478]  process_one_work+0x63a/0x1070
[    9.312706]  worker_thread+0x45b/0xd10
[    9.312917]  kthread+0x2c6/0x3b0
[    9.313101]  ret_from_fork+0x36e/0x5a0
[    9.313311]  ret_from_fork_asm+0x1a/0x30
[    9.313533]
[    9.313627] Second to last potentially related work creation:
[    9.313941]  kasan_save_stack+0x33/0x60
[    9.314157]  kasan_record_aux_stack+0x8c/0xa0
[    9.314403]  __queue_work+0x68e/0x1030
[    9.314614]  queue_work_on+0x5d/0x70
[    9.314816]  flow_offload_del+0x74c/0xad0
[    9.315040]  nf_flow_offload_gc_step+0x264/0x8e0
[    9.315297]  nf_flow_table_gc_run+0xcd/0x150
[    9.315538]  nf_flow_table_offload_flush_cleanup+0x5c/0x70
[    9.315840]  nf_flow_table_free+0x280/0x350
[    9.316074]  nf_tables_flowtable_destroy+0x71/0x270
[    9.316348]  nf_tables_trans_destroy_work+0xb26/0xeb0
[    9.316627]  process_one_work+0x63a/0x1070
[    9.316856]  worker_thread+0x45b/0xd10
[    9.317067]  kthread+0x2c6/0x3b0
[    9.317252]  ret_from_fork+0x36e/0x5a0
[    9.317464]  ret_from_fork_asm+0x1a/0x30
[    9.317684]
[    9.317777] The buggy address belongs to the object at ffff888109c9fc00
[    9.317777]  which belongs to the cache kmalloc-rnd-10-512 of size 512
[    9.318479] The buggy address is located 408 bytes inside of
[    9.318479]  freed 512-byte region [ffff888109c9fc00, ffff888109c9fe00)
[    9.319132]
[    9.319225] The buggy address belongs to the physical page:
[    9.319532] page: refcount:0 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x109c9c
[    9.319966] head: order:2 mapcount:0 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[    9.320382] flags: 0x200000000000040(head|node=3D0|zone=3D2)
[    9.320675] page_type: f5(slab)
[    9.320856] raw: 0200000000000040 ffff8881000532c0 dead000000000100
dead000000000122
[    9.321275] raw: 0000000000000000 0000000000100010 00000000f5000000
0000000000000000
[    9.321698] head: 0200000000000040 ffff8881000532c0
dead000000000100 dead000000000122
[    9.322121] head: 0000000000000000 0000000000100010
00000000f5000000 0000000000000000
[    9.322546] head: 0200000000000002 ffffffffffffff01
00000000ffffffff 00000000ffffffff
[    9.322969] head: 0000000000000000 0000000000000000
00000000ffffffff 0000000000000000
[    9.323392] page dumped because: kasan: bad access detected
[    9.323697]
[    9.323790] Memory state around the buggy address:
[    9.324056]  ffff888109c9fc80: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    9.324451]  ffff888109c9fd00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    9.324842] >ffff888109c9fd80: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[    9.325234]                             ^
[    9.325459]  ffff888109c9fe00: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[    9.325851]  ffff888109c9fe80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[    9.326243] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
