Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30499376465
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350157; cv=none; b=hkB+M7XXJxeUqDh47q1B17jHH4L3N1ohkLN2NRrNL2a7sN0DAsbZbFxzDMVVUH2pBFUSFofidHjX1q/R4SpBy4sL+D2PcsNANw6Ht5WDSznsnY4+LgZRIv+wWHiTIhIUjnFIZ4oBgBHN1Do+gRXuDWRFMV+n74o1sJqNyWNdw6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350157; c=relaxed/simple;
	bh=JGzkXl8T4vjevVpJys/9S7aV2vwhdOJ0EE2T8w9o+ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=niRELkr2cSB457FP6ZvCOZV4nVWBApDSzx0LiB8ygyU6nO4udfav3/XanlO9KCe6I65jspqE6PF/QBSbfaw3Dw/DJwg9+ZpTE2WLVM/4RfLpdGjfBEzC9bJI0RYF5uBv6VIUcI4DsB/8skE3/YUKgoT0uDdBIfpc5EXV12/Xd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbYEEjjf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbYEEjjf"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so20603645ad.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 08:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783350154; x=1783954954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bk3S36tC0GR663/gxEYgv45wCB/Ce7y/WSTL/b0Dlu4=;
        b=YbYEEjjfCVZMncjx0L2Jaf6DomVF0tSTUXjtgv4KfIjjpc3U8KO1jxiQ0dEYxVqKEV
         kP41AfxGQP7shiBnfXXk0oG0O+GEKHdRzhOPL8SBn6JywjW2xZRfSOPIYXRdBH7QQXdm
         ZfIlFdwohRoVG2N1zCUV7tyqVI6rYodzi5fmzGne0vKXTS5JbsIGr5JzKPyRs8ISQuTn
         wJBQpo8uUFPM/2ZDEvWooBiNucZx0CMIZXXM3xo+6iKMkCbf8uEvpzj5qBhxhHK5vD72
         3UmJFdVwijKNFpePEWzPYj2e4jFIvXkQXk5/QwZF/cIv0zAc2oU5aprnyzlrbCThQagt
         cMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350154; x=1783954954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bk3S36tC0GR663/gxEYgv45wCB/Ce7y/WSTL/b0Dlu4=;
        b=ITVwLR7n7rBfEvlRGrYHUA+gXxL3QBSjnyND/YeJ7Fq2mlD5jFvrnXo9ZUnJi7w+fM
         ndt7E7QXRzJm50fGFFzCRzJpvqbaQzg5JIqgldq5wFg2Bdkeiglh7aTX/xuG0Jx1TpP1
         RbRCBOYZbiZ3yIOwgvnchUJE3hPdI/QXUGof10olFZF/4u5FufQlx2JxOwYR9jsgjg7c
         a1aXBxHoCtdzb624DocV+ZV8iENcGa0tM5abUuWCUgD0lnwiq722kKFXyGwHdfuXcanJ
         RKM4tuyKRavPgn5mipEktfwUesPGSxb67oT5tcx2hO8SHVyD76+uv51r9FZdObKkVyjU
         mCrw==
X-Forwarded-Encrypted: i=1; AHgh+Rrdfv73i9sxJjEgte6bmwzqn9E9yJQpcDTimyvgPu1yh1CCqm57MCsgAMLuqcL1ht5oWnP7H1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYDGNE85HsfO7/naK8twt0TaOvF1JzhTQR2EhXQjz+rjfrKcqQ
	C3b1sbw2erpq1mMGVdVyLdEbPlsdtZx1Y1XJuRdUekPtrdj2/sEEzyUa
X-Gm-Gg: AfdE7cmFqOPsAR5LiJBoezgv3FQl92aglgf2ya1GM1nwvrku36UFlpZLl2LmrW0w5z0
	pWejY7ertBKCKvaLcESxBN2K71qy+H/oHXZ6ucdWuwLNKm582/VQXijRyV+V6BpdWXVqh2lyFQz
	PoJ6GvhQr56zNpUpJomApr/M7z7+CXOG4aunrUcWiQR4csSuyBHK717P86Fsh6SVOEOkpG4Ut6R
	BzMYQiDVET1sqgW12A/bZ8lCmpwZd2//MBv35kLP5Li6hf3dvjOtoFPQ6XDTH4AtZgtq/ogFkwS
	UQM1LS2u/wHO/23Vz70/XTg28wJW2EfUhUD9q5UWcxFbLtP4IGgo8DMsdby+Gs07kbqYRF1qscS
	sQYbTZKPNNJwSKgSKQ67ecl5PYh/yxKs/viZtB+osSWpR8A4mHkySFp6sNtkToRvk/U4m5qfTUB
	2JWAsQAYs0uMtVaG9hbPUKOfeirQ7EYe2OlMzqUg==
X-Received: by 2002:a17:902:c404:b0:2c9:97a7:3278 with SMTP id d9443c01a7336-2ccbf1828b0mr10330665ad.41.1783350153050;
        Mon, 06 Jul 2026 08:02:33 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cb3f5b7090sm41651765ad.26.2026.07.06.08.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:02:32 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v4 3/3] octeon_ep_vf: fix skb frags overflow in the RX path
Date: Mon,  6 Jul 2026 23:02:08 +0800
Message-Id: <20260706150208.2944898-4-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706150208.2944898-1-maoyixie.tju@gmail.com>
References: <20260706150208.2944898-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__octep_vf_oq_process_rx() has the same unbounded fragment loop as the PF
driver. buff_info->len comes from the device response header. The loop adds
one fragment per buffer_size chunk with no check against MAX_SKB_FRAGS. A
long packet yields about 18 fragments. That is one past the default
MAX_SKB_FRAGS of 17. skb_add_rx_frag() then writes past shinfo->frags[].

The fragment count is now checked before napi_build_skb(). A packet that
needs more fragments than the skb can hold is dropped.

octep_vf_oq_drop_rx() drains those descriptors. It also frees the head page
and every fragment page. The previous patch added those frees to the inline
drop path. The napi_build_skb() failure path now uses the same helper.

Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 50 ++++++++++++-------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index 302559b16b..e7733b41a1 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -357,6 +357,31 @@ static inline u32 octep_vf_oq_next_idx(struct octep_vf_oq *oq, u32 idx)
 	return (idx + 1 == oq->max_count) ? 0 : idx + 1;
 }
 
+static void octep_vf_oq_drop_rx(struct octep_vf_oq *oq,
+				struct octep_vf_rx_buffer *buff_info,
+				void *resp_hw, u32 *read_idx, u32 *desc_used)
+{
+	u16 data_len = buff_info->len - oq->max_single_buffer_size;
+
+	put_page(virt_to_page(resp_hw));
+	(*desc_used)++;
+	*read_idx = octep_vf_oq_next_idx(oq, *read_idx);
+	while (data_len) {
+		dma_unmap_page(oq->dev, oq->desc_ring[*read_idx].buffer_ptr,
+			       PAGE_SIZE, DMA_FROM_DEVICE);
+		buff_info = (struct octep_vf_rx_buffer *)
+			    &oq->buff_info[*read_idx];
+		put_page(buff_info->page);
+		buff_info->page = NULL;
+		if (data_len < oq->buffer_size)
+			data_len = 0;
+		else
+			data_len -= oq->buffer_size;
+		(*desc_used)++;
+		*read_idx = octep_vf_oq_next_idx(oq, *read_idx);
+	}
+}
+
 /**
  * __octep_vf_oq_process_rx() - Process hardware Rx queue and push to stack.
  *
@@ -432,27 +457,16 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			struct skb_shared_info *shinfo;
 			u16 data_len;
 
+			data_len = buff_info->len - oq->max_single_buffer_size;
+			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
+				octep_vf_oq_drop_rx(oq, buff_info, resp_hw, &read_idx, &desc_used);
+				continue;
+			}
+
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
 			if (!skb) {
 				oq->stats->alloc_failures++;
-				put_page(virt_to_page(resp_hw));
-				desc_used++;
-				read_idx = octep_vf_oq_next_idx(oq, read_idx);
-				data_len = buff_info->len - oq->max_single_buffer_size;
-				while (data_len) {
-					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
-						       PAGE_SIZE, DMA_FROM_DEVICE);
-					buff_info = (struct octep_vf_rx_buffer *)
-						    &oq->buff_info[read_idx];
-					put_page(buff_info->page);
-					buff_info->page = NULL;
-					if (data_len < oq->buffer_size)
-						data_len = 0;
-					else
-						data_len -= oq->buffer_size;
-					desc_used++;
-					read_idx = octep_vf_oq_next_idx(oq, read_idx);
-				}
+				octep_vf_oq_drop_rx(oq, buff_info, resp_hw, &read_idx, &desc_used);
 				continue;
 			}
 			rx_bytes += buff_info->len;
-- 
2.34.1

