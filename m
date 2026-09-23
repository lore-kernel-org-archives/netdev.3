Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6433A1E92
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165668; cv=none; b=K/shkObNHClfJwy2+izyR8vNV6UpljnQqBfTgoS13rVx/Xsig9qKyB8kYHE5uBJfUs1ohCcBaJ9WP1mPCGfFg85qVkkCS0Nzvp4JblQWLPVn6u0sVGhiGKUKPxoB8+oKdMugDIGtk3Oi3XJKJZUs7nu6dPIiOmDdn9J6WDZAnuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165668; c=relaxed/simple;
	bh=NZK87l8S48wXwyeHiQxofCn9HkJsUCte3P/pApdGpdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BZ4nC/7NkZI2Cb6Sg38wTA3zM3zBfrTdirV7ryAWqp/CRepsBGY3Fe/XSUHpfUAe7SNVYvW7EpuRGmodgayXTmAAYhAfnT3Uo2HHxfnPgV3TeV4XWtRjos/x3d2Rg8wQg7rCgZ3oNu3RLjoaRgOfvxaUN3GcWCJNGOldRUGFlQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LsApqJMO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xnM2pBFe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LsApqJMO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xnM2pBFe"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790165653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5ON121Jd7aAKznGarVXfZNZsbycKhRoHoMVBnaw9DVk=;
	b=LsApqJMOIv7DUhYiQFJkmf0gvjipcUjzr/qNeHVSEGFJ+gxvGlShj93/DLpEGqyGcbHMQI
	Cts/1Mbpzwa5M4xI5y5XiEwYQVOeuI/yhueLspT1Wyry49zocgmHgxpE+ZuT8xOsKNSYTX
	nwLurI/YZbnmvsuUwhqviTa5hLJBBM3JKeMQVNU8ah4NtFRxtdw0sri/W+dvlYEyUFChn2
	voNpWjrUG1NTSxMktO3UWfn6XmV65BsJciFRdcV7MU6JCq0yYhBWyt5eHh3mimLPL5Sz3L
	czCWksZmJjw6A8ls/VNJddpSiNVagrysq19maAe8I2VKpjilNFJ8YQf8Ka2Eeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790165653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5ON121Jd7aAKznGarVXfZNZsbycKhRoHoMVBnaw9DVk=;
	b=xnM2pBFesypkSVacSV5yHoDfugoLcy9DNQ7gBgAWMOAbydBcRYm3cZy+/JhMB94dpH9mqr
	RvMyohl6JWDgedDQ==
To: netdev@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>,
	Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next v6 0/8] hsr: Add additional info to send/ receive skbs
Date: Wed, 23 Sep 2026 14:14:01 +0200
Message-ID: <20260923-hsr_ptp-v6-0-6ea07b3fb8a8@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260204-hsr_ptp-1f6380f1d35f
Content-Transfer-Encoding: quoted-printable

I am trying to extend linuxptp to support PTP over a HSR network.

This is the kernel side of the changes. In short PTP over HSR sends its
packets to a multicast address and every node needs to forward the PTP
packet (SYNC and FOLLOW-UP for instance) within the HSR ring.
In order to achieve this, the HSR stack must not duplicate and forward
the PTP packets as it would do with other packets. The delay caused by
the duplication and forwarding adds overhead which in turn makes the
timing information within the PTP packet inaccurate.

My current approach is to open the slave devices (eth0/ eth1) from
userland in order to receive the PTP packets. Sending happens from the
hsr0 device. The actual packet has an inline header prepended of type
struct hsr_inline_header. The size of the header is equivalent to
ethhdr. The header has a type (h_proto) at the same position as ethhdr
and expects it to be ETH_P_1588 as this extra meta information is only
relevant for PTP packets. It makes no sense to send PTP packets via the
HSR interface because it gets duplicated and the timestamp information
is lost so this should not break anything. As an additional safe guard
there is a magic value at h_source position. The value has '0xaf' at the
most significant byte which makes the address a locally administered
multicast address.

The header passes two information from userland: On which slave port
the packet has to be sent and does the HSR stack need to prepend a
header or not.
The header is skipped so that the remaining stack sees the actual data
and can send it as requested.

The PRP packets are sent directly via the SLAVE interface. The standard
mandates not add a PRP trailer (PRP, redundancy control trailer) to PTP
packets. There is not really a reason to use hsr interface.

HSR hardware offloading is optional. The driver needs to know if the
operating mode is HSR or PRP. In PRP mode it needs to check the ether
type and for ETH_P_1588 it must not perform any offloading.
In HSR mode, for ether-type ETH_P_1588 there must be no offloading. If
the ether-type is ETH_P_HSR there must be no offloading if the
encapsulated protocol is ETH_P_1588.

This has been tested in a pure software environment and in an HW-assisted
environment where the HW is able to duplicate and duplicate packets
but does not do it for PTP packets.
It has not been tested within an environment where the HW is able to
forward the PTP packet and correctly update the timing information.

---
v5=E2=80=A6v6: https://lore.kernel.org/r/20260527-hsr_ptp-v5-0-158a7633eac0=
@linutronix.de
- hsr_ptp_test: Let it wait up to 100ms for a packet. Otherwise it will
  complain if the recevied packet is not already in socket.
- Use TEST_GEN_PROGS instead TEST_GEN_FILES, the test can not run
  without additional arguments.
- Make the inline header mandatory for sending ETH_P_1588 packets via
  the HSR device.
- Use kfree_skb() instead kfree() for the skb.
- Rephrase the commit message saying that skb_clone() shares
  skb_shared_info and does not copy it.

v4=E2=80=A6v5: https://lore.kernel.org/r/20260508-hsr_ptp-v4-1-aa19aa7c6a71=
@linutronix.de
- Split the patch into smaller pieces
- Added a test for the added inline header (which signals the port while
  sending packets).
- Replaced __pskb_copy() with skb_clone() + skb_cow_head() in
  hsr_create_tagged_frame() to preserve timestamp request.

v3=E2=80=A6v4: https://lore.kernel.org/r/20260429-hsr_ptp-v3-1-afbf8f200f48=
@linutronix.de
- Removed skb extention. The information within HSR is passed via
  struct hsr_frame_info. Driver with HSR-offloading capabilities need to
  know the HSR mode (HSR or PRP) and parse the skb to decide what needs
  to be done (whether to send on both ports and if adding a header is
  needed).

v2=E2=80=A6v3: https://patch.msgid.link/20260309-hsr_ptp-v2-0-798262aad3a4@=
linutronix.de
- Remove af_packet changes entirely.
- Add an internal header to pass additional information for HSR-PTP
  packets.
- Remove PRP, userland will use slave devices directly.
- Drop all received PTP packets. Userland needs to use the slave device
  for RX.

v1=E2=80=A6v2: https://patch.msgid.link/20260204-hsr_ptp-v1-0-b421c69a77da@=
linutronix.de
- Added PRP support
- skb extention is used instead of extending struct skb_shared_info
- in af_packet
  - packet_sendmsg_spkt() is no longer extended
  - jump labels are used to avoid the overhead if there no socket that
    is using this HSR extension.

---
Sebastian Andrzej Siewior (8):
      hsr: Add header_ops::parse_protocol
      hsr: Use skb_clone() while adding the HSR header
      hsr: Add a magic header for sending PTP packets
      hsr: Drop received PTP packets
      hsr: Use the port and header information in hsr_forward_skb()
      hsr: Assign a socket for cloned skbs
      hsr: Move struct hsr_ethhdr to a global header
      selftests: hsr: Add test for the inline PTP header on HSR

 include/linux/if_hsr.h                         |  16 +
 net/hsr/hsr_device.c                           |  67 +++-
 net/hsr/hsr_forward.c                          |  77 +++-
 net/hsr/hsr_forward.h                          |   3 +-
 net/hsr/hsr_framereg.h                         |   2 +
 net/hsr/hsr_main.h                             |   5 -
 net/hsr/hsr_slave.c                            |  37 +-
 tools/testing/selftests/net/hsr/.gitignore     |   1 +
 tools/testing/selftests/net/hsr/Makefile       |   5 +
 tools/testing/selftests/net/hsr/hsr_ptp.sh     | 109 ++++++
 tools/testing/selftests/net/hsr/hsr_ptp_test.c | 495 +++++++++++++++++++++=
++++
 11 files changed, 774 insertions(+), 43 deletions(-)
---
base-commit: dec005ae90a2946656a090f37bf1cfbd22f08e57
change-id: 20260204-hsr_ptp-1f6380f1d35f

Best regards,
--=20=20
Sebastian Andrzej Siewior <bigeasy@linutronix.de>

