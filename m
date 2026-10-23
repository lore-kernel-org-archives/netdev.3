Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742415;
	b=cLXtffup9sUSy2ZJniZ8jBk2xJjDPOhiyRWDYnFYZEFEX6nMwy6k9Xcs4tRSOt2MkF5O
	 jeif26/aonBl8E/CpwKJYZj1abOLIrAPenjpgy3X/5odsuaURTf1WhAY8wLzHbb79hqU1
	 Ute/mBLbQIE/4d9EQ4SSJ4Q6/aSv+7gZtYv1eztRxhb8IgQH03Zw1Db7U810297obj4A9
	 L7a2/cTK4QZoW/GHRMESEJLIfNAH9CiPkqLknxZUh0IgGFABZXvqlZtKF3SycdgwmqKgg
	 hBVcd5ZntCkaCbr6t+dW+OwyeIqp91/AShzZVEd5vt3SDjcmJZjcgyC4U5Dl0ZiSNIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742415;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ItkFITQqVemDflnB6F4EjAtu7VU2GDqfU5CqgHSl5ag=;
	b=hpA71FkMtQBZLnjzV4NYszzc20YHpivZOBpvZwOm1UDnMbvo+94GjtzxYrDlb6J1VR6y
	 OW685YjRIYyHHjg0qIqWgxU04b8PvqpL+fq1g9JiOfqAiy2Z/DasP0oI4dmFCCD9PEMNK
	 QHClbFTj1FS5/dfll2cJGr7jzLGHDAW5H0o/Nc25DZWN1VLRb3XYGWSI1C9cEQJ3D6X3N
	 v/RWIil9skFc6oZBM4uos/GV1V4QxhKG6UFwB+pDLkFEO3w5IHilrkSWTGF20ehHICq0V
	 0e3HzNo1VhtFLVrBXJgA1W2wBJ5IEZJpcUe6Xz8H7RbJF4pujsr4WfxZEX75fB59KYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dTXPoxop;
	arc=none smtp.remote-ip=91.218.175.25
Received: from mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7ECF606A31F
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 08:00:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7ECF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=dTXPoxop
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nRUZmgSDvGljOjKJtqokZxEuSspYSr0j3ajei4dg+dU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792742412; v=1; x=1793347212;
 b=dTXPoxopHflo3Rltzuy0ZvhB2RyZkBABrOZEfOmM5+b6FWkYHe0LdBEcIDyxDhasc9kPGD0H
 N3Manxde9PL7Rt6Ym78cO3aDOQ0vCLbycN82vG186e7aW+BbkQcg9TiDeTmOrb1PgPP91TR5BAW
 752tv1Z+cbU/Ed/6gAdxImxw=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 95aa2cc1081f3afa;
	Fri, 23 Oct 2026 08:00:10 +0000
X-Mizu-Trace-ID: 95aa2cc1081f3afa
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Eric Woudstra <ericwouds@gmail.com>,
	Felix Fietkau <nbd@nbd.name>,
	Asim Viladi Oglu Manizada <manizada@pm.me>,
	Guillaume Nault <gnault@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] pppoe: drop discovery frames with no MAC header
Date: Fri, 23 Oct 2026 16:00:00 +0800
Message-ID: <20261023080002.221332-1-qingfang.deng@linux.dev>
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

Commit 8540827ebac6 ("pppoe: fix reception of frames with no mac
header") drops PPPoE session frames with no MAC header to avoid reading
uninitialized memory.

Apply the same to PPPoE discovery frames, as both functions read
eth_hdr(skb)->h_source.

Found by LLM static analysis, and reproduced using the same TUN
injection as described in the mentioned commit.

Fixes: 8540827ebac6 ("pppoe: fix reception of frames with no mac header")
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppoe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index ee0e318d6a2a..bdaa8cf8404b 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -460,6 +460,9 @@ static int pppoe_disc_rcv(struct sk_buff *skb, struct net_device *dev,
 	if (skb->pkt_type != PACKET_HOST)
 		goto abort;
 
+	if (skb_mac_header_len(skb) < ETH_HLEN)
+		goto abort;
+
 	if (!pskb_may_pull(skb, sizeof(struct pppoe_hdr)))
 		goto abort;
 
-- 
2.43.0

