Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818306;
	b=KY3hkhtF09B1Ir0oPm+HOM5VhTD4b7DoscybEZPIt9jyyacnCcfePHktMNTJqmN5qnaR
	 SYiZigh9UbuXFT/dYCnka6idooQ342do0+k2m/LJGPA+a3aPlBBcqQls+uVwY1rmmNs0v
	 Ct19pDi9D0VizfLBSO+McYqhYF12qLRiPM0kPcwEAFJoHKOkrZMEGgJEnL1E433LWXLMO
	 YCGEkIQkxYqYmHjBsbWIUSejIvziv+wC3nVH1AG06dagJpQoIQsmZcB3wICWNBQjKOg+/
	 JNqLAOkjdK65qtdnFwKemgEnhfQ+wgCcWaOVBgiKRk4QuPC34ATRuKdjRTTKg1RL3KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=GxOsG1FNuod9bXhFvzMNlfoNfXOWS5qMBH+q+vk1SoE=;
	b=X6zvvmFmE2tjVdVS1T2p9pI4keZno3TokP8V4BxIkWStsa0msSh7efsoOHc2wywAEYTU
	 gKXFWpYi2SwfIhdA9AyBtx7j6wTGpXBy2FzmQhngHa5k2LelECVADHP226lQABoLN5oaB
	 sC1iU5PcjADXGVWpv73ZKwRvgFJWty8rrqfuFyCNX3kN0SIuG/uS4wn+mqnyqxKGQDOM5
	 cwKVJsHIaJ4sjhjiXLZc0d0JecITO/3hSVT7/GtMfVI7CYm7RARjvFhUrLDJMFIkhK04J
	 OuYk5P9b3K3+oMsCzfBtBOKOQHQOyL3JI8uwUtZRjoFpFWfW6qNnxmNmP/5c0DXFI2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VEq8MWFn;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DFE606D811
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04DFE606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VEq8MWFn
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-53c156ba662so544975b6e.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818305; x=1794423105; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GxOsG1FNuod9bXhFvzMNlfoNfXOWS5qMBH+q+vk1SoE=;
        b=VEq8MWFnZ89eQVqxi2LjalVk93IhZocmtSrtejj054zKt9zA/tuOf12Qe6y3MbR/sV
         RdlV+tige7q5ICSGHANAV0w2hZVqpnj9x0eEKyHyeFI5e33l+x598EMgs6zQxgigqQaF
         Sfa3LdhxiJpePdUgluAkxvTZenWktqkM1WY1u/X4EzVh0pwKo/waDHI3wjEbAU56HveF
         92NC4u1d06GZWKpAxL/6GpzpbFB0JJ4yNXPVw0992YJKgTdI+PRtDGYQPek75nHaS7sJ
         Nc96bPqYsMzVjdJ9FK1cKlwHSQAyDJsF/RqA2z2UBmI7zNrgqiTFVACJ/J/SThLY5WFy
         o9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818305; x=1794423105;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=GxOsG1FNuod9bXhFvzMNlfoNfXOWS5qMBH+q+vk1SoE=;
        b=TrbK9WALef8MOJ3ysvXRxBR7dBUX1t6ikMEfBzyHRXF03Qsd6h/R/8rdhmelr20OsY
         GAH5uM09ouAq5Qn5YFmXoPXaxRHRkIUT1X7B4cypDEJV8Wdlde3WIZLUc1/Y+2MMM2Lq
         nse54APMgaxHBGShUjyMKS4yL3k7mAFtudw+mBtr20vHDLPuPGwqdAdC42n1EfVsy1sR
         Zhrtt3s5hckEOhvaDN2/3guIVitpmA11t4isb0eftX+SJrzKbQGOFlHg9EdZRNUcD9wk
         smFla2DdeUkDUBU/n0Jt5F4t4e2ucPY84JGovyvqB5Nr82KOSxb88OijAGvrxIOZENHv
         Dl8w==
X-Forwarded-Encrypted: i=1; AKwUvBy44aIkW5tpN5IvbwYSOfStz+B+QwbeDtQfOPVbmP9eHt5SgUAobrGtd45c4i02Pnw8ExpLRbs=@vger.kernel.org
X-Gm-Message-State: APuU4Z89klaHNf8GYtzLNyTbNi+ujbCokmIPAczAMbwkVgqGvzoYCVBE
	JLC/DU0wIPs9fWpXmyOycs3LfA/nxjHgqxJIIU+5jcci9J4UgpuAqcXE
X-Gm-Gg: AYBFou1dpUZjagARP2l+PthHNlMINAK+m+fmjOp3EiU4mLjlxD3qcDL89zJjPi6ydtX
	yboHffgTJb/4ZizWdopOl+g+xOodcXMA+1XY5yeH/Jva1u67G2X/2dcpZv+fofNR/BdWiRIGjlG
	XCgUPoV2IlaOxqCQA4v5cIef/ZRi4WKsIoTytpWDabz2XiMtoZL6aGJ5ENT6TrlJd0QipdTxqSG
	lDyrAyUyiGOtFdVAfjyfEQ1ZjhfkvuNRaMHQGuIXFd+HkXu3LMsX4x8q1725yDnHREZ0xG84X5L
	spVKFpki7Mx0gLpDa0DO6TB8B1KFVFXTWEWHfQ9TqJC6lo3tK/MOuli+uDgsHnnBYPUYDbxspIi
	/9wLkm8oTjivRzDhisA1cPNAncVzjonrmp51JmliJARd5Fmvq2uYizl0/v6+OyjNrUxggMa5ZTr
	FqZk+d8Z6P6NzHSx7ca/QBhYuRUa1RUd48KuChcY/eezEqmB2bJGfqavruEjw58xipUNSLpq9sT
	PCnPW8cGzO4Ws+ZzJVh44eMn4iWuI5Bl3NadkgwvFvwSts22UYU6GEPkhMZ+ZLmRcZYf3qacp0i
	iuzAsPWEK4SpeChJm7ZBrZnvBWWe3/O7CRK8n5Zd3WmGLHiT3QEyQNALtL64fm5T/Y1iVIr6h9l
	YtPRR6IUy2d8rjj+qF5Ui17K3cIlYrYGKHtjzL9YgQA83FM2FPiTmx5j6Io4XrrR8VsGezh/Sru
	XccWYxCG6W152KBJo/6N/RT7ExAeqH93rAVXBlgNioqLA5HWZqMfxH
X-Received: by 2002:a05:6808:1b0a:b0:500:5e36:3a9d with SMTP id 5614622812f47-5640de79ad3mr10612422b6e.30.1793818304721;
        Wed, 04 Nov 2026 10:51:44 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9fdebe2sm2316003b6e.16.2026.11.04.10.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:51:44 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 04 Nov 2026 11:51:41 -0700
Subject: [PATCH net v2] net: stmmac: rebuild VLAN priority steering when
 filters change
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-submit-stmmac-vlan-prio-v1-v2-1-6cfc71e636ad@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ7CIBREr2L+WgxgLY0r72G6oPjbflOgASSap
 neX1guYzGYmkzezQMRAGOF6WCBgpkjeFSOPBzCjdgMyehQPkstaCC5ZfHWWEovJWm1YnrRjcyD
 PsmANXvpaVb2QXEABzAF7eu/wOzhM0P7CgniiSRt2q40Ukw+f/UIWe/mftSLBZHdWqlZYIW9ug
 9U0nYy30K7r+gWYNtDX2wAAAA==
X-Change-ID: 20261102-submit-stmmac-vlan-prio-v1-8e5f674f1201
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Piotr Wejman <piotrwejman90@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The RX queue priority callbacks preserve previously assigned priorities.
Passing zero from tc_del_vlan_flow() therefore leaves the deleted rule's
priority mapped to its RX queue. Clearing the whole queue instead would
also remove priorities belonging to other installed rules.

Save each VLAN rule's priority and rebuild the complete per-queue masks
after insertion and deletion, starting from the platform assignments.
Resolve overlapping platform masks with the same last-queue-wins ordering
used during initialization.

Make the GMAC4 and XGMAC callbacks replace the target queue's mask while
retaining their exclusion of its priorities from other queues. Program a
priority's new destination before clearing its previous assignment.

Keep VLAN rules in programming order. Flower installs a replacement under
a new cookie before deleting the old one, so the newer assignment must
remain effective while both are present, including when an earlier array
slot is reused. Removing a rejected replacement restores the older rule,
and removing the last override restores the platform assignment.

VLAN and EtherType rules share the RFS array. Preserve an existing cookie's
steering type and reuse its entry without incrementing the rule count, so
replaying a rule cannot unlink an EtherType entry or leave a retyped VLAN
entry on the list.

Validate the selected RX queue before indexing the masks:
tc_classid_to_hwtc() checks the number of traffic classes, which can exceed
the number of RX queues. When rebuilding the masks, skip rules whose RX
queue was removed by ethtool so they cannot suppress the platform
assignment or an older rule targeting an active queue.

Found by code inspection while working on STMMAC reset/recovery fixes.
Host-side tests exercising the driver's VLAN rule handlers and priority
callbacks with mocked MMIO reproduce the stale mapping after deletion
and pass with this fix. No hardware testing was performed.

Fixes: b3da86d432b7 ("net: stmmac: fix rx queue priority assignment")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes in v2:
- Preserve RFS entry types on replay in both the VLAN and EtherType
  handlers, keeping only VLAN entries on the priority list.
- Reuse installed EtherType entries without counting them again or
  rejecting them against their own capacity limit.
- Skip removed RX queues when rebuilding masks, retaining active
  platform assignments and older valid rules.
- Rebase onto net at 03897066069f.
- Link to v1: https://patch.msgid.link/20261102-submit-stmmac-vlan-prio-v1-v1-1-2b37767e4e08@gmail.com
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  2 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  4 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    | 97 ++++++++++++++++------
 4 files changed, 81 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 259e2ebed8c1..efbe2ec4c213 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -126,6 +126,7 @@ static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
 	 * clear them from others queues
 	 */
 	if (queue < 4) {
+		ctrl2 &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);
 		ctrl2 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
 						GMAC_RXQCTRL_PSRQX_MASK(queue);
 
@@ -134,6 +135,7 @@ static void dwmac4_rx_queue_priority(struct mac_device_info *hw,
 	} else {
 		queue -= 4;
 
+		ctrl3 &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);
 		ctrl3 |= (prio << GMAC_RXQCTRL_PSRQX_SHIFT(queue)) &
 						GMAC_RXQCTRL_PSRQX_MASK(queue);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1a88cbaed70c..7ad08651675e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -119,6 +119,7 @@ static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
 	 * clear them from others queues
 	 */
 	if (queue < 4) {
+		ctrl2 &= ~XGMAC_PSRQ(queue);
 		ctrl2 |= (prio << XGMAC_PSRQ_SHIFT(queue)) &
 						XGMAC_PSRQ(queue);
 
@@ -127,6 +128,7 @@ static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
 	} else {
 		queue -= 4;
 
+		ctrl3 &= ~XGMAC_PSRQ(queue);
 		ctrl3 |= (prio << XGMAC_PSRQ_SHIFT(queue)) &
 						XGMAC_PSRQ(queue);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index b76acfe0d958..fcc395321816 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/hrtimer.h>
 #include <linux/if_vlan.h>
+#include <linux/list.h>
 #include <linux/stmmac.h>
 #include <linux/phylink.h>
 #include <linux/pci.h>
@@ -210,6 +211,8 @@ enum stmmac_rfs_type {
 struct stmmac_rfs_entry {
 	unsigned long cookie;
 	u16 etype;
+	u8 vlan_prio;
+	struct list_head vlan_node;
 	int in_use;
 	int type;
 	int tc;
@@ -382,6 +385,7 @@ struct stmmac_priv {
 	unsigned int rfs_entries_cnt[STMMAC_RFS_T_MAX];
 	unsigned int rfs_entries_total;
 	struct stmmac_rfs_entry *rfs_entries;
+	struct list_head vlan_prio;
 
 	/* Pulse Per Second output */
 	struct stmmac_pps_cfg pps[STMMAC_PPS_MAX];
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 10b61fa2c27c..2ea3f433ff9b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -250,6 +250,8 @@ static int tc_rfs_init(struct stmmac_priv *priv)
 	if (!priv->rfs_entries)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&priv->vlan_prio);
+
 	dev_info(priv->device, "Enabled RFS Flow TC (entries=%d)\n",
 		 priv->rfs_entries_total);
 
@@ -685,6 +687,45 @@ static struct stmmac_rfs_entry *tc_find_rfs(struct stmmac_priv *priv,
 
 #define VLAN_PRIO_FULL_MASK (0x07)
 
+static void tc_update_vlan_prio(struct stmmac_priv *priv, u8 prio)
+{
+	u8 prios[MTL_MAX_RX_QUEUES] = {};
+	struct stmmac_rfs_entry *entry;
+	unsigned int queue, i;
+
+	/* Restore platform assignments with the same precedence as setup. */
+	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++) {
+		if (!priv->plat->rx_queues_cfg[queue].use_prio)
+			continue;
+
+		prios[queue] = priv->plat->rx_queues_cfg[queue].prio;
+		for (i = 0; i < queue; i++)
+			prios[i] &= ~prios[queue];
+	}
+
+	/*
+	 * Flower installs a replacement before destroying the old cookie.
+	 * Preserve the latest assignment while both rules are present.
+	 */
+	list_for_each_entry(entry, &priv->vlan_prio, vlan_node) {
+		/* The RX queue count may have been reduced with ethtool. */
+		if (entry->tc >= priv->plat->rx_queues_to_use)
+			continue;
+
+		for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++)
+			prios[queue] &= ~entry->vlan_prio;
+		prios[entry->tc] |= entry->vlan_prio;
+	}
+
+	/* Install the new assignment before clearing the previous queue. */
+	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++)
+		if (prios[queue] & prio)
+			stmmac_rx_queue_prio(priv, priv->hw, prios[queue], queue);
+	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++)
+		if (!(prios[queue] & prio))
+			stmmac_rx_queue_prio(priv, priv->hw, prios[queue], queue);
+}
+
 static int tc_add_vlan_flow(struct stmmac_priv *priv,
 			    struct flow_cls_offload *cls)
 {
@@ -694,13 +735,16 @@ static int tc_add_vlan_flow(struct stmmac_priv *priv,
 	int tc = tc_classid_to_hwtc(priv->dev, cls->classid);
 	struct flow_match_vlan match;
 
+	if (entry && entry->in_use && entry->type != STMMAC_RFS_T_VLAN)
+		return -EINVAL;
+
 	if (!entry) {
 		entry = tc_find_rfs(priv, cls, true);
 		if (!entry)
 			return -ENOENT;
 	}
 
-	if (priv->rfs_entries_cnt[STMMAC_RFS_T_VLAN] >=
+	if (!entry->in_use && priv->rfs_entries_cnt[STMMAC_RFS_T_VLAN] >=
 	    priv->rfs_entries_max[STMMAC_RFS_T_VLAN])
 		return -ENOENT;
 
@@ -708,7 +752,7 @@ static int tc_add_vlan_flow(struct stmmac_priv *priv,
 	if (!dissector_uses_key(dissector, FLOW_DISSECTOR_KEY_VLAN))
 		return -EINVAL;
 
-	if (tc < 0) {
+	if (tc < 0 || tc >= priv->plat->rx_queues_to_use) {
 		netdev_err(priv->dev, "Invalid traffic class\n");
 		return -EINVAL;
 	}
@@ -724,13 +768,18 @@ static int tc_add_vlan_flow(struct stmmac_priv *priv,
 		}
 
 		prio = BIT(match.key->vlan_priority);
-		stmmac_rx_queue_prio(priv, priv->hw, prio, tc);
+		if (entry->in_use)
+			list_del(&entry->vlan_node);
+		else
+			priv->rfs_entries_cnt[STMMAC_RFS_T_VLAN]++;
 
 		entry->in_use = true;
 		entry->cookie = cls->cookie;
 		entry->tc = tc;
 		entry->type = STMMAC_RFS_T_VLAN;
-		priv->rfs_entries_cnt[STMMAC_RFS_T_VLAN]++;
+		entry->vlan_prio = prio;
+		list_add_tail(&entry->vlan_node, &priv->vlan_prio);
+		tc_update_vlan_prio(priv, entry->vlan_prio);
 	}
 
 	return 0;
@@ -744,14 +793,14 @@ static int tc_del_vlan_flow(struct stmmac_priv *priv,
 	if (!entry || !entry->in_use || entry->type != STMMAC_RFS_T_VLAN)
 		return -ENOENT;
 
-	stmmac_rx_queue_prio(priv, priv->hw, 0, entry->tc);
-
+	list_del(&entry->vlan_node);
 	entry->in_use = false;
 	entry->cookie = 0;
 	entry->tc = 0;
 	entry->type = 0;
 
 	priv->rfs_entries_cnt[STMMAC_RFS_T_VLAN]--;
+	tc_update_vlan_prio(priv, entry->vlan_prio);
 
 	return 0;
 }
@@ -784,6 +833,8 @@ static int tc_add_ethtype_flow(struct stmmac_priv *priv,
 
 	if (match.mask->n_proto) {
 		u16 etype = ntohs(match.key->n_proto);
+		enum stmmac_rfs_type type;
+		u8 packet;
 
 		if (match.mask->n_proto != ETHER_TYPE_FULL_MASK) {
 			netdev_err(priv->dev, "Only full mask is supported for EthType filter");
@@ -791,32 +842,30 @@ static int tc_add_ethtype_flow(struct stmmac_priv *priv,
 		}
 		switch (etype) {
 		case ETH_P_LLDP:
-			if (priv->rfs_entries_cnt[STMMAC_RFS_T_LLDP] >=
-			    priv->rfs_entries_max[STMMAC_RFS_T_LLDP])
-				return -ENOENT;
-
-			entry->type = STMMAC_RFS_T_LLDP;
-			priv->rfs_entries_cnt[STMMAC_RFS_T_LLDP]++;
-
-			stmmac_rx_queue_routing(priv, priv->hw,
-						PACKET_DCBCPQ, tc);
+			type = STMMAC_RFS_T_LLDP;
+			packet = PACKET_DCBCPQ;
 			break;
 		case ETH_P_1588:
-			if (priv->rfs_entries_cnt[STMMAC_RFS_T_1588] >=
-			    priv->rfs_entries_max[STMMAC_RFS_T_1588])
-				return -ENOENT;
-
-			entry->type = STMMAC_RFS_T_1588;
-			priv->rfs_entries_cnt[STMMAC_RFS_T_1588]++;
-
-			stmmac_rx_queue_routing(priv, priv->hw,
-						PACKET_PTPQ, tc);
+			type = STMMAC_RFS_T_1588;
+			packet = PACKET_PTPQ;
 			break;
 		default:
 			netdev_err(priv->dev, "EthType(0x%x) is not supported", etype);
 			return -EINVAL;
 		}
 
+		/* Replaying a cookie must preserve its steering type. */
+		if (entry->in_use) {
+			if (entry->type != type)
+				return -EINVAL;
+		} else {
+			if (priv->rfs_entries_cnt[type] >= priv->rfs_entries_max[type])
+				return -ENOENT;
+			priv->rfs_entries_cnt[type]++;
+		}
+
+		stmmac_rx_queue_routing(priv, priv->hw, packet, tc);
+		entry->type = type;
 		entry->in_use = true;
 		entry->cookie = cls->cookie;
 		entry->tc = tc;

---
base-commit: 03897066069fd47caf2908183edf3b22b822ea73
change-id: 20261102-submit-stmmac-vlan-prio-v1-8e5f674f1201

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

