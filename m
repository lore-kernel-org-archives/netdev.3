Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A6A270EDF;
	Tue, 25 Aug 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650854; cv=none; b=GYZsHneLbsfsHE3FsGZO2HCX8ouC59DC5/syBXDOgMpnLdvtdd8p9/M+fNEJlMMuIle6VRnln4A4rbjx0ltzLAG6JRuJnVHTHneX8N5tWZmZIRX3y4cLejQkgaOO1y8iPoE/n16FtBDO1kuWN2GWR5qCJtptt3u1vag3PyLaIVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650854; c=relaxed/simple;
	bh=1sR9FQ8lgegWWL9TjYm8e52lrR9uubdBoTHv2JVI4bQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=l61F5Xi31vnSf2gKvMHaigXpljIEZK/LPslROCUYHPV4xYLGlzYXK76xCvKEWm+0FGs1BYzKToecOrcgNi1EmXcPwZ2BeBC6mpHKHme56oa0WNwjCmbZ8ZxQdmxZuDf2upXasRX6009Ko/jVGm3dG5dCaDaXFQcKhb/MO9YNKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=N+Kw5Bo6; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="N+Kw5Bo6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787650847; bh=1sR9FQ8lgegWWL9TjYm8e52lrR9uubdBoTHv2JVI4bQ=;
	h=Date:To:Cc:From:Subject;
	b=N+Kw5Bo6q7Ikx5UopsKRcbUzXML/akAjVMzla+UJ7CpJ85m8IeYy01KkAwcmMNfy0
	 K50YWPvYoY4ddLMsi+8BeWj6eqHNr6w55WDS7HAKa9uoT/EYVepHFX2sGlo6m68Saf
	 gMVTS5CQJpEOJ2NsjitaTqTlaIvg9Aqq8+IyLAko=
Received: from [192.168.255.10] ([111.206.96.150])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id A2D37EF3; Tue, 25 Aug 2026 17:40:45 +0800
X-QQ-mid: xmsmtpt1787650845tjf60vcr8
Message-ID: <tencent_E2AB9F7DCE50A5CA66137A198A2D847A790A@qq.com>
X-QQ-XMAILINFO: MXi6VldghLL7JQ2mN4YoL72Us4YTiU2Fu1CAs0+miFzgJRHd9Nx+XTk+TiYy/v
	 QmKRi+kN8AqFj9UbDn6kXhPc2HlJzFCe1laIlJbf6H7ExUEUKTCaLsYguijz3NjEI/MtGAp28tMa
	 UZ3F8YUYbm8G9Ey2Qb6HRZG8o/SCHerWRTJsf+Y0HP/X7vwu/jnRjUzrdE5kc5b2OpBBYxJcHCDX
	 9gfbpPR5tVSbNvvEsrc6VV0sXupuHK4ELzPWY2VRUkf4fbd61tsqEB/AbUTBgj0GgeptOOAkPZf3
	 C1qm2VGxTqDiQMo2iZJ+bbV6XOrRBSC7rQUkb1VMuxzofzZz5BhaLtr+q1MYak1mIr9XFA1ZFXNp
	 JHAD64ynSlMvrW8rZdbzRF4y8vQgszvk3aBZWNGZvzb6H48qSheC0BEKBM952/nr6rpNhJTb3NA0
	 cIVL6WwFCNtOBgrZK1Eq5s+2wBmoxmCrqdWlCwuywP5DbLT46hZU+E1vfCg2ENKMMwA043Wwf3iO
	 p/jFN6XSP/ph9Z/2ABDWCU6lSgGbfuY4LHBKVX2SViQeRuFtg3aRx9MoCxeZ4Z+GpryhZTo2COIE
	 thhmxVXjzGe7zPTEq3/gehTC0ZZu5Pukjv9dB0PJe4rlMCB3RDKxvNJ/nGcLLuaE/H4MvY5KdwIr
	 izIkgfdsYhLnDPMr0Ho7TFkBucZteQidYgadZo3zeTLW/sNgG62H9FZ1Ump6c7K67nIsRuPPruFh
	 XKcujivZksPbFF8xamWXec4Nz6kSqfZgQUxiAOVdeao9m2YxYE3pdu1IJU4a8051ou4wzHFKHyQI
	 O7F0ap3b9qxr3n8HN+tV1y7LC3qbdfzx5SOj2ERZDV9mDBsqeCX/1hGsUR9CqWcad27l6rshYWif
	 g45dVHGIQccEMwG7jOAnhslrO0VsjAphzQkZ9GkE3UAOhmlyB6QZTmOb3aVop0cWIlcb3cbw7tS3
	 BAVJaXZaZbPjO2ihbZIPUGGoTkBNLFIE0/GiqUUDR0v8taPg5fuqXfolcdb/Q53jAsYOr29PWgy1
	 KFT7FSzRwybofgcq2PJJFPf7yUGIUJ7QdwVjbwXMJbK1EQqXHVNnID08qa5KU3IXQZ65eDQRMYkD
	 ZnVYyr
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-OQ-MSGID: <3ccb6b67-e148-4877-b4a4-0c5ff80c7d59@qq.com>
Date: Tue, 25 Aug 2026 17:40:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Yang Zi <2959243019@qq.com>
Subject: [PATCH] e1000e: validate BAR 0 MMIO resource before ioremap
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

e1000_probe() ioremaps BAR 0 and then accesses it through writel()/readl()
(e.g. __ew32() in netdev.c and er32(EEMNGCTL)/er32(STATUS) on 82571 parts)
without first checking that BAR 0 is actually a memory resource large
enough to hold the register space.  A device exposing a short or non-memory
BAR 0 would make those register accesses fall outside the mapping.

Validate that BAR 0 has IORESOURCE_MEM set and is at least 64 KiB (which
covers the largest register offset the driver touches) before ioremapping
it, and abort the probe with -EIO otherwise.

Signed-off-by: Yang Zi <2959243019@qq.com>
---
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..f73e4da5be5d 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7449,7 +7449,17 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
     mmio_start = pci_resource_start(pdev, 0);
     mmio_len = pci_resource_len(pdev, 0);
 
+    /* BAR 0 must be a memory resource large enough to hold the full
+     * device register space (at most 64 KiB) before it is ioremapped
+     * and accessed via readl()/writel().
+     */
     err = -EIO;
+    if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
+        mmio_len < 0x10000) {
+        dev_err(&pdev->dev, "Invalid MMIO resource for BAR 0, aborting\n");
+        goto err_ioremap;
+    }
+
     adapter->hw.hw_addr = ioremap(mmio_start, mmio_len);
     if (!adapter->hw.hw_addr)
         goto err_ioremap;


