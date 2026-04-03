Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB1D3563E9
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775246858; cv=none; b=G5B4c2eJrPceZtQUg8HUDWbhNfQPDgeoLZuySC3/BcchYrnqsH1o2RA5xgBhkWfAtx+aFa/OHxu9i+VSC6z93cDmMZcpChkVWJPCBZTkmT7jAB0rMrFPu32fXdMmmdGDdkGWDEqVV7dUezGi3JmZ7jfKtJUZCyPvGQE5SshkGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775246858; c=relaxed/simple;
	bh=2EWNeglDkNZGr2Gg1mnutn0NEb1fsT8qNPLfPzONX6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioijJk8dNww1D/IG1tu4htrnnI1BwIkHqhqs1zNLNOFjDu6YwI0qeWZdihXiHDEr5E15PMwL3pAWlYGG/edeGL6/3gPF3L0RKxSxr18MO90sv3N15AzNz2IDqx4SdilqURC7KNoRetnSg4tgbRxHwxrZYoRAx1JuDpBWWRokns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi+FBY7T; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi+FBY7T"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso20304465e9.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775246855; x=1775851655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTa3SMNP51BcljfrASeQns+9o2oJfvoBuCifvUwOAm0=;
        b=Qi+FBY7T3N+t9Z6zyYyUvToT2W2yH71BCPwTWhey5+NXD7bS1WOb7pIflMLgBATccf
         oUqBb//GKWACMjVeoXpHeDrGHCODJmsOr1ReJjA4hkQogb1luLXks+SQLgSOPWBRrDDB
         70o99J93FpAQqptCcxju1oyEb/jZUyJyIGF08T8Inn4Fu53VcZZs3k1EormV/97vHJxT
         eQwlFKwdsRaxqST4MRtR+EdLJEyxleFjMJQtQ9yT0t2ewh3i+Fb/HO83Q3OMFMH1tzAs
         1wJxeAItkG1+6dE3SlGLy9qWfADIXu1TTKxPrIPVDDjaHZ3+uJU7GtwEY288H+8uDJHt
         q0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775246855; x=1775851655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTa3SMNP51BcljfrASeQns+9o2oJfvoBuCifvUwOAm0=;
        b=kQI0lbxRPm1h+1c4wEZonokcXKg7Tt0GByzsw7UpJbcQLtAQ1y897qyDtKaEFV0xCL
         lfKE3yuLJ/ir2CDielax+qKd8PWeFGXg3SKsHqRw4LOev9Uj2Xn8IQ8JC+eq5IpQoFbY
         xT+qVQWuIRIyRDHSW5cKDSpMV28epuWDqWuPAiXFgRhljftd7Rs17nPiXY4Pe8gvbVcb
         uq3D7gSQdmc726yd3C5+wMZgTGltR20SfOQnggJ/Zb1An0e286k/Pl/rXN/9xvu0pVc7
         mSdDql5VL25vIWikGMYofnBDkVJPR+bP9rUe53oXiiVV4TlUyAj/m9GgBYlAGPWkB153
         Rl1A==
X-Gm-Message-State: AOJu0YzEs+K3TP2W322J+A7lpjoVkZxzfotiuoZMBWf1mqwRn1Lf+AgA
	3wlQB++Ie2rGv6fMO5n8q18UHDyxTVAQIvBRnV9f5KPcRhaidModmXOt
X-Gm-Gg: ATEYQzwjT5d/dbwKpyHODjuauPQUkk5iYEDYbveMi591xn5jrGflidnUJfAzb8VmY9a
	P5zy9F80Un7fQZrEEoNYeZLwqNiGiYsX+pT1vcMhuw5NK0sdwzv4E7CDtluYiJfLQAR9hZGSilr
	bnRpZo6hg4Kdd8afa5dU4HuZ0+qo8gPkUksQ61aAhPGv67KLPyAMkEdX5ey2Ll11YtQCE+gBhII
	HsPduG60r9YNOjTs6CUlNBkaAcQ92JqXKsBEWqCHQBOXbepBz8w9E+Qc02YjWcCd8em9xASRbZz
	eSABy9q2JkJKN7CTF1NKH6i4uQIBpC+XZJvempr4T4jMOhY0kL+AqXEXOW3XvyjUf0FrFmaJB4e
	cwQmn2c9XUDSHoL5Nh3HjoZkaQW5kSu7bSJUljxhJHpKqPknj0HPz1WXZq4slzrProRRCg0Bu6c
	sh9nwdDDsIl2JQd739FVWndY39wPPqEkU2tDXSdwy/p22fXGnupbxyviRwWzYqvCb2WtGU0dxBY
	tyz97qTCyJx
X-Received: by 2002:a05:600c:6290:b0:488:869c:ed9e with SMTP id 5b1f17b1804b1-488997c1c18mr70132855e9.23.1775246855414;
        Fri, 03 Apr 2026 13:07:35 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899d1c148sm43199695e9.5.2026.04.03.13.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 13:07:35 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] octeon_ep_vf: add NULL check for napi_build_skb()
Date: Fri,  3 Apr 2026 21:07:32 +0100
Message-ID: <20260403200732.497307-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

napi_build_skb() can return NULL on allocation failure. In
__octep_vf_oq_process_rx(), the result is used directly without a NULL
check in both the single-buffer and multi-fragment paths, leading to a
NULL pointer dereference.

Add NULL checks after both napi_build_skb() calls, properly advancing
descriptors and consuming remaining fragments on failure.

Fixes: 1cd3b407977c ("octeon_ep_vf: add Tx/Rx processing and interrupt support")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 .../marvell/octeon_ep_vf/octep_vf_rx.c        | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index b579d5b545c4..97b836c1f5d2 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -409,10 +409,18 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			data_offset = OCTEP_VF_OQ_RESP_HW_SIZE;
 			rx_ol_flags = 0;
 		}
-		rx_bytes += buff_info->len;
 
 		if (buff_info->len <= oq->max_single_buffer_size) {
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
+			if (!skb) {
+				oq->stats->alloc_failures++;
+				read_idx++;
+				desc_used++;
+				if (read_idx == oq->max_count)
+					read_idx = 0;
+				continue;
+			}
+			rx_bytes += buff_info->len;
 			skb_reserve(skb, data_offset);
 			skb_put(skb, buff_info->len);
 			read_idx++;
@@ -424,6 +432,30 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			u16 data_len;
 
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
+			if (!skb) {
+				oq->stats->alloc_failures++;
+				read_idx++;
+				desc_used++;
+				if (read_idx == oq->max_count)
+					read_idx = 0;
+				data_len = buff_info->len - oq->max_single_buffer_size;
+				while (data_len) {
+					dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
+							PAGE_SIZE, DMA_FROM_DEVICE);
+					buff_info = (struct octep_vf_rx_buffer *)&oq->buff_info[read_idx];
+					buff_info->page = NULL;
+					if (data_len < oq->buffer_size)
+						data_len = 0;
+					else
+						data_len -= oq->buffer_size;
+					read_idx++;
+					desc_used++;
+					if (read_idx == oq->max_count)
+						read_idx = 0;
+				}
+				continue;
+			}
+			rx_bytes += buff_info->len;
 			skb_reserve(skb, data_offset);
 			/* Head fragment includes response header(s);
 			 * subsequent fragments contains only data.
-- 
2.53.0

