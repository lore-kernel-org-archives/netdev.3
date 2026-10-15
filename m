Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2476529B216
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792105433; cv=fail; b=Or2tpDbT8zULeiQEt3AfWN/11LMXxrEo4rijWswCXEFxX3jXFXtHJSb9YKQKvOhxcqUadpHL8r8jH51lXDqykpS16/wssuScJfwjbOmyTt0/IMvO9Z504IwoQTOYoWYAjiKqlyVDtmEx/2SH5KIHTtqGyRHEyZFV81apHnqotXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792105433; c=relaxed/simple;
	bh=FjwGEJUMQE4d/po8kFrs+tMKMvNPN7mQ40UTnwTcQDs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=oACW6csdMoYxK4e64nIyNYqb47heSIYL2GOTW1pf0ZXs6gIW929NNeQBCTu3V2ZbonbKhJv98pPGo6fsWqmE2kf6dcleGl30hqzuIVtZzyZWmL09I5CbYJQddal6dDLrgaW/1YGtXi1lBJC9lr/L/hnL7LLXepS9OSRsIH+HXOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=alJ4vziA; arc=fail smtp.client-ip=40.107.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="alJ4vziA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+HidaYXyAeyjG1kSE9xYOe7/1NnkD8yyLr2Rl8cdUm0z70MnNlFBdBijTv2MxKS1pYDB1n50d1BjUdiiDGacd7wKGxBEy1nyBxbPVIbzFgkp+AHrFFL209ZaA6j2sRHB4NAisUNS3DQvB3VJDDKxVAVSh7JHuIQO39hn6qMR8zgSz0U/+ysHaesjZy+otMJoItjVCj6nAwShugIEN2wJ5zMcPIJ0DcOC6BED4q1w539d3DYhGLDGnJaJZ40+NJdRniwozfwHcO0Y7a5gAfphFhdEh+jEwlbWApfcRHbhR9ywlDw2tAJr4Wmgu2KnPv7Fnc8qizj9NxfIJZMOQ/vLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z54Tu3MVLDM9lnrlnTPb1KBe6E0o4hxXhB64krYwuY0=;
 b=btFgSnJXX8ROnjJ+Er6zFI1ciYglspI4CRBCU3/IYeYMmlIcPhpsY7WxlzXaYC8vb+shvf6NqxlPS54yzwKzakB6Cr9ZK7jXYs/64N2xvLXGdMegcUsw3f0tiD71QSN2rWyT86XRNL+32wbV5N3l5BeJaxHQT4qXo6s8n4vThY3tbiwm1edQ2xBcr6V9mp8y1vZeB+e0aQhKe92kKWN/YdIb7LxRvcXvffVY5RAJ+Rv6lLLWCXg4z7jY5yOYZwpMOxHAjE9roxPZS3/TjJyC/GBcug4vThWpNtedXvNuf5amQnQbK/xdWfBkJIkgBuZjlpypPmdD+pXpbLgAGiV9SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z54Tu3MVLDM9lnrlnTPb1KBe6E0o4hxXhB64krYwuY0=;
 b=alJ4vziAV10pH2iTzOgZYcewMF4y7JCq7rxrojdjRVbVUgmnq3C19G2Q44YO32rlYUGys1y1OJd+1YLdAPLBB43+X7jWwlfwRl03x4R+lPCeMSLh5Nwov4ZgN/tSASmF5a9HCfrV9/awBMimAqQoQ4VZHMCYseLrbRhFy8wH9xs=
Received: from BN0PR04CA0105.namprd04.prod.outlook.com (2603:10b6:408:ec::20)
 by IA4PR12MB461082.namprd12.prod.outlook.com (2603:10b6:207:10f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 23:03:48 +0000
Received: from BN2PEPF0000A992.namprd04.prod.outlook.com
 (2603:10b6:408:ec:cafe::25) by BN0PR04CA0105.outlook.office365.com
 (2603:10b6:408:ec::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Thu, 15
 Oct 2026 23:03:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A992.mail.protection.outlook.com (10.167.248.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 23:03:48 +0000
Received: from SCSEJOYNER01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 15 Oct
 2026 18:03:40 -0500
From: Eric Joyner <eric.joyner@amd.com>
Subject: [PATCH net v2 0/2] ionic: fix port_info lifetime bugs
Date: Thu, 15 Oct 2026 16:03:29 -0700
Message-ID: <20261015-ionic-port-info-lifetime-v2-0-57232013fd79@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNTQ6DIBCFr2Jm3WkAW/xZ9R6NC8WhTlLBADFtD
 Hcv8QJdvvflfe+ASIEpQl8dEGjnyN6VoC4VmGV0L0KeSwYllBatvGHhbHDzISE76/HNlhKvhLX
 UddN0ZlJdC2W+BbL8OdVPcJRgKOXCMfnwPe92eaL/5l2iQNvUkxyFNnerH+M6X41fYcg5/wCyU
 TO/wwAAAA==
X-Change-ID: 20260814-ionic-port-info-lifetime-3163779cb298
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Eric Joyner <eric.joyner@amd.com>, Eric Dumazet
	<edumazet@kernel.org>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A992:EE_|IA4PR12MB461082:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf7219c-7bb0-486a-c809-08df2b109287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|11063799006|261009223027099003|18002099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	5hce/brOTFrc1fROECD9O0JBeeORtoQrFGvei7EHriiauKqVWl33OwpTN9Ii1e2ehQ6Mr7VYDR6UQsl3MRKgzD8BzOf0VxsvBe7WeGG4qYGbl2Sho3oprkkFCjffbKSqkpVxE/qxaLgKKiOD3JQAmEJsXR1k+obPqgsBQrpGDgfIPBOv8V2Abp8aH68fEh3cP/XPx79OCLl2/zg+Xmd9B7vjjTHJtihm67wr/TmBaSbRloksoUnf4VUGLcpljdOrf+LMullWGBWhP3zHgLAVanLPyFiCbhl7JqgEEDgh6ymkLZPVZSxI2lJAK84L1Xp0/TPzVFEjxw8MkGTyCaMj25saet8WD5EmJMK1I2qwzTlAWAI1vp04dnp5H8luRRnlscO4khMHbulQeLPCvA6r8oXQ5orN1hmhJH9VCq6jaBO32qA/LwDre2bfMbSx3G4Uv/vwbWJTZgaASFZAFxS1Tn7+IYOsozuozi4eRVraleTP9fXz70Nb//teoaEM52ITEayd2aC48f6YCAyX/zIzO1O9SK4e1zUAXQeVAnBTB81ll/egpWvZLnGcSM+szjv2MUscfIAANWk7aA8HJfRriHrem4MI6rtAy6MVJLE4WPFLlo+z/Jzz5y5bfS1NuXU5gk3nm4/OSUcn/65SdWzrP2q5Rt+GXDduDBFn+Wcy6No=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o7NQl0N3an1e4eZpfgUvyMYCv9ZgbCCynl1TAt1FvJbclc/3B2VKnt7W5yxuOE7HNaDZEu8o3njXplpOmxbCyWp9kancDyqj2AiTg4zf4XE6lVoXwRdZ+Q8NpuxZd0rOLF0dR8QjY/22DwdPYsLU+Bws9MDe8gx6wYnXm0lB8wEChrjmn3+JmCVgm4ii7Z21JPWxyHm5jM8gzhVTlAhk0wm5wFjSI7joIW/dQV8zSoL1xV5SQpICzGRIgTi77L/CenfktX27tLozKXsPASR0LR6Wv8W/C5PgjUlFXY53X5zrkKXfg4+pGyWBHOA79aeKTuRb4M840neU/xHHhvZPaBg2qdYOcCnkJcA+YPFDfPZ+rcWGvtpW6oEnq4PP9Jy2RKinZk6fslkcRUugm2QWuy2XbKB7FZZGxvSqQFKjZnwUhBOrLJ40qH0+hfjiew7E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 23:03:48.7321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf7219c-7bb0-486a-c809-08df2b109287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A992.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB461082

Two fixes for the lifetime of the ionic port_info DMA buffer.

Patch 1 fixes a use-after-free. ionic_port_init() allocates port_info
only when the pointer is NULL, but its error path frees the buffer
unconditionally. On the firmware recovery paths,
ionic_lif_handle_fw_up() and ionic_reset_done(), the buffer belongs to
an earlier successful init, so a failed PORT_INIT frees it under any
ethtool op that is already reading it. The error path now frees only
what the same call allocated.

Patch 2 (v1 patch 3) fixes a leak of the same buffer when probe fails
after the port has been set up.

Signed-off-by: Eric Joyner <eric.joyner@amd.com>
---
Changes in v2:
- Nikhil's work replaces v1 patches 1 and 2 with a fix for the root
  cause. With the ionic_port_init() error path no longer freeing a
  buffer it did not allocate, port_info is never freed or set to NULL
  while the netdev is registered, which also covers
  ionic_sw_stats_get_values() and ionic_reset_link_down_count(). As the
  Sashiko review pointed out, the v1 NULL checks could not stop a reader
  that had already loaded the pointer, and ionic_reset_prepare() already
  detaches the netdev via ionic_stop_queues_reconfig() before any
  port_info or BAR teardown, so the extra detach did not close the window.
- If PORT_INIT fails during recovery, the old buffer is now kept. The
  netdev stays detached with IONIC_LIF_F_FW_RESET set until a later
  PORT_INIT succeeds, so its stale contents are not reported.
- On freeing without PORT_RESET after a timed-out PORT_INIT: that free
  now runs only when the same call allocated the buffer, i.e. at
  probe. LIF_INIT is never sent after a failed PORT_INIT on any path,
  and Nikhil checked that the firmware only writes port_info once the
  LIF is initialized.
- Patch 2: correct the Fixes tag to 0de38d9f1dba, which removed the
  ionic_port_reset() call from the probe unwind, and reword the
  changelog to match. No code change.
- Not addressed here: an ethtool op can still run while the PCI reset
  path unmaps the BARs in ionic_clear_pci() and tears down device state
  in ionic_dev_teardown(). The ignored PORT_STATE result in
  ionic_port_init() is also unchanged.
- Rebase onto current net.
- Link to v1: https://lore.kernel.org/r/20260814-ionic-port-info-lifetime-v1-0-f73b1a06c5f6@amd.com

---
Eric Joyner (1):
      ionic: free port_info when probe fails after the port is set up

Nikhil P. Rao (1):
      ionic: fix port_info use-after-free on firmware recovery

 drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c |  1 +
 drivers/net/ethernet/pensando/ionic/ionic_main.c    | 13 +++++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)
---
base-commit: 045958acaa75205b31578cb22c4345e28dd2e4bf
change-id: 20260814-ionic-port-info-lifetime-3163779cb298

Best regards,
-- 
Eric Joyner <eric.joyner@amd.com>

