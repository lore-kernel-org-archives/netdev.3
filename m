Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981931A555;
	Fri, 16 Oct 2026 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792112151; cv=fail; b=BPeWgQWyBDrv9ijgGwBvIO6322CnGueSaWtszFWcLfVJvvoGBDB51XYGCveuJ6SDZFhER29MFwVdrDl3zau8MbE/O6/EPScHAi4p7eCucyTJ+imqlce3SAcnSZOMH5EkY7Rs+hJ9w4rZWwk2jg6iHY0HmV0+6Skj3jfMAX6DNDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792112151; c=relaxed/simple;
	bh=ZxCR52ZZ9wBMqpxoSuYDSlYLAiLwJ2Cju+aL5T4tUs4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WH0BEKj56W+xJLo5X2QfjfBf09Ua631t1d7BLkwUQFF0CVYc1w92+FOIJYqyLl33SCTw8s1Ssz5YK5COTxoZ6s6hR4/TDeoSUpUDJXQGTF8Eseg4/lLFeY1c5uWNVikABTd6ag27YfUzG1Cu0JqtYVcudYWI26ZRoNmdCwbn/i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=BFtEPVwJ; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=Jn8Lf1Bt; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="BFtEPVwJ";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="Jn8Lf1Bt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=ZxCR52ZZ9wBMqpxoSuYDSlYLAiLwJ2Cju+aL5T4tUs4=;
 b=BFtEPVwJqffFdhxDuJI1CtgjTXOs301+Gg0iKyNgBA8rEdRjNYWeb2wnzIBSZrWvIhKXPzZjPKDBAaYkrSyPpt1gHTJs+PlOsbPPC+72R+0t1afD8jyOSaPsSSjD52NQOMUYaLRzpG6RquccjJ8aJL184eR6yJMzU/sWLYDh7bwTxaiUcA10Q8yYvQjAU8FPAJCkSCyMUpuOrqlg5Upi8LV7HbhW6y5/DVv7aVi6HSdaz23Fj89H6Y6JY7SwHPAVlc3N/xy7IU1qtnfyR91M0R/UlyOUdfO9e9hmNpnJDwq7OkbdMSdDdJGX5WOB0jDbmiu5hBPBkEM1lrFUKFD2LQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020104.outbound.protection.outlook.com [40.93.198.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9E2A5C0076;
	Fri, 16 Oct 2026 00:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7cEzNy03PoDGDyMs47mQNvCzI/YmIM7tDyfTUmIaofDwAGI7tiE4EXv40XeK/oecXK9//ldR5SF57nJv3LB8D+mhBIxmIhDJNN/Yq4nn2B3e9ba+m9iz2p8r8jcnHzjHSxE+9I6aDi1LnuzAyo0r79JITdRY1O/T0jW/f6EmJZ/wqDPtT0SiVwc6iICfoe5r/18zKYab2wZQnc5O9xt3UVhga25zBBl2Hh2zN4qP8qc4Pc/XGBSKsfthR78H3Y5RmsO1T3QF9pc6VWVRBskkdesm1ZUIQq43pVmRd1J/cql2snbvVncSm6FRku6CJUkWXYdl9VOl1MsWuL4YkPcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxCR52ZZ9wBMqpxoSuYDSlYLAiLwJ2Cju+aL5T4tUs4=;
 b=SILg95YmX6f4iFficpoYwKrKZvi/sUM3d1GfUtnATfEoRNKz3/ndkyAenWpDDjGVDGu2VGROaIHelSW9ZCpvtXmnHTaAYfJ4p8fdnGi8S/Sei2WZHBBSCsnSGMiLQaMMkqyRJQgKZEREmg3dzpIAYsVukq7szQxcy8xYHGeJ8PmGaSc13qWSWSzCku2m++IOH/I5V/btXfveXa/AyINZYBjC5FdMoVb21kUod6UXTfFQb+Us6EYJAOu0qSh+F4RvR+TeLXYg4209uYV+2kLrnKEfCZrTzIfC11Rcz87Ia4MDy6592Tr60pCl2fs4dJvaVpZRD8MCTceYtZZjzFZyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxCR52ZZ9wBMqpxoSuYDSlYLAiLwJ2Cju+aL5T4tUs4=;
 b=Jn8Lf1BtKPazvB0yqG+g1pC4Q3zNUM18dU7i/xEz8UuyewrB0jf88TuebBrbHyOK1tzTlHD9iNxGCy3wqjyFGOTGFFN172vJ+q2VRMO2uRotstUrmiXaQyrmV1GVViuLHmgj56v3OHsthiyJS+rpPQ3kJKdKmUoLBadm/jSYuxV3Zt5+ImMT8hmLWrMFWn0iIOUgzFnhTUiTKSpZh56yfxKU9qM3tknLkxaOYK5zNKdu62ZAWX+4bIcujBuAyRYmEInn8cUdkFqQGpU2w65Uh3xSnvPLvTqnGKmg6vRRbMCnfU7xiSPzZC8XzYehjpF6xrdc5LwGr6bhG3qeHIVHaA==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MN0PR20MB4789.namprd20.prod.outlook.com
 (2603:10b6:208:3c7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 00:55:45 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 00:55:45 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v13 12/12] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
Thread-Topic: [PATCH net-next v13 12/12] dpll: sit9531x: model the inter-PLL
 sync net as a pair of pins
Thread-Index: AQHdW2QC5cGg2ZHRfE6zmmz5BnQjd7b9o52AgAG3vIA=
Date: Fri, 16 Oct 2026 00:55:45 +0000
Message-ID: <20261016005541.11374-6-arouhi@sitime.com>
References: <20261013224131.27149-1-arouhi@sitime.com>
 <20261013224131.27149-13-arouhi@sitime.com>
 <sashiko-outbox-172000@kernel.org>
In-Reply-To: <sashiko-outbox-172000@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MN0PR20MB4789:EE_
x-ms-office365-filtering-correlation-id: 1eac94da-971a-437b-7a0e-08df2b203627
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|5023799004|56012099006|261009223027099003|4143699003|18002099003|10067099003|6133799003|22082099003|3023799007;
x-microsoft-antispam-message-info:
 DQhumiF/OQxULd2DPjHpgUfVAIlH2Nju6xQVzlhtD9s9NbHhJfSgBkSUQPti77iClEjjxpuyVrkkTAYfRCK0Dkiz4MgaZTrvqUAvLkY1TCM0G0v6W19O9EEy1fKJ70DMrQtUtUhWLh9OwuLE8ptWK/TyIIeysPg5DnuxAOln8W3ACMqLHYT26qrlxsEfdYMKlM3XtvLkGJdzVRmIogX/QuVqgICODHzsGZTmytFvtuNYwdGp5RUFtMLRXTkQJe/zjVr3atTyMQ712swsIi4G6jErpcBAeRvkLE8dsEGbiXlh77BMdkZpDk2IMy3CmUfJoca7dQul04UxgFBSUt61D2gkW68h+ZAkRgyKDjBr++34f8+ID1k5zmILHK1nYPsCyvOAssKG+wq4uz+1zPmuSaxwjEQmWrZayymlF31o7PQu/iDa9BKjE6h5P9HJt5Zn1rzq0CpdsjzE/xvGwUyV16ye4RLirOpkmb9INeFtTtY4uIBFqVbwh0Y+61N6KVwyC5a8SLpVX326aw24diaRDIY0lBy5FWUNqoUpJavHuPpVrdlfd3I+HgEPTcSOGKHxa+G90r9KIID0pHZ8TNS4OV5Q64PNszr3HcJu3psMbltH1JoxadJdNoE/JUNsxN+ApJL/7NI/cN6ReMKmAKcWAmwcLPE8EV9CFsUlHJd+1/p9Dy4ILyzqYvnKLZuh6/6fPC7+OE2Tdg2ylywquBrObl1VLJbcLp0/rNxdq7ExRRU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(5023799004)(56012099006)(261009223027099003)(4143699003)(18002099003)(10067099003)(6133799003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjBTamh4WVJPdWlsV1F6dFVVclFBUkRtY3k5aml5VnM1TXk2ZXorUWU2U2F1?=
 =?utf-8?B?NkxaMWl1djhkdno2aDJvNEdvTG5UblZ0UHV5Sy9aMmlqNEwzQ01mWWkwSVlj?=
 =?utf-8?B?U3hiT3cvR3NheitwTVlTMklMYWQzQlg4NmlDc3pJdHAzUzMvK1NEaW50dkto?=
 =?utf-8?B?WVhaZUlGbE5wdG8zdnZvNDJyQzRnR3FONktXUHY1eWF6WUlpdzBLRFM0ZEZG?=
 =?utf-8?B?S0FUZEt0RDVBQnl1TTVLeWprUDM0VzFhdTZOT2NMUGQ0S1pocUN0NkhjdFJj?=
 =?utf-8?B?TWxxbENscG5mRWdJVkNLTnZjc0o2eWFsRVk4Y1o4WnUrOW1aZ0EwSlRBaWZu?=
 =?utf-8?B?c1JiOFJLdytBVUc5UWRzd3E1VU1EYU9lMm9GcE9QWjVXYVZPVVBmbVdzZENy?=
 =?utf-8?B?bHRqNUIweVpvUW9vbWQ0MHhjMlNrcHJkcVlKR0gyOVlxdFFLVXpsdldxbUds?=
 =?utf-8?B?T1FyTkUzNGpaTGxRenFTOVE4TFpyTW5SdGx1eHFzcURVbGR6cGU5MVptQ2tP?=
 =?utf-8?B?bThaWDM1N3k1eHNvZWtvZWFDUFdFSDM5Zi9LU1lDcUFPQXRkTWdydGJFUWtv?=
 =?utf-8?B?bmxaNlhHcnJqM0VCd1lST0xvMVB6UGdmVEN5cjNKdklRYytEQ0JlWFlkckhr?=
 =?utf-8?B?ZHRsdzVEMUVydmRiTFkvVWRrd2NuaGJWT09aMzYwNVNvR25vb1ZHZ25ISU0z?=
 =?utf-8?B?UzZ1bVdDMmtkUDhjdkxGbmM3TXBLY1JpRVBaLzlUcjZKa0dycFJreHBYcUJu?=
 =?utf-8?B?bTZjZk9SaEJ6bTYvaWp4aWdxT1hEaUl2QnZGMWpiZXlma3FyWUx3eVRpTklW?=
 =?utf-8?B?bUEycnhQZzZGVm5XVFA0ek51VUpKRElSZWdjZXNiVWg0bmM0NnFBK1VDcmgr?=
 =?utf-8?B?UmptL3BTQlVEU0k3M1JIK09hbERnUGE4RmorV29XbFVzekMzTWlZU3Q3Yk5M?=
 =?utf-8?B?ZUNrWTUzcmdUZ1ZrOTQ4NXNpS2FER0dIdlpQYmVtY3l4MDFNcDlRc2ZqQkd6?=
 =?utf-8?B?RzJ5dXM2bU55SFRSaGZMUWdTVVFHMXRUMCtNZkRHN21YVW5mcjd4b2E1SExi?=
 =?utf-8?B?ckcrbXlieFVJdDUzTzNHb0RuYmFpU09DSTVNbkFBL0JGUCtuWGZwT21TY1li?=
 =?utf-8?B?SkpBR0JjazUySHc2K1hHMEE1bWZUS1lxeXNjV0lqcCtINXpnamlTQWRxRjZU?=
 =?utf-8?B?ZGltek82UjM1Y2xEUUlPUnREZVBJSkpqOTZ4dDZRL0szQjJuOVF1L0hZSmVG?=
 =?utf-8?B?dEc0NXI1QU9JV21GejVXY0xPcG1aMUtReHVidDgzUTlIK3hEK0Y5UDhrdm1m?=
 =?utf-8?B?UUhZdS9rdmF4SnNwekh5cHdVQmczVnZFZ212Mm0xZnBoSnZNcVBTckZBN1lI?=
 =?utf-8?B?ZnlqSFg2eS85SUdQcUdCTWgwYUZrcDB2ZFpoSVk2eDJSYTdpNGdjMVpYRzRl?=
 =?utf-8?B?cWtvUTdzTFVMaWxCamx1TWJKblVJZGxMcElLWVhLb3pNdGQ1blE4c3ZVZ2sx?=
 =?utf-8?B?UENkemV3ZVVDUW9vMG9rRHJHSEV1T1NxOXV6QjNKcTZERVlQSU16UlRTR1Zo?=
 =?utf-8?B?Ymw5OHdTMGg4cS9xbXRiaXVjUVRMelYwWnljU0dickFsM3l0d2tEVk5WY0d1?=
 =?utf-8?B?UFlpOElWUVZ3Mm9mbVJ1WmpRRVBmVWdJWVpIdlJ2cEQ3ZjI1aFZVOHVpVVBX?=
 =?utf-8?B?ZDh2bkJOcTllT0w4TGxjOEFIVjVRcjA0MWZKQ2ZmU0F1OVpkdUV3bzRBM3B0?=
 =?utf-8?B?QWtMeHhCZXd4ejZ5bjZmTWJ5L3RlTGYrYXlQNjU0RFZKci94ZDA5cEVOVGVs?=
 =?utf-8?B?TWg5U2dRVFRLTDVCaFQvOCt1Tm1yZ1ZCUnlNbldqaWZ2T1Q4U1pNVFR4QUpE?=
 =?utf-8?B?YmZKQWJuaUoxYUcyR3ovUkhGdmgyVWYrMFZiZFRvWkoxTlVpblczV0wwUllQ?=
 =?utf-8?B?TDdYMHg5K1BMTWZCdEVKTW1yVXlhcytWekJWVWN5Y09QTjZFUGNCbjlOVWln?=
 =?utf-8?B?dzM4ZWZjZjVYVDR1dHJSTFV2b0VJbktQeUxNKy95a3Jza3lJS2hhSzllWjlt?=
 =?utf-8?B?Y3orNUdHcmNoS1J1NExTak16R0RGamMxOGlDY2syUEJsNU9XZjFFUTZlQ3p0?=
 =?utf-8?B?TVI2b3p2RDZpa05NVUxzbDEvU3ZGNno5NnhnZ0hPUXZDckhSNUR0bTU3U2F3?=
 =?utf-8?B?T2N5MHNzUDBKTUJtWEZHeG1ZVGMzUUZVejkyTTdrQnZ4SE9jM2d6bmFQeU9N?=
 =?utf-8?B?MGwxNnVqUS81V1pUWjYxY2xWNEQ5blpHc1k4N3pNOXphYXVyOUVqVFI2YmJI?=
 =?utf-8?Q?JNTJXMHuSSjxXy6eKK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	0yppwwbT4nlhGQWYzy9kfGZ9HcPfSmBwLXKiUM2D32MJTObZ2ZDSD2eXliqrVDWzX7aV07LXU5SJTND/UI79FzyZZgG8xI7LmshWb62Q2gm8nTWJR0XOISgRNeBY2T5SHiNbWMj7wwNT4Bz5p6YIC1m9nC49Yf0AgDf2DCaJMJ8RG1ABxxJHypDaDJ4Dyr4YBAa3CxJDlQGR98yfQ/3XUAuksrR9Suktt9++ZPHiCIGo1NdJ0d5BV76GiMppre8W7Fx9X/8e9c63Erq/nOI3XHD/U/4zXQMt2OcBa1rvaqcXvSXnlzz/yD+PEF0CXI/qI4VwMSj7G39OkCBzIE7xNw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eac94da-971a-437b-7a0e-08df2b203627
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 00:55:45.6985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjoN6NJ4V7yB+eHqMw8do8bq9KAqx6MKbRtmWMObCvW0nzKW4GC3IXYbTZITDF4sBLfxYXio6AKHbiUcz3pgVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR20MB4789
X-MDID: 1792112148-8F9Yu0_l6gLS
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1792112148;8F9Yu0_l6gLS;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

T24gV2VkLCAxNCBPY3QgMjAyNiwgc2FzaGlrby1ib3RAa2VybmVsLm9yZyB3cm90ZToKClJlcGx5
IGlubGluZS4KCj4gW1NldmVyaXR5OiBNZWRpdW1dIElmIHNpdDk1MzF4X2ludHN5bmNfc3JjX2Rl
dGVjdCgpIGZhaWxzIHRvIHJlYWQKPiBmcm9tIHRoZSBkZXZpY2UsIHRoZSBjb2RlIGxvZ3MgYSB3
YXJuaW5nIGJ1dCBsZWF2ZXMKPiBzaXRkZXYtPmludHN5bmNfc3JjIGhvbGRpbmcgaXRzIHByZS1z
dXNwZW5kIHZhbHVlLiBVbmxpa2UgdGhlIG91dHB1dAo+IG11dGVzIHJpZ2h0IGJlbG93IHdoaWNo
IHNldCBhIHN0YXRlX3N0YWxlIGZsYWcsIGlzIHRoZXJlIGFueXRoaW5nCj4gdHJpZ2dlcmluZyBh
IHN1YnNlcXVlbnQgcmVhZCBpZiB0aGlzIGluaXRpYWwgcmVzdW1lIHJlYWQgZmFpbHM/Cgo+IFtT
ZXZlcml0eTogTWVkaXVtXSBUaGUgY29tbWVudCBpbiBzaXQ5NTMxeF9yZXN1bWUoKSBzdGF0ZXMg
dGhhdCAiYQo+IGNhY2hlIHRoYXQgY2Fubm90IGJlIHJlYWQgaXMgbGVmdCBmb3IgdGhlIGdldHRl
cidzIHJlYWQtdGhyb3VnaC4iCj4gSG93ZXZlciwgdGhpcyBnZXR0ZXIgZGlyZWN0bHkgcmV0dXJu
cyB0aGUgY2FjaGVkIGludHN5bmNfc3JjIHZhbHVlCj4gd2l0aG91dCBhdHRlbXB0aW5nIHRvIHJl
YWQgZnJvbSB0aGUgaGFyZHdhcmUgaWYgdGhlIGNhY2hlIGlzIHN0YWxlLgo+IEJlY2F1c2UgdGhl
IHJlc3VtZSBwYXRoIGRvZXMgbm90IGludmFsaWRhdGUgdGhlIGNhY2hlIG9uIGZhaWx1cmUsCj4g
Y291bGQgdGhpcyByZXN1bHQgaW4gcmVwb3J0aW5nIGFuIGluY29ycmVjdCwgb3V0LW9mLXN5bmMg
SU5UU1lOQwo+IHN0YXRlIHRvIHVzZXIgc3BhY2UgYW5kIGVycm9uZW91c2x5IGFjY2VwdGluZyBv
ciByZWplY3RpbmcKPiBjb25maWd1cmF0aW9uIHJlcXVlc3RzPwoKQWdyZWVkIG9uIGJvdGg6IG5v
dGhpbmcgdHJpZ2dlcmVkIHRoZSByZWFkIHRoZSBjb21tZW50IGRlc2NyaWJlZCwgYW5kCnRoZSBj
b21tZW50IG5hbWVkIGEgcmVhZC10aHJvdWdoIHRoZSBJTlRTWU5DIGdldHRlcnMgZGlkIG5vdCBo
YXZlLgoKdjE0IGFkZHMgaW50c3luY19zdGFsZSwgc2V0IHdoZW4gdGhlIHJlc3VtZSByZWFkLWJh
Y2sgb2YgdGhlIElOVFNZTkMKc291cmNlIGZhaWxzLiAgV2hpbGUgaXQgaXMgc2V0LCB0aGUgSU5U
U1lOQyBwaW4gZ2V0dGVycyBhbmQgc2V0dGVycwpyZS1yZWFkIHRoZSBzb3VyY2UgZnJvbSB0aGUg
ZGV2aWNlIGJlZm9yZSB0aGV5IHVzZSB0aGUgY2FjaGUgYW5kCnJlcG9ydCBhIGZhaWxlZCByZWFk
IHRocm91Z2ggZXh0YWNrLCBzbyB3aGF0IGlzIHJlcG9ydGVkLCBhbmQgd2hhdCBhCnNldCByZXF1
ZXN0IGlzIGNoZWNrZWQgYWdhaW5zdCwgY29tZSBmcm9tIHRoZSBkZXZpY2UgcmF0aGVyIHRoYW4g
ZnJvbQp0aGUgdmFsdWUgaGVsZCBiZWZvcmUgdGhlIHN1c3BlbmQuCg==
