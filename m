Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA23EB81D
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791719569; cv=none; b=sgIzzJBQCF2/oJ1WFGwAfxKR3CulO93n53MF5wuLsHrhJFQIjetG8T4O7qoIAUIRvtQQxxFPqNwlTkfBs7yTPY4HXQ+RyNYTPooU23Z7J1hVemb85tygbxyClT46K3fCPxznBHRp+7ii62abBTBI/uCuslBElF3suXx6zBIFYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791719569; c=relaxed/simple;
	bh=pGrIbcOnrs3r1Rbno3SsUiv6xGqTpYjcsIFt2H5JFT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=feYU7SiGdJNvgbMF78c7YGPa97F8SQC9zhk9VOFnCyEjDWJmpbAwzh2KZKqTJwdkN6z9eM1IpTvvJbOEwWR7uY2i9R3t2M7hQ7tonH7yOZqPODtJQ+/xWq+Tivfwp1Z3bDcjYHb8HYPbPZzZACBOSp9ZnW1sQ2tZlaQMQSO7Jk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i1G7SYtz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i1G7SYtz"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69BBasfv1782254;
	Sun, 11 Oct 2026 11:52:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=0tdUcO/KiWD2FfLp48tLYmUCH3Spo
	bbCtXIVHhRE/So=; b=i1G7SYtzHbGZjLH1OGYDk1CChssjVI+RyfyKdKuAbAXsB
	3Y3brjAa35ingV4FwQPj0lA5pI74Y0JSbdnbidtBk+74K2dA9sdQs9VZf8IudmAy
	7efB+Im2JQsJLH1b5fkitO4sYdaT3ReDJiH1edH5DPmvP9iDEqWjmm/eb4y/xLu8
	LbagUQ1SVxiy7BYNAQUP/oYZ4+Oa4SSfpcsF5+ad3xINVVO3i7kJ16ZAwwWUPoKO
	OfAvLpbnhaNhUJ/Z7Bnp+3/A4FopGDA7z5U/6e6XnC8R2Kzf1Xol2mRkUKv6kkas
	3Nhi+jRNfudd/PI22tAt6MaF8mG2g+lVdAyDz0RAQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7df7rynb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 Oct 2026 11:52:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69BBafjC035549;
	Sun, 11 Oct 2026 11:52:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btgwv9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 Oct 2026 11:52:31 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69BBqUFH023074;
	Sun, 11 Oct 2026 11:52:30 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btgwv9a-1;
	Sun, 11 Oct 2026 11:52:30 +0000 (GMT)
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] mlxsw: spectrum: Remove redundant return in KVDL free function
Date: Sun, 11 Oct 2026 04:52:22 -0700
Message-ID: <20261011115227.21760-1-alok.a.tiwari@oracle.com>
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
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610110046
X-Authority-Analysis: v=2.4 cv=N+a8hG9B c=1 sm=1 tr=0 ts=6acb7880 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=f_hmEdg4tOf5KfOiiO8A:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA0NiBTYWx0ZWRfX+1tebBqxQ8D3
 aZW/kvxIG0h5r1xdqCLLzdQ5Kd1gzFoToRG8+aA47DJjFoZ2wziW0vkFYaZ5305tmZAUPUbYNdv
 vu16dgLYCYDKpy8P0W4xZFW4MB21LRrRpgCMErNkH9eG16yVZYCuA3cv7LubFaNzo0PA06c9bNS
 ngWbkDORWKot35ephV3U4AswGeOT21QNLnQkb2OBSYC5ZmTWSbP3qtuR5ogLhr6jrg4GwNy2esW
 8rtZftkpdsYOCwJUL5RRtHzVQ3CWE46Ee7j3SsBbQVhxeYrWmXeZ2+WBej0iIWFfNmU70+I/PdM
 RcDXtbEYNI850YjxAdURlZ2DMu97RMWIXbozFzvAPe87ovGUuU/H/NGpAToGFQ9jyTwXyaCva9S
 tRZL1EBdohCgIvooU1AsDFpvLS6DSmPRkmwoJ/tcvMAi6O03GNzD+0rmDXA5ylZtkA0PRn7LIQp
 LFAS5X0iLcur8M5bXIG24oDDvgGdFXOUdPKNFwpI=
X-Proofpoint-ORIG-GUID: v7sle5FoS1x0V_c1lAYdpjBf_oGAKTi6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA0NiBTYWx0ZWRfX6Nbbn4byN78z
 rYBft2S4tJf9i+8tjY3IeUGDAHC4XIVzESHivQvOR1sqVbhMmP2wbk0JQGt/cABbJSjRzA+ULmA
 0mGs8NjhTuVrKIajuSIMpKg/3wB5hlmSeF938pmUlm2ZRfYr2tuI
X-Proofpoint-GUID: v7sle5FoS1x0V_c1lAYdpjBf_oGAKTi6

Call mlxsw_sp2_kvdl_part_free() directly instead of returning its void
expression from mlxsw_sp2_kvdl_free().

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c
index 24ff305a2995..6a23d1626519 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum2_kvdl.c
@@ -163,7 +163,7 @@ static void mlxsw_sp2_kvdl_free(struct mlxsw_sp *mlxsw_sp, void *priv,
 	struct mlxsw_sp2_kvdl *kvdl = priv;
 	struct mlxsw_sp2_kvdl_part *part = kvdl->parts[type];
 
-	return mlxsw_sp2_kvdl_part_free(mlxsw_sp, part, size, entry_index);
+	mlxsw_sp2_kvdl_part_free(mlxsw_sp, part, size, entry_index);
 }
 
 static int mlxsw_sp2_kvdl_alloc_size_query(struct mlxsw_sp *mlxsw_sp,
-- 
2.52.0

