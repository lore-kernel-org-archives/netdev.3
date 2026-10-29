Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282164;
	b=ni8gNbb21sTYSFbILKSK5bJjRV4u75PACXBkpCbIeCZCiJZT4x1Bjy1ZEsGW38+kvbDE
	 NWys2MoHzg9KaZ8BYVF19jnD7Fkn7yGs+1bSwW4qNJm78VpHnleU0iIa3BgfygLbRTC9n
	 rXunniXVKZqXm1C6zW+agcxnA+Km51W+q8OMcpqUb86Y3WDCJEXOtd846QOsN4RanwpiE
	 2YFI0tBADR4SybaeB2Nx+UPxnYghPHAQOAcnak5Nw2BsFNmFPlPKkfpS6nrsSdahLJS9q
	 N/kU/oVJQOycWmmhYvn1t4mkEQuxtHr76xE+9ktdq7CkGumo4XMrDVsXVZJ+s79pjxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Vxa8AmcTAnTqlMRaglXqO3kdP+AG+7ou/20D2qdOuTk=;
	b=QAYQrof8dwXr60n2fuxtMvaTYDmDcj4Hq80a5WSCeVbfO9r1dxtEx9GD0ia3wN8RewEX
	 EOVHfT6hZaWeKKW/gviMA0UKJgpmyDY42GeZpa8BKnOrCyz/TfuWha/KmMQlzzOtFE/pD
	 XEa8oLW0C3twYOXjg9tF1qlcAZOje1js3wLD7ZSeUg1SjJj5sOZi9ShxxigeiErfZsDPt
	 +yt0l8HWFZIlRmp73POPts6Bszv74q1gzxe7M15hqsRo+S40sABT8/1DQu5t3FTtrqFuT
	 PerTjJvyAk/zwBQfbX0wHaa2/pauyPSsi2tSnDCBgu7/kToFBtE+hxl7/ewGuEeboUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=jclark.com;
	spf=pass smtp.mailfrom=jclark.com;
	dkim=pass header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EV0OS53g;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AFD606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 13:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7AFD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jclark.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jclark.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jclark-com.20260707.gappssmtp.com header.i=@jclark-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EV0OS53g
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1044915a12.3
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jclark-com.20260707.gappssmtp.com; s=20260707; t=1793282163; x=1793886963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vxa8AmcTAnTqlMRaglXqO3kdP+AG+7ou/20D2qdOuTk=;
        b=EV0OS53gHjs5gB/C5aFrhAt0b113Yuxwc8Wrs+m7XPF/OpFdDa1iAo+uTLj9OeHCk4
         BlKhWfThx65xwNHQAWxjSNlvIp6f1tIb6T+E5/PY5zQ9F+BJaMqm206Gmr5f1K5l6+mE
         kFFEJgt5pnKgupwgpjZlDEdpUKFk8AxAR74Nf+LzXLcDvPaWohlAm3XLWOO27N4XYRE3
         DduLrrHKG6l4zo0E2vQbqtBfQZyZCdiXyOyoaq2W1qj/T42r+K8yT/kBBLQu7JRkafPZ
         FDWu6JV6SL4pTiUKDSQC7yvsgnY/macpYCyehFZ1SGUyLp5RyTIxZSS+8c6G2IOdZo0X
         j8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282163; x=1793886963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vxa8AmcTAnTqlMRaglXqO3kdP+AG+7ou/20D2qdOuTk=;
        b=Z39hZAUUmJVYRVMmBKmxbwOSq5Y2ySKkr73/fsLE8TQMliBUZrmAsZN8yIXY+3u6EN
         Spl7FxaN/TLkBTtxyZnW0yI0Vey1oPbE9XmBJkLG//l/n0S2uxzld+DNkPRhZj9p7tAS
         wRl6yvNEqM+qIR8QN5wfgXdWFY6IKdL69dxEvoF61tEPZ46UPthDuiBPJnmRSfPmV9E4
         l9KIQwXcj4nccCmym9mk8HYZIE/MfHpm6kFvsG44Tl3y5JxnwXdEUQMeKrmrKCZG1M36
         ZjGHhWi6ZYwThOrGt6Jff+Ngy2fhRvDfS3/JruntBHt2C44Fs0cB8ZyegYkbSuGPHbb/
         ilHA==
X-Forwarded-Encrypted: i=1; AKwUvByk1wgSVZZtSHU+CT+BUgL6U7yIPjTNhZiCjo78/hBzEGUsyXA5QP69gbgouDBXyg3no+8KX/w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLB/GOqJ8vG+KYBNQ3ooOOLbLUKz4qQHciyJHuaQg+vv/r8pDZJ
	SZqjmQWhobTzvUblPpTMN+sFic+Qb0mNRw/tTXcWsHx7jep1sfMMzA/he4cFtv4JHA==
X-Gm-Gg: AYBFou3LbDebqzg1KUl1xcfPZUBSLsJQFHbfOp/4BQiARAeaEanxSWelJfn9I9mKvOb
	gJ+vUAnkqeIrej6N1h2sliPuJVFl1xBAApzqMNvr+PrRCLyKSST+Q+mA7yQqYgMpux2Q3jLKgZ+
	6fEMeBfr7V4Hn2NduaIlonvT7jhtispNoMfdQRUsMaPKl1C6/Qa17Q9TwOFeU+EqCiLf/mtLvkY
	MF9PWpZQzbz1yiAEus1AWprvbCS6DSKqlgSbMEyA4RVQsaRHjwvDp3Oh8y2ZPn4/oDNMdniMBqX
	kJVZV89HZdr/pFGCBKouBCn1UDluntFaBkwnbBnbUmtoXPWuWF510czpQ1J0Su7a4p5gRNy82+Z
	p0PaI4wtoaUCiaeVnRKxhbHFfu//wxCcbLGOY6di3hy0qmBU/SEoQFHJXZtK7Q4BP1UAy1uBl7T
	7g9qPa69QodKL7ovyU7GEYi2oGJIpvUgoSWzuyAfdHxoE3zCw2NiAcezVNFndRfX++WtzLOK5va
	4Rd0zAgByF2cYz9H7CDyklW0qmMqNr5GCaS+TWlpAV4XnAS51AJGKbLAFeEK7unHegNYtbg4Eje
	h7c7sNSocJrxZrRpNn6DSmd+ZnBktuAel2p3GddiPY7BtjqQHtPEbYpmHGO/C+LsHZgruEyg4zr
	eju3Mc1jw8m1Pxm5Z
X-Received: by 2002:a17:90b:4b0e:b0:3ac:929e:691 with SMTP id 98e67ed59e1d1-3ae57f9b30cmr4349658a91.17.1793282162808;
        Thu, 29 Oct 2026 06:56:02 -0700 (PDT)
Received: from cantal.lan ([58.136.77.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55d64c0bsm4418845a91.1.2026.10.29.06.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:56:02 -0700 (PDT)
From: James Clark <jjc@jclark.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Aksh Garg <a-garg7@ti.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ethernet: ti: am65-cpts: adjust perout genf following ptp changes
Date: Thu, 29 Oct 2026 20:55:56 +0700
Message-ID: <20261029135556.2508688-1-jjc@jclark.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A periodic output requested by PTP_PEROUT_REQUEST2 drifts away from
the PHC as soon as the PHC frequency is adjusted, for example by ptp4l
or ts2phc: at +10 ppm each edge is 10 us later than the one before.

The GenF that generates the output counts its period in ref_clk
cycles, which the PPM correction of the CPTS clock does not reach;
each GenF has its own PPM registers. am65_cpts_ptp_adjfine() programs
them only for the GenF used for PPS, and am65_cpts_perout_enable_hw()
starts every GenF with them cleared, so a GenF used for a periodic
output is never corrected.

Commit eb9233ce6751 ("net: ethernet: ti: am65-cpts: adjust pps following
ptp changes") added the correction for the PPS GenF, and
commit 7849c42da2ca ("net: ethernet: ti: am65-cpts: adjust estf following
ptp changes") passed the same values to the ESTFs.

In am65_cpts_ptp_adjfine(), update every enabled GenF the way the PPS
GenF was updated: read its control register, set or clear the PPM
direction bit and write it back with the PPM value. The PPS GenF and the
ESTFs get exactly the values they got before. In
am65_cpts_perout_enable_hw(), start a GenF with the current correction
instead of none; this applies to the PPS GenF too.

Tested on a BeagleY-AI (J722S) with the GENF0 output looped back to
the HW1_TS_PUSH input (EXTTS 0). With the PHC frequency adjusted by
+10 ppm before the periodic output is started, the edges drift 10 us
per second against the PHC without this patch (290 us after 29 s);
with it, they stay 20 to 23 ns after the PHC second. This also works
if the frequency is adjusted after the periodic output has started.

Fixes: f6bd59526ca5 ("net: ethernet: ti: introduce am654 common platform time sync driver")
Signed-off-by: James Clark <jjc@jclark.com>
---
Test details: testptp from tools/testing/selftests/ptp. Before is the
stock BeagleBoard 7.2.9 kernel; after is this patch on net/main.

  testptp -d /dev/ptp0 -f 10000
  testptp -d /dev/ptp0 -i 0 -p 1000000000
  testptp -d /dev/ptp0 -i 0 -e 30

Before:
  event index 0 at 32.000000023
  event index 0 at 33.000010023
  event index 0 at 34.000020023
  ...
  event index 0 at 61.000290023

After:
  event index 0 at 33.000000023
  event index 0 at 34.000000021
  event index 0 at 35.000000020
  ...
  event index 0 at 62.000000022

 drivers/net/ethernet/ti/am65-cpts.c | 67 +++++++++++++++++++----------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index df5659ead72f..0d71147f3c29 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -176,6 +176,9 @@ struct am65_cpts {
 	struct mutex ptp_clk_lock; /* PHC access sync */
 	u64 timestamp;
 	u32 genf_enable;
+	bool genf_neg_adj;
+	u32 genf_ppm_hi;
+	u32 genf_ppm_low;
 	u32 hw_ts_enable;
 	u32 estf_enable;
 	struct sk_buff_head txq;
@@ -436,9 +439,11 @@ static int am65_cpts_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	struct am65_cpts *cpts = container_of(ptp, struct am65_cpts, ptp_info);
 	u32 estf_ctrl_val = 0, estf_ppm_hi = 0, estf_ppm_low = 0;
+	u32 genf_ctrl_val[AM65_CPTS_GENF_MAX_NUM];
+	u32 genf_ppm_hi, genf_ppm_low;
 	s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
 	int pps_index = cpts->pps_genf_idx;
-	u64 adj_period, pps_adj_period;
+	u64 adj_period, genf_adj_period;
 	u32 ctrl_val, ppm_hi, ppm_low;
 	unsigned long flags;
 	int neg_adj = 0, i;
@@ -470,20 +475,33 @@ static int am65_cpts_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	ppm_hi = upper_32_bits(adj_period) & 0x3FF;
 	ppm_low = lower_32_bits(adj_period);
 
+	/* GenF PPM will do correction using cpts refclk tick which is
+	 * (cpts->ts_add_val + 1) ns, so GenF length PPM adj period
+	 * need to be corrected.
+	 */
+	genf_adj_period = adj_period * (cpts->ts_add_val + 1);
+	genf_ppm_hi = upper_32_bits(genf_adj_period) & 0x3FF;
+	genf_ppm_low = lower_32_bits(genf_adj_period);
+	cpts->genf_neg_adj = neg_adj;
+	cpts->genf_ppm_hi = genf_ppm_hi;
+	cpts->genf_ppm_low = genf_ppm_low;
+
+	for (i = 0; i < AM65_CPTS_GENF_MAX_NUM; i++) {
+		if (cpts->genf_enable & BIT(i)) {
+			genf_ctrl_val[i] = am65_cpts_read32(cpts,
+							    genf[i].control);
+			if (neg_adj)
+				genf_ctrl_val[i] &= ~BIT(1);
+			else
+				genf_ctrl_val[i] |= BIT(1);
+		}
+	}
+
 	if (cpts->pps_enabled) {
-		estf_ctrl_val = am65_cpts_read32(cpts, genf[pps_index].control);
-		if (neg_adj)
-			estf_ctrl_val &= ~BIT(1);
-		else
-			estf_ctrl_val |= BIT(1);
-
-		/* GenF PPM will do correction using cpts refclk tick which is
-		 * (cpts->ts_add_val + 1) ns, so GenF length PPM adj period
-		 * need to be corrected.
-		 */
-		pps_adj_period = adj_period * (cpts->ts_add_val + 1);
-		estf_ppm_hi = upper_32_bits(pps_adj_period) & 0x3FF;
-		estf_ppm_low = lower_32_bits(pps_adj_period);
+		/* am65_cpts_perout_enable_hw() sets pps_index in genf_enable */
+		estf_ctrl_val = genf_ctrl_val[pps_index];
+		estf_ppm_hi = genf_ppm_hi;
+		estf_ppm_low = genf_ppm_low;
 	}
 
 	spin_lock_irqsave(&cpts->lock, flags);
@@ -500,10 +518,13 @@ static int am65_cpts_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	am65_cpts_write32(cpts, ppm_hi, ts_ppm_hi);
 	am65_cpts_write32(cpts, ppm_low, ts_ppm_low);
 
-	if (cpts->pps_enabled) {
-		am65_cpts_write32(cpts, estf_ctrl_val, genf[pps_index].control);
-		am65_cpts_write32(cpts, estf_ppm_hi, genf[pps_index].ppm_hi);
-		am65_cpts_write32(cpts, estf_ppm_low, genf[pps_index].ppm_low);
+	for (i = 0; i < AM65_CPTS_GENF_MAX_NUM; i++) {
+		if (cpts->genf_enable & BIT(i)) {
+			am65_cpts_write32(cpts, genf_ctrl_val[i],
+					  genf[i].control);
+			am65_cpts_write32(cpts, genf_ppm_hi, genf[i].ppm_hi);
+			am65_cpts_write32(cpts, genf_ppm_low, genf[i].ppm_low);
+		}
 	}
 
 	for (i = 0; i < AM65_CPTS_ESTF_MAX_NUM; i++) {
@@ -513,7 +534,6 @@ static int am65_cpts_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 			am65_cpts_write32(cpts, estf_ppm_low, estf[i].ppm_low);
 		}
 	}
-	/* All GenF/EstF can be updated here the same way */
 	spin_unlock_irqrestore(&cpts->lock, flags);
 
 	mutex_unlock(&cpts->ptp_clk_lock);
@@ -679,9 +699,12 @@ static void am65_cpts_perout_enable_hw(struct am65_cpts *cpts,
 		val = lower_32_bits(cycles);
 		am65_cpts_write32(cpts, val, genf[req->index].length);
 
-		am65_cpts_write32(cpts, 0, genf[req->index].control);
-		am65_cpts_write32(cpts, 0, genf[req->index].ppm_hi);
-		am65_cpts_write32(cpts, 0, genf[req->index].ppm_low);
+		am65_cpts_write32(cpts, cpts->genf_neg_adj ? 0 : BIT(1),
+				  genf[req->index].control);
+		am65_cpts_write32(cpts, cpts->genf_ppm_hi,
+				  genf[req->index].ppm_hi);
+		am65_cpts_write32(cpts, cpts->genf_ppm_low,
+				  genf[req->index].ppm_low);
 
 		cpts->genf_enable |= BIT(req->index);
 	} else {
-- 
2.56.0

