Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8482747424C
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784823725; cv=none; b=L81eB+Mvs4RXDmxT5wxOdsX5c9OuwdN8PXuAmc1OBYEX0IhNWEPQv+WLFo/Q+gjKiyh6SmwA8VW2p/ELiOExEGhBMrj9YONuXNzLUgpzA6sS/U+NZCSDttOzQ6Euy0LyHVgXU0qQBsGvGdK6wpivT2uMvrlDV8qBq7xWr81LNZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784823725; c=relaxed/simple;
	bh=NghrB147wDJP6UfR+Mb8KU2JaexQfx9i7gNM/0Bvrjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnJ1KANMPCXlKK2HcxiUvJg2UEVEbxRB4B07GI3a2MopxYtjRyoD/lSgFvXwl12HYYLF840kHGwghrxZIeb4HLt8Ncc+WZBTKHNH29t67lwQbAU7g+TS6OtLoljohJDOkL1KN7oSOuWKLhKSp7BTe5xd92bFNz56J4WYb37vR2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtmyfIa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtmyfIa8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72AE1F000E9;
	Thu, 23 Jul 2026 16:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784823724;
	bh=TavPUNRhP2sthDlOcfH12cbPSFnr3h6CiGWZbYUURgk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UtmyfIa8AunIUxGdzCFmiNgsqaOuyHcJPHCAYswgAi1MuaB/mazR0crWnBj8Tw5Wf
	 ykOl55Cpfu+9BrjZeoJOXtgUKiKlnSiibWAN1HL0lvgGSeoBOOZeUJ3S/bn6bUTz3M
	 M6dGJ/eNAEZOMQ1mjPRPn/9HUehxjKv/0Z0fiNbDDBJm8rhXUKgTrQOkyDjUh39P3n
	 yFd71j7MkotUGl35570bDFMmRwZBuxgUfnUYkTMxhO2S9IEbKWuchbZGNUM5c3bMsB
	 Kqwg49ftCI4EWR2qp5As+eOJsY2KjSnhAuUwz7kCzvzy44hLiqFOQNgN79CzEgymWq
	 K4iBdbE/pWnKA==
Date: Thu, 23 Jul 2026 09:22:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Tangxin Xie
 <xietangxin@h-partners.com>
Subject: Re: [PATCH net] vlan: fix skb_under_panic() and races when toggling
 HW VLAN offload
Message-ID: <20260723092203.5b1470f5@kernel.org>
In-Reply-To: <20260720072622.3541873-1-edumazet@google.com>
References: <20260720072622.3541873-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jul 2026 07:26:22 +0000 Eric Dumazet wrote:
> Toggling hardware VLAN TX offload (NETIF_F_HW_VLAN_CTAG_TX or
> NETIF_F_HW_VLAN_STAG_TX) on a lower device invokes vlan_transfer_features=
(),
> which dynamically changes vlandev->hard_header_len.
>=20
> This causes two issues:
> 1. Lockless TX paths (e.g. packet_snd in af_packet.c, ip6_finish_output2)
>    read dev->hard_header_len without holding RTNL lock. Mutating
>    hard_header_len dynamically under RTNL creates a data race where upper
>    layers reserve insufficient headroom based on a stale hard_header_len,
>    resulting in skb_under_panic when vlan_dev_hard_header() is called.
> 2. In addition, vlan_transfer_features() updated hard_header_len without
>    updating header_ops, causing a mismatch between allocated headroom
>    and header creation.
>=20
> A VLAN interface may require software VLAN header insertion at any point
> (e.g., if reorder_hdr is disabled or HW offload is unavailable). Always
> setting hard_header_len =3D real_dev->hard_header_len + VLAN_HLEN and usi=
ng
> vlan_header_ops unconditionally ensures sufficient headroom is reserved
> by all upper layers and avoids any data race on hard_header_len during ET=
HTOOL
> feature changes.

Hi Eric,

Looks like this broke VXLAN tests:

https://netdev-ctrl.bots.linux.dev/logview.html?f=3D/logs/vmksft/net/result=
s/742304/2-test-vxlan-mdb-sh/stdout

AI bot says:

The NIPA CI detected a regression introduced by this patch in the VXLAN
MDB selftest (tools/testing/selftests/net/test_vxlan_mdb.sh).

All data path forwarding sub-tests fail on both normal and debug kernel
builds, while the control path (MDB entry add/replace/delete) tests
continue to pass. The failure is 100% reproducible across both runs.

The test topology uses VLAN subinterfaces (br0.10, br0.20) on a bridge
that has a VXLAN device as a member. mausezahn injects multicast frames
from the VLAN subinterface and tc ingress filters on the peer namespace
count packet arrivals to verify forwarding.

With this patch, `vlan_passthru_header_ops` has been removed and all
VLAN devices now unconditionally use `vlan_header_ops`, which calls
`vlan_dev_hard_header()` and inserts an 802.1Q VLAN header in software.
Previously, when the underlying device had `NETIF_F_HW_VLAN_CTAG_TX`
set (as veth does), the passthrough header ops were used and no software
VLAN tag was inserted.

This change causes frames injected from VLAN subinterfaces in the test
to arrive at the peer with an unexpected software-inserted VLAN tag,
breaking the tc filter matches used to verify delivery. Tests that check
frames are *dropped* still pass (the frames never arrive regardless),
but tests that check frames are *forwarded* all fail.

Failing test output excerpt:
  TEST: Destination IP - match                                        [FAIL]
  TEST: Destination IP - no match                                     [FAIL]
  TEST: Forward valid source - first VTEP                             [FAIL]
  TEST: Forward valid source - second VTEP                            [FAIL]
  ...

The pattern holds for all four overlay/underlay combinations (IPv4/IPv6
=C3=97 IPv4/IPv6).

Could you please take a look? It seems the unconditional software VLAN
insertion breaks the VXLAN MDB data path when veth (or similarly capable)
devices are used as the underlay.
