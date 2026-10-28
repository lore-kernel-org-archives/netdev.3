Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793156736;
	b=bj7iJD1AGPHw+X4AFRWIbnPRtLSEAFnzC8V7j3NMwvfjzbWC+FoLzK9o8/xhOiRs5kpl
	 9bgboQIb4K1gMIgTs4/6b6tuH2UwLFWOphxNbnUpbgD7BuiNjtpG4M5VR9qP5mYPgqlFL
	 s01ak71vnl/w8JWza95KanC/Kdo/fGjocktrWmBA/+PayTGNZpIDs9Rk48bfvkPF77yai
	 SAadTH503cjVTQM0iCY56CPkk3TVoZtC6lNrTIsQ5pe+SBwOfBkAPaw1eg8oy1hIotONY
	 2zyYEnG+s+gZ3gxdVgE4fvI+uFkbCrHnuFgI3qX/fk9mAMHzDJVWWYkgpMzsTguST7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793156736;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QBdI0HemFF4jJcTQE7v05uTcrSaZjCfdPkQj/jMasXo=;
	b=WTteA3yN1aoXwe/aRKMcZ7x38HRRY9K+h3OPAmMuLNXVfMFBae02hDixoo4fy5pxDdN/
	 yXNjUWHBTdqE60qmHxgX82bQUY87JcZMUwuQ6PiYSIrSDyUu4rb8bNUl451k7qbyakQFG
	 O89pzoab5lb3suibiWNJGX3SwW75Zh10uC3xTd7WGW8u5Y2w5aUq9r6TqHRBZj92mGRcP
	 QyVAeCv05Dln1HGdNY+zMJQdj/TgcncWwbTmJ4DxagshgiWb7ImH8NZU3BaEGRDcK6P0S
	 ZjsCEJ+miLKsXGRVl7MYnj90ZNitDiS+eXUPDfIFE47zLStNiF8HBoJgd/gkY2Cafzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lP0Jhfi0;
	arc=none smtp.remote-ip=95.215.58.233
Received: from mta1.migadu.com (out-233.mta1.migadu.com [95.215.58.233])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C5606A324
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 03:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F6C5606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=lP0Jhfi0
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TDStg+Qul3TWcc5sp2CBXfopqRTJDE33N7mn7zCdRqo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793156719; v=1; x=1793761519;
 b=lP0Jhfi0EYjIu/zYfZn4NWFAPIHJysXiAVM4wjY50fJv5MvCsPP+nA/QSDcDucJD7p9VDaPJ
 q+cjeC7SkZjuB8wbdXF47XhZOcrSgHey7SnG6E/LwI32MjeCHPcqpXoWOuuH6JKN/LsAs7XXHCb
 5+SJNLV29M5jI+NlMCbLsKR8=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2cf9dfa8d49ad2c0;
	Wed, 28 Oct 2026 03:05:17 +0000
X-Mizu-Trace-ID: 2cf9dfa8d49ad2c0
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Julius Bairaktaris <julius@bairaktaris.de>
Subject: [RFC net-next v2 1/2] pppoe: pass bound packets directly to generic PPP
Date: Wed, 28 Oct 2026 11:05:05 +0800
Message-ID: <20261028030509.23294-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bound PPPoE sockets pass received frames to the generic PPP layer. They
currently do so through __sk_receive_skb(), which takes the socket BH
lock and serializes calls to ppp_input().

The lock originally prevented ppp_input() from racing with
ppp_unregister_channel(). Commit ec4215683e47 ("ppp: defer channel free
to an RCU grace period to fix pppol2tp RX UAF") now keeps the generic
PPP channel alive until in-flight RCU readers have completed, so bound
packets can be passed directly to ppp_input() from pppoe_rcv().

The direct bound receive path also skips the socket filter check in
__sk_receive_skb(). This does not affect normal pppd PPPoE operation:
pppd uses the kernel PPP channel and does not attach a receive filter to
a socket. Instead, it uses the generic PPP pass and active filters,
installed through PPPIOCSPASS and PPPIOCSACTIVE, unaffected by this
change.

A local receive-path benchmark sends 1492-byte IPv4 packets through
multiqueue TAP -> PPPoE -> PPP in an x86-64 eight-vCPU QEMU KVM guest.
The generic PPP receive lock (ppp->rlock) is retained in both variants.
Median throughput over 12 samples per cell across four boots, expressed
as IP-layer Gbps:

  Senders  Before Gbps  After Gbps    Change
        1        25.85       26.71     +3.33%
        2        45.19       46.93     +3.86%
        4        84.14       88.36     +5.01%
        8        60.39       68.50    +13.43%

Repeating the test with a separate benchmark-only change that removes
the generic PPP receive lock:

  Senders  Before Gbps  After Gbps    Change
        1        26.35       26.58     +0.87%
        2        46.57       47.54     +2.07%
        4        87.04       91.47     +5.09%
        8        64.01      161.85   +152.86%

In these tests, eight senders perform worse than four in every
configuration with at least one receive lock remaining. Removing both
locks restores scaling: throughput increases from 91.47 Gbps with four
senders to 161.85 Gbps with eight senders.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
v2:
 - Split out the synchronize_net() change (already in net tree e7b01bc0202a)
 - Do not change the banner comment
 - Include the benchmark results

v1: https://lore.kernel.org/netdev/20260804074452.75548-1-qingfang.deng@linux.dev/

Sent as RFC, as net-next is not yet open and commit e7b01bc0202a is not
present in this tree.
---
 drivers/net/ppp/pppoe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 9edf8151bd7d..fbd04e7252b2 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -415,6 +415,10 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!po)
 		goto drop;
 
+	if (likely(po->sk.sk_state & PPPOX_BOUND)) {
+		ppp_input(&po->chan, skb);
+		return NET_RX_SUCCESS;
+	}
 	return __sk_receive_skb(&po->sk, skb, 0, 1, false);
 
 drop:
-- 
2.43.0

