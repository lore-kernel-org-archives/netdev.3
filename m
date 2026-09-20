Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05A41A0B15;
	Sun, 20 Sep 2026 03:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789876103; cv=none; b=ahlEWJ+XunxDoh7BgyxwqsjpbrSEFiVNX71nZD/loJ14maR1u8RFbjLFTk+2bTI+uGT5Lxe/PN3pDVrW5VNizOXDwqF/V9hNuf2G6mPtfnizOZv+2BS5fksMX3NCE7G3DjzUX7C4LNzpP58ht4w9prA4jbyHguyn03RLOSraOCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789876103; c=relaxed/simple;
	bh=d2h7FXY+Z0Ko0oEFu2YEzuKqYCDUZDocdHjJCap76RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWoBzuJEwpQr8du9quu3n9SkaGDHloqu0FGl3G9wFOmz2iXBLJbDljtdNTk2IaVxZLiQwFgczn3E7mnp87YCk+UyivWmhBf3TOs9XoqdYGDCde2IlBJkEpISUvg7XcvvZgW+WjgUsRy8XlvP8dAc8kkqtl/dtKwcU1l2eSpQESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ji/eJWH8; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ji/eJWH8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=zC
	ZCn/HTbvG7ECS8MrnseKP2fmhceo6WnzmtSb28Ils=; b=ji/eJWH8jJUx2y1NRV
	4O0lrwzr6L2hX5zSkT1raEF6w2QDxuoWsW5rF6LJktJdWaontCENLTMHXjZmqAnF
	xrO8PjzsijH9oXNuYysbIIQxBaNk8pQSjqNrh6hKG9dswpFriMT7xC2nq5Xjld98
	9mv4KdxfTV6kyWSbxMZTHWWOg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDHlxhjV69qJnc7AQ--.62997S2;
	Sun, 20 Sep 2026 11:47:48 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	enelsonmoore@gmail.com,
	peter@korsgaard.com,
	horms@kernel.org,
	andrew@lunn.ch,
	hppiscas@163.com
Subject: [PATCH net v2] net: usb: sr9700: include receive overhead in the length check
Date: Sun, 20 Sep 2026 11:47:45 +0800
Message-ID: <20260920034745.18468-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDHlxhjV69qJnc7AQ--.62997S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryktrW8GFyDWr4UJrWrKrg_yoW8AFWrpF
	ZxWFW7Zr4kJ3W7Jwn0kw4fWayrCas3Jr9xuF9Yq3s5uasIvw1xKa40gF1j9F1DArWrGFW0
	yrZ8trs7Zan5AwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U59NsUUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxQR1PmqvV2SULgAA3G

The receive fixup subtracts the Ethernet CRC from the reported packet
length, but compares that payload length against the whole remaining
receive buffer. The following copy starts after the three-byte header,
and the cursor advance consumes both that header and the four-byte CRC.

Require the payload to fit after SR_RX_OVERHEAD before copying it or
advancing to the next packet. The loop already ensures that the
remaining buffer is larger than the overhead, so the subtraction is
safe.

The issue was found by our static-analysis tool.

Fixes: c9b37458e956 ("USB2NET : SR9700 : One chip USB 1.1 USB2NET SR9700Device Driver Support")
Reviewed-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Tested-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
https://lore.kernel.org/all/20260705083724.24494-1-pengpeng@iscas.ac.cn/
Clarify the subject as Andrew and Ethan requested. This is a revision of
the previously withdrawn queue entry, not a new bug report.

 drivers/net/usb/sr9700.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 937e6fef3ac6..50981a28376a 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -355,7 +355,8 @@ static int sr9700_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		/* ignore the CRC length */
 		len = (skb->data[1] | (skb->data[2] << 8)) - 4;
 
-		if (len > ETH_FRAME_LEN || len > skb->len || len < 0)
+		if (len > ETH_FRAME_LEN || len < 0 ||
+		    len > skb->len - SR_RX_OVERHEAD)
 			return 0;
 
 		/* the last packet of current skb */

base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137
-- 
2.50.1 (Apple Git-155)

