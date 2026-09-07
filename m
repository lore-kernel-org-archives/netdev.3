Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33DD4D98EF;
	Mon,  7 Sep 2026 13:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789203; cv=none; b=huBmbvij4LAFDURZXZdJd4GSXhNdR9pjIqYwXvTggkBiU/8rz6Q4LOa1xA2NxYU9j/nVHQdo9VdpXB/KuUL0zuGlgqMnWIXUHwrGs4V4rhaq0+towFtenweJlvscfJwEbuYXXNg+HIQNSODOal9i8jHn8YW2aqr8vvhxmZD8nYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789203; c=relaxed/simple;
	bh=6XAhUDHRh00qK7xNcGVH+kIrArDv7jC8q4bwjpDHnTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5yW1OsRYaBkxx8Xf+eJAnimtnXMECTARGx1bBjIXRSeh/v3JWnSyopKQ0MRDceL86P7RMta/9CpfmPZ/VIlj8nlx4yqPInlgWKspX4teZl083mDK1vAMT9whQMs/STth1fvjzjdzLdF6DIOk8ANhBIYJ1eaBtdun9XqwqEIfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz; spf=pass smtp.mailfrom=email.cz; dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b=Jjjef6aG; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=email.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=email.cz header.i=@email.cz header.b="Jjjef6aG"
Received: from email.seznam.cz
	by smtpc-mxd-8df7dc6f5-mtdcb
	(smtpc-mxd-8df7dc6f5-mtdcb [2a02:598:96:8a00::1200:70a])
	id 595cf1d7d9bb9b4a5b28cfb9;
	Mon, 07 Sep 2026 15:53:15 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=szn1;
	t=1788789195; bh=KbfbAnfKkMJRLguqz6jlFQXIkEF6dh+uEy2whayqEFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding;
	b=Jjjef6aGwdkmy9hf/5QW9noXODNIHXbsPKzNrjwNKBU14ws1IdI6XR5/BB0Y9WePF
	 LFkaWQvzZ+oE1M66ziVE/OQ6TvxEMLWLhPl/M5SQewGJsjFcyM1BnPNjEr0Iyhj8id
	 HwkKx60Wkj7ChqKKQaWayEj2FV6vB2xAF0AVySg7MMVQliYKyMUvFUNk3FllcUqdLP
	 LTt2hTjdwsKRLrTr15BfqULV0imWfGmXDQ/PiFQ1fIUQ9wVnleMPWb5hOrnemDgjLQ
	 K1h7pbK68zkoloc/fU7kgMEAlfLm1Gmr23wfWhndpFF9Q3SJxbzfGI4k0AoETjaqGn
	 phpIZCUAuiYaw==
Received: from arch-zen ([2a02:8308:b086:3c00:3636:4bcf:b8c2:e5cf])
	by smtpd-relay-6ffbffc97b-l7tfj (szn-email-smtpd/2.0.82) with ESMTPA
	id 1c7a8d14-1b8b-4ec9-aa20-1ee60de1e924;
	Mon, 07 Sep 2026 15:49:49 +0200
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
Subject: [PATCH net 3/3] net: dsa: lantiq_gswip: fix GSWIP_MDIO_PHY_FCONTX_EN value
Date: Mon,  7 Sep 2026 15:48:18 +0200
Message-ID: <20260907134818.16670-4-havran.jan@email.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907134818.16670-1-havran.jan@email.cz>
References: <20260907134818.16670-1-havran.jan@email.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the GSW145 data sheet, the FCONTX (bits 8:7) and FCONRX (bits 6:5)
flow-control fields of the PHY_ADDR_n register both encode 00 = AUTO,
01 = EN, 10 = reserved, 11 = DIS. GSWIP_MDIO_PHY_FCONTX_EN was 0x0100,
i.e. field value 10 (the reserved encoding), instead of 0x0080 (01 = EN);
FCONRX_EN is already 0x0020 (01). Enabling tx flow control therefore wrote
the reserved value.

Set FCONTX_EN to 0x0080. The register is shared by all supported parts.

Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
Signed-off-by: Jan Havran (Advantech Czech) <havran.jan@email.cz>
---
 drivers/net/dsa/lantiq/lantiq_gswip.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
index bc3686faad0d6..0b75be14dc109 100644
--- a/drivers/net/dsa/lantiq/lantiq_gswip.h
+++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
@@ -42,7 +42,7 @@
 #define  GSWIP_MDIO_PHY_FDUP_DIS	0x0600
 #define  GSWIP_MDIO_PHY_FCONTX_MASK	0x0180
 #define  GSWIP_MDIO_PHY_FCONTX_AUTO	0x0000
-#define  GSWIP_MDIO_PHY_FCONTX_EN	0x0100
+#define  GSWIP_MDIO_PHY_FCONTX_EN	0x0080
 #define  GSWIP_MDIO_PHY_FCONTX_DIS	0x0180
 #define  GSWIP_MDIO_PHY_FCONRX_MASK	0x0060
 #define  GSWIP_MDIO_PHY_FCONRX_AUTO	0x0000
-- 
2.39.5

