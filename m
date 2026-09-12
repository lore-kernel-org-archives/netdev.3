Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9BF3C584E
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789247838; cv=none; b=kpsMpl9kc2ILKuh69N3dfSbDzQ6lNXTRxy3JlMovPPXgeAxVBFFCR9wccuk7u/IaI2SWk9h6sznYF+ct21fBqhcbmwPb/SSqSbL3yU11FhjAEm/KFJTQWasEZfv1+lXc09t8BN543giHXJWUlT2ACfYWSH3qBgQdIHVbkwzO9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789247838; c=relaxed/simple;
	bh=LepYv14wccf0AuC0QMqyI7J+GISB3wJsJT6g7U3+gk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rUMPJewWgnxwR1H8rBCWH09xTvGrbNRaUEHienztd99VcOiBqPJyAjvY3bVt1t80rqjfwGm5fzIuV+3UlcAFvIFZNBa1SLJF4F0Z4lgIYtLOA5Nk2jNGe0+xbbzLtJatCxDzIzfjvt0xEzAJIISUbDRosVpOKceuYWJx+lwzhOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WKr5pMx4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CFhh6zou; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WKr5pMx4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CFhh6zou"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68CI4cfP060289
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 21:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uLLbPlKs0eaia0hhi+j+T5
	BP0erZ1UFOrHpPsEsvnYA=; b=WKr5pMx4oqJuMQzKdl3Zf58VxP5VlSkg03WAHw
	rFNpxNzm0F+9V9qV6DXDAcR0sR9abAowCmU6P06/4Ls/SiCM19PBn/ihv5Tfr7BV
	c3b29C96z+F6KRz71br4npGvg6rteaR9Ohxsob0+aN2gjXURYmG42L/RBiNhqckj
	+WDN2As+lsn9DQJ7zd1037WVqKzldhR6R0NrmGy5/0aAeItrZ9NzS2F6S+fYG6cX
	kJ3J5ZDLoPx1XYpZ/rkvKOiAoQxZ1SzSGrrYcg0QfForuYD3XpGiDql09GRPX94J
	9qErcCESUerW7yeA/13/qxmQar964MC8BMpMhDqaqRJa5Zyw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dhxeb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 21:17:13 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9103f4ddce5so24427106d6.3
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789247827; x=1789852627; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uLLbPlKs0eaia0hhi+j+T5BP0erZ1UFOrHpPsEsvnYA=;
        b=CFhh6zouLrt6AaPy2CZCI2hNpsQVl1j5bOeQrK3N3e+TC5YQurbPTWNAGDVAMQYWyG
         mPThcGCyoiONDxadE3o7mJ/zY3CgnkZtPQxaqzSfTJqrdC8+LzASYvh06aBzPWXzqIJq
         oepgvHJPq3IBNW+J2kFrvq9O28FKUycEfUlAF64dHNWF2jWX+KnsbuLY4HZLcQXlO9/C
         /YrYHqN5hhJZ0y26pJ2y+1C3rbKVoqDcRsFLLI8rqr3rE8volFiGWcbcp8tgmOPycOtC
         foCdejO7xgQXMXpzAi2KqYMiddwBRbqmEYKAPE5TrnPY8MHJjItvFmwsLZXt7N66+rxY
         RrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789247827; x=1789852627;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=uLLbPlKs0eaia0hhi+j+T5BP0erZ1UFOrHpPsEsvnYA=;
        b=ikOC8o5yTjUK7PeZkg/FF61/MOmrGVWNnlO6IyU0aNqpbyDLO0+GwKGRHj9ZjM1czm
         LZ8bznzfCUbXzP2DPH/mfVh28XN1xav9p+Xm9qIZNvxLpa1rKqY0g9q25+zAJb2gCIE3
         j18DKqSMlAnN9ov8t0xIGzY4V0lMxH45e9IBxbw5zQ/D6nh2u7e/nl2Zb+PYZCc86B6B
         CA8ugpClOnewKDbvn/4pZBTR/b7nJSdLc1EODbvXT3ZfRb1OMsuTaJw68V3CIfX88PN0
         T3jlNY4UKWigkPMUB6zIJ/wkkcpku+b/ItTTn28mMWiGgd3TAGzoZZ8cCmut7/7ebSe9
         S0Ng==
X-Gm-Message-State: AFuF++khJuvLCkjhUlsIqMQGPmxl7Z17VsCGmXiqEGELMFYpaGkBT9Tq
	v0oJluctH6IqeLwCnKDw/WTj+T6DasWrNUaggA9+5A/s994CIMvmULA99Pj57S301yd0Z775m93
	IrdD5m9Xd34+whC5C3lXSCRan98FcXN6VzrYp2FQRkl0DwZIZhaXPWnNekG0=
X-Gm-Gg: AYBFou3PXgh33bEdO8W/CVLn5Nvj9c92DdpyRXS0y9m4yLl/mCRFoHrW0s2WQo0IxTn
	xX4ExmWOIsfO13AOrkav5tYz3Z98MBQYfqnEk3L4OW1Z4buMyvjvvUStkYdPR455Tt/rPS6+CNO
	jzAMTuSUBrhmWLSCPr+fZE2SOUDrjWX5/RFtCU35la7FuxqpRbBzWjQPHUuXaHk4dosltJjujea
	5g04btEpellS4VWLQrgGez44MF76mxda+VG3EXV7OWiu14pq2igiIHkBpcLCu7BulFsAn1FuptZ
	gvezu3VAMjaLR6gt0r0dJrJRUjfVshAcsg/kZGdvXzQ82XsHD/AG3+4FohUzymEF6CTrmGq/5R7
	qVAeIumylgN2paw==
X-Received: by 2002:a05:620a:298a:b0:93a:824:ac8d with SMTP id af79cd13be357-93a0824ae72mr586288085a.27.1789247827497;
        Sat, 12 Sep 2026 14:17:07 -0700 (PDT)
X-Received: by 2002:a05:620a:298a:b0:93a:824:ac8d with SMTP id af79cd13be357-93a0824ae72mr586281685a.27.1789247826890;
        Sat, 12 Sep 2026 14:17:06 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c2985dsm454971865e9.6.2026.09.12.14.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 14:17:05 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Sat, 12 Sep 2026 23:16:24 +0200
Subject: [PATCH net] net: stmmac: report phc_index as -1 when no PTP clock
 is registered
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-stmmac-fix-phc_index-v1-1-26e1ead25324@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAMBDEviJ7dqHtQdGviIiuo+7BKq2IUPy7x
 WMgSaKIoIjUFokCbo16+Ay2LEi20a9gnTOTM64yjXUcr30fhRd9+NxkUD/jYYtpsY0ITF1RTs+
 ALPzbjjwu6t/3A40yBohrAAAA
X-Change-ID: 20260912-stmmac-fix-phc_index-1ebf19cce076
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Gal Pressman <gal@nvidia.com>,
        Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Carolina Jubran <cjubran@nvidia.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: -Rst_0CY_nbMStnUeMXFv3FqqMkHqQ5J
X-Proofpoint-ORIG-GUID: -Rst_0CY_nbMStnUeMXFv3FqqMkHqQ5J
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa5c159 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=N7w_mUtDbW-LDaCnSHMA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDMxMCBTYWx0ZWRfXxJnVk3vstkS3
 b4Tdpwzd6Xh5v2zdT8JClRE6fWlvkrNRiRobzXht2TyqUiL8xq9270n6qMeZ9VtJqCgUvx0rzE4
 bor5f0mE/vgRvea1wHx7bK+0D41scA4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDMxMCBTYWx0ZWRfX341M7Oa0Hj1C
 WiE5pMnSGvGumVLmi4ar9j0RadRu/KoawL/Nj1SPxoAMWWKtT0flSzWo7eNU8s4BvvnHuL/VSBe
 D7anRzsDJV4mUyQEpzYsRcvoCJD2jLKkdOMW3sBlAb7T7QDS8hWWONW+pe/MVcVLr57L2bytyh1
 i9LGu1tjegp/VLuHlx//fVTTenerc6UWKCyr87fOOj3vns+jQfLdu39PyTE/OqI0/0Jg/DFVngS
 vvWDRJuyUZbSuQM35A5o6g9YOh0C2trKVOBiXpuXTf3O15/tDZwiXq+wehNIzh8fkkDyG9Mly1b
 Jxhfj/D8tWBoDifIuxx3Babqwr9JW/QxFq26ZFbPiej0gAoXGX6/nKF/a3ZI2JJVFZPawt2qS31
 E1Izz/r8TU2o4UG32oh88AnZZbOeBmKo5Zfy3ilb2+p1QhXJPi+XTfa++0nd5UG64fZUlndDXwc
 S6BqnsLJmgue7KOVc1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120310

When hardware timestamping is supported but no PTP clock has been
registered yet (e.g. while the interface is down), stmmac_get_ts_info()
currently reports phc_index as 0. Zero is a valid PHC index and would
make userspace resolve the wrong clock; the absence of a clock should
be reported as -1, matching ethtool_init_tsinfo() and
ethtool_op_get_ts_info().

Report -1 when no PTP clock is available.

Fixes: 9364fa7fcf12 ("net: stmmac: Remove setting of RX software timestamp")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 154cc0c7623d..eced707131cd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1017,7 +1017,7 @@ static int stmmac_get_ts_info(struct net_device *dev,
 		if (priv->ptp_clock)
 			info->phc_index = ptp_clock_index(priv->ptp_clock);
 		else
-			info->phc_index = 0;
+			info->phc_index = -1;
 
 		info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
 

---
base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
change-id: 20260912-stmmac-fix-phc_index-1ebf19cce076

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

