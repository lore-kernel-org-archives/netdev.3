Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793042548;
	b=3GSam9JpbIzxmcylor7KiW1QGsPVRl7FyAK+9XDhIn5GLOdf3FTGaZ0W8ZN7Pg3QHFqe
	 3WjqrhLvz6MRkoSjeXtIpuAj3MzB4NsKBWnhz0HVUGqLyqZz56B+AB2x7OEEgE2ai8kWL
	 o3b80l3P+XF3XYlYzQAr4VH2bmbGs2tyfTDQJDDJWvEHjSA3rsWRPbey4DkBdFM4RxhlJ
	 Ag3jsfiKke84zUwRaigop8U/w9l5gZI5He8TY7+C5whrSxI4wFTMrpPv8B6mRzVmlC+vJ
	 xeYc0kAYGP4jrjuurkkheyzAE5Ps7lSDIA/ujYRsbIVvW8OFUjzzHrse+iYvIl3OmRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042548;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
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
	bh=3GqyIm2w2YCfnVPBpVkQN0p9D0eYb0NyqEEV/k59/Lk=;
	b=ELVrjkMeRWRBRuXtULN4gXQvPK9nF826XWAGpMPkiurSHr3WoZhwhV2UGlmDc4L+Ph6I
	 mwyiiwH/Wl6XstRIaS9Z/wTrvtH73yB2RdtYizSrASYVq9Zt1mHgxUpKINUzQb657m/Rs
	 UnHh6/tmB8uS1IOHVVcWz4UKrk3wjEaDqZ3shvG7Qrho0IosmUy5XghZZdaGwiwEtM8ND
	 gbaqlIRVmZceVydr2fxEgQ85M+CArIzBL1NhfEIH/3kvRoqi5VIEGg4SmPbUbfPCLK8jb
	 C35bIYmYFPUIiSSA2PXRGjeFnZrv2aMUQv0qefY5nX22v2gHNXxWpKDtVvSN2ebbhLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hKKtyFKk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.14
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D184606A31A;
	Mon, 26 Oct 2026 19:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D184606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hKKtyFKk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUIMGkBw6qOizZpDY0ihGyPz9wrSSxcCY9dWYX1mBuGXnkU/ivw4OP7IqhTfP722ire1tl6ZHpD2CADMJ4sOKehsi50g/Kao+8Wqo20cy1ZH0RKE5e7tPCGIcaJXfVVj+3XN5BpHRNFREEMYk9Fucyj+XDXcMAM796hmt8okRHoUFnUxNAMB/cFESAUZXrO7M/JhTV6E8g0KMJacxuIicVICyGHlUP1LnVI9NVrbWkgrOPctJHeTiXauiUk7QWBVU9nt1cByyECawcwYijyLfe0+s4403OniIYktum1BpMZXI+WdmEFZIA1zhvybkorwo6YOZsq3B+U6LxsgrmR8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GqyIm2w2YCfnVPBpVkQN0p9D0eYb0NyqEEV/k59/Lk=;
 b=vBh7SjdjoclBNztdxs21xWo5TbSKZIgIxgicKKrA/Dq/6G58fbfqpamWBeJ4w1ey5wLUWsFk6QWKiqfkfkDFptAvwB/8A6j1vLH6ithGW7JXkdOsJEtQBcTwNz+7Fkt4Zh25KVahlEzTXlRZXakVSF5vIgNljd93FCFS8Fi0ybSVLgwQ74McO7ZmclQ8aF1/JE+zAp0O+s80Z0Fk4u5IGGOBNZWPLyohK1imH2PivQ+6YHNfkQw10yLs1kUnye+fISkuTUdBr0Skb4UZGA0xsp+Ozmk4Xbflkq9vnrlff7ep+Jbw8nfFOMpWu74SpYA22YCYiNVSuhvet/PpvBeR0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=tipi-net.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GqyIm2w2YCfnVPBpVkQN0p9D0eYb0NyqEEV/k59/Lk=;
 b=hKKtyFKkyt1zj4WD29MYIXOA9eysRLxtrlvgDag4UrQXMf71FXpjEIlUjJr0GiJCvNbdzCzGzsQO4R4knGTwSVlZ9lPwVYgbLxHPbJoMxNxoNM8ED7t08JwN/rtUGlkk7K1R2cwZJZ/FTudkmemjg/ltYe15AdsB10/f2YhZDweUrzGeQIkpFUhJxkWma3WIeJzrNun7LSRGI/FRPafVdKpOeTfvEkiyt39mz99ZfscP2SmLDkuNVJaZBnIlBUm7XS4QyT5WNFcLfaP9yG2PcmCned6eJXfef1jdsXkoXMEV4LmO9aNiJrL1DI+/H9WRSho1MrJBiZu1bmuDHikgVw==
Received: from CH0PR03CA0388.namprd03.prod.outlook.com (2603:10b6:610:119::30)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 19:22:20 +0000
Received: from DM3PEPF000265B0.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::84) by CH0PR03CA0388.outlook.office365.com
 (2603:10b6:610:119::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 19:22:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM3PEPF000265B0.mail.protection.outlook.com (10.167.23.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 19:22:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 12:22:01 -0700
Received: from vdi.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 12:21:59 -0700
From: Chris Babroski <cbabroski@nvidia.com>
To: <nb@tipi-net.de>
CC: <Raju.Lakkaraju@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <bryan.whitehead@microchip.com>,
	<cbabroski@nvidia.com>, <davem@davemloft.net>, <davthompson@nvidia.com>,
	<edumazet@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>
Subject: Re: [PATCH net-next v1 0/5] net: lan743x: automatically recover from TX hang
Date: Mon, 26 Oct 2026 15:21:43 -0400
Message-ID: <20261026192143.550470-1-cbabroski@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <86df200787e1be614b21a7d009e8f1be@tipi-net.de>
References: <86df200787e1be614b21a7d009e8f1be@tipi-net.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B0:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 9431c645-52db-4640-87ca-08df3396745f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|23010399003|7416014|376014|18002099003|6133799003|22082099003|261026121527099003|10067099003|3023799007|56012099006|11063799006|261009223027099003|261022105027099003|261021123027099003|261021135927099003|261022075727099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	07myLsgrlF3Hz3O2dBU0ICFKns86iZJXZVHrrQ6cQw1bgwEmA0f90VDNhsUVvXcs5L6KLLqwOCB8r/mLXW00Faop8UrvP66lFRedyJm5jdRjgEczWBACpDV3uWXMa58q98mENczv+c/J7ggHjK35lZcXppJRQCmYia7td8xqrAy8/hgZot0aarEQhO1CHxyLobRYtNuVwYLQka/G608a5qQdBhVVy8seIgMq0nc661+yh7kkZpPNJjcQ1JCVtlT2DQaH8jQ5KU9R3rCIGJ6GIGbbePYfYlRvfJmiiW7b6KDu5PKfuQDKe2z2TRHeMlAZ5YTVW0JTRshjnfZhxyIa4SA9zPfDqqWj5MLBOmiHbnjd34yDFJQo0rzzJWMvxCC2mO92eOMT7Z8iD5j/QfD+z0qxbIs5g0FoIkk0hFycqvTZKe6I7xFB9hKQFAp4WGScHRuRDPWGdStiwkZ/oAA6PqJtd/THeqLlvJz7GSusUnaA7g04HsfH9QUa3gZlnIy1HW+LeKHa65NMdQ9/ZsxGv9AW7DE/UPX1rka1yLNziT6FcXFCAiGitXC2LSSKxDzNUwKm7TtQAgO5h2JyqY1TL0uDxJS8JdWS7EohOneQD9awLb7bzbKJOdWfCMbqS64vhWmzs4vl0tbN0Y6hs/wkpq3Z42oENEHZN4Lk1oVlVEk56cIXscfyfOEATSl/p51iJa9Wdff74GM6h/BRViPX6Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(7416014)(376014)(18002099003)(6133799003)(22082099003)(261026121527099003)(10067099003)(3023799007)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(261021123027099003)(261021135927099003)(261022075727099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LeNZYY/A44SqI7ItbtTGpJY4QgrHiEJjU+lYRg17PX8pfvuLsWZxK7eCQKWXcAMkCTVK6Uz32RrUuLPQ/TtihXNmXXxYj6oRqFdAGzy7bAMF/zkmEgcKGAJIQerfirmCM5x8EHE9pe+lCaHk0f7gGI8asfyUWnJAa+iv8F8NAHc2RaS+PJWNnlw6v7dHIiwSH9T0hvn1XsLDi9zPMVkq4NVnFsTPiv0gFOpNv9v3e40raM5pYX8gDhDUCAsROX04o6Hip8A3cbFLK46Sz5qr+SwRcShza2lHeE4p+Z4At2Ncwb+VXkPYNiC0b9Bw7kfkBKZqrUtQH08QgGDB5TDyKKKwq/h2vSyxcE4hzez7nDL1Rinr2rSeLHKRKYExl9/2fN6hBBAy+2xmXbzF/NKCXG+z6evhxsE0rppcTosmlETVCpi/DqGqq9hOtf9RYjci
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 19:22:19.9368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9431c645-52db-4640-87ca-08df3396745f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453

Hi Nicolai,

> What do TX_ERR_STS0, DMAC_INT_STS and FCT_INT_STS show while it hangs?

No errors; the following was captured during a hang:
* TX_ERR_STS0=0x0
* RX_ERR_STS0-3=0x0
* DMAC_INT_STS=0xF100
* FCT_INT_STS=0x100000F1
* DMAC_CFG=0x10060
* DMAC_CMD=0x1000F0
* FCT_TX_USED=0x34
* TX_HEAD=0x3C
* TX_TAIL=0x38

> DMAC_CFG MAX_READ_REQ is not a size either. It is the number of
> outstanding TX data reads, 1 to 6, and the driver sets 6. Does the
> hang survive MAX_READ_REQ = 1?

So far I have not been able to reproduce with MAX_READ_REQ = 1, but I
have reproduced with MAX_READ_REQ = 3+. It's possible I have not run
long enough and the issue would still eventually reproduce with
MAX_READ_REQ = 1 though.

> If you can share the reproducer I can run it here.

I have been able to reproduce consistently just by starting an infinite
scp loop to copy a random 50MB file off of the SoC onto a Windows
laptop. Usually will reproduce within a few minutes when on the same
local network. Something about Windows scp/ssh significantly increases
repro rate; we have only reproduced once this way when doing repeated
scp from a Linux server.

Regarding the test data I mentioned: I do have a debug kernel module
that can reproduce consistently on our custom HW and I included it below
for reference.

The test configuration is based on some data we captured while
reproducing with the scp loop. It requires that SG and TSO are enabled.
See comment at top of file for details and change IFNAME to your
device's interface name.

I have not reproduced the TX hang with a LAN743x EVB connected directly
to a server using this test module or the scp loop method.

> So not the request size. What is left in the driver is the descriptor
> prefetch. lan743x_tx_open() sets TX_PF_THRES to 0x10 and
> TX_PF_PRI_THRES to 4, and the prefetcher works hardest with a full
> ring, which is when you see the most hangs. Does TX_PF_THRES 1 change
> the rate?

Unfortunately, no. I can still reproduce with TX_PF_THRES set to 1 and
TX_PF_PRI_THRES set to 1 as well (tried various combinations of values).
With the test module all reproduced on first NAK.

I also tried enabling DMA_CMPL_RETRY_EN and increasing the completion
timeout to 17-64s with setpci and could still reproduce quickly with the
test module.

Thanks,
Chris

Test module (debug only)
-------------------------

// SPDX-License-Identifier: GPL-2.0-only
/*
 * LAN743x TX hang reproducer. DEBUG ONLY.
 *
 * Sends the same TSO frame to TX queue 0 of IFNAME as fast as the driver
 * accepts it, until the module is removed. Each frame is a 54 byte
 * Ethernet/IPv4/TCP header in the skb linear area plus one 23560 byte
 * payload fragment at page offset 14335 (0x37FF), segmented by the NIC into
 * 1240 byte TCP segments. The driver maps this to three TX descriptors:
 * header, TSO extension and payload.
 *
 * Frames are addressed to the interface's own MAC and to 192.0.2.1
 * (TEST-NET-1). Needs scatter-gather, TSO and TX checksum offload enabled.
 *
 * If the queue stays stopped for STOP_MS, the sender reports it and stops;
 * the module then idles until it is removed. Remove this module before
 * unloading the network driver, it holds a reference on the netdev.
 */

#include <linux/delay.h>
#include <linux/etherdevice.h>
#include <linux/ip.h>
#include <linux/kthread.h>
#include <linux/module.h>
#include <linux/netdevice.h>
#include <linux/skbuff.h>
#include <linux/tcp.h>
#include <net/ip.h>
#include <net/net_namespace.h>
#include <net/tcp.h>

#define IFNAME		"eth0"

#define HEADER_LEN	(ETH_HLEN + sizeof(struct iphdr) + sizeof(struct tcphdr))
#define PAYLOAD_LEN	23560
#define PAYLOAD_OFFSET	14335
#define GSO_SIZE	1240
#define STOP_MS		1000

static struct task_struct *test_task;
static struct net_device *test_dev;

static struct sk_buff *tx_test_build_skb(struct net_device *dev, u32 sequence)
{
	struct ethhdr *eth;
	struct tcphdr *th;
	struct sk_buff *skb;
	struct iphdr *iph;
	struct page *page;
	unsigned int order;

	/* headers in the linear area */
	skb = alloc_skb(LL_RESERVED_SPACE(dev) + HEADER_LEN, GFP_KERNEL);
	if (!skb)
		return NULL;

	skb_reserve(skb, LL_RESERVED_SPACE(dev));
	skb_put_zero(skb, HEADER_LEN);
	skb_reset_mac_header(skb);
	skb_set_network_header(skb, ETH_HLEN);
	skb_set_transport_header(skb, ETH_HLEN + sizeof(*iph));

	eth = eth_hdr(skb);
	ether_addr_copy(eth->h_source, dev->dev_addr);
	ether_addr_copy(eth->h_dest, dev->dev_addr);
	eth->h_proto = htons(ETH_P_IP);

	iph = ip_hdr(skb);
	iph->version = 4;
	iph->ihl = sizeof(*iph) / 4;
	iph->tot_len = htons(sizeof(*iph) + sizeof(*th) + PAYLOAD_LEN);
	iph->id = htons((u16)sequence);
	iph->frag_off = htons(IP_DF);
	iph->ttl = 64;
	iph->protocol = IPPROTO_TCP;
	iph->saddr = htonl(0xc0000202); /* 192.0.2.2 */
	iph->daddr = htonl(0xc0000201); /* 192.0.2.1 */
	ip_send_check(iph);

	th = tcp_hdr(skb);
	th->source = htons(12345);
	th->dest = htons(22);
	th->seq = htonl(sequence * PAYLOAD_LEN);
	th->ack_seq = htonl(1);
	th->doff = sizeof(*th) / 4;
	th->ack = 1;
	th->window = htons(U16_MAX);
	th->check = ~tcp_v4_check(sizeof(*th) + PAYLOAD_LEN,
				  iph->saddr, iph->daddr, 0);

	/* payload in one page fragment, starting at an unaligned offset */
	order = get_order(PAYLOAD_OFFSET + PAYLOAD_LEN);
	page = alloc_pages(GFP_KERNEL | __GFP_COMP | __GFP_ZERO, order);
	if (!page) {
		kfree_skb(skb);
		return NULL;
	}
	skb_add_rx_frag(skb, 0, page, PAYLOAD_OFFSET, PAYLOAD_LEN,
			PAGE_SIZE << order);

	/* TCP checksum and segmentation offloaded to the NIC */
	skb->dev = dev;
	skb->protocol = htons(ETH_P_IP);
	skb->ip_summed = CHECKSUM_PARTIAL;
	skb->csum_start = skb_transport_header(skb) - skb->head;
	skb->csum_offset = offsetof(struct tcphdr, check);
	skb_set_queue_mapping(skb, 0);
	skb_shinfo(skb)->gso_size = GSO_SIZE;
	skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(PAYLOAD_LEN, GSO_SIZE);
	skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;

	return skb;
}

static int tx_test_thread(void *data)
{
	struct netdev_queue *txq = netdev_get_tx_queue(test_dev, 0);
	unsigned long stopped_since = 0;
	struct sk_buff *skb;
	u32 sequence = 1;
	int ret;

	while (!kthread_should_stop()) {
		/* the driver stops the queue while its TX ring is full */
		if (netif_tx_queue_stopped(txq)) {
			if (!stopped_since) {
				stopped_since = jiffies;
			} else if (time_after(jiffies, stopped_since +
					      msecs_to_jiffies(STOP_MS))) {
				netdev_warn(test_dev,
					    "tx test: queue 0 remained stopped for %u ms after %u packets\n",
					    STOP_MS, sequence - 1);
				break;
			}
			usleep_range(1000, 2000);
			continue;
		}
		stopped_since = 0;

		skb = tx_test_build_skb(test_dev, sequence);
		if (!skb) {
			netdev_err(test_dev, "tx test: skb allocation failed\n");
			break;
		}

		ret = dev_queue_xmit(skb);
		if (ret != NET_XMIT_SUCCESS && ret != NET_XMIT_CN) {
			netdev_err(test_dev,
				   "tx test: dev_queue_xmit failed after %u packets: %d\n",
				   sequence - 1, ret);
			break;
		}

		sequence++;
		cond_resched();
	}

	netdev_info(test_dev, "tx test: sender stopped after %u packets\n",
		    sequence - 1);
	while (!kthread_should_stop())
		msleep_interruptible(1000);
	return 0;
}

static int __init tx_test_init(void)
{
	int ret;

	test_dev = dev_get_by_name(&init_net, IFNAME);
	if (!test_dev) {
		pr_err("lan743x_tx_test: %s not found\n", IFNAME);
		return -ENODEV;
	}

	if (!netif_running(test_dev) || !netif_carrier_ok(test_dev)) {
		netdev_err(test_dev, "tx test: interface must be up with carrier\n");
		ret = -ENETDOWN;
		goto put_dev;
	}

	if (!(test_dev->features & NETIF_F_SG) ||
	    !(test_dev->features & NETIF_F_TSO) ||
	    !(test_dev->features & NETIF_F_HW_CSUM)) {
		netdev_err(test_dev,
			   "tx test: needs scatter-gather, TSO and TX checksum offload (ethtool -K %s sg on tso on tx on)\n",
			   IFNAME);
		ret = -EOPNOTSUPP;
		goto put_dev;
	}

	netdev_info(test_dev,
		    "tx test: starting header=%zu payload=%u@%u gso_size=%u\n",
		    HEADER_LEN, PAYLOAD_LEN, PAYLOAD_OFFSET, GSO_SIZE);

	test_task = kthread_run(tx_test_thread, NULL, "lan743x-tx-test");
	if (IS_ERR(test_task)) {
		ret = PTR_ERR(test_task);
		test_task = NULL;
		goto put_dev;
	}

	return 0;

put_dev:
	dev_put(test_dev);
	test_dev = NULL;
	return ret;
}

static void __exit tx_test_exit(void)
{
	if (test_task)
		kthread_stop(test_task);
	if (test_dev)
		dev_put(test_dev);
}

module_init(tx_test_init);
module_exit(tx_test_exit);

MODULE_DESCRIPTION("LAN743x TX hang reproducer (DEBUG ONLY)");
MODULE_LICENSE("GPL");
