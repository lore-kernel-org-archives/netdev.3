Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA94473C8C
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623234; cv=none; b=eB/AJPL6EluHXsO8IGqa30njqcZryHP4tc+sHwFg1KcAYFJZQu5Hkh+xkyuSS7MV3Fn52WpAFCjYh05Mx/CSgIiHduOVcNeeOHErPjZF59IdZRMl8lIGzHm8JDlNLq6SE79PKV1tadZ40Hb9idWxKj/b1ThlxAbj/YZwrLqmaw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623234; c=relaxed/simple;
	bh=XkFUCzpy+IBMlg19qKp0L2tMPDM2OG+lQhNUfpGx70A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qIAmOEcwXjOTS1Gj+kuclhF12W2z2LKVormA8hNORGunPQQZ8cBMyOcILfy8Hefx+OV9k/xzQHmipW9jiPb+F88/SGnQYx8GqU9GBUlVQg4+y+6UHZXmdVsEIdE4RzMkFQYpIuMF4gfJxUF6HOUi1NTPUBGRe3HXGI/TX/PF82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FuAQj0gb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FuAQj0gb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D99Pee1821387;
	Thu, 13 Aug 2026 12:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=KmW3H9Bze83WAYZk9r62T7NXkEZ8Jn5Kx3MQTgG98
	0A=; b=FuAQj0gb1P7BRkxfr57kO+Scl9x0LHUaaXycXlN3zTp3bgfLVaa5LjKS1
	R/BQx7TCycK9dpICHv+1o/hCByLyiWPKkSjj4i9abSr9ela8fa9uETXn1PKaHHpu
	ljqaVWrZP9mu8ak+L7veTogYEQq97yuFbom77dFXJmJBKycUBRuEofRGoPZEMRVF
	NQ9CHORITtFH+apvLmjYRK2oSbNCaSyp9oVLbwV+JR4kNMPmubSmgUKfk0bXwuuW
	08RNH7PGUTgb0bmRXJqXLT/hkQb1/9/28rmcio7uPyENAZCeF+BEwSS73viO9nxV
	o/z57YOZhBg1FKVUnxO7w00vPe15A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp36sfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 12:13:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DCBIg6026611;
	Thu, 13 Aug 2026 12:13:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk2wuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 12:13:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DCDedR39190850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 12:13:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14F4A20049;
	Thu, 13 Aug 2026 12:13:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCBB120040;
	Thu, 13 Aug 2026 12:13:39 +0000 (GMT)
Received: from li-fa2166e9-1f7d-4f1a-8ca5-7ccf0f022c25.ehn-de.ibm.com (unknown [9.224.79.183])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 12:13:39 +0000 (GMT)
From: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org, svens@linux.ibm.com,
        brueckner@linux.ibm.com
Subject: [PATCH net v2] tls: fix RX desync on overlapping skbs
Date: Thu, 13 Aug 2026 14:09:44 +0200
Message-ID: <20260813121337.3300688-1-maxbr@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7db4f9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=JELGjYNmWtrEyUvtCkEA:9
X-Proofpoint-GUID: PDspGaaiduNN5zFxdfQUiTc7vy5XERyE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA4NSBTYWx0ZWRfX9ERRqxnPoBgs
 ZW1wo1c5F3xyG/rBDOlOOwYAXQPcJUlVIisRSocPMj1AWryPtPoa5KpbJILXPBoqXD3vKQOdaFt
 XMYNMMn3IV3nRxrg5KFeKZXjuR2+Qp2wL58blLGXZm/j8n/s2d73MGfoQHYWRW8Vd0Wli+krW3i
 JMA22xU9mHLhlzDuXNgfzlw1YDQ5gD/bzGnBBr5v2v+v9oDQgFLL4D1jUDYsk3n4f9AWn/eKil1
 ZTy3jdIAgne5lg9+7Jb4x5a1Nt3ewP6+qGT5D7vobh/alwH9XYCVtSNAcHnbG6yVjJr+mMA8qyD
 bCAqCcGDXtO4LbKPSsL9Ev2pbAP1sksH8JkhTdGAsxUT17qt+ikxYBunKowGBrp+vJqKMq5eF3b
 /xMSRVPpiB/5NzHARutU1FDYZOCMlS67xEmIM13wLeK6zLaIOVzzmJqUzGGUfgjG8hbDaTOoK+A
 1PMiw1VrWQ86/hMHhFQ==
X-Proofpoint-ORIG-GUID: MV00obeyLqKY2HYEBmkveQYbf5CbAPq6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA4NSBTYWx0ZWRfX2DeJfZE4LrNF
 wrrJjVdhTzH7K20d3OT05pLGOmuidEiQNcAdOceDHXWZzDBCHEP/0zAHrPm1mg7pSmDuqsxvwN6
 XJiHtMAcz0tU2pNMxrdnJviWUkMRFKA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130085

The TCP receive queue can hold adjacent skbs whose sequence ranges
overlap. The tls fast-path reads the record header with skb_copy_bits()
by byte offset, which assumes skbs do not overlap, so a header split
across the overlap is misread and the connection aborts
(-EMSGSIZE/-EINVAL). tls_strp_check_queue_ok() detects such overlaps but
only ran after the header was parsed, never covering the header itself.

Observed with parallel kTLS connections on:
- ConnectX-7 + IPsec crypto offload + GRO
- VirtIO (8 queues) + GRO

Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
Signed-off-by: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
---
v2:
- move the stm.offset addition into tls_strp_check_queue_ok()
No functional change from v1
Tested on Linux kernel 7.2-rc6
---
 net/tls/tls_strp.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index 61b10c697ecc..6cc222008d95 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -430,9 +430,10 @@ static int tls_strp_read_copy(struct tls_strparser *strp, bool qshort)
 	return 0;
 }
 
-static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
+static bool tls_strp_check_queue_ok(struct tls_strparser *strp,
+				    unsigned int len)
 {
-	unsigned int len = strp->stm.offset + strp->stm.full_len;
+	unsigned int remaining = strp->stm.offset + len;
 	struct sk_buff *first, *skb;
 	u32 seq;
 
@@ -443,9 +444,9 @@ static bool tls_strp_check_queue_ok(struct tls_strparser *strp)
 	/* Make sure there's no duplicate data in the queue,
 	 * and the decrypted status matches.
 	 */
-	while (skb->len < len) {
+	while (skb->len < remaining) {
 		seq += skb->len;
-		len -= skb->len;
+		remaining -= skb->len;
 		skb = skb->next;
 
 		if (TCP_SKB_CB(skb)->seq != seq)
@@ -525,6 +526,11 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 
 	tls_strp_load_anchor_with_queue(strp, inq);
 	if (!strp->stm.full_len) {
+		if (inq < TLS_HEADER_SIZE)
+			return tls_strp_read_copy(strp, true);
+		if (!tls_strp_check_queue_ok(strp, TLS_HEADER_SIZE))
+			return tls_strp_read_copy(strp, false);
+
 		sz = tls_rx_msg_size(strp, strp->anchor);
 		if (sz < 0)
 			return sz;
@@ -535,7 +541,7 @@ static int tls_strp_read_sock(struct tls_strparser *strp)
 			return tls_strp_read_copy(strp, true);
 	}
 
-	if (!tls_strp_check_queue_ok(strp))
+	if (!tls_strp_check_queue_ok(strp, strp->stm.full_len))
 		return tls_strp_read_copy(strp, false);
 
 	WRITE_ONCE(strp->msg_ready, 1);
-- 
2.55.0

