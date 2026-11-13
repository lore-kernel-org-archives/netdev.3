Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589173;
	b=2ucaX1kmsczstiFRsuNO8wRcLEpcPHos3Ft6PfTjmLKptrhhdv51Z/VgBiTrfPRZBkfp
	 H49Od06cYkisVpFTygq7Zlvwr14+szxc6V7HEM26MxAL6sHQeWjlnOSW27eevIA0+epTk
	 mXZJTKBbGUbNZK1rh2rOXk/NjGKGr+vSdnAzTH6uVaEdLlv3leTndv1GCzlSJr4redQxw
	 ZO7oofpPggwWLE3R4kMlvHoA04H7mScrwClRclT3/5bYcZpfPerLhRnV3bjTBIxKdNhCq
	 ms866ryf46iV1YzKmbGp41Itm26uRJYJxVRBgBrl7kOHhili+fXhYjSed0QIAdbMEwQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589173;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UROUaPQ6/0XkamJwNrv47DvvPmOfp1Hh9nRo7HeWd1k=;
	b=BqkPiYlkshfEBS16NYyfHayF35UOuMjEYCDox7kBBfJ6uDkXqK+LeZY/2ILwUX3rEkAY
	 Pc4FJWmbFLTHDpIdysWgjQ1qeAZUorQM+l75fzjKwoFB9q9toRgftPSvALqenwSTRgaLT
	 voe7fabA+P5qGZoB+I14VaODyKp0BE49JFLW7PUxLX2JOsiLs3vOmKBuFuN8yUHXea8nQ
	 kaaKvHeshUEju4lq9TNq8kFjOX5WqWzpDFuMiZ7yEfNioJofcXuwpHVju9LkExpxytH68
	 jFn469CsG5UA6MYWRD30uKipG9AXGiTKwKtadk/DiUO+NJBmeT+x3mOKSKoGKl4ZASQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlUlum+h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C57C606A8B7;
	Fri, 13 Nov 2026 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TlUlum+h
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589173;
	b=SBNvX93GDCqznOUsxkyMaqzEb1kEBVVDiXv0uAnSKRTuCGIl5y91VNIfsJiYSq4TafzK
	 tTrVUkTboc4VC+Ojo266Z5FtWiimQTseKDtaWjskEhtiC1ae0YBDwLsMOOqFxJIRGOdpF
	 u7HdV4eGAWMZ0Ilk3hi8WFLvwVAHnCa0swzB/GJBtqEc2gSjXeFkoVMCgk8HKdPcy2CVN
	 U4Bxrd0/ruVXpyShjKPNdKZPxxsPR7LdMgwnScT48EFUM7sXQDNb9PA81FFdIyUCZDJAl
	 9kaAFxIR7wBEySn9Z3fqIsvsA4jQXW9ZZQjLfzmKy3Qa96c+8GARVixv+Yp7u8OcWXA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589173;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=UROUaPQ6/0XkamJwNrv47DvvPmOfp1Hh9nRo7HeWd1k=;
	b=cnoYHS0ay8EJZl7I4H3PbKJwb8EqwlP68nyAwcjcRwDL2W3mxA4ShL6wo26NVIcujaeZ
	 Q9rgcBKsio6RAHiBqRo1LXo7f96Cx23ktAF6vBl7zAvb5FVJmmnP9IJi0HEOaOs70olzk
	 P02V9nO+Uar89/c/KtZ5rkQ0QVyVjakRdewWWTFrihl6htm5rd0Z9HtZiEFVP3mm5hCth
	 1d4LJNggt4/oleB2J3UwxKw9kUe0o1aqCpM2gDyFE56exqq63s1UaJU5BIZqniyJsvZ2B
	 wV+HFj5ZGNt5O9DqkdqwLrjAXhOsRdgOrvTaJ4IETuLR68KkX6fw9oSicnOaWPtROBA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BDCAE1F000C8;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589173;
	bh=UROUaPQ6/0XkamJwNrv47DvvPmOfp1Hh9nRo7HeWd1k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TlUlum+hi69h4mv7zNYrysNdDMgEDQEDAsb867Ym9TsXtiXzB0mYY3sBzGlC3i3ln
	 XJ7XKZwRfcFPhU/aaGWbgGMqWJuEAdzHG3tELKVZSK+PJDdrtzZ2S5LWy0fgaPH9DL
	 I74bKC6Fc3xqFV3l5n6EH29EUBroc9UGN9z6lNZubav4tyzbJYTEyYR9ATYxG97kiu
	 6whKImiE80FprrT5zxUA6aN+y7emXPq3x0aEhHFwKnjBen5v+a1TalL9Y3DRsPHpzf
	 m+hynj4DY4tSs1w8hxMlvhUJZazwtaWwHGQ3vTIVwRm3fRV1imbjt9x7gqnk7kDnY7
	 RuvXDRIVF+Xyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 45BEE49A1B;
	Fri, 13 Nov 2026 16:59:29 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 13 Nov 2026 08:59:23 -0800
Subject: [PATCH net-next v11 04/14] net: ethernet: oa_tc6: Move constant
 definitions to header file
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
Message-Id: <20261113-s2500-mac-phy-support-v11-4-7a186141952c@onsemi.com>
References: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
In-Reply-To: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=9475;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=fzye6JMC/7MohkHqYviCT3+QuVAqSqwKD1htmTY4JR4=;
 b=hT2q9Gkq3Zb6pefm+CLfPq6LlTfX56M0om23ZjEutd3+wSAGKIkaWHrPcEeS5PHOq83fCDDnI
 dZ5g16//w/GDN+X02jtRAnl0j2feMCyVDaE71gzoW1uRw2WqUbF/5b0
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 8bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

To help other source files within the module share the
constant definitions, some of the definitions from
oa_tc6_main.c are moved to a header file. This header file
is still private to OA TC6 framework.

oa_tc6 structure is also moved to this header file as it is
needed for other source files that are part of OA TC6
framework.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v11
  - Removed the reference to oa_tc6.c in commit message. It is
    oa_tc6_main.c now.
changes in v10
  - No change
changes in v9
  - Added Reviewed tag
changes in v8:
  - Merged with latest base version's changes
  - Added Reviewed tag
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - No change
changes in v4
  - Added MMS values 1 and 12, which are used now
changes in v3
  - Moved constant definitions from the source to newly created
    header file for other sources in the directory to share.
  - Standard specific defines are moved to Linux common header file
  - First patch
---
 drivers/net/ethernet/oa_tc6/oa_tc6_main.c    | 107 +----------------------
 drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h | 125 +++++++++++++++++++++++++++
 2 files changed, 127 insertions(+), 105 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
index 8e86cfde6d1c..341d13c97f91 100644
--- a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
@@ -12,111 +12,8 @@
 #include <linux/interrupt.h>
 #include <linux/mdio.h>
 #include <linux/phy.h>
-#include <linux/oa_tc6.h>
-
-/* Control command header */
-#define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
-#define OA_TC6_CTRL_HEADER_WRITE_NOT_READ	BIT(29)
-#define OA_TC6_CTRL_HEADER_MEM_MAP_SELECTOR	GENMASK(27, 24)
-#define OA_TC6_CTRL_HEADER_ADDR			GENMASK(23, 8)
-#define OA_TC6_CTRL_HEADER_LENGTH		GENMASK(7, 1)
-#define OA_TC6_CTRL_HEADER_PARITY		BIT(0)
-
-/* Data header */
-#define OA_TC6_DATA_HEADER_DATA_NOT_CTRL	BIT(31)
-#define OA_TC6_DATA_HEADER_DATA_VALID		BIT(21)
-#define OA_TC6_DATA_HEADER_START_VALID		BIT(20)
-#define OA_TC6_DATA_HEADER_START_WORD_OFFSET	GENMASK(19, 16)
-#define OA_TC6_DATA_HEADER_END_VALID		BIT(14)
-#define OA_TC6_DATA_HEADER_END_BYTE_OFFSET	GENMASK(13, 8)
-#define OA_TC6_DATA_HEADER_PARITY		BIT(0)
-
-/* Data footer */
-#define OA_TC6_DATA_FOOTER_EXTENDED_STS		BIT(31)
-#define OA_TC6_DATA_FOOTER_RXD_HEADER_BAD	BIT(30)
-#define OA_TC6_DATA_FOOTER_CONFIG_SYNC		BIT(29)
-#define OA_TC6_DATA_FOOTER_RX_CHUNKS		GENMASK(28, 24)
-#define OA_TC6_DATA_FOOTER_DATA_VALID		BIT(21)
-#define OA_TC6_DATA_FOOTER_START_VALID		BIT(20)
-#define OA_TC6_DATA_FOOTER_START_WORD_OFFSET	GENMASK(19, 16)
-#define OA_TC6_DATA_FOOTER_END_VALID		BIT(14)
-#define OA_TC6_DATA_FOOTER_END_BYTE_OFFSET	GENMASK(13, 8)
-#define OA_TC6_DATA_FOOTER_TX_CREDITS		GENMASK(5, 1)
-
-#define OA_TC6_CTRL_PROT_REPLY_SIZE		4
-#define OA_TC6_CTRL_HEADER_SIZE			4
-#define OA_TC6_CTRL_REG_VALUE_SIZE		4
-#define OA_TC6_CTRL_IGNORED_SIZE		4
-#define OA_TC6_CTRL_MAX_REGISTERS		128
-#define OA_TC6_CTRL_SPI_BUF_SIZE	(OA_TC6_CTRL_HEADER_SIZE +\
-					(OA_TC6_CTRL_MAX_REGISTERS *\
-					(OA_TC6_CTRL_REG_VALUE_SIZE +\
-					OA_TC6_CTRL_PROT_REPLY_SIZE)) +\
-					OA_TC6_CTRL_IGNORED_SIZE)
-
-#define OA_TC6_CHUNK_PAYLOAD_SIZE		64
-#define OA_TC6_DATA_HEADER_SIZE			4
-#define OA_TC6_CHUNK_SIZE			(OA_TC6_DATA_HEADER_SIZE +\
-						OA_TC6_CHUNK_PAYLOAD_SIZE)
-#define OA_TC6_MAX_TX_CHUNKS			48
-#define OA_TC6_SPI_DATA_BUF_SIZE		(OA_TC6_MAX_TX_CHUNKS *\
-						OA_TC6_CHUNK_SIZE)
-#define STATUS0_RESETC_POLL_DELAY		1000
-#define STATUS0_RESETC_POLL_TIMEOUT		1000000
-
-#define OA_TC6_REG_MMS_MASK		GENMASK(19, 16)
-
-/* Internal structure for MAC-PHY drivers */
-struct oa_tc6 {
-	struct net_device *netdev;
-	struct phy_device *phydev;
-	struct mii_bus *mdiobus;
-	struct spi_device *spi;
-	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
-	spinlock_t tx_skb_lock; /* Protects tx skb handling */
-	void *spi_ctrl_tx_buf;
-	void *spi_ctrl_rx_buf;
-	void *spi_data_tx_buf;
-	void *spi_data_rx_buf;
-	struct sk_buff *ongoing_tx_skb;
-	struct sk_buff *waiting_tx_skb;
-	struct sk_buff *rx_skb;
-	u16 tx_skb_offset;
-	u16 spi_data_tx_buf_offset;
-	u16 tx_credits;
-	u8 rx_chunks_available;
-	bool wait_until_start_valid;
-	bool int_flag;
-	bool disable_traffic;
-	bool prot_ctrl;
-	enum oa_tc6_quirk_flag quirk_flags;
-	struct gpio_desc *reset_gpio;
-};
-
-enum oa_tc6_header_type {
-	OA_TC6_CTRL_HEADER,
-	OA_TC6_DATA_HEADER,
-};
-
-enum oa_tc6_register_op {
-	OA_TC6_CTRL_REG_READ = 0,
-	OA_TC6_CTRL_REG_WRITE = 1,
-};
-
-enum oa_tc6_data_valid_info {
-	OA_TC6_DATA_INVALID,
-	OA_TC6_DATA_VALID,
-};
-
-enum oa_tc6_data_start_valid_info {
-	OA_TC6_DATA_START_INVALID,
-	OA_TC6_DATA_START_VALID,
-};
-
-enum oa_tc6_data_end_valid_info {
-	OA_TC6_DATA_END_INVALID,
-	OA_TC6_DATA_END_VALID,
-};
+
+#include "oa_tc6_std_def.h"
 
 static int oa_tc6_spi_transfer(struct oa_tc6 *tc6,
 			       enum oa_tc6_header_type header_type, u16 length)
diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
new file mode 100644
index 000000000000..c2c120ddcc07
--- /dev/null
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Register and driver related definitions to support
+ * OPEN Alliance 10BASE‑T1x MAC‑PHY Serial Interface framework.
+ *
+ * Author: Selva Rajagopal <selvamani.rajagopal@onsemi.com>
+ */
+
+#ifndef OA_TC6_STD_DEF_H
+#define OA_TC6_STD_DEF_H
+
+#include <linux/bits.h>
+#include <linux/ptp_clock_kernel.h>
+#include <linux/net_tstamp.h>
+#include <linux/netdevice.h>
+#include <linux/spi/spi.h>
+#include <linux/skbuff.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/oa_tc6.h>
+
+/* Control command header */
+#define OA_TC6_CTRL_HEADER_DATA_NOT_CTRL	BIT(31)
+#define OA_TC6_CTRL_HEADER_WRITE_NOT_READ	BIT(29)
+#define OA_TC6_CTRL_HEADER_MEM_MAP_SELECTOR	GENMASK(27, 24)
+#define OA_TC6_CTRL_HEADER_ADDR			GENMASK(23, 8)
+#define OA_TC6_CTRL_HEADER_LENGTH		GENMASK(7, 1)
+#define OA_TC6_CTRL_HEADER_PARITY		BIT(0)
+
+/* Data header */
+#define OA_TC6_DATA_HEADER_DATA_NOT_CTRL	BIT(31)
+#define OA_TC6_DATA_HEADER_DATA_VALID		BIT(21)
+#define OA_TC6_DATA_HEADER_START_VALID		BIT(20)
+#define OA_TC6_DATA_HEADER_START_WORD_OFFSET	GENMASK(19, 16)
+#define OA_TC6_DATA_HEADER_END_VALID		BIT(14)
+#define OA_TC6_DATA_HEADER_END_BYTE_OFFSET	GENMASK(13, 8)
+#define OA_TC6_DATA_HEADER_PARITY		BIT(0)
+
+/* Data footer */
+#define OA_TC6_DATA_FOOTER_EXTENDED_STS		BIT(31)
+#define OA_TC6_DATA_FOOTER_RXD_HEADER_BAD	BIT(30)
+#define OA_TC6_DATA_FOOTER_CONFIG_SYNC		BIT(29)
+#define OA_TC6_DATA_FOOTER_RX_CHUNKS		GENMASK(28, 24)
+#define OA_TC6_DATA_FOOTER_DATA_VALID		BIT(21)
+#define OA_TC6_DATA_FOOTER_START_VALID		BIT(20)
+#define OA_TC6_DATA_FOOTER_START_WORD_OFFSET	GENMASK(19, 16)
+#define OA_TC6_DATA_FOOTER_END_VALID		BIT(14)
+#define OA_TC6_DATA_FOOTER_END_BYTE_OFFSET	GENMASK(13, 8)
+#define OA_TC6_DATA_FOOTER_TX_CREDITS		GENMASK(5, 1)
+
+#define OA_TC6_CTRL_PROT_REPLY_SIZE		4
+#define OA_TC6_CTRL_HEADER_SIZE			4
+#define OA_TC6_CTRL_REG_VALUE_SIZE		4
+#define OA_TC6_CTRL_IGNORED_SIZE		4
+#define OA_TC6_CTRL_MAX_REGISTERS		128
+#define OA_TC6_CTRL_SPI_BUF_SIZE	(OA_TC6_CTRL_HEADER_SIZE +\
+					(OA_TC6_CTRL_MAX_REGISTERS *\
+					(OA_TC6_CTRL_REG_VALUE_SIZE +\
+					OA_TC6_CTRL_PROT_REPLY_SIZE)) +\
+					OA_TC6_CTRL_IGNORED_SIZE)
+
+#define OA_TC6_CHUNK_PAYLOAD_SIZE		64
+#define OA_TC6_DATA_HEADER_SIZE			4
+#define OA_TC6_CHUNK_SIZE			(OA_TC6_DATA_HEADER_SIZE +\
+						OA_TC6_CHUNK_PAYLOAD_SIZE)
+#define OA_TC6_MAX_TX_CHUNKS			48
+#define OA_TC6_SPI_DATA_BUF_SIZE		(OA_TC6_MAX_TX_CHUNKS *\
+						OA_TC6_CHUNK_SIZE)
+#define STATUS0_RESETC_POLL_DELAY		1000
+#define STATUS0_RESETC_POLL_TIMEOUT		1000000
+
+#define OA_TC6_REG_MMS_MASK		GENMASK(19, 16)
+
+/* Internal structure for MAC-PHY drivers */
+struct oa_tc6 {
+	struct net_device *netdev;
+	struct phy_device *phydev;
+	struct mii_bus *mdiobus;
+	struct spi_device *spi;
+	struct mutex spi_ctrl_lock; /* Protects spi control transfer */
+	spinlock_t tx_skb_lock; /* Protects tx skb handling */
+	void *spi_ctrl_tx_buf;
+	void *spi_ctrl_rx_buf;
+	void *spi_data_tx_buf;
+	void *spi_data_rx_buf;
+	struct sk_buff *ongoing_tx_skb;
+	struct sk_buff *waiting_tx_skb;
+	struct sk_buff *rx_skb;
+	u16 tx_skb_offset;
+	u16 spi_data_tx_buf_offset;
+	u16 tx_credits;
+	u8 rx_chunks_available;
+	bool wait_until_start_valid;
+	bool int_flag;
+	bool disable_traffic;
+	bool prot_ctrl;
+	enum oa_tc6_quirk_flag quirk_flags;
+	struct gpio_desc *reset_gpio;
+};
+
+enum oa_tc6_header_type {
+	OA_TC6_CTRL_HEADER,
+	OA_TC6_DATA_HEADER,
+};
+
+enum oa_tc6_register_op {
+	OA_TC6_CTRL_REG_READ = 0,
+	OA_TC6_CTRL_REG_WRITE = 1,
+};
+
+enum oa_tc6_data_valid_info {
+	OA_TC6_DATA_INVALID,
+	OA_TC6_DATA_VALID,
+};
+
+enum oa_tc6_data_start_valid_info {
+	OA_TC6_DATA_START_INVALID,
+	OA_TC6_DATA_START_VALID,
+};
+
+enum oa_tc6_data_end_valid_info {
+	OA_TC6_DATA_END_INVALID,
+	OA_TC6_DATA_END_VALID,
+};
+#endif /* OA_TC6_STD_DEF_H */

-- 
2.43.0


