Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E429397343
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786516154; cv=none; b=jelzfvczm6XTE43wDTZ04codRvVzfQvfV8i+ceR8I6o37lcLIWb5WklNa7v2zZWlROyVM4RtKeco2v4OA7F0dstCMUF4F4Yb5xQ7YBoDc/lyGTtCfRDXTh49RGmKxkk6NXgbrbMi6IptgpIrhOesmVVntCGTImsT1hoRKnZKWSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786516154; c=relaxed/simple;
	bh=6bijNBhw3aiffq9wLuwoxzUhFfX+Pj76uZzim767l9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=md9tPFC/gZjTBIUsKNuvAAYF1/6FFNwvCJ+S2KtjUeBEbtdmEP7Q7/1+a10XtUf3gz/YdCzm5airerUmZTcSTZJJBoTQGDAyy6yBE0weG4GiZl3hGO2DBw0IQcKJXH2Cs/3jkHE3qLNyj6ke9lQ/0e1KZ+yodQ5wURz4w6eflIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dVJCNhGR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OpttTfp0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dVJCNhGR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OpttTfp0"
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786516148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7GaqLnSbBrIEhdw7ERwjg1ICgmS4Mg1QhxztBP8zNGQ=;
	b=dVJCNhGRy5PI14/WAZq7Bb9TeBkNhcfN1v0FIuCSbTS77WtewzHb7zlRubHEiDY0f6sLVS
	DC/LCso3+6i3uxZDYb/ISyjulBGGkEpX/Lmn/AwxMFVt/BAGOSeJf74Pf8GRZwxuu1tTKi
	Il7CbmTm0Lz2w9hll5Xad950ERRRzuAFfgCZ1ON/OTg5SKfZsuxxHzDw+VMtzJaVfTsqlq
	FlX4KXeIdjfyd0qsWIK+1FyCYAqGjYTQgz2LE5T1pO5DPBwKlORGPy0vDEED0A6QTXofDq
	uPlIp+c1AucTXUZCv9NLQUhEZjpaq7uvheVWpiotp8Fhx2cJ/OawbXhh4XiYqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786516148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7GaqLnSbBrIEhdw7ERwjg1ICgmS4Mg1QhxztBP8zNGQ=;
	b=OpttTfp0RHCqBCkO3e6XCeWzoo+tzhuW9e2EJSplyFYckpbifC6wsNRSERkuuQETA8ePoA
	XpbA0Aep2q9Iy/DA==
Date: Wed, 12 Aug 2026 08:28:57 +0200
Subject: [PATCH net-next] net: stmmac: stm32: Set TSO/TBS Tx queues default
 settings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-stm32mp2_txtime-v1-1-f9e2462cc85d@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAKgSfGoC/yWMUQrCMBAFr1L220ASIbReRURs+qorJJbsKoHSu
 zfq5zDMrCQoDKFTt1LBh4VfuYE7dBQft3yH4akxeeuD7Z0zouno0+KvWpUTTBjnAdbFIfSgVi0
 FM9ff8UwZajKq0uVv5D0+EfU7pG3bATJ5BV19AAAA
X-Change-ID: 20260811-stm32mp2_txtime-6bf9e01c968e
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=6bijNBhw3aiffq9wLuwoxzUhFfX+Pj76uZzim767l9I=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBqfBK050VvGZByWEuk5r4XnRppzVePJljR44eKB
 XfXoMwKsGWJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCanwStAAKCRDBk9HyqkZz
 ghzxD/48XbfLYKwUibZn/F6uNLcpUJjJLDQ+FYEGF37bSCUs0jVKo15GQwwWPFZszeZeCz0w5gU
 NOgPH/qzbfq5r6eG4FMfXrJ74Iuvwd315Tc6jVOaeOj1gZbSDIWPCKM9odz3UNNoxHf/Q8WsOan
 Z0JuIyM4Rg/IKboP1zwbITT87ugY03KX5cjrW1ySkKWHLhCN+59fONrpb4fQ5mW5dfMZ9Z76oYg
 BR54KOhiRpbNHZLOo2bX8bE0ADBXXXK68pyEkEpm7MTqHsS6x0nTHr+MnT8HCO1LbNbwPL4Jvek
 k1yn2fEgpzd3ZvpwIWVxd4fbRqZ9b2Y+FodwP0SR6t8QPQgqFl6cJ5ZJU6l0du6JTsOMjTqKQYc
 fxo80jscYqzuDr94kMv4Scbtb/y8OPwV0v1pyBbP1A/3HAVxTfIKTGy01s7hk1lwXtjfW8mSRc/
 EQlfEKYZaCs9nif5aYVPFyZiGzFPpPItAyZuZQfk5qiEnOLuL/rkaoQAW+QKQ+fP3tQzd2otgeG
 aZ4T+JQPGqWlKiYydoCvAocXQoNolK8alSjy3olG52F9t8T1V5lDZsCMyb7+QaPW/OPnI0HgE1B
 rj6b2NP5huR2YMaj1ccuJj4o1lmqLVUmLPUmiiQsbpo4Phc4woh9Ut1kqlN3cajJV6o27GJypxq
 4Z+p8HGF58V3IPw==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

TSO and TBS cannot coexist. Use the first queue with TSO and the rest for
TBS. Tx queues with TBS can support etf qdisc hw offload. This is done
similar to dwmac-imx and dwmac-intel.

Tested on stm32mp257f-dk with AF_XDP and Tx Launch Time on queue 1.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index e1b260ed4790..8e15094eeab9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -557,6 +557,12 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Default TX Q0 to use TSO and rest TXQ for TBS */
+	if (dwmac->ops->is_mp2) {
+		for (int i = 1; i < plat_dat->tx_queues_to_use; i++)
+			plat_dat->tx_queues_cfg[i].tbs_en = 1;
+	}
+
 	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->suspend = stm32_dwmac_suspend;

---
base-commit: ac155a26750a595703e7dadff84735456d75a479
change-id: 20260811-stm32mp2_txtime-6bf9e01c968e

Best regards,
--  
Kurt Kanzenbach <kurt@linutronix.de>

