Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13B1F63D9
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787091347; cv=none; b=XfkcJvEFufTAg1qu98xWBvDX1FM0LhshausFpI+8qOM8ca2Ng3YHQMc81plIsttJ0OOUmo3Txp00e3FXdAZ7OIkG4+eYKpZhj4w5SQlzDVn/ZM4DFVsIh+Ng2NPAlfH0CZV8G62WToB1vpb9L7Q7w1OKySe0C5RfOYBQsNcN8Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787091347; c=relaxed/simple;
	bh=dWqEdlMOvfDAahIlhYX2TCEpWuCGjP3Ra2LKtaKwRjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tauSJGBclLb3FKImxTN61ZEh6npZ+h+5gF33eBTlB7oG7PoJNGCr2uOSqMvwcc9xFa0y50SjYW1GKWuC1ZX2wDoAhfhE7WeSTOyXfud/gCD9Ut1rbL7uSQOOMtXLMHwYYh7hK7zu+y0G6JCeUHB/89ro92SoDv4p/03cYOL5IsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbNH/Gbj; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbNH/Gbj"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso216878a12.1
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 15:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787091346; x=1787696146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bMc/RV8+QamD995c7SJc+0xKaf5peRvcqbfVUWFdgW4=;
        b=HbNH/Gbj19/920POKG/OzRzdrIsFVupTTzZo+tZeYJ03BbaarTBLx4uO7rKf3/Lqgc
         9GRP7atgfCITxVr44MbP/mYdJSg4VoMSvOQ4NHrkQaRoOeqL5UI127lfpMp2mWs5ge+U
         MTHSh11ctiWd58n4IH00/ufHn2rJI1UheGGIOFkb630hLmKwsJsncgJTi/2dD5/urtuB
         prnus2+xqRtel+uIDbArJj4ZzaArC+GuNzcK9mLSionHCtLS0m4hX31ZVYf+McAkUfXs
         ckQraZBDswoYQc9lWqeQMVLLBsGkdY6LEuuWqa17aKPuPvQDfXyd9Mj4KxDPZ3yEyc5A
         S/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787091346; x=1787696146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMc/RV8+QamD995c7SJc+0xKaf5peRvcqbfVUWFdgW4=;
        b=FGM8FRdvnAykwbC6ET1zrwYqrb7AACKF3Gi2cfOSDW/IFOpR79HsuV2rDOf3hPmlUj
         zYDccWflmPTfIweaoatH/lKmQJVzyRY51Et0a3X5D46YokWk8E1v0LYIMzg7Wubd2jGl
         kSkKSkrPbYGtKqoP7fIB6M/pGpvgIzstgMQkX1OMRcGFLD5MvNUtnRVmjRcJTxV1FvS2
         I08zjXhafJjgVjJ0x3i4fJmhxSNHHuFWhSL1YjViFm/LTT576TVqexKQOIlJ4EbIOqqQ
         iS5VhgbMaj5pw317pNUjGrslIbLRDgJhSyyEtXVHJ7zHHApyPt9fvUDHQcfD9TvCvLg4
         oukg==
X-Gm-Message-State: AOJu0Yxp1kR2KQkt2hrs1p/kpa7TgjM3NzEYf+jtKK5JREoov4OEGx07
	huij87V+R4d8R5o1cWQ3Yc6UocNOq7cjdvJ722RW/9VoNcyRUGRheqY3h8uLUKxhkO8V/Q==
X-Gm-Gg: AR+sD128VCEEuSKohDWTBDil2duWKTAlBxXX6IETW5Rij5Gm8dr4Nhgzg3MyqS9W8/S
	TXnl+1FijMtc+dCzSTQ4bfirXw/XWlFIL0Ur7+hzGAvydwmHY1msg5XikeRCv987SDwuWO8yFwK
	gjNG/jrGfzyc4nZmcRvJcjixlvqWyJuiI4U5+qGHEpkImJU9vjg0YyVSx8F49pP+RMsjBdoHE1A
	rHNcLy/0hXX3Ph634ak11V9gFxTC7URpoJC+88UOJ90ekwlNS/aqKBorCcq62m/xT1fcKIIB/Az
	VYgQOrkUf3DKZlzLNSdRuXNBFM48dr3bnskrqIL4A3YTopvhKfO8C1O6x9hnjv6PfloE4AzEAHV
	37u3DDoZAC89Vi/4yHJmi9qROslC3T3/Tgc31n6WPhU3NLxmRAOscHe9Ks4lN97do/V+iMYqUxS
	Ejz8rqyZH9mYZSOJWlqBlRlg+lD5YQdt7s4bCOv8LEKNNoEidBEtSpL1z03MW38ViOYExut8w6f
	itjwRMrSC0rCvGwn8uEU/xfu6c2KJeGqzAILAcXxw==
X-Received: by 2002:a05:6a20:e212:b0:3c3:9993:d5c3 with SMTP id adf61e73a8af0-3cd0113f017mr558202637.9.1787091345774;
        Tue, 18 Aug 2026 15:15:45 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf10d497sm223707eec.14.2026.08.18.15.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 15:15:44 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH net] net/sched: act_skbmod: Fix headroom COW leading to page cache corruption
Date: Wed, 19 Aug 2026 03:15:17 +0500
Message-ID: <20260818221519.75088-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_skbmod_act() calls skb_ensure_writable(skb, max_edit_len) to ensure
the modified packet header is writable before rewriting Ethernet addresses
or setting ECN bits.

However, skb_ensure_writable() only pulls and COWs memory starting from
skb->data onwards. At ingress or on forwarded packets, the Ethernet
header (or network header) may reside in the headroom at a negative
offset (skb_mac_offset(skb) < 0).

Because skb_cow() is omitted for negative offsets, writes via
ether_addr_copy() or INET_ECN_set_ce() modify shared headroom in-place
on cloned SKBs (e.g., cloned by tc mirred, bpf_clone_redirect, or
packet capture sockets). This can result in silent packet corruption
and page cache corruption.

Fix this by ensuring that if the target header starts at a negative
offset in the headroom, skb_cow(skb, -offset) is called to unshare the
headroom before ensuring writability across the header span.

Fixes: 86da71b57383 ("net_sched: Introduce skbmod action")
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/sched/act_skbmod.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/sched/act_skbmod.c b/net/sched/act_skbmod.c
index a8e2b83ebae5..cd2a6e974e6f 100644
--- a/net/sched/act_skbmod.c
+++ b/net/sched/act_skbmod.c
@@ -22,13 +22,24 @@
 
 static struct tc_action_ops act_skbmod_ops;
 
+static int skbmod_ensure_writable(struct sk_buff *skb, int offset, int len)
+{
+	if (offset < 0) {
+		if (skb_cow(skb, -offset))
+			return -ENOMEM;
+		if (offset + len > 0)
+			return skb_ensure_writable(skb, offset + len);
+		return 0;
+	}
+	return skb_ensure_writable(skb, offset + len);
+}
+
 TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 				     const struct tc_action *a,
 				     struct tcf_result *res)
 {
 	struct tcf_skbmod *d = to_skbmod(a);
 	struct tcf_skbmod_params *p;
-	int max_edit_len, err;
 	u64 flags;
 
 	tcf_lastuse_update(&d->tcf_tm);
@@ -38,7 +49,6 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 	if (unlikely(p->action == TC_ACT_SHOT))
 		goto drop;
 
-	max_edit_len = skb_mac_header_len(skb);
 	flags = p->flags;
 
 	/* tcf_skbmod_init() guarantees "flags" to be one of the following:
@@ -52,19 +62,20 @@ TC_INDIRECT_SCOPE int tcf_skbmod_act(struct sk_buff *skb,
 		switch (skb_protocol(skb, true)) {
 		case cpu_to_be16(ETH_P_IP):
 		case cpu_to_be16(ETH_P_IPV6):
-			max_edit_len += skb_network_header_len(skb);
+			if (skbmod_ensure_writable(skb, skb_network_offset(skb),
+						   skb_network_header_len(skb)))
+				goto drop;
 			break;
 		default:
 			goto out;
 		}
-	} else if (!skb->dev || skb->dev->type != ARPHRD_ETHER) {
-		goto out;
-	}
-
-	err = skb_ensure_writable(skb, max_edit_len);
-	if (unlikely(err)) /* best policy is to drop on the floor */
-		goto drop;
+	} else {
+		if (!skb->dev || skb->dev->type != ARPHRD_ETHER)
+			goto out;
 
+		if (skbmod_ensure_writable(skb, skb_mac_offset(skb), ETH_HLEN))
+			goto drop;
+	}
 	if (flags & SKBMOD_F_DMAC)
 		ether_addr_copy(eth_hdr(skb)->h_dest, p->eth_dst);
 	if (flags & SKBMOD_F_SMAC)
-- 
2.43.0
