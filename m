Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794376931;
	b=42Sh1bT0WAv1UCVIGEpiaJwBmxfX5Eerr+DWHsw/6RCsoQeZ7kEKb5Fx76/0f6nvv7at
	 RAhrH7UvIK1FeLuyuiDag3dMmFrhtiPyjkWxUM8WN4koQ6CbL45fZsNeVWY1uLGMmj1S+
	 XouCNzp2ANomt0LNyU6zGRKNZF0qppHGq3AHG73WBY/QBSD1p6/2oqtNiyVRKRChe4NMm
	 26eEj4tcH/ODYoqPOUi24jbh6j5RN2s+lphgGJ4EEWPMt3z4q1mvrwXcmZAtzz2FVXrJd
	 WS+/ElUAPJYFjgHwBpyQM2uyX94hGjm76yWAu0CdErN47oMLJgYJ2clNRlkTE4pB4gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376931;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=clJ16mqtaU4VebO6eCORWaZIIouvMDiu9cYs0vhp9oQ=;
	b=cFs5lV92PZcv9/iFripYKFCRgMGyFtQk+AJM7bFr1SDbIMXeyTbrmvqlLtTsJTdpLnPu
	 NUsPAx0AnWzMoqign7j20WCVANDcNJvm6npmo0NYAjnhs/5T0NP6k92UcZPnxeRndRaJp
	 ydXCLvq77ii249pQUMISy02PK132hPBPM+4WStEaWcuhq4xo/bXaP5YTTq3jatA7kzZLp
	 VOP8avz8ki7K9zj/kgyZIlovh+xa0bxiT36NrfqsGDlcgrR/EEMSl6effYd+hEU9zwSLf
	 JdboBb1hJQ24WkFJ6iGR111ZqjDEQzjK+CLjNwme2ID1BmgOPcrcLr3V3VdtD3isfdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=B82NAHBp;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD52E606A31C;
	Wed, 11 Nov 2026 06:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD52E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=B82NAHBp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=B82NAHBpjl5lwEA6S+7NHHaJ3+WCHX1PyueGyZBoHRhwg7f03Ul61dwCezWxA2wJZliN5P2Sc26DL
	 rhRWs14sNiO460es2ftG/VzduG7v8ZEr1PRnxi3u6zCV29VwHT8nJsuhifCRTapY4vfCLY0sZSwDFV
	 EWplzW/7ChQ6KCPY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af404da9d7-74870;
	Wed, 11 Nov 2026 14:02:05 +0800 (CST)
X-RM-TRANSID:2ee46af404da9d7-74870
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af404dc3a6-d03ed;
	Wed, 11 Nov 2026 14:02:05 +0800 (CST)
X-RM-TRANSID:2ee86af404dc3a6-d03ed
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	MD Danish Anwar <danishanwar@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: [PATCH net] net: hsr: clean up synced addresses and allmulti in hsr_del_port()
Date: Wed, 11 Nov 2026 14:01:43 +0800
Message-Id: <20261111060143.183670-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsr_set_rx_mode() syncs unicast and multicast addresses to slave A and
slave B devices via dev_uc_sync_multiple() and dev_mc_sync_multiple(),
and hsr_change_rx_flags() propagates IFF_ALLMULTI via
dev_set_allmulti().

However, when an HSR device is deleted via hsr_dellink(),
hsr_del_ports() removes all ports from hsr->ports before
unregister_netdevice_queue() invokes hsr_dev_close(). Similarly, when a
slave device is unregistered while the HSR master is UP,
hsr_netdev_notify() calls hsr_del_port() directly. Because
hsr_del_port() does not unsync unicast/multicast addresses or restore
the allmulti count, the slave devices permanently retain synced hardware
addresses and a leaked allmulti reference count after port deletion.

Fix this by calling dev_uc_unsync() and dev_mc_unsync(), and
decrementing allmulti via dev_set_allmulti(port->dev, -1) if
IFF_ALLMULTI is set on the master device, when detaching slave A or
slave B in hsr_del_port().

This issue was identified with the assistance of an LLM-based code
review tool, confirmed by reproducing the leaked allmulti reference
count and synced multicast address in a User-Mode Linux (UML)
environment, and verified in UML that both states are properly cleaned
up upon HSR port deletion.

Fixes: 36b20fcdd966 ("net: hsr: Add support for MC filtering at the slave device")
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
 net/hsr/hsr_slave.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index a546f70f9cc8..bab0c27dd06a 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -245,8 +245,14 @@ void hsr_del_port(struct hsr_port *port)
 		netdev_rx_handler_unregister(port->dev);
 		if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK)
 			dev_set_promiscuity(port->dev, -1);
-		if (port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B)
+		if (port->type == HSR_PT_SLAVE_A ||
+		    port->type == HSR_PT_SLAVE_B) {
 			vlan_vids_del_by_dev(port->dev, master->dev);
+			dev_uc_unsync(port->dev, master->dev);
+			dev_mc_unsync(port->dev, master->dev);
+			if (master->dev->flags & IFF_ALLMULTI)
+				dev_set_allmulti(port->dev, -1);
+		}
 		netdev_upper_dev_unlink(port->dev, master->dev);
 		if (hsr->prot_version == PRP_V1 &&
 		    port->type == HSR_PT_SLAVE_B) {
-- 
2.33.0



