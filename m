Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6441E475351
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154670; cv=fail; b=VSSw7se+7iKF3OZ7++3/lQCkdsyklocvTsDgXH6+5VxIqVPfYYB9w3Hdrzw/PmG5MztO/aiSDbJLB4s86FNsmbUBdgkZz9OKOzROkzvotQcX0rVNKjnJV+m7OuNnqnfsz0bltabXDNv5dF7S78BIcTl+iTlx7ufWYl5OF6sbgjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154670; c=relaxed/simple;
	bh=wsfoljQVZ+2cZM9CPs1DrkFTcmTdctrmc9zcJbK7/sA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jRmv+Plo9N/B0eWEL+oUy4KMbMXo4mvYOEWAVLTR4MTSIRq+HeFAI2Sr39PYwqFgf6jLr/Jgqcg+FQCXv6Z+S8ZULNjDsbuh4GxAz9gupgYkJ8nRxpQgytz+6U05fQ5RHgAzXh1QyhVEu4LwDkQR8QWX2RJeW5nI4JIhZHqj86Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=u4bPJkOZ; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="u4bPJkOZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psph3nPF1EIP2fD3C+nGOCLShGp9jSgzom9y3ueglTmwewYO+rz0n/SWm2cdEZ6UA0ntXyLPDJvmd8x9CzqAWR+J+zxYvJ9yXRFMF0Xy9xMW738G7w0h1KgFEtKSxDcvkPHoQmpJvahasq3G+cbNT6U7OevPZjl9KX0pokbHFPujTZsr7EzfYRj7LCVX6r6F3aGB/Bkhhpaf1rISAj9IjL4EZG5xvCxTGUZzqOzFTXVpt51cPSaRrZ8D+95GPouRMP+Nunl+KIJFAMo1iLb36d9ZCgZoGbC1NTY1d4DQ23Yxb4aTwnE0Zdtm1Fwo8ZZ4WiXDwQoelWro9kBVQQbTFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryLjSunnPqJgDy7do9kEvZyHyA3xKXk0oH5UFdqG9PY=;
 b=h3eg837/BSzkmevwX1gYxmKgqqm0aUIImIU15emI6FV+TqUQ6lseI2m+q6tezpBgDHjsaOALcnZ08QdQPdkeJKf//Y5Hi79P9DCSt1cWTp3zc934dKXSGIbGgVW/D7mi39yJrqS6WRMXBcu8rmgl7w2hDmDA7L4G1sYkNAehl8Z9do7b6BKhGel3Aw4sqNYS0NAagPWWMT60uQQqXcWlTSqHz2VJgrRjtTWJ3DIAqmsXEOOgcAgkcMRerQhpYuJ+wt9nB6oucWWkFC6gdEiW+pijJnu904CBOU72FKTbyEp2hNbeJZScdSTkLp3dHfJfMfMSOYcvuJgY/nqkONxXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryLjSunnPqJgDy7do9kEvZyHyA3xKXk0oH5UFdqG9PY=;
 b=u4bPJkOZTcwf/a45H1H9VhzcyAzf7jNMvgU0ofKI4SbyTKsUXdljjalGWzvZUy0UtZYPsbKHI3CJiMnARfykqZplVgW2QdJ9HJbW5NeCjfM3L2J9FBM/3lNIE31l6/V+ZPnyqT3H0h0uYQhzCQQHUhCk7SONCdGHnfvcxcTKEq1Ix5B/pqNHfKjTyvUchanE+8naRytdCHojHjokI/b7vgZDTfGB34xkx1UaJjy2GgrDIz176y6mTNonE3FNWC5bUH5j4pnXMPW/SPeFbIqTFcf49SIeKBI0Y+xx+iaj4nyVy7p/PxamrBfE0clCfsR3siXw8H6Gm4aeG/E5nvNbrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:617::19)
 by DB5P189MB2519.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:4a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 09:11:03 +0000
Received: from DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3]) by DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 ([fe80::d422:dd3a:7c1e:f4f3%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 09:11:03 +0000
From: Tung Nguyen <tung.quang.nguyen@est.tech>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jmaloy@redhat.com,
	horms@kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Subject: [PATCH net] tipc: reject attaching bearer of different media to the same occupied device
Date: Wed, 23 Sep 2026 16:10:34 +0700
Message-ID: <20260923091057.375981-1-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:295::19) To DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:617::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4P189MB3750:EE_|DB5P189MB2519:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bae7eb2-6742-45cc-f40a-08df195297e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|10070799003|366016|1800799024|56012099006|11063799006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NM6IX8NO+RX9+AFhYD8DXkT0iUadu2TaFYfm+ZWvZ2FPKZA9URSOSkbYYoR+1FwWm/O8J7o/UPs6am9ope1+AMl3N7x/MAW+/EBKNigksm1lqs6R6lr/o9CnF6ijSxWIGITeoMFOXjl64Dc/j0AnFvExg3LR+9lJZUvmdP8wcraQtrrSuQ3JE/TOOSOMRPP1VwhkgfLh0RL/yop6593QZ9LiaQLGt05/udpJhvqSR/KgUtowMq3fQURlJVpsUstfm0Ev6KbTNDReIC7NzUsVnzgtUfvIzOx4BmghqEFRIIrc2diwncY43sm42DcE7u7zRPCk4ACr5zhNMLGyfZuFfbVpcI1c8a4ODgxOq3275V0kCTo5nAF7bNIuGT35b1h38bOo1YDBQ8yJgfW20oAC/XOfi028Cu4ms11pXKfFEYyhKqbxuHnWUbJFc8UxHXJIkPydko2K+UZOu4DytRvw96Pma+01KojDNksv4i+P7h1yoPHh4F+2T2hBKdOvngQ8CTciSmU3cZD9V2voh2ZoKq9Oi9HoKgyjtOYiw25lwruEHql98af7pIUac7MwRFI6jrjIvd00c/fk7BJjINSZQXvoFS7fU+12uK1ZNnFqkLVGfp12pQ1CElP3cYyUIPE56DMGB6lPxDUWW41y1PsKWSU0UcmjGBq9FgySlIHV22o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4P189MB3750.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(10070799003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vhSdx26bFldZH85QbiYhKNVuUQlCQhDmfzA+qsyrkOGDdrEuEHol97nM+RLq?=
 =?us-ascii?Q?aBLWmpuCy6Msi8zPLQ31SclSyHwRgInHoBHyABuJBiRfVjE3ziyahEw8tHcx?=
 =?us-ascii?Q?81WjUdBHqbb1VMNI//XyzNnprMN79lO4FaZ4NUk4F8CVnetZG9PXPBz+owRW?=
 =?us-ascii?Q?7v2YUmjClvo/kpzf3BCiJPt6VyjYIVHwzPW0U3nWd85vI5Hi03T/uBaXVexi?=
 =?us-ascii?Q?OHOjEiCT5C5bPfVeMkdvek25Ix4Us7XUAGVLDW/858sWkAaYYhbJk7Fe2IJI?=
 =?us-ascii?Q?PBT1vKm63ofUPatP0ObNvYaoAaPsXQhK2QbmI2aE20D+b3I05FB36WEunUVL?=
 =?us-ascii?Q?aVL3Xu7NpBF2/yVjh7lTYxh8AcktDz9dBjTKb7xi/NoQi2KgZflkyjxxSvnP?=
 =?us-ascii?Q?8olWpIWwMzIRS6wdO6pZ8T5Eep5/LReCeM1pJhgeFjzoxDs8wdCMBDu2arxt?=
 =?us-ascii?Q?/IzceRDWiFRBivdraOqdAaf/CZPN6MPmuaBFX9BS5YKShu24QQraG6nfWv8Q?=
 =?us-ascii?Q?UuDlggj9O+mnjdooVGq5cIPatWbTVcP5YB40QkeY1WUdvEImJc38QB/KpwsB?=
 =?us-ascii?Q?QQ26G3W/IdQQdgot0HpAN18LHQCH8QgGFcFpIpMpIq3E1WRiwNDfDFhm936M?=
 =?us-ascii?Q?an4kjunfs6VljSd2SVuJ3LPImS7doaPaeXciU5d2e4PYIyhww3rf5rSOvLKK?=
 =?us-ascii?Q?Eynf7opphhSV7LXlvWsw+bW62+zgEjXWqWopvbEu6A3uoesxgrcK+FjAdCx6?=
 =?us-ascii?Q?ab/FjJ6j1OiirS64umO1G1CXFkBL3mK2vEx6fnqgIZ34E7RECchNqZCAa/lk?=
 =?us-ascii?Q?CNrjv1+Wll19GIzUWFEl4Es07kiVJgePhnXmE7caBfEuCG7p687/LsipVfyW?=
 =?us-ascii?Q?1ywUzO9DvaqUW4nrmLeCDa6l7BtTFcca6N3RuUpQNZOaFX5jw7EXMsRfYcIa?=
 =?us-ascii?Q?RatnzdJ0MyqAE4h+OoAgsY74qT+qSG2LJIaNQZ6c1xTP0ggqoc8rBXZVbE9v?=
 =?us-ascii?Q?09dELad2+EcZIjCEyuVmL8jWHnOjqRbZmo4kX2Fzi+tGHiAqaUZ90Qi/4HSU?=
 =?us-ascii?Q?OCLJc1WoSDAQKau9MAbhK6X2A0Yu+qg4GLbPtHdZE7U6BJjRYVgw1CC9JjQ4?=
 =?us-ascii?Q?qNW1rjl5b53Sr47za6BJe/tQZB8DAZ+egsIzpWPEHY4OH5/VR+fsTMfGWIl1?=
 =?us-ascii?Q?J0OysvIOBsPghCEyph9k1Tek87B/Ilx1YXFJicKhfGJ5n7F/Pb/eAgafv1qd?=
 =?us-ascii?Q?cnvFpH9ynYGkDU+73hI31NCCeVwiIRy65TkrHodRrNk0D30WgsIQJsMZbFcm?=
 =?us-ascii?Q?SR+U5jx2dp5zgd0EAi/OqUd901ol2q3daEolvOJEz8E84I8a+IBdTkoyqthF?=
 =?us-ascii?Q?CcQztLrVRd9M3vGr3yUVehH74MqtftNiqoJZSc+8xjLlvV+ah+IeDeAn2LjS?=
 =?us-ascii?Q?LgQG6JyMkKz4sF724G85qoTePri1I11fRI3dJnezyJI3EHZCRynW3BhvELOP?=
 =?us-ascii?Q?NgkvJKPsb6d0sIntbqXkJERJmlsSuRpEpQUPwLQ3eFlnst7838XiJ8X1eXAO?=
 =?us-ascii?Q?DfYBSJlIPSghk17abTRujYBs0Bdaf9VCwOkXfryUPHa5CuktF0PRPfoHZI3i?=
 =?us-ascii?Q?VWcN+x1xKp53NNLfoxOX93yeT0Wze/ChgADqqikvMAZJB2CIZ6Qfa9BXmnSm?=
 =?us-ascii?Q?cl0KWonLwbcWgB8iUw93A84hNguQr8GsaMx2NLVKuivS4VNobYTMDntFd5qL?=
 =?us-ascii?Q?nTzo47DN3yWiPKXbO0+QGBiOsmYuRDdwZtfbyxNVK5Bo4k7gWCJ6NRqr5HEm?=
X-MS-Exchange-AntiSpam-MessageData-1: UJOSgKYxVipIc1CgDPVKzmmhuDxv5pPHelQ=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bae7eb2-6742-45cc-f40a-08df195297e8
X-MS-Exchange-CrossTenant-AuthSource: DU4P189MB3750.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:11:03.7596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdXS/qx8ljemzOqwj22jNI84zmPgkV618kdsko1XiRnddEAavVlq7b5isol/l+vvBtgsfgCgKQkorU3119TIzpvN2RFXoJwTzOcmHnpAVwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5P189MB2519

Currently, two bearers of different media types can be added to the
same device (e.g., "eth:eth0" and "ib:eth0"). This causes a leak
in device->dev_refcnt as follows:

tipc_enable_l2_media()
 dev_get_by_name()
  dev_hold()

As a result, device->dev_refcnt is incremented twice, but the second
bearer replaces the first one.

Fix this by rejecting a bearer with a different media type when the
device is already occupied.

Fixes: cb30a63384bc ("tipc: refactor function tipc_enable_bearer()")
Reported-by: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
Closes: http://lore.kernel.org/netdev/20260918013509.1853952-1-xujiakai24@mails.ucas.ac.cn/
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/bearer.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 05dcd2f9e887..1fb54a588c8d 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -258,6 +258,7 @@ static int tipc_enable_bearer(struct net *net, const char *name,
 	int bearer_id = 0;
 	int res = -EINVAL;
 	char *errstr = "";
+	char *if_name;
 	u32 i;
 
 	if (!bearer_name_validate(name, &b_names)) {
@@ -296,6 +297,15 @@ static int tipc_enable_bearer(struct net *net, const char *name,
 			goto rejected;
 		}
 
+		if_name = strchr((const char *)b->name, ':') + 1;
+		if (!strcmp(if_name, b_names.if_name) &&
+		    strcmp(b->media->name, b_names.media_name)) {
+			errstr = "same device for different media";
+			NL_SET_ERR_MSG(extack,
+				       "Same device for different media");
+			goto rejected;
+		}
+
 		if (b->priority == prio &&
 		    (++with_this_prio > 2)) {
 			pr_warn("Bearer <%s>: already 2 bearers with priority %u\n",
-- 
2.43.0

