Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639A344052
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.137.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172884; cv=none; b=oc25DZgVRPqYcL/7S7+OBBYjCUBfOS9xiFjeF/mKg92Kj+VCC9owC55xTYB3zyJdjKY6fMM1jxCUq0QAjXaItprDFLGvoKKqrawl+NwgNwm9zLrAWWrMQ/mW3wxY0K4KogF2v8bIkSZ2JqK5fJCk5ZC9oMc2noXMXlxTgS3eQU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172884; c=relaxed/simple;
	bh=9apoK3BskQAmMncV62opsm1ZB/rbhzmhq0rV9xf1s28=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=liApNjgeThii0O6WXQtM1toPKG6AYJsca+P5aXADvsYK18L1KP5TL9Z9B/k+tX4j9MdsOFdVeCAWOM+Vsr+CmAwrS3LJPdgWOGVpKAquyRUPAybdBaPNlrj3t5e1LignoJJ6qA1/z4jm2bujz7EIod3++dPUqJd3ksO+h4dMMqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=QcfnX2VU; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=Tt+cWWcK; arc=none smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="QcfnX2VU";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Tt+cWWcK"
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7x18g2499081
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=smtpout1; bh=TCnBJq0boXd01N4FrG3FAva0Gy9iKBjvRqJI
	5ukCFcg=; b=QcfnX2VUw6HV1FW0YPftrd6ueuW6v50GQnunBJH8TS6wwXi9ORs6
	ynO5hZJ0M7peNSx3X+65PQqVcX/OdAXQAWh3fzUWsk9zZ7Vyadcy1v5yEud+INpd
	/+WbQwpLHJlHJUuAUTs7jOqdR+7mjmHtgbvbi3luJOuVrvUiWjLwizs9Yr899b51
	cllWB7DTgnos7NwC0Iv5a8LMLLvJrFYqAFPuVbUVUo3SgY+YfhgaEzjDyd/5LKfx
	/3XGFD+g6Bq76r6QiJ+tS7aFI38/FaLJemFCRYK/kFIy4DOhUg1qZLPvXHIQYRnj
	clu6wPO7s1VsmQyaRGp2IwdrJnXZRZtPBg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gbtn4wfnr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:22 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VALh2E248615
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:21 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com [143.166.211.150])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gd67b9a6x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172882; x=1819708882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TCnBJq0boXd01N4FrG3FAva0Gy9iKBjvRqJI5ukCFcg=;
  b=Tt+cWWcKmhwMrlbk4Adj4EzOUu0gOnA4zIy3GazR1nCSyMYhvAzz1SlW
   mmjqFwaGhHBSgtXIMMM0HjdnpcGEs5IXg9fColIGaTpoqtI5pAYB1yim7
   Bukn+f8B6wpSGvYE+AsosyWHdAITqOtkvkuci9Umg5y4oQYTx11l3VfQA
   o4FcXImVb7b8YDIi3ag8yerddnbydFXf5V5mWTS/UEjR7mItRAOp++3Md
   KMwVT4O66mIF9O4Qo/vnfN92fJ+k5fccFthW4sAHXKU1+/bDKHZ58Qwf5
   JtA32pE7i4pCgYVrBF7VoXExOSoSrc5RaSB0MKy7NCsVH7hXq/uV0Ivg4
   g==;
X-CSE-ConnectionGUID: Gx/WySDdSYOtVphut5sl3g==
X-CSE-MsgGUID: WB0kVrWOREelCa5OixFnVA==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtpat02.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:41:20 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: netdev@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 0/2] ss: reject malformed /proc fallback records
Date: Mon, 31 Aug 2026 10:41:14 +0000
Message-ID: <20260831104116.2190-1-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 clxscore=1031
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MSBTYWx0ZWRfX4qxVq0UzU93e
 h1Dvq3rARRIIhR0RgPTdW9hWXKLxmADwOHKTwfDlkrj/bhSXVTF9vVY9ioBpgqmEFeWhSGOIm3W
 7jRBq4Cd8b4+xfR9b5bmxqEGAM19taw=
X-Proofpoint-ORIG-GUID: Hhr3s9dNXimCuC3bEcPROtabQkxbOu4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MSBTYWx0ZWRfX4H3M+pBBLdWD
 dYB4COIvU8Flz6Id6y/QE/5jVZDGArZyb5OYJ6otwYAld1IfbW/WCNlCOPul+Ior5zh1fDIdX1G
 PPvi40jK5i1EwSUxlKEJiM7pwc69o2s9r0EnSPgRdVcKQiFzJIJaa8dnSlpEQJ9NHXy6gBEOqJM
 StlBi4rnmr791fkMRnvKk3LyIpSi/1fFme42f4fMv7oDJ6nEhmuVWfMoNrxNrOZ9N8c4CRTYv+B
 ICz5NqHtdvoMyUhPTAcXqS1TQDnVtQcHZXVr7WY72NAHvsvrPyMpF9DYCyMtikTXHPFQOMyWFcP
 1O4fOIoL3Icr+QhdCXIalt25TbIqQBF6I7h5fg6EeJtJEJmYXcyoGGQGXxd3Cj1fMHCDeTrXEBS
 ZKOxvCKP5YhzJPCrbYDr7cW/t/22BXFeUXSj6oT2cBqbBLND5VdM3aC8UO5Illi7MqIfqsW0rxr
 38kyvD1Yg2i5SKoe0kg==
X-Authority-Analysis: v=2.4 cv=FMIrAeos c=1 sm=1 tr=0 ts=6a955a52 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=31FWDKFBM7tiZN6CtZ0A:9
 a=zgiPjhLxNE0A:10 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: Hhr3s9dNXimCuC3bEcPROtabQkxbOu4f
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 clxscore=1031 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091

The packet and netlink fallback parsers use sscanf() to read records from
/proc.  Both paths used the output variables without first checking that
all expected fields were present.

Require a complete record before filtering or printing it.  This prevents
malformed input from leaving socket fields uninitialized.

Tested with a full iproute2 build.

Prabhakar Pujeri (2):
  ss: validate sscanf() return value in packet_show_line()
  ss: validate sscanf() return value in netlink_show()

 misc/ss.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.55.0
