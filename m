Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com [148.163.137.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C326839CD18
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 10:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.137.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788172893; cv=none; b=JNV1cwLJdPedmIs5z+sIAP8MIR4Rs7ZCqA8g7Tmqo1SUnivKhn+8BA8FB4+6/BUNg2tVWU9P69qy+F0DqhoopSKS7A6amuWkfKv5mz0/ZquT0SM9UR0d3WPlgO34KGKQgFqzGhN1IqetIzaZfo0wlROfLLcAetuqdAP5M0bb+ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788172893; c=relaxed/simple;
	bh=GCSC32d7bXw3d4KMlxqPeiR2ZEosAseVs/pYpDE63zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ip8e9JFIVCtp+XJiDFimUxAmJluOvYOzI/97PCyyiLchgOz6Od1WRJiNPXCFqFSNqc4GfOOTv4zo+jcZ0UgLJJddWJR6y/U1w5lmZaIgOKsjpLmXFbAGWDpZ3uKbKntIso7yGqAb3U/DCZFVyX9TEHCsOFfox1zdZxki//o+T7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com; spf=pass smtp.mailfrom=dell.com; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=Ha+oT0un; dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b=mkVyI/Xb; arc=none smtp.client-ip=148.163.137.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Ha+oT0un";
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="mkVyI/Xb"
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V7x7od2499806
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=smtpout1; bh=P8zUYFrBbFiKTXOiK3neIiH74jjQ/0NLKut4
	+P4n76o=; b=Ha+oT0unBGShlmwbrgfltkgPwDnk/9BSzFKZQkKLKhJQVhCN0+It
	J0VjKEh47tqMJEgOJUYJ8u+uhZsyAaYEjFN1dV5AFqRHT1gqcbXRj4YTp65Qe8FS
	Ez/POfQb3jWAxfvU7XxCTWw/GbqZ5NUE9Np9jKl0O77VvCZpSJSOZLPYnPSNybhh
	Lz3vJdinKz+Rbwn+pt1Dvh/K0SdihBy+Yo276Fb2HdMD0vm52p6cAoGHyMGcJDpL
	qx5B+5N8VCsxWxFFHGA6/yyzikSGDiWkppUXIpqWIKBrKSmwNjBt/g/Una5WF9AF
	AO9nDu3pzegRFreuzZkEPYdZeZQ1W/Puug==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4gbtn4wfp4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:30 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VALh2I248615
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:30 -0400
Received: from esapsmtpat02.us.dell.com (esapsmtpat02.us.dell.com [143.166.211.150])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4gd67b9a6x-4
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL)
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:41:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
  t=1788172890; x=1819708890;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P8zUYFrBbFiKTXOiK3neIiH74jjQ/0NLKut4+P4n76o=;
  b=mkVyI/Xbd/tTe6xNAWS0CVTReMNqBq6Z/OCPT4G/SIeQ5k8UQ8z0nAE+
   yVIg8egNNS0zv+9eDwgOJLK1gBTk8EOYR8gKtEbOn3xbFpAnNH+s8WLX5
   j1FYHuSDdsBveTLQUM+78D4tqfG29iCELp8VDroh3o9SVeQJY+lkunGpr
   Fwkpnn595fugdUk8wRsmrN3fWYIiJT2pBt5Qc0deKBZ1b953/40IqaZx+
   yWH3JxZOaM7+R/mO9Z88cax3f2Wdu6KiECqkwkJYidyGlRRJ8T9Jgx/96
   FP7TkBqLSBOBwg9zDnSXJPi6AlarTnjbcBlqehSVCeKKKJBEdK/IBUI/y
   w==;
X-CSE-ConnectionGUID: KRfAK6qGSZWGWM6y+PK2BA==
X-CSE-MsgGUID: 1tXNAxGSTWOUAwV81IisMw==
X-LoopCount0: from 10.94.8.206
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from w-96j1th4.apac.dell.com (HELO W-96J1TH4.blr.amer.dell.com) ([10.94.8.206])
  by esapsmtpat02.us.dell.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 31 Aug 2026 10:41:29 +0000
From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: netdev@vger.kernel.org
Cc: Prabhakar Pujeri <prabhakar.pujeri@dell.com>,
        Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH ethtool 0/2] harden module EEPROM length handling
Date: Mon, 31 Aug 2026 10:41:22 +0000
Message-ID: <20260831104125.2203-1-prabhakar.pujeri@dell.com>
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
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 clxscore=1011
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310091
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfXxdw8HCDtl/3G
 7oWx8xoaYhUxsUl5OqE5y9nB4qkZ0NO5sGEB/jXNHAsKQDm/0YDxE021n1i1XDuUPl2mF+VKTBu
 XnJBkjG+0+X9S5bNLnCNBRS1v/AnRR0=
X-Proofpoint-ORIG-GUID: xRYXrxSzNVGie_Ai13_WJx7xiYMXGWGz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5MiBTYWx0ZWRfXw2jeD8Rd5E7F
 XvXDsmflzTNZQ5bdS+FM9NeWo5G9e+hHA9aXV+XxvfZ3Fq2gS9wElJ/Y4DBdkJEI1jlw+bvAB3c
 Xu8q94u2icd3Npr1UixArqzTrnkjXCVa8HT6qEk3pCcpH73dyQashDkWX2GicHyx2SLDr1k1mlR
 IBPtJVPiOoHZKTfw+nGz59lhvTAnkBB3ZqLuunhKry/AN8gOJa7FdgJj9yDM5XF6OkBtO7QoumN
 dGV6xSAzTBlk1K/vRcOWIw5wYSZ2ulQHkbsPyBue0grtU1a836RAgqQR0SOmFmQ+61Q3Sgd8kwf
 SEKYe4zMZzUCWazUymZ/PXKODplmj+/76jHGYrXPiQzhztJ2B7n5WOrL3+/ocAHc1tG2Gvl/rZJ
 DeXEym/rJOB0HAqTu0+GC7vFGFnfvwJ2adc+Dl2nG5/st0KuA+SvTokjCbKFo+CZkrjytSCkAj4
 EtCBdGQCwORNy0Wqb5w==
X-Authority-Analysis: v=2.4 cv=FMIrAeos c=1 sm=1 tr=0 ts=6a955a5a cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=i8a7nF7jFa3EbZrjgrQYpA==:17
 a=Sv0fKeRqtYgA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=fzG0kLV7QcnNMfXU0kIA:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: xRYXrxSzNVGie_Ai13_WJx7xiYMXGWGz
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 clxscore=1011 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310092

These patches keep module EEPROM reads within the lengths reported by the
kernel.  The netlink path now limits its copy to the received attribute,
and the ioctl path validates offset and length arithmetic before allocating
its response buffer.

Tested with make check in the default and --disable-netlink builds.

Prabhakar Pujeri (2):
  netlink: module-eeprom: clamp data length to attribute payload size
  ethtool: validate module EEPROM offset and length

 ethtool.c               | 9 ++++++++-
 netlink/module-eeprom.c | 8 ++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.55.0
