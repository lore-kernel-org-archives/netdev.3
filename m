Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606080;
	b=WuYwJpmN0prhg/qo37Eenkq7k77mcJ+/GrmKcicPTKGD68U2AfC1M1FTon5Fvt3iwR7c
	 YUs35Th1C4GVCcf7OE70LddOG0SdgZar+dymPvdtNei9nq0ryXqnRwH/8mRb8sj7YZxjK
	 6Kw5K/v7bjfkIxeRx3B8aECouS7VPEokD4aPJ4kmKR4zOYqWdSez/z3ZxJGCj3TlkMQZJ
	 7/n+gb/yPnUO4EinnUfeCWt3bvPrm4s+N4TkUVNU8iG3/S3wpf/SKtWNv8PYGxPzRH5Pl
	 t5rhXPghtpNLRp8q5UyE4iGBvSwBywg2pw7/yrIlnNPKnHG+rCLTYfJodRNgEIJAf3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606080;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=eTGcAizAcDDrkg1CZrd0OewU+209Qr7WPh/y5C1UCpM=;
	b=XBZLg72JHtr0mlfUqhJ5PaTVEZVCX8MG2kXLI2guLWmLihNtOpEIs+TEW8Hof8Cum/3s
	 4/3KRbWBg+nrGdFBATgKTSlD6dUf8ssX3xZNle7lnyr7TQwmEhajqtTPidVQ8YAbSCUn0
	 JN+JUQbdvnyVJxmI73ygmRjhKqvkzoIOBIqIJ2dNmA9JNYQybstvcyWF2TAOLaYU6lC2T
	 IFjEThWDmEp4lP8/34GF+00R+3ti6vRU0TBFqGNkoXTdHHr7mdR972ok2DM9yMIlP1WiT
	 DHdcI8tp6mbIU6KajNlrblvvaAiRjOoC7aOKLpbdz37M7TfY88to06D1UtqYhVivOZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nebula-matrix.com;
	spf=pass smtp.mailfrom=nebula-matrix.com;
	arc=none smtp.remote-ip=115.124.28.53
Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DFE606A324;
	Mon,  2 Nov 2026 07:54:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10DFE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.4052481|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.135047-0.0138827-0.85107;FP=16596272992148291472|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.jumCpT0_1793606067;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.jumCpT0_1793606067 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 02 Nov 2026 15:54:27 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v33 net-next 0/8] nbl driver for Nebulamatrix NICs
Date: Mon,  2 Nov 2026 15:54:01 +0800
Message-ID: <20261102075424.2165-1-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

changes v32->v33
Link to v32:https://lore.kernel.org/netdev/20261021062113.2158-1-illusion.wang@nebula-matrix.com/
changes v31->v32
Link to v31:https://lore.kernel.org/netdev/20261010095939.2230-1-illusion.wang@nebula-matrix.com/
changes v30->v31
Link to v30:https://lore.kernel.org/netdev/20260928123237.88994-1-illusion.wang@nebula-matrix.com/
1.AI review issues
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
 .../nbl/nbl_channel/nbl_channel.c             | 1528 +++++++++++++++++
 .../nbl/nbl_channel/nbl_channel.h             |  196 +++
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |   52 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   14 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   20 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      |  727 ++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |   55 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c |  671 ++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   23 +
 .../nebula-matrix/nbl/nbl_hw/nbl_chip.c       |   32 +
 .../nebula-matrix/nbl/nbl_hw/nbl_chip.h       |   12 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 1286 +++++++++++++-
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  342 ++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  370 ++++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   12 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |   33 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  |  851 +++++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |   21 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  157 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  159 ++
 .../nbl/nbl_include/nbl_def_channel.h         |  175 ++
 .../nbl/nbl_include/nbl_def_common.h          |   23 +
 .../nbl/nbl_include/nbl_def_dev.h             |   16 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |   83 +
 .../nbl/nbl_include/nbl_def_hw.h              |   80 +
 .../nbl/nbl_include/nbl_def_resource.h        |   38 +
 .../nbl/nbl_include/nbl_include.h             |   28 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  289 +++-
 29 files changed, 7280 insertions(+), 23 deletions(-)
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
2.51.0.windows.1

