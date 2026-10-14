Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E114E7807
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981608; cv=none; b=pfGVkYgKwuwMB31sIunIb/ABJv9d+p81zemLc8vXRTpjiXSyoPI7VEdpJq9k6zqweGxa1yX6OxitwsJdVdB52Ay2YQKpa3ZsLkHsO0+HcTPMLx1xKWez5Hzhh9JtGXeg0D+OkXND1xBR1x3w09RqPxldHKcnH80kOQyYAgpbhDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981608; c=relaxed/simple;
	bh=4Piv2CI9sadBoT7rMKzK0vTXaF/jRiPd6olpiWlGh6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjYRxvafhMELTlBZrpTiomy0o69+vw78qeacAuLlTaBAk2KMhUzL+db6CenlOVAlSjj7iKALjWl7ljIGJrIL3rYO/42bjrcuxv6hYj5n8ZfPF9SRAF2irl4fwykoEg47BXK0XakfRcxzqtonGGI89U6uUBVS/277y0uIT0j6DHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JukPAsZG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JukPAsZG"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so32143615e9.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791981605; x=1792586405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKmAPboELViMedd9OF97VZ6G4NUnBVl906J/PIlmbd8=;
        b=JukPAsZGT0OhYoK3/iTRzP9/oHOEzZmGEpKNJb4y2boP6IOu9Lfxgvc2vTF6m7gJY8
         xZueKByIsplIRgLGMPmo8bGgwcxm6pA55RMUh4RBHVWKoDwfSiSa5lu+8sq1gQw3LYp5
         WdwoY6Fz61Ise4CB0sJ3G4GyFniNwi9ObHKjeb0yrPOQcbe4bP4oJkxmaGbeMtVqGQDd
         knpDvlxke7EPzbtTm2FpdgVNPCJFAgMJcvO571AkylI+8bMhWJmTcCCX5y0VOMomUYW+
         mbMzs6VTUzYdz/fQaZfj22FsStoynVLYptaozt7QaRQ6Ok5Q6D3ecOwYNjd2iS8UfBGa
         rn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791981605; x=1792586405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IKmAPboELViMedd9OF97VZ6G4NUnBVl906J/PIlmbd8=;
        b=ozbcbBhx/EQFqrLRhfkOQuAbEKhHRrzaM8guxPJK8Ryhm2Dgk9m1cbiegvCC2z++4C
         UGuSUa19vyX6+uEU99FRJMcMQrurz1JCD0q4OKYpUPe3OfY5K4KGRt/WeONiNhwpYBi9
         IpO9HtQq3YzVArrQUrI+lO/S3IxypJAp+PLrQvOynVof4u84wCY2BgedzsbxYG06l73b
         vPJg4wI+Jqywe4pHAvVgm1YkHYE/ERkJ+6nYLa3QtuilnBwLKvVg8w9Vt/Yw4rRGdrnz
         rvrhL+2hcppDooake9zRYTA3Vg2AL/INoLXMGVgfmbBT5fpp1iSYyzcDDVnjk140FpVI
         61TA==
X-Gm-Message-State: AFq9FYJWuYbCeldg3QBP/xRXGCGGL63oZRL+Yb5PReKH6Boclg3VhkTN
	bMsUnJrQaxkVCBTG4GpegqxYSGSuBIwFRriVRMXFmD77CVXVfCymaTnOMafjs5vPQYk=
X-Gm-Gg: AYBFou2LlZA7oAme2fnJoLOaigre3LsK6vOqicsN4EUANSUD7maA9fUXrwN7o7MD0N2
	OMa+AAKkCroKzgvWs4kn+cJ1HkHWV3I5C8kP/wqDL3XvgKmNzMeIneVo9ndJU3zo350EtNmf4/3
	yJKiXKbKQ7BjiG0Kdo1JGp6ZvaGIHkQu7xmmnek4U9dxQJMR7TW1J/EHrhxyOs8dSxO1bQvW05H
	1WBm0Xe5KCiFUIIfmf5TIucrEYx4IHDkKgbVx6byqf/fFnVyvDtCaWqzZKiTib1N+oQaQvdEMEd
	XhN53gNz3N1wCGzwL2SzEVz33l5b8TY3Rcmhog9DqxUaeukhmZvpyerd56/ACMht4TytafPhs+8
	hVQfxhYbFwfWAXbtdCVKwojoQMbm7fnn8yaB2MNg/xNa5wHlbZEawdvq0VcEPUQseFXwmbf3XcI
	R2DxujW7qKxkuKso8fAOsSJ6M0dbCopuYW3pnsVUIAO8wDvSzxnYfuyFhzqacscJMSf6MT/tr6Q
	w==
X-Received: by 2002:a05:600c:4e01:b0:49f:ce78:3567 with SMTP id 5b1f17b1804b1-4a18e4afc3amr300571905e9.24.1791981604576;
        Wed, 14 Oct 2026 05:40:04 -0700 (PDT)
Received: from kali ([169.224.126.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b2ec47fcsm54163165e9.1.2026.10.14.05.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:40:04 -0700 (PDT)
From: Ali Firas <alishmery18@gmail.com>
To: netdev@vger.kernel.org,
	idosch@nvidia.com
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	razor@blackwall.org,
	roopa@nvidia.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Firas <alishmery18@gmail.com>
Subject: [PATCH net-next v4 3/7] vxlan: vnifilter: clamp the dumped VNI range to the request limit
Date: Wed, 14 Oct 2026 15:38:10 +0300
Message-ID: <20261014123814.388557-4-alishmery18@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014123814.388557-1-alishmery18@gmail.com>
References: <20261014123814.388557-1-alishmery18@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxlan_vnifilter_dump_dev() coalesces a contiguous run of VNIs sharing a
remote into one VXLAN_VNIFILTER_ENTRY, and packs as many entries into a
netlink message as the skb holds, with no bound on either. A later patch
bounds a single request to VXLAN_VNI_FILTER_MSG_MAX VNIs summed over its
entries; without a matching bound on the dump, a device holding more than
that -- populated by several requests -- would dump a run, or a message,
that the input path then refuses on replay.

Introduce VXLAN_VNI_FILTER_MSG_MAX here and clamp the dump to it first, so
the series never passes through a commit where the kernel reports a range
its own input path rejects. Bound the two ways the dump can exceed the
limit:

  - end a coalesced run once it reaches the limit, in the merge condition,
    even when the next VNI is contiguous and shares the remote; and
  - carry a per-message VNI budget, ending the message once its entries
    would sum past the limit, the same way the loop already ends it when
    the skb is full.

cb->args[1] continues to count the VNI nodes already dumped and is advanced
only when a completed entry is written, so the budget break and the
skb-full break share one resume path; a run stays a gapless block, so the
dump never drops a VNI and never emits one twice.

Assisted-by: LLM
Signed-off-by: Ali Firas <alishmery18@gmail.com>
---
v4: moved before the input cap; now introduces
VXLAN_VNI_FILTER_MSG_MAX and adds a per-message VNI budget (v3 clamped
per entry only), so the dump never emits a message the input path
rejects.

 drivers/net/vxlan/vxlan_vnifilter.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index 9e15f4de75c9..5beec29eb84a 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -17,6 +17,13 @@
 
 #include "vxlan_private.h"
 
+/* The dump coalesces a contiguous run of VNIs into entries, and packs entries
+ * into netlink messages, of at most this many VNIs each, so every message the
+ * dump emits stays within what the input path will accept on replay. A later
+ * patch bounds a single RTM_NEWTUNNEL/RTM_DELTUNNEL request to the same number.
+ */
+#define VXLAN_VNI_FILTER_MSG_MAX	4096
+
 static inline int vxlan_vni_cmp(struct rhashtable_compare_arg *arg,
 				const void *ptr)
 {
@@ -342,6 +349,7 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 	struct nlmsghdr *nlh;
 	int idx = 0, s_idx;
 	bool dump_stats;
+	u32 vnis = 0;
 	int err = 0;
 
 	if (cb->args[2] != dev->ifindex) {
@@ -388,15 +396,29 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 			continue;
 		}
 		if (!dump_stats && vnirange(vend, v) == 1 &&
+		    vnirange(vbegin, v) < VXLAN_VNI_FILTER_MSG_MAX &&
 		    vxlan_addr_equal(&v->remote_ip, &vend->remote_ip)) {
 			goto update_end;
 		} else {
+			u32 sz = vnirange(vbegin, vend) + 1;
+
+			/* End this message on its VNI budget the same way we
+			 * end it when the skb is full, so a dumped message
+			 * never sums to more VNIs than the input path accepts
+			 * in one request. Resume re-emits this run as the
+			 * first entry of the next message.
+			 */
+			if (vnis + sz > VXLAN_VNI_FILTER_MSG_MAX) {
+				err = -EMSGSIZE;
+				break;
+			}
 			if (!vxlan_fill_vni_filter_entry(skb, vbegin, vend,
 							 dump_stats)) {
 				err = -EMSGSIZE;
 				break;
 			}
-			idx += vnirange(vbegin, vend) + 1;
+			vnis += sz;
+			idx += sz;
 			vbegin = v;
 		}
 update_end:
@@ -404,7 +426,10 @@ static int vxlan_vnifilter_dump_dev(const struct net_device *dev,
 	}
 
 	if (!err && vbegin) {
-		if (!vxlan_fill_vni_filter_entry(skb, vbegin, vend, dump_stats))
+		if (vnis + vnirange(vbegin, vend) + 1 > VXLAN_VNI_FILTER_MSG_MAX)
+			err = -EMSGSIZE;
+		else if (!vxlan_fill_vni_filter_entry(skb, vbegin, vend,
+						      dump_stats))
 			err = -EMSGSIZE;
 	}
 
-- 
2.53.0

