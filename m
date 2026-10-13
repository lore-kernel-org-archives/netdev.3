Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2A484255
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 23:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932988; cv=none; b=s4M/jQmhX4xdzmR0qTu1Qm1zOag7w6G13Z0dlcA95K/U+iSWy8Wi6bTSwgPO1z490eOSNKAkpC75Wa72X7YIdbsFnF4yJ0HQYJh62Aj0NeORXkek0F4fb3XqziLahn5qDgTRQYU6lGTeC3bVE1KGxARB1YkjF/o9zo5gTQzZvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932988; c=relaxed/simple;
	bh=ZZnTTHvAaNC5Y/iSX4YWZ7PWsGUXP124Z3BEBBoEMx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7OPZyrcBIpHua7CObkC7+K1AZ1B7insOiiNqj+jBzbG9s8rGg339yobJ3Bn0liZzzdIN0yzeN7KyXVCLZRNd/PBe+gJjhZRgVTbVywdXQEuV/gucPGytv+c11xCVPuRfbl0CLb+8xI6O+csxalVbDeXUUY/hALl4AvJx1xYRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zachschneider.com; spf=pass smtp.mailfrom=zachschneider.com; dkim=pass (2048-bit key) header.d=zachschneider.com header.i=@zachschneider.com header.b=wFC02CXt; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zachschneider.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zachschneider.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zachschneider.com header.i=@zachschneider.com header.b="wFC02CXt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zachschneider.com;
	s=protonmail; t=1791932983; x=1792192183;
	bh=yZPw6IzPyRTv6JkMWN4UbyKzV8/yGbjIb6MrwB33dd0=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=wFC02CXtDoiEakaLxUh76ZpyiNvNqe2togPXlIlf0pOttw/cemr5CagySAvp6q0m4
	 0gohxJyfGpR25/NwZJcTcLCMH8Ec6aySIwtL7Ze8sA9awMaj1EwQo4IQtVkWuyBD6u
	 6T/UxFdpbK9p2gkrc106MZUIpHhYu54DvCYU7hnSwGeK3BNYTKOTDrULpFmeZ7SA2q
	 OyUtz+G0g8b6gbmA6q51v8m1+y4cGYUt49RPZoSXPn9oEIQi7HteHYvi6CMSWXA4D0
	 +TXV8jWQM7kPM6kVvD4el8Kx6MvYJ5ec3+lh2PepjbhXp+uykRjNAr+d03Bv4JU6az
	 ZYeRwwfhytCsA==
X-Pm-Submission-Id: 4j495d62y2z1DDXV
From: Zach Schneider <me@zachschneider.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: netdev@vger.kernel.org
Subject: r8169: RTL8126A (XID 64a) TX packets lost with TSO enabled
Date: Tue, 13 Oct 2026 18:09:04 -0500
Message-ID: <20261013230904.58717-1-me@zachschneider.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On an RTL8126A (PCI 10ec:8126, XID 64a, firmware rtl8126a-3_0.0.5
08/30/24) TCP uploads collapse when r8169 has TSO enabled, which is the
default for this chip. Disabling TSO with ethtool fixes it.

Kernel: 7.2.9-arch1-1 (Arch Linux stock kernel; also seen on 7.2.9-zen).
Board: ASUS ROG STRIX X870E-E GAMING WIFI (onboard RTL8126).
Link: 2.5Gbps/Full, flow control rx/tx.

Test: 100 MB HTTPS upload (IPv4) over the RTL8126, measuring TCP
RetransSegs from /proc/net/snmp:

  r8169, TSO on (default)   upload stalls, >120 s,  25-32% retransmitted
  r8169, TSO off            45.8 MB/s, 2.2 s,       0.0% retransmitted

The stalled connection shows bytes_retrans of about a quarter of
bytes_sent and cwnd collapsing to 4. TX error counters in ethtool -S
stay at zero. Downloads are unaffected (on 7.2.9-zen they were faster
than with the vendor driver, with rx_missed 0).

Reducing gso_max_size does not help. It fails the same way at 64000,
32000, 16000, 8000, 4000 and 2896, so any segmentation offload seems to
produce packets that get lost, not only large bursts.

For comparison, Realtek's out-of-tree r8126 10.018.00 driver ends up
with TSO off by default on this setup: rtl8126_fix_features() clears
NETIF_F_ALL_CSUM unless built with CONFIG_R8126_VLAN, so TSO is dropped
too. That driver also builds TSO descriptors differently for this chip
(GiantSendEn_V3 bit 16, GiantSendv4_V3 bit 29 and GiantSendTCP_V3 bit 30
in opts[1]), while rtl8169_tso_csum_v2() sets TD1_GTSENV4 (bit 26) in
opts[0]. I don't know whether that difference matters in the mode r8169
runs the chip in.

RTL_GIGA_MAC_VER_70 gets SG/TSO enabled by default since commit
3907f1ffc0ec ("r8169: add support for RTL8126A").

Relevant dmesg:

  r8169 0000:0e:00.0 eth0: RTL8126A, <MAC>, XID 64a, IRQ 200
  r8169 0000:0e:00.0 eth0: jumbo features [frames: 16362 bytes, tx checksumming: ko]
  Realtek Internal NBASE-T PHY r8169-0-e00:00: attached PHY driver (mii_bus:phy_addr=r8169-0-e00:00, irq=MAC)
  r8169 0000:0e:00.0 enp14s0: Link is Up - 2.5Gbps/Full - flow control rx/tx

I'm happy to test patches or collect more data. I only have this one
machine on the LAN, so I can't capture on the receiving side.

The analysis of the driver sources was done with help from an LLM
coding assistant; the measurements are from my machine.

Thanks,
Zach Schneider
