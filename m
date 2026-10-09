Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CCD4F93D7;
	Fri,  9 Oct 2026 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570722; cv=fail; b=hxHubdKxzI4OmGTcVtYCV1xypxqlVK8gOnma1oL25V4IPEnXHo1+8ZpQthlKD2wkt8xbniLSAshsAfJqNNJx9k87gsvUIxt/dIzE/tzfKPhZLFfQAa+tAimfu97g80yXj6XMQRiXwGF+r8Od+u+rSbU4PeyT/43sAS16VH+f9bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570722; c=relaxed/simple;
	bh=ljdQIvsFUi48y5kzHWAmxyaOfnDhIUUR3jziVhcx3oE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QhoZwUgKr0OSW+irXTigJHrCfvdhrBWJW2QZV1G6y2jprMxZairuGA6BKXuhhJgxF8ZgsWk1MJE5kmH7MO5/3dM7EvcMcAnf9qu9sCwdOMRm0iFSzzvXyCiL2Gk04jL6I1brF/O81mtc1UVIh960xxbqV515gP1wWqJ597EMTGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=YgxbatrM; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=uaHHF6sb; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="YgxbatrM";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="uaHHF6sb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=XgXZcYJsS8Qkdd8ARzjcVLbg8ZVpovsABxQ2FVoNhxw=;
 b=YgxbatrMdo/8QM7p0d8y8K0lrWs6a4CA7jIvY3XLG40kU65hmpOA4q/9V1qrOrj2p3MEPNdablHXOCwCONZ4WqIGKHFCgkB1xmbIv3ox8ODezvHSqgZO6xQbkoodct/w5kx5IUYn/wqqHwrtzQP+FBaevR65lsdXYSxWPsP5qmpw4nuhN0bn0fsarLXQSUBvBWBXbJaxtKObCIo9pR5rNI4ECNgifWFAgg5Z2ELEE0UX1qgSV+nIES4uv2UWnKB2Hkx/neCsap+xmrpIhLAK66GK6l1IjaIgyOMp/BW63mEVWr3spJl7E9lSv/UM73QcstSs6wrevtQHzktu7LBDew==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021143.outbound.protection.outlook.com [52.101.52.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 31B3480072;
	Fri,  9 Oct 2026 18:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XdhOkXwjmccv/Tn5Sae1zoQGBaRNHN8TBqOpia11+fg1CS2xRNfg9GUu403WpG/VVcbwKItYCHB7rxQRGg2X9xyuzx7b4QZnc9WgyhF3YXisTA8RS8mUJJ08+2Gdb/fTnuwc2zfatCwCgrVGkawLdU9ExnHF5eb802NI9U23o7RDxA3qSz/Nb7n4waDpIjOg08NpX4HEktdyQXidj5/Uq7wcoGveKIf/fO0dl6LYjjQP3avBk6y4xANsQhich80aGRsvyz0sxpipVeyF6RQXyMUS1co5uQkTBA+6UZOyh265vO4aRbaztrKOR7cmIU1D+2J6U9Os0ofHNR0pLn2BJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgXZcYJsS8Qkdd8ARzjcVLbg8ZVpovsABxQ2FVoNhxw=;
 b=MKGSk2m8sx2gaj0RNd4pkc5zi2f4G/MNR2kHlJiXTKMrb7bCa0qFcUERQeLjNKhjVZFLt4AkXSkofZlzxOi4ik7rRNkwTv+mFueZAjafHQxA1NQ3zMmRxIXSCMsqPrbMXodz1zxkcW4/OrMMn2RuPN8Em+uT1ib25SbARD3Mk7kBgm78Fp4a0B6SP3RpzbgvjiuvJWQGJA0E/Dj+uDTWuPmdd3FMFOJgdiD5+ZMTs1FSx6axhDKCAnCHq3RtUAvfCN7VCjLakd7OEbeYTxQ6/86hiFM7nAdjLEN3yhQrPfq1z3w4APbfe27fMS6VS85zZmcOVyjsZ/D9EWMzaPFi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgXZcYJsS8Qkdd8ARzjcVLbg8ZVpovsABxQ2FVoNhxw=;
 b=uaHHF6sbNl5NN2KszoHCuYY0PnG/mB22OIrnXsrPamy3/nNhlDDU+uo39np4aA0JmbCIFO19q7qtWAGnOY6A+Thoaz7ebW+N+czyYSK7A1bjV5yHYJafZKOukI0xWuFHrjUy+3gGXI3dZTzLenE8aMQC7P8wzZS6twxQg6ofo20hJBZwmH5EjJGV439ashsdNBqxHW7AE3UfyAr70elIr44/zaeGFJ7F9igL2LzhpeGgWz4AeBlsNS5zW/sdIuVzTElD1xwvMbG7lsWXt8SeGi6i6PBrvPRMLJzHvq0I2hykA6DABjjwJ/134IvTy3zogMq0ozfBTE0V2okxTPOYfg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by IA6PR20MB994567.namprd20.prod.outlook.com
 (2603:10b6:208:5dc::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:31:53 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:31:53 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v12 01/12] dt-bindings: vendor-prefixes: add SiTime
 Corporation
Thread-Topic: [PATCH net-next v12 01/12] dt-bindings: vendor-prefixes: add
 SiTime Corporation
Thread-Index: AQHdWBx0BwSm+eHHd0Ki6MkQKj+fjw==
Date: Fri, 9 Oct 2026 18:31:53 +0000
Message-ID: <20261009183151.78497-2-arouhi@sitime.com>
References: <20261009183151.78497-1-arouhi@sitime.com>
In-Reply-To: <20261009183151.78497-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|IA6PR20MB994567:EE_
x-ms-office365-filtering-correlation-id: 53b498f8-94f3-48c1-6c05-08df26339760
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|56012099006|260925021911599003|260925021311599003|260925022911599003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 M1ZT5zsJwQSMneEbPRUhwe5x4jtfYuQKZp6uMl0wQsq0n0bgK5w+jOpDV9WEAsuQQw6towoJNzWOLgIs6jc6dm4EbKmtxRLBwOeHsVMQYG2lY9/2NmDdxbS4r6mlau6AtXbnsJjPNUtz3vjoq0mWYTe2hYl0LtlZGjAZlIVDnXEWebNgKr/pNJQ7za3JxeS8udlHy3OZCB53LrgGelUEUiEycmF7F1qgkoIykY3NiFVZElJC+3pTwRTrXRRllHDXzYme3hTJ/Q+kkqK58Tg8WrCoJ1C/Qava8EQoU5k+0aNHqGngXtLckjy0LCKOLA1OVHiSeeYDkt56d/AklOW/p6td17dB4P+b/0bgaJSklVDNr6DCXWTC4YxCL912TZggk3LAyRvrz4WxE633H468PHJElrl+L835G6QSFRW9DO+Zxb6hufDxagmlanurmqj2iglTmkyGVeRYY2raDGF7HGfGYdGeVm4zenvZ/yMdeheKRZeNAYf/APzPr3HVwJkbM7KJ87kTPNhvLR5umi2h+k5P6lnj3obHmHRXYJGpQbfS4oHVJOGkWhnPFzH0RMc4/qmxIY0AfcypJNHrVGs2XH6MpKGQoqNrB47emoaf+cldI+sKTha9iQmUlGWWyszo1Z3R8MI/SyLwQB/yNcx1ibg+DAeS39Xt041I/rQJwyyzu4b2I7C0O6bpvfOlQ1xlX3wDdHIl1Pe3KVhUUH4G4AxH8Oc0ZSxvo1pwlU/ZXJ8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(56012099006)(260925021911599003)(260925021311599003)(260925022911599003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JY2wxQnobDsqXQKmoH0Cyaz7BHrQCpTmejrgQ30yVmR0i676Sdx2yadEZR?=
 =?iso-8859-1?Q?+tVzVzXYVfCCWjcQeRpZAL4EFI+XB/hzgLPif3Tp3+8E7yKsJ0gYz2Bkb3?=
 =?iso-8859-1?Q?MgfjQboBqwdNVnJFnkSmGsEqxihwsPlJ/aa5DLcp+pF4hCUe0xqED2SYFm?=
 =?iso-8859-1?Q?T/WHts7BH2dO6S3lZQ/xFmPaRQ3kgBJZNh/UayBcOzYJQgLs6kP2AVL0k8?=
 =?iso-8859-1?Q?8PwWAlnxiHPE0vzQX1m9Q/q+YFgm1oxFiXuXRenpB2vZN0os+QFKyIZWLW?=
 =?iso-8859-1?Q?2XIJzcQxkWQ3locZ+kYC0GkzWTTHBTbgBWPGsz6tyeG1gAR+E72iTl6vt9?=
 =?iso-8859-1?Q?ffncXOro3gdmpZs/wH3AwSHC9GwP3aJLFYPmrqYPCMsOUB2y6uzQnTUkd4?=
 =?iso-8859-1?Q?RCe6OCVcGuhCoy4oVa3NFrCb2+uOJENPc/emswRR2f6tiTZps2iQFML7uS?=
 =?iso-8859-1?Q?6t5QCblKOiYO1e/5iyNcYaylOWast5z562op4abe1zzfc+1Cuy8qi+/+O/?=
 =?iso-8859-1?Q?czex92ZKnPpJcRiau8I9ts3RJCYUiFsil/XChOTexLvanafn4mlAnXqGMZ?=
 =?iso-8859-1?Q?jVGpAZE9GfAVryc6m87RX6K5bHbmwRGCPYRlh9/BgN9/2hG9I+qjqRJf17?=
 =?iso-8859-1?Q?V/Pys64Abjj5OOp9kd/Cu3YCWhdpBvtg/0GJ7x5ci6x6Nv/KoDgY7nuS0h?=
 =?iso-8859-1?Q?hYvhvT1DLWjKRzN9B4dqwe6spBErduVipwWmk7lmiMuE1lNluYxOYdBDuq?=
 =?iso-8859-1?Q?VEZxMaSC2rlMniNcwAZyg59C2noL3BB7wM4i1SyvudkefoHzHVSlhNwYEz?=
 =?iso-8859-1?Q?vxxouOxOuPxh9tREfkF++TyvayOp18Rwewp5/+a4LrkZpOcwyPai49Xir6?=
 =?iso-8859-1?Q?v1llGjJuQat51QWwlhqaq21KgUTd6LNhWUVrMz4dxanXuhsiy9zXKqI1kN?=
 =?iso-8859-1?Q?mOlyVxkJ8ywllTBnwBTefhju1LD7I53/neTmMGkUKgsacWPsxVYCvb888K?=
 =?iso-8859-1?Q?iz4HN64whcZQkWqV3/PkDob9NPpVvRi0IkTHJSQFzc00pQwwpmyX0V83ZP?=
 =?iso-8859-1?Q?2y2j9x2rv3yUcKK7TJBT2hwAePupNUePR+AJ8zh1d93FZV3geYlu9EgLT5?=
 =?iso-8859-1?Q?xxf+ZMrsgVuMNzoMo1GGeSwSudtJ26KFhrA64HF6hI9a4ZUPegriIjtLym?=
 =?iso-8859-1?Q?4fRLCmIt/GKy9/XjX1M1J9FPyQkDS5bS47kmMRertJIBH3qBc1WwvSs6ad?=
 =?iso-8859-1?Q?1lvs5RjR/yhVUzWbEfT+NqnE+Wxb4eDQVA9ffp6XTuLsbVh3tmN9R+vWuO?=
 =?iso-8859-1?Q?CCB9bx+EHQkbIhNft0C3yDrnMvoDCnJU3axv7xhZBu1CvobiylsWc53/b7?=
 =?iso-8859-1?Q?FzaFTrXm20KCNU5Yn2jYvyhYTQeB1NQovcZRtFjp5U9M3auAW0V7LR4raU?=
 =?iso-8859-1?Q?lrVrrlnlRtHFRvDS3XB/6qzuAnaq1w0HlkLBuktIJICn/FYXovjie7mfKc?=
 =?iso-8859-1?Q?br941WDIPT7w37cQG0Tl688D8Kb+gIkUk9JPlLCV0C4IGngZDmmI+YfjR7?=
 =?iso-8859-1?Q?eDotK1unteUr4gODTA4E/OWf5T95FiaQv7HCj4l8KNOhHjFc20Zn6JGJe1?=
 =?iso-8859-1?Q?q0zngWqIkmTOLEeZkw3rJ1USLdPtZlVFIZOCWTN0hBCK7kM+Pff+MPG2yd?=
 =?iso-8859-1?Q?VaqiP7VHR1G3K8N7Zl2njQkyXT4EW72JKNDbaBTZ/JOG1rDBqcYfmg+ASl?=
 =?iso-8859-1?Q?JwWew8qWZJAJagbimY3J0nys4ks3jOFgBvLuC2W17k/jc/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	nzC3NLga99bEX3VbCY/VgSooCeeCrfB7Rt+H9alxDqlsTrlzHJTtbMXXPtqwLdrYS+JaV8j1i2SuEy0KOcNlCL6HSvkjP0Yh4uOdTgCcyGBFM94ojB3Pq6JKVYZ6Qm1bsE5CUSmJ41pste0SAi9q24czlPVyYaGiPI27nEF958zvYwxdrDcjdHWLB9Jnuvrmf0T+kd13TjaJ88PMD37V6fLaUlBjNwR1hbLLyu7Gii5aEFtusipEMgLiw47FmdscIwxF9E7Rn/R2mHtqv1lz5CQpS3E7XFOyu72wYZFnqvR0Dk5AS1SeIQThyaZ0WRc4/eo6ObRQa5yUR66ggU10TA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53b498f8-94f3-48c1-6c05-08df26339760
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:31:53.4455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZZk88WrciRENlNYpgUGylWHf+gGksC6EiqcqmWQjPgYHiPHJw4G8aKrB74oj3gg3hz3tqiWGhGs0mLbhr4NZqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR20MB994567
X-MDID: 1791570715-HUtc1mG9FQ3h
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791570715;HUtc1mG9FQ3h;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
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
index ba2002969373..65da27d6e84d 100644=0A=
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml=0A=
@@ -1563,6 +1563,8 @@ patternProperties:=0A=
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
