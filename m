Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130869;
	b=dnTZf7zeFRPj++F9LxSz2AAQlOsypirgxYO21+jmGAYN5r5HvevO2uvngpOYbWNxiOVC
	 oM9IiSWq+7UhVUEeMGVOdwFgsvSz929IE9fgZ8ay7sTH/prtNedbQPn8YLJ0zcxOA9HPj
	 hxbvT198bHSLJAhwb01EMLWm/Nhv76+8hMWq0QopsgMbhIf3Vx4M7cfdUO69/HARiBuBt
	 2L1ReNw/8XJd1aQhDJvuO/PXERviwIq0kZz3UOV0Vyj/w9re0yvNe6IpWIqrtGJWyuYkW
	 L8xfnmbhij2Robw3FCUE8XhqM/WS1rsF/wSl9+jDP71vNmfL6T9mdHwH8d3eDHp85sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130869;
	h=DMARC-Filter:Received:DKIM-Signature:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=e0cNosVIvrwrLg1oyemNTICbA8kWNi/5IpjZtAuHw0M=;
	b=nK/TPdh/qr1ahyEfkmvNORh+W1IxO9xPi1KjDA+xgwQS5wWzjfarYSrqQ8rjrcytQe+k
	 jXutTrsfqeEoymtNmthgWVZ0eYFKkSfLfe7097yrsi1QOZGpiOkgo8wVA85Rz9+zF6Soz
	 UifwHzQCD1ua9+igt3vGx/XgFZND9sVtDfuuEyxrLtx1mLFIUlK83S0hwIc9IJ7EqQLDQ
	 kmq3cGPG/8QYlNxrR0eJS0P+ZyJuGl9GMOYoA7du+z2t3QNT2nh8Nzln1dVHFNgfHdMQT
	 +20t8i8T6lIbKefGeQ++5LD6K0RLeEDwSkqCYidQmWZxrAVtP88g3WjfNRKS2ZpdzMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=qfkxsh1r;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B702606A31E;
	Tue, 27 Oct 2026 19:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B702606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=qfkxsh1r
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79884A3764;
	Tue, 27 Oct 2026 20:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793130864; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=e0cNosVIvrwrLg1oyemNTICbA8kWNi/5IpjZtAuHw0M=;
	b=qfkxsh1rAKW1wNqU8PbiW83tUJZduSKcfU8wo2MTD+9rHU3bhPu1ho28M3p+gnufPyymoi
	QDW1CSorX6F8MQBsYQv3IJzhpe8bDC71URfOQn/PXZ9Pz/z+ZHzP8qy8YZJQvgP+now76U
	WgeyUkYoEVE8uJKtcajo/wcBycWNVDdk7qNbyen3oeSDIuVVWHsbEtCbGxHVY8063l5A5U
	ljeVT6IMizyZfwO88E69Mg9lgPqPkaTSQzdcy5kdsYJhIlsa2Hd3t41e2cgCTT9f41aXdQ
	w/7Xmxk82cKqeS89nNoqXsFcuy+KiZM6To8QZlXgYT7zw9gY7F5vi34DK7L6Fg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net 0/2] octeontx2-pf: fix ipsec transmit error paths
Date: Tue, 27 Oct 2026 20:54:05 +0100
Message-Id: <20261027-nb-otx2-ipsec-tx-fixes-net-v1-0-2114c4f10c36@tipi-net.de>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2oE2YBR/RVykya2Oi7RkogRK/
 71TXZ77OCspikDp1q1U8BWVORsMp47iK+QnWJIxud75oXcXziPPtTmWRRG5Np6kQTmj8vkaJ58
 QkIInEywFv9L+d7IBPf6hfsY3Yj20tG07WEHQcYMAAAA=
X-Change-ID: 20261027-nb-otx2-ipsec-tx-fixes-net-58cf6deaeda6
To: Sunil Goutham <sgoutham@marvell.com>, 
 Geetha sowjanya <gakula@marvell.com>, 
 Ratheesh Kannoth <rkannoth@marvell.com>, 
 Subbaraya Sundeep <sbhatta@marvell.com>, 
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

Two pre-existing bugs in the ipsec transmit error paths, flagged by the
clashiko review of my earlier ipsec fix for this driver [1].

Both look like edge cases to me, but at least the path in patch 1 (an SA
removed during rekey or teardown while packets are still queued) looks
plausible to me. But don't take my word for it, I'm not an octeontx2 user.

Compile-tested only, I have no octeontx2 hardware.

[1] https://lore.kernel.org/all/20261022-nb-otx2-xfrm-unshare-net-v2-1-5590c9325bcd@tipi-net.de/

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Nicolai Buchwitz (2):
      octeontx2-pf: fix skb use-after-free on ipsec transmit drop
      octeontx2-pf: pass the skb to otx2_dma_unmap_skb_frags()

 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c |  5 ++++-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c |  5 ++---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h |  3 ++-
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c   | 10 +++++-----
 4 files changed, 13 insertions(+), 10 deletions(-)
---
base-commit: 06e1899f01565572d746a8c9ed1bc94041dd7690
change-id: 20261027-nb-otx2-ipsec-tx-fixes-net-58cf6deaeda6

Best regards,
--  
Nicolai Buchwitz <nb@tipi-net.de>

