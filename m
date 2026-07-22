Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFEE35E958
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 01:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784684283; cv=none; b=FZguR5PJTOZAYuC/gVDPVPeTF8CXCLFQ1ZcRO5o20sPIY8tOHueZ/aJ13vDdHcwNvcQDYIwra1LxGg07C6LI75PpYyq3jGD0L+n8XOu5hsazfthgfpLeJGNNl3AAPVkbV+klz5vO1+R8ZkQVISwKU9tQFjVxLZQHEQDJX+OGuio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784684283; c=relaxed/simple;
	bh=cac/C5oCBvM43JEJP2GI3KnFD6g9DhWPrPULyTyMXa8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUxTKNDztC5PR97rAF03MAib3+WAXxx18tHqgjJclSpcZsEL8GCuYvQa9F14hfrwkqxzbwbTmQXAv80hKvRiaDhFS2e/H2MY4lq0rupbGS7ZhrjfrzscZRJ065/Uxmleu7zOS8G0AsnJjFscmCjdQDeu4eqQ8J+tUUFeSVSrBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlLQx/E2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlLQx/E2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53511F000E9;
	Wed, 22 Jul 2026 01:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784684281;
	bh=0QyA7hUTWJ16dxx9ve/DbIx2Rsezxg2GSELB3/GgzbY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JlLQx/E27AVNORRIePeJS1jewhLbIpqL5iV9InCpSXG3YqKImFCB/SUGgR4LOAPoM
	 sfdBEbBHg3CXPXqlxcH9QhZRBZcgCXQz08Pr8dbrH+JUDHOVKlxLSy7groHd8LJ5E9
	 Luqtm72OtJr+tiyfytAw+xHhReb8iZO/AY8p7y0NHC6wLX6/kjjrr00DLGFoutmUMa
	 zZqQfuT53v9bqvwU5F+xBpY5yifcc0gmV87YZZoWUlg+DCKH1Ecj2hD+lZQh2lXdZX
	 tIVJtxWzzRKSZpqzj6aP6F89qxXpHj99TXIW0i9c08Ww3ygv7mjXprheh4YfjaoyCr
	 W3i4mmhRd6dqA==
Date: Tue, 21 Jul 2026 18:38:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Muhammad Ziad
 <muhzi100@gmail.com>
Subject: Re: [PATCH net] ipv4: icmp: fill flow parameters in
 icmp_route_lookup decoy lookup
Message-ID: <20260721183800.3bb3fc5e@kernel.org>
In-Reply-To: <20260716021049.2124921-1-edumazet@google.com>
References: <20260716021049.2124921-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2026 02:10:49 +0000 Eric Dumazet wrote:
> When Linux forwards a packet and needs to generate an ICMP error,
> icmp_route_lookup() performs a reverse-path relookup. For non-local
> destinations, it performs a decoy lookup via ip_route_output_key() to
> find the expected egress interface (rt2->dst.dev) before validating the
> path with ip_route_input().
>=20
> Currently, the decoy flow structure (fl4_2) only sets .daddr =3D fl4_dec.=
saddr,
> leaving .saddr, .flowi4_dscp, .flowi4_proto, .flowi4_mark, and
> .flowi4_uid zeroed out.
>=20
> When policy routing rules (such as ip rule add from $SRC lookup 100, or
> dscp/fwmark/ipproto rules) are configured:
> 1. ip_route_output_key() fails to match the policy rule because saddr and
>    other key flow selectors are missing in fl4_2.
> 2. It resolves a route using the default table instead, returning an inco=
rrect
>    egress netdev.
> 3. Passing the wrong netdev to ip_route_input() causes strict reverse-path
>    filtering (rp_filter=3D1) to fail, logging false-positive "martian sou=
rce"
>    warnings and causing the relookup to fail.
>=20
> Fix this by populating fl4_2 with .saddr =3D fl4_dec.daddr, .flowi4_dscp,
> .flowi4_proto =3D IPPROTO_ICMP, .flowi4_mark, and .flowi4_uid so that
> ip_route_output_key() selects the correct egress interface matching policy
> routing rules.

Hi Eric!

This got auto-discarded due to bad interaction with the xfrm test:

https://netdev-ctrl.bots.linux.dev/logview.html?f=3D/logs/vmksft/net/result=
s/736183/28-xfrm-state-sh/stdout

AI bot says:

The NIPA CI system flagged a regression in the selftests/net/xfrm_state.sh
test on both the normal and debug kernel configurations after this patch was
applied. The failures are consistent across retries.

Two IPv4 sub-tests fail; the IPv6 equivalents pass:

  TEST: IPv4 unreachable from IPsec gateway s2   [ FAIL ]  unreachable_gw_i=
pv4
    ip netns exec ns_a ping -W 5 -w 4 -c 1 10.1.5.3
    4 packets transmitted, 0 received, 100% packet loss

  TEST: IPv4 MTU exceeded from IPsec gateway s2  [ FAIL ]  mtu_ipv4_s2
    ip netns exec ns_a ping -M do -s 1350 -W 5 -w 4 -c 1 10.1.5.2
    4 packets transmitted, 0 received, 100% packet loss

The test topology uses an IPsec (ESP tunnel) gateway that should generate a=
nd
return IPv4 ICMP error messages (host unreachable / fragmentation needed) to
the originating host.

The regression is in the IPv4 path only, which points to the change in
icmp_route_lookup() in net/ipv4/icmp.c.

Specifically, the newly added `.flowi4_proto =3D IPPROTO_ICMP` field in the
decoy `fl4_2` structure may be causing ip_route_output_key() to select a
different (possibly IPsec-encapsulated) egress interface than expected in
the xfrm gateway scenario. When the wrong interface is passed to
ip_route_input(), reverse-path filtering appears to reject the lookup,
causing the ICMP error reply to be silently dropped rather than forwarded
back to the sender.

The patch's stated intent =E2=80=94 fixing policy routing scenarios where .=
saddr and
other selectors are needed =E2=80=94 is correct in principle, but the addit=
ion of
.flowi4_proto =3D IPPROTO_ICMP seems to interact poorly with xfrm policy
matching during the decoy lookup.

Could you take a look?
