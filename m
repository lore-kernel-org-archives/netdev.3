Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4237BE6F
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791778597; cv=none; b=Gpv47TD4jyyCr4FjmI+EXg7flaw+p1btRc3/hrF4+Azq3UcGFTOrMqs95xhR1Svz4IG3PXx3bHIq+FOqdO0DmNUa7Rnd+1bjTf5XZkxBjXX3Vxnc89vIkZUuYYC+riEQXbuHz4wWLeaF9nVdPCU6iVAMLaBgQ3+sfcszKno7Xmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791778597; c=relaxed/simple;
	bh=YQaGRylIUdDFcPUitGbK2CzCGwIGvThJblHLN5RMhBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzIXgyg25LaOdY+S0DqmmP9SSymK8NvM0JJRpOUTqgbyPqXYqLn2uoz4tfWtDKZZ5yIVME6VaRai8uKKMOZ0uIb5LGNsOKHjbiLXy7SrHe79SToDeiU3+ZNZPGOFB/JC1WobVdaFNUZE3Z7P2NfiUR6ymYWTura+LYQGKJPFzqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=H8SmtG0U; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="H8SmtG0U"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2dd9cbb661bso10795205ad.3
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 21:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791778596; x=1792383396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=92mwmyUTtXBrrkUU1Kt+mlj6dDxLQ8K0k1LROD62i4E=;
        b=H8SmtG0UiKktKj4B45uJukiKVqdRyUgwcAHQEy8ZP4uhwBa3ymS2RAilbXfriPHtlI
         imAMPcsCszH+NnuP5GYQB52Q0j3tzQAKHsHbl0GUjOWcuzOggQaRSmoecD3eVuVIk+2P
         A6VjSA7QdmU9az5nbBKzrGtX70VHH9YF4I+0vR8FJCA4pt34MnWQJ4mAbis0X1FMy+y/
         orLQMUFx6AhZeIM1+lPqnZt3a/EFdW1W47Xe6mP75+LZo0hn2TZ5nribE8SJSSIbFYrP
         QzP753PZoBwm32fQrbqh3gK41oaEWxK7L6N3lkbRACK3RaYGfh2dVVPKklyJR3O/JOZK
         7bYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791778596; x=1792383396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=92mwmyUTtXBrrkUU1Kt+mlj6dDxLQ8K0k1LROD62i4E=;
        b=E0G3M5SJw/ow5OVqc8+ByJZUCTnzGe5ymu7QR/amODfpCtL53IkoqicDnRUTuwB3bS
         3nzru5Nuqz55bSuhtIVNz81GV77I9uRMWh4eti/J/do79EYoWScNxxawZNoRxMIqMbhI
         u2J1kfSmTr86wTJYOSbHpcJ5uHUQg0i8L5NNItV+I0ZhIgz3eK36Up23S7CBVZ3sUDHA
         6zc5/VtNsaGF40fsljpx0tGb/tRiKvPtm0qMU+sUKORjlnCN2A9Ugs8T/yO59cRBRf/o
         4iFvl1KI6QWjF85x9QCGb/8h5TDdzRIVCV6H5vQd7zrKJurtxgx45aMlj4n53zq7D/QA
         iKKg==
X-Forwarded-Encrypted: i=1; AKwUvBw/HmYRUlNhrnDSudHEjT0fi81VmU6EfcoM677uPDbfeZ9iFh5pipqVzq40u+FH3SghOTw2Hzo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9SN5jlizq++F42mRcPKin+eRj+Due5z08s9KPMan9W/lh0sPA
	MHqArnbctLSmLn60EIdgLq9IktFMKmNRgXdA7sJeOOzV81vDK0qzejzmZ1BXoSTSov4=
X-Gm-Gg: AYBFou3KzPvfaasEEO8tIoVWEO8M6UOo13d8pwT7bXZzSOUlDJ52RERP5+bA32dM2sZ
	lMPS3c4GBFx1wjSQPA7aLTSa9MTUbQZ+RcXyR4+BiF9CLuu4cruASYtxEqmNnKXWp8rHg8zLMkx
	NGofaQrtBEAJnwaqrhTskU/UFRAHk/8hxS0AfNnbA1/SSJV98z/uVTMNfGA7O468UTmWXAGz3uM
	APwL4eTrbZKrgUP+rckpnwFQ/LqYnttqBhlPPiYeGKTJIEnO3o5UQBjKk6sAEnApkvqiUXE7PUq
	o1fyidwq6KIV26rORA0q7U9zan165RJ/JLXnBFv4pfTWo9DLcAI8bBiOkHgMArewfHjYEBjsaUj
	K/Um4fIVUYtsNHND6CipNJ1S3R3PUIM2+4qwi9/+ubAVwkU+JDM49Mg3h/11RJE7fupkvpaWZDO
	PxxkAzhYCRCeHKznVI+ZtrvZyM2ovV8kcKfo1Ejx55OlKug5CzPR1RwL8GC0kb4ImZy0U1R5jiq
	9nvJzISJmh4JijI
X-Received: by 2002:a17:903:8c3:b0:2e4:a338:3658 with SMTP id d9443c01a7336-2e842bbf5bamr75162065ad.42.1791778595822;
        Sun, 11 Oct 2026 21:16:35 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8421af46asm38240025ad.39.2026.10.11.21.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 21:16:35 -0700 (PDT)
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
Subject: [PATCH net v3 3/5] eth: fbnic: return a pending Rx packet before reusing its buffer
Date: Mon, 12 Oct 2026 13:15:58 +0900
Message-ID: <dc2fd0f8b4ff068c3919444d7b4a88ad55e5831f.1791775409.git.yhlee@isslab.korea.ac.kr>
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

fbnic_pkt_prepare() starts a new packet on each header completion and so
far only warned when pkt->buff was still populated from a previous header
that no META completion had finished. The stale buffer, and any fragments
attached to it, were then overwritten and leaked.

Return the pending buffer to the page pool before starting over and clear
data_hard_start, so the META drop path does not release it a second time.
This leaks memory rather than crashing, so there is no oops to show.

Fixes: a29b8eb6e533 ("eth: fbnic: Add basic Rx handling")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 62 +++++++++++---------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 7dda59bba14ee..47ded7a9e0a81 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -1014,6 +1014,33 @@ static unsigned int fbnic_hdr_pg_end(unsigned int pg_off, unsigned int len)
 	return ALIGN(pg_off, 128) - FBNIC_RX_HROOM;
 }
 
+static void fbnic_put_pkt_buff(struct fbnic_q_triad *qt,
+			       struct fbnic_pkt_buff *pkt, int budget)
+{
+	struct page *page;
+
+	if (!pkt->buff.data_hard_start)
+		return;
+
+	if (xdp_buff_has_frags(&pkt->buff)) {
+		struct skb_shared_info *shinfo;
+		netmem_ref netmem;
+		int nr_frags;
+
+		shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
+		nr_frags = shinfo->nr_frags;
+
+		while (nr_frags--) {
+			netmem = skb_frag_netmem(&shinfo->frags[nr_frags]);
+			page_pool_put_full_netmem(qt->sub1.page_pool, netmem,
+						  !!budget);
+		}
+	}
+
+	page = virt_to_page(pkt->buff.data_hard_start);
+	page_pool_put_full_page(qt->sub0.page_pool, page, !!budget);
+}
+
 static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 			      struct fbnic_pkt_buff *pkt,
 			      struct fbnic_q_triad *qt)
@@ -1025,8 +1052,12 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 	unsigned char *hdr_start;
 	struct page *page;
 
-	/* data_hard_start should always be NULL when this is called */
-	WARN_ON_ONCE(pkt->buff.data_hard_start);
+	/* a new header while one is pending: release the old one */
+	if (unlikely(pkt->buff.data_hard_start)) {
+		WARN_ON_ONCE(1);
+		fbnic_put_pkt_buff(qt, pkt, 1);
+		pkt->buff.data_hard_start = NULL;
+	}
 
 	/* A buffer ID we never posted cannot name a buffer we own, so drop
 	 * the packet instead of running off the end of rx_buf[] or picking
@@ -1146,33 +1177,6 @@ static void fbnic_add_rx_frag(struct fbnic_napi_vector *nv, u64 rcd,
 	}
 }
 
-static void fbnic_put_pkt_buff(struct fbnic_q_triad *qt,
-			       struct fbnic_pkt_buff *pkt, int budget)
-{
-	struct page *page;
-
-	if (!pkt->buff.data_hard_start)
-		return;
-
-	if (xdp_buff_has_frags(&pkt->buff)) {
-		struct skb_shared_info *shinfo;
-		netmem_ref netmem;
-		int nr_frags;
-
-		shinfo = xdp_get_shared_info_from_buff(&pkt->buff);
-		nr_frags = shinfo->nr_frags;
-
-		while (nr_frags--) {
-			netmem = skb_frag_netmem(&shinfo->frags[nr_frags]);
-			page_pool_put_full_netmem(qt->sub1.page_pool, netmem,
-						  !!budget);
-		}
-	}
-
-	page = virt_to_page(pkt->buff.data_hard_start);
-	page_pool_put_full_page(qt->sub0.page_pool, page, !!budget);
-}
-
 static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
 				       struct fbnic_pkt_buff *pkt)
 {
-- 
2.43.0

