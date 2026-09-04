Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE433EC69D
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518003; cv=none; b=sQgGAqyGIXah98hp7ZA1iCK45NmdTuAR7U8bAIsYYoHtZqg59v2CX4ufDV26PF9nmun++QeO6QlpUlVSNAnKdcpNuVc1NYTI1kegFJTkq0yOIu02NEQsj2UvgDvtUHZNII/icMV4oPXClAxe7Z5c0ma7GFcvn/DBmZLRuYea5xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518003; c=relaxed/simple;
	bh=FXPIz7ji7N6/mA4z4TaDO6EsnAACx3p8Zbpsie5y3hE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pGjBdP01lOGtklnTxkBpqN350210+yPc8/EXWGSbLVluQacx5UCgLlfnZbp23GPOAzzEbhZEqxudQngtiwzIXngX1IgP0wnWmd6MAi7RlT+J+66h/twI3nipLNEo+nsmteVhij6v6KzHKW/h4HN7ICVkl8TMxua3QCM2TGKWICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LNrNi32y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ElJPPPSd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LNrNi32y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ElJPPPSd"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684AIFM13442537
	for <netdev@vger.kernel.org>; Fri, 4 Sep 2026 10:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+Wco/kXMn0u9im/xM9AEVe
	sGiGf2KmU+6WXQANShwKs=; b=LNrNi32yS4j73C57+h6LNMvcxwU30EDl8g7Zr5
	eS+IvLjmirfKDHYJQdKmWX+s09duLT+vvLqhLFP97Vgs/9rUZZ71zZKL3LMUjvKj
	5DIlz59d4mzdYUhHr6w0t01fl6/78H/2DBG9kXvZggXrJN5yt+4xsQJCdwGh+Ch3
	vEzUewmIxRvp3u3XdU+3YJS7/6g0UPbDSk9D04EkZDP299ehdHjSG/eAndnK7hic
	3lg80R4sxoPdqGF0+HWzyEwwrro5EW5aL0muqintLv/SloYh/ekFBOlJaR9EYXkT
	9Al+wa9eXs+IG/M8i4irB9h6KLsi+5wTuAXeq4oM4/3grb+A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp7818b9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 10:33:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e820609d9so166905585a.2
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788518000; x=1789122800; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+Wco/kXMn0u9im/xM9AEVesGiGf2KmU+6WXQANShwKs=;
        b=ElJPPPSdNCGkykWbkGobIID891z+KE2lOBD78Gm5XksQRX3KchyzPWd2IqrEOwP/RC
         I2Ygn2vO+LS4M9wfv+FDta6Fhx/LzzJZ8Opnf0PwKchrfislnjjeiAMV6i6HYP0YQgvL
         FnoRNX5/25ZTFyNoAewBjw1+6Z6go75PuV8MdeXno1KSB1SrNwWRvjJRj80ROq0tGPmc
         HBVoY4uRrJJtBZYc5n3WVeolG0dEDi/8DExGnysOZL0Gn/WegSqFtocHlvmTDefDrrmH
         rlKet/7ubJeIotwQ0rNBvl+HP4HI4wTy53dpONSDVxbdCsNeiV7m5zHSO9t0OY565ja3
         CDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788518000; x=1789122800;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+Wco/kXMn0u9im/xM9AEVesGiGf2KmU+6WXQANShwKs=;
        b=KdarZHP+nYscfZuTw0tfh3JKl9oNtNcep7XrFVGiItfxc2qWK/ErFID9mB9paIX/Jg
         i1CzSua2U9AGOYuHWvwO39R6BUotEbRzz1PVPb97TD3UPwVhXffjUl5a1euBh3AsIDv+
         ErdYMZsY2+qOgBB1Hvx+BEYGQMg5Sn45rFE2A0tauEvz3zUcb61O1tEM4xnLpV8EA+M4
         yOzbmR2hbbR9d09pSjEe/7Uc51bYY0yEP/Fdle6MNaYM/0q7knhXhNQv9TUyjsMljU5U
         lvJGEvZOWEG98tXdcOQSTkCU33tc+AundF+6nEnq1Ur6LuHSXPaf+CMrKAEV7ZqNjCIc
         Y8Yg==
X-Gm-Message-State: AFuF++lEiMLfvGivHapxZ4j5bOZYYRger87x1TvhGo0n8nJ0IRClaPVN
	qWN9LLSxN9XNzmTPoU4LFdgSf9sAXJAZY+FXrVHwShLmHlwOxo/Zt11s5oaOetflorOG39Zf1T7
	wrN/7LHHvaqyKTjgVzK9rNt8yptd1CCwRjvKqNoxnbnh4L+ime4/7okMF0+U=
X-Gm-Gg: AYBFou1xzessSyEUagVYygkfUBBbahKQnf9DJNKfn1CU5nupDSMHfRChAlwFbxksq4a
	3gzWt6pNyhsB97rnxtqqMWLc7+BGOMSLLp7CQTUTls+PhjGg3ESkyA/aApIccg0x1X8dVIGvwgr
	ub9HXPLTajrZ1ZZ7tt0l9dBKPUwqDe7pVrN+sHz0kDti1oLCili/8GEPGeSv2450YciYcdkWeQF
	RauhuILxc8JgRUar6WX+TbUIsE86nVO+2iGSVRPafHBldALidasgM860rUgGKZI/rYCDtQhqUg+
	4zu1hkxKhZFSEpj/jCIBdM7vQodAw7FIaeP/eBLnzRAfYifOA0geN8S0E/WE+YJIP5x7uYwDhHl
	DETo0yLatKmTSog==
X-Received: by 2002:a05:620a:4105:b0:92e:4927:2002 with SMTP id af79cd13be357-9398045f7a9mr460779885a.39.1788517999925;
        Fri, 04 Sep 2026 03:33:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4105:b0:92e:4927:2002 with SMTP id af79cd13be357-9398045f7a9mr460774485a.39.1788517999460;
        Fri, 04 Sep 2026 03:33:19 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm159708415e9.13.2026.09.04.03.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:33:18 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 12:32:55 +0200
Subject: [PATCH net] net: stmmac: initialize ptp_lock at probe time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-stmmac-fix-ptp-clock-init-v1-1-df70eb1eb04d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7bsFUovpKdDDbaqlMVCKI/p50H
 JiZByIFpghd8UCgiyOfLkNVFmBX4xZCnjKDFLIWrdAY03EYizPf6JNHu592Q3accGxoNFrJRmo
 FufeBsvW/e3CUYHjfD7r6RGhwAAAA
X-Change-ID: 20260904-stmmac-fix-ptp-clock-init-b8eba4328243
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA5NSBTYWx0ZWRfX0apcFa7Je7jw
 aAp/N4E13wExuaPO75smvvWdf5UisJSA6G9vsxnv+Rfb0s53DP2jH7d9HiOaMahf7DHFSUBUemz
 2FzS6D6+k1F8RsO9tADFWG5F7mCBiy0=
X-Proofpoint-ORIG-GUID: lt3hp6e6LmMG2T4_nRVVMDxzzdev43Ky
X-Authority-Analysis: v=2.4 cv=ab5RWxot c=1 sm=1 tr=0 ts=6a9a9e70 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=-llX2YphXL_7R2jwOlwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: lt3hp6e6LmMG2T4_nRVVMDxzzdev43Ky
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA5NSBTYWx0ZWRfX6KlaEteSVwog
 xXvx8YAeJ7spu7PjI51cIPIOMqHUbnjs+bV+fZxFm52GZ5wdhuYgL314vEGXU3goisGE7kcP7rh
 3BwJV8WRCxR77SJt+sBiLY5Kon5EyxE2i8hRn/rjAoZqb0KZbPvfBRdcJt0N/ntDlst4TnBXtyz
 GQlrL8VkW+PNLNY4g44Fh+nftEw1tM9NCoXbEMKXog33ydH7nCmvMmbgeXeN1UvBnrOW1ujAFep
 pRU0oEXyAlpi4grUrSu1TNr6PQ6TwUhCgTCVnfjccxyhJTEXwjBsiDSC3B3xE5EwvQY90SDuheg
 gJckbeuZpx8hIlGZH6snaSnxL6KJXhCvEZwnvAPHKewZimwJjtfwvuK/V9ZbXpf+UqZWMxxOH9V
 l98hAAb1yxmEtKWqc2TrvloQ2BMi1khdKST5gunwXYU7Kgcs3cKLMBQMDpN2u7JFXdvbUz48Sqe
 eyKyt7Br97W5/cul+bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040095

priv->ptp_lock is only initialized in stmmac_ptp_register(), which runs
during __stmmac_open(). However, the lock is also used while the
interface is down and has never been opened: tc_taprio_configure()
invokes the PTP gettime64() callback to compute the EST base time when
offloading a TAPRIO schedule, and stmmac_get_time() takes
priv->ptp_lock. Using an uninitialized rwlock is undefined behaviour.
Move the rwlock_init() to __stmmac_dvr_probe(), together with the other
private locks, so that ptp_lock is always valid regardless of the
interface state.

Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 1 +
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 24656b35350b..5fe7e95fdd34 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -8025,6 +8025,7 @@ static int __stmmac_dvr_probe(struct device *device,
 	stmmac_napi_add(ndev);
 
 	mutex_init(&priv->lock);
+	rwlock_init(&priv->ptp_lock);
 
 	stmmac_fpe_init(priv);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 960249960004..3bfcc9760dce 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -365,7 +365,6 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 	if (priv->plat->crosststamp)
 		priv->ptp_clock_ops.getcrosststamp = stmmac_getcrosststamp;
 
-	rwlock_init(&priv->ptp_lock);
 	mutex_init(&priv->aux_ts_lock);
 
 	priv->ptp_clock = ptp_clock_register(&priv->ptp_clock_ops,

---
base-commit: 641d03105cc0d2437e32fdeec164f91a4ccef6c4
change-id: 20260904-stmmac-fix-ptp-clock-init-b8eba4328243

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

