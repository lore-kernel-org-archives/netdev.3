Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D03B0AE2
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.137.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172896; cv=none; b=eP1GGcZtkFKnOBGdcTgdqSm7i4W975vOjGzhIC2qFMhkzvuoRJ9HmxgkjbreYTpQvg0iptYAOfYLGcbclk56r11w0KOFNxZCNBf4QBxag6t+Iy94LovN0MZDwGgW3tfbTpWV0sHfE4nEV6w9KkhXydtNP5Xe6IESp76wCU17b+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172896; c=relaxed/simple;
	bh=dPU6I6u39e0E4lbCZcAkFIpU8GJ6tsYQekjie00JZp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxwDsfx0P7tc2VD0Mfd3GnLLTw6FBFIAEAw0smyTK96SCKVce+qCAexHG1imKak8JH4NwEyMm7IrKZAvcofzbv1PRCl2uJzUNINOYkWfDD0E+Xzh8rhsaY49JEGlGarnu9sEf3RXA3dIQ1rOa7p5LBxctI38oRHTzERy1y9GYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=ejxlG1I6; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=EKBw4o5Q; arc=none smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="ejxlG1I6";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="EKBw4o5Q"
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xMj43192106
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=smtpout1; bh=lrH04flITzsT
	JGXBhUigFKtnAbWF9rAOUlgIpGem7/g=; b=ejxlG1I6oiCIh47AerBjWJ2fPkO+
	wSTl1LwSIGqjtWYy3vFJmZmOkV8p32W04V8FXEqK/Y4bg5ln19gIGWYwGR3tb1IC
	XkClUDpccAGl65n7bB7JAMsteXZzHnv2uqGbd7VKHlISeecmlaOTY9uHiZhmz1az
	aoI6Ty0ymVu+zsRPdt4qqFNkkiNA7vFkZpMmDbOdLDraHNg9G75asckItKeVhd0V
	aCc3EgpyPiVEQ4GQ+T5n9TmAw93OGpMk+AkNd0KmPWIMIw5J8L2EZFYE9VbU86m1
	I2l+/F8epV103dvK0gCPHfYjIu0DtMQRWI8JmIVR0JhtC/id+iO1B/tHvA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gbv3g57cu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:34 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VALh2K248615
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:33 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com [143.166.211.150])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gd67b9a6x-6
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172894; x=1819708894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lrH04flITzsTJGXBhUigFKtnAbWF9rAOUlgIpGem7/g=;
  b=EKBw4o5QzprdF7ra2vSsn6l4dpwds5bwbJ/+9kaKUC1lHYdWtW233J0T
   zv8Fy15+js68xOFaiyOQDBBLuSDxbRSsiDMnOIeMdBPpKSl4AHS3/bS7G
   FzKI5sPrsZEKJu+Dv5r9HnqCrN2Nh+YZ777fPLFqzUFb/kXplwo628qui
   UH3YIqhyHPbIniUhEx1AhKvcUaBIcVv5mWTm152cJwKShRDBq/89ifYJq
   rKKNJKdEnBgs4XnDpW+GjpLqlEI9FdgXmEccXd7wO1I4w9ZNWF/JlE1Kn
   hjQGJETCMX4t7qNs2rj5940PQ/l9Fs6CIUF/osxRS5BKv8dLApl3nudvR
   g==;
X-CSE-ConnectionGUID: VjV2qHV5QBGJheLo8mDhrA==
X-CSE-MsgGUID: 7uukfKSNQCO1vUnSDugFGA==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtpat02.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:41:32 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: netdev@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH ethtool 2/2] ethtool: validate module EEPROM offset and length
Date: Mon, 31 Aug 2026 10:41:24 +0000
Message-ID: <20260831104125.2203-3-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831104125.2203-1-prabhakar.pujeri@dell.com>
References: <20260831104125.2203-1-prabhakar.pujeri@dell.com>
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
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 clxscore=1011
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091
X-Proofpoint-ORIG-GUID: njDZmF--XT1ri4SbNdqlSTjkUmtYBvgW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX4qgM2detCHut
 Y+oa4p6LOzA4o3FENmf0izqmN0mAwk+yOwXvAn1At/uQpvOtbW1GxwziBdknHofEsz5RuMnbIVn
 rpGDluX7TGNvzpoLvTHDjwm7ZLHx9x9KKg0aHCBm0e5FYS0S/FMknJ8mmJjDmBwDOFvVomgZCuI
 DbI9iNmbJi0eFbrxkjUR7s4rc9HOxq0yPJfFyW59tRV6D14IOH5981UB5yRPo0+vieZC0bpRYce
 J7xRr9OklpQJ6M/vz0o9EJY7szECitU4aq1nZ0eEPS/1tGotFHpK1TP97eIggr0GOe+kk2opBUM
 D50aVOO8oHxyLjrgQvs2Xump6zy/jNazWBcngnCbfmy/1G3gqjUWooeJgaKEAA6usM/fXQSBmEa
 O2a2/gAy57RjFrhraxWce7mYcXUFuk6099FLndOcDC3e4IWUVznYpefpY4Ekd6IYZg495DyjTPR
 sGL99iEXbtI0LnD6T4g==
X-Proofpoint-GUID: njDZmF--XT1ri4SbNdqlSTjkUmtYBvgW
X-Authority-Analysis: v=2.4 cv=B7SJFutM c=1 sm=1 tr=0 ts=6a955a5e cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=Qy6CKLcU0MZ4grw4BCWD:22 a=iLNU1ar6AAAA:8
 a=6ZXG51rAU_E9tX-MSm0A:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfXxKih8cxQ2qM7
 vVub64yeTPGlkGu1OK9bfyrloIxZicz1T4mlH7EPk4Wc+XRhoyJURlZxra+MHnL55QqQtD/9bG6
 YQFH0NiXst6loqK0CWDAcGDHWCscdIk=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310092

do_getmodule() clamps a requested range by adding its offset and length.
An offset beyond the EEPROM makes the later subtraction underflow, while
a very large length can make the addition wrap.  Either case can produce
an unexpectedly large allocation request.

Reject offsets at or beyond the reported EEPROM size.  Once the offset is
known to be valid, compare the requested length with the remaining size
instead of adding the two user-controlled values.

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 ethtool.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/ethtool.c b/ethtool.c
index 3076c12..fa0f729 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -5051,10 +5051,17 @@ static int do_getmodule(struct cmd_context *ctx)
 		return 1;
 	}
 
+	if (geeprom_offset >= modinfo.eeprom_len) {
+		fprintf(stderr,
+			"Invalid offset %u: module EEPROM is %u bytes\n",
+			geeprom_offset, modinfo.eeprom_len);
+		return 1;
+	}
+
 	if (!geeprom_length_seen)
 		geeprom_length = modinfo.eeprom_len;
 
-	if (modinfo.eeprom_len < geeprom_offset + geeprom_length)
+	if (geeprom_length > modinfo.eeprom_len - geeprom_offset)
 		geeprom_length = modinfo.eeprom_len - geeprom_offset;
 
 	eeprom = calloc(1, sizeof(*eeprom)+geeprom_length);
-- 
2.55.0

