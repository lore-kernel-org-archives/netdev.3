Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794439922;
	b=yzlR88FCtlMG2SiTAHbyklIiFFBYRJVzZmwqFpOZtIia7XWa4WZxK/lFc3/tjPvSSx6p
	 raEnCjKC4WzAkSL9AXbNIu4EFL3Znh1x9YBS1L48sQ7f4cscJRrvT8DkekzYd6/KiegqQ
	 UEpMau90mDTBgw3DAMTpgUWeB85v/LlUfsj91hud+Nu+s1UhwLS1Jy2S8RaWFbrPyAhfy
	 TwDHq2cxY97BHcCSRblm50VT7N0tanIhyOTQ0T9o1Z3pm0R/l7HDJdD+2rPyUjjS7v0vD
	 NEJl+cUsdQZWSJGgiiK9RdbLjJIt68zgcXPDGStAAM5IXXmDtS0J/1X94q26wKq9bLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439922;
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
	bh=eZ+cOMs/eKz5GtorVDjsGsXGdwxGuVJ8eb7y1I8ep7w=;
	b=YYPA8cvbRb20Rl9di2+bW4jBJk+lfK8QW1shaRyv9JuolqiP+56Zcbu6pcO8oSKjb9rz
	 MOVWUtVCMrDCJ/Ju6K2jnZGpg5YKM97jZfCNbdEUE0MuW0WtqPwVtck2+LayDeQphPhod
	 U5MpuDchRA8QTNGTAo/FB1sw1eySgKX+rkJhDS9njGT0R4Y8q2F6RrHZa1JgO4AsqX4yZ
	 ZHpLFKv0xhN9DlAg6XgCIz0jjRfez2mrQWBO3JSem+S26vG9kGfv6+klKjZFQKatjbhig
	 NYy4mr9levn8A9uNNSY6m+VOSUfKkailNpRMbvJC7xRJnHjxDk3aM0h2vgUVwtou2LA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=fq+WyFXk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.28
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11D6606A88E;
	Wed, 11 Nov 2026 23:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A11D6606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=fq+WyFXk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yC3z2yUSrPtX3ZRDiSKrXrhxTDQsAQJNut29dNvplGIE17f4DIwZ7TDJcYy9OpPOaehEp8Qzk0axzNptTT5UrDdHogJYYR1VSGxjaw1vjeJFBaOXcZ3rPeMeIImAJgBywHCjYk3xCubuWTyGYu+FM6ACw5Eo1R8O1OqXfPX1/4isKEug/ibC0peBWNiAfBRRF9n8uASDHUf7mJBxeMZakVOX+p07owwXAkrdn+iT7ZHowQmc3PLsXHt1p7mpPDKqsCdHNbcdSregt/zsp49u52YniKrcnAXojWBUN71c3jbTexxfeVzHKgFrtloUPfkbAcjBi9rXzQiJb3GioU2olQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZ+cOMs/eKz5GtorVDjsGsXGdwxGuVJ8eb7y1I8ep7w=;
 b=ixhqu4R2b3lNysufrqsYIr1wEQjwKDDuX3RhCP6FzWTz5GElMtiLnH022M+pd3XXHQzPhPNmwbFbbmbh3WIYrbM2xqg0REs7Yw8+r4ex4OC+LkMPDRzhfExjpXppoqAPzh5JbfGL9/1tufU/pGSDv/RFEre9Sk7EhnblX+Uk/JAR2HFC/08RpyhK+qAg65YTdPJ4F5//ASfVdYEbEo9OrDvpB15aODzn8Tg6ebXpA/bWnGJ4GEYC4quEo+6NZBZDIInl251IwAQE0YFGSTtECsMQnUeVr8vKpd5TslRuLBdTzgphyu4TKsUhuGqj+D0o4Evs1qTL/4W+Q7yye5v3Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZ+cOMs/eKz5GtorVDjsGsXGdwxGuVJ8eb7y1I8ep7w=;
 b=fq+WyFXkyU4Fr0Qja0HkYMhR6fgNioGnaJZlUPZCtAlxKdP6kJ7jO0Hk6YWDB4tLYeh5qIoj0ep/yh1EwJA1Ubh1RlwRv24VUqAemKHsUPYOz+Sg2Sbmkr8e5cvW1UMtCiflupnbAZu1Gq6+PDSnvus5dmMRvTetS0OTVTJLhlTvpbn34UVS/Fyem2FqWxEUs7cR9yJ4qhDuGA9ACMWYxyN1Wir0AIYGTVr3Jv7R1RgOd026Er8bMPGBGUgsdJ28PPuC1LTXA+ZBFJ8DJmNci0ATDvnIlwBYqrWG90yXwkcVqHCQdazP7HJ0/tD3SM2I+6+3l2XR5gfyvVhshRAv/g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by DU0PR04MB9249.eurprd04.prod.outlook.com (2603:10a6:10:350::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 23:32:00 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 23:32:00 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: enetc: let core segment GSO super-skb when headers exceed TSO_HEADER_SIZE
Date: Thu, 12 Nov 2026 01:31:49 +0200
Message-ID: <20261111233149.479596-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111233149.479596-1-vladimir.oltean@nxp.com>
References: <20261111233149.479596-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::14) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|DU0PR04MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 999a2673-81bd-4eea-2872-08df404bfbba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|10070799003|366016|1800799024|19092799006|11063799006|261028144727099003|10067099003|5023799004|56012099006|261021135927099003|261021123027099003|261026121527099003|261021121427099003|261022075727099003|261026140227099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	OAz3sKoISB/PKXMu3vMA1y0+ETYJytFYdF7lTLdbFYheHlxB/t4LqEhTm/6eJ+cjrluKCp8i6jQeTthJuI9HRgb8wNqeGTvGhDB63EOkFe7+YdIJp4TPSAK/+HNtQxWAZte3hNFZoy4gzxfJ+bSG2YbfK3v3rRmJdX8Gr4tl9UcTKF72IsoRq7JlhEnoUGpp9+pjsUu5urmLwKgqNzmCSJH5ZLczSdGussdvy3WblymNj49nqhp4/j79OIJ101gyXg8Idx9/W6kfR+JIJdpbAe5/lau/45kO4v/slZYEH4UaAwwYdoyK/s4rCBOU5yBdhWi/ULdPM5foHvFwbBOriGgk+g9+GXPkDu8aktSrPQxatjOKv0odNLtA8eRJGY/4jyfcl3yZwl4by2aReHnVpUtqavGk22lGnEcDgbp8t1oqgIOyW3VTEke35iQoNp1qtyEAPSmpD8Ky8/t46zO+OvtWoUq6/Lpi+Ll3vN5Eb1QNlE6zMamD6RzHaVkpLCc8c+bmVMW9SVf8XWOUuZoBHFhixsuBYzoG42y4JwBtRUfNjTaFQSW4gEzvJ2knbzk0MZQuyhumokyuvGljTfubYOTHc57yOXbYbA/nHn1ppcwK5NlIP7NvwFW9EmQg6UG/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(10070799003)(366016)(1800799024)(19092799006)(11063799006)(261028144727099003)(10067099003)(5023799004)(56012099006)(261021135927099003)(261021123027099003)(261026121527099003)(261021121427099003)(261022075727099003)(261026140227099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gdG4cTwhGWBgXYFEHE6wg2vWv2FKa82mHTy/+cRpw+hlkUO21Ix/EsMwAY8B?=
 =?us-ascii?Q?VVF0Zkur+r7pBUoQ+ux0rdT+ITYrKMTAECLVD2NRHLk52vYQwzm8yRjlvnZ8?=
 =?us-ascii?Q?Az+mFAUHohC17OfLglc7i7nf8FeefWRkowgdgjyNjlkLoeogFCNHEK8jXyip?=
 =?us-ascii?Q?U9J/YCMOhSC1WfR6OGziXS5/jzwJJUo4kt4WSUmSu9kr6ATSMoOX8yo+gj1k?=
 =?us-ascii?Q?mrcadk7/bF+Ax2uz+fLWqQGIP1LU3Q6hggE2+S+G+f3qYckaU4s5mVgmGYPG?=
 =?us-ascii?Q?Vl0/Gaid1pvqxoq3ayLTmIiHo9QoOSJEUXyX1WCCXYudsaWhu3z0/8rpXqFc?=
 =?us-ascii?Q?0OledVVcQW3kM87nd0NBU6EGwot48qPp2B8VIstQVNd5H7s9BYRDIB3zt+HW?=
 =?us-ascii?Q?26fB2FPyleSSx+oijRICBXXMhwmG8pxQ8SObd0W/Z8xlXW8rBKSBP2pfdR0/?=
 =?us-ascii?Q?wpMo6Rm0N6foMxj73vDIqBv/I+qOA/3KtxBTyOdEhkfodgoif+ME91YWMlwF?=
 =?us-ascii?Q?BTwbXgZ/8S+e1aQjOGdApmqj8Ga6FvDjCAJvVVEtFWw2WlSj7IS6L/XFEJ4o?=
 =?us-ascii?Q?WeLYSBOoLE1myKkpij/1Mejek41F7Ebq8K52NHf+hRK4g9zNYv871kcYz6/+?=
 =?us-ascii?Q?sdGwvenhLzRvqQ73dFNCGpeTLjkZuOL3Sm7LuHK7A4qqHtJuXo225KqhNRkD?=
 =?us-ascii?Q?BMjvScrVSytFmrVNDv6LlWa5EfRDxm1IPXfG5Yb0J9jPqzPJD8sPq13vTEMH?=
 =?us-ascii?Q?AJD7nzf3PUP+wP+I1UzV+0TVEV7XzDYzg8JY9MFSoXcFOgl6jexMP2QAI0I4?=
 =?us-ascii?Q?hfKbnliavdsRW/jrvzXAlnTtKyLjqrAwKQK9DuA7x+TxCk7r6FBTNtsvGb0l?=
 =?us-ascii?Q?pksbh/3lJmsB28OxZKlARwI+rH1Cn+cyEN0L3NYbLugGBtbvLq7JrIdrMTIl?=
 =?us-ascii?Q?HkH8GeBzUZ6X2xigBV1uKw/ukeBeyP8nCCFdsrpTClnCZP1dmARV0wEHaygl?=
 =?us-ascii?Q?r0tsKmgRhcS/IYOZtLE0MolS3e6FyzH5MwAsbs7PJmHSVXJWlIdjM7GV6FJw?=
 =?us-ascii?Q?3kODduZkkkxYubkgLkh27mFKviLCsNcYQOPdrmb9ZZjgFhDHp9oIJ+D+IiDg?=
 =?us-ascii?Q?89aimTSPzHtZ0LcHSfLcCEDGxOhdV6yLffFN4m9s5EVz3P+hV7ioWxbyvODT?=
 =?us-ascii?Q?Csjd7CmeQN7Y1dVqBX7vSXRnPGi7trfZH1B25S3SJ2JQe7Q4sfCpJK6a40s2?=
 =?us-ascii?Q?sUSJeFIJm3kTnWRLPHnXXhw/gwEb1yiqEFQapcthtidxAOO6xWW4x41aKU25?=
 =?us-ascii?Q?9KDepMAZEqr1zMw/kxiC4WNacGGJImH8r6Wpl7QUCgW23uxZD2yCR2tU9d0i?=
 =?us-ascii?Q?ggNPggQZAZJhdi0RVSb6trYMKiraef5HrAqjgwevW/anCud1Ryc0oi6LLjzF?=
 =?us-ascii?Q?50TFOomkV9QGo7qZ13I6pz+cE3IHOFeRcLQNGlUeWCxHUinOK+8oI4xed9rG?=
 =?us-ascii?Q?UOdoXx4dgtmfpBQlv40MWqaGzWJ6Yn68SC+7tZlD5diWhwwy+i/KymcNFEV1?=
 =?us-ascii?Q?++DJ+uaoGErz2WLJDzDsFd9oct9QFTiBwkQvVBc253NrbvFJUcHYHMl66AQu?=
 =?us-ascii?Q?yIT9N26knEFTbN9QwHPqqnQHZhx391etVUtgBljmEoIIZ0PpoIz8JkhqWpvb?=
 =?us-ascii?Q?rHQ1XbKDyuM0fjLGUaL1F8BJ1NH9HdlCNXYYp0pJcJoiJkQPaeEPJW4oO/kP?=
 =?us-ascii?Q?VwFbyq5rOqxZzM6Kc58doa5fh+7eA3rnX4ZW9vhdINghbR+iT/7DRMl6KEFv?=
X-MS-Exchange-AntiSpam-MessageData-1: gbwOcUy62+Fc3A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 999a2673-81bd-4eea-2872-08df404bfbba
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 23:32:00.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sl7E+J0+hp9lxA14bXq70Fi3fbBhR2TfveBEIM50l7cCOs+sT4IhhV+EHGqs47of9HsK8BO8dzunrIb7H1E98A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9249

Like many other drivers, both the software TSO path
(enetc_map_tx_tso_buffs()) and the LSO path (enetc_lso_map_hdr()) copy
the L2+L3+L4 headers of the skb into a fixed-size TSO_HEADER_SIZE (256
byte) slot of the per-ring dma_alloc_coherent() header area, without
checking that they fit.

Sashiko casually points out during review of an unrelated patch:
https://lore.kernel.org/netdev/179294166520.3134.18097439321876673016@kernel.org/
that TSO_HEADER_SIZE does not constitute the maximum size that packet
headers can have for GSO super-skbs, but rather, an essentially
arbitrary number.

An example where headers can exceed TSO_HEADER_SIZE is with an IPv6
extension named Segment Routing Header, set through setsockopt(IPV6_RTHDR),
with a type 4 routing header. With 11 or more segments, the headers of a
TCP/IPv6 packet exceed 256 bytes:

  Ethernet                14
  IPv6                    40
  SRH, 12 segments        8 + 12 * 16 = 200
  TCP (with timestamps)   32
                          ---
                          286  (30 bytes too many)

No privileges are required to request this socket option (but it will
cause driver writes outside allocated memory). A reproducer sketch can
be found at:
https://gist.github.com/vladimiroltean/7cecf636b788b29f361a2fbdae646010

Bizarrely, enetc is the only affected driver, because the core
accidentally protects most other drivers against this bug in
gso_features_check(). There, we have this logic that saves the day:

	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
	 * so neither does TSO that depends on it.
	 */
	if (features & NETIF_F_IPV6_CSUM &&
	    skb_has_ipv6_extension_hdr(skb))
		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);

enetc is the outlier because it only advertises the more complete
NETIF_F_HW_CSUM, so for it, this fixup does not clear the NETIF_F_TSO6
and NETIF_F_GSO_UDP_L4 bits.

[ astute reviewers may ask: what if we disable NETIF_F_IPV6_CSUM at
  runtime, via ethtool -k, so as to bypass this fixup, don't we make
  all drivers vulnerable?
  No, because netdev_fix_features() will trigger the code path which
  also prints "Dropping TSO6 features since no CSUM feature.\n".
  So TSO super-skbs will now be segmented in the stack. ]

Surveying every driver that uses `TSO_HEADER_SIZE`:

 Driver  | TSO6 | Checksum feature    | Core guard fires? | Verdict
 ---------------|---------------------|-------------------|---------
 enetc   | yes  | `NETIF_F_HW_CSUM`   | no                | vulnerable
 bnxt    | yes  | `NETIF_F_IPV6_CSUM` | yes               | safe
 nicvf   | yes  | `NETIF_F_IPV6_CSUM` | yes               | safe
 otx2    | yes  | `NETIF_F_IPV6_CSUM` | yes               | safe
 fec     | no   | `NETIF_F_IPV6_CSUM` | n/a               | safe
 mvneta  | no   | `NETIF_F_IPV6_CSUM` | n/a               | safe
 mvpp2   | no   | `NETIF_F_IPV6_CSUM` | n/a               | safe
 mv643xx | no   | `NETIF_F_IP_CSUM`   | n/a               | safe
 dpaa2   | no   | `NETIF_F_IPV6_CSUM` | n/a               | safe (*)

(*) dpaa2 also uses a fixed-size `kmalloc(TSO_HEADER_SIZE)` per segment,
so the identical overflow would apply if it ever gained `NETIF_F_TSO6`.

The above survey is what influenced the decision to make a localized
patch in enetc_features_check() rather than create a huge disturbance in
the core, even though, IMO, TSO_HEADER_SIZE is a huge foot gun.

Fixes: fb8629e2cbfc ("net: enetc: add support for software TSO")
Fixes: 69797ff888d3 ("net: enetc: add LSO support for i.MX95 ENETC PF")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 7f089a84d9a6..3c5478238e35 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1122,7 +1122,15 @@ netdev_features_t enetc_features_check(struct sk_buff *skb,
 
 	features = vlan_features_check(skb, features);
 
-	if (!skb_is_gso(skb) || enetc_skb_uses_lso(priv, skb))
+	if (!skb_is_gso(skb))
+		return features;
+
+	if (enetc_lso_get_hdr_len(skb) > TSO_HEADER_SIZE) {
+		features &= ~NETIF_F_GSO_MASK;
+		return features;
+	}
+
+	if (enetc_skb_uses_lso(priv, skb))
 		return features;
 
 	if (enetc_tso_count_descs(skb) >= priv->tx_bd_count)
-- 
2.53.0

