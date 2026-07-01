Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC621257F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782869816; cv=none; b=scAmNJena2cIXINZXPgyNXc80wky6zDlQ1cawdDK3En3M2wWYoo4fUGNL9Ia+GafFsSgJGy02cJjmVBExdI/UGXaBSu17mVvGvBrGI7YWgfzmfbMFzm+R7xf0mb1+HOU9cpNtBipmgsbwTmILXfUEqeagcDUJzkglJz2WLNkxqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782869816; c=relaxed/simple;
	bh=Vio8Na6AYtoZEsRTPZGDom+nKJqt1LVckgVFAfdY9UU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WqOyMnv5DO5QbJZEp/fdaMgd78Kk7df+j5PzGIByhBW8NOb+lYIUIyQ/b3ftvp0wtfsOf4KLB5hOUUwAxFvlZ33Uvx1RaDynY8a8GI7qxxuz4t0Maj3J+uNlgaK9kpfynjxZ7wFvPVn49TEQKAudxDwGSF8Gab92TrMcWerul9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bXf0jlvL; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bXf0jlvL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kk
	/mqLcjOiQxsynfAZGTVGxzxLPRDaop96Kg1Dkj/3c=; b=bXf0jlvLLaiHru409Q
	ouqez9HLyhro6uGbxbvZ3yalIQUp+n6tsH83nGSTsZ+qoOuVcnph0xNvwG1Fl2qa
	3sultl+y62Ek8HT7ljNPJkMF7vI2SAMWVJuOB1slAs6s6vsFuJdxeX+lzKnYnrRG
	3dHak3cBFwJySDKXhG65D78uc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBHd0oTb0RqhqMdHA--.8248S2;
	Wed, 01 Jul 2026 09:36:21 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com
Cc: anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net-next v2] ice: use dev_err_probe() in ice_probe()
Date: Wed,  1 Jul 2026 09:36:18 +0800
Message-Id: <20260701013618.29934-1-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHd0oTb0RqhqMdHA--.8248S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw43tryDJr13Ar13WF13XFb_yoW5WFW7pF
	Z8Cas8Gr1kGr1rW3s8WF1qyr95K3yvqa43KFWDJ3Za9rn8Ar4DtrW7tFWS9ryrGFZ7Kay3
	XFyjvFWUuF4xXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWxRgUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-RWM92pEbxWodwAA3Y

From: Rongguang Wei <weirongguang@kylinos.cn>

dev_err_probe() logs the error and returns the supplied error code, which
allows probe error paths to be written more compactly.

Use dev_err_probe() in ice_probe() for error paths that currently print an
error message and immediately return the same error code. This keeps the
existing error handling semantics while reducing open-coded logging and
return sequences.

Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v2:
  - Fix commit message per Aleksandr Loktionov's recommendation.
v1: https://lore.kernel.org/netdev/20260630032537.42605-1-clementwei90@163.com/T/#t
---
 drivers/net/ethernet/intel/ice/ice_main.c | 24 ++++++++---------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index e2fd2dab03e3..31aa42f8e6d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5161,10 +5161,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	struct ice_hw *hw;
 	int err;
 
-	if (pdev->is_virtfn) {
-		dev_err(dev, "can't probe a virtual function\n");
-		return -EINVAL;
-	}
+	if (pdev->is_virtfn)
+		return dev_err_probe(dev, -EINVAL, "can't probe a virtual function\n");
 
 	/* when under a kdump kernel initiate a reset before enabling the
 	 * device in order to clear out any pending DMA transactions. These
@@ -5188,10 +5186,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return err;
 
 	err = pcim_iomap_regions(pdev, BIT(ICE_BAR0), dev_driver_string(dev));
-	if (err) {
-		dev_err(dev, "BAR0 I/O map error %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "BAR0 I/O map error %d\n", err);
 
 	pf = ice_allocate_pf(dev);
 	if (!pf)
@@ -5202,10 +5198,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 
 	/* set up for high or low DMA */
 	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
-	if (err) {
-		dev_err(dev, "DMA configuration failed: 0x%x\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "DMA configuration failed: 0x%x\n", err);
 
 	pci_set_master(pdev);
 	pf->pdev = pdev;
@@ -5240,10 +5234,8 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 		return ice_probe_recovery_mode(pf);
 
 	err = ice_init_hw(hw);
-	if (err) {
-		dev_err(dev, "ice_init_hw failed: %d\n", err);
-		return err;
-	}
+	if (err)
+		return dev_err_probe(dev, err, "ice_init_hw failed: %d\n", err);
 
 	ice_init_dev_hw(pf);
 
-- 
2.25.1

