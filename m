Received: from cvsmtppost06.nm.naver.com (cvsmtppost06.nm.naver.com [114.111.35.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909854A3D42
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553891; cv=none; b=KsHIZJCefbrUWcvqEAL7eQwz+ZIJuDPEQKOPoEQzzI5rDqm+QedU9zqDaA+W69/7YAjvjcLrE+RD5cvMc0bzrdty2yUTvIsBBj7R/DHW43iP3juFLIMO/nhC8rjVilP1GZYWxG6USMC/wmv1BTQOYvK2eNTpruy1TSC/oMYQa5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553891; c=relaxed/simple;
	bh=8r3qyAGiiqPNdgH3PQHtgL/FMc98sMjUhb/Ody0PVjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WdTssoRLpZ/ztIyjhhi//bC/L046fyB5iNbl0pHcyGwfFhTSx1kO7rygphnKAvAVMiLSZjAzjeJp47U47xG1ivs2rA86Ijnb2X2Ii/2hrGyDONLkFXfx+umnR8jkgoyGbsXJScP7603E9YbPfChsPO7Yp1Zj3sU8fDEIJeXX5rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=gT/vmp+o; arc=none smtp.client-ip=114.111.35.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="gT/vmp+o"
Received: from cvsendbo031.nm ([10.112.22.37])
  by cvsmtppost06.nm.naver.com with ESMTP id PAEwGWlzTpiqEJX4u5rPFg
  for <netdev@vger.kernel.org>;
  Fri, 09 Oct 2026 13:51:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791553879; bh=8r3qyAGiiqPNdgH3PQHtgL/FMc98sMjUhb/Ody0PVjk=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=gT/vmp+ogUHvfGI/9O1L04DbLCTLJpeiOKwjjetO6S8zJIqcTLqNLb6qjBOtp2Kpb
	 wgoIMVPtTvTeleRznkKLl8usw4yNHQa+CW8CGaRZmS5GzOoacOMOvOze9/Y7Jz6wz0
	 ABiXsJqdhh7IQzq6z5adgUaG/z/N4fDb6PPLDBTlEJrQtGH5MkXFPNymsj5p+HDlF7
	 p0oLo/9I9WGxlNDfsaqb71mrL+bipnF5Qdy/R2c+gveNj7eRA74c3m5EdY4UGYfrZC
	 /2ZUGqAVqqn/MaJkR1muQ2zD/bIRcOeGA418mc1MrUxzz5XC3lvqSE0CdFmkE+k005
	 p/M6xrc+m2Bcw==
X-Session-ID: qeaE1moiQfCr+3UlCRMSLQ
X-Works-Send-Opt: OlRwpzGdjHmdKHFOMr39Ko3YKHmZjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: ldbZFxulFqJZ+HmlFqtw+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp005.nm.naver.com with ESMTP id qeaE1moiQfCr+3UlCRMSLQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Fri, 09 Oct 2026 13:51:19 -0000
From: Sung Byeongchan <tjdqudcks0424@naver.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: [PATCH net] macsec: reject frames after receive PN exhaustion
Date: Fri,  9 Oct 2026 22:51:08 +0900
Message-ID: <20261009135109.718408-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The receive SA replay state cannot represent the state after consuming the
terminal packet number.  For non-XPN, accepting PN U32_MAX leaves next_pn
wrapped to zero.  XPN has the same problem when the recovered full packet
number reaches U64_MAX.  A peer holding a valid key can consequently send a
distinct authenticated frame with the terminal PN and have it delivered
after that PN was already consumed.

Track the exhausted state explicitly.  Preserve the full recovered XPN in
the skb control block so that the post-authentication path can identify the
full-width terminal value.  Deliver the valid terminal frame once, mark the
RXSA exhausted under its lock, and reject later frames.  Clear the state
when the receive SA is initialized or its PN is explicitly reset, and
restore it if an offload update fails.

The unmodified kernel accepted a post-terminal authenticated frame in three
fresh boots for both non-XPN and XPN.  With this change, the terminal frame
was delivered once and every post-terminal frame was dropped in three fresh
boots.  Lower-word XPN wrap, replay-window, bad-ICV, reset, replacement,
and concurrent-duplicate controls continued to pass.

The demonstrated impact is limited to a receive replay-policy bypass by an
enrolled peer.  No memory corruption, information disclosure, privilege
escalation, or code execution was demonstrated.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
 drivers/net/macsec.c | 24 ++++++++++++++++++++++--
 include/net/macsec.h |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 78a19b1346321..ea542766e3d7c 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -142,6 +142,7 @@ struct macsec_cb {
 	u8 assoc_num;
 	bool valid;
 	bool has_sci;
+	pn_t xpn_pn;
 };
 
 static struct macsec_rx_sa *macsec_rxsa_get(struct macsec_rx_sa __rcu *ptr)
@@ -744,6 +745,15 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 	u32 lowest_pn = 0;
 
 	spin_lock(&rx_sa->lock);
+	if (rx_sa->exhausted) {
+		spin_unlock(&rx_sa->lock);
+		u64_stats_update_begin(&rxsc_stats->syncp);
+		rxsc_stats->stats.InPktsLate++;
+		u64_stats_update_end(&rxsc_stats->syncp);
+		DEV_STATS_INC(secy->netdev, rx_dropped);
+		return false;
+	}
+
 	if (rx_sa->next_pn_halves.lower >= secy->replay_window)
 		lowest_pn = rx_sa->next_pn_halves.lower - secy->replay_window;
 
@@ -804,8 +814,11 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 		}
 		u64_stats_update_end(&rxsc_stats->syncp);
 
-		// Instead of "pn >=" - to support pn overflow in xpn
-		if (pn + 1 > rx_sa->next_pn_halves.lower) {
+		if ((!secy->xpn && pn == U32_MAX) ||
+		    (secy->xpn && macsec_skb_cb(skb)->xpn_pn.full64 == U64_MAX)) {
+			rx_sa->exhausted = true;
+		/* Instead of "pn >=" - to support pn overflow in xpn. */
+		} else if (pn + 1 > rx_sa->next_pn_halves.lower) {
 			rx_sa->next_pn_halves.lower = pn + 1;
 		} else if (secy->xpn &&
 			   (pn + 1 == 0 ||
@@ -927,6 +940,7 @@ static struct sk_buff *macsec_decrypt(struct sk_buff *skb,
 
 		macsec_fill_iv_xpn(iv, rx_sa->ssci, recovered_pn.full64,
 				   rx_sa->key.salt);
+		macsec_skb_cb(skb)->xpn_pn = recovered_pn;
 	} else {
 		macsec_fill_iv(iv, sci, hdr_pn);
 	}
@@ -1409,6 +1423,7 @@ static int init_rx_sa(struct macsec_rx_sa *rx_sa, char *sak, int key_len,
 
 	rx_sa->ssci = MACSEC_UNDEF_SSCI;
 	rx_sa->active = false;
+	rx_sa->exhausted = false;
 	rx_sa->next_pn = 1;
 	refcount_set(&rx_sa->refcnt, 1);
 	spin_lock_init(&rx_sa->lock);
@@ -2388,10 +2403,12 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *tb_rxsc[MACSEC_RXSC_ATTR_MAX + 1];
 	struct nlattr *tb_sa[MACSEC_SA_ATTR_MAX + 1];
 	bool was_active;
+	bool was_exhausted;
 	pn_t prev_pn;
 	int ret = 0;
 
 	prev_pn.full64 = 0;
+	was_exhausted = false;
 
 	if (!attrs[MACSEC_ATTR_IFINDEX])
 		return -EINVAL;
@@ -2426,7 +2443,9 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		spin_lock_bh(&rx_sa->lock);
 		prev_pn = rx_sa->next_pn_halves;
+		was_exhausted = rx_sa->exhausted;
 		rx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
+		rx_sa->exhausted = false;
 		spin_unlock_bh(&rx_sa->lock);
 	}
 
@@ -2462,6 +2481,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 	if (tb_sa[MACSEC_SA_ATTR_PN]) {
 		spin_lock_bh(&rx_sa->lock);
 		rx_sa->next_pn_halves = prev_pn;
+		rx_sa->exhausted = was_exhausted;
 		spin_unlock_bh(&rx_sa->lock);
 	}
 	rx_sa->active = was_active;
diff --git a/include/net/macsec.h b/include/net/macsec.h
index d962093ee9237..57e9789ac75ef 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -136,6 +136,7 @@ struct macsec_rx_sa {
 	};
 	refcount_t refcnt;
 	bool active;
+	bool exhausted;
 	struct macsec_rx_sa_stats __percpu *stats;
 	struct macsec_rx_sc *sc;
 	struct rcu_work destroy_work;
-- 
2.43.0

