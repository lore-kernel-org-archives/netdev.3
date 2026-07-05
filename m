Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F32D59E8;
	Sun,  5 Jul 2026 08:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783240668; cv=none; b=keKX9HkvS72aDQtvRB2Hrj5nno4DZtx8eliHrUAbgv8ZnYjgEmTI4kUQ12PVj41eh/pkkiUDGEspKQftFHQHxnC8FjSiFP0ObkpEkpFztzR6kskTVN68I8psRcQXUfcCTrnlrQVanlBQIjKxGacp7ytXl3CB7sscqMbBOPtiG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783240668; c=relaxed/simple;
	bh=5TaI+DIhBgZ3RzIz3m90xhYg9PZKJEP7SD6FW4v+Bno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMK6mr7a0vBlS2Lk/1iL2m6KfpwJRGbvDdkk5zKDoC79ef87s2RfMG7bPnuQWEThYU8NMPNzSBfuorwdb9ofQL3OC/w6SXsmH2sCqGvr8N1VdwP5UPqI5zAaT3XnvKTwivccCGoCNfaM48wjjkGynRFkeICHSZUZZOft6XIxaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowACX99rPF0pq_X38Fg--.29630S2;
	Sun, 05 Jul 2026 16:37:36 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Simon Horman <horms@kernel.org>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] net: usb: sr9700: validate receive packet extent
Date: Sun,  5 Jul 2026 16:37:24 +0800
Message-ID: <20260705083724.24494-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX99rPF0pq_X38Fg--.29630S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw15WFy7uFyUtr1rXrWUurg_yoW3CFb_ur
	y5uF15Gr1UuFy7X34ftr45urW2va97X34I9ryav39I93srKr10qrs5urn3ZwnrGry8CrnF
	ywn8uF45J34jyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU5iihUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

sr9700_rx_fixup() copies len bytes from skb->data + SR_RX_OVERHEAD when
a URB contains multiple packets. The old check compared len against
skb->len, but the source pointer has already skipped SR_RX_OVERHEAD
bytes.

Validate len against the remaining bytes after SR_RX_OVERHEAD before the
copy and cursor advance.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -355,7 +355,8 @@
 		/* ignore the CRC length */
 		len = (skb->data[1] | (skb->data[2] << 8)) - 4;
 
-		if (len > ETH_FRAME_LEN || len > skb->len || len < 0)
+		if (len > ETH_FRAME_LEN || len < 0 ||
+		    len > skb->len - SR_RX_OVERHEAD)
 			return 0;
 
 		/* the last packet of current skb */

