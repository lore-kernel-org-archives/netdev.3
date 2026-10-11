Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66E644A417
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742014; cv=none; b=XSoHHScUn2UcKUXIskCC30N70/pePVa4SZ9Ya+uoLYcCy1nvxKPXelLxq7mtLhPU8Z9hXIB5+LHpvYnJUY6zPQgEML8bF2aXoCCvbbEqLIWNAOg2UN/oxGZyoMlMcFegLolR4yBst+GhALxA7z/fQSg+hsIZVvgqDvxsxNdIoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742014; c=relaxed/simple;
	bh=oaCREIsgTzhuMCLbnkjFrh5p64rqYoQkX54l+DelF7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUb9MCE8nd6YclY/Ul17ZV0QGZErLEzUgatAyZcSByUskpWaLR5HUOG6bNeU10eQgeT4Ebrl5JjDErWDbSvov/44dOkP7Y0duDTdbQlaChNS0v2cxZl2gE/VQ2d4d2VlZ9MUIR1vkI6FbCUwD43NOrrr2ZtVF3ru7Etd24HCUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdcAPtgY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdcAPtgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B40E1F0089B;
	Sun, 11 Oct 2026 18:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742013;
	bh=SiO7tzU83chQYZjkseHrpq8wGlhR1HbBsOaIOzg549o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CdcAPtgYljlIc+fOOfRQ/3Cu0ttDQudXq7hrjTE0aCbp5QGZ7hYMemVsHKkc8/UaE
	 gurrEGeLCKRZrjhTx2oA807WQXLqDvOtUtN72unYQ2K26OTBenOmargt0mCf/S/pYG
	 spgv99MPHzr1Ejp0lmB9itXfOGQdS6gxYsgoygzQtufMwBTJ6GWOvwDuHbu3oGLnUJ
	 5B2QDo4fTEfG6t7ulUuvQRNdC8pcQdsiVOxHXsEzpdBdMxpN0bGLsy4eIBzjWE+A5o
	 zoeit8u0lX88pqReMs7TrxBoNU8AIIYUeZASE1K3924O+2AN4mVeisTOYehWgnyi8V
	 ay1S+KVg3gblQ==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:25 +0200
Subject: [PATCH net-next v4 12/15] net: ethernet: cortina: Account RX
 buffer size in truesize
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-12-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
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

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index d8bafcdf4d5f..43fd8fd773e3 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1849,7 +1849,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
 		skb->len += frag_len;
 		skb->data_len += frag_len;
-		skb->truesize += frag_len;
+		skb->truesize += freeq_frag_len;
 		frag_nr++;
 
 		if (word3.bits32 & EOF_BIT) {

-- 
2.56.0

