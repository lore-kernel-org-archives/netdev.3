Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4B2DCC1F;
	Fri, 21 Aug 2026 01:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787274920; cv=fail; b=VNIPG6D8BqbFoB3MMS3hgafpA6rj/egN5YCwlabGhHEeuutqAG0qiTH7Q7Vf3BpfwZyjtCEjyNKiic9kcFL3XOkbrndj5oSNolmt0pzVolu86P1Nuu6wnRLuR8DxPOXQeF7Vr8RctJwbP02+VkdWAlWioUip3KDuUD0NLunUwKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787274920; c=relaxed/simple;
	bh=M6KOTO/Yzx5fGq16R4FiHnakX6E7176KqWdrIpGw1BE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KI/uZvdCrjxQfhzTusMdf7Int4z9rguJAse4Y2Ea9ZwZ0NGLrbuKG5qhoZ5RJfg87QZcl+pjHB3twXdMiLTQ0GXjd4dSqqGYKegQTrdais9iF28RhhacPEkg+jqwtAyT2fi604P6MSg34dpCg61Lkaq68iZfbsg/R+295IHKNm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=gzLlHus0; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=Yw9ZJfCJ; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="gzLlHus0";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="Yw9ZJfCJ"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EEFAF609F75;
	Fri, 21 Aug 2026 01:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=M6KOTO/Yzx5fGq16R4FiHnakX6E7176KqWdrIpGw1BE=;
 b=gzLlHus0B7Jbu2PnrUCyAm8j1M+wZdf84e9AGSr39Sr/xNHS5dakofXTXXOMOWR4SXUE4NHq3cUeCThzvffruoIA7J2HiulaIJ23FwKJMY7IDRoZYKfhh3PH9n1piEnGhEJrwsvrJeVlVmcaLHL6Atfvnf0TeGbGKHHDZjI/cFowrfVAftFgBPSAlVmPDt9FKqMi4NXJRtaQnmS+Vzb4zCNDP2b44Fz7b3I3iZBzKLpwOYeErxPvXFAI0r708rySrf72f80EmRx8KO4+gABARgWquINIKWScKe/HIxrCrPwupJT0rN9aabekfuL8O/AAn2A1YQDq4x8s00NtQRErWw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022080.outbound.protection.outlook.com [40.107.209.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id ED7136C0071;
	Fri, 21 Aug 2026 01:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SM+xX8ETeR8bqMmLhqlCvS6HrdQoiXOdtz8g4cuIq5+8z0nYiyVj4HyY7/vbej7HHHVMzMeCpBxUhaqQcP5Pp0Faanho+HG7JY8bSQCNOuqA27pMTh0U2gmBtod7E0UnKv8knJCJTI2yF8DG+tv6bUGXZQ6SA7+Le9UzlZ/HooU3FMU/xD45xfCMkrBbtdbgIUC/4ntvpcAuD+imBKfl5pbeEyuPWuvhRVjd5BwKi3VBMkMZ3akhfXFIPhqd4YXuiVXqEidVUf0OdX1A8LOHoaWwBcq/sWtsJx41LH4L1SZTL2iW8Cng+mCUp9vHGpYwFXcitaA4SnSOGC2L0md8BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6KOTO/Yzx5fGq16R4FiHnakX6E7176KqWdrIpGw1BE=;
 b=aK6LUSCIt2pT3v4uumJoShCdUtBBdmyIlUFcsQhfPdFW5q1W2r8YZ4TbisuWmW7Ju8q9qkvIwzWxUPPnrqgZPUMppZvXTdcRE64J4Fa5wXLzSdC22jGh8IK5fixmf3o4FBm6Z2DuaJPT9RHUxSOkH9hoAWEVCBFAgYqDOHjO/TiEv23l5YyeUhOvlCc4GDJzw0rb8FVSetcjxv1lHZEtsMx/CRTE3XB/0l+mEwlRwXkfP0nNTY1mSucTzB7gLoaEMhaYJFMSe4KJ4/wyaegBMRvFR5iLxTEykbQoeDN8Js6IXM5VDrsoLVrxH5/Ra6yNRhi1Ykka+J/lFxTgv1xbLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6KOTO/Yzx5fGq16R4FiHnakX6E7176KqWdrIpGw1BE=;
 b=Yw9ZJfCJjZ/wRFgEcFlHz8BhdjICxj4vI2q/rtxTqcQqZpZiT78dbuoIYIQkPqm9R+fQLiJaTzVGoMzuZeQifoFV5X4utYkrYuhlGmxpuM6xw6H/2KY+zRj2rjXQtb4DCW7DSAOrvbBbrlOm1M0vibkKYuYOHHgzLBQiLmoWwingCODUpCY3NbsvRjHkzyWAWR4+ktYK7UJoRLKybHif8ACmulPAhoGetVIpmZcQLY5FEMREDuqGuMiQxjB2kG/ApM+OC59/szDxtq9fGgyUWQmsm+yAuUY6Pkh9fEpwgT6WtrC7A2W6zJsJylAsZyxvMD2hbb3BkGjTiG87igbYCw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CYYPR20MB6737.namprd20.prod.outlook.com
 (2603:10b6:930:c5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 01:06:09 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 01:06:09 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "ivecera@redhat.com" <ivecera@redhat.com>
CC: "jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "arkadiusz.kubalewski@intel.com"
	<arkadiusz.kubalewski@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"cjubran@nvidia.com" <cjubran@nvidia.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Topic: [PATCH net-next v7 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Thread-Index: AQHdLQQfSg/FkjsHkkS39O51qCIspbal5eoAgAFSSoCAAIBCAA==
Date: Fri, 21 Aug 2026 01:06:09 +0000
Message-ID: <20260821010608.96264-1-arouhi@sitime.com>
References: <20260815221919.64226-1-arouhi@sitime.com>
 <20260815221919.64226-4-arouhi@sitime.com>
 <6a529684-bd6a-4187-9ed9-bb40f4b98065@linux.dev>
 <dcbd4d98-8d22-405f-9ed0-b6e97369098c@redhat.com>
In-Reply-To: <dcbd4d98-8d22-405f-9ed0-b6e97369098c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CYYPR20MB6737:EE_
x-ms-office365-filtering-correlation-id: ae7c465b-5a7f-49d9-fe1d-08deff2062bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|22082099003|18002099003|56012099006|4143699003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 cypOVpJmWN6LvaQZvBmLSxHLlM/UN65ANSKWalJ0sth7ZeERj4coTVQAmBxd/BkoFwsGjAe+xhoXQ4nkmR86dJ04t2wX3rH/mGK2av4pirELLWCy8Ig+KRPWhIeAklo5ID6G2ezNC2f1HVTkDbwMj8IE9TOPk8aPLELpUCB/6edSeCjxwDDLxttmGu0qwVLFyd3rzqUIc1hciehOHUKK4AFjsimrI0er1IbFM4cyFdINwkZB+zAfXxrO2j21oMKpX4dHgmjt3mG8TFF7xolhuFZViwO7q34VURsipSJ2kBAssvXbHCikBRCZpLkk7Y+KCknewT5wP+EmLpynI3L+wgapyHdlX6cmSqza5gp8stxNpZvOT87REtFIqnIQXCyuojwrCSvk6TtPIDqr1M50ihWLvlEsFhcWxTxbKxjP8dwxU1hXkSlc5rbxuw2+nmgdqJ2l2zhtwMegFtswQqwcvLpuXPaeeCjW+1XicbHvy7MbbSQR28CHNKEPQx37d7Y9nVlWwgJRVHbJWWTbVWXxKgq10H2HDa+/KJGKT/HTvsiN18rEchPO+7yanSrRQ/ZQ0m/ZXFHuI0dm13zsr0oLVf/KevK6E9O/h7wBDB+4c1gdjrJjAkwkYEsplKu9ljCAaMVOPIJ29XAQQC3wzO2jkdjhGmXqtUYc3+faMASgIm/r4legltHpDi11aVpXvBcHOZAk+1KkTpc94joW7MkrfKAvfqvC7QhjLqWsv1vKH/E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEpFbStSdllWVURBTys0aUgwcFRRUFYzOGMyWEVJeFFHbUxjWWZDMlBCTDBm?=
 =?utf-8?B?bVhGUFpFQ1YrejVpbVlRRUJreWxRdGNnaTBZamhOc1dUSGg0N2I1VzdlR3pX?=
 =?utf-8?B?OFhza0ZXdVd5cEcyWk1vRHltYmhOQ3RKQW9BSlo1QVVEcm1ZVGFKdEZjUEN3?=
 =?utf-8?B?RnRHaW5DWnNCY0t4UTM5RjcrdXhTamFUemtpaURvcUQ5L2NtR24vYlhMMUwx?=
 =?utf-8?B?eGREVnN3dUJ0cFIxU2VBRmw3L1o3MldxN2piMjNXWFhodzd2Nm5aMWczV045?=
 =?utf-8?B?UDNnZlpNTFRLdWdrWUsvUTcwckhiQVN2V0tla0hIZW1vZmJjVitFT1Y4UHda?=
 =?utf-8?B?UG5NeGRaNVltSEVVNWdvZ0RDdk1WUXRUQlprWDRVd0xLZXZCb3FsNXpoZGdD?=
 =?utf-8?B?aG1mNDAzTFlRZ0pMeWpWdC9Jazc5c052SHNDcTdHa3ZKRkpKaU1tL1VSd0gz?=
 =?utf-8?B?L3FsVS9wQldIckkrYVhCSUZsT1BoZHBVTXhwbjdJa3hxaUtxS3FCa2FmdWpV?=
 =?utf-8?B?Q0l2YldsQ2xpN2hCNlhRczI4NThiOWFNVGdDYklndzhIY0kvL0Y0b3ljOE1O?=
 =?utf-8?B?czI3aC9DVW1vOGdETWg1WHJ1ak5aZDlNVmo4T2NSWTRKenhOeHkraHdaMk5x?=
 =?utf-8?B?dzFDeUlxR2hOMkhrdHc3TjNOZ2tPRHJjMnpVOWRwdkJJYWZ1QTJwZzlpTHUy?=
 =?utf-8?B?Y1UrVEpxRzBnaHJMVWthRElGc3YwelA5TkU0aWJ3ZEcxSnptdXZ6SnZlT2dY?=
 =?utf-8?B?YWpEWTlvQ2pXeHRvbVRFUFpXK0RQbHpTRjRDN0ZXSTB2Y1FxV25RcXhidUE4?=
 =?utf-8?B?THFlNGtiZHlVNkJIeTNqNjdsSm55NnVvSkIxVzI5b0ZSYThMTVJXQjc4QWlC?=
 =?utf-8?B?YWZuaDNaYnpZQUd3UlBoREJ0TkxKc0JVcUFJNWQ4amtoZWh3WEswbDJpMTBn?=
 =?utf-8?B?amVYd3dqWno2ZlBYYnM3Vk8rdGJoUkdYU3RxVGN4eHUxSlZQbVJLWDJacVFm?=
 =?utf-8?B?WWk3bnErai96T29PSmVXZkZQNFluT2pYSWN4TjErd0RDV1hYeG9GTmRpYnpt?=
 =?utf-8?B?MHkrOFVHU0ZyQlQwUkdWL08rTjk2ZEMyYzg5S1k5YUZLN08yUHl5S3dkcVds?=
 =?utf-8?B?Tk55OXJjWkhrbzVqUVpaTDNIYmo5Y1M4Z2FmS1lzLytxNERKK3U2QjlBdDV3?=
 =?utf-8?B?QkFiaEh6R3pXamVqYlFIV3drUmNwTjc1ek5oVmtZSXk2ZVU1eVZka2M1cjV2?=
 =?utf-8?B?SjZYMUpjSzhpMUNXV3RQanNMb1BxM1BFR29Rczl1T1BZK0N6L3o3Sk9IazBD?=
 =?utf-8?B?d24vWmFPS1VRZHliS3FCTFdvQUswY2xmVHZKVFFUdlFhb2lKRk5OQlFlODZ4?=
 =?utf-8?B?bVErMGJFNEdLRVQ0bnpxM29FdnBoanVaN2VtbWpuaS9UMUlIUmtUUHhxTEZ0?=
 =?utf-8?B?T203bElTd1krR2tjOFlMYmJaMWI1cXBvQUhIVDhHeE5sZzVsb2piQ3dPZ01C?=
 =?utf-8?B?aGIrMllUOSs3R2kzUkZjOUc3VDhVeStHTnYrYTVDKytqQjZsZ0I0Y2YxUGZW?=
 =?utf-8?B?YXFQRUZGWmFZM0d3NDYvTlFSQ3NCZXphZmNOcFJWQlFFZ2Z1a2VJelZTLzhG?=
 =?utf-8?B?VS9sMzZ3YXdjZWcrc2txVkUvcVpWd2ZlbWFMcmMwTURxU3NGeGMrWmlqNmNj?=
 =?utf-8?B?bVkwQ2taOEROeHB3dFNGZDEra3VHOHAxNTBMNGpMRDhTL21xeVdFY1JYakdY?=
 =?utf-8?B?UVViSERoaGJ1d2RjRlZObFhleDRQS2RiMEtPTStLUFZ3SkNEQ1VZb2EzTFNq?=
 =?utf-8?B?QjhxdWdFSE90MTNTV3BvYk9IOG5mY0thRXYxS245NWJaSFhVOUc1ZWQvVHA2?=
 =?utf-8?B?WWR2aUZYdFJsdHhTTGVWOGZ0SjVzSDZ0UE1GWGVkY08xYnIvM1E0Q1JWYzBE?=
 =?utf-8?B?dTdobEMxZWdVUjlKb2RYNjlWS2Vub3pBQjR2QUJxNnhmTVJtRXBOaXM2Rlky?=
 =?utf-8?B?MHo0SHI2enYwdk1vdExsSTROU3hMZ2VMZmZBaS9lbm9hSmpTYTRrSVNHNlp4?=
 =?utf-8?B?cGJTWllqckpMNjNkN1NBbFdmamJtWUxVLzh1OHB4ZUNRY3UvdXdRcnd6TkxF?=
 =?utf-8?B?TTN4bkl4UXpoQVNJVkMxNW9sR1daSDlrTVVvRDNSakE3Q3dJNHRETVA5RkFo?=
 =?utf-8?B?Q1NnMDBTTWMyTnNsY2NmbkQ3K0twSkhmMzh1YmZLbGM4ZUJiQlI1UXRGL0ZJ?=
 =?utf-8?B?R1dKYllkZVg4VHVoUyt0Z29WbzlUdkpyakpiT2ZhRUVWWm9oTTEvVGs0VXpl?=
 =?utf-8?Q?lNg4C3Oo8EeZkXginl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Rk8Z0N9FIisaBp79h0QIg5S9qszqG1efz2FsrFpS1PUk4riezPt0mp4u1U2MbdjOKi4Sda5mmoPNmJrzWk7tuoiM7rc5zfqGAOnE9fnPU8KxLGI3MlNESAvWEUbpbOVmL9rjxgsn8qadu8SfMT47xTMullKFMRImGXhib3E7eUSieXDvGMaBrYkmmlhrEfqedQczJdHezLC4Z+NiIhqU36MrJ5ctAYWDk3XHUbrQPUsygtooP6gLDt68AH2r/3V2VRxn47MScwZ4xu7EJMHehBXVGT9JK2wyPP7W/VbS6AaWy9avHFhX3zxCbMcPora7kvgIwvxDEgCIWVG877SSaA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7c465b-5a7f-49d9-fe1d-08deff2062bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 01:06:09.3426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UctI9N3b0SKw8MqvUzFxEO5YmZBFTYRukfDXYTUlWc8RxazU59v9k0LZ0pLWTbW05ArSei9VOz229utSwfjNYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR20MB6737
X-MDID: 1787274374-gb0pp-EBh-jn
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1787274374;gb0pp-EBh-jn;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

T24gMjAvMDgvMjAyNiAxOToyNywgSXZhbiBWZWNlcmEgd3JvdGU6Cj4gKzEgLi4uIFJldmlld2lu
ZyBzaW5nbGUgcGF0Y2ggd2l0aCB0aGUgd2hvbGUgZHJpdmVyIGlzIHJlYWxseSBhbm5veWluZy4K
PiBOZXh0IHRpbWUsIHBsZWFzZSBzcGxpdCB0aGUgZHJpdmVyIGludG8gbG9naWNhbCBwYXJ0cyAo
ZS5nLiBsb3ctbGV2ZWwKPiBvcHMsIGNvcmUgb3BzLCBmZWF0dXJlcyBvbmUtYnkgb25lKS4uLgoK
VW5kZXJzdG9vZCwgYW5kIGFncmVlZC4gdjggY29tZXMgYXMgdGhpcnRlZW4gZHJpdmVyIHBhdGNo
ZXMgc3BsaXQgdGhhdAp3YXk7IHRoZSBmdWxsIGJyZWFrZG93biBpcyBpbiBteSByZXBseSB0byBW
YWRpbS4KCj4gRHVlIHRvIHRoZSBmYWN0IHRoYXQgdGhlIHNvdXJjZSBpcyB2ZXJ5IHNpbWlsYXIg
d2l0aCB6bDMwNzN4LCBwbGVhc2UKPiBsb29rIGF0IGl0cyBnaXQgaGlzdG9yeSB0byBzZWUgaG93
IGl0IHdhcyBzdWJtaXR0ZWQgaW4gcGFzdC4KCkRvbmUgLSB0aGFuayB5b3UsIHRoYXQgd2FzIHRo
ZSB1c2VmdWwgcmVmZXJlbmNlLiBXZSB0b29rIHRoZSBmaXJzdApzZXJpZXMgYXMgdGhlIG1vZGVs
OiBiYXNpYyBzdXBwb3J0LCB0aGUgaW52YXJpYW50cyBmZXRjaGVkIGR1cmluZwpwcm9iZSwgRFBM
TCB0eXBlcyBhbmQgcGluIHByb3BlcnRpZXMgZnJvbSBmaXJtd2FyZSwgZGV2aWNlIGFuZCBwaW4K
cmVnaXN0cmF0aW9uLCB0aGVuIG9uZSBjYXBhYmlsaXR5IHBlciBwYXRjaC4gT3VycyBpcyBzcGxp
dCB0aGUgc2FtZSB3YXkKYW5kIGluIHRoZSBzYW1lIG9yZGVyLgoKVGhhdCBpcyBhYm91dCBob3cg
dGhlIHNlcmllcyBpcyBzcGxpdCwgbm90IGhvdyB0aGUgY29kZSBpcyBhcnJhbmdlZC4KT3VyIGZp
bGUgbGF5b3V0IHN0YXlzIGFzIGl0IGlzIGZvciBub3cuIFNheSBpZiB5b3Ugd291bGQgcmF0aGVy
IHNlZSB0aGUKZmlsZXMgYnJva2VuIHVwIGFzIHdlbGwgYW5kIHdlIHdpbGwgZG8gdGhhdCB0b28u
Cgo+IC4uLmFuZCBwbGVhc2UgZG8gbm90IGZvcmdldCB0byBpbmNsdWRlIG1lIGluIHRoZSBDQyBs
aXN0IDstKQoKQWRkZWQsIGZyb20gdjggb24uCgpUaGFua3MsCkFsaQo=
