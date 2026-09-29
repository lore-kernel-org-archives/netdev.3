Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5577B3AFCE3
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709745; cv=none; b=swan+3TpqCYyEXKvxhd5a5qF0I4VgZk9XQ7SMQGrVV5Ha4lplUavlp/j1J7Ar50cvTxZON6kHHMf4/jKehmjmjMthtSiiPWoDQPUzMFm5Jy5qQpeXEs44bYgcfPN09G7k+8AyXcRUK27nhDF4+naUWbybXYME8EqyNhscfghbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709745; c=relaxed/simple;
	bh=soc1UdL6U29pn8AR+X3a5I0n2rxTg8pVScIUjai6HGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=manGpVh24St4xpIa0hHL7pKvjBWbBY3KWXczbEWdzuVKzWKRIZKM6kg5hwtxC7SKOJZ7zaGQrWkWfW94AvIlTPi9mhqRsgwbbXp+vPrqkbdd6TgqpKXrIfdsSM+yxHPCQe8jdAwpZAxyvxm6QbZUZdx2mXloCkMApINQzq/LKlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DyLv/cvH; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DyLv/cvH"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-39b2ad862bdso1817966a91.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 12:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790709743; x=1791314543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UGlpLytsQuiePTVR4JYMni5yCyAEoJqxH+8EP5tQGiI=;
        b=hvl0eX/QyzVUgFIRr02j1nF78PTSzx6bzdY86ljutCSYwijoMwx+ds///BFx+G1Zwg
         OkxPtlNlu/yU3Y82d9wLzL+2pMbLzFs4TpcSQB+YwQk8KrqEUkaFqgDEuyYuEukk3+PV
         3gi91tuZpqvKHT8VOhj/ApohL7h69rCopGYh4Pux8QS+XEIgHJuhQ03kBKhQ/k6tDXOK
         uD+NSiO93DUw/y9PbO/MqpBfEWK2Ce8pe+dRrK99/znVqUvDpYul81+ozqIpYm0W2XUH
         no9n/vv5V+XBANu5c3K4wh+u6EkASOMF5Z6IPTNzt2APoXRQSvM8N24rrIokSvO0uUwr
         z0Yg==
X-Gm-Message-State: AFq9FYLDnG77QPmiKwif3ieB1rsnaKIoLnYey0YZBBcvJYf6gKI18bLs
	4oVsPf3wjqNqWIeteSUJdCNz37Tia50e1PxT9cpIPgZ2x8EbnKeskatbRM7CtVWShkV+kI8fyf0
	gT14CaMkdZUNc5qiT7CYgDxi4QFKrZnCiwlrkXklkaTdNhPi3TQPldiEl8EbCx7vdy14gnSwZKk
	y58fWDZl2CeW/4BpS3ijG5w9L0RRydqe0onNi8gwqD7+YiX2VDGLwt4lfbLdJF6MA8OusTMuIq0
	xciDoT/GQ==
X-Gm-Gg: AYBFou0cEAi/aj5Ws22i/Xc9J92Kng4WlfQqet/p01NmEJ7K7r4OhkGstr5r93iWh3/
	oivC9sHqW2Pm2+LMg0jZ4TrT6oPMq7kCI2/AxThdZ1myDKcVAfegFqdH017QdyAuqFBzfJ6zTD8
	LvcL/ZDvMfGGyBHHI8MSU0nhRrZYCqYYga1z/5Tz3+HdJhQRA8D9LTNwhc7US/wfwUr8ZC3pnhd
	pBBtSVd2zFeY/6BFODytb/zh75chQug1N0SP4mnSHF3u7qU2rz2d+Jh9u6End849oT2AV4U8Zp7
	V+wVRZoR2hgKbHE3kuizkSqyktt5XrV6a+ZJc6sgP+ucJo1pLBkMDvpqyAelgsDzYDiYE3c3LAW
	KVn3w+BXl+7zugBymvgwzprIjpZFVf96YmdM6lpKByXDiRvNMQ05ght9v1kJmElze+oJrzuhVGC
	oG3N3pd0vEayrD65rlu9Zi8I0oxRPiMxJ0DYaT
X-Received: by 2002:a17:90b:288e:b0:3a0:9fe0:3aaf with SMTP id 98e67ed59e1d1-3a4bfe93a6fmr334986a91.48.1790709743145;
        Tue, 29 Sep 2026 12:22:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-124.dlp.protect.broadcom.com. [144.49.247.124])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a4984078e1sm2233494a91.8.2026.09.29.12.22.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2026 12:22:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91431adf55eso80716176d6.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790709742; x=1791314542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UGlpLytsQuiePTVR4JYMni5yCyAEoJqxH+8EP5tQGiI=;
        b=DyLv/cvHQNvR/dMn/SNBDCTUoc62FVOa6aTgvAgdU98loPUP86t6g5xvl6l1K5uF2B
         NQC26USCGYRRR0rEdUgYAIGZpe63McAZA64lbaG775A46AefCEya/5Yk2l1cXyTIJIuH
         oyW4IVFLhxY00xtquR/6E7nLwC5CSI1i36WtM=
X-Received: by 2002:ad4:5f0f:0:b0:8f0:afa3:594e with SMTP id 6a1803df08f44-917999f8837mr2763076d6.8.1790709741973;
        Tue, 29 Sep 2026 12:22:21 -0700 (PDT)
X-Received: by 2002:ad4:5f0f:0:b0:8f0:afa3:594e with SMTP id 6a1803df08f44-917999f8837mr2762496d6.8.1790709741420;
        Tue, 29 Sep 2026 12:22:21 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9179880b6cesm2293976d6.34.2026.09.29.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 12:22:20 -0700 (PDT)
From: Justin Chen <justin.chen@broadcom.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@kernel.org,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	bcm-kernel-feedback-list@broadcom.com,
	nb@tipi-net.de,
	florian.fainelli@broadcom.com,
	opendmb@gmail.com,
	Justin Chen <justin.chen@broadcom.com>
Subject: [PATCH net] net: bcmgenet: if UMAC was suspended in SW_RESET, restore it to SW_RESET
Date: Tue, 29 Sep 2026 12:22:16 -0700
Message-Id: <20260929192216.1490017-1-justin.chen@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When the revised suspend/resume sequence was introduced this led to an edge
case where the TX is left disabled in the following sequence.

1. phy link is down, so UMAC is held in reset and then network interface
   is WoL enabled
2. Enter suspend, bcmgenet_wol_power_down_cfg() enables UMAC_RX since MAC
   is in SW_RESET
4. Enter resume, UMAC_RX is left enabled. Since we only enable UMAC_TX
   and UMAC_RX in SW_RESET. The UMAC_TX is never enabled again on link up.

Fixes: 254f3239dd07 ("net: bcmgenet: revise suspend/resume")
Fixes: 88f6c8bf1aae ("net: bcmgenet: keep MAC in reset until PHY is up")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
index 96d5d4f7f51f..984432952963 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c
@@ -253,6 +253,17 @@ int bcmgenet_wol_power_up_cfg(struct bcmgenet_priv *priv,
 	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
 	reg &= ~CMD_CRC_FWD;
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+
+	/*
+	 * Mirror wol_power_down_cfg(). If only UMAC_RX
+	 * is enabled, then we must place the UMAC back
+	 * into SW_RESET.
+	 */
+	reg = bcmgenet_umac_readl(priv, UMAC_CMD);
+	if ((reg & CMD_RX_EN) && !(reg & CMD_TX_EN)) {
+		reg |= CMD_SW_RESET;
+		bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	}
 	spin_unlock_bh(&priv->reg_lock);
 
 	/* Resume link status tracking */
-- 
2.34.1

