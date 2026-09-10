Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6293806DC;
	Thu, 10 Sep 2026 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021633; cv=none; b=TFUN3vdl1NPd3RabZeUodvM1ttWaDz5UBEya8UEwMMQZg8Vm9NHNuMnc3hHI4nCc4h72TJ7dwJE7PizWrJK43AFtHF8QlsLLbsEr4C7pUtXWnopXWEwMEdtWCypFwkEAIj1Ef8UKgAUKrZqb3OWCSWI1JB/sknkDm/k0hBK2Qyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021633; c=relaxed/simple;
	bh=3FaBXxv9xyVh0SjpzJa3UzqgIZyWWt8a0aM5MDUqJQg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GOTQEu2mu9F2IYOxSZfyGVyCP+VJye4fo1MWq2+VI7mV7Jl6/KFd5lGJZmSPz6VcoaSgKyakJwA0SKM1+SwChRZ6dvIha0g8myptdgcVWC80B8ybG+qlInojkBjLU9I7irjZFmmm9ymLeM9LKKhOXZ3h6f5pBQfB182yHQn+EB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CQ5WC3Cm; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CQ5WC3Cm"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5Ha1o267798;
	Wed, 9 Sep 2026 23:27:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=U8g7vB8zU8cU+scdHh1h3rI
	8V8VHx8vTeF/ryayir6w=; b=CQ5WC3CmLe1BpDkJyOku6Yv6ED0/w2UJOgaFizn
	sc2hJaupHQi3M+sYJjBr4DJVFwJGc6OFw1KMu5GtA0sW/2kkqkKpK5MWe01ToL8H
	wHEBDZDNEUjhvy+u5eZjRjSn04XBPJTuWrEpPVy/TqROxuuAyB0scOJk6JNXNu0q
	l73rUw4avFsudQxnwWiV0XlsUx82S4fup0pZwUk7OHyU6LDdEuN4ACnWuQO4dOAx
	jOTA6KaCjgNbS17JGxL45OpN0KKR0VsOW2ggRTGf1lRAl4aoX0LwEIFFjsK9DE4b
	M+CnNxXIHnr0mn485ylOopHDvEfjqHYDkkfBHrr/lTJlp0A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gkcxntcaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 23:27:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Sep 2026 23:27:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 9 Sep 2026 23:27:02 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 916D53F7063;
	Wed,  9 Sep 2026 23:26:58 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v6 0/2] octeontx2: Misc fixes for RVU drivers
Date: Thu, 10 Sep 2026 11:56:55 +0530
Message-ID: <20260910062657.3712256-1-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=K923jCWI c=1 sm=1 tr=0 ts=6aa24db7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=4I0ENqp42E1HAAk-qN4A:9
X-Proofpoint-ORIG-GUID: 6F3DAml525beMtiVYmFAIFdE9fPaWY98
X-Proofpoint-GUID: 6F3DAml525beMtiVYmFAIFdE9fPaWY98
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA2NiBTYWx0ZWRfX5FNKO0EAkDnJ
 k5oEAe/nzr4EyNC1I+lwHBQ6BKxRTKWNFdWtQNUYzaGdfAUf6rfXFemiEpqu1BUX0hUkCCgaTJa
 /UD4cPxXq1ADph4rZmZDY3HoAxwbel4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA2NiBTYWx0ZWRfX1UGLPBvZdIhL
 +Ad0GFYUJ/7lQHzTAFfu8/2CTLdzWaXxoFYsZ6dCUCTuabL/TxwUTKUC6BBkJpnYIuVhGC1Hgvd
 d+kaCDLE0ysARrqOjhnYJO/VCYGwHJ3M8CveRfNdBl4MMsIVXIciuEFfgBECrK3jwbuqVwXLn0G
 CJ/SbW15ydfwTO44WSSnaQ9HgO4hFdAYNJvjrKxq0FjyrqhQzigUYlunyrPKeUSojIrfDvxwLPF
 IBiYikdtGJeFyGmsj6LVW3ecEwXTZEKm1a4aMXupf5gB6Jxf+bZ75Hq/pV56zzlvLfiu85MxySu
 zknPwPC1EtZsPNtgfBl5x5HMnyJjiZ9lJ01gjgqw0iuRLoJsHuRbwRzE5dm2/xQkkS/u0vOFjcC
 HKebKau+INDiJLrtcyjOkmWlVXyNdfTLhcbOPoWBvzLlkuKYfgImvgq/MvV+gbcMNt/QJYdBrKj
 kzNFYD2j34Su1whsFYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01

A few independent fixes for the Marvell OcteonTX2 (RVU AF/PF) drivers:

 - Fix aura/CQ BPID assignment under CONFIG_DCB, which assumed
   queue_to_pfc_map was always allocated (not true for SDP VFs).
 - Fix the SC resource cleanup loop that iterated over secy.max
   instead of sc.max.

Changes in v6:
 - None. Rebased onto latest net tree.

Changes in v5:
 - patch 1: Fixing the compilation issue when CONFIG_DCB is
   disabled.

Changes in v4:
 - patch 1: Add 'inline' qualifier to otx2_get_bpid_idx() helper
   defined in the header.
 - patch 2: Correct commit subject in Fixes: tag to match the actual
   upstream commit title.

Changes in v3:
 - patch 1: Unify the BPID index logic into a shared otx2_get_bpid_idx()
   helper, dropping the per-file #ifdef CONFIG_DCB.
 - patch 2: Extend the sc.max fix to the SC stats loop in
   mcs_clear_all_stats(); add Fixes: tag.

Changes in v2:
 - Dropped "octeontx2-af: Fix mcs string buffer size", will
   re-target it to net-next.

Baha Mesleh (1):
  octeontx2-af: mcs: Fix SC resource cleanup loop

Geetha sowjanya (1):
  octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled

 drivers/net/ethernet/marvell/octeontx2/af/mcs.c  |  4 ++--
 .../net/ethernet/marvell/octeontx2/nic/cn20k.c   | 11 +----------
 .../ethernet/marvell/octeontx2/nic/otx2_common.c | 16 ++++++----------
 .../ethernet/marvell/octeontx2/nic/otx2_common.h |  8 ++++++++
 4 files changed, 17 insertions(+), 22 deletions(-)

-- 
2.43.0

