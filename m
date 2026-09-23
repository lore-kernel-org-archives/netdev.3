Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C4F583AC1;
	Wed, 23 Sep 2026 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194542; cv=none; b=nJomHEzWZCkaujAIoBb6wLzjA4COAxBpIINs+SsSSDYx7r8VmaBa/jdpVHMaJLLzYw9pY7N0B2rIrDyFUzxbpaTpGyAzQoZKGLZF7yF7qH9nrLyt3iSW7cdNf7+6uY3Dz7Jpztew/gJ5726lGGKRO3Pw7sA2jAkSRUuujONnSHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194542; c=relaxed/simple;
	bh=Xtvujy0opXHYFOBbyHZSJd2ab9aWwCysdO4mW4mN2Ag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qr/qXvWYWkIYRYXsx1c6krEnzVSsdLE/tKQyw2EJa/GRncnyvN7E0PNfLJK2h/T4M/aIyMxaUh4S+rttCHjQKpd3SssddkEuXvmVUb92TXxXaC61YT6wI5AtwIqjpF5anl+OOFpFWgtqYZ9s4WXuy4iv7+4o/JfIPCSdiKNr+Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from wasted (91.78.46.39) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Wed, 23 Sep
 2026 23:15:27 +0300
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 1/2] ch9200: return error on failed register writes in ch9200_bind()
Date: Wed, 23 Sep 2026 23:14:38 +0300
Message-ID: <20260923201440.36966-2-s.shtylyov@auroraos.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923201440.36966-1-s.shtylyov@auroraos.dev>
References: <20260923201440.36966-1-s.shtylyov@auroraos.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: exch16.corp.auroraos.dev (10.189.209.38) To
 exch16.corp.auroraos.dev (10.189.209.38)

The successful register writes, done via the USB control requests in
control_write(), seem vital for the normal functioning of the device,
however the driver's bind() method ignores error codes returned from
control_write().  Do bail out of ch9200_bind() on failed writes...

Found by Linux Verification Center (linuxtesting.org) with the Svace
static analysis tool.

Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

---
Changes in version 3:
- dropped the Fixes tag, retargeting the patch to the net-next.git repo again.

Changes in version 2:
- switched to checking for the negative error values instead of non-zero;
- added the Fixes tag, retargeting the patch to the net.git repo;
- dropped [RFT] from the subject.

 drivers/net/usb/ch9200.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index a206ffa76f1b..ab3cd3902ed7 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -360,32 +360,44 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 	data[1] = 0x0F;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_THRESHOLD, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	data[0] = 0xA0;
 	data[1] = 0x90;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FIFO_DEPTH, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	data[0] = 0x30;
 	data[1] = 0x00;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_PAUSE, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	data[0] = 0x17;
 	data[1] = 0xD8;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FLOW_CONTROL,
 			       data, 0x02, CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	/* Undocumented register */
 	data[0] = 0x01;
 	data[1] = 0x00;
 	retval = control_write(dev, REQUEST_WRITE, 0, 254, data, 0x02,
 			       CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	data[0] = 0x5F;
 	data[1] = 0x0D;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_CTRL, data, 0x02,
 			       CONTROL_TIMEOUT_MS);
+	if (retval < 0)
+		return retval;
 
 	retval = get_mac_address(dev, addr);
 	eth_hw_addr_set(dev->net, addr);
-- 
2.55.0
