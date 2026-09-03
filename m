Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD4C4DF4D3;
	Thu,  3 Sep 2026 20:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788466779; cv=none; b=ebWsVp6fnBxNvLmH9FrUnwbU8cETpQaofJZmxBRv52W7ayLYn9nYkZZBFdr3SmElsCwMd7puSGIZk5yp/c0Eehxg/QATl0iEMpdaUbrAYGUxT7feWJGOffPI7AOAVSviZouRN4Iqs7mln81PfEqw4u2ar4G1TswsWD17CRZNiCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788466779; c=relaxed/simple;
	bh=gGDWk5679CDpHU/MI56TQEoLnvyE50NUNQnsUVWycSg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nvWaY1WZZwTmkwdaCGLVitDBK6+KZ2UQXqXE4nsnE6F/zIvBJOKmzBzfkN/xoSgYq132/apdrQWiB8Am8385vBfSNw5y9h9dCXitCisqK7vOhk81bUnrBwImG2z99kv6jYeU8jth7cu05DKcx9FKCBjW9IBLj96QWq+543PWLHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from wasted (91.79.34.53) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 3 Sep 2026
 23:19:11 +0300
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Subject: [PATCH net-next RFT] ch9200: return error on failed register writes in ch9200_bind()
Date: Thu, 3 Sep 2026 23:18:41 +0300
Message-ID: <20260903201842.62338-1-s.shtylyov@auroraos.dev>
X-Mailer: git-send-email 2.55.0
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
 drivers/net/usb/ch9200.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/usb/ch9200.c b/drivers/net/usb/ch9200.c
index a206ffa76f1b..ce2e62f85c3d 100644
--- a/drivers/net/usb/ch9200.c
+++ b/drivers/net/usb/ch9200.c
@@ -360,32 +360,44 @@ static int ch9200_bind(struct usbnet *dev, struct usb_interface *intf)
 	data[1] = 0x0F;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_THRESHOLD, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval)
+		return retval;
 
 	data[0] = 0xA0;
 	data[1] = 0x90;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FIFO_DEPTH, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval)
+		return retval;
 
 	data[0] = 0x30;
 	data[1] = 0x00;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_PAUSE, data,
 			       0x02, CONTROL_TIMEOUT_MS);
+	if (retval)
+		return retval;
 
 	data[0] = 0x17;
 	data[1] = 0xD8;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_FLOW_CONTROL,
 			       data, 0x02, CONTROL_TIMEOUT_MS);
+	if (retval)
+		return retval;
 
 	/* Undocumented register */
 	data[0] = 0x01;
 	data[1] = 0x00;
 	retval = control_write(dev, REQUEST_WRITE, 0, 254, data, 0x02,
 			       CONTROL_TIMEOUT_MS);
+	if (retval)
+		return retval;
 
 	data[0] = 0x5F;
 	data[1] = 0x0D;
 	retval = control_write(dev, REQUEST_WRITE, 0, MAC_REG_CTRL, data, 0x02,
 			       CONTROL_TIMEOUT_MS);
+	if (retval)
+		return retval;
 
 	retval = get_mac_address(dev, addr);
 	eth_hw_addr_set(dev->net, addr);
-- 
2.55.0
