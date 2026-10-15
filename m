Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94763C1D73;
	Thu, 15 Oct 2026 15:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076566; cv=fail; b=is7QjjLInICZO9dJhB7mKzt1yGE6eDBUwd3jKYVylMT3nQT7hL9b/vScsAm7qPMPgaqQFQm1Lw1XZ1ddYfvYmJrbP8y4A06hTUmSNW4ormVgQts2Rz2hb2qQF1xLzZtC37KRSGoCepcBDwDF7llDDZ9cOOrIHIU3aiJ9OCzdH3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076566; c=relaxed/simple;
	bh=U03TsRb9NPU/ymVxrxxkghPQsQ/5SUZLrLfeVAAiW7M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qwiaqb/bX3H4f19QHb06VLFTuKAOnBPJPesYWNk4QaoeRzNTfNCglIKKF4edUIYzrIIeMUonKLYgieFvleRlHFtrwbxeuyzHqgaobcHFZZVvj4v+uC3ubLiXuc33fuivBz+Md2xJdslHedWQXkFVocRtog71MM1SlNJBQJiTaDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eMlpq17m; arc=fail smtp.client-ip=40.107.208.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eMlpq17m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oy9sZiNPqN3Si1wZzuWb4u7SxuKVb8CKow+99Rt0zTJAYFsGH/Yt6HpslZP45rMGjZvgrxdNS9to9ZPGyOlCLRCQ4n86sLUFN3GiNwT7hMzg3mm6VrWPFARcyVopYPYDAWGqlo2Pghew4Olj+WsoRRBoFKaAnSVVgbP7BayW7tqJs09vUoShzpXtHL7+cCTr2r7tA1XGAo5aDEedGyn7DJMJlHkIEB4n3dE8+zlxr0LIawLu83t4RNHVBB9N4QsXYm7psyUA1398M9ihHe7jjaRlFJpOmMMPxabUoYffG0WJkSffIrW3j2x0Bi75wa5FvF8C4jrxhEZZNMo+f9hHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt4lGju7D8PTj1rfAG/OcLfJQFJkK3lME2hd34qjobs=;
 b=Z5oBLtAi8AdlZubUEJwKy3QyD3qFVPySKcTvhwRm72QpiLpIjytkhwXwzfSGMH4EbHpic5gwF22pI2P+q/2HjO3wmYBedGzxRUQdQ7xF44Q6oy+akUmp1ngX3Wamycw8k3ZzsajpU8rgF5dUYOTSjPQvBJ9Opn3qUYdE1xuNhHdmn11iM6XZxuVWfSXDR5BQCEGVQRo2Zw7xvAtMMcNAsTYDnrKRfgFvoQzwcOZS5xWK4u7e0NJCAyNb8UZLIaomPtB+FF/ho3lheHw1JafEzgOnMbSPhzFYIhUNgt3GqkAnMnoUJweCv+3G/u58i3Z4LV5FzS+ZWXj/yJ9O9PHTHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt4lGju7D8PTj1rfAG/OcLfJQFJkK3lME2hd34qjobs=;
 b=eMlpq17mPXPLixgae/D47sm+sQFJlGZ9u+hY4goPv3VQoxn2XB2Bf3xkSBMYQFgnD4Do+Q4iOe1njEwF0gmI+kq2qNwy3HUbCW1JgUWZkVa3q/uCY7gfJx0KmDjRYHhSXoizD019KPaGr0UKjhb9KwbH4X2lp0MN1KOogmMYyyzqGWwEJsxJnZG6mjWONDddbTVYHAFmYUToDdP/hhHBRmd5EvXul2inApkJV/h99LnqNbtOwaFz8B46BSFrqeKhlpVkYxHTd/jWMtbUk6+ub8WSR1fDTN9zPH49tMBkd2dOgNk7LQBDUSozLdYK4JcHl6P8uQ2iKIDKgZ3aIG6BIg==
Received: from CY5P221CA0146.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:6a::19)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Thu, 15 Oct
 2026 15:02:38 +0000
Received: from CY7PEPF000000F3.namprd05.prod.outlook.com
 (2603:10b6:930:6a:cafe::5) by CY5P221CA0146.outlook.office365.com
 (2603:10b6:930:6a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 15 Oct 2026 15:02:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY7PEPF000000F3.mail.protection.outlook.com (10.167.247.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 15:02:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:02:08 -0700
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:02:06 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>
CC: <maxime.chevallier@bootlin.com>, <Raju.Lakkaraju@microchip.com>,
	<cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH net-next v1 0/5] net: lan743x: automatically recover from TX hang
Date: Thu, 15 Oct 2026 11:00:39 -0400
Message-ID: <cover.1792008404.git.cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F3:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b99ff5-8957-4db4-ff2b-08df2acd5ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|6133799003|10067099003|18002099003|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lGV9ucvTD2yMJvAMzMbmKdWI8GfIgE7b8lQaUnscgMsaozASc2rWrJUjsXlEJpV5EvykYUvPq73ayfMC5tLrJzFp77zIzxHJB8M1quBUqaowT0mk8BtduxGZJH38q3dRO3eR7c47sAr+NX6e/1OfIiSAp0c4/4y3HhkBkAwabF/J/KdH8M30JPaq9nwO9Rrnk8h86vnI+cQp8B4/bwWp8zS9gOmacnnwNl5sAstRU/zTCXF8C1GTRrXOTH7YaPXTHdlu2iWY8Ndjju940GCSQed+WkPhEME0rp1cQNntsqFiYcN9chipyQeGEOv8+31mAw4lVvwtfkGGaVj04ouncu4cZIDVvh9WoWK6smYlf+fZ1gYHpzFA4Cd9PYneLQfsDhqtg0bvewiuxUnLhLza6gpsXPIRzkHqiEj4yI9cdhuS0ZG5BW0dTvp9ByyZ0TGpAo28hYSRfabXlbts0KOFOBXgdzFG3gaXMmihtG25fQMZzxG5TrgY56OyQ85vp1JDsjajzRTbmKCWt6Ev/rGZs2rAfFCpW0kfVry6lwEOO5eBhIE5so9GI0njNZtr6MT6kIpumgczjTWl0ZJrZUgtWm3fw9ZFkMY/m5ZnXoLY6tDnVLJO0gCDRfj8Tvzyu5AHmjuodXbKfTV5homc+NR+53MmmHlexvtnxGuXbwzpfWssXmIZmZ4slipkvMNJ1seYqdll6q7G3nuMSf6aD1TQzm8O2cWtLJrqWt7xmeAJS+IWZFMmOo4KszVVBpqbmA+8
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(921020)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XXmI02bW4C7ClVONv85Q0cJVVHNoamsRd5bOfquNIpaS1hJ2TNjQbw9wbgMMTAFodct0vuYq1aSWM1xG4OE84ZHKapgaoVPowK04x6LZ9/uSwyGHJ7QkQenveVvMchYSURKEX8Si7TwOV5hVT0c2fbQDZmP2BCom9xZXzbhn7BgGr40d4ajBC20fDB5zDy9H4zvBhoxF9YbRSa+zZQGaFnHLJs4mkJQfqyojRFLO/6aeBjxHw8xhmCUqIIIhTzAeasbxcn9UKjar2/IfGUPWt8/xZ3W40WnxxRKx1oDxQ6fQ6DHPUCF3LdMYPfRPy+ybqESZafZQtHNIhx8/FjOLO36O3BBKbV8KXZYPBfXQcjZD7vQzvK1ucDwxdjPXt1fUp/4a0YX3kbxm/xOyM2p01Nd2VBKfQGRmE+9I7UggCYj3+l7Hi7n+bwIJGiaYmJC0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:02:38.7964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b99ff5-8957-4db4-ff2b-08df2acd5ac2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299

Background
----------
On a custom HW platform that uses the LAN7430 NIC we have been able to
reproduce a scenario where the SoC stops receiving TX completion
interrupts, appearing as a TX hang. After dumping and decoding the
LAN7430 registers we see that the TX channel reports that it is in
started state with no error, but TX_HEAD stops advancing. TX MSI-X stops
incrementing while RX interrupts continue to increment.

This scenario has most often been reproduced in large server cluster
environments, but it's also been seen locally during repeated SCP and
iperf testing.

The root cause of this issue is still unknown and we are continuing
debug. It was found that bringing the interface down and up recovers the
network. This issue has not been reproduced with the LAN7430 EVB
connected to a standard Linux server.

What this patch series does
---------------------------
This patch series attempts to implement automatic recovery of the
network interface after a TX hang is detected. It does not fix the
underlying root cause of the TX hang.

At a high level, the patches implement the following:
1. ndo_tx_timeout support to reset and recover the interface when the
   netdev TX watchdog triggers.
2. BQL support to decrease the amount of time it takes for the watchdog
   to trigger.
3. Stability improvements and error handling around the open/close paths
   that now get executed more frequently as part of the TX hang recovery
   flow.

Potential issues and concerns
-----------------------------
* One of the patches adds new lan743x_dmac_tx_reset and
  lan743x_dmac_rx_reset helper functions. There is no cleanup handling
  introduced if these return an error, only a new error log. This
  matches pre-existing behavior: if a reset timeout occurs then it is
  possible to DMA freed memory. The datasheet states that these resets
  are performed immediately in HW so I'm not sure if these will ever
  time out, but I'm open to suggestions on how we should handle an error
  in these cases.
* The TX timeout reset flow does a full lan743x_netdev_close followed by
  lan743x_netdev_open instead of individual TX channel reset. If the
  stall is happening inside the NIC DMA engine then the theory is that a
  full reset may be needed to recover. For internal use we also wanted
  to reduce risk by putting the NIC into a clean state after recovery
  with full reset. It would be great to have Microchip/LAN743x experts
  confirm the best reset flow.
* LLM review tools flagged several possible bugs during development
  that resulted in the inclusion of three "Fixes:" tagged patches in this
  series. They are included in this series with the ndo_tx_timeout
  support because lan743x_netdev_open and lan743x_netdev_close are now
  called more frequently as a result of TX hang recovery.

Testing
-------
Testing was performed on a 7.0 based kernel using the same driver code.
Please let me know if you would like me to run any other tests.

Tests:
* Verified the TX timeout watchdog triggers and recovers the network
  interface when TX hang is reproduced. This was done as part of
  repeated SCP loop testing and is also being tested in a server cluster
  environment. dmesg was inspected for "NETDEV WATCHDOG" to verify that
  the watchdog is being triggered. No errors were seen in dmesg after
  reset.
* Performance tests using iperf3 to measure RX and TX throughput show no
  noticeable difference with the patches applied.
* Repeated module load and unload cycles produce no errors in dmesg.
  Network appears to function as expected when module is loaded.
* Repeated ifconfig down and up cycles produce no errors in dmesg.
  Network appears to function as expected when interface is back up.

Chris Babroski (5):
  net: lan743x: reset DMA channels that fail to stop
  net: lan743x: start phylink last and stop it first
  net: lan743x: quiesce TX before freeing the rings
  net: lan743x: reset the device on TX timeout
  net: lan743x: add byte queue limits support

 drivers/net/ethernet/microchip/lan743x_main.c | 177 +++++++++++++++---
 drivers/net/ethernet/microchip/lan743x_main.h |   2 +
 2 files changed, 155 insertions(+), 24 deletions(-)

base-commit: 05b5019b01fb9443b09ae4ed34af1135a80a84c8
-- 
2.34.1

