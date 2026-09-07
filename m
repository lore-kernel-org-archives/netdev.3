Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701BC47885C;
	Mon,  7 Sep 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789057; cv=none; b=NhC0l3HNAranMIZD+w/7MxtoGLQ/1760vRSm/KmrC0gQeo+lXQEnbrohecjcWsNCEqnSlJfu/lwS/3OYND/xefT5csg/0UoKU7nvALbwr2WxXGB5GkxnnJbB2y/3tCyhX0H3OBwy029lTxcF6Ql18HWejfK59Y0u3sHMXezkT90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789057; c=relaxed/simple;
	bh=YXpnSVq188p4POcvSmkJWF/nC9Xp3316WGaY/c/QUzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfHXfjWpOQ2DagApqLO4eG9WHilyQLD//CAaZ+jMF75kcU5PklBScO3sU+pdZxabFC4ZmcRUWu1cwXWHyKP/itS+oWxr2xPT6FKtznH/51GsQ+J5ruOTI4HQIkoc4z0dh3i57GiOsZYGcQpzTteOTzjnjIvVJBG7RKWZM7dPZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=o5T7OVHR; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="o5T7OVHR"
Received: from email.seznam.cz
	by smtpc-mxd-8df7dc6f5-w2xkj
	(smtpc-mxd-8df7dc6f5-w2xkj [2a02:598:128:8a00::1000:a0a])
	id 7a71a44cfa96ced178059a22;
	Mon, 07 Sep 2026 15:50:07 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
	t=1788789007; bh=b447+c3JpacFqsplJGcvDlOAkpUQq6Xvi2xG1biFBc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	b=o5T7OVHR4Q9Q3sPRAHBEbWkLrBI1oDicoALcN8YQqaXu9FYGfiLvSBUPGV/b0NCmw
	 jEUOpDbG1cQmPgGM49Yj2wVUyNhx+UmQqtZ1UnkEN+gV2RI4imWx7Dnm12JoFuU9RC
	 gwx7mXomoHavbcfDMTbCccJrGzzPTMnYA4hGgLQZkmRSLTfwNyr+UhgrOptaIx0QrG
	 Yhj7yXJHtG7KTh5jlYx3wd7pXF3mYQ9gPfQhCEzEvtb45WAyTVq6D/rp3ecuAazXN7
	 IiFPk8K6QJb535CjuwOtka2wUgAgzMH9I5zhtCB0HZEgm4EM9youAEJEKw0dwh9380
	 xhaCOOpGSR6pA==
Received: from arch-zen ([2a02:8308:b086:3c00:3636:4bcf:b8c2:e5cf])
	by smtpd-relay-6ffbffc97b-l7tfj (szn-email-smtpd/2.0.82) with ESMTPA
	id bc3054f2-1adc-4e64-83e9-c5e4cecb86bc;
	Mon, 07 Sep 2026 15:49:31 +0200
From: "Jan Havran (Advantech Czech)" <havran.jan@email.cz>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jan Havran (Advantech Czech)" <havran.jan@email.cz>
Subject: [PATCH net 0/3] net: dsa: lantiq_gswip: SGMII/2500BASE-X and flow-control fixes
Date: Mon,  7 Sep 2026 15:48:15 +0200
Message-ID: <20260907134818.16670-1-havran.jan@email.cz>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three issues in the lantiq_gswip / mxl-gsw1xx DSA driver
found while bringing up a MaxLinear GSW145 over SGMII on a Marvell
Armada 7040 board, with the switch CPU port running 2500BASE-X and the
user ports at 1000BASE-T.

Patch 1 reorders the SerDes NCO clock-rate setup ahead of the SGMII shell
reset. Without it, only the rate the switch was left at by the straps or
the boot loader links up; the other rate comes up but forwards no traffic.

Patch 2 adds the missing SPEED_2500 case to gswip_port_set_speed(); without
it the CPU port was forced to 10 Mbps at 2.5G link-up.

Patch 3 corrects the GSWIP_MDIO_PHY_FCONTX_EN field value (a typo present
since the original vrx200 driver).

Tested on GSW145 hardware only. The register values are backed by the
public GSW145 data sheet and by the driver's own field encoding; the
xRX200/xRX300 data sheets are not public.

Jan Havran (Advantech Czech) (3):
  net: dsa: mxl-gsw1xx: set SerDes NCO rate before SGMII reset
  net: dsa: lantiq_gswip: handle SPEED_2500 in gswip_port_set_speed()
  net: dsa: lantiq_gswip: fix GSWIP_MDIO_PHY_FCONTX_EN value

 drivers/net/dsa/lantiq/lantiq_gswip.h        |  2 +-
 drivers/net/dsa/lantiq/lantiq_gswip_common.c |  1 +
 drivers/net/dsa/lantiq/mxl-gsw1xx.c          | 29 ++++++++++----------
 3 files changed, 17 insertions(+), 15 deletions(-)


base-commit: 38b6be101006d3e7af972999f45d4f1e8250587a
-- 
2.39.5

