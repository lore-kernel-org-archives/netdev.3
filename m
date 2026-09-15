Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA602FD696;
	Tue, 15 Sep 2026 06:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789454011; cv=fail; b=hXzXpqxuSL4234R58gBmfobWM1IAe08HlgnAsY9Al1JRE988PQQqUWne54lZti6ifZfSwvJLWqbRslw4wMw8C5+uh+uQEU3RgqgKToX86eo3Xm1nDFn4VxaoWr7kx/jYQAtfeRRvtujfNY3xSm73cp/4UnyhvQ/lshv2pWCIVD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789454011; c=relaxed/simple;
	bh=APNwwpMpl8v/IWa0e3Z2mRVs5JyJ5AIp9382IZEHtAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khctzT4zkBcESO5F+0mm5l11fB4HPUWukLZ5VjSpIJnMwWeNjsBwRv7NVBNi+X8mbI4G+1whR+i7aBY6le0VTwaWRLSl4O+hqlJIzCsgs2y5jzIM3vle+K4vxie8h5ALebTZCGjUDqRWTEmA9pG3vXZCYk5f605YPL5iodqEWOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=M2YM7Pej; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WSKUpz+3; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="M2YM7Pej";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WSKUpz+3"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68F2lh3o683775;
	Tue, 15 Sep 2026 01:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=6ihxu1rsaL6oLosVIhxL+EJ7jXhsN407wemA9XEwU
	Uw=; b=M2YM7Pejad3k8TChFKLhfrjKCYwT3c2vVhJrCQdGCuhXxiACfxbF3o5nc
	bgwIUSR/g4DXbIu93td86u3FMQH4GKDRuWd2FnkTkqddloWc3KiM7gN5opSrsh/M
	eVKm9pfRuiCtlzyr+GveKzmgFkwvB5FVLhNRF7FItSAEKBxmlak6WQwWSW+/+3EP
	WmenKYhIGBoGB0s2UPRX2E2B9VOvnnacMGh34Q7XhRjzOc91+Bvih89FK17OCaUl
	FrLPAy7tG3EnJmnsWKGuNNrr039TbudPwtZ8ZVIqzHRvCHagPJNX3n5BxN+JLAsD
	g9TpWB0YJ6YbePzU8piKjX/jxs+JQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gpvpa1ekf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 01:31:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUMUcW5FNqJ6rEOHzif0T0kS+hKYKdcop8hwKBxEYeQlpNko4aJEhO/gsJr0iKZy3OZxGBtBsB7nvBWPxeJ1k+EFdqvpLas7Z9jw3FzJV/H3Q5VfHmbs/bmrWP7zlhFRJ8Hn2DsElzeVak4Fe6BP/2iUrgxa12PXj+FaJurgAnZtk9x5PkKFtckf9npLh/SfoiNqXefo7XjDUsRcmSij7zcabmkKvSG1B4LhI/p0SntW9KeMkW1ndfZIhZLrAw+W5sxqN/SNjzXD58/cwpVaXOKOZLy2/dab5p5+5CJbmgkQZyUVLKrna4VjMob0MiMlMB0U3Wm/g72vexlLddPykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ihxu1rsaL6oLosVIhxL+EJ7jXhsN407wemA9XEwUUw=;
 b=vj0OGHb4mCG/bbsqlk6zJCGO3uKSsVqO/7jBZCYQ9938tmiMQ5dXPQOxpbPcHqfpVPHrMNU5DcM3MKKiXdiDFqWc2DmunGidTRCMqidcxe7x8ICQO6tLghh1NREdIdQPN1Epp+TkwJpY4sU8V0LFOu8pwwHzU30b5wKdDpGSN01UUeXqqdSQyT9PTmIpkxHnJK55bkkKsDHRKVzcZhS2dcvEkEPKGCfQwd3sV+P0GsjmTq9UKAJRqr6XjVrG/ImxaQhCZq2MU6oFWJ0Um65MsA0ksz1BxncMvVyvKDKyfaTkPZsDnRPhDYZ6AsNkYLuW04sT82lS2v4EYV5SFtK8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=users.sourceforge.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ihxu1rsaL6oLosVIhxL+EJ7jXhsN407wemA9XEwUUw=;
 b=WSKUpz+3clQPMJMMoVCLVz33uP7/v9KV28knQSxJ2VtLEFjtonduurbr+/LHYkm1zjGQsNpEhW/bvZn7dbMn43YJkL7fq31qXgOAXqDd+5hT8bw+0AKyDLeL0/rZNzFcqZj4Qu+KnHsFhVRtXuTEUETi1ADl4dq6KgEaEt43MLU=
Received: from CH0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:610:b3::32)
 by BY5PR10MB4225.namprd10.prod.outlook.com (2603:10b6:a03:20f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 06:31:20 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::76) by CH0PR03CA0057.outlook.office365.com
 (2603:10b6:610:b3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 06:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 06:31:20 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:31:00 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:31:00 -0500
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 01:31:00 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68F6V0HK507825;
	Tue, 15 Sep 2026 01:31:00 -0500
Received: from localhost (meghana.dhcp.ti.com [172.24.231.93])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 68F6UxbN013695;
	Tue, 15 Sep 2026 01:31:00 -0500
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
Subject: [PATCH net-next v8 1/2] net: ti: icssg-prueth: Add Frame Preemption MAC Merge support
Date: Tue, 15 Sep 2026 12:00:51 +0530
Message-ID: <20260915063052.2274986-2-m-malladi@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|BY5PR10MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: a542eb29-1af4-48be-31be-08df12f2f47d
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|10067099003|6133799003|3023799007|22082099003|18002099003|56012099006|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	MzDS4pxXGMZboOj+Llq2QZH4MjzTiBBbi95Ghxe295XgLSByjP1YWN7wljn/KLCe9Q4K6tCdiDDNDeu6QOtoJVDl+juc0JEA1pDLRJ0v7VmSmMs6JM1km+FeRZUW1zR3LVL4mFMiQtbD8577TgOqzgGWnZZGh1JBdA8wMOJvprlWZxKshH8KQo92o56jWPCRjliREEYQ49kDyXACK6esgrA7q8HPl4IGOusmRugFzaI+ht8TJQpqoV1PXc35hW5pRyXVJuAyzS+0+5Yd4rAivuHzLfnYzdiSOJqTIpWaVzU0n0J3lZo1JXuXJBo1Rib8Je2c0oQ9IABVHRt43mrhu/+hTkx+wrCsyRXSgy/aOxQ5hI6emgJ+cUFnbavaw8oxcIoC48UZwsAs72/lhmuig9vmUiLsluVmjnW9iRX/cg/SUlawI0di3h8DGR4zlLaw9C1b+5Bx071y5EWiefZ9xGH6sRp36fv3hIfuNEATO+b9jbene7YJAL7b0UKJYdtHg6cl/kQHTKeB7r0QfINCix6lqK1nNbB6LyW1pP9n0P91jhhNOywa8D0qRDSLgyMkm+D8Jb3m0EubRPkyZvJ1Ijc6EihTOGYoQOkFBkoWKoHMGyTJ6sTiUmKFD0JpqU77uwjXoxrEsH2mp7f46EMV8F+uWZKreQrG0J39n32NkvFtqKPt6AZ9kY0+3othTit6
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(56012099006)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hYKcZwQ14dK/EDJkQnubBhyHKtdgbJAGvCfWFzqTasSXVg8KoO1lSKRXTpYrftrGdZyS9ViwDbrHEvzJzFQhZNkU6g6R9WB4R703vb2JZ4cvMPY6FtI4OWT6GbfFKD3taqlD0wsOug7s5XG8r0jtS/i4n3PWY5Y+0vjCQN3RxSp4PboWqasNAEVXWFH+n+jcfzu56PFKeElsPhTopaegJ/dS0kn0bh5VhjbLpq/EKhGeJcFg1+/JCTjMEJfgpjnpoIWc6UJchuJ1MF5vqJdbdZvLds1JevAwskA9vdA94KyQIgZBrQATsf/Id0DCXsh3DWFUKHD8GRC9sRNa4E5R9ak3v04wE/2u0iX9HKSAtcTqpSsc/cKH2p6PilMmW17Nk381rBkPK+/leB2K4472PY2HUxFtpxMMHxvtNY1uU7rBV2Qk0UQoAZRzqKSamE6e
X-Exchange-RoutingPolicyChecked:
	z0Lg1x5jJj4QeZPxSt8PObMQ7Ph8IOstEKdVPoVyx4KlCrFVX4qgGphpInETNccaRB0ClFODl9Ji5j2csENXi3Md1VDYSJGtNBH8hUtdMe37KcTo8gtaqfOQOwJC9vKE8XNsH0YPuGifL8jYe5MVZey2NClFDJBmOdTCnGG0uLSaS1l8QdqlGddTxJ39ruL4wAOatDabBRMbdWxJzcB5Ud5dy8IG7unEPCdiDsUglPEpGJCBup5TVAAdmpldZpHIJ7LezRYFtqli8ktMPuUuLt5n/UPT7p3vvG4r8U5SQjn6YwZsYP7wiy5KWHWmc1av/ujnYxPtozcevAcQdh6q+A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:31:20.2084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a542eb29-1af4-48be-31be-08df12f2f47d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4225
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA5MSBTYWx0ZWRfX2nDndK7QQ82X
 1ea+gSxPDLwv/w62+NdhYsk0erpxmIN8D0bnfZfXTiFGFndbNKt1bzmfZm6X/i8/NbwzwH6HTSX
 BhgQ3E94efUxqgMAhbP+wDremwXB6WByKujvNWXnjfFNMu/9JdnEZjfqg3tHBdvZJWx1dIT+fi3
 ql1fIG2PuGKgaFYozi3iUhp+WqoEJRQIbplY6J/+q4d9HBw314CEYWZv0gje3s2Ets20WN8kKI0
 HccoE01MrfFbZ/lemfrrfkVpjnqLR9gk07YGYRio6TzHwxDAGpb7WxuibQ1v6RdT+wQy9QvdJJA
 sNAuBPslMrgBlIadJrKbjrD995PzDISUkF3og2RsTz7zt1aIY14wcoZq4WjVMSPopx+sdZMAa+F
 HRHdEdAt5yQxBpGcVBCPZHgnKBakQohUJMMcDPZvh+uhSa7CeyVxlskIt5lnjn5VC+MhwOrcn3o
 Yt2pNAtqo4SvMKJQD9A==
X-Proofpoint-ORIG-GUID: HknGqlj00mCKSM6clFryV1T_bdvSjF4Q
X-Authority-Analysis: v=2.4 cv=U7cHnuru c=1 sm=1 tr=0 ts=6aa8e63d cx=c_pps
 a=Tu5Wf88tfLtYLtD+ArEHOw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=IYJuKz_O2MwEE1U3Vg0A:9
X-Proofpoint-GUID: HknGqlj00mCKSM6clFryV1T_bdvSjF4Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA5MSBTYWx0ZWRfX1USaDjPqNUjA
 IP7/8T1xmzM3MXeFWcIw8uUyPrCjRUzW3hj7p4X7Mey7RTuI+1Q2VVd0OLDAZLv2NCqy8zDU6oR
 mVyog+tGRN7fhwFbkMn45RYDev47SHE=
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

Introduce QoS infrastructure for Frame Preemption (FPE) support in
the ICSSG Ethernet driver.

prueth_qos_iet tracks FPE enable/active state and verify state
machine status via firmware-reported enum icssg_ietfpe_verify_states.
icssg_config_ietfpe() configures IET FPE in firmware, triggers
verify state machine based on ethtool MAC Merge parameters.
Polls firmware verify status up to 3 times with verify_time_ms
intervals and driver handles timeout by logging error and returning.
In case of any failure during configuration for enable/disable,
IET FPE falls back to disabled state.

For MQPRIO qdisc support all queues are express by default later
gets override by user-provided preemptible_tcs bitmask via tc
qdisc mask. Preempt mask configuration: Maps traffic classes to
queue express/preemptible state and applied only when FPE is
active (Tx enabled).

Verify state machine re-triggers on link up/down events based on
fpe_enabled and fpe_active flags, and for memory protection,
fpe_lock serializes all FPE state mutations, preventing races
between ethtool config, qdisc setup, and link events

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---

v8-v7:
- icssg_iet_set_preempt_mask(): Reset all Q_MAP entries before
  applying new TC mapping when fpe_active is true to clear stale
  preemptible entries from a prior wider TC mapping
- icssg_iet_change_preemptible_tcs(): Skip firmware command when
  FPE is not configured to avoid unnecessary PREMPT_TX_DISABLE
  on every link-up event
- icssg_qos_init(): Remove unnecessary mutex lock/unlock since
  no concurrent accessor exists before register_netdev()
  All the above changes address the sashiko review comments

 drivers/net/ethernet/ti/Makefile             |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_common.c |   1 +
 drivers/net/ethernet/ti/icssg/icssg_config.h |   9 -
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |  10 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |   8 +-
 drivers/net/ethernet/ti/icssg/icssg_qos.c    | 305 +++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_qos.h    |  68 +++++
 7 files changed, 389 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_qos.h

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index f4276c9a77620..d19bcd25c9d07 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -46,6 +46,7 @@ icssg-y := icssg/icssg_common.o \
 	   icssg/icssg_config.o \
 	   icssg/icssg_mii_cfg.o \
 	   icssg/icssg_stats.o \
-	   icssg/icssg_ethtool.o
+	   icssg/icssg_ethtool.o \
+	   icssg/icssg_qos.o
 
 obj-$(CONFIG_TI_ICSS_IEP) += icssg/icss_iep.o
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index 4a7d1a6f470b1..d59eef61e7012 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1754,6 +1754,7 @@ void prueth_netdev_exit(struct prueth *prueth,
 
 	netif_napi_del(&emac->napi_rx);
 
+	mutex_destroy(&emac->qos.iet.fpe_lock);
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
 	free_netdev(emac->ndev);
 	prueth->emac[mac] = NULL;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
index 60d69744ffae2..1ac202f855ed4 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_config.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
@@ -323,13 +323,4 @@ struct prueth_fdb_slot {
 	u8 fid;
 	u8 fid_c2;
 } __packed;
-
-enum icssg_ietfpe_verify_states {
-	ICSSG_IETFPE_STATE_UNKNOWN = 0,
-	ICSSG_IETFPE_STATE_INITIAL,
-	ICSSG_IETFPE_STATE_VERIFYING,
-	ICSSG_IETFPE_STATE_SUCCEEDED,
-	ICSSG_IETFPE_STATE_FAILED,
-	ICSSG_IETFPE_STATE_DISABLED
-};
 #endif /* __NET_TI_ICSSG_CONFIG_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 591be5c8056b4..283be27a240e9 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -357,11 +357,11 @@ static void emac_adjust_link(struct net_device *ndev)
 		}
 		if (!emac->link) {
 			new_state = true;
-			emac->link = 1;
+			WRITE_ONCE(emac->link, 1);
 		}
 	} else if (emac->link) {
 		new_state = true;
-		emac->link = 0;
+		WRITE_ONCE(emac->link, 0);
 
 		/* f/w should support 100 & 1000 */
 		emac->speed = SPEED_1000;
@@ -392,6 +392,8 @@ static void emac_adjust_link(struct net_device *ndev)
 		} else {
 			icssg_set_port_state(emac, ICSSG_EMAC_PORT_DISABLE);
 		}
+
+		icssg_qos_link_state_update(ndev);
 	}
 
 	if (emac->link) {
@@ -1652,6 +1654,7 @@ static const struct net_device_ops emac_netdev_ops = {
 	.ndo_hwtstamp_get = icssg_ndo_get_ts_config,
 	.ndo_hwtstamp_set = icssg_ndo_set_ts_config,
 	.ndo_xsk_wakeup = prueth_xsk_wakeup,
+	.ndo_setup_tc = icssg_qos_ndo_setup_tc,
 };
 
 static int prueth_netdev_init(struct prueth *prueth,
@@ -1686,6 +1689,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 
 	INIT_DELAYED_WORK(&emac->stats_work, icssg_stats_work_handler);
 
+	icssg_qos_init(ndev);
+
 	ret = pruss_request_mem_region(prueth->pruss,
 				       port == PRUETH_PORT_MII0 ?
 				       PRUSS_MEM_DRAM0 : PRUSS_MEM_DRAM1,
@@ -1793,6 +1798,7 @@ static int prueth_netdev_init(struct prueth *prueth,
 free:
 	pruss_release_mem_region(prueth->pruss, &emac->dram);
 free_ndev:
+	mutex_destroy(&emac->qos.iet.fpe_lock);
 	emac->ndev = NULL;
 	prueth->emac[mac] = NULL;
 	free_netdev(ndev);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index df93d15c5b786..f73b8f5fca956 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -44,10 +44,11 @@
 #include "icssg_config.h"
 #include "icss_iep.h"
 #include "icssg_switch_map.h"
+#include "icssg_qos.h"
 
-#define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
-#define PRUETH_MIN_PKT_SIZE     (VLAN_ETH_ZLEN)
-#define PRUETH_MAX_PKT_SIZE     (PRUETH_MAX_MTU + ETH_HLEN + ETH_FCS_LEN)
+#define PRUETH_MAX_MTU		(2000 - ETH_HLEN - ETH_FCS_LEN)
+#define PRUETH_MIN_PKT_SIZE	(VLAN_ETH_ZLEN)
+#define PRUETH_MAX_PKT_SIZE	(PRUETH_MAX_MTU + ETH_HLEN + ETH_FCS_LEN)
 
 #define ICSS_SLICE0	0
 #define ICSS_SLICE1	1
@@ -254,6 +255,7 @@ struct prueth_emac {
 	struct bpf_prog *xdp_prog;
 	struct xdp_attachment_info xdpi;
 	int xsk_qid;
+	struct prueth_qos qos;
 };
 
 /* The buf includes headroom compatible with both skb and xdpf */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.c b/drivers/net/ethernet/ti/icssg/icssg_qos.c
new file mode 100644
index 0000000000000..27a953d981538
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Texas Instruments ICSSG PRUETH QoS submodule
+ * Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#include "icssg_prueth.h"
+#include "icssg_switch_map.h"
+
+static void icssg_iet_set_preempt_mask(struct prueth_emac *emac)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
+	struct tc_mqprio_qopt *qopt = &p_mqprio->qopt;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int prempt_mask = 0, i;
+	u8 tc, num_tc;
+
+	if (!iet->preemptible_tcs)
+		goto reset_hw;
+
+	if (iet->fpe_active) {
+		/* Reset all Q_MAP entries first to clear any stale preemptible
+		 * entries from a prior wider TC mapping.
+		 */
+		for (i = 0; i < ICSSG_MAX_TC_QUEUES; i++)
+			writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+
+		/* Configure queues for user requested preemptible tc map */
+		num_tc = p_mqprio->qopt.num_tc;
+		for (tc = 0; tc < num_tc; tc++) {
+			/* check if the tc is preemptive or not */
+			if (iet->preemptible_tcs & BIT(tc)) {
+				/* Set the queues as preemptive queues */
+				for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++) {
+					writeb(BIT(4),
+					       config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+				}
+			} else {
+				/* Accumulate express queue bits for the mask */
+				for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++)
+					prempt_mask |= BIT(i);
+			}
+		}
+		writeb(prempt_mask, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
+		return;
+	}
+
+reset_hw:
+	/* Reset to default: all queues as express */
+	for (i = 0; i < ICSSG_MAX_TC_QUEUES; i++)
+		writeb(0, config + EXPRESS_PRE_EMPTIVE_Q_MAP + i);
+	writeb(ICSSG_EXPRESS_Q_MASK_ALL, config + EXPRESS_PRE_EMPTIVE_Q_MASK);
+}
+
+static int icssg_iet_verify_wait(struct prueth_emac *emac)
+{
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	unsigned long delay_us, timeout_us;
+	u32 status;
+	int ret;
+
+	delay_us = iet->verify_time_ms * 1000;
+	timeout_us = delay_us * ICSSG_IET_VERIFY_ATTEMPTS;
+
+	ret = readb_poll_timeout(config + PRE_EMPTION_VERIFY_STATUS,
+				 status,
+				 status == ICSSG_IETFPE_STATE_SUCCEEDED ||
+				 status == ICSSG_IETFPE_STATE_FAILED,
+				 delay_us,
+				 timeout_us);
+
+	iet->verify_status = status;
+	if (!ret && status == ICSSG_IETFPE_STATE_FAILED)
+		return -EIO;
+	return ret;
+}
+
+/* Direct synchronous configuration of IET FPE.
+ * Caller must hold iet->fpe_lock.
+ */
+int icssg_config_ietfpe(struct net_device *ndev, bool enable)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	void __iomem *config = emac->dram.va + ICSSG_CONFIG_OFFSET;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int ret;
+	u8 val;
+
+	lockdep_assert_held(&iet->fpe_lock);
+
+	if (!READ_ONCE(emac->link)) {
+		netdev_dbg(ndev, "cannot change IET/FPE state when interface is down\n");
+		return 0;
+	}
+
+	/* Update FPE Tx enable bit (PRE_EMPTION_ENABLE_TX) if
+	 * fpe_enabled is set to enable MM in Tx direction
+	 */
+	writeb(enable ? 1 : 0, config + PRE_EMPTION_ENABLE_TX);
+	writew(iet->tx_min_frag_size + ETH_FCS_LEN,
+	       config + PRE_EMPTION_ADD_FRAG_SIZE_LOCAL);
+
+	/* If FPE is to be enabled, first configure MAC Verify state
+	 * machine in firmware as firmware kicks the Verify process
+	 * as soon as ICSSG_EMAC_PORT_PREMPT_TX_ENABLE command is
+	 * received.
+	 */
+	if (enable && iet->mac_verify_configure) {
+		writeb(1, config + PRE_EMPTION_ENABLE_VERIFY);
+		writel(iet->verify_time_ms, config + PRE_EMPTION_VERIFY_TIME);
+	} else {
+		writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
+		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
+	}
+
+	/* Send command to enable FPE Tx side. Rx is always enabled */
+	ret = icssg_set_port_state(emac,
+				   enable ? ICSSG_EMAC_PORT_PREMPT_TX_ENABLE :
+					    ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
+	if (ret) {
+		netdev_err(ndev, "TX preempt %s command failed\n",
+			   str_enable_disable(enable));
+		goto fallback;
+	}
+
+	if (enable && iet->mac_verify_configure) {
+		ret = icssg_iet_verify_wait(emac);
+		if (ret) {
+			netdev_err(ndev, "MAC Merge verification failed: %s\n",
+				   iet->verify_status == ICSSG_IETFPE_STATE_FAILED ?
+				   "link partner rejected" : "timeout");
+			goto disable_tx;
+		}
+	} else if (enable) {
+		/* Give firmware some time to update
+		 * PRE_EMPTION_ACTIVE_TX state
+		 */
+		usleep_range(100, 200);
+	}
+
+	if (enable) {
+		val = readb(config + PRE_EMPTION_ACTIVE_TX);
+		if (val != 1) {
+			netdev_err(ndev,
+				   "Firmware fails to activate IET/FPE\n");
+			ret = -EIO;
+			goto disable_tx;
+		}
+		iet->fpe_active = true;
+	} else {
+		iet->fpe_active = false;
+	}
+
+	icssg_iet_set_preempt_mask(emac);
+	netdev_dbg(ndev, "IET FPE %s successfully\n",
+		   str_enable_disable(enable));
+	return 0;
+
+disable_tx:
+	icssg_set_port_state(emac, ICSSG_EMAC_PORT_PREMPT_TX_DISABLE);
+fallback:
+	writeb(0, config + PRE_EMPTION_ENABLE_TX);
+	writeb(0, config + PRE_EMPTION_ENABLE_VERIFY);
+	iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
+	iet->fpe_active = false;
+	icssg_iet_set_preempt_mask(emac);
+	return ret;
+}
+
+void icssg_qos_init(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+
+	mutex_init(&iet->fpe_lock);
+	/* Set default values to prevent garbage values during .get_mm() */
+	iet->verify_time_ms = ICSSG_IET_MAX_VERIFY_TIME;
+	iet->tx_min_frag_size = ETH_ZLEN;
+}
+EXPORT_SYMBOL_GPL(icssg_qos_init);
+
+static int icssg_iet_change_preemptible_tcs(struct prueth_emac *emac)
+{
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int ret;
+
+	mutex_lock(&iet->fpe_lock);
+	if (!iet->fpe_enabled && !iet->preemptible_tcs) {
+		mutex_unlock(&iet->fpe_lock);
+		return 0;
+	}
+	ret = icssg_config_ietfpe(emac->ndev, iet->fpe_enabled);
+	mutex_unlock(&iet->fpe_lock);
+
+	return ret;
+}
+
+static int emac_tc_query_caps(struct net_device *ndev, void *type_data)
+{
+	struct tc_query_caps_base *base = type_data;
+
+	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+		return 0;
+	}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int emac_tc_setup_mqprio(struct net_device *ndev, void *type_data)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_mqprio *p_mqprio = &emac->qos.mqprio;
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	int tc, offset, count;
+
+	/* Validate parameters */
+	if (qopt->num_tc > ICSSG_MAX_TC_QUEUES) {
+		netdev_err(ndev, "Number of traffic classes (%u) exceeds hardware limit\n",
+			   qopt->num_tc);
+		return -EOPNOTSUPP;
+	}
+
+	if (mqprio->flags & TC_MQPRIO_F_SHAPER) {
+		netdev_err(ndev, "traffic shaping is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (mqprio->flags & (TC_MQPRIO_F_MIN_RATE | TC_MQPRIO_F_MAX_RATE)) {
+		netdev_err(ndev, "per-queue rate limiting is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (!qopt->num_tc) {
+		netdev_reset_tc(ndev);
+	} else {
+		netdev_set_num_tc(ndev, qopt->num_tc);
+
+		for (tc = 0; tc < qopt->num_tc; tc++) {
+			count = qopt->count[tc];
+			offset = qopt->offset[tc];
+			netdev_set_tc_queue(ndev, tc, count, offset);
+		}
+	}
+
+	mutex_lock(&iet->fpe_lock);
+	if (!qopt->num_tc) {
+		iet->preemptible_tcs = 0;
+	} else {
+		memcpy(&p_mqprio->qopt, qopt, sizeof(*qopt));
+		iet->preemptible_tcs = mqprio->preemptible_tcs;
+	}
+	mutex_unlock(&iet->fpe_lock);
+
+	netdev_dbg(ndev, "dev->num_tc %u dev->real_num_tx_queues %u\n",
+		   ndev->num_tc, ndev->real_num_tx_queues);
+
+	return icssg_iet_change_preemptible_tcs(emac);
+}
+
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data)
+{
+	switch (type) {
+	case TC_QUERY_CAPS:
+		return emac_tc_query_caps(ndev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return emac_tc_setup_mqprio(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+EXPORT_SYMBOL_GPL(icssg_qos_ndo_setup_tc);
+
+void icssg_qos_link_state_update(struct net_device *ndev)
+{
+	struct prueth_emac *emac = netdev_priv(ndev);
+	struct prueth_qos_iet *iet = &emac->qos.iet;
+	int ret;
+
+	if (!READ_ONCE(emac->link)) {
+		/* Clear FPE active state on link-down so get_mm() reports
+		 * accurate tx_active and verify_status while link is down.
+		 */
+		mutex_lock(&iet->fpe_lock);
+		iet->fpe_active = false;
+		iet->verify_status = ICSSG_IETFPE_STATE_DISABLED;
+		icssg_iet_set_preempt_mask(emac);
+		mutex_unlock(&iet->fpe_lock);
+		return;
+	}
+
+	ret = icssg_iet_change_preemptible_tcs(emac);
+	if (ret)
+		netdev_dbg(ndev, "IET FPE %s failed\n",
+			   str_enable_disable(iet->fpe_enabled));
+}
+EXPORT_SYMBOL_GPL(icssg_qos_link_state_update);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_qos.h b/drivers/net/ethernet/ti/icssg/icssg_qos.h
new file mode 100644
index 0000000000000..e826ce4bcfd96
--- /dev/null
+++ b/drivers/net/ethernet/ti/icssg/icssg_qos.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2023 Texas Instruments Incorporated - http://www.ti.com/
+ */
+
+#ifndef __NET_TI_ICSSG_QOS_H
+#define __NET_TI_ICSSG_QOS_H
+
+#include <linux/atomic.h>
+#include <linux/netdevice.h>
+#include <net/pkt_sched.h>
+
+#define ICSSG_MAX_TC_QUEUES			8
+#define ICSSG_EXPRESS_Q_MASK_ALL		0xFF
+#define ICSSG_IET_MAX_VERIFY_TIME		128
+#define ICSSG_IET_MIN_VERIFY_TIME		1
+#define ICSSG_IET_VERIFY_ATTEMPTS		3
+
+/**
+ * enum icssg_ietfpe_verify_states - status of MM Verify returned by firmware
+ * @ICSSG_IETFPE_STATE_UNKNOWN:
+ *	verification status is unknown
+ * @ICSSG_IETFPE_STATE_INITIAL:
+ *	Firmware returns this if verify state diagram is idle
+ * @ICSSG_IETFPE_STATE_VERIFYING:
+ *	Firmware returns this if verification is ongoing
+ * @ICSSG_IETFPE_STATE_SUCCEEDED:
+ *	Firmware returns this if verify state diagram completes verification
+ * @ICSSG_IETFPE_STATE_FAILED:
+ *	Firmware returns this if verify state diagram fails during verification
+ * @ICSSG_IETFPE_STATE_DISABLED:
+ *	verification is disabled by the driver
+ */
+enum icssg_ietfpe_verify_states {
+	ICSSG_IETFPE_STATE_UNKNOWN = 0,
+	ICSSG_IETFPE_STATE_INITIAL,
+	ICSSG_IETFPE_STATE_VERIFYING,
+	ICSSG_IETFPE_STATE_SUCCEEDED,
+	ICSSG_IETFPE_STATE_FAILED,
+	ICSSG_IETFPE_STATE_DISABLED
+};
+
+struct prueth_qos_mqprio {
+	struct tc_mqprio_qopt qopt;
+};
+
+struct prueth_qos_iet {
+	bool fpe_enabled;
+	bool mac_verify_configure;
+	u32 tx_min_frag_size;
+	u32 verify_time_ms;
+	bool fpe_active;
+	enum icssg_ietfpe_verify_states verify_status;
+	/* fpe mutex protects all FPE operations for synchronization */
+	struct mutex fpe_lock;
+	u8 preemptible_tcs;
+};
+
+struct prueth_qos {
+	struct prueth_qos_iet iet;
+	struct prueth_qos_mqprio mqprio;
+};
+
+void icssg_qos_init(struct net_device *ndev);
+void icssg_qos_link_state_update(struct net_device *ndev);
+int icssg_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			   void *type_data);
+int icssg_config_ietfpe(struct net_device *ndev, bool enable);
+#endif /* __NET_TI_ICSSG_QOS_H */
-- 
2.43.0

