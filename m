Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3AF2E7635
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 05:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353087; cv=none; b=L1CfonziPgVlw+XRvPo1CBwlemEoKZmh6mgPFIMTIBi3oRjxdMBrCIz+ZI2xsHt3gtYbscN2qJxuaYTB0QeOmVo2jKlk499qybiI2kp+vJcexKRPefrHCRuBEfYUfcr9zgytSLc1hw0OygjoI1OMeHIybCS/V39P5ncH0N4nAXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353087; c=relaxed/simple;
	bh=IDFwQPFCFY7/4FW3VjvftA4mwDxU7Q59AGp0SdwY1s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qMxns/II9fkH7td+EybxUCftisxadIvMTf0olZaXV9KqYKrKkXuxq14Fium916Va7pxqktaYRDd1RZufMDojQenE5RB5Kw+33R4mque6nSiOKypgFSIGXwY/9+aiCLuOfNT/zU/mOEyawpb5nDqK7bD11NDuQBzgSlI2oI76U+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7Ao+7A+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7Ao+7A+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA3BC2BCAF;
	Tue, 28 Apr 2026 05:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777353087;
	bh=IDFwQPFCFY7/4FW3VjvftA4mwDxU7Q59AGp0SdwY1s4=;
	h=From:Date:Subject:To:Cc:From;
	b=F7Ao+7A+2rhkFm5z4VuffCL4G7falhApwqeyqYpddHvMKIOsLFOcqipD4n97hNCOy
	 bX+LWxzG8NhM14dvfnll/xRbKqLRCbUX8qCVucSBlwNaci+jcDt+J4XZTQ35bldTiw
	 B8+memv2e2OrY4KQi1B2viI+8yNJd7Vv65hLDa+0Dx0/lVNp48Cl1uRoeWkpEc1dZP
	 droQH0B49SK6n4Hg1MLDDww/oRH9+J1rusHYwwsL+q4NuyZU0IdHmvufcl9vFQ3PTv
	 afkRXd4DihjUSWeQk7wBuF/gW8vYW2ONgpthCUzlsmzShHPojc5k3SbTk0/fPZHTft
	 SNmVz4+7u+j3Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 28 Apr 2026 07:10:53 +0200
Subject: [PATCH net-next] net: airoha: Introduce
 airoha_fe_get()/airoha_qdma_get() register read helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-airoha_fe_get-airoha_qdma_get-v1-1-6cfbdeb42743@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zXM0QpAMBSH8VfRuaZmhLyKtE78x7kwbJKSd7eUy
 199fTcFeEGgNrnJ45Qgq4vI04SGmd2ETMZo0kpXqtRNxuLXmY2FmXD82seFP9esmpp1wbAlxcf
 mYeX6/h25GDhcB/XP8wJ5Gp0ueQAAAA==
X-Change-ID: 20260428-airoha_fe_get-airoha_qdma_get-7a087a23aef4
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.3

Add airoha_fe_get() and airoha_qdma_get() as utility routines for reading
a masked field from a specified register.
This is a non-functional refactor, no logical changes are introduced to
the existing codebase.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 13 ++++---------
 drivers/net/ethernet/airoha/airoha_eth.h |  4 ++++
 drivers/net/ethernet/airoha/airoha_ppe.c |  5 ++---
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 2bb0a3ff9810..40b7a00c7d95 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -201,15 +201,13 @@ static void airoha_fe_vip_setup(struct airoha_eth *eth)
 static u32 airoha_fe_get_pse_queue_rsv_pages(struct airoha_eth *eth,
 					     u32 port, u32 queue)
 {
-	u32 val;
-
 	airoha_fe_rmw(eth, REG_FE_PSE_QUEUE_CFG_WR,
 		      PSE_CFG_PORT_ID_MASK | PSE_CFG_QUEUE_ID_MASK,
 		      FIELD_PREP(PSE_CFG_PORT_ID_MASK, port) |
 		      FIELD_PREP(PSE_CFG_QUEUE_ID_MASK, queue));
-	val = airoha_fe_rr(eth, REG_FE_PSE_QUEUE_CFG_VAL);
 
-	return FIELD_GET(PSE_CFG_OQ_RSV_MASK, val);
+	return airoha_fe_get(eth, REG_FE_PSE_QUEUE_CFG_VAL,
+			     PSE_CFG_OQ_RSV_MASK);
 }
 
 static void airoha_fe_set_pse_queue_rsv_pages(struct airoha_eth *eth,
@@ -227,9 +225,7 @@ static void airoha_fe_set_pse_queue_rsv_pages(struct airoha_eth *eth,
 
 static u32 airoha_fe_get_pse_all_rsv(struct airoha_eth *eth)
 {
-	u32 val = airoha_fe_rr(eth, REG_FE_PSE_BUF_SET);
-
-	return FIELD_GET(PSE_ALLRSV_MASK, val);
+	return airoha_fe_get(eth, REG_FE_PSE_BUF_SET, PSE_ALLRSV_MASK);
 }
 
 static int airoha_fe_set_pse_oq_rsv(struct airoha_eth *eth,
@@ -247,8 +243,7 @@ static int airoha_fe_set_pse_oq_rsv(struct airoha_eth *eth,
 		      FIELD_PREP(PSE_ALLRSV_MASK, all_rsv));
 
 	/* modify hthd */
-	tmp = airoha_fe_rr(eth, PSE_FQ_CFG);
-	fq_limit = FIELD_GET(PSE_FQ_LIMIT_MASK, tmp);
+	fq_limit = airoha_fe_get(eth, PSE_FQ_CFG, PSE_FQ_LIMIT_MASK);
 	tmp = fq_limit - all_rsv - 0x20;
 	airoha_fe_rmw(eth, REG_PSE_SHARE_USED_THD,
 		      PSE_SHARE_USED_HTHD_MASK,
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index e389d2fe3b86..c81433d44e3e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -619,6 +619,8 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 	airoha_rmw((eth)->fe_regs, (offset), 0, (val))
 #define airoha_fe_clear(eth, offset, val)			\
 	airoha_rmw((eth)->fe_regs, (offset), (val), 0)
+#define airoha_fe_get(eth, offset, mask)			\
+	FIELD_GET((mask), airoha_fe_rr((eth), (offset)))
 
 #define airoha_qdma_rr(qdma, offset)				\
 	airoha_rr((qdma)->regs, (offset))
@@ -630,6 +632,8 @@ u32 airoha_rmw(void __iomem *base, u32 offset, u32 mask, u32 val);
 	airoha_rmw((qdma)->regs, (offset), 0, (val))
 #define airoha_qdma_clear(qdma, offset, val)			\
 	airoha_rmw((qdma)->regs, (offset), (val), 0)
+#define airoha_qdma_get(eth, offset, mask)			\
+	FIELD_GET((mask), airoha_qdma_rr((eth), (offset)))
 
 static inline bool airoha_is_lan_gdm_port(struct airoha_gdm_port *port)
 {
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 5c9dff6bccd1..697af6fdd4c3 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -80,9 +80,8 @@ bool airoha_ppe_is_enabled(struct airoha_eth *eth, int index)
 
 static u32 airoha_ppe_get_timestamp(struct airoha_ppe *ppe)
 {
-	u16 timestamp = airoha_fe_rr(ppe->eth, REG_FE_FOE_TS);
-
-	return FIELD_GET(AIROHA_FOE_IB1_BIND_TIMESTAMP, timestamp);
+	return airoha_fe_get(ppe->eth, REG_FE_FOE_TS,
+			     AIROHA_FOE_IB1_BIND_TIMESTAMP);
 }
 
 void airoha_ppe_set_cpu_port(struct airoha_gdm_port *port, u8 ppe_id, u8 fport)

---
base-commit: 790ead9394860e7d70c5e0e50a35b243e909a618
change-id: 20260428-airoha_fe_get-airoha_qdma_get-7a087a23aef4

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

