Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793574835;
	b=fEMNusqV+i7QCE0Vmz4JRlQLfZRNgKFRfctwM47qM4qjk1nV6q9hDuptp6GPJ7rgZ5J6
	 YTIXZmqEvlTZ1WTWlfWN4yJpR4t7bFET8VlDqCQLnlYiSobA4U1A6joTz9OPbEaK12sl6
	 jhqongIW7GbZ61XQeJl0OPm3tuysB+NwDH/2wn4i0qKIxcPB3MQDffyXPT0F3e2+dmCFD
	 vNU5mYb+0OsB8xZVvMqi47g6OcImQVzcRYiD84d33fGF+7d2rRkFSVVnf0GE+sBOPc7dG
	 iEGZZpIoHFNePNM/uMcp9liGUy36xHNBmK9IZq5hZFkzdjFjfnIQp6UxQpEPS/SA7LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574835;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=31iDTzwoWXre76cM4MNXfxMoFL3mNprXkjRVJxMLEqk=;
	b=n3NYhdoy+Us6N9O92QymQ02ETcWcgreRcWTJruu/mwpnSLewYMK+SWbwX21ns28xuw7X
	 14EogSKv2ZFip+vLj7CObIIe9ch8bRbVVmxDtfrc00rUKuS/po+DT832yJuiTXbJZnUla
	 6RSixTXy5lXmUaqOYobr8Grw9T3OGsGhPMGXo6/IgHrlVF+LgWToX4WuxK2HG+9t8ytDx
	 HQ3O8bZNaf9tp4KoGhaxitQUtkS8e2GcHbNGnyUYkxTLIkiBvLxXovkJL9jt3i85EoE72
	 4JQupytgvcGIU8QTlowbvy15gepf7UKcMYX+bWkSFEMpKI29FAm0trA5yp8LC5/CMrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=OjZBBSCN;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01316606A324;
	Sun,  1 Nov 2026 23:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01316606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=OjZBBSCN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1793574824; bh=31iDTzwoWXre76cM4MNXfxMoFL3mNprXkjRVJxMLEqk=;
	h=From:To:Cc:Subject:Date;
	b=OjZBBSCNgutsbIG/jDpKm5/UgjMtd90U329TMgvALc1hs2O1WBfNG0B6jdQ0V2PWF
	 w253KyCMw1HRcr6jRpulbrth58dZc+4bblKUzAEPjODs1XD8tj5MBI7hqV2FLKsIyl
	 8Hjxgy5fAuSmIB9VOuyY2fsRq1zPmMVl+cPh1y+d6pWtBaR2KbKcQLp/dddCBPLYAA
	 TOEtbXUry9asvz0N58UHifya75QPekXTRfcwGnxGY55N9YC48SZHvR4JSVjsYf/Aep
	 i8P0rzoq8Ao1d+yy6RBBpeZYm56+eYrR7ptCQra32VwZb3ZSMbzCDedn3keNlfuA18
	 syw7KK66XENNg==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 1B94D27A38C3;
	Mon, 02 Nov 2026 01:13:44 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ethernet: mtk_eth_soc: 9K jumbo frame support
Date: Mon, 2 Nov 2026 00:58:23 +0200
Message-Id: <patch-4f863a941889f0bceca1c082f2d79624@loljews.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

This series makes the MediaTek SoC ethernet driver support 9K jumbo
frames on the 10G XGMII MACs (MT7988).  The driver currently advertises
a 2030-byte max_mtu and programs the MAC max-rx field for at most 2048
bytes, so MTU > 2K is rejected and 9K frames are not usable.

Patch 1 adds the MTK_NETSYS_RX_9K capability, advertises 9K max_mtu on
the XGMII MACs (from the DT phy_mode at probe, so DSA can raise the
conduit MTU before the netdev is opened), programs XMAC_RX_CFG2,
derives the shared RX buffer length from the largest MTU, sizes the RX
rings from it, and programs the PDMA RX SDL max frame.  A runtime MTU
change that would need a different ring buffer size is rejected with
-EBUSY while DMA is running; the rings are sized at the next open.

Patch 2 stops creating a page_pool for RX rings whose buffers do not
fit in an order-0 page (jumbo and HW-LRO rings).  page_pool is created
with MTK_PP_MAX_BUF_SIZE and order 0; using it for 9K buffers would
overrun.  The large-buffer path already uses mtk_max_buf_alloc().

This work is a forward-port of the MediaTek downstream jumbo series:
Mason Chang's "change default rx buffer length", "add 9k jumbo frame
support" and "add dynamic rx buffer adjustment support" (MediaTek
OpenWrt feed 999-eth-30/31/33, carried in
frank-w/BPI-Router-Linux), plus Frank Wunderlich's "try to fix crash
the right way".  The per-ring page_pool rule is added here to make the
9K path safe without disabling page_pool for every ring.

The equivalent change was tested on a BPI-R4 Pro 8X (MT7988, 10G lan6 /
MxL86252) on the 6.18.60 backport: with both ends at MTU 9000, 8K ICMP
passes and iperf3 with MSS 8900 reaches ~9.87 Gbit/s (vs ~2.57 Gbit/s
at MSS 1460); the DSA conduit is raised to 9004 at boot.  This v7.3
series is compile-tested with CONFIG_NET_MEDIATEK_SOC=y and
COMPILE_TEST=y; no hardware run of this exact tree yet.

The runtime-reallocation patch is not included: it reallocates the
shared RX rings when the MTU changes while an interface is up, removing
the -EBUSY restriction.  It is a larger change and will be sent
separately.

Sandeep Haemoon (2):
  net: ethernet: mtk_eth_soc: add 9K jumbo frame support
  net: ethernet: mtk_eth_soc: skip page_pool for large RX buffers

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 142 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |   9 +-
 2 files changed, 122 insertions(+), 29 deletions(-)

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.53.0

