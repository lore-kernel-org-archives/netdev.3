Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794621368;
	b=j3/fsGm4i51V3tHI2QxKhLUWAGSiCHCBoFZq3qMIcqmPK2AI76B8jrp7wtxZjVYVbCGN
	 yQXp3yrhOdTMYndKtLwFDQpr8Yae/HHP37mGom7P3UMespYbIz/WGCTXLTKcxhf1KtlHP
	 eU+QECxE6SmXuVeCL/ETmODsZbAaFcV47HjiNPkZPnLPpawoq5eVRT86MRWfe+LrOKzp4
	 hPCKL5P01vTThve4kkekDhpEOzHHZEvC7nu/srFkn79hS9ZsWtSycO0BPt9xYGISLSfny
	 sWqs/lVljO/wzjRcJBhBfYYGCeS+CjDjr/WOc9XWZT2jALWt0xDkYVfuwOS3Qygen6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794621368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h1I4zZU44SQT59N5skU0UP5Zl+f6sTdiRU3S4l9F4sg=;
	b=HIBsOg4KHdxro/MWJmiQBSCQyoimipGKWOKbCLFPtmIQtIyrOvRbEwROimGmLR3BIHbf
	 Ou9DVkGE9ic+43MAwC5L5SHIEqImY2CxHSlfdEUw169Rz+oP5YeuqFYWaagd+QhBtAgbV
	 0AxWkupDhbheEsiwf/FA87d/iEOUNkM+den1rPFFORvw9bMCZed0YpPB7UBCTtKYhXshF
	 M4hAVa+Pr6XMLxiw7+iJwQEp+6BcRAxtn38dD0QHG2bWuV6mfH7ZWbqc+ibY8NsR9auv4
	 A7yqr9Hz11T55J4Sa2/0Iynj31zv3scX8y5dH+e/TF+7A66dLk9LrulfrL8DJsfmJTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Q/mCPAHY";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A6606A333
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 01:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E8A6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q/mCPAHY
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b1d1d74384so11473a91.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794621367; x=1795226167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1I4zZU44SQT59N5skU0UP5Zl+f6sTdiRU3S4l9F4sg=;
        b=Q/mCPAHYooolHhRJp5/geLYcgGPDZgaBv1P5WFHF/TOjZk84J9un/OCiHPIocR47Az
         5h8lro8V4Eh0W+o9Ta7pL/0ZENwV4nwrvDhsgQhFfdQE2pUr4KO548hfUjNEv5V9GyCw
         N2v4kiQMUVe9JmorJpdTAm2bvi2e8W8B+O79iI/AmlGPErD+0xGLhv4sAhPKnINHm0wN
         TrbEFS3WonVLhaukPuhGnZkfpzyHQLeXsYNP2DJr3fbktlN5teDMJ1D/70A3vyi0weZP
         BNeKWAnhDOtj5mNUdhEn5BrVUCTpM3wW3Wby971UFMSXDT+HL3nStVvY+GTz6T8QA+Se
         yI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794621367; x=1795226167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1I4zZU44SQT59N5skU0UP5Zl+f6sTdiRU3S4l9F4sg=;
        b=dLxqwDq2A8k01Hxk3+2hTIOJVKMa5+orYF/caw9QcrHXvE1Umf7E16ErEOsCJTFs4p
         GemeKanUiAz7Ld+FrruJ+dF9BtjcxKjXF2Ascfzyi5VV8+Q9FYpgop6MqNuCBBVUZRTr
         zsxH6TojAMnF8pfWQ5DwMiJdy6pnhXZlHgAZaEpqlMvJ/TXl+KvGUWlk7+igXMdYuAo7
         W8aq4OeHhCKWpiNEGssUjG9SFdrD1vA8PJkAHxL9kLtS4+xS9bcZTbB4EuQFntEFDU7D
         JsMP9Mlx1upEHD1Kjc7jQGhIYR8oNFQOSQaKqiof8pwpDQZYKaCqGv2MNqtvQjx9tywg
         g+/w==
X-Forwarded-Encrypted: i=1; AL+hErEXnDBNILEVtpgc8N/mwjkRgg2m8SwryAQX6M8DjPRol69T1EWX+Sjgp2aRsmvGz1TbqUvOS4I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Aj1h4EqU15qeZNIXpgFJTCabhbt7tDwDQe1usHVlT5oBsMvB6
	rAXWejQg765A58Yfvl8fitnGzCaQUuWGj8yfZcHkjA/429JbIb6mCk0V
X-Gm-Gg: AYBFou1skviJ1SFzLU48nIHpZaXNwP71UOPFUk/JkyeWzePLmr4R9QgYMs3NBDCD7EY
	fzNalHV8NKAT5ewvlZpxW0pXeJLK6S+VdoVKDz/8Fve9ltksUiZQngyxxR49+mweQKretfRk3ex
	RD6+Z47pmoZ141UoEu3mZNPCc3WEXDhmt+fEfZ0Z5xvAsql5ffnwmX58POtVHRPJZQ7VYQGXf6i
	L8A1Fh5dWILNbaUjhAGDzngfsKLCLzABbRcGm4rtwE68mU8+PPd2JlYJZ7wsy4Ashnmz/IaPAFN
	5ahett8uTcsVMtk9xhFtHab3g1BOh+X1/T4WgBM3VmlEpkvdvEZSJGZb90VjlnXk4f6vTRH1zl6
	GGd24S9Vn0OGmPNIgStzStge+2EPO37chcJhcxM/Suxth6Aa3jz/b6gMQl/VVRF+pDCFXpfbq+F
	8H64SyupzO1sKVQyogREYBWGdF0LKSSQKpEIKmV4F5L4IrOL9mpCVMTiJOMzjxFj9KsjwIApHt0
	e4Bd+nRC0XNSqmPTB8QwaB8gT0axRAj2lmnHM9jioOG6GGr/iCuhVRTmlpWa+rhgTw4WyXMtB49
	nlUzjYuI021IQsGUGap/03vFRVky
X-Received: by 2002:a17:90b:33c7:b0:3ac:4291:f569 with SMTP id 98e67ed59e1d1-3b1b089e2cfmr4020163a91.8.1794621366556;
        Fri, 13 Nov 2026 17:56:06 -0800 (PST)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3b110c0sm3084124a91.3.2026.11.13.17.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 17:56:06 -0800 (PST)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	horms@kernel.org,
	0x1207@gmail.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: stmmac: re-enable on-chip parity checkers for XGMAC ASP 0x2
Date: Sat, 14 Nov 2026 09:55:54 +0800
Message-Id: <20261114015554.2187341-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Commit 669a55560e4b ("net: stmmac: Check more MAC HW features for XGMAC
Core 3.20") made dwxgmac3_safety_feat_config() bail out early for
asp == 0x2, assuming that configuration has no parity protection.

Per the DWC_xgmac databook, the ASP field of MAC_HW_Feature3 selects:

  0x1 (AS_EPPE):  all automotive safety features, with ECC and parity
                  ports on the external application interface
  0x2 (AS_NEPPE): all automotive safety features, without ECC or
                  parity ports on the external application interface
  0x3 (AS_PPE):   all automotive safety features, with parity ports
                  on the external application interface

The reset value of the field is defined as:

  (DWCXG_ASP_ALL && DWCXG_ASP_PPE == 1) ? "3"
  : (DWCXG_ASP_ALL && DWCXG_ASP_PPE == 0) ? "2"
  : (DWCXG_ASP_ALL && DWCXG_ASP_PPE == 2) ? "1" : "0"

so ASP 0x2 implies DWCXG_ASP_ALL = 1, where the internal FSM state
parity and timeout (MAC_FSM_Control) and the on-chip data-path parity
(MTL_DPP_CONTROL) features exist; only the ports on the external
application interface are absent.  The early return therefore skips
enabling safety checkers that are present in the hardware.

Drop 0x2 from the condition so the FSM and data-path parity checkers
are enabled again.

Also update the safety feature descriptions printed by
stmmac_dma_cap_show() to spell out that ASP 0x1/0x2/0x3 differ only
in the ECC or parity ports on the external application interface; the
previous wording, "All Safety Features without ECC or Parity",
suggests the on-chip checkers are absent from an ASP 0x2 device.

Keep the early return for ASP 0x4 (EASP), which selects only ECC
protection for external memory and has no on-chip parity features.

Tested on XGMAC 3.10 and 3.40 cores.

Fixes: 669a55560e4b ("net: stmmac: Check more MAC HW features for XGMAC Core 3.20")
Cc: stable@vger.kernel.org
Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 6 +++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 1a88cbaed70c..6b2bfc241109 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -859,10 +859,10 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
 	value |= XGMAC_TCEIE; /* TSO Memory Correctable Error */
 	writel(value, ioaddr + XGMAC_DMA_ECC_INT_ENABLE);
 
-	/* 0x2: Without ECC or Parity Ports on External Application Interface
-	 * 0x4: Only ECC Protection for External Memory feature is selected
+	/* 0x4: Only ECC Protection for External Memory feature is
+	 * selected, without any on-chip parity protection
 	 */
-	if (asp == 0x2 || asp == 0x4)
+	if (asp == 0x4)
 		return 0;
 
 	/* 4. Enable Parity and Timeout for FSM */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 25894771e9e9..24f887df88fa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6741,9 +6741,9 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 	};
 	static const char * const dwxgmac_safety_feature_desc[] = {
 		"No",
-		"All Safety Features with ECC and Parity",
-		"All Safety Features without ECC or Parity",
-		"All Safety Features with Parity Only",
+		"All Safety Features with ECC and Parity Ports on External Application Interface",
+		"All Safety Features without ECC or Parity Ports on External Application Interface",
+		"All Safety Features with Parity Ports on External Application Interface",
 		"ECC Only",
 		"UNDEFINED",
 		"UNDEFINED",
-- 
2.34.1

