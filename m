Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3883B4E8C;
	Sat, 17 Oct 2026 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792238380; cv=none; b=XNK8MlICOcUWbEdbjGd1DFCc3KnBoaTlawmndKe+ZDRrkMKDHGTxoHs3Pe1VhKe/S0rNKGqOXE9XoZDCNTfp6bI6NT7ov8ijLyHAOYfE5iB0T0vxZPG82GochKc1T7FpMYaMwDkMrMpMslTQBEwTiwb4VS17zPJU7Xz4pcO0vLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792238380; c=relaxed/simple;
	bh=CtsMB7FWCtidKPIcmtxMdzGpu62AoNs2Ar4YSgY7vm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gBPo0MzPeFUmHsLgQPtUejXD7Cx58V1CZ6EvNbYXp+Aq8O+12F6pk29EE0/4P/LnSMTDJyh0SUe5+ZIyFGPyHzJhxtwY8SGjwC8pYfQMTh/2eE4OMx2K03VpX05XxF6gMcDamO4eRj7oxCRqZiBCPJN5tuFHyGCdb8CKrSBGXGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=yRVtlU8R; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="yRVtlU8R"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1BCB4A1579;
	Sat, 17 Oct 2026 13:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1792238374; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=b6sFBxn4QFnrimYWFzdabU/AP8VL+VKqrieNhJhjvwY=;
	b=yRVtlU8R8nNr7amiu3JCMUoFX6309/PlRKhlAgKv5aD0fWUdDtclHlaMdMwIGuc+AcoQBL
	+NVeZ0uax3IHW1DcZXP/QIs5bk7N7v3VONCAFHOU0NgbNTUGHlw5qDsiHZDG4XRbe3kaWe
	ai/7upPYLJoZoNWUtoCL+QWUBDDTE7Uegt8BHOqshMj4uBsgNg/fpfRrMQ0z8/dI61mvxm
	1g8shibapLwhEf0n7HY3KweGiuj5MbnuX+4Ps1qZ6mWLoGPsOigiNt+k18BhIHu/qpXqrM
	2OUk0QphlF5H2UIHAYn9QvHg0mfEEG75ImPIw4DgicSADcJVCUYVOg0Ci1BB2g==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Sat, 17 Oct 2026 13:59:25 +0200
Subject: [PATCH net 1/4] net: bcmgenet: stop the PHY when a WoL resume
 rebuilds the datapath
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-nb-genet-fini-dma-net-v1-1-47e7c57f6834@tipi-net.de>
References: <20261017-nb-genet-fini-dma-net-v1-0-47e7c57f6834@tipi-net.de>
In-Reply-To: <20261017-nb-genet-fini-dma-net-v1-0-47e7c57f6834@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

A WoL suspend leaves the PHY running. If the resume then finds the MAC
was reset it tears the rest down and rebuilds, which ends in phy_start().
That warns and does nothing unless the PHY is PHY_READY or PHY_HALTED.

Stop the PHY with the rest of the teardown, but only while it is still
running. A rebuild that failed can have stopped it already, and
phy_stop() warns about that too.

Fixes: 254f3239dd07 ("net: bcmgenet: revise suspend/resume")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index e8908916558b1..308716cddc077 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -4288,6 +4288,9 @@ static int bcmgenet_resume(struct device *d)
 		bcmgenet_rdma_disable(priv);
 		bcmgenet_intr_disable(priv);
 		bcmgenet_fini_dma(priv);
+		/* An earlier rebuild of this datapath may have stopped it */
+		if (phy_is_started(dev->phydev))
+			phy_stop(dev->phydev);
 		enable_irq(priv->irq1);
 	}
 

-- 
2.53.0

