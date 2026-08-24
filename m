Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E4042FCD0;
	Mon, 24 Aug 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579293; cv=none; b=U6e1pXaWlDq610QFLQrafgV3SvVV5bVyWBUr9mrb0fDGXIKFXHxPdhXAmxMLATLyUAbPLWWKETwXFkXXvyQBJVOPXTuDDbrenAWKfGQKU0/ukN1oUBikQ3/yUgjydA2XfA5WbgclvM4ijBZLLqH+jrXjQORUzar4xCJpieU8u9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579293; c=relaxed/simple;
	bh=RgOGPPdVaOh2xWvIpyEoukN8vyU5QUzOzTKlJST29FI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbb12XMngjZ16dVcmvYKWBkgqyAM8563g+UNOJRmOvi3EARkB2D/iMlh0G3vksZyB2pZJll8EaRuoitbak42wYRZeDfz4xpJ2TV8PLx9dvF//gmMu01OOvd2MjJnDkbqidZcTcTdrc1FpoGjbql21V2PmdywjaxNuEd/RQ19VOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=mmTuhc3T; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="mmTuhc3T"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A488CA47D5;
	Mon, 24 Aug 2026 15:47:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1787579280; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=UI0369oIB2KvwXrc0Y4jF0QOhzgy0tpY4wqzeCSHVT4=;
	b=mmTuhc3TNaSdIC/VDtqE5vrgqQz50Zme6g8gL/7VnLHkz32fWzGfqnAWXAj5dyjx3CTPQO
	e+ZUKGrodyYj89IxJ0OC3PuX4DNeQm8lxKnZwSFv3NsiW6pkWiWXJHukM9OwbXXsLc/zMM
	IDJRkyNx479wWec0CeA6uBefCV150vJ4WSz3s3FU1LEnTQaqBJINZKlBp0eUO8vA1xPI8m
	4fgY7YhFTUralYSfdtNVgom+szyk/T2Aw/bF2hlXoWWWgECE0JBr4Sdy3kCc6l9di9Mk3z
	FY+nSLyi9S5vwu3H9oUVDrIci5+E0/RPe+/ILrN0YdwDJXgDTLsSqPATM5t8pg==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 0/2] net: macb: fix zero UDPv4 checksum on transmit
Date: Mon, 24 Aug 2026 15:47:01 +0200
Message-ID: <20260824134703.766708-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When a UDPv4 checksum computes to zero, RFC 768 wants 0xffff on the
wire, but the GEM sends the raw 0x0000, which receivers read as "no
checksum". Raspberry Pi confirmed in a simulation of the Cadence IP
that the engine skips the substitution for UDPv4. UDPv6 and TCP are
fine, and the IP changelog suggests all GEM revisions could be affected.
Reported and analyzed on the Raspberry Pi 5:
https://github.com/raspberrypi/linux/issues/7550

Patch 2 does UDPv4 checksums in software and lets the existing pad
and FCS path keep the hardware off the frame, UDPv6 and TCP keep
the offload. That path miscounts tx_bytes by the software FCS, so
patch 1 fixes the accounting first.

Tested on CM5. To reproduce, send bulk UDP to another host and capture
zero checksums on the receiving side:

  iperf3 -c <host> -u -b 200M -t 30
  tcpdump -ni <iface> 'src host <dut> and udp[6:2] == 0'

Without the fix a packet shows up every few seconds:

  12:46:20.002739 IP <dut>.36309 > <host>.5201: UDP, length 1448
  12:46:23.773968 IP <dut>.36309 > <host>.5201: UDP, length 1448
  12:46:40.227460 IP <dut>.36309 > <host>.5201: UDP, length 1448

With the fix the capture showed none.

Some numbers (udpgso_bench):
- 18-byte UDP throughput dropped by ~ 8%
- 256-byte UDP throughput dropped by ~ 10%
- MTU-sized UDP and UDP GSO were unchanged at the 116 MiB/s link limit

Unfortunately I don't see a cheaper fix, the zero only shows up after
computing the checksum, the MAC inserts it in flight, and AFAIU there is
no register or descriptor bit for the substitution.

I'd appreciate testing on other silicon.

Nicolai Buchwitz (2):
  net: macb: exclude software FCS from TX byte statistics
  net: macb: fix zero UDPv4 checksum on transmit

 drivers/net/ethernet/cadence/macb.h      |  3 +++
 drivers/net/ethernet/cadence/macb_main.c | 28 +++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 7 deletions(-)

-- 
2.53.0
