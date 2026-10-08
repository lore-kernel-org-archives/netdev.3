Received: from cvsmtppost31.nm.naver.com (cvsmtppost31.nm.naver.com [114.111.35.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11703E4117
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447966; cv=none; b=iEvLacaEV5uRlT5BYlPOiBb/J84Dg5mNxAE3PUci/rluB6ARR+YAkf8ZReIUkmgyNnqVhz6jbcS/A4tY/i1Tod73H3kcZqWBPz/+8oqIpoOYKO/t0USm9nqGhU9dfiEGUujtn2eekcupe5b29lik2adHgkVWl9ZytI3L2oJYpbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447966; c=relaxed/simple;
	bh=rd/WlOIap/FMgqq7jOhlr71RIQa75Ea/U1FIGj6hRuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W8hzewJd59CEGzsmWzlORDpllgHR/3fxl+Avc7sYA23ODbqupudKumADv1FBnt5fa0+MhbjanAAg5ju6j3DqT2g2+IJ3+/5CqPct+PLxGvC8/76mCdv3rZskAm1sHhEyer5bSd8hScIE/3kYXOS0y/khGUYQbQzCiFSQDWwkYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=HwUJ7Grc; arc=none smtp.client-ip=114.111.35.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="HwUJ7Grc"
Received: from mvsendbo37.nm ([10.179.40.219])
  by cvsmtppost31.nm.naver.com with ESMTP id AKczmAL-QCafv8fOZ6bSnA
  for <netdev@vger.kernel.org>;
  Thu, 08 Oct 2026 08:25:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791447957; bh=rd/WlOIap/FMgqq7jOhlr71RIQa75Ea/U1FIGj6hRuE=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=HwUJ7GrcBpgXj+oeOXwA7sus88UEKil9K0S5F4BkqLcga16Bz+bdYdCJz6mtZU8tT
	 ByaVqS4nd1CbRpn6VSB5esNQjuedWM7CzCwsUWJY572h7xRzc/nzB8wNXp9BojD6U3
	 D257u3NA1Ojr/z6wgJWD3O4R9pXoZ43rxooUijnIMOh7RyZCxhFExl2JKoqs5AQEDn
	 9/rA9NKdTALzNooP+L5kpSR1uPfbUxNYoeeRLjYkpBqSqr9FidVBQ4rrqK0P1wZKEv
	 pxXtEKf7FHA7fhTao41FQ5tUpLh7KZD2mE3R2vOffQQbUVtlH1TT/TmmMMzpwLw/4T
	 0dISeKexHl+XQ==
X-Session-ID: xGPvyf-dTEiaJv9owoAsbg
X-Works-Send-Opt: OlRwpzGdjHmdKHFOMr39Ko3YKHmZjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: XdbwFAulFqJZ+HmrFxE9+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp009.nm.naver.com with ESMTP id xGPvyf-dTEiaJv9owoAsbg
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 08 Oct 2026 08:25:56 -0000
From: Sung Byeongchan <tjdqudcks0424@naver.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: [PATCH net] macsec: reject replays after non-XPN receive PN exhaustion
Date: Thu,  8 Oct 2026 17:25:50 +0900
Message-ID: <20261008082550.349487-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a non-XPN RXSA accepts PN U32_MAX, advancing the receive PN cannot
represent the next value. The replay checks subsequently accept the same
authenticated terminal frame again.

Record receive-SA exhaustion after accepting the legitimate terminal frame
and reject subsequent frames until userspace explicitly resets the PN. Keep
XPN behavior unchanged. Preserve the exhaustion state if a hardware-offload
PN update fails and the old PN is restored.

The identical terminal-PN frame crossed the controlled port twice in all
three baseline runs. All three fixed runs rejected the replay. PN max-1,
fresh terminal-frame, and bad-ICV controls retained their expected
behavior.

The demonstrated impact is a replay and integrity-policy bypass. No memory
corruption or RCE/LPE primitive was observed.

This change was prepared with assistance from OpenAI Codex. I reviewed the
source change, test results, and this commit message.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Assisted-by: OpenAI Codex
Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
 drivers/net/macsec.c | 18 ++++++++++++++----
 include/net/macsec.h |  1 +
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 78a19b1346321..906108e10b32d 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -750,8 +750,10 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 	/* Now perform replay protection check again
 	 * (see IEEE 802.1AE-2006 figure 10-5)
 	 */
-	if (secy->replay_protect && pn < lowest_pn &&
-	    (!secy->xpn || pn_same_half(pn, lowest_pn))) {
+	if (secy->replay_protect &&
+	    (rx_sa->exhausted ||
+	     (pn < lowest_pn &&
+	      (!secy->xpn || pn_same_half(pn, lowest_pn))))) {
 		spin_unlock(&rx_sa->lock);
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsLate++;
@@ -813,6 +815,8 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 			rx_sa->next_pn_halves.upper++;
 			rx_sa->next_pn_halves.lower = pn + 1;
 		}
+		if (secy->replay_protect && !secy->xpn && pn == U32_MAX)
+			rx_sa->exhausted = true;
 
 		spin_unlock(&rx_sa->lock);
 	}
@@ -1252,8 +1256,9 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		bool late;
 
 		spin_lock(&rx_sa->lock);
-		late = rx_sa->next_pn_halves.lower >= secy->replay_window &&
-		       hdr_pn < (rx_sa->next_pn_halves.lower - secy->replay_window);
+		late = rx_sa->exhausted ||
+		       (rx_sa->next_pn_halves.lower >= secy->replay_window &&
+			hdr_pn < (rx_sa->next_pn_halves.lower - secy->replay_window));
 
 		if (secy->xpn)
 			late = late && pn_same_half(rx_sa->next_pn_halves.lower, hdr_pn);
@@ -1409,6 +1414,7 @@ static int init_rx_sa(struct macsec_rx_sa *rx_sa, char *sak, int key_len,
 
 	rx_sa->ssci = MACSEC_UNDEF_SSCI;
 	rx_sa->active = false;
+	rx_sa->exhausted = false;
 	rx_sa->next_pn = 1;
 	refcount_set(&rx_sa->refcnt, 1);
 	spin_lock_init(&rx_sa->lock);
@@ -2388,6 +2394,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr *tb_rxsc[MACSEC_RXSC_ATTR_MAX + 1];
 	struct nlattr *tb_sa[MACSEC_SA_ATTR_MAX + 1];
 	bool was_active;
+	bool was_exhausted;
 	pn_t prev_pn;
 	int ret = 0;
 
@@ -2426,7 +2433,9 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		spin_lock_bh(&rx_sa->lock);
 		prev_pn = rx_sa->next_pn_halves;
+		was_exhausted = rx_sa->exhausted;
 		rx_sa->next_pn = nla_get_uint(tb_sa[MACSEC_SA_ATTR_PN]);
+		rx_sa->exhausted = false;
 		spin_unlock_bh(&rx_sa->lock);
 	}
 
@@ -2462,6 +2471,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
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

