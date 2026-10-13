Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFBE33F5A8
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 01:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791853653; cv=pass; b=d8/FIKIX46FxOn0BjL8zOpno9H82YxXKPUoQRL+MG1bTt2xWk2Y2RlFDM0hb87KNd+s0sYWXkXHTqiDJCoNPpByxuGcBGMnw2yW3YiPVa8WY8aKkJtarDISzRVu2P7STF3dDq7XnURc/Ra1uicepFUQibm6KSoJro9Ilx/xK100=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791853653; c=relaxed/simple;
	bh=dmqo/rRKwcI4JGSucbf6w7qYELLj1zZNxK6pc8Chn7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwC2jrcxhj+FrWCOf0EV4Fl240Hfk2kF2zMVw6T8/Wah8V8BOVZNMracX2yHOECthgC17Al04L4Ee2cNYoKaU+W7gfa2ZKSgRmE3+pBB8a7e2D5V/Lo2XXKrvXxVUKjEjA781lrLe9M9aDzZv2b5HYwjv2R8QcOHRD4J2Hbif6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vnv28ubx; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vnv28ubx"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3550c917fd3so3450056eec.0
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:07:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791853651; cv=none;
        d=google.com; s=arc-20260327;
        b=YrI4jHvmXvYLPpL5rGiDaF1cqBKqTN2X+pe5B+AC6AalS6X5BoyBZrSot/ANq+VSmm
         cjKZSpvWYToFUyTYLQ5E+89D5NM8aOJlODxqXyknD3Dh2dTOGxT1TqLxdllyFKgPxIzj
         snZ6C5b2cCrvaeaKydqwWDqIa5kTTz3SG3SZuUK1eDjj238f0DU9QFgmsSx2XaGzzyJ+
         Ejtsa4wKKCp9ByNzMpRERupeO631O/oL/R121EE3RoWrgxQT1mv/nhW4uO5I6P51sfEK
         WwpJbV9fV1ymzxmyjZKHF8VBvKjaov/CcUYQgUW7f5EYcWj7+q93iyJH1Fib+rkfgtKs
         pImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l/Dt1a3m1BsN0Ve4mSC4iIes1pIXA7Iv0yCJdw8/D+s=;
        fh=cEm9bu1rEhcNg5XVuZrQVj6pOCZEmqXnfdMkLS2HX2E=;
        b=hy6/uIJbIOmIfkeddfDZlW+l/hQG81ENE7V5mCLF/qvnRuUbAeBZpahElnoGVNtopJ
         XMvx+Nyc/zTv1p7XrVRyYRb8u13sT1FWWsTTeR+dVXPeNAHPwbE/kGMVh5EZYuxqgmqO
         Rz7/q1dige3nBukSuH77FDY+ZYn6ZuTUPhTa8DLfkLXGF92YsykSQSO289NomO7zV+wK
         Uh8w1/FfHIpOvYS+d0qmMypLqQ4y8NMfD0EzNf0fQRleVKA/X7nbxil1D2bEQuPPkr1Q
         XzGVW2YXSfnt+7HW/7nUzYf2byTO0P8Iz1mpxWcSjWmJLKXilNsAYWlCoPuOG4X8RaWw
         A6ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791853651; x=1792458451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l/Dt1a3m1BsN0Ve4mSC4iIes1pIXA7Iv0yCJdw8/D+s=;
        b=Vnv28ubxKhCI9pXWQ7dFgM3tixJrB4nVKkEuNuF0dTcwEhXoc80CWzOj7VLzoPrvqi
         kEtbzIaB7tonswKC5mwhK4xK71ph/07Xjfas2pX8WG6Tmudvupr5J0GgTFOWXGi3HIuB
         fvuE1G++HJ5JW2XVPEmpXqcTkoFwXgleveuoRqI6xFNUVFRxT2eFcL3DT04wpMlc8UCC
         JGWu0Ziqt1VWCuane3ZWDHA6OS8IZvSvbXycCkDE6Cwf8Uf+Bfwub2KCLrFm3Hpkr+H7
         7ZiLWaSBx2DMY0lOPjEqeMOVULh6HVz4zFkVM5mafH7sZUaOzbADieeLo2QpK8RwesLD
         fdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791853651; x=1792458451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/Dt1a3m1BsN0Ve4mSC4iIes1pIXA7Iv0yCJdw8/D+s=;
        b=NGYJjH2VJmrVIRpT5SkJqliwms6/zpNNg5omt8bSyirqLJUNR0YqRXpU/2nqGJJvzN
         J8+5Q6KJFjPGdyuvm9PsejmaIVKXE8ZOL3MdtE8ZhdoY8q1m21V/b4HlZssOGCDWZ1ni
         Wd/5WY7kSoG0VcpHzQAEEAVVGTapCge40Vn8s1mDEto9b7XSHx2UIODG9+c2Oou16SGR
         hqZb/yHSwm45taYSg6+5qgfrQDkb/tLbiVbIv/CYuJ3l+guAoqtvX5Fg3UD8BThzQ8+f
         9cbMdqaRKVBVywApHnjv/EskAXC4kGQm+pa1WGB5TPffEfFrU3w2qDDZ44Q1sCE51A9Y
         X+Zw==
X-Forwarded-Encrypted: i=1; AKwUvBytZp4cgekiECCA4kWaSMa74cOPl8FEkmE27NMGYihV03tOeke87OJ4WEmIutuDr87RJqEmV6Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYJFVQXn49JKbdiRTeylNELWjuaKm7x0dFvdBsqVs7fN0Fq8SEWw
	qRLIhrOsp/Ed1MnzruZxrevcgiFH2ECdket+AEkJordhWueHGHF2hy1o2eWHiLYo1YGOcoWh/rb
	6SqJ1PoQ5XlhM9Jgs/r1dV4znpRS7QqPZFFhcvGuw
X-Gm-Gg: AYBFou1QLpKlWZHZYgvMWEAodNxUsIPrSXIxfOPVSuYVEXu1GNLK8gy5hpAeH3ABYXj
	bO6cj98vBxrNV1fGX3qz0ZdAOPC79Nv/+SsR3ebjyS6fjEtRcuJryWfgAnqiXIv4//Eo9sVoAbY
	bjzwpHfhAg0F8lN5R8L5PdZQRtCIpVDeWxqelbA6k4IukDSELxVl/Np0JVatyQ9Nyl7LbGsXoeM
	7N0LMzeLKVqSRQPkTG9Qtnw3zMRady3SW1FyMAOrUB0SwJQXn2X25iFdSbYB0mQCYxtcRY4B4Dh
	6Q+CRQY3K1V1LfIk8jBWWOi6H94B+6WhXta2+w/W9Md7lEhyGGCHVKaf53SXieiNPMQIoUP+TFC
	aW/SyoMask25q/O+wcJevlNeupqHh6ShDya1tI2lZwxsF4oNuTcA4rYrUmZqN8GJcoXqB
X-Received: by 2002:a05:701a:c96f:b0:179:50d7:9ba4 with SMTP id
 a92af1059eb24-17950d79e34mr1584682c88.41.1791853649982; Mon, 12 Oct 2026
 18:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013010323.1058-1-kj2864@nyu.edu>
In-Reply-To: <20261013010323.1058-1-kj2864@nyu.edu>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 12 Oct 2026 18:07:18 -0700
X-Gm-Features: AclHuK9fb-xIidc3O6m-1UunJL34PxLpQ58IP8Bcl0fSdhalNCCQj8xNELr3Jyw
Message-ID: <CAAVpQUC33fc7di-7a5tgTdsuD4_ADEM8ZAXn4BcfxNDi-1df1A@mail.gmail.com>
Subject: Re: [PATCH net] net: ipv4: add zero check for snd_cwnd_clamp
To: Kaho Jiang <kj2864@nyu.edu>
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	co+71b6509cb791e531@bugs.sh, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 6:03=E2=80=AFPM Kaho Jiang <kj2864@nyu.edu> wrote:
>
> User can pass zero to snd_cwnd_clamp via RTAX_CWND type.

We should reject it then instead of ignoring it later.


> This could lead to division of zero error if not checked properly.
>
> Oops: divide error: 0000 [#1] SMP KASAN NOPTI
> Call Trace:
>  <IRQ>
>  tcp_reno_cong_avoid (net/ipv4/tcp_cong.c:510 (discriminator 1))
>  tcp_ack (net/ipv4/tcp_input.c:3517 net/ipv4/tcp_input.c:3873 net/ipv4/tc=
p_input.c:4440)
>  tcp_rcv_established (net/ipv4/tcp_input.c:6685)
>  tcp_v4_do_rcv (net/ipv4/tcp_ipv4.c:1854)
>  tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2248)
>  ip_protocol_deliver_rcu (net/ipv4/ip_input.c:207 (discriminator 1))
>  ip_local_deliver_finish (net/ipv4/ip_input.c:241 (discriminator 1))
>  ip_local_deliver (./include/linux/netfilter.h:325 ./include/linux/netfil=
ter.h:319 net/ipv4/ip_input.c:262)
>  ip_rcv (./include/net/dst.h:481 (discriminator 6) net/ipv4/ip_input.c:49=
2 (discriminator 6) ./include/linux/netfilter.h:325 (discriminator 6) ./inc=
lude/li)
>  __netif_receive_skb_one_core (net/core/dev.c:6297 (discriminator 4))
>  __netif_receive_skb (net/core/dev.c:6410)
>  process_backlog (net/core/dev.c:6761)
>  __napi_poll.constprop.0 (net/core/dev.c:7830)
>  net_rx_action (net/core/dev.c:7893 net/core/dev.c:8050)
>  handle_softirqs (kernel/softirq.c:645)
>  __irq_exit_rcu (kernel/softirq.c:679 kernel/softirq.c:519 kernel/softirq=
.c:758)
>  irq_exit_rcu (kernel/softirq.c:775)
>  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062 (discrimin=
ator 35) arch/x86/kernel/apic/apic.c:1062 (discriminator 35))
> RIP: 0010:tcp_cong_avoid_ai (net/ipv4/tcp_cong.c:482)
>
> Fix by checking if user pass in zero as parameter,
> if so use the default value of snd_cwnd_clamp.
>
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> Cc: stable@vger.kernel.org
> Reported-by: co+71b6509cb791e531@bugs.sh
> Assisted-by: LLM
> Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
> ---
>  net/ipv4/tcp_metrics.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
> index dc0c081fc1f3..ff41804ad086 100644
> --- a/net/ipv4/tcp_metrics.c
> +++ b/net/ipv4/tcp_metrics.c
> @@ -484,8 +484,11 @@ void tcp_init_metrics(struct sock *sk)
>                 goto reset;
>         }
>
> -       if (tcp_metric_locked(tm, TCP_METRIC_CWND))
> -               tp->snd_cwnd_clamp =3D tcp_metric_get(tm, TCP_METRIC_CWND=
);
> +       if (tcp_metric_locked(tm, TCP_METRIC_CWND)) {
> +               val =3D tcp_metric_get(tm, TCP_METRIC_CWND);
> +               if (val)
> +                       tp->snd_cwnd_clamp =3D val;
> +       }
>
>         val =3D READ_ONCE(net->ipv4.sysctl_tcp_no_ssthresh_metrics_save) =
?
>               0 : tcp_metric_get(tm, TCP_METRIC_SSTHRESH);
> --
> 2.43.0
>
