Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6A035B632;
	Fri, 25 Sep 2026 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318406; cv=none; b=o4n/SoZFdEQm8EOpA9/ztD7CG2edd3qracXcJvpsLTJvFJrPaTPg82U9C2nnH286A+zs7Gk36CuPDMWhH5zfHpl2PaHPv4Jr0hTu3iY44AW6GF1632icDaCs9fs0/JzhG0v9ClXbfBSwy6viQCvAs8G+vG7KcvMiBSiLVT0vlIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318406; c=relaxed/simple;
	bh=X7W+v3OhN0BEf9XjBV2u5tsUe/V0pc4AbUdnHcNPxm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tzf9eUQxH3UdKdi1q9bem1l+KwfHC4W1DTPIZXJvY05HSFpVidPJ7lR4Yvpgw+eaQ1KIMGynEEbz9iLIPAtsE0MR4Ae7qpXbKBxO4DE/f+zGEgivQyUSMhe0Mh40QmJbTaErAFZPY4PkKTpqSs6WIAJsM0pLLoCfFSWwIPsJhP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nUa5SS5T; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nUa5SS5T"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OLMsG63847423;
	Fri, 25 Sep 2026 06:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=8Wx74CcjZN2KpLzFAPrGCL0wBHdAL
	z/M9ECkC+f9nFw=; b=nUa5SS5TRMPNKD4rFZtDSqIinJhsGrNrwioh5MGQBw1GL
	sHj78NFoIT9IFp8K8dbe9RogaWgfaXbuHZjSIbhGpnlVllDSwXQgrPioxpK60P6k
	VNmW/Q2LEKhpa5rw5jpKPo3b1Oews1wnJRpERDdvOp/Ow9GbIidm9wgE9rRDGq5y
	IIMtAzeQjK9ex7zhzS3tQwy/dOQv9/Vx5H1eyMBnBsUWBAkcfWWPtYtGvivFJd7/
	qGuV+mzXPFRqHBe3NWjSOS7inp6wm4XkEvZJPUg0002qcbGRDqv//GkvgViMPOBa
	cvpwD77QGAPMe42oKA35d2ipqm4XH6geJhnz89bJw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsjxb8xc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:39:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68P6Yq7L023634;
	Fri, 25 Sep 2026 06:39:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gtegpxu13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 06:39:43 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68P6dgLM036692;
	Fri, 25 Sep 2026 06:39:42 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gtegpxu0a-1;
	Fri, 25 Sep 2026 06:39:42 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        harshit.m.mogalapalli@oracle.com
Subject: [PATCH] net: microchip: vcap: stop scanning after deleting key field
Date: Thu, 24 Sep 2026 23:39:36 -0700
Message-ID: <20260925063937.963430-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609250026
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfX75AOeZb2Rkov
 W4XinyGdG2OydliU3JylfdNGIAMNNE00n51FPootjAO5/wyElKh/UbE4yFoMSp0JnYWReA5489I
 AVn2ri1JglkoicToQv1BUAJWV+ooLvrPmlp2zCj5BJjZol2ZfEgV5YSIGaOe7H3hXS+A70MZnEF
 u3pwvwqyimTp7LTUxYcRZ+3jFP3QytyPFMfZG2XIaFG0JYBpGiu07scclTuB9QOA8ZGWQxzoulB
 D8kJYFqVGJuc5kNwY5ZgIUZ4Nw6dYSKxKDGS7/fgkcKM7jNIfKospFwCbwUi4z4B0JXhoWd3yNu
 oFSIn622bCXfgsxgp5bVn8XmEHbMLz1ywdFqhbyHdJ4O31nqlTgACqAREs8IGusmlKM6hAfVlGw
 gfia59Z2TglYrcmbY8mbdFg0h1hjkZhYA1EQEDSaWLSCV7wE7TCbDqmOD9pAB50bZjPGxJVGgd6
 hy4TWi6OTx5NzXsTgWw==
X-Proofpoint-ORIG-GUID: H3bv3TOXvrw2tKZOqmCs9849OdC1-jvv
X-Authority-Analysis: v=2.4 cv=UINIjyfy c=1 sm=1 tr=0 ts=6ab6172f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=uVw-QqTyBSQbbWnki_UA:9
X-Proofpoint-GUID: H3bv3TOXvrw2tKZOqmCs9849OdC1-jvv
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAyNiBTYWx0ZWRfX40ygXbz5QkSY
 3fM645nqsrGRdY5a2IztYiU4rfgTZdGZkvnwSXZSSdtlcDWSGtC8f2DvXnLJ2CQQyOGVN1Grlef
 Wz0vOgR1VfjbgLxcpO4NJK2PLb0LyAT2B9br/72NOD/cw66PolZa

The only call outside the KUnit tests is in
sparx5_tc_add_rule_copy(), which passes a fixed key list with no
duplicate entries. Therefore, the potential double-free is not
currently reachable in tree.

However, vcap_filter_rule_keys() is exported and does not require its
key list entries to be unique. If a future or external caller supplies
the same key at another position that the inner loop visits, it calls
list_del() and kfree() a second time on the freed field, leading to a
potential double-free.

Break the inner loop after removing a matching field. The outer safe
list traversal continues to process the remaining rule fields.

Fixes: 465a38a269e9 ("net: microchip: sparx5: Support for copying and modifying rules in the API")
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/all/ahs-lCAXXikkaHky@stanley.mountain/
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/ethernet/microchip/vcap/vcap_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api.c b/drivers/net/ethernet/microchip/vcap/vcap_api.c
index 788c0728d763..0f8d98f2094d 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api.c
@@ -3527,8 +3527,8 @@ int vcap_filter_rule_keys(struct vcap_rule *rule,
 				if (key == keylist[idx]) {
 					list_del(&ckf->ctrl.list);
 					kfree(ckf);
-					idx++;
 					err = 0;
+					break;
 				}
 		}
 	}
-- 
2.52.0

