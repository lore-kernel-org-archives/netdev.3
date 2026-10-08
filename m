Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D2422A4F1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791426522; cv=none; b=MetprWrhcWp0fBExnoGX9r68K/lneCDdns14qNLqPrApd8avEhMzRVBrqmVIHdyywhJfjbPKqpSGFphlDix/xgQyqVtEb7lMtHqN8buXImHIR0vfoqBmLnnzccK42noycTZXz8MT/ylneNoaWj4FvjvvwRn/g+FROT0RqE6yhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791426522; c=relaxed/simple;
	bh=pJCcvTykfNBX4OcOIfs+L/ELsHjM37PhVPLQgZLGoKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWg9BDTy8gx1dNZDY4Zg3wr3ElbLunU4LEXt0Ccb7z5OoJo86tjgfn5hddUouZHH5lLl6yxZg4ZppHchSX0WPjSJEq9vP90xO/hTPtCNqzn0PSAeldwgDxzbc79cxqtyhX3GzYHG3tgsmyaNZPzzdK++LF0SmeZPhmp2dVclzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8bUAgYv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8bUAgYv"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2dfa54c8ccfso1488035ad.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 19:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791426521; x=1792031321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MwahjYlmNg5Sb7TImh0bCwCphihNsrlCradydgL/hSk=;
        b=g8bUAgYvUY1cSrIHQrLmGj+aXyvUoFGrUvIxL3wjuZUcVPMm3KveIridAPoFndt5j+
         e9MZm6s0KPBSoA3TMFYwaO1kHW7fKmV+BNOFq3mf3pUDN10xFjyn0rbRQ5u9YnP5uZWn
         k5aayMHWYgtP1ipgTAS0uYIWi03aEmP9yTs7KAs3kAHynoFFsbSGBLY0MKVtlA5Pp0Ll
         yZGyzQ9lQ7+Sqq1mIpYu8rxO9q30qXeiazn95KtSPnzQSxhXHicDCdXaKKWN1yVzxKjP
         zI4SVmdtXg0LFrJTdTBpseYiRcTYNqU8SO+fJIoVLaREL5BTigklrzzWFqgx5q8/hAFw
         u6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791426521; x=1792031321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwahjYlmNg5Sb7TImh0bCwCphihNsrlCradydgL/hSk=;
        b=fvc0qFTX8z5PehKUwRMd9BPEK4EwevmOyYAnUBz9FZTE0fCZRMNqrdxs+Jo1zs49Pi
         aJVMK29bs7b7zd47ll4MkaR2kkPngn/w/IO7JGzcJpZuatB9mjuj6pjI7E+MWOZd+KhA
         YKQDFicgzn7WbY3ADOv+I/QtC4kK71UaZOABeZFQSGEAuoyuTA3PQKtUPYglG0Ws+22j
         rv+Y/gPieZBGKE640K7yo/hiZtqq/0aPtGfKCj4ATZIkyg3AQ8NBH5iK5P18LjSAXA+V
         02Z8oFi/b53uP54oHGdI+WN6pCjzYgcouwJUJdWTCU0F/35W06Smsw13KJhOoBiv4+0E
         vPvQ==
X-Gm-Message-State: AFq9FYL+umx4BYfEitfSz6fgVHtPIJHotUi6/EXm6jIoxJ01NSIaa+qB
	6e6rSZz7gbtoYeO53/wpWBPF0uIaYlBhknU+ji04UKgMVrSjKbOAfAlSVKH7G+gKz58=
X-Gm-Gg: AYBFou1YRPUqAGKARi4ha21WS7KVXfu347Q92fV7Sz0+rK4dls/LkSMQMvXk3tBITOQ
	A9mhDjbw5K3VD5bbB0hMhNPZrckHtY9mEoiOTP7s4wgkt/xyddwOMQFSTDK9jJvsQPJVwK23RRD
	OlesPE+ca01xeBXxoYHJw/0WuvojoRRZa75suZzgWpQqvIt7xc5PAdlnirm87iIqPTm7Aowg1pc
	CdzwUxNpGoYXjWVm3TXMN6xLPm/+91vtme8rEJKDCZFuECwo6SW/4oSq8k38fkOxyXb5qlUU3yI
	cDODB5CnzCyisch842MWWb/9YQBE1Eb5SMgrcKxiKlBxHj76pNWPd60agCV3ocOmF4/vCLcm4Zt
	NPBBM/lGerMyT0NlhMAvKJhsc3kbnC25J8RLPMxMnQSw4KJs59ldEsW+A7CpGrZBRV3pm4zF52X
	lxWqzY+T84wmiq2N+xVAknPiy6y5DV7Ud5SSCCS+YAuv4Ab9FhEL83MW+lSfIjxPbFXModIbIHB
	TUMpNXErDW2eQKhARfQ7pEM1A==
X-Received: by 2002:a17:902:eb8d:b0:2df:375f:b7ee with SMTP id d9443c01a7336-2e7ffde9b3dmr5405065ad.18.1791426520826;
        Wed, 07 Oct 2026 19:28:40 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661c:1246::1d2:d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482cab0sm18045865ad.50.2026.10.07.19.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 19:28:40 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Ciprian Regus <ciprian.regus@analog.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Parvathi Pudi <parvathi@couthit.com>,
	Roger Quadros <rogerq@kernel.org>,
	Mohan Reddy Putluru <pmohan@couthit.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 00/10] net: Move setting of netops to fix crash
Date: Thu,  8 Oct 2026 10:26:42 +0800
Message-ID: <20261008022656.3592191-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ded86da4bbb7 ("net: ethtool: relax ethnl_req_get_phydev()
locking assertion") put a netdev_need_ops_lock() check on the
phy_attach_direct() path, in phy_link_topo_add_phy(). With
CONFIG_NET_SHAPER enabled netdev_need_ops_lock() reads
dev->netdev_ops->net_shaper_ops, so any driver that connects a PHY
before assigning ndev->netdev_ops now dies with a NULL pointer
dereference at probe time. The breakage showed up in v7.3-rc1.

ibm/emac was hit first and fixed by commit 7c9f391ec89c ("net: emac:
move setting of netops to fix crash"). These ten patches apply the
same one-line move to the remaining in-tree drivers whose probe path
attaches a PHY before filling in netdev_ops:

  1. hisilicon/hisi_femac   (crash reproduced on hardware)
  2. hisilicon/hip04
  3. actions/owl-emac
  4. adi/adin1140
  5. marvell/mv643xx_eth
  6. amd/au1000_eth
  7. ethoc
  8. aeroflex/greth
  9. ti/icssm-prueth
 10. microchip/lan865x      (attach happens inside oa_tc6_init())

Only patch 1 was reproduced and verified on hardware; patches 2-10
were found by source inspection and are neither build nor boot
tested.

Note that ti/netcp_ethss and cavium/thunder_bgx attach a PHY to
netdevs that never get a netdev_ops at all (dummy netdevs), so they
cannot be fixed by reordering and are not addressed here.

David Yang (10):
  net: hisilicon: hisi_femac: Move setting of netops to fix crash
  net: hisilicon: hip04_eth: Move setting of netops to fix crash
  net: ethernet: actions: Move setting of netops to fix crash
  net: ethernet: adi: Move setting of netops to fix crash
  net: mv643xx: move setting of netops to fix crash
  net: au1000: move setting of netops to fix crash
  net: ethoc: move setting of netops to fix crash
  net: ethernet: aeroflex: move setting of netops to fix crash
  net: ti: icssm-prueth: Move setting of netops to fix crash
  microchip: lan865x: move setting of netops to fix crash

 drivers/net/ethernet/actions/owl-emac.c          | 3 ++-
 drivers/net/ethernet/adi/adin1140.c              | 3 ++-
 drivers/net/ethernet/aeroflex/greth.c            | 3 ++-
 drivers/net/ethernet/amd/au1000_eth.c            | 3 ++-
 drivers/net/ethernet/ethoc.c                     | 3 ++-
 drivers/net/ethernet/hisilicon/hip04_eth.c       | 3 ++-
 drivers/net/ethernet/hisilicon/hisi_femac.c      | 3 ++-
 drivers/net/ethernet/marvell/mv643xx_eth.c       | 4 ++--
 drivers/net/ethernet/microchip/lan865x/lan865x.c | 3 ++-
 drivers/net/ethernet/ti/icssm/icssm_prueth.c     | 3 ++-
 10 files changed, 20 insertions(+), 11 deletions(-)

-- 
2.53.0

