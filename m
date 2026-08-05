Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E3841A931
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 22:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969868; cv=none; b=XuIijGicqwrs8GZlGYcuy7tJVNFg9Viz1TW1KzFtQyxt2/dd5Mg+4l0j9zK8hYCy+vyBdi1ebQxMY9UDY2m4V8a2a+7N48XuejgMMDUBcrrBeFOwf7+UrUAUYqqDjravA9DNGlVvhBUgQzF9xZ8oCYQn1J1fvLy7QhX7NHaWDtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969868; c=relaxed/simple;
	bh=K4ZX2L6XzBr6t12U1fetwXYu9ZKcANaxpjB4Obf7wPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X5XCVnvesQTjnhwqR2NcxEfCNuvCiRUjIN5wnvf5aKMu1P4t8RHDjXUistHoFqnlcWjxdKLlerVn1gDCHXM1FYylJEHtHvzwPqrFD8xUc4M4l8RKFp+XBFMgjPRL54NOKy6jqny8iu3wkHo69o8vvFQ3lC2vC13wGkV+duBgSCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hS6c6E6d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hS6c6E6d"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Hlr6L2655652;
	Wed, 5 Aug 2026 22:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=U71CCB9x5bhazO35E7RiDtEUAZF5nSdwrzLaQ87Wo
	zk=; b=hS6c6E6dI8/hu637h2JQgI5ZqreVspTE+j5Q3X5e+WNxpqW7RspWtejFY
	PaGh3Y6GFsk9vgqZqrkK5pNLFWzDYiirsIlqPp2EyzMW6Un9vdNHhGqsMmLndCg9
	/U0na3a6kZHedL+kafYbmi/2u7/P06FaHvFldCL3K53j78qd9k2Pe9nyW1OijJ/1
	WGtZPNXCig2UtYYGgMa/ZclTDCtSyu1sjlAGYXxse/AKfWCN+Y3uERg0j3cGr4UZ
	BuLYEP8x7DEUHnKvljl1YcEkRCdQZ7kVXHpzqN2pgHOD3K3Sj4ojUqdDS0rv1Pg5
	Y2DeXJgC+slXCsfQV/Wzh1HBAJoag==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqwacd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675MfIw6016940;
	Wed, 5 Aug 2026 22:44:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgger9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 22:44:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675MiCRT31588942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 22:44:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 990905805D;
	Wed,  5 Aug 2026 22:44:12 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D61D5805A;
	Wed,  5 Aug 2026 22:44:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.135.24])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 22:44:10 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, haren@linux.ibm.com,
        ricklind@linux.ibm.com, nnac123@linux.ibm.com, davemarq@linux.ibm.com,
        vaishnavi@linux.ibm.com, bjking1@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, mmc@linux.ibm.com
Subject: [PATCH net-next v1 0/6] ibmvnic: honour flexible in-range MTU values
Date: Wed,  5 Aug 2026 15:43:55 -0700
Message-Id: <20260805224401.58791-1-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: MhTcb0ouJJR0x5LJd8bPOlBjQulEuXlp
X-Proofpoint-ORIG-GUID: cUNabOWsPXo0rgrBPs3ZmjwBwMBbb1yn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfX9hAivU5LK7cY
 0q4o/6La1HsC3vIrFr9N3YFH/Ah7H84RfFoKK8iyzjLPHs5mvi4xSi3+X8XeZ9JnCh1obv5+tyX
 x1PcOyvt9ab+s45cbcpnXel7cE84IW8=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a73bcbf cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=5rr74yZLSFAQtvEL210A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE4MyBTYWx0ZWRfX7wSqXoArhwP0
 Y0zFj+7yhTep763siAkhL3ifhIEou9ueM5r0akKh051UrqmanWIW4/glVO9siU2/0WM3aguryah
 7rSmSLyCUTyTBKsVK8ppzAXGKAoSzB4FN3MiXkm4vJcNPCLk47QLkR+CgQu4UZrF7nzKWsm2hCj
 b7jOC0BPN3wAz787PxO7eJLUL/AEXix/uHp3RjxfxBCIQIQ/Eb9kjnEdjf1rk1PavwmhtZ/3kMu
 3IyeuaBlNB7qBvajxfPcu4vYskqLRdCcgaHAB5XRWGQO8Tfbva4Rq7MfwO04vNspXgkUezuqLYX
 JOFuJr/hkVV3yysU2+Z1Bqn2F3Rjjzc1nol9FXggKwYf53U6ycSXKusf8R1ZW5T1fg9995SDO0y
 VZigI5lcBQmqgD3JmGJhhH8DkXjyT/aBYwgxWQa+P1vuTPwoZjC74m9LwaDlYSoq+z1dsPewTg9
 XjsmYSC76BXzMBCjfWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050183

ibmvnic currently only keeps an MTU of 1500 or 9000. Any other in-range
value is accepted by ip(8) and then silently reverted: the vnicserver
answers REQ_MTU with PARTIALSUCCESS and the size the backing device
settled on, and the driver treats that as rejection and falls back.

Customers want flexible in-range MTUs (for example 1414, or values in
the 2000..8000 range) rather than being forced onto the 1500/9000
buckets. Today those requests either snap back quietly or, in the
mid-range case, can fail pool allocation and leave the interface down.

This series makes those requests stick, hardens the reset path an MTU
change goes through, and (patch 6) skips the reset when the backing
device and current buffers already cover the new MTU.

Posted as a single net-next series so the flexible-MTU change and the
reset-path hardening can be reviewed together. Patches 1-5 address
user-visible bugs and carry Fixes: tags; patch 6 is the follow-on
optimization. Happy to resplit 1-5 to net and leave 6 for net-next if
that is preferred.

  Patch 2 is the functional fix: keep the requested MTU when
  PARTIALSUCCESS covers it, and converge on the device size when it
  does not.

  Patch 1 is a prerequisite. Once req_mtu may sit below the backing
  buffer size, the existing pool-entry guard (which budgets with
  req_mtu) overshoots and mid-range MTU changes can fail allocation.
  It must not be backported without patch 2, or separated from it.

  Patches 3-5 clean up side effects of the MTU reset: skip unmaps for
  buffers the VIOS already forgot across a CRQ reconnect, and allocate
  new pools / long term buffers before releasing the old ones so a
  failed realloc refuses the MTU change instead of stranding the
  interface.

  Patch 6 records the covering backing size and skips wait_for_reset()
  when the new MTU fits in both that size and the current buffers.

Tested on PowerVM ibmvnic with MTU sweeps including 1414 and the
2000..9000 range that previously failed to allocate.

Mingming Cao (6):
  ibmvnic: cap rx pool entries against the real buffer size
  ibmvnic: honour the requested mtu instead of reverting to a fallback
  ibmvnic: do not unmap long term buffers across a crq reconnect
  ibmvnic: allocate new buffer pools before releasing the old ones
  ibmvnic: allocate a new long term buffer before freeing the old one
  ibmvnic: change the mtu without a reset where the buffers allow it

 drivers/net/ethernet/ibm/ibmvnic.c | 188 ++++++++++++++++++++---------
 drivers/net/ethernet/ibm/ibmvnic.h |   3 +
 2 files changed, 133 insertions(+), 58 deletions(-)

-- 
2.50.1 (Apple Git-155)

