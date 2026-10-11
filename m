Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F1A1C84CB
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791707093; cv=none; b=Hh/xdCOT0bHx7BwKdyYGx4CcHWIiizmHwHLHO0M7kclC3PfmhX1tKm923Bn83MQr642hIh4tz1jf0x+42arUYUmybbrj+z0rh0fiXDhbGzZITqqOoYHbPpanh/EsJ5k7jZyeldZzooUN/IGEitFluqnSkh7B+vnGttUCjGg91ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791707093; c=relaxed/simple;
	bh=DVlvpcSU+l8MsocvPiXK14zDFL4lPwCgHGawjsFSaV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBL36DdL6H1m2cZ4BGAPj95cjTUtTOgJ+Xk5hJOoGl8QxatFGXWhEw+4+/TyTrlFNBu11CALDCc8Xj8jqsf0Ov3s0ugu6EDvzNE3VhbrYNGTlNbphnPXXftp1AF1KJbkG5mJ6Hw89xUC7NwoMJgs9Sj5zuNsS/I6mSAyTX7cCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIN0R08Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIN0R08Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF101F008A4
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 08:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791707092;
	bh=akBs+Ql74VJDQYf/bJz7IZtF57QSpbzonAG8FFo5X1E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aIN0R08QeTYF8z3n+LPWXdDcOyauwychHtT29FL5Hf0Ltpesb0n/yzXI4OA7+4TiJ
	 ZUT/AdXGa1Ma7CCzQ1mP0Nb2BTglp5AsomEMIsxy3Oek3Hq7vPEf4oitriPNyjwVZJ
	 V0OWhujeDfg05rMzCaFKeo7VSNx7AFWYmk7/B3B2IK6+JifXPTw8z08HIETxKek+qO
	 a2d0oOsJk+2ix+pocGD8wxyjiYvfEJp1T3bdp4I/1U/jXSRRCqvDhWQ/IOB7+5DGYm
	 B+pKwJ/VOCOiUn8RyRiXRjzjtM+pMuQExGyMvd5IwUh1E5ZS6lzYlvA1yadYJicko1
	 MtYOGTJ1ZvlHg==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-499f20c7054so618929fac.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 01:24:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwm0dNN2DRpd3wNh3ToRHBWtjkn/0+mKPZNVFYFxkurQb4uqViYr63NXwzQLI2lEFRztAC1pTU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyFbLHdqpSyia03/WtjWM1GyAmVFIm1gJDO8//3RbJmb0YZn8a
	+4UkbBV/rg61wZnfu35ns8kQ0441IPI9LyCN9VmpP+6GAEJ00FKo6/H3OoHFQAXN9bw0uEVpugC
	WUn8vJd7jrchFjzJmyvDGaiKMHuDcUjE=
X-Received: by 2002:a05:6870:6586:b0:49e:16bf:1f87 with SMTP id
 586e51a60fabf-4a2a8a7ad2cmr4961091fac.38.1791707091176; Sun, 11 Oct 2026
 01:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010152227.401987-1-acassen@corp.free.fr>
In-Reply-To: <20261010152227.401987-1-acassen@corp.free.fr>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 11 Oct 2026 10:24:39 +0200
X-Gmail-Original-Message-ID: <CAL4WiipPLTPOtm9VL+xpf=Bj=SgiPyafsYLynAyns3VNHVGBiA@mail.gmail.com>
X-Gm-Features: AclHuK8canZhdW4krwKcMXeuhtrZQXi4JcLCLKEyTFNxMtLkOk29RB2MYiar9Tw
Message-ID: <CAL4WiipPLTPOtm9VL+xpf=Bj=SgiPyafsYLynAyns3VNHVGBiA@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: act_api: take tcfa_lock for hardware
 stats updates
To: Alexandre Cassen <acassen@corp.free.fr>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 10 oct. 2026 =C3=A0 17:22, Alexandre Cassen <acassen@corp.free.fr> =
a =C3=A9crit :
>
> Actions without per CPU stats update their counters under tcfa_lock in
> the software path but tcf_action_update_stats() adds hardware stats to
> the same counters without it. A dump of a filter without skip_hw does
> this even when nothing is offloaded, so such an action loses counter
> updates. On 32-bit, readers holding tcfa_lock can also observe torn
> 64-bit values.
>
> Callers disable preemption around this update for the per CPU stats.
> PREEMPT_RT forbids taking a spinlock_t with preemption disabled. Disable
> BH in the per CPU path instead. On 32-bit, this also keeps a softirq on
> the same CPU from updating or reading these counters in the middle of
> the update.
>
> Discovered by manual code inspection while letting more actions honor
> TCA_ACT_FLAGS_NO_PERCPU_STATS. Reproduced in a VM without kernel
> changes, where the second action counts fewer packets than the first:
>
>   ip link add d0 type dummy && ip link set d0 up
>   tc qdisc add dev d0 clsact
>   tc filter add dev d0 ingress matchall \
>      action gact pipe action gact pass no_percpu
>   yes "filter show dev d0 ingress" | head -10000 > batch
>   while :; do tc -s -b batch; done > /dev/null &
>   samples/pktgen/pktgen_bench_xmit_mode_netif_receive.sh -i d0 -t 4
>   tc -s filter show dev d0 ingress
>
> The 32-bit issue in the per CPU path comes from the Sashiko AI review
> of v1 [1] and was not reproduced.
>
> Tested with the reproducer and the tc-testing action, matchall and
> flower tests with lockdep enabled. Also tested for regressions on
> ConnectX-7 with firmware 28.48.1000.
>
> Fixes: 5e174d5e73df ("net: sched: modify stats helper functions to suppor=
t regular stats")
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009051703.=
3615846-1-acassen%40corp.free.fr [1]
> Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
> ---

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Thanks!
