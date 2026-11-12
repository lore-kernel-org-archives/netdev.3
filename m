Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504351;
	b=bcIFFWlcOVlN9p5BB9NM6kzIG7q5c7mcdEEt/WmivoRwnOrY7F/S7ZutTH6CVqi+t7uu
	 oQmlh6Gelb0p+5eTuWHYD2lXT4moaLgYq25moMvU2GisBJyJyMTDwWIJCiV8Ou+oi8mh+
	 Fyp2iIn18m72J+/pH6FaLJrsLbVr1rkTvfeyt1nuL5/H3k3IwJAf5I8KKZ7e1yd256NiJ
	 LardX3sRdmt46UfBib7ZGKW1NVGEC1Pad3TUSj/wHSimAIiNnSXl97EeR28i5aqDNU19J
	 L+mLmMV0thUq0WZLnV96z6BBvLlZv56Vj4MMo8/RMhyUL8R49BfSUwk4K8sFXkix/sQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504351;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VCv7KYBGvrMdQS7BXuXkGcc9FkOA7UPEnnTHueWJv/g=;
	b=s7QKzD0FYUAb5c/OQonJhb1Kt/GsQjWTf/clq1QVq5LisuLvyl5PS5/aR3hFBVtz2aeb
	 iSSAvLExLKdNeeAoHPrLBhFKapbz62zma4RZlSxMXKFFBlQ0KlX3TjtvVMg3VI+1ItiC5
	 yh52vrS9k7nymj8nDRvbADVoblgxNZWXNjyzV2WGn34baRkjLlnCvwkrIzjjFCtrmTXPn
	 sQfAQ2CORk78DCa+YCC3YjgdIjTicg1cYB0K/KLgndInd2FWMz3KBjmuMIMVwxxsjNFX6
	 Kgki9wxP406Ij5Br0juuizGY+bSlraLtzIcFl+0pbSs+zZUJQVf485/HUwlgJjL6ISw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWZ1i7Is;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20896606A31C;
	Thu, 12 Nov 2026 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YWZ1i7Is
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794504350;
	b=HSZWWiwPZlPuC1hOd5u6uVBrL1mIFwkY8VEvMFrh7kXhNsHZ82hPqbjtkqlA+M65REgV
	 laVnUSU57BDLZs40dB+6eZJBbTs16JQxLR/QHP96OI8ElUjBS0jXv0m5A8+xsRsK15bVE
	 K+iJQ6Vf8hvGSYX4yNC2F0b6uvjM4cWlN0v+XrcsA1vR1rDDlSdeDCuzySJpWajVVlXWu
	 8lzKWTiiTSavJhOLTCHhsy64xBuqupqkNjSEeAJ0CxAevskNKFd0+XC1GJLhdDfRyw42Y
	 SFgHb0ngx4Kk95s1Qfkm44ea29GIy3zVU9KmMiFHheKHK2Mj3sMX1qNSU3m9A5Ps+sA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794504350;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VCv7KYBGvrMdQS7BXuXkGcc9FkOA7UPEnnTHueWJv/g=;
	b=ouZ7QL42hUr+yRDiw8N2BRgOPHmp/qj+wZre0nO5TgXdo+S+zduPeXrlXJSRwaT4mj1n
	 N/KIBTe4UlPDsEi4HegSke1xKK306nP/T9djvq0oAh4zPy7+WTV5z1AP8ibVg7B3WbgJv
	 i2MC2TwhL5YzcG+PHDBQ3MWPSQqDKPK5NjBAfQIprDrksjdQgkGBwxlHLD1pXM23lWUDD
	 u5tqNaG7y5HmAaqE3s2DnV9UyNHltkS7gvsZangMLHNsUJOnAVDNhpREkp6sWxi+C87WX
	 mLu/rRLJdKAGT7EyCP9iFuG7jiUfuMBUHPcHSfEl5ZKje1Dn6yijUGHZT+xlHdf6WTw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2422F1F000C5;
	Thu, 12 Nov 2026 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504350;
	bh=VCv7KYBGvrMdQS7BXuXkGcc9FkOA7UPEnnTHueWJv/g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YWZ1i7IsUvFP/WPoXq+iROPpAX807yoeWlzYDM7Ee7qmswcZ+hwi7sEdNF5B/P5Cj
	 EJgEJBaSloFIZUiyJNH4duSn+lbDicmMu9WnvlcodwUxFEiztomoUYCLtonHqf5Rad
	 YpxvNEQ2zWNzrk9VHHAFYlPmf5NS190jlprpfA3Vc2/N13do4Qnbm8X9IkpezxKqOQ
	 JJaZus/QpB7oksvYUHyJTXU6BNFnkymHVSWndCE+vYAUvRI5Ux1UBnef8XW03OorQ8
	 q+BWApKSPPn+gzjYhgWJLsloyhVh2t163P5zy9215YsgO7X7CRm5gj/37Udb0ZSHhY
	 MLO2j+wwrpwyQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A0EF545A7E;
	Thu, 12 Nov 2026 17:25:49 +0000 (UTC)
From: Asdlerto Korry via B4 Relay <devnull+korryasdlerto.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 19:25:50 +0200
Subject: [PATCH net-next v3 2/2] nfc: s3fwrn5: i2c: Enable the pvdd supply
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
Message-Id: <20261112-m52xq-nfc-netdev-v3-2-725a61ce4148@gmail.com>
References: <20261112-m52xq-nfc-netdev-v3-0-725a61ce4148@gmail.com>
In-Reply-To: <20261112-m52xq-nfc-netdev-v3-0-725a61ce4148@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Asdlerto Korry <korryasdlerto@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794504348; l=1297;
 i=korryasdlerto@gmail.com; s=20261104; h=from:subject:message-id;
 bh=BU/u19abuS0g4Yio1+6hrfs+bYhBTcwmZ8Z62ReWzM0=;
 b=zXW9TD99ARWgKP8NRp0zBxxVn18mZEoUA4raHgsuCQNx5yRKCwfrVKa0K3c8mxE/8yzTJlKqs
 mKzzNM8Ef1lARsFLDTuOpIG2PfkrqMvfPK0CpeQDLgnpGe8/wrNDqJY
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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


