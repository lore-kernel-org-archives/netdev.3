Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E59A3EFFA6;
	Wed, 23 Sep 2026 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153393; cv=none; b=guPKxPIdN11pw9tbAlaye2gLx1Jj6yxbk7Yxhc/c+UbPjsnioem7hrPLg7MHEKAYDcXE3CI3cTJpbrt7tkLMkMkMeXyaRn46AsrAWRZCqjHzVOkok5gJ5pwXijILty0MbuQqNVm4BHwuL/6soPTzxsI/0yMYhJdUnpgwfczueqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153393; c=relaxed/simple;
	bh=seLHURhLUB+AKjKXweD+eknRBBkMowwouYIPCefHHuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9NlXhwqbzBuxuN70022EVoVgA4SFpRZIpfDUahZhC7+JKqoDQ3xJaPzyNfarG8xdO+wjeCJNyqxzkDZWvVB7Bh7aomiRc+JP90gTi2aKyigqHBtQVWu2+DxcaEgU/UYFS+pE397P00I6S0ifzX0o+9XPEhC/XZG8173cFJ9mjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hdUZCwM7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hdUZCwM7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8Jc3J2719129;
	Wed, 23 Sep 2026 08:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=jSRBMJOo8h8
	YK/9D58wKGpgOcXOL9Xo8aC2wVlMDzmA=; b=hdUZCwM7RS6VVnE6voDfSKv/IBO
	rrjS3wYPTkxwZO3gUpT56eu7Y/N0xSWkzxFgCKoZRK2U1it35qXeP6PnQkWIGrbo
	ZwCk0DK6dR11VeAGclN/xSQYtjv1mOUB+M5F9+vmbv6UVXN4MkE4Vf48WjpsTvzR
	3eIlud7HxClM56UW5oDh0y8B3QUFUPDQuGLNHa19w6Kaq1kMGRnuKwVyfHaluvMX
	4qazGMhin5ieW1pg9rvmuvWvKQlX7NfTC06DEPoxmbBPOKfEcwHoyhgSnhhcHYUP
	K8aYn/KRLAMWUgSALXIOmALOg11nipt85Fqhy66CTxUeqqOGZOp4MoGPohA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv32qsx35-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 08:49:30 +0000 (GMT)
Received: from pps.filterd (aptaippmta02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8nRM0677493;
	Wed, 23 Sep 2026 08:49:27 GMT
Received: from ap-kernel-sh03-lnx.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 68N8nRS1677477
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 08:49:27 +0000 (GMT)
Received: from ap-kernel-sh03-lnx.qualcomm.com (localhost [127.0.0.1])
	by ap-kernel-sh03-lnx.qualcomm.com (Postfix) with ESMTP id 0441640543;
	Wed, 23 Sep 2026 16:49:26 +0800 (CST)
From: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
To: shengchao.guo@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        mohd.anwar@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Subject: [PATCH 0/3] Nord ethernet followup
Date: Wed, 23 Sep 2026 16:49:18 +0800
Message-ID: <20260923084921.3942100-1-zhangfei.gao@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
References: <20260923-qcom_xpcs_nord_emac-v1-0-4b1c682af70f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=SJnXx+vH c=1 sm=1 tr=0 ts=6ab3929a cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=i9qpN243zccxjc0edKYA:9
X-Proofpoint-GUID: PUWMz3RWxHUhqBGtfBdgGsb_4Iq-3fIW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX07VsbaWyPeBh
 l0XJmU1H5r3TI1ojLVOwGxfKsbvFs3TLkcHTvi68FZc/TSGso6Kuh/20stAjO1bs8AeWI/kUAXr
 Dnv9C7gInV2cTgHGwTg2hb40IBa5PmU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX5XTexz7Ly/ON
 nf9jTv971BA6w2mHwnsfjJ78SmcZcuAkZY34tYeEdG6rbLEQuyWasIvDJSEtS0PqinVGk5ZWd1h
 zfq27GxBaeuB+Q58POVZo+S082Gy5RFNvtoxBtsBJbpntcn5Ke71x/nLZ7wpDfcf3djDdDHM3+s
 nsL6oBoDsplKAyrX3WJX+0FsLdKcH9qDHtWRyJKtC+yx3QGqGH7+j1Rc5tDqKxohSHAANn73IXk
 TrSOlR1jONLkFy9bMuqOAL+7/ZMzja7IsKgfKWWmMMYJWk4nIwC9CURwl5JD13WcfYOvnPN4sbk
 /VbW1+ul/texa59UQtuLfzZGchCgtG167vgGiHqe1vEulb5C0u4N1ULAnAUSVQdI49Yvvm/sIST
 1dR2BrjljAo+B5TtKBGnXqPTWbB4NncPOn9aJA4e4uaRJwD+rAyV23B3qULCFdqieXGpLSCG7dK
 PSugjmqcYpxnu614+kA==
X-Proofpoint-ORIG-GUID: PUWMz3RWxHUhqBGtfBdgGsb_4Iq-3fIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230035

This series verifies Mohd Ayaan Anwar's patch set:

  net: introduce Qualcomm XPCS support and add Nord Ethernet plumbing [1]

Tested on both IQ10 RRD and Ride

The full test branch is available at:

  https://github.com/zhangfei-gao/kernel-topics/tree/next-9.23


[1] https://lore.kernel.org/linux-arm-msm/?q=qcom_xpcs_nord_emac


Zhangfei Gao (3):
  net: stmmac: support low-speed USXGMII validation
  net: stmmac: qcom-ethqos: configure USXGMII rates
  net: stmmac: fix 10/100 support and MDIO for DW25GMAC

 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 65 ++++++++++++++++++-
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  6 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c |  9 ++-
 drivers/net/pcs/pcs-xpcs.c                    |  9 ++-
 5 files changed, 82 insertions(+), 9 deletions(-)

-- 
2.43.0
