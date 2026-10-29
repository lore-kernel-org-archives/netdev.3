Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270070;
	b=EeNpODdgsXd9DjVCV0DpDpm+R1iTu+CD7IOsqJkDLQNq7LT0+qX4Xa3PsXeroCueKstY
	 WuQeIlIW4Sxp5Nh5wvt6IsoWySa3pAeioJNAaui2GzhqEM8/h+wQIrNiIblCUDDMfeAE2
	 HA6F/RdclK+Fv0h0OauKwY+1wshEDyMnLzpoy/yjLACW70MscvQ4KE/s8ynZDUOsc+0sj
	 Bh3UF3AqeVg8oJvxAdJf51w2Dcgn1FB7FqzC5I7rXUupFgJhPN+MX77kKDHjcxEgNBqK1
	 fkFoqoz8eOkWxDAVSnzWrMdXsA8OA8kXMJnVH4kNnaqdcrEoGJw5KCN4T7re/HbWyTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270070;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tllG4ebgjCEqHUrmWCTRE3lwjXE2wGxH2RyAazL8TUg=;
	b=ze0PrThodUwbN2dDPpWRpa90ZufxWKp3vRtGYaIO7FEDMj/JfGmjXPlZL9UiLdApexJ5
	 4wD1EDaXwFego0oPCalUcmk9iqFh10RIm3oIKfBJyNBBHnQtIwIf+JrU8rLof4lEHCg9K
	 B3KLfkC6WqvSdoTs0KbE2h277sydFyDsmSS5sP3yCpTjOZel+O8j3YWPQw2dt1N0O7lS7
	 nXGoCVaSd7b+AXwrYq8QCA8KoeM5MHo1rCU+SH6W0VBmtGYx5Js7BqoVMURYVIx84IJB5
	 IXj6eCS4FJ30MVMOYyDOJCnPVGU5FYJfXbyDwwQJ/bcLCzx8nsxwwU1W/EAzvmX1FWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YTQhhSjY;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PfdaPQ2F;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7707F606A31E
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7707F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YTQhhSjY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PfdaPQ2F
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vFvD3765967
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tllG4ebgjCEqHUrmWCTRE3lwjXE2wGxH2RyAazL8TUg=; b=YTQhhSjYgYYSoAkQ
	cNL9yZs+GTyGDgIj/iQ2UDNdUhPHCaYSO6JlEaWNHo7brenAKRM1sCXNdU2lO62A
	mo3MU0IKa0UbSt2rXzFU46V/bbG2cBAgl4F5+KIegAlFopqkorERwQgJadpntZpQ
	/Tpeqz9SBihOwQeEA15elNH+67cWIGK1mnx2ibH2arX6Uh3AQ5Jb6eCHshyyyacV
	1Azolaq1jJDs79Q9zX2Q6CsIqepXIA+yO6FeDCWeILg+53RlQ250nzh+jt8ViXhC
	a2aaJ4aT1UVoL5gXF98EbGI1o7ETCrSUvRlRprrmteE+1dw3IKwxyhHyLVLn+vLo
	AJiOsA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgpu5pf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 10:34:28 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7cc10da5ad4so446434137.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793270067; x=1793874867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tllG4ebgjCEqHUrmWCTRE3lwjXE2wGxH2RyAazL8TUg=;
        b=PfdaPQ2FHyr4PTQJ71QlIYkPj/kPVGLzRRBuSPR25RJKjfcLsT/57DopmFv+fb1xZt
         Kn+iVyap9Z3AeBbttpuObvPZYbaOszNkcP1KyZlW+EHEtXBw6BikK+08VL1ZGxdOmrC/
         0FGRf2TOEFBkkd529QXSeWQtEFjWCPJJsl3WbvxwU2+s2pfsfXd2XGq5KVj1iiuiupdO
         uq6U9yIUX2pfBQ91nzxJogfEBEVONubOtwjgfgD6f2DNzlmxTomxsVoOTckl9bfBf0iG
         /tn5a7UfXX1BJUkqx+sDIvSr1V/0BkJ3kF4nmAP5KKosH3YHWYVHcoU3fbXos9epN+gS
         LQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270067; x=1793874867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tllG4ebgjCEqHUrmWCTRE3lwjXE2wGxH2RyAazL8TUg=;
        b=zUJokPqVBN7ATl8fIZGXAqvyd3C0/mttiW2HUNssM/iOCiSdbJ3GnbrRXWB+/snZAn
         qIR3Np6CgI0v60OGGlu4uHrv72jLu7uNtqdAnJZ7MkxNG2cNMs9/sLK0V1WYQtiSTSVq
         oMNx7LxVRu06yuutgdVRnVDOzKdySIy0xL42YjI4pBrwi9QC44WCKUpbuSvu0dXuWg/S
         5T+5UyBKH3tZQwXhGhN6tGheJmkUAjgVzNlB03MRCd6PKkcjL8OXhDkuoMHcyVRJbIF1
         GmGCXBK1KzUgBxx2Jc+65FeNaOqh/YpuxHTIjTo3DuFM4+fKvSvMNuz7ySxZH5OQT8Bc
         hSXA==
X-Gm-Message-State: AFq9FYLJ+So4pzsLD6gVCf9+/I7M42vkCeQpKUfpTF5E2OKURfjp5Tmh
	Qaf2Dl9mvokhMDTMZfdSsZjyF6xLH/+gUkpMkldU9QfryHbNtydh34BPqYaejX4rin7v8cUiZqc
	wInF1wCVthVSg7kc4gU4hpEB3o9uOQc7SgxqWnPahDQx226IcMkJM/WwKakA=
X-Gm-Gg: AYBFou0++BMwjGEJUqH7U2z1PDESnHKXqksPZMfLNg7E2gXtpwwzkWsgckcVqHekVqE
	svIp8csYzjIA8SlTiWktOMLvUDnbx9SOsOawMo+9t9jWLAUr0kywjck+gKW60w00WUEEob2xfQc
	0mXbBaGhYLOhN20ym7QK1xNwekJd3U9tLQGz4zhVsdDx4F2pQNlOpAqrXxpNjDmmY91xszAJb4t
	NaT0SWpQoxFNcgbIGKvauuCztbNpOi9HWxmkOZWbJtJFcGN9Qc8ijpWrNKXkHC2dMjPmu+zhn2V
	uA9ouG3cZ1RbkGCOwkfUPlh8CmCg/YMn5//B8PPdmb058h7TRGD857V3kF/VVbJwwBsgw2bZscT
	0W1S1c+G5fW8Mbp9IAtnodr3QeQNI7t++B4P3A9R/UdORonmCU3YOPPJR4zlG6PI3caZZyzlvJF
	arRICkQP1EACT8vj1hw7Bj2w==
X-Received: by 2002:a05:6102:f9b:b0:7cc:2cd0:e73c with SMTP id ada2fe7eead31-7d03a5b3b8fmr2177511137.25.1793270067028;
        Thu, 29 Oct 2026 03:34:27 -0700 (PDT)
X-Received: by 2002:a05:6102:f9b:b0:7cc:2cd0:e73c with SMTP id ada2fe7eead31-7d03a5b3b8fmr2177495137.25.1793270065971;
        Thu, 29 Oct 2026 03:34:25 -0700 (PDT)
Received: from localhost (net-93-144-6-81.cust.dsl.teletu.it. [93.144.6.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e412cc164sm31805426f8f.7.2026.10.29.03.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:34:22 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 11:33:57 +0100
Subject: [PATCH net v5 3/3] net: stmmac: re-apply taprio offload in
 __stmmac_open() and stmmac_resume()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-stmmac-est-fixes-v5-3-85b830a795a9@oss.qualcomm.com>
References: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
In-Reply-To: <20261029-stmmac-est-fixes-v5-0-85b830a795a9@oss.qualcomm.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
        Rayagond Kokatanur <rayagond@vayavyalabs.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX0spIwD1i43vD
 djsaTCp8O4843/KWycoP6226w8UgDMzLIv6Clz/FfnChh40eZsLAWQfvgJEJAUx3ms9n6qABL/7
 Arwb8+TDyPtjpJz0nDdH0dJFIG4TDIJeIUqsrOxbFXYsPXj4lCtLhfxkJCzip5RWzWEtqQwsizK
 WGScbNDFcyv0tNAmeprCx3ekyrJ7WCs/xGIIBHLa8UVpcESJYyHE+RhsMfKDbWR81g/aT9MVmal
 Uwg+JS8g/1/KTeT3A3lTEtivWLQfYBMgAvC0ir0jEBM6rnMBmUmz0qQe9ENHDuv0tgYdF2fxgLm
 WoPUhg4sv77vQMkXT58qkbZ3xN7bVklz6OBklS6ag9p6Xou1VY3uqOs7LLV4LEH0C3XoG4zbVee
 +AqmJ0zjX7+Zk+FV482fyv+X7KkRGh0E+2AcxHN8N9/gRtZd3eUqfh4hhN5zIYs73p/2Th3RYUB
 O9dKBMmzMX3xH+Mkodg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX64MOrflLa1L0
 yLMlBHlTps3+gAQPVvxedhRZrp5NElJPfcnlK9GQsHWa5k9pwpYOuy2uiqzKfFhO1gjrAZmeYmp
 xrYzUlW46IO3x8IK3kmYd6Xyh2Wd6rg=
X-Proofpoint-ORIG-GUID: Ia8YD-uiYTOKvY-AX0-IGxbgGlbkdmOr
X-Proofpoint-GUID: Ia8YD-uiYTOKvY-AX0-IGxbgGlbkdmOr
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae32134 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=7fYLNvKHbgS61GKHX+yayQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=JpBpa1p7AAAA:8 a=lwEgaQNyhJe4a321_6MA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=YCh05so4W2E6r1tszMC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290040

The core soft reset issued by stmmac_init_dma_engine(), called from
stmmac_hw_setup(), clears the MTL_EST registers. Nothing re-applies the
taprio offload afterwards, so priv->est->enable stays true while the
hardware EST block is left disabled: taprio keeps being reported as
offloaded, the TX/XDP paths keep dropping frames larger than
priv->est->max_sdu[], and the programmed base time is stale.

Re-apply the offload from __stmmac_open() and stmmac_resume() after PTP
has been brought up. The base time is recomputed from the reserved base
time and the current PTP time, because the timestamp counter has been
re-initialised and the previously programmed base time cannot be reused.

Factor the recompute-and-program sequence into __stmmac_setup_est(),
which must be called with est_lock held, and into stmmac_setup_est(),
which takes the lock and re-applies the offload only when it is
currently enabled and PTP has been brought up. Use the same helper in
stmmac_adjust_time() so the PTP adjust path shares the base time
computation.

Only tc_taprio_configure() updates priv->est->enable: it is set when a
REPLACE succeeds and cleared on DESTROY or a programming failure. The
re-apply helpers leave it untouched, so the flag records that an offload
is installed rather than the current hardware programming state.
__stmmac_setup_est() only reprograms the EST block, and
stmmac_setup_est() replays the FPE mapping afterwards. On a failed
re-apply the open and resume callers abort, while stmmac_adjust_time()
keeps the offload configured.

The same reset also discards the FPE preemption programming, and on XGMAC
stmmac_dma_tx_mode() overwrites the queue-to-traffic-class map. Save the
preemptible traffic class mask in priv->est->pclass when a REPLACE
succeeds and replay the FPE mapping from stmmac_setup_est() as well.

Re-applying the offload is best-effort with respect to PTP:
stmmac_setup_est() does nothing when PTP was not enabled (for example
when clk_ptp_rate is 0), so a missing PTP reference clock does not by
itself fail ndo_open(). If re-applying the EST or FPE programming fails
while restoring the interface, the failure is fatal to the caller:
__stmmac_open() aborts the open, and stmmac_resume() takes the same error
path already used for a failed timestamp counter restore.

Since __stmmac_open() and stmmac_resume() now trust priv->est->enable,
also make tc_taprio_configure() consistent: hold est_lock across the
whole validate-and-program sequence, build the gate list in a temporary
buffer, and only commit it and enable EST after validation and hardware
programming succeed. A REPLACE rejected during validation then leaves the
currently installed schedule intact in both software and hardware, while
a hardware or FPE mapping failure disables EST instead of leaving a stale
enable flag behind. Reject cycle times whose seconds field would not fit
in priv->est->ctr[1].

Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.c  | 55 ++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_est.h  |  8 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 44 +++---------
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 88 ++++++++++++++---------
 6 files changed, 139 insertions(+), 68 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 93292014c393..b76acfe0d958 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -239,6 +239,7 @@ struct stmmac_est {
 	u32 gcl[EST_GCL];
 	u32 gcl_size;
 	u32 max_sdu[MTL_MAX_TX_QUEUES];
+	u32 pclass;
 };
 
 struct stmmac_msi {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
index f15d4d046aa7..59e9a54e864d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.c
@@ -80,6 +80,61 @@ static int est_configure(struct stmmac_priv *priv, struct stmmac_est *cfg,
 	return 0;
 }
 
+int __stmmac_setup_est(struct stmmac_priv *priv)
+{
+	struct timespec64 current_time, time;
+	ktime_t current_time_ns, basetime;
+	u64 cycle_time;
+	int err;
+
+	lockdep_assert_held(&priv->est_lock);
+
+	priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops, &current_time,
+				       NULL);
+	current_time_ns = timespec64_to_ktime(current_time);
+
+	time.tv_nsec = priv->est->btr_reserve[0];
+	time.tv_sec = priv->est->btr_reserve[1];
+	basetime = timespec64_to_ktime(time);
+
+	cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC + priv->est->ctr[0];
+
+	time = stmmac_calc_tas_basetime(basetime, current_time_ns, cycle_time);
+	priv->est->btr[0] = (u32)time.tv_nsec;
+	priv->est->btr[1] = (u32)time.tv_sec;
+
+	err = stmmac_est_configure(priv, priv, priv->est,
+				   priv->plat->clk_ptp_rate, true);
+	if (err) {
+		netdev_err(priv->dev, "failed to re-configure EST\n");
+		return err;
+	}
+
+	return 0;
+}
+
+int stmmac_setup_est(struct stmmac_priv *priv)
+{
+	int ret = 0;
+
+	if (!priv->ptp_enabled)
+		return 0;
+
+	mutex_lock(&priv->est_lock);
+	if (priv->est && priv->est->enable) {
+		ret = __stmmac_setup_est(priv);
+		if (ret)
+			goto unlock;
+
+		ret = stmmac_fpe_map_preemption_class(priv, priv->dev, NULL,
+						      priv->est->pclass);
+	}
+unlock:
+	mutex_unlock(&priv->est_lock);
+
+	return ret;
+}
+
 static void est_irq_status(struct stmmac_priv *priv, struct net_device *dev,
 			   struct stmmac_extra_stats *x, u32 txqcnt)
 {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
index f70221c9c84a..5e07b84957f3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_est.h
@@ -4,6 +4,9 @@
  * stmmac EST(802.3 Qbv) handling
  */
 
+#ifndef __STMMAC_EST_H__
+#define __STMMAC_EST_H__
+
 #define EST_GMAC4_OFFSET		0x00000c50
 #define EST_XGMAC_OFFSET		0x00001050
 
@@ -65,3 +68,8 @@
 #define EST_GCL_DATA			0x00000034
 
 extern const struct stmmac_est_ops dwmac510_est_ops;
+
+int __stmmac_setup_est(struct stmmac_priv *priv);
+int stmmac_setup_est(struct stmmac_priv *priv);
+
+#endif /* __STMMAC_EST_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2163e79fea9a..d1e3d2cc7767 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -48,6 +48,7 @@
 #include "stmmac_ptp.h"
 #include "stmmac_fpe.h"
 #include "stmmac.h"
+#include "stmmac_est.h"
 #include "stmmac_pcs.h"
 #include "stmmac_xdp.h"
 #include <linux/reset.h>
@@ -4201,6 +4202,10 @@ static int __stmmac_open(struct net_device *dev,
 	if (ret)
 		goto ptp_error;
 
+	ret = stmmac_setup_est(priv);
+	if (ret)
+		goto est_error;
+
 	stmmac_init_coalesce(priv);
 
 	phylink_start(priv->phylink);
@@ -4224,7 +4229,7 @@ static int __stmmac_open(struct net_device *dev,
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
-
+est_error:
 	stmmac_release_ptp(priv);
 ptp_error:
 	stmmac_stop_all_dma(priv);
@@ -8527,6 +8532,10 @@ int stmmac_resume(struct device *dev)
 		ret = stmmac_init_timestamping(priv);
 		if (ret)
 			goto error_stop_dma;
+
+		ret = stmmac_setup_est(priv);
+		if (ret)
+			goto error_stop_dma;
 	}
 
 init_coalesce:
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 9a32af00d7d2..a37405534beb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -8,6 +8,7 @@
   Author: Rayagond Kokatanur <rayagond@vayavyalabs.com>
 *******************************************************************************/
 #include "stmmac.h"
+#include "stmmac_est.h"
 #include "stmmac_ptp.h"
 
 #define PTP_SAFE_TIME_OFFSET_NS	500000
@@ -54,8 +55,7 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	u32 sec, nsec;
 	u32 quotient, reminder;
 	int neg_adj = 0;
-	bool xmac, est_rst = false;
-	int ret;
+	bool xmac;
 
 	xmac = dwmac_is_xmac(priv->plat->core_type);
 
@@ -69,47 +69,21 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	nsec = reminder;
 
 	/* If EST is enabled, disabled it before adjust ptp time. */
-	if (priv->est && priv->est->enable) {
-		est_rst = true;
-		mutex_lock(&priv->est_lock);
-		priv->est->enable = false;
+	mutex_lock(&priv->est_lock);
+	if (priv->est && priv->est->enable)
 		stmmac_est_configure(priv, priv, priv->est,
 				     priv->plat->clk_ptp_rate, false);
-		mutex_unlock(&priv->est_lock);
-	}
+	mutex_unlock(&priv->est_lock);
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
 	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
 	write_unlock_irqrestore(&priv->ptp_lock, flags);
 
 	/* Calculate new basetime and re-configured EST after PTP time adjust. */
-	if (est_rst) {
-		struct timespec64 current_time, time;
-		ktime_t current_time_ns, basetime;
-		u64 cycle_time;
-
-		mutex_lock(&priv->est_lock);
-		priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops,
-					       &current_time, NULL);
-		current_time_ns = timespec64_to_ktime(current_time);
-		time.tv_nsec = priv->est->btr_reserve[0];
-		time.tv_sec = priv->est->btr_reserve[1];
-		basetime = timespec64_to_ktime(time);
-		cycle_time = (u64)priv->est->ctr[1] * NSEC_PER_SEC +
-			     priv->est->ctr[0];
-		time = stmmac_calc_tas_basetime(basetime,
-						current_time_ns,
-						cycle_time);
-
-		priv->est->btr[0] = (u32)time.tv_nsec;
-		priv->est->btr[1] = (u32)time.tv_sec;
-		priv->est->enable = true;
-		ret = stmmac_est_configure(priv, priv, priv->est,
-					   priv->plat->clk_ptp_rate, true);
-		mutex_unlock(&priv->est_lock);
-		if (ret)
-			netdev_err(priv->dev, "failed to configure EST\n");
-	}
+	mutex_lock(&priv->est_lock);
+	if (priv->est && priv->est->enable)
+		__stmmac_setup_est(priv);
+	mutex_unlock(&priv->est_lock);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index ac926c60f9f9..10b61fa2c27c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -966,11 +966,12 @@ static void tc_taprio_map_maxsdu_txq(struct stmmac_priv *priv,
 static int tc_taprio_configure(struct stmmac_priv *priv,
 			       struct tc_taprio_qopt_offload *qopt)
 {
-	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
+	u32 wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
 	struct netlink_ext_ack *extack = qopt->mqprio.extack;
 	struct timespec64 time, current_time, qopt_time;
 	ktime_t current_time_ns;
 	int err, i, ret = 0;
+	u32 *gcl = NULL;
 	u64 ctr;
 
 	if (qopt->base_time < 0)
@@ -1013,42 +1014,46 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		return -EOPNOTSUPP;
 	}
 
+	mutex_lock(&priv->est_lock);
+
 	if (qopt->cmd == TAPRIO_CMD_DESTROY)
 		goto disable;
 
-	if (qopt->num_entries > dep)
-		return -EINVAL;
-	if (!qopt->cycle_time)
-		return -ERANGE;
-	if (qopt->cycle_time_extension >= BIT(wid + 7))
-		return -ERANGE;
+	if (qopt->num_entries > dep) {
+		ret = -EINVAL;
+		goto error_unlock;
+	}
 
-	if (!priv->est) {
-		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
-					 GFP_KERNEL);
-		if (!priv->est)
-			return -ENOMEM;
-	} else {
-		mutex_lock(&priv->est_lock);
-		memset(priv->est, 0, sizeof(*priv->est));
-		mutex_unlock(&priv->est_lock);
+	if (!qopt->cycle_time ||
+	    qopt->cycle_time > (u64)U32_MAX * NSEC_PER_SEC) {
+		ret = -ERANGE;
+		goto error_unlock;
 	}
 
-	size = qopt->num_entries;
+	if (qopt->cycle_time_extension >= BIT(wid + 7)) {
+		ret = -ERANGE;
+		goto error_unlock;
+	}
 
-	mutex_lock(&priv->est_lock);
-	priv->est->gcl_size = size;
-	priv->est->enable = qopt->cmd == TAPRIO_CMD_REPLACE;
-	mutex_unlock(&priv->est_lock);
+	gcl = kcalloc(qopt->num_entries, sizeof(*gcl), GFP_KERNEL);
+	if (!gcl) {
+		ret = -ENOMEM;
+		goto error_unlock;
+	}
 
-	for (i = 0; i < size; i++) {
+	for (i = 0; i < qopt->num_entries; i++) {
 		s64 delta_ns = qopt->entries[i].interval;
 		u32 gates = qopt->entries[i].gate_mask;
 
-		if (delta_ns > GENMASK(wid - 1, 0))
-			return -ERANGE;
-		if (gates > GENMASK(31 - wid, 0))
-			return -ERANGE;
+		if (delta_ns > GENMASK(wid - 1, 0)) {
+			ret = -ERANGE;
+			goto error_unlock;
+		}
+
+		if (gates > GENMASK(31 - wid, 0)) {
+			ret = -ERANGE;
+			goto error_unlock;
+		}
 
 		switch (qopt->entries[i].command) {
 		case TC_TAPRIO_CMD_SET_GATES:
@@ -1060,13 +1065,26 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			gates &= ~BIT(0);
 			break;
 		default:
-			return -EOPNOTSUPP;
+			ret = -EOPNOTSUPP;
+			goto error_unlock;
 		}
 
-		priv->est->gcl[i] = delta_ns | (gates << wid);
+		gcl[i] = delta_ns | (gates << wid);
 	}
 
-	mutex_lock(&priv->est_lock);
+	if (!priv->est) {
+		priv->est = devm_kzalloc(priv->device, sizeof(*priv->est),
+					 GFP_KERNEL);
+		if (!priv->est) {
+			ret = -ENOMEM;
+			goto error_unlock;
+		}
+	} else {
+		memset(priv->est, 0, sizeof(*priv->est));
+	}
+	memcpy(priv->est->gcl, gcl, sizeof(*gcl) * qopt->num_entries);
+	priv->est->gcl_size = qopt->num_entries;
+
 	/* Adjust for real system time */
 	priv->ptp_clock_ops.gettimex64(&priv->ptp_clock_ops, &current_time,
 				       NULL);
@@ -1091,7 +1109,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	ret = stmmac_est_configure(priv, priv, priv->est,
 				   priv->plat->clk_ptp_rate, true);
-	mutex_unlock(&priv->est_lock);
 	if (ret) {
 		netdev_err(priv->dev, "failed to configure EST\n");
 		goto disable;
@@ -1102,11 +1119,16 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	if (ret)
 		goto disable;
 
+	priv->est->pclass = qopt->mqprio.preemptible_tcs;
+	priv->est->enable = true;
+
+	mutex_unlock(&priv->est_lock);
+	kfree(gcl);
+
 	return 0;
 
 disable:
 	if (priv->est) {
-		mutex_lock(&priv->est_lock);
 		priv->est->enable = false;
 		stmmac_est_configure(priv, priv, priv->est,
 				     priv->plat->clk_ptp_rate, false);
@@ -1116,10 +1138,12 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			priv->xstats.mtl_est_txq_hlbf[i] = 0;
 			priv->xstats.mtl_est_txq_hlbs[i] = 0;
 		}
-		mutex_unlock(&priv->est_lock);
 	}
 
 	err = stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
+error_unlock:
+	mutex_unlock(&priv->est_lock);
+	kfree(gcl);
 
 	return qopt->cmd == TAPRIO_CMD_DESTROY ? err : ret;
 }

-- 
2.56.0

