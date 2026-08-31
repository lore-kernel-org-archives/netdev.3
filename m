Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com [148.163.133.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C129D39CD18
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.133.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172902; cv=none; b=fCq3e8Gm0QnjVgtn/YxPe+RUNapW/fqH9H17O3S/DfSNrouaSWA8Q31mVb19DDc668M6QenRIAGHaHWAqnab+IYks+7agwKxXb+h1l4Rn3oKQSEPmvmpb0IKfx9CC/Ew0jVp/Ljx0+urLiiq20evH0mTMBqx51qJXn0CzkCp2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172902; c=relaxed/simple;
	bh=f6+xUQ7SHLWLiHx4D0H0IqIMuWBPQhXle2RFTKl6pEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qwV9Nj6ccD3QJXvLRt2EnLFyye93Go2TAUWwv/owF4a3UJtz9MfV5BwLn8KCX4LCy6r6paXTfcwEHrwQD9p80sQDydDJo3fDTwHoJNHPB6a76tsK9jDaQl1yiBCi0QiBB+iXIwp0/FdaItCHVjIvlVTDZ9ovf0IU8Psg9FHndiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=VOy5ui4N; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=TRQ7/+a+; arc=none smtp.client-ip=148.163.133.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="VOy5ui4N";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="TRQ7/+a+"
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7xPPY2642289
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=smtpout1; bh=GkhSXlgZrIdf5NYXatacXVyVIB4DX2rA6mTa
	YIHrzCg=; b=VOy5ui4N2dtL7LGswqISQliPRb1Vh8rNGfcnWYtuUKjEtY74+jun
	mQwqf2kdDE5lcpOpRutQ6B8z7JZswEe3DP2jDXyniZCyPbFECWgYoKcWDOeYuyw8
	0pjB0LStJO09z+e/wgA4HsH6vV0V4p237uNyWam/ji2XRBdhZJUtsH34GrbxcPJ7
	chaLJS1+Rsy6aszY6VGYRa1K1skNDoX9v2n2XjRWDLl3Rg/uiQ7eFvTiUEbWjgdk
	1J9tYJuHTS/cmJ1g92imMVV3amx6avV2NFnYH9vq50dwsdgA2a8FR+B1AeMGiLJv
	KKH4uax9GRz7YbkLlvRSSsWRBvcJ1rL2/w==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4gbuedwa77-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:40 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V96gSp1865631
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:40 -0400
Received: from esapsmtplv07.us.dell.com (esapsmtplv07.us.dell.com [143.166.203.154])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4gcnjksb98-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172899; x=1819708899;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GkhSXlgZrIdf5NYXatacXVyVIB4DX2rA6mTaYIHrzCg=;
  b=TRQ7/+a+vAtTbXjhlzDiywnHdc3215fDEXzNRT05m25kgWhCZCoiuOV6
   z/oDOL3wvfTeO/2KXXEG4ISGgb4sdyg74Zi75wJHXgeKc3A3YQQ80/A9x
   oDRVI+IN/CQrALf2MRcjhvr8x8ziL3jG/z9SeoreM4NbkIwAKpiueN94z
   lt93AEsZ4AERMAjgpdH7raIPBem4UVGkwAQzlF72we30hUbCEObhZSTVN
   S/kRoVFJE6wNyzl1fFGB+k+1cpT0hRIJXkkUH5mkC5FwOCIr/4eJPSll1
   Fcx26yKp9ito93jHzpEjQrBWw52Irlx7VRiW8qsspzYirZppW5uxTjam5
   A==;
X-CSE-ConnectionGUID: U1VRVNziQoGP2qeDf/DFIw==
X-CSE-MsgGUID: 9cOnkS0cSoO0/59YYSkfnw==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtplv07.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:41:37 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: netdev@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH ethtool 0/2] fix RSS hash-function reply handling
Date: Mon, 31 Aug 2026 10:41:31 +0000
Message-ID: <20260831104133.2216-1-prabhakar.pujeri@dell.com>
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
 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1011
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX279PGR+TNquX
 tQkk6wKfKH1kqn1op434Y2ZdcHxqU+vl9qQ7pHweo0C5TPAbL3QJ1xNCN/cD6okNPZ4qjVQGH2K
 1eCeMnNu8dCzanVQl3Cs5Zs6iTgBH9Y=
X-Authority-Analysis: v=2.4 cv=FbUHAp+6 c=1 sm=1 tr=0 ts=6a955a65 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=FlBIjDbFArVVlnHZBJJA7g==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=PpEg0BoV_A2aca28hXd0:22 a=Jwe_olJ0Zp3QmIFlM1sA:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: 8YSWg-j01vEsMHAhzQZb6N4lq6eZJyf5
X-Proofpoint-ORIG-GUID: 8YSWg-j01vEsMHAhzQZb6N4lq6eZJyf5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfX9wu7/CSew0r0
 ZWyYIPmrVpEMZax88DPqHNKbMFaumH2xPUYNcY+xr4i3PAYqaZ1qLNTW/0HT2KmNtNncn+gCXaQ
 Gu5bVw3sJHtRUsMyhRPzspXd0Aj6YVrt69jsVdj0vVVsKMkAq0Z1ESrckgignvr9wlP4BFXExLl
 euyp7RAkWHls/U82sajxUGO7egUrPvZqs+xcMmuW/m/xeeBfYEi2cyRUjYbWRusOJEMRt10+CZ/
 EcBDGdaAHeKB8IN3ARk36VJNI/QHtLd6gqi6exB/WAExgvK7lqyWRh1dzjv9ntnaTHPB6gOva+5
 efH/GDgw9gqCCZTn5qo3A+Yx7ZzstPbbNyuWvT+Hkr9F5Z9p0gXS0VxlaFZFPMU3RoSweM6XIXZ
 9eK5p0Yoe5u9fLyWh7UrTBDg+iNAvLt5GRmUQnMGfJtsqdDCQHhw6hmiGxjkcWyqQMFpoqdKvS4
 1U0mGyOPszuHf/sJ4EQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310092

The first patch keeps RSS hash-function masks at their full 32-bit width
and bounds shifts in both text and JSON output.  The second removes a
duplicate parse of the same netlink reply.

Tested with make check in the default and --disable-netlink builds.

Prabhakar Pujeri (2):
  rss: bound hash function masks in text and JSON output
  rss: drop duplicate attribute parsing in rss_reply_cb()

 netlink/rss.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

-- 
2.55.0
