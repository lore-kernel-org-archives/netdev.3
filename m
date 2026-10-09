Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF87367F25
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791537837; cv=pass; b=oQE6OWGK/35wP/KJPdAjD4jy8Grf91FjX2Uf29AO6s3/FfLl5jpYpgTxMjICWj/+IKmG9wAMEtwEhmvFyag6L8hRgTFKbhbitekh6X//QUpY/mkTGGlTZSqSgrtE04KFkcRCCfCUE6iILbJD8LnSXGJyhRDVLj9/vy2ZXCqgbLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791537837; c=relaxed/simple;
	bh=TzFkSQ/kgUwmZzyD56X0aCUuJJGsRgH0XuOHO1C+5yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OESgHpL0ZrcRpOOvLybp0JSGiDMUQJVkFFYkDnQkFqG153SGHfV07T0PfCrWv3buzyMBs5OGxwlg4IG/6ulWbbvjexWXMgHsMFASvC/wEqivtRKtxIiR6tfQ7FPvIE1J2IPyUO05PS4KsBcJO840fScooiBXPFboryxPlDzMgyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=WGhU/JMs; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="WGhU/JMs"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-873a4edb243so4513343b3a.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 02:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791537835; cv=none;
        d=google.com; s=arc-20260327;
        b=fQliujziGaqXlGcuRQgGatPCptUVNn8E9xusEjGh5ND5Y6dS8WFf+jwg82XcEEwwJX
         XXPYuqHEVujT/+jY3Vgp4+zuLqZRG2cp25YvyBt+csLL0R/qs6kbZwDMRBojH21R0jjh
         1pUw+fXDzO5ldrzwCpFWaB7l9JLQcwd8xW2v8P0OUXmroEWOyjzRnn/BO7goJRld7sIz
         URcr9k6r/+xjbxBwbapdL88g2FkdtcSa0kUsvvsbt7f3mMCydeZlHS74OgrR+og5Ddc4
         qwRx0QfNhcQxqWBdpZdSR2G7Sv4wgMvrd5hHXGYAxOGIAc3wVLk1N7VPKEhqI44mksk+
         T/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yHSRiRzJzQVt7SKLI9ycJ6RsLP0z8yh1HZvirE9N1T8=;
        fh=B/yY33zljz0XGkAzXrVcgDhrGhThntojw7L9l9i4ECE=;
        b=jeoY/OQrZEbgKoy2On5zOAWdjqXf4abkMJel4m76ypWM9WtfEsJBKN9+kbA37KTjWo
         2CLEvDINLoqIAY1+dEXFfQsbc5zq0gyFlm5riwYcFvm5J6yBvH79I7JwE1eQoVNE3QKD
         gUuuNT2AbOfIwfYz88tuejdGUOGUfJg2yUCa1qadsKG+kfIUVOkC5V3Injj87OpA7jZV
         rCDTOwNb5eEMOlnkCm42wzZXDEPTmB6LDzmEVne58pF+Ve8s8hSW8DNINPQmmvYDNP+G
         /5Ms+TIi523dHNuf0a5IKT0j5MnrZYDaKVXPd9W12EhuWtqODlwUU7V82i6zCbiH1N3n
         R68Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791537835; x=1792142635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHSRiRzJzQVt7SKLI9ycJ6RsLP0z8yh1HZvirE9N1T8=;
        b=WGhU/JMsudLaY4d3HC8G+cgQq7tdsc0qamZZGngnqOUvBfHYTnhdM6QbxN5TBmmiOL
         Begxv1XgKS2jbYg35MRfS6Bh1v3fgAJSxb9kI/feV+eXvBxlTMEGJJBhM25MfHANeJ1l
         6Y+/3noeSrT2Lahxa/inRoYj+pndijJjsss90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791537835; x=1792142635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHSRiRzJzQVt7SKLI9ycJ6RsLP0z8yh1HZvirE9N1T8=;
        b=JxvBiQgTUBtKhBDed8Ui/TLJ/o8LA2m60Gtr1+qo1aB0fZ+9T/91OIp/1cNAIrkCGv
         yikUowYrqSBbUuU9qKXvVwYUBNmppDVIRbjdez60ODFK7OaC1343M7GzHs77TLRSVhk1
         v6xX6tLMMu8W1Qh/vEEqmMiZB/GGT+dnbbzBP1VqAMdcRJnMWSKpOW9V4sG00h04Ip23
         cU+M3Bi2WyK2L0KO76WObyzo16byzcA8+8GAMinH9LgN/D7cDUC9xxMcXqbjxksktoBf
         lsC20nNhMnzdRI65PYGkEqeO8D16ckv8PLGmbJOarfGVlgY/mtOmRDuGiVcP/Mv9Lk0J
         BRyg==
X-Forwarded-Encrypted: i=1; AKwUvByaZPJVGAWLbggK3dZV3IEImxn7NK9M60yKXIZwPkPnE6uAcGQYb2s7AhTgYgppaLHCXjNDpR4=@vger.kernel.org
X-Gm-Message-State: AFuF++n9iAnAprqBQy3ongTylkdez90a0fAyTGHV2rdl2dfoXLLWYAlv
	YV5nL/YOWl+R1mb9PA0NQdDerNA/qZsGqXvCmTMgGrDHIJrGYSTtDtA/IBKHxOufNVbANyQWzbB
	eSbUJtYNTaaie3XLtPlmCQCDzRvxFIS0ecfqLozZc
X-Gm-Gg: AYBFou1tno1uBDX6pS94PFumZnFlOpe9UJKLp1yPH888y5XjQkp+mINE6980XdSe9yE
	tJ7Zt2diQxdXOoBaOGaauRu8/9/AupMzeCb0/Ikf9TSzMR7O2BouzeloaeyDgueJQIYs0FNCOv5
	kLypdhncFXLtJ55QN4sDLyrttAPQ/OJtyFKO8upDVCHcgeVNDY7AwABooF6pQf1b20RZjrnjSdd
	Lq4dS6h1tcc7PG9MCqTu5mdH9DSyr+Y6V1odg9FgO6sT8NyPJQKY6RJYhzsbMAPG9VWZWPi30jm
	E69i4PjSjaGUyv45KeJUHZ0i6bXgha6KOJprPrqVQPYRmTJoKFOYuoVY8KE5qABr/edRTRJzf4X
	sFJzuweY25d/20AwVBvAK6Mw6Y3RoJhTRgQ==
X-Received: by 2002:a05:6a21:38e:b0:3dd:a197:edfb with SMTP id
 adf61e73a8af0-3e16bf8d2fcmr1092667637.74.1791537835583; Fri, 09 Oct 2026
 02:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009051703.3615846-1-acassen@corp.free.fr>
In-Reply-To: <20261009051703.3615846-1-acassen@corp.free.fr>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 9 Oct 2026 05:23:44 -0400
X-Gm-Features: AclHuK_O7gmHUpeTUDp9YmOwmYfBg5HgPcy_BbuoeH3KkmfpJk8V_axtVvK_MaU
Message-ID: <CAM0EoM=NH6_Nc7WeUpaqO8hJQef0XWtxDoCfcF00z-bPUE6CRg@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_api: take tcfa_lock for hardware stats updates
To: Alexandre Cassen <acassen@corp.free.fr>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vlad Buslov <vladbu@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

On Fri, Oct 9, 2026 at 1:17=E2=80=AFAM Alexandre Cassen <acassen@corp.free.=
fr> wrote:
>
> Actions without per CPU stats update their counters under tcfa_lock in
> the software path but tcf_action_update_stats() adds hardware stats to
> the same counters without it. An offloaded action that also runs in
> software can then lose counter updates. On 32-bit the race can also
> leave the u64_stats seqcount odd and make its readers spin forever.
>
> Callers disable preemption around this update for the per CPU stats.
> PREEMPT_RT forbids taking a spinlock_t with preemption disabled. Pin
> the CPU in the per CPU path instead.
>
> Tested for regressions on ConnectX-7 with firmware 28.48.1000.
>

See the comments from Eric and the bot.
You must now an explanation for how you found the bug. In your case i
would probably cite it as an observed production issue (even if you
are experimenting before production)
You have to wait at least 24 hours before sending V2. When you do you
can add my reviewed by for the series as well.

cheers,
jamal

> Fixes: 5e174d5e73df ("net: sched: modify stats helper functions to suppor=
t regular stats")
> Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
> ---
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
> index 6e48b4bc2d75..f634c23d6a65 100644
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
> +               preempt_disable();
>                 _bstats_update(this_cpu_ptr(a->cpu_bstats), bytes, packet=
s);
>
>                 this_cpu_add(a->cpu_qstats->drops, drops);
> @@ -1604,13 +1603,16 @@ void tcf_action_update_stats(struct tc_action *a,=
 u64 bytes, u64 packets,
>                 if (hw)
>                         _bstats_update(this_cpu_ptr(a->cpu_bstats_hw),
>                                        bytes, packets);
> +               preempt_enable();
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
