Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4500E555;
	Tue, 29 Sep 2026 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650478; cv=none; b=kyD6/59PuMNU6ZlDmF7xYGyiaqK3orP9u7xxwpiUlqQt63L/G0l4a5rjnzSgK2r0m+IvahbAt0/HJSYQwoMrSYw1XB5VmygQ+DIqd9xakCQcOVh+XZ35JIFQ5es1WEHTVD6PtpTKMVNklOVQoOzMQPNQbhCg8bZT1J9ghcZU0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650478; c=relaxed/simple;
	bh=8pGTNRSF3UK1pCVwM98x6pEio0Gcxznr7++HTyCbr3U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M+NFA6Mh6l54Fd9TCuRY1k+db3387L3dgOL6gLAWhg69+QZ9Kotws857iD6Uw+kbSF5PbtkanLghfIysAwpsz9uSIsWGdUDbQ2/DhLlq4m8hURIBVOamQDVxHvKBjZxr8e91f4XM0l9LTzhpfrUrLJDYClED9dLYm8zLkdcxJ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08713508|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0346587-0.000683779-0.964657;FP=16713160018312604816|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068005250;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jQghbcU_1790650454;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jQghbcU_1790650454 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 29 Sep 2026 10:54:25 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mmyangfl@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: [PATCH net-next v10 0/7] net: dsa: motorcomm: add support yt922x driver
Date: Tue, 29 Sep 2026 10:54:06 +0800
Message-Id: <20260929025414.313641-1-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset mainly adds support for the yt922x series to the dsa driver.
Currently, only the yt9224 in the yt922x series is supported, and the
corresponding tag handling for yt922x is added.

At the same time, it optimizes the max ports boundary check in the
existing code, and initializes the dsa switch based on the chipid.

changes in v10:
1) Rebase the code.

changes in v9:
patch 1: 1) Add a dev_err() when chipid mismatch.
patch 3: 1) Using GENMASK_U* to replace GENMASK

changes in v8:
patch 1: 1) Add a lock operation to acquire the chip ID during the probe()
         stage.
         2) Remove meaningless changes.
patch 3: Modify the changelog description.
patch 6: 1) Remove sds_init() in this patch.
         2) Code refactoring, including yt922x_sds_phyaddr_get() and
            yt921x_needs_extmode_check()
         3) In yt921x_intif_ext_write() and yt921x_intif_ext_read(),
            add a boundary check for phyaddr. The reason is that the
            phyaddr of the top ext register is 9, so max_ports should
            be used for the check to include it.
         4) In the yt922x driver, added initialization of yt921x_port
     for exporting priv.

changes in v7:
patch 1: Fix the series_lookup() redundancy issue.
         Fix the dsa->priv initialization and the code style issue.
patch 6: Move psc definition to yt921x_port
         Fix psc_get_state() and an_restart().
         Use the existing yt921x driver interface for the duplicated
         logic for chip_reset().
         Move the yt922x_cpu_port_set() to chip_setup_dsa() to align
         with yt921x function.

Kyle Switch (7):
  net: dsa: motorcomm: initialize dsa_switch based on chipid
  net: dsa: motorcomm: use max_ports in series for port bounds checking
  net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers
  net: dsa: motorcomm: move mib start from probe() to dsa_setup()
  net: dsa: motorcomm: move mib stop from remove() to teardown()
  net: dsa: tag_yt922x: add support for Motorcomm YT922x tags
  net: dsa: motorcomm: Add support for Motorcomm YT922x

 drivers/net/dsa/motorcomm/Kconfig    |   7 +-
 drivers/net/dsa/motorcomm/Makefile   |   1 +
 drivers/net/dsa/motorcomm/chip.c     | 565 +++++++++++++++++++++++++--
 drivers/net/dsa/motorcomm/chip.h     | 110 ++++++
 drivers/net/dsa/motorcomm/mdio_bus.c |  47 ++-
 drivers/net/dsa/motorcomm/mdio_bus.h |   2 +
 drivers/net/dsa/motorcomm/pcs-922x.c | 173 ++++++++
 drivers/net/dsa/motorcomm/pcs.h      |   1 +
 include/net/dsa.h                    |   2 +
 net/dsa/Kconfig                      |   6 +
 net/dsa/Makefile                     |   1 +
 net/dsa/tag_yt922x.c                 | 109 ++++++
 12 files changed, 989 insertions(+), 35 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/pcs-922x.c
 create mode 100644 net/dsa/tag_yt922x.c

-- 
2.25.1

