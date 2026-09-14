Received: from mail.auroraos.dev (unknown [95.181.193.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA9B47CC99;
	Mon, 14 Sep 2026 20:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.193.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417566; cv=none; b=glMbLPsAO+QUKYvSqJUMVymzLBPWD1YkIGw7Cbe9ku3BVB/hGMUMe/zkEe5f7qu4JxU4VPnJnHb+d6f8RceWAEjk+efJbv7Fhm4Q5+ET57CrNcDE3Uv250jI+xktdyb6Qra0DB6cLiJVVo0wx5VQETn2HGI2LEyRsr9JvUqFc94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417566; c=relaxed/simple;
	bh=S2DLb7Baz0egOMmQ61CMe3ocIrfFpR4DnEXrxCL5G9c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BMOd/PWLp4tlhHHaJSyRT6wJgRNSFHDsw2BWMy2OqnTTsldAcmGMcvWb+gKdUlynpUu8ev3GpvXg3PDuWBiRTYFKRcfDdBAenlZ7Liy0hGibgNDI7KLrUQ8Z8ZDZpqA8NiH7Czr8PoytjI+HSLvZKsJ9LuOuQFBb17MUyC1+Lf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev; spf=pass smtp.mailfrom=auroraos.dev; arc=none smtp.client-ip=95.181.193.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=auroraos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=auroraos.dev
Received: from wasted (91.78.33.248) by exch16.corp.auroraos.dev
 (10.189.209.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Mon, 14 Sep
 2026 23:25:49 +0300
From: Sergey Shtylyov <s.shtylyov@auroraos.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Sergey Shtylyov <s.shtylyov@auroraos.dev>, Matthew Garrett
	<mjg59@srcf.ucam.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] ch9200: return error on failed register writes in ch9200_bind()
Date: Mon, 14 Sep 2026 23:25:02 +0300
Message-ID: <20260914202503.52920-1-s.shtylyov@auroraos.dev>
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

Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

---
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
