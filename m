Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573E41D123
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735521; cv=none; b=EIvV9gC5yO04s5fOSPgTbBf6+YgHd1d32i5YZuaiQFqIEkuP/iI94zLN2szMyDdEIM2QIFZYlN82jDm2bX2fP62Rnz3dRZGwrBgJJYPfdr8LCaNDzib1EYLEX7a6Zn2tSzwDcPOF8mqBumbCOukQIyselfWuhsoZ44q4uRV2egw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735521; c=relaxed/simple;
	bh=YiOZsq6Y1IbB4b4lwLMmIwOT04xVy4fzjYkWQ7AnOlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rk2NB5DOKIr4lCa6M4I4ElZpEBETx+vWT476DZExGCPXVrL8Ezco09KrxSNdsZbQDEI8iKjR/H+tuvdjcYWKVpwl4J1JiATUBQ3pPFPJQIGMcLBRuYj6r5Q5gZHs/c0Y1F8r3u0CSqx1Z91lnouq422u4gKiZ8ZMCHLLT9NVWoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcmVj7pd; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcmVj7pd"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so4145398a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 08:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784735515; x=1785340315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=onDvN0sOyUsUE/lLtZeTVoz1SOZ06K7HZFi9ZupIfc4=;
        b=DcmVj7pdpmc0Sy9cG4sfn7+gn27889loPRUjR0rap+s8HiuKu2/VzVnv2x/TrVIlfY
         7jZvcHXl601q4xpPufmOPZ8loeDmemCGXNQ8ackeXfCvy8CeNr2r8i8F0r+62fk8OZ8N
         +yybKsEKD7ptFQ1/aoBpWvKabJvYUIoqLSgokDP99/HSnWwteKMqcAJnQ5zLl0C/seCq
         42/3wbP0wywHcEFX92VZNquUsblME1MXplYJz2GgIHdo4Ap4NRjJpr+qrfI99r79oUvt
         qDXlIX6+AbyY+XxwgQTgqi+7NbS1g5djFf/L4AWhNcl3FxqJQkmlHv/ga94uM2qM/zP2
         eY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784735515; x=1785340315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=onDvN0sOyUsUE/lLtZeTVoz1SOZ06K7HZFi9ZupIfc4=;
        b=jH8V0HKbka7L3zUPYFCWZzAHR4wLojuNPGbOUeApHWYO6AdqP2262mH9d9tD6i8iLe
         xLl71B8oTI+8M/MG+SYNNfSW+C1+cddXy4U/jF9XEksctAGr0WG7idZh5xJtexnQ30QR
         HDmi6rI8l2l3Xgrqj04BKPqJ+Pik1Yc2A/suzjfPsX0QIyvQKP2+gtOA+dutYH9jV4/z
         ocb/0UrpIexLYbLecyg5bDI4w4PGB6yYl/tdJDvPoLU65rhs7iVf12iECZBhFA59As7O
         0jU07PGLpxISnOYV298GUWZhfx/IdLc4SSUhjCBH0pjWdqtG15ER58AE+i7Mk8KdN99d
         SjJw==
X-Forwarded-Encrypted: i=1; AHgh+RrwrzQ3NR9BsQc66+1uEbggPr4Yx3WcY0+NO6H8ONSj4vlL986DP5zzAao72eqSFFzuFe5NeKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYR/ziItYp3CsTzrFlWbD5YNNmHpQ+Wx2h5QiNpz9Nbls7BCn4
	fdWR5jrlrzIufqHloXKhp5LeUItIc8ZVufaP9wvdujLX822KobZ8bdLx
X-Gm-Gg: AR+sD10Od6wS+AQanK7Kht8/LBOdVv3od7NPIay2JQAWgREq75leRYbhbglkCV0WUcl
	NiB93neVl/r1Jv5vNmMBFzsjJg7fPg6B1xQ1ScIIN79Gmgg5ynOYIVqPjp+ejq13qK8KJgsW6CP
	+R86aNWYfhBHtEu0WvuMQ0fT2TxHks2K4K5eTHk96j1o229bPB6YC4UzqmUJEQV/uf8b98xP//t
	MQroJ5zlvUo2rI5HvWi+Ohir+njRz4PhMvwj+hnC9EdZMqCS+CG8WQPv5bIZXO2yuTk3mVwld6/
	J+2hLiNCCfAGMWEdbbzPG+A97jeRnVhBXWAgoIzJexD0kccm+KUACOXPGlNeg1LDnwYGZpDhIoP
	eptW/BwdTvDDB8Qy4jeLoG7mf5uDNX40a3qGDs+V55aygjdbCbK0nvmKD3zkqzzVja+GJVjSLpa
	ZduedHpA34FESi+MnGCt2m6f6zmUPWFLVfPLdmQA==
X-Received: by 2002:a05:6a20:2d21:b0:3bf:aa54:4cbc with SMTP id adf61e73a8af0-3c4294a6909mr5228486637.26.1784735515492;
        Wed, 22 Jul 2026 08:51:55 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm11123125eec.17.2026.07.22.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:51:54 -0700 (PDT)
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
	Simon Horman <horms@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6 4/4] octeon_ep_vf: fix skb frags overflow in the RX path
Date: Wed, 22 Jul 2026 23:51:31 +0800
Message-Id: <20260722155131.2017597-5-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722155131.2017597-1-maoyixie.tju@gmail.com>
References: <20260722155131.2017597-1-maoyixie.tju@gmail.com>
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
and every fragment page. The drain stops after MAX_SKB_FRAGS fragments. A
bad device length cannot run it past the ring. The previous patch added
those frees to the inline drop path. The napi_build_skb() failure path now
uses the same helper.

Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 53 ++++++++++++-------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index 302559b16b..9d71937074 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -357,6 +357,32 @@ static inline u32 octep_vf_oq_next_idx(struct octep_vf_oq *oq, u32 idx)
 	return (idx + 1 == oq->max_count) ? 0 : idx + 1;
 }
 
+static void octep_vf_oq_drop_rx(struct octep_vf_oq *oq,
+				struct octep_vf_rx_buffer *buff_info,
+				void *resp_hw, u32 *read_idx, u32 *desc_used)
+{
+	u32 data_len = buff_info->len - oq->max_single_buffer_size;
+	int i;
+
+	put_page(virt_to_page(resp_hw));
+	(*desc_used)++;
+	*read_idx = octep_vf_oq_next_idx(oq, *read_idx);
+	for (i = 0; i < MAX_SKB_FRAGS && data_len; i++) {
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
@@ -430,29 +456,18 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			read_idx = octep_vf_oq_next_idx(oq, read_idx);
 		} else {
 			struct skb_shared_info *shinfo;
-			u16 data_len;
+			u32 data_len;
+
+			data_len = buff_info->len - oq->max_single_buffer_size;
+			if (DIV_ROUND_UP(data_len, oq->buffer_size) > MAX_SKB_FRAGS) {
+				octep_vf_oq_drop_rx(oq, buff_info, resp_hw, &read_idx, &desc_used);
+				continue;
+			}
 
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

