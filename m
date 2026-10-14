Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9174939B94A;
	Wed, 14 Oct 2026 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791948375; cv=none; b=HNhWjswyYWPTOJsrr8rDQJqGChT72xLIMbFbQjx/MdEu1CCa+YAUPlmcxOWE6w5fg2aeU35tGWxMUtGwHmOjvr6xZuiSWHDOtTF7gUEnCrj0M2SLjMe+MaL4GfMbsZJNnODJr/xZxMHTe6AVQbEL3aFGyIjWBezwNRt+PqYOTLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791948375; c=relaxed/simple;
	bh=1MkMYXRkCCDApZ3mxxdFy6NmCVENs4XSZvohPNx/Uw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QpYmg4H0T5VlB2sGbZx89DxwpaG9kzcqo8dgX7WQ8qYBFgbr0Jofr7GyPEFiVSpFIB0GzrXlEqLiodb0K96HxbHQGtg2LaXYbqDaw80yeF5rsk7zESdAu12FPyumQmqNQ3g08eRXGYkatlhumSjh4OrFoSWTkfkzf+mudSspvNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VrCTKYIu; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VrCTKYIu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZC
	7IVOM91nENCBz/6/raj1xaaQ7jxcRs4GVZUTNAE4A=; b=VrCTKYIu2yjORpYaOu
	+BH0iTT5qF2A56kB/hBD73Dxb5RqrYX09w8t7HBhBj7bx8FOfE4/HiL4y4lWGuym
	//yx13/VNeRTumw4LNxnss7vC1ADdjKWjbGSzoAoTRy6xmSy7rLRUeJht5DYd4KC
	cxZHU1xF2Q3HYLCxWlEiKXdys=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3l7M29s5qhWn7EQ--.42443S2;
	Wed, 14 Oct 2026 11:25:43 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: Elad Nachman <enachman@marvell.com>
Cc: Pengpeng Hou <hppiscas@163.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: prestera: avoid overreading a short firmware tail
Date: Wed, 14 Oct 2026 11:25:40 +0800
Message-ID: <20261014032540.14311-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l7M29s5qhWn7EQ--.42443S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF1UWr15Zr18Ww4rKryfZwb_yoW5CFWfpF
	WDCFy3tr4DGF1ft39rJF18ZF45X3s5tFW7KFZxuw1Svr4jkr97Jay29rs7KrnxJrWSgw1U
	Zr4Yk3Zxurn8Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piRuWQUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbC7RcZ4WrO9jfNewAA3R

prestera_ldr_fw_send() passes complete 1024-byte blocks to the loader
and then sends fw_size - pos as the final chunk. Firmware header validation
does not require the payload size to be a multiple of four. Consequently
that last chunk can end with one to three bytes, while prestera_ldr_send()
still loads a full u32 from it and transfers bytes beyond the supplied
firmware image to the device.

Reserve space for the rounded-up transfer, use unaligned-safe full-word
loads, and construct the final word from only the remaining bytes with
zero padding. The firmware image-size register still describes the exact
payload size. Preserve the existing native-word load and writel_relaxed()
byte-order convention.

The issue was found by our static-analysis tool and manually reviewed.

Fixes: 4c2703dfd7fa ("net: marvell: prestera: Add PCI interface support")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
- explain why a short final chunk reaches the loader, as Andrew requested
- include linux/unaligned.h to fix the reported undeclared get_unaligned()
- use a const full-word source pointer and sizeof(u32) for index movement
- rebase on current mainline

Previous version:
https://lore.kernel.org/all/20260830142404.37663-1-pengpeng@iscas.ac.cn/

 .../net/ethernet/marvell/prestera/prestera_pci.c   |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
index 1ad0e62a8433ba91a9c019aa7f277c6c9f65f58e..4492c35ea5d388ef485f424d88fc1f9b0f7ad29e 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/iopoll.h>
+#include <linux/unaligned.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -589,18 +590,27 @@ static u8 __iomem *prestera_ldr_wr_ptr(struct prestera_fw *fw)
 
 static int prestera_ldr_send(struct prestera_fw *fw, const u8 *buf, size_t len)
 {
+	size_t write_len = ALIGN(len, sizeof(u32));
+	size_t i;
 	int err;
-	int i;
 
-	err = prestera_ldr_wait_buf(fw, len);
+	err = prestera_ldr_wait_buf(fw, write_len);
 	if (err) {
 		dev_err(fw->dev.dev, "failed wait for sending firmware\n");
 		return err;
 	}
 
-	for (i = 0; i < len; i += 4) {
-		writel_relaxed(*(u32 *)(buf + i), prestera_ldr_wr_ptr(fw));
-		prestera_ldr_wr_idx_move(fw, 4);
+	for (i = 0; i + sizeof(u32) <= len; i += sizeof(u32)) {
+		writel_relaxed(get_unaligned((const u32 *)(buf + i)),
+			       prestera_ldr_wr_ptr(fw));
+		prestera_ldr_wr_idx_move(fw, sizeof(u32));
+	}
+	if (i < len) {
+		u32 last = 0;
+
+		memcpy(&last, buf + i, len - i);
+		writel_relaxed(last, prestera_ldr_wr_ptr(fw));
+		prestera_ldr_wr_idx_move(fw, sizeof(u32));
 	}
 
 	prestera_ldr_wr_idx_commit(fw);

base-commit: 4056b3c9d3c92ea45955641dbafeb9b960e146ef

