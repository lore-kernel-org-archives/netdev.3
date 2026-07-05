Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63DC2820A9;
	Sun,  5 Jul 2026 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783241111; cv=none; b=uL+vhOPsbUW94L1Bn8LXN2CTghb4IZBn8fpdDGFF3JYN1fTOzzFS+PDj8RJAVIGzz2Qa7uyP9hNQ3BVt2lVX2VoD7+Z4HJg7uOYOLJ3p8gAm0z4kUAkKUehjvSk2McMyV7KO9PVUGqYttSRpv5K1Y2Z/3HD+fwTojMYo85icpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783241111; c=relaxed/simple;
	bh=wUD75mZGOgJZAPh8PCUn7G/0cQOVKtz16FivmgjPo9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioWgqBX6rp8C7GHKy88lS8U11R1phYgHY4ZI8/xErkshCy8+9XuwwiVEbPoErdeL1OuKZQPq9+DW4ZpJveZtNhPiGM/PZVI/DT9jPVqfTLfow6EZJ8SmAeLTWbSFYf2btvEcaPBeurxHNrwft31dyEs/iWX2XR8oYP0Ur5Yfk/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABHkcSSGUpqS6_8Fg--.7044S2;
	Sun, 05 Jul 2026 16:45:06 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Chas Williams <3chas3@gmail.com>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] atm: solos-pci: validate DMA receive size
Date: Sun,  5 Jul 2026 16:45:04 +0800
Message-ID: <20260705084504.54281-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHkcSSGUpqS6_8Fg--.7044S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtF13KF4kJw1UCw4ruFyDKFg_yoW8JryUpa
	15KF1Utr95Ar15Ar95Aw4UXa15Gan8Aa4agFWkGa4a9rn5Ww15uFZ5KFWSgrWkArs3GrW2
	qr1ktr40ka4DZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjIJmU
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The DMA receive path reads header->size from the RX buffer and uses it
to extend the skb with skb_put(skb, size + sizeof(*header)). RX DMA skbs
are allocated with RX_DMA_SIZE bytes, but the DMA path did not check
that the device-provided size fits in that buffer. The MMIO path already
has a similar size check against card->buffer_size.

Reject an oversized DMA receive item before skb_put() and drop the
invalid skb, then continue through the normal DMA RX refill path so the
port is not left without a replacement receive buffer.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -784,6 +784,12 @@
 
 				header = (void *)skb->data;
 				size = le16_to_cpu(header->size);
+				if (size > RX_DMA_SIZE - sizeof(*header)) {
+					dev_warn(&card->dev->dev, "Invalid DMA buffer size\n");
+					dev_kfree_skb_any(skb);
+					goto refill_rx;
+				}
+
 				skb_put(skb, size + sizeof(*header));
 				skb_pull(skb, sizeof(*header));
 			} else {
@@ -865,6 +871,7 @@
 				break;
 			}
 		}
+refill_rx:
 		/* Allocate RX skbs for any ports which need them */
 		if (card->using_dma && card->atmdev[port] &&
 		    !card->rx_skb[port]) {

