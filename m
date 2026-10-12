Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50666FC5
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778609; cv=none; b=mme8t+Kq67g8xq53BGhcmiD2fW0z/S5BNw+dkz0W7difPToxeUtrVAJbMlmcJ8VLfT2r1+co3ILD58lpKFYBMIDRklIHLl2C+qJjioCs4VZLZTzZwCiID4X1WwzSptSEJ5cVDUC7clYqr1fj6qP7hY69xZgsGUvKCL8dFMJPUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778609; c=relaxed/simple;
	bh=gSlfGsopcGf9FK8Zaap1vOZBQpbIoDFRmIjKXx13pc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaLyKRFLQI9WwVyLO45hO/B79agOC0v4pUIe7dpUU4F31OXoh14aVdLj0mbnGCeqpLQtTrDoUTsOZLpZZE3/X5FbfKMuubVDqmBrw+rbcHu+WDY49BcVf7hX8L8sQFHQyO1sRSxjegFbwHbeF6/vlM0zXV2GTHkD4RYrhHowf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=0evk00us; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="0evk00us"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8b20a899fso2972475ad.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 21:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791778607; x=1792383407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rP4KsK1HtGSJGS/ybx9BjunDk3siJwpiSOpuzBq9Cq8=;
        b=0evk00usViC3KOgz7hu/yjDo5ynT39w/hTcVoEa2GtNgPKLoj3mQjpveBsLiP/r1eP
         jhIYmefLcusQ0HREha6d/EqqFPT/aLj/xOAP6llBBmuQzTnVLWTm/thZe16cifLuB6B6
         XfghTVw8KzXQUtK+wueNQ1JM6JufydM7j5vup1NmjhbIqOkwjgahMH3M5lUuHLMKdtzd
         DOKi6DLGeec33Foif0U0V6eD+IIq7zbVU3ofxhsZ3LqpAhiB4t55A6IcISIAgImd5BuM
         pWEF9GjzziidVLXeVcfLzUe5VJBw7fNfwpfg/mwcthLAiBA0Iri1wWVpe+DyiVf1guvX
         hunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791778607; x=1792383407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rP4KsK1HtGSJGS/ybx9BjunDk3siJwpiSOpuzBq9Cq8=;
        b=CM/JxcyLWjYm1n7JyNhdxdvRpVH23O9tp3npgQzuDLF0Mz46hOb9xLT4HpSyjw99db
         qDsk/p1q8qxmuxNYxeT3Vwz+910rHcwJ97XUM/0oHxYESYUrpIahMIGUTl0GyluzBBKA
         RrgOwj63PSVGnXDQ1mVB6RCRNt9GvbRriO5stKkiPQfLn5eEggo2GV7GsbiV1Xuggytg
         coQ2cJ5fB8urBJoggwJLhw4J7suf5aygGs9csq/4jpRZDTPx01yJktGRzcE9DOIKoADO
         cbNX8NlRKtVlboTYJVsEpVFNvxKfriOBf3IfWWDTD8l4xFn4Om6eoqv1HFljRamxs1pd
         S4Zw==
X-Forwarded-Encrypted: i=1; AKwUvBycMCQAsCJqJ8cgb34cqLEEOzkGeUwpg/ytd1439yfX7AP2y4nX0gi6zWFEd74VEeDbV7/x5Ck=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5oZXzAE0OKIWzOBgaUwkujI/1mtywkN6AxLaAPMO86hLE/8V2
	t1PCIIDnTVCj/S80t4FxBBej7mg9OTs2D1aCexlepQ80ALCDQ0bR8QHw9dttpXxL2Rg=
X-Gm-Gg: AYBFou02KbvzWB3kPRdbldHEZafixuNAInp9+OzvXEqcYzpWBKe6ddKf7SH/S7FT1Cf
	onZFOOVAq1uQYMFkRrUFJiBIaf5TVJxVCTDV/EnJjL74ECsto6zs0S/IO3o7UN6pRsViEp46Z2d
	DUNOYu1Sqmt5nrJkjI8+t+1E5G19sctYYNbqtveUx+somFlGc/nfCCalqaBvMOnVXvqypte/H94
	5+OByH3FYT7iTQV2sE49PcN7HnW/byp17tmiI0b2CrYfGrpBVkRtOe3rDMJOC1BuwE+xbzztk53
	deTfV+g9w1chBvPZt5caI/K0Ggd+bYjxTEJSXz0czvwpYVBMzegmDuQ9aJR44ZueXOT2wUBZKyq
	fh5m3h1EISrvY9Czuy6TCtB4kLALwNOM/87mQy25BKmtF9g5B2g2o8zM1xLM7u1PNiRaTgKA2Zn
	ey3H6Ey+xYdedFSOuvFZJ2wbFJAK+UmkPVJud3mqlsJMKZGi7ld/n7eIPueIfBPE+ViNM4KLzs4
	Df2Hg==
X-Received: by 2002:a17:902:ec8f:b0:2e8:31ef:d24 with SMTP id d9443c01a7336-2e842bc2b36mr71098925ad.38.1791778606855;
        Sun, 11 Oct 2026 21:16:46 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421af46asm38240025ad.39.2026.10.11.21.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:16:46 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v3 5/5] eth: fbnic: bound the XDP Tx completion head to the ring
Date: Mon, 12 Oct 2026 13:16:00 +0900
Message-ID: <99790c3eceac9ac0bc9afbd90e8adb9789a08c50.1791775409.git.yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
References: <cover.1791775409.git.yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fbnic_clean_twq1() walks tx_buf[] from ring->head to the head the device
reports in the Tx completion (FBNIC_TCD_TYPE0_HEAD1_MASK, a 16-bit
field). head is masked to the ring, the device head is not, so a head
outside the 1024-entry ring is never reached and the loop does not
terminate; it keeps releasing the same buffers to the page pool. A head
that is inside the ring but past the posted tail walks over descriptors
from an earlier wrap and releases their pages a second time.

Return without cleaning if the device head is outside the ring or outside
the posted window, the way fbnic_clean_bdq() already guards its head.
fbnic_clean_twq0() masks the head difference to the ring and is finite;
twq1 did not, which this brings in line. A head equal to the tail is
accepted, as fbnic_nv_flush() passes the tail to drain the whole ring.

  Oops: general protection fault, probably for non-canonical address
  0xfbd59c000000002b: 0000 [#1] SMP KASAN NOPTI
  KASAN: maybe wild-memory-access in range
  [0xdead000000000158-0xdead00000000015f]
  RIP: 0010:page_pool_return_netmem+0x2a/0x3f0
  Call Trace:
   <TASK>
   fbnic_clean_twq1.isra.0+0x20c/0x410 [fbnic]

The loop was exercised by passing a crafted completion head to
fbnic_clean_twq1() under KASAN; no hardware is involved. On a kernel
without soft-lockup detection the repeated release trips a page_pool
use-after-free before the loop is otherwise noticed.

Fixes: cf4facfb132a ("eth: fbnic: Add support for XDP queues")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 7a9bd91bcc41c..3a148eb4e560f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -661,6 +661,12 @@ static void fbnic_clean_twq1(struct fbnic_napi_vector *nv, bool pp_allow_direct,
 	u64 total_bytes = 0, total_packets = 0;
 	unsigned int head = ring->head;
 
+	/* bound the device head to the ring; see fbnic_clean_twq0() */
+	if (unlikely(hw_head > ring->size_mask ||
+		     ((hw_head - head) & ring->size_mask) >
+		     fbnic_desc_used(ring)))
+		return;
+
 	while (hw_head != head) {
 		struct page *page;
 		u64 twd;
-- 
2.43.0

