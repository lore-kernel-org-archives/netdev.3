Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BDF221546
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 06:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180390; cv=none; b=E3kVSwheLBQT268zFwfa6ZMdpF6krdgchx7Ld17q3SI+2aa0aKYN8MbC2ym5IanncfXYj0EGDftlzWUrpgrte/GGygOqL9/oRHASE7YhQ8ntDG2KKnqhX/2hH84u+YiHFq6j6cJ4jk8G1ADzX/vuRjKwULlOgPiFiFSM8qqLhWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180390; c=relaxed/simple;
	bh=oAOZUKkt9WwnRlviX73CMF0oP9xGl3EI2XQbxaYwPfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JKfko+PGnbghTiL8dK6G0AO9ib25TC5UgQGcnn/Whj1xitNjtlKlerP+dQa2Hc5eQTE6IexUvEsi8eSyTjxODmlm+wYCAPeSZEszilxx/UO5vQt6Wsv6U3QGUzN1llQf4fbPQQ9Zfu706DayPvqbNRpuAQcgmu1blcg/fb9gp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iV2YZN9f; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iV2YZN9f"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515nVf3138364;
	Mon, 5 Oct 2026 06:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cgBfTj9eSxIdFZicJreKoU3pREaaUEjEg/r0u1LUB
	q0=; b=iV2YZN9ftZ/aQY/6bq6Qp0MNOSz/zTwbDRpTREXcxAz7giehArwYbtJdr
	9yKUHDfkh9QhlkjuFo4faxEGaswXVDTbfJ3OhK9ljLUBsutxnE9P0z9ZHk1H2zxn
	YtJTkmHOHumlt8dMCJQ78R5d8JBr+IexfeKLIuqojBXdPr7pX/QLVsIHSQz23mHG
	lOKIpHjieX64rmA7o45IVI8M9CQqTEgN3+l9NjKVX0cXB6CbRvHyykb0pJx9vodh
	oypEmCzG7p74ZYjX3U4mJaBaLcww/sbBxpPeGqvGxZI3mWh2cbYpoG1vLgnTNu4Q
	uqFZmIfxJY97m3CQQtEnqgHVFaU6Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jga6h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:06:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69512oj32142366;
	Mon, 5 Oct 2026 06:06:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3d1jm67a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:06:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69566NvZ30016244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:06:24 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AACE458068;
	Mon,  5 Oct 2026 06:06:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E1335805B;
	Mon,  5 Oct 2026 06:06:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.97.222])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:06:22 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v2 0/8] ibmveth: fix hangs, use-after-frees and netpoll races
Date: Sun,  4 Oct 2026 23:06:00 -0700
Message-Id: <cover.1791178212.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zABlG-zIQoPO8vnMzorEfbh0C34kShMc
X-Proofpoint-GUID: zABlG-zIQoPO8vnMzorEfbh0C34kShMc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX30FyCX3jvWj8
 f4NgiMvUY+X+aa7GTErc1C1Dau1bzkqcarjLq8Eq8saiXHMDwHFMnXbHW47QaiF/+ARsohP8p2W
 dbN5+YdQcC2ZSL8A5tohJQ3Ccny3Z70=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX+0+2K0KaOihT
 e9hbsGpMkomTxXCVRRIvCFEOdDLOBcoMbwoh7q6wwWVgTqHmv25k1m38a/vDbMcHpibPS1HMSxX
 8svTtuGhD8ccUcctF0bUyHJTF0g+cAm3ia3Acc/u70PG8tyEcNaSFOTGzLZ/GxY+38Rufkwp2z8
 vYuOqyYNIJ5xYa7Pw3vkO26+AC+oqdUBmokv+kFInHMElcZEtKRNcyO8CAboNZjkm6ULbGz4HBu
 4Awxb8EZhXzY5Tbzq6LGs1Hb0B6ovXz/XEcv492qCQHJHs09ZJRhIyk0AfniPMrb7I+MazWqC/W
 gvFA07lcN+qRlx6FafkwpzmOCM/ANWyxiZceUATCWxNRUxqsqh38/tiUtPqj7KPo4PXmm9OOgMP
 Z5l1qpTR6T/6gQibSii+VmBVx+A620XpwXL6UApYxeh3LOgS3GolxsODTMUzdow53XybmCRQjcR
 VGJAfr7KqtAdlUqqmQg==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac33e61 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=psrjJ5DR-VdYSoFnn7AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050024

Hi,

Eight fixes for serious bugs in the ibmveth driver: two hang the
system, four are use-after-frees, one corrupts memory, and one makes
ethtool -L report success when it failed.

The series is based on net-next cfb7793d1bc0 ("Merge branch
'net-lan966x-add-support-for-pcie-fdma'"). It does not depend on
the two open() error-path fixes recently applied to net
(af0524bf4ce1, 84bec0bf0352) and merges cleanly with them; patch 2
explains how it relates to them. It also applies to net with
git am -3.

  1. Netpoll races with RX replenish (memory corruption, NULL
     dereference): remove ndo_poll_controller, as was done for
     ibmvnic, skip RX replenish in netpoll's budget-0 poll, and
     enable NAPI only once the RX resources exist.
     Fixes: 6b4223748895, bea3348eef27

  2. Hang after a failed internal reopen: the next close() waits in
     napi_disable() forever with RTNL held, and only a reboot
     recovers. Skip close() when open() did not succeed.
     Fixes: 860f242eb534

  3. Use-after-free in remove(): a reset queued from NAPI could run
     on the freed adapter. Disable the reset work first.
     Fixes: 2c91e2319ed9

  4. RX poll hang on a bad correlator: poll restarts on the same slot
     until RCU stalls, and an inactive pool dereferences NULL. Step
     past the slot, reject inactive pools, count the drop.
     Fixes: 2c91e2319ed9, 860f242eb534

  5. Use-after-free after a failed probe: the pool kobjects stay in
     sysfs after the adapter is freed. Put them, as remove() does,
     and give them a release() that probe and remove() wait for, so
     CONFIG_DEBUG_KOBJECT_RELEASE cannot free them early either.
     Fixes: 860f242eb534

  6. ethtool -L returns 0 when it cannot allocate the new TX queues.
     Return the allocation error.
     Fixes: 10c2aba89cc0

  7. Use-after-free of TX buffers: close() frees them without
     waiting for a running transmit. It is called directly for MTU,
     offload and buffer pool changes, and through dev_close(), which
     does not wait either with a noqueue qdisc. Use
     netif_tx_disable().
     Fixes: d6832ca48d8a

  8. Use-after-free of the RX queue: napi_disable() returns before
     the poll has finished, and the rest of the poll re-enables the
     interrupt and reads the RX queue that close() then frees. Wait
     with synchronize_net().
     Fixes: bea3348eef27

The triggers are rare and there are no field reports, so the series
targets net-next. All carry Fixes: tags; I am happy to repost
against net, or add Cc: stable, if you prefer.

All were found by AI-assisted review of the ibmveth multi-queue
RX series [1]. Landing them first also shrinks that series, which
then only extends this handling per queue.

Testing: the new and extended KUnit cases in patch 4 fail on the
unfixed driver and pass on qemu pseries (ppc64le). On a POWER10
LPAR: netconsole under printk and ping floods, MTU and buffer pool
changes under traffic, a forced open() failure followed by down and
up, unbind/bind under traffic, a forced register_netdev() failure in
probe, ethtool -L with a forced TX buffer allocation failure, and
rapid link down/up and MTU cycles under a ping flood for patch 8.
The forced failures used test-only module parameters that are not
part of this series.

Changes in v2:

From the Sashiko review of v1:
- Patch 5: give the pool kobjects a release() and wait for it before
  free_netdev() in probe and remove(), which closes the
  CONFIG_DEBUG_KOBJECT_RELEASE window.
- New patch 8: wait for the poll to return before close() frees the
  RX queue (raised on patch 1 as a pre-existing bug).

Other small changes:
- Patch 1: also skip RX replenish in netpoll's budget-0 poll.
- Patch 4: count rx_dropped when recycling an invalid buffer fails.
- Commit messages: say how each bug was found and tested, with small
  clarifications in patches 2 and 7.

Rebased on current net-next.

v1: https://lore.kernel.org/netdev/cover.1790991039.git.mmc@linux.ibm.com/

[1] https://lore.kernel.org/netdev/cover.1790319558.git.mmc@linux.ibm.com/

Thanks,
Mingming

Mingming Cao (8):
  ibmveth: fix netpoll races with RX replenish
  ibmveth: do not close twice after a failed reopen
  ibmveth: disable the reset work before unregister in remove
  ibmveth: step past bad RX correlators instead of spinning or oopsing
  ibmveth: release the pool kobjects when probe fails
  ibmveth: return the error when set_channels cannot add TX queues
  ibmveth: wait for in-flight transmits in ibmveth_close()
  ibmveth: wait for the RX poll to return before freeing the RX queue

 drivers/net/ethernet/ibm/ibmveth.c | 294 +++++++++++++++++++++++------
 drivers/net/ethernet/ibm/ibmveth.h |   5 +
 2 files changed, 237 insertions(+), 62 deletions(-)

-- 
2.39.3 (Apple Git-146)

