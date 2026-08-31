Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B13033FB
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.137.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172866; cv=none; b=d2cpUFm81L8zcVgLlkfogTiSFcC5/VH8v5k4NRm56EOGkFredMu0vYzCiRvGKrjS07XyBJbvM8CEyhk5izZNiDS8y4NiJPBqpZYKX9sVvOW0eII+xSW3SHNfJ7w+uyW39GloNHkhnAzxhEtaGq2BhdR7wMw8TXiEMYCqcDtHPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172866; c=relaxed/simple;
	bh=cERD+dbdGL460TMFadVUM7NP3jO7pBApMAZ/P0Z8G3o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=u4KBNCjW+TPPe5g3G+yBNppzDGb1jnW1+J8Lt9ajZYo1KpuWrkk24hoWS0bBSE3l3HGIGryFv2LidQ51GzYl5A9qAszOUtOoOb80yDxILjKm9sAtxM5OztNXkfWF9HrIEpTRJQWR70niVDQB7jljGLbZ57NzJcRgOj1Du2xu9r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=sQ2dbMu1; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=m04kISHb; arc=none smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="sQ2dbMu1";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="m04kISHb"
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7x07w3191543
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=smtpout1; bh=TBU+cV57Oya/PGh0vLS3CJxUUQOBy0He92S6
	zE2ldDo=; b=sQ2dbMu1QWbg++lsQ4rWvIEK08IP/yJ8CgLUSH/RKfgPmLSKmlww
	1mvU5qlPj6+o5pb2C2Z5UeEDHWcsHtJZjIK/d4nnQ+lpfm0iNEkdv9Ad2D8/xvnr
	3XDhGnSJ6YFaU7U4xIfg3+zZDzkywUAWaTK93TmQ5+N8GZUb7JeGLFNxh2T8XLVx
	uqZJL2ja9u/XtAwpheggo8L6uichOSmOV8LhwvlHV5gCPrq5q+BtNHRuy/vElMnz
	vn6COV3LeUVUCV7hRsQfuFz/3r2bhWcLV+TZj3lSSp0PbEGFNPf2A/Vk5FGw+xiv
	LMlvdp/fC8xr4iZB3ykcPRtR9/tzU9tn0A==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gbv3g57be-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:03 -0400 (EDT)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V817lC2674620
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:03 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com [143.166.211.150])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gd5ebstdb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172863; x=1819708863;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TBU+cV57Oya/PGh0vLS3CJxUUQOBy0He92S6zE2ldDo=;
  b=m04kISHb4lOczMfAyQsqVaQkhtAzIpuftxeHCNTPWWqVG1z1SIWxqtCD
   EvAqJIMhgPxENq8bmyK/MpCP4CFliR5qjV1TcV+NFHNxRV1OpsXw8DKK3
   ciBE33pfOqvdxTQnooaiZZfgJMcONnXvnoasLoVcz8+wDOGe9IJPWAdll
   K7kSMkNp9XZ4EH+QymoGiPD72lGQ84O4Oxa/e50rMZhmfrY5CwJSHI9dZ
   4c0kCaVfQBouEFcJKSG/Wq31FlaMXavCd/sNjTG0+qOH88gHMh7fp7klJ
   2hkyYOfnijpSRYat6q2mUhgNv9T7zkfP6PGy7BP9ARh/+vefD2YPu0FJT
   Q==;
X-CSE-ConnectionGUID: Pk2boAo8TQW2Ht/k7p6XyQ==
X-CSE-MsgGUID: I1dZO9pnTeayajprt27RzA==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtpat02.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:41:02 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: prabhakar.pujeri@dell.com, netdev@vger.kernel.org
Subject: [PATCH iproute2] u32: fix IPv6 port match pretty printing
Date: Mon, 31 Aug 2026 10:40:57 +0000
Message-ID: <20260831104057.2176-1-prabhakar.pujeri@dell.com>
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
 clxscore=1031 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091
X-Proofpoint-ORIG-GUID: bzbEaQxgid9cmBU9XsiK6i8sixWuRUct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MSBTYWx0ZWRfX3BZkueCXuspn
 3AaqOFPTA6PPJDqy1G/qE4ud1nFb6FTDvWG3jmJdwu66FNlkw/CI4K0xxqJkfOCXDNNQzw30dPw
 BaFMzsbjmXgH2MtFV5MuntBajcwIoseS6zjBvIRlJ53y3pyCBWITvXAvoXzj17Bj8jk2o3uONXX
 qV/+ivBGDI4qKFvhDm21Dhc9i/RB1jo7wgMuWllvKAJz6gHe+vvBCiNhiaUTmRwMw+zsI+5Zpbi
 XEEXpEHXqlvVOHXAOVw7qTgixy9qPy9rbf5ynjYsmuJhFcdIqKwdV+TVh2dBj3k06/X/MjYtJm0
 4ooPmLcVfKQ9UW6Uo7HjOxXsS99WPFjq8MH1I6rMHx/ZxwvWMalnfRIvY9u2Q/hhROXU5r6yYpj
 03FNvFE48f8nML6uoAxLn52uYJrbWs0jCGhcWJ4V3xe+JCHdo8h80Yn5NMrIR4wwzUPuqWQTnLZ
 myU5r64aIAv351Dwgnw==
X-Proofpoint-GUID: bzbEaQxgid9cmBU9XsiK6i8sixWuRUct
X-Authority-Analysis: v=2.4 cv=B7SJFutM c=1 sm=1 tr=0 ts=6a955a3f cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=Qy6CKLcU0MZ4grw4BCWD:22 a=iLNU1ar6AAAA:8
 a=kPxjs7EtMyOY6NC3-IAA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MSBTYWx0ZWRfX1zcviuZ4k3Zn
 vm9iveroYvJ0IRJd80HKZ3PMPqha3w4POmIoJuaMJbuCfS2VH1w4STPduNntF/uCAmbleFatJy5
 GTZrXzUgUHqfWLc2YHwBU6eoS1awvb0=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1031
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091

parse_ip6() stores source and destination ports in the 32-bit key at
offset 40.  print_ipv6() checks offset 20 instead, so it does not print
the decoded port fields.  The source and destination labels in that case
are also reversed relative to the layout produced by pack_key16().

Handle offset 40 and use the source label for the high half and the
destination label for the low half.  This matches the parser and the
equivalent IPv4 printer in both text and JSON output.

Fixes: d13cee6d598d ("Add IPV6 match pretty print")
Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 tc/f_u32.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tc/f_u32.c b/tc/f_u32.c
index ae285146..304fbfa8 100644
--- a/tc/f_u32.c
+++ b/tc/f_u32.c
@@ -948,22 +948,22 @@ static void print_ipv6(const struct tc_u32_key *key)
 		}
 		break;
 
-	case 20:
+	case 40:
 		switch (ntohl(key->mask)) {
 		case 0x0000ffff:
 			print_nl();
-			print_uint(PRINT_ANY, "sport", "  match sport %u",
+			print_uint(PRINT_ANY, "dport", "  match dport %u",
 				   ntohl(key->val) & 0xffff);
 			break;
 		case 0xffff0000:
-			print_uint(PRINT_ANY, "dport", "match dport %u",
+			print_uint(PRINT_ANY, "sport", "match sport %u",
 				   ntohl(key->val) >> 16);
 			break;
 		case 0xffffffff:
 			print_nl();
-			print_uint(PRINT_ANY, "sport", "  match sport %u, ",
+			print_uint(PRINT_ANY, "dport", "  match dport %u, ",
 				   ntohl(key->val) & 0xffff);
-			print_uint(PRINT_ANY, "dport", "match dport %u",
+			print_uint(PRINT_ANY, "sport", "match sport %u",
 				   ntohl(key->val) >> 16);
 
 			break;
-- 
2.55.0

