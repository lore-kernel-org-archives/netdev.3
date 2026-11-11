Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794390889;
	b=aLUj9cJi347UI/oOetJmLlYZEZ87tnpg/eoIpP/pdAx+DWzSa8rl4cTOE0ho4Rzp0VOZ
	 w7t6VcbF8LNlZbOUU1vyidUst4+zxTbAPv6295k6NoVeF1ZTHY/HBqAtbpCM0DqbUM0/8
	 pFKxUFK+mG+2RMU9knlZX/X/uNj46pUUfdFSZhnE42ySaqPILb2MCvtETLyNeEepW/ALP
	 9HtHtT4TkDy8cgExiI2Ln9WuaKfp6iOk0DFkAjSp4iV8tsKPoc2VMDfwIOeeR9Wbmje4B
	 0wvibEM3uS2hBJDuZ5cuHe01KdYm+G3pFiDb9GAPNuTnHH1vLSi5xqSkxTWYzFlwhGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390889;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UdG5oyTsW3SCo2JaVqWOt03kQFAtr2dh6inbjFjR3UM=;
	b=LDHz9NLgq0medpL7eS9hsBXeh/laUe0VnFEmeiXVWqGYGnVE8MuzUz9WPylQoxgW/Z4H
	 dYSCD+EpJkqS0MXYO4JJCYqIPirAciza361PwP7uiw0IVuXy37MNR7TiYeLAe9ceisAwA
	 uky4EsQTnK2glqk1bP/534NKjao5V3rM9WJqBzn+j0hkCodkCj02FZX069+ZKxBchZCmP
	 0TiKq09fQc4MG786sKZsYsZ814KqzxAKfw67dbRRouGFeJMMlA6nK0P9HySg21ztwr8FK
	 1xIFh/KCArS7xG0rpGmjUO9pWTfA4/WCgaddnkEYBfpD96yJfKYI8bSbsbuvtbLg/yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cKC7hwmo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VafnTvo6;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6138A606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6138A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cKC7hwmo;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VafnTvo6
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5KQ2k3959060
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UdG5oyTsW3SCo2JaVqWOt0
	3kQFAtr2dh6inbjFjR3UM=; b=cKC7hwmok2r4xo0UIntxu9OswXSJFTOIQpPgol
	FbH88e0jmx+GVS158ESiDX8wsRVBmr6sfy1K3t+qWRme+k1LKDryCrglucTVweO2
	WdH+bbwzs779A7JEXRvfoCTFZ8Cqo0Z3emqf8kTmKlTML12pVwaiZs+/tDAgHSL9
	rnwNTifXZb2JuenQu2267G3EMzECaF/ldhicKF6sZxVveazdRBfm0bvP8SOj37xB
	F1NteQbz/nWF7JxXBMvjjE9QxS+ZsN1W5NRnm1CtjO3GkVjfxMYMokOwT6xtvC4a
	mAhhS81dwVZTbg6ztTcLm1UjtkT1AG7HZ1Hq+DbjWCH70nvg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv9b330b4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 09:54:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-944138ed63fso530369985a.3
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 01:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794390887; x=1794995687; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UdG5oyTsW3SCo2JaVqWOt03kQFAtr2dh6inbjFjR3UM=;
        b=VafnTvo6M8qhkz5KBghXwOBGOnon0Yz6pKSsZsuqE7yfGTy0i9+wpwUJfN/Cq9GYle
         VNRcqhC7RbXEx2x7fEIsd1M3NrjCjTfSV3F+uOiFZWZ43G9nNS/EiYCLcKOdiPt3N71/
         ntxPZi/MgPGRR4aOVQY+04XJS8E+sk5USI7b8/sh0yZQ+hzdYpouzzFlPgDNLp+VmQ38
         eJoY9Yz4zqciQbKfG+nZ5nXJF9iUYMBaAkztNkIqbHRVdEM4k4vBHRoGunHbbMTfPxvV
         0xnj+zz/KYWnfWm5HtfsoqxTSAfzsbx/gilsKaozEBeWQAhTnWKoU9MCRCbnmgmd3Yy4
         wC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794390887; x=1794995687;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UdG5oyTsW3SCo2JaVqWOt03kQFAtr2dh6inbjFjR3UM=;
        b=nhOHxE/4eTUPbJT1DMdi4OpmgzSkQ/q0h35sea0iKfqm7l/KUUXodx3gOIQeeuq93q
         Dj7JFclgRbz1ez112SXx4fBQKRozZkJO/CUdxmud2ZWqZfl8xLjGSXKML/QGak4yXet1
         YF8Tn2alezqTSteuiXciXzWpViiqoIjr9GnXEa/6dxL3B02nTDP6Qq8i0YhHYeUXmHrh
         z9Q4bQ/JIGAhWsna1z1wWv/sUhKcGvUThhjBVIh0lionnLCtr6IvkpjP0fjsMCg4jcDk
         AKaG9aSw3UNr+tm+m8KARaIPnGVoDQoLzAja5bbSGhHnN15kDi4COVGbwuCS/DSbB6OM
         oKeQ==
X-Gm-Message-State: APuU4Z+ikVzMl8hrhaiZ8RtRJYQdtwRpcuDlMEd9ztxZ57FObsNNn8ZK
	oowcpKPKF96N+WcAKoK+0BNZ57R/Gp8UjbUeETRCO/WPL679mfLCh1BofZuLiGC4ZPNPDih066l
	gfj4WDvZn1+c2whowHG8n8q3AWwhdvcAk9fMzuq9hhcNL0QXnKkyQfML4A58=
X-Gm-Gg: AYBFou0LHwj3haAmeg+FzbxCW5QWSe+bhTZFYImSFcRkRIC7WHlP/N2CzsXi0BS4ji0
	/qVk0W9S9qmh1smE3T5gPBpMgb6QP4vxArSjQNR47khcOLC+cE4x8o+ZSxdgqUOqRH9eX3uQn6q
	VQWjweI/f8RSGUHGHbkUKHc2UAP+Qx1u3xY2qyUayQBuXqDhOaWEvsSYZcnwe7dJi47Kc74yn6K
	+lEzVWQMD1K5wCG4lg9Z26lQ65y5ZPqJZR4jMuqAyZa/vTCJxsaVHpz2oYRuZS+DcgF+DzSfjHU
	KFQ6Lb3aU+wniElVDqFXgM06VyA4Hbfqdt8SQxK05B4V6UYO0Ckz9pxSjNeAwjbgdfQ8z2gGLtg
	5/zOlAdwq9eDElp01K/GY2hTmZuhWu+ObSsq1l9ulrlZ6q2eMErqV57Nz1l1GuJs=
X-Received: by 2002:a05:620a:4712:b0:947:7857:bb7c with SMTP id af79cd13be357-947affd2230mr285459485a.33.1794390887272;
        Wed, 11 Nov 2026 01:54:47 -0800 (PST)
X-Received: by 2002:a05:620a:4712:b0:947:7857:bb7c with SMTP id af79cd13be357-947affd2230mr285455985a.33.1794390886668;
        Wed, 11 Nov 2026 01:54:46 -0800 (PST)
Received: from localhost ([93.66.104.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba09509c74sm25782215e9.2.2026.11.11.01.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 01:54:45 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Wed, 11 Nov 2026 10:54:27 +0100
Subject: [PATCH net] net: stmmac: re-base EST after PTP settime64
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
Message-Id: <20261111-stmmac_set_time-est_lock-v1-1-da1554f233e6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQqDMBAFf0X2bKCKmOKvlBJsfLFLTZTsIgXx3
 w3ObQ4zBwkyQ2ioDsrYWXhNRZq6Iv8d0wzDU3FqH23fFIxojKN3AnXKEQaibln9zwTbhc6jt8+
 PpZJvGYH/9/pFCUrv87wAsbkWbG8AAAA=
X-Change-ID: 20261111-stmmac_set_time-est_lock-f74f4ce678b7
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=GKGdgeNK c=1 sm=1 tr=0 ts=6af43b68 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=cAAIdyqZgEis9HJxay2Blw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=_-cRevXDmKoCW8SLZQYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzOSBTYWx0ZWRfX/P7tiMtZiJfs
 Hz+wSR/VD65gJaCdYoFfbVm4deBBM9P/0117/6yxZeNGlee6gx/f8LURcgnUZL1NHTprqTmJg3w
 wqdeloXcGnVZoyybh+yb5cDkkmAvqS5cuZ5b7AMaQMvHjKCrm8gZXgd9wlMo6A41X2oFwenuhJX
 xExMPmhmVcN3WHTheuDzGa+pmCOhbJNItfaMLenKQ+LNzFaczfoMO+HnRet1W6MFnYuSvroXa75
 E5hJPa4Eqx5+NFy5KEUAAR4uP7HyydLQvrn2gcMIuwZ4B7bx+xpECBj2JdKFTQYFXBu6VA+o8Wd
 12NyrpET4RV+XAvD+Kv6wCyhrjjVkhGwd+YA8ZMTnM0xfdCDVkPNliEr3bYf4T1ons+D94hkceE
 4X+KRfxtjf9UXX99nm48FTGUdUxjtWQnFHRPHgaC3tJDIsC1VLwteKQt/s2HUovNWXRyimX9ofZ
 QGcNoqPqirPQRu4Jv5w==
X-Proofpoint-GUID: AoFZs-WpHKY1qGeqg6DdPGQ_sIf9MKnz
X-Proofpoint-ORIG-GUID: AoFZs-WpHKY1qGeqg6DdPGQ_sIf9MKnz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzOSBTYWx0ZWRfX06UgFO7cZ2Sh
 ndVnwt2JqOmgFXEQVnlGSjRXdU2GU7+EeMqx0IiA26pVYKYBnRAx3VcBvcMULxGpUbjk50Ju32w
 lr53O9/bLrl0oLEB/7HYqQ2Mdd3tAgM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110039

stmmac_set_time() initializes the PTP clock through
stmmac_init_systime() (TSINIT) while holding only ptp_lock.  It neither
takes est_lock nor disables and re-bases EST around the step, unlike
stmmac_adjust_time(), which performs TSUPDT through
stmmac_adjust_systime() under est_lock.

Both operations change the PHC system time, so both invalidate the
absolute EST base time.  With settime64, a concurrent
tc_taprio_configure() can read the pre-step clock through gettimex64()
and program EST with a base time that is already stale once TSINIT
lands.  Separately, a taprio offload installed before the clock_settime()
is never re-based and keeps running with its old base time until taprio
is reconfigured.

Take est_lock for the whole disable/step/reprogram sequence, as
stmmac_adjust_time() does: disable EST before initializing the clock and
call __stmmac_setup_est() afterwards so the base time is recomputed from
the reserved taprio base time and the new clock.

This keeps the established est_lock -> ptp_lock ordering:
stmmac_init_systime() only uses readl_poll_timeout_atomic() under
ptp_lock, and __stmmac_setup_est() takes ptp_lock through gettimex64().

Fixes: b60189e0392f ("net: stmmac: Integrate EST with TAPRIO scheduler API")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 31a66e855d6b..6370bdc6c58b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -129,10 +129,19 @@ static int stmmac_set_time(struct ptp_clock_info *ptp,
 	    container_of(ptp, struct stmmac_priv, ptp_clock_ops);
 	unsigned long flags;
 
+	mutex_lock(&priv->est_lock);
+	if (priv->est && priv->est->enable)
+		stmmac_est_configure(priv, priv, priv->est,
+				     priv->plat->clk_ptp_rate, false);
+
 	write_lock_irqsave(&priv->ptp_lock, flags);
 	stmmac_init_systime(priv, priv->ptpaddr, ts->tv_sec, ts->tv_nsec);
 	write_unlock_irqrestore(&priv->ptp_lock, flags);
 
+	if (priv->est && priv->est->enable)
+		__stmmac_setup_est(priv);
+	mutex_unlock(&priv->est_lock);
+
 	return 0;
 }
 

---
base-commit: 22b7cb932c6a0f7566d41072be6956cb6c8af4e1
change-id: 20261111-stmmac_set_time-est_lock-f74f4ce678b7

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

