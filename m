Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793590985;
	b=xOh4RTaIsi5pr9p5CP5YiuCeF5qlAS0/qYqV3TaFXNK8ohoaHU1bDcqN5N1EMKqMKky4
	 ZhzrNqISDAl0G4agvAt50Vp6lVN+CjLfS1l92XLz1r/6XcIKygeBK0ayC6OamxpIkQOtg
	 TEGe5M8ehwLve7jHHDL1jYl5mIUy6gO0QiWDtvgPkkMeuOVb05FcdGW9NsmVY80Z3546M
	 jSkHweDZULuGcjDiPeZkETCLAnoLosPc5sx3POCLs01XWxoo8vw2Pu8U5BP6sQocSZzik
	 PYa2lgNTFkSglpfV0UUvZbxB+EVdT5t9LydU+NIkcahlKWwDahuXSf7H7qQS7htwctg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793590985;
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
	bh=G8IQeoyaqit6QBxVMyw2cdGsksYUq+JDv55HbyAbaMU=;
	b=kSRhwdbV/e57Tu602Fv7yIhzUAKt6/sXhuJ4qLg7qvAe0/yudItz4elro+0l/GO8sHtM
	 Nz4bhrV/P1rsIPKBq+T+vsibuwEDQiWL0TFGM/2D/9iPKar+jpgXLuGAeKn6gl6WAN/W5
	 4b7MjReg0/z9IscK6WFqBmZhvdo4++Feh/weM6mG6O8K7s9cJ9FzH7YizYHFhCRgWv6ee
	 8Q01/DQ6rUw/VEKZHn7z3pr8fm4mOSlckMWONx6+bPRpufEGpW/yOzqKhi+6CLul7rcYd
	 sUc2lUp+i8K/Ca9OiAA3CGJm0S57ib0nyYHqGM4Ct/2tajKRb79uXZNmIf6WESFo+Bg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=0dm5gzZV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.29
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58030606A324
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 03:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58030606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=0dm5gzZV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlnW22SkJ1ze7XpDM/GMCaQvrJVfNwxDc4RTZ472HD8a3XLju5RH23loTQlKFW84cMu+ZiF869HmjuVju0UTrRK8i3KGdOl1VQcfIstvoa3nkTZjPhVXeFHDPBufUeDE/OeRUHZSb1HbHe7ZQlPq8f/YYPeNffTa36i5RttRmRlg4ahKF5GaNcvGs4EbD1gDYnje2SvnpHBndk9o6xXODRL4EUf5XAq+yNqSoObAuwbvJDIbx0fmTJ2tlWY5uP6vbwOM7I1qUThbfUxG85vJzRyVldEZ2hPYgbu8AQA/agLAPFvy/pfTYioKuKBkURhQYiLOwUNZuE4huXmCaN6GMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8IQeoyaqit6QBxVMyw2cdGsksYUq+JDv55HbyAbaMU=;
 b=LFWwmrebtttrCUeeFB8yWRE3o0jd/rhZDky+S0DPOiu4HY14VQoRus74oGEQ6DHjfY4/JAes2zvPcsURBumjP4lD2wcgQs2DHaW5KtG+ZFGBxleZ4syFx73RTgLkHx/5V6yhcNN9PHgMZR6S92Sr5ocby5Z32BKTDlrxJvG/8gkQSO/CryQCCjPL7pV7DPDGIQ1w657AjX7XmQmnJ3PIwJYfQuVk2YTTGMYyiKy8MfI7Uvh+w4fSxWg60P44O0VlEHXv/VbJEw4YFOZ3jYdUyvACGQPI+Ty2VpMZy6sX/SG1ezBvkW9uC9uyFzN11nK6ryTCLIQAHK3lixnM6q22TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8IQeoyaqit6QBxVMyw2cdGsksYUq+JDv55HbyAbaMU=;
 b=0dm5gzZVGwcFBVHgXxD33kg7qKgTg1mwixsc8L9iyOpTeBDDiceulptbE5MaObKJjwOEICtwTPyCV25PlSIUA+48Ldj8XKEUb5revnhfW9PLEUIu1RV1kfBcX3Iw5FWrjHpsAYeobHXpaPqKfulhPplqx3Ompvhqc7eK6otDk3KR96puMCUfIPEqOphzmDwpTZqlie2ouZqQT60ah9Sw2ei6haOTsJHc3QIpQqWVV5098lO8Fk9FU69hsHGJ4jIGeApXqb7qmjwjUGpUJezBGK5kYTSH4CGwvKR3ujadIEjnHLZFPOfLvLunBO6xuD+K6cbJhElxOL6pU84vQvXaQA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by PA1P189MB3491.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 03:43:02 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 03:43:02 +0000
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
Subject: [PATCH net v2 2/6] tipc: fix dangling link in cluster_scope list in tipc_service_delete()
Date: Mon,  2 Nov 2026 10:40:28 +0700
Message-ID: <20261102034207.10639-3-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
References: <20261102034207.10639-1-tung.quang.nguyen@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
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
X-MS-Office365-Filtering-Correlation-Id: 639db13f-3438-4686-6d1a-08df38936556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|366016|376014|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	zZDGs4lLwhObmO9azRmvxaThRoNpFk6nyCtfJuZEj8i2FS9MZ06pVEWltyDs9ZYJ0MXzRp8Nqn656RbfjFKlLJ1vxMegQ21cZMe2bD0rZ4urDVNUZjDNYO/L07dUHOe7I5T/XRQetc+viasFt2kBjYneKzYZOkQv66zlkfhOVbUEZ2MISGwNeTzqTKNkFbTDBfnBmznNNpX+hCr1lD+0JA5T/EoCFeziDHn7YzdpncDdaO57gt3Sx2YiWGzFEoeLi/7w0NiMpiJnvGSIm8mopJO2DOwount7Nij5vmZJzOrhIu/14szwUYdBEVUAb9oVY6laFtZqEektTMEIayWWkw0tirdd+YeFqjQ431igCRAMMsMJjF1fkXJ4RHXrKQqFUzF6vAvZyvVRIMov4REjuF+AOyUFOCJ4QnPZJMj0ThdqjuF6vRo+TViNV0Ij/14vMIzdmGhOcX602oJujk2J4cD/BZawdbPUJfyv+HQ2mKHMGbAndWuraj5y2eIDL0g9IQMl6P1y71RLXiC5I6ruKciA8m5w8tc5R5UIWO9UJVoNTxbVNKtDxQvxlzc19Bj+0XMwlz3lB82t1rInZwIlFsKCIYXFVe0TmzPq8Kqo1zC9HgKzebsne3JOLjCBYqfwX9a4NAT8AhYvPvgHN0y5jmWJ8kdz52LSwdTE70XmSt0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dsvahp5cXefn34/bBvfpqb6/vPdPVLwcYvpRGWwSPwV7zbC5A/DSc90BqlNV?=
 =?us-ascii?Q?Xqi9ycIM2hz/mZuqCX8KEI5CjttJyXfZCR7kbLt47YX7/UwquIyt5KL0JePR?=
 =?us-ascii?Q?cOvxcw658b3G5V5CQBYcKVKyr41IGfAyYxl2E5YEebw+AAFl2eKYpRM87R0w?=
 =?us-ascii?Q?KHpXVYhAb0phDIh+7kFj1paPHIV5kv9LCgJ9wLwxr12LddcOtYV+RV1aWp3y?=
 =?us-ascii?Q?FjKrmYyVNodgJLbngFiMk9KBsO6DXO99I777MzDlDqEKhRbmOsEkfsoTU4G5?=
 =?us-ascii?Q?39PrGn4HGCBTphzqLPOgimxTJVA9mqs7wHzLfGSNnir5tbVbtPZWafyJ9RU1?=
 =?us-ascii?Q?288VlqypCRiQE9LGaX1SOCvtQoIiR5wpPC6ikQtMzq06yqfQUtYiT91RbNby?=
 =?us-ascii?Q?bLout5TYL+Wh+/kaIzKh3I4Ub6oFPCiyxVCMPw9gMMOsnshR8z2H1vxjje4W?=
 =?us-ascii?Q?ghIIRAk9RH5s773s45TJDgi/9z18Hhu2Iuu77Lcz4rneGo0o/I3GwUqgqGWE?=
 =?us-ascii?Q?2+uQea1NIDU5x6GT0Sm1gahrxEldnpvJ7UAjjye97+BgQNZ/KBJiGic4bHzY?=
 =?us-ascii?Q?sraslTy23CAoDW5ZrVxmrhQt5Q3GuV1wtYGO1AYrY0ZRkG1jAgVvWoI8R3fF?=
 =?us-ascii?Q?gqbxmzG0AST+/F1WudPu0H9aYZCvKmxN8zw7otxDWL5mXoHudLm8hDkZlKdt?=
 =?us-ascii?Q?DSOTbjzPmZ57llpdzfIS+/84GWeaVJticeYJZXgi6QkdO+h2WTfeSMpd9ZCl?=
 =?us-ascii?Q?A2rAwExpExanbwLi93B912k3FPjdqJUWvjlLQLdXRW1g899b3p/Ky3DiO1fx?=
 =?us-ascii?Q?gdgv/V9kWmRm6ZBNCZVizOrFoIjZBT0BhsYb28it7Ld43yivqSZQIS+BppRZ?=
 =?us-ascii?Q?G0JDHb2Y1k0lHXdg/TX4wwUKYCGy68F92ZCu3QGUbLU3FsHheVAqUZerWapB?=
 =?us-ascii?Q?GnJpDluxd+hAU5mLL96pDdo0+WJe/HIbKm6x1ObeugwkfTEpa+p4VoKl2U0G?=
 =?us-ascii?Q?MUazhacbxiP2tipZ4lJFpHmZKXz4HzRMh0FMx+ZV4n+JsLAQe4FZpm8dtpiu?=
 =?us-ascii?Q?ATG1kckH33rVtOpiA/21m2m2eKU/6RDDmHxtkoPKzOwggYz8LGoISsgs277Z?=
 =?us-ascii?Q?4ADl3/VinVKwhmxZ8iz8jMsvsYF3Ay9dJYACs2Evugm9n1LoFxzx26mr7XFs?=
 =?us-ascii?Q?8E9awfnnEh4P4h61UFYmbZL4J8HgvXF7YMXDKLNXfe/m5LQB4A+ouOsXaMhb?=
 =?us-ascii?Q?sk4ORb+fM2VQLhEKjZAMa2vQVP612BLTCVK4s6bH9WgtzEOV6e2jHulWqNMX?=
 =?us-ascii?Q?AJI95EhLIS50P0q3ZqApQgWKS7Ek85LpaLYWpTi1fdeqQYSIaINyBOqDNUqt?=
 =?us-ascii?Q?NC1Gq0P0jO1gx9eZTB0CPQrhPpyLvgV9DlfIPVAnoGpdX2ZUELgmqcHrtyzX?=
 =?us-ascii?Q?Kd5YG83G+IWyIKXQbLhZMVdMAd8fL1yNqBPn0J8hDvOjCzPupWrlij7YbGdM?=
 =?us-ascii?Q?6agB6HFwrbHs4I4arqICuLp4gB9MjPjC6+oiZKL7F6hLFE+ZHzf8v/y8KABP?=
 =?us-ascii?Q?IyMKfSDSxEj7RudIs2NLLhqnMbtd/YKyGD8TPIk3//Kp4ZR24BeIpU/L7zSn?=
 =?us-ascii?Q?QQ9L+c5kaZP2aDewJa5FBWXGXgc9nR0qukcOvbjKDieiW2Qo0M9todQMtNPX?=
 =?us-ascii?Q?9uCxzKB5aDstTioaRmaf6B4ExabacvtYvjBJaKd9Mr6PKGw/Xj2becpZmUPo?=
 =?us-ascii?Q?eVlfqXoEaHZSozH+MWuY+6b70ts81EFLksJRKQNjcO/fF6N8ZuRuti3gQnDw?=
X-MS-Exchange-AntiSpam-MessageData-1: HC7bgI7efOMnI52u9XqnjVPjOOXOEqyfupU=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 639db13f-3438-4686-6d1a-08df38936556
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 03:43:02.1991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLE4cZn6YKDe1sv1YK2T3m8kn05+mDzMOT4FBIh2tfWBWJBZB+7K1M0TFlwzdNwdEmF2XLdsgVfF25Wp+zmMKXmijz0Dt/mQy3PBlvZxYWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P189MB3491

The TIPC name table uses the cluster_scope list to store the
following publications:

- User publications with cluster scope from the local node:

  __tipc_bind()
   tipc_sk_publish()
    tipc_nametbl_publish()
     tipc_named_publish()
      list_add_tail(&p->binding_node, &nt->cluster_scope)
    list_add(&p->binding_sock, &tsk->publications)

- Protocol publications of type TIPC_NODE_STATE (0) with cluster
  scope from the local node:

  tipc_net_finalize()
   tipc_nametbl_publish()
    tipc_named_publish()
     list_add_tail(&p->binding_node, &nt->cluster_scope)

When a network namespace is destroyed:

- User publications with cluster scope from the local node are removed
  through the following call path:

  tipc_release()
    tipc_sk_withdraw()
     list_for_each_entry_safe(p, safe, &tsk->publications, binding_sock)
      tipc_nametbl_withdraw()
       tipc_named_withdraw()
        list_del(&p->binding_node)

- However, code inspection revealed that tipc_service_delete() does not
  remove self-node TIPC_NODE_STATE publication from the cluster_scope list,
  leaving dangling list entries:

   tipc_service_delete()
    list_for_each_entry_safe()
     tipc_service_remove_publ()
      kfree_rcu(p, rcu);

Fix this by calling list_del() before freeing TIPC_NODE_STATE
publications in tipc_service_delete().

Fixes: 1bb8dce57f4d ("tipc: fix memory leak during module removal")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/name_table.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index 6fda36ab1766..73b032ba2f8d 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -934,6 +934,7 @@ int tipc_nametbl_init(struct net *net)
  */
 static void tipc_service_delete(struct net *net, struct tipc_service *sc)
 {
+	struct tipc_net *tn = tipc_net(net);
 	struct service_range *sr, *tmpr;
 	struct publication *p, *tmp;
 
@@ -941,6 +942,13 @@ static void tipc_service_delete(struct net *net, struct tipc_service *sc)
 	rbtree_postorder_for_each_entry_safe(sr, tmpr, &sc->ranges, tree_node) {
 		list_for_each_entry_safe(p, tmp, &sr->all_publ, all_publ) {
 			tipc_service_remove_publ(sr, &p->sk, p->key);
+			if (p->sr.type == TIPC_NODE_STATE &&
+			    p->sr.lower == tn->node_addr &&
+			    p->sr.upper == tn->node_addr &&
+			    p->key == tn->node_addr &&
+			    p->sk.ref == 0 && p->sk.node == tn->node_addr)
+				list_del(&p->binding_node);
+
 			kfree_rcu(p, rcu);
 		}
 		rb_erase_augmented(&sr->tree_node, &sc->ranges, &sr_callbacks);
-- 
2.53.0

