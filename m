Received: from out-zbxj-a71.jellyfish.systems (out-zbxj-a71.jellyfish.systems [198.54.127.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A195441DEE1
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 22:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485730; cv=none; b=nt7sLKLmgYBQBOIPdzUt+YzrIaoOLyU20jWFaybPeHDkB9ZeXuqg79KppYGAR9K9mzXpv6Ju36DT841q1D09dlhNuBB3m2sq3vY7P0+g12D/XpiZq9FpOfn0YXGoYOy9BT+d2+JraNdVV1jnVLq1lwAzo00HUD0rKP3VqIUKvck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485730; c=relaxed/simple;
	bh=rFuMfLFJVq/3ks2toWLWtGVVcTS1sq3q1RxvpflL70g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqJA8qU/7MdyAMl2y+tqFgYg3HGCma9ALFFdUkk/5PHSKz4Pf2gGFHTKj/wmw3belCXyjX7JYWUrmRAPFwAXoK2tZJ/xAwQc2cvhynifzQvOPFb1Tz7P3qT9/OhHaEGLrxf80OoVnsRkrGjBnwwIKM7hzx3HQwG/PBBDO6TMrkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hKQZN2H6tz8sWP;
	Tue, 11 Aug 2026 22:01:48 +0000 (UTC)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH v5 1/6] nfc: s3fwrn5: drop of_match_ptr() from the I2C driver
Date: Wed, 12 Aug 2026 00:01:30 +0200
Message-ID: <20260811220135.472380-2-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811220135.472380-1-jorijnvdgraaf@catcrafts.net>
References: <20260811220135.472380-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

Since commit 777fd2dab446 ("nfc: Drop __maybe_unused from of_device_id
tables") the OF match table relies on its MODULE_DEVICE_TABLE()
reference to count as used, while of_match_ptr() still discards the
.of_match_table reference on !CONFIG_OF builds. Drop of_match_ptr() so
every configuration uses the same code; the S3NRN4V support added later
in this series carries its variant selector in this table's match data.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Assisted-by: Claude:claude-fable-5
Assisted-by: Claude:claude-opus-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
The Reviewed-by was collected on v4; the referenced commit id was
refreshed for the rebased for-next (same commit).

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
-- 
2.55.0

