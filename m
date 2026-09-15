Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171E2FD696;
	Tue, 15 Sep 2026 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454023; cv=fail; b=gi1YHhUFa8hxknx49LZ6Q3MZkRVanlXNXPoPncPsB4ogcUxigJEzbh8zSlzjevnnHVO2PUMKhRcux/GAp+2BlMsnTDEhKepkHVbEBE3ojrBp+2UT6csdxBVbW5S/YZO7Iu7aF/9Gx7HhyrBdyv6SaBcH3+qG6M6iG84BBlb8oIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454023; c=relaxed/simple;
	bh=OkcmbVNndZMbUAeahSZjeEkfIHPuUVpzr6v9Zn3vnAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQLL9Eg4t1uMyzyXJZGj9H6Y431C3pPsQywcuXKfR0xl3C4rOSWO27NHWVrtwfqJUGvw1VQF9T3N4/zYS6pxLJfkY+Ba5xl5TV1pKo1X13kFGKvpnBB+ISUhagVQcrrv3CRy7lzH9E09yH/Hw08jOOBYu6vw5ktmji2tREtn/Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=GMQg65Kc; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Sb1OJexU; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="GMQg65Kc";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sb1OJexU"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68F2lhmO683778;
	Tue, 15 Sep 2026 01:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=a4I9lHkg7cU6vf+kntXYs6cDc3m8ag8mO4JubG6es
	XU=; b=GMQg65KcvX/xw1WF3DBXGj7gKlqXCMsdMG4P8wdPoj2BNt0cL4BURHdXr
	bgcwsAabUjgdySld66r5CV6RAAlT3M49QoMpP0U0UwQ+sATRo8pbMFhj6f85xpp0
	4EEHdnDqHAEgzaukkBC58yD7T2TDmZNFEHCRS4SQIEcqytdeIDNg0gAuQ7Q79cqj
	ShEDpTFMg0A5qaIZrK3b/cuI8Deb2KATA6sRtsk3DRZCJ17GUsR2VbjBANkZW9qU
	5e98wLTZJXHay/09XT365tMSz17OxoG5UojpbbN7lZctL631u1nTRHnBtAq19hUy
	o5cC4lJJh8ydkVFnfkTLA+cqJG9DA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gpvpa1ena-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 01:31:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osVmO4C88T+4GVy0/mxfIdc16PvrNFHRRgWAyL+gsHETFOlPWq8SzkpLfF/WbH/oQInPbzsoX+CJEEyQxMgNThudXI9rxeoIkt7qNjkK9edsxijOZBUq03BL/e1G7uGZd+ysa891ylSKqIA8OSQYztHv855PeZQhKKM6uov8hPDqcYD/tb0TNCGftFaETbynfJbnUg3YgYyK3zjqPHCCBztaJmDsnjTy8zzOMReD5feK4UJJ+NszoHFVA5CuE7VHotpB8qrG4ujosRXvh19tMPzbevN7ZgM69q+AaCQCja1V6vpDVtVsJxzM7MybKFhHzxHpn1nUODp+wnZ1dLpFHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4I9lHkg7cU6vf+kntXYs6cDc3m8ag8mO4JubG6esXU=;
 b=bl1zaRB1V9lMk6jnOf5CBk37D6QgJ+bbYGqsEBUx0tbRWl/IdNduv8aXuywH+y+BM2tQ62yhJb62EJn+qNMYlTjACRNshEfFUXbwhQ4KwlVYqt6A1R8t5WAt6ypIqVea5OlQ/DX6y7u1ravlsRLcPDOrCKswSGeMg0V4aoah8moqo0WfOA+A1Pbd3H9v6ZIu/QNp3VCkvYoa1ES94qx+bPjWs8+ynAda3aGUL1UNpkwfysWWzyTFHwfH453v5WfJJAxziM5kcbDlbP7LFowr0HdJWBC+hheM7i4MZVkiIFNI1QLC3BhueJlohzbOIIKl25m/kSdu/JjPHH4mUb2eLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=users.sourceforge.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4I9lHkg7cU6vf+kntXYs6cDc3m8ag8mO4JubG6esXU=;
 b=Sb1OJexUJwCZOrsrGyQ8OquAxnIOBWw9jKwsYOmUIUKX9bArGKVk/BQpt47gtkZM4nU34TmQ5lhzzK7A2VmyLeKevl3/yV0bFf3RvFqeqTMdvBFTLsnntw9R2DP6ASxg/KUUHLF6G85bvban5cthohilLeZz4gwigUlPZcodJ0I=
Received: from PH8PR02CA0028.namprd02.prod.outlook.com (2603:10b6:510:2da::29)
 by DS0PR10MB7342.namprd10.prod.outlook.com (2603:10b6:8:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 06:31:47 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::5c) by PH8PR02CA0028.outlook.office365.com
 (2603:10b6:510:2da::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Tue,
 15 Sep 2026 06:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 06:31:44 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:31:03 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:31:03 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 01:31:03 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68F6V33p3660941;
	Tue, 15 Sep 2026 01:31:03 -0500
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 68F6V2uX013700;
	Tue, 15 Sep 2026 01:31:03 -0500
From: Meghana Malladi <m-malladi@ti.com>
To: <elfring@users.sourceforge.net>, <philippe.schenker@impulsing.ch>,
        <vadim.fedorenko@linux.dev>, <haokexin@gmail.com>,
        <devnexen@gmail.com>, <horms@kernel.org>, <jacob.e.keller@intel.com>,
        <m-malladi@ti.com>, <arnd@arndb.de>, <afd@ti.com>,
        <parvathi@couthit.com>, <basharath@couthit.com>,
        <vladimir.oltean@nxp.com>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>
Subject: [PATCH net-next v8 2/2] net: ti: icssg-prueth: Add ethtool ops for Frame Preemption MAC Merge
Date: Tue, 15 Sep 2026 12:00:52 +0530
Message-ID: <20260915063052.2274986-3-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915063052.2274986-1-m-malladi@ti.com>
References: <20260915063052.2274986-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DS0PR10MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ca59bc-691a-433b-4581-08df12f30334
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|921020|3023799007|6133799003|10067099003|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	YEpzMiFV/6ufS0cfcIRqXNM0yVaHXr4p0cJNxwVRIRvHrzcc45UIxOkRfyLfL2YpiWl8tcWq4yYvPiuXqRO7CVjWCLOSiKCzzmQ002O6HhijdDcV7k5u3AZjH3r0ZM0Jnr9vkA8qNuMzROFX5bEQcpTxP3xLBQum+phRWUy5tugAjZS83G1z+k2TUFcb9PTQ9Rr/nZb53RSE79IzfbaLF61B8wLnibgLz31ZzSVjrg8pA0JFlpd1nN0YH5+lDnznr+nnmZNuhtkItjR3dpNz20maKFpnmSQ7mR7WHvNQxDI1uw51e0Nj7dmukoKDlHI2pMZa2IsabVLS9N4QdTWinzQOpWdE7TIU3CThYQD6lTNTeGE4msnapdfyHcu3Dr8xBORUMhQ6d4003fx/iEc5lyzkvfuhGR5XiOaWRdoTy4V0TCZ+0IZYAuGslgIy3FEozkqzD/9EzLdGw8NhZQHZkw9yhe3uDR3OzN9IXZBG0TV7HQUAyl13KiQV3qpqNYIkA0l8INXZKDEQKWb2XVQo55ypO6Bntqizy0F2Uh9TyqH8IMbNAI1W2JF9VQsUur7wwqlHdLZrXcOaIAmN66fXn9qzQGWb7kM3HZ9SODdm+3y4fcOtXnnstJ5H5HvTt/HibSV9O1k90h63eWysPx75xqGrM4aW4tYOG5NSN5CdnC9h1sn2UBDY7ZxRJ3irJnJX97llOd1EOw0d4FeNAXFufeGcewwuJfIMn9nGS79I7uzxpp5d86VuiwtZmcZqRxrK
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(921020)(3023799007)(6133799003)(10067099003)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wDjf9O+ehDH8+toDBwQ8BPqBgv//qK/kzVKEwUshdytowTtvHzI/w+0pYBQAjlVr4Iyj27cpLw+rDkh96Z19wQRlXbvEpeFST8sAJA+vkphKVkagynkdjVxO1+NocFwEGDrzAKUjnIWOgFr2K43s01ZIjwBvtgSpeIkrSD8Kl4o8RsmNOxQIZetKl/Y6R1UrkH0DcKsM5B1FqX5fyK+1Zvue6O0BYxCzwNJkpWyUSNwadGOkDNyv/hIs+lu7stROj+LIKKLVrdSQB6b5AFAev6Jsg58FeCCGL4Jmu6RLEuaeCzRQZvItZGnLLtYFQ55bkIz13xGgrvTugRVGEjCoBv7iJLrLOmOwonjFnzKQ5fkj1iFp253z991XzBvcgOlDfHxyiVPW5SaQdTrAEmOKFdy9GGYnqvehf0JqNDvUH1mPvVFylQpUZohqrDUIfL5D
X-Exchange-RoutingPolicyChecked:
	vazDCaqY26jUdEIkGHBb2SQIOanAVWnfeREk09MVTZiLVy94Be8y+jzNnLsD5epzk0vxVDb2Nn+8NwdbJkOthgqscVaa0UYaMu3snyPcQcH3F+x8r1xxn8o046KL5f8TXWiXc+uwB/RgI4iHSwAYZjLxJhoYcowBM8novWrYRahZ2JX7siUXFfJ0vaPP1eigFKmIHBnNZBMOwjefLThDTnzMqcWTjLOfCyNw+LLFuongZT8/QSIR1Qr1Wksoc+9L7dzt2v4CXfoaZTh7G7ln9pJ4ZhePB1nijH7zEF0RCqxDR1ELD+cqjQA2GYgsNZm/P2gaFNw47KZLhefaHvuz2w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:31:44.9336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ca59bc-691a-433b-4581-08df12f30334
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7342
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA5MSBTYWx0ZWRfX5SvxDgRW6RtE
 n1UU3rqCGe6vUmio0RhcCsGOjRv6SPvUyL6Byvvh3YemgluQ2HzEvdmCOF1Bq+jJfXiIFjxLQJo
 3Vl//X/UAZ5GX15Afp9h4iiGSw89AJhT8nq8QHNQorEUz476u3MnBt90CFb2gp5cQ18CQsVLeUE
 uwUlxWsNep97e91BwpEqG1hVwrEMxt7WeKUFxocezJ/EjOUKbXjNFYout5n5sxP8amHE/5kccT4
 EQvrtRLA42MdgrkJw+x3jDSVXmBiIvQK4rJazrTpxT5XJ7upRI2wpQ+ettfp2RbOoyTrTV6SiQW
 kriiSxpg/sGErHrrCYSsEDTsv01DO52k4XKqzFRK/EiTF3ReekAW7KHnb3ICUfIRJeH9R9lemJI
 8lA4JZ6m8hBglJLTBMyoK58gbRcdKYoy/CjkS+mpQUsDa3y+V+Bg8f2MrH//xFPsYXTuBT3wD2L
 qUVXqyCLyz3o0EHeRLA==
X-Proofpoint-ORIG-GUID: 3yiSPwf0HhrMK0J7bKzrHhSAOrRF-me3
X-Authority-Analysis: v=2.4 cv=U7cHnuru c=1 sm=1 tr=0 ts=6aa8e65a cx=c_pps
 a=ikyLliMNhLjillvDIwfXbw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=3No02A6uqN5UtLhohQAA:9
X-Proofpoint-GUID: 3yiSPwf0HhrMK0J7bKzrHhSAOrRF-me3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA5MSBTYWx0ZWRfX0FR2McWRZd0g
 kMp7VeFZafsleBRsZmh1QkvTMHkYGRaG5T65EXU87irInJ+LVmPnfWZZ61t9rrKIzfxikp37V4N
 cqFKNcMgpzpgXS8x5EkYWjD+uI+j6z4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150091

From: MD Danish Anwar <danishanwar@ti.com>

Add driver support for viewing and changing the MAC Merge sublayer
parameters via ethtool ops: .set_mm(), .get_mm() and .get_mm_stats().

The minimum size of non-final mPacket fragments supported by the
firmware without leading errors is 64 Bytes (including FCS).
Add pa stats registers to check statistics for preemption,
which can be dumped using ethtool ops.

Fix emac_get_stat_by_name() to return u64 instead of int and return
0 on error instead of -EINVAL. This prevents invalid stat lookups
from corrupting output stats with signed error codes cast to u64.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v8-v7:
- Fix the duplicating new entries for emac_get_mm_stats()
  which already have a standard uAPI
- emac_set_mm(): Save and restore all four config fields on
  icssg_config_ietfpe() failure so get_mm() reports the
  configuration actually reflected in hardware
  All the above changes address the sashiko review comments

 drivers/net/ethernet/ti/icssg/icssg_ethtool.c | 132 +++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  13 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   4 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |  84 ++++++-----
 .../net/ethernet/ti/icssg/icssg_switch_map.h  |   5 +
 5 files changed, 191 insertions(+), 47 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
index b715af21d23ac..dc25361afe989 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_ethtool.c
@@ -74,7 +74,8 @@ static int emac_get_sset_count(struct net_device *ndev, int stringset)
 		if (emac->prueth->pa_stats)
 			return ICSSG_NUM_ETHTOOL_STATS;
 		else
-			return ICSSG_NUM_ETHTOOL_STATS - ICSSG_NUM_PA_STATS;
+			return ICSSG_NUM_ETHTOOL_STATS -
+			       (ICSSG_NUM_PA_STATS - ICSSG_NUM_PA_STANDARD_STATS);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -93,7 +94,8 @@ static void emac_get_strings(struct net_device *ndev, u32 stringset, u8 *data)
 				ethtool_puts(&p, icssg_all_miig_stats[i].name);
 		if (emac->prueth->pa_stats)
 			for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
-				ethtool_puts(&p, icssg_all_pa_stats[i].name);
+				if (!icssg_all_pa_stats[i].standard_stats)
+					ethtool_puts(&p, icssg_all_pa_stats[i].name);
 		break;
 	default:
 		break;
@@ -114,7 +116,8 @@ static void emac_get_ethtool_stats(struct net_device *ndev,
 
 	if (emac->prueth->pa_stats)
 		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++)
-			*(data++) = emac->pa_stats[i];
+			if (!icssg_all_pa_stats[i].standard_stats)
+				*(data++) = emac->pa_stats[i];
 }
 
 static int emac_get_ts_info(struct net_device *ndev,
@@ -294,6 +297,126 @@ static int emac_set_per_queue_coalesce(struct net_device *ndev, u32 queue,
 	return 0;
 }
 
+static int emac_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	enum icssg_ietfpe_verify_states verify_status;
+
+	if (emac->is_sr1)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&iet->fpe_lock);
+	state->tx_enabled = iet->fpe_enabled;
+	state->tx_min_frag_size = iet->tx_min_frag_size;
+	state->verify_enabled = iet->mac_verify_configure;
+	state->verify_time = iet->verify_time_ms;
+	state->tx_active = iet->fpe_active;
+	verify_status = iet->verify_status;
+	mutex_unlock(&iet->fpe_lock);
+
+	state->rx_min_frag_size = ETH_ZLEN;
+	state->pmac_enabled = true;
+
+	switch (verify_status) {
+	case ICSSG_IETFPE_STATE_DISABLED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+		break;
+	case ICSSG_IETFPE_STATE_INITIAL:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_INITIAL;
+		break;
+	case ICSSG_IETFPE_STATE_VERIFYING:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_VERIFYING;
+		break;
+	case ICSSG_IETFPE_STATE_SUCCEEDED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
+		break;
+	case ICSSG_IETFPE_STATE_FAILED:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
+		break;
+	default:
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
+		break;
+	}
+
+	/* 802.3-2018 clause 30.14.1.6, says that the aMACMergeVerifyTime
+	 * variable has a range between 1 and 128 ms inclusive. Limit to that.
+	 */
+	state->max_verify_time = ETHTOOL_MM_MAX_VERIFY_TIME_MS;
+
+	return 0;
+}
+
+static int emac_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
+		       struct netlink_ext_ack *extack)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	u32 old_verify_time_ms, old_tx_min_frag_size;
+	bool old_fpe_enabled, old_mac_verify_configure;
+	int err;
+
+	if (emac->is_sr1)
+		return -EOPNOTSUPP;
+
+	if (!cfg->pmac_enabled) {
+		NL_SET_ERR_MSG_MOD(extack, "preemptible MAC is always enabled");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&iet->fpe_lock);
+	old_verify_time_ms = iet->verify_time_ms;
+	old_tx_min_frag_size = iet->tx_min_frag_size;
+	old_fpe_enabled = iet->fpe_enabled;
+	old_mac_verify_configure = iet->mac_verify_configure;
+
+	iet->verify_time_ms = cfg->verify_time;
+	iet->tx_min_frag_size = cfg->tx_min_frag_size;
+	iet->fpe_enabled = cfg->tx_enabled;
+	iet->mac_verify_configure = cfg->verify_enabled;
+	err = icssg_config_ietfpe(ndev, cfg->tx_enabled);
+	if (err) {
+		/* icssg_config_ietfpe's fallback path already cleared fpe_active.
+		 * Restore all config fields so get_mm() reports the configuration
+		 * that is actually reflected in hardware.
+		 */
+		iet->verify_time_ms = old_verify_time_ms;
+		iet->tx_min_frag_size = old_tx_min_frag_size;
+		iet->fpe_enabled = old_fpe_enabled;
+		iet->mac_verify_configure = old_mac_verify_configure;
+	}
+	mutex_unlock(&iet->fpe_lock);
+
+	return err;
+}
+
+static void emac_get_mm_stats(struct net_device *ndev,
+			      struct ethtool_mm_stats *s)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+
+	if (emac->is_sr1)
+		return;
+
+	if (!emac->prueth->pa_stats)
+		return;
+
+	emac_update_hardware_stats(emac);
+
+	/* Hold stats_lock to prevent icssg_stats_work_handler from updating
+	 * pa_stats[] between reads, which could yield a torn u64 value on
+	 * 32-bit architectures.
+	 */
+	spin_lock(&emac->prueth->stats_lock);
+	/* MACMergeHoldCount stats is not tracked by the firmware */
+	s->MACMergeFrameAssOkCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_OK");
+	s->MACMergeFrameAssErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_ASSEMBLY_ERR");
+	s->MACMergeFragCountRx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_RX");
+	s->MACMergeFragCountTx = emac_get_stat_by_name(emac, "FW_PREEMPT_FRAG_CNT_TX");
+	s->MACMergeFrameSmdErrorCount = emac_get_stat_by_name(emac, "FW_PREEMPT_BAD_FRAG");
+	spin_unlock(&emac->prueth->stats_lock);
+}
+
 const struct ethtool_ops icssg_ethtool_ops = {
 	.get_drvinfo = emac_get_drvinfo,
 	.get_msglevel = emac_get_msglevel,
@@ -317,5 +440,8 @@ const struct ethtool_ops icssg_ethtool_ops = {
 	.set_eee = emac_set_eee,
 	.nway_reset = emac_nway_reset,
 	.get_rmon_stats = emac_get_rmon_stats,
+	.get_mm = emac_get_mm,
+	.set_mm = emac_set_mm,
+	.get_mm_stats = emac_get_mm_stats,
 };
 EXPORT_SYMBOL_GPL(icssg_ethtool_ops);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index f73b8f5fca956..ad9061408050e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -45,6 +45,7 @@
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
 #include "icssg_qos.h"
+#include "icssg_stats.h"
 
 #define PRUETH_MAX_MTU		(2000 - ETH_HLEN - ETH_FCS_LEN)
 #define PRUETH_MIN_PKT_SIZE	(VLAN_ETH_ZLEN)
@@ -58,12 +59,16 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
-#define ICSSG_NUM_PA_STATS	32
-#define ICSSG_NUM_MIIG_STATS	60
+#define ICSSG_NUM_PA_STATS	ARRAY_SIZE(icssg_all_pa_stats)
+#define ICSSG_NUM_MIIG_STATS	ARRAY_SIZE(icssg_all_miig_stats)
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
+/* MIIG stats with standard uAPI equivalents (excluded from ethtool -S) */
 #define ICSSG_NUM_STANDARD_STATS 31
-#define ICSSG_NUM_ETHTOOL_STATS (ICSSG_NUM_STATS - ICSSG_NUM_STANDARD_STATS)
+/* PA stats with standard uAPI equivalents, exposed via get_mm_stats only */
+#define ICSSG_NUM_PA_STANDARD_STATS 5
+#define ICSSG_NUM_ETHTOOL_STATS (ICSSG_NUM_STATS - ICSSG_NUM_STANDARD_STATS - \
+				 ICSSG_NUM_PA_STANDARD_STATS)
 
 #define IEP_DEFAULT_CYCLE_TIME_NS	1000000	/* 1 ms */
 
@@ -460,7 +465,7 @@ int emac_fdb_flow_id_updated(struct prueth_emac *emac);
 
 void icssg_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
-int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
+u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
 
 /* Common functions */
 void prueth_cleanup_rx_chns(struct prueth_emac *emac,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 7159baa0155cf..cfdb6f5dc5da1 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -74,7 +74,7 @@ void icssg_stats_work_handler(struct work_struct *work)
 }
 EXPORT_SYMBOL_GPL(icssg_stats_work_handler);
 
-int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
+u64 emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 {
 	int i;
 
@@ -91,5 +91,5 @@ int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 	}
 
 	netdev_err(emac->ndev, "Invalid stats %s\n", stat_name);
-	return -EINVAL;
+	return 0;
 }
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index 5ec0b38e0c67d..b86da8da23a18 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -8,8 +8,6 @@
 #ifndef __NET_TI_ICSSG_STATS_H
 #define __NET_TI_ICSSG_STATS_H
 
-#include "icssg_prueth.h"
-
 #define STATS_TIME_LIMIT_1G_MS    25000    /* 25 seconds @ 1G */
 
 struct miig_stats_regs {
@@ -155,50 +153,60 @@ static const struct icssg_miig_stats icssg_all_miig_stats[] = {
 	ICSSG_MIIG_STATS(tx_bytes, true),
 };
 
-#define ICSSG_PA_STATS(field)	\
-{				\
-	#field,			\
-	field,			\
+#define ICSSG_PA_STATS(field, std)	\
+{					\
+	#field,				\
+	field,				\
+	std,				\
 }
 
 struct icssg_pa_stats {
 	char name[ETH_GSTRING_LEN];
 	u32 offset;
+	bool standard_stats;
 };
 
 static const struct icssg_pa_stats icssg_all_pa_stats[] = {
-	ICSSG_PA_STATS(FW_RTU_PKT_DROP),
-	ICSSG_PA_STATS(FW_Q0_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q1_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q2_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q3_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q4_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q5_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q6_OVERFLOW),
-	ICSSG_PA_STATS(FW_Q7_OVERFLOW),
-	ICSSG_PA_STATS(FW_DROPPED_PKT),
-	ICSSG_PA_STATS(FW_RX_ERROR),
-	ICSSG_PA_STATS(FW_RX_DS_INVALID),
-	ICSSG_PA_STATS(FW_TX_DROPPED_PACKET),
-	ICSSG_PA_STATS(FW_TX_TS_DROPPED_PACKET),
-	ICSSG_PA_STATS(FW_INF_PORT_DISABLED),
-	ICSSG_PA_STATS(FW_INF_SAV),
-	ICSSG_PA_STATS(FW_INF_SA_DL),
-	ICSSG_PA_STATS(FW_INF_PORT_BLOCKED),
-	ICSSG_PA_STATS(FW_INF_DROP_TAGGED),
-	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
-	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
-	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
-	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
-	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
-	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
-	ICSSG_PA_STATS(FW_RX_EXP_FRAG_Q_DROP),
-	ICSSG_PA_STATS(FW_RX_FIFO_OVERRUN),
-	ICSSG_PA_STATS(FW_CUT_THR_PKT),
-	ICSSG_PA_STATS(FW_HOST_RX_PKT_CNT),
-	ICSSG_PA_STATS(FW_HOST_TX_PKT_CNT),
-	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_PRE_OVERFLOW),
-	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW),
+	ICSSG_PA_STATS(FW_RTU_PKT_DROP, false),
+	ICSSG_PA_STATS(FW_Q0_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q1_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q2_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q3_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q4_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q5_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q6_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_Q7_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_DROPPED_PKT, false),
+	ICSSG_PA_STATS(FW_RX_ERROR, false),
+	ICSSG_PA_STATS(FW_RX_DS_INVALID, false),
+	ICSSG_PA_STATS(FW_TX_DROPPED_PACKET, false),
+	ICSSG_PA_STATS(FW_TX_TS_DROPPED_PACKET, false),
+	ICSSG_PA_STATS(FW_INF_PORT_DISABLED, false),
+	ICSSG_PA_STATS(FW_INF_SAV, false),
+	ICSSG_PA_STATS(FW_INF_SA_DL, false),
+	ICSSG_PA_STATS(FW_INF_PORT_BLOCKED, false),
+	ICSSG_PA_STATS(FW_INF_DROP_TAGGED, false),
+	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED, false),
+	ICSSG_PA_STATS(FW_INF_DROP_NOTAG, false),
+	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER, false),
+	/* MAC Merge counters: exposed via .get_mm_stats standard uAPI,
+	 * not duplicated in the private ethtool -S table.
+	 */
+	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG, true),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR, true),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX, true),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK, true),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX, true),
+	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR, false),
+	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF, false),
+	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF, false),
+	ICSSG_PA_STATS(FW_RX_EXP_FRAG_Q_DROP, false),
+	ICSSG_PA_STATS(FW_RX_FIFO_OVERRUN, false),
+	ICSSG_PA_STATS(FW_CUT_THR_PKT, false),
+	ICSSG_PA_STATS(FW_HOST_RX_PKT_CNT, false),
+	ICSSG_PA_STATS(FW_HOST_TX_PKT_CNT, false),
+	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_PRE_OVERFLOW, false),
+	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW, false),
 };
 
 #endif /* __NET_TI_ICSSG_STATS_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 7e053b8af3ece..855fd4ed0b3f6 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -256,6 +256,11 @@
 #define FW_INF_DROP_PRIOTAGGED		0x0148
 #define FW_INF_DROP_NOTAG		0x0150
 #define FW_INF_DROP_NOTMEMBER		0x0158
+#define FW_PREEMPT_BAD_FRAG		0x0160
+#define FW_PREEMPT_ASSEMBLY_ERR		0x0168
+#define FW_PREEMPT_FRAG_CNT_TX		0x0170
+#define FW_PREEMPT_ASSEMBLY_OK		0x0178
+#define FW_PREEMPT_FRAG_CNT_RX		0x0180
 #define FW_RX_EOF_SHORT_FRMERR		0x0188
 #define FW_RX_B0_DROP_EARLY_EOF		0x0190
 #define FW_TX_JUMBO_FRM_CUTOFF		0x0198
-- 
2.43.0

