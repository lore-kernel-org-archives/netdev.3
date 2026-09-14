Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3030E3AC0F0;
	Mon, 14 Sep 2026 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426859; cv=fail; b=Mw6N+imSJpjBNymTxLeppNSv3Xh0cdXzoi2V/1ADZPYfsuwvSBXO5xpSYTaXX6ZlLXui8542M7Lv+ObHzHBfQ0kOCsnzjidwFvey3egnh5bLZhm3Ny5wMB+dm4ImHNGzA7F5KOHi13NigNAJDU4dbXemBEGw5NiKRKJYv7Nj+5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426859; c=relaxed/simple;
	bh=Oo1jk0QwRsM55/mPIDvsnrJFblWPAZinmFZrEBTkyPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fobbn/3WjmnX8JZ3RxpNKzk0PAHFfC1gBmZcinm0WcVMAoJVFi8e5LywbOUdgCG0UYsi7OqEo3ITWsc2i+BG2gNuOa1+Kzy5ld4EEuyBoiz1xlr4UwmeXFE4Ke3eORghaZ5IhH4lCNzzBcRMqdvF1xmrku22bKSRgLd/mJ5QjmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=Elq12Dj8; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=GFqGYppq; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="Elq12Dj8";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="GFqGYppq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=zRNKooOQFO+/Z1kVMs7CRYnL8hniHq+DJxvzzvPnBBc=;
 b=Elq12Dj8XKU3WxVOEnSoTWuQ4Zigxdzvg1VgSNE3npwWc/bhcxt+qhwGL3Ui2zH3OTLhw4IUdN5ibHCvMD6y3+sf4yDvxENfUFVZx8f0E9gu/RgWH8FYeXEm8NiKNxyTiMneio7at66z5guqIxZY/ClilVPHnEXsNUzsJmqWemSg7NQdNyRjYo6j1/w4uBMqkRG4f29MJUQpBbrnG6eCTtF+NqFQVzoQ76LwFhIcCaOgJx3IkeX7jLCVYxfRLSYjGWQCDgxU+MM9uXk3LBTP6/tKPg9qOBSZ22NkPRsfFF4+bnBnLGscvW29OVR/6FloCfKYtQQ3VRUMmSK1h/JUJA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022095.outbound.protection.outlook.com [52.101.48.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 139BF800AD;
	Mon, 14 Sep 2026 23:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klcRcp61Ydo+C7iZ42zhrqsRy9qkuLg4NXHoGXUdExVAhk8Q0xUXOj05XY9U4JBKaqZC/yxIktkTvqeA8FF3V+0kn9dXYyANv7FFfRXGEzCU3yj2STbe//CeG1plzxCV1UM0eIuM8enU7PBycXBWF3wmJfL0qKbYa0eo2jP/vukHe5JDQlqQkQj3eVYDF/8uslNKcPx/P6iIrUUGEIvl0XUkEdqbjpU3YTz48SVYSr9SjfMVRCBh2LCjt783WLc/HKHyUz5VcxmXh4wH0wXqZpJfneJJae/2ZJ1/EnKQR9k8LGTJ3zXwMMNxEz9f0JievAZCwci0yEVZ3BNP9q9LiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRNKooOQFO+/Z1kVMs7CRYnL8hniHq+DJxvzzvPnBBc=;
 b=WF4FgHnd2lz6Q2AR+qtz+WudWM0lOT/im+T/vAtT+50cihZqxyuZasgU9CspG2CDYcjBQ5vbCXPGPCW0N8FAxi/8Ghwk6UqqCl71DwJa/6xUljkIssMH6K/RhKPi+uU2IcnqGyO+WOMBhnuJ/qKJBpDv6R579VY0GY10ilBPWH9vWGAha1rLrTz9DcCjWW6fKZhlP/1wClFVerLzy0hMrHLnPg/W+TJDoCAD/Cch7u8JlCvxTV3m+H5E8NVyzzVRKvjhzI2tbFm2Rip9WbPEP/NBh/VMos6V3LxEJftzAHU09F1edIB2BHqiT/sly/GVRz9rVx6/X6WvANRIAXVwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRNKooOQFO+/Z1kVMs7CRYnL8hniHq+DJxvzzvPnBBc=;
 b=GFqGYppquMju3RgjoROVBWWHhrqzyMfraueUutH11POQtOqvT6oWPeJrg0RofJqOQAogHKy+Bqji+913GS9VdHwKdTm45WGZab8Ubgi8mWJCydZN8xnfwcBYhDbBocrS8YCFkRXj1a2/pljFdJIulaXpg2h1kav77y44ck1HJdhPyTQ9FUO9gKCzI9FMaoR0y0YDY1LJj2T5zPY3jw3DSizEqeCEncj4GTi4c43JDi+nBCRVuPDwasijQ12NUvAP9q6v5wTSay/uUqT0F/Vqh29VeEiY0+Mw16wnc5PH1Ik/REm/cynbstsKYjqcpdW/IFM1SgXhImEvk/Ejw9G0qg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MW6PR20MB6839.namprd20.prod.outlook.com
 (2603:10b6:303:23e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 23:00:43 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:43 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: Ali Rouhi <arouhi@sitime.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v8 12/15] dpll: sit9531x: add support to get
 phase offset on the connected input pin
Thread-Topic: [PATCH net-next v8 12/15] dpll: sit9531x: add support to get
 phase offset on the connected input pin
Thread-Index: AQHdOyOxG8v/E+U7IU+jkp/1mUdhobbEqZAAgAoZ1gA=
Date: Mon, 14 Sep 2026 23:00:39 +0000
Message-ID: <20260914230034.63861-11-arouhi@sitime.com>
References: <178887152665.219967.3620325573196534009@kernel.org>
In-Reply-To: <178887152665.219967.3620325573196534009@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MW6PR20MB6839:EE_
x-ms-office365-filtering-correlation-id: 99dc2e51-3c16-4090-3e69-08df12b40139
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|6133799003|10067099003|56012099006|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info:
 WnHyBwm2EB2Zx5K/SdpMe+V1tnjAqamxIexcpPRqRWKWg+Wo3+wcJo+6CnBA6p2/kjoUjCooRNJf28a7ov9gR9eZNfIajV2iTY97Z9rneVcujvD6HhDLxfK6fDxWSeYP99mbXXONC7/pkRTGxsBmI3APi51xibX9td7xC/31wdAvpbPwGhUrlUXsx0rTkc0zSNhOPvjD5+KbzjzbbtqAkWyPhFEDyDhIAf4khbYGBWHG1vZsvcj3MCtzqS1xpyHB1JRfp84A7W2mUwtF4qetHe096DQ8YoYkzxVD3lklbdoSrzl7j24pEflSrbqJv23L8GVqD+/EEAHFDxtNIAoNIOvdiUgzMiOe80VAXMLflfLIDzd6ga9QjN3SlzKGrjMiHVrddIK3HU+RkOVBMFpIRoaBGyB/3m1WADe1OHegqSdrGZHRFo5P66YwVLR68c6LwOT+ld5ZddVkG9WGhbfOqfw9kDRqXiJ8dxrk1chr0iGa+NTvpauWMojiP9yAhLFd/fltNsnYwz7k8xORI2lbnIwqD9zVPqGAeOHz8fVCzwdAyg43O6+4WBamD0zbLubl7iLOd1Q9JjMiurRoPpc8UaJk3uoRffro4ZuwmtdDELaFP39rzdL2MzN7XLfZ6RNrbIn1iZf4vmWV2YCgtcL8H/YmPkhl4FvEbS49lkhn1xM5zK8IpXasHowMgkY5GfbYAqOn0zeVj/vwJOqOAZspTAloyjnLHxzwo/M+8FfesnI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(6133799003)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ThKOUXUY3sFbRA4CvRWrDs3G3ZPnwTlF2WmEz4mUMvGHmBEmKswtpTbOEt?=
 =?iso-8859-1?Q?m6gabIXHvdG8PCm0UWnyUGbd1csSrqnlTmipVogVbUahynzqS8eRwC4xtY?=
 =?iso-8859-1?Q?KCkkWDpUdMA2M+fCetOQy5IXEngH4K/hg16y4R4fOfgoKCg7FH9Ut8FHdJ?=
 =?iso-8859-1?Q?Zn7R+MQocMWC+hU8702+dHd4obEZ02ZdUran6dZyF10Kip3Dpcg5dl54Ei?=
 =?iso-8859-1?Q?ns7CrZm7VUWUVjpEOYi95UHDhdbSV5Mg6d3vwJCFEadUgpj2Tmb1x5xLIw?=
 =?iso-8859-1?Q?KBLElBQKs9GUmr9IW189hXnIkjBikEwcAv2wJ71+1et17wXW7gNCDJ5o5N?=
 =?iso-8859-1?Q?uvR+oo/44NvJ+OCe3tL+54GKVuo/5Xt8t39rEFHcPuQHu0QSK9D2jwPBXU?=
 =?iso-8859-1?Q?NpD30BAPkasrfZNhv86lMn2Pvj5670qAmXtw1cIgV6O+ChiT39KzQZXrru?=
 =?iso-8859-1?Q?fFxZovNvHXNqv1mRo1lMqWwp7uQyWMTp+BlmBXoAi7Bdtmis2oklaW4197?=
 =?iso-8859-1?Q?Va1v4nKZvKv/XiJGFsRYSOKVBu6b6IkrKDsjkOuJIh6kZdCzh+0Fm2jtw7?=
 =?iso-8859-1?Q?DUJmM07Ivq34VII12f/Ks3xmarPptJbxNQXVCgNnCHAFY20XNHJ7g44AGB?=
 =?iso-8859-1?Q?rQPwmj5EQ6hGr0c7YEdfF3Nd5ubxhWByLICPEvUq2aOfPigveJWqhAS7Jp?=
 =?iso-8859-1?Q?+7VyaPMnQWLFr7F/UXqXuOASV4kL6pw6pWrJsZdYYQ38xS/Ls6IueyLzch?=
 =?iso-8859-1?Q?MaAlHcGgA6barC7wNEAabswrnCNPdsmyW9wPs8sBlztX56JIHw1z9KO/LT?=
 =?iso-8859-1?Q?Ix03HIO//PCPTBicIki477Gw17kH52/EcxZcGGlwsPds88TE2GUjbe6EYc?=
 =?iso-8859-1?Q?AcX5FBWCp+VYbYi8CsU0S+22J5JEDDehbnvxa3YQfdkDZRdLZEb3hto4tY?=
 =?iso-8859-1?Q?HYu4qHIzkOKV4vD6nBh2Eu21JHrhh0kQ0I65bIk5gkXT7Geb+sXLKHm2JQ?=
 =?iso-8859-1?Q?znCLJSUpi0w4vTEI5gMFhnB2L+kIgggrMj8fQANuP8hJ4A59G2dcMbxa3/?=
 =?iso-8859-1?Q?T9cVVl2wPqHyv0o2VLHYcFjxNAMSYH862XvrB5z3OIs8NnQT63F7v4/uMo?=
 =?iso-8859-1?Q?RLAVt/Cv4Lw+shPU+O4YflTXKEOVdWc7aBvW7IGeyLrNtUrTBoNhgiAiOm?=
 =?iso-8859-1?Q?7idr4HqwXA27PrLxJp/OkEJzLRjq/IT/EjnimzTuZV/UiAaE3lJaL89m9Q?=
 =?iso-8859-1?Q?uTtM+H/A1FcNNF5Co9CuyMh4WmobAJw8Qes2h91HcUa4yyjVGb3G9xRjVJ?=
 =?iso-8859-1?Q?bHmEkciNM80ZbpxnNnRdvjhhtMmOjUqzt0y8MGD8KY9drRWW63/J+m4vFP?=
 =?iso-8859-1?Q?vPg11D9pbtaXzt+RxC3tuIeGOaQI+qNNkYHddOkTtsiFgENlQyo8kELzLj?=
 =?iso-8859-1?Q?2L7c3pDe6flHtRj4EwpEdznORtYGbsQjp7bRco51osifBYJnqfnawMHK5q?=
 =?iso-8859-1?Q?bDP7Ec/G3iHHs52kZ71ZS8WonNCiPouz1MjWG/kg5d70jiUYLor0MnwnsR?=
 =?iso-8859-1?Q?yyxhtAojCc68Iw5GYqEftfLhAg3AWZnFT32DafCWoZ+xHJ7IUyebNMe7mU?=
 =?iso-8859-1?Q?AD2UJb2g04FDdQJIN3xcweFUctVSrlGkPKK4QiK5Twc8bU3vyVfx0NqNM0?=
 =?iso-8859-1?Q?mfToTiZbbisIIvIeABHlybTvHUH/NTWR05Dm0kYNazXvZCRmp2SdHhXgO7?=
 =?iso-8859-1?Q?TToenXG2ovfJsFgkB+J8J8uSGor2dPcAAcIKEPmg2O3Him?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	d5W17cGTzVrcvuqB0PmVSFOMPV2DTp8HCBGVzdQSY6LrOb8saEliPJ+mumvVk/DEhPe8yNbzaYA54ZL3Kf9L+qMnshvM44Wz27GjXw9x1uaJ+VN6akbc7dKhV2SM6WIkZokSfbWm+4681Ls5ksYdgtY0GEsRSdGuktLrD+2ddcPmSJVNPEx+SjSIspThSfxy55XNwugBB56h52XnyxlmktJ7fNkxPGlQk7gtVFE4WZ8Aas78ivw2VvMKIjWAL6dL7yoVxkwX7kkQJMzgOUGIJ6qsovUWst+hjP7SzlBdv3/vP5Zrwd8NH1RbdZZlpKsn7qbW3+9Vk+AnD2ZKIuNu+Q==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99dc2e51-3c16-4090-3e69-08df12b40139
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:39.8702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gl7F3JNOpPhPvhkE/VxvGHQ7aRx5LsCZOkZTKZPLQ+PX2mEpkBsPdS38Rx3HBfGRQFAphOPVIBxZbaRjj9nliQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6839
X-MDID: 1789426847-CLilN1SlNH-u
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1789426847;CLilN1SlNH-u;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.=0A=
=0A=
> How wide is the TDC sample meant to be?  Three places in this patch=0A=
> disagree. [and: the 0x07 is the only unnamed field mask]=0A=
=0A=
Fixed in v9: the width is stated consistently (code[34:0] plus sign),=0A=
the regs.h annotation is corrected, and the magnitude mask has a named defi=
ne=0A=
(SIT9531X_TDC_MAG_HI_MASK) next to SIT9531X_TDC_SIGN_BIT.=0A=
=0A=
> Is "Fvco=3D=3D0 means DIVN is not programmed" the only case?  [bus error =
becomes=0A=
> a successful 0 ps measurement]=0A=
=0A=
With sit9531x_get_fvco() reworked to=0A=
propagate read failures (see the patch 08 reply), a bus error inside the Fv=
co=0A=
derivation is returned as an error like the trigger/data read failures, not=
=0A=
published as a 0 ps measurement.=0A=
=0A=
> The comment states the conversion as tdc_code * 1e12 / fvco, but the code=
=0A=
> truncates the denominator to whole MHz first.=0A=
=0A=
Fixed in v9: the conversion uses mul_u64_u64_div_u64() with the exact=0A=
Hz denominator, removing the ~40 ppm scale error; the MHz truncation and it=
s=0A=
overflow rationale are gone.=0A=
=0A=
> Where is that debugfs operation?=0A=
=0A=
The sentence refers to a=0A=
planned debug facility that is not in this series.  The comment is=0A=
reworded in v9 so the rationale (a netlink read must not freeze the loop, s=
o=0A=
the callback reports the closed-loop residual) stands on its own without=0A=
pointing at code that does not exist.=0A=
=0A=
> If a reading taken in that state "is simply not meaningful", what stops i=
t=0A=
> from being reported as a measurement?=0A=
=0A=
The gate the driver applies is selection: only the pin the PLL is=0A=
actually tracking reports a phase offset (others report zero), and in v9 th=
e=0A=
FFO getter applies the stricter full-selection gate as well.  Whether the P=
LL=0A=
drives any output does not change the validity of the input-side TDC residu=
al=0A=
-- the comparison is between the reference and the feedback path, not the=
=0A=
output drivers -- so we do not think ZDB/OUT_MAP gating belongs here.  The =
v9=0A=
changelog describes the measurement's scope.=0A=
=0A=
> Can the pin the sample is attributed to differ from the pin the TDC actua=
lly=0A=
> measured?=0A=
=0A=
The window is one poll period (500 ms) after an autonomous=0A=
switchover, the same staleness bound every cached attribute in the driver h=
as=0A=
(lock status, mode, LOS/OOF).  Re-reading the active-select register inside=
=0A=
the sampling lock would close it for this one attribute while every=0A=
neighbouring attribute keeps the poll-period bound, at the cost of an extra=
=0A=
paged read per pin-get; we prefer the uniform bound.  After a switchover th=
e=0A=
next poll corrects the attribution, and the misattributed sample is still a=
=0A=
real TDC reading of the same PLL.=0A=
=0A=
> The value cached here is in ABI units (1/1000 ps), but the field it is=0A=
> stored in is documented as picoseconds=0A=
=0A=
Fixed in v9 -- the field comment now states the ABI unit=0A=
(1/DPLL_PHASE_OFFSET_DIVIDER ps).=0A=
