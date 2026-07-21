Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2946D2B8
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 23:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784677627; cv=pass; b=Aw810qsHB1JDgqRLlO85RA2lKcU0wsyW3numhKN8fGGYFzOdTCX3GoC9/ZEaWxxen1CH0Ol/la72uuXVWniF+pY1+qskpYUxhOxdIABfunsZkqkIae1eh/0RbElaGXANKtvCSlmq2dHKg10k+FzJd/sgsif+VxZnqr9D5sdzIvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784677627; c=relaxed/simple;
	bh=bu0MPy6ae83okpVhA/+Im0TnCmtjD3xuJHzsd+QtZxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fb6/mky+MU1HBkOdMelX8X+Xy32Vzi/bO99bKXw7zX+MBQHOV/3OzX+hnrFYD6Pby92lRGy+cQzFhQGUw8n3q6x4jddQl2WTIRqNpbTOgLcf32hJ2Mc0yFHj/D6y7e175X31gfzPJ33o3fcLcTPAcnmiPDGIRzvg8zzYnLCgW5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=n7ICL7Dn; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="n7ICL7Dn"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-848d21bbaffso12026557b3a.0
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 16:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784677625; cv=none;
        d=google.com; s=arc-20260327;
        b=iyubTo++/TktQofDug7ANCpih+8rvHED99swl5HumTe1KVPuBSoiD/Q72knQvZ0fWD
         zdL673jXD4rTTWKqn7FL4zNE6/RAYSWqaXMmF09ay7JKRxwBZeX7ErfTiE54nYShA7fp
         1beLN9EPGAozobbIhRzsHJzTWcA1drnF3CDkA1h9O38ovH1MdjQ7TJx1sfzJV/RNTbk3
         tpTTstzXn5U3LHS9RZls4lVFLBPB3T4QDtmTVwV5HC8RVYIObX2Yey9WaGgrLYhrCxHa
         +ft+22I5b+olw3PQF0iAqh3ABiesuPJ/BE0yeeb++G0geWj+ObIlR8afKoClwCsFNQrD
         xBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0kJTN81SsCjp6H9bccSx3Q2z0nhMlaOsI7veRHwVvio=;
        fh=GpfHnLhBoOAWgOVR/91axx/9kEsK2BiCC3uL7icgJ+M=;
        b=SFJnQgTRRMJOgtV4FdCLvJCIyzldqVAjRRVUZQvsMx6at+IPWhmPnqHNVGUckw1r6E
         46eIynbdDUdm52hBDXI4rpemVoM2xQhMvwQDL7hM3Jo/RA5QXTvSZeksnnC2MLvKpptZ
         9azzUtgC+3XZmU/TMHb8gU28HNUFBgUXsTwmrwp6AO451zSexVoMDkqmAFgcsY/TOyse
         jhKf9tWQvbv+zydNn5nXcTQc13hP+Az3069kYFOCEGMgcNklKDREeja+RhaNyAf0Mtnt
         gJH3zdiWBvKKb40BCScus7BIbuh/ztx33ks3pKoJ4t4OGEp2T7BA3Hcc7Pq9gvl90nHg
         L0+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1784677625; x=1785282425; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0kJTN81SsCjp6H9bccSx3Q2z0nhMlaOsI7veRHwVvio=;
        b=n7ICL7Dnrkg21yAdvl3ZgyFPmXaZoXtlGSwod/JgmdlylM+R4kY+5t3poQnVPZFxKv
         JHzsP16flWQjbruMJ2Mp141qjRfL4df0uR42nWMcHGRnfa+JVZiF+VNLBpVJvpkNlaPY
         PiaBxn7OBVd+t3OQvfgeQWnjzhw0VHHp2nZ4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784677625; x=1785282425;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0kJTN81SsCjp6H9bccSx3Q2z0nhMlaOsI7veRHwVvio=;
        b=CvuQ1xCLFhKTCHsaipX/jEKjIR9C6pcchzTKdUrZl8IonLx6ciZW/RrICmGygv/KLr
         2gkvwKXFTVz68pb7iL21oKJrpDMP+QDlIhdLSkBz9uhiRsAbDpUHguV9U4Sb+sEOD6PK
         cXphSu/MJho/GJN8sD3l2Wfi17NM4LNA8sfc8gJkyUnejrdj3PYKYBkIa0Esf87KRTcB
         rJvW1TkRuVZha6jmxVCZ3a3oF8BigoHeHoaWK0V6ohiVXbf/la0kCYSICrTpwDtJNAlj
         /TeXtPJXcA51YpWof0T1GBxEMBs8YAMc9GUyzG5+AyqVA1A1fXHUSP+Yg4zf0QTSwOdh
         X4eA==
X-Gm-Message-State: AOJu0YwcHWdI8s/XqfABACm1gZsvsH/AIZTAg5EQd4DlqnfYEgtZlurS
	Hnw35kn9nD3uT2FjYA96RBhZs0mnbrqk1xs2xaLMZ/+0lU1jGhF/SSc/HsR9TvNqXivqFZ//d0X
	ukJ8qhFe0/RjBWYSmfJyTp7hak7B4ZkmxJ2CDQWgL
X-Gm-Gg: AR+sD13y6juYLUBuE+/EkR7mFfoeQtQCoaNhFGGgKfM7yLSeMXG9Ose/Eowc3ouZohm
	2cJ0+XHqlL3X+YuJybT4+o3WeT5cdJvDnV+tgJExE4ksRUNGiszOCUkzwn/wACatYfTW/nAAU/M
	gJeu1s4PqubUoK2xQvfdQ6t8olFDdWjegM+ju905wyJHD/1foBkt8APn5IGzLgYJNCdxZssACuD
	eml+MtxYRwxKZKbkSoz+Z75LLa4z9oSxaD0oy5exoHgCTXgdNsO9bznG2o=
X-Received: by 2002:a05:6a00:22d0:b0:848:2a71:a48a with SMTP id
 d2e1a72fcca58-84c29239575mr19652003b3a.13.1784677625283; Tue, 21 Jul 2026
 16:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP48HfvFnArD5hDW8gCAWrp4Hz8Pbh7m3A8F6DiPtLYq45WOBg@mail.gmail.com>
 <CAM0EoMntb24oXpBW-pAYVX1WYTNnTU9eJLe-cvoiD-GGdW-Rkw@mail.gmail.com>
 <CANn89iK63bSCL3MPBQKiYEwYfioNYkvTBYVL8cavM2THQbPyhA@mail.gmail.com>
 <CANn89i+6K3TrAx0Jq_6Z+OtLBt6DhV6_dNjU5U6m6epucPzVVg@mail.gmail.com>
 <CANn89iLFBPHjjOZg5p7b=-vA++17oBLCJtGi8aJXnfJ3j67J1g@mail.gmail.com> <20260715114114.446841-1-qwe.aldo@gmail.com>
In-Reply-To: <20260715114114.446841-1-qwe.aldo@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 21 Jul 2026 19:46:54 -0400
X-Gm-Features: AUfX_mx27ou0j_PhEaeg9eT42xDEIFXySji_8EeIj69J5RkOrdvnj6FAbDKOPiY
Message-ID: <CAM0EoM=gikondXD5GAun3p8S_fjmUgBucD0dJriUQhJ5U48E=A@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: serialize qdisc_rtab_list against
 concurrent get/put
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 7:41=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gmail=
.com> wrote:
>
> qdisc_get_rtab() and qdisc_put_rtab() mutate the process-global singly
> linked list qdisc_rtab_list and a plain non-atomic 'int refcnt' with no
> lock. This was only safe because every caller historically held the RTNL
> mutex, which serialized all rate-table lookups, inserts and frees.
>
> That invariant no longer holds. cls_flower sets
> TCF_PROTO_OPS_DOIT_UNLOCKED, so tc_new_tfilter() keeps rtnl_held =3D=3D f=
alse
> for it and sets TCA_ACT_FLAGS_NO_RTNL. That flag propagates through
> tcf_exts_validate_ex() -> tcf_action_init() -> tcf_action_init_1() ->
> tcf_police_init(), which calls qdisc_get_rtab()/qdisc_put_rtab() with the
> RTNL mutex NOT held. Two RTM_NEWTFILTER requests on different CPUs, each
> adding a flower filter with a police action carrying the same rate, then
> race on qdisc_rtab_list and on the non-atomic refcnt, leading to a
> use-after-free / double-free of the kmalloc-2k struct qdisc_rate_table.
> qdisc_rtab_list is a single global (not per-netns), so the corrupted
> object is shared system-wide.
>
>   BUG: KASAN: slab-use-after-free in qdisc_put_rtab+0x12f/0x160
>    qdisc_put_rtab+0x12f/0x160
>    tcf_police_init+0xda9/0x1590
>    tcf_action_init_1+0x460/0x6b0
>    tcf_action_init+0x439/0xa40
>    tcf_exts_validate_ex+0x42d/0x550
>    fl_change+0xddd/0x7da0
>    tc_new_tfilter+0xaa7/0x2420
>    rtnetlink_rcv_msg+0x95e/0xe90
>   which belongs to the cache kmalloc-2k of size 2048
>
> Protect qdisc_rtab_list and the refcount with a dedicated spinlock. The
> (sleeping, GFP_KERNEL) allocation in qdisc_get_rtab() is performed before
> taking the lock; if a concurrent inserter added an identical table in the
> meantime the freshly allocated one is freed under the lock, so no
> duplicate is leaked. qdisc_put_rtab() now decrements the refcount and
> unlinks under the same lock.
>
> Fixes: 470502de5bdb ("net: sched: unlock rules update API")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

The fix looks reasonable to me. I also tested the poc
 So:
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal


> Cc: stable@vger.kernel.org
> ---
>
> v2:
>  - Rework qdisc_get_rtab() to allocate before taking the lock and free th=
e
>    surplus table under the lock instead of dropping the lock to allocate
>    and re-scanning (Eric Dumazet).
>  - Add Fixes: tag and Cc: stable.
>  - Build-tested (CONFIG_NET_SCHED=3Dy).
>
> v1 was sent privately to security@kernel.org on 2026-07-11; moving to the
> public list now that a fix is ready, as requested.
>  net/sched/sch_api.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 8a3236456db4..668bcd60d183 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -415,12 +415,13 @@ static __u8 __detect_linklayer(struct tc_ratespec *=
r, __u32 *rtab)
>  }
>
>  static struct qdisc_rate_table *qdisc_rtab_list;
> +static DEFINE_SPINLOCK(qdisc_rtab_lock);
>
>  struct qdisc_rate_table *qdisc_get_rtab(struct tc_ratespec *r,
>                                         struct nlattr *tab,
>                                         struct netlink_ext_ack *extack)
>  {
> -       struct qdisc_rate_table *rtab;
> +       struct qdisc_rate_table *rtab, *new_rtab;
>
>         if (tab =3D=3D NULL || r->rate =3D=3D 0 ||
>             r->cell_log =3D=3D 0 || r->cell_log >=3D 32 ||
> @@ -429,15 +430,20 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_r=
atespec *r,
>                 return NULL;
>         }
>
> +       new_rtab =3D kmalloc_obj(*new_rtab);
> +
> +       spin_lock(&qdisc_rtab_lock);
>         for (rtab =3D qdisc_rtab_list; rtab; rtab =3D rtab->next) {
>                 if (!memcmp(&rtab->rate, r, sizeof(struct tc_ratespec)) &=
&
>                     !memcmp(&rtab->data, nla_data(tab), TC_RTAB_SIZE)) {
>                         rtab->refcnt++;
> +                       spin_unlock(&qdisc_rtab_lock);
> +                       kfree(new_rtab);
>                         return rtab;
>                 }
>         }
>
> -       rtab =3D kmalloc_obj(*rtab);
> +       rtab =3D new_rtab;
>         if (rtab) {
>                 rtab->rate =3D *r;
>                 rtab->refcnt =3D 1;
> @@ -449,6 +455,7 @@ struct qdisc_rate_table *qdisc_get_rtab(struct tc_rat=
espec *r,
>         } else {
>                 NL_SET_ERR_MSG(extack, "Failed to allocate new qdisc rate=
 table");
>         }
> +       spin_unlock(&qdisc_rtab_lock);
>         return rtab;
>  }
>  EXPORT_SYMBOL(qdisc_get_rtab);
> @@ -457,18 +464,25 @@ void qdisc_put_rtab(struct qdisc_rate_table *tab)
>  {
>         struct qdisc_rate_table *rtab, **rtabp;
>
> -       if (!tab || --tab->refcnt)
> +       if (!tab)
>                 return;
>
> +       spin_lock(&qdisc_rtab_lock);
> +       if (--tab->refcnt) {
> +               spin_unlock(&qdisc_rtab_lock);
> +               return;
> +       }
> +
>         for (rtabp =3D &qdisc_rtab_list;
>              (rtab =3D *rtabp) !=3D NULL;
>              rtabp =3D &rtab->next) {
>                 if (rtab =3D=3D tab) {
>                         *rtabp =3D rtab->next;
> -                       kfree(rtab);
> -                       return;
> +                       break;
>                 }
>         }
> +       spin_unlock(&qdisc_rtab_lock);
> +       kfree(tab);
>  }
>  EXPORT_SYMBOL(qdisc_put_rtab);
>
> --
> 2.43.0
>
