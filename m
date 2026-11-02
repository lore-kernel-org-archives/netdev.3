Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793641092;
	b=vQzSR3dYcaIVwAjRPlHqvOmsZha2BtMtnDMhnSfpWpayrQqzDzfkLwXyWJ9rcV6pztar
	 tqgSLyfuhfz5/GaT3lgxYdQI/1h89H59a7Nj7ruFt+0LhSO3X0EP0+nh137L8KWh4T9tn
	 9oFeGhlZrOyiMf4KdTm4Zb6rFDMU/FHJqeGbNbHfnY1iWDx5lYgHbt78iDaBeY1Jbng6/
	 bj0OibZU5xlzG1lOG0YLRbzx14ySsvwg4NpS1nriWk06qeLKuZTMVgB1w6uuKk+qLm/92
	 waR4pot4f/S9mI1lsoLQM6YfYiaqEPTUeGskURGG69S488UQbgevl15K9MaGHBY7idg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793641092;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QQb80D+r6JfVtoptDfuVmhrS3wB+UmuBb1MfOz4BLGY=;
	b=ps7NzWO85d43dr1BXbbaiSJ59rQWVRFmUuIXL7MMrztm26xw/RcUIUr6XVG/TKaUQT6P
	 ShbzuEZRXOOGFNUQ0np2h/TjVpe+fcj7Rl8W7QLIHrQmo5SxatnTD/FodPE7R63mD5kJD
	 7/r1pMXCgSpf9g57GEY6OAKTrXZS682y8vqgx2Cz7YR1lUNpi6ApDuBCsBdVmAS7D7bgC
	 nCg5LU85JMViIDTPKqR+4AHAuRlvgq9WoVLwSRsyonfdE3dv1j0wmHR7GhQ9hG4N8gG0M
	 V9Yt7Oj/mF0Oz8A5sriOuVxFa3u/Bj7q21hXZbelrXj4tA+mbYPM9BOrnSo7O0g4TZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y4OJZXIW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YwkjmrX6;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D830606A90B
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 17:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D830606A90B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y4OJZXIW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YwkjmrX6
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2HP3AY3480949
	for <netdev@vger.kernel.org>; Mon, 2 Nov 2026 17:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QQb80D+r6JfVtoptDfuVmh
	rS3wB+UmuBb1MfOz4BLGY=; b=Y4OJZXIW8FpWB4DnmBXq4AN3OSebEVwtFzeaow
	NOofCoU47R16luZzgkAyfq1If07+2c6tZgbBpbdAsm7mpy0iXzAYCuR1f7W1BSjq
	YMrZqhVyg9Wj4Hcj0R4oBRLiWpfd6w2ddc456HZbW41ju1hJWfFS84F6ReteDjtM
	KqYqyK0QPC3wOAZrgUWwqpxFpSZCygtw26KHSu2NmPWFPQWfLrS721W21L7dnUZ3
	dvlKXU5aNRAJLZk75LTE0l7WDnidZvgmxDML058LG1P5oZOqKDgc3XOxjsvXecT4
	r9N7Dlyn2622O6Zhjr3BOyaA/80urhl6sEh6i/g83nilJ8RQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpsavhnr2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 17:38:10 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb98809caso547085085a.1
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 09:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793641090; x=1794245890; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QQb80D+r6JfVtoptDfuVmhrS3wB+UmuBb1MfOz4BLGY=;
        b=YwkjmrX6B/r8ZzruMizV3N8coCuP2o87CrFRiNZpS367TypXBJ/eix7nweU8hFXvKa
         0wfDi058No0ZbZ/eNXLBupUkGW9zdzZ4Q+IJ3YjKHLg5YPnaHZZMIZJJffZggEl/gooJ
         C9h4nE4Gz2Gl4/4RyNTL1wWoSQ3SX+SBER0F5atyu1ID4v6RHpVbrGy4Lzs941TnMx3Q
         Vho07i+4DDUc4Yqp5aGNoBEM+mCCFgiVNdWrhlMVtmnvvYgboc+8U2JWOfs+D1EqSbiZ
         OFqgkovTVzHwMutIIXBmpCI0emZ0HFaI9IzhFIXbRWeYJcPMY8P+v1urV8OqHYQIpmAH
         3MWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793641090; x=1794245890;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QQb80D+r6JfVtoptDfuVmhrS3wB+UmuBb1MfOz4BLGY=;
        b=nxev6rwaWnvuAGbNNjdBh6YHuXpdH+mPpSBj0LOVM1zJUN0IoHl0m7FCqd7uBnLqjL
         p6sL7ne9JsvIiP7cO2MZ7fRvzwffqMXV1ZXOX8jQQQrLcLg28DoIj7Haxk9O09BKffSO
         ++ls96uUuSn5xHr3gcqFxetStGX78jEG4qavwp7MF6xt33LJh8wOVNkUnyvR5tQX6rjj
         7ygUTjZovOeckWIWdqNGXXDE1bOAG+Twd+Z3Gr5wBWj3YjOkiPeqAB5Ozq/l48XwfpAU
         1FQO7A8br9I5ISoMx2EOXLr6yvz2kxUviPkSiisXxBvHJ1nCitBhBNwBTNqz/FGwuEGL
         sVBA==
X-Gm-Message-State: AFq9FYLnP3Y4Acllfk0ZhZKQkco+4/H4N0+HrvIZ27ULbyY0BOJbd+8r
	w5Qrp2uQwQ5ZrK5ChTbw/dofU3jkHvn6VGQ/iBtBixpFOwGMjBGsPaMOomoxDgkzcMT8Mxvun9a
	GFYazSQax+33bYgZ0ArVt1fcjJf2a8LumVlaZ5EPxWDZhAIke9/W/zBNKv4DohO+07C8=
X-Gm-Gg: AYBFou0r6h7yuxdKUTvmXo7xuy2AzARzd9kv2wTvt0ASz4kXAdqbdafRkrmtFM6T6g5
	QbhyoRWXRfCs8oW1VwcE+3Wlk+hkT4Z2xZ+6Hyu/j+B4DpO5nJz7QUyVfnRFFRGgGmTMZIYAU+x
	ipu2DEZuiJFqD67yZV5h7V/S2muNsI+xin3iqsj+jH9D2QeYNcQ7t8kIRyzxsYGKsPYhvKbLHlA
	1CrHZFSKIcVHUDHsbuTTtEk5vuuOq65SXJLqRQBRvHz7uoQ/LTB0/vGxb3CqTSWWs9BJjVHhBCj
	SfQXQ4d9m3phF85hYh44Tacke1Dr0oqWchH08IGhIpvnjh7EZhbeEcEHdQu2V+28qkhdwxTX/CO
	EFPuoYaxiixTnEEociDLW92w28U/kwmnbglvjXsNMz6ZSixjUhzgcTyZw62iIpL0=
X-Received: by 2002:a05:620a:19a7:b0:944:110b:d824 with SMTP id af79cd13be357-94421581772mr1756138985a.5.1793641089585;
        Mon, 02 Nov 2026 09:38:09 -0800 (PST)
X-Received: by 2002:a05:620a:19a7:b0:944:110b:d824 with SMTP id af79cd13be357-94421581772mr1756133785a.5.1793641089016;
        Mon, 02 Nov 2026 09:38:09 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac09ad35fdsm198764435e9.2.2026.11.02.09.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 09:38:06 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 18:37:56 +0100
Subject: [PATCH net] net: stmmac: keep est_lock across PTP clock adjustment
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
Message-Id: <20261102-stmmac-ptp-est-lock-v1-1-76fbc0cb230d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQrDIBBA0auEWXcgDqQJuUroQszYDo1GHCkF8
 e6RLN/i/wrKWVhhHSpk/onKGTvMYwD3sfHNKHs30EhPY0ZCLSFYh6kkZC14nO6LM01+cTN5byz
 0MmX28r+vG0Qu8GrtAv6/ui5qAAAA
X-Change-ID: 20261102-stmmac-ptp-est-lock-725f8c72ff1a
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA3MCBTYWx0ZWRfX8rtVv23rhbNS
 Vf8dwwbOfPP0EXmeJ3mg01EtvK41ay180TjeCeu6gKs8Qt7h37l8aGOsnb47lUDjbq4uE5/TPqW
 lojcSTIfKd5W/HUsqIea9ZCsrJsTEV9h43jC81KZnhNiHxHtRFE9rwvj9771okI0zR83Biak0RV
 TSx7a58q4TzdQU3qgPM8HM0buzhRQ//JQzdtV3uQBBqbf6TSFGEbTfL6EfMZHnWbl3EHkUgqXVH
 NSI05bgqHxaR4ClBG0DPf0bJZ7dW07PmKCUXa1Q6CiPqli1m6lkIbf6zqRJ2hTbR82SjsmS1ZZg
 E2JTO+ycbL0+ZZLgnm6DwmkyoUZt+lmc6pQLlkwv+lFc6x74pz/Xn0TjuhEIGBKqqA7AgxXP4WD
 c87vneWR3SyAaIy0ndj3WSxvZP/W6ldCESFZ88zxzTY38NMUTPbytzoFZHvpJf/Fvv9SnseXM67
 MNNfIsjTFsmCSqwQqSg==
X-Proofpoint-GUID: eN732XEchlipSPC7ZmaY0lZrVNAv3sGx
X-Authority-Analysis: v=2.4 cv=FZmiV5+6 c=1 sm=1 tr=0 ts=6ae8ca82 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=2V3RxEKsxQ3JlP20WKEA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA3MCBTYWx0ZWRfX4CUKH/Rd2riy
 fVnvZkAj/1Lq/E5RsLRBal+kij5BfMG5xJ2NdzrGU0WFzSkN4ptc+iHMT+RiJiAIEXXV9B6wT10
 BJQ/yp4lredZ3/2HLaobEqGQng4Tw5M=
X-Proofpoint-ORIG-GUID: eN732XEchlipSPC7ZmaY0lZrVNAv3sGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_05,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020070

stmmac_adjust_time() disables EST, drops est_lock to step the PTP clock,
and then reacquires the lock to reprogram EST using a base time computed
from the new clock value.

That leaves a window where a concurrent tc_taprio_configure() can program
EST enabled with a base time derived from the pre-step clock.  The gate
schedule then runs across the PTP step with a stale base time until
stmmac_adjust_time() reprograms it.

Keep est_lock held for the whole disable/step/reprogram sequence so no
other EST user can program the block while the clock is being stepped.

This does not introduce a new lock ordering: __stmmac_setup_est() already
takes ptp_lock through gettimex64() while holding est_lock, and
stmmac_adjust_systime() uses readl_poll_timeout_atomic(), so it does not
sleep under ptp_lock.

Fixes: 23d96de472f7 ("net: stmmac: re-apply taprio offload in __stmmac_open() and stmmac_resume()")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index a37405534beb..6ad6c2f52a0d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -73,14 +73,12 @@ static int stmmac_adjust_time(struct ptp_clock_info *ptp, s64 delta)
 	if (priv->est && priv->est->enable)
 		stmmac_est_configure(priv, priv, priv->est,
 				     priv->plat->clk_ptp_rate, false);
-	mutex_unlock(&priv->est_lock);
 
 	write_lock_irqsave(&priv->ptp_lock, flags);
 	stmmac_adjust_systime(priv, priv->ptpaddr, sec, nsec, neg_adj, xmac);
 	write_unlock_irqrestore(&priv->ptp_lock, flags);
 
 	/* Calculate new basetime and re-configured EST after PTP time adjust. */
-	mutex_lock(&priv->est_lock);
 	if (priv->est && priv->est->enable)
 		__stmmac_setup_est(priv);
 	mutex_unlock(&priv->est_lock);

---
base-commit: 7308ef8b4a6779a39f68d053c19b53a5c584a663
change-id: 20261102-stmmac-ptp-est-lock-725f8c72ff1a

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

