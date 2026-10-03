Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9501A8F7B
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790992673; cv=none; b=bk/h9+daDveWw5BNm4X1QEAazm6fXFLCBTfUz5fFB4AoX8uVprzrmMj9A9ekD5acDKPxRFfJjpm/jjmqLaumNfJv3bgNX7fWUjXIo/lFBU3R9Bep7114ETDWGbsBoM72V4e6vbXotoO6lHJBmcQgsOyLtJOALBTcUz/aE0T43W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790992673; c=relaxed/simple;
	bh=UwAoEVBowGjymE94DpVmvW/TihI/DjMIP0SsOasgadI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i3CRrUVPZJKjiNoneuttPw7Dz+2ah0oQ94QRvIIPYrWTCgeQsprLLKSNcVpwBXwo7mVPPYpKx0wiKSzz7huQTrNv9lMZOMr2omMEDZmJ1sF/Gwo/bKRUhhwxluaNhsn/aPrMm8YHlqxfXBaumfEMP1cOLoRQml5p+7rzjb3M9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ldlf7uDC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ldlf7uDC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69305LkR1896546;
	Sat, 3 Oct 2026 01:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=95mqI5qzwOfO2/EjObKcngGS35A/bfnatHPqZ2Er4
	M8=; b=Ldlf7uDC7eGRN0mRr6pR6agoMssk3unAvgcuxlvpe4+hY6wVJBm9YZUHS
	teJBvfRgehn2LSdi0a4eQX7UbILw4JuWBQdltRVEuEvH855lQIRcW+PVS3RhCSwH
	BKtsrTmENEoDEfmW9nlq1Yltf8+mzRhYIAs0K83vWcvjZXMMGwhkeVkB5WN9plYe
	j3yhGaSIzLavLLc6s8N+z5hR6Sahm+4ic8RgcU9/f8yBv43PyfRNiWB1dQfB4KhC
	SsyjOrf6CEc1hAQvwhtsWyiAjL3WZZtUrvmuF0owh47wmcU4CIDgwIpFc7d3pmKY
	/ELj1GSMyrFvFsV9kvbNq8job9rAg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5veew-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692NlwbV3233087;
	Sat, 3 Oct 2026 01:57:30 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1y2dn71b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 01:57:30 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6931vS8g28771048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Oct 2026 01:57:29 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1EB458055;
	Sat,  3 Oct 2026 01:57:28 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8395358059;
	Sat,  3 Oct 2026 01:57:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.102.94])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  3 Oct 2026 01:57:26 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next 0/7] ibmveth: fix hangs, use-after-frees and netpoll races
Date: Fri,  2 Oct 2026 18:57:12 -0700
Message-Id: <cover.1790991039.git.mmc@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX99keqcR+AGg6
 G3eS2lnp1+YOasjT9V4x+iADAQraQfpWySipZTGmbPa8edbyicbIUMMTr6o9gll3yhZiLLesO6q
 dqApMay015ee/F5AWR+WbeIybWMC5M0=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6ac0610c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TVZ6rJpfqCA6Mtk4hssA:9
X-Proofpoint-GUID: GpfRQ-LqGhGYJF7P0SApYPjA3QKxNHgu
X-Proofpoint-ORIG-GUID: 9rN3-YIXwyeHJygyRuJCHMFy2Z8e_EEb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwNSBTYWx0ZWRfX8ux02nR/xgAR
 InGofc8RV2Z0jTrl7YPsxbow0vNuOiFP4g3h7KVgBt31046fY9ET7Cc/8IKbnoR7vZtvjZMcsPA
 ybGE20flOxsBdosOAvJvwJpzTno8EU2lipCq6YvUM70BJw8BxhMaFm6Rm488nQF67aJnMFXeIa2
 oBA7qQLsd5tTkIjPtAfwIiXMU6SpJ5CtzUJb6Xmbk5OllAcsF8sKbuqvsrWpCalaU2GVASTTr9+
 B5qNpGUVCKiZkD93vgm40P/oqT0SmpLEplLfPxqypPM+FihQAxstVNesgEkQhyDl7hG3V6eciUI
 NDcs1JiMU1daBsnCs52AsnG7QdJjUSNc61sFpE96p3tKhai2eYN8is1wcPICL9p8kts2NdsD5Dv
 zWcrRBFDpKyvj6WCDAqKBrHf4b8yQrerGnCYgHrUfwOaKivfpo42ZatJhsCqRjeac7k4RyH4Usy
 T85at9pHxyJWz/n2KtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030005

Hi,

Seven fixes for serious bugs in the ibmveth driver: two hang the
system, three are use-after-frees, one corrupts memory, and one makes
ethtool -L report success when it failed.

The series is based on net-next commit 071876fd5048 ("ref_tracker: Don't
use __GFP_NOFAIL for PF_MEMALLOC thread."). It does not depend on
the two open() error-path fixes recently applied to net
(commit af0524bf4ce1, commit 84bec0bf0352) and merges cleanly with them;
patch 2 explains how it relates to them. It also applies to net with
git am -3.

  1. Netpoll races with RX replenish (memory corruption, NULL
     dereference): remove ndo_poll_controller, as was done for
     ibmvnic, and enable NAPI only once the RX resources exist.
     Fixes: 6b4223748895 ("[PATCH] ibmveth: Add netpoll function")
     Fixes: bea3348eef27 ("[NET]: Make NAPI polling independent of struct net_device objects.")

  2. Hang after a failed internal reopen: the next close() waits in
     napi_disable() forever with RTNL held, and only a reboot
     recovers. Skip close() when open() did not succeed.
     Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")

  3. Use-after-free in remove(): a reset queued from NAPI could run
     on the freed adapter. Disable the reset work first.
     Fixes: 2c91e2319ed9 ("net: ibmveth: Reset the adapter when unexpected states are detected")

  4. RX poll hang on a bad correlator: poll restarts on the same slot
     until RCU stalls, and an inactive pool dereferences NULL. Step
     past the slot, reject inactive pools, count the drop.
     Fixes: 2c91e2319ed9 ("net: ibmveth: Reset the adapter when unexpected states are detected")
     Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")

  5. Use-after-free after a failed probe: the pool kobjects stay in
     sysfs after the adapter is freed. Put them, as remove() does.
     The pool kobjects have no release(), so with
     CONFIG_DEBUG_KOBJECT_RELEASE a short window remains here and in
     remove(); giving them a release() is left for a follow-up.
     Fixes: 860f242eb534 ("[PATCH] ibmveth change buffer pools dynamically")

  6. ethtool -L returns 0 when it cannot allocate the new TX queues.
     Return the allocation error.
     Fixes: 10c2aba89cc0 ("ibmveth: Ethtool set queue support")

  7. Use-after-free of TX buffers: close(), called directly for MTU,
     offload and buffer pool changes, frees them without waiting for
     a running transmit. Use netif_tx_disable().
     Fixes: d6832ca48d8a ("ibmveth: Copy tx skbs into a premapped buffer")

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
probe, and ethtool -L with a forced TX buffer allocation failure.

[1] https://lore.kernel.org/netdev/cover.1790319558.git.mmc@linux.ibm.com/

Thanks,
Mingming

Mingming Cao (7):
  ibmveth: fix netpoll races with RX replenish
  ibmveth: do not close twice after a failed reopen
  ibmveth: disable the reset work before unregister in remove
  ibmveth: step past bad RX correlators instead of spinning or oopsing
  ibmveth: release the pool kobjects when probe fails
  ibmveth: return the error when set_channels cannot add TX queues
  ibmveth: wait for in-flight transmits in ibmveth_close()

 drivers/net/ethernet/ibm/ibmveth.c | 238 ++++++++++++++++++++++-------
 drivers/net/ethernet/ibm/ibmveth.h |   2 +
 2 files changed, 184 insertions(+), 56 deletions(-)

-- 
2.39.3 (Apple Git-146)
