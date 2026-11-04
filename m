Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793805575;
	b=38rMhQTn6U1HiBAWcE8CTVWeLtjVESsug+scIrSUSxEz7vKVlqMu3lOwfSKzVtiSmwa1
	 hu4M9W7PWIAvbn1psLyxgSlM5+zcLvDaXpr3De/Wl+h7Et34pnp63aPpkPEGjeBGMdSNz
	 O+VenxFylFw/CkG9YMGR1Qp/n9J2sSK2YSoXd5hsyhEUv6sl3+peYdy8thXa50MhuaPMq
	 fWcYK4qJwHp24URhDFI5e++2WFwsBIsOixIvmyOkOF5FPZkuxE5diJsVTtGOLe0YXoqHS
	 Z795066sLaTZWVH9NjJbTmn3G/6cQWP4yYMZ1LXa3xvKrFGjC2HK2dT2vAKrNa/mWyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793805575;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bLOJZaXgrljjby6d2ZZG7h7GGo4k7OpcvIB3L0adEqA=;
	b=3eP+BOiYeDlf92kJ2M6D0FhU9MRDqrFdJ6C6dD8mJFhk/mqqUemtAWH9Eie8PUJ7XwYq
	 +YR5ftHDO+onqSjSV/gToXi+BFbWJ7/y7Ww2G/fx34LmURLGPbV8qauNfkPdrEaK92gbI
	 rEw9o+lbksgTuOQcqxdw/86JEg0DnGlvqTLVwa8DTWLtmiasUOxFOnj3eKFVjXnt9iB/k
	 hk3Z0fZbhE7wUcbmlZSCohU6W1DdflIQniRcsE9lFtZRTqvU4nvMQTTzK78LvWraJsr0v
	 sSZmH6o8i1efOBgjaj0CoHMHE2PX/zVZLtSUL0b1ZWZ7S2QJGLjYVmw889dTiLXTj/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0491606EEBE
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 15:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0491606EEBE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dee593f18so647508f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 07:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793805573; x=1794410373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bLOJZaXgrljjby6d2ZZG7h7GGo4k7OpcvIB3L0adEqA=;
        b=STHjdIsD5G9Yqshvd5i2hZsdPIh5nHwGgzSzog6l8DHBWEVMC5LikdsDGQEi7sZrc5
         G/uV9Ez+BrZKJoKKB60vaXhdRinqayzT8TVrimER5uRZ30EAOv5jFaUSu/wCZ9J02ox6
         ZUUeWbXTDMSw/qh1Sl6mTWwE9TubcYqbSkDhgacn39gnX8LQYcVuyOWELAE1L1F/+HXU
         tvMM9N7iPHFmmDS61N2d99oRdN+GeT3TpI87Lw4SaXrcXCyVfcL/pX5thHRA+NujDi18
         ECAHcLbk/Hp41bzqLS2NDYmjhoWG5iXpYfNucB+0F0XVTfupz34hcJJccrSPFoQEeGRP
         3sug==
X-Gm-Message-State: APuU4Z+swsehqva06cWxnCCO+YjGxuVPZ4Fu3apn4yx/5J75Munlf1lp
	5bcRHbmjN0FnLIUxNQoFY/r9zvvllJzQXcYFcbrMuTXB3k9/ADphgLAhiysz+047pXQOr0fC8dD
	3+Q7EGkkZ7iQU
X-Gm-Gg: AYBFou1svIN8i1AMVvIoF8Sg0kDWNZxBXaBJlBlBx/uUZ0bB7r2SMEFEBBo5UvzmZIY
	pHlymqfE9yhH8j+zu9d1V+at8peORHWDyvPJn4detDCLqkbRctpePsKF6f9ZK01vr+8Vg8JEzF4
	0V0rtvvgRYqAgRGlxYnRK8CE8SIGd9xaeexsyPOB9xgpZwye0wi/ejGlNMAVkS84Cg8wbRu4tDb
	UMg3g0ILHOprZvpA2ks51QqR44xiZ2zwP4tZSZlyTaqo7jmNNzY8fL1ILW33vGx5UQA4rcRzYmD
	rFNU54eGJYOJKdVlVcCxxeO9RfEpqb46GMZMq/8jvruCDLI/hp+Uaf3RRaTGoizwqvFIY+VNSfF
	O8KVPX0Dp+d+/FwW3wtJRmOKegJuHkzz5HfogJoHYNLmZ6xq1Bfj5hVsoKw9gtM2fvf5BVlMnrf
	t00vOXXQA/DhhE8yntwLr0Z4+vV8g6MvMR3cGQOooAR1nzVSDv0OXxOUxpyNWe8lwcAARt6wRMG
	5WAZk1lT2PgxdjX1xe52GbR/4Y3e8WhAIT6UblOkjHIAT5ncRz+BPTzyPrP9NcMcNX8IZQOaV3q
	wLn6Pd/BSAuaNkhI26xh6iq7SngeJcnGhLDoCsQpEkbafqI=
X-Received: by 2002:a5d:6950:0:b0:48e:3bc4:a367 with SMTP id ffacd0b85a97d-48e6e2fab84mr28602707f8f.33.1793805573103;
        Wed, 04 Nov 2026 07:19:33 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:4366:70cb:bf82:f8ac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8e29sm4639812f8f.19.2026.11.04.07.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:19:31 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: netdev@vger.kernel.org
Cc: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Christian Schmidbauer <opensource@grische.xyz>,
	stable@vger.kernel.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/3] net: stmmac: dwmac1000: stop hardware from dropping checksum-error packets
Date: Wed,  4 Nov 2026 16:19:13 +0100
Message-ID: <20261104151914.2651241-4-opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104151914.2651241-1-opensource@grische.xyz>
References: <20261104151914.2651241-1-opensource@grische.xyz>
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

When the checksum offload engine (CoE) is enabled, the dwmac1000 MAC
silently drops any frame for which the engine detects a checksum error,
before the driver sees it.

This breaks VXLAN over IPv6 with zero UDP checksums, which RFC 6935 and
RFC 6936 allow for tunnels.

Set DMA_CONTROL_DT so that such frames are delivered instead of dropped,
as commit fe4042797651 ("net: stmmac: dwmac4: stop hardware from
dropping checksum-error packets") did for dwmac4. CoE remains enabled,
so the driver still sees the error status and marks the skb
CHECKSUM_NONE for the stack to verify.

Set the bit only with enhanced descriptors. The normal descriptor parser
does not report a checksum-only error to the stack, so cores that use
it keep dropping such frames in hardware anyway.

Tested on an Aruba AP-325 (ipq806x-gmac-dwmac) with Rx checksum offload
on.

Link: https://lore.kernel.org/all/20250625132117.1b3264e8@kernel.org/
Link: https://github.com/freifunk-gluon/gluon/issues/3783
Fixes: 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers.")
Cc: <stable@vger.kernel.org> # 6.6.x: ee0aace5f844: net: stmmac: Correctly handle Rx checksum offload errors
Cc: <stable@vger.kernel.org> # 6.6.x
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>
---
Depends on patches 1 and 2 of this series.

v2:
- Set DMA_CONTROL_DT only with enhanced descriptors. The normal
  descriptor parser does not report a checksum-only error, so cores
  with normal descriptors and Type 2 CoE keep the hardware drop.
v1: https://lore.kernel.org/netdev/20261020190319.884375-1-opensource@grische.xyz/
 drivers/net/ethernet/stmicro/stmmac/dwmac1000.h     | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
index 1de1f929d61c..004e6e30a68b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000.h
@@ -163,6 +163,7 @@ enum rx_tx_priority_ratio {
 
 /* DMA operation mode defines (start/stop tx/rx are placed in common header)*/
 /* Disable Drop TCP/IP csum error */
+#define DMA_CONTROL_DT		0x04000000
 #define DMA_CONTROL_RSF		0x02000000	/* Receive Store and Forward */
 #define DMA_CONTROL_DFF		0x01000000	/* Disaable flushing */
 /* Threshold for Activating the FC */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index 3ac7a7949529..31d5f79ef560 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include "dwmac1000.h"
 #include "dwmac_dma.h"
+#include "stmmac.h"
 
 static void dwmac1000_dma_axi(void __iomem *ioaddr, struct stmmac_axi *axi)
 {
@@ -129,6 +130,13 @@ static void dwmac1000_dma_operation_mode_rx(struct stmmac_priv *priv,
 {
 	u32 csr6 = readl(ioaddr + DMA_CHAN_CONTROL(channel));
 
+	/* Deliver checksum-error frames only with enhanced
+	 * descriptors, because the normal descriptor parser does not
+	 * report a checksum-only error.
+	 */
+	if (priv->plat->enh_desc)
+		csr6 |= DMA_CONTROL_DT;
+
 	if (mode == SF_DMA_MODE) {
 		pr_debug("GMAC: enable RX store and forward mode\n");
 		csr6 |= DMA_CONTROL_RSF | DMA_CONTROL_DFF;
-- 
2.54.0

