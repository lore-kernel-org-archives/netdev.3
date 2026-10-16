Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36A1480DED;
	Fri, 16 Oct 2026 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153848; cv=none; b=arRQYUbSVCGynP43JjsXiSZ5PI4p520I7cX6luTfYTW05LXk8dSNtsbQ9NpDRmMZh9VOWyuIXKPtemd3sfxAh6ZydP2w81bL4H2GOAmRcjHSaRoCKwW8Do3M4PC+rkD72dqQjra6OpueBGS3Gte1+Wbc/SiJr5DwmyLGoOrsDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153848; c=relaxed/simple;
	bh=rod6xy9+gndHUdnbr4wgG656s1uGxUW7SPIP+EVNlHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nj46AvS6WCgx61n0ro9dxzaXGV/IRjP5N3Pi2QTTk4lxtLYx6Hr/ljm1KITFADCHbs3/Y6YaIVwzHZSfn3AHhB3/jRxhhsthzdscnCy99C7rvoQPqDaoiuFIoc1o+YOncBcHnmgE0m+hgg7E1OjoTX3J5hyA7D/VUU3yDFbvOVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com; spf=pass smtp.mailfrom=ugreen.com; dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b=rP4UF5tK; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ugreen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ugreen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ugreen.com header.i=@ugreen.com header.b="rP4UF5tK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ugreen.com;
	s=pkvm2402; t=1792153799;
	bh=PTGNf+pFA4HlvSUNJLATMTS2BdbiXazN6lRObVyVPC0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=rP4UF5tKmoJzRdfIra7YzOMp+2iUIg+jw/GGGOD9kFdTXFPcwI55HXgfA2K38nCvq
	 0NcwSq86L8zPnhGwG9F51goITWSPRq4LlzH151gqWhcOX6V/kFaQsmjyCxzFx/2Bma
	 wFKhLn+y01SXB+b45cingkEo7Zkuimk7QlwJFTQY=
X-QQ-mid: zesmtpsz8t1792153794td166a33c
X-QQ-Originating-IP: +8ylvwj65TkPxlY7DREeXjDYclub16XfNEoyv3MvgGA=
Received: from exmail.qq.com ( [113.88.77.42])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 Oct 2026 20:29:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3139676211192935493
EX-QQ-RecipientCnt: 6
From: Hanson Wang <hanson.wang@ugreen.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	oneukum@suse.com,
	jakub.kicinski@kernel.org,
	andrew+netdev@lunn.ch,
	hanson.wang@ugreen.com
Subject: [PATCH net v2] net: usb: aqc111: fix set_mac_address return value
Date: Fri, 16 Oct 2026 20:29:44 +0800
Message-Id: <20261016122944.1889622-1-hanson.wang@ugreen.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703073936.462231-1-hanson.wang@ugreen.com>
References: <20260703073936.462231-1-hanson.wang@ugreen.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:ugreen.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N+sUQ11wBK5qy7i/Q3cLsLARQ0I4WvjA2npztSrd3PrN88qhgpsMCa9Z
	bBfFtR5aIu3zkUJ0EVl/9K8Tix4yDh9JLoHwc4PGmvC22J+gRLNs/naNB/6Qsz/EKycvVIR
	ljKtZ0Uu4GBWiKbdIace7+9bJAgS9/8kq0ShVYHkSXDgoRQFFlIRS54fSpAcffeI/XMsvRV
	jS6Wlko8dHak6f90i/lq9urS1AB/+m4uHx3dufwi5ZJiOcJ9A3uko3pbsMXKCFhekx7OJyq
	xY1kiIjv/5COP6e/K9HFofi0qvKdl+YwTunShq9MWmZc/paRQ9T0W6hWK8vSnLORI5uCaBB
	JqDT3C+J6ZsOwudbTTX09c40+H4d0KSeLHUEs0tAyMQbkkYni7QUtpVBJqhOa3wPj+MBqFR
	GZSv/ISBu9njpFZIOAH0FBqraH7Kd6AIg0rrTZkji49hpXIcyw4GwgLeZM6NU7BBLPCqvlJ
	8qJOVqllWmjOJRw53QJmrxqJIGG+XzZgF/lYtG03przZn91CTgSbIXyzg4ufuTF/n9K98Hp
	f6XG0DkC30vBdKU3mqcceDQwHoZhVPZalkhxOiChWBIfb+fjlVm29y1MvChPqLYzXCbrW9q
	9OduhvdCbuPIQfNd4Xh1pbWSTSOqut7MW89bM3+umL1APHWDoSDnTytWc6kg0Qly1DFHSPu
	NdOKwsRYmN5jTgqkXUo9qGc3tNlV37OL/EG1nVk0AI6KYJnIepDFJnCkw0STM2yBjNDe822
	9FqRb4LIIMFqSkuO/OZSWIEHhtigdG8n6nR0QCnoDpZeidc3S33vhUSUWrmEoOeX/UxFOlZ
	av6fhInouIWr5P4VGWdnHN6Ky4y6iUWqIvzNXtt+iqhPKwUWqqLvX7hT890CNqi9XWVxyU6
	7BV/VbVQFDhPCWc/wZvLw4DcPNzWRFCWF4QTOc6cP9dxnmZlp7IL4/GhCejrfi29N339bXJ
	f39PNXXcAh4RaWd7bV3r0NG51rA9q+9kcPWRSW7bYrHcQFpVERgKXWMyRu2waJnAsm5oS56
	/AKTq0rbvJ3AQ2/f8/LIsrcHgHrv7VQBRMBbLWH11d/qZWeG1zPvH2/lEuh9U0aNEBNyhtF
	9G1YWNh9NG71igT3zrgLFFuzhHN1PJx2GuV3iUjdpsyK8SchDpaFlI=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

aqc111_set_mac_addr() returns the result of aqc111_write_cmd() on
success. That function wraps usb_control_msg(), which returns the
number of bytes transferred (6 for ETH_ALEN) rather than zero.

Callers such as netif_set_mac_address() and bonding treat any
non-zero return value as failure when setting the MAC address.

Return 0 on success and propagate negative error codes on failure.

Link: https://lore.kernel.org/netdev/20260703073936.462231-1-hanson.wang@ugreen.com

Signed-off-by: Hanson Wang <hanson.wang@ugreen.com>
---
 drivers/net/usb/aqc111.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 9201ee10a..827aab540 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -476,8 +476,12 @@ static int aqc111_set_mac_addr(struct net_device *net, void *p)
 		return ret;
 
 	/* Set the MAC address */
-	return aqc111_write_cmd(dev, AQ_ACCESS_MAC, SFR_NODE_ID, ETH_ALEN,
-				ETH_ALEN, net->dev_addr);
+	ret = aqc111_write_cmd(dev, AQ_ACCESS_MAC, SFR_NODE_ID,
+			       ETH_ALEN, ETH_ALEN, net->dev_addr);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int aqc111_vlan_rx_kill_vid(struct net_device *net,
-- 
2.34.1

