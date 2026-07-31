Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79564455183
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515858; cv=none; b=ukFhSPukoQ88PB9WB04iAkgAieiDHiClHyIZsLAp6JJ5PQY0Zk7R8wC/SuPPugpbT8EVItHTZ26ZzzKXhaCklNuz8a83kJBdJxQu3nLu2s1DiwbjmsHWEUFrP97TrAEvOjcuOffhF5F2SAzIgKjO/Jj3vXHWaT0ACDbOmvMrwuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515858; c=relaxed/simple;
	bh=3C5AABexfvyCLkrRdDNz3236hDARiVl0H4YbD7IuVQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgWz5sYqRVTyatpxhZdoIXuXus2D3NElOWRcL1Ro9U8a6sZeNMQ1oHT7PNEltjWXs+C/xBEXCXZSFzP2PfLhOVnYx1oYIckruuRowmxs/8gXqyXKrd+OwFbq2MFdWIMM2IxG5LE97kGTbjoZSjzp8Tpsl+zMizbP6QfXLPXpBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xk4z9hld; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xk4z9hld"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2caced6038eso11677935ad.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515856; x=1786120656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O3+7vGCuus9kHQh7NOEwPhcHzmTaHtnsRvlJx5U3nw8=;
        b=ivCzE4O11KVSgz2jftooopIyUipkXt/8co6XOAnAgnnui2phshUjULPx7kiWNhOTL9
         zuKazPljdRgnr6JwNgUzDe7jd6lcBzUqbxr57ZiaCKIV7OFxgwj3EgdYHFKx5PMd+9Er
         Kqdo9a6r/SLy7GACvnsqV2K4wXshAGhlPIbwpufuBsMyynO8iqVJBQCuS6q5+hsmDsOA
         WZ6x4yo5M+0DgS04tvAz7IUv3soav0zIiQDGlqJ63iRgCrPQ4vJR1tJRPRnvQX9yPnsj
         V7bQmKOtvhSgg/7se8W/0VRcrWVGcVlZBca1ECfHsfoigpmY5AQWemcxg52UVvWTJl66
         X7QA==
X-Gm-Message-State: AOJu0YwVRj3+IVeRRYP3LLQykMpamvwpFAQ2tnwc3ztFk12dSObP70W6
	xyCi9+AkJ6YT7m3wWbsiDYamOOunRX8uNFfFYtuxlFgWfhJk+/2iw4N2UFIxpbCq/A2M5uXbmu6
	bTtpugX3IMHHG4HhUG4U3wecejIFfd7zTEhiSW0KcIXbUCUfm2oSktfZN2gN9e2uV44piGht5G1
	RvVdE8qTrJ2dcWxjNxtQOb7l/trIM3fGVE4eh5+GQLH2m/h/dycSM9h0BY2aV8dumrcfjBsgPBd
	tSToBHhyA==
X-Gm-Gg: AR+sD10dWI5c54C2/fMx3YoiO8bFNJ2qY8IWREjQYtxmmvvE/pjDEe/+OiG0hFHLUyH
	d5zUrCCA5kM8GJzXlDtH4uBtOl3y+0RqDFxRtOYml2zrlRn9Nv7cQoKhQ8+alzqRU/t9A8Qp+Le
	ywbyYBJfY4UgsPreJ8QbCy1ylaHF62y87oGmClffbwrtSDRWYg0B+CyZfLgzpwI3+r9WX3/O0Oh
	hFUVrANC24JWk+aXnivMsz1mxNkF0sF93HYW+GCDppphtVHAxv2/cStXZJFMgPeDS4yF2ll+rQc
	LDqSbzZosC6D8L/T7QI8BaT91VLEfeP0rr/hCfJAOd1Z+E24WmawbCPBncHAQsUhSP2Le35EP2N
	5o149/6gWaRedLE+p58wILLpFTc3KRNDWl4CrD4YqqWxEH8T2ZorlinOMT5SYTT5XJlSp9jbpkx
	o7zZc7Yq7XRCUIXUu++yS1mC3c+02pFdcOAg==
X-Received: by 2002:a17:903:2c06:b0:2cf:b23a:3e68 with SMTP id d9443c01a7336-2d047e9cee5mr23306325ad.25.1785515855326;
        Fri, 31 Jul 2026 09:37:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-3153ddbd8d1sm125604eec.11.2026.07.31.09.37.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2026 09:37:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e4ef486c7so1086427b3a.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785515853; x=1786120653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O3+7vGCuus9kHQh7NOEwPhcHzmTaHtnsRvlJx5U3nw8=;
        b=Xk4z9hldxtqOJL/7outM1IDQfJXZKsUS0Xn5RZPqMe3wms29cw2EzLmI6CxQv21lII
         IX4YPZHYBOATPAq0LrhlOnAGgMDADGU+FRBcGkrdb6pLj3pxzif29KcZ38Dzx4xUtFmF
         5cv+raJKJVdZ5OGvM3MIQc+VTnOWDJbnmevsA=
X-Received: by 2002:a05:6a00:2d0c:b0:848:55a6:fbe with SMTP id d2e1a72fcca58-84ee499d324mr244382b3a.35.1785515853069;
        Fri, 31 Jul 2026 09:37:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d0c:b0:848:55a6:fbe with SMTP id d2e1a72fcca58-84ee499d324mr244357b3a.35.1785515852598;
        Fri, 31 Jul 2026 09:37:32 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe57020sm690127b3a.17.2026.07.31.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:37:32 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [net-next, v2 2/3] bnge: add ndo_set_rx_mode_async support
Date: Fri, 31 Jul 2026 22:07:11 +0530
Message-ID: <20260731163712.3463362-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260731163712.3463362-1-vikas.gupta@broadcom.com>
References: <20260731163712.3463362-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Register bnge_set_rx_mode() as ndo_set_rx_mode_async to handle
unicast, multicast, broadcast, and promiscuous filter updates via
CFA_L2_SET_RX_MASK. The async variant receives pre-snapshotted address
lists from the kernel, allowing the driver to issue sleepable HWRM
firmware commands without holding the addr lock.

Move uc_update detection to the caller so the async path can compute
it directly from the snapshotted UC list before calling
bnge_cfg_rx_mode().

Handle -EAGAIN from bnge_hwrm_set_vnic_filter() and
bnge_hwrm_cfa_l2_set_rx_mask() on the open path by scheduling a retry
via netif_rx_mode_schedule_retry() rather than failing the open.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 67 ++++++++++++++++---
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  6 ++
 2 files changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index db0e616fc46c..d47eb9bc5b8d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2202,18 +2202,13 @@ static bool bnge_promisc_ok(struct bnge_net *bn)
 }
 
 static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
-			    bool snapshot)
+			    bool uc_update, bool snapshot)
 {
 	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
 	struct net_device *dev = bn->netdev;
 	struct bnge_dev *bd = bn->bd;
 	struct netdev_hw_addr *ha;
 	int i, off = 0, rc;
-	bool uc_update;
-
-	netif_addr_lock_bh(dev);
-	uc_update = bnge_uc_list_updated(bn, uc);
-	netif_addr_unlock_bh(dev);
 
 	if (!uc_update)
 		goto skip_uc;
@@ -2267,13 +2262,58 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
 		vnic->mc_list_count = 0;
 		rc = bnge_hwrm_cfa_l2_set_rx_mask(bd, vnic);
 	}
-	if (rc)
-		netdev_err(dev, "HWRM cfa l2 rx mask failure rc: %d\n",
-			   rc);
+	if (rc) {
+		if (rc == -EAGAIN) {
+			netdev_warn(dev, "FW busy while setting l2 rx mask in CFA, will retry\n");
+			vnic->rx_mask &= ~BNGE_RX_MASK_CFG_FLAGS;
+		} else {
+			netdev_err(dev, "HWRM CFA L2 rx mask failure rc: %d\n",
+				   rc);
+		}
+	}
 
 	return rc;
 }
 
+static int bnge_set_rx_mode(struct net_device *dev,
+			    struct netdev_hw_addr_list *uc,
+			    struct netdev_hw_addr_list *mc)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_vnic_info *vnic;
+	bool mc_update = false;
+	bool uc_update;
+	u32 mask;
+
+	if (!test_bit(BNGE_STATE_OPEN, &bn->bd->state))
+		return 0;
+
+	vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	mask = vnic->rx_mask;
+	mask &= ~BNGE_RX_MASK_CFG_FLAGS;
+
+	if (dev->flags & IFF_PROMISC)
+		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
+
+	uc_update = bnge_uc_list_updated(bn, uc);
+
+	if (dev->flags & IFF_BROADCAST)
+		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_BCAST;
+	if (dev->flags & IFF_ALLMULTI) {
+		mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
+		vnic->mc_list_count = 0;
+	} else if (dev->flags & IFF_MULTICAST) {
+		mc_update = bnge_mc_list_updated(bn, &mask, mc);
+	}
+
+	if (mask != vnic->rx_mask || uc_update || mc_update) {
+		vnic->rx_mask = mask;
+		return bnge_cfg_rx_mode(bn, uc, uc_update, true);
+	}
+
+	return 0;
+}
+
 static void bnge_disable_int(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -2706,9 +2746,13 @@ static int bnge_init_chip(struct bnge_net *bn)
 		vnic->rx_mask |= mask;
 	}
 
-	rc = bnge_cfg_rx_mode(bn, &bn->netdev->uc, false);
-	if (rc)
+	rc = bnge_cfg_rx_mode(bn, &bn->netdev->uc, true, false);
+	if (rc == -EAGAIN) {
+		netif_rx_mode_schedule_retry(bn->netdev);
+		rc = 0;
+	} else if (rc) {
 		goto err_out;
+	}
 	return 0;
 
 err_out:
@@ -3202,6 +3246,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
 	.ndo_get_stats64	= bnge_get_stats64,
+	.ndo_set_rx_mode_async	= bnge_set_rx_mode,
 	.ndo_features_check	= bnge_features_check,
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index d177919c2e11..476b5bab96fe 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -561,6 +561,12 @@ struct bnge_napi {
 #define BNGE_VNIC_DEFAULT	0
 #define BNGE_MAX_UC_ADDRS	4
 
+#define BNGE_RX_MASK_CFG_FLAGS				\
+	(CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS |	\
+	 CFA_L2_SET_RX_MASK_REQ_MASK_MCAST |		\
+	 CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST |	\
+	 CFA_L2_SET_RX_MASK_REQ_MASK_BCAST)
+
 struct bnge_vnic_info {
 	u16		fw_vnic_id;
 #define BNGE_MAX_CTX_PER_VNIC	8
-- 
2.47.1

