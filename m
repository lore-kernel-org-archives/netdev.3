Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DCA3D75D7;
	Fri, 14 Aug 2026 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674612; cv=fail; b=MQP1WgdeiEWgI+ceOJ1NYy7GaBOdJ/D3hcdJUeKfyvG/BpVdoVOJvmIhIBuD+2dlucCwfUzYYy9abWohGhrfPlscLpKT7Oq4JkvMuvDU/E2Bt6CSY4o2iZ3Fj36BLZIFy498fs4SIyy60mrP5ElwBsFihdLjBXGNyLqMNBCBCUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674612; c=relaxed/simple;
	bh=AgLKPa00gnMfn/e+TTIL9GYECU1QVPfc0P5ezsUJmrk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AL25GiuXaOofVv8TtnVtg3l8hXUWfCvd0NAl979sJpf3TgqqehuoI/Z6QbGCLeIBX5P2kDQmd/NM2PULChkCS/0yefnObMlh349TloBAVpOXdNsradw/zm7FaEP/ODFoJiniGfPDJqt0kfMiubncNsjOwEssthXTp0DacWu91S8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=W80bx8jn; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tFN4RSRU; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="W80bx8jn";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tFN4RSRU"
X-UUID: 0eb29672978811f1b1788b6acf885367-20260814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AgLKPa00gnMfn/e+TTIL9GYECU1QVPfc0P5ezsUJmrk=;
	b=W80bx8jnfYJ4hNq4i+tlqw6/LCR0FnKOaKoyT5rz1QRdsdyce9VHbMr4ZqH/3TPjJROxIsn3pjc4HnMGcDjZXKozRbZ7gE7UoEZKC1vwDo3AeAcEnmrkWnlbdjhbvcGhsXHUeHOBd83rPuwVRI/FBgyPrkjGZe+opQTCAJcfQ1E=;
X-CID-CACHE: Type:Local,Time:202608141030+08,HitQuantity:4
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c10de6e4-66c2-4cec-bc2f-e236d5532185,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:f3b1b094-30ec-4a0e-a534-3a2c77ce0b67,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:80|1,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0eb29672978811f1b1788b6acf885367-20260814
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <zhaoping.shu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 962835497; Fri, 14 Aug 2026 10:30:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 14 Aug 2026 10:30:03 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 14 Aug 2026 10:30:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRSsC4toIjrKeGHjOp6tQdcb3vb50cmw0gxxVfmHOwcEwa2Z1lXWYcNWwJwNVcTohAolYQF7II8fNtWhStDH2TJgUN9bOsFxZuTV4x65W9/c7/5EKzZOcq3b8hxGG/W62snWF09L6knB04EkWEC+8RnWHinbnqzulMj5JYLNkHwW1msXC8BrMrbqs5VYHsHhWdyF/i0fnH2Ic6X4Abpvsp7RyMi4RD7T4wjEJjcRAISkwzWz9ji/LlpqvqxYkap4q6wykjuSijHS5PAt+UA/TMJh7HARi+C5Rx0lhqgIyDnG9bQW2BmMCFOtvtkidC6fyzHwz2gy/Z6+EvQC8j07Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgLKPa00gnMfn/e+TTIL9GYECU1QVPfc0P5ezsUJmrk=;
 b=iN2/GCqfK4vuglN91w2+F4xnaf+5VvD9Cwg5CXiIQToHIxXxiRrHGuge6A/2F1tnBMRmvH0Kn5CDyiCR9/V6wKrEI4uchTfZSBptpfh1koJmFS1FxQ6ru+kIJnW+6rTfmZRbX3VtZTHU0qDOeaYSeE6cyaoW9H0rSRYz0W0CLWpNk7ACzws+37pIKpYVCyjN4Pchl7uiOQcRblmwca14BUpZZU0NOQzcjdoi+t5ofS0FE/8J+csh9RdgcJ0TH8zsalp/sIaS3D7E1rRTj7cHUxA6VSlMDj/Afd90HxcvQW6cS9XHybEINT6BafJERu43gMN0Q8ZA6Y0aNFB6HNrx9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgLKPa00gnMfn/e+TTIL9GYECU1QVPfc0P5ezsUJmrk=;
 b=tFN4RSRUchiePwOGIpMtCv0EPDOHsgvnDwwXDB6yqBMl5OxUq2f3RKPnANTmPDQ3ue9jfiLE22mfNQLFw/vmklKsGxCpY0QoIqSZVZT4DnTjNRL/sk90S1DxmVQqeuWPJX1JJQoKAqvuTNuTRPcSyOkl258r3dHoMrFNt4vqu3c=
Received: from SG2PR03MB6635.apcprd03.prod.outlook.com (2603:1096:4:1df::6) by
 TYSPR03MB8590.apcprd03.prod.outlook.com (2603:1096:405:88::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Fri, 14 Aug 2026 02:29:59 +0000
Received: from SG2PR03MB6635.apcprd03.prod.outlook.com
 ([fe80::d6a7:ad8b:c6ff:fce]) by SG2PR03MB6635.apcprd03.prod.outlook.com
 ([fe80::d6a7:ad8b:c6ff:fce%6]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 02:29:59 +0000
From: =?utf-8?B?Wmhhb3BpbmcgU2h1ICjoiJLlj6zlubMp?= <Zhaoping.Shu@mediatek.com>
To: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>
CC: "kuniyu@google.com" <kuniyu@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "imv4bel@gmail.com"
	<imv4bel@gmail.com>, "eilaimemedsnaimel@gmail.com"
	<eilaimemedsnaimel@gmail.com>, "alice@isovalent.com" <alice@isovalent.com>,
	=?utf-8?B?SFcgSGUgKOS9leS8nyk=?= <HW.He@mediatek.com>,
	=?utf-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= <haijun.liu@mediatek.com>,
	=?utf-8?B?SXZlbiBZYW5nICjpmLPlhYkp?= <Iven.Yang@mediatek.com>,
	"horms@kernel.org" <horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	=?utf-8?B?WGlheXUgWmhhbmcgKOW8oOWkj+Wuhyk=?= <Xiayu.Zhang@mediatek.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "willemb@google.com" <willemb@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?TGFtYmVydCBXYW5nICjnjovkvJ8p?= <Lambert.Wang@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "sd@queasysnail.net"
	<sd@queasysnail.net>, "ncardwell@google.com" <ncardwell@google.com>
Subject: Re: [PATCH net v3] net: gro: Fix nesting of TCP GSO SKBs in
 skb_gro_receive_list()
Thread-Topic: [PATCH net v3] net: gro: Fix nesting of TCP GSO SKBs in
 skb_gro_receive_list()
Thread-Index: AQHdKz8oC6dNb05D20+TlvUOaiAP4Lac0xmA
Date: Fri, 14 Aug 2026 02:29:58 +0000
Message-ID: <ddb39bf238a544cb5c8a178dd0fc6e5cb682bbb1.camel@mediatek.com>
References: <20260813014056.160533-1-zhaoping.shu@mediatek.com>
	 <willemdebruijn.kernel.1372b82f50882@gmail.com>
	 <0e1f71c4417099399eda78fd2a082b2444e42af9.camel@mediatek.com>
	 <CAF=yD-+AF1aW5D5H_QPKE1yxyU2wLxOmT8c2Fm4CJsPY=BjW-g@mail.gmail.com>
In-Reply-To: <CAF=yD-+AF1aW5D5H_QPKE1yxyU2wLxOmT8c2Fm4CJsPY=BjW-g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6635:EE_|TYSPR03MB8590:EE_
x-ms-office365-filtering-correlation-id: c462653c-c216-42e9-06de-08def9abefc8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|10067099003|4143699003|11063799006|38070700021|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: hswCa1JfrnnxUunlNmJnztQ8XSQrykXGGWLouPVFyi8/OU4ekml/wcdzxGzgp2QffMwLCmt1P7f5pW/bGjA971fmi1dCrJur9oXCtLRno+JTSuz573tqhOVuuO2bXsr5S9rVBXHe3I+p+dE1XS9IFimK2ksjeCooU3TTy8BAcy+fJAt3bWUQneHkziJaPzccarroZGZECC4u0hLZnEKZiYvvYF4lvU+j2X/CLq0NKOM4lsAa7OBTjAKM2Q4ZM8PhIfdACrSo6m60X5+mFb4+0/uGdfn9iYPLHeu715Ke1eg+3C4IC83jTWnsMfltYasZHt95vm+JHgeFcLtoVzyokhNGc+g1RZ/AxNDD8sXrWsdKTRf6RCCw2DT3d7Dq/huAU7lwi06hUXxxpzmlNrrNEngOhK+0u+TbIU+EQDzpI5KP8wiYH811V74/YEGHmeyE+CcMPVmEGarrVWm25cJoMtS3DisUP5MvrdVctLNWeefxW5ExMo5+AupNg4EG+8US1LBtsEXefUAwhKRipmxQwY5LzRiIVqPYMOkIIDqL69cti5x8GIM0jfed6CsdkedJyoC8A4ArkvEf5vOCNw9uV8pqwT1xvzbIhsQfVwKTHoOHdu/6uo5KQu8vfFokEJ8USWcDRB6/JQpNC9vGsV/Thl4t5251h+DiTCrCuWTrwwM8cUJWVD1EW1WmmMCwEGj0Ok5XVho3NobEAF7Q3i/0uH5BoaWWRqVUKw1XWjVDuqc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6635.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(38070700021)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STE0S2RZN0lYY20xSU9kV0JrNktZY0tRN1RwL25wQzJOWGl6MzZKbmlhbFhi?=
 =?utf-8?B?OGl0SWtxaTExWWFpZllUdC8ybHF0R0MvU2grcnJVaW5sUVNyZ0FiYXczYlB2?=
 =?utf-8?B?elROYkRpejZYKzZoT0pVSmk2SU0yb0praWlqdUtCc1Avd2dHYUdQMWJ6OHJV?=
 =?utf-8?B?ZUFldmczeWQzMUlMZ3Rwa1NGZ0FDK1pvbGZ4M0hJMlo0TUo3Y3kxaUZZNjVH?=
 =?utf-8?B?SCtuSXNlSjhnVE94NDBEL0RuZENsazUzT2E1bmJjbDJ0c3ArUFBITWs5a2ZC?=
 =?utf-8?B?SVhHQVd1Qk5tSjBQOEpYQXBLWDZmWWw4NUc1b20vT2NyNVhybEYrV2F0ekZp?=
 =?utf-8?B?Yit4TlBMMi9jQ3BZR2xXRkdZc01FUDRpb2xhNTVGbFU1L2h4SytQbGJ4NC9i?=
 =?utf-8?B?Z2o3cXZFZUVwRm9ORXowQno3anBBQm9nUDRNQllGRi9XOUVWdGlUdFVXcVdO?=
 =?utf-8?B?cWVDNXJIdHlHbnJ4TTA0T2pycHJwWmxWVytlS1cwK3lONTZCaEhMUDE0Yys0?=
 =?utf-8?B?QUcrb1BDMXJhMXp5MDl0ZUhINEl5cXN5UERFM2dlZHludHVSK1V4cjFmNURM?=
 =?utf-8?B?WjRvbW1QcDFCUjA1U2o2anFoWm45amFDQStyQXYyaEVYdUU2bXlqaGs5ZC95?=
 =?utf-8?B?dnVQQkdUSlZicGg1U0s0cU5SNEdGZ0MvQm52MHZiSkNVaWhCdlVuYmU4Z3hX?=
 =?utf-8?B?Mm1NYUtRNUdvdy9jRmR2RGtHVHlsTG00ZFpLU1MzTWcwNzZ1cHNvOUE3UjlO?=
 =?utf-8?B?MEpHYmVjYUlqRUZjb0xRQWVWT1NOZWxMWUM1VDZhaGtsenhhQkF0SUZTZ2VI?=
 =?utf-8?B?YlZhYkQwbDdRRml3YXd4OHNMQ0lYUTFlZy9Rb1JNcGZSOUh2dE81dlQzeXg3?=
 =?utf-8?B?cXBqWW10STRER3pWa1lsYzQya2NObUc2REpQbGJEY0VsK3VWNjMzQnU1VUx2?=
 =?utf-8?B?bVZVZ2YreitSR2p0cHdrVGNxbkY5Wkd6dmkvRUFZd2pKVlpqNkRqSXlSblU4?=
 =?utf-8?B?Q01UUk14TDJKcm1jUmIvUXp6YVg2RmJEamJGUy9TYnMxWmw0aGhNMnNYeTRJ?=
 =?utf-8?B?dGlLc0xEdWR3cDJxNWg3Nitsa1kwQmxMc2lFbURBc2JZQlU0NHEwS3F2ZkVQ?=
 =?utf-8?B?VVlOM1NwRUV2bUNWRDJSOEtMMGdMYVhJTjZnelN6aExiT3lubVdOczZsakts?=
 =?utf-8?B?ZFBHS0RaQjBpQ21yTUpqRUxjVC8yWW5NMEU0UmhaQSs2d2V5VkkzM0toWUc5?=
 =?utf-8?B?dXlrd0VqbFZLLzhYd0Q2VllYb2VvZGFxUUhvRkdxY2FlcVUyZENhYldseWRo?=
 =?utf-8?B?aDhXaldVeVhWVG1URWE5Ujk1Y2dZaWZ6VWt2ZkNqSDRKMGpGZERiMG1semQ3?=
 =?utf-8?B?RG43VDkwQUwxVXJUcEtoMlVXZ0ZPSTE3Tk5uOFdYdjJUcXBGS0U3dFlncjJW?=
 =?utf-8?B?Y3p3Vjg0VC9jd1VJTjN2RDE3NlYyVlIwTE4raHdPbTJWVFpPSFlFaGtuZ3B3?=
 =?utf-8?B?RzlZYmg4WVVld1BwRVJvVHVBNVFZU0xOa1lSVUEzdXU3cVpNM2J0VmxlaVVQ?=
 =?utf-8?B?eFhIOTNFVzEyYm5wK3NYNTNKdzBjeVlpZmtScnFXS1dsVjRBR0ZkZG5yeUZB?=
 =?utf-8?B?dXhncTMxeEcrM1NKL1BNQ0tkMksxY2tTdTJFSzUrSzhiNVJEbFF3NlpkbkR4?=
 =?utf-8?B?ZmlyZm4zakU3N3dDVlFjM2lWb3c3K2N2VjNIMjVSZ3l3ekpJZ3pXb0ZyMkw2?=
 =?utf-8?B?UVdTRzNIb29aMUR2Q01oWi9FNy9EMmM1L1JKaWZpTHV5MEM0cHNIZHJycWRr?=
 =?utf-8?B?VXBwOG1HeUE0VG5mdU5WTzNGTVNnRW9GOU1aME9sbS9EdE9IRGhIYzM3ZWJ1?=
 =?utf-8?B?YW5ucHBpQUVOSUllWGVwcmh3Qjh2NW1hVWdmZ3g1cXJXL01ydkNwK0N4Yk10?=
 =?utf-8?B?TitkU2hjWGJwRjkyWnFuOGZJNDlaSU9PUHFROEp2ekxhVENRZzkrQVZ6VSsz?=
 =?utf-8?B?anhvNFpwLzdkV25UcEVPQWRoNmtIVWZMZXgwNFNQVm1Dbi9NcVEzOXVQUmNi?=
 =?utf-8?B?OVNVTzd4TnFHcDNNTDVub0lhY3B3Z1RrTjdmcDRWMjFLYkpuWTRJakhRN1k1?=
 =?utf-8?B?cXp2TWMzYjlSNG82eWZiUUJFQ3cwbDBxUWZBalpXajZ1bzg3amlYY3g0ZU16?=
 =?utf-8?B?NWpNNnVjenY3WEhPUFJxZjhnK0Q4T2ZBOFROMjlXNjFsSDBHSlJzWGxMcy9V?=
 =?utf-8?B?VnBFaEY5VXRTeG80MnJrVEVocFptd0xNNjcvYlEwM0lCQS90a0IzZ2QxS0lo?=
 =?utf-8?B?VnFrby91dTdQOEhFT20yKzdMV29GVlhxeGZuNTBBZjRoanplVStpYjU1VGkr?=
 =?utf-8?Q?nVcpBz35d2d1z3HU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <987C73AC2F4C714FBBD7A63E0EEA1F16@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ffabYGhepzdnJ5ocYT3JiME0qKmusDRYGJBwEXrsyb7qWKA4gICSg94npJakKuzUkm3xWF872zSCaDetjkGhaZattRCk9J/aAUAhtwjxlyPLwN7A+7q+ahL4MoxjqfeM/qXq7mP0jMgMLzY3a24KRxq72oGsLmvhukP+wf6s9OO4I5uYNNDHKb9uU5rCr0KbAFoXdHhjejafqgNsNYeP1ofhxev2HbrziWRnzc8efASyPPmGee/n6UmqKUnc0oCrXpKjoCFZYbmjdudNpNezSFa8G2lRdkAF6nwqtHIzEq2W+2tTNFm4qigT7Ane7vNMM8tVAG6ox0/OJNLqt+QzOQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6635.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c462653c-c216-42e9-06de-08def9abefc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2026 02:29:59.0718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7x4lO2hBlIBgs9rSePz2QNBx2V2BDsdl6fjQOgyv/b57rsAk74XgQwEnUEk54RLGfsJz3yAYbzdG9afby6DeH2RY4hYkYLEOEM90L/MgI5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8590
X-MTK: N

T24gVGh1LCAyMDI2LTA4LTEzIGF0IDEyOjE1IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IE9uIFRodSwgQXVnIDEzLCAyMDI2IGF0IDQ6NDDigK9BTSBaaGFv
cGluZyBTaHUgKOiIkuWPrOW5sykNCj4gPFpoYW9waW5nLlNodUBtZWRpYXRlay5jb20+IHdyb3Rl
Og0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyNi0wOC0xMiBhdCAyMjoyOSAtMDQwMCwgV2lsbGVtIGRl
IEJydWlqbiB3cm90ZToNCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4geW91IGhhdmUg
dmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+ID4gDQo+ID4g
PiB6aGFvcGluZy5zaHVAIHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBIVyBIZSA8aHcuaGVAbWVkaWF0
ZWsuY29tPg0KPiA+ID4gPiANCj4gPiA+ID4gQSBkZXZpY2Ugc3VwcG9ydHMgR1JPX0hXLCBhbmQg
dGhlIGRldmljZSBkcml2ZXIgZW5hYmxlcyB0aGUNCj4gPiA+ID4gTkVUSUZfRl9HUk9fRlJBR0xJ
U1QgZmVhdHVyZS4gRHVyaW5nIGEgdGV0aGVyaW5nIHRlc3QsDQo+ID4gPiA+IHNrYl9ncm9fcmVj
ZWl2ZV9saXN0KCkgcmVhZ2dyZWdhdGVzIHRoZSBHU08gcGFja2V0LiBIb3dldmVyLA0KPiA+ID4g
PiBza2Jfc2VnbWVudF9saXN0KCkgY2Fubm90IHNlZ21lbnQgdGhpcyBwYWNrZXQgYmFjayBpbnRv
DQo+ID4gPiA+IHRoZSBvcmlnaW5hbCBwYWNrZXRzLCB3aGljaCBsZWFkcyB0byBJUCBmcmFnbWVu
dGF0aW9uIG9yIHBhY2tldA0KPiA+ID4gPiBkcm9wLg0KPiA+ID4gPiANCj4gPiA+ID4gU2NlbmFy
aW8gKFRldGhlcmluZy9Gb3J3YXJkaW5nKToNCj4gPiA+ID4gMS5Ecml2ZXIgc3VibWl0cyBhIHNp
bmdsZSBUQ1AgcGFja2V0LCBQMS4gUDEgaXMga2VwdCBpbiB0aGUNCj4gPiA+ID4gZ3JvX2xpc3Qg
YXMgdGhlIGZpcnN0IHBhY2tldC4NCj4gPiA+ID4gDQo+ID4gPiA+IDIuIFRoZSBkcml2ZXIgc3Vi
bWl0cyBhIFRDUCBHU08gc2tiLCBQMi4gUDIgaGFzIGFscmVhZHkNCj4gPiA+ID4gYWdncmVnYXRl
ZA0KPiA+ID4gPiBtdWx0aXBsZSBUQ1AgcGFja2V0cyBieSBIV19HUk8sIGFuZCBpdHMgbm9uLWxp
bmVhciBkYXRhIGlzDQo+ID4gPiA+IHN0b3JlZA0KPiA+ID4gPiBpbg0KPiA+ID4gPiBmcmFnc1td
Lg0KPiA+ID4gPiANCj4gPiA+ID4gMy4gUDEgYW5kIFAyIG1hdGNoIHRoZSBHUk8gcnVsZXMsIGFu
ZCBzaW5jZSB0aGVyZSBpcyBubyBsb2NhbA0KPiA+ID4gPiBzb2NrZXQsDQo+ID4gPiA+IHRoZXkg
YXJlIGFnZ3JlZ2F0ZWQgYnkgc2tiX2dyb19yZWNlaXZlX2xpc3QoKS4gVGhlIHJlc3VsdGluZw0K
PiA+ID4gPiBza2IsDQo+ID4gPiA+IFAzLCBoYXMgYSBmcmFnX2xpc3QgZW50cnkgdGhhdCBzdGls
bCBjb250YWlucyBmcmFnc1tdOg0KPiA+ID4gPiBQMzogWyBMaW5lYXIgRGF0YSBdIC0+IGZyYWdf
bGlzdCAtPiBbIExpbmVhciBEYXRhIF0NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgWyBmcmFnWzFdIF0NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgWyBmcmFnWzJdIF0NCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLi4uDQo+ID4gPiA+IDQuIExhdGVyLCB0Y3A0X2dzb19zZWdtZW50KCkgb3Ig
dGNwNl9nc29fc2VnbWVudCgpIGNhbGxzDQo+ID4gPiA+IHNrYl9zZWdtZW50X2xpc3QoKSB0byBz
ZWdtZW50IFAzLiBIb3dldmVyLCBza2Jfc2VnbWVudF9saXN0KCkNCj4gPiA+ID4gb25seQ0KPiA+
ID4gPiBzZWdtZW50cyB0aGUgZW50cmllcyBpbiBmcmFnX2xpc3QuIEl0IGRvZXMgbm90IHNlZ21l
bnQgdGhlDQo+ID4gPiA+IGZyYWdzW10NCj4gPiA+ID4gaW5zaWRlIFAyLCBzbyBQMyBpcyBub3Qg
cmVzdG9yZWQgdG8gdGhlIG9yaWdpbmFsIHBhY2tldHMsIHdoaWNoDQo+ID4gPiA+IGxlYWRzDQo+
ID4gPiA+IHRvIElQIGZyYWdtZW50YXRpb24gb3IgcGFja2V0IGRyb3AgaW4gdGhlIGZvbGxvd2lu
ZyBwYXRoLg0KPiA+ID4gPiANCj4gPiA+ID4gV2hlbiBORVRJRl9GX0dST19IVyBpcyBlbmFibGVk
LCBkbyBub3Qgc2V0IE5BUElfR1JPX0NCKHNrYiktDQo+ID4gPiA+ID4gaXNfZmxpc3QuDQo+ID4g
PiA+IA0KPiA+ID4gPiBGYWxsIHRocm91Z2ggdG8gdGhlIHJlZ3VsYXIgc2tiX2dyb19yZWNlaXZl
KCkgcGF0aCBpbnN0ZWFkIG9mDQo+ID4gPiA+IHNrYl9ncm9fcmVjZWl2ZV9saXN0KCkuDQo+ID4g
PiA+IA0KPiA+ID4gPiBGaXhlczogOGQ5NWRjNDc0Zjg1ICgibmV0OiBhZGQgY29kZSBmb3IgVENQ
IGZyYWdsaXN0IEdSTyIpDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEhXIEhlIDxody5oZUBtZWRp
YXRlay5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFpoYW9waW5nIFNodSA8emhhb3Bpbmcu
c2h1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IFsyXToNCj4gPiA+ID4gDQpo
dHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
YXRjaC8xNDcwNjAzMl9fOyEhQ1RSTktBOXdNZzBBUmJ3IWtpZ2IxNDctRzlFZ05xZFdNaGFRNDN1
ZFlPdk45MFNHNmJWamVNLUd4VHNQbzNFMDdfdGJ5c3VvRWllc3pyNUNiQ3FUOTRBWXB0MWJfTTdW
c2dOYVpjanRCU19BbllvJA0KPiA+ID4gPiBbMV06DQo+ID4gPiA+IA0KaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTQ3MDIyMDlf
XzshIUNUUk5LQTl3TWcwQVJidyFraWdiMTQ3LUc5RWdOcWRXTWhhUTQzdWRZT3ZOOTBTRzZiVmpl
TS1HeFRzUG8zRTA3X3RieXN1b0VpZXN6cjVDYkNxVDk0QVlwdDFiX003VnNnTmFaY2p0dTBiUVBO
SSQNCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBuZXQvaXB2NC90Y3Bfb2ZmbG9hZC5jICAgfCA3ICsr
Ky0tLS0NCj4gPiA+ID4gIG5ldC9pcHY2L3RjcHY2X29mZmxvYWQuYyB8IDMgKystDQo+ID4gPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiA+
ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9uZXQvaXB2NC90Y3Bfb2ZmbG9hZC5jIGIvbmV0L2lw
djQvdGNwX29mZmxvYWQuYw0KPiA+ID4gPiBpbmRleCAzYjFmZGNkM2NiMjkuLjY0MWM0N2ZiMWVh
MiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvbmV0L2lwdjQvdGNwX29mZmxvYWQuYw0KPiA+ID4gPiAr
KysgYi9uZXQvaXB2NC90Y3Bfb2ZmbG9hZC5jDQo+ID4gPiA+IEBAIC0zOTUsOSArMzk1LDYgQEAg
c3RhdGljIHZvaWQgdGNwNF9jaGVja19mcmFnbGlzdF9ncm8oc3RydWN0DQo+ID4gPiA+IGxpc3Rf
aGVhZCAqaGVhZCwgc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4gPiA+ID4gICAgICAgc3RydWN0IG5l
dCAqbmV0Ow0KPiA+ID4gPiAgICAgICBpbnQgaWlmLCBzZGlmOw0KPiA+ID4gPiANCj4gPiA+ID4g
LSAgICAgaWYgKGxpa2VseSghKHNrYi0+ZGV2LT5mZWF0dXJlcyAmIE5FVElGX0ZfR1JPX0ZSQUdM
SVNUKSkpDQo+ID4gPiA+IC0gICAgICAgICAgICAgcmV0dXJuOw0KPiA+ID4gPiAtDQo+ID4gPiAN
Cj4gPiA+IEludGVyZXN0aW5nIHRoYXQgaXB2NCBhbmQgaXB2NiBkaXZlcmdlIGhlcmUuIE5pY2Ug
dG8gdHJ5IHRvIG1ha2UNCj4gPiA+IHRoZW0NCj4gPiA+IG1vcmUgYWxpa2UuDQo+ID4gPiANCj4g
PiA+ID4gICAgICAgcCA9IHRjcF9ncm9fbG9va3VwKGhlYWQsIHRoKTsNCj4gPiA+ID4gICAgICAg
aWYgKHApIHsNCj4gPiA+ID4gICAgICAgICAgICAgICBOQVBJX0dST19DQihza2IpLT5pc19mbGlz
dCA9IE5BUElfR1JPX0NCKHApLQ0KPiA+ID4gPiA+IGlzX2ZsaXN0Ow0KPiA+ID4gPiANCj4gPiA+
ID4gQEAgLTQzMCw3ICs0MjcsOSBAQCBzdHJ1Y3Qgc2tfYnVmZiAqdGNwNF9ncm9fcmVjZWl2ZShz
dHJ1Y3QNCj4gPiA+ID4gbGlzdF9oZWFkICpoZWFkLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+
ID4gPiAgICAgICBpZiAoIXRoKQ0KPiA+ID4gPiAgICAgICAgICAgICAgIGdvdG8gZmx1c2g7DQo+
ID4gPiA+IA0KPiA+ID4gPiAtICAgICB0Y3A0X2NoZWNrX2ZyYWdsaXN0X2dybyhoZWFkLCBza2Is
IHRoKTsNCj4gPiA+ID4gKyAgICAgaWYgKHVubGlrZWx5KChza2ItPmRldi0+ZmVhdHVyZXMgJiBO
RVRJRl9GX0dST19GUkFHTElTVCkNCj4gPiA+ID4gJiYNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICEoc2tiLT5kZXYtPmZlYXR1cmVzICYgTkVUSUZfRl9HUk9fSFcpKSkNCj4gPiA+IA0KPiA+
ID4gV291bGQgaXQgYmUgYmV0dGVyIHRvIHRlc3Qgc2tiX2lzX2dzbyhza2IpIGFuZCBvbmx5IHNr
aXAgZnJhZ2xpc3QNCj4gPiA+IEdSTw0KPiA+ID4gZm9yIEhXLUdSTyBza2JzLCByYXRoZXIgdGhh
biBkaXNhYmxpbmcgaXQgZm9yIGFsbCBza2JzPw0KPiA+IA0KPiA+IFllcywgZm9yIHRldGhlcmlu
ZyBwYWNrZXRzLCBIVy1HUk8gc2ticyBhcmUgYWdncmVnYXRlZCBieQ0KPiA+IHNrYl9ncm9fcmVj
ZWl2ZSgpLCB3aGlsZSBvdGhlcnMgZ28gdGhyb3VnaCBmcmFnbGlzdCBHUk8uIEhvd2V2ZXIsDQo+
ID4gY2FyZQ0KPiA+IG11c3QgYmUgdGFrZW4gdG8gYXZvaWQgcGFja2V0cyBhcnJpdmluZyBvdXQg
b2Ygb3JkZXIuIEkgd2lsbCB3b3JrDQo+ID4gb24NCj4gPiBpdCBhbmQgc3VibWl0IFY0Lg0KPiAN
Cj4gT2ggcmlnaHQuDQo+IA0KPiBBcyBsb25nIGFzIHRoZSBjaG9pY2UgaXMgb25seSBiZXR3ZWVu
IGZyYWdsaXN0IEdSTyBvciBub3QgZnJhZ2xpc3QNCj4gKHJhdGhlciB0aGFuIEdSTyBvciBieXBh
c3MgR1JPKSwgaXQgc2hvdWxkIG5vdCBpbnRyb2R1Y2UgYW55IG5ldw0KPiByZW9yZGVyaW5nIGNv
bmNlcm5zLg0KPiANCj4gQnV0IHRoZSBkZWNpc2lvbiBjYW5ub3QgYmUgbWFkZSBiYXNlZCBvbiBz
a2JfaXNfZ3NvKHNrYikgb2YgYW4NCj4gYXJyaXZpbmcgc2tiLiBCZWNhdXNlIHdoZW4gc3VjaCBh
IEhXLUdSTyBza2IgYXJyaXZlcyBhIFNXIEdSTyBjb250ZXh0DQo+IGluIGZyYWdsaXN0IG1vZGUg
bWF5IGFscmVhZHkgaGF2ZSBiZWVuIG9wZW5lZCwgYW5kIGl0IGlzIHRvbyBsYXRlIHRvDQo+IGNv
bnZlcnQgdGhhdCB0byBub24tZnJhZ2xpc3QuDQo+IA0KPiBTbyBlc3NlbnRpYWxseSBIVy1HUk8g
YW5kIGZyYWdsaXN0IGFyZSBtdXR1YWxseSBleGNsdXNpdmUuDQo+IA0KPiA+ID4gDQo+ID4gPiBJ
ZiB0cmVhdGluZyB0aGUgZmVhdHVyZXMgYXMgbXV0dWFsbHkgZXhjbHVzaXZlLCBhbm90aGVyIG9w
dGlvbg0KPiA+ID4gd291bGQNCj4gPiA+IGJlIHRvIHJlcGxhY2UgdGhlc2UgZGF0YXBhdGggY2hl
Y2tzIHdpdGggZGlzYWJsaW5nIG9uZSBhdA0KPiA+ID4gY29uZmlndXJhdGlvbg0KPiA+ID4gdGlt
ZSwgaW4gbmV0ZGV2X2ZpeF9mZWF0dXJlcy4NCj4gPiA+IA0KPiA+IA0KPiA+IElmIFY0IHdvcmsg
d2VsbCwgdGhlcmUgd2lsbCBiZSBubyBuZWVkIHRvIGNoZWNrIG5ldGRldi0+ZmVhdHVyZXMuDQo+
ID4gTGludXgga2VybmVsIEdSTyB3aWxsIGJlIG1vcmUgcm9idXN0IGFuZCBhYmxlIHRvIGhhbmRs
ZSBzY2VuYXJpb3MNCj4gPiB3aGVyZSBib3RoIE5FVElGX0ZfR1JPX0hXIGFuZCBORVRJRl9GX0dS
T19GUkFHTElTVCBhcmUgZW5hYmxlZC4NCj4gDQo+IFdoYXQgaXMgeW91ciBwbGFuIGZvciB2ND8N
CkJhc2VkIG9uIGtlcm5lbCA3LjIuMC5yYzcgY29kZToNCkFkZCBsb2dpYyBpbiB0Y3A0LzZfY2hl
Y2tfZnJhZ2xpc3RfZ3JvKCkgYXMgZm9sbG93Og0KaWYgYW4gYXJyaXZpbmcgc2tiIGlzIHRoZSBm
aXJzdCBwYWNrZXQgaW4gdGhlIEdSTyBsaXN0Lg0KCU5BUElfR1JPX0NCKHNrYiktPmlzX2ZsaXN0
ID0gIXNrICYmICFza2JfaXNfZ3NvKHNrYik7DQoNCi8qDQoqIE90aGVyd2lzZSwgdGhlIGFycml2
aW5nIHNrYiBpcyBub3QgdGhlIGZpcnN0IHBhY2tldCwgd2hpY2ggbWVhbnMNCiogdGhhdCBzdHJ1
Y3Qgc2tfYnVmZiAqcCBleGlzdHMuDQoqLw0KaWYgKCFza2JfaXNfZ3NvKHNrYikgfHwgIU5BUElf
R1JPX0NCKHApLT5pc19mbGlzdCkgew0KCS8qIEFnZ3JlZ2F0ZSB0aGUgc2tiIHVzaW5nIHAncyBH
Uk8gbWV0aG9kLiAqLw0KCU5BUElfR1JPX0NCKHNrYiktPmlzX2ZsaXN0ID0gTkFQSV9HUk9fQ0Io
cCktPmlzX2ZsaXN0Ow0KfSBlbHNlIHsNCglOQVBJX0dST19DQihza2IpLT5pc19mbGlzdCA9IDA7
DQoJLyogRmx1c2ggcCBhbmQgc3RhcnQgYSBuZXcgR1JPIGxpc3QgdXNpbmcgdGhlIG5vbi1mcmFn
bGlzdA0KbWV0aG9kLiAqLw0KfQ0KDQpBbm90aGVyIGNvZGUgY2hhbmdlIGluDQp0Y3BfZ3JvX3Jl
Y2VpdmUoKSB7DQoJLi4uDQoJaWYgKHVubGlrZWx5KE5BUElfR1JPX0NCKHApLT5pc19mbGlzdCkp
IHsNCgkJLi4uDQoJCS8qIGlmIGFnZ3JlZ2F0ZSBtZXRob2QgY2hhbmdlZCwgZmx1c2ggY3VycmVu
dCBncm8gbGlzdA0KKi8NCgkJZmx1c2ggfD0gTkFQSV9HUk9fQ0Ioc2tiKS0+aXNfZmxpc3QgIT0g
TkFQSV9HUk9fQ0IocCktDQo+aXNfZmxpc3Q7DQoJCWlmIChmbHVzaCB8fCBza2JfZ3JvX3JlY2Vp
dmVfbGlzdCgpKQ0KCQkJLi4uDQoJfQ0KfQ0KDQpBZnRlciB0aGlzIGNoYW5nZToNCi0gTkVUSUZf
Rl9HUk9fSFcgYW5kIE5FVElGX0ZfR1JPX0ZSQUdMSVNUIGFyZSBubyBsb25nZXIgbXV0dWFsbHkN
CmV4Y2x1c2l2ZS4NCi0gSW4gdGV0aGVyaW5nIHNjZW5hcmlvcywgVENQIGZyYWdsaXN0IEdSTyBh
cHBsaWVzIG9ubHkgdG8gY29uc2VjdXRpdmUNCm5vbi1HU08gc2ticyghc2tiX2lzX2dzbyhza2Ip
KS4NCiAgb3RoZXJzIHdpbGwgYWRvcHQgc2tiX2dyb19yZWNlaXZlKCkgcGF0aC4NCg0KUGxlYXNl
IHByb3ZpZGUgc29tZSBzdWdnZXN0aW9ucyBvbiB0aGUgY2hhbmdlcyBhYm92ZS4gU2hvdWxkIEkg
cHJlcGFyZQ0KVjQgcGF0Y2ggYmFzZWQgb24gdGhlc2UgY2hhbmdlcz8NCg==
