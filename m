Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021141.outbound.protection.outlook.com [52.101.57.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FAD46D094;
	Tue, 21 Jul 2026 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656393; cv=fail; b=IteQbU3PgF9m+/FFcytOwnuLv0Nx/m0RRFGyjT2qyFUhLn5fYZUTsUQngBjusItEM+F0OdrKHbAbGEj4HdlCELml/8hGBgE8HLiqWBraW8/I8llSX9eT8MehmbFXO5zTRqDugHf+pQrA1iL8Oog7h+x+6YoSaiADgO+O8oICDRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656393; c=relaxed/simple;
	bh=/NlqF1A+3bjsoSfiM+IivDBMsvOcGsEVTrB1BDxu2XM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a0a8aLgYrqWVjAHCuwfxbX0OIcailrLAoBJz2de/3zg7MC4cTewLMrZqnzFZjsWokv+SoPfm0uKfbIKd2TuBsUQ5+EpjsNwVN7c+xq1nBZYhcJlWWrrWdSV040HTkQdy2aybuoxzPQYFftBJmM8M1NUJLOZiJGSCxBmpLTSAVUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QNx95wDc; arc=fail smtp.client-ip=52.101.57.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QNx95wDc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARXR7Iyossdixi0mPuzGmL7T1KmzgCQzSwXw3xoa8HvhVMfmWnQy1Uk6JVBtGtHZ5+ZMC3uXOk4SYfCySyPdoSEkM3KmcbMTrYMwDwfYbHlcdhYWryWKg8vq7pF4U3EbttFrvQIVwyVcW0KsytI5VFhA/M0abu2xXfkx70vgGwc5u6dIawzVnUcIomPSzk8AMvfznios4wc7t86YE5wB/RJ7j3/uoRjw5PYHNIseCP8ek1hJwHo/s4AQ32+euygVAyu4xdQ8tpGg2VgWKT8IWRLY66ol3Ak/D8RiOCKAQhz81Lk2hHMlkuO6mNIAJDfK6MFat+6B9wB1ZN5GbHdSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6+8d8d77TXbTqfkvHNtxnm8IybKgyIwxivxDNqzQGA=;
 b=wyriNjavkRMjIrhxx75ZGOGKyp/OpxAceoqRUR6gp4wuSbX8NM8SlL+h6QAhgeTRfZ+MQoUUl8O4M6Q3F9rw4eYh8ekwSWQx7fUH4yCHp2yz5HXpbjGjqnVN0le9Vhh3PMi3cr71WebAb2k7dInDepGMV1Zs/LM6FHK72wwDc2edy67wUWqNXAKkEMXhnFDGZDexSsz5lrhC8CjfZMU6g5LH1miDY11NE+FCce7Kvg5qCY31VeDCoMgWFXvfcqf4VTioJbZvENQButYTNYAxNFuIw1cAbgrmlQi6tC1SguxcAsfi2YO5Lk8TookAdgXBh9NxPxjw0vgSiaOQDvKmlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6+8d8d77TXbTqfkvHNtxnm8IybKgyIwxivxDNqzQGA=;
 b=QNx95wDcanRja5vI+bX8CviFsnYyJTfjz5kbusF3VbTn6G4qdP0BehO9iQD8ofFLR2bKC5ASW/86cJgQJipfymwDhMywuz4yTeGlg3Rff2qojT1qXaVBSCtr2EquheqczHGaGnRgzGcGXaVo3MBz1u69V9GzjeVmcapofesqzJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB7425.prod.exchangelabs.com (2603:10b6:510:4b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 17:53:05 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::44f3:1050:dce8:1ea9%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 17:53:04 +0000
From: Adam Young <admiyo@os.amperecomputing.com>
To:
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: [PATCH v45 0/7] MCTP over PCC
Date: Tue, 21 Jul 2026 13:52:49 -0400
Message-ID: <20260721175258.87600-1-admiyo@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:930:89::9) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d0d408-2c03-4cf8-c93f-08dee750ea40
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|366016|10070799003|55112099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	7mbQpHwznF3XtZRd6+jx69hTSpbg7HsQFxDTq978fdzwzCzJhPCcpFfUzLaDMrk8Z9o0OGCNiBnEftk+/K5T+gyRUVkBQCYT4sir9aEy/32T6E+c6Vqfi7y93KmGDFIhm/XuCkhr9WZiCGl8Dwi4DpGHroUsAsUphu/cuNTS5LqVTTI5GEB5ZEb6feCF1gbxk8FlpJTvwXOpnDDDF3EuSgU7FPd1v0QUsiWTuuI6I53UWuVPK0ak/RlFngBNneabs1Fc1mgI1VFUcENfufyXvBbLsuzpG0q936LdOPYS1Y80QSsEg5Zw3BPF/7nWh7w4DYjwfBxf2rISbx3wtU/xbdRITcVD+L3TsdcEzXHhmjy6pIZFwgr7e4Lg483QZmuMksXA2rQgHw/LRa7yaDRjTP7NDvOLj0BV/oXYJTLmyF/+ZWAtrljN0NOBazWViPrmRRcDpJTAcDrLRXzQDPcn+JHypd+hfrAujMJpGg+p92scepBRPMSiBuq/iLxAN5H15x3Xfx95Oc8pBvbjiwu+RdhRVkMB9IfGQhRVq+XJGCMNGuq6QWHGKdKj+ZG21Zd2U8pGfM1npniUgLi9sZqcfJ/oc+AbC+ABOJQGWDhTFWKKjEJ9iUQ4vclk5JYnbVCC2NacbkAO+CT0C0U8Y7fSgBGS8WEN4yQRuFIbAOK4SnY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10070799003)(55112099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k7SLDhdRLQ3Emo2tTbVs8MQJCuWYpWW4j13ptWRV741xk6LosMxG5+fLE2JD?=
 =?us-ascii?Q?B+CkaKOm55MSYfmvzfZqr5uAeIfupQ22H/aAl0I3VI3IWzsRR1a7FsU2XmH8?=
 =?us-ascii?Q?ctlDClS/XZ/gp4JZGwHiW0J2rH2oR7hCC1Uqotvsw0HeQLnq645Lo6MmuALk?=
 =?us-ascii?Q?aJzobX8s9WY2skr0h/ZGKhG2yXKd8zgkjphwJFtzhEu5S5UGfGFfe6jjhF5b?=
 =?us-ascii?Q?8G5OO3LcVYQ29HFzcJZiaJkkt8QFESY2Ghq9kTvGbW2mBmS8JqfFcZp3dgpo?=
 =?us-ascii?Q?4tZE0wlS/SNKmjuWQqiQxxsW//H1len2vdSkVMcuXjui+o7bywrS/DI9aHBe?=
 =?us-ascii?Q?qqYNxmmgW8s/VgycFVyOegreX+Jq/HnCpmDxiR+jyew2gTmfZo0j5mz1+7Ey?=
 =?us-ascii?Q?EQzcPFa+yuaXLA9srfTBKG4ejXD50bB1e5Pd2T0+zoj4VxZCJebJ8um0aRTH?=
 =?us-ascii?Q?5whvbHbGrIDoMzLOJVwh5HCWXETkJ+Qq5mieGEwebJrZEop/zl9Ihyq+zklX?=
 =?us-ascii?Q?1tCiTWAP7dT2D6XNMXqdFGDXf8rGwWAfyMRbcBmkQyJlf6OvIQYcI3irPsGm?=
 =?us-ascii?Q?2xbF787ZJ8fQ5esZpLWBodJqhQAPKcC9fKqJ+KpzsVG9RzEzL/R8zIVwwToF?=
 =?us-ascii?Q?+rQ+cXjur4Y0cIpFXxfAwf2zOgcLnU3ldh00nGNCaYhmH3fXDT9bJZvhuf3K?=
 =?us-ascii?Q?vcpjvtGDlQbEmzrEMg0F2o+xWJwZQHmweCSfyHQQkPFlXZJ9eaXk0mkJr/nO?=
 =?us-ascii?Q?pk9g7IhF0+ahMpdtYrZTELDsSb1D6P/GbRR+R5Y9pQG0mByERGtBgDixmLm3?=
 =?us-ascii?Q?qeP51eo52HSraylFCAH9aAOLQ250kynUpWMrTd3BuL+BfCOoKLo4kT2trbwf?=
 =?us-ascii?Q?3ch8ikFZd9AUA+FmgnTIJqF18zLwNLQ6gQ0M51Cmq6JrmNB7HbhcWjCoju5Z?=
 =?us-ascii?Q?cX04KzSg+65LPcUtUKYmcgfDdqJOH/w6PC+hq4U/znZM7Qhv8a9Y5uugE746?=
 =?us-ascii?Q?ctfUA1Dm+0SajX1dB66ToCX6NkXaW1P0tuVu+xzjOD8b0aP4zjWTvJm0Pv/k?=
 =?us-ascii?Q?5G0fw7rEKoegXu1e5WbaIsY6j2rC/lkIkrnqUBSnbEeC5t7nY584K+fhpfDz?=
 =?us-ascii?Q?e5oIncEdf2FSL9f447GDxwzCPsCO4lswvHp9BHKQoN1rD5oGNHly38PX/+6T?=
 =?us-ascii?Q?5hGnrdA5uayndzDrYV2cxOyGUnYIcqNFi88O+drbnani9X5d37Or65YKna9x?=
 =?us-ascii?Q?q1gfDoxCyfXejRLdp7zNbfRnxxLFMR5ey099AYjYFmlr6Dhy06qWVa9Pw40N?=
 =?us-ascii?Q?ujB/3EbjkPXsZ5FZYP7UcyUTko3v+xWPe8bv24WqpK59sa15xaybmgtUhKnL?=
 =?us-ascii?Q?ueGgXD1rNYolYbjoaHd29qRzzolJ6WHrwonf/ZZNen8HVs0WiRN/Mc1F2NYr?=
 =?us-ascii?Q?g5w7kQcJRBj2N5VQ/RyYMYnNkdWtM2HCN8SkyYITxvrY994Idw4iZsNJHnzh?=
 =?us-ascii?Q?NBM53/Xh4icL4C1AfJj6y/hV+kGvZefjIawLVs8VxOZB2lopLLz8Arj8bXi4?=
 =?us-ascii?Q?q1b/8iuTtA0TmhD0IHuZa7y6bchtSwj8UYH6BScUbrP4V77O8EevhUwatdwV?=
 =?us-ascii?Q?RaJqMRkHgRS4HxJPls90C078K+GCVixgo1tP9nlcCE9gX9edWXieh+bw7drr?=
 =?us-ascii?Q?4UqiFLGrC51qRwGatov3MSBw8zzdA4qdkLEagl3cywj+9ci39R7UHQQUuV+H?=
 =?us-ascii?Q?hVrcHOZ8wkPCuIuR2OWwpB9UCkS4U7YvIMvX3NSGysiLnyFYiSk/M77j4Wpp?=
X-MS-Exchange-AntiSpam-MessageData-1:
	2VjfxUwbUb3dSCIBxZtqerxNz/8DNAqELrmogjVr37Rk564yc24bOQrU
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d0d408-2c03-4cf8-c93f-08dee750ea40
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:53:04.8494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LIFQHZn804/FhEby6zFYcezMCdi9QsRxstZV289nSJn4BsSWggzV/kA+NLsLCJ/TuNzzKrwDPZMwNhlrZSBSRj4PTuTJm1wGz8mavLfhcmBvoVvV8ZUYUHOrGTbCAN0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7425

From: Linux Bot <linuxbot@amperecomputing.com>

THis patch sereis is long lived, and the main
changelog will saty with the MCTP over PCC patch.
Recent changes in AI code review haved shown required
fixes in the PC mailbox layer. The main changes to this
patch series are the addition of those patches.

Adam Young (7):
  mailbox/pcc.c: shmem map/unmap startup/teardown
  mailbox/pcc.c: ignore errors on type 4 channels.
  mailbox/pcc.c: report errors for PCC clients
  mailbox/pcc.c:  add query channel function
  mctp pcc: Implement MCTP over PCC Transport
  synchronize IRQ before releasing shared memory
  wrap pchan->chan_in_use  in READ/WRITE_ONCE

 MAINTAINERS                 |   5 +
 drivers/mailbox/pcc.c       | 112 ++++++---
 drivers/net/mctp/Kconfig    |  15 ++
 drivers/net/mctp/Makefile   |   1 +
 drivers/net/mctp/mctp-pcc.c | 466 ++++++++++++++++++++++++++++++++++++
 include/acpi/pcc.h          |   9 +
 6 files changed, 576 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/mctp/mctp-pcc.c

-- 
2.43.0

