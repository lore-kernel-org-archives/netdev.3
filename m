Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55B228D831
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 04:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791000771; cv=none; b=EeGmu5+lo727l3OiVOPCF7AMOAwXb7C4EjH2YY/M+0y/fFPqIng/jkTe5r69GZ1yyplK2kp7zHXIf6rSBGX0iVbo23ifVMobvTYJ/Sen/dXswCCJ/9OfdKcdfyCqUs68jEK51O2BV+k0dgmV0utnLvWnNDiglgZLYxrQeYOkuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791000771; c=relaxed/simple;
	bh=dOIXqLzBtSxy2qJIrgonAcgd/FeiJxv/lEsDBeOpcYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BET5mHgI2Jsv/L1BlSoweLNXAYABFXmGLQDb8i687gtUKv8aUb0E6a2q1qGISuxDtVyiloqmvVYeUKtyjrE18wVV4ptx5eBT1SiZX7Dp4qSfLTrr/eKHiVjslhh49GFHkDS8QojbbStNZUOacSUFVq9W/nBSifItApjDdV3uSgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfPWsVw5; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfPWsVw5"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53440816851so2291711cf.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 21:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791000768; x=1791605568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cc2suPktwUV0lHyZwCLOmemG0HWTqvkRtCzdgjiCcCo=;
        b=MfPWsVw552kdpSET7H05u7VK5wF8VaN5nFh/7wOKOzRwfkWzv6kQ7CQ58YH+xoyT6Y
         o6ol6OVJ4dTCa2eqLB3AHkyCRG1n22kAP8cmbOURfGewAIDsri0G9Uxl0BKyoy8WVkVI
         Wb6IEU8VpZQ07zOIJPQ+JXsYOCF3p7BN3XbxgdDaEoye4jlsdxs9XaizNKpO6iBrFh7P
         x0YgMXqJv/zDWqhYkx2rOnkO4IMeWT0WMQI4x90WZyAl5FLOD7jfnO2f+aBsVS2Q8sK2
         L18nbKp6Y/P7u6x/6sWSLEWGwyBoVSq+EMMGtuTQNEeoDCae1+MSODuEcOBzYArl9JNV
         5oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791000768; x=1791605568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cc2suPktwUV0lHyZwCLOmemG0HWTqvkRtCzdgjiCcCo=;
        b=lBrKSor57cVZ/2xQ8LWZtFtTFbB1bQjNz8FKYHdJ+FSTZN9dtDPJuMZnauFRMOJyHo
         noRhdmEUqoB6TGCaWXUuPXM+HLbkdNjysHZi+uKFgrbSHyJxJkyS2fMojEZdmX/H06Ei
         EprNt24gXNQmTXCNrU1j/1vjYpdq/XEvppjRmRiOMGEgIwdG5B2C1C6xs/ks4lAPgXPd
         cWMTalCSSPvO926+t4ysmI5vTJKz5fbgFSJrBo5Hbz6+eUXc08rraOBwfH4e1NfjsFWH
         RRB8AEtpNxiS8cKFYj2EVyQZzcmdAKO0C+ZdHqi9MkMwzVko0I08k40u3EyPC7g8rHKB
         qUdQ==
X-Gm-Message-State: AFuF++lk2zNoJrJ/2KB3vqRuaDzJILRKJdjqjrPAfzqPt4Y80jSiklCB
	csSlgkVV9w1L0lJxvfFV5KUxhYr6yhqdofqAUlsjTVWHCe01b0g9YlJc1ao+iPE=
X-Gm-Gg: AYBFou3+0bqLc3jdlcHmOGr7UJ6koKykwycXBLc62SY8HThFQ+W37gRnsKAPz0ufPm5
	df+0uNDFkjnwveScpJBL/D7A8fzZag71zppPcjtyFFBuPoShoRVMIcRXGQi1sDp1Ef/BgaVCaDD
	NGq1Wubz+5/ll/mBo9WzwslupPpYm2P0E/ntHhLjT8mW8fCwAj7M0VAzg0iicfKTmRZiApRDioM
	dKSFUxZRwekg3eoLqwKM6vXQ4uad866XcG8mMGhqMekqXM01vdowj5IfiVYdsAL71A84StW+9GI
	8qhmkFaYRLnjFeCfR0SRkxRIPBlje89QaqBO1s5XmZcZqslt6+fllWU6CD3qYnVb8TFWjoTVS+L
	uvsAsPMWAzC5lSZm2rS+RY4ehNxOrgPH4e9lcWgIj1BmwzC1PC+/peOZVcumbhoyZ+2MUj8UkG2
	fy3r8cDx1RKrMWCoWCnZwMBRty9Dw5oWOiGNu8scQZjlxEN77UmRuNr5PITQVfP+DYbkhXNTi25
	2J82xzN9iVveAOFTQMZszdq74oyOvpahWgFgSARh62cvAkmAtTWZcahSEdgr1AtW/lYaZVcjLDq
	k7/HE4a63BKAcnENSkbpN9FRMx0k
X-Received: by 2002:ac8:7e85:0:b0:531:172f:79e8 with SMTP id d75a77b69052e-53511f1965emr23644131cf.57.1791000767676;
        Fri, 02 Oct 2026 21:12:47 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53398a5b6d6sm42699391cf.9.2026.10.02.21.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 21:12:46 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net] net: nixge: stop IRQ producers before draining DMA error tasklet
Date: Sat,  3 Oct 2026 00:12:42 -0400
Message-ID: <20261003041242.650599-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TX and RX interrupt handlers can schedule dma_err_tasklet. Killing
it before freeing the IRQs leaves a window for an interrupt handler to
schedule it again, so the tasklet can access descriptors and TX skb
state after nixge_stop() releases them.

Keep the initial DMA channel stop while the completion IRQ handlers are
still installed. Then free both IRQs to stop and synchronize the tasklet
producers before draining error recovery.

A tasklet queued before the IRQs are freed can restart both channels.
Stop them again after tasklet_kill() returns so error recovery cannot
undo the final stop before the descriptors are released.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 492caffa8a1a ("net: ethernet: nixge: Add support for National Instruments XGE netdev")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Compile-tested nixge.o on net commit
6dc989ea46b96ce170840174b4a38c4a387fb005 with x86_64 allyesconfig
and allmodconfig, both with W=1. No hardware testing was performed.

 drivers/net/ethernet/ni/nixge.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 230d5ff99dd7..7bba6f8e64fe 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -920,6 +920,7 @@ static int nixge_stop(struct net_device *ndev)
 		phy_disconnect(ndev->phydev);
 	}
 
+	/* Stop DMA while the completion IRQ handlers are still installed. */
 	cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
 	nixge_dma_write_reg(priv, XAXIDMA_RX_CR_OFFSET,
 			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
@@ -927,11 +928,20 @@ static int nixge_stop(struct net_device *ndev)
 	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
 			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
 
-	tasklet_kill(&priv->dma_err_tasklet);
-
+	/* Remove both producers before draining the error tasklet. */
 	free_irq(priv->tx_irq, ndev);
 	free_irq(priv->rx_irq, ndev);
 
+	tasklet_kill(&priv->dma_err_tasklet);
+
+	/* Error recovery may have restarted DMA, so stop both channels again. */
+	cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
+	nixge_dma_write_reg(priv, XAXIDMA_RX_CR_OFFSET,
+			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
+	cr = nixge_dma_read_reg(priv, XAXIDMA_TX_CR_OFFSET);
+	nixge_dma_write_reg(priv, XAXIDMA_TX_CR_OFFSET,
+			    cr & (~XAXIDMA_CR_RUNSTOP_MASK));
+
 	nixge_hw_dma_bd_release(ndev);
 
 	return 0;
-- 
2.53.0

