Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D5D37C90B
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786092137; cv=none; b=bUtgjG6oSHGqOUngwXKw1sGAK/m4r7Sc42UkFuTw9iBtQCpLzGieepY6L8FHq+BXzhpXgmgLqcad1zopzemsO1DWyKYlYSNTQDyaNoxBlak2hOBwomdDsWDn4eLZBJ5SobNPGQnuV5dtbnZtTRS99XzRTsnCU+shadS73aT+LUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786092137; c=relaxed/simple;
	bh=JJbKHRPYYFaDN0B+sW7f/QQtgWD2R8JVIF7zvd+Yz5M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ber+rAO5GjI/PhvTBYy2KEQY7D7v4sLWGm0KN9A8KIFX8BuEMhGY2lh9b8NmPL4Kie4mByq3lo3TKK50AMTIRZdwkjMw4ubmf3+fnXbXCgrpbjGFRjXiZ5t4SYTGdycYcKb5nwJHVxH3AZrIQ48LoxNg6mNm1dDLoawKwsnsVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JMWoD4mp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rj/WywQQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JMWoD4mp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rj/WywQQ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777vg0s3218076
	for <netdev@vger.kernel.org>; Fri, 7 Aug 2026 08:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=J4IsFEeTpVt60tPxwz78Yv
	mFb7VqMsV3+47tRUOw49M=; b=JMWoD4mp2izJ2WK/bfj07tP/gIkvUi7iz7F6K4
	RrSpug1OPLUEIjFa3UppKFZybBHpxeMdik4agXgcL6BzSEuwvBROlYkTNhl1QAYy
	XESt0pxhsEuipl2pMe7GE6iekrchbQffqSdRjSwvDt5SdGZjFaVWyZfIuJ+MAfxo
	C4aKNQemxBE+mZRAi8PtLy6/cVjNxt07dOy6MloYowg5i269Nx8TyCfTzzNXX8Wt
	2KY6iaVnPdZ7QykGacOibDBO16z8y0XNQQNg+GwrVqam4WPmdldx2ec0c+zGIqmT
	p7jQqYaNigVsfE40KM+BhlZ2BTNDQz2Tq/EsRdwPneCraYPQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6hu18a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 08:42:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9309af14fd7so298783985a.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 01:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786092130; x=1786696930; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J4IsFEeTpVt60tPxwz78YvmFb7VqMsV3+47tRUOw49M=;
        b=Rj/WywQQL9R1n5OyOSUkp+xMxqaJCRY03c6ujsZ1+y/5NnIMbdbxLt4CGxpev7QzUt
         bwwicn683SBekHVHtrqSgZDhhKtUWWysqVFgRQnrkTewcvrGRhRcbCfLIUYZ40/hSXWf
         R49lUmygcTtCRhT4lLb7qtY5+8TSJQ1d2AkVbuaCA1wj0IrBYmXpzIh1RehmrjfFdQd2
         /aePb1+uE4p1PWnF9ATIFh9fEJZkbBNq7F4aIu9bhAqSiaPWXzp12N89TPNDYmxnAect
         cwT2OJISpXo1UNglAt03fMrd1RHSJQFPRCTDsECwBGzuiyql+ebp0ij94Bi9Q4PgW3dW
         yr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786092130; x=1786696930;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J4IsFEeTpVt60tPxwz78YvmFb7VqMsV3+47tRUOw49M=;
        b=ex6AJLAgVbk4TOxj8wpHEoXyTyoEpasxXQNrqODmWS9yJmkDo28fjuEgLJTXTR4WNF
         TeCPJiKmEv3EW2jQc6boj2AHk+hc9F7uSpcq5ClILm+Il1JBNwL5Jw3bLMZ00Psmuxhd
         0bixa6PTdf3P1/K2qWu0xuxe560Zj4PCERonDV/fqE86MRqoHpgOKyVujCUPNWowgbgl
         +w7nKifMTIe9XwPzfZeNfGbpU57DyhC4plS9LIAGnxmnMKBf/e5LgikS9YsKL9Fs+RZw
         8EFYyqqyfaVu7wu19NDYq6wvXFoEvEEMBCCelkf4Pa0eEL1/D6TgsJHSpiHVs9/DqpZY
         flaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrBGNbdPXiuad+BUrzK4lFxZ8TV0hx5NWzmPeH+KRsOvjiKQTB+WRR+s8sg/BDJWqnvaVVVis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpculXyeOm98xtRsnndEaP5gMzq8FUaa+pqy7HZrA8OScftFL+
	eb3J3qZheYP4oWvCln5clEPdoSq+wccDKVVccJi7YSZPDpkzlbN2D9+SfZgNDcKKMwGnaTH0HYt
	iZaGIb3SaUrxKA4OyfywKU0rbtVLhjFknt9tUofUi+nS89a50UoU8PDW5wFA=
X-Gm-Gg: AR+sD1154SE1uqvybFq1cJrd2d4oSKd8Lpd+D9Ttk4gvcR0C9Bs2HQ4awUEhs1pVhq6
	iRbd118j1b4vUazuXCmwsA4a+/KoA8GAxbdfA8JwFkw53ajw3W5Pkp+gUSHNjQupWLw7a+ofDp2
	zsoIc+LKT9ag8Sk9z/KZwR+pmBoYh11YK2MM/uptyKtZHQ6goxw43OBe9vVRJJl7oUKLVOk4Of9
	kDSNh8p+nMkS9NlVRLB3Z6Q5eiYc/U3/tRUGt4e9WTz+TA50/zuoQmSjko1AuwcaTsiOCsFr0RF
	bYC1NwpHttwdLAZPlEED65Zgy4T0XMK7yYRbUckpiMViUvB8wZOg+BzZmae2V6vo9PQ+uZ2/RSN
	lcw7J1GQww+yTWv8=
X-Received: by 2002:a05:622a:1820:b0:51c:963:cafc with SMTP id d75a77b69052e-52ce61e1e39mr210588421cf.41.1786092129679;
        Fri, 07 Aug 2026 01:42:09 -0700 (PDT)
X-Received: by 2002:a05:622a:1820:b0:51c:963:cafc with SMTP id d75a77b69052e-52ce61e1e39mr210588091cf.41.1786092129238;
        Fri, 07 Aug 2026 01:42:09 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995420cb4esm126033935e9.2.2026.08.07.01.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:42:08 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Subject: [PATCH net-next v2 0/2] Implement mqprio and ets qdisc offload in
 stmmac driver
Date: Fri, 07 Aug 2026 10:41:38 +0200
Message-Id: <20260807-stmmac-ets-offload-v2-0-9ac67af92cb8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQrCMBBFryKzdkqSSjGuvId0kSYTG2gazcRSK
 b27oQdw8+Hx+e9vwJQDMdxOG2RaAoc0V1DnE9jRzE/C4CqDEqoTV3FBLjEai1QYk/dTMg6t1W1
 ntfZukFCHr0w+rIf0ATMVnGkt0NdmDFxS/h5vizz6f+JFokTfGqFlp51Swz0xN++PmWyKsakB/
 b7vPxYW4f3FAAAA
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NCBTYWx0ZWRfX9wStLOjkcnS6
 WpPqmMI8YJTXtCD2avQVpjYuNQFZTtgMf9yIB8CUTFt3ZJt8d/s/A/S87gLIDP72k0QpCJC6kmp
 7+/4Go/72gH1bgCfWptmv4u3JhlaWcQ=
X-Authority-Analysis: v=2.4 cv=PK0/P/qC c=1 sm=1 tr=0 ts=6a759a62 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FsjTgQVixRrW3wEsH18A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NCBTYWx0ZWRfXytghnZUAnaOd
 Tb3dwM5nswk6js0IuXNdcCMpF4Xul79CmgWcjqhYbeHiJO16uzWR8U+C4FRwjRu1CH3k9uw540y
 HiNNW3odRh3gBYDdJblc0KZVMPoGdb8wW5+yu5Y7FPvgXrBeoM42c/GtLyGPxWNhYAcGlBsLB6m
 yDKdMGgNONeg47bQg+maXDJEKj7yiW6+yfEzha2g2ZiVuzERFE7lAWUlmApcchSm5XpvmCzRhOL
 Jw+1m4OBQ1M+e23WPMNdWUD68CH1r6NHG8vW1FYt4HolBDE2ESmdMk3ucQyEAL6wagbiir4aVJj
 AYh7FNLIla6aZuMJCmmARAO6Bw7SDblsvCk0cZ28i0w84mOX/m35j4dSvzaQaSvcx9dtzhd252l
 sLcbOHigFKUAW0r9ykQ6x5r55ZhBtsu3RM4Hs11idwmpEvqgMsmWEcIDHHfKqC4Udu1ds9SsDh9
 zGHU+oXbA8Y8gPALyvw==
X-Proofpoint-GUID: hZPX8GgGkXYQinAJv5hj6Wg3HDmfM5bO
X-Proofpoint-ORIG-GUID: hZPX8GgGkXYQinAJv5hj6Wg3HDmfM5bO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070064


---
Changes in v2:
- Implement strict priority policy in mqprio qdisc offload
- Restore to dt configured values destroying the qdisc
- Do not ets offload if there are any queues in avb mode.
- Re-apply ETS configuration closing/opening the net_device.
- Link to v1: https://lore.kernel.org/r/20260804-stmmac-ets-offload-v1-1-f3a09169d22b@oss.qualcomm.com

---
Lorenzo Bianconi (2):
      net: stmmac: add tc-ets qdisc offload
      net: stmmac: add tc-mqprio qdisc offload

 drivers/net/ethernet/stmicro/stmmac/hwif.h        |   4 +
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |   8 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c |  35 +++++---
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c   | 100 +++++++++++++++++++++-
 4 files changed, 136 insertions(+), 11 deletions(-)
---
base-commit: b0057c68df711bf6a62033c072ac61c4f9d3cbc1
change-id: 20260804-stmmac-ets-offload-cc936c99fdb1

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

