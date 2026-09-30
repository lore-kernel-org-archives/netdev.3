Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E884E2BFC60;
	Wed, 30 Sep 2026 05:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790745283; cv=none; b=Z1hzFoWUheJcntbTQ0NQM0eTjajjDoPkRPncGVwRKmIu1soX9OemhMCP5BjPgrYTNbSWu4UXddySNCTb/o56I981266r8xzlaB3z2V8YKHz/sggvE+M80PZcv+pGNk87aPyDAjuuKyDkD1hT3soPCbFpEqOjFUnFzC7ncvNOWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790745283; c=relaxed/simple;
	bh=Xf9GO4lRM3DYbivglZf1cfwL2t0kEtM++HUP42Mzdk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JeuR+Z10gOtrxfRhHvRAmAt8CCQq0gYHjSBdkqXg4sAng6D3yuxmRzb4NS6KZV61ImmhWMKF1zxbfcm1YPJUK/20Xb0CARMioHN83RDH9BAvVwGO7dfJm6IWz+O3zB5UhOyI+0U/lMiBksEA7oDZDG4wJVRAVg0wwfREJIYV3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=glSeU1HI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="glSeU1HI"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68U1AVhT1264150;
	Wed, 30 Sep 2026 05:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2xcjN/EDQFpx5TIXAfaIVQjeiPFlDB6hGFH
	qYzD7LtM=; b=glSeU1HIO5DdKTUC76u9Sdvo2/gwsNcX/Bm2hOsBRwdUeozEhZ7
	sfsA9g6iOdJLz5Tc1tshDIgZRq0wgItsPYHWvqShHlT1vab2f4gvDv8N89iTGuJr
	VXgney8JRnxtipvzoR04VKN1BfSIJpGIpLVBjF6qiKMQsr0Yb96ghAWNGDaBZJAV
	Zs54qlbjZKgnKUkvnK7L+v6+pLSB7yPSky+DE3ACcZNYDKQ7WwurCQ6QMCOPcaip
	3MWKFrNgXC2jwnvrkqnNcOqx2dqHaFJ6k57/PGFDzH7XpFZfatfIhOdh/HUgVi+F
	Fv/hXETpyGjZNcDNvDvBLAt0+CyTycf0n4w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rhegxen-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:21 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U5DxHj1576484;
	Wed, 30 Sep 2026 05:14:20 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 68U5EJjc1578915
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:14:20 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id AF4E0AC1; Tue, 29 Sep 2026 22:14:19 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net
Cc: horms@kernel.org, skhan@linuxfoundation.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
Subject: [PATCH net-next 0/7] Add HW GRO handling in rmnet
Date: Tue, 29 Sep 2026 22:13:38 -0700
Message-Id: <20260930051345.857443-1-subash.a.kasiviswanathan@oss.qualcomm.com>
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
X-Proofpoint-GUID: TyS6Lyr9FR2JKrSXUr1VapNwbCWTnWIs
X-Proofpoint-ORIG-GUID: TyS6Lyr9FR2JKrSXUr1VapNwbCWTnWIs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfX4fH01mYSyCZT
 4ZrWv+g+kY0ExOK9Hmo+LJO9eA+PUIeQuuXGfHz4HqPAkPd7pkfFKkSPdRzuiL2yQ+4xqSyJBM9
 t7sfmSTHujNbWMGx5sEbiQIRzAG9JUfHwddrbH49B8l/7Fb/957tbHYhhX9LwcIhOUuHTF+gQeV
 6t+kDjaHRQxznYg/merxPCwX9tSs+GpI2pWrlijXhwWhFqW0OPVzdluijVXpc+WjoWZGlioJnGF
 VXYuC6nlSzQey9Jog3q5u/SAfOkP2orhlzCq+x3oKIYT2Uq4RshszbIaDiLLDNLJGNywUKQ3pW6
 6KP51tUXv742evZiWhC7a9mfYaj4/3Kb76yVjAg5ZJ4Us57223FiabI48uEmhHO/xkPBMs3dXyl
 6CbVl1AQ7Nn7jBqklfDOAyZCynl11RtiB1NkucIur7MgqbsIvQvQv9HPbAk+KaBITq5BJ/ZdIfb
 Sco8//iNOyQLFHtE+1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyMCBTYWx0ZWRfX4G+V4vO0Lguw
 0rd8ZbEEbTN5GE2DD2CpXgpKXCt+jsV75kZmh5Jd/Un5DjCtVc/FFwashMNNxzsFmS+Jod3/ZRG
 3U9N3rOWMtNLX7WtzSp63LAFjL0intM=
X-Authority-Analysis: v=2.4 cv=Tu1zFzXh c=1 sm=1 tr=0 ts=6abc9aad cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=Ka7roW517PP78mHaEasA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300020

This patch series adds support for processing coalesced packets
in rmnet driver.

Hardware can coalesce TCP and UDP flows up to a maximum size of 65k.
Up to 48 total packets can be coalesced into a single frame and
are limited to 6 different consecutive packet sizes. As kernel
supports a single packet size (gso_size), the coalescing frame
will need to be broken down and queued per size to the network stack.

Hardware can also continue to coalesce in case the transport checksum
was invalid so such segments will need to discarded in the driver.
The exact segments which have bad checksum are identified through a
bitmap in the coalescing packet header.

Patch 1 adds the UAPI flag for the coalescing packet format.
Patch 2 is in preparation for the coalescing format packet handling
where packets maybe delivered as a list to the network stack as
mentioned above in case of different sizes or checksum errors.
Patch 3 is in preparation for the coalescing format flags to ensure
that there is no invalid MAP format combination to process the packets.
Patch 4 adds the core coalescing handling.
Patch 5 is for handling some quirks observed in the coalescing
hardware.
Patch 6 adds coalescing statistics in ethtool.
Patch 7 adds documentation about the coalescing feature.

Subash Abhinov Kasiviswanathan (7):
  uapi: if_link: Add RMNET_FLAGS_INGRESS_COALESCE
  net: qualcomm: rmnet: Process MAPv5 frames as a list
  net: qualcomm: rmnet: Restrict supported MAP checksum configurations
  net: qualcomm: rmnet: Add DL packet coalescing support
  net: qualcomm: rmnet: Work around coalescing hardware quirks
  net: qualcomm: rmnet: Add ethtool stats for DL coalescing
  docs: networking: Add documentation for the coalescing support in
    rmnet

 .../cellular/qualcomm/rmnet.rst               | 115 ++-
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  70 +-
 .../ethernet/qualcomm/rmnet/rmnet_config.h    |  20 +
 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  |  25 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   |  20 +-
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  | 715 +++++++++++++++++-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |  21 +
 include/linux/if_rmnet.h                      |  31 +
 include/uapi/linux/if_link.h                  |   1 +
 9 files changed, 958 insertions(+), 60 deletions(-)

-- 
2.34.1

