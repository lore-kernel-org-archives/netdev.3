Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F763B637E;
	Mon, 30 Mar 2026 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774866385; cv=none; b=jsdDo7wSR2R0aptFfi2SoUP6s7fOhC+qQbjsdE7eabZEHq7i+jkRnmm8seujN0ID2qYdTnvlxifBd0evNlgn2Z0F1nmgSlRPM5v/1v7aVY5yuF2Q2yKcjiKua1ixWfOiFEa4MfDXnL0JtFItjg/xkST4h6/9ZUMCnNgINzP1NRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774866385; c=relaxed/simple;
	bh=T9uIlKF64yOcg9bZtE+cTBedhjk9S9RgTUSXgAnuvIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPmpX1Ah1ZwQqfSvCUH2R82AdsMkb798GbHbkjpkZ6RGIfYvuOfFwjUqUfDGdSQbl5937u2BBzvw/5an9/We9s+JpR3VLBtS1j8Ff+fvO3zpTFwfq7BAd68isNDfKULd4NMuhzCCrJWzePdZ5cYXuKpGATASeZsmpsIFDOzasE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3Lk3LeT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3Lk3LeT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D52C4CEF7;
	Mon, 30 Mar 2026 10:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774866385;
	bh=T9uIlKF64yOcg9bZtE+cTBedhjk9S9RgTUSXgAnuvIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3Lk3LeTfciLzYIG75jBzdIlDdDiBmouF5ORvWGPOHx12VEIo6la8O327J2sZk3/e
	 fXDSOERPW4rywuTPQeYzcfPtPw1avW980TYA13Dl2aMHwTfS+l/eolVC3gcYMWn2Vt
	 KhIp7fKVr1MK42KrpJJiCmc6IgayIZhmyiM71ySP67dneW4Qea3SfCP6+tdNWbGu47
	 GqPHK+ichN9sfmqgQjLDfXu4vmfPt2lktGVJ1estQdrQ0uXz4tY57sga7toFsLTqrD
	 mcUjGBZsq2/Q7m+T/Hjuc3iDEuWkAqhnqWg0W2dVxLUC/3sEnA+SXH8yQ3URnAeuEW
	 sD1cTcOQLCcCA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w79p8-000000070qq-42E7;
	Mon, 30 Mar 2026 12:26:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] net: ipeth: refactor endpoint lookup
Date: Mon, 30 Mar 2026 12:26:11 +0200
Message-ID: <20260330102611.1671546-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330102611.1671546-1-johan@kernel.org>
References: <20260330102611.1671546-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the common USB helper for looking up bulk and interrupt endpoints
instead of open coding.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/usb/ipheth.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/ipheth.c b/drivers/net/usb/ipheth.c
index a19789b57190..bb1364f85bd1 100644
--- a/drivers/net/usb/ipheth.c
+++ b/drivers/net/usb/ipheth.c
@@ -573,11 +573,10 @@ static int ipheth_probe(struct usb_interface *intf,
 			const struct usb_device_id *id)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usb_endpoint_descriptor *ep_in, *ep_out;
 	struct usb_host_interface *hintf;
-	struct usb_endpoint_descriptor *endp;
 	struct ipheth_device *dev;
 	struct net_device *netdev;
-	int i;
 	int retval;
 
 	netdev = alloc_etherdev(sizeof(struct ipheth_device));
@@ -603,19 +602,16 @@ static int ipheth_probe(struct usb_interface *intf,
 		goto err_endpoints;
 	}
 
-	for (i = 0; i < hintf->desc.bNumEndpoints; i++) {
-		endp = &hintf->endpoint[i].desc;
-		if (usb_endpoint_is_bulk_in(endp))
-			dev->bulk_in = endp->bEndpointAddress;
-		else if (usb_endpoint_is_bulk_out(endp))
-			dev->bulk_out = endp->bEndpointAddress;
-	}
-	if (!(dev->bulk_in && dev->bulk_out)) {
-		retval = -ENODEV;
+	retval = usb_find_common_endpoints_reverse(hintf, &ep_in, &ep_out,
+						   NULL, NULL);
+	if (retval) {
 		dev_err(&intf->dev, "Unable to find endpoints\n");
 		goto err_endpoints;
 	}
 
+	dev->bulk_in = ep_in->bEndpointAddress;
+	dev->bulk_out = ep_out->bEndpointAddress;
+
 	dev->ctrl_buf = kmalloc(IPHETH_CTRL_BUF_SIZE, GFP_KERNEL);
 	if (dev->ctrl_buf == NULL) {
 		retval = -ENOMEM;
-- 
2.52.0

