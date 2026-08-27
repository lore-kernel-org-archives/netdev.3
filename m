Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227263DB313
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 12:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832096; cv=fail; b=smfiXKHsEWl/JeZTnxRsE/It3l5FbhPONOrSvEKT6riMEs+SK/SSA69QpKhV8xcWO0GLqJ6VzBTmkhzvC3pXKDnmbmnXDhcM5j3bl+TqK38JFLB40QKty4EXC2GzfFGclVZU/7avAFO/4kyeSw3s2CfwtGHlgnW444Me/9i/nc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832096; c=relaxed/simple;
	bh=LtQI4vD0MYvsihCNOpJ2XVYHNmwSmyoPRnDwgxRK0PM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aNkcmoaIw0fWmP34yNvZ9pmEJ0YWCyZYTj8TUtmFSvmN0WG5KyCg9bQE9Qbd6w5R7p0AiTGBn08fMRc+ZlzbeDs2S6Gex3B9sFBjKKTKJVY5bfyJiZ8CZTbNlV/ficChbPBoWUNr11efgqn/n7B7UZQO/RvJRGrFsPvCtKGuUvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=QIVxTcBq; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="QIVxTcBq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jX9Z7vAUT7pxe3br5G6sCfDIfnBpPJlboLuFiwZH+xMtUdU7CoWIfIKV0BGOi0TriYfflaxdA3mNS0Yz0NMnwwMZfXV2IwotBqJjeaLwQJMvfAtsDWZlApytU69I9wS5bGxdlt03/AmzzyCFmQXO+4iHkU748BWfLChHdG7esB5OeTsWnPAKnTZJV/HYJekAI+gbYRSeKpG77ZFdhdM1A3AzwK6MYoBlbl1RMfkbsR4mbm1StiEfevm+p3PcJN/fKOrxuRQzjOZUksCV6QAkJrQ/0taBhR46jEbaQCMfKPAkKpmkzYx5ctVJB3BVQppn6i06iHvB4NQfX+2XawTluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtQI4vD0MYvsihCNOpJ2XVYHNmwSmyoPRnDwgxRK0PM=;
 b=S+L2ZvB3VKMpYW7MvQb25+k3UV03cKsNwXuKyZ6VzVUVoHYP9qHTeLipN6PSDe9WvWl760eT9ZrCuLG3SE8jeWNWenZNM+hji43BTZCTRAFqFvaSrc2Ac8LyTFf8Q9MDLX/sm4ESYjt8jQAVO3kHlNDBVsjBc26Lzf9rlQNt7A3FfldmRI4vlj2GUMix1uyCZWi+ZUAB2owEGnZE5kiXNxwpdDzpN4/9fHO4cUwyZnLkCJYEJGMMi8WsZ8cz1ROZ7JG/6u9pXhFNFMKPZoBHv1yOjzCzZ9+p1Zp04LnXZfU4fIScPTJd4yFP+aLtwvA/eBlWGHkCoHf19upt6hb5DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtQI4vD0MYvsihCNOpJ2XVYHNmwSmyoPRnDwgxRK0PM=;
 b=QIVxTcBqtfJI4c6f/3DvkgpXpJK7dE4031Xt1cyvVl/xnOqspS8N/Q9sZKjJI/Fgzs0hQqyu/qj28igLRzoWtpVNk0quqJq9bgVdd7Y+DXuU7TVUJLhPlFhrcqeHwos4Uoxf8GSAmje2xlDL0iZEvf6VWwRLPx7pZUsDeE9pQBeSB3kyj+CGsRhtbcLzFXDaSDLdeQBYC042VcWqkpbfj1fpkm6gNDjb66KvRE0IefuX3Vdgb0lpBoo2NuCAEJUQ10JA5MswbXafg+hcT1JNyHsWwvrVR7S26TFu97/eQYRcWH3R3WFyZVgvdau6DBIjXVAV9nnHZEEWmuiO+1z6GA==
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:63::5) by
 VI2P189MB3636.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2de::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.10; Thu, 27 Aug 2026 12:01:29 +0000
Received: from GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7]) by GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
 ([fe80::bfff:5391:8a49:21b7%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 12:01:29 +0000
From: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
To: Srilatha Addanki <saddanki@fortinet.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jmaloy@redhat.com"
	<jmaloy@redhat.com>
Subject: Re: [TIPC] Enabling an already-enabled bearer triggers brief link
 flap (~243ms down) despite 1000ms tolerance
Thread-Topic: [TIPC] Enabling an already-enabled bearer triggers brief link
 flap (~243ms down) despite 1000ms tolerance
Thread-Index: AQHdNL/5gg/ZiuzKC0+waAp0eE4DvravIHDwgADJzBuAAQy6B4AABVyggADP0gI=
Date: Thu, 27 Aug 2026 12:01:28 +0000
Message-ID:
 <GV1P189MB1988FA263E585254379ED3A6C6AD2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
References:
 <BN3SPRMB0002D8DE46CAA989F8F3961CB3AF2@BN3SPRMB0002.namprd18.prod.outlook.com>
 <BN3SPRMB00020EA67E11CAB28D9EBE6AB3AF2@BN3SPRMB0002.namprd18.prod.outlook.com>
 <GV1P189MB1988D232DCFFF279C4EC4595C6AE2@GV1P189MB1988.EURP189.PROD.OUTLOOK.COM>
 <SA1PR18MB64195FFB1FE652AF2586686DB3AE2@SA1PR18MB6419.namprd18.prod.outlook.com>
 <SA1PR18MB64191BF8C9F6A501752F65DEB3AE2@SA1PR18MB6419.namprd18.prod.outlook.com>
In-Reply-To:
 <SA1PR18MB64191BF8C9F6A501752F65DEB3AE2@SA1PR18MB6419.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P189MB1988:EE_|VI2P189MB3636:EE_
x-ms-office365-filtering-correlation-id: e4442d99-976f-4003-cdf5-08df0432ed85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|23010399003|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info:
 /9bTOhQC7Otno1oCrnTcKFmUXDL/eutBWpMw3oVTXiqQIHmch8oE2n6zHXdcOFxglyHo5Lb/AldbgQCLK+lrrk/pDbDGGI1TZg2rF9Sc8RjiB8efMmSdai2aEPneFQ7E4A5fUoB9CpSJ2k6OqW2C7AKM0T5wWSP5FmHTsac1+8vS8abiE/k5FOAU9S2VyIGII51u7PPbC0o7lbqJijKjm5PeOpDpze5HPJhItaV8LkT8sSee96inNb4pT5LJdz3b+lJDdfRhEzdPKQ93x847Vxd1KQSHfncdPMGZNp3WJMpsrtOwTyosJd455scccA+RkEA+JhMxI9CY4rV0uairCTyD9sj0VNiUDnpRh3V/G3Q1IxywegJK6AIId04gI984hwwy1THa6M0B2uFFPhZGR2dkJZAj5XaszUHtrM37SCyWVWxK1qUo35vqy4cW64uvm2Z1H+8O41SOk9ZzUXVmg5cd9KjrrgDAgfVwy9VsoxSxy+H40OR+5Y5iREApaXSA1VznMRI7ZJ7FXJMa+7PiHsMb3Ah45QdATbcsFL3yDsrb830AIEE2zkP0NR6x/9pwUoKoDA6bjuV3BL0Us7Boq9Bg8LFtCdd56QebKFdc91vcNghFegPJM3+ylUawq3MILqNOOaK7uffRtPjPSXtg38zsic/MhK5i2QtfxlCS5ygYRpPT/wQ7UQXdS00Kh00SCmJyPC8WqLjaiK1YzU0/yA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB1988.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(23010399003)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ribFVXqIdmSrrP/WVHIm9PP9NXkwlSmH3kceKxwypwHQxC7Cfb6F26y4JH?=
 =?iso-8859-1?Q?/PnKAausUsQyv9j5hF3gc+lR0bBHl9g3nctfOANBE3sGwBvdotuO8Xp44/?=
 =?iso-8859-1?Q?6ZJ/+HKDF3l/0L3en3CX50DolIpdn75/PdNfsrk93SXjDcCQuIff8oTuDs?=
 =?iso-8859-1?Q?xqhW/gy/O/jgev89sXHeJhQfAqnkpg/ffECZQl+kudjSJXYtPM8j2A8XWP?=
 =?iso-8859-1?Q?esnKi8uAoA3Qi1FGobQgaD4O3SwKumKVemqxzFqE3ZTBXJF3o9MlCcPcLJ?=
 =?iso-8859-1?Q?YEgksaO+Fk+veCWiMJZwWpP0ObdgF9W+78QdQjeq3Q18f0Wa8SiE2r+Hcs?=
 =?iso-8859-1?Q?oPDW8IQkk6A7JgQ69yiO+rXtElvaPC72XlJIPOQDhgp/WJQ0tDc7jknWO0?=
 =?iso-8859-1?Q?3FqyAkPPRj3QxKqeAsFMjus+hikGagXsAtaSj55JP1CL9dW2v+6IhoJic9?=
 =?iso-8859-1?Q?h9Hm8Ff9nfJDPibs9v0w3XEuwoUfw2InqRupLGZfOMqQOhtrpKZ/RGpAWj?=
 =?iso-8859-1?Q?BzLL7tSvjp2r0uwHSBAlZ1Y6Tam5S/cMcWxf37t0jm9ZzPi/wZABE9d1gS?=
 =?iso-8859-1?Q?sOi82SREj8LW3S8KlkGDMnWJOghatw/m1VVLMWu9eVQ7KWdeJ++6EQzZoW?=
 =?iso-8859-1?Q?eQq9KptUMUChi8VTQa5FjZ/kICkdckKv3iPO9tTpXW6xmu2vkMLSHzTJ4W?=
 =?iso-8859-1?Q?U4eJgUbmksTrGTk3D99UTDaaoKRa92uS0lki+gUhMkdxk9HTb0QuzExj+J?=
 =?iso-8859-1?Q?urBeHMqoi+QDHDSTikDr4cCRREMcJG6EYAxCCJUUKHGXnEpZpana2oK+dh?=
 =?iso-8859-1?Q?m7yZ3CtUv3fhDq1G3dRM0kEzk+SCG6QKcpec7PFm6wd437zlHgpQafLBBP?=
 =?iso-8859-1?Q?PERkf/nOXhK4BpJOTxCSdVq3USDWJuOjQz2NOeeeabI7EKLq3W9/aTSi1A?=
 =?iso-8859-1?Q?O4BJA77ikXBzAg+2v/yQX2YzMC2gZzCxSjdHc38je6VbQQE0TbGVZkEpxq?=
 =?iso-8859-1?Q?z7cCKdZxUcl0rLyhAFSG1+FSYvgahbiJIjBfPg247m9C5qMWRGxv68ZY0W?=
 =?iso-8859-1?Q?wu9mu9i6GNSL5JvgpNwhRIJvx0OitQNooG94HJkRdF7owMRWiA+d05aULQ?=
 =?iso-8859-1?Q?6MR4mCTFojl+KqgZmCf0zmX/16X3gli0yIHRYdCBPEZgrxBqhHQcO/BxWr?=
 =?iso-8859-1?Q?dlD/9AEHf0kEYPnnYM5fQKASXu4YJ80Q9czM90iGY0utmC3/T7UZXujyiX?=
 =?iso-8859-1?Q?iRK83PGKDPynP5bqZBnUKdd2BBPYpFviPY38PVC7Hk834Qlke3upC3vUei?=
 =?iso-8859-1?Q?h6lf2S6AtcfHTwhhgdxg2p06pdLUPgZBMu/aoH0TV4p/Te2Zxv1UczXP0g?=
 =?iso-8859-1?Q?vqilrvElWNX5jxiXQSo9tuTii38hFAQg95zxcottz9mBapgwJUGUUFtrEx?=
 =?iso-8859-1?Q?8W6/vdzynbvO5i4eglYVCJeWY2/NP+RebpGROo4dDOHO/SsPTghhSMfFyS?=
 =?iso-8859-1?Q?v4L9YSDN32O5cmB5u/K7dPKaFGTHS0IoT7pBgRYwIS6D0YNRIYMW75plKd?=
 =?iso-8859-1?Q?7XmeCbsBBVr401GNuZxlVgLxyz782iDcclWnOvuqR4c/+H49+vg/DR1VZ8?=
 =?iso-8859-1?Q?888yktgmK+BIIt2MhvRwfXqqAlx33cREOia2BhVQwilx8GRemiv2t/8h3I?=
 =?iso-8859-1?Q?c4iQOM0vLiMmDia1w/LAaEe1DXiblBMoXmMcW7wU5HCdH2anWqko+IE6zm?=
 =?iso-8859-1?Q?eSKQLQpqAn/Le2TWRyELpq7V6tNJIN2AI/H4M3wvnRGPcqAyrt8s/5hZ2m?=
 =?iso-8859-1?Q?zzBb+YcEWavWMrW2O4+Xwsxf6yvRukXgs3LzyT7BAd1M9l8Psjv7DoHio1?=
 =?iso-8859-1?Q?dV?=
x-ms-exchange-antispam-messagedata-1: HeatU6tDVPjm+Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB1988.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e4442d99-976f-4003-cdf5-08df0432ed85
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 12:01:28.9568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFvVnnC9MspthkU5Ao6K02Ysndnq/RLtb5Ck/+HIhvx4ucB4IaT2eOpG+DwkBoUxpbmjvhrmWir8o7zZJN540JEqkoUv/AFem6Hq9sgab/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2P189MB3636

> I was curious if there is an existing/planned API flag (e.g., --ignore-al=
ready-enabled in the command) to handle this on the kernel side, or if igno=
ring the error in user space is the recommended pattern.=0A=
No, there will be no such new "API flag". User applications need to check t=
he error code and handle it accordingly.=0A=
=0A=
=0A=
=0A=
