Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844923E2AB1
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779282746; cv=none; b=BeP7sbGMFFrn7kCJm7tnatWecHm/V2sPCtyVH2kB8q6Is3VbP2fbDe20/qMYU/g9crt0AemqM4BnH3Gu8CKDbDHD8nVG/T+9j1Vl2shACZmp3BAjfcs9CJ+ZK3NtICatLE3l/w5n4zMY5uUXeGx63/Ginl7DlqATGX+nAB6zBk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779282746; c=relaxed/simple;
	bh=xVc0ntT1Xm5wQxxgWny+ot2kecLmhiZjd7/qdyuv/kQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eeFnFRrFSmDChPPfuX1s+kvUu36zhExz+LCaKBxxfMd8ZlnWBp+FFPmSoS9N3ig9HU+STELw5EAK9cthJQkuF8MYYVrvgSQfgFbQSA1NxrhYv5kpK69+mI1KNX/J5MUMnfPLnGe6C+wYC0T9E6T8wYmRyJyVMU2KXTCYtyKaZ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elEBtTCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elEBtTCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847B31F00898;
	Wed, 20 May 2026 13:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779282743;
	bh=mXaopxgAUyb+dYnMEPNpUoPGlTbsAgez8gJglbBR/V4=;
	h=From:Date:Subject:To:Cc;
	b=elEBtTCQH1mi0PXwjMq+KplsaUDqZ34YzS7/kBjyNcBpBUZIo6vhFsKwnbkVGPM0r
	 TTc2GmfzGKZmrT3Nt8Fi3F8KUHeWIcZZoQr8C2OTvX389ftTiJKcjUAukJhneGBC0c
	 ey63Rnw/c1jtuyQWQhDVF7BcnBSCVz662RQTQHSUFtDgNNyuqvPWcm9TCLcFSdEh8w
	 HYcmypdLkCgra5jEtHQdoPPmtvxemU74V39vlH0oRWtpdc18EUy1lSKl+U1sCy68FA
	 59n3ASXC5IKfVWTuVrIxwAEkZNMTiW5DKWwpDPaAcKJgol3vuu7Q+ILwSExbhO4KLq
	 cS3KtnflTs6Gw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 20 May 2026 15:12:02 +0200
Subject: [PATCH net] net: airoha: Disable GDM2 forwarding before
 configuring GDM2 loopback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-airoha-disable-gdm2-fwd-v1-1-1eeea5dffc2f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqEMAxA4atI1hNoi3/MVWQW1SQacKq0ooJ4d
 4vLb/HeBYmjcoJvcUHkXZMuIcN+ChgmH0ZGpWxwxtWmcga9xmXySJp8PzOO9HcoB+FAYltpqBQ
 rkOs1suj5njsIvMHvvh/BzPOAbgAAAA==
X-Change-ID: 20260520-airoha-disable-gdm2-fwd-cdf18f7d4f1f
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Madhur Agrawal <madhur.agrawal@airoha.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

Hw design requires to disable GDM2 forwarding before configuring GDM2
loopback in airoha_set_gdm2_loopback routine.

Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
Tested-by: Madhur Agrawal <madhur.agrawal@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index d0c0c0ec8a80..cecd66251dba 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1793,11 +1793,8 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	u32 val, pse_port, chan;
 	int i, src_port;
 
-	/* Forward the traffic to the proper GDM port */
-	pse_port = port->id == AIROHA_GDM3_IDX ? FE_PSE_PORT_GDM3
-					       : FE_PSE_PORT_GDM4;
 	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
-				    pse_port);
+				    FE_PSE_PORT_DROP);
 	airoha_fe_clear(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
 			GDM_STRIP_CRC_MASK);
 
@@ -1815,6 +1812,11 @@ static int airoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
 		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
 		      FIELD_PREP(GDM_LONG_LEN_MASK, AIROHA_MAX_MTU));
+	/* Forward the traffic to the proper GDM port */
+	pse_port = port->id == AIROHA_GDM3_IDX ? FE_PSE_PORT_GDM3
+					       : FE_PSE_PORT_GDM4;
+	airoha_set_gdm_port_fwd_cfg(eth, REG_GDM_FWD_CFG(AIROHA_GDM2_IDX),
+				    pse_port);
 
 	/* Disable VIP and IFC for GDM2 */
 	airoha_fe_clear(eth, REG_FE_VIP_PORT_EN, BIT(AIROHA_GDM2_IDX));

---
base-commit: dc416e32baaeb620b9809e9e25fc7b30889686e9
change-id: 20260520-airoha-disable-gdm2-fwd-cdf18f7d4f1f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

