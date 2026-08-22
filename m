Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC2939B954
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787399858; cv=none; b=f/pvnUNZSYQGlSEWeHQG5szJAcQvacabydAwXgbqQr+i+NViWbRr7Iv+LSXVR/DgFM1Ou1fwAACjr0qShJrdYdeyaaLr4PaQW05C97JYJW954rJeYpcH4FCrUTCeLG4q8WOFcRCQm0idj9g9V6GVvPtPA/IJhtKuaKGHlhYf1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787399858; c=relaxed/simple;
	bh=fyQnDwmBvZhwdPxpNjhVOg6Xk5kHTh49t+Kla3gA22I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hs6y3Spb4eLvIrjqEDD3DI+gSHLPzPmdZT2qcp5zh+pO3y2Y4mP6X/Du4RGBfVAG/rYO1mvNI54XP2POqNy9O2br6AeB9s+iyzJz7rFvxvnqHYPmFJyuXobG3pHsB+y/jFnE1K2sjmbQyI9JcUFpHAH9JSBoSbSRq8EqxuzewfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=iMLY9w1J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OwdYFQ5Y; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="iMLY9w1J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OwdYFQ5Y"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C4C2EC01A5;
	Sat, 22 Aug 2026 07:57:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 22 Aug 2026 07:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1787399855; x=
	1787486255; bh=ZLvMbCeSXdtQkIOWzRzI6a/TX6P3a9Bcia4D0fcTn+w=; b=i
	MLY9w1Ju1Vc5A9clRv109quA+VluTv0m1LZk8t79pTdF5uMh3WE9mTgYpQupYped
	9Xq/cp7iG7WJeNu170GtDAQU95XbIYjOXI7TDb7bXwei2INSeIfgHFklFN1fix0p
	SspjDNDfHHx8LO10FKpoQEjxkhsOtZvvxBL44deaxihvTEUW8ELoD8+8EWaRDPBl
	SCK9sbLdBzUYBsIOKtRy9IK/NU72BrLyHdCro5428SrhWiib8NLcoaTnqUJCKSj3
	6cAWhb/2d28tDdpR9/EMcDSwocNSKTw0BQ2jc8lXu4NeeOMSVIFMWJHn3+tkqFD4
	dXULe3jb4SzaLyCA+5E/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787399855; x=1787486255; bh=Z
	LvMbCeSXdtQkIOWzRzI6a/TX6P3a9Bcia4D0fcTn+w=; b=OwdYFQ5YDw2BTc9s7
	CpVA+6s9QEj0yNiqADzm5nJaazHJkI3qRP1jtYQb1n8Nd4TUut9THPPWasLnPi2V
	a3VvBtklQT7vH7GcTdTz5UWBbViy0x2D3O2gR9mxsrUJ0CLWIDjw8ZRsd8Wzge3o
	+7U2GrHJZpglNKnc2x7W7GZM2LzPfxwDUJy6P/Xr20CLQ5DwXo7wwbufuFTUabOJ
	gfHhqhvhUqk3SudWzIWNEZi4tpzucSJB7j7ROm5h9FsKGDXBqMegU1iWD2iaQYWf
	CmyY2N79M7Aj7m2QWba3Xu4pEt0W2U50jnwgUI2Vz5pJ/+UaXJQYmEeoWsBAUZsl
	cgfyg==
X-ME-Sender: <xms:r46Jap54jDM1eGR5ydGPBB6NjAKHoddlE7HGKTelxO0mXkkLx-I-zA>
    <xme:r46JalbXP3yqsj6phwywV3vIqkXHTu0tidqvwtMN9vWFLjYQkSexLctNPeDA10kAt
    -AZJR0THhVrV6MZSLb-uhPibIQ407OgNJy_FOIIC48PlA84oQ5eMjA>
X-ME-Received: <xmr:r46Jar8yDPg3yIBUIGBlNbyIX6w26proXWh4xJe5zJW5gRrQaK81QNb2VQNaUA>
X-ME-Proxy-Cause: dmFkZTGieKHeAxnH/iR+FE6N6OcyVm7Qn3RL6YH7XC3AtDbxzppyY8MSJ/1YMdQgU6rtjD
    z9nt1H5AkWp2Andn6Nveva+6C9NpZq36JTxE/z0APl1V1oRpEE/v8xVQaDcipfZAfIDr7w
    0q28WqFRTWagD5Q3OvpWJcYiyfzBlaX6/O+ksDPHmOj+CORUh5kJLqcqf1rtqDyruFHxut
    6iy3g3kYQD8GB6XqZhLmxWcdIuHx0r/eayzqtcIzyzq7reVpU9vCKz6mcsL2F93gSQvMFr
    iTr09/DDAlLQm6sXhwo3Gb4IFwgEjy75IkWgGba/F7thrJsgso0ULzBqnGnRzwMYD5pVhZ
    xm2h9e3/R3Cw9/SvdHa0cavjH21WH+/2VRCv9TSxB1ezFA8o2bbZJB9N4TeZaiZEaUUcnz
    rpg/eVpugnPaxOW+6lENHMg8TEAMpq45MTP/yYc8d09pOq6w3NqLUavltQ6gWUfmu9Chdf
    9pE/mvgfL70lPkqGNgpEL8nVSJt9G45oiUYtsg2IEXDRKBX+NtHjEGCTlvUpVDc1wlLtXx
    OO3sdlKQPfLf/AqvYOMG/wcvzNoVCJP9kosoR+gwy2d+zk4iprTJRJfg2rhWJKruysyGMu
    gc4bCN12FYE9iGzhDlJe23ZyAtwc03xGc8IEhh2pZ1SaTalQNrB3obcJN2xw
X-ME-Proxy: <xmx:r46JasTIWN8P7R3mE0VXlBT2aS60DrUYfgxFltSnMaQfZDkvnQ0SUQ>
    <xmx:r46JamITviq9hx0x-ZkFuujsLIDpt_RLEWigwmc3W_Ep2JpPA7x-KQ>
    <xmx:r46JauTdaxXQnhc9Wj9FQ-Or2H8gSP2k5u7NXvfpM9rYwBmwK-FQDQ>
    <xmx:r46JauJmrdVz7dX7gDAC0F93rUwlyf0PWZqOGN1S8n40K95bFRDwCw>
    <xmx:r46Jap7Yji1iAdohUrbo6eHyxAKzwB90eKUfDVrpSHr-GHNU-FG4JTH5>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Aug 2026 07:57:34 -0400 (EDT)
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
	Alice Mikityanska <alice@isovalent.com>,
	syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
Subject: [PATCH net v3 2/4] net: ipv6: Fix UDP length overflow with PMTU discover and big MTU
Date: Sat, 22 Aug 2026 14:57:15 +0300
Message-ID: <20260822115717.1161782-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822115717.1161782-1-alice.kernel@fastmail.im>
References: <20260822115717.1161782-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

This commit bounds cork->base.fragsize to IP6_MAX_MTU to avoid a
possible overflow of UDP length that triggers a WARN in
udp_set_len_short when setsockopt IPV6_MTU_DISCOVER is set to
IPV6_PMTUDISC_DO or IPV6_PMTUDISC_PROBE, and a large packet is sent over
a netdev with an unusually large MTU.

Steps to reproduce (included in the new selftest):

1. Set device MTU bigger than IP6_MAX_MTU. cork->base.fragsize will be
   set to that MTU in ip6_setup_cork.
2. Set IPV6_MTU_DISCOVER to IPV6_PMTUDISC_PROBE or IPV6_PMTUDISC_DO. It
   lets maxnonfragsize be set to device MTU (cork->fragsize) in
   __ip6_append_data, rather than to IP6_MAX_MTU.
3. Send 65528 bytes of payload (+8 bytes of UDP header, +40 bytes of
   IPv6 header). Device MTU allows it (it's only one byte bigger than
   IP6_MAX_MTU, and the device MTU is bigger than that).
4. The UDP length in the built packet is 65536, which overflows the
   16-bit length field and triggers the WARN in udp_set_len_short.

The original overflow bug with IPv6 and IPV6_PMTUDISC_DO seems to
predate git history (verified reproduction on 2.6.21), was fixed later,
and then reappeared in commit 427faee167bc ("net: ipv6: introduce
ip6_dst_mtu_maybe_forward"), which is chosen as the Fixes tag here. The
overflow with IPV6_PMTUDISC_PROBE reproduces since its introduction in
commit 628a5c561890 ("[INET]: Add IP(V6)_PMTUDISC_RPOBE").

Fixes: 427faee167bc ("net: ipv6: introduce ip6_dst_mtu_maybe_forward")
Reported-by: syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6a6a966c.86abc875.e5c3d.0054.GAE@google.com/
Signed-off-by: Alice Mikityanska <alice@isovalent.com>
Assisted-by: Codex:gpt-5.6-sol
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
---
 net/ipv6/ip6_output.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8fc4766c8da9..550965058991 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1432,6 +1432,8 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	if (frag_size && frag_size < mtu)
 		mtu = frag_size;
 
+	if (sk_is_udp(sk))
+		mtu = min(mtu, IP6_MAX_MTU);
 	cork->base.fragsize = mtu;
 	cork->base.gso_size = ipc6->gso_size;
 	cork->base.tx_flags = 0;
-- 
2.55.0

