Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA14A6CD7
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594712; cv=fail; b=HE9MDCuMZ/Bygv1QPxNtqrILYCi4erJRAp7ekJxvwSjhdi6ZfAOqLJepqB/KiZXubF47BnXcVqnQ95nMzIjI/x2WMneVFq0kCVm7KQ/3V3N2w0YlKoYN2HHd+S7pyJtn1/nGG5KUcGoSapOEKsmmvCRzLl328bZFeaFk+eN3398=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594712; c=relaxed/simple;
	bh=IRlZRScXweY5xPAcB5b1QhKxRE4PiSbouC+42N4Y9Ho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KBMSL05dwlOL18h4AJO9+Mmm+XcJBW3VoEAri2xQ7GqdSQIkClBZrwihhMNbI5HVmAYBhpfadZHWlynzTrT+DgxF6pZ8b0VzF73k1fkmPIQtWAD1HQu3+qHwx4FQ2n2bLBnei+Cyeu/JnNRMWwGYEla0uPb1bxOrGBKWMivb9SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=aGqgMjY1; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="aGqgMjY1"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBAw0b2562963;
	Mon, 28 Sep 2026 04:24:54 -0700
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022113.outbound.protection.outlook.com [40.107.200.113])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gxxt7u0wf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 04:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihXTR3s9Arh+eE/BT7vW/46qB3nSzVbhDI7KQE20PEbj2R6Jy36uK+0MmuEYbIMDvWe9omn2I4XrjLOP6tMg4BvUUoXKmD4QvSpZUNejeKkOgVmIjqIMvBIUm17/RSfuJYWwi8rsjabq6hetk6bDzwskRw+D/jutPloIHrFMkoX+kjUNifTgXgmr8PYzVXBK0qTYGVSOLSfPsaCwCm5SkkXJFZFUmFSXSJhdll9ywKm4fa7WVgsf7nzUIdco4GuKemwn0ChGh9Pjl67EKSuLqDod7z9Jv2qCvrazgzJlhoTAHVv47/Gbq846o3tIWnD0vy6t77A7zlK8JIj4nkEyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRlZRScXweY5xPAcB5b1QhKxRE4PiSbouC+42N4Y9Ho=;
 b=DvT17X8qtjsF6FTYgDnt5mEIiD0sM+0dieBrOqq0JPyKQIm1tFGh9CrsfFbYYXDyz5XBLNJxOuH7heoA/v/v1vDIt0eQuhMCWArs0RQv089ddAwgv12p0fXU49P6585W8YRDVE3ncenGfhaArzm4lmW2yHW2ejiMdMauv0Q/4pluMbkZbqVpqESZNitY5CtmY3BGpVJ5OZQ7/LmkgHlTuObUAx15mGShXHQE3zJGN3zUGebFaq3onKflrX9eEWVlaTYih46UIoLJN5smw/Gnzj5VGxRgq8C3aluz4XI3ypES+3Py0tIIU8aKk2R4UaVsknVXobs4fGTuDX1+jiJIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRlZRScXweY5xPAcB5b1QhKxRE4PiSbouC+42N4Y9Ho=;
 b=aGqgMjY1kX6M0jfdJ8VZ0drcYYjRpPqeepXYC587ooNoR3XEmYvAMx9u+9s3QuztnN+xOHgdIuUP7EjP7Cfhm0U0rHLQBmC08cjeVYqZPvvhI0j3uak1o6qaUkgcH0iv56H5OTgpGomc1XXoXscyV4PZ2ypmJoKAI6iR/gNIWqs=
Received: from DS4PPF7D4D8EFA4.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::aa8) by BN9PR18MB4154.namprd18.prod.outlook.com
 (2603:10b6:408:133::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 11:24:50 +0000
Received: from DS4PPF7D4D8EFA4.namprd18.prod.outlook.com
 ([fe80::1aa4:25ac:43fc:2a79]) by DS4PPF7D4D8EFA4.namprd18.prod.outlook.com
 ([fe80::1aa4:25ac:43fc:2a79%7]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 11:24:50 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Christoph Hellwig <hch@infradead.org>, Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        "horms@kernel.org" <horms@kernel.org>,
        Ratheesh
 Kannoth <rkannoth@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Bharat Bhushan
	<bbhushan2@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: RE:  Re: [PATCH net-next] octeontx2: remove unneeded symbol exports
Thread-Topic: Re: [PATCH net-next] octeontx2: remove unneeded symbol exports
Thread-Index: AQHdTzv5gMNxoBcc30KYQm9B3cow3A==
Date: Mon, 28 Sep 2026 11:24:49 +0000
Message-ID:
 <DS4PPF7D4D8EFA488F71459CCD2E67B3116C68D2@DS4PPF7D4D8EFA4.namprd18.prod.outlook.com>
References: <20260925201042.1174488-1-kuba@kernel.org>
 <arn4Efet4feI-WFl@infradead.org>
In-Reply-To: <arn4Efet4feI-WFl@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=marvell.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF7D4D8EFA4:EE_|BN9PR18MB4154:EE_
x-ms-office365-filtering-correlation-id: 574b9b54-737c-40bc-bde6-08df1d531c06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|4143699003|6133799003|4133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 uFyaz/Nbaz6Fms2bj3n/Ur4VHONqreUpkym+bRUFp+6RrfGFMJT4CH+YNoBUolcf49B72fTre4l93Ds99GUyzi/EMHsla0aQzaiIjl9S0nn2gUky5JAShu8Xl9WfynxWGLz1PgAO/887yRvSovQ4FC2esUvIs1kiNZZbUbPJn9Ok4UlCcJ5DnzWLl0rSM74aTblwA9xFuDVjDilBKOGcHdKAMFMKj0MyvVM32Y+Ftm3I9L1WkR1hocPdFF1S3IBl1m9T+J9UZPBCvazsqsbt+n0ugi+5LCWJ+eqzo/e+JsMpyEEX7lazf+r3DdR4FnW6ZdUlIVXvGHC4e8GZuxpwyvrwTJcw7OtwwB5qeKZEQwqft/OV54T4AflZN8kMMt7jhEzP1whIa5/YUZfRfcmw4LG5KNdMDi6UrEZ6OJysArCh6aqFvYDTp6/96AmUyKXmNhqBeje/pmVh2GzvrEfydSKVAh7IougbD/TQ4oFybDTH6CKdeOQoFnInCbSVtmwNMqRJCpFkUT5ga76cDd9sPfXYQgFza0OJ3X+eFEGJ2P97hrnQpv25ECfbKXHg6j+pHCyQf7rskNEMe4KuT6fP2gsjPOGz129ytZRxZtHoOsuXN4LQuQ6g+atg1byd32SJGzzs3vDBfxWctUSqN0wx0y/oUjh5doapuZPDCBUO2fc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF7D4D8EFA4.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(6133799003)(4133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dS80SDUrbUU1MXg4NWZyblUza2QzZFRML1RKRitBZ2psNlFJdEZORFovMUxB?=
 =?utf-8?B?VG5DeWE3bG84MnJoVzJ3bHp3ZmJCRFpoeHI4NUovcnRHRlJxZ3Q0QmsxMmRx?=
 =?utf-8?B?QXMvczg5WTUrUTZLTXg4VzJaNnhneU1QNlpYdUJHbHhZN0Y1OUFzM1NhVTdn?=
 =?utf-8?B?ZEJkY0VPS29wTkliRmhqZmg2Q2ZnbjNIVFFJeFBPendpVU9yZitqZEZwblda?=
 =?utf-8?B?clJldHk5RjBwMDU4ejVORjIzMVFzVG9aUVNqbkd2V3dDM1Q5K2NmSE1nNE5k?=
 =?utf-8?B?ZHJ4dStLclV5bVk1aWtrY2YvQk5DMlpjcVo1NVhPRERkdU1RbDhmMlhUb2xx?=
 =?utf-8?B?VERCOW05M1UxNTMxNlJwRTBiMGNKNVNPNjhRV25NK0JBRTd2ckZvZCtkcDlq?=
 =?utf-8?B?a0c0MnRRKzVseHZrd0JhaENuSmlrTWowem5VbXNJdy85cEhhRDZzb0E3bU03?=
 =?utf-8?B?WDJSUTJjb1duMUpJMnpUa2hkZUxRQWplbkhTRW0rd2s5VVRqMGg4OVFlOVNk?=
 =?utf-8?B?b2JaVXROR3lGY3JKdFhVTVdiOG85ZUFUU2VSeVp0a01SM2IxdEovTFRzcGsy?=
 =?utf-8?B?cmNXNmxpY09uOUNhd1BNYWp6b3o5ZW1ZRVVybHN1VzA1V1lmYi90VmRhdFBa?=
 =?utf-8?B?clpDQXZtcDhPMm9PN2ZuSEtIVGtpbXBxZ29LTG96MWpOUTlsNUZWVmx6SW1G?=
 =?utf-8?B?b09yTDhDMkE2RzlRZmF1dGhXbklvUTRUdG0xQzBoaDdtMEFFV3V0MzF4Tmgr?=
 =?utf-8?B?T0tCc3FyUG1DWFdWRGsvS2ZwME9pbGprd0M0WVJmOUJMT2N0bXRzdVhjVG5Q?=
 =?utf-8?B?VVBkcVpnaUFVWXB4SkNNZFQ1SGVFekxMWS9UK1VCRWNFZDVFRWd2ZE5wbkc4?=
 =?utf-8?B?NjIxQ3cvM1RweVdCQm1TaFd2eEJpVnU1MjE3eUh5OURwK2hHekxPcC9RemZY?=
 =?utf-8?B?RUQzbzV6dTJDakYwRVJHSm9CY3c3cm1KUC95MVZXWEZMZ2VOU0QycjZaYlZr?=
 =?utf-8?B?dUMxdE0wSytybmZYZlRnNWVadWV0RVJ4NHZDZHhJaEdvamlWSnVDbC81dVkv?=
 =?utf-8?B?YWVIOHVkODVoME95RVJWU2FxdlJ3QmlSYlVwVkI4dUdYaVo5R2ZZYjNhMldF?=
 =?utf-8?B?VnpnMTFzZGh0bGJ5Nmh5MUF0UVlva0hQeVRIdGhWMTRjT2k4Y25ENTJkSGwr?=
 =?utf-8?B?akkvREZhMWlEUFZ4Ykt4Q0dJMFo2WnQyMVhLbmdhRWpzbHczcTMxR0cwSXF4?=
 =?utf-8?B?OTNnL0NLNHJZRXlHRW9TREgvaWFJZDBES2xhZlRUYVJNSDEyaVA2eWgxZllt?=
 =?utf-8?B?dUFRYkFWQlFVdStrZEMyODVtSnI0M0syZFlVL2tEQTMxT245NjMwNzBvZTV4?=
 =?utf-8?B?OTc5dnFEWTFkQXgxeE9vYWJHclpWa2VXOE5vZDR0c1RsbElLSWU5TzcvS3Aw?=
 =?utf-8?B?c250ZE9FWGhINDd5cXRrWUJjM2RObTFYYjJ4UHd4K1ozMkl0bWpmRXVxQ282?=
 =?utf-8?B?dHN3K3Z2RGhZblJIYnYvWG9HVEJhSXVmQ2JmSFZxTUhJSC9DejlQczNSa09a?=
 =?utf-8?B?b1lLcndsMHRubmJlcVpSSkhEa3pmRnJrcjBNWnlRRU1YYXkzcDRHOEtTbFlw?=
 =?utf-8?B?Q3VlQ2VtWC9xeTBKbGZMaFcvNW5GQUtvNVJ6Q3cyaUw2cnFwS21YdEJOQnNX?=
 =?utf-8?B?YVZ5WFhTWWxRMnNBM3FYaytYZGtBcExUVm8yRlZyQkcrdFB4OVA0U2lUa0Mv?=
 =?utf-8?B?RGZmbFhYOWJCeTVzNXllMjE3R1lManZSTFBvNXZJc3c4ckl1eGhXc1hiZVI3?=
 =?utf-8?B?K3pNZWYyOWJXQzlYQ2tYai9tSzdud3Q5M3d0aStKRG96eE1GMExiV0RneVht?=
 =?utf-8?B?R0hUV3BQZXNxUkN6Qi8wOW4vOFZZOS9tRmc0SVorakJCQkdNa0JFelFmZDBj?=
 =?utf-8?B?MUVBR3pjc0o5MWRjNWhjQjl6RkN6dkR4Zml1Z2Rzem5PZ0t2aDYyMG9vdjFx?=
 =?utf-8?B?cEhxQUJsVG9sc2thRDg5TDFQaGd3cFRXT09KS2ROUW5nLzJoUDQvcXB3UkpB?=
 =?utf-8?B?MU5EMWxYdi9xZDFrazZFR3RoSnowVHJOTHBGMUJSNVoxS3hpV3dEWjF2OURQ?=
 =?utf-8?B?S2RjM1EycW5qYjlTVmY3VDdYN201YjdOUUN1T2hvaUQ4VE9DMC9kNTlMekxy?=
 =?utf-8?B?Tm5nRXF6WUg1ZlVnN0ZKQlU1NjhWM3hrcExZbTVuc01KVTR2WkJ6ZnpJQ3lN?=
 =?utf-8?B?Y21HSEMzcXMxc2hCVWtFUVJzZ295OC9OeTgvRU1lVm1vTE1qL3puYU1qNExM?=
 =?utf-8?Q?TqrbQuXN1EbVeGpFYS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gHApxCdEyoqEM0dkkjhAxbmGE7MkLqM9QktipvYvccJYcbbVmV+jMdLQ/1hwcBfW+Au6r1kVtpMWBPo6AL2jgIAqLrhzK4wZL57m0qrcEb9Fbf1pEWlxRFylsa+WJckabXn3T2aw3ZqBr07jz3aKRj0ciz8UW1L7P83ZvL0jU8tilH/mur4krXfzycGt+QXvYUQ/8noYYbvsEdStcSEuIxwcDPpWcGW+Y3KSplaEbhPPRNEtTsQNXG4A13ALXD582pbbpJT1PGcsM33AVG3rMrEuRrYb6GViKgkOcGX6rAgq2xD2usgxK/hdlRyS56epnh/VXZmBu4YmrBg5sfQrfg==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF7D4D8EFA4.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574b9b54-737c-40bc-bde6-08df1d531c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 11:24:49.9562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /cvmFTihhjzuDe6/w5x0GUOHLA+15egtqLa2oL5pcsEvuh3XkJsKnZnKA7SgnrkTC18GTwXbSlGFSeF7vV1kOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NSBTYWx0ZWRfX9RhBhFzezF9x
 Nj3j0QaBrF8uOeY8aUwsRtIUhdrLF6bN6FLVVp/roWx92z2K/d/zgk5oTW8D0gOqtpavxzAEIaT
 LgownTtgnuCXa9a1VO+DDIPyHNxTuh3H/lkiTxm48Rw3uvpMVJnRpRBwH8eglRy5CeKqlmKIK7B
 h8zjRRwPd71RffQHIX5BDD2IG62833Jn4yht22npABUMGiasGYLz/vK7hx8XapRe++e2gPKH9K7
 gpOKD9cpImSl68BQm/QiPLN2zrhcKtDfFuOLmxwwBTBYZnQlHn0SIkH1/Yd5Jl/9VxxctsNnVw/
 XgYTQNNuoForzjgQBmNyfKQDES4DWCzhZ5SPmWJspjPOjo/+snBpavYjmCCkwZHb21wNZEU85KU
 DI5CyteSC+Y9B9BIKJJRpm3CF4IDXDDuW5cdyH153cC4+WFw6Vp0aHichPx0yYDs3v0AokXWwq5
 0mjx75WNDIMY7EVbpbA==
X-Proofpoint-GUID: 8srJNUxJUMleEtlGVX8Wq9PIGI3fsVFO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NSBTYWx0ZWRfX1WCaAroqDRZ8
 qXIHjhXYUHGz7Cf2GGuZ73BFLRbR6SfqTlaEH2hGpGzetE3uFISjE48neUsnHBHMxAzuYdUzgdx
 ZzOyWfLJ0F2tBiQHMQa8KN6JtQ7iuw4=
X-Authority-Analysis: v=2.4 cv=YaEodARf c=1 sm=1 tr=0 ts=6aba4e85 cx=c_pps
 a=ypcO1grc5O9jTiuCy4hLbQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=qit2iCtTFQkLgVSMPQTB:22 a=JfrnYn6hAAAA:8
 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=M5GUcnROAAAA:8 a=RpNjiQI2AAAA:8 a=Y3MThTQWeS2AKb7hA7QA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 8srJNUxJUMleEtlGVX8Wq9PIGI3fsVFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENocmlzdG9waCBIZWxsd2ln
IDxoY2hAaW5mcmFkZWFkLm9yZz4NCj5TZW50OiBNb25kYXksIFNlcHRlbWJlciAyOCwgMjAyNiAx
MDo0NiBBTQ0KPlRvOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPg0KPkNjOiBkYXZl
bUBkYXZlbWxvZnQubmV0OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBlZHVtYXpldEBnb29nbGUu
Y29tOw0KPnBhYmVuaUByZWRoYXQuY29tOyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGhvcm1zQGtl
cm5lbC5vcmc7DQo+aGNoQGluZnJhZGVhZC5vcmc7IFN1bmlsIEtvdnZ1cmkgR291dGhhbSA8c2dv
dXRoYW1AbWFydmVsbC5jb20+OyBSYXRoZWVzaA0KPkthbm5vdGggPHJrYW5ub3RoQG1hcnZlbGwu
Y29tPjsgR2VldGhhc293amFueWEgQWt1bGENCj48Z2FrdWxhQG1hcnZlbGwuY29tPjsgU3ViYmFy
YXlhIFN1bmRlZXAgQmhhdHRhIDxzYmhhdHRhQG1hcnZlbGwuY29tPjsNCj5CaGFyYXQgQmh1c2hh
biA8YmJodXNoYW4yQG1hcnZlbGwuY29tPjsgTGludSBDaGVyaWFuIDxsY2hlcmlhbkBtYXJ2ZWxs
LmNvbT4NCj5TdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggbmV0LW5leHRdIG9jdGVvbnR4
MjogcmVtb3ZlIHVubmVlZGVkIHN5bWJvbA0KPmV4cG9ydHMNCj4NCj5PbiBGcmksIFNlcCAyNSwg
MjAyNiBhdCAwMTrigIoxMDrigIo0MlBNIC0wNzAwLCBKYWt1YiBLaWNpbnNraSB3cm90ZTogPiBv
Y3Rlb250eDIgaGFzIGENCj5idW5jaCBvZiBzeW1ib2xzIG5vdCB1c2VkIG91dHNpZGUgdGhlIG1v
ZHVsZSB3aGljaCA+IGRlZmluZXMgdGhlbS4gV29yc2UsIHN0aWxsDQo+dGhlIG1hY3JvIHdoaWNo
IGRlZmluZXMgb3R4Ml9tYm94X3VwX2hhbmRsZXJfKiA+IGFkZHMgZXhwb3J0cyBmb3IgYWxsDQo+
WmpRY21RUllGcGZwdEJhbm5lclN0YXJ0IFByaW9yaXRpemUgc2VjdXJpdHkgZm9yIGV4dGVybmFs
IGVtYWlsczoNCj5Db25maXJtIHNlbmRlciBhbmQgY29udGVudCBzYWZldHkgYmVmb3JlIGNsaWNr
aW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMNCj48aHR0cHM6Ly91cy1waGlzaGFsYXJt
LQ0KPmV3dC5wcm9vZnBvaW50LmNvbS9FV1QvdjEvQ1JWbVhrcVchdEMzVHZiU1VMTjhRWEk4MmMz
SjV3b1BrOFU5R1NnWA0KPl9JSW1kT3NqdVMtd0xUUVZrV0hSSm9tTFIwR0VPdExUY0FYQWlkUzNy
Tk5qTiQ+DQo+UmVwb3J0IFN1c3BpY2lvdXMNCj4NCj5aalFjbVFSWUZwZnB0QmFubmVyRW5kDQo+
T24gRnJpLCBTZXAgMjUsIDIwMjYgYXQgMDE6MTA6NDJQTSAtMDcwMCwgSmFrdWIgS2ljaW5za2kg
d3JvdGU6DQo+PiBvY3Rlb250eDIgaGFzIGEgYnVuY2ggb2Ygc3ltYm9scyBub3QgdXNlZCBvdXRz
aWRlIHRoZSBtb2R1bGUgd2hpY2gNCj4+IGRlZmluZXMgdGhlbS4gV29yc2UsIHN0aWxsIHRoZSBt
YWNybyB3aGljaCBkZWZpbmVzDQo+PiBvdHgyX21ib3hfdXBfaGFuZGxlcl8qIGFkZHMgZXhwb3J0
cyBmb3IgYWxsIHRoZSBmdW5jdGlvbnMuIFJlbW92ZSBhbGwNCj4+IHRoZSBleHBsaWNpdCBleHBv
cnRzIGFuZCB0aGUgYXV0by1leHBvcnQgZnJvbSB0aGF0IG1hY3JvLg0KPj4NCj4+IG90eDJfbWJv
eF91cF9oYW5kbGVyX2NneF9saW5rX2V2ZW50IHdhcyBleHBvcnRlZCBieSB0aGUgbWFjcm8gYW5k
IGlzDQo+PiBnZW51aWVubHkgY2FsbGVkIGZyb20gdGhlIFZGIGRyaXZlciwgc28gYWRkIGFuIGV4
cG9ydC4NCj4NCj5Mb29rcyBnb29kOg0KPg0KPlJldmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdp
ZyA8aGNoQGxzdC5kZT4NCg0KVGhhbmtzIGZvciB0aGUgcGF0Y2guDQpXZSB3aWxsIHZlcmlmeSB0
aGlzIG9uIG91ciBzaWRlIGFuZCByZXNwb25kIGJ5IHRvbW9ycm93Lg0KDQpSZWdhcmRzLA0KU3Vu
aWwuDQo=
