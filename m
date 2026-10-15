Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6D4A64F2;
	Thu, 15 Oct 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792076581; cv=fail; b=Fh7nLYyj6OpYxXh+kmA7dd3oJO9B5l0+00A4eMyJjF2pPkexff9f0HmfTDlIzSD0jtXUiYIrtY62Tq4ZSU68U5Hq4qgz8KkWsGvkfeemEPn9OnrdMum5w9vJSd4gkrNOQVgQVfK6WXuSofGlDH2bMwRU81PjvoE3NG9Gakw6u8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792076581; c=relaxed/simple;
	bh=b8gAOoSP32vMJgLXjpdt6Rc3nzpCj+3/NNo7CV5WKPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jr0ipYfQUH3Si8v1gcmmzrlcbHEkhYPJ95uL1SOUB5jhacm9GOolQ1+zTeZbTf3oHvKV9IzBP043ngBedaEpWuyQI3Qnk7I4s/AoFapsHyafcRdC7IAk7LfRt3BCl8rqsw/xMRvKJPYlVGyabS7L/gZbgTjA2/pKbP+Ke94eKjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=edVR2yx8; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="edVR2yx8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UD03W7IYCQs8Qzb/NQ0Yd/kAchfzoqpCsuJhZHX/wTUG4jodhknhc4ssS8kkV0qEL7JCSpFzR/MwKYyBb3fZzPzC16y2+7Ao00em/LVD+kPsIV6wflFDhRk49UGiOw6Yx8/Z7lS68QfZbL2w9YJPHMfOXPOJHtqwZjpKgUxATHIBXFpMwHVmn9kpugFnzCMRE4DGXFi3KgkO/rHzP2VZZk+YOajQ0DrlVJOZtYSgjNOxeNSIFBcCICY+MF+R6s8GJ9GsbTUut+2dPjTrcR4u016WrPPz/qgkdRfwo0LM34fpcU164LqFrgUdIgMma0zJgp57UUldQpuFgQiSuj3bNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b45AUc75THHXuVtvqbPcXAO7PTSa7LSUE7A6Gek2nSA=;
 b=tIS2DyWr32U0WJ1eg01cT4hmAoNDtScimxpvx9Va70+y05zqwsE6TfoU8dkumNnpkAqW640kkoH5N6BRxlp9i8Og3w9sbBmxpR32TZdn2TLhjtXYYcUrYXCroi/r3O+IqwOyuKm50VvN8xzct7ysbpJoLETkFFMx+pRJgPQJumbpluFXxKhvNzka2R4xPXyIzhxpyOLj2sRkw4amsqeofpoqfBi4XEjMroursci9xYZwvi/WYxb771irEa9kVlVqIJiTpvfjdkTpT2pwcjyFYkRt8Uftwfe/ru0Vjl/6G8aRCh+4w2XzFLcpIRAlFdXzdUvlR1ubrJgGWKEELcbZGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=microchip.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b45AUc75THHXuVtvqbPcXAO7PTSa7LSUE7A6Gek2nSA=;
 b=edVR2yx8/gvaCx9gIZze6D4MPvJjvkmis9vbBSN4g9/gYK0AgjngnAJp8jVJeG+BZzSCoX9Mbn0LmKeNpkY5qGVpMN+INLa4IAm8XpY2J/1AdxpLe5FKexssANvzyiz4ToaWfuQg/DB910LJqJU8vezpjIuCen9FC2d6Iz4QrLikqqoiVOUvYIOyTNwOuNzCq9Xe+1fqA4O1h73tt0wMPvbIsrAYtpHT77ezpTuendEAtvoFV7Y3lYdVLBZZBa2GCC6konEmt2F6tqcFQyCuyyZn5Bp+jmMglj8nFqFy6YvywYhwOAqK577idl7rTjSmBPrNUudmN0smtGH5aCno1Q==
Received: from CY8PR12CA0064.namprd12.prod.outlook.com (2603:10b6:930:4c::10)
 by DSVPR12MB999193.namprd12.prod.outlook.com (2603:10b6:8:496::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 15:02:55 +0000
Received: from CY7PEPF000000F0.namprd05.prod.outlook.com
 (2603:10b6:930:4c:cafe::17) by CY8PR12CA0064.outlook.office365.com
 (2603:10b6:930:4c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu,
 15 Oct 2026 15:02:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY7PEPF000000F0.mail.protection.outlook.com (10.167.247.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 15 Oct 2026 15:02:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:02:21 -0700
Received: from vdi.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 15 Oct
 2026 08:02:19 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<linux@armlinux.org.uk>
CC: <maxime.chevallier@bootlin.com>, <Raju.Lakkaraju@microchip.com>,
	<cbabroski@nvidia.com>, <davthompson@nvidia.com>
Subject: [PATCH net-next v1 5/5] net: lan743x: add byte queue limits support
Date: Thu, 15 Oct 2026 11:00:44 -0400
Message-ID: <1e42bb2a36f305d8b3ba805e85d18c3dcda14887.1792008404.git.cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792008404.git.cbabroski@nvidia.com>
References: <cover.1792008404.git.cbabroski@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F0:EE_|DSVPR12MB999193:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7e1bc8-9307-4f2f-580c-08df2acd64a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|82310400026|36860700016|376014|56012099006|921020|11063799006|261009223027099003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Q9GEpRtVSTxl1bU4SQoTCTfafFPR6ElhcCvcsTNrgkGaKVbyWnLuZd5nmFU/aKiiPfJ1aDbjwOn0M/UFv5qEF/Qm3KyQbovQjCZubc+kraEtWKE/cx69LGFlS5yJtF3zGRqALGD9h2AdUmDQUpF0hPTls3XkE3hsVwb7YWTex6I+oOUS/eE4uInMwuX9WZWbFmJScoTUdVOVum/bbChziejDOc50/0DmEqe6tciVDOeIGtEKzXA3ueR8Yx2GXKAh0WyfcLib8jOwa22qMY3D/8Bl3+TmmAdXY02/7IJ0UNPcvy/cMawrQU1NQ1XlJSPHyIFkXAEEeJSduglS0x6uG4L0t4OIDyt2zizVpdarDHve6Hdh0cXvicU91Q1ZtdRGhXJ+IftcjCOh903ogGP6qYsXOe1aXuaKtge8huKPKUg72pgcDqQqAQP89AAghGIHHQUQHWDdDFfFuE9NjN08Ok0XxJv3J8lji6C7hP0O1MYudDB5XNdMMYZ6Bkoq3QmoN34WAyOHwSAT/AQOPJT5FdKGRLvrEuuJRvblC6ojXDDPPonzOn6UD9irA9nOsdeywfYjv9J7WNlF3ClHZE6+ZC9kr8GfGq0X/AvAln9O+vgzl8YLoggQu/YsIxwbd8ZuhoyfKvm0+68tXfRcUciMZu9g5AtlIioXZgYv7xS0nd7jE7pie9VJtx6DkTRVzyn1HM775lzblKePkA0649rsFvf98/UrbIm8x3xPz+sxJDjywqcmCSfhhEzd/VKsDH0S
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(82310400026)(36860700016)(376014)(56012099006)(921020)(11063799006)(261009223027099003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UYi1qUE24G4Uv9wBO4GqWHi4+o00GD7/IvETE3xEfL8ZBxQViErid5peJodHFB3BZO7JRCabnugRwLXhUQrY9bQIe3WiK5qI8akGrXWHeUrF+SJgAwrGm4yxO8Am2RHatyzfzgrodyCfNpavYt3Gtb+1W0YAFpsc+q7YB2QotTzrh0tRtOOKXsQj+YxgP7GGMHwS8guQgyjRmiEr+Y0TF8OuYl2YGeQ7KzWwYlENVSSRUwoUCYahSZszSISNQuAqOM0KZi++o81mQAmDIOScqjBw3TJSSoCzhvKmGXhJ4wsC6P3e4Pgy59qQt74/4cW2/ddBq+v/LR/i627vfnOZ0sb+F1os7h05l8bR6UKHi6QZ1OsQuQQ7fN9hJPWOd3V0BjJ1OV5kfB/ukxU9pXJe0zCUodtm9gN+cXYfcJio9I/T3T0rOMcp5DcUuYiXZcOY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 15:02:55.4086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7e1bc8-9307-4f2f-580c-08df2acd64a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999193

Report the bytes queued to and completed by each TX ring to BQL.

Besides limiting how much data sits in the TX ring, this lets the stack
stop a queue once the bytes in flight exceed the BQL limit. Without it,
a queue is only stopped when its 128 entry ring is full, and the TX
watchdog only looks at stopped queues. With light traffic it can take
tens of seconds after a TX hang to fill the ring, before the watchdog
timeout even starts counting.

lan743x_tx_close() frees pending descriptors without completing them,
so reset the BQL state there.

Assisted-by: LLM
Signed-off-by: Chris Babroski <cbabroski@nvidia.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 2545a846478d..7739fa49fc44 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1708,10 +1708,23 @@ static int lan743x_tx_next_index(struct lan743x_tx *tx, int index)
 
 static void lan743x_tx_release_completed_descriptors(struct lan743x_tx *tx)
 {
+	struct lan743x_tx_buffer_info *buffer_info;
+	unsigned int bytes = 0;
+	unsigned int pkts = 0;
+
 	while (le32_to_cpu(*tx->head_cpu_ptr) != (tx->last_head)) {
+		buffer_info = &tx->buffer_info[tx->last_head];
+		if (buffer_info->skb) {
+			bytes += buffer_info->skb->len;
+			pkts++;
+		}
 		lan743x_tx_release_desc(tx, tx->last_head, false);
 		tx->last_head = lan743x_tx_next_index(tx, tx->last_head);
 	}
+
+	netdev_tx_completed_queue(netdev_get_tx_queue(tx->adapter->netdev,
+						      tx->channel_number),
+				  pkts, bytes);
 }
 
 static void lan743x_tx_release_all_descriptors(struct lan743x_tx *tx)
@@ -2003,6 +2016,10 @@ static void lan743x_tx_frame_end(struct lan743x_tx *tx,
 	if (ignore_sync)
 		buffer_info->flags |= TX_BUFFER_INFO_FLAG_IGNORE_SYNC;
 
+	netdev_tx_sent_queue(netdev_get_tx_queue(adapter->netdev,
+						 tx->channel_number),
+			     skb->len);
+
 	tx_descriptor = &tx->ring_cpu_ptr[tx->frame_tail];
 	tx_descriptor->data0 = cpu_to_le32(tx->frame_data0);
 	tx->frame_tail = lan743x_tx_next_index(tx, tx->frame_tail);
@@ -2276,6 +2293,8 @@ static void lan743x_tx_close(struct lan743x_tx *tx)
 				 0, 1000, 20000, 100);
 
 	lan743x_tx_release_all_descriptors(tx);
+	netdev_tx_reset_queue(netdev_get_tx_queue(adapter->netdev,
+						  tx->channel_number));
 
 	tx->rqd_descriptors = 0;
 
-- 
2.34.1

