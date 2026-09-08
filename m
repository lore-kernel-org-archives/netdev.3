Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05AC51D519;
	Tue,  8 Sep 2026 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858584; cv=fail; b=MQJVMPnEKtCKo1WWbGoNPUNB4DO6je/hUU6ea0rFw/Q5g/bzzELGMHmXGxphgzYTGyx4otlBt5MkLG4DG/gRbEYyorXXRnEtTJGHYAzWfoS4p7fuIIMJwAYec+qrFJsqhWs/DQNtLV6DaWPjGT4mFy894tPG2CSzOr86LPjYdKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858584; c=relaxed/simple;
	bh=ikwOSmF6Yhb7TrxLH0e9pOdlILDjcZiiqoq7FYBi9DA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QNTKSDRHY5qonLNCBJ8PDElvofvagAyQ+yNZ99ufwpFhnXB5MEVmE7Hv3xRG9qSB4L+8xgDlKAolYnKaio3oS/qajpsQoRugbwfXN+IUf3aT3xPwJ410MYbm3zsMa62iBGLiJulT4JZRNlIMUuaw7dpSvxWZDLRwKvLGywEL394=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=hxSy+u5G; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=g15XYJNc; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="hxSy+u5G";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g15XYJNc"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6886PNX53415076;
	Tue, 8 Sep 2026 04:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=l3Bz2LF7RTj8x
	GgcOW5cOu8WrQBekfx1T31IYnvNE0c=; b=hxSy+u5GKqxj5d9fbjcNougSlVT8m
	NnANOvISspQI1g9GdISMdVjRcdNDJXCf1D0kfepSfCkZCLqXqJ7iIyKQxRjtj5cp
	qkacbCg3B4DMZxrpfVpydAcIvYzHCI1XZH9SXNSk+L0bHcAB7E8cL+/wDJMuzoBp
	rR5+gPmMqkvOHnZoLcGBjMYnx6qYyhTMbwuhZr5roV9W77zcxtMTF+EqJDIrmcA5
	nYIP9R/Sva70JtgF5l8j50hx7B4AH5cBh865WHWwA8vINotkFl9VMPjfMvSZxeEB
	Ch3E0ogNqeNkU4sDfeMEgStz78um77qEvxQ9IP0fgxxstFmhJPBgy8Wfw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	by m0384305.ppops.net (PPS) with ESMTPS id 4ght65pkq4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 04:09:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgaPj8+bXvDZ8xJdk5elINYhbsMfitsSPU5WHwBB7/ZxbMDGfxAXLo3grvu02SkE/ZUFjBTaLvxq3pxwl12UzBUS6NtpIS1Ki2z5/k304u3n6KLwatRPyVXYBjq59dwqZ6RJGKF/474tpDzSUZaNn0mpxmEq+8dz/pRIYXxPtlve63HYu5WR3zUnaypygVqHq57Bttyv3ojvg3AE4yZ6Eg1W9TnQF5M7sOOpN/PBQBaC1uS7bi6fRvCYrHC7ojMWOo5O+LhTEaQPcczZUzcUpQL+PUYIVSu7u2Un9aXHyHREocT3nAwXGyd+EB59t5GmuWUUSIt7m2HkUlzJ1rOfmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3Bz2LF7RTj8xGgcOW5cOu8WrQBekfx1T31IYnvNE0c=;
 b=LKoHft5TIjGf9nlqlWtlzdkzZG6FuMwDAkgIySdLY0G77UoGTAVg18EY7xx3pFaRe3LyBU9wGv2THmF9+7+T6wBhAD/QkLcHZnyl4im2rLZb4VynYeKQ1rnXuCmrqiG/j7AYpVV2CJC1oo99fZVZ3s/B0pV0uQldDsR2p+7veyB8hTuqeaI8ytN31Az+qGeTCbbz8qUe7SiMNGgkUXV2JYG3ygtmoR1UW/C0ofhBnqpl4gWpFjXQMXdxaHLQ/JDbcvwGSaNvrKmXC8CNumaW+v6+Qy8BkHDxHlf61mqaNU4kdXsLo3REf/1ztCWIdc4WwwE51BeoCAfDH31ps189Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=davemloft.net smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3Bz2LF7RTj8xGgcOW5cOu8WrQBekfx1T31IYnvNE0c=;
 b=g15XYJNccaaFSzRYi8Nbv9pwnPdlVp0eu1BSPHSqUrc8asAXgfb7jUgljqdhcKFApEkcSNt6ATmpgtB/EOjuqxU6Fi431o5OolV4miW9ejcsM9Nzx+3hl7OOjyFZDD4Ptvnmrjd9JeG2lq79XiYgVOE6DujC0XARJot4B24dV7M=
Received: from BL1PR13CA0443.namprd13.prod.outlook.com (2603:10b6:208:2c3::28)
 by BLAPR10MB5089.namprd10.prod.outlook.com (2603:10b6:208:330::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.4; Tue, 8 Sep 2026
 09:09:01 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::54) by BL1PR13CA0443.outlook.office365.com
 (2603:10b6:208:2c3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 09:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 09:09:00 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 04:08:59 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 8 Sep
 2026 04:08:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 8 Sep 2026 04:08:59 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68898xCO3163661;
	Tue, 8 Sep 2026 04:08:59 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.73.69])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 68898w4X019943;
	Tue, 8 Sep 2026 04:08:58 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Felix Maurer
	<fmaurer@redhat.com>,
        Fernando Fernandez Mancera <fmancera@suse.de>,
        "MD
 Danish Anwar" <danishanwar@ti.com>,
        Hangbin Liu <liuhangbin@gmail.com>, "Kees
 Cook" <kees@kernel.org>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        "Lukasz
 Majewski" <lukma@denx.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: hsr: enable promiscuous mode on interlink port with fwd offload
Date: Tue, 8 Sep 2026 14:38:56 +0530
Message-ID: <20260908090856.2876114-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|BLAPR10MB5089:EE_
X-MS-Office365-Filtering-Correlation-Id: bd506c59-df28-4287-7975-08df0d88d24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|921020|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	iVULWoqWiN3Za63+JnpwpV+j2pmq7fbEJQus1ufv5cdM1Wq8YD4BBgZQaaB1468Os2FFCAYqt+3GSwXAGE++9nuw6rmXXQMSHXpgsPka2kPZaHS/NrpnvxrgqEw4/Xw4gXvofqnYW0tAfMNlx1fAu9S6l8zhhRYzvW3tDscJ+ypPWykUhlfBUrZvkxFQCg7Tn/ypk5oY/K7lt7ahLSPB99i+YxhytJamRkQT6srmyRgQgAXgaejtsq836og1yLQ272VB0PhN/6Svjtub0fGI66ONX79bI9yVPaDn97BFRjsxPsFaJ9jvCujpMsLGoetjQ3o/S8cNDu0XbSNCWVIdtY5l5gN9u3BfuzxWRY1EWQFH9A7D8K20M7pOxEOfLJIjmlaFlxQhyRPk6SAjEKnpZEBGvFLmporF0fRinyFkZmCxqrszAAeptipULYSyKNG9h9nJjINvPCDCPXnNHsMgp6R+qnbgAWbvJhCT4WYTOtfG90kFMfmP2spL8eknOriRHuntnXec+vHU47HtOp73t8lrYOuRrhpMtzD0v4a9tanmHhTwOAFfR9zW9CPCj9deBrOmt5bnXPwtmjD4U60IRb8fC+elRXfzEjzyPT2x60te/qbNWY2PFx/Y1w0v3zVnToJzKZHRzeH5SD0xWDzG7KkzyOnn9nh3J2GYhLH8lPBUXLY09X0p5YwqZQWrwHEc/7VLpHi9UZXXilT6ypA0ZzgdbMx2f3T0C5eUYP0Nh246iUVERXxa1qFGSzm/TK9Q
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(921020)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aOpbG0+gYAn4RVvynKs0ysDiId3Cpoo0CZYxBKFg9he76DR59fvqHmOG/IEocNpNoKWLm0k/bwL9CS/C9I6ySX5HvldhcYI/rt1GcEraSsJcNsGshNJerAkl2HKku9ApgXAJFCGuA7jBqrX5ZJGXO3nOrpLrRdtoykPdgDttHRUnO3xhkV5d7ClyxoPDwTJ4dAP2NLTs91shrYokcsOsVCd5wxKZtaUQFT6Pt3goYMFKbbGPpuAdjWjMh9938hkkq34x5lyBw7vxNjCiZxBAaiGIMXI4hVAe8/gq2idSN91ICS06+iH4ld5Vg+3M6FE7lKOlbweVkVZ4Vqmz/UgXYpUqSXJO4Blfvl4WGSXCAMxuvRmXmAwu3PDB1tzbRLc2V6Aan/bHGMKfdvIr5s29FssJhNQwIDV8fvmaacktY/jDr76T7E8DcyQ0qijPoH+7
X-Exchange-RoutingPolicyChecked:
	2WWNozuHW4pq3YRj4/Q5ShdEkvL+P/M5JlkXdWxJz9KpcC1j7KoTeMS54zb5ktKEMLVneUd0iGTi3SJ9rHrFAYa4idLNHr6fjQoFYHhdBHXxM81wD7b2cr6qFpbXqgzGeVX14KESI18TxYxf0g8cQXjogC8eq+eYRMGygSvlYl0ehnwkvGVfKbSWS+iMKe/U5jvX8WYUjyhSZzkhp+dKpMBmBDeAPiX2ruownL0xRNlNTt1IynPDEun5n4zrvdLKI7vn+OAzSblnqT1b9OBo9M9v0YkuPZizj3blvEFMWiwISmJX+unxc4j03X+tQY9cUeiiMlYWQvWNbc8TJFk27g==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 09:09:00.3689
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd506c59-df28-4287-7975-08df0d88d24d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5089
X-Proofpoint-GUID: USq_-8jF-xK91qgXsLeoFvFAhIbhORb4
X-Authority-Analysis: v=2.4 cv=I95Vgtgg c=1 sm=1 tr=0 ts=6a9fd0af cx=c_pps
 a=DPCWJwWgIuHEo730oqIOaQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=6eEUboXb6EBEuhgoORQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA5NiBTYWx0ZWRfX2YcUklSIi8DP
 SIlem2F3cjwg8HwBWmxZyOq0PvjF3rOcB6+H64SBa2qA6RzHYnANjF2rbEYKxbjZwaQ7+I0X6Uo
 W6cOfvXbJ1UvElEZ606mR1+3fDKTKYY57ovHjQZhY/H1hnNbNTELu6a8et4Smgj4W8qed5jzkjo
 ELU9Sg9pwclwwfaZRN2gQhEcn86Mu0BnNqicCyJDmXRJP1vqwP99tbDy8PI1cFXq/p8Usworx2V
 OY6KMxS/CyOw7dCXfYlyZY5Uh5iNER3hosYMGgwEkYw2q6nVM6JJn7KyKK71ikpkj5AeSZOc6nN
 wO6I97RVdsoPERv25v7b+aG6MTS5N8Di90ScqHSusbyHxvmrB4DIN5kzoGU+FQqUvX1d02xIs0R
 lKzClzQyDRFoF3S5XIFCWsFLlETzNqRF/8rc+3KqqDVIRkA4VUH3PmiFnicVOjhAV2Iw8dxZ3H/
 VfQ8Kl5X4v2P5hm6+FQ==
X-Proofpoint-ORIG-GUID: USq_-8jF-xK91qgXsLeoFvFAhIbhORb4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA5NiBTYWx0ZWRfX3NFxLufsXf//
 bfAMd3WfN/nZ5d+ClNIBA5i+1JifRvoX1ibgawXRnf66gLuLnR+lqNV9H2bfX17gMk8RHUHCq5w
 2ghlVV63D+7fRwBRStovc9+7i2YB6eI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080096

hsr_portdev_setup() skips promiscuous mode on non-master ports when
hsr->fwd_offloaded is set. fwd_offloaded is derived only from the ring
slaves' NETIF_F_HW_HSR_FWD bit, so this also skips it for the interlink
port, which never gets forwarding offload. Without promiscuous mode,
the interlink NIC drops unicast frames addressed to hsr_dev's MAC
(e.g. SAN traffic to the RedBox), breaking RedBox whenever the ring is
HW-offloaded.

Fixes: 5055cccfc2d1 ("net: hsr: Provide RedBox support (HSR-SAN)")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 net/hsr/hsr_slave.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 01c73b4b50ddd..a546f70f9cc8b 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -149,9 +149,12 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 	int res;
 
 	/* Don't use promiscuous mode for offload since L2 frame forward
-	 * happens at the offloaded hardware.
+	 * happens at the offloaded hardware. The interlink port never
+	 * gets forwarding offload (RedBox forwarding to/from it is done
+	 * by this driver), so it still needs promiscuous mode to receive
+	 * frames addressed to hsr_dev's MAC rather than its own.
 	 */
-	if (!port->hsr->fwd_offloaded) {
+	if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK) {
 		res = dev_set_promiscuity(dev, 1);
 		if (res)
 			return res;
@@ -176,7 +179,7 @@ static int hsr_portdev_setup(struct hsr_priv *hsr, struct net_device *dev,
 fail_rx_handler:
 	netdev_upper_dev_unlink(dev, hsr_dev);
 fail_upper_dev_link:
-	if (!port->hsr->fwd_offloaded)
+	if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK)
 		dev_set_promiscuity(dev, -1);
 
 	return res;
@@ -240,7 +243,7 @@ void hsr_del_port(struct hsr_port *port)
 		netdev_update_features(master->dev);
 		dev_set_mtu(master->dev, hsr_get_max_mtu(hsr));
 		netdev_rx_handler_unregister(port->dev);
-		if (!port->hsr->fwd_offloaded)
+		if (!port->hsr->fwd_offloaded || port->type == HSR_PT_INTERLINK)
 			dev_set_promiscuity(port->dev, -1);
 		if (port->type == HSR_PT_SLAVE_A || port->type == HSR_PT_SLAVE_B)
 			vlan_vids_del_by_dev(port->dev, master->dev);

base-commit: 8d6cd188508513503805c156165de38e4e4a8615
-- 
2.34.1

