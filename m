Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19546492E2C
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585469; cv=none; b=oWN9//2FRqmVD7xc5z5ayGYIMcIeDxK6Zomrk35O6QP+Xssa7zz8T0nsnXw9AmfdWxlfu386zsKJp01Z1fvPIhlmjz8+xJwjt/2rv6fyDEKXlCS0hu9qzukPw2JnwNYCJThrTSaFbhJ6ABpF3gSnLp1YQU/aj2L288Z+wOYF+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585469; c=relaxed/simple;
	bh=qbZbAs1nXyNptTXSsuownJrnargPa9mQ7WIcBxyu0xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLhLbcbDGRpjKV3YqLmJWVScRyhBgr28rJMhQ9fRhovTYWz3cyrPhO+5ZvZtk4X72kPXL0/94yDURrCwzvri60o586AcpydTrABNvvNRpDcNNSIZ96U+LxVHJHjgQ4PcVAPkHf14qwYjwxtz9rs6pdMI1qoU5u9ej5w30RBP1D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHPVUEdF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHPVUEdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1881F00893;
	Mon, 28 Sep 2026 08:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585468;
	bh=T15ycRIT+U2F8SZHB9PocI0PoyfeDRk/0MMl3N/QGB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nHPVUEdFmbnN6Pd9Uqa7jNxjR14EdBoa5RG5pSqJ1mntSc1idZXXSGc7vPyGJOjkm
	 Pm1uVo/0okzIkR1yMNyDEOMTUzfkUVula9jTfPGgRlmPlG701ijem0s7cB1fDuKem9
	 uq6vfpfKPAns4hYHLQbL1XPlxEObkIFdorFselHopK9Tk+FdWU45Z3b5v3+nZtIZ8c
	 Q7RzOK1iegu6w1r5Hi50bAAEbsvV9saRB4dHVW/kDfDLSf1hJlNc5TbZ3l07vOGI/s
	 B+/t9xZ+r9IrEjWWb3wwN0TgJQ2fEZiy4A1Dzi5Aii+4f3erSKIXn8Ssn7UIVINmSU
	 2p9Qd9FOEIQ3A==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 10:50:36 +0200
Subject: [PATCH net-next v2 10/11] net: ethernet: cortina: Scale Gemini RX
 queues to system memory
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gemini-ethernet-fixes-3-v2-10-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The default RX queues contain 512 descriptors per port. The shared
software free queue is sized at twice their combined capacity, requiring
4 MiB of page fragments even on Gemini systems with only 32 or 64 MiB of
RAM.

Choose smaller default RX queues on memory-constrained systems. Use 256
descriptors per port and a 2 MiB free queue with at most 64 MiB of RAM,
and 128 descriptors per port with a 1 MiB free queue with at most 32 MiB.
Keep the existing defaults on systems with more memory.

This preserves the existing relationship between RX descriptor capacity
and the free queue. Users can still override the defaults with ethtool.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index a7096690e4be..910de9925949 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/bitmap.h>
 #include <linux/init.h>
+#include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/net.h>
 #include <linux/platform_device.h>
@@ -35,6 +36,7 @@
 #include <linux/skbuff.h>
 #include <linux/phy.h>
 #include <linux/crc32.h>
+#include <linux/sizes.h>
 #include <linux/ethtool.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
@@ -470,6 +472,17 @@ static int gmac_pick_rx_max_len(unsigned int max_l3_len)
 	return -1;
 }
 
+static unsigned int gmac_pick_rxq_order(void)
+{
+	if (totalram_pages() <= (SZ_32M >> PAGE_SHIFT))
+		return DEFAULT_GMAC_RXQ_ORDER - 2;
+
+	if (totalram_pages() <= (SZ_64M >> PAGE_SHIFT))
+		return DEFAULT_GMAC_RXQ_ORDER - 1;
+
+	return DEFAULT_GMAC_RXQ_ORDER;
+}
+
 static int gmac_init(struct net_device *netdev)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
@@ -538,7 +551,7 @@ static int gmac_init(struct net_device *netdev)
 	writel(sw_weigh.bits32,
 	       port->dma_base + GMAC_TX_WEIGHTING_CTRL_1_REG);
 
-	port->rxq_order = DEFAULT_GMAC_RXQ_ORDER;
+	port->rxq_order = gmac_pick_rxq_order();
 	port->txq_order = DEFAULT_GMAC_TXQ_ORDER;
 	port->rx_coalesce_nsecs = DEFAULT_RX_COALESCE_NSECS;
 

-- 
2.55.0

