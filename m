Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793476603;
	b=ZspKC9OAni2GG39NZXjGMWHpW1EQgc+F3l/xzzCot620H3BK+6GdXS2h50M+MLaw5MT3
	 NoyNZ0VRKSikLRrKQK9+6yWprP902t94pd9Z1lcy/nZvemhnoNlk6BNm+2vqqCG5Vw2K0
	 9mVE2NUteyjpXBem5c1ib/ZPMMYrl5SZDyRLgHb/5VZXKMqlMEBGjC+I1xYEiKEY82FeJ
	 DAX52RwiZYgdQOBTvDXf1/JHcsISWSk8T8H9SZ4IudzRl/R4GWtW4qUcbiI66hMWUiZdp
	 7Srm6Rr0frQyq+iRLjAtaBhn44NujYRc5/Rl1A/Bi6VNYK2vQxln+Q5CFJo6lHjmjFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793476603;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=aryptuAOBAtBz9hlnvqOhV6KqS5vh4lfw25sRossDrw=;
	b=Emd2m+zybmBMvAy8CWkLS9nAsQMGMgGKzMnRYJjG/8Newq+3kO33Wuy/qdW4sl/q1VnR
	 dDXPDEhwmZKoYoGPpSA3Kp/FXjQH6liM/Rq/1NMJTNMefr26b3kAFZjArwoQZS+39ry5y
	 Ytnw3Uehen6LtJqLGhFPce5TM0QWEq/0T9dt/XIel/dxxv403IAzsnUHfFRarutUeRRVD
	 199EvE2BnDs3EFuouxHtyDiB0XSQwelgA79JaPprxsgjWvATWTHcxBzK8I73KOl5fPR9k
	 bdcNR6gils3/3lyTdOHMC2z8K+ZJGaib46Vd9UStVjj0PVnIBwwYLr4xOg1+n7iNvAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=EQWy5YnJ;
	arc=fail smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4658A606A31C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 19:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4658A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=EQWy5YnJ
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so1197348b3a.3
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 12:56:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793476603; cv=none;
        d=google.com; s=arc-20260327;
        b=HWS+I0Cm15K+k/3rKSgdPePFMegLx5bgh/RaMgo1ES0fWL78iKuCH2yCZ1sLK6TKcg
         QRnZYEEc3kwhy8xK/P7TgmtlEUGhHH8GThyxALzB0cmVNj8w1ksDosSu660zwmxZ1RUZ
         6Kk4gtVutCFHqHvbp/jyMkd+PcD2GOcYKsPk5tJp/JHobfQKyBkoW139EKkb7EiVkNfP
         jN4UeuuRlUWaW5QcauDKWI8djLXtbrcAwb8C0HPV3dLp9p2ORMLvTRKbYVI2O/VZzM3N
         SrSIRCFpXFKVRmPQGV4QP1QoGj49r08+vybg9rvUYjShM5Rvhl3DB2Ob9lSNK32VYVix
         sTCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aryptuAOBAtBz9hlnvqOhV6KqS5vh4lfw25sRossDrw=;
        fh=B5iBFtXI11SCovLbAfqDo5uelFKmfXu4lylYV6otXSk=;
        b=VZ+Wn63vZr8cuCwUbqKc0uVvxF/XG1sJk+euCmqetxj0gQkWWJw81wkVqgVL/sMoms
         nUq5iWU+0xJiGB29AWt3rAbtW3CeSI4fa+H2fTAOON0Zu5YlmHiFhBtaNuOk3BSxUSbK
         iRr5xZe538xHOL9vlgLpAu44jfFYkqqDPnDzSyU+WoHD8Kbpt7TgzSjR3gAloPLW2xUG
         zpT+3PJ/IVnV6s9J3aj1lSScllh/Uy9HYvNZmGwfeN8r+JpHbMuI0HDpkWDzpGxqANLn
         jWt1UNAx+c2A6NaanH1BokLT/OJhHp7kS7s8ij3yW7pFpHs72ESeF0/2hBOThNkWa6Qd
         HOww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793476603; x=1794081403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aryptuAOBAtBz9hlnvqOhV6KqS5vh4lfw25sRossDrw=;
        b=EQWy5YnJ+StRsCRsI3UjqxM6NhG3RkxbsEiIF6b8lmVFWqJXaFe6EEgM1DxxMYqrhY
         meISUh1+N863oX0Wmij8QpfEC/9bR3Nkxdso0Ckso2XgF24pONCldB3yk4PH9i45tBe9
         lvUPBLjXhNSX2MP+GH8ZuCTIxCkhPe8vYbgDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793476603; x=1794081403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aryptuAOBAtBz9hlnvqOhV6KqS5vh4lfw25sRossDrw=;
        b=QXY4e3DiRXMXQtzaAXbCFEz7WqSTXRWcTyIwSZAuHKwNbrriAnkodmMlcFwQ6yc51O
         yGCcREzAlQ8u5cjHaAC3EbmL4j6iWczle/AE3h8S0U8WokNkUHc4UkjOBVz7JCQeKejy
         1B24uFkMNKOuXr5vdanKF4IZDQLSYbSRV0imoSzihiG6bRTv15QleZc/9HZldmhIB3JK
         +pam52ceGvU/t6qo7Nopx751Csxgk90m9jyFDLhRyzt+8Mw1uhQoRgPEs+VIk6x3LnL/
         d39IdzdVhP7+E+9XegvPQKJYdPhpaFyBFyRRmIzTXGLf+TQ9UZmPDJ/XQ9eXr2mqOyn+
         KftQ==
X-Gm-Message-State: AFq9FYIe/SBHuhl57CN22DieiVHAGfkrZ3+5041oscYQP5V94zMFe2AQ
	Kbn1/jBdGpzhQE5Sw7zkZfIVKazgdVQKzqGw/scjpkJyVjEwIE4r6ezEBB8DqJos3eKFO6stKwI
	FJaGwpsIcksv/4u35MxnfXCWySkNgAFd5dzW7Mg7swEE3ftaTBe0=
X-Gm-Gg: AYBFou3t20TDkVVTICTfOCmq0GgcXfrPmlCiJK9RqCH8Io9mOTsiKE5wPA5rx9nf3JP
	zfD3G+WNqRworu/WbWAKVKs+Fo3ZfC3Z4K7GGKmcJGWnBv2FInVzFi+4Req4qVSTKm++XtaNbtj
	/sLKIa2vAkpemrbheCC9tzAkV0nFD9ikjRAzX26GkYrXLv6JwQOdYoCaIXgryQxv8stCE8ruKz0
	0sTz+Md3DEcex3n1t1Vlowgn6/Q5kqFBh25oUu2rLpj9cktJ4oSfcA5dDLZpalJ+y7uzq2fptiW
	Z5FG8xn3IU5WHLRo/br80bi6dTFtnvE8m2ex09fwEVRmp98mCdQKqn6G+sZITikWryFLsr21rgc
	nwA9bz37KLjeQeg4kPvK4oZ3lH1ep9Z+GRuqvaCYg/qf/roGbVuU17KixBEq7K6orNfLFe1H+Sq
	hRBDdjeJPqhJTv2iE=
X-Received: by 2002:a05:6a00:181b:b0:89d:eb23:4e83 with SMTP id
 d2e1a72fcca58-8a9beb67de4mr4983680b3a.30.1793476602669; Sat, 31 Oct 2026
 12:56:42 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v1.r1.20261030042947@mojatatu.com> <SER-NSBD.v1.r1.20261030042947-3@mojatatu.com>
In-Reply-To: <SER-NSBD.v1.r1.20261030042947-3@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Oct 2026 15:56:31 -0400
X-Gm-Features: AclHuK_5FcR14Te-KF0vKW6H2qH3L3t-X26CkMjnn0VEbpmmZR6cMUtExiAwJbk
Message-ID: <CAM0EoMnHR61Z2cW2+x-4Jeaz_mjdCfh8ieYJVZJu3ak5YDkRjQ@mail.gmail.com>
Subject: Re: [PATCH net 3/3 repost1] net/sched: sch_teql: reject qdiscs from
 another network namespace
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, shaos <shawnq1@163.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Victor Nogueira <victor@mojatatu.com>, 
	Tom Goff <thomas.goff@boeing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 3:36=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Reported by shaos <shawnq1@163.com> with a reproducer, which was
> reproduced and verified in our test environment.
>
> The issue:
> The teql master devices are created once in the initial network
> namespace and their Qdisc_ops are global. teql_qdisc_init() takes the
> teql_master embedded in the registered sch->ops and uses it without
> checking whether the new qdisc's device lives in the same network
> namespace as the master. A qdisc created in another netns can therefore
> attach to the init-net master and change its MTU and flags.
>
> The Fix:
> Reject a teql qdisc whose device is not in the master's network
> namespace with -EOPNOTSUPP and an extack message; same-netns teql still
> works.
>
> Initialize the private skb queue before any validation so every
> constructor failure path, including qdisc_create_dflt(), which resets the
> qdisc before destroying it, sees an initialized empty queue.
>
> Conditions to recreate the bug:
> CONFIG_NET_SCH_TEQL=3Dy, CONFIG_DUMMY=3Dy, CONFIG_USER_NS=3Dy, CONFIG_NET=
_NS=3Dy.
> As an unprivileged UID, unshare a user and network namespace, create a
> dummy device, set its MTU to 60000, and add a root teql0 qdisc:
>
>   unshare -Urn
>   ip link add dummy0 type dummy
>   ip link set dummy0 mtu 60000
>   tc qdisc add dev dummy0 root teql0
>
> The init-net teql0 device changes from MTU 1500 to 60000. A pfifo control
> on the same device leaves the MTU unchanged, and a direct MTU change on
> init-net teql0 is denied. The namespace needs CAP_NET_ADMIN; no init-net
> privilege is required. With the fix the attach fails with
> "Operation not supported" and the init-net MTU stays 1500.
>
> Fixes: 7316ae88c43d ("net_sched: make traffic control network namespace a=
ware")
> Reported-by: shaos <shawnq1@163.com>
> Link: https://lore.kernel.org/netdev/20261022144830.67948-1-shawnq1@163.c=
om/
> Cc: stable@vger.kernel.org
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Argh, sorry - this patch 3 is not properly rebased. I will send a
repost 2. Ive fixed it so it doesnt happen again.

pw-bot:cr

cheers,
jamal

> ---
>  net/sched/sch_teql.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index 409ce50cc0db..55f9944ca47d 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -188,12 +188,19 @@ static int teql_qdisc_init(struct Qdisc *sch, struc=
t nlattr *opt,
>         struct teql_sched_data *q =3D qdisc_priv(sch);
>         struct Qdisc *first;
>
> +       skb_queue_head_init(&q->q);
> +
>         if (dev->hard_header_len > m->dev->hard_header_len)
>                 return -EINVAL;
>
>         if (m->dev =3D=3D dev)
>                 return -ELOOP;
>
> +       if (dev_net(dev) !=3D dev_net(m->dev)) {
> +               NL_SET_ERR_MSG_MOD(extack, "teql master is in a different=
 network namespace");
> +               return -EOPNOTSUPP;
> +       }
> +
>         if (sch->parent !=3D TC_H_ROOT) {
>                 NL_SET_ERR_MSG_MOD(extack, "teql can only be used as root=
");
>                 return -EOPNOTSUPP;
> @@ -201,8 +208,6 @@ static int teql_qdisc_init(struct Qdisc *sch, struct =
nlattr *opt,
>
>         q->m =3D m;
>
> -       skb_queue_head_init(&q->q);
> -
>         spin_lock_bh(&m->slaves_lock);
>         first =3D rcu_dereference_protected(m->slaves, lockdep_is_held(&m=
->slaves_lock));
>         if (first) {
> --
> 2.34.1
>
