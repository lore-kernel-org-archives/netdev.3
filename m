Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1C3A168B
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790456896; cv=none; b=rnhgGfGlubgGPd0IHeEO7UJHwYnk/vK7k42S9Kiog9YOby+R4XQE9rCnt4G35CACZD8N6XWvoyK/eBRBSSAiRp+1o+MXNkrNyn/K75jrVTym8LwXJXKTqI6JfFEDI1VSiUlU/npLUkB2k4jiZsYUrS8eg5FUbF5w1YwVtc+ycVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790456896; c=relaxed/simple;
	bh=JeKRfAmmE91MxprxdKAsQfplBSI9p7Xp46i94pnx2xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFd4gEDpzmDsbP2xZUqTsP8/8avi8lZP+ORIiKD3lEXxdm3tyfwOqUXl5223lBZqax/r4j/9wIyXV3R7aF0a1G/IOJAgfcEQZj36mRyECiUmuj9FvDhiydN0l6SwpafLcc1neZdS11EsjxAACgkBMNF+fSUrZtQnMPZrVK0X3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC8J7uQ3; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC8J7uQ3"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341fe27b718so1784115eec.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 14:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790456894; x=1791061694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5jLr1UOPOpYPQnBcdUz4e44kGyYHeunrc1rNWkKIT5Y=;
        b=MC8J7uQ3anLgyydiRrT6l0dvQ1rJ8ok9HMsvX5p4QF3Ije1fNmk64RLyiJwc5aX9OA
         w95IGFGI/clqXyLduukwYkzTezDtc4JNq+/S0aJ0X0BmNAcmCiE20Z2APu0Wc/NeNy2s
         sJJTthDMPWXPSASE8XHndeYpSUNWb4LnQmU0TKwvL5Re4NZa6kPTeG+cJUoaGUn7DX37
         9MKhAr9mI0gzNsD1zuy7TNP3ZbkIbdQZfEmd689NVFQ9EVCY52MyyLCJQHpYYGxGTniq
         qtf78Wg4XvvEfG7w7j80/wzNkRXbln5HrKRshlq2mIp6dt7Q10fuma2H3UiImDls3KYd
         jXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790456894; x=1791061694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5jLr1UOPOpYPQnBcdUz4e44kGyYHeunrc1rNWkKIT5Y=;
        b=ek4/6uyDfDxKC+CidrtoVPHrcmugrYsFRxVq4C7q8Igrkf5GnVrrNKiw1mxWZswCfG
         MtPG8xi+o9fwjhzrs1utBPCojYf4YhkgoPWv0ERjWxkuM0KcmQPX5yJbwOwvN0rFycd2
         1Ye/K/CQPBjTutOyFNeSvINrJNduD+xbklQWrDO28DAr8GeFj0dS3iKwuMN777sPfGB3
         jpRdIrihskgUbgsrO/bk9t7IZQ4xNs10azSRo+tyUGFzjUKaiyeUOMtavO6FxCtVZutC
         7SOPyQNpXHknRybDgGUiOFzefQnqg/m0OrFym4qt4tWlz3+peobS57VqHMpkNJVCq+Rq
         RyJA==
X-Forwarded-Encrypted: i=1; AKwUvBw8xM9n0dWytq0Mt83pDAt4k7KQFT1zgVx3yIL1VT3CrWFVu5LJZydE3GKZErQMT6iP0V9rYuo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdnGNIkhaTbvrKrp9KEC+3/vePan2qY638I7AGmVrBJnwcgO7H
	LX00AHRWXhr70sPe7MScQeLBHcV2m8c/FtNmAlilChG5UMOTBdkIKIC+
X-Gm-Gg: AYBFou3/1goiiZEsad3cN+K2zq5GJqA82Mhk02I9hao/ki91oUXfWan+YDpe0m5peD9
	oBtkagz3EvcHiipL2xiGb2fOHQs7hZMPYzude9DpZ9U6fwl3wiMp7KTn0kXGVnhJ+hmN5d8+NEG
	LuVnSKn7kmOUmnm0k97/orvYRyR8lnyKniNuqUa+G+NJwod1fs4ckmQ9KaAupreyPVhLWkPvEaW
	6jBzqmmKCroZ4BAW7wwf7gIppEIq9/wO/g0aPDKiGtSjGShCakdS+HzA9+aoWOjaFoC+QdkU5gX
	wUuViLaAZQsA/y4ZmqNpLKi8R0v6a1wh8vmeacWKLzwggQ5mSGzXdI4z+6Fzl9w1153WX2ckin/
	BNQZ8XiCsC3kmbhK4rh3aGvlRK9fgr4uVEjuB4FtuSFIf+rgcwNz7bXWbeBu6wIch9Im9/QUeVy
	ppmNrYu4r+RmExag5Y9OpnfBH4VA7zYDsPtvjLGC9+UgNA6jdsn7V3M26ezKvkgrThc+gYExB0t
	1/8DwvlUBiSySrNnzR+yusBIfFCMjPk
X-Received: by 2002:a05:7301:b0f:b0:342:451b:c0cc with SMTP id 5a478bee46e88-3426fbbef10mr4318105eec.6.1790456893721;
        Sat, 26 Sep 2026 14:08:13 -0700 (PDT)
Received: from build2026.lan (67.230.168.206.16clouds.com. [67.230.168.206])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145d0fc9fsm17886648eec.25.2026.09.26.14.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:08:10 -0700 (PDT)
From: ThisSeanZhang <thisseanzhang@gmail.com>
To: bpf@vger.kernel.org
Cc: ThisSeanZhang <thisseanzhang@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	netdev@vger.kernel.org,
	Nick Hudson <nhudson@akamai.com>,
	Felix Fietkau <nbd@openwrt.org>,
	Qingfang Deng <dqfext@gmail.com>
Subject: [RFC bpf-next 1/3] bpf: Add PPPoE encap support to bpf_skb_adjust_room
Date: Sat, 26 Sep 2026 17:07:55 -0400
Message-ID: <20260926210757.2152159-2-thisseanzhang@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260926210757.2152159-1-thisseanzhang@gmail.com>
References: <20260926210757.2152159-1-thisseanzhang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new BPF_F_ADJ_ROOM_ENCAP_PPPOE flag to bpf_skb_adjust_room() so
that a TC BPF program can encapsulate an IPv4 or IPv6 packet into a
PPPoE session header:

    bpf_skb_adjust_room(skb, PPPOE_SES_HLEN, BPF_ADJ_ROOM_MAC,
                        BPF_F_ADJ_ROOM_ENCAP_PPPOE);

The flag reserves room for the fixed-size PPPoE session header (the
6 byte session header plus the 2 byte PPP protocol field) between the
MAC header and the network header, and updates the skb metadata so
that the packet is consistent for later consumers: skb->protocol is
set to ETH_P_PPP_SES and the network header points at the inserted
PPPoE header. The header content itself, as well as the ethertype in
the MAC header, is left for the BPF program to fill in, e.g. via
bpf_skb_store_bytes().

So far a TC program could only add the header bytes manually, which
leaves skb->protocol and friends unchanged, so the skb keeps being
treated as a plain IP packet. In particular, software GSO can select
a segmentation handler based on the stale skb->protocol and process
the encapsulated packet incorrectly.

This pairs with the PPPoE GRO/GSO support in the PPPoE layer, which
registers a GRO/GSO handler for ETH_P_PPP_SES: once skb->protocol is
set correctly, such packets are segmented via pppoe_gso_segment() on
egress.

Signed-off-by: ThisSeanZhang <thisseanzhang@gmail.com>
---
 include/uapi/linux/bpf.h       | 12 ++++++++++++
 net/core/filter.c              | 22 ++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h | 12 ++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 732b35cc0..30481d040 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3036,6 +3036,17 @@ union bpf_attr {
  *		  Use with BPF_F_ADJ_ROOM_ENCAP_L2 flag to further specify the
  *		  L2 type as Ethernet.
  *
+ *		* **BPF_F_ADJ_ROOM_ENCAP_PPPOE**:
+ *		  Encapsulate the packet in a PPPoE session header. Must be
+ *		  used with **BPF_ADJ_ROOM_MAC** mode and *len_diff* equal to
+ *		  the size of the PPPoE session header plus the PPP protocol
+ *		  field (8 bytes in total). The room is inserted between the
+ *		  MAC header and the network header, *skb->protocol* is set
+ *		  to **ETH_P_PPP_SES** and *skb->mac_len* is updated
+ *		  accordingly. The PPPoE header itself and the ethertype of
+ *		  the MAC header are filled in by the BPF program, e.g. via
+ *		  **bpf_skb_store_bytes**.
+ *
  *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
  *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
  *		  Indicate the new IP header version after decapsulating the
@@ -6323,6 +6334,7 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
 	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
 	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
+	BPF_F_ADJ_ROOM_ENCAP_PPPOE	= (1ULL << 13),
 };
 
 enum {
diff --git a/net/core/filter.c b/net/core/filter.c
index 70dc62167..5b204e316 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -47,6 +47,7 @@
 #include <linux/ratelimit.h>
 #include <linux/seccomp.h>
 #include <linux/if_vlan.h>
+#include <linux/if_pppox.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <net/sch_generic.h>
@@ -3583,6 +3584,7 @@ static u32 bpf_skb_net_base_len(const struct sk_buff *skb)
 					 BPF_F_ADJ_ROOM_ENCAP_L4_GRE | \
 					 BPF_F_ADJ_ROOM_ENCAP_L4_UDP | \
 					 BPF_F_ADJ_ROOM_ENCAP_L2_ETH | \
+					 BPF_F_ADJ_ROOM_ENCAP_PPPOE | \
 					 BPF_F_ADJ_ROOM_ENCAP_L2( \
 					  BPF_ADJ_ROOM_ENCAP_L2_MASK))
 
@@ -3688,6 +3690,14 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 			skb_dst_drop(skb);
 	}
 
+	if (flags & BPF_F_ADJ_ROOM_ENCAP_PPPOE) {
+		/* Network header points at the inserted PPPoE header. */
+		skb->protocol = htons(ETH_P_PPP_SES);
+		skb_reset_mac_len(skb);
+		if (skb_valid_dst(skb))
+			skb_dst_drop(skb);
+	}
+
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
@@ -3874,6 +3884,18 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
 		return -ENOTSUPP;
 	}
 
+	if (flags & BPF_F_ADJ_ROOM_ENCAP_PPPOE) {
+		/* The PPPoE session header has a fixed size and is
+		 * inserted directly after the MAC header.
+		 */
+		if (shrink || mode != BPF_ADJ_ROOM_MAC ||
+		    len_diff != PPPOE_SES_HLEN ||
+		    flags & ((BPF_F_ADJ_ROOM_ENCAP_MASK |
+			      BPF_F_ADJ_ROOM_DECAP_MASK) &
+			     ~BPF_F_ADJ_ROOM_ENCAP_PPPOE))
+			return -EINVAL;
+	}
+
 	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
 		u32 len_decap_min = 0;
 
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 732b35cc0..30481d040 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3036,6 +3036,17 @@ union bpf_attr {
  *		  Use with BPF_F_ADJ_ROOM_ENCAP_L2 flag to further specify the
  *		  L2 type as Ethernet.
  *
+ *		* **BPF_F_ADJ_ROOM_ENCAP_PPPOE**:
+ *		  Encapsulate the packet in a PPPoE session header. Must be
+ *		  used with **BPF_ADJ_ROOM_MAC** mode and *len_diff* equal to
+ *		  the size of the PPPoE session header plus the PPP protocol
+ *		  field (8 bytes in total). The room is inserted between the
+ *		  MAC header and the network header, *skb->protocol* is set
+ *		  to **ETH_P_PPP_SES** and *skb->mac_len* is updated
+ *		  accordingly. The PPPoE header itself and the ethertype of
+ *		  the MAC header are filled in by the BPF program, e.g. via
+ *		  **bpf_skb_store_bytes**.
+ *
  *		* **BPF_F_ADJ_ROOM_DECAP_L3_IPV4**,
  *		  **BPF_F_ADJ_ROOM_DECAP_L3_IPV6**:
  *		  Indicate the new IP header version after decapsulating the
@@ -6323,6 +6334,7 @@ enum bpf_adj_room_flags {
 	BPF_F_ADJ_ROOM_DECAP_L4_UDP	= (1ULL << 10),
 	BPF_F_ADJ_ROOM_DECAP_IPXIP4	= (1ULL << 11),
 	BPF_F_ADJ_ROOM_DECAP_IPXIP6	= (1ULL << 12),
+	BPF_F_ADJ_ROOM_ENCAP_PPPOE	= (1ULL << 13),
 };
 
 enum {
-- 
2.47.3

