Received: from mail-lr2-f34.google.com (mail-lr2-f34.google.com [74.125.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD0751EE0F
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793567; cv=none; b=Nh2PZaWowbw4QMQT2VJZmsEOsxuclXQgHhEX95rLYudXjTqsCq3BwnsdQLVvmhGlNDkPE2FJ2CbyrgcBLi1MsiamRpNy7N4ZY0+K0X5yyOyiPvvursa9Ao1jHgAbkpCMENp9VQRv00XvZgUKDech3P96j+SEgK17uEP5CEtYHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793567; c=relaxed/simple;
	bh=GBC8ZKCtDqG4Gr1EhfrzhvBgOdiDn+0K6Z044IsIPy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFP8/CZrKgo64RNKZxVxeeN2UT/TYiJ0LiFw4qOitz2HUYM3p5NiMbOdQN2J/DzFTxKmX98pQzE03qHFr5eHtDdGJ8axWBvUMyDktB6pHqGaZlRw5mJlr8zfTL6t+eYPBZc6ElS5WpRidVk1IQgK0zmAjyNHLHPhGnHMCwt60Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwQ/pFJY; arc=none smtp.client-ip=74.125.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwQ/pFJY"
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a76b373063so15927181fa.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793563; x=1791398363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QVfy1AdzDcEJByj+KtqnfaYXffwilgMQe7jCHgW/ts8=;
        b=CwQ/pFJY4FjBiY8KDxgs9RmznuUzAedePde/oyu2wJl4lrSFOCeUT547ksBis2ID3L
         n9anlM49eeph0xr7mR5BtjtFLZgE1QeCft2AI3apUHJz+J4c2AaNNeDaH/nE1M2rqgg7
         ZQwC8+vXqub5z/dAtw1/NXZ0sQWq+7olD3KP5h5VD9Z4bI34gyWowXevb2Taz0PLcvoW
         PbBwZCBOkYjWp5L/lV5dUVndClPTZmuZZ/4RPrHChxyu3IDsWVVgWfLUkXTi7r5dmKw8
         A0S8EY1i/tUX8o6BZBs2OxFpvvrdJTKp9DK/1d0UlT70GsfnC64PG4tNYOz7Bg2TDFnU
         Y8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793563; x=1791398363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QVfy1AdzDcEJByj+KtqnfaYXffwilgMQe7jCHgW/ts8=;
        b=jY0BqH11HO9dr8zwckNke5T9CdbrJL3PX4Fz7XUjMdXyjJmYz2tsS64qsGYgjBaie3
         KMUu+YsUSr4okEsBVzH4/MsYWANzqkcdcD5IwxqO/srr3JCkI6op695VZ6Q8bBi6I4bF
         jw8hLvj3NJEy1X5r+C+dzzPH3OiYIFnb7+seXnA137/GXvVJI90z+se8DFHYhmlFAdCg
         mY0hmE1dezXWDRDkCwVEH78p3UUZZ1qSzCu6n1xunoT3YZyfTaeH/3fm1apJFR3bcthq
         2ttOQfkrsYvmDf8xJZzGoJQ0cXl8+BsU8yqAOVYythm101sRJiqC0asENfTZ4/FmKmrH
         uxiA==
X-Gm-Message-State: AFq9FYIVPACaLGUPCtVV+oIbsVvsOKFsnnXnJFHZ57wm6wA8k2WQxOu2
	v+6IUbIlVtfcYuXx60jIXEP2FHIPh0ZOZ4/2JZEFsaUlzCvdPCGIbIFLufkLO0Kr
X-Gm-Gg: AYBFou0HtIxX8V3XthkuRCQ0qNysNbOj3DJhPZmOoNgQJ3d5qHItaSQDEH/JIxQODr3
	Z3M0ZMHIay8iwNgtskXvisrlKFw40M/T1G7j2UUsOXn4aAHpUG7ukA/zEOcpRpr/pZltqqW4PDH
	YAT+TiTDEittqxESSGaYIIJ9fKr6NG0Zb+5xwWkMgIvmG0P4IGN0DqxXH/G5nbrPAtoJehVKUrm
	dclMhwOfeEgl5kaddL3IBG5rZx43vDR0U4ZvlDCIjnG9us0vs8zAOO0QXgFY6OKpAITpbEnv7rV
	pZlJlm7sq1o9UCQww7ImVFHZ30RLM5sRZGIEdsyXXHjy+UJliX0gTFN+9sUEkr7V2tnRXGf+sfK
	u521XrPZ744pZBd9K2Q2ZAt4utaZPAX+MsNdSNRNWhFeQ7/ApTvkyYnb2KnBH8NrSwP89grcP8L
	On/k9EATX4R5IAKrYU7ox6sxMr0ru2ubJYTqkjpKbeTwBXy7+6O3v596hKT2TEcWNZ9risfsOYA
	2mqacPahezU+q7xnXak885QGIB2sohTB7W/OjuIiSa6BA==
X-Received: by 2002:a05:6512:31cf:b0:5ba:3c49:6ccf with SMTP id 2adb3069b0e04-5ba402b853bmr933579e87.1.1790793563218;
        Wed, 30 Sep 2026 11:39:23 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.169.181])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba42fbb999sm156593e87.62.2026.09.30.11.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:39:22 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 01/14] vxlan: rename the drop reasons for use by other tunnels
Date: Wed, 30 Sep 2026 21:38:57 +0300
Message-ID: <20260930183910.3151873-2-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
References: <20260930183910.3151873-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VXLAN_INVALID_HDR and VXLAN_VNI_NOT_FOUND describe conditions that are
not specific to vxlan: a malformed tunnel header, and a packet for
which no tunnel device is found. The GRE receive paths converted later
in this series drop packets for the same two conditions.

Rename them to TUNNEL_INVALID_HDR and TUNNEL_NOT_FOUND and reword their
descriptions, the way VXLAN_NO_REMOTE became NO_TX_TARGET in commit
46e0ccfb88f0 ("net: vxlan: rename SKB_DROP_REASON_VXLAN_NO_REMOTE").
The numeric values stay the same; the names that the skb:kfree_skb
tracepoint and drop_monitor report change.

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 drivers/net/vxlan/vxlan_core.c |  8 ++++----
 include/net/dropreason-core.h  | 19 +++++++++++--------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 27b0b6567d52..35a47cc27200 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1700,7 +1700,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	if (!(vh->vx_flags & VXLAN_HF_VNI)) {
 		netdev_dbg(skb->dev, "invalid vxlan flags=%#x vni=%#x\n",
 			   ntohl(vh->vx_flags), ntohl(vh->vx_vni));
-		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
+		reason = SKB_DROP_REASON_TUNNEL_INVALID_HDR;
 		/* Return non vxlan pkt */
 		goto drop;
 	}
@@ -1713,7 +1713,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 
 	vxlan = vxlan_vs_find_vni(vs, skb->dev->ifindex, vni, &vninode);
 	if (!vxlan) {
-		reason = SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND;
+		reason = SKB_DROP_REASON_TUNNEL_NOT_FOUND;
 		goto drop;
 	}
 
@@ -1729,7 +1729,7 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 		 * previous stack code, and also is more robust and provides a
 		 * little more security in adding extensions to VXLAN.
 		 */
-		reason = SKB_DROP_REASON_VXLAN_INVALID_HDR;
+		reason = SKB_DROP_REASON_TUNNEL_INVALID_HDR;
 		DEV_STATS_INC(vxlan->dev, rx_frame_errors);
 		DEV_STATS_INC(vxlan->dev, rx_errors);
 		vxlan_vnifilter_count(vxlan, cfg, vni, vninode,
@@ -2389,7 +2389,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, cfg, vni, NULL,
 					      VXLAN_VNI_STATS_TX_ERRORS, 0);
-			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND);
+			kfree_skb_reason(skb, SKB_DROP_REASON_TUNNEL_NOT_FOUND);
 
 			return -ENOENT;
 		}
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 12f909651591..40a27d8887af 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -111,8 +111,8 @@
 	FN(PACKET_SOCK_ERROR)		\
 	FN(TC_CHAIN_NOTFOUND)		\
 	FN(TC_RECLASSIFY_LOOP)		\
-	FN(VXLAN_INVALID_HDR)		\
-	FN(VXLAN_VNI_NOT_FOUND)		\
+	FN(TUNNEL_INVALID_HDR)		\
+	FN(TUNNEL_NOT_FOUND)		\
 	FN(MAC_INVALID_SOURCE)		\
 	FN(VXLAN_ENTRY_EXISTS)		\
 	FN(NO_TX_TARGET)		\
@@ -539,13 +539,16 @@ enum skb_drop_reason {
 	 */
 	SKB_DROP_REASON_TC_RECLASSIFY_LOOP,
 	/**
-	 * @SKB_DROP_REASON_VXLAN_INVALID_HDR: VXLAN header is invalid. E.g.:
-	 * 1) reserved fields are not zero
-	 * 2) "I" flag is not set
+	 * @SKB_DROP_REASON_TUNNEL_INVALID_HDR: tunnel header is invalid. E.g.:
+	 * 1) VXLAN reserved fields are not zero
+	 * 2) VXLAN "I" flag is not set
 	 */
-	SKB_DROP_REASON_VXLAN_INVALID_HDR,
-	/** @SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND: no VXLAN device found for VNI */
-	SKB_DROP_REASON_VXLAN_VNI_NOT_FOUND,
+	SKB_DROP_REASON_TUNNEL_INVALID_HDR,
+	/**
+	 * @SKB_DROP_REASON_TUNNEL_NOT_FOUND: no tunnel device found for the
+	 * packet, e.g. no VXLAN device for its VNI
+	 */
+	SKB_DROP_REASON_TUNNEL_NOT_FOUND,
 	/** @SKB_DROP_REASON_MAC_INVALID_SOURCE: source mac is invalid */
 	SKB_DROP_REASON_MAC_INVALID_SOURCE,
 	/**
-- 
2.47.3

