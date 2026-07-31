Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5EB192B75
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785458875; cv=none; b=Gb+zsrUwrIe1PU5s6DJ7Ydj9mbhOcOGTcoHqxapNcS/I5YB+6fgv3LuS/j3MMML00nu8bbxp3/gKX55Rn56Hw1iDhYmIpPT13LazWib4WBF0ZKfBDcD3CKFhDodrWsg9JhyDulxs9sqZ9Glr3wGXuuFk+a686NTjJPcfn0qwYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785458875; c=relaxed/simple;
	bh=z4uEFIYOHHWbkov3rvs3HIbBw3sfjhPMIDOfDz2eBbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i9yc6/fevQp7ZN0StSNmmpri+vciAo7ah0DMwp+QriEsNcbXHkG6r4Qz3P7rBPbK992LKl/egLcl6XRll+eRxC67vlb2AeAxzJ18huNmB3Sw0pcBLU4ojHUAvCIs2WGs2B5ekzuRy263nHQ7qRMNVrLTWwluZL4XmIZKutzcQyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NiaDKlsX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NiaDKlsX"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNK4XK223094;
	Fri, 31 Jul 2026 00:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cceipyx7ZETmL+wGyudLwxubSxgmMClxud2EHJXtR
	74=; b=NiaDKlsXvZuJRpUwUJGz9bSumnLiim72NCyVafFy/mPz2zDvz8EUH70iZ
	FSP9US5wPdNis8aJLaVbxqoIc8fwCNpchMFgiubq5yV+EoGZZa42qnMZj3zjAS5Q
	dVAsNDcu+oQZkG/45S/UAVg4wb7zDMQoA4AlXgUq4OamUFz6c9x15eJjNyvN6vrf
	EllN8Bs4uy2Z19HV4YPIqTarVFXKGBmsjoBz0LfGTVvgGhDUiXrBDpbDJNuiDS6Y
	Xu1RJJBqd91pxmalQXxtTNoytAYwtQ5z2GgGYZ8StA3Kd2ISCQNCDyscdQyDvoch
	xG9IrohK55M1G40G+WhgmCzx0I+cQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0y2mhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fOug031579;
	Fri, 31 Jul 2026 00:47:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgnpcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0lYYg3277602
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:47:34 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38CC15805D;
	Fri, 31 Jul 2026 00:47:34 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4ACBE58058;
	Fri, 31 Jul 2026 00:47:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:47:33 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com
Subject: [PATCH net-next v4 00/14] ibmveth: Add multi-queue RX support
Date: Thu, 30 Jul 2026 17:47:03 -0700
Message-Id: <cover.1785457143.git.mmc@linux.ibm.com>
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
X-Proofpoint-GUID: B86ouFPx9-oyuR1H3h9w5hciM22FQ0UY
X-Proofpoint-ORIG-GUID: 006rnVtAuByHYr-6L-4_P4rFMKuoR901
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX19Odk60asf8e
 xuN8GneLiQZGh9JePN2SA44R9L+ER87mm06Z8HQZHKDoETSmUsd0bwDuOJFnU4rTXwmNOorBR5l
 mQ3wlvrH4xDJG55S9N2IYzrZ/vG1GTs=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a6bf0a9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=-zOltsE3303Mi9OEyQUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX6icomEOrbyyM
 JQ0D9LCf4b1xoC7tdes/RQQ8HFbESVUOPp2RIofokCp4RA3cI/yyzK+/tgbud11gF7fNs/g4hAZ
 uhJ4MfRD14jIqxKsEZBc7PfWundxJmxvw/wyjbFWuECWkRzPg5gyQ9I67BzKzmcxTCaF3ggHzLa
 YcdRDkNGAUzl1rBZ8WuaxafSZigHafzQxMiJvXT3WhWVaQGT4X/hK1zWNP0PWBh45D6ZgNm9c+P
 A5lFeodl4Nj8eBLBTJikx/p3I2lfPOaXosj/7VLsw2hQ6RK5eQ1Hx3hDZt3aWYvMBr2RkWlChcN
 htYDdPe889xHQxbDiXnclspzJnT4Lu31cFxLHL1J5qo9Vnk0VmdAv6Bat+bFXC02SJJksXC8IM+
 PAWWbR4LtVp4uQSZxAl3R52R9RoeDczPh+57s1yfzbm1LhtbDsBwZXSxAoDy2g6XwGlGyV1uJZa
 9YzfP/+1bZi2bWclUEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1011 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310003

Hi,

Power11 PHYP adds Virtual Ethernet multi-queue (MQ) RX: multiple
logical-LAN RX queues, per-queue buffer posting, and completion
delivery. Guest Linux did not use that; ibmveth still registered one
RX queue even when PHYP was MQ-capable.

This series adds the ibmveth MQ client for net-next. When PHYP
advertises IBMVETH_ILLAN_RX_MULTI_QUEUE_SUPPORT via H_ILLAN_ATTRIBUTES,
probe enables MQ with a default RX count of min(num_online_cpus(), 8)
(same cap as TX today); ethtool -L can raise RX up to 16. Packets are
received on per-queue NAPI. Older firmware without the bit is unchanged.
Queue selection remains firmware-defined (PHYP hash). Ethtool RSS hash
get/set for that algorithm is deferred to a follow-up series so this
one stays MQ datapath only.

User-visible bits: ethtool -l/-L (channels), ethtool -S and
ndo_get_stats64 (per-queue + aggregate), and a read-only debugfs
buffer_pools dump (v3's multi-line sysfs dump moved to debugfs; the
historical queue-0 poolN/ sysfs ABI is unchanged).

Background:

ibmveth today uses one logical LAN, one set of buffer pools, and one
NAPI context. PHYP MQ mode gives each RX queue its own handle (post via
H_ADD_LOGICAL_LAN_BUFFERS_QUEUE, subordinate register via
H_REG_LOGICAL_LAN_QUEUE). Legacy firmware keeps the original hcall path.

Series layout (14 patches):

  1-2   Hypercall wrappers; MQ adapter layout (MAX_RX_QUEUES stays 1)
  3-8   Refactor open/close into queue-aware helpers (still SQ runtime)
  9     Enable MQ datapath at probe/open (subordinate register helpers
        land here with first use; probe pool-kobj fail paths put
        already-created pool kobjects)
  10-11 Per-queue RX/TX stats; debugfs buffer_pools
  12-13 Incremental RX resize; ethtool set_channels
  14    Poll/close fixes after aggressive ethtool -L

Patch 2 is layout-only. Statistics types land with first use
(hcall_stats in 7, rx/tx qstats in 10). Patches 3-8 do not change
runtime behaviour until patch 9. v3's separate big-bang open/close
pipeline patch is gone; wiring is incremental across 3-8.

Testing:

ppc64le PowerVM LPAR, MQ-capable firmware:
* ethtool -L cycling (16/1/8/11/1/3/16/8/1) with ping
* ethtool -L under iperf3; link down/up during traffic
* ifdown/ifup under iperf3 RX+TX (SQ and MQ)
* Legacy firmware (no MQ bit): open/close/stress on helper path
* allmodconfig W=1 clean at each patch (bisect-friendly restack)

Changes in v4:

Addresses Simon's v3 review and related fixes:
* First-use helpers/includes (irqdomain.h with first dispose); no
  unused statics; dropped orphan open/close pipeline patch
* Open/close unwind (free LAN before RX pools); no double TX teardown
* MQ open: replenish all queues before PHYP unmask; H_FUNCTION on
  subordinate register is a hard open failure
* Resize/set_channels hardenings; stats probe-lifetime + sum-on-read;
  buffer_pools diagnostic on debugfs
* Patch 9: put already-created pool kobjects on probe failure paths
* Patch 14: correlator skip, skb tailroom check, napi_complete_done
  shutdown return < budget

Comments welcome.

---
Previous versions
v3: https://lore.kernel.org/r/20260706193603.8039-1-mmc@linux.ibm.com
v2: https://lore.kernel.org/r/20260701222327.61325-1-mmc@linux.ibm.com
v1: https://lore.kernel.org/r/cover.1782758799.git.mmc@linux.ibm.com
v3 review (Simon, from 05/15):
  https://lore.kernel.org/r/20260714124327.GJ1364329@horms.kernel.org
