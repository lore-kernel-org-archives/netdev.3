Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7113EC829
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789371686; cv=none; b=Wh48MUwCNcpEICIMZiHdvP3r5nHiBWZO/N3KzU6afzxSosHQBVHp8hP8opDdph4mIl2ELIq6tk1RDL5y4NNauoiouFy6JRu1OJSS0dagN4YAPhzHsdOWc+N/Y7YRoUVWJoEwKX+M+D9QW0VR5KHC/5sNV1QwauYJlZSfzUlrSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789371686; c=relaxed/simple;
	bh=u7kRmIpSqzj+KSXk3RS4cDon/AOzeRRS/sEoZvHnGvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cJNK/O4/Des23jr8Mr0O7d1gP9ax7aYUYg2yJ1OSkf1RKkhinSZLPJwSEVAvMVfhbWzuSrM/3PGDbBnvv5bmoW+rwVuPPLkSxx2P90GMybv0RgPK90j5brk/6Kgp/Wugsd6OJO88CoVSeZkZo+guVA85rZGOdJ1DR5OdljTHL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IR/lnCNb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ASwKX/4m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IR/lnCNb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ASwKX/4m"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5ikap3901085
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:41:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AkCHfC41wPyIPhNPVFyOA6
	2GFwV2gjFvUh4M3ly7uws=; b=IR/lnCNb+Z5gL/js+SLokR57BNDv2zkYuxQCro
	K1zGpAsoxG891Kd5fODtxDP761szeAz33WfQHhkZdpk/9G0ti5wMGPPIiDiJENpu
	OqjG1gL0pozmJ6Mrl3pJx5BMMYWePjXlN3wi46O5ke3hX/TMiYM+pPkLAG65eNuM
	t55lxTz/zEKgUOzAFoh+XTMZ+5NtuuXt22zzcxD3Jfu4pKEql0qfiWUXemzkSS4o
	T8di/A5GL6bV/oVx7QkTiA4wWTb7kCuD+e0LkFf9AP4ijO91uLV8SIxo2hzH8nwP
	T9nAYjuLSaUTevTwW7yriTDdhnp4CUE1fX4LvVxjSBrSMEIQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9d5hsu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 07:41:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9104eedb5b0so61553266d6.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 00:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789371683; x=1789976483; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AkCHfC41wPyIPhNPVFyOA62GFwV2gjFvUh4M3ly7uws=;
        b=ASwKX/4m9KZYj+S7nxuwixsvhArgUZSTDZbGsKij4Z8xdDZWhz1a5C9L7WFVzEVtl6
         lRXtJqwqNMX7Y04PfZ4hG2jAHo5OLh7B2s57Y+N/o0nKEOz53lf/b2M15QM/gBFvyPry
         efxZXPNoWjCvG13Z1uPbLdZJKzKn7OIWjM1upJ698wPg5XpSk5Zfp6oaKOZlbLUQUnZo
         RqIo6zflWXKiI9MLHX/7cow2ncxggoAnGobcfrZLFxNmwupq/6y91C/m02HvT1KTUPiI
         OXgoC8GKiz/xVEe7Wq6GnW5RIYQMZ5lw12PrXCDooZtTuo55lxm1sit65k40fPNjslyK
         JnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789371683; x=1789976483;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AkCHfC41wPyIPhNPVFyOA62GFwV2gjFvUh4M3ly7uws=;
        b=N0FL3chXSp0umJ3KGcDLVt8bU5qJ9uvVFiw/pajcoYVz8l3cwRUBr2SCDfjcDf1tQ/
         CpBvNGZlJAW+NYaldEDPZZQBQbUhL/h9YXpS2NmNrrbjdiVOSQSg1jKkyuwFV6ovAM4N
         KRB0cHKj16p8WZ1CFkcE2gKTsr7r/uY1HtnAgqmjrXcCk66+qXsJrOcq7V2OusBqThg1
         VHFoxbSh45o5UvP0X8eVSYF9WoA9+qNwHBd6yCuFh30syWwW3q65zkWuWByfFBZ+GQcu
         69SfmbanpiKrjg5jKxGdZ3v4LFCJI+BAdM4RUF1pB/UkiJirEAMHOsrG7DI8xIsa1Y2S
         RFzQ==
X-Gm-Message-State: AFuF++ndYSSgyL+u4u6/gsnEdgw/4Irh8LbhYDhYFjfE5ziAwdq1d6Om
	FY2U7hfWrOSOOAQ0bLSlqEcHHie6Xt6gPcq8kxrBTPH778nXxRHpenluu0IfvXGzLJMUaiHoc2d
	cH9y2+0+SbTIqRzLGYHaYFWOS25OAfEhd2RIA5QN3b9oMiGziunW7VWVBjco=
X-Gm-Gg: AYBFou0Ao8CNdheDXo90Eaw9sDRvJd9rTUfGzWISFDUzwcRj363ruKgol8WMxlveX8G
	1DErLi1wnX6PHIo2DHXn4zmKProfkl3G1q5KVgAqQT5b+305N1/uWVhtwPGQDjwXub45QItSAC1
	qpGsN7lBVNZf/aP1CBf0ToFqmC2oFTlGld9tfdUq8GiMen1tB+ytHC5kHSwn0wsrq7TKMSEq7L0
	+TFeodRtWWtwAzyvTx3Ki5w+wv5ABp69bpDqUZMT+ji5GAZA1SrGcpNPnNbbP3fZlVKy12Vqgvl
	vA5BoEF+QjiblEtkUzeLj1f8YRYnsF3lUkPSH0xTXuyhYa+2crmTzgBQd/AvfWqw+Z4pL7NLMze
	nKlf3v67WAxF81Q==
X-Received: by 2002:a05:620a:4885:b0:93a:14c:32ad with SMTP id af79cd13be357-93a29460140mr213423285a.0.1789371683496;
        Mon, 14 Sep 2026 00:41:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4885:b0:93a:14c:32ad with SMTP id af79cd13be357-93a29460140mr213420085a.0.1789371683026;
        Mon, 14 Sep 2026 00:41:23 -0700 (PDT)
Received: from localhost ([188.216.77.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ebe4sm21213536f8f.14.2026.09.14.00.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:41:22 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 09:41:07 +0200
Subject: [PATCH net v2] net: stmmac: do not overwrite phc_index when no PTP
 clock is registered
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-stmmac-fix-phc_index-v2-1-bf3d90373fe4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/31NSw6CMBC9ipm1Q5hRMbjyHoaYWgZpYlvsIMEQ7
 m7DAdy85P0XUElOFC67BZJMTl0MmfB+B7Y34Sno2syBS67Kmhh19N5Y7NyMQ2/vLrQyI8mjo9p
 aKc8V5OqQJAe22RsEGaHJYu90jOm7XU20Wf9XJ0JCroTEtHw68PEaVYv3x7xs9L7IAM26rj9ES
 SjbxAAAAA==
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEwOCBTYWx0ZWRfX7N2UgVVxc3zR
 HhVodeiiSdtS2YqQXKIECYbdtdiQVrG1y3d5KuzTyi5OA5jlZmfXLEUJAkgPoRMBd+J1wRmhLSD
 w13JzC4DBGDa9LOsQ+YSkfdj+H3YE4M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEwOCBTYWx0ZWRfXzq3fHrOCmgNF
 i9nfGsRCa37fGQh3mECcjsnUagPKMQ0FxLt+Kdc1s2veZZoQ5iP7CYD0Rm3BwQC8zTG28W9RIrE
 DEshSAlIw+93jBe81X6Gr4HFbSwxMqCwSj1s+GdEpOtL2wZ0A+KAdidvO2ohJL8re9vHwqBMQF4
 4V0GyGKOBHe42zqiazzi14WUKBiEyB2514YufuOHoHQjc2T8zWwzgT3ZWCZPu2LTSP2hjar82vK
 o+x9HwqjlnZgpseLGCc+n2Kzo1r93zQzJBpsBczghJhkMG4wWlXBFbXJFZhHgMXg2LwYkgQEhTL
 MVM4vg7D6UB8GKFTQPrRxvSZJqMTUf2YgGywWgvBjmqyExohNFYXZ6e+078JI3a5ELepLcLdSXg
 HLPS0kMZn1UtY1Lmx7vA+V9EXzLq+YGy1iGH81EUrD9SNzrSObesTd8XuUNSqZwg+sxs8o4YiiE
 LTA6bVmaPL1LoC6CroQ==
X-Authority-Analysis: v=2.4 cv=IOSXmQvG c=1 sm=1 tr=0 ts=6aa7a524 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=WpTaRW6qxYHRGzLzQsVYzg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=P-IC7800AAAA:8 a=Ikd4Dj_1AAAA:8
 a=8J_TXdTtfbox2WkpGzYA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: gkxdDwv8s8JM7luo6w-GBlF24MnYB__I
X-Proofpoint-GUID: gkxdDwv8s8JM7luo6w-GBlF24MnYB__I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140108

stmmac_get_ts_info() reports phc_index as 0 when hardware timestamping
is supported but no PTP clock has been registered yet (e.g. while the
interface is down). Zero is a valid PHC index and would make userspace
resolve the wrong clock; the absence of a clock should be reported as
-1.

The ethtool core already initializes phc_index to -1 before invoking
the get_ts_info callback (ethtool_init_tsinfo()), so just drop the
erroneous assignment.

Fixes: 9364fa7fcf12 ("net: stmmac: Remove setting of RX software timestamp")
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
---
Changes in v2:
- Drop phc_index assignment to -1
- Link to v1: https://lore.kernel.org/r/20260912-stmmac-fix-phc_index-v1-1-26e1ead25324@oss.qualcomm.com
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 154cc0c7623d..1be5310ca766 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -1016,8 +1016,6 @@ static int stmmac_get_ts_info(struct net_device *dev,
 
 		if (priv->ptp_clock)
 			info->phc_index = ptp_clock_index(priv->ptp_clock);
-		else
-			info->phc_index = 0;
 
 		info->tx_types = (1 << HWTSTAMP_TX_OFF) | (1 << HWTSTAMP_TX_ON);
 

---
base-commit: 78445023439506ebd83b86d40b1e428a3b309d4a
change-id: 20260912-stmmac-fix-phc_index-1ebf19cce076

Best regards,
-- 
Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

