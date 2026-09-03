Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD4D19E97B;
	Thu,  3 Sep 2026 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472899; cv=none; b=EFY2GlejAXto5PsxfIHT7pk4Jm5h5pJ/vpqhIG2sVXRgFrZPGj6oBVyoEFPvqDG+qph76IhI8slM9QWKOPwXPG5AtVEr0I0EXGufUhtmTdSbS0PkoOeXCDDnfi/Kt8ZBpniJWnnKbrwjEZ8v9nI2LPWhjXDo2SndRtVq7XqnKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472899; c=relaxed/simple;
	bh=PoA/DHYNZOe/21o0emYovdyOo6vCKMcKpP39FAe9SYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j1WU9pidtS1rMV6osm7bRZ5wmGtyXfh6tWdtLZpx2deeqzcHXAyQNDuIh0rLSUdgIRisrmRM5DTLfbZW84J+QlvDWCHWDk+kLAl/JjSnlBMfSjYqBmo4tYg6gQ3D7VFDPvEeVa3bdbhAKVwdCt2kzO4Bz5t5tFUOuR0A44jWSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dXQmaRN+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dXQmaRN+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683K1b5c3922333;
	Thu, 3 Sep 2026 22:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=QAmqejKNmNP+mfMNDq09ycqUSobTLK4ccmsLLo8OZ
	EU=; b=dXQmaRN+qA9U4C/dP0DJ3eB+ePLXIY/KKcVH2jFBOmmwyzMZsRZfLUd6N
	XgT0Dy7LwQD4bryuPW6nq8sk5n7p6RGEiKizsjfjq/8rjhnB7K3m+eNsYNAHR7Zl
	QXbfck/1Wjd7mfUd4IwOTbx6sga7lKiBHnJoN+GRUu40aIGFvC4le5g/VJ9KBzYT
	9iDbWrtes/z4zdz8O096anYpt/Bi9/Z9j8bJaCYrhjwDHloYRjt9Btw0YhQEeJqU
	5tZmoSbrr+PbSelr46QhKd2aW+Gm3g8M0H4PbkF/fFs+Ke/i7ilq79lkIoMSGFFU
	zuDKMNkVTKMVSVHWtGnEGIzeW1X/g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5y8fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 22:01:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 683LuIx2015917;
	Thu, 3 Sep 2026 22:01:27 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygshmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Sep 2026 22:01:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 683M1Qi97799774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Sep 2026 22:01:26 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B3E958054;
	Thu,  3 Sep 2026 22:01:26 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5781A58045;
	Thu,  3 Sep 2026 22:01:25 +0000 (GMT)
Received: from li-4c4c4544-004d-3310-8032-b2c04f503334.ibm.com.com (unknown [9.61.75.10])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Sep 2026 22:01:25 +0000 (GMT)
From: David Dai <zdai@linux.ibm.com>
To: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pradeeps@linux.ibm.com, zdai@linux.ibm.com
Subject: [PATCH 1/1] bonding: crypto offload enabled, non-offload slave failover, rekey failed
Date: Thu,  3 Sep 2026 17:01:23 -0500
Message-ID: <20260903220123.475685-1-zdai@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a99ee38 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=90oEQoJImY1yxsAiUqMA:9
X-Proofpoint-GUID: Qo0JzSIHupwwh--bEqgoveZz27Y7WDyG
X-Proofpoint-ORIG-GUID: 4VT0vd94mrpP_zVaywdeIr8UAR0gSGdW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE5MyBTYWx0ZWRfXyvdhLxkqeAiT
 YQLzs1P3TbtDL8sMk/0h6gKEtFX9Wxhf6xan1bX8aQyI//t8jJxuRD17egKGPmmfalCIXAvnG2Y
 CwDMpBgAyVtVfziA8lBN5DB30kuANZ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE5MyBTYWx0ZWRfXz7f62GPPKHRT
 SmPV3KSKN+wGeuoqz/0dBGkB394IlIjnjg6Nb8H5FxOR6TRviR+I40wl0QS4RI2dIzVJ7xphzj8
 j95rQRZVmQm22qWUcc/kZ1w+NUa8d+tf+a2FkM98V+ZKGcszhNfqwbDb2B5E+sF9YwhiOH8AWjv
 4i6018H8ZzOjbo7c0OmqVmKDBAP8y0mBjE2yUwn9R5hicg77Bo5ucHEmsLFRNhqh8Vmx9dgCtOk
 eB81R7091LfXYyy0ahqaqYuM2NHrxoNrNjS13WiDajSrb5FjauFyVS5ZlNP59PGXy9kSIQJyfuU
 8zJSvF3WNz73y3RYcBqPbqsOAuUwgQETN4/F/dg4MiBYENAwo9iU50VAtrPjG/kiA6PLjCfqTZM
 iGG39MgBjVg6IMmPou+0SI5uZSX5mZDq5mFtEamAEClXh00N7LrmWKrk9LlZoWgxrlsCicf/ygE
 7gwlHu/GqXpo3QdssAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030193

Create a bonding device (i.e. bond0) in active-backup mode, 2 slaves.
Active slave: offload capable interface (i.e. eth1), primary interface.
Backup slave: non-offload capable interface(i.e. eth2).
Configure strongswan service swantl.conf child SA "hw_offload = crypto"
Start strongswan service
IPSec Crytpo Offload is enabled on top of bond0. i.e. 
ip xfrm state |grep offload
        crypto offload parameters: dev bond0 dir out mode crypto
	crypto offload parameters: dev bond0 dir in mode crypto

Active slave eth1 takes adavantage of IPSec Crypto Offload capability. 

If active slave eth1 is down for any reason (i.e. eth1 link down):
ip link set down dev eth1
non-offload capable interface eth2 failover to becomes active slave. 
The existing SAs can continue use software IPsec after failover.
Traffic still keeps going properly.

However if eth1 link had not recovered yet, strongswan service does
new child SA rekey, or uses swanctl command to do new child SA rekey, 
it will fail because active slave eth2 doesn't support crypto offload.
In bond_ipsec_add_sa routine, it returns -EINVAL now, which is 
treated as fatal error by xfrm_dev_state_add routine in kernel xfrm.

To make the non-offload active slave survive the child SA rekey, need 
to make bond_ipsec_add_sa routine returns -EOPNOTSUPP instead when 
active slave doesn't support IPsec Crypto offload, the xfrm will 
gracefully fallback to create new SA using Software IPsec. 
Network traffic can keep going.

After offload capable interface eth1 link is up, becomes active slave,
next time strongswan child SA rekey will create a new SA which enables
crypto offload again.

This way, network traffic is never interrupted, always keeps going.

Signed-off-by: David Dai <zdai@linux.ibm.com>
Tested-by: David Dai <zdai@linux.ibm.com>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index ef9eb0c53c66..79fc892dab07 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -490,7 +490,7 @@ static int bond_ipsec_add_sa(struct net_device *bond_dev,
 	    !real_dev->xfrmdev_ops->xdo_dev_state_add ||
 	    netif_is_bond_master(real_dev)) {
 		NL_SET_ERR_MSG_MOD(extack, "Slave does not support ipsec offload");
-		err = -EINVAL;
+		err = -EOPNOTSUPP;
 		goto out;
 	}
 
-- 
2.55.0

