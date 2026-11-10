Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342398;
	b=48DjEi564tZPdSs/H60YWIlGASTsAr8vCkdE95D6gYzlz+nbjU7pYKD4+O1TTGuU9Z8T
	 2IIoZvVGWOPq0h2Ix/QXIFc4Jv3uy3xM5K7l4LfuzcnIb8NbeyhrEJOhl9ev0KM+zMkYf
	 EKI8D0X+cFXdxHKYEK3lwq37DEypDJN6v2gZJWYtvCBiCXjWzVJes33UzbuTSpc32uFd/
	 BxGOF8re0+jIMBBDabriLZ3pm4x6P15FQxeSoNfJgHgl1SXOWYzuflgT7QNbsr49AdkBN
	 JxuOsz6rOI27qKorBQYSITqI+GD16Ot9NWuYsziyYEV7y6Xm6iHY4xDJJlW5FDedM7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342398;
	h=DMARC-Filter:DKIM-Signature:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-MDID:X-PPE-STACK:
	 X-MDID-O:X-PPE-TRUSTED;
	bh=0HIcCaoBYBAJ9Gi+ED/e9uNbjf5eTx/FSyfICvjPM+g=;
	b=Vel88de+Q7FhFVAy9E4BQtdwTc8G8XQM3S1mlMbAMZVCv9HSE6qUvi8+aSMYfGPT+9zz
	 7ji52MfS+1QggL3CLAgTxwXiSpR61px61Uh5o8Hr5O9wVUqRCNnkMrRJzLA7oxh+uTYqn
	 PVCadXXFWW44bZ176RHO0cQZ5SROz+q+syRGdsCQjGeJs5XNSH8Hu/bI8HRgxTwsWIkiz
	 +RMFyIpo9JNE+Yyka9WFYt2d41MDRyiaAm/kN+nkXQ1ojpolJWDmyXo0f97WHRvThEKPr
	 R+Po1qxpyj5JCr9C3J+l3iZvHFvWvgPhrx9XKPS2CMQTmhhA5Bu6fSH1nXSvLy6oX1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=WKhaLHF1;
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=tG5lTnd3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.52
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EEF606A880;
	Tue, 10 Nov 2026 20:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67EEF606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=WKhaLHF1;
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=tG5lTnd3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=0HIcCaoBYBAJ9Gi+ED/e9uNbjf5eTx/FSyfICvjPM+g=;
 b=WKhaLHF1hPYOIaooxgmtLMAe1NO8Wa6+15XHbEx/WzidphGE3sc0toDCULcRXYWvw0Zx+ssrm8Kzlo7wNP3oCuectOXN1s0/qge9MR3OMaWQ2qLmoQaBWKqNg8UcJlm6B3bmp9IFkzd0WrRwZpg8Yi2ASlimzM5x8O3AfR4YSg7IPOjtmn73WP9qAnbuN93cfHYrmAXQ3B2Y2NlMe0q+Z1SyWGqle47KMpYw6k4TAZBYvkk1qxMlB7Ap3INcQJKFYzDRy4vcdRu5vh7/zWvfmLA5gfYxPUkZiueuSlvqblFfB62CJI29jdxrbYIT6PmnL41wJRc2paYYe3jUoBjSuA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021098.outbound.protection.outlook.com [52.101.62.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 13F2F1C0080;
	Tue, 10 Nov 2026 20:26:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G88uaYtob9XhQk3c4IS1vBk8boovWe0tcZx7ml4AuPOuNe5czt+1VXvSmeONoRNoKFBuNgGvggVokxl9MHxar4oLpfbdiF0p58f0IPNLzxxKouOHewA2BKa/MfDfofwSlObmLCWJIMZs2HSHvlvFgyAAXXzeyb764fOxaBuN4w27scF6wwvzMLuhQVICq5rsvZKNIJRWpfpvUcMyIqRYvs3tsfTi78XQS509wO70Bh2Dl6kLUi99wn9untzqZUd7ASCVsu4r60Jx6InaBZt/VX7n07kS5f2/Vyl9DmpRjF7nQnIlAN/v6j/jZsZ66yArj3a2SJReRPPW2EuzCQ+CKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HIcCaoBYBAJ9Gi+ED/e9uNbjf5eTx/FSyfICvjPM+g=;
 b=Nls5oG3j2m882qy/951jp8jN8AIznanmxQQwMuHerc0oxUG2LX7FmDVsNVoxbgXFm5D6XxSw+ySjhbbgM+P2PL+VQ2B2NklSpjymyBTWZQDk6zNSnKzszB+OzHy9MRAKiOMEB6hiTvHcUAGs5TRFBFLxq0DDRoXgL2uX3UvZ1fgas15aE+DY9T/28JF9Y64I2khwuNmyc13H5c/5toQW4zmiul9YovvJvGKx7fVu/a0jmj0FsnL+UDA/EuO9yRkCqg+che74Fdtj92gT78hZNMezr9H5H7KwcAp7+b2I1pcxdXFFCPycCUmsUoP6j54zA25x8yUAoNd4HiE+uw68Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HIcCaoBYBAJ9Gi+ED/e9uNbjf5eTx/FSyfICvjPM+g=;
 b=tG5lTnd3F/lApQQ2xZHbaCc+lufxj4UzGzO5QFjyCl7At1LDgVMCpwhQ/zKZhUfOu5HtkTb+awYia2aac9SunrAOEJWgXY098fDccI+zyojGgWxfh3nSbSgXHV/Cv6tw1aU1y4R1FeT77mE33Oktis5hoV0erGGQqwk6zXtdMiJk6uTXbYZOYI/lwbcKtvVXhJc/uIdOroFmKSl+QBe4wd0q7meDuue0Ha57Q2k/0EFLwBPtYB306dLkWO5gQv6+8oOKb5UNtmOpeqtZMVZ9wj1smnbMUkpr465PUO9A0BbWyDt+z8XHCuw5BkjOoH+V4GBm+MzWbh2DIBSZUXiuOg==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by PH0PR20MB6205.namprd20.prod.outlook.com
 (2603:10b6:510:295::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:25 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:26:25 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v15 12/13] dpll: sit9531x: add support to get phase
 offset on the connected input pin
Thread-Topic: [PATCH net-next v15 12/13] dpll: sit9531x: add support to get
 phase offset on the connected input pin
Thread-Index: AQHdcVG87Kdt8HqG3ES9pEyPWtB19g==
Date: Tue, 10 Nov 2026 20:26:16 +0000
Message-ID: <20261110202607.55744-13-arouhi@sitime.com>
References: <20261110202607.55744-1-arouhi@sitime.com>
In-Reply-To: <20261110202607.55744-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|PH0PR20MB6205:EE_
x-ms-office365-filtering-correlation-id: 02b4f882-3955-4afa-e7d8-08df3f68e465
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|261022115727099003|3023799007|261026140227099003|261022075727099003|261026121527099003|261021135927099003|261028144727099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003|10067099003|261102123227099003|5023799004|56012099006|38070700021|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 DYvmiE5Opq5uS1sC+1DUq35UguoGn6EbuhguRPvQj9FlrbB2vaxOWl9l4u6VnQBS8ywUVHN1b3JPQcCwebg5CXhZoaCfvLoxHZ0g+2yh+9V/0dSIDyUX9S7aGYWA4gvYcGpsDZiASgnZc5QWrTxAAw+41CQMc2WPO4MzlkQuBZxyblHK2pRHw/jMCWivUr+SLDK96KvG6cIfhNTj/jfZtigB/JQNRda7BTKWa1l2oSvCc4nymv0J77Vfvia8Yedbb1yRizSHEEopovsS2ZKRXAPcvjgrgJElW7zvZXEM7KA4CQ9vfOSh9ApxQDHDt2AYKg5XZzzQkPx96IHQA3b/bU8Rzt/X0HwnHB+7Fl7pV212vgD845PixkXIbYg29J/cy55EBE2YJdMY6sR6h+n4uxLGDk40ZuAybFSkoNcJuYw0Izqt6rLbqJVSBrLdazCGU4yKoylcmCtsPGIFnXNPIgztcyvGbXzYuKGdepGmcmc/h9zteSLQjG4TRXWde1/jUMjLmWLY5ZG3fYkq1oVmme9tLdV6x/9DqhUaomf4nednPsUU2IwIxXE3PKw/VXCChH0I4HQaz8ZVSrTuVkLdDih7coPQeQv55gJSqeDbL8gV6UMW+/dArE4tytjSzkhHIL+gS+EclGJJRSmZ/TE06YiXG3RJNtU03GqRiT04KS70Q/6rp1N+dZalJjwaE9BATkMatbBq1nSsnnJlfOpLLuIL2vFcPcGjh256SZGP5QM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261022115727099003)(3023799007)(261026140227099003)(261022075727099003)(261026121527099003)(261021135927099003)(261028144727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003)(261102123227099003)(5023799004)(56012099006)(38070700021)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?e66HGZlzCsQNwcH3bdKSiw8cSxPn7QIY9RyeAfLUWMJWujxhM2AgUtMsmV?=
 =?iso-8859-1?Q?ExAnbf5TUOdZG+mZKl/di5yL6GCYEx1ZxgtModCJkmTXqy4xJ/sPswPl7+?=
 =?iso-8859-1?Q?qnY2KZeH2PJeDyD0xFFOJo3XDljlFFIw/0zsp1UglTvANKFSIIuOk5EUhl?=
 =?iso-8859-1?Q?5aVsggAYIkuVMfvRiocWtmJl0I5CuC4qw1hH4t/zEcDokRgWA65LN+sFdl?=
 =?iso-8859-1?Q?txGM59n68Z587cvtCoTOHt5YPl8/0Z56fThEv6DzaKgvl3k1pZk1QFdZNP?=
 =?iso-8859-1?Q?XiHd+zoJ/GdVwnfodvdqzTeu97MzOAgHh7B3gFig+6TKV6RgYIoJgIgcHN?=
 =?iso-8859-1?Q?rG6h5oJG+2lIjf5j3AV7s6HljtBXIt2cgm8wF/yZpKvWBa+A2ASWMKMITF?=
 =?iso-8859-1?Q?H+Zvj7ruUIuoBDbx6rN8LhWo/u6dSNx5DZ39PyH8DnX77RhgXC4xEbvEMP?=
 =?iso-8859-1?Q?ZQM3uLlfuQ8C29LRg4lA4pBfOt9sepGtM7koaoS0q6tyjGy1ko/mBmjLk9?=
 =?iso-8859-1?Q?/t7ry7oRgjoujG81cf0yqujfR/zRLx7tEIzf9pet3upvo+KjjM032u1m7l?=
 =?iso-8859-1?Q?0pLcoIyyyEm6eYe3gjIUTZmU5R/qLyuTIPr0E/lOQ8ePx+U+Q4sFNIT4tO?=
 =?iso-8859-1?Q?37fhWSy7S20dTfs7zgyXMTcTuycI55GTNDFaT/kNEzCBr2688dxNkHbaw6?=
 =?iso-8859-1?Q?tL0LAhQGB798ogao3G+kEwSLr8wOkA0guyhzNxTt4vY96opHvs1y1Lv9j5?=
 =?iso-8859-1?Q?CETnb3s6GheUYb7oMJ9zKeRBb7GiH+/B1786QDXpIPSDATcanFD6dLEpgz?=
 =?iso-8859-1?Q?zO/TgoIbCz7qcZ+H/5RGNRHq63qdDA3yOjdmv54nyNoXy23M4sprIwUBDf?=
 =?iso-8859-1?Q?0geBQhHHxuQKOSIpE3Scn4n0UwSBa7OtjBhXzY3BmygVexYSr9jAZIqxO2?=
 =?iso-8859-1?Q?nUztRKEQZxRWN/vFZ2ze8I/BFq9/rKZBS6Dh1KOyaaZQOM30ict94mOkhK?=
 =?iso-8859-1?Q?Yf3FmvjWTefSCbhSBarSC7iHs7IYQGCwaPXivsYRdEV0uehXU/kFO1kTYG?=
 =?iso-8859-1?Q?/ZBslQua9hu8kto/zJQp4YFAUK4xY0Y1UgNzi4JykH4Kr+yBIBhWC41hR6?=
 =?iso-8859-1?Q?Eqvs4YVNqS8UZjwxKJbKNr/dyLGI7rIr7Zu3rKJf0VPoK8+reJAmrGMG7j?=
 =?iso-8859-1?Q?+tW+k2ceHWOOOXzGUE7Cu/JaNXukiWAnz7OWAvr5T30rImpwE7OlmabjT0?=
 =?iso-8859-1?Q?PpBxVHE5P/MfuXVg5XZJZCgCeOUaJJRmAXuuF1Y8FS1l1J4rXu4RvMcDLq?=
 =?iso-8859-1?Q?gAhYx3CF/8U41KowmsFD4H4YmKjQnhRt11fcf/hsiGunZTagGO9p5yhq82?=
 =?iso-8859-1?Q?82Ish9pERkCITRVc/e7RWuxdBUixXtMH4fmv9CBWNIlPF2xfpfnW7Hfarb?=
 =?iso-8859-1?Q?ZY1AcOnUjGfJciJ3CK3pZYAMiKucB9O8bTEFTe7ZxgXhaC9xYPWHnDxo7I?=
 =?iso-8859-1?Q?IZQR4kb9vwhEjW9J1dOmYT6fVJ8z7Vohye+CNakIZr1AvR9qiiDEwp8uoI?=
 =?iso-8859-1?Q?H8hv9MxLEPRvD+3aLLJf7Phzm+/s6uYNyT94wbp6Q0drYt1CqSkchC7oWW?=
 =?iso-8859-1?Q?LheX4gfXiycTLTlGiqpSwZEFyg3nKpO5D2TU+7p8t7mIkBCRf0GSTyQBR/?=
 =?iso-8859-1?Q?3FhORiumORq9oaNcWbmX0XGDVeWbZ2Rxnd5sogwn6QHpgghhCnNVMfGEt4?=
 =?iso-8859-1?Q?Kek8FmlvTTso7W+bABr4owPCReLN0vaiZAUGRaeXdzcFvb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	SNBc9+kA4JrJYvfjPNW5JzJaUslP6C8D22bw2xt1BtdN/S18rr+X9K+IwCAya5FdgTPSS5HNlETKmUjZm5+tdEGksF0XRqGHeXxvWDt0/mhAaI5058fy6Dp3h9FHGxd14Vipf53UK5nGcV11YVpB7pGX/zVo4/2Qos+p2PklsPg24MEmlKBqt1NJkW5gw+Srbnte+KegDMIO7kk0RNy4NFAHhoMQGOCxmHEVMjX0nfjXuEPzQwna27PSYCl9M1GufuRp+DFFastKMuqZQTXKh48ywEKcwU2sh/zsfV5mlZiOtc/ZR7fWyX1J9c5UEjMrnsyUSiO0I5ip90RwNOCa0w==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b4f882-3955-4afa-e7d8-08df3f68e465
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:16.8075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/x6J2Wg8dxDeLRBG6nzUplp8y5+x170MtnZsSvXWASAIrg8F90J/Hv52w+FxkWklSeBc0LPZKroU6Vv1HZ9TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB6205
X-MDID: 1794342390-BNWZEaMMVot3
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1794342390;BNWZEaMMVot3;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report the phase difference between a PLL's reference and the PLL, read=0A=
from the on-chip time-to-digital converter through the debug window as=0A=
the documented procedure does. A read latches a sample and returns the=0A=
previous one, so each sample is read three times.=0A=
=0A=
Only the input the part feeds the PLL has an offset. Any other pin, a PLL=
=0A=
without a reference, or a PLL that drives no enabled output returns=0A=
-ENODATA and the core leaves the attribute out.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 357 +++++++++++++++++++++++++++++------=0A=
 drivers/dpll/sit9531x/core.h |  13 ++=0A=
 drivers/dpll/sit9531x/dpll.c | 120 ++++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |  19 ++=0A=
 4 files changed, 456 insertions(+), 53 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 9896d5aa40f5..8f305cc27737 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -262,6 +262,28 @@ static int sit9531x_update_pll_close(struct sit9531x_d=
ev *sitdev, u8 pll_idx,=0A=
 	return rc;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Restore the debug taps a phase-offset read changed. The PLL page's debu=
g=0A=
+ * window must already be open.=0A=
+ */=0A=
+static int sit9531x_tap_restore(struct sit9531x_dev *sitdev, u8 pll_idx)=
=0A=
+{=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_pll_close(sitdev, pll_idx,=0A=
+				      SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+				      chan->tap_read_code);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_write_pll_close(sitdev, pll_idx,=0A=
+					      SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+					      chan->tap_write_code);=0A=
+	if (!rc)=0A=
+		chan->tap_pending =3D false;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static void sit9531x_input_get_regs(const struct sit9531x_dev *sitdev,=0A=
 				    u8 index,=0A=
 				    unsigned int *force_reg,=0A=
@@ -785,12 +807,16 @@ static int sit9531x_prio_prg_commit(struct sit9531x_d=
ev *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-/*=0A=
- * Four registers carry a nibble per lane: loss of signal and the fine and=
=0A=
- * coarse frequency-drift flags. Caller must hold sitdev->multiop_lock, or=
 run=0A=
- * before registration.=0A=
+/**=0A=
+ * sit9531x_input_mon_fetch - read the clock monitor status of every lane=
=0A=
+ * @sitdev: device pointer=0A=
+ *=0A=
+ * One nibble per lane: loss of signal, fine and coarse frequency drift.=
=0A=
+ * Caller must hold sitdev->multiop_lock, or run before registration.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
  */=0A=
-static int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev)=0A=
+int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev)=0A=
 {=0A=
 	static const unsigned int regs[] =3D {=0A=
 		SIT9531X_CLKMON_P_STATUS_01, SIT9531X_CLKMON_P_STATUS_23,=0A=
@@ -2559,6 +2585,171 @@ static int sit9531x_clear_notifications(struct sit9=
531x_dev *sitdev)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/**=0A=
+ * sit9531x_phase_offset_read - read phase difference via TDC=0A=
+ * @sitdev: device pointer=0A=
+ * @pll_idx: PLL index (0-3)=0A=
+ * @phase_offset: phase difference in 1/DPLL_PHASE_OFFSET_DIVIDER ps=0A=
+ *=0A=
+ * The TDC code is a 35-bit magnitude with a separate sign bit;=0A=
+ * phase_diff =3D tdc_code / fvco. Caller must hold sitdev->multiop_lock.=
=0A=
+ *=0A=
+ * Return: 0 on success, -ENODATA if Fvco is unknown, <0 on other errors=
=0A=
+ */=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_offset)=0A=
+{=0A=
+	u8 v, old_write_code, old_read_code;=0A=
+	struct sit9531x_chan *chan;=0A=
+	bool have_old =3D false;=0A=
+	int rc, ret, i;=0A=
+	s64 tdc_signed;=0A=
+	u64 fvco, mag;=0A=
+	u64 tdc_raw;=0A=
+	bool sign;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	chan =3D &sitdev->chan[pll_idx];=0A=
+=0A=
+	/*=0A=
+	 * Read Fvco first; without it there is no reason to open the debug=0A=
+	 * window.=0A=
+	 */=0A=
+	rc =3D sit9531x_get_fvco(sitdev, pll_idx, &fvco);=0A=
+	if (rc) {=0A=
+		if (rc =3D=3D -ENODATA)=0A=
+			dev_dbg(sitdev->dev,=0A=
+				"PLL%c: Fvco unknown, skip TDC\n",=0A=
+				'A' + pll_idx);=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/* Restore pending taps before saving the selection */=0A=
+	if (chan->tap_pending) {=0A=
+		rc =3D sit9531x_tap_restore(sitdev, pll_idx);=0A=
+		if (rc)=0A=
+			goto relock;=0A=
+	}=0A=
+=0A=
+	/* Save the tap selection; the debug key does not cover the mux. */=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				  &old_write_code);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+					  &old_read_code);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	have_old =3D true;=0A=
+=0A=
+	/*=0A=
+	 * Enable the debug clock for taps below 200 kHz, then select the TDC=0A=
+	 * tap. The modifier register also holds fields of other taps.=0A=
+	 */=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+				    SIT9531X_PLL_REG_DBG_WRITE_CODE,=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT,=0A=
+				    SIT9531X_DBG_LOW_FREQ_CLK_BIT);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	rc =3D sit9531x_write_pll_u8(sitdev, pll_idx,=0A=
+				   SIT9531X_PLL_REG_DBG_READ_CODE,=0A=
+				   SIT9531X_DBG_READ_CODE_TDC);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+=0A=
+	/*=0A=
+	 * A status data read latches a sample and returns the previous one;=0A=
+	 * read three times as the documented procedure does.=0A=
+	 */=0A=
+	for (i =3D 0; i < SIT9531X_DBG_STATUS_READS; i++) {=0A=
+		rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+					  SIT9531X_PLL_REG_DBG_STATUS_DATA,=0A=
+					  &v);=0A=
+		if (rc)=0A=
+			goto relock;=0A=
+	}=0A=
+=0A=
+	tdc_raw =3D 0;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_4, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	sign =3D !!(v & BIT(SIT9531X_TDC_SIGN_BIT));=0A=
+	tdc_raw =3D (u64)(v & SIT9531X_TDC_MAG_HI_MASK) << 32;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_3, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 24;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_2, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 16;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_1, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D (u64)v << 8;=0A=
+=0A=
+	rc =3D sit9531x_read_pll_u8(sitdev, pll_idx,=0A=
+				  SIT9531X_PLL_REG_DBG_DATA_0, &v);=0A=
+	if (rc)=0A=
+		goto relock;=0A=
+	tdc_raw |=3D v;=0A=
+=0A=
+	/* Per the register map the sign bit set means a positive offset. */=0A=
+	tdc_signed =3D sign ? (s64)tdc_raw : -(s64)tdc_raw;=0A=
+=0A=
+	/*=0A=
+	 * phase_diff (ps) =3D tdc_code * 1e12 / fvco. Scale by the subsystem's=
=0A=
+	 * divider before dividing to keep the fractional digits; one code is=0A=
+	 * 203.45 ps at 4.9152 GHz.=0A=
+	 */=0A=
+	mag =3D mul_u64_u64_div_u64(tdc_signed < 0 ? -tdc_signed : tdc_signed,=0A=
+				  1000000000000ULL * DPLL_PHASE_OFFSET_DIVIDER,=0A=
+				  fvco);=0A=
+	*phase_offset =3D tdc_signed < 0 ? -(s64)mag : (s64)mag;=0A=
+=0A=
+	rc =3D 0;=0A=
+=0A=
+relock:=0A=
+	if (have_old) {=0A=
+		chan->tap_read_code =3D old_read_code;=0A=
+		chan->tap_write_code =3D old_write_code;=0A=
+		ret =3D sit9531x_tap_restore(sitdev, pll_idx);=0A=
+		if (ret)=0A=
+			chan->tap_pending =3D true;=0A=
+		if (ret && !rc)=0A=
+			rc =3D ret;=0A=
+	}=0A=
+=0A=
+	ret =3D sit9531x_write_pll_close(sitdev, pll_idx,=0A=
+				       SIT9531X_PLL_REG_DEBUG,=0A=
+				       SIT9531X_PLL_DEBUG_LOCK);=0A=
+	chan->key_pending =3D !!ret;=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /* Read the lane's receiver state from the Page 0x02 force and state bits =
*/=0A=
 static int sit9531x_ref_state_fetch(struct sit9531x_dev *sitdev, u8 index)=
=0A=
 {=0A=
@@ -2689,13 +2880,20 @@ static int sit9531x_chan_select_fetch(struct sit953=
1x_dev *sitdev, u8 pll_idx)=0A=
 	return 0;=0A=
 }=0A=
 =0A=
-/*=0A=
- * Read the reference the device feeds a PLL from the debug status bus; th=
e=0A=
- * active selection does not change on a fallback. The caller rules out fr=
ee-run=0A=
- * first and must hold sitdev->multiop_lock.=0A=
+/**=0A=
+ * sit9531x_chan_routed_ref_read - read the reference the device feeds a P=
LL=0A=
+ * @sitdev: device pointer=0A=
+ * @pll_idx: PLL index (0-3)=0A=
+ * @ref: logical input index, SIT9531X_INTSYNC_PIN_ID, or SIT9531X_REF_INV=
ALID=0A=
+ *=0A=
+ * The device falls back between listed sources without changing the activ=
e=0A=
+ * selection, so read the source from the debug status bus. The caller rul=
es=0A=
+ * out free-run first and must hold multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
  */=0A=
-static int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev,=0A=
-					 u8 pll_idx, u8 *ref)=0A=
+int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				  u8 *ref)=0A=
 {=0A=
 	int rc, lock_rc;=0A=
 	u8 v, i;=0A=
@@ -3189,10 +3387,32 @@ static void sit9531x_table_back_retry(struct sit953=
1x_dev *sitdev, u8 pll_idx)=0A=
 		 'A' + pll_idx);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Restore the debug taps and close the debug window after a failed phase-=
offset=0A=
+ * read. Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_tap_back_retry(struct sit9531x_dev *sitdev, u8 pll_id=
x)=0A=
+{=0A=
+	struct sit9531x_chan *chan =3D &sitdev->chan[pll_idx];=0A=
+=0A=
+	if (!chan->tap_pending && !chan->key_pending)=0A=
+		return;=0A=
+=0A=
+	if (chan->tap_pending &&=0A=
+	    !sit9531x_write_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_DEBUG,=0A=
+				   SIT9531X_PLL_DEBUG_UNLOCK))=0A=
+		sit9531x_tap_restore(sitdev, pll_idx);=0A=
+=0A=
+	chan->key_pending =3D !!sit9531x_write_pll_close(sitdev, pll_idx,=0A=
+						     SIT9531X_PLL_REG_DEBUG,=0A=
+						     SIT9531X_PLL_DEBUG_LOCK);=0A=
+}=0A=
+=0A=
 /*=0A=
  * Rewrite the priority table when a listed source returns to a PLL withou=
t a=0A=
- * reference; the latch restarts acquisition. Caller must hold=0A=
- * sitdev->multiop_lock.=0A=
+ * reference; the write latches the active selection again. Each latch res=
tarts=0A=
+ * acquisition, so the table is written once per change of the best live s=
ource.=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
  */=0A=
 static void sit9531x_reselect(struct sit9531x_dev *sitdev, u8 pll_idx)=0A=
 {=0A=
@@ -3273,6 +3493,7 @@ sit9531x_dev_chan_states_update(struct sit9531x_dev *=
sitdev)=0A=
 	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
 		sit9531x_table_back_retry(sitdev, i);=0A=
 		sit9531x_ho_release_retry(sitdev, i);=0A=
+		sit9531x_tap_back_retry(sitdev, i);=0A=
 		/*=0A=
 		 * A flush pulse sent into open loops may be lost when they=0A=
 		 * re-lock.=0A=
@@ -3525,55 +3746,30 @@ static void sit9531x_pin_nodes_check(struct sit9531=
x_dev *sitdev)=0A=
 	fwnode_handle_put(pins);=0A=
 }=0A=
 =0A=
-static int sit9531x_dev_start(struct sit9531x_dev *sitdev)=0A=
+/* Retry the pending debug tap restore and debug window close */=0A=
+static void sit9531x_tap_pending_retry(struct sit9531x_dev *sitdev)=0A=
 {=0A=
-	struct sit9531x_dpll *sitdpll;=0A=
-	int rc;=0A=
-=0A=
-	rc =3D sit9531x_dev_state_fetch(sitdev);=0A=
-	if (rc)=0A=
-		return rc;=0A=
+	u8 i;=0A=
 =0A=
 	mutex_lock(&sitdev->multiop_lock);=0A=
-	sit9531x_eeprom_state_report(sitdev);=0A=
-	sit9531x_pll_states_report(sitdev);=0A=
-	mutex_unlock(&sitdev->multiop_lock);=0A=
-=0A=
-	sit9531x_pin_nodes_check(sitdev);=0A=
-=0A=
-	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
-		rc =3D sit9531x_dpll_register(sitdpll);=0A=
-		if (rc) {=0A=
-			dev_err_probe(sitdev->dev, rc,=0A=
-				      "Failed to register DPLL%u\n",=0A=
-				      sitdpll->id);=0A=
-			goto err_unregister;=0A=
-		}=0A=
+	for (i =3D 0; i < SIT9531X_NUM_PLLS; i++) {=0A=
+		sit9531x_tap_back_retry(sitdev, i);=0A=
+		if (sitdev->chan[i].tap_pending || sitdev->chan[i].key_pending)=0A=
+			dev_warn(sitdev->dev,=0A=
+				 "PLL%c left with its debug taps moved or window open\n",=0A=
+				 'A' + i);=0A=
 	}=0A=
-=0A=
-	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
-=0A=
-	return 0;=0A=
-=0A=
-err_unregister:=0A=
-	list_for_each_entry_continue_reverse(sitdpll, &sitdev->dplls, list)=0A=
-		sit9531x_dpll_unregister(sitdpll);=0A=
-=0A=
-	return rc;=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
 }=0A=
 =0A=
-static void sit9531x_dev_stop(struct sit9531x_dev *sitdev)=0A=
+/*=0A=
+ * Retry every pending write once more and report what is still pending. C=
all=0A=
+ * with the DPLLs unregistered.=0A=
+ */=0A=
+static void sit9531x_dev_pending_retry(struct sit9531x_dev *sitdev)=0A=
 {=0A=
-	struct sit9531x_dpll *sitdpll;=0A=
 	u8 i;=0A=
 =0A=
-	kthread_cancel_delayed_work_sync(&sitdev->work);=0A=
-=0A=
-	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
-		if (sitdpll->dpll_dev)=0A=
-			sit9531x_dpll_unregister(sitdpll);=0A=
-	}=0A=
-=0A=
 	/*=0A=
 	 * Write back tables first: forced holdover stays set while a table=0A=
 	 * write-back is pending.=0A=
@@ -3637,6 +3833,61 @@ static void sit9531x_dev_stop(struct sit9531x_dev *s=
itdev)=0A=
 				 'A' + i);=0A=
 	}=0A=
 	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	sit9531x_tap_pending_retry(sitdev);=0A=
+}=0A=
+=0A=
+static int sit9531x_dev_start(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_dev_state_fetch(sitdev);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_eeprom_state_report(sitdev);=0A=
+	sit9531x_pll_states_report(sitdev);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	sit9531x_pin_nodes_check(sitdev);=0A=
+=0A=
+	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
+		rc =3D sit9531x_dpll_register(sitdpll);=0A=
+		if (rc) {=0A=
+			dev_err_probe(sitdev->dev, rc,=0A=
+				      "Failed to register DPLL%u\n",=0A=
+				      sitdpll->id);=0A=
+			goto err_unregister;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	kthread_queue_delayed_work(sitdev->kworker, &sitdev->work, 0);=0A=
+=0A=
+	return 0;=0A=
+=0A=
+err_unregister:=0A=
+	list_for_each_entry_continue_reverse(sitdpll, &sitdev->dplls, list)=0A=
+		sit9531x_dpll_unregister(sitdpll);=0A=
+=0A=
+	sit9531x_dev_pending_retry(sitdev);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static void sit9531x_dev_stop(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct sit9531x_dpll *sitdpll;=0A=
+=0A=
+	kthread_cancel_delayed_work_sync(&sitdev->work);=0A=
+=0A=
+	list_for_each_entry(sitdpll, &sitdev->dplls, list) {=0A=
+		if (sitdpll->dpll_dev)=0A=
+			sit9531x_dpll_unregister(sitdpll);=0A=
+	}=0A=
+=0A=
+	sit9531x_dev_pending_retry(sitdev);=0A=
 }=0A=
 =0A=
 static struct sit9531x_dpll_pin *=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index bbf5026f945d..8718c463c560 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -165,6 +165,10 @@ struct sit9531x_out {=0A=
  *   stays in forced holdover=0A=
  * @table_back: table reported and to be rewritten while @table_pending=0A=
  * @tap_pending: debug taps not restored after a phase-offset read=0A=
+ * @tap_write_code: tap selection to restore while @tap_pending=0A=
+ * @tap_read_code: readback selection to restore while @tap_pending=0A=
+ * @key_pending: debug key not locked again after a phase-offset read or t=
ap=0A=
+ *   retry=0A=
  * @prio_srcs: cached priority table, a source code per slot=0A=
  * @prio_last: first slot of each source plus one, 0 if absent=0A=
  * @prio_mask: bit per canonical source in the priority table read back=0A=
@@ -194,6 +198,9 @@ struct sit9531x_chan {=0A=
 	bool		table_pending;=0A=
 	u8		table_back[SIT9531X_PRIO_MAX_SLOTS];=0A=
 	bool		tap_pending;=0A=
+	u8		tap_write_code;=0A=
+	u8		tap_read_code;=0A=
+	bool		key_pending;=0A=
 	u8		prio_srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
 	u8		prio_last[SIT9531X_PRIO_NUM_SRC];=0A=
 	u16		prio_mask;=0A=
@@ -311,6 +318,12 @@ int sit9531x_output_phase_read(struct sit9531x_dev *si=
tdev, u8 out_idx,=0A=
 int sit9531x_output_phase_adjust_set(struct sit9531x_dev *sitdev,=0A=
 				     u8 out_idx, s32 phase_ps);=0A=
 =0A=
+int sit9531x_chan_routed_ref_read(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				  u8 *ref);=0A=
+int sit9531x_input_mon_fetch(struct sit9531x_dev *sitdev);=0A=
+int sit9531x_phase_offset_read(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       s64 *phase_offset);=0A=
+=0A=
 static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
 {=0A=
 	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index e6271ebd47ac..ba4ac5e7d365 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -488,6 +488,122 @@ sit9531x_dpll_input_pin_prio_set(const struct dpll_pi=
n *pin, void *pin_priv,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Report the loop's residual phase error, sampled with the loop closed. T=
he TDC=0A=
+ * compares against a signal the PLL drives, so a PLL driving no output re=
turns=0A=
+ * -ENODATA.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_phase_offset_get(const struct dpll_pin *pin,=0A=
+					 void *pin_priv,=0A=
+					 const struct dpll_device *dpll,=0A=
+					 void *dpll_priv, s64 *phase_offset,=0A=
+					 struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	bool drives =3D false;=0A=
+	u8 routed, i;=0A=
+	s64 offset;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * Check the cache first: the core calls this for every pin of every=0A=
+	 * DPLL in a dump.=0A=
+	 */=0A=
+	if (!sit9531x_dpll_selection_active(sitdev, sitdpll, dpin->id)) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return -ENODATA;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The device can change the routed reference, so read it before and=0A=
+	 * after the sample. A PLL with no routed, enabled output has no=0A=
+	 * measurement.=0A=
+	 */=0A=
+	for (i =3D 0; i < sitdev->info->num_outputs; i++) {=0A=
+		if (!sitdev->out[i].routed ||=0A=
+		    sitdev->out[i].pll_idx !=3D sitdpll->id)=0A=
+			continue;=0A=
+		if (sitdev->out[i].state_stale) {=0A=
+			rc =3D sit9531x_output_state_refresh(sitdev, i);=0A=
+			if (rc) {=0A=
+				mutex_unlock(&sitdev->multiop_lock);=0A=
+				NL_SET_ERR_MSG(extack,=0A=
+					       "Output mute state could not be read back");=0A=
+				return rc;=0A=
+			}=0A=
+		}=0A=
+		if (sitdev->out[i].enabled)=0A=
+			drives =3D true;=0A=
+	}=0A=
+=0A=
+	if (!drives) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return -ENODATA;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * Read the monitors live: on loss of signal the device falls back=0A=
+	 * without a request.=0A=
+	 */=0A=
+	rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
+	if (rc) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Failed to read the input clock monitors");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	if (!sit9531x_dpll_selection_active(sitdev, sitdpll, dpin->id)) {=0A=
+		mutex_unlock(&sitdev->multiop_lock);=0A=
+		return -ENODATA;=0A=
+	}=0A=
+=0A=
+	rc =3D sit9531x_chan_routed_ref_read(sitdev, sitdpll->id, &routed);=0A=
+	if (!rc && routed =3D=3D dpin->id) {=0A=
+		rc =3D sit9531x_phase_offset_read(sitdev, sitdpll->id, &offset);=0A=
+		if (!rc)=0A=
+			rc =3D sit9531x_chan_routed_ref_read(sitdev, sitdpll->id,=0A=
+							   &routed);=0A=
+		if (!rc && routed !=3D dpin->id)=0A=
+			rc =3D -ENODATA;=0A=
+	} else if (!rc) {=0A=
+		rc =3D -ENODATA;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * A reference lost during the sample can leave the routed reference=0A=
+	 * unchanged while the PLL is in holdover; read the monitors again.=0A=
+	 */=0A=
+	if (!rc) {=0A=
+		rc =3D sit9531x_input_mon_fetch(sitdev);=0A=
+		if (rc) {=0A=
+			mutex_unlock(&sitdev->multiop_lock);=0A=
+			NL_SET_ERR_MSG(extack,=0A=
+				       "Failed to read the input clock monitors");=0A=
+			return rc;=0A=
+		}=0A=
+		if (dpin->id < sitdev->info->num_inputs &&=0A=
+		    sit9531x_ref_state_get(sitdev, dpin->id)->los)=0A=
+			rc =3D -ENODATA;=0A=
+	}=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	if (rc =3D=3D -ENODATA)=0A=
+		return rc;=0A=
+	if (rc) {=0A=
+		NL_SET_ERR_MSG(extack, "TDC phase readback failed");=0A=
+		return rc;=0A=
+	}=0A=
+=0A=
+	*phase_offset =3D offset;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
@@ -496,6 +612,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pi=
n_ops =3D {=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
 	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -509,6 +626,7 @@ static const struct dpll_pin_ops sit9531x_dpll_input_pi=
n_norate_ops =3D {=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
 	.prio_get		=3D sit9531x_dpll_input_pin_prio_get,=0A=
 	.prio_set		=3D sit9531x_dpll_input_pin_prio_set,=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
 };=0A=
 =0A=
 /*=0A=
@@ -520,12 +638,14 @@ static const struct dpll_pin_ops sit9531x_dpll_input_=
pin_manual_ops =3D {=0A=
 	.frequency_get		=3D sit9531x_dpll_input_pin_frequency_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
 };=0A=
 =0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_norate_manual_ops=
 =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
 	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
 	.operstate_on_dpll_get	=3D sit9531x_dpll_input_pin_operstate_on_dpll_get,=
=0A=
+	.phase_offset_get	=3D sit9531x_dpll_input_pin_phase_offset_get,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 8c76609b99c5..d6c6b4a6a6bb 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -229,6 +229,25 @@=0A=
 #define SIT9531X_PLL_REG_DIVN_NUM		0x32  /* 4 bytes (0x32-0x35) */=0A=
 #define SIT9531X_PLL_REG_DIVN_DEN		0x38  /* 4 bytes (0x38-0x3B) */=0A=
 =0A=
+/*=0A=
+ * Signal pathway debug readback: Dig_Sys_ReadCode selects the tap,=0A=
+ * Dig_Sys_WriteCode its modifiers; a read of the debug status data regist=
er=0A=
+ * latches a sample into Dig_Sys_read7..read0.=0A=
+ */=0A=
+#define SIT9531X_PLL_REG_DBG_READ_CODE	0xB3=0A=
+#define SIT9531X_PLL_REG_DBG_WRITE_CODE	0xB4=0A=
+#define SIT9531X_DBG_LOW_FREQ_CLK_BIT	BIT(7)=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_0		0xB5  /* [7:0] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_1		0xB6  /* [15:8] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_2		0xB7  /* [23:16] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_3		0xB8  /* [31:24] */=0A=
+#define SIT9531X_PLL_REG_DBG_DATA_4		0xB9  /* [34:32] + sign */=0A=
+=0A=
+/* Read code of the TDC phase tap, and the sign bit of its sample */=0A=
+#define SIT9531X_DBG_READ_CODE_TDC		69=0A=
+#define SIT9531X_TDC_SIGN_BIT		3=0A=
+#define SIT9531X_TDC_MAG_HI_MASK	GENMASK(2, 0)=0A=
+=0A=
 /* DIVN is carried as fixed point, in steps of 1e-12 of a whole divider */=
=0A=
 #define SIT9531X_DIVN_SCALE		1000000000000ULL=0A=
 =0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
