Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8481CEAC2;
	Mon, 23 Feb 2026 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851630; cv=none; b=oQBay0YA+0phpeIdvvbZFxF1/VtuuJIfN5QCC3pzUwCM/SPAJIioWVUsqUckJVHz27pkiIpJACqHy5j3tEUgQHZSmrYflXIJOf1vwOEsPmpSkkO2LrP5T0SU3nzs+V0h8EJObVb9Qsdj9yau2Ue2UBnUJYo2kZEPT5s2vkzw1H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851630; c=relaxed/simple;
	bh=fa/XaBXU8+TE0yxdzEO8Hvvq/4m8BUXr1YVLFQ28SQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PVwAtutqzyJKehQWml2AiDnG6JhGNi/jG3a0ZUx0ibWfR6kQ4SGpiA7P+q0gv3UVYr+0ILhbkBD1/mbDPNRT37np5+8Drs1/tx8G1fHtvXLK5pQVkI/IwYCqYf0hnMK9GkXnHNUUc74e8FTVGPRiTP0XcDxqiAVtQqPXW5q7ryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wih+Aumr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wih+Aumr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF376C19424;
	Mon, 23 Feb 2026 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771851630;
	bh=fa/XaBXU8+TE0yxdzEO8Hvvq/4m8BUXr1YVLFQ28SQM=;
	h=From:To:Cc:Subject:Date:From;
	b=wih+Aumr2bah3KYeoFTbphd3bhBl2S3/kHhvDZFoPwmz6PfRrBMvlaj2Ku2G2Nbrp
	 K8sKFLCPE/4mU10Eufr9i7gQElXP1XYhNMLlM0UtEhI9S24BJWSkLrqSz09FtKkTAJ
	 4we9iHUYG+nyPgx3Y9xMSQqVNdEd5bsvOdtENjQ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>
Subject: [PATCH net] net: usb: kaweth: validate USB endpoints
Date: Mon, 23 Feb 2026 14:00:06 +0100
Message-ID: <2026022305-substance-virtual-c728@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=fa/XaBXU8+TE0yxdzEO8Hvvq/4m8BUXr1YVLFQ28SQM=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlz/EOnafCIMR3ZvnJmltzqOotQnS3fZn456tg6K39Fv Zz6if+TO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiCQ4MC452xIecySq547g4 6lnGrnkXhJ7dC2RYMK+X6zt/jGjeVxPNA48ynztxKu2+DgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The kaweth driver should validate that the device it is probing has the
proper number and types of USB endpoints it is expecting before it binds
to it.  If a malicious device were to not have the same urbs the driver
will crash later on when it blindly accesses these endpoints.

Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/kaweth.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/usb/kaweth.c b/drivers/net/usb/kaweth.c
index c9efb7df892e..a8c3ecf7d810 100644
--- a/drivers/net/usb/kaweth.c
+++ b/drivers/net/usb/kaweth.c
@@ -885,6 +885,13 @@ static int kaweth_probe(
 	const eth_addr_t bcast_addr = { 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
 	int result = 0;
 	int rv = -EIO;
+	static const u8 bulk_ep_addr[] = {
+		1 | USB_DIR_IN,
+		2 | USB_DIR_OUT,
+		0};
+	static const u8 int_ep_addr[] = {
+		3 | USB_DIR_IN,
+		0};
 
 	dev_dbg(dev,
 		"Kawasaki Device Probe (Device number:%d): 0x%4.4x:0x%4.4x:0x%4.4x\n",
@@ -898,6 +905,12 @@ static int kaweth_probe(
 		(int)udev->descriptor.bLength,
 		(int)udev->descriptor.bDescriptorType);
 
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+	    !usb_check_int_endpoints(intf, int_ep_addr)) {
+		dev_err(dev, "couldn't find required endpoints\n");
+		return -ENODEV;
+	}
+
 	netdev = alloc_etherdev(sizeof(*kaweth));
 	if (!netdev)
 		return -ENOMEM;
-- 
2.53.0

