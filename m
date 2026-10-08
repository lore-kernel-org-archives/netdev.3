Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD4C188596;
	Thu,  8 Oct 2026 00:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791421045; cv=none; b=gyh/y0Jf3yZaaUyZNhI4mTx1vyo8ywzJ+93tCRI/0httSO7x6sa6kBPbepg5SDJo9LV030HbVtaJqKRroUPd8PkoJOt+pKRY7u6Q3rJb6cBCwZgwHurab/li4tCP2YO21TVLrkIQhwWCzE3nJq30EKlxl38ZuBrCme5WfqJjOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791421045; c=relaxed/simple;
	bh=m34vnYeNSsgNBJy34hz9K++goTkVt12ZrNcDmK1zG1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nHUMZLzvGRVKkiSGzZXQNx5jDFasO0cZ1G0XxqHDMXIwuivT5DhmHEQpqUzK9NyFgryFFRmmF1y75EQxBsWISs8O8/14Ik1H5n7gslRMG0BRy0XGiD+ePJpunz3R1czGkN7gDspxsB4AFmNr8yN/Vuj0H+dhuQxHioI92i1sMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WSG3XU2I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WSG3XU2I"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6980aNMK2434649;
	Thu, 8 Oct 2026 00:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ItP43JxRTlNb9M6BenecJTOAjl3wZw8idOn
	0CuElbrw=; b=WSG3XU2I4q7Fw8fBeQg/YnA3Tke6n087LlqfMnhFCC2vvI3/DRZ
	IUY5OD3pmwHqLmywQx+v+czjlDDMtYhDcY4EXfStwKNxB6/UQCvJBo84hMsaCp4A
	yYVaBlI6xDoITCbSLQgjI4WvCkEaLlnb6jKW4RZisB0awDYEAk5B73VfOVKunmp2
	mw9Qyt26LBBabLliH3RiIYZhQvju2i49xuVY4oUOLBy3A/sFy9HLu/8yFLxQXpLF
	YlxUN9m9WyrsQSOZKk7CHjNuvWw+CDeRG7dlm+zc5kiF6hStoI/EGcXRaZMiS7KD
	qoHyfOjOaBsMh7/1TyVJJC+gIGc21nR9Zew==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h60sg81n7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:58 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6980uvHh1429361;
	Thu, 8 Oct 2026 00:56:57 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 6980uuJL1429349
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 00:56:56 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id 9A46FACA; Wed,  7 Oct 2026 17:56:56 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
Subject: [PATCH net-next v2 0/8] Add HW GRO handling in rmnet
Date: Wed,  7 Oct 2026 17:55:37 -0700
Message-Id: <20261008005543.2630828-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-GUID: hVMD7PpTZCRBtOtpnnIkhxLusc3xyiQ9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX7QkW/seXM+2J
 uTT/RgtV7Rb/Fcao9Od+VfSmQ4keYl3abb9XsnPtDb3HMrBcytgw+/t7pbnm7zWTIRgVMg+XH25
 T7+AMKQuKn6bxMLJfF/lh+Wnw9hx7mc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMyBTYWx0ZWRfX0UyLe2KZHf2I
 G8OzqG0B6C9OZdip/8Hl90IiPpEW3nA04ugAeVujO7kQppc+eS7vUqIDp/8q+t0DCB9+y5q8Ik8
 beoA90bOynNGI4xmTFaY55XCXopFQ8pGgos8EUVn1IEX/1gNp0FS5lhMXRzrTt+VpH7CNnT+vIG
 +rXkknHMAKnN5HnPoxLBwq/muFXWkaUT5xOGcusESyk5MXESh6cHX2AT3kLcr+ukk3G8YLSXhs4
 vP2afjhNQtlFqc3d+RnXjNo4TbGW/PxYq8U7AYgqtCfBMp6GxYQ+RGIKEaVTi+LXiCIgW9xBr34
 5Mr8Uu1jeUb244rdFVIKzY0l5soKVhoymt/1qXbfXh2SkmUulPkAzcoNgGBQSSQGcTZ2jGR0r8d
 EDjnfoNN3ZrbzfY4uOzTh3tkOSe1QPAeHtcR4NlR/L92QBK/in17hmBeQUBt+IVTlewx8tls8DG
 pMlwT1aKgGYRsDfCjwg==
X-Authority-Analysis: v=2.4 cv=DfWCOftW c=1 sm=1 tr=0 ts=6ac6ea5a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=3YWVQOoNCXH4OLSUSDUA:9
X-Proofpoint-ORIG-GUID: hVMD7PpTZCRBtOtpnnIkhxLusc3xyiQ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080003

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

v1->v2:
- All changes made are based on reports from Sashiko.
- Added a new patch "net: qualcomm: rmnet: Update MTU handling during format
  changes" to address the comment about the pre-existing issue about the MTU
  handling with data format updates.
- Document the restrictions on invalid combinations of data format in patch
  "net: qualcomm: rmnet: Restrict supported MAP checksum configurations" in
  comments and commit text.
- In patch "net: qualcomm: rmnet: Add DL packet coalescing support", add
  checks for packet content validation, better handling of the GRO_HW and
  RXCSUM flags, unclone prior to modifications, tagging drops with kfree_skb
  instead of consume_skb and updated comments about the coalescing packet
  format and updated commit text. 
- In patch "net: qualcomm: rmnet: Work around coalescing hardware quirks",
  updated the nlo field parsing checks and updated comments and commit text
  about the checksum related handling.
- In patch "net: qualcomm: rmnet: Add DL coalescing statistics", updated the
  stats to use per cpu counters to avoid torn reads, added network stack
  specific stats for HW_GRO and updated comments and commit text.
- In patch "docs: networking: Add documentation for the coalescing support in
  rmnet", updated the documentation and commit text to clarify the hardware behavior.

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
 .../ethernet/qualcomm/rmnet/rmnet_config.h    |  84 +-
 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  |  25 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  20 +-
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 983 +++++++++++++++++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   | 193 +++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.h   |   4 +-
 include/linux/if_rmnet.h                      |  31 +
 include/uapi/linux/if_link.h                  |   1 +
 10 files changed, 1469 insertions(+), 117 deletions(-)

-- 
2.34.1

