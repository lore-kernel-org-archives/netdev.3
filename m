Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E73D1CAA;
	Mon, 20 Jul 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538598; cv=none; b=nNewFUXoNzf6faewNvZ32smRzsquhLhzC1wwSQBaciu0lfkGMtuLRhbcSwNpf006kXO26m2Jn5cOIe5XXNgFEOXr1G4CCipOUt/mwAmTZUDvjXgDdJ9ZQeBYN1YYiolQDhWI4bI0QCcMUznpNuOPXivEzjW3pPYN0UKgGxPCUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538598; c=relaxed/simple;
	bh=XIpDfYnJ05eNWlqxselKhna0K/43rRte/9Sq2FiKZP8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fvCSs4uhIbob0ougu2PMxly9GU2cMN/tU5y8WnAcJ8fJ0Dh3sRlEWVByhRmHYaE97XObWPz1mwtD/S0gvkMv8arxEd+v9FtbW3hCvgQ6MmwcqYHCw3pyTXSREFATqHJUf8mH2GSkswAV/PWYj0HKeuiw5fu7vc+pY9KC++dcCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P/wvii38; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P/wvii38"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6g2cA1382769;
	Mon, 20 Jul 2026 09:09:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=zffkQeAE3OepcqCOQPyvER022f/4vLuIJlb1bxqsC
	eQ=; b=P/wvii38+XplvrPWt1AroPg57eP00ZzP6cbh6Y14NqaOZTd1IN+wfTw2a
	HhpmTzyxMCXQ4is6nBSOBBS2n0dioD6wMQTLvBlrrZKfEC8paop+yQkpqgB+lksM
	wawG2Dghmmz+LJ3FkuC8GOrNXctW0Zh1i+6qJIycUJQMawVjm2t3RGbuTlTGRa1t
	3pEn7FAYcdfhBnwwqpHkNw0StVbyb6yj47amhTjUnIKAbviK40FOSUd0dZKHunOl
	tQkvbNbine+h1Ck1UeZchrsnBJ6lVRbkB3ps8CuSqcyoTkw5v69M0Uqc3DBj+qeu
	PXMJYZ2XtoWmaUCZV/KKDNOjJHSlw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77jxee6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:09:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66K94aC5028048;
	Mon, 20 Jul 2026 09:09:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjmvhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 09:09:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66K99isP45351314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 09:09:44 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C0402004E;
	Mon, 20 Jul 2026 09:09:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 205CF2004D;
	Mon, 20 Jul 2026 09:09:44 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown [9.224.79.183])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 09:09:44 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, bcodding@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, svens@linux.ibm.com,
        brueckner@linux.ibm.com
Subject: [PATCH] tls: don't abort the connection on signal-interrupted sends
Date: Mon, 20 Jul 2026 11:08:47 +0200
Message-ID: <20260720090940.1334523-1-maxbr@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5de5dd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=DxUau5oYhKRh-3WaREIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfXw3OzU7ZrRoXl
 Oe4HSVpA4ouCRp6viItXfUlmRnph/WGO6VKHvWv+2XjsQTWLtBs4cHMeQJfZu5CzxTuSK2FjaBX
 mW766PQWIudpXLVBHLHM71UZ7AG3YQa6A2NNmDmLYM6I7GwfsRIDs1OWRql9U9ckKJIntPs5jM7
 PglXcVswYM+ZSYiS9+PROC9AWv0QuCri8Tz7L+6J7rg9CTmrMsgflBaLrv11it7F8zUNAD84z3d
 76S7KQg1MOkUG9teKlqKPJzUNPzPM+rnA2s07C2E3GTPX6KI9indfbosRX7fd2Pv8MgxKZGHhOg
 TMhUpAgEnNpaW4CQZCGDoJnc8/4Kib0Nndi6p7GNyRir7lqOT7Vq6y4n6CdUlcke4rbYyPMm3V5
 9in3PuX9aRWJqp7m7x1cJXlQOiXqrWgEW0VJU8+eoFkfklRGlezdycDlzGlv5AOeHK7xQercLZx
 PyJgfwyZYxfa5Fp5YqQ==
X-Proofpoint-ORIG-GUID: 4RKV2FSJM-hY-ibnYAcpmUe7NVB4YMio
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX+cPyVMvtyMVh
 nkwG6ySkraSrE023G4oY08+JjyHye5YSdSXyNTLk3Abu+swbvyiaYIFQj4l3csPlOLqWkKO/vf9
 AUEYa6F4APxeXu2lUKwr6B5J2lMziW4=
X-Proofpoint-GUID: i2ylfEYJvaQACEf2Gcz4FXR9oGQYYG_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200096

When a signal interrupts a blocking send, tls_tx_records() treats the
resulting -ERESTARTSYS as a transmission failure and marks the socket
errored via tls_err_abort() with the raw error code. Later syscalls
return the kernel-internal errno 512 (ERESTARTSYS) to userspace, as the
signal it stems from is no longer pending during syscall exit and thus
never translated.

An interrupted send is not a connection error: the partially sent record
stays queued and is resent later. Interrupt error codes are therefore
excluded from the abort in the same way as -EAGAIN.

Fixes: b341ca51d267 ("tls: Fix tls_sw_sendmsg error handling")
Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
---
Tested on top of net commit 3f1f75536668 ("net: openvswitch: reject
oversized nested action attrs").

Several subsystems contain static helper functions to classify these
interrupt errnos. It might be worthwhile to refactor these static
functions into a generic helper function.
---
 net/tls/tls_sw.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d4afc90fd796..3c9e94069e82 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -405,6 +405,24 @@ static void tls_free_open_rec(struct sock *sk)
 	}
 }
 
+static bool tls_is_non_restartable_err(int err)
+{
+	if (err >= 0)
+		return false;
+
+	switch (err) {
+	case -EAGAIN:
+	case -EINTR:
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		return false;
+	default:
+		return true;
+	}
+}
+
 int tls_tx_records(struct sock *sk, int flags)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
@@ -458,7 +476,7 @@ int tls_tx_records(struct sock *sk, int flags)
 	}
 
 tx_err:
-	if (rc < 0 && rc != -EAGAIN)
+	if (tls_is_non_restartable_err(rc))
 		tls_err_abort(sk, rc);
 
 	return rc;
-- 
2.55.0

