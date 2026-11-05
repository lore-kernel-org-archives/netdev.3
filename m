Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887044;
	b=BKyL8WZNWI6Acw/kU5OrMPm92L1prioMJKWqE+2rY82pSajSBvVJWd7TYNjtMtfCj1Vr
	 EZD4H+hOzxr+KmFqDbaui8tFuiwsu0h13i0guyYsvK0yo3sfQsit2kNb7zkxwsZqFkHAT
	 Tc6sGo2ish++Sg+AFjY8CHwBzomDzT3oI13mSgzou/4CgwN2SGwYB3NxMtytJS6UyJhf4
	 7NyVZ6aYYTORZ+keYilQIOvHvMIjoQ5HeCI6osrYWufDcHHwOMOaYY5yo6RgytQmhgrx7
	 m6R09ovVW5039K14xxhDqfCooVN57QBglQepKIAtK7MNLe+rzK0UbHF05rUcUMjvzRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887044;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer;
	bh=lpSsFBYMJOjp2UGoZuYwqoOaJecqtn3T+EOGB0fgaFo=;
	b=RcnMsAWugqdN03fuFOKVvlQMXAmygY0zzaofKJLEh2FXXOD9//rMaP8IFmoCe3bVU/cF
	 0V/7P5ielcsfCrivDRnStPSQWM77iy4qXAiEqrup1DODOKKsVzcVVcTcs87KiaLFJlTR2
	 LVNcuEh+QjwqhU0MjSmUjrjxoO9pipdSwGiIqSWpIkbNmbB/gn7sSxU7mp2ER5soSLodB
	 1C5TYoi7DxIldU9cloaEJTYzpMLOCYE36WRRf/+tXKSdV3l67zMSSd7YxRX70CLqUSZ6B
	 jiAihViDbkprEsDzZUMpjGZYY0wbIt0IBNPAQrpRfdKaWaSLWP8AXc7JzMEvv/Agb1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=pZx4jgmA;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C793606EEB9;
	Thu,  5 Nov 2026 13:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C793606EEB9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=pZx4jgmA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793887044; x=1825423044;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=AS6YN7PNHmR1WJ7dk985HrdfIfCxE7SjW4P34crHnCQ=;
  b=pZx4jgmAEJkZpoAS9NIKW8CtZnOfcMNnPPM1LOl7tC6/QprNVMx20DFI
   rPxeLrMKaFmb2Ac4UdOX0sIpB35hMpiCGo3w25r8nutN0vXtgbXuyU1oR
   ADquPIiT9sHIENQOBYf9hsPwMbwOCgMnO6RhrmOApwAFD4D6/xIlNRoSA
   6H9DD87svmP3+7QYEgSa75wqL1yuMXKlbdn6JdCIi/Vj3rWi/qKNIoTGb
   l0lKk+Aw081lOaZDLdnMBELZoMJvzBms88iMZMcQbCdFtmjn8yp+onpB9
   Iy4cARWH65++VEngIkWo6KfnI2pxlaWC4i812Sue6r2QH1zTmlIc1p2Hd
   g==;
X-CSE-ConnectionGUID: amQdPwc/QcGGi1gsnE7ZPQ==
X-CSE-MsgGUID: NHEDFOPLSp+8RCuKkxALqw==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="65112466"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 06:57:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Thu, 5 Nov 2026 06:57:23 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Nov 2026 06:57:21 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Thu, 5 Nov 2026 14:56:44 +0100
Subject: [PATCH net-next 9/9] net: sparx5/lan969x: add support for changing
 the MTU
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261105-sparx5-mtu-change-v1-9-f27bab580463@microchip.com>
References: <20261105-sparx5-mtu-change-v1-0-f27bab580463@microchip.com>
In-Reply-To: <20261105-sparx5-mtu-change-v1-0-f27bab580463@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Richard
 Cochran" <richardcochran@gmail.com>, Russell King <linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Robert Marko <robert.marko@sartura.hr>
X-Mailer: b4 0.14.3

The MTU of a port is currently fixed to 1500, as the MAC maximum frame
length, the FDMA buffers, the queue watermarks and the TAS guard band
are all sized for a 1518 byte frame. The previous patches make the
buffers, watermarks and guard band follow the MTU, so changing the MTU
is a matter of programming the MAC and updating these.

Add an ndo_change_mtu callback that sets the MAC maximum frame length of
the port and resizes the FDMA buffers. The MAC must never accept frames
that are larger than the RX buffers, so when decreasing the MTU, the
maximum frame length is lowered before the buffers are shrunk, and when
increasing it, it is only raised once the buffers have been grown. The
new MTU is only published once the buffers fit it. If the buffers cannot
be grown, the MTU is not changed. If they cannot be shrunk, the current
buffers still fit all frames, so the new MTU is kept. Once the new MTU
is published, update the queue watermarks of the port and the TAS guard
band.

As the FDMA is shared by all ports, resizing its buffers briefly stops
CPU traffic on all ports. This only happens when the change affects the
buffer size needed for the largest MTU of the ports.

Register based extraction, which is used when the FDMA is not, sizes
its skbs from the MTU at the time a frame is read, so frames queued
before an MTU decrease would not fit. Therefore, only allow the MTU to be
changed when the FDMA is used.

The MACs of both Sparx5 and lan969x support frames of up to 14000 bytes,
so set the maximum MTU accordingly when the FDMA is used.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  1 +
 .../net/ethernet/microchip/sparx5/sparx5_netdev.c  | 48 +++++++++++++++++++++-
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index d150a76fc917e..181637b5f8f4a 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -110,6 +110,7 @@ enum sparx5_feature {
 #define SPX5_BUFFER_MEMORY     4194280 /* 22795 words * 184 bytes */
 #define SPX5_TAS_ENTRIES_PER_PORT 2 /* TAS lists per port */
 #define SPX5_HW_MTU(mtu)       ((mtu) + ETH_HLEN + ETH_FCS_LEN)
+#define SPX5_MAX_FRAME_LEN     14000 /* Max frame length supported by the MACs */
 
 #define XTR_QUEUE     0
 #define INJ_QUEUE     0
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
index b3725cf2dd44c..095925752f5f6 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_netdev.c
@@ -250,6 +250,44 @@ static int sparx5_port_hwtstamp_set(struct net_device *dev,
 	return sparx5_ptp_hwtstamp_set(sparx5_port, cfg, extack);
 }
 
+static int sparx5_port_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct sparx5_port *port = netdev_priv(dev);
+	struct sparx5 *sparx5 = port->sparx5;
+	bool resize = new_mtu > dev->mtu;
+	int err;
+
+	/* Register based extraction sizes its skbs from the MTU at the time
+	 * a frame is read, so it cannot handle frames queued before an MTU
+	 * decrease.
+	 */
+	if (sparx5->fdma_irq <= 0)
+		return -EOPNOTSUPP;
+
+	/* Never let the MAC accept frames larger than the RX buffers */
+	if (!resize)
+		sparx5_port_max_len_set(sparx5, port, SPX5_HW_MTU(new_mtu));
+
+	err = sparx5->data->ops->fdma_resize(sparx5, port, new_mtu);
+	if (err) {
+		if (resize)
+			return err;
+
+		/* The current, larger, buffers still fit all frames */
+		netdev_warn(dev, "Failed to resize FDMA buffers: %d\n", err);
+	}
+
+	WRITE_ONCE(dev->mtu, new_mtu);
+
+	sparx5_port_wm_update(sparx5, port);
+	sparx5_tas_gb_update(sparx5);
+
+	if (resize)
+		sparx5_port_max_len_set(sparx5, port, SPX5_HW_MTU(new_mtu));
+
+	return 0;
+}
+
 static const struct net_device_ops sparx5_port_netdev_ops = {
 	.ndo_open               = sparx5_port_open,
 	.ndo_stop               = sparx5_port_stop,
@@ -257,6 +295,7 @@ static const struct net_device_ops sparx5_port_netdev_ops = {
 	.ndo_set_rx_mode_async  = sparx5_set_rx_mode,
 	.ndo_get_phys_port_name = sparx5_port_get_phys_port_name,
 	.ndo_set_mac_address    = sparx5_set_mac_address,
+	.ndo_change_mtu         = sparx5_port_change_mtu,
 	.ndo_validate_addr      = eth_validate_addr,
 	.ndo_get_stats64        = sparx5_get_stats64,
 	.ndo_get_port_parent_id = sparx5_get_port_parent_id,
@@ -306,7 +345,14 @@ int sparx5_register_netdevs(struct sparx5 *sparx5)
 
 	for (portno = 0; portno < sparx5->data->consts->n_ports; portno++)
 		if (sparx5->ports[portno]) {
-			err = register_netdev(sparx5->ports[portno]->ndev);
+			struct net_device *ndev = sparx5->ports[portno]->ndev;
+
+			/* The MTU can only be changed when FDMA is used */
+			if (sparx5->fdma_irq > 0)
+				ndev->max_mtu = SPX5_MAX_FRAME_LEN - ETH_HLEN -
+						ETH_FCS_LEN;
+
+			err = register_netdev(ndev);
 			if (err) {
 				dev_err(sparx5->dev,
 					"port: %02u: netdev registration failed\n",

-- 
2.34.1

