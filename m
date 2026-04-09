Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275F13815D4;
	Thu,  9 Apr 2026 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775728428; cv=none; b=ObwcKILA/Ne+0pVz5emX9B7dyJCgKkEi6BfUKEPA5CXcKWo8pohGcizyjXTgjbLzciuk7QKujGUGW+8bWDgIZBsTsesUD+jpPamLkxCkdcEFBJzc0+hpFROxdDSjfZnOCIpr1Flm6bRwHqmQs0smmqGBFNo44LwXyF349e+knuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775728428; c=relaxed/simple;
	bh=mZPf7BigUouzlgJ++tCMblfW/BSOaFOArE/ZWfXG1JE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/KCn9z3Nh08uKN/TWQw1n007T0t4nI5tiGGQirfmLPPPECgUN/Ahp91AHuBeNbWfmifG41fmdyCRdoUaxQu+ROvppMyNoSkze/HqkHkdkwwLXgP9MNKXxdEJER7XPu+4o/+4NtW0/vAaJe7Pq4jA7uom1AhimeMqfe9BC3db98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JbXyAaqO; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JbXyAaqO"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638NaEBf2131122;
	Thu, 9 Apr 2026 02:53:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=tqXQATzsnol0D2p2ROL/PVlRbZrFDmx5Zm86JYlVTUI=; b=JbX
	yAaqOx65swtHAnoPF2+c/UmfarHbKwNlBF+QJpHnLtdBxDytDo/zzWCXOSMeyzTR
	BQLP6Ed6j6VFJIObCQBQzbj9z+3gI6n1tf5aPRhtgbXzwkIPIHTK/ln/EI9gff9S
	suGA5BrKXpylTSNGxyaMApHU/udtHqGrOe22vKDHwIKHQGAjP4AajpT5JIUy/FwO
	ZgOLmQtrygEhmHRXBlaM08GCOebBAc72C97cboY23fc+SLhgABU6MUNzF5PO4Xo4
	BqmuUGOe+AmbWiG/5s51su1IJP+x2LZswFYA+7wYhGD6YN+TBI3kavN0DeYIQXmH
	lOUeW8R+e2h/aK5RobQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4de0u416ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 02:53:38 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 9 Apr 2026 02:53:37 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 9 Apr 2026 02:53:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 9 Apr 2026 02:53:36 -0700
Received: from hyd1358.marvell.com (unknown [10.29.37.11])
	by maili.marvell.com (Postfix) with ESMTP id EBF573F7071;
	Thu,  9 Apr 2026 02:53:32 -0700 (PDT)
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <bbhushan2@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>
Subject: [net-next PATCH v5 0/4] octeontx2: CN20K NPA Halo context support
Date: Thu, 9 Apr 2026 15:23:20 +0530
Message-ID: <1775728404-28451-1-git-send-email-sbhatta@marvell.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=KpN9H2WN c=1 sm=1 tr=0 ts=69d77722 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=Apbl8yOqu0udmtBCm5gA:9
X-Proofpoint-ORIG-GUID: aipurw7UOYHWT9VvWhTFXCIZcUNSpV0m
X-Proofpoint-GUID: aipurw7UOYHWT9VvWhTFXCIZcUNSpV0m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA4OCBTYWx0ZWRfXzJzA56yKTda9
 QhH8toGar5TNy/qDt0PgwA7bSnso5A9NzJfeNVRmsdjLEiskJVaF9o5t8Jl1w5nm4bxENi4RA45
 2jU3wIL0HBgJzgnjLQpc2tiqUasipsot9buooZPlUo1dBJF26BAWqnd4Va8EgjS6pXijp8U9zEg
 b4bKymFLBHdADvfzWcgwtd3ItUcSwptJ4QVnVUN7bwe+1QjzrRTcS2y5p9HoROjYGPEDmzFskD9
 BAVTOAeNmywtvHQW2gdDFJpJeNCKVv+zOyyPfikKK7ck5/uyz0inIHH2n9t8OtbrP89kuy7P7yH
 PMjv7SyPhoxpLGdJTCVNVMfgq85zW0ZyfRU5T2Tb9I2XjjnlF29U04GC1uNklHmtPFH1ZiGwFkP
 igxyLxP7laUdgByhz6kZoCahgSJRDNSwNUFL11PpEi9W23inXNOb882AZ+rcz+XkD5DJNC4YYiT
 PVSLlZQELAVwPxP1zDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-09_01,2025-10-01_01

This series adds NPA Halo support for CN20K in the octeontx2 AF and
PF drivers. On CN20K, NPA supports a unified "Halo" context that combines
aura and pool contexts in a single structure. This is a simplification
in hardware so that there is no need to initialize both Aura and Pool
contexts for queues. Separate Aura and Pool contexts are needed say if
we have to point many Auras to a single pool but we always use 1:1 Aura
and Pool map in Octeontx2 netdev driver. Hence for CN20K use Halo
context for netdevs.

The series:

  1) Adds Halo context type, mbox handling, and halo_bmap tracking in AF.
  2) Adds NPA DPC (diagnostic/performance counters) 32 counters with
     per-LF permit registers, mbox alloc/free, and teardown handling.
  3) Adds debugfs for Halo (halo_ctx file and NPA context display/write
     for HALO ctype).
  4) Switches the CN20K PF driver to use the unified Halo context and
     allocates a DPC counter for the NPA LF.

Changes for v5:
 Fixed double free of DPC counter in error path as per AI review
 Modified commit message to state that backpressure
 is not supported currently
Changes for v4:
 Fixed DPC counter leak as per AI review
Changes for v3:
 Fixed all AI reviews
 Removed inline for npa_ctype_invalid(as per Simon)

Changes for v2:
 Fixed all AI reviews
 Removed inline and added const for npa_ctype_str(as per Simon)
 Fixed build warning flagged with W=1


Linu Cherian (3):
  octeontx2-af: npa: cn20k: Add NPA Halo support
  octeontx2-af: npa: cn20k: Add DPC support
  octeontx2-af: npa: cn20k: Add debugfs for Halo

Subbaraya Sundeep (1):
  octeontx2-pf: cn20k: Use unified Halo context

 .../ethernet/marvell/octeontx2/af/cn20k/api.h |   6 +
 .../marvell/octeontx2/af/cn20k/debugfs.c      |  60 +++++
 .../marvell/octeontx2/af/cn20k/debugfs.h      |   2 +
 .../ethernet/marvell/octeontx2/af/cn20k/npa.c | 156 +++++++++++++
 .../ethernet/marvell/octeontx2/af/cn20k/reg.h |   7 +
 .../marvell/octeontx2/af/cn20k/struct.h       |  81 +++++++
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  25 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   5 +
 .../marvell/octeontx2/af/rvu_debugfs.c        |  71 +++++-
 .../ethernet/marvell/octeontx2/af/rvu_npa.c   |  77 ++++++-
 .../marvell/octeontx2/af/rvu_struct.h         |   1 +
 .../ethernet/marvell/octeontx2/nic/cn20k.c    | 215 +++++++++---------
 .../ethernet/marvell/octeontx2/nic/cn20k.h    |   3 +
 .../marvell/octeontx2/nic/otx2_common.h       |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   8 +
 15 files changed, 601 insertions(+), 119 deletions(-)

-- 
2.48.1

