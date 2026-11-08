Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.153.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167001;
	b=l1PPTGd8NhtjSsVi0JnLZz+kQf/hQrRU2oYNKQgRVZhMtH2zxU9jkdRBrewXd6SavbWV
	 VUFxYR7kSyS3T9V4lK2Oqn+9R07QTzM8tZNNytBbiS4QGVBmla7S1fXWKWGwdZNbdX4oT
	 qOqqB6FV7VBv8QIIi6ty68yr73LwkSFFPwczY5jge5FJ7YnO+8NwMvCm+eo/vSnOsxf9G
	 DVGQKfFFviTIXsSpn3g8ZgiO4AbvKr8c8/UWw7eE0vOPqn8hl826KhaEWtYwIPyag+l5M
	 8sRFr9OWVF0fILO5ukI5zMawOsUwmdWn50ptzhYffakW8TXT7+lzpxW3aaUqurzMCQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167001;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding;
	bh=LMUIQd9BKqDIp0iT+IOnxSEGBNI8CopxVff36z6SJAQ=;
	b=XE/26OC9lnGL+EizMAIkh82qN/UbhCw5QkixrCeq+TihwJEPRoqlWaShKlL4m0SaTUAt
	 34kM3pFUhd52PM9fzYeZr/F/uZZS9xJzcB6RIUfl6IfjSmqXu8JR/LtMnh2UX0aXdcDhn
	 Ti2OM+gGE+go9YH8r7628Ug8BrR9TzCAMpDo3FtUC/S7EBMeIhB/Rhsf3j+V27BnIpRAu
	 VvWb9nqdVzGlgoWch1LvDnBft9wsP5uQhUvOg5elVP/5vVShK8fRtwH7jQlgl+wDoChz+
	 7+tYnVDMFNoysrgGbHbMd0cWLyqk7wWvn3D5QfYyssoj6eMaE3yUv2bEZxYeJBaDzuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=onsemi.com;
	spf=pass smtp.mailfrom=onsemi.com;
	dkim=pass header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=L3tNSh7I;
	arc=none smtp.remote-ip=170.10.153.120
Received: from usb-smtp-delivery-120.mimecast.com (usb-smtp-delivery-120.mimecast.com [170.10.153.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11F5606A330
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 19:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C11F5606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onsemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onsemi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onsemi.com header.i=@onsemi.com header.a=rsa-sha256 header.s=mimecast20250127 header.b=L3tNSh7I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onsemi.com;
	s=mimecast20250127; t=1794166994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LMUIQd9BKqDIp0iT+IOnxSEGBNI8CopxVff36z6SJAQ=;
	b=L3tNSh7II7kELHWPkjmM69D9WOAJ5uphj2yB/++RkzIHjEsM6tJ6Dy46LGles1ISeENfNR
	sDaCSf+7KCD2+7P20JMt+DQIsayyqYcCI0YiRrrjoclC3hspWjs0slcrmvnHa28J2s3jDE
	zcithfYb1jpddwiLDNbRe1Nd/e3e1zeInueoEX9avCn+/LfttJqmkOQYEJvV7Ra2U01sKi
	p6dRmex2nX6OWJSjnSAn7UBxbVJpJES31EDFcw/evacYrkLFMh774V+U5y0CFEPu+eWWwP
	6rOZtVzXu8s40NtLVD9ncBxntc0lt+2ZdNdSPEF7FM3xWajmbi+JBWZhLRvROA==
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id usb-mta-16-y3634tYwMkugPc9Hy0f5MQ-1; Sun,
 08 Nov 2026 11:43:00 -0800
X-MC-Unique: y3634tYwMkugPc9Hy0f5MQ-1
X-Mimecast-MFC-AGG-ID: y3634tYwMkugPc9Hy0f5MQ_1794166974
Received: from CH0PR02MB7867.namprd02.prod.outlook.com (2603:10b6:610:110::22)
 by SJ2PR02MB9771.namprd02.prod.outlook.com (2603:10b6:a03:549::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sun, 8 Nov
 2026 19:42:50 +0000
Received: from CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e]) by CH0PR02MB7867.namprd02.prod.outlook.com
 ([fe80::d722:d686:a9cb:6c2e%6]) with mapi id 15.21.0592.010; Sun, 8 Nov 2026
 19:42:49 +0000
From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "parthiban.veerasooran@microchip.com"
	<parthiban.veerasooran@microchip.com>, "horms@kernel.org" <horms@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org"
	<skhan@linuxfoundation.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "edumazet@kernel.org"
	<edumazet@kernel.org>, "piergiorgio.beruto@gmail.com"
	<piergiorgio.beruto@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "jerry.ray@microchip.com"
	<jerry.ray@microchip.com>, "ciprian.regus@analog.com"
	<ciprian.regus@analog.com>
Subject: RE: [PATCH net-next v10 06/11] net: ethernet: oa_tc6: Support for
 vendor specific MMS
Thread-Topic: [PATCH net-next v10 06/11] net: ethernet: oa_tc6: Support for
 vendor specific MMS
Thread-Index: AQHdbkU4auV6WFPvRk+qUBEQ7Pmjs7cjUAaAgAFDaoA=
Date: Sun, 8 Nov 2026 19:42:49 +0000
Message-ID: <CH0PR02MB786763ADB1947B02865A7CC983742@CH0PR02MB7867.namprd02.prod.outlook.com>
References: <20261106-s2500-mac-phy-support-v10-6-31b5a69b85b7@onsemi.com>
 <179409693924.994134.1633626847542095748@kernel.org>
In-Reply-To: <179409693924.994134.1633626847542095748@kernel.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB7867:EE_|SJ2PR02MB9771:EE_
x-ms-office365-filtering-correlation-id: 0dbc39df-cebc-45ee-9043-08df3dd078bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|10067099003|6133799003|38070700021|4143699003|261026121527099003|11063799006|261102123227099003|261028144727099003|261026140227099003|261022075727099003|261021121427099003|56012099006|261009223027099003|261022105027099003
x-microsoft-antispam-message-info: e0ExOGCpCJk8jWEIcc31aX371aMVUcsvBTHDD9w5E8OwKJQ/IOC+yBheA7ewNOUSsPpjcFNWBZvQnYcU2Xp+dZYSMhEP0N84QyyXpXiCEfbGFybWE9cgowS9imHWvPR/alm/aCqZvakSK9XI66LMH3eS+yKEywWYO/TOP6sSF7ePfdWY6CM81R6Toyzhpg1S6yo4PoHGPXEWG2DpooE1yrGrzJVpMzYzchhoMVHN+ux3inRyxs0TGIrJbZo70GbT8o+6G90fvL7vpNKbaUqhOnfeQSroXeJgxIIhZ0EKy/wgd1l6EO3svTfV06gvqH1GDQI11a5E/tJv/hPLbimIN+CKB2hoDdpFDm7l0LoNp5fdJTgdODcdQAiTBK7dMW+DPjIdhi1wye3gEPWIIaMF95+8/mbBsj/P/2vIDDcEw5cAEH456plp7qAfKkLwRTMiOf4G3186ZasEK7OsMjlzkKT92gBa0O2bt50MUwIOTU3ZtyPymEvQ+x9wH+rrnoyR35kHt8N2YreDnk+eu1hwW/qe3JQl1KR378tVHuVkiQ6b57B+yyuXt2Q64h1iVNPNoxcJuOaxO+9E243oXkmeGCQIFuNf7aqVaLGNQCYnma1BwVhFiGZyp0Ll+/bFF+iEjmCRJd1OH4FO4u7R9ztwYEhjeWf6I6tQnyUAZz30Yg0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB7867.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(10067099003)(6133799003)(38070700021)(4143699003)(261026121527099003)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021121427099003)(56012099006)(261009223027099003)(261022105027099003);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cC9VeG9Qc1lZU1NobVY4aU41VjFEQjdzOVNFaGtXUzJmMlpETVhpcnZCd0dL?=
 =?utf-8?B?dEQ0aVNYc1pzTGhWc2NoSCtubm4zcFZwejU3aitXd25Ec1ZLV2JtWm1IRWgv?=
 =?utf-8?B?R0RONS9PbThoaGgyTk9UUjBKTTZHN3RROGcvSVJReHJ0Q1RxaGVESi9UOUJu?=
 =?utf-8?B?eWFrUDVZaU4xZlhtZDNJbmxTWHJRK1owV3hicW81RjVCb2V1eVJYSU5aMDBM?=
 =?utf-8?B?RUNkYlcxUjYrR0taRFI0KytqUTVTVlhqUVFZc0RxSnR0S0JUM3l5R2k5b2xP?=
 =?utf-8?B?Zm8xR25VQXVnb1p2bjlNRjVJb1ZqVXZGMWNQTm55bkUvTEI4cWNNWXZGUTNK?=
 =?utf-8?B?NGViU2JoMHpkTmtUbHVuRFdENzhXS2ZoenIzWUtRTndoM042MCtNd3dsUWtC?=
 =?utf-8?B?RkZqUGxjZXhydk5ZZVlKL1RpYlBTbWtqM0M2YWdlSGkvWnVPQ09CbkJ4Rzly?=
 =?utf-8?B?REN0YWdKWFp4V2QrOE0vdGJmSThKVkcvV0NmRTdvR0d0cFk3N1lFWnJEellR?=
 =?utf-8?B?ejlHR09RMGROenJQWDN5aS9rbWpYVisxc2JKdENpdlRuSmxlUEZsZWRnM2o4?=
 =?utf-8?B?OWJRay9icEI3ZGxRMUF0SFNMY1dLYVhUUW5XcHpxV01MT0tuT25hcVpwbWR5?=
 =?utf-8?B?aWpSbGtDeTFOcHRqWGxjbVFpK250bVowSVRnUmZLRHI4M1ZHdGh6Z1A3NXZI?=
 =?utf-8?B?Zm1jOEhHQjVwSEJDazdtZUpuZFovenVhOEhTWENGd1F3M3F0MWUrbkJjU0VW?=
 =?utf-8?B?SjRseGw1aEU5dDYrWGxCOGtmN1A4QjR3b3RJZlRKRUFxd0ozdGFpd1FYUk11?=
 =?utf-8?B?ZHp0RVo0YjdCTXZkeEVra01VcFNuazNCV0J5RXc2aWZnQ0pJK09rVGFuQVJx?=
 =?utf-8?B?UGNTTTRIS2h1bk5aQVp4TG92b3pybS9jZGN6cUxrMTN6MFlrb3YvU3FzNW9l?=
 =?utf-8?B?Z1hjVGlibUg1UlNDVENOcWhjZU5OUC9jakFtVEM5engvaENEM243cGR1cEM2?=
 =?utf-8?B?QWpxcTNJL2FyREs2N1hiY1phTEs2NjRQTmFQOFlubjNJM0J4eTBNRmVjR2dX?=
 =?utf-8?B?eWhEWkx5c2l2NFM0Sm9lcFdYMXlyb2hUTnVKTTZ2VFVwOFpTRmtDWUtITlJn?=
 =?utf-8?B?S0phMmRyTUk3ZnhYdy9RQ3JTZnBtRWhldG9zUWtERVQzdFRKM21qZk9md0k2?=
 =?utf-8?B?ak5LRWhrL0VTWFk4cTRmOEZhRC9rcWFDeVRuTHFaUjJRSFJ4VktCWVJpQWl6?=
 =?utf-8?B?QjJIak5pVmp2V1VLd1pYVjhkREhmRHV5TGc2YTRYNFdZdGRjakI4czVHc1pC?=
 =?utf-8?B?WVNlY2lNcmlUcUMxMXE2Ym0wOGx6N1Raa0Q4dDd1MVlxYW5UMGRSVVBLZ0VC?=
 =?utf-8?B?Skgzd0RHeDgxZ2YrbWdZZ0YxenV1ekNUdXFvTkYzN3hBZ1pBTEh5cnRZZncw?=
 =?utf-8?B?KzU1TXJMcnEvblpSaE9QWWhkaTd2MHlVbmNQVFl1b3hCaXpicGlzT1VKdTFq?=
 =?utf-8?B?UUdyMkVOK2FtQ0ZZSWFZNWZ4WU4zRFdXTVhCcjh2L0ZNQnl2NUtvdmlWZzlY?=
 =?utf-8?B?ZXRSamtzMStNNE04cFlRMG93cXVHdjd6U0VPM1BYWHQvMnc2a1E5M2ZvNWNC?=
 =?utf-8?B?eDNBdUhCWnpuZkpXaHdYblpqamxwNHFHdWRpUndjOWk0Rkh5dUdXd1o0SDFM?=
 =?utf-8?B?R1lTTk5zZEduVjhscnNjTHZSYmYxUWxsZWs2QVVlNTY3TGN4NkF1dmc0cUFt?=
 =?utf-8?B?c0RnN2hpYmdObXdnL0Zma1lVRzIyOXFJczNhS1ovWmFrY2dqWnpnMUdpOVlq?=
 =?utf-8?B?SGI1NjFxNWJ2UTVtRlVwd083THJiWVdZNnNhOGVQdFA0R1ZhQlhKWEhjMjgv?=
 =?utf-8?B?Qm55ell6YUhwRjFWUXRXWXVtMHdNSHBjaWtFcXdZMmphNGJxNGNCMGFBNG9I?=
 =?utf-8?B?TXRDaC9KSmFwWmVPU01SdXprSFUrN2VLdGNBbGQ3bjIzYTVCRW9uWUtITlZK?=
 =?utf-8?B?U3pVY0Jqd1hXQjlBOTZEZ0V5M2x3Z0U3SW91N3VXWHNrQVY2UCtFYVJqQXhI?=
 =?utf-8?B?T2FsN2ZraDc5TmtsOUVHM2dOYnJkbm9LSlJUbkV5d2U3eXRiSHd4SlZITXB3?=
 =?utf-8?B?NTNoaUdHVEU2aEpWcWxXU3ZlazVIRVNiU1N6aEFQN1FGMGRUTXlxWDlLT1Va?=
 =?utf-8?B?OTZwZ3F2UkFyWlp1ejRRM0V5MTBKNkd2TWM3NVJPdUFuT0xEQm8rR0FHOEd4?=
 =?utf-8?B?eHF1UDNJNHlkZVI1OVRqVW41K0VPN1EyNFg3WVZsN3FTNytNcXdCaVBNMFpn?=
 =?utf-8?B?K2VxaFE0a1NENlhycXcyQ05uenpqWVFEd1QreFRFSUNRb1BFK3dDekx5czhj?=
 =?utf-8?Q?wOMHJN08zI2VtkMY=3D?=
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xe694w2QmHpfKvmOx+uYACorCHf0H/e/dROW7buLP8hGJ8pksSCVPyDw1Di+0OjTTdgdtJRF8NvBK5xI8Iuxc5IvXd1e4IMAaWwNLHbzRlM4l8gzv0BXwPFCMWDDJZtXEC5YR4jil4Ry2kQy0DI45stZ1zotLRVAAbjJQaU/CNzP+KjF6YgXw4U/aoQfWx4YnJUDtKHSrsPozTp0Cc8Y+V6RQqXqCf25Xl14rHVW44S/b+HPAxBhHcqe4xYmlVhofUTfjujQb3U9M07wycDLOztH3RAyd8m9jYRdRS6U7h5M0mLSDYqApSH+JB0UnEYXJ53s6ZjR6pY64CuSyIuEew==
X-OriginatorOrg: onsemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB7867.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dbc39df-cebc-45ee-9043-08df3dd078bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2026 19:42:49.8102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 04e1674b-7af5-4d13-a082-64fc6e42384c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/hYIm/ztTesnsp4Gd8/mtjmYPrAzwWjrqYhqtADB8+5/Sb8nedsPIaQBLNq+dIVxKNbrM+TrDDuv74rTcTuMXLHL+zMiKmwoN06cGNedTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR02MB9771
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pcGpvErAN30iADVpF3QJ1dh8fvWxlh6dJujqE6-zrYc_1794166974
X-Mimecast-Originator: onsemi.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBuZXRkZXYtYm90K3Nhc2hpa29A
a2VybmVsLm9yZyA8bmV0ZGV2LWJvdCtzYXNoaWtvQGtlcm5lbC5vcmc+DQo+IFRvOiBTZWx2YW1h
bmkgUmFqYWdvcGFsIDxTZWx2YW1hbmkuUmFqYWdvcGFsQG9uc2VtaS5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjEwIDA2LzExXSBuZXQ6IGV0aGVybmV0OiBvYV90YzY6IFN1
cHBvcnQgZm9yIHZlbmRvcg0KPiBzcGVjaWZpYyBNTVMNCj4gDQo+IG5ldDogZXRoZXJuZXQ6IG9h
X3RjNjogU3VwcG9ydCBmb3IgdmVuZG9yIHNwZWNpZmljIE1NUw0KPiANCj4gVGhpcyBhZGRzIG9h
X3RjNl9zZXRfdmVuZDFfbW1zKCksIHdoaWNoIGxldHMgYSB2ZW5kb3IgZHJpdmVyIG1hcA0KPiBN
RElPX01NRF9WRU5EMSB0byBvbmUgb2YgdGhlIHZlbmRvciBzcGVjaWZpYyBNTVMgdmFsdWVzICgx
MCB0byAxNSkNCj4gYWxsb3dlZCBieSB0aGUgT1BFTiBBbGxpYW5jZSBUQzYgc3BlY2lmaWNhdGlv
bi4gVGhlIEM0NSBNTVMgbG9va3VwIG5vdw0KPiB0YWtlcyB0aGUgdGM2IGNvbnRleHQuIFRoZSBu
ZXcgdmVuZDFfbW1zIGZpZWxkIGRlZmF1bHRzIHRvIC1FT1BOT1RTVVBQDQo+IGluIG9hX3RjNl9p
bml0KCkuDQogDQo+IFtTZXZlcml0eTogTWVkaXVtXQ0KPiANCj4gQ2FuIGEgZmFpbGVkIGNhcGFi
aWxpdHkgcmVhZCBvb3BzIG9uIGEgTlVMTCBwaHlkZXY/IEluIG9hX3RjNl9pbml0KCksDQo+IG9h
X3RjNl91cGRhdGVfc3RhbmRhcmRfY2FwYWJpbGl0eSgpIGlzIGNhbGxlZCBiZWZvcmUgb2FfdGM2
X3BoeV9pbml0KCksDQo+IGFuZCBvbiBmYWlsdXJlIGl0IGRvZXMgZ290byBwaHlfZXhpdC4NCg0K
DQpZZXMuIEl0IGNhbi4gV2lsbCBmaXggaXQuDQoNCj4gDQo+IA0KPiBbU2V2ZXJpdHk6IE1lZGl1
bV0NCj4gRG9lcyB0aGlzIHNldHRlciBydW4gdG9vIGxhdGUgdG8gYWZmZWN0IFBIWSBwcm9iaW5n
IGFuZA0KPiBpbml0aWFsaXphdGlvbj8NCj4gDQo+IHN0cnVjdCBvYV90YzYgaXMgYWxsb2NhdGVk
IGluc2lkZSBvYV90YzZfaW5pdCgpLCBhbmQgdGhlIGNhbGxlciBvbmx5DQo+IGdldHMgdGhlIHBv
aW50ZXIgYmFjayBvbmNlIG9hX3RjNl9pbml0KCkgcmV0dXJucy4gQnkgdGhlbg0KPiBvYV90YzZf
aW5pdCgpIGhhcyBhbHJlYWR5IHJ1biBvYV90YzZfcGh5X2luaXQoKSwgDQoNClRydWUuIEF0IHBy
ZXNlbnQsIHRoZSBwbGFjZSB3aGVyZSB2ZW5kMV9tbXMgc2V0IGlzIG5vdCB0aGUgcmlnaHQgcGxh
Y2UuDQpNTVMgdmFsdWUgY291bGQgYmUgc2VudCB0aHJvdWdoIHF1aXJrcyBzdHJ1Y3R1cmUgdGhh
dCB3ZSBoYXZlIG5vdy4NCg0KQ29uc2lkZXJpbmcgdGhlIGZhY3QgdGhhdCB0aGlzIEFQSSBpc24n
dCB1c2VkIGJ5IHRoZSBQSFkgZHJpdmVyIG5vdyBhbmQgDQpNQUMgZHJpdmVyIGNhbiBhY2Nlc3Mg
TU1TMTIgZGlyZWN0bHkgdGhyb3VnaCByZWFkL3dyaXRlIEFQSSwgSSBhbQ0KZ29pbmcgdG8gcmVt
b3ZlIHRoaXMgQVBJLiBXaGVuIFBIWSBkcml2ZXIgbmVlZHMgaXQsIHByb2JhYmx5IHdoZW4gUEhZ
IA0KZHJpdmVyIGlzIGNoYW5nZWQgdG8gd29yayBpbiBpbnRlcnJ1cHQgbW9kZSwgd2UgY2FuIHJl
LWludHJvZHVjZSB0aGlzIA0KQVBJIHRoZSByaWdodCB3YXkuDQoNCj4gDQo+IFtTZXZlcml0eTog
SGlnaF0NCj4gVGhpcyBwYXRjaCBkb2Vzbid0IHRvdWNoIGl0LCBidXQgdGhlcmUgaXMgYSBwcm9i
bGVtIGZ1cnRoZXIgZG93biBpbg0KPiBvYV90YzZfaW5pdCgpLiBUaGUgZWFybGllciBwYXRjaCBp
biB0aGlzIHNlcmllcywgIm5ldDogZXRoZXJuZXQ6IG9hX3RjNjoNCj4gU3VwcG9ydCBmb3IgaGFy
ZHdhcmUgdGltZXN0YW1wIiwgYWRkZWQgaXQsIGFuZCBpdCBpcyBzdGlsbCB0aGVyZSBhdCB0aGUN
Cj4gdGlwIG9mIHRoZSBzZXJpZXMuDQo+IA0KPiBDYW4gdGhlIGNhcGFiaWxpdHkgcmVhZCBmYWls
dXJlIHBhdGggb29wcyB3aXRoIGEgTlVMTCBwaHlkZXY/IEluDQo+IG9hX3RjNl9pbml0KCk6DQoN
Cg0KWWVzLiBUaGlzIGlzc3VlIHdhcyBvdmVybG9va2VkIHdoZW4gd2UgbW92ZWQgdGhlIEFQSSB1
cC4gV2lsbCBmaXggaXQuDQoNCj4gDQo+IA0KPiAtLQ0KPiBTYXNoaWtvIEFJIHJldmlldyDCtyBo
dHRwczovL25ldGRldi1haS5ib3RzLmxpbnV4LmRldi9zYXNoaWtvLyMvcGF0Y2hzZXQvMjAyNjEx
MDYtczI1MDAtDQo+IG1hYy1waHktc3VwcG9ydC12MTAtMC0zMWI1YTY5Yjg1YjclNDBvbnNlbWku
Y29tDQo+IDxodHRwczovL25ldGRldi1haS5ib3RzLmxpbnV4LmRldi9zYXNoaWtvLyMvcGF0Y2hz
ZXQvMjAyNjExMDYtczI1MDAtbWFjLXBoeS1zdXBwb3J0LXYxMC0wLTMxYjVhNjliODViNyU0MG9u
c2VtaS5jb20NCj4gbmV0ZGV2LWFpLmJvdHMubGludXguZGV2Pg0KDQpwdy1ib3Q6IGNyDQo=

