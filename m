Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794342403;
	b=CAXQenZo4j+uEMYlidh60rM05jEgqAb3RJV9Sk99JRHY93lN4Ef79XCbBHOJkW56th/d
	 +DDlTzMowMM2I4L5X+Ol8g3fZqt62TVrhWKRsssAJxyKjeKrZHC5F93NkQYaVmS5FF/mc
	 zAztGftIa7xwY1Ic8jeJ2ORNJENVBVzm++NdVmyJP0n9aEjhbQagQVvIyGozxUSW/j4JD
	 sAFk4u8Vb6HW8QmtnqjoS+e54eRVdX8YyubZsoedzTKOswSEqcmJSHtjBQOD0o6kh7LLZ
	 YgdbZQ0NI9U4hHzk13a8k47lFcuOgRAvH8Elr0s78VwXvWWhJzvgCL7/oUymgBOfj4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342403;
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
	bh=mYFfvd85jBKWhv1k5XsijW0QHRvgqAs1DfMd4q6D3wI=;
	b=FoujgKOuBEB4wljmiqlmTDqt+tTRlKXnrGvc8YP3L0iN8UjrtOmCRyo32JANA1FDYZ3A
	 aTW2yH13nV+qbJnlXEcO2R6fnNG3GOoAfrcZUER5ZoxFZdqqfmyDhSET2eUf95CUdn1Ng
	 v7BNEFqq7mHaYR//ZVpj8AXjyvUIWqu0be2zRHkinA1YcEQCMoQV1HchJsrxs4lEmG4WU
	 dsnNbMUbcZ+ryNCG/pUV0Qbaqi5inifYq5CcdvdfN4peLB2oC5HD9F4owp16UWuw9zUe7
	 +J73Y0ojZ/aTjuTMWtedsFN/H5BDkqXPgukFxX1wyv7HXhttml4j6DYLVw2Dc1bTK6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sitime.com;
	spf=pass smtp.mailfrom=sitime.com;
	dkim=pass header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=h+RsXzXw;
	dkim=pass header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=Murp+VaB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.129.52
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB7A606BA5B;
	Tue, 10 Nov 2026 20:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AB7A606BA5B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.a=rsa-sha256 header.s=mail header.b=h+RsXzXw;
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-Sitime-onmicrosoft-com header.b=Murp+VaB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=mYFfvd85jBKWhv1k5XsijW0QHRvgqAs1DfMd4q6D3wI=;
 b=h+RsXzXwC8Jaw84mZlvmUY//ipeRhp9C9gIp8lYsG25IKVKNlh/ZaghN4FGJyFlJzW0FHmJCEs3RzCaebxBe+Ah1zg0cpdFXZ07rdWhJtis4m9B39qbdS2B4IrzdR5DI8mBQ+tDSKGk8VBr/6I126MODhmHJHgrDOdAcl5gHPlBigPkX0XJjnxGDyLtt43Aa/Yvq6JwtrQQ5fBgVlWPajb+RC256TwpRojX/NDR4B3+ebsjqPKZNzP2BTn023DyZQ7eB5NT5te0Qegt/1ohepqAQ7Km3T0e/3TdsUEcjO3aakQrHXVGB+7/vOejP0V2UmdLIHNcTfLnEgVO3OiyYow==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020092.outbound.protection.outlook.com [40.93.198.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 34A3D280064;
	Tue, 10 Nov 2026 20:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YREpw/1k5zdHQOpkCVzV4CrMThI9UeMIQi2iL1E4/C8dS7PZxcLjkoax+A15Zdcv7ZabiHWqi2ez/mRw4bxXDrV74qToqMqtW1/+sxv9ppZb3LGmN5OUyqwECZ3pKkMGfVKjH5fQyHS9HYelxuBSoWo+TKyJrgbEKXRq9/VDt4rkP4SoEpNWvI/LOvrMWmoedk5fRLueNSfiiTIfk1ihVFcMeBwyR4PKGoj6VCnpuOVFnKABYktTMg7Tj01oFfrHfuRP0+nV1VtDATXO5fto0beuElOCtH3zRieA3SH+ybTGJYX5ZKcYOgHlctf9/MlB7pzAwMVey4LZsiq6L2EKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYFfvd85jBKWhv1k5XsijW0QHRvgqAs1DfMd4q6D3wI=;
 b=XFgjeVW2Rg9mlln7ORGsiGMn0DKN0Kx0lAdeCa5r61jwJc2wK1oRt1N6cAsYd5nkOLOHYvz4q1YEfSbWQgw+bj7biV6Dw2K3bevGCzB4iLl9bxP1/41YPLbuAz4b+sOptIr0U9ZOXf4xRXxk8DrtV/fcoIG0RKud4dhRVfB9oc2QHQ3tObbDTFzceymamZ3YORcSjdyzu5z0G09WUsH6IB/nRvqZXvHoEq7pOoSv+jKdclvm5L22H0txiHUZCcRdKIhj5zkx9rF2UvqqEmQim2XH32HKKzHmiI9yc1It8Hr2lEuC6ypoH0e8O1XnUl7j8U3ke2PNJIEd9p64CJTRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYFfvd85jBKWhv1k5XsijW0QHRvgqAs1DfMd4q6D3wI=;
 b=Murp+VaBx2DRG2LhQVuW/udAhwBCEt7HbB9sLjkFDv1Dc2YDgtbTz76v4bSI1Arujq6Deue/uVexPUKL6XASYJS0HV5gGX4MkL3FTuWQ7/2fX7mG50jkD5AhNYB4RKn/MYvvbcNG+mF5w0k8NEv4f5fy5W6QS3oQPEVuTgUpt3U7HSch4dGeuLmXwaJy0l33QLaWpfVieQ19qFI8J2RcBFgMToXmiTRGiokNYyaCAZHDqZX90iZIKCB+qzWeYdKgXq0hD1EWN1Ll8coq6S9LpNeAqY6FhOk+f9EpoxXg3s0AADO0hPkaZHDZL9mYQKTZAIQPwJNWEgq7N8muQ5pm/Q==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH3PR20MB5745.namprd20.prod.outlook.com
 (2603:10b6:610:14d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:26:14 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 20:26:14 +0000
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
Subject: [PATCH net-next v15 04/13] dpll: add basic SiTime SiT9531x support
Thread-Topic: [PATCH net-next v15 04/13] dpll: add basic SiTime SiT9531x
 support
Thread-Index: AQHdcVG5ugD90PBkuUyHv55svtfJww==
Date: Tue, 10 Nov 2026 20:26:11 +0000
Message-ID: <20261110202607.55744-5-arouhi@sitime.com>
References: <20261110202607.55744-1-arouhi@sitime.com>
In-Reply-To: <20261110202607.55744-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH3PR20MB5745:EE_
x-ms-office365-filtering-correlation-id: 7dfd73f5-068d-4cbb-6279-08df3f68dddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|38070700021|56012099006|5023799004|18002099003|22082099003|6133799003|10067099003|261009223027099003|261021121427099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261022113327099003|3023799007;
x-microsoft-antispam-message-info:
 V0SYEOnZ3RT8skTJdVPVB886jLlyja1tNpCZsXTAimoXEvz+gXNaa94v8ZeK2WjSBda3OLJrbUgsTTJM/WVkdquXWyCgUhFeAu8LbFlVxO+cAIg3pYk6vYJhjma1D5qX8yh1Rin/3gVY5I3as2aRzpZ7geGd8IOR9iU0teJqXXlsJ+fEsJ/M3BEzTyA1zw9vOGEucsyWpY5J5IhcUDSVoM+pHBM/kXPCmRH+vPv2a6ErumdZTJMjJmLmCAExugmQ6T8Cf5Z+cWt10X2FpcCNkQ47w3RTxylgTRGPJSfX0XdtIdxjDGlPZ6E1/jjxdsMU5MJccQ7IhuI9o18WrAWPGXczdqcVl9q+EUcm+/XKGUtmoHLbShZoRI1BSVOSPtrAcQaQ7TLl2VuYFFnOxg4/ujxDJxRtRYyV1sYUXMhSvGjMeX6rei5KCv8rq9GqEyLPSlyXiM2FA2r7QrfZm2a7U8DL0CTiE6TfmzEWUmh/+aDy2X6taFcNfwE//5B3WaWfv6o/fLqxmGoMnad/OSYP27un67VkmPj1rmDMxkgs63Nysjq+eNRuLfI77+zHgPfWu05xNYn43SPn+FTpxww3e0fouObAYEI7d7B8CIQCP5fYBcfN1lmYU5ON9SoQgvFiZygfrSSZEsT7CHbbahMQB7ZhBpQa/S/XgquhiprkGHSQJrNHpiKNiNiPfwnVugcr422k4opYf4JBN/GKjrhRKckDUAp0SmpaIlt7WOTIjYg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(38070700021)(56012099006)(5023799004)(18002099003)(22082099003)(6133799003)(10067099003)(261009223027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022113327099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FOQOziP+DHgHcVsEDRuCuPwaYcsafY1sA2D0Cmd9dJN7/ozH5xjLYSP/CG?=
 =?iso-8859-1?Q?Cj4ZHpsPhuITaDaURhYlMF12nTal41jdeCBl9uhal9Qbgk5vxOhkyCV+I7?=
 =?iso-8859-1?Q?c7BRAuGngETLgW8Z35vvC0nVZSI06xgY7r8aFMI0PQj2M3UzJnAucGqBn/?=
 =?iso-8859-1?Q?eZdLZR6fNgbvabpD5RPVW5A4zBY+hMmOggMH6vMKFL3sMmXUL8aDVPVXZo?=
 =?iso-8859-1?Q?HZ5SURCi2Slh3wfCKMRh/1EA8iHMupoOBOgatlKxUA1OU71oyYaaNYad3z?=
 =?iso-8859-1?Q?Q2C9kN4ntRUJK80PwfUK2Bl3/Jre9PP5foggIXMEuLM3YPkcrq8zsvwIHE?=
 =?iso-8859-1?Q?4facibCZq4XiC9mCYEKphCxnTAlFmDUQ/CJaXKUEzytyR3R8WzHI5pYuvT?=
 =?iso-8859-1?Q?kuA+RZ72idffxzIuTZPNq94PiqXzM8Qyq/90slMjBGdUx7gDOnjwGwi7GL?=
 =?iso-8859-1?Q?Wsr21aa1IGPRhxz+BzcAGxD0s2hczhEJDXn7cQRteDjRgOnTjWUTCDsI3k?=
 =?iso-8859-1?Q?qvwK8ih+BbHvvoMmNmcZfPP03iOTi/a55nywXRDYhEXvN2ueh7reqrUP73?=
 =?iso-8859-1?Q?njTNf1xClE3yPjYmZ1rVIyXOcm2AhbKX+jHqSI5VHoQDElyuTOvPXlx/U6?=
 =?iso-8859-1?Q?EDIUpp99XnlU0rsY8zdNEkrV5dXekPEBgBda5EAw7mJRjiV7QuBuVw1ibX?=
 =?iso-8859-1?Q?PmT5lXXWgdhytPjCIw9uaO0YWQ9+S3ef0DAEmwhZ+3zpBFSToXsMBN4bn+?=
 =?iso-8859-1?Q?cSaaFBSlBiTBDe12CmBnaRArVIfN9oj5S5Y7ZAVpLoujbCRyrWwWuKQABL?=
 =?iso-8859-1?Q?g+KECMfCim2Pe8IhdLrtCjUJ/MfnVNHEdwOFdkXxynyXuxbFOeB24v0bSd?=
 =?iso-8859-1?Q?pCRjPu1ag17tWExFFyDC9nKBSqV1dQkDoL6nMMq2p5cYvADhFjeYIamdPs?=
 =?iso-8859-1?Q?2aV0EkWop/PZA8Ahd4fyUfnt7azmcGcAYyGkgVUBJmoyQFAhMLtJGtj1+I?=
 =?iso-8859-1?Q?gPssDuz75H6rmj674ABxv7Jkf7sP0kq4S+XpSFkvoksfa0qWXONlQsW/RH?=
 =?iso-8859-1?Q?Qz1pdv4dUGCIdI+aPbdOLCWyvaxfalu0eKvT4xeuLOhCorhH+tm4kjE2uE?=
 =?iso-8859-1?Q?R8k5H/+zCTgri/M4qqHbac4fwVCqySTelhegA8p/0zezxpt2TGmLjdQGNQ?=
 =?iso-8859-1?Q?aO7svnZNQsA2BtEZcj77Pp6JAeLBHf7ma1wPpvyjp4BLAiX3TJ8NCyjWg8?=
 =?iso-8859-1?Q?7/8/hsnifh+ypZhCASwxbN70TypopbSd3OrRBqU8yxcKYafhgLcdGvfg1R?=
 =?iso-8859-1?Q?ClCpbLD9hDcVxSWWYeZoQVe0JNnHZ5kyl5A8pcjaTxkuaZk32DqJIOn2rL?=
 =?iso-8859-1?Q?V8zlEmNlZNm/+/qEOAU9DhXfr2zrgUsM+jhxTIJYABpqMf1v4ZsvbX1es6?=
 =?iso-8859-1?Q?BabracFTaB/cso/NbHZii56h3U3TOkF8hVtY0OUtF06JHLxOBVSLAmY6GS?=
 =?iso-8859-1?Q?LSJIpbI+eocSqn1GgG2QdZFvMjKK65e7Q7HY6ViienHgaJNb2Sl/Nbc5MR?=
 =?iso-8859-1?Q?yxxflC/mfyK5i8bSy6dn7qneEJtUX25neJpG5o2yDv8PVy7wv3hBaQ0ASJ?=
 =?iso-8859-1?Q?mYs8fcuCBolj9oa6k4mijrxEhr6F6s3vjX0sN3SxMotXvZ5CG/dFVCO4uN?=
 =?iso-8859-1?Q?UODWKkAMW7BdhosgdQQ1ko+Y8WXXLfcWhB+c/SFggTHVvF48JdU1r5WkRR?=
 =?iso-8859-1?Q?7C4Zgkqy6Vs3QvtYxbN8O+E6bQB16tOUDVLfYVDnCc8gK9?=
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
	MesZGGx9dyZc3xDxzOyYZJjMCQjMgaHqZoAg6SNm5b+J47GzBqKhN54EU+BMVGmMg62BlhNXou5tITfgPkl7xUwO/56QzoToY/OWmhIXhMv6MxeOKWoC+0xjJbrU/bzmjIh0zP0q/gk/O8/gg8p4rqfugTpUNIWO5uol0XnN4KcdVMXAZHOlwi0DzmhGH4c2+v75bV5Z3f8QL1SXJwfOhy54bgXIQiKF2k/MMe4Y+5j95kPoNp8mQHDi93U+BI/0v8UTm/vd1DXS/MvZb6ZeDYUW5Fgup346TNuh/5W37SxT55d0PmUvLgVKtC6lInN9kBQXGRNNI3BEqKt7DqrF4A==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfd73f5-068d-4cbb-6279-08df3f68dddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 20:26:11.6813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEFTE0CjnzO99NogQgAIxajjyV78mVG+wT78nPz3S07JMrazUC4Yy4y4735cCQv8+SJiEAVOnO47zhKyrOLGJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB5745
X-MDID: 1794342400-OIm6wKD9LmN0
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1794342400;OIm6wKD9LmN0;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Add the I2C probe for the SiTime SiT9531x family: four PLLs, up to eight=0A=
inputs and up to twelve outputs, configured from efuse or from a blob=0A=
applied before the driver binds. Later patches register the PLLs with=0A=
the DPLL subsystem.=0A=
=0A=
The register space is 32 pages of 256 registers, selected through offset=0A=
0xFF of any page. The regmap is the flat 256-byte window, and the=0A=
accessors select the page under a lock.=0A=
=0A=
Probe takes the optional reset line and the XO rate, waits the boot time=0A=
with reset deasserted so the configuration the part holds is kept, and=0A=
identifies the variant from the ID register.=0A=
=0A=
Suggested-by: Ivan Vecera <ivecera@redhat.com>=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 MAINTAINERS                    |   1 +=0A=
 drivers/dpll/Kconfig           |   2 +=0A=
 drivers/dpll/Makefile          |   1 +=0A=
 drivers/dpll/sit9531x/Kconfig  |  13 ++=0A=
 drivers/dpll/sit9531x/Makefile |   4 +=0A=
 drivers/dpll/sit9531x/core.c   | 308 +++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h   |  88 ++++++++++=0A=
 drivers/dpll/sit9531x/regs.h   |  36 ++++=0A=
 8 files changed, 453 insertions(+)=0A=
 create mode 100644 drivers/dpll/sit9531x/Kconfig=0A=
 create mode 100644 drivers/dpll/sit9531x/Makefile=0A=
 create mode 100644 drivers/dpll/sit9531x/core.c=0A=
 create mode 100644 drivers/dpll/sit9531x/core.h=0A=
 create mode 100644 drivers/dpll/sit9531x/regs.h=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 6c831bf9e812..936996cef03a 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -25875,6 +25875,7 @@ M:	Ali Rouhi <arouhi@sitime.com>=0A=
 L:	netdev@vger.kernel.org=0A=
 S:	Maintained=0A=
 F:	Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml=0A=
+F:	drivers/dpll/sit9531x/=0A=
 =0A=
 SL28 CPLD MFD DRIVER=0A=
 M:	Michael Walle <mwalle@kernel.org>=0A=
diff --git a/drivers/dpll/Kconfig b/drivers/dpll/Kconfig=0A=
index be98969f040a..f8f7ca121b93 100644=0A=
--- a/drivers/dpll/Kconfig=0A=
+++ b/drivers/dpll/Kconfig=0A=
@@ -23,6 +23,8 @@ config DPLL_REFCNT_TRACKER=0A=
 =0A=
 	  If unsure, say N.=0A=
 =0A=
+source "drivers/dpll/sit9531x/Kconfig"=0A=
+=0A=
 source "drivers/dpll/zl3073x/Kconfig"=0A=
 =0A=
 endmenu=0A=
diff --git a/drivers/dpll/Makefile b/drivers/dpll/Makefile=0A=
index 9e7a3a3e592e..4adc50d748d4 100644=0A=
--- a/drivers/dpll/Makefile=0A=
+++ b/drivers/dpll/Makefile=0A=
@@ -8,4 +8,5 @@ dpll-y                  +=3D dpll_core.o=0A=
 dpll-y                  +=3D dpll_netlink.o=0A=
 dpll-y                  +=3D dpll_nl.o=0A=
 =0A=
+obj-$(CONFIG_SIT9531X_DPLL)	+=3D sit9531x/=0A=
 obj-$(CONFIG_ZL3073X)	+=3D zl3073x/=0A=
diff --git a/drivers/dpll/sit9531x/Kconfig b/drivers/dpll/sit9531x/Kconfig=
=0A=
new file mode 100644=0A=
index 000000000000..ac5b7f31a034=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/Kconfig=0A=
@@ -0,0 +1,13 @@=0A=
+# SPDX-License-Identifier: GPL-2.0-only=0A=
+=0A=
+config SIT9531X_DPLL=0A=
+	tristate "SiTime SiT9531x DPLL driver"=0A=
+	depends on I2C && NET=0A=
+	select DPLL=0A=
+	select REGMAP_I2C=0A=
+	help=0A=
+	  Driver for SiTime SiT9531x family clock generators=0A=
+	  (SiT95317, SiT95316).=0A=
+=0A=
+	  To compile this driver as a module, choose M here: the=0A=
+	  module will be called sit9531x.=0A=
diff --git a/drivers/dpll/sit9531x/Makefile b/drivers/dpll/sit9531x/Makefil=
e=0A=
new file mode 100644=0A=
index 000000000000..a221fe55386a=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/Makefile=0A=
@@ -0,0 +1,4 @@=0A=
+# SPDX-License-Identifier: GPL-2.0-only=0A=
+=0A=
+obj-$(CONFIG_SIT9531X_DPLL) +=3D sit9531x.o=0A=
+sit9531x-y :=3D core.o=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
new file mode 100644=0A=
index 000000000000..3ec1ab5aa56c=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -0,0 +1,308 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL core driver=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * I2C probe, paged regmap configuration and register access helpers.=0A=
+ */=0A=
+=0A=
+#include <linux/bits.h>=0A=
+#include <linux/clk.h>=0A=
+#include <linux/delay.h>=0A=
+#include <linux/dev_printk.h>=0A=
+#include <linux/device.h>=0A=
+#include <linux/gpio/consumer.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/module.h>=0A=
+#include <linux/property.h>=0A=
+#include <linux/regmap.h>=0A=
+=0A=
+#include "core.h"=0A=
+#include "regs.h"=0A=
+=0A=
+#define SIT9531X_CHIP(_id, _nin, _nout, _name, _map) \=0A=
+	{ .id =3D (_id), .num_inputs =3D (_nin), .num_outputs =3D (_nout), \=0A=
+	  .name =3D (_name), .clkout_map =3D (_map) }=0A=
+=0A=
+/* Per-variant output index -> physical slot mapping */=0A=
+static const u8 clkout_map_95317[] =3D {0, 3, 4, 5, 7, 8, 9, 11};=0A=
+static const u8 clkout_map_95316[] =3D {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, =
11};=0A=
+=0A=
+static const struct sit9531x_chip_info sit9531x_chip_ids[] =3D {=0A=
+	SIT9531X_CHIP(SIT9531X_VARIANT_ID_95317, 8, 8, "SiT95317",=0A=
+		      clkout_map_95317),=0A=
+	SIT9531X_CHIP(SIT9531X_VARIANT_ID_95316, 8, 12, "SiT95316",=0A=
+		      clkout_map_95316),=0A=
+};=0A=
+=0A=
+/*=0A=
+ * One 256-register page is visible at a time, selected by offset 0xFF on =
every=0A=
+ * page. The map covers that window, uncached; the accessors select the pa=
ge.=0A=
+ */=0A=
+static const struct regmap_config sit9531x_regmap_config =3D {=0A=
+	.reg_bits	=3D 8,=0A=
+	.val_bits	=3D 8,=0A=
+	.max_register	=3D SIT9531X_PAGE_SEL,=0A=
+	.cache_type	=3D REGCACHE_NONE,=0A=
+};=0A=
+=0A=
+/* Caller holds page_lock. */=0A=
+static int sit9531x_page_select(struct sit9531x_dev *sitdev, int page)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	if (sitdev->page =3D=3D page)=0A=
+		return 0;=0A=
+=0A=
+	sitdev->page =3D -1;=0A=
+	rc =3D regmap_write(sitdev->regmap, SIT9531X_PAGE_SEL, page);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	sitdev->page =3D page;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* Caller holds page_lock. */=0A=
+static int sit9531x_read_locked(struct sit9531x_dev *sitdev, unsigned int =
reg,=0A=
+				unsigned int *val)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_page_select(sitdev, SIT9531X_REG_PAGE(reg));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D regmap_read(sitdev->regmap, SIT9531X_REG_OFFSET(reg), val);=0A=
+	if (rc)=0A=
+		sitdev->page =3D -1;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/* Caller holds page_lock. */=0A=
+static int sit9531x_write_locked(struct sit9531x_dev *sitdev,=0A=
+				 unsigned int reg, u8 val)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_page_select(sitdev, SIT9531X_REG_PAGE(reg));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D regmap_write(sitdev->regmap, SIT9531X_REG_OFFSET(reg), val);=0A=
+	if (rc)=0A=
+		sitdev->page =3D -1;=0A=
+	else if (SIT9531X_REG_OFFSET(reg) =3D=3D SIT9531X_PAGE_SEL)=0A=
+		sitdev->page =3D val;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/* @reg is a SIT9531X_REG(page, offset) value. */=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		     u8 *val)=0A=
+{=0A=
+	unsigned int tmp;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->page_lock);=0A=
+	rc =3D sit9531x_read_locked(sitdev, reg, &tmp);=0A=
+	mutex_unlock(&sitdev->page_lock);=0A=
+	if (rc) {=0A=
+		dev_err_ratelimited(sitdev->dev,=0A=
+				    "Failed to read page 0x%02x reg 0x%02x: %d\n",=0A=
+				    SIT9531X_REG_PAGE(reg),=0A=
+				    SIT9531X_REG_OFFSET(reg), rc);=0A=
+		return rc;=0A=
+	}=0A=
+	*val =3D (u8)tmp;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* @reg is a SIT9531X_REG(page, offset) value. */=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		      u8 val)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->page_lock);=0A=
+	rc =3D sit9531x_write_locked(sitdev, reg, val);=0A=
+	mutex_unlock(&sitdev->page_lock);=0A=
+	if (rc)=0A=
+		dev_err_ratelimited(sitdev->dev,=0A=
+				    "Failed to write page 0x%02x reg 0x%02x: %d\n",=0A=
+				    SIT9531X_REG_PAGE(reg),=0A=
+				    SIT9531X_REG_OFFSET(reg), rc);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			 u8 offset, u8 *val)=0A=
+{=0A=
+	u8 page =3D sit9531x_pll_page(pll_idx);=0A=
+=0A=
+	return sit9531x_read_u8(sitdev, SIT9531X_REG(page, offset), val);=0A=
+}=0A=
+=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			  u8 offset, u8 val)=0A=
+{=0A=
+	u8 page =3D sit9531x_pll_page(pll_idx);=0A=
+=0A=
+	return sit9531x_write_u8(sitdev, SIT9531X_REG(page, offset), val);=0A=
+}=0A=
+=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			   u8 offset, u8 mask, u8 val)=0A=
+{=0A=
+	u8 page =3D sit9531x_pll_page(pll_idx);=0A=
+	unsigned int reg =3D SIT9531X_REG(page, offset);=0A=
+	unsigned int orig, tmp;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->page_lock);=0A=
+	rc =3D sit9531x_read_locked(sitdev, reg, &orig);=0A=
+	if (!rc) {=0A=
+		tmp =3D (orig & ~mask) | (val & mask);=0A=
+		if (tmp !=3D orig)=0A=
+			rc =3D sit9531x_write_locked(sitdev, reg, tmp);=0A=
+	}=0A=
+	mutex_unlock(&sitdev->page_lock);=0A=
+	if (rc)=0A=
+		dev_err_ratelimited(sitdev->dev,=0A=
+				    "Failed to update page 0x%02x reg 0x%02x: %d\n",=0A=
+				    page, offset, rc);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+static int sit9531x_read_variant_id(struct sit9531x_dev *sitdev, u8 *id)=
=0A=
+{=0A=
+	return sit9531x_read_u8(sitdev, SIT9531X_REG_VARIANT_ID, id);=0A=
+}=0A=
+=0A=
+static const struct sit9531x_chip_info *sit9531x_match_variant(u8 id)=0A=
+{=0A=
+	unsigned int i;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(sit9531x_chip_ids); i++) {=0A=
+		if (sit9531x_chip_ids[i].id =3D=3D id)=0A=
+			return &sit9531x_chip_ids[i];=0A=
+	}=0A=
+=0A=
+	return NULL;=0A=
+}=0A=
+=0A=
+static int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct clk *xtal_clk;=0A=
+	u8 variant_id;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Fvco =3D Fref * (DIVN + frac/2^32); Fref is the rate of the XO feeding=
=0A=
+	 * XIN/XO_CLK.=0A=
+	 */=0A=
+	xtal_clk =3D devm_clk_get_optional_enabled(sitdev->dev, "xtal");=0A=
+	if (IS_ERR(xtal_clk))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(xtal_clk),=0A=
+				     "Failed to get xtal clock\n");=0A=
+	sitdev->xtal_freq =3D clk_get_rate(xtal_clk);=0A=
+	if (!sitdev->xtal_freq) {=0A=
+		u32 freq;=0A=
+=0A=
+		if (!device_property_read_u32(sitdev->dev, "clock-frequency",=0A=
+					      &freq))=0A=
+			sitdev->xtal_freq =3D freq;=0A=
+	}=0A=
+	if (!sitdev->xtal_freq)=0A=
+		return dev_err_probe(sitdev->dev, -EINVAL,=0A=
+				     "no xtal rate: provide clocks=3D<&xo> + clock-names=3D\"xtal\", o=
r a clock-frequency property\n");=0A=
+=0A=
+	/*=0A=
+	 * Keep reset deasserted, never pulse it: a reset discards the=0A=
+	 * configuration from efuse or a pre-probe NVM blob. Release it before=0A=
+	 * the first I2C access.=0A=
+	 */=0A=
+	sitdev->reset_gpio =3D devm_gpiod_get_optional(sitdev->dev, "reset",=0A=
+						     GPIOD_OUT_LOW);=0A=
+	if (IS_ERR(sitdev->reset_gpio))=0A=
+		return dev_err_probe(sitdev->dev, PTR_ERR(sitdev->reset_gpio),=0A=
+				     "Failed to request reset gpio\n");=0A=
+	if (sitdev->reset_gpio)=0A=
+		fsleep(10000);	/* internal boot after release */=0A=
+=0A=
+	rc =3D sit9531x_read_variant_id(sitdev, &variant_id);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	sitdev->info =3D sit9531x_match_variant(variant_id);=0A=
+	if (!sitdev->info)=0A=
+		return dev_err_probe(sitdev->dev, -ENODEV,=0A=
+				     "Unknown variant ID: 0x%02x\n",=0A=
+				     variant_id);=0A=
+=0A=
+	rc =3D devm_mutex_init(sitdev->dev, &sitdev->multiop_lock);=0A=
+	if (rc)=0A=
+		return dev_err_probe(sitdev->dev, rc,=0A=
+				     "Failed to initialize mutex\n");=0A=
+=0A=
+	dev_info(sitdev->dev, "%s detected, %u inputs, %u outputs\n",=0A=
+		 sitdev->info->name, sitdev->info->num_inputs,=0A=
+		 sitdev->info->num_outputs);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int sit9531x_i2c_probe(struct i2c_client *client)=0A=
+{=0A=
+	struct sit9531x_dev *sitdev;=0A=
+	struct regmap *regmap;=0A=
+	int rc;=0A=
+=0A=
+	regmap =3D devm_regmap_init_i2c(client, &sit9531x_regmap_config);=0A=
+	if (IS_ERR(regmap))=0A=
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),=0A=
+				     "Failed to initialize regmap\n");=0A=
+=0A=
+	sitdev =3D devm_kzalloc(&client->dev, sizeof(*sitdev), GFP_KERNEL);=0A=
+	if (!sitdev)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	sitdev->dev =3D &client->dev;=0A=
+	sitdev->client =3D client;=0A=
+	sitdev->regmap =3D regmap;=0A=
+	sitdev->page =3D -1;=0A=
+	rc =3D devm_mutex_init(&client->dev, &sitdev->page_lock);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	i2c_set_clientdata(client, sitdev);=0A=
+=0A=
+	return sit9531x_dev_probe(sitdev);=0A=
+}=0A=
+=0A=
+static const struct of_device_id sit9531x_of_match[] =3D {=0A=
+	{ .compatible =3D "sitime,sit95316" },=0A=
+	{ .compatible =3D "sitime,sit95317" },=0A=
+	{ }=0A=
+};=0A=
+MODULE_DEVICE_TABLE(of, sit9531x_of_match);=0A=
+=0A=
+static struct i2c_driver sit9531x_i2c_driver =3D {=0A=
+	.driver			=3D {=0A=
+		.name		=3D "sit9531x",=0A=
+		.of_match_table	=3D sit9531x_of_match,=0A=
+	},=0A=
+	.probe		=3D sit9531x_i2c_probe,=0A=
+};=0A=
+module_i2c_driver(sit9531x_i2c_driver);=0A=
+=0A=
+MODULE_AUTHOR("Ali Rouhi <arouhi@sitime.com>");=0A=
+MODULE_AUTHOR("Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>");=0A=
+MODULE_DESCRIPTION("SiTime SiT9531x DPLL subsystem driver");=0A=
+MODULE_LICENSE("GPL");=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
new file mode 100644=0A=
index 000000000000..0f826313eff8=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -0,0 +1,88 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x DPLL core driver=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ *=0A=
+ * Device structure, register access helpers, and core function=0A=
+ * declarations.=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_CORE_H=0A=
+#define _SIT9531X_CORE_H=0A=
+=0A=
+#include <linux/gpio/consumer.h>=0A=
+#include <linux/i2c.h>=0A=
+#include <linux/mutex.h>=0A=
+#include <linux/regmap.h>=0A=
+#include <linux/types.h>=0A=
+=0A=
+#include "regs.h"=0A=
+=0A=
+#define SIT9531X_NUM_PLLS		4=0A=
+#define SIT9531X_MAX_INPUTS		8=0A=
+#define SIT9531X_MAX_OUTPUTS		12=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_chip_info - chip variant identification=0A=
+ * @id: variant ID byte read from the device=0A=
+ * @num_inputs: number of input clock pins=0A=
+ * @num_outputs: number of output clock pins=0A=
+ * @name: variant name=0A=
+ * @clkout_map: physical slot of each output index=0A=
+ */=0A=
+struct sit9531x_chip_info {=0A=
+	u8		id;=0A=
+	u8		num_inputs;=0A=
+	u8		num_outputs;=0A=
+	const char	*name;=0A=
+	const u8	*clkout_map;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * struct sit9531x_dev - SiT9531x device instance=0A=
+ * @dev: parent device=0A=
+ * @client: I2C client backing @regmap=0A=
+ * @regmap: the 256-byte register window=0A=
+ * @info: chip variant info=0A=
+ * @multiop_lock: serializes multi-register operations=0A=
+ * @page_lock: held across a page select and its transfer; nests inside=0A=
+ *   @multiop_lock=0A=
+ * @page: current page, -1 when unknown=0A=
+ * @xtal_freq: crystal frequency in Hz=0A=
+ * @reset_gpio: optional reset line, NULL if absent=0A=
+ */=0A=
+struct sit9531x_dev {=0A=
+	struct device			*dev;=0A=
+	struct i2c_client		*client;=0A=
+	struct regmap			*regmap;=0A=
+	const struct sit9531x_chip_info	*info;=0A=
+	/* Serializes multi-step register sequences */=0A=
+	struct mutex			multiop_lock;=0A=
+	/* Serializes a page select and the transfer it is for */=0A=
+	struct mutex			page_lock;=0A=
+	int				page;=0A=
+=0A=
+	u32			xtal_freq;=0A=
+=0A=
+	struct gpio_desc	*reset_gpio;=0A=
+};=0A=
+=0A=
+/* Register page of PLL @pll_idx (0 =3D PLLA, 3 =3D PLLD). */=0A=
+static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
+{=0A=
+	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
+}=0A=
+=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg, u8 *va=
l);=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg, u8 va=
l);=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 offse=
t,=0A=
+			 u8 *val);=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 offs=
et,=0A=
+			  u8 val);=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx, u8 off=
set,=0A=
+			   u8 mask, u8 val);=0A=
+=0A=
+#endif /* _SIT9531X_CORE_H */=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
new file mode 100644=0A=
index 000000000000..3a6151f44d61=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -0,0 +1,36 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * SiTime SiT9531x register definitions=0A=
+ *=0A=
+ * Copyright (C) 2026 SiTime Corp.=0A=
+ * Author: Ali Rouhi <arouhi@sitime.com>=0A=
+ * Author: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
+ */=0A=
+=0A=
+#ifndef _SIT9531X_REGS_H=0A=
+#define _SIT9531X_REGS_H=0A=
+=0A=
+/*=0A=
+ * The page select is at offset 0xFF in every page; some pages are paired,=
 e.g.=0A=
+ * 0x0A/0x1A for PLLA.=0A=
+ */=0A=
+#define SIT9531X_PAGE_SEL		0xFF=0A=
+#define SIT9531X_PAGE_SIZE		0x100=0A=
+#define SIT9531X_NUM_PAGES		32=0A=
+=0A=
+#define SIT9531X_REG(_page, _offset)		(((_page) << 8) | (_offset))=0A=
+#define SIT9531X_REG_PAGE(_reg)		((_reg) >> 8)=0A=
+#define SIT9531X_REG_OFFSET(_reg)		((_reg) & 0xFF)=0A=
+=0A=
+#define SIT9531X_PAGE_OUTSYS0		0x03=0A=
+#define SIT9531X_PAGE_OUTSYS1		0x04=0A=
+#define SIT9531X_PAGE_PLLA			0x0A=0A=
+#define SIT9531X_PAGE_PLLA_EXT		0x1A=0A=
+=0A=
+/* Reg 0x03 holds an unrelated revision byte, not part of the variant ID *=
/=0A=
+#define SIT9531X_REG_VARIANT_ID		SIT9531X_REG(0x00, 0x02)=0A=
+=0A=
+#define SIT9531X_VARIANT_ID_95317	0x17=0A=
+#define SIT9531X_VARIANT_ID_95316	0x31=0A=
+=0A=
+#endif /* _SIT9531X_REGS_H */=0A=
-- =0A=
2.39.2 (Apple Git-143)=0A=
=0A=
