Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E13D36F42A
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847165; cv=none; b=d697MZH0SGmhwscQciN0GrF7H8x1HfpAtESmHKxbcwsEme/ZeODE952/71WBaBBtsekwRkVk426Jc8cii94qWwaxQL7q0L/mDN5Xwn39vA9oqeVOz4y6t9X9/8T5RTXlPITUrLavxBbZktG8rCN9EBN0DNDVz1zprxntQvc6Nvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847165; c=relaxed/simple;
	bh=ZiQ/nn9ANVloPJIK/b0D8sPCCqQJrkIokYi9sJvhR7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tjxev07hcrMzZHIiVjxGSiuEr0curz66LBmiCdtGPxhEMRhVty3I8VIBPLNnxhr5+HMmo0KxXH6wmmYrqvtU3CBvhwjY1vTQLDlxQbDkyS9D9PPExwx6asWmfOnvw6KjEdRBfGGEkYac9LgaYdkTYvkONdTCJUxsV2FXbwzx7eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q3SFi77d; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q3SFi77d"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc1cf287ef8so40653a12.3
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847164; x=1788451964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pGyTFP/ZSQ2pi6NB0HQ1eQMbojy+m9ryJYHVSeuqsrk=;
        b=qI4ZtlArZtz8JPL+VFxEl4gqk0P4znPWpDNsyjWy3/V78Pedl48GhAMDh9Qr3CaMN4
         DvFH90ko4O3hJKhhKszNhWCqDIZThJ6qpTmRPYT+Wog63OXUWOfA2WpCPO/Wt5MdhERN
         iWzcUXRwfo2/0q/1EcX78oiIoxVJ0N79FK5iCEVhRrGM6+UkP/UG0tS1lOBjtAfdeG9I
         cIz+wJACQqOdycUlnQ1iHm6Dnq/5Hil55+aT+e80mLcnF2YQ6PYHAxgm9iKWiSw5p4qZ
         GE3Yee0/31iD0/7Y2rDUa2S3Twys4iLuBsvLgcrSUA3JmM9fymlCysVAwtAihKnr57zx
         gizA==
X-Gm-Message-State: AFuF++kE+IauVWjRu1VfZZdPKIOG/DsirnAa+CJ9Joixb1F1IZhVI3eN
	8zqjcLycoG+JJ8vVfuPeYUAXkJH3A2DIfX3dXADklZ/d3k3SqGlcfG1l2LbFK0FVqeokaCzMPkf
	FcIhHGiqpBRBYxdY2ic4CNksj5/pXXhKLah3mDAeSEEX7PuIqewuS2LEZXKHltzoDpOZTYxp1GP
	ifHVZ8QrcTdqgeS3Fp8EccXO9snoFBLpdyQlLLnHiDE5qEMD/kF8OwbU9nJGOn48TnrxTtYkwQ8
	37FlLLo+A==
X-Gm-Gg: AR+sD12QdN3sIxiDpEZwke+zYm5Oq/hqeqrzqX+1u62Fd5f6MoA/4Zesd/qTU9AANdB
	BVuYGRm8Q+AXZh6tlG78KH3LrCqeuyXVVXLosD/Vff+1IdwkzzZlBCMli3Qr94e1K0jANUzR+1z
	C+CbKysYMKa/Xnn9vAolymLJ3eIPIx8gXkR5k8kDYuik7GhZv34GwE7gGIhatvfKW+kSDLMXNTc
	NJJM390kRg44wSvanuW/QpwN3WY6AJ0NSSO2hLs1JWgXBxAC8fA/BqqUabMjH19TQCuOlH9Igsy
	mGPmDpjul2JQITqPyoFKrV17hwFpNaAizWa0H2IBXXn4TrVRNlY+c1r8H+xTe3hcVupLUbtp/+0
	BfWeFcdhdsBO30KHFfIPXE143mHWwE+uzi9aN8FVXkKJpA6BgirIhnHMxdr7QzEhJ2Mu+u3cFL/
	2LppHmrv4G8lYxUXXKMAXxKUqZPSCpq0ShHg==
X-Received: by 2002:a17:90b:440d:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-396d0e5e891mr507373a91.2.1787847163486;
        Thu, 27 Aug 2026 09:12:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-396b0eac8cbsm1144352a91.7.2026.08.27.09.12.42
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2026 09:12:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cfe48ca1efso144395ad.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1787847162; x=1788451962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pGyTFP/ZSQ2pi6NB0HQ1eQMbojy+m9ryJYHVSeuqsrk=;
        b=Q3SFi77dVP6DJl75FDBEVDpJ9OdWT97qYP6yLSD/IfgEN9cmv/4mtRv/RB/0sWq3lR
         28tcAkaegQf+atpGlp25/M6ZFn48ihI70CdKsoKv05O6bw38XgbrKXkA0ndeP8eXSph6
         oNTob+8dJnPLnivatssyrZQtf2nCsf+wQzgB4=
X-Received: by 2002:a17:903:144b:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2d74dc2fe73mr1875635ad.4.1787847161621;
        Thu, 27 Aug 2026 09:12:41 -0700 (PDT)
X-Received: by 2002:a17:903:144b:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2d74dc2fe73mr1874475ad.4.1787847161104;
        Thu, 27 Aug 2026 09:12:41 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32854db74eesm11005486eec.18.2026.08.27.09.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:12:39 -0700 (PDT)
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
Subject: [PATCH net v2] bnge: add missing ndo_set_features
Date: Thu, 27 Aug 2026 21:42:30 +0530
Message-ID: <20260827161230.1724658-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The driver advertises togglable RX aggregation offloads (LRO and
GRO_HW) in netdev->hw_features but is missing the ndo_set_features
callback, so it is never notified of a feature change.

For example:

  ethtool -K ethX rx-gro-hw off

is accepted - netdev_update_features() clears the bit in dev->features
but the driver never reprograms the hardware, so the TPA engine keeps
aggregating and dev->features no longer reflects the actual hardware
state.

Add ndo_set_features to reprogram TPA (LRO/GRO_HW) and the RX ring
parameters when these features change.

Fixes: c2effd12c96d ("bng_en: Add support for TPA events")
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
---
v2:
 - Sashiko's points addressed.
  Sending FUNC_DRV_IF_CHANGE_REQ_FLAGS_UP twice is safe and no DOWN is
  ever skipped. Reworking the handshake so if_change sits only at the
  ndo_open/ndo_stop boundary is a reasonable cleanup, but it's out of
  scope for this patch and will be handled in a follow-up.

 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index a4288f0258f8..13573a2b78ef 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -3155,6 +3155,9 @@ static void bnge_close_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
 
+	if (!bn->bnapi)
+		return;
+
 	bnge_tx_disable(bn);
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
@@ -3267,6 +3270,44 @@ static const struct netdev_stat_ops bnge_stat_ops = {
 	.get_base_stats		= bnge_get_base_stats,
 };
 
+static int bnge_set_features(struct net_device *dev, netdev_features_t features)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+	u32 old_flags = bn->priv_flags;
+	u32 flags = old_flags;
+	int rc;
+
+	flags &= ~BNGE_NET_EN_TPA;
+	if (features & NETIF_F_GRO_HW)
+		flags |= BNGE_NET_EN_GRO;
+	else if (features & NETIF_F_LRO)
+		flags |= BNGE_NET_EN_LRO;
+
+	if (flags == old_flags)
+		return 0;
+
+	if (!netif_running(dev)) {
+		bn->priv_flags = flags;
+		bnge_set_ring_params(bd);
+		return 0;
+	}
+
+	bnge_close_core(bn);
+	bn->priv_flags = flags;
+	bnge_set_ring_params(bd);
+
+	rc = bnge_open_core(bn);
+	if (rc) {
+		netdev_err(dev, "bnge_open_core err: %d\n", rc);
+		bn->priv_flags = old_flags;
+		bnge_set_ring_params(bd);
+		netif_close(dev);
+	}
+
+	return rc;
+}
+
 static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
@@ -3274,6 +3315,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_set_rx_mode_async	= bnge_set_rx_mode,
 	.ndo_features_check	= bnge_features_check,
+	.ndo_set_features	= bnge_set_features,
 };
 
 static void bnge_init_mac_addr(struct bnge_dev *bd)
-- 
2.47.1

