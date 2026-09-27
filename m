Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C8B28505E;
	Sun, 27 Sep 2026 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790507609; cv=none; b=ANSqOcYJDxwqg+8Z6YLbv8N+RQgA6ViUkmJCu0zHLX+P3QnD8F6Qz0IseUTnEADWAIamdMi9PS/eOXwZiVslDGCl1PzLF8jXcW2loGng+fUTzk1D++plSbGvVwSFUfeAKCek+IxmYqhkGVXk8nLvPOp25N/LFhu1ifS2Ay3DwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790507609; c=relaxed/simple;
	bh=kOLbId6K8FdUWZMjux32HvEuTRY8wE3Losla8gmLV1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CW86sR8ekjnzXhXz0IxNrJ5KqDYXpgKVAVbqkfil9VVmyBom9pwrvQoNFNWt4nQ0+AL1MkLS4ZTdau/Ixvy4DZqs6VjwJ+nNZ1sCOk//+J4GwH7uOlaaoPfCCQAx4vDhsLi2PxnXqpghQQ4WpLZ7ppjPgwRhq9odKUQhQznRTc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BwlvqHnR; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BwlvqHnR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=q5
	85d+RZE5u1nwYpb62J5OBTENxYwIPs4OGx+0y3VgQ=; b=BwlvqHnRoSlI4NhC91
	37fj1bB259+j4FElGLRKhdG2/9B+QNhRb0XwsXIGVj6/OnS/T30adAanHgriw5aP
	v/H9o35LDxFCCvlWgyoEh+rQnUI9MIYYSgZyJe1hVfgIAyw2yGQz//Pc2Oe9m5KS
	MfsNVfgK40vXnGIe4RNKxUtRE=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3_92P+bhqB9V5BA--.4648S2;
	Sun, 27 Sep 2026 19:10:09 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Wei Fang <wei.fang@nxp.com>,
	Frank Li <frank.li@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Byungho An <bh74.an@samsung.com>,
	Russell King <linux@armlinux.org.uk>,
	Soren Brinkmann <soren.brinkmann@xilinx.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	dingtianhong <dingtianhong@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Dongpo Li <lidongpo@hisilicon.com>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Siva Reddy <siva.kallam@samsung.com>,
	Vipul Pandya <vipul.pandya@samsung.com>,
	Girish K S <ks.giri@samsung.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/7] net: ethernet: release managed IRQs before freeing netdevs
Date: Sun, 27 Sep 2026 19:09:57 +0800
Message-Id: <20260927111005.1035089-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_92P+bhqB9V5BA--.4648S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4xZrykCFWDur4kWr43Awb_yoW8ury7pr
	WftFW3urn7JrWaqws7uF10vF95AF4fKF4Ykr47tw4rZw1rAryDtry7WFy0vFW5tFWxAF1j
	qr4Yywn7u3WDu37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRx9NfUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7xFrpWq4+ZH3LgAA3T

Several Ethernet platform drivers request interrupts with
devm_request_irq() but allocate and free their netdevs manually.
Device-managed resources are released only after the driver's remove
callback returns, so these callbacks free the IRQ data while the interrupt
handlers can still be invoked. A late or shared interrupt in this window
can dereference freed memory.

For six drivers, make the netdev allocation device managed. Since each IRQ
is requested after its netdev is allocated, devres ordering releases the
IRQ before the netdev. SXGBE also keeps its hardware operations object
alive through the same ordering because its handlers dereference that
object directly.

RAVB takes a separate path because its ndo_stop() participates in runtime
PM teardown and its remove callback can encounter a resume failure before
unregister_netdev(). Keep its netdev manually managed, place its IRQs in a
dedicated devres group, and explicitly release that group after
unregistering the netdev. On a resume failure, continue the software
teardown without an unmatched runtime PM put.

Each patch handles one driver and is independently buildable.

Jiale Yao (7):
  net: macb: manage the netdev lifetime with devres
  net: fec: manage the netdev lifetime with devres
  net: hip04: manage the netdev lifetime with devres
  net: hisi_femac: manage the netdev lifetime with devres
  net: hix5hd2: manage the netdev lifetime with devres
  net: ravb: fix resource teardown ordering
  net: sxgbe: manage IRQ data lifetimes with devres

 drivers/net/ethernet/cadence/macb_main.c      | 17 +++++-------
 drivers/net/ethernet/freescale/fec_main.c     |  8 +++---
 drivers/net/ethernet/hisilicon/hip04_eth.c    |  4 +--
 drivers/net/ethernet/hisilicon/hisi_femac.c   | 15 +++++------
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 15 +++++------
 drivers/net/ethernet/renesas/ravb_main.c      | 23 +++++++++++-----
 .../net/ethernet/samsung/sxgbe/sxgbe_main.c   | 26 +++++++------------
 7 files changed, 49 insertions(+), 59 deletions(-)

-- 
2.34.1

