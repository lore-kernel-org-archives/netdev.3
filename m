Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.91
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550184;
	b=UdTKYGeK7VNFZEdtiUdzFp3LUZKsitlZIqU99tD8zG+p9Vt46oLH+Fpqrpkbljb+GuHH
	 KAjTgfwULXWPqU0R+jPWhY9fKxUSSQr3gJc35B4BPnmt7tPx1t/enw6tgKLLtzeSgJxze
	 fDNErjrHMHN2sgnHr4tFjL5rIz/x7/XTTN0UzNxokzkHRNl/46/4oGRueiqJ8but6em3l
	 19yX9xfoScumyCXKSsydVU1J1iuBqZTmh5+aTwHHB0Xxxih7OVJp7oPpPGwFIqRIglEXG
	 g1U3vPg6vwR7kA90ld3A9ZsncynqzpGtt4fygUz6n5sP53fdgN4QZAlOBsdVE/dWAUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550184;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GR124ABTP8hVFzVqn+1Ol538eubHOFABWIZhnPlfz1s=;
	b=4CuhEMmM3RI7o+Kp/+UmExYmfDS9suhRaQomJUqXBhc2SCMS5uBdNO+0T9qZXX9zHWI1
	 YdFeQkx8HvsifM74DfM0NEpLGwuifnDSjmIXGoJSddUJ1XnaBX24n/9zNFVXLfUZePRo5
	 XrHmNKYLq6tKWXd+lAMblR/+bgRxoyR1y485pI+yLr8SezSKrv/M4ryxSSKoQ/ENuOEcz
	 n+3D22LcT7j/lNO8qwkuQ5gihfRXmM1C48RCRT70/70s19CGhNvtdI3flf0GKJdOkoIPE
	 A9tzXG2G8+Wjj6afEM+65dy3rFyqM/CD90aikhSC7q7ornyJHStbqdOAk1ZybT+qLUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K5HXAtfv;
	arc=none smtp.remote-ip=91.218.175.91
Received: from mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817D606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C817D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K5HXAtfv
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sSx8B/MoT7F+YR3WxVCNi4OfBeJXfUbzIEWDqSFIibo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792550176; v=1; x=1793154976;
 b=K5HXAtfvFriKmutRRMVtanU08/Z/OMNmgxf+kb1ufISeHSY8qPLy6q+8FKvsMFUJrPD4IYJw
 F+jBEeMiDNjq2BbQ5oZixahqS/Kkf5KKpJAK4JDTPWGUU0XSTsOaOy8RO7k05tlDVByWKrxVkB+
 bXwWqnP/wJKQ+hnV7bqxlWsA=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 65086cd44d755d15;
	Wed, 21 Oct 2026 02:36:16 +0000
X-Mizu-Trace-ID: 65086cd44d755d15
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Breno Leitao <leitao@debian.org>,
	Kees Cook <kees@kernel.org>,
	Taegu Ha <hataegu0826@gmail.com>,
	Tom Parkin <tparkin@katalix.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: James Chapman <jchapman@katalix.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] ppp: linearize bridged packets when required
Date: Wed, 21 Oct 2026 10:36:06 +0800
Message-ID: <20261021023608.55867-1-qingfang.deng@linux.dev>
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

PPP channel bridging is commonly used for PPPoE relaying or forwarding
from PPPoE to PPPoL2TP. Both destination channel types handle non-linear
packets, but other channels, such as PPP Async, require linear packets.

Ethernet drivers can pass non-linear packets to PPPoE. If one is bridged
to PPP Async, ppp_async_encode() accesses the entire packet through
skb->data, assuming that it is linear. This can read beyond the linear
buffer and transmit unrelated memory over the serial interface.

The normal PPP transmit path in ppp_push() linearizes packets before
passing them to channels without direct_xmit. Apply the same rule in
ppp_channel_bridge_input(), and drop the packet if linearization fails.

Fixes: 4cf476ced45d ("ppp: add PPPIOCBRIDGECHAN and PPPIOCUNBRIDGECHAN ioctls")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260908072135.877364-1-qingfang.deng@linux.dev
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/ppp_generic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1a610a18893b..a84618e24d61 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2299,6 +2299,11 @@ static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
 		goto outl;
 	}
 
+	if (!pchb->chan->direct_xmit && skb_linearize(skb)) {
+		kfree_skb(skb);
+		goto outl;
+	}
+
 	skb_scrub_packet(skb, !net_eq(pch->chan_net, pchb->chan_net));
 	if (!pchb->chan->ops->start_xmit(pchb->chan, skb))
 		kfree_skb(skb);
-- 
2.43.0

