Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466056;
	b=BWYd9DLRJTFDet476zKkxiD7gIrNjp5xS4DdcfoP9ptjxsyGY4r+1uDWiCKbM3ior4Xc
	 TF4XZafJuOBft9TxY8niZoKxA2fcgDkp+yErMYoM8eMviflwRV/y8B2lXwuonpbHOQiFr
	 OMaxX0h14yHo1oeGx8Y0eUhO2DVI99L2f5Z7TYOSdn+YrQD4uL/VKpCI5RCYHjFZuZYy3
	 Z2AzjYM8WgXHpX0YSDc6LvL/Ng9ETLChqK5yRBAYcLXFoKhpEOjm1NHukSd9syA+ROE13
	 prkvxTTSGmxnaIFBTTSrJIzbCuITzHyxyPV4vjqq0XUa58OGZjbFhSV9VDXEMr424sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466056;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j0GyUlZEGPpriF5zPEiTDrFh1ANa5ZJWc2IPoRZAtwk=;
	b=DFEurAoTV2Dckq5sKhXmKpR81SWb5SqJYn3H1WTyRE/dah/IVFKnsu2JWLmv0JwK/wOV
	 SNE0L8zT0FgSZ7HXdRRbtBQqGoh+oS7tnElwglA287A32qJCsXKSR0aQSosaEXBoCC0l5
	 kuQaPN/8e98VbaP9eI/NzDmeo3fdxtt7bH1N7emhbnD/6ztjRsX+UzdwMMMJcDFEYhISR
	 yhfUgFFBoDROAtGqEy5FqfXJ3384pTTBbn0HTRtlQJc9GYqM7Ye6qSr0NMw2RSlobUJqU
	 curKn62/F8pWaxL/H2ji99GmDe9H+hnksppk6LE90jecd3EL12GPiTvY6zykm/awNqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vKBz5uI6;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4348F606A31C;
	Thu, 12 Nov 2026 06:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4348F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vKBz5uI6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=vKBz5uI6r/9pLOdZPv7b6wDRHifK2aLXGeU62SgxrC637Rs+Dz8Od/kzM4/aQkDagTbl28Yv1XLpi
	 IV8kXQQzezGc95aQH7c5u43mSghJmghhgHq03ThAsQCaAAp+KpxHzZoscQhotCNMsyzIPFk81MmLxF
	 9XBwZCPfNLISUVhU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26af56102d50-1acc8;
	Thu, 12 Nov 2026 14:47:33 +0800 (CST)
X-RM-TRANSID:2ee26af56102d50-1acc8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6af5610144b-f5982;
	Thu, 12 Nov 2026 14:47:33 +0800 (CST)
X-RM-TRANSID:2eea6af5610144b-f5982
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Hangbin Liu <hangbin.liu@linux.dev>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	MD Danish Anwar <danishanwar@ti.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: [PATCH net v2] net: hsr: clean up synced addresses and allmulti in hsr_del_port()
Date: Thu, 12 Nov 2026 14:47:16 +0800
Message-Id: <20261112064716.85381-1-sunwenbo@cmss.chinamobile.com>
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

When an UP HSR device is deleted via hsr_dellink(), hsr_del_ports()
removes all ports from hsr->ports before unregister_netdevice_queue()
leads to hsr_dev_close(). Consequently, hsr_dev_close() iterates over an
already-empty port list and cannot execute dev_uc_unsync() or
dev_mc_unsync() on the detached slaves. Likewise, when a slave device is
unregistered while the HSR master is UP, hsr_netdev_notify() calls
hsr_del_port() directly without running hsr_dev_close(). In addition,
hsr_dev_close() does not release IFF_ALLMULTI on slave devices either.
As a result, detached slave devices can retain synced unicast/multicast
addresses and an elevated allmulti reference count.

Clean up these states in hsr_del_port() when detaching slave A or slave B
by calling dev_uc_unsync(), dev_mc_unsync(), and, when IFF_ALLMULTI is
set on the master device, dev_set_allmulti(port->dev, -1).

This issue was identified with the assistance of an LLM-based code
review tool, confirmed by reproducing the retained allmulti reference
count and synced multicast address in a User-Mode Linux (UML)
environment upon deleting an active HSR interface, and verified in UML
that both states are properly cleared after HSR port deletion.

Fixes: 36b20fcdd966 ("net: hsr: Add support for MC filtering at the slave device")
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
Signed-off-by: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
---
Changes in v2:
- Clarify the commit message to explain explicitly why hsr_dev_close()
  iterates over an already-empty hsr->ports list on hsr_dellink() and
  does not release IFF_ALLMULTI, answering Hangbin Liu's question.
- Add Reviewed-by from Hangbin Liu.
- Link to v1: https://lore.kernel.org/r/20261111060143.183670-1-sunwenbo@cmss.chinamobile.com

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



