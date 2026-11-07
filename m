Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011049;
	b=I7kdC0Hvhnz0uvciXd3rpfbp7xPByYFj5sPFyITiqXO0A/8KhTA8NpqEKIJRF89GxhKM
	 zYVZSro7AZLK/3mVPmNHX9oh25GRS8rkIdawIfM1WPPfHanb7vnA5Sq8NjxbLajXXFSjD
	 ZiODW/NfocczeW/FI7y8d6igKuWCLOwShs6vUy/WgWjnmyjhiXoQWo53VyUtM4w4nYYsx
	 NwrJJNV1tEyMHbk19W9NPMSlLitBfXn+n5aMT+NG0lojpiHiPhHEicTctjqZnH19JroOs
	 5YCHZeVg9zo2g/NGpSprhiO00GcUafZwrkI8DWpuXMGQrIr4dYeH561PUXhbG3idmzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011049;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0p+Y2iGSfZ6EJBwbmFyShmlBEwlMutl4X2l3jmMBRXs=;
	b=bcPON4ogCWiIm6bprK04U05vMTAIfn5UG8r1kcInuSAvQSXu9OylZs3UyG6gfXSw1G1V
	 h0f3UPwvInvh1EpQIS6lWaivWWd0yYG93nvpq0+KOSRWQPM1XQLh+4drjifzZT1euuQHg
	 tAKYglOtsxECYxwJ8LQMQbyE2GbWZBbz5owE1knbzAB1RcTGcOAYLbAkQwMryRTaN4AwJ
	 0/1NXrX/Zha+gefcKM2pU6ruk5lNtrkOHq1FpeS4sRoKkWAzIwSEUiwTe7o4/FsVT+7Ka
	 TcWIc1B97sXeSvHPDNiULXr72tUwGO+TieUQJQW1/D1eC8l3PwwwA4iVnD6RyxE1BNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mGb5CpW2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.5
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE4606A326;
	Sat,  7 Nov 2026 00:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DBE4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mGb5CpW2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0Toc00uw2Ng5nAgSYZegs9mlfLYWTvzdD9aBxpwj0RRosGl5gxC2Bib5Ie3Srx5McNP3za0ZpAEAc6vbOG1h+Ia2Eq3elv2Yqf4PovP+XSoWUaP21LgYP8cRn7zohuZZ/WqelloO0sM2mUlAB1hHfmKKzkyI9+lF8kxoJdtYKWMkjqUJNwihFJ70WnZeyUYHZ2/xn5MD+Aziuxc0ggWDMWQsy8y5FQItsU5O4Qq/NOKd8kNZNwMhVFcED2OA4voVb2BQEZPhHXP8TGWz9EcyfrZDFe8sbGbnFkuErrkpbJJ2c/K5qddbCynoGelgnLPYKjzj7IaJQDPJEXe8IHndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p+Y2iGSfZ6EJBwbmFyShmlBEwlMutl4X2l3jmMBRXs=;
 b=MkZ2+F+Tw1iK+486h4Wfh5Jkv7kOQSfcabtxEf0xSP9UVK1OsjHOAdp51nbgl7vU34eHYGdiovA5mVM5FU2TQqElvv7Ev2lnWkAhr0OCRxh8YdliGT6lTnChDLdAe+KqhatxR7QkaunZLJaBYsQhMlj1GBMF1pyg8HvKutk20D9Q+S5iO21/E07YU5Z4HO2WxX1pkwOJmrO4rJCE3j5yvWU3ziVyt65HKDIQOIfZo+AOd36/RkfNzz6zss+sSl7FZSmLkuinoS7waGf20/JOdfXEwNVFGZD3GvD8Zlyc4munn2lUNQtBeHU0AyykAEQPIZKC0RzOdbHCWXjs8fY5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p+Y2iGSfZ6EJBwbmFyShmlBEwlMutl4X2l3jmMBRXs=;
 b=mGb5CpW2d33RjEBxQzE1DmMGhLMeFd/QAyl8tqYRLQBfqYtvX52mPOPnqYlXtb3WLSwfYcgzorzL4DmArqAVOiGHLMdLlPcaGsWZsC7C/jRVO2GLC+mMHypz33BZsLbYIJi8LMcz2qIzAdxKwMp185XhO3UJnCqMUysF3bpNMIc=
Received: from CH5PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:1ed::7)
 by DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 00:24:03 +0000
Received: from CH01EPF000BE944.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::42) by CH5PR02CA0005.outlook.office365.com
 (2603:10b6:610:1ed::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Sat, 7
 Nov 2026 00:24:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE944.mail.protection.outlook.com (10.167.244.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 7 Nov 2026 00:24:02 +0000
Received: from [192.168.0.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 18:24:00 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net 0/2] ionic: fix Tx stalls on TSO skbs larger than the
 Tx ring
Date: Sat, 7 Nov 2026 00:23:42 +0000
Message-ID: <20261107-b4-ionic-tso-max-segs-v1-0-67c248a5b681@amd.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI5v7moC/yWM0QqDMBAEf0Xu2YNEtGJ/pfhg4mqv0FhyUQTx3
 03bx1l25iBFFCjdi4MiNlFZQgZbFuSfQ5jBMmamylQ3a03LruZ8Ec9JF34POytmZdO0bkTnJ9Q
 dZfcTMcn+6z4oIFH/H3V1L/j0LdJ5XvBAMwB+AAAA
X-Change-ID: 20261107-b4-ionic-tso-max-segs-057bde9cfe49
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>, Eric Joyner <eric.joyner@amd.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE944:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: 562ccc34-2413-4ab4-2b8f-08df3c656cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|261026140227099003|11063799006|5023799004|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261021135927099003|261102123227099003|261026121527099003|261028144727099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zrgW10KOJ/stbhA669dQsqUgp564/5hXML3Ywv7wEPWnhvyC8C62ULahKXnztEZEfqAqgxKd5gr5zDip53lPCXLvMnyZcd9/4u7OMNO3nk/WUrtwOEz+//pxZjQpkm/IfEjCGeWwxP0GWTKybCnkaujcxH3t+5oIbmIGRrAzNmuxVcpRaWlQF7i1n5pluei3qjaO24T0wYZzaUhKEzJPhZWPRuMPPzY/CYAx+uXwd/3LAn3BBw7qrbtsvy9vtFtXXAHnXPtJesM+kL/mqKmWGbFumSRZS95BysbjrQQtwdA9PdK/uvMnuF/QOK1X28D8zeFmwXQHi6FB5vCDArHgqoRu1tGPcdLj7vcuzwhuQ+tz6wMqlar918Ws5LZN33oxVNrJ8qw2iM37il4f7XJ6JlWoCjOUxpgU/IGNVoCh03sevLkiSZJydcM1mzzOXLp3ZlG6LxEdnEz0yz20xltIpJF27RXJQT58sQHNOD56ek/Ah1L88rQpwPR3xwmD2VsTlWq+p8AzrDCkfmbp7D7kzMlMtwk4wORDZznN/8yDW73AfwTZhLUCZi20hilHk8BhJAc2MyUQ4RSMdIEQh+VKqH/nd7/9nIPb6ZnARAO1bN/e2jz3X/4/1OSSjM9t4g6/fMX+fKJ3koZAvW3pczvlzYSc1cqLtz2p09ZbZSG1CLnTlo28KRNZpYTsJ6599sVFeOFZpbqcnHOLL7kelBbPEw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261026140227099003)(11063799006)(5023799004)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261021135927099003)(261102123227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CsRZGjCdXCJt8iYEtgAJghRDcIyXc4wdHkEmbiq8CyhI8xq1b55IO+LlrCbeMynRhjh5sOxhquzrGphKjin0GwU+xbKFj9I905M8kTcaLekMiF/5FNMKGyhvphAg7iBGYPM1nF80I/o85xTDvOmHeLgYLtQRAG0zFTTPLnAOqB5Oo0DaGgSkaGeqX0VQNLtAGxhamaSfZSeqB+5VSaaTTCKm5N1BNzt2vct2wd56ha0Pvm0zSu6W6frwIOhNu0+Z903IIIuo41uufIpn3cUcHbFVp72mZw6DP2E1y7Zjz8XMq22c5Q/dJ9mRUHbOCY3zZCIDgWpQlCVwqECPR4crIT2m3n3QEk/gdi3J7qKp740lzVuMh3zapVpZsPqgFOL971oYH+EHmBjrahYr2Edo1/tzp6W+WuuVw/FBeWZ3AQn3KfZC4Ena2oV3Sjo7enfa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 00:24:02.4506
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 562ccc34-2413-4ab4-2b8f-08df3c656cd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933

ionic uses one Tx descriptor per TSO segment but never tells the stack
how many it can hold, so tso_max_segs stays at its 65535 default. A TSO
skb with more segments than the Tx ring holds can never be posted: the
queue stops with the ring empty, nothing wakes it, and the netdev
watchdog fires again after every reset. A 64 KB TSO skb needs more
than 1023 segments, the limit of the default 1024-entry ring, once the
MSS is below 64 bytes.

Patch 1 rejects Tx ring sizes below 64. The completion path wakes a
stopped Tx queue only once 44 descriptors are free, so a smaller ring
can stall on its own, and patch 2 would otherwise let such a ring lower
gso_max_segs to a uselessly small value.

Patch 2 advertises tso_max_segs from the Tx ring size and keeps it in
step with ethtool -G, so the stack sizes TSO skbs to fit the ring and
segments larger ones in software.

Tested with the in-tree driver in a VM with the PF passed through:
GSO frames with a virtio-net header and about 1500 segments, injected
through a tap redirected to the ionic netdev with tc mirred, stalled the
Tx queue before the series and are sent without a stall after it;
tso_max_segs follows ethtool -G with the interface up and down, and a
Tx ring of 32 is rejected.

This series was developed with the help of an LLM-based coding
assistant (Claude).

---
Nikhil P. Rao (2):
      ionic: reject Tx ring sizes below the minimum
      ionic: limit TSO segments to the Tx ring size

 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 19 ++++++++++++++++---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 10 +++++++---
 drivers/net/ethernet/pensando/ionic/ionic_lif.h     | 10 ++++++++++
 3 files changed, 33 insertions(+), 6 deletions(-)
---
base-commit: a36b9e205cb3c452ab96cc783e63465d466fe615
change-id: 20261107-b4-ionic-tso-max-segs-057bde9cfe49

Best regards,
--  
Nikhil P. Rao <nikhil.rao@amd.com>

