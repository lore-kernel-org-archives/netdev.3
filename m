Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255B2440634;
	Tue, 15 Sep 2026 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457541; cv=none; b=r/YGJ/kHMGBv9us33kA/UGCAfTZENopXRvkZVzII7M/eI+2206JlrBua/7Q8QP27/NpOEqM52F3gKY9g8I23Ld99oqL6afM8FerIMXuBjaTMvh0yxdDGETK1OFR/1s8E+HMilCBCKK6403Fdusq6AdWdlUEbiZref3qh4cACW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457541; c=relaxed/simple;
	bh=4lrDSt9b3Z+QlOBFrNJa7mTGdvGM6/21viXwh8CdHso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POdIC2FhpE1SguCXhSj4EF3lnv+n7xZzpBd1oAl+2ysisWVZlKo7reEk32Z9WblyoCaEgY1A4YqAJazMGew6f/2ctBcNHijvD/dsq7pYauQnxBv2JG+RX8cPUf4EaZOzGf2NmgCXNfP31/bgR2wVrh+to3WlcV4tm6AIMtRKaVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxytF+9KhqUh0MAA--.35159S3;
	Tue, 15 Sep 2026 15:32:14 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxmM139KhqQukgAA--.4430S2;
	Tue, 15 Sep 2026 15:32:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Yao Zi <me@ziyao.cc>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] net: stmmac: Default DWMAC_MOTORCOMM to m on MACH_LOONGSON64
Date: Tue, 15 Sep 2026 15:32:06 +0800
Message-ID: <20260915073206.6665-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxmM139KhqQukgAA--.4430S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XryxJFWkGF4DWF15WFWxAFc_yoWkCwcEg3
	ZFvF1fJw45ArWUK342gw4rZ3sI9a1ku34fAa1Utayruwnrurn8X3s8uryqkrnrWw1rZF9r
	WrySq340y347tosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

Currently, there is no network connectivity when upgrading to the
latest upstream mainline kernel on certain Loongson machines such
as Loongson-3C6000 server, because the driver for the onboard NIC
is not enabled.

Enable the Motorcomm PCI DWMAC driver as a module by default when
building for the Loongson-64 platform.

This ensures out-of-the-box support for Motorcomm YT6801 Ethernet
controllers on Loongson machines, enabling demand-loading without
increasing the core kernel image size.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index ab3c4cf96423..c86d6c08977c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -408,6 +408,7 @@ config DWMAC_LOONGSON
 
 config DWMAC_MOTORCOMM
 	tristate "Motorcomm PCI DWMAC support"
+	default m if MACH_LOONGSON64
 	depends on PCI
 	select MOTORCOMM_PHY
 	select STMMAC_LIBPCI
-- 
2.42.0

