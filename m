Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB6371885
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350151; cv=none; b=LlQhQIz0h8xJnUTN6Iq8Y2Njze43gcgSbd9EzUXyKGrb36rUhM1StPFISttn+7Vr/Uw9Ai2VyJvb4TMjuLcDduzo29CUx0m+G1JDm33aybpj1qaEfffM+4SWUJ7kx9NLppNMFQBSkDVDwg0SxbYEEbvpPwCWJ3ZAars1KKsLR8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350151; c=relaxed/simple;
	bh=cTQoP0lWlAxfFS21VMcXcV5AqjPUsdSmGaP2HtEb0nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZW+PLpdjWK4lZw0OLCVnavtO6mGsXu1X8AlRrwWQCFqgrV/RANOSF32UF1jEv8v9xzbsHgVIB2tYxNEkt2HEnCUoKFVXcaFE/4c1SQosch++xmb7LTI1UaavfR/NtU+nkDSt1YhaBeJ1ZpvduaTTzP1B4TrnTaA+fF/9LkE2IVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlRMMhFu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlRMMhFu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cace91f112so26360815ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783350150; x=1783954950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAC+WsEZ64mnrQj0pnVENutWORk+53oxQVLeMc2X3SA=;
        b=mlRMMhFuKfaeqOFkf0+zmm2W1xTuWYLksErrHvdS5W41hm4ITOBG3r198HwEnnfZxD
         arJJZuWmfBhmgz/OIc4phrZGRidcZl4lw2KH6VjeNRyE1YPxtHN5lxkYTGgCY0oYBFYk
         1DYPFG+p612IadOlKuV9xh9gwfTG+QaEIamoSewzMgvUyacYizchcdfoo3gd6EVb8UmL
         vkskIs2xLula2Utcdue37oSnkUqBNt2MUHGA/M1LwVsB12438F72YiOJdCoiERU9drOB
         WJyrf3D1gVZ3oqJIAazZm4wPh+Kr7Ng3l/Y2CaICbiHSAdlPm4+srK/h3yh3XzUylL5r
         jqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350150; x=1783954950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SAC+WsEZ64mnrQj0pnVENutWORk+53oxQVLeMc2X3SA=;
        b=ZE29R7R4dVJsHc8hGxSj4t7h6x48Ujvhr0RXad/7b/N9p9Oy+daC6Ky01pHELd/Rm/
         PwO7DDN91ahsgFSgRoW5fl6qkrk5LKseaZoeIrNtOJXat7dCXR3flaaoWlsxGuWEuBVm
         DvYqs5lkWy+wqsC/JIemXJ3wCnx1JOkZ7ruSSp33Ai32uQH8/zutUuphqPajYdMkCB+k
         g8bn4ZVTIhsuj9pAaJNX6wkJIMeQmMheOimQkq08BausnNHNKctKOp7HQiUpDa8bcHAL
         8gelz9kPvdhRWTMdXIHw+l0pGd3Mq9JKk0U5Zk4t5CzuK2YZhQBrsN7pBpM1df1hqbbk
         9Tqw==
X-Forwarded-Encrypted: i=1; AHgh+RqylX1pAL2dSsgWYFWb7dCqw5AoqJDqCAgZWlxuu6JJVjZ2BSrUjzSnFkqsO5M5iZq8A9wfN/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YztiF6TIG7BKvkEYJxCmqnDrB+TVMd0X14nrisb3v/3HoXdeT7X
	zD7pQSfBD047b5Fn53+yCD6D234ZHf2sejO/0c1WQKUZJny4lnRlFkh5
X-Gm-Gg: AfdE7cmjN12u4XHLj0zaRwWq9N17sHWrAAtP1v4TKG1HLzCxGKlrkEXobODuuU2QriU
	fA5XHRG+9dvshk2WgClZhFJ8NkqM5Ou+Y19lwnEkSq2ajOCMz5BW1l8xTdZoGG3pznDavRiStxB
	6qE3ST2uR72RRUgrVcT5MRnlfJVjfxLN/aadZl8o0uIN2+5khwZ8yPMHirQiE1TiWwlBk1szUoi
	GfxYpipIJdzynk3U+QpmcnaL/eDJ28EPgtSmC1RT2u7G7zaJf4QmEX48qy4EKH0Bx4AlrsltT4a
	E91Kbwhvl0H1P1lMZo+ofAVFuBJbM+/Y1kKnS7pLBnAE8LhRntpM7j5p3q+m5E2WiaUIpgR3RkG
	6+3xWPirFBDbj0GNea2Nb6JKeQf9FjqFa0ZZtpimy5e/qrSyier3oFagwb1WxirRJuUqHw2CNl6
	J7lWlOmdchhIAOCC+SHS0wrQubASHp77vBN8IXag==
X-Received: by 2002:a17:903:4b46:b0:2ca:d818:61e5 with SMTP id d9443c01a7336-2ccbed27acamr13150385ad.26.1783350148537;
        Mon, 06 Jul 2026 08:02:28 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cb3f5b7090sm41651765ad.26.2026.07.06.08.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 08:02:27 -0700 (PDT)
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
Subject: [PATCH net v4 2/3] octeon_ep_vf: Fix RX page leak on napi_build_skb() failure
Date: Mon,  6 Jul 2026 23:02:07 +0800
Message-Id: <20260706150208.2944898-3-maoyixie.tju@gmail.com>
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

From: Guangshuo Li <lgs201920130244@gmail.com>

__octep_vf_oq_process_rx() clears buff_info->page before building an skb
from the RX page. On the success path the page is consumed by the skb,
either as the skb head or as an RX fragment.

If napi_build_skb() fails, however, the page is not consumed by an skb.
The error path advances the descriptor and leaves the ring slot cleared,
so the page is no longer tracked and is leaked. In the multi-fragment
case, the remaining fragment pages are also unmapped and removed from
their ring slots without being released.

Release the head page when napi_build_skb() fails, and release each
remaining fragment page before clearing its ring slot.

Fixes: dd66b4285470 ("octeon_ep_vf: add NULL check for napi_build_skb()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
index d982474082..302559b16b 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
@@ -418,6 +418,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
 			if (!skb) {
 				oq->stats->alloc_failures++;
+				put_page(virt_to_page(resp_hw));
 				desc_used++;
 				read_idx = octep_vf_oq_next_idx(oq, read_idx);
 				continue;
@@ -434,6 +435,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 			skb = napi_build_skb((void *)resp_hw, PAGE_SIZE);
 			if (!skb) {
 				oq->stats->alloc_failures++;
+				put_page(virt_to_page(resp_hw));
 				desc_used++;
 				read_idx = octep_vf_oq_next_idx(oq, read_idx);
 				data_len = buff_info->len - oq->max_single_buffer_size;
@@ -442,6 +444,7 @@ static int __octep_vf_oq_process_rx(struct octep_vf_device *oct,
 						       PAGE_SIZE, DMA_FROM_DEVICE);
 					buff_info = (struct octep_vf_rx_buffer *)
 						    &oq->buff_info[read_idx];
+					put_page(buff_info->page);
 					buff_info->page = NULL;
 					if (data_len < oq->buffer_size)
 						data_len = 0;
-- 
2.34.1

