Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4991E3D8132;
	Mon, 25 May 2026 08:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697599; cv=none; b=nme3xBcW5sVjCUvVKUAXA6QBlcG3QzOYjgtt5284BhPk+i6oGwMO+O+6tk7d25e5rFeghuvwySdz75JEaxmxueZR9HQsqcMput2F09UX8CCTjiI9lV3vETKlyioExi25SKJT9DSBTC7iq6MJHOqRmm/Lt9LRpRccWb/PYkXlHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697599; c=relaxed/simple;
	bh=ks1S0/z1GDCT66ukqI4KGA8S+ogvXH3Pqsh2FmB0PKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dlZ51R4Luj9ZTcsTeQ35s87ts9uXx+GHZpBRBMYZ4610y3ak0WEWvNLomBgckWI35qCziRAeVu1vjMI7CdbFdPk3d5pqWf/BdEIkdJ9s9P8gtt2IuQhvlTaLgBKPLH+wiYWUvh2/rBX1SnVnVZOCvAr922QaY/sPO7Rbjg8qzJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from localhost.localdomain (unknown [36.112.3.223])
	by APP-05 (Coremail) with SMTP id zQCowACX7dCkBxRqxz9mEQ--.6360S2;
	Mon, 25 May 2026 16:26:12 +0800 (CST)
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
To: sgoutham@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	pombredanne@nexb.com,
	aleksey.makarov@cavium.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: thunderx: fix PTP device ref leak in nicvf_probe()
Date: Mon, 25 May 2026 16:26:11 +0800
Message-Id: <20260525082611.61817-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX7dCkBxRqxz9mEQ--.6360S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWxCw1fXrWDGFWUAw43Jrb_yoW8XF4rp3
	yDJFyakryfAFy5W3WDXr18uas5Gay2ya4rCr4kC3WYgwn3ArWktFy8Kr4jvw17XFWxKa43
	t34Ut348CF4fJaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olkt0x0ld0ww6lv2u4olvutnvoduhdfq/1tbiCQ4SE2oT57CD-AAAsX

cavium_ptp_get() acquires a reference to the PTP PCI device
through pci_get_device(). If any initialization step fails
after cavium_ptp_get(), the PTP PCI device reference is leaked.
Add a common error path to release the PTP reference before
returning from probe failures.

Fixes: 4a8755096466 ("net: thunderx: add timestamping support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 0b6e30a8feb0..d794aec80821 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -2109,8 +2109,10 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	err = pci_enable_device(pdev);
-	if (err)
-		return dev_err_probe(dev, err, "Failed to enable PCI device\n");
+	if (err) {
+		err = dev_err_probe(dev, err, "Failed to enable PCI device\n");
+		goto err_put_ptp;
+	}
 
 	err = pci_request_regions(pdev, DRV_NAME);
 	if (err) {
@@ -2264,6 +2266,8 @@ static int nicvf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_release_regions(pdev);
 err_disable_device:
 	pci_disable_device(pdev);
+err_put_ptp:
+	cavium_ptp_put(ptp_clock);
 	return err;
 }
 
-- 
2.25.1

