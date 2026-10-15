Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8795542EED
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077885; cv=none; b=hJeTJQfwZYGvAodO6+cz2Bh60XQP5WoTaRvvwZzErmVgghck1usH4vITHu0uHnKHcfg5YL4310eYa08afkTL3F5tSpdP97TXVJ4VxgmeSf6KxNRKb6kzyqIzhL0lDzZgVjf5wSIf64S3AU1EIvIilNAEXp6uJAxXoi+Qc8A5b58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077885; c=relaxed/simple;
	bh=qATRpF6iXzAXJ/e3XvISDE3jKplabPi2qYcXQdUv9Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qXWXYuQdVnVCxccMjdp8nMC71v56R+kqL3lumGqkHPtwFVEJatjhS6BQhyZw6atp78uA22yGF8Z8q0wV4lb7dS4tbdSAS61mxAm3iznSgcUp5aap9skfzMWE4IP/u6VtkeZHYsiLcJ0Jxh/EJGtGVXFqkjui7mzbV9ZKjqPstag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWCgiKxc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWCgiKxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9381F000C4;
	Thu, 15 Oct 2026 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077878;
	bh=5mi32mBJxaMiGumfOeXHTAjQdQ2Z1fOexJQU9H6njgE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cWCgiKxcrUOfVRzQcHkiNK/HUBlU29PyARWlfdyv3RiQROfga18sHOPDUew18zDQ5
	 BSHNIV0kA7Qrjtq1icofTaOLp1xUjYSn5fmSbwSfsfgAYeCgG6lmMbPS9mKLtn4RMW
	 ueQZzmFN3JWcBZOUmCg8k2wsBbmfnybyeq/tdN7WaEYR2HfBsRPGLlE3P9F/e5Yzb7
	 D7Mw5IfWz920VzzZZfP55bi+ZLoN0l9ojBYUo2KjsqMrzRZNv7GTAhPi8qf065gnFy
	 QRZ6M3AdXnGCTVHweWTN1Ix2DxJynz/Tuek38I85qs8J65ybz0OP0JfKB0bV8B9FVZ
	 QtXmKPq6raasg==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 15 Oct 2026 17:24:11 +0200
Subject: [PATCH net-next v5 11/14] net: ethernet: cortina: Account RX
 buffer size in truesize
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-gemini-ethernet-fixes-3-v5-11-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
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
index 70aa418d7037..d4e90aa97d22 100644
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

