Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4BF3921E9
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338890; cv=none; b=pXSxFjBo4EAkPRPXz0kanLqeYXJwVCRuhBAM83N65mJqyWfwDX8IEF72tztNIEpAxhB1QIF0sblcoTbaBlsPv37Rg0dDFI5R6ctXtggFiYZgxATPF0QLIH6oMvCVBQ6d63mhelFT/S1aXmFnEaNfzVjZjVcKkLr74jtBoIfaElE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338890; c=relaxed/simple;
	bh=Yet4Wu6a4CYkl8BKRHXPVopnFNuZBmvl9WJpXin0QFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4ED42qmhQs4ERP6TDOTDHVJqn/FPlmL3W/qeCMY1P4h7UPDS3MblehGZgQmyUkHaGhu/XVc85+uretgtIdtw8pfXTig0xASBT0kZSJG4sLu5wFO5hfmB9A1whpErxpPCiNgzghUkjxl9R0h5mELt/XV2nAVIQaeIm4c5e6dFhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=MLMfJ2EG; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MLMfJ2EG"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1230393a91.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338888; x=1786943688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KKaKhPv2i4NZwsaqUZdLqN5v0dUSAulY82bjWc13PCQ=;
        b=QJVfzBmCwqCZJBtxLRiNzqLitDfOZrX+fPt0AalCoWbFJVcCfp7gLEWjGI+Sy8nXJB
         Op9P+UqWSu0qTiREXvwHrsHdttHG8v+v/7lRywMqRNssrqGKRfeCdBMZGXWG4c/iR0SX
         jBGrHicpULtFP87e5d4HUatckoGEHWX2jz1QUlk+ZE1AXqljabjh/rvGBNqHjH4o08rd
         uhHPLEjkD7rYDUreKaTYfqFmX5eIr+NjnIcx2Cv1/x3S0kSd1QPskjCnKtwVCW+8iRBP
         MSCcI6FeS2P0OGhoIaA/H/ifDMAg6LkDhG7UJNNQMF5n/5WiSwIbeGgcBdx7Aw9GLChg
         qZTQ==
X-Gm-Message-State: AOJu0Yzs/0vokg2r2JgfuTh/Evbvuru39jIIYbBdNJSZLtrvkATKIOLS
	pK+T0oonmNzsi7do5EmTDDzHhp8hq3rfGod65nDEkdUI6AYoEZl+litpb3o4RD02dMUcS+w9Gm5
	P1wnOu04IC/PqiAoaZp5vTCkVyiPOzUj34KP7MmtOIu8dNC1Xt4/RF9omE/2HhtJg64LNBaIHZK
	OM1tuaeuXPPPzCSGQOYY0xQalmVGbfDpFk/+qnbu0fEfYQXLo+Mvw1Wk9UehqVo4cYhf3NVVgZF
	kjnHYT2goE=
X-Gm-Gg: AR+sD10ZOl8NNboV9dH9ZaVSErLCiHNyBtRgXKL94Ts/Cw6z3CXNyiaguSf1Z14xyae
	OvRz0V5SYUuy9DmL1+YrGyc62zRya0qRYkuwfgEWkfeuPkidsiBp79XukL9h7U0z45usM0Cd0fD
	CLksPmsuhDFiTViMgNXj+0FSt6D6oDFyHjO8Nc7YTPc6YHMFOPhh6x7QraeDpCWpMMWgu2j3vsj
	ByNGrl4wN76HUWuRfY7hUJEEsCU4PgJVS4b9RVdn+x06/bJg29RUJwKwMn9SgSCqx9+Hdri/ytq
	nWKSzdJJ/Dx9Xxk6S3SLSuP1o/9WfTy74iW8t62D82ctb2/JDIEudOwUvIEA5HqQgJo/1gg+qK7
	B6N+IQyKJBKFxA9npb5HAqkIH5Ic5tvWoi3X/LXtHJbOAEqNYhJZPnCqxIYBozi45hXBvQ7dH0a
	LiKmzL94fVgsIR73ZF2reqFEw71EeR8HQaqNc=
X-Received: by 2002:a17:90b:4e8d:b0:38d:ec31:4840 with SMTP id 98e67ed59e1d1-3903c5932femr42923169a91.13.1786338887731;
        Sun, 09 Aug 2026 22:14:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-392825e7e8asm4075326a91.10.2026.08.09.22.14.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:14:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8e934385db1so17097966d6.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338886; x=1786943686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKaKhPv2i4NZwsaqUZdLqN5v0dUSAulY82bjWc13PCQ=;
        b=MLMfJ2EGlvQJBDov+t+zmmsx9emZZ7KBjEIs2AcUKHeI0WNVIsf4Yzz/F+PT8xwgIu
         Ii6CCBJMsSZbnKtNxLsMidiJH5G18VYZVEF8JarmU07rPqTJbKrzwh+k+Cftkps5wAaQ
         oTTnvQnuWf3UemknP1F9SVO1EeIbAEBogSFbE=
X-Received: by 2002:a05:622a:614:b0:51c:164b:b240 with SMTP id d75a77b69052e-52ce5f61c7fmr406571711cf.4.1786338886298;
        Sun, 09 Aug 2026 22:14:46 -0700 (PDT)
X-Received: by 2002:a05:622a:614:b0:51c:164b:b240 with SMTP id d75a77b69052e-52ce5f61c7fmr406571551cf.4.1786338885712;
        Sun, 09 Aug 2026 22:14:45 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:14:44 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v6 03/15] bnxt_en: Set default MPC ring count
Date: Sun,  9 Aug 2026 22:13:46 -0700
Message-ID: <20260810051358.1244418-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810051358.1244418-1-michael.chan@broadcom.com>
References: <20260810051358.1244418-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

If the firmware supports MPC channels and CONFIG_BNXT_TLS is set, set
the default number of MPC channels.  These MPC rings will share MSIX
with the TX rings.  The number of MPC channels for each type must not
exceed the ethtool TX channel count.  When changing ethtool channels,
bnxt_calc_dflt_mpc_rings() will determine the default MPC rings for
the newly requested channel count and we call bnxt_check_rings() to
check before we commit.  bnxt_set_dflt_mpc_rings() will set the
committed MPC rings for the new committed channel count.

We also add bnxt_trim_mpc_rings() to make final adjustments in case
the number of reserved TX channels is less than expected.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v5:
https://lore.kernel.org/netdev/20260710042400.3996847-4-michael.chan@broadcom.com/

Improve the ethtool -L MPC calculation to use the actual MPC rings
during ring check.

Add a comment in the code to explain the bnxt_trim_mpc_ring() call.

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-4-michael.chan@broadcom.com/

Use proper int type for min_t().

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-4-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 11 +++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  8 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 72 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 27 +++++++
 4 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6debe20aec51..6946ddfb0c63 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -13219,6 +13219,7 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 		return rc;
 
 	bnxt_adj_tx_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
@@ -16771,6 +16772,7 @@ static void bnxt_trim_dflt_sh_rings(struct bnxt *bp)
 	bp->rx_nr_rings = bp->cp_nr_rings;
 	bp->tx_nr_rings_per_tc = bp->cp_nr_rings;
 	bp->tx_nr_rings = bnxt_tx_nr_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 }
 
 static void bnxt_adj_dflt_rings(struct bnxt *bp, bool sh)
@@ -16822,6 +16824,8 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		bnxt_set_dflt_ulp_stat_ctxs(bp);
 	}
 
+	bnxt_set_dflt_mpc_rings(bp);
+
 	rc = __bnxt_reserve_rings(bp);
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
@@ -16836,6 +16840,11 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		if (rc && rc != -ENODEV)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
 		bnxt_adj_tx_rings(bp);
+		/* Re-cap MPC ring counts against the reduced TX rings.
+		 * Any extra reserved MPC rings will be reconciled on
+		 * the next open.
+		 */
+		bnxt_trim_mpc_rings(bp);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bp->rx_nr_rings++;
@@ -16870,6 +16879,7 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 		goto init_dflt_ring_err;
 
 	bnxt_adj_tx_rings(bp);
+	bnxt_trim_mpc_rings(bp);
 
 	bnxt_set_dflt_rfs(bp);
 
@@ -17213,6 +17223,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * limited MSIX, so we re-initialize the TX rings per TC.
 	 */
 	bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
+	bnxt_trim_mpc_rings(bp);
 
 	if (BNXT_PF(bp)) {
 		if (!bnxt_pf_wq) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 88d879a27820..4bc3cac57b13 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -960,7 +960,7 @@ static int bnxt_set_channels(struct net_device *dev,
 	struct bnxt *bp = netdev_priv(dev);
 	int req_tx_rings, req_rx_rings, tcs;
 	u32 new_tbl_size = 0, old_tbl_size;
-	int mpc_per_type = 0, mpc_cp = 0;
+	int mpc_per_type, mpc_cp;
 	bool sh = false;
 	int tx_xdp = 0;
 	int rc = 0;
@@ -995,6 +995,10 @@ static int bnxt_set_channels(struct net_device *dev,
 		tx_xdp = req_rx_rings;
 	}
 
+	bnxt_calc_dflt_mpc_rings(bp,
+				 req_tx_rings * (tcs > 1 ? tcs : 1) + tx_xdp,
+				 req_tx_rings, req_rx_rings, &mpc_per_type,
+				 &mpc_cp);
 	rc = bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, tx_xdp,
 			      mpc_per_type * BNXT_MPC_TYPE_MAX, mpc_cp);
 	if (rc) {
@@ -1054,6 +1058,8 @@ static int bnxt_set_channels(struct net_device *dev,
 
 	bnxt_set_cp_rings(bp, sh);
 
+	bnxt_set_dflt_mpc_rings(bp);
+
 	/* After changing number of rx channels, update NTUPLE feature. */
 	netdev_update_features(dev);
 	if (netif_running(dev)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 9859a5f86268..26eef764c544 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -3,6 +3,7 @@
 
 #include <linux/stddef.h>
 #include <linux/types.h>
+#include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/bnxt/hsi.h>
 
@@ -45,3 +46,74 @@ int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 		return 0;
 	return mpc->mpc_cp_rings;
 }
+
+void bnxt_trim_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int max = bp->tx_nr_rings_per_tc;
+	u8 max_cp = 0;
+	int i;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		mpc->mpc_ring_count[i] = min_t(int, mpc->mpc_ring_count[i],
+					       max);
+		max_cp = max(max_cp, mpc->mpc_ring_count[i]);
+	}
+	mpc->mpc_cp_rings = max_cp;
+}
+
+void bnxt_calc_dflt_mpc_rings(struct bnxt *bp, int tx_nr_rings,
+			      int tx_nr_rings_per_tc, int rx_nr_rings,
+			      int *mpc_per_type, int *mpc_cp)
+{
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	int mpc_tce, avail;
+
+	*mpc_per_type = 0;
+	*mpc_cp = 0;
+
+	if (!BNXT_MPC_CRYPTO_CAPABLE(bp))
+		return;
+
+	avail = hw_resc->max_tx_rings - tx_nr_rings;
+	/* don't use more than 80% */
+	avail = avail * 4 / 5;
+
+	if (avail < (BNXT_MIN_MPC_TCE + BNXT_MIN_MPC_RCE))
+		return;
+
+	mpc_tce = min_t(int, avail / 2, tx_nr_rings_per_tc);
+	mpc_tce = min_t(int, mpc_tce, BNXT_DFLT_MPC_TCE);
+
+	avail = hw_resc->max_cp_rings - tx_nr_rings - rx_nr_rings;
+
+	if (avail < BNXT_MIN_MPC_TCE || avail < BNXT_MIN_MPC_RCE)
+		return;
+
+	mpc_tce = min(mpc_tce, avail);
+
+	/* TCE and RCE are sized equally, so the per-type count is also the
+	 * MPC CP ring count (max(mpc_tce, mpc_rce)).
+	 */
+	*mpc_per_type = mpc_tce;
+	*mpc_cp = mpc_tce;
+}
+
+void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int per_type, mpc_cp, i;
+
+	if (!BNXT_MPC_CRYPTO_CAPABLE(bp))
+		return;
+
+	bnxt_calc_dflt_mpc_rings(bp, bp->tx_nr_rings, bp->tx_nr_rings_per_tc,
+				 bp->rx_nr_rings, &per_type, &mpc_cp);
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++)
+		mpc->mpc_ring_count[i] = per_type;
+	mpc->mpc_cp_rings = mpc_cp;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index 7a7d81197ea6..6d50ca8c45ab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -17,6 +17,11 @@ enum bnxt_mpc_type {
 
 #define BNXT_MAX_MPC		8
 
+#define BNXT_MIN_MPC_TCE	1
+#define BNXT_MIN_MPC_RCE	1
+#define BNXT_DFLT_MPC_TCE	BNXT_MAX_MPC
+#define BNXT_DFLT_MPC_RCE	BNXT_MAX_MPC
+
 struct bnxt_mpc_info {
 	u8			mpc_chnls_cap;
 	u8			mpc_cp_rings;
@@ -37,6 +42,11 @@ void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
 void bnxt_free_mpc_info(struct bnxt *bp);
 int bnxt_mpc_tx_rings_in_use(struct bnxt *bp);
 int bnxt_mpc_cp_rings_in_use(struct bnxt *bp);
+void bnxt_trim_mpc_rings(struct bnxt *bp);
+void bnxt_calc_dflt_mpc_rings(struct bnxt *bp, int tx_nr_rings,
+			      int tx_nr_rings_per_tc, int rx_nr_rings,
+			      int *mpc_per_type, int *mpc_cp);
+void bnxt_set_dflt_mpc_rings(struct bnxt *bp);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -55,5 +65,22 @@ static inline int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 {
 	return 0;
 }
+
+static inline void bnxt_trim_mpc_rings(struct bnxt *bp)
+{
+}
+
+static inline void bnxt_calc_dflt_mpc_rings(struct bnxt *bp, int tx_nr_rings,
+					    int tx_nr_rings_per_tc,
+					    int rx_nr_rings, int *mpc_per_type,
+					    int *mpc_cp)
+{
+	*mpc_per_type = 0;
+	*mpc_cp = 0;
+}
+
+static inline void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0

