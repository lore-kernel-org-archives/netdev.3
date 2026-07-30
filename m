Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20C3BBFC3;
	Thu, 30 Jul 2026 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400213; cv=fail; b=mYahSAM053VpAQFJ5BEg+geCGC+0m5Y3WU801HpjLG2OyewM8emaQueh9/kcK/neMwnJP50a5pmfdzkUnCIbQgEY0kze2hlqhIdBgmYpk4YRO+tbhxTUQqvM6eXuo0G6rMVMYFfvWSaa26hitjYnSLGkVI65x2XuH9CJA0c6Bdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400213; c=relaxed/simple;
	bh=SVNT48KLuXvW+FsO12dbjRZzUM5oN4R2foBMRhaCjns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WDRVp4fpelZqD84foZ+hfYz62HaNQ617TMHp+7DsnEFbyQuaOiQamYgpyIgLBe1XIb7WuzEt8VUW1A1AJOswigORaWXEkKNLNzEWujpadEYCGuY2gs9yjNKnCiUzYH+nQAd3LiBCs/U2wzf939Lo80X5wiEW9q2sv9qmS9TE7mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=b5Q6Vi62; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="b5Q6Vi62"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6Yo39295042;
	Thu, 30 Jul 2026 01:30:02 -0700
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022109.outbound.protection.outlook.com [52.101.48.109])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fqu7kscga-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 01:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4p7IKyN62BccIQZyzs4Zp7ndnFIcjGG2Hy/GOhIgeNF4GKh4Pl7R1N8Bi7BlaZ/0onFv4ebzFyCDyVkgdWOZsRQVfW0h1eXh/ULVSAspcWKiwiXPt8Xy4lWkQGthxRYDhfKAM8xFcWYXnEem/JTUNYERaCjPmqjRMVqd1MA0evhF2RfDzy0SbJpQtxAM4uchsPARX8/WZO/UQTIRPTypAWbI2Fbj86Kv7jtXd+dKSQ3aPFCSlcXe1nsebTcb9K3FJHEvGPDSAbCrSul5JoBqg/t0ZwuuUeGHU+AK6RM2xUGqh+OriZ25wOm29VJgBhUzmyQP5AS3T4kn/bumIZLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVNT48KLuXvW+FsO12dbjRZzUM5oN4R2foBMRhaCjns=;
 b=byrliEFcqTisdwCJUu/2nHoNjun+4d6wpRTGfpVDNYuW04pMbnr/K3QvxEj29ad/HWAI0pa2ZrxSZUsFvx8N0Hmdv9aHfcGm6RDfOM8ho6mUiy8pqCkAborUytPfW0hOjJ8a1rN2VViMl6it40deuXjBbJgbZ8+xfkPY3v4sPimHsV7/baIAqNyZoD4rLMYGCoEjfl7Y9bpe7OdzsqysoCG59XiN1sHubsxZbVRkIc+VmKh9Vn7QazevhNF3Eq5iqksokGOnBx8BcX5mVY7fvVrYgL3bKHGOfwqh2pX8ZdDtTszodwdc5K6BEC/xUPK1xsJZBgj0iRKkq5aYgLjPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVNT48KLuXvW+FsO12dbjRZzUM5oN4R2foBMRhaCjns=;
 b=b5Q6Vi62xpeyJi7Btp9+TdlBnbjAYaAFtNxlGzK3gdt9q0pa9VTyILsliTWr949TCSentnj5yTiaSXv7enPiGVp8JLkRXHzaCi+nqZzrkSgRwm7HAwsYYVRD2IYDBeX7Iyxs5J8/b7tMmbgBwN/b7ko2S+lz5l4x35HU3nqVtKk=
Received: from BL1PR18MB4374.namprd18.prod.outlook.com (2603:10b6:208:31d::11)
 by LV1PR18MB988707.namprd18.prod.outlook.com (2603:10b6:408:3f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 08:29:58 +0000
Received: from BL1PR18MB4374.namprd18.prod.outlook.com
 ([fe80::867e:6c8e:f418:4b13]) by BL1PR18MB4374.namprd18.prod.outlook.com
 ([fe80::867e:6c8e:f418:4b13%4]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 08:29:55 +0000
From: Subrat Pandey <subratp@marvell.com>
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Subrat
 Pandey <subratp@marvell.com>
Subject: Re: [PATCH net 1/3] octeontx2-af: Fix mcs string buffer size
Thread-Topic: [PATCH net 1/3] octeontx2-af: Fix mcs string buffer size
Thread-Index: AQHdHyzZac10z06QYk6GlATvhYB2DraEULlQgAFB6niAABeVMIAABGFn
Date: Thu, 30 Jul 2026 08:29:54 +0000
Message-ID:
 <BL1PR18MB43747999AC98FD27154EDE7BABC92@BL1PR18MB4374.namprd18.prod.outlook.com>
References: <20260729072337.664479-1-subratp@marvell.com>
 <20260729072337.664479-2-subratp@marvell.com>
 <PH0PR11MB5902D607518134D4FB323044F0CA2@PH0PR11MB5902.namprd11.prod.outlook.com>
 <DM4PR18MB43844B8740DB2D5FFDBCED0FABC92@DM4PR18MB4384.namprd18.prod.outlook.com>
 <PH0PR11MB5902E826DFB27A4AF57CD173F0C92@PH0PR11MB5902.namprd11.prod.outlook.com>
In-Reply-To:
 <PH0PR11MB5902E826DFB27A4AF57CD173F0C92@PH0PR11MB5902.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR18MB4374:EE_|LV1PR18MB988707:EE_
x-ms-office365-filtering-correlation-id: 1d863d74-8a07-4113-4bba-08deee14bbd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|4143699003|5023799004|11063799006|10067099003|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info:
 H09hU1KkGREnAtpRamCMQ3otL5clpOPo0VhdrNjmlarC0mJkL6aq2cgp8sB7xg2IGrxSdX16dGG3+3BeYShX037DgXBkt/zOBovS8JRdLUcZFH2+NiyerGl5oRV32JHwtrBmDHSJUhlksXiEDu9B/tvGbkj3KlqVkE0T7L5q8KwzAgTUQV/Tf/kGF+lGGihqeN5piyOlYbeqGvu+1hyNAOo/2slXJUU2yF5Jzt2UDNT4UGv8UexI/2j5XeoTzt6o3UXsB7iaCsCn/2CFHw3BruijqqXaX0T3Tbp695s45VMr6367g6x7g414g4HL0Xw3GuJSq7SI0FCICbMERP1MjgoPOgw/xPBddejJKxrDg6YfdUkNfJpnYhKGRPlKdYfQUi+CJOjPCHhrmeghw/3F5mcCaO9FzD3/3hIFAtNgEQab895k7BrT3uOmDpFvYtkwXxmGHDksvNyY13KxatfWCGQXvwvEhtEdoCDQ4L1BMqsI5IHcr97qI6Zc2Ve1inS7Af5KYHbtegPKv6LNsXi2/BMO4uEwzYzZPKWpvKCRUI7nK7/UeUgKqUJXn5mLh/0boFJF5yC+zLknDTO9BpWAb98UXF13zX1qgYglxDSN4OS4cq8sBPfIyQNx3YdahQtQGlNOdysvqKbsGoDF4mnv2GT6m8RHnvzzxuTyoNHvVJFf2krMxKYHoV2UhDn28Jy88OE2/JHKhwpZ81bGh2AjajItdJIoncqYNvDSa+OnoBw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR18MB4374.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(4143699003)(5023799004)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OVlLeENEYVdjSXIxUzVEZWk2Q0tOT1dNM3ZQUWlqN01Ja0ErMDBzVzRWOFF4?=
 =?utf-8?B?dW03cjB5N2pYamJheVB3WUxjL0pJdVRRQXVUakhCUTNEdkZpWHBSK2RUd3Vo?=
 =?utf-8?B?dU51L1dObGN5U3BFaml1VW5MemdZUGtFTjk4VTQzK0lhaGNMYjk4bmdLOEhP?=
 =?utf-8?B?WVlBSENyYnI1cUU4R00wZlVra1pXUnU1WFRlVm9GNkJoYTF5ZVExRVRndGxW?=
 =?utf-8?B?M3EzL0lRa1ZZOU1CSEN4UGgyUEllRnRBa1dzdEpZQ2FmMTlaN04yTys2ZGU3?=
 =?utf-8?B?Ym5KVGZRTGVMeW1PZFR6VWVrYllEaVRuQTNxM2JyRFVpWkRXNER2N1RlbElB?=
 =?utf-8?B?QlZyRWNHL1FyQ3d1R2M4bWVhRW5mQjA0cGlQbWc0cituU1NHYVM3ZDBqQ3lM?=
 =?utf-8?B?ZUZCNUpjZUpsVmdmYnJNbzVIN1VjU3VWTkNSYS82VVZYdzBOaFlMSS9wbTAy?=
 =?utf-8?B?dmtxc0o4aDMwQnRiUmYwOUJ1ZHY0cFVhV2dsd1hLV3A1cDk5YSt2WjdFUkUr?=
 =?utf-8?B?NnAwTlp2eUp5YlFISEhaenNlS2RZMnA4NDY1UjAvMm1NeGp3L2VYMGxndXR0?=
 =?utf-8?B?QUF5bjU0ODl2andxbThRZWVJNEc0RWV5SmptN2s0MHI5QjJaSmpxZ21qVW1p?=
 =?utf-8?B?SDYzZko3SlVqN2l2cENhTWhlSnVFVExHL202eDMrOFJteElETTVZV1ZjNjll?=
 =?utf-8?B?czNhaWJ3NmU3VE9PT2dLT21WLzlBYWMxZytKNVdieklsNmtqL25YR1kxbGRr?=
 =?utf-8?B?ajNNcUo5aUZLWk9CaVFQQ3M2aEZpekloM3BnQkdlWWtuNWwxM2xTd2FFOHhM?=
 =?utf-8?B?cmQ3azNiM3VIU0Y5Z0x1YkVQalkzYTRBQ0QxNUg3dFRRTUx3Z05DM3dJNlJo?=
 =?utf-8?B?WjhGNGdDaVNPSlhRTGRiRjk3cFRsY1ZZSDU4SnNQVnJGZFBIWG8xUnpFMSs4?=
 =?utf-8?B?RUVGR3h5bWpydGtSLy83bWdDWXhKZVVlOGN1RkIzVzI0RlhoeG95cXBpZmNm?=
 =?utf-8?B?OTMzOG9hbnV0UXA0Q1ZQVFZpSys2S0l0c2xKWmVHbm1Ma09lNmU4YWRWaGpV?=
 =?utf-8?B?YnV3My8wMnJPU3hYQ3Y0VGk4a0taUzVRUG1YWmdleEtLTG9aZU5rQ2RlUnBm?=
 =?utf-8?B?RE9vamt1M0VXb1pOa1BzZDE0ZytucGdoOE5oVDZhS3I4RGhzV0U4bUNmZEhT?=
 =?utf-8?B?T3hObzkvcVp1KzlnZjA0R1g4NC95VlJOUE5ab09UV1RSbkMvTW5DU1ZhYU11?=
 =?utf-8?B?OURMdzRTV3lGVUpmM1h1UlZ1d3FpU2NVR1FPeVNhN2NXMDMydER0Y25ubGZo?=
 =?utf-8?B?cnpUVGtHOHJrTlVLbSszdjNzZkdHS1VhZnVwY3AxdTZHb3l1Z3FIa0YzV09T?=
 =?utf-8?B?MU03c0MxQ1VhWVNPTEkyZkJVRjFubEFvRHJZdExYS3E0aXFuRm5VUXNDaHJS?=
 =?utf-8?B?TEc1MmM0Y0VidHZvamFZVmY1WnVTbEllUm5HazNkTWxFYVhGVk1lUmxNUmFs?=
 =?utf-8?B?QmlsNVNlZjNuN3JQaWVOcytSeHpueU5Sc05JbG1nT1cvY1RuR1hqb0MxM05y?=
 =?utf-8?B?c2hlQThoZ0RYUFlJeUF4SjByajBtYnRyZ2VZWTdaYW9va0lZTjBua2tSL2dy?=
 =?utf-8?B?WEhoZ1BRK2kxNmlZVmcrS3JMUklIZ0VLRVROUWJkSi9ZM3d4QlZUZ1VEUngr?=
 =?utf-8?B?S0phcUQ4ZUJWc3c0YWtObVRKbVF4MTVQdW9odG9Ba3psbnZwY1k1MjJlTUcr?=
 =?utf-8?B?YU1xY08rV1ZaMXNuRWJhbkdmM2VNN3lKM1M4dEpYbGE2YkNGRmQweTFkU3Vh?=
 =?utf-8?B?ckVZZ21UT0JFbFBKNVM0dnhrMTNKbVhnUG1xVmhtSURydFo2Zlh0SEk1WWZE?=
 =?utf-8?B?SGYybUlDSHcwdE9zNkRha0xRek5FUmpQSkdCbHp5ZE5wVml5VThCaDBHNXcr?=
 =?utf-8?B?Mm9Nc3lqeU1SYmgwS0UzbnZBQklTNTZoTk9rUEpVZHVYdmtwR2xkMXZZcktm?=
 =?utf-8?B?QjZMRTR6eTJwekJidkwzbG9KRTlWZ2l2QklKTzdiZWpCK3JvRU9jbkpNRXdo?=
 =?utf-8?B?OXZKQ1d2QS9PbDBpbVNZZXhENHNLWlRQZ1Z1UDU0SmdYWjRJZ01aQjE5Umdm?=
 =?utf-8?B?MmUvQk1CWXZMZUU4S3paR3BDTFdRc0tsaUtBUTVyUXpDbng0UE5Qb3ZKR29K?=
 =?utf-8?B?UUk1RXYxR09KSHc2cnlSc0Jra1Q2Z3Uzb2tWb2lVN0p6VkdZMFVvVWVBOStm?=
 =?utf-8?B?SlUxMnJIMzZoRXVZdkt6VnRFanRFbTluUGpZaDI5d01ZK3BuY25RRk1TWFB0?=
 =?utf-8?Q?KfAP0trJRb/jJX4yjh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	dH+7M197nLul+dN910it3eVxbdnSCDonMYdczrOqEVUxtsV4+F9858Oh35Q98GpIiY/ilQ2ClLJQJVxVBbQh/9pv7mObZlIU9xc2vHn1aJ5PJ+MFzDSyE+nmxW6V3xz0uf90dP0/pcC5R7ynmUI4g1K32qe9SHsS0e0P0Z9BNz/F5SwRiYzj657sytlHnopf8l06nQbJoOOBKKWDEGSmlBdkMLxp/ya3xZ9Pi+w8Ttp+tB4TjmjSx1+Av26SbYOEaRCQuTE1Rh9gNmh2KounLo2YRUBFPnzprnnkeQ3LtuCLZTvSBB+vJ2bD1EXpa6uIWUJw7sV2GSvv+3R/QTc7mw==
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR18MB4374.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d863d74-8a07-4113-4bba-08deee14bbd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 08:29:55.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mtlz+OkWePPeU8CpPWX7PWONazT4/5DkaCs23/7M/W3mCOr22LOZ1szrBUnO2qauoZ/p21TP39dpVUpYycMg1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR18MB988707
X-Proofpoint-GUID: wyQkK8Jmiuna1uFWifWwuskTdHXlv-xr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA2MSBTYWx0ZWRfX0pjAbhrV6NZL
 vlIue79LvyHRW3eVUs9V6sLl13gCqO/KfM307VjaKcDDHzKpaGZygyzVjyp/9/V2fMqxBpLF1AZ
 q2eUvKWdd5V9gVXvIholdHek3fAwGII=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA2MSBTYWx0ZWRfX07VCsMMaoxGS
 fQWxNy5Mtx3QxWgIubfx5ujVOoJ7o5HJiZ2NJjM+faqYpDNK9H1B4sM0pS5oFR1hck3sC03L52V
 qJ0JSMvE7J5V4H9SBdi4u1WGJbhI0gnEYvu5Uu8hL1/KOfGytwKV/jRJYjjYsJkyk/fXIReGKAX
 qA3Za2q2JBP14WBH2sYi3lu5ERqlFJ5N4xnijELaKKdt07bYIVsW6XIal014Pce24jTBGnqXcAL
 GfZfiVyqhzeqDHrgpECPgfzc4Y0PT7dyYJQQOkGH/DklANzN+GrqdjUe6NXOjO4pkBfXmUCvQwg
 0kFXcPdnro3aEPVT0imPK9uQ7Eo46DRNzUmTTlduunbxeTwuhCOwke1P/XImawmze/5reBYWK4H
 nnBb40wJD02SNowJKhM6agDPABqa2ZloNELeOJRHkrm2ak36ZbTV1QiDQ6urFi94GT8AghqhKUu
 Zge/SRpXlcgeI4myGpA==
X-Proofpoint-ORIG-GUID: wyQkK8Jmiuna1uFWifWwuskTdHXlv-xr
X-Authority-Analysis: v=2.4 cv=TrnWQjXh c=1 sm=1 tr=0 ts=6a6b0b89 cx=c_pps
 a=d6SuDfCU3ZZz3a5uGz2bWA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=-AAbraWEqlQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8
 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8
 a=J1Y8HTJGAAAA:8 a=9qxNCY_qAAAA:8 a=WVTPzkQoiUmB2wrWO-AA:9 a=lqcHg5cX4UMA:10
 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_02,2026-07-29_01,2025-10-01_01

CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpGcm9tOiBKYWdpZWxz
a2ksIEplZHJ6ZWogPGplZHJ6ZWouamFnaWVsc2tpQGludGVsLmNvbT4KU2VudDogVGh1cnNkYXks
IEp1bHkgMzAsIDIwMjYgMTI6NTQgUE0KVG86IFN1YnJhdCBQYW5kZXk7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcKQ2M6IHBhYmVuaUByZWRoYXQu
Y29tOyBrdWJhQGtlcm5lbC5vcmc7IGVkdW1hemV0QGdvb2dsZS5jb207IGRhdmVtQGRhdmVtbG9m
dC5uZXQ7IGFuZHJldytuZXRkZXZAbHVubi5jaDsgU3ViYmFyYXlhIFN1bmRlZXAgQmhhdHRhOyBS
YXRoZWVzaCBLYW5ub3RoOyBHZWV0aGFzb3dqYW55YSBBa3VsYTsgU3VuaWwgS292dnVyaSBHb3V0
aGFtClN1YmplY3Q6IFtFWFRFUk5BTF0gUkU6IFtQQVRDSCBuZXQgMS8zXSBvY3Rlb250eDItYWY6
IEZpeCBtY3Mgc3RyaW5nIGJ1ZmZlciBzaXplCgpGcm9tOiBTdWJyYXQgUGFuZGV5IHN1YnJhdHBA
4oCKbWFydmVsbC7igIpjb20gU2VudDogVGh1cnNkYXksIEp1bHkgMzAsIDIwMjYgODrigIozMCBB
TSA+RnJvbTogSmFnaWVsc2tpLCBKZWRyemVqIGplZHJ6ZWou4oCKamFnaWVsc2tpQOKAimludGVs
LuKAimNvbSA+RGF0ZTogV2VkbmVzZGF5LCAyOSBKdWx5IDIwMjYgYXQgNDrigIoxNyBQTSA+VG86
IFN1YnJhdCBQYW5kZXkgc3VicmF0cEDigIptYXJ2ZWxsLuKAimNvbTsgbGludXgta2VybmVsQOKA
inZnZXIu4oCKa2VybmVsLuKAim9yZwoKPkZyb206IFN1YnJhdCBQYW5kZXkgc3VicmF0cEBtYXJ2
ZWxsLmNvbTxtYWlsdG86c3VicmF0cEBtYXJ2ZWxsLmNvbT4KPlNlbnQ6IFRodXJzZGF5LCBKdWx5
IDMwLCAyMDI2IDg6MzAgQU0KCj4+RnJvbTogSmFnaWVsc2tpLCBKZWRyemVqIGplZHJ6ZWouamFn
aWVsc2tpQGludGVsLmNvbTxtYWlsdG86amVkcnplai5qYWdpZWxza2lAaW50ZWwuY29tPgo+PkRh
dGU6IFdlZG5lc2RheSwgMjkgSnVseSAyMDI2IGF0IDQ6MTfigK9QTQo+PlRvOiBTdWJyYXQgUGFu
ZGV5IHN1YnJhdHBAbWFydmVsbC5jb208bWFpbHRvOnN1YnJhdHBAbWFydmVsbC5jb20+OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPG1haWx0bzpsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPG1haWx0bzpsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzxtYWlsdG86bmV0ZGV2QHZnZXIu
a2VybmVsLm9yZz4gbmV0ZGV2QHZnZXIua2VybmVsLm9yZzxtYWlsdG86bmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZz4KPj5DYzogcGFiZW5pQHJlZGhhdC5jb208bWFpbHRvOnBhYmVuaUByZWRoYXQuY29t
PiBwYWJlbmlAcmVkaGF0LmNvbTxtYWlsdG86cGFiZW5pQHJlZGhhdC5jb20+OyBrdWJhQGtlcm5l
bC5vcmc8bWFpbHRvOmt1YmFAa2VybmVsLm9yZz4ga3ViYUBrZXJuZWwub3JnPG1haWx0bzprdWJh
QGtlcm5lbC5vcmc+OyBlZHVtYXpldEBnb29nbGUuY29tPG1haWx0bzplZHVtYXpldEBnb29nbGUu
Y29tPiBlZHVtYXpldEBnb29nbGUuY29tPG1haWx0bzplZHVtYXpldEBnb29nbGUuY29tPjsgZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldDxtYWlsdG86ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4gZGF2ZW1AZGF2ZW1s
b2Z0Lm5ldDxtYWlsdG86ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IGFuZHJldytuZXRkZXZAbHVubi5j
aDxtYWlsdG86YW5kcmV3K25ldGRldkBsdW5uLmNoPiBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g8bWFp
bHRvOmFuZHJldytuZXRkZXZAbHVubi5jaD47IFN1YmJhcmF5YSBTdW5kZWVwIEJoYXR0YSBzYmhh
dHRhQG1hcnZlbGwuY29tPG1haWx0bzpzYmhhdHRhQG1hcnZlbGwuY29tPjsgUmF0aGVlc2ggS2Fu
bm90aCBya2Fubm90aEBtYXJ2ZWxsLmNvbTxtYWlsdG86cmthbm5vdGhAbWFydmVsbC5jb20+OyBH
ZWV0aGFzb3dqYW55YSBBa3VsYSBnYWt1bGFAbWFydmVsbC5jb208bWFpbHRvOmdha3VsYUBtYXJ2
ZWxsLmNvbT47IFN1bmlsIEtvdnZ1cmkgR291dGhhbSBzZ291dGhhbUBtYXJ2ZWxsLmNvbTxtYWls
dG86c2dvdXRoYW1AbWFydmVsbC5jb20+Cj4+U3ViamVjdDogW0VYVEVSTkFMXSBSRTogW1BBVENI
IG5ldCAxLzNdIG9jdGVvbnR4Mi1hZjogRml4IG1jcyBzdHJpbmcgYnVmZmVyIHNpemUKPj4+PkZy
b206IFN1YnJhdCBQYW5kZXkgc3VicmF0cEBtYXJ2ZWxsLmNvbTxtYWlsdG86c3VicmF0cEBtYXJ2
ZWxsLmNvbT4KPj4+PlNlbnQ6IFdlZG5lc2RheSwgSnVseSAyOSwgMjAyNiA5OjI0IEFNCj4+Cj4+
Pj5Gcm9tOiBTdGVmYW4gV2llaGxlciBzdGVmYW4ud2llaGxlckBub2tpYS5jb208bWFpbHRvOnN0
ZWZhbi53aWVobGVyQG5va2lhLmNvbT4KPj4+Pgo+Pj4+VGhlICJtY3MlZCIgbmFtZSBpcyBidWls
dCB3aXRoIHRoZSB1bmJvdW5kZWQgc3ByaW50ZigpLCB3aGljaCB3cml0ZXMKPj4+PndpdGhvdXQg
YW55IHJlZ2FyZCBmb3IgdGhlIHNpemUgb2YgdGhlIGRlc3RpbmF0aW9uIGJ1ZmZlciBhbmQgY2Fu
Cj4+Pj5vdmVycnVuIGl0LiBTd2l0Y2ggdG8gc25wcmludGYoKSB3aXRoIHNpemVvZigpIHNvIHRo
ZSBmb3JtYXR0ZWQgd3JpdGUKPj4+PmlzIGFsd2F5cyBjbGFtcGVkIHRvIHRoZSBidWZmZXIuIFRo
ZSBidWZmZXIgaXMgYWxzbyBlbmxhcmdlZCB0bwo+Pj4+MjQgYnl0ZXMgdG8gY29tZm9ydGFibHkg
aG9sZCB0aGUgc3RyaW5nIGZvciBhbnkgTUNTIGJsb2NrIGluZGV4Lgo+Pgo+Pj5IaSBTdWJyYXQK
Pj4KPj4+SXMgdGhpcyBzb21ldGhpbmcgdGhhdCBjYW4gYWN0dWFsbHkgb2NjdXIgZHVyaW5nIGFu
eSByZWFsIHNjZW5hcmlvPwo+Pgo+PlRoYW5rcyBmb3IgdGhlIHJldmlldy4KPj4KPj5ObyDigJQg
aW4gcHJhY3RpY2UgaXQgY2FuJ3Qgb3ZlcmZsb3cuIFRoZSBjaGFuZ2UgaXMgZGVmZW5zaXZlIGhh
cmRlbmluZyByYXRoZXIgdGhhbiBhIGZ1bmN0aW9uYWwgZml4OyB3ZSBtYWlubHkgd2FudCB0byBh
dm9pZCB0aGUgc3RhdGljLWFuYWx5emVyIHdhcm5pbmcuICBJZiB5b3UgcHJlZmVyIHdlIGNhbiBh
bHNvIGRyb3AgdGhpcyBwYXRjaC4KPj4KPj5TdWJyYXQuCj4KPkkgYW0ganVzdCB3b25kZXJpbmcg
d2hldGhlciB3ZSBzaG91bGQgZHJvcCBmaXhlcyB0YWcgZm9yIHRoaXMgb25lIGlmIGFueSByZWFs
Cj5zY2VuYXJpbyBpc3N1ZSBpcyBub3QgZml4ZWQgaW4gZmFjdC4gU2FtZSBmb3IgbmV0IGFzIGEg
dGFyZ2V0IHRyZWUKPgoKQWdyZWVkLiBXZSdsbCBkcm9wIHRoaXMgcGF0Y2ggZnJvbSB0aGUgc2Vy
aWVzIGFuZCByZS10YXJnZXQgaXQgdG8gbmV0LW5leHQuCgo+Pgo+Pj4+Pj5GaXhlczogZDA2YzJh
YmE1MTYzICgib2N0ZW9udHgyLWFmOiBjbjEwazogbWNzOiBBZGQgZGVidWdmcyBzdXBwb3J0Iiku
Cj4+Pj5TaWduZWQtb2ZmLWJ5OiBTdGVmYW4gV2llaGxlciBzdGVmYW4ud2llaGxlckBub2tpYS5j
b208bWFpbHRvOnN0ZWZhbi53aWVobGVyQG5va2lhLmNvbT4KPj4+PlNpZ25lZC1vZmYtYnk6IFN1
YnJhdCBQYW5kZXkgc3VicmF0cEBtYXJ2ZWxsLmNvbTxtYWlsdG86c3VicmF0cEBtYXJ2ZWxsLmNv
bT4K
