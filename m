Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793827218;
	b=tUBJK4W1xNivLUfgt0KP0Rv39k71dhnurDLZr47vkNN2z2as1/s4sDuOHLRQTl4Dfbuf
	 V8iyLWqyrHWYpOc6UxOIKDIQ+Tp0hlFEeuu9Ys3HPeRHMPLUzG0Xe0ECFPmPYAYuMKfkd
	 vkrOfHMYKGESVQqmsE2R9G8PvEJisV1Jm1SFfg0nb5/fOkJw+ZUyBAyqmFj8HXjOM6EhH
	 NToXEe6zrVOYY/mRRmp6NVSIbXaq62eyFfZU6YEELv0K+iybJMrXuAwmedSHkGpKgyqYv
	 8EZmvurMLEk2lUvR/q+pr4wqo3InI8Zj8yzpYT4Rhzc7Zj55EU6AG5nDn23mxKhb7Hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827218;
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
	bh=cO66KZAIR1jvIQFe6aM43kmxmbyBq4i3B0BwVfxyCPs=;
	b=JdAfqr4sAQ6v83KO5e1vPErQXvbK/S7eDaf6Qj4igXs2derXVo0CytGG6+Juwd0lZciO
	 d2w6Gm3THqG4Q/XPnK0Of9yiINhQPv8Ja0nRkoVBjec+DRSSI2RGy30e8WJX449khI3BE
	 hat+ZjbMo3/1UHOdf2slUL3ql54jGbqYPzrO0s/Mre/30ZDG9gsrWHUvoEOI8asPDYc2E
	 eWlW5Zg2ZtwIhEh9dLHLp058fEtz7E34MSS5VRPJaTiLRBXpPIBDPXY+cccKHUchcNb2G
	 auDxMcjQyB+aiY/+/JAHOEJeWVaaYicQD6iUE2ZkUECe+fHYTQ3BtTad91MUgBORT6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0zy0vFqN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.3
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404C6075DC1
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4404C6075DC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0zy0vFqN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZA32u/BL5OUXRcO3NxU8uwX627fOoMYTwPOCz80bCLVa8ZbquUe2t98cSve2u5Bp7w4hjACHldwpA1nhEZtWk7A4D3GcmDUxQJu4bngHrSZn+xpn3aOkr3SpwgyMa6rbdXAM+ZMxjBk3pMedRjpL1IUqHJ1Yvv6sGacxMHfU8yNbcwXl/yxAgIn2K2Wp1go9VQcRz1sJPUc3o57AlnZFjsguGH9njqqeqLxgprW41pNW8b7XAEXCs0BR4NUKYkeL21LCtaAFZy6WVvG0Cz9SyHC8nUfdFK0yowXy5qOzLVvbU45PZkR3d2j/1HowEv9w802dVGWBdS3cliK3UXA0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO66KZAIR1jvIQFe6aM43kmxmbyBq4i3B0BwVfxyCPs=;
 b=wcwoY8pL4QllZ9Rcfao+ccfMspM0jFwAHet9M+hnMvhm0/qrEYk6+VQxGCbqCRERwqo+99s4rBnDtavcOkxco7lfv9jkiHUTYz+tWGiGmmGr5qFEjjnAaJnFoobWQjlIyWKR7PAoXIuIhHfPKDw+wbB2/FdGp0zWEao/Qi2IBmJ+6MT2WxkN4SIH/zsQ4kRwfTxtfUTOw4DEYK5eSY3UmfFgKrbWI24FzVAsBeuFZeHz4auxy6B4LTokKEjW/SQ4vrFobFqUTFBGzrcZ2cEhDGKbhIgsydvLEWjtkxBd6Fie05XJVm5j4STN5IXpaw9a+YRl3GS2V8n9Edz97/JHkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO66KZAIR1jvIQFe6aM43kmxmbyBq4i3B0BwVfxyCPs=;
 b=0zy0vFqNC3tKufYR095YZ6+KglUDbFVUV4OFHbwiRdVmVtd5R+IdKT4LNogoGZ+1XppcmgszV0NWw14tr2l/ku7cuczEkdPBltnZOZ01dx6VkkhO3Ef7MEs3rWNLRiMHQCVjiSj3fKbLonYyWGMT41H2h1FWckYA+OI5zxLMSkU=
Received: from CH2PR10CA0018.namprd10.prod.outlook.com (2603:10b6:610:4c::28)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 21:20:07 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::7a) by CH2PR10CA0018.outlook.office365.com
 (2603:10b6:610:4c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 21:20:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 21:20:05 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 15:20:04 -0600
From: Eric Joyner <eric.joyner@amd.com>
Date: Wed, 4 Nov 2026 13:19:46 -0800
Subject: [PATCH net-next v3 5/5] ionic: Add .get_fec_stats ethtool handler
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
Message-ID: <20261104-ionic-get-fec-stats-v3-5-b261fd53d0a7@amd.com>
References: <20261104-ionic-get-fec-stats-v3-0-b261fd53d0a7@amd.com>
In-Reply-To: <20261104-ionic-get-fec-stats-v3-0-b261fd53d0a7@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, "Nikhil P.
 Rao" <nikhil.rao@amd.com>, Eric Joyner <eric.joyner@amd.com>, Eric Dumazet
	<edumazet@kernel.org>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da9be0c-380d-4802-8d68-08df3ab965a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|6133799003|22082099003|18002099003|10067099003|56012099006|261102123227099003|3023799007|261009223027099003|261021121427099003|261021135927099003|261022075727099003|11063799006|5023799004|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	RIN1Hp6EN+1ePQcZEPwI3QTsHpAsj6lTjyGYx6c0DGFe9CZVRVTN9Lbyj3ALzYN32fvm1lXXi4Qoxmvnuq7pBSDQmp7ca2re+O7IxiBTFbGMeb/Q9m8rsIFqhF0UxEX9NaNSyCTgLori15ujCo+H8JQmzR2sWufmPG/6QChyZM4pFVuPYiJz9n4EPQyDOYF9iDlNTwdconOw/pxyE/W5LIwH7TpZTcBx9dLy16rVMbAk3ZXBO7m4n6FdzkfKF6Rcwe8CxXuR8czvH6yrqD4rHsmlxKrwa2vWKkzm84oWeDmyJtBLPI3XbbUlLPN37oqTNXS/k5DLG40N8KFLYUoWYroeJhBiS5uazMGIKkW8HE6bXz3zKV2cn4zn/4KgTLzBEsM0BCxhBAaGZ0UisI2TNVXyPPZ3Rbll4hzCE+5/Qw/hPGRNhyesTm7UyCDUHfV1E+vJ2dPkIC2SN35Xgj8tDYVsiClgUbSugViLar8Vxf/CZuib1VTSAHoxRGTgPNQfXX96L3/GTrVfkMiUSZ9sQ55h6U2MNHpLRqYQwaukdqc39yS3jtDm7wGR861taHHDLMk5ifI68XK1SeRXWO97ppJee4iP5s0r1bIeeLN6zOw9cY3Zv8FMwtwwACGfPIcBuWn/rI+W60A0JL5u1iFxQzJl2hVRKfZV2+YjQjYXeinvOy6tS/tmO2RTP6A9LVqySLfpKr1W7PFFTAjW6k8hoQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(261102123227099003)(3023799007)(261009223027099003)(261021121427099003)(261021135927099003)(261022075727099003)(11063799006)(5023799004)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vmW9QCGOti8EoSE3ko+15eT30Baa0O5AAyQnMyV7Jtuue+hqskykILL8q8JoIT1psfbNqsn//Ulgu5D1mHuFPtMIfI8IUlCam7i1J1nUCS9t0aAvkGeRnK0mdOwac+y9D9arjz5WGwq9x7ymNKZpJOzvy2bM1afIkJXeD52QsZMGacg8RIbnP4AN5BYo599cTytEmgECRkWOZpq84BAbi4GdE/Phf/sF6AO22CwtrpqJ2WHbb7Iedk1zWf+Ut3NxWx0hRq7yXlCoTthNHXqVU+2A7xM4Ox4gw770FJujoNlRXAfKKdAW7BFpBQpwCmZvHOwRBGKi1S1YEBkVDdNthSsWSxFhU5Ai8h1LOAsbO8QNE999YOvq68hb6XGtqF2/ISBMc8Ui+TxyFN20ohpVXECLZnFgwMLQhQfoHe7mf+hu56QDaoI8KplDSZV/8Wkt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:20:05.7734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da9be0c-380d-4802-8d68-08df3ab965a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209

Reports FEC statistics totals and an 802.3ck FEC histogram. Per-lane
counts currently aren't supported. Every counter reported here comes
from the RS decoder, including fec_corrected_bits_total despite its
name, and the only histogram format firmware produces is the 16-bin one
from RS(544,514), so nothing is reported unless RS is the active FEC
mode.

These are physical port counters, so virtual functions are skipped the
same way ionic_get_link_ext_stats() skips them, rather than reporting the
port's counters as if they belonged to the VF.

The reporting of these statistics is gated by DEV_CAP_EXTRA_STATS and
checks for IONIC_STAT_INVALID, since only the newest devices support
reporting all of these stats. Older devices can only report some of the
statistics or not at all, and so the output will properly exclude those
unsupported statistics.

The firmware writes these counters by DMA while they are being read.
Use READ_ONCE() to ensure that the IONIC_STAT_INVALID test and the store
see the same value. Counters are still read one at a time, so the set
reported can span more than one firmware update.

Co-developed-by: Nikhil P. Rao <nikhil.rao@amd.com>
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_ethtool.c    | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 2e067481bb15..1d32fa811003 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -450,6 +450,88 @@ static int ionic_get_fecparam(struct net_device *netdev,
 	return 0;
 }
 
+#define IONIC_FEC_STAT(dst, src)			\
+	do {						\
+		__le64 __val = READ_ONCE(src);		\
+							\
+		if (__val != IONIC_STAT_INVALID)	\
+			(dst) = le64_to_cpu(__val);	\
+	} while (0)
+
+static const struct ethtool_fec_hist_range ionic_fec_hist_ranges[] = {
+	{ 0, 0},
+	{ 1, 1},
+	{ 2, 2},
+	{ 3, 3},
+	{ 4, 4},
+	{ 5, 5},
+	{ 6, 6},
+	{ 7, 7},
+	{ 8, 8},
+	{ 9, 9},
+	{ 10, 10},
+	{ 11, 11},
+	{ 12, 12},
+	{ 13, 13},
+	{ 14, 14},
+	{ 15, 15},
+	{ 0, 0},
+};
+
+static void
+ionic_fill_fec_hist(const struct ionic_port_extra_stats *port_extra_stats,
+		    struct ethtool_fec_hist *hist)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(port_extra_stats->fec_codeword_error_bin); i++) {
+		__le64 val = READ_ONCE(port_extra_stats->fec_codeword_error_bin[i]);
+
+		if (val == IONIC_STAT_INVALID)
+			return;
+
+		hist->values[i].sum = le64_to_cpu(val);
+	}
+
+	hist->ranges = ionic_fec_hist_ranges;
+}
+
+static void ionic_get_fec_stats(struct net_device *netdev,
+				struct ethtool_fec_stats *fec_stats,
+				struct ethtool_fec_hist *hist)
+{
+	struct ionic_lif *lif = netdev_priv(netdev);
+	struct ionic_port_info *port_info;
+
+	if (lif->ionic->pdev->is_virtfn)
+		return;
+
+	if (test_bit(IONIC_LIF_F_FW_RESET, lif->state))
+		return;
+
+	if (!(lif->ionic->ident.dev.capabilities &
+	      cpu_to_le64(IONIC_DEV_CAP_EXTRA_STATS)))
+		return;
+
+	port_info = lif->ionic->idev.port_info;
+	if (!port_info) {
+		netdev_err_once(netdev, "port_info not initialized\n");
+		return;
+	}
+
+	if (READ_ONCE(port_info->status.fec_type) != IONIC_PORT_FEC_TYPE_RS)
+		return;
+
+	IONIC_FEC_STAT(fec_stats->corrected_blocks.total,
+		       port_info->extra_stats.rsfec_correctable_blocks);
+	IONIC_FEC_STAT(fec_stats->uncorrectable_blocks.total,
+		       port_info->extra_stats.rsfec_uncorrectable_blocks);
+	IONIC_FEC_STAT(fec_stats->corrected_bits.total,
+		       port_info->extra_stats.fec_corrected_bits_total);
+
+	ionic_fill_fec_hist(&port_info->extra_stats, hist);
+}
+
 static int ionic_set_fecparam(struct net_device *netdev,
 			      struct ethtool_fecparam *fec)
 {
@@ -1184,6 +1266,7 @@ static const struct ethtool_ops ionic_ethtool_ops = {
 	.get_module_eeprom_by_page	= ionic_get_module_eeprom_by_page,
 	.get_pauseparam		= ionic_get_pauseparam,
 	.set_pauseparam		= ionic_set_pauseparam,
+	.get_fec_stats		= ionic_get_fec_stats,
 	.get_fecparam		= ionic_get_fecparam,
 	.set_fecparam		= ionic_set_fecparam,
 	.get_ts_info		= ionic_get_ts_info,

-- 
2.53.0

