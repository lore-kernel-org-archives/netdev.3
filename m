Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DE233D4E4
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183692; cv=none; b=WqVcxF7vnlj/i9nu4VOhlnqs/sCtoKmiJBFsZzN3G7chJJ9wvzhYAQVfW7tz0pbJOfyh3x2FqJ7XpgdBf7G3tJsK0Ar6uvdLOj5hIBoY5vhgz6dNQJPH7Gn5zRAFRbs6hv5hTLMliY0YLLp5Ihw4GesrVoZwR3nYn548ugh1P+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183692; c=relaxed/simple;
	bh=vwtzLaUn7wHgUAalpp5RyegEj5VMiUcE2KwC9OxQpoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hn6ffTNMERwgO0zJo9c5F6bRdY7QhueeFNCpF2sSPefIVpcH+rTGmhflfm1fZG/GNoM58nV4mfLwJzrnLzp/QM2iOawoDSGhEr3OpqbywgHyExxaYPXSpjflNFg5Njote9ns5ekgtIohA4vU08XQSo6PX+xTJYHrtH3mpcsEHVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbdkXmL4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbdkXmL4"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848761b5897so3275445b3a.3
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784183690; x=1784788490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GwXxw7O4TWZvXWtuVAmXlGrveb0Tk1fsMJGJIBcnjmk=;
        b=nbdkXmL46zpBls7LPE4Ql/QjaIyicnvx7h+gpaWtq3xr+D49YtGTfMvoF0Wj4uGAgx
         IeNBy539JJ7tVL8y4404MTz1EPGHVfjErPqJV5/djiMTKfnxGx2Be5popFww8VFrqMkL
         PimpZsiM1XkvuJIdmMWklR8LWbihstK2pAGz0Tqvk+ziy8QB3yp4vqea5LwU5IuL9CmN
         lSx6lnDruyqGMUvXrabbmVBw0qBye0h0YYwWxKDmSCx/HB0cIhTyFvVLRSAuN3PWBJDY
         6RWKnsJqbCRbqacMqpkyWpxflE+DrrRyZANgeYFR2arCRk2wbyn5/h4oLdjJ57yz3Znr
         UbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784183690; x=1784788490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GwXxw7O4TWZvXWtuVAmXlGrveb0Tk1fsMJGJIBcnjmk=;
        b=Zvzjho4tv3TfQvtXGUg7wfIh/YPNYwzni8qTkD4ZtU1vBXts8FxyNbq+EOO3uDwt6M
         CR0UzWEclphoptbOOJ7fsUEQSv/GuTrdELSutAHdVkknomUhAGss/7Wbm5dC2eRbVmq2
         4O0BfQLcFRPwwH1hXz7hZfkkTNyR+PgmCmv8Ktau7iT1DxWxa2z0aQXKnkB42fxorIIq
         JstJ/sQCWM/38JZT8pZOgwifeCoiB+EkQfG8nEaMh47hpzyi8AdCVxHFbVoHvmiDv8sO
         85L4CQYs8caPRXL/nnLtHgj9q2Vy3CLalXFRUs8cSPMFFJkrB1V1f3h7mV37ySADuHIp
         TYLA==
X-Forwarded-Encrypted: i=1; AHgh+RrtvMX9GKBb9kRfaR2ldVoHK+yW8c9aWwrjUbI5JH9YJF2MrqmAbAdkZXDh+EYNoYnK2YR63P4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyu9AhTxONsrKV40CaiUQn29rlaaFXlkHQpWuYcOibV31EZHZw
	IrLgvOfs0mhY6XRC7JEAYTodIrkAR4afL5tAd1mNhQONTQx6pskPcqLx
X-Gm-Gg: AfdE7cnt9FSd+krscT2ye8QnFjbptDg0mspxZuoCYSrHDImLisq/7VYi1QAgAI6js+H
	iOytUi47sMihwXFiRwRVsVXjh2bbIC/MIE8FRniroPl5AO1z3dtfZl/TNw/7kJtmF5zwsLXJSG1
	2uFvtlyJjfvkVcss3oT3+XAN7GE6Nkompz0rpRTzW3bj3NBBwI3OLqnmk7k3+2231w1+TjSU4B+
	6tKt0rBdcwogmPe5CbGEjZwdG87gT2P9SOcD7j+Fa6u09CE/gDMG2OthLwnUBN8jgfsF/MVQHEM
	Mt766G12LP73Emm+qwQtuodqWJlI2nd1Tq8lzsojm5HUlfFmB06vy+PuU7xso0VoASNQvj66SPY
	h2GQ+33NTLjmnuveYaUoPYTK+6fYWutatza6m2+vduPcmyVABgTmwiQwyXfAJhZRRi8xSRcsmhK
	V3zUdkbnRq93lsHffIv/KC2zT7NEj2ajevScyp0Q==
X-Received: by 2002:a05:6a00:2da4:b0:845:e41f:9696 with SMTP id d2e1a72fcca58-84a5574252bmr8683937b3a.25.1784183690556;
        Wed, 15 Jul 2026 23:34:50 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dadcfsm4242172b3a.48.2026.07.15.23.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:34:50 -0700 (PDT)
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
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v5 3/3] octeon_ep_vf: fix skb frags overflow in the RX path
Date: Thu, 16 Jul 2026 14:34:32 +0800
Message-Id: <20260716063432.2908100-4-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716063432.2908100-1-maoyixie.tju@gmail.com>
References: <20260716063432.2908100-1-maoyixie.tju@gmail.com>
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
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 52 ++++++++++++-------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index 302559b16b..138e779f7e 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -357,6 +357,31 @@ static inline u32 octep_vf_oq_next_idx(struct octep_vf_oq *oq, u32 idx)
 	return (idx + 1 == oq->max_count) ? 0 : idx + 1;
 }
 
+static void octep_vf_oq_drop_rx(struct octep_vf_oq *oq,
+				struct octep_vf_rx_buffer *buff_info,
+				void *resp_hw, u32 *read_idx, u32 *desc_used)
+{
+	u32 data_len = buff_info->len - oq->max_single_buffer_size;
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
@@ -430,29 +455,18 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
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

