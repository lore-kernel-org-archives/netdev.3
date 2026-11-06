Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794007139;
	b=RYrzCTzviyBZVYXB4Xx8Yg7W8McMxtSfYyIeyqgnOsdU55Ur1CpWqoJSlXGuoXnITEFa
	 xP/XK9+FyTV9KMHvPd8l6f8ndsXTyYmcAu1M9po0Dvcctz9ZlGf2EU4bVjkHkLbK4U4RL
	 vksRmpQI4sGFflytRYyAPi9dPZAm/mr7JsBZcgH9nP6qadruLAQ5tnPtCkhfORVKAuWlN
	 VnbSrUSeICA3tVwVBqc6TA9EuqtJVfEkgdO0GWKcWUYcBoK3gbLsaD9+gZ/yT4IPN3faK
	 j+mQM/qh3qzTAOw6kLd1Vl6HLGHkwL3/+mBvIcxCPioSL23IQ5UOFhNvEPqfSCKCvVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007139;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=noHKKnjSRsjFiJnjiLkSMLX5VsJo33DWvruhsis/05E=;
	b=f+1nTBnoYDnQFMJUEfwfJ6s00MKEP+ECTalKPdEahSr/35XKKoxwM5nkZmFUceFBhbb1
	 04Ev95zOcfIuNCWuuAgq9JyGYkY9uDy5dZqrlXvxJUj68s3gI1vePglyf6yvCeeZf7kyF
	 T3r6Wtv/VgdazwAPD4hg6VJX/V2dFO2HP1mxtVT48vzfiZE5RyvHQ2W1gdIViSDf18cwv
	 GqDiYggtUYgd7fu+gGzYL8yEfJQTNa3q8WO9JytHNL7NcSs6GtJb8HL67+opxPshCgvIc
	 /ktk9Cg20dOvuFOjbjh6miEWVM1hD7AcS+OJtJTw5FbJimrJ8b1RJDQjQTzqY9D/rwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqdR6OQ+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5584606D817;
	Fri,  6 Nov 2026 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hqdR6OQ+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794007138;
	b=erDENNNMVOHAp0rWl46+WvzjprQkU+kdX/9E+EsX6ho8LyEjR12YcA+Ybz7rCOFc0Gfy
	 pg27nZdm8t9u1cLtptNKpGSxhaqmVM0g2dlnHrxGhTrQq8yLniC0rhMEaeQ0hk3TglyEk
	 fosaSX3+LeZTnbzGeuMawpO9vO+DLenvNeKWooCiqm62eRPLJrBRldM2BMi13oltajoEx
	 fc4lHtm3CiipwdE8j3oLvzj+jK3vzTuYmFudbHjOE21yB1pZKvqDSuk+iPSB1tmiSeC/Z
	 oJkqT/Gt4YKR5KXGJeb2f2VvbjCavXLrevnDy0bvNpuIdw9OnCZAWmeJCDXzbUqxy1A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794007138;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=noHKKnjSRsjFiJnjiLkSMLX5VsJo33DWvruhsis/05E=;
	b=U1Hib4023xVJrbi5bCNUhc15YmHNVuk84MfE7nOoF6DA1jb6BvWxx8EqkZyY2NlobT/F
	 47UoqswUfPelqqNiYs3r6e8S3hnmdX5W3TC8T8G9ViwNoHiAxeoJEgQQ4Yzk36GHwFDsY
	 lDEN1OvwP1DJZN82iaUKfw55Gje2jRgzhWAJHUITIpWvKE+jsATDGkh1PPybj/qH2sdFF
	 n6V8L3sZOeISMFOMa+tdw2o7ch1xmSeH8IYCZg5ZjE5kL8hK3QbjGGe4BPctN3DqA9cqY
	 Ypm+YvUzujnHQna/rpAv5DgvmbcKwkD5U86HnLHnm8oYPz++r6Dz0ida4uCmornIERw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BC08F1F008AB;
	Fri,  6 Nov 2026 23:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794007138;
	bh=noHKKnjSRsjFiJnjiLkSMLX5VsJo33DWvruhsis/05E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hqdR6OQ+d/bDflNNPwfIjIrEUWA69xQgI6McHAlchc7FfpIb3oife97e5lBQhMZEY
	 yV2S4UDqVleLlLmszr5E+UIaakuIL4oiz+YcdRY/Gdev7BjcYz68gEQfs/KUmh9G7b
	 O7k78OtSgug40NEbgIR1y96qJLoXgJ7ve2a94cNasbbDq7pcSVzJn9+qLFbvME4ZV+
	 nJcudCa3h8kTgZupIdO7MVMqHMxTgKPepmhpSZxUfWh4XnPxUOGQVSYgF73KuhJxjK
	 EXEsD9jQJkNpPr5034GvEuum5GxXb+obZzvXTlIEgx4XnHSOMIf6YnmYq62phHtt3V
	 eqi2V7HvSYFsw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 36033478F0;
	Fri,  6 Nov 2026 23:18:55 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 06 Nov 2026 15:18:52 -0800
Subject: [PATCH net-next v10 06/11] net: ethernet: oa_tc6: Support for
 vendor specific MMS
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
Message-Id: <20261106-s2500-mac-phy-support-v10-6-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794007133; l=5213;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=ADbDwJZUXJpXDi7nCi09a1C9W5pYqfG/AwuaN/N5bAw=;
 b=MwF/jxvHsFpFTdYT88DRJtEdxAQrYUktNNrFOaNhzjpfUvWmHR0i3ckn9F6MCdp7ekLPeMiVn
 EH13LScNjDsD4HSUB+VVYkREY9uxoZV60X2//cYkyCC3pk8Vsbyk2Ss
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

OPEN Alliance 10BASE-T1x Serial Interface specification, table 6
allows vendors to use any memory map select (MMS) value between
10 and 15. This new API interface enables vendor to map one of
thes MMS values to MDIO_MMD_VEND1.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v10
  - Moved the API documentation to this patch
changes in v9
  - Added the missing vend1_mms initializer to where it belonged
  - Added Reviewed tag
changes in v8
  - No change
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - no change
changes in v4
  - no change
changes in v3
  - no change
changes in v2
  - Moved the handling of vendor specific MMS mapping to separate patch
  - new patch
---
 Documentation/networking/oa-tc6-framework.rst |  7 +++++++
 drivers/net/ethernet/oa_tc6/oa_tc6_main.c     | 21 ++++++++++++++++++---
 drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h  |  1 +
 include/linux/oa_tc6.h                        |  1 +
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/oa-tc6-framework.rst b/Documentation/networking/oa-tc6-framework.rst
index 23856c4bfd69..3cfe8cb7cf75 100644
--- a/Documentation/networking/oa-tc6-framework.rst
+++ b/Documentation/networking/oa-tc6-framework.rst
@@ -537,6 +537,13 @@ Provides hardware timestamp related traffic statistics for ethtool.
 Helper to set hardware timestamp configuration. Part of net_device_ops
 callbacks.
 
+.. c:function:: void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
+
+Helper to map MDIO_MMD_VEND1 command to vendor specific Memory Map Select
+(MMS) value. This function offers flexibility for vendors that may have
+used any MMS value between 10 and 15 as allowed by the specification.
+MDIO_MMD_VEND2 is already mapped to MMS4 in the OA TC6 frame work code.
+
 .. c:function:: int oa_tc6_write_register_mms(struct oa_tc6 *tc6, \
                                               u8 mms, u16 address, \
                                               u32 value);
diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
index e793d7fb0635..5b2454b75974 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
@@ -266,6 +266,18 @@ static int oa_tc6_update_standard_capability(struct oa_tc6 *tc6)
 	return 0;
 }
 
+/**
+ * oa_tc6_set_vend1_mms - Add vendor specific MDIO_MMD to OA TC6 MMS
+ * mapper value.
+ * @tc6: oa_tc6 struct.
+ * @mms: vendor defined MMS value for VEND1 mdio device.
+ */
+void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms)
+{
+	tc6->vend1_mms = mms;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_set_vend1_mms);
+
 static __be32 oa_tc6_prepare_ctrl_header(u32 addr, u8 length,
 					 enum oa_tc6_register_op reg_op)
 {
@@ -593,7 +605,7 @@ static int oa_tc6_mdiobus_write(struct mii_bus *bus, int addr, int regnum,
 				     val);
 }
 
-static int oa_tc6_get_phy_c45_mms(int devnum)
+static int oa_tc6_get_phy_c45_mms(struct oa_tc6 *tc6, int devnum)
 {
 	switch (devnum) {
 	case MDIO_MMD_PCS:
@@ -606,6 +618,8 @@ static int oa_tc6_get_phy_c45_mms(int devnum)
 		return OA_TC6_PHY_C45_AUTO_NEG_MMS5;
 	case MDIO_MMD_POWER_UNIT:
 		return OA_TC6_PHY_C45_POWER_UNIT_MMS6;
+	case MDIO_MMD_VEND1:
+		return tc6->vend1_mms;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -619,7 +633,7 @@ int oa_tc6_mdiobus_read_c45(struct mii_bus *bus, int addr, int devnum,
 	int mms;
 	int ret;
 
-	mms = oa_tc6_get_phy_c45_mms(devnum);
+	mms = oa_tc6_get_phy_c45_mms(tc6, devnum);
 	if (mms < 0)
 		return mms;
 
@@ -637,7 +651,7 @@ int oa_tc6_mdiobus_write_c45(struct mii_bus *bus, int addr, int devnum,
 	struct oa_tc6 *tc6 = bus->priv;
 	int mms;
 
-	mms = oa_tc6_get_phy_c45_mms(devnum);
+	mms = oa_tc6_get_phy_c45_mms(tc6, devnum);
 	if (mms < 0)
 		return mms;
 
@@ -1658,6 +1672,7 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 	SET_NETDEV_DEV(netdev, &spi->dev);
 	mutex_init(&tc6->spi_ctrl_lock);
 	spin_lock_init(&tc6->tx_skb_lock);
+	tc6->vend1_mms = -EOPNOTSUPP;
 	tc6->ttsc_current_id = OA_TC6_TTSCA_REG_ID;
 	INIT_LIST_HEAD(&tc6->tx_ts_skb_q);
 
diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
index a4d269cd685f..3bb41873773f 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
@@ -140,6 +140,7 @@ struct oa_tc6 {
 	u64 tx_hwtstamp_err;
 	u8 ts_ttsc_pending;
 	u8 ttsc_current_id;
+	int vend1_mms;
 };
 
 enum oa_tc6_header_type {
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index adfa83cd92ee..15d62e1b87a2 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -114,5 +114,6 @@ void oa_tc6_get_ts_stats(struct oa_tc6 *tc6,
 			 struct ethtool_ts_stats *stats);
 int oa_tc6_hwtstamp_set(struct oa_tc6 *tc6,
 			struct kernel_hwtstamp_config *cfg);
+void oa_tc6_set_vend1_mms(struct oa_tc6 *tc6, int mms);
 void oa_tc6_ptp_unregister(struct oa_tc6 *tc6);
 #endif /* _LINUX_OA_TC6_H */

-- 
2.43.0


