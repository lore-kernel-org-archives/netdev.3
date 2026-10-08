Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4484D9543
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471115; cv=none; b=BBS6eMikIBkJKxvaiHulbx4dgpbWSJ6q0rgGFAIRnmubE7dHkETrDD1iwzYT2zryPStUxwyt5JyYiy9ZtNwYt5VG95wEsz335ZqIr9wqn5wrj2t5kpwRjZd4dA5mrUq930ZJX8m4c+mYtsPb3Cjn2aCtjHWf8mngFuuiILb1IQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471115; c=relaxed/simple;
	bh=xAlGA9ZWS04KIS+benLm+w2ukxp8v4ZDhslbugqb1fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t0ZzwJgVNiqPosS2sCXUu1wFy8xH5kKsr3O7w01BcbZbfqmLjCJldeP2xPwq60jS4ynujJiUOzxRcVLWlTNe/q6GUPI4gk6yOSU9L/LT5jBsRSJQRICFOF1lL+ZK/kpnuICuEL/KoVWub65hG/ybVccjDF+5iE6xZHxrdYuvXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M9eKl15O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kNvvMEcW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M9eKl15O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kNvvMEcW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EVW373018355
	for <netdev@vger.kernel.org>; Thu, 8 Oct 2026 14:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YlDcZg0BQE5duZulU+ElFFqS4rkCwqS++//cDsA6uqk=; b=M9eKl15ODcR90CcJ
	jF+S5h2v85vXLm2S7D78vA3hvC3ETJl58ZW/dwTQxCsXPPl/TPzpYx8Cs/rxbBOh
	cVUMBpM+GYAmMFDxVAhViBtAXRrNqQBQOr2A55WR7EJyDEAlSSHBH7mNp4lOO8O1
	tRc/ZdzkDZf+kvjilkaVteDQBgufcwdvjpzSrgRWNE2UNzXLlAxAyOc3etnLQfCk
	h05VUUXW7ue5+J/3KZ8A3Ex8i+XeZLqw22a9M0dFp8WvQlaUHnM1+wxhgMgQKrpe
	9C9Kx7aBJvhonehMyyB071bZ9z0y+h+av0ru00/nvBIrTzlWTfiio3Az/fEeZcTY
	9XCFdQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6b9kggh7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:51:43 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-8ab43f7f5faso80582567b3.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791471103; x=1792075903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YlDcZg0BQE5duZulU+ElFFqS4rkCwqS++//cDsA6uqk=;
        b=kNvvMEcWKXusk2CNJmL/T5zcMZbhRhMJwMfwlF+jJ+Db9a98V6mx4abydvnhVaj8Bs
         lc7PIM8eMS3m50USQZGrm5YxTR5HYdafIiVzCDepBTp+8A43xfmGNts3Bj2ZPAU92Ujc
         LD7pNW9YbNMCe3cOKp8Xu07Q5B6IEncQvfM26HPtpfU/9wYbOumE4zZ3fG5PuKJAYq2h
         zpkQTrknFEJBJd/pFiTouSW1fmLtv+dlzrjX3P56IonOLgMjf7AONu9Z+KBiqKEJh/H7
         5Co6aLUrs11yfe+Halhu3H3M4lIRY6xXSPz9NFl0MEpdaJj8bI7pYRUV/zuVMUogVSZD
         +UQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791471103; x=1792075903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YlDcZg0BQE5duZulU+ElFFqS4rkCwqS++//cDsA6uqk=;
        b=tglUnHByL5/5KtsHQh+YW7mfmlmC8btNBM85gwClprz8wqUkFjrzKQiLj66nHS0sot
         DKuEfXeP7zsdiV1atGPWuEkCkhfII1izDHMdM7vbwl4YOmSYBVYWS5VP++DRHTs2wXdj
         8FVSfU/kwuesIS4BjmBAEJjvrMTCUxMzCXifLQmPAdcIeTFNNl8BSxGoUaXyMtCzHCG3
         xyU5CErWU/GLdbqQYYZ2rcpEYT+xcamIRs8wsxMURjGD1eZ7nuz3G7xhMr1QQh9tMcPB
         7CZ0tF7Toxq7zrM4kPNKt+6QRwlFctE7Ky6wk91f483XyBpll5nfAqXDwIInVgQtpCjQ
         d55Q==
X-Gm-Message-State: AFq9FYLnkRg4NLTeQiKKCo0qNph4k+ZEORMCly6uoLZGD3N8hBJPWzZA
	s5IIqPDCrThAbXL+pmkLTPVRIwwwjZQVNDWumGGp37e9lN1KuVzMfc6Z2ZT23VRjTD/rqQSIEQk
	1Wfq0uIsTn41gYRUePF2UOKYiGwC16UNUpiFmdalHB6bjk5AIJDLzrXsajeM=
X-Gm-Gg: AYBFou0a5vImXQDhZeppH3d5U8kHdMGnAD/IuRNdTVF6bEmSj7/qLC/IXazkO2f242b
	Cae57zdYnIBlOh7q0uVpZluGVwweSB6jiRHHFwTgYUhK5xFETlbU6s5Kieo69hg32t3IiAot85G
	DXEiCrXf+xHH/oRTxRI9W3SxDVjuKTPvRgybPG4isCAJrGRiyDc2V5Tlc+5rB0h4idVfJJbSFa8
	czlXNsqBdekb/v6Jew6v5jtQj+eXoHT30EhZpKn0wzjV0MpcG/y5dqy/nbc5gNkwb0QQrTHh9ch
	EIJW5DOQUejxviuBZRLlwZM0H8w513VwosxjBrtdATvgwBxNcZtxnjhsHNt5z24sKWNNvULpy0y
	KOlNeQJlpcCmRyOL4W2swFm/Y3CLp0X85V3LVWhRUwEM=
X-Received: by 2002:a05:690c:4990:b0:8af:1cb6:30ac with SMTP id 00721157ae682-8b05b11f8bfmr27029347b3.67.1791471102411;
        Thu, 08 Oct 2026 07:51:42 -0700 (PDT)
X-Received: by 2002:a05:690c:4990:b0:8af:1cb6:30ac with SMTP id 00721157ae682-8b05b11f8bfmr27029047b3.67.1791471101695;
        Thu, 08 Oct 2026 07:51:41 -0700 (PDT)
Received: from hu-luoj-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b05ab62607sm20903407b3.22.2026.10.08.07.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 07:51:41 -0700 (PDT)
From: Luo Jie <jie.luo@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 07:51:34 -0700
Subject: [PATCH net-next 02/11] net: ethernet: qualcomm: ppe: Fix multicast
 queue config table index
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-qcom_ipq5424_ppe-v1-2-16caf43e44ee@oss.qualcomm.com>
References: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee@oss.qualcomm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>,
        Suruchi Agarwal <quic_suruchia@quicinc.com>,
        Pavithra R <quic_pavir@quicinc.com>, Simon Horman <horms@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, Luo Jie <jie.luo@oss.qualcomm.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791471094; l=1654;
 i=jie.luo@oss.qualcomm.com; s=20251128; h=from:subject:message-id;
 bh=xAlGA9ZWS04KIS+benLm+w2ukxp8v4ZDhslbugqb1fc=;
 b=WicTMr9iqzpLFpADMxM3B1i1JoCHa5f6Q4Jv7FB5145K/jZ6oRw1Ol3h1kdvkkJDLfq+Xmdzs
 s+fAOlPbvx1CvSYzhB9uZbBCa4NJR7YNVBPbBSCBqH8VUgtY93rdtM2
X-Developer-Key: i=jie.luo@oss.qualcomm.com; a=ed25519;
 pk=gSsYMDakxtd6UDFYDdA9y9yjIs5Etp5GK/3DoXWPyS0=
X-Proofpoint-ORIG-GUID: uyiOmfN5sj7f89KZj5PII4xxn362fwtK
X-Authority-Analysis: v=2.4 cv=U98Hnuru c=1 sm=1 tr=0 ts=6ac7adff cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=mx8D-BtPiHKBULbPJ0MA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1OSBTYWx0ZWRfX1qAULxVpl53a
 3R0cJdsTCbj/9SlFv0X7RqO8Ep0rTNg9quxwpAvPZD5ObW6osRmoztp76twSgBFBpNnmtM27emX
 TrkGEBRyrZ6xe+vZY/XPP1HIgd1mDc0=
X-Proofpoint-GUID: uyiOmfN5sj7f89KZj5PII4xxn362fwtK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1OSBTYWx0ZWRfX/DCKGJCSgIiX
 xS5GHjDmJdgc5wf6Ubprzw8Q6Te4mikh7Pb/TBysTiKt7DjaXr+gkzK3XskzpYogfFL6rf7iOjf
 s8VG4dEPXMi7RiHIvUNjMPdZLi9QsovJx6FcbY5iomlh9yagOwKG/PS3/qYVGmRbaVB5vwor2bx
 OK1mC/duG0Scl01UJkRG7DqCdsPRjB5ADWEyJ0oDgtJ8r0m/8awWxTcJJZm88mXgjbMk+DqMrpe
 Qwig9JFBVTSzDYMx2ntgfPjRQzU3ReRM3JFWGJpWZu/KFYC1GHH5P8uHbPOwWopbEOCCNFObplf
 HTfMxvJGi7mb6Q+rFjUF3byNZ9lgqcZElqyXjOyNwWDKtYPBk7uxMV/GuKlANwORnHouNKrVlGw
 3XEYI9LHORrDWl+HBAk8afSE1+LDg53U1/4OXayBjN8omlCoLQtpX72VmHeZdK2rOHHR7mGpH5Z
 uf/WucNquDCEqDU9qYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1011 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080059

PPE queues 0-255 are unicast queues and queues from 256 onwards are
multicast queues. The multicast queue configuration table has its own
index, starting from 0 for the first multicast queue.

The driver uses the absolute queue ID as the index of this table, which
is out of range for every multicast queue. As a result, the multicast
queue thresholds are never configured, and unrelated QM registers are
written instead.

Fix it by converting the queue ID to the index of the multicast queue
configuration table.

Fixes: 806268dc7efd ("net: ethernet: qualcomm: Initialize PPE queue management for IPQ9574")
Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe_config.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
index 125b73be92b1..8a553902ffad 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
@@ -1530,8 +1530,13 @@ static int ppe_config_qm(struct ppe_device *ppe_dev)
 				if (ret)
 					goto qm_config_fail;
 			} else {
+				/* The multicast queue table is indexed from 0 for
+				 * the first multicast queue, which follows the
+				 * unicast queues.
+				 */
 				reg = PPE_AC_MULTICAST_QUEUE_CFG_TBL_ADDR +
-				      PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC * queue_id;
+				      PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC *
+				      (queue_id - PPE_AC_UNICAST_QUEUE_CFG_TBL_ENTRIES);
 
 				ret = regmap_bulk_read(ppe_dev->regmap, reg,
 						       multicast_queue_cfg,

-- 
2.43.0

