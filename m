Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03180472079;
	Mon, 21 Sep 2026 23:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032481; cv=none; b=Nu59hWhlteNewjdhkpujchCZInYGf1VzrIjpEufGiy3CXHDPEb9De7Fdc7gM5XnDLR6jVHNmoxUYkkLBcWdQa69PXdI2nuAVFRzYEnG27W1UQXDgjf71aT4t2uFeD/80bSLhGkZPjTtJ3B3fSe0Futz1O8Cw3gDcd3NybdMcR5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032481; c=relaxed/simple;
	bh=+2lz5Ib/AOivyKV/aiz2gUyK2CUnonhtaoEzTb66ros=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oDb08ma9zqfl52X4yWTOWDKAUEvzXLYHCgRHJvcOOBRUfmCJQKotHCdiwqs2mSlXBiRErhBnddEG0jWPkPzm0ixh06NIEEKeu0qlxr5KS870HVgcDa6C+25371S6WhvYCZvKA4z19tUW8gj3Z7jUEQorTaOUOCBfKmlbgo3IBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iVZFgctk; arc=none smtp.client-ip=192.19.166.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iVZFgctk"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 258C9C000D84;
	Mon, 21 Sep 2026 16:14:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 258C9C000D84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790032473;
	bh=+2lz5Ib/AOivyKV/aiz2gUyK2CUnonhtaoEzTb66ros=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVZFgctkwiZCZeHkCtnEMvHOyLjUCE4tb0STR1rBnpv21JuJ+F7l5dmwQlJMDZiCr
	 9Wsz3h9tayC+PItcbdLIVj6GK0pNtr/wc+CxZQ5tXYEgbrj5hvXvEF3vMM/QVnuOB/
	 QE1aPB2OvSMNuXFheYZpnL6Ss7ISdIMDPFMn0UNk=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id F1B96AE0;
	Mon, 21 Sep 2026 16:14:32 -0700 (PDT)
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
Subject: [PATCH net 05/12] net: systemport: Fix Wake-on-LAN RXCHK filter enable loop
Date: Mon, 21 Sep 2026 16:12:58 -0700
Message-Id: <20260921231305.394773-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921231305.394773-1-florian.fainelli@broadcom.com>
References: <20260921231305.394773-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bcm_sysport_suspend_to_wol(), the loop enabling programmed RXCHK
filters in RXCHK_CONTROL used an auxiliary counter 'i' instead of the
actual set filter index 'index'.

When non-contiguous filters were configured (for example, if filter 0
was deleted and filter 1 remained), the code would enable bit
(RXCHK_BRCM_TAG_MATCH_SHIFT + 0) corresponding to filter 0 rather than
filter 1, causing Wake-on-LAN filter matching to fail.

Fix this by using the filter 'index' to set the appropriate match bit
in RXCHK_CONTROL.

Fixes: bb9051a2b230 ("net: systemport: Add support for WAKE_FILTER")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bcmsysport.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 78b96b192185..7f2e5e4efb8d 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2652,7 +2652,7 @@ static int bcm_sysport_suspend_to_wol(struct bcm_sysport_priv *priv)
 {
 	struct net_device *ndev = priv->netdev;
 	unsigned int timeout = 1000;
-	unsigned int index, i = 0;
+	unsigned int index;
 	u32 reg;
 
 	reg = umac_readl(priv, UMAC_MPD_CTRL);
@@ -2682,10 +2682,8 @@ static int bcm_sysport_suspend_to_wol(struct bcm_sysport_priv *priv)
 		reg = rxchk_readl(priv, RXCHK_CONTROL);
 		reg &= ~(RXCHK_BRCM_TAG_MATCH_MASK <<
 			 RXCHK_BRCM_TAG_MATCH_SHIFT);
-		for_each_set_bit(index, priv->filters, RXCHK_BRCM_TAG_MAX) {
-			reg |= BIT(RXCHK_BRCM_TAG_MATCH_SHIFT + i);
-			i++;
-		}
+		for_each_set_bit(index, priv->filters, RXCHK_BRCM_TAG_MAX)
+			reg |= BIT(RXCHK_BRCM_TAG_MATCH_SHIFT + index);
 		reg |= RXCHK_EN | RXCHK_BRCM_TAG_EN;
 		rxchk_writel(priv, reg, RXCHK_CONTROL);
 	}
-- 
2.34.1

