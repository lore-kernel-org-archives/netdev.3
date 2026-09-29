Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE5952759C
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790687435; cv=none; b=oH9jNvTIIlZtk1hHL+oBpS7h6vUyteLPDRkgI1I93Q0xm+9VFzPW+Y1/MFrUoaA1cOssyl/eCML9RmUHBUO2/YJAgtitw0JLFAl4qVyhQj3GNcuy73OlCVWvR3ejffLyPWSbebzVh5qDnVRuALzriuXmw0jClvA7UwZb2AqXuVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790687435; c=relaxed/simple;
	bh=kXx2NTXbZ7/TbX9Jvt1tI0jG/IhwOWPbLRGr+3M3CCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KD6qaYl96NUpKWNWvEAAMJA3gO6+b+i9wHTQADmLjNAn7UITdb76VtXL6vqrPMuVkgIhjxOo92LuQbQPo0lCpiqIeZS8HUcicgaFlyM4cFpWhsaTB2wP38NVrIjwnRxT6ncYIfkO0RTxGjZ36e/B95nRRIiLCU9uJhRPpjZq0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bjWvjIpt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VDv2abnK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bjWvjIpt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VDv2abnK"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TCqijk350142
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uR5lZ/aLpg7JPf2Y9UuxbB
	RL+jfu0XggxF3MrEIcb/s=; b=bjWvjIptWBAZ3qpYVa7Y9LbPgzauS7hhuuZvbc
	Oi9HpsqU2Deu5XML//HnyYkZ/gQYoN6o/LSHB/ANMj+KOrAUubiGRRJ8ce2B3nUK
	XfiTnwIQe570orxV+b1LgMb2y9aJGyh6PyYQs58upHuoOMj3f8mzK7nD/sgxbZDi
	7XfRNSQaRnhFI97sHLqP+9PNoqk/W9KU+eR1uB/4rpYcwYgGfv1B4sC9nUOSlcJD
	TU8gmCxN6s93ofZvCrUXjoCIpdeZ+dpO/coQlvSxJcBtK5hiZdCoEw5a8lPDgzkA
	JD097sDgON5hAXEOVZBHMypd+XVOczVdodRTUfrWyNaSdRkw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkjxqf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 13:10:31 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-9829a8b46a7so300779241.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 06:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790687431; x=1791292231; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uR5lZ/aLpg7JPf2Y9UuxbBRL+jfu0XggxF3MrEIcb/s=;
        b=VDv2abnKkqPeFUf/MZ6cebAbcZJfo6W4qi9Yf4NzjjXew9eVeR9ZXtRz2uVG+Wf112
         Fn8QQ4hZowR1Uiglo3y52wZB7ZmFt33Rb1an3Z9KnfB8WdvF7OIQQG/jnyX+TbOJo1qs
         jSyIBNTACpZ4lUTIXj0ar7S9wevxB8LaFMSFLo70RJyOg6rcjPr7lCLwDX8nqfpvpMTB
         cQ7tX01x0GG2DSs1e6wjwbll4z1QyVoZEp3EW3IF+9srPfspudjamvsE6Zby2RuJ/GZJ
         SsvAXWCKlLB7xtLsf/krGgMQDpe24yrJrqEal/rCVowAsCGfN+BZwYPgFJvxD65oJ7Fi
         xngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790687431; x=1791292231;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uR5lZ/aLpg7JPf2Y9UuxbBRL+jfu0XggxF3MrEIcb/s=;
        b=zgrRriuK1hPJ0NhyFwG4PLuFunE/WS8EkaZiEOI3N0NVL7AVWL52IOr7fuE4lSLMnA
         9PZDPECR2qsNU6SFxdJ1G38Mfu52cADrR5tA8FVEcZIbnUYDyPKw/cEd6e5sOhznDCdP
         RP8RQ6V88TivQfdDGkg/xCfNcU3SC/vzEXABdha4xm2oJylMl8WbkqDSAGTIJkgUzee4
         v9KzlNoUEXYLJZSdXNxkrtPU8r8nVboHlSpttcan1Ww1msnEpdZlYZbm9a8vCDuaJYkt
         N70CpSWw0jZrLUtd3UwKfRR/4wDp48aFEsU1tK0NJuh3+O97zMBkJVJnlypnsdHc5aZD
         txjg==
X-Gm-Message-State: AFq9FYIstaKemmo2/Hv3fHEwyg7mgFY6/rNCN2QpIzwqsRzxig9owMyj
	GrFaBeNRTUcI9a6a+o6R8SRjrLsN++ZDtLpf1B6geVT3tCjEmR4D2btU4/oCVEfuUQa3Q+YWXpb
	fcz9qZnw2jjmsmbvK7EYItwAdgoixY8z9owV5FqzlySAWypy2ohpiJQMPQ9o=
X-Gm-Gg: AYBFou0kS1H6w2B+DPzpVeaaiMxxSINapqb5LYs0oCMaczB4khEe0xedEbJl3Jcesow
	3X3MAkmaehJY6n2aEjkumHbpXVyDyjJ/AublSg/60CaLgtMxQ/8ScsuSgB+ow9ZtPgBT1TjmQSP
	vbqHEQBicED+z6ifmMSsEvPG9Dd7StP4br0YgyOzmzP9GjOA+0SM+vY1vdbdNElAFWQSJxjFCNH
	KHs+m5NYuKEp0wPezlCPeGlqH83coO2wYcK91Z6yuTLlnFLMO81yZf8kbDoAyjFiKP0drrrGR9Q
	/AOVJtMdtXhrcS+ojY/CMcnmddG3ZFsSMXUvXCpFdwQ9719mCA4feA4avkKkyd3+jwnbpOFcjvj
	GEHQTZIOGBPfgIQ==
X-Received: by 2002:a05:6102:390a:b0:7ba:9a91:c50a with SMTP id ada2fe7eead31-7ba9a91c98emr102349137.30.1790687430745;
        Tue, 29 Sep 2026 06:10:30 -0700 (PDT)
X-Received: by 2002:a05:6102:390a:b0:7ba:9a91:c50a with SMTP id ada2fe7eead31-7ba9a91c98emr102321137.30.1790687429921;
        Tue, 29 Sep 2026 06:10:29 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af506fdc1sm3931416f8f.21.2026.09.29.06.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 06:10:28 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 15:10:11 +0200
Subject: [PATCH net v3] net: stmmac: propagate PTP addend and system time
 programming errors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-stmmac-ptp-added-systime-error-v3-1-ddd6afe936b4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQ6CMBAF0KuYrh0Cg1Rw5T2Mi1Km0sRS7FQiI
 dzdhpULE91M8ucn7y+CKVhicdotItBk2fohhXK/E7pXw43AdikLzFHmDebA0TmlYYwjqK6jDnj
 maB0BheADtLqppESJBo1IyBjI2Nc2cBEDRXFNz95y9GHeRqdiq/71pwIKqJVu6KhKownPnjl7P
 NVde+eydLaFCT/Vw08Vk9pSi0q2laml/KKu6/oGNKMYxS4BAAA=
X-Change-ID: 20260920-stmmac-ptp-added-systime-error-bc9566262f2f
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MiBTYWx0ZWRfX68nscSLIdmTi
 3lAPsV08qBjMErxYHdzMJBw2LiLKF6BDfkq4c+YnWoZ/B/9yYDN6jfxIQhDpuSyOASjpH+9Kq3D
 cdyHujVuahcaAGLfDM8elfZMX00XDOov8KQjV4oadwgp3LEuho7QIBW+VtzwNQJsScH5wk3iKlj
 ROImoe1uZhUbax3B1oXZ+O9hZq1b27zjFzPzWCZNDbnugm4z1+LWNHRn1G17fbyr1Z6sAkn/evY
 x2pbVuEP4rGP+NvZFQbD/MbAWBTlKZuX7VY5KZJL+2cFb8KKesUC0PH9JJF7gzVKT0lTmJ1Kzaa
 JnmwoOeiP/sk4VLhntEgvrC4bqS4RZpJAaxchEZU9g6wZ+vC7hX9xtvSvkbSaH2w70SvwOgJSsA
 NySG4yd7N9soDGuemDCMdWWlpjWgY1aJv8Bw+qIg+j73fEbvC0ErOee3YM8gVydh5IPdqvX+zYy
 6nW0KVdIp7cqT+MO3tg==
X-Proofpoint-GUID: DLbZ8Gco-9kSadrl5cobrHfnLfGNyp0s
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abbb8c7 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uyVPXY6SzKWq727VUmwA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: DLbZ8Gco-9kSadrl5cobrHfnLfGNyp0s
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MiBTYWx0ZWRfX9pDX7pjK9aNU
 gQIwySm0ji86HCAOoW6DA7KOTZuvU0jQN/RFstcn5BsBAomzSTZVKCBFzGbCE6R5L1AahtQMgsV
 GENy5y5u0YGUo4e+25k++0ONbF1QQOI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290052

stmmac_update_subsecond_increment() ignores the error returned by
stmmac_config_addend(), and stmmac_init_tstamp_counter() discards the
addend and system time programming errors, always returning success. A
failure to program the addend (PTP_TCR_TSADDREG) or to initialize the
system time counter (PTP_TCR_TSINIT) is therefore silently swallowed,
leaving the hardware timestamp counter in a non-running or partially
configured state while the driver keeps operating as if timestamping
were up. This matters for TAPRIO/EST offloading, which derives the gate
base time from the hardware timestamp counter.

The same hooks are also called from the PHC callbacks: settime64 and
adjfine drop the error and report success to clock_settime() and
clock_adjtime(), so a dead PTP reference clock goes unnoticed by
ptp4l/phc2sys.

Return error codes from stmmac_update_subsecond_increment(),
stmmac_init_tstamp_counter(), stmmac_dl_ts_coarse_set() and the
settime64/adjfine callbacks instead of silently returning success. On
failure, roll back the partially applied configuration so the hardware
and the driver bookkeeping stay consistent, and report the reason
through the devlink extack. Also guard against a zero sub-second
increment, which would otherwise divide by zero when computing the
addend.

Reset the persistent timestamping state (hwts_tx_en, hwts_rx_en,
tstamp_config, systime_flags and tsfupdt_coarse) when (re)initializing
timestamping, so a failed init does not leave TX/RX timestamping
enabled on a counter that never started.

Fixes: cc4c9001ce31 ("net: stmmac: Switch stmmac_hwtimestamp to generic HW Interface Helpers")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v3:
- Do not run stmmac_config_addend() in
  stmmac_update_subsecond_increment() error path.
- Return error from stmmac_adjust_freq() and stmmac_set_time().
- Reset hw ts configuration in stmmac_init_timestamping().
- Link to v2: https://lore.kernel.org/r/20260924-stmmac-ptp-added-systime-error-v2-1-beb2a6b5f866@oss.qualcomm.com

Changes in v2:
- Initialize sec_inc to 0 in stmmac_restore_subsecond_increment()
  routine.
- Link to v1: https://lore.kernel.org/r/20260920-stmmac-ptp-added-systime-error-v1-1-8ac9e7a3fce2@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 106 ++++++++++++++++------
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  |  10 +-
 2 files changed, 84 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ec62fa7418f4..9741f97fa37a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -601,31 +601,64 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 	}
 }
 
-static void stmmac_update_subsecond_increment(struct stmmac_priv *priv)
+static void stmmac_restore_subsecond_increment(struct stmmac_priv *priv,
+					       u32 default_addend)
 {
 	bool xmac = dwmac_is_xmac(priv->plat->core_type);
 	u32 sec_inc = 0;
-	u64 temp = 0;
 
+	stmmac_config_addend(priv, priv->ptpaddr, default_addend);
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
+	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
+					   priv->plat->clk_ptp_rate,
+					   xmac, &sec_inc);
+	priv->default_addend = default_addend;
+	priv->sub_second_inc = sec_inc;
+}
+
+static int stmmac_update_subsecond_increment(struct stmmac_priv *priv,
+					     u32 systime_flags)
+{
+	bool xmac = dwmac_is_xmac(priv->plat->core_type);
+	u32 sec_inc = 0, val;
+	u64 temp = 0;
+	int ret;
+
+	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
 
 	/* program Sub Second Increment reg */
 	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
 					   priv->plat->clk_ptp_rate,
 					   xmac, &sec_inc);
-	temp = div_u64(1000000000ULL, sec_inc);
-
-	/* Store sub second increment for later use */
-	priv->sub_second_inc = sec_inc;
+	if (!sec_inc) {
+		ret = -EINVAL;
+		goto error;
+	}
 
 	/* calculate default added value:
 	 * formula is :
 	 * addend = (2^32)/freq_div_ratio;
 	 * where, freq_div_ratio = 1e9ns/sec_inc
 	 */
+	temp = div_u64(1000000000ULL, sec_inc);
 	temp = (u64)(temp << 32);
-	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
-	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
+	val = div_u64(temp, priv->plat->clk_ptp_rate);
+
+	ret = stmmac_config_addend(priv, priv->ptpaddr, val);
+	if (ret)
+		goto error;
+
+	priv->sub_second_inc = sec_inc;
+	priv->default_addend = val;
+
+	return 0;
+error:
+	/* Restore previous configuration */
+	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
+	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
+					   priv->plat->clk_ptp_rate, xmac,
+					   NULL);
+	return ret;
 }
 
 /**
@@ -854,35 +887,42 @@ static int stmmac_hwtstamp_get(struct net_device *dev,
 /**
  * stmmac_init_tstamp_counter - init hardware timestamping counter
  * @priv: driver private structure
- * @systime_flags: timestamping flags
  * Description:
  * Initialize hardware counter for packet timestamping.
  * This is valid as long as the interface is open and not suspended.
  * Will be rerun after resuming from suspend, case in which the timestamping
  * flags updated by stmmac_hwtstamp_set() also need to be restored.
  */
-static int stmmac_init_tstamp_counter(struct stmmac_priv *priv,
-				      u32 systime_flags)
+static int stmmac_init_tstamp_counter(struct stmmac_priv *priv)
 {
+	u32 default_addend = priv->default_addend;
 	struct timespec64 now;
+	int ret;
 
 	if (!priv->plat->clk_ptp_rate) {
 		netdev_err(priv->dev, "Invalid PTP clock rate");
 		return -EINVAL;
 	}
 
-	stmmac_config_hw_tstamping(priv, priv->ptpaddr, systime_flags);
-	priv->systime_flags = systime_flags;
-
-	stmmac_update_subsecond_increment(priv);
+	ret = stmmac_update_subsecond_increment(priv, priv->systime_flags);
+	if (ret)
+		return ret;
 
 	/* initialize system time */
 	ktime_get_real_ts64(&now);
 
 	/* lower 32 bits of tv_sec are safe until y2106 */
-	stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec, now.tv_nsec);
+	ret = stmmac_init_systime(priv, priv->ptpaddr, (u32)now.tv_sec,
+				  now.tv_nsec);
+	if (ret)
+		goto error;
 
 	return 0;
+error:
+	/* Restore previous configuration */
+	stmmac_restore_subsecond_increment(priv, default_addend);
+
+	return ret;
 }
 
 /**
@@ -905,8 +945,14 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
 		return -EOPNOTSUPP;
 	}
 
-	ret = stmmac_init_tstamp_counter(priv, STMMAC_HWTS_ACTIVE |
-					       PTP_TCR_TSCFUPDT);
+	/* Reset hw ts configuration */
+	memset(&priv->tstamp_config, 0, sizeof(priv->tstamp_config));
+	priv->systime_flags = STMMAC_HWTS_ACTIVE | PTP_TCR_TSCFUPDT;
+	priv->tsfupdt_coarse = false;
+	priv->hwts_tx_en = 0;
+	priv->hwts_rx_en = 0;
+
+	ret = stmmac_init_tstamp_counter(priv);
 	if (ret) {
 		netdev_warn(priv->dev, "PTP init failed\n");
 		return ret;
@@ -927,10 +973,6 @@ static int stmmac_init_timestamping(struct stmmac_priv *priv)
 		netdev_info(priv->dev,
 			    "IEEE 1588-2008 Advanced Timestamp supported\n");
 
-	memset(&priv->tstamp_config, 0, sizeof(priv->tstamp_config));
-	priv->hwts_tx_en = 0;
-	priv->hwts_rx_en = 0;
-
 	if (priv->plat->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
 		stmmac_hwtstamp_correct_latency(priv, priv);
 
@@ -7711,18 +7753,26 @@ static int stmmac_dl_ts_coarse_set(struct devlink *dl, u32 id,
 {
 	struct stmmac_devlink_priv *dl_priv = devlink_priv(dl);
 	struct stmmac_priv *priv = dl_priv->stmmac_priv;
+	u32 systime_flags = priv->systime_flags;
+	int ret;
 
-	priv->tsfupdt_coarse = ctx->val.vbool;
-
-	if (priv->tsfupdt_coarse)
-		priv->systime_flags &= ~PTP_TCR_TSCFUPDT;
+	if (ctx->val.vbool)
+		systime_flags &= ~PTP_TCR_TSCFUPDT;
 	else
-		priv->systime_flags |= PTP_TCR_TSCFUPDT;
+		systime_flags |= PTP_TCR_TSCFUPDT;
 
 	/* In Coarse mode, we can use a smaller subsecond increment, let's
 	 * reconfigure the systime, subsecond increment and addend.
 	 */
-	stmmac_update_subsecond_increment(priv);
+	ret = stmmac_update_subsecond_increment(priv, systime_flags);
+	if (ret) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "failed to reconfigure PTP adjustment");
+		return ret;
+	}
+
+	priv->tsfupdt_coarse = ctx->val.vbool;
+	priv->systime_flags = systime_flags;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3bfcc9760dce..493c5d81a36b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -28,14 +28,15 @@ static int stmmac_adjust_freq(struct ptp_clock_info *ptp, long scaled_ppm)
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
 	unsigned long flags;
 	u32 addend;
+	int ret;
 
 	addend = adjust_by_scaled_ppm(priv->default_addend, scaled_ppm);
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
-	stmmac_config_addend(priv, priv->ptpaddr, addend);
+	ret = stmmac_config_addend(priv, priv->ptpaddr, addend);
 	write_unlock_irqrestore(&priv->ptp_lock, flags);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -153,12 +154,13 @@ static int stmmac_set_time(struct ptp_clock_info *ptp,
 	struct stmmac_priv *priv =
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
 	unsigned long flags;
+	int ret;
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
-	stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
+	ret = stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
 	write_unlock_irqrestore(&priv->ptp_lock, flags);
 
-	return 0;
+	return ret;
 }
 
 static int stmmac_enable(struct ptp_clock_info *ptp,

---
base-commit: 37e02c42a00be692c06343e11779aadc45f45971
change-id: 20260920-stmmac-ptp-added-systime-error-bc9566262f2f

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

