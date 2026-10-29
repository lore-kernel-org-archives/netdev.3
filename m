Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793243134;
	b=xMvjqeywChy6rd9mTisNmsoa7AhD0Ez0OA3jx8XnK1Mf4sZet/tmabkkH/eAk/PdJ/5M
	 gV81KA05SLIDRXt2wq+RU6q6XdBogWQoHZTCio0X6sHfvZOryRf+nI1qffYgmsfa7zjDE
	 BR5sH1y+tUEfTOfBe9J46miSEcUlEr+yR6xb8cxqvuUm1+6ukmIaXB1aeb0LKhWF9hqFQ
	 igBwTsabtTtDWo2uuTAJTbyQA8/fdQux8RV3tBCibmnlo5i4xOhRyahwNvA8pNaze5pVK
	 F0te7XBlE9gdrWM5g5LaIiTXXPIQyG23xZ0YN8xGB6X9eDQz7Xk02hpRdROFPcanrRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243134;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=MRqijniYrQeDOHzHUR2PC1La5p6LkZTKesHO2VLopj0=;
	b=GBkgpbdafI1si0+v6LRWR26sbLXqjCNVVGfOf0gf/orWZ5Zyw3dQ3Jp0Z4o2sMLbHHWV
	 6wJxcvI9qKf2OE3vWQDjHYF1oqKjz7vVyQqr7sDCdJLH/OP7IxF+5sa4JLJJZWwpU8Axp
	 vD6aiFJXxXGh0b/cq5krnUi69ggGfvdwGZp7JLvcBQU1vSxiq79qbvU/9LS2v3CAKnb63
	 OiiMqQAZkGbXYNL4IrCOqsy+0yrSRK5zzLkgHn5SJZpiavQVL/4Xvmo9GHPIb3o3Ykcn3
	 KrVKEleTbfLaAoyMMrTTL0D6SovQI9+syPQNUatUcjd3pKSCJTUwPavxUYQl02u+tKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=bEwjEf0N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.14
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8D606A321
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 03:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CF8D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=bEwjEf0N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8hrCLhK2CLnz/4p0LCkN8toS4tHaATnnk2ae1KvWhMFsbdsV+JuWGaeYX+rxeXaAYfCpTjMYAXeGTTcBUJB/k2quNz4Haa4AOkn7sCqP781e4Kl17PwghB5v3R/fQ8wa9vVfzI5hLfBW/PwjvDp4pivMl6IhGta6LMaWoM4Kbsz1W2Xws28F9hWfUeRC6PSCa7GgdtfvnoNJGxJlwEjs18rmOx6a83epDt/S8Ge/OVjA0EvctU6OR/KqOHbGplGLpoVOiJJvxUi0crRqCKRwoxMblChgvokXx8BBwtjDl/0PncJ261n8yKk+x3brbhw5GlbI2/tNRNWH35rl9DUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRqijniYrQeDOHzHUR2PC1La5p6LkZTKesHO2VLopj0=;
 b=Jn/lYruO49bFMb7TmuIdZHBmy4c3QMkdfHKtsxc7x/ZJK68s/a9JMA6BTkZKAChF1tAboXGzpXe/0khOQjW1U1xfk1aioeVdSNGerUHdT0muEWkD+mcO59vDLoYlIEzHCRL8fpnA4eZoDVAgcT8fQeZPNcOXBep4gnNLD1ucgRDqrT0BWCihTwk8zCXYaCaRriFbugJ9ZkLab/ef85kPJPLd+5tXlT/emGs16jekSXEZMOYp3zdmRm43PGzvruV/0F5WwJhxnql4zAsYbt2bE3n3QIH67rUmYgySpDbaGgoMB8Aky4VXKfye8r4ieXBOOFB4CAPlbueJd6YfqtB5Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRqijniYrQeDOHzHUR2PC1La5p6LkZTKesHO2VLopj0=;
 b=bEwjEf0NT56aos5MKZKu3EefHVach+AR5dvP73DSq/VSADb5OxdqyaGkJgPfbQlXJwVUXrS4LbjWFBI++y0O3VpnaJG1s2xyaauk+SB3Q5GUo1A7frQZ6el73DK4acV7j1a07S5F6J5d1uyVOHD8CbSdoqNUPuSc51RQrE8hdUHtKFX57yV6WIogTdJiPNWTqUpItysOQaJj5RnAlVsW1H9CwpmxHjVCBHj++14QUKW37TdMOK1cDVaYblXDlVSr3QTJfw3jBHiAJYoDJo6oid7ObgZiQZr5vGY5bBNyA+VfE50q1snOmOqttHpUuBL1+3Rr39riTkHGBQ4m32ONxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by BESP189MB3243.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:e8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 03:05:29 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 03:05:29 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH net v4] tipc: reject attaching bearer of different media to the same occupied device
Date: Thu, 29 Oct 2026 10:04:48 +0700
Message-ID: <20261029030522.8306-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0187.apcprd01.prod.exchangelabs.com
 (2603:1096:990:75::22) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM7P189MB1137:EE_|BESP189MB3243:EE_
X-MS-Office365-Filtering-Correlation-Id: f84cc0d7-7fc9-4b1f-4019-08df35697d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|23010399003|261026140227099003|261009223027099003|261021121427099003|261022075727099003|261022105027099003|10067099003|56012099006|3023799007|261028144727099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	klLCI4NJAptv+BCbKgsUgp3E7uS8TnXwRnSzR7pvuaN8bZD684tQukdZWRd9fAXQ3BUl0mJNDqvFxwGoT74q/OghjASqnvMBq36Syvwu3CA/54L86d4mlzExh7IwTkh7kr0JTttLaNvjFRWrt4anNSHqqhu90/cBMhhYEdfe2mzsQtUTMNGrRcHj6yZGAQmVo6rL4ivalS8lXXAGcP4xx2ueO183aqZ8YSwo7GFZ5vQ1wM7IyRj+qYN5sPRukiw1pbn26//jpmlyEAzGAeGnS+hyEI7NwYYMfdpIzrp+wTQ9dfDbCC4J9Pya9r2jYeOeT1w64r6BcbA7McIG6OQwUS5p6fm/4CTuYKMhRy84Uvba+bw66otEXCpNBQe5gZ3eH14ZQOls2++0YQBWGCkEzycSiNk8ADN0sczAakSruLoyx+XluGrNrb8CHd4SqmRafCCKLp/zxnTrWPv8Oo0GKyzKAGeE9bpcQDm9OgCFEWGgQFU/zHpKavU97SrXljXNKFjXdahcz6Dd5t8M60kUx8MnUqqzwgwQnYVdZNizVlwCSO3i+nsrVBq/2JvyvlRa3mSA+4q0o7sPxIGKfewcaz+WMeR5zfQWfP/z5dF4odpVJIenrdOW+u5zgMGeod3u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(23010399003)(261026140227099003)(261009223027099003)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(56012099006)(3023799007)(261028144727099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TM+4lcm24mA/955SF7GFuOGESaAqeOVG67nJM3V1HRBW2lUOnnz0ACDxlv28?=
 =?us-ascii?Q?+X6SQr2RPN2cRvKi0K1XRwe5nXXEQH5Ji7zy1vAo0ESM0RNs9C0pZ+9kyqBz?=
 =?us-ascii?Q?s8RUoQYCe2kPQuqYgm+JkYbACBei2y02Cfyz6Jjf/D73b0kH81Daa/eJquzD?=
 =?us-ascii?Q?VdfFA/9QENBKGdD+mdzvVzKvX/eoAVLsBMSyMZsDw+ns+EOFNaLRGbXA3AFM?=
 =?us-ascii?Q?RLJu/9duRBD6854QeU8slXUmABdLjsv7ev9ymMhmTSu4rGFMdULuDJ5KdsJT?=
 =?us-ascii?Q?JMVH/SHerzCOisvQtDln0xs6KsYsie6CwBOJZt7nb2X3h3AsNEIaQo5d2ewV?=
 =?us-ascii?Q?MunZ8h5YBVW7Dvy7q/faGUXjn6UIcFY59buMvK7rNZWez9PC63K70PFXqgpM?=
 =?us-ascii?Q?orvwXF5DSNwNatIQ87f0nLbn1qbIKSicfxR5B9nlQYlgbnsJWZnaa2QvVMjB?=
 =?us-ascii?Q?fkZTXkViIkrUFDpD2irqHqby5go5RCl/SuxZkpDRhMK1gIJ6AH+vt5fgtDMz?=
 =?us-ascii?Q?9rFGBsar94sarZuJ1ctFCJVf41M94zophINi+o1DDpPPHqTWO9h8o/PvK7Ya?=
 =?us-ascii?Q?nO7f6yP3KLR1WwZW0fupK7TS2ff2GBhnwUZOh/Swla7otFCArCaOSTubX3zj?=
 =?us-ascii?Q?VMMVTqauXzun/wM/8Ls8rKRbMvBim2cH1umrcPtVi/zw6blojwZPWfKTqAqX?=
 =?us-ascii?Q?fu6WzxJU2QCy73YK7g6tSIkRRrZgROlHgiIoAIvNUlbmE6WCNO/Oo0qLbngw?=
 =?us-ascii?Q?v2jOuaArt5u0RQKuk9qD58/MZQ/KOrjaDtmdnTR8VJEU6OmVHYnym0YAsSBS?=
 =?us-ascii?Q?l3cH04ZXt51KZQ9NeLwFR5G6irvjw7Kb8YbSKZavPUko7U5LvNFMLkup+ibr?=
 =?us-ascii?Q?uTpYM+Fkv4GA9Sksh8RrT3yqzLH/UUvfWmSX0avJastszFCqHBGgf3gJEL4N?=
 =?us-ascii?Q?enJ6TvlhaUoDsUlttk+1xPo6nsVDQEva4Ez+9cxJsOa55cxYRgrL1r8FZw+I?=
 =?us-ascii?Q?+O/VnYwKMBJtwQJwxleK+KxVnXyIysCEyLZOrztI/ZPgPav77KojoUTeQQnf?=
 =?us-ascii?Q?EEc7OazM6jTiF/xnppIZ8fJ8AYb8Kn5XnfPVQ1bQ2rE+jsZ3QQTINk0VCK32?=
 =?us-ascii?Q?wf/uJZS6urNu2ANfMZzIdhv6DSpF/DX0ezxHTcfgND1FwwQ3cHgZxmsRJwmm?=
 =?us-ascii?Q?fo24cg5FFhubdhJcRMJsby8o9JuNXM9Be95T54odqR2K28RhOWRgiqUAsOMZ?=
 =?us-ascii?Q?smCZRE1DYofZwoV/Ew2X5qYLmEdbsDWlVfKTmoN1C9w13WJPRllVDHLwV0Ek?=
 =?us-ascii?Q?Hne124b8Wcy/N8xTcX6y0PZqwUYVIBmCumH8Iuf2/WrjlqM4pL+KD0W8j14u?=
 =?us-ascii?Q?DWpgIw0Q/sSwUSGDGFBLfW9q/QOSdnWTtXLixpRc0m5/jQn2x9JsPV/3YNnG?=
 =?us-ascii?Q?8nWapvvEQhVk5DjYD8Kd+hqtmUtTyKsXe+Wr6Sbv/0xhbmFQ4GsFXNLMeTUj?=
 =?us-ascii?Q?A7l8GtzIa8vtdyE13935mRn49qH68IbR6r65Z8hLoydDTz4vTuPj6XDyT4Ei?=
 =?us-ascii?Q?RKhn7a+Hf6ooUSDEoIh1GUfrDjnWpfg1OXnzTHpqopr27f21A2qo22hcYTBD?=
 =?us-ascii?Q?o0h5BckCiWwQMPmMJH0NF5Dr0krLXFULmPgheF58XSdUFm4Uoqxi9Dm/tCfq?=
 =?us-ascii?Q?q7mr/lclu7IiatPrwm78aLgq6CWH8i9s8JBGYmAKUMbUgrhnHF7ne5ocNfE7?=
 =?us-ascii?Q?THBkECTwF8OfSkHzM66TkZD0c3ke6X1LKZGXKQOzq0H6mhA5RL+wjnp7Ky7w?=
X-MS-Exchange-AntiSpam-MessageData-1: FgpqdrIz2hRIraRUcFirEtWkw4JiKkeddho=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: f84cc0d7-7fc9-4b1f-4019-08df35697d22
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:05:29.7767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQ8H829DpBCIajlP52CVAO5ZmcDvMER+Sm8aTxX+VZuKbRNdaGN14ewTxyLv93f3+BDZogS2ov4fP2+r5Oi2+sydAKEDWI1IBn+MHLMU1hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP189MB3243

Currently, two bearers of different media types can be added to the
same device (e.g., "eth:eth0" and "ib:eth0") via tipc command:

tipc bearer enable media eth dev eth0
tipc bearer enable media ib dev eth0

For each command execution, tipc_enable_l2_media() is called:

tipc_enable_l2_media()
 dev_get_by_name()
  dev_hold()

As a result, device->dev_refcnt is incremented twice, but the second
bearer replaces the first one. This causes a leak in device->dev_refcnt.

Fix this by rejecting a bearer with a different media type when the
device is already occupied.

Fixes: cb30a63384bc ("tipc: refactor function tipc_enable_bearer()")
Reported-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Closes: http://lore.kernel.org/netdev/20260918013509.1853952-1-xujiakai24@mails.ucas.ac.cn/
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
v4: Handle alternative device name issue found by sashiko
v3: https://lore.kernel.org/netdev/20261001134432.49481-1-tung.quang.nguyen@est.tech/
v2: https://lore.kernel.org/netdev/20260924162016.1258485-1-tung.quang.nguyen@est.tech/
v1: https://lore.kernel.org/netdev/20260923091057.375981-1-tung.quang.nguyen@est.tech/

 net/tipc/bearer.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 774f68d1a2b3..60a6f4a3c0fb 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -287,17 +287,50 @@ static int tipc_enable_bearer(struct net *net, const char *name,
 	bearer_id = MAX_BEARERS;
 	i = MAX_BEARERS;
 	while (i-- != 0) {
+		struct net_device *dev;
+
 		b = rtnl_dereference(tn->bearer_list[i]);
 		if (!b) {
 			bearer_id = i;
 			continue;
 		}
 		if (!strcmp(name, b->name)) {
+duplicate:
 			errstr = "already enabled";
 			NL_SET_ERR_MSG(extack, "Already enabled");
 			goto rejected;
 		}
 
+		/* udp media can be used together with any media */
+		if (b->media->type_id == TIPC_MEDIA_TYPE_UDP ||
+		    m->type_id == TIPC_MEDIA_TYPE_UDP)
+			goto priority;
+
+		dev = __dev_get_by_name(net, b_names.if_name);
+
+		if (!dev) {
+			res = -ENODEV;
+			errstr = "no device for the media";
+			NL_SET_ERR_MSG(extack, "No device for the media");
+			goto rejected;
+		}
+
+		if (rtnl_dereference(b->media_ptr) == dev) {
+			char *dev_name = strchr((const char *)b->name, ':') + 1;
+
+			/* Not allow altname of occupied device */
+			if (strcmp(dev_name, b_names.if_name) &&
+			    b->media->type_id == m->type_id)
+				goto duplicate;
+
+			/* Not allow eth and ib to attach to the same device */
+			errstr = "same dev for different media";
+			NL_SET_ERR_MSG(extack,
+				       "Same dev for different media");
+			goto rejected;
+		}
+
+priority:
 		if (b->priority == prio &&
 		    (++with_this_prio > 2)) {
 			pr_warn("Bearer <%s>: already 2 bearers with priority %u\n",
-- 
2.53.0

