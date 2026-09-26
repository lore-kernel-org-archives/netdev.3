Received: from mail-qv2-f43.google.com (mail-qv2-f43.google.com [74.125.230.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC003822B4
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447015; cv=none; b=ROVT+awq6x44neTd9gSlN09V3bmH7vdwU7JzyihhhjFJx8bz6hv/e4Qf9mUDoCDDKQpnIilmQHBNPPkxcdlWXCMEzZvDeWo8uypcByA+oiXDrCp3vuNtg+qD36nQLkLEOkxaazzFz4g7Os/YYH8K6a45PeVkVdOMyriEY4m6nlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447015; c=relaxed/simple;
	bh=YXcKeAABVopox1ms0yXcGp3yED3zJqToRnnpfv/dnGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXF9LORv7DfhdJzRYHdv1ji4dYO5orhddsdL91fcWEcWynlcZOzl0yQZcQNBseO/9fWY7w3N/xRHYHnFtL2Ogfrs/jVdwAgv6OOAW3xY0204SF6OZKfNg5GPJykA4AAuHjAMe6YBRXdfs9kui9IDJbmri+K/YFDNbBEkcDTdGpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=EiqbW7Pu; arc=none smtp.client-ip=74.125.230.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="EiqbW7Pu"
Received: by mail-qv2-f43.google.com with SMTP id 6a1803df08f44-9142a19ebedso23057526d6.3
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790447012; x=1791051812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZNWJ/PVqA7Unu2QlmPXwBTiLGNdMXmik3KB4LNGEMU=;
        b=EiqbW7PuZczse756wfhM2SrbYeOre4hQf08YTzOOHT26Ud1GxwvP8NE6nGupth36Dl
         pjFf84LMWdrRNvVOoofA/R6utfCzXke0f+qJotK6poizYCYadmp9OZvWctGQHZ7zZb+Y
         eUpBWozGAKdTTAx/6E6XUcSJ7472PADF7nDjShyLr+bUtyDT8aUBLta4UMDwcU9609e5
         l8x/PDlHxx22ALqYfM+pztD93u6WRKRD8fkmQZHfRDMXKlOOL5dIfABBeVkZhQJ1Fyas
         4CG2CKzg2zS1jMKDKxfwi8eOQp05yGKL5wfxEixyKd16//DyL+wVWj6aCttDCU/aez+D
         HlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790447012; x=1791051812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ZNWJ/PVqA7Unu2QlmPXwBTiLGNdMXmik3KB4LNGEMU=;
        b=g0O+GCFluqyXag/s2BkUPGGt7Pm9TcsizaOgjzI5/fTudQsokBgiGMUxa0jY4SPw9q
         kKKUj6JRtssPxgAeWuWWiZ34PjIOXAbdzJR+WBQzQbiqDD0CQhWOotYMByBLRHLYeYsS
         jN/ICK/PEz7kIHOlH+nsV0c9nf/kDQnALoYQhuIuSKL1CRVwxGskNMQDAF8vYREocJ7u
         SOy+kXuydDF1QmPdk1AMC6Z1ZNW2XJ1iH0R9KCPEPKGrLd/blOTu6aBD2K+l5iKFT4ZI
         bXmuyfSO4JE595ZBS/06T/b8+CDe1bV7epeZrury8KU59XGFgoY7lTf/MBAEkCDJx6O0
         ESMw==
X-Gm-Message-State: AFuF++kZ90ASTgbZ6zTZwCRjeBuAKXm05VKitngHkDZtPL81e2j234wC
	nh8zTybaO1grBfIJxrJyGcNXjSwLUncb6T4rtE07bGyEC+jeEP7Tefz8KkWbMXKWOo5A21iF5+5
	468Mc2aXw
X-Gm-Gg: AYBFou1h4cjP40h1BCKjtcn1jFWiDIwEuYsQcJxEzU25k4tkN/u2FtQ/zkyPiKrd0lX
	2SO3XnOqRbuB1j/cbJ9OofAIX3/EEKppTJVKWyQVzqYqSaqOGrGdrBZw/7ThdBeBH0UY+ooQZS5
	9ndQkpnZi7urBHDtfEhH0auwmNsCFu2cfY48Yqm3MApDzH43WV0BRJPwNFLYZ4nZKkb6waQEx7g
	vYVa7HC4PKCKzxS3vpdC8djjD1+LeFOtHUsggkiYsm3I+zSib0GE+yBfRt8oVML3Gd96i/JRs08
	FN/SpYVT93rxIgofBoyhhgD6AnsBgfzEXvl+SnhUZzf0xpKytJ6ZFSJsitAlN8diZR7TxzelUGY
	S/LzIFF5PGQv2DyUNYSnMs38yWCu7QAdsMDEvNH2WOS0ByxDfHYzxE1OYxnSR19W4C+MW5lRQjr
	VLa2DMXEKklhVq0qQD50lya0KHT83gutn7ynEgf04PuZPwi0NvafhYHbDjw0wdBXaqtoYeHcX75
	ZLxRJdj5+pNoUeE4A==
X-Received: by 2002:a05:6214:590f:b0:914:2c1b:7d29 with SMTP id 6a1803df08f44-91441fdca4fmr70787736d6.6.1790447011987;
        Sat, 26 Sep 2026 11:23:31 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([202.8.105.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430ec87e3sm43970006d6.47.2026.09.26.11.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 11:23:31 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	lucien.xin@gmail.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jbrandeb@kernel.org,
	sln@onemain.com,
	fw@strlen.de,
	petalzu987@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v1 1/2] ipv6: reject truncated extension headers in ipv6_skip_exthdr()
Date: Sun, 27 Sep 2026 02:23:08 +0800
Message-ID: <f9abb4c3ba2b50f982ddca240012f8a782c9958e.1790082243.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790082243.git.petalzu987@gmail.com>
References: <cover.1790082243.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zixuan Chai <petalzu987@gmail.com>

ipv6_skip_exthdr() derives the length of each extension header from packet
data. When the packet ends before the declared length, it currently
advances the offset past the end of the skb and reports a successful
parse.

Check the remaining skb length before advancing over an extension header.
Handle the resulting -1 in the consumers that use the offset or classify
the first fragment: reject malformed first fragments during IPv6
reassembly, including conntrack reassembly; suppress ICMPv6 replies; and
abort XFRM BEET GSO before updating the transport offset.

Update the helper comment to describe the -1 failure result.

Fixes: 25a44ae93d1a ("esp6: support ipv6 nexthdrs process for beet gso segment")
Fixes: 6f297068a069 ("esp4: support ipv6 nexthdrs process for beet gso segment")
Cc: stable@vger.kernel.org
Reported-by: Florian Westphal <fw@strlen.de>
Closes: https://lore.kernel.org/netfilter-devel/aq1HaYS96SNn7HJY@strlen.de/
Assisted-by: LLM
Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 include/net/ipv6_frag.h |  4 +++-
 net/ipv4/esp4_offload.c |  8 ++++++--
 net/ipv6/esp6_offload.c |  8 ++++++--
 net/ipv6/exthdrs_core.c | 14 +++++++-------
 net/ipv6/icmp.c         |  2 +-
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/include/net/ipv6_frag.h b/include/net/ipv6_frag.h
index 41d9fc6965f9..5616f6e7428d 100644
--- a/include/net/ipv6_frag.h
+++ b/include/net/ipv6_frag.h
@@ -125,7 +125,9 @@ ipv6frag_thdr_truncated(struct sk_buff *skb, int start, u8 *nexthdrp)
 	int offset;
 
 	offset = ipv6_skip_exthdr(skb, start, &nexthdr, &frag_off);
-	if (offset < 0 || (frag_off & htons(IP6_OFFSET)))
+	if (offset < 0)
+		return true;
+	if (frag_off & htons(IP6_OFFSET))
 		return false;
 	switch (nexthdr) {
 	case NEXTHDR_TCP:
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd77162f5e7..a29e79a8b924 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -168,10 +168,14 @@ static struct sk_buff *xfrm4_beet_gso_segment(struct xfrm_state *x,
 			skb->transport_header -= IPV4_BEET_PHMAXLEN;
 		}
 	} else {
 		__be16 frag;
+		int offset;
 
-		skb->transport_header +=
-			ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		offset = ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		if (offset < 0)
+			return ERR_PTR(-EINVAL);
+
+		skb->transport_header += offset;
 		if (proto == IPPROTO_TCP)
 			skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
 	}
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 22895521a57d..2fbf6f567a50 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -210,10 +210,14 @@ static struct sk_buff *xfrm6_beet_gso_segment(struct xfrm_state *x,
 		if (proto == IPPROTO_TCP)
 			skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV6;
 	} else {
 		__be16 frag;
+		int offset;
 
-		skb->transport_header +=
-			ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		offset = ipv6_skip_exthdr(skb, 0, &proto, &frag);
+		if (offset < 0)
+			return ERR_PTR(-EINVAL);
+
+		skb->transport_header += offset;
 	}
 
 	if (proto == IPPROTO_IPIP)
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 4a9748338cf4..60e20036c1bd 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -48,15 +48,12 @@ EXPORT_SYMBOL(ipv6_ext_hdr);
  * "nexthdrp" initially points to some place,
  * where type of the first header can be found.
  *
- * It skips all well-known exthdrs, and returns pointer to the start
- * of unparsable area i.e. the first header with unknown type.
+ * It skips all well-known exthdrs, and returns the offset of the start
+ * of the first header with an unknown type.
  * If it is not NULL *nexthdr is updated by type/protocol of this header.
  *
- * NOTES: - if packet terminated with NEXTHDR_NONE it returns NULL.
- *        - it may return pointer pointing beyond end of packet,
- *	    if the last recognized header is truncated in the middle.
- *        - if packet is truncated, so that all parsed headers are skipped,
- *	    it returns NULL.
+ * NOTES: - if packet terminates with NEXTHDR_NONE or is truncated while
+ *          skipping extension headers, it returns -1.
  *	  - First fragment header is skipped, not-first ones
  *	    are considered as unparsable.
  *	  - Reports the offset field of the final fragment header so it is
@@ -107,6 +104,9 @@ int ipv6_skip_exthdr(const struct sk_buff *skb, int start, u8 *nexthdrp,
 		else
 			hdrlen = ipv6_optlen(hp);
 
+		if (skb->len - start < hdrlen)
+			return -1;
+
 		nexthdr = hp->nexthdr;
 		start += hdrlen;
 	}
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index a95b0351824f..8896ac90343e 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -145,7 +145,7 @@ static bool is_ineligible(const struct sk_buff *skb)
 
 	ptr = ipv6_skip_exthdr(skb, ptr, &nexthdr, &frag_off);
 	if (ptr < 0)
-		return false;
+		return true;
 	if (nexthdr == IPPROTO_ICMPV6) {
 		u8 _type, *tp;
 		tp = skb_header_pointer(skb,
-- 
2.34.1
