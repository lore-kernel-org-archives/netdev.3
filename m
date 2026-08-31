Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3083B3A1E7B
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172886; cv=none; b=Ef+aFFrSD0luh9Dee+WEREXiQJ47fb3Qo6WGlbd6lJswAHIcjR+R6YwwuGE/q3ykJZWPDkIPXe5AIlC105SwNDrRo3S5QA+1njwmppqExFSUpADEZw8V3anx+qUw8uB2q4ZM6aawcdj1IQl67qY2EofxOKGDVs+3oDp5k2yVQwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172886; c=relaxed/simple;
	bh=wF07lXZNh98CwixIh7dcPzK+l79DwNDjGRHKGrFaaLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8wUjkf67g0bU3SETiZi1fAFl5cVo13xksasOLCBoXat0+6HA4ZyVCKdQOozcvUnl2+kExTspMLfFBI54cjA2Trgjbs5PsbbBgcIfsq/j5j2tx+MOSmC+Kd0dAjExERaL53TnyABV9AYxYXb7tOMuLWlpwdOzdO0xGosp6x9LD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=okne1lN6; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=RgoOR8bd; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="okne1lN6";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="RgoOR8bd"
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7x7Xr1070520
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=smtpout1; bh=yZEzHe0hfp3o
	hgYNLn+i6wjzGT4BGczijvOsNO4btPk=; b=okne1lN6N/epyaarMXmq1mNdiM9Z
	92YWNP/ZUCwcfTcaqX3oGVxxwe/CpA8PezVgqR/BO/yTOo8BriYpXTj4wo6gDow6
	HQaHeY7rPDRmdlR1UiFQsj8Jt67ZvPvYXkXS09+oaNpPIYaf/kul2Sr3wrQaZqQC
	FR9X9OEXEwrcxPKKxu9+hUaIncop7IgbkPnQoI4BDud6cDi4NHBQVZNQaiXOW8Kr
	ztxh9MO45hWE3SyaHGi4oozXRrPOcXtzVh/TtF2E6S0hRfdmWhBuMjNoLPsCwphy
	Ib3fXalOqsDJwjhY4A4O5F51z2ObqPu1zFMT4ojcZ8youG+tZJK/rD2uGw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbtfwdf0d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:24 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VALh2F248615
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:23 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com [143.166.211.150])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gd67b9a6x-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172884; x=1819708884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yZEzHe0hfp3ohgYNLn+i6wjzGT4BGczijvOsNO4btPk=;
  b=RgoOR8bdmEXfC/dPjoY8xHX79YE7KCcvDcSSwVzALCdngK9TBJyW6nzj
   tffF4SJlGkuTAOGMP/w1nez8x64oAljSxTGcrMSdMllwxOJu8YdRbxAIa
   uaNzNv90dGH+8o7TjztiAMAl+k9UGTcD5ZylzgVfpK8uGPW6YTHrr0dKF
   fFjzuNSyxSY5xoVQgSCXfipY/jgVc4RRCwlK3U6uaT969Lp7O66MwPVYZ
   MyWlc1ihJS2VjYGlGw4eESWWA2Ui1hHhsZW1ckGEtl6Xgb1usvILEtYVg
   c1wHiI/5GDLtvwf3FYbzDdrZU0m/QTHkT/SJjUgCeNhU+ywgoyrG27UD0
   g==;
X-CSE-ConnectionGUID: pI0mMIoLREWlycsp+RwP1A==
X-CSE-MsgGUID: 7O6X0zuBRoGJLjW06esF6w==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtpat02.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:41:22 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: netdev@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 1/2] ss: validate sscanf() return value in packet_show_line()
Date: Mon, 31 Aug 2026 10:41:15 +0000
Message-ID: <20260831104116.2190-2-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831104116.2190-1-prabhakar.pujeri@dell.com>
References: <20260831104116.2190-1-prabhakar.pujeri@dell.com>
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
X-Authority-Analysis: v=2.4 cv=BdToFLt2 c=1 sm=1 tr=0 ts=6a955a54 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=sEWawkeXllE7TocFc0N_:22 a=iLNU1ar6AAAA:8
 a=A2hZHUZ_CmX2MLGkPF4A:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MSBTYWx0ZWRfX9yIf0hWbKWg1
 SYY8L9UFsU6VEd9yFd8JyT6IPXfwNJa02ND6HPGOWjGkqyNRX8VkiMrGisEfo+/vJaMMr9t1izP
 zxb+Jx5eHmxmzmhmpMYwQz4L9I907dyXzm1BrkbwBD4S08LvugzILIioHnMJgeyerP2hvdODNjz
 XzJZy91oXsJ/LNLvhud5OdeGXLEhxbN+zVJlVyWl24iLxo4kf5Led4Lr45t00EuAksFVPSFhepU
 4vNmofbFNAWhJn1PaRrwUhboOSlFQV4GxByQz6GvgaPgDHntAtIx1VJ2AtQXRQ+VzuIgDlx5gfM
 ip3IvPtYNXcEunfC9QsKvZD0Ix+7Fs1ArVv2R8LQLAoo8DzZqNjGgQdv9dR64+joBi80V3JHACk
 9gJzEFQP5NV1GFN95H22MavjhdnlLQu3G6fqZ67csPyEmKTwb2F28C9YngQB3n3b1gQxL3WJG6R
 wqKsSeLaE8f2FIlYIBg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MSBTYWx0ZWRfX4+3Wi1iYyZgq
 yD4iz8R3w78NLU5c+APgTBIXJz748HB5isyrjTKmFJ6soOkiyBke8KS/JgBGabV6REmb+FFv0bC
 5QXuijpTRjiniEVOLNX5Mk7H3QEOfmM=
X-Proofpoint-GUID: jUDD8LLbBWcQ5W_SvTUcksJnv_G_Kb1N
X-Proofpoint-ORIG-GUID: jUDD8LLbBWcQ5W_SvTUcksJnv_G_Kb1N
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 phishscore=0 spamscore=0 clxscore=1031
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091

The /proc/net/packet fallback parser never checks the return value of
sscanf().  On a malformed or truncated line some of the output
variables (type, prot, iface, state, rq, uid, ino) stay
uninitialized and garbage values are used both for type based
filtering and for the printed socket state.

Require all eight fields to be converted before using the values and
return -1 on failure, which makes generic_record_read() stop
processing, the same way tcp_show_line() bails out on a malformed
/proc/net/tcp line.

Fixes: aba5acdfdb34 ("(Logical change 1.3)")
Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 misc/ss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 26520cee..098eed27 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -4922,10 +4922,11 @@ static int packet_show_line(char *buf, const struct filter *f, int fam)
 	struct sockstat stat = {};
 	int type, prot, iface, state, rq, uid, ino;
 
-	sscanf(buf, "%llx %*d %d %x %d %d %u %u %u",
+	if (sscanf(buf, "%llx %*d %d %x %d %d %u %u %u",
 			&sk,
 			&type, &prot, &iface, &state,
-			&rq, &uid, &ino);
+			&rq, &uid, &ino) != 8)
+		return -1;
 
 	if (type == SOCK_RAW && !(f->dbs & (1<<PACKET_R_DB)))
 		return 0;
-- 
2.55.0

