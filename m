Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AB385D64
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786434626; cv=none; b=rr+ri1zh7NS2QhWyxBNpD5BH7OnNkf4oqpRJQo0u065lwnqaXMn6wrV76Y9WitZstuof/M9TP3didtplz7qBv1Vi+8JVSAro0HtyVFmEsy598SThhTNiBbU0YISTzU0SNEdPHV6B8JYIwDbDBJe25/mXpaaT4P/YBEm6ialBMcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786434626; c=relaxed/simple;
	bh=IexRW26cqTS/6jJaeDSWPMpThAjO9N7+EsEgDs0gn1k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UJ+fPbEpCy2Fdq9pDMO4NH9RXADFX/JrZ/jFJQq59bpQ2GCzvnLTBNdSB1kpDmFI7JUIVjhXjfr24Tdx1JHYCwKgmsk13LI/XqtGld9ln+OE7toA6j8MdibwaE4kHRST/1puey9h5NVouLAeJQDRZkcwbpJvhNg2XWbuFTrFVo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V84vqvG7; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V84vqvG7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786434613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=etp5o1HT7t0iFGspzQ9CmM4vdczDWcYY3Wv44aynvY8=;
	b=V84vqvG7CPSl1vX+kJ6DTAidek0d+VcJrUXFoaZHg3+I7GVtzGwBOxJmcmWFt6sNUZDM32
	OPGCopzHufzAV2TLpo0MVuGGDNWUu39mglIwWpg5UoPDIU3M1SnBMQT9z/GI5n0cBrJz+3
	76ZT4i7kYZInHD1CXSBPe40x5J3TqHM=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Dmitry Kozlov <xeb@mail.ru>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] pptp: drop packets received before connect
Date: Tue, 11 Aug 2026 15:49:47 +0800
Message-ID: <20260811074948.345834-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

pptp_bind() publishes the socket by its local call ID before it is
connected, so GRE packets can reach pptp_rcv_core() while
PPPOX_CONNECTED is clear.

Such packets are queued on sk_receive_queue, but PPTP provides no recvmsg
operation and never drains the queue after connect. The packets therefore
remain there until socket destruction.

Drop such packets immediately instead. Since PPTP no longer queues packets
on sk_receive_queue, remove the corresponding destructor purge.

Assisted-by: Codex:GPT-5.6
Fixes: 00959ade36ac ("PPTP: PPP over IPv4 (Point-to-Point Tunneling Protocol)")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pptp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ppp/pptp.c b/drivers/net/ppp/pptp.c
index cc8c102122d8..a797a0606f6b 100644
--- a/drivers/net/ppp/pptp.c
+++ b/drivers/net/ppp/pptp.c
@@ -278,11 +278,8 @@ static int pptp_rcv_core(struct sock *sk, struct sk_buff *skb)
 	__u8 *payload;
 	struct pptp_gre_header *header;
 
-	if (!(sk->sk_state & PPPOX_CONNECTED)) {
-		if (sock_queue_rcv_skb(sk, skb))
-			goto drop;
-		return NET_RX_SUCCESS;
-	}
+	if (!(sk->sk_state & PPPOX_CONNECTED))
+		goto drop;
 
 	header = (struct pptp_gre_header *)(skb->data);
 	headersize  = sizeof(*header);
@@ -539,7 +536,6 @@ static void pptp_sock_destruct(struct sock *sk)
 		del_chan(pppox_sk(sk));
 		pppox_unbind_sock(sk);
 	}
-	skb_queue_purge(&sk->sk_receive_queue);
 	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
 }
 
-- 
2.43.0

