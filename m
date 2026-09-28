Received: from out28-197.mail.aliyun.com (out28-197.mail.aliyun.com [115.124.28.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A9140E5F;
	Mon, 28 Sep 2026 12:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598772; cv=none; b=RCFBlWr21eauo1jgy39aC2Sx+liOv8cBsUZjnEauzKJA+MssdZa+8gSLbhoofzOir/QaqI3JavDNgv3ECefmv1/SaEXswidAXarvXLIVI99ni8h/085RXteeGIHnXVDdKgsKDvATQeQNYAUpbUXn3jOr5qC3EBJ1YRv0jTmtMTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598772; c=relaxed/simple;
	bh=K0l81un+edAdB5SzIiEsvHmqBWxY75R4gNovU3jd65Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IsIP82jdoy/qahstQdjsBlTidH7vu96GttW0PTxzBBhUG23WtF54NIfGkYIKfYNAumFTtTTMo3jR7VlDaHnr5OUSyEeArhl1tDjA2Pk926zKuzi0lUns1Ch647TStu4T9jKX3fm8zcv6ZLJA1gOawpDd32xXb2hrBFFtuY5DHII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.5423321|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0744364-0.00998503-0.915578;FP=16604998707832323984|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jQ6tpgL_1790598760;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jQ6tpgL_1790598760 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 28 Sep 2026 20:32:40 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v30 net-next 0/8] nbl driver for Nebulamatrix NICs
Date: Mon, 28 Sep 2026 20:32:25 +0800
Message-ID: <20260928123237.88994-1-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

This series continues and refines the previous v28 NBL NIC driver patch
set for Nebula-matrix m18110/m18000 (SNIC s1000) Ethernet adapters.

The first two foundational patches of v28 have been merged into net-next
main branch:
- net/nebula-matrix: add minimum nbl build framework (cffde9e49e86)
- net/nebula-matrix: add core driver architecture and HW layer
  initialization (825e6d230163)

Following maintainer feedback to shorten the patch series, this
iteration drops the two merged commits, reorganizes and polishes the
remaining functionality into a standalone 8-patch sequence. No new
features are added; this series only completes the pending core
infrastructure.

The overall driver development plan remains consistent with the v28
two-phase roadmap:
1) Complete hardware initialization, mailbox/channel communication and
   control-plane infrastructure (this series)
2) Implement netdev registration and TX/RX data-path functionality
   (follow-up series)

This patch set supplements the merged foundational code, covering
channel layer abstraction, resource management, interrupt handling,
chip-level initialization, control dispatch routing, channel RPC
framework, and device lifecycle init/remove/start/stop logic.

changes v29->v30
Link to v29:https://lore.kernel.org/netdev/20260922120311.86593-1-illusion.wang@nebula-matrix.com/
1.AI review issues
changes v28->v29
Link to v28:https://lore.kernel.org/netdev/20260914123429.56596-1-illusion.wang@nebula-matrix.com/
1.AI review issues
2.remove the hash table implementation

illusion wang (8):
  net/nebula-matrix: add channel layer
  net/nebula-matrix: add common resource implementation
  net/nebula-matrix: add intr resource implementation
  net/nebula-matrix: add chip-wide hardware init/deinit implementation
  net/nebula-matrix: dispatch: add control-level routing core
    infrastructure
  net/nebula-matrix: dispatch: implement channel RPC framework and
    serialize hardware ops
  net/nebula-matrix: add common/ctrl dev init/remove operation
  net/nebula-matrix: add common dev start/stop operation

 .../net/ethernet/nebula-matrix/nbl/Makefile   |   10 +-
 .../nbl/nbl_channel/nbl_channel.c             | 1467 +++++++++++++++++
 .../nbl/nbl_channel/nbl_channel.h             |  181 ++
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |   52 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   14 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   20 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      |  625 +++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |   55 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c |  680 ++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   25 +
 .../nebula-matrix/nbl/nbl_hw/nbl_chip.c       |   32 +
 .../nebula-matrix/nbl/nbl_hw/nbl_chip.h       |   12 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 1094 ++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  320 ++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  359 ++++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   12 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |   33 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  |  703 ++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |   21 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  157 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  121 ++
 .../nbl/nbl_include/nbl_def_channel.h         |  174 ++
 .../nbl/nbl_include/nbl_def_common.h          |   23 +
 .../nbl/nbl_include/nbl_def_dev.h             |   16 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |   61 +
 .../nbl/nbl_include/nbl_def_hw.h              |   62 +
 .../nbl/nbl_include/nbl_def_resource.h        |   38 +
 .../nbl/nbl_include/nbl_include.h             |   32 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  138 ++
 29 files changed, 6536 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h

-- 
2.47.3

