Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A339C015
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789057854; cv=none; b=reNPmLmeEaaAljP1VjsuO6DVMdSabMGGxYd45zbwTJKz6v7/OAuU3wPTu4SSwGYB3g4NhGw7JcL9tJ1SPRkoo3xx73ipp+naA7C7y8bAa+pXrgdNfsnczHrigNGClwF9okuS7aF8fUH8xqedYrLxLObhbqMUw1xT9NScXY4caPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789057854; c=relaxed/simple;
	bh=BdDgjZVgjENYQnS82HkCLKPF+jdNAZBxg1UrJdsRaq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IGPkm5Bzcl5pHI3fJOZkuOqC62lJEtgPuvyJ+K5fb7YoAvG47knR8glcgG3ZfDJm7l0SFqwGH9e84/zHn1WEW9EAoznq8kUXlWI59RIRL5XRE4MKk93tGOoCPydFpoOxzpxAT/oFCkNbSNH2Bn+7Coj1sZAvBmc0NMRdlsjNsmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n1cjvJhz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CmW98Wrs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n1cjvJhz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CmW98Wrs"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF4HD81326061
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HbAhR2iPBS6JlP9jCk540R
	ehEd32H6vuse79vCpZM0Y=; b=n1cjvJhz4gG7UIRK8Cq0rZIexgbk862hQDmfdr
	jcakNl6JckhdFNvNqdsVd4PQovx1aHDLjp7YmAMp4IwlgkzMzeilT/zP6I0gus5Z
	W3t+yKAw1hePuKgsMJn2u6CLnkETccmhzjpPATUt/pkksUkPq2/wth4a4DkyvY/r
	tuYe2doGp034aoOsSLNQhjRp7tC2rl9KeEQgOJdkO/RjsAUjlV9/wH/eFdYY1lAC
	nhNTW5uHb1N6lX/V5OGQYXL8r9qCFnwwUu2G5Gb9k/tmuTuLZVoFKrrHqXUJ6mtV
	OKdl9Q75kc9dIlq1t2LB51S+Ppn6PhFcEPNXME8fxDesPAww==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwts0vbj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 16:30:46 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c66c4fd901so23887e0c.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789057846; x=1789662646; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HbAhR2iPBS6JlP9jCk540RehEd32H6vuse79vCpZM0Y=;
        b=CmW98WrsPUS//qSNJScTaqRBB9PngZtu7aGIsi1Qv/rFJl4QRGjvfm/epKY5oOGqgs
         00yYvSsMMGLh28w54kIJzHct+1RxlPp7Zo6h3Z77hw2lTL3l5KxjfvBMyTl+sK0zVPxI
         SFtu3/rr8mIGX3MhK3ExOj9BFs4/XeeHPRUtvjRX2JrR9qYQdtzKr42dZVRs3If+FsTh
         V825gHsL9qiqYG40/nb9kH9vism5L6KMIpGqYhOHXT9zOd75tinhUKiFGcHFXwiOoHXZ
         teWi4Q7G1Fi9uB4fSKvRlCeshcN+mbS94JgjdI4WutVwX6y3Da+K5nkeOEsZaWM4tBfR
         L6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789057846; x=1789662646;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HbAhR2iPBS6JlP9jCk540RehEd32H6vuse79vCpZM0Y=;
        b=Q/DtcNaU5JXZMBoZTgS2HgDAwEiS5+keveUUaMEXC/w3Lp5J2QJ2iadQ/pn5YGWQS1
         QNqfE7qtuWqfzYylG+rQ72M5uJhW3WcAR2oISzeS6HfO4HjY4nXYQNBp5gZ5Y+yWMoop
         de/5UokJqIF9bOcJ01Bmi80wW66mh95JpQk/XDgTHSCHhSKP9hflVd/ILVNy430RYkN5
         TFzj7JB5VHA9bw7/TZHXCJ1hqWnChFvXFbVgEHD8L/XsADe1po8U/Jh25tXo3ax8jPnQ
         Fgn/Bpkomvc2+z1m31tAyWxHKEL6b8WTUDs0zRGn6+Ljzp+WDe0/deT1h6hlEIGWpJe0
         ri7A==
X-Gm-Message-State: AFuF++lmkoxpAvHIr0vbXsxqLJ8dWjvGqNfeJp3FPVnP0xewCNDdBXTp
	AW0gJwirdZGtLB9Egujj/WjZ48IvuQtwMCzhpXmk8eCTY0SQz8D65+5O5oA9633mNt8uiXEhfG5
	Hnswdat/sMYtzruVtmU+FxIxsoj7+dk4te/uP2xkuUn9kff5IFTRQql2QbIk=
X-Gm-Gg: AYBFou2E1zy3MxDm1VN+ffaOVdsNktg5X484NvcWWdbPZ78/hS0NpEDATZTH3SqMMNn
	HKB5rKPkJkNK+CqAhRpDFsoInc1+mzH/yBVJwOqi70uhKn256SXg0B8MzYL5yLV3H8c85+K0rnU
	3ktgVGraXX4YBv6Ozi8MOzVdEHAgUz0T2kVRRv6NoFDTXcOUGuhfMgdcyo9TZR6gtMjxZA+kl6m
	xzboXvS8Odm8q9F9oc0cN45O8/hv0vGv/MfAKVSmH/kruq2LfOmzvFk5oJHQnoO5fOQ02Q0uRNm
	nIOnI/fxHvf6r5Ojh2SS27FV+Ya/YHc/6VcO32kipYHm5zKqdDUfIy57TfH0gbci6+Ux2NGpgfg
	XCTRZ8AqSI+Ltmg==
X-Received: by 2002:a05:6122:420e:b0:5c7:ac2a:770 with SMTP id 71dfb90a1353d-5c84606cfcamr549342e0c.2.1789057845311;
        Thu, 10 Sep 2026 09:30:45 -0700 (PDT)
X-Received: by 2002:a05:6122:420e:b0:5c7:ac2a:770 with SMTP id 71dfb90a1353d-5c84606cfcamr549226e0c.2.1789057844791;
        Thu, 10 Sep 2026 09:30:44 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d1fb1e60bsm130205775e9.0.2026.09.10.09.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 09:30:43 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:30:20 +0200
Subject: [PATCH net v3] net: stmmac: propagate PTP init failures in
 __stmmac_open() and stmmac_resume()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-stmmac-ptp-error-propagate-v3-1-4f386e8256b6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NTQrDIBAF4KsU1zWMRvLTVe9RujBmkgg1WrXSE
 nL3iqsuSulm4L0H32wkoNcYyOmwEY9JB23XHOrjgahFrjNSPeZMOPAGehA0RGOkoi46it5bT52
 3Ts4yIm0UMNEOQiHvSQacx0k/C34hK0ZyzeWiQ7T+VR4mVqZ/7MQoox1MwAaoRznJsw2huj/kT
 VljqnyKnvin2P4UeRaF5NihYNg18EXc9/0Nzd3+3yIBAAA=
X-Change-ID: 20260904-stmmac-ptp-error-propagate-6c0147b4ce29
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>,
        Thierry Reding <treding@nvidia.com>,
        Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=PIaaavqC c=1 sm=1 tr=0 ts=6aa2db36 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8 a=fjIqBVsnwoag37M7--IA:9
 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: -2UVDrFbnexR_Q7r-MmiOailcu0olKYx
X-Proofpoint-ORIG-GUID: -2UVDrFbnexR_Q7r-MmiOailcu0olKYx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIwMCBTYWx0ZWRfX/Gv+Bgvwev7j
 +Zj0i3fqVG6/KagujaL5fqJcoqXQwKmw9BMrlJvUGQStQMk0vBiyd/PgtKSMJVtCkpSh2Q8Aba5
 DCGKSw0q9N8ROl5h5D96s+58zmyGPt4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIwMCBTYWx0ZWRfX7SKLwcGRUiON
 ednDkgTNjdLkpGTBL/HTq5dkunGreM3swYBIo54gDQ69llvwlp295M+At6BDZGIekgcNIdP+Z25
 cHz97Oatytp1DYzHZGYZ1dG0bBEQe0wtQthl2/CmQ/2lObI89OZ+8TOCkWJubnI5Sn7p/q+IcKg
 DBuRJUt3Z/44gPL97qveM1j4YqbMKBoEvjH/mtHAXyAScgJDqOagzvn6KdxW6o+V2egvIRjwSwq
 bE/Cfazgt8oTXJSsfV0wviPjGce/EJ7bHA+PhXS3fb2TfmRbHg7HAlFUNAFx/GqZd+pZBBsJxSS
 S4JfWZeDmQ4g5N2ta/urqu8ngKeOqvxDa2nC+CS9GxivldejhKSnF5jEFdSnbZTK2Hzz2nVnZLi
 OdjwQs3q7yw6UqtMFakNedkMQK0wegIcUQAJHavALdH7xIInUOgE12R6oMsonZeGMhShgf+dnn5
 leuF4o8FzQar7exX57g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100200

stmmac_setup_ptp() returns void and swallows both PTP setup errors:
the PTP reference clock enable and stmmac_init_timestamping()
failures are logged but never propagated. When they fail, the MAC
system time counter is left in its post-reset, non-running state,
while the driver keeps operating as if timestamping were up.
This matters for TAPRIO/EST qdisc offloading, which derives the EST
base time from the hardware timestamp counter: arming the gate list
against a non-advancing time base would leave the schedule permanently
stuck.

Make stmmac_setup_ptp() return an error code and propagate the
failure in __stmmac_open() and stmmac_resume(), stopping the DMA
engines when PTP setup fails.

Extend the same error propagation to the timestamping counter
initialisation: stmmac_update_subsecond_increment() and
stmmac_init_tstamp_counter() now return the addend and system time
programming errors instead of discarding them, so a counter that
cannot be configured is reported as a failure rather than silently
left non-running.

While at it, factor the timestamping availability check into a
stmmac_check_timestamp_cap() helper that requires both the hardware
timestamping capability and a valid PTP reference clock rate. This
keeps the interface operational on platforms with PTP-capable
silicon but an unconfigured PTP clock, where timestamping cannot be
enabled: those are treated as PTP-less rather than failing to open
or resume. Apply the same helper to the hwtstamp get/set paths so
they consistently report -EOPNOTSUPP when timestamping is not usable.

Gate the PTP reference clock enable/disable in the platform noirq
suspend/resume callbacks with the same helper, keeping the clock
reference balanced against the new early return in
stmmac_release_ptp().

Fixes: 92ba6888510c ("stmmac: add the support for PTP hw clock driver")
Fixes: 0ad2be79f254 ("net: stmmac: Balance PTP reference clock enable/disable")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v3:
- Rebase on top of net main branch.
- Link to v2: https://lore.kernel.org/r/20260907-stmmac-ptp-error-propagate-v2-1-4a2e8e41e860@oss.qualcomm.com

Changes in v2:
- Check clk_ptp_rate value in stmmac_check_timestamp_cap().
- Return error code in stmmac_update_subsecond_increment() and
  stmmac_init_tstamp_counter().
- Rely on stmmac_check_timestamp_cap() in stmmac_hwtstamp_set() and
  stmmac_hwtstamp_get().
- Link to v1: https://lore.kernel.org/r/20260904-stmmac-ptp-error-propagate-v1-1-80f01b03dafa@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       | 11 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 98 ++++++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  6 +-
 3 files changed, 78 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..0a00490832f3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -419,6 +419,17 @@ int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 
 struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev);
 
+static inline bool stmmac_check_timestamp_cap(struct stmmac_priv *priv)
+{
+	if (!priv->dma_cap.time_stamp && !priv->dma_cap.atime_stamp)
+		return false;
+
+	if (!priv->plat->clk_ptp_rate)
+		return false;
+
+	return true;
+}
+
 static inline bool stmmac_xdp_is_enabled(struct stmmac_priv *priv)
 {
 	return !!priv->xdp_prog;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 5fe7e95fdd34..7f5ada1132c4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -601,7 +601,7 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 	}
 }
 
-static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
+static int stmmac_update_subsecond_increment(struct stmmac_priv *priv)
 {
 	bool xmac = dwmac_is_xmac(priv->plat->core_type);
 	u32 sec_inc = 0;
@@ -625,7 +625,7 @@ static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
 	 */
 	temp = (u64)(temp << 32);
 	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
-	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
+	return stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
 }
 
 /**
@@ -653,7 +653,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 	u32 ts_master_en = 0;
 	u32 ts_event_en = 0;
 
-	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
+	if (!stmmac_check_timestamp_cap(priv)) {
 		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
 		priv->hwts_tx_en = 0;
 		priv->hwts_rx_en = 0;
@@ -843,7 +843,7 @@ static int stmmac_hwtstamp_get(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
+	if (!stmmac_check_timestamp_cap(priv))
 		return -EOPNOTSUPP;
 
 	*config = priv->tstamp_config;
@@ -865,32 +865,32 @@ static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 				      u32 systime_flags)
 {
 	struct timespec64 now;
-
-	if (!priv->plat->clk_ptp_rate) {
-		netdev_err(priv->dev, "Invalid PTP clock rate");
-		return -EINVAL;
-	}
+	int ret;
 
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
 	priv->systime_flags = systime_flags;
 
-	stmmac_update_subsecond_increment(priv);
+	ret = stmmac_update_subsecond_increment(priv);
+	if (ret)
+		return ret;
 
 	/* initialize system time */
 	ktime_get_real_ts64(&now);
 
 	/* lower 32 bits of tv_sec are safe until y2106 */
-	stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec, now.tv_nsec);
-
-	return 0;
+	return stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec,
+				   now.tv_nsec);
 }
 
 /**
  * stmmac_init_timestamping - initialise timestamping
  * @priv: driver private structure
- * Description: this is to verify if the HW supports the PTPv1 or PTPv2.
- * This is done by looking at the HW cap. register.
- * This function also registers the ptp driver.
+ * Description: configure the PTP reference clock and initialise the hardware
+ * timestamp counter, then detect which timestamping modes the HW supports.
+ * The caller is responsible for enabling the PTP reference clock and for
+ * registering the PTP clock driver.
+ * Return: 0 on success, or a negative error code if the timestamp counter
+ * cannot be initialised.
  */
 static int stmmac_init_timestamping(struct stmmac_priv *priv)
 {
@@ -900,11 +900,6 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
 	if (priv->plat->ptp_clk_freq_config)
 		priv->plat->ptp_clk_freq_config(priv);
 
-	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
-		netdev_info(priv->dev, "PTP not supported by HW\n");
-		return -EOPNOTSUPP;
-	}
-
 	ret = stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
 					       PTP_TCR_TSCFUPDT);
 	if (ret) {
@@ -937,22 +932,39 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
 	return 0;
 }
 
-static void stmmac_setup_ptp(struct stmmac_priv *priv)
+static int stmmac_setup_ptp(struct stmmac_priv *priv)
 {
 	int ret;
 
+	if (!stmmac_check_timestamp_cap(priv)) {
+		netdev_info(priv->dev, "PTP not supported\n");
+		return 0;
+	}
+
 	ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
-	if (ret < 0)
+	if (ret < 0) {
 		netdev_warn(priv->dev,
 			    "failed to enable PTP reference clock: %pe\n",
 			    ERR_PTR(ret));
+		return ret;
+	}
 
-	if (stmmac_init_timestamping(priv) == 0)
-		stmmac_ptp_register(priv);
+	ret = stmmac_init_timestamping(priv);
+	if (ret) {
+		clk_disable_unprepare(priv->plat->clk_ptp_ref);
+		return ret;
+	}
+
+	stmmac_ptp_register(priv);
+
+	return 0;
 }
 
 static void stmmac_release_ptp(struct stmmac_priv *priv)
 {
+	if (!stmmac_check_timestamp_cap(priv))
+		return;
+
 	stmmac_ptp_unregister(priv);
 	clk_disable_unprepare(priv->plat->clk_ptp_ref);
 }
@@ -4161,10 +4173,12 @@ static int __stmmac_open(struct net_device *dev,
 	ret = stmmac_hw_setup(dev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
-		goto init_error;
+		return ret;
 	}
 
-	stmmac_setup_ptp(priv);
+	ret = stmmac_setup_ptp(priv);
+	if (ret)
+		goto ptp_error;
 
 	stmmac_init_coalesce(priv);
 
@@ -4189,7 +4203,10 @@ static int __stmmac_open(struct net_device *dev,
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
 	stmmac_release_ptp(priv);
-init_error:
+ptp_error:
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
+
 	return ret;
 }
 
@@ -7685,9 +7702,7 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
 	/* In Coarse mode, we can use a smaller subsecond increment, let's
 	 * reconfigure the systime, subsecond increment and addend.
 	 */
-	stmmac_update_subsecond_increment(priv);
-
-	return 0;
+	return stmmac_update_subsecond_increment(priv);
 }
 
 static int stmmac_dl_ts_coarse_get(struct devlink *dl, u32 id,
@@ -8327,13 +8342,14 @@ int stmmac_resume(struct device *dev)
 	ret = stmmac_hw_setup(ndev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
-		stmmac_legacy_serdes_power_down(priv);
-		mutex_unlock(&priv->lock);
-		rtnl_unlock();
-		return ret;
+		goto error_unlock;
 	}
 
-	stmmac_init_timestamping(priv);
+	if (stmmac_check_timestamp_cap(priv)) {
+		ret = stmmac_init_timestamping(priv);
+		if (ret)
+			goto error_stop_dma;
+	}
 
 	stmmac_init_coalesce(priv);
 	phylink_rx_clk_stop_block(priv->phylink);
@@ -8357,6 +8373,16 @@ int stmmac_resume(struct device *dev)
 	netif_device_attach(ndev);
 
 	return 0;
+
+error_stop_dma:
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
+error_unlock:
+	stmmac_legacy_serdes_power_down(priv);
+	mutex_unlock(&priv->lock);
+	rtnl_unlock();
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(stmmac_resume);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 6128ed1bd521..dcfce51b2886 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -959,7 +959,8 @@ static int __maybe_unused stmmac_pltfr_noirq_suspend(struct device *dev)
 
 	if (!priv->wolopts) {
 		/* Disable clock in case of PWM is off */
-		clk_disable_unprepare(priv->plat->clk_ptp_ref);
+		if (stmmac_check_timestamp_cap(priv))
+			clk_disable_unprepare(priv->plat->clk_ptp_ref);
 
 		ret = pm_runtime_force_suspend(dev);
 		if (ret)
@@ -984,6 +985,9 @@ static int __maybe_unused stmmac_pltfr_noirq_resume(struct device *dev)
 		if (ret)
 			return ret;
 
+		if (!stmmac_check_timestamp_cap(priv))
+			return 0;
+
 		ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
 		if (ret < 0) {
 			netdev_warn(priv->dev,

---
base-commit: 2ac09b5353fe6858411fdc8c6efa60d832e20f13
change-id: 20260904-stmmac-ptp-error-propagate-6c0147b4ce29

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

