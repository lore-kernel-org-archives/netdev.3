Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02F22D7A1
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785965750; cv=none; b=CKYjFTuJ8F+lRXBxvveVUJMoJXX0KE341BP5RMnHbBTmxy55Sskqr96nEypI0ZPd3BdYDuBTnUHg0cioBlI2166hpPZnYAxaudKXmLKbnl1zD4UGfbJEwDPxbHC0KFzGj0S7AqSVUzjMKpZUNfV3j8DwROoeLERf7sWwv/11HmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785965750; c=relaxed/simple;
	bh=sCjBPT3UqsJ/ZQysuFDu4jMQZjoK1NUfKhxY/X4i07E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=No9CltpDxNuOJxw7OpGShVvMkMLJqkqcvpm21a7g9nGDmqhfZnniHWbKGswgxNfXe2Jt2+4+J1ZIcpH73vapE/ftyAarRpPl4jEhtbC2sFQiah+wW3wGjwzGZMHfuN4/OWLYIq246LTLrEUDyJ5es2ZtrYTXjhgQQvJUJ5iPGDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/mIFh8X; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/mIFh8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785965747; x=1817501747;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sCjBPT3UqsJ/ZQysuFDu4jMQZjoK1NUfKhxY/X4i07E=;
  b=H/mIFh8Xc5Os1UhJK3tUuh5WgfPPFkZmF2i011fVscWcABa5QXldKZqz
   iixWJJdI/snvn9P/CitjytYtkkrmaJ1thpbgAD1ozyRagUBVfInV0gK7F
   JCW5hNBkQTb1VipkUj90zllOme5R60qRtecfYnNlX9FK5QoVod1Cz7Ni2
   HLDHzFjYxf+Aqg6zynBcad9ZIE8MgNEhYq+PtsMiqrwSlvwEiAJ1AQF29
   ugWbWkHHHKmZz7MaXrFpi9P3pP4A4WCSrcnfKXs0EhkqApnGZs+DgSXji
   JKLUi0ZUwLYkSsEiR7IAX04mma0mc2dKNR4jAbSHceWm79g6hPbcNy3DL
   Q==;
X-CSE-ConnectionGUID: 7o8gw2oMTKaMoy04XaOiTg==
X-CSE-MsgGUID: LuO5+5bPSPOQiUFJZ0xQhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109343482"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="109343482"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 14:35:47 -0700
X-CSE-ConnectionGUID: ECN35FPyS9KwypqCSjhTBA==
X-CSE-MsgGUID: coXdVBikQb+E53copCT8kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="286576036"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 05 Aug 2026 14:35:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates 2026-08-05 (ice, i40e, igc, e1000e)
Date: Wed,  5 Aug 2026 14:35:25 -0700
Message-ID: <20260805213541.2281287-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Arkadiusz adds support for an unmanaged DPLL interface on E830 devices.
Enabling users to check the DPLL lock status and obtain relevant
configuration information through the DPLL netlink, even though the
physical DPLL settings are hard coded within the hardware.

Michal resolves issue with checksum advertisement and handling with
extension headers.

Alex expands support to allow for VLAN ethertype 0x88E7 for IEEE 802.1ah
B-TAG support and adjusts interrupt moderation rate for other interrupts
to reduce latency of timestamps and mailbox messages.

Grzegorz reduces DSCP error message to debug as it is expected in this
situation.

Marcin replaces open coded copy of ethernet header to use an, existing,
helper.

Przemek adds trace event for Rx timestamps to aid in debugging.

For i40e:
Kohei Enju adds support for XDP metadata of Rx hash and VLAN tag.

Chris Packham reduces frequency of overflow Rx filter warning to occur
when promiscuous mode is enabled as a result of the condition.

For igc:
Dima adds support for setting of ACPI-based MAC address.

For e1000e:
Matt Vollrath improves Rx performance by eliminating unnecessary DMA
re-mapping when recycled buffers are reused after copybreak or errors.

The following are changes since commit a23b36233d4103def55dc8cf65698106d0bd1e62:
  Merge branch 'bnge-add-more-functionality'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Aleksandr Loktionov (3):
  virtchnl: add VIRTCHNL_VLAN_ETHERTYPE_88E7 support
  ice: add 0x88E7 handling to SW validation paths
  ice: increase OICR interrupt moderation rate to 20K interrupts/sec

Arkadiusz Kubalewski (1):
  ice: add support for unmanaged DPLL on E830 NIC

Chris Packham (1):
  i40e: Avoid repeating RX filter warning

Dima Ruinskiy (1):
  igc: Support ACPI-based MAC pass-through

Grzegorz Nitka (1):
  ice: reduce loglevel to debug for 'Can't delete DSCP' message

Kohei Enju (3):
  i40e: prepare for XDP metadata ops support
  i40e: add support for bpf_xdp_metadata_rx_hash()
  i40e: add support for bpf_xdp_metadata_rx_vlan_tag()

Marcin Szycik (1):
  ice: use ice_fill_eth_hdr() in ice_fill_sw_rule()

Matt Vollrath (1):
  e1000e: Avoid DMA re-mapping on RX copybreak

Michal Swiatkowski (2):
  ice: always do GCS if hardware supports it
  ice: use NETIF_F_HW_CSUM instead of IP/IPV6

Przemyslaw Korba (1):
  ice: add rx timestamp tracepoint for debugging

 .../device_drivers/ethernet/intel/ice.rst     |  80 +++++
 drivers/net/ethernet/intel/e1000e/netdev.c    |  32 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  70 +++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   5 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |   5 +
 drivers/net/ethernet/intel/i40e/i40e_xsk.c    |  12 +
 .../net/ethernet/intel/ice/devlink/health.c   |   6 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_common.c   | 136 ++++++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   8 +
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 315 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  10 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   4 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  34 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   2 +
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  46 +++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |   6 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   |   1 +
 drivers/net/ethernet/intel/ice/ice_trace.h    |  18 +
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   1 +
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |   3 +-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |   6 +
 drivers/net/ethernet/intel/igc/igc_main.c     |  64 +++-
 include/linux/avf/virtchnl.h                  |   1 +
 28 files changed, 814 insertions(+), 75 deletions(-)

-- 
2.47.1

