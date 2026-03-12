Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00D3B5832
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354919; cv=none; b=CKs7ZAk/rOMUygLLNfc4yB0SdGxvkb8iVTVdgN4as56b80affhtPHVs4XfwzSkOKFvQ+bt7tKV0hg+fWNzBJcbofaN9MURB3FiZFYXCNd9ctGmikum+uZX2EbgH4BzuNkbUYS/EVyDi24BuJtcvgqM6y7hu7romN51X2V+twRp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354919; c=relaxed/simple;
	bh=PuJu+cuvxYyzLYu/heimivKoS0LlknYg8MItINKiTSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CY6rlWN80PhGzU8y8TW8LPMETdqSDSPu5Oq7Z6lPl0g5XDLNieyTq+dQLOZV8mcYYN5Loyqknk6AVDUtMlwDe+xDMANpBFYf54Aip8KsTSDTruuwgP/iRB6FpRD8LTfqBjLzQvzrWsDgbxjWFaXiQjFZkCnhPoHkod8cnpAmBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=JEH9/HFi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="JEH9/HFi"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae4988e039so17774295ad.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1773354914; x=1773959714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhpU0qTAGa7ThLCGsekUFVuiiOUf0jdr/bUs5nRSlS8=;
        b=JEH9/HFipRoY975DSUM3yxuNnuOUBeYc98szNskPCBO9PRL2pwVJNwFAJqA3CudUJR
         UBNnVuolzAClTDrOtrdHtXIpDChUfVNLuiGOSzpMzIEVfoBlhkd+4zdbqZMuq1kXdz6D
         842u68IV+FtyHYMETgWewlvr9UQwR4hcvUONl6wQyY4bF7gps4lpUOFDZjg4W+QAmnUv
         UQGy5Kd5eakJeAgBIOYsJ5SpmlkkrYKZz1TbKbaTM1QuRVGI/qqMjhHWpcWE9hLDYv2Y
         plo7IReDJAX5n+xQ+hS01b1BfqJELAizcBRdaOJwAH6Qw7DYxNOG8yUhTugmwD9rhgqX
         q3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354914; x=1773959714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yhpU0qTAGa7ThLCGsekUFVuiiOUf0jdr/bUs5nRSlS8=;
        b=ksQS6RVLo/TITJA8YVk0yq+KJJihf4+wKukxjMXFABfNZfnh5QnWnY73doTon7MrZh
         E6SvrVLVydOLQ1hCrj20/pak1u1kWH8BxfBCF5HHwyMRVtY+GJagDU4I+l90J4TfI9VI
         K+Fhq3KSq9F8lA4cRUrjDzWIkl/n6w3KKmqVTtCRUmDz3CzLAqQ6JIV7haxsd8P7gxZI
         1y/sQRsx4EYnnonMb6SRXcmrzhWvYKIPbX8GD+e8+LOHTDX9NU29QsMnV52N3iEVyEDz
         58QFvq+v28uIz36MJ5FmTLDG+XIfeF91kp1/aBJs3hRn3sl9D5G6FomW5aL4kz/uJJmy
         qAGw==
X-Gm-Message-State: AOJu0YyeDo53XUE09QtJxJ3PBAuRb0BdUIZlZXNq3h89Ds434vf5Hz1h
	S19zi9a4Sszh9Lm/3UngE9t4IavIxDLZ9YArXLpPfmFLpE+uG3AbVu4eNmtbUqY1iMfwlM7sJPy
	VbDk6AIQ=
X-Gm-Gg: ATEYQzy5nx+7Qf0+j8cRXB80f61sFRxzoLirUlrhFc74F/j2K6FtBxO7OASjgd8dxc3
	V7eL5lKFJv4cpXmIN+20RMXQrUkom38br0C7xyr0kmNbLcoCOauHq9ruE7UdWgUzs92c8Ul7koa
	cHyRhI496c6Z5fvg77wh/nZDmACJvW1FvLY51cntL8boRu68xe+QtR6iNL2MI0AREWJUhS9ozz8
	09SsBb6oFIjfu69o98SZJPKGN1oM66WztUqzbBXh5xg4DsDL1DEz9v8/I2kRkL63algtOL4olYs
	ajRVFg1ONZU9iv0P6x1P//POBsziB8KEH2g1qX0PXhckfHoZYKZevK5kYPQI5giDQxkbKWgqzXP
	fZGrZk0YNAEkQ5xKJU2xaJ/gJSPuzv+x+mYNAwonHiGQDnbbqcY54sbHFEb1uNS7gDyEbGbkvOV
	iMLU26
X-Received: by 2002:a17:902:ec91:b0:2ae:4d6b:b2c7 with SMTP id d9443c01a7336-2aeca50068bmr10458835ad.9.1773354913863;
        Thu, 12 Mar 2026 15:35:13 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece8233e1sm31025ad.71.2026.03.12.15.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:35:13 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Joe Damato <joe@dama.to>
Subject: [RFC net-next v2 04/12] net: bnxt: Add a helper for tx_bd_ext
Date: Thu, 12 Mar 2026 15:34:41 -0700
Message-ID: <20260312223457.1999489-5-joe@dama.to>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260312223457.1999489-1-joe@dama.to>
References: <20260312223457.1999489-1-joe@dama.to>
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
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |  9 ++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c9206977fd54..d12e4fcd5063 100644
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
index 8147f31967b5..a822bbb71146 100644
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

