Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D72C11E6;
	Tue, 15 Sep 2026 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430432; cv=fail; b=Kd8MkL2epMhFUy22sBO55fFuvrSXj+cS0PFvqqWBxhTexGuuXTZzVVIS+G6GT71TP89Oe1pjAFuzYbDrJJtV7R/qXZsPZQ8fedG3O/SuZOpaWdP6t3holAIhEwCEVy0G8uw////lvUbi7c574iSolWzhMVLbaT7cwkqIX1uq7SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430432; c=relaxed/simple;
	bh=0zNZ991taQgt1Yhz6t2ikxbkk+JwzZum1XcOyDPh1jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BoHFRc89puaGujhknSOR4fnXrUht5nMxUOj/kv/vbwR9HjfZ7Yw5yh+1R6DSx1UJNaRfi+FFfoDOLo1QwwE2G3AMiELIJy9NZsyGSWF04vhGq33Wa0X9BHCsLeUdKYGAdvyqk02rfskXCylPNzVZgc2rHHp8SW20BPHxe61a4Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=o4VNW+kN; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=dZv9OFdk; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="o4VNW+kN";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="dZv9OFdk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=SqxjNHAVOGB8JTu0R5MdCYMloavFnVtZOrxBfopKwtQ=;
 b=o4VNW+kNIYGE5A5XqyvYx9jAU31M5hr3XObmXu1tPZYx8P2l1Dtd7AKeCKRryALZY+GubqnQA9cuY7NLFZFJH8MPurnLTzsesZI7WlAnLnxVYEQCMqa0wOZZZqfdqKKKxoksop/59KzMedQQc/y7tjnFhW07G8070oxYPSz2R9ubM948yl7YSoRKEOY5oYoXic0J5oHw6YYK2jn4ADDs/n4dnSIlfpqs9tRoCnvvv7UcS7kCiP5fwAM2gXWX6nw9pYIKy1/NS3LKYmYdsZwq8xMjFfGAZiijrPynxS0dfJ6H94JzZmZfK0LpJjtUoWM44sp8dL7ySdbkEZKQv1KiFQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021084.outbound.protection.outlook.com [52.101.57.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2A709100077;
	Tue, 15 Sep 2026 00:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awD6lyrCyO01yShzfjZnkIyGYFt22C2WhCMkhArM2RvVg4EnYq3MCLmR9L1FYfsmYy7OW7tnsRA7z9OVk50ooTHMhWJJ8eddL93rWiBBuXBX4jZE8aSn/8I5iMcQ8brP4EY3cq0tWv5spuylxV3YuCCCHB0RPMn2AEP5zunE8uQL5eVB7DYj7hexKiTkrbzjklUpuSQRoEl/cSBBPiahGh/xBle8/TIjQDaZtFldTC2QWTBIGMXWczreOfB1dgLWape6qKuDG+inV+lpw7lBfg6X6JZwseo0A0sg2dUxDs5pMQqUg5KDqrgXjEgmA5xSqZPvULUXXwVaJcz1O/lzZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqxjNHAVOGB8JTu0R5MdCYMloavFnVtZOrxBfopKwtQ=;
 b=TxZAoFzj9kBVavIeEOZ5of5ezrnomm6gU2eUKowSIzASbha6+i10WA435hCv4hCxH7s2oy0gdEXOQ4CrPzFmgiWrWQQiGzSw/nCB1W1RhS1I5kLvmAUs9ykIlH/F3hx0O03BFY8xpQRm0JtdQd6uSJEhif5rTsQSvJH5Xu5Vmie+gKmvkrl3cunkFbIIcfN6FRKMXR1MfYiqHMEsX2zkGVvPNuMmNY9kZxZCLGPqRMZmRKA57YAfz/wcXw5sBct4tJ+hSs1+zT9nt/xCnSqRAwTrsMyYiUHLDOtb3HfJvcczlB3wDHcf1ctaIl0Xt1mR5v+m5tRajTImW4vzlh4j7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqxjNHAVOGB8JTu0R5MdCYMloavFnVtZOrxBfopKwtQ=;
 b=dZv9OFdkuFxC/Ho7nym/p+o2sJTI/NGNPyp+S3zNgyeGs+Ft95O1rcWrJA6xYctitFzaXSQq6t6SNOPy8yU7u/Urq5SuYWMukmk7AEKwQTTjsS+OjEkChguVBDwW9s7khAAYZC3MilBSgfjcTEw6GZaQoJKS8nPUDczTuJCp182mU5Mn5uiW1WLd/v+tX/dmTmKybtNn7nOlcLggW2fl2RUpouQFARDpKK/6Jb8i3e7trGZZezUBO0t7POoy8eNJiGw/KR4rX8MOhYPNCOXPbhYHEXZi8XnxQ1JGZKUbq2aGpr6mkYJoTu0wz00oHpmBvYRt3+3eoT4QlH9gKfi+4g==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB4277.namprd20.prod.outlook.com
 (2603:10b6:510:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 00:00:20 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 00:00:20 +0000
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
Subject: [PATCH net-next v9 04/15] dpll: sit9531x: read DPLL types and pin
 properties from system firmware
Thread-Topic: [PATCH net-next v9 04/15] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
Thread-Index: AQHdRKUxVgelaNcJnEeLERFAEdSBCA==
Date: Tue, 15 Sep 2026 00:00:18 +0000
Message-ID: <20260915000015.80480-5-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: e680af66-d18e-48f7-7c8c-08df12bc557b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|5023799004|56012099006|3023799007|6133799003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 Zv8rytCy0JPzX0M0lDxCLrxjZ42Y/hpxf3h2JUAjC9B/smBRQSNPWo52Kd9DM3LZ8pH7+wScpEJs7lgtvnbADZaLrVRg3ILrP5c2PAWMNFO8yROnk1jWhPq9PAktzXKzB6jO+z3tgkn9WyQS3awhnB863U8GWnsX09BxeQ67iFVwevqClaJiAbIbgwIBdQoBV4m8tF8ZNIKoZJe/W0Mm9b8Nlp/SxiWfxTRHzyT4erRaHuNeCzCfnefc66nLg0iCEIGZola5/mEAnXBVAs8Dz280Eg5yAk83vWefIjberOySWxeGvz0kPLxamMOhNKJK8Ww+r07rOj3RrR3XBLkW2nfp5NdLcyVLMRtwGa1el8h117zKYguhTMJ6lrfh03MM7GlfnXnoy3hWqH0Rv91VYPejoj3THS0iQtVPF/Qu2G0c+qAp40OkmxTBXeeO4974tol08e10LL39R5d+3pYZg6aaVJUvPnkShgN8Bl4pmbtNFD7xssQywJh6psvzOEE2cF4rAvuJfR2+DXdC5vPScIC6AFLHQ+bGXvZTxynxjRmj6BX8s9t2tkkEzb01g6dzb6ZScRHu6B6HLeNGDRLdB3khDoF4+cvVfmcAayn387C6Es6adxgalyv7ztBvoWYiPZLasr0OFdkUYaGvQKsqMNvu4nXKRTya7LbgjPh8cz1A2zYLlnVYDzhglEp4zCNA2aVJIhBsoj8M0MKDwRqQh90JYyX8tb6/Lor+bcXi550=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(5023799004)(56012099006)(3023799007)(6133799003)(10067099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XJKGq7an1CbXM7y8zv9Soqfg2U0Y7CdqZqO9ozkrw/fqKS2nNrcNsoL4I7?=
 =?iso-8859-1?Q?Y9GGcqRM7KkOoysgq8RG0XK7VXN8lp6RN8GZrXxkweavS/5+BmYiQAqdcJ?=
 =?iso-8859-1?Q?jg2h9IyGRwQyriHAKeyUmRLY1Z/yh2i89giCK5vWgSeU1TY1ztgxLf0i8N?=
 =?iso-8859-1?Q?FgWboYkt6z/7DRMhf4u6KXlJhNgnrbM/MOLtYiXDKIQOEvP1jE7lIEknHL?=
 =?iso-8859-1?Q?TWYxqWBUFky9os1iT5b9bbEynFaTZyutK3heTbAdhgvL9r+KCLReGa6L5i?=
 =?iso-8859-1?Q?7sEHePO7seRCuHueLEAAHn22vbaQmO33oPberuIZkv5CjF0JrWCFvXIq/9?=
 =?iso-8859-1?Q?bvIuhX5idNQ/XBDrRfZddLPES/atWiltMtIYwfx09isu3oLfPlVCTeAnZk?=
 =?iso-8859-1?Q?wyIbDBjmV0vDZVcBWxJf+PteFX3GQPruVGmve1CxBP4Ksr22I9rS5Ra+WS?=
 =?iso-8859-1?Q?+YVYcyZO7WWE12jt0heVoolwMD8SlTnCzNh1p+jhG6G/nygmRfnwK0VgxR?=
 =?iso-8859-1?Q?L13Cdsxy7X+TfJU2QCN/gDlAqSr8vdeWRUqR0rYfBrhvHn8CeeZA5kFqPL?=
 =?iso-8859-1?Q?MF78neV/d1V31E7UfiN4OBf4WoNg/xX2+vA12mZ24BatB7nfvn5MYfoYkH?=
 =?iso-8859-1?Q?GtC33J+ZsTr99RdZIHEGnLIK3RxFTn6UJ6tNKxLlTYGnw0x02Sf5FnES5c?=
 =?iso-8859-1?Q?IE13f5T8oKWpgDeLAo9DrozBqBtgaE6+eLAjKXumWTJ4uuMO6mvyb0ABCv?=
 =?iso-8859-1?Q?z4LgyI1BGRAQeQIIjGVe8HzHr9eGCSxtgzCVRt8Z4ZVSBuPgB5/vjRADJA?=
 =?iso-8859-1?Q?kXyqXf008sfa9d8LRO/nA9Iaa+lFKyotjnmE8vntbGhZADUfk1UAG5fxdI?=
 =?iso-8859-1?Q?jxVlztDZBZVBxCJaFXovVP3t61hTd3fSla+fJYUZAkXVkUdI4EuaNb5wsU?=
 =?iso-8859-1?Q?v7bswhdyET8kvjO6as8EfkkTzJQwdDwBOCLg0xTlsLMmV1S39SnnfJrPM/?=
 =?iso-8859-1?Q?ni35jo8GWQ22a4UnDEUZIEAVxKxLd4O04RS7UkHKNJaDKfR4RtaqMJUCYo?=
 =?iso-8859-1?Q?3LQHc1U6O+S4aOwicXonjU7UdlFykOSUJmvYI8quzgHZ78L+EMvGFc+Mct?=
 =?iso-8859-1?Q?/H8OBBCyv71d54Ts6ZAda18SrX/mn+P0cN8bGfBagRn+iv5B8SAi7h8Df/?=
 =?iso-8859-1?Q?8JUbbjE8g+HpaZmSi9Q3HlgIYGOhzTUqqKrDLeW1tR86YC2MQeoZYVpJWW?=
 =?iso-8859-1?Q?OBKK5CYPhiYjJramVib7ikj7pONqEqfJ9S1scouiaj8pc9DMU6BrLaIy4w?=
 =?iso-8859-1?Q?pZBz004LPWjG+a/FgXXfngLZAMKbv575jdcrk+6vJwYivhNewiebJpL+o1?=
 =?iso-8859-1?Q?FYVylYsU6upOlAh8J7Dopja05UeDu9VLUwBtJIvW7VA5VEnGQ0d734z6Z+?=
 =?iso-8859-1?Q?cpJEkXDPngS2h+Sndggg83Dbfwu23NQyOdfU6GKx9VBVuNDHGh6NOS7R0B?=
 =?iso-8859-1?Q?aL3f+qDpJRALnIHUetrJWsSSiliFFKOtyPBjgJaOU4H5+GmSWOUkvxcvKL?=
 =?iso-8859-1?Q?5Ggg2Dk5h2lb8xx1/tZ2MoO9sfbv0I4JIwXVFtg0MEYkO8q6DhYmPuii/Q?=
 =?iso-8859-1?Q?vw/CxokwPQ/XjB/2nQBNZGocDioZf1d4BP7ZXi2VUPl2qg+Wx+QXOgoFwK?=
 =?iso-8859-1?Q?TLWj25qnkY3MPrAm1JL6Rw4Se0Lm8jfsWPSiZawj0cpoAic50x/p1qNHe8?=
 =?iso-8859-1?Q?+t0g6lPrVgEJAc/mJRTDOx/xhrpWOQuYendRreJnzM1U9L?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	f7tt1xlh6ODoy0OnJuCVmWocFGfj5AFbRHUJ2USPyAMWceNKTS/phNX+sXgCB32uEfxQDpDuWLPHV0c+nyd1Gc7Yin/twV3vu5QVo7VnDi8Pp0zIa1TgHiSyrbwWYJdxDdNYuiwI7B+9IEHMr6YxnUgWHwX9MZksZ5njSSHU5/S8dgMr3WqB/t7aM3RzFsCGYqnqijgIVosKZI/XxjgRS2vXw+pxtsB4f3SFQsDes0biCz9ys/Fv8ZcXpVQ+iUji7aT+EJytS+q3qBRXU69pjFUDH9c/cPuEB11BNiTgjNr02T3SizFFWiN/LXln9DR4+/jbjHZAgvdtfJlTd8ZJVw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e680af66-d18e-48f7-7c8c-08df12bc557b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 00:00:18.4529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzGhQmo/ArftTCtAEvxcCroQWqYyzuMR4PKVc/JyxdEqIgMp+ZarsGMIwxU6DQShYDW2slLaVmV2d2cM26/v0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4277
X-MDID: 1789430428-9L7dRFerOBBU
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1789430428;9L7dRFerOBBU;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The DPLL core wants a type per device and a property set per pin: a=0A=
label, the direction, the capabilities, and the frequencies the pin=0A=
supports.  None of that can be read from the chip -- which frequencies a=0A=
board actually presents on a given input, and whether an output's=0A=
embedded sync is wired to be controllable, are board facts -- so they=0A=
come from the firmware node, with defaults for a node that does not=0A=
describe them.=0A=
=0A=
Input pins are interleaved P and N lanes of four differential pairs, so a=
=0A=
logical index maps to a pair and a lane, and a pair configured=0A=
single-ended presents two independent inputs where a differential one=0A=
presents one.  The labels follow from that, and the two extra input=0A=
positions -- the crystal and the inter-PLL sync net -- are named=0A=
separately.=0A=
=0A=
Kept in its own file, and introduced before anything is registered, so=0A=
the registration code that follows has nothing to say about firmware.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/Makefile |   2 +-=0A=
 drivers/dpll/sit9531x/core.h   |  72 ++++++=0A=
 drivers/dpll/sit9531x/prop.c   | 437 +++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/prop.h   |  39 +++=0A=
 4 files changed, 549 insertions(+), 1 deletion(-)=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.c=0A=
 create mode 100644 drivers/dpll/sit9531x/prop.h=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e=0A=
index a221fe55386a..819af61123f5 100644=0A=
--- a/drivers/dpll/sit9531x/Makefile=0A=
+++ b/drivers/dpll/sit9531x/Makefile=0A=
@@ -1,4 +1,4 @@=0A=
 # SPDX-License-Identifier: GPL-2.0-only=0A=
 =0A=
 obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o=0A=
-sit9531x-y :=3D core.o=0A=
+sit9531x-y :=3D core.o prop.o=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 76a2632f0ce4..230b21b9e238 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -23,7 +23,17 @@=0A=
 =0A=
 #define SIT9531X_NUM_PLLS		4=0A=
 #define SIT9531X_MAX_INPUTS		8=0A=
+#define SIT9531X_NUM_INPUT_PAIRS	(SIT9531X_MAX_INPUTS / 2)=0A=
 #define SIT9531X_MAX_OUTPUTS		12=0A=
+/*=0A=
+ * INTSYNC (the inter-PLL sync net) is modeled as two pins.  The=0A=
+ * destination PLL that locks to INTSYNC sees an input pin=0A=
+ * (SIT9531X_INTSYNC_PIN_ID, in the input id namespace after the physical=
=0A=
+ * inputs and the xtal); the source PLL that drives INTSYNC sees an output=
=0A=
+ * pin (SIT9531X_INTSYNC_OUT_PIN_ID, appended after the physical outputs).=
=0A=
+ */=0A=
+#define SIT9531X_INTSYNC_PIN_ID		(SIT9531X_MAX_INPUTS + 1)=0A=
+#define SIT9531X_INTSYNC_OUT_PIN_ID	SIT9531X_MAX_OUTPUTS=0A=
 =0A=
 /*=0A=
  * struct sit9531x_chip_info - chip variant identification=0A=
@@ -41,6 +51,39 @@ struct sit9531x_chip_info {=0A=
 	const u8	*clkout_map;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * enum sit9531x_signal_mode - input signal electrical mode=0A=
+ * @SIT9531X_MODE_SE: single-ended=0A=
+ * @SIT9531X_MODE_DE: differential=0A=
+ */=0A=
+enum sit9531x_signal_mode {=0A=
+	SIT9531X_MODE_SE =3D 0,=0A=
+	SIT9531X_MODE_DE,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_ref - input reference state=0A=
+ * @freq:		configured frequency in Hz=0A=
+ * @label:		board label from DT or default=0A=
+ * @sig_mode:		signal mode of the pair this lane belongs to=0A=
+ *			(detected from CLKINx_INPUT_MODE at probe)=0A=
+ */=0A=
+struct sit9531x_ref {=0A=
+	u32				freq;=0A=
+	const char			*label;=0A=
+	enum sit9531x_signal_mode	sig_mode;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_out - output state=0A=
+ * @freq:		configured frequency in Hz=0A=
+ * @label:		board label from DT or default=0A=
+ */=0A=
+struct sit9531x_out {=0A=
+	u32		freq;=0A=
+	const char	*label;=0A=
+};=0A=
+=0A=
 /*=0A=
  * struct sit9531x_dev - SiT9531x device instance=0A=
  * @dev:		parent device=0A=
@@ -48,6 +91,8 @@ struct sit9531x_chip_info {=0A=
  * @regmap:		paged register map=0A=
  * @info:		detected chip variant info=0A=
  * @multiop_lock:	serializes multi-register sequences=0A=
+ * @ref:		array of input reference states=0A=
+ * @out:		array of output states=0A=
  * @xtal_freq:		crystal oscillator frequency in Hz=0A=
  * @reset_gpio:		optional reset line (DT "reset-gpios"), NULL if absent=0A=
  */=0A=
@@ -59,11 +104,38 @@ struct sit9531x_dev {=0A=
 	/* Serializes multi-step register sequences */=0A=
 	struct mutex			multiop_lock;=0A=
 =0A=
+	/* Hardware state */=0A=
+	struct sit9531x_ref	ref[SIT9531X_MAX_INPUTS + 1]; /* +1 for xtal */=0A=
+	struct sit9531x_out	out[SIT9531X_MAX_OUTPUTS];=0A=
 	u32			xtal_freq;=0A=
 =0A=
 	struct gpio_desc	*reset_gpio;=0A=
 };=0A=
 =0A=
+/*=0A=
+ * Logical input pins are interleaved: even index =3D P lane, odd=0A=
+ * index =3D N lane of pair index/2 (IN0P, IN0N, IN1P, IN1N, ...).=0A=
+ * Index SIT9531X_MAX_INPUTS is the XO input.=0A=
+ */=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_pair - get input pair number for a logical input index=
=0A=
+ * @index: logical input pin index=0A=
+ */=0A=
+static inline u8 sit9531x_input_pair(u8 index)=0A=
+{=0A=
+	return index >> 1;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_is_n - check if a logical input index is an N lane=0A=
+ * @index: logical input pin index=0A=
+ */=0A=
+static inline bool sit9531x_input_is_n(u8 index)=0A=
+{=0A=
+	return index & 1;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_pll_page - get register page for PLL index=0A=
  * @pll_idx: PLL index (0 =3D PLLA, 3 =3D PLLD)=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
new file mode 100644=0A=
index 000000000000..c9642b702c4a=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -0,0 +1,437 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x firmware node property parsing=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * Retrieves pin properties from Device Tree firmware nodes (or=0A=
+ * applies defaults when no firmware node exists).=0A=
+ */=0A=
+=0A=
+#include <linux/dev_printk.h>=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/err.h>=0A=
+#include <linux/fwnode.h>=0A=
+#include <linux/property.h>=0A=
+#include <linux/slab.h>=0A=
+#include <linux/string.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "prop.h"=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_pin_label - fill the package label for an input pin=0A=
+ *=0A=
+ * Split out so input-naming changes stay local to this helper.=0A=
+ */=0A=
+static void sit9531x_input_pin_label(struct sit9531x_dev *sitdev,=0A=
+				     struct sit9531x_pin_props *props, u8 id)=0A=
+{=0A=
+	u8 pair =3D sit9531x_input_pair(id);=0A=
+=0A=
+	if (sitdev->ref[id].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		snprintf(props->package_label,=0A=
+			 sizeof(props->package_label), "IN%u", pair);=0A=
+	else=0A=
+		snprintf(props->package_label,=0A=
+			 sizeof(props->package_label), "IN%u%c", pair,=0A=
+			 sit9531x_input_is_n(id) ? 'N' : 'P');=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_pin_package_label_set - generate package label=0A=
+ * @dir:	pin direction=0A=
+ * @id:		pin index=0A=
+ *=0A=
+ * Generates a package label string.  Output pins are named "OUT0",=0A=
+ * "OUT1", ...  Input pins are named after the physical pair and lane:=0A=
+ * "IN0P", "IN0N", "IN1P", ... for single-ended lanes, or "IN0",=0A=
+ * "IN1", ... when the pair is configured differential (the N lane is=0A=
+ * not registered in that case).=0A=
+ */=0A=
+static void=0A=
+sit9531x_prop_pin_package_label_set(struct sit9531x_dev *sitdev,=0A=
+				    struct sit9531x_pin_props *props,=0A=
+				    enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	/* The internal INTSYNC pin has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    id =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		strscpy(props->package_label, "INTSYNC",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/* The internal XO reference has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT && id =3D=3D SIT9531X_MAX_INPUTS)=
 {=0A=
+		strscpy(props->package_label, "XO",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	/* The internal INTSYNC source (output) pin has a fixed label */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    id =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {=0A=
+		strscpy(props->package_label, "SYNCOUT",=0A=
+			sizeof(props->package_label));=0A=
+		props->dpll_props.package_label =3D props->package_label;=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+		sit9531x_input_pin_label(sitdev, props, id);=0A=
+	else=0A=
+		snprintf(props->package_label, sizeof(props->package_label),=0A=
+			 "OUT%u", id);=0A=
+=0A=
+	props->dpll_props.package_label =3D props->package_label;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_pin_fwnode_get - find firmware node for a pin=0A=
+ * @dir:	pin direction=0A=
+ * @id:		pin index=0A=
+ *=0A=
+ * Searches for input-pins/output-pins child nodes in DT, looking=0A=
+ * for a child whose "reg" property matches @id.=0A=
+ *=0A=
+ * Return: 0 on success, -ENOENT if no firmware node exists=0A=
+ */=0A=
+static int=0A=
+sit9531x_prop_pin_fwnode_get(struct sit9531x_dev *sitdev,=0A=
+			     struct sit9531x_pin_props *props,=0A=
+			     enum dpll_pin_direction dir, u8 id)=0A=
+{=0A=
+	struct fwnode_handle *pins_node, *pin_node;=0A=
+	const char *node_name;=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+		node_name =3D "input-pins";=0A=
+	else=0A=
+		node_name =3D "output-pins";=0A=
+=0A=
+	pins_node =3D device_get_named_child_node(sitdev->dev, node_name);=0A=
+	if (!pins_node) {=0A=
+		dev_dbg(sitdev->dev, "'%s' sub-node is missing\n", node_name);=0A=
+		return -ENOENT;=0A=
+	}=0A=
+=0A=
+	/* Enumerate child pin nodes and find the requested one */=0A=
+	fwnode_for_each_child_node(pins_node, pin_node) {=0A=
+		u32 reg;=0A=
+=0A=
+		if (fwnode_property_read_u32(pin_node, "reg", &reg))=0A=
+			continue;=0A=
+=0A=
+		if (id =3D=3D reg)=0A=
+			break;=0A=
+	}=0A=
+=0A=
+	fwnode_handle_put(pins_node);=0A=
+=0A=
+	props->fwnode =3D pin_node;=0A=
+=0A=
+	dev_dbg(sitdev->dev, "Firmware node for %s %sfound\n",=0A=
+		props->package_label, pin_node ? "" : "NOT ");=0A=
+=0A=
+	return pin_node ? 0 : -ENOENT;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_pin_props_get - get pin properties for a given pin=0A=
+ * @dir:	pin direction (INPUT or OUTPUT)=0A=
+ * @index:	pin index=0A=
+ *=0A=
+ * Allocates a pin properties structure, generates a package label,=0A=
+ * looks up the firmware node if available, and reads optional=0A=
+ * properties (label, connection-type, supported-frequencies-hz,=0A=
+ * esync-control).=0A=
+ *=0A=
+ * Call sit9531x_pin_props_put() to free the returned structure.=0A=
+ *=0A=
+ * Return: pointer to pin properties on success, error pointer on error=0A=
+ */=0A=
+struct sit9531x_pin_props *=0A=
+sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
+		       enum dpll_pin_direction dir, u8 index)=0A=
+{=0A=
+	struct dpll_pin_frequency *ranges;=0A=
+	struct sit9531x_pin_props *props;=0A=
+	int i, j, num_freqs =3D 0, rc;=0A=
+	u64 *freqs =3D NULL;=0A=
+	const char *type;=0A=
+	u64 curr_freq;=0A=
+=0A=
+	props =3D kzalloc_obj(*props, GFP_KERNEL);=0A=
+	if (!props)=0A=
+		return ERR_PTR(-ENOMEM);=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
+		/*=0A=
+		 * INTSYNC destination pin: a PLL locks to the INTSYNC net as a=0A=
+		 * reference, so it can be connected and re-prioritised.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+		   index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID) {=0A=
+		/*=0A=
+		 * INTSYNC source pin: a PLL drives the INTSYNC net.  It can be=0A=
+		 * connected/disconnected but carries no priority (driving the=0A=
+		 * net is not a reference selection) and no frequency.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D 0;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+		   index =3D=3D SIT9531X_MAX_INPUTS) {=0A=
+		/* The XO reference is fixed: no state or priority control. */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		props->dpll_props.capabilities =3D 0;=0A=
+		sitdev->ref[index].freq =3D sitdev->xtal_freq;=0A=
+		curr_freq =3D sitdev->xtal_freq;=0A=
+	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D sitdev->ref[index].freq;=0A=
+	} else {=0A=
+		/*=0A=
+		 * A synthesized clock output is an external connection with=0A=
+		 * no more specific meaning; a board that knows better says=0A=
+		 * so through the pin's connection-type property below.=0A=
+		 */=0A=
+		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
+		curr_freq =3D sitdev->out[index].freq;=0A=
+=0A=
+		/*=0A=
+		 * Allow phase-adjust over a +/-1 ms window.  The subsystem=0A=
+		 * rejects pin_set(phase-adjust, X) when X falls outside=0A=
+		 * [min, max], so leaving these at 0 silently blocks every=0A=
+		 * netlink call.  1 ms is well beyond the DCO dynamic range=0A=
+		 * but costs nothing.  Only outputs get a range: input pins=0A=
+		 * have no .phase_adjust_set, and advertising one there would=0A=
+		 * promise userspace something every set would refuse.=0A=
+		 */=0A=
+		props->dpll_props.phase_range.min =3D -1000000000; /* -1 ms in ps */=0A=
+		props->dpll_props.phase_range.max =3D  1000000000; /* +1 ms in ps */=0A=
+		/*=0A=
+		 * The fine step is 30 ps, but requests are accepted at 1 ps=0A=
+		 * resolution and rounded to the nearest achievable delay, so=0A=
+		 * advertise the request granularity, not the hardware step.=0A=
+		 */=0A=
+		props->dpll_props.phase_gran =3D 1;=0A=
+	}=0A=
+=0A=
+	/* Generate package label */=0A=
+	sit9531x_prop_pin_package_label_set(sitdev, props, dir, index);=0A=
+=0A=
+	/*=0A=
+	 * Both INTSYNC pins are internal to the chip and have no board-level=0A=
+	 * wiring, so they take no properties from the firmware node.=0A=
+	 */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    (index =3D=3D SIT9531X_INTSYNC_PIN_ID ||=0A=
+	     index =3D=3D SIT9531X_MAX_INPUTS))=0A=
+		goto skip_fwnode_props;=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	rc =3D sit9531x_prop_pin_fwnode_get(sitdev, props, dir, index);=0A=
+	if (rc)=0A=
+		goto skip_fwnode_props;=0A=
+=0A=
+	/* Look for "label" property -> board label */=0A=
+	fwnode_property_read_string(props->fwnode, "label",=0A=
+				    &props->dpll_props.board_label);=0A=
+=0A=
+	/* Look for "connection-type" property -> pin type enum */=0A=
+	if (!fwnode_property_read_string(props->fwnode, "connection-type",=0A=
+					 &type)) {=0A=
+		if (!strcmp(type, "ext"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
+		else if (!strcmp(type, "gnss"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_GNSS;=0A=
+		else if (!strcmp(type, "int"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		else if (!strcmp(type, "synce"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_SYNCE_ETH_PORT;=0A=
+		else if (!strcmp(type, "mux"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_MUX;=0A=
+		else=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "Unknown pin type '%s'\n", type);=0A=
+	}=0A=
+=0A=
+	props->esync_control =3D=0A=
+		fwnode_property_read_bool(props->fwnode, "esync-control");=0A=
+=0A=
+	num_freqs =3D fwnode_property_count_u64(props->fwnode,=0A=
+					      "supported-frequencies-hz");=0A=
+	if (num_freqs <=3D 0) {=0A=
+		num_freqs =3D 0;=0A=
+		goto skip_fwnode_props;=0A=
+	}=0A=
+=0A=
+	freqs =3D kcalloc(num_freqs, sizeof(*freqs), GFP_KERNEL);=0A=
+	if (!freqs) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_freqs;=0A=
+	}=0A=
+=0A=
+	rc =3D fwnode_property_read_u64_array(props->fwnode,=0A=
+					    "supported-frequencies-hz",=0A=
+					    freqs, num_freqs);=0A=
+	if (rc) {=0A=
+		dev_warn(sitdev->dev,=0A=
+			 "failed to parse supported-frequencies-hz for %s: %d\n",=0A=
+			 props->package_label, rc);=0A=
+		goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Seed the runtime ref->freq / out->freq with the first DT-listed=0A=
+	 * supported frequency so the netlink frequency_get callback reports=0A=
+	 * a sane initial value before any pin_set occurs.  DT lists the=0A=
+	 * physically-wired reference frequency for each input pin and the=0A=
+	 * default output frequency for each output pin.=0A=
+	 */=0A=
+	if (num_freqs > 0) {=0A=
+		if (dir !=3D DPLL_PIN_DIRECTION_INPUT ||=0A=
+		    index !=3D SIT9531X_MAX_INPUTS)=0A=
+			curr_freq =3D freqs[0];=0A=
+	}=0A=
+=0A=
+skip_fwnode_props:=0A=
+	/* Neither INTSYNC pin carries a frequency attribute */=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
+		return props;=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
+	    index =3D=3D SIT9531X_INTSYNC_OUT_PIN_ID)=0A=
+		return props;=0A=
+=0A=
+	/*=0A=
+	 * Advertise only concrete values from firmware plus current runtime=0A=
+	 * value. For outputs without a firmware list, publish one wide range as=
=0A=
+	 * an explicit fallback because those pins do support frequency_set.=0A=
+	 */=0A=
+	ranges =3D kcalloc(num_freqs + 2, sizeof(*ranges), GFP_KERNEL);=0A=
+	if (!ranges) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Publish the seeded rate only once the pin is certain to be built.=0A=
+	 * The allocation above is the last thing that can fail, and a call=0A=
+	 * that reports failure must not leave the device's cached rate=0A=
+	 * changed behind it.=0A=
+	 */=0A=
+	if (curr_freq) {=0A=
+		if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+			sitdev->ref[index].freq =3D curr_freq;=0A=
+		else=0A=
+			sitdev->out[index].freq =3D curr_freq;=0A=
+	}=0A=
+=0A=
+	j =3D 0;=0A=
+=0A=
+	/* Current frequency first, when known. */=0A=
+	if (curr_freq)=0A=
+		ranges[j++] =3D (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq)=
;=0A=
+=0A=
+	for (i =3D 0; i < num_freqs; i++) {=0A=
+		struct dpll_pin_frequency freq =3D DPLL_PIN_FREQUENCY(freqs[i]);=0A=
+=0A=
+		if (freqs[i] =3D=3D curr_freq)=0A=
+			continue;=0A=
+		ranges[j++] =3D freq;=0A=
+	}=0A=
+=0A=
+	if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT && num_freqs =3D=3D 0) {=0A=
+		ranges[j].min =3D 1;=0A=
+		ranges[j].max =3D 1000000000ULL; /* 1 GHz */=0A=
+		j++;=0A=
+	}=0A=
+=0A=
+	if (j > 0) {=0A=
+		props->dpll_props.freq_supported =3D ranges;=0A=
+		props->dpll_props.freq_supported_num =3D j;=0A=
+	} else {=0A=
+		kfree(ranges);=0A=
+		props->dpll_props.freq_supported =3D NULL;=0A=
+		props->dpll_props.freq_supported_num =3D 0;=0A=
+	}=0A=
+=0A=
+	kfree(freqs);=0A=
+=0A=
+	return props;=0A=
+=0A=
+err_alloc_ranges:=0A=
+	kfree(freqs);=0A=
+err_alloc_freqs:=0A=
+	fwnode_handle_put(props->fwnode);=0A=
+	kfree(props);=0A=
+=0A=
+	return ERR_PTR(rc);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_pin_props_put - release pin properties=0A=
+ * @props:	pin properties to free=0A=
+ */=0A=
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props)=0A=
+{=0A=
+	kfree(props->dpll_props.freq_supported);=0A=
+=0A=
+	if (props->fwnode)=0A=
+		fwnode_handle_put(props->fwnode);=0A=
+=0A=
+	kfree(props);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_prop_dpll_type_get - get DPLL channel type from firmware=0A=
+ * @index:	DPLL channel index (0-3)=0A=
+ *=0A=
+ * Reads the "dpll-types" string array property from the firmware node=0A=
+ * and returns the corresponding DPLL type enum.=0A=
+ *=0A=
+ * Return: DPLL type for the given channel (default: DPLL_TYPE_PPS)=0A=
+ */=0A=
+enum dpll_type=0A=
+sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	const char *types[SIT9531X_NUM_PLLS];=0A=
+	int count;=0A=
+=0A=
+	count =3D device_property_read_string_array(sitdev->dev, "dpll-types",=0A=
+						  types, ARRAY_SIZE(types));=0A=
+=0A=
+	if (index >=3D count)=0A=
+		return DPLL_TYPE_PPS;=0A=
+=0A=
+	if (!strcmp(types[index], "pps"))=0A=
+		return DPLL_TYPE_PPS;=0A=
+	else if (!strcmp(types[index], "eec"))=0A=
+		return DPLL_TYPE_EEC;=0A=
+=0A=
+	dev_warn(sitdev->dev, "Unknown DPLL type '%s', using default\n",=0A=
+		 types[index]);=0A=
+=0A=
+	return DPLL_TYPE_PPS;=0A=
+}=0A=
diff --git a/drivers/dpll/sit9531x/prop.h b/drivers/dpll/sit9531x/prop.h=0A=
new file mode 100644=0A=
index 000000000000..f7f1c854b955=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.h=0A=
@@ -0,0 +1,39 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x firmware node property parsing=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_PROP_H=0A=
+#define _SIT9531X_PROP_H=0A=
+=0A=
+#include <linux/dpll.h>=0A=
+#include <linux/fwnode.h>=0A=
+=0A=
+struct sit9531x_dev;=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_pin_props - pin properties from firmware=0A=
+ * @fwnode:		firmware node handle (NULL if no DT node)=0A=
+ * @dpll_props:		DPLL core pin properties=0A=
+ * @package_label:	pin package label (e.g. "IN0", "OUT3")=0A=
+ * @esync_control:	embedded sync is controllable=0A=
+ */=0A=
+struct sit9531x_pin_props {=0A=
+	struct fwnode_handle		*fwnode;=0A=
+	struct dpll_pin_properties	dpll_props;=0A=
+	char				package_label[8];=0A=
+	bool				esync_control;=0A=
+};=0A=
+=0A=
+enum dpll_type sit9531x_prop_dpll_type_get(struct sit9531x_dev *sitdev,=0A=
+					   u8 index);=0A=
+struct sit9531x_pin_props *sit9531x_pin_props_get(struct sit9531x_dev *sit=
dev,=0A=
+						  enum dpll_pin_direction dir,=0A=
+						  u8 index);=0A=
+void sit9531x_pin_props_put(struct sit9531x_pin_props *props);=0A=
+=0A=
+#endif /* _SIT9531X_PROP_H */=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
