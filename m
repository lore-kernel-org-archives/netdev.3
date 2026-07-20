Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B742B424D5E
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558121; cv=none; b=Pv41gCaRQdpUOlYoTBbp/sGnJNIeM5JrJSCkhqrHy3slrUawD+0GZJ5pBG/RPc6bayIFMRrQUdYGHhoZVrPfEXymdPxJml53E9jp2N58e9L2fKQbBDTFN49ThThfMJtI4OykGZenoJxwqto5bOgr2cWKSCF53lPeixqU3T9owQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558121; c=relaxed/simple;
	bh=MyoDi/F67/Vtmeni+GqlRytHCLtNStiJMtnrDJx4KoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YXosK9j8hhkolqu4XgFYQKvtpXQ4Q4SbtysmIrRfWtaLA2Zv/1wet2zUXprAzxZRtYUBV2nJXFZFc3pWB+JJj+jX3PkCQDJUz8KWL0HwVdnY5VkuPsU+SlGZXJ86XCMyjlwyYoWgvl/qNsw19jCRUHKgV5GLD/4vDT/f7zpquD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX3d04Fv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX3d04Fv"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cca0c5799eso78168025ad.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 07:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784558119; x=1785162919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z3VaPip/rhZHQR85NvyPs/zlByfwCUa6xlhWOu76l9g=;
        b=RX3d04FvbeyGSjoDz9LiOTUSQUfQ6Fq7ZLYFu32jHV0DT+FJW43sGHU+UJ8NQgJRe6
         LtrlWAskmVRTXpu3XFAabN2w54vrGzngj/FXMyTBYN4Zy1WXx5s5tA9u95cwpO3vHgo4
         OFC2WbHJhG3+RhGvYoaHzpNTG1v0PngIq/d9ZqqFDC/qtzpgUIb203j8CgY9J+fClZHB
         9I/WXlRJP0rXn/QDYZTWX71sl1HiDk0WhniC4flaaFr3G4P3Yn+Z+H/Dcgfj26TKsINH
         93GELs/cptkr7beYDtwQ3lFaWAK6j97MG6jgaSFc0Q6PPixbR3lLxjkFqen8/SEz+h+p
         C1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784558119; x=1785162919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z3VaPip/rhZHQR85NvyPs/zlByfwCUa6xlhWOu76l9g=;
        b=nUM31uu6u0jT5lhFoL3BV8J90PcqJAMjV7YYld4B7FG34eqckGZ9JXae4S0IaIu3qw
         MEsDa8BtQPoEJXAm5vsOFiIiupIQOIGi4AxRCxvob+h43hHmLnzzpRtWQToVdFhX/9rc
         nKfRJvuSqRugWQ4a9hMtUq/ZwWkMWLP8XiN4VRNbclWnPavVbRv2cxnMSTiP6s5Yfk7X
         UiweFSt1PYwkalh+yqO0kh2SlSkJ5HcQ1UfYmb79aNPWN95Cm/mF0GL9bm1lBP32QWXm
         BMXtSaua/rATzDghYZ8vVkySNeyuP2mICv6XcIKMiGrePybN6+twWYBXadnFIKfGs3UU
         lRFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrf1K8RwFNlQDcwu1R25+Q2koAkJa9mwLjYUjYkTRJsMNDlI1q0TaDMcFKyiqWlnjQgBrSg58g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh4gexXC7yaAwzFdkwNFMAr8tRc7CTCsaywJEGHVKMfAWLvgTz
	dkduMQQb6/3m9u4l37xxmDOx+16FhK05HoE9E44Ndt7iHXfwF9bF2Nc=
X-Gm-Gg: AR+sD13HZC6vUHMRZtxnjpx4ZXDkySxADPYDk7chAjvDxJR8jxH1p8TaEZk5a2DZwNl
	9aA9Tc6qCJHHq2oLRcKVurJx/8Dnumk2i7Gi/ndjp2GWvyHdXrNB+2CsACkeFOaSwjn34KdM5EI
	t04q1PO9k/gjy/BdOUInkWxWtOk4petaYzOZKUB054Q9cOENKmhH6QFktAAaTIt6patliqAbUyj
	MMwCXJ5W+TdI5LNwJ9kah8S2UH46R08tgMJP3qNMzKJsCKMC4fXexckZ/nytQMo06F9miiGuP7v
	9cROw+mqgMD9WWumuzN9zJb3r9tYI4LCETjYFkjsVJkVDd38O6fvi+WWKUtdGs1PEbg37AorS5O
	xYqVIj5fbgxlznf750rPkkcTyNHpr/y88lDCDzFgEKd3O8wACR8TwztnZEy0Cf8nEKay4rusFZm
	OxhIb0GQauJwlNeURnVSQzVyhen1DhxpXKWSKfQx0upVTwXkF2bqDCiRgFWO6hiETIcXjsnY0aD
	Df4YqmiuK7YoUqYzgTHPxE7aavOFQHEdWDUg3sR
X-Received: by 2002:a17:902:d4c5:b0:2c9:2ee6:693e with SMTP id d9443c01a7336-2cf34873ddfmr172634965ad.18.1784558118851;
        Mon, 20 Jul 2026 07:35:18 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf347166e6sm57973575ad.59.2026.07.20.07.35.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Jul 2026 07:35:18 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Milena Olech <milena.olech@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v3 net] idpf: disable PTM on probe failure and on remove
Date: Mon, 20 Jul 2026 23:35:10 +0900
Message-Id: <20260720143511.43408-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idpf_probe() enables PCIe Precision Time Measurement with
pci_enable_ptm(), which takes a reference on the device and on every
PTM-capable device up the path to the PTM Root.

Neither the probe error path nor idpf_remove() drops that reference, so
the PTM enable counts of this device and of its upstream path stay
elevated with no bound driver, and the device's PTM control bits remain
set.  pcim_enable_device() only arranges for pci_disable_device() and
does not undo the PTM enable.

Add the matching pci_disable_ptm() to the common probe unwind and to
idpf_remove().  pci_enable_ptm() failure is not fatal here, so guard both
calls with pcie_ptm_enabled(): pci_disable_ptm() decrements
dev->ptm_enable_cnt unconditionally and then recurses upstream, so
calling it after a failed enable would drive this device's count negative
and wrongly decrement parents shared with other endpoints.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 8d5e12c5921c ("idpf: add initial PTP support")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v3:
- Rebased; aa8671af0c38 ("PCI/PTM: Drop pci_enable_ptm() granularity
  parameter") changed the call signature, so v2 no longer applied.
- Guard both pci_disable_ptm() calls with pcie_ptm_enabled(), as
  pci_disable_ptm() is refcounted and recurses upstream since
  e1092d5e15e6 ("PCI/PTM: Do not enable PTM automatically for Root and
  Switch Upstream Ports").  Raised by Tony Nguyen.
- Dropped the v2 claim that pci_disable_ptm() is a no-op when PTM was not
  enabled; that is no longer true.

Changes in v2:
- Disable PTM in the probe error path, as requested by Emil Tantilov.

 drivers/net/ethernet/intel/idpf/idpf_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index ab3c409..97bafeb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -159,6 +159,8 @@ destroy_wqs:
 	mutex_destroy(&adapter->queue_lock);
 	mutex_destroy(&adapter->vc_buf_lock);
 
+	if (pcie_ptm_enabled(pdev))
+		pci_disable_ptm(pdev);
 	pci_set_drvdata(pdev, NULL);
 	kfree(adapter);
 }
@@ -266,7 +268,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (err) {
 		pci_err(pdev, "DMA configuration failed: %pe\n", ERR_PTR(err));
 
-		goto err_free;
+		goto err_disable_ptm;
 	}
 
 	pci_set_master(pdev);
@@ -279,7 +281,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!adapter->init_wq) {
 		dev_err(dev, "Failed to allocate init workqueue\n");
 		err = -ENOMEM;
-		goto err_free;
+		goto err_disable_ptm;
 	}
 
 	adapter->serv_wq = alloc_workqueue("%s-%s-service",
@@ -366,6 +368,9 @@ err_mbx_wq_alloc:
 	destroy_workqueue(adapter->serv_wq);
 err_serv_wq_alloc:
 	destroy_workqueue(adapter->init_wq);
+err_disable_ptm:
+	if (pcie_ptm_enabled(pdev))
+		pci_disable_ptm(pdev);
 err_free:
 	kfree(adapter);
 	return err;
-- 
2.47.1

