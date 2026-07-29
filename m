Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F92442B33E
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785312093; cv=none; b=mmnyDwZ01ZWX6sX8PDvl1E4LHUzZTbNs78ZWpoesw+EfD8U2hulvIvDNct7F2WglrX6p4XIr13okNZXC7SQrN4f274++w1BRf5IfQUu0uLz76+uCNBKgrw6YHrNSIlbOS7JB6C9u0/2/NIMlAIFbRbJNxxIVzTi7N34KM/O/Z4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785312093; c=relaxed/simple;
	bh=XpKWNePA5PtOxPOsfEKhi9q6D485cBitPvXlwK7aWfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQN31qAGNrIc2aoszDF+K3jOHY58XqOIBSvS3acc+fSJaXFtGONTWb0EfQtxl60avNiU5dU6eehHvE/Wb0PZvUxf9dNeNbAa2taVOpe5GQWgDSQGXJk1hNJ7vWBq/AMNuR3Y9RF+ujwpTXvLFMDD5OJ7yCxp8fSiFxppMArnS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=fqlUpxlG; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="fqlUpxlG"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84e27035206so742464b3a.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 01:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1785312088; x=1785916888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=26wuvyCQUtwFDNC3XvJvRGJkecoG/+P+P0HW/5yjOz0=;
        b=fqlUpxlGhsZ/kAHVCLNxEeOh659MwcRwYkbSXCmcXfyprL5+Z1VeJVcxJEAQBKn+xZ
         pWLoh4M0ylJoGtgPGXmAloXTyqyTYP2c04Gwv19hEry3SNcWDhioO8GMCaFsdAZlZC8W
         ztuhqeEg0sjDXod2vW7E7AWrDy8WTjC2xCqYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785312088; x=1785916888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=26wuvyCQUtwFDNC3XvJvRGJkecoG/+P+P0HW/5yjOz0=;
        b=NIKXTWlsEia05H6tk/fVqDXIC3Y+fNXAkez6hr7DBEHl7sAIa4e7DFP0qTqEFiHxqo
         Kt61SR/NDELbAcMuXtaeMNT7E/oYhyFvtVTPqj2PhuQ9r1ZW0OvePJc0yDtncL5b0h5y
         KF87Rv542/DYhflgqcIo/YjQbVJEJB4dmLU8o7Cbpr9GwY0e0FmRKK1Y6mCNewo+0H5o
         je5cstVUmZvlBLIHO61D7LuM7Id6jPvuhbRHCNa6i0uzfewmz/pPmU1IlyP4SilMhJmE
         fKFm3B+KJtFbOTZkhbb2+69KDWY+Btqfh+kYsEh1E7ZYRBBILUgjRXuiRvem7wR+PMvd
         d9Fw==
X-Forwarded-Encrypted: i=1; AHgh+Rq030PsL6JWTVeIc1nGkWWiPWhTFqwkvdadeiKh5al+XxIIDx0+ub5uYKqN6gUpDBIykKTkGOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw/UW6FeA8gixZW+MmCCI5eJ67BYqpXYwAakReQ+IjkO6BAdh8
	JeZJN3/WhfXKDRr51bdccEKRU4CFMCKzGwbODZfAcATJ1dDZdMwPybyD/E/ifda40DkYftQ2VCZ
	FbcNAnKc=
X-Gm-Gg: AR+sD10oL9JQQGMhyMILPdkYvk5ByK8JWFZYUgITNNB6f3xuZo7/lX1rkS/1JCLYDZf
	EBnpi+0h2VM62J5M3DCtmvuFIz7W0jHgyC8HnpYvGIg1fA6AWEMG3iAkz0Dc0/3K8JeyPotrHXI
	1FSLWvVM3MC2mSLRIH5SkmCma1sT4ZDrtPTJpu9bMnzYk8txv2engdkSDurx4sxWC7RE1/an149
	NsFruQk56xHMW+M8l7tddzgyM1fpcgWb1MEKQgnR96qwu427nk0vRuPTDq+S7oW9J2B2xSeI35Z
	UAHzHb2HjCjbxivfJszp+PGd72da6GZVzsV3f7iaCXGCzT+r6EFZ0+AGQh3OOsZZyjXRlJ3FRY/
	x0WXtV4GOSPoeemml2ynQbV8IFlktUltUv+6cKMy2FbMW3JZow9z7dzWuuGYb355ejwGlLrDqfV
	JIpyk0vDxe7DE2MXFU+f4UGg92u5PQKH26+JSNhm5JBtaWsof2pAz3FKilmg==
X-Received: by 2002:a05:6a00:bd09:b0:847:8ccc:d7c6 with SMTP id d2e1a72fcca58-84e931844b0mr6501081b3a.31.1785312087869;
        Wed, 29 Jul 2026 01:01:27 -0700 (PDT)
Received: from 1c1aead48890.. ([49.142.45.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdba3519a5sm540157a12.18.2026.07.29.01.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 01:01:27 -0700 (PDT)
From: Seongjun Hong <hsj0512@snu.ac.kr>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Seongjun Hong <hsj0512@snu.ac.kr>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] e1000: drop dead switch statements in configure_tx/rx
Date: Wed, 29 Jul 2026 08:01:00 +0000
Message-ID: <20260729080100.2057448-1-hsj0512@snu.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

remove unnecessary branch

Signed-off-by: Seongjun Hong <hsj0512@snu.ac.kr>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 55 ++++++++-----------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index 9b09eb144b81..5d67d61ebfee 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1599,24 +1599,18 @@ static void e1000_configure_tx(struct e1000_adapter *adapter)
 	u32 ipgr1, ipgr2;
 
 	/* Setup the HW Tx Head and Tail descriptor pointers */
-
-	switch (adapter->num_tx_queues) {
-	case 1:
-	default:
-		tdba = adapter->tx_ring[0].dma;
-		tdlen = adapter->tx_ring[0].count *
-			sizeof(struct e1000_tx_desc);
-		ew32(TDLEN, tdlen);
-		ew32(TDBAH, (tdba >> 32));
-		ew32(TDBAL, (tdba & 0x00000000ffffffffULL));
-		ew32(TDT, 0);
-		ew32(TDH, 0);
-		adapter->tx_ring[0].tdh = ((hw->mac_type >= e1000_82543) ?
-					   E1000_TDH : E1000_82542_TDH);
-		adapter->tx_ring[0].tdt = ((hw->mac_type >= e1000_82543) ?
-					   E1000_TDT : E1000_82542_TDT);
-		break;
-	}
+	tdba = adapter->tx_ring[0].dma;
+	tdlen = adapter->tx_ring[0].count *
+		sizeof(struct e1000_tx_desc);
+	ew32(TDLEN, tdlen);
+	ew32(TDBAH, (tdba >> 32));
+	ew32(TDBAL, (tdba & 0x00000000ffffffffULL));
+	ew32(TDT, 0);
+	ew32(TDH, 0);
+	adapter->tx_ring[0].tdh = ((hw->mac_type >= e1000_82543) ?
+					E1000_TDH : E1000_82542_TDH);
+	adapter->tx_ring[0].tdt = ((hw->mac_type >= e1000_82543) ?
+					E1000_TDT : E1000_82542_TDT);
 
 	/* Set the default values for the Tx Inter Packet Gap timer */
 	if ((hw->media_type == e1000_media_type_fiber ||
@@ -1884,21 +1878,16 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
 	/* Setup the HW Rx Head and Tail Descriptor Pointers and
 	 * the Base and Length of the Rx Descriptor Ring
 	 */
-	switch (adapter->num_rx_queues) {
-	case 1:
-	default:
-		rdba = adapter->rx_ring[0].dma;
-		ew32(RDLEN, rdlen);
-		ew32(RDBAH, (rdba >> 32));
-		ew32(RDBAL, (rdba & 0x00000000ffffffffULL));
-		ew32(RDT, 0);
-		ew32(RDH, 0);
-		adapter->rx_ring[0].rdh = ((hw->mac_type >= e1000_82543) ?
-					   E1000_RDH : E1000_82542_RDH);
-		adapter->rx_ring[0].rdt = ((hw->mac_type >= e1000_82543) ?
-					   E1000_RDT : E1000_82542_RDT);
-		break;
-	}
+	rdba = adapter->rx_ring[0].dma;
+	ew32(RDLEN, rdlen);
+	ew32(RDBAH, (rdba >> 32));
+	ew32(RDBAL, (rdba & 0x00000000ffffffffULL));
+	ew32(RDT, 0);
+	ew32(RDH, 0);
+	adapter->rx_ring[0].rdh = ((hw->mac_type >= e1000_82543) ?
+					E1000_RDH : E1000_82542_RDH);
+	adapter->rx_ring[0].rdt = ((hw->mac_type >= e1000_82543) ?
+					E1000_RDT : E1000_82542_RDT);
 
 	/* Enable 82543 Receive Checksum Offload for TCP and UDP */
 	if (hw->mac_type >= e1000_82543) {
-- 
2.43.0

