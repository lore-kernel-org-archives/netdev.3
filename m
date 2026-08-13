Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95933397689;
	Thu, 13 Aug 2026 08:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610407; cv=fail; b=NvZaQtAapNXiDfDV7lpS/Ry59eKaUonW/KbfRxEqoK8DMCmJ5/fItgQqQLLV40VnoKn7ECZtld+zEY56Cx9UTbHmrQvXFGl/ju0KcGCukCiZeyZX9BSitXqTth15gxF2XmN3lnB9qwhAOd+TvqP+r1sUuviDt2ysqNC58QJePpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610407; c=relaxed/simple;
	bh=8pZ6b1wV7oIPzjAYmAkmYTPaTMwh9jqg6RCbWQCeDSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ANKnVUD+czp9HuXflYEs1fNCY8RsXrfEUjEPGtkBQL4vbL7e2CM1lJap7zFpGeqzCPubs3u5ENPVcq+5t6YexLVY6+tiE2RG4849f7UqaYhw7e8D+7933tvfpc9LhrWfbHS5I2XA7oRpQfmg0vId8cpEuPgCuI73cVNXwq0KTrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fUWXuKgz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=CD15yUWS; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fUWXuKgz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="CD15yUWS"
X-UUID: 8f9bb32296f211f1b1788b6acf885367-20260813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8pZ6b1wV7oIPzjAYmAkmYTPaTMwh9jqg6RCbWQCeDSc=;
	b=fUWXuKgzX93W2QCKk7R8iHina7W8FCIFPXlVqzCluHGXAIxfBQNny6FB9INY+2bNDJByRERiCk/rlTn/03CfQ4wDhNvtX9POBhrvCrEDrKNkLcUoL6zHqGmN7+g0zTverdprsZuPnPr+ZSFPJzJtTmd/p9InJ12cBDovZd3IFSY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a775683f-91db-46b6-a3ab-49e81c64ad3c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:b86dd4f1-0685-46a3-9cac-19d8f3a05ae7,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:80|1,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8f9bb32296f211f1b1788b6acf885367-20260813
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <zhaoping.shu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 233368851; Thu, 13 Aug 2026 16:39:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 13 Aug 2026 16:39:55 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 13 Aug 2026 16:39:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrJZBaWKnIlc78I7+dRjfEAiNpJj+nekXDjhVN/4eqi4lEBiEERVnIOwhtd/LWejxKe18VZ/A7o/b8EaFW+LD6bK+trjlpwT3sAezDl3s0Cr6xVFrytQAxwIFHr0e0vFFP66AYUjkQWROdBk0218xB8NqZYWtVmIYIC85sTfnuclxeQgwL6R8vUC1oe0c4W2WNNPsUlC92lDEHTr3D5FMUWEYyM7QeSUDUtV/Razzle2QWW2+xN+NWEfn0/WfTWS9+kGtq638xbtRGQwW+JmH8AiR8UDbMBT7OV1Ql6529+K9GrLOsc0Lm54gODMlkKfQ8f87rFhF53NBr20tXBmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pZ6b1wV7oIPzjAYmAkmYTPaTMwh9jqg6RCbWQCeDSc=;
 b=iSabiH7ZsST3aATBUWTvKTT+XTeMJZ3Ym45z+96aEnJSuC18BRhYrPCjoIzvUcLx3l65Fhl4EkRHQH4zMTo9MGE4GwJ7hkrHfeUb+HSKLtNzOLTGe2uk0HmTCrtAmTyw8/bylOH/4ktET+SrvJ6OINEnRyHvqFOM/WdHJB8rcVoSDEL+zPC7UW2HzkUM479N2Q+w3sWtOaIS2HM9HT3LOAbz0MZyDz3tAn0XjOIIpqnB0hGTjUSE7mWJB+RCi6ZVUWlhsrLqDw1CfQ2jjoqT/cxS34xySA7itTAMemogUkqoIi+0gf2xN6RuJUsD9PQtT4SHtgqxt0M/T4Rf1nls6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pZ6b1wV7oIPzjAYmAkmYTPaTMwh9jqg6RCbWQCeDSc=;
 b=CD15yUWSMyLZhIw1cRaGlme7ESFXHTFr1vanVGtKJhKRMI43ceeqN00irp/nTk3up9ep2xmabcAUAHcuZpu13SKqYrDZ/qB6Y5yk7AHFPMXL81xBLyDdiHEf84IN5zr0Xr+3JLBk+K0RD3WEEYzRUl8wYq52o3DXDuHK1cJRBAo=
Received: from SG2PR03MB6635.apcprd03.prod.outlook.com (2603:1096:4:1df::6) by
 TYZPR03MB8801.apcprd03.prod.outlook.com (2603:1096:405:a1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Thu, 13 Aug 2026 08:39:50 +0000
Received: from SG2PR03MB6635.apcprd03.prod.outlook.com
 ([fe80::d6a7:ad8b:c6ff:fce]) by SG2PR03MB6635.apcprd03.prod.outlook.com
 ([fe80::d6a7:ad8b:c6ff:fce%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 08:39:50 +0000
From: =?utf-8?B?Wmhhb3BpbmcgU2h1ICjoiJLlj6zlubMp?= <Zhaoping.Shu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"sd@queasysnail.net" <sd@queasysnail.net>, "imv4bel@gmail.com"
	<imv4bel@gmail.com>, "alice@isovalent.com" <alice@isovalent.com>,
	"eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>,
	=?utf-8?B?SFcgSGUgKOS9leS8nyk=?= <HW.He@mediatek.com>, "horms@kernel.org"
	<horms@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"willemb@google.com" <willemb@google.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuniyu@google.com" <kuniyu@google.com>, "ncardwell@google.com"
	<ncardwell@google.com>
CC: =?utf-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= <haijun.liu@mediatek.com>,
	=?utf-8?B?WGlheXUgWmhhbmcgKOW8oOWkj+Wuhyk=?= <Xiayu.Zhang@mediatek.com>,
	=?utf-8?B?TGFtYmVydCBXYW5nICjnjovkvJ8p?= <Lambert.Wang@mediatek.com>,
	=?utf-8?B?SXZlbiBZYW5nICjpmLPlhYkp?= <Iven.Yang@mediatek.com>
Subject: Re: [PATCH net v3] net: gro: Fix nesting of TCP GSO SKBs in
  skb_gro_receive_list()
Thread-Topic: [PATCH net v3] net: gro: Fix nesting of TCP GSO SKBs in
  skb_gro_receive_list()
Thread-Index: AQHdKsTRJTSvkpOzhkKxmMAGQeSLMrabQacAgABnaAA=
Date: Thu, 13 Aug 2026 08:39:50 +0000
Message-ID: <0e1f71c4417099399eda78fd2a082b2444e42af9.camel@mediatek.com>
References: <20260813014056.160533-1-zhaoping.shu@mediatek.com>
	 <willemdebruijn.kernel.1372b82f50882@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1372b82f50882@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6635:EE_|TYZPR03MB8801:EE_
x-ms-office365-filtering-correlation-id: fd6c44f4-2c66-4e90-706a-08def916706e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|38070700021|921020|6133799003|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: VV8I3AOmF77RT6oQVoCQDtnq3xLbVyvhLLg53GiQK0OMVeINwO4O2OLXv3dsP/mBUT3c8fRO/yujTq+DSMfmVLRvkUGhtxli29x80+BZL1CvJuFRsq5/j+xbGCjWcMwLVgD2JlpYFmzwpvQIfyOx2sJwwIWjAbk3yX76RliJh56dBsAzcUkAkyd+PkgO8xae2n9rMle+oT2IZQ9qPMh6ZI7e35VDt5/3yZc+poJqzJEzZAugmZ24k1UvabD9uKrTvTigI8uEVhuQ8QeoL11kri0EmF5JbI4FWqIB8Ro0OX5XyccxPfKFDNF4lBZceFMbgH06qhdCTlEiB0Vv8dVFJ4OcikDXMWve3NmcGcn4t4j5Lyw82X/SBOmOVaC4nCj5AjGh1Yd0oAL8PfkkMlYwB5KMA4ClZlLl5kUwZKNDwWoOle7GuOh0fm9H3vn3q6Vy8FXgbujqI43RyzRtz2GIXAe/sGZdFV3mdm29eMGnWcdpyz0qgWYESmWXRBkX3AcuvZuvbOWmAhipVHPjSQkMvWHbmaDEN6AeC1uVzdatnjzyaRJ9Xpbg+v/Zom9jlPbCL/IrRlYIyoApdMVu4BaiVY2ANtnnoU2w6JH9CsWEjWV8oTqlt/67ZQgqFJep57/W6Frc38JkDb8T4cFAnUzGtytNhGhCG9ND1urF5nGnB7/LoJIDeTRKXIEt9BzyCfa/QB8v/uxLJtBYihc747SjfiVJEqnNZ89dC8TFVdar0TgbPHIujHSPTlN0jopFy+ia
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6635.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(38070700021)(921020)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXBYSXFvenhTUTV6K1E3eWFoeUNSelJPMklVVEhMeFJkdFlEREh0MENxSVI4?=
 =?utf-8?B?Tm80aWhnZnN5alFvTW14akwvRUhZYkNSUm15ekFsTllXU1lVN0ExQm4rU05J?=
 =?utf-8?B?eXJWUGFJWXVrUUxqeDlDLy8yM0lHUEl5UEtOcVp6QkpYUVQ5ZFhNYTJBYzJi?=
 =?utf-8?B?L2lPM2xYc2kxMDR6WjlCWG1yVVB4N2VmWndwL2E1djAzKzE5ZUJQWTdZNDFK?=
 =?utf-8?B?dm9MTlBjRWY4VkF3UVRUYmkreHB6RnZ0ZTNTd0ZpSTJVM09pWWQyNW5SSjRk?=
 =?utf-8?B?QjArNWsyWXhSekQ3RTdJdWxlL1YwZGpQemZTeUtYb2xGbzBuRklHYUd4UzdL?=
 =?utf-8?B?V1ZBNGZVN0E5Tm04SUhzWlhJQnVndG43OHVtd0kvaGM0WDR1YzFDM2RSdEQ1?=
 =?utf-8?B?WUVTMXBHdFVJTFRhMnN5UjE5cVVJc0pvNlAvSXpMMXlTUzBJMmt0clFybGgz?=
 =?utf-8?B?VkN2alMxS3dxTUlQeDQ2YUlvMWkvblJMb2ZnOVNqU0ZwcEptTHNwWHQ2aFNN?=
 =?utf-8?B?UUdOR0ZncGRQTyt4Kys1aThHcXhoenRrSUN2RWFrTUFrcU1ZdXJ5S1ZTUWxE?=
 =?utf-8?B?K3JFTHNTSUdyZFFMa1ArRzZnaGR3Mm9EQW15S21JZGk0ZFlDc1JXWUtmVFRs?=
 =?utf-8?B?VzdLcmcrOHkwK09vb3NFSVJ6YTF1eStPZ3BOUGRvVldwT3FGRitrYmlxR1JI?=
 =?utf-8?B?UUhGRHNvNXgxWE9zMXJJRmc5M1hxcVl1ZGJLUEVZS3Z1eVJ5U1JLR09zWEZF?=
 =?utf-8?B?VU9Tek5KN1dOdnJ3SUcvcU5OTVc0SmN6eVBxa2MraGJTUHYxMUtSc2JDaVh5?=
 =?utf-8?B?U3RXUTMwOU9FL0prMmhBTFV1cWN3aitPNG9HN0F4ckxnRXlnVnpUVkdFN1hR?=
 =?utf-8?B?TExpcWhYZE5iUVR0cHljLzdQTmFoYXhBaHBtb2cyQ25xSDRkL3VQMXd1VUpv?=
 =?utf-8?B?WDdXUEZWb3I4L1hoUmEzNEcreWV4QlIwcWZ6cHZEeUNOb28zQldUL3R4cnBy?=
 =?utf-8?B?bi93STR1TmMvY1ZHTlFQb3oza2JIMjgyQTlYcEcyQzlKQWUwVHEyazRtWkhz?=
 =?utf-8?B?QzRidDVxNVF3YXVsTSswckRMUEc2aHE1NjJPeFBtU0pXY1Q0VnQzeWQ1dktD?=
 =?utf-8?B?MDd5U2ZIWHlQdUdId2lKR1JiZjdncVJEbWJSVXI3dnU5NDhiYWFGbitJL1RG?=
 =?utf-8?B?bFNoR25NMURaanA0V2Y0cmxpZTFuczBDc3E3Nk1WK0s4b2tQcjZHd3BQSjQ0?=
 =?utf-8?B?R0FwNDh0RlB4clMxd0VpT0tSTFpLTnJMYnhML1VpUDFQMkpsemw4bVUrM2pk?=
 =?utf-8?B?azh4aEtDcGRRYmhsVURqVDJuTnRKaUphdTRhYVdkWkJRMlRXbnZHUUJEdFk5?=
 =?utf-8?B?QjJlSlY1TWpvcEtnNjRLTkhiOFZEdVB4alV5bHhaWW43dmtFZFpValhhd3Ny?=
 =?utf-8?B?b0xicm5GMkhLK0dtZDV6VmxxRTZNZGJrelQzK0FoOW1mU3NoTkJrUmtiNkE0?=
 =?utf-8?B?NEhyS2x5MTEvb2l0cVRoc2hlVWl0QVdUdjRaUWh1VGZmTUJXVlZBS29WUGpY?=
 =?utf-8?B?VzJmU0VvVXVnMkxjQ3crcC9lakhSeEt3bzBnazBPTEdHM3VlY1N5dDh1dmdJ?=
 =?utf-8?B?T2dFb3pQSW1QRUpRS1hLQktMQzVsZlZ5bFpBcjhCbkJRcEhaTkdzcytlbWZ1?=
 =?utf-8?B?TUNLbG9wNCtBc0Q5a2V5K0ZjWmV0eW50ZStoeFFoWEJRaERxMVdSZVdJeFBZ?=
 =?utf-8?B?ZXZDM0FMWEhrZWJuS2pDeHB6cDlRbThsZGI0TUxsNVRlOFJ6SGxEU3F4N1k0?=
 =?utf-8?B?NDNtcXRwUldpUnNUYTNseWV4QXdMdHdPcjkyZE81SFNwRlR2dVR3SDE2WVJP?=
 =?utf-8?B?QWZEa3VvT2xBVlh1N3BjRGhDTzcvbWo2VENER3ZWcXVHY3U3UVRrY1FVNFM2?=
 =?utf-8?B?anppRm9XdE9PMEk5TWYzM0M5TDByMTNMcmRtNHZyVFk2c3FVVzEvQXFMRFhW?=
 =?utf-8?B?NlN3SFFPeHlCaitIWThmaHNaaVNPN1B6UURYUmpsZ0s5bGlXU2ppeUlRcDgy?=
 =?utf-8?B?SnhKVldXL01lSmsvSWNmRFdPaFo1TVY4ZER4UWh0K3pIcWhscE0wZGwvNlFm?=
 =?utf-8?B?VXByWDllNnRwUmZLaldUWGozVW9FckVjaGV1VnBKTWtZdk00VVU2ZTJDSjBo?=
 =?utf-8?B?SzZtOE5YRUJFZStjWTV3azZnR3p3SDdhNTltUW1PckNGcDA4bEVweDcvWUZX?=
 =?utf-8?B?VGNPOE9zV2lxbFV6UTZ4UjhVMk8zYnJHTHNNOWVqM0I0RVJaSGpTZzA4RW1S?=
 =?utf-8?B?Zy93elc0UHVZVFhWVm5FbVdvaWVMZ1RLUWc5VGxERTZ1eGV5Sk53RlgwMDdP?=
 =?utf-8?Q?N66PVBsHHETnT6UY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C49832830DAF9C4FB36EE9C04CCB90F7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pMn6QR6PQCYtTweLHPpfQHkNzh/atTAiS1lk9DpQP6eeBeUrnIwy7Pd2wAfkqtTFyH1BZ6mKeh+t7hLFGQxNta+Z3Z94sCW5nrF68L76iAq3JCKYZ4m2AKX3goYWPnKb6HkultDibiN3dzx0pPukJuYPN+mI6AbcKbXGQrjxxSsKcT42aZBaeuHNBCr0MXDAL1VpgdsykKVoA/P6BhxDZi7A8jNPuGf+Ph26n2LoNqQrpEyQOjpT0DzHlCO/yrMJT7sHOuIejopNcvwP3VrfKso4rebCk4RmNhjctxafkaSXheVxfzyfAjfK+Fh8f1TfdCPEWqcTk8DZZ1nnTL6r5w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6635.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6c44f4-2c66-4e90-706a-08def916706e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 08:39:50.3679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9RZuDTESyWQh3GHZPOnA1J+KbMkJxVJHxwbJykWuIrYljeXVmz/07N8bQoITfDggRrVJHlYNoxRnp2PO2qizNtIAjvfatTepi5O8UQODiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8801
X-MTK: N

T24gV2VkLCAyMDI2LTA4LTEyIGF0IDIyOjI5IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IHpoYW9waW5nLnNodUAgd3JvdGU6DQo+ID4gRnJvbTogSFcgSGUg
PGh3LmhlQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBBIGRldmljZSBzdXBwb3J0cyBHUk9fSFcs
IGFuZCB0aGUgZGV2aWNlIGRyaXZlciBlbmFibGVzIHRoZQ0KPiA+IE5FVElGX0ZfR1JPX0ZSQUdM
SVNUIGZlYXR1cmUuIER1cmluZyBhIHRldGhlcmluZyB0ZXN0LA0KPiA+IHNrYl9ncm9fcmVjZWl2
ZV9saXN0KCkgcmVhZ2dyZWdhdGVzIHRoZSBHU08gcGFja2V0LiBIb3dldmVyLA0KPiA+IHNrYl9z
ZWdtZW50X2xpc3QoKSBjYW5ub3Qgc2VnbWVudCB0aGlzIHBhY2tldCBiYWNrIGludG8NCj4gPiB0
aGUgb3JpZ2luYWwgcGFja2V0cywgd2hpY2ggbGVhZHMgdG8gSVAgZnJhZ21lbnRhdGlvbiBvciBw
YWNrZXQNCj4gPiBkcm9wLg0KPiA+IA0KPiA+IFNjZW5hcmlvIChUZXRoZXJpbmcvRm9yd2FyZGlu
Zyk6DQo+ID4gMS5Ecml2ZXIgc3VibWl0cyBhIHNpbmdsZSBUQ1AgcGFja2V0LCBQMS4gUDEgaXMg
a2VwdCBpbiB0aGUNCj4gPiBncm9fbGlzdCBhcyB0aGUgZmlyc3QgcGFja2V0Lg0KPiA+IA0KPiA+
IDIuIFRoZSBkcml2ZXIgc3VibWl0cyBhIFRDUCBHU08gc2tiLCBQMi4gUDIgaGFzIGFscmVhZHkg
YWdncmVnYXRlZA0KPiA+IG11bHRpcGxlIFRDUCBwYWNrZXRzIGJ5IEhXX0dSTywgYW5kIGl0cyBu
b24tbGluZWFyIGRhdGEgaXMgc3RvcmVkDQo+ID4gaW4NCj4gPiBmcmFnc1tdLg0KPiA+IA0KPiA+
IDMuIFAxIGFuZCBQMiBtYXRjaCB0aGUgR1JPIHJ1bGVzLCBhbmQgc2luY2UgdGhlcmUgaXMgbm8g
bG9jYWwNCj4gPiBzb2NrZXQsDQo+ID4gdGhleSBhcmUgYWdncmVnYXRlZCBieSBza2JfZ3JvX3Jl
Y2VpdmVfbGlzdCgpLiBUaGUgcmVzdWx0aW5nIHNrYiwNCj4gPiBQMywgaGFzIGEgZnJhZ19saXN0
IGVudHJ5IHRoYXQgc3RpbGwgY29udGFpbnMgZnJhZ3NbXToNCj4gPiBQMzogWyBMaW5lYXIgRGF0
YSBdIC0+IGZyYWdfbGlzdCAtPiBbIExpbmVhciBEYXRhIF0NCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBbIGZyYWdbMV0gXQ0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFsgZnJhZ1syXSBdDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgLi4uDQo+ID4gNC4gTGF0ZXIsIHRjcDRfZ3NvX3NlZ21lbnQoKSBvciB0Y3A2
X2dzb19zZWdtZW50KCkgY2FsbHMNCj4gPiBza2Jfc2VnbWVudF9saXN0KCkgdG8gc2VnbWVudCBQ
My4gSG93ZXZlciwgc2tiX3NlZ21lbnRfbGlzdCgpIG9ubHkNCj4gPiBzZWdtZW50cyB0aGUgZW50
cmllcyBpbiBmcmFnX2xpc3QuIEl0IGRvZXMgbm90IHNlZ21lbnQgdGhlIGZyYWdzW10NCj4gPiBp
bnNpZGUgUDIsIHNvIFAzIGlzIG5vdCByZXN0b3JlZCB0byB0aGUgb3JpZ2luYWwgcGFja2V0cywg
d2hpY2gNCj4gPiBsZWFkcw0KPiA+IHRvIElQIGZyYWdtZW50YXRpb24gb3IgcGFja2V0IGRyb3Ag
aW4gdGhlIGZvbGxvd2luZyBwYXRoLg0KPiA+IA0KPiA+IFdoZW4gTkVUSUZfRl9HUk9fSFcgaXMg
ZW5hYmxlZCwgZG8gbm90IHNldCBOQVBJX0dST19DQihza2IpLQ0KPiA+ID5pc19mbGlzdC4NCj4g
PiBGYWxsIHRocm91Z2ggdG8gdGhlIHJlZ3VsYXIgc2tiX2dyb19yZWNlaXZlKCkgcGF0aCBpbnN0
ZWFkIG9mDQo+ID4gc2tiX2dyb19yZWNlaXZlX2xpc3QoKS4NCj4gPiANCj4gPiBGaXhlczogOGQ5
NWRjNDc0Zjg1ICgibmV0OiBhZGQgY29kZSBmb3IgVENQIGZyYWdsaXN0IEdSTyIpDQo+ID4gU2ln
bmVkLW9mZi1ieTogSFcgSGUgPGh3LmhlQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBaaGFvcGluZyBTaHUgPHpoYW9waW5nLnNodUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
WzJdOiANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wYXRjaC8xNDcwNjAzMl9fOyEhQ1RSTktBOXdNZzBBUmJ3IWtpZ2IxNDctRzlF
Z05xZFdNaGFRNDN1ZFlPdk45MFNHNmJWamVNLUd4VHNQbzNFMDdfdGJ5c3VvRWllc3pyNUNiQ3FU
OTRBWXB0MWJfTTdWc2dOYVpjanRCU19BbllvJA0KPiA+IFsxXTogDQo+ID4gaHR0cHM6Ly91cmxk
ZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTQ3MDIy
MDlfXzshIUNUUk5LQTl3TWcwQVJidyFraWdiMTQ3LUc5RWdOcWRXTWhhUTQzdWRZT3ZOOTBTRzZi
VmplTS1HeFRzUG8zRTA3X3RieXN1b0VpZXN6cjVDYkNxVDk0QVlwdDFiX003VnNnTmFaY2p0dTBi
UVBOSSQNCj4gPiAtLS0NCj4gPiAgbmV0L2lwdjQvdGNwX29mZmxvYWQuYyAgIHwgNyArKystLS0t
DQo+ID4gIG5ldC9pcHY2L3RjcHY2X29mZmxvYWQuYyB8IDMgKystDQo+ID4gIDIgZmlsZXMgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9uZXQvaXB2NC90Y3Bfb2ZmbG9hZC5jIGIvbmV0L2lwdjQvdGNwX29mZmxvYWQuYw0KPiA+
IGluZGV4IDNiMWZkY2QzY2IyOS4uNjQxYzQ3ZmIxZWEyIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9p
cHY0L3RjcF9vZmZsb2FkLmMNCj4gPiArKysgYi9uZXQvaXB2NC90Y3Bfb2ZmbG9hZC5jDQo+ID4g
QEAgLTM5NSw5ICszOTUsNiBAQCBzdGF0aWMgdm9pZCB0Y3A0X2NoZWNrX2ZyYWdsaXN0X2dybyhz
dHJ1Y3QNCj4gPiBsaXN0X2hlYWQgKmhlYWQsIHN0cnVjdCBza19idWZmICpza2IsDQo+ID4gICAg
ICAgc3RydWN0IG5ldCAqbmV0Ow0KPiA+ICAgICAgIGludCBpaWYsIHNkaWY7DQo+ID4gDQo+ID4g
LSAgICAgaWYgKGxpa2VseSghKHNrYi0+ZGV2LT5mZWF0dXJlcyAmIE5FVElGX0ZfR1JPX0ZSQUdM
SVNUKSkpDQo+ID4gLSAgICAgICAgICAgICByZXR1cm47DQo+ID4gLQ0KPiANCj4gSW50ZXJlc3Rp
bmcgdGhhdCBpcHY0IGFuZCBpcHY2IGRpdmVyZ2UgaGVyZS4gTmljZSB0byB0cnkgdG8gbWFrZSB0
aGVtDQo+IG1vcmUgYWxpa2UuDQo+IA0KPiA+ICAgICAgIHAgPSB0Y3BfZ3JvX2xvb2t1cChoZWFk
LCB0aCk7DQo+ID4gICAgICAgaWYgKHApIHsNCj4gPiAgICAgICAgICAgICAgIE5BUElfR1JPX0NC
KHNrYiktPmlzX2ZsaXN0ID0gTkFQSV9HUk9fQ0IocCktDQo+ID4gPmlzX2ZsaXN0Ow0KPiA+IEBA
IC00MzAsNyArNDI3LDkgQEAgc3RydWN0IHNrX2J1ZmYgKnRjcDRfZ3JvX3JlY2VpdmUoc3RydWN0
DQo+ID4gbGlzdF9oZWFkICpoZWFkLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+ICAgICAgIGlm
ICghdGgpDQo+ID4gICAgICAgICAgICAgICBnb3RvIGZsdXNoOw0KPiA+IA0KPiA+IC0gICAgIHRj
cDRfY2hlY2tfZnJhZ2xpc3RfZ3JvKGhlYWQsIHNrYiwgdGgpOw0KPiA+ICsgICAgIGlmICh1bmxp
a2VseSgoc2tiLT5kZXYtPmZlYXR1cmVzICYgTkVUSUZfRl9HUk9fRlJBR0xJU1QpICYmDQo+ID4g
KyAgICAgICAgICAgICAgICAgICEoc2tiLT5kZXYtPmZlYXR1cmVzICYgTkVUSUZfRl9HUk9fSFcp
KSkNCj4gDQo+IFdvdWxkIGl0IGJlIGJldHRlciB0byB0ZXN0IHNrYl9pc19nc28oc2tiKSBhbmQg
b25seSBza2lwIGZyYWdsaXN0IEdSTw0KPiBmb3IgSFctR1JPIHNrYnMsIHJhdGhlciB0aGFuIGRp
c2FibGluZyBpdCBmb3IgYWxsIHNrYnM/DQoNClllcywgZm9yIHRldGhlcmluZyBwYWNrZXRzLCBI
Vy1HUk8gc2ticyBhcmUgYWdncmVnYXRlZCBieQ0Kc2tiX2dyb19yZWNlaXZlKCksIHdoaWxlIG90
aGVycyBnbyB0aHJvdWdoIGZyYWdsaXN0IEdSTy4gSG93ZXZlciwgY2FyZQ0KbXVzdCBiZSB0YWtl
biB0byBhdm9pZCBwYWNrZXRzIGFycml2aW5nIG91dCBvZiBvcmRlci4gSSB3aWxsIHdvcmsgb24N
Cml0IGFuZCBzdWJtaXQgVjQuDQoNCj4gDQo+IElmIHRyZWF0aW5nIHRoZSBmZWF0dXJlcyBhcyBt
dXR1YWxseSBleGNsdXNpdmUsIGFub3RoZXIgb3B0aW9uIHdvdWxkDQo+IGJlIHRvIHJlcGxhY2Ug
dGhlc2UgZGF0YXBhdGggY2hlY2tzIHdpdGggZGlzYWJsaW5nIG9uZSBhdA0KPiBjb25maWd1cmF0
aW9uDQo+IHRpbWUsIGluIG5ldGRldl9maXhfZmVhdHVyZXMuDQo+IA0KSWYgVjQgd29yayB3ZWxs
LCB0aGVyZSB3aWxsIGJlIG5vIG5lZWQgdG8gY2hlY2sgbmV0ZGV2LT5mZWF0dXJlcy4NCkxpbnV4
IGtlcm5lbCBHUk8gd2lsbCBiZSBtb3JlIHJvYnVzdCBhbmQgYWJsZSB0byBoYW5kbGUgc2NlbmFy
aW9zDQp3aGVyZSBib3RoIE5FVElGX0ZfR1JPX0hXIGFuZCBORVRJRl9GX0dST19GUkFHTElTVCBh
cmUgZW5hYmxlZC4NCg0K
