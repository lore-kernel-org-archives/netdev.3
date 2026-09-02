Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259681ACD
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 03:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788321408; cv=none; b=bvirOl1j5q6xLc0nYKQfZAvfeXLlqP+gvfwLNzQW8vNgasaxdl+vGiUoOMGcPiAsC0iL/US1LjugHaA/zqxtbdBZa/3xMgUo+HwNw805gflc8ynvJsqqXiWD7BVoMwlPF3NGW+2y+DnnAJGjH8mlbqgX3A2wS1lDPEqzowmHkoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788321408; c=relaxed/simple;
	bh=SypVZq/tJa+qeF3RW6BZ1D6A5922dSr4nzP3T5mWuOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MFNQcWPYvpvF8hJAP6xr59bokYk2S2kRpJNlYWhy+l0eDndNOSpdfsWeDCSsjJBgmST3opo97Vowz6P6pKm+oFnstbRmIdZQeYwdn0Vd3SYjm/YVG58onJPNQBcyrEdsy+1OyPERQhsGiuLJUDO5Vmw9lFDuLU/K3xzu9vf1IbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=p6DfGd9W; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=DD/5FXN1; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="p6DfGd9W";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="DD/5FXN1"
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681KSAOD1481951
	for <netdev@vger.kernel.org>; Tue, 1 Sep 2026 23:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=smtpout1; bh=dkI5WEwW9dWuKEmNlzVXJYWgCGV7YzpP3BpA
	D+nJxe4=; b=p6DfGd9WPRoUu5fvMlDMtRwDlOOyHkZ434miNkPWXHP0W75PFgrb
	F6WSwwvBYfC/03aabqhgCriULGHdqrr9JH4Cq5JWtm8kQNFUkDtUOfnrEt+rTHCP
	BUic+kBqmRexjcL0J2u2RujcVtPEP/m4mBQRHEllMv+gAVjDNm9sJsBBq9LDYcj+
	6y8mvMiCKIQm5Mj0FQ7mI0HtZR0unk9D6qKZlEjAXv3IkphyPpo4WimjrErYHbh2
	PMQJK0iozG2j9DKcDw9Uzq+KACy/dInxaoStD8wFsbhDDozJSLb0S6nXtVSzyu73
	aPNIIq23DS59XEN3qvnIv+Z6pzx1LIX4+A==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbtfwqmw6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 23:56:40 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6822dtHo3251694
	for <netdev@vger.kernel.org>; Tue, 1 Sep 2026 23:56:39 -0400
Received: from esapsmtplv01.us.dell.com (esapsmtplv01.us.dell.com [143.166.203.147])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4geb77gnfa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 23:56:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788321399; x=1819857399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dkI5WEwW9dWuKEmNlzVXJYWgCGV7YzpP3BpAD+nJxe4=;
  b=DD/5FXN160MVKBC0JMNDsiDCKiH5lDiH/tkkhX5sCAL7HeeEpvUHfVs3
   0dMpJuPo5EOzDvk1/e3vK25FJMASgxtEbEuZdlAe96VnwAwbOUBwCVdex
   U5eBaFMMPlmLsdnwNQQfSkGQf+mz8ooLwDGtv6Zp7cTcwRvZqFigau6zU
   kWxHTWYO7XH79/lB/aC7cVJ386Ya0OoFYbYv7qLP7ilXUXGPILqQwz9gK
   h2lppV29xH3O86e73RadUMCEV18qHg83P3XQF+udVHDz/zf3cr3JYtQ/F
   11OvomprC/3aqyOGw985laIddMmKBU90bsVL83ultZo7S0a9POrtZw/jc
   A==;
X-CSE-ConnectionGUID: lWneaWcBSYuw8ruXpCjRgw==
X-CSE-MsgGUID: 6f2n9In4RXmd0Q+8uZ+y0Q==
X-LoopCount0: from 10.94.14.196
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.14.196])
  by esapsmtplv01.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Sep 2026 03:56:37 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: netdev@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 v2] ss: drop the /proc parsers for packet and netlink sockets
Date: Wed,  2 Sep 2026 03:56:33 +0000
Message-ID: <20260902035633.1978-1-prabhakar.pujeri@dell.com>
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
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1031
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020032
X-Authority-Analysis: v=2.4 cv=BdToFLt2 c=1 sm=1 tr=0 ts=6a979e78 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=L/h6WUVEnF1aJ0/14Ndw0A==:17
 a=VdqzKS8jKosA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=sEWawkeXllE7TocFc0N_:22 a=VwQbUJbxAAAA:8
 a=iLNU1ar6AAAA:8 a=yI-2Dom9qA2vpsbiWJMA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAzMiBTYWx0ZWRfX8bA28WyEn6U1
 0JLLFbKSnwnAirMuIKNaXBeuYQiPGYU17qjEypE11XIGnW1HQQI8IIJrJQeFNlQJ2y/382/KRpU
 MlKcOjdo20DNDm32eqBhRXK6RhQ4azcRidhoHV0Cdqpk89hHExweUKbSCw4opfR9/fLzOrPYTZX
 salBgZjcXiFINYdvkBG3COCczzkygRg02kvbIxqnAzI3x3qcRkCurXrfwjHJsAn0BfT+LYfaOrx
 GOWtwa5tiKac6pbtbInagxTFKmXcaczdGZrSBKvuX0SjkDv+PiUfKddNtwHFXpnMjHOs3gfxHlR
 MFxvFru8LtiDd9/GqNU7W8Xn3zUV53Ipk6IFkpuglTx0uaO0si9MtQKeS9N7NvOCsuln/EPReh1
 4hCs2U1dhwwQVojdvDue86CkgA5UOE0Ufem6JBAJd63juKW9y0FHlKVvHhOOoaSvHNmF2q9Qh/8
 /6/t4oMBjfZk9sYXctw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAzMiBTYWx0ZWRfX2tk7lvsmO6Xa
 wJi+CY7ClOxUiq9gnBbGqIzY7pqFuDmExba2Gjidx0XMQk5ipQgOy0IfO8aMON2Z73luxKPIk7R
 Ilp1j36o6biB1B9HHOvT0v/cEnBnY1A=
X-Proofpoint-GUID: RBUj8dfLHYXcR9rwCsx3XP9IybJGDPnm
X-Proofpoint-ORIG-GUID: RBUj8dfLHYXcR9rwCsx3XP9IybJGDPnm
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 clxscore=1031
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020032

packet_show() and netlink_show() fall back to parsing
/proc/net/packet and /proc/net/netlink only when the sock_diag
netlink dump fails.  That fallback exists for kernels without
sock_diag support and parses each record with sscanf() without
checking the conversion count, so truncated or malformed lines
leave fields used by filtering and printing uninitialized.

Remove both sscanf() based parsers instead of trying to validate
them; kernels new enough to matter answer the sock_diag request.
packet_show_line() and the PROC_NET_PACKET/PROC_NET_NETLINK hooks
have no other users.

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
Changes in v2:
- Replace the sscanf() validation series: per Stephen's review of v1, remove
  the /proc fallback parsing for packet and netlink sockets instead of
  hardening it, so the unchecked conversions are gone with the code.
v1: https://lore.kernel.org/netdev/20260831104116.2190-1-prabhakar.pujeri@dell.com/

 misc/ss.c | 79 ++-----------------------------------------------------
 1 file changed, 2 insertions(+), 77 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 26520cee..6ca6d406 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -480,10 +480,6 @@ static void filter_merge_defaults(struct filter *f)
 #define net_raw_open()		generic_proc_open("PROC_NET_RAW", "net/raw")
 #define net_raw6_open()		generic_proc_open("PROC_NET_RAW6", "net/raw6")
 #define net_unix_open()		generic_proc_open("PROC_NET_UNIX", "net/unix")
-#define net_packet_open()	generic_proc_open("PROC_NET_PACKET", \
-							"net/packet")
-#define net_netlink_open()	generic_proc_open("PROC_NET_NETLINK", \
-							"net/netlink")
 #define net_sockstat_open()	generic_proc_open("PROC_NET_SOCKSTAT", \
 							"net/sockstat")
 #define net_sockstat6_open()	generic_proc_open("PROC_NET_SOCKSTAT6", \
@@ -4916,56 +4912,12 @@ static int packet_show_netlink(struct filter *f)
 	return handle_netlink_request(f, &req.nlh, sizeof(req), packet_show_sock);
 }
 
-static int packet_show_line(char *buf, const struct filter *f, int fam)
-{
-	unsigned long long sk;
-	struct sockstat stat = {};
-	int type, prot, iface, state, rq, uid, ino;
-
-	sscanf(buf, "%llx %*d %d %x %d %d %u %u %u",
-			&sk,
-			&type, &prot, &iface, &state,
-			&rq, &uid, &ino);
-
-	if (type == SOCK_RAW && !(f->dbs & (1<<PACKET_R_DB)))
-		return 0;
-	if (type == SOCK_DGRAM && !(f->dbs & (1<<PACKET_DG_DB)))
-		return 0;
-
-	stat.type  = type;
-	stat.prot  = prot;
-	stat.lport = stat.iface = iface;
-	stat.state = state;
-	stat.rq    = rq;
-	stat.uid   = uid;
-	stat.ino   = ino;
-	stat.state = SS_CLOSE;
-
-	if (packet_stats_print(&stat, f))
-		return 0;
-
-	return 0;
-}
-
 static int packet_show(struct filter *f)
 {
-	FILE *fp;
-	int rc = 0;
-
 	if (!filter_af_get(f, AF_PACKET) || !(f->states & (1 << SS_CLOSE)))
 		return 0;
 
-	if (!getenv("PROC_NET_PACKET") && !getenv("PROC_ROOT") &&
-			packet_show_netlink(f) == 0)
-		return 0;
-
-	if ((fp = net_packet_open()) == NULL)
-		return -1;
-	if (generic_record_read(fp, packet_show_line, f, AF_PACKET))
-		rc = -1;
-
-	fclose(fp);
-	return rc;
+	return packet_show_netlink(f);
 }
 
 static int xdp_stats_print(struct sockstat *s, const struct filter *f)
@@ -5276,37 +5228,10 @@ static int netlink_show_netlink(struct filter *f)
 
 static int netlink_show(struct filter *f)
 {
-	FILE *fp;
-	char buf[256];
-	int prot, pid;
-	unsigned int groups;
-	int rq, wq, rc;
-	unsigned long long sk, cb;
-
 	if (!filter_af_get(f, AF_NETLINK) || !(f->states & (1 << SS_CLOSE)))
 		return 0;
 
-	if (!getenv("PROC_NET_NETLINK") && !getenv("PROC_ROOT") &&
-		netlink_show_netlink(f) == 0)
-		return 0;
-
-	if ((fp = net_netlink_open()) == NULL)
-		return -1;
-	if (!fgets(buf, sizeof(buf), fp)) {
-		fclose(fp);
-		return -1;
-	}
-
-	while (fgets(buf, sizeof(buf), fp)) {
-		sscanf(buf, "%llx %d %d %x %d %d %llx %d",
-		       &sk,
-		       &prot, &pid, &groups, &rq, &wq, &cb, &rc);
-
-		netlink_show_one(f, prot, pid, groups, 0, 0, 0, rq, wq, sk, cb);
-	}
-
-	fclose(fp);
-	return 0;
+	return netlink_show_netlink(f);
 }
 
 static bool vsock_type_skip(struct sockstat *s, struct filter *f)
-- 
2.55.0

