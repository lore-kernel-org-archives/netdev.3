Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756175;
	b=BaM/8NDk/yfsmXguuI0DVRJIfN2S7VZC9QfprwDjzV6Ckj/Fv1G8kaBdWDUWFH1/cb8g
	 mBvoNkRg9EFiV40DGGrWhnr2LowqkJAyioB8+AxWg8btbfQK+XLT0exdNoDEzoCZTYzyr
	 TouZQFbdEg616fuU9LnUHGWd9cHRPI+VKpolf7+ue1W6YVLdGHmB+agDnO7oU6pTIVnoL
	 5Bn4oYF/7fSoPdffwOWw0IwdgVX218M0KcCBcW8mpnjSNu2oG6+E787FBHHSNoLFQO5Zj
	 ZAkH/FjlKRCckFjJTxWONE2U85Stu4kWGxcJIJm68U4DMJhTb5pSmVsf9DJG7quoEZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756175;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=GAC24OLY0Y1nAdH6NCIJXJvDYqD0c/SMa5E8X0eawBg=;
	b=THS9LtkztZm8FRerDdCoK94ia0WzwV4vY1ftkERfxy3F8Qy0xpRWdM0U5Wf1Q9AGr3Mp
	 isU2BQM3+Py1NDWV4CDXdZJgQgg/Zv3fOcKPY01Y/xXCVhHrk8NMOu3Eso7KjC3jCi+lv
	 I1kHupel/eBFesjNJcGraTCottLTfsx0pDPFlf2Y+NjBV5xWw5v5ZkNK4/MiMlUiOxu7X
	 By49gCAmFYP+xHv0FzlWZdnFY0+M/p7WCkj3Z4XxM/+znEdBEVYbNIQmiiKYo08GGOYDl
	 fMqwrbnxt2/Zmv3vJy/VvmnLT1f0Lt/hf8+flKDTljOCEv8quVamam4o5FYjd4003pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eKi9HXom;
	arc=none smtp.remote-ip=209.85.222.200
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CB606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 01:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C9CB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eKi9HXom
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cb93c874bso260904685a.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 17:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793756174; x=1794360974; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GAC24OLY0Y1nAdH6NCIJXJvDYqD0c/SMa5E8X0eawBg=;
        b=eKi9HXom1jzQHDi++4BhoU+PjYzuksmlc/bhrDksLQ8N38WhhZEupkeXxvZocRBziR
         fHWkVatJt1ZLAchLLmmSBOMYJECXm3XjxNJ6kSHGOxv5L7nd6FhWrO2vncIyxme/HUhz
         px+hQjAlt3qdDiA4wsBo9GIhqCl+RSz2kgbmpHP4+qNKXmY+Pls7f0M7RKwot8ASY3J8
         X5TEXJ66plHHW7NMz/Opbloi6GV67ACx55aax1bZdwVAETOt+Nn2jwmM/sptvo4McXYh
         TAZfSjym5j4wZSBvaF94jRE+ivS7NnZ2nDPTP3fybpiJ27WPCxkDJe67fqxv5m2yQbdL
         NA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793756174; x=1794360974;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GAC24OLY0Y1nAdH6NCIJXJvDYqD0c/SMa5E8X0eawBg=;
        b=qG6FOToHQLR3W0+R9qywWNJ95U00wRQkiMrGUStRuHp++BGoAqUzm1c10m44hFBLrf
         PVxij32bEK9o0RXYaus0bPHKDWgv8EfsOL1qe2GkWBKTNPd83oFbSeSRiVdL8MHC94Tm
         g6p5iXbNceegvXbPEfCV/0sHUrvcPmGdDdpBIfBdJSxXJ9wh2a//Ua9YXPhd+JW+1SE1
         NJcdJy68LG8YtHDeouxwA90mToHPKw5ihESdBNzJ6wl+XbjDW+K9Lh8DmzjTeCJ0nZPm
         2Y3h7oL7kH/eK/AzyFbT8ezvch/qHjGFmZaZnUw8Xn2OXZfCv3yAs1oGFHTs4pQq+yfg
         uSIg==
X-Gm-Message-State: APuU4Z/OPLqf7UUFCqgD/Dcqnc5SM1LYUcuEC457zgHb4N8KqWO+oQ3U
	+TRe9DFtscCOO9pQYeKCA58a9oXeRkZ3L3Qv5eIkPpY/aRs8MbvakeVHP8x66UmzWCFnZkPASF8
	SBeTnkWe4zXnl0S81Dz7yC5PAnQ==
X-Received: from qtnm25.prod.google.com ([2002:ac8:4459:0:b0:535:6bd2:134f])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5d8f:0:b0:535:22c2:f161 with SMTP id d75a77b69052e-542b742cdcbmr224703161cf.21.1793756173996;
 Tue, 03 Nov 2026 17:36:13 -0800 (PST)
Date: Wed,  4 Nov 2026 01:36:06 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261104013606.1527767-1-namangulati@google.com>
Subject: [PATCH iwl-net] idpf: fix Rx payload buffer leak when header buffer
 allocation fails
From: Naman Gulati <namangulati@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"

With header split, idpf_rx_update_bufq_desc() allocates the payload
buffer for a buffer ID first and its header buffer second. If the header
buffer allocation fails, it returns -ENOMEM and leaves the new payload
buffer in bufq->buf[buf_id]. idpf_rx_clean_refillq() then stops without
consuming the refill queue entry, and the next NAPI poll retries the
same buffer ID, again starting with the payload buffer.
libeth_rx_alloc() overwrites bufq->buf[buf_id], and the earlier payload
buffer is never returned to its page_pool.

Each such failure leaks one payload buffer. The pool's inflight count
never drops to zero, so when the queues are re-created or the device
goes away, the pool never finishes shutting down and
page_pool_release_retry() keeps warning about a stalled pool shutdown.

This happens when the header buffer pool runs dry while the payload pool
still has pages, for example under memory pressure: a header page holds
several header buffers and only goes back to its pool once the skbs
using all of them have been freed.

Release the payload buffer when the header buffer cannot be allocated,
as ice_alloc_rx_bufs() already does, so that the retry starts from an
empty slot. idpf_rx_page_rel() also clears the slot, so the buffer queue
teardown cannot release the buffer a second time.

Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth + napi_build_skb()")
Signed-off-by: Naman Gulati <namangulati@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 885df6294ad94..7383d8241ead5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3745,8 +3745,10 @@ static int idpf_rx_update_bufq_desc(struct idpf_buf_queue *bufq, u32 buf_id,
 	fq.truesize = bufq->hdr_truesize;
 
 	addr = libeth_rx_alloc(&fq, buf_id);
-	if (addr == DMA_MAPPING_ERROR)
+	if (addr == DMA_MAPPING_ERROR) {
+		idpf_rx_page_rel(&bufq->buf[buf_id]);
 		return -ENOMEM;
+	}
 
 	buf_desc->hdr_addr = cpu_to_le64(addr);
 
-- 
2.56.0.398.g882cbad275-goog

