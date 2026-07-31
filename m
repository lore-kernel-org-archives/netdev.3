Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05C44CF44
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515852; cv=none; b=gzwEujrkMuWAUEYiNI6PAZ3jzrwXl8URxePW8jV1TRd39JpsJiG8/2r4G5uyvO4BRMkxyrkBe/9gc2qmBEIxGOFW0ubCkwocX6mC0lzfxLCotChZfJxJVcAWR7UAFbP2k7+yht/H1Qn6KECemsPmMMLIvBBH+PmZ1L0PkaRimgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515852; c=relaxed/simple;
	bh=O5fJQ3d6PuDgPKpL8e9OVHaXuQDovYEMEiNrPn9MFLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcSWqRxrwK3HmpyjEgKqX5C2fAuMspEGfkSTgRZKQDlTLDtCtFEgyWzuUo43ywWRLEZBw5lrScVuB6aZO8lj5L9XWgJ6tYISNtvZ/ZkvLA8c5aAC5IhWmkDyDMOGmHr5EqiDYjZ7ORAthZm8oDP7w3opFTGiO17d7RgfFzg3rFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NMdKNdC8; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NMdKNdC8"
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-81e69a2db34so18184827b3.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515849; x=1786120649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MmTQj4gHPMMZifdDZe2dPfuW/tp8ej1Qu6RBJZYcOCE=;
        b=ModohZp/ePtWD7c5R5UUUSiAv8XlYvBfWKQYCZ+o4EwbPIySsWguKtSnKWbfsBD8FG
         4OO4vy2towY8mBXZEg2Tzac7AP2ucc8XbQO6jnkzV4brLsjDNHufotxNLBg1kW9+k4ZV
         UJqZfHqxhCo00Xaku3MVvtLwcD6IfSeY4i6pOPmgbA2vrC9KRaQ1D8McaMMKX0OTbD2y
         4mQ5GK2G2M0HJJYZW3XsPAYyqOjsvtTMRmIJZzLaYJssSIJnZ33wrzx/JazVYp0JYemx
         RgIa+cdeNvIETX8RnysIT6BebG3bExsVF+zeD5vELogOsAZTVEmTVgoST026glb0ymNY
         MPsA==
X-Gm-Message-State: AOJu0YywiLqM1jy6W/PK21WZA5/yKNjJUd0NiLo3JINxeKgJpGxv4dYm
	PhBPT6Ti9IAm63OIeTjVlcwzuNfiSf7UPDDF2h8Z2LQHEex6+JyIFpE9ieXZNNgYiXwk7QYKQ5w
	FMirzhA19P9xNHgWxaFfSfJy/HGRSuRxJ1VNrMF/H2Zes5KDjC1wR1RGCo/RKdnscIR/wRmkS/D
	j9xntIeX7+0A54cSDlNlqV5k2+pUgpao8+LPFntOjOtq19AMFfvlD44Sip5dSJpV7pT/szuO7zp
	qRkNHtI3g==
X-Gm-Gg: AR+sD12gZZfOX8J3dlGxSou686g5iGnssGZ/IyJZv48RsRML+svGhs99sJaxq27HgmW
	chkHDJof9NIBAkVqSbpggPqjC6+Knh/El6qVQ7FzlHPnHwVyzhHNUNugPsrXLPPETwvv5hdTV6D
	JHXylaWqADSqLQ3f+gvhNhlQDh2CzQQxc/Z+Gdl+aaElVvCWq789uUsOfDz/xN7/p/BH12U9/2R
	M1IQBd/ffjyQyzrTlcpOqhlHwk3G2SPqKoJ0xwXYOQahwFuV8uMBWqnYD/zZN8sVtqGPxMk3fJT
	uoBQ0b7EQ8ohSNkNNXLHNVUaBsKym9d0961Wv+e1IfYm0UHvbXOUxDKjyuXVn0+IXHnN8z4HLyG
	NCnNx1K1GW0jtuvNE24Dkrv9YHNNPO3DCAx0KHVnejMTSDZUoKJd8+ok0FpdH31pGRSGNwnmWbi
	CfKb3+/bc8FEpYenmd7q7ajtiVFpnNCbGetA==
X-Received: by 2002:a05:690c:4b85:b0:81e:ac09:c89d with SMTP id 00721157ae682-81fd49bf6afmr7528547b3.4.1785515849035;
        Fri, 31 Jul 2026 09:37:29 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-27.dlp.protect.broadcom.com. [144.49.247.27])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-81fcd0fb905sm935377b3.26.2026.07.31.09.37.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jul 2026 09:37:29 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so1657284b3a.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785515848; x=1786120648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MmTQj4gHPMMZifdDZe2dPfuW/tp8ej1Qu6RBJZYcOCE=;
        b=NMdKNdC8K5AkAWbo7yab82YHFogSkSByHFCXfHJiiSwZolJ8JL4eaHNwbn60Sr19le
         zvZ5Fm0GwEJwUFS+yymgrbGwtwrcDVN8eCnyc/zHGz2jAhtEcHe+zllNxFVDEK12WDSL
         ll5OiqX6Y7Ou4LQwIH1axXVmGNSy71JhPNxI0=
X-Received: by 2002:a05:6a00:3cd2:b0:847:8b1d:230d with SMTP id d2e1a72fcca58-84ee482bb68mr331594b3a.3.1785515847761;
        Fri, 31 Jul 2026 09:37:27 -0700 (PDT)
X-Received: by 2002:a05:6a00:3cd2:b0:847:8b1d:230d with SMTP id d2e1a72fcca58-84ee482bb68mr331559b3a.3.1785515847125;
        Fri, 31 Jul 2026 09:37:27 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe57020sm690127b3a.17.2026.07.31.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:37:26 -0700 (PDT)
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
Subject: [net-next, v2 1/3] bnge: refactor rx mode helpers to accept explicit address lists
Date: Fri, 31 Jul 2026 22:07:10 +0530
Message-ID: <20260731163712.3463362-2-vikas.gupta@broadcom.com>
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

Rename bnge_cfg_def_vnic() to bnge_cfg_rx_mode() and update
bnge_mc_list_updated() and bnge_uc_list_updated() to accept
explicit netdev_hw_addr_list pointers rather than deriving
them from the netdev.

Add a snapshot parameter to bnge_cfg_rx_mode() to skip
netif_addr_lock_bh() when the caller provides a pre-snapshotted
list. On the open path (snapshot=false), the live netdev UC list
is passed and the addr lock is taken as before.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 39 +++++++++++--------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 6f7ef506d4e1..db0e616fc46c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2144,16 +2144,16 @@ static int bnge_hwrm_set_vnic_filter(struct bnge_net *bn, u16 vnic_id, u16 idx,
 	return rc;
 }
 
-static bool bnge_mc_list_updated(struct bnge_net *bn, u32 *rx_mask)
+static bool bnge_mc_list_updated(struct bnge_net *bn, u32 *rx_mask,
+				 const struct netdev_hw_addr_list *mc)
 {
 	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
-	struct net_device *dev = bn->netdev;
 	struct netdev_hw_addr *ha;
 	int mc_count = 0, off = 0;
 	bool update = false;
 	u8 *haddr;
 
-	netdev_for_each_mc_addr(ha, dev) {
+	netdev_hw_addr_list_for_each(ha, mc) {
 		if (mc_count >= BNGE_MAX_MC_ADDRS) {
 			*rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST;
 			vnic->mc_list_count = 0;
@@ -2177,17 +2177,17 @@ static bool bnge_mc_list_updated(struct bnge_net *bn, u32 *rx_mask)
 	return update;
 }
 
-static bool bnge_uc_list_updated(struct bnge_net *bn)
+static bool bnge_uc_list_updated(struct bnge_net *bn,
+				 const struct netdev_hw_addr_list *uc)
 {
 	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
-	struct net_device *dev = bn->netdev;
 	struct netdev_hw_addr *ha;
 	int off = 0;
 
-	if (netdev_uc_count(dev) != (vnic->uc_filter_count - 1))
+	if (netdev_hw_addr_list_count(uc) != (vnic->uc_filter_count - 1))
 		return true;
 
-	netdev_for_each_uc_addr(ha, dev) {
+	netdev_hw_addr_list_for_each(ha, uc) {
 		if (!ether_addr_equal(ha->addr, vnic->uc_list + off))
 			return true;
 
@@ -2201,7 +2201,8 @@ static bool bnge_promisc_ok(struct bnge_net *bn)
 	return true;
 }
 
-static int bnge_cfg_def_vnic(struct bnge_net *bn)
+static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
+			    bool snapshot)
 {
 	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
 	struct net_device *dev = bn->netdev;
@@ -2211,7 +2212,7 @@ static int bnge_cfg_def_vnic(struct bnge_net *bn)
 	bool uc_update;
 
 	netif_addr_lock_bh(dev);
-	uc_update = bnge_uc_list_updated(bn);
+	uc_update = bnge_uc_list_updated(bn, uc);
 	netif_addr_unlock_bh(dev);
 
 	if (!uc_update)
@@ -2226,22 +2227,28 @@ static int bnge_cfg_def_vnic(struct bnge_net *bn)
 
 	vnic->uc_filter_count = 1;
 
-	netif_addr_lock_bh(dev);
-	if (netdev_uc_count(dev) > (BNGE_MAX_UC_ADDRS - 1)) {
+	if (!snapshot)
+		netif_addr_lock_bh(dev);
+	if (netdev_hw_addr_list_count(uc) > (BNGE_MAX_UC_ADDRS - 1)) {
 		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 	} else {
-		netdev_for_each_uc_addr(ha, dev) {
+		netdev_hw_addr_list_for_each(ha, uc) {
 			memcpy(vnic->uc_list + off, ha->addr, ETH_ALEN);
 			off += ETH_ALEN;
 			vnic->uc_filter_count++;
 		}
 	}
-	netif_addr_unlock_bh(dev);
+	if (!snapshot)
+		netif_addr_unlock_bh(dev);
 
 	for (i = 1, off = 0; i < vnic->uc_filter_count; i++, off += ETH_ALEN) {
 		rc = bnge_hwrm_set_vnic_filter(bn, 0, i, vnic->uc_list + off);
 		if (rc) {
-			netdev_err(dev, "HWRM vnic filter failure rc: %d\n", rc);
+			if (rc == -EAGAIN)
+				netdev_warn(dev, "FW busy while setting vnic filter, will retry\n");
+			else
+				netdev_err(dev, "HWRM vnic filter failure rc: %d\n",
+					   rc);
 			vnic->uc_filter_count = i;
 			return rc;
 		}
@@ -2695,11 +2702,11 @@ static int bnge_init_chip(struct bnge_net *bn)
 	} else if (bn->netdev->flags & IFF_MULTICAST) {
 		u32 mask = 0;
 
-		bnge_mc_list_updated(bn, &mask);
+		bnge_mc_list_updated(bn, &mask, &bn->netdev->mc);
 		vnic->rx_mask |= mask;
 	}
 
-	rc = bnge_cfg_def_vnic(bn);
+	rc = bnge_cfg_rx_mode(bn, &bn->netdev->uc, false);
 	if (rc)
 		goto err_out;
 	return 0;
-- 
2.47.1

