Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8F4D09EF;
	Wed, 14 Oct 2026 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982854; cv=fail; b=psQ2xKNgMaIylbewSL7b6psCycyhg+zM+4s5J3n+wXFkCWpojucdZguy/CKpyJRTlzrKGhAZyaM8AKWI9uudTjicnVoCAJfX5QLGQ+02347+ouPLbc/FxWXOx5CTDLr9qVi6ZKr/n0AF3goHml2QHOWnlsM35vQTSFP6cRhc+II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982854; c=relaxed/simple;
	bh=GgjZM2+f6zub7/AIB+w468TMB4/W9TrZxvO7zywl2Wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/pTAPYB3082aWGqP7qt3aL7LtgnMxVjqiJRqwBwYBXbBaPPDBUtCUypD/8kqcUSbNwLVftOWI1GU/3fCqTAK6RiGCtIU+H/x00kbvfPDILU+AposR1RuFZiXwuCHpsF9T2EvCN/0uPdk3ob36yJX4HKmm3hA4+G0/42z4XHls0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=mP5lYAIy; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=T1JeyrhQ; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="mP5lYAIy";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="T1JeyrhQ"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EAaSY32293882;
	Wed, 14 Oct 2026 08:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=1HBKzXq3JrC7MW1P6WOqeqF/XdqhfP876N8v/W0LZ
	lU=; b=mP5lYAIyupO13xdtfa10LlHQRmWfUdDVMb73zCQ0ksRl6qyUXvDQ3Jzh2
	irBfXX2ufG4gKkhUwFgjWWLRkcClB2pCgF/fAeouOpsNMP2PpfVItfdNn0KSg9Aa
	vi+FPSWm7CdjMUmjOIFIYN1BU/GMa6rzKPrqCX9cLPSLZi2yes2xTDzuqDxd+eQm
	7zqFryOzXshI1kbhq1d5quz5ouqssJgHhd/4WuVZ6mGqGNVKPU/yW66puIIoqAe9
	7LUG6CaaF1kvEuXJjDIqGW8oHpu7ypFI1QciKFKR98XnJdpvwyDhh3EA1h6C5od+
	MVJqiMzr/DWanRQoDEm6EjtTz9Kmg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010020.outbound.protection.outlook.com [52.101.193.20])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h9ys53hmj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 08:00:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDoE+ogKEOPpkE9IKE/tPCSJcQ3Vvc9gvlRpoPu2BlH5KHRVhcbhVVYMTpZ4zU0iI5SsrqilgyVwq7wLYz0m88SKw2G3ohUOWHB98qxl9OTDyqD8qoy4Py2r4PJNf8LXVjphjgWn/dWei4hLAP40eq29vnTIbk/2lDWcxnaifIdjnc/OCsvVc9g3AzpHWsjho0+LFIej1SuH07e30Oj2lBHAzdNMLptnP6h+Z6LczGdNtXLyWO9VZIGDu2KxcYCghGczVTcenHScVukXiAragpxVhZQjdjtY6728cGV/gzoQvvax15F6Y4YJ13tpWszvrkZZpbHMzajPGQNgNKhUGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HBKzXq3JrC7MW1P6WOqeqF/XdqhfP876N8v/W0LZlU=;
 b=Dr2P3I4JxmSYzkeleeqddI22qorwvj+Ox0BxUlv9v7fjeFldjWOhX6JkcXBeDB0JngztFzMiafLIDaCKaHLQXLZJNNlSEdvw02JHigPYj3mfgfXwdJR/Jk9coNoKmsMFrj3IsI41pMmhmtrEFKORUoYIkX8GZClK76KGgcuZASKsEBMofA6367idAV3L++RgS9H5zejPi5rVXTdCGPNzZ8bLhUbduC6/ADM7neA4ECmCt3ZfgYI8+gHXBVsyvp5uuszM4V+tU47grOIDBo2dfzILwXXeT9m2k+OZSZWW4mlhhuGio8ZxOrN/Jfk5cqmKzBA7Q0jnKBqVeKxH4SPuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HBKzXq3JrC7MW1P6WOqeqF/XdqhfP876N8v/W0LZlU=;
 b=T1JeyrhQeESGdJudfurXar8DrGK5PR582JbQSRw2pbbXOrjUD/HDJ1vggU/3AzXF2x30qCo0E4E/YdohgG+Yk7l574D2eKaS60CY+Yj235mi9i7nTnPpxJwk7n80nPY3Kesqx6xzLFBbWolZ7d20qqXtdcEaukEeID7hhkRjpgs=
Received: from CH0PR03CA0264.namprd03.prod.outlook.com (2603:10b6:610:e5::29)
 by DS7PR10MB7252.namprd10.prod.outlook.com (2603:10b6:8:ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 12:59:59 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::95) by CH0PR03CA0264.outlook.office365.com
 (2603:10b6:610:e5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 12:59:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 12:59:57 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 14 Oct
 2026 07:59:53 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 14 Oct
 2026 07:59:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 14 Oct 2026 07:59:52 -0500
Received: from localhost (akira.dhcp.ti.com [10.24.72.253])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69ECxpu42333219;
	Wed, 14 Oct 2026 07:59:52 -0500
From: Rishi Kumar <r-kumar12@ti.com>
To: <netdev@vger.kernel.org>
CC: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jacob Keller
	<jacob.e.keller@intel.com>,
        Meghana Malladi <m-malladi@ti.com>,
        "Vadim
 Fedorenko" <vadim.fedorenko@linux.dev>,
        Kevin Hao <haokexin@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-rameshbabu@ti.com>,
        <aaron.richard@ti.com>, <l-chinnannavar@ti.com>,
        <m-santhoshkadavan@ti.com>, <k-tiwari1@ti.com>, <a-dev@ti.com>,
        <r-kumar12@ti.com>, <pratheesh@ti.com>
Subject: [PATCH net 1/2] net: ti: icssg-prueth: fix missing port config on second interface open
Date: Wed, 14 Oct 2026 18:29:47 +0530
Message-ID: <20261014125948.230571-2-r-kumar12@ti.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014125948.230571-1-r-kumar12@ti.com>
References: <20261014125948.230571-1-r-kumar12@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS7PR10MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5f137c-bab0-4e07-98c7-08df29f30cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|1800799024|36860700016|22082099003|18002099003|10067099003|13003099007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	eynKl1bq1og66NBWy2duXsjKIQpDg4lrxwbYDlW4xEVYwrOwODcwrSbCu4ptRnHpHukdPaWuBFTQea6baevPDRq6+K1ZWnAnFi045Dr9VK4NUF5f7CMv1hsowY41l98+rSYR2z4u1iGbgshIJU+qCirXJflB3KIqWvCtVmIzzL8G4+I9R7eMZqkrMwGH/K9uibe0waCgJJVuJdJgekfWagkrFBJftszwl7GnB8KoUAHrdYgSQ4RtfOp2b0iVATk1FR3TOOOurh4Oi/QFBvOLVZdvGnizcgkePxqOKwklVg34KRZVeDJanvjKVJCNmgUkb4FgFNU/GikqkouqekdaAk4Obax54yF6BettxTJENcDBSnqfvXHTwUz00lQhY/+m4EswguyOrEx3Agazb5Djx0qOiyNzmhfSs22Vahh0MjqofFMkXHYZcMW8dyA9+1JjE5Tij4KG54sT6kyWBTvKIl+fptRR3/QU3trf1/TJE3iMnjn430C5x1RVf3IuCZ/pIM2a9GXG99D9x9rXfVe7gOQvYmoTYUM+cr5QNRVJQl7gtGdK3qWg/44xJrynITFQ4zs4eqYtZ+CtzF9/OnlNUxfa+5FyDdxde3gGLnx85sO99dAMbT9gnDjn1DEFu30GdKANtnVAhC70u7r7YZV19+OHjqXAcYTOIE1B2OA+pU4VM9i0ik+Q7HtMZ6foikbLdSmXX7d5y80CNUfox6ZY+A==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(10067099003)(13003099007)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ScxuI/cs1F1U/SOLm0R+5ovaXfoXz/6IL5yYZMt6FDHW4d//RoEfRck/XAVl64Fw4x9M5pL4FRAluQCgHn55VpTdMLiqzJ/Zknnb8lbCSdtWyblEyz/nZGUt3OshUktU5oh2t/J/gnGC/ZqAJ2cVs/C1p78feiqteYxYT18I0eHzotwN3EvP85t6gKIs9q6FcTBUPz5e/hB2V7vnrRT/WtJXd53K6lR/6syIU2lCdMuJSVPdrpkGeONRwbRChug6XfFd/DTumvtElFXzMA3NQpfzm8jvVoOHUA5cD7dXfrORQIpCFqCco888cyfHZkjSuzhycbTk1QrawvlmQxoAPmBz4YDuMliVPB8dd85BrF9fv3DaEGaSG6+VxTedJTc/uCjzfOdvAHJmX9BhFI2onUUZsHnMch9SRkqFO28ZUyjLCblK/3PzCiRShnCZv1aO
X-Exchange-RoutingPolicyChecked:
	oq7ny/xh1CZYoJqyNwyiaTSH8u+d03lU2c/LKS9Ze11Va4c3uk0lc4Fy1jjzjLBCffyVViO8UoepKdHEZHJ1o0qLDJnztzImqmlzOJhR2dc0TqGlDEz/bWb0H7BvZuV6YL5teQFiV2PEiCkNkq2wKG5SXhWKGOFRQcZGBRrQsq2YMnkHPVujA1LHgHKUlYUVuumMV4M4BFnCk/8sOVNqB+Lq1epnnDDZfpoyIyOl0ktWLf9mN/md1Kr+OX7Zamq0HLL/wPagjI05SkUuJkGrZ7Etg7VYVB+UdNCskQezKhxYUhTC0psVz2+Vm5vUBJWCTsZCgoGLn8fp1Xt2aD4rtQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 12:59:57.6490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5f137c-bab0-4e07-98c7-08df29f30cc0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7252
X-Authority-Analysis: v=2.4 cv=ANGCXYlm c=1 sm=1 tr=0 ts=6acf7cd3 cx=c_pps
 a=Qq37X6yQjtlUzqIQK1H1Rg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=NEAV23lmAAAA:8 a=sozttTNsAAAA:8
 a=Dk77J0p82QJiQ1U9Ip8A:9
X-Proofpoint-ORIG-GUID: TrhDGmrHLoqjCMxGpdwJlMlk4vwUTm2p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfX/Klg5i56PG+L
 BmZarbYBGEjUsyxQS+Y5gI828RLAzwKlDossQyC0n7t27PJjQL2sYRH/6/vAHuEcgGlq6BVM4J0
 JcErEQjCAdSYLw9rw6SVoe1YE1rma8M=
X-Proofpoint-GUID: TrhDGmrHLoqjCMxGpdwJlMlk4vwUTm2p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1MSBTYWx0ZWRfXwRYz8yInXlvu
 tejJ7xPZhnd+kbynnHySG29CbsZoDUNDNBUQgFScZOQnpcWZR3CED7gNWgABPys3G8F9uX8N01o
 vE+K2X9DpXROOX8b5us3nUfZ7u6MhJj3RZdcIx0xIs9MYfTpx2eleewn/dZE9zPwATK2nH2kup1
 HPMSih9YrY2myQ/2GDvP0v/oYbq7xoE4HTM0iXoqtSYxml+prQ3q9qsDV3UYRGt2sUTm6qSulv/
 ed3vCw0ZKt9CHBSbtdIjmGKjqniu9N0Uuyva9RPk007CzyfnCpQ/Gmmynb1WynXrngbA/TSZ2+O
 Ovn0n+fwWEqVdMlGZCs/t+OMCUS/3RWkGSTV0QLRsOoRmXNFp58+FVLbiQ3o5DZl6mlJpEIRTCa
 o4UTPzNRJeyH8uSul4K0zKoUCyLTl3hqo37rtg5og/+1axobGdMpeete0h92d6p+cRnXtutQMvB
 nXSg8nlYRGwC5DGtcYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140051

icssg_enable_fw_offload() is gated by !prueth->emacs_initialized, so it
runs only once, on whichever port opens first. If the sibling port is
not yet running at that point, the netif_running() check skips it and
its FDB entry and VLAN table membership are never configured. If one
port is later brought down and up while the sibling stays up,
emacs_initialized is still non-zero, so the function never runs again
and the port is left unconfigured, depending on bring-up order.

Extract the per-port FDB, VLAN table, PVID and VLAN-aware setup into a
new helper icssg_enable_fw_offload_emac(), and the HSR Rx offload
setup into icssg_update_hsr_rx_offload(). Call both unconditionally
from emac_ndo_open() for the port that is actually opening, so each
port configures itself at open time regardless of sibling port state.

icssg_enable_fw_offload() now uses the same helpers and is kept for
icssg_change_mode(), which needs to reconfigure all running ports
after a full firmware restart.

prefix logs: https://gist.github.com/r-kumar12/2279fbfeb5b451a427c4c9778cdfca4a
postfix logs: https://gist.github.com/r-kumar12/071bd3625040fc1fb71207df4e652f58

Fixes: 01792bc3e5bd ("net: ti: icssg-prueth: Fix HSR and switch offload Enablement during firwmare reload.")
Signed-off-by: Rishi Kumar <r-kumar12@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 72 ++++++++++++--------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index f43c1394179f..745178fe7cf3 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -206,6 +206,44 @@ static void prueth_emac_stop(struct prueth *prueth)
 	}
 }
 
+static void icssg_update_hsr_rx_offload(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+
+	if (!prueth->is_hsr_offload_mode)
+		return;
+
+	if (emac->ndev->features & NETIF_F_HW_HSR_TAG_RM)
+		icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE);
+	else
+		icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE);
+}
+
+static void icssg_enable_fw_offload_emac(struct prueth_emac *emac)
+{
+	struct prueth *prueth = emac->prueth;
+
+	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode) {
+		icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
+				  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
+				  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
+				  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
+				  ICSSG_FDB_ENTRY_BLOCK,
+				  true);
+		icssg_vtbl_modify(emac, emac->port_vlan | DEFAULT_VID,
+				  BIT(emac->port_id) | DEFAULT_PORT_MASK,
+				  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
+				  true);
+		if (prueth->is_hsr_offload_mode)
+			icssg_vtbl_modify(emac, DEFAULT_VID,
+					  DEFAULT_PORT_MASK,
+					  DEFAULT_UNTAG_MASK, true);
+		icssg_set_pvid(prueth, emac->port_vlan, emac->port_id);
+		if (prueth->is_switch_mode)
+			icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
+	}
+}
+
 static void icssg_enable_fw_offload(struct prueth *prueth)
 {
 	struct prueth_emac *emac;
@@ -213,34 +251,11 @@ static void icssg_enable_fw_offload(struct prueth *prueth)
 
 	for (mac = PRUETH_MAC0; mac < PRUETH_NUM_MACS; mac++) {
 		emac = prueth->emac[mac];
-		if (prueth->is_hsr_offload_mode) {
-			if (emac->ndev->features & NETIF_F_HW_HSR_TAG_RM)
-				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE);
-			else
-				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE);
-		}
 
-		if (prueth->is_switch_mode || prueth->is_hsr_offload_mode) {
-			if (netif_running(emac->ndev)) {
-				icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
-						  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
-						  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
-						  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
-						  ICSSG_FDB_ENTRY_BLOCK,
-						  true);
-				icssg_vtbl_modify(emac, emac->port_vlan | DEFAULT_VID,
-						  BIT(emac->port_id) | DEFAULT_PORT_MASK,
-						  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
-						  true);
-				if (prueth->is_hsr_offload_mode)
-					icssg_vtbl_modify(emac, DEFAULT_VID,
-							  DEFAULT_PORT_MASK,
-							  DEFAULT_UNTAG_MASK, true);
-				icssg_set_pvid(prueth, emac->port_vlan, emac->port_id);
-				if (prueth->is_switch_mode)
-					icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
-			}
-		}
+		icssg_update_hsr_rx_offload(emac);
+
+		if (netif_running(emac->ndev))
+			icssg_enable_fw_offload_emac(emac);
 	}
 }
 
@@ -1073,8 +1088,9 @@ static int emac_ndo_open(struct net_device *ndev)
 		ret = prueth_emac_common_start(prueth);
 		if (ret)
 			goto free_rx_irq;
-		icssg_enable_fw_offload(prueth);
 	}
+	icssg_update_hsr_rx_offload(emac);
+	icssg_enable_fw_offload_emac(emac);
 
 	flow_cfg = emac->dram.va + ICSSG_CONFIG_OFFSET + PSI_L_REGULAR_FLOW_ID_BASE_OFFSET;
 	writew(emac->rx_flow_id_base, &flow_cfg->rx_base_flow);
-- 
2.53.0

