Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5903B8939;
	Sun, 30 Aug 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788099864; cv=none; b=PRZke3Qz97qlbps2WosXFLAqHZINVjQYJKlEDDDLtIjjpYdXfGJGHF164HMabkRVBoK0wB7HN03nk05tuQtwda8Q6cKgNtXoPI5k//KoGhqUM+2M2rLYaQuoSelgXHgLq8NnLK3ZAkfpDaiJ1MRaQnmJM/KAHO/JFuZVKbKsmP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788099864; c=relaxed/simple;
	bh=ynz2dZChD3puQFlY7ICCHVT5bTQ8wwzozCO0xiL5OIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFyzhwUKqTUzG4FYWG6oSN54qGqvlVCKfmBbMOe7Vh1jX9ALMbPWXd8AFgumOOYTbhCWsvT98NbqqbL/ORP/2F0xN4TbiTCIOeVPa+vMRJ8DGdCIldDgxrx/46jLGjOTE4SWI4fjvl52XF3PDrHaQsyvQtwo6rj0udgun3naHuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowABHUD4GPZRq9rebBg--.40870S2;
	Sun, 30 Aug 2026 22:24:06 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Elad Nachman <enachman@marvell.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: prestera: avoid overreading a short firmware tail
Date: Sun, 30 Aug 2026 22:24:03 +0800
Message-ID: <20260830142404.37663-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHUD4GPZRq9rebBg--.40870S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1fCFy8Jr1rAF4xWFWUXFb_yoW8CF13pF
	WUCFy3tr1DJr1ft39rtr48ZF45Was5tFW7KrZ3C34Sqr4jkr97Ja43Kr4xWr13GrWrXw13
	ZF45u3Wxurn8Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUgXo
	cUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

prestera_ldr_send() writes the firmware in 32-bit words even when the final
chunk is not four-byte aligned. The last iteration then reads a full u32
from a one-to-three-byte tail.

Reserve the aligned ring space, use unaligned-safe full-word loads, and
zero-pad a partial final word without reading beyond the firmware image.

Fixes: 4c2703dfd7fa ("net: marvell: prestera: Add PCI interface support")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/marvell/prestera/prestera_pci.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_pci.c b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
index 1ad0e62a8433b..9b3d6e5a81d1c 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_pci.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_pci.c
@@ -589,17 +589,26 @@ static u8 __iomem *prestera_ldr_wr_ptr(struct prestera_fw *fw)
 
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
+	for (i = 0; i + sizeof(u32) <= len; i += sizeof(u32)) {
+		writel_relaxed(get_unaligned((u32 *)(buf + i)),
+			       prestera_ldr_wr_ptr(fw));
+		prestera_ldr_wr_idx_move(fw, 4);
+	}
+	if (i < len) {
+		u32 last = 0;
+
+		memcpy(&last, buf + i, len - i);
+		writel_relaxed(last, prestera_ldr_wr_ptr(fw));
 		prestera_ldr_wr_idx_move(fw, 4);
 	}

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.50.1

