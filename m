Received: from mail-oi1-f227.google.com (mail-oi1-f227.google.com [209.85.167.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4B2C21F7
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 23:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809605; cv=none; b=S6iRPcdEF48bw9hKoO4TUnxRphYW8VaRSY118b0nwnDjUPwlxrJRRI+Ht4AAfR9beAOm1wRnvDzu7CXGWpSO7ciGemY7ujYqd/6RAGWkcmHFSF+JPb5b9XqA0Q0oDUaRflsfJsHZmIvQCovKH2mj5IyNe6KH2xIdj0HYejFG59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809605; c=relaxed/simple;
	bh=88UOfwXpNmj9wwRS6KYQI9yaVytNZ07nI2IWMjyRFmk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AY60Vs1L2TT/EoeBI4MHWJzaCfFbasQf60VSkh9IUjkfwezFe7LACT1EPGV+kC8QTeMHgD355w74oyme3JS80HdF/PhMhK8aARNHvOW7aTtTy7rAcuku0F2pC+q8rQJEvgtUrlHFyT8FGLz7r20uxkCRSQ9L+/Qeql0iGAiFWZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NjrATCE8; arc=none smtp.client-ip=209.85.167.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NjrATCE8"
Received: by mail-oi1-f227.google.com with SMTP id 5614622812f47-4eb444ae5ceso1022887b6e.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 16:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790809600; x=1791414400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2A1aoZJPSg31t9WTQ/Sn8rXwGssFb/8lsgDEw3ydqR4=;
        b=BF6S8JR3y+AGdKjp9OOVOZrtxApQJSTbTzcvng9KkpNYiNbR5AVIXjuA49mFTGuOaE
         MrAF0yZBOogQQuU1VyZNAVfHV3RW8AzQAt8n+ew49oVfzRNe2ixF100dLzS1rr2XK/1H
         fYUg+zE3LnBkTMmt+zFEeh5NlWnkgC0PjMPjkD+bcZiGLt28hKhahsEu4j1cWsjCMeQm
         rmKscgJ/cYmpWuMHlixppOTAcMlZ6nki+s/GiMcl0VCuQCfB9tSx1gFNRzMV07CSetIS
         xQzC9TnzmH5XVC82JRxxz8jnaHHnk1YEGPIx85hP4ySjuyCb45dWqiXbULiP1a1Hcbya
         hChQ==
X-Gm-Message-State: AFq9FYItybNIwzbOy4o5CrlIfkA3T69Umhv211FW8ZTMoah8VgZZrzJB
	n0CrzrJu7wyrUYgjFHcIqZ6q8EgAzIyPwoD4/L8/KA2bArO7fDafsgJgrXWerWIBleRg8fUBSt5
	FduzmpQWOPb+lo+sHAiwgu+iI/VjAraFqwghoJyrM+9CuTyIFbCML0BEGWpfIjRkq9E4SQBrh5/
	Vrh3q7bEdX2ONI/aYW5lIjxIPyrnmPWP8CHUbsvsqJX9BzK0wiI47va3m3cx/C92W5I/OjJD+Id
	az/Eip1fQ==
X-Gm-Gg: AYBFou1j4LbhgUvuzeF4XeYNOaYKglCrLSku2a8D+1BfS0e7PV3yLP/THIS61GTvnx5
	dkPOo+c0ep/6AqefiGKjz25TbcAUtyz4dbgc8fb/m9ckrxZBAu7xE2uF8etOPqpsSjwzBeKN030
	PrUnB1uf7D4O8ZEPoMvCMc5r2s3d2KsSXfcdfO7Z5J4ElmqG51jrdyraKlB+ZZa0j/NwIolEEdn
	WOh6k+XMbIbetgFaUOwEOgyWTatU+P8OnS/yzcaHcBa7MTn1HXOt+VEBqvWJx8znOnTheNZN3mt
	U0uHoqDQSeXevSR/p2L2PWNkKAwPzxGt2TQ5vrM/GT2PCtPPjhKemm2bRllvM8GSLYNAu9ChMzg
	04l0YXaNf31dyGXY8eYv7JcVVUCbK/ijk9+Eh9Dstofpf+HiNPhhIfjI6PgUVZdanXu5HQQ++YE
	DFGmelt2rhajw8Ic+Lx6FTGJjp50t+kwHWnhug
X-Received: by 2002:a05:6870:89a9:b0:48f:e0e5:a1fe with SMTP id 586e51a60fabf-49ddd604b65mr3254684fac.50.1790809600024;
        Wed, 30 Sep 2026 16:06:40 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-49ded3342bdsm287901fac.20.2026.09.30.16.06.39
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2026 16:06:40 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-34d84114044so2268386eec.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 16:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790809598; x=1791414398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2A1aoZJPSg31t9WTQ/Sn8rXwGssFb/8lsgDEw3ydqR4=;
        b=NjrATCE8nQIHAWFRXb7Wl40x3WkVXYXJOtR7rHeFQl36uYZzTCOARzA9Q9W3AIWhFz
         csvdneiykAb6VdxNLf0ogTFtc4mdRiTI3XTiFk8odDR2hWa2H43uGdAZi807h4HVjeRP
         lChM4fAG7mXc0+g/esaZjVTGFYTAo/BcRPi3k=
X-Received: by 2002:a05:7300:bd03:b0:33b:e842:d272 with SMTP id 5a478bee46e88-34cd937558dmr4029525eec.5.1790809598020;
        Wed, 30 Sep 2026 16:06:38 -0700 (PDT)
X-Received: by 2002:a05:7300:bd03:b0:33b:e842:d272 with SMTP id 5a478bee46e88-34cd937558dmr4029479eec.5.1790809597312;
        Wed, 30 Sep 2026 16:06:37 -0700 (PDT)
Received: from stbsdo-bld-1.sdg.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db0c8e913sm1888206eec.3.2026.09.30.16.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 16:06:36 -0700 (PDT)
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
Subject: [PATCH net v2] net: bcmgenet: if UMAC was suspended in SW_RESET, restore it to SW_RESET
Date: Wed, 30 Sep 2026 16:06:34 -0700
Message-Id: <20260930230634.3132729-1-justin.chen@broadcom.com>
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
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
v2
	- Dropped fixes tag that did not introduce the bug

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

