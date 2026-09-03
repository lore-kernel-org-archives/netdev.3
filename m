Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996E84D90D5
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 17:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788458291; cv=none; b=cRPJxSd06Qv/kjYrQlayYLgpa6LiS2Gp4+gzN7zEH2L6zDfpdV3yIL6WJEB94aSN8x5x0pnTsE7eoBQwzo6bZQj130zt22iKc3405yYb1QIYhhTuchH8n3n1t9a2bUSDA0gfBjADUt0pubVZ3M5uN2X8RGawGsbILJ4CleyI2oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788458291; c=relaxed/simple;
	bh=MQd71EoCe5ZjjRuiEfcCbInqnzuScdN3H253BhJPO4U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TE/LZJKg3JIZ2763wlvIXtBcEtQTqQOxiJnwZT4jvotl4Yat8Anowx/28sddELXK7049vD/7ASLBt2H6ILyG1HLK/7dx6nrr4yGrUuDF2WQEPn6ZaV20Iqx9ln+SrQfWz6zkxQVZ8wR38lNfDeI3xjigef9c4UDAJ/0mpNwSFrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJTsoNDV; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJTsoNDV"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1cb472b76so228044a12.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 10:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788458288; x=1789063088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7HfQZFdTYN3f+JvStxy6svA8B2kncUF/2jONtsH2XfI=;
        b=CJTsoNDVZSxR3OBxWlVs1uJBunBzIUBrCLJgy7dPQJr0DrYV2fXhN5WWLlYkk7ma8Q
         cTXc4uvxNT8+xkas48t2JfH9/T5P92cpzrFbUxb9mM/FAwy73hHz6qbsE7ERFl+7mjEY
         M+aieccInM04o9hqCRBtooJ2wmsuWdX+tdT/5Plo9aU3m0fhlJ1Bp/CTQRqO9TJllIrN
         ueGcyN0QhehkHVuFu4cwPs7lScx0EysUTJ1FiL/03/0oWwg1eSgFHdIkNP2BI1cc0u9Y
         eBJlfmUDS3wQumSPasICKYne3z4nW2ADHesSbJFSCJeUMwuPyXiZ9IEeKsBfgxtwd2gj
         +2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788458288; x=1789063088;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7HfQZFdTYN3f+JvStxy6svA8B2kncUF/2jONtsH2XfI=;
        b=JsVNoMNYPtL6lyiB/FI8HrkP3MiEy3zD95CSz/YX4Sp+yo5qX5KJv7ZNpKAIDf7ob7
         tue6si/y2M73v6Nbxw7mq/pK9eb/WAt4vmvd7sGnTR5Urid5sKQG9jl95hh5pk8sbnhu
         tZ5PI1IfVvt1FbccGuZVTN0SYm9MWN7A1gEB7nLSTmBdSymcDQZ9mlyIbkrDlZY7kWHw
         FR/ubVY8hu+eYNcT6on07ZxR6U0lHsAGxnO422X0ANKJmbvpkUG0ydc115qXBDz2SaCA
         IuaegxqGrTc0uyQQQEVDz/wjkH5gzRxXfrkMZV+8kzQ20ve1CU8UkPbEtzaPe/JsuWKH
         K6Xg==
X-Gm-Message-State: AFuF++kv9qH4tTJsRVTiIhan4uJgK165vsapU+ZJeB7sSnVody9Fi66M
	za0NW8VbGogZ+3sQc+KnPXFZX9M/zCQjhR2eTzcM26CB+GG1W3ar6jP9
X-Gm-Gg: AYBFou3MCdWpFSYZHEfEwn8+t6QqSdg5RiovL5UggsvJYR+Ag0Sbk0PkTltTrp0YjXV
	rTq6gtRrUt9402l1deed6yP767Ug0lKb4pQFHugmwNYDr6WgI9+Vs8vRElc7lTCesNeLAfum2p7
	+cfCd0XsIg44zGt5WgosV616sv3ooLbfONSIla42NbCwkiaxHIizJhq3VXN/wMR5FjDt2MPVrqL
	6Q7VbejkgK0gVRl8Yoq7da4+w3R4Fqwlzt9SX6TMZl3G/e6Po6hNasVpzqYokyByHWoVzuc8Nh7
	O2F5potpQu7aDbmYR7kD22n9ziTvsvAKrsnEXLIKft1MwS6HVzczjCuGAQicwYsrJOluyoqvEdW
	la+wMkbDxFcypTuXxopcFv2FNgICuvPrNECUMlzeuz9KV2VKBeiREj0OC+6ljyme7fRw3uuK9AU
	SJBvQM3NbcOPQYkd+ezq74w8hI8GzsXmZBwGhUNzfe2nL/BkIR4XY5ru/IveKtD1RIHUyumYJwj
	OVHsrJK+A4IBz18p4L9uzAbv95FJC+DIitkv0mTiURIZrqleSkWyzMov64pWE05o8VsET7wl7AR
	15TR7ovk
X-Received: by 2002:a17:90b:280b:b0:398:c315:fa6f with SMTP id 98e67ed59e1d1-39b261cfebdmr311141a91.14.1788458287756;
        Thu, 03 Sep 2026 10:58:07 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:4db7:e37c:a6be:f5bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08cacbb0sm6558902a91.13.2026.09.03.10.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 10:58:07 -0700 (PDT)
Subject: [net-next PATCH 2/2] fbnic: Remove BMC routing rules when the BMC
 channel is disabled
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Thu, 03 Sep 2026 10:58:05 -0700
Message-ID: 
 <178845828588.2787.8575380594560953372.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178845766796.2787.6001399537275460493.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <178845766796.2787.6001399537275460493.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

While a BMC is present the driver programs MACDA entries for the BMC
addresses, an action rule that steers matching traffic to the BMC, and
the DEST_BMC copy bit on the multicast/broadcast RSS actions. These were
only torn down when the host interface went down.

A BMC can instead disable its NC-SI channel while the host interface
stays up. When that happens the BMC filters are left in place, so the
host keeps steering traffic to a BMC that is no longer there and logs
"Found BMC MAC address w/ BMC not present" the next time the interface
goes down.

Detect the BMC going away in fbnic_bmc_rpc_check(), when bmc_present has
dropped but BMC tagged rules are still programmed, and remove the BMC MAC
entries and action rule. Also rewrite the RSS actions via
fbnic_rss_reinit() so the multicast/broadcast copies to the BMC are
cleared, then push the updated filters to hardware. The enable direction
is unchanged.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c |   81 +++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index bc0f38b6a2b2..8e53428e35a6 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -238,10 +238,91 @@ void fbnic_bmc_rpc_init(struct fbnic_dev *fbd)
 	act_tcam->state = FBNIC_TCAM_S_UPDATE;
 }
 
+/**
+ * fbnic_bmc_rules_present - is the BMC currently programmed into the filters?
+ * @fbd: Pointer to fbnic device struct
+ *
+ * The BMC tag is only ever set on a MACDA entry while a BMC is present, so its
+ * presence tells us the BMC routing rules are in place without having to keep a
+ * separate state flag.
+ *
+ * Return: true if any MACDA entry carries the BMC tag, false otherwise.
+ */
+static bool fbnic_bmc_rules_present(struct fbnic_dev *fbd)
+{
+	int idx;
+
+	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
+
+		if (mac_addr->state == FBNIC_TCAM_S_DISABLED)
+			continue;
+
+		if (test_bit(FBNIC_MAC_ADDR_T_BMC, mac_addr->act_tcam))
+			return true;
+	}
+
+	return false;
+}
+
+/**
+ * fbnic_bmc_rpc_disable - remove the BMC MAC and action rules
+ * @fbd: Pointer to fbnic device struct
+ *
+ * Undo fbnic_bmc_rpc_init(). The BMC can disable its NC-SI channel while the
+ * host interface stays up; when it does its routing rules must be torn down so
+ * we stop directing traffic to a BMC that is no longer there.
+ *
+ * Clear the MAC entries before the action rule. The action rule matches on a
+ * MAC entry index, so removing the entries first ensures the rule is never left
+ * pointing at an entry that is already gone. The hardware is updated by the
+ * __fbnic_set_rx_mode() call that follows this one.
+ */
+static void fbnic_bmc_rpc_disable(struct fbnic_dev *fbd)
+{
+	struct fbnic_act_tcam *act_tcam;
+	int idx;
+
+	/* Drop the BMC's claim on each MAC entry. An entry used only by the BMC
+	 * is deleted; one also used by the host is left in place.
+	 */
+	for (idx = ARRAY_SIZE(fbd->mac_addr); idx--;) {
+		struct fbnic_mac_addr *mac_addr = &fbd->mac_addr[idx];
+
+		if (mac_addr->state == FBNIC_TCAM_S_DISABLED)
+			continue;
+
+		__fbnic_xc_unsync(mac_addr, FBNIC_MAC_ADDR_T_BMC);
+	}
+
+	/* Then remove the action rule that steered traffic to the BMC. */
+	act_tcam = &fbd->act_tcam[FBNIC_RPC_ACT_TBL_BMC_OFFSET];
+	if (act_tcam->state == FBNIC_TCAM_S_VALID)
+		act_tcam->state = FBNIC_TCAM_S_DELETE;
+}
+
 void fbnic_bmc_rpc_check(struct fbnic_dev *fbd)
 {
 	int err;
 
+	/* The BMC went away while its rules are still programmed; remove them
+	 * now instead of waiting until the interface goes down. The enable
+	 * direction is handled by the need_bmc_tcam_reinit path below.
+	 */
+	if (!fbnic_bmc_present(fbd) && fbnic_bmc_rules_present(fbd)) {
+		struct fbnic_net *fbn = netdev_priv(fbd->netdev);
+
+		fbnic_bmc_rpc_disable(fbd);
+		/* Recompute the RSS actions so the multicast/broadcast copies
+		 * to the now absent BMC are cleared as well.
+		 */
+		fbnic_rss_reinit(fbd, fbn);
+		netif_addr_lock_bh(fbd->netdev);
+		__fbnic_set_rx_mode(fbd, &fbd->netdev->uc, &fbd->netdev->mc);
+		netif_addr_unlock_bh(fbd->netdev);
+		fbd->fw_cap.need_bmc_tcam_reinit = false;
+	}
+
 	if (fbd->fw_cap.need_bmc_tcam_reinit) {
 		fbnic_bmc_rpc_init(fbd);
 		netif_addr_lock_bh(fbd->netdev);


