Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A069B45D935
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117131; cv=none; b=j3ykfm1vs0CS7j5PX0B6ZudWuBW+imtW84ERG4lqLmiqhR2j+bL9zJDxUzVMUDEgCUcmV/K/HWAyVQrjiwXh4Il6W0FxOeqcszWVd0QaCTAi69ruj8M5SexxGk57k+VvVUPI7QyusIN7DhA1pmzs+ZXrarGViEbnFobDvmmAgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117131; c=relaxed/simple;
	bh=SOi6LCDHJ+cmcUTBrwW8qUFSTh5cfAWOF19WP2ybHpA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QeV5uDH0+YoMfIbrSa9W+1igpZFva7R0Rg8cNiG5yFkzkZ2lBbJcnFg3mieoTuwk+yTH+dZFTFSC7LlLnNh74zeQ6EKKOmOWYjq9VnFMn6kjWGzPcTllxUCFlFSQa+bPBTW2LwvMxi7rH/lGezEsR/Obw9jS0pC5AOIOrhDda/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kYkyBXbU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AJMw6Zxz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYkyBXbU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AJMw6Zxz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7lJck3846627
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:58:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ui4rNKQkTeU5PMMBYKL/mL
	Ugy1+10rfQEnY+sjASKno=; b=kYkyBXbUXjDVDzwQ0hNq0cPpu2e83DLBxo5/kV
	fAKa64PdEH6np8oR2r1ZmrzdLLbHg15p30738+PjX1O7T7LrCgW4rTv+yIW42lFO
	USX8mrMH84RH6bbZM/UUZt2H6+/91CLhNwp+Xxnazoqi3Yp6IHvjDnpB4MPFaBcj
	XSEGliLB4lcpPA7+TSI5aSXBtkjv5fQetu1t3HljFQIz9/t7qD2mIGzjmvIFpfBM
	QRwqA/MKDNF6t/jaKMRPINnxTTByCCsrpFTYO1E2GFAtq53dq/AEMbkC+iC/djBr
	ubevLN095l1UQwZuOTiA6DwDW57ipviCZOtxeNFD1M7U4SNA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm5q421sf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 08:58:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936aa34873bso101036485a.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789117128; x=1789721928; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Ui4rNKQkTeU5PMMBYKL/mLUgy1+10rfQEnY+sjASKno=;
        b=AJMw6ZxzGO/nmFsbC4tiGLu+2Ugvm2c1bzjFj2H5mJ1YWBeuZQuoM+foBTmPN3arq2
         Hl5LFSNXgZB3YaHAPXI1+Pex1pLKnz/+F0lI51iqBfy629FroCGfNBYo6Ubhsg5tlZUQ
         s0LpTvsWoaYA2CpRr+1KbdYExmlNcPxYrp40vzXmKU7sjaa4lq8W33Ql11Caekc80fUO
         A/a+CrEy850iPuqvSR1ISco/UTkHWGX/0SC8eAHreFBNp+LHoK6ccg9kDuQnvQW4YFyh
         vV62/tlIVAzTofw2josj7B3Oyk0Xqevq93vMEo/7Z/0CW+qPKgVUDxBnrzDIG4UmP4L4
         nHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117128; x=1789721928;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ui4rNKQkTeU5PMMBYKL/mLUgy1+10rfQEnY+sjASKno=;
        b=lsjrUYco+5q+6mSdeRl4vNib8xpcF0RxGjKq2YzG2Ml79aDslApmZh0tDJpRnpvkXr
         9t1FvE5Eajtqu/Jmf4YrS9R+Wx/yMmPZFav60ebpoAODEyr0cObllZzgUsiakJ8b4i6y
         u3dcwcrAGuLagOGyrlxeWRV1ZbllDrVTkhAJNOa5tw/Am2sdoIJAluUMY9hQOjYaXSQb
         lK1qTIztvXKyN+1DTkv/msLlcpFgTD6APQrmUrlMVthdzO87iCGsuyECNEa1QfVjVads
         qhchoruKm0mNSsIAH/6nNyvZufIL7Ca/gQs088fTDJg3rBkvA/YcoZrIE2b9va2Tq4ei
         NCYA==
X-Gm-Message-State: AFuF++mcUmMdL+GwwA0sh6PAX/LGqDW7QWtN71t2NLAl9C6Gcm+g6Eg3
	SS6pC00Sj4bJf30KSFgi/8RtXB14ia5dhEmvCI5K5lS3rC5bE/f3/ipVv7wc8AsGKPF0tX24IsH
	UTVgjnOyhomlCAmf8qvY0yjMYFUGvhrJpHS1ll1SSEFviI56IQ+5OwCtA3r8=
X-Gm-Gg: AYBFou1MCI0BxZQLqDKzRjm2iAQtwP8BZS6fZ92pDiFPM7mnlsCosXk8FNwInXMhIY4
	k6E5OFVFa8bHscjb83lF1XDxDly8S2NNF02UBet8ElLGJRFsoFB1kBWsGwGI/IwsZ/XZhWcOXAW
	6w5/vFc1NbtyBEybgtnuGRYt1Zpytfg3F8RKytSdq36uLvGFzeOSR8FPMJKRnRMZpmGz75ZcPVQ
	UXfyiI3q0fLeKuUOOgCTVKwe68owUrMD/bKz8gBM4GDp5DwNlUEZWdjh5Y69564LmwsA/2BeU1U
	+OxUW808LbpK1NFHYxABM+M3zTD/W0CgBYmCyox2b0PvYviOii6OETyZBUaONNxk13G2adR3veH
	uMQE3AkUltlc6Lg==
X-Received: by 2002:a05:620a:459e:b0:939:9e33:6a63 with SMTP id af79cd13be357-939ea26b020mr367218485a.45.1789117127756;
        Fri, 11 Sep 2026 01:58:47 -0700 (PDT)
X-Received: by 2002:a05:620a:459e:b0:939:9e33:6a63 with SMTP id af79cd13be357-939ea26b020mr367215985a.45.1789117127275;
        Fri, 11 Sep 2026 01:58:47 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb34fdd2sm4455640f8f.28.2026.09.11.01.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 01:58:46 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net v3 0/2] net: stmmac: restore previous state if
 tc_setup_dwmac510_mqprio() fails
Date: Fri, 11 Sep 2026 10:58:28 +0200
Message-Id: <20260911-stmmac-tc_setup_dwmac510_mqprio-error-path-v3-0-a76b1e2547c1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/53OwQ6CMAwG4FchO1uzrSjgyfcwhgxWZIljsE3UG
 N7dhZMHL3pp8vdP+vXFAnlDgR2yF/M0m2DckAJuMtb2argQGJ0yk1zuecURQrRWtRDbOlC8jbW
 +p7gTvLbT6I0D8t55GFXsodR5IVWOGjvJ0sHRU2ceK3ZiA0V2TsvehOj8c31gFmv1jzULEECNK
 ESjNeZcHV0I2+mmrq2zdpvGqs3yU6h+EiRwKMWubEpEbFB/EZZleQMvbGZgUgEAAA==
X-Change-ID: 20260903-stmmac-tc_setup_dwmac510_mqprio-error-path-8d472a43d3f2
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Furong Xu <0x1207@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: jQVPmIafSY-C0F1g1x8-An1q730iSHMi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEyMyBTYWx0ZWRfX3nJ3/pMMFl33
 1KIHM8BRwVvKG/QbpxNUXBsKl3IOAFHy0CLIhIlMvk3Vi6BacJ9kxRYrWyIkxNXNva5EopWLoYw
 jAn1US2aDzMCWxGV6pDI8C5b0qKR8nQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEyMyBTYWx0ZWRfX6dSYnJo5ZjFx
 dvcfOAAa53YdoqYCit5r7BSBqX4QcjBEPtymA2x5U+WdVLpDFgdFKn2yexDrA0w96hoYlYC0xxo
 LWv1LOmgJ/FQvHsFVGCsLesc0H6FPMeRzVSuQ0Z/mamRwf/jzDsly2rKl6w3uDtCllWxd/2PgF1
 nkiiJT8gqiCaNh/n8X2CgA4z5a8s7OJKvHw9TmhKf4WbEXvQh8/yCqo/E3yLi7h+YiefpFmtAJP
 fL6jOlQlgY3Phu1n+MGIZ13v+YzWuO/m7+j4Q6SNIoNCakCA3sSrKMGcIdvI9BzTRLQdQe9mdTx
 MkCnld3z3RpMK2Fx9KIYtj3c9AXvrt2SLLQcom3UeWPXkTQjLg9qXtA6tL10FouTsU/koq3uePK
 nkuBA0YKmMuJWjzjt5xmRjLK80ZyJ0PaaASa275Da9l6Qx/2NZ6M8UkupZ6JfyUIDeVG64kKTr3
 EoR6NhFcMwAo2a/fDIg==
X-Proofpoint-ORIG-GUID: jQVPmIafSY-C0F1g1x8-An1q730iSHMi
X-Authority-Analysis: v=2.4 cv=Wsa+otfv c=1 sm=1 tr=0 ts=6aa3c2c8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aTdT7-qauowdluxQhbsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110123

Restore previous mqprio qdisc configuration if
tc_setup_dwmac510_mqprio() fails running the following configuration:

  $tc qdisc add dev eth0 root handle 1: mqprio queues 2@0 2@2
  $tc qdisc replace dev eth0 root handle 2: mqprio queues 2@0 2@2 fp E P

Propagate FPE preemption-class mapping errors in
tc_setup_dwmac510_mqprio() and tc_taprio_configure().

---
Changes in v3:
- Fix commit message.
- Rebase on top of net main branch.
- Add log in case of netif_set_real_num_tx_queues() failures in
  tc_setup_dwmac510_mqprio() error path.
- Link to v2: https://lore.kernel.org/r/20260909-stmmac-tc_setup_dwmac510_mqprio-error-path-v2-0-8158b8333b3d@oss.qualcomm.com

Changes in v2:
- Move stmmac_fpe_map_preemption_class macro definition in a dedicated
  patch.
- Improve commit message providing a configuration example.
- Link to v1: https://lore.kernel.org/r/20260903-stmmac-tc_setup_dwmac510_mqprio-error-path-v1-1-eb171bdd340a@oss.qualcomm.com

---
Lorenzo Bianconi (2):
      net: stmmac: propagate FPE preemption-class mapping errors
      net: stmmac: preserve real_num_tx_queues on mqprio setup failure

 drivers/net/ethernet/stmicro/stmmac/hwif.h      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 99 +++++++++++++++++--------
 2 files changed, 71 insertions(+), 30 deletions(-)
---
base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
change-id: 20260903-stmmac-tc_setup_dwmac510_mqprio-error-path-8d472a43d3f2

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

