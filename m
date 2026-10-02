Received: from out198-23.us.a.mail.aliyun.com (out198-23.us.a.mail.aliyun.com [47.90.198.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707028CF4A;
	Fri,  2 Oct 2026 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790962661; cv=none; b=Zf3HtFFHBo1e3YGO9tUOHW8NchuGnKvCV+4KpqOnDV1fiHmC3mYwik9i8sHJjNBu5hgk9TI6Ohf8ZkBhfq5xGwQovDs8A+ZG0ZjbxgRnopZU0/J9HdB2/pXzIvXUOpNiEtvOwP0fv+8I6bReKSAZU3LKBgRA5inrMW1BTDUZApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790962661; c=relaxed/simple;
	bh=pQtEIg5TAtLzo1ZrSDWmJDrPuOAtGc4KKUTQAKyJaYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YrwiR6Pl67jigIQ71le+YZdY1ktfNjYnMa9o017y+acq+0mAcQg9seKl9bfPVSuMbXHqBnqTpjfYRBX7kUvsX3h/O0JTC99E2apySOT+cEW/a1WYQ85ZeWwQUtngxoiZHyw0Rz8mmbbwncFJ+rm7f+gUpDvR8oV2w163/DF2cjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08171212|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0342056-0.000822086-0.964972;FP=16713160018314691728|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jTk7nJr_1790962627;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jTk7nJr_1790962627 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 03 Oct 2026 01:37:13 +0800
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
Subject: [PATCH net-next v11 0/7] net: dsa: motorcomm: add support yt922x driver
Date: Sat,  3 Oct 2026 01:36:59 +0800
Message-Id: <20261002173706.1225502-1-kyle.switch@motor-comm.com>
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

changes in v11:
1) Initialize ctrl variable inside yt922x_port_up().
2) Update maitainer for new file.

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

 MAINTAINERS                          |   2 +
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
 13 files changed, 991 insertions(+), 35 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/pcs-922x.c
 create mode 100644 net/dsa/tag_yt922x.c

-- 
2.25.1

