Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA89A3B8D75
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.137.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172906; cv=none; b=mjPTGeh415Uy70wyo72SAi/O+7GBjlP5gRF9Q4knAqnLs0FWbnIoIUiHE7wFNvzvOqZaQ0f6dqdVNvQTWZP7FOoQTKkDhYxH+GaAT5AqOiUbN9jhjQarSXaSOMQ3ba6SV8FameCRvbqjZP3fCMjfEkMdtm9gBsESSEcLQuuQ6NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172906; c=relaxed/simple;
	bh=+S/OkmRVNEDou6b00VE1VtoPmQecCoWhzGLIe6Xf77g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p03YBhQsuH58HxI4jZALug5OPtlalihtUU4YqVHhzkN4qyZXbzrWc4ZZU3hJ1e1o3c8lOKFIITFMbzSbGow4un81pcww9ONWaNXYoDWiw2vDVgI2MkczoP4cETXXxANS0LYmngBbxgsXxPxS3K42cXd0xBjGFMdnR3SqXly1y8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=VmhFKbsz; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=RTKQt8wG; arc=none smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="VmhFKbsz";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="RTKQt8wG"
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xHgZ2856469
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=smtpout1; bh=tMxRSBrgoBtE
	hrryAtzXs/uG00kjhGZb9/QQDYEE5vc=; b=VmhFKbsztxOeDAQR3JgrN9gZAH8C
	3p8Io4DKKV7INfTMZi7O1lYLaIYrALSqhB0Apo5Gh8chsbc+e2dKy3SmMoivRi/d
	Jyk2sPWJ8LRr5w+rVGgojSEDM5Nq5+mhtLMBtbss9HJRD4ck/unsrLg47px5NAX4
	jBC68SbAMtwOcINzOOWzsWXnd/0egyc0UZ4JWikEhHlvmtwvpG/mO46Elm5zbyM0
	ct6MKxlcJ6eZuIncpJ3jRew+oCvl1iKFZtEFTVFssW3KitIhxJqc7xikkavWm7Dc
	S1ApJ1IEpZ0MIN5shAc6FD6sulPDupCL6RFP2/c7k98qwBoh/WlPKNYykg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gbrgq5pd9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:43 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V96gSs1865631
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:43 -0400
Received: from esapsmtplv07.us.dell.com (esapsmtplv07.us.dell.com [143.166.203.154])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4gcnjksb98-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172902; x=1819708902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tMxRSBrgoBtEhrryAtzXs/uG00kjhGZb9/QQDYEE5vc=;
  b=RTKQt8wGGYNhTnJkVUC5S7w5IKTjcKtd9mPlut7CFJzKxDSVd7Qf7rl+
   ZdaJOdENwWOBAFJ4ZO3DeiQwB68SkHSOT+aQ3RS5Ln6EjoBdFBQ17BP1B
   KEFd3wOTCNdemnyBLylGOPsDAaKqXQpd2JoXjC+RS3GCZagZd1PD1f4ob
   oCL0LO7YM2UP4ToNinzw8DqZytJJ/DW9SmreovnTD66V59ic+79qsVpQk
   ku6NU++Dkm9r92oP1mg4Ap+jiU26XgeLeQD+D3ycExJj5pdi8DCyJvbIs
   pe0UCNDgeUah/eR6y9MStdNzSn9sOWST+lpq4lQFkrQrnhfDiV+gE7z5x
   w==;
X-CSE-ConnectionGUID: No9y+OvVTH+wPiSllNHnnw==
X-CSE-MsgGUID: z3RnMMBOTA+Z33Si3jV80A==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtplv07.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:41:41 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: netdev@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH ethtool 2/2] rss: drop duplicate attribute parsing in rss_reply_cb()
Date: Mon, 31 Aug 2026 10:41:33 +0000
Message-ID: <20260831104133.2216-3-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831104133.2216-1-prabhakar.pujeri@dell.com>
References: <20260831104133.2216-1-prabhakar.pujeri@dell.com>
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
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091
X-Proofpoint-GUID: GoV0lj_3YjDLvUK0ufxKkS5qHt1ZX42Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfXxjtX5i5/vFZi
 KiQWrBcQUhS1VdFMsiCQlZ8dnWlNXJb8IXKqeLgiYz0IUGS8DuV5/YChjmuPBienabO+pF7anMA
 9zi9dxgF6NNMgiFpvYxoaGiEjTdfev5We0oSbjdUr5GjDPIgI9Wfe+0Q64EYACcfYWqkXR8+RRq
 5OFnHNnn9GIHZkIirhj/uC1TO+HVNC+PVd5zJtr9ylQ6umGoP9ZxAKTAvJcANIR8KaczHJX235I
 cqWwP+J7D62bMj10IRYO/uvs6p19UcdPBhpkOPk/rV0hTHpPxmRxa1kCyjJG6Kmgbv1smtJmHZH
 bcySaMNe5jrO9OZ2e45dbOKjA4cKBnku/CgsJkc44LdchsZ1MmlOZ+DdbF0nNC7vrBEVzaRjS1e
 95elLC9PNOE7yjOZgwmjZm0yxC14wCx12y5b97y3XrDJWY9boBv8TsBWHUi4e8U4o7eU56KwYbZ
 ro1gTw/ml8pBZ0TWKnQ==
X-Proofpoint-ORIG-GUID: GoV0lj_3YjDLvUK0ufxKkS5qHt1ZX42Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfXyrpa/FPbjNUe
 CJwBRJZrGAO21yHjqXP/Z9X9ouuAJ5IqxTJBQTJBww82N5S4MJiw+0zBjzTqwQexq4eBal/LLBM
 5+E1j2X9MVEplwAnx9RADJ8tL89PJ50=
X-Authority-Analysis: v=2.4 cv=IoQutr/g c=1 sm=1 tr=0 ts=6a955a67 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=FlBIjDbFArVVlnHZBJJA7g==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=U3ti1ie9CgboSd2qXsAw:22 a=iLNU1ar6AAAA:8
 a=NLrgXGbizIUOXE2jB48A:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310092

The second mnl_attr_parse() call re-parses the very same message into
the same array as the call at the top of the function, and none of the
code in between touches the table or the values extracted from it:
all attribute reads happen before it and attr_cb() just rewrites the
table entries with identical pointers.

Remove the redundant call; its failure semantics were identical to the
first parse anyway (MNL_CB_OK when silent, MNL_CB_ERROR otherwise).

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 netlink/rss.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/netlink/rss.c b/netlink/rss.c
index 85c2bd9..8c70c29 100644
--- a/netlink/rss.c
+++ b/netlink/rss.c
@@ -149,10 +149,6 @@ int rss_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	hash_funcs = global_stringset(ETH_SS_RSS_HASH_FUNCS,
 				      nlctx->ethnl2_socket);
 
-	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
-	if (ret < 0)
-		return silent ? MNL_CB_OK : MNL_CB_ERROR;
-
 	ret = get_num_rings(args);
 	if (ret < 0)
 		return MNL_CB_ERROR;
-- 
2.55.0

