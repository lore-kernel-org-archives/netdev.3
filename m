Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.107
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794250686;
	b=vaGG8IBD48+1gRreJmzdIP33KDTWz7pdK8bZ7TttQShZzM67dWQDo7yF9vaftLxlYXcw
	 w3Y6r+xeJacRSsrMdcgE4u1iGC841lw41CZGVhYfjQwFlC5zmINvAi17+W7n7lmSnIRNp
	 U4lK8QWQvWd9ljE2A8hH/y1uG4C1w/ErfuzMndgnF5nta8EPiG7yemn6Wx4p4MKYF5Ro0
	 PgVskiNo4rXIJZuwCeP18WT6Ac+Ka/8MY0Jh4dUomRLRZZO7ABq1Bo/yuTF+pgm8+KPfG
	 eCdej6a3tDxI3CloLhjccmXYacS7EtojsCPwgW3YMEl/PPw+2w0HSG8pm4X2+31h+hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794250686;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BESS-ID:
	 X-BESS-VER:X-BESS-Apparent-Source-IP:X-BESS-Parts:
	 X-BESS-Outbound-Spam-Score:X-BESS-Outbound-Spam-Report:
	 X-BESS-Outbound-Spam-Status:X-BESS-BRTS-Status;
	bh=Al1N2DcEycY/mHX2HIs47nAZebRn/FO8L8mAphp9nbc=;
	b=gZJi6SAhg5oFA7DL41I0SUichVwrtaxdJ2j2BEVjkLf4OSd1li2uqBauJEE088nAgsAN
	 6208ETEc5AsALlP0DEY+J4jHt9DZkemwG3QtkRgy6qVQWgSTShVzPRbe62wuCbgpEj77E
	 XNkLCLTDIp/OTXFjatNvfoqmMWtOjZOIKbthI95+PwDj/r2K0eovg50R3oBG92DjV6Vkt
	 FdjrHvwdO5fZz/VeaQtgVWiwNn8ySzQZeEkEDfHAV8cgDdFyhSOOfunEhp/7yQ5Ze4/Zp
	 xBo/AV00O9B4N2I94benpchuEMjWyyCfT30MuUMwOxYtelJLxyJK5hyJHipBbILzqxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opengear.com;
	spf=pass smtp.mailfrom=digi.com;
	dkim=pass header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=lH3zrlXf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.222.82.107
Received: from outbound-ip173b.ess.barracuda.com (outbound-ip173b.ess.barracuda.com [209.222.82.107])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABD8606A321;
	Mon,  9 Nov 2026 18:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CABD8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opengear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=opengear.com header.i=@opengear.com header.a=rsa-sha256 header.s=selector1 header.b=lH3zrlXf
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021086.outbound.protection.outlook.com [40.107.208.86]) by mx-outbound20-206.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 09 Nov 2026 18:57:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdyR9P8TB9SglFM1KVD0d5ckIv8yIMjGss8wYSYS1+cTwVBUY3EXyUxdZHK43pICwMe6yu0kierOZiMxJ7kMzbwf7XOwPhhvFdfJE1XMu+/eI/6bY+uRQVgM08zpuCmForiTQ/qnLdK43Pt68Fjk48deLAXJ9m2oWADs5kYxWy7b5OG8COlcqhPk/o7aqfUm1DJjkVujYl2z3/HJT1iy4uBEB1i3Dm3dOlmcdjSA3/pQ+BROhPhXeLgzjjgjb/4LyDQZXpI5HoQDIMSe6arFFbxH6SEvKfEb32IcRQCbnoU+UMljFWRuYo9F9ZiHsGZg6B77CmIOAi5F4JfyUG/fLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Al1N2DcEycY/mHX2HIs47nAZebRn/FO8L8mAphp9nbc=;
 b=NvQgqbZcwgGRo3qCAnkchZ2aGZl9FYga81q4I0FpnPnEXJ8IaWhe7ZPuA2EIwQqngUJvK5eCMMkUpwhMulA1oJ+cRcU45ezVF7oIXptaFMglyMtsom9HvIAYcCbRElt/t66AmIO1Cx5bbPGOoxMwZpDOm9mfXGgYifgogbo+IOl5WKBZznZLCGkdkPhWFNJ+mnna21x/Y2G9XDl6zcsgIMIdARTIOgAEQHpEjlnVfSNycgXmqc+UqBOZuwJjcuiSpczMVqVNcp09JpC7gduatHSHOxYwNFwwK511W21tiGerP8R0ABE906GhuezsxlhMl8RoZQOXyUUobjbm25O2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=opengear.com;
 dkim=pass header.d=opengear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opengear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Al1N2DcEycY/mHX2HIs47nAZebRn/FO8L8mAphp9nbc=;
 b=lH3zrlXf53mX5rhObBUcVJqcU6pMvEgH3LKPoDipz3HZ4mUnCH1tibWV4Omn4fsn3DIHbNQoa292JDG6ZjNRAy0hkVUGPty9PuDLpsGd0IKl+ZLnUbniRDf7G1mzbMX6+js/VPgiM7iQmt3LvkYDAbIKmGCI3gZ2Q07Shav57q7pnPvtjOsXdUa4/+Bms5gDb4BOrUTfscnCQK6JzulePMh5XTp2a9adWJiOjX1koOTJb3IzoMjsRRJmYA6KFVeW7wSmpVGHkSvSxCKfTBybPm9Q1UhgO9ucRdzcvqsO7pB/pjeWC+lpaEnDennUnnULIcVGfOU4TMPuR8gXXycUOw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opengear.com;
Received: from DS4PPF6C5A39D55.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d26) by DS0PR10MB7017.namprd10.prod.outlook.com
 (2603:10b6:8:14a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 18:57:35 +0000
Received: from DS4PPF6C5A39D55.namprd10.prod.outlook.com
 ([fe80::975d:9714:9193:440a]) by DS4PPF6C5A39D55.namprd10.prod.outlook.com
 ([fe80::975d:9714:9193:440a%4]) with mapi id 15.21.0569.011; Mon, 9 Nov 2026
 18:57:34 +0000
From: Peter Hunt <peter.hunt@opengear.com>
To: netdev@vger.kernel.org
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>,
	Peter Hunt <peter.hunt@opengear.com>
Subject: [PATCH net-next] net: wwan: mhi_wwan_ctrl: say the DTR drop flush is best effort
Date: Mon,  9 Nov 2026 11:57:31 -0700
Message-ID: <20261109185731.182990-1-peter.hunt@opengear.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::9) To DS4PPF6C5A39D55.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d26)
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
X-MS-TrafficTypeDiagnostic: DS4PPF6C5A39D55:EE_|DS0PR10MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: e99bce14-23ee-4689-a4bb-08df3e93508f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|261009223027099003|261028144727099003|261102123227099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|56012099006|11063799006|261026121527099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TGgS6AsTLtAwv2nwFm11ZGWXrmFQad1SbfjB5JH/Hqh4roaloa0kPjGGS+eXQ7Ab3QWc6OdIDZyosgVfbwDL4c+00HKoAbl0KCnXrXCvuV5IxAzYj6LVxOvMbJ7dN0awAoYCr7ar07lBPuAjiSk9J/OuTLc+b4hypv3ug0CqGvNF8VtQmHq+XNhxsYA0g2TvuceCCYBo4H1moXjCA43yvzQwUh2gCqDS+EiF9cSy9k6ULcvyVCpcacuiZ5CmDZ/MhqnbEz2gAp9j+5spb/v2Evp4PfcdGsbefzw63Ut9N86Vd37mSEJFTDkBGm2EJlRuq+YBPlXnWP76qsaoBFklIqSVKyUyRpRkyIafrTkrDd2LScT6bacEmlOBQeCIof1ouyHclTFnSCUzGtUJbPzhvfaTOWAd6IXh7NXO73wp4LsDgxV3IOwczJH4lAQUVIZHQwSvpQ+w8xAlmgLS+Bl7PHZP3YVGwdNoHDfQVd3gV7nVU8A74cAMZts4hmm4DVQ92IuoxG604xp/seOoYxwXNOButIcwANuFd7XvkOn4d3lzNvUGV9eOGnxXNDlTbA27OKobmz+ZU+H/59oIBYHTxVFDz5bimI2L+Pvo6yU6VZOrqM3W+Sysy+zjaxitHwkR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF6C5A39D55.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(261009223027099003)(261028144727099003)(261102123227099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(56012099006)(11063799006)(261026121527099003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zlsex8663SNhLTjiLHudFb8w8Ab8ysSnr+KFwkflET4ZstOBCDwdigDmV2s4?=
 =?us-ascii?Q?cjH4UJ7gGqNUt2R7C6Bhz4i8u7JvykyyUot88rmddp/Y2TT5WIRQtztoYtja?=
 =?us-ascii?Q?8Rqnoj1N3vVK+FNuYIhmaCqiUD2PceQ5ItX+HFPPQ3HRcuN7AQJfuzo+bisY?=
 =?us-ascii?Q?F2obPgKiBCw3fVcJtKuLgdFaTtk7sOWXa8nyUMDXb3IM0Yjq5gDMKT5mev36?=
 =?us-ascii?Q?rVqT48ASl+mWdA7gecjKERV/oj5ycTIFvwK9yn994B5kNBqnctFZ2HO77nGA?=
 =?us-ascii?Q?BcXowdTBlrOapVEhLRa6DzKTXpiHkMnxHHls34Tf7FnOPVxDjddUm2T1QR7s?=
 =?us-ascii?Q?z4MdKersz8/qHZEayxsNyvo2zLTujxZ72mLdfSTiPm/jblokJerKULbhBSYL?=
 =?us-ascii?Q?7AZgV5rdQ2XuOEN00VUxV659hIKzH0y8tfQq0cnKrnPB/ie+LxKqM+bwam57?=
 =?us-ascii?Q?OoB34oGnlaQB8Dz36SeOuyB3KVG1VTjA4+GEL9t0lk3HX7ARGHyqMXq6mlHA?=
 =?us-ascii?Q?+4VUk7NA7nU/MW91h85XiuVHf1ULZFShlJjpEyowXA/BoX6cllkZWcKGWs4B?=
 =?us-ascii?Q?Q0JdQHM71YH7SQ+utgqkrJ2pevDKkUgvGTX+xkaiBzKaShbKI+FBJJcgJ5fO?=
 =?us-ascii?Q?E6O9vO11WiFNcCuQQ/DsvHZKNYho8VTMJVvK3JRTNYr2LXtk+TIymIFDjEwb?=
 =?us-ascii?Q?meTdQt7DfdE3dBzUCZfMlxeTmszvZJ/ur6sWTPLJwb6TJJvDNjLe02W8aRON?=
 =?us-ascii?Q?Eq3d4VU9hfePIeiQ23GAbDl1ZGcNJ8MqDEQWzIHFipTs7g+DeI8YsR4gvgXZ?=
 =?us-ascii?Q?NVibDffzFqGCq8ybyQLMU5OmFROD9/GQnrrwy6Ji8rq71bnf+9dJcURCiEQp?=
 =?us-ascii?Q?N4eCYgLXgBfzdg5SRP89bKGyL5/1iyIO8s1Fo/ySHGc6mo90ZKIiB/urRdSo?=
 =?us-ascii?Q?nzs5wEeFK60iBPrFtyajvqsCDqYFFekx8ZAVBeE9rt5xGFMEWAZdtPNKLbmE?=
 =?us-ascii?Q?1DnSWEZCTZyTWLJd5Uak2VGaBhMDYP8LZrrZc5tvHXpB+R3WUN1r4QR1C+fA?=
 =?us-ascii?Q?pAT8gK3dZDbkakPNzCaSYbS43KjdpRzo93INNqvDDa6cqCGZkL5HqAP2UvlP?=
 =?us-ascii?Q?sGnFxd3PDqmvXC82lq9z1Y+O0KSce9pLaPGtd31UJujmYqrOTWhUQLVS+ANt?=
 =?us-ascii?Q?4sa9zkZ/T16Nqjh/rszUbQWvVFfZlJp5YdyMwfaTBPlCY4rt8A1C72y8uHMv?=
 =?us-ascii?Q?XzL7/GwqsbTLCQZ8fPPKxgO7sFlIaix56/6gLDF/EF7twtnIz4bxgkj/VKTJ?=
 =?us-ascii?Q?Oh3eigErlCHOT7OQL551xd9Rhtw+9Z5D2REfGClMJ098sTvqsMvedTQcUezm?=
 =?us-ascii?Q?f5aPmHi14mWBb6N62KX7f9Qtihf0C0qi5tqaBswIa1rvFeLbHLkDEa79EZNy?=
 =?us-ascii?Q?uD8YhRHCWomr86/lwxr2dtdOydzezpHDWsn8E9YQVJyxpBnATJGJyyM1cToQ?=
 =?us-ascii?Q?E3JVk1VrIoLWo9vHedh4dRKm9imuyrw+3704Jn512SyLWYJzUirA56l0387Z?=
 =?us-ascii?Q?8RX5NtzRBfLm/biq5ECS+/zbX+fg0NqvWM4WTfoLLW44FHOmd/WXSXFDrSqn?=
 =?us-ascii?Q?EqiPHP86EUfkEqvx/9SBW7EoPY/RBPw1l/muGUtve6cltJe3JEfge4051fzJ?=
 =?us-ascii?Q?17j6Bqqyp3fCzrqC8um7ryQAcf0P3covcApgI7dyfkTWRm21?=
X-Exchange-RoutingPolicyChecked:
	4lupw3KYpsbIf7uuDRQO6WNOx5gBMhrKwbZTknlWYS5dr+r4sRUMf9hm8dxe0ehJJ1/GdVrN1q5+I93ZxNuGTcZlg8lBgXJiySwybX6hbUSUXvpJFlZc8VWwbx3CUSy7Ikp9D+owVD6ahkfwoUMVguIBrLxeGCW4krsYt5m9AMCJ6qg1wZeTk82zhxzDyxgOH8FewOvr7JaES4j9EG9xOJ05A9fCkl/6B8PRia5uv6inM0NikzxE93A2s8vXWRaH+d6Ek+WBW01/DkE2QAEqMau4tLWAVRsu/ysx5TVfxIdMRWX2/AtUECY+i36cd3Hb7A+M9rHq3Mvuf18r2qAKHQ==
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99bce14-23ee-4689-a4bb-08df3e93508f
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF6C5A39D55.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:57:34.5319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxaOm8CZlfh3o05VxSXh2bZ31iFx9eHNtWJt/P0aYQ3NFXTGUmIz1ThCX4UJJMHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7017
X-BESS-ID: 1794250658-105326-7691-1337-1
X-BESS-VER: 2019.1_20261104.2126
X-BESS-Apparent-Source-IP: 40.107.208.86
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGFgZAVgZQ0NzUxDglOc3CwM
	DMODHNyDQl0TTR3MQyJdHcLBkoZKRUGwsA2DxwyUEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.277465 [from 
	cloudscan15-142.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Three comments around the DTR/RTS work don't match the code since
commit 10f51f4fb99d ("net: wwan: mhi_wwan_ctrl: send a DTR drop before
it can be coalesced"):

- the ->dtr_rts() comment says the drop is sent now, but a drop that
  hits a full UL ring is retried with whatever state is latest by then,
- the dtr_mdmbits comment only describes coalescing,
- the remove() comment says the removal drop gets one attempt, but the
  drop and stop() paths now flush the work as well.

Update them. No functional change.

Link: https://lore.kernel.org/all/179340002701.3131.15535297427661129303@kernel.org/
Signed-off-by: Peter Hunt <peter.hunt@opengear.com>
---
 drivers/net/wwan/mhi_wwan_ctrl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index 772319927867..3610613e442e 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -68,7 +68,8 @@ struct mhi_wwan_dev {
 	unsigned int rx_budget;
 
 	/* Latest DTR/RTS state for the modem, sent from dtr_work so a burst of
-	 * changes is coalesced and only the final state has to get through
+	 * changes is coalesced and only the final state has to get through.
+	 * A DTR drop is flushed out on its own, see mhi_wwan_ctrl_dtr_rts().
 	 */
 	unsigned int dtr_mdmbits;
 	struct delayed_work dtr_work;
@@ -216,7 +217,9 @@ static void mhi_wwan_ctrl_dtr_rts(struct wwan_port *port, unsigned int mdmbits)
 	schedule_delayed_work(&mhiwwan->dtr_work, 0);
 
 	/* A DTR drop matters on its own, e.g. to hang up a modem set to AT&D2,
-	 * so send it now rather than let a following raise coalesce it away
+	 * so try to send it now rather than let a following raise coalesce it
+	 * away. This is best effort, a drop that hits a full UL ring is retried
+	 * with whatever state is latest by then.
 	 */
 	if (drop)
 		flush_delayed_work(&mhiwwan->dtr_work);
@@ -376,7 +379,7 @@ static void mhi_wwan_ctrl_remove(struct mhi_device *mhi_dev)
 	struct mhi_wwan_dev *mhiwwan = dev_get_drvdata(&mhi_dev->dev);
 
 	wwan_remove_port(mhiwwan->wwan_port);
-	/* Give the DTR/RTS drop from removal one attempt, then stop the work */
+	/* Give any pending DTR/RTS state a last attempt, then stop the work */
 	flush_delayed_work(&mhiwwan->dtr_work);
 	disable_delayed_work_sync(&mhiwwan->dtr_work);
 	kfree(mhiwwan);
-- 
2.43.0

