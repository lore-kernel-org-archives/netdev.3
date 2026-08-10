Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56715412BF1
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373879; cv=none; b=Cq5eNq/iSkhMQkCIRDaxL47f91lQ0HKUkwEtorunYWXwKR3297d2tY33++kakjtBUCLeldoFhTjHrrF3bQ7441K4RC7A48ws2+KqrfYDAAZyS72/9dFwX9MvufvaQQPPez0fKErNARc8wQwI6ucn07f7uk22cGRTKjYw474P3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373879; c=relaxed/simple;
	bh=hnhgbnBFVXGlRf8QMp2yxUOZygghKd++lPr/wVO57Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0OiCyr0/4awtQxsb5rr/apZc73LeRFG3LP9MeYV4ZSuE6kqJfXZTw4Tq+A0PshekKLc2sBazXn82WYgA5r6wfG4Nf+fTgTk2Af+srgdRqVOBt70oJObD8IMBg0G0vfml/3752hKGuWhotvSKPQlICQ392UKg+26SRA+aOQTUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=S4wsdsMG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="S4wsdsMG"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92ed3993c1eso94319285a.1
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1786373876; x=1786978676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j0rB9Jjig8cN4sfHOy8svv9C8RxGQPDOIghXLCybeaw=;
        b=S4wsdsMGG3xUg3nVZ9caWjQzZe0VFSjo7SEAlanZEcO0b2Npfj2eas/L+WIz/soz9b
         DTmVDQlujclnbubu9GhF7399UIYfOgbrbUxdBG41LBAXVHXALGILfqYA3n7SHmhSzcGg
         rfvZjcLq3I17mGQpvOUDxl72qHAMAsDurfOy9fKiivGtnU48TNHXKLNMjvmLzfC5IKT9
         Zct3ImOecGv3cdZJDjkEfsglNP3bTlBQkwDK2IZp3hYiBA/azzVol+ooRcCp9lR8F1C3
         16zPsQLlHqlpjNxhNJJEFxv8a22OEBRaVP0sW4RX7BOc/qkEZpc2ufM2xU8eqeiYkUgu
         xEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373876; x=1786978676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j0rB9Jjig8cN4sfHOy8svv9C8RxGQPDOIghXLCybeaw=;
        b=NLl8vvUYvnXGKEd1xk+W26c1k2OPBQFr+mrAkV1sEm/swghMan5tZ/wv8YPoGqlsPW
         d+PANj4gcHINWctHflWXGa/JCK+tBa49dh2m+1OVO6r7+6Q2G9svf5KjAHaGu2gqJmWD
         /q75lz6uL+08ikazwNNhB8DEuEg4VgbY5tJOt7MNbVe1CCqfGj6LmT3oDitCkd3nPX63
         qb88O4qPMg+KtoeXiK55IIWz5ywdycEq7LRluFzfesCC4yoerXNravmQjhn2q5+1Wz5j
         pOGyvJztbm1qMRBFEyczcJrLiqXkCx2x3v8BiiPjiD/pzJyY5FXlgitQ2XftImpBIxhE
         DFtQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyEn23hPFAHTUP4aO1AOYkba8XQO8EBC51xqvcNARLpVQCFmRGiX+ToIKoyL002LpaulF0wfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN4U2Ypy1M4IJWo1tKkJT1fiU16Tux2vHGgZo+lLc82WfV/e0Q
	ByPtYGPcgOzMtjhZ/RPT2/5hVvM3A/2y9BSwAqeidzVk8LsYjIBbuLaecSqYk34EiA4=
X-Gm-Gg: AR+sD12/nEHArY1myiHCE0LLdwEgcvrdgbqFqj04y9/3K0/+4lHS3EtrgdbVo4T0xEM
	f+8pePKDQjNMnkO7mcmbLJSEERNU+5KYIbr6LWp1RICMC8jvDCPJxKBPi+3HFW6gsx0DmMITYc8
	XS6QwONBueUSvBNne/ifOcYqM0ojEh8cseBDdTyhHXfhTXCLzL8bhVB4OHf+Km5WlaH2VMyGuZ/
	sv3X0cjuULqC50rZjixfilHqooL4Lxu/n9uw3FZQ5e01GKayoBbL9k7BIAEThMvVm8glrvmP7F4
	Tw2ea0TKyOEIjJk4FFuo4EetV4V/Gm5t+nuMqL5hNGTiPhJ2+rJA16sH7PKUu/2ESV2Tb0R47eh
	2c3MsCasaUY4y+bvXV575zU7TXQ98xE8dybkSuBTK3flrAaNZdKgAtLKL8Ha8SzXZLp9XPxTuAy
	KyCRMqwiHO8tgMc2gGiLgcGzcCKu+oOLsDpHegx5Xr1zNocKO8fz3DSkOtuOWrmoGiHg==
X-Received: by 2002:a05:620a:40ca:b0:936:4955:e5ef with SMTP id af79cd13be357-93671eae246mr2247821285a.22.1786373876052;
        Mon, 10 Aug 2026 07:57:56 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-9366e2294a0sm809249685a.27.2026.08.10.07.57.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 07:57:55 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org
Cc: Kyle Zeng <kylebot@openai.com>,
	davem@davemloft.net,
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
Subject: [PATCH net v2] batman-adv: reject unrepresentable multicast TVLV offsets
Date: Mon, 10 Aug 2026 14:57:51 +0000
Message-ID: <20260810145754.828936-1-david.lee@trailofbits.com>
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
Suggested-by: Sven Eckelmann <sven@narfation.org>
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
---
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

 include/linux/skbuff.h | 26 ++++++++++++++++++++++++++
 net/batman-adv/tvlv.c  |  5 ++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e..dbeceaf5c3b3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3126,6 +3126,32 @@ static inline void skb_set_transport_header(struct sk_buff *skb,
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
+	long transport_offset = skb->data - skb->head + offset;
+
+	if (unlikely(transport_offset !=
+		     (typeof(skb->transport_header))transport_offset))
+		return false;
+
+	if (unlikely(transport_offset ==
+		     (typeof(skb->transport_header))~0U))
+		return false;
+
+	skb->transport_header = transport_offset;
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
