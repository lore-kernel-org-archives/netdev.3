Received: from MTA-15-3.privateemail.com (mta-15-3.privateemail.com [198.54.122.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F083DBD43;
	Sun, 26 Jul 2026 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785104696; cv=none; b=jKbgScYT33tkOulT+XCLrNOUSQXIwq5/eEsZkfLnjatYdCNvm3Iwi3gDIyz5e/xHCw5jowNoCRH0Os1RlnBzUozFU3AF9vepDHF1f3GioMBztTYR2qSDcrITzAk4pasdBjItq7y+6EYioWp+nNnYgj0cayjJ7K7B2vG0EUoVqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785104696; c=relaxed/simple;
	bh=4e31DzdvWvuiXa2ewgd3iMw3GuVU1HTPKjOPyYMyOno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPpIBtrmltqR1FDSz1UB+stwyLuELc66hCHqLp2HgEaM8G7LazZXjyYJklzsbfowz1MUJzBMSuv+uWq7uwxvrWSxa2Aa7pCyH8GddlYWgBiTT4YxssED/eTPEoD2b2qWDr29t42M/+iyRbPfxrONHyh/qGHc46we2UyNP5KUf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.122.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-10 [87.215.145.39])
	by mta-15.privateemail.com (Postfix) with ESMTPA id 4h7br13fhBz3hhTH;
	Sun, 26 Jul 2026 18:24:32 -0400 (EDT)
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
Subject: [PATCH v3 1/5] nfc: s3fwrn5: drop of_match_ptr() from the I2C driver
Date: Mon, 27 Jul 2026 00:24:01 +0200
Message-ID: <20260726222405.153008-2-jorijnvdgraaf@catcrafts.net>
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

Since commit 9739e07fdb29 ("nfc: Drop __maybe_unused from of_device_id
tables") the OF match table relies on its MODULE_DEVICE_TABLE()
reference to count as used, while of_match_ptr() still discards the
.of_match_table reference on !CONFIG_OF builds. Drop of_match_ptr() so
every configuration uses the same code; the S3NRN4V support added later
in this series carries its variant selector in this table's match data.

Assisted-by: Claude:claude-fable-5
Assisted-by: Claude:claude-opus-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 drivers/nfc/s3fwrn5/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index 4ba762611711..cb73993446e0 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -219,7 +219,7 @@ MODULE_DEVICE_TABLE(of, of_s3fwrn5_i2c_match);
 static struct i2c_driver s3fwrn5_i2c_driver = {
 	.driver = {
 		.name = S3FWRN5_I2C_DRIVER_NAME,
-		.of_match_table = of_match_ptr(of_s3fwrn5_i2c_match),
+		.of_match_table = of_s3fwrn5_i2c_match,
 	},
 	.probe = s3fwrn5_i2c_probe,
 	.remove = s3fwrn5_i2c_remove,

base-commit: f0054d864e6e734add71e29961f5ae15211ad24d
-- 
2.55.0

