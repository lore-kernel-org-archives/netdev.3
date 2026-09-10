Received: from mail.dspace.de (mail2.dspace.de [80.228.58.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FCE47426F;
	Thu, 10 Sep 2026 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.228.58.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789040402; cv=none; b=jvtXLmQ0w+uC63eEIor6K8Qllv9NNOY9RWzgaDgsQvpHLbV4gndiDiFxYaYUHsxPyIJ6Z6joT6bL5BNPeazphn4MWjGCBNGYkUi0fXS+zMpCnpgjTCo5LDKV6QFRf+y1KpnVB1Z0hEJKDM18mHT/aw+zi6NiyFkdjImMXONQdXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789040402; c=relaxed/simple;
	bh=YYEdVx3PupT2oaaRu2QlzSM0l5sq3GFzN7SVQ2V40+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiPCiYnK2/omury8z0RVQgbRi1cbHBQgA8XMMMUqz0lUwveOX/Ki08Y0D8YzupJgfTlZJ8chyF9fV52E2uEKx4hXyV+XIMWJI9No+0I6HAv2j7BfyjdsU3u8Q9upNX8IZchwAU5bkveV0iUPW5cVrD3tDaCrSvC5zFKk240MRO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dspace.de; spf=pass smtp.mailfrom=dspace.de; dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de header.b=G1z5szZD; arc=none smtp.client-ip=80.228.58.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dspace.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dspace.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=dspace.de header.i=@dspace.de header.b="G1z5szZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dspace.de; i=@dspace.de; q=dns/txt; s=dkim1;
  t=1789040398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HYc1GkjMkoO0IwSEGcDUPrpgIzT7TfqZnoypA7FbSqQ=;
  b=G1z5szZD6rfte4fDyN4eyFlU7ekzqMhF4yNfP0X+k60udkfufB3vrXQX
   0WHaNJpdV1p3axbbWsEzloKHckHAaUskJjQ3cpVHWxaVUmzKZ3OZ7Jj/F
   plLQoesKJFkhdCfwVAyMltJbyy512x/G2iyggwJ/9IVamC/0A3H7j/AVi
   I=;
X-CSE-ConnectionGUID: hHALKpIESwy/OraNpp4jyg==
X-CSE-MsgGUID: wf3VMeShRv6nmsXOAm5CQw==
X-IronPort-AV: E=Sophos;i="6.27,95,1787004000"; 
   d="scan'208";a="5467930"
Received: from unknown (HELO Z1-1000) ([10.1.1.222])
  by mail.dspace.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Sep 2026 13:39:55 +0200
Received: from VM-Z1-1000-LIVE.dspace.de (localhost [127.0.0.1])
	by Z1-1000 (Postfix) with ESMTP id AF51E60037;
	Thu, 10 Sep 2026 13:39:55 +0200 (CEST)
Received: from exchange.dspace.de (EX-DE-PAD-SE.dspace.de [10.100.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Z1-1000 (Postfix) with ESMTPS id A195560036;
	Thu, 10 Sep 2026 13:39:55 +0200 (CEST)
Received: from PascalKW11-NB.dspace.de (10.71.5.241) by EX-DE-PAD-SE.dspace.de
 (10.100.196.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 10 Sep
 2026 13:39:55 +0200
From: Pascal Kneuper <PKneuper@dspace.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
CC: Daniel Baldin <dbaldin@dspace.de>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pascal Kneuper <PKneuper@dspace.de>
Subject: [PATCH net 2/2] igb: Quiesce the receive path before enabling i210
 Rx timestamping
Date: Thu, 10 Sep 2026 13:38:54 +0200 (CEST)
Message-ID: <20260910113854.13279-3-PKneuper@dspace.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910113854.13279-1-PKneuper@dspace.de>
References: <20260910113854.13279-1-PKneuper@dspace.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX-DE-PAD-SE.dspace.de (10.100.196.14) To
 EX-DE-PAD-SE.dspace.de (10.100.196.14)
X-C2ProcessedOrg: 563f5800-21cf-4d8d-8aed-fddd1469e4ee
Content-Transfer-Encoding: quoted-printable
X-TBoneOriginalFrom: Pascal Kneuper <PKneuper@dspace.de>
X-TBoneOriginalTo: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
X-TBoneOriginalCC: Daniel Baldin <dbaldin@dspace.de>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Pascal Kneuper <PKneuper@dspace.de>
X-TBoneDomainSigned: false

Commit e57b8bdb4833 ("igb: Add 1588 support to I210/I211.") enables
per-packet Rx timestamping by setting RXPBS.CFG_TS_EN with Rx queues
running. On i210/i211, CFG_TS_EN makes the DMA engine prepend a 16-byte
timestamp header to every Rx packet buffer and sets RXDADV_STAT_TSIP in t=
he
Rx descriptor so igb_clean_rx_irq() strips it.

Setting CFG_TS_EN changes the buffer layout of already-armed descriptors.
Without a pipeline handshake, descriptor status and packet buffer layout
disagree for in-flight packets:

  header inserted, no TSIP -> unstripped, frame shifted 16 bytes right
  TSIP set, no header      -> 16 bytes stripped, buffer tail appended

In both cases the Ethernet header is corrupted, causing protocol demux to
drop the frame silently. Because igb_alloc_mapped_page() allocates pages
without __GFP_ZERO, the second case appends uninitialized memory.

This occurs reliably on i210/i211 under traffic when requesting hardware
timestamps at runtime, yielding corrupt frames on off-to-on transitions.

Fix by bracketing the CFG_TS_EN transition with igb_down() and igb_up()
when the interface is running, ensuring the bit is only toggled with Rx
queues stopped.

Fixes: e57b8bdb4833 ("igb: Add 1588 support to I210/I211.")
Signed-off-by: Pascal Kneuper <PKneuper@dspace.de>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ether=
net/intel/igb/igb_ptp.c
index 638d8242b66bb..4da26e997f92c 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -1283,9 +1283,26 @@ int igb_ptp_hwtstamp_set(struct net_device *netdev=
,
 			 struct netlink_ext_ack *extack)
 {
 	struct igb_adapter *adapter =3D netdev_priv(netdev);
+	struct e1000_hw *hw =3D &adapter->hw;
+	bool quiesce =3D false;
 	int err;
=20
+	/* CFG_TS_EN changes the Rx buffer layout, so flipping it on a live
+	 * queue leaves the descriptor and the data disagreeing about the
+	 * 16 byte timestamp header for one window, mangling a frame.
+	 */
+	if ((hw->mac.type =3D=3D e1000_i210 || hw->mac.type =3D=3D e1000_i211) =
&&
+	    netif_running(netdev) &&
+	    !(rd32(E1000_RXPBS) & E1000_RXPBS_CFG_TS_EN)) {
+		quiesce =3D true;
+		igb_down(adapter);
+	}
+
 	err =3D igb_ptp_set_timestamp_mode(adapter, config);
+
+	if (quiesce)
+		igb_up(adapter);
+
 	if (err)
 		return err;
=20
--=20
2.47.3

