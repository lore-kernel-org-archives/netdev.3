Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012071.outbound.protection.outlook.com [40.93.195.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC550B409;
	Thu, 15 Oct 2026 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063599; cv=fail; b=dA/K6k59oQhgk5dqlB4XNDnEY9sGLA6WJ/kzGVxr55Fn/3NbLPLGxffMj5w7oAFoc1KV3zqAXEjtbg2Zjk+AJ/6CFZYZ4biDROsEoM/GB1vadwvMMlqzOh+a2Dzfy2aTTGndib2TYR0vdQb+2hNUfmcUyd0hZ4zXt5Si9KItQKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063599; c=relaxed/simple;
	bh=Kaz9K5LWluj29T2axZuA8gbp4F9YCrbim4989ZRGPYE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dkQqud+nFsdX/8mVT4NG4M2eXKzywkV34sWmvElk1OtKNCiVIXVwlv/NlmbyCqAv2YrLNgNqt/FsIhBB+YYPuXbn6Ip/kF8gWuK/hmBYIJe1Nd8NlA6bKT5WKCj6j+WCDazoujWOd943J6Zu9UYpD9Rvm3mzfYdzAwhV4y0xaJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sHFcGOZb; arc=fail smtp.client-ip=40.93.195.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sHFcGOZb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tPb3AjHm6t41BoPXTS7HBvpJ4NF4b/cphTAV43+uiXwqXEx4BnTt9xeLfBPexxQs5N301y8wi36XKukwvhxf7dKQHiVfJnKndPqI9ZPxR9tAG/PNYbEErIJnTED/VWNSLaPIoagwGaChOYL/AJjnb0EXKsyC79zGa+wtySUtflo1rPR/oj1bYGhnAUIJmvjc2Uuc+AHI8L2HPX3RyLvCrIrae52nSAdGS+3tNEbeL0MfBOtQK8cY+FxVpBuHbzHM1zjC7TPv5G9uHB5yiJgnm2b6a0ZRwuPErX1sEMyerG6BquC+puRssyHp4EK6yk8p94zCLqDpQuGjr653GChW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kaz9K5LWluj29T2axZuA8gbp4F9YCrbim4989ZRGPYE=;
 b=vgNZGjB9IsDiBLOYUHvv68E4zVegxqfeVb4xsQBAlfYJbpLnJmz/HYRIz4l6zH2RLrh0FRgAeriCmvcORtJQq8DZIzL06l+cYFaaXC61Vsfnomo8G3TBlemQurMqeh33jg6pvJdN8K8mjqMHdirwP5NZX56dwJi5Eod7h1QD/HTk7tod2ps4sKtIWmbVDRFB+mJJos6ZxiscOWxZCkZl2qClFGa4Fcg5AMheLjzH28eQsroYuxYzJJuWd4ZE5O+lGphOqDtFTF9JkRdAuFibqWRFgwPs4wi5BkmPvK4zc4SMA/USM0WZdHFXUcKSX/V+v1pbPM2xCyt+qiVv+P85Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kaz9K5LWluj29T2axZuA8gbp4F9YCrbim4989ZRGPYE=;
 b=sHFcGOZbaYfsig2IaYiO00qdyofoKEukMTpvZdfXcwDUyHzIyaDNT1lg1UihXPec8O7ZN1y4dGXijHZlyaqi7hBtAGk9j07Z+8I8VO37snAnKMp0JV8awoSYwjwbvpvNq5oXjxe9wOjN+SmqbTbIzsKvqwH2G02mY68pzI2bqy4W2mcWrlyKXRFh2sZLvidFpV7agEaP3Rmz/H3ezKQVfeUv9nj592+7il4RBIm+EPbw+ycDFNC2aj+x6ZQyzFKguTneF982lMOcHAGeslnjhEB0IpqvkvVLIg9AVVCqsczCUdFsbNtl2TDCcO6sQKk7CXi7BG4/Sqr7s6g4kb/VSA==
Received: from DS6PR11MB523643.namprd11.prod.outlook.com (2603:10b6:8:468::12)
 by DS0PR11MB6352.namprd11.prod.outlook.com (2603:10b6:8:cb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Thu, 15 Oct 2026 11:26:29 +0000
Received: from DS6PR11MB523643.namprd11.prod.outlook.com
 ([fe80::1cc0:e019:a70b:f954]) by DS6PR11MB523643.namprd11.prod.outlook.com
 ([fe80::1cc0:e019:a70b:f954%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 11:26:29 +0000
From: <Manikandan.M@microchip.com>
To: <michael@walle.cc>, <pratyush@kernel.org>, <mwalle@kernel.org>,
	<takahiro.kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <srini@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<linux@armlinux.org.uk>, <richardcochran@gmail.com>, <linusw@kernel.org>,
	<arnd@arndb.de>, <aaro.koskinen@iki.fi>, <gregkh@linuxfoundation.org>,
	<mathieu.dubois-briand@bootlin.com>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 3/8] nvmem: core: take a reference on dev.of_node in
 nvmem_register()
Thread-Topic: [PATCH v8 3/8] nvmem: core: take a reference on dev.of_node in
 nvmem_register()
Thread-Index: AQHdW6cSHE+HOC+e2kKLMwSXuzZQlLb+U0sAgAAlcAA=
Date: Thu, 15 Oct 2026 11:26:29 +0000
Message-ID: <29e64d3d-a002-496d-a4b6-b696f3f3013d@microchip.com>
References: <cover.1790847519.git.manikandan.m@microchip.com>
 <2e21cc4b871da8764e3a12d0ebdcf7cb799149ab.1790847519.git.manikandan.m@microchip.com>
 <DM5AO9LBE1OI.19L3SG4BQTNB0@walle.cc>
In-Reply-To: <DM5AO9LBE1OI.19L3SG4BQTNB0@walle.cc>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS6PR11MB523643:EE_|DS0PR11MB6352:EE_
x-ms-office365-filtering-correlation-id: 72426daa-101d-4bd6-aa17-08df2aaf2817
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|921020|38070700021|11063799006|56012099006|4143699003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info:
 u4dLfjGgA+qvOyxFKF38q5YXRR2hN6fv+jhNaQv8SxX5QhgeFqsjpJCQyelAmaNlF6f7DR72hzeYjTWXgSKtS8yyNc6/bsdYqalcv5nLcDcM4TTCPQApiCbuB4ikBeTVYAQJN5FVchdSIGUeZ7UzMv9T2RuigbuLvO9Cw5+CPNAHuIQTnTl2LT3vzT0D/yoN5Xi89ss79GyaeqfLOvmb2rtsGgGz8995+UTiQENaxZMY9+ZWyRoCzAeoaJ+H5mgrU1yFGBSY2CAStomA4fbVuQrc2gU9jVhfrxDPvL/iDeD8aPVaV0W/zBYgPU9jSOFmnHK9i92E4RxcGgzDFujIxznJbf+27BwJ8IESWvMgmEFSmFGatckTTa9w2jCmNkE+F2/tA8wuIJgppWrfZEPpHr3LptG8HqkdUUUK+5in5za9MgGtQDvhFGDhjHtLOkZZEZpKx6IQrnHJA58hmNHkpoZA05hPRgdT4ibIwvE5T2weLNeHQHt31Ow7YeQvlo4jnG5yZokTRlAZuJFn6ZPrGX5xk//WAcEvmc1XidX6xPlS99ompoOEGEwkz8iaoNur4f8RPSltvNIeKxynQMbDncqvPux0Ts91n//y8qyUot9U+LayQqHhg5KKz+X78PSrGoNfiellV3xl/Caj+0bQlWb6EORZ0EgF0aaAOamhihb5OrQB9Wk7wgd+Q3NXz2vqmZkfSrKN3j65bkDVLhiJzkrL+wD/8Ox17XsJ0Q8fMHkdymZlR389znmIgUT0jUf1
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS6PR11MB523643.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(921020)(38070700021)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1JhRHRXQ09qK25sQkpCcXJEYkhINjRKN2gxTFdVT1NoTXRob0t2QVIrUlVB?=
 =?utf-8?B?TEprbGhmN2Q0TXRIMVNIN1NLR0pvcy9qK2kwWW9KcUdOUGh5T0UvQ3JXZGF1?=
 =?utf-8?B?MjhwbmcvZ1BGOXdNVFREY0F6M2dubkU1c25PQ2pZV0JOQ2ZuVmpaZTZJRlV5?=
 =?utf-8?B?Y25hMFhyVTJUZVorcVpXcFptOWNySzZkbnlPb1F1bnZmeS93dElJK3BCMHNK?=
 =?utf-8?B?QVVuTTFtc0JZSGgxaEw5a042c3JvV3E3RElYRG1wWjBwTnA4cERPU1p3Zjd3?=
 =?utf-8?B?Y1dPRUdtL2tBNWxXcUtrMXRqQnREaksrQ2lzQTg1UzlDUlNqeWZuL25mR2FF?=
 =?utf-8?B?TllGV1pXWVNRTWlvQnYzVXlNRnkzK0krbllFL1J1OXo3R1ZNbGRlcy9pVzBW?=
 =?utf-8?B?Vk5OWHZ3YkRXMGxNMjEvWWQxTERpQVpzaVFTRFA2cTEwTFlDb1NTTzNGT2FP?=
 =?utf-8?B?eHFVcFVKODV0WGozZjdUYVZWMVdITDRnOUxBbC91ZzFUT0g5SnNKM25KcXVV?=
 =?utf-8?B?YVBXUFdyS2dmNk5nRnEydXZlTG11byt3WjZrSHk4S2R3eTE4S3BLRFpYT09G?=
 =?utf-8?B?KzY2b3F2d0lDUndyc1Boc1JQdGVZKy95Uzc1M0g1ZmM3aDU3WHAwMVI3SmRC?=
 =?utf-8?B?UGEwWnhzKy9uYm80UTdYeTI0TjlyZDNIYXN2RklTRmxRUHFYbFJVTGVRR0wv?=
 =?utf-8?B?SGk3TXRDRjlqQWZHb3hOanRoSGpHSXhkekJSWnoxTTNBZG1VN0k0VWhyb3l1?=
 =?utf-8?B?WCs5L2hncGtwRmpGT25LNnE4SjFERDF3bHcwL01ZaWU3SSs2MEZJRDVHNGd1?=
 =?utf-8?B?RmhsNUVZOEFnM3lBbytubDZEU0hGa09vK2ZlQlFieGs0Nkh2bDJNZFRJNkdu?=
 =?utf-8?B?MTRmblVlZFJYMTQ2VzNJWmJGZDVWbEI1MGJWVDJZakZ1QUxuRXlYUmRMQjl1?=
 =?utf-8?B?RllWK0d2bXN5WUY2aGVKbGIrN0loWWxZUFFxWlFCVktPSkFnUjZwaHpuRkNF?=
 =?utf-8?B?eWNscHEzdWVwMGlaLy9oekVrMmtUOUhrek05amRrUEdHM2pycGw1UjJQaDFC?=
 =?utf-8?B?WDlKVHNxeUxvKzFPSGRsMmd6L1Z6WktscENBRnNIQUlCeENMOEFkVURldU5r?=
 =?utf-8?B?djMxRzViRS9QMkJuYmgxaVRQM3VJcjZoS25IdURlTTAxVEM5b3FOVm8xMEN4?=
 =?utf-8?B?aXhtRlhyZm9LVDJ3TE0rdlltQ1N2VHMvSkJzQlV5SktmRjZtQWptMU5IS1dO?=
 =?utf-8?B?Z1lEeVpvZVBJbUdqcXhOR2FqV1MzRzc3cnhaSFJPODB6a2R4NlFZTExpVGIv?=
 =?utf-8?B?S1NyZGkyVVlRUXZ2YVh3ZEZQcFFyRTRHSU9vdmxWamZ2WUNDL29SVzF6L0Iv?=
 =?utf-8?B?MUNkTmZjR3cyQlhua0NFam5NN25EOGZ0RkVzVkFuTHhSSkcvRkQ4enpReFlS?=
 =?utf-8?B?WUFocTRyUWhsS1VnTWFTR1FNTkVXMGlVR0swdnQvcGJnV00rSzRkUk9RVDhJ?=
 =?utf-8?B?cG1uL2V3aHZWZU1iR3lqV2dkUHhMYThNeG1UajMwdGd1K1FQVDVNa2lrY3Fa?=
 =?utf-8?B?amRwS3I1WDBxSSt5Y3V6eG1hNzZwMkNZc3NuQ0wxNkhIaWMyWTRTQXZaQTlk?=
 =?utf-8?B?dnlFK2FRYkRGRkhjbGlKaTlmbkQrNzc3UkNlUkZUMVFBdzlpRVdWTEdqTTlG?=
 =?utf-8?B?SVlTcEFpZ01ZdnBKR0dkb3lMeDVmTG9rNW9vRXlQd0xWcHFqU0F4UlBteVBi?=
 =?utf-8?B?VEl0L0hXc3FmOHE0LzR6S1FMUjlJSFk5U3Q1Nmg5VnNySlo2eWpZZDB0R1do?=
 =?utf-8?B?Y0luaGpvMmVXOWVHYWh1UVhmeWQ2WXc0Tjg2SEVud0NjYUowY09OdzM2dy9S?=
 =?utf-8?B?ekphNHA2eDJ3YjgwTUxIYktoTUZKNGI3Z3pXMmxXUEdUQ0xmczJrbndzUlVn?=
 =?utf-8?B?dDdPQWdYYUdVcEVSRktvQ2lDM1BodlRGUUlBUURhNk9uTk1YZjNPN2dlY1Qw?=
 =?utf-8?B?d05qV25tTUNNWGtnSmZ1YUl3WTV2ZGxGYXpndE1YTmJvM3dvUHVWaXVpUFFC?=
 =?utf-8?B?SER0dnkrd1licytSUnZ3blRYVElxOTAyZnhlYW1QY1Z0ZDJ3N1F1bm9ZY0Nw?=
 =?utf-8?B?NlFpYXdDUDdZcDluakNRL0RwZzdUSmQ1VytLcThKc3MzWTYyd2ZlKzZ5WjZI?=
 =?utf-8?B?MW5HbnJ3b05mUUc2Vjd4RnZhekEwbU9TZk1YaDFMMHhHMHFidEQwbElXWkRX?=
 =?utf-8?B?bldFNkJyN2EyeGwzTGtCZyttQzRmM0lKVk5uTFVKM0xQMWY1VnNFbEpyUE1o?=
 =?utf-8?B?VG9MK244eVFFd0lrZEFGbStEWWxadHcwaU9sL0FGMEs5SlA4Y2NkZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26CFEE668BE2FC40B8C569F689B87FB0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS6PR11MB523643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72426daa-101d-4bd6-aa17-08df2aaf2817
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 11:26:29.0119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/5lC1/jxR7FDzpxCMzj79b+BJ3bYrz2SrJtnO5NLeJFerFAMSYCsrDZtLzpyZAuyHBTDlKZgR2D3uKArWqkjoseQJTMcKep+Vfv0Fm0Gd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6352

SGkgTWljaGFlbCwNCg0KT24gMTAvMTUvMjYgMjo0MiBQTSwgTWljaGFlbCBXYWxsZSB3cm90ZToN
Cj4gT24gV2VkIE9jdCAxNCwgMjAyNiBhdCA4OjQwIEFNIENFU1QsIE1hbmlrYW5kYW4gTXVyYWxp
ZGhhcmFuIHdyb3RlOg0KPj4gbnZtZW1fcmVnaXN0ZXIoKSBzdG9yZXMgY29uZmlnLT5vZl9ub2Rl
IChvciBjb25maWctPmRldi0+b2Zfbm9kZSkNCj4+IGludG8gbnZtZW0tPmRldi5vZl9ub2RlIHdp
dGhvdXQgdGFraW5nIGl0cyBvd24gcmVmZXJlbmNlLiBDYWxsZXJzDQo+PiB0aGF0IGdldCB0aGUg
bm9kZSB2aWEgb2ZfZ2V0X2NvbXBhdGlibGVfY2hpbGQoKSBldGMuIGFuZCBkcm9wIHRoZWlyDQo+
PiByZWZlcmVuY2UgcmlnaHQgYWZ0ZXIgcmVnaXN0ZXJpbmcgbGVhdmUgbnZtZW0tPmRldi5vZl9u
b2RlIGJhY2tlZCBieQ0KPj4gbm8gcmVmZXJlbmNlIGF0IGFsbC4NCj4+DQo+PiBUYWtlIGFuIG9m
X25vZGVfZ2V0KCkgd2hlbiBhc3NpZ25pbmcgbnZtZW0tPmRldi5vZl9ub2RlIGFuZCByZWxlYXNl
DQo+PiBpdCBpbiBudm1lbV9yZWxlYXNlKCkuIEV4aXN0aW5nIGNhbGxlcnMgdGhhdCBob2xkIHRo
ZWlyIG93biBnZXQvcHV0DQo+PiBwYWlyIGFyb3VuZCB0aGUgcmVnaXN0cmF0aW9uIGNhbGwgbmVl
ZCBubyBjaGFuZ2VzLCBzaW5jZSBnZXQvcHV0IG9uDQo+PiBhIGRldmljZV9ub2RlIGlzIHBlci1o
b2xkZXIgYW5kIGluZGVwZW5kZW50IG9mIGNvcmUgbm93IGFsc28gaG9sZGluZw0KPj4gb25lLg0K
Pj4NCj4+IFN1Z2dlc3RlZC1ieTogTWljaGFlbCBXYWxsZSA8bXdhbGxlQGtlcm5lbC5vcmc+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBNYW5pa2FuZGFuIE11cmFsaWRoYXJhbiA8bWFuaWthbmRhbi5tQG1p
Y3JvY2hpcC5jb20+DQo+IA0KPiBOaWNlIQ0KPiANCj4gRGlkIHlvdSBjaGVjayBpZiBhbnkgY2Fs
bGVycyBhcmUgYWxzbyB0YWtpbmcgYSByZWZlcmVuY2UsIHdoaWNoDQo+IG1pZ2h0IG5vdCBiZSBu
ZWVkZWQgYW55bW9yZSBub3cuDQo+IA0KDQpZZXMsIEkgY2hlY2tlZCDigJQgbm9uZSBvZiB0aGUg
Y2FsbGVycyBob2xkIGEgcmVmZXJlbmNlIGJleW9uZCB0aGUgDQpyZWdpc3RyYXRpb24gY2FsbCBp
dHNlbGYuIFRoZSBwYXR0ZXJuIEkgdmVyaWZpZWQgaW4gZWFjaCBkcml2ZXJzIGlzIA0Kc2hvcnQt
bGl2ZWQsIHRoZSByZWZlcmVuY2UgaXMgZHJvcHBlZCByaWdodCBhZnRlciANCm52bWVtX3JlZ2lz
dGVyKCkvZGV2bV9udm1lbV9yZWdpc3RlcigpIGNhbGwuDQoNCj4gUmV2aWV3ZWQtYnk6IE1pY2hh
ZWwgV2FsbGUgPG13YWxsZUBrZXJuZWwub3JnPg0KPiANCj4gLW1pY2hhZWwNCj4gDQo+PiAtLS0N
Cj4+ICAgZHJpdmVycy9udm1lbS9jb3JlLmMgfCA1ICsrKy0tDQo+PiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZW0vY29yZS5jIGIvZHJpdmVycy9udm1lbS9jb3JlLmMNCj4+IGluZGV4IDA1NTZk
MTQwMTcwYS4uOTgxOTI1OTdiOTM1IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9udm1lbS9jb3Jl
LmMNCj4+ICsrKyBiL2RyaXZlcnMvbnZtZW0vY29yZS5jDQo+PiBAQCAtNTQxLDYgKzU0MSw3IEBA
IHN0YXRpYyB2b2lkIG52bWVtX3JlbGVhc2Uoc3RydWN0IGRldmljZSAqZGV2KQ0KPj4gICANCj4+
ICAgCWlkYV9mcmVlKCZudm1lbV9pZGEsIG52bWVtLT5pZCk7DQo+PiAgIAlncGlvZF9wdXQobnZt
ZW0tPndwX2dwaW8pOw0KPj4gKwlvZl9ub2RlX3B1dChudm1lbS0+ZGV2Lm9mX25vZGUpOw0KPj4g
ICAJa2ZyZWUobnZtZW0tPm9wcyk7DQo+PiAgIAlrZnJlZShudm1lbSk7DQo+PiAgIH0NCj4+IEBA
IC05NTAsOSArOTUxLDkgQEAgc3RydWN0IG52bWVtX2RldmljZSAqbnZtZW1fcmVnaXN0ZXIoY29u
c3Qgc3RydWN0IG52bWVtX2NvbmZpZyAqY29uZmlnKQ0KPj4gICAJbnZtZW0tPmtlZXBvdXQgPSBj
b25maWctPmtlZXBvdXQ7DQo+PiAgIAludm1lbS0+bmtlZXBvdXQgPSBjb25maWctPm5rZWVwb3V0
Ow0KPj4gICAJaWYgKGNvbmZpZy0+b2Zfbm9kZSkNCj4+IC0JCW52bWVtLT5kZXYub2Zfbm9kZSA9
IGNvbmZpZy0+b2Zfbm9kZTsNCj4+ICsJCW52bWVtLT5kZXYub2Zfbm9kZSA9IG9mX25vZGVfZ2V0
KGNvbmZpZy0+b2Zfbm9kZSk7DQo+PiAgIAllbHNlDQo+PiAtCQludm1lbS0+ZGV2Lm9mX25vZGUg
PSBjb25maWctPmRldi0+b2Zfbm9kZTsNCj4+ICsJCW52bWVtLT5kZXYub2Zfbm9kZSA9IG9mX25v
ZGVfZ2V0KGNvbmZpZy0+ZGV2LT5vZl9ub2RlKTsNCj4+ICAgDQo+PiAgIAlzd2l0Y2ggKGNvbmZp
Zy0+aWQpIHsNCj4+ICAgCWNhc2UgTlZNRU1fREVWSURfTk9ORToNCj4gDQoNCg0KLS0gDQpUaGFu
a3MgYW5kIFJlZ2FyZHMsDQpNYW5pa2FuZGFuIE0uDQo=
