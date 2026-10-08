Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E583ABD80;
	Thu,  8 Oct 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478417; cv=none; b=psnyCs2cvHxRlXZDLinjFfCEVRUqRMkK2JwY/oOEaR9+KwAM5AQ7hikR6UtfW4b7rwiOecUBSepM0cJsgLhzpRxW3kG4TurblraIlsh+kkv62DS/2QwVGe9qu2qe0gTu2ttBKzJTpid0LB+y9sUSYggHJKRS//aooHWj7O7AmxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478417; c=relaxed/simple;
	bh=CHrg/5nhW8ZoRHnxM/UpD41foj63PkOKAilIxgokRvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B5Ug2756HkiD1POTe3d71GUx0+a0IfU47gFWMi1RhJser6i24zRitfNbbTS7lLA1J95SqYFNx19wh4LWTCK+PHn23ANkUwyO0PLNU1Q/PHbUmk1uNT6UnscjMZmGAB22oqeHOCCNhbUJpqOTZcedQZHq44aBuakNhQ4sx/bm7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAAHED6FysdqbYoOCg--.13658S2;
	Fri, 09 Oct 2026 00:53:25 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Josua Mayer <josua@solid-run.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: mvmdio: fix clk reference leak in orion_mdio_probe()
Date: Fri,  9 Oct 2026 00:53:28 +0800
Message-Id: <20261008165328.2702289-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHED6FysdqbYoOCg--.13658S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyfJr1rKr1fZFy8try7Jrb_yoW8Cr17pa
	yvgFyYy3yxJFyUW3WkXa18ZFyF9a1fta4fGryayanY9343GryxZr93GrW0vrWUJFWkCw4a
	qr1UAa1xZ3WDZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUqHqcDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUOA2rHpDliXAAAsf

orion_mdio_probe() calls of_clk_get() with index ARRAY_SIZE(dev->clk)
purely to test whether the device tree declares more clocks than the
driver supports.  of_clk_get() takes a reference on the returned clk,
but the return value is only checked with IS_ERR() and never released,
so both the clk reference and the clk allocated by alloc_clk() are leaked
whenever the DT node has more than four clocks.

Store the returned clk in a local variable and release it with clk_put()
after emitting the warning.

Fixes: ea664b1bdc19 ("net: mvmdio: print warning when orion-mdio has too many clocks")
Assisted-by: DeepSeek-V4.1-Flash
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/marvell/mvmdio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 2ccb8c8f5feb..17537142be6d 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -286,6 +286,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	struct resource *r;
 	struct mii_bus *bus;
 	struct orion_mdio_dev *dev;
+	struct clk *clk;
 	int i, ret;
 
 	type = (uintptr_t)device_get_match_data(&pdev->dev);
@@ -338,11 +339,13 @@ static int orion_mdio_probe(struct platform_device *pdev)
 			clk_prepare_enable(dev->clk[i]);
 		}
 
-		if (!IS_ERR(of_clk_get(pdev->dev.of_node,
-				       ARRAY_SIZE(dev->clk))))
+		clk = of_clk_get(pdev->dev.of_node, ARRAY_SIZE(dev->clk));
+		if (!IS_ERR(clk)) {
 			dev_warn(&pdev->dev,
 				 "unsupported number of clocks, limiting to the first "
 				 __stringify(ARRAY_SIZE(dev->clk)) "\n");
+			clk_put(clk);
+		}
 
 		if (type == BUS_TYPE_XSMI)
 			orion_mdio_xsmi_set_mdc_freq(bus);
-- 
2.25.1

