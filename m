Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626893E3D93
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283604; cv=none; b=W4VhdCFeyig0Sd/T+w/KifPhPOfUJBCSWGQkr1+6ATnbkqgX1ylpLpzWABibIUzrqxSrz5PM75RAQ434GpBU/5uBUoG8tEXaj7tjy7omD8hEQVQhYCb2nSjRzYhiAdQN1nw7zusT4B9IrH91Oz8bXnWDpHAXx4g21NXXHua7Azw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283604; c=relaxed/simple;
	bh=/qFQ+mTnPTtQBw1VN0LPgMdk2kFeIT0dDfkz1PAxkxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IeRDSFK/Fqt8BzwUCLkNGm8/8lPQK0no1CuKWb7/aHYYZ0wCM5n9zdnIyc+Uv0ohopB5MYY9h0JDI8HurgADtOXhJFHh6hX2J+QjGkwimCNYy57c+DNunnxAP5YygrQjGhw1cBwwpHQJNG+LPJjIApV7F8cwqV3vbkihhGAPbgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=okYiRRBw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SNBJG/1J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="okYiRRBw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SNBJG/1J"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696ARKfY1544016
	for <netdev@vger.kernel.org>; Tue, 6 Oct 2026 10:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rkdaTawAeWTd5xZOK+YRjCbD0V9u8wUiR43gGegjqfY=; b=okYiRRBwMVMFXqNS
	DRex+TQ7mHWktpekgYsceIKXKkX2S2qF8p5JdR6wY6y0WXf6LiqixX+TEFgcutJa
	iiz3Wif2r9ZtR+gy9MJPn2M30pJUzrFq0Xgenm1aU5B3trIvgKWblfb4246QR9OK
	6mrNbxPqtC+t8BHjAAmkTFnN1sbJ/KAK+pvGRH8NmWElDmMojkjjBxOddF09EEjf
	74n+TKZLbdf9OvRph0oBbtiRqvcnRjsYfomMJ1XgAIpjBBGaWnYZEzu/wP+f9qlV
	0Je9zUyLDxzXHWwjuXUbK5v28KO7Auw1CkEafVlYE+br6i055zHqdOfo7T0wR8/I
	nDxKiA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4uy4gtyy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:46:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93bfb2da664so605844785a.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 03:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791283601; x=1791888401; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rkdaTawAeWTd5xZOK+YRjCbD0V9u8wUiR43gGegjqfY=;
        b=SNBJG/1JRG1IWxi+UpuXj8ZyAYkdds9gjeqEjWpnBVeASCLFUSGYfLrxJtaq+z9zxo
         8Iuz1dGRq/4YR8eQUdJJLlYnhG0mq3J/DxFxPylbPuBXdQ6MpyNTbPcpQ1kE+7RsmMQ4
         ZtwyFAC3vtXn8nPcgpuM53dyXRyHomvrZxfasQaS7NmKACmMsa7qm9Qo9EZcZklwh334
         rVYEpj/gejmXeTkF1kWq89cKaD0EH5owsPt+kcTrJsP7je5gW/sDvNGwx+wVlYDctDy+
         eco47NPvf8HCFvaYDhcZ2dBn0ND7Xb8E8FNsGyJQJxTh7CN/b3ZcihttsiYfd6ORYWaN
         o6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791283601; x=1791888401;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rkdaTawAeWTd5xZOK+YRjCbD0V9u8wUiR43gGegjqfY=;
        b=tfOmsAC5HpE/e8ucvl9l185sA6C3UL9Op1h7HpO6fR6Bhz+Fki2ESI5Mi9YJnuv0zJ
         WfaqxaGRprqX8seEYZuYfIRWhF49kxp8y6D5WUe+bDfHgp49iv9JQqDJx7gyJnx1TPWM
         YPn1ybOYsXTpgcNiMfg3xRrpdTdciJZ1IP9r7POOTr9Sn7Bf4aSYdCr0YOoBKcO7RgC1
         Si+Upn6QHi9NQzUqW0xJRqu/11JC8FRdXl/vcBW7oLennRmkPEWBEvOkH/+l55MCPPwa
         nyBfOJFxBE8+PtnBvAnuzTUWNQKJqqkBWAALWY2jICCIcgmmGDcypZy7L0zelYZErcgG
         jihw==
X-Forwarded-Encrypted: i=1; AKwUvBxCmHP4uaasUXhB6xOiQe/sCur4L04TANtoBhYLmfn/H7dIqwYeHptxuBbOiZqZrCX/ZQhJ5vk=@vger.kernel.org
X-Gm-Message-State: AFuF++kNAMiMHuvocFtL9DRCaYtJ71pzyQUiW48OumV6dTL4ncYRJfNk
	WtrDnN6DGycyRju8EkvE7RPZnF3C91TUbJTpJiJ1Drzt7hjy2mJzBlXH1I4x0hxhgzkdNHHmTfg
	fwBTadBhbb0aYtZ0GgSIXiTuPnA7rOb+M2aJXwCMapSNsM0W/gi/+jijJMs4=
X-Gm-Gg: AYBFou1A/+3hjvIQUhOApPQwuuk2qIM1oRZ4afl+J2Hev+mm2B/EGrgvEKu03kQxINt
	q0pMOvzZlqmi906qVcqRxqF8CIlJk2qcyQswpO9TPZrR+U+vj4kNgFRXcvRAUKP+OQ+ssmVpq1G
	3fjRB0k0BY05ptvLpEFVhrLlnDUawBCrzGu4wIyfoFYhghZcnH6QTQaBs8/o8GtBBwpuLoOI12d
	I8ibmBIpupGmiuok/XKy/z7aUwr0/gsEQyaVHDAv+p1xNqE5Yn9na2TQYW6jQRqgCi+/QgHKc/U
	xFAMLhdgoW2Jkr0UCFbqByWyO3pULw4kZFlkc0k5DqStnFA+dbfVlLnI56fuQuU0SGM0QBtA0WN
	zmSsHQr7ICeOXvw==
X-Received: by 2002:a05:620a:2845:b0:939:3a81:326 with SMTP id af79cd13be357-93e8f4e49admr163679585a.37.1791283601226;
        Tue, 06 Oct 2026 03:46:41 -0700 (PDT)
X-Received: by 2002:a05:620a:2845:b0:939:3a81:326 with SMTP id af79cd13be357-93e8f4e49admr163675985a.37.1791283600689;
        Tue, 06 Oct 2026 03:46:40 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c69be6b12sm4139542f8f.45.2026.10.06.03.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 03:46:39 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 06 Oct 2026 12:46:26 +0200
Subject: [PATCH net-next v5 2/3] net: stmmac: align real_num_tx_queues to
 mqprio configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-stmmac-mqprio-prio-offload-v5-2-d7da93419784@oss.qualcomm.com>
References: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
In-Reply-To: <20261006-stmmac-mqprio-prio-offload-v5-0-d7da93419784@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Vladimir Oltean <olteanv@gmail.com>, Furong Xu <0x1207@gmail.com>
Cc: Daniel Thompson <daniel@riscstar.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfX1/pORtDLXgeX
 ATW+JcllIsEv+Ygrq7dHqIfTS+apoE8C3XuNDlJQVS+j9MauwsORbaEF6TKzXDaUQHvxD636Wba
 EWgklny8k8wJBvV9kv3zlFmdrcplJpUF2rxIfXtuV+E3wkkNOc77Z3pJyQ7JwZH32r6nLXPXeYh
 P3KiYqda4T0wcI6LqV6VYk19+qHm0BT2NAUERk2cuW8lrWhobgoJ+t08M19CTq/5DqMwfAImSiv
 gUWVyWw1A6u0aczjGU3N38QRt4TzVvn3EYrCeSPiBiByAbRgyHRN+Dx4j9d8opmFmJpfOTgsE26
 1ogvf7KR4JiJ6YvF6Uhh5ofMaG76RwB+bqTWwa9UShzCdv7s3X6wkuDWxa4Ul2Y+Mu3HaU/OOM2
 exs0Fy7I1VUdCP6RDPwiTB2W7XsYwCd0Fd0vfKX16b0QbOX14+RIx43R8hU8UzibK3rcION2hyK
 tPLI6uG6PyR4hbNHAvw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0MiBTYWx0ZWRfXymS+65Tdf42H
 SRU6uPzifNPuJFG2POZu+duxlFZIq3Z8XhwErE1tqpDRhg4dg+//WnoyuwPqzrZVv6zrMNuJpt6
 pw6Knfn61sTsonZlBKTbCOuhaJx71j0=
X-Authority-Analysis: v=2.4 cv=F97C5ahN c=1 sm=1 tr=0 ts=6ac4d192 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=EUmjA8OtTW9buVhb6SYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: AH6zh81MQVwZs-2SQLkrlhL9E3E39tSu
X-Proofpoint-GUID: AH6zh81MQVwZs-2SQLkrlhL9E3E39tSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060042

stmmac_hw_setup() unconditionally sets the number of real TX queues to
plat->tx_queues_to_use on every device open. When a tc-mqprio qdisc is
offloaded the driver reduces netif_set_real_num_tx_queues() to the number
of queues enabled by the offload, but the next device open reverts it to
plat->tx_queues_to_use while the netdev TC map is still the one programmed
by the qdisc, leaving the two inconsistent.

Track the number of TX queues enabled by the current qdisc configuration
in the per-qdisc state (priv->xmit_qdisc.num_tx_queues) and use it in
stmmac_hw_setup(). The field defaults to plat->tx_queues_to_use at probe
time and when the mqprio qdisc is destroyed, meaning no offload is active
and the number of real TX queues must match the number of queues the
driver allocated, and it is updated to the offloaded queue count on a
successful mqprio setup.

mqprio only validates the requested queue ranges against
dev->real_num_tx_queues, which can be larger than plat->tx_queues_to_use
while the interface has not been opened yet. Reject a qopt whose highest
referenced queue (offset + count) exceeds plat->tx_queues_to_use, so
xmit_qdisc.num_tx_queues can never be larger than the number of TX queues
the driver provisions. Otherwise stmmac_hw_setup() would expose TX queues
without an allocated DMA ring.

Refuse to lower the number of TX queues below the count required by the
active mqprio offload in stmmac_reinit_queues(), otherwise
netif_set_real_num_tx_queues() would leave real_num_tx_queues
inconsistent with the netdev TC map.

The issue has been reported by sashiko and the patch has been tested on
a Qualcomm RB3-Gen2 board.

Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  6 ++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 +++++++++++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 13 +++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 4fc96b317d79..0052f2129297 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -299,6 +299,12 @@ struct stmmac_priv {
 	/* Protect est parameters */
 	struct mutex est_lock;
 	struct stmmac_est *est;
+
+	struct {
+		bool enabled;
+		u32 num_tx_queues;
+	} xmit_qdisc;
+
 	struct dma_features dma_cap;
 	struct stmmac_counters mmc;
 	int hw_cap_support;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0c381ae0d0ff..9c03d21ebfcc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3780,7 +3780,7 @@ static int stmmac_hw_setup(struct net_device *dev)
 
 	/* Configure real RX and TX queues */
 	netif_set_real_num_rx_queues(dev, priv->plat->rx_queues_to_use);
-	netif_set_real_num_tx_queues(dev, priv->plat->tx_queues_to_use);
+	netif_set_real_num_tx_queues(dev, priv->xmit_qdisc.num_tx_queues);
 
 	/* Start the ball rolling... */
 	stmmac_start_all_dma(priv);
@@ -7707,6 +7707,10 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	int ret = 0, i;
 
+	if (priv->xmit_qdisc.enabled &&
+	    tx_cnt < priv->xmit_qdisc.num_tx_queues)
+		return -EINVAL;
+
 	if (netif_running(dev))
 		stmmac_release(dev);
 
@@ -7714,6 +7718,9 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
 
 	priv->plat->rx_queues_to_use = rx_cnt;
 	priv->plat->tx_queues_to_use = tx_cnt;
+	if (!priv->xmit_qdisc.enabled)
+		priv->xmit_qdisc.num_tx_queues = tx_cnt;
+
 	if (!netif_is_rxfh_configured(dev))
 		for (i = 0; i < ARRAY_SIZE(priv->rss.table); i++)
 			priv->rss.table[i] = ethtool_rxfh_indir_default(i,
@@ -8025,6 +8032,9 @@ static int __stmmac_dvr_probe(struct device *device,
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_XSK_ZEROCOPY;
 
+	/* Default qdisc num_tx_queues */
+	priv->xmit_qdisc.num_tx_queues = priv->plat->tx_queues_to_use;
+
 	ret = stmmac_tc_init(priv, priv);
 	if (!ret) {
 		ndev->hw_features |= NETIF_F_HW_TC;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 1aa80d51ab33..a7721b2eee96 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -1266,6 +1266,9 @@ static int stmmac_reset_tc_mqprio(struct net_device *ndev,
 {
 	struct stmmac_priv *priv = netdev_priv(ndev);
 
+	priv->xmit_qdisc.num_tx_queues = priv->plat->tx_queues_to_use;
+	priv->xmit_qdisc.enabled = false;
+
 	netdev_reset_tc(ndev);
 	netif_set_real_num_tx_queues(ndev, priv->plat->tx_queues_to_use);
 
@@ -1299,6 +1302,13 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 		ndev_prio_tc_map[i] = READ_ONCE(ndev->prio_tc_map[i]);
 
 	for (i = 0; i < qopt->num_tc; i++) {
+		if (qopt->offset[i] + qopt->count[i] >
+		    priv->plat->tx_queues_to_use) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Queues exceed hw TX queues");
+			return -EINVAL;
+		}
+
 		tc_to_txq[i] = (struct netdev_tc_txq) {
 			.count = qopt->count[i],
 			.offset = qopt->offset[i],
@@ -1321,6 +1331,9 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
 	if (err)
 		goto error_reset_num_tx_queues;
 
+	priv->xmit_qdisc.num_tx_queues = num_tx_queues;
+	priv->xmit_qdisc.enabled = true;
+
 	return 0;
 
 error_reset_num_tx_queues:

-- 
2.55.0

