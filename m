Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A103B19A9
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771803; cv=none; b=eItGO8Ov+gIufOGEinJ3yuY0j8b0b4HFAEU19+vKUGkivkk5TTgjEf6apdkgnlvbHt1TEgaX0yHN4RrEhoJCUciGA+AQQAeFYCPDCpTY9pqxPgAwOtzMY/GEf03ZgD75fL0OUmbg6sStyh72hh6MCULAhfkSP2dXkr2GQhxecY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771803; c=relaxed/simple;
	bh=LEyAaVhzvhSsgDRqQgbBUU5XfES+acdxhcOorykFmX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sk93Wvn6a6EFZRD7QMNyRS/PzMCraZNeUlFohAvtmgRwNC5Wt/5t1TTuL9Y/69x7+4AMXaYFqZEpNY1qGKE5cWFY5raWG0HlS0zPpv5tdWqJ4zJVsY6yZ6XC4Fo67RNFJrRsDDVdFdxK0m85wc5me9AFxJzdgddz2dF7Vw5kAsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=ZdBVv5Z3; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="ZdBVv5Z3"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026091822494797db88555400020796
        for <netdev@vger.kernel.org>;
        Sat, 19 Sep 2026 00:49:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=M9GFPJKsaPxZfCgvjZf9vaV2eAIMvLSEw19T5lmjtbI=;
 b=ZdBVv5Z3TSPLoqniqU7lOqQ1PXIngn/kA+huaCZP4SDicb7Gz0Of58tAUIQwjVzJlSD8Me
 HMkuroNZCa/ZE2siYkLGKXR7Hwit2tCZQcOI3XySR44zL5o3o9ueUmluClfTPDG3PitoGNEI
 oAe6tHWZ4qdZty9qsTWaPQZamtNdmaPRjgmPBApHPku4Sru6bjPZk1A7ARHEOfwK9yCMHU88
 D3enpZ8+jOLJYkF8RmWqyao1o/zILpm7PcGg5R0+7lZV5TLeSt+q9zXMLm07cUxf9nUwcmzP
 qyDzNTST3dYEl41/RmRUAWuLr/XI5Rgdwtc+YwmFl8T5eO39Bro2DnwQ==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ciprian Regus <ciprian.regus@analog.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH net-next v3 4/4] net: ethernet: oa_tc6: add reset-gpios support
Date: Sat, 19 Sep 2026 00:49:34 +0200
Message-ID: <20260918224934.51998-5-alessandro.zini@siemens.com>
In-Reply-To: <20260918224934.51998-1-alessandro.zini@siemens.com>
References: <20260918224934.51998-1-alessandro.zini@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1327013:519-21489:flowmailer

OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface specification
(v1.1, section 8.2) defines an external RESET pin as an optional reset
source for the MAC-PHY.

Add support for an optional reset GPIO in oa_tc6_init(). The GPIO is
requested asserted, kept asserted for 10 us and, once deasserted, 1 ms of
settle time is allowed for the crystal oscillator startup before the
initial TC6 control protection check and software reset are performed.

As the reset handling lives in the common library, it is available to both
users of oa_tc6_init(), the lan865x and the adin1140 driver.

Suggested-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
Changes in v3:
- Request the GPIO with GPIOD_OUT_HIGH and drop the now redundant
  gpiod_set_value_cansleep(..., 1) call, as suggested by Qingfang Deng.
- Return the error from dev_err_probe() so that -EPROBE_DEFER is
  propagated to the driver core.
- Reworded comment to stay within 80 columns.
- Sorted the new includes into the existing include block.

Changes in v2:
- Moved reset GPIO handling from lan865x.c to common oa_tc6.c as suggested
  by Parthiban Veerasooran.
 drivers/net/ethernet/oa_tc6.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 8c82bc8354ede..364027c39fa4a 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
 #include <linux/interrupt.h>
 #include <linux/mdio.h>
@@ -88,6 +90,7 @@ struct oa_tc6 {
 	bool disable_traffic;
 	bool prot_ctrl;
 	enum oa_tc6_quirk_flag quirk_flags;
+	struct gpio_desc *reset_gpio;
 };
 
 enum oa_tc6_header_type {
@@ -1504,6 +1507,22 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev,
 	if (!tc6->spi_data_rx_buf)
 		return ERR_PTR(-ENOMEM);
 
+	tc6->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
+						  GPIOD_OUT_HIGH);
+	if (IS_ERR(tc6->reset_gpio))
+		return ERR_PTR(dev_err_probe(&spi->dev,
+					     PTR_ERR(tc6->reset_gpio),
+					     "failed to get reset gpio\n"));
+
+	if (tc6->reset_gpio) {
+		/* Keep the reset asserted for 10 us and then allow 1 ms of
+		 * settle time for the crystal oscillator startup.
+		 */
+		fsleep(10);
+		gpiod_set_value_cansleep(tc6->reset_gpio, 0);
+		fsleep(1000);
+	}
+
 	/* Check the PROTE bit status so that we can reset the device */
 	ret = oa_tc6_check_ctrl_protection(tc6);
 	if (ret) {
-- 
2.55.0

