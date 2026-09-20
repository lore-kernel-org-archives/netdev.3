Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099F73BB680;
	Sun, 20 Sep 2026 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789871475; cv=fail; b=KYYE8OO8pO1zRLWzg2l9cm2jK5weJeqrySBx948PiFh5vjpK3UMu7HEDiezMQgzLsV1acfzsy9f1eTRcD3S88JmZOtaRFhwh7JJXFxZLAGr3xCsW7rzaEFHVN1PYxQ0U6DVx05AHrdqpc9kBwFIntzaiTN6aNlIclw68eLwokm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789871475; c=relaxed/simple;
	bh=F4/rKK3Lj70eDCShFlZgEL+M6kzyASRLarBWm1E7Zd4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UxpVJLG088d+aqmUep/v5J5UNeKaqkCmW7S16hHP1GC6nPYJtOQgko7Y26wOZFxBa8POd1oV7A96xlrlD5pPwj7HoxxKO+xen9Hmkr4N3C216DTEbs66R09cIk08vwKwmPz/jvUKwfNsAze9/uPJMbU0PN3FsVAmyJEgvwKQYH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fStlc8to; arc=fail smtp.client-ip=52.101.72.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fStlc8to"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVcHc1GZLIJnR9MRq2cmzAmaNFKPs6xBd7hhvvw+Yso+yCavcLad6tvAlv2Pp0pEPQx3OzryuVqCu65FuYwn+2szNYdR6/9jixvcYcvnKSxgj4d/95Ouqai0lnEYJpIQDJdJwvho8IT2mDF0D4NNKL5XWG74gyf4DjbjoNzPDwwdhAg0iZUxcMYjnzx+oJSueTskqE80NiEzbX1EqanJF/NscuoYKxuwUlF7lyxKeifY0ASENzeytlUMz5qKQcxQPuEKPL1FvNsJT0ejk3nIoURtTNryBvUe9Q1nkNUUhQ23r2nRw+UY4RhcjL6mF2lWo4+5MZob3FpWPGgrQ1TQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2khwLgpjnaq75pGjuR14bA0R/S/syXRnf2IaxRmnChA=;
 b=Iy9izOGIqsp/ShiHhSBGX2JmWbBGdXP3LAe3SVPbk28XoK1o9kxLEIyHr43pIXhomFo8fEBcdGXu6GPxJvcdmurzfxsZGo0DFIGf1kI6xWScJra9xyrecDnQVnEpUh/nToUMk6PnZ+yfytQzhx5kVEp7q6OVau8vzIrOkUd5HVzTDYkyhOB/IRgzEI3lJOa/gpK+kBLyMZXL2+whcFES60qASBCWYWLk1DHGZhliA/YYf1eCXt3PROP2dYTaoW4T682KLC5rPHbVNUBsaxLO/3LWQyklzzazw4iE83Qx1LapqMb/wsAMTnkHj9HTpTBTZVLT6SKlLZ7chdkZ/NlM8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2khwLgpjnaq75pGjuR14bA0R/S/syXRnf2IaxRmnChA=;
 b=fStlc8to74GOLtRR8jGcmCqfp9giINQRHGmfYg3FZvmTfdEBzBfLZAc3Umj2cdP4NTGomaArJoKNakvwTNCMMf6FRv5AEiOYZG/9AoFwvNQ4liICvdfXdGIDmDY0ETkMLsLQGmW4qL48afhnV2uDbekwfgX6LMLgjY+CRqjqDf3l99WRJL2qiuINJ+xV20iEQoMkk2b6+TMKgM1LowxrIa/MIdHW4YI6Dzi/Id/jNo3lSVH/t4HvRfaQYyZjewh98QCeG/GsOK41UAc9JIFkAepEzhT+em+VjxJyqeaKUGcFziUpVbKRBQZFNdsL9NOndht3GV5zwYFwB+t20Zqyjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9596.eurprd04.prod.outlook.com (2603:10a6:102:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 02:30:23 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 02:30:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org
Subject: [PATCH] rxrpc: use assign_bit() where applicable
Date: Sun, 20 Sep 2026 10:27:52 +0800
Message-ID: <20260920022753.3145871-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: 82fafe4e-0825-4924-b954-08df16bf1fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|19092799006|366016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	THsM9yhVcNjDf6manOP/P1pa01EX0dXFuOxPk/HO/c4jYwD6u7THhnvnf6YkCzqdTV0FUL+9kOuQS9A9ndknDY+M2PsrB2IvactTS8RkJm7tcAM/ybZNlmdJ9YexlWBgy3TuzxtgxJXEpaZkkd9JjpKXqQ2kaUGKg/CePbN/5DhBrAyH6dEnlL3vsQgjh/7R3RyC0SsyHKufUOndR6ZXVoZ7S9qiLdtv8oHP4SLybrxStuEsXzBsbW5k/UDyFSPPUmesCVVUvryl7s/AMzOaUOFEb2cZnPSBXn8Il1uDNFnErowsuIgWVm24PnJRm12HsLIQl4VPNKEriBQ5X3RlX5Q02LYTIUNswRPz8Zh2ZZwLhNWPt1MF/rETlk2Z6dlYE3q7ShfbDvIv+ZCOjpuRt6TRBSXQQylchx5lZhG9zMCGlxKEQN+4roWNVLdAc92FKttBK70EXaeyVqsEPab/31I7rjil4C5weMwSxiT+7v1a/S5xI2haUwhvFhL2VvGJRxkT/DOKU3SZq5feQe7HtxWzRVtlJIjYflV07L1DcC7FCIlU5yBRGzl67vZzEdbbrLYVS6Swp3ETykkzTiqIkVygfXPLawIcNyxQ74Ngsug6US1jQNmC0f9VlEET3Nm22YOgRBMxXTnJRyAevFSIPubmbWO5G/gmPYWqTWAjGnw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HOqp8SlD/CpW9TKEt0HBYJ88CPM8JPuE4Zdhw7Hdkdeh+5qrQQgdth6Xwj/l?=
 =?us-ascii?Q?q4/pSUlRU093wCJNgZrH/8Gswkxoua1wvGW0rWtVsEZhCJkGpWdEAg4iv3B7?=
 =?us-ascii?Q?Hccq4526ddA/cD7hBm48tptUdSDQpn3AaWtMXoEro6VPsDE8ICvN6WMtpasV?=
 =?us-ascii?Q?wWBodI4T7CKSG3w+UBDTSRcQRzrXdCSQygEtC0YKdhdc2fW50nwk0SUFITNn?=
 =?us-ascii?Q?27yZRM56XSPBLTGr3ese3Bb5xlud+4B26vPRqv66D968FrdYruZxcNPMj0Y4?=
 =?us-ascii?Q?yi4DptNr9cqwzKfqsQuFGI9rA8UrZi/HdlygN68YBwEzK0MGhaufAMga6dPM?=
 =?us-ascii?Q?vGx8V/3n9uubujWYDyb1blxNxVAStCzhkPjsDhNRuuzsOTpwo+mbz87Bj5Es?=
 =?us-ascii?Q?W7lBL/rZos7Clm7jq+t11PRS6qR6jTjj9I2xS87SLiBH6MoSQxvrlcakkNin?=
 =?us-ascii?Q?62rxZVRWORAUH1ZKEb2J1EMTVeFi6AgqdnE+XCxLCtod4DZEEbTA2b2W2Z2C?=
 =?us-ascii?Q?0jXq1gL1hZDyp4rokdOFXge3FeVRkmw3Z4xYrStZ5x7Gw2XSfJDquLHOPfRf?=
 =?us-ascii?Q?RKFuQo9R4lKhvxpKOM9zES70WfI0HDpuqrfBuKEk9Mb/PZxcnGotAjBVMQzk?=
 =?us-ascii?Q?9t7NpyHsPaAJ9yI5PqMY7sXimZGuUz2TUM0e+YPc1l+ubkhXLwcLe6sJvzp0?=
 =?us-ascii?Q?/yizrW5tC/k17G3WtSn9gCBGvclFzbwh9qf8qxsLTpOPZqi19LpeMF1ewD8l?=
 =?us-ascii?Q?pKKz2kjWqy1h2Ly8b1llpg3Qhmdr1U9O9dgRxSFbtTaD4V/fH3LhIYEcHA48?=
 =?us-ascii?Q?gyO/Uxrz2VPGRITVorwRIqYpakTjIH/x99yQoYAkC6NJdYhi1zJ/vrt5aLdG?=
 =?us-ascii?Q?13TiZAEZlesQ4aLyM/ywAt3Ybop6afnKYF3caOSvV5Y0q0Ew/2xWfLwkkRu5?=
 =?us-ascii?Q?e4hP8fAeRUjk2ADnNyscMWFDI6cVHqWJ+MJEmRBfO2CSORbBj8oJBbQScCG4?=
 =?us-ascii?Q?ZJvkbuTHFyMSEO2fx2ESfXO/mSRCsj2evjQ1ICSMKvuw/7Av8LY073YHilG2?=
 =?us-ascii?Q?nWBI6dvZHq91/0gw/hHzVaPKiUTtRAWFDIo7AHcl3YdkoYn/Dpln9lJJ39Z5?=
 =?us-ascii?Q?d8Wl1n+U/iUaw2C/eDvHduJX/a/ITxUSA0zbBEk/1UOI7bQWAcjsRMy59grT?=
 =?us-ascii?Q?WjhYDyWbdb7+dVnzJWYGxMiuQEtvm+aex9MSc4BbdaI57Z/4x+flilJ0ZiDx?=
 =?us-ascii?Q?C1FBKub6ocPDrNEZ8lEOr61/BaY53EoR37RiyDMdLvh3Xd3jOc7bChWNT80E?=
 =?us-ascii?Q?YzaeclBimcYdjLibEh1/ux53hr2ARfE5cj0D+2iuS+0/6r0Ek2vwcB/jowks?=
 =?us-ascii?Q?rULhDYOVdOWyfdWAhGtwRvaQVEtXFt3XEjgMAtZ16Gsie0uRxSSOUTXZQTk3?=
 =?us-ascii?Q?fAUTrI4b8ZMbMwYbnh4fvwcfIzAVOLTzcIQ8+UMRM+ZnQSCRYxDtAKmQnVeR?=
 =?us-ascii?Q?zz0/C6njszC+KKCSl+DvnHL05O2FznjPGo55YS2YZhPABhojiFHw+3wbLclL?=
 =?us-ascii?Q?m3j57aU49O4EjNLp8TsPF7GqMjlm08g+2O8NG7KVflJxx4uEcjVRluxXuh+X?=
 =?us-ascii?Q?GasyfKETMm0/W1T8/kCDufVUxy6mcPvOMiz3nI9mKggmrql2LEzqJiCWca7K?=
 =?us-ascii?Q?yxA6dHQG2ppHK/BJ8PXlB9mgvdA5D4r2fvPu54dzdNpQPenfx7o0QiinNNUn?=
 =?us-ascii?Q?4V74U1VZliDbdb0vbyUehv2oCcoaxsrqpeb5P7SFcwCHjuoD986B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82fafe4e-0825-4924-b954-08df16bf1fbd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 02:30:23.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMb8Ih9vjfl4x/cmBajKkIRh/5eOZiwRPWhiH7UmUT6IElM9BYI8azuF4JOoXEt9HuqUrTO29/0C+jL+mDCEss9TgbByW9zFU3jK731i6fTJMmy+tpZiEigskTocEch4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9596

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit the assign_bit API.

Done with Coccinelle semantic patch:
    // set_bit -> clear_bit => assign_bit

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        set_bit(bit, addr);
    -else
    -        clear_bit(bit, addr);
    +assign_bit(bit, addr, cond);

    @@
    expression cond, bit, addr;
    @@

    -if (cond)
    -        clear_bit(bit, addr);
    -else
    -        set_bit(bit, addr);
    +assign_bit(bit, addr, !cond);

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 net/rxrpc/af_rxrpc.c   | 5 +----
 net/rxrpc/server_key.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/rxrpc/af_rxrpc.c b/net/rxrpc/af_rxrpc.c
index 9ab0f22c881e..61e785b0048f 100644
--- a/net/rxrpc/af_rxrpc.c
+++ b/net/rxrpc/af_rxrpc.c
@@ -722,10 +722,7 @@ static int rxrpc_setsockopt(struct socket *sock, int level, int optname,
 			ret = -EINVAL;
 			if (val > 1)
 				goto error;
-			if (val)
-				set_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
-			else
-				clear_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
+			assign_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags, val);
 			goto success;
 
 		default:
diff --git a/net/rxrpc/server_key.c b/net/rxrpc/server_key.c
index 3efe104b1930..726d6f34dd18 100644
--- a/net/rxrpc/server_key.c
+++ b/net/rxrpc/server_key.c
@@ -205,10 +205,7 @@ int rxrpc_sock_set_manage_response(struct sock *sk, bool set)
 
 	lock_sock(sk);
 	ret = !!test_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
-	if (set)
-		set_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
-	else
-		clear_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags);
+	assign_bit(RXRPC_SOCK_MANAGE_RESPONSE, &rx->flags, set);
 	release_sock(sk);
 	return ret;
 }
-- 
2.51.0

