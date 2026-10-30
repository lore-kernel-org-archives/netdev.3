Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336400;
	b=kMD4RmgNgVkWa5km53aLszEDjTwftnIMgOuICC1cHY2xppbCGDb/YPKhNrCmNkGaTmD3
	 /kSda+wbVlxEoMtmdQxQm68/ozSXYDQMFjqQlTtxXpUvZ5ZmgE4GzVmR4Cl4aQa0nBzDm
	 UZxgqtmH0yJG55BdlLPyJqFNDC+f516Li0GUhmOOzPm5yfJAlTpgQnjksZu4YP1yTNxRW
	 dlHkpq+ycBVQ6ohZF8hCFVM8WnjgdslBjiBE/cw/J3K0p2uNY/G1guu/caz8+Nu8aAL66
	 ub1eZaHAXHkNuYArV/uUtMvp0VH3dWVCFjRfcH+d0wocDG0NiKXLsqbP6YkTlpT1rag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336400;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+uhFviJi95FfRixQqgCz3QABcgJJElu6aUonffMDIc8=;
	b=002qVAVYP2jaqpvOXJDuA82Fle8dhgaSwMHLUat5Ac7kswePFRfTgMwqbfI74Q1ql3X6
	 6G8+fqk2Ru57CLERhWxEe7AP3ag4U57RBvkYso7l/aRbzehc9lnYCfbXuVRxNUGW0rLic
	 QfZRyMh9pjF4UXyxZkUAqN485FZqLwiYtLCAEc1pvtaXYwI4t+VdV4PCzog9OeS/cwPE/
	 ZzY+Us3/9M3ahySh9iuAwIbRfx5ngcouZAoUZgxdK/cy07+pDhpNVTStkfCv+WmBQg+Ce
	 zbVAASqi770fX7qll+FqEpnRWlJKgwn9yfv5/ZKtg9D9CkCM2oWQlfqLORZ0RYOHYxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.177
Received: from mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C8606A327
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 963C8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1QZfhhnleUE4Qtl413axRXSMeGIPVgq5jpbG/FueLes=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793336392; v=1; x=1793941192;
 b=CAM0eMC/IoWBKYBvBR11LKbWnwA6T9XJ6kceuVgU/asRgOwE5PylhyeiOEBfA8vgzkXozUE8
 xUSKrcoickxbdKZ6lSFZ3kXp+mjJITgjaEsKWMJMsssfNAnAj3hm9tCuOY+jtB9CeM9ZwfctQYl
 FEa+Z1HpXL7q7AV4FV0eTCD0=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9aef2a93ac6fa195;
	Fri, 30 Oct 2026 04:59:52 +0000
X-Mizu-Trace-ID: 9aef2a93ac6fa195
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Eric Woudstra <ericwouds@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Julius Bairaktaris <julius@bairaktaris.de>
Subject: [PATCH net-next v3 1/2] pppoe: pass bound packets directly to generic PPP
Date: Fri, 30 Oct 2026 12:59:39 +0800
Message-ID: <20261030045943.2093-1-qingfang.deng@linux.dev>
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

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
A local receive-path benchmark sends 1492-byte IPv4 packets through
multiqueue TAP -> PPPoE -> PPP in a 16-vCPU x86-64 QEMU KVM guest.
Senders are pinned to distinct guest CPUs. This synchronous TAP receive
path does not use GRO. The generic PPP receive lock (ppp->rlock) is
retained in both variants. Median throughput over 12 samples per cell
across four boots, expressed as IP-layer Gbps:

  Senders       Before       After     Change
        1        19.08       19.63     +2.89%
        2        31.52       33.77     +7.15%
        4        53.67       63.48    +18.28%
        8        39.79       51.50    +29.42%
       16        49.40       61.33    +24.15%

Repeating the test with a separate benchmark-only change that removes
the generic PPP receive lock:

  Senders       Before       After     Change
        1        19.45       19.89     +2.23%
        2        33.29       34.92     +4.90%
        4        61.72       67.01     +8.57%
        8        44.46      123.76   +178.35%
       16        54.62      220.48   +303.69%

Eight and sixteen senders perform worse than four whenever at least
one receive lock remains. With both locks removed, throughput
rises from 67.01 Gbps with four senders to 123.76 Gbps with eight
and 220.48 Gbps with sixteen.

GPT Codex assisted in the benchmarks.
---
v3:
 - Update the benchmark results. Code remains unchanged.
 - Sashiko reported a potential dangling skb->dev pointer in v2:
   https://sashiko.dev/#/patchset/20261028030509.23294-1-qingfang.deng%40linux.dev?part=1
   That requires a very specific and uncommon setup. Both extensions
   require a non NULL skb->dev, so I doubt anyone had hit that path.
   PPPoL2TP also bypasses __sk_receive_skb().
v2: https://lore.kernel.org/netdev/20261028030509.23294-1-qingfang.deng@linux.dev/
 - Split out the synchronize_net() change (already in net tree e7b01bc0202a)
 - Do not change the banner comment
 - Include the benchmark results

v1: https://lore.kernel.org/netdev/20260804074452.75548-1-qingfang.deng@linux.dev/
---

 drivers/net/ppp/pppoe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 67c28ac763ef..a1ed756a6220 100644
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

