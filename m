Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339333A9854;
	Sat,  4 Jul 2026 12:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783168052; cv=none; b=FSIrofuR/Jh667QM6/EmGJqhuGHfxCA+edmQ3UigS4SNeQUIA/rN2XNR9mGAo/IBAplBQOoM2hlkDQytcMrae03xmdtRArs6Oh6j/PjVsIvawdyDX2FK0pfgbowWA1DMWoq/4cWtaFOXjFbtzK2KfMnfO0vUbu/25yPINWIgE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783168052; c=relaxed/simple;
	bh=7lEDdwAigF1bVKSFUzC/HYcRqbKZtH7wlJ1VmQ/1W4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JI+HNqs/BrMJTNwSjf7+YsurMXhi+zZrj1rTVyVeIlxzkjVo+/KJj42UnqyEn+UOYxVltxFlKJIBt3tbJWMzFprvgjhnJmG7pwkxyuc6b1rxD1/waRIPUce5hJf/UHXuR8p0gIdxu6pdOThFWh300jmpYduCkHQXUnoizddYzBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowADn47os_EhqexzWFg--.11569S2;
	Sat, 04 Jul 2026 20:27:24 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: xscale: add missing MODULE_DEVICE_TABLE()
Date: Sat,  4 Jul 2026 20:27:22 +0800
Message-ID: <20260704122722.5715-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADn47os_EhqexzWFg--.11569S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr45uw1rurW7Aw4DuryrtFb_yoWDurgEkr
	18ZFs3Xw4UC340ka1Ykw4fZry0ka4Durn7KF97KrWFq3W7Xr13JrWkWw1fAwn8Wr18XFWD
	Xr9I9F18C3y7KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUCNt
	xUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The driver has an OF match table wired to .of_match_table, but does
not export the table with MODULE_DEVICE_TABLE().

Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
information is generated for OF based module autoloading.

This is a source-level fix.  It does not claim dynamic hardware
reproduction; the evidence is the driver-owned match table, its use by
the platform driver, and the missing module alias publication.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/xscale/ptp_ixp46x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/xscale/ptp_ixp46x.c b/drivers/net/ethernet/xscale/ptp_ixp46x.c
index 558c4f8d23f7..c805d1df5d4e 100644
--- a/drivers/net/ethernet/xscale/ptp_ixp46x.c
+++ b/drivers/net/ethernet/xscale/ptp_ixp46x.c
@@ -307,6 +307,7 @@ static const struct of_device_id ptp_ixp_match[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(of, ptp_ixp_match);
 
 static struct platform_driver ptp_ixp_driver = {
 	.driver = {

