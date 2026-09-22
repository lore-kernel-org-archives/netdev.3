Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555023CCA02;
	Tue, 22 Sep 2026 22:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115985; cv=none; b=ZKxOdhXL0QRZuHgmHBnLho4QXSCeVhmJq7/z40/3necj4Ot9eqyhyqM3RfpLjzm8V+wxKoquj7dZhCJDY4dNZU8YumZMvKQHB8z6ZWmB8I9PDP9BFWBYpg4B8+ASVWAoTRNm8dJmQWPvpsWZNK8l/F3KZ7QyUmIh+2X8gRFjuTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115985; c=relaxed/simple;
	bh=6GY1P3CT+TECcK8vmqgbIz43cZ8RnreV8QocW0PnAb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PaJZHuRehYOmsArZtFhDAYEDy4gghaxDbMSyijtxCicuOGeCVQn6A7hHxczFREsT6IHy5eTkwJMNn9d0Gx0QPYEuiBRRj6wT2bKbFEG6VVgTPfCqh+HCwNRTWxGNY5NE+WLG0/Dw7CdCFimyCFCcmwnHX4ZmOIcVrRY62yF22a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VCh2WA0Y; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VCh2WA0Y"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id BD365C0000E7;
	Tue, 22 Sep 2026 15:26:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com BD365C0000E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790115974;
	bh=6GY1P3CT+TECcK8vmqgbIz43cZ8RnreV8QocW0PnAb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VCh2WA0YKIHse8TBYrDEbTnq4iKn9hQ/HbZYYqqCGDoveNZWqq6ATpit9w5+fTKnB
	 S0cOdBKSe7ckYX37TWmcKJ0r+wJCfg56M4gsKYlgbpchc2+anAC9/Wp5z5hh1Ba8tD
	 LVfAzDHw8aprBDDAZZbeaIcgO31DP6qHSPLVav3o=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 97CF3B06;
	Tue, 22 Sep 2026 15:26:14 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 2/2] net: bcmasp: remove duplicate MDA filter register definitions
Date: Tue, 22 Sep 2026 15:25:25 -0700
Message-Id: <20260922222525.3992167-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922222525.3992167-1-florian.fainelli@broadcom.com>
References: <20260922222525.3992167-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the redundant duplicate definitions of ASP_RX_FILTER_MDA_CFG,
ASP_RX_FILTER_MDA_PAT_H, ASP_RX_FILTER_MDA_PAT_L, ASP_RX_FILTER_MDA_MSK_H,
and ASP_RX_FILTER_MDA_MSK_L in bcmasp.h.

Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 8c8ffaeadc79..b08a7ddc4c64 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -80,11 +80,6 @@
 #define  ASP_RX_FILTER_MDA_PAT_L(sel)		(((sel) * 0x14) + 0x108)
 #define  ASP_RX_FILTER_MDA_MSK_H(sel)		(((sel) * 0x14) + 0x10c)
 #define  ASP_RX_FILTER_MDA_MSK_L(sel)		(((sel) * 0x14) + 0x110)
-#define  ASP_RX_FILTER_MDA_CFG(sel)		(((sel) * 0x14) + 0x100)
-#define  ASP_RX_FILTER_MDA_PAT_H(sel)		(((sel) * 0x14) + 0x104)
-#define  ASP_RX_FILTER_MDA_PAT_L(sel)		(((sel) * 0x14) + 0x108)
-#define  ASP_RX_FILTER_MDA_MSK_H(sel)		(((sel) * 0x14) + 0x10c)
-#define  ASP_RX_FILTER_MDA_MSK_L(sel)		(((sel) * 0x14) + 0x110)
 #define  ASP_RX_FILTER_NET_CFG(sel)		(((sel) * 0xa04) + 0x400)
 #define   ASP_RX_FILTER_NET_CFG_CH(sel)		((sel) << 0)
 #define   ASP_RX_FILTER_NET_CFG_EN		BIT(9)
-- 
2.34.1

