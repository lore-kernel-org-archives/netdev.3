Received: from MTA-15-3.privateemail.com (mta-15-3.privateemail.com [198.54.122.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3D3DBD43;
	Sun, 26 Jul 2026 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785104719; cv=none; b=FV1modWcFXK4DUHMNre+m4Cbriib1YmQPK7ig/IdNeeOsLd2QHEXaFZCVTri+zZV95quzFSFeeBFLRoAs4eyGHIdv+nNT474cbyJDM8DWxOCCKlk6FGfvSW//1MWb4psBxKMOKP2VWbzs7wo2VC28madypa+FvrucK1HmtChIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785104719; c=relaxed/simple;
	bh=p+SS7vZxOAXOrGGtNcEayjNQLffbukPNwaC7Z8qdp9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhgzaMdfotZNR8ROUJinm4PV9WGwZMrC7U1/Mghw0nfedX9DcXERx59haaidb/gUCNIEx3xDmHf7q8rCcQiMdNVwQ/TipPSbBKPcQ7QTfUMTRzuYhEQDAd5kHwrfSFfvosZA+iQdIIuLn2zSlPLBbpfqxN+i1zUftCIDt1Rx9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.122.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-10 [87.215.145.39])
	by mta-15.privateemail.com (Postfix) with ESMTPA id 4h7brR2cPBz3hhTG;
	Sun, 26 Jul 2026 18:24:54 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] nfc: s3fwrn5: use the "s3fwrn5_i2c" string literal directly
Date: Mon, 27 Jul 2026 00:24:02 +0200
Message-ID: <20260726222405.153008-3-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726222405.153008-1-jorijnvdgraaf@catcrafts.net>
References: <20260726222405.153008-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

