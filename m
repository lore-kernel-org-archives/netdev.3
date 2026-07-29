Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CF142B731;
	Wed, 29 Jul 2026 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785310791; cv=fail; b=OfoRjhhnBbnW0fX0Zvjt9pz1lPPgqPjKCNSuT3tbEEFmfIrXbMudV4rMKHOtdaKQLhBory5kL1PoqVsha7hDgjihfrAbq3zaQXhlR9xHF9G8/pvIapGjykLwbBdD36hcs37kwuHN2PPLNry6UoXeHloDp4EAt/ZW9/K/xmFh1qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785310791; c=relaxed/simple;
	bh=AjD92tKM4A/sFRSAP8eFhl69L+ifrvvXbcTnE1hzsEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RYphle9hfm130+y4EHom2sEZNN9AyX5P2zIIs19+pXxxt2z/iDJ6LJ6hhZrHzYiw4PG79pVo3oMbSm0CWGhqaS64EKbUaHR8EVejZNBkPKJ4EQeHeUMm569R/yXyUBSjCoVAX6nE49Z3Mr6CYQW6QaIzbpF/ycMoZf+n/62BTbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kWqj1mNT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=cPS8Fj1g; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kWqj1mNT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cPS8Fj1g"
X-UUID: a600ec828b2011f18dc8c9802ae25ab1-20260729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AjD92tKM4A/sFRSAP8eFhl69L+ifrvvXbcTnE1hzsEI=;
	b=kWqj1mNTIS/UbQMnDN1AXIh4+PYl7IVty2XDOxfL8SuzVeOddzaehhDAsjq9JxvVkQV6jvEsgrXM+W/Togf6v3L2/LefDS/t8UDHNMqgrVZ+2aeOZSTTLHaggRYjfgOKKJUVj6ux0T/xpZAvtUOVD6FZBdgNtqvJTK1nk9o4Umo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.18,REQID:b9264901-bde3-41ef-a296-82f4631d9d9a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:8a735a6,CLOUDID:30cfb033-ecf5-44a3-a34c-573dcd551473,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99|100|101|123,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,
	QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,
	ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a600ec828b2011f18dc8c9802ae25ab1-20260729
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <zhaoping.shu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1585310411; Wed, 29 Jul 2026 15:39:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 29 Jul 2026 15:39:35 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 29 Jul 2026 15:39:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7lxVQGFESC4SMZdJIQEJSLF77GIvTaaN2cot8m8GJhw9UcWOpmGWgyRgZ8ZpTY5wLAcG6+wB56sr/xZkGFI6I2C94Gb/VZD33uPeMNfOfUc9TFW74dQBScYXUI93cy9aj7xcJVZKx5kLPHIM29pZxXQnNPYK1lZsvM7J95zLDtYg72INnD1BFNogrd97J93GJ2Td92yzhPwwoma9A91gwBikMSZ/B4TTZobxAftkFXHODYEX+9pqiCw0vwFCcKBt8Ll/pMUcJxEgBOR8a4DJfpYafYx4PUbjyDyosSiMR1grYyhqJeYsu9URWp7FQaR/MNqpbd3XeoRvDWaIPFQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjD92tKM4A/sFRSAP8eFhl69L+ifrvvXbcTnE1hzsEI=;
 b=ra6SDe682VZimxm3e/N34z4ySKgnYHfFKa2peRS+FiGU+bQy4mJy5aMofVQ347hVMSLpwEXT5owDbODmWPRutQUtDGquXkwRvMJpqZPJETiaWdQDlgdCi63mNf3NSiEkSW9YD86W9D+rcYdKtBSwgtELd/b6Uz/aLUZGQaJepcDfFSwt0ZMgoizke9+H/eXEOsJDofO9V/ogKWWEKTjXvLXpIh8iiabJ3x+nrwlE6b0UpmMmSntofFJ/i9gM0oi08Iu8In2QfSAB56izZy8NjeSGaL+geOArwuKwLX3nBZpq8pU8p1VkDgSWiUwI2VQiDlWayd5rTNYwSh2mWIeobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjD92tKM4A/sFRSAP8eFhl69L+ifrvvXbcTnE1hzsEI=;
 b=cPS8Fj1gvLDM8O7UB6+ZS+9PaU3AZsrbLw0j7w+PLMZxHFeBY4oi2NsozslCOD/Pj6G3ButEkDlCN5Hu5t0g1uY22f8o+jnM+81Q9lgd2vD/jj4KDcG3CQ36JHgL8A+Qy2xKPG+Opx+F6jnpjkJqNg+7rCQvWrTLhMnBozHlx6Y=
Received: from SG2PR03MB6635.apcprd03.prod.outlook.com (2603:1096:4:1df::6) by
 SG2PR03MB6657.apcprd03.prod.outlook.com (2603:1096:4:1de::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Wed, 29 Jul 2026 07:39:32 +0000
Received: from SG2PR03MB6635.apcprd03.prod.outlook.com
 ([fe80::d6a7:ad8b:c6ff:fce]) by SG2PR03MB6635.apcprd03.prod.outlook.com
 ([fe80::d6a7:ad8b:c6ff:fce%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 07:39:32 +0000
From: =?utf-8?B?Wmhhb3BpbmcgU2h1ICjoiJLlj6zlubMp?= <Zhaoping.Shu@mediatek.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "willemb@google.com"
	<willemb@google.com>
CC: "sd@queasysnail.net" <sd@queasysnail.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "imv4bel@gmail.com"
	<imv4bel@gmail.com>, "alice@isovalent.com" <alice@isovalent.com>,
	"eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>,
	=?utf-8?B?SFcgSGUgKOS9leS8nyk=?= <HW.He@mediatek.com>,
	=?utf-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= <haijun.liu@mediatek.com>,
	"horms@kernel.org" <horms@kernel.org>,
	=?utf-8?B?WGlheXUgWmhhbmcgKOW8oOWkj+Wuhyk=?= <Xiayu.Zhang@mediatek.com>,
	=?utf-8?B?SXZlbiBZYW5nICjpmLPlhYkp?= <Iven.Yang@mediatek.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?TGFtYmVydCBXYW5nICjnjovkvJ8p?= <Lambert.Wang@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "kuniyu@google.com"
	<kuniyu@google.com>, "ncardwell@google.com" <ncardwell@google.com>
Subject: Re: [PATCH net v2] net: gro: avoid nesting TCP GSO skbs in
 skb_gro_receive_list()
Thread-Topic: [PATCH net v2] net: gro: avoid nesting TCP GSO skbs in
 skb_gro_receive_list()
Thread-Index: AQHdGoPpZQeEskAmQEC+Cb3VpJHrZLZ7HF6AgAAGToCACQMSgA==
Date: Wed, 29 Jul 2026 07:39:31 +0000
Message-ID: <0f5668da79eb9a13dfdb9c97c7d71c5153b3a48f.camel@mediatek.com>
References: <20260723091601.72103-1-zhaoping.shu@mediatek.com>
	 <20260723063935.75bf55e3@kernel.org>
	 <CA+FuTSfgBbPkdLanqEgbDq-jLVQJax4fUxQ-tuzTuFwQANwxBA@mail.gmail.com>
In-Reply-To: <CA+FuTSfgBbPkdLanqEgbDq-jLVQJax4fUxQ-tuzTuFwQANwxBA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6635:EE_|SG2PR03MB6657:EE_
x-ms-office365-filtering-correlation-id: 8d388cd8-6ce0-466a-f60b-08deed44878a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: Nz8QbILfH001eH73sPagJdpu0laAiaZvM4RcPsHHTSX1cqtneniB6Y8WFa4iiOec0LzRcbjZlyh4U8Ioh9SYXOx2N7GIu5WYfx2aIljPwGm67qnGYUas/RvxeC23e9bn3rZjLStPtt4545xYVemymgdFM9MA9zrHeM6AdZ5IQxbjxCh/1loHJWNdK8uATy8k10XzuwlGFqkK0Ai6gdEvmUPXf80I6Tw+0kGVKYuC6emZmfuwIuUwgyXEQpSRsqOZVdJRGvBn5igV6X7iGBfVg7pxnK5PN9xLfRM7xfjAO3E6HLGBI9P6IKRJzSC4xzR1jQ6dZSazQESeV5OmIrWVJft+vJRl+Er3L7G2uWRUB0niGg7SpYgnklD3qBiRISButoSCLeYku7YJKKg+kFNeCVBlEAXw1Zy2947vl2OV9X+King0Dw6XtfsfyP/N0W0ACQdknlJk8kL4zDgZxrsZsbOFmHCqjo5ciWqNdgD2tYjiCiuluFh4sctYgy2EBx88GE3xUDU+51w3w8wnHEhL/YwPcIPVaHcVXtYA9qEMDAKeVk+1MERQTFbcJ3z76y07nlf5LlXKdQ3Xc7OAo8JDfGir4f3/dKfx89H9lw079KaWaZmaHqMPahaRlglkOT+0993BY84VBLFFLCPkmG6jZX8BKHK3py1M7OYnLP+NwwhnOlQLSq8MxL1gloIUybt+ENt4nrBeHjLRoYjOo8DQYRYacQvHgUM+JpyEapGgTXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6635.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckhTTEtXZTlSVldYNlFrbVNVcEFnSUJjcmluMkJWWDFGcU5ka0dhc3JiVTBL?=
 =?utf-8?B?ay8yaWl1NTBMYkw0aC9WUnBmaTB4ZnlFYTMyVFR4SzFKWnQ0WmgvN3h4RVJr?=
 =?utf-8?B?Z3dDaWZXN3JlNFUvTHBaMmpJTjJXVVl4UTU0N2lzZGUwSHZtZnJ1M3p2TTZh?=
 =?utf-8?B?Sm5RK29DaUIxL0FoR200Tm5hVG5PUHFsbGJFRFdTSVhSUndEeGREU0ozSmdo?=
 =?utf-8?B?c2NMOWN6c2lwRkZ5Qk5nVHA0aHljK0tId3poQkZGajlTYWhOM2N2RWpzS3R2?=
 =?utf-8?B?S29ZY2NWd0g0U2hQZHF2d1R2VVNTMm5UdHhIV3MycXREeG00NVgrQ2tiM05a?=
 =?utf-8?B?SW90N3kzWlo4VE40bXBkZVkzVUUrd0pXb3k4b2lPQTZrQ0VZUGRMTUlhUlM1?=
 =?utf-8?B?YTh1clRoeFVmWHB0NmFiaEpxd2djRkVVVUh2akM2N3pIY2tkQ2VVVlp0QnBD?=
 =?utf-8?B?SUdsQWk3MEFHMjA1WG5XcFEzcUlaL2RBUm51ak01VGNTUG52TUQ3RmRyRW0w?=
 =?utf-8?B?OG92d1NvdmJHcm9ZcG9veHlqdWdOa0piaXIrSnR3eUppSGkrbTh1czdRelJV?=
 =?utf-8?B?RnhHYXB5MHVKdUNhYmtkR3VybXZmR2IrLzdFWHIwZEdvUWFlUFdCR2dwaGVH?=
 =?utf-8?B?aUpQMEM1ZUxYWjNqYy9QMy9sZnJRbDgxclpPNW5aODNJVk1zU0xmZlpzWTl3?=
 =?utf-8?B?UER2cEcrRFhyMXo5VSt0L050T2QrR1U1SFpkY2ltNTVRMDQxMERhU1g1WHJT?=
 =?utf-8?B?dWxPNXNSYUVoZFliZjdyRksrekNETUY2bDVFR3dremlWbmRGeVBZc0VmWnJj?=
 =?utf-8?B?Rzc4b1FnbDg4dGZVWXZ6d3F4c0NBK3pPZnlYS1pTd3dVaU92OXM0U1c4Skg0?=
 =?utf-8?B?UUo2RkcxTzk4bkRHSnIzMGU2bldQdzlRWFM2bnVFdTZENncvZ1ExVmRaQkJC?=
 =?utf-8?B?a0RoL0t2ZURkSWpPK294cGk2b2Fza3pmQUM2clArMlUxdnluUVpwRG1FZmFV?=
 =?utf-8?B?OUh5VFphdmZxVnRaVDdVTWhmc0w4VnZxakduekRsV1ZJdHRJSTFqRXl0bVhQ?=
 =?utf-8?B?VVN1Q0kwZ1hxZFVyVERCSDBJN3dOcjlzL2lOc3VaYkVJWTNwNlVTRkdQMkFT?=
 =?utf-8?B?T2RXckZrMThRanNNUDJ2a0RldkV2MmpQYzRLVzlpbDN4NVVrTnE5T210ejYw?=
 =?utf-8?B?QjBIeXpvOTZrU1pZOW1WNXJUYndxQUllNVFzbUxOOWtBUGY1VHlyZXVBL1pa?=
 =?utf-8?B?N09VdHdFd0l1T3E0cklHQ005aFVEMWs2bWgwMG1LK0poam95akJRbS90TWhp?=
 =?utf-8?B?bk1KT2dMMERsK0ZzN3FLL0pXdzVITW1WbG4vdW1DRU01aHc5cFNwKzdMN2xI?=
 =?utf-8?B?V1d2UjQwZ2xNcUxLRDFOK2VtY0ZBZzJpNTJmM29TL25TcExUbHRFMDlzNVRz?=
 =?utf-8?B?clJsMnlKckc4b1Y1WnNBeElZQ25ybjlxOUcwa2FrY3VkVkt0OHQ0UEdmL0NR?=
 =?utf-8?B?VFBVd1V1WlYwMDRvMU8zNm5zZ0t1OTE1SVZiU1RLNWVqT09SQ0E5Q05PVjRD?=
 =?utf-8?B?OWN0QkQzMzhIbUFoTlVLcHhrckxEczZIV0ZRNHFNb2hNV0VnMWFBME5CS1Vj?=
 =?utf-8?B?cHA4YUQvbTE3SEJoM2U2Y0RnRFlCbnlFVGdJUVJJcVVtZU9oNkZJY3c5OXpR?=
 =?utf-8?B?WmZPUTZYd3BLYklnayt4dzljQldCQTc1Y05ySDhGNFRhY1NiYjhiaE9lL2dS?=
 =?utf-8?B?NXByQVJxYkFLb1BZZzNiQklqbnM4ZXMrWVcxMjhFajdSclBJMmsydko2Mjll?=
 =?utf-8?B?OStlamFPaHFVc21FL2JiVmI2RTUrSFNqck9haVB2Z0UvRUMwazE3K2M5NXBJ?=
 =?utf-8?B?TGxsNFdjRkt6UGtEampGMzFjZjMxUzd1Vy9pWmRDRE1waktBWXZaakVvcjBK?=
 =?utf-8?B?ejN1dU5FVTFzOTlyYmxZNXpZMEpVbnZyR210VGtQOUcwZXZNWk1MYStEMjlx?=
 =?utf-8?B?REdtSEl3OGRRdzQyZFBQMGZaTndGVTZMSndqODIvSTFIOHkrWVR6SFk3RkJK?=
 =?utf-8?B?MmJMY3FQSGhTNmhNUGFNOVJTK3BiOVA2N3F5b2lwNmdNY2k5WFZqU3hRQk1u?=
 =?utf-8?B?MW40SWdCK21MYzJad3YyOUs1eitrd3JRVWxtRDNUWWp2cUplaGpxMGxuTVNI?=
 =?utf-8?B?SlBoZGsrS3lkZkRwNjJ2b1d1eVpFNHFPN3psNlJDTDVPMVo1eHZtRm12dllw?=
 =?utf-8?B?SVF5c3VnTnNMWUg1Q1hpN1ZJVHRHc3lhV2JrT0VUa1RVNmt5UFRYS01YWkdK?=
 =?utf-8?B?bnNSYktLWnJEeGc2UzZmNm92citLYm9YRk5nNy9zY3JEaVhEWXVRdnVtYy8y?=
 =?utf-8?Q?wxQZlIGK3c1m8SRw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AA78F1C9B633C4EAD0770482DB4FE06@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: J7p2W+f5rwoipbxqfw50TqRR1n/YdCNY6EWynPr7q61L1TJ92/Ow3pfrBtrKdPFwHdOXxlxHMLtZll67GGp0MkLZyjYzXLhbuZpAnsjaKNsq8HF5PCdw3TdxBJdIC15bWuBtySzwohYSk/OzXfpm2Mrdmejspd1cja5ESddvJugCouiXOtBVsJnU9KPDbUNlHWoyVBzKf0RrDIThUdRIFq+nkJdS0odOO8KrDtBaaHEZD5HxcSW7+delXctoohKtwshfTAnj88Nw8Yh9MQ2AdSJ5MY3OrP0uq3uQr/d8s130dcsCndvzRqvib7enQz0T0KMuqbVno+YVuVsWEAUgyQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6635.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d388cd8-6ce0-466a-f60b-08deed44878a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 07:39:31.9077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40RZkBNok6QPZnEmG672V4bfYuUBqkzERUpr3ree6SBRiVisSORC1zRmiOIOeNB7d+klDLFswF0pkVjXNalfzamCFY8nR3MLyCy/SCMXsRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6657
X-MTK: N

T24gVGh1LCAyMDI2LTA3LTIzIGF0IDE2OjAyICswMjAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiBPbiBUaHUsIEp1bCAyMywgMjAyNiBhdCAzOjM54oCvUE0gSmFrdWIgS2ljaW5za2kgPGt1
YmFAa2VybmVsLm9yZz4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1LCAyMyBKdWwgMjAyNiAx
NzoxNjowMSArMDgwMCB6aGFvcGluZy5zaHVAbWVkaWF0ZWsuY29tIHdyb3RlOg0KPiA+ID4gRnJv
bTogSFcgSGUgPGh3LmhlQG1lZGlhdGVrLmNvbT4NCj4gPiA+IA0KPiA+ID4gT24gZGV2aWNlcyB0
aGF0IHN1cHBvcnQgYm90aCBORVRJRl9GX0dST19IVyBhbmQNCj4gPiA+IE5FVElGX0ZfR1JPX0ZS
QUdMSVNULA0KPiA+IA0KPiA+ICJkZXZpY2VzIHRoYXQgc3VwcG9ydCBGUkFHTElTVCI/IElzbid0
IGl0IGEgc29mdHdhcmUgZmVhdHVyZT8NCg0KU29ycnkgZm9yIG5vdCBtYWtpbmcgaXQgY2xlYXIu
IFRoZSB0ZXN0IGVudmlyb25tZW50IGlzOg0KZGV2aWNlIHN1cHBvcnRzIEdST19IVywgYW5kIGVu
YWJsZSBORVRJRl9GX0dST19GUkFHTElTVCBpbg0KZHJpdmVyLg0KDQo+ID4gDQo+ID4gPiB0aGUg
aGFyZHdhcmUgb3IgZHJpdmVyIG1heSBkZWxpdmVyIHBhY2tldHMgdGhhdCBoYXZlIGFscmVhZHkg
YmVlbg0KPiA+IA0KPiA+IElmIHlvdSBoYXZlIGEgZHJpdmVyIGluIG1pbmQgcGxlYXNlIG5hbWUg
aXQuDQo+ID4gDQo+ID4gPiBhZ2dyZWdhdGVkIGludG8gYSBUQ1AgR1NPIHNrYiB3aXRoIGZyYWdz
W10uIEdSTyBtYXkgdGhlbg0KPiA+ID4gYWdncmVnYXRlIHRoZSBza2IgYWdhaW4gaW4gc2tiX2dy
b19yZWNlaXZlX2xpc3QoKS4NCj4gPiA+IA0KPiA+ID4gVGhpcyBjYW4gY3JlYXRlIGEgbmVzdGVk
IEdTTyBza2IsIHdoaWNoIGlzIG5vdCBoYW5kbGVkIGNvcnJlY3RseQ0KPiA+ID4gYnkgdGhlDQo+
ID4gPiBsYXRlciBHU08gc2VnbWVudGF0aW9uIHBhdGhzLiBXaGVuIHRoZSBza2IgaXMgc2VnbWVu
dGVkIGJ5DQo+ID4gPiBza2Jfc2VnbWVudF9saXN0KCksIGl0IG5vdCBiZSBmdWxseSByZXN0b3Jl
ZCB0byB0aGUgb3JpZ2luYWwNCj4gPiA+IHBhY2tldHMuDQo+ID4gPiANCj4gPiA+IEF2b2lkIHRo
aXMgYnkgc2V0dGluZyBOQVBJX0dST19DQihza2IpLT5mbHVzaCBmb3IgR1NPIHNrYnMgYmVmb3Jl
DQo+ID4gPiBhZ2dyZWdhdGlvbi4NCj4gPiANCj4gPiBJIGRvbid0IHRoaW5rIHdlIGNhbiBkbyB0
aGlzLiBGb3IgR1JPX0hXIGRldmljZXMgcmUtYWdncmVnYXRpbmcNCj4gPiBpbiBTVyBpcyBxdWl0
ZSBoZWxwZnVsLCBIVyBvZnRlbiBydW5zIG91dCBvZiBjb250ZXh0cyBvciB0aW1lcw0KPiA+IG91
dCB0b28gc29vbiwgZ2VuZXJhdGluZyBza2JzIHdpdGggMTZrQi4uMzJrQiBvZiBkYXRhLCB0aGUg
U1cNCj4gPiBjYW4gaGVscCBicmluZyBpdCB1cCB0byBmdWxsIFRTTy4NCg0KSSdsbCB0cnkgdG8g
ZXhwbGFpbiB0aGlzIGlzc3VlIGJlbG93Lg0KDQo+IA0KPiBBbHNvLCBhZnRlciBlNzUxMjU2NDg2
ZDAgKCJuZXQ6IGdybzogZml4IGRvdWJsZSBhZ2dyZWdhdGlvbiBvZg0KPiBmbHVzaC1tYXJrZWQg
c2ticyIpLCBpdCdzIG5vdCBjbGVhciBhbiBhbm90aGVyIGJ1ZyByZW1haW5zLg0KPiANCj4gSWYg
aXQgaXM6IGFzIHNhaWQgIm5lc3RlZCBHUk8iIG9mIGh3ICsgc3cgR1JPIGlzIGludGVudGlvbmFs
LCBlLmcuLA0KPiBmb3IgQklHLVRDUC4NCj4gDQo+IEJ1dCBpdCBtYXkgbm90IGJlIGFudGljaXBh
dGVkIGZvciBza2JfZ3JvX3JlY2VpdmVfbGlzdC4gT25lIG9wdGlvbg0KPiB3b3VsZCBiZSB0byBz
a2lwIHRoZSBmcmFnbGlzdCBHU08gb3B0aW1pemF0aW9uIGZvciBzdWNoIHBhY2tldHMuDQo+IA0K
PiBGaXJzdCBJJ2QgbGlrZSB0byB1bmRlcnN0YW5kIGJldHRlciB3aGF0IGV4YWN0IGJ1ZyByZW1h
aW5zLg0KDQpJIGFncmVlIHRoYXQgcmUtYWdncmVnYXRpb24gaXMgdXNlZnVsIGZvciBpbXByb3Zp
bmcgR1JPIGVmZmljaWVuY3kuDQoNCkhvd2V2ZXIsIGFzIGEgZ2VuZXJhbCBydWxlLCBhIEdTTyBz
a2IgbXVzdCBiZSBzZWdtZW50IGJhY2sgdG8gdGhlDQpleGFjdCBvcmlnaW5hbCBwYWNrZXRzIHN0
cmVhbS4gSW4gdGV0aGVyaW5nIHRlc3QsIHNrYl9zZWdtZW50X2xpc3QoKQ0KY2Fubm90IGNvcnJl
Y3RseSBzZWdtZW50IGEgbmVzdGVkIEdTTyBza2IgcHJvZHVjZWQgYnkgdGhpcyBwYXRoLg0KDQpU
aGlzIGlzc3VlIGNhbiByZXByb2R1Y2UgaW4gdGhlIGZvbGxvd2luZyBzY2VuYXJpbzoNCjEuRHJp
dmVyIHN1Ym1pdHMgYSBzaW5nbGUgVENQIHBhY2tldCwgUDEuIFAxIGlzIGtlcHQgaW4gdGhlDQpn
cm9fbGlzdCBhcyB0aGUgZmlyc3QgcGFja2V0Lg0KDQoyLiBUaGUgZHJpdmVyIHN1Ym1pdHMgYSBU
Q1AgR1NPIHNrYiwgUDIuIFAyIGhhcyBhbHJlYWR5IGFnZ3JlZ2F0ZWQNCm11bHRpcGxlIFRDUCBw
YWNrZXRzIGJ5IEhXX0dSTywgYW5kIGl0cyBub24tbGluZWFyIGRhdGEgaXMgc3RvcmVkIGluDQpm
cmFnc1tdLg0KDQozLiBQMSBhbmQgUDIgbWF0Y2ggdGhlIEdSTyBydWxlcywgYW5kIHNpbmNlIHRo
ZXJlIGlzIG5vIGxvY2FsIHNvY2tldCwNCnRoZXkgYXJlIGFnZ3JlZ2F0ZWQgYnkgc2tiX2dyb19y
ZWNlaXZlX2xpc3QoKS4gVGhlIHJlc3VsdGluZyBza2IsDQpQMywgaGFzIGEgZnJhZ19saXN0IGVu
dHJ5IHRoYXQgc3RpbGwgY29udGFpbnMgZnJhZ3NbXToNClAzOiBbIExpbmVhciBEYXRhIF0gLT4g
ZnJhZ19saXN0IC0+IFsgTGluZWFyIERhdGEgXQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgWyBmcmFnWzFdIF0NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFsgZnJhZ1syXSBdDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4NCg0K
NC4gTGF0ZXIsIHRjcDRfZ3NvX3NlZ21lbnQoKSBvciB0Y3A2X2dzb19zZWdtZW50KCkgY2FsbHMN
CnNrYl9zZWdtZW50X2xpc3QoKSB0byBzZWdtZW50IFAzLiBIb3dldmVyLCBza2Jfc2VnbWVudF9s
aXN0KCkgb25seQ0Kc2VnbWVudHMgdGhlIGVudHJpZXMgaW4gZnJhZ19saXN0LiBJdCBkb2VzIG5v
dCBzZWdtZW50IHRoZSBmcmFnc1tdDQppbnNpZGUgUDIsIHNvIFAzIGlzIG5vdCByZXN0b3JlZCB0
byB0aGUgb3JpZ2luYWwgcGFja2V0cywgd2hpY2ggbGVhZHMNCnRvIElQIGZyYWdtZW50YXRpb24g
b3IgcGFja2V0IGRyb3AgaW4gdGhlIGZvbGxvd2luZyBwYXRoLg0KDQpUaGUgcGF0Y2ggb25seSBw
cmV2ZW50cyB0aGF0IG5lc3RlZCBjYXNlIGJlZm9yZSBza2JfZ3JvX3JlY2VpdmVfbGlzdCgpDQph
Z2dyZWdhdGlvbi4gSXQgZG9lcyBub3QgYWZmZWN0IHBhY2tldHMgdGhhdCBhcmUgcmUtYWdncmVn
YXRlZCBieQ0Kc2tiX2dyb19yZWNlaXZlKCkuDQoNCg==
