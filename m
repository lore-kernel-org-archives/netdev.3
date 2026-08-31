Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7C39FCCA
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172888; cv=none; b=YEi7wOhh4DQRKiAciz4w0GfeMoJmL+08cAUc4WGCVJRB6DmI0AQt+gAvzFknfud/DPlEE9ztPgDqFlkt9qLtx583BChQQ3hRGxzRc+aPCrBiQT2FCbJoyTnG4flSORlj6hdeMLVpAE2fuSQgKpwUfZFwicBB4D3F7N4Nsmx58WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172888; c=relaxed/simple;
	bh=0RTWqE5iZ+yXp3OHoTwAWI3YvXAVTCbnQf/Oz3nTwc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqAfQyV/8GaREgcBeYRY621w8WG03SpxuROrZrb+77d6otP7rlegGBBwlgCltgdKs3+w2uD06SfIHYlb1tia3gjlD2ooZaXUWp/HFt+eCbgY0A+qBM3g0ry9Tpa1Uz0YJz300rQs/DUdJPSY52bk9HRYoO0/9OVSM2rSPl7Aq7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=kHTlmJ8c; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=LYSHQ1Zh; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="kHTlmJ8c";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="LYSHQ1Zh"
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7x1NH2648323
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=smtpout1; bh=XsIHXMwESyki
	HFivcXXrGjX1NiETQwKn36pbWF6f5wM=; b=kHTlmJ8cyZXd1AAzALq+wGJR0/TI
	hSliwNwFgnaNJNBDJY6ZlHFFbBk5djipmZg5zn1TpAubZMnQvrBYjtTndEmRhh9Q
	j+eXplIAd7bqAolCyO3Hy1rf2C5P66BrT7zSu6leNzg4R6V5YtdaeCODWHwxIaAt
	B15JTplo76swF03aDCsI60aSYIdmh0iuAGL1EsNpOZPhNpN8Nq/WN+ED+4lNk5a9
	vK4YmrWwPWx2WGl5VdLkMCFPbIzD4Q02aDaQe42D3lZysdIn8Mw6/bxljTVNlZa9
	BHivsOn1YdE5diY/c76RFl/DQ+rvgSPvrvpUmYeJhY+yWxFVxK3uJF8iQg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbtrfwd76-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:26 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VALh2G248615
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:25 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com [143.166.211.150])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gd67b9a6x-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172885; x=1819708885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XsIHXMwESykiHFivcXXrGjX1NiETQwKn36pbWF6f5wM=;
  b=LYSHQ1ZhMcKCi/I8ofuBc5NSNrVpP42mT97olV+4J6s06xdh7/767B8I
   R7dHPXUiXpxWVUhe8XSnDHY6KhBSl6CyYlGCx+YCrDxNMW9V0x+2vqB61
   cyRruprR0xiTGy9X4IG/jMnBTZ2diBP+4imEFRBiDhwRfD28l2hz3WkQ/
   A4kZpAD3ZyJkpPuhYKEM3p9h8IHV2vZPHuY8CJvNdQZ43IstX67ZYfGSr
   MY4eGPPjIu3nHusyQygp70EexjWTINjXSnR07KA4guEZGo8VwWK0YMYrZ
   p18ZuSj+dJaIeRfW7ZInBL8nmSEarsHMkskFlfw5YKLU16baQkLAJw+EI
   Q==;
X-CSE-ConnectionGUID: 9qita1tJTGmk8t2YIyRnXg==
X-CSE-MsgGUID: oKbWQgaKQS6iPuZbsFqz0Q==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtpat02.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:41:24 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: netdev@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 2/2] ss: validate sscanf() return value in netlink_show()
Date: Mon, 31 Aug 2026 10:41:16 +0000
Message-ID: <20260831104116.2190-3-prabhakar.pujeri@dell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfXziOzDPiPSRqw
 UG4CLUUIUoiJbw2W+uSfF3wJ9ZGy5eEIoo1r1v4PB65Q24utCyrHjdvN/DT2zSWYPaZss8bOtc+
 1vtiGbHMS9q2fo5VL8/aiaWez6qaBL+BHOAiRRy0AfvWRZAW5k5TIM+97HYGRehcfRMOreNnA2A
 TqaWdP4mhd7V/f/Waq19lwTCtps2QGUIEADpZY0mKHgMAFoX9z96QwUgSXF7J6pvEXHGBQUjG/h
 2n8nkxEB1DqWTdLIqvzsFGwSjljY2Rkv/9AmgRekiSilDvpau0382auZK3sIztYMkNR30tcbo/t
 8htlwWqfzQJN6qzX9LC2jE6ZWHT9yZmHYaqwdRlcoFuzI79GVXX5tqMEWyGqJ3GmwpWkXk79LME
 2U+CEOTQMovXaa7AvvBDwrCGLsiWCUJK+pnV5045MrsvHFT70lQS1SbPgJMXP+nGC+Pp9LK6rTt
 40x9A4hL7HNZvN+euiw==
X-Authority-Analysis: v=2.4 cv=SeXHsPRu c=1 sm=1 tr=0 ts=6a955a56 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=2Lpba0WeoN7BYVdwMO11:22 a=iLNU1ar6AAAA:8
 a=EaIn_wvRDERPLUWATj0A:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: L7C6uKCvCMZVaJ5vE5mvzSH4262zcnrf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfXzU1dNrpFztou
 UADBJ5L/BjWAlyV5EYvzlPoo3W/MMUsT361h+fdqK0+tO7RCELGiAop7+7L/7PvasuDH9BbqEHz
 XXf+FIF1sInccI1a4aMuyKFH5Zn1rGk=
X-Proofpoint-ORIG-GUID: L7C6uKCvCMZVaJ5vE5mvzSH4262zcnrf
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1031 priorityscore=1501
 suspectscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310092

The /proc/net/netlink fallback loop never checks the return value of
sscanf().  On a malformed or truncated line the output variables
(sk, prot, pid, groups, rq, wq, cb) stay uninitialized and garbage
values are passed on to netlink_show_one() and printed as socket
state.

Require all eight fields to be converted before using the values and
stop the read loop on failure, consistent with the other /proc
parsers in ss.c.

Fixes: aba5acdfdb34 ("(Logical change 1.3)")
Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 misc/ss.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index 098eed27..7d9c5e91 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -5299,9 +5299,10 @@ static int netlink_show(struct filter *f)
 	}
 
 	while (fgets(buf, sizeof(buf), fp)) {
-		sscanf(buf, "%llx %d %d %x %d %d %llx %d",
-		       &sk,
-		       &prot, &pid, &groups, &rq, &wq, &cb, &rc);
+		if (sscanf(buf, "%llx %d %d %x %d %d %llx %d",
+			   &sk,
+			   &prot, &pid, &groups, &rq, &wq, &cb, &rc) != 8)
+			break;
 
 		netlink_show_one(f, prot, pid, groups, 0, 0, 0, rq, wq, sk, cb);
 	}
-- 
2.55.0

