Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011052;
	b=IEOQZ5SzONsTbQfjQITaXTcJnYU3clM5SDopyn1COj5MWDmsFKQqXe9OL7wCLSDQH9Cx
	 YA/tVSnuf5Jj7hFHzLnzGRUQ3990YaGsO/pLgLwHFBRA7CLHj366PxcgX8uMWRrun9REC
	 kM708WHtmP5D0CRsB7bsgQMdR6z+lqBYW5hs+4nYl7vBD5/VI9xc1sjJJthzXtwjqyjaj
	 BR3wYg+XXPpi0pZaNkJI6TPzeGVAHG4eAgDM94Kz24n5n0Feysp7sl/I5oX9b4EZ+UWZO
	 KjZfWP8ulsxcDhfbspgmEKvamYQVVBgsrWylaJQ9lDCIPbKVEYHNsVaoQZuILaQdlyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011052;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-ID:References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=7tKy8Z5io6THizODNJ4rqd7XgI160xiuUF0GMMfgPDk=;
	b=k5pUrRBu+C4I4KFXKms7qvAT0EoZvyZQvmCc9TdDfySOpYrgcfaK+i6/n/B/64aIhQhQ
	 fm5yrxldaTDWcs22c084bQ36qupxASOliAjhnL0bUuu+SKV5t/+lHMaOhHzESa87axi/L
	 qRNsP2AO1iKW9C7l2QezdTWyrVyY0h+n6Rj9YeGBT55hzrQmnpwz0gmOcNwQpMgD8Eq30
	 0+HHH+Hs31eXkAZmLtWcGlCk1HSyfaKjh7Bowgsk/6d5bQZmdRAckwZIyU8VlxIr4KC5w
	 XsVGnw/1a+2jPw41K9834jwtbhWID40j+Nb6I6WcgCKOK07mEFZwbI7b8pg64Vt4I/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="RUdi7hX/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.39
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A05606A32C;
	Sat,  7 Nov 2026 00:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99A05606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RUdi7hX/
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/o8P4trZgeDmNL5LYb1O09XgK+JF+Nu6ZXLjqLzuwARE7v/hJKB/9+JjGPVl48M80lfYwB85Z2bhb0TWhHATff0ds1wHgpKIyT7D7/QviU9P3JhpYU4arAuyAEZb0UojcuyrezXspuTcqWBAg43SQBOoZNP4idliG0tY6hUx4/OAEmtpPpZyC9VkvECuS2LtpWpqSRbjqx6VIpbChtwQlO+n1IpgDud0mooPj4X38qeeTgTg2gQgvxlLhxIpNmXbgTftGczi3g1YJH7KIhoufYbvgCN/NK0M+YdfqUlMdIbzlbT4vDITVNgEAuSoMQMXouj5LUNPGAs0g9r2NEKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tKy8Z5io6THizODNJ4rqd7XgI160xiuUF0GMMfgPDk=;
 b=I/i+g/s30nuDNhEzv+z4aOQXcXSv6n8IDw5JuyKhuAiA7yvyeLa12IqyfJrp75GVhb7CDIowJfWSuCjmJ7ZBNEf2+8Ao7HoFecJshYariIXeIYiS6D4Qzl4Z0MIVpVvjd6fCCZXlFMYbuULHoQA7B5CyBo5UD33AO73iIA8k3O+OOIZWWmSVKRqFqWNu2LfLeqKHagUOO7I2W3hRmZp2SHMvRfzy5e1V2QEbE9lDSZA0OdixDbbzc0AKoSc0ArZuP9Ru/Eao81w2YhD50zPIsngsRy788HZwcS2GrwM6Kw7nao5VpHarUzubh+DAp0TVbqSBkfo4xjeCopqVwzn1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tKy8Z5io6THizODNJ4rqd7XgI160xiuUF0GMMfgPDk=;
 b=RUdi7hX/jZfPgYc1c+9HQzVTbsToZBExvp5O/PwUni+ohjshL3GaWM7FCVq4Ix1kGLvPfbRitwMCPGtxN+IKDP/2QxR40b8attsh9JpqE0qejzXFdIZK/qD2m/xhpY5+QF7FmdRDarT2EknDnXZDiqDXGc/kG2x9Pn5eF3Jgjzg=
Received: from CH5PR02CA0011.namprd02.prod.outlook.com (2603:10b6:610:1ed::28)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 00:24:03 +0000
Received: from CH01EPF000BE944.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::3c) by CH5PR02CA0011.outlook.office365.com
 (2603:10b6:610:1ed::28) with Microsoft SMTP Server (version=TLS1_3,
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
 15.21.615.4 via Frontend Transport; Sat, 7 Nov 2026 00:24:03 +0000
Received: from [192.168.0.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 18:24:01 -0600
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Date: Sat, 7 Nov 2026 00:23:43 +0000
Subject: [PATCH net 1/2] ionic: reject Tx ring sizes below the minimum
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
Message-ID: <20261107-b4-ionic-tso-max-segs-v1-1-67c248a5b681@amd.com>
References: <20261107-b4-ionic-tso-max-segs-v1-0-67c248a5b681@amd.com>
In-Reply-To: <20261107-b4-ionic-tso-max-segs-v1-0-67c248a5b681@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE944:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 1302d964-0b7c-429e-3408-08df3c656da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|5023799004|11063799006|56012099006|261021135927099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	enREZyuAt/76VtbiL2HyREB4UcflTeVcYcTxdlpNdHXZggD4DXu1hQvTzH4bXKZZ6GlA9BLnGuRHOfYK74h+supIz5rIByhfL74b4m3LfSFNhqv5XKFbq8FMgkixSglcXhis1RA2bdywuWMqOgqI38s6raZ+Gk6RtxzsqUfeEGHvOhiLsyT62Wh8R3V/NRUYoeLn5ZJOVHw+O+sfym1SUpFwUuOpiACW8hwzQtH4u4cyImIjgK/1JjGma4vLmJ5iNqBabVwhz19W96M8gHaBe/RT9/wbPzubE3gyoIJYyfx4W1ScNTNoEBaumJv/+mpb6JQUTyDjrgcYGoSNDxnGShn4jdjH/QbSNXQqMJCGoiyVUalDtqt/aQIrMmX/ANHlp7HUWD216BGL0MOJt3k6WGeGR+LGS5I2HDNQMXUuq3EUHkHUCDs0X9mkeCqAp+GSceIh+qirg5pLdSgWiKMWF6RAUmkAhPPPhdm3acqYSXzeGPAwLeIaaPvAyW1S7+hSu0zSmgqBlzmZELJgjk+C5oIJHWd9STOakyHzk79lOZVLJ22heBGYIf62GKMWMHqtPeoMTjtoP0aa3Cy+Fx0V+ahEmB9A4zKOiQNdy74X9e970mzIzmIKkkFosHD0QT+4WZEcTJWPKUbogVWijt6dpbPtVhGe+aSX+IxlZhqoisIMPRqzUtiNfc+bGgCFv7ARBFFQNX1Dw0B7ckQI7rbEzw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(5023799004)(11063799006)(56012099006)(261021135927099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R73fUw7EBZvL/5PFiJiy784V8RMzUvxVwlot89XTHns0NWT5bb+cfLyDD/eHQ82WQj2gR/K7W3iuqmDv4SodsW8tUeroafEOUYnI0DFd3I3hjJr0w1U99DYrDvwdPIzdsJYhhVql8q9zJV4Du0dLx1r27ikYib7May2fkSAOTSFzFdkci0BINOi8r7wwxCbo0tFooNfiqfJK06VZSHgNEIsAs9687HeDys0aRjsxyqnU0QKzsQsow2RrPcXSQF8wTuxvYDPzcSkjOKTs5VvX5hQpVyWhX2yomyPGruUd4lGGvyjOTiHrPQVcbhmCPH9WsQ36e9aJA2HB/sYhWCsdNL4hA1yTI3Txs4iWOB7R174WdXrPFmbiDLwQZ4EIATkhevat7b54gkPGB3CtVoNm2TqoegZl5vcYgeFhyhj4pKHWL7klB4idpBW5wKPzdIwi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 00:24:03.8397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1302d964-0b7c-429e-3408-08df3c656da4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE944.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039

ionic_tx_cq_service() wakes a stopped Tx queue only once
IONIC_TSO_DESCS_NEEDED (44) descriptors are free. The threshold is
sized for a 64 KB TSO skb at a 1500 byte MSS and assumes the ring can
have that many free; a Tx ring of 32 or fewer descriptors cannot, so a
stopped queue is never woken and the netdev watchdog fires.
ionic_set_ringparam() only checks that the size is a power of 2, and
the ethtool core only checks the maximum, so such sizes are accepted.

Reject Tx ring sizes below IONIC_MIN_TXRX_DESC.

Fixes: 061b9bedbef1 ("ionic: Rework Tx start/stop flow")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 119ac720c078..3518fbf5882d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -708,6 +708,13 @@ static int ionic_set_ringparam(struct net_device *netdev,
 		return -EINVAL;
 	}
 
+	if (ring->tx_pending < IONIC_MIN_TXRX_DESC) {
+		NL_SET_ERR_MSG_FMT_MOD(extack,
+				       "Tx descriptor count must be at least %d",
+				       IONIC_MIN_TXRX_DESC);
+		return -EINVAL;
+	}
+
 	/* if nothing to do return success */
 	if (ring->tx_pending == lif->ntxq_descs &&
 	    ring->rx_pending == lif->nrxq_descs &&

-- 
2.43.0

