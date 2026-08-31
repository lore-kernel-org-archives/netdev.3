Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC38B3451C8
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.137.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172904; cv=none; b=TJGH1LA18LUX5V5Z1aJUDto6iMuQm/sNvSL+5BpOENAqvPHgOzYlTiD8bNRz/ax/0hdQ8BzaUaSaTIQQXTO8mPF8rm0WUnL6JQXvuBai/QNR1NgBRm76SBMHARyyxqckG6PQUiV768EuQkmIPUD8rJEw9C6YJ6ogqZwXIeodfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172904; c=relaxed/simple;
	bh=rA3/PbU4WrXp7ee6LsL4DHwbyYzhAfrwPEfO635R8xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rwR35b8IS2R/jQmDCW7Ah4WXWb4bpE3kgzq++btzg0l1XWxgbMrlPMk6oXH7plgWs8Cl4hC4TaEmjaw97i8jk7lCbgcp3ECDQn8OmnpEP91UdsvTFdtX8qcwL5YRvxzEUgtPZxoCZaiLGASNWLvuhZik1QP1TGouExVzPNCcrPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=hdjHtiBr; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=N3RXD5Qi; arc=none smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="hdjHtiBr";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="N3RXD5Qi"
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7x38Q2499685
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=smtpout1; bh=5HiRryrJYfJb
	m/FHWrmjRvfzYk68dqF1E5JAqLyOhOY=; b=hdjHtiBrT7JQI36cW6B/OFqSFxGK
	wUwV7OTbzlJZkUv19wUwEOoGkajk+0gyq44OGpUukMMouOgAabhJc6TSRyVJu+Kq
	4WoazuZoBgyEakLeakU+zUOyNa769of73gnxQ7tDENJRzsQz2z7GtD/wAaXc4dmj
	p0Rwq9yHPqK4J1iXIUsSSy1HKGgUlf4YvW9p/EOZIfajqWkR9tHLhwI8Epu4M43Z
	1Hz+tz97BI3AKfcWLhJ13UOjiG+AHEv3wSQADEfACyVUjAQUEpxdogVLu+yuO1oI
	XuO/Ql6kSvUfyoBkSnz02e/qA/W1Bh0FvTTrBY6UapP+YnjVWaM6rer8Gw==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gbtn4wfpj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:41 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V96gSq1865631
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:41 -0400
Received: from esapsmtplv07.us.dell.com (esapsmtplv07.us.dell.com [143.166.203.154])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4gcnjksb98-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172901; x=1819708901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5HiRryrJYfJbm/FHWrmjRvfzYk68dqF1E5JAqLyOhOY=;
  b=N3RXD5QiVRxrhGA0EUpbZB8AnhcXPWO1qdC+0KXaMOdx34DyenoA7IK3
   q/LHkyIK3lHETQpT8zCpY/sL1ZYj38K2zcdwBbjkQDPbNMIbQp3XM/l5E
   f9JaA5pl6CShVM/sIYsbWzd1uwZ6IsFNusNk3OyGsSLsEhB3dbWq+uONE
   2oZCMfQJQ1BJL2/xxLMn4J0FKlBKpnVk47bw4+3aD6kAD/4yqG7jvwS3q
   vvC/4hTEbhKSQcir5htOLLQl1e+BivvUWo6CcR8mj/EaI4JAu3AdK1903
   1u40UTLZv+VwXsbzMoTn9gD0HpHkDmTOwqriWIA7Beb1CidZnVnEPPpy0
   A==;
X-CSE-ConnectionGUID: 0mpN6SevSGOqdglu6DeADA==
X-CSE-MsgGUID: uOHaaCxqTzigO0hWxLze+A==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtplv07.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:41:39 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: netdev@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH ethtool 1/2] rss: bound hash function masks in text and JSON output
Date: Mon, 31 Aug 2026 10:41:32 +0000
Message-ID: <20260831104133.2216-2-prabhakar.pujeri@dell.com>
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
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX5+5uS2S7jBOy
 1CbY1BP0cTUBxs1YLtYmE4W+nkgqiXy5mSX4S2q2O8Yj94ZK5cKgyDXweq+dD6oHTbCGp1A0mcQ
 heKx/5PIMSBIfwjKb+IZfhvRo+gGLAo=
X-Proofpoint-ORIG-GUID: Aql-RXfs_D0kf428QoJNIn0yojdeyFHu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX1BMEg+FXixNd
 +PwSF54HlW3C5F+OCrrBH5Xm4JtOol2znwAJ41cTqf3TgL0FuT3HL8EIfl4VaSBo0/i+jVs4SWN
 JCUVI0kvDLmHq1qGkWQ6VyvTIyzmZ/Qk8tzh2dC+D8DFgQdziRAYCQzohZxXFIv/dcDlQMEzNGx
 g3DuE0piKm4ZhO0E3W1JjDomUlf6w69KuHix6hQDs6LfglpbRraEGS952oO1JMOa0vEljQ0/54d
 CdlNs/W5aDPmbM7trDtzRqD+3sV9laKiuhgcaqnSdKYweBo78/CVuSF7VrL/i+0ySBCmGAVA2ip
 /QbAxpXOcnJpLwQRtIUG7WC4wmUCYEkQui67UhjTozwkGiGHhJOHpKruVhXrfQDbeHBSCTKSX/3
 0j4HsTPqr3muak3U7mE0CD7eUH7EWyzbvdX+NReuFibxPXid0aSLiZawZ4e6VnKnMHmw7R2ODaa
 bVDEc9dCxSL40W1oo7w==
X-Authority-Analysis: v=2.4 cv=FMIrAeos c=1 sm=1 tr=0 ts=6a955a65 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=FlBIjDbFArVVlnHZBJJA7g==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=iLNU1ar6AAAA:8
 a=v2UsagvcdoPkTUP1N28A:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: Aql-RXfs_D0kf428QoJNIn0yojdeyFHu
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310092

The RSS hash-function string set can contain more names than fit in the
32-bit ETHTOOL_A_RSS_HFUNC mask.  Iterating over every name can therefore
shift by 32 bits or more.  The JSON helper also accepts the mask as u8,
which drops its upper 24 bits.

Keep the JSON mask as u32, bound both output loops to the mask width, and
use unsigned shifts so bit 31 is well-defined.

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 netlink/rss.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/netlink/rss.c b/netlink/rss.c
index 83cc504..85c2bd9 100644
--- a/netlink/rss.c
+++ b/netlink/rss.c
@@ -21,11 +21,15 @@ struct cb_args {
 
 void dump_json_rss_info(struct cmd_context *ctx, u32 *indir_table,
 			u32 indir_size, u8 *hkey, u32 hkey_size,
-			const struct stringset *hash_funcs, u8 hfunc,
+			const struct stringset *hash_funcs, u32 hfunc,
 			u32 input_xfrm)
 {
+	unsigned int hfunc_count = get_count(hash_funcs);
 	unsigned int i;
 
+	if (hfunc_count > sizeof(hfunc) * BITS_PER_BYTE)
+		hfunc_count = sizeof(hfunc) * BITS_PER_BYTE;
+
 	open_json_object(NULL);
 	print_string(PRINT_JSON, "ifname", NULL, ctx->devname);
 	if (indir_size) {
@@ -43,15 +47,15 @@ void dump_json_rss_info(struct cmd_context *ctx, u32 *indir_table,
 	}
 
 	if (hfunc) {
-		for (i = 0; i < get_count(hash_funcs); i++) {
-			if (hfunc & (1 << i)) {
+		for (i = 0; i < hfunc_count; i++) {
+			if (hfunc & (1U << i)) {
 				print_string(PRINT_JSON, "rss-hash-function",
 					     NULL, get_string(hash_funcs, i));
 				break;
 			}
 		}
 
-		if (i == get_count(hash_funcs))
+		if (i == hfunc_count)
 			print_uint(PRINT_JSON, "rss-hash-function-raw", NULL, hfunc);
 	}
 
@@ -159,6 +163,8 @@ int rss_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 				   hkey, hkey_bytes, hash_funcs, rss_hfunc,
 				   input_xfrm);
 	} else {
+		unsigned int hfunc_count = get_count(hash_funcs);
+
 		print_indir_table(nlctx->ctx, args->num_rings,
 				  indir_size, (u32 *)indir_table);
 		print_rss_hkey(hkey, hkey_bytes);
@@ -167,10 +173,16 @@ int rss_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 			printf("    Operation not supported\n");
 			return 0;
 		}
-		for (unsigned int i = 0; i < get_count(hash_funcs); i++) {
+		/* rss_hfunc is a 32-bit mask; if the kernel reports more
+		 * hash function names than that, cap the loop to avoid
+		 * out-of-range shifts.
+		 */
+		if (hfunc_count > sizeof(rss_hfunc) * BITS_PER_BYTE)
+			hfunc_count = sizeof(rss_hfunc) * BITS_PER_BYTE;
+		for (unsigned int i = 0; i < hfunc_count; i++) {
 			printf("    %s: %s\n", get_string(hash_funcs, i),
-			       (rss_hfunc & (1 << i)) ? "on" : "off");
-			rss_hfunc &= ~(1 << i);
+			       (rss_hfunc & (1U << i)) ? "on" : "off");
+			rss_hfunc &= ~(1U << i);
 		}
 		if (rss_hfunc)
 			printf("    Unknown hash function: 0x%x\n", rss_hfunc);
-- 
2.55.0

