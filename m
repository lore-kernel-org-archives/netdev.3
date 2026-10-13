Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184CE53D9E2;
	Tue, 13 Oct 2026 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931300; cv=fail; b=HTMzLQbXmWTP/1VY0QUwYhpcNTz9MxHpL5BqsEiehSqQSFGwyIXGFnCGeoIGTQmL9VhRK9i9Jk7hEM6nzYrXYkuxtUsgXEyxRprAl7QpLRXFez/sLahGeC4n6phJ3KH5f4NOn2FusfEIgj8M54bcqfCfssY4m+9upcLsLEv5Zuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931300; c=relaxed/simple;
	bh=2ILYh+qRUfm7EJhqXmlc6ahoMY9BtTsi7YckV/i0/Jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FLyby472ErRiDRsxPQBw4l3AiyYRiCt08RgGt/YU0CikahKT+ct4h9/OTgqmzr5PMd1V1IFcNuaAPOYgF65aDX19XxPRtS4llGG8fsKmHceZFhPfNepbD5+M+BXV7evrHW9lmm+DRqcq+IMNzOGs87CK73Aeb0FOSZxsqg7qQkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=hj2Uj0Pi; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=ktdcUm+j; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="hj2Uj0Pi";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="ktdcUm+j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=xVVWuVA9JF6rNZyQ5xBu0PBo5UeOvGT8lBWPvYxhe3Y=;
 b=hj2Uj0Pi07CS1uQwuXSYOwn74BLMaB50OrtPZbc4ye6iP65Ji2148QH2NhdaFbR9UV5Gqp2TnnMdX7yOQO0fkM5xHpEI9i518kA7kFkHtPSSajS2KOSmBP8adGPOQF/ZaX2asI37GDeyWZWuonVGEosZ+F/CYtvJaakprtnDGF1EeJDoXZ0KMUmYI/ilIRBtTDWNz2KLdxuCnh88VEU/ahYHJdBwlchAqiXQXaNqdBY6w2QAJlbj3D9aYbCtQmZgIEtAf3tWGAz3+2w35s33oBkKrvrDjaJecIa62nMWa3Pgo0i0R2Pmf3nP+8Z0st1xhutygwTVZdUE2obNSoCSTA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021141.outbound.protection.outlook.com [52.101.52.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id EA185800079;
	Tue, 13 Oct 2026 22:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4X7gcQ6GAFBFdMujsGNeS/eCa0zw82PjxpYwje1Zv0KNkNscmHHdO+PmrqpdDtcpijVban8AwldNdpI5YyFob8UryjItM8WIsGMzJN2E8oL73WzTG9uULbhjj97JA8yBXdRe0VPcI8NWs63EaEaSh7cW/zIQsMTpiV2ZlTpd20KPuIl450U6uDkNnLrwdXazj8MwaSyZgKFpB64eNpSpLpbkyp/FmDqjDsKas2N2V3VmzzmKmSj2tgYj6CPLCWj6bN2T06SR32VlRPnjSYzQGXdk4iRGq7lJrwGS97QQAj2wWUs2coYqjzHmLylu7pNBbNea2vPZyThijevhCRKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVVWuVA9JF6rNZyQ5xBu0PBo5UeOvGT8lBWPvYxhe3Y=;
 b=Ffq0kTio3SqFIaZvF7HcsVrwpRxCGO+rZHU6aypYdzM9vBhy7368h6n1BE5PL1PM0mZofK5Ui2sKvGW/X7htCaVrsCr2eUF/Dz2FGuwET3mbF92OuQh6/5CkxGjspb97JTZzsw0u6tuh9BRChi+UcERN23JCsEdguz0XG8i3cBcfBPdjt44axcdcv0SKrCzb4BIg5UGac7+q2v5ReBBSMYcWnN7un7Sl8Gz/lCJpwFPEfB7qtDSJKyd3Ex3XYGC9gSmPUVl207JGIp0GCxM/mOLT1oCPM4c2Ge1+H70/nT8T9JlXbtAZgXIJGRXq27whQsuoR5o7oNH423PuhqhxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVVWuVA9JF6rNZyQ5xBu0PBo5UeOvGT8lBWPvYxhe3Y=;
 b=ktdcUm+j9fMaP0nBzuSuyk0mATG7dF5/rx/5h9wRVLzgX9bXKvGEZxlPZ4QO7+xgsPA30WS/1ndOiQRor5ce9bjkl4mIkQg/gz/50ArUVNpTs06gEbE9vhWbHFrZsG8d1ghl+ev/B5/W0qfpsjIozePfg9wri9mvPUMZh7lK4XADoU1i4n8YpRQK1PH502WQKYLh1N9Mq2WyjZR7GwhkJZYRjep7BBIVsEdW1GZ3+/v7FAzvs8ktajcykt7YV7AgATNtN30KOqFRV6Rq4i+eVFmhr51eNx8G8Lx5o4RJKX63pg+JYwko/aqfz72GB6dnc0Fo9wUMPAi1Tlhh2GPznA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by LV2PR20MB995388.namprd20.prod.outlook.com
 (2603:10b6:408:36d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:41:33 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:41:33 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v13 02/12] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Topic: [PATCH net-next v13 02/12] dt-bindings: dpll: add SiTime
 SiT95316 clock generator
Thread-Index: AQHdW2P/9ZE6kK9KDUy1mF8AMssy6w==
Date: Tue, 13 Oct 2026 22:41:33 +0000
Message-ID: <20261013224131.27149-3-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
In-Reply-To: <20261013224131.27149-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|LV2PR20MB995388:EE_
x-ms-office365-filtering-correlation-id: e00fa076-3f0d-4861-ecd6-08df297b21ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|5023799004|56012099006|261009223027099003|261009223327099003|261009220027099003|261009221227099003|261009221727099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 T1O1la0cPhvDnANINpY0V7k4m9t+y7uQJlrU8NWT2ZFExNfeoxmuQjcvJ3cny2WsiI7uzA2xQ2sttAxPOdcH8cS36bpGzR8VetgRuPEar9+NBW+YPnQsWXE/707d9Q0x0PlOxhLn3Mgt+9t11hJc2VAmGRgUdbEyn+5wsXL3eqx9Sx2SLFIDESaCmOHLEYIIds2m6xlwKJKcetQelw2t+VMaW5k068KoztNGdTGYBadadcxqBpg7xhr9W3SIDYSHYcIyvqOC6/Inoi/gEB0xrlePG9Uh4ME9HmMwRpcqXafNGW+zQuMvkzVZSaUVhwEkHUsZC3RS588SyxhOHRj10MtFTs6vAZxECAg3eq2xiJJC9swP+oEKwmclqhqPw1nzxEvDIS8VuECl5sWd8/FoCPn7skGN54s2QVzKW9zyaZjr56P89vYQDWrBD8z0HqRMZT2rzSktWauM6yu47nMKz3I8wvk5Pyc/hYAAHQ2fdyQKGi9Epl+/ykSlOix6xlq+g0HPZYVEfyuyRAGrts2LRn6HHzI9EsnZS1ba5LFUAMyVNEiNRxJZKbDtTEcyeOnVXUx87QKUmqmUvIjsYY0kZdt+q/AO3ABfx3TTN4Op8KfZFF3CgDozEwWEGLgX9aYNIWsYCsPNmeG/LH/LhVXV1X07vrHTwK9UyxVwDZXFMq4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(5023799004)(56012099006)(261009223027099003)(261009223327099003)(261009220027099003)(261009221227099003)(261009221727099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?M4G880d4wqkA099plpHZelg2tdDQpjf4JqJcbuA2h3LUWBDM4pulyornup?=
 =?iso-8859-1?Q?xH5Xb9gNAkDlpm6qnNp10CbpNTcn7FOSAziKCDd9KPyeP2NBsfWbWbSYt2?=
 =?iso-8859-1?Q?Mq7wGvfRCVclxI84azCj/uSMOzYRzKIRupt1A2N2ikezYA8FEkG/+HyczL?=
 =?iso-8859-1?Q?n0V3LteWNpz0xgGAyJGk285hFuvAYzvlO+lD/NWhNjzuvFNIps79RNoK+n?=
 =?iso-8859-1?Q?FuMWCYtP5q06zwGLfJrvf2Esr9oLrQAvDZ463QIENkepHthrtH8BP+nSTt?=
 =?iso-8859-1?Q?x4pYA/6RqrbzWkb7ZeNuHPqwg9uYvBbqhFRRNKEaU1ejIGRn7yxqoCp1S9?=
 =?iso-8859-1?Q?2hRo6BWnbb1RXuTD4GnIYkb+GoW5dq5K2KEb9PTVvwK+cWtz8iSFQHyXSK?=
 =?iso-8859-1?Q?uIyDaDZz/uQOg0ru09ZAp6E1OQ/2KnYJlRZ5pD9oUrSsagHU49teSl5hSI?=
 =?iso-8859-1?Q?pUQ6SvvuvOKykkrOHYsrrnOzn2/msJLHHkfSuVSPOOGlMC3k39nDps8AHi?=
 =?iso-8859-1?Q?L+tWb5EtWAyT4cMn2nCDW7UhAIOE9xI2UU5CsJ7o8OQ6VKCLRqUBqIgQMi?=
 =?iso-8859-1?Q?EmVLWqGx43nwQgQQgCTZt9VU4HxsFUG2vz2OglLUnn5H1242CQ2ZUboNzi?=
 =?iso-8859-1?Q?Q5bkjgLMCsMt08GuB3pmRB8DIldDQoks69EHsSvcfOSUF4dyb3rjiP6b8X?=
 =?iso-8859-1?Q?9WzXdXYl4Xa2oecf/7djETtF1EqZi8045nyZMMZ7hWgLodHe0HkLgwiudW?=
 =?iso-8859-1?Q?cf4O0vnd5LHxk6RcTvRYsuZdv+mqS+gPQa3t4bwT+YcJt1L9OYOunvUI/O?=
 =?iso-8859-1?Q?aM8pc4GXDRdPpV8y+IYBvcjTZ1kMA42nD6y8qamSTY+GetlbndMlsI75fZ?=
 =?iso-8859-1?Q?2zEsxWg3tS5nOcMeRhI5Z1zIINlOODCOF+f8sTg9AI16q3Q3Avnah8ABty?=
 =?iso-8859-1?Q?mKpdNyVULXD4ouZ/CkfgyiJ/FFwMJUAK5lhyfHSCkoRDWw3YD/E4DNtLZZ?=
 =?iso-8859-1?Q?Lyk+0Q/4BqYZsOJwWSOvcrNme2D+/iSMpw2ne6GvHYeU/ztZ+XIv8npJUG?=
 =?iso-8859-1?Q?+x18T03U9BiZW+7L2D+Gq5iSVaf/ZjR8WpIAyk9VNB++dGgMMv7TzWyb9B?=
 =?iso-8859-1?Q?0QAEJSHqpToEbzUeQJm80Tb72oA61mj3LQUdZRB+V7yWPgUsHSzWmv4U4S?=
 =?iso-8859-1?Q?wo4MA983oJR3pjfyMzhB4QW9yvBnvjrie4y71Lcs5iBBcgehAr/FcdhECH?=
 =?iso-8859-1?Q?NYzvtvo/VXTKSh2iO3WrUNBB2WJglPZUpT8lI4RiYmr0OYWs3xg8oBwqEl?=
 =?iso-8859-1?Q?cEs7aMc+A6qUe5erUBUf0rbhox1q5vfHuk9/s0qFfjQXBI/krtE4a+SRcH?=
 =?iso-8859-1?Q?Ektn1XbvgA+/A0jFTaPLKl/JMr7oqTm6Sid/Bh73GMpvBdNHLV7JcclVTC?=
 =?iso-8859-1?Q?Njk8Bi4JOY3DvT6CCWq76yoPlTHGwc35yk3RKJ15GprANIvvLnBEqWtlbf?=
 =?iso-8859-1?Q?Ar5zaYBeBw3pXlYxDNW09dsRRddCD2s88bHBFAioWXmx/zCD/BbCqPhQJD?=
 =?iso-8859-1?Q?qADJdylQ6JxMdiaROTL16V6baqiTolLIZyENveDIk6g0l+n+AfyRVp0Cwe?=
 =?iso-8859-1?Q?7gkkCZ/Azq3AXsYsPiftFAVAOXG+jmXnuivwdJaqhaCTKxaXgArtuqXkqK?=
 =?iso-8859-1?Q?S6L8YzuUydxyBXf4dZYVLG7u8f3Pa/6vPANc0gnvDFUL4C0/XWa/fuvofT?=
 =?iso-8859-1?Q?pYUk+vTFgt1V1A9JQOwMgb9gyKIIZnGmh2ny7X6YkL1lYy?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	1tDuUM81/ME2bY7YzHqJYTFIlH0C3TQHvVHTS4LF1anrabJDuu7Y5gH6XvzC6ILlhZrj1oli9q37kQ+g2/KK4+DpV1doRrbcSfOd/uuJEMRAEaF883aVrz5IsqR3hXno8J+v1p2ZAF/4rpr6s2NUvg39uwUkixeH9rvuEmIJQfXth8b48+X8eckKJt+PirDy6h9SL0+QFa3nsroTboRAv2Kjc08AW2qKk74IEdwPN6KAn7RqWa6V2bPqzQS5FGcMpCw3qJ00+cuy1X/3T9j05jlyri0AEuB+CyMyUVYv289BdF4BoOYt8VpUUFR5PR5QNG8NEcR5qnb66Mf+nFke6g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00fa076-3f0d-4861-ecd6-08df297b21ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:41:33.4404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8pgKxwY+AGfZjP8dDdpPbDRMq6AHumNULZvse5ITsLShftJVD+W7BtS0B6ZLHOojeZ9OGEPUoQ+MLmmdaBVZ8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR20MB995388
X-MDID: 1791931295-GG-YQWGEXQ7x
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931295;GG-YQWGEXQ7x;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a binding for the SiTime SiT9531x family of clock generators: an=0A=
I2C-controlled device with four independent PLLs, up to eight input=0A=
clocks and up to twelve outputs, described as a DPLL provider.=0A=
=0A=
The XO is given either as a clock or, for firmware that describes the=0A=
oscillator as a property rather than as a clock provider, such as ACPI,=0A=
as clock-frequency.=0A=
=0A=
The supplies are described by their pin names: the core and input rails,=0A=
the GPIO rail the SiT95317 has, and one per output-driver pin -- VDDO0 to=
=0A=
VDDO7 on the SiT95317, VDDO0_1, VDDO2 to VDDO9 and VDDO10_11 on the=0A=
SiT95316.  The driver does not enable them, since the boards so far=0A=
power the part permanently; describing them gives a board with=0A=
switchable rails a way to say so.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 .../bindings/dpll/sitime,sit95316.yaml        | 213 ++++++++++++++++++=0A=
 MAINTAINERS                                   |   6 +=0A=
 2 files changed, 219 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/=
Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
new file mode 100644=0A=
index 000000000000..200b9f709a57=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
@@ -0,0 +1,213 @@=0A=
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
+%YAML 1.2=0A=
+---=0A=
+$id: http://devicetree.org/schemas/dpll/sitime,sit95316.yaml#=0A=
+$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
+=0A=
+title: SiTime SiT95316/SiT95317 DPLL Clock Generator=0A=
+=0A=
+maintainers:=0A=
+  - Ali Rouhi <arouhi@sitime.com>=0A=
+=0A=
+description: |=0A=
+  SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock=0A=
+  generators with integrated DPLL for synchronization applications.  Both=
=0A=
+  variants contain four PLLs with automatic/manual reference selection,=0A=
+  DCO frequency adjustment, and phase offset measurement via an on-chip=0A=
+  TDC (Time-to-Digital Converter).=0A=
+=0A=
+  Both parts have 4 differential input pairs whose lanes can also be=0A=
+  driven independently as single-ended references, so 8 inputs are=0A=
+  individually selectable.  SiT95317 drives 8 outputs, SiT95316=0A=
+  drives 12.=0A=
+=0A=
+  Pin numbering.  An input pin's reg is its lane: 2k is INkP and 2k + 1=0A=
+  is INkN, 0 to 7.  A pair the loaded configuration runs differential is=
=0A=
+  one input, described at 2k.  An output pin's reg is its physical output=
=0A=
+  OUTn, 0 to 11; the SiT95317 bonds out OUT0, OUT3, OUT4, OUT5, OUT7, OUT8=
,=0A=
+  OUT9 and OUT11.=0A=
+=0A=
+properties:=0A=
+  compatible:=0A=
+    enum:=0A=
+      - sitime,sit95316=0A=
+      - sitime,sit95317=0A=
+=0A=
+  reg:=0A=
+    maxItems: 1=0A=
+=0A=
+  clocks:=0A=
+    maxItems: 1=0A=
+=0A=
+  clock-names:=0A=
+    items:=0A=
+      - const: xtal=0A=
+=0A=
+  clock-frequency:=0A=
+    description:=0A=
+      XO rate in Hz feeding XIN/XO_CLK, for firmware that describes the=0A=
+      oscillator as a property rather than as a clock provider, such as=0A=
+      ACPI.  Use either this or "clocks", not both.=0A=
+=0A=
+  reset-gpios:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      GPIO connected to the chip's active-low reset pin (RESETB).=0A=
+=0A=
+  interrupts:=0A=
+    maxItems: 1=0A=
+    description:=0A=
+      Interrupt from the chip's active-low INTRB output.  Asserted when=0A=
+      the device detects a status change such as lock acquisition or loss.=
=0A=
+=0A=
+  dpll-types:=0A=
+    maxItems: 4=0A=
+=0A=
+  vdd-supply:=0A=
+    description: Core supply of the PLLs, 1.8 V (the VDD pins).=0A=
+=0A=
+  vddin-supply:=0A=
+    description:=0A=
+      Supply of the input receivers and dividers, 3.3 V (VDDIN).=0A=
+=0A=
+  vdds-supply:=0A=
+    description:=0A=
+      Supply of the two GPIO pins that have their own rail (VDDS).  The=0A=
+      SiT95316 has no such pin.=0A=
+=0A=
+  input-pins:=0A=
+    type: object=0A=
+    patternProperties:=0A=
+      "^pin@[0-9a-f]+$":=0A=
+        type: object=0A=
+        properties:=0A=
+          reg:=0A=
+            maximum: 7=0A=
+=0A=
+          supported-frequencies-hz:=0A=
+            description:=0A=
+              The rate wired to the input, in Hz, as a single entry.  An=
=0A=
+              input runs at the rate the board feeds it and has no=0A=
+              frequency to select, so that entry is what the pin reports=
=0A=
+              as its frequency.=0A=
+=0A=
+patternProperties:=0A=
+  "^vddo([0-9]|1[01]|0_1|10_11)-supply$":=0A=
+    description: |=0A=
+      Supply of an output driver, named after its VDDO pin.  The SiT95317=
=0A=
+      has one per output, VDDO0 to VDDO7, numbered as that part's=0A=
+      datasheet numbers its outputs; in the pin numbering of this binding=
=0A=
+      those are outputs 0, 3, 4, 5, 7, 8, 9 and 11, in that order.  The=0A=
+      SiT95316 has VDDO0_1, VDDO2 to VDDO9 and VDDO10_11, the two shared=
=0A=
+      pins each powering the pair of outputs they are named after.=0A=
+=0A=
+required:=0A=
+  - compatible=0A=
+  - reg=0A=
+=0A=
+dependencies:=0A=
+  clocks: [ clock-names ]=0A=
+=0A=
+oneOf:=0A=
+  - required:=0A=
+      - clocks=0A=
+  - required:=0A=
+      - clock-frequency=0A=
+=0A=
+allOf:=0A=
+  - $ref: /schemas/dpll/dpll-device.yaml#=0A=
+  - if:=0A=
+      properties:=0A=
+        compatible:=0A=
+          const: sitime,sit95317=0A=
+    then:=0A=
+      properties:=0A=
+        output-pins:=0A=
+          patternProperties:=0A=
+            "^pin@[0-9a-f]+$":=0A=
+              properties:=0A=
+                reg:=0A=
+                  enum: [0, 3, 4, 5, 7, 8, 9, 11]=0A=
+      patternProperties:=0A=
+        "^vddo(8|9|1[01]|0_1|10_11)-supply$": false=0A=
+    else:=0A=
+      properties:=0A=
+        vdds-supply: false=0A=
+        output-pins:=0A=
+          patternProperties:=0A=
+            "^pin@[0-9a-f]+$":=0A=
+              properties:=0A=
+                reg:=0A=
+                  maximum: 11=0A=
+      patternProperties:=0A=
+        "^vddo(1[01]|[01])-supply$": false=0A=
+=0A=
+unevaluatedProperties: false=0A=
+=0A=
+examples:=0A=
+  - |=0A=
+    #include <dt-bindings/gpio/gpio.h>=0A=
+    #include <dt-bindings/interrupt-controller/irq.h>=0A=
+=0A=
+    i2c {=0A=
+        #address-cells =3D <1>;=0A=
+        #size-cells =3D <0>;=0A=
+=0A=
+        dpll@68 {=0A=
+            compatible =3D "sitime,sit95316";=0A=
+            reg =3D <0x68>;=0A=
+            clocks =3D <&xo2>;=0A=
+            clock-names =3D "xtal";=0A=
+            reset-gpios =3D <&gpio 78 GPIO_ACTIVE_LOW>;=0A=
+            interrupts =3D <12 IRQ_TYPE_LEVEL_LOW>;=0A=
+            vdd-supply =3D <&reg_1v8>;=0A=
+            vddin-supply =3D <&reg_3v3>;=0A=
+            vddo0_1-supply =3D <&reg_3v3>;=0A=
+            vddo10_11-supply =3D <&reg_1v8>;=0A=
+            dpll-types =3D "eec", "eec", "eec", "eec";=0A=
+=0A=
+            input-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
+                /* IN0P and IN0N: pair 0 runs single-ended */=0A=
+                pin@0 {=0A=
+                    reg =3D <0>;=0A=
+                    label =3D "clkin0";=0A=
+                    connection-type =3D "ext";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <10000000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkin1";=0A=
+                    connection-type =3D "synce";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;=0A=
+                };=0A=
+            };=0A=
+=0A=
+            output-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
+                pin@0 {=0A=
+                    reg =3D <0>;=0A=
+                    label =3D "clkout0";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkout1";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <25000000>;=0A=
+                };=0A=
+=0A=
+                pin@a {=0A=
+                    reg =3D <10>;=0A=
+                    label =3D "clkout10";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <10000000>;=0A=
+                };=0A=
+            };=0A=
+        };=0A=
+    };=0A=
+...=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 72ca3aab2106..858fe1c4332c 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -25182,6 +25182,12 @@ S:	Maintained=0A=
 W:	http://www.winischhofer.at/linuxsisusbvga.shtml=0A=
 F:	drivers/usb/misc/sisusbvga/=0A=
 =0A=
+SITIME SIT9531X DPLL DRIVER=0A=
+M:	Ali Rouhi <arouhi@sitime.com>=0A=
+L:	netdev@vger.kernel.org=0A=
+S:	Maintained=0A=
+F:	Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
+=0A=
 SL28 CPLD MFD DRIVER=0A=
 M:	Michael Walle <mwalle@kernel.org>=0A=
 S:	Maintained=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
