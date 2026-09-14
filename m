Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3112371D02;
	Mon, 14 Sep 2026 23:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426853; cv=fail; b=MKEmAneUchkDMDt3HpITnx5/wHyc/8pZJvWmEyUt+DmC/wHZjpokuvBYndAjDB4ASqh0JdqBj1nd/TSSw1+rneQONPhITtEhWWCpOFaSHViDBZvINItZ19UwjguMT17R1aNbdWkjlI9k9SjhvDZXbgbOpZBoabOczysO5r3+XI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426853; c=relaxed/simple;
	bh=jPHxNHAkiGTF9X/ZwpnLWBviRKOFpQViWcYP2FIxBGg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QvzpFqDwiZ5z4vAoEy1go8Yyn7XO5Toq8Qk7QTpzAC8qwjskvqdI6psAzYGezhhU6Z6h9IA1Lx0XygFE4rnx6RzvsCgkoGDroTwjKZeT3B/QpF57Dd5Ch1Jv/ydnGNrxLCDD9q3bQKPJiY6Qy0xwbr83cy6vP1nFKclCmUBPVoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=A3B0lsEP; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=ipml0usI; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="A3B0lsEP";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="ipml0usI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=WJJcw+sRMlJkplXktSjkTQEftO+k8YaJa2+F+I6d19o=;
 b=A3B0lsEP9GyOTU7PpmzR/mbGdAvWlgUHY5QvyLKqt7AHR5cFVAU2jWs4T+suMK7R4ybTT4M0A7mEK6nZDsCEso+bK7ggM4oyPsWn9bD9tTWxP8YzSAy+Num2wK9Twi9T9MC5E9noyKT6ovFSmrdVRg1orGAuZz3POHgMpqyjyHE1YT/llUpKHqO+6UUFMoAOuaHefVUR46m0hh6i7Jpp0Zw8G3+fXPJrWuBERhQZfYcrWlkbZWtLLGsVySuW8+OQlJe0PsVbGswmQwKNhVTpJLgYDnr3t6jxBLafDQgQy/gBDmra+3mZpKMduJlZK99h2gf+1mzxd7/h+3QdrvKh9Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021110.outbound.protection.outlook.com [40.107.208.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2D632A80066;
	Mon, 14 Sep 2026 23:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFMQHF+VDpsm2kFh3F29SIfp46/JNq15goeMgNnHZdOgDs60nETph1Mc4CjlcsIu3/t+9ReVrnVRlQnez/yWHdrw/Vdp/sMivE3kL0wY4hii6EZn7yyK2bFsxFJL60EOFN/j/fjAbmbe22BaSczAaAzfY1NJd6WUiSSFSYcXdCZUH/LUg++vJL7F3cestXrypeGuEx6t3HLyExJna4J1z9p56v8a/qH5tj17aqErzJrusY5BKrwESLX+7VdhL4v37OwKIcc9fYJ5oib7cXk7kYNi5EHNDE0IWn2mRDqd+mm8d3+Wkx3JRXlCW4vDtFtz+8jm6Ur0UEXbcOCMEEePsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJJcw+sRMlJkplXktSjkTQEftO+k8YaJa2+F+I6d19o=;
 b=y9fOynBO0nceTauWTFHhMTAYO8Zs+mzCVCFFY3Il05MmpXkYxUNuRogke+TlfhprELlGOARkFea8rTysF7iaLJi6UMaSo0vObLL+tJSusfY1QBD8CBxGCxY2QFEEbytdjVcAR5ET4adQBdPEKfKCHLhDtCQpnhhpD03pyL6IaZwCegUUzPn/S8f9F8ZYRemlQ56EQ99OADf7vq9nBRfCezkovc5y5M4Yjv9Upgv3Cs1VMtfi3j5n7zszYv+d+Eg/znsqWO9OAbN6YvLOVhEhIjxMduG0vnrGvXsebvDNpUnzch/pgNkKkjwY6ItK7uHwsjWqFvMV/kS1bWwm0efNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJJcw+sRMlJkplXktSjkTQEftO+k8YaJa2+F+I6d19o=;
 b=ipml0usIih6VQ71CkU/pGRsuomO+0xt9aPUdV2ADqdALbo5j2Kov48JLjT1vYotr11xvnhT4CBZDi0EUXclyPLCzjexzDgrWxYkygdugPhuZ+GYxThuyRSGbXZ1yJK/naUbDE9DkVRrilaKqYV8LSS+W8CaWmWntz+MG449ud6jLXtLY3ZHZjbvpG4zcRPu9WttA8+8ZSM0L8rsx8hJsARxeUbjStu3eSgKwCKjv9mzD3KjyYvO+ktbU5DEwcr3uu94NKo7TH0PBlMPZXH/NfkaJUz4vg5+G5NoqbJDSNSTO5ZfHLHNlVWSL4xl8h9GyZzPhzs3BO0nt4kTHwhqi6g==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by MW6PR20MB6839.namprd20.prod.outlook.com
 (2603:10b6:303:23e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 23:00:35 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 23:00:35 +0000
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
Subject: Re: [PATCH net-next v8 03/15] dpll: add basic SiTime SiT9531x support
Thread-Topic: [PATCH net-next v8 03/15] dpll: add basic SiTime SiT9531x
 support
Thread-Index: AQHdOyOu5s1ccX3ED0ePRcFt1M9LwbbEqX0AgAoZ3oA=
Date: Mon, 14 Sep 2026 23:00:35 +0000
Message-ID: <20260914230034.63861-2-arouhi@sitime.com>
References: <178887151007.219967.1063342347409203849@kernel.org>
In-Reply-To: <178887151007.219967.1063342347409203849@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|MW6PR20MB6839:EE_
x-ms-office365-filtering-correlation-id: 7eac797e-3aef-45a4-981a-08df12b3fc77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|10067099003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 Q3qABRya1v8kU8rz5jU1hhfIawIVsJpViG4/p3cE0b8zp7kPV95oE/PmBBsTHqlrUU71vKb4uex1hZEqpL3sZGO0c1ptRGyH+V+kWmX+zk5nWKAb5N06shmgDW7ULABSNSuaEslwr+q/dJ1JJQ03HZdfkLSih57m0dbu3EEWw9Z9WcaU2hb++HG9yJiRa9YQy/jjgmBBr+E79rwztb2cfOGo7yVPofIpoBKeE6lX1XHUVYh2yAXkw0QBGzRSO1EWOpCGaUQomaksiKWIujeyS8QRG5z6feoIYXbnhXJVwQFGQztmzCESFtx5WW4GCQwFnN+1cQwPz/FK6RLY81gS+cMmGQkn58wtMmmHxAZm75kTeuK4tQJD2WWrJeBj1dgL15/JvG+U3dBI6im3rwYGjjznsNQi8QXUcoIymYEvCZEqcfCGngsGO+z6nsdvyv5c8I3zUoR7ru6d6pAVIlIL7CbMRYkt9wVCIMRmrqGfU+TqLzf4IZvQlEdYhL1+nksyYVm/wbF/oS7MipiXo1cqc5ppXdKjdZrMeBxJOedSDw2ph5i57mdvUYyQRIY9VP/LeUcPmgWgjxIEFzfYk5uNuUjBy1LR+aHd8iG92Gt7HnvvrDS4xZq5kKyhaB/yjll4YV73IsTwRuaLPNBCFYI3U6ehYCOIMhbx0xempFz03eA6n+4TENvkOsqTT8Nepm1bQA/qioe4ctDOUircF0tFzV+l80knAahUGCU5MBhXVDo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?WY885jyBGP+Fr8csU8ATPwtWEzZ4JSs8ZbD78NU/cQYbb6h4hfh2RdLe4L?=
 =?iso-8859-1?Q?cH5UoVTNhTqljE6U48/p71uQb6Wqp3ggwhEv6HPEkR7oGtJUUUpSxXRCCW?=
 =?iso-8859-1?Q?C5fwWaUwe5sixdjbaZSFeMcdsl0DgIXwgUdMey3m2BzVXfCTfmKc4QnYqV?=
 =?iso-8859-1?Q?V8BvMlTwouCxuPVZexEsZbJuW8jC4j60YZ1k+P3rAStR7B0NQUww+mavMT?=
 =?iso-8859-1?Q?BQD3pbGjc3ZQPvQBJ72uAY++7KyMiWs62pASnWedIv9Ww7VTVtAwxv9x6c?=
 =?iso-8859-1?Q?Gfxz0Cinm0qMoNo5ANZT0rWOYfuZUqmEW1C5By0KQ9PKv+YL5+cARHzohx?=
 =?iso-8859-1?Q?KTRZgaH+kRGIEu+YC9dhma7OTjskV+g7X9JdHs1FkEn7WtLMPW3DU1qPsH?=
 =?iso-8859-1?Q?ZPTyNY28wFdrXilMVrCq5F0/gPiOXlgK1myD3GMqEwOIsyjdzFvdulTXXi?=
 =?iso-8859-1?Q?Tqq5RoMnWWQabsYiPLeMBtwmXP8ivSLa6bZ1innnkmCALcpz/Q9Dnx7TJb?=
 =?iso-8859-1?Q?ZLlqD6783xIJhf0r3yiRs61GNmOU5Q8ctQfy421lNtYWfcujeS5z+aPjhe?=
 =?iso-8859-1?Q?zDo6iFLir20V9yQgU8eNmuSLShBAqhhwrfEyV6zqa3jM10/FK0n2CJNrqO?=
 =?iso-8859-1?Q?EVk4ixfE4hA9xTKPEMo70NPxjoqVoLA9oxbSjH1v8YPGvcKqlNV5cX9VOt?=
 =?iso-8859-1?Q?c2p60DaZYvlSWxB7LFsERzQJQyuya9vo2S8XT7cwBjUB+sq8NmhOFgjXUV?=
 =?iso-8859-1?Q?8O4R39/LSg+3MFvB9KEHJFbKCJJ0aBvqM/cBtVYHsHLqk+Taz/yXas3qYQ?=
 =?iso-8859-1?Q?7PePgz5lsXp+8i/yx+RKiAqvDAluWJRjnxSNqyegLRdOSLhzfPN2b5UhoE?=
 =?iso-8859-1?Q?fsVm7zsir2KHVuQsoJY2zdG8jLRBhtoCeb4g7o25U+C1n9/PgyReoWiYMY?=
 =?iso-8859-1?Q?r2+SkaZ3LJ2RIwnP+emAQ1+sFIM7KJvZGaL9KmbsEufFvXP089ZcIZjNkL?=
 =?iso-8859-1?Q?w5SC6+1+enocNyRx6t9MxbGvHfCMNTYrgcVO4u8efsBihnyioW8yHm8G2y?=
 =?iso-8859-1?Q?opy4TAe4hYJXc9Iq2S86n/SJaaykTHTIimJpmKz0biw3elxttX0V6kTj1M?=
 =?iso-8859-1?Q?5g1107h6wdfjhoqcV+OOzmZUnCLbV4u2t45QQPGUp5Ykh52tH/Oi8cbJrU?=
 =?iso-8859-1?Q?aN7g/wUlssr+urkpAZce521HETRQiJcDDkfgCdKiDn4WMQdFgijqFoMGRU?=
 =?iso-8859-1?Q?qHkq05HcEbSuKZpG6las0FH75RceAAx6Cjl21Jp4ioYtOGEOK733Ye4j5z?=
 =?iso-8859-1?Q?C9NK9euWMur2EiRFG8upnJFJAIGCwOWN7KKnRspSgNDvhOvgN7I7cOERiX?=
 =?iso-8859-1?Q?dxS/GM8u8nNZaMUko9Z4094lrXlw4Y5b7+av1tg3AJpjPKaZYxJC441em7?=
 =?iso-8859-1?Q?0ryt7pgUz4fr+laDPmeyWp9RqOlZCPkSGhxt7NIUlDlPZF/dXVe84if3o4?=
 =?iso-8859-1?Q?pNlQriXa6cmZkzav9HtQU30zj9suY6l7F34aibEZmpcx9kMIENriq/O+LU?=
 =?iso-8859-1?Q?3aC4nnyszYsGgcWqUj+ez7XmVHebBiIBjOfpmJrHmvJh57QOKWDU3sdGCC?=
 =?iso-8859-1?Q?zfClp9V3TxE1cwpn6wMLqdXlYKY1KRYlTAOsdZLAhJSFEYLXWMNOWUNrCK?=
 =?iso-8859-1?Q?fu9zRCOSzgbMqHgaCDEfJcYMml+puZ7JxMYd96rHojxuifLupFCbJ/d5C3?=
 =?iso-8859-1?Q?PxnbIwESIbnFX22ilmVH1nFphCkNIWIA5CCc8a3Qo4e2/h?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	16MGdGY6Vk7bf2r+nm1ndJQVW8Yhbr3XJ+aU+/o2hGUScqb7EiE6rKcJIal2ZudRSdy/+OXpyjejlmS+1X685YIv05cQv8SSmdfg9A5g71B1xnjfzQ+u/GqRBfmIl6E4PaQHmxG8zQVx1UGEE9HrshBp/8PV9TF71T+kNlS5hcc9E2d9WlOjOn1Da1AJvQq4UNBB4dLfuguZfmK0s4D6B0aoCZd1zTgZsTgvfyXYirxvjwM4MrVirND5YqgQo3H2m8Yx0DhdMvYFhiEWXj333cBXY6Vd/6ys5OMmGhSlg0TU75Ukzzvhh8DWM0B4CQ0s2QH+9TNAsA3AKXWOWucqug==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eac797e-3aef-45a4-981a-08df12b3fc77
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 23:00:35.3676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ibDmgvoOQltQt/F6g4aLo2o28JWTXDqjctuS1qD8wpuButkp2WCDfCM1dnkud5LbDtX/OyVd3XpXHLCrx1CWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR20MB6839
X-MDID: 1789426842-DPHVn2kwoHUA
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789426842;DPHVn2kwoHUA;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

Replies inline.=0A=
=0A=
> [Kconfig] The later patches in this series do add the DPLL device and pin=
=0A=
> registration, so the help text matches the final state of the series; sho=
uld=0A=
> the Kconfig entry land with the patch that implements it instead?=0A=
=0A=
The Kconfig and Makefile have to land with the first compilable=0A=
module skeleton so that every commit of the series builds standing alone.  =
We=0A=
kept the final help text rather than rewriting the same paragraph mid-serie=
s;=0A=
until the registration patches land the option only enables the probe/detec=
t=0A=
skeleton, which we think is acceptable for a series that is meant to be mer=
ged=0A=
as a unit.=0A=
=0A=
> the comment block for sit9531x_input_get_regs() describes a function that=
=0A=
> does not exist in this patch [...] Could the comment move to that patch?=
=0A=
=0A=
Right -- the block belongs to=0A=
"dpll: sit9531x: implement input pin state on a DPLL" where the function is=
=0A=
added; it is moved there in v9.=0A=
