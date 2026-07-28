Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4723C3F41;
	Tue, 28 Jul 2026 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222440; cv=none; b=jNb+CK0A59WcnOucqgEe7AvsxAsk904S8OxFOYhMvU2as1XqjLF8b6/cxsjPnL/hmH8uLAXuI69Lys5BBnYP4RPkBGcZo07hKzPi+DhZFUQsVBLAwYwGMd3yO7pYDfMTa5L52NwjSZ3kicY23Jfq+PMNM3V+hg0EuUXOtlBXMBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222440; c=relaxed/simple;
	bh=WDn2CthXgL443POAhWI0jUZPfd6M4xLgY/BY16Gi5Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LT2B1OubT486WINVta3sjXrarVBxkyWwqjkA8yZadN8l94hpHIM029w0o0giT9IMoe32H7cZ9dshSSHTO+VeTQiVaqeDZSfqXTPkVyikjHUQosjT2IbHlxsSC2EixsvHPCoec8tp7PZOXnFLmdiW/B7EpiF91Vntit3T8zSNjZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ik5dKd2D; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ik5dKd2D"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S3bd5U1702756;
	Tue, 28 Jul 2026 07:06:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TxCo1UmYl/1AEYsKQd1yfQ2LWwi9YIRmHvz
	wswHasIM=; b=ik5dKd2DO37gZpn9pJ7VJqmik8CIG3b6eBo794RSUgVRO1PPZ5j
	aRnR2Sc6tr3VQs/z0xFtISm3/p1eUSr9n2pFOWDhbVHZdAaQ4Jqlh++girWGeZvz
	Py5YGHcuEEh8avsj8VrCq25rpdJU5JQZuFpVhbpELPp7D29Nzeb/GYXGuHRdW0G2
	i4AApPuDFQaKjmDELHlCvziDKvNnbv4i3GL/dwnNGDslIPO/llVw6MZcFNUIypfr
	xFScXCLykEfnou05mriWnU+Dz5JM0tsNMw0HEB8CEWtjIVpLboP5KCNFF5Bq1FCJ
	YSKZUlJIy10t6JDeZbIzdAOD4P6reYvCeYw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fphh7hejh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 07:06:52 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S76jtD005724;
	Tue, 28 Jul 2026 07:06:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fmp7j4es7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 07:06:45 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66S76iXS005716;
	Tue, 28 Jul 2026 07:06:44 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-rpavan-hyd.qualcomm.com [10.213.96.234])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 66S76iab005715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 07:06:44 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 437544)
	id D7E6F666; Tue, 28 Jul 2026 12:36:43 +0530 (+0530)
From: Pavan Kumar <pavan.m@oss.qualcomm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: qingfang.deng@linux.dev, kees@kernel.org, ericwouds@gmail.com,
        manizada@pm.me, nbd@nbd.name, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavan Kumar <pavan.m@oss.qualcomm.com>
Subject: [PATCH v1] pppoe: Add PPP interface name to /proc/net/pppoe output
Date: Tue, 28 Jul 2026 12:36:36 +0530
Message-Id: <20260728070636.3462165-1-pavan.m@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfXyS+DWJCLy89g
 +3XZp1F4MF+QZBIxUefSGvVw3Kjrkfj7ItWFBqTDn3rZBYFD0Zw0PcO4rLvPFDFGBfE4B5zIac7
 nzxvnczhCB8t68jEMr1yubYg4mQDqiAgaCUQWYQKzwbghbcsNARPzqAGRahWicdvWiPhkHENq03
 BwR35xTPeJ5wbz3S5rAy3KGnsWeARPtt9VSf+akIwVyvItyClidgxR8SE88V6kSBz1CztPmR/Cj
 E7pIwdDOdbJ51vLe3feurJOZIJUZh47m168Nw+TUesiGN+2PdEBNc8Jlf/1b6d6/M1cAd7ddEx5
 +4EiGt4gHt1FuM638hvuUBKBr9JShcdWavop+s/jZqhX+4A0Kl7LPJWfVAmefu5vNLRv+xghNHA
 c2BvmAlOYCrMlI6BFtHMPixXDzS75AirRYNwWB+N65w+3ZiPOBF83YJT6aI76HQ1qgAjHXwwJOA
 LtWmFqIGNF0s4rg/UCQ==
X-Proofpoint-ORIG-GUID: HgfWfYRBT8gObyGTs2Vx-8vbe_UlZ0gf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfX5R/yWR3kPWXm
 3fhtBT+En9pjnY+ecEqnEYo+e9B5UopeSkzOHCKBRsgA2G2S56NOr2bW463dnPaze6CNHTa8D1I
 oKDtB/lTmHoRiV/d/p2baYXW87u+cXM=
X-Proofpoint-GUID: HgfWfYRBT8gObyGTs2Vx-8vbe_UlZ0gf
X-Authority-Analysis: v=2.4 cv=b+6CJNGx c=1 sm=1 tr=0 ts=6a68550c cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=JZvh2-ZGMo6Dlry8MrkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280061

The pppoe_seq_show() function displays session ID, remote MAC address,
and the underlying Ethernet device, but omits the associated PPP
interface name. This makes it difficult to correlate PPPoE sessions
with their respective pppX interfaces.

Retrieve the interface name using ppp_dev_name() and append it as a
new "PPP-Device" column in the /proc/net/pppoe output.

Signed-off-by: Pavan Kumar <pavan.m@oss.qualcomm.com>
---
 drivers/net/ppp/pppoe.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 6874a1a8edaf..cb31f5db43e8 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -963,17 +963,19 @@ static int pppoe_seq_show(struct seq_file *seq, void *v)
 {
 	struct pppox_sock *po;
 	char *dev_name;
+	char *ppp_name;
 
 	if (v == SEQ_START_TOKEN) {
-		seq_puts(seq, "Id       Address              Device\n");
+		seq_puts(seq, "Id       Address              Device   PPP-Device\n");
 		goto out;
 	}
 
 	po = v;
 	dev_name = po->pppoe_pa.dev;
+	ppp_name = ppp_dev_name(&po->chan);
 
-	seq_printf(seq, "%08X %pM %8s\n",
-		po->pppoe_pa.sid, po->pppoe_pa.remote, dev_name);
+	seq_printf(seq, "%08X %pM %8s %10s\n",
+		   po->pppoe_pa.sid, po->pppoe_pa.remote, dev_name, ppp_name ? ppp_name : "");
 out:
 	return 0;
 }
