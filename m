Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6653A4249
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591201; cv=none; b=ppFJXfusL+tD/VLF/dnA9PfJnglaRjFjqG+ef8Mt8JMAoD9MRxU9OERnUuHhxc9A6HfFphbBx/5CCA/qeuhOXAip0qhiDFLahADdmYsPvuJukBXLBKxhVqd6pDldEcVBFCaD4LulSS+rHoySHtEOD6CMIr6ex1OAT8b5a+Fo8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591201; c=relaxed/simple;
	bh=71W9CQ/u8V/IYMtFUt8CnZW9A2VV7G3YlPgnygGV0fE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lnyVO4YWSJfgs2ymLX9iR3oejct9R/mDR30njyoWkXno9FuJzftYNx7fWXBMSlzdhGyaYsVg+wbw/NhwwxVucHMjTCRc2gp2w3rmBs6Gbq/Nt8MXjbBs//6B+YwySUoTK/6J8MBSbzq+t6+oozLvDDHXS5cBJsM9G+DMQ2NehCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cXC4KgY9; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cXC4KgY9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C2DFF4E42C1C;
	Tue, 12 May 2026 13:06:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96BD560646;
	Tue, 12 May 2026 13:06:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CA1B11AF883A;
	Tue, 12 May 2026 15:06:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778591196; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xtR3PbQ8LkC7/BxqrO5iWBMQ/JhzVCinCp73MwwnS80=;
	b=cXC4KgY9qx8Xpf08GkJXaJt8PAEOCe+NhcLLgW6+j4a9xul4lv4rsPejMeHtMWhNjRUZbX
	F4VrNz3339hJBNtOFHcoNewZEZCdDroVbkZ/2uXgWGYtY177aKIKTeakO1aKpDYymHPLGM
	EW1oornrPz6+DY/mIDDsSfJIlQHExmbZt/hobrkFYAFu0NEBCG9P9JJ1LimQO5qldhDJpG
	8AXMqVRQ2HfObgVQmIoCz1Exr2gHPMO0qVw9uzY2CTySpye/SZOF7xaqXbSkFyrJ9xk59A
	LhJ13PgEXW/4cw2IRS0u6af3TW+JYcd5NZNOI9Ow13n2X6cYRjTvbgH8bHAJEw==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 12 May 2026 15:06:23 +0200
Subject: [PATCH net-next 01/15] net: dsa: microchip: remove unused
 phylink_mac_link_up() callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-clean-ksz-2nd-series-v1-1-c00f6ce037fa@bootlin.com>
References: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
In-Reply-To: <20260512-clean-ksz-2nd-series-v1-0-c00f6ce037fa@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

ksz_dev_ops::phylink_mac_link_up() isn't used anywhere.

Remove it.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 3dde7e7717272..0ab3b4f96595a 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -444,11 +444,6 @@ struct ksz_dev_ops {
 			   u8 data);
 	void (*freeze_mib)(struct ksz_device *dev, int port, bool freeze);
 	void (*port_init_cnt)(struct ksz_device *dev, int port);
-	void (*phylink_mac_link_up)(struct ksz_device *dev, int port,
-				    unsigned int mode,
-				    phy_interface_t interface,
-				    struct phy_device *phydev, int speed,
-				    int duplex, bool tx_pause, bool rx_pause);
 	void (*setup_rgmii_delay)(struct ksz_device *dev, int port);
 	int (*tc_cbs_set_cinc)(struct ksz_device *dev, int port, u32 val);
 	void (*config_cpu_port)(struct dsa_switch *ds);

-- 
2.53.0

