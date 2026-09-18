Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A0D52842F;
	Fri, 18 Sep 2026 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765938; cv=none; b=Gg4sUXyo5cBxs90TWujLPBpGsbDl7oaxtaVjQMIrmMPo8wLolHDnh1oYICuc7HPc9LS7mFxZJSFOUR8Y5WhQiLviKoP6PUiOVJIKVQ8HZZqynN8OGfTY/BW1OrAADh+62G1I0eIA7SXKNKzAYqcu0W7sru/yNUQUVc2x5YdZqeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765938; c=relaxed/simple;
	bh=cIfSR1CMii8h1MA9LWF4cboCuUSevhIysbC5246uSiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWyn7wS6+P+P2MpDyErOZN77kIapzfApk6xMBHWq3uTBzeNI91r5jlU8Oo7r3fasPCIfLHFSrSGHgAJn6nVuMRr31MDB3snnplgZh2JhZhi3LgLPuMRa8W4U8puoR6thCnBg8dLYKKh3BaT6LCkAcrx640OSCD6q8IszehC7mb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tF3vRl3D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tF3vRl3D"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IKVPRX2272748;
	Fri, 18 Sep 2026 21:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Y7faeOI1LJz6yQ1ktdAskhdUjRuOohiVpln3WNI1J
	Us=; b=tF3vRl3DwaJcrkyn0CS01tZgJVreriJgnKjbJjbQ4AQ5y5RHFUl7Hr+pe
	SyjsvFqbtELXDToFlf18VMBdmkFLzQhx/sTfVgnQUvA4vRr69aO54bpjvOdlvhcr
	pyc1bSDmU/uWy9MJ+oeV/HZ8UUAPaFn8s8a6usFeuSqm/UR3Hcnim78WaXwq5xfV
	eXTtm4CWt2YySRrMld5bq8Xd/LdCRweYEIfGhTFJcpmqCF3x7vkH6i9nTO2PTqpd
	fwy/sXyq4fv+Lm5EiFic5Qngsdxrvq6a3Lqi60ANsNv+zN2Kc272jDAQ8pYeqoJf
	SX23Y2Ag/aYMRNqmSexDjgmIcZZGg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5jc05-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 21:12:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IKK3pn2177907;
	Fri, 18 Sep 2026 21:12:00 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gs4tva22k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 21:12:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ILBwSJ61931910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 21:11:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EBC758060;
	Fri, 18 Sep 2026 21:11:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10DD35805E;
	Fri, 18 Sep 2026 21:11:58 +0000 (GMT)
Received: from li-4c4c4544-004d-3310-8032-b2c04f503334.atx-us.ibm.com (unknown [9.16.51.119])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 21:11:58 +0000 (GMT)
From: David Dai <zdai@linux.ibm.com>
To: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: jarod@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hangbin.liu@linux.dev, pradeeps@linux.ibm.com, zdai@linux.ibm.com
Subject: [PATCH net v2 1/1] bonding: crypto offload enabled, non-offload slave failover, rekey failed
Date: Fri, 18 Sep 2026 16:11:55 -0500
Message-ID: <20260918211155.1664493-1-zdai@linux.ibm.com>
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
X-Proofpoint-GUID: YVVw5WEEXYrbP-_QDp9CoBijfzORgWO3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDMwNCBTYWx0ZWRfX00fH7VcyUusq
 BsSaCaJd7JhgleaMvEjslwfiBn9Hlm4osC+X5MXRaF7Ec3VMTczmt27naDcLTeoiFutJqEMuo7M
 Tr7gdNSjtU2r9Tu09oHRRGvcm6mAteI=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aada921 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=90oEQoJImY1yxsAiUqMA:9
X-Proofpoint-ORIG-GUID: _PFMqiUmwdFaMYAwCXkGy1oO-30Rg3k9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDMwNCBTYWx0ZWRfX0Wh1AnbeYHiC
 WADClSc295joDbfpKM7Rpkpoy47l0aLAuD+rLn5+RjmA2vS/hDkr7b5+EhvqWs+JG2QPuWa6An7
 BnT0skmep8Q2yDK+RLfXPiaRGoMtZb8jtjcW424iCyjr/RpEy8JOW2zrzEXnHILZHI9KBCViNEt
 cSVS6mTsi6IV0qkbJWX6iB8JAG/kIEgvR9JQrOjQfeAkawr/v+VlPk75B0Ukh8A0hyN4RCeYTAD
 uY7SJItujTQILnRluYrEj5LB4DGyzaJvO28XK8Q9O1aPQOBWbZyenurcQurlGVyYKdD8KrNuFeJ
 al/2ps16Ot14SXYVNeCX4w2NmeM00LxTxZjCJA3wuvMNnqz/TW5G9SwDwy2NGKGXuGYhdfLwaey
 MMqc5kpQgNxrAduFDkBsI2Je+RuEWxRaCXtiqJ5yc+rSKxY5SrZb+9cRY5zhFELkIDX3F7sfKyV
 rd87JV5PcDIeYiG489Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_06,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180304

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

Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
Signed-off-by: David Dai <zdai@linux.ibm.com>
---
Changes in v2:
- Add "Fixes: 18cb261afd7b ("bonding: support hardware encryption
  offload to slaves")" in v2 patch comment.
- Remove last line in v1 patch comment "This way, network traffic 
  is never interrupted, always keeps going." to avoid confusion.
- Link to v1: https://lore.kernel.org/lkml/20260903220123.475685-1-zdai@linux.ibm.com/
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a9bff7663eec..de2489c3d9bf 100644
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

