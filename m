Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793668054;
	b=KWu/oNqQDqBAHTK51ZefyHTodKCRyzeZXkYWZxDwrqwqwjmQsBxrxOYDiU7gFRE00lnG
	 JaHT8bPWQoAys99A2o4gyW6q5J5/Y0cnErLMG1bIX0QNaXoegqnJXKrdG+2bwTXR1Rhli
	 lsP3vTov8Ed80mw6QIiC9jCBSqbkBCi6RfCssXfdt3C1KiXota6VSpn1+A888nkQPu7aH
	 r6SeXq7PYJ6JQ7vP5MpVywqGiPwHJf2vTyW8U4PXfXHJ9ftB4Zt97/gKW1wZ7EpCvjuOh
	 P70ebS+AbBb5eToIfMdatHmdcDV+HItkj1s+9Va7CBrRQ/jpZpn2sE0D2PMmhorAUKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793668054;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=rgRd2KV6kD1NlWNz1iQZ1uAx06L1PCjsN94PDtPnamo=;
	b=azsKv9KAMUgSupmW/gBDCjV3kcD/waHMQX/EAX9csUGCmOMvAU20YXL3LkhghXteryDU
	 tYepvvfnxdAhglDKDBOC0Dd7AzW+ZY6pGZ4+BVF9VA+sIIOB1yhe4x50xCg3zbkAypb8U
	 LqI/8Ge/Xtx+vGoEeoFdY1dR7WEJ9RSauAm4M/4243tNj4UxZjEAFG7frdGhTO99atCXj
	 Pmfe9GEnt/a9D3PZ5qPchJyO6D/TdpzVncI54KMvlC6ksdLVV5N6hgZ/0hZQGvLtyYJ98
	 YCQA8kWkAbMYaPM4JvXsRV+fjmgYKNM7JNacs1x1gNnsong22ZcDHlEWAEHcnG7x6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OVeXZpU1;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026DC606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 01:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 026DC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OVeXZpU1
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-833e671ee9fso3812947a34.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 17:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793668053; x=1794272853; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rgRd2KV6kD1NlWNz1iQZ1uAx06L1PCjsN94PDtPnamo=;
        b=OVeXZpU1pHTrFk6hsiE25uJUry6d6qqzgIE0wtg9KD/YQFUOwqgvq3Aklp3whw/D7a
         coaSsTCKbZWtg/VyITUwR3KFSPIsLkYqLcltyODOdJfyZyIttEZHMiTzPEGmCnMfRxCX
         6bhObHJAD+hf3sRkX3d841m+lvSce/MVB8vvrgl8+UfJWk2tM8uYxme771d7MWcXWU6R
         kR/45Aqx0x7bx54ellAqYc8Cf45ACFl5HE+ZHm/7ZwZfdf0WF/qtOhy6hyVFIik7L6w1
         offUDNAG9K6Msh0Gqjm3Oo/bCBKMlEaQY+9nwVpd2loyMZKHFcQAij0jsm7x0vrV9b4t
         BL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793668053; x=1794272853;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rgRd2KV6kD1NlWNz1iQZ1uAx06L1PCjsN94PDtPnamo=;
        b=K3kJp4kBWPQTz65vYn72dhZ6G1me0K3XjBlaWP/rJoa8SFzKI6lp0Bjg3eWoLlOcJV
         GsE1tEodRolONg5Zrnvs7UBqQ/E9m8IhlCCHvuAR55JLZiMmdOsHns/MXuGSUm92vNHj
         yZLHBEErtBzKYBX6sA+3EHS+TFBiNw1VOuOEkv1ptE9aTG64VZhmXb0FzBHJhvTMdFZC
         kWCgGd0UVzZcSlp2KCNa2wkxdxcD7OG6KV1Ye/puQ2RlVej35mUd7mSXryoa6Qb4odOh
         dsxwA14tKoIratabzNLEGhbxUSOV5yjg6rXcOY3MhBamcZ76JFTMR0EclbuQX85VgIK9
         5+1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxYdtBhwBUEBm2CjXJxfNMoys4eGsLreC213yNG+xDqoNAA9nrrddwcDTNwtwNmlF+PrQUviv4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlfbY3JjYI2Ff1a3dnmqNSJ3PHD0W+XseU9vNKdrxVf1LPoxQa
	7xHuIZlK640UZQqGGufUp5evyDxojZA4aLSNBbhobvM0YDd1stMieZdD
X-Gm-Gg: AYBFou1kdsDXLJ7xyMCYE/g4aFXKyCUF/svHYqAZK5TAcTtD9HVs+6LUeqH12AoYSd0
	WKjXuEOBSO1myNGIDgTBWQA600+ixGoPeJJOwWh3wvvrxLYZtTAqDU6nLXv7mnQDlu7BtHpC8zb
	k/KmH0xpyGDhaERawK2NAbgIjhHJ9CZAsRak/vhCGOyyN87Flq2Og6sq4lARLE900X7IyRPIdFw
	qA0CJgZaJp6tV0L8VKCpbE0ECrJeeii855XFM7KMXIbUbtFpsxfsBreHwjPD4RwaDzMQ5qVqCnA
	ERi/64qYCDX1Hj5WjOsgJwNnAuFVaa0vE6eRCN5mMaq6VlhzNEQy8WB6o9HiqfAQbSFyOJIj6p/
	gdSuOiT+3JcDOyp+PZJqATt4JidN/nTcIK6peMq+sqn34ZwmApGeEXTESSf7r8lZKo8s/4S7lGc
	T/YU/gYdXcuOmqdiOzyz2OV52lx97w1UEKus4OPE/LXYqakqycFh1CYRCmPRHzAD6Cuf0yeJa01
	UpqkmNE9IXNacrlyapW7ahVfkLLKzvYMd1jO1PPVhCx1fxPXLJxnov1VYxlKOj+7q2I/O1Rw38m
	ySM3z2Z4HS3tgg/7XGVvQmdcCD54Lsh1PExM58z4sIibtu4786RFOJGzEphMtqgGZPZNScIDQOE
	CePyf/Ej0ylZQ9WWO60FjRDH4ptQkaCZqHPcG/UJlwKFtnf5iWYoNL7+0l7o61bkNiIEVygNpqo
	oV2jde/fec/Xly9nWWoavRCv2cwSkiJwsohR0QfASdlDfWFR8D9h2/
X-Received: by 2002:a05:6808:f0d:b0:54c:d3dc:b544 with SMTP id 5614622812f47-5640de7a69cmr7834429b6e.32.1793668052739;
        Mon, 02 Nov 2026 17:07:32 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56523cdd0ffsm430286b6e.8.2026.11.02.17.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 17:07:32 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 02 Nov 2026 18:07:30 -0700
Subject: [PATCH net] net: stmmac: rebuild VLAN priority steering when
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
Message-Id: <20261102-submit-stmmac-vlan-prio-v1-v1-1-2b37767e4e08@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBA0auUWTuQCbWKVxEXMU50xKQlE0Oh9
 O7Gdvn/4i2gnIUVLt0CmauojKkFHTrwL5eejPJoDdbYgchY1O89SkEtMTqP9eMSTllGrIRnPob
 h1AeyhqABU+Yg84ZfIXGB2z4b8WZf/iys6w+XZMbbgwAAAA==
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

Reoffloading an existing cookie reuses its entry without incrementing the
rule count. Validate the selected RX queue before indexing the masks:
tc_classid_to_hwtc() checks the number of traffic classes, which can exceed
the number of RX queues.

Found by code inspection while working on STMMAC reset/recovery fixes.
Host-side tests exercising the driver's VLAN rule handlers and priority
callbacks with mocked MMIO reproduce the stale mapping after deletion
and pass with this fix. No hardware testing was performed.

Fixes: b3da86d432b7 ("net: stmmac: fix rx queue priority assignment")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |  2 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  2 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  4 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c    | 54 +++++++++++++++++++---
 4 files changed, 56 insertions(+), 6 deletions(-)

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
index 10b61fa2c27c..6707f7621f3b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -250,6 +250,8 @@ static int tc_rfs_init(struct stmmac_priv *priv)
 	if (!priv->rfs_entries)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD(&priv->vlan_prio);
+
 	dev_info(priv->device, "Enabled RFS Flow TC (entries=%d)\n",
 		 priv->rfs_entries_total);
 
@@ -685,6 +687,41 @@ static struct stmmac_rfs_entry *tc_find_rfs(struct stmmac_priv *priv,
 
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
@@ -700,7 +737,7 @@ static int tc_add_vlan_flow(struct stmmac_priv *priv,
 			return -ENOENT;
 	}
 
-	if (priv->rfs_entries_cnt[STMMAC_RFS_T_VLAN] >=
+	if (!entry->in_use && priv->rfs_entries_cnt[STMMAC_RFS_T_VLAN] >=
 	    priv->rfs_entries_max[STMMAC_RFS_T_VLAN])
 		return -ENOENT;
 
@@ -708,7 +745,7 @@ static int tc_add_vlan_flow(struct stmmac_priv *priv,
 	if (!dissector_uses_key(dissector, FLOW_DISSECTOR_KEY_VLAN))
 		return -EINVAL;
 
-	if (tc < 0) {
+	if (tc < 0 || tc >= priv->plat->rx_queues_to_use) {
 		netdev_err(priv->dev, "Invalid traffic class\n");
 		return -EINVAL;
 	}
@@ -724,13 +761,18 @@ static int tc_add_vlan_flow(struct stmmac_priv *priv,
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
@@ -744,14 +786,14 @@ static int tc_del_vlan_flow(struct stmmac_priv *priv,
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

---
base-commit: c3e67bd82b9b9b1a5118f09a429ccefe2aab0741
change-id: 20261102-submit-stmmac-vlan-prio-v1-8e5f674f1201

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

