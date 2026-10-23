Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.76.27.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794181;
	b=dFyMvddXL/iTpYbwAtieX32FqN8/zfS4kN9spAPGEF7prqUepIBqtYR7gJofbKKPvj5S
	 DOSrEHb80DIbEAVZp6B0OnER9SV89zOu/GLAyNXPWX1pQ9nq/3utyaITR1w1rVD41KOg3
	 bHTK4QuZ9SZ+snOg0+1C166Zplab903w8BZtqF6t7VYiGfbgy+ihQY3Q6/iE3/lzoSGKD
	 oclxmNc7Rxc/ZmY2jVPc8Dcii6ygo98suoOx48t/X1qnkVg0qfWI9KM0QPXN1NjDvjzKm
	 HiwghqxeRE6pFuMmMmFsNng9RhrJexRcGPrrSblY4EKI/nQN5dVYQDw4zPZ5a0clPKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794181;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=NOXq3GB19d77y3Iz4Ur6hSHpD6Dl4HBXAEowizutA1Q=;
	b=eTI2uASjyn5Z+LQW1wipaWSfZFPnx1EMaAovWdqqoSbnBhPSeLG17LvrW9uTAUS3/70s
	 g4eO7XIJYptclQfp1FPuC56hO5y/agX4F4pM4bpxNGeYMBcbwz8bZgcbCOM9l/A5hoMXG
	 b8ifghCBVK9WbjjkV40V/KHPoF4fey0nOWp6B4PkqIyEp0AJwKhfXT5J3TDW/+dvinUPv
	 H71tYlm/jnXYoJq8sqRL8af9HU+btTVR9r8ka9aAjRrS+le04vYAveTIl7RDlSfjwV5uq
	 cdXhkkfOkyhFfAfLjRgtSYyQAzyjBtBo8mAi0itVtRaA34sO77OgaQhfB939Vo9nY9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=andrei-z.com;
	spf=pass smtp.mailfrom=andrei-z.com;
	dkim=pass header.d=andrei-z.com header.i=@andrei-z.com header.a=rsa-sha256 header.s=sig1 header.b=OkQM9rcG;
	arc=none smtp.remote-ip=82.76.27.144
Received: from vtj.irix.systems (vtj.irix.systems [82.76.27.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CEE606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 22:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrei-z.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=andrei-z.com header.i=@andrei-z.com header.a=rsa-sha256 header.s=sig1 header.b=OkQM9rcG
Received: from MAILGW-HP.hp.vtj.corp.irix.systems (localhost [127.0.0.1])
	by vtj.irix.systems (Proxmox) with ESMTP id 8837923B83;
	Sat, 24 Oct 2026 01:22:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andrei-z.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=sig1; bh=NOXq3GB19d77y3Iz4Ur6hSHpD6Dl4HBXAEowizutA1Q=; b=
	OkQM9rcGAwcKEgqE2ANE2u4tJYZSzsgzwoAaNnTKmy8DwEtir4yN9B5cJEN1hZ2i
	xUHtOgW0zJsIh30dPJa6FK63iOw/l7f/BbRiGs2EqBptI5tfZar20kqmp8Tztp3F
	aNlr+qhCrUOTYELxBq8jhgEYWB1NYOLTujqy5nOCJTXMeSVBFGnKiPCOrZM2JSA5
	weysTCGnl8mu+RXVoOguBp2VGk0L/R1sHJfWtHgIdP8d2KKcWWEGfVgy2M5QDDvm
	Nd7CFnvSX6byhfRkzhfhQnUfNcBrCgE9XQVF3eqqDrtRU7iF3Cp7QhDF4NidS4qB
	5zUfSZou5MqivXmZlOct2A==
Received: from VTJ-MX.corp.irix.systems (unknown [IPv6:2a02:2f04:1:9c24::6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by vtj.irix.systems (Proxmox) with ESMTPS id 3BC4023B37;
	Sat, 24 Oct 2026 01:22:58 +0300 (EEST)
Received: from workspace.corp.irix.systems (2a02:2f04:1:9c23::c) by
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 24 Oct 2026 01:22:57 +0300
From: Andrei-Alexandru Bleortu <me@andrei-z.com>
To: <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Vitaly Lifshits
	<vitaly.lifshits@intel.com>, Sasha Neftin <sasha.neftin@intel.com>, Dima
 Ruinskiy <dima.ruinskiy@intel.com>
Subject: [BUG] e1000e: I219 with jumbo MTU: RX CRC errors for unicast DAs not in the RAR (promiscuous/bridged ports)
Date: Sat, 24 Oct 2026 01:22:52 +0300
Message-ID: <20261023222252.2528909-1-me@andrei-z.com>
X-Mailer: git-send-email 2.47.3
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
Content-Type: text/plain
X-ClientProxiedBy: VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) To
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6)

Hi,

On I219-LM (8086:15bb rev 10, pch_cnp) with MTU 9000, frames addressed
to a unicast MAC that is not in the RAR fail with rx_crc_errors at
roughly 0.1% of frames (rx_errors rises by exactly twice that; the
length and alignment counters stay at 0), while the same stream
addressed to the port's own MAC is clean. A port enslaved to a bridge or
OVS is always in this state, since e1000e_set_rx_mode() skips
e1000e_write_uc_addr_list() under IFF_PROMISC.

Hardware: Dell OptiPlex 7060 (BIOS 1.32.0) and HP ProDesk 600 G5 Mini
(BIOS R22 02.24.00), both I219-LM 8086:15bb rev 10, NVM 0.5-4. Kernel
7.0.14 (Proxmox); e1000e_set_rx_mode(), e1000e_write_uc_addr_list(),
e1000_rar_set_pch_lpt() and e1000_lv_jumbo_workaround_ich8lan() are
unchanged in net-next.

Setup: lan0 (the I219) is an OVS port, so IFF_PROMISC and RCTL UPE|MPE
are set. A VLAN device on lan0 carries the host's IP with its own MAC
(different from lan0's). The sender is behind 10GbE switch ports; the
receiver's switch port is 1GbE.

Test: 1 GiB of TCP (ssh, MSS 8948) pushed into the I219 host, counting
rx_crc_errors before and after:

                                              host 1      host 2
  DA = lan0's own MAC (RAR[0])                  0, 0        0, 0     per GiB
  DA = the VLAN device's MAC (not in RAR)     438, 429    416, 417   per GiB

Workaround, confirmed on both hosts: giving the VLAN device the port's
own MAC, so the host's traffic is addressed to RAR[0], brings the same
test to 0, 0 per GiB. Frames to the MACs of bridged guests behind the
port cannot be helped that way and remain affected.

All of the following are needed. Removing any one gives 0 errors:
  - frame size: path MTU 3000/5000/7000/9000 -> 0 / 0 / 80 / ~370
  - back-to-back line rate: the same jumbo frames paced at ~1000/s -> 0;
    the same 1 GiB from a 1GbE sender through the same switch -> 0
    (only a faster ingress port drained into the 1GbE port produces
    minimum-IPG back-to-back frames)
  - a DA that is not in the RAR (table above)

Not affected (each tested, no change in the error rate): CPU C-states
(holding /dev/cpu_dma_latency at 0 -> 380/GiB), the disable-k1 private
flag, GRO, cable, switch EEE/jumbo settings. rx_missed_errors stays at
~0, so this is not an RX FIFO/descriptor overrun.

My reading of why (please correct me): the I219's PHY-MAC interconnect
runs at 1.25 Gb/s 8b/10b (datasheet section 2.2), i.e. no headroom over
1000BASE-T. e1000_lv_jumbo_workaround_ich8lan() copies the RAR into the
PHY (e1000_copy_rx_addrs_to_phy_ich8lan()), seeds PCH_RAICC(i) with
~ether_crc_le() of each RAR address and sets FFLT_DBG; the PHY register
fields described as "Crop ANM DA Jumbo" / "Filter on 1Gbps ... jumbo
fix" suggest the PHY drops the DA of known addresses to gain bandwidth
and the MAC restarts the CRC from the per-address seed. A frame whose
DA is not in that table gets no crop, and back-to-back long frames then
overrun the interconnect.

Two consequences in the driver, from reading the code:

1. Under IFF_PROMISC, secondary unicast addresses (a VLAN, macvlan or
   bridge MAC on top of the port) are never written to the RAR, so they
   never get the jumbo fix. This is the case measured above.

2. Even without promiscuous mode, e1000e_write_uc_addr_list() ->
   rar_set() writes only RAL/RAH (SHRAL/SHRAH), while PCH_RAICC and
   the PHY's copy are refreshed only in e1000_configure_rx(). An address
   added after the interface is up should have the same problem until
   the next reset or MTU change. (Not tested.)

Possible directions, if the analysis holds:
  - while the jumbo workaround is enabled, program secondary unicast
    addresses into RAR/SHRA even under IFF_PROMISC, and re-run the
    PCH_RAICC + PHY copy whenever the RAR changes;
  - for DAs that cannot be in the RAR at all (bridged guests' MACs, or
    an ME holding SHRA via FWSM.WLOCK_MAC), is there a hardware way to
    sustain line-rate jumbo for them? If not, a one-time warning when a
    jumbo MTU is combined with promiscuous mode on pch2lan+ would save
    the next person a long hunt.

I worked through this with the help of an AI assistant (Claude); the
numbers above were measured on my two machines.

I can test patches on both machines (Secure Boot is on, so that goes
through a MOK-signed module) and run further measurements if useful.

Thanks,
Andrei

