Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704646;
	b=PTbTC8LvggAliE7uMaOGrH6GQmIe+SHAX2MRVNS6DCs9vAatvPYNGMwzwWMZK+41EvC9
	 ggp53V1TVIiMM6MQiHCqHo9uZ3ThzN9AYvSYr9tlEJiXG+AL9g0Ohwc79rzIN0NMDNRIN
	 yFZzlTK9UxeO3eK3p38TouLZ2arHuEHY8SaDRRHJg+DF02PyDKUmdT6abe7OimMqS+Muj
	 i4tn7vO5AH5+IjeP6R3BI1ugczsB9d/wCbQ6J0HrZshMkq0i06EmaNbD8Lmdyy9mokJM+
	 zhqGPXlkS7IQEicEx6aE3BnabPju1EN6UHjyaI9GOUvfAlI4zkBv631OXXOBViAc77A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704646;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=qJTrP+kjOqQC+fLtoQKFgh4j2LTr9sgJUcT6kjbQdzI=;
	b=D451T4ynTgHgVQImBIgoEtd5VnnPJhWvMfk0ucN8bP8aCN5MMts0A+onGioPX68ukIrt
	 jvzNrp6Di9tu9OcnAsTXwSxIXs85wrcSDF1G6/9L2DWtX+yP7ZMblEEa9Rq+0RsJPKJ3F
	 sH35e/MU/FAhl4yuyvKZKmDt8Ka2TfeS9f9p9AzchyBLyzcB7jRBXWAy3UBx6RfpYq3l5
	 fK7SZFneHfC6B+UIjsbuzuMZ2lgI62OcJCkl7bBhZL0zbLi8VPM2dq1ZdI6nfBsdJP4RP
	 Zuk3JpuDwH9mxI787ONGFf7/ejI5tCqYs/hUqLay5ev2BwfgkcEgVw5HqrS6hUF1h0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d3kIDosD;
	arc=none smtp.remote-ip=91.218.175.148
Received: from mta0.migadu.com (out-148.mta0.migadu.com [91.218.175.148])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715E606C588
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 11:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3715E606C588
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d3kIDosD
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sujENotXY12t9gdwLn9SgJTO4k95J48ndEmhzKrZbdE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793704642; v=1; x=1794309442;
 b=d3kIDosDjMK0YP6UIZGbSsXibt1/Wam3Ebt5E/+pXHZbnw9ay/notpySx4SXGOgBSc+yCpdh
 d+YDCZkslma/tE33PBuOwqFTEYvKlJxLGJQA4D/YIH7tfeoDe6V2wV1vi4Nrq5vjS8cayTAWxHN
 2agyXBRqUqrKbnaoDl9XeAQg=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0b9e4ef34d459c9a;
	Tue, 03 Nov 2026 11:17:22 +0000
X-Mizu-Trace-ID: 0b9e4ef34d459c9a
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Eric Woudstra <ericwouds@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/2] pppoe: pass bound packets directly to generic PPP
Date: Tue,  3 Nov 2026 19:17:09 +0800
Message-Id: <20261103111711.28202-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.34.1
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
change. Set skb->dev to NULL to match __sk_receive_skb()'s other
behavior.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
A local receive-path benchmark sends 1492-byte IPv4 packets through
multiqueue TAP -> PPPoE -> PPP in a 16-vCPU x86-64 QEMU KVM guest.
The guest runs on 16 E-cores. Senders are pinned to distinct guest CPUs.
CONFIG_PARAVIRT_SPINLOCKS and CONFIG_X86_NATIVE_CPU are enabled.
This synchronous TAP receive path does not use GRO.
The generic PPP receive lock (ppp->rlock) is retained in both
variants. Median throughput over 12 samples per cell across four
boots, expressed as IP-layer Gbps:

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

A separate matched GRO-off/on test uses threaded TAP NAPI and UDP
packets with a valid checksum. Senders and NAPI threads share the same
1/2/4/8/16 guest-CPU sets. UDP GRO forwarding is enabled in both modes;
only rx-gro changes. Medians use the same sample and boot counts.
With the generic PPP receive lock retained, in IP-layer Gbps:

                   GRO off                GRO on
  Senders     Before      After      Before      After
        1       13.44       13.42       14.35       14.15
        2       21.11       20.81       25.80       25.26
        4       42.18       40.89       45.31       44.76
        8       48.09       59.12       74.96       75.73
       16       46.84       54.99      142.00      142.27

With the benchmark-only generic PPP receive lock removal:

                   GRO off                GRO on
  Senders     Before      After      Before      After
        1       13.47       13.41       14.20       14.32
        2       20.63       19.86       25.58       25.21
        4       41.15       40.21       41.91       44.02
        8       50.61       70.97       76.39       74.38
       16       48.69      122.52      141.55      142.89

GRO coalesces 3.33-5.07 input packets per PPP receive skb across
measured samples. Packet and byte counters account for every datagram,
with zero TAP drops or PPP receive errors. The threaded-NAPI results
are a separate comparison from the synchronous TAP results above.

GPT Codex assisted in the benchmarks.
---
v4: repost after net-next is open, and set skb->dev = NULL before input.
    attach a benchmark with TAP's NAPI path.

v3:
https://lore.kernel.org/netdev/20261030045943.2093-1-qingfang.deng@linux.dev/
---
 drivers/net/ppp/pppoe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 67c28ac763ef..5d5187e4976b 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -415,6 +415,12 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (!po)
 		goto drop;
 
+	skb->dev = NULL;
+
+	if (likely(po->sk.sk_state & PPPOX_BOUND)) {
+		ppp_input(&po->chan, skb);
+		return NET_RX_SUCCESS;
+	}
 	return __sk_receive_skb(&po->sk, skb, 0, 1, false);
 
 drop:
-- 
2.34.1

