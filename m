Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C49A4B4893;
	Wed, 30 Sep 2026 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811451; cv=fail; b=bYGgzRpkWagpM1s8XSA3J+IUcQo8lNmPSXvLbyF78ychKQKbiz1hTByK4mhZrZ3yY/MewaAUyxM0gY0kVN/VEK0PqlTPIlhI4l2lrQGzycs0bB5onxvb/yANylUU5g1sP/J52wTtZO1YVrOaxzY/frMcxiaI+TvQ227FcgT+Ch8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811451; c=relaxed/simple;
	bh=w8Eu00geD9OOyGSKTrc0wVZwQyFfyNdRN45fS1OV8Iw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PTASBg7GyZ9xnW4etai7twSiVQCe7Htu7Gp/XtQurT8DswlGq8ss1gVz8CW2LJAbiFCP6kVUMlMhdp3SGnzB2iX0nKWoZvE4tjhilWmCPah63ds1b63DFmal5OmfpYghDukjJnD0/FFzpnWtT1t4LgBPEqzT9FXAWCUCH2B9JqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=da+po8xb; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=OvcHhlxA; arc=fail smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="da+po8xb";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="OvcHhlxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=y2zkoJniFxRZQwPlDPOTvofa/b2uyN77FNu4N70BR60=;
 b=da+po8xbA8velFVSy5oo6M6XO05HutneHNY/UtkC2R8w5DPGULDlb12ZX5q/kUoolHZRKCE6yKODZL7/6w2RmKjdIFYYxMxo17hqdIvwJyoY9gMdgz3GTZkd0I5Dx2kg3+huxLB8a3qINo+dS+w+dx7B5DZGFQtp/FY8wXFVtznCbMbgfcpNmHWA+auZ1Ts6FZp5tyJExBM4wT17J0NDagczUY+BThiPrJ0M7sw30eZulsf1RtlEnKZXG+OUCubQ5yeGmw8JIWUeX4VKsxCtLpzwT2MnDR+S7hdyXs4+02KqI2KWuAVlnBxm6/GVbsYVZgT6d6g2n46ST4mmzsnM/Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020097.outbound.protection.outlook.com [52.101.61.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2321910006C;
	Wed, 30 Sep 2026 23:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMrxzo3g/5HwwD+lmgZL0SBUaS4xeFrMHXvXN3ZwVzpQA1xp3ga8pylwUOG6QDAQ+7LMqB9r72/9jDnJfDjIEjEo+gBvGT0QXnRx2OewOX8Fp/FeHdbZJJZvxyyOC3TOqlij8YglE6bf6t5RNIy32RelFglblcSGnPbBwyEhilh8MDZyU55mRHzhE4OxiyTTtws5FaJ/t9NMAy5ueQy4uW+W78ywtM6ZFRHzsgsrVEbYIECL2HAQyuHiE5iJsox3w8gnU93laXkEYPDLyDGuMIZZG6zcRMMx1daQuFiefK6V1kuahwhzvya+9cfsByrrzxx4PmT3nf3+ai8CkWk3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2zkoJniFxRZQwPlDPOTvofa/b2uyN77FNu4N70BR60=;
 b=vIR/VAhTIRstSRCgTfZE1yeTN2b/XP6iCFEvX/eefeL1bWXfXBkjSBIo3xbPB5Av6YuI0eOdTpnc8dsCnYsj6NZ21UQkpVVIxvqQIXDIelaBrE2ClYYCbgkSKtz+Swn92B8YK/46jvW6gNa+jql/FtKTFsDaUMPRLmxJXC5AdkeohmzLOB67bB2+AxaxicTr+6EOc+NRoDFMn4A9VMC+k17n/mP1s7GN0P6MzQi+w5YMLd6odhqqRMyVjMNGdGo72IJiWw7tBE3/2C4nPXrx3KYkXwIkXOmXocIFi4SiGvkiHVPjIqPDF7b1HPhWbGFohA+T4uEgXF4kLKPK32ttSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2zkoJniFxRZQwPlDPOTvofa/b2uyN77FNu4N70BR60=;
 b=OvcHhlxAQ1NTgV1e20bea7JYGpiWv1jANXPIGOGNykeuPpgev7cXtNFBjIk4avKFlQpo3Ug+q3ddbqAkID8KTnkMkfEGth8MC3lrtxzrAlX524nzq47bqzRuYmmNakFUCetNey0VVLDept3BDBuJzBbbJ9u53HiVcYoqL5dS/S569N/fc2r1x/AevjYisKCIfPwWAjtFm6NJnshrNLogokyYpYtBZblB9FPzrf1s1/+n8fQ/5V+yEJ60m4Xzcf2lVdPsTKWzOJXkRV5ehb/ya731Oc+voRO0wZGH96UW7t41lW+hgMlpaK9OEEh8Gv21tHk2emXgX7aea/O9LPyRaw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB5383.namprd20.prod.outlook.com
 (2603:10b6:806:29e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 23:37:21 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:21 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v11 08/13] dpll: sit9531x: add support to get and set
 priority on input pins
Thread-Topic: [PATCH net-next v11 08/13] dpll: sit9531x: add support to get
 and set priority on input pins
Thread-Index: AQHdUTSjYJab91Weo0yHPNESYimFVA==
Date: Wed, 30 Sep 2026 23:37:21 +0000
Message-ID: <20260930233714.87679-9-arouhi@sitime.com>
References: <20260930233714.87679-1-arouhi@sitime.com>
In-Reply-To: <20260930233714.87679-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB5383:EE_
x-ms-office365-filtering-correlation-id: c5fafa93-bb83-42b3-d236-08df1f4bc5f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|38070700021|6133799003|3023799007|10067099003|5023799004|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 VxWTc71idGulJn5EUyDQ0A8VCKREfx9hPgJqtHXpf2MAA/7LPlQ+Jor4k2ijmSqAL8zKu/asrVRapHijhk5ZAShf0OTuMjAXLEnGT7/ECJTggb2NOnUY5V/eIFcQ5jyNtlh+aiWMMPOSpGHCJGJ1NIkTJuKZgyd53ME7LFe70NsK/76MWdJA2Otp5bIa6N7axkJvgUO5z+Vfw42vMCuXEMXnKPlEKLJCKUOtpFB9THHskXrP+VCU20XXsbGblVU06uuET9luPRoK0XgSfOq1QqzBR8XDgDNQCucm7pQxQIycnz8JP0xJTMr9lCabBa3aJoG74+xFUhXcNAP/36Snpv8/gTQ0xamHiUwG28GRxxUT4EsCNIul9zhxUcuiRfGBJmoHMbq7w8pdwhExR9Ly9j0JmM1yO2tygcjurjq5JLGVdKokBwexQu7MqlIqFC0/eIQcMXvEIFDh28wThTvBSGxKmdircLBAJfw9dktM8gXs4lJA8OmYOW7nKG5jG8nuBWtYdDQFy8yb4PKVtbiQ3x+ZBeuq7nxBQDU+BYjoDzmhaUqr34J0Tx6SV3ZQLdm7DhVAZxmo2NunIZDN7NGGX0cKWA/7dApDWqTz8k/zg5DHwdDch6CjjCjuDBrk619bA5ysswjEWF0BDQJanu+MXC4XszaWMFPsUGQ7hXldLh27edvghI9Y8RFpMawF6ABcvbJ8ZBdH3Y18f2wwgya52mCRQuDooPjz1pcVu+BqUFY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?QqwOgITUvy0ze6IBIDEpJ5KibL2SItNUx+wnMJ+NCkdL8ys650WCigrEaA?=
 =?iso-8859-1?Q?K6hasuljh6Sbim8Mmxhr5Iz/Tt46L5fUyHX2yKTZy5ir3ljzSsBosDe1HN?=
 =?iso-8859-1?Q?+Cl6OKyam6yKu+5sBW7I+NijCLhu4CXD7d99j45PCV4E8Q+HHjSw194L+m?=
 =?iso-8859-1?Q?UIVMe1mIcj9DPM4CWcKXjerW+Vce09AiaFQmwISYB/Wyn5EDeNGj7geObL?=
 =?iso-8859-1?Q?LzbWZ9ou4e2aXmffrVy6KXhcLFH8nXaNTrNurs/ZIBx2T7PFLtAaEyWrbA?=
 =?iso-8859-1?Q?m2n3W60FcBj7YuDSRY41a4O6dpG3A9n+HEYlSXigQ/UC+BDecH9BJqTavn?=
 =?iso-8859-1?Q?5g8HcEDMB4/fBIqus/5lz3oKHPZlZ+O9BWUYEdSbQVyHzOwsBIfOiwCRVC?=
 =?iso-8859-1?Q?vPkWgv3z2hxPK1815LDevrSJXvU4qKgcmhGaJxgvMIr6U9e3sYjadlQQD9?=
 =?iso-8859-1?Q?Txztsnu13Vpj1bHVzX1VdHBLNHEeb6g/7aqQLIb/lLd0LqwM9izYqn9RnN?=
 =?iso-8859-1?Q?gXrBTFycI1yCK4sxDLLxl/P7RLiZbIGVd07yPHXQKCz1WLvFq9UFIPc0PA?=
 =?iso-8859-1?Q?VaWBQ1UkyYu7Wy4YvBqc60zN7ZUkEt/U09uj4eKZUuFTsxHNGOTt1zoV6j?=
 =?iso-8859-1?Q?7AsOr+FRxaK7zy+14ES5ZWBrf9H2dc5SkVJoQ9wvki0cVght6wr1cx177c?=
 =?iso-8859-1?Q?6g/9rVQe/zZ9LjYqX+QCb81QLxYGCOEJgZiVQzyEDh9PbKJHDY1Gu02lUd?=
 =?iso-8859-1?Q?Q7hm/cR4oVSPNyNO1ylQQlD7+y5RQ0hencMBZ2QnErLLfGc3A4pbMtCk3V?=
 =?iso-8859-1?Q?55xf7o9IQBFkM5SNCY8KJ4gy8cC4ul5JctvaU+7tYDC/Y6vcMCjAV3sNSv?=
 =?iso-8859-1?Q?8Z57eRJgXwzsneDCq/M0pxi0l4EOhsfX3/glkf7+eqRrKSK6JmKpbfVXvW?=
 =?iso-8859-1?Q?1TdmIDXuf14JB6XdI1Kgml42H0GKAlQogtM3L7Rf478XE9Z+RhaNRNctsp?=
 =?iso-8859-1?Q?z617dL6+peoMHe0F9hyMMAyGYr8mKK2IH671WQSO2bR2tHGqn07/+520F0?=
 =?iso-8859-1?Q?72sStdyhsK2OXOlisUN8gu5GVaeuZPzXnN+XmgPNYmN7D0eusCy9VsMzvO?=
 =?iso-8859-1?Q?L3oip4wZDoU5vy1MQcaGBusvjpYCgmzs0XYs7FUCSF3C0G7sYRatogLZAo?=
 =?iso-8859-1?Q?uP3h97PV5brXBlgEH6yk75zC61IupfpnFDvk0gOIUNRzPTzF75uHjAgn2n?=
 =?iso-8859-1?Q?RD2fHSEwTnt6iS9iJGYWCGl6CHnfPPB7LqNIzYCjTf8US1LBFPsEyI9Xqu?=
 =?iso-8859-1?Q?4EdSMi73Vkl7fWYpluYNjj4YyZMhKCN4vAskwtnHgnqPI3E/uDqkeAM334?=
 =?iso-8859-1?Q?xdQzAutLLzD9gJuFTWDLOq2Ja1REWHowHM9V90vogYSDZHVl+Hn5kkGUuQ?=
 =?iso-8859-1?Q?P2HorMdFjHOAT+6/c5eYayb8GYumPIIr25zdFMw0jJHE6wF7sQRz+o/25W?=
 =?iso-8859-1?Q?l+TBpvfHGxZDa3zSKEulTZVD+RwvY7qt853nXAZWC3eF4cDNmr8nmyt5Co?=
 =?iso-8859-1?Q?V7XavnpTHyAjxvgrAINj7hQa/3DC/CWF05JhbDzKnWt3chplAFVC/VJbaj?=
 =?iso-8859-1?Q?hB9Szimr9wWhP8st8DpwJMFUPoxjizOUBPJub2HOU8jDDNA/IetVlYhkey?=
 =?iso-8859-1?Q?vQm3x34E3nZP7bxu/4LrrX6clXUA8YM8z9kF7tcvLUqJV1NWbFMElrzbrZ?=
 =?iso-8859-1?Q?vFhiYoG821u80LceEJt1bNbq9pW7CH2DcS+VB/9HKSD65z?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	gmdv6CDVC+HP51jhbyekRscraHjGx/fgViAm5TNRrflgVuSyHOdBERVLFkmwDFwZXjXb6bkWy/o+cIXlBGpIJYBFepQL2Q1Bpm1ItwcZTLPFKAwSzSYnqUR6WYE4ysZ3d4IY24cf7Y7lgX2Z2xvqd7qE1ToQ1htYSoFC79AXo8GOz7fmDd490ZiDoLAbBw1KJzY9eUApJ9DQ2Yz8OeAPk1WLBSzYFOAs8fSr+OF9M/S/NNZL5DV9CFvBZAdJOhalMFn8GZOuhcNzMlqo5w3q9IaLmcAx4ry3JsBgW1aJv65jkOVguwaYMpAX9JET8GOSREiH4rgRGRkm2Qx/rA9Dvg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5fafa93-bb83-42b3-d236-08df1f4bc5f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:21.4247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bH69L9+7ejWHmcQ43EHegfmwPSIOHVLCpKFY3cWAxuuxF0yNchW0KLUi3NpItPuWlb8vAQyJUSdpNxrwVxPggw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB5383
X-MDID: 1790811447-pTRFZvkmadlO
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811447;pTRFZvkmadlO;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
When the device has to choose a reference, it takes the first slot of=0A=
its priority table whose signal is qualified.  The driver keeps a=0A=
priority per input and PLL and builds the table from it (previous=0A=
patch), so getting a priority reads that value without touching a=0A=
register, and setting one records it and, for an input the PLL lists,=0A=
rewrites the table in the new order.  When the new order puts a=0A=
different input with signal first, the PLL moves to it; a change further=0A=
down the table leaves the PLL where it is.=0A=
=0A=
Priority and state are separate attributes, and neither moves the other.=0A=
A priority can be set on a disconnected input and takes effect when it is=
=0A=
connected; disconnecting an input and connecting it again brings back the=
=0A=
priority it had.  Setting one input's priority leaves every other input's=
=0A=
as it was, so only the named pin changes and the core's own notification=0A=
covers it.  The range is 0 to 255 against a table of eleven slots:=0A=
inputs of equal priority keep the order the table already has them in,=0A=
so distinct values are what fix an order.  An input the PLL has never=0A=
listed reports the lowest slot, the priority it would be connected at.=0A=
=0A=
A table rewritten behind the driver -- a profile reload, a direct I2C=0A=
tool -- is taken as the new configuration and the priorities are=0A=
re-seeded from it, so the poll now watches priority and operational state=
=0A=
as well as state, and notifies a pin when any of them moves.  The=0A=
notifications go out after the walk over the pins, outside multiop_lock,=0A=
since the helper takes locks the callbacks run under.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c |  38 +++++++++=0A=
 drivers/dpll/sit9531x/core.h |   2 +=0A=
 drivers/dpll/sit9531x/dpll.c | 152 ++++++++++++++++++++++++++++++-----=0A=
 drivers/dpll/sit9531x/dpll.h |   2 +=0A=
 drivers/dpll/sit9531x/prop.c |   4 +-=0A=
 5 files changed, 176 insertions(+), 22 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 231e2d71dd6f..f6c76cc78456 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -670,6 +670,44 @@ bool sit9531x_input_prio_present(struct sit9531x_dev *=
sitdev, u8 pll_idx,=0A=
 	return !!(sitdev->chan[pll_idx].prio_mask & BIT(input_idx));=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_prio_get - read an input's priority for a PLL=0A=
+ * @input_idx:	input source in hardware encoding (see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	output priority (lower is preferred)=0A=
+ *=0A=
+ * Reports the priority configured for the source on this PLL, which is=0A=
+ * kept whether or not the source is currently in the table: state and=0A=
+ * priority are separate attributes, so disconnecting an input and=0A=
+ * connecting it again must not change the priority it reports.  The=0A=
+ * value is seeded from the hardware table, and re-seeded whenever the=0A=
+ * read-back shows the table was rewritten by something other than this=0A=
+ * driver.  A source that was never listed reports the lowest slot.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+	if (chan->cfg_known & BIT(input_idx))=0A=
+		*prio =3D chan->cfg_prio[input_idx];=0A=
+	else=0A=
+		*prio =3D SIT9531X_PRIO_MAX_SLOTS - 1;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Take the configured priorities from a table the hardware holds: each=0A=
  * listed source gets the first slot it occupies.  A source the table does=
=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index adcdfc46c597..8aa505f84e87 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -250,6 +250,8 @@ bool sit9531x_input_prio_present(struct sit9531x_dev *s=
itdev,=0A=
 				 u8 pll_idx, u8 input_idx);=0A=
 int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			    u8 input_idx, u8 prio);=0A=
+int sit9531x_input_prio_get(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 *prio);=0A=
 int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
 			       u8 input_idx);=0A=
 int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index f961b7af28fe..ebbf7f5a3394 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -502,11 +502,93 @@ sit9531x_dpll_input_pin_state_on_dpll_set(const struc=
t dpll_pin *pin,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_get - read input pin priority=0A=
+ *=0A=
+ * Reports the priority sit9531x_input_prio_get() keeps for the source on=
=0A=
+ * this PLL, connected or not; no register is read.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_get(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll,=0A=
+				 void *dpll_priv, u32 *prio,=0A=
+				 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	u8 slot;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id), &slot);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	/*=0A=
+	 * dpin->prio is not touched here: it is the poll's baseline for=0A=
+	 * spotting a change to notify, and a get refreshing it would hide=0A=
+	 * the change from the poll.=0A=
+	 */=0A=
+	*prio =3D slot;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_prio_set - set input pin priority=0A=
+ *=0A=
+ * Records the priority and, for a pin in this PLL's table, rewrites the=
=0A=
+ * Page 1 table in priority order (sit9531x_input_prio_set()).  The other=
=0A=
+ * pins keep their priorities, so only the named pin changes and the core=
=0A=
+ * notifies it.  A pin that is not in the table keeps the priority for whe=
n=0A=
+ * it is connected.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_prio_set(const struct dpll_pin *pin, void *pin_pri=
v,=0A=
+				 const struct dpll_device *dpll,=0A=
+				 void *dpll_priv, u32 prio,=0A=
+				 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	int rc;=0A=
+=0A=
+	if (dpin->dir !=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority applies only to input pins");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	if (prio > U8_MAX) {=0A=
+		NL_SET_ERR_MSG(extack, "Priority out of range (0-255)");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	rc =3D sit9531x_input_prio_set(sitdev, sitdpll->id,=0A=
+				     sit9531x_input_hw_src(dpin->id),=0A=
+				     (u8)prio);=0A=
+	if (!rc)=0A=
+		dpin->prio =3D prio;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input priority");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
+	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
+	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -625,39 +707,67 @@ void sit9531x_dpll_changes_check(struct sit9531x_dpll=
 *sitdpll)=0A=
 		dpll_device_change_ntf(sitdpll->dpll_dev);=0A=
 	}=0A=
 =0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
 	list_for_each_entry(pin, &sitdpll->pins, list) {=0A=
-		const struct dpll_pin_ops *ops;=0A=
+		enum dpll_pin_operstate operstate;=0A=
 		enum dpll_pin_state state;=0A=
 		bool changed;=0A=
+		u8 id, prio;=0A=
 =0A=
 		/*=0A=
-		 * Poll input pins whose state can change autonomously: regular=0A=
-		 * references and the INTSYNC destination pin.  Outputs (incl.=0A=
-		 * the INTSYNC source) change only through their own set=0A=
-		 * callback and the XO is permanently connected, so skip those.=0A=
-		 * Each pin's state_on_dpll_get resolves to the right getter.=0A=
+		 * Watch the selection-role pins -- regular references and the=0A=
+		 * INTSYNC destination -- whose state, operational state and=0A=
+		 * priority can move without a request: the device selects on=0A=
+		 * its own, the monitors follow the signal, and a table=0A=
+		 * rewritten behind the driver re-seeds the priorities.=0A=
+		 * Outputs (incl. the INTSYNC source) change only through their=0A=
+		 * own set callback and the XO is permanently connected.=0A=
 		 */=0A=
 		if (!sit9531x_dpll_is_input_pin(pin) ||=0A=
 		    sit9531x_dpll_is_xo_pin(pin))=0A=
 			continue;=0A=
 =0A=
-		ops =3D sit9531x_dpll_pin_ops_get(pin);=0A=
-		rc =3D ops->state_on_dpll_get(pin->dpll_pin, pin,=0A=
-					    sitdpll->dpll_dev, sitdpll,=0A=
-					    &state, NULL);=0A=
-		if (rc)=0A=
-			continue;=0A=
+		id =3D pin->id;=0A=
+		if (id =3D=3D SIT9531X_INTSYNC_PIN_ID &&=0A=
+		    sitdev->intsync_src =3D=3D sitdpll->id)=0A=
+			state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+		else=0A=
+			sit9531x_dpll_selection_state_get(sitdev, sitdpll, id,=0A=
+							  &state);=0A=
+		sit9531x_dpll_selection_operstate_get(sitdev, sitdpll, id,=0A=
+						      &operstate);=0A=
+		if (sit9531x_input_prio_get(sitdev, sitdpll->id,=0A=
+					    sit9531x_input_hw_src(id), &prio))=0A=
+			prio =3D pin->prio;=0A=
+=0A=
+		changed =3D pin->seen &&=0A=
+			  (state !=3D pin->pin_state ||=0A=
+			   operstate !=3D pin->operstate || prio !=3D pin->prio);=0A=
+		if (changed)=0A=
+			dev_dbg(sitdev->dev,=0A=
+				"%s: state %u->%u operstate %u->%u prio %u->%u\n",=0A=
+				pin->label, pin->pin_state, state,=0A=
+				pin->operstate, operstate, pin->prio, prio);=0A=
 =0A=
-		/*=0A=
-		 * The first pass only takes the baseline: the pin was=0A=
-		 * registered with this state, so nothing has changed yet.=0A=
-		 */=0A=
-		changed =3D pin->seen && state !=3D pin->pin_state;=0A=
 		pin->pin_state =3D state;=0A=
+		pin->operstate =3D operstate;=0A=
+		pin->prio =3D prio;=0A=
 		pin->seen =3D true;=0A=
-		if (changed) {=0A=
-			dev_dbg(sitdev->dev, "%s state changed\n", pin->label);=0A=
-			dpll_pin_change_ntf(pin->dpll_pin);=0A=
-		}=0A=
+=0A=
+		/*=0A=
+		 * The notification helper takes DPLL-subsystem locks that the=0A=
+		 * callbacks run under, so it cannot be called with=0A=
+		 * multiop_lock held; mark the pin and send after the walk.=0A=
+		 */=0A=
+		if (changed)=0A=
+			pin->ntf_pending =3D true;=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	list_for_each_entry(pin, &sitdpll->pins, list) {=0A=
+		if (!pin->ntf_pending)=0A=
+			continue;=0A=
+		pin->ntf_pending =3D false;=0A=
+		dpll_pin_change_ntf(pin->dpll_pin);=0A=
 	}=0A=
 }=0A=
diff --git a/drivers/dpll/sit9531x/dpll.h b/drivers/dpll/sit9531x/dpll.h=0A=
index 1d320e183eb6..2e3df7608490 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.h=0A=
+++ b/drivers/dpll/sit9531x/dpll.h=0A=
@@ -31,7 +31,9 @@ struct sit9531x_dpll_pin {=0A=
 	u8				id;		/* hardware index */=0A=
 	u8				prio;=0A=
 	enum dpll_pin_state		pin_state;=0A=
+	enum dpll_pin_operstate		operstate;=0A=
 	bool				seen;	/* baseline taken by the poll */=0A=
+	bool				ntf_pending;=0A=
 };=0A=
 =0A=
 /* Per-PLL DPLL device state. */=0A=
diff --git a/drivers/dpll/sit9531x/prop.c b/drivers/dpll/sit9531x/prop.c=0A=
index 3635ea497e41..934db566c002 100644=0A=
--- a/drivers/dpll/sit9531x/prop.c=0A=
+++ b/drivers/dpll/sit9531x/prop.c=0A=
@@ -187,10 +187,11 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=
=0A=
 	    index =3D=3D SIT9531X_INTSYNC_PIN_ID) {=0A=
 		/*=0A=
 		 * INTSYNC destination pin: a PLL locks to the INTSYNC net as a=0A=
-		 * reference, so it can be connected.=0A=
+		 * reference, so it can be connected and re-prioritised.=0A=
 		 */=0A=
 		props->dpll_props.type =3D DPLL_PIN_TYPE_INT_OSCILLATOR;=0A=
 		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D 0;=0A=
 	} else if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
@@ -214,6 +215,7 @@ sit9531x_pin_props_get(struct sit9531x_dev *sitdev,=0A=
 	} else if (dir =3D=3D DPLL_PIN_DIRECTION_INPUT) {=0A=
 		props->dpll_props.type =3D DPLL_PIN_TYPE_EXT;=0A=
 		props->dpll_props.capabilities =3D=0A=
+			DPLL_PIN_CAPABILITIES_PRIORITY_CAN_CHANGE |=0A=
 			DPLL_PIN_CAPABILITIES_STATE_CAN_CHANGE;=0A=
 		curr_freq =3D sitdev->ref[index].freq;=0A=
 	} else {=0A=
-- =0A=
2.43.0=0A=
=0A=
