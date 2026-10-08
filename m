Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CBB36495F;
	Thu,  8 Oct 2026 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494155; cv=none; b=JfOJxBOqbXC0CCELU0JEu5WzNrMrzhSxYSncn06ipycCLoYwuVjlY+tdjOCItKW+0iF7eOoXf3RWKtUU1pyyRQ9asWjZjztQlC1IpFkzC6ix+4zC7RH+To8CG52DtKR4sEvnAnbpiy2gnTe5z8pVHHurkTjziIBfAG28okaE61Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494155; c=relaxed/simple;
	bh=VvHDwgLrgpQm4MhBLTm4+NzNaIJGN4I3n+kWtTspTr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U/wTd3XSiDUob7B6Oi+IQW8p8fhbVlOHYmRJwjVH2YbP/c/sWWxn/LBIwlEpbU/Yl4DlbgO41BmxpcSWOcHwrRFBYaXFAL2B8Y9Em1U7rbW68C+gXakkseql/6ga6P0c6vttAmsP0RDC8PW9EuA+PwbdPgqxQLflKQrs5qSnlaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TLhSfx+M; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TLhSfx+M"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 0E335C0000EA;
	Thu,  8 Oct 2026 14:07:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 0E335C0000EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1791493647;
	bh=VvHDwgLrgpQm4MhBLTm4+NzNaIJGN4I3n+kWtTspTr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TLhSfx+MNnRkYkxU5h2+mCQSYKWpFHdm1gyTRB6mPUnHMzpmGY99ngo/yiy2WETct
	 Sy4xoug+/tPIqbWUoDZiZ01VoPcgT88hzVHYLqHwrgaESzRf9y/BjfjzeHGZ+USqmN
	 gFYYCzX0y4g3KetuqjZDuVWPbt3gjSE7+uqB0HME=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id DB8BEA88;
	Thu,  8 Oct 2026 14:07:26 -0700 (PDT)
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
Subject: [PATCH net v2 1/6] net: bcmasp: fix mib counters struct alignment with ethtool stats
Date: Thu,  8 Oct 2026 14:06:16 -0700
Message-Id: <20261008210621.1374785-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
References: <20261008210621.1374785-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When EDPKT stats were removed in commit e9f31435ee7d ("net: bcmasp: Add
support for asp-v3.0"), the corresponding entries were removed from
bcmasp_gstrings_stats in bcmasp_ethtool.c, but the edpkt_* fields were
left at the beginning of struct bcmasp_mib_counters in bcmasp.h.

Because bcmasp_update_mib_counters() and bcmasp_get_ethtool_stats() index
into struct bcmasp_mib_counters sequentially based on the order of
bcmasp_gstrings_stats, this 16-byte offset caused ethtool to read from
shifted offsets: the first four software counters read unused fields and
reported 0, the next four software counters reported the values of
alloc_rx_skb_failed, tx_dma_failed, mc_filters_full_cnt, and
uc_filters_full_cnt, while filters_combine_cnt, promisc_filters_cnt,
tx_realloc_offload_failed, and tx_timeout_cnt were never reported.

Remove the obsolete edpkt_* fields from struct bcmasp_mib_counters so
that it aligns with bcmasp_gstrings_stats.

Fixes: e9f31435ee7d ("net: bcmasp: Add support for asp-v3.0")
Assisted-by: LLM
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.h b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
index 8c8ffaeadc79..9c9721da1662 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.h
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.h
@@ -250,10 +250,6 @@ struct bcmasp_intf_stats64 {
 };
 
 struct bcmasp_mib_counters {
-	u32	edpkt_ts;
-	u32	edpkt_rx_pkt_cnt;
-	u32	edpkt_hdr_ext_cnt;
-	u32	edpkt_hdr_out_cnt;
 	u32	umac_frm_cnt;
 	u32	fb_frm_cnt;
 	u32	fb_rx_fifo_depth;
-- 
2.34.1

