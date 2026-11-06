Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959016;
	b=2BWDJPjcikB7hCfi9/uLB8FrYMWVO3QZ2gNOyjt+Qvk3hut4YY0D8YRjEulXoVTI1Rcj
	 ZyYz3D5P+jP9ccvbpna23cKCjp1Y6yVcHDBTbTXkwhA1es98Pj1mwV61MsEyR8bZIkv8e
	 yGUG5O57rL+MnlmvWzM1XErkANeNG4JtX23QOphYmMBa/vp3khEWWMbYk1NZGBqOw0CqS
	 BdCbe+9cVkuMVcHEljv31bbtICC4StvsaLHPs3TF1NMxSmRgZXyyAIOKy42+WnF9wHCif
	 0wX3x3xCFBrpmZpv1bm8wNVoHyyJLExJjVSnQ7SDHUfKsVrjXx8jEZGsj0tOhY9rg0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959016;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z6vk6OTThl/kiLBhQPyPXK1nbZr+d/QuPGqRSqWejRk=;
	b=WWDMFNIWCNEdlRLFrbWUB0Z/kdNopp2czkNZugNolmpAAXq3dT1JEOm4BF61Y2QVZaWu
	 YHoLxEMaAFm8r9S7Z1HU1rdFikLgTzptfSh1FB/Cc1bNXyMvGoIgQC7DsFgmhbRSYsp5p
	 b9fxoTJuCfmcqT+ApMO30rRZKZ0gXqxxRiA/q07K6vUTEl1PNIihCRh2IVZVTYR1j2ksM
	 iQdaAodtUxniBPdfTs6kV+ESNzuELeg8mnggFEbNMmF3CqGIscyyQyFBR2NR6UxOF7sxU
	 cE7UvyHTPa3CwPFoMUlOFg9sSbKuidaV4OIbTVakRQkS5SFv3tktFHJcZn6ONOP0W2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ftkHLjKB;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B9606EE8E;
	Fri,  6 Nov 2026 09:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 769B9606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=ftkHLjKB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=ftkHLjKB8XfRCJWcP+rNAXmx8RFDkuuD/tntPSQUXWGodr3hZ64OIHmAiU7Owk9Ksbcu/4d9ALX6Y
	 wn3W9aCY+/TxMqiOYcc8rG81cPijya9HUpV4KxfckK47vY7r8yS9Xyi1K+M5qGnEmeiF9hgiSeZT2C
	 YuL+B2fTOera+pHw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26aeda462429-ed018;
	Fri, 06 Nov 2026 17:56:51 +0800 (CST)
X-RM-TRANSID:2ee26aeda462429-ed018
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26aeda461cd7-1bf81;
	Fri, 06 Nov 2026 17:56:50 +0800 (CST)
X-RM-TRANSID:2ee26aeda461cd7-1bf81
From: xujiahao <xujiahao@cmss.chinamobile.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xujiahao <xujiahao@cmss.chinamobile.com>
Subject: [PATCH net-next] netxen: fix the ring interrupt name buffer
Date: Fri,  6 Nov 2026 17:51:15 +0800
Message-ID: <20261106095115.3564392-1-xujiahao@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The receive ring interrupt names are assembled with sprintf() into
IFNAMSIZ + 4 byte buffers as "%s[%d]", with netdev->name (up to
IFNAMSIZ - 1 characters) and the ring index.  A 15-character name plus
"[" and a full-range %d needs 28 bytes, so gcc reports in a W=1 build:

  drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c:1052:45: warning: '%d' directive writing between 1 and 11 bytes into a region of size between 4 and 19 [-Wformat-overflow=]

Enlarge the buffer so the worst case fits and switch to snprintf() so
that the write can never exceed it either way.

Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic.h      | 2 +-
 drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic.h b/drivers/net/ethernet/qlogic/netxen/netxen_nic.h
index 3d36d23df..1b924b2d5 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic.h
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic.h
@@ -634,7 +634,7 @@ struct nx_host_sds_ring {
 	int irq;
 
 	dma_addr_t phys_addr;
-	char name[IFNAMSIZ+4];
+	char name[IFNAMSIZ + 16];
 };
 
 struct nx_host_tx_ring {
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
index 67d9bf69f..cffa93a98 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_main.c
@@ -1049,7 +1049,8 @@ netxen_nic_request_irq(struct netxen_adapter *adapter)
 
 	for (ring = 0; ring < adapter->max_sds_rings; ring++) {
 		sds_ring = &recv_ctx->sds_rings[ring];
-		sprintf(sds_ring->name, "%s[%d]", netdev->name, ring);
+		snprintf(sds_ring->name, sizeof(sds_ring->name),
+			 "%s[%d]", netdev->name, ring);
 		err = request_irq(sds_ring->irq, handler,
 				  flags, sds_ring->name, sds_ring);
 		if (err)
-- 
2.43.0



