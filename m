Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E43C3442;
	Wed,  5 Aug 2026 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785911485; cv=none; b=jo/Vw5aS7fiV1GsC3syyHFQlj5cfd3Esr+2V1V+LW75tt/Ic3OYbDZYdmX9XRIizxbls8JCUws9zLclwfH1jqU1U0173goLei2PzKbKoG0pVjwckWEd55DPZ76QLnglmeXbqn9cQazoH/cENPaJdGznHcyXNYkSp/YjmvjE9ex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785911485; c=relaxed/simple;
	bh=qTDJmNUaz1iB6sRgZI3zIwe3p/3tbGwqZvwB9t+qVhw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VQpPeJ+X7YqZoTp+uBDveaxkahXkkvaOmHD4AS1lfaWTNcQjnCTUYWSfdyCUjVAqWXuXDUcMfIG1RwhU2OnuEJizLKm6APi89YXoYMwx3uAhYpJ7enSmA5TPNQ6K1qB3W65DyMvFkebc91cktW0zqq41SEowbLCDs2+p9YDXBwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=No3aEWan; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="No3aEWan"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755mRkc2910531;
	Wed, 5 Aug 2026 06:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=imWz3HUGoZYSP9GjY636p1lN2zhZ/Pe+2PGdM1xbL
	8o=; b=No3aEWanJMz2azTshhxcqerhKVwIGRJs/quJlhj8dBtLHe7qKlQnfwU38
	M/1fNE2Y31Wo1Zo+FeYxX/JLd//J6Ao2bYiUHuYWFhpHqHBD1UG+OKQ7NQBHTdKq
	82JcqZ9tyYDa003LuuLVNR4ZB9lNNdLOxEUGyyD6yn40RnT1zhhCRNARalEZ4obq
	8zZD+4TrphcVfHgeWgkKfFTrlrEv3IXaBlCQyxF2c8jjD7KxAZr9uwWU6V1haray
	jU2Chao9v3NoYa1jWP0XJueFyp2AGR0Sg1LWcB61kZa9hAB77bZrGdVZb6I7+GBb
	EhjkLbIjYGnR1St5umILbncK/qnFw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77g9a3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:31:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6756QHt1019924;
	Wed, 5 Aug 2026 06:31:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhd95m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:31:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6756VCc728836538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 06:31:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B0F420043;
	Wed,  5 Aug 2026 06:31:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BD0D2004B;
	Wed,  5 Aug 2026 06:31:11 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com.com (unknown [9.87.142.61])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 06:31:11 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        svens@linux.ibm.com, brueckner@linux.ibm.com,
        ben.coddington@hammerspace.com
Subject: [PATCH net v2] tls: don't abort the connection on signal-interrupted sends
Date: Wed,  5 Aug 2026 08:22:48 +0200
Message-ID: <20260805063109.1772314-1-maxbr@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA0NyBTYWx0ZWRfX6MZw16YXH91t
 hB1e9H1UmrQufY23ydnhHf8QTsGC/4iZIOjaUgWys9avVxxq+7/z2L1Gh0gXhrv0CoLfon4N4EK
 hnvEciLYSPJDK88NNLJjI85kol/MMhgmYhes0CDDsW5veqRlSRTtlyDzqJ21f2GwrPtL3gsgB+E
 EELXMZekGcmZvdL+J2zKLH+OEt+6u4EslEVhdIz5aB9Sc9jebDlEpf/ltLEcbQaR71B3rOGxASx
 7ek16OlF6k0ITLNxvfvpicXacci/NBljrEuzxuF8O8AbMFAUdjCz6RHz0sESNmodNj/fBGu/bVO
 AGJyD2eVFA4HyiW9KwoCVwtLngbA/D5y6WflgO9ljrg4PA7r7xi8wmxIeBGNbQncsyAhK5JcY3P
 c2syjn9iE+AcvplukrM9nERJ0K0pG7RfqlIxCPhj4ic06NUMFCBuPQUCZdEU95NDHi9RH5+iPCu
 /XEV0yeiwZmOu8lr9vQ==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a72d8b5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=82jE9IMOl7yLyLrd4k4A:9
X-Proofpoint-GUID: i8Pu67qn8XYUlLka1LFNqlEQKs046uzw
X-Proofpoint-ORIG-GUID: wXI2Q_2XxmIqst5aA88VJSULFHTdRorQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA0NyBTYWx0ZWRfX9E4gQEzoC8Sg
 aiUbW3v8d8A4vNCUAmMjoYCYxgv+LFeMLoE9YORMx/oI91UNZp7MEeQ5L0eOawrr8GjqTTldp9j
 Lpx+4nBVCRC99uUgnymuyXw6o6c3wr0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050047

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
Changes in v2:
- remove checks for unused restart error codes
- check error codes inline

Tested on top of net commit 3f1f75536668 ("net: openvswitch: reject
oversized nested action attrs").
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d4afc90fd796..4d1fa9b04181 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -458,7 +458,7 @@ int tls_tx_records(struct sock *sk, int flags)
 	}
 
 tx_err:
-	if (rc < 0 && rc != -EAGAIN)
+	if (rc < 0 && rc != -EAGAIN && rc != -EINTR && rc != -ERESTARTSYS)
 		tls_err_abort(sk, rc);
 
 	return rc;
-- 
2.55.0

