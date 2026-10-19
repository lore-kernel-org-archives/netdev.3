Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.7
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792425462;
	b=RaB9KvsDzmSzYXmFTuM7vzmFG2fPjrRUtxv7CpAYiGhFDeBTUVQC+P0QzjIRWx918yWw
	 VCyRGTrffCPvWFm+1rB73zkT6Y/l7ZfTEP6lIWw0YkEwYxgu/tYnkvmt9qxU5gcFOXG3f
	 ozlx9PQVVYla6D0Qts7AL+w9aZwRqxp9S5khUUSXlzAq1b0caSD2ZUoHuLxxnc1OThA72
	 kg+zI9z1mAe4xP0CBg+bTwkP9vshnFbBzX0tJDjhy+aCgrVPlYeUA/bdtJrFqoAVHh2US
	 jTUMip76JfqceHW12ikx+sTKe5s1dkHA0dOlreqjv5RsEhtfoiNxf4/nYZz/8A8Vm2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425462;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
	bh=ES/36iUYSJsd3edItbfZ0i8T8t6lEUq077AfpRWn0OA=;
	b=iAF/M8lUaoJCkAkbk/cPXitnwwU49G628KPHfnZea/uWvRg3ziU/3ssfDXutmkdrIzdm
	 nJ/DY/Rd8QchYtHjqVHKpdkQjgmAaTK4QesOct3f4gan5sp5iE/bZQYmA+fen7GS8mR70
	 2NZysmSiEHCUPFCZeVvULSKogs3e1ROOxmnZ4Rl1tJqNTy6/rVzkZELQzU4X+KQ4Nf3sp
	 /OM3Nnt66x0pZGr3//X/b1IRQXyJI91oGLkMHJL8JAwaQlYt5y05XF6FNyOo7rC5Udvkx
	 kkGf1HyMqJCyIPJk8sQuMX2eFjpJKGU7qlnrdgPJdHUt3cy84rCqN/8fnxTQaE8TifA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b="bg//iQlO";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.7
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010007.outbound.protection.outlook.com [52.101.229.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CAA606AAF0;
	Mon, 19 Oct 2026 15:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66CAA606AAF0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=bg//iQlO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFb1zs0CD8ql/OPTeptsvB8JKBk059ZFXrdi+5dWExd4jy6t+XNQqsU56CjqCwP7Yn2uG/Vluvg+QvvGOU5oBG7i5yOPzgMAFyV0jMYMCTV5oZqYyLNI5Y8H7Y5eAP1IRAungp3t4m1ApoKYlP7DB/GxN3XfHddWGB+sBtCBRDWjl225ODpgwDT6g1Fkkh+XTc59uN7wYy/0wNk8xoMgozlvb85z8sUzOp75I8fMmIOOkB07JNsNa/WX4CdqG2J1s2rMbPzlOlVnbAkfgijuXPu3mVcjxWCZ40WC9ppwBRleo515rQD5w7ou1Bnr2qV/5fblzyPduBgOsUlIUgeVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ES/36iUYSJsd3edItbfZ0i8T8t6lEUq077AfpRWn0OA=;
 b=Vu/wWn4hufB0vpyWIVtnIyN9q290PpWd6XksheyXvSwOqZsIXyCtzQpSpbP7rj0BHw3XaU3aHakC9hxW5hOFXWTg+pS/F0oSWYFUbdrtdvOu0D2ALIrIp6wiREUBoOLbDJUYOGaY7l2bk9FVV6Y7bI5rkwIP54rJUqumJPVJXAH811qYQ4nIZOq1kNCXkrXTOauumxnFxXSOYiiewgXClK7DdQ/DLlZ2u4h8SkA++5eyp7aRFAyKo/X3N2HFp4CvSuwlTjFZHcYA6HmEjD1vkcuQr5074M4yXFdo8Z1FpFFbof2ZBf8gofWnAD0SWdLNbe5bqbbGHJ4qu+GzcqxfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bootlin.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ES/36iUYSJsd3edItbfZ0i8T8t6lEUq077AfpRWn0OA=;
 b=bg//iQlO/ftISWXmwqRb7tv9ORY6Jh5mRpEllAnDqlPQmql1QvWOan0Ylg6RXMdnlSGj/+KZ3iJSxnhGeWfQj41T+P8fUMM48utLSBVlXFHQsJNA4zHl0gYjzj1AvUQexovPbqBVLq6lw/hzbiCFgcWB7hlNozqtHo5HfUcHLIE=
Received: from OSTPR01CA0075.jpnprd01.prod.outlook.com (2603:1096:604:21a::7)
 by TY4PR01MB13059.jpnprd01.prod.outlook.com (2603:1096:405:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 15:57:37 +0000
Received: from OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21a:cafe::5f) by OSTPR01CA0075.outlook.office365.com
 (2603:1096:604:21a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 15:57:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003C.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Mon, 19 Oct 2026 15:57:37 +0000
Received: from vm01.adwin.renesas.com (unknown [10.226.93.174])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 326403000241;
	Tue, 20 Oct 2026 00:57:31 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: maxime.chevallier@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	xiaoliang.yang_1@nxp.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH net v2 0/1] net: stmmac: Track the TX DMA threshold per queue
Date: Mon, 19 Oct 2026 15:57:27 +0000
Message-ID: <20261019155728.85318-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003C:EE_|TY4PR01MB13059:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 794869d6-c8e5-4e36-4f59-08df2df9b25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|7416014|18002099003|13003099007|11063799006|10067099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uehmbA2tn0bHHX/hRyP3Zf2LrWLGkhEiR6u5xtmqghaE32WOuck6SAs589Z7BQ7n67RRSvXj/ZLyy47nGNPVjovHU1hjC7WB5XMV4SMqLYj5jz7n2iWyEJFtHo7cma8Ud5/0ruqmYck5SWN1wQOxAdlmnJpFDhDxoLcrAbpq+lOPEtIOtrSTkHvRQt3iAcBS9K6Rs1gcXeWckzugyqrjAaf94OeET4fLkeeJZTzTZBOd+7aYiHH38I08zc0yRtucNXdt5Dt1nEBdi6CMUnhXhyVwilC70/79ig+eFhpvysHf8HgmMuCsRdQStNO03TvlWT9IUkbjFEpGTzu6M/vk/NlU8DzgCxDTIkcUXMFNy1JmiUt8ykT9UimamVwBXarHEn6TjYGuGiRT1yCH7LgKpHaVlrHTCZ9UswNhUAEKJ08xnlboYkuqjEJxk0QFasfa8uLFW4Dw7iv6YJAgodf0ed2fF5XlQgBtaTxXna+j5G8Psx1esOTJS3WCbMRWW6AYy5Hk35K+9ASqR3u6mab8zdedWr7ZOAKzljU8hV8wOkrQpr9h35cHwquTtKxYPTHFvxnQbow8aG0KrInKlrMzWoZiDQ8bIoixjmYxyIWKfOIRg8eNjj6C/NR3Up3DmeihCAswzKeN0EvMnWGfzBtxNscwbtwWuSayxZ6qCmGITNw=
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(7416014)(18002099003)(13003099007)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2RVutyA8nMlUBAQZc7nPg2vBct8XO9BpabzE+k/IZQTpB/2nKWBKje0X4hPdUERLIfy56IgXkIURX+0MNQLsCZImIvqEaWf0EVvyyofzUbJBpZvFdiqHe0JyzBgXCN3EEFnldy1RQsRCAykgMD5QqFpR5XpkbWgcFKqW8Vg/gpOik1y0hAajFcXhYNusL7NC2xxlSIveMkwAJ8XP9OFSt0fW2BuVxnI+c9nT6mQ1+o6QJKD1+nAD7fIHSKsj6PXxSrY8MJYq37iMrmBInj4VdL9osjfbrivrqSvV6PS9yrF2VcSZcjH+0IfNX4w8g0WeXipL67RJ9Sut4NnGvMuOTS9TCg3fkv4AhfYb9G7sztq8C44637GFVTuIqG4ZYsIVGULIV0e748ET7cfjyf/uggDFXhxzi9ZFRt/qwnWkrLG/VLdF4CVK6hTDokwgKsE1
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 15:57:37.1648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 794869d6-c8e5-4e36-4f59-08df2df9b25b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13059

On the Renesas RZ/V2H platform, which has two dwmac4 controllers, we
observed sporadic iperf3 TCP TX failures on one of the controllers, with
throughput dropping from >900Mbit/s to ~1Mbit/s due to TX underflows and
the resulting retransmissions.

Commit 3a6c12a0c6c3 ("net: stmmac: bump tc when get underflow error from
DMA descriptor") made dwmac4 raise the DMA threshold of the queues that
report TX underflows, by increasing a global module parameter 'tc'.
However, this logic does not work correctly across multiple queues and
controllers, and can leave the TX DMA threshold stuck at 64 bytes.

This series fixes that logic to track the TX DMA threshold per queue for
each controller.

v2:
- Dropped patch 2/2, as it is not suitable for net. It will be sent for
  net-next at a later time.
- Added "Reviewed-by" tag from Maxime.

v1: https://lore.kernel.org/all/20261013114503.57487-1-ovidiu.panait.rb@renesas.com/

Ovidiu Panait (1):
  net: stmmac: Track the TX DMA threshold per queue

 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 33 +++++++++++--------
 2 files changed, 21 insertions(+), 13 deletions(-)

-- 
2.34.1

