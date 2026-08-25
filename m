Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2097081E
	for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646318; cv=pass; b=OJ3l7udm5xNhEmuFHIz9LPCoadOT4wtvg3ymQ0p8NZBjFUdXkN5WsaLLOIzgDWPLilF+1QmOIgF4ytjrHLvYAs3FjqZPYEfETb/4Ew/L6TrMJMVcGaWH7YsKwVwiPrYbbRC0TezTot1TaUgRVN0Q62UPUR3ttXIj2ABKUamvamM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646318; c=relaxed/simple;
	bh=3TMz8h2Y8ZQoWtofq7tItPR1wT/1suBMVbMvtgRSOIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0ZjBuAQAHzNQPtuEgAAJlyGTaCW81maJ4tOsSlSNhLrElvtmZMfRC/SzgPN8nSjkFq6csGh9Tdlw28A2v5fCOk5wsZNEdnkFz1ablkfgcqCxKMXnDvREnqB0iDD1/dmwqt+BZUQ126xdKYeApaMsvjmrJJHFljAFn6xVf+fQsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=OwGcgVca; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="OwGcgVca"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so5317726a12.2
        for <netdev@vger.kernel.org>; Tue, 25 Aug 2026 01:25:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787646315; cv=none;
        d=google.com; s=arc-20260327;
        b=cd/9Y8pGPDfWy8+kkw0Yu6CKyZvbHhOCHESZ4kymjuDw1Lc1FGpGOay1+udr0KKcb3
         zdO+MxOKvIByhthxpwxmxJo3O4apq9HIwtUBPAlVLlyQy7Pj3eI+xRXQbVpjxf62QrPR
         jxAC+g16H1ss5DFiMFYadJDd2r5ZtZNH6od7tI+v4PCJbQCJODl2Fs8Ai89IlRRy2jce
         m3aVH18LKooiItftA6F9M0KHqchAojrIEDYcR0+LkUW1P928n/W4XRu+O/N6DCuHdr2B
         x1JoaVNPEUH/RwqPkdMcTDVxJ9PJ9fQo8dOwt7uDGXSNW+XNeX+qbUPuJ7kr6aQBflaf
         wzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V73eJTudFd9I8NjZ0GGHxF6IYaPPj1gbpXxYmvbqF/U=;
        fh=Ae1Jar1WbhSl8cU14ip1TiFo9Lgr+4RhPAQNDHDRojI=;
        b=OCEMIMF89DRJGnm3WsFBTIQ3iHrUqEG/XsqdLQrUuO+vhBVSfW0g+57Pf434RONgMX
         06TV49Tqku49hibRBE5GsqClGeJ8hAQMkaq4ljLJlmikfhUb2QifkxEN4rzBMeT42R7x
         fkbQczBFiip47oBhd0u1LYqd0FzOulhXiQb/GWaUBw/ygkt9mgmpnEOuY/8BLf/DuV5d
         Y/G0Z2lxWO0rJ44ZD4qmij3qNCck/ekGbxtmuRduW3bW4WsrQYWy5IiLN6gdCacl9PCN
         iKq1dYuxEpDZkd7YZIy7Gpoz0DKjwz385RHtr48/0T5fsIcIHgomQUCGH4BeHWHaiiAG
         W39w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787646315; x=1788251115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V73eJTudFd9I8NjZ0GGHxF6IYaPPj1gbpXxYmvbqF/U=;
        b=OwGcgVcadoi2DXOYHB71EY5ZA9rkmCjRUUcyjOptaHBgC+zX7qEhbSuv7brL9bYfPB
         tuQOKabUfMRAcx3XBqEUNE11khZIDp6zj6ueF7i0Ub9H9lMCR8T/I1W/jh+tahp7Vi0+
         qBEoBNT46Bp4c8j1lXVU2xLZEcMra9dmq0xhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646315; x=1788251115;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V73eJTudFd9I8NjZ0GGHxF6IYaPPj1gbpXxYmvbqF/U=;
        b=MyohG7iyUIr57VWveKgq1nds5poXMlchzE2d1NNw5ruYJGmBOpwItk6ugAxwCk2Jg2
         L/oy2qG+rtHltsBx7Fow7hN1dYxbV5neV5/bGzTZAmvPCtW/0OcECLSL8fg1xakUdKAI
         nxDluZ31vTVn8nD764/ovrXmfZJNZbc3h9eS7HI2T/3piCMK1HA1yv9XufOiWHQ9FfVt
         mpC+meLtl2/kqer0yHqHZIevH2BWfoLVbEYYl9BnZDn+rhyG28TMQADg1uFUa9+B54Z0
         kTRTseC06TPv1Lbg0DZT9uL1kIsP3y6SUsUykbQJePUHnu6Nev75GAQ7FVteblJQd/R2
         bq4g==
X-Forwarded-Encrypted: i=1; AHgh+RrMrfsjiTv8dF8AOZ1PyjxKcKXuVhvJJ3Y+ewLwttrpjLd8i3H+vWhF+qlQDPdHH2xR7HB9Q8A=@vger.kernel.org
X-Gm-Message-State: AFuF++mJwGzRfxZEC6/IKU65jBLqC9l55lY3Sdw0wU885/gDy694U9lE
	DZsJNEfmB8/5f+9OxDUHFmuHbqrKmgdVvqpUr4Z0ujli8KoO8Swo1+fK7jhrg0r/0PcM0zgyNKY
	hNirWjU759VDIxUV2Cz43aYFNVaPfvWYiuTYQuwms
X-Gm-Gg: AR+sD12DbUKmltm5W/3cPlTOC6ZoUCJcv1pFWO92Kss7fy//cv3lT8DkI7Rufn6AI2m
	rTQvqS9pqGJrsW0mAKR545gmB6VS9bzZbEwsCOC5J9JwGVumQeTypELcqK+GkRARCiJ+iLhOzjw
	m3pBqb4fqYNcjOVNLVvsjtMPb5oN9H2TbEwp24iWwNnUeyeaTKgrMqNy3RbHegY54excgEJCCm5
	+sjQd95XPm8NB1/7e7iFoq+6cZ7azY8OrwCWEvJrvg5Qc7PnNDQqypDyLxMhwHw0iIyE0HsJ0Qz
	3Or0wKWfg3VKvt14ysu79Veh13t9FieG9lAvo2onhbeWuA==
X-Received: by 2002:a05:6a00:ab86:b0:851:8baf:5b26 with SMTP id
 d2e1a72fcca58-851fa040526mr60792876b3a.14.1787646315494; Tue, 25 Aug 2026
 01:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822202012.2229309-1-kuba@kernel.org> <tencent_4ED9536B0375C96183B2244CF7709768C605@qq.com>
In-Reply-To: <tencent_4ED9536B0375C96183B2244CF7709768C605@qq.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Aug 2026 04:25:04 -0400
X-Gm-Features: AcwNN1VTUW0ohbErN4JmJ0_Ujz8mDoUXINqJV_4TP4R3c2TARHi5tmJRa-c01So
Message-ID: <CAM0EoMmHMFQ+mATPoHv-5uyN9++Lch7MDjHsC7eu=NVapRB2bQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/sched: act_gate: Limit the max value for cycletime
To: Edward Adam Davis <eadavis@qq.com>
Cc: kuba@kernel.org, Po.Liu@nxp.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jiri@resnulli.us, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 12:07=E2=80=AFAM Edward Adam Davis <eadavis@qq.com>=
 wrote:
>
> If the user passes a cycletime value of 0xFFFFFFFFFFFFFFFFULL,
> an overflow occurs during the assignment of cycle in gate_timer_func():
>
> cycle =3D p->tcfg_cycletime; // overflow, cycle =3D -1
>
> Since the local variable cycle is declared as ktime_t (i.e., s64),
> the assignment overflows.
>

Review the sashiko feedback. At least two of those concerns look legit
and need to be addressed:
1) complaint about timer disarm on replace 2) INT_MAX being too narrow

cheers,
jamal
> This leads to an incorrect calculation of the close_time value.
> Ultimately, the new hrtimer expiry time becomes less than now, causing
> __hrtimer_run_queues() to execute the "timer callback" for an excessively
> long period, which triggers a soft lockup. [1]
>
> Another factor is that the passed interval value is 1; while this acceler=
ates
> the problematic progression of close_time, it is not the decisive factor =
in
> the issue described in [1].
>
> When initializing cycletime, ensuring its value does not exceed INT_MAX
> guarantees that the hrtimer can correctly calculate a valid expiry time.
>
> [1]
> watchdog: BUG: soft lockup - CPU#1 stuck for 3s! [syz-executor291:5020]
> pc : seqcount_lockdep_reader_access+0xd8/0xf8 include/linux/seqlock.h:76
> Call trace:
>  arch_local_irq_restore arch/arm64/include/asm/irqflags.h:195 [inline] (P=
)
>  seqcount_lockdep_reader_access+0xd8/0xf8 include/linux/seqlock.h:75 (P)
>  ktime_get+0x68/0x218 kernel/time/timekeeping.c:971
>  gate_get_time+0x1c/0xa4 net/sched/act_gate.c:23
>  gate_timer_func+0x1a8/0x390 net/sched/act_gate.c:101
>  __run_hrtimer kernel/time/hrtimer.c:2032 [inline]
>  __hrtimer_run_queues+0x314/0xbe0 kernel/time/hrtimer.c:2096
>  hrtimer_run_softirq+0x15c/0x21c kernel/time/hrtimer.c:2113
>  handle_softirqs+0x2ec/0xd98 kernel/softirq.c:622
>  __do_softirq+0x14/0x20 kernel/softirq.c:656
>  ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:78
>  call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:885
>  do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:83
>  invoke_softirq kernel/softirq.c:503 [inline]
>  __irq_exit_rcu+0x1ac/0x428 kernel/softirq.c:735
>  irq_exit_rcu+0x14/0x84 kernel/softirq.c:752
>  __el1_irq arch/arm64/kernel/entry-common.c:531 [inline]
>  el1_interrupt+0x40/0x60 arch/arm64/kernel/entry-common.c:543
>  el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:548
>  el1h_64_irq+0x6c/0x70 arch/arm64/kernel/entry.S:586
>  __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:26 [inline] (P=
)
>  arch_local_irq_enable arch/arm64/include/asm/irqflags.h:48 [inline] (P)
>  __local_bh_enable_ip+0x1f0/0x35c kernel/softirq.c:455 (P)
>  local_bh_enable include/linux/bottom_half.h:33 [inline]
>  __alloc_skb+0x1c8/0x610 net/core/skbuff.c:699
>  alloc_skb include/linux/skbuff.h:1384 [inline]
>  alloc_skb_with_frags+0xb8/0x690 net/core/skbuff.c:6775
>  sock_alloc_send_pskb+0x740/0x850 net/core/sock.c:3012
>  unix_dgram_sendmsg+0x434/0x1078 net/unix/af_unix.c:2137
>  sock_sendmsg_nosec net/socket.c:775 [inline]
>
> Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
> Reported-by: syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D0054fed3dc9085390f51
> Tested-by: syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
> v1 -> v2: return -EINVAL with NL_SET_BAD_ATTR
>
>  net/sched/act_gate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index fdbfcaa3e2ab..30bcf173274c 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -501,6 +501,14 @@ static int tcf_gate_init(struct net *net, struct nla=
ttr *nla,
>                         cycle =3D ktime_add_ns(cycle, entry->interval);
>                 cycletime =3D cycle;
>         }
> +
> +       if (cycletime < 0 || cycletime > INT_MAX) {
> +               NL_SET_ERR_MSG(extack, "'cycle_time' is too big");
> +               err =3D -EINVAL;
> +               spin_unlock_bh(&gact->tcf_lock);
> +               goto err_free;
> +       }
> +
>         p->tcfg_cycletime =3D cycletime;
>         p->tcfg_cycletime_ext =3D cycletime_ext;
>
> --
> 2.43.0
>
