Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1F481AB5;
	Wed, 12 Aug 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786557340; cv=fail; b=YsN66Kxba4TVaIsaNU6mPptEtl8btkMfKblZD5k1+KcDwjZooI4cC1koVsdWvVQPYElLlnMP03mxKb9bX6mYHcFt5e8gXDfGGVk9O5KaWcnff8gCtTidrRkjSXfZXBE6PDd8Q8P/AdAm0frzEHWzWrgm8EOAdDfe681x13iSE3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786557340; c=relaxed/simple;
	bh=pSY6ZjQnNs72PeUqCLsMOIVCchx3Qs4n1H/U/mCLas4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=luPhdcddT0fxt5MbsFxMnoMAWFNNTlEMdEZfr3ufH6rfoW6QGNZdYUcQ0D7/ULyzzkL/rkqAq3JwDLeHrpraLpivvywPCKWkdhqFXwFs8bUAbcR/J9cjkfnMQ5rjk7s4VwAGT+CoOkW4QYTEI1G8XTD4IYsXNlvlU+GiDxGutyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=TlxCZu2J; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=TwMSnnZb; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="TlxCZu2J";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="TwMSnnZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=jqzaL9ahUYfTBCKtjAfkdYLrgZYatIlJMcFVcQE/fEA=;
 b=TlxCZu2Jdfr6PX46LC/xWeA5OL3/fRBG94RBSWpMiP/e7k4LQ/QIvd46WpWqIZ1GLnMQzNyPO/8HPGm7DzRUSktBNmMqmcVl0iTBUUbEekTKctnNiPklpJgK1LfXDJnHympvB+JctrIlAMCHt7oJ0c09ofNJY1YqwuRc2J3HRU8lBVblBp+sCCBSBwoVqggMyiMMA7rVa3Qwnm/NRNU/RzTRCHH8LzdaBerc5lpSTcRlVlEYJuMYLPGUuaP2xnb8u9pqCRfyn/gNsZVkbSElt994GKGQsTPG3ouGC0kfkioXNNe+J/Nnv1FgTSSf4+iiE8jixIDtqqzPb9AT4NCf/Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020110.outbound.protection.outlook.com [52.101.56.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 71947340080;
	Wed, 12 Aug 2026 17:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXgxn94phNlzD2bsA67KGgd5PF8XUrLuoOOk0zPAUis5DQrs/SQdNnFEuGR6HfkK5DVaUl3bpsWGjLFY2YJjLmAQLSxdpQ905bsVTscQIhuwqzZso9R3GbjlMWisV90sLh6j+A6Yon1UOZAlQn0wyharzLZAlo6f9ExQcOANrcubjjAdOq5lEtwxhdZVW1zR4T+uKnzEIkJkroFA05Y71PzKWpa4Oqy0xBnr1pA/SwsOYzXFdlo/JrQPkUCdYb7fRuZKMooDmEXt2XJbJoAXjoxgcN3ErKcrSJbUZPcIsLvcroJwgkZd2C9Ja7Jvk6e/e1jIZvXESaoorilG4z2ppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqzaL9ahUYfTBCKtjAfkdYLrgZYatIlJMcFVcQE/fEA=;
 b=lkn2Z/oH3D2jbWw/IsjKVxfce6/h4prSLJTPldYbZ71xGcV88meOqHyByPBZVMcouqLDfOYyYig2j5xBR+QcPzb4ipob5bJVWWmqaG9tuRCOITs+FEiBOag5Rvj3HIL1zeVQceebzG04PTON8LzlEbuChaE/jZ+7eUXMl3pbOZfFldAUbWIQb9gPFen+disCTbpnHUPQxOUVyXoZZXABJnmyiik7FR5eRy1jQs3c/atZcsN5zeJLOIU6tfzz9sSQruom/31CiUoNRaH8SOjL3hJC2twuzx9AJnDOIPLWoev1IdA3RbIkr54/AfIeJuN6Xaje7uRdiCeCFsXFKzw6SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqzaL9ahUYfTBCKtjAfkdYLrgZYatIlJMcFVcQE/fEA=;
 b=TwMSnnZbmo4RsyVpVq1NRSvlbY79El8eKyHdyShxpLIrRoOEdvreOV1YwcGc2+E01Z/bqRKDMLtQ6e2f4FqtsFfpCGqcF952i0ASpC7MgsFnqhEMO5WcpWsC4jiIWE/MrPEfnNPWTMKOpq/JwS9vhs6BJnyEU+Ao+ynrYiZ6Vkb2obQZTolSaI9M3p8axUopAGEemPvznTN4Wl7o56Jyny9JXtXSl7WWpVKHBVspA8bB5Y1bY7Eup/2PLgPpr+dtj5+01409EXZcroemFn42P1Z4Ht0OQyUA5AxNC2QQDEFOKzZLmmHYXAPopOshct9ssftM7hb5u3t4lK5OLITkzA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DM6PR20MB3282.namprd20.prod.outlook.com
 (2603:10b6:5:2a1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 17:55:25 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 17:55:25 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cjubran@nvidia.com" <cjubran@nvidia.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v6 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH net-next v6 1/3] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Index: AQHdKoPAOKmq+0BJLU6/L5T8dsyf/g==
Date: Wed, 12 Aug 2026 17:55:25 +0000
Message-ID: <20260812175337.18155-2-arouhi@sitime.com>
References: <20260812175337.18155-1-arouhi@sitime.com>
In-Reply-To: <20260812175337.18155-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DM6PR20MB3282:EE_
x-ms-office365-filtering-correlation-id: efb8c1bb-8bd5-4397-8d76-08def89ae339
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|38070700021|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 HTExPLE/HGxdCjsMVafoMl5gOWSGdDNc/KWyK8aNNLs5nVb0KN7cBSnpGwzH5M+wsNIm62pbbqYTiIS7KQmTAHDx5i/HN/CLmkTXsYl7ibud9d8QY1939liiOP07hzkgwGnWx51Q7wVZ5833tukBU1CwCqYKOzzkXrBbNn/Ip44CeFL3WrcDXoHXHqRsWpgLXhv2GgC98MuxvaicXw1+4mHEZITHzG0awCxXregKHTEovSX/wYZKHRHeJDOX4DosDuV8dpx3o5fi+emWHkR62Yz85GvMzeEAEbwzDYhP9WWJW4+forFdzKN0UsBvPdqsxQz7+9/k4PpI8ZKskGNa4e7Y4x7+sVfNbU3oxSqGz4fCODc4PJ+Y8foXa0uRXeK7Qe0XRM2sW5cQEoFDPcSEy6woQe5rKU58iPFcrsnM2LNw8r6uoqyB9UTSJzEkL9J8fPf7nSjJmFr5PAzuNb1jvMSFGIofgUhMqkhfWYx15t/siHBBGBCnX+ZBEYI4L/Huvs2tOrmpepPr8X2gVkWhBQOxZBnP8E979yvBPpX0Vcsf1PPTy51c0y7WgLXOnCKfCl8jMgCaGZy8iUM3BYWQ65T9e3Y/IJj/44PYT2W0FXnzn9r7xrxJF0QYYGuNC1rn9hJhLMJW5MzNAGw+xQVN9Eg+I4MdzesLvEZBgD+VQvWqrmyfN71o85LoQVMHihF7vwUkeIDIuIWWFD0ENH1jJyuBYydz+3PnnecJsxcUU/o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(38070700021)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?r/x84OEx9kRPG9t2Xjnt0Ft/KzJt9CMUfhNM0kyoh+mMfNXy3QXYqkeyUK?=
 =?iso-8859-1?Q?cyOjMk252MlQnCw1nu99pXUp3mkCze5hlB6wyMmqVM8vXCx1iR35XIHnVd?=
 =?iso-8859-1?Q?HHR41s9mo27mh/6ig+y6ABx8bqGs5tYes71MTHUnaVNMzdWkeZTYKwsFHA?=
 =?iso-8859-1?Q?QrFLgogz5w/2wfnr6DTiqLB7DXdKeKF/NmaHOVgadjS6n7/oJm8tS0uJpo?=
 =?iso-8859-1?Q?vxgWLwL5EGUrj5FpjvCFJ6FkbgIc97JFr1T1zBdp6HE+h38X6Esyw9mZFu?=
 =?iso-8859-1?Q?EFgju5X+5jVIAME1TpHPe+PpOXtga6iI6Yb7W+mqXblg0b75oqlRNwPvhD?=
 =?iso-8859-1?Q?Scx8+vr9DRPXbVnVlokaY7DL2UcVEeRxs1yVLaAfGVM6RqNtGW62kOhBw1?=
 =?iso-8859-1?Q?pJpmD5pukuTKa16FGDod+9S790q7/s5SbXYqgfC9UyNhP3O9qlylMWTw2d?=
 =?iso-8859-1?Q?Y9VJ8kB7rCHvlFoNDnrANMhkZkfCnA+qIz18uyabSWRGunmDrXMqmsUsJV?=
 =?iso-8859-1?Q?DfyOAqUrZdMOSxtueDtLU030Fh9j9EhNWHjOpew9obqHVimq4ZNHMuFY/M?=
 =?iso-8859-1?Q?SifzKqUo8h2luZiCtpG6bOOq7J6F0l1ARp7zic7Feaf5OQe6CLAevXTtrj?=
 =?iso-8859-1?Q?bUX8R4BI+4v5altyYyVu1vCBf3whuOVyeZnNj0XZeQqnOGqyV2++RUcG7K?=
 =?iso-8859-1?Q?dcadE1a8cL5XfBzc4O/CpY5rKEUPejd4c3u2wfLCN9dfhosV8OZUmjmi6H?=
 =?iso-8859-1?Q?slk+pA84GTfKpAaobd4aTljKqRohUPHIcPYBbl7vS73rrscCXFQTQjKbTd?=
 =?iso-8859-1?Q?30psCx7ij3EpuoPTwLldnwudEHLNmFmEoF+EhnvwuYrE7nuAITtUFrxJyJ?=
 =?iso-8859-1?Q?11C11fpQzr6f+sYHdX40ZaJ2klDVyfaIsFO90acPWxMKSbIBDniT5J+0q+?=
 =?iso-8859-1?Q?8CkJ1gPax21+ucBgGC5eS8w5Bc+p9JAcEBNXOzl7Nun8/ZJXILg9rzpYrW?=
 =?iso-8859-1?Q?lUGA3pzGSXHPYWum4iJKU/zsvsXvwyegzgTEqnVDgMS/AXa/ujl8uXikLJ?=
 =?iso-8859-1?Q?9L9Vtq4o0d6Kke3u+Y4C1n3VuZvaPCEcD91dInwkeucIdYKag/oTDKbG5I?=
 =?iso-8859-1?Q?xjg0EyJNqRvMxFhzgFa4XMOeZY8NlKI4OHd8uYf3ffkVLXnB9ihayVS12o?=
 =?iso-8859-1?Q?VRxtDlHm2ha01ZmqqAbQL5KvEFz6aeog/sQP6LgsMzF/V0GaBgmAyBQIPL?=
 =?iso-8859-1?Q?OQTpImXO/i1xAZfo5ZtGWwbU1wr0QtE1kM1Mt09PeHk2dYuF+LSJFT2a4E?=
 =?iso-8859-1?Q?mk6usHdN0cfMlDmHY8R83RUJfxj9Dw4k+XyA1xn+N7xTI99SJeVpErV2iQ?=
 =?iso-8859-1?Q?ayyLtRAOI4Isl5SAm5m8kbYZZzFRWNsd2XqS02CVXBEBbGF8LRGhjnpcui?=
 =?iso-8859-1?Q?YF3cg7UDH0/OdhHcUeDmnoigKi+Gf3EVXcoqu2IsEUK+MeWfsmHCmTM5N0?=
 =?iso-8859-1?Q?QEYZBvPyIN+SZLRi2Ypcldfp/FBTvhaIm6QqC9bXaLkVLMZlVd0JzeREkw?=
 =?iso-8859-1?Q?g/p2fUuE+zx+hUVEIYNijnLk1MfT3cbX4rWnTX+W4UPRecXvCQdkUPxCXF?=
 =?iso-8859-1?Q?1SojmfjDPr+ndGrnwN0WJz/rxEoTrw0dTVMoEELYQedrE6DFtxX/Cn+aYY?=
 =?iso-8859-1?Q?0o+AJ+M0PLc7mygOqkjujAbG1MMv1DoQdT+TKID79qufRtz/6OEyd+9SVo?=
 =?iso-8859-1?Q?nEVo00Q+OyoZWsonNpFP4zLcq6gRpVQEx1896tHkeVu4Y2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	P/bjWZX9ubQD4MRobaLOHCklcPrfGuIw+EuRy1kLvwt7nqOHa74sLQiWP7pwpE5Tq7tAuIe1WLNEbjuW8Cj8t/mtN+YGrkjydXN17SO2jcwSquIwOS8wiqOa0QlraFfxQMBquLFyj9+6GBZLlCkEJ4PI22wGXv/cnPoKayhloiSZOlpHyJIMYuPgTtF9CAW4WWstvUM1CeQlIbi6xv65Gvp7bpQZwSYNfHMtbfLSbNcZMZSzAmgdWsFcPlz1XkXUxoxftdS9WUausxIg4AXuoxAVREYTR8sdsfi/uarZ1RD/Oexnlx9/CZtBP7jJK+ZO6yk5PwzgcPxQ8Mn4dFL6dw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb8c1bb-8bd5-4397-8d76-08def89ae339
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 17:55:25.2713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C6ltREr+wVG/9sTJ9SiE9S73U8I9h27JkLB/y3OUIrAFWFeJHybDryvccdZWtmw8YXVzD1U+M2STO33U3vKgTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR20MB3282
X-MDID: 1786557332-nsZwlU8fkq3X
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1786557332;nsZwlU8fkq3X;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Add vendor prefix for SiTime Corporation, manufacturer of=0A=
programmable clock generators and MEMS oscillators.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
Acked-by: Conor Dooley <conor.dooley@microchip.com>=0A=
---=0A=
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml=0A=
index 396044f368e7..1921718a5f82 100644=0A=
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
@@ -1535,6 +1535,8 @@ patternProperties:=0A=
     description: SiRF Technology, Inc.=0A=
   "^sis,.*":=0A=
     description: Silicon Integrated Systems Corp.=0A=
+  "^sitime,.*":=0A=
+    description: SiTime Corporation=0A=
   "^sitronix,.*":=0A=
     description: Sitronix Technology Corporation=0A=
   "^skov,.*":=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
