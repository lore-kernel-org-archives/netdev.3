Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759C720B80B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187904; cv=none; b=MGUrAX8v23YscGkGdMQqdWlr0FC44imq7ShnlCCIggV0fn903k3TIl+pg03FnkFJQSOuZaB49IlaRXjGTr0+DGZnHYkJfywQGoRIOUonKtUW/1CYyFFuPEP9/YNidMZQeN6CCJmNiN9VIxLJIggpUnWuKqgBzetyUcQsZ2i8gyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187904; c=relaxed/simple;
	bh=1mqPA6jdwkJpTXEnTcEVQtS12jpuKiVe0zYYZY0QYaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CEbr0tR560LCp4VFlxvyhKIRj5pPZon8Rvu6In31ubdgXmDlNE8SAWR+jYzixxVS/Z3F0SHwiv3vOMfEYUYRRiOEuS6YnBvqu71cAk92v+W1cELHqihlWs2Z0dXr6SOO+QFBedK7uvoQ/4p+0JcN91e7pZjyzxFuQkXC6S3YK9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=idxu6Hew; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f+muIEBz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="idxu6Hew";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f+muIEBz"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69584OvR1823446
	for <netdev@vger.kernel.org>; Mon, 5 Oct 2026 08:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bjZV0POkzh7LpIvx+eSG55
	3iX1QjNnqXJQew9yHol0M=; b=idxu6HewFD5i5Crnicm1AfOOiBOeFpmgt+n89q
	M4xdbtAu06OPlZZxIkdg6tcqZX4cARFFxpdQV+fwFxN7ON359XqfF5Ljy/P0/Jh0
	tpi2VQpgkx9jSfdG4wzDDXNOV6N/8rDYtyqKZn9XzBHd2fAGxVXK0r29e76UoMhJ
	KEXp8YHN3jB2RT0vx25OIa6DImH+COQJ10S/5z1yTLbUj6JxN/6hZ8LDHimVJW8j
	Pc1DTgmBJ9w5WMrczzrxh8KHbdvYz2ZxTonmv/uo6gCJgrgTfMY3VQbyhO7sSZmf
	RJtLr2K/1AcRa/zV4PMnDuM4/0HixR1XVRh6uOIneFyG4EXw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sq8w13s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:11:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91430af782dso37798076d6.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 01:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791187901; x=1791792701; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bjZV0POkzh7LpIvx+eSG553iX1QjNnqXJQew9yHol0M=;
        b=f+muIEBzS25kbsy0zydsYBwHutRRPS/aB/Y8KMVrv9u0t/grKAQiWGc7y02aPsd/Nm
         w3MSwArW7wTeru41xYFvLky12nowYUqgZ6tWFsVZ0OzCAaMFDJ3Lemvxj04wHgPrT+o+
         NzOPrJl4WNot00j0cvCpBZv/TKJLERhaIxdO44V+Eq065qEzxTbovZq/V7e8S93tToPv
         A+yfu30CYrGrRKu0/EF+bDlUQTb4JB5pS7C06XbPWkvUSRs96obp+6eT8qrG2vM3YK5+
         Vo8w0PKTfOkmzLBppP1lpgkGnhY/+v5bI/TBxB2NiuPxyygePqbDidU0dXmp2XW4cVVz
         gleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791187901; x=1791792701;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=bjZV0POkzh7LpIvx+eSG553iX1QjNnqXJQew9yHol0M=;
        b=P3N28KyqqY1jgb+vYqeXcYXbx1+F7rsBrzJzl8KQX7J10P+uH755CDq7Wpko7arkks
         LnQ/quZ1bGM2spLXpMnHatKR/ytQJmisDCf+cXaPzfR9dhE5fVUg4CLWOQ4ZaiIh5h9D
         fr53zq22sG6RWGkkAmd7HZJQC2idDx25iylGy654v5HSSSEY6Np8/GBlfry5WbM2i2lC
         wqJBhiIXuUPH+81AXbM+puX7qJ6dzZUnwGe9xPT5q9wzZXmaPzDhAJnBvXbRV2GMpTp3
         h1c6+gSem/mM9iylvZSrqN32vkdE4javjXEUZ0IxQt+GeUrwAXw5WIJbRduEYSGEp8Bk
         LulQ==
X-Gm-Message-State: AFuF++m9zI7doLtDtaqRJh7Mpu3zVopCPhVi4vjUu8yQh5cN4IlyCDKt
	qKFDrVTRPOXfeiPECrn/1PK44PBOlcMyHZm7fMbU3sapxzaOJSflomyRzib9I1tGSO5nzoEDxDZ
	J1qpVifQC406PnXR92/wly6eiCG7OtHf3SfXD1PAItV+xKTO4YlxlqpxgWwM=
X-Gm-Gg: AYBFou2upeZSpjRFiQhe5rEel6CGgyFroQm+0yC3kaLtVm8qb1MSdMfia3cB1dAonPN
	oh8h7UyWO3Q/uHpPAVlMDR2aBl7wMgJ26/CSQR1dSwIE8EDWluK8gbMLF7DnP0Y46QgunaNAhbl
	OSHIFwD+PxOMlvKQ+29eZcNSCN9FOGoHhNAA2ydUgKuTUqmS9rf20q27HUAwpUhQLJDGnNUR8cI
	geA/O0YV3Ip+tg7XLKPYZHbIlvYS03MqMFks2DPF42q3GBB6fDvMqownxKYsyj5q5iXEHxD7g9G
	jVOH7lzU+Es4gK8EtH0bYpN336FWc5l3V1079gNElq2ivd4aDdDq2MVoPD2Zf1uChOWNjPD5P4v
	g54J7oR2MAPjaJg==
X-Received: by 2002:a05:620a:1710:b0:93e:5929:f012 with SMTP id af79cd13be357-93e592a0715mr1003524485a.18.1791187901347;
        Mon, 05 Oct 2026 01:11:41 -0700 (PDT)
X-Received: by 2002:a05:620a:1710:b0:93e:5929:f012 with SMTP id af79cd13be357-93e592a0715mr1003519985a.18.1791187900697;
        Mon, 05 Oct 2026 01:11:40 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0316b2524sm376315055e9.1.2026.10.05.01.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:11:39 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 10:11:24 +0200
Subject: [PATCH net v2] net: stmmac: serialize PTP timestamping
 configuration with priv->lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-stmmac-hwtstamp-missing-lock-v2-1-3b3bf4fe3f45@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NUQ6CMBBEr0L22yW0YhG/vIfho9YKG2mL3Yoaw
 t1tOIGZZJKZSd4swDaSZTgVC0Q7E1PwOchdAWbQvrdIt5xBVlKJqpLIyTltcHgnTtpN6IiZfI9
 jMA+8Kt20TWtUvTeQEVO0d/ps+At4m6DL5UCcQvxul7PYpv/os8CsY2usOAitZH0OzOXzpUcTn
 CuzQbeu6w//TMYY1AAAAA==
X-Change-ID: 20261002-stmmac-hwtstamp-missing-lock-b6a7979c643c
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Kory Maincent <kory.maincent@bootlin.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: I0yCjJhlkJwFbAjZVgBR77N0xuEUr2Ku
X-Proofpoint-ORIG-GUID: I0yCjJhlkJwFbAjZVgBR77N0xuEUr2Ku
X-Authority-Analysis: v=2.4 cv=TKzQ2Fla c=1 sm=1 tr=0 ts=6ac35bbe cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fyqvg29pATKFG4behgUA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzMSBTYWx0ZWRfXxwvlbMYHT7Gv
 0cfM3PEmtgB0JdhQNjoaHKYI98X6hFD1z48DEeZ8KguPjxsp3nodS9uqIFpeLh0/0uFOoCoC2ew
 BbnMY4z4wbdpCGJ23TTkZvX2cJQLfNsmtFOS9J54X533zuWD0PN21x8fuurZIUtgRVfGjmbmKN/
 D/qokeu3pSjwsM9gVXN6phElQ6x8Hn1yDPdIw5+RIdpzDbvO1HGko3ef67lUfQw3RAHcVSZDrk0
 ohe39cZO2Ux380tlxxz0njwUcDacwVqGPaiRSBm+AvThTkUpKjTowkP+cLJ8JcHh0kOXmsBJWbP
 POtBRi9Ee9HUpl05oTcxw40WPDRXK8jRLrCtyEhFbNmRFWdxIJqJ/8xnKbN/R+M79Qy3AMPn0Ee
 TkTW0cgFgTSIaVy4hQLYk6/MpKfO3TLHhFmfiPn89fvl9DMNVvYE3iGF71ie3pZlnZ/KOOqJ3QY
 pvShsn6Z/BAzQ7DWYZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzMSBTYWx0ZWRfX+K48B3xjvJiY
 mYjcBAKACag7NWpv1U9PMquxsc393SglGWt2aYqdgjJzmqzWIrvMZrmDNEVsV3GWSE5GOXdAyfD
 BcnQs4se34PA9VnW5dohVUabP31pU7k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050031

stmmac_dl_ts_coarse_set() runs under devl_lock only while
stmmac_hwtstamp_set() runs under RTNL. They read/write
systime_flags/tsfupdt_coarse and run stmmac_config_hw_tstamping().

stmmac_dl_ts_coarse_set() snapshots priv->systime_flags, programs
PTP_TCR, PTP_SSIR and PTP_TAR, and only then publishes tsfupdt_coarse
and systime_flags. A concurrent stmmac_hwtstamp_set() can read the
stale tsfupdt_coarse, build fine-mode flags, program PTP_TCR in fine
mode and set hwts_rx_en.

Take priv->lock in both stmmac_dl_ts_coarse_set() and
stmmac_hwtstamp_set() so the timestamping configuration is updated
under a single lock.

Fixes: 6920fa0c764d ("net: stmmac: Add a devlink attribute to control timestamping mode")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v2:
- Use proper Fixes tag.
- Link to v1: https://lore.kernel.org/r/20261002-stmmac-hwtstamp-missing-lock-v1-1-189ce151a624@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 43 ++++++++++++++---------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9741f97fa37a..a6793054a179 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -685,14 +685,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 	u32 snap_type_sel = 0;
 	u32 ts_master_en = 0;
 	u32 ts_event_en = 0;
-
-	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
-		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
-		priv->hwts_tx_en = 0;
-		priv->hwts_rx_en = 0;
-
-		return -EOPNOTSUPP;
-	}
+	int ret = 0;
 
 	if (!netif_running(dev)) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -700,13 +693,23 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 		return -ENODEV;
 	}
 
-	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
-		   __func__, config->flags, config->tx_type, config->rx_filter);
-
 	if (config->tx_type != HWTSTAMP_TX_OFF &&
 	    config->tx_type != HWTSTAMP_TX_ON)
 		return -ERANGE;
 
+	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
+		   __func__, config->flags, config->tx_type, config->rx_filter);
+
+	mutex_lock(&priv->lock);
+
+	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
+		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
+		priv->hwts_tx_en = 0;
+		priv->hwts_rx_en = 0;
+		ret = -EOPNOTSUPP;
+		goto unlock;
+	}
+
 	if (priv->adv_ts) {
 		switch (config->rx_filter) {
 		case HWTSTAMP_FILTER_NONE:
@@ -829,7 +832,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 			break;
 
 		default:
-			return -ERANGE;
+			ret = -ERANGE;
+			goto unlock;
 		}
 	} else {
 		switch (config->rx_filter) {
@@ -859,8 +863,10 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
 
 	priv->tstamp_config = *config;
+unlock:
+	mutex_unlock(&priv->lock);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -7753,9 +7759,12 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
 {
 	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
 	struct stmmac_priv *priv = dl_priv->stmmac_priv;
-	u32 systime_flags = priv->systime_flags;
+	u32 systime_flags;
 	int ret;
 
+	mutex_lock(&priv->lock);
+
+	systime_flags = priv->systime_flags;
 	if (ctx->val.vbool)
 		systime_flags &= ~PTP_TCR_TSCFUPDT;
 	else
@@ -7768,13 +7777,15 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
 	if (ret) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "failed to reconfigure PTP adjustment");
-		return ret;
+		goto unlock;
 	}
 
 	priv->tsfupdt_coarse = ctx->val.vbool;
 	priv->systime_flags = systime_flags;
+unlock:
+	mutex_unlock(&priv->lock);
 
-	return 0;
+	return ret;
 }
 
 static int stmmac_dl_ts_coarse_get(struct devlink *dl, u32 id,

---
base-commit: aaaaf87ea99b8766c9a8aa0e71aa42e6bc8a5320
change-id: 20261002-stmmac-hwtstamp-missing-lock-b6a7979c643c

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

