Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE9550DBA
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924344; cv=none; b=X64ZOlI0GFERG9Z2nkfzRJ+9+qxBsepephJSnuoL+pYBIvoZJSjQoJqg8VJ+YrJM6W3ax+w/zk3dIWBM3p6PII1/gqqJFr4hRLxq78kk3qrMEH2Tp2Jr2qHQS/r/LHmaLWeK1MoHHkkNg7J6KKgEmMM9WbroRGvjhwZR80f7Auc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924344; c=relaxed/simple;
	bh=0BgAVYlymJMII0VGNR6T79dO0Vsgbex65fcphmm3SgU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EHFDkeotC+J6JWuHPitfRO339GkLj6LQn0vnqMYAKoZ4aGNQz1avkjIKobGuKus3s2Fm39HMkR1GdGph1lEd33Vj6+9jnCEO2DvDfifGDAO1fNIe9qIPlnDvVx98H1rDhXiLCiSW0Yl1tURz5Gpqx2W9i+/NW1Ysm1uUu1C4DZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aCWDO5E9; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aCWDO5E9"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ab868eb9cfso113387a91.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924341; x=1792529141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x0qT31SDh86SWXXSgmpic+OSeenZgL4DO9M+aCZaoqs=;
        b=phDmpgaYX06AtqMSiTKMYwj8p2LP0eqVJEEUwGfNHfB0lh1GsjE994ItFHJ23nTMa+
         GGy57+fmTF1AwXdTHvOo+WDsy9K4TAh7++wtHaYPaYySmbRQzrc3C/njX257p6nQy9JX
         PIDSIexyIeHmbsjSTgKgQF3BTZWpcbPTFimpnSjSQAu4LzOXTmvXBVvXeO4r3LYXJF1w
         2MRaVjcNxa7BXNWTXt70e1l3jqRWNhvsL+Hhd0fQThD9vBr6llVjLvyYkagDpuN6ZcJG
         Ho+VDBzq9cfY7zPu1/1bExWmWfeNtlnOY9OJS6LCW9PocwcFVC/YaCB/W8xm8A4Ov3Ub
         gJ1g==
X-Gm-Message-State: AFq9FYKE92+PR5S3AjztWiLUu2PIOEcGNIV8BeFxAoSCjcPCnO67l+Gg
	yKLm4PM27NHDRvYfC11Tpl3KjHvEMB+OZYtTZLHPMs2uuqQBxd2dywGUKPvNSOWAGXHtku0Uk2A
	KAKMCSWE0fGt9o3aN4ZrlvgEOtuOf7uH8jYFJ7NmyTZtiEytm2I8Gto3iZktvpyhJJNkg6uc6XS
	tW8gcoPO3FzP/CaLdu5yb1UeKzm3eySHgLsR+CYvmheI3+F+iUCGQLEnt+ABvxviYcAR+sdz/lC
	hgwWGGwnZeXu4fi
X-Gm-Gg: AYBFou2s2yfFChIzWAZIhiRgLymdvcS9YyH4KtMxXJ9R9C6neadkBYsYb0gr7Is8fA2
	KH7QbR1T2+/SSky4ACnYCX9JPnbbXfaUhcCcgHFbFrw2LB8HeDhcRS3Q+hVAKiDUA5iNShEnPya
	LasTsYA1VXp+OufHuvqIwIJA1yeOc4tOzEJaVwoYXKqS9CZpwD+fz1PEuBJhdRO1jrcJxkzT/Yh
	/CHYw+1E9hr9WYAfiHmw+OL4VpJo9a2WWFeyvYHdBoC9yql4Pm8E6XUKy+OPXx78CsZybZgyNqc
	hE59ADqm9P2RgK/JRDb76hpr/Tiu047Q9jby/P1FOI/uFYDliRWpKlyayqxBV5byKNMCMtyQqtj
	HV6vi/yrg8KwGKGpBk2jtmPXibv8Ro+BBla4VwaZ2SYfNdqJaGtE4tMfQ04sjvgmddoYJZ3x36W
	LPdhWSZyHurn8CfCdoEk4/obPzNtV0SqTgSa7AFAS24Lw=
X-Received: by 2002:a17:90b:2784:b0:3ab:9cb:b5a5 with SMTP id 98e67ed59e1d1-3ab3a74739dmr11915712a91.18.1791924341410;
        Tue, 13 Oct 2026 13:45:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac678d366esm58140a91.3.2026.10.13.13.45.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:45:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-535294e0f64so64063021cf.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791924340; x=1792529140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x0qT31SDh86SWXXSgmpic+OSeenZgL4DO9M+aCZaoqs=;
        b=aCWDO5E94m+KJD3Ob78aP1eeEX0F0cEnKR0YoKvi+bNqJ+SJqWW2czNMtTyTsJT9Nm
         PqpA+Crl7AulPz1tbjqTEKpxTMLujjMACp6b7c3oQgJEoPwRyqoNMJSUgnieZfxRZzXU
         LyBsI+8EG1901p9CrxsKEBRtIitA7s1YT1zXs=
X-Received: by 2002:ac8:59d6:0:b0:530:b2e4:91c1 with SMTP id d75a77b69052e-5359fdf3dbcmr212168001cf.58.1791924339793;
        Tue, 13 Oct 2026 13:45:39 -0700 (PDT)
X-Received: by 2002:ac8:59d6:0:b0:530:b2e4:91c1 with SMTP id d75a77b69052e-5359fdf3dbcmr212167451cf.58.1791924339085;
        Tue, 13 Oct 2026 13:45:39 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535f4eee7bcsm15879231cf.30.2026.10.13.13.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:45:37 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Justin Chen <justin.chen@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v3 RESEND 5/6] net: bcmasp: account for offload header in TX short packet padding
Date: Tue, 13 Oct 2026 13:44:38 -0700
Message-Id: <20261013204439.3494046-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
References: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When hardware checksum offload is enabled for an skb,
bcmasp_csum_offload() prepends a struct bcmasp_pkt_offload header
(20 bytes) to the skb via skb_push(). This increases skb->len and
skb_headlen(skb) by sizeof(struct bcmasp_pkt_offload).

Because the hardware descriptor processor strips this offload header
before transmitting the packet on the wire, the wire packet length is
smaller by sizeof(struct bcmasp_pkt_offload). The padding calculation
must account for this extra header; otherwise, short frames are sent on
the wire smaller than the minimum Ethernet frame size (ETH_ZLEN +
ETH_FCS_LEN).

Furthermore, small frames with payload in page fragments (such as small
TCP segments with CHECKSUM_PARTIAL) have nr_frags > 0 and were skipping
padding entirely because the padding check was restricted to
nr_frags == 0.

Perform the padding check on skb->len before the descriptor loop using
skb_put_padto(), adding sizeof(struct bcmasp_pkt_offload) to min_size
when checksum offload is enabled, and re-read nr_frags after padding in
case the skb was linearized.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Assisted-by: LLM
Reviewed-by: Justin Chen <justin.chen@broadcom.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c    | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 693e8cdfe960..a855e637b6f0 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -236,7 +236,7 @@ static struct sk_buff *bcmasp_csum_offload(struct net_device *dev,
 static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bcmasp_intf *intf = netdev_priv(dev);
-	unsigned int total_bytes, size;
+	unsigned int total_bytes, size, min_size;
 	int spb_index, nr_frags, i, j;
 	struct bcmasp_tx_cb *txcb;
 	dma_addr_t mapping, valid;
@@ -262,16 +262,21 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (!skb)
 		return NETDEV_TX_OK;
 
+	min_size = ETH_ZLEN + ETH_FCS_LEN;
+	if (csum_hw)
+		min_size += sizeof(struct bcmasp_pkt_offload);
+
+	if (skb->len < min_size) {
+		if (skb_put_padto(skb, min_size))
+			return NETDEV_TX_OK;
+		nr_frags = skb_shinfo(skb)->nr_frags;
+	}
+
 	spb_index = intf->tx_spb_index;
 	valid = intf->tx_spb_dma_valid;
 	for (i = 0; i <= nr_frags; i++) {
 		if (!i) {
 			size = skb_headlen(skb);
-			if (!nr_frags && size < (ETH_ZLEN + ETH_FCS_LEN)) {
-				if (skb_put_padto(skb, ETH_ZLEN + ETH_FCS_LEN))
-					return NETDEV_TX_OK;
-				size = skb->len;
-			}
 			mapping = dma_map_single(kdev, skb->data, size,
 						 DMA_TO_DEVICE);
 		} else {
-- 
2.34.1

