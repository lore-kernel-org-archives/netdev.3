Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974083090C5
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291151; cv=none; b=UlqBT3PivbmCelNGAlXeQPFlioBam7S68ZWduA4x0Vk4mUrQWsRs6DEiYMuMvN6V6Eo9SoC4x/9GFyQSm/HYKnQHix5cAnzowKIy53QbMWDQrfZZcipNCafleHbYuGRUtsBWpFUHpyUfwu07DKv9jegfG7xOhCheUTa0Ra4gC1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291151; c=relaxed/simple;
	bh=uT8Gdsj4WmnDwk5F7IYjxDPdX4MIIvH80+iQjYGrqHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uXgMI+L3tnLgu6b07UcxRSIMwf6RBvEc0gjbJK6zYeLckGRll2X/oE3pH91F3V6cBLrI5A6pDwhMLLHMm0Fk6Aj5ij5BhcLxNlxWkq93Rdqk+wMzl20tkXeOZt8OhrhJHaq5LAq37qj/i9LQ2k/FpTjA62Yje2I6SzrrDJEsFGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=df6apRLH; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="df6apRLH"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b062069f80so21390945ad.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774291147; x=1774895947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sy+CDHxlIyZx/+MrAYIXPwoNBrNq+e5Vy6JCRCEF8Rg=;
        b=df6apRLHEBRXZZaR9NhK7lfCfWPDKkvfPYsH1TdK4iULr7YVYKtK9v4fqKQlSUd38C
         mRJXXA3I0gLLykgwcn5FJOmK9X22SgHiCgyIPjt9smUQrhpqau167Sw/24ZyMsHUVR+v
         LOwrIjqNrF6JXxCpagyzRz6X+ToRZyrf45O7AN1JzZfuSRf8jloJr73ZKEDF+MMTBbA2
         4E55WG+m6MU0Mh0vr+SbJv1dCSoJ0Ja0VRiP+7zgZuxbHK2jSPirYfR1c+QQJUe10raH
         cywDk1R0HxaVFVR3Sxmw7vkYVU+ImFBEqqnAaxpvtBgLSUENoT8COK1r5HmfldIv227b
         eEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291147; x=1774895947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sy+CDHxlIyZx/+MrAYIXPwoNBrNq+e5Vy6JCRCEF8Rg=;
        b=KPXpbLmpzUbhSpo+Qc1EYjQdo684OxtgRAC7hUJ8DQEmWfIIiUPm/2DfMwowSyiIju
         XXixWMP5yLLq5JMjR4sHGxu5a3XC8FDCVXsdpFawyc9BnsBNBMnUTs0kCJbs7x5rAUTT
         aSIV6freFi/sqFbDi9TmAq1VwRU1cFyaDxlO+Lq4ruQxdXWLbwrpbEHd4WHV0fJByliW
         9DBUGWV/chNGqt9/gWLI5daADHE8d934KQGYpYPMxWC8V2HxulNK9YjquLfZJtXgbTNA
         aDeaSRlsINCv/w2PDwEcNJNYrS3ihIPN+J1opAbWlzsqLNtHhIRpIyoWvK5iBFYEkSww
         s6Kw==
X-Gm-Message-State: AOJu0YzbqEki4zvAGDwqZZjGmFOYW2UNsFzU9aNbkT2S+bJoXK9qqW6+
	r7e0Ui2y5rnRq1qRYns51sz45wrVBWo8EFU2hEPxXVpS4/9h52awuIFKSsdWIhB9C22qddDdKdx
	mpiJAJsE=
X-Gm-Gg: ATEYQzzOLRvxu5wVIf+0fGOsrSJXfhtvJWuo/VsIesIKrErLO95uBXDcgR5y35/gRvW
	pJbZfVgfSPNHhl7uI5/sJSmqKO6R3OCxc0PDpE0OgSFgt6U6hpjqoUcjF74d/hHERNoQP6qMvek
	ry1o+XZazAp/0hfxWoB2nLSMs5IglFXVMxO8Ipn9Kz1VFrRukz62Xe/R+xQe77ukyDPLa+X4rPq
	Gg/OxXgql9Yk2evV/eZ2NugsX3estBeXEmlOXa5u6sPKYkBT94JNfeQoIkpGBsJHGkb5V7/IsYZ
	3kB1lN0nI+yoqv7LlYzNWpO2WcZQUOFTbOI0RB2Xi1ZyUb8eBVcA6jTWG5ikZgDlJ2Ou5OT3CIn
	XOOmCJtWTw6zAvyE8DPGXDDMsYOpHUBSirELIRH/Yat/xZr3mufYt81SLQ5t4Npdp3JeLSBE643
	gIiqK7i2MXTys=
X-Received: by 2002:a17:903:15c7:b0:2b0:73d2:219e with SMTP id d9443c01a7336-2b08280025bmr116139915ad.47.1774291146948;
        Mon, 23 Mar 2026 11:39:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08366c443sm151792235ad.56.2026.03.23.11.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:39:06 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	leon@kernel.org,
	Joe Damato <joe@dama.to>
Subject: [net-next v5 04/12] net: bnxt: Add a helper for tx_bd_ext
Date: Mon, 23 Mar 2026 11:38:29 -0700
Message-ID: <20260323183844.3146982-5-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260323183844.3146982-1-joe@dama.to>
References: <20260323183844.3146982-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out some code to setup tx_bd_exts into a helper function. This
helper will be used by SW USO implementation in the following commits.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Joe Damato <joe@dama.to>
---
 v4:
   - Added Pavan's Reviewed-by tag. No functional changes.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  9 ++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7793ba59bcfc..4d4e7643f7dd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -663,10 +663,9 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	txbd->tx_bd_opaque = SET_TX_OPAQUE(bp, txr, prod, 2 + last_frag);
 
 	prod = NEXT_TX(prod);
-	txbd1 = (struct tx_bd_ext *)
-		&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	txbd1 = bnxt_init_ext_bd(bp, txr, prod, lflags, vlan_tag_flags,
+				 cfa_action);
 
-	txbd1->tx_bd_hsize_lflags = lflags;
 	if (skb_is_gso(skb)) {
 		bool udp_gso = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4);
 		u32 hdr_len;
@@ -693,7 +692,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		txbd1->tx_bd_hsize_lflags |=
 			cpu_to_le32(TX_BD_FLAGS_TCP_UDP_CHKSUM);
-		txbd1->tx_bd_mss = 0;
 	}
 
 	length >>= 9;
@@ -706,9 +704,6 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	flags |= bnxt_lhint_arr[length];
 	txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
 
-	txbd1->tx_bd_cfa_meta = cpu_to_le32(vlan_tag_flags);
-	txbd1->tx_bd_cfa_action =
-			cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT);
 	txbd0 = txbd;
 	for (i = 0; i < last_frag; i++) {
 		frag = &skb_shinfo(skb)->frags[i];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d82b0899b33d..a6b04652600e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2834,6 +2834,24 @@ static inline u32 bnxt_tx_avail(struct bnxt *bp,
 	return bp->tx_ring_size - (used & bp->tx_ring_mask);
 }
 
+static inline struct tx_bd_ext *
+bnxt_init_ext_bd(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+		 u16 prod, __le32 lflags, u32 vlan_tag_flags,
+		 u32 cfa_action)
+{
+	struct tx_bd_ext *txbd1;
+
+	txbd1 = (struct tx_bd_ext *)
+		&txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	txbd1->tx_bd_hsize_lflags = lflags;
+	txbd1->tx_bd_mss = 0;
+	txbd1->tx_bd_cfa_meta = cpu_to_le32(vlan_tag_flags);
+	txbd1->tx_bd_cfa_action =
+		cpu_to_le32(cfa_action << TX_BD_CFA_ACTION_SHIFT);
+
+	return txbd1;
+}
+
 static inline void bnxt_writeq(struct bnxt *bp, u64 val,
 			       volatile void __iomem *addr)
 {
-- 
2.52.0

