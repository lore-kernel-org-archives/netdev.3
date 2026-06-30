Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A162FD1C2;
	Tue, 30 Jun 2026 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784553; cv=none; b=QyLsnKMzKHZCM2dkhGXfVuKkHQoR9P1hSy+DemxTQYBHZ1xp4cgcCbfSTdmeLvw6SVbWgLNAq12nOAOOUEVz2NX8ZuBvU8ow3WbQJoJdzPB0kkAV6BtyyHXNFeqFuYwL5vLu+x0aiwbjMPpTqBkuHBp4fFyuCm+p79232YpCjzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784553; c=relaxed/simple;
	bh=cr2oETy4C1aQiD6NtNwbLq68Rta2WF7XtRZHtojddaY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r6zdqfGYd14GzaPAIs1qVQOaziV0KKkbkZikMcVZIpvnQtoQbpdqlOyTAjE9w4xFES8+lTJykY57aMPSH0aIOTx/XUYpTs8V+qWZc99ykgkygMWiSmZcA73NrLXizLniJD7/PP/rts3i/9+vuT0arDkgGRF3NQ6tg2B1BuP9hgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CCMkVen/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CCMkVen/"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U1IPFK3489301;
	Mon, 29 Jun 2026 18:50:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=5TzSs7aaBzNuPllRbmCm11r
	K9IIpM/ddCYuDRCPwL0g=; b=CCMkVen/BPM485QQvUX2sgsl0+bGOl8pI9Ach3b
	DTdeor0cGJ3k5gUCW8iqXKPk7ALU+FLDE+XZJXSjEvlaFqEApWtfyB1dSNk6Jzb4
	Az+YQ8eUMHmcTSNUg/o7/mMoXqT1JS2p7bPnwcv1QoRXTWKcyAsIFiZky7rjgQsj
	hUbr7mbaY7ZvAQb+1itjLh/HCPL9sVDKUaDbt0c5kxYWCSkxR669qwwy7iOULANS
	yEX2ObcrAgr/z/icmD8ARzZky9EJBNYSvoirnovU5Dovxf2vFkIOKITf/J6U6zk9
	6i1dls1Hs380EQaSUSYhOiInB49Nni+AbYWJN1e6SsOR7IA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f2e1h7uhh-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jun 2026 18:50:29 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Jun 2026 18:50:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Jun 2026 18:50:28 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 29E6F3F7068;
	Mon, 29 Jun 2026 18:50:24 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <stephen@networkplumber.org>, <dsahern@kernel.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <rkannoth@marvell.com>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
        <pabeni@redhat.com>, <jiri@resnulli.us>
Subject: [PATCH iproute2-next v2 0/2] devlink: support u64-array devlink parameters
Date: Tue, 30 Jun 2026 07:20:10 +0530
Message-ID: <20260630015012.3728870-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6Da8rfOmvUiSy0tvIReb_TeDebtsn55P
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDAxNCBTYWx0ZWRfX5axZRe/99mKg
 joWZUp7BLwEm2n26mMdFISGhrB+FkrOIhJkmVN6KFAhvmBDlEi4ezPuAd3iT1+nfAikRTYHMjKH
 sVrjy8li9omgzqh6jAN5ANQB1U2UDzg=
X-Authority-Analysis: v=2.4 cv=e802j6p/ c=1 sm=1 tr=0 ts=6a4320e5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=snJZ9v3O13RfP-hfMHkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 6Da8rfOmvUiSy0tvIReb_TeDebtsn55P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDAxNCBTYWx0ZWRfXxY152QxJIBXC
 81fOB1mdLjx5kLUTgKj9GPt2aUdBHvH1qCnI246lBw9dGREr2aAXOp5UKvA6FKIAqM2J+k8iFLD
 Ugt/YOws5kFssI973HAOTbBSKOOqf26EnL55lCXqrtiTlUtqUlIYJI79y5IXJNblRRAcw7SVKtP
 z61CehPTUjDw4cojQTRNGciJzV0RVGAlvFMliQyMEe002z3KbvKZ4p+zhLO2GghOaP00VFcpJRO
 qnPsP/dZRqS62i+MvXmACiLgb+vYJ6ip4A4+gtIr89QYuvJ0YXQY1GHt0THBxrupe1WstAVtotA
 WQbtE7k+Ez/NvIqxcwftfCFx77v+I2QOLug+D4rqO5wKXCLc2oD9vbd1te8NdTx0TvAuqgp1ZKT
 xgzbTWHkhMtTWKf+CmjmsPSou6U5tWf6qJJerqVDaoe8B/nrULs3LNYIIaFn81e+X3+VnB4WtF3
 mEol/zt0Ja1V/kPnC5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_01,2026-06-26_01,2025-10-01_01

The kernel gained support for devlink parameters of type
DEVLINK_VAR_ATTR_TYPE_U64_ARRAY.  These parameters carry a variable-length
list of u64 values encoded as multiple DEVLINK_ATTR_PARAM_VALUE_DATA
attributes.  This is used by drivers that need to expose ordered lists of
configuration values, such as the Marvell CN20K npc_srch_order parameter.

This series updates the devlink tool to handle the new UAPI and adds
show/set support for u64-array parameters on both device and port params.

Patch 1 switches devlink param show/set to use DEVLINK_VAR_ATTR_TYPE_*
constants instead of generic MNL_TYPE_* values when interpreting
DEVLINK_ATTR_PARAM_TYPE.  The kernel now reports param types using
devlink_var_attr_type, so userspace must use the matching symbols.

Patch 2 adds parsing, display, and configuration support for
DEVLINK_VAR_ATTR_TYPE_U64_ARRAY.  Values are shown as a space-separated
list of u64 elements.  Setting accepts a space- or comma-separated list
and emits one DEVLINK_ATTR_PARAM_VALUE_DATA attribute per element.

Tested on CN20K hardware with npc_srch_order:

  # show search order
  devlink dev param show pci/0002:01:00.0 name npc_srch_order
  pci/0002:01:00.0:
    name npc_srch_order type driver-specific
      values:
        cmode runtime value  value  0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31

  # set search order
  devlink dev param set pci/0002:01:00.0 name npc_srch_order \
    value 31,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30 \
    cmode runtime

Depends on the corresponding kernel UAPI addition of
DEVLINK_VAR_ATTR_TYPE_U64_ARRAY.

Ratheesh Kannoth (2):
  devlink: use DEVLINK_VAR_ATTR_TYPE_* in param show/set
  devlink: support u64-array values in devlink param show/set

 devlink/devlink.c            | 178 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/devlink.h |   1 +
 2 files changed, 164 insertions(+), 15 deletions(-)

--
v1 -> v2: Addressed David comments
	https://lore.kernel.org/netdev/20260615041042.549715-1-rkannoth@marvell.com/

2.43.0
