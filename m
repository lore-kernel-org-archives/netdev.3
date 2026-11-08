Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135643;
	b=Df6yFKJEerenXf/RKtq5BmqrpdvCgZ8LROTsCM4y6ahaiv6ZtOoherwoqkMKJynHjRBR
	 DcxUaUYkdo/SrzJNXlwumRNK5YR1mqtwh3s7cIpZ8i3gBzn7EZ0AHzpmSuIfcI96fj39V
	 kjiB41lfnFGusdNrHFqva8qb1R2a5rNiz1NMIhnEoi6mxgqEd+22sCoTOvRV96MJiYyX0
	 fxBuJ/paD5CKqIgeazDQZyKq/48aSTb388AI+kaidzGluOsgvgzNOtQIJj19vvCJLgqpa
	 MvGssaeQ20/0Du93PZQ2Jhvs6bW/OhJi/HYKOgTl2PxXOZRdZMpAFTaJgJR8M6bUEPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135643;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=rzNTqiF/0oFtFuwLiqpYwCiwI9Zt2IrMYSYo1+8ZOzw=;
	b=tIPqV6JRsEbifvhAZKSTQ6rXABGfTZtghi/dr9jk044F9GVHLfYzy1ge6ESaFbsVQjGn
	 qdOZ/+7zgYi7dSoMLzPs+LOSH2GSbZE5hPr3KTQ/WtkTnil6F3le3zpIOjY2rCyQDeGcz
	 AkTkHRm40wNpHimtgUgQrdnt6c5axctZ6gK2AoBjwR7itkeuGn6iNncglYQvZa+tnckfI
	 Lo79mA3sPdZGqqQwlbnrVuWIuWQVYbBvwqN+5gVRqRZmS7WAdBOEjuqZnkRQZd9j+ad3P
	 qFaYQ6A/Ve4aTfEf7t6Zpz54n6b+Yo5C2/EKBxIP5NviRipoXpIXLQX5FPcMxmhu/7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80D606A332;
	Sun,  8 Nov 2026 11:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB80D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADngLZOVvBq3vOZAA--.18448S2;
	Sun, 08 Nov 2026 19:00:30 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Simon Horman <horms@kernel.org>, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 vulab@iscas.ac.cn
Subject:
 [PATCH v2] net: stmmac: release MDIO node if bus data allocation fails
Date: Sun, 08 Nov 2026 11:02:31 +0000
Message-ID: <20261108110231.315004-1-vulab@iscas.ac.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowADngLZOVvBq3vOZAA--.18448S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw4DuF1rWF1fXF1rJr4xZwb_yoW8ZFy5p3
	y7Ga9Fvrn5Jr1xtw4kJw18ZFyYkayayrWUGrWxKan3u3Z8GryaqryaqFWj9F9rArWkW3Zx
	tF4jkF47ZF1DAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxV
	W8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjU-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAFA2rv4qizTQAAs7

stmmac_mdio_setup() takes a reference on the MDIO device tree node and
stores it in plat->mdio_node before allocating plat->mdio_bus_data. If
that allocation fails, the function returns -ENOMEM and the caller
jumps to error_put_phy, which only drops plat->phy_node, so the
reference on the MDIO node is leaked.

Release the reference before returning, using an error label so that
the cleanup stays in one place.

The issue was found by a static analysis tool; the candidate was then
audited and the fix was prepared with the help of DeepSeek and
GPT-6.1 Sol. It was identified by code inspection only and was not
triggered; this patch was compile-tested, not tested on hardware.

Fixes: 1a981c0586c0 ("net: stmmac: Make MDIO bus reset optional")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Sorry for the very late follow-up to the review.
- Use a goto-based error label, as suggested by Simon Horman,
  instead of an inline of_node_put().
- Describe how the issue was found and how it was tested, as
  requested by netdev-bot.
- Drop Cc: stable@vger.kernel.org: the leak is only reachable when
  the bus data allocation fails.

 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 3ea16d618215..ded352afd103 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -356,12 +356,17 @@ static int stmmac_mdio_setup(struct plat_stmmacenet_data *plat,
 						   sizeof(*plat->mdio_bus_data),
 						   GFP_KERNEL);
 		if (!plat->mdio_bus_data)
-			return -ENOMEM;
+			goto err_put_mdio_node;
 
 		plat->mdio_bus_data->needs_reset = true;
 	}
 
 	return 0;
+
+err_put_mdio_node:
+	of_node_put(plat->mdio_node);
+	plat->mdio_node = NULL;
+	return -ENOMEM;
 }
 
 /**
-- 
2.34.1

