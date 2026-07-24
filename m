Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6350E43CE74
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903440; cv=none; b=uTa2GfhX/iXl5m93arWvrPRRsrU8tWMcdUDBzZl9IcYJw562ASUO72hC93vwqcjlnVqGJuy5bYkz9NtvOgSsbDsmmQuXkTC0PvKRKvMX5AEBzU7psZCRGJy/QTQUWB/kxB4iSY+gkpPX2BzAj+MbH2cd8kdsCos3FzthjDxYdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903440; c=relaxed/simple;
	bh=4ehvwSaEiXVBlRUd5vewS2RGvirgocMw5uBi835Hx9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZontcLFduHMl/0VjkoB2UeTmwYwrN99wZOvw1xacBVwxXYCNNaZV/NUnJgMzmPxhmkm51soDxMA51N08GEyR3TfH3QA7X+tRE0NmjbrZxZKOkVf9W5bwVXunqFXvR+493lFtNywFdYXxDH+/kERpuAqQ6qmPpxpjDBAlYvDxU+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZYMeRiI0; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZYMeRiI0"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-5276d598b96so3621511cf.3
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:30:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903438; x=1785508238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+PfAlfX3vpEZCie4PFwUObkKJIDKS93e86I5c2uPjRs=;
        b=XjQK5hdOvIRBxD9g45pJaZO8scRpccNeWWLFus1m+g9M/S5yQXqDHc45/Os8ENoyt2
         CD01C+kIzPlZVNPwtph0dzO3MJqpb8f+esY6mLCl7M81k2MneNjQRG4bTPnLsEVivi6Y
         903bt/pk79gsmH4zFeFEZ7cmNrUca7CP6MHzWMlUcIlfKqmBvEyDJ1eBEikvaUFe/GnC
         70qKsb3lVPciQOPIuoyHrT1XrrUYZF59Z34FAcNb9Gikw3rXaG24GelUjImyTuN7zo4m
         67gZhYKAsxuYEYXFhpTh6/hGhD6nD/TgFeOMn9DbjwsNwtewQJaVf/N2OaXwMS/fL1kF
         bPCg==
X-Gm-Message-State: AOJu0YwnlTQlYaLfXqfiR8JYPOUH3am8rB6kkbKry8outlhblsLcISYy
	EzOqMYHwrPAn6ED8OrMcXfNLk7btQYC90127dIgCsnC3FFp6y/Mia5FiAmi5SCm9g8ivim4xsqC
	4dWQx4UEPuhMU7UG+vhWhEwaapx2ZikjRr1PSd4IAIGNXmG/yjwIrDhZu9dT2UednYFwx9FDI55
	SlrJ0lTVYF5FkbFv0G7i9KmU7BEgmkyZU3RABYm4heyI+YWhHnmo7fcgxb+2HglGQts4hDHPKYM
	kPykYOCUA==
X-Gm-Gg: AR+sD110AFxkFGU/sGgYMvu/Ku3zJ+rr+k4ySS2+l23CuADj2pB4+mOISBKbIooT7QI
	aaGbE93Q9P7Ra+ER/crYi+R/Z2tLGWnrKJZEEynMIvKirxIGIaMUEnI2lVkT9lkLbVI/9k8wx+g
	IE1616imT6BQxH6alWt6hLhMOAQJWJChiOwuP0ECQn4OdlyxXJIeDKodtUZH3NVjV2OsvkiWhwB
	m3faDPZTq1AQzwxXa3cD09YHbrmj312fQQocqxiBQgAu71TetftgCrnUIdhs/gvwUuVg8QrNq8s
	mUxtD6xYP6IGHk3XPRQZbmP4Cx1wiCrPGSBqnoMKkfZ7g8XjrNePWE/y0aW9LyugoWqo55Yk+Oo
	cF5AL/pLqZyPCqOLKOi4N/MNxRo94UNDeZujj3yjBZYvRgXH+GDYp7XZVlKS3oVJ4wrmSbTdwFe
	/cm7LFnGAbErgmveSlEmZBVOb1/mOP6Pgk7w==
X-Received: by 2002:ac8:5cd0:0:b0:527:7112:a5bd with SMTP id d75a77b69052e-5283dfa125bmr80415111cf.78.1784903437908;
        Fri, 24 Jul 2026 07:30:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-529a29ccdc1sm6181cf.27.2026.07.24.07.30.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2026 07:30:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb5ea36f969so553748a12.2
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784903437; x=1785508237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+PfAlfX3vpEZCie4PFwUObkKJIDKS93e86I5c2uPjRs=;
        b=ZYMeRiI0cXUaofJxMlKk8pNZSC7Pu2vk3NVOqN/ESj3UTL5WPY+lPisCoGnE30YqSq
         lrHA0TZhc4la3ztv0mux9diX4Z2ZZpopPQ/Qa62S3SY06Y6seMmJreuldAl8A5P6gIO/
         74rA1stf+k5Gk1Y2mgcorCZfo+5AMzhmNIA2Y=
X-Received: by 2002:a05:6a20:9183:b0:3c0:9c19:6591 with SMTP id adf61e73a8af0-3c44b2c3b52mr9461689637.75.1784903436656;
        Fri, 24 Jul 2026 07:30:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:9183:b0:3c0:9c19:6591 with SMTP id adf61e73a8af0-3c44b2c3b52mr9461641637.75.1784903436193;
        Fri, 24 Jul 2026 07:30:36 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5cb670sm259643eec.31.2026.07.24.07.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 07:30:35 -0700 (PDT)
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
Subject: [PATCH net-next 2/4] bnge: refactor rx mode helpers to accept explicit address lists
Date: Fri, 24 Jul 2026 19:59:52 +0530
Message-ID: <20260724142954.3101980-3-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260724142954.3101980-1-vikas.gupta@broadcom.com>
References: <20260724142954.3101980-1-vikas.gupta@broadcom.com>
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

Handle -EAGAIN from bnge_hwrm_set_vnic_filter() on the open path by
scheduling a retry via netif_rx_mode_schedule_retry() rather than
failing
the open.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 47 +++++++++++--------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 6f7ef506d4e1..1e3cdaeaa03d 100644
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
@@ -2210,9 +2211,7 @@ static int bnge_cfg_def_vnic(struct bnge_net *bn)
 	int i, off = 0, rc;
 	bool uc_update;
 
-	netif_addr_lock_bh(dev);
-	uc_update = bnge_uc_list_updated(bn);
-	netif_addr_unlock_bh(dev);
+	uc_update = bnge_uc_list_updated(bn, uc);
 
 	if (!uc_update)
 		goto skip_uc;
@@ -2226,22 +2225,28 @@ static int bnge_cfg_def_vnic(struct bnge_net *bn)
 
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
@@ -2695,13 +2700,17 @@ static int bnge_init_chip(struct bnge_net *bn)
 	} else if (bn->netdev->flags & IFF_MULTICAST) {
 		u32 mask = 0;
 
-		bnge_mc_list_updated(bn, &mask);
+		bnge_mc_list_updated(bn, &mask, &bn->netdev->mc);
 		vnic->rx_mask |= mask;
 	}
 
-	rc = bnge_cfg_def_vnic(bn);
-	if (rc)
+	rc = bnge_cfg_rx_mode(bn, &bn->netdev->uc, false);
+	if (rc == -EAGAIN) {
+		netif_rx_mode_schedule_retry(bn->netdev);
+		rc = 0;
+	} else if (rc) {
 		goto err_out;
+	}
 	return 0;
 
 err_out:
-- 
2.47.1

