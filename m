Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEDA3BBFA9
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787399853; cv=none; b=AZHq0EXkx8ncTW2zCrGIErKtNWsySkqpwRx8M9kcCazyfwBGKD8MJnxJtcV37xtRYAqMsNN7MRsdhFlIeekXzTKo8PljNBbSW1/hLdUr7jGpBkUaXomFuQ8bPhLl6kXaWHWwhF8h+ZT83pxJUvYxH0SPVVGLfe6HsA+XG0PbldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787399853; c=relaxed/simple;
	bh=Zlm5L8K0s90SM5zcTEdh/SZ8hbaKIrmefN9A8cEZP1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXYkDcc387mKZlXx7ZlWyldmn21cmbLFOBx9vc3XWg9hQ8IAv+C7Wtb/AMiKdlD1FRN6TE9nVHX/SHxcmvju6DBhUlkCjNqAYy7xrF4/Bh//bYDpU4vORYa6gMUYeltO9lYLjo+hERd/lBUMcIgWWhl5UpkJTveNB/b4o8OV4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=ttjvJJrA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J3brXx4R; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="ttjvJJrA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J3brXx4R"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15479140013E;
	Sat, 22 Aug 2026 07:57:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 22 Aug 2026 07:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1787399850; x=1787486250; bh=BqfWSkw+jVAYIMJ5sUU9T
	d+A9vXCtfJa427AkjPzauw=; b=ttjvJJrApnHu/X5fG47vxSzijOlnTKOVvjDMx
	lUxo8Mjto+MWw+vs24Ttg7apTW5iDrVgvEEpbgDpObtgb0DNOdWp4pOuF6+RMBQ5
	4P1jn7x8MfTWulTk9+WNb+ck+WC3DeWMpe+lo4TqvJsn9kvkphHRltpz9suN4kPb
	YsgqNPF0qt01Kcmn+oaNZB4srW9cuEbVx9kAjUY5wXUumNMpd7+QYBowyCn7ELa7
	Pk8+NGE/fAERhJiak0IVtif/gS3UrNr8NoHOgazXK3svDcLraLRGjUKJvIEzOMX8
	3HNBxmHMXmsSeBuCWr7Ne4NhF7UtTRweCuvu9qxv1F9bQhADw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787399850; x=1787486250; bh=BqfWSkw+jVAYIMJ5sUU9Td+A9vXCtfJa427
	AkjPzauw=; b=J3brXx4RGE1SqqUqwix4hS0iOt8bmWN9Chq/ZLuam3Pq8fxSfyj
	pwSBaO8cdZy8K20tPTzzI5zS7pG5fAJ22QMK/KPeQSk8MYWFS8TtvnTiOgYHCvMb
	JsAq1EW7iweqr0NZFTgEmYW2QiuxtIUqf5BetsMhjSd8mm5VIszdBs3Nju0dAbUU
	mzR43K0XpWsTix/z3/MZWE7FMv01JE1JVw4IN8kWVcImZWcXM1mMuax97EoKLIhn
	RTYizpBUt/ZJJ1S5zU930gkamJwcTIWLjeUfZyARWGTuTYYiQGceGutvTKkTr8Ne
	yG9BHUsRkgNoAUUz61ukc3d1rwWy3oke3Jw==
X-ME-Sender: <xms:qY6JavXURAx93Xz-URKciquSO0-ynKngjtrHRS2mDke5ZXTwEAP7cw>
    <xme:qY6Jat9I6SpeQ8dKjmTzFOS9Mt3x0LtrQRew7HBMiZGvIx1ZR78hQ7W1ogHydg5wD
    VwTMhRpPCbAoFtgz9Roj7OPmC-VhCTpu-0LNvZBbd9gwfcCZusEaA>
X-ME-Received: <xmr:qY6JanqCUOmz-DHuJ4JZUty0rnvLjR8W9NHCWC-v1PD07q5pewylTdbXKMskeGkd>
X-ME-Proxy-Cause: dmFkZTG28zW6wnDATFp4KnlBgDN75UrsFJ7x4jtaqL+8kw77Zt7QsgOq0BBUk7rgM6F+VS
    IV0Yrq7ppZA+Z2l0NhRDClATGOpvjlB6ROQ9g4UExgfIPjXEHLunek2VaOv784wTxvJhRE
    BXgjERs8tIXa8GeaHJTLVXMHWP4RWbROdEimPwWd30Gqaremvsud7mBxQbEnF+MVa4LtfN
    FDNV6bMlyplW+VKZ3UCqk4MfV1W3OCuFHgdmayZadqM4Bs9x0LPX1Bf/intLCxPwzayIiV
    3h2ymArUFLgMXLdExtyS4BbW9woloDOQ837p2Ulg5BYUDyBgQL293UGuM1iJbS68188QL7
    VQp2KwnNJypispkOH3pLedIkqMVBw+FcexcDbdfJ6yZPB7NkZwZlMCf2Gw0CtHYqxlEbSu
    g7V8Eof+eUkyTeRp1mqmfMipJOy546E1mbrGmB6jOzWaIO2fJaqRDiuP/qBuVYN131svXo
    5SGEUJfKs9L+4VqWTJUELIlXMMgXZE7WrNlrjQy0A1hVsmbEViYlTiNKAk8bOa3A+5WVA8
    gW7gaoIF4Nf9deMVJ6CCr1t9zBmhYTzRb3fJeWEeNt4ex9qzjrqmDyz6d3k9gcuGd8+B+h
    NKZrf37MliG2NWtcHZzoHOughbhbqcoPNOk1Tt+teDKMU0Mdzmf+Rgl6DDEA
X-ME-Proxy: <xmx:qY6JaoLJZiZ01XVvH2ST0o2m7oIdt8X32cV_4fOF1MzoSWjnMRQpiA>
    <xmx:qY6JaiOjkMuYvXmsU8EkLYwECRdACKoEeDYMThUWCiF-p_IyH3u0HA>
    <xmx:qY6JatozFWs5Uud6CipoxXtF7gyVd7j5xPt0xq2fBi_j4PnMcfzwzw>
    <xmx:qY6JatLSgvcEHd8iB7sXAkKDAaiyL0tuX6TZrilLuaJ5ciWG9SFEcw>
    <xmx:qo6JajtrZZUl06r3Pwk857M3KC6j7JoRN0GLnfoG9j0VWas45YjLk4zh>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Aug 2026 07:57:29 -0400 (EDT)
From: Alice Mikityanska <alice.kernel@fastmail.im>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	netdev@vger.kernel.org,
	Alice Mikityanska <alice@isovalent.com>
Subject: [PATCH net v3 0/4] Fix UDP length overflow in edge cases
Date: Sat, 22 Aug 2026 14:57:13 +0300
Message-ID: <20260822115717.1161782-1-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

These are fixes for rare edge cases of 16-bit UDP length field overflow
that might happen on netdevs with MTU >= 64k.

Exposed by the new WARN added to udp_set_len_short, reported by syzbot.

v3 changes: Split IPv4, IPv6 and selftest; limited the clamp to UDP
sockets to support UDP jumbograms over raw sockets; added a selftest for
raw sockets; added the kernel config check to the selftest.

v2: https://lore.kernel.org/netdev/20260813120351.2807829-1-alice.kernel@fastmail.im/

v2 changes: Restored the MTU clamp in ip6_dst_mtu_maybe_forward.

v1: https://lore.kernel.org/netdev/20260805205957.1652619-1-alice.kernel@fastmail.im/

Alice Mikityanska (4):
  net: ipv4: Fix UDP length overflow with PMTU discover and big MTU
  net: ipv6: Fix UDP length overflow with PMTU discover and big MTU
  selftests: net: Test UDP length overflow with PMTU discover and big
    MTU
  net: ipv6: Clamp to IP6_MAX_MTU in ip6_dst_mtu_maybe_forward

 include/net/ip6_route.h                      |   2 +
 net/ipv4/ip_output.c                         |   1 +
 net/ipv6/ip6_output.c                        |   2 +
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/cork_fragsize.py | 130 +++++++++++++++++++
 5 files changed, 136 insertions(+)
 create mode 100755 tools/testing/selftests/net/cork_fragsize.py

-- 
2.55.0

