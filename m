Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794409669;
	b=w9IzQ5v1KPpAg1JQygNvjR7YUZjClreqy5R/9DiUZgAElHK+RoOq0k+TTANKt05tZ3PW
	 8w8NRkzPzPon5QAqka/3UyuglLO9W5xTD2NpbvdAVeQw4MCMfL46HebrSBo4rRGU/21vg
	 c+wFM4p/NdlUFzrVodC/0+6qUtwAxYN5FFfYGIHedQlwHwaVxjWxfI4ahogw0d4AjhUxC
	 U8uJPgELjKEGi4m2e6CXHhKqFWYYLnNupIOw8IAcsj4vYYwV/vuKwezb+M4+aLiaX609f
	 cp0nEVGx3FCxk4lYM/iifa6qSoMFET8YVM0Iy6zqplN3tKKRCYrZmcO9bw6GunuUBGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409669;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=V5dkWnZ6OPg7h816OKB2FNUn385i/2AP4xWWSltjHUM=;
	b=wflsyVLA9xKHB7z2ixjGe7p2HobWZ0+7zTVFm/CuCkHAYpiN0XNts7prxkjD6KcLhZ/p
	 JzLAFvWK8Em+GGm1mGboUoy2NfMoBe99aocmoTc7ZenEMHoUi5HERNjWpk5mTMHn0F7l/
	 Pg+PDf45c5V9GQ4qumFAtPemN7M9Tft3Dl3DqD3czVbz0rIuMrtDg3N9t0/UVYfUFhR3a
	 gPMF0sEmOgUYc+Cyv4tj+NDAkkUI4G+fhSfb7HuyWPPElwjokqAxh4U6GjCz+wUbLen88
	 OPU/thZEo8UfxzLKSQoJiCXLzI8PHWVh0IjYGL6HzI7zNxN26nruVe2MTmQC/rvzvFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtbXsHEf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B475E60A261A;
	Wed, 11 Nov 2026 15:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtbXsHEf
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794409669;
	b=usRprD11TabdGvL59RdLj07ZoPDLt09/DXjxhyW/Ov5yGvNqlosy4tzuay5LBlBpS9fK
	 g9iCn9u3hT1AaiNK6FVO9bsHWwgHBxTGVLJa8xiXNEZlnC+inHA4sx3CUD3BqRigkddj0
	 UzprMBef9ZUtsRuhfG9/gSxMCnCopK4RWd1T4SZKQPcUuGj0ZQo93tgsWxcRnziNFd56W
	 gzah3r/0hp9BFldP2FXmlOlx3t7xyzvRYzZSgsU49a9lNwGtfoC3sihiiao86XqagXUc3
	 52R4zxNm/g0v9+A9IETDBL2NGso7B6zmvS0gexd/E75d8PuhCNyI0El0L01OBqLAiYQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794409669;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=V5dkWnZ6OPg7h816OKB2FNUn385i/2AP4xWWSltjHUM=;
	b=FVAirqURi6hWsJUjnRLBeGowxW8FI5gVfifIsq0qqptLizq8Mv6slxO+4UNEuQCD9989
	 pbKQdo5IS3mNmwOwtPY5mkoh1qGxJnY5iuWEwIHXlTwuqKB5iB3TCkDItWeBoOCfJAt8W
	 MqXCOon/y/1QDnDq0AMdmXCFQy5C0+Z9RctIF7fHIFmeco5qjbi57RpuTk/yVD492J0bL
	 4KRQE9oTo7o8lmw1zltu81/QrudFx//EbpUMrkttrfj6KaUnfdWtZqy3n/EGOoR6VOsOg
	 KcxuUIFpFC9eOeJgkJ+a9j4fZRBovrBi84Yv0amjAWNGN1NALhUdCERMqfbWGbBnLsw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E3B711F00A08;
	Wed, 11 Nov 2026 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409669;
	bh=V5dkWnZ6OPg7h816OKB2FNUn385i/2AP4xWWSltjHUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=TtbXsHEf9V3QTOxrihLbV+PCyj4/jkNYnBKWF7yKCI8n9L+wJO9VbPr9BlldsZcwZ
	 RA/JP6ICN3Hq0edRFudjSOGcOCkGHxzVC6fJALoPdTjQ/Ifu6feklI/jmie4+HUYmq
	 EA9e0HCAplY/8ZK/ypT65BkoLgKLzzKiP2BImYY4rqR20MmAZI0p9kgtm6aiR3d6hY
	 E9q3QDvrglEejxRMXCJHaOhp2moolqGaNl1WaTd1znSgNo7qcADe1yBEsnlNppyki9
	 g7OaBTOOsWh2lb8Fz/qLVP/D8IDngUUV+781ZNuCduyGeVWMzhcSjPN8906Qrc7N65
	 +WZCTiRsmdA0g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6573B48FEF;
	Wed, 11 Nov 2026 15:07:47 +0000 (UTC)
From: Asdlerto Korry via B4 Relay <devnull+korryasdlerto.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 17:07:47 +0200
Subject: [PATCH v2 3/4] nfc: s3fwrn5: i2c: Enable the pvdd supply
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
Message-Id: <20261111-m52xq-dts-v2-3-063289405882@gmail.com>
References: <20261111-m52xq-dts-v2-0-063289405882@gmail.com>
In-Reply-To: <20261111-m52xq-dts-v2-0-063289405882@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
 netdev@vger.kernel.org, Asdlerto Korry <korryasdlerto@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794409665; l=1224;
 i=korryasdlerto@gmail.com; s=20261104; h=from:subject:message-id;
 bh=rV79nydgybBLFbM4Kvj9gL9d07PN0WdedvOZm2JSmiw=;
 b=BtLsRrLyFOgwC/N79sWeh9BuLkBoz+XPUKrY/A84mTRALJNVKCA1k+Y808SvBBHt5J9eoROa3
 hOUcCvsw2EmCuGZIVJ+rHgKm4rXq6qO5Q5LKH4Qf18OwXWd0IzXhPNl
X-Developer-Key: i=korryasdlerto@gmail.com; a=ed25519;
 pk=RqttIGkm2XZ8NhLQBzPgpXXawOdVa1uODGsk+sagbxs=
X-Endpoint-Received: by B4 Relay for korryasdlerto@gmail.com/20261104 with
 auth_id=1411
X-Original-From: Asdlerto Korry <korryasdlerto@gmail.com>
Reply-To: korryasdlerto@gmail.com
Content-Transfer-Encoding: 7bit

From: Asdlerto Korry <korryasdlerto@gmail.com>

Get and enable the optional PVDD supply before the enable GPIO is
driven. Boards that switch this supply from the SoC no longer have to
mark the regulator always-on.

Signed-off-by: Asdlerto Korry <korryasdlerto@gmail.com>
---
 drivers/nfc/s3fwrn5/i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index 4ba762611711..eaa9a1f75533 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
 
 #include <net/nfc/nfc.h>
 
@@ -160,6 +161,12 @@ static int s3fwrn5_i2c_probe(struct i2c_client *client)
 	phy->i2c_dev = client;
 	i2c_set_clientdata(client, phy);
 
+	/* The chip has to be powered before EN is driven */
+	ret = devm_regulator_get_enable_optional(&client->dev, "pvdd");
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to enable pvdd supply\n");
+
 	phy->common.gpio_en = devm_gpiod_get(&client->dev, "en", GPIOD_OUT_HIGH);
 	if (IS_ERR(phy->common.gpio_en))
 		return PTR_ERR(phy->common.gpio_en);

-- 
2.25.1


