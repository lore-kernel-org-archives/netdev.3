Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FDE37D104
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791956859; cv=pass; b=uveVr87871SrURzz6yY9WZPnAbb57ZcAL0158vOLMl7HxEORQUWlYlzVh3m7ZhNjXcuvH+RCopufD0Hf67zuNk+MIA2MEGnUf61KCclUiXnpo3cqUIWzpWtIO1YvopZM0X+3LdR9Vk3No8tf8AZvB1wMYweNvbuXvhemQ7gxGns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791956859; c=relaxed/simple;
	bh=YbfBeWbJZEthnD4ryQGW5UZUJaQkW2epDNscbxcqwg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TaV9my6vz3ZGY1FtZel9EHihZv2iWGDS+HELbt8pdz7T2EUh9Y36fHWChNbNKFOk2TIRiq3upYv1biwA7YmFBmfyv6CkrHRF5awvgzsNXuPD6ROQXjavQGfcmLy6dn+0pttXIiH7cOBpB6yFq15/x4aeJQQ4EUm4WEwL/TBYCW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/gF6cNt; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/gF6cNt"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6d28aa26cso2397505ad.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 22:47:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791956856; cv=none;
        d=google.com; s=arc-20260327;
        b=dpr3zqn3oHRxRXr/XOUxJh0YUbAVyMkToNrnbm4deA+DOWFSS81IP/uzkhG5wfH8hi
         v6ut1hZyRvfVXS7Gk97bmgR05mHWb8hyQA3TCFusakuBQWtaRuVYUY9w8QJPU+b+X/Qy
         nUDm3xiLHUmL3Er9RxbuKnurWiTxJKKkn3lUdboe9uTPePNPFSZjLS08AIWwyGtbYfNu
         h3vIYMzu5mFKf1QtYX9GuX765xmyB6DxV7zo54WH525M8bTfsV5DwXJksZVukq+9kac/
         A/r61ALXtbSUbTuv0zq96lrGqJAfaH3uQZBV9dmtO9/ynP7P5qu6b31jW1Wn7M2lWIx1
         IvtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uiamb8oeOLwbAb3wb/XhlGzdEH5piRR1MJoyLDiXmSc=;
        fh=7tvFzf7/h/ERBLCAtaRoemOUgYeJOw19S3o115KnPlI=;
        b=OLW0DcTe9m/epZ/DiZPxHEq4g9zOEwwOcA0vwC4j7xzYblGR1FjIJ5+eiPnRq1oQRR
         O8olM9tNMPZKCqCmweioIpsOcqiXizmmDKh8PZGEVki2eiLcXCUbeU8j1D20+6I6jtu0
         6pIGUplctkWDHFG7LMzE0dkoRgCdLhdZ1RYliIRfkSnxWPP8HUcFRm0R31S8TopxK0eP
         mQKjn2QKMV1lIGa9PGAENiAhVXald8UL/lf51aNyaNIvbCkK75I6vGyZOhXDxFUe4m0I
         XDfJUavkIGj4YbyytfVYQFhNQEh+1VO9N+zSJRqJJ5QJFXccejXSgcbecs/QXK7hkA+4
         LvBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791956856; x=1792561656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uiamb8oeOLwbAb3wb/XhlGzdEH5piRR1MJoyLDiXmSc=;
        b=Z/gF6cNtyHp8Ol5d/xP89WRsaUZ5DUPKvFS0kUX/7I66arrMK7uOG4CZlJ/iE7N/wP
         cC2llanpEY22/5mWMu1FDYj/QiOd95cUU7nwpgnYsWyfG1LA1Zfw38bDGgGG37I4+eJ8
         nmclLx8XVnc5SSkv8i8IWoTWGXZXsgHRQ6/4IdMD8FXQs8z8M6/8m7EQq00SBWsat0JI
         2LYocGzGqCRvzVfuF9EDp1th4PS5cKiRM9kZWH8YewRGOi6XnMMwfOSgnwVn2PGkuoJs
         yGS41EBn0bqHah1qhB3TebENEifzGeMZBmanaQgBLZFgmAL28wrNHVdUg/FO6a/HNHDX
         gPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791956856; x=1792561656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uiamb8oeOLwbAb3wb/XhlGzdEH5piRR1MJoyLDiXmSc=;
        b=Qegtlk8yvWymkhUyWIR7epRPmE3tXW3m3RJP2WCJroN+9LfFHo8dQMvQvHgqr0r80t
         LKr7bkfn8nJWxBzpvVsPIhc1SkIkMpHXgs9RvzCj7yIirnB1acnyVcLABZ/ONEbTjukH
         Uvb78CGzfEDzcbNhh4zIrLXqWit7XSJry4YPTC5vEiaMTqeCfhoB7GRRUHF8rO+ZpA5i
         +KC+CtWX41tVmxkSNpuIYBy1zG8XodaczOIoRCxHNswgy2x8T5gAvIUg7JiQMWgbY/LZ
         PsWL9A5U+4IILUPsU5H+a53hh5Idc6vQymsCpPW9tdVqXM2x9DZdeoLRzbmpuE+2LhZJ
         khkg==
X-Forwarded-Encrypted: i=1; AKwUvBzLnb4tZMg5eaFWihuRViKE+MJscQ3OgODxIlCUkNRZrjKz5Euf32jxZP5Egt6hpyLDH7grKDA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKyGjgN27HeHB51NaeB2D567DtJp2piJpuVG7g6jqyr+jK4MV72
	NkOeYwGMSzLEuoai4H3b3k17mXHSktKs2NJ0XhJnjU1aNUekJKattl9TkkFp5Ax2r9mEZC/pODw
	GV4ZMUoi7MZd1Bx6z9CpPoHbqfTz3uaoYaXssKcAlig==
X-Gm-Gg: AYBFou27OvG62f7zcU0Ix6KKhP/q80NcTdmAwe2JOL7eguGsj8fhaUh8Zc3pjJA/fqC
	p+x+1ugUJkiQmNMunhxv6AIg2Xu8bMZ7D6FArSAXeUmsU80jAKIqLReI4DvwB0xG3FpYLu7SRo8
	KWh37Ptu/JTP1U0konhDhONmR/pAKScutPY9J1V17tewQkiLhhk2tJTKcMs+YMDbNrz/nL9dTF0
	ytxzYG+9QLRk8IGSX5+/Kz8J1O2iyC4sMLKFZGo+8ZvUYiT2YD5HpI4cyHfTzHZMeHZ1PrwdtfP
	Jzny/fj/t2nKB0c9jiKEPDnZXIadt1Pxw4NRhXH/00OWonv4zjs5LA==
X-Received: by 2002:a17:903:950:b0:2e6:136e:f264 with SMTP id
 d9443c01a7336-2e842dfd193mr123338855ad.50.1791956856254; Tue, 13 Oct 2026
 22:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012060152.2930-1-nashuiliang@gmail.com> <179187482010.434549.10175777615206996282@kernel.org>
 <CAAVpQUBEBPNMqsWChsAhTt47zNaTB5Y13Y5r0cBrmD=LYg2SUA@mail.gmail.com>
In-Reply-To: <CAAVpQUBEBPNMqsWChsAhTt47zNaTB5Y13Y5r0cBrmD=LYg2SUA@mail.gmail.com>
From: chuang <nashuiliang@gmail.com>
Date: Wed, 14 Oct 2026 13:47:24 +0800
X-Gm-Features: AclHuK9QSZrG-IM4DkcQh3w5utaBquVj4fTQvJ0PvX7qLNQJEA0UC__-ARmbHZM
Message-ID: <CACueBy5SMrqQ+EY=P=b96PBWUX6CH7h_xh5=7zUxJ_xtc8Oqqw@mail.gmail.com>
Subject: Re: [PATCH net-next v11] net: reduce ARFS flow updates by checking
 LLC affinity
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf.kernel@gmail.com, 
	liuhangbin@gmail.com, skhawaja@google.com, ncardwell@google.com, 
	roman.gushchin@linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 3:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Tue, Oct 13, 2026 at 12:00=E2=80=AFAM <netdev-bot+sashiko@kernel.org> =
wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 5 potential
> > issue(s) to consider.
> >
> > Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 4
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchw=
ork
> > know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> > (one such reply per series is enough).
> >
> > - [Medium] The new LLC skip in set_rps_cpu() (net/core/dev.c:5196-5199)
> >   assumes that `old_cpu` shows where the NIC currently delivers the flo=
w.
> > - [Low] The new user-visible sysctl net.core.arfs_llc_affinity
> >   (net/core/sysctl_net_core.c:563-569) has no documentation.
> > - [Low] The config guards for the sysctl and its only user do not match=
.
> > - [Low] The commit message says the results "demonstrate that filtering
> >   updates by LLC affinity significantly reduces driver lock contention=
=E2=80=A6
> > - [Low] In this tree, cpus_share_cache() (kernel/sched/core.c:4008-4014=
)
> >   returns `per_cpu(sd_llc_id, a) =3D=3D per_cpu(sd_llc_id, b)`.
> >
> > --
> >
> > net: reduce ARFS flow updates by checking LLC affinity
> >
> > This commit adds an opt-in sysctl, net.core.arfs_llc_affinity. When it =
is
> > set, set_rps_cpu() skips the ARFS hardware steering update
> > (ndo_rx_flow_steer) if the flow's previous RFS CPU and the new one shar=
e
> > an LLC. The rflow->cpu bookkeeping is still updated, so software RFS ke=
eps
> > steering packets to the CPU the application runs on.
> >
> > > These results demonstrate that filtering updates by LLC affinity
> > > significantly reduces driver lock contention and improves overall
> > > CPU efficiency under heavy network load.
> >
> > [Severity: Low]
> >
> > Does the data above support this claim? The only number given is the
> > mlx5e_rx_flow_steer() call rate, which drops from about 200k/s to about
> > 10/s. There are no throughput, latency, CPU utilisation or lock
> > contention numbers.
> >
> > The commit message also leaves out the trade-off. When the hardware
> > update is skipped, the flow stays on its old queue. get_rps_cpu() then
> > hands every packet to next_cpu with a remote enqueue_to_backlog() plus =
an
> > RPS IPI. After a completed ARFS steer, the packet would instead be
> > handled on the queue's own IRQ CPU.
> >
> > The phrase "subsequent packets take the fast path in get_rps_cpu()
> > (tcpu =3D=3D next_cpu)" could be read as local processing. The packets =
are
> > still moved to a remote CPU.
> >
> > The opening paragraph names rps_record_sock_flow() as the motivation.
> > Since v10, though, the patch only changes set_rps_cpu() and get_rps_cpu=
().
> > Could that paragraph be reworded to match?
> >
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index a6951ea08961e..434ad5499906d 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> >
> > [ ... ]
> >
> > > @@ -5179,6 +5180,24 @@ set_rps_cpu(struct net_device *dev, struct sk_=
buff *skb,
> > >               if (!skb_rx_queue_recorded(skb) || !dev->rx_cpu_rmap ||
> > >                   !(dev->features & NETIF_F_NTUPLE))
> > >                       goto out;
> > > +
> > > +             /*
> > > +              * ARFS LLC Affinity Feature:
> > > +              * Reduce ARFS flow updates by checking LLC affinity.
> > > +              *
> > > +              * Frequent flow table updates can trigger constant har=
dware steering
> > > +              * reconfigurations (e.g., ndo_rx_flow_steer), leading =
to significant
> > > +              * contention on driver internal locks (like mlx5's arf=
s_lock).
> > > +              *
> > > +              * Skip the expensive hardware steering update if the f=
low's previous
> > > +              * target CPU and the new one share the last level cach=
e: cache locality
> > > +              * for the application is preserved either way.
> > > +              */
> > > +             if (static_branch_unlikely(&arfs_llc_affinity) &&
> > > +                 old_cpu < nr_cpu_ids && cpu_online(old_cpu) &&
> > > +                     cpus_share_cache(old_cpu, next_cpu))
> > > +                     goto out;
> >
> > [Severity: Medium]
> >
> > Is old_cpu a reliable sign of where the NIC currently delivers this flo=
w?
> >
> > get_rps_cpu() passes in tcpu =3D rflow->cpu. That value is read from th=
e
> > hashed slot in the flow table of the queue the packet arrived on. It on=
ly
> > records the last software RFS target for that slot, and it may have no
> > hardware filter behind it. For example:
> >
> > - ndo_rx_flow_steer() returned rc < 0, but set_rps_cpu() still did
> >   WRITE_ONCE(rflow->cpu, next_cpu) on the arrival queue's slot.
> >   mlx5e_rx_flow_steer() can return -EPROTONOSUPPORT, -ENOMEM, or -EPERM
> >   while MLX5E_ARFS_STATE_ENABLED is clear.
> >
> > - The tmp_rflow collision check or the !q_tag_ptr check took goto out.
> >
> > - The slot still holds a CPU left by an earlier flow that hashed to the
> >   same rfs_slot(). store_rps_dev_flow_table_cnt() sets RPS_NO_CPU only
> >   when the table is allocated.
> >
> > - The driver flushed or re-created its filters.
> >
> > In each of these cases, if old_cpu and next_cpu share an LLC, the new
> > check skips ndo_rx_flow_steer() and then reaches:
> >
> >         WRITE_ONCE(rflow->cpu, next_cpu);
> >
> > On later packets tcpu =3D=3D next_cpu, so get_rps_cpu() never calls
> > set_rps_cpu() again. Hardware steering is not retried while the
> > application stays within that LLC. A new flow that lands on a stale slo=
t
> > in the same LLC would never get an ARFS filter at all.
> >
> > Before this patch, every CPU change triggered a new steering attempt, s=
o
> > a failed or missing filter recovered on its own.
> >
> > Without a filter, the flow stays on its RSS queue, which may be service=
d
> > in another LLC or NUMA node. Every packet is then handed over by softwa=
re
> > RFS. cpu_rmap_update() ranks queues by sibling, package and NUMA node,
> > not by LLC. Nothing guarantees an LLC relationship between the receivin=
g
> > queue and old_cpu. Doesn't that contradict "cache locality for the
> > application is preserved either way"?
> >
> > Could the skip be limited to the case where this flow has a live
> > hardware filter, for example rflow->filter !=3D RPS_NO_FILTER &&
> > rflow->hash =3D=3D hash? Another option would be to compare next_cpu wi=
th
> > the CPU that actually services the receiving queue, rather than with
> > rflow->cpu.
>
> Eric used raw_smp_processor_id() in the v9 thread:
> https://lore.kernel.org/netdev/CANn89iJkPPXruitnot9D28Xe5LWnD-irtgCUEOpmF=
fVkG4M=3D-g@mail.gmail.com/

Eric was only giving an example there. When adding the LLC check to
set_rps_cpu(), it is old_cpu (rflow->cpu) that should enter the
comparison, not the current CPU.
>
> >
> > [Severity: Low]
> >
> > Can cpus_share_cache() return true here for CPUs in different LLCs? In
> > this tree it is:
> >
> > kernel/sched/core.c:cpus_share_cache() {
> >         if (this_cpu =3D=3D that_cpu)
> >                 return true;
> >
> >         return per_cpu(sd_llc_id, this_cpu) =3D=3D per_cpu(sd_llc_id, t=
hat_cpu);
> > }
> >
> > sd_llc_id defaults to -1. It is assigned only in build_sched_domains()
> > and reset to -1 by __sched_domains_free_llc_id().
> >
> > sched_cpu_deactivate() calls sched_domains_free_llc_id(cpu) while the C=
PU
> > is still in cpu_online_mask. CPUs outside any sched domain, such as
> > isolcpus=3Ddomain CPUs, keep -1 permanently.
> >
> > The new check guards old_cpu only with cpu_online(), and next_cpu only
> > with nr_cpu_ids. If both CPUs carry the -1 sentinel, they compare as
> > sharing an LLC and ndo_rx_flow_steer() is skipped. That could happen wh=
en
> > an application migrates between two isolated CPUs in different LLCs, or
> > during a hotplug window.
> >
> > The sentinel handling belongs to the scheduler, but should this new
> > networking user guard against it?
> >
> > > +
> > >               rxq_index =3D cpu_rmap_lookup_index(dev->rx_cpu_rmap, n=
ext_cpu);
> > >               if (rxq_index =3D=3D skb_get_rx_queue(skb))
> > >                       goto out;
> >
> > [ ... ]
> >
> > > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > > index 473c162736d69..9ce0bbe454c83 100644
> > > --- a/net/core/sysctl_net_core.c
> > > +++ b/net/core/sysctl_net_core.c
> > > @@ -560,6 +560,13 @@ static struct ctl_table net_core_table[] =3D {
> > >               .mode           =3D 0644,
> > >               .proc_handler   =3D rps_sock_flow_sysctl
> > >       },
> > > +     {
> > > +             .procname       =3D "arfs_llc_affinity",
> > > +             .data           =3D &arfs_llc_affinity.key,
> > > +             .maxlen         =3D sizeof(arfs_llc_affinity.key),
> > > +             .mode           =3D 0644,
> > > +             .proc_handler   =3D proc_do_static_key
> > > +     },
> > >  #endif
> >
> > [Severity: Low]
> >
> > Should this entry, and the arfs_llc_affinity definition in
> > net/core/dev.c, be under CONFIG_RFS_ACCEL instead of CONFIG_RPS?
> >
> > The only reader, static_branch_unlikely(&arfs_llc_affinity) in
> > set_rps_cpu(), sits inside #ifdef CONFIG_RFS_ACCEL. RFS_ACCEL can be
> > turned off on its own ("depends on RPS" in net/Kconfig).
> >
> > On CONFIG_RPS=3Dy, CONFIG_RFS_ACCEL=3Dn kernels,
> > /proc/sys/net/core/arfs_llc_affinity is still registered and accepts
> > writes that flip the key, but nothing changes.
> >
> > [Severity: Low]
> >
> > This isn't a bug, but net.core.arfs_llc_affinity isn't documented in
> > Documentation/admin-guide/sysctl/net.rst. That file covers other
> > net.core knobs, such as rps_default_mask and high_order_alloc_disable.
> >
> > The Accelerated RFS section of Documentation/networking/scaling.rst als=
o
> > still says:
> >
> >   The network stack automatically calls this function every time a flow
> >   entry in rps_dev_flow_table is updated.
> >
> > With the knob enabled, set_rps_cpu() now updates rflow->cpu and
> > rflow->last_qtail without calling ndo_rx_flow_steer() whenever the two
> > CPUs share an LLC.
> >
> > Could the documentation describe the new knob, its default (0) and
> > accepted values, and this exception in scaling.rst?
> >
> > --
> > Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/pat=
chset/20261012060152.2930-1-nashuiliang%40gmail.com
