Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A13C37A820
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695882; cv=none; b=bDjDoSbdjsZEXfKleqNFs7zjlQWJOET9xRIv8YrjmAMCxwGo/Nu3rEPQzI2701nLf1+TT4131+yQVpyQhyVEWsOYeXcdlCBExrKJNVNEMVbqZB0oJeICP4vx/Zde2BKraeUdd4qq6epp0FhnRHL+iorzsdaDbSDZJO8BWDD4F0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695882; c=relaxed/simple;
	bh=V9lg38Vf7jZapxl1nX3JHinivXWDameN/IxWV3yotv8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bYSvIZp6aLI0dDAyfioznzkcpIIEk5QP//Utd7ChIBtDTYOPV61cm1HlSBJ2GHYkh5+NpVJ2wnQroOXq3I8ugDY7NudQd4hDT1IjuSIpLg5+9lFU11yVuQKEMTSoc5EdXNygSAVze/qMD/TB6Lpvcw4rSgRTJlx0tPiN/7/AoNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=i+oa0SA1; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="i+oa0SA1"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2dbdcb4f59so455378166b.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1790695878; x=1791300678; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KUokiXULiB5QsBWdM9hQZjEq8BVs/Diba1IyZLK0fCQ=;
        b=i+oa0SA1I0ql0x913EiKlVthwnGVMwsg9W40HEl7RNvJoE6krGwXeVBRjO0apYZ3BK
         Iks52N9H6DbTTyLWmfGvNy2C435s3p0Q+FuBH/mQgHK3bwTJARWTyNPCMD68v541deBD
         MoEjUXaw97/m0DQj7bMH8Ci7OdnzUCriUlcRfIYKk2Yxv1F6ctF+BaTuz2HZQedW7GA8
         SP/ovagLqDK+oj6iwtBadN4/UrKJ7Ikqao3V1bOCayYobPNZWspV257mnCgr6uD/M+rY
         IgqCdIa4xNtToaOc8RAiqhwYJ5VB4O7Rcjz9+DVzKhTiIhNkIQihHSoJgKxtG43l1Noh
         DpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790695878; x=1791300678;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUokiXULiB5QsBWdM9hQZjEq8BVs/Diba1IyZLK0fCQ=;
        b=OzYhqexJXYoLIpix67JzPkFXOx86c0flQBo8hxkhZm1JWVhs6/tLAmu/llaKauDyaA
         xny4S59fRSCq539ZBywvwUxoQTulS+gDYmPjBqIDg9h8sUpSgetWjlp+2jTgBbkkIKOt
         AP5synl0+JMhRH56Pzz0kwVia+2WRgY12Au6AppDgPoVSckY0H+0aiOVuyMjiFrwbw3c
         gVfhH1ThvLw+4vQKxNBUq4yREsAUmXfbeYUGFA77VD+0+5aHPVHrY8qtkTaN/23zYe5r
         p5FhnYKogAyRF+v3G76JemwQmQMvWdZ6m+AjI57ZKO4AtAWacFaJMauQGTuYxNvoQ1ES
         o4nw==
X-Forwarded-Encrypted: i=1; AKwUvBwVKOucdEUyE1za3ZkTdWm5n4UjMzGwaZM3nGFf1SkC7EFhKKJqRy81PuRdBVgfWN2WBiRcMCU=@vger.kernel.org
X-Gm-Message-State: AFuF++kW5RbCq7A4TzeV0eF3FkR0vY1ynbl1aGy7NlShiRd1e6GA2YFI
	8kjDjDNUx9pFJaWGB667eSvbUn7kfH60BscdX3R5niQxSwRT+mCwWq48vIqkCVywHYcRtfaBxFC
	IofJroDobJQ==
X-Gm-Gg: AYBFou3kdPeWGKrV1dksA+w5BFISn4MpwbmqLHrSR/82y2kia6DAjyubZ56Ng15Rrur
	+V7rD+TVGcilipNdKJzjukwQ/NUC0zNKUitpTS6qeGHR6NTcIwVCj9FE71Fa17HGI61hH2nPdIw
	JAiRjTt4QQV0KNiv5FCMWCvkFq/NP0gjWhIJwLN1PJKY/yRljGgEyaJ/cOVsK3EZE1JqOHsNfdj
	oC/+oWSarxn1UgeHXJssKuPLpE8/ni6vh7OY+n5bR/RGmmf2pP8VxUk74DG0wSfnEBjcXrlN771
	WBbYP1AhCiVXAi9+u7zs3cyCgcmNrFHGG4blI60XcCK61ZcE/fqJqbpouBKKiFdjTH89OJDjqFi
	zmuGSin6nSpxpFbta6uSqTnu0BIPFcDvo31h0bf5VFcQSt2GQ5ZIiWi1eFDKWuwmtqN0oUm1cQG
	yXsC+3xTMKEFNFwkXL7VS0cYz7WbYxUbCh6ybz4M+VSBXS/Nm7uHZ/v4XLW4o4roUa2soVXZT+F
	scUb9UuufYdIyTTDaLU+0xoeZkHJOoVltgdqXN/TeexxLCAnEzDpm+FBQBMILbRD9MF7cNz
X-Received: by 2002:a17:907:c8c8:b0:c25:62db:772b with SMTP id a640c23a62f3a-c2ac23858f0mr1428859766b.7.1790695878179;
        Tue, 29 Sep 2026 08:31:18 -0700 (PDT)
Received: from smtpclient.apple (80.49.145.194.ipv4.supernova.orange.pl. [80.49.145.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e11b9b22fsm1416666b.6.2026.09.29.08.31.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2026 08:31:16 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH net] soreuseport: Fix use-after-free when a socket is
 added to socks[] twice
From: Norbert Szetei <norbert@doyensec.com>
In-Reply-To: <20260928174546.4022833-1-kuniyu@google.com>
Date: Tue, 29 Sep 2026 17:30:57 +0200
Cc: daniel@iogearbox.net,
 davem@davemloft.net,
 edumazet@kernel.org,
 horms@kernel.org,
 kuba@kernel.org,
 linux-kernel@vger.kernel.org,
 martin.lau@linux.dev,
 netdev@vger.kernel.org,
 pabeni@redhat.com,
 willemb@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E620A4AC-8FC3-437D-AE14-31D50C7E2007@doyensec.com>
References: <6E4F8645-9453-45F1-B068-52E1B14E8B0C@doyensec.com>
 <20260928174546.4022833-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)

On Sep 28, 2026, at 19:45, Kuniyuki Iwashima <kuniyu@google.com> wrote:
> This has long been a known problem, and I think it's time
> to fix it instead of working around it:
>=20
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 2948dffcc3e1..a33cdf99368d 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1324,6 +1324,8 @@ int sk_setsockopt(struct sock *sk, int level, =
int optname,
> case SO_REUSEPORT:
> if (valbool && !sk_is_inet(sk))
> ret =3D -EOPNOTSUPP;
> + else if (!valbool && rcu_access_pointer(sk->sk_reuseport_cb))
> + ret =3D -EBUSY;
> else
> sk->sk_reuseport =3D valbool;
> break;

Thanks for the suggestion. I tested it with my sock_reuseport.c change =
dropped
and I was not able to reproduce the issue, and migration and resurrect =
still
work.

One question before I send it as v2 with Suggested-by: you, unless you
would rather post it yourself.

Should the check be restricted to TCP?

	else if (!valbool && sk->sk_protocol =3D=3D IPPROTO_TCP &&
		 rcu_access_pointer(sk->sk_reuseport_cb))
		ret =3D -EBUSY;


The closed section only exists for TCP, so TCP is the only protocol =
where
clearing the flag leads to the double add. With the check as it is, a =
bound
UDP socket also starts getting EBUSY from setsockopt(SO_REUSEPORT, 0).

N.

>> Clearing it between shutdown() and listen() makes that listen() skip
>> reuseport_add_sock(), and with it reuseport_resurrect(), so the =
socket is
>> hashed as a listener while it is still in the closed section. On the =
next
>> shutdown() __reuseport_detach_sock() does not find it in the =
listening
>> section, returns false, and __reuseport_add_closed_sock() adds a =
second
>> copy of it to socks[].
>>=20
>> sk_destruct() calls reuseport_detach_sock(), which removes one of the =
two
>> entries. reuseport_grow() then dereferences the other one, because =
its
>> loop runs over every slot up to reuse->max_socks:
>>=20
>>  BUG: KASAN: slab-use-after-free in reuseport_grow =
(net/core/sock_reuseport.c:291)
>>  Write of size 8 at addr ffff888132359988 by task poc/621
>>=20
>>   reuseport_grow (net/core/sock_reuseport.c:291)
>>   reuseport_add_sock (net/core/sock_reuseport.c:350)
>>   inet_hash (net/ipv4/inet_hashtables.c:810)
>>   inet_csk_listen_start (net/ipv4/inet_connection_sock.c:1359)
>>   __inet_listen_sk (net/ipv4/af_inet.c:225)
>>   inet_listen (net/ipv4/af_inet.c:247)
>>   __sys_listen (net/socket.c:2014)
>>=20
>>  Allocated by task 621:
>>   sk_prot_alloc (net/core/sock.c:2246)
>>   sk_alloc (net/core/sock.c:2308)
>>   inet_create (net/ipv4/af_inet.c:333)
>>=20
>>  Freed by task 0:
>>   slab_free_after_rcu_debug (mm/slub.c:6570)
>>   rcu_core (kernel/rcu/tree.c:2919)
>>=20
>>  The buggy address is located 904 bytes inside of
>>   freed 2624-byte region [ffff888132359600, ffff88813235a040)
>>=20
>> Only move the socket to the closed section when =
__reuseport_detach_sock()
>> reports that it was removed from the listening section.
>>=20
>> Fixes: 333bb73f620e ("tcp: Keep TCP_CLOSE sockets in the reuseport =
group.")
>> Assisted-by: LLM
>> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
>> ---
>> net/core/sock_reuseport.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
>> index 29948cb44b7d..031b641be317 100644
>> --- a/net/core/sock_reuseport.c
>> +++ b/net/core/sock_reuseport.c
>> @@ -479,8 +479,8 @@ void reuseport_stop_listen_sock(struct sock *sk)
>> */
>> bpf_sk_reuseport_detach(sk);
>>=20
>> - __reuseport_detach_sock(sk, reuse);
>> - __reuseport_add_closed_sock(sk, reuse);
>> + if (__reuseport_detach_sock(sk, reuse))
>> + __reuseport_add_closed_sock(sk, reuse);
>>=20
>> spin_unlock_bh(&reuseport_lock);
>> return;
>> --=20
>> 2.55.0
>>=20

