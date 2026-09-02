Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8CE3A63FB;
	Wed,  2 Sep 2026 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788385280; cv=fail; b=M8evW7uBytwWYQw5O8XNCH67iXrB0PKTgAm/mfdoHmAgARpj5fVM8jlepbd5+yCTgIh/lmIu1Y8CGfvT7a7A/NsH7bvuj7CSdgywPhAXgxxfNhITIER7CPXmMjLRsN+aWPD+s9rBxNdXnFvv9Tp7saZZV9sqPCaEKFtETRafWho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788385280; c=relaxed/simple;
	bh=ixRYjMLeJ3ZY03Qd6ucBybeNcGevBJLSatB4zwvrhmQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ssWeXJpWvak6vanjFPWLz5XJXVt1X7hhgdK93vIjlYaeWUQnhG26wFgh2W6wlo0ggjTGMjxg3KMkqotVanIm02uiunN78Od6JmydsEC9auB6iEqgADFUDOEXrHd5ocgo3sBhKtnsFeeed1y268Wle+7qEpoqQaP0wVdHqRdicFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=RoVj14Ws; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=hV6jI+ro; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="RoVj14Ws";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="hV6jI+ro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=bsED6UwJ9QYKGko9aWzYbCzjW0ss5suaFNHVNb+lqzw=;
 b=RoVj14WsASspRI10sXWYyQ81dCSOVANreqB+DkWvzpEYK8cLX1U3i3KL6adt+PKjkinjjZIV2Ab0Ryv7IOqX9cOWHQDVPiBoaJxJvop/8+GF6v3yFPa74SlAqtNQRAkMRt/4zxPO0R2ENrV/uV3GZsupM8vhYhLpgSFdiGwtKR3nMXKJeOlqGjtBCeektUd16c+3FRA7HlzsXfTtjW/vfeUsn9iv+6+ZcqA37MhhKKP0oYUD010iVsq4jPVNIAO6U4Ddlutc9Mo5Ry8DaaMKoEAvlMuWMDIvkkOo9Fn0l6nSFZe5rwOk7D2MOEnycBG6TbkPb2PbIh1EBDo+6Ayw9Q==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020124.outbound.protection.outlook.com [52.101.85.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 191912C0066;
	Wed,  2 Sep 2026 21:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/ogksl1DDhpYgVRSzxItboaDix2lEqiVP7NSjgk2IBkjUfIU6l0Aea5DsVXLGLOHue47G5Nd4ACPXks9FF2nlESmm+nntnv76L4avAL2bAaC+IdUHTIvAAf2zldO7RNF2qqBmmf6zdwwcb1FRL9oXMKEl446HOn9dtPNZhJWQOTut6xmS2W8JdLTN/Tw3WdWZ69GlklChy+M5BfOIPafb/j/CHftQUj4gOsvQ0mO3vgUY1P8uJiXEFDVtf/DOqxsJKc2IpER3v6wn3z/9yNppVEsKfN4pz6GSCAL8TVX1S7+dPLN9OabK0fY7CDs962r7IxMLZcvZ8t8Td3GLzOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsED6UwJ9QYKGko9aWzYbCzjW0ss5suaFNHVNb+lqzw=;
 b=Go7cdgeXJwujxSt9IZFnQYjJackSQuPmDQC4kiw7Ms4HWq+59TXQrwSBWuMyL/sYUF/JgCB+I1+TQ5YxAyEoYYgywaeuG7BM1OehFRrwxbvLfpI6JTyapSuuDeFcmmbm9CybXM9KBeyXSU4qkKRuS5CMVdd041Drc6VniexAy6g2otP5Xjr4y4cRMGBeAtTO4SACj9mBqb4obKYQSSIizfMXb4BEFHbFQX5Awl5i9E8LrKF6mH7Upb9mtM4J34LYhRlUFV8CTH0f5ebfxGgwijQ7YERJoU3gnO0I13cExoGmjz0kDRjLdbQ+vHefIaF5ZRt1V4Ek1n1Mt9caFJ5SGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsED6UwJ9QYKGko9aWzYbCzjW0ss5suaFNHVNb+lqzw=;
 b=hV6jI+roo0yhMRKaIDcvGv+Pgv29EXEvY/GJe9uX1BVRuRo/8z0z9BDdyymU9ITfMDlRed9KS5AveoEWxFXPH30yTqZvFiCzgquBSrzMr1+2sb50QraNig4Tc2VLSlERx7J6wxa63IAoTlsk0wYLDfX5nD2j+9E120SBB1WZ8/QbAkm/gD2QVngFDqIGECuy7aDJHnR+KMJoLDLuwa38Tusmok52PZ5uXfOwuudBYeD4rH6A+yrAU1jm+CSPByCHIzRX2JWV9nwckm6ocyq+bugg4viTsYHlCniGd/udMv0FC4diMFMBpcQcRLGKOaXVIejIRZTFZypAV0KCR/UEUQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS7PR20MB4877.namprd20.prod.outlook.com
 (2603:10b6:8:97::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 21:40:38 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 21:40:38 +0000
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
Subject: [PATCH net-next v8 15/15] dpll: sit9531x: allow the device tree to
 override two board facts
Thread-Topic: [PATCH net-next v8 15/15] dpll: sit9531x: allow the device tree
 to override two board facts
Thread-Index: AQHdOyOxgVkxPL0MGEC6dAn6hw12aA==
Date: Wed, 2 Sep 2026 21:40:38 +0000
Message-ID: <20260902214030.20955-16-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 2bcc60e9-57e2-4d31-74bc-08df093ad45f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|56012099006|3023799007|38070700021|6133799003|10067099003|5023799004;
x-microsoft-antispam-message-info:
 EgbMhP/3ErF4zLZyQclAFcp5il+uUslsK8pyfSpc2xit9YZ4PRGWrq0fYbvFleDB+t85a+m33/J/keFVBAV7rrvoymk+9sqMVnzlMl8KW5ZmWSKEtQACw4tovQdjzYrilNFjBRRfKDl9OPq8gasRJ+KoRq5Rzhd1HvL0mxp3MjwSBKT+Qp64UJkCYy/q95Vdq/V2ci9reLzcuYglc+ik7uNohY1EbVHv4B+pZRjFFHQr8oL8jowkJax0XD73O+2lGZLoLmjO9ilObKEL/LSkOJh5rkhAyS62J6/5bF5WJ56ocxvIBxgjGhuCoSGnKfCtx+yXzTtAFWqWztorsQZlF0JfNqJmNRA2qhL/CQVcYwKyAesXqVopYaijWgFMHr2Pgtabgc50QTMHkiXgpIkLzrSw6UX+sHkqLquUEB5tmJx0nqTsgPGDgeSHYkDDVoUqiTnMSAZWb8NFsa5WHbM+D3nldYZMPKAzzUO0ociNMxbx6zn34KfWhOgUELhkvm1awnZZM7Q74BKZfV5xbBqc9nBts+Ky+Edwk/H6cJJffahNuHRKCwyn2nVptGLxSY6BapsQt+tHXZG3pfPsVkg8dzffl6dUqa/OfJL/7US51HNlmGOLRONHsLrNrAm/Sw4ET7S1p7KbQmBXbrg/Yo3T0/PjsdFcHuZYozpvqx3F5J0aU5j9121Yi7ckJCH7HsIF34GccGDPGcu9z3iXgkTonUfR9wXRQ67WxPzE5p17z7k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(38070700021)(6133799003)(10067099003)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?f9S+PGuaZ24CiuMBThEMnR+0AmBjzFp2J3Zk6ECh2ZHvHLb2cqkEq+n3dm?=
 =?iso-8859-1?Q?HDwaJTrV4zyDGliG4Uu2kE7YIYBCbAQ7MsEdnEUiXN/5R+H/WGJPythPk0?=
 =?iso-8859-1?Q?o1zlY1L433447u/IHC7TwwDPZu0rhUmXkgQQcGASJlXoVMAfxA6lVRcWes?=
 =?iso-8859-1?Q?l5aNPQ0xs2heG5xlvgGMRnWgFNDjU5ynpTu7P5Mq23N7iwfs5daA477VBe?=
 =?iso-8859-1?Q?Hyf/bv5xzJ3urMDqKkgKNumyn2jhxgEFiGFRNnyUKvlrK6bX8uflcKeaOu?=
 =?iso-8859-1?Q?FugOrJmdgTsQwOMsyxfB5gByS6okwrJGB3SZ96qxscrNsebKnaQrofQHSg?=
 =?iso-8859-1?Q?1hSwLQeEOZYc47wzaYgY7H6aqXxzJ62mSQ1Z3i8S3hZ9tSnmNKnBGQAtsS?=
 =?iso-8859-1?Q?fKnt4egNp6JWuw4b8e7deymRyvY7/AMzxdJuKTkl9hQkdinl9p417HD5pF?=
 =?iso-8859-1?Q?5RUWB8EQjLGG4Cz8ul0QGdNTGx+XbGswKXxwtzv579J5/VPhdMnhvHZogt?=
 =?iso-8859-1?Q?cMIjZaw0ULSHxzZzXp3gFpLUvQloPoxPgDxuXwAUiLaMSDag5RUNjBVjfQ?=
 =?iso-8859-1?Q?BQX7mCV+SCfrxEbAaQI13b0H0wtHo1dGs97Xz9n8UEQXVbi4WaThcHexdJ?=
 =?iso-8859-1?Q?1/otXXfY7IrlX/kRpXU/BFxPe9qQwiJSTQV30W3rU6D8ao5rfPVV+fAaIQ?=
 =?iso-8859-1?Q?f8toWJbAwlbN5Xk6A5YZoUhPzh8r94fbv28M2m2zUWBbISvwO0oqMHecWK?=
 =?iso-8859-1?Q?UZfH+Fd9VkbiAI7G5SIOCMrWKAiD2Ksc6yopEF+L6x4SbZNH3nObSr4xZ9?=
 =?iso-8859-1?Q?KwZTHrryLaDKUGL00ur3pEARCA2EodM8MObXJvDvgcytPE4TPmkIgQAKPi?=
 =?iso-8859-1?Q?jSHwtrMrgv3++zF7CyfyvXEnBcARB/nKK5Jg7O/kwiQPTM4yhLUB40ZGy1?=
 =?iso-8859-1?Q?EP3w8DKFepJ9QTyYXXUCMDfOJCkXLkyZ/pWpYR3R1jwTGcJN3Dwl3I3dWM?=
 =?iso-8859-1?Q?mWeDGDWdO1N5ddm8tPKmAja8Lzjd+daIs4no9fwruTLZ9eGF3S4HwM8bIw?=
 =?iso-8859-1?Q?yLpSZqbPsUb6WAk/JWXD4TzsCwb1eE9anaWrS0dINJl8AHW6maIrWeCVQi?=
 =?iso-8859-1?Q?lpC7yhOJybgYiGGplv9bCrCAMJgz0T1QVxIbBrEjyR/CXhKEjoS5Ct5yNK?=
 =?iso-8859-1?Q?2nlmQ6PCcX4bqg8goqj/1SsMdYF4ZOrUYAFiEvC/62bhMoccFQSyjDDbqk?=
 =?iso-8859-1?Q?feLvtavqYXegpgWOFa5h+GkCgl0cScGQ3+do7cLwUnfHD06z4rNwUUe9wN?=
 =?iso-8859-1?Q?YNnVnBEEU7fejZpXy9PR5M7bt+/YBqmK3WWlcniyQ7d/jniCveeDD/jaGi?=
 =?iso-8859-1?Q?3YUwtcX+eKmoP4RLyA8vJKyhLu47FbE35dfW5SOWNxuPqKV+pJHq6Nwq4M?=
 =?iso-8859-1?Q?q/ilzwFp/bQM3UnLvs2dxZsohgiw8PxqYKIojFfPpXnZJsXJtrXxvYuAwX?=
 =?iso-8859-1?Q?EHvn0Sj9OdmfDKifOcjHeNQL8j7JDvLJk6NBFDShKRZWY+MyfkdnnkTBjf?=
 =?iso-8859-1?Q?d0EJd4+3AVdXtn97jI4k6ZrWVC3Caqv4ICaDtvb+piTyrXmYCSBngxFKHS?=
 =?iso-8859-1?Q?5ca7IKlkyYwQCdB2YfRg3t5djvyATOhMaE9487t6wAvr67r1BXUg67sjpO?=
 =?iso-8859-1?Q?iB3anOKdNcxZ/I7iPG7oYZimNEzfmFGazaznhkfUar9TBKoC2Y3bplYYsB?=
 =?iso-8859-1?Q?SaS4CX3Ae+NxctkugrFbBonjYP+W2MJBAaEPg/8uHUfRIg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	YnutUid0lNw2xDVh1IxvDCbyge7jMe8ZfJQaZur9kirxtdQ6gHwswjm2YI0f8gQvC4br3s5XAFXV9uiDkiIP748OoUDKNomTOf6aY+aO+DKJEKrDFvZHbRkn3sjRHIo5kzuI5DJqyChpqsbnbz0r3PmvJE5yuPaVKS3G71l5FI3z4i6HKlXU0ixX7cs8+WSa8b76pVwYnshn9kx5Opo1x8YOfI9hhy4sqa+jQ+iUnQTzl3bHmrX/mvIVKZ84YiYyxU4rCEgLLn0DTXQTcTpViMjSnndyFobUSCTDIUBDf3P5zSyRGAaC9OKgGs4vqVByf9LePZY3ckA5gIVMoOUFeA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bcc60e9-57e2-4d31-74bc-08df093ad45f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 21:40:38.5290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IqeYPRhXOj/B+SNiNwpgYXZJLvJgadL92lgBRH9gKxUfiBX1mhKiU735MCuFo3XAonpgWinSNdQ3M+ua42iaoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR20MB4877
X-MDID: 1788385246-Jsf8Wu_gJfqb
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1788385246;Jsf8Wu_gJfqb;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Two things the driver reads from the chip can be wrong on a board, and=0A=
neither has anywhere else to come from.=0A=
=0A=
The VCO frequency is derived from the feedback divider, which is exact=0A=
while the loop runs but not while a PLL sits in free-run with a divider=0A=
the configuration never programmed; a board that knows its own VCO can=0A=
state it.  The output-to-PLL routing is read from the output map=0A=
registers, which describe what the loaded configuration did -- and a board=
=0A=
whose outputs are fanned out differently from what those registers imply=0A=
can state that too.=0A=
=0A=
Both are optional.  Absent the properties the driver behaves exactly as=0A=
before, deriving one and reading the other.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
 drivers/dpll/sit9531x/core.c | 39 ++++++++++++++++++++++++++++++++++++=0A=
 1 file changed, 39 insertions(+)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index c3d7c4851549..d75ac02047b5 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -3158,6 +3158,43 @@ static u64 sit9531x_derive_clock_id(struct sit9531x_=
dev *sitdev)=0A=
 	return clkid;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Board-config overrides for fixed efuse/blob routing the chip registers =
do=0A=
+ * not describe unambiguously.  Absent properties leave pll_fvco[] zeroed=
=0A=
+ * (derive from DIVN) and out_pll_map_valid false (use the OUT_MAP registe=
rs).=0A=
+ */=0A=
+static void sit9531x_parse_board_config(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u32 map[SIT9531X_MAX_OUTPUTS];=0A=
+	int n, i;=0A=
+=0A=
+	device_property_read_u64_array(sitdev->dev, "sitime,pll-fvco",=0A=
+				       sitdev->pll_fvco, SIT9531X_NUM_PLLS);=0A=
+=0A=
+	if (!device_property_present(sitdev->dev, "sitime,output-pll-map"))=0A=
+		return;=0A=
+=0A=
+	/*=0A=
+	 * Any 1..MAX_OUTPUTS length is accepted so the 8-output SiT95317 need=0A=
+	 * not pad to 12; variant detection has not run yet and entries past=0A=
+	 * the detected num_outputs are never indexed.  Trailing entries of a=0A=
+	 * short map must read as unmapped rather than 0 (=3D=3D PLLA), which=0A=
+	 * would mark unrouted outputs active in sit9531x_out_state_fetch().=0A=
+	 */=0A=
+	memset(sitdev->out_pll_map, SIT9531X_OUT_PLL_UNMAPPED,=0A=
+	       sizeof(sitdev->out_pll_map));=0A=
+=0A=
+	n =3D device_property_count_u32(sitdev->dev, "sitime,output-pll-map");=0A=
+	if (n <=3D 0 || n > SIT9531X_MAX_OUTPUTS ||=0A=
+	    device_property_read_u32_array(sitdev->dev, "sitime,output-pll-map",=
=0A=
+					   map, n))=0A=
+		return;=0A=
+=0A=
+	for (i =3D 0; i < n; i++)=0A=
+		sitdev->out_pll_map[i] =3D map[i];=0A=
+	sitdev->out_pll_map_valid =3D true;=0A=
+}=0A=
+=0A=
 int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
 {=0A=
 	struct clk *xtal_clk;=0A=
@@ -3192,6 +3229,8 @@ int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=
=0A=
 	if (sitdev->reset_gpio)=0A=
 		fsleep(10000);	/* internal boot after release */=0A=
 =0A=
+	sit9531x_parse_board_config(sitdev);=0A=
+=0A=
 	rc =3D sit9531x_read_variant_id(sitdev, &variant_id);=0A=
 	if (rc)=0A=
 		return rc;=0A=
-- =0A=
2.43.0=0A=
=0A=
