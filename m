Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138749C4D5
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789399625; cv=none; b=eOCrj9Z7b9KEiyLFNZQw5w6a2MpsosQquaEV5L1S4L7aMyuE4UTggeu1w7gfGecj3pZBj4oKbZgT/53vrRGJFququ3po/GVMo11OcBe5SXGL4vMiTdLYwcxWQD3WSy9hZJqGg/dX1YlGA4OB6i00CCiT2fuWMw8eQ2Ve4sCRP/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789399625; c=relaxed/simple;
	bh=ZWomnV3In/vJRIp6lFnG0GclZX8vhJ0bCa8mbTVyyDA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OyAZI1a20wtitKW4YiympIcVR7g6CGTzY0kzgPtYkyzPrhlypfHmeaedZlyinKvpnbL/VHRNHTzhE/rwmHpaopPExqIizVgZxtYdNNYk2bOud/6D0rlWycbwm+EaVTDbKf65sg1LQ4WfjMnPgTirZcJHr3KD+Ys8ytBa3gdNPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLCzAzr2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aUqQmy0h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLCzAzr2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aUqQmy0h"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ED0YUq4091235
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WfeSSIGEMf5/K70d7iHCjK
	sPLBWa2a40x5/XuD7ShWA=; b=gLCzAzr2kq9jO7ZYOIbNv771/R6UdSWd30fMAJ
	b3DSelcmoBTj3NGUrVgZv1MmE1pvByqygVwQ4U4HhYN1u8VhOLB1CL/j19Cq13T0
	M796Klv/AcAQvZjo5kYkIJaKQLZR0bbag9mA1FaEFldzjNE2wEw36OxTFJ4YBcEn
	UCnDMZAZ41B+cKjGZEDUbpTmY19tbFJdlt2V57hoSxjTcuLVqYZeenSlwTomwo0U
	mTWSJgFkixquL7v0y4u9jwKhhZoeVVrIs3AC5c1c3K+0GMV5ERFQWgLwzM6RslzX
	RKz+0Civ/38spjxahafJk8wIqgbWpsFCiL81tXTjoBe2uXKg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpcjg1v4h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 15:27:02 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-785827e6073so719310137.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789399620; x=1790004420; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WfeSSIGEMf5/K70d7iHCjKsPLBWa2a40x5/XuD7ShWA=;
        b=aUqQmy0hNlVfym6jrrRn74bXRERJWwkxYVo8h8mzIooVztQ7NMWHv+NWpIrkFcQoZQ
         O9ySyrDGO5Mmk4hL/5jUqpje2Zkpg8d2LBKBFrs3QLzniFQ1DX1LFYHNWfZv6BClQuMy
         tIx1UHuGBgHke0gSxpgZQDYsH78LTUMG5xK9Rcl/up331No+9vqkiNTk+9Jh0pqXcLo7
         SVY4qOs+x0SdPxAN8ANk6FET4lUIersmuzkdNzkCWtLFwDpdlnYZE+ihLVILiLKGKyoI
         KaE6qeAulXvC8Cvvon/y6XGCJtrz1QBMHq3WLv/GVflhXJB7mecSNgExCru79dCCvXbC
         T6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789399620; x=1790004420;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WfeSSIGEMf5/K70d7iHCjKsPLBWa2a40x5/XuD7ShWA=;
        b=Zdhji0UBh3KiB4cQ1JxXt+KHnsgtHmCNRaNHxXzhSWztZdIfDVJjzQWv0J8lQbcvUR
         VtJHqWR4SIaUMWJgLL1kjzwjOAMIPTRZFIGrFpW81nZ97V3MyKRF1Zt9UtyVRroT4pXS
         7mraa6fD2M8eWVszWDaZ5amDwL9z7+5LLSqsabIwUSInTCjlLubhUe6UPIu4nyr5BdOz
         qFy3kPubosK3cJFmQV6Wt+WLNGOS9yVL5pMHWDwnvzzltZL96wNvitpWSp7ypDKqpilP
         CIwVmPQuj3qwq5uqMVykFAboIQQfGnfzQpqAF6K1qGnLw6n4kyrsIq1BLGNR+/74xT7d
         /dXw==
X-Gm-Message-State: AFuF++nA77hN4Ae5wEHgD7CROY6ILu25QK1kdpV61kzBz0llsuWKrt+C
	2ODuX+H8w3aSO9Y7aMPFOukzRFN3RX9hM0MIc7NVD4+7U9s+1an6S6eEzNACZDT1W+ABGRVi/t6
	ONS+LB1Nd0bjd+am4TZyNLw+ZRoKrqUgzFKapcVDUlP34dIMPLZh7zQlBbA8=
X-Gm-Gg: AYBFou0Z1QoBN+OKgKsuJpGPQiWqCZTwoo+wNvxceybd8oUPUACqjZiK3bDP0HzCTlB
	yCJ/VHIoSz68hpPEfnWrLJhS45SV+cCTCHOjbmpEHZyerY1eP6bk4e+iMReXu8ARxT7W3N0kQrJ
	0ILth5wiXf+62y6JMVf3u6cnyL40oOcqyNzf1xEuAnpDHO1FCKX4EigjMpsPM5NbUhauVJk4qjP
	m0JEwOPK7GBqPT/yBJvrkHiufwq3jXqbV/TqHxbFWsmyykY+cjgeugOVfWIEhFvlmDePEun3FVS
	fjZaDOsUHy9y3fy6xrQlr2Ws5H+UuZtGSxq4SXJhpOYKauZbRgi7VA6DDSrGoqWb0gzX0g6xrzN
	zlyeBCT7csVbd/A==
X-Received: by 2002:a05:6102:80a3:b0:796:9525:ac63 with SMTP id ada2fe7eead31-79b5adb9951mr3385094137.9.1789399619327;
        Mon, 14 Sep 2026 08:26:59 -0700 (PDT)
X-Received: by 2002:a05:6102:80a3:b0:796:9525:ac63 with SMTP id ada2fe7eead31-79b5adb9951mr3384908137.9.1789399618486;
        Mon, 14 Sep 2026 08:26:58 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d2915d6sm4926985e9.4.2026.09.14.08.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:26:57 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 17:26:44 +0200
Subject: [PATCH net v5] net: stmmac: propagate PTP init failures in
 __stmmac_open() and stmmac_resume()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-stmmac-ptp-error-propagate-v5-1-81149897e65d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NTW7CMBAF4Ksgr2s0/sFxuuo9KhYTMwFLTezaJ
 mqFcndMVllAxGak9570zY1lSp4y+9zdWKLJZx/GGg4fO+YuOJ6J+1PNTII00ILmuQwDOh5L5JR
 SSDymEPGMhbhxIHTTaUeyZRWIiXr/t+DfbKTCjrW8+FxC+l8eTmKZ3rEnwQW30IPoQJ2wx6+Q8
 /73ij8uDMO+nkWf5FpsNkVZRY2SLGlB1sALUa1EAZuieoi9soasPJjOvBD1WlSboq4itrpBR+h
 aaZ+I8zzfARxh7ejGAQAA
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
X-Authority-Analysis: v=2.4 cv=CKa/zhrD c=1 sm=1 tr=0 ts=6aa81246 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8 a=DHtdb9-wNaOo6L0ygOcA:9
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: aYWDVyA4meV45Sub6Kh4UBTcvD1fJekW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIyMiBTYWx0ZWRfX/Vr8RsuAhWr7
 qiRUXdmGR03O1/eN1pp6PfXoWA7TchK4KQWN8kyA3AuALVAWwmw7NvQJrw77FE4WQlVWoPY27kG
 2GscsAkZicx/PDtyApZ/j/BJbd+ieKM=
X-Proofpoint-GUID: aYWDVyA4meV45Sub6Kh4UBTcvD1fJekW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIyMiBTYWx0ZWRfXxD8rKEF/tzO1
 4XrzcRWhNH0gqVd+vmifEQOSqEPmsRXp1MdNZb3bFQuQzn3uhTOgZWUCJfy/hsFB4Hd2bbyBDPo
 MrhZYxtSXSRH0LqD2jI/+RCOdhAYqVQn24dTKUeveVYfUpOhpPYxCXDeBdBZi3h10ifTPXZIYi0
 mxdG6PtlsUZFbtqVEbm3y8iQnRnrL5VTjBduZYalq8UVApjH0C8aADseNndBYSXro08uKbOL5iC
 GvcDAkYNTpQvOWDx9y1DRR4QUWvMeIT+ZR0RbWWEM0AfP2flT2VWahKDYXp0Rmc3z87LWjlYxCM
 SdzRltBzDSm2KXyjHcPwvgTc9WXHpU/bCOCFVEJldQ/9NeX7nfwx9/KzOxb01s5RkUUrzSlA6SK
 l61PcU8FG738tWwPKVLUjiBpojYP/AdfD5fax7+xrfaZ3h3jB8HYS5jCCaWeE4WzY4LmxMdcCWK
 R40UahPqzriHdduBhwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140222

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
failure in __stmmac_open(), stopping the DMA engines when PTP setup
fails. In stmmac_resume(), re-initialise timestamping only when the
PTP clock was registered before suspend, re-apply the platform clock
rate configuration, and stop the DMA engines if re-initialisation
fails.

While at it, factor the hardware timestamping capability check into a
stmmac_check_timestamp_cap() helper and apply it to the hwtstamp get
path and the ethtool ts_info path. stmmac_setup_ptp() now enables the
PTP reference clock and runs the platform ptp_clk_freq_config()
callback before validating the resulting clock rate; if no valid rate
is available, it disables the clock and returns success without
registering the PTP clock. This keeps the interface operational on
platforms with PTP-capable silicon but an unconfigured PTP clock,
where timestamping cannot be enabled: instead of failing, the driver
proceeds without setting up timestamping. Extend the timestamping gate
on the set path (which keeps testing the core's basic/advanced
timestamping capability) and the devlink registration with the PTP
reference clock rate requirement.

Gate the PTP reference clock enable/disable in the platform noirq
suspend/resume callbacks on priv->ptp_enabled, keeping the clock
reference balanced against the new early return in
stmmac_release_ptp().

Fixes: 92ba6888510c ("stmmac: add the support for PTP hw clock driver")
Fixes: 276aae377206 ("net: stmmac: fix system hang caused by eee_ctrl_timer during suspend/resume")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v5:
- Introduce stmmac_init_ptp_clk_freq() routine to configure ptp clock
  frequency.
- Update commit message.
- Update stmmac_init_timestamping kernel-doc.
- Link to v4: https://lore.kernel.org/r/20260913-stmmac-ptp-error-propagate-v4-1-a947aceac928@oss.qualcomm.com

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
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   7 ++
 .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |   3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 114 +++++++++++++++------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |   6 +-
 4 files changed, 95 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7582fca63741..4fc96b317d79 100644
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
@@ -419,6 +421,11 @@ int stmmac_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
 
 struct plat_stmmacenet_data *stmmac_plat_dat_alloc(struct device *dev);
 
+static inline bool stmmac_check_timestamp_cap(struct stmmac_priv *priv)
+{
+	return priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp;
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
index 62c3441911e7..0cc6eafa19a3 100644
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
@@ -866,11 +867,6 @@ static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 {
 	struct timespec64 now;
 
-	if (!priv->plat->clk_ptp_rate) {
-		netdev_err(priv->dev, "Invalid PTP clock rate");
-		return -EINVAL;
-	}
-
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
 	priv->systime_flags = systime_flags;
 
@@ -885,26 +881,37 @@ static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
 	return 0;
 }
 
+static int stmmac_init_ptp_clk_freq(struct stmmac_priv *priv)
+{
+	if (priv->plat->ptp_clk_freq_config)
+		priv->plat->ptp_clk_freq_config(priv);
+
+	if (!priv->plat->clk_ptp_rate) {
+		netdev_info(priv->dev, "PTP clock rate not configured\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /**
  * stmmac_init_timestamping - initialise timestamping
  * @priv: driver private structure
- * Description: this is to verify if the HW supports the PTPv1 or PTPv2.
- * This is done by looking at the HW cap. register.
- * This function also registers the ptp driver.
+ *
+ * Description: initialise the hardware timestamping counter, reset the
+ * timestamping configuration and derive the advanced timestamping flags from
+ * the HW capabilities. The caller must have ensured a valid PTP reference
+ * clock rate (see stmmac_init_ptp_clk_freq()); the configured state is valid
+ * as long as the interface is open and not suspended, and this function is
+ * re-run on resume.
+ *
+ * Return: 0 on success, a negative errno otherwise.
  */
 static int stmmac_init_timestamping(struct stmmac_priv *priv)
 {
 	bool xmac = dwmac_is_xmac(priv->plat->core_type);
 	int ret;
 
-	if (priv->plat->ptp_clk_freq_config)
-		priv->plat->ptp_clk_freq_config(priv);
-
-	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp)) {
-		netdev_info(priv->dev, "PTP not supported by HW\n");
-		return -EOPNOTSUPP;
-	}
-
 	ret = stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
 					       PTP_TCR_TSCFUPDT);
 	if (ret) {
@@ -937,24 +944,48 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
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
+	if (stmmac_init_ptp_clk_freq(priv)) {
+		clk_disable_unprepare(priv->plat->clk_ptp_ref);
+		return 0;
+	}
+
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
@@ -4161,10 +4192,12 @@ static int __stmmac_open(struct net_device *dev,
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
 
@@ -4189,7 +4222,10 @@ static int __stmmac_open(struct net_device *dev,
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
 	stmmac_release_ptp(priv);
-init_error:
+ptp_error:
+	stmmac_stop_all_dma(priv);
+	stmmac_mac_set(priv, priv->ioaddr, false);
+
 	return ret;
 }
 
@@ -7740,8 +7776,7 @@ static int stmmac_register_devlink(struct stmmac_priv *priv)
 	/* For now, what is exposed over devlink is only relevant when
 	 * timestamping is available and we have a valid ptp clock rate
 	 */
-	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp) ||
-	    !priv->plat->clk_ptp_rate)
+	if (!stmmac_check_timestamp_cap(priv) || !priv->plat->clk_ptp_rate)
 		return 0;
 
 	priv->devlink = devlink_alloc(&stmmac_devlink_ops, sizeof(*dl_priv),
@@ -8346,14 +8381,19 @@ int stmmac_resume(struct device *dev)
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
+		if (stmmac_init_ptp_clk_freq(priv))
+			goto init_coalesce;
 
+		ret = stmmac_init_timestamping(priv);
+		if (ret)
+			goto error_stop_dma;
+	}
+
+init_coalesce:
 	stmmac_init_coalesce(priv);
 	phylink_rx_clk_stop_block(priv->phylink);
 	stmmac_set_rx_mode(ndev);
@@ -8376,6 +8416,16 @@ int stmmac_resume(struct device *dev)
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
base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
change-id: 20260904-stmmac-ptp-error-propagate-6c0147b4ce29

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

