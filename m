Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC939EF01
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172895; cv=none; b=VdIezjZm8eLc/LbvuO92L6M7FIVySzJ+ZJXkbk2HRVZ2YGTyPuATRCFFdzRwr2skuXt8i3HDrTSdJ8syWu2nntbC1O7aaKUTbXH5kDrpqwcFA3LEBanPZAzSegP9+WmIaiYYY6/sXsNJ59W/lT9xMltn8cgF4NQlF0Crq6hk2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172895; c=relaxed/simple;
	bh=yPtiBBh5qtkWdHCrhExPfuEFC8h+sMP9wxtizQIurPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I19yTDsbh/Hbtln6mR4znHg7HN3FtCGiOyXqSoCG63Cce8wTVCnewtBCHip/N1KVh+A2yNZA8W45gqdCMag7DptGxSUuGwAnDxE22Ig+v/EsgrT/EYq8odu3mBvJJiolekffiL2inBqyRDXF8gRrjvDnplpTL1GSxbFmWMYsFq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=myVtDSF8; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=h6gcOg1a; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="myVtDSF8";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="h6gcOg1a"
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7ww7v2641103
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=smtpout1; bh=tDGCpsr6GC0P
	vKRPWW08Yez3fEMzqCAvpGdsiAXO9J4=; b=myVtDSF81on7mrCDxKiq9jrdUhqI
	hyGnepoi84rmgjOhtBugSmZFtfLCH4LzEU1CTWeHijLjgxFiWDEQaMFk+WKYNoVD
	/vTfWOb6qpMHahjNwIvQDRLRx1HmS5LruVF92hl32Ejkvsdj7rLxGY4GKRMlaTTV
	pj2lmyuI1+ZWZQvd38Zc3g6Zg70D1C38UDZEVIGFZrWMIEsBZuTbIE/E5JQwHJvJ
	Rx1uoOP6g/4LxtHsKjObUzXRVRoCHdRd78oZ8Y70x08Wwtt1ilcW1b+4nXzCga+U
	8+oGk5SmJF2Um0omj4lGCGFRavgiZVXW+gpVVv428F1rRh3yLvkvjV1o8g==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbuedwa6v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:32 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VALh2J248615
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:31 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com [143.166.211.150])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gd67b9a6x-5
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172892; x=1819708892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tDGCpsr6GC0PvKRPWW08Yez3fEMzqCAvpGdsiAXO9J4=;
  b=h6gcOg1apyoGeU33HvvhMjiYXSnTmq1mVyvhh/frwMcoijQd+olr95FH
   So0mnqogj4Fk8PKMRnQpbm9L4p0n9u6uTi/Aoi7LgJ0qVM/EiHcg0UwQJ
   YT7gTLBOkIMk2nE+z5dRbpT9rfoVF1In8XpWcufcbMo9mjX2yZzDzeeLE
   MzNJkfd1F6SrlkcK7y0d4iHGXsez520FIJNuGVYKltIA1WOZNl3WIjhEM
   w4oZEMiRv92VymUkj4tTaK8sM8NmZITlvOpYe6ldFQxYo6ELg0OOZRkOD
   H24si+m5JEGeJpCW0zs9I142UqvXHIZSNgtyFaHV21Jmi+R9guREhWQ+4
   g==;
X-CSE-ConnectionGUID: VTMPpd+aQMWwp+dc5oNOjA==
X-CSE-MsgGUID: LdlwQ4dxR0609I3QzXVVEg==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtpat02.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:41:31 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: netdev@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH ethtool 1/2] netlink: module-eeprom: clamp data length to attribute payload size
Date: Mon, 31 Aug 2026 10:41:23 +0000
Message-ID: <20260831104125.2203-2-prabhakar.pujeri@dell.com>
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
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX1mDT+HYDq5hV
 89E55r/vOTMl/VQiM3PnUTUlE8iGFqtDx+CAEaeb3qNVwOEFp9DS4wuEvg3T+TWIBTzEI3iCHUG
 qhaumjXrd/Lz5uS5cXkN9SPZgpcBEp8=
X-Authority-Analysis: v=2.4 cv=FbUHAp+6 c=1 sm=1 tr=0 ts=6a955a5c cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=PpEg0BoV_A2aca28hXd0:22 a=iLNU1ar6AAAA:8
 a=LsdQg7GxoRn7zjlC7f8A:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: qL4GxEW9kNWG188q6F0ZeA2JXsu8T39i
X-Proofpoint-ORIG-GUID: qL4GxEW9kNWG188q6F0ZeA2JXsu8T39i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX+Y2jPdhTo9eQ
 bi2NUA9yxrnbTaQPIzKDI40dhbVqfWKSl87sXzq2WGZIyyAUXKVp6hG5wZoJCJc+qPIcyg3P1x0
 wuRVRCTxvxUUXmTX7xb9AqmouM8kpq733GbjcQOQIRhGbUME5oVr4BL4ufKWpleAqlkFEuUw3TX
 b6anvkdeMoBkvmO4a0Q77t3ywcXPuXJRNAwZAauYhGiPHn6cwHRqMMCpUE3rFJoN5eRX8zRUqbH
 MDBdxqkhFSEyE9/9sMi+c8F9t8hYNmmd1TKBicVp3gf7ki0fyM37O6Ti9CS6ipa2IIUa8klNANG
 4p7Quh30Cl+iaXZkjr4eS3KlSMjXK6KHjuqase5rV9njl7SAD8GmLdAjqubvVJ/egRSzNbdKyo3
 COzoTrAFxYtx4cuUJ/WwMXS68agIhTy5lwzW0VsyYcRYJF+0SLgVyWlNT9WEAiAH/9BaEN5ALhI
 cprpn/ksY5BLYQWaiRg==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310092

get_eeprom_page_reply_cb() memcpy()'s request->length bytes out of the
ETHTOOL_A_MODULE_EEPROM_DATA attribute without checking how many bytes
the kernel actually put into it. If the reply carries fewer bytes than
requested, the copy reads past the end of the message payload.

Use mnl_attr_get_payload_len() to learn the real size of the data
attribute, like other parsers in the tree (e.g. netlink/rss.c,
netlink/fec.c), and clamp request->length to it before allocating and
copying the data.

Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
---
 netlink/module-eeprom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/netlink/module-eeprom.c b/netlink/module-eeprom.c
index 40882ca..7e2af4e 100644
--- a/netlink/module-eeprom.c
+++ b/netlink/module-eeprom.c
@@ -133,6 +133,7 @@ static int get_eeprom_page_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	struct ethtool_module_eeprom *request = data;
 	DECLARE_ATTR_TB_INFO(tb);
 	u8 *eeprom_data;
+	u32 data_len;
 	int ret;
 
 	ret = mnl_attr_parse(nlhdr, GENL_HDRLEN, attr_cb, &tb_info);
@@ -142,6 +143,13 @@ static int get_eeprom_page_reply_cb(const struct nlmsghdr *nlhdr, void *data)
 	if (!tb[ETHTOOL_A_MODULE_EEPROM_DATA])
 		return MNL_CB_ERROR;
 
+	/* The kernel may return fewer bytes than requested; never read
+	 * beyond the data actually present in the attribute.
+	 */
+	data_len = mnl_attr_get_payload_len(tb[ETHTOOL_A_MODULE_EEPROM_DATA]);
+	if (data_len < request->length)
+		request->length = data_len;
+
 	eeprom_data = mnl_attr_get_payload(tb[ETHTOOL_A_MODULE_EEPROM_DATA]);
 	request->data = malloc(request->length);
 	if (!request->data)
-- 
2.55.0

