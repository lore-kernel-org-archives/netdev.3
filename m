Received: from out-93wp-a46.jellyfish.systems (out-93wp-a46.jellyfish.systems [104.207.68.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B923B71B1
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068690; cv=none; b=hIFSbSg9gj94iowZ4XMPGjuJWu/3Xgqq5mKLk0BmNWAE7Nup+ZIpYYGFFx97y525xgcd2Or2Jcfc2a5Z6Wh3+6KWxewd+UHzDcA9MpTfqHqXI8dWDjmcQbrF3iFG4dtrQy9DmIXgtachMrFo5XX5AYy2c8QdL5UNTg5hNpDMBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068690; c=relaxed/simple;
	bh=xd8jnbxtdr8XMZUAzjIlTKjSpbI8jthavSrKjrSwRA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKZApLb4mWP+1UBDbouy6z3m3J/SLxy+AF5hezanmgPquhtcI45KacRiWpj+5o6k3ZtZQHc0eUHn5qF4y1eXrYBOb2PzjgpWfnLBQRqAQiol3sT734Xa2FaFLJ9yep7xb9LAJXWzIGFPyHSVWVTM4iBSKFs6ZvIq0oet1d1d11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=104.207.68.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hGSLH0wwMz2x9B;
	Fri, 07 Aug 2026 02:11:02 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH v4 4/6] nfc: s3fwrn5: enable the PVDD supply
Date: Fri,  7 Aug 2026 04:09:59 +0200
Message-ID: <20260807021001.239389-5-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807021001.239389-1-jorijnvdgraaf@catcrafts.net>
References: <20260807021001.239389-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

The controller is powered by an externally switched PVDD rail. Get and
enable it in the i2c phy probe, before any of the chip's pins is driven
or its clock started, so the chip's power does not depend on whatever
state the bootloader or platform left the rail in. Boards that do not
describe the supply resolve to a dummy regulator, so the existing users
keep working; they gain the regulator core's dummy-supply warning until
their DTs describe the rail.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 drivers/nfc/s3fwrn5/i2c.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index c528c085b43e..f93d8b47b65e 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 
 #include <net/nfc/nfc.h>
 
@@ -158,6 +159,11 @@ static int s3fwrn5_i2c_probe(struct i2c_client *client)
 	phy->i2c_dev = client;
 	i2c_set_clientdata(client, phy);
 
+	ret = devm_regulator_get_enable(&client->dev, "pvdd");
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to enable pvdd\n");
+
 	phy->common.gpio_en = devm_gpiod_get(&client->dev, "en", GPIOD_OUT_HIGH);
 	if (IS_ERR(phy->common.gpio_en))
 		return PTR_ERR(phy->common.gpio_en);
-- 
2.55.0

