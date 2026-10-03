Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28633B992C;
	Sat,  3 Oct 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791018168; cv=none; b=usSwKFAxhXDpVCYZ92/yxyeb0a1hPFYV0iaET8zGhTftX8lAZtICENs8L3J0XZcNwIoxlp1sSJXVW76RLY+atGUXd4sY60CmGk5/JwUVQimRArqnZvbKvROLRwUwBuXzg1jNG0YnNjhb7ME0J7bv862kWmoCIOVLow24xltDxb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791018168; c=relaxed/simple;
	bh=JHIJZ+Nq4EksoDu7uv14qPjyqd+3ALfF0Tm3yKu2j1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KoXtB39ax4JqYGE8KnDLOlG3XUbNKgy0IhCX0GayofzgbjWPDCs4t69Q5dnXyOY9cwBvZw1ALaWzYIf93SdybIh2OwoB/LCFPlLxf6Z0DLQNnlagjl8v9tqtOws6oWAvos7rgmScOC9N8571wm+bPpkAPej1vbfJnB+9vG6ZvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OoRhdd97; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OoRhdd97"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=UN
	GuWRPGKIDXpixNtRVeSpH5PE0CmbSCQDhZyyIiwMk=; b=OoRhdd97nAsPM+/cYu
	30edtOaB7lSvmGlGp8iLk7oXaKrindg6h/uK3o1f7tVnh0bHdOAedWJOLK6TDUDS
	EDlnpyZbwt0hQDSrPpL42GaW+yGlL3IFBJXxRN9gGQEWIlPLMN+deOUKdOHTeF/y
	vDd1CziYPsZcZ3GsLkbP8qMhY=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXP4b_w8BqInaGCg--.62290S2;
	Sat, 03 Oct 2026 16:59:45 +0800 (CST)
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
	Arnd Bergmann <arnd@arndb.de>,
	dingtianhong <dingtianhong@huawei.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Dongpo Li <lidongpo@hisilicon.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Vipul Pandya <vipul.pandya@samsung.com>,
	Siva Reddy <siva.kallam@samsung.com>,
	Girish K S <ks.giri@samsung.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH net v3 0/7] net: ethernet: release managed IRQs before freeing netdevs
Date: Sat,  3 Oct 2026 16:59:31 +0800
Message-Id: <20261003085940.493951-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXP4b_w8BqInaGCg--.62290S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWrXry3uFyDAF45CFW7urg_yoW5WF15p3
	y3Ka9xur1kXr4avws3ZF40yF95ZF4fKF4Ykry7tw1rZw15Ary8Ary2gFyFvFWYyrWxA3Wj
	qr4Yvwn3u3Z8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRaiiDUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQH7NmrAxAFFUgAA35

Several Ethernet platform drivers request interrupts with
devm_request_irq() but allocate and free their netdevs manually.
Device-managed resources are released only after the driver's remove
callback returns, so these callbacks can free the IRQ data while the
interrupt handlers can still be invoked. A late or shared interrupt in
this window can dereference freed memory.

For six drivers, make the netdev allocation device managed. Since each IRQ
is requested after its netdev is allocated, devres ordering releases the
IRQ before the netdev. SXGBE also keeps its hardware operations object
alive through the same ordering because its handlers dereference that
object directly.

FEC additionally masks its hardware interrupt sources and disables the
Linux IRQs before unregistering the netdev, preventing handlers from
accessing registers after the clocks and other resources are released.

RAVB keeps its netdev manually managed because its remove callback has an
existing runtime PM error path which can return before unregistering it.
Instead, place its IRQs in a dedicated devres group and release that group
after unregistering the netdev and on probe failures. The runtime PM error
path is intentionally left unchanged and will be addressed separately
after this series.

These issues were found by a static analysis method used in our research.
Each patch handles one driver and is independently buildable.

Changes in v3:
- Target the net tree and document how the issues were found.
- Mask and disable FEC interrupts before dependent resources are released,
  and remove the obsolete failed_ioremap label.
- Limit the RAVB change to IRQ/netdev teardown ordering, correct its Fixes
  tag, and defer the separate runtime PM error-path change.

Changes in v2:
- Keep commit message tags together without blank lines between them, as
  requested by Francesco.

Jiale Yao (7):
  net: macb: manage the netdev lifetime with devres
  net: fec: release IRQs before dependent resources
  net: hip04: manage the netdev lifetime with devres
  net: hisi_femac: manage the netdev lifetime with devres
  net: hix5hd2: manage the netdev lifetime with devres
  net: ravb: release managed IRQs before freeing netdev
  net: sxgbe: manage IRQ data lifetimes with devres

 drivers/net/ethernet/cadence/macb_main.c      | 17 +++++------
 drivers/net/ethernet/freescale/fec_main.c     | 28 +++++++++++--------
 drivers/net/ethernet/hisilicon/hip04_eth.c    |  4 +--
 drivers/net/ethernet/hisilicon/hisi_femac.c   | 15 ++++------
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 15 ++++------
 drivers/net/ethernet/renesas/ravb_main.c      | 18 +++++++++---
 .../net/ethernet/samsung/sxgbe/sxgbe_main.c   | 26 ++++++-----------
 7 files changed, 60 insertions(+), 63 deletions(-)

-- 
2.34.1

