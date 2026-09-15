Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17E12B2D7;
	Tue, 15 Sep 2026 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430431; cv=fail; b=GwFEtCmDCSGqXLJudsxlekXhbgZL035WkvsJcoJa6P/d+rF0WYszH7PxCoNHiy8Eypuk9iia+PQx39vH/CybT05QOtYCO1lKHLr1FeeVKY9WqYjpZwjJM1bzgglWP1F+l7wULsuDCPywyVbCPULgwsWx+TwsLx5+19wsxGlBvFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430431; c=relaxed/simple;
	bh=WB2tUhgDBZ8TDg4dDP8Iv6KXEwNY2xCDxerOUKZDpeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lh25Oqqt5vjUlAygZQx88YVq/QSc6CtmSX1LOK7kyfaYrB7t4mrp6Aj81EwxjEevoJDc+92BDQplKypHJmmwuqWy1xHuPCCtmb31QoXqXz3/QTAQ9nRd1SYW+fAc0Y1K7WKx8EPUj/FBJcZzZGcXBWQIbtWODfM7IAIWf261iMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=TdOBPQ/a; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=lbRHVh5S; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="TdOBPQ/a";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="lbRHVh5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=SBsBBMQSOPEswWzZam246tM4eFU1KlYy+pInISncxGA=;
 b=TdOBPQ/aUSzXhbeDqb/cboAodBUhIEriR+N0HvowgOwbQVCgVox1t+3m8nEpkNIEvrIx8hOlmDLqUqkS8I9Z938h0p25HzPM6ME/V58iu/+siDksj6685TUHZw2vr2iSCwWr8wC/2Lr0lHIwAUwEp9bgrpK1qvnffOJkRmsMA92ZgviKbppbBHLPqOYg1X/ccf3XxJn3bTL7oOgRLv6l5VZPQ1P0qVF83ELDhpabKWuzGs5UjmUclr7J1ZhETGjroZruWA7hSGtCsPai59nqBjFrCTH524V9lE6Iq8oNLxhz7O00l+JFYHykuZBR9yQ1JL1bw5A0WB9g4Rtb5n8LhA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021084.outbound.protection.outlook.com [52.101.57.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id D7CED100077;
	Tue, 15 Sep 2026 00:00:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2/0lrVIl3hC0+pLYpFDropmkK5Vta4MKC4JBgasYXFxpOgyM6JrYWGK6CaXzxheX+9fiZau2BMgsAdifqJ16ztWFKlMZKLWZYG7JC+1eqEgqdm+JnSongyU5DUfDk93ZABu2aVGmFNMwIHBvSYTUic74fgVZQsah8IlNAcZ1K7w3X4Ihcx4z+S4NAR3YOzC9CV3dKDGYpuN8JsHMb0kmDfVflq5gOJhakv2KbEDvmHm/ehHbr71fjBAnbn4mk+q+Ttu1wFjokiq5eFBCgzAkd+1xbaGKd585cIBhG0NpXIdSY/VWjrMIKM5sjwSAAxRd7iblP/TG8YGOaqeIrfK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBsBBMQSOPEswWzZam246tM4eFU1KlYy+pInISncxGA=;
 b=x1bJOeCpdnw6289m06WfIjVEcmEr6wKwv4q+8ZWuuScgLHioTZadvOoKCix/ny8Idoh2HsOvUjWaUZ4S2sUH/G2fzCWmz9R2Z6c0aO8IDXoQqq8qdeK1t+w1/uNTJCF/cZDJ6qVq9QYbcVUNNnraPhaokdgWy46ThdUXkz6vH0R8YYnTL9+lptXnbpgqJoaHq6U8e6zZdPCPnRqRh+HWA71zY2X2SkC3/0o8OTPddrBoM8RI+LC7SE7g0E87E1XX/aDRBaVipUw7gG5sMhkfSQPqZ9zuqO4TszD/iMbRwsk/8GIw9nzGjmm75QK8SO4ieMUCybAKnVZwgz1O9g8YJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBsBBMQSOPEswWzZam246tM4eFU1KlYy+pInISncxGA=;
 b=lbRHVh5STbnG+O+RX8tF2dcaTCkVwBINr8bUcJGneaqO96dSsvbAErVf/nB7qLiM3doviUUqRTSWkKfKP556x9yPMkKPa1zDQOkiNt+xHQAUH7Ife+PPOd00YPS/26h8n2lrHlKU3sTXZfByq4Oleq8YnVznz8J23+/cShBcF9lP5Gaz3+ezfKVIUQCPIhwtHrQrOiF5jjh5RtTnS12LfI0FhhmmKCBb+z3pn3Jfj/OKibaq+rseozAUqpW8NllW1l0+ulxQnJ4kOXuqYjzyKPxxRxZ/xyu1jhQM1GecbiH/sLaESEBT7sAfmtZ+Fj7CZpdsFDsgrmDEkk20a59CYw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:19 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:19 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH net-next v9 02/15] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Topic: [PATCH net-next v9 02/15] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Index: AQHdRKUxreuLQRfBak2nzeuyZG8UBQ==
Date: Tue, 15 Sep 2026 00:00:17 +0000
Message-ID: <20260915000015.80480-3-arouhi@sitime.com>
References: <20260915000015.80480-1-arouhi@sitime.com>
In-Reply-To: <20260915000015.80480-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB4277:EE_
x-ms-office365-filtering-correlation-id: 851e93a5-2355-4920-299d-08df12bc54df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 R0mqdD3OpA1yoffrbzOF4KSwGnoEsu3AxeNk//cxGfqV7D+o8mlbuT9rUL8h2tmATAVWFWqD3uLCVa040FAL6oNEO2xYD+Wr9qg1Y45zu+2hjYihQwCOeKp4TGnujXQ5wc+YLqEQm2M8uKTJQv9WNxMkiaUYcQQvaF+gzi+3HrnFxl1DUxCnOrCm3ksAD4ZYO4aOr6iIfXUX/mqrqyDL2fBnXzoDBh8sytCpGVq4R/tc+PP89gtbK9kYW/cQqnWUFey3l9NpVUk651lQNiQQ+8bfgI18RPs2e9Xc680DSrT1+ok3MjXkqLHENvW6wf6pXq30A38nIRcsi5EgqG5ZTvc6Ss03b6XqZ4oV5QynAo0v8WO7C7JQAoc/YpZ+qFq8NiRS3nJhX5oVS9lqfZqnDtKHUIy1ijMLxrR3EfcR11rTJqEQgempf53hm+6SDa946JlZPdsZ93/PShk3Dol63DdzALWwfoYC9xExFLDkWjhRUcF9NYfl7el31i82vU+IqjVp5diqcARbSXctOFxLYQkjHiPL9FXuDTla4W5JPwIE/Jb7OvnvExsP47NDCKbieHBb390drUmmxXnqpftbZUQ8RPKsfml9clNm+qPPWSzewTWkMRBUFzCq5t0tQ7U8Qu8GpILp71PzFwbG4MVGoeY+iTrtoTRXXshT2Lt7ebk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KHo/ZsNNYgf+u/IMa1s/zqcpy25eG2G9FHZmLHxiBKsab813eDQK77oc0h?=
 =?iso-8859-1?Q?nGZnt4XEoixZ9UbWw3ySDrxgZGKkgfUWs1EfwTUOKHzaD14/QncB4FARak?=
 =?iso-8859-1?Q?Mh228cl1g02cdc6nRlCuwrMZVyPQe6Lb+tgFIIJSdWX8cv3b5qaK4gE/Ke?=
 =?iso-8859-1?Q?p9vLo13y8tFZxR8fx6QYeex9E8XC85hWMD6F3jNbS1FXjXi2F6DiHt8xwR?=
 =?iso-8859-1?Q?6/nwnvCMkuI79jGciYV/4q5m+bGetsnLY6BH2UfAdYgOU6KFINXcy6rGLP?=
 =?iso-8859-1?Q?XHeB3KqJPU9slGl5dranObDQnM2oY0jLQbLBi2eVPUHmd0LB5Pv+RC1i0k?=
 =?iso-8859-1?Q?ZTWiZ1DmCO4qvrY7i6fRDpfkNhDl+SricJKIFZKLgXX9v657ow8MTfozMg?=
 =?iso-8859-1?Q?/39oHd9X9//01RMoqQNam3FISj3MsWXrC+IiUZOU6i31BmExuhDay0dl63?=
 =?iso-8859-1?Q?riZqoW1b5wkwJDWSQTkShvJ1yYI0/gLxBeDr5pXcf2SdmmMrpr4Wchmo1a?=
 =?iso-8859-1?Q?moWDF24kVwFYrTtU8EFUghNFvXCbvyYIfMyjZGBlshj+T/VThrN2InrisL?=
 =?iso-8859-1?Q?SY68SiCagJSexldgaUinmcel+ioKWHhTtPJMxpMDMOkETQWPAVrGr1T2bv?=
 =?iso-8859-1?Q?qnaYoBvGtmzvgG6ySE0AOo2BdFqpbs03IwrTLTJaOCWrORq/tNGqFIsW19?=
 =?iso-8859-1?Q?91d1EX1Et5znCZTOe9YpwdILIOcGuI7oe6MMq0ahQy/PcsnozMcNOXc1wT?=
 =?iso-8859-1?Q?o1488iv4A8RG/ILuHNu5WgPrgIpN5s9tdjDj0bH7c+1xSyW63/sOAfoARp?=
 =?iso-8859-1?Q?XVRzd50LlCP4nykOnUXEohTfvokseRPxSSJsjohrDFWBtRZHu8pl6HCT+r?=
 =?iso-8859-1?Q?WYtpRS1xD01dqrHdW92DvtdzTJq7Gnxnfkgn9zxlaQUSzAEtFiKBHqSTjL?=
 =?iso-8859-1?Q?E3GjwQZ9B9PIeMcyI1rNNZaXM1KasLj1bEwvBBhCN43v0T4YgYljO8xqCt?=
 =?iso-8859-1?Q?WxXi8wK+JJrw94Y0+SpuZ/qYTkX6kmQKXvFtsJmLzlKwydbu4ii/LL9Ey4?=
 =?iso-8859-1?Q?siS9xog5IQn2N5xFGaCSdYG6Cqkba0evGI4u07gXTx0Sc2YdITX01xaZBP?=
 =?iso-8859-1?Q?798lQRG0VBT99pfx4Z1YtUQsgU+Jy+5JmHe7ZlweyVRNU7gzv+y3tiX/gP?=
 =?iso-8859-1?Q?IpxobVN8P+hmD2QXyLh/wXoFBV48yPY2orxOwxu709j5IiuJbOyl704zli?=
 =?iso-8859-1?Q?LbPSDmnPMIomkWoKcrx9bY33ZaNqRbvwfyEjjWXaMJ6g4QWOulh6wKYvPa?=
 =?iso-8859-1?Q?sL0FjlimZzm0MmcyrS+oHcguKJqzD+KcmLgWBNCJoOOBDXxtHW+qene1O9?=
 =?iso-8859-1?Q?TT0gZpf84Yhx5RMXuT3aaNT70v/367fyzoJKwhvhhygY6Is1ByduqNyWqX?=
 =?iso-8859-1?Q?E2U3NjoirgS3zIWtcMB5vRc+w1dfcRLlRgU/XA1dZdZwZrElWltmX6ZlzW?=
 =?iso-8859-1?Q?p0hh1P3sfHwb0dpY3MYAAH37nn09ikeLZy9eyr1VBOTrnhgNard2wHR8TG?=
 =?iso-8859-1?Q?LmF9yHZLqyYBt1mU9ffkxLs9sDYCJI+w6FEsMaIhRlLlu0pYWPdcYGyXuH?=
 =?iso-8859-1?Q?kEfQtxhK3oXMi6tJH+lef85pklowKkdrHj3sa8CGzhDR38B+CyxqWq8wK8?=
 =?iso-8859-1?Q?ieKapQueh616F6bn7M+svTY5tAsEUNaTrhYSTu8rK4wHuPpgBWNWqg17it?=
 =?iso-8859-1?Q?Q0e7jt6bvqDopaXpNKeblnEWwa4fxAFLXm/lwCushGJrYV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	MCPZqePiDAAWoNKPIx3b0H0rDtQkM98A2BSx1Hx3gmWjeXR9wp/8O7YkimzxoWYUazUsmQMZgV/afo2IwtQoRq53UmbaM5wOvSK2tybm7M3GeaeRLI/FCfbw0ua/9yc2KbSbbQSzx7DRWOOoHEQwQUD+S2AQze1PUQgrhtmqEQz9GD5zVJeLH80i3WpppjDnpJPyd/KFNy/xdqDaQxVfkN54uZW0N/yUxLjjUrDScOTOXGKR/sQ4Yhal08R6gY9Dckn/z8CE0xuQbt7SWp1rxgmm1fI8A8vPiY2J4tM9CK9jxi9CLrtpyWRLf9m2A93GMGW1mksO40ckOnLqiRXF8g==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 851e93a5-2355-4920-299d-08df12bc54df
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:17.3860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2zFncitW5Wdc6gfIKfW55soxH3i5TOcpJAe8R+RsQPJYdDtEIIqitJNugXTlXJ86lg3lhmAYwZSQsVj65z5xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430428-NIR8v__cHb4H
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430428;NIR8v__cHb4H;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Add a binding for the SiTime SiT9531x family of clock generators: an=0A=
I2C-controlled device with four independent PLLs, up to eight input=0A=
clocks and up to twelve outputs, described as a DPLL provider.=0A=
=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 .../bindings/dpll/sitime,sit95316.yaml        | 181 ++++++++++++++++++=0A=
 MAINTAINERS                                   |   6 +=0A=
 2 files changed, 187 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.=
yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/=
Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
new file mode 100644=0A=
index 000000000000..e71ee3611a83=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
@@ -0,0 +1,181 @@=0A=
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
+      XO rate in Hz feeding XIN/XO_CLK.  Alternative to the "clocks"=0A=
+      phandle for platforms where the firmware does not expose the=0A=
+      oscillator through the clock framework.=0A=
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
+  sitime,pll-fvco:=0A=
+    $ref: /schemas/types.yaml#/definitions/uint64-array=0A=
+    minItems: 4=0A=
+    maxItems: 4=0A=
+    description:=0A=
+      Per-PLL VCO frequency in Hz for PLLA, PLLB, PLLC, PLLD.  The=0A=
+      values exceed 32 bits, which requires an explicit uint64-array=0A=
+      type; the dtschema meta-schema does not permit a type $ref on a=0A=
+      "-hz" unit-suffix property (only opp-hz is defined as 64-bit),=0A=
+      hence no unit suffix.  Override where the standard=0A=
+      Fvco =3D Fref * DIVN derivation does not match the running VCO --=0A=
+      for example a PLL operating in INTSYNC mode.  A value of 0 keeps=0A=
+      the register-derived computation for that PLL.=0A=
+=0A=
+  sitime,output-pll-map:=0A=
+    $ref: /schemas/types.yaml#/definitions/uint32-array=0A=
+    minItems: 8=0A=
+    maxItems: 12=0A=
+    items:=0A=
+      enum: [0, 1, 2, 3, 255]=0A=
+    description:=0A=
+      Source PLL index (0=3DPLLA .. 3=3DPLLD) for each output 0..11.  The=
=0A=
+      value 255 (0xff) marks an output as unmapped and prevents the=0A=
+      driver from registering it as a DPLL pin.  Override for=0A=
+      configurations where the chip's per-PLL OUTPUT_ENABLE bitmaps do=0A=
+      not unambiguously describe output-to-PLL routing.=0A=
+=0A=
+required:=0A=
+  - compatible=0A=
+  - reg=0A=
+=0A=
+oneOf:=0A=
+  - required:=0A=
+      - clocks=0A=
+      - clock-names=0A=
+  - required:=0A=
+      - clock-frequency=0A=
+=0A=
+allOf:=0A=
+  - $ref: /schemas/dpll/dpll-device.yaml#=0A=
+  # SiT95317 exposes 8 outputs, SiT95316 exposes 12.  Bound the=0A=
+  # output-pll-map length to the variant so a SiT95317 node cannot=0A=
+  # describe more outputs than the part has.=0A=
+  - if:=0A=
+      properties:=0A=
+        compatible:=0A=
+          contains:=0A=
+            const: sitime,sit95317=0A=
+    then:=0A=
+      properties:=0A=
+        sitime,output-pll-map:=0A=
+          maxItems: 8=0A=
+  # SiT95316 has 12 outputs.  When the map is supplied it must describe=0A=
+  # all of them, otherwise the trailing outputs are left ambiguous.=0A=
+  - if:=0A=
+      properties:=0A=
+        compatible:=0A=
+          contains:=0A=
+            const: sitime,sit95316=0A=
+    then:=0A=
+      properties:=0A=
+        sitime,output-pll-map:=0A=
+          minItems: 12=0A=
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
+            dpll-types =3D "eec", "eec", "eec", "eec";=0A=
+            sitime,pll-fvco =3D /bits/ 64 <6900000000 0 0 0>;=0A=
+            sitime,output-pll-map =3D <0 0 0 0 0 0 0 0 0 0 0 0>;=0A=
+=0A=
+            input-pins {=0A=
+                #address-cells =3D <1>;=0A=
+                #size-cells =3D <0>;=0A=
+=0A=
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
+                    esync-control;=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <156250000>;=0A=
+                };=0A=
+=0A=
+                pin@1 {=0A=
+                    reg =3D <1>;=0A=
+                    label =3D "clkout1";=0A=
+                    supported-frequencies-hz =3D /bits/ 64 <25000000>;=0A=
+                };=0A=
+            };=0A=
+        };=0A=
+    };=0A=
+...=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 0b42e898f4d8..ef07a53b5fc4 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -25157,6 +25157,12 @@ S:	Maintained=0A=
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
