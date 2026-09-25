Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4B4D0CE1
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359595; cv=none; b=eco377n5HRo0M85CQrW9Os7UdVQd8Hh4XR2QkEaJWcNMvxaKIfmaZTLheKpIBj35wGcAJ1uei4pqP78gvM6539b5R+57wa1jSeGACxqnfpOU2rbRZOxaJPnrTW6vTKCOYnhdwMBdsI5DobXNOnXxw7Ig/L6HbaDgaNtIyxEN+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359595; c=relaxed/simple;
	bh=IAOHM/rZ5yguor+mMtA+v5Dv3NA7Ahr3PvXfowAPYqc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pOvQG1/tc+k6NaMPagtpirvlp3XTBJonbkQvsrm9M0V2JR4D+tKoGBIw4IlcJFTSVt6bqzyT3MBBcx6qJnCSF+JJ9QQc+okBePlIQDxkTKT0Vis2HZkRoLEv7VtSPJK9SuiqLqVqlLEmhwM99+hpc3jsM3UamWgKhJ4/QZ2kl3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MHJbvi4z; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MHJbvi4z"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5Q7S1513469;
	Fri, 25 Sep 2026 18:06:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=kR/ZDaU40oTtJhuV93KqFzsxwFWwLrihKepCE7GyM
	nE=; b=MHJbvi4zgb4KhLAaHeZKP2G21K1CdiKaLU55qvggAJd90qwBO+FyoqR7n
	HMIosL852zgRX78wYVDFj7UBS8qE4tG5VKLD/jXfrj7U9Af73TQW3lQNFbXFAgyB
	Nh177+ypu8qbo9m8iQS53fD0UB3E7EYEErrtrS5Xe/uGc3TMedsT+i1BzYL/hDd7
	+q3jTT9hEtLpz134NGmCxlRc07kZ+F6u0L381UpYiLOVM2kTXbxPhNO4BS9RY9Hl
	3uJWaQzLImCAIf3qksfmO353wbnnvKyiLEcpmAPnj4byglg/xmlHcVgBqgJ46jhK
	kD0gDf5LV6s991hvU0Af9/qMFRAYg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsreta-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:05:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG36Or2859334;
	Fri, 25 Sep 2026 18:05:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7efpbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:05:58 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PI5vFA30474826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:05:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39A5958065;
	Fri, 25 Sep 2026 18:05:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD99658059;
	Fri, 25 Sep 2026 18:05:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:05:54 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, Mingming Cao <mmc@linux.ibm.com>,
        shaik.abdulla1@ibm.com
Subject: [PATCH net 0/2] ibmveth: fix open-fail unwind after LAN registration
Date: Fri, 25 Sep 2026 11:05:28 -0700
Message-Id: <cover.1790357373.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab6b808 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=PgtYs7_rqURmL8y0IDUA:9
X-Proofpoint-ORIG-GUID: ukVnJa5RHUDZqyC5DvT3_ZUm7VqQRJiw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MiBTYWx0ZWRfX3oxF/1Gjebjp
 Ae/IuKI6Z7Lh0TO0MLxxRU7bSdoLiRd8eq1vQLrpdK7tsKNmt4F9PoqOw+0gyF69G515+zX/BUq
 im92GyfbFLWJbnYOdbrl0pBv/cLTmzApxrbqw72tGkCs9ns5ecelpFbMNQmmdmOewXq8xYGV+oN
 ui4vzvmAUAUj+RiASNlWHTr6+Jdm23S0Y6Syzg97kLAiCr5vne6vH9eLA8MN/Oirg4+sfi3xm/G
 UuiHsUmoWmos1ddnn1NyBKH9TLUNT2dS55J8NbXeV2KYbZf86CDZx4poAda/lktQBeiFOQO2+MT
 BDRhmQ/EdxoD3+pZNUX4R21SX8ltNX74MMGk3Z4RNpDeFZC/7Rxwiftr88LLjUfnjq+sD3nag6c
 YcaxXJpberjg7fMEFv5poRV281GAzJJl1StiOqkroFCKEHLzc4K4NWThXb4vTjH3eixCzE12iFH
 jxabp4LF1qKuQFJ4+lg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MiBTYWx0ZWRfX8sdZE0Y93IuB
 6tNpCwO7l2xTVfQz0snKLxmSOCbhKVevBjrFEB3r3pTSKK49QVGWm6AgEnFJbY/D2V0vaee0WS0
 isV+KVEwcmndNx68rR6ItNYz7ZAptLM=
X-Proofpoint-GUID: N8JFQqDRIO1lH3hR3uLnERDaVWnBYBtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250072

Hi,

ibmveth_open() has two independent unwind holes after the logical LAN
is set up. Neither needs the MQ RX series. This posting is against
current net.git.

Patch 1 issues h_free_logical_lan() on every post-register failure.
A pool allocation failure jumped to out_free_buffer_pools without
the hypercall, so PHYP still owned the buffer-list page when it was
unmapped. request_irq() failure already issued H_FREE before taking
the same label.

  Fixes: d43732ce021f ("ibmveth: properly unwind on init errors")

Patch 2 gives TX LTBs their own walk. out_free_buffer_pools reuses
open()'s loop index, so after the pool unwind i is -1 and the TX
buffers leak. request_irq() failure has the same leak. The TX-fail
goto on that walk also skips dma_unmap of the filter list
(pre-existing since the LTB was added).

  Fixes: d926793c1de9 ("ibmveth: Implement multi queue on xmit")

The MQ RX series on net-next keeps the helper versions of these
guards and does not depend on this pair. If both land, keep the
helpers in that series; these two patches are the current
single-queue open-fail path only.

Mingming

Mingming Cao (2):
  ibmveth: h_free logical LAN on open-fail after register
  ibmveth: fix TX LTB and filter unwind on open-fail

 drivers/net/ethernet/ibm/ibmveth.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

base-commit: 11536ee3d3e0b1bd35b6f3f8df55a6053eb0c71d
-- 
2.50.1 (Apple Git-155)

