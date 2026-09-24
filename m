Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89724CC622
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271891; cv=none; b=HwSoUhajeD6nLaWfhenpIP4N1wHV48Qlk8HcbkyNMCYFK5eZLFy67LUiebsSgvLbeqnw7A1gF6DPmjB+kSfegqEE+qRFnRMu55CuVlaCF95277KnWEMoODtZKVsRkeJGS4TQ5OH1ODmSSBOQIVTqaeFBCHVOi5zKIGxfDUfFedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271891; c=relaxed/simple;
	bh=lENjvTcJ6jn6OOtjQT9OxyeXMbXMz3M/XL/BEeU1C48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JrMGhQ8/Yl8HbchafQQMHwEOGE314VYEBo/1LNvWvHtr6Q67mHN1zvmchX7Pun02tVuBnZT4JXyDOeyL65awLuwzyyYDoU3IFQHq3KIfbBfUf970H0O589Rjda/zfeJq6t1kuWh4QC+LZhWPDf/VyF/HZZXTOtE5xzDW6mwtCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5/ocFJo; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5/ocFJo"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-491c13d63d9so141214fac.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790271887; x=1790876687; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VrMqc8Q1NW4R8bM+PWgpFGuXOWv8RLSIAwP5mrNvnTc=;
        b=k5/ocFJo/TqwLLtij4rM8EDgk1dATiT5Fxr9mic6QuxyfVU9JyxzoHPFj6DZNL/REx
         KempqyQLQxYgqqt0DTDIXx45dc70oJZkfuYEwC2As6rNhLBQ8pfRwm66MUAqGrIIwiTt
         5TXgUEW5PicfDJFkpzqVfQxxirvAGuVcPSGVcS+VYRWN7W8cCNKLYZKNZIIArYkzfmv9
         ajETeCZWxQlnaF4x37F2zT4f3G0LVWbPpV/BNBd2W75RuDB6R7GFfz2oZzpUPzAAUb4m
         leM1LzkNkajv6631vxo6UAFQ6sEVGWE7edTZEkaQyH4LkY3Am+GFO2sdCAlq972csj1A
         SadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271887; x=1790876687;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VrMqc8Q1NW4R8bM+PWgpFGuXOWv8RLSIAwP5mrNvnTc=;
        b=gkxmWcEjHWMtD9HWJpj53OtimumKANdRpzur9+eNpOJv53hn5+0zYbWZfJwNCDK6kn
         /tOTnGFZo1e5LGPzXYfon1EEYltaEL/rppLSSfls9kHJ/veU0UV9QWlBZfbz3v5PTvuG
         EEKq2B+GTlCAK9vn8ofWu9atEdcMi3x1wdqOvdpHk1yNH79DY6blDDxHryhHW5Pv4L5w
         fCOUN7SJSuLuSPF7J/1LMZtz+g/o5+oo0yu/PssLN7EQ1ztj8PuB674a6NLhDZ6P6T9F
         QZYEioMbeVLt4/Wmvu60kkFcHHHllqq3x1g/rP2l4zT3CAXEU1Qio9R84jiwh2mrOxiU
         cMgw==
X-Forwarded-Encrypted: i=1; AKwUvBzv/+qL6BWc+2di0ht5T2WkW8Fsvl3nw0/gbN6qoACLtIO6iht+SkEWmlQE0N16FKGqzvkHw9I=@vger.kernel.org
X-Gm-Message-State: AFuF++mnrR7j15qNUZiMaBIz7vdLOfjBhWf7PgmH7aYiw9zvhwQUug4y
	IqtzMrfcgpDiJ7wic5eTsBmMBGhbzX/qkp+ejyx6PuduUnay0DE3wIXN
X-Gm-Gg: AYBFou3RJf/gajcmide5nCmn+YPv48vVGUWOZdirmNsYmuj4EGoZk2nT5kcQ2BDbLaP
	tbMz70jpM+UTw8PcpC1CZTDvwDaEa2C9d3suSlDOOIKBygp/Zw+O89eiHQESvm9Zy/nD81bHKIP
	GYJcyxpD83VfNbEaJcZHH+SmtUdLwk7syIYg7D75lyrGseuhrytcVkrCxj0uW5hTRBylwiF8gib
	QOtKVTt3aXHN2LivAVZM5nVAiHQ1hRIjdOEcD+AVLDY5PTnSb+WlSq1k1mk5uGmC2yp3elx8tqp
	oU4BpzklJ3uRpkMMbsaGNhkYg2prOCpT3DrUJm5H4kAU1jc0EaUfttQ5uP8bBSo2rZ5noxIWSXI
	SNe8SSEdceNe1POVFvkJ4QYJKQTO2Ir8x4ElktxvbB1laAYirpHNw68P+FpHGPPYlCTpiFGnsBq
	1RvfMuVRhJBbPivkBHdy9huXmBY42qekBv1TELaVuKpfnSedlKz8GEsqf2TRcaej5FdfXTWCzPn
	6sGximr+XPfX306bw1gDM0xRL0FZcXr4QSfQQ+6z7o2dN6K+857gR9LJHbCkVL+f42PZvAkWeD8
	io/ti1jOje7QlKX0acCL7OxWNOKYF4PNvsz7HrwU6OQmtbGfoX23azEs4rv4Bbw+d8OonLrFvL7
	uti4CdkpWsLDJqyaIBzwbOg==
X-Received: by 2002:a05:6870:d88f:b0:47c:f956:c7bd with SMTP id 586e51a60fabf-491e4e5f03emr3167632fac.3.1790271887477;
        Thu, 24 Sep 2026 10:44:47 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-491e8f8d14asm3027802fac.0.2026.09.24.10.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:44:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 24 Sep 2026 11:44:37 -0600
Subject: [PATCH net v3 07/10] net: stmmac: account for failed live XDP
 reopening
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-submit-stmmac-reset-fixes-v1-v3-7-c031e3f3a282@gmail.com>
References: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
In-Reply-To: <20260924-submit-stmmac-reset-fixes-v1-v3-0-c031e3f3a282@gmail.com>
To: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Joakim Zhang <qiangqing.zhang@nxp.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, 
 Suraj Jaiswal <quic_jsuraj@quicinc.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Joao Pinto <Joao.Pinto@synopsys.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Ong Boon Leong <boon.leong.ong@intel.com>, 
 Voon Weifeng <weifeng.voon@intel.com>, 
 "Song, Yoong Siang" <yoong.siang.song@intel.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>, 
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
 ZhaoJinming <zhaojinming@uniontech.com>, 
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, 
 Ding Hui <dinghui1111@163.com>, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The XDP-specific release/open pair bypasses the ordinary datapath
bookkeeping, and its caller ignores reopen errors. A failed allocation
therefore leaves the device marked running with NAPI disabled and rings
released. A later close disables NAPI again. An IRQ-request failure also
frees descriptors after starting DMA without first stopping it.

Detach and stop phylink while replacing the XDP datapath, update its
ownership state, and reattach only after successful reopening. Preserve
the existing PTP registration on success, but release it on failure so a
DOWN datapath has no residual PTP ownership. Drain transmitters and timer
producers after freeing IRQs which can restart TX queues, including on
the ordinary release path.

Keep the old program reference until the change has succeeded. On an
attach failure restore the old program and return the error, allowing the
core to release the proposed program. Program removal must still succeed
when the non-XDP datapath cannot restart: BPF link teardown cannot retain
the detached program. Leave the interface administratively up but detached
for an ordinary down/up recovery in either failure case.

Fixes: ac746c8520d9 ("net: stmmac: enhance XDP ZC driver level switching performance")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 47 +++++++++++++++--------
 drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c  | 31 +++++++++++----
 2 files changed, 54 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ce598b575763..467f471874cf 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4314,12 +4314,10 @@ static int stmmac_open(struct net_device *dev)
 	return ret;
 }
 
-/* Quiesce NAPI and transmit queues without releasing their resources. */
-static void stmmac_quiesce(struct stmmac_priv *priv)
+static void stmmac_stop_tx_queues(struct stmmac_priv *priv)
 {
 	u8 chan;
 
-	stmmac_disable_all_queues(priv);
 	netif_tx_disable(priv->dev);
 
 	/* A poll function can still arm a timer after napi_complete_done().
@@ -4332,6 +4330,13 @@ static void stmmac_quiesce(struct stmmac_priv *priv)
 		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
 }
 
+/* Quiesce NAPI and transmit queues without releasing their resources. */
+static void stmmac_quiesce(struct stmmac_priv *priv)
+{
+	stmmac_disable_all_queues(priv);
+	stmmac_stop_tx_queues(priv);
+}
+
 static void __stmmac_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
@@ -4350,6 +4355,9 @@ static void __stmmac_release(struct net_device *dev)
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
+	/* TX error IRQs can restart a queue after the first quiescence. */
+	stmmac_stop_tx_queues(priv);
+
 	/* Stop TX/RX DMA after draining IRQ handlers which can restart it. */
 	stmmac_stop_all_dma(priv);
 
@@ -7244,19 +7252,15 @@ void stmmac_enable_tx_queue(struct stmmac_priv *priv, u32 queue)
 void stmmac_xdp_release(struct net_device *dev)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	u8 chan;
-
-	/* Ensure tx function is not running */
-	netif_tx_disable(dev);
 
-	/* Disable NAPI process */
-	stmmac_disable_all_queues(priv);
-
-	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
+	netif_device_detach(dev);
+	phylink_stop(priv->phylink);
+	stmmac_quiesce(priv);
+	priv->datapath = STMMAC_DATAPATH_DOWN;
 
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
+	stmmac_stop_tx_queues(priv);
 
 	/* Stop TX/RX DMA channels */
 	stmmac_stop_all_dma(priv);
@@ -7271,7 +7275,13 @@ void stmmac_xdp_release(struct net_device *dev)
 	 * watchdogs during reset
 	 */
 	netif_trans_update(dev);
-	netif_carrier_off(dev);
+
+	if (stmmac_fpe_supported(priv))
+		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
+
+	/* Keep PTP across the immediately following stmmac_xdp_open(). That
+	 * function releases it if reopening fails, before returning DOWN.
+	 */
 }
 
 int stmmac_xdp_open(struct net_device *dev)
@@ -7350,19 +7360,22 @@ int stmmac_xdp_open(struct net_device *dev)
 
 	/* Enable NAPI process*/
 	stmmac_enable_all_queues(priv);
-	netif_carrier_on(dev);
-	netif_tx_start_all_queues(dev);
 	stmmac_enable_all_dma_irq(priv);
+	priv->datapath = STMMAC_DATAPATH_RUNNING;
+	phylink_start(priv->phylink);
+	netif_device_attach(dev);
 
 	return 0;
 
 irq_error:
-	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
-		hrtimer_cancel(&priv->dma_conf->tx_queue[chan].txtimer);
+	stmmac_stop_tx_queues(priv);
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
 
 init_error:
 	free_dma_desc_resources(priv, priv->dma_conf);
 dma_desc_error:
+	stmmac_release_ptp(priv);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
index 909219775507..7ecb7addd2ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
@@ -108,6 +108,7 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 	struct bpf_prog *old_prog;
 	bool need_update;
 	bool if_running;
+	int ret;
 
 	if_running = priv->datapath == STMMAC_DATAPATH_RUNNING;
 
@@ -119,25 +120,41 @@ int stmmac_xdp_set_prog(struct stmmac_priv *priv, struct bpf_prog *prog,
 		return -EOPNOTSUPP;
 	}
 
-	if (!prog)
-		xdp_features_clear_redirect_target(dev);
-
 	need_update = !!priv->xdp_prog != !!prog;
 	if (if_running && need_update)
 		stmmac_xdp_release(dev);
 
 	old_prog = xchg(&priv->xdp_prog, prog);
-	if (old_prog)
-		bpf_prog_put(old_prog);
 
 	/* Disable RX SPH for XDP operation */
 	priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);
 
-	if (if_running && need_update)
-		stmmac_xdp_open(dev);
+	if (if_running && need_update) {
+		ret = stmmac_xdp_open(dev);
+		if (ret) {
+			netdev_err(dev, "failed reopening after XDP change: %pe; interface remains detached\n",
+				   ERR_PTR(ret));
+			if (prog) {
+				/* The core retains the old program on error and drops
+				 * the reference it passed for the proposed program.
+				 */
+				xchg(&priv->xdp_prog, old_prog);
+				priv->sph_active = priv->sph_capable && !old_prog;
+				return ret;
+			}
+			/* Uninstalling a BPF link must release its program even
+			 * if the non-XDP datapath cannot be restarted.
+			 */
+		}
+	}
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
 
 	if (prog)
 		xdp_features_set_redirect_target(dev, false);
+	else
+		xdp_features_clear_redirect_target(dev);
 
 	return 0;
 }

-- 
2.53.0

