Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2657E43A81C
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902569; cv=pass; b=tIhRg3WjHdG9fUUlc0+l+KCmUL7x1jLav7YCE+fk+q0WLY3ntjhhxUQFblyX4/VbhbPVegheyI6u56ZdbxRVVYvnherWzDmEecn+NlPCPaH/Bepq60Tl6tF7JIyvjk2SUZWjIgMTgRe+LpVdht1Gu3uNTO3H752ebcGLHVlY9UI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902569; c=relaxed/simple;
	bh=dF651AL1FEKrfFSWm/sXgiouYq9dl4bGOsTBVOAPt7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7y5YKfE8qDr0waFPjdHy33ERV4tvBPb9Mp0zX0ZTw8TCEkcnfF+Zw2zMe0kePqUCONUdyFfUMAr6Ja2xd97QLUk6VKNvEXeTkvkMEkeYVAbQqCz4nIkTUwioRq/eRSWls23U06DhbWFbeDb6Q6xWrodIGNyVMZZDqG2T58YkWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvG8DVM9; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvG8DVM9"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81ed073fed0so4894227b3.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784902567; cv=none;
        d=google.com; s=arc-20260327;
        b=a9a94UZsWVlaZPJ3fhyx8/tptOnk2aF8QKU5LxJX3rRwkPVNN3zZ8czNQ3lT0UG+Wl
         xSBHzGDx7AsCKE0IBU7JQn4Qlck267isPnzDpaWyPiNhlxdIqv4ZOYEOkII1MSddYxjM
         Xr5b1Rsuhyo9iJ2xLWqoE9pHFrIdTTdGysKiMWPzBnbfTAhwQMfiQVx2kz15W9YTcDtW
         cBnxb67A2ZHjU4rLwyzF7FdqbjLqa7w8kLTGDov2SS03QF5oY3sgbBhjHKyBRBcv/4ix
         gQ3jMQXZmWis2ciU0MMJFR6mEpKN8Vf0LegVgL/Xd8GOSLJ91DDNlRBSY/QHmo+SN382
         xUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6kMoMAT8PFCNocb5di4MRJY3VHoGCDarZH4IFLuTKhw=;
        fh=UOU/+cMUATUMqMQVmJ+7BM4iKOWwPEX3hLHWFAvUfRo=;
        b=mudHGhQ+O1hvcAXqgl4mIHL5TY/tKmF/atXjUhsMU/k+s2QZu9JtRV7VqkMJ2zy6o6
         TMswXAlBRl2tgf6WqFeIwZ1HS8WNvgatIAZhTJ8CqATJKbdKo60imRa9CgD3MCiLiSMs
         M5KQFch/czm2zNY2tjvDdXpyxKpYs7CXRTmaLmR648GQdNPkcUeHIHFmvJArhLOuOE6v
         1c6DcYSqnUVnSxzZIhUeweEgWTD3xJ1xOYAWoV0F3sRSHgoKYvXYO1YTdc+Ij/30TM78
         IBtdedYQNW+zmX0sInkI9CMAY0+TzGTFzqmAFyoHRpOb0HT+xC5Di+YRe/AcAx2pAorC
         Itjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784902567; x=1785507367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6kMoMAT8PFCNocb5di4MRJY3VHoGCDarZH4IFLuTKhw=;
        b=JvG8DVM9co3RRZ9BnZZpyMCvg+KrNvnGODdmxW8G5KF6oR2rlPcQF0pEBiiaCJ/tLh
         NtJFx+eLfuPh/oxqip61zdblZCkRq7bnYE/kGSdxa6bPPUGMdAKEKEGYrxKyFT1o0iaz
         BmTPy/cDigzfVUDP693uzSbn5Ah2Kq6tTi0rxjjhGvFJpD5zEJtUZapO8dBITjnpMrJE
         RIeYDnleuhAdyyk8ZbA3Bh2cVUSMX/xnCNe9OdcOBY3UxqS1itHyDfC1RigxLFqjt0vK
         lM0DLHn4XUB+kpo8vN/sQMmoDevYaHRcAhNCvoNCVnMHUNizlWr1XIYN9fhVvnqsdxVL
         QKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784902567; x=1785507367;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kMoMAT8PFCNocb5di4MRJY3VHoGCDarZH4IFLuTKhw=;
        b=gm0aJh8VAVWMW5EKhAgrI6mPtNOyKwOFw4LL0KI8nWtHsqXTkjlPhGTMYY38WUXMcb
         m9FzMvkP36vmRtcJclCCaDBTQjsKlkEEMXyIl5ebDikXC8d8T45q1wBgsa/C5okdOF5g
         6NugOySGNZjlSQFJX74zUDDitJKC9FtAV9Hc1xqYzVMiDNlwPTmy4EnkGbXjJtuxXMNk
         NmbmEW+bscPo3gjihI6yamTOf90HsLeurjmCTkaUvlWkD+9z/jazCTFEl1X1QH9/vQKv
         8Ymm+t3jPiZfYYwpwuGHi0wBueETcdORbxDTaVcLN/+lJSSnWUE/LO4yYvQsFekX9XX6
         q19g==
X-Forwarded-Encrypted: i=1; AHgh+RqVD6+RU/GrQCc+38pOsi9/gAgq5XGsGcH41xP/D0SV/PrBX/eWLPNzge4iMEgwjS1DgAz+qJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQqmLiuJc4F75LWLs4OfdjicbyVZDVpmlIxh2CID++xxZxnNTI
	V0BFtJCTadHzSK8fpZoFvt7ja05ghD87CEpwkR3yKn0xJn+aeK0KFl8kd6sIHeoych185W8/v3J
	PQ5aLLmKW6Xnbg8gLesTZaxnBRrHhAw4hCIJp2PQd
X-Gm-Gg: AR+sD13qEkC8qkPES6HzMIxzsP15mXvgj3KKgWkBX+dJUavuOJFh4BQBlHePf1N7YNn
	WqXu6YbnIqDiJucLMI/N3vPqB763AY8BnybmUNcsZEB70Z0+vGJfUep7w4ivneKQjgzqAOLsoXE
	Y2gBCcc3sdsmHyTtNxQgSfDRhYSdAsHOEg6QVOMrSklNJ1k49OPHLVXOllhOpOImt7oMrXiRnlc
	a2V8v8qKN1ZnLiPbvJXArAcwPc1kZ2xFEf0DQoY3Mc3hOsJkeiOaST1jc5Fi7Fxo+uH7vhqDJoo
	AwJs5Gsvj8PCiocMQSgKUPBMmUGAWpvyT8obOmo9JYY027s5FpbZ+LGZMZua4C6Fgsb62+Jq+T9
	DtA/LDbA=
X-Received: by 2002:a05:690c:dc1:b0:7fd:4ef9:e5a4 with SMTP id
 00721157ae682-81f4c1d6eb8mr25626817b3.29.1784902566261; Fri, 24 Jul 2026
 07:16:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724072901.1633601-1-edumazet@google.com> <20260724064246.2a22ee44@kernel.org>
In-Reply-To: <20260724064246.2a22ee44@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Jul 2026 16:15:54 +0200
X-Gm-Features: AUfX_myRjkFwYwtYByccP3nEEUTdUFngN8BHUHKiNZfLQg3H2tKGCYoGR2a_Y2I
Message-ID: <CANn89iKuh3PbaoWskJEd7MXWZNmLDUNH7DdtE7hmAz+MTOybnw@mail.gmail.com>
Subject: Re: [PATCH net] net: do not send ICMP/NDISC Redirects when peer
 allocation fails
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 3:42=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 24 Jul 2026 07:29:01 +0000 Eric Dumazet wrote:
> > When inet_getpeer_v4() or inet_getpeer_v6() fails to allocate a peer en=
try
> > under memory pressure or tree size caps, redirect handlers previously f=
ell
> > back to sending un-rate-limited ICMP/NDISC Redirect messages.
> >
> > In IPv4, ip_rt_send_redirect() called icmp_send() directly when peer =
=3D=3D NULL.
> > In IPv6, ip6_forward() and ndisc_send_redirect() passed a NULL peer int=
o
> > inet_peer_xrlim_allow(), which returned true when peer =3D=3D NULL.
> >
> > Because ICMP/NDISC Redirects are not part of the default global rate li=
mit
> > mask (sysctl_icmp_ratemask), sending redirects when peer =3D=3D NULL cr=
eates
> > an un-rate-limited ICMP packet storm.
> >
> > Fix this by failing closed in ip_rt_send_redirect(), ip6_forward(), and
> > ndisc_send_redirect() when peer is NULL.
>
> Bot says:
>
> The following selftest regression was observed after applying this patch:
>
>   Test:   tools/testing/selftests/net/fib_tests.sh
>   Result: FAIL (reproduced on retry)
>   Runner: vmksft-net (x86-64, kernel selftests VM)
>
> The test passes all sections up through the IPv6 route garbage-collection
> tests and then fails with:
>
>   Error while performing Neighbor Discovery for the Destination Address
>   Error while learning Source Address and Next Hop
>   not ok 1 selftests: net: fib_tests.sh # exit=3D1
>
> This happens during the multipath balance/list tests that follow fib6_gc_=
test.
> Those tests probe IPv6 multipath routes using `ip route get`, which requi=
res
> NDP to resolve nexthop addresses through a forwarding path.
>
> The new early-return in ip6_forward() when inet_getpeer_v6() returns NULL
> (peer allocation failure, added by this patch) can drop IPv6 packets that
> would previously have been forwarded (and a redirect sent).  In the test
> environment, freshly-created network namespaces may encounter peer-tree
> allocation pressure after the many namespace allocations in earlier test
> sections, causing this path to be exercised unexpectedly and silently
> dropping NDP probes, which causes `ip route get` to return EHOSTUNREACH.
>
> Could you investigate whether the early-return in ip6_forward() for the
> NULL-peer case is too aggressive?  In particular, if the goal is only to
> suppress the redirect (which is correct), dropping the packet entirely on
> a NULL peer may be undesirable =E2=80=94 the right approach might be to c=
ontinue
> forwarding the packet but skip the redirect logic when peer is NULL.

I have no idea really :/

vng --cwd tools/testing/selftests/net -p 4 -r ./arch/x86/boot/bzImage
-- ./fib_tests.sh

 All tests are [ OK ] for me.

Tests passed: 257
Tests failed:   0

Note that my change in ip6_forward() does not early-return, unless I
am mistaken.

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 368e4fa3b43ca2a96f53fa4f3bc14fd6832c346f..2c44e5ed617167ce060c265052c=
d40449fdab69f
100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -641,7 +641,7 @@ int ip6_forward(struct sk_buff *skb)
                /* Limit redirects both by destination (here)
                   and by source (inside ndisc_send_redirect)
                 */
-               if (inet_peer_xrlim_allow(peer, 1*HZ))
+               if (peer && inet_peer_xrlim_allow(peer, 1*HZ))
                        ndisc_send_redirect(skb, target);
                rcu_read_unlock();
        } else {
