Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793591000;
	b=QWdOiTZMR5l1Ug58pgdFgHun+4AtIlfdm+nCHq+CGqgPCewr10aabyk/lnJUYnjygIeN
	 8gvImhN7OhNvd1K4/xcuWgXXIID0PwVN+oIvWSN0EyqyvaDEDA1KZtB7CpcwwE3psBvKR
	 b6ETpzvYjVQabq1op84m8g6trckJK1PaCviIODp70ucNiyFkbnfOjVGlv9BDW8TTDl2WL
	 xw+1ckOHExEZkg9XK718UUo/GNu9b0O02NfPXNWXRYIRbJDpv6TIV8FZcEAT9z1lq1ck5
	 RbUr1vleUrVXQ7F5OEvM4MJq7EnbC9WFCV2pJi0Z+4UbW5+9gm8GECQkDuL/bMaSl+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793591000;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=trFHP30XjYbpuxY1GI4eJnr4LdWGDqweAGQwRl+HLwQ=;
	b=c6cZyXtenxzVdHaS+yTJYx0ovx6YyNiFdgRVXm9o51iIJbAZwHn5zJ9e7+yXBtkWzPNI
	 X/WHSRwXSt+T8PIwjl+C1QZBS4W+udOSWXWe8zrK4xN4bTjf+AvHt852ei5Vro/riRDmA
	 YosFsT9fhco9m1B+gOs3BDaRFp08PBwuZAYuQIuhoupcvFSzqXSftbinsehxs7neWBCdt
	 T9dT80wONDhHjZ0Y8tkjQTISD9sNwBGrZ6MTNRBPZi4986Q5kqLYit7jfvRTV6hBWvXwP
	 EDsORU4VbMYBGNYj2A9ZEETe10TCpE+Uk79xK0KPHyCihRxUtlRa4CTqTb+euEMO3FA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=ke4rlQIt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.58
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B3606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 03:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 094B3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=ke4rlQIt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSFCm+Ct9tTRWkSX83swF/7XxsLzIvhDSdwzAZqSYUA+nafCGc/JjCvhdIcsyiKeBsPUwwvDbIMFhvdm1GyXwLe2AiSBkq7ZKPiutAbbUrzV4j8cApw3NOV4GX4Q4tN/HjA3NRo6z34IHcmoWcr3uZrPPsu+Ax46SNbyE2NYb+ciJ7mNilBIo2j5lvkAad1VQlm4uBNTJVE+iW8cc3iBA9Jg8rlNJN/pPV6HQWVWzxWxQQyr4HHOlMc+ghyInieNlPoXc7OhJvLuZ9uzNARnY8LC5yjI705/Q6fpNWh4XPpEZgjGD3m2nTMoR/aEt4xpK8Zt6dzbzT+YPs7BdoMdXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trFHP30XjYbpuxY1GI4eJnr4LdWGDqweAGQwRl+HLwQ=;
 b=skEgUcXHzmqA6RGHploKO3RvB/kqRnUEFGJMJ8y+7F/RpZk+K2pemW+eLUr2PW5uo1WHU6AkGtgeGYCeH8QkAGT4Y8JUaBeOJulYcwJ8+LvboeWyToYr4TrfxeZDtVKxzvPaBZaonTVCjefzpKwolEwXeqDUKB0TYAVhq/8Owpkg15/nC0nUMOBrh2hZqwnINFkEmTf98Eo1ZV5o0p4rK9nesuLeGFnErk1ex0Byg32c9WIxwvy1ExjwqwnV6B4eSNGgt/WEYPVrWLhhdP5dk6kAD5d/WqQNXnl/BH5nYSRJI7izQSdvLxXWKl4DNqS0MOd0RK2IEDY8okVJCTfg8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trFHP30XjYbpuxY1GI4eJnr4LdWGDqweAGQwRl+HLwQ=;
 b=ke4rlQIt2U5g7Dx8+vSS+S4gzoHYsjRLnrBz/58dGs9tUMBSFmSdgYRw3xsiKARq7O8gDNa2Pim1CdV51UH7a/UQfmRTUUBpo1Y7XdHIhVaHA7tGqcIRXI8Cg1UspgR8RxzY2aLruFI29mMvun/Axn8jfK7fXyumgmbUB+JnX4xUSYHyAixBXl92wIA8qAqNgSImuMzqMztYzEKNxPv1WAsrQth9zdSOzkKZ550eiNd5Np/d4mL9reYxMLrBuK6JEPOBt4ROtJw66ifmAxeiqY668E26lo4ywfKn+fs4Jua9ey/HPBypBBagukfELwWmPO0+mxjHYuyS5yHKdG8sgQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by PA1P189MB3491.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 03:43:17 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 03:43:17 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>
Subject: [PATCH net v2 4/6] tipc: fix missing link-up event on memory allocation failure
Date: Mon,  2 Nov 2026 10:40:30 +0700
Message-ID: <20261102034207.10639-5-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
References: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:17e::23)
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
X-MS-TrafficTypeDiagnostic: AM7P189MB1137:EE_|PA1P189MB3491:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b241ad-2f50-43a9-c59f-08df38936ea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	BKU7gUl4ARBlEdn4KNmJeRTmG8MB3SWjJqpNCbUlXdhzC7I2FnuleqNDufnIydHCJ9bpIveolGz2nHYleuHnsUQBK2xm1WvEhHk4hkGjmkE5Lyx9iKqfllbodpvsnA5Cdg2nFjIK63tYvmGW7j18WJXOaef63B3JdjO7tCG24+WUIPeouXiilfze/m4wBhXkPZcxAJ1F7nnY5o/8UfP3bUO1JqdydvGxb8zs1dzPX/wr1ULGg8PFHorVHqqERSJ8WnHoJdAUfi1zgaGfbaxK5cuEQUI67DA+VUpjutq5SqMWA7aokyPq95DEAHUSHEfZdQ3iJcZn0DiTUMut1HoyiQideRAFFuDXrd3wett3iwRdvGU6lyelF46Fln5UOTY/1A4KEKV+xhyKYfxWUCEo8cSu21I+gs+hlDGzct5J1hVcih4yE84l1cZqa0kF0Z5Y12Xetw+nZu7zjFBOAVBb2wYjUd25u8lroU8UQ4ibH753o9EFxuy/3/jhgYofFVT+TDvIccerXhuTRFljoniWp8mM6xMRrC1n8uoDyoXHjSFncWZqO5VN3a84Vyw2oySm2sqQ/xy2EQ94eZKYchO059xUVETSFecfqQ9evGIn6hkMjEgpb+JjToXkSKzeOrmf1LdkJM6nQe8yXaXzOqjrhThF3prLpKHvNDcrNGUbPD0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jrwsGuPwQKVChxMSKgxHzOwcyxGqFxiyGRM4NhYWKwrM+ksMnQMOR2oXOIA3?=
 =?us-ascii?Q?9crSE6aaER2mVEPHLz3Itnff8kFlFyCC7nI6dU2NOVfdxJ8LDozQfoTmixph?=
 =?us-ascii?Q?edMaYzQ67ivo2L6Hg1DLKp8fQM2ptbvkqOkhkxt7w+LEFCJEs66P4+37SORE?=
 =?us-ascii?Q?MaEWvse8K4K1+eaIrmYkk23VeqU5xCRebyWgj93XkJqM7YPWvRNY098lwcr3?=
 =?us-ascii?Q?U8e9wjiQaGGxuxL/LAOamuPLcSGvT9OcI7QFzAs1qsMKhqXP1p/Lv/cjqwO9?=
 =?us-ascii?Q?y7jhnuaN9lf+I42aa6+gfnern/M9N73IqOI+SC4PDCq+hWWDinFmI7CcLoB8?=
 =?us-ascii?Q?3V3GDtAOfskhspkQLudAWEp3BsmFpi53uuPWh6SadNlhq+XdG4+9LzkUgNC/?=
 =?us-ascii?Q?H4oCqPd3byhnSXk5M4oEkqGoEZhBGuLRhEwXswtokpBMp1X+lhnXJv39iZm2?=
 =?us-ascii?Q?P/nbX7bVrwvzg6y4kTObefxikBKQY8ry5YWyRv2Nz6aGZl9likMvKV8wwU6k?=
 =?us-ascii?Q?oQCw6T64LD3jXo0T+YxZUGVjEvzwJ7+mjHuLjrlSRAjejXiJPJ2rf1U8ruk3?=
 =?us-ascii?Q?KDoC4Y/73NBHHchZaDwXM8huTk+izGVnRJQcl2vuJm5oJCFxekpC9OfEAE6j?=
 =?us-ascii?Q?FJ2HpWHXOoF3f3Z0bcdB3LJwLRdVQSBvIJahFYpQUNYpSpm+R1QNVfSZgXIe?=
 =?us-ascii?Q?+cyp9W38Z36KdMJi9+386RTdXjqZFhXIiXLGM/cPgfJZPKWpqrlqyBc1xyQu?=
 =?us-ascii?Q?9xP9Kero1QegC6CSw3D3OXyvXU+NT7Rv7VVC+mEqQNx4awIh3gwVuJlReIGb?=
 =?us-ascii?Q?+RFUg/OaUetNtbSuTh30mQHvVb4m3sr+yOqR2NtJ1OcOstAgIYoDIMAbAYs8?=
 =?us-ascii?Q?AN2kpWwMdl00LH34YVepqnS9kIcVYki37OeKT8gPkSAl5Ee1wX6oXnUGWOZ2?=
 =?us-ascii?Q?VY/bwQcoEdG0w+9a2eVF/dXRs9nDwY63cpqBwPJYlZ5ReYyMxwZtKmOKVRXj?=
 =?us-ascii?Q?HFQNSimvtNB1i9mBE7eNZamg18hFutSx7I3beo1ySACo0OejwEKB1m6b41gi?=
 =?us-ascii?Q?8DEVmmUKw6NivkZbyTXbMBWyw4FUUkK6+v8Z3C9qiWccqnJdz8N3RY+5IZOZ?=
 =?us-ascii?Q?qnv9AhZx39bQLJ7XtIhP2EzDNa2KeDYNZu079rJhmvNPRM4OB2b57Vnmy1uJ?=
 =?us-ascii?Q?nCGpB3UUKAJDV5aLFz+Og6t8iloYUpCirowbLYzM9yhfbYoMlC+5GH/KOnEy?=
 =?us-ascii?Q?GNQKX98OuXjBqEFwHC6wOpbxUr1FJuEF2P7ClDIkSxoAS18rRaHBmfCyGzjI?=
 =?us-ascii?Q?XbTIsTCxyevKTnjfwbxwbYgnQUKoeHHt7NGw7mXX7WpiU3Mcy8oHjhMr4OnQ?=
 =?us-ascii?Q?3LgntXx87yn9wEU+pff7WPz3bX0JTTXYn6kGXKxLrgvVSCLVLZQa/qUa8Y3r?=
 =?us-ascii?Q?Aa0+11Ak5U/Y+nvfwM5KuZv75BCbX85a0BjBUrnWgTwkz+DqUuiDj/UsrrA2?=
 =?us-ascii?Q?G6EKDKXlpvjmiUjgLF6nZN59nXsxMfQ5Ex0NVirl5h4NS548FKL3+isA4nhC?=
 =?us-ascii?Q?COqwLieyTfsq3w5uDjhC49Eg60Uo0mClPORWAhpA5CuvY7PTv6R4HP78Exyl?=
 =?us-ascii?Q?t4WKN/lohV6c61vWjPazQA9ji5aQJjW1HawY/q5NSNmhfVe0AIBGGAbr+vNA?=
 =?us-ascii?Q?pH7NWy3oP9co7g8Rx2qj5dbgIfx0Y72NSht7nU77BarymO1Z1JkSDykdFeg1?=
 =?us-ascii?Q?biils+gIU1Tg1Iv2Umvu8e7aVLy1ph0yvnwhhDpy7qwUMePD6EPTVHaaTSOO?=
X-MS-Exchange-AntiSpam-MessageData-1: g5d9kfZvA2q3PVedjZUR4PQ4CrU88s1O15g=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b241ad-2f50-43a9-c59f-08df38936ea7
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 03:43:17.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XoGidsDa1YhnsWEjkjkEJeRVqh5TcfVa5vpi2JvcctH2sLvHS7aMNrMgAlvm3nRi/KxcMLDxE5aquxGJbEBemoEvwcarnrjXFzV1VcFbLT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB3491

When a new TIPC link comes up, a protocol publication of type
TIPC_LINK_STATE (0) is created and inserted into the name table
through the following call path:

tipc_node_write_unlock()
 tipc_nametbl_publish()
  tipc_nametbl_insert_publ()

User applications subscribing to this TIPC_LINK_STATE event will
be notified when the link comes up. However, code inspection
revealed that if tipc_nametbl_insert_publ() fails due to a memory
allocation error, the TIPC_LINK_STATE publication is not inserted
into the name table. As a result, user applications are never
notified of the link-up event.

Fix this issue by checking the error code returned through the
output parameter of tipc_nametbl_publish(). If the error indicates
a memory allocation failure, reset the link so that the
TIPC_LINK_STATE publication can be retried.

Fixes: b97bf3fd8f6a ("[TIPC] Initial merge")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/name_distr.c |  2 +-
 net/tipc/name_table.c | 43 ++++++++++++++++++++++++++++++++++---------
 net/tipc/name_table.h |  5 +++--
 net/tipc/net.c        |  2 +-
 net/tipc/node.c       |  6 +++++-
 net/tipc/socket.c     |  2 +-
 6 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index 1dfe8475a75d..22c29b187daf 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -299,7 +299,7 @@ static bool tipc_update_nametbl(struct net *net, struct distr_item *i,
 	sk.node = node;
 
 	if (dtype == PUBLICATION) {
-		p = tipc_nametbl_insert_publ(net, &ua, &sk, key);
+		p = tipc_nametbl_insert_publ(net, &ua, &sk, key, NULL);
 		if (p) {
 			tipc_node_subscribe(net, &p->binding_node, node);
 			return true;
diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index 962b82956032..0b03d407242f 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -329,7 +329,7 @@ static struct service_range *tipc_service_create_range(struct tipc_service *sc,
 
 static bool tipc_service_insert_publ(struct net *net,
 				     struct tipc_service *sc,
-				     struct publication *p)
+				     struct publication *p, int *err)
 {
 	struct tipc_subscription *sub, *tmp;
 	struct service_range *sr;
@@ -341,8 +341,11 @@ static bool tipc_service_insert_publ(struct net *net,
 
 	spin_lock_bh(&sc->lock);
 	sr = tipc_service_create_range(sc, p);
-	if (!sr)
-		goto  exit;
+	if (!sr) {
+		if (err)
+			*err = -ENOBUFS;
+		goto exit;
+	}
 
 	first = list_empty(&sr->all_publ);
 
@@ -353,6 +356,8 @@ static bool tipc_service_insert_publ(struct net *net,
 			pr_debug("Failed to bind duplicate %u,%u,%u/%u:%u/%u\n",
 				 p->sr.type, p->sr.lower, p->sr.upper,
 				 node, p->sk.ref, key);
+			if (err)
+				*err = -EEXIST;
 			goto exit;
 		}
 	}
@@ -478,20 +483,30 @@ static struct tipc_service *tipc_service_find(struct net *net,
 struct publication *tipc_nametbl_insert_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
-					     u32 key)
+					     u32 key, int *err)
 {
 	struct tipc_service *sc;
 	struct publication *p;
 
 	p = tipc_publ_create(ua, sk, key);
-	if (!p)
+	if (!p) {
+		if (err)
+			*err = -ENOBUFS;
 		return NULL;
+	}
 
 	sc = tipc_service_find(net, ua);
+
 	if (!sc)
 		sc = tipc_service_create(net, ua);
-	if (sc && tipc_service_insert_publ(net, sc, p))
-		return p;
+
+	if (sc) {
+		if (tipc_service_insert_publ(net, sc, p, err))
+			return p;
+	} else if (err) {
+		*err = -ENOBUFS;
+	}
+
 	kfree(p);
 	return NULL;
 }
@@ -760,7 +775,8 @@ void tipc_nametbl_build_group(struct net *net, struct tipc_group *grp,
 /* tipc_nametbl_publish - add service binding to name table
  */
 struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
-					 struct tipc_socket_addr *sk, u32 key)
+					 struct tipc_socket_addr *sk,
+					 u32 key, int *err)
 {
 	struct name_table *nt = tipc_name_table(net);
 	u32 max_user_pub = TIPC_MAX_PUBL - 1;
@@ -768,6 +784,7 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 	struct publication *p = NULL;
 	struct sk_buff *skb = NULL;
 	bool protocol_type = false;
+	int error = 0;
 	u32 rc_dests;
 
 	if (ua->sr.type == TIPC_NODE_STATE || ua->sr.type == TIPC_LINK_STATE ||
@@ -788,7 +805,7 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 	}
 
 insert:
-	p = tipc_nametbl_insert_publ(net, ua, sk, key);
+	p = tipc_nametbl_insert_publ(net, ua, sk, key, &error);
 	if (p) {
 		/* Not count node state, link state and topology server types
 		 * so that maximum nt->local_publ_count does not prevent
@@ -798,6 +815,14 @@ struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
 		if (!protocol_type)
 			nt->local_publ_count++;
 		skb = tipc_named_publish(net, p);
+		/* Local-scope publication is not published (skb is NULL).
+		 * For cluster-cope one, skb is NULL when named_prepare_buf()
+		 * returns NULL in tipc_named_publish().
+		 */
+		if (!skb && p->scope == TIPC_CLUSTER_SCOPE && err)
+			*err = -ENOBUFS;
+	} else if ((error == -ENOBUFS) && err) {
+		*err = -ENOBUFS;
 	}
 	rc_dests = nt->rc_dests;
 exit:
diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
index 7ff6eeebaae6..3a15dcfcc2cd 100644
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -126,13 +126,14 @@ bool tipc_nametbl_lookup_group(struct net *net, struct tipc_uaddr *ua,
 void tipc_nametbl_build_group(struct net *net, struct tipc_group *grp,
 			      struct tipc_uaddr *ua);
 struct publication *tipc_nametbl_publish(struct net *net, struct tipc_uaddr *ua,
-					 struct tipc_socket_addr *sk, u32 key);
+					 struct tipc_socket_addr *sk,
+					 u32 key, int *err);
 void tipc_nametbl_withdraw(struct net *net, struct tipc_uaddr *ua,
 			   struct tipc_socket_addr *sk, u32 key);
 struct publication *tipc_nametbl_insert_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
-					     u32 key);
+					     u32 key, int *err);
 struct publication *tipc_nametbl_remove_publ(struct net *net,
 					     struct tipc_uaddr *ua,
 					     struct tipc_socket_addr *sk,
diff --git a/net/tipc/net.c b/net/tipc/net.c
index 7e65d0b0c4a8..c4b274320c9c 100644
--- a/net/tipc/net.c
+++ b/net/tipc/net.c
@@ -138,7 +138,7 @@ static void tipc_net_finalize(struct net *net, u32 addr)
 	tipc_named_reinit(net);
 	tipc_sk_reinit(net);
 	tipc_mon_reinit_self(net);
-	tipc_nametbl_publish(net, &ua, &sk, addr);
+	tipc_nametbl_publish(net, &ua, &sk, addr, NULL);
 }
 
 void tipc_net_finalize_work(struct work_struct *work)
diff --git a/net/tipc/node.c b/net/tipc/node.c
index d84b0274fefc..d99049e67033 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -402,6 +402,7 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	struct list_head *publ_list;
 	struct tipc_uaddr ua;
 	u32 bearer_id, node;
+	int err = 0;
 
 	if (likely(!flags)) {
 		write_unlock_bh(&n->lock);
@@ -429,12 +430,15 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 
 	if (flags & TIPC_NOTIFY_LINK_UP) {
 		tipc_mon_peer_up(net, node, bearer_id);
-		tipc_nametbl_publish(net, &ua, &sk, sk.ref);
+		tipc_nametbl_publish(net, &ua, &sk, sk.ref, &err);
 	}
 	if (flags & TIPC_NOTIFY_LINK_DOWN) {
 		tipc_mon_peer_down(net, node, bearer_id);
 		tipc_nametbl_withdraw(net, &ua, &sk, sk.ref);
 	}
+
+	if (err == -ENOBUFS)
+		tipc_node_link_down(n, bearer_id, false);
 }
 
 static void tipc_node_assign_peer_net(struct tipc_node *n, u32 hash_mixes)
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 65cc0c4964b3..4f204bdcaf21 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -2929,7 +2929,7 @@ static int tipc_sk_publish(struct tipc_sock *tsk, struct tipc_uaddr *ua)
 		return -EADDRINUSE;
 	skaddr.ref = tsk->portid;
 	skaddr.node = tipc_own_addr(net);
-	p = tipc_nametbl_publish(net, ua, &skaddr, key);
+	p = tipc_nametbl_publish(net, ua, &skaddr, key, NULL);
 	if (unlikely(!p))
 		return -EINVAL;
 
-- 
2.53.0

