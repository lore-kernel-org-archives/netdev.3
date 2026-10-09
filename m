Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D410E40BCC2;
	Fri,  9 Oct 2026 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535467; cv=none; b=JdqOEEVJBAWy0ic+LhclxCP0AvavaD9gnctZJ85vRARGburmGASIg1ZSBeB2BKSgAatWioAvsqnIZ6khs30cYcr0cm7MxvPLOlj31EeEwKPLYi6JBZ8aEGCXDKy3gIK7LM08RGCNSVDEmObfZ/G9jV0c9grOpORaFZ1O7Z872mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535467; c=relaxed/simple;
	bh=nzYLx4ACZMYHNFxEhZTqJF7igz3vC0kQCOL5EGYm8Zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ewN6uwnCiZ4DxJLXH3tqQvYKRtg794t5PRHkmSa3DOGZJsTmCCwmoNCVrWwJ/2RwgS2T0fDkZeUPSALPTRH40xR903jDx41c/eQWxgaR17garGdOzfWByeiIcu0AiIy09poThlfagFHnzcLzO30AAzSr4Bxo4Yg3dVC4n+suiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KLGikEm5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KLGikEm5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998L2LD643852;
	Fri, 9 Oct 2026 08:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eADWQgnS9Tdgl/hvmZfTnp4rOMKoZHBHcRa
	Z6i0GAAU=; b=KLGikEm5AMyObq8rX+dCGAF7olu8Qfe/4k8IG/PKhx+VYgtFeib
	DCOG+mCzOKE5993eXfeTgJC3uzupsqhSHGXl5P61vUZGbOBnsaixhhfTaegzRNKD
	em25EdZgIhNbafj4fGSAFb/n/06Ap9G8emYoQcJQmBwffzBR9gQkzxghioG9rraX
	RbjHdPShjiyiU70foWUdijV7lVFbj7j5HTV+lgmt3TWVXWhE4hpoKc63bDSi211u
	yVRDD6ogfk6LV8CirSBYKSNHYcMc0smuem0cQKNxCAVUVemjF8hKsUzB9M3lF3Jn
	ahv2c+HqIN4d6i0818lgE/lbjtVRDMhh2sw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxrtrcs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998i2PE348325;
	Fri, 9 Oct 2026 08:44:02 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 6998i1sg348188
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 08:44:01 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id 22DFCACA; Fri,  9 Oct 2026 01:44:01 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
Subject: [PATCH net-next v3 0/8] Add HW GRO handling in rmnet
Date: Fri,  9 Oct 2026 01:43:43 -0700
Message-Id: <20261009084351.317632-1-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
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
X-Authority-Analysis: v=2.4 cv=E+1YNqdl c=1 sm=1 tr=0 ts=6ac8a952 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=nSku2C_l4kxvR02R9f4A:9
X-Proofpoint-GUID: jMMsimlArtt59rxyKTwVqNPGfXdUXxr7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX9uXd1l4RQbEp
 Byo10nuM4m24gO3OLtYahX9JVugYmk+JG8G2sRyirM5pZQqRcADGzdR57+EXzWDReYpORYR2XZc
 18e89YYsbR9maDYS9YyZsuNKf5HiaDry/CwIPgpOrCZGUKBp2nkgnxmzU/xe+fbPGs1PNiGB9Lp
 vOxKLjz4AYnnLuEsPTj1ckBmQfS+TtHCyxNGxpnjLNLgnAQwGCEBgmYDC7oon6TIKWhU1YnVa44
 NnA5kGNOuQ6AOwwTmS54aNv6UE3aKANFbdUUb4+kQjl9QHkZThATtzte/xd42rN5etNASgwy/vk
 jRDzEDn65Q1wpOGUlwi1avzzA8OFYc+gxdlC1OOitNYF9XXqK6SdzXhQMLsswP9X9fUIygnB71k
 d8QWzf/hN175SD2K6p3/NdrUg7qTwc1aof4UFkemWfQRyXMAS2kLtPF8MN6M6ANYu5GZ7Xas/bf
 ++zCB1KVR1ff4E53zHQ==
X-Proofpoint-ORIG-GUID: jMMsimlArtt59rxyKTwVqNPGfXdUXxr7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzNCBTYWx0ZWRfX5xyg9OAGL0Qa
 S73tsYaGFPOfmJxjwxXZ38FPkMUjHhdW26xV4PfUQ/bl70JW33JkcjiGmIRgTnqf4sCVl9YNZKo
 mPrD+Ru/d8G9BGTP9QX1C4kMyLNHu/k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090034

This patch series adds downlink packet coalescing support to the rmnet driver.

Hardware can coalesce TCP and UDP packets into a single MAPv5 frame.
A frame can contain up to 48 packets grouped into up to six NLOs.
Packets within one NLO have the same length, while different NLOs may have
different lengths. Since an skb supports only one GSO size, the driver
reconstructs separate skbs for each NLO or packet run.

The coalescing header is a fixed 28-byte structure containing all six NLO
slots. The checksum error bitmap is a single 48-bit, frame-wide stream
consumed least significant bit first. This allows the driver to identify
checksum errors across NLO boundaries and for NLOs containing more than
eight packets.

The driver drops coalesced segments reported with bad transport checksums.
IPv4 UDP packets with a zero checksum remain valid because that checksum is
optional. Multi-packet coalesced frames require RX checksum offload and
hardware GRO support. Single-packet frames are delivered as normal non-GSO
skbs when those features are disabled.

v2->v3:
  - Fix build warnings in the patch "net: qualcomm: rmnet: Add DL coalescing statistics"
  - No changes to the other patches

v2:
https://lore.kernel.org/all/20261008005543.2630828-1-subash.a.kasiviswanathan@oss.qualcomm.com/

v1:
https://lore.kernel.org/all/20260930051345.857443-1-subash.a.kasiviswanathan@oss.qualcomm.com/

Assisted-by: LLM

Subash Abhinov Kasiviswanathan (8):
  net: qualcomm: rmnet: Update MTU handling during format changes
  uapi: if_link: Add RMNET_FLAGS_INGRESS_COALESCE
  net: qualcomm: rmnet: Process MAPv5 frames as a list
  net: qualcomm: rmnet: Restrict supported MAP checksum configurations
  net: qualcomm: rmnet: Add DL packet coalescing support
  net: qualcomm: rmnet: Work around coalescing hardware quirks
  net: qualcomm: rmnet: Add DL coalescing statistics
  docs: networking: Add documentation for the coalescing support in
    rmnet

 .../cellular/qualcomm/rmnet.rst               | 153 ++-
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  92 +-
 .../ethernet/qualcomm/rmnet/rmnet_config.h    | 104 +-
 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  |  25 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  20 +-
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 983 +++++++++++++++++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 199 +++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.h   |   4 +-
 include/linux/if_rmnet.h                      |  31 +
 include/uapi/linux/if_link.h                  |   1 +
 10 files changed, 1486 insertions(+), 126 deletions(-)

-- 
2.34.1

