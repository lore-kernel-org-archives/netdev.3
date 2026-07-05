Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02F2309AA;
	Sun,  5 Jul 2026 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240587; cv=none; b=jxXMYlh6J773Q1LkkUu3yc30+oMg3b/7/xbr7c4yikjCrzu6SuXfdBbQZItZGvCDV8UNm13E+yrMD0XkqqstR0BjX56n0SYTwNmI08JEE0y700ZoPnLKsn1DvblfJjCMLindl0Pfx4Ioemozs/LrYsZTJTrbvcaZYTGUgMfQ/8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240587; c=relaxed/simple;
	bh=IzImo2ypN6AdqEYTqNnz5CTeIiYgQwz8oPG1KYifZ2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bkc3R/y//ghIhFKXOKMqRjqnxpVJdAMZ0UTdwcU+RZ062lzMOcgROhLBkXwQDqbzN9L8ib+MCWJHdAVOMvEwFeU1QaaQqWNTKFhtzrJHLahuueBeHyYv8o+7JzmQsNhPLGDmzmGWSwmA0ehiAkmxi5mbhtON0dfnShGI3V79Dps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowADnL8N7F0pqa3P8Fg--.12232S2;
	Sun, 05 Jul 2026 16:36:11 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] net: usb: cx82310_eth: bound partial receive continuation
Date: Sun,  5 Jul 2026 16:36:09 +0800
Message-ID: <20260705083609.23977-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnL8N7F0pqa3P8Fg--.12232S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr47CF18AFy5WFW8AF1DWrg_yoW8WF4fpF
	Z3JF43Cr4UGr17ur4xGFW8Za1Y9asrArZ8Gry7Zw13Ar4kA3WUKFy3KF409r1UZr4rAayI
	yrsYyw4jkF15uFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU13ku3UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

cx82310_rx_fixup() completes a packet that started in the previous URB
by copying dev->partial_rem bytes from the current skb. It then pulls
the same continuation extent, rounded up to an even byte count. The code
does not first prove that the current skb contains that continuation.

Add a fail-closed bound check before the copy and pull. If the
continuation is shorter than the pending packet state expects, drop that
pending partial packet before returning so later URBs are not consumed as
stale continuation bytes. This keeps the existing cross-URB packet
model, but avoids consuming bytes that are not present in the current
skb.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
diff --git a/drivers/net/usb/cx82310_eth.c b/drivers/net/usb/cx82310_eth.c
--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -242,7 +242,7 @@
  */
 static int cx82310_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 {
-	int len;
+	int len, pull_len;
 	struct sk_buff *skb2;
 	struct cx82310_priv *priv = dev->driver_priv;
 
@@ -251,6 +251,13 @@
 	 * end of that packet at the beginning.
 	 */
 	if (dev->partial_rem) {
+		pull_len = (dev->partial_rem + 1) & ~1;
+		if (skb->len < pull_len) {
+			dev->partial_len = 0;
+			dev->partial_rem = 0;
+			return 0;
+		}
+
 		len = dev->partial_len + dev->partial_rem;
 		skb2 = alloc_skb(len, GFP_ATOMIC);
 		if (!skb2)
@@ -261,7 +265,7 @@
 		memcpy(skb2->data + dev->partial_len, skb->data,
 		       dev->partial_rem);
 		usbnet_skb_return(dev, skb2);
-		skb_pull(skb, (dev->partial_rem + 1) & ~1);
+		skb_pull(skb, pull_len);
 		dev->partial_rem = 0;
 		if (skb->len < 2)
 			return 1;

