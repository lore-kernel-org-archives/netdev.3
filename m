Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1213BB12A;
	Tue, 28 Jul 2026 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785222687; cv=none; b=s9iZQs7wAzBnm7VuYliArkf0gb019rowUVUxqzdHBi/ZK3oLAhZgum7o9BAmYhxNt2f3OIR7c1ZDlKXvim17MO82h6HOTCmdbOuzsEx01g6Z6itR3sKu5tArsqKXIT2BIqXvWag+Z5cq4+gZ+R11NSbWg4BqfFhWNGuyLQ5WJ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785222687; c=relaxed/simple;
	bh=WDn2CthXgL443POAhWI0jUZPfd6M4xLgY/BY16Gi5Xs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kLG88EL0P0/UWGD5T2sRspgTb8VgGtK1qjOkMa0zAMiFqB00GoEqwiSg0QBBuEq5JCpv68rY+teeBcDDQed4GhfhMU6s2b1kplEj0IG/OKURq1PKCHWPJEt2zLv+q7dkYAqNFTHDN3OoeWDkpNnBCeLfyPTbqa5ksZPClURs7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z8KaOGCE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z8KaOGCE"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S46WaJ1821206;
	Tue, 28 Jul 2026 07:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=TxCo1UmYl/1AEYsKQd1yfQ2LWwi9YIRmHvz
	wswHasIM=; b=Z8KaOGCEQqA79crM1TiCpdsIVC4vkXOaoe8kAm22Lj34qlPzj8R
	yH7QGxPOTVGXmMwRghKLhgkaCzJ3MTAk0heaPhnRmvU5mgi295a0FSSgsq6V03mY
	+x2EZ9XZ5NBX07hvuuwETt6VQ2utQWVhSyVlQkWdXv877hgoRhth5yYr4zoehqgs
	7CGG724o6WuXg7ddcVy395r8wKlBrmtmIG+ni3q4O0vCm2JoURNvF8GgeET4UyTv
	RjDgAkgGt4s5/+CCa0hiPbXysvDX2QFbucRpn4snFfWIRsLRUiPXcyt+i5ptwCym
	noRs2kHDqTT72hv+rZXFTIVrpjzOgDF8LpA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y0n4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 07:11:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S77HJf027180;
	Tue, 28 Jul 2026 07:11:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fmp7jxkwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 07:11:06 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66S7B57p000360;
	Tue, 28 Jul 2026 07:11:05 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-rpavan-hyd.qualcomm.com [10.213.96.234])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 66S7B5h2000359
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 07:11:05 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 437544)
	id 78CC966F; Tue, 28 Jul 2026 12:34:16 +0530 (+0530)
From: Pavan Kumar <pavan.m@oss.qualcomm.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Cc: qingfang.deng@linux.dev, kees@kernel.org, ericwouds@gmail.com,
        manizada@pm.me, nbd@nbd.name, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavan Kumar <pavan.m@oss.qualcomm.com>
Subject: [PATCH v1] pppoe: Add PPP interface name to /proc/net/pppoe output
Date: Tue, 28 Jul 2026 12:34:08 +0530
Message-Id: <20260728070408.3458155-1-pavan.m@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a68560e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=JZvh2-ZGMo6Dlry8MrkA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfX+yfsZ7cEba/8
 kiPF4kvG4K4QEuhTpvioDliUxSpCHrBbQpTBW65wzHluodSlgeHdS/cvJSrIY16/bH0GgSpck03
 3LcgbFNTIjKHAAiHeclBWl7G667oOzQ=
X-Proofpoint-ORIG-GUID: OnqxYdGekN8Wmtv7mR8FKL2Y_YtX_FIr
X-Proofpoint-GUID: OnqxYdGekN8Wmtv7mR8FKL2Y_YtX_FIr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2MSBTYWx0ZWRfXwcUFxqDZSgJO
 96I4a4UGlPR5ym7HpaAW6qH6dZ8QExF9K4Vtc7r6TCGmSEFoCVZORKBoc6+Q7/c8q3IXVQXwDEk
 HJyqV+YjiGf3E020mNakkT+CWVw8OsZH7D5z1YZWV/ZrHUxjRlox6rSPRrD+esl5NlbUUNrQT2b
 L7L0eUj3CT8SJN425jbSARQToCDBOre3VcU2sS1kCcAqthuy1rbAMq8QyAdi5JEq+vwL6Y2GCyp
 cGLh+mPmHkNj8wpGJPMkHT3Hm8ANd05IugDmETL3VhtO/v59D1pXWC2lDTQbGb+t+SQe+AHJXOI
 ASR5vedLtQQgN5f4/KT/P+fOWVLu6Tj7BS/O60p44uJpfWdmLJP8Wk6RjWRMAS0iC0b2WsE2uOO
 egxk1m6SqPE5528LU6o+dpoSPDVes/Qs5ZYiTGlF/MS9TqaAuBEoKDYXe8ZNG3f13rMR9+nOhxI
 YXnAgk66j7WQbygmqwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
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
