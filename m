Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B730216D
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296383; cv=none; b=EMdCZSqltxhZAmO2uiuzZnzxkTxJ9i9bmKkVYKBeLxUJ4lk2VLkj55TrD+EDDK8aoSrYNUPpnvo9wFHh4VMRSrg//Sgw6OOG4ZZO06i5N72y1G9oGvIrWwMggswgjQbdR9u+0glUQJGu3bgOiR1bVbrJOZDkD2WWMFwjln25ns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296383; c=relaxed/simple;
	bh=Xf7I1h4jJsTAwYeglowmd9HCWNu1KMr7PLzC8H1W9PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/UFo57t/Hixrxvocpk4/bTjCCk9hAERWGXyLMTuzXq0I3lY3/4DXv3znRn7OGPaGwuiDbcNMD108Zs77xiR0q9+fskebwGEwZgDacmk3UCACIBLbUsrTeeTjT9RytRdJadJ1dMXvZ1b6CA/nFwAgenuxb1HUXXEYj6ieFUInbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bNqlPSJo; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bNqlPSJo"
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-ccd0887c542so314936a12.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 07:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791296382; x=1791901182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qvsJ0zRtLPgkphjwJSWiqKXq4bf/xxFr4DSjG3zLC3Y=;
        b=yziVIuI7VSi4qwAQOEFFtUGdfJDkMosEyex/aPrkROr3zyCGSeoWlKD2C5mi9AKick
         cwmjIkNn+obvQ9obcWx8qc8OJCI79WBQ3LZT5BrI5GcG/VD8pDxn99uFt8M0UgNtKXWT
         ojOkNbVYiKfyBtYXz0qHSDGWscQZRwDxuMkbO1Xovt+upn07lsGIgrb/vzxknDS4VOKa
         Wjl2+f145pHUubCocNOUu2ofcqMVjw36rr3M+AemUqKBon69qyBzAaTQtuHunQkVIhfD
         OsFZHpTkhlkMfbu2R3DW9BMOVNPZ8Y9qX+4fHlPAWQaB+NnKCW+7O0YwlYye+C8ZYJpl
         ZmMw==
X-Gm-Message-State: AFq9FYLpCXlKiX9J6XptRb2NINiPHmIYHla2bgvyIyLIM0ouv6HbgnaI
	bpEtO0T4h8ZE7iIH8zymluz9IPiVvgpug9cWgsPlIGTn0AB39UhBl7QcAkJwLWTb+HwrHe7EMpm
	7oTys7UZU5ZUA1b20DiHX3D+t2GUA+61p6sL2+gL+7TE2TgXx5TCaEqKzEOTP1tirby4OBtfQOG
	BWz7gqDkJ5i4nKgqLpKT+kr62nDJNh2nY02c3ylH1oql1Fug+zZw8yDpYjTk4K0nVdsIw2cCcO2
	7Qx3rTq8A==
X-Gm-Gg: AYBFou0qm3sNd6xMcvLnvTlpGQRUKYzbLQdptX+scu35Uw/MlfEg3ag6aAzxFAy8P8+
	opWLm2O053WpSIwKIq6XCxeN5GHGrP3HmLltbK+CwGtUmimxjO+vNI7tSRXVYKeOaiwWmi5lmPS
	Y308aPQNO4SASyd75EgOxg5t+4suV1gDwMjqjAcGR/EBW1qazsD0lw+mfHkn8ZN1Iv42tUKmMKR
	mTZgnRoNnSdvUXncBcczD4E5nUvgRD5u1plBXEcTbKIkibsUgzY8ncNbmZ5+Zg7BBwzCnG31cDF
	ovqjFZcwrfYVjzw6VqDQCniurAZ3Um8noslE8R1pqim2fGrTy07ODwJ3IYZM8BBbM5oWOFOVhUj
	IswzwWoeilbuhyFgjAR6eviMTvoblnSH3TP0IZ8gJ6VxqIXXV26qL4TQ9YC4tFwofvAe3J5qVQf
	WSf1AXAB80HcYGxf/WIcdX5XOw/4c5C+YI2S9O
X-Received: by 2002:a17:90b:4ccc:b0:3a8:5d8e:5cf with SMTP id 98e67ed59e1d1-3a8726c1d03mr1030216a91.9.1791296381634;
        Tue, 06 Oct 2026 07:19:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a853892b65sm1257568a91.3.2026.10.06.07.19.41
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2026 07:19:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3a4e36d5a77so3084549a91.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 07:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791296380; x=1791901180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qvsJ0zRtLPgkphjwJSWiqKXq4bf/xxFr4DSjG3zLC3Y=;
        b=bNqlPSJokD1gRxDQaFiYqF1QS+3eBcFfhT6Gl2WpaCpnk4NqSXaRMF36gU9k1nXFAf
         mpdLd8bDUbz6+OHeAWOnIkeMB/QYHeW5aCW43Yj81seMeGcoEW1+3Zod1TcsSJHd1B3w
         038zorx/VjfD4gvsTGcDAh034m1THVtVwBDLc=
X-Received: by 2002:a17:90a:e707:b0:39e:6c69:34da with SMTP id 98e67ed59e1d1-3a873746b81mr901493a91.62.1791296379643;
        Tue, 06 Oct 2026 07:19:39 -0700 (PDT)
X-Received: by 2002:a17:90a:e707:b0:39e:6c69:34da with SMTP id 98e67ed59e1d1-3a873746b81mr901471a91.62.1791296379056;
        Tue, 06 Oct 2026 07:19:39 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6d2406b1sm2672878a12.8.2026.10.06.07.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 07:19:38 -0700 (PDT)
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
Subject: [PATCH net] bnge: skip dev_addr when building the VNIC unicast list
Date: Tue,  6 Oct 2026 19:49:28 +0530
Message-ID: <20261006141928.1432927-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The default VNIC programs the device's MAC as L2 filter 0 in
bnge_init_chip() via bnge_hwrm_set_vnic_filter(bn, 0, 0, dev_addr).
bnge_cfg_rx_mode() then walks dev->uc and programs each unicast
address as a further L2 filter, without excluding dev_addr.

Skip dev_addr when building uc_list, since it is already installed as
filter 0. As dev_addr now takes neither a uc_list slot nor an
l2_filters[] slot, count only the non-dev_addr entries for the
uc_list overflow check too, otherwise an input such as
{dev_addr, A, B, C} would needlessly fall back to promiscuous mode
even though A, B and C fit in exact-match filters.
bnge_uc_list_updated() applies the same skip and count so the
change detection stays consistent and does not loop.

This issue was caught by Sashiko (nipa).

Tested on Thor Ultra device.

Fixes: 9afad4a17174 ("bng_en: Configure default VNIC")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 28 +++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a4288f0258f8..92aea6f6f09f 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2182,19 +2182,21 @@ static bool bnge_uc_list_updated(struct bnge_net *bn,
 				 const struct netdev_hw_addr_list *uc)
 {
 	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
+	struct net_device *dev = bn->netdev;
 	struct netdev_hw_addr *ha;
-	int off = 0;
-
-	if (netdev_hw_addr_list_count(uc) != (vnic->uc_filter_count - 1))
-		return true;
+	int off = 0, count = 0;
 
 	netdev_hw_addr_list_for_each(ha, uc) {
+		if (ether_addr_equal(ha->addr, dev->dev_addr))
+			continue;
+		if (count >= vnic->uc_filter_count - 1)
+			return true;
 		if (!ether_addr_equal(ha->addr, vnic->uc_list + off))
 			return true;
-
 		off += ETH_ALEN;
+		count++;
 	}
-	return false;
+	return count != vnic->uc_filter_count - 1;
 }
 
 static bool bnge_promisc_ok(struct bnge_net *bn)
@@ -2207,9 +2209,9 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
 {
 	struct bnge_vnic_info *vnic = &bn->vnic_info[BNGE_VNIC_DEFAULT];
 	struct net_device *dev = bn->netdev;
+	int i, off = 0, rc, uc_count = 0;
 	struct bnge_dev *bd = bn->bd;
 	struct netdev_hw_addr *ha;
-	int i, off = 0, rc;
 
 	if (!uc_update)
 		goto skip_uc;
@@ -2225,10 +2227,20 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
 
 	if (!snapshot)
 		netif_addr_lock_bh(dev);
-	if (netdev_hw_addr_list_count(uc) > (BNGE_MAX_UC_ADDRS - 1)) {
+	/* dev_addr is already programmed as L2 filter 0, so it takes neither a
+	 * uc_list slot nor an l2_filters[] slot. Count only the entries that
+	 * will actually be programmed so the overflow check matches the fill
+	 * loop below (and bnge_uc_list_updated()).
+	 */
+	netdev_hw_addr_list_for_each(ha, uc)
+		if (!ether_addr_equal(ha->addr, dev->dev_addr))
+			uc_count++;
+	if (uc_count > BNGE_MAX_UC_ADDRS - 1) {
 		vnic->rx_mask |= CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS;
 	} else {
 		netdev_hw_addr_list_for_each(ha, uc) {
+			if (ether_addr_equal(ha->addr, dev->dev_addr))
+				continue;
 			memcpy(vnic->uc_list + off, ha->addr, ETH_ALEN);
 			off += ETH_ALEN;
 			vnic->uc_filter_count++;
-- 
2.52.0

