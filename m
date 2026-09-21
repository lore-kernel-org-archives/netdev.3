Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE68A41440A;
	Mon, 21 Sep 2026 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021489; cv=fail; b=tBUYEylb5ly/NbvhA+3Red94hqlpoq/ZjKxhGbH+zxqI+rjaQ17clCURxZZxMQyLF8GNKeP78U7gJOOWVRhrdoDde0aGBdn9owfr+fpjp7bbylRhtbxxG8+3XHl9JFN/mSDEJl5PAS8R0E/4FU+ddvUfndw14ILCi9I0fGLAxKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021489; c=relaxed/simple;
	bh=qRfUWynBvHvK98RKEO5fjSymy26JAWgmMI6lbkV5luY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sPw78o0pJIddhpYvWTIW4gOgqp2O9We6FW1semK4xbEZuYhc7WOhkEYGmAANUXFX4hwCsZiU5xJOcD+3wZxrG8mvLHfF3/mFTzJJWyHbsUd4ZiFC8l7HLi9+hbQeDyVP+Zb9So8mYCaAIoLTlK3ZyEJo35WAJeZrIyyrIQwGXGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=OT9JNKMP; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=WOLyIY8d; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="OT9JNKMP";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="WOLyIY8d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=hPK5NOltCdSDP12yac83zPW+t6DaAwSO8bNvIPQOKj0=;
 b=OT9JNKMPSyUlMV26RBYN3MzWtF0vTs7SDCLuQgwNwPFs88dyXjsuPWU5IP7sImIHqUjorZ4Jk43ALfmTQ0BRL51ZGnmvRk8hjkKPOlNdtx5YJKI5axvTMaT80v9Tr7TcMNOnRcJvtDWEyMYQU521cjVsVpPGqBYke9zFENaPyAgXkriZTutYwaf7gT+McFAU/lpZAptuk7ZZrc/ccZXHlDI92W9KeKLW7ALhyIfuuvMjEa1vwqrkdItsikejFSKJymf7qqCaldxO4fkyb7MDdTet1PGftqdL7FA0V+fNmPGkjUTxQQ5aQwQ1hRVnFmqzAWYFsQg7fBqSakZFg08WWw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020102.outbound.protection.outlook.com [52.101.193.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 93B3480087;
	Mon, 21 Sep 2026 20:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTZv0W2QaBwx9EG3C7/jxKJoVgeDanmDjEe43utX64yU8Gvyv7UPfP8EtSkBg2KYwT7C2qloXnHgnTcQqX3VrD4j+8qfobADZRiw6vgStVu6TXk1KIN7opBpd4eGEhWXXmJwUZ72y9OGT6RZrchTxpWgEJFrOo4nVMpr7yUUt/dFWswlLrJTTq5dewllf59L9Q/C+6XzteXB9Tjpw8dPbG6XZvVqIU1ENisqPUBQvZNksIcpV9RptCLmAqxJKSXOcd5uXdz49Dp6vs4s23fGH7uUT4fKEQt+dBJ+OSYtybtGjU9FXqV2xcqRynksKTrr2YFI101SfVNahalyYEGevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPK5NOltCdSDP12yac83zPW+t6DaAwSO8bNvIPQOKj0=;
 b=jFFegWdufyR3vhymJtCuOd6iWoGskrwx8XIGUtWFsUOA7PExnNlI/x7pcUIp0UaAe6+sFqkqJCDS7+mZVUyNiLj0QsUcp5lVnrJOzqsUVmufnke4BEk3oQYVXg5Wb6BG5ENOv/OjtUerQVBfHGhL9OI9dLbXSUPkNR7bKKdunb0dDyeFvn296nP56i8RGI2bxTXSGjm6y9PDUEtLFHmdtfJ05dezaFV3Z0B4oGF5dkHfS23Bf/1T3ln/baoDLA/9WKPeVtE+Mcrvy1igVJPJcv9R60zCQQckO8NFMjSLNYnS8lKwkvewdfqg03rUi/GWbQ5eNERn8bC4zc7AK32kqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPK5NOltCdSDP12yac83zPW+t6DaAwSO8bNvIPQOKj0=;
 b=WOLyIY8d2AUsVLwxo6+1wW2+QGNhKiqSUJkF2oj8cEnAYGqfLY38SCwbcC05xZKGtJAlVgcKMph+NfLkT87SxE9MAbixNduMUsy/ztzm781Um3796sxEkDs9VO18i3m4/SLsF5uS3Ftbb7hIB4eEr4amYWvN200CmpsvRH24MeceZRXc+dTVW4VVn0WmHVtIIq9tZDMh1uxtY3Pu9+km2GNCurEUmtvaXDYx/TFOfMFVlu8HOfdZFTJ2EFMY4DDCn4UV6xRByYiPIdkuYgaiBZ/RNTa30jrdz3rU2e9tJckOWRn+4+T0bJDFYpotV60rut4Hn7kx9ilvGdWfehfI8A==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:10 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:10 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "jiri@resnulli.us" <jiri@resnulli.us>
CC: "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>,
	"ivecera@redhat.com" <ivecera@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "cjubran@nvidia.com"
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"prabhakar.mahadev-lad.rj@bp.renesas.com"
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "dev@kael-k.io" <dev@kael-k.io>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ali Rouhi
	<arouhi@sitime.com>
Subject: [PATCH v10 03/14] dpll: add basic SiTime SiT9531x support
Thread-Topic: [PATCH v10 03/14] dpll: add basic SiTime SiT9531x support
Thread-Index: AQHdSgVY4xZe+VfSrUGoWYUh2k3Llw==
Date: Mon, 21 Sep 2026 20:11:10 +0000
Message-ID: <20260921201108.42676-4-arouhi@sitime.com>
References: <20260921201108.42676-1-arouhi@sitime.com>
In-Reply-To: <20260921201108.42676-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS3PR20MB7783:EE_
x-ms-office365-filtering-correlation-id: 9ed91a63-3d55-45cf-8683-08df181c7aa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 ZDEKjx9ePvZ3YmBGXkggLivKztOg8AcFWNpaq3X3lQCNhQ0khA/5CZM7kmakz+d33udGb40wc6cP5u3oGiqFgEd+KUmABv4LHaQidRtS2rwiwTz1+lpT1QKnc1yn7hrhwPenIp5KusmT2Mhft1fUlgq3ungztevz2Y7ZCD3mao7IvZHFz5QcPJlpjIi5BOPnek+yCQEMvLt1nIhKV/ohksuyKCBbLP5W+hm4MprUrmEAhkODK8OLv8MAuYpnIlqSyST00TkM/Fk+uCV6hGEadM0dhRFarzqUSSsQjDe/ZHkzvwF3t6dFq+d8Xl3FDfmnHl4cqD7vlU+b2eMeFv5AmUgl7eonhJa0pxDb7rPlIRgS3YJmtJ5AkJYB6J+sR0Xr6s7aj6/wNXkzofwNMvaO2oaGE0dJwOloUQiyLX1kZMRlkDdWzyR9ZR7RaMoUOGM38oZnwSDDy+I36b5GJOuP8R4Ztwjw8YX+z0cRzKgIEh34XhgUKva8N/CADDUqkMrufoITbDyu4kt0ibJ9P8eJU96tTmm/yPYKntGn3v+Zmstbuo9H7ve8NDR6PhjXcHbSepvWBsSECsD5Z9EIAyaSwX1TlGtWEyBeD7YSKmxSx+SKLo6w4fZKK3vPZCUf1sV+6ha8R4ClaP/DhbUXqYbhwxCsFCxP9/9Zb5LBkh23fbgE5w2rlpncm3gbgbyTgAoZs07hhiNzeJRhsboP5cRK5JpnwZMdsdGfsQoRfHiDn6M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?FoD+f/RfRQdoACGGsthiAZcgeduymeS604ZoXk2TMKhlzMBWMPUGMlaVHP?=
 =?iso-8859-1?Q?2A3NFTSHWU/IHgCjoN0qnKRQ3FbJ/Hq0btFuNCSPWUNjircx4X0N0IyNpl?=
 =?iso-8859-1?Q?S5dTD9OjjGt2Copou87OERl02FUOBcBjD3m22OhWCAoFXT6qzDx3SIBPu9?=
 =?iso-8859-1?Q?7MHwmKqWvXB7I7ZbBVUVSx/1+8IlHKsQJn/kgxrNhBZ5kX6SHrgSeIWUVU?=
 =?iso-8859-1?Q?b8qyTRKt+3ujvnmpKp5R1iigiGuzL92Bta5vEOluB+wAeu91DJibTwybpv?=
 =?iso-8859-1?Q?02ZbYXO8bipT+/irVLB+Ld0LpfGhXqL2ubU6PzMWx13+GZHHx4StB1RFbI?=
 =?iso-8859-1?Q?95FbX8HvmJ6No6p7D8gCWKxu3hrfGS391751Xo1PlBALwpFYHw8gecu01l?=
 =?iso-8859-1?Q?2zmV42oiEsCfbE/2LKnJRhOSBZwKHdhJfaPgNmiEjyecREmjZHKQYqVu68?=
 =?iso-8859-1?Q?sF1OWUefnpb2UT72SOkUASFUARnoncezswwmJv9q4KX4M7wdytwNR3iilh?=
 =?iso-8859-1?Q?LBqfKsfIZGk7jcrs3loyq5t4tlGzjRNfd+ErscWRsrz3bLQxygqgDBPzNU?=
 =?iso-8859-1?Q?4qwf9zPpT3yzavPeDZPjd0pS44CN+nHIHUt02UYrMjJqT0woPHwAG7joXq?=
 =?iso-8859-1?Q?A9DJIKqI7k2rm/GMXJTk3WVBeB5nPNGPMLZhOhcDbwvH3XuI5Ymtp4zJkD?=
 =?iso-8859-1?Q?PSteWD30a3pXEN/efUAGCqUXwnDU9j6TyZ8ztSQYymup8DkZNOsr8mIr1i?=
 =?iso-8859-1?Q?Sqil6keBzwS6l/GrcKarcfA9F7cZIBjL2TuHUvslL4+/wED0UPxyDZ8QHF?=
 =?iso-8859-1?Q?79T7bf3TO/5wdU6PE/UF3CWO+5fgYgqNBr3ilLbt5mSXwu6OSBcypgV5WQ?=
 =?iso-8859-1?Q?7R2pAt4t/gHkskMx3Zu/odngeslY1xm3LlDUBF9T0sMlOjY5cRdDCg+ect?=
 =?iso-8859-1?Q?lk/nVrVQ5os3S8JiII/q/uqSZYA5mlPSEFJV9kLqsfVTduqD8TMbCBPHLQ?=
 =?iso-8859-1?Q?4qKCFVTa/dKie43liXbtz7RUBz68l98JR1V5jUFRezzyohErPNpqzEU+Nq?=
 =?iso-8859-1?Q?OloEpWDjhDWG9va6ZYH8/D4vIsq2isUz0yKru5LX+HiVqz73IVXg85+jub?=
 =?iso-8859-1?Q?Sdgz4RV4NuVIZghnVa7piyC5cKT5XY14kmUB8jWJ6NjV6QVnXZW2CqZl6u?=
 =?iso-8859-1?Q?IDTMCiRzP/sl+Vvo3aKFD+WxAegsZN+9Vq+cwAybiKXxoVnWG5KQwxdbnO?=
 =?iso-8859-1?Q?5kU7QEICmGdtJE0bI9UrO/16wMXPBUGJIq7c0MgBm3WjP9vrCCzdPdw/sP?=
 =?iso-8859-1?Q?Z0wQJjJ1+6/9HTq+Zo+Fc6717MuqMI0dj1dKn6QDGkWBlSybUA9s/tXPIA?=
 =?iso-8859-1?Q?+gpREVDC2uoQFEkjYtJnco/RQjLdFj7YxQoiaEnwPrI4WUgC330mEg+g1R?=
 =?iso-8859-1?Q?lew8ElNfI40VmjFAnp+MjvWO+efYiyQM0s8FTcI7TtHP9asRSAnV6NAPBO?=
 =?iso-8859-1?Q?LXty2er5r/u7JSd6dNaZWOgPgy6XFsW/r5JUpkNqF0gpI3fi5P5bQP9zE7?=
 =?iso-8859-1?Q?QMG8Mun2Y2SBjy1TMOs7iLWN6I+fykoRYYoitZbYjpnIyNujubjr14mo0y?=
 =?iso-8859-1?Q?c52pzjGalJa5XB0YgP0MBJHLp6BVfg6GL5LDlfgMGHz0FBdDdVOQG4S2wz?=
 =?iso-8859-1?Q?2LbdGth+dL/U+O+gFxtcLhHxR0HOF2i67KhVKhgE8E3cCoogkHX8kM8Yvf?=
 =?iso-8859-1?Q?IL6IclN+wHjXJBlhybyLh/f1T3Qa+eJFXmbWLggO6MnYWi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	CR/5CarKh8chRhndWYHlLpBYUQfLFqmJKHqtgwbk09a3yFXMbZTyXt+I+YVumzOYCDP8OopGOOGvoo4wVMI6PqvZs8RiWsh18ZWnb3rYaK3VGzS63j80sejSlYxRpfziXwMHtHL3XqC0lh400hZ8/HmDeApXG6sBL8ha2X9YZZm9jXqf83sjMEzyrFQWjtUhd8NE9Kit9P9gz5KXI6JkBv+RNV22QsjeEBkjKvQZLE4OuLT3551U+Envckvm19clMA2Z3XhkoNaMK2cYNvr0mez6PtTftm5cvVLgVrejfUG9EB1B9hSfyY3hddfpHtv2hw1+J22B7QmogacuEMAnKA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed91a63-3d55-45cf-8683-08df181c7aa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:10.5481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9qdQcdTBiGHYjaGeJUujF45aBUn9sMdbumJjLn5OZDKiY7QgCK7sPHpLKbWqCZmRZwu8IlRZH+67rJ4bXCdHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021479-lovfYwbD6VbV
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790021479;lovfYwbD6VbV;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
The SiT9531x is an I2C clock generator with four independent PLLs, up to=0A=
eight input clocks and up to twelve outputs.  Later patches register the=0A=
PLLs with the DPLL subsystem and expose the clocks as pins; this one adds=
=0A=
only what is needed to reach the device.=0A=
=0A=
The register space is paged: 32 pages of 256 registers, selected by=0A=
writing the page number to offset 0xFF, which is present in every page.=0A=
A regmap range configuration describes that window, so the rest of the=0A=
driver addresses a register as a page and an offset and never touches the=
=0A=
selector itself.  Pages come in pairs for the PLLs (0x0A/0x1A for PLLA,=0A=
and so on).=0A=
=0A=
Probe reads the rate of the crystal feeding XIN, since every frequency=0A=
the driver later computes derives from it; takes the optional reset line=0A=
and leaves it deasserted, because the device configuration comes from=0A=
efuse or from a blob applied before probe and a reset would discard it;=0A=
then identifies the variant from the single byte at page 0 offset 0x02=0A=
and refuses to bind on anything unknown.=0A=
=0A=
Suggested-by: Ivan Vecera <ivecera@redhat.com>=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
=0A=
Notes:=0A=
    Changes in v10:=0A=
    Cached the page selector, which Ivan Vecera suggested.  It is the only=
=0A=
    register in the map that is not volatile, which removes a selector=0A=
    write per register access on a paged device.=0A=
    =0A=
    Moved "select DPLL" and the paragraph about registering DPLL devices to=
=0A=
    the patch that does that; at this commit nothing here includes a DPLL=
=0A=
    header.=0A=
    =0A=
    Brought the added lines inside eighty columns, the width the CI checks.=
=0A=
=0A=
 MAINTAINERS                    |   1 +=0A=
 drivers/dpll/Kconfig           |   2 +=0A=
 drivers/dpll/Makefile          |   1 +=0A=
 drivers/dpll/sit9531x/Kconfig  |  12 ++=0A=
 drivers/dpll/sit9531x/Makefile |   4 +=0A=
 drivers/dpll/sit9531x/core.c   | 288 +++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h   |  91 +++++++++++=0A=
 drivers/dpll/sit9531x/regs.h   |  44 +++++=0A=
 8 files changed, 443 insertions(+)=0A=
 create mode 100644 drivers/dpll/sit9531x/Kconfig=0A=
 create mode 100644 drivers/dpll/sit9531x/Makefile=0A=
 create mode 100644 drivers/dpll/sit9531x/core.c=0A=
 create mode 100644 drivers/dpll/sit9531x/core.h=0A=
 create mode 100644 drivers/dpll/sit9531x/regs.h=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index b4a901e65bfd..b500dbb67c4e 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -25156,6 +25156,7 @@ M:	Ali Rouhi <arouhi@sitime.com>=0A=
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
index 000000000000..c306d1dd1c58=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/Kconfig=0A=
@@ -0,0 +1,12 @@=0A=
+# SPDX-License-Identifier: GPL-2.0-only=0A=
+=0A=
+config SIT9531X_DPLL=0A=
+	tristate "SiTime SiT9531x DPLL driver"=0A=
+	depends on I2C && NET=0A=
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
index 000000000000..cf1cda87fa52=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -0,0 +1,288 @@=0A=
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
+#define SIT9531X_RANGE_OFFSET	SIT9531X_PAGE_SIZE=0A=
+=0A=
+/*=0A=
+ * Everything the device holds can change without the driver writing it,=
=0A=
+ * so nothing here is cacheable -- except the page selector, which only=0A=
+ * this driver moves.  Caching that one spares a read of it before every=
=0A=
+ * access: the range code selects the page through a read-modify-write,=0A=
+ * and with no cache that read goes to the bus each time.=0A=
+ */=0A=
+static bool sit9531x_volatile_reg(struct device *dev __maybe_unused,=0A=
+				  unsigned int reg)=0A=
+{=0A=
+	return reg !=3D SIT9531X_PAGE_SEL;=0A=
+}=0A=
+=0A=
+static const struct regmap_range_cfg sit9531x_regmap_range =3D {=0A=
+	.range_min	=3D SIT9531X_RANGE_OFFSET,=0A=
+	.range_max	=3D SIT9531X_RANGE_OFFSET +=0A=
+			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,=0A=
+	.selector_reg	=3D SIT9531X_PAGE_SEL,=0A=
+	.selector_mask	=3D GENMASK(7, 0),=0A=
+	.selector_shift	=3D 0,=0A=
+	.window_start	=3D 0,=0A=
+	.window_len	=3D SIT9531X_PAGE_SIZE,=0A=
+};=0A=
+=0A=
+const struct regmap_config sit9531x_regmap_config =3D {=0A=
+	.reg_bits	=3D 8,=0A=
+	.val_bits	=3D 8,=0A=
+	.max_register	=3D SIT9531X_RANGE_OFFSET +=0A=
+			  (SIT9531X_NUM_PAGES * SIT9531X_PAGE_SIZE) - 1,=0A=
+	.ranges		=3D &sit9531x_regmap_range,=0A=
+	.num_ranges	=3D 1,=0A=
+	.volatile_reg	=3D sit9531x_volatile_reg,=0A=
+	.cache_type	=3D REGCACHE_MAPLE,=0A=
+};=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_u8 - read an 8-bit register=0A=
+ * @reg:	register in SIT9531X_REG(page, offset) form=0A=
+ * @val:	output value=0A=
+ */=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		     u8 *val)=0A=
+{=0A=
+	unsigned int tmp;=0A=
+	int rc;=0A=
+=0A=
+	reg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +=0A=
+	      SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	rc =3D regmap_read(sitdev->regmap, reg, &tmp);=0A=
+	if (rc)=0A=
+		dev_err(sitdev->dev, "Failed to read reg 0x%04x: %d\n",=0A=
+			reg, rc);=0A=
+	else=0A=
+		*val =3D (u8)tmp;=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_write_u8 - write an 8-bit register=0A=
+ * @reg:	register in SIT9531X_REG(page, offset) form=0A=
+ * @val:	value to write=0A=
+ */=0A=
+int sit9531x_write_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		      u8 val)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	reg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +=0A=
+	      SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	rc =3D regmap_write(sitdev->regmap, reg, val);=0A=
+	if (rc)=0A=
+		dev_err(sitdev->dev, "Failed to write reg 0x%04x: %d\n",=0A=
+			reg, rc);=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_pll_u8 - read a register on a PLL page=0A=
+ * @val:	output value=0A=
+ */=0A=
+int sit9531x_read_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			 u8 offset, u8 *val)=0A=
+{=0A=
+	u8 page =3D sit9531x_pll_page(pll_idx);=0A=
+=0A=
+	return sit9531x_read_u8(sitdev, SIT9531X_REG(page, offset), val);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_write_pll_u8 - write a register on a PLL page=0A=
+ * @val:	value to write=0A=
+ */=0A=
+int sit9531x_write_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			  u8 offset, u8 val)=0A=
+{=0A=
+	u8 page =3D sit9531x_pll_page(pll_idx);=0A=
+=0A=
+	return sit9531x_write_u8(sitdev, SIT9531X_REG(page, offset), val);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_update_pll_u8 - read-modify-write a register on a PLL page=0A=
+ * @mask:	bits to modify=0A=
+ * @val:	new value for masked bits=0A=
+ */=0A=
+int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			   u8 offset, u8 mask, u8 val)=0A=
+{=0A=
+	unsigned int reg;=0A=
+=0A=
+	reg =3D (sit9531x_pll_page(pll_idx) * SIT9531X_PAGE_SIZE) +=0A=
+	      offset + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	return regmap_update_bits(sitdev->regmap, reg, mask, val);=0A=
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
+int sit9531x_dev_probe(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	struct clk *xtal_clk;=0A=
+	u8 variant_id;=0A=
+	int rc;=0A=
+=0A=
+	/*=0A=
+	 * Fvco =3D Fref * (DIVN + frac/2^32) with Fref derived from the XO=0A=
+	 * feeding XIN/XO_CLK, so the rate is needed before anything can be=0A=
+	 * computed from a divider.  The rate normally comes from a "clocks"=0A=
+	 * phandle (clock-names =3D "xtal").  On platforms where the firmware=0A=
+	 * does not expose the XO through the clock framework, fall back to=0A=
+	 * a "clock-frequency" device property.=0A=
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
+	 * Held deasserted, never pulsed: the chip configuration comes from=0A=
+	 * efuse or an NVM blob applied before probe, and a reset would=0A=
+	 * discard it.  Must precede the first I2C access, as a board that=0A=
+	 * powers up asserted keeps the chip unreachable until released.=0A=
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
index 000000000000..76a2632f0ce4=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -0,0 +1,91 @@=0A=
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
+ * @id:		variant ID byte read from register=0A=
+ * @num_inputs:	number of input clock pins=0A=
+ * @num_outputs: number of output clock pins=0A=
+ * @name:	human-readable variant name=0A=
+ * @clkout_map:	per-output slot mapping (output index -> physical slot)=0A=
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
+ * @dev:		parent device=0A=
+ * @client:		I2C client=0A=
+ * @regmap:		paged register map=0A=
+ * @info:		detected chip variant info=0A=
+ * @multiop_lock:	serializes multi-register sequences=0A=
+ * @xtal_freq:		crystal oscillator frequency in Hz=0A=
+ * @reset_gpio:		optional reset line (DT "reset-gpios"), NULL if absent=0A=
+ */=0A=
+struct sit9531x_dev {=0A=
+	struct device			*dev;=0A=
+	struct i2c_client		*client;=0A=
+	struct regmap			*regmap;=0A=
+	const struct sit9531x_chip_info	*info;=0A=
+	/* Serializes multi-step register sequences */=0A=
+	struct mutex			multiop_lock;=0A=
+=0A=
+	u32			xtal_freq;=0A=
+=0A=
+	struct gpio_desc	*reset_gpio;=0A=
+};=0A=
+=0A=
+/*=0A=
+ * sit9531x_pll_page - get register page for PLL index=0A=
+ * @pll_idx: PLL index (0 =3D PLLA, 3 =3D PLLD)=0A=
+ */=0A=
+static inline u8 sit9531x_pll_page(u8 pll_idx)=0A=
+{=0A=
+	return SIT9531X_PAGE_PLLA + pll_idx;=0A=
+}=0A=
+=0A=
+extern const struct regmap_config sit9531x_regmap_config;=0A=
+=0A=
+/* ---- Core lifecycle ---- */=0A=
+int  sit9531x_dev_probe(struct sit9531x_dev *sitdev);=0A=
+=0A=
+/* ---- Register access ---- */=0A=
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
index 000000000000..67077d112653=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -0,0 +1,44 @@=0A=
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
+ * I2C register model:=0A=
+ *   - Page select register at offset 0xFF, present in every page=0A=
+ *   - Each page has 256 registers (0x00-0xFF)=0A=
+ *   - Some pages are paired (e.g. 0x0A/0x1A for PLLA)=0A=
+ */=0A=
+#define SIT9531X_PAGE_SEL		0xFF=0A=
+#define SIT9531X_PAGE_SIZE		0x100=0A=
+#define SIT9531X_NUM_PAGES		32=0A=
+=0A=
+/* Helper macros for page:offset addressing */=0A=
+#define SIT9531X_REG(_page, _offset)		(((_page) << 8) | (_offset))=0A=
+#define SIT9531X_REG_PAGE(_reg)		((_reg) >> 8)=0A=
+#define SIT9531X_REG_OFFSET(_reg)		((_reg) & 0xFF)=0A=
+=0A=
+#define SIT9531X_PAGE_OUTSYS0		0x03=0A=
+#define SIT9531X_PAGE_OUTSYS1		0x04=0A=
+#define SIT9531X_PAGE_PLLA			0x0A=0A=
+#define SIT9531X_PAGE_PLLA_EXT		0x1A=0A=
+=0A=
+/*=0A=
+ * VARIANT_ID is a single byte at page 0 reg 0x02 (95317 =3D 0x17, 95316 =
=3D 0x31).=0A=
+ * Reg 0x03 carries an unrelated revision byte and must not be combined in=
to=0A=
+ * the variant identifier.=0A=
+ */=0A=
+#define SIT9531X_REG_VARIANT_ID		SIT9531X_REG(0x00, 0x02)=0A=
+=0A=
+/* Variant ID values (page 0 reg 0x02) */=0A=
+#define SIT9531X_VARIANT_ID_95317	0x17=0A=
+#define SIT9531X_VARIANT_ID_95316	0x31=0A=
+=0A=
+#endif /* _SIT9531X_REGS_H */=0A=
-- =0A=
2.43.0=0A=
=0A=
