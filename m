Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CBA35C1AD
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 16:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368233; cv=pass; b=P+1z0kuECDgmBdlu5PqRkBIsw2ulnWGVIEjUsN1OAL52nKH/3N/rXr8k/WRaqfkgis24B6lL2TG6aiTLvhMUKGPRzMmlWNtX/5o1C34JbEnFbyknUdK1kFeHH4DqtMMWIspzNc/K3ISSgvpKcxvnJVPXUCYHemkL3fwlztp+hyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368233; c=relaxed/simple;
	bh=ZoPODiabd65INfCcb7TVHNdzHm6rKCEg42Yo9rpSC1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ss/JHVNwkizPU30z3RyrJyiLwGs82J4cLQlchGSRb43JTT3zDlix/u8pJAZhRwaiOXFoCwarHPGkRN5ORMo8Zb3MNsecS7+EvVyDvueU5SsgTpiT97CKq+NR4ysA1c6xvucZ8SmVzgEzowIR56Uu93GnM0AyEtLVB/W/Vbvwo2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CrRx4o4K; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CrRx4o4K"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so1460019a12.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 09:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788368231; cv=none;
        d=google.com; s=arc-20260327;
        b=g8DIKyxnUnvBOTPuwU7eK9xhsNvF5BucVg3aomRbQTseophpgbA3cCdqTtS519aUt+
         x88C05Or7Z88GPM1fuLKzvoJi+WKbMa5LNH3ieTypwPL4leXiBw1kTbt2QLK/f7dntmA
         2kvA4Ay6iK4QGczHlESKp1SZE4yQSl66C572D0FcKqp1LNaOllFrblsk23rf3StCnx00
         2DNayGOVhzNNUTiiNm7M9JZkCt19M3U4IT7CWR0Vfzg7JETPOlsbC6kZ2zvsKQ0QdG+T
         33uWNSUMzIM0fsEJFJ3ujBDWfAYZOcBVuDe70zk06poHp2IQ8j6o0ejdAEwIOoMdkN/8
         Lb/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lUHduyikGRFh8ufwvaytvgmAczW7+cMzkHVOrinLTgA=;
        fh=ihZpfOQsoLeUKmEJIkyOmhCJLmepB8th8AqxdXYRRTo=;
        b=mv3SWrmp1p691wQBcGAqAcwBNfM97ZJrfbO4MPTI43ecN9+HlYgs7zQn3hQcj/eehg
         u45S5htE1/ploJo1Oo47ScKEuGxqUyti+fI7PXy3Vm0YhvtbptWxXdXTN046dMrf2a4S
         m9/eTDsuo0blPddt/ol8VV0EW/Yka/+nY+V0xXyejEyKKhpb7gzbdQ3nClljR2bT9xU6
         swzyyB7gGLixUaMdYjUPrXwU+aaEd9fANgsX2x8VkZMYqCNSK5CiZp+EDrh8Kv60s81p
         /b1cZ8grDEHoUkj26tOh6bc8WwQV/ZeZDmucZe4y/qxsEjW8ZQ/6SY0/t8Uw38EBAYuu
         /hhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788368231; x=1788973031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lUHduyikGRFh8ufwvaytvgmAczW7+cMzkHVOrinLTgA=;
        b=CrRx4o4KKn2mry5xIAyuUik+1/Nzjbvh28+s4RtgwQEH2RwAJc3tmypLWyYR+IxWn6
         k3aHV+jnL56CEwFGKVde+36r1CgwkotbFE+I+CcDRHwI6LFxkZOppXosyU6TvxiB2ADy
         1JyVV3TgwpJgzXQGDZFqQFYUkEHWcvrvkfhPP7Poqz1Lman4KLRqAYEInT+y9n70HBU7
         kiOpwFg/mPst7Og9jPH3ZFlRM6W5cBLGHbYbfGvhQZGUcWeeFVlg2nvsaPVVBAVQXWTl
         6fMkh6Cy54g2dXqpXMnc1j/SVz5gYtNn7indM+Xgagwzs/X8119TScK7dguqr5KxZ0C5
         jSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788368231; x=1788973031;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUHduyikGRFh8ufwvaytvgmAczW7+cMzkHVOrinLTgA=;
        b=ctCKcW6lDy+a4QCZmP/ViG6iR2eFepYSYRkVLRyu+ocveOlmLaHkROhLvolA5knzvZ
         OD+ZRKJmiUlW/4hTLD0js07K4K8QnBYpXPQH4+bFMfPc75BDRg8ayyJ9EPOmdp4Ad3As
         4rUx1EsiesfrezGyY11pD6FAVhtf55j8cKYJzm+cKTSXuG/kjebhf68C2ir66M2cRayE
         Zc/qKpMjGjl4Bg2sCdtswdWHRHiGh0DQINYFrj78N+M9XG3GIigh9eL3HnnWc8YWXfTx
         4jOuqbQPdyrYqQbGloaAbHbj5rlVs83UCXRDO8U3FX0BekU801JQ6/FJTLLjmZwBHgIT
         HHTw==
X-Forwarded-Encrypted: i=1; AKwUvByKfxGXoegMBdR9e9NWRBISQPmdPBe/ncBOcqcyZwqCNoseAfsDiTeOOI9sQIQI46MaTK3FTgw=@vger.kernel.org
X-Gm-Message-State: AFuF++nxBbMay0H9mnFPssiWUz6JidrV4pVZmqCSdI+KbuU8YuqnJO8A
	/1PUOTbjO32hlrNaTkM4N+3MvkLaJtlQBA8HDDjRYfI/7MO3GPyvasCaxccRxg0tUz9zBALAphG
	s5MkVDWg1Ed76EVigU7KDPhzQIa2LASlE4hrn9jU3
X-Gm-Gg: AYBFou3O3/Y66udHqenETbfAezNz8b00R/hqvLq17TIlBu0ffn5ObbA0o5MkBAMpA39
	ET5lk3i8HIJqAyRZRR7B5euGrN29LHxhYMhYGqwm3aGvH6vxz8XGuJoNobvdiklzJmaSk0rk9Ug
	fGpVAipXTk1zgV120bYWRwQjBWp7PQW/hPQ83Tn5S0UyAdsBF8MUCh+kRB+hqcuC9isFh8wSF8p
	KUGORcdFz77X0RyoG2mU7E1KZfVXSKmqzwtWYvIEU7C/gf1T9cnOZBcV5/+FqDyvSwdHMLqsgsU
	XAlORumpLVKEy827FUkyIx7vVmJ1jSlcQCt2jV2T+onYWXg1QI7201UqwQd2RI6WB22RxcDKnTJ
	2eNqaW0MsPila66Tb5Ks+QAPLrt91bCdFGmT4EWluE9PETDMoC73syrp99p+6KMhJltmOEaSROE
	dsnBwyw9WjkVJr7CX0rmZPz5g=
X-Received: by 2002:a17:90b:2d0b:b0:398:9be8:ea66 with SMTP id
 98e67ed59e1d1-39aee1b7937mr9733808a91.19.1788368230515; Wed, 02 Sep 2026
 09:57:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901183327.3332855-1-kuniyu@google.com> <20260902143023.GA3966681@shredder>
In-Reply-To: <20260902143023.GA3966681@shredder>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 2 Sep 2026 09:56:59 -0700
X-Gm-Features: AcwNN1VRgCbAFrO6YCSvq5EQKkTKBkqGpIXmsDIetb-9-PbGU7pbhIzy_ub2MQk
Message-ID: <CAAVpQUDRUbxf=7FxHM9+vbqNkGP1KosS4CQyw4=wR47cSG2vaQ@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 00/15] neighbour: Namespacify arp_tbl and nd_tbl.
To: Ido Schimmel <idosch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 7:30=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wro=
te:
>
> On Tue, Sep 01, 2026 at 06:32:49PM +0000, Kuniyuki Iwashima wrote:
> > The neighbour subsystem is almost ready to drop RTNL.
> >
> > However, the control paths are serialised by the global
> > per-table lock.
> >
> > This series converts arp_tbl and nd_tbl to per-netns table.
> >
> > With the series, /proc/sys/net/ipv{4,6}/neigh/default/ can
> > be configured per netns, which was only configurable in
> > init_net.
>
> LGTM overall. Two notes:
>
> 1. The two periodic works (GC and the one for "managed" entries) are now
> per-netns, including their intervals. An unpriv user can set an interval
> of 0 and hog the CPU. Previously you needed CAP_NET_ADMIN in the init
> netns.
>
> neigh_managed_work() already has a floor for the re-queue delay since
> commit ed6cd6a17896 ("net, neigh: Set lower cap for neigh_managed_work
> rearming"). We need something similar for neigh_periodic_work().
> Something like:
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 27602bcbeb69..17817e30944b 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -1038,7 +1038,8 @@ static void neigh_periodic_work(struct work_struct =
*work)
>          * BASE_REACHABLE_TIME.
>          */
>         queue_delayed_work(system_power_efficient_wq, &tbl->gc_work,
> -                             NEIGH_VAR(&tbl->parms, BASE_REACHABLE_TIME)=
 >> 1);
> +                          max(NEIGH_VAR(&tbl->parms, BASE_REACHABLE_TIME=
) >> 1,
> +                              HZ));
>         spin_unlock_bh(&tbl->lock);
>  }
>
> 2. Related to the first point, we are now going to schedule periodic
> work per-netns for "managed" entries which are quite exotic. Better to
> schedule it only when we have such entries instead of unconditionally
> from neigh_table_init().
>
> I think both can be done in a follow-up given you are already at 15
> patches. The first is more critical, obviously.

Both make sense, I'll follow up on them after this series.

Thanks !
