Received: from out28-98.mail.aliyun.com (out28-98.mail.aliyun.com [115.124.28.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD22D7BF;
	Wed, 19 Aug 2026 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787098341; cv=none; b=oHewhVCZOywQpB0LD43etbmff0jF8Ng1w9w3YKwBxN0tN6VV+5L0g6jRIA69H+OqZ70cQLXYJi11AmjU9mF/dyZIpyIduCawXzPTZbJxHpK6pv2pIneP0um5P9fwdKQI3H4SBF3SbBkAOmY8wrmlSc2d1X5swbK1Jxv4f0gRuGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787098341; c=relaxed/simple;
	bh=m0v/jcgBu/8PQ++KzvRZewUKFxqJUgELDtxkexvexCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sO/RUcxN/exgg31O2EdJrmvzx+DCJxK7iNr8fTcUpDEHkTyhEyG8iqxQ3f1CNNescwK1LjEGhuloz3DDj4RSc5dtoM+o3rCeAcntXFM3lFCdV7+QUgPZFRk7bOMeWwOnUIEV4iPqQsDc9+K/e2IObsKaCnw8riJ/3H1ZNC5doVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06844582|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.141809-0.0120438-0.846147;FP=2770204692289439250|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iqi7nKr_1787098326;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iqi7nKr_1787098326 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 08:12:07 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v25 net-next 00/10] nbl driver for Nebulamatrix NICs
Date: Wed, 19 Aug 2026 08:11:02 +0800
Message-ID: <20260819001117.46785-1-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: illusion wang <illusion.wang@nebula-matrix.com>

This patch series represents the first phase. We plan to integrate it in
two phases: the first phase covers mailbox and chip configuration,
while the second phase involves net dev configuration.
Together, they will provide basic PF-based Ethernet port transmission and
reception capabilities.

After that, we will consider other features, such as ethtool support,
flow management, adminq messaging, VF support, debugfs support, etc.

To ensure compatibility, our architecture is divided into the following
layers:

1. Dev Layer (Device Layer)
The top-level business logic layer where all operations are
device-centric. Every operation is performed relative to the device
context. The intergration of base functions encompasses:
management(ctrl only for leonis pf0), network(net_dev,this time not
contained),common.

2. Dispatch Layer
The distribution from services to specific data operations is mainly
divided into two types: direct pass-through and handling by the
management PF. It shields the upper layer from the differences in
specific underlying locations.
It describes the processing locations and paths of the services.

3. Resource Layer
Handles tasks dispatched from Dispatch Layer. These tasks fall into two
categories:
3.1 Hardware control
The Resource Layer further invokes the HW Layer when hardware access is
needed, as only the HW Layer has OS-level privileges.
3.2 Software resource management
Operations like packet statistics collection that don't require hardware
access.

4. HW Layer (Hardware Layer)
Serves the Resource Layer by interacting with different hardware
chipsets.Writes to hardware registers to drive the hardware based on
Resource Layer directives.

5. Channel Layer

Handle communication between PF0(has ctrl func) and other PF,and provide
basic interaction channels.

6. Common Layer
Provides fundamental services

changes v24->v25
Link to v24:https://lore.kernel.org/netdev/20260807044422.2356-1-illusion.wang@nebula-matrix.com/
1.AI review issues

2.Issues found by Jakub
changes v23->v24
Link to v23:https://lore.kernel.org/netdev/20260731094242.2655-1-illusion.wang@nebula-matrix.com/
1.AI review issues
2.Issues found by Jakub

changes v22->v23
Link to v22:https://lore.kernel.org/netdev/20260723040110.91410-1-illusion.wang@nebula-matrix.com/
AI review issues

chages v21->v22
Link to v21:https://lore.kernel.org/netdev/20260708064742.35391-1-illusion.wang@nebula-matrix.com/
AI review issues

changes v20->v21
Link to v20:https://lore.kernel.org/netdev/20260630010718.4346-1-illusion.wang@nebula-matrix.com/
I have dropped the old Patch 2 titled "add our driver architecture"
Add new Patch 2 "add core driver architecture and HW layer initialization".
Split original patch8 into three separate patches as suggested

changes v19->v20
Link to v19:https://lore.kernel.org/netdev/20260617044702.2439-1-illusion.wang@nebula-matrix.com/
Starting from V20, I have dropped the old Patch 3 titled "P4
configuration invoked during chip initialization". This functionality
will be reimplemented in next phase using the request_firmware() API
with an external firmware blob.
changes v18->v19
Link to v18:https://lore.kernel.org/netdev/20260611044916.2383-1-illusion.wang@nebula-matrix.com/
changes v17->v18
Link to v17:https://lore.kernel.org/netdev/20260601093149.25905-1-illusion.wang@nebula-matrix.com/
changes v16->v17
Link to v16:https://lore.kernel.org/netdev/20260526035453.2359-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v15->v16
Link to v15:https://lore.kernel.org/netdev/20260520032950.4874-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v14->v15
Link to v14:https://lore.kernel.org/netdev/20260513011649.4404-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v13->v14
Link to v13:https://lore.kernel.org/netdev/20260428114910.2616-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v12->v13
Link to v12:https://lore.kernel.org/netdev/20260415033608.2438-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v11->v12
Link to v11:https://lore.kernel.org/netdev/20260408093739.56001-1-illusion.wang@nebula-matrix.com/
AI review issues
changes v10->v11
Link to v10:https://lore.kernel.org/netdev/20260401022318.28550-1-illusion.wang@nebula-matrix.com/
1.Issues found by Mohsin
2.AI review issues
changes v9->v10
Link to v9:https://lore.kernel.org/netdev/20260325040048.2313-1-illusion.wang@nebula-matrix.com/
1.Issues found by Jakub
2.AI review issue
changes v8->v9
Link to v8:https://lore.kernel.org/netdev/20260317034533.5600-1-illusion.wang@nebula-matrix.com/
1.Issues found by Jakub
2.AI review issue
Changes v7→v8
Link to v7:https://lore.kernel.org/netdev/20260310120959.22015-1-illusion.wang@nebula-matrix.com/
1.Issues found by Paolo
Changes v6->v7
Link to v6:https://lore.kernel.org/netdev/20260306033451.5196-1-illusion.wang@nebula-matrix.com/
1.Issue found by Jakub
2.AI review issue
Changes v5->v6
Link to V5:https://lore.kernel.org/netdev/20260226073840.3222-1-illusion.wang@nebula-matrix.com/
1.put all standard linux includes files the .c file which needs it & others
--Andrew
2.AI review issue
Changes v4->v5
Link to V4:https://lore.kernel.org/netdev/20260206021608.85381-1-illusion.wang@nebula-matrix.com/
1.change nbl_core to nbl & change ** pointers to *pointers & others
--Andrew
2.AI review issue
Changes v3->v4
Link to v3: https://lore.kernel.org/netdev/20260123011804.31263-1-illusion.wang@nebula-matrix.com
1.cut down to part of a mini driver(mailbox and chip init)
--Jakub Kicinski Simon Horman(some sort of staged approached)
2.modify issues found by ai.
3. Reverse Christmas tree/nbl_err/devm_kfree/remove some macros/
void type to real type/others
--Andrew Lunn
4.change deprecated pci_enable_msix_range to pci_alloc_irq_vectors
5.delete service layer
6.the style of kconfig---Randy Dunlap
7.add to Documentation/networking/device_drivers/ethernet/index.rst
--Simon Horman
Changes v2 →v3
Link to v2: https://lore.kernel.org/netdev/20260109100146.63569-1-illusion.wang@nebula-matrix.com/
1.cut down to a mini driver:
    delete vf support
    use promisc mode to cut down flow management
    drop patch15 in v2
    delete adminq msg
    delete abnormal handling
    delete some unimportant interfaces
2.modify issues found by ai review
Changes v1->v2
Link to v1: https://lore.kernel.org/netdev/20251223035113.31122-1-illusion.wang@nebula-matrix.com/
1.Format Issues and Compilation Issues
- Paolo Abeni
2.add sysfs patch and drop coexisting patch
- Andrew Lunn
3.delete some unimportant ndo operations
4.add machine generated headers patch
5.Modify the issues found in patch1-2 and apply the same fixes to other
patches
6.modify issues found by nipa

illusion wang (10):
  net/nebula-matrix: add minimum nbl build framework
  net/nebula-matrix: add core driver architecture and HW layer
    initialization
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

 .../device_drivers/ethernet/index.rst         |    1 +
 .../ethernet/nebula-matrix/nbl.rst            |   28 +
 MAINTAINERS                                   |   10 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/nebula-matrix/Kconfig    |   31 +
 drivers/net/ethernet/nebula-matrix/Makefile   |    6 +
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   15 +
 .../nbl/nbl_channel/nbl_channel.c             | 1194 +++++++++++++++++
 .../nbl/nbl_channel/nbl_channel.h             |  170 +++
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  224 ++++
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   32 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   45 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      |  503 +++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |   57 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c |  639 +++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   25 +
 .../nebula-matrix/nbl/nbl_hw/nbl_chip.c       |   23 +
 .../nebula-matrix/nbl/nbl_hw/nbl_chip.h       |   12 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 1084 +++++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  352 +++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  345 +++++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   12 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |   77 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  |  402 ++++++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |   21 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  150 +++
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  109 ++
 .../nbl/nbl_include/nbl_def_channel.h         |  182 +++
 .../nbl/nbl_include/nbl_def_common.h          |   69 +
 .../nbl/nbl_include/nbl_def_dev.h             |   16 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |   57 +
 .../nbl/nbl_include/nbl_def_hw.h              |   68 +
 .../nbl/nbl_include/nbl_def_resource.h        |   38 +
 .../nbl/nbl_include/nbl_include.h             |   55 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  243 ++++
 36 files changed, 6297 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
 create mode 100644 drivers/net/ethernet/nebula-matrix/Kconfig
 create mode 100644 drivers/net/ethernet/nebula-matrix/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/Makefile
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_common/nbl_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_chip.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

-- 
2.47.3

