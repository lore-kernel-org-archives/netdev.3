Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793792926;
	b=2O9MKtjHMQRpSbP/5lTCrkYbeEjDYxixg0/qNiANxobsfra0plm86FwshKu8Lw5F2X77
	 uOp9zM7DkH6nJg26UirjdADpQEezJQARg7BmCovqFLZjd4TqP0RF4FBidJO2m8/eiJyRL
	 qGpzGhTFYh5eYJPD47iGV8GeCnIR/ADHy5MJLFuQ3Clf0NzlqIBUU8ukfR1tjx2WHrPT+
	 w+WhfHkuYeTs3ltxn7bZOTmvnBeFG8Ifssr71vYR3K/3hw4hDz1BxAGNtZ/fsHkbNjeT1
	 iTqju/O9BXeRW15R/2Vw2T+c9hQvgmWpD4Ug+/jqIbF23/8y8gLz97zZwZiXeCTCDgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793792926;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=Bz0nqTsX+SVe2yv12UIFCrkUsWFsu0k6BjSN4MdGI4s=;
	b=TAM20SzpTCvq+Xnt151wZ+Xp5Xo2j0CsGhdmGjWmes/XkpMzL4bXiIw2Au0IzzpL6ant
	 +K6NbI8HQTUthFycEZEflgBJsrT4SVyHlta7YMIQwYTt2OMnbqRM27TN+kbWWfnc/9zSf
	 QZ6hRMLzo+D2u0mFX0k6vFnI+QLr55IOHdle8/prMvCabjkikcEO9NaLi01dSMnerUZMr
	 CpiegBg95RR3LoXh5QZSEDlb8crW2UXBUb3MJ8PYlPJqUzBskz4uOfuNN9tWQHvCMh1iE
	 dHr8vNl8STLxhJPbQCHk9kjQtSraGs7U1odSprL+WieaSAyc8fjFP9hrTR001jE3UCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GkWVOTo8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C247606A32F;
	Wed,  4 Nov 2026 11:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C247606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=GkWVOTo8
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.4.pengutronix.de [10.17.1.12])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6A08E200AD7;
	Wed, 04 Nov 2026 12:48:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793792922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bz0nqTsX+SVe2yv12UIFCrkUsWFsu0k6BjSN4MdGI4s=;
	b=GkWVOTo8OA5rO7xbcyNMH/qWLLuB4VwdDDOgj01j1RQkODfmbpDWoTYdAL1A/SmPOycKAe
	AXdPQC3SjW6SOUyo8NdXYkFJDiHQHFUfMQjziN6Q3W4wC/4gFnnktLZ5so6e3EJvcajXSW
	SSbhrfjgIc3nskbdHX0Ww1YVTFSP2Oog+zudFGvoKq0RkxrkqgFZ5AiARdTuhfBFyyWCkH
	Aec60GFra1Va+SshfE2J58w4lQ8uj9PpZcHkAI8/sidE8EwDDefXLGp2HAG5I5F/7LsYYg
	EbyqmG8RgwvwornTus60kMVLLxsuN5NVgTRjXtoul2Qv8lg1zAgg0PVbBI4b5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793792922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Bz0nqTsX+SVe2yv12UIFCrkUsWFsu0k6BjSN4MdGI4s=;
	b=ZDgosKSMs6WZGfTTbKVBwsRlIjEPQAXcbzuE/73mTFoKQqi5DTe7W+gX7IoVkkgkhxKN9l
	qDO6Ci5957J2Mo1ceftxRnzGR+u0qWM/N5OJKS/5dKcflmOShlljKZdhkvg6KHD2apO2LI
	ixFHeAgkEvG6rOpHyStCRLiLYTBlJAKvIktBYMAqrjVi8jmOxF9ydGl5XdpSeEhozV/Pma
	woDAK3l5kWFYdm4/tp1sjMUDkm5y7YIn6r+OzEUMrss5pMq8GIVkQ1E7NAf3zefKCvdpSq
	PGRC+ijpoR27flwGuaE9YW7NbVEYueoqlbQsb1vwZvjgdnRCNQiaRLv6KkhCMw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793792922; a=rsa-sha256;
	cv=none;
	b=MJUDHjRo/STTGox1rBRvqHDg7ia9CbZ44TbLReP5w5cGzT2Vuc5zTCabxzbxlwJQEvC1wx
	kDx3bOA6ZxESlIkH45vNk2fHa5KIplqS+SWlsoTCl7snofO2kCVRAOd8y0OUtNKhPrqCTd
	IE023M8eDmwDuAjBS2biP/1PhGQNdAEPn20ZmDOxfo22Tua6C5VSoeDXFTky62pxE35TyU
	VeRFHJcfXxn2lumy+2XetxbA94dW7BPBy3VwHW/CkzWJhk9KOx/NxHoa/+Zf9OS+qE5yqr
	aT5LOludc68RK5gs9JjhDRCufRIbnF9unSUxLSTj0r0DmRwOnGN/cY9kRu1YVw==
Received: by dude04.red.stw.pengutronix.de (Postfix, from userid 1058)
	id 5DD70380600; Wed, 04 Nov 2026 12:48:42 +0100 (CET)
From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: [PATCH net-next 0/3] net: dsa: make a shorter bridge ageing time
 take effect
Date: Wed, 04 Nov 2026 12:48:27 +0100
Message-Id: <20261104-ksz-stp-ageing-v1-0-2c2bc7217dea@pengutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIsb62oC/zWM0Q6CMAxFf4X02cZtBhR/xfhQoI7GUMm6ECLh3
 50mPp7ce84GxknY4FptkHgRk5cW8IcK+pE0MspQGIILjffuhE97o+UZKbJoxLOriZr2ElquoUh
 z4oesv+ANlDMqrxnuZenIGLtE2o/f4EALT/h/HCcShX3/ACoFvTmQAAAA
X-Change-ID: 20261103-ksz-stp-ageing-705aa69829e5
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, 
 =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?= <jensemil.schulzostergaard@microchip.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
X-Mailer: b4 0.14.2

With kernel STP, the bridge sets a shorter ageing time during a
topology change. When the topology change ends, the bridge restores
the configured ageing time. Without this series, two things go wrong:

- On a KSZ9893, a shorter ageing time does not take effect at once.
  The new Age Period starts only after the running period ends.
  Entries already in the table keep their old Age Count (patch 1).
- On any DSA switch with .set_ageing_time, the restore has no effect.
  DSA writes the short value to the switch instead of the configured
  value (patch 2).

A port can also leave the bridge during the topology change (patch 3):

- Before this series, DSA kept the short ageing time of that port. DSA
  uses the smallest ageing time of all ports. While the port stayed out
  of the bridge, later changes to a longer ageing time still wrote the
  short value to the switch.
- With this series, DSA clears the ageing time of the port when the
  port leaves. As before this series, DSA does not write the ageing
  time to the switch at that moment. The switch keeps its current value
  until the next write. The next write comes with the next ageing time
  change, or when a port in the same DSA tree joins a bridge. Usually,
  the next ageing time change is the restore at the end of the topology
  change.

In a lab test on a KSZ9893 with a redundant path, I cut one path while
one station sent one-way traffic to another. I ran six setups. With the
series, the traffic stopped for 12 to 15 s in all six. That is about
the time STP needed to converge. Without the series, the traffic
stopped for 24 to 56 s in three setups. The other three failed before
the cut (see below).

Without the series, the switch kept the old FDB entry of the receiver.
The entry pointed to the port on which the traffic came in, so the
switch dropped the traffic. During the topology change, the switch still
ran its old, long Age Period. The entry therefore did not age out in
time (patch 1). The outage ends when the entry ages out or when the
receiver sends a frame. In one of the three measured setups, the sender
used normal ARP, so the receiver could answer ARP requests. There, the
outage was 24 to 46 s. Where the receiver sent no frame that the switch
could learn from, it was 51 to 56 s. Stations that receive much and send
little are affected most, for example receivers of a UDP stream or of
telemetry. I did not test traffic in both directions, such as TCP.

Without the series, the switch also stayed at the short ageing time
after a topology change ended (patch 2). In this test, the topology
change when the bridge came up already left the switch at 8 s instead
of 300 s, before the cut. The short value is twice the forward delay,
which was 4 s. Entries of stations that send little then
aged out after a few seconds. In three setups, the switch lost the
entry of the receiver this way before the cut.

Patches 2 and 3 change the DSA core. They affect every driver that
implements .set_ageing_time. For this reason, the series targets
net-next and has no Fixes tags.

To reproduce the restore case (patch 2):

  ip link add br0 type bridge stp_state 0
  ip link set lan1 master br0
  ip link set lan2 master br0
  ip link set br0 up
  ip link set br0 type bridge ageing_time 1000
  ip link set br0 type bridge ageing_time 30000

ip link takes centiseconds, so 1000 is 10 s and 30000 is 300 s. Then
read the ageing time from the switch, for example from the 32-bit
regmap in debugfs:

  grep -E '^0*310:' /sys/kernel/debug/regmap/<device>-32/registers

The line shows the bytes of registers 0x0310 to 0x0313. Bits 5:3 of
the first byte are the Age Count. The last byte is the Age Period in
seconds. The ageing time is Age Count times Age Period. Without the
series, it is 1 x 10 s = 10 s. With the series, it is 2 x 150 s =
300 s, so the last byte reads 96.

To test a port that leaves the bridge (patch 3), run "ip link set lan2
nomaster" between the two ageing_time commands. Without the series,
and with only patches 1 and 2, the register readback shows 10 s. With
the whole series, it shows 300 s.

To test patch 1 on a fresh bridge, set the ageing time to 300 s and let
the switch learn an address on lan1. Then set the ageing time to 10 s
and watch the "self" entry of that address in "bridge fdb show dev
lan1". Without the series, the entry stayed in the table for 57 s to
more than 120 s in my tests on a KSZ9893. With patch 1, the switch
removes the dynamic entries at once. The switch learns the address
again from new traffic.

Tested on a KSZ9893. I did not run the forwarding selftests.

---
Oleksij Rempel (3):
      net: dsa: microchip: ksz9477: apply a shorter ageing time at once
      net: dsa: store the port ageing time before programming it
      net: dsa: forget the port ageing time when the port leaves the bridge

 drivers/net/dsa/microchip/ksz9477.c | 36 ++++++++++++++++++++++++++++++++----
 net/dsa/port.c                      | 15 +++++++++++----
 2 files changed, 43 insertions(+), 8 deletions(-)
---
base-commit: 4dd16e31135ea8437a720222df34e8745f385d6d
change-id: 20261103-ksz-stp-ageing-705aa69829e5

Best regards,
-- 
Oleksij Rempel <o.rempel@pengutronix.de>

