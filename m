Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31689372B2B;
	Tue, 19 May 2026 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230644; cv=none; b=WOpbucRfKZ771sa69medFT2Q3p2oW4cEzFQtpvioH1l39Yebz4jLktajIjQ5WqWyONKknlABrSwwkIi+fz4Rv19FWmOgHcxDw5uoOz0UPTbPRi3HKOz4cfN6+1tM69/EgyLJfpI/4s/Rl89im/12jZBVrqfrRiAoluqc1FDNVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230644; c=relaxed/simple;
	bh=JAIKU1oMXr4tjwW6TUuMmSlflARu7U1Kda6l5NIuAW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TuqqlzYCOMIi5od/DX27FTuAGq7kpKmT1bGf5KEj/HapKZGsA+G1P1Y8zCvdrgBrRq2duK/4e9wAyqIDME+iHJ7tGOOeaIZke8OqxOsVlLktoCraqSbpx5pi86HmlaH93vO9Al7sGfBddkGYtIl6fkXGKL+BsTuDzRoBolVzhXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C2xI8rJX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C2xI8rJX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JMDvG23905763;
	Tue, 19 May 2026 22:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VgajbobAVXFKFsterr/wkSPfnFzooZhk39AQ0L0+f
	ss=; b=C2xI8rJXa5RNXFnX3TJbl21qvo5nkwScw99reahMNmY2ZOsZBksdiJ972
	nG4A94mHXZYovQQCHBnI5IVgoZh1F1T7kmC4WTJR3CGXBXnrRM49OKSWYn5w0fd9
	uqWT1wh5b+C/cAptXB8QqZagpCEHcq/8bJCM+Vo6MRNVojjV8BHlfhyeoPYCKrko
	RPiTP2OF0lfqZu8O8bUCPJL2n3KIF9zvLKXtJWSBNB4M6NTf6ijm5zygzdabeNvg
	BRnnFADbCAAHylHaLJihngS/nJ4hUf4bJ4jf0y6f4VNVmMse83cLXlp1v9NwtRmq
	F6t95rTXOxYu8EN3oq/OY2ddbdjEA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8ej9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 22:43:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64JMd8cs028352;
	Tue, 19 May 2026 22:43:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vvxxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 May 2026 22:43:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64JMhalU25821900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 22:43:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5292D58055;
	Tue, 19 May 2026 22:43:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68E695804B;
	Tue, 19 May 2026 22:43:35 +0000 (GMT)
Received: from ltcblue121-lp3.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 May 2026 22:43:35 +0000 (GMT)
From: David Christensen <drc@linux.ibm.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, David Christensen <drc@linux.ibm.com>
Subject: [RFC PATCH net-next 0/2] net: remove the orphaned IBM eHEA driver
Date: Tue, 19 May 2026 17:43:50 -0500
Message-ID: <20260519224353.1282038-1-drc@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDIyNyBTYWx0ZWRfX0w3GltonwcqK
 ZOE6a5mPoiZggP1ci9BGlJueq8bRWzBkLTIN+nDDyt9gSmSUxKLn3QxqLL9I0pxFa9jO3Z6RUlZ
 h4rI639G2uqxIvnGElZaC/JArHn9gQ4hhJJn+qgRdZv/hB2mvn2/0B7Rz9u1cxtiKkM7Jkuj4H2
 46tqo7BnudIBSHnuay0fkN7XSZQ+526YZPvdqxekjRN6fsNiaowR4n3tNI5R5kV1P/0icixLwQj
 74v5XFbyOotxt3NvgxUvhst9159UKa+WThfgBUZ7yPyfQPR+sySSDtDkDxNuceV5TP+ZF3eWaKZ
 WgXniOxR7XF1jFbqgDl+ibfoz67KXFFv6Gpx/DRNcLkmxDotGBcPA4KaxVJRitrePWyX8YpzUJb
 6lb9Yd4xbZxZDh8oLrzieBjUHBpPOQA4hGstxuo7HNvnnhkmUAHIHCRNFhGk88CCVHBBH7BaWOr
 pKCpakg93/pjogWgGaA==
X-Proofpoint-GUID: P1yamkcNq5Q1JHJIZfC_Zhg2yKbPprcz
X-Proofpoint-ORIG-GUID: u9RxXADsTDGOgY2GnmJSQN6R6oFqdyI1
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ce79a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=Mg1kAvL63G5DmFgKp1gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190227

The IBM eHEA (Ethernet Host Ethernet Adapter) driver has been orphaned
since April 2024 with no active maintainer stepping forward. This series
removes the driver and associated references from the kernel tree.

## Why now

The driver was marked as Orphan in commit 97ec32b583bb ("MAINTAINERS: eth:
mark IBM eHEA as an Orphan") on April 18, 2024, with approval from the
PowerPC maintainer. In the 13 months since, no maintainer has stepped
forward to take ownership.

The hardware was last supported on IBM POWER7 systems, which reached
end-of-support in December 2020. The driver has received no functional
updates since October 2022 (commit 0e7ce23a917a, "net: ehea: fix possible
memory leak in ehea_register_port()"). All subsequent changes have been
mechanical API migrations affecting the entire kernel tree.

A search of lore.kernel.org for "ehea" over the last 24 months reveals:
- Zero user reports of active deployment
- Zero objections to the orphan status
- Zero maintenance discussions beyond mechanical updates
- One tasklet-to-workqueue conversion patch (July 2024) as part of a
  tree-wide infrastructure modernization

## RFC rationale

This series is posted as RFC to give any remaining users the opportunity to
identify themselves before this is reposted as a non-RFC series for
inclusion in net-next. If you are using this hardware in production, please
respond to this thread within the next two weeks.

## Reversibility

The code is preserved in git history and can be restored if a maintainer
steps forward to take ownership. The driver was originally introduced in
commit 7a291083225a ("[PATCH] ehea: IBM eHEA Ethernet Device Driver") on
September 13, 2006.

## Testing

- Diff equivalence verified: the series produces identical tree state to
  the original single-commit removal
- checkpatch.pl --strict: clean on both patches
- Build test: Both patches build successfully on native ppc64le

## Patch breakdown

Patch 1/2: Remove the driver code, Kconfig/Makefile entries, and
           MAINTAINERS block (netdev tree, 7042 deletions)
Patch 2/2: Remove powerpc defconfig entry and obsolete comment in
           arch/powerpc/mm/mem.c (powerpc tree, 5 deletions)

David Christensen
  net: ethernet: ibm: remove the ehea driver
  powerpc: remove ehea driver references

 MAINTAINERS                                  |    5 -
 arch/powerpc/configs/ppc64_defconfig         |    1 -
 arch/powerpc/mm/mem.c                        |    4 -
 drivers/net/ethernet/ibm/Kconfig             |    9 -
 drivers/net/ethernet/ibm/Makefile            |    1 -
 drivers/net/ethernet/ibm/ehea/Makefile       |    7 -
 drivers/net/ethernet/ibm/ehea/ehea.h         |  477 ---
 drivers/net/ethernet/ibm/ehea/ehea_ethtool.c |  277 --
 drivers/net/ethernet/ibm/ehea/ehea_hw.h      |  253 --
 drivers/net/ethernet/ibm/ehea/ehea_main.c    | 3579 ------------------
 drivers/net/ethernet/ibm/ehea/ehea_phyp.c    |  612 ---
 drivers/net/ethernet/ibm/ehea/ehea_phyp.h    |  433 ---
 drivers/net/ethernet/ibm/ehea/ehea_qmr.c     |  999 -----
 drivers/net/ethernet/ibm/ehea/ehea_qmr.h     |  390 --
 14 files changed, 7047 deletions(-)
 delete mode 100644 drivers/net/ethernet/ibm/ehea/Makefile
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea.h
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_ethtool.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_hw.h
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_main.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_phyp.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_phyp.h
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_qmr.c
 delete mode 100644 drivers/net/ethernet/ibm/ehea/ehea_qmr.h

-- 
2.47.3

