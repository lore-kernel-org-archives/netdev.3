Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35844400968
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155450; cv=none; b=k0o19Wz1VILJcALyc/IY2Q7zVGNmZAXJxXXmS/TGAv5zWFHahmNnS3PJ+fqrU17I2vbOcGRQ2QZPEbLPuk0f1IQA3UHbjm4ze+AS3J3r9LXh3Vz/EfdttRnwcAjGgxeDhqQ2cBkL41hFcs8v1sv4g5Uqf+S0i3BSu9ABSgf1qC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155450; c=relaxed/simple;
	bh=+nkn2L3juBq5sEJdA5SDK+26iCLXITKuDjPDHVgLO7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hFx3Rrvxe6CSY9g3+NM8bdil8o6UYo131+JfNqKjG39Ar3yThkOYC3F93+phiulAX6ycZEjuaCaTF6wUArU5afv1efEkga5RMC6l6n/6SmpbCf0o7evUjPcyMZSsdFiEqfoL6WAiK3KD+wKsQ4y9t0RcFKfjlTMKsAlmC7Wh15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvyFD+4E; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvyFD+4E"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cab973140bso34764575ad.3
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785155447; x=1785760247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RXLp1w9y313rtvVEolOnByVGZO9J02FYO9mn2TCWDxg=;
        b=pvyFD+4E57o+lfBm4bNGoJjegngiIbIInyYAQbVVIsP1ZzsbA6CffA0MyKcfU49uQ3
         GM0DaKzGeZfReeBtb3iG2NHrKOF3aCBxPLLbdGqa7jor/R2f8aWh7ysr905QflrgxCz+
         ui1MZ7y3GPa5GOy0IB3QU6Vda7BhuIpII4f0w+Gfx7zJ+TXYjNWCKQchEWVvBqzzxkoy
         F/TWOhShXeYAFUKcDCUDJAFAdsmIL6NHirBhTGKvfQyWpNbsiAyJVE/RHeyuHHaV4Wu3
         5FgD8O4jXwWO7G0AP6S+D0htQTgXVD8evp3mXu0nKeKnFNeZpk+TjK9BghadcCjPflmV
         QtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785155447; x=1785760247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXLp1w9y313rtvVEolOnByVGZO9J02FYO9mn2TCWDxg=;
        b=QFaZNHn2ESCzzs3GEDe+Nw1C7Hj9iyf8P83ohSspTmcbmdolnufmZMtgC7U/Hb0mOZ
         KtstK6csouAy6OoNVN04AQmk37hRQzBC1/BfHWyCWAhUKmtkzZozdCkKa6dxv87VToH9
         gFDZHHLveDglW6bFzLx0QkxMLUPxOf0ErOS7Sj/SklBGJXnBeyu8PEevfFf4z2VzXC6t
         IzC82IXAPtgbNM+v/4YiDUF3VhZ1MNUwtxen26OUNcTCNV8TsCnfzh+2LC5WibQTeq8d
         oyfCBQvh/OifKeNhfj3Xf0OPpt9clLtsk8KT8PLpHQ5M4QMzHgUzaHD5iQSoizurrSrx
         3XKA==
X-Gm-Message-State: AOJu0YzDUHUake9TLhZvA3GunRtLJEZ4qAGsGsIdoXl+xley7nAGHU0W
	MlT5K5RVRdkkqJ8X4uwZJN4tBDbClr6RoaBg51db+tdVuNBs3w7rZt8=
X-Gm-Gg: AR+sD11e7AoYex9w11pnMXIFZhI6CpifDkfIop78EV1A+aSc33dhXVkRJOtTxUO+OIW
	Hnb/68rmVez9FZFcoQFzQp5Ak9avcqHQtz0fxcpKSBxdlc0C4epBujbG7Ges+YVky4v24Jy3UWG
	M94Qh/GkwKsHxOtKwGu8bDYxa+dsMI8LD7gNqQ4iqNVLJRh6oSZTTQ4HCR1eb0aDPYLiyGt1+GW
	p1ZlF7YyqxYOD96VvLKb/IImC8Il/+dItqE9NuS5UiltJxgHkhFim33oxA5d7cPDmrGil6wSi5O
	VsfWXGNQE2QM+m/yIj5NKHsSGQ0wOFMGqBXpx4z0pcNZ1sa8Bvd4dOQ8TxLUYVO/6pDS2Ntkekm
	HfrJQ0p6a4hT1CS0xeRWfMmgdhhh2c5UBQeQNgihSlrODlrBTa8h2+kZF+GcYJrWYharBpt73O1
	UdgTClTf4=
X-Received: by 2002:a17:902:ce06:b0:2cc:6018:f030 with SMTP id d9443c01a7336-2cfde7ae1c6mr76726365ad.14.1785155445857;
        Mon, 27 Jul 2026 05:30:45 -0700 (PDT)
Received: from jplife-black.. ([171.2.207.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e28easm34644985ad.24.2026.07.27.05.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 05:30:43 -0700 (PDT)
From: Fan Ye <fy15309206903@gmail.com>
To: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Ye <fy15309206903@gmail.com>,
	zhangjianrong <zhangjianrong5@huawei.com>
Subject: [PATCH net v2] Revert "net: thunderbolt: Enable end-to-end flow control also in transmit"
Date: Mon, 27 Jul 2026 12:29:48 +0000
Message-ID: <20260727123002.25225-1-fy15309206903@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a8065af3346ebd7c76ebc113451fb3ba94cf7769.

Per the USB4 spec, a Transmit Descriptor Ring with E2E flow control
disabled does not require any credits to be available before the Host
Interface Adapter Layer transmits a tunneled packet from it. Once E2E is
enabled on that ring the controller must first obtain end-to-end
credits.

The ASMedia ASM4242 USB4 host router (PCI 1b21:2425) never delivers
those credits. The controller does accept the configuration: reading the
ring OPTIONS register back right after tb_ring_start() returns exactly
what was written, including RING_FLAG_E2E_FLOW_CONTROL (bit 28) and the
E2E HopID field. No credit ever arrives though, so the Tx ring's
hardware consumer index never advances and the link carries no traffic
at all.

Measured on two hosts connected point to point, onboard ASM4242 on MSI
X870E and X870, v6.17, stock drivers/net/thunderbolt/main.c with only
this revert applied on top:

  before: 100% packet loss to the peer; thunderbolt0 is up and the
          XDomain handshake completes ("new host found"), but iperf3
          fails with "No route to host" once the neighbour entry
          expires
  after:  0% packet loss, 0.28 ms RTT; iperf3 4.21 Gb/s one way and
          5.17 Gb/s the other (5 runs each, stddev <= 0.02), 1
          retransmit in 10 s

An instrumented build additionally showed a frozen-Tx-consumer watchdog
firing ~30k times in a 10 s window before this change.

Rx-side E2E is not touched by this revert, so peers that do return
credits keep receive-side flow control.

ASMedia does not look like an isolated case. The out-of-tree
thunderbolt-ibverbs project disables native E2E on AMD NHI by default,
noting that "Strix Halo has reproduced TX completion wedges with
multiple native E2E rings active" -- the same failure mode, on a
different vendor. Since the driver has no way to tell in advance which
host router returns the credits, going back to the previous behaviour
looks safer than adding a quirk per affected part; Tx-side E2E can be
reintroduced as an opt-in for controllers that are known to implement
the credit return.

Note that the reverted commit was not fixing a reported problem, it was
derived from the spec wording alone, so this revert is not expected to
regress a known workload. Cc'ing the original author in case there was
one.

Fixes: a8065af3346e ("net: thunderbolt: Enable end-to-end flow control also in transmit")
Cc: zhangjianrong <zhangjianrong5@huawei.com>
Signed-off-by: Fan Ye <fy15309206903@gmail.com>
---
v2: Send as a plain revert of a8065af3346e instead of a separate change
    that disables Tx-side E2E, as suggested by Mika. Functionally
    identical to v1; the ASM4242 measurements are kept in the changelog.

v1: https://lore.kernel.org/all/20260723025649.7112-1-faliye@ymail.ne.jp/

 drivers/net/thunderbolt/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
index 02a916505..c5670d618 100644
--- a/drivers/net/thunderbolt/main.c
+++ b/drivers/net/thunderbolt/main.c
@@ -925,12 +925,8 @@ static int tbnet_open(struct net_device *dev)

 	netif_carrier_off(dev);

-	flags = RING_FLAG_FRAME;
-	/* Only enable full E2E if the other end supports it too */
-	if (tbnet_e2e && net->svc->prtcstns & TBNET_E2E)
-		flags |= RING_FLAG_E2E;
-
-	ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE, flags);
+	ring = tb_ring_alloc_tx(xd->tb->nhi, -1, TBNET_RING_SIZE,
+				RING_FLAG_FRAME);
 	if (!ring) {
 		netdev_err(dev, "failed to allocate Tx ring\n");
 		return -ENOMEM;
@@ -949,6 +945,11 @@ static int tbnet_open(struct net_device *dev)
 	sof_mask = BIT(TBIP_PDF_FRAME_START);
 	eof_mask = BIT(TBIP_PDF_FRAME_END);

+	flags = RING_FLAG_FRAME;
+	/* Only enable full E2E if the other end supports it too */
+	if (tbnet_e2e && net->svc->prtcstns & TBNET_E2E)
+		flags |= RING_FLAG_E2E;
+
 	ring = tb_ring_alloc_rx(xd->tb->nhi, -1, TBNET_RING_SIZE, flags,
 				net->tx_ring.ring->hop, sof_mask,
 				eof_mask, tbnet_start_poll, net);
--
2.43.0

