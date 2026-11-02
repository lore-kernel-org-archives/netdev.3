Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618973;
	b=o04XLbtiOHo4IihnZj8ZOKcBlvwTnpZuqvsGroyhuwfLeMj55JOqMi75VFGgqysjvWSx
	 Ki/kYfAIrIAx7AXd3qSeAQLAn08WdXAnLzJ2Q1P1B+tFqpiyGGxKxFyCvD1ZaEtuVOiTc
	 rnuBoSncHTuCuyd4MFm7QYJrZmFQUVvG+u9SvCeIIm6aJq1EyVARW6kiCpT5NVu4TrbUx
	 nsRujgnkTOxEUzdR6CmZTbltdEdIGNRBR7s909rFMJEWVJeXdxyEErDUFTGIJcbORGEs0
	 SDXFBOIJzjDEJOjoDBmviwAJM5MqLK2SdqGYBCno4wfZVR5vj4ASwXJHGhocurwON9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QwzwIhZ4Vhg0yMtUFiMQIb6T639ZhIjBjhNGY8JVezQ=;
	b=t+eKh49caMrYAGvQ4rPCnbjIBvGUMlYz2r8C2LC8c+tBvTfwZtc+CXNuTWP7EmWsKYt+
	 IfK48wUk5Cm128n/C3nXAqdXYHOevbnO0H1ZDXoidhdTHj2lk7qSaU8lxmfENuPf14TKG
	 Akr7RkdhgqkUP1VUUIc18YNhXabcUnJQaMLTElS+cCaeETEDjeiyz3MftyHudGFOi3HIJ
	 QYzDSvAyGsNoJpQh15rKc922vsFmDKghvTw+LGvy7DGrw6kLVJNYd1F2VmrcC9+VK68n4
	 WyHbTrzMlX9AzmdqujKhIhE0mxX897uZdKw9Ja5esIZBWbRS/1xC5pXyna1XX8QB7Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qICbsGuG;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998460A260B
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 11:29:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2998460A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qICbsGuG
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso5009952eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 03:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793618972; x=1794223772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QwzwIhZ4Vhg0yMtUFiMQIb6T639ZhIjBjhNGY8JVezQ=;
        b=qICbsGuGNoQtaU7lj8qffUjIvxdDaN3KGOFPlwbip0XKuUb044igWgjNgnKwnSxupX
         S7mR80ZlJPCSxbCzBUo8ZWdeXIIGym1DkmxSpzdeYXiIzUC8Jwg2aFm0V5W7HKLyFiXZ
         EmN2ppuGdAS7lJPz6i1+G0f0GXjDs1gZpa/V/qo8ZguBMN9eWrB6kVWq4riuwxXOiXUG
         FkmDYgvKAoyee/u0LFvHpSL26Zb8bbspsNC3vgxcr/sa79iuRJGCzkscATgbyyaaFJRh
         5SOLpbW/bYLFVqoIXqvFa/7T8LSOqJHLS7mpD2u5tJqx8qNdK/cxmrc2En37ap50FOQE
         G3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793618972; x=1794223772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwzwIhZ4Vhg0yMtUFiMQIb6T639ZhIjBjhNGY8JVezQ=;
        b=Ltn0L+0gvOWuEDvO3e2M0Ma2c7406qmWfAinah+GKQj40Ifif3wnQb4F70bEmxoW15
         fv9SHSVYavS/h8CU896TImNA5raC6ywC5i4LNBx6FPuOGWrryHVAefT8TtdDd5KhUlF/
         qhmLxLhO8Ivv7K4upzwOdNt376kpdNUL6LHOl1t6bM7TpivGpG4cmgD6qzkZB878mjWX
         q/HJGtZgKjSIsq86LIE11HAQIGKVNA5EDHsk1PGaru3+9N0MN6IwP8x3xpICiftqg2lR
         GaMi6lD9OxYoH5Rt7hZLiWMVa5Cpgi6Z3+hmqdpFNHlMU6FPVlxxFTD0dCAZP7oNjo9d
         vqmg==
X-Gm-Message-State: APuU4Z/fw7O8NmLsAz8kO8BUYVFZqXH/V07F/DKMUr05iMx2dc4aj4vD
	UFz6qbHz7txkO63kTZsZDX3ZYa56USdU9Gg/4GftfilRPMr/1yEx6SNCM0aSAeKA
X-Gm-Gg: AYBFou1jDXW3UB+1a40ujwZLSeyMk3nEbwX/zp3ILc6klHnEjcJq6V2+TPX0PD338u3
	mYW2vjnk9edllubAEUDPx2uxMmQg0ZkynLGXcC036+LQctEcchBf2QmDr6+rVUnD5dkZsm9QnLI
	lEfnZbkv1OK+6AUESRtAaiPhtzdNjavfO5R7CXiLh0N57z754iO4mgjiBLevO/jDjhgL0rRGhm9
	sYGEJcOVmq1AYKYD4IWYyXAst5MsOzbICLUeBaAmZ7bV77mlhNAfUwaImPBfmyhLHRwMQbbrOib
	pBerfPdpWPuoj+o5ghHuj4sA7Zo4FVqq28+hmJV6cToOavPr7asykIFv319gULR3MzmtECOrabi
	Z78jkj/524sRDGbE5a2Hn+Y3akOl1lNR1Dhiw7MBaDDlM+2F48aXz+JqMwNtuNMAdUXkjIhRu0q
	rS8LP6Z1pMI2zUox8GgUx52sVdlnjPMDGyhZ7Zkgxg0+xJfVjesM3jGsAgCdRZawlxuMQ6S41V+
	Li5zFGWAPxqnm4ja4Z96T+fIollTWvmNvC+BkPPGK3g9Z4/szH7u9M06bYlpftuWMXnRzftrlh2
	3GX1prdg1wwv7bnXRY0WtzHHW7QA1VUmffmt8n3VeAbK
X-Received: by 2002:a05:693c:87cd:20b0:36a:32de:a239 with SMTP id 5a478bee46e88-36a420643f1mr15134932eec.0.1793618971972;
        Mon, 02 Nov 2026 03:29:31 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:51:284f:c2b6:f9ff:fe77:10a0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42902649sm42269118eec.11.2026.11.02.03.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 03:29:31 -0800 (PST)
From: Amaan Cheval <amaan.cheval@gmail.com>
To: netdev@vger.kernel.org
Cc: Amaan Cheval <amaan.cheval@gmail.com>,
	joshwash@google.com,
	hramamurthy@google.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	bcf@google.com,
	jordanrhee@google.com,
	przemyslaw.kitszel@intel.com,
	pkaligineedi@google.com,
	maolson@google.com,
	csully@google.com,
	willemb@google.com,
	yangchun@google.com,
	npl@google.com,
	awogbemila@google.com,
	shailend@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] gve: leave refcount headroom in the RX page bias
Date: Mon,  2 Nov 2026 16:55:54 +0530
Message-ID: <20261102112613.18334-1-amaan.cheval@gmail.com>
X-Mailer: git-send-email 2.49.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gve's GQI and DQO-QPL RX paths set every RX page's refcount to INT_MAX and
hand references to the stack by decrementing page_info->pagecnt_bias, to
avoid an atomic op per packet. This leaves the page no headroom: while a
fresh page's buffer sits in an skb its refcount is already INT_MAX, so a
single get_page() from the stack wraps it negative.

splice() of received TCP data into a pipe takes such a reference, and the
onward splice into a socket then fails: skb_splice_from_iter() sees
page_count() < 1, sendpage_ok() fails and the send returns -EIO (since
commit 2e910b95329c ("net: Add a function to splice pages into an
skbuff for MSG_SPLICE_PAGES")). tee() of the pipe fails with -EFAULT via
try_get_page(). On GQI the reuse check gve_rx_can_recycle_buffer() also
sees page_count() < pagecnt_bias, WARNs and calls gve_schedule_reset(),
so a task that merely pins a fresh RX page (e.g. holds spliced data in
an undrained tee() pipe) can reset the NIC.

Use USHRT_MAX in a u16, as igb, igc, ixgbe, i40e and hns3 do: the bias
only has to make the per-packet atomic rare, so a small value leaves
page_count() ample headroom below INT_MAX for the stack's references.
Refill by adding a fixed batch and setting the bias to it, which keeps
the rule `references = page_count() - bias` intact.

Refill when the bias drops to 1, not 0, so the driver always keeps one
reference of its own. That matters when a consumer returns its
reference before the driver has decremented the bias:
DQO-QPL passes the QPL page itself to xdp_do_redirect() and only calls
gve_dec_pagecnt_bias() afterwards, and an AF_XDP socket in copy mode
returns the buffer synchronously via xdp_return_buff(). If the refill
waits for bias 0, the last handoff of each batch happens at bias 1,
when the reference being handed off is the page's only one, and that
put_page() frees a page that is still DMA-mapped and registered with
the device as part of the QPL. That is a use-after-free: the driver
then takes new references on freed memory and re-posts the buffer, so
the NIC keeps writing packets into a page that may already belong to
someone else. INT_MAX hid this because one page had to be handed off
2^31 times to get there; a 16-bit bias gets there after 65535.

Reproduced on gVNIC in GQI-QPL mode (GCE n2-standard-8, 6.12) and
in DQO-RDA mode (GCE c3-standard-8, 6.12) with the help of
relay.py -- a small splice(2) TCP proxy -- relaying a download while
the RX ring is refilled with fresh pages:

  ethtool -G eth0 rx 512 && ethtool -G eth0 rx 1024   # fresh RX pages
  ./relay.py $HOST 8080 &                             # splice()s both ways
  for i in $(seq 200); do curl -so /dev/null \
      --connect-to $HOST:80:127.0.0.1:8080 http://$HOST/file; done

Most downloads failed with EIO before the fix (tee() with EFAULT) and
all completed after it. relay.py is at the Link below.

This bug was found and fixed with the help of an AI coding assistant
(Claude Code) over an interactive session; it read the driver and
splice/pipe code and ran the tests above.

Link: https://github.com/amaanc/kernel-bias
Fixes: 9b8dd5e5ea48 ("gve: DQO: Add RX path")
Fixes: 58401b2a46e7 ("gve: Add rx buffer pagecnt bias")
Fixes: 82fd151d38d9 ("gve: Reduce alloc and copy costs in the GQ rx path")
Cc: stable@vger.kernel.org
Signed-off-by: Amaan Cheval <amaan.cheval@gmail.com>
---
v1: https://lore.kernel.org/netdev/20261031173449.2439047-1-amaan.cheval@gmail.com/

v2:
 - Refill when the bias reaches 1 instead of 0 so the driver keeps a
   reference of its own across every handoff. At bias 0 a consumer that
   returns its reference synchronously, such as an AF_XDP socket in copy
   mode on an XDP_REDIRECT from DQO-QPL, freed a page still registered in
   the QPL.
 - Commit message: explain the refill point, drop the build notes.

Re-tested on 6.12.113 (c3-standard-8, DQO-RDA, which still uses the
bias on 6.12), fixes EIO/EFAULT from splice/tee nor a NIC device reset
after applying the patch.
DQO-QPL is untested; I have no access to that hardware.

Built allmodconfig W=1, no new warnings.

 drivers/net/ethernet/google/gve/gve.h           |  2 +-
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c   |  4 ++--
 drivers/net/ethernet/google/gve/gve_rx.c        |  8 ++++----
 drivers/net/ethernet/google/gve/gve_utils.c     | 17 ++++++++---------
 drivers/net/ethernet/google/gve/gve_utils.h     |  8 +++++++-
 5 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index b7ce6e8632db..18d7edbf4b3b 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -119,7 +119,7 @@ struct gve_rx_slot_page_info {
 	void *page_address;
 	u32 page_offset; /* offset to write to in page */
 	unsigned int buf_size;
-	int pagecnt_bias; /* expected pagecnt if only the driver has a ref */
+	u16 pagecnt_bias; /* expected pagecnt if only the driver has a ref */
 	u16 pad; /* adjustment for rx padding */
 	u8 can_flip; /* tracks if the networking stack is using the page */
 };
diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
index 6880d1531ba5..571f851d6dcd 100644
--- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
@@ -149,8 +149,8 @@ int gve_alloc_qpl_page_dqo(struct gve_rx_ring *rx,
 	buf_state->last_single_ref_offset = 0;
 
 	/* The page already has 1 ref. */
-	page_ref_add(buf_state->page_info.page, INT_MAX - 1);
-	buf_state->page_info.pagecnt_bias = INT_MAX;
+	page_ref_add(buf_state->page_info.page, GVE_PAGECNT_BIAS - 1);
+	buf_state->page_info.pagecnt_bias = GVE_PAGECNT_BIAS;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/google/gve/gve_rx.c b/drivers/net/ethernet/google/gve/gve_rx.c
index 81ea800e66e9..6533fff06155 100644
--- a/drivers/net/ethernet/google/gve/gve_rx.c
+++ b/drivers/net/ethernet/google/gve/gve_rx.c
@@ -152,8 +152,8 @@ static void gve_setup_rx_buffer(struct gve_rx_ring *rx,
 	page_info->buf_size = rx->packet_buffer_size;
 	*slot_addr = cpu_to_be64(addr);
 	/* The page already has 1 ref */
-	page_ref_add(page, INT_MAX - 1);
-	page_info->pagecnt_bias = INT_MAX;
+	page_ref_add(page, GVE_PAGECNT_BIAS - 1);
+	page_info->pagecnt_bias = GVE_PAGECNT_BIAS;
 }
 
 static int gve_rx_alloc_buffer(struct gve_priv *priv, struct device *dev,
@@ -230,8 +230,8 @@ static int gve_rx_prefill_pages(struct gve_rx_ring *rx,
 			rx->qpl_copy_pool[j].buf_size = rx->packet_buffer_size;
 
 			/* The page already has 1 ref. */
-			page_ref_add(page, INT_MAX - 1);
-			rx->qpl_copy_pool[j].pagecnt_bias = INT_MAX;
+			page_ref_add(page, GVE_PAGECNT_BIAS - 1);
+			rx->qpl_copy_pool[j].pagecnt_bias = GVE_PAGECNT_BIAS;
 		}
 	}
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index caed38cd5f2b..adcdccd54684 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -92,16 +92,15 @@ struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
 void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info)
 {
 	page_info->pagecnt_bias--;
-	if (page_info->pagecnt_bias == 0) {
-		int pagecount = page_count(page_info->page);
-
-		/* If we have run out of bias - set it back up to INT_MAX
-		 * minus the existing refs.
+	if (page_info->pagecnt_bias == 1) {
+		/* Refill at 1, not 0: the page's own reference is counted
+		 * in the bias, and a consumer can put the reference we just
+		 * handed off before we get here (e.g. a synchronous
+		 * XDP_REDIRECT return). At bias 0 that put would free a
+		 * page that is still mapped for the NIC.
 		 */
-		page_info->pagecnt_bias = INT_MAX - pagecount;
-
-		/* Set pagecount back up to max. */
-		page_ref_add(page_info->page, INT_MAX - pagecount);
+		page_info->pagecnt_bias = GVE_PAGECNT_BIAS;
+		page_ref_add(page_info->page, GVE_PAGECNT_BIAS - 1);
 	}
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_utils.h b/drivers/net/ethernet/google/gve/gve_utils.h
index bf2e9a0adb36..a5e3413234d0 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.h
+++ b/drivers/net/ethernet/google/gve/gve_utils.h
@@ -25,7 +25,13 @@ struct sk_buff *gve_rx_copy_data(struct net_device *dev, struct napi_struct *nap
 struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
 			    struct gve_rx_slot_page_info *page_info, u16 len);
 
-/* Decrement pagecnt_bias. Set it back to INT_MAX if it reached zero. */
+/* Up-front references gve holds on an RX page, so handing a buffer to the
+ * stack is a pagecnt_bias decrement, not a get_page(). Keep it in a u16 so
+ * the 32-bit page refcount keeps the headroom every page needs below INT_MAX.
+ */
+#define GVE_PAGECNT_BIAS USHRT_MAX
+
+/* Decrement pagecnt_bias. Top it up to GVE_PAGECNT_BIAS if it reached 1. */
 void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info);
 
 void gve_add_napi(struct gve_priv *priv, int ntfy_idx,
-- 
2.47.3

