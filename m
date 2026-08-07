Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA544E652;
	Fri,  7 Aug 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786093206; cv=fail; b=JtJ4boCeaFRKpzrPpNXiZYA2BSWO0mVI8u4Cs0qOiGN+f9Joy0fR6MqLD4Te1vTNSQ2PPxi7Uxn94xaGU1b9cLk94HK07myEJrc84A6/HfykGR8ivEyOyZTMV9jSvr0rxg4TmBPGPc6SbUt5EqgzCpEyLzuPn9vDkGoOCY94aOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786093206; c=relaxed/simple;
	bh=PvyVuHGxzgdNqt7MCt7IscDBE5L0cXnmqHW5ZTot9mU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LgQ5rfE4F8aG8UPzKkW4ShZX9Uddg84tfseyx6L6bksJfxgaMQvx9sFF3MNP93QxINRrnbpxGB8s7/4k4m+nBsNABWew/BvGzKj1+EaEg6SLdKwuq6vOwpnNQsKlWKA8Vyc3MjQ5Vu07DLPlDnOs7UR5uQWVUyZBYxZ+KEispkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=OHMo48eg; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="OHMo48eg"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777bIbZ754690;
	Fri, 7 Aug 2026 01:59:56 -0700
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11021117.outbound.protection.outlook.com [40.107.208.117])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fvy5vtux6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 01:59:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9xwj/IJyFEcxrmJN65UJo688wVtFmEOOVHQTvpLuNtd2KTkep9YfBi5ddtKuk1fI+Co6HcJuRUPOzqzKdYQ1MVULMlT/muG/2E864rZ760KV6gLWYxxxwX/NpZvMkPOnk3bYJenbx2f+c7N4575XBgNpTs9uXa42RBZD0fxLU/aZ7CHRlWjk31VTO20wx159geGo98CSeipL5P8pOGuHmH9eF/CS6lEE+Mr6d29+8hIF840KqiKyvYO/Pu9Lp+uYiUSomyhI6cKdNyqo5XKgTW/WR5SkEftXss27ENZqrLKJZu5Z15E1mJZPYOq55sr/saI3JjGqRnyPI9C/geXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN05TYCf9SyP7Uku9cXQF0epLzE3tolzoz4Dkxj3/+o=;
 b=HuIXSqfVQ5ONFujry3b5qXHhyDsnHirk2xRlZzUC22bZAOg7egsGzd8Fv1W0eK0U2jFi3cmUuxBNFFeSULwisdUM1RjjDOc2sCQ6AfPqEZ3bv9sYTwksG3g/8K13uQPtg9qesm1Xa5NjdUCGZN/Hne2mIS83nUxJNGcfSij7cQUS3qohAPp/Ocl6L0o7OBHWnV87zRlak3Z5wyHTTdcel2RB2GJEsl7M5+vu3tz3HMZVYp6aOgY059kouZCX41zcBpEDCbBgNkrNUY6lhuWL6yMbmNCKpYaB+QC8jT6dgs/hJ0dquicaGEbrABvldhatp+97+cRAnnt4i82fd2c5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN05TYCf9SyP7Uku9cXQF0epLzE3tolzoz4Dkxj3/+o=;
 b=OHMo48eg6ZOf6duHmdgcZHHiGBarnQtG7OLbX4WGGa5AsRlqhvfUFcOZvE9PbWJe3iLhh00Z2eP+WmAsPW1AscZ7CqQhGlR0lVDvyd8sXaRQBYwM8X43/R9Ylkb1iK332J2KCa3tvmeWmt8DX/X2s8JTbrmuaEl3RoDKb3TOa0g=
Received: from DM4PR18MB4384.namprd18.prod.outlook.com (2603:10b6:5:39d::13)
 by DS3PR18MB927665.namprd18.prod.outlook.com (2603:10b6:8:346::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 08:59:53 +0000
Received: from DM4PR18MB4384.namprd18.prod.outlook.com
 ([fe80::99a5:6a38:56fa:cda3]) by DM4PR18MB4384.namprd18.prod.outlook.com
 ([fe80::99a5:6a38:56fa:cda3%4]) with mapi id 15.21.0292.019; Fri, 7 Aug 2026
 08:59:53 +0000
From: Subrat Pandey <subratp@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v2 2/2] octeontx2-af: mcs: Fix SC
 resource cleanup loop
Thread-Topic: [EXTERNAL] Re: [PATCH net v2 2/2] octeontx2-af: mcs: Fix SC
 resource cleanup loop
Thread-Index: AQHdILDsctbKWI4OK06i5IWjFGe/rLaRLreAgAEjx88=
Date: Fri, 7 Aug 2026 08:59:53 +0000
Message-ID:
 <DM4PR18MB4384F1E2927E6C9DE9A5450BABD12@DM4PR18MB4384.namprd18.prod.outlook.com>
References: <20260731055310.1229213-3-subratp@marvell.com>
 <20260806152711.2563373-1-kuba@kernel.org>
In-Reply-To: <20260806152711.2563373-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB4384:EE_|DS3PR18MB927665:EE_
x-ms-office365-filtering-correlation-id: 08954cce-bd60-469f-9f10-08def4623f19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|56012099006|5023799004|11063799006|10067099003|4143699003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 ZXcIppU11D7irGnhbLrc8Z5RDb5au9P3Yp4Dx2HSDu51R48d2lmYfkCy1lT7w69yvO7tWSiLJDhOLGuhbbFxg9vP1LHA4HwJGyUkW6QC8WLcxV0mKLhUxs4zqOoFb8tPeXVrVUtJ2bGpqNvUlsnD26V7CMwuuidZjRHmGoWVKPj3CEqDUdRoMhXG7JCpBNlkhk2WbzHB0R7G/GthqEfiaKa2A6yGQG9al1PIe5AtDIyQ/O3ZgYf3+Ip3SMRzSOP9WfDrDQnOGCF7ZtNqIlSrNVNlT1BzwUT1W8jGd2lHu8uqA9gynUCUWjilmZzZclAjgAsGQW60/o45lV9LBu1upbBC/MFigPEXLTfWYF7tIwx+hYUCeZRybD04jiu7ElRbW/MTvYpevB2Davo2knKTqIu9D5nQZO5HC0fOiERfvR98jig0YN0HMMdmZoMcNBJ9cb3rnSuQiogtU/Id4fxy6hHfOGvPQMk7zLwH5dvXiCovudPL9VsqxLnMO+TetLcw4qpBfXyz8brs254cDrH5Z8hmH0Jv4IJw2LSQ9BNgADWCIrgmtX7Qpa18DEcm/CIojilAvybs34ghYjbiRIzdoGA8brhzQlfk0Qni+1bepknymO1NQQhOVLzZdE/TTsSxQq/lS3JMWPCsPCAZYVkoQINVeYfoLbssU2i1e5K7wfzxzJ1Y99B0ZvdjYpwWdxc+S2H+iYFqw+fZyHPlYA8HgY9lTOYcq/jQG2jtWSL5i6k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4384.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(56012099006)(5023799004)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qpkWP9u0TmIL4bcWxZxBcDdoyM/mhpEB+W0f8F6clxpGHHQK4yiMX0oHQQ?=
 =?iso-8859-1?Q?5B93QQqLdluiGMSnA9mNd0F0WAYGoSQUO293eXZR4J0/SOhb/wGdvmJQD2?=
 =?iso-8859-1?Q?1M+rSWIvM4WN+SyqORAZublT78yxd21TMP88jTW8jwKEf71Xjnkn/YqMjy?=
 =?iso-8859-1?Q?NM32H9RMEqzVFZruIgY5gM1rSLQ1dsrtmZBHJvA17G4NdSGrRkV46idugO?=
 =?iso-8859-1?Q?pY+Waf/B3gRAhN2s/2uusn8BmsAUi8GRRK+0yyWNxWY5VebR4k/9grqAUd?=
 =?iso-8859-1?Q?ow3tMY8BiXNEtU6ABHN05HxcNJioFPizhhD6F+HQa+ELRRufkHYSVJnWn7?=
 =?iso-8859-1?Q?17G6lD069QkEx2cIp+CYXdnY0HsOh26UbnF+Z1N7f4W42ST5a9Ojnb9Ihf?=
 =?iso-8859-1?Q?lzdUj95z22ZCoDRry6J4wKYIyvM59MyRlhQ1axuROtN6qdt/BX3d8D9Hwr?=
 =?iso-8859-1?Q?WWaYROUQSq4n9Gx8mItyjLJrJBStgdxwsPAABRDEfQ8VpBIBHi8p6gK7Uv?=
 =?iso-8859-1?Q?mRD20cosONVmyzpiQ9zB+ZsUR3dZ/hpR8HsB9AaZuhN5fmz3L8AEiInY/f?=
 =?iso-8859-1?Q?qLANmT7sQyJ3xuFx8gdJCJwqIDY2NIlmrrKtJ06NZK/EaB6L1G6GjkPvwu?=
 =?iso-8859-1?Q?zdRRLEDYSoYt/nEJFIylHw+dOwFmWzJEW5ZuGRHtn8xN51FNGTlCq4UMPZ?=
 =?iso-8859-1?Q?ZYM0s92MlhLpfUkiOAOsPZsyBq/oUjbehffXArOMUYgoqMlewTmjpw4E7G?=
 =?iso-8859-1?Q?qTrrz63YcpodwRn+RGBLw3sWK15UXDbciph2TMZgMg9oKoxIwG4HpyM91v?=
 =?iso-8859-1?Q?+rQkWjPFR7cNyEnQiZ8VLFSsJLXxJfhSMeh+N4aN6Ggar49ncSPH/4E/2d?=
 =?iso-8859-1?Q?2bWQLPGsGVsdKveQG/jwxST3LC/hOt2F1gQtzfi00i6bSOWBi/AigmdCZJ?=
 =?iso-8859-1?Q?IpP3DFRbH8SAnS1MCG1rSDLzXi7yotnQFpLo6Y+y6yn10Dz/5edEw5T6gZ?=
 =?iso-8859-1?Q?AjnqhdqVJl2pgAG2izYrCJNX9EgD2KXOIWUEiGjqcULoahaVRnLwbZfY2M?=
 =?iso-8859-1?Q?PTBt3gt/Dq4zFufxvFo/q0gzBsQxNLnZTJdD209VOEnyDaBBeMGbOUGGz9?=
 =?iso-8859-1?Q?c2nH9YNhrOSM99RBHPoomXaNS4COnawXtNnAhc9etaG9+K78zY1K/IaqIT?=
 =?iso-8859-1?Q?Llq2vqceckEQHoWnjEReOX38ZJLpI0debVgs5nNlU5Mqx4zQFtbqWBexGf?=
 =?iso-8859-1?Q?43swPZX/RdQKZXoPS2/hxRd0sh1oswzkjlUE8qMKpytl6cnb580H6vRpD3?=
 =?iso-8859-1?Q?YTc8O7fmFu9oPzKuWKI8o/VZO6T/FTunGXQCh18hCMBk/kHqChHhM94qE8?=
 =?iso-8859-1?Q?PY3wGM78erqeb5dWVma4tOjAj6H+AezIqFIwXUaVFHz3QlNCD1d92ijrHQ?=
 =?iso-8859-1?Q?ONCwVSMD34LjX+m2nOEfAcGZSPetM01DrEs4Rh50Kk30FoC4u/zs1ldecm?=
 =?iso-8859-1?Q?enYhtFgL9Mr3m64dWwq3ZfEHBTk1BGBqnBOSAhsSOrTaS5TL5+1BOMWlPW?=
 =?iso-8859-1?Q?HwWsulq7CdeXQeh5Xx9OvVM9ebRDQp5oYwAOMOjZADyqbly5Hq1eRAzVwO?=
 =?iso-8859-1?Q?0dlNrWI+9nPmOnUz3k1u0sZ0ofPSlBvL3x6O+QNmRpViU2e80kvhV5gI5j?=
 =?iso-8859-1?Q?lRNJZ34GH3Iub2sm8HPAUNsdoRP0OcX2cuURdwTHHcsRhUy1zXSyXW+aV7?=
 =?iso-8859-1?Q?ZeqZzRlxOGYSjPIIy1rLM3R4M2xRuwi/33NLZK8qJe9C4W?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	B9qAgjce1Nq4gk0r3T1CmHJxWrHHjc+jzGp056LBvXkzNQ4RHD7PNzTd9Mj7DYEQeYSp1Xb3swi8hW+oZOA8VssXPH7hLgTPwibNcnH1HGgkcS+6OIl7LOxVlALcP531ReAtxYbVHkt/a6jtIsCrMMLCjIaivqabgbl7frfkVvPLBA0/KaVPMCKIY7FJ3w+S/VYAxOBZ8N2qefF+0zZh0B7ltSupaZfjj0MROvZyl3msIRORm77NrLHIx0C4RyrJhtivGQYn6cokuuu8A639bSNEIOwCQCO9XyAj0x9EoFnDRVE8AaG7tjYHuR0u+wLEa2041CVMvMKi0Gp1W4T7qA==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4384.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08954cce-bd60-469f-9f10-08def4623f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 08:59:53.5778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+VN/UW7QqW2qfikeDqq8ZPvZC86vh7FBryhr58QQm0MVOmaKfZ5iZQ9wr9ipFWrzNWcaAms1Yqp0ZECrzvKag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR18MB927665
X-Authority-Analysis: v=2.4 cv=Ot5/DS/t c=1 sm=1 tr=0 ts=6a759e8c cx=c_pps
 a=fJIB0T+C2yAfE4P2TQxPqg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=Sv0fKeRqtYgA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=J1Y8HTJGAAAA:8 a=vX779P-GqtUeZOpxFXUA:9
 a=wPNLvfGTeEIA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA2NyBTYWx0ZWRfX2L+HiiImcew4
 2KA4xJKYwgTI4Q53OIX4StUjPBSP5PBzR3LIuqj1x4wAkWPAP7BY1/ZGNqAHo9WnWNdJLLTu3cd
 lTRCW9v6TaxES2iKXXa/fYaTPX0p3zRy1VJD4aQJmomje0a/dpVlXZ+cDWlMYC2OJTijokgLNiK
 WftBvBf9z0azAZU5Cx28vWTLeLFV9QSg6beaXoOZCPcFAj86WdP0t6MBFI3VN3lhWNQ7x4EmLsV
 +aoBUdnn2tQjaLBqAdpBM4E0vbu8HgcxGVenkqaQII1UJBesXsxEeZiptnIDBTH6RopHfMqPTm7
 DSYsQ3+yLRVGlArIqL+zQEIqSWOGCEop9g3IzuTrPMb3bxV7W1ndbeLZgyGIuoGw0RfpcO7sJTr
 Dkq6KDyAz58528M99dsMWfE7AzmhthCNbdDVD7jrcc43dLZecX+R9Yl7VuOwHSwLnnn+aY4L+Bf
 MfKunIFYL0zzJJmymTw==
X-Proofpoint-ORIG-GUID: _17oR71gjE4GHXZ5zpd2USU-vAMSy1mF
X-Proofpoint-GUID: _17oR71gjE4GHXZ5zpd2USU-vAMSy1mF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA2NyBTYWx0ZWRfX/JXFIaemqNnm
 PbxVfPYp5jP9aLSr4OYkMARoA0oUAzVu2XoOcbj0wasrpdXawty/Z9u+g6Mgq6aXOmbbnVNaWdn
 k/qe4/gx++VJj8kwBLi/qPtyDNiusNA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01

=0A=
=0A=
=0A=
________________________________________=0A=
From: Jakub Kicinski <kuba@kernel.org>=0A=
Sent: Thursday, August 6, 2026 8:57 PM=0A=
To: Subrat Pandey=0A=
Cc: Jakub Kicinski; linux-kernel@vger.kernel.org; netdev@vger.kernel.org; p=
abeni@redhat.com; edumazet@google.com; davem@davemloft.net; andrew+netdev@l=
unn.ch; Subbaraya Sundeep Bhatta; Ratheesh Kannoth; Geethasowjanya Akula; S=
unil Kovvuri Goutham=0A=
Subject: [EXTERNAL] Re: [PATCH net v2 2/2] octeontx2-af: mcs: Fix SC resour=
ce cleanup loop=0A=
=0A=
This is an AI-generated review of your patch. The human sending this email =
has considered the AI review valid, or at least plausible. --- octeontx2-af=
: mcs: Fix SC resource cleanup loop The SC cleanup loop in mcs_free_all_rsr=
c() was bounded=0A=
=0A=
> This is an AI-generated review of your patch. The human sending this=0A=
> email has considered the AI review valid, or at least plausible.=0A=
> ---=0A=
> octeontx2-af: mcs: Fix SC resource cleanup loop=0A=
>=0A=
> The SC cleanup loop in mcs_free_all_rsrc() was bounded by map->secy.max=
=0A=
> while indexing the SC arrays, and this changes the bound to map->sc.max.=
=0A=
> Since mcs_alloc_rsrc_bmap() sets secy.max =3D secy_entries - MCS_RSRC_RSV=
D_CNT=0A=
> and sc.max =3D sc_entries, the two bounds differ by one.=0A=
>=0A=
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/=
net/ethernet/marvell/octeontx2/af/mcs.c=0A=
> > index a07e0b3d8d000..88658c07c391f 100644=0A=
> > --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c=0A=
> > +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c=0A=
> > @@ -738,7 +738,7 @@ int mcs_free_all_rsrc(struct mcs *mcs, int dir, u16=
 pcifunc)=0A=
> >       }=0A=
> >=0A=
> >       /* free sc entries */=0A=
> > -     for (id =3D 0; id < map->secy.max; id++) {=0A=
> > +     for (id =3D 0; id < map->sc.max; id++) {=0A=
>=0A=
> [Severity: Medium]=0A=
> This is a pre-existing issue and not introduced by this patch, but the sa=
me=0A=
> wrong bound still exists in mcs_clear_all_stats() in the same file, where=
 the=0A=
> "Clear SC stats" loop indexes map->sc2pf_map[] and clears MCS_SC_STATS:=
=0A=
>=0A=
>        /* Clear SC stats */=0A=
>        for (id =3D 0; id < map->secy.max; id++) {=0A=
>                if (map->sc2pf_map[id] !=3D pcifunc)=0A=
>                        continue;=0A=
>                mcs_clear_stats(mcs, MCS_SC_STATS, id, dir);=0A=
>        }=0A=
>=0A=
> With mcs_alloc_rsrc_bmap() setting:=0A=
>=0A=
>        res->secy.max =3D hw->secy_entries - MCS_RSRC_RSVD_CNT;=0A=
>        ...=0A=
>        res->sc.max =3D hw->sc_entries;=0A=
>=0A=
> and MCS_RSRC_RSVD_CNT =3D=3D 1 with secy_entries =3D=3D sc_entries (128/1=
28 on=0A=
> CN10K-B, 64/64 on CNF10K-B), secy.max =3D=3D sc.max - 1, so SC id=0A=
> sc_entries-1 is never visited by the stats loop.=0A=
>=0A=
> Should this hunk also change the bound in mcs_clear_all_stats() to=0A=
> map->sc.max?=0A=
>=0A=
> Before this patch, SC id sc_entries-1 was never freed by=0A=
> mcs_free_all_rsrc(), so no other function could take it over. Now that it=
=0A=
> is freed and re-allocatable, can the next owner of that id read the=0A=
> previous owner's pkt/octet counters?=0A=
>=0A=
> The teardown path in cn10k_mcs_free_rsrc() always sends the clear-stats=
=0A=
> request with the same "all" flag just before the free-resources request:=
=0A=
>=0A=
>         clear_req =3D otx2_mbox_alloc_msg_mcs_clear_stats(mbox);=0A=
>         ...=0A=
>         clear_req->all =3D all;=0A=
>         ...=0A=
>         if (all)=0A=
>                 req->all =3D 1;=0A=
>=0A=
> so with the stats loop still bounded by secy.max, MCS_GET_SC_STATS on the=
=0A=
> re-allocated id would return the departing owner's values.=0A=
> =0A=
> [Severity: Low]=0A=
> Would a Fixes: tag be appropriate here? git blame on the pre-patch line=
=0A=
> shows the secy.max bound came from:=0A=
> =0A=
>         Fixes: cfc14181d497 ("octeontx2-af: cn10k: mcs: Manage MCS block =
hardware resources")=0A=
>=0A=
> which is in released kernels since v6.1, so stable tooling can pick it up=
.=0A=
>=0A=
> Could the changelog also state the user-visible impact? With the old boun=
d,=0A=
> the sc bitmap bit and map->sc2pf_map[] ownership for id sc_entries-1 leak=
=0A=
> permanently (rvu_mcs_flr_handler() is the only other teardown path and=0A=
> calls nothing else), making that SC id unallocatable, and on RX the SC CA=
M=0A=
> entry stays enabled because mcs_ena_dis_sc_cam_entry(mcs, id, false) is=
=0A=
> skipped.=0A=
>=0A=
> One wording note on the changelog:=0A=
>=0A=
> > The SC resource cleanup loop was incorrectly iterating over secy.max=0A=
> > instead of sc.max. This patch fixes to use correct value.=0A=
>=0A=
> Documentation/process/submitting-patches.rst asks for imperative mood and=
=0A=
> discourages "This patch"; something like "Use sc.max as the loop bound"=
=0A=
> would match.=0A=
>=0A=
=0A=
Thanks for the feedback.=0A=
We will fix it and submit next version.=
