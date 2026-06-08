Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80443D3324
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937754; cv=none; b=PKJ9gkHlFo3jZVlTKJtJlwUuNvNU8VbgPeD52ioW+nXhy417L8u+TkwWcqxLYWL9l2ZyHqq7dALnBbxL8sO23mpOQxpqxKQr2TIBLGRVKcMAqcKXq9VKewvpIIspHb/lVufnbsiWqTw0w9VWWqhjoejsxeSrmnyOWucV75GS15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937754; c=relaxed/simple;
	bh=a2gNHrfQXAbpHgyrcom7vv6lcJ0JKp5KwHsJj2AyLkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAWdIY2EWB2V/4v6bt/SbKnfRNKhKbzvmbh1sjpyvHo6m78EDm2KRVTh/tUUgUBszbrv3aO+SrMDx2WV2NVnI9B06LGaI4KQ6EF5uKphfwYnjKnHCrCbifHtIJgu5WlZWIIBVaXnrXlEmLEF0xrJMtV6aL48DCIsm5m8yGMd3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AKTyE//5; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKTyE//5"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5177b1a7441so66025801cf.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780937751; x=1781542551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZ5g8neWMUm1buYqST+RxCz1TcAX6r9PD0gYi+UhGC8=;
        b=AKTyE//58kRbRW39nl3YrQzcUwiYaa4zY6ikhRZP98dMDtha0y5BCj5lLLOexQaN1d
         ikt363NJuAHWB+/wCikE1fKAMZO8NF1nYeJHZmrpSYbOXntMO/CGtNbJ0Htub+hU+Wrr
         QcbHijSjAf/2DpIppkonMllCLxdBNjO/LOf2a1Hz0lRTKjLM+gLCmdUZIGcBmcLaibZl
         OcpNkOngX3AcBGNSfyCQepSDBGTck5ZdGVZg3iADjDergGcEADzGeSmBWK01L5PSLxIS
         KQWJXG8VM0Xq1xMJN+h38J/rcpYcYMbfT0LyL2LMinhMZkWqG8zl5FORALQhIt0QwNWM
         gStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780937751; x=1781542551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ5g8neWMUm1buYqST+RxCz1TcAX6r9PD0gYi+UhGC8=;
        b=Lwvfm9Or6QnxI8NMF2dDEGacBGysruOFUZrB+twpN54Fd8tjnPhC2WNDATnBNA6ULB
         spaixhllprNrO7AxbQBV0nfvpy/sl5EI4IKaCz1x7d4M5xs3TcSscnJo9Wr3GPqBi3NN
         a6eJy/JvZsPed7qMSPfJ13m25LPWnqUo8zKVPkpP1OmRzvsUNE1m9RkbANV2t1uxpWr4
         l7zksQXVJUGesKQiO+xogyIrac8TRPUa9kzW0d8KoLaFqO5KQXWeHWCaeuzFxn3sGQUR
         vOavTlRfqoxTETi8JtQI6VMxv7z/388o05IeuuB8bxjzUwAoxVM2Cwcq917plhZjL+JD
         bATQ==
X-Gm-Message-State: AOJu0YwIUhsalVkS7Mggu1kcEre72O6xvkAy3HsbxIGqtDAFDwYb4hr8
	2lJA9L7NeWzdbo/W6uaSp5XCIFJgdEh74o3BF+RsnbbKyWPhHYYXiZLO
X-Gm-Gg: Acq92OHQVbuRZ1CIIeJq521qsTJddCf5CZl1LfT4taPbncjOiDSqE3uldkeQkXmM2Dr
	ZNryQNrKcKie7TeSgqmD7f7bIX5RprpGldPFaKzqi85xYauAh3+ULJ1DIta/oHafMhW2S49donk
	mVqAZno2yyAr1fZ6fbeDbVmBGTLuPjWn33oax78smkztNR+zmqFYLDJMqfWoLoX32ZmjnSqIm+r
	W2ClVGDvnpc87SDCTkLuQb1Ry7oWWMqn6e/3uifIQThB2POEljCmsj6Geh37Bxh9sd6y2lCEcWM
	hIi4uB2S4AdvNpvhwVwgC9vi3fwF7g+JiGGXvSXg1Kgu0RcHXau3zJzygB37W3ZlmPIPNBo9cwO
	cyf+Oh+kEZIagQG6um850sl7AD+PDOUYDXHCnOUTDAr4g7KEyXCKS6Yh1j1jSQK5mWL6/JGRtBq
	QjkKTOCePDaduPgbABJRY9M4X05FYiDLWWayuUT4huK+Y57iSiL8w=
X-Received: by 2002:ac8:5a0b:0:b0:517:706f:9923 with SMTP id d75a77b69052e-51795b727b6mr227912541cf.1.1780937750613;
        Mon, 08 Jun 2026 09:55:50 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fa7fsm171522916d6.9.2026.06.08.09.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:55:50 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH net-next v2] octeontx2-af: Fix PCI device reference leaks in debugfs
Date: Mon,  8 Jun 2026 12:55:46 -0400
Message-ID: <20260608165546.61347-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cgx_print_stats(), cgx_print_dmac_flt(), and cgx_print_fwdata()
look up the RVU AF device with pci_get_device() and pass the returned
pointer directly to pci_get_drvdata().  pci_get_device() returns a PCI
device with an elevated reference count, so the lookup reference is
leaked on every debugfs read.

Store the returned PCI device pointer, check it before reading driver
data, and release the lookup reference after pci_get_drvdata(). In
cgx_print_dmac_flt(), release the AF lookup reference before reusing
pdev for pci_get_domain_bus_and_slot().

Fixes: f967488d095e ("octeontx2-af: Add per CGX port level NIX Rx/Tx counters")
Fixes: dbc52debf95f ("octeontx2-af: Debugfs support for DMAC filters")
Fixes: 49f02e6877d1 ("Octeontx2-af: Debugfs support for firmware data")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
Changes in v2:
- Keep using the local RVU AF pdev returned by pci_get_device() instead
  of cgx->pdev, because cgx->pdev belongs to the CGX/RPM device.
- Rebase on current net-next so netdev CI can apply the patch.
 .../marvell/octeontx2/af/rvu_debugfs.c        | 31 +++++++++++++++----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index fa461489acdd..04ba091773b6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2838,9 +2838,16 @@ static int cgx_print_stats(struct seq_file *s, int lmac_id)
 	int stat = 0, err = 0;
 	u64 tx_stat, rx_stat;
 	struct rvu *rvu;
+	struct pci_dev *pdev = NULL;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
+			      PCI_DEVID_OCTEONTX2_RVU_AF, NULL);
+	if (!pdev)
+		return -ENODEV;
+
+	rvu = pci_get_drvdata(pdev);
+	pci_dev_put(pdev);
 
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
 	if (!rvu)
 		return -ENODEV;
 
@@ -2958,8 +2965,13 @@ static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
 	u64 cfg, mac;
 	int pf;
 
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
+	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
+			      PCI_DEVID_OCTEONTX2_RVU_AF, NULL);
+	if (!pdev)
+		return -ENODEV;
+
+	rvu = pci_get_drvdata(pdev);
+	pci_dev_put(pdev);
 	if (!rvu)
 		return -ENODEV;
 
@@ -3014,9 +3026,16 @@ static int cgx_print_fwdata(struct seq_file *s, int lmac_id)
 	struct phy_s *phy;
 	struct rvu *rvu;
 	int cgx_id, i;
+	struct pci_dev *pdev = NULL;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_CAVIUM,
+			      PCI_DEVID_OCTEONTX2_RVU_AF, NULL);
+	if (!pdev)
+		return -ENODEV;
+
+	rvu = pci_get_drvdata(pdev);
+	pci_dev_put(pdev);
 
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
 	if (!rvu)
 		return -ENODEV;
 
-- 
2.43.0

