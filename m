Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065E03CB56F;
	Tue,  4 Aug 2026 12:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847506; cv=none; b=HNyUyAsXgeA58xtYDPV7RiXEArGMkLgLktY0+397u4UrbWFnQDGi1RmHZCFRh6y/q+TRE+wMUT5KEdoPSxEhnNQ2MVOhHaH8k4UfOhD7HjtxPxqdiE3vZqqO1fS2K76GuiF3a3c9mNPs+19Sq5LcAPgrtRvNguxLr0ecva48A/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847506; c=relaxed/simple;
	bh=fEs8xpQxyinkhxUND1PkUDM4E6aq1y4+e15DcEvfKjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THqwjOqbynDzclbM40XwQkyLNx9JKvzJV7FrY3U8+JthskCUvxZbOwY6rljecnvl/CVRTKRPQPuAdIeKQjdRmJ3uUMuPo5Z/hU7x82WoJZUczhXhtay5qPpIeiTCluJo0hCaVMoVZElhmKdqJ5IsNrgwZ238d6N3LF9SR2TLj7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=gXHBObGR; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="gXHBObGR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+dm10zh0RVgzNHIcGKbfMg0byJkvtvWhc/QSPrzufu0=; b=gXHBObGRzCtrJ0rLxu5I2IlYQt
	UaLJxUk5AD5guztzi5db9rgE0HQcHxvBBz+nEkwDC2UxCN+dsFaFI+mPTTSJGglA/KrahE9GXwrl4
	5Mr6evCmjelGe2xgz5ruygabV/+sO3NG2zbsaK1He2qXKyB+LN6N5/+dTwjm1dsZaJuj4ijUM0/y2
	2xizdMlKgKDSUiw1Vv3OFa5pmPDwMKeDSsfwAmXi1eynomFW7yVTppvYy8ReH8KsHxq/EG3rA+fIO
	pbb4GCKDvhfj524eoI1F6BlXKnJAwLjW7x+bekhvb6TH/t0fca+ZAd58g6lyIc8p/uG9709Q96IfN
	BjevO35g==;
Received: from [115.246.246.98] (port=43717 helo=cypher.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <parvathi@couthit.com>)
	id 1wrE54-00000005dIg-0o59;
	Tue, 04 Aug 2026 08:17:14 -0400
From: Parvathi Pudi <parvathi@couthit.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
	basharath@couthit.com,
	arnd@arndb.de
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: [PATCH net-next v3 0/3] Introduce HSR/PRP HW offload support for PRU-ICSSM Ethernet driver
Date: Tue,  4 Aug 2026 17:44:48 +0530
Message-ID: <20260804121644.465118-1-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

This series introduces HSR and PRP protocol HW offload support for ICSSM-Prueth driver.
HW offload support for HSR/PRP is implemented using dedicated HSR/PRP firmware running
on 2 PRU cores(PRU-ICSS) as a "DAN" available in AM57xx, AM437x and AM335x.

The following features are offloaded to HW in case of HSR and PRP:
1. L2 forwarding of a HSR frame via traditional store and forward or via cut-through (only for HSR)
2. Transmit frame duplication is offloaded to HW
3. Tag removal on the receive is offloaded to HW
4. Redundant duplicate packet discard on the receive is also offloaded to HW

In HW offload mode, redundant tag insertion in the transmit path will be still done by HSR driver
and firmware updates the LAN information available in the tag on the fly when PRU is transmitting
frame in that respective LAN.

HSR Test Setup:
--------------

     ___________           ______________           ___________
    |           | Link AB |              | Link BC |           |
  __|   AM57*   |_________|AM57/AM43/AM33|_________|   AM57*   |___
 |  | Station A |         |   Station B  |         | Station C |   |
 |  |___________|         |______________|         |___________|   |
 |                                                                 |
 |_________________________________________________________________|
                            Link CA

Steps to switch to HSR forward offload mode:
-------------------------------------------------
Example assuming eth1, eth2 ports of ICSSM on AM57x, AM437x and AM335x EVM's

  1) Bring down both slave interfaces
      ip link set eth1 down
      ip link set eth2 down

  2) Set matching MAC addresses on both slave interfaces
      ip link set eth1 address <mac-addr>
      ip link set eth2 address <mac-addr>

  3) Enable HSR offload for both interfaces
      ethtool -K eth1 hsr-fwd-offload on
      ethtool -K eth1 hsr-dup-offload on
      ethtool -K eth1 hsr-tag-rm-offload on

      ethtool -K eth2 hsr-fwd-offload on
      ethtool -K eth2 hsr-dup-offload on
      ethtool -K eth2 hsr-tag-rm-offload on

  4) Create HSR interface and add slave interfaces to it
      ip link add name hsr0 type hsr slave1 eth1 slave2 eth2 \
    supervision 45 version 1

  5) Add IP address to the HSR interface
      ip addr add <IP_ADDR>/24 dev hsr0

  6) Bring up the HSR interface
      ip link set hsr0 up

  7) Bring up the both slave ports
      ip link set eth1 up
      ip link set eth2 up

Switching back to default mode:
--------------------------------
  1) Bring down both slave interfaces
      ip link set eth1 down
      ip link set eth2 down

  2) Delete HSR interface
      ip link delete hsr0

  3) Disable HSR port-to-port offloading mode, packet duplication
      ethtool -K eth1 hsr-fwd-offload off
      ethtool -K eth1 hsr-dup-offload off
      ethtool -K eth1 hsr-tag-rm-offload off

      ethtool -K eth2 hsr-fwd-offload off
      ethtool -K eth2 hsr-dup-offload off
      ethtool -K eth2 hsr-tag-rm-offload off

Testing the port-to-port frame forward offload feature:
-------------------------------------------------------
  1) Connect the LAN cables as shown in the test setup.
  2) Configure Station A and Station C in HSR non-offload mode.
  3) Configure Station B is HSR offload mode.
  4) Since HSR is a redundancy protocol, disconnect cable "Link CA",
     to ensure frames from Station A reach Station C only through
     Station B.
  5) Run iperf3 Server on Station C and client on station A.
  7) Check the CPU usage on Station B.

CPU usage report on Station B using mpstat when running UDP iperf3:
-------------------------------------------------------------------

AM57xx
------

  1) Non-Offload case
  -------------------
  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
  all    0.00    0.00    0.00    0.00    0.00   10.41    0.00    0.00   89.59
    0    0.00    0.00    0.00    0.00    0.00   20.88    0.00    0.00   79.12
    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00

  2) Offload case
  ---------------
  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
  all    0.00    0.00    0.10    0.00    0.00    0.73    0.00    0.00   99.17
    0    0.00    0.00    0.20    0.00    0.00    1.46    0.00    0.00   98.34
    1    0.00    0.00    0.00    0.00    0.00    0.00    0.00    0.00  100.00

AM437x
------

  1) Non-Offload case
  -------------------
  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
  all    0.30    0.00    0.80    0.00    0.00   35.19    0.00    0.00   63.72
    0    0.30    0.00    0.80    0.00    0.00   35.19    0.00    0.00   63.72

  2) Offload case
  ---------------
  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
  all    0.10    0.00    0.31    0.10    0.00    1.74    0.00    0.00   97.75
    0    0.10    0.00    0.31    0.10    0.00    1.74    0.00    0.00   97.75

AM335x
------

  1) Non Offload case
  -------------------
  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
  all    0.30    0.00    1.10    0.00    0.00   90.32    0.00    0.00    8.28
    0    0.30    0.00    1.10    0.00    0.00   90.32    0.00    0.00    8.28

  2) Offload case
  ---------------
  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest   %idle
  all    0.43    0.00    3.61    0.00    0.00   13.28    0.00    0.00   82.68
    0    0.43    0.00    3.61    0.00    0.00   13.28    0.00    0.00   82.68

PRP Test Setup:
---------------

     _________________        LAN-A        __________________
    |                 |eth1-----------eth1|                  |
    | AM57/AM437/AM335|                   | AM57/AM437/AM335 |
    |    station A    |eth2-----------eth2|    station B     |
    |_________________|       LAN-B       |__________________|

Steps to switch to PRP offload mode:
------------------------------------
Example assuming eth1, eth2 ports of ICSSM on AM57x, AM437x and AM335x EVM's

  1) Bring down both slave interfaces
      ip link set eth1 down
      ip link set eth2 down

  2) Set matching MAC addresses on both slave interfaces
      ip link set eth1 address <mac-addr>
      ip link set eth2 address <mac-addr>

  3) Enable PRP offload for both interfaces
      ethtool -K eth1 hsr-dup-offload on
      ethtool -K eth1 hsr-tag-rm-offload on

      ethtool -K eth2 hsr-dup-offload on
      ethtool -K eth2 hsr-tag-rm-offload on

  4) Create PRP interface and add slave interfaces to it
      ip link add name prp0 type hsr slave1 eth1 slave2 eth2 \
    supervision 45 proto 1

  5) Add IP address to the PRP interface
      ip addr add <IP_ADDR>/24 dev prp0

  6) Bring up the PRP interface
      ip link set prp0 up

  7) Bring up the both slave ports
      ip link set eth1 up
      ip link set eth2 up

Switching back to default mode:
--------------------------------
  1) Bring down both slave interfaces
      ip link set eth1 down
      ip link set eth2 down

  2) Delete PRP interface
      ip link delete prp0

  3) Disable PRP offloading mode
      ethtool -K eth1 hsr-dup-offload off
      ethtool -K eth1 hsr-tag-rm-offload off

      ethtool -K eth2 hsr-dup-offload off
      ethtool -K eth2 hsr-tag-rm-offload off

Testing the PRP offload feature:
--------------------------------
  1) Connect eth1 of Station A to eth1 of Station B (LAN-A).
     Connect eth2 of Station A to eth2 of Station B (LAN-B).
  2) Configure Station A in PRP non-offload mode.
  3) Configure Station B in PRP offload mode.
  4) Run iperf3 Server on Station B and client on Station A.
  5) Check the CPU usage on Station B.
  6) Disconnect LAN-B cable to verify Station A frames still reach
     Station B over LAN-A with no traffic interruption.
  7) Reconnect LAN-B and disconnect LAN-A, verify the same.

CPU usage report on Station B using mpstat when running UDP iperf3:
-------------------------------------------------------------------

AM57x
-----

  1) Non Offload case
  -------------------
  CPU    %usr   %nice    %sys  %iowait    %irq   %soft  %steal  %guest   %idle
  all    2.04    0.00   18.85    0.00     0.00   27.83    0.00    0.00   51.27
    0    1.80    0.00   21.56    0.00     0.00   54.89    0.00    0.00   21.76
    1    2.29    0.00   16.14    0.00     0.00    0.80    0.00    0.00   80.78

  2) Offload case
  ---------------
  CPU    %usr   %nice    %sys  %iowait    %irq   %soft  %steal  %guest   %idle
  all    2.79    0.00   18.36    0.00     0.00   18.16    0.00    0.00   60.68
    0    3.89    0.00   22.16    0.00     0.00   36.13    0.00    0.00   37.82
    1    1.69    0.00   14.56    0.00     0.00    0.20    0.00    0.00   83.55

AM437x
------

  1) Non Offload case
  -------------------
  CPU    %usr   %nice    %sys   %iowait  %irq   %soft    %steal  %guest   %idle
  all    5.68    0.00    43.27   0.00    0.00    43.57    0.00     0.00    7.48
    0    5.68    0.00    43.27   0.00    0.00    43.57    0.00     0.00    7.48

  2) Offload case
  ---------------
  CPU    %usr   %nice    %sys   %iowait  %irq   %soft    %steal  %guest   %idle
  all    6.39    0.00    42.86   0.00    0.00   32.57    0.00      0.00   18.18
    0    6.39    0.00    42.86   0.00    0.00   32.57    0.00      0.00   18.18

AM335x
------

  1) Non Offload case
  -------------------
  CPU    %usr   %nice    %sys    %iowait  %irq   %soft    %steal  %guest   %idle
  all    2.29    0.00    14.04    0.00    0.00    75.50    0.00    0.00    8.17
    0    2.29    0.00    14.04    0.00    0.00    75.50    0.00    0.00    8.17

  2) Offload case
  ---------------
  CPU    %usr   %nice    %sys    %iowait  %irq   %soft    %steal  %guest   %idle
  all    5.70    0.00    48.50    0.00    0.00    29.00    0.00    0.00    16.80
    0    5.70    0.00    48.50    0.00    0.00    29.00    0.00    0.00    16.80

Note:
  hsr-tag-rm-offload and hsr-dup-offload are tightly coupled in the firmware implementation.
  They both need to be enabled / disabled together and hsr-tag-ins-offload is unsupported.

This is the v3 of the patch series [v1]. This version of the patchset addresses the
comments made on [v2] of the series.

Changes from v2 to v3 :

*) Addressed the 8 Sashiko AI review comments that required code changes in this series.
*) Identified 4 Sashiko AI review comments as false positives and replied accordingly.
*) The remaining 7 comments correspond to pre-existing issues and will be addressed separately.
*) Rebased the series onto the latest net-next.

Changes from v1 to v2 :

*) Fixed all applicable issues, except for the false positives flagged by the AI review
on sashiko.dev.
*) Addressed Jakub Kicinski comments on patch 3 of the series.
*) Rebased the series on latest net-next.

[v1] https://lore.kernel.org/all/20260611123636.376577-1-parvathi@couthit.com/
[v2] https://lore.kernel.org/all/20260630124958.894360-1-parvathi@couthit.com/

Thanks and Regards,
Parvathi.

Roger Quadros (3):
  net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for
    AM57xx, AM437x and AM335x
  net: ti: icssm-prueth: Add priority based RX IRQ handlers
  net: ti: icssm-prueth: Support duplicate HW offload feature for HSR
    and PRP

 drivers/net/ethernet/ti/Makefile              |   2 +-
 .../ethernet/ti/icssm/icssm_lre_firmware.h    | 141 ++++
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 764 ++++++++++++++++--
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |  87 +-
 .../ethernet/ti/icssm/icssm_prueth_common.c   | 278 +++++++
 .../net/ethernet/ti/icssm/icssm_prueth_lre.c  | 224 +++++
 .../net/ethernet/ti/icssm/icssm_prueth_lre.h  |  19 +
 .../ethernet/ti/icssm/icssm_prueth_switch.c   | 318 +++++++-
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |   2 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  41 +-
 10 files changed, 1787 insertions(+), 89 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_lre_firmware.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_lre.h

-- 
2.43.0

