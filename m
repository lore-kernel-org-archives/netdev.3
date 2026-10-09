Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE694F7CB5;
	Fri,  9 Oct 2026 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570219; cv=fail; b=rd8GKpi8H7xvXY1RohN82DHWS0yuREDQv2TS8mUc7bnoruZikQHzxV5viBvJWcmYsis6zMskf3cKgWsOJzn2KxYQCVYlLorcaG85CZ0qjpe1Emvk/FVd6Sezp8E7UfTsGMQDWmy2AAjMihdXeOmw9jSJp5NvUTKmwpDNLyHSgP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570219; c=relaxed/simple;
	bh=rtP9Du8FqG1oxO1WXY+44M+/qAV5IIa0n38T32aRLkE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ULpeNH6SdXW73xFq/lu2owOJeq/BOvkmMxIat04o9R4HQGdv/+igJuoKKxRXSmPzChfC/h1Jwhf21jME3YOvgp2vFIAEuj4SOuPa0OJjWC6N7XnRbM6V1I3o/v/aPiEFoy2p5Xf6YP/XVoXdqiqg1G+ioQO+G5rhPS/ruHXdUr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=olNL4xlt; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=IlPdkLFh; arc=fail smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="olNL4xlt";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="IlPdkLFh"
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B9ED344D70D;
	Fri,  9 Oct 2026 18:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=ykWVLdLvyFlrOmlNiKiWvs3mC1IK34dtx/BPAx5FNCI=;
 b=olNL4xltV1OEv26CdzzXDfZAA85vyEsjR4Ic9xArnyja9NIUTp5mEhoukGQ3DWXQ/2hpXxbCDvBSjOZimvLLBNZ6w90eiiJthjZD2Saxh3/q9YtpnB4GzJI2xmfwakRNBb9sHYW4rrsuSRVwR1lQCTDn7RNUmL6f+G4FeS5unGrdi6N8Aqm8xTi3YLBu255E1St78fQLbl7VnrEG7hzgDB02+JlFkAvmKSG9uYfHYiIyNizmC2xu3em7goKOERa9Bd/y+t0c4KFB/087Bg48K49ehCkQKXvCej8myY/QD+IhhD9Hhf9K6BM/Q2z4e1Xy/b4slD2sw1xRhiajpn69QQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022092.outbound.protection.outlook.com [40.107.209.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 731DA100088;
	Fri,  9 Oct 2026 18:23:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STkxAQ+UB3jE1sS4QsA7j5JOg3HJRcD4psdUyWLF0gNYgWYAG51oiH7ltRepbbdL4QKwwaQOJlyKfBP4h+EiwDhxCjME493n1Zch/3WG6wfc1XyIxUl2l2lPnnHEtBVH6gn1f2ILm7W/uifnkz9HjgWsYvbo3J31nrNsj6ZYlfYfOANvz8mVLmv2R5qUMAwrdH857L4re+HazzXMNZteCoDPRA2vwOx6UXIGWn2+qAmniepXgl/pHLdK+PhdM54NHsktNxXvyf6vcfj+54qMJMejTKZRNT8dXGr1ptpg236mP8xDKyTUzcvDiKdu+c9Hyq8ZD/V+z9wIzusMuLWn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykWVLdLvyFlrOmlNiKiWvs3mC1IK34dtx/BPAx5FNCI=;
 b=skgc7QmoaigGh0YnjF5mfUzf7zh7u15UMHAqsrOtSO0abJ4SS9YzwOoXwMzFx9U+vSwqmSxb4S2pd97eEBTWdm5WC4FaoQfkE2mZS5a2pz/vi/qcy9CFe9zMW0EpDmu1MzMxq/iy54vZL01iSwnjCzzyd3aR1mbiPtsaDQCCGNSfZfr9RvegGTU+J5yefG6Nms67t/7O5CRoR1s4plKJhE5UC/KWEYXZS9ARem5/6Uo5ca8FdZ1g+rifHirOZA8CNObxOR33D0ycJJkoHf6oEa1QLb4KV33pthUBZrFE2tF94xz7MDI2RRaGsFD04HCw45W87yc3WepwgDqrMtwiHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykWVLdLvyFlrOmlNiKiWvs3mC1IK34dtx/BPAx5FNCI=;
 b=IlPdkLFhK7URGAvifvokvtBZ1R/Nb6P5XO+fSzxYPnDstAu8/u426RN4Ws3Rw4wAmsqf4TVaj/ybOoYOzBFvcYR1ucm+93cTXm6qpq9P/wvA4leZoJ0xLLA3w7x1WCDjFWzMUbttSHR49E7O2QYZPrNgo50owOESSSI3Jt+pQmcSxeqX9pSTrx9SCO+AwLuh9Hzxno1VWqulyZAZHG0kdB2Sy5jcLO0xL/UJNQfedAnD0FoWWrQ4B7+51Jx9rIqWxZI/ga94IJ5khW33o9xtE5xgiE0g1WiVc2QWMxV6yKuKhLhqP5Wz2DkmZOPKg1nPjwj25ETtm7DxgoUt2tNLFw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by CH9PR20MB007164.namprd20.prod.outlook.com
 (2603:10b6:610:314::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 18:23:25 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 18:23:25 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "netdev-bot+sashiko@kernel.org" <netdev-bot+sashiko@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Ivan Vecera <ivecera@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Carolina Jubran <cjubran@nvidia.com>, Oleg Zadorozhnyi
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v11 03/13] dt-bindings: dpll: add SiTime SiT95316
 clock generator
Thread-Topic: [PATCH net-next v11 03/13] dt-bindings: dpll: add SiTime
 SiT95316 clock generator
Thread-Index: AQHdUTShUiqVpM3oXk2TUznUAYFs+LbuKgwAgAdqCIA=
Date: Fri, 9 Oct 2026 18:23:25 +0000
Message-ID: <20261009182323.76166-1-arouhi@sitime.com>
References: <179116259487.434549.6833952261033036380@kernel.org>
In-Reply-To: <179116259487.434549.6833952261033036380@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|CH9PR20MB007164:EE_
x-ms-office365-filtering-correlation-id: 385cfd06-646e-4c4d-6d66-08df2632685e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|18002099003|38070700021|56012099006|5023799004|22082099003|10067099003|3023799007;
x-microsoft-antispam-message-info:
 jF0yRTlS9cULvmRpTmOA2HyR4wgHCKeaME8o17DiX5qlOKB+EN9Q6gPqLBjbKYyzsuEJuffCvaXmS35l+nmYKHv12y032xPYWZ1L/MYyyiXzeG6dfmquVinytZ7pENQBFv62bt7zPry+JUBlC+2OndQ2XmhRKwGN4nPssKi/iJebMqK5ZdbmLWqXkj+4auoo/9xsU/Y/j45V1Q5C5I2/g2SBYwGwPZe0SxW3rnXnLibhe1lup98+bWSbxw7/7p9/A4BUTJE76OVsF1MvxKTI22XFfFrlF1WkCgrTMQW7SccvUgsXU8O60KmufjgllICzWlhRNWt/+4SnY6KDV4PX9dLHxvqIA2XQoCRQ0a3l5UCJX2nHaCQ7lfLZZwFGB0j8bkCBBVMOo1LXOFpkq42mpHMsnPK2vQ0UHrl+P6UiH2gSQssKohPKoBO1lxk/0dsIoDMeAz93hEx3BWxFE6lfwUbXGyEl1OGhyBDA3dlCoofRLeF+TNziWcrEuD0p+dPCsu9+iLFxjpfdHxBEJemUwIxsWgqj54OqH4doiXPNYp0A/z0jSFoCap7aXAJyRFIwO4vsewGdT/eMb/yc2c+32vB5XdDnpuUI7p9vCZS2q7VFgNqbp58ikM1d9Qsi3dp0ib0F/vc6LaWqZgAhUPofZJSMXOkZF+YMYpnSIHVZZKYkBn8q80qQtLlr6ki931ODkqBnNnJ8zhDuiSvIEg8hbMf2bjkEEmAgTEKgW4wfAPI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(38070700021)(56012099006)(5023799004)(22082099003)(10067099003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OhcDf10rHftFRwtqUBKuOQnWtxhcbC4o+T1dIfV0xB7/GRMCmgz51uqX4/?=
 =?iso-8859-1?Q?f4mCOZVVgMEu5V79Uf535RobuUsKc61YNW3xow9aE3I6jXTrtVe2RDxH0Z?=
 =?iso-8859-1?Q?u9DYp48138XyB81/ao6+ngeVx5RkABm6o7NcS0iDUqGHCBeDcxnhRfWnEi?=
 =?iso-8859-1?Q?B05AGc7FqTTp1rw2A7t3opmMbrOZOhmyHZYOsCL2TKh7qUsplLjIKdd3Lo?=
 =?iso-8859-1?Q?YKPjad6XOWqGFMLBMeWMZ8+36defbEpc1rT4A6KarPj53O9jIcQPnkGjMj?=
 =?iso-8859-1?Q?pGcRqM7DRGDbpGY6CD64KOFzhmSaUpeNpH/DtUiNQ2vwxAFY799PytZ+qr?=
 =?iso-8859-1?Q?eIDgwdGkMhNqBeXhWON8aApr4fLSdqNycL9q/sDowlSRrWk3xJ5pmNbkLL?=
 =?iso-8859-1?Q?45n3/q8FYG5okTyCgUQP/zMS21UW/RMAHjUy+Zqgn2KahBCjhaFG4vlFXE?=
 =?iso-8859-1?Q?FIlh2PuoKVl1jn8wl1Vm7uyZGLVOwHaUSFBHOzBRstvGW9EbUfRQ26m7Uv?=
 =?iso-8859-1?Q?23ekeD4Cmr3Kuj3o0uGTJKv+hpO1VdpZnIpRrSbqF//XDoSllVg9jlT3Hb?=
 =?iso-8859-1?Q?EPs/uLmtuAqo0x/Ylx2hFFEsS3XCexYadwa60AU71KrFfu7A8/hM/sMBsK?=
 =?iso-8859-1?Q?7L8ZpZlYuJGi16Pm+gNMdganMdMrExvp7G0JlKwbAqbFydDS/3W/pW9nA6?=
 =?iso-8859-1?Q?X8wvqqKR6XaWVfgsCyJT1+1hnskKDlhQ2/5uVXOZkhTS59k1dXtoWcpFaz?=
 =?iso-8859-1?Q?ihEpgEtbII9Tq3/DJA2kc+rtogS5ZiyhTz4RWWbCQTEjcrVR5AXShyR5V4?=
 =?iso-8859-1?Q?qTgRYd2aEB12Qy1hnXS+zV9XTzqfqFlWBFgqMILWlenHhTNGc62fYnonV3?=
 =?iso-8859-1?Q?BKmsRhRJkjyd/NghPYZ0bfpdYUa16DZUnneDvngLotR5af+dizYcSYA/4l?=
 =?iso-8859-1?Q?XBNTMwAY8huu04uzoCq6klPpeh1Uh6pJfcleK6Q+PTcEwS0k2crkb4BwyN?=
 =?iso-8859-1?Q?FgTfMnnTtEugTpRxf1Cp+VcZqEe/uMWfhRwGnA37G8TAzxFdPnH/ZPembP?=
 =?iso-8859-1?Q?MRoXmVmwbWqlDpYq+RNS+ORi9XslT9InRseLa1qlvJwFDPDLBw4GCADWcJ?=
 =?iso-8859-1?Q?dDuT0iDWMLpj3TXDjYTtmxt/WO2zXMs69tTGJg68IBag72R/7mRz8IraG6?=
 =?iso-8859-1?Q?gMfuDM/4BaHwZ+1p4nf9zI/F2V4UkmkAYOkyBVlLOIdDUgQ+fvEhIWgOLN?=
 =?iso-8859-1?Q?syXAbR76E4BEmku/EbGLvfNsbrRCcf1G6wifx/+jg9VQjyWJXBT8oNuR/o?=
 =?iso-8859-1?Q?UMsIO1+MyH408e582cMn03dl+YVEvVxF+KZSL16EivDykhP+vYnxCSX6qc?=
 =?iso-8859-1?Q?TrqSURFjVzp/yipbLf0RCDmLI0QO+TuNgqrmaFQCnx/Y4i1sXT5pCN0NRs?=
 =?iso-8859-1?Q?Qi/NJxQCt1nNOoh+ROX/QE30FmxXNenNTHPICR41SBKAF6QqfYfZT3cFHI?=
 =?iso-8859-1?Q?6OWYDL7e8KCOvJazpNJ6Vqfs7BBLMB/ELNh/U/BEzs8nXtiyLbVa1WskeC?=
 =?iso-8859-1?Q?awtbWqLeOvF3vakM0PhloCVeY89reTvFdiCNA0rmaUNKouJtGy6OXyJhzL?=
 =?iso-8859-1?Q?kmf0I0lq2SSSEBAcjUlHBa/jxSuPkJGGAc90I/9Aessnipj60pC/fo+/58?=
 =?iso-8859-1?Q?V+574EWV/xYiu1yDb5B4MCJjbKCr3B9Svl0+jsColzsCz0xV+yeYXboYpI?=
 =?iso-8859-1?Q?uOhMlVxGSIuAqj8ubMKQVDZVqBDA6MtSlmwDsgaJZsWkDq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	kPMacI1teB2v2Jvyfnun/t+CkfZg7fD7xUfJwkVqiV2OYgABr1/Wqbf3Ds2g6iKUhhwDs+8pq9t2muO2h5zEfZKDXxNsiuryYjicuDZGCaRsI7O5H0M1gTLBF7QMIJ7bV0r6yhRlwlD3A8mahmqDwQrK/vvCuP0zWC8sHgtUQc+OnbEgZLQmJziZHeBOP+Ab90hFYObiLSG3qH3bX1KDpnPQMqJ4IPeK8Zt+W8Uy8s8a9VCRBvMn442kenM4idJ1ta16kj4yjMmBD49ewz6jYGnDb7STtS1E/jZ9oD4slESM4TRTkqRwnWurkyrSQs3WTKCaTTEjwnXVgJwVH/d2Cg==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385cfd06-646e-4c4d-6d66-08df2632685e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 18:23:25.1006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tkp9mqgO0LV4hb8CqEaYiR9ASLC24U2C1P1KR3nCG3EDIBPYO0Di1IKybtXverxxMDFiglk8l1k6wXainjkOEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR20MB007164
X-MDID: 1791570209-XmQntUKWzWnP
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1791570209;XmQntUKWzWnP;<arouhi@sitime.com>;5de2396b9b83917d02f0372d9ae54394
X-PPE-TRUSTED: V=1;DIR=OUT;

On Mon, 5 Oct 2026, netdev-bot+sashiko@kernel.org wrote:=0A=
=0A=
Reply inline.=0A=
=0A=
> [Severity: Low]=0A=
> This isn't a bug, but should the binding describe the chip's power=0A=
> supplies here? For example a core VDD supply and the per-bank VDDO=0A=
> output supplies.=0A=
>=0A=
> The schema ends with:=0A=
>=0A=
>     unevaluatedProperties: false=0A=
>=0A=
> With that, a board that adds a *-supply property to the dpll node fails=
=0A=
> dt_binding_check. A board that powers the part from switchable regulators=
=0A=
> then has no valid way to describe those rails.=0A=
=0A=
Right, the schema described none and refused any.=0A=
=0A=
v12 describes them by their pin names: vdd-supply for the PLL core=0A=
rail, vddin-supply for the input receivers and dividers, vdds-supply=0A=
for the GPIO rail the SiT95317 has, and one per output-driver pin --=0A=
vddo0 to vddo7 on the SiT95317, numbered as its datasheet numbers the=0A=
outputs, and vddo0_1, vddo2 to vddo9 and vddo10_11 on the SiT95316,=0A=
the two shared pins each powering the pair of outputs they are named=0A=
after. The variant conditional refuses the names the other part does=0A=
not have.=0A=
=0A=
> The supply names were not checked against the SiTime datasheet. Any=0A=
> supply properties added should use the chip's actual VDD/VDDO pin=0A=
> names.=0A=
=0A=
They are the pin names in the datasheets for both parts.=0A=
=0A=
The driver does not enable them. The SiT95317 datasheet states that=0A=
there is no power supply sequencing requirement for VDD, VDDIN and=0A=
VDDO, so a board that powers the part permanently needs nothing from=0A=
the driver. The binding now gives a board with switchable rails a way=0A=
to describe them.=0A=
