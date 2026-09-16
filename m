Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB6F44CAC6;
	Wed, 16 Sep 2026 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546478; cv=none; b=s4Z+s5bpnzXX8SVtph6dtEdSr+RTTFZburrKl8NO4kI30P2RIDPsxycUF7SsN5kd8UkEQbG/NVf37+vNRMpsuLQfG0V/5eMHnsLAE7/9tIPlfcllqRrZ7BSdhJtysihvGvXgGZaLGkLCUV/Gfv/GK6DtF7c+GLBANJbtwP7Etk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546478; c=relaxed/simple;
	bh=Pd02UcGb8Nlw+efSj/ToovWghrx8vtQKejJ4ygeqY7E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S/S0z7wCUq8FHz9tyTDsNZtLuxH9sAG5hZoEjXnTglgkFPsUSb+sG/qmYmoYx66aS5pSElCxJdKDH1kb29nd3w2n2fhkhy9ldJli3CIpoYe0E57zokPJLZ2MsdWpcfLvnc3j86ejBx7NIOeiBacZczaaDxnTU8eAN4mgVje1pZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=k3du6MZN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="k3du6MZN"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68G8D81z82222553, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789546389;
	bh=bddv7LOh8I8prGPJH7iCAe8jzLnvPktOVLGUrp7IdFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=k3du6MZNo6QxxSlxkhe6KaPkfEkaU1ExEGfkx29AuYiahbrGxS3a4lLwSiJxXbRAG
	 RXsQn0X2ie2s4RcCKTmIUQjynKWChRdL5P48l6JFLqcg0lSWqZ5iLrDKZA0RJr3HKX
	 mG9YNMVfSZ5yrnSUW97hQILI6F1YkJQgX3YLoy2rFHLqPbN+uRvB1u04bJbtJwKaZ5
	 RMy05ZaynohZ7iS15YYO/uvwNQO3nuKgQos9EMFlqUBZG/uORuj29HhKlJZmtVkKXh
	 1jpbx44XfT6HZZ7ZoNMwNWVFkadVsgeo7pJ5uroYSlGD6cSgIOwTorAq8kAmYbBybc
	 0juSupFLEe13w==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68G8D81z82222553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 16:13:09 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 16 Sep 2026 16:13:08 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 16 Sep 2026 16:13:08 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1] r8169: set eee_enable_default base on LPI cap
Date: Wed, 16 Sep 2026 16:13:06 +0800
Message-ID: <20260916081306.184-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

When initializing phylink configuration, if LPI capabilities is
non-zero, it indicates the hardware supports EEE, thus we enable it by
default.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index b6f7d212ed77..6923069266f2 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -6583,6 +6583,7 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
 	tp->phylink_config.type = PHYLINK_NETDEV;
 	tp->phylink_config.mac_managed_pm = true;
 	tp->phylink_config.lpi_capabilities = rtl8169_get_lpi_caps(tp);
+	tp->phylink_config.eee_enabled_default = !!tp->phylink_config.lpi_capabilities;
 	tp->phylink_config.mac_capabilities |= MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
 	switch (tp->sfp_mode) {
-- 
2.43.0

