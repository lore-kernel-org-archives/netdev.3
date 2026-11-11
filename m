Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794417643;
	b=LO4JokT+Ev0SW6zYI4tOanca/esumU95ltuOsqmWMhTc+f9VFelpDNEAYvMo4dqzrSqP
	 mfKPZAhox64R6FL/A3HxtVUZm2hicgX08y/zPlfc7i87MQYbRjzUQuMacjLr9bbtDjail
	 OqS9Bj3wN1V+BgcM1YWSRfA9HAWlvDlIMZMxMuqbbnC1Mw6xyv7ftQI/0jouH5oqceoTm
	 6mO/ugk0GbUAT/nn8dYBuH75Pqy/Lb1XWIbVZ1k02QlcHaUZZarV7MNbxM+Gqhse+TBld
	 8lAoGNO1erakKq0OT1IgT8IPwd2k2LGs1RzGWiOqOLEaWcPruRpKiInvmhSQdkfnxNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417643;
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
	bh=w5yn43NFOqRPxokJfrBxEnMJ6WbcyW0JKzPQXo6swTc=;
	b=ZI/klK+e7gTQSvzwrCHSD05lAn1uslBWxOC50HhMYq3CwCfp5FEPrTDb9Jbv3C6c6Yi1
	 bggXMGPDPt9e9yR3KP3/iwBgp/PWe+9u7doJ7Bo7WOLIDnElPyWEOaD04WxRrPDUAceka
	 aRiw2cZEelazeYay8U6uVD4CFT5T8PNUs5LUKL3ylKPdYf70zwjgNjLQlH1ijw0CJjYuF
	 YM55SuGtwvmzt2tJLWpy9PGD8IuZQo2tOnm9jH+TQppqxg81c+9aD0c8mHUw9sh69vu1R
	 8eq/8NlY1yNS52fW6tpUWUdIkby9+UbfnvA6MNkYMLoKafg3xPVGT5JEbrPwzQfqCRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=amCl8SdP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.16
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C6606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 17:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E1C6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=amCl8SdP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dM7EMpFYAKtRBFJezYoq1+r2I+NTdpoxiqGa8m9IhijwjtOA0nCVg/AXbxSlKDtHgoRVziOW5xtgrezgZuElyypieEenqRviBYcGf1Duo6nDs4VX5uor9rbfzKTvSAH1uzV9sY8Ot82VRE1qlBLXysNs14JBn4BW6UINYfDaQmcYsRW25QxBb0jngCFk1mq9cEWt/iP9NbiwT7XR+StK1TvSCrKJAnaiqMZPceF/jEOTGOQqaLOZxLYRYFO1Oj2P4I7KTWgaXWKfIIk1cbM4CFBQppi+i4nR8A7QuO//lxVH8jTMqPKxSShzOljmnMdhz96GgEpIkU+EDwskF1J3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5yn43NFOqRPxokJfrBxEnMJ6WbcyW0JKzPQXo6swTc=;
 b=qbj1uLfjqM13iPEPIfSiE63mNJWJxAqqxOvGZBNJnusr3V3twpYTKAG1s9Ak4D5TiohIp/q26zlFHDZnzbajYCoAGYVM5sFeIoYVCatfvTlHh0egDpd28z4EZyAku/Es2agUZ7JzHy9ABcNbk9t77QJm8YQAepJgMxMA8OYRbtRDpy5MGsXLbNQvYeIHzLzzO7/jEDAduCBVkRm5/OGR1P2Ec5T4TQeHMlV+HVx2ZMUL3pt3DjnWh8eCIKsoqsAHl/lcE2L2XQ2fpl+tC4GsifGDq20391FlnOFCN8kq1yeykQ1FDUEji3klGIQEMolmfKaWYThsyuuMD4VWAskZgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5yn43NFOqRPxokJfrBxEnMJ6WbcyW0JKzPQXo6swTc=;
 b=amCl8SdPR7pv7ezz3EP18HESrv1KYIBPLPy+P5XMF+YqtEflHNIIqhpIYu2ISqZdvr+q37je6jOaKWkqoDk3rDW7U6Lo9oAazGZ+eUgjzEz84j9YyENfW8kEoXGYVPh+6UaUcbiVH4gHysd7tPx4L50GLJNw1bI6W9YdRg3rc/Vs0ifv1C/Jspaw4+gH9aXnaHo67T6/94OX9Y8LA4PfR7eWGPckSVOYvbrHLZK7znOH6mkvcPOB/TzM5Gy1fC9/RmBaNdm/ieEK62U4EILyRycHj3/zUZdqAanzeITUK6g7seTPChjweMwmko5OLBPgE2EKu8AJI8ImJisZp0hCzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 17:20:39 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 17:20:39 +0000
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	razor@blackwall.org,
	aahila@google.com,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/2] bonding: 3ad: Receive packets in COLLECTING state
Date: Wed, 11 Nov 2026 19:19:46 +0200
Message-ID: <20261111171947.2816258-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0019.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::14) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
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
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 0858d471-8229-4fe5-65a3-08df40181b45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|261026121527099003|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OWqrGiumqojS7r3io5yruqfSSyEV1TQWLptF4nfYElanwmk+J/5E7nnIkE935X894dVCImMf0HLzJ/UB0TduF+wZfZSmZpKpuSt+KXwvQ7OLVCdu0rApouRixeSP782mpSMpOYnLQ5s13Wj4lwGis3JhpST1tBtcNQ2yVKa58eIaPH3WV9fAatEU6huXPEKLEUTdNjzXM3s/uuTCUdhPQ/RkfPCv+yNN/WpW1g1/CqhnHYwDhbUZIY/WqNFbMdpcjbpsCQ1TDQK5dh/555B1r/ka5fOy+3pdzHOjj9X0n2QV239ZBPrSmolSEnbOX8EyD9hAgFSCsRELIcrfClPrRhd+tJyAugNJeYyAMMmMR+M4eKdw+OOhihSwb/RDRFQAOiAKTB7mdTtNOrzdMoG/pDRxWh/t0AUS7KAJogt5yk9x8HjRQ4sRRnEDTX2BSh+2Yvp5BnGPCyMNHkGle6LV1wFUSKAM7mIGolxVQzyOoZKefx8UbvJxooUfQrdIy+37L85sGBpD+skZDRk0NavVlvddjwoyF/mYfc8/+q+PSJ/rlJoSLh3k7eFBae3nzqPtstyFSuGJV2kBEAuCfkwN+H2q1m777XiT5b14SiMagw8xengbV5qzMGk2T8rGCYqRgL7vGsfPv2aeWZecBhQfoVCgN//upYQE2fgy1pB++w0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(261026121527099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xPQabAWDQ85XwVA7KREuZg0QDGPTzf2P9zmhXh0GCt5HO8LV6/UI85ufExjd?=
 =?us-ascii?Q?i0NiSutfqfLsPpZuU+2bjIMy8jDqkFpyOmaW+K9iElyEiGke2IZ+NDW967ws?=
 =?us-ascii?Q?iBOFIgDzFkXxfcOWh5HMF5omy2FhpPMKzKSqEaVhoOyPVENOxyEKPNjSyRqn?=
 =?us-ascii?Q?ROeWQBJbQFx2yZwAJKbJ6CED8uIRgL2zmgQenh6mnxyyr1szW/WreKcHcaFC?=
 =?us-ascii?Q?4wT2XGIXrAfkASZWoBoIBkLReNJdDpI1RPgGme0nekSSpfbW2xyygygYGHJ3?=
 =?us-ascii?Q?1OEk7OxGC0e881GyPdNSeiW+jfZ/Kzy2kqQMOSTeknwQjTjJcHTx6nu7/QP9?=
 =?us-ascii?Q?wUQ+52A82QHQG9bAGEzYjhl1+OOdHNTGBNnXo0CguDeGCJq31L+GYE9lsSRl?=
 =?us-ascii?Q?w3AY59Q8yEKbGDuEfQPnR5E6voZcX43VZeJ+C5v5FtHGPmZkG499MvqSJF0U?=
 =?us-ascii?Q?DcxOQbX1wgxgQf8loi2guK8nig7p1JpL6iKBnbRcK2C53bPnnxoQDtv9dQM2?=
 =?us-ascii?Q?oqYSgyjOV4FKqOhdblxTtr9aJP+1PySsWVeq9iILNrnW51kC4i1OJk4l/qIf?=
 =?us-ascii?Q?K1JMCRcZYawucbYl74iK2LzAOwct5Elqa0pn0yFcb4FMtBvtLxMoqL75itcJ?=
 =?us-ascii?Q?qvdPt7pCK2HAgSZAnvMUU089DV9ciiiXjp2cmAnYGQoWrpsc9UvXY0OnnENR?=
 =?us-ascii?Q?oV5eLGZvg6uSGJhtAoLfygbl1/7bS4Y5um6qBtJwoVLQtqE/TNgrnVVpX2AY?=
 =?us-ascii?Q?dXZekzaL6VKFRUDX+OArbZ5rxgKe6vIjcH21dRcbdH+pgyHN7Yb0zdsIpWxc?=
 =?us-ascii?Q?FTFCm9RcDmP4Bk0aIBui/l2G9mowVkrrmWIixIQR+Pp/cG3GRFbbrzRKYgfw?=
 =?us-ascii?Q?0vZy8clSxZTatBHbrduSJF2aB/aYbW8BVWvXxYcKWXElCY4jkQqlaEe8hpYe?=
 =?us-ascii?Q?S05fNMeBK8a5alclWCIZ8fr8wD9O112Hvpc77PgBkCKaBo0XMZrzvzw4u79T?=
 =?us-ascii?Q?LfzIOc5E7wMqyhlzjbRjjYPYZgg0bEyAZvVcDtEXoYZor7m0rYmV6DvJlIxv?=
 =?us-ascii?Q?HHLSJ9GOUWfw0G4ZwZxygm/IGIOc+rpS1JN4uU4zsZV2OgdWJEYqaYMFToWI?=
 =?us-ascii?Q?jDS+THvMaO3U/DKOIuEW4J54kSwBCXuhcEGzOoOkVOSUALVpQi223aKs+RdH?=
 =?us-ascii?Q?kSeIZ4WD+ZQh14uG9Fvgg35nzSzidxPVkl9tcUEZV59mP0t6hYFrkNfQgzgh?=
 =?us-ascii?Q?wnI5s+B4kLnnqldRGjgtSEMup9T2SflZz5N3zb4JlL5/DsDZY/smE7lvRKKE?=
 =?us-ascii?Q?B7F6geA8UZQxAVmxDhdSFn3Kfjcxdb/vTKILhOpSAKrtxVSVt8lNptfNuGGr?=
 =?us-ascii?Q?jT4qOspZcYaiRxuJoZ/fl7oqvXdW+bcpldiBM+/Cuup3vyuwvBRWcokM5ViO?=
 =?us-ascii?Q?cyvXYCQXvixF8Pw46Yjt1jlBMSH8c3rQ6ysijhXV0WfP/0Mfy/tvF6lgfqWr?=
 =?us-ascii?Q?7MdaIoA75mJRjGopYxd1oMVA5F2BMZlzvG0iKfaECx1WvRawduBOzm4EEdwV?=
 =?us-ascii?Q?oG05qRsyIVVpz67U6TV/CaxnXg/gc3kdnGCu4DKONcuFcUFCXaTRgnAsEOkv?=
 =?us-ascii?Q?+DyhK/4MP0IqHpQHpHnXA2Qe+/d5I1/4Fe9mI+zsGedv96dMwO0tX3vLNZ9U?=
 =?us-ascii?Q?C01YkPZoX5LHWDi8xwGIvn21/1ywYZYZfUvksp4xmI3967zg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0858d471-8229-4fe5-65a3-08df40181b45
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 17:20:39.3723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGL6Nd8ylPG51SWEYhNsxRLqYS6Cd5tdVyMwxaRG6f7zS+7zUUnrfo6DY7Ej+sPJQ4MKS2PpUGgrTK2eSqSmRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440

When coupled control is disabled, a port in COLLECTING state is supposed
to receive packets, but it does not. The bond only delivers packets from
slaves whose 'inactive' flag is cleared, whereas
bond_set_slave_rx_enabled_flags() only clears 'rx_disabled'.

Fix by clearing 'inactive' as well.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
    Targeting at net-next since this never worked.
    
    Known issues that this patch does not address:
    
    1. Changing 'all_slaves_active' from 1 to 0 while a port is in
       COLLECTING state sets its 'inactive' flag and the port stops
       receiving until the next mux state transition. This is not new,
       COLLECTING is a transient state and the option is off by default, so I
       do not think it is worth handling.
    
    2. The 'inactive' flag shares a bitfield with other slave flags. The
       802.3ad state machine writes them under the mode lock, while the
       'all_slaves_active' handler writes 'inactive' under RTNL only. This is
       not new.

 include/net/bonding.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index 598d56b1bc97..cb89aff437f4 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -594,6 +594,7 @@ static inline void bond_set_slave_active_flags(struct slave *slave,
 static inline void bond_set_slave_rx_enabled_flags(struct slave *slave,
 					       bool notify)
 {
+	slave->inactive = 0;
 	slave->rx_disabled = 0;
 }
 
-- 
2.56.0

