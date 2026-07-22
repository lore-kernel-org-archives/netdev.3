Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAC941D137
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735515; cv=none; b=HTu3PjkOKHmDnwnUKg5pCGt3kmNhH+GpXDizzKvNs9kG1ptNxrLq1VMScq9eaR2fCdE41OcY2QZskzObVocYh2NBC26Wcwf9eiZMS37n5EXua+KynuVGUSXVElL2+JUS3Jt7ICJocLLGZQyZmat+XkyUNPFdQ7jzKl1PFCDNgfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735515; c=relaxed/simple;
	bh=cTQoP0lWlAxfFS21VMcXcV5AqjPUsdSmGaP2HtEb0nM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LfRblmEHlxNGt0Q6eSI8ZwA791z/F8R05s+k/wdFW1cmccHFby6bE8VB2OFH85jw0S91CYKFUMOfj4XW9HyBqzMvL4+gPyyNSUIpPsLqeplL29b6g6N4qpFvPCx0ct4B6ZbFtFSUe8XX9Z+yh62aB3/r5CN18Xwsm+hb+BTbJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8Z1RWkF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8Z1RWkF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so117832275ad.1
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 08:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784735511; x=1785340311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SAC+WsEZ64mnrQj0pnVENutWORk+53oxQVLeMc2X3SA=;
        b=g8Z1RWkFOiht2zK58jdP0GYPqXNst5miiQeltDBRxLzvareVhEVri7K8RRJpIw3vx1
         EwZ5awsB6HFh4ixUNjK2cRQtduiuGDaI2FLMu1HJljawjEaZSc27djqsmuOdhyyg065y
         aREuMStiBGPdoE0TWyzcqISdUXxLUOg26OIATYS41l2CM6otaI7gX9VqBXy/wNOpmpXE
         MDioWLz3uh3U8+N2Zz5V8p3L9jf5wBoj9aQWrYsOQe8PhHrOFfwOz3yat2sgNsJikN/4
         3UVVZgYuujconBfVvoYwzDoUlXQ3xbbGFpeDzVmSP0HM7UD/UxHEyr47fmJcltPDvbEZ
         9zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784735511; x=1785340311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SAC+WsEZ64mnrQj0pnVENutWORk+53oxQVLeMc2X3SA=;
        b=IUmJTm2+N/vGENZ/L41ibDtqD6eE5ZrTjpAkMxwUHmxs5hbBXY0IQzGgsAu+uS0Y5B
         QcIkyBE2D9Wl+r93pbZU5X/XZqMHZxv2IOKwlx43hSiGXUbdvdyq721yfeU03ucON1L0
         MCwqqml5xpE6cCttYvoc94AG3bqd/5RJlithZNf3+NWJKhHRN5Zs2PweJOdysMNpNbKI
         SkkNA2Xu4AlH9Akv+6rF6GrCFQxsasmAbADRoKgARyrZYIgWQZQ/Z6yzq22I2dAtw6l/
         kqeLYQIOc+2JxCRVTHvXfr/T7KZtov+pfzOuqDOc5uxUnTj620WXyoqQppvr6NBqAJ8h
         mkaA==
X-Forwarded-Encrypted: i=1; AHgh+RppQlGzhsOxn8KZd3SgqFa8BM4UGiPc4jXDoRH9UgxRb6/yKWvewAJyreBr/DSQQdaI4Jr1K00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9BoU07mVdUGXWk+E5KitfLbLskgYAr55akqTdhbqZ1Pine15X
	X330vWMOE0ZefCt6XPleyuskkrGPj/5CGIqx/07bkVEzAi7jaiRfhLJ0
X-Gm-Gg: AR+sD12PpQFNMHvdR4xX282ENHfcumEnWWRFhiRYjDpdhv8EhC3rAR73/oeRMwAq1A6
	861rjNcY94lA0DGRqiecExxzazx7aRp73O2kIkcDjwojnzhBYFC7gC7koI25GjVA/JRzKsUuonS
	2ZZWuxg6h5XUkpLBr6fMj8Sp+uziDedRbgoEALBJ7A1fDS7YftSsM9sKQ2/96rtIe/8W4KXZ6Fa
	BbNHU0UVy3qvUBsGvSh0OpRI4HWOWJyW7dz9PB5WFZkvHq9o8oYpRcqphHsM8weaiedTUbSXIo1
	nkIWtlUfVYonFsbSG7bMNqp2TIEqMe8USIanz4FLOyE/zVsrXNIe/jelVwUtMY5Dz9lHhbDI1Gv
	h3sx5rrrV4O9eGvlWMb0Kla1BC8obE8D5cD6DcBm/l262Afdv9gyVCv0BW9MfqGZCXMmuHtt4zY
	IoGnFJKqt35m43ofOZGEeob54jGS4=
X-Received: by 2002:a17:903:13c6:b0:2ce:b096:e517 with SMTP id d9443c01a7336-2cf3489548bmr257323065ad.5.1784735511158;
        Wed, 22 Jul 2026 08:51:51 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm11123125eec.17.2026.07.22.08.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 08:51:50 -0700 (PDT)
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
Subject: [PATCH net v6 3/4] octeon_ep_vf: Fix RX page leak on napi_build_skb() failure
Date: Wed, 22 Jul 2026 23:51:30 +0800
Message-Id: <20260722155131.2017597-4-maoyixie.tju@gmail.com>
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

