Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794007138;
	b=aGvaF0ikP65+y+2gac2RLwKYQsindsgMepgg3GVa5025VinBG+SnGDSkoyMblNYb/nvI
	 VGni7aC+CjdrGqS3ofqkU1c0XbrZGIz4fc4DFWy9rVAabV4htDKoUME1tcQE/iNnNq/su
	 DwDeZ6vH+Nx1IXadvx3VjP8MgAjpZ2sW0IUGshyrjKC7KEOM087dgtK90Q0cBluaZotFY
	 /wH8xZ9uv0SnB/aJv/GkbQQDKSMm8ASXH+9UcVAxuJOk5pM3k3WtaJ2W+7E/UoNmF+5VD
	 pMyUOU1hvRJFIQn+gXoVYla9v4sS+6Zbofcc1pbBQSz+48izuAAYXanMV/zRwFnMPjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007138;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mDtf9qqbkjNlPE1p1iX5YWDUz9mYrvYvbNBNF1x6N/M=;
	b=Oxzv7SBROMbzSia+V7zkmDI81xBfC8sdNZCgGHn2QQxW7fPdJHiYXtFtgEBUCjqq1cL5
	 2UMSed44a8xKJLAyTBpVl1ErhTmhtiVmDAeJuD2ceMVJrww069AkbeFJp92GGdue77748
	 WmLCY2xSHmV4MhrPPvFH3g9FMN6ClCg/gj8Ni0XjvqGMNX8UgKE6/+J31eLXac7EbDoGm
	 uqW6ICqoysvAFqKXKi3j9eYqZCdFmFmBFFijjJYBbkDwbj7fLPQRuvi1yU0V/138pcQuX
	 c4oJhFWEUle9NgLtaHt/jP5f1Gsr+J8KWHiWT5baf6Vjl2oL72GO6Eg/V5zplK65r/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGVNGfs6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADD7606D805;
	Fri,  6 Nov 2026 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGVNGfs6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794007138;
	b=smltsMxNNI0yUuJ4ijmMgPbNR//IWxGOD/phuxTtgQCAlD5iUITBN+fFX57GGeDsckjv
	 xCyRXDvBcjE4dOSTnFIE+F283pF1j0TB1SmwTdtD0GHiIMTKKZ3/UTzXKAbE0Dvm2IKNF
	 sx1NwAe3WinO2tyD0GFw+THs32GoqSRAGtLvFNzqiGGLq57IfareRVP2hd7K/9Fe9lPj9
	 2CKx6Hd9VlguyKwCYYn6jDmYh81wFMWfl6eMh7p3S+NLSCVFDm8OYe+wQUNiX6Mf0zfXa
	 QAZkSwQFNAMbuVtukmf9ryHoRMxbmvA2oiPM8HfuY3O0ULe154BFpno4QlNN/PzI3Dg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794007138;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mDtf9qqbkjNlPE1p1iX5YWDUz9mYrvYvbNBNF1x6N/M=;
	b=YmheMDLx88tK6vaARlBemzWj0pwD2ta/g2TCiUudXZEfHPMkoRvk2PbZffU1CcMVc12+
	 BBneu5ChERm6bGvlcoeArrX2iQ8Ub09mfUHsLr/4/6FNR8OecFCBmnw+ThD0Ogb2Te8L/
	 eKq6vjeuVpm7z8zUu+GUlyYNT+sWIO+8j0cYGOZFNB57AAtpNgx2lbHkyil1XSmR5yT2+
	 z8xPs1OlC3f3vKG2MfQb+hGunD37ex3WV70RAWoZ6hhkIZ69Cx+A8o33Co3OKAU5kj8c6
	 28rcmg3cRzRhHmaBhKZ+ERnHlCWGmiuGZD/4igFHE+/ObbL7QO1duYnpxiUIpZHzlbQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 88FD21F008A6;
	Fri,  6 Nov 2026 23:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794007138;
	bh=mDtf9qqbkjNlPE1p1iX5YWDUz9mYrvYvbNBNF1x6N/M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BGVNGfs6OzEvo2QGLkHDqlv6JTgE2iuGBF+rkFb9NpDDqUogJeQCMNBdpLOZjYIFu
	 X3ydybmQ9Xt6A24maECvvmD0NYEtQaTcDpkbhtfqp2dhmpkwRYdG5ifdfFs2cUe0iA
	 MpXjBK0ULFEJUfKlnrzyTXA1OeKtNL1vqKvQc0k3EjyQmnkDlxQWSU4lmXvS1gKw1f
	 ljLInX4/vTmE1SnTY+rRBCtasYI7PswAT7XJQ3a1SKxo+dhRmTX0ZwBV7rpRGOobtS
	 fJ5yKXr8gTsKtAn26jIuvnaxncblYr3GimyzQj/v2dadeX4Bns17u1MFM1pV3FlZ4V
	 +1B7Czi13j2vg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 144EE478E8;
	Fri,  6 Nov 2026 23:18:55 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 06 Nov 2026 15:18:50 -0800
Subject: [PATCH net-next v10 04/11] net: ethernet: oa_tc6: Move constant
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
Message-Id: <20261106-s2500-mac-phy-support-v10-4-31b5a69b85b7@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794007133; l=9369;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=KBMW5itlM24uP6FazAU2dbfoVgeA/7Vwd8XxNt7I/TM=;
 b=pjGvBJ3jGye+P6HdQX6I40+2WVh/Cz6GavJvCeyWzDl82h3G9gq3j4nxPdSgegVI0QMb2W+Mh
 vpJu5KpIWmmAO2IXLtHXxSeb6CPiyJv0bRPkZVdz7L7Ui04B9oTF4kD
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 8bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

To help other source files within the module share the
constant definitions, some of the definitions from oa_tc6.c
are moved to a header file. This header file is still
private to OA TC6 framework.

oa_tc6 structure is also moved to this header file as it is
needed for other source files that are part of OA TC6
framework.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
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
 drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h | 126 +++++++++++++++++++++++++++
 2 files changed, 128 insertions(+), 105 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6/oa_tc6_main.c b/drivers/net/ethernet/oa_tc6/oa_tc6_main.c
index 364027c39fa4..45eb896cd986 100644
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
index 000000000000..c61672aa618c
--- /dev/null
+++ b/drivers/net/ethernet/oa_tc6/oa_tc6_std_def.h
@@ -0,0 +1,126 @@
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
+

-- 
2.43.0


