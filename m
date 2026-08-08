Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F32205E02
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786200619; cv=none; b=lMKBpxfRfbLEac8UurOryyGePFGo3Lm6Y4Yj2KNiVACvtWU7aaspmUmyMBjPzzbARms386Dz5zjm4pw1kU61uDK8yV+Ka/STCPdTE3ohcbTI1GNoJXxOEUzMSxpyFp4/QVa5WrQ3fpE+2PQ34M+oNqvgviwpIiMslWORTjm8yYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786200619; c=relaxed/simple;
	bh=uffTL1iLfeSN0mSXcwWqs8mFbu2Jj4eVRmXqMTwxOcE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SQCI4vQ281wwPZ7JELcM7ikCNEYc5CB/MdIyrXxfw0YNvBLPPOUy4Yo507oOeyroasD67mkntV8AouY4jqyYK97Wbs0wilmA6DYy+nREUPUksFmrzPA2+80FhoXdpcIc24rEPKUzCQHcILsZxXCbBcVFqz9lKLfB2QJKhNOgsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JePiLFGZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RZXyRc9M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JePiLFGZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RZXyRc9M"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678DbVA04162437
	for <netdev@vger.kernel.org>; Sat, 8 Aug 2026 14:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eE6eUxpMqHxeuN+lR4AFDf
	3e/mtKNvxsFBwzQyNzYP8=; b=JePiLFGZdraW98aVdc0KoXxguK/o/qx1+w0GZU
	xy9zSnMGaqHKhVsJ7/KJEsN8AVGUvZ7HVNQ7mTTckAITDyxMyJ5o4p3ipgZH2FLe
	RjdkMgKqTID2Xe1MctzuVXVGWRpLAm37HLfSMPrpsuCbUsivVyoDVykFQ+EuidkJ
	uzKIdUVI1dZ5CldRw5gQsixPL0E/gDDP0ETslx54r17G/eBrCyU8lrNAgqaaV7j5
	dIQCDxiBD9nZNQy3lBwgyfavIOR6W435pvn0bcMJaYXk2Tf9s/QBx2btQbXVyjPS
	UsHYzm5kSA31hOI9w9oKV+XBDNZaee8epj7n1SC68uy30+5Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwstp1ceh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 14:50:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-526da7e3c9dso4547091cf.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786200616; x=1786805416; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eE6eUxpMqHxeuN+lR4AFDf3e/mtKNvxsFBwzQyNzYP8=;
        b=RZXyRc9M82q1YdjNNFBHkK5yYMkf5tcEFvfhLlz8WCKmOVfdJI3JiQC4VdwYp4rDAQ
         byLuyBcnl84q7pNuXI4p/gl6rk+7XT2ytQT3L/XSm98lLdzW/n0d5aAh9JiNrPZP2BHn
         dNfWRNe9jMBPAS3szctuUk3OfGKYiSWJjSMgLIqTiZlKsUItD/h7VIxiAMbAm0adHYxU
         g/0ujX9bBE0HGa6HHO90V1NCgSCX2M0F8DZNWVGz0yi5mvxU5y1YFQ81wYcoykKhOU//
         AAoCrQ6NFwIXvjObKuC/Pszl0WDXJW78ISAwI7B3DiCSHuo6hirbfGTLRw80Ah9HGTzt
         BRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786200616; x=1786805416;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eE6eUxpMqHxeuN+lR4AFDf3e/mtKNvxsFBwzQyNzYP8=;
        b=XC+Q73S3hbbtb7zMigLtqzSLPSxtMepP+pxXD8K95YnCtw7vuXaSUXzK+it2RpuQRv
         TrKNR4uySer5pseaMBH1qW6InOMBys/+X6oRS4JH8u46l7kTUZTfo1KrRFG4LP8GJQ/S
         AAZftC5tmWDJ/EYTgIWhIZSQ+Ii47NLwKNd1R3Y18ouHcFC2phrwpjJ+8s51Vd6cu/hu
         XdH3JQ7UyNYM1yzREAEsEy3pDtNNp0JmayEootR3jyw2ay8qNkEtdMJ/9uGqZtpElOaF
         dYv3EqlHYHpnrd8u53q4TaSBAxUcLfrygf/gZ2YJoB5UznKsMz4QUo3QRbyf+8oQr9TG
         ph2A==
X-Forwarded-Encrypted: i=1; AHgh+RoNFrBjQNSK4bmBQc7Ie9WijImBEuruaHpoRW496th3XVjvaUYmMuPO9LLHRICOsRxco3CXKSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdADVZWAdWOoUqOUC+fK432Yi+uYqcntEOxWXXzAKweBVwx6mS
	doi+vWOWUSri8m3IvOpju7cghEHS3EGNTh0Jthl1h2NZk91dsJ8lE23xY6/HXJwxhPJwhqEOVJq
	Vgfdw1KAC2c1wjE9ETryeBZmel3E9Zv3dH7igxm6c0wP9s8uvqMPlIShcB0g=
X-Gm-Gg: AR+sD13xTwPD7k3waMD5B2UnLWdxHCyZMs06Sif4ANSB5mbYMYyx2pcf66nB33wkS9W
	E3U/cPeSV8kffp0K3ITznKqiQc7B1OeelSmZe/3YEAKMEXuxGGP735yLnOa/qFB5TqO4T7tZ1E5
	GtCp/zL1B1VM5hVX0hHqIRJGOtNJnVtDlvY+McquTlFVmnKwxT053kJIz5aVCLqwRqde9T2ly70
	lDeYj7shzGmQRz/xajTevyBaTwGrGFLaxUN65NICLfeAAX9ziaN+Zk2i+boujCO+UDounNmL7AQ
	p0bpxfgvumEi9Y7f7KmPHxjHejPXAo0jFNRj30t6ptY2p7Z/VAzg6/+yIH6RBq+B528Lh/g/ssZ
	43gGl/7Lwqe/lkdA=
X-Received: by 2002:a05:622a:148c:b0:51c:52a:8e70 with SMTP id d75a77b69052e-52ce5f8237bmr315119891cf.2.1786200616255;
        Sat, 08 Aug 2026 07:50:16 -0700 (PDT)
X-Received: by 2002:a05:622a:148c:b0:51c:52a:8e70 with SMTP id d75a77b69052e-52ce5f8237bmr315119231cf.2.1786200615682;
        Sat, 08 Aug 2026 07:50:15 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021509a5sm14623982f8f.16.2026.08.08.07.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 07:50:14 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v3 0/3] Implement mqprio and ets qdisc offload in
 stmmac driver
Date: Sat, 08 Aug 2026 16:49:56 +0200
Message-Id: <20260808-stmmac-ets-offload-v3-0-b714466142b9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQrDIBAF4KsE152gppjYVe9RujD+NEKMrVpJC
 bl7xVUXoZuBx+N9s6Gog9URXZoNBZ1ttH4poTs1SE5ieWiwqmREMWV4wGeIyTkhQacI3pjZCwV
 S8o5Jzo0aCSrDZ9DGrhW9oUUnWPSa0L00k43Jh0/9lknt/8GZAAHTCcwJ44rS8epjbF9vMUvvX
 FtOVTP9lfpDiQIGLiTrheFUjsOBtO/7FyaHU3MPAQAA
X-Change-ID: 20260804-stmmac-ets-offload-cc936c99fdb1
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Daniel Thompson <daniel@riscstar.com>, Alex Elder <elder@riscstar.com>,
        Davide Caratti <dcaratti@redhat.com>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: DBcstsOq1U6XB7UN2g-ZRwqtqx7kWl93
X-Proofpoint-ORIG-GUID: DBcstsOq1U6XB7UN2g-ZRwqtqx7kWl93
X-Authority-Analysis: v=2.4 cv=CMEamxrD c=1 sm=1 tr=0 ts=6a774228 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=petc-e2FbpDzYRbdd-oA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDEyNyBTYWx0ZWRfX2A0DHLlaGUzA
 R2JJey4qJoUpjFiPCTLXO3GPtdMy5LqAUtKwAwYYc/UmR7hEHbYhv5CAqJXVa2rLAQ7sUWODHNq
 X3C6RxXBZ3NzeNRIQ3wLZv//e/xK9/dXAwtMMwNjOSCXuNoaQTkFM/a3NFqf4vcmPfGx3gfD6HT
 dEO69UAHgFcOTsaw4MnieOJAh05g+9EPYZ0Q1LPtk911WCyzQ8k2PDDizCL5TrAp0XpYIQswjv8
 Mem6+rhwaxTvuXlMNjlwvItm8311pKRdvgF5Kq3PV6VzSLhXotU46bKSXeuubcs1AJgNKDBl3oY
 LvLYXn6DBLsN3uobczcYldRjRoxQOmJD55N80DjDFeQNMLx4IQZwn+LWRqFu2D0s1/n/h4o3ePC
 PhEinp7jXBfA7jCAtH5B2LmOzNpFD4AbV2HCtcH+z6z2iCcdHL5NpaO4tAIwff7JzhZGmwuyLn9
 Tkn+9XDeQbfAM3Z5fIg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDEyNyBTYWx0ZWRfXxqAvKueoRbPx
 Iz4DWq5hKUVyHjgxMI5vr0j2+/NAmwDXFEq+0DjjiOJ7xuyja6+4vwV79jxTCs7hE6cvLbAZRqN
 tKF5I1pBC/FuuE7/E1YSmPe2kaEWlic=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608080127


---
Changes in v3:
- Limit number of tx queues to ETS bands enabling ETS qdisc offload.
- Do not overwrite previosuly configured qdisc if ETS offloading fails.
- Check dcb DMA capability before programming the sched registers.
- Always power-on the device before applying qdisc offload configuration
- Fix priority applied for SP tx queues.
- Link to v2: https://lore.kernel.org/r/20260807-stmmac-ets-offload-v2-0-9ac67af92cb8@oss.qualcomm.com

Changes in v2:
- Implement strict priority policy in mqprio qdisc offload
- Restore to dt configured values destroying the qdisc
- Do not ets offload if there are any queues in avb mode.
- Re-apply ETS configuration closing/opening the net_device.
- Link to v1: https://lore.kernel.org/r/20260804-stmmac-ets-offload-v1-1-f3a09169d22b@oss.qualcomm.com

---
Lorenzo Bianconi (3):
      net: stmmac: add tc-ets qdisc offload
      net: stmmac: add tc-mqprio qdisc offload
      net: stmmac: hold runtime PM reference in setup_tc

 drivers/net/ethernet/stmicro/stmmac/hwif.h        |   4 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  10 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_fpe.c  |  20 ++-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  86 +++++++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 159 +++++++++++++++++++++-
 5 files changed, 251 insertions(+), 28 deletions(-)
---
base-commit: 8ac4255c1e0c83d2e1559a18b8918673116fc8d6
change-id: 20260804-stmmac-ets-offload-cc936c99fdb1

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

