Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5C83E5A0C
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702816; cv=none; b=BFInXEwaJakr+NQPLhEazm7gRa7L0Fp4A1WprjJCYPDxdX1S9emgDiRufEukpdd9Xdq5F6sG51IATwq8Zt7UOCOOohlA/zdBTFDik/qXBzZJsB1x+rIeeDu+9Wgcd6jFaaYtqSYKIKhyZ6UBHf367h/UDEL2prtnB2BSONXw3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702816; c=relaxed/simple;
	bh=WhlzzhRCicb1j2i2d+/jwh7J1No3blieLLU3VJwXzBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhdh+18GOkb+YUGEsEixAf0EYZcC3KIDW/C7zRcnZoCs+RkRaOeVdxhP5xGQx+9Ur2upDi3ubWo7z8hoF2woNhfDqrmhkzTQN5AQt50SgxIffRhir3aA4wmFSBRAYvKWbcD0IzIB+mCZiA0WcUl/RdABR1JzaIJKs7XybsTfr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEDipd0s; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEDipd0s"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc515bef69dso142651a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789702814; x=1790307614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRYy8S+vbAvgrHPn+nros3c78n1/jZJq1PBt4RQ7keo=;
        b=WEDipd0s4qfO+l/qsqaNZakGEUj9Lkeqd5Xs9OKIU4eTSAwNLdbvxw+4YVMUf4P5He
         s/KN4oeRRwXz4VezZrjP7Xf5LR0aV1mHPr6iLvB4yEXPym9wVFYhwo8pnp8pQ+RV8ull
         w9rir8xIsFtgutcpTv7Dd2KSoK2jxX+23jgRIptXKtFFGvMshEbXJtszsuQwocpQ9f9y
         pbwYkvMvq6OTbfFAPpVLCQNTwFDu/Zuhe3KKZnhNNOT3n0CZSgDmrTk23IcEIIqRd1n7
         7InL+RzFk+sKWl9dLq+Mk83aR9gFm//hYZcpejxQrOH7VXmZGSl8qfXPXO8ujv63sSwq
         68ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789702814; x=1790307614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gRYy8S+vbAvgrHPn+nros3c78n1/jZJq1PBt4RQ7keo=;
        b=e25J5AQHUm16Z+84Ys18NeqWZ4kqh2VdyGiBXkshZmAKTq/uRLYgy4I1BXkA6oZEGJ
         37U1MpMPN+VbcvFFxtvzYRViVYyUO96E3c2zs9dqrLsxRmlyNc/sB+M7gsbk+wpOQSk1
         O7O4KYqRrEa8jkGTPgdAqYcK7s5HmPc+8jAEei2QIafv7jsRkg0z32Bbfo5tqaM38IN6
         fNSbyNCEYv2C1S4DKZewts5w2EsK79SF5EVy7sP/OoHAbh5l2TYSGfT31ASeZkFcG52H
         Ra7oTMJ/ors1wZfjABgl1CEr9M9+xDoWt/SH1m2jnIesY2fYv1G6salbwn+uh2vxLaiA
         0rAg==
X-Forwarded-Encrypted: i=1; AKwUvBxzJ9mDDWX4tvmOq5Epoved9v8UWYGiOHEjmVqDikMCvRJy+AiToxikcrMA2WFELqqx1msV76U=@vger.kernel.org
X-Gm-Message-State: AFuF++mfxcnHJT30WgB1Q/HqVqF2jD8eXoxSTLoXYrH7AHCkKPUdS23Q
	6DvKg+6sEaYhRtW8gXXcttyJ3We4lx2J2ui5G2eSu4Tgu/qzYI+IbZCH
X-Gm-Gg: AYBFou24TrLFq5sB40xSWG1tDgswGp1LlzwLHKGA//VlNC5G0BLWrskE9tnU3IQR2QW
	LF1VwdAUphwFIZZMkAo0gRzoIbasn+vqNOtyI5YdD0HbFXdnITrfidrWwaPNRIVTBcQ9eokU2b0
	zgnph6lLe7WazwIl3aWFAk4mombgRrHPkb8jKTyxUpt/hlDK4isw4ATqPrfLdnfoj+jgvqechoo
	iP1UPjVSknUOPCmYMnCdQKAsNigQ13NVJcKt+V2FLdwq0O99PmV0/+jMwvxRTEcwH6S+Bd2Mn9c
	ORkusHxlylCP4pviW2NVhVqyakga9d8yBvq+oxhB0lU/oOBgyTHYW6678BuBtPZXBxWLVD3/PYN
	9a2n8VbtB2MwILC/Nd0d2Rp+EJ05VaHU+hTJIyySIIHII+HU4r6M6tRiQht9+QittJIytvkZP5W
	u67aT9QKIiD9zIHEWQ0qlyX39DIRfKykGUC2RUDGTehPtCEWzDk0clQWPx02OiIlnXoo2+nw3N2
	nIX22Nl7dXDZSCO5r1gLj+bJSRpSieSL3FvavE=
X-Received: by 2002:a17:90b:518c:b0:39e:345b:3335 with SMTP id 98e67ed59e1d1-39e54af367cmr3070690a91.6.1789702813731;
        Thu, 17 Sep 2026 20:40:13 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a1e:2e81:7320:79da:8b9b:16b2:8431])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c284a8a2asm706032eec.1.2026.09.17.20.40.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 20:40:13 -0700 (PDT)
From: Yuchao Zhang <ndaugoing@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuchao Zhang <ndaugoing@gmail.com>
Subject: [PATCH 1/1] wifi: mac80211: drop oversized fragments to avoid extra_len overflow
Date: Fri, 18 Sep 2026 11:40:04 +0800
Message-ID: <20260918034004.85078-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260918034004.85078-1-ndaugoing@gmail.com>
References: <20260918034004.85078-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ieee80211_rx_h_defragment(), fragment payloads are accumulated into
entry->extra_len as subsequent fragments arrive:

        entry->extra_len += rx->skb->len;

When the final fragment arrives, the head fragment is dequeued, and
pskb_expand_head() is called with entry->extra_len to ensure sufficient
tailroom for all queued fragments before copying:

        if (skb_tailroom(rx->skb) < entry->extra_len) {
                if (unlikely(pskb_expand_head(rx->skb, 0, entry->extra_len,
                                              GFP_ATOMIC))) {
                        ...
                }
        }
        while ((skb = __skb_dequeue(&entry->skb_list))) {
                skb_put_data(rx->skb, skb->data, skb->len);
                dev_kfree_skb(skb);
        }

In commit 69f132236827 ("mac80211: shrink struct
ieee80211_fragment_entry"), entry->extra_len was narrowed from unsigned
int to u16 in order to reduce structure memory footprint.

However, an IEEE 802.11 frame sequence can contain up to 16 fragments
(frag numbers 0..15). If a sequence of large fragments arrives (e.g. from
a malicious peer or rogue AP), the sum of fragment lengths can exceed
65535 bytes (for example, 15 fragments of 4400 bytes total 66000 bytes).
Because extra_len is a u16, this addition overflows and wraps around
modulo 65536 (e.g. 66000 wraps to 464).

Consequently, pskb_expand_head() allocates only the truncated amount of
tailroom (or is skipped entirely if the head fragment already has >= 464
bytes of tailroom). When skb_put_data() subsequently iterates through the
queued skb list, it appends the full payload into the undersized buffer,
causing skb_put() to trigger skb_over_panic() and crash the kernel in
softirq context.

A legitimate MSDU in IEEE 802.11 is at most 2304 bytes (or up to 7935/11454
bytes for A-MSDU, which is not fragmented), well below U16_MAX.

Fix this without increasing the size of struct ieee80211_fragment_entry by
checking whether adding the incoming fragment length would exceed U16_MAX.
If so, purge the queued fragments and drop the frame.

Fixes: 69f132236827 ("mac80211: shrink struct ieee80211_fragment_entry")
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
---
 net/mac80211/rx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 5e26be8e27d8..e7292d5febf5 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2499,6 +2499,12 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
 	}
 
 	skb_pull(rx->skb, ieee80211_hdrlen(fc));
+	if (unlikely((u32)entry->extra_len + rx->skb->len > U16_MAX)) {
+		I802_DEBUG_INC(rx->local->rx_handlers_drop_defrag);
+		__skb_queue_purge(&entry->skb_list);
+		return RX_DROP_U_DEFRAG_MISMATCH;
+	}
+
 	__skb_queue_tail(&entry->skb_list, rx->skb);
 	entry->last_frag = frag;
 	entry->extra_len += rx->skb->len;
-- 
2.53.0

