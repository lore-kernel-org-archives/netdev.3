Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7C40F74A;
	Wed,  2 Sep 2026 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338861; cv=none; b=L53nDZSRjszJvaBqsPuvDyjBZnUDoq1YVegBU8Ftl97fAPmvxQMCQT0fe7JLMq9z4W261eqLTiFa/dhYCgDbQ2bVo3C8Ux1TtqMVKFHpJBJU7VBTYRWLjsnDDA9Gqx1Y74oGXVAIPa7Jm7xxXqpTLdNCDgaEHYA5WbnAth3BHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338861; c=relaxed/simple;
	bh=oAz5sQ2ZkBi9byyrbCBEmL3wAnVDTfgV+o+W+8fS4Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QW4Wd/OmTFTw8jZed+0wm9gqQ5/+1o7RsFg80BgPADUKO1+iu2y+Ra91NO5HfRlMtVEqQv6PJ9z0lvTz2v03oq2KBjNFH2vbeVhIH2yWoe3+aeTK+UEzuEosz+PGvzvXyxOhbjug+VKaTnVdrsBmkgPlyj5sHyxMBv9P80FD5LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=cHwxgvAC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iDNs9pMV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="cHwxgvAC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iDNs9pMV"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E4C51400141;
	Wed,  2 Sep 2026 04:47:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 02 Sep 2026 04:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ragnatech.se; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788338859;
	 x=1788425259; bh=xninzBdh1IJS0lOnJ9VwYxscY4/BJ1MXk08bi4TFD/Y=; b=
	cHwxgvAC17g7tzMBo0hJbELpbcpua1HYMrsbJYgfp98S5niNiYXgaVwUDtzI+Il7
	n8bjPC/tf+fOuGpVcudF3wuzyH072FEpTnXb9029TXS9DaSoln/fvI3kogoYTgSs
	G6rb8HBuT7Uqwt+1Y1EZ1t3bOwNpwxmt7i0riXlUPKU6opTaakXQIx4Ar3LOZJbi
	9/PmdMS5lHrNM+/0y1LZ54Ug407Ck73NQxVovbia/f6jnWXxkaOlJkQTFLKzh7P8
	FyZNWjgzI9pNkFrOSSyk9fxAsWm7cb3nt1hwQBLW2Z8eKgUWxHK11KLtk+wCW3q4
	evruPJi6o+EdBxnwwXBSWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788338859; x=
	1788425259; bh=xninzBdh1IJS0lOnJ9VwYxscY4/BJ1MXk08bi4TFD/Y=; b=i
	DNs9pMVkjLISfg+fVA9Q8Yx8WXa3ZIIIGby9bK7i3WhoipUupDnnXC27/dOvLEUl
	v2zTEU7yZjlwPIH0Eyp7tD1IHhfq25IzlU+7x+DgqvHe88LOiehb9054FZB65kfD
	28M58wWcJUgPlAIJTW6a9puzN0zXw1EXkxoaGObaKbNdqT9SpzUwzFlDbzVaz5oE
	QxcbAUuZkjSuD62kdKcwYWcEmYZH1wKQooRb9b9WPd3gxf5onXBGbkgtoHf0A7pN
	A6RDhSBbYtRvaFdNd48Q3QeYcoNFzPiQmXsMBMZ5jp1Fr+9BnZv+SCEgFn5ZINff
	9GOiSXY59WfKvtXD9ez2w==
X-ME-Sender: <xms:q-KXakSsP-sYgj5Yx8kxKOqdokD9pf4tHtY-vJmUKhBKQHwAf2eyxQ>
    <xme:q-KXaqgMusL7nRIG-DDfMJT4vd50e_U38ynWxeiCDi7AOPJEFJGkpjGitTO567zyv
    wY5oCR5dT0ibkhTURrQS9sCNvxnvfvNWVOy6m5ekwY8IvA-BNm_3_A>
X-ME-Received: <xmr:q-KXaghzFbZemfQyQ4sJu3O6Rsf32O8K8XMd1DEHlwAU1oXi1zCM78sp_ypZhQ2nWx1xclfdIFNnWSh157Opjthf7ssdL_Q>
X-ME-Proxy-Cause: dmFkZTFLAv/ibph6UC33feAOMpzczryfKzXjO7EDaAqbWAtNnwbJPCoHyFP6KyAhOx9F6x
    dNf/b+0Xn+KWry8AK5eahf1FDySDBqLxaUqoPd3rgZYpbsxa666JLLmPyRvWDKeI2ghAf/
    unF9XDDDCD+dXmlFUY+PKo1SF2FZ/CGClyqiCAFeoxQ89ueTM5YIAs9qvMF+7r5U3tqqqm
    GoyvBZuncP1oKLZLKyVWYH39p02A3ZyE5AEAz7A4Oi2slaH558XyoLwxPAuEUWy2p+d5vb
    QMhR9+RrNEaH8aNp37fOiQNHXNfFuLyQGcQpuWCW512Wy1RZKLJJjGvur1RKpdfLH1XvUL
    9pv3drN2hDJH5MbjfjTZpSKxCFT0R0p9voDKMMuJopMBGLdc+UV9c5H+5dNpLZmpZEHs8g
    E/M3mHjKH5cv9b/3X2FgMo52XVJ+zpjygI7CWu2+045RgTG3VK4LbCnN2Zg6BYavVlnkbP
    If7exXVTu/HxrtSIjAgaGXyiI9EGYELK25/Ag7d1ZZlv8wNx8zMOV7Av8ISJuh1qxy/pAV
    ujgbVIHt3OGogULbBhowmA2qUN6u+zPthjIt2VHOlmGCgjDxZbujPiC7DMCySRP5mw3PqQ
    T4AniBb90aaSgW8rd/ZsqP3PF4fDzM7xvx1vzmJo3ep5X0gy1HwvShd8bZ3w
X-ME-Proxy: <xmx:q-KXaqbB9Sn5J62wgN8l8LhMYxiyiWZq_OkrYM2w_aoTeXZ3FBWt9g>
    <xmx:q-KXahVXXb5wPJABUWkfotlokxZqcDYdhzW4jp53cT5FRmJRmcvTJQ>
    <xmx:q-KXapioTWuBC45pOzu0Ks5-FHpbLmDOUO9gRUlCzen2fhOts4sghQ>
    <xmx:q-KXakliT8dsLXfTjiukwVuby_9ghHg9Z9PFhqLtesgvvUCvBBtc5A>
    <xmx:q-KXavoyFZGDofN-wWV7-_VYJidF5kZWdyCLH01yXVwhITGoIIr-Z2FQ>
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 04:47:39 -0400 (EDT)
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
Subject: [PATCH net-next v3 10/10] net: ethernet: ravb: Add gPTP support for Gen4
Date: Wed,  2 Sep 2026 10:47:03 +0200
Message-ID: <20260902084703.3228504-11-niklas.soderlund+renesas@ragnatech.se>
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

While driver advertises gPTP support on Gen4 platforms it is in fact
completely broken. On R-Car Gen4 devices the RAVB module have no
internal gPTP clock as generations before it. Instead it utilizes a
system-wide gPTP clock.

This change utilizes the refactoring of the RAVB gPTP code to add
support for a system-wide clock and stops the Gen4 devices trying to use
the non-existing internal gPTP clock.

To remain backward compatible the ptp-timer property is optional.If not
present, or not enabled, the RAVB driver will no longer advertise gPTP
support to user-space.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>
---
* Changes since v2
- Use full 100 character width instead of breaking at 80.
- Remove superfluous return statement.

* Changes since v1
- Use the standard generic ptp-timer property from
  ethernet-controller.yaml instead of a vendor specific one.
- Improve spelling in commit message.
---
 drivers/net/ethernet/renesas/ravb.h      |  3 ++
 drivers/net/ethernet/renesas/ravb_main.c | 54 +++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index 27e2b31955ba..5d35b40d7c58 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -249,6 +249,8 @@ enum APSR_BIT {
 	APSR_RDM	= 0x00002000,
 	APSR_TDM	= 0x00004000,
 	APSR_MIISELECT	= 0x01000000,	/* R-Car V4M only */
+	APSR_GPTPTIMER_SOURCE = BIT(25), /* Gen4 */
+	APSR_GPTPCLOCK	= BIT(29),	/* Gen4 */
 };
 
 /* RCR */
@@ -1132,6 +1134,7 @@ struct ravb_private {
 	struct list_head ts_skb_list;
 	u32 ts_skb_tag;
 	struct ravb_ptp ptp;
+	struct device_node *of_gptp;	/* Reference to external gPTP clock, if any. */
 	spinlock_t lock;		/* Register access lock */
 	u32 cur_rx[NUM_RX_QUEUE];	/* Consumer ring indices */
 	u32 dirty_rx[NUM_RX_QUEUE];	/* Producer ring indices */
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 402370e1be63..66c9cd15a19e 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2752,6 +2752,57 @@ static const struct ravb_hw_info ravb_gen3_hw_info = {
 	.magic_pkt = 1,
 };
 
+static int ravb_gen4_ptp_probe(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	priv->of_gptp = of_parse_phandle(priv->pdev->dev.of_node, "ptp-timer", 0);
+	if (!priv->of_gptp)
+		return 0;
+
+	if (!of_device_is_available(priv->of_gptp)) {
+		of_node_put(priv->of_gptp);
+		priv->of_gptp = NULL;
+	}
+
+	return 0;
+}
+
+static int ravb_gen4_ptp_clock_index(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+
+	/* If no clock, mimic ptp_clock_index_by_of_node() fail and return -1 */
+	if (!priv->of_gptp)
+		return -1;
+
+	return ptp_clock_index_by_of_node(priv->of_gptp);
+}
+
+static int ravb_gen4_ptp_set_config_mode(struct net_device *ndev)
+{
+	struct ravb_private *priv = netdev_priv(ndev);
+	int ret;
+
+	/* Enable gPTP Clock and Select High-speed peripheral bus clock. */
+	ret = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
+	if (ret)
+		return ret;
+
+	/* Set PTP source to GPTP module, only option on Gen4. */
+	if (priv->of_gptp)
+		ravb_modify(ndev, APSR, APSR_GPTPTIMER_SOURCE | APSR_GPTPCLOCK,
+			    APSR_GPTPTIMER_SOURCE | APSR_GPTPCLOCK);
+
+	return 0;
+}
+
+static const struct ravb_gptp_info ravb_gen4_ptp_info = {
+	.probe = ravb_gen4_ptp_probe,
+	.clock_index = ravb_gen4_ptp_clock_index,
+	.set_config_mode = ravb_gen4_ptp_set_config_mode,
+};
+
 static const struct ravb_hw_info ravb_gen4_hw_info = {
 	.receive = ravb_rx_rcar,
 	.set_rate = ravb_set_rate_rcar,
@@ -2774,7 +2825,7 @@ static const struct ravb_hw_info ravb_gen4_hw_info = {
 	.tx_counters = 1,
 	.multi_irqs = 1,
 	.irq_en_dis = 1,
-	.ptp = &ravb_gen3_ptp_info,
+	.ptp = &ravb_gen4_ptp_info,
 	.nc_queues = 1,
 	.magic_pkt = 1,
 };
@@ -3188,6 +3239,7 @@ static void ravb_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(dev);
 	clk_unprepare(priv->refclk);
+	of_node_put(priv->of_gptp);
 	reset_control_assert(priv->rstc);
 	free_netdev(ndev);
 	platform_set_drvdata(pdev, NULL);
-- 
2.55.0

