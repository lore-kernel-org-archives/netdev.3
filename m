Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094999;
	b=hfiLMvT0jriduSceaBaoRYKF7YoBpOMHsPXPR7KwdKBMkh7IbuXtN8DuPbUgmWQ4g2/0
	 dQc/2cGRGrs+A5ySNsYj0tRb4a2wNR5Zy9Zxs/qLyURywgXD46dCuIcQ2n5hFJsPI5WTk
	 FikPoUR3dh9t/koJdaiCUEHDKtsGiMKnGDSNEHC23UwKD8z1bEiPalV0poUj0EfFRqCkA
	 DyhAXrxPrHjKtPXwI8FktagwD8wSMOJolSrEF3UtIgnV0KO2cWTDwb/hSxnm4SBPbNGb3
	 tg1wzEZgJvpqKwOxX1g/yrZO328XJcAXgAA7ZE2xJ8fyBhs1Undk1tX6q7siei3j6rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094999;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l7hc7TWwK3jRjuIXe52LR92uVwu6NesbUFRYeKYWe/w=;
	b=T8pR/JJBeNSeSRjNMAuKwi78leOTNyQGlbEBMswOJHXQvlr1WBy7EysP+4UdCvpH3223
	 V2CTeFAkPl9JhCNBD/lmgeRSyremqfoDFVUIBbt7/wreiFWo8h3txKhonfQ2fTq69Gkby
	 S7e8xMqZtCsvhbp1GmR/I1RMHLgQJVDw7W+Pdc5PfFJeZx0MNHP/kuKyJrrHANa1DOa+t
	 j/yHJidxFBsIH/gnJ1jPytT7gNSM4+JSuvyPiDNW8v4gS4ntPRXgSFuE4fxaCrPjR1ClM
	 mbw8wFxKtD6HxrOG9WMfCjFaT8o3lgR3abAhMT7oNWu9NXKIX8ZPA/usQSzWIZAUWJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nj5pKLYw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6B606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nj5pKLYw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8267A1F031E2
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793094998;
	bh=l7hc7TWwK3jRjuIXe52LR92uVwu6NesbUFRYeKYWe/w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nj5pKLYwoFKhDqJJY/b2NrEED86qyE3EpkT30IPOha0L+e3iVZvIYoLVBhDEpWi/z
	 PD2vPwv/tvbZIGNnnKJlTVeUl1kDj2MYfdhi+bLsNCpGuD89sXCezHXSB0Sn1vmMWk
	 F5wakaJoAqkBy3Th87X7KvtaikJg8fPSYCiGTLLApvenR6SQZuRTHgaGU3R3y7458B
	 kNsr09wSajBOiMRstFL2nRaKmNyCo/EJfNZUrqSWoDCDqiIbic1r3dl9ssE5YgvK8Y
	 BD4cSf086YXPKVbTKDKpo8Kbty1t7RTqGuY9jwirenUVhr1oHSAZzxL1L+ONubPCTL
	 rWC+EmNwPUO5Q==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ab4c608a6dso30653331fa.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:56:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwvoEVVPRU47TOZB3xqOA+vsMgFbn+f6xs2jQ+gm+vy0UK7Nr0/l1YAhptgqHSBn7xsmQJ0w8Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWVa5gIYcyDsz6oy+t6AVdnqq4cruXs8u+4tudZYPC5dcYehn7
	JmVB6JanYLM6yLt/yWk9Jp7ZoaTxnNvph8vlHWwcLcGqYFJ5O55DBS+re1GrurQEY9M9f0Ewsm7
	rvCWAE5M+aa+ySSQmjrU6Hj9wNZGA0l4=
X-Received: by 2002:a2e:bd02:0:b0:3ab:690f:82a8 with SMTP id
 38308e7fff4ca-3ac6fd4319fmr23447541fa.23.1793094997317; Tue, 27 Oct 2026
 02:56:37 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027065247.2871134-1-kuniyu@google.com>
In-Reply-To: <20261027065247.2871134-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 10:56:24 +0100
X-Gmail-Original-Message-ID: <CAL4WiioO81d9x7QJ==qCZChAK-7Eq=QvoRQcPwXncKwHbPcQkw@mail.gmail.com>
X-Gm-Features: AclHuK-NyGWZiMxi-BvaDceFVRSt3yEs3j7qkA7RJTEhtK79OAGS58wq4haPUuE
Message-ID: <CAL4WiioO81d9x7QJ==qCZChAK-7Eq=QvoRQcPwXncKwHbPcQkw@mail.gmail.com>
Subject: Re: [PATCH v2 net] ipv6: Protect multiple routes insertion by table lock.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	syzbot+751b587577d0ebca10f2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 07:52, Kuniyuki Iwashima <kuniyu@google.com> a =
=C3=A9crit :
>
> syzbot reported the warning below. [0]
>
> While call_fib6_multipath_entry_notifiers() is called locklessly,
> fib6_siblings could be changed concurrently, leading to the
> warning (and later null-ptr-deref).
>
> Let's protect multiple routes insertion with tb6_lock.
>
> Along with that, __ip6_ins_rt() and ip6_route_del() are changed
> to fib6_add() and fib6_del().
>
> Note that fib6_del() finally calls rt6_multipath_rebalance(),
> which requires rcu_read_lock().
>
>
> Fixes: 169fd62799e8 ("ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUT=
E.")
> Reported-by: syzbot+751b587577d0ebca10f2@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6adbaed6.67317f00.38c4bc.001b.GAE@goo=
gle.com/T/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
