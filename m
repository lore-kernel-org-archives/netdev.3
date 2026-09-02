Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BA240A945;
	Wed,  2 Sep 2026 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338855; cv=none; b=uUD4lj3NzknHEcWrcsynKN5a8u5ncwtxjjC6FcN/uvzQ+L+F2Kw5MPuX8UV8CTdR6APAj48uIV6vhAB9AOAsKjng2WdpfBqV8sycKkEpSamIlEtWiX7XZqICoPCQwNCGDX8HPz4a95yrzh5nKVzruYMG3xO9nFpIiJS3aN8B2U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338855; c=relaxed/simple;
	bh=GU3MzRajGGC1icwm8wNjUdcCutwDNmJ4aQpsnPdTouA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrQBAPmGSdLsVux/pPZVL/w5v9ojhc6tm1lVb6+hFagNxJwisiDbrKPL5sUAKrAeU2b+B7cD+zAdzzPaNzLSNTdq4yubr8yVdtTLZT1DKLl2hthlvIiA53sVSOk2qqVWjd03pcFYMuvzuQv+GJ3nyvK3N4b57d4mc9ca5GbTr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=n5Bgr1Dx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Faqes5oO; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="n5Bgr1Dx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Faqes5oO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 19C75EC001C;
	Wed,  2 Sep 2026 04:47:33 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 04:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788338853;
	 x=1788425253; bh=ux3pMOjD8SqmtZSRdfG+nqZg/LtfJSjVpHkFAtUlqow=; b=
	n5Bgr1DxuPW3UnO1wtyWF0jpHkF6ELfaRvEubX8Iz3ZcGUWpo8xz641IQDwYpg5i
	LZ6Q8Osrb0WIwYFuDjARjbPjb10s/Hr4/WwPOJXRIqOLWm/9umfP1NZmSc08cvXt
	10/rjgxCpoWZ9rdmynXIPwXARvuuNmB5mKQyVBoBx0ueNzDhJvzObcJwTvLWaRuC
	nZ5UDVU4xiXX947Z8O8ZV0Oe9uREESLmUKUkCERu5UsS4CnvGR+ThHfaJ9vmsGFv
	ldQll1dfkPhnJ05VptG85p65BDXV4qBmBz7HD+mQ8B2rXOf/Ba8+P+WSAUnXFymc
	4KVauvswwsExcdWTboQBOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788338853; x=
	1788425253; bh=ux3pMOjD8SqmtZSRdfG+nqZg/LtfJSjVpHkFAtUlqow=; b=F
	aqes5oOnSWa5muQlZKEZFSIlNh4rsuNJL5EoeIJGGbFN1BzVpoMivlmBnUoTE8P6
	nncMlpnkBNAt4LQps0Q3f+SDhqQNKly6UhNDh55nCvV7aIsBrsfH2nPqw3VuAjFJ
	YKArR6qIn0g1XXtI4lvSCL6QR0Mii8hNCIwNSJkYFUd0+F9ns4Pcs+o/YnFHsvYf
	WQZ85eKKPXf7s2fJyivmvvaKLj/08o7FPp2dS5MxKK5Jk3JspMYEHUcah9AIbcpw
	e6oA/iTGfBSuezwq5BL2LrfUFPKXk3yx8HjaLOq/msS2GVHch+7fcdrh3Ca7gArL
	AZo/eQwc7KnWUr8mYv1XQ==
X-ME-Sender: <xms:peKXasLoaa-sDbGxX_awvX9ZQDVVR5_3uMoZD9LXLIjXkHHcayBORg>
    <xme:peKXak4CN0Nl9gV9qx32zhilsMdPnHV1-ETOWgw5bLlue8h-r4qPprTPaxc6Sskhj
    x5cumMGNNXLSiHQ4x4cjwFX_542qLJAnVTNHwjZZPkWrNRXjKS1cYE>
X-ME-Received: <xmr:peKXarYuBRn5R8ZkALsgPVySSfFOd5zUiWyD-pXgMh14bCb3jyi4BydQJijcXMA6xH0r_gVZQrYxXGCAs_GIVw-rJIK-zHw>
X-ME-Proxy-Cause: dmFkZTFaC34AKDyyx2JWvZAyzMZPrLonj6Y+cyOD3p17c1AG7DXyqbHg0dDF7Ebt7D07IF
    3bfgT3UIfdbkPvPeVD+Yc8AR8IwBaeo1xPGZ7tVhUbz8REGwfObyy724YL1xvbxCkiSoVs
    Zr19kANjQaj/+w+iddWEU0aC1CzZHQM6yeAvRJc41D8KwaVzv1SFIAbTrsCNRf9If+K5t4
    PSZ7pSeAuSkewwU7HekFeHRwu2Sp+xkfx4AxKGocqHuIvnYqnaWzKGxKkrOU98vd8D5Cmj
    UsyB3ygea/aoCYfSx4ZC9E3wSkGCjWeq63mqLQMpNszZyuhbp9Rf0oWEqJNGraLhyCxIpf
    yi+Be6gPmQ7AsCj44rIFR3YUs+ogrqgjcYAwURfwdN4gJBfzDcIWog4I+6oSfKgu+Hfo2e
    Gih3nJCX4RXa/5yzQs9B8pduD2i68qPB8wG9IQ4td3AHMnEqJxvlcFft/JLR/c6iSyIWrs
    hl+O1odrjYdTR/d4BOLYJf6k/M1O1c3QwAn0KBgXlzbZIQmSSi+YKsHicTskC6ZGM03mSs
    3Yd1fN0lZE80Rnt6T5lhn8f8Mfjuc1ylN9Zj/yvp6Yw+CcGDJeejtsiFgfoXz/+fpnc8De
    3bOF4+r4Q/y4UzAZmWz6h50Q84Bx4i98JV+ZOu1ZT0jVaDXg7bC3jfaH0WQw
X-ME-Proxy: <xmx:peKXarz-DpUdBK9pJOOSWphxIZkdj_6_Yep7zAYfXx7h3-twUgYSYQ>
    <xmx:peKXanMdRmnFCA8h4LdcWsTigsxBCUlyAWFPmQlOYIKC1D9Cwp23XQ>
    <xmx:peKXap6SSrVzi5mlBDdBUt2qRdjwmwuGnQJtD4ZlAgqoBx-5CrNTSg>
    <xmx:peKXatdqyHOTurBlzdsOFp1gT8XHpHe_9hcxiKE82XOapUm2PpQJlQ>
    <xmx:peKXaoQhJ9EVssliQ97Xf3LNEd9byGJuZxvZT8LWbqBcoz21kLSYWNFE>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 04:47:32 -0400 (EDT)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"DavidS. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sergey Shtylyov <sergei.shtylyov@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v3 07/10] net: ethernet: ravb: Add callback for gPTP probe
Date: Wed,  2 Sep 2026 10:47:00 +0200
Message-ID: <20260902084703.3228504-8-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
References: <20260902084703.3228504-1-niklas.soderlund+renesas@ragnatech.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Different generations of the RAVB IP have different needs when it probes
the gPTP timer clock. Add a callback in the PTP information to allow
each generation to probe its own way.

With this the last gPTP specific flag (gptp_ref_clk) can be removed.
However the primary motivation for the change is to prepare for Gen4
support, which compared to other generations with gPTP support does not
have the clock as part of the IP itself.

Gen4 will not need to compute GTI value as it have nowhere to write it,
as the gPTP clock is external. For this reason move the computation of
it into the newly gPTP probe specific callbacks for the RAVB IP's that
support it.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
* Changes since v1
- Improve spelling in commit message.
---
 drivers/net/ethernet/renesas/ravb.h      |  3 +-
 drivers/net/ethernet/renesas/ravb_main.c | 53 +++++++++++++++---------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 6603f90b19e1..b788e8f5260d 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -1041,6 +1041,7 @@ struct ravb_ptp {
  * with the gPTP clock. This struct provides the callbacks to be called at
  * critical points in the RAVB driver.
  *
+ * @probe:		Probe the gPTP clock
  * @set_config_mode:	Enter config mode
  * @dmac_start:		Called when the DMAC starts
  * @dmac_stop:		Called when the DMAC stops
@@ -1048,6 +1049,7 @@ struct ravb_ptp {
  * @ndev_close:		Called when the ndev is closed
  */
 struct ravb_gptp_info {
+	int (*probe)(struct net_device *ndev);
 	int (*set_config_mode)(struct net_device *ndev);
 	int (*dmac_start)(struct net_device *ndev);
 	void (*dmac_stop)(struct net_device *ndev);
@@ -1084,7 +1086,6 @@ struct ravb_hw_info {
 	unsigned multi_irqs:1;		/* AVB-DMAC and E-MAC has multiple irqs */
 	unsigned irq_en_dis:1;		/* Has separate irq enable and disable regs */
 	unsigned err_mgmt_irqs:1;	/* Line1 (Err) and Line2 (Mgmt) irqs are separate */
-	unsigned gptp_ref_clk:1;	/* gPTP has separate reference clock */
 	unsigned nc_queues:1;		/* AVB-DMAC has RX and TX NC queues */
 	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
 	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 5d5b9c0e2f45..7e53eca5327f 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1842,21 +1842,14 @@ static int ravb_set_config_mode(struct net_device *ndev)
 	return ravb_set_opmode(ndev, CCC_OPC_CONFIG);
 }
 
-static int ravb_compute_gti(struct net_device *ndev)
+static int ravb_compute_gti(struct net_device *ndev, struct clk *clk)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
-	const struct ravb_hw_info *info = priv->info;
 	struct device *dev = ndev->dev.parent;
 	unsigned long rate;
 	u64 inc;
 
-	if (!info->ptp)
-		return 0;
-
-	if (info->gptp_ref_clk)
-		rate = clk_get_rate(priv->gptp_clk);
-	else
-		rate = clk_get_rate(priv->clk);
+	rate = clk_get_rate(clk);
 	if (!rate)
 		return -EINVAL;
 
@@ -2653,6 +2646,13 @@ static int ravb_mdio_release(struct ravb_private *priv)
 	return 0;
 }
 
+static int ravb_gen2_ptp_probe(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	return ravb_compute_gti(ndev, priv->clk);
+}
+
 static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 {
 	int ret;
@@ -2668,6 +2668,7 @@ static int ravb_gen2_ptp_set_config_mode(struct net_device *ndev)
 }
 
 static const struct ravb_gptp_info ravb_gen2_ptp_info = {
+	.probe = ravb_gen2_ptp_probe,
 	.set_config_mode = ravb_gen2_ptp_set_config_mode,
 	.dmac_start = ravb_ptp_init,
 	.dmac_stop = ravb_ptp_stop,
@@ -2704,6 +2705,7 @@ static int ravb_gen3_ptp_set_config_mode(struct net_device *ndev)
 }
 
 static const struct ravb_gptp_info ravb_gen3_ptp_info = {
+	.probe = ravb_gen2_ptp_probe,
 	.set_config_mode = ravb_gen3_ptp_set_config_mode,
 	.ndev_open = ravb_ptp_init,
 	.ndev_close = ravb_ptp_stop,
@@ -2763,6 +2765,24 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
 	.magic_pkt = 1,
 };
 
+static int ravb_rzv2m_ptp_probe(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	priv->gptp_clk = devm_clk_get(&priv->pdev->dev, "gptp");
+	if (IS_ERR(priv->gptp_clk))
+		return PTR_ERR(priv->gptp_clk);
+
+	return ravb_compute_gti(ndev, priv->gptp_clk);
+}
+
+static const struct ravb_gptp_info ravb_rzv2m_ptp_info = {
+	.probe = ravb_rzv2m_ptp_probe,
+	.set_config_mode = ravb_gen2_ptp_set_config_mode,
+	.dmac_start = ravb_ptp_init,
+	.dmac_stop = ravb_ptp_stop,
+};
+
 static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.receive = ravb_rx_rcar,
 	.set_rate = ravb_set_rate_rcar,
@@ -2783,8 +2803,7 @@ static const struct ravb_hw_info ravb_rzv2m_hw_info = {
 	.dbat_entry_num = 22,
 	.multi_irqs = 1,
 	.err_mgmt_irqs = 1,
-	.ptp = &ravb_gen2_ptp_info,
-	.gptp_ref_clk = 1,
+	.ptp = &ravb_rzv2m_ptp_info,
 	.nc_queues = 1,
 	.magic_pkt = 1,
 };
@@ -2976,12 +2995,10 @@ static int ravb_probe(struct platform_device *pdev)
 		goto out_reset_assert;
 	}
 
-	if (info->gptp_ref_clk) {
-		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
-		if (IS_ERR(priv->gptp_clk)) {
-			error = PTR_ERR(priv->gptp_clk);
+	if (info->ptp && info->ptp->probe) {
+		error = info->ptp->probe(ndev);
+		if (error)
 			goto out_reset_assert;
-		}
 	}
 
 	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
@@ -3034,10 +3051,6 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->netdev_ops = &ravb_netdev_ops;
 	ndev->ethtool_ops = &ravb_ethtool_ops;
 
-	error = ravb_compute_gti(ndev);
-	if (error)
-		goto out_rpm_put;
-
 	ravb_parse_delay_mode(np, ndev);
 
 	/* Allocate descriptor base address table */
-- 
2.55.0

