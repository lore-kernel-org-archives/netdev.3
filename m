Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2894AE134;
	Mon, 12 Oct 2026 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791824300; cv=none; b=gv07Rc4dC9hykRXuRfcOwWg/UKGPdvkDXoiapwDlyEY5MbgeHoHuMxnVJbN4V7PbJdxxOZQgBKvGnt62BZpLyl7QVTRLrU/36TNvVw9pgvruru+boOgMUtw3Opq9rj2HJ+E8wGQkyYI0B4+G1c6Ab6INQOeYYMS9eEwaVYbg7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791824300; c=relaxed/simple;
	bh=vUpcsez7CgnIpw4YbzcmYEoAjaaVFIIoSzz7dzlZask=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMs0VfX4mw1ED5shAH2BjUj8JtXX/8Ng8UNvUUIOQ91j5TJ8CtA9PNMQmmi+lLA13lbSuYHuvLkUFBTartYNSTXnkZZCQt7y6zbb3sm/dwXOh/+fNpMZBQy1tIsz5iVztC3iiOOE+gjPFosssx5nLMZ8nXnvxXK2W1DjH987/a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XAvIrLB8; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XAvIrLB8"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 8059AC0000E2;
	Mon, 12 Oct 2026 09:58:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 8059AC0000E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1791824285;
	bh=vUpcsez7CgnIpw4YbzcmYEoAjaaVFIIoSzz7dzlZask=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XAvIrLB8WPb2dhO7ruLj7EVjtdibmdrr58EzFVqeWjcL4o1tmuN3CO/KMS3qjMhYb
	 5BqNRYJmNn3TJoxovVy9M0YpQfQDKBk0Fx51T3hBR2IPXwD2sUJ++4jSbpvYdyxIki
	 rBs7R1u5OyRB6LozNuC3xRCkFrTjPZc42Tn7F7sU=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 7BDB1AEA2;
	Mon, 12 Oct 2026 12:58:04 -0400 (EDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v3 6/6] net: bcmasp: fix network filter lookup and wake filter pair allocation
Date: Mon, 12 Oct 2026 09:56:54 -0700
Message-Id: <20261012165654.3480668-7-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012165654.3480668-1-florian.fainelli@broadcom.com>
References: <20261012165654.3480668-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bcmasp_netfilt_get_init(), when looking up an existing filter (!init)
for a specified location, if the filter at loc was not claimed, the
previous loop continued searching higher indices and could return an
arbitrary unrelated filter belonging to the port. This caused flow get or
delete operations on an empty rule location to return or delete an
unintended filter.

Fix this by checking only the requested location on lookup and rejecting
RX_CLS_LOC_ANY when !init. In addition, harden wake filter allocation
and release by ensuring wake filter pair searches stay on even boundaries
where both entries are free, checking that loc + 1 is free for positioned
wake filters, and validating parity and bounds on release.

Fixes: c5d511c49587 ("net: bcmasp: Add support for wake on net filters")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 121 +++++++++++---------
 1 file changed, 70 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 972474893a6b..f41a79529f10 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -511,6 +511,13 @@ static int bcmasp_netfilt_wr_to_hw(struct bcmasp_priv *priv,
 	return 0;
 }
 
+static bool bcmasp_netfilt_is_companion(struct bcmasp_priv *priv, int i)
+{
+	return i > 0 && (i % 2) &&
+	       priv->net_filters[i].wake_filter &&
+	       priv->net_filters[i - 1].wake_filter;
+}
+
 void bcmasp_netfilt_suspend(struct bcmasp_intf *intf)
 {
 	struct bcmasp_priv *priv = intf->parent;
@@ -524,9 +531,7 @@ void bcmasp_netfilt_suspend(struct bcmasp_intf *intf)
 		    priv->net_filters[i].port != intf->port)
 			continue;
 
-		if (i > 0 && (i % 2) &&
-		    priv->net_filters[i].wake_filter &&
-		    priv->net_filters[i - 1].wake_filter)
+		if (bcmasp_netfilt_is_companion(priv, i))
 			continue;
 
 		ret = bcmasp_netfilt_wr_to_hw(priv, &priv->net_filters[i]);
@@ -556,9 +561,7 @@ int bcmasp_netfilt_get_all_active(struct bcmasp_intf *intf, u32 *rule_locs,
 		    priv->net_filters[i].port != intf->port)
 			continue;
 
-		if (i > 0 && (i % 2) &&
-		    priv->net_filters[i].wake_filter &&
-		    priv->net_filters[i - 1].wake_filter)
+		if (bcmasp_netfilt_is_companion(priv, i))
 			continue;
 
 		if (j == *rule_cnt)
@@ -583,9 +586,7 @@ int bcmasp_netfilt_get_active(struct bcmasp_intf *intf)
 			continue;
 
 		/* Skip over a wake filter pair */
-		if (i > 0 && (i % 2) &&
-		    priv->net_filters[i].wake_filter &&
-		    priv->net_filters[i - 1].wake_filter)
+		if (bcmasp_netfilt_is_companion(priv, i))
 			continue;
 
 		cnt++;
@@ -607,6 +608,9 @@ bool bcmasp_netfilt_check_dup(struct bcmasp_intf *intf,
 		    priv->net_filters[i].port != intf->port)
 			continue;
 
+		if (bcmasp_netfilt_is_companion(priv, i))
+			continue;
+
 		cur = &priv->net_filters[i].fs;
 
 		if (cur->flow_type != fs->flow_type ||
@@ -659,7 +663,7 @@ bool bcmasp_netfilt_check_dup(struct bcmasp_intf *intf,
 }
 
 /* If no network filter found, return open filter.
- * If no more open filters return NULL
+ * If no more open filters return error.
  */
 struct bcmasp_net_filter *bcmasp_netfilt_get_init(struct bcmasp_intf *intf,
 						  u32 loc, bool wake_filter,
@@ -669,45 +673,55 @@ struct bcmasp_net_filter *bcmasp_netfilt_get_init(struct bcmasp_intf *intf,
 	struct bcmasp_priv *priv = intf->parent;
 	int i, open_index = -1;
 
-	/* Check whether we exceed the filter table capacity */
+	if (!init) {
+		if (loc == RX_CLS_LOC_ANY || loc >= priv->num_net_filters)
+			return ERR_PTR(-EINVAL);
+
+		if (priv->net_filters[loc].claimed &&
+		    priv->net_filters[loc].port == intf->port &&
+		    !bcmasp_netfilt_is_companion(priv, loc))
+			return &priv->net_filters[loc];
+
+		return ERR_PTR(-ENOENT);
+	}
+
 	if (loc != RX_CLS_LOC_ANY && loc >= priv->num_net_filters)
 		return ERR_PTR(-EINVAL);
 
 	/* If the filter location is busy (already claimed) and we are initializing
 	 * the filter (insertion), return a busy error code.
 	 */
-	if (loc != RX_CLS_LOC_ANY && init && priv->net_filters[loc].claimed)
-		return ERR_PTR(-EBUSY);
-
-	/* We need two filters for wake-up, so we cannot use an odd filter */
-	if (wake_filter && loc != RX_CLS_LOC_ANY && (loc % 2))
-		return ERR_PTR(-EINVAL);
-
-	/* Initialize the loop index based on the desired location or from 0 */
-	i = loc == RX_CLS_LOC_ANY ? 0 : loc;
-
-	for ( ; i < priv->num_net_filters; i++) {
-		/* Found matching network filter */
-		if (!init &&
-		    priv->net_filters[i].claimed &&
-		    priv->net_filters[i].hw_index == i &&
-		    priv->net_filters[i].port == intf->port)
-			return &priv->net_filters[i];
-
-		/* If we don't need a new filter or new filter already found */
-		if (!init || open_index >= 0)
-			continue;
-
-		/* Wake filter conslidates two filters to cover more bytes
-		 * Wake filter is open if...
-		 * 1. It is an even filter
-		 * 2. The current and next filter is not claimed
-		 */
-		if (wake_filter && !(i % 2) && !priv->net_filters[i].claimed &&
-		    !priv->net_filters[i + 1].claimed)
-			open_index = i;
-		else if (!priv->net_filters[i].claimed)
-			open_index = i;
+	if (loc != RX_CLS_LOC_ANY) {
+		if (priv->net_filters[loc].claimed)
+			return ERR_PTR(-EBUSY);
+
+		/* We need two filters for wake-up, so we cannot use an odd filter */
+		if (wake_filter) {
+			if ((loc % 2) || loc + 1 >= priv->num_net_filters)
+				return ERR_PTR(-EINVAL);
+			if (priv->net_filters[loc + 1].claimed)
+				return ERR_PTR(-EBUSY);
+		}
+		open_index = loc;
+	} else {
+		for (i = 0; i < priv->num_net_filters; i++) {
+			/* Wake filter consolidates two filters to cover more bytes.
+			 * Wake filter is open if:
+			 * 1. It is an even filter
+			 * 2. The current and next filter is not claimed
+			 */
+			if (wake_filter) {
+				if (!(i % 2) && (i + 1 < priv->num_net_filters) &&
+				    !priv->net_filters[i].claimed &&
+				    !priv->net_filters[i + 1].claimed) {
+					open_index = i;
+					break;
+				}
+			} else if (!priv->net_filters[i].claimed) {
+				open_index = i;
+				break;
+			}
+		}
 	}
 
 	if (open_index >= 0) {
@@ -716,16 +730,20 @@ struct bcmasp_net_filter *bcmasp_netfilt_get_init(struct bcmasp_intf *intf,
 		nfilter->port = intf->port;
 		nfilter->ch = intf->channel + priv->tx_chan_offset;
 		nfilter->hw_index = open_index;
-	}
 
-	if (wake_filter && open_index >= 0) {
-		/* Claim next filter */
-		priv->net_filters[open_index + 1].claimed = true;
-		priv->net_filters[open_index + 1].wake_filter = true;
-		nfilter->wake_filter = true;
+		if (wake_filter) {
+			/* Claim next filter */
+			priv->net_filters[open_index + 1].claimed = true;
+			priv->net_filters[open_index + 1].wake_filter = true;
+			priv->net_filters[open_index + 1].hw_index = open_index + 1;
+			priv->net_filters[open_index + 1].port = intf->port;
+			priv->net_filters[open_index + 1].ch = intf->channel +
+							       priv->tx_chan_offset;
+			nfilter->wake_filter = true;
+		}
 	}
 
-	return nfilter ? nfilter : ERR_PTR(-EINVAL);
+	return nfilter ? nfilter : ERR_PTR(-ENOSPC);
 }
 
 void bcmasp_netfilt_release(struct bcmasp_intf *intf,
@@ -733,7 +751,8 @@ void bcmasp_netfilt_release(struct bcmasp_intf *intf,
 {
 	struct bcmasp_priv *priv = intf->parent;
 
-	if (nfilt->wake_filter) {
+	if (nfilt->wake_filter && !(nfilt->hw_index % 2) &&
+	    nfilt->hw_index + 1 < priv->num_net_filters) {
 		memset(&priv->net_filters[nfilt->hw_index + 1], 0,
 		       sizeof(struct bcmasp_net_filter));
 	}
-- 
2.34.1

