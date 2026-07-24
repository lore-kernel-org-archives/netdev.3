Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87323437466
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784900568; cv=none; b=bixif5d0ohMuQNIzVSTouXWYoCVJtKyR5iCrXnmf5dVQBHVDFxxxoGrWnrKF+lTXNlKGaUSozIBWs/lxmD0SmaS22J/1Kc/cl7j/Bu2TD8A3pO7q3yPSrVSrFOhisDIGMK7OcQTFJZUN45VJW+MqRWlP2elp9xZG5A7iBvo9Na0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784900568; c=relaxed/simple;
	bh=QtfCX2fMSQ2BqPbprKEmjVgne0gJyi2J1N9t6yyBsCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pR9ukAjDh09pqKGHNwfxuA/6fPvY8KH6wz+lDcQbMFfa+eOYzXn1CjrDqOE52ddVAMT4dr+l1WG+NpUOD3amdT6d+HzYJnzC4PMKrO6wRutnCvKlAtMI6s+mI7xQTfLw7KHVpBPzTJcJ2OkMuxo2eq/1nen2oL40x5TWqKEnu0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKCZeMZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKCZeMZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054EE1F000E9;
	Fri, 24 Jul 2026 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784900567;
	bh=faRE93zzH3S3kWgcQAe9myXWuOUmLIyv+clcGvTJCpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FKCZeMZnmjUuvnW1ZxWg5zfmu4XceMcK8PIGCGCioeC84TN36mN1tjGezFAvv1puh
	 D8/Xeg3mDJ8fuR5fJ0f9v47DffA70ICqBInsegAE7NGIOeeSccEIbW/HkrDQpobsJv
	 GPJTggpmyezC8Vk/MqFVDnjS8piOz81n9QC0qr1862j3GWzVA7G5FwFBHtFd8mhZ2g
	 M/qOkKC9oTDaBBzrRvzPJb3q/TxyOisXuYkH254vlUssrg6fZKOwN4jAXje2qzVme6
	 TDojSZtUBM0cA+sumDNUBTH2Dm4HVntQ3S1LN5zZHJ0CGYT2+u22NMUbdP7hCrDO5w
	 K7i295/M+aMdA==
Date: Fri, 24 Jul 2026 06:42:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] net: do not send ICMP/NDISC Redirects when peer
 allocation fails
Message-ID: <20260724064246.2a22ee44@kernel.org>
In-Reply-To: <20260724072901.1633601-1-edumazet@google.com>
References: <20260724072901.1633601-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Jul 2026 07:29:01 +0000 Eric Dumazet wrote:
> When inet_getpeer_v4() or inet_getpeer_v6() fails to allocate a peer entry
> under memory pressure or tree size caps, redirect handlers previously fell
> back to sending un-rate-limited ICMP/NDISC Redirect messages.
>=20
> In IPv4, ip_rt_send_redirect() called icmp_send() directly when peer =3D=
=3D NULL.
> In IPv6, ip6_forward() and ndisc_send_redirect() passed a NULL peer into
> inet_peer_xrlim_allow(), which returned true when peer =3D=3D NULL.
>=20
> Because ICMP/NDISC Redirects are not part of the default global rate limit
> mask (sysctl_icmp_ratemask), sending redirects when peer =3D=3D NULL crea=
tes
> an un-rate-limited ICMP packet storm.
>=20
> Fix this by failing closed in ip_rt_send_redirect(), ip6_forward(), and
> ndisc_send_redirect() when peer is NULL.

Bot says:

The following selftest regression was observed after applying this patch:

  Test:   tools/testing/selftests/net/fib_tests.sh
  Result: FAIL (reproduced on retry)
  Runner: vmksft-net (x86-64, kernel selftests VM)

The test passes all sections up through the IPv6 route garbage-collection
tests and then fails with:

  Error while performing Neighbor Discovery for the Destination Address
  Error while learning Source Address and Next Hop
  not ok 1 selftests: net: fib_tests.sh # exit=3D1

This happens during the multipath balance/list tests that follow fib6_gc_te=
st.
Those tests probe IPv6 multipath routes using `ip route get`, which requires
NDP to resolve nexthop addresses through a forwarding path.

The new early-return in ip6_forward() when inet_getpeer_v6() returns NULL
(peer allocation failure, added by this patch) can drop IPv6 packets that
would previously have been forwarded (and a redirect sent).  In the test
environment, freshly-created network namespaces may encounter peer-tree
allocation pressure after the many namespace allocations in earlier test
sections, causing this path to be exercised unexpectedly and silently
dropping NDP probes, which causes `ip route get` to return EHOSTUNREACH.

Could you investigate whether the early-return in ip6_forward() for the
NULL-peer case is too aggressive?  In particular, if the goal is only to
suppress the redirect (which is correct), dropping the packet entirely on
a NULL peer may be undesirable =E2=80=94 the right approach might be to con=
tinue
forwarding the packet but skip the redirect logic when peer is NULL.
