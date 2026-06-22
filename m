Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBBE2E040D;
	Mon, 22 Jun 2026 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782129264; cv=none; b=Xc7hCS3R33nv+syCU+/msFWqvc3kQvQwZpHTpK9YHBHh5lL6KslMahR2YTy3tGLKNJOF4M9bGA3ltxIyWEnWF0yHrkmfRn+UeK+bh0hFACBSmnGdRu9TwrCjJH3A3GdbCVTQke/ZVXMbRNGZZF4dzvTwOUxyFOaFblrvB0lMes4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782129264; c=relaxed/simple;
	bh=zb21KzLXAgnRALbkzFvdIAa5XrZDwTtMTqswp9or0Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W0tk8UHEv+SaXMwWXhyuxsXHLDtixoKIla0MeUIPKJ+11qZME72HsbPmHQeM4U0t5GxOCxHRG5CN0kelW2IwfHxIgZmtocmpxNPFkjyUS/tTAnCLE/lB+V1AMp3w9xasKxFCUSOqilFcrs5egkCuEKfZ7BRWWdCtUEbadDOIovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.238])
	by APP-03 (Coremail) with SMTP id rQCowACXdZxeIjlqRYqGFQ--.43340S2;
	Mon, 22 Jun 2026 19:54:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>
Subject: [PATCH v2] net: mdio: airoha: fix reset control leak in error path
Date: Mon, 22 Jun 2026 19:54:03 +0800
Message-Id: <20260622115403.39772-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXdZxeIjlqRYqGFQ--.43340S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFy7uFWUAw17Cr15XF4kXrb_yoW8Xr48pr
	4jk34ayFWUtr4rJay8Aw4rZasI93Zxta4UGrZIv3ySvr1fGrW7XrW2yFyvgFyUCFW0qry5
	Cr42ya18uF4DA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoGA2o43cr+VwAAsk

In airoha_mdio_probe(), after calling reset_control_deassert(),
if clk_set_rate() fails, the function returns immediately without
calling reset_control_assert(). This leaves the reset line
deasserted and causes a reference count leak on shared reset
controllers.

Fix this by reorganizing the error handling to use a goto label,
ensuring reset_control_assert() is called on all error paths
before returning.

Also add error checking for reset_control_deassert().
Fixes: 67e3ba978361 ("net: mdio: Add MDIO bus controller for Airoha AN7583")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/mdio/mdio-airoha.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mdio/mdio-airoha.c b/drivers/net/mdio/mdio-airoha.c
index 52e7475121ea..4c1b2415687c 100644
--- a/drivers/net/mdio/mdio-airoha.c
+++ b/drivers/net/mdio/mdio-airoha.c
@@ -246,15 +246,17 @@ static int airoha_mdio_probe(struct platform_device *pdev)
 
 	ret = clk_set_rate(priv->clk, freq);
 	if (ret)
-		return ret;
+		goto err_reset_assert;
 
 	ret = devm_of_mdiobus_register(dev, bus, dev->of_node);
-	if (ret) {
-		reset_control_assert(priv->reset);
-		return ret;
-	}
+	if (ret)
+		goto err_reset_assert;
 
 	return 0;
+
+err_reset_assert:
+	reset_control_assert(priv->reset);
+	return ret;
 }
 
 static const struct of_device_id airoha_mdio_dt_ids[] = {
-- 
2.39.5 (Apple Git-154)

