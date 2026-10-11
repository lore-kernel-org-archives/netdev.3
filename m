Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51322DCF74
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791718635; cv=none; b=lFMvmIILu74WvxkqnirNEnfemtJ1672LePY/S4JIBGAST3282050RUx0WS56CI9yhmOoBcbdb/gqxApt3omPtzXYw8/4G8b2qzeMKPFr1UmViZgT7IDbLXq8jwJeoMx6bgu4D7WZi/jDGJOwtld3V2MG6tRz9ZidyiiWzeapeU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791718635; c=relaxed/simple;
	bh=6u3stofNI9BLVmR6DuuYhthlvV0eWWkKPfnCsUKCaNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnigtC4FbmLZrwW3Z7Vq0CjuRmzv7sTxH3TQPBM3OdD1hQnHn/5f6CN1oOIIJeb5n9DA52B61r8toRKqdEObhu3wjJuznNgoNtsSG8kBd+hIFJUrPKi21BuideET9juxqi3/zJHm67RdodVyWGvCe+WRFOWE91acuHnWeDuK2BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nRnoT+7O; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nRnoT+7O"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69BBQBTV3526241;
	Sun, 11 Oct 2026 11:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=g6N78M5WVxE9MlZLLXJgM6SbU5sYA
	NtzHa2a12DeunY=; b=nRnoT+7OwFHNlANTKcQb7JBFigItymSeJG1u0CmUTPw4z
	eoamBoKSF1YivMti6zhrv8CBv5YrE4OJPUCfNdut/rK+8wFc7FulLSb5iBr7yNZL
	5TQZVhsUWZX07VhKrEuYaz3M2cYhtqjF7xh9sbtgoL/EUvnDkH4kRLnOUzGoWKYl
	hvs/Iyi9o0/LknICShmwjlxy18JP68UisxHCl0tr1S/VaHYe2lBv73inlv1dSK0B
	RLtbjzK+RK+nFbzovYISw/GDy6LPjD/xxN+D5yyhCKgGpm6vJ8V9F7HZvh3PyFg7
	wnz+FZMJaHWOIjJmf84Ja3xgdZ8ham5QZQyj9awKg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7demgye9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 Oct 2026 11:36:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69BBamEq039610;
	Sun, 11 Oct 2026 11:36:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btkyxbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 Oct 2026 11:36:52 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69BBapvO040050;
	Sun, 11 Oct 2026 11:36:51 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btkyx0f-1;
	Sun, 11 Oct 2026 11:36:51 +0000 (GMT)
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: richardcochran@gmail.com, anthony.l.nguyen@intel.com,
        przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] ice: correct PTP register access debug messages
Date: Sun, 11 Oct 2026 04:35:36 -0700
Message-ID: <20261011113545.16718-1-alok.a.tiwari@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610110046
X-Authority-Analysis: v=2.4 cv=CoEq4X4D c=1 sm=1 tr=0 ts=6acb74d4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=KXD2W1d5SiN8HkZNh0UA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-GUID: AR-OUwSS8V5ZlzLCFDsxowOX2DUKEP24
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA0NSBTYWx0ZWRfXwZFd+dbUJ3GD
 zMUk64YOHBKuY+rCasJ7J4zPMsbXfUfsN949EoXtb5sIzcBfpSB7A/ZKU1dluKPyHue1443yi84
 Rx7oTXHY1TDK/Sh8rdUiqaK15IYlRoVmtkJG13NXEdDjpqy6Q4sc
X-Proofpoint-ORIG-GUID: AR-OUwSS8V5ZlzLCFDsxowOX2DUKEP24
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA0NSBTYWx0ZWRfX8JVZZd76zAqf
 tFyW0VBtse1tjaG0Ql0M5CzYAasal8cUSHJXc4MQjfHOM55THzyubQWXZ6/QLbW7kvaMksCTsF+
 uFTgJhtUAfx8dpV97GlsJoJFPP/TP3u7w0h3E8s64jwqhA+CFnHELXYNAALtfzMZBFH3UxYsgiW
 SjWdGHTlgWXb1CFw/EHdZxUHzLy63M4tV8klZEq7R4q9yerQfiYw8l4ZXfOOnVYtcPUjZkRCupI
 J/KcJbXXdNQvAR1MIxVMkFiGxZOBZC6D5sQwHAOlxyps8VNrzQ6iGDpgzVVhUhBCpvrJVcIJ693
 Fc0TYqeMD3jzXXJu99rtFrf7kyvTcV3Z1Bdr6u0Alv6+eToySqHQbIs3mmH5zlN1+sb579Jfy0v
 zD4IDR8kIU22i2Ws5DwocMewEKmf8r5YERsj9FBYTToSiq35ZsCdWkVeW4CmP6xk9gdIbZB29Gs
 XV5ZtYRbOQ5tfSMiTPxoscU+fNM4+vEhm8qkK+S8=

Report a write failure rather than a read failure when updating
PHY_VENDOR_TXLANE_THRESH.

Fix newline placement in PHY register read and threshold write failure
messages. No functional changes.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a41c711e751..289e0b3ef6ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1529,7 +1529,7 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
 	err = ice_write_xpcs_reg_eth56g(hw, port, PHY_VENDOR_TXLANE_THRESH,
 					ICE_ETH56G_NOMINAL_THRESH4);
 	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to read VENDOR_TXLANE_THRESH, status: %d",
+		ice_debug(hw, ICE_DBG_PTP, "Failed to write VENDOR_TXLANE_THRESH, status: %d",
 			  err);
 		return err;
 	}
@@ -2589,14 +2589,14 @@ ice_read_64b_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 low_addr, u64 *val)
 
 	err = ice_read_phy_reg_e82x(hw, port, low_addr, &low);
 	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to read from low register 0x%08x\n, err %d",
+		ice_debug(hw, ICE_DBG_PTP, "Failed to read from low register 0x%08x, err %d\n",
 			  low_addr, err);
 		return err;
 	}
 
 	err = ice_read_phy_reg_e82x(hw, port, high_addr, &high);
 	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to read from high register 0x%08x\n, err %d",
+		ice_debug(hw, ICE_DBG_PTP, "Failed to read from high register 0x%08x, err %d\n",
 			  high_addr, err);
 		return err;
 	}
-- 
2.52.0

