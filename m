Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B943CEFA
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784903445; cv=none; b=LNBoFnIlv6MvB8kfxt0B83Nm84Ljpb3DLLbA1Y64fVXSPro+9TijLWqtwLpg1JeN2gOQ5g5OPjInScBIj+wgDpyi1+qNTdnV4IkJCdWoZkIDALmtIeDMjNDZix7OuOFnkf90Gmc4G2vTlCYi5BeMcjHa4l2j8VEsGYiEKpTKBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784903445; c=relaxed/simple;
	bh=T6+4uWno3qiPu42lbh3caCYCt+l5+8vX7oK0bCAiq8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcG2mR0T5kTBn8AoTe9bcvODeMM2ABg6uBeeI/dj0LLt32mj4YT3K6SNXmnUUnXZ4EaajYM8RHR/ss/l7pfZUsejLdKOy1DIJk5gmtUWxe4+yX+RngVCEaObiZh+N7G4uQ0neVHdyv12EdmvljdRrZMk0iNANViRjxU/M4jKkE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hWcQHXpT; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hWcQHXpT"
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-74ae4c75b20so244701137.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:30:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784903443; x=1785508243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6yRI+9u7xmeJWs4rtpYpBl5JFmjWKLMn+METPdpZP8k=;
        b=HtGuTKHK7cBDj3o6CLjAz8t09TCw4PgM/iugciU48ruG+dafahrdhARBVlth1HCLXs
         pI8BXhVVKu7XGG2lG5qDF5QEzxQuCLTIiCz6Rf/W0O8gMxfRF5kHnDA3HPb+lD50AjP0
         5UALICoNb84/0AwBQsCOzHe88idojnPtoNr3HLxUD2/c5K3Uphgjr2EDWf+dn9FNs3Y7
         mF/gsfXtyJGR10G5d6PhzQr5MNMUF4cgpH2bBKv3k27au05YqulydtHTNQOEGaQrodxO
         clE3Aj9os7fozEIacE9rm0vNjeODKM8jTfEzBJrOJlBde0hTew05bTgZ14Iech2Qk+Y7
         SjOA==
X-Gm-Message-State: AOJu0YwYKi4KXbBQ4g1jxkLVnkUoVZ3iFaFlHgIK2XxAymTE3j5RYadN
	umDvG+k7zVGX0GqXCROGkNAXAYseFvTFRoujw5b/0JWq4oF0ch9LsC+G+HEgmND20Y6GgxhLzCU
	3s5VWgN70/PcY7aGc40WRAwngWBnK0SIkpmlMBZO87zNPtmFQzMQPsJxhR+HDioR00kyAjSnzPk
	skea3H53FKEtSxx7NBuQiDMsrMLz5ll/AE8M15UMYC97XCeOIOFbRHF33Vr2EeBfOKsK7uDluyw
	XRW/tEcsA==
X-Gm-Gg: AR+sD12Ydd0qJOzH2x5MH/Rr4IOjIzrP+OrGmTvkUSeOyzonr1Oooiu/kETHzjM+pye
	wj1R0cRXbk8v9r1kEOlO6Pv9hKWPSi2IUq24hBKL3DSoJpz6BNARi4KgSeg5QJEsedXi2S9d9c/
	3DD6XNVQY7AcIY9V2+2hEKJ3Z6uM2nCJmQilfYbcK3SYq1TUpKrZx0LQMm8Qcahr3XunKaaey3D
	hN0o09AscrRMAxJZ5rJGZxMqHkC/1rEJgVCzG0q+TaB323pgcrEsCXv47iWrg5DVfZ2gLEu8F9P
	kfFjXABcsu08YhD8pwLG1zfDpdXD2n9i2NepDQ6GpC/TV2JXPeAad9UjvBaDeGONoPTzqFX96IT
	WpcQX6hoHEywUu4Vsq54n/V1NYYMZiu30oitSD72NhSZiEICZXtaOb18BawAD0doAu6481X6vdh
	htDYGaRY2DpCnUBfdIyy/WWmpfM0BBtUowtA==
X-Received: by 2002:a05:6102:3ed4:b0:73e:bba6:bd59 with SMTP id ada2fe7eead31-74fa485fb04mr408514137.3.1784903442917;
        Fri, 24 Jul 2026 07:30:42 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-73.dlp.protect.broadcom.com. [144.49.247.73])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-74ad324790dsm772386137.12.2026.07.24.07.30.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2026 07:30:42 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c9c26587e67so438458a12.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 07:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1784903442; x=1785508242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6yRI+9u7xmeJWs4rtpYpBl5JFmjWKLMn+METPdpZP8k=;
        b=hWcQHXpTT9W5h8PZtbTzbJFuSCf5r4RbbHnfyOmCm9fzyuC7qz77vE4vfIiLbGpvMC
         5NRg9o9B0taUcu3UaUdDkcdUKf/RbCFqJerclHZEHpOaFjXQJfuHwsWVhxDpgq1bzYJ0
         DTMRYJSjzQvCvY54nMwOIhfRCpIsn4EA9Ffh4=
X-Received: by 2002:a05:6a21:6494:b0:398:76d4:c7e9 with SMTP id adf61e73a8af0-3c6726d21c0mr802993637.35.1784903441805;
        Fri, 24 Jul 2026 07:30:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:6494:b0:398:76d4:c7e9 with SMTP id adf61e73a8af0-3c6726d21c0mr802944637.35.1784903441316;
        Fri, 24 Jul 2026 07:30:41 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5cb670sm259643eec.31.2026.07.24.07.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 07:30:40 -0700 (PDT)
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
Subject: [PATCH net-next 3/4] bnge: add ndo_set_rx_mode_async support
Date: Fri, 24 Jul 2026 19:59:53 +0530
Message-ID: <20260724142954.3101980-4-vikas.gupta@broadcom.com>
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

Register bnge_set_rx_mode() as ndo_set_rx_mode_async to handle
unicast, multicast, broadcast, and promiscuous filter updates via
CFA_L2_SET_RX_MASK. The async variant receives pre-snapshotted address
lists from the kernel, allowing the driver to issue sleepable HWRM
firmware commands without holding the addr lock.

Move uc_update detection to the caller so the async path can compute
it directly from the snapshotted UC list before calling
bnge_cfg_rx_mode().

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Rahul Gupta <rahul-rg.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 50 +++++++++++++++++--
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 1e3cdaeaa03d..e67536a8c430 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2202,16 +2202,13 @@ static bool bnge_promisc_ok(struct bnge_net *bn)
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
-	uc_update = bnge_uc_list_updated(bn, uc);
 
 	if (!uc_update)
 		goto skip_uc;
@@ -2272,6 +2269,48 @@ static int bnge_cfg_rx_mode(struct bnge_net *bn, struct netdev_hw_addr_list *uc,
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
+	mask &= ~(CFA_L2_SET_RX_MASK_REQ_MASK_PROMISCUOUS |
+		  CFA_L2_SET_RX_MASK_REQ_MASK_MCAST |
+		  CFA_L2_SET_RX_MASK_REQ_MASK_ALL_MCAST |
+		  CFA_L2_SET_RX_MASK_REQ_MASK_BCAST);
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
@@ -2704,7 +2743,7 @@ static int bnge_init_chip(struct bnge_net *bn)
 		vnic->rx_mask |= mask;
 	}
 
-	rc = bnge_cfg_rx_mode(bn, &bn->netdev->uc, false);
+	rc = bnge_cfg_rx_mode(bn, &bn->netdev->uc, true, false);
 	if (rc == -EAGAIN) {
 		netif_rx_mode_schedule_retry(bn->netdev);
 		rc = 0;
@@ -3204,6 +3243,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
 	.ndo_get_stats64	= bnge_get_stats64,
+	.ndo_set_rx_mode_async	= bnge_set_rx_mode,
 	.ndo_features_check	= bnge_features_check,
 };
 
-- 
2.47.1

