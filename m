Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F284EB872;
	Tue, 22 Sep 2026 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115440; cv=none; b=DNk9acVPDx/JV6U4muNcqZXVp+a5gkwdMURpJ6ISpxyliIQZkIEJrKpCyMLxnqVTbGd6regRWnWyyYNQHL02O/65zV46r0DaQl1MchgflVJPx2z3XkYEXMMF50sD4XC9CeJI4LDZ60afvtQA9Nsf7kbLCslhByDsNPH7j7TR5F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115440; c=relaxed/simple;
	bh=JYvjhNDYGhs5rJldHmD9vwIambpYeVwpV62wUGcNrR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p02qbn+VLtzXl0qhbi8EPaDlX9JDnqHAQQmehs/WD3wNtHKEKz9IKWjDd0rm1V2BCufz8hCDJj2fV/oMAshPqV+LAFxoVEyF1mxOCtBoLOzn8babevVirqpmxdLwqjex9igssCAfl9c/Lf6UNWoZBftwE/kf7pT2CCigP6MXC2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VQbExmpd; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VQbExmpd"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 0F317C0003CA;
	Tue, 22 Sep 2026 15:17:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0F317C0003CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790115430;
	bh=JYvjhNDYGhs5rJldHmD9vwIambpYeVwpV62wUGcNrR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQbExmpdavQHPS7o08QlwLPKlZSY9iyAdKycUwJIpBp6aBKvOWvn1APfiE1UOfCBF
	 YkClfZNHB5+H1lHZxw260RyYavopH0iZBS1jZYD+ecEsXewA6dtRKph3HHi5GwKjBr
	 Xz3GW5hO/ky+U9Qflvwue+Gp3w2Fcfyp8yCjT7/Y=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id F3816AEA3;
	Tue, 22 Sep 2026 18:17:08 -0400 (EDT)
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
Subject: [PATCH net 3/6] net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
Date: Tue, 22 Sep 2026 15:16:27 -0700
Message-Id: <20260922221630.3864427-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922221630.3864427-1-florian.fainelli@broadcom.com>
References: <20260922221630.3864427-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bcmasp_rx_poll(), the driver removes a 2-byte alignment pad and
optionally strips the ETH_FCS_LEN CRC from received packets using
skb_pull(skb, 2) and skb_trim(skb, len - ETH_FCS_LEN).

If the hardware reports a descriptor size smaller than the pad and CRC
lengths (e.g. runt or corrupted frames), len -= 2 or len - ETH_FCS_LEN
underflows u32 len, leading to out-of-bounds trimming and memory
corruption.

Check that desc->size is at least the sum of the 2-byte pad and the CRC
length before proceeding to process the descriptor.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 9ad5a982542f..2ad8a7eac888 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -523,6 +523,12 @@ static int bcmasp_rx_poll(struct napi_struct *napi, int budget)
 					DMA_FROM_DEVICE);
 
 		len = desc->size;
+		if (unlikely(len < 2 + (intf->crc_fwd ? ETH_FCS_LEN : 0))) {
+			u64_stats_update_begin(&stats->syncp);
+			u64_stats_inc(&stats->rx_dropped);
+			u64_stats_update_end(&stats->syncp);
+			goto next;
+		}
 
 		/* Allocate a page pool page as the SKB data area so the
 		 * kernel can recycle it efficiently after the packet is
-- 
2.34.1

