Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277A390239
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789288161; cv=none; b=PJSk3sBfVlEPjjv0Janl9iI+C3j3FnYt3+QTAjY9H6Op58U1u0RX5nZq80/r6uMZLUnoI7jUQIiiz9tNjb6lSUXu2SAIXOV+devr9kSxzxCW3mS9LfJ+MbXQNdseuhy+WVAyXei1GdPUYKY0fBd889MV5DYVDZHo6xd/Z8qgons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789288161; c=relaxed/simple;
	bh=BMzy6TzcpABrHW/cvniQxYw46VTYN40C8wKb1+cZHCg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nReNlV7EmmeSZmWCYUhVRFfj3l2t5ZzhNRegqsH4Q16xZJNKXXIF2lN4xfMkiCMQDlbOEeZLWw5LC3LKknpoxkwieTlt8Z6LNp0YscxPSqAg8FREk6IjwkoizpI902jga+cCPEjLh/NG1RZElvi0oAtxpqAxZtn/l1rRh0Lxg1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=niS2aWZT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KotCY2Wf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="niS2aWZT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KotCY2Wf"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68D7VfuX463321
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 08:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=M95Bm5VFm4God59VQwDASL
	qUlPy5RyXv405harasprE=; b=niS2aWZT777KmIy+W3ThkU3Q1OLLipHKVIX6ew
	odA3n4LbZsYNy1pGkefoEXxehVfWPWbAXsI+CRtmcNsoF0aAeIN6QeV1970ttzJd
	BJ+kxU+VChiEH97Cz0j0kqsw/qTS+2EPrsXc9Rmwfhvx/whJZAVyVP373h3B4d7G
	FRiS0wS1k7RQl/ppMiqozM0bG7kaVX1IrsJTkJHmFLjB1cOmuOEq7F+2U9ZteZbg
	PO77yokfFH/uPOrmjY34qd8BokgtmYzeFJu2K0aTyMqD7qa4/ei0PSlE3mVJitOn
	mhJzU6jZ0iBstFC7A2fKDp9/yV6ZTMynEIHNV2ukMwfafq0A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9catnq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 08:29:18 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93a1d44c437so15886885a.1
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 01:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789288157; x=1789892957; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M95Bm5VFm4God59VQwDASLqUlPy5RyXv405harasprE=;
        b=KotCY2WfixJP+XQL3kp+yshrdTMAlUaEt6ZCTrBIYY3uS+cVSx4z8xEtHxEYYzx3T3
         1K2fwaEvizRiGRZgj7+uaqlv/O+YzEfMitjghw+0baXHQsh2cyUBgygbLPaPzsrPgOc+
         2iNPQ8TNzJPHFLx/TLtnA3o3ozMSiCBjD0MBk7NEy0ezdcFdHhC6LruTugvx5o0/dGoy
         epVCLptxgiaEHQuKHCxlxHSflRS/w9IHjAOoN2XM1i8THylV8MZSQuFuh5FPfqgYHRAC
         AmoQQY+CKLQ/jjQUyyEA5SHNg96o0YZ2J6LcTSUn2iO0YkbQH401t7BobCSwPb4Xp+SS
         fqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789288157; x=1789892957;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=M95Bm5VFm4God59VQwDASLqUlPy5RyXv405harasprE=;
        b=fXhzHXp4ftbV5e9Sv8KVTBiQJrB9BDLttZpANmn4qhnq6f3zyaUYvyd5xxzi9fjJxh
         kdlHjXH0/+tWcLXpZjoTY1m5/KwAOeKrc+1edWUe0BtMWlFbZVcOoQhExXAeYJcy3YWd
         Cf/Rax/wn0uKivOHGMUlv/RcC/ZcV1Fh926SnXqPo/7FO+ow9NyQcqR4IZnAtaO4tpGL
         u6HpyW7mgTQ0KP+/O6zvxbc82HBzRnODV/XeOdz66NKuKFXT4g6PbFaeHjaN2vbxN+WZ
         CaLX93cBy+qPZrxdJKYIzr3kZuYhJ/XqBW3F2Hh7Sa04CAcnLgn3Da5a6ytTvCkdCJ7s
         KZlw==
X-Gm-Message-State: AFuF++mXttoiFz0zjS6rdFDvZdOHhztjwNz9sfUrxqECPcmU8CAXRfMB
	sIRFupBezmfCw+6a9ky7sP4eBbDvWN/gSCyCf/rY/3bZBjOtg/xZk0b9gsZZaZtnoshN30AnOHu
	TuIgKAyaYrXfjPixn/+IGz63riOqbrRN3+C8YTCyfQk1hOfMSFOZUBrMO+hE=
X-Gm-Gg: AYBFou0iXYd6ybfc1pXtLvCl9RAd6YsrSESdNSayjAdQdeyZwP8LH35PZ3CVG8zUyPJ
	rNbniKTBdglUy1KfVMhvG+5rsliFyr7D5FPxyJzSdWMcISk+Nn0/5ndQXKUbItqW2Re5DrHNw0Q
	zVDjE7hQQXTtPiQqT2jA0UqREEx2zk+vLkXrDTbfvfWnGZazU3WFjuL3W66EirPU6iycSVmdCUh
	DPXwq9ZdgapypGm0o4IL+hj5xb5thOjyKUvgwFOsuHS5f/JYUUTTOojGDdIaN//ENrVgdNdQ76u
	xpcFp+oUGHSpRi9yZKSx/ViSgGv+wSR2FwcKLOA1jmYNWASPo8brEJdcEXe+h9REdmQ9IdsOF0/
	VVJIV3lj4MdLlfg==
X-Received: by 2002:a05:620a:711a:b0:939:d38:3ab8 with SMTP id af79cd13be357-939ea11353cmr1624308785a.12.1789288157172;
        Sun, 13 Sep 2026 01:29:17 -0700 (PDT)
X-Received: by 2002:a05:620a:711a:b0:939:d38:3ab8 with SMTP id af79cd13be357-939ea11353cmr1624306685a.12.1789288156575;
        Sun, 13 Sep 2026 01:29:16 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6fe9d3e3sm68237815e9.0.2026.09.13.01.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 01:29:15 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sun, 13 Sep 2026 10:29:00 +0200
Subject: [PATCH net v4] net: stmmac: propagate PTP init failures in
 __stmmac_open() and stmmac_resume()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-stmmac-ptp-error-propagate-v4-1-a947aceac928@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQ7CIBAF0Ks0rKUZKCJ15T2MC0qnlcQWBGw0p
 ncXu3KhjZtJ/v/JmyeJGCxGsi+eJOBko3VjDmJTEHPWY4/UtjkTDlxCDYLGNAzaUJ88xRBcoD4
 4r3udkEoDTOwaYZDXJAM+YGfvC34kIyZyyuXZxuTCY3k4sWX6x54YZVRBB6yBqtWdPrgYy+tNX
 4wbhjKfRZ/4p7hbFXkWheaoUDBUEn6I1YfIYFWs3mJXKYmKb2Ujv4jzPL8AnffahHQBAAA=
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
        Russell King <linux@armlinux.org.uk>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: JlXpopchvnA0QrANJjbqfnUXTzjkeGjV
X-Authority-Analysis: v=2.4 cv=Pv4G/AM3 c=1 sm=1 tr=0 ts=6aa65ede cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8 a=ajOIpsWwYqLBSbH5xuYA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDExOSBTYWx0ZWRfX9yo3joksi3lo
 Lbx7VwbNnjbxNgaOYgaluB72gR4fNsaDoLcuexxubUBI0p3ViGjApp29EEjncUe4dH4Okhh7wJG
 1zgFNbyNCZG8aTXfXag5c3CZ1GiYjN8=
X-Proofpoint-ORIG-GUID: JlXpopchvnA0QrANJjbqfnUXTzjkeGjV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDExOSBTYWx0ZWRfXy+qsczeCUXak
 4bl6SGhoJPozcP9QQIbdlZ4Pk+3Krqt6fmFnkuDfUuF2J2oHbWWCgkvejEimvsRpuINkSLdCr0Z
 UsmwabangkR+c/iIHhttCHng0ixcbJ9nBRDyIrKIqXOBSWbfGyxHwODbI8studTHQvG/rNZAgRf
 2CCsJsNVHk0thxNu6gBpXyK/Mr/jYitczbNmEns1A7qsiGY9TzfK5sdJeN5HaazEccfsDO5x4KZ
 L8lqTPWLcEah3CFBD6Syc7tKEvuf2SyIFr96yJJoCo3lH6KtXkrtx6l4vaxtLTmH6R7tlayUfRs
 w6TOsiiAsU3L3R+px0nPh6S7Y8hUIYJu44AXvw3G7PlnXpT1ZQv2Eh4JUafhdxgGTc6f0bWHEDW
 TRcr6DjtUuAwgednCYg0GHBMjF7tC+uOvsvvJNMJSZ4YDQe1JtPmYZ4tLpYvVpaS0PygcCaSTA3
 iz3Q3Ie6uyt19Zst/gA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_03,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609130119

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

While at it, factor the timestamping availability check into a
stmmac_check_timestamp_cap() helper that requires both the hardware
timestamping capability and a valid PTP reference clock rate. This
keeps the interface operational on platforms with PTP-capable
silicon but an unconfigured PTP clock, where timestamping cannot be
enabled: those are treated as PTP-less rather than failing to open
or resume. Apply the helper to the hwtstamp get path and the
ethtool ts_info path, and keep the timestamping gate on the set path
(now also requiring a valid PTP reference clock rate), so all of
them consistently report -EOPNOTSUPP when timestamping is not usable.

Gate the PTP reference clock enable/disable in the platform noirq
suspend/resume callbacks on priv->ptp_enabled, keeping the clock
reference balanced against the new early return in
stmmac_release_ptp().

Fixes: 92ba6888510c ("stmmac: add the support for PTP hw clock driver")
Fixes: 276aae377206 ("net: stmmac: fix system hang caused by eee_ctrl_timer during suspend/resume")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v4:
- Drop stmmac_restore_subsecond_increment() and
  stmmac_update_subsecond_increment() changes for the moment.
- Add ptp_enabled check in stmmac_pltfr_noirq_suspend() and
  stmmac_pltfr_noirq_resume().
- Link to v3: https://lore.kernel.org/r/20260910-stmmac-ptp-error-propagate-v3-1-4f386e8256b6@oss.qualcomm.com

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
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       | 13 ++++
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 72 +++++++++++++++-------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |  6 +-
 4 files changed, 70 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..c781cf3441fc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -329,6 +329,8 @@ struct stmmac_priv {
 	struct kernel_hwtstamp_config tstamp_config;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_ops;
+	bool ptp_enabled;
+
 	unsigned int default_addend;
 	u32 sub_second_inc;
 	u32 systime_flags;
@@ -419,6 +421,17 @@ int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 
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
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 154cc0c7623d..7758b854700a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1007,8 +1007,7 @@ static int stmmac_get_ts_info(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if ((priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
-
+	if (stmmac_check_timestamp_cap(priv)) {
 		info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
 					SOF_TIMESTAMPING_TX_HARDWARE |
 					SOF_TIMESTAMPING_RX_HARDWARE |
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 62c3441911e7..9d2c6bf68575 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -653,7 +653,8 @@ static int stmmac_hwtstamp_set(struct net_device *dev,
 	u32 ts_master_en = 0;
 	u32 ts_event_en = 0;
 
-	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
+	if (!priv->plat->clk_ptp_rate ||
+	    !(priv->dma_cap.time_stamp || priv->adv_ts)) {
 		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping");
 		priv->hwts_tx_en = 0;
 		priv->hwts_rx_en = 0;
@@ -843,7 +844,7 @@ static int stmmac_hwtstamp_get(struct net_device *dev,
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
 
-	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
+	if (!stmmac_check_timestamp_cap(priv))
 		return -EOPNOTSUPP;
 
 	*config = priv->tstamp_config;
@@ -900,11 +901,6 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
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
@@ -937,24 +933,43 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
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
+	priv->ptp_enabled = true;
+
+	return 0;
 }
 
 static void stmmac_release_ptp(struct stmmac_priv *priv)
 {
+	if (!priv->ptp_enabled)
+		return;
+
 	stmmac_ptp_unregister(priv);
 	clk_disable_unprepare(priv->plat->clk_ptp_ref);
+	priv->ptp_enabled = false;
 }
 
 static void stmmac_legacy_serdes_power_down(struct stmmac_priv *priv)
@@ -4161,10 +4176,12 @@ static int __stmmac_open(struct net_device *dev,
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
 
@@ -4189,7 +4206,10 @@ static int __stmmac_open(struct net_device *dev,
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
 	stmmac_release_ptp(priv);
-init_error:
+ptp_error:
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
+
 	return ret;
 }
 
@@ -7740,8 +7760,7 @@ static int stmmac_register_devlink(struct stmmac_priv *priv)
 	/* For now, what is exposed over devlink is only relevant when
 	 * timestamping is available and we have a valid ptp clock rate
 	 */
-	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp) ||
-	    !priv->plat->clk_ptp_rate)
+	if (!stmmac_check_timestamp_cap(priv))
 		return 0;
 
 	priv->devlink = devlink_alloc(&stmmac_devlink_ops, sizeof(*dl_priv),
@@ -8346,13 +8365,14 @@ int stmmac_resume(struct device *dev)
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
+	if (priv->ptp_enabled) {
+		ret = stmmac_init_timestamping(priv);
+		if (ret)
+			goto error_stop_dma;
+	}
 
 	stmmac_init_coalesce(priv);
 	phylink_rx_clk_stop_block(priv->phylink);
@@ -8376,6 +8396,16 @@ int stmmac_resume(struct device *dev)
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
index 6128ed1bd521..19d481554499 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -959,7 +959,8 @@ static int __maybe_unused stmmac_pltfr_noirq_suspend(struct device *dev)
 
 	if (!priv->wolopts) {
 		/* Disable clock in case of PWM is off */
-		clk_disable_unprepare(priv->plat->clk_ptp_ref);
+		if (priv->ptp_enabled)
+			clk_disable_unprepare(priv->plat->clk_ptp_ref);
 
 		ret = pm_runtime_force_suspend(dev);
 		if (ret)
@@ -984,6 +985,9 @@ static int __maybe_unused stmmac_pltfr_noirq_resume(struct device *dev)
 		if (ret)
 			return ret;
 
+		if (!priv->ptp_enabled)
+			return 0;
+
 		ret = clk_prepare_enable(priv->plat->clk_ptp_ref);
 		if (ret < 0) {
 			netdev_warn(priv->dev,

---
base-commit: 6500e89132d5d510c75e1be443455af87267b40e
change-id: 20260904-stmmac-ptp-error-propagate-6c0147b4ce29

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

