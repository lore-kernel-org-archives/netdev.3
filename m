Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2138E3358BE
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775620236; cv=pass; b=r03FxWd3ODC4A/mp/lB1cdQnKAWjKC3cw3IqsjkhyZrYQUb3HF1sPGWSkk/ujtUSHOK0vAB1muLlAMTTLebwfzr5xM5u+oCfk9Jkp1Rz2qs6/XJh8/Fz15vW6jmpens+lvryOEg0u+gX3EIcptu4v6qlMXVNP+PKQ2+ET+V9MCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775620236; c=relaxed/simple;
	bh=/rK2u7V0Vfg4hsh+9lY+x4GS78g0o5lRsBmTFUWCLiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kngzWEiYXHKJsjKDETqZlXweVV+bncbvAsq9ilOTrfq/TdJwKmAc7zKjkcGr+w5jt00T+EFp2Qbu+5LA2vNrcStGJu9keb8+nmntSGD+Q0YLJvjKK3CtqPGyh39513Y0WU2aHg+sOkfNrfEb8EKTRRnyvJ/2ReAY3NkFioIPFkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBvOZaPD; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBvOZaPD"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ce7d6fd2c5so251928eec.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 20:50:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775620234; cv=none;
        d=google.com; s=arc-20240605;
        b=lp57OlvlSw74K0ycnQPtrAXjaodWhOxXux8BqS02adlVvMIv3SL6s62SHkizfFJjvu
         U8cqgo9mMi75yyW+6UVlWZ61OHPO39RcrlqO3viZWu+bJB/RFG1tr4vKWwNn7KJVlGuR
         V7PTvKFIQp9w3SU+IrAZocfEeYmZXITvkBRNJu2Tug2Ph+CDlS6h5L0L2WIzRvEkrZyl
         6/bIvtFJJ00Jnhm7ly5Wa/pWOySr7g11k5zzytdMk5Bwns+Q4Y7RFgHL/owx0II+nC9c
         e8F2rVzwqQSqYogUtV9eJQ0R2n7mIsBbf95CI0g3oWRE4rAVo6YeU3v/VJigq3Z81Uyg
         PLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZacPHITCgx016Lcxkrb9BCOC/amVwpYfGnRjliY0Q2U=;
        fh=mBgBHv7W0+fHzAe5TTi7YrKy78bpjUiy0aIV6vWdHWA=;
        b=RxFiKL49xIH+gi3udu3z6VYQaSR0dn+McAMGuN67UADETsdOE9XJtbThxSsvQKzHg4
         DO3Wr5lHvKMbYzblR72C16rTJEoPONggtnEDaN2J5DzegAv/o6dPxJuXukdx/SfPG7uw
         UkRY1EIOBd3QBkEaA93G+NqCQUjLHoRH+o0Katuz0arm2AUp2ATvi5m7AOSIaGDu+Y27
         J1V9zjNuYqQpG+Sg5MabAK0+SqpHhz+zFBcsJeL7RPYz8MypZ7XZp5SV9AvtBg8FzOIe
         N+ns349AUKrsC4BUwk44u24mv/QNFCqaknyiT4ZJxsILTHdXVi2Wk6pN3kDSF0bPZG9n
         Wwzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775620234; x=1776225034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZacPHITCgx016Lcxkrb9BCOC/amVwpYfGnRjliY0Q2U=;
        b=DBvOZaPDaUJJwQRToaiWY7W87RRSysuMCdBNTKF6OR8/W5yxB68aCsFGGKiWnp06Qn
         bFopHiSGiZ07YXWpPjK0+X1OS4sjmA3GdAk23XTK5PQ1dMG59iXaOAuZlzdeeYkH2EMP
         ozEDH7g3JfWspoNuF7Voz7WtwyQ1cTxDdYOrNDWGkk8GMTjIXIrj0mLeFYFmAMbzrrsd
         j8IIOFEMYTi2cPew0PujPzQG2VAa0PiYj+guqDPZRSLVtM0LsMkMQiSdHhZlHR7AQYjP
         wDiLJ7ZD8WG/MgQJ9VjYWuwNTYhpO0noHj9Nz9jPZ+gjvY7AXlRQ6AOayko1profYysx
         IA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775620234; x=1776225034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZacPHITCgx016Lcxkrb9BCOC/amVwpYfGnRjliY0Q2U=;
        b=q2ybuoagnML3myWJ9h91eZzMSCxEas7ZskvJlaC/7byf6cIMEAUSftZ8SQEduiQLwL
         S3U48FfETduFbsDYHxoLN9Ylg/ImHcFedmh/u56BkPm1XODlWeQgjrhrNyFwCJpapc9i
         Tm3kdTbpMDc5Finme9J2+UaUjnL33OHAKynL2XxFTV7eOhsz2hqeNStauLrqxhPb89sx
         CBuvvIBOjjzjA58mG6mET6eCOnxQpPp6RBtWjvUVwKozGs440WrYdxII1XxYUiKiMVoQ
         MLgm+xXXTgMrGb48U9DtucpesfZYoqyq16PQEH3kTB3tMrOSf0Q/6dB3lL+Hf/YvgZBL
         IBdg==
X-Forwarded-Encrypted: i=1; AJvYcCViIkKBGAjRISrl0k7FXblLQYOgRchlil1O7BSb8C5EKrcz44FCaX8caPGrAO19LTM8udxDqvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzATSJ4l8G1mrpxGBVX6CtB9gCf84DWY0TOIYMTj1UJL78RRC2r
	gU8UxqhXfr3wEm+yImWLdz0P7VDe01KxgGUbgjCz/uck7D5I787fCcO3V4DOTSuzlsMMCHI2/E3
	WBnz3LOPpF8QjEVon8EFH3gNoAXuDyrLnL+yU/0ta
X-Gm-Gg: AeBDietc6x3ZpJZ5116Cs1UDIVrffACTQop3XBqRTAOhdqjyjGszhgXYGmcW7oH+BRc
	PFExOooVbRNyTHspd5ek9oripyTDfxmKd6D2X45enWv5FetcPZiW6PWtAmZ4ah3kKpSZ+lEmvYl
	c53qoq1UI0X9rl8X74XQ2SgSd8UcIGbcUKVvqsKAo9k4B/to+eezgpttl3ol019jzAioDroFBGv
	g7a3CUK3NXPta5BO+CtJnIbGEVUrtldGyYfstqhEg+dSo2KMP44EABtTlA/9SsuoMw13W29Q8LX
	qGTPbg5k4KNvAYYZGSluLJItdHb701a37hMDz/EaflJsI9HX6ulXPSD4Fub3LMqgVVfoMEYK
X-Received: by 2002:a05:7300:d518:b0:2d2:f421:a6c with SMTP id
 5a478bee46e88-2d2f421144fmr535408eec.20.1775620233389; Tue, 07 Apr 2026
 20:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407184202.34cfe2d6@kernel.org> <20260408034906.2812551-1-kuniyu@google.com>
In-Reply-To: <20260408034906.2812551-1-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 7 Apr 2026 20:50:21 -0700
X-Gm-Features: AQROBzC73DQxk_2Er9TsY2M13eHYXyxpNfVoUG2pdcrs7q9hEGLeL_Ml2WsyTeo
Message-ID: <CAAVpQUB6b0U9g86bKcXWtLK-+CJ1BbxfryXeKvwxQE7LnRUXNw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 00/15] ip6mr: No RTNL for RTNL_FAMILY_IP6MR rtnetlink.
To: kuba@kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 8:49=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 7 Apr 2026 18:42:02 -0700
> > On Tue,  7 Apr 2026 21:19:33 +0000 Kuniyuki Iwashima wrote:
> > > This series is the IPv6 version of
> > >
> > >   https://lore.kernel.org/netdev/20260228221800.1082070-1-kuniyu@goog=
le.com/
> > >
> > > and removes RTNL from ip6mr rtnetlink handlers.
> >
> > CI says:
> >
> > [  857.648411][   T63] Oops: general protection fault, probably for non=
-canonical address 0xdffffc0000000006: 0000 [#1] SMP KASAN
> > [  857.648639][   T63] KASAN: null-ptr-deref in range [0x00000000000000=
30-0x0000000000000037]
> > [  857.648765][   T63] CPU: 2 UID: 0 PID: 63 Comm: kworker/2:2 Not tain=
ted 7.0.0-rc6-virtme #1 PREEMPT(full)
> > [  857.648903][   T63] Hardware name: Bochs Bochs, BIOS Bochs 01/01/201=
1
> > [  857.649006][   T63] Workqueue: mld mld_ifc_work
> > [  857.649090][   T63] RIP: 0010:mroute6_is_socket+0x4a/0x80
>
> Oops, CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dn does not check
> if net->ipv6.mrt6 is NULL and always returns 0.
... in ip6mr_fib_lookup().

>
> Unlike ipmr, ip6mr had implicit dependency on the pernet ops
> order to stop mld_ifc_work before ip6mr_rules_exit().
>
> Before converting ->exit_batch() to ->exit_rtnl(), it must
> prepare for that situation and properly use RCU helpers like below.
>
> I'll replace patch 2 with the RCU conversion patch in v2.
>
> ( I noticed I marked this v3 by reusing the previous command for
>   ipv4 series, sorry for confusion. )
>
> Thanks !
>
> ---8<---
> diff --git a/include/linux/mroute_base.h b/include/linux/mroute_base.h
> index 3341acca002f..ee68c05d0584 100644
> --- a/include/linux/mroute_base.h
> +++ b/include/linux/mroute_base.h
> @@ -259,6 +259,7 @@ struct mr_table {
>         bool                    mroute_do_pim;
>         bool                    mroute_do_wrvifwhole;
>         int                     mroute_reg_vif_num;
> +       struct rcu_head         rcu;
>  };
>
>  static inline bool mr_can_free_table(struct net *net)
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index b9c048b6f1ca..468a30c76930 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -319,7 +319,9 @@ static struct mr_table *ip6mr_get_table(struct net *n=
et, u32 id)
>  static int ip6mr_fib_lookup(struct net *net, struct flowi6 *flp6,
>                             struct mr_table **mrt)
>  {
> -       *mrt =3D net->ipv6.mrt6;
> +       *mrt =3D rcu_dereference(net->ipv6.mrt6);
> +       if (!*mrt)
> +               return -EAGAIN;
>         return 0;
>  }
>
> @@ -338,7 +340,7 @@ static void __net_exit ip6mr_rules_exit(struct net *n=
et)
>  {
>         ASSERT_RTNL();
>         ip6mr_free_table(net->ipv6.mrt6);
> -       net->ipv6.mrt6 =3D NULL;
> +       RCU_INIT_POINTER(net->ipv6.mrt6, NULL);
>  }
>
>  static int ip6mr_rules_dump(struct net *net, struct notifier_block *nb,
> @@ -412,7 +414,7 @@ static void ip6mr_free_table(struct mr_table *mrt)
>         mroute_clean_tables(mrt, MRT6_FLUSH_MIFS | MRT6_FLUSH_MIFS_STATIC=
 |
>                                  MRT6_FLUSH_MFC | MRT6_FLUSH_MFC_STATIC);
>         rhltable_destroy(&mrt->mfc_hash);
> -       kfree(mrt);
> +       kfree_rcu(mrt, rcu);
>  }
>
>  #ifdef CONFIG_PROC_FS
> ---8<---
