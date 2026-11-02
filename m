Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656692;
	b=hXUFa8gZ/ZZwTaIbVZU43JOrrZp6jMJ1ZcdCHFEfFc7ckB7ltTjvWdQ+4N9HFF3yzgTc
	 PLdWw/TGYgzeIRoCeP5CMIgW+6zvf16qKH1CF1uGEqM86c0O3TJwT/nx7B27OzVF5rDpr
	 1hziMT5YgKQYutMVnqkI6H03wlSWCt6UaxijbaGfBKzQ1R4FdyWmxIoCkMtmo+d7edAMY
	 GcshXksAhw6LLDj5f6zHeQKZRMWTIhfSujBZzBoniLlb8MFPdoJbE7jSVlQOiOOoevUMc
	 lvODhIy9OfFBveFOXWv/xJjDIqoRN0g4GRBZWt/vHIxvSmcgXJS+w8+4QxkDbI33Y9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gebPnQ/HRugxL6nfFyrvMtYAqOFjmGnjd5psHTA3l8E=;
	b=hvevmSfnsULwyLckqN1u4SOjbL01NipxVEkt6oiPn3d7ADq5gXUUJiCJsJZudIvIzfc4
	 bJdKfuYb35T+3Y7uhB4b2LkvYi23nD87udju8lCeI6simB+G1oSDO4is+cgoT5zA5D/WC
	 pmE+s4C5QQ10ADdk2YQj7M5ATIub9uaQLvIKiMEo+nBHhSAkHXN5R4fiMigbG1My/8Qpl
	 0fopGQsA2GURw8LZEkVEfeQ9N1IuGlqf5stUMcUIbHz6O6edVQJ2+/LWDQ5oOJvV4Hv8f
	 479XuIjSEbVO2lgQ5jXeY/9WW0Nnl9xSQAVmlZbb2nPx7sEGKf78ApGJhHTegtAKASw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XpBrACIn;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BEB606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 21:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83BEB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XpBrACIn
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e98798cbddso16949825ad.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 13:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793656691; x=1794261491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gebPnQ/HRugxL6nfFyrvMtYAqOFjmGnjd5psHTA3l8E=;
        b=XpBrACInLlTWuFMMdhFWtpx5vhfJhI1QN7JOShyE7KOeWmDf+zlM8nSXfqdtOAIYmW
         p2U5e2JgXjCxbcoSGl0NXCEaPwrR1uzsq/NA+2frTqpx0Bej+n8rFz/UzxoFVTSafcZT
         LDOSkEKrknltPLoqAVXEJshjq1OlvUmLH0wFOF2FFWNBRBTXce61jci2h5V8mTGBy8mb
         KV+fD451HeBs94vyBm4uJO0XUn9/HLhmyCfFU2zHzID1A1YY8tM/S/brJtcBZosUcZCI
         7gVEbgUonYzW7Gbqwdbawa5A0+yN0qbZeo5prhNTo3nufbs/9T/vYDtZbseU8Fz9+O2E
         gVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793656691; x=1794261491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gebPnQ/HRugxL6nfFyrvMtYAqOFjmGnjd5psHTA3l8E=;
        b=e/IcKYEJgQSI9vrXSpvW41i9wX282pb6YPmuUFNU7cDtha9GXVkqMPXoXJP86wAbqJ
         M0h7PXN9w+bBzSQi3F11B1MuAywthxypQXwmqj6yo42694diC8M/0HjSp8VWxJZSPgNd
         33M61sFh1iWm3jvfdx3kcLbPp3k/wwkb76SMZVG6hTKcc12LS6Zl7ag3ain/plm6KfbD
         cHalnHshwgxVlccbOAsGw9TshT6cI69gqCs3qPcmyynSFqQBC2dzqFf94RqfmCFc2Y3p
         GdqY2Q7hGEs9Bl04Y4EDWDF6Vg59wyLDNqpKty4sFbs6x1Mg9OE2acmZLgLwm6qh+PVp
         fQjQ==
X-Gm-Message-State: APuU4Z+z83U7zzKCZppYv2uAhfdPw3L3A8RbfmS/V1D2FPJ18c3EXpc9
	b8C2fXMba8WWaASaQXU1+RScX7bjhxmWTTuQXWx1+JMLJ9i6GpFxAbb2+Scs5w==
X-Gm-Gg: AYBFou3CHolnCJEVN40VlASt1+nQyAtIa6U9QwnlMzCaSsSVEXx2WJ/6jgCBhwQn1kr
	RofaJ3JeXozz3NfucIi+HChPwmiXo9goUiZ0UAT9cWDl3FcsZB5vAPEbuwZos2nA4jDzewTFGfd
	i/VrfT75v8Wq95PBfkMG719XPQ1DBicvpZlLyZv0+1TyfJPWJuRLtwB2rS7c2j/W/WTqofs8DU2
	F79eAdFrovCfcB1p54KC84v+Ub6X0L+SxVhoWC1MWIVSjf83//qFOmVZtU5XgS31PRIw4X6CMnh
	Fp84kmwjPPVJfcD1/TW73JAukVougX9wZ7q1Kq5BsWuwbv3yvQJwrKAdq7teffYYBvAjxC7e4eb
	fpJ4CtemypjfX+yxgP7/UzDUkBVPdiV4OmBjWrxWprc8MawO0hsrca3xy9YfShTGzVQ1wW3pNc6
	HQa4YWczkTm9J+0eKRaXCEkxWPMJc6GHjbHdWxOsvnwGBKeTbYivfg71w3rXaMaiRHgjt+8R9I/
	dMKcNP3Yeo/rKwLWD0sIv6Rb4751ilLiNAicKL+lmhQyTs40g0+TV/3OjiGmC8AEumkyrWXKRKI
	0Db2fXMFX81mBjvozRcr/0Cnvqg/9v2KJqJCYN2tJ1ZEzsV+auad+UNbtalyRNLkETjroBKRwol
	VwMjWe1qBd+YKzlEo2EMBU34qoeBQSix1/q6OSomo+cdqFHRQ+TcLRmfvg/jcffd1po0mjB1aaH
	iedg==
X-Received: by 2002:a17:903:3804:b0:2e6:1a6c:abcd with SMTP id d9443c01a7336-2eb364026bcmr108654215ad.3.1793656690833;
        Mon, 02 Nov 2026 13:58:10 -0800 (PST)
Received: from ryzen.lan ([2601:644:8000:37f::e34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb39248621sm31840155ad.28.2026.11.02.13.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 13:58:09 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: bgmac: stop advertising TX checksum offload
Date: Mon,  2 Nov 2026 13:58:06 -0800
Message-ID: <20261102215806.13723-1-rosenp@gmail.com>
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

The driver advertises NETIF_F_IP_CSUM and NETIF_F_IPV6_CSUM, but
bgmac_dma_tx_add() calls skb_checksum_help() on every CHECKSUM_PARTIAL
skb, so the checksum is always computed in software anyway. The return
value is ignored too, so if skb_checksum_help() fails the frame is sent
with a bad checksum.

Remove the feature flags and the fallback. The stack then computes the
checksum before handing the skb to the driver.

Tested on an ASUS RT-N16.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 2dff43f540d3..822903a3ac6e 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -145,9 +145,6 @@ static netdev_tx_t bgmac_dma_tx_add(struct bgmac *bgmac,
 		goto err_drop;
 	}
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL)
-		skb_checksum_help(skb);
-
 	nr_frags = skb_shinfo(skb)->nr_frags;
 
 	/* ring->end - ring->start will return the number of valid slots,
@@ -1574,7 +1571,7 @@ int bgmac_enet_probe(struct bgmac *bgmac)
 		goto err_dma_free;
 	}
 
-	net_dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+	net_dev->features = NETIF_F_SG;
 	net_dev->hw_features = net_dev->features;
 	net_dev->vlan_features = net_dev->features;
 
-- 
2.56.0

