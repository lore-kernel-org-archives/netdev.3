Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492773BCD15
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956599; cv=none; b=YSuTU4ExELytjuSY4tfBP99SCI1PsCfV6JSgPHlpS0Qdja/Zh8g8r21XPXcWfvSkVwgOhhyTMfjC/S07UvgArJ06P7sHwidfMnsAO09XeuraftMmXjUEdsn25qaSdDnYhLUfAlmnc1Ij/rmDdW13aGN1I4turw8vju683aYZJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956599; c=relaxed/simple;
	bh=as2SDlcdmZszLVLpp6U0wTu9/8GUPviDLNz+v3rqc6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QC7juJzb12G9R8DjcGP3pXpeIGa/04sda85i1DPMfWBPhllzG3oHw9HT77sivlyM8NSOTl1zAN3tNhyHTHSKVInQMNg7hhCZ0h2DHp6/PDlYspGgh8PzF+s6gyTaKlNswTfgjErwwX6DU7KsTyTyonCBN104KqErBkuttL3ebrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=BxIpjygb; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="BxIpjygb"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5218927884fso30880041cf.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 01:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786956597; x=1787561397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6lLhWIiCgpmicN480/UwG2uhnEik8ZpJA1z/kNF7n0I=;
        b=BxIpjygbPBsERGuqYa65TdvDLAtwrPMxEugGngYmCrYOzDhdHE1Mcruipw1JP8Clb5
         6liZ75ZtWhzFUW1mHjkiihQnNEb27cQNugUHVO8JoyXEWc6ss20S2LBvGui9TBABY5RB
         jnUIaSOOswXGOACCJyhSl5I3S5J+xlYzG95UyU2f43Cmp4IAUZdv5dfkWqkL5hoNVQfq
         XzkDowMZrDNSEczKjPTxgHY2ItLi1/dtrRs16a5hxoVHk2bOF+V9ZOSobX33rH+yIqDL
         9RMvyHBHzqrHzNpdW/U0QjOddYLYk5So0WezB5jFW2ED/GMpzLuIDAlxoUQaVnxQx0QU
         Xw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786956597; x=1787561397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lLhWIiCgpmicN480/UwG2uhnEik8ZpJA1z/kNF7n0I=;
        b=exUiIX5N7tJJt4a0KcGl37usJslhCmdsxfoGNSLfaW93WhiZtMajM8FNKD8QBwlrJn
         83ZrNm2ZL13RnLzSXghHRsdRYWRvjCEBPKWJjKya1opWePVM7Wr5hG6jgxLjjgnuPUDk
         biZHAMvpo4MY9gkNeb2M586Dn4hMCoa53JjhnOEq3jd6xxfaV+o2V8RS26ZBNb2/p7W4
         ZmqgTeRXMG6Yorzvs8NesklVbs5NVcA74gLK5j+pnIRqi8dGDZOCnJFhm5XmDI3LVjn3
         huaa8APVQJS8sDXlV7PNanCI+E6PhwKwqcE+oeqNi2EYcGdvY5EXgGskv8NGnlk/sSPr
         rNLQ==
X-Forwarded-Encrypted: i=1; AHgh+RpoyEqFzA6nSEDZX3L8DR1/2dJKoL7efCvD3ok15bdzaQKZyu4/hevx07OaKtM8ECV0UYVt3cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmELZ7fwhrIGzUfCNszuaxi2bpULXTKXLTaw3YN2Lavj7LYZmE
	ScFq7zslHpBICMOn3D9WOmm427RTr87JxdLTPmZD0dUhb1XfcjkYqH8Y+ZFR102u0gw=
X-Gm-Gg: AR+sD10gqy50bia7RgRTx2VWHOZrR0m56MQHy6Ue8WvgQpWmB2RMGBK8o1zUGPoS5hP
	1jt9ZtjmRVencYshjOnIzMGyQ6UFqwuXWLCI2d3shH4HUyGsarW8HZcBTEdqAh10Cy4X+M4orVe
	35DwShlAy22j5qg/kN5SMBCqdkITwC2tGenq2ZmzIu7gBUePBDvdwWUgONvsaHA7HahW43PNMrl
	O1aDE5SwQ40nT6+80Mni/5Jfu4BNCW67LQGlew5aEBnXC7dTynTr1j2ibALMRe//0QNO1U2CSrs
	xzGEr3dYTHnUCjFfCifGaRkKFAHU24nHDGbjh7kTj6oeqCm08lkw4mlM6NmyiJQ2tRoNnq8aiCp
	289VfIA4q42e/mZO1lkr/xWspr8E6Vh2mdHpGqVsNpYzhrII4kFt4UA+bE9UwuOsZkP7A+naZez
	/ByW94tJUskfrLRnSC4qtgRzW26LdKikq7hkP7gijTuxtpUEUK6i9Tx7x5+Unc7Y0/CPQ=
X-Received: by 2002:a05:622a:3d4:b0:51b:fb82:67d1 with SMTP id d75a77b69052e-52d8542c8e8mr204942221cf.20.1786956597000;
        Mon, 17 Aug 2026 01:49:57 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-52db60eb85csm9405991cf.4.2026.08.17.01.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 01:49:56 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org
Cc: Kyle Zeng <kylebot@openai.com>,
	davem@davemloft.net,
	linus.luessing@c0d3.blue,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>
Subject: [PATCH net v3] batman-adv: reject unrepresentable multicast TVLV offsets
Date: Mon, 17 Aug 2026 08:49:54 +0000
Message-ID: <20260817084955.944189-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Zeng <kylebot@openai.com>

The network and transport header fields in struct sk_buff are 16-bit
offsets from skb->head, and U16_MAX is reserved as the unset transport
header value. batadv_tvlv_call_handler() sets both fields from a received
multicast TVLV without checking whether the TVLV end is representable.

If the end offset exceeds the field's range, skb_set_transport_header()
truncates it so that the transport header precedes the network header.
The negative difference is then returned by skb_network_header_len() as
a large u32. batadv_mcast_forw_packet() consequently accepts an oversized
multicast tracker and accesses memory beyond the skb data.

Add skb_set_transport_header_careful(), an offset-aware counterpart to
skb_reset_transport_header_careful(), which validates the final
head-relative offset before assigning it. Use the new helper in
batadv_tvlv_call_handler() and reject unrepresentable TVLVs before
setting the network header.

Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
Cc: stable@vger.kernel.org	
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
Changes in v3:
- Rename transport_offset to thoff so the comparisons fit on one line.

v2: https://lore.kernel.org/netdev/20260810145754.828936-1-david.lee@trailofbits.com/

Changes in v2:
- Add an offset-aware careful transport-header setter and make batman-adv
  handle its failure, as suggested by Sven Eckelmann.
- Restore Kyle Zeng as the patch author and correct the sign-off chain.
- Move the research credit below the commit-message separator.

v1: https://lore.kernel.org/all/20260731135222.566367-1-david.lee@trailofbits.com/

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Trail of Bits has a reproducer for this bug that triggers a
KASAN use-after-free and can share if needed.

 include/linux/skbuff.h | 24 ++++++++++++++++++++++++
 net/batman-adv/tvlv.c  |  5 ++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e..ed6a2bc23db5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3126,6 +3126,30 @@ static inline void skb_set_transport_header(struct sk_buff *skb,
 	skb->transport_header += offset;
 }
 
+/**
+ * skb_set_transport_header_careful - conditionally set transport header
+ * @skb: buffer to alter
+ * @offset: offset to add to skb->data
+ *
+ * Hardened version of skb_set_transport_header().
+ *
+ * Returns: true if the operation was a success.
+ */
+static inline bool __must_check
+skb_set_transport_header_careful(struct sk_buff *skb, const int offset)
+{
+	long thoff = skb->data - skb->head + offset;
+
+	if (unlikely(thoff != (typeof(skb->transport_header))thoff))
+		return false;
+
+	if (unlikely(thoff == (typeof(skb->transport_header))~0U))
+		return false;
+
+	skb->transport_header = thoff;
+	return true;
+}
+
 static inline unsigned char *skb_network_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->network_header;
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 1c9fb21985f6..c384db16bcac 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -433,8 +433,11 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 			return NET_RX_SUCCESS;
 
 		tvlv_offset = (unsigned char *)tvlv_value - skb->data;
+		if (!skb_set_transport_header_careful(skb,
+						      tvlv_offset + tvlv_value_len))
+			return -EINVAL;
+
 		skb_set_network_header(skb, tvlv_offset);
-		skb_set_transport_header(skb, tvlv_offset + tvlv_value_len);
 
 		return tvlv_handler->mcast_handler(bat_priv, skb);
 	}
-- 
2.53.0
