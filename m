Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D69283FC4
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 00:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678468; cv=pass; b=cUPbPsRMPIUoSj6w8YNrSJMiSlFOY6zzG0C9Eg5MNTdT2dbZABZMK3oGv1m38EmxpBMIHt0JPFZkH2cIbbXJwuW+jugKSpO8mV82HfxykhSJsxVclbunGt4WqW3wTi6KIRbshm2/s/UJF6xWBqwpqhZbX6VQv+fnB367nvfSSow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678468; c=relaxed/simple;
	bh=zPlV3ytA9mYq182TVv8ShHtMlUg4BGn040Ng/0SYAO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GSzWRUZME/rBUFimntqSpnSCPIApGTEMbzscUGjUq4MgjR6TKvItNOeG97ODilhqoWW2njScWk8LClJE+uQIDI4M30mH3bY4S6Map1/TOwJXyqFdKbYyVzgF9uGUplJOsFsNy85ZH/RVU3XXr3+QgUzawxJXOFZ/9MHmEWSlo9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eBsuswPm; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eBsuswPm"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c0c68aa31so86722491cf.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 17:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784678463; cv=none;
        d=google.com; s=arc-20260327;
        b=lZSVRNaDr9l6fnVBlCBy68UVqBjd5Uhh6Avf1IkFc4d468NyDQX5yXh1ohmVqReMlu
         Do0YJti3kq5q1fLxAIE86eZ/f6JKTVVQGD+cs9EFDdzeT3IualcHX50EWUnFnSr9/J2j
         0FrBHKRa9ZTtWCDkAOzg+F37cOxhAs7VlbjnchdTspzayvE8Eq2MFc1tkXlfbIewkmiD
         lJl589lWIwAqKCkW+m8tUlsHXINxcTcIPdrHqaOnvVzVkPiyxnmiGicnzxN8jZDKL1/2
         bK4/hh1/B58fwNwiAjVna6ZjRCAx8YZX1V6il+i2l8+8C9SJ9P4fJ47yE4o8JboznkUg
         MF3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AlnEHI8kT91AydctQLRHbmFtJAyusQQDosMCUEGHLXI=;
        fh=NvtM+JLqUOPk+sFjPMqF/U60POOS1NekYfifrK/rk9Y=;
        b=S0MElpjcpZPQISntay9GjUCVBnnuNxqDVGrmmG8iof30/OCO/U4hO45w067ifzg2Kc
         i7IO0jiOsgk0B2u4AMbNmn89PiEiuZO/ChxdJ6/1uhPcel+LdWWOgkJHfo8WMAoXiF5k
         G9k+IJvxlX0+5D8CMzCxD2qr8uLV8nEq80AM6SZKvpXTSSsurtIBsJuBEPOhwooqrXn5
         4atxhZ3Gf8WPDWS2zDpjuqF+EN68caA7GVt28uBCjI9x6Q85T4UJ0wkB9M5QDBEdOfS8
         j28qGxGBdfG5yT1lz6+82VH+vSiweQbxltZI5F8qYgW6gnLcGTaf+vBEt4WlndIwIdIV
         uXwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784678463; x=1785283263; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AlnEHI8kT91AydctQLRHbmFtJAyusQQDosMCUEGHLXI=;
        b=eBsuswPm+a2QFmNq59I/Fi/2NnNcQ2SR12pF84ijjQXuVIz5rZiE78NDaqXtYP1p3x
         TdnVcQRpPrvm79xQOPyg2jnqM5DV1vnT7usJtwx5qYhFN0McFP9+RaegbUbrchAk3UK1
         Qct2A1vQi59crFaFTfz1VvdPEyj1Ap9I5PVR7LVyFqrQIyK/1lvJY9ojGMlphOLBz9WW
         pGyEaGc3Gh5a+Qz4To9//MZerbL6STKsNxt3VVBG/Cz3/vG6dV3COWkQdh05PnfFvbgq
         5KrnD3aQ9vpm45z4tGITpAwJQqu+q4r4gRIBuPQe1J4mJE34Dxi1aDcr45DZ5tmAgkFP
         WvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784678463; x=1785283263;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AlnEHI8kT91AydctQLRHbmFtJAyusQQDosMCUEGHLXI=;
        b=DW7ERQwrcnXb5m9edayScmVmDQtsbga/Bj/fZnvqelzuKFQcILOd3R/wUEtPMlu7Xa
         f6DdTa5sn1hvn6RYOQDVtPhykmkOPEPZFCrU5IJtR9HpCdiNh4WQsLysQ6Tnh2ZvyRFL
         wQU3f/n9LQ1ZizHoBXLI+JwFvO7Q2UmVnWH6A9sDsXDHpjbAbzp5vMcARIow6Ego/rVY
         oZqx3v9qz4qmuL5k7iQ9w0YFBiPTWTS8wLvOPZPhwsb7kkElZq7kkDwooBZ+QjYODohl
         JnOKowQYa+Z6yoPlB2iPdKrFi1lokS26W2AqMjm405tjyOQirMwqMPcuBUmW7QmjOlA3
         BUtQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXTAPR4+LA05k6hbF8B/HIdN6xIQF8FbPC+ClYryxHOh30Mx/JBu0WXC4TYZE77NZFq+0W6wY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS3bnlD+2f5QIVelgwNnouD3AqpX7ChpsYW7d8Us7hlVivNFFS
	icjv/iTc/KOZB7Rq325FMhiga0v0AuK17DpGC738ieL4+r8edvNcIN7GmoY1gYzYWf7QfmZfptg
	P/ij5+haMLeRL5XHWIoc5lUYa1+Gdn5+TYF+4fgUa
X-Gm-Gg: AR+sD13kssbXR/PZFwFCQ73zvLOCGuEga+6m1gIlJcL5vG4DmlQvvLnjvbp05YPFP1s
	6eUrZAAphZniC/wViMWEomtWNxlc1VnWgIB8InO+hTE4PfjAQAWYpwgujQbfkn1UZJqYs8PVgwy
	wEJ26kTJX1MrZ+WvjddiW/dOygNV8vCatBhO4q1f9WqGSYU1H5KpSVuYHfFyaYFjnUMqSX7DeLR
	xXlKFxVlOEVlkQXeOItJ5wutl4rMn++0a+VWjoq2ujDLn8NZngh2V4QBQt00uVJsjmzv6spDKRM
	ixU2gCf9QjNsL/RZ/1LruAH/nUX3EmjkhKHC2cgn6ar87l3JEj+HZrSCbequ1+ODh/+jpCj7
X-Received: by 2002:a05:622a:1b9e:b0:51c:b900:513f with SMTP id
 d75a77b69052e-5213aa6d821mr199345281cf.10.1784678462197; Tue, 21 Jul 2026
 17:01:02 -0700 (PDT)
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
 <CANn89iLFBPHjjOZg5p7b=-vA++17oBLCJtGi8aJXnfJ3j67J1g@mail.gmail.com>
 <20260715114114.446841-1-qwe.aldo@gmail.com> <CAM0EoM=gikondXD5GAun3p8S_fjmUgBucD0dJriUQhJ5U48E=A@mail.gmail.com>
In-Reply-To: <CAM0EoM=gikondXD5GAun3p8S_fjmUgBucD0dJriUQhJ5U48E=A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Jul 2026 02:00:50 +0200
X-Gm-Features: AUfX_mxYti_u9g3TaEGTEw3d3yXuJoEdcw2O7vlKVcWTjrg4Z9P97FYbNcOSxd0
Message-ID: <CANn89iJoE1ES0P+dbsPczCwV4bkXTZGQ0YtvrHDiHgzkWtkoQg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: serialize qdisc_rtab_list against
 concurrent get/put
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 1:47=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Wed, Jul 15, 2026 at 7:41=E2=80=AFAM Aldo Ariel Panzardo <qwe.aldo@gma=
il.com> wrote:
> >
> > qdisc_get_rtab() and qdisc_put_rtab() mutate the process-global singly
> > linked list qdisc_rtab_list and a plain non-atomic 'int refcnt' with no
> > lock. This was only safe because every caller historically held the RTN=
L
> > mutex, which serialized all rate-table lookups, inserts and frees.
> >
> > That invariant no longer holds. cls_flower sets
> > TCF_PROTO_OPS_DOIT_UNLOCKED, so tc_new_tfilter() keeps rtnl_held =3D=3D=
 false
> > for it and sets TCA_ACT_FLAGS_NO_RTNL. That flag propagates through
> > tcf_exts_validate_ex() -> tcf_action_init() -> tcf_action_init_1() ->
> > tcf_police_init(), which calls qdisc_get_rtab()/qdisc_put_rtab() with t=
he
> > RTNL mutex NOT held. Two RTM_NEWTFILTER requests on different CPUs, eac=
h
> > adding a flower filter with a police action carrying the same rate, the=
n
> > race on qdisc_rtab_list and on the non-atomic refcnt, leading to a
> > use-after-free / double-free of the kmalloc-2k struct qdisc_rate_table.
> > qdisc_rtab_list is a single global (not per-netns), so the corrupted
> > object is shared system-wide.
> >
> >   BUG: KASAN: slab-use-after-free in qdisc_put_rtab+0x12f/0x160
> >    qdisc_put_rtab+0x12f/0x160
> >    tcf_police_init+0xda9/0x1590
> >    tcf_action_init_1+0x460/0x6b0
> >    tcf_action_init+0x439/0xa40
> >    tcf_exts_validate_ex+0x42d/0x550
> >    fl_change+0xddd/0x7da0
> >    tc_new_tfilter+0xaa7/0x2420
> >    rtnetlink_rcv_msg+0x95e/0xe90
> >   which belongs to the cache kmalloc-2k of size 2048
> >
> > Protect qdisc_rtab_list and the refcount with a dedicated spinlock. The
> > (sleeping, GFP_KERNEL) allocation in qdisc_get_rtab() is performed befo=
re
> > taking the lock; if a concurrent inserter added an identical table in t=
he
> > meantime the freshly allocated one is freed under the lock, so no
> > duplicate is leaked. qdisc_put_rtab() now decrements the refcount and
> > unlinks under the same lock.
> >
> > Fixes: 470502de5bdb ("net: sched: unlock rules update API")
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
>
> The fix looks reasonable to me. I also tested the poc
>  So:
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

Same here, thanks!

Reviewed-by: Eric Dumazet <edumazet@google.com>
