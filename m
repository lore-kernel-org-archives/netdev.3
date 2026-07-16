Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5161A345750
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183688; cv=none; b=s8CdnrU8yZiFQFcCv81RW6pn1A5yUrUkXL1t20EOOLMLpCecL6VqGEnLVVc+LHOY8X9K5LMXbwFjOzRJrh7B0bKjSoEUmIZ4vU5rzj94fUzBu9JbGatPAAr5OU0snOXIaKANipwmMOD1V1mBEBmZXoc0jTSR7iW/NPTmsOAEhLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183688; c=relaxed/simple;
	bh=cTQoP0lWlAxfFS21VMcXcV5AqjPUsdSmGaP2HtEb0nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a9JunnIR6WwYvScOXK6YCMvXH2AeS+CG/psOw9Rd8MLquZO5IFUJB8cRr8Z981p4gdb6SsGwdlorqarggsuIVd7aEFuAJT1rVzhocxJpUQh9P6/xdgTzrWe2Oyb0iDCvXQNzeX6t91VatDdYk7l++93kQ8VWYijE+8x6jZZs8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ec972UkW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ec972UkW"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84a2c90e383so199985b3a.0
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 23:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784183687; x=1784788487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SAC+WsEZ64mnrQj0pnVENutWORk+53oxQVLeMc2X3SA=;
        b=ec972UkWOzctDho/p8NFJV00QvG+UYuw+HgQOFyD3+kG6ywBNDM7Uk0jN1aMZ3LgiQ
         dFd6kRMaudmlFAfHIte7TJB6y4aEyO+vVN2IbxeRQBOolYOykKGoneAjxCOV+1211fLf
         QX1Th/5teYVviEsLycxIa4gDQgXEv2BppPDf7GW8jcqFxnsLiWkm4+tDyg9bhEGpiVFQ
         24jEEmlxVFkQfWQW5OCqPraC4Q1MVIyI69Xf+tBamonxTk3+3CYsmZtLkndACrcrktV4
         FhJgKLjFkgfowbJ78+e2NrqOwrK15AYgjca1nN1mVvEufM625wlsYt2+Vg0g3DbnxQ9n
         D5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784183687; x=1784788487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SAC+WsEZ64mnrQj0pnVENutWORk+53oxQVLeMc2X3SA=;
        b=CLX4tn7/299EU8g7B/XDIiJIofhqMLwjbZCP9iYQVhMGBJC/v/KbLSbo0vBBR2Qj2v
         ApiMomi/uujBeZPUd9OQP1sTj1H+plgB+2w1GIFeXNeQhz0MsJA9kM9HPg3uJC7iv6K7
         t/vtCHab4Fasbf3AgSfdrW07SrErimq0FUfMThLQ1f7ZoArnExlW5eTK+xgKfmFo4GN/
         gQjBfm2DW0h6jx/Pbh0dXBk+CzkQ7xpVmo/nyr7+DIZIQOX59Sl2yZac3+uY5+LtNggi
         r5vXBgCF3TCzhQR1LaXdVEakq9Ef3q/GvJPD0qnv6u8OKxp45BrnxNJEVZxTowoN/hrb
         aqqw==
X-Forwarded-Encrypted: i=1; AHgh+RoJ7GCVryq853+RoSMLOqNV1mpY2lR/c3MRqv0Op1/Y7x6kVYfjXCJPCzSK6bthgTqBFAt8pbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo/5IGh82vLmurN7eD3YOb1TcpfkQaxTP02yozyucph9WJ4ag/
	WdavZ9XrUeY389YxLMYVuZrH6auk2c350YfVa8yBaB/wGurAmy/5qGGm
X-Gm-Gg: AfdE7cn6XqR2VS+cl9WUYYan5CkDVyRZQ9oj/EL1hvRuvUyz0WEM/tf88FhijtXI6Xi
	+y0vj/PIOETsl9ZzUJOw0UFTgE2fg6L8qQsJ5U4ZdLYXvpUbIwiZuKaGgJJh1qa96uRBXk3EiFg
	kHG1xjpolC/NGf0PbudI1r2yMidxPaaWp6i+f3kVrcze+IIF3yuvby2d9NvOBBVsas5U0s6j/k1
	mnP4or3vQUXBVSWK49zrZ0eAzEybNlxiuBMKH+J9vGvieLnzIbVHJ3rkqcAYTBhjl2OUKP3Ei8b
	xCMZ04SemqM+PHqUPokLC1EeaKvjZt2Yrcfc8xE0y9UkyyKqNag0/igzTjtiO7OIxUGL1ZEYw0R
	1nCrXsh99EHtHfyVNX+JYK9+ZHF8Uys0r7KgkeSloSd8PjDM90Y09xHtQdBXR0uqFKBFO/9Xda/
	Lp2NLCB2CcX6fK2BngsilstAJmzYw=
X-Received: by 2002:a05:6a00:1250:b0:84a:32ba:a262 with SMTP id d2e1a72fcca58-84beb05714cmr1199736b3a.7.1784183686611;
        Wed, 15 Jul 2026 23:34:46 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f7dadcfsm4242172b3a.48.2026.07.15.23.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 23:34:46 -0700 (PDT)
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
Subject: [PATCH net v5 2/3] octeon_ep_vf: Fix RX page leak on napi_build_skb() failure
Date: Thu, 16 Jul 2026 14:34:31 +0800
Message-Id: <20260716063432.2908100-3-maoyixie.tju@gmail.com>
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

