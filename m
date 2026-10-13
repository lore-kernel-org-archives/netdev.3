Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688BF31F986
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791875254; cv=pass; b=HVvHpitT436DtVXNFX9lQ0ufoHOAzPyhZxQU4zZVc1NrTh9WBLkICXWHmjTdoKDnULEv0OCvAS9YQmArstOILbCD0XHCR8ghj9wF15SiV+eux53nty7wNTLDPeCyEhSyrUOGYEL4OULc9PsmH2Tchp/gCf4hGmIrSf9cbA6FtiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791875254; c=relaxed/simple;
	bh=oXyc8GuTOf52/4BncIPkQWfGRE4BC3arhoX1HvczZLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJkjj/gHlA6gwT4OHK+WGBbwRpryG9sJ3T4IXshqfLqli/ihh9kNii0rLqagw7umskTsrxgPgg5wWpH9q449OOXcXgfYd3Jp3vbOStPgPi0OCJjvfx8PzZzmAqJy467nP66OkJ+JnhegFumEhEsqxxMEH+amwjyMKjD7LX5akvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/UuYL+V; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/UuYL+V"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-15ea896ddc8so3717883c88.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 00:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791875251; cv=none;
        d=google.com; s=arc-20260327;
        b=ASWnthh2/yTa0wo4Tra6beLpcXY99tfzIR+k/k0kyJt1vkl871b358ZtrOIjL6Ece6
         t/R6pzmR6zJ22MBWAIyIUTPnk68P8Xxjan78qfdccL/800WxLUV2Tdneb1nKnh8IL6P/
         2sdQc42XvB0TG93tiMjPuzUJwxq+szJy4jRPeysVOafu2FiLUANqibtsyLIVP3qCJglr
         IMBBfrqrBXLUcT4Le6tg5wLEZDkdP7Xjz0ORsl/NBgJLmgGveyVgVHz1PnEAT2u04Lm7
         AF6HNMxOqUvGvL7tF9VbCJkk2xdMxOZUXqp3sRzd5TNRvc4BaADv0N1IZwKGq/81j/ms
         uEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nlQ4HdbyutB2k+eyayYrtNRFvZWrd3c6UOg+ikmNles=;
        fh=SmrD7DlACWCYuBNatgKDUpNdxpAERNOmEmyqMtsqWXg=;
        b=KsqM6afySqoWlnQl7Ylc3vuJ3ms1SE91RT3bu8xJSBLi7IbZsvuyshned0lC15IcUk
         Ov1fRNEIiMT887wA/SEkBlcBcp7CTxnNVG0+j+yjzce6+BdN3NnyVdorJShLgswlD/WW
         uM7M0kkX3CkcsFl19Pd9cr9I0WqpMsq8VhMp9UzDrxf1M5hwK9jC/c/wdESxChzpfd6u
         OQ3Bd4nTnOCxahB0gOsxbNgd+eRmQU+O8Zaz0lvUjJOIUDtqigWh11RRUGfDnYEXcxDX
         /MbvlTDeyIci98tbwSTkQqhEzBJ4JcfqbUMX9hHtrmS6cVylfTzoey948qiK+LPFB5GM
         r39g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791875251; x=1792480051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nlQ4HdbyutB2k+eyayYrtNRFvZWrd3c6UOg+ikmNles=;
        b=M/UuYL+V70xKIIwJWc2yffs1gzpPjlzpaY3VuFED6Gr0y1Vu1oeCMEDr6/CZAfhEJf
         IpzLnCltj4c1GkNPZ8Dcu4zkfQEUPrXD3TOt0KE8PzKrOBqf7ZIn/LGhrEt49YsTKKRD
         MwCOQ5QGlmsAmAtMxUCOPGjijAjs+MP8AvAXVH1uJlL5dydCETwE1li4u0lId9te4H3b
         9c+J6dFt+Nsn0K9GGGYSLAIxWQ23B51ILN/niQyEh7HeWs5JsLx2PT5LN6TDjRjgHuOd
         6OaTPuW80HX6mJaqErb1qEdLuj4fsv5NCY5InCPlQ/LQ2iADXEkIqiG8vtnoNxVdYjhY
         pQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791875251; x=1792480051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nlQ4HdbyutB2k+eyayYrtNRFvZWrd3c6UOg+ikmNles=;
        b=1jJZkxtdS3rYE6ZUXg0f5VmkrUeGsRCv2LUWDxqIV9JdvYDADhrgj0xIwZ2WG6yMsw
         Yn7OLabM/tADLq0Nrj1LI8J8HymgkkLjDGzh0ko3MdawO3aFnTmKR2TvUPS44TO302sd
         kvaVBsh9GaC/+zxsCWM32dIiysSfT3bZXBAQrohrCQG/Q3DBrDTMSpzX574nJQ593lbq
         a/D9f1Xoup+FA6So4hnwNRPPUayRvCoZB24Xd48PWHFMXjKrLlSsTk70sdIzv8MYvDna
         XaJUBU8N9KXCUYfeLHlaIHbDFJFggIuKV0wNB2wUvoFfgOzcyz/bg4j6TuzipAngLPxT
         h4Bg==
X-Forwarded-Encrypted: i=1; AKwUvBz986az6Y843jKmdF8B5vNNGYdCBzLfYugmmx4eNZ6oucUHKGynElF0Q0TfGtip/uvFlH8GDX0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjxmu90JrLw13yKh5jTUSEbQ6fBpzcAVcwLXpGtOPJFYB/5e4P
	ewULiFli8CEmhwlVl1ZOCxQeuOdHVYVdaswLSQlAvXOl659Xe6G+aDKinG20EoR9VHZdJwrEhhH
	xjS/Z0YP9CRFUfaS1PsdrLypjinbN3BezY/v9t7IB
X-Gm-Gg: AYBFou1zGXrF8GlvMd91p3zwG6x/RAipKyoF3MYOfszoJ1lTXB24uS7VKK7PdB4kogs
	4uhmctg5t2XLh4W99Qbe61EbjcgOgOv8c22ew9jd1P7jNQqyr7VWuMtjrGRDZBOrXOqn8Y5M3Nz
	G2p3qRx6aJZBV2APD+bK1FyNXJFQIt+Jc718pxqa5OCere0z5eNzEAHVBkohUcYShKaJgOQSnRx
	f2Z4OsNNkN8HGciGN9ZdPU/S0iCZqJISjqS8Rfv5SqFD83QiN3TtaqcIihmNR6lVtyNLc6YZ9z5
	s9JEpA27+bFJQPX0TYzSpP98w9PbedD3GB2QKhGi6XvPABtPjTPLYtyw/Xq00L2yU+i//6n7je2
	BV+DpMHTL7fQbMejv9gpQDDnEGqv3uLIHxfDGaVOoaZu8OJN1cQ6HQXKlxYXdKYO0T+mAUOe9Es
	VSgvuPbPe4HH89jZYIAqPFYdQo
X-Received: by 2002:a05:701b:4506:20b0:14a:8cff:fbb8 with SMTP id
 a92af1059eb24-16a6081143cmr15076986c88.28.1791875250520; Tue, 13 Oct 2026
 00:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012060152.2930-1-nashuiliang@gmail.com> <179187482010.434549.10175777615206996282@kernel.org>
In-Reply-To: <179187482010.434549.10175777615206996282@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 13 Oct 2026 00:07:18 -0700
X-Gm-Features: AclHuK_qLoE1qaHmsDAUK6leR_AX-pzKQ_LHFF1aVMB4WDdWUsaNoh4FTBWFZyo
Message-ID: <CAAVpQUBEBPNMqsWChsAhTt47zNaTB5Y13Y5r0cBrmD=LYg2SUA@mail.gmail.com>
Subject: Re: [PATCH net-next v11] net: reduce ARFS flow updates by checking
 LLC affinity
To: netdev-bot+sashiko@kernel.org
Cc: nashuiliang@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf.kernel@gmail.com, 
	liuhangbin@gmail.com, skhawaja@google.com, ncardwell@google.com, 
	roman.gushchin@linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 12:00=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wr=
ote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 4
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] The new LLC skip in set_rps_cpu() (net/core/dev.c:5196-5199)
>   assumes that `old_cpu` shows where the NIC currently delivers the flow.
> - [Low] The new user-visible sysctl net.core.arfs_llc_affinity
>   (net/core/sysctl_net_core.c:563-569) has no documentation.
> - [Low] The config guards for the sysctl and its only user do not match.
> - [Low] The commit message says the results "demonstrate that filtering
>   updates by LLC affinity significantly reduces driver lock contention=E2=
=80=A6
> - [Low] In this tree, cpus_share_cache() (kernel/sched/core.c:4008-4014)
>   returns `per_cpu(sd_llc_id, a) =3D=3D per_cpu(sd_llc_id, b)`.
>
> --
>
> net: reduce ARFS flow updates by checking LLC affinity
>
> This commit adds an opt-in sysctl, net.core.arfs_llc_affinity. When it is
> set, set_rps_cpu() skips the ARFS hardware steering update
> (ndo_rx_flow_steer) if the flow's previous RFS CPU and the new one share
> an LLC. The rflow->cpu bookkeeping is still updated, so software RFS keep=
s
> steering packets to the CPU the application runs on.
>
> > These results demonstrate that filtering updates by LLC affinity
> > significantly reduces driver lock contention and improves overall
> > CPU efficiency under heavy network load.
>
> [Severity: Low]
>
> Does the data above support this claim? The only number given is the
> mlx5e_rx_flow_steer() call rate, which drops from about 200k/s to about
> 10/s. There are no throughput, latency, CPU utilisation or lock
> contention numbers.
>
> The commit message also leaves out the trade-off. When the hardware
> update is skipped, the flow stays on its old queue. get_rps_cpu() then
> hands every packet to next_cpu with a remote enqueue_to_backlog() plus an
> RPS IPI. After a completed ARFS steer, the packet would instead be
> handled on the queue's own IRQ CPU.
>
> The phrase "subsequent packets take the fast path in get_rps_cpu()
> (tcpu =3D=3D next_cpu)" could be read as local processing. The packets ar=
e
> still moved to a remote CPU.
>
> The opening paragraph names rps_record_sock_flow() as the motivation.
> Since v10, though, the patch only changes set_rps_cpu() and get_rps_cpu()=
.
> Could that paragraph be reworded to match?
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index a6951ea08961e..434ad5499906d 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
>
> [ ... ]
>
> > @@ -5179,6 +5180,24 @@ set_rps_cpu(struct net_device *dev, struct sk_bu=
ff *skb,
> >               if (!skb_rx_queue_recorded(skb) || !dev->rx_cpu_rmap ||
> >                   !(dev->features & NETIF_F_NTUPLE))
> >                       goto out;
> > +
> > +             /*
> > +              * ARFS LLC Affinity Feature:
> > +              * Reduce ARFS flow updates by checking LLC affinity.
> > +              *
> > +              * Frequent flow table updates can trigger constant hardw=
are steering
> > +              * reconfigurations (e.g., ndo_rx_flow_steer), leading to=
 significant
> > +              * contention on driver internal locks (like mlx5's arfs_=
lock).
> > +              *
> > +              * Skip the expensive hardware steering update if the flo=
w's previous
> > +              * target CPU and the new one share the last level cache:=
 cache locality
> > +              * for the application is preserved either way.
> > +              */
> > +             if (static_branch_unlikely(&arfs_llc_affinity) &&
> > +                 old_cpu < nr_cpu_ids && cpu_online(old_cpu) &&
> > +                     cpus_share_cache(old_cpu, next_cpu))
> > +                     goto out;
>
> [Severity: Medium]
>
> Is old_cpu a reliable sign of where the NIC currently delivers this flow?
>
> get_rps_cpu() passes in tcpu =3D rflow->cpu. That value is read from the
> hashed slot in the flow table of the queue the packet arrived on. It only
> records the last software RFS target for that slot, and it may have no
> hardware filter behind it. For example:
>
> - ndo_rx_flow_steer() returned rc < 0, but set_rps_cpu() still did
>   WRITE_ONCE(rflow->cpu, next_cpu) on the arrival queue's slot.
>   mlx5e_rx_flow_steer() can return -EPROTONOSUPPORT, -ENOMEM, or -EPERM
>   while MLX5E_ARFS_STATE_ENABLED is clear.
>
> - The tmp_rflow collision check or the !q_tag_ptr check took goto out.
>
> - The slot still holds a CPU left by an earlier flow that hashed to the
>   same rfs_slot(). store_rps_dev_flow_table_cnt() sets RPS_NO_CPU only
>   when the table is allocated.
>
> - The driver flushed or re-created its filters.
>
> In each of these cases, if old_cpu and next_cpu share an LLC, the new
> check skips ndo_rx_flow_steer() and then reaches:
>
>         WRITE_ONCE(rflow->cpu, next_cpu);
>
> On later packets tcpu =3D=3D next_cpu, so get_rps_cpu() never calls
> set_rps_cpu() again. Hardware steering is not retried while the
> application stays within that LLC. A new flow that lands on a stale slot
> in the same LLC would never get an ARFS filter at all.
>
> Before this patch, every CPU change triggered a new steering attempt, so
> a failed or missing filter recovered on its own.
>
> Without a filter, the flow stays on its RSS queue, which may be serviced
> in another LLC or NUMA node. Every packet is then handed over by software
> RFS. cpu_rmap_update() ranks queues by sibling, package and NUMA node,
> not by LLC. Nothing guarantees an LLC relationship between the receiving
> queue and old_cpu. Doesn't that contradict "cache locality for the
> application is preserved either way"?
>
> Could the skip be limited to the case where this flow has a live
> hardware filter, for example rflow->filter !=3D RPS_NO_FILTER &&
> rflow->hash =3D=3D hash? Another option would be to compare next_cpu with
> the CPU that actually services the receiving queue, rather than with
> rflow->cpu.

Eric used raw_smp_processor_id() in the v9 thread:
https://lore.kernel.org/netdev/CANn89iJkPPXruitnot9D28Xe5LWnD-irtgCUEOpmFfV=
kG4M=3D-g@mail.gmail.com/


>
> [Severity: Low]
>
> Can cpus_share_cache() return true here for CPUs in different LLCs? In
> this tree it is:
>
> kernel/sched/core.c:cpus_share_cache() {
>         if (this_cpu =3D=3D that_cpu)
>                 return true;
>
>         return per_cpu(sd_llc_id, this_cpu) =3D=3D per_cpu(sd_llc_id, tha=
t_cpu);
> }
>
> sd_llc_id defaults to -1. It is assigned only in build_sched_domains()
> and reset to -1 by __sched_domains_free_llc_id().
>
> sched_cpu_deactivate() calls sched_domains_free_llc_id(cpu) while the CPU
> is still in cpu_online_mask. CPUs outside any sched domain, such as
> isolcpus=3Ddomain CPUs, keep -1 permanently.
>
> The new check guards old_cpu only with cpu_online(), and next_cpu only
> with nr_cpu_ids. If both CPUs carry the -1 sentinel, they compare as
> sharing an LLC and ndo_rx_flow_steer() is skipped. That could happen when
> an application migrates between two isolated CPUs in different LLCs, or
> during a hotplug window.
>
> The sentinel handling belongs to the scheduler, but should this new
> networking user guard against it?
>
> > +
> >               rxq_index =3D cpu_rmap_lookup_index(dev->rx_cpu_rmap, nex=
t_cpu);
> >               if (rxq_index =3D=3D skb_get_rx_queue(skb))
> >                       goto out;
>
> [ ... ]
>
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index 473c162736d69..9ce0bbe454c83 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -560,6 +560,13 @@ static struct ctl_table net_core_table[] =3D {
> >               .mode           =3D 0644,
> >               .proc_handler   =3D rps_sock_flow_sysctl
> >       },
> > +     {
> > +             .procname       =3D "arfs_llc_affinity",
> > +             .data           =3D &arfs_llc_affinity.key,
> > +             .maxlen         =3D sizeof(arfs_llc_affinity.key),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_do_static_key
> > +     },
> >  #endif
>
> [Severity: Low]
>
> Should this entry, and the arfs_llc_affinity definition in
> net/core/dev.c, be under CONFIG_RFS_ACCEL instead of CONFIG_RPS?
>
> The only reader, static_branch_unlikely(&arfs_llc_affinity) in
> set_rps_cpu(), sits inside #ifdef CONFIG_RFS_ACCEL. RFS_ACCEL can be
> turned off on its own ("depends on RPS" in net/Kconfig).
>
> On CONFIG_RPS=3Dy, CONFIG_RFS_ACCEL=3Dn kernels,
> /proc/sys/net/core/arfs_llc_affinity is still registered and accepts
> writes that flip the key, but nothing changes.
>
> [Severity: Low]
>
> This isn't a bug, but net.core.arfs_llc_affinity isn't documented in
> Documentation/admin-guide/sysctl/net.rst. That file covers other
> net.core knobs, such as rps_default_mask and high_order_alloc_disable.
>
> The Accelerated RFS section of Documentation/networking/scaling.rst also
> still says:
>
>   The network stack automatically calls this function every time a flow
>   entry in rps_dev_flow_table is updated.
>
> With the knob enabled, set_rps_cpu() now updates rflow->cpu and
> rflow->last_qtail without calling ndo_rx_flow_steer() whenever the two
> CPUs share an LLC.
>
> Could the documentation describe the new knob, its default (0) and
> accepted values, and this exception in scaling.rst?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261012060152.2930-1-nashuiliang%40gmail.com
