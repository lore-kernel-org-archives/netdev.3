Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653222F7F01;
	Sun, 27 Sep 2026 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790520679; cv=none; b=NhAaRgSQTE+W/aSoxc7fbYyyptjnYKxEjZpZDmuZhHX19LP78+ulC2JiKjqThO7oxuMY50KMBgqMRQ5keDCeaeFCVRrf66cT0eC4xqKsGSWcAvdiMTAAuVnaBT2fl8kAEIJmNVk0s6Jm4VrK/8+wxPr0fT4r1lXD2yUA6aKVRC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790520679; c=relaxed/simple;
	bh=TK1gImBMhRgBTBDF7HKLfd+Byj7VBVGMv9S3OnhG6bg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sgH6k8/ySHK7BUr6zWKYg7abQMv02ZnGF1H+O/eSbDomFG629XnvfxJ/jnHweVvS332sAWefHnUCTG2kR7k6R0F788J8rO+zYeWTtmwjUqii/qnIKZ7zvJIoyeik4Yw5M9p8we8ZLRhMKQuckuMOJopzNT8D5MGqLiXkWWmXIP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J1x87me6; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J1x87me6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/X
	MHc5GIuhjpObJjerDu36k2PUDjUw5VDqwU1ib8loI=; b=J1x87me6ZZu7bVUysv
	gtwLlMGrw9y64gZnN4bKsnKEKUcBTGYpGnqiHB6/Wi1e5Ypuu/hN3rc9bsINTFqr
	DFCo+ZdSHdzJh9xLyF3KfWCDrI6i+cwapFrR60l2iYbkWiL7nUOTzRk1RaH0hy+L
	RHEM7FxgzonXHIA2eD/yUsvP8=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD330OOLLlqjwJIBA--.47706S2;
	Sun, 27 Sep 2026 22:47:44 +0800 (CST)
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
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Soren Brinkmann <soren.brinkmann@xilinx.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	dingtianhong <dingtianhong@huawei.com>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Dongpo Li <lidongpo@hisilicon.com>,
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>,
	Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Vipul Pandya <vipul.pandya@samsung.com>,
	Girish K S <ks.giri@samsung.com>,
	Siva Reddy <siva.kallam@samsung.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH v2 0/7] net: ethernet: release managed IRQs before freeing netdevs
Date: Sun, 27 Sep 2026 22:47:33 +0800
Message-Id: <20260927144741.1320558-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD330OOLLlqjwJIBA--.47706S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4xZrykCFWDur4kWr43Awb_yoW8tr4Dpr
	WrtFW3urn7JrWaqws7CF1IvF95AF4fKF4Ykr47tw4rZw15AryDtrW7WFyFvFW5tFZ7AF1j
	qr4Yywn3u3WDu37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRaiiDUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzhA4cmq5LJBNGgAA3s

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

Changes in v2:
- Keep commit message tags together without blank lines between them, as
  requested by Francesco.

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

