Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1BB3DAAB9;
	Mon,  3 Aug 2026 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785749578; cv=fail; b=tvKq8G4utTG/TWwNGLlxsHhPIOJ7z6qoi5PaA/4fOOWchwIhdAPnV3mve8Kg++SFXG/i4JdRzM2IJV5TWQhpGXcJNbhlClutbCYYTAtTGYA6uvkVlv7UgMk3MxegANqz+P7a7e0Kw0OB4FW/2fXld+MoDxSvaVrfC8n4zsQgvgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785749578; c=relaxed/simple;
	bh=0qedBf/9LVDWbCf6Cwvu4+SkZ9ilPdQo5fMsuW0mu5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ScxbXCQ+VANV/jplOXeql1u1OGyECK/7Ho4UrdiJzSbfGp5r83HQgWRYA5NWvnt+CKkdDGgqZJJbSkCU7T6xTgitoMVh9uDGzAaCxNOzzad4+tlGFG8dsr0GSkZ2EhYQ/y9GHoEdmfYxo0FnY36gpFZCSFDt+uG295Uc+DF5esc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mYeayndS; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Xn4ACOeC; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mYeayndS";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Xn4ACOeC"
X-UUID: 435ded4e8f1e11f18dc8c9802ae25ab1-20260803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0qedBf/9LVDWbCf6Cwvu4+SkZ9ilPdQo5fMsuW0mu5E=;
	b=mYeayndSp+Mqhe7tu1AofdEAn+rHhFFOBimE0eoRz7dh4CpHXYIky/+J/wL1Q2CKDRjDl5plKsvPqAdqkpRrx18Bc1/ShDlBcnYKXuiVUEAb6FwManTu6igJa46P6DQCr9e64iieYsFNoFRsnecVTUcq0rWjt7TUT9txLQdGJ1o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:68952418-4181-4057-9fba-d8f65811ddf0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:3953893a-5bdd-4f42-bfc4-0142c32224f7,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|836|865|888|898,TC:-5,
	Content:0|15|50|99,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-
	1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 435ded4e8f1e11f18dc8c9802ae25ab1-20260803
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <zhaoping.shu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1407488907; Mon, 03 Aug 2026 17:32:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 3 Aug 2026 17:32:35 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 3 Aug 2026 17:32:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3/OzFyjZDT1Xr9dSjFbwGlYpI3wFQqRriaEkpx+rjXkIRtsWe2uhnNPlvFNdQgZxoU10BGk4VFmKSdjIyBdGw6RDawc3cI2Bl7vsxRic6jBig5lHJkuilBWWgL2v7DtH311WRgLU/hcw4R6I4WSlKpENgYb10gHM3+bwP4HTfN+EPXv2DrW80Voj7dhqCo0PakhpAakMkMMqGlg9nan7Qz7Rxmc8z4UgsjRRkrNRDiWbS8+k2l2QVkdXa1k4+GoH+IAD+RFRmAD24GUMyiJxihwyqye4wG/GixiluOWzINIPoSnieIvY3sKZmk1lFSqdBUfET+NTAx0QERg20tXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qedBf/9LVDWbCf6Cwvu4+SkZ9ilPdQo5fMsuW0mu5E=;
 b=Qmn/FCwPlaEQDHhibQIh5YwsciY84s29wrPR6hCz92G0ZCYe3gGKFvOil76jl3xqRQA1wwEedyjSC3BDfjLmSd4W1GJ2g9HB2e/A0nUZoupSUc3W0LSxs+op/DRHqTgymmhfCCHPCRzYAR3IvFqji24PtIrhpxYJM7BsAL2/x/O86prZWqkLAwlMYsSMAFGOdQ77vNSthixmvfs2BbhsnIo1as3LIlBi0smIErTCq4dwNC16iVnlVlwIYe2B3CGEHnze3/pmmWwuajlnazK1cIOmD/jzo5aKKcXiFK9xE2uw39QiFxruf2gA2558dtc2cjSFjMiYIztHYRE4dQOkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qedBf/9LVDWbCf6Cwvu4+SkZ9ilPdQo5fMsuW0mu5E=;
 b=Xn4ACOeCndAQegdyUZMrrbs7+tnYmBKhFlMQ+x0JPKO/pAiyAbTYYsZ9kMSIiNEuxf/hDrVIC6dGJ3XcU05KPShdeAtWXcJuL+phdT4Jobz+Zs08mrwpFIGti0k8CO03B88/51q89HGO+Zxuo+rdVBiqr/SufzwBrMSadvN+k5g=
Received: from SG2PR03MB6635.apcprd03.prod.outlook.com (2603:1096:4:1df::6) by
 KUYPR03MB10311.apcprd03.prod.outlook.com (2603:1096:d10:97::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.17; Mon, 3 Aug 2026 09:32:33 +0000
Received: from SG2PR03MB6635.apcprd03.prod.outlook.com
 ([fe80::d6a7:ad8b:c6ff:fce]) by SG2PR03MB6635.apcprd03.prod.outlook.com
 ([fe80::d6a7:ad8b:c6ff:fce%6]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 09:32:33 +0000
From: =?utf-8?B?Wmhhb3BpbmcgU2h1ICjoiJLlj6zlubMp?= <Zhaoping.Shu@mediatek.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "willemb@google.com"
	<willemb@google.com>, "willemdebruijn.kernel@gmail.com"
	<willemdebruijn.kernel@gmail.com>
CC: "kuniyu@google.com" <kuniyu@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "imv4bel@gmail.com"
	<imv4bel@gmail.com>, "alice@isovalent.com" <alice@isovalent.com>,
	"eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>,
	=?utf-8?B?SFcgSGUgKOS9leS8nyk=?= <HW.He@mediatek.com>,
	"steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
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
	<davem@davemloft.net>, "sd@queasysnail.net" <sd@queasysnail.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"ncardwell@google.com" <ncardwell@google.com>
Subject: Re: [PATCH net v2] net: gro: avoid nesting TCP GSO skbs in
 skb_gro_receive_list()
Thread-Topic: [PATCH net v2] net: gro: avoid nesting TCP GSO skbs in
 skb_gro_receive_list()
Thread-Index: AQHdGoPpZQeEskAmQEC+Cb3VpJHrZLZ7HF6AgAAGToCACQMSgIAAvYuAgAc9soA=
Date: Mon, 3 Aug 2026 09:32:32 +0000
Message-ID: <c84c9f4bd495977e08ee38343282f05f42b080fb.camel@mediatek.com>
References: <20260723091601.72103-1-zhaoping.shu@mediatek.com>
	 <20260723063935.75bf55e3@kernel.org>
	 <CA+FuTSfgBbPkdLanqEgbDq-jLVQJax4fUxQ-tuzTuFwQANwxBA@mail.gmail.com>
	 <0f5668da79eb9a13dfdb9c97c7d71c5153b3a48f.camel@mediatek.com>
	 <willemdebruijn.kernel.1758c8f19209@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1758c8f19209@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6635:EE_|KUYPR03MB10311:EE_
x-ms-office365-filtering-correlation-id: 9930e96d-fa44-4bae-cccd-08def142257a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|7416014|376014|38070700021|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info: 4FUo2v2EEAWVrhvwnIfPo79sftR9XBFXwkMvdIoMDFwBF4xsjx1tNEPO5RcRepCO2ZlRy/sauhZQCRCySBwdcarwGoUWGY7vywBu+z5VeMoW6avb+As3NXc9FVcircJgXnGkHeoP1URdrBTyy2HrCoDk6cKUUTz6n9X3X5gkT51BuSN4ayZdzRZ0DLGOECZDrB2oU1aiW0T1/uKA/izWVZN8Hn6SYWXhOU1kuEpMozm1pHpwpTJqQIxZieQUznUd9nioswdIC9yA9qJzgXjxv1EU8dEvLCT5qgUQ5OKwX3SpFNDjWidceQWxN05b2v5XIF8w1mguNLnBvALoDRh9w5cFC19vmwgN74KYzf++P/37S62w7x/itDqzamCxtRYS5bRa6WUmcdLTQO+Eqg5n6ENpOwCkFA18BMAlb742B81N3vakLo/e8bA5M9LK7/k+pV7zeELBo0hExc2vOeGHuTiPhqrj+G9xgDYnh7I4eAWp8ockbVkhEpVBxMQoOw/k2ITAkyXJMqU9Wftbp4D644kUM1bXElwA/TRBC1vWlJ28KuDy9NcB2fgV3oWCuV2K/cquKpU0A7Z4a/tVLxFIaKYUB/QRJGGf+WgTquo7sdSpTnhvsPaL7tnq2PD8hLINCEGUGtxVEk7ySjyv8n7faHeiNkQaoWklccnIbuLuxCLh0X4JRfVa2j2vQww7QPG34FcNn1+3k/o3hdMyX8aCMgfikj6R91JFiA4P3AeMxjE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6635.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0hxTjE5Qm52bUxWemNzQ2tEMHhmZVZubGFLWnE3UVVRMkJ4eWVVekZTSksr?=
 =?utf-8?B?VDkzMHJkTkhjajF5bnlBTWdQSTc3SnpweVVTZDR4SCtMWFhtekRYaTJNYmxD?=
 =?utf-8?B?aS94b0ErL00rVk9Nbk5VdExvOEJmRUhlaHBib2JtOEtrWVF2cjMrNitlcGZa?=
 =?utf-8?B?TVRjYW1QdzdBOCtwaDJJYmk0SWl6WjAvdEhhWFlNZjJub2x4endpeSsxVllB?=
 =?utf-8?B?dUhQc0VDOGx4dmFaZjBuWTU2RzQ1OXJyc09nSEhSdjFqdU1adFd1bXVWRDFO?=
 =?utf-8?B?Z3RvR2VmMVRNWjhMOGxzSDRRclJnS1pOY2ozUzJDTElHQkl3N1lsVXdyck9r?=
 =?utf-8?B?WU5ibHpWU01rWkVQUTFxclhrM20yZjRpZFpFUjhhbTNROHdIdTE4aTQ3Skwr?=
 =?utf-8?B?Y2dZZ2QxT1JOWHVTSG1wRjFqNVNybGU2Vy82cmh2L1RZYUVPVlAzQy9JQmZP?=
 =?utf-8?B?NDdkY2dsWElYL1BiMi91YjN0YUtJbm9kZk4xOHVBbHFsbUZrSWJaKytONFJl?=
 =?utf-8?B?MkRvZk5uTHQ0VElZUG9pb0xNQjhmUS80QVpicWNoSjM3MkFNU2lmNUNWSDNW?=
 =?utf-8?B?SXUwclg0Y0diNWtiZ25YUnFVL2ZRbEJSM3Yvc281Y0hLU2s5cmxNUUs5VUNt?=
 =?utf-8?B?ZFVndWtKTU5XcHpVaGF4NHJtSWZSRVVweXdITmp1dUx0QUw1bFdZbTRMbzF3?=
 =?utf-8?B?TUtoNlVSdmFFRzNKbjgzdXdiNFoyNFNJVnpZL1RmbEZGamtteTQyRFJhOGJl?=
 =?utf-8?B?WDFBVWx3RXgyUHpFaGNQWEUxdUVHRkRHb2JZN3pGYlZLOThna1gvaXJQRUl3?=
 =?utf-8?B?cnA5emluWlM4ZWk3NnpQVDN6dG5jdm5kbURYVTRPN0d0dnVnM2hxbFhHeVpK?=
 =?utf-8?B?VzRTbGdsVm11ODZoZHJ0TzlENWpaNEIyaXJNK2FPMDVYZ2ppNGM4WmMwRWRY?=
 =?utf-8?B?OTdhOEpQekRPOUVuRnVQRUhqa2tJZUEzWkZRSXI1MHZZSkE0Vm9OMUhIYVFU?=
 =?utf-8?B?NWY5OXFQTHdIZTZjdmtWbzRqNi9RajcwM2JManZqWG1hRkZGdU1kN0RJWTJl?=
 =?utf-8?B?NW16OTZKblgzc2ZuOVB1OVBXOE1HWWs4QzFrejNVNVN1WHQvdjVFaFZvYzNV?=
 =?utf-8?B?VVdKdjFCVHNQRmM1ZE16a1JBMkdjandhaEJkekFOd1grMzZjUVFuMmZRSkNV?=
 =?utf-8?B?YUlxSDBpUGxzN0JyOVpuM21mOGNiUTR4MzZ2cWprVXNxWi9NZE1ocUhrL2dS?=
 =?utf-8?B?UjNMWGdKenRXbHQyZWpsTW9BbGhid2h4c0JNTlphak1CUGMwc1kyZUN2dkRo?=
 =?utf-8?B?TnJoeXkrTWdYLzBlZHZVbGVXcStmNVVjdHEzelNQVTdEVFJ4U0JWTUlOMmVp?=
 =?utf-8?B?NkZpcFpyRG9RdVl4YnlTWEJWbDBsQ1lRU0FDOU0wQ0FhR2xlNC9rV3JGRFhv?=
 =?utf-8?B?eVMzUXYxYTlYRzd6QzNhV3lDTDhaOWZPcTBvWW9EbndKd0R5bFBTKzZ3d3JU?=
 =?utf-8?B?MEtBa1lkWk9vZTg2QU83aUU4bGFKZDhUK1VxNHQ0SnNuU0pKUUVUdkYyOFJB?=
 =?utf-8?B?UTdkVVN5NlVQbzA4R1llTHk4S20wQllPMlR4UXlscWZ6OElmR1VsTlBDb3B6?=
 =?utf-8?B?Rll1Tmplanc4bGs3Uk52UVl0V0g1WnhQR1d4amJnOHlrcjBZaHphODBnSzUw?=
 =?utf-8?B?N3JKNnVaeW94T3kwM0wwQ0c0TXYwcTlReVBMT0dORW9NSXVtb3VoQkpUZGlE?=
 =?utf-8?B?ZHYwaHpOc3cyeENia28ycE9CNTc4dXQ3ZTdETlFFc3pCVERCUzBjQ1VuYXZ0?=
 =?utf-8?B?ZGlwSlhNaW9OZkE3bkFQTjV6WklMc2hKRklHVFlzc1lGdWc3LzFXTlorYmhk?=
 =?utf-8?B?WWZPOFJQaXBmckZvVkhneGZKc2lDSDJGMmNQQ2xTcFhUTy9xalRFWmlicEx6?=
 =?utf-8?B?TVZPdFcraTRNRFI3RGw4Q09zSmVjcVlSV05RamlmQlpNenBMdmNJc2ZIZXpj?=
 =?utf-8?B?RHJwTndPTHg5eVJCaGcxNlM5K2c2UmFlYzF4bWRlYzBrdkN2S1BYVE9aSUJP?=
 =?utf-8?B?eklPdmV2VnRSV00xNVZCOHllVjM1WTFFMUJTcXI0S2g0SGJ2TFRRRmFUMlJG?=
 =?utf-8?B?WUNwdzFpSVU1TnBQUm5sRTVHMm1xeW1RM1YwNTAvUEN4cy9Xd2tCaVE3b2dO?=
 =?utf-8?B?UjdRQ0JoZUNFVit2ai80MmM2YVFtYTVUbU9nZkIvUXYyWXhhdzF1WW9SbzN6?=
 =?utf-8?B?MFlMcEI3R1hCV2JGdWR1Wm5CMnVnTlhPZUJqdVA0d1ZZNG9qUjhCdmplTC9H?=
 =?utf-8?B?NnQ3cVlVTlNwMXI3QXdXL1lkN1VNSXU3NDQxM0VGS3lZZzR0NjBHL0IwS2Fy?=
 =?utf-8?Q?uOK5syYReQ3rGrf4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B79A35C10C490141873274881EB3DE2E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kbIKo8ZjrUj6XrmWwpLXSnxCtqbNU4vMTmlZHJTKUlt0bgwFVAQ2ZgfEEtFSbRLPyDXiRrEwXGUyEm/xqgP6BkxmrkaSHlA3tvtEfCymcRRrlGyhJPgfK5bC5iiB9BjjwXVsK9gH6PngqcDDQKz2FBZlldLrYBZ0ofPkVhw9dtMMwgKZ5wQD3GyWIxtFZLLcKRVUjf4TnOggL46aOVBlun7eq0hLkQYmyLUjHdi/BL0J2ROnhXgzyWlwHdqRudxD/XeHXrb2CvsPlmX0+0LuVfANmbej00fQAoa7bO+rNKmBO1Qtz+7It6/UKpmgI1Y4/G5tGPx5PwxO791yHIiv/A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6635.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9930e96d-fa44-4bae-cccd-08def142257a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 09:32:33.0986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8knNZvFp47B+pA5s0A+KQ7lFVsgwSCu39tKfvejwVmksxPlFwitf+X89FUtAsuTLLe6Lv40nevgGXbtWLPtVNpUWUU1hct+Akh56dZdE5fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR03MB10311
X-MTK: N

T24gV2VkLCAyMDI2LTA3LTI5IGF0IDE0OjU3IC0wNDAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3Rl
Og0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiANCj4gDQo+IFpoYW9waW5nIFNodSAo6IiS5Y+s5bmzKSB3cm90ZToNCj4gPiBP
biBUaHUsIDIwMjYtMDctMjMgYXQgMTY6MDIgKzAyMDAsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6
DQo+ID4gPiBPbiBUaHUsIEp1bCAyMywgMjAyNiBhdCAzOjM54oCvUE0gSmFrdWIgS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gT24gVGh1
LCAyMyBKdWwgMjAyNiAxNzoxNjowMSArMDgwMCB6aGFvcGluZy5zaHVAbWVkaWF0ZWsuY29tDQo+
ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IEhXIEhlIDxody5oZUBtZWRpYXRlay5jb20+
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gT24gZGV2aWNlcyB0aGF0IHN1cHBvcnQgYm90aCBORVRJ
Rl9GX0dST19IVyBhbmQNCj4gPiA+ID4gPiBORVRJRl9GX0dST19GUkFHTElTVCwNCj4gPiA+ID4g
DQo+ID4gPiA+ICJkZXZpY2VzIHRoYXQgc3VwcG9ydCBGUkFHTElTVCI/IElzbid0IGl0IGEgc29m
dHdhcmUgZmVhdHVyZT8NCj4gPiANCj4gPiBTb3JyeSBmb3Igbm90IG1ha2luZyBpdCBjbGVhci4g
VGhlIHRlc3QgZW52aXJvbm1lbnQgaXM6DQo+ID4gZGV2aWNlIHN1cHBvcnRzIEdST19IVywgYW5k
IGVuYWJsZSBORVRJRl9GX0dST19GUkFHTElTVCBpbg0KPiA+IGRyaXZlci4NCj4gPiANCj4gPiA+
ID4gDQo+ID4gPiA+ID4gdGhlIGhhcmR3YXJlIG9yIGRyaXZlciBtYXkgZGVsaXZlciBwYWNrZXRz
IHRoYXQgaGF2ZSBhbHJlYWR5DQo+ID4gPiA+ID4gYmVlbg0KPiA+ID4gPiANCj4gPiA+ID4gSWYg
eW91IGhhdmUgYSBkcml2ZXIgaW4gbWluZCBwbGVhc2UgbmFtZSBpdC4NCj4gPiA+ID4gDQo+ID4g
PiA+ID4gYWdncmVnYXRlZCBpbnRvIGEgVENQIEdTTyBza2Igd2l0aCBmcmFnc1tdLiBHUk8gbWF5
IHRoZW4NCj4gPiA+ID4gPiBhZ2dyZWdhdGUgdGhlIHNrYiBhZ2FpbiBpbiBza2JfZ3JvX3JlY2Vp
dmVfbGlzdCgpLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoaXMgY2FuIGNyZWF0ZSBhIG5lc3Rl
ZCBHU08gc2tiLCB3aGljaCBpcyBub3QgaGFuZGxlZA0KPiA+ID4gPiA+IGNvcnJlY3RseQ0KPiA+
ID4gPiA+IGJ5IHRoZQ0KPiA+ID4gPiA+IGxhdGVyIEdTTyBzZWdtZW50YXRpb24gcGF0aHMuIFdo
ZW4gdGhlIHNrYiBpcyBzZWdtZW50ZWQgYnkNCj4gPiA+ID4gPiBza2Jfc2VnbWVudF9saXN0KCks
IGl0IG5vdCBiZSBmdWxseSByZXN0b3JlZCB0byB0aGUgb3JpZ2luYWwNCj4gPiA+ID4gPiBwYWNr
ZXRzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEF2b2lkIHRoaXMgYnkgc2V0dGluZyBOQVBJX0dS
T19DQihza2IpLT5mbHVzaCBmb3IgR1NPIHNrYnMNCj4gPiA+ID4gPiBiZWZvcmUNCj4gPiA+ID4g
PiBhZ2dyZWdhdGlvbi4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgZG9uJ3QgdGhpbmsgd2UgY2FuIGRv
IHRoaXMuIEZvciBHUk9fSFcgZGV2aWNlcyByZS1hZ2dyZWdhdGluZw0KPiA+ID4gPiBpbiBTVyBp
cyBxdWl0ZSBoZWxwZnVsLCBIVyBvZnRlbiBydW5zIG91dCBvZiBjb250ZXh0cyBvciB0aW1lcw0K
PiA+ID4gPiBvdXQgdG9vIHNvb24sIGdlbmVyYXRpbmcgc2ticyB3aXRoIDE2a0IuLjMya0Igb2Yg
ZGF0YSwgdGhlIFNXDQo+ID4gPiA+IGNhbiBoZWxwIGJyaW5nIGl0IHVwIHRvIGZ1bGwgVFNPLg0K
PiA+IA0KPiA+IEknbGwgdHJ5IHRvIGV4cGxhaW4gdGhpcyBpc3N1ZSBiZWxvdy4NCj4gPiANCj4g
PiA+IA0KPiA+ID4gQWxzbywgYWZ0ZXIgZTc1MTI1NjQ4NmQwICgibmV0OiBncm86IGZpeCBkb3Vi
bGUgYWdncmVnYXRpb24gb2YNCj4gPiA+IGZsdXNoLW1hcmtlZCBza2JzIiksIGl0J3Mgbm90IGNs
ZWFyIGFuIGFub3RoZXIgYnVnIHJlbWFpbnMuDQo+ID4gPiANCj4gPiA+IElmIGl0IGlzOiBhcyBz
YWlkICJuZXN0ZWQgR1JPIiBvZiBodyArIHN3IEdSTyBpcyBpbnRlbnRpb25hbCwNCj4gPiA+IGUu
Zy4sDQo+ID4gPiBmb3IgQklHLVRDUC4NCj4gPiA+IA0KPiA+ID4gQnV0IGl0IG1heSBub3QgYmUg
YW50aWNpcGF0ZWQgZm9yIHNrYl9ncm9fcmVjZWl2ZV9saXN0LiBPbmUNCj4gPiA+IG9wdGlvbg0K
PiA+ID4gd291bGQgYmUgdG8gc2tpcCB0aGUgZnJhZ2xpc3QgR1NPIG9wdGltaXphdGlvbiBmb3Ig
c3VjaCBwYWNrZXRzLg0KPiA+ID4gDQo+ID4gPiBGaXJzdCBJJ2QgbGlrZSB0byB1bmRlcnN0YW5k
IGJldHRlciB3aGF0IGV4YWN0IGJ1ZyByZW1haW5zLg0KPiA+IA0KPiA+IEkgYWdyZWUgdGhhdCBy
ZS1hZ2dyZWdhdGlvbiBpcyB1c2VmdWwgZm9yIGltcHJvdmluZyBHUk8gZWZmaWNpZW5jeS4NCj4g
PiANCj4gPiBIb3dldmVyLCBhcyBhIGdlbmVyYWwgcnVsZSwgYSBHU08gc2tiIG11c3QgYmUgc2Vn
bWVudCBiYWNrIHRvIHRoZQ0KPiA+IGV4YWN0IG9yaWdpbmFsIHBhY2tldHMgc3RyZWFtLiBJbiB0
ZXRoZXJpbmcgdGVzdCwNCj4gPiBza2Jfc2VnbWVudF9saXN0KCkNCj4gPiBjYW5ub3QgY29ycmVj
dGx5IHNlZ21lbnQgYSBuZXN0ZWQgR1NPIHNrYiBwcm9kdWNlZCBieSB0aGlzIHBhdGguDQo+IA0K
PiBTbyB0aGUgc3BlY2lmaWMgaXNzdWUgaXMgYSBkcml2ZXIgdGhhdCBidWlsZHMgYSByZWd1bGFy
IChIVykgR1NPDQo+IHBhY2tldCBmb2xsb3dlZCBieSBzb2Z0d2FyZSBHU08gdGhhdCB1c2VzIGZy
YWdsaXN0Pw0KPiANCj4gVGhlbiBJIHNlZSB0aHJlZSBwYXRocyB0byBmaXhpbmcgdGhpcw0KPiAN
Cj4gMS4gZGVjbGluZSB0byBmdXJ0aGVyIGFwcGx5IFNXIEdSTyBpZiBza2IgaXMgR1NPIGFuZCBp
biBmcmFnbGlzdCBtb2RlDQo+IDIuIGlmIGluIGZyYWdsaXN0IG1vZGUsIGZ1cnRoZXIgYXBwbHkg
U1cgR1JPLCBidXQgZG8gbm90IHVzZSBmcmFnbGlzdA0KPiAzLiBpbiBza2Jfc2VnbWVudF9saXN0
IGRldGVjdCB0aGlzIGNhc2UgYW5kIGZhbGwgYmFjayBvbnRvDQo+ICAgIHNrYl9zZWdtZW50DQo+
IA0KPiBXZSBhbHJlYWR5IGFwcGx5IG9wdGlvbiAzIHRvIHZhcmlvdXMgY2FzZXMgd2hlcmUgc2ti
X3NlZ21lbnRfbGlzdA0KPiBjYW5ub3QgaGFuZGxlIGNvbXBsZXggdXNlLWNhc2VzIG9mIGZyYWds
aXN0Lg0KPiANCj4gVGhpcyBwYXRjaCBjaG9vc2VzIG9wdGlvbiAxLCB3aGljaCBpcyBmaW5lLiBB
bHRlcm5hdGl2ZWx5IGl0IGNvdWxkDQo+IGZhbGwgdGhyb3VnaCB0byB0aGUgcmVndWxhciBza2Jf
Z3JvX3JlY2VpdmUgcGF0aCBiZWxvdy4NCj4gDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0K
IA0KUGF0Y2ggKG9wdGlvbiAxKSBpcyBhIG1pbmltYWwgZml4IGZvciB0aGUgcmVwb3J0ZWQgaXNz
dWUuDQogDQpGb3IgdGhlIG90aGVyIG9wdGlvbnMsIG15IGluaXRpYWwgdGhvdWdodCBpcyB0byBo
YW5kbGUgdGhpcyBpbg0KdGNwNF9jaGVja19mcmFnbGlzdF9ncm8oKS90Y3A2X2NoZWNrX2ZyYWds
aXN0X2dybygpOiBpZiB0aGUgbmV0ZGV2DQpoYXMgYm90aCBORVRJRl9GX0dST19IVyBhbmQgTkVU
SUZfRl9HUk9fRlJBR0xJU1QgZW5hYmxlZCwgZG8gbm90IHNldA0KTkFQSV9HUk9fQ0Ioc2tiKS0+
aXNfZmxpc3QsIHNvIHRoYXQgdGhpcyB0ZXRoZXJpbmcvZm9yd2FyZGluZyBjYXNlDQpjYW4ga2Vl
cCB1c2luZyBTVyBHUk8gYW5kIGZhbGwgdGhyb3VnaCB0byB0aGUgcmVndWxhciBza2JfZ3JvX3Jl
Y2VpdmUoKQ0KcGF0aCBpbnN0ZWFkIG9mIHNrYl9ncm9fcmVjZWl2ZV9saXN0KCkuDQogDQpJZiB0
aGF0IGRpcmVjdGlvbiBtYWtlcyBzZW5zZSwgSSBjYW4gd29yayBvbiBpdCwNCm9yIHNlbmQgYSBm
b2xsb3ctdXAgcGF0Y2ggdG8gZml4IHRoZSByZXBvcnRlZCBpc3N1ZSB3aXRoIG9wdGlvbiAxLg0K
DQo+ID4gVGhpcyBpc3N1ZSBjYW4gcmVwcm9kdWNlIGluIHRoZSBmb2xsb3dpbmcgc2NlbmFyaW86
DQo+ID4gMS5Ecml2ZXIgc3VibWl0cyBhIHNpbmdsZSBUQ1AgcGFja2V0LCBQMS4gUDEgaXMga2Vw
dCBpbiB0aGUNCj4gPiBncm9fbGlzdCBhcyB0aGUgZmlyc3QgcGFja2V0Lg0KPiA+IA0KPiA+IDIu
IFRoZSBkcml2ZXIgc3VibWl0cyBhIFRDUCBHU08gc2tiLCBQMi4gUDIgaGFzIGFscmVhZHkgYWdn
cmVnYXRlZA0KPiA+IG11bHRpcGxlIFRDUCBwYWNrZXRzIGJ5IEhXX0dSTywgYW5kIGl0cyBub24t
bGluZWFyIGRhdGEgaXMgc3RvcmVkDQo+ID4gaW4NCj4gPiBmcmFnc1tdLg0KPiA+IA0KPiA+IDMu
IFAxIGFuZCBQMiBtYXRjaCB0aGUgR1JPIHJ1bGVzLCBhbmQgc2luY2UgdGhlcmUgaXMgbm8gbG9j
YWwNCj4gPiBzb2NrZXQsDQo+ID4gdGhleSBhcmUgYWdncmVnYXRlZCBieSBza2JfZ3JvX3JlY2Vp
dmVfbGlzdCgpLiBUaGUgcmVzdWx0aW5nIHNrYiwNCj4gPiBQMywgaGFzIGEgZnJhZ19saXN0IGVu
dHJ5IHRoYXQgc3RpbGwgY29udGFpbnMgZnJhZ3NbXToNCj4gPiBQMzogWyBMaW5lYXIgRGF0YSBd
IC0+IGZyYWdfbGlzdCAtPiBbIExpbmVhciBEYXRhIF0NCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBbIGZyYWdbMV0gXQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFsgZnJhZ1syXSBdDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgLi4uDQo+ID4gDQo+ID4gNC4gTGF0ZXIsIHRjcDRfZ3NvX3NlZ21lbnQoKSBvciB0
Y3A2X2dzb19zZWdtZW50KCkgY2FsbHMNCj4gPiBza2Jfc2VnbWVudF9saXN0KCkgdG8gc2VnbWVu
dCBQMy4gSG93ZXZlciwgc2tiX3NlZ21lbnRfbGlzdCgpIG9ubHkNCj4gPiBzZWdtZW50cyB0aGUg
ZW50cmllcyBpbiBmcmFnX2xpc3QuIEl0IGRvZXMgbm90IHNlZ21lbnQgdGhlIGZyYWdzW10NCj4g
PiBpbnNpZGUgUDIsIHNvIFAzIGlzIG5vdCByZXN0b3JlZCB0byB0aGUgb3JpZ2luYWwgcGFja2V0
cywgd2hpY2gNCj4gPiBsZWFkcw0KPiA+IHRvIElQIGZyYWdtZW50YXRpb24gb3IgcGFja2V0IGRy
b3AgaW4gdGhlIGZvbGxvd2luZyBwYXRoLg0KPiA+IA0KPiA+IFRoZSBwYXRjaCBvbmx5IHByZXZl
bnRzIHRoYXQgbmVzdGVkIGNhc2UgYmVmb3JlDQo+ID4gc2tiX2dyb19yZWNlaXZlX2xpc3QoKQ0K
PiA+IGFnZ3JlZ2F0aW9uLiBJdCBkb2VzIG5vdCBhZmZlY3QgcGFja2V0cyB0aGF0IGFyZSByZS1h
Z2dyZWdhdGVkIGJ5DQo+ID4gc2tiX2dyb19yZWNlaXZlKCkuDQo+IA0KPiBUaGFua3MgZm9yIHRo
ZSBkZXRhaWxlZCBleHBsYW5hdGlvbi4NCj4gDQo+IA0KDQo=
