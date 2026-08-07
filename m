Received: from out-2z4y-a162.jellyfish.systems (out-2z4y-a162.jellyfish.systems [198.54.127.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F873B3C1F
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 02:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786068670; cv=none; b=CfvKiItCuzvNPyWe6M8dyRSNzGUNWfdLOh3eomi+UbPvoYSGoczM0qtAniNGhs1D6u9af/cAJbbRgSz06xtYsYNtsxiqNxsLrEx9CyShw2gbQXQ8bH3fo2GVuvZhv18zOFRZyQbt/IVNw9yfZtVzBoAMxwDADXVoKtetbpR9Q0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786068670; c=relaxed/simple;
	bh=p+SS7vZxOAXOrGGtNcEayjNQLffbukPNwaC7Z8qdp9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXsBhLFOI1mib7lAwH5u4kgrAdHULlMsbU7Vu7bb4RWeI0sbZrxnT6AJZ5RHIPLeNNKtqisRvtcFJzmxzjzPadySs70/8RA9ztblbHf1jOOXsDEUTwF3/JoT9eLpWfRp6ioP8xKmQEpc30fc8pVS/M3flKjaoy8QkdkH7Hyzp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hGSL536HVz2x9C;
	Fri, 07 Aug 2026 02:10:53 +0000 (UTC)
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
Subject: [PATCH v4 2/6] nfc: s3fwrn5: use the "s3fwrn5_i2c" string literal directly
Date: Fri,  7 Aug 2026 04:09:57 +0200
Message-ID: <20260807021001.239389-3-jorijnvdgraaf@catcrafts.net>
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

The S3FWRN5_I2C_DRIVER_NAME define is an indirection for a string that
is fixed ABI (the driver name) and only used within this file. Spell
the string out at its three users and drop the define.

Suggested-by: David Heidelberg <david@ixit.cz>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 drivers/nfc/s3fwrn5/i2c.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index cb73993446e0..c528c085b43e 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -16,8 +16,6 @@
 
 #include "phy_common.h"
 
-#define S3FWRN5_I2C_DRIVER_NAME "s3fwrn5_i2c"
-
 struct s3fwrn5_i2c_phy {
 	struct phy_common common;
 	struct i2c_client *i2c_dev;
@@ -186,7 +184,7 @@ static int s3fwrn5_i2c_probe(struct i2c_client *client)
 
 	ret = devm_request_threaded_irq(&client->dev, phy->i2c_dev->irq, NULL,
 		s3fwrn5_i2c_irq_thread_fn, IRQF_ONESHOT,
-		S3FWRN5_I2C_DRIVER_NAME, phy);
+		"s3fwrn5_i2c", phy);
 	if (ret)
 		goto s3fwrn5_remove;
 
@@ -205,7 +203,7 @@ static void s3fwrn5_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id s3fwrn5_i2c_id_table[] = {
-	{ .name = S3FWRN5_I2C_DRIVER_NAME },
+	{ .name = "s3fwrn5_i2c" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, s3fwrn5_i2c_id_table);
@@ -218,7 +216,7 @@ MODULE_DEVICE_TABLE(of, of_s3fwrn5_i2c_match);
 
 static struct i2c_driver s3fwrn5_i2c_driver = {
 	.driver = {
-		.name = S3FWRN5_I2C_DRIVER_NAME,
+		.name = "s3fwrn5_i2c",
 		.of_match_table = of_s3fwrn5_i2c_match,
 	},
 	.probe = s3fwrn5_i2c_probe,
-- 
2.55.0

