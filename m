Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348835;
	b=Yi+59t9CJqOXSSFDx4bqvnaZKKXojjqGegMPHrjHNrTqMKJVfVu3Rpa7e0XF323oRmoX
	 pZGfeemgPOXNX1FH24QA1hkqYxleEkj/kxTi1AjBBowSdfjeYoJpYQi00koprYAPmp7aa
	 bSPTdjhtoDbSKIunkaax5csoWIvw+LCG4YHbeJn6qlP+VHtUuSLZcwegfea07wglXKoko
	 sSftXiiPEEJ2N5xkMACLxmoEryqZHh2la54uPMMN2GsALyZyanGmg8Ui+0bWxniZ4C1PO
	 wa59WuNLYiSrn8bQwh2J5GwyIXW1Jggc8L6x/1O/0vKy5aJCoaJONFYEUqqBA0ZIfDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348835;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=GMecSFi07NeG1i2cgpuzrTwGBchnCxi415FRnpVKLHQ=;
	b=JlGIrONuseJ8DpwdBRqMgEgKQYdlETUA2MJnuO4in2nTDVLlgyPPlaH70mN+O9lfYSzM
	 w2L7/FNHSRzyy8ZczNL1ZMLa94x79RAV/rBWHVGIoXPC5qbiQf0ZbaJ8utB8D102HhbLe
	 nXKTO+oykEad3odjkN6754diTuH38XqUkzNLGciEaotxzbbHt44dyp0sOIxRA9KqNQnDP
	 0Y8GtgG3KppKlf/hUzrf9pcPrt+R0BTFSQZkAb6bIFYJUnpSRiDDWALtPhbinSKgTbqJH
	 CKTjl1bnrF4YUD1ecLmhpdIzB91SedS7dGlXVa1C19yUwx51crOMn2Py5zsKTYihQCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKseWNXO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86EB606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKseWNXO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABF31F008A2;
	Tue, 10 Nov 2026 22:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348834;
	bh=GMecSFi07NeG1i2cgpuzrTwGBchnCxi415FRnpVKLHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OKseWNXOtbrTXpMQIOKCdsAo7IT+DZ83+5B7/bOMj4MsuwiC95vWkvpU7R7muBpMx
	 2nqt5KqiLcugfK5qTZe+zgBuOApqyFC2cf46EvQa8qTa0mB6PSEulxJnbuMmPTU9KZ
	 hZgd7aB3OKOvhRzpSNhIRAmy+REDhVuR6nIKuoliYKtzaEg+c4EwUt0CbwKT0eN3/b
	 klai2V+SwrA/OWGAB/VmCd1W5QWiI7CrCD5X1RqEzrNDM6WjTyUX4TuPwhWkC0V9HM
	 TXXx+TsofNRlaAMw7a7zRB+G5AFb3hNLMNm8ttki10houTD9MRND9r5mC9mMfpNGII
	 GNWC38SPqjWtA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:26 +0100
Subject: [PATCH net-next v7 11/18] net: ethernet: cortina: Account RX
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-11-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
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
index ddda4a9c236b..73ba008a9c7f 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1866,7 +1866,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
 		skb->len += frag_len;
 		skb->data_len += frag_len;
-		skb->truesize += frag_len;
+		skb->truesize += freeq_frag_len;
 		frag_nr++;
 
 		if (!(word3.bits32 & EOF_BIT))

-- 
2.56.0

