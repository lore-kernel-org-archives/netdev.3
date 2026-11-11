Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794417002;
	b=wYKaW4ZeMRyxblnybL2/v24cXQNg9iRZ2ksM5R6ReTe1DqHcRleKjfyVUfGrG7BGBZoY
	 uyMVPmvBQLYskWaGtCW0imWkYdUil+qTixyG4tmDVk4ie7kkw1u3h4ZjygUSSaz0De0nN
	 7zQsC0caExjw/u7bfRVwf05XQT9f62vbLcsn9jZDXei1dX1B/QRSa0XlOgF7KXqA3tflU
	 kuIjx/utl9Ykiwkgv92aL+K7E8X0YB/lQ/wS9Mkh7lGHqkeqyAXGGa3lw+EN93DRKR7lq
	 845975BDRR3xF1OeYZlNBqFAqx5BzR5UeTToXQKrCEEIXOvARdR7HG/DHk2dyXyhLcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417002;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PUu2/W9twgztRtcI6TM09Mt5HgO01QueH6PjqgeX2P8=;
	b=i8qFSuT0FTtI3Z98blQdPGi1bQpOx+VK1v2qgNuTw5xRSpC7abWIxH7KE+i+h3H+OE3f
	 CJHGa2+xHOxrLUKTNFXoYXKJSUhaSW6UWulFyXf8iBx01qDvnxaIiSd716mYj6owFu/+k
	 ThHHicpLy36ZI2D1PFM8+UV3ymf6M9UJVpYhNbmkYgj7LJdjaPdHnRNHMw61SGFCK20cV
	 B0utuiu4Jg3qnnuH7/MImr7CVKBgyJP6QitnMQH3w30Sb6oC3uifqUzfQImcxHn3/dkjB
	 NMqp/THKOhcbuEQvzqnBxat+KVQWQp/iYIBGhQJz38WD2+gFoZuEEkk/kR0UnWbutow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FBf2CGjJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.0
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69282606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69282606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FBf2CGjJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KF/+XIWsEtvzfHq8/8Yb1gZ+RCXHIO25hCMIajIfD8XWXcM5MCkwHDWZvAgwfVOI9yGjQvo3Imt6Ue9GREQuvvnLnCBSG84qAo3FYW37WsffEDOwM6FmmlGtOJRBjZ3+DfRuqI2678hYxtXxUvNsq1yK5OTuIvlspUAv29T7gGxwpCe8juY+Op8YOR4UFSsGr/WcjxFlf4xbNH7IaT5HIktZBg0yFnWp45mFkHbsDGVLbpJfzd/7TsVNeNXFZPE6xkP55FoBzlPPC79IOkO614EN7F9Ac3ow68PA5K2jy1ye4ezd1oJrLnAKgvBRmDRqwSzdKxkVfWSAr05WunSDbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUu2/W9twgztRtcI6TM09Mt5HgO01QueH6PjqgeX2P8=;
 b=Y2nUoQ/Vv9xErSL16NsVfplgcp9cgrwIeRM2QvyBkI255AKELR8fMrCDAIo6R7tdGzNIG6uTQHC2wBUaGvbVx394QR6gwCViIxCRqWxxPnS3Qr/stEAPFaIh8sTAUET6RcoPdcymaCpGikx3ZyniN4hYXwNWAr88w3SrOlpNYgBiArG/sLZ3jaKlOWjsmqkYlBldJQxcYdoLckhOs2OWHkPhQy9JnLUDh1KGn4o6jTO2UiQUjlgPOMk8aqj+yoS5k5OoOOkVKTKlgufC5EjLGiiNdEruDo7F6rZITdkAHix2uN7WYM4kddisSm+Te5OsCkgoEXVwzOSXAqlq4w+oMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUu2/W9twgztRtcI6TM09Mt5HgO01QueH6PjqgeX2P8=;
 b=FBf2CGjJXUatOe/MULzL3a0nXQl3OnE0mzCcIw4/zONxjGmR6DX5B+Syx0c6tEjiH5S6YYO2hA4dUlCI7dOl6rSvUkTpNxq7nA9ID+WDOfIF3BB5fSCZcSsbddKffUZ54DI3wGXiWQBOvFUALEf5gPYZIu6ntZ5OEOnr8m/tuwMgi8L1eJgIeOOY3jJ5viPeVliQqpM2tJ3PjhtvC/sQbxGBElrMpj9HF9+a1mRcVh3rSTRTNl6kolz7Dwev7wT/h99xT/FraIac7/4vvsM5KM3Q6Op0AMWUc/8dEGzkPIkIj1iygK4gPcbfjgF8kJpA4c02Ps8p7c5jOykJ0nJ5gQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 17:09:58 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 17:09:57 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	petrm@nvidia.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next] mlxsw: Disable LAG collector when requested
Date: Wed, 11 Nov 2026 19:09:25 +0200
Message-ID: <20261111170925.2809513-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0017.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::7)
 To PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: a9b601ea-bf5c-4381-cbe4-08df40169c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|10067099003|261102123227099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	xgtCQ27sQt9hww02IvCxNoUDMN1mSFKVJHfzqXKBrFoJb1GRKAy13gRgHDC52eeikGfCUntNCg2d63vlFjcUBmVQPsjGXOpGyd3Q2pBmw8hB+7XYSlm0bu4v2B9HCfmReViucYTL4v1xxWmtAo0165qwnQdH2oZwn4h7b0qopKrK9TJP2uBMziVTYNKW4E6rBJcQqDAbBMQdVp7E+ctTFxmuPjdTnw99oSAPXr4QW2lsEMAN4syoVptdDEZWR3/E2UBuWQ7I/0fJkqaLl4ySpIUFkK6XvEeim2V5NWYqZCBIFHBUxbrArL5a2xjATlz3CWy8Ce7hHKEr9/fSXP9FXU99a+nE6wZSI8LkbaXu0vBdsT2ZkMJnmOrXS4q3kHXB1tQtVt362mPxBe2Axk1bRaXxSMw4LPZpgWthjGEDCnfz+/XD1OqKrPHpzjo3T0+frqShIHqVBPWjAMxlzxr6hvBdctaVR/elEy6+Yt66/wFCP3c44wDkuqOPFxlk2kqur6Znr8Ia5Vot666QFmWZ3tmPhPp9E2rwqA5pouSGcDUeA9gXiCdxj3NwvLbq4z8dYeM39vspOjHYnB/Bs3f9USTyQBze2nEOb1ImeTFPpi07tGpaban1pd3gQrTMMIwuD2XnEeoxFq8S/elczvX9NQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(10067099003)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ACzFMjIvfRZB+IvlpikggCx7zFjtlbBiDwZj+BvoshC7vrTr5Zy0kloBrNsv?=
 =?us-ascii?Q?rTJk4aE9PEz9fpISXwLgwCRmvbEyBOAv2wWv2Bs1dMBYOsIploE/9dZKvCbB?=
 =?us-ascii?Q?rNjRXp6IOPN+4JiH1CIARE/LDrEqYYOm4rl+rW/E8R2x5NBj5NXq8WwKNik5?=
 =?us-ascii?Q?kudTArGD/7G+V0mZxiKLkknuOXeMfZ2b/6MbX40lV6+I+41UZA1yGoIWLvqi?=
 =?us-ascii?Q?EQTvDRo3MXf4+1n/VDszgQx0GRLIuCHxmMzEAJ+8wn23a0OXuC8XhLLx/Jik?=
 =?us-ascii?Q?T8WK1lRvRH1zle7wso2BVZlGeDKAKfoZQFgMmldljDd/AZGXHOqLYN6R7MQG?=
 =?us-ascii?Q?J4NMiG2C5WNog97fMyF/2iLH3nxXk3cOCBXd6g5V3HYhLZVoeAozcH7ke8sC?=
 =?us-ascii?Q?AcPkhBONj1qWj7Y1zXaTNOE3roHg3yVOK0KaCGD+ApPTvdEFv7/y+XFDWw9m?=
 =?us-ascii?Q?qzkxlvVqJgzW9gfomyW6jeJKOAiOgokabIoZAebqNFYij7AGEbCHSRJFDfU6?=
 =?us-ascii?Q?WfWNNAsripmd/25NDrEiqXFQovfkSfTLyERro/BitI3RPSDgT2zSifgYvJIO?=
 =?us-ascii?Q?vcW4VWfbOgs4m/B/rLRUIR/gmC7M2x31bgt0S0tIZuIjbBWoZND6JBJyC3wN?=
 =?us-ascii?Q?OAdBMMCh315U/0gct2JggbWq29hp5FXYAv2M2XyoSo6hbIg1/dv8BYlSr8fk?=
 =?us-ascii?Q?+w7wBkAtoNOzZxAT6UcPEPIxaNERogBskH2L5jGf/np34jdeZrwn3awWgIIB?=
 =?us-ascii?Q?nVvo1Lv9/qbxkAOsBiQ9o5yQeyV04TMMv9pjn+MMDnLw3xcgXKGu9wDNQeyR?=
 =?us-ascii?Q?IHd5xnwAtGDdynJEx48Nx+Jba+aMapVApFljStYEs13QUQkkUhjNeP5AKhrz?=
 =?us-ascii?Q?UZkRBvKSiTsRWEgv5fSU+YUqCsV5DGN3RHiERZWd/8ZJK9Reei7XzZ+wGw6k?=
 =?us-ascii?Q?unPJrpomHsScKgSiabQF//5iNl4nd5WwknOpz8C+/ce/+hKOjNMbcHUyj6qI?=
 =?us-ascii?Q?HGWH0a42jEmcDqlOlUkeaVjJl5RWlpToNYusR4UUm3mvhPhJ6sIN6xZoqaoO?=
 =?us-ascii?Q?TY0A15BYZDFusTP+yWoX4ah5GWvdUZ9UvN+mAkUSATUeeT0gT8+tgBiXtf0p?=
 =?us-ascii?Q?+6TuEftf8oPNnLQNQQdE1GuG7hxhWnV2+0Z7iq6OELL7ysLDBrcP+wZXQgsL?=
 =?us-ascii?Q?7ImRZ7Of62We+S+jFhgw9iqY9greM2sQ/4lLTJsBQyeJ4fb4geZWADjTXXNz?=
 =?us-ascii?Q?YSAaV9q5qNNeK7osADyZ4lJ/xfFPJy3LJ/XBNvaBRX8+YKq1UpAxTu9DCEgJ?=
 =?us-ascii?Q?SSAvGJggyGAQizfVofKsOa4S+PbksxQoHmbvRknuZbxWMcMxHbKYKag0nQyz?=
 =?us-ascii?Q?iIRUUPZtvRNO2Xxfor94549VP/SSXU2+y0+/UKwINUYEN+FXWjfB0ZYj8i33?=
 =?us-ascii?Q?XoDhyyqkDccaAn2UcAXsomsyAhMo3CVSfH/KIXIXSLYNmomW+N6bvA7omSUq?=
 =?us-ascii?Q?wlrhuoS+3Ifz5xtOqRmYJJPqY4YS4dFzz2ax/VYUB9R47atoR/CuDnAguo3N?=
 =?us-ascii?Q?5wcqWJN/rHLIZiiSF42kSvrnmtMUxyncxv8dfK113VoIDHhCvVvEzSURIrAz?=
 =?us-ascii?Q?E4xUNNZ0uBDs0RJzSR7+pTEH+0ksmpWtH4KUkVWOEe0Pcj4hpjANebAv5DVc?=
 =?us-ascii?Q?4cgGerI6RoVu+aISVjzy1ryVd+UgamgHv1PiEthHbxo0AQ24?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b601ea-bf5c-4381-cbe4-08df40169c6f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:09:57.1992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 523JNGrkHSwOB5VcQI6smq1jojNL52TRJH2gErT4FZEJ8puiNXBzxpnqknLKVrnV+T09xux8UL8YbV52heRaOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485

mlxsw_reg_slcor_col_disable_pack() packs the "collector enabled" value
instead of "collector disabled". As a result, once a LAG port is enabled
for collection, it keeps receiving packets even after the LAG master
disables it (e.g., when the port loses link or the LACP partner falls
out of sync).

Fix by packing the correct value. Packets received on a disabled LAG
port are now dropped, as they are in the bond's software datapath.

Note that this does not fix a regression (always broken). Noticed this
while working on independent control support. See commit 240fd405528b
("bonding: Add independent control state machine").

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/reg.h b/drivers/net/ethernet/mellanox/mlxsw/reg.h
index 01fcbd1c8d01..9dbeabf5536d 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/reg.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/reg.h
@@ -1491,7 +1491,7 @@ static inline void mlxsw_reg_slcor_col_disable_pack(char *payload,
 						    u16 local_port, u16 lag_id)
 {
 	mlxsw_reg_slcor_pack(payload, local_port, lag_id,
-			     MLXSW_REG_SLCOR_COL_LAG_COLLECTOR_ENABLED);
+			     MLXSW_REG_SLCOR_COL_LAG_COLLECTOR_DISABLED);
 }
 
 /* SPMLR - Switch Port MAC Learning Register
-- 
2.56.0

