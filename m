Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793158703;
	b=AwyEHBSxSzqm2vwqiAMWoxkNbKiSoASLjztgaSef3BoS5Zue0zZ+dO3A9cpYOJi773Gq
	 7GQT/dzSoLcVauasJD8vuwKyGF/tt7e1UxE37h96eHXmUewa/+xfBoh4nAMR/DDJ+EPlY
	 CBdh2ev4QCuivHTba5wLRuuBEDjHJ653cwnuncTaTEilinWyWehGOPDabVqmavRvgkZHG
	 DSZfC0PxPMwlhzMYAyQ0vnCIFYd+OKiRGweFqrQ3a2W67/tZhHhNl1VjdlBzCJ4Zqm960
	 D+/WjCIuQN8CxJ4m5Ve+kvK2aWv4bO9+Wdg04zxI42wapWiSFKxp5iRwz4wqH0vvP/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793158703;
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
	bh=dcYZsF/MhIJP3YMunrs3d+GZDbj3mBA+N4adPWHLzoQ=;
	b=z2ePKcpV78bCtt3bR3F+OcpgiyGw1sQPSU0xus8HXkhM51NTpB90lsHI4byM9H4FTWCu
	 32+8e3UPv+meTdsPmIFP+mmWTRzpe1ntiqxNZQSKREzP/IiTtRv6ugCOQYHIY2iEsF6TA
	 0ftqlmatVm+LF3QCaYx20RieyUiTM3xwyMS+hk3nK0IR/TcaDGUpB26CybW/iDNXfPHdf
	 gvhaUiaFUeh4bGJNv8NVCk+cOL/1XBnOK9OYEGH1Z9dMbyta+IxuOOmBr30oastnIlY18
	 57SF+imZrRwgS6ymnBlEEprPmc4+azdMds/w1zpHJm52waS3u8WiakLc8pQpDJJf0/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=est.tech;
	spf=pass smtp.mailfrom=est.tech;
	dkim=pass header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=sHn7Uop6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.38
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8F0606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 03:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A8F0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=est.tech header.i=@est.tech header.a=rsa-sha256 header.s=selector1 header.b=sHn7Uop6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjXTRuJDS5rbVFSR8XU2VapO2//RlaMySAq30DxcroGcz2o4W4WaUg8RTvjmTqm2xqhNfhOysW9/121gJoGaFedVzCm/llXXdbH0ryVS2VUmWQZXjBWJ0UZ93XUe2GpnInC2ExLrMsNrX6BkjMR0ONNGD4/k77PT+oZAQ68harZrvS6ucw3GSCP6MddcGNBlqmalSp8q9mAgTjWIxWAGFuQ6CK40FfVhAxwp5yUOU7tvjkoBTrBxx4FHAqfLm6jf9QzmJieYa1cJfwXPVUu9QpwaVuDsbOT8q4Mzxg0irCafUMB2wKIimzlnoRmhpGPiPp7q8VNxnvj+B+Jp/V4MbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcYZsF/MhIJP3YMunrs3d+GZDbj3mBA+N4adPWHLzoQ=;
 b=ZZh8/u+ORDjTqznIlPgmT9CupSt1PO4v23X6xcLTZIlcWqAjjClKgLPRInXOwp7TpRdac4VnnMhl96CM3UlzjBHXwMlhlKjCfdZOajFLG0PtJ70ts+KOmmKCoAcBKw4l74Q7UrhTdn4U3pld/1CEo3VaEMSxE8hbT9DT7dLDX4nxXoauJLB+zq9QS46hqDDksj92imoq5ZlAkBYtfq8AA1+0C5rlx2CKPL3DovV2WgevbYctL1oBL+CD18EJSoiHbGVSJzrJg50YmG4SaE6rmvjJ9+W1fc55tNE6NWo0EOzhZzlrHEvpkRquMUo2tLfueGGSwYVfxoEA33r50u0g5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcYZsF/MhIJP3YMunrs3d+GZDbj3mBA+N4adPWHLzoQ=;
 b=sHn7Uop6oI3h+K7eVb/8qHolqzCr9krCFgpopacbO//CFSkN5iS2LqIeynYobaZ3Cho+yOIQ7EHt4cC4kCfo5p75Fbe1QXf2YCaVKFfxNmm44GXiOepywY9QtNUXDhx0BLBacs9E3WoPnPAmFl2m10cwIrL9tPgUC29diivU6B8hV/0wQrmEtbr1+vqlBK18JBticmlpSB6IuBb/JcIaZ1PyAAT8dBHYpP3JYrjKhX+uIPdtfM3quLM//z/W9xQwzW0t+pveicO2VLKkoWULir4ghRZN/IMk/tQ31MoGgGETHQPPrs9MoRkPGCZbpTvTPGbB2k309R/CHndA2xhLSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:17e::23)
 by DU7PPF8B0E479D0.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::add) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 03:38:19 +0000
Received: from AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5]) by AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
 ([fe80::86f0:8ce1:a437:b2d5%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 03:38:19 +0000
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
Subject: [PATCH net 1/2] tipc: fix self-deadlock in tipc_named_node_up
Date: Wed, 28 Oct 2026 10:36:45 +0700
Message-ID: <20261028033722.125477-2-tung.quang.nguyen@est.tech>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028033722.125477-1-tung.quang.nguyen@est.tech>
References: <20261028033722.125477-1-tung.quang.nguyen@est.tech>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: AM7P189MB1137:EE_|DU7PPF8B0E479D0:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7b6377-e58e-4084-738f-08df34a4e8b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|261021123027099003|261026140227099003|56012099006|11063799006|261009223027099003|261022105027099003|261022075727099003|10067099003|261021121427099003|261026121527099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sHGqSMC9UY55pxkYV8ESXncKzL9SE+WUX6+XjNSTbI8OcGGRg7TG6HxDR16KApLG5J71TTOC18Mldsy/C3IghicwSThp1VcBDW67+5cxgWc9q8wzzIrc4gc7fOPnoNNOLP+oi0Jao1YHhT0hoEKJS2RhrfJuZMddNdO5FObkXYmgcsg4Ygm9o3MhIcSEyRHm5G2tsECUU7J2sxN8cBQGxnP9gcZqL2ypq2hBWb0YjlecsMEEKavAeRZykCHCK4JuyIUeauh3Qnv7lu01CB/aruxTZ2Nd6KLXis54c35LZ3KQ8KPVtlzFZG48biWkW+n3vgkONc+B4t3xM6KWklehFGT8TgShz4eFk6rPCMYK34wEcn+dqjDNbHnAKFaFT/1LzfRNl0azjaXLXAPQ9WFTWk5Mdglh+o18AGAlaa5JAa6dvpazddmo1vR3on0IthJaWOERt9r7W87P1kBC3N0+mfJOtA3d83nTfRjSsHNQnWaZLGSfLbcJv2naTAZ26MkbkoPbbbP+iqDApKdqmMFTdn11lTmqg4es4UYLq7X+r23Rt5pQmiRh7KYMgIdvrlN6/f0QyoswHUBMla87LYueA1VOTF7AYjFdIR3WWKIjfeHww/9rIzCHi87Km3YVzPet9b3EVCF1qApzIxUaoudL6f8MB5k7Y0zf9d8by2oEpSU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB1137.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(261021123027099003)(261026140227099003)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(261022075727099003)(10067099003)(261021121427099003)(261026121527099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rOFgvop8GHIZBlwWK4iMLCTR2SigoSQVkj8tTbnGxsFtJJS1DA5/pzwZBkjb?=
 =?us-ascii?Q?QK/eNFA36Lk7VdB3AoFgztyRHT1gyvR5CjKuXvkrg6Xz3wpKJUYC+C5SJ+x6?=
 =?us-ascii?Q?IPcFgp0pmobFK9PyDj1YQsyZIrihiDiRtrl1rA7wcamz5fyruwOP3hsQiovf?=
 =?us-ascii?Q?0odjXLOzAMKNCGIMyzpUT7Eg9g/ADYuS4CEHkZBrnitMOe2/Y1OxsvChRwrj?=
 =?us-ascii?Q?VQ+j7pHgRcGRjpakmAY30ySDFw7fsj0vunmaclf7aRqGB3J2uoIMWURdc2Oj?=
 =?us-ascii?Q?uZS9w9wrew/mQg7d0i+7NskRT1ht89WsXc9T0JeHO+CD118W2nkL9Jbirjka?=
 =?us-ascii?Q?IY7MuUM+s3QZnzbq9oHbZa7qAgy8W3etOd8LdpkS7xIPx3bsObIp0uQm5Y6f?=
 =?us-ascii?Q?AN7l+TZerOMR0l3x9To44yaHV0p/56zEFD3JJcPpXDdN8d6lDUUDJx3OUnTZ?=
 =?us-ascii?Q?1M+znPQslbMxAjHuVkPcFYXmPSistowYYw7M7UTZf0naAXEIcUIw66jjJnTI?=
 =?us-ascii?Q?Yrn3/1K2SmrxUFPUTcdDBZrXVuU40sAQ4f1Cd+Q3RMBArXrgJkRIL+TKhzOS?=
 =?us-ascii?Q?2tdv3hMTs9c6MUq7pis8/apHI0hXffeeQMM6yDmp+tao30ye6ewh+XB80niv?=
 =?us-ascii?Q?X8hvPLwkWsaP0ACuX9ZZ8G1f4OaB/sufWbG4O37IKrTGGVrgs+61WXPDQYGF?=
 =?us-ascii?Q?NypasrMjuRNaDZUOkWyMb9zTZNU/ez9pf/pq2dkrRMe11zlvEVgUtluXAZI0?=
 =?us-ascii?Q?TiOZeqUcZKwQ1NDs0v37Kt7DJqcUtDkz3ZpsGFvHn2BBZVdD5pwh6UEcGSsN?=
 =?us-ascii?Q?Vo/KFuOYbrH0ytJyJ2rmF2DCRjWM4VCAVZB92u9IIQ8Q6IDT50xP5v1jUq4X?=
 =?us-ascii?Q?GknpQX0mN4xjxaw4c+u6Ex1ZGuJzFYBIYP/fIwDokpDoKy6G8k6xDkP6aWiC?=
 =?us-ascii?Q?uUxcLKe2e5Vh5eyiFSYdtzH0GUjat9gazlHKPCApFgDx7nwm6RzAlxopIgH1?=
 =?us-ascii?Q?XR9vobUy/IgcfD1tL8T9tHMI9Dclmu6XUJk2aacKy/NDV/Nt19VDIcXZX8VP?=
 =?us-ascii?Q?YqC/uryxUbkVR/ld0Icy4efYBVvDZQ2MS7BKNDED9CFOctFRRI5Lqq8LiLoR?=
 =?us-ascii?Q?ARbFPQ7rmBQ41e+mexS8Wv1Ac38jup3JVy5dn/btCOKb/pXv8ACZNwcylQQL?=
 =?us-ascii?Q?wrupI2A2PneIKjIDG9s6OU2jTn8iNyP4D98BuxLQrwKg/1qeVNUZSEhQBsRA?=
 =?us-ascii?Q?jbx0WM5zOgQvSv1rE2VTcGOU+69mxnw1AL5uuubgjH2NAWU/TUWEUM5CaUti?=
 =?us-ascii?Q?hwsgq1kXpUA59VHQQQZHAs3lffEhWi5hqSkCEYoI7EF82VDcRZpSN8xXrELb?=
 =?us-ascii?Q?6eZX25bJX4aBW5zdYby2VIWjF1ZJVM+6Khmx259dWTynpeCbJD/hSsCSfq2N?=
 =?us-ascii?Q?sdIzjxr6oxrx/92pBYxSUiBkLJA2PlUENuIY5oAhKNldgjIAtu7UQzI/ujWx?=
 =?us-ascii?Q?OHNryIBPD/pGusNgvwEGdyNCP8v5GhwczZrtLt6v9MF/pbXQURpfI6O3H92E?=
 =?us-ascii?Q?fF3bomF2j2hu2MUbIxlJtNk/6kR8h+LF81Z5exI4zXGjm0Nse+7W/YXLEdPR?=
 =?us-ascii?Q?tTfuITbiQ3m1Z8zND2s25yP/32QcZyTUVRLbFCzdVPs0q8LMdZqQl0y+egb/?=
 =?us-ascii?Q?ebOxI9QZ+rkpdzJlAWza8nvajQZqxMDP4NCyGFq8jGTdZuoPuJO903FSu4oG?=
 =?us-ascii?Q?jjUNsa4aLumWL+Fr1uNa4FLD2tkt1liodQQmTP9mQNxP7S8jVFM9Us3LddK0?=
X-MS-Exchange-AntiSpam-MessageData-1: 3IvPAmg4YGgpMtJ3Cmr6hBj6CQUdKl7cCWQ=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7b6377-e58e-4084-738f-08df34a4e8b0
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1137.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 03:38:19.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOVhVzaNxroisiCzXw0FKtT1fscOKDHX+UYd0E4veY5WlaBcm5GmPs2gkrDcdpx8IVk0e/Nn6gpKjzPWPR9olH27rQ70g+uglDVJkmPGOL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PPF8B0E479D0

The following deadlock can occur, as observed during code inspection:

tipc_named_node_up()
 read_lock_bh(&nt->cluster_scope_lock) <-- acquire read lock
 named_distribute()
 tipc_node_xmit()
  tipc_node_link_down()
   tipc_node_write_unlock()
    tipc_nametbl_withdraw()
     spin_lock_bh(&tn->nametbl_lock)
      tipc_named_withdraw()
       write_lock_bh(&nt->cluster_scope_lock) <-- acquire write lock

Fix this issue by:
- Removing cluster_scope_lock, which protects the name table's cluster_scope
  list. Use nametbl_lock instead to protect the list against races when multiple
  threads concurrently call tipc_named_publish(), tipc_named_withdraw(),
  and tipc_named_node_up().

- Introducing a new function, tipc_node_distribute(), which is similar to
  tipc_node_xmit() but does not call tipc_node_link_down(). Both functions call
  the newly introduced tipc_node_build_list(), which builds a list of messages
  in sequence.

Fixes: 988f3f1603d4 ("tipc: eliminate message disordering during binding table update")
Signed-off-by: Tung Nguyen <tung.quang.nguyen@est.tech>
---
 net/tipc/name_distr.c |  32 ++++++----
 net/tipc/name_distr.h |   2 +-
 net/tipc/name_table.c |   1 -
 net/tipc/name_table.h |   2 -
 net/tipc/node.c       | 140 ++++++++++++++++++++++++++++++++----------
 net/tipc/node.h       |   2 +
 6 files changed, 130 insertions(+), 49 deletions(-)

diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
index ba4f4906e13b..a60f213ed118 100644
--- a/net/tipc/name_distr.c
+++ b/net/tipc/name_distr.c
@@ -95,9 +95,7 @@ struct sk_buff *tipc_named_publish(struct net *net, struct publication *p)
 		list_add_tail_rcu(&p->binding_node, &nt->node_scope);
 		return NULL;
 	}
-	write_lock_bh(&nt->cluster_scope_lock);
 	list_add_tail(&p->binding_node, &nt->cluster_scope);
-	write_unlock_bh(&nt->cluster_scope_lock);
 	skb = named_prepare_buf(net, PUBLICATION, ITEM_SIZE, 0);
 	if (!skb) {
 		pr_warn("Publication distribution failure\n");
@@ -121,9 +119,7 @@ struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *p)
 	struct distr_item *item;
 	struct sk_buff *skb;
 
-	write_lock_bh(&nt->cluster_scope_lock);
 	list_del(&p->binding_node);
-	write_unlock_bh(&nt->cluster_scope_lock);
 	if (p->scope == TIPC_NODE_SCOPE)
 		return NULL;
 
@@ -202,25 +198,39 @@ static void named_distribute(struct net *net, struct sk_buff_head *list,
  * @net: the associated network namespace
  * @dnode: destination node
  * @capabilities: peer node's capabilities
+ *
+ * Return:
+ * * 0               - Success
+ * * -ENOBUFS        - No buffer space is available
+ * * -EHOSTUNREACH   - Destination node does not exist or cannot be reached
+ *
  */
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
+int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
 {
 	struct name_table *nt = tipc_name_table(net);
 	struct tipc_net *tn = tipc_net(net);
 	struct sk_buff_head head;
-	u16 seqno;
+	int bearer_id = 0;
+	int rc = 0;
 
 	__skb_queue_head_init(&head);
 	spin_lock_bh(&tn->nametbl_lock);
 	if (!(capabilities & TIPC_NAMED_BCAST))
 		nt->rc_dests++;
-	seqno = nt->snd_nxt;
+	named_distribute(net, &head, dnode, &nt->cluster_scope, nt->snd_nxt);
+	if (!skb_queue_empty(&head))
+		rc = tipc_node_distribute(net, &head, dnode, &bearer_id, 0);
 	spin_unlock_bh(&tn->nametbl_lock);
 
-	read_lock_bh(&nt->cluster_scope_lock);
-	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);
-	tipc_node_xmit(net, &head, dnode, 0);
-	read_unlock_bh(&nt->cluster_scope_lock);
+	/* The link is congested after the list is inserted into
+	 * the link's send queue. Return 0, as this is normal.
+	 */
+	if (rc == -ELINKCONG)
+		rc = 0;
+	else if (rc == -EMSGSIZE)
+		rc = -ENOBUFS;
+
+	return rc;
 }
 
 /**
diff --git a/net/tipc/name_distr.h b/net/tipc/name_distr.h
index c677f6f082df..3f41e36efee3 100644
--- a/net/tipc/name_distr.h
+++ b/net/tipc/name_distr.h
@@ -69,7 +69,7 @@ struct distr_item {
 
 struct sk_buff *tipc_named_publish(struct net *net, struct publication *publ);
 struct sk_buff *tipc_named_withdraw(struct net *net, struct publication *publ);
-void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
+int tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities);
 void tipc_named_rcv(struct net *net, struct sk_buff_head *namedq,
 		    u16 *rcv_nxt, bool *open);
 void tipc_named_reinit(struct net *net);
diff --git a/net/tipc/name_table.c b/net/tipc/name_table.c
index 6fda36ab1766..8924bdb6a443 100644
--- a/net/tipc/name_table.c
+++ b/net/tipc/name_table.c
@@ -921,7 +921,6 @@ int tipc_nametbl_init(struct net *net)
 
 	INIT_LIST_HEAD(&nt->node_scope);
 	INIT_LIST_HEAD(&nt->cluster_scope);
-	rwlock_init(&nt->cluster_scope_lock);
 	tn->nametbl = nt;
 	spin_lock_init(&tn->nametbl_lock);
 	return 0;
diff --git a/net/tipc/name_table.h b/net/tipc/name_table.h
index 7ff6eeebaae6..afe665e68bb1 100644
--- a/net/tipc/name_table.h
+++ b/net/tipc/name_table.h
@@ -97,7 +97,6 @@ struct publication {
  * @cluster_scope: all local publications with cluster scope
  *               - used by name_distr to send bulk updates to new nodes
  *               - used by name_distr during re-init of name table
- * @cluster_scope_lock: lock for accessing @cluster_scope
  * @local_publ_count: number of publications issued by this node
  * @rc_dests: destination node counter
  * @snd_nxt: next sequence number to be used
@@ -107,7 +106,6 @@ struct name_table {
 	struct hlist_head services[TIPC_NAMETBL_SIZE];
 	struct list_head node_scope;
 	struct list_head cluster_scope;
-	rwlock_t cluster_scope_lock;
 	u32 local_publ_count;
 	u32 rc_dests;
 	u32 snd_nxt;
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 53b0993c2c23..b19d6652dc73 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -402,6 +402,7 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 	struct list_head *publ_list;
 	struct tipc_uaddr ua;
 	u32 bearer_id, node;
+	int rc = 0;
 
 	if (likely(!flags)) {
 		write_unlock_bh(&n->lock);
@@ -425,7 +426,7 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 		tipc_publ_notify(net, publ_list, node, n->capabilities);
 
 	if (flags & TIPC_NOTIFY_NODE_UP)
-		tipc_named_node_up(net, node, n->capabilities);
+		rc = tipc_named_node_up(net, node, n->capabilities);
 
 	if (flags & TIPC_NOTIFY_LINK_UP) {
 		tipc_mon_peer_up(net, node, bearer_id);
@@ -435,6 +436,9 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 		tipc_mon_peer_down(net, node, bearer_id);
 		tipc_nametbl_withdraw(net, &ua, &sk, sk.ref);
 	}
+
+	if (rc == -ENOBUFS)
+		tipc_node_link_down(n, bearer_id, false);
 }
 
 static void tipc_node_assign_peer_net(struct tipc_node *n, u32 hash_mixes)
@@ -1682,6 +1686,51 @@ static void tipc_lxc_xmit(struct net *peer_net, struct sk_buff_head *list)
 	}
 }
 
+static int tipc_node_build_list(struct tipc_node *n, struct sk_buff_head *list,
+				struct sk_buff_head *xmitq, int selector,
+				struct tipc_media_addr *maddr,
+				int *bearer_id, bool *lxc)
+{
+	struct tipc_link_entry *le = NULL;
+	bool node_up = false;
+	struct net *peer_net;
+	int rc = 0;
+
+	rcu_read_lock();
+	tipc_node_read_lock(n);
+	node_up = node_is_up(n);
+	peer_net = n->peer_net;
+	tipc_node_read_unlock(n);
+
+	if (node_up && peer_net && check_net(peer_net)) {
+		/* xmit inner linux container */
+		tipc_lxc_xmit(peer_net, list);
+		if (likely(skb_queue_empty(list))) {
+			rcu_read_unlock();
+			*lxc = true;
+			return 0;
+		}
+	}
+	rcu_read_unlock();
+
+	tipc_node_read_lock(n);
+	*bearer_id = n->active_links[selector & 1];
+	if (unlikely(*bearer_id == INVALID_BEARER_ID)) {
+		tipc_node_read_unlock(n);
+		__skb_queue_purge(list);
+		return -EHOSTUNREACH;
+	}
+
+	le = &n->links[*bearer_id];
+	*maddr = le->maddr;
+	spin_lock_bh(&le->lock);
+	rc = tipc_link_xmit(le->link, list, xmitq);
+	spin_unlock_bh(&le->lock);
+	tipc_node_read_unlock(n);
+
+	return rc;
+}
+
 /**
  * tipc_node_xmit() - general link level function for message sending
  * @net: the applicable net namespace
@@ -1694,12 +1743,11 @@ static void tipc_lxc_xmit(struct net *peer_net, struct sk_buff_head *list)
 int tipc_node_xmit(struct net *net, struct sk_buff_head *list,
 		   u32 dnode, int selector)
 {
-	struct tipc_link_entry *le = NULL;
-	struct tipc_node *n;
+	struct tipc_media_addr maddr;
 	struct sk_buff_head xmitq;
-	bool node_up = false;
-	struct net *peer_net;
-	int bearer_id;
+	struct tipc_node *n;
+	int bearer_id = 0;
+	bool lxc = false;
 	int rc;
 
 	if (in_own_node(net, dnode)) {
@@ -1715,42 +1763,66 @@ int tipc_node_xmit(struct net *net, struct sk_buff_head *list,
 		return -EHOSTUNREACH;
 	}
 
-	rcu_read_lock();
-	tipc_node_read_lock(n);
-	node_up = node_is_up(n);
-	peer_net = n->peer_net;
-	tipc_node_read_unlock(n);
-	if (node_up && peer_net && check_net(peer_net)) {
-		/* xmit inner linux container */
-		tipc_lxc_xmit(peer_net, list);
-		if (likely(skb_queue_empty(list))) {
-			rcu_read_unlock();
-			tipc_node_put(n);
-			return 0;
-		}
-	}
-	rcu_read_unlock();
+	__skb_queue_head_init(&xmitq);
+	rc = tipc_node_build_list(n, list, &xmitq, selector, &maddr,
+				  &bearer_id, &lxc);
 
-	tipc_node_read_lock(n);
-	bearer_id = n->active_links[selector & 1];
-	if (unlikely(bearer_id == INVALID_BEARER_ID)) {
-		tipc_node_read_unlock(n);
+	if (lxc) {
 		tipc_node_put(n);
+		return 0;
+	}
+
+	if (unlikely(rc == -ENOBUFS))
+		tipc_node_link_down(n, bearer_id, false);
+	else
+		tipc_bearer_xmit(net, bearer_id, &xmitq, &maddr, n);
+
+	tipc_node_put(n);
+
+	return rc;
+}
+
+/**
+ * tipc_node_distribute() - distribute list of messages to specific destination
+ * @net: the applicable net namespace
+ * @list: chain of buffers containing message
+ * @dnode: address of destination node
+ * @bearer_id: id of the bearer
+ * @selector: a number used for deterministic link selection
+ *
+ * Return:
+ * * 0              - Success
+ * * -ELINKCONG     - Link is congested
+ * * -EHOSTUNREACH  - Host is not reachable
+ * * -EMSGSIZE      - Message's size is too big
+ * * -ENOBUF        - No buffer space is available
+ *
+ */
+int tipc_node_distribute(struct net *net, struct sk_buff_head *list,
+			 u32 dnode, int *bearer_id, int selector)
+{
+	struct tipc_media_addr maddr;
+	struct sk_buff_head xmitq;
+	struct tipc_node *n;
+	bool lxc = false;
+	int rc;
+
+	n = tipc_node_find(net, dnode);
+	if (unlikely(!n)) {
 		__skb_queue_purge(list);
 		return -EHOSTUNREACH;
 	}
 
 	__skb_queue_head_init(&xmitq);
-	le = &n->links[bearer_id];
-	spin_lock_bh(&le->lock);
-	rc = tipc_link_xmit(le->link, list, &xmitq);
-	spin_unlock_bh(&le->lock);
-	tipc_node_read_unlock(n);
+	rc = tipc_node_build_list(n, list, &xmitq, selector, &maddr,
+				  bearer_id, &lxc);
+	if (lxc) {
+		tipc_node_put(n);
+		return 0;
+	}
 
-	if (unlikely(rc == -ENOBUFS))
-		tipc_node_link_down(n, bearer_id, false);
-	else
-		tipc_bearer_xmit(net, bearer_id, &xmitq, &le->maddr, n);
+	if (likely(rc != -ENOBUFS))
+		tipc_bearer_xmit(net, *bearer_id, &xmitq, &maddr, n);
 
 	tipc_node_put(n);
 
diff --git a/net/tipc/node.h b/net/tipc/node.h
index 154a5bbb0d29..775a8ec240fb 100644
--- a/net/tipc/node.h
+++ b/net/tipc/node.h
@@ -100,6 +100,8 @@ int tipc_node_get_linkname(struct net *net, u32 bearer_id, u32 node,
 			   char *linkname, size_t len);
 int tipc_node_xmit(struct net *net, struct sk_buff_head *list, u32 dnode,
 		   int selector);
+int tipc_node_distribute(struct net *net, struct sk_buff_head *list,
+			 u32 dnode, int *bearer_id, int selector);
 int tipc_node_distr_xmit(struct net *net, struct sk_buff_head *list);
 int tipc_node_xmit_skb(struct net *net, struct sk_buff *skb, u32 dest,
 		       u32 selector);
-- 
2.53.0

