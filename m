Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9644A3F8
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788292680; cv=none; b=ULh6pRAk5V8PXqgEeX1vlqg0zdpRJvDQpOWd01uqCcR3rKzJyUdT+KvoTDP28FLbj/FGPlTQ73idnqkCOYqHXSio4BuMbF4H+gCAfzXIr0q0Ys7IV9gqOD6uwk0ZIB95n/RND161zdRRi5wYLdyxkfPsn8xWqnzQumXTAui+5Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788292680; c=relaxed/simple;
	bh=ZKaUERDMGZnAIY5OMdDRn3CUnu4nw05mP4Pr14lhJPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLjq5JFjWrBFlqGrepX+VGbVt+SISfzdvRR9usxig8CHhbp4jd7uAKftZxD58w/GjfSlq8rwVppUqtBNh1QuGpFKN1SK7y81PCOTgQSLV7IRkoq961JDreN1rYCzfh480oDXGpjASvEwAMKJov+5W/nwtW899tY/8Run7lxwug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im; spf=pass smtp.mailfrom=fastmail.im; dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b=ex9cDISS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FytYLfuE; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.im header.i=@fastmail.im header.b="ex9cDISS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FytYLfuE"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id DEDAA1D00031;
	Tue,  1 Sep 2026 15:57:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 01 Sep 2026 15:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.im; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1788292677; x=
	1788379077; bh=2wl1tB57oKKl/+BK4wxd+wuZ3TFQXvsZw6wMOYUXOQk=; b=e
	x9cDISS30DuJv/pG2M33xehRzvR5KaHPsvsceJCCQUDEAeTdK9S2niBn94PJRqo6
	0XBqWnN73yHwe5Z3BORzV7yOZnBA5F4VKm2Exw6C3VqLXGnMohdovNrlzUj45qeK
	AYWVLfXrNRvliLH1myBw92AP1t0gSmw89hDs0u49tj28C0scBIOEttD9g0MhU2sB
	u3YF4PrwcKCNfM+cdm9qR+VCy3XO0/CWkExrGduA71vrR8GsDPmaEwJ+8tlARAx/
	+bF5sLH2UCcK/NWYUNyqfNcouW0Jkv754aHGKqj2hDPIo6Sh6hQD8zLCzwyXaPpr
	DocDB9ecSAo16wSFneHkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788292677; x=1788379077; bh=2
	wl1tB57oKKl/+BK4wxd+wuZ3TFQXvsZw6wMOYUXOQk=; b=FytYLfuE5BtsEMyez
	bG37Ad/TYcWKFEyyuT4ZDUn8h6vE/bvXRii7WrxGh2AvlwN9v0kyTEd0mUhsViX/
	HR3s0f4h4/QbfVsvi4obOEp23UDLIN3DpIombGcs+LXXjP1wsGNrZPBdu/quA4mS
	ZtLarY2Oe3ttxWvG44vs8NBBXuovuV7jebI/Uu1QCQuyeCAzgx9sNRI4/MgEPyvJ
	arcWHp9kWiHJSRnKMFvM7h14O/4xwo3jZzInkveCGznc5kCSKwUAdYFl/J0ZXoSE
	dOkbcAjmUaY8kWCJWmxz8xmsiwUBRBvsSUcx4ARC1yyVD+PVghSx40nEGuoXIE2c
	B23Vg==
X-ME-Sender: <xms:RS6Xaie33O2-fRiQDBIPs9bACAvfTf5OH-abFid1VRj19e3saxe1Yw>
    <xme:RS6XamkasMS6cDuZXby_zMwH2SIiazvNgKeqqiUtlfFGHgio6Uua9t28mM-dZFo3O
    vaCtF1rUvGl2z5CSSFnBzqrve60TfSULq8M7jZv-QYxnJSwCk6OqKAP>
X-ME-Received: <xmr:RS6Xapo0SAr1hLVaOTHR5Ad4pqPBrKK6JC2pstaGdJpDDAlVlHatAkqxwg5y4newZSI1K_f7dxJbnsoyGYQNLJ8>
X-ME-Proxy-Cause: dmFkZTGKERgzTLwHMclbJZzTkB5b9OqbLI5gd45Jp0QKvpxX/PDi7lz5bXZcBbrhmzxB5g
    bowSi1xv+S351ubGhtKMXNMJRgJWrFSdnSHxIzTw4vnG2pN8l8Bll3qfHquYZ9qn4oLQVL
    F3vL7m/EB1vMDELvk9pfYiB5iSfCVG/kv6WecTaKFqbdcUC0BF+SAAkKgVg66R3YbrnGL9
    00Yxarb7ziNCTezrgbrUOjeV4WX0enamJ8uc36HucQMVKlkDBor7yqbSJAxeI6gpWUm9pL
    cdk8ZxbZIT/SQjUHY1rtlPX+j53s7AxzOR99/kUZ8I3iYM3H0larM8s88fzgZMtaG46zeD
    61RZvQtrdK/iyfWGL5AKxguB3wcWhyAOtMHRni6E6K8YKY0D2lU/4LexcEqXIKNCiqdUMz
    /JSIptVYO6pdqrCcl/8lGb6JRx+YAl6yQkwTX/y16bMr55ab7byM888w0NQP4DmTYX16xu
    ZXSu/kK1BV9o8d+LQcHL6jTTlclkGqsfSe/PfZx3rhI9xT3NR2/Xc0JRNXqqcIXkMknIga
    JjWFku32BNSbYmIb5KUMtbnpeg9Ol3CcVi2xrf6+LcnZPRLrCloXukpVRWNyoX2iEgfoH1
    mNeI3wPMT+uJzLDPy5dO+C+x2wh6QF5ZyuOtK0ePyxfZ35lPkkCDbSNm66Dg
X-ME-Proxy: <xmx:RS6XarHlX2ULOSelaBuqCKAeuEC5Lw6BbInagLlbUzzrmOveTGe6LQ>
    <xmx:RS6XanTXiCPKhQKHfqWsJF_6nJpLqbJISB62zaNCAs3Sqm6E54R9KA>
    <xmx:RS6XapNncH0fKlD1hIxy0bXRgXnG7gYJCyXP_xZtRTipx06DfgccwQ>
    <xmx:RS6XasmbUbzkltPXN7Vk3QyxVBKNOtxxRiARMzZRUXrxrzFK5YU6qQ>
    <xmx:RS6Xamz3OUjP14Wi1_DMkTXfK0KbdH8rTCaZZD2j8HVceXLvW4STO98l>
Feedback-ID: i559e4809:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 15:57:56 -0400 (EDT)
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
	syzbot+ce13c07d96d04716eaa2@syzkaller.appspotmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v5 2/4] net: ipv6: Fix UDP length overflow with PMTU discover and big MTU
Date: Tue,  1 Sep 2026 22:57:12 +0300
Message-ID: <20260901195714.673548-3-alice.kernel@fastmail.im>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901195714.673548-1-alice.kernel@fastmail.im>
References: <20260901195714.673548-1-alice.kernel@fastmail.im>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alice Mikityanska <alice@isovalent.com>

This commit bounds cork->base.fragsize to IP6_MAX_MTU for UDP sockets to
avoid a possible overflow of UDP length that triggers a WARN in
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

To avoid breaking sending UDP jumbograms over raw IPv6 sockets, limit
the change to UDP sockets only.

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
Reviewed-by: Willem de Bruijn <willemb@google.com>
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

