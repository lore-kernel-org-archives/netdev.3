Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8265E1B85F8;
	Mon,  3 Aug 2026 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761335; cv=none; b=EH3t8Ha9DmUJ9ts/ZAY7SnkUrvGlaKqEbf0tsgfHssix50Jw7jIMwn9y75Eg+8auFvqWu89tGpUEi7RfnQRwrbO9EbbLiKI54ttMwAAkkIW7y/AnmjUzlCiYCTRU9ar4u6cF5mapnmIIYDy9oqteMipQtSYRFVRXLiFtUMfJn0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761335; c=relaxed/simple;
	bh=NNITze/YbZA8n+ZpeBoUNYBiV57y68bqQwZ92m3yTow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BRttB96Ri1gL/5SViOzkOnns+mb+vXa6licGSSoBgntBGEjQG+MUy00CJjI7JOIvvVxR5rT4XW91GhgPxUxBeF0LYyli5Wyns8HqhfmeK5TRNOJsXJA1mM6ZYIGvNBuT0uZ2K44CrKSiUFTK3kgpAY48X8tSUXLqcaB03W6bCxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OWWAPRhy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OWWAPRhy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785761334; x=1817297334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NNITze/YbZA8n+ZpeBoUNYBiV57y68bqQwZ92m3yTow=;
  b=OWWAPRhyLjE6QzOx5FNNL00KbY6gBP5WP6Fbl/ledbSZzQVR0Hhfwhcp
   PwEyA4hE/x+rkpAkZFT2Jrc1UJjxdE8ihbZZqGff2xnTyyy19vIWiU2Z3
   LGbztjSSFWS6H6Zzt5c/yDiGsJN6w1WKuJ9LoStZhV7pYgEkldRXeHUgU
   e/febNPntqTYXjuvz2yerw17if/q4UBkGGoH0hxveL3kLOdVqzLkA40c7
   UE9kiww4femgu18PwMbCl+6pgQ+WXOwETa/HnPYLKYTkLo1h5HCge66I1
   Dga94rWj2JuxIP96TrK+ly3rJ3IeNM2xZ7IR0nNB53nBO8Z+6NtCKlTtB
   g==;
X-CSE-ConnectionGUID: s5O+9fu3QL2mJCy0DPIhFA==
X-CSE-MsgGUID: LiiZx+FlTxKBCZZ1g8tgOQ==
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="61875678"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 05:48:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 3 Aug 2026 05:48:53 -0700
Received: from che-ld-ungapp03.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 3 Aug 2026 05:48:49 -0700
From: Dhanushkalyan G <Dhanushkalyan.G@microchip.com>
To: <netdev@vger.kernel.org>
CC: Bryan Whitehead <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Thangaraj
 Samynathan" <Thangaraj.S@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/2] net: lan743x: speed-based and user-configurable interrupt moderation
Date: Mon, 3 Aug 2026 18:18:45 +0530
Message-ID: <20260803124847.17315-1-Dhanushkalyan.G@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The lan743x driver programs a single fixed interrupt moderation timer
into all per-vector INT_MOD_CFG registers at interrupt open, regardless
of link speed and with no way for userspace to tune it.

This series makes the moderation timer follow the negotiated link speed
and then exposes it through ethtool:

Patch 1 sets the timer as a function of link speed in the MAC link-up
path (64 us at 2.5G, 150 us at 1G, 330 us at 100M/10M) and separates the
static vector-to-timer mapping (programmed once at interrupt open) from
the per-speed timer value.

Patch 2 adds ethtool .get_coalesce/.set_coalesce with
ETHTOOL_COALESCE_USECS and ETHTOOL_COALESCE_USE_ADAPTIVE_RX/TX. Adaptive
mode (the default) keeps the timer tracking the link speed; disabling it
pins the timer to a user supplied value. Because the hardware uses one
value for all vectors, RX and TX cannot be tuned independently, so
mismatched rx/tx requests are rejected.

Dhanushkalyan G (1):
  net: lan743x: add ethtool interrupt coalescing support

Thangaraj Samynathan (1):
  net: lan743x: set interrupt moderation timer based on link speed

 .../net/ethernet/microchip/lan743x_ethtool.c  | 70 ++++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.c | 71 ++++++++++++++++---
 drivers/net/ethernet/microchip/lan743x_main.h | 14 +++-
 3 files changed, 144 insertions(+), 11 deletions(-)

-- 
2.34.1

