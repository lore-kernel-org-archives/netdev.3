Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023693998BF;
	Sat,  4 Jul 2026 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783178520; cv=none; b=qGox7oRVnMJaI8XuUIerERXAFQ0wkc7bOpOXZu25qEuTVPDAVKtFx7ZnsoJ5RXUtYj7GOtOAfm9XTxrAdmVwFOLdPslqRR6GqNUe+mObW0cI5FQTuZmQLiV/6YxO/Tm8OScOORy1MfOQTGKBiTmGvKf96Imo64e3Vj6rDs1cfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783178520; c=relaxed/simple;
	bh=lG5F2xKGGWbE3H/wClHUhFtkn9YwYTFPwSdnfklL9l4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fP+lkVsUpGTFYq0cHbcOp0qZuHYhpwbkMaYUbbe5jrdBg+u8M1Y8KKD4aUhV6G0xEJbS2rDGDxleYtSV4IwtZkG8udm0i+zfiDRbAWshXb8fC190V01KkX5v7RpRqdTaBxGcyCgZf0ZOySfESjidodDETjMXOrrx3GI+nNF/n80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAAnoPMHJUlq7KHbFg--.2715S2;
	Sat, 04 Jul 2026 23:21:44 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: davicom: dm9051: add missing MODULE_DEVICE_TABLE()
Date: Sat,  4 Jul 2026 23:21:42 +0800
Message-ID: <20260704152142.50156-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnoPMHJUlq7KHbFg--.2715S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWktrWrZr4UtryUKw4fGrg_yoWDKFg_Cr
	y8Zr93Wa1jkFZYkan2grZ3Z34S9w1rWrs3X3yvgF90qa47Jr13XFn3uF93tw1Dur18KF98
	JwnxXF1fC3yaqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
	Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x0JUW6w
	tUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The driver has a match table for the spi bus wired into its driver
structure, but the table is not exported with MODULE_DEVICE_TABLE().

Add the missing MODULE_DEVICE_TABLE() entry so module alias information
is generated for automatic module loading.

This is a source-level fix.  It does not claim dynamic hardware
reproduction; the evidence is the driver-owned match table, its use by
the driver registration structure, and the missing module alias
publication.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/davicom/dm9051.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/davicom/dm9051.c b/drivers/net/ethernet/davicom/dm9051.c
index 59ea48d4c9de..194494ac5582 100644
--- a/drivers/net/ethernet/davicom/dm9051.c
+++ b/drivers/net/ethernet/davicom/dm9051.c
@@ -1241,6 +1241,7 @@ static const struct spi_device_id dm9051_id_table[] = {
 	{ "dm9051", 0 },
 	{}
 };
+MODULE_DEVICE_TABLE(spi, dm9051_id_table);
 
 static struct spi_driver dm9051_driver = {
 	.driver = {
-- 
2.53.0

