Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793149838;
	b=0QjEqInV+lqZxnfBvf1bvaXULfjWWCHHQGTqDW+YsMeV8RkSHsJ0SsJRVZiZh3SILbRa
	 iZgNSBEU9yfr9bMmHeATig4dmNBGjs1GSbwg0NYxNHJrCFL1dBY7INGZA5bdQoZsPgReD
	 KFzHH+x5TSHAJwCu+0dqhq3edyKi8oVANBMWKzpVGbl6F/aCEbXzzbsGCZaWomphAvfId
	 B7OQtxmLo99NhB6F2j93vYGUVrC2BMdxumk5teEyveGFVxqWIffl45vO0GgtveVVEPxNT
	 JkJI1QQP2GGWedfcCC/T5H4xG7Ng4xC5LtE5/LplKxVUaNGjSzQvDamUBUFbSbtaUbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793149838;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ouBqehUakR7SvhmTexou4smL/OlHYmPuilTGYVp8FO4=;
	b=afxZRoS0FUev/qqlj0Ti+IFCCTaAfeWWJJtAqjJuYJId94aRWuygVtf7dfy22cybe/hW
	 Kv9r8YzLOYcFIOhlIx5FjnciCuq9Jn076lY3/wQWOL5Qv+sj49jTzvezmmWZPZN9gUv5c
	 JqWSPHxdsk/mL5d+mIY1syuNk1s5uJicdt701Gwjk8Y2ocL1b7bf6JIPwl0dNHO6MgYrR
	 idLGWHgofLXHPaLhhFmI79qkhkd10rq7xk4ItYSRGZ45FEiGXmBBvZIt3Ejz0T1rblWHp
	 Vqe5RK5QfugWDkk8DdkkQpCttxgoML3hTwA9aZ4TzpK0kx4ZjFxS63t/+d71fYDfI/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MSUIHUdv;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5663E606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 01:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5663E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MSUIHUdv
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd623dfe420so376689a12.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 18:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793149838; x=1793754638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ouBqehUakR7SvhmTexou4smL/OlHYmPuilTGYVp8FO4=;
        b=MSUIHUdvkaTyCe+FSUelzUBf0PwwVP8DFOaD8OBK7+odPFTk/RrcmvoDFWLOwH4gO/
         jcYvJbEDd/S/l9YQf2YE+5YvMv2DB+jR6RsebbrRHL8WiUAXKrZ2q2/OClAZypFBlqlo
         7koHtHdFFlMDEjHuzVVZM+qU6T0ocUOGyJaCZzlGZNcSGRwwLnQHwiDYyHvzTq9BNJtk
         fP8OJL8wVetlmnrqIX9Hoem8/Zi7pSJIOSvJS1/BAe4UUFX+JGWxwd7CGopt7SKhyCuc
         6cdnzzaKJ57fTZWD6cmJeL5BgRIUykcKrYGdGP6l7sYqgKwVajhnypzKSGHsbj0kXhGM
         KZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793149838; x=1793754638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ouBqehUakR7SvhmTexou4smL/OlHYmPuilTGYVp8FO4=;
        b=hRaIU8bFo3gE3tzAPr80u66fOkZ9b2O3lipTaWkoUCAO6dUAATdh9c6feSe/xdOpTm
         FJCHApvpCmeu16D0ypk2js7POy/A0GMdqctw0KZTuNztD2e/SadsdBJx/9PFNlOjAmen
         /hoWZseaROHJtZDQh1DV2DOh5FJJ3to5zpJ0YOVaEqDcsdDq78WUVpfdcuRNuelrURud
         Is+e8PWftq5iR2Y9+ZTjJafaVKCT9yukY/9MXrK2U3Ny7uQKpWDC0g9g+rS+iL3qDwwU
         VDZJhDNXl4E7GTwivX/UowKhbNWvx2tTZOEtzi4rIeXdugUL2smylT/J5NEphrou/OSK
         gRuA==
X-Gm-Message-State: AFq9FYI7bbfNr8L+FYbDtk/OCgaXgt9qhs3ca/rv2sgSeVtCSMJtBv17
	a2thMyhDgnUkKTx5O8nvw1hVLoykipkHUqDJGRTcHTDrnp+LYzQdwHEnz+aF6A==
X-Gm-Gg: AYBFou3ZXXMrj78tQghNvrNJHf8FJmKCEuTf/mtFOloH3jPvmoneSf3zaYfhFSZdPWK
	SGh/YpxCQboM53y311p83q5f6BAmXBK0FApNNkRAhfx21Grx5h/lpErK4MpLeFCcx8h5E7B00UL
	+Q45UCAcnpXH6LuxhCnWbNvQrzCaKnEgKukg4cv0Wn8f+W8EmWH75pSnYhpMyQyotnsL4Apw1si
	BPVIbQ1mLmLChQmRc6YGOSPPxTf8MV6f2ODRNkN4XSYmKT+nakqkVJaigIrg3iqCjoM31wfyUl9
	ILNzSMKh3XU87hJFVkA5rLZXvO2j0EQZllWNhvLqBMWuRdfQfKzFqBR6hdzJ8x6PPCB700Eoiap
	kEWEnxqvFVKESJxjW2K3LGaFpxWuydE2d8wOReLV10S1l0cNzrId1jW700PcezC+mkjojsFdE06
	OEHmTEmLOX+7SRURVhIxziSoG09slCOpJ79ZA8FntAyiq9Nk60aEgg0c5SI2pg5obxXmACLjg0G
	6xE5tY3N+SZum4lh75we7K2CTPUTQHLhPkhpDJvh41DdeUuIjxzAFaB6Av9tx1+9ZkZ2Xis/mBG
	x7JUdIz/muhEYvHK8wrFGGCl2eLoPxlPZycKD3y0nXD2dqCSYXHFBLXWVIzR3c70liIVydGydFf
	wGnJeoFOb1HiNFOJ9NINaCuAiyI6AdJb9aV3tLLpTcKrxnWIeqUKh9+Yi9ZKOEfu7gzBO9mkBSB
	kZ9A==
X-Received: by 2002:a17:90b:54c5:b0:3ac:a204:aa27 with SMTP id 98e67ed59e1d1-3ae58195369mr591267a91.66.1793149837700;
        Tue, 27 Oct 2026 18:10:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9a58d1sm456471a91.9.2026.10.27.18.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 18:10:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Felix Fietkau <nbd@openwrt.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] net: bgmac: fix oversized RX frame check
Date: Tue, 27 Oct 2026 18:10:35 -0700
Message-ID: <20261028011035.49201-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
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

While reviewing commit 77dac783f11
("net: bgmac: rate limit RX error messages") , Florian spotted that the RX
length sanity check compares the length reported in the RX header against
BGMAC_RX_ALLOC_SIZE. That is the size of the whole fragment, including the
space reserved for struct skb_shared_info. The data area handed to the
hardware is only BGMAC_RX_BUF_SIZE bytes, and the frame starts
BGMAC_RX_FRAME_OFFSET bytes into it, so a valid frame is at most
BGMAC_RX_MAX_FRAME_SIZE bytes long.

A corrupted length between those two limits passes the check, and the
following skb_put() runs past the skb tailroom and calls
skb_over_panic() instead of dropping the frame.

Compare against BGMAC_RX_MAX_FRAME_SIZE instead.

Only compile tested. Not tested on hardware.

Fixes: 6a6c708469c9 ("bgmac: add check for oversized packets")
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: replace Suggested-by with description.
 drivers/net/ethernet/broadcom/bgmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index b3a92ae95de3..6873c7bb7a14 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -455,7 +455,7 @@ static int bgmac_dma_rx_read(struct bgmac *bgmac, struct bgmac_dma_ring *ring,
 				break;
 			}
 
-			if (len > BGMAC_RX_ALLOC_SIZE) {
+			if (len > BGMAC_RX_MAX_FRAME_SIZE) {
 				if (net_ratelimit())
 					netdev_err(bgmac->net_dev, "Found oversized packet at slot %d, DMA issue!\n",
 						   ring->start);
-- 
2.56.0

