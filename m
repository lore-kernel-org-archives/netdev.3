Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF08561FFE;
	Fri,  6 Feb 2026 02:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344622; cv=none; b=eeglw5hcHU8Nzm0LA39FhjIcLxSbqULSQBpx4bYPVFe67BXw8UPP/8uzonkoLNXGnmS5cw/f2Uln6CJG7E8fZLjFVXBAipVu50629COlcB4kR1jNwA1gFKAh5/2vf24Mk+xxN2LGFys79scac0wb/Ln9ja8iBp+fSQ3IkEudoRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344622; c=relaxed/simple;
	bh=R1RE0kAv+Fxj5p4anUrIoQsxpSMlD4p4lsH/ZoEiAs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KfIgacISCYgcVAl9oHhwoLRlXeG7oXjxzSff5yqFr2H0bhU2m5gaWQqVx+K+LsybRXB5qnc9CA2ruRqxAFZfjuRXWpjgBwveOnMEgL2x59IkrG5l7qRasocV/aZVnt0V8NOpaxr/blB7RZjiLANBA1fLYU1fHs69FPI3IsDTlvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gQHg4as_1770344289 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Feb 2026 10:18:10 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 net-next 00/11] nbl driver for Nebulamatrix NICs
Date: Fri,  6 Feb 2026 10:15:52 +0800
Message-ID: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series represents the first phase. We plan to integrate it in
two phases: the first phase covers mailbox and chip configuration,
while the second phase involves net dev configuration.
Together, they will provide basic PF-based Ethernet port transmission and
reception capabilities.

After that, we will consider other features, such as ethtool support,
flow management, adminq messaging, VF support, debugfs support, etc.

ps:The "nbl_core" issue has not been modified yet as it is still under discussion.
(https://lore.kernel.org/netdev/17d3aa72-23a8-4ea8-9721-bc20fe39fdf4.sam.chen@nebula-matrix.com/)
We will make the modification once a conclusion is reached.
Excluding patch 3,4, the total comes to about 5000 lines.

changes v3->v4
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
chanages v2 →v3
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

illusion.wang (11):
  net/nebula-matrix: add minimum nbl build framework
  net/nebula-matrix: add our driver architecture
  net/nebula-matrix: add chip related definitions
  net/nebula-matrix: channel msg value and msg struct
  net/nebula-matrix: add channel layer
  net/nebula-matrix: add common resource implementation
  net/nebula-matrix: add intr resource implementation
  net/nebula-matrix: add vsi resource implementation
  net/nebula-matrix: add Dispatch layer implementation
  net/nebula-matrix: add common/ctrl dev init/reinit operation
  net/nebula-matrix: add common dev start/stop operation

 .../device_drivers/ethernet/index.rst         |    1 +
 .../ethernet/nebula-matrix/m18100.rst         |   47 +
 MAINTAINERS                                   |   10 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/nebula-matrix/Kconfig    |   36 +
 drivers/net/ethernet/nebula-matrix/Makefile   |    6 +
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   22 +
 .../nbl/nbl_channel/nbl_channel.c             |  872 +++++
 .../nbl/nbl_channel/nbl_channel.h             |  159 +
 .../nebula-matrix/nbl/nbl_common/nbl_common.c |  227 ++
 .../nebula-matrix/nbl/nbl_common/nbl_common.h |   28 +
 .../net/ethernet/nebula-matrix/nbl/nbl_core.h |   84 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      |  472 +++
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |   53 +
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.c |  492 +++
 .../nebula-matrix/nbl/nbl_core/nbl_dispatch.h |   51 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw.h         |  128 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  |  765 +++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  | 1183 +++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c | 2902 +++++++++++++++++
 .../nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h |   12 +
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  292 ++
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   11 +
 .../nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h     |  131 +
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.c  |  233 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_interrupt.h  |   13 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.c   |  142 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |  128 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        |   54 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |   12 +
 .../nbl/nbl_include/nbl_def_channel.h         |  363 +++
 .../nbl/nbl_include/nbl_def_common.h          |  122 +
 .../nbl/nbl_include/nbl_def_dev.h             |   12 +
 .../nbl/nbl_include/nbl_def_dispatch.h        |   40 +
 .../nbl/nbl_include/nbl_def_hw.h              |   50 +
 .../nbl/nbl_include/nbl_def_resource.h        |   34 +
 .../nbl/nbl_include/nbl_include.h             |   81 +
 .../nbl/nbl_include/nbl_product_base.h        |   20 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |  320 ++
 40 files changed, 9610 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/nebula-matrix/m18100.rst
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
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_reg.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_interrupt.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dispatch.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_product_base.h
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

-- 
2.47.3

