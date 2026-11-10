Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794354328;
	b=W6mv1S1PatdguU+x3p5lySTtpCz5n962hcdJ8xV/pBd2bjmFv3h2bbQRGXVqsA40+E2r
	 LMJW3e9+nCPLjDhyCXbigtlYeg2nB9SyHnPWGjv2/uU6T6hMM9smg1tIt8vsYRaaeTnY0
	 6hHjzTEtlUj5/9XqO9fwokpUIU3Hku+VGPZKUzAUO5YRyWMPlJg6qKyICLGq7fqRDX+wO
	 Rh7ELUuTVyH6gUj7wj4j0lnRHN06wbtEakibVduYaRbgTkS/q7CdtoI9a/b39AFpputZO
	 5b0Zc3lU8325MZxBWuTKFDZPM2PR1NXE7FR3JESD/u7+Z5gtJKIfZquUM19YYsT8tnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794354328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=gP1I/aOHIVkz2RYwsuJe4lOo/+53CVtE6Vrdu7o0FP0=;
	b=RRbTRvQIsh+oz2GG/TVqdMsAb/CJ+mLf+3ldisAur/hyE0+rCrs30tQGK4QTVr4R83Xp
	 GKE55/A1qiyeC4Y55XSgDwfs5O0lgNQn1myCAPH1mcPNKZjD/q9FQjW61HTtgTBeiO8f3
	 dZzHNswoHZXWpKe87Ee59wg1k0VncHuIzr2Bm6OW3zXOjs2O6IwxzI0ADhhJ+onEbrGDw
	 HgvnxU/pyXeLUz0rjnWeYLc9A09TlrLR5qySUOobc9uGPEFqGwAvb+y2siOCxsGiIslwJ
	 vdy+GtB21+VkwdUOCZuUaaYVb4g9dsEgnkx0Ugvm0uVhCOi8wBwgM+Rv4DHfqsBFVkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IEMkjv+f;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05EA606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 23:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05EA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IEMkjv+f
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so4146400c88.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 15:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794354327; x=1794959127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gP1I/aOHIVkz2RYwsuJe4lOo/+53CVtE6Vrdu7o0FP0=;
        b=IEMkjv+fJbbU0GSmzqVFP1dzDPtfTCeitmnM1jrhu8UhLH698xn8qHmqGSuLfYLKa3
         B/MoqZb05I0eh5gJrL+Rv37iOIaqrQgr75F52Rptj00aAXcOKSqTZR03n0JdeINSu830
         yct8sSlD+6Go1sxuoxY8B7xRpa07KBi7LQ3qKmcyh3TiUMJKQoEpCWlKpugWbBdJJ4DH
         n+1xiQCiEajwhuYY2p/rEKsR97lo1Jr7xbOvxohweW1Clk69ZJWEJGFpm+OSU66wc3Nz
         SeYGDqt/VHIuPXgSgN0o43upupnMcnR8/7phZNZjh8uyNJkyRzvTR3SZIk+9zRgGDB0Q
         QSSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794354327; x=1794959127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gP1I/aOHIVkz2RYwsuJe4lOo/+53CVtE6Vrdu7o0FP0=;
        b=eTWjruowT/YXThY9cruUfz1c+z0IcpNsXtCq8VwjhfcTjZdwaVIkMTtuExfbJa3a0x
         BDpkjHHSA239w+5P1NeuxD/GU8BRPyWhBANyrB7bYK9F8SK4Y/N7avG8DYrwRMc5Y5cN
         R8ibH79St+0+Fk2k/YtCAVLtD+NA88AXddnV3WtbxxB/P54cM8lwNybmqvdFbDmK8N9t
         ybFRfIuHLYxhSleaN+aftiL1tjgBml4B9nGWYdPBMULGPhHcQGTLZJG15m7VOEEqQZbB
         fUkOpmQN3iB8ctEkUVl4KW45Cn3ZPI8uc7pMbCt6hf22moabUOhqI1SYeaPFfPUIzWLP
         X8Sg==
X-Gm-Message-State: APuU4Z9kP4HZpMNyBAW3vPrlwpubOYrnjjMiqSkPcMmC+PK9SXgQUphz
	MQa3hbP+sfbsK15v/CH0+6cJeYg4RGPOL02DWKknfkrbVTwjHErKZkesCwKaQg==
X-Gm-Gg: AYBFou0Bhw9HT7TXomdI+3nY3OauN7K0e8XijhSvBDw8i32jvJC33LYUGQzHWeeGJQE
	Row/H9k5rw3RH2XRxpRuNrBuMuQ/riZ8ZAdBGqt6lwZ8NgkOCCJjCNNBrOGlk/Zeq1Tgy9IkOEB
	aennAkYO2Sr7sDoeJesloRRq04ZgWuSslARgQoEFdEVu7wSBL0SX993NIxQBdpjeY485nqojEUt
	s2glba8w038bJqly4OIENjnny+NTTZxEB+jVHFonsd/w1xAQ/tOatF4yv+wWWv4LwgpwuiIKby/
	L12oeryzBzm1j+P0i9CzWWcm/WQgm9hC+aLgvgRZ3ANKyJ56LU2J+zrgKv70gEsPl8bMgdb8twk
	oxskzgUAGKDbKhXs3pj6wmfQY4vggNaTCdsYGHX0f6VO/UH9hW+uX+g6K+qE4S18BCqYE35n0zd
	gq/XaBzbMvKCOOOaBscU592BTywcBL58Wn1DqIdaKioMCkf7DPzx1sU18er+YzJRam1LWHj1w1y
	ly5+/1Wl21qGLmqGOXKiCqXKKvZlHNfes2tWzrFdCNaaepWWhqp3xRhft8vpFFXzl8mPabNZ7k3
	ka/Zte/R
X-Received: by 2002:a05:701a:815a:10b0:19a:9a93:c9b2 with SMTP id a92af1059eb24-1b3c02f575fmr660475c88.13.1794354326618;
        Tue, 10 Nov 2026 15:45:26 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b20c55sm9145881c88.8.2026.11.10.15.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 15:45:25 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2 0/4] net: sb1250-mac: ethtool link updates
Date: Tue, 10 Nov 2026 15:02:56 -0800
Message-ID: <20261110230300.2769327-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This patch series addresses a few minor issues:

- Running ethtool against an sb1250-mac backed interface would not
  return any link information, although all of it is there
- There was no support for restarting auto-negotiation, also there for
  "free" with PHYLIB
- The kernel driver reports enabling RX Checksum offload but does not
  report it through the NETIF_F_* feature bits

Changes in v2:

- collected tags for patches 1 through 3
- added additional change to address RX checksum status and header
  offset setup based upon Sashiko's review and checked against the
  datasheet to be correct

Florian Fainelli (4):
  net: sb1250-mac: Add ethtool link settings support
  net: sb1250-mac: Advertise and honor RX checksum offload
  net: sb1250-mac: Add ethtool autonegotiation restart support
  net: sb1250-mac: Fix RX checksum status and header offset setup

 drivers/net/ethernet/broadcom/sb1250-mac.c | 27 ++++++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

-- 
2.53.0

