Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841B415F01;
	Wed,  2 Sep 2026 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.183
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385263; cv=fail; b=GShcQWHaN5LT5CeE6k6USpERvQIxj8f4hRUIw11NY1JD1NrxnGpIXAGi0nK+MqpzH8wxgV+e1L+PlUR//p8KpBn1ivud7hWrcB4Ou14TYhdVbAoEXMRIcVIG63kY6HybHuCYckpgOBTXvIJi3n6qIeLAkACUAxqZSXk8fMCOVHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385263; c=relaxed/simple;
	bh=Z/di6aZR5NVhwZfVmNq8bFDd8h4QsnkeCLouRNfCkCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rw/Y7ts8xK9fDcEDz6Uyc0kwCiBXkXCSRDEyq6tYzkG47f9rcePSIzGzvaKqvWqYlxBmuA89sPtyGRA8byLUqehooBNzPpRiK/4xoxyA/8+81jKWEDMwBY1jfHXD+5pELEa6VGXCS2ntOoEVR36p0INXeKuiZwnLEUTdEXTdQ18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=EAR97cYG; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=PyZswzYK; arc=fail smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="EAR97cYG";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="PyZswzYK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=JZvavY17Q/Mczqxld7A3QssQGwKunKHn1tkk5v/oZeA=;
 b=EAR97cYGIdFM9rII94AIHgO5XPHbHZS7UMN/z/muwIA4d9sGLZ8bOqUt7w4BExhX2Q43eCStdOru3Et4rVyN81s6tdFZ4au0W0MwlS4NJkPZr2TnXHk9gRwNDgzjzRYvR62ed9l8EVNnJlsLKtlw4w/R0KmUYP1DuE67RDdKgxPgCC2qPMCzfG5EM6druE9HAawE0Sr34W/L5G8VECY+0gwNgDXux8GiEa7jdTCN4wBjvDsWgIZGOp+GEbGCeRLDHNXwzsV9eD/5hALpd2FI6N2ZyEuav5BA/lOW2qoKJ68ZbxnbNdq3C7XQZ13lVcOVcazhVoeGoaiRFD28EedANQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023110.outbound.protection.outlook.com [40.93.201.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A4DE53C006B;
	Wed,  2 Sep 2026 21:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJfg50pZmRQ5DzClX64TGtGxYwFPfQE26DTO093KjvGVfjNOzQfsS5H2jMBSk6SeAOvR0Gqfk93g8WMJP9uusYUJr+EqATXPpE/YSHwnD1R7bctvGkxGT/qIv3uYvOSs/T18oAtzvnoGKIgK7F7Eczlt+ez4q9I+lgUg+I+P1yQ++tgwQXt/r8RxSkHeREWPzzclNyP7bguGbT1YCcF66txvkIEUpgPVxm1ZMMxffk2YO3lEutzXebhNnAZZOlhrUs4oE6jwHauO9Nryu8RcQbyG24IRhRXH+5XdTYBJ68eJoXp0p9PbRhfcKE2KStwfmkTPfVHYW/2shEjtMRuVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZvavY17Q/Mczqxld7A3QssQGwKunKHn1tkk5v/oZeA=;
 b=NlUiPHvpr4vDbXrIUW7KsNSZ4blcs2L6VwSoj21hAqZlCYICZFoj9xSN+NjZD2NGwb8f0ptEXrZ9Hh6EqvugEsZX8c3/pbBns8F7Rn3HANl4cVQBJgafVLZjjGu1EZw/AzvPDP6ui9YyUmqjOsjSZtu0k52m6fWic0mn6e7ubfBOo1o57l4lwlzH2tLXFrTkJmK7dM8K+nPoa0LXRn2ZDKOANq14YFENpvQEo9og24w6Mnn3AcKptOvreGAwj2SPrP6qBoX+AfBiZckRbz+yhY+MpFJdfa4Ob61GEVV0bi47zs1pCi8o6YJApQM//Pg7gYt3nA8/uF7CA9fS+EKYVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZvavY17Q/Mczqxld7A3QssQGwKunKHn1tkk5v/oZeA=;
 b=PyZswzYKdO3saeAluGLjrCbViKUD8n+QklcMyceHJQSQe64Dc49GGOPWyUlwcasuf2SqdPMe5un9xJwGzX0//kSn3TxV8sSCPcf+eSeEicIM4J8r7bdoZmq9EbbW8ReG7EM9Gx7J+viVeWydQnQbZuqoAki5RSsjalz6Ejk4O7GgrCLlzqvtEhdaTvujd838uv8ZbKQFkh4yITy9UVTdSnoCKOGW/Ded+6uAoIC59WemxRR01rdoOEq1TeQw3hPqUD/Ee+y6vLYuHF9i60d6ZHnVM/OkJ78t7UYQLNU0fh+S0pMLZwE3ISPdMDYH03LXTnkM2IlGHG+Lcnzv7y92eg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:33 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:33 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Ali Rouhi <arouhi@sitime.com>
Subject: [PATCH net-next v8 04/15] dpll: sit9531x: read DPLL types and pin
 properties from system firmware
Thread-Topic: [PATCH net-next v8 04/15] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
Thread-Index: AQHdOyOu9Kn1vpfFikmIOKtsbMi1gA==
Date: Wed, 2 Sep 2026 21:40:33 +0000
Message-ID: <20260902214030.20955-5-arouhi@sitime.com>
References: <20260902214030.20955-1-arouhi@sitime.com>
In-Reply-To: <20260902214030.20955-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS7PR20MB4877:EE_
x-ms-office365-filtering-correlation-id: f4ade555-ecc4-4aa5-9fa8-08df093ad15b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|5023799004;
x-microsoft-antispam-message-info:
 kvJjaO8WG+FJpEXZ/QsjmPaVEbsclYptrymoskQtIgYy41ot3Qv/SkFqGIBajZ9SfD22vtADsUftAhTk1m+Z25qa/DK7tC9ldiNbbCiD9ICjdINWt+S0SqMmvsUqOKzmTI2Vrj850ogzP1UjzEGwXwbRXyQSbKNHj1bv/eGLD/WQDqp4yz/WsXHsaT4wMVDR1HT72xu96GV+9Y797TwVGJJBGrKF2lYREzgStTzekeBcN7j2PfzBr1Wa450uoClJGYynJHMiFiwK1UrI33EHvJnbd884D6KZVFcnVuDHS0hybGNk7irKqaCZdyoEvK8hlFNbMysenAGEgsCkWZG7+1lQf/i/1JcTgjLnt3VxeWDqzGEzs+twX2FKfEZ+X3UIk/xwvK+E1nsvvd1YlOydIXNEFKfRL63iLAN7fOmAfXD1CGedOErbTJVQdnKV/OErrp02TD5EeppCxwDWZMD1jZ51xpBUhVTD4xDSXPr8Hp00wkH+k6oQA1wJ+S9kOTT5/jrKMzH19VlIZrwXWFdQg7wM9yc/hyqYssW2LPupumwdwYGRoagLrF3wmkoNjV5iAhtrC2uoMAf284CFpTFLm5qixTjB/dS5vpmQZGcWPnsSViuJL6mYEE+18u67IttO7gX+CI8LqPHrskd842pqQDpOihiY+B37zjSUDBhap4gGnrNZ8eBLYM2kftfq7ytF1HT7ToVyBboODV/XLVMcsiqCFMExPJII2HjHChv5Cnc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iinaF9LefLfgMZqUR8GYyd58MC2hxiETMhoMQ+9Uh8U9WSpLi7OASNPvEa?=
 =?iso-8859-1?Q?juwiHEg2R3YgHLW6di3gnQiSlY/E6srnX3iUbXF8HgUgCDPElxrKM5Otb7?=
 =?iso-8859-1?Q?6bAAyTTPnsj6C1Nfe6FHliR8zzPXwCVdualNObAXx3JuoFevoSKTNHz1Fb?=
 =?iso-8859-1?Q?p2Mtknp1btxuDwnCDhPUeTXAwjaLPuiOT568ZeHX/YAQwNt7qchUFJFPTl?=
 =?iso-8859-1?Q?ZcZNgos779PdTlQwPn3RIMu52KGOJ7EB+p+B0LACbV28szwXA4mHt3bSG0?=
 =?iso-8859-1?Q?wlpCpUY3PVxede3t6+EbjgKmnQfpePRPmzHARsmMfN1mtnF13B08hWM1jd?=
 =?iso-8859-1?Q?aO4E36bQApI03ILENvHmZhRFHRTocf8VjcsjgRYQx+sOzfobVWG3bLcvqN?=
 =?iso-8859-1?Q?HAwnY/6bhsAnKXs6v/21dOemlYO2lXtipr8Zc2qwlChnc627ansOYqfxjN?=
 =?iso-8859-1?Q?9M2ELtv9EZaudac8BRiaqn2ja8DW+WglxjLH7iNyc9b/FoliOJF4Qig1is?=
 =?iso-8859-1?Q?3+lyqjfsCAjnnCdizB9OoYU9lxzx2pWBvpoD6zUvwjZKgNVal/uKg3afhv?=
 =?iso-8859-1?Q?4Bli227/r0qBwFoaJfHuz/TehsfWMcLbhFrrOqzRXTbdBUrPYAn5qrQ4ga?=
 =?iso-8859-1?Q?kTseN5lP9ZfR19EP4D0uSEe8jDbv52NbTVhaZQxLrq12rF00sdRIIN+VWQ?=
 =?iso-8859-1?Q?v+96eqnDwDba+dc0nJhbfHkIqzsRQBA+e23PPI9hnDgn5aw8lsYO9MiLz2?=
 =?iso-8859-1?Q?71ClHPoTEdiH6+lLEXRelVC7/ZK43WCvZ5H9IeAeZ9Qh1GUPuEaHPtrUpD?=
 =?iso-8859-1?Q?b5YkmlMVb9TbSWBnWZN1/GsjMtnVM2BkpIc+NmlXlutpbOnybby4DOjn+h?=
 =?iso-8859-1?Q?cj6UlO/MwBUv1QldWsRvouHr5KZw9wb1FsfyAsicRC0b8wkKZtEXCdejuO?=
 =?iso-8859-1?Q?W1JhbJyjMgWWQKrA08LqzEQYWATPhYlsd3O/0RzIeUXOmuLufVcFiVu3iE?=
 =?iso-8859-1?Q?KkJv2cYlI22MJbeekhtT42DC+jUshtnzZkBdS+9h8LmbkBoEUb5jOFmQHz?=
 =?iso-8859-1?Q?za1M3UDj/sSHvp7WcDgQ112yhSiYT6RjRBExY9VglYHglV+n/a8HjmQrTj?=
 =?iso-8859-1?Q?hWKxVasWha/kghyW9wOK7HvKX0a921VbM641Ks8ZhBpAJXpSDmX0PFobWh?=
 =?iso-8859-1?Q?Rc2K6kglDGiG0bfCebZPvbwRPvFAFXMQxxrLKfAO5cZlxOccVZVsSvS2b6?=
 =?iso-8859-1?Q?gVowf42UqM8KkUJJlc5ASdZFJOUROCOgmMSufzadYfenQ/jwPj8ApbaAGY?=
 =?iso-8859-1?Q?/st8fcVgPzAtopbpUcTVfFXj+bC4fIjzGZcCPb0rVCykArhjkUxP7i1sFG?=
 =?iso-8859-1?Q?SA5fSzxO36cfeG9UjPA8AMMNJn++h29H0q4DZ+0753aTcNQtJ3zR+FddU9?=
 =?iso-8859-1?Q?o1T9IEj0p4MDfNMk9wMYjU6/voht0r0qIc1xQGLF0a/5Btzi8cutLQIhm3?=
 =?iso-8859-1?Q?h4c/8wCkeW+JD3hh9q7vk5uJHZGuS58H9ifWmAALXtvESLA+YG26n01g3F?=
 =?iso-8859-1?Q?c4kkEAscPznaYEFOXBMpbD6I0isasK/Qw7f6DduBvojauvFPOWuB1ackVy?=
 =?iso-8859-1?Q?z+BxLA7g1Er6R9SBPZ2/uYLNOZdGVP08oHgy3VNSiB8s8uoiWC3F8l6R5H?=
 =?iso-8859-1?Q?RC3YUCYKLHXi+ljywxDC93s47fdMBWiINntDOsiykfK0ywfmkArmm+eWTy?=
 =?iso-8859-1?Q?Sdv1Nw3ysxExfFpdy4Yy+zIrRG7I6i0bsJTwGABv8jLGpO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	x6hYPmXPytIwHiA0TA2rYaNCGZK5HT5QWyRsDUJ1iiMQy2WguVJC3SY3ZPUUlB7i7epxv3EkuyOVJ1h2njCN/0NrB54HXBEXacR1s3HW3gqLI44vtdMLXhX4FycD8miiA0mQrMocV/SqLytDN8kmYepuOkxyxOj3L9x82nK5Og7jMIveawIswpjK5zjH4MwE/K6/JvUMSbX0gfGPloZnNts+gJz6wCfJ0cULdEE4Uv8vvsDEPPxKJeTQpr1oo6MYTG/yBbKJDDbIPt1Di1/70XzmtgX/uYv1IHC2Z0QoPIjcHsnqX11Ifn6dArlOK+BfYtzaGhRPCREPfBUy5MRYaw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ade555-ecc4-4aa5-9fa8-08df093ad15b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:33.4008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HVXzQlZ7eAiTS0Y0vreOdBfjVxzSImTLTfprz74p6jwggd9WB0Srax9h+VGJU/doqYWScnRyyPRwAF1Lsw/FTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385238-uT8Ff1fPYgkV
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385238;uT8Ff1fPYgkV;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
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
 drivers/dpll/sit9531x/prop.c   | 406 +++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/prop.h   |  39 ++++=0A=
 4 files changed, 518 insertions(+), 1 deletion(-)=0A=
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
index 000000000000..94f3da716297=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -0,0 +1,406 @@=0A=
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
+	u32 curr_freq;=0A=
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
+	    index =3D=3D SIT9531X_INTSYNC_PIN_ID)=0A=
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
+		else if (!strcmp(type, "int") ||=0A=
+			 !strcmp(type, "int-oscillator"))=0A=
+			props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
+		else if (!strcmp(type, "synce") ||=0A=
+			 !strcmp(type, "synce-eth-port"))=0A=
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
+	fwnode_property_read_u64_array(props->fwnode,=0A=
+				       "supported-frequencies-hz",=0A=
+				       freqs, num_freqs);=0A=
+=0A=
+	/*=0A=
+	 * Seed the runtime ref->freq / out->freq with the first DT-listed=0A=
+	 * supported frequency so the netlink frequency_get callback reports=0A=
+	 * a sane initial value before any pin_set occurs.  DT lists the=0A=
+	 * physically-wired reference frequency for each input pin and the=0A=
+	 * default output frequency for each output pin.=0A=
+	 */=0A=
+	if (num_freqs > 0) {=0A=
+		if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT)=0A=
+			sitdev->ref[index].freq =3D (u32)freqs[0];=0A=
+		else=0A=
+			sitdev->out[index].freq =3D (u32)freqs[0];=0A=
+		curr_freq =3D (u32)freqs[0];=0A=
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
+	/* Allocate frequency ranges list -- DT discrete entries + current=0A=
+	 * freq + one catch-all wide range so the subsystem never pre-=0A=
+	 * rejects a frequency_set call.  The chip's real admissible set=0A=
+	 * is bounded by VCO / divider math in sit9531x_output_freq_set().=0A=
+	 */=0A=
+	ranges =3D kcalloc(num_freqs + 2, sizeof(*ranges), GFP_KERNEL);=0A=
+	if (!ranges) {=0A=
+		rc =3D -ENOMEM;=0A=
+		goto err_alloc_ranges;=0A=
+	}=0A=
+=0A=
+	/* Current freq as first entry */=0A=
+	ranges[0] =3D (struct dpll_pin_frequency)DPLL_PIN_FREQUENCY(curr_freq);=
=0A=
+	j =3D 1;=0A=
+=0A=
+	for (i =3D 0; i < num_freqs; i++) {=0A=
+		struct dpll_pin_frequency freq =3D DPLL_PIN_FREQUENCY(freqs[i]);=0A=
+=0A=
+		if (freqs[i] =3D=3D curr_freq)=0A=
+			continue;=0A=
+		ranges[j++] =3D freq;=0A=
+	}=0A=
+=0A=
+	/* Always append a wide catch-all range */=0A=
+	ranges[j].min =3D 1;=0A=
+	ranges[j].max =3D 1000000000ULL; /* 1 GHz */=0A=
+	j++;=0A=
+=0A=
+	props->dpll_props.freq_supported =3D ranges;=0A=
+	props->dpll_props.freq_supported_num =3D j;=0A=
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
2.43.0=0A=
=0A=
