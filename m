Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3FE3D75A0
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 12:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791722140; cv=pass; b=AQVA/IOmUa8iPuOhC48zaV/wShe2sqeAily7rfrwR0JKAqOY+tGiWn1C1TF15JoMF8qKTU+gBAd4FsTyyV4kV2mAcqsl6h29IGJAu1dydC+2cmu/HGg7ltZZPgQCJd+hgwWOGP1Av7qfflbSOY+OSrdlInL2/mSD5geHRC8bDCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791722140; c=relaxed/simple;
	bh=88IIAoChlEf0WQ3jxG0qVp+32AZndTvn9HQBAYzNovE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5gdS5lyqdhujKdPh7uWNmeMC/AxQFqARDqwMU9y5yspy1TULk5JfcvmKZc7KO1F0BwhQbsGxmq4N7jck40er2eMEencacyfC/ZbWRSRNzxehly8N4PtxL02gEHcH3SGb/bADoxdGsSLBGVfwgGGChOgKbEIpo8RS4m75emPtPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=OcEQ4B6P; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="OcEQ4B6P"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-890d52c7c7bso892433b3a.2
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 05:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791722132; cv=none;
        d=google.com; s=arc-20260327;
        b=QBie/dsQFDnZ7AqjcmkKQ/VWmTmKAGliPWiLI7e3P6tV37oM/9x3N0SgsliJsK6o0K
         kSeLTIxN/2M9tPWwTu9JlGkuCVRr9By7iYk19j3yjWi7FZS6GXrWsQI11VhlsgQ/cTku
         UV9S506GIMKmRyXtHdwkpj7LLHfnKqzlNo0Yd/cYJZaj4aQAoSX5/TXcCb+zkBzDbio0
         GzpXYg2Ftc6E9wnghNe8C65Ncct22cSRQ9YyUFw6Jt53K8Xjg4dgJETZE3CdnhtCp35I
         9KiN9NMDAyf4dJGdvZgZvP+kx/k3L3rTdYlNGMsdy1LjUS+Fh3rk4yJTzY4PMf/ySyHM
         VAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KdVoUcER69zvBRWUnB5/fbxarYF+WWZROLlRW70C99Y=;
        fh=oY+r7cJmBTQgvbRX2DXKoB56Qi1BJwWhjiTky7dfimM=;
        b=N8/C0NQGTXlqYTsDMyVK4nFS7kZgpbKfJvJVo/0zDPD9Sd/8JSqO4xB4IBJf8CwQTm
         151Mq87IW23PRksvDLPPt4NZUzv55UFZxYULayAbXq35TmIWTW+I/P+5K2xkUDOT4juI
         pasuXnrmJUn2XEF+2ECgHCbR/33Sr2GLGOzuSbkDkUsmz8hlbZN8XJp/d2zgEq8qlieH
         x4Yxj2TyhQKgI4TOblcV94jUf6x6Vu2DXp1scqX6p/YX4Ck36PJSXKuAFx8kR9x0iQcQ
         FAQE4fWm0dcNNhy1ORSEQwACildTQ0EP64m/62uGC14fR9LdgvzizvuKhkLWB43GtO4C
         wx2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791722132; x=1792326932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KdVoUcER69zvBRWUnB5/fbxarYF+WWZROLlRW70C99Y=;
        b=OcEQ4B6P8fZ5SrHAR4PPnfAn8I7F9VipNwEOseMcuTyfS28KtPS9ZfamIOsC5PKGjN
         wXLZUSrJjuu9/yQcPnkKPRj5X+huwpFZXRklMkszEbzlPBMkki4opHGMrtULmXpOuD6D
         aNwVt/Lkv+TT2tUmOY3dTFsWRgdN9C5AzttiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791722132; x=1792326932;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KdVoUcER69zvBRWUnB5/fbxarYF+WWZROLlRW70C99Y=;
        b=hEYVGGx3lTYTpGdrKrtnkssgpMyGPc58KHOK8ziGQzMEfnNHr1ha5wJWBZOOc47Ch/
         DOEp4HEiHDp8A9boekCcsDjVeAxIMciiHxPo9JdR5MsWpOkiUS54YztbFwvQbA8y0Q8X
         zFPLLef0aHtLO5zny5/wJWt5bAEXd1AEbTOOGSGNzjv7G+e90CbtLsdDnjPIbfyK8Gde
         HZIZZdAKSE/JVqLgWl9zu0SV92Pv/8Fx2oAVAlnxNYPKmnQK1IPykgVbAlYiLTzPAFcN
         yc7lnmlnsXC+QafQFcv/CA4CLior2O3cV8GAMIxLSRrYLL3/O6teVAvxRS2YzDh6C5zC
         YAyg==
X-Forwarded-Encrypted: i=1; AKwUvBxd1ti1aayVoMU+1aZTN9W6mrl6ziocaChqTfUR8TSg1+GajnWoqVopit7xpot+W4FXB87smeQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKarnm7aFLrVs2tJkJwKApp5LY/lhBXe/0cgpnqrNRzxfvoGmJy
	QvsgyVB/B1SIYrHPsSEe+prH8q98UY8JjI5eKC/P77VJeO8He87GuvkkuWBdLJc4fsCQ1jF3fX4
	JdwGBwP9rMir+GX/m/K6BYogRBKeH8JFIYOJu7C+b
X-Gm-Gg: AYBFou130elA8CPwbhnO1dEVEXNmMjbiGUmD5YqHJF11a9rCOkqgiOG9SwJnYlKTETS
	ug79u6SDXsEcmojD5KUJmNFzX49BvyV3mQsa7S0TkpwKDGXQoTtGWjpPJSanuq9ekTOJifhmDHv
	w5GGOg2PH9n2ZNcSTBTZ4JUKGda0vhfVa9eIm8obheoBUD9ONzD4N7k44sgegBcp77rhBCZV2Co
	q2w8pzlmuKvXiQp+xvfGL0nrK05ckrz4xmULqJbL8Ali54tCfSmB/p+/YfzNLAnEyHOvso5lw7M
	Gaz9eeTnpN/psVyxEV+KhsWqQ3eejviqk1vqnvKxAaE+B/0F3c9Jhze+gfEzmiSnhUDLcGossPC
	L0widIUpcKRTnPeUMfzaYszosR5yW77LAzw==
X-Received: by 2002:a05:6a00:181f:b0:892:597f:37d8 with SMTP id
 d2e1a72fcca58-897c7010883mr6378352b3a.15.1791722132398; Sun, 11 Oct 2026
 05:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010152227.401987-1-acassen@corp.free.fr>
In-Reply-To: <20261010152227.401987-1-acassen@corp.free.fr>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 11 Oct 2026 08:35:21 -0400
X-Gm-Features: AclHuK_kb5Ok9iFu-OBYa-uWj3fzN6-JFeqxqGiL0LJZf2Q7bJaoQgJXUTLjPnk
Message-ID: <CAM0EoMm_Sc36=GOhXrjA4Syz=Ak8mdAC+dDUAX-brQSzbcz8Bw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: act_api: take tcfa_lock for hardware
 stats updates
To: Alexandre Cassen <acassen@corp.free.fr>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 11:22=E2=80=AFAM Alexandre Cassen <acassen@corp.fre=
e.fr> wrote:
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

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> v2:
> - Fix the 32-bit consequence (Eric).
> - Disable BH instead of preemption in the per CPU path (Sashiko).
> - Say how the bug was found and validated (Jamal).
>
> v1: https://lore.kernel.org/netdev/20261009051703.3615846-1-acassen@corp.=
free.fr/
>
>  include/net/pkt_cls.h | 2 --
>  net/sched/act_api.c   | 6 ++++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index 5f5cb36439fe..9382405b2bab 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -316,10 +316,8 @@ tcf_exts_hw_stats_update(const struct tcf_exts *exts=
,
>                                 continue;
>                 }
>
> -               preempt_disable();
>                 tcf_action_stats_update(a, stats->bytes, stats->pkts, sta=
ts->drops,
>                                         stats->lastused, true);
> -               preempt_enable();
>
>                 a->used_hw_stats =3D stats->used_hw_stats;
>                 a->used_hw_stats_valid =3D stats->used_hw_stats_valid;
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 6e48b4bc2d75..4ff553f3abb6 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -307,13 +307,11 @@ int tcf_action_update_hw_stats(struct tc_action *ac=
tion)
>
>         err =3D tcf_action_offload_cmd(&fl_act, NULL, NULL, NULL);
>         if (!err) {
> -               preempt_disable();
>                 tcf_action_stats_update(action, fl_act.stats.bytes,
>                                         fl_act.stats.pkts,
>                                         fl_act.stats.drops,
>                                         fl_act.stats.lastused,
>                                         true);
> -               preempt_enable();
>                 action->used_hw_stats =3D fl_act.stats.used_hw_stats;
>                 action->used_hw_stats_valid =3D true;
>         } else {
> @@ -1597,6 +1595,7 @@ void tcf_action_update_stats(struct tc_action *a, u=
64 bytes, u64 packets,
>                              u64 drops, bool hw)
>  {
>         if (a->cpu_bstats) {
> +               local_bh_disable();
>                 _bstats_update(this_cpu_ptr(a->cpu_bstats), bytes, packet=
s);
>
>                 this_cpu_add(a->cpu_qstats->drops, drops);
> @@ -1604,13 +1603,16 @@ void tcf_action_update_stats(struct tc_action *a,=
 u64 bytes, u64 packets,
>                 if (hw)
>                         _bstats_update(this_cpu_ptr(a->cpu_bstats_hw),
>                                        bytes, packets);
> +               local_bh_enable();
>                 return;
>         }
>
> +       spin_lock_bh(&a->tcfa_lock);
>         _bstats_update(&a->tcfa_bstats, bytes, packets);
>         atomic_add(drops, &a->tcfa_drops);
>         if (hw)
>                 _bstats_update(&a->tcfa_bstats_hw, bytes, packets);
> +       spin_unlock_bh(&a->tcfa_lock);
>  }
>  EXPORT_SYMBOL(tcf_action_update_stats);
>
> --
> 2.43.0
>
