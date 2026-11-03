Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728308;
	b=4hzf62aJPH2MgscHEIv0UrPo0iyXUEp6W5cRj2Uxeqk9uring1TJAEyZ5a4KvdsCle0F
	 7fkISyYPquLQZtJ3hMo1E29UOPFCyCksOveWPdJoYYLAnhPDLT350c2zJaPYRWmvX8Qfg
	 ij1oe32r6SQRy/D8b6/jQ3lukRWbG+EiJjVrBNdYtwk7TMvM4ebhT4PzDGyvFcI5WcJG3
	 x2pbwVj+FwyzIl217rbknX5i8BUBv3bh2/0laZ7x4hFu20TEjTFHNCIWEYpwaDaLMtOZa
	 ab/MDIjjSgNb+Tg+nmz8q4y1JtRLd/hdRIe8MPDHueF+iT29CVvKqfPTcNifhvMhTEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728308;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=0F23DVeIluaxu/HEvkvya0fwoTwqonK1mhTJ9ygyfhE=;
	b=EJKLnlzjecwHAkMJytYALy2qpcNo3X0Y9tD2o9OwBIOuP52jHL4SxbbmK1yImIvTb36U
	 2R60o44+uqw5pk2YXCI6fOO3fDXJHsGX3hiwWoDYPt/nD3E876J/ObN8IzmQrmOC2LG4H
	 /QgEmQNIko5MoQfD1tR3YhsjnhyQEL4PZoUw0BbVcRZte/OtczgDKNpe+jP81v6+LXBDg
	 JZUgpzq+VMY9C1Txoxi5kANoldRDwyaucx6PMJhaMmFdo017qq8jFWkzjS/gSDDb47A3W
	 lJvIFC4Ce1oouuvEHo76xAYc397EIOVaReZ7cJClXr52Z6OEfYu5j2j0vKmLypWag7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIHssiWR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E1E606D81C
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIHssiWR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708021F000C1;
	Tue,  3 Nov 2026 17:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728307;
	bh=0F23DVeIluaxu/HEvkvya0fwoTwqonK1mhTJ9ygyfhE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QIHssiWREUVJSlqb/LNYVHNtyS7l4JiW09Q+gWsn12jE01W2f2dg43WAV8Rbs5qNG
	 K/1vWqVhWogO/7Z3QwIpNFjE3r5HTdDy68w57G6ryeqrao8BOvMw4ev8HHG2fjBt1L
	 w+qZM9poI3Jse78kv088d8MdDKjfOkOAWf5/+budkOzo1lLt4v9MjPhZ+jHiakOGbh
	 vEOx5twm6W++ZHb7noDQcRJnaEh83p/scozo2fEtxyv5PdlJ4JPSrW8jyfsZNH9jYB
	 aDCS8A2N844h2bsAp8DbZiP/fn2GDQSJEbclBukaAfJDbikwY8jYqo9R6LSYyXdrxo
	 3pkgi20WPe6fQ==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 03 Nov 2026 18:51:22 +0100
Subject: [PATCH net-next v6 11/15] net: ethernet: cortina: Account RX
 buffer size in truesize
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-gemini-ethernet-fixes-3-v6-11-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-0-c4b5ff8a65d8@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

gmac_rx() charges only the received payload length for each page fragment
attached to an skb. Each fragment pins a complete free queue DMA buffer, so
short packets understate their memory use to GRO and socket accounting.

Charge the full posted fragment size for every attached fragment. The skb
already accounts for its own head separately.

The issue was found by reviewing the RX fragment accounting. The series was
tested on a D-Link DIR-685 with media playback and ksmbd transfers under
ping load.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 972119080c2e..7569c9935b85 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1862,7 +1862,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
 		skb->len += frag_len;
 		skb->data_len += frag_len;
-		skb->truesize += frag_len;
+		skb->truesize += freeq_frag_len;
 		frag_nr++;
 
 		if (!(word3.bits32 & EOF_BIT))

-- 
2.56.0

