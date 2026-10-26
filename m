Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.154.197.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013840;
	b=ngCfhXvXukluEa2N7/K5i24LIcxcW1Fn5cFklmIw10c1uKcYWhGzDgRqHdqxrDFZqge9
	 Wl7jVW8Vg2Rco7zWnrgV5MVu+fqyyAuYcEvAD26geYkzrF8OQGM7V66qYRXP/1n6zgUtn
	 VxGAgNYOGkGTtdH/PN4oErbOwpFiuseWjgQxsn91l4npwACAPtXcoNRLzjTGW9L1WuY3j
	 R1IcTIfo4XpU1FshvkG/tryrhSxcLV6h+kP8hqNh5SSQ+y3CNXYCpTfnnc2TclUsGwTc5
	 8iw1TVnnoVkCH1x3tOLbes+5fNA1Ibl5FPq2Yk7mkxSeuQc/AURXP5BjsodMyccRngg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013840;
	h=DMARC-Filter:DKIM-Signature:X-QQ-mid:X-QQ-Originating-IP:Received:
	 X-QQ-SSF:X-QQ-GoodBg:X-BIZMAIL-ID:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-QQ-SENDSIZE:
	 Feedback-ID:X-QQ-XMAILINFO:X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=R7Kp6Sx8Q5f+sglvC0Mx5U6/l0EiDM28FjrnVKPnQDE=;
	b=ZaCm+xpONGu4tuqGtkEcLK0gCj7i3YY6MjMGWCYOQ4m8E7hklDdQ5amXyqvC5sIw7MXc
	 MdBR78nv87fIpnHitl4W8kxHbjyDvUb2v/VwnR+hvqeA+zEZbm3JPdv1PIxRly23LHiXw
	 r4yti8jv19FERlN6aB2BOdlrIY3juJcelLxAzyxLgphfSOFLQet9FH0SkCiGDzy4KYc5Q
	 HUVApyRH78ZfAH2K8F/tkkwz+KKm6d12w/394mr6P9B3BUWkIKUPHEfCmwldVFXxeG68y
	 x0yu0L6rkkUhrB90Dl/mKoBoIRmlTryvkmC3+7jMEYZct7cYRguPWUhkPkKxTflnWow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tencent.com;
	spf=pass smtp.mailfrom=tencent.com;
	dkim=pass header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=e3YWYiXP;
	arc=none smtp.remote-ip=43.154.197.177
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88477606A32E
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 11:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88477606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tencent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tencent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=tencent.com header.i=@tencent.com header.a=rsa-sha256 header.s=s201512 header.b=e3YWYiXP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
	s=s201512; t=1793013762;
	bh=R7Kp6Sx8Q5f+sglvC0Mx5U6/l0EiDM28FjrnVKPnQDE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=e3YWYiXP2MPhKSphS+ZgUne+xhYnb/vHa1W7SDxgZX+Kc7heNWQYxj/icFnnOLUpu
	 a4sQxy+cxrumKBQeIXcQkALhDu5CyBFemEbucQ/8CFq0YeYEu+HgZmPDmrRZbzLBYx
	 UTz59Mk48GOSWp7tKjpBH4Oa/HgL+7zvvddNq75A=
X-QQ-mid: zesmtpgz1t1793013761t854386c9
X-QQ-Originating-IP: dv3TqDyNFUZ2ca9A5AectZ0CS8/dZuwnC2U3jdTKfI0=
Received: from localhost ( [9.218.227.8])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 26 Oct 2026 19:22:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10830747323379310559
From: "=?gb18030?B?dGVuY2VudG9zX3NlY3VyZShUZW5jZW50T1Owssir?=
 =?gb18030?B?uau5stPKz+Qp?=" <tencentos_secure@tencent.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Steffen Klassert <klassert@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	security@kernel.org
Subject: [PATCH net 0/2] ipv4: fix the fraggap out-of-bounds write in __ip_append_data()
Date: Mon, 26 Oct 2026 17:51:28 +0800
Message-ID: <4EAC037C49E647E1+v2-20261026-cover@tencent.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OL/6RyBS/f6Qwd38RI78eDKuvwy+UkRsHdJK8BJnP67S/jsQQRK87qxq
	R0pU+kUwvWEDmNGsdwmJ1r346vb8gwPru6Ez1Zn10J2xKDNS45EgSBa3BoVFspXUZ9jVotj
	+SsOpYg2GH7iOvraxZYSlWwqbpplMSQ7GRMgMQ6jz6VHXpAWHMTH+fcklOM9KwwRDrMfr40
	Aarw+imYyRHGERVVFLWQaGKiytftNV/+BS5HK4Rp4lrQtfO/BJY89p9ktl/9py1toRmX11+
	JO/M13DDsehG1PNybdI7kJtSZbzHNTBCm5PXZhphEUO/l+PwC2CLUzrz1+aNcJ1kOWMbakU
	FHIdLlicVUwVc1zxRn/At+TnVhUtRoaFaSACFkpuFT3DSXNzBI92uupXQVvxOm2oPmmQY/W
	Hs5EqcnWR+xUREBfOTdJGijX+k9kQVI51D/wqiC2odRRcV+X8IkmcWyKMo54ULQm8boelSi
	hFQbP6y+zSuPGOMAWXRZ0Y+C0koTsCad95y1ljjXqGbC8pP6JW/RXG2vgtCyQoA/+uLrovE
	ffg6BtVWKBV+uQJiRtACIQox5/8UZkplY2ym6S35kTq2l/QnfOYdHfId6xjJqJ3lmaojats
	tD+kXaWa4w92eKLWk1bex/GdU+Wxy3n9p6AbUrwcEEDS3dRInRCguMJ71czxY1YyF/ZMW79
	mDmi9yCUUsl2P0RASW1Ha3PxIr6YHGXe0C+Fbl0yZJNeLaXDec4j1KCLZpHyBKDrMTa1Nx+
	lYfkAt6imx7yj5JG3OtdlOOJhnG/BarhvC5cqMA9OwFPtqs/3ly2lySxzQmC5TqevX6VvrP
	f2YygTv0quKJbz5kRg0Eblzgb/kdcUbZObbRCpTk6rXRj8oow6T8YGsaBgQt+2h8M1jglm2
	fW+eATxO9Y3igaU5D+sk1zaSztUxagoc67MJVxcXj9A70h5QViZIvUiEwDxHx7pNoCsbbl6
	ja42HdiRSKipq0qMxtdxr1hVi
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

v2 of the fix for the heap out-of-bounds write in __ip_append_data()'s
fraggap relay. Patches are against v7.3-rc7 (f909e534f5e3). This was
reviewed off-list with security@kernel.org Cc'd; per
Documentation/process/threat-model.rst it falls under "excess of
initial privileges", and the reviewers concluded that posting to netdev
is sufficient, so this is the public post.

Changes since v1, following Willem de Bruijn's review:

  1/2 - Dropped the alloclen += fraggap approach. It rested on a
        misreading of eca856950f7c, and enlarging the allocation does
        not address fraggap > datalen. Replaced with the root-cause fix
        he suggested: reserve the xfrm bundle header as headroom, the
        way IPv6 has done since 1f85851e17b6 ("ipv6: fix incorrent ipv6
        ipsec packet fragment"). Every fragment skb then keeps
        skb->len <= maxfraglen, so fraggap stays within the alignment
        slop the relay was designed for and the copy destination is
        provably in bounds. Allocation sizes, tail positions, tailroom
        and truesize are unchanged, and it is a literal no-op when
        dst.header_len == 0.

  2/2 - Replaced the copy < 0 guard with a check placed before the
        alloclen branch selection. The v1 check was dead code on the
        paged branch, where copy is identically 0 and the actual defect
        is pagedlen = datalen - transhdrlen - fraggap wrapping
        unsigned and breaking the alloclen + pagedlen == fraglen
        invariant. The new check covers all three branches and fails
        before any allocation happens.

  - Removed the reproducer recipe and the concrete sizes from the
    commit messages, as asked.

Testing:

  - The geometry that previously wrote past the skb head now sends
    successfully and produces correct fragments, on both x86_64 and
    arm64. The instrumented build reports no out-of-bounds and no
    KASAN report. (v1 only made the send fail; v2 restores the path.)

  - With 2/2 alone applied, the same geometry fails with -EINVAL and
    the instrumented build reports no out-of-bounds, while a pristine
    kernel hits the detector on it:
      pristine:  FRAGGAP-OOB-DETECT: fraggap=400 off=76 need=476 cap=384 mtu=68
      2/2 only:  sendto ret=-1 errno=22 (EINVAL), 0 detector lines

  - tools/testing/selftests/net subset (udpgso, msg_zerocopy,
    ip_defrag, pmtu, xfrm_policy, xfrm_state, nettest, ipsec.c) on
    arm64: identical results on v2 and on a pristine control kernel,
    including the pre-existing pmtu.sh, xfrm_state.sh and ipsec.c
    failures, which fail the same way on the control. No new failures.

  - UDP loopback smoke across fragment boundaries (40 / 1400 / 4000 /
    60000 bytes, IP_CORK and MSG_MORE appends): payload verified
    byte-for-byte on receive.

The reproducer and the full verification logs are available off-list on
request; they are deliberately not in the commit messages.

This was found by TencentOS Corvus AI, an automated research pipeline.
I reviewed the analysis, wrote and validated the fix and the
verification above.

Anakin Zhang (2):
  net/ipv4: reserve exthdrlen as headroom instead of counting it in
    skb->len
  net/ipv4: fail append when the moved fraggap exceeds the fragment
    data

 net/ipv4/ip_output.c | 13 +++++++------
 1 file changed, 9 insertions(+), 4 deletions(-)

--
2.55.0
