Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.240.164.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794580368;
	b=cPyxjtFS3/a391hgUH+OEc3wydIR2BF5eZjA+LVTyZdA9ses2CwzojsqGYu/CqbAHBUZ
	 iitiWAjrCwPOa7yfqimzx9vA+LJh/A+yV1KsOkOg2Wq9XmeK2YpZnikUSYyKbatvxuyJ+
	 Fqzl84ASO8p1C6COsS2gpTWZXAT/GNKjYvP0Czbm6t6+ePxXuoOqAS7jd377wMHWcYhj5
	 dYxicjI6X1Pzgxlwgsq3pCgAova5nKX9fWtASpxN/Hwe/JunhM4kPPBx5oVwJRop1u0PY
	 GcX0+kGDwU1KeFmqOok+4nvFbtq6wCer871Dpo8nP4fUVrmTMrDm5yg84ku+M2QuK6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580368;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-Get-Message-Sender-Via:X-Authenticated-Sender:X-Source:
	 X-Source-Args:X-Source-Dir;
	bh=P6Zz8nLVr+CXWqX8BFHKnq5c+RvQQo6UVKKSWAKXWMA=;
	b=Glp8IcTneFZJ383CNlkSQ0oXmOBbfW79W4qPukk4ktrlI1b4V88cskM7EIZ+du00MIOH
	 0AvSgIi2X9NX1eYs00yXaFHUMOIY7k7QBd1jYBMpvZep5QtwI/h0cXJ9D0AHEQ3iaCP46
	 l97DbfuEw+4y9ImVCeoEZphwMh9vbcd+SgbI7zh0g55ytGhUMR+JJXCpOO+ooXewt04+x
	 tfZBlrA4bJr7ek5Gf1NDvIiO/f5ljE3aDnbYCE6ZoSw2LKVQi18Oce5WV2LnuftWdWPyK
	 8L/f1QYAV9u8qw4G+wczix0rV7pBkxx+C3RZTt2Jh9qcgmHvUsshm9L4qhvgVun0fDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=couthit.com;
	spf=pass smtp.mailfrom=couthit.com;
	dkim=pass header.d=couthit.com header.i=@couthit.com header.a=rsa-sha256 header.s=default header.b=ePefooXq;
	arc=none smtp.remote-ip=162.240.164.96
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521B606A32D;
	Fri, 13 Nov 2026 14:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A521B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=couthit.com header.i=@couthit.com header.a=rsa-sha256 header.s=default header.b=ePefooXq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=P6Zz8nLVr+CXWqX8BFHKnq5c+RvQQo6UVKKSWAKXWMA=; b=ePefooXqVjeiIv0mKuCVNYRIJ/
	qIDAFrlF7rZes8Kk0yE4v/ajxrNxt+23wOW67eown8UqSnRXI35aGkMaMh6xPk7ujCgW7rdyfwTkt
	/BBxnP6aozD2WHUeXd1c1UX7IuqK+WtGU6YkyzUhnCjGTu+BzzzNteX3cHMF8JUHlY0clVCp0vw69
	IHVfMzy7ccn57lB6Vqc1z1mmajXgkiI7WiMZIlVbO/H9sn+eFK+e1Oj6NVfBRLDmWtERvGV4rI0De
	Sll09hSh2rTjcY2e10tYuSmPkZPYfGP+Gjgl1/mpdLSXzCT0BNa7VTewvq3gGIM8/QMiKgCDZATAk
	cmgtCKkA==;
Received: from [115.246.246.98] (port=25118 helo=bulbasuar.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <saivarun@couthit.com>)
	id 1xRsKV-000000060PR-1L1r;
	Fri, 13 Nov 2026 09:32:40 -0500
From: Sai Varun Mudepally <saivarun@couthit.com>
To: danishanwar@ti.com,
	parvathi@couthit.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	vadim.fedorenko@linux.dev,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	afd@ti.com,
	basharath@couthit.com,
	arnd@arndb.de,
	haokexin@gmail.com
Cc: linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pratheesh@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	j-rameshbabu@ti.com,
	m-malladi@ti.com,
	rogerq@ti.com,
	krishna@couthit.com,
	mohan@couthit.com,
	saivarun@couthit.com
Subject: [PATCH net-next v6 0/3] Introduce HSR/PRP HW offload support for PRU-ICSSM Ethernet driver
Date: Fri, 13 Nov 2026 19:58:21 +0530
Message-ID: <20261113143127.282466-1-saivarun@couthit.com>
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
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: saivarun@couthit.com
X-Authenticated-Sender: server.couthit.com: saivarun@couthit.com
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
      ethtool -K eth1 hsr-fwd-offload on
      ethtool -K eth1 hsr-dup-offload on
      ethtool -K eth1 hsr-tag-rm-offload on

      ethtool -K eth2 hsr-fwd-offload on
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
      ethtool -K eth1 hsr-fwd-offload off
      ethtool -K eth1 hsr-dup-offload off
      ethtool -K eth1 hsr-tag-rm-offload off

      ethtool -K eth2 hsr-fwd-offload off
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
  hsr-fwd-offload, hsr-tag-rm-offload and hsr-dup-offload are tightly coupled in the
  firmware implementation. All need to be enabled / disabled together and
  hsr-tag-ins-offload is unsupported.

This is the v6 of the patch series [v1]. This version of the patchset addresses the
comments made on [v5] of the series.

Changes from v5 to v6 :

*) Addressed eleven Sashiko AI review comments which required code changes.
*) There are four Sashiko AI review comments which are false positives:
   Patch 1:
   - Comment : "In LRE mode, icssm_emac_mc_filter_ctrl/reset/hashmask/bin_update all redirect
               `ram`..."
     Reason  : The HSR core syncs the master's multicast list and IFF_ALLMULTI to both slaves,
               so the shared filter always reflects the HSR device. Multicast must be configured
               on the HSR device, not on an individual slave.
   - Comment : "icssm_prueth_lre_timer() calls hrtimer_forward_now() and returns early unless
               `prueth->emac_configured == BIT(MII0)|BIT(MII1)`..."
     Reason  : emac_configured tracks admin state (ndo_open/ndo_stop), not link state, so link
               loss does not affect it. The table-check write is skipped only while a slave is
               admin down, which is not a redundant HSR/PRP setup. Stale entries age out once it
               is back up.
   - Comment : "icssm_prueth_lre_protocol_init() always writes ICSS_LRE_SUP_ADDRESS_INIT_OCTETS_HIGH
               (0x4E1501) and _LOW (0x1) to..."
     Reason  : The PRU firmware matches only the first five octets of the supervision address
               (01:15:4E:00:01) and ignores the last octet. Matching frames are classified as
               supervision and passed to the host regardless of the multicast filter configuration.
   Patch 3:
   - Comment : "In LRE mode, icssm_prueth_tx_enqueue() finds the L2 header with skb_mac_header(skb)
               instead of skb->data."
     Reason  : The driver does not support XDP; in HSR/PRP mode the slave ports only transmit
               frames from the HSR/PRP master, where the MAC header is always set.

*) There are two pre-existing issues which will be addressed in seperate patches.
   - [High] icssm_prueth_change_mode() calls ndo_stop()/ndo_open() directly and never calls
     dev_close().
   - [Medium] icssm_prueth_tx_enqueue() cannot tell a full ring from an empty one.

*) There are four other comments related to pre-existing issues which will be addressed by a
   separate patch.
   Patch 1:
   - [Medium] Mode changes are not synchronised with multicast-filter programming.
   Patch 2:
   - [High] The new 'do not restart TX during teardown' logic is a check-then-act sequence with
     no lock or ordering against ndo_stop().
   - [Low] This feature patch also carries a fix for an existing bug, with no Fixes: tag.
   Patch 3:
   - [Medium] The TX path now reads prueth->eth_type (through prueth_is_lre()) several times with
     no synchronisation.

*) Rebased the series onto the latest net-next.

Changes from v4 to v5 :

*) Addressed 3 shashiko AI review comments which required code changes.
*) There are four comments which are false positives:
   - Shared NAPI is initialized and used only when both MII0 and MII1 are present. If MII0
     is absent, the device remains in EMAC mode and uses the per-port NAPI.
   - The shared RX IRQ handler is registered only in SWITCH/HSR/PRP modes and with MII0 absent,
     EMAC mode uses the per-port IRQ handler instead.
   - HSR packet TX duplication (hsr-dup-offload) and tag removal (hsr-tag-rm-offload) are
     unconditional by design because HSR mode is entered only when the HSR offload features are
     enabled. Otherwise, the device stays in EMAC mode and the HSR core handles these operations
     in software.
*) There is one pre-existing comment related to the VLAN tag check in the TX path which will be
   addressed in a separate series.
*) Rebased the series onto the latest net-next.

Changes from v3 to v4 :

*) Addressed 27 sashiko AI review comments that required code changes in this series.
*) There are three pre-existing sashiko comments that are not introduced by this series:
   - FDB learning can sleep in softirq context
   - mode changes can bypass normal network state synchronization
   - allocation failure can leave the RX descriptor unadvanced, potentially causing
     repeated interrupts.
   These will be addressed in a separate series.
*) There are four comments which are false positives:
   - NETIF_F_HW_HSR_DUP is for TX duplication, not RX duplicate discard, and is added in patch 3.
   - The __packed comment is not applicable since C packing rules already handle this structure, as
     noted in feedback on an earlier series (https://lore.kernel.org/all/20250708175301.599c82b8@kernel.org/).
   - The LRE timer check depends on interface admin state, not link state, and both interfaces
     are expected to remain up for HSR/PRP.
   - atomic64_t is used to safely update statistics from the RX/TX paths, and the associated overhead
     does not cause a performance regression in this context.
*) Rebased the series onto the latest net-next.

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
[v3] https://lore.kernel.org/all/20260804121644.465118-1-parvathi@couthit.com/
[v4] https://lore.kernel.org/all/20260921134343.200426-1-parvathi@couthit.com/
[v5] https://lore.kernel.org/all/20261005154654.576663-1-parvathi@couthit.com/

Thanks and Regards,
Sai Varun Mudepally.

Roger Quadros (3):
  net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for
    AM57xx, AM437x and AM335x
  net: ti: icssm-prueth: Add priority based RX IRQ handlers
  net: ti: icssm-prueth: Support duplicate HW offload feature for HSR
    and PRP

 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/Makefile              |   2 +-
 .../ethernet/ti/icssm/icssm_lre_firmware.h    | 141 +++
 drivers/net/ethernet/ti/icssm/icssm_prueth.c  | 802 ++++++++++++++++--
 drivers/net/ethernet/ti/icssm/icssm_prueth.h  |  89 +-
 .../ethernet/ti/icssm/icssm_prueth_common.c   | 338 ++++++++
 .../net/ethernet/ti/icssm/icssm_prueth_lre.c  | 229 +++++
 .../net/ethernet/ti/icssm/icssm_prueth_lre.h  |  19 +
 .../ethernet/ti/icssm/icssm_prueth_switch.c   | 333 +++++++-
 .../ethernet/ti/icssm/icssm_prueth_switch.h   |   2 +
 drivers/net/ethernet/ti/icssm/icssm_switch.h  |  40 +-
 11 files changed, 1881 insertions(+), 115 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_lre_firmware.h
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
 create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_lre.h

-- 
2.43.0

