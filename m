Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DEA34D3B2
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786124150; cv=none; b=GnZHby0S2hH4fHAyS5HQb9wqUueC79JBkOGDpoMrviPLHHs2E80jnfYoQm+Iep4MDcsHFPJIRoIkh+tm74YVvCsbx54jh+Jr/4bPsx3q490aF/GMq76gx2Hixn2G2GpYP/aGdB2X0iv7ynn/kZqISpaoGWKVpXpWZebZn/enOw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786124150; c=relaxed/simple;
	bh=AtwJI+oaVsuWNm0ufWXA4wIDliiZkLr8C/0/t6yCX74=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pcePFXADnr/trEGiU/suZgmyKKAfSew2UARnE6KF1wfgAjp28pDMdKEY5NMJ3ns4EcwAk42ckY20q5PT4EUm4MdqAMurPWRQLsUL3PID5YgfUxnGy/mZoZk4y1EiJBP/tzgmS5Cv4IBmVWe2VebKqxhRbWLsDXAlxoBDyb3t2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rRL2c/X+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rRL2c/X+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Glh2f1936821;
	Fri, 7 Aug 2026 17:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RVsFf5PksDDJChrQ5YlPesOTIxBfmnqPPgx7DTNOI
	Xo=; b=rRL2c/X+5/xA7MLMsenHV9M1RgxHK6SeHsnRBt07k35aSwBVg6ShRvl+6
	OL1+MDou6zhyhxI7kWEjQfmhwvA3hbEejNdphJQ9gDA5VkjUhd79nxbvnzuHmLQp
	1yc6LtmpzxhJTC4morSPVcx36xsSmgHkP3x/ap7ydBZJCP8uQ/DPmOBulzN3sRUR
	jLedgFEyWqeN906arl+oQ/1/x0Y4mJgN4Ps8N7a+ZdE/jBaCaVQMTP4ngboWXOAh
	JkSN/zh6i4guwIpqXPa8rrzQ47Ajp8GM4H77rv7gnl52LBNB0QxKb8bbcUnHN8DW
	HFAWYwi8Zp9IE19ymL8Tsi4rc+DgQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy024xvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:35:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677HQKsY000839;
	Fri, 7 Aug 2026 17:35:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kgqaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 17:35:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677HZZwJ40435970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 17:35:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21C9920043;
	Fri,  7 Aug 2026 17:35:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9257920040;
	Fri,  7 Aug 2026 17:35:34 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ibm.com.com (unknown [9.111.30.61])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 17:35:34 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org, svens@linux.ibm.com,
        brueckner@linux.ibm.com
Subject: [PATCH net] tls: fix RX desync on overlapping skbs
Date: Fri,  7 Aug 2026 19:31:05 +0200
Message-ID: <20260807173532.2256680-1-maxbr@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ybPcmdrmVQUSVrWpo-tfIn5PzgP9l_h7
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a76176c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=JELGjYNmWtrEyUvtCkEA:9
X-Proofpoint-GUID: EX3FuNqHK-sDN4SPNI3b5qyVCY0ITTFz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX6+TC/KCKS0hN
 ybDvXQ+YrHVsA2sEhuumuxSMJ6cNfmvtw4NQOWeC/8SRy6aVtxpbL35Lj1d9QSw4WQnU9+KMha6
 VGMvbGQ9Oax2CReFxA/+wnLg3rpGs/3aQhFaXMgJRWJnzva16bGrXmeecp7me7fq4d50Z1VmhqT
 tPgKTJkqaun8/Wk/GgqWLim00TtJ8JdkGflPWINDGxaRqNdxDPCS46EM7ufKhuOWfnL4yNkrrCG
 refZtGPsgGJ+1LnzANxFeeD6Uc8052vcTPfsj2IeMOzz5UZ8eiI8zbLEgwtvQ3siDOPbZRVoD+k
 9ijqgTLB6NmXbapn81+fZU7C13fE2JhIPNlD33+GZkRe4uYNDpQo7VtZYHMoR2qHRu0YlK6g4SE
 qcISEBgFQuD9bqP7MP+OZL6Az1OAr/eXMVBjc2QuM39pSXMBU9d0LNXh+o1BvK4jkiPe64pFgLZ
 SQypOqpbrgZou0t/t0w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzNSBTYWx0ZWRfX+t8Q5Pbtdukm
 DTgZKWEsWO2kKP6k6pPD+0b2BWGoQtqUcN0YM10nh/1rxsnN1zi1RjB8UeKqzWaW+cVtizGvNro
 8TggbfWRJ2GVOPns0Rvh3umKl9TX5zU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070135

On a reordering path (e.g. IPsec crypto offload + GRO) the TCP receive
queue can hold adjacent skbs whose sequence ranges overlap. The tls
fast-path reads the record header with skb_copy_bits() by byte offset,
which assumes skb ranges don't overlap.
When a record boundary lands within the last few bytes of an skb, the
5-byte header straddles into the overlapping next skb; the duplicate bytes
are read as the header, yielding a bogus length (-EMSGSIZE) or version
(-EINVAL) and aborting the connection.

tls_strp_check_queue_ok() already detects such overlaps and diverts to the
seq-addressed copy path, but it only ran after the header was parsed, and
it validated stm.offset + stm.full_len -- and full_len is still 0 for a new
record, so it could not cover the header bytes. Parameterize it by length
and also validate the header region (stm.offset + TLS_HEADER_SIZE) before
parsing.

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
---
Tested on Linux kernel 7.2 rc6
---
 net/tls/tls_strp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 61b10c697ecc..64d5dea90540 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -430,9 +430,9 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 	return 0;
 }
 
-static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
+static bool tls_strp_check_queue_ok(struct tls_strparser *strp,
+				    unsigned int len)
 {
-	unsigned int len = strp->stm.offset + strp->stm.full_len;
 	struct sk_buff *first, *skb;
 	u32 seq;
 
@@ -525,6 +525,12 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 
 	tls_strp_load_anchor_with_queue(strp, inq);
 	if (!strp->stm.full_len) {
+		if (inq < TLS_HEADER_SIZE)
+			return tls_strp_read_copy(strp, true);
+
+		if (!tls_strp_check_queue_ok(strp, strp->stm.offset + TLS_HEADER_SIZE))
+			return tls_strp_read_copy(strp, false);
+
 		sz = tls_rx_msg_size(strp, strp->anchor);
 		if (sz < 0)
 			return sz;
@@ -535,7 +541,7 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 			return tls_strp_read_copy(strp, true);
 	}
 
-	if (!tls_strp_check_queue_ok(strp))
+	if (!tls_strp_check_queue_ok(strp, strp->stm.offset + strp->stm.full_len))
 		return tls_strp_read_copy(strp, false);
 
 	WRITE_ONCE(strp->msg_ready, 1);
-- 
2.55.0

