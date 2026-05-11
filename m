Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26D63BAD99;
	Mon, 11 May 2026 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489579; cv=none; b=jus1H1biXYgpLPDTkQNuCmDTnbTP7uCiQukL6SNVqR82P0RJ64z26WVZrprOdo2MLHRp1Tj2r+Hcvi4DezDXYW4WR9A0sm/txe1Dl3534J8J8yeHkWG307Q6+yOKkoHEQnaG5lOaA2qOsEc4m1NGWgfB1tB0W+x65jJX7yP9JbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489579; c=relaxed/simple;
	bh=2lvWdFNnegbVPck1/sYsq0efWTSUMEV3loHEE41KwMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n8nrsUAhaxDyr76kkkof4BM6mqYiZ1h2nzIiDTai5LXk0BYlIk/9Q0PiICpYoCP3LUNTAU9LgX2B76lK3NID0o70/5oSZ3l1YdJ+2+qUl81hgl7Xt/kTIo72BcIGg2doH6M2yalHyL6VWdeB9he0OCuOUaaDyvB4X4ERP39+FrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: ydzwYBMkQcqd0pPl7OgGBA==
X-CSE-MsgGUID: u2j4W/5ISeO4MUsXNxC8/Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 May 2026 17:52:56 +0900
Received: from [127.0.1.1] (unknown [10.226.78.135])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 801074009A31;
	Mon, 11 May 2026 17:52:53 +0900 (JST)
From: Michael Dege <michael.dege@renesas.com>
Date: Mon, 11 May 2026 10:52:11 +0200
Subject: [PATCH net-next v4 08/13] net: renesas: rswitch: add basic vlan
 init to rswitch_fwd_init
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-rswitch_add_vlans-v4-8-a5a225f8faae@renesas.com>
References: <20260511-rswitch_add_vlans-v4-0-a5a225f8faae@renesas.com>
In-Reply-To: <20260511-rswitch_add_vlans-v4-0-a5a225f8faae@renesas.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
 Paul Barker <paul@pbarker.dev>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michael Dege <michael.dege@renesas.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778489544; l=1893;
 i=michael.dege@renesas.com; s=20251023; h=from:subject:message-id;
 bh=2lvWdFNnegbVPck1/sYsq0efWTSUMEV3loHEE41KwMY=;
 b=veLY/dY+7oy4k80oO60nxxhWGSTVlRiFj1gxjhA1Pp9UlHkGZTePSZz7kK2+WPxmeGm90VdKP
 rI0Sz2PcM3xCD7+9r9bhaiwxC1Xok6j3pnt6tkBenZiXs7kfYHChFha
X-Developer-Key: i=michael.dege@renesas.com; a=ed25519;
 pk=gu1rwIcCrAxNMv2I8fIfiQvt51xzZwnQy4Ua/DscQt8=

Add basic vlan related register initialization.

Signed-off-by: Michael Dege <michael.dege@renesas.com>
---
 drivers/net/ethernet/renesas/rswitch_main.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index 7d85905f2be2..90c44dcfd169 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -120,6 +120,7 @@ static int rswitch_fwd_init(struct rswitch_private *priv)
 	u32 all_ports_mask = GENMASK(RSWITCH_NUM_AGENTS - 1, 0);
 	unsigned int i;
 	u32 reg_val;
+	int ret;
 
 	/* Start with empty configuration */
 	for (i = 0; i < RSWITCH_NUM_AGENTS; i++) {
@@ -154,17 +155,27 @@ static int rswitch_fwd_init(struct rswitch_private *priv)
 	}
 
 	/* For GWCA port, allow direct descriptor forwarding */
-	rswitch_modify(priv->addr, FWPC1(priv->gwca.index), FWPC1_DDE, FWPC1_DDE);
+	rswitch_modify(priv->addr, FWPC1(priv->gwca.index), 0, FWPC1_DDE);
 
 	/* Initialize hardware L2 forwarding table */
 
-	/* Allow entire table to be used for "unsecure" entries */
+	/* Allow entire table to be used for "un-secure" entries */
 	rswitch_modify(priv->addr, FWMACHEC, 0, FWMACHEC_MACHMUE_MASK);
 
 	/* Initialize MAC hash table */
 	iowrite32(FWMACTIM_MACTIOG, priv->addr + FWMACTIM);
 
-	return rswitch_reg_wait(priv->addr, FWMACTIM, FWMACTIM_MACTIOG, 0);
+	ret = rswitch_reg_wait(priv->addr, FWMACTIM, FWMACTIM_MACTIOG, 0);
+	if (ret)
+		return ret;
+
+	/* Allow entire VLAN table to be used for "un-secure" entries */
+	iowrite32(VLANTMUE, priv->addr + FWVLANTEC);
+
+	/* Initialize VLAN table */
+	iowrite32(VLANTIOG, priv->addr + FWVLANTIM);
+
+	return rswitch_reg_wait(priv->addr, FWVLANTIM, VLANTIOG, 0);
 }
 
 /* Gateway CPU agent block (GWCA) */

-- 
2.43.0

