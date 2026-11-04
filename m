Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793827206;
	b=smt+W9aVv/Ee//W53h5VoqKIob58F1cqyiN0KMi+dsJTsEZHVjBuwmRs/AuGBYDzHPZI
	 EN55gWacHhZmwRYrcYCKLLqQAvYmjPeMt9RIC7P+49oDR0GJPPGr/cfre5g2A5tykhqx8
	 if7cgrLvzeBV4FfYOb8m63nOvo/fyo4VFRgLG283Ci2cifNLwabyN/4vw+05WqD2d7gd5
	 99YLQODArtvW7UOk4w3p+XN7nm1a/BQnbGR/iX/xHI7GtumqxtW2OnPz+9P3Yxh28R0pu
	 vJcI+PdsPmVoxvmy51uynJtWZGoj7QaKqVf6xUT/m29rZfjxtTLshgtSyNuaRVuzpSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827206;
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
	bh=9Es1gM8LS9tAV+WW7bNMA2fZCPfH7pbTUuphDn7RIQU=;
	b=CHVvQTd76SUMBbrJP1ltOkZF4tXOUEJokTpFfD1JDx0SiAaOUyt1oCgWWhgMDFlFIuw2
	 KaOrMJvwwfd7mHFZRpPt+vc9Ly6yCrRnyUEHkThQf545SGWkuNOimE/j/U/focBYAkIDs
	 BpiTYcGX0n/zoVa5TJKtSNG5lvE4sHMBAc/qGepre87Q1o+z67IOV0uHOABMqeiyxG4Kn
	 +ddIeDH5XvWgvpNIryo1I1Y7msjrlXWGY5eIbHLWtJhvHU8kcXdQMZx5rO2wogH7LXZrf
	 GmuymASVL/6CQJY+Fgl8DJpdjq+gq06y1i1d25mQCqi+x/uf8+FdCgyZQQpvoVI90bw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WV4jkAt5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.15
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013015.outbound.protection.outlook.com [40.93.196.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06468606B2D6
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 21:20:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06468606B2D6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=WV4jkAt5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdAOZUD541MMYc4NKXZ2pBW/mevMW0dbg++dNTSpp2jDdAHH1vztdCHoo/rdSPotwsLYpMCcjnrLOX2i/Jn0Zfmxv7s+7VB4SCQ4Hx+GxEHPJFV4J7rX3p4MbjmNJbPEEmN2Pf+YgcaDogKlGUvV03PYPr9X42CMoYqsyxtHkB8TbmpWUySd+LHOdTkXzBsFeltILzdl/flv314h+nSJ59Py7tJfps3qkbldLXWB1B3Kmd05tZ2InC+0j867ftoWc/cqpPIvSgTinyIyJN9M/WByN3zXgr25mmBkwh6Fe7ITwmPbAW0rZ2h8gT6IPvCnzowiJ52zEBT4mlRsxQ9J0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Es1gM8LS9tAV+WW7bNMA2fZCPfH7pbTUuphDn7RIQU=;
 b=csflmvhyuP+MYMsb16xk9MrPa+VhjcAeES2tJoyqC6Alpu4IwxszSG0IZ510Zlv3VErGySB5dTagcr9sTHjDBzL2wNCRRm+lJgnobzdFjnrd9yJEkDgaElbBTg+78bjJOnJOZ8NM0x3lOdUPuyFtf6kF2AURefu691WM5P/7D6BV/zTs2H+GfQaFR87OXmeuBdR7kSkue+iVINNsywu3S7EOmMy1HiAyeUXSnau3KwSh4fbWgmV0uYs4jm75lo1y/PCwqOBs/ZGswxEWlDA69V5Bnd6ujfsVpilnkYFEIjJ5/Xl/cWFWqutZyY3T6Q+j7GJU59g1+CTcmPse0zWR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Es1gM8LS9tAV+WW7bNMA2fZCPfH7pbTUuphDn7RIQU=;
 b=WV4jkAt5H1sTl03mdZq967t4Ig51AAtTSS+ouq3W+2P2bcfq9xuFOWKFkIyAdSV+9qqpigZ4dleW1fdNfe6zPVsL6AzBzyQw4n/yvj0Hzelqhmagv0Cwtl3+aml7131TFRpUEIVn6iYJanS439HjtvpcYd8H2xVvQ4Fn4o+3AQA=
Received: from CH0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:610:b0::35)
 by CY8PR12MB7683.namprd12.prod.outlook.com (2603:10b6:930:86::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 21:20:01 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::70) by CH0PR03CA0030.outlook.office365.com
 (2603:10b6:610:b0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 21:20:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 21:20:00 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 15:19:59 -0600
From: Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net-next v3 0/5] ionic: FEC reporting fixes and
 .get_fec_stats handler
Date: Wed, 4 Nov 2026 13:19:41 -0800
Message-ID: <20261104-ionic-get-fec-stats-v3-0-b261fd53d0a7@amd.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOQQ6DIBBFr2JmXQwMVqSr3qPpwuCoNBEbIERjv
 HsJG1dd/rz5b/4BgbylAI/qAE/JBru6HOStAjP3biJmh5wBOba8Ew3L3Bo2UWQjGRZiHwPTmiv
 Z6rbRvIPc/Hoa7VasL3D51NEW4Z3JbENc/V7eJVF4MSspUDQcRS3uqDQTLM8y9WfdHflnvwy1W
 ZdiSHi1/u1JmAVCjpzUgKQ4XobzPH+ExuiP9AAAAA==
X-Change-ID: 20260814-ionic-get-fec-stats-990736964908
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|CY8PR12MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 576c41ab-a52d-4ffb-79a5-08df3ab962ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|6133799003|18002099003|56012099006|261102123227099003|13003099007|261009223027099003|261021135927099003|261021121427099003|261022105027099003|261021123027099003|11063799006|261026140227099003|10067099003|261028144727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	/aaKE0RmteqR+x2ikAjhu7JM+A2OePh4v3ijCdyvYeq0hbM8znAWe87BZVnPBo4TD2gctUSPkJ+cTv2Gok0+sKdaSQRdp09990iBKCgQPWqPIwnEAkn7JdAxjGOW4W36R1IwbJZcedg9nDR4mjT90Idogu7X+8wdgG3swbdbIHrWn6J4urcJHpp3/BlzyhnJogpqDU1yofW5RSj9Vo8io5mhyc43+qg2+nJ29I1QahLR0Ltb3CizC3daJlmyfs7JLmpFVBcqDSovI3Bao8BjnXH8EV8Rw0OXdP9lO/BOrckC+wniU08I8NT3ZwZWGgIpqqKSKCrtjUEyzf0912xhvBxGj5cOMFf/4ECFn18JseTHYBn3Pngj1M83RjILWLp4E78DF8w54/vlOSHiY3hfCsXhwBNXs9mSjtdzaYvpPi3g5NTrMnN6Ky4bNh5Hn+hNowzLVpZRqtZoYgW0J2j89kC9UlofmIduMkJxqZeDle79yISXMgz7S1bf++D/tvy2umDEQpkUgSLAr/RmzTc/m5AdhXoL1k68JOLe/sbaFeGdJeDFLo/OQ/+SRY1Bd8XnWTIfYfAIkq7Aqmh/5uFhLPG54IgrFjnt6DlZGhVgj8qcK08qOir778R5CZM0mEZIIgV5zUQYa3SdjC3kTqrOnWqRqkY9VdJoYD4FVkX+3pw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(6133799003)(18002099003)(56012099006)(261102123227099003)(13003099007)(261009223027099003)(261021135927099003)(261021121427099003)(261022105027099003)(261021123027099003)(11063799006)(261026140227099003)(10067099003)(261028144727099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xIO9HIfMgeGgtJ34mjeVbQP+Nd31sP6P5VLFWo3YGG/YVchxYKGVkV/SrGEjD0pDBaEAtlBLwRAxZNBqEhS0Yge/YZ79PfeC+FhjqUR/Z2WwurTfI/NmxdU6AuNp8XEdBn1oaLZPrO86ZD3JYppaaBXOGcTNDye+yHbrM4wnlwOcq6YuQwjZjvW/z8SKjrZ4W2pLGiMBur2mg8bLGTY2U0iwN49JGPLBIglNwDw7z9UQ9Z1Srv0ekZHqsWg2fBRIAhj09gtUOkxg8WvVJID8W0ZSf74veJJszZI7q8TrEG6oebRKj7oFio/84/bqeELo5f8XHAj4EzIfnK61WLgwAat450WdwyyvWsxc3N9/vlKOWc/CFKYGCfT2aNqHwby9gpvEPbg+ZY+0mFl+ltu2GjEvv7VhOolh/u4HsEy/AcIkAPDWwAWkpoXJcsJ0R3aE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:20:00.8581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 576c41ab-a52d-4ffb-79a5-08df3ab962ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7683

Add a .get_fec_stats ethtool handler, and fix the FEC reporting it
depends on.

Patch 1 writes the IONIC_STAT_INVALID markers in extra_stats one
counter at a time, so a reader that tests a single counter cannot see a
torn value.

Patches 2-4 fix ionic_get_fecparam(). fec->fec reported the constant
set of supported modes instead of the configured mode, and
fec->active_fec reported the requested mode instead of the operational
one. Patch 2 has a Fixes: tag, but patches 3 and 4 rework the lines it
changes, so it is sent to net-next with them rather than to net. The
bug only affects what ethtool reports.

Patch 5 adds the handler. It reports statistics only while the
operational FEC mode is RS.

The netdev AI review of v2, which Simon forwarded, asked whether the
per-bin local really guarantees a single read of each counter. It does
not, so v3 reads every counter with READ_ONCE() and drops the struct
copy. The port_info lifetime problem that the AI review raised on v1
and v2 is fixed in net-next by commit d90d1a768b3b ("ionic: fix
port_info use-after-free on firmware recovery").

Claude was used while developing this series: to investigate the v2
review questions, and to help write the code changes and commit
messages. The authors reviewed every change. The series was tested on
Pollara and Vulcano NICs.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
Changes in v3:
- Read each counter with READ_ONCE() and drop the struct copy of
  extra_stats (netdev AI review of v2).
- Report statistics based on status.fec_type, the operational FEC mode,
  instead of config.fec_type, matching the active FEC mode that patch 4
  reports.
- Add patches 1-4, which fix the FEC reporting the handler depends on.
  Patches 1-4 are by Nikhil, who is also a Co-developed-by on patch 5.
- Drop Vadim's Reviewed-by from v1, since the code has changed.
- Rebase onto current net-next.
- Link to v2: https://lore.kernel.org/r/20260814-ionic-get-fec-stats-v2-1-13f0e7d2e702@amd.com

Changes in v2:
- Latch each histogram bin into a local before testing it against
  IONIC_STAT_INVALID, so the sentinel check and the store cannot be
  folded into two separate reads of the firmware-updated DMA buffer.
- Explain in the commit message why the RS FEC check gates every
  reported counter rather than just the histogram: they all come from
  the RS decoder, including fec_corrected_bits_total despite its name.
- Rebased onto current net-next.
- Link to v1: https://lore.kernel.org/r/20260731214021.15279-1-eric.joyner@amd.com

---
Eric Joyner (1):
      ionic: Add .get_fec_stats ethtool handler

Nikhil P. Rao (4):
      ionic: write the extra_stats invalid markers one counter at a time
      ionic: report the configured FEC mode in ethtool_fecparam.fec
      ionic: map the FEC type through a helper in ionic_get_fecparam()
      ionic: report the operational FEC mode from ethtool --show-fec

 .../net/ethernet/pensando/ionic/ionic_ethtool.c    | 116 ++++++++++++++++++---
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |   8 +-
 drivers/net/ethernet/pensando/ionic/ionic_stats.h  |   2 +
 3 files changed, 112 insertions(+), 14 deletions(-)
---
base-commit: 7b6ab4dbc156e2f96419715130b3d5738a306c93
change-id: 20260814-ionic-get-fec-stats-990736964908

Best regards,
-- 
Eric Joyner <eric.joyner@amd.com>

