Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081BB4A7CA7;
	Mon, 21 Sep 2026 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023768; cv=fail; b=tmXLf9fD9CEI/VQvTlCVYuU2bbxQdERm4KDw+YHOPC6QVoD4Daux2mbkFpe5iWP2DZp3H9+B/CPzjBx/LtwXpywFu4zJwIS++4ZLW8THaqGBz5bIrmvZHbR8G6LYS64MCR3KgQhnj/KGbTBPdvlZTPJAFPhgx51GvVZ5c0GXcjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023768; c=relaxed/simple;
	bh=HvyGNbAO/+/3/2/37CcxcLIMz+3oTpTvgf5R6qVnqzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TAyEJ2qpjfOMDXauaSXHOBAcUbOOaQAx37qpZ3tFV5Luy7xymlRjbJLqmPXScr2DmoX+3Il6GKINjiDQ2XHdWUdGRunyItqBEkFgonWInSrG3O2QmpMcVg9iLYbX5ac6GNs+sDEdFxw9EWQlcDsQRp3W0c6tAjP2DAVH8vYpcQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=I6aHcTvl; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=OEzbMum3; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="I6aHcTvl";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="OEzbMum3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=WwLUB+ML1wttlNKFDJXOep3pEurALEyzyoazSP4tstw=;
 b=I6aHcTvlEiJOGpIpyBtLS7/5erIVomoHZlpDsk0NrjNh8KdMDuHiFh+8NDL4vEQ8+wPnIM8pZOMWIv9Ykuw3ksdaPQyuO92NT155+kKiNNXEJmlJAX88STqOO0fMIi8oDtRo+e4dB31tpq05KRQkHWdo4FJi1fFFBROXDV+vzEx9TqW6H4J9cdJvOk+HrURU57DHbLSRAM5saevXUPnbOa0v0QsyyEKgNGanvE7/DdHbvUrr48BaCkLoRPjgtPzsn0szMDrWBzBHZ8GU3AsB0FxYouIqfF1jWkmZ1zxQk8LMHf5VubDB+KPfO78wF1ewym6UOQrDMHiHhN9JDoaMrA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022078.outbound.protection.outlook.com [40.107.209.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 103C03C007B;
	Mon, 21 Sep 2026 20:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaZ1RicBAIe93PobMxsyOMJG0YLeCWM9AATuA+AhnAKSSliSLChAPyU1d8v6BrDhLCgcuLuCrsPBEYq/Ei45qbiP864AOj4uprSdXxae2trTKFqPwlEIoHiFLv87DCLbn5dXvSMWDUPGv5EvqLDlQjj14QXz2C8xAcnTo2bWebyPHhM5a3aduXiNSJu13IE3XVuz2etU3wpCIDKaWTwfHTH2sQtUDwnRW6nCA90uKGN5d12pGgnXU5fqRdS/uE1GTFeoj+7coysw5AJPoe6qqtCYjcOAXY3c6jlR5ijXXOtvz1vFNBwU8akGjhkjXkT6yyw47P1flYRDWF4V1sWeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwLUB+ML1wttlNKFDJXOep3pEurALEyzyoazSP4tstw=;
 b=zSYV/Fy8gYjGHiMZTKwV1nBErOjtwl6JVno6SCIxTyvXL1WAcIwrmRY6zWlRoTwoo8Fy1W3vJTMD096ONRUAAzXMhQFvulQdg3Lw6UAqfD44lkNR1m0QDmQm27XB8H+vfqWghaoF1+jP0DCA5gO0qBA06ksbcc9X9jkRMznvpv66IXCTXlcb+pyYoc88WRkXqd/DPjEaaLngMWYYwjyNAufoEi9yQ0LQQ0NPQA0zfVJDq5VicmUeE0328rKVtAxPD31KNuJdLEiya6s6hh+JeDcInScBkaBnu46qiC6L453o97DxVo5cOAB2bm92Gmu3wAu89YE7ujCSWxkOk2SIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwLUB+ML1wttlNKFDJXOep3pEurALEyzyoazSP4tstw=;
 b=OEzbMum3kKH/8I7hfc/OB1XZitPc8YFc9OUORwGzYNaJOK4C+gM2GdMHRzRk9NVRvkY2EKnBnnudo68VwBojsFEQ/Uw7BN1nSGvykMHyOgZh9C3668HOBkhC46Llqxp+vpDc7egbKdDNaO7dJCMiH72hEdmjVD6UzJ4Wrw5pJK+2GSKR/4p1UnXgdUOXqd6nAbY1wYuo5J6V2RyhzIdMukRT35ifoVgTv3Y4Not2TRWCMOjtjosnwrKiHkVoMk2aURMrhU/QKwWCWrSJGGPJiHSPaDHLRLwsjHyHDi4oqzxcAGfw7CUXdwlg9SPSs9E1suOV02eJjckPlcGkkv+NQQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS6PR20MB266123.namprd20.prod.outlook.com
 (2603:10b6:8:418::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.15; Mon, 21 Sep
 2026 20:49:20 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:49:20 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "ivecera@redhat.com" <ivecera@redhat.com>
CC: "jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
	<vadim.fedorenko@linux.dev>, "arkadiusz.kubalewski@intel.com"
	<arkadiusz.kubalewski@intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "cjubran@nvidia.com" <cjubran@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "Oleg.Zadorozhnyi@devoxsoftware.com"
	<Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v9 04/15] dpll: sit9531x: read DPLL types and pin
 properties from system firmware
Thread-Topic: [PATCH net-next v9 04/15] dpll: sit9531x: read DPLL types and
 pin properties from system firmware
Thread-Index: AQHdRKUxVgelaNcJnEeLERFAEdSBCLbSiFIAgAcDuYA=
Date: Mon, 21 Sep 2026 20:49:20 +0000
Message-ID: <20260921204918.53170-2-arouhi@sitime.com>
References: <20260915000015.80480-1-arouhi@sitime.com>
 <20260915000015.80480-5-arouhi@sitime.com>
 <5757ed06-a14c-4dc5-ada8-3a76129e2d5c@redhat.com>
In-Reply-To: <5757ed06-a14c-4dc5-ada8-3a76129e2d5c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|DS6PR20MB266123:EE_
x-ms-office365-filtering-correlation-id: 2a2e9d18-8745-467e-e33a-08df1821cfae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|10067099003|38070700021|3023799007|56012099006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 bk+42xbqqfNJ0DNvNLjizcwVBKY42FgdJJ/kpjRTh718JhTnja8hNuT8lU6Dlc6TonMWSqQj1hZz1lUWE8wyLQdp21D/GMcaaenZXNaQyBY9CTB50H21fE2eVkrLjgJJwctw2zosOnfZ3dNWXmKfOVJO+g++rRe0OxsUuF2+du4jA0j1nItfZdEc/+9GVk0QhUhFNerX8dRjx+Q3B+Xv8aXZpfXx+EP9VskWh4wW3EiDuFcE7cNTWxWOs0f5CIrQyDMGoI+UbehPLbPc0rfgKICtupCIXtv5bJVxIKYXi2UlpBdHDBRXn8j5YGgCRhR6J7cbynmAV8Hha/wii0nYEztINNKoxxt9JJfN8mdWSUWkXZYFVUDMFALq83l9sXgaTWt2tc+4EstUaUwd7PnSXvLdIiRAYZCpRTY2tpkGGutv9asVS0QkZn4g+d2zzOh7+KSNuT5mYjJ5k4RuWINP1ipCf9+TXyKDU2GP2Qqj/AEmytIOS4q5QClJAuf0GbOtl5txrKmh8j0WluCed7rBac7hpgHEknzxNAY9iJu8BsiqI99HDASuxV6j5dnYJoSIooyYrup+vOruf8bRQhoU2UPfkwyN86gopzj4YLkEnN+MFsJ/BbJVdlJzSh3HULcnoShpyikJKweb2QXL61BZ74TmzT0QZXUyVxKBvfE7vttigtEFhkLssKjfTG1/S0A6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(10067099003)(38070700021)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?I2xaOP7wm+ICQh2Qcp67OZa/S/3TvNDN4p1xk/KSsdTOsHKvQRKo1YkylB?=
 =?iso-8859-1?Q?SW3zbbAWtNQypnb+cnqSckRay/2WIQf4qGxK0vSrN0SL4hP1jdGfWeRQ1h?=
 =?iso-8859-1?Q?5OTZXiQoVTy0S9mDcDzYq0paIJohM77UC25pn6Sf3esdeG9X8o1kMF2+LK?=
 =?iso-8859-1?Q?YzxCyyURxJ+sFXcqxdmbaoqlt+U8NjxoFHE5JUA40Di7rYvJiPCiO5+eq0?=
 =?iso-8859-1?Q?Oun2bVDGuNplBmaGZlLTALslGeH8fbvTDhU2fOk0pONcxDr/UZLgcui1Pt?=
 =?iso-8859-1?Q?SJarnfjUPfVAxtED0NSO5g+8vBx1eY8MAA5Pf0CglP3aVxGfHKVZSboD5D?=
 =?iso-8859-1?Q?71kWdQ2upZGYA5Xwx9eYsB0bi/HTe9P8QFeQzzgHFAfzELhws82k9fk4tb?=
 =?iso-8859-1?Q?0tfoJpuaOL1rV4sMmuW4WB3XSHXcayueVBUzyTnzspdAFi92eYJD0Rf0le?=
 =?iso-8859-1?Q?DmY/R4PIFzMs6yosSxZLbAjcnePS56OJouI0ALKmRsThi0gHOHBcZWTVWs?=
 =?iso-8859-1?Q?KXIW7lKPw8nUI+ljfk2koWYBWoujAmc4GWspG+QggHqnmmSuox2C9zPQte?=
 =?iso-8859-1?Q?lPc+J+RrczpfP/WcRnvcZBBXj+ytVMaB4usmwkvOsHA9MhTbFL1APHQAXO?=
 =?iso-8859-1?Q?IxdlI+AK3YmrU3M01T89ZsJoUdazpkjY1/EpjH5/dVjdZ0Gfv2J6mkiy9i?=
 =?iso-8859-1?Q?ERNQnHUkLjCwIqmVGnTT2orvtYl9yjBDXILTQHXk58husQAVFSAZZPxu3J?=
 =?iso-8859-1?Q?Hz8onIUpUmVWmyjnkQz3Q/yZgYVgSJNWEk1bs3Rp/WQd0UCXyYCbcBGP0i?=
 =?iso-8859-1?Q?qdm+viJeXIm7FR+UFEHonk/r+tVU/vdTF/skRgg8n2YALXVSBm6dPvH8+1?=
 =?iso-8859-1?Q?i4ZVFHE4Wx/ZcsN8kYFb6w8LzbP7TL3n/gQ0bfPyraTbnXENLleYOLgVQ0?=
 =?iso-8859-1?Q?OoO3nZs9lk8ar6fTczYegb64ndxzKbexHMDX6acY3RqHRK2zXUY7mJW9FL?=
 =?iso-8859-1?Q?Jt7yUXoZZ9+3bEjAZ4kfklk/eLX6LxLm5Gs1TwC/nzEKXn6ODdooOQBb7L?=
 =?iso-8859-1?Q?TZEhdj4CUMeocCBsFrtsmvpSKgaBgwY7cjKIUxaMEo/BYwzSGGXvvlYv7x?=
 =?iso-8859-1?Q?Nip/7QUTL95neNCcZCcOL/pDG+pqzGdBpX+W9J12CBJAtiOOyGbWCTl+qi?=
 =?iso-8859-1?Q?TVthEHf59Y5e4whUbU8YFrpkaaUe6OITmP9EzFySYVILJzv8RbGae6MVP1?=
 =?iso-8859-1?Q?6EmNjwLMgnwgISqSEqxFs/4u5gcUN9xg7pOCfNMQxJq1arLLBEm1TYTnJe?=
 =?iso-8859-1?Q?/oh8mogJBfwajuSaZ8yg9qkr+DgjoEDPZ0el/uHwnWNnAa1NLI/A0c3Ld0?=
 =?iso-8859-1?Q?jxkmnuFY7Ju8axAFnqOTJlFS/vp3snYE0TKqOp2lzlMfmH8VxlDLpJRh97?=
 =?iso-8859-1?Q?RmCvTnSNi96zxF/hIPW/iUSgOmxa+TQTaNTCXMJ4DbkO+LvwI0MyBob8ju?=
 =?iso-8859-1?Q?ZMOdz+Ypl/wnpYLfjPnnFi/n/vAF86J7jVgXg5y6rMOWmUexF47EZT+3OS?=
 =?iso-8859-1?Q?2hW/iqT1ALt/meY1k6ui43CShhOaFXPkCA8b/GdTmHEnqx8q7WYANjRGwm?=
 =?iso-8859-1?Q?DqKBPx9nHrNSqjqtpWa7Cad8MwykuCveU9NTRhwskgzOCf+pd8xiiZHYCr?=
 =?iso-8859-1?Q?yKT3Ib+mMweCSoJlgSpgBlvj/5nGd14Cak8zfajFHYDD7rxfXCFMrXyqNY?=
 =?iso-8859-1?Q?T2ZQlNTaiKernAYEcjHxERiRoGd3+T+riiO+2O7B+sPRYT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	F8CzviGSZAgx7iKoU7p0Q9oGs3mSc2Yw+0QjzeEZbj6e8cjnm0+o+EktHGXvfxUqJrOYuVj1OeC527w/Ok7uFqe4WvAoGbeLyhv3qcmzP15s4Q46jDvmcbUJ+iwIA9BUcXHejU2DZ7dbTcIcBY+82Alo1toWGZXo1jsdl8cQ29RDeAsXCfdww5vPp9ehNdXk77lv8RofaA5IXBGUMRIv4b2Lc3jwe4WDcaJdc4U0WCHIA1baMD2dGOS20zvnV++ZAPkLMzGbuk5rO3QFG4BWghVRv5pWvPm5px0/9FeRnnk8Xrdz84e6fGH0CdSu/z1auUPgnBXiPuXsNgk6IAlBtw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2e9d18-8745-467e-e33a-08df1821cfae
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:49:20.3713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQnMgzwRsWJVWRfcSAr3K88ROcDQp4dsFrpL822VrnYZW2zoM+RsHuA3ois4Obt5Onywzy/0sJMMNKtc9CYxEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR20MB266123
X-MDID: 1790023765-pKXBMGgco0iV
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790023765;pKXBMGgco0iV;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

On 9/17/26 11:42 AM, Ivan Vecera wrote:=0A=
>> +	/*=0A=
>> +	 * The fine step is 30 ps, but requests are accepted at 1 ps=0A=
>> +	 * resolution and rounded to the nearest achievable delay, so=0A=
>> +	 * advertise the request granularity, not the hardware step.=0A=
>> +	 */=0A=
>> +	props->dpll_props.phase_gran =3D 1;=0A=
> =0A=
> What is the real HW granularity? If 30ps then you should announce 30 to =
=0A=
> inform the userspace that this is the step supported by the HW.=0A=
=0A=
There is no single hardware step on this part, and phase-gran is not=0A=
only advisory: the core rejects any request that is not a multiple of=0A=
it, in dpll_pin_phase_adjust_set().=0A=
=0A=
  if (pin->prop.phase_gran && phase_adj % (s32)pin->prop.phase_gran) {=0A=
          NL_SET_ERR_MSG_ATTR_FMT(extack, phase_adj_attr,=0A=
                                  "phase adjust value not multiple of %u",=
=0A=
                                  pin->prop.phase_gran);=0A=
          return -EINVAL;=0A=
  }=0A=
=0A=
So whatever the driver announces becomes a filter on what userspace is=0A=
allowed to ask for, and that is what makes 30 the wrong number here.=0A=
=0A=
A requested delay is split between two fields that are added, not=0A=
selected between: a coarse delay counted in whole VCO cycles, and a=0A=
three-bit fine field in fixed 30 ps steps. The reachable delays are=0A=
=0A=
  coarse * T_vco + fine * 30 ps,   fine in 0..7=0A=
=0A=
where T_vco is the VCO period in force. For 30 to be the right modulus,=0A=
T_vco would have to be an exact multiple of 30 ps. It is not. The=0A=
feedback divider is fractional, so Fvco is XO * (DIVN_INT + NUM/DEN)=0A=
times the doubler, and the period that falls out of that does not land=0A=
on a 30 ps boundary. As soon as one coarse cycle is part of a delay,=0A=
the reachable values are offset by that remainder and stop being=0A=
multiples of 30 at all.=0A=
=0A=
Take T_vco =3D 240.5 ps purely as arithmetic. The reachable delays are=0A=
0, 30 ... 210, then 240.5, 270.5, and so on. Announcing 30 against that=0A=
set would be wrong in both directions at once: the core would reject=0A=
240.5, which the device produces exactly, and accept 240, which it=0A=
cannot produce at all. A faster or slower VCO does not fix this, it=0A=
only moves where the mismatch starts, and Fvco differs per PLL and per=0A=
board.=0A=
=0A=
Announcing T_vco instead would at least describe the coarse field, but=0A=
it discards the fine one: the core would then refuse every delay that=0A=
is not a whole number of VCO cycles, and the 30 ps resolution inside a=0A=
cycle becomes unreachable through the ABI. It is not exact either,=0A=
since phase-gran is an integer number of picoseconds and T_vco is not.=0A=
=0A=
So the driver announces 1, accepts the request, rounds it to the=0A=
nearest delay the two fields can represent, and reports back what the=0A=
registers hold rather than what was asked for. A caller that needs the=0A=
exact applied value reads it back and gets the truth for its own VCO=0A=
rate.=0A=
=0A=
I recognize this leaves phase-gran carrying less information than it=0A=
does for zl3073x, where one output period is a genuine step and the=0A=
readback scales by it. If you would rather the attribute describe the=0A=
coarse field even at the cost of the fine one, I will announce T_vco=0A=
instead. I did not want to close off the resolution inside a VCO cycle=0A=
in order to make a single number look tidy.=0A=
=0A=
This is unchanged in v10, with the reasoning set out in the cover=0A=
letter:=0A=
https://lore.kernel.org/netdev/20260921201108.42676-1-arouhi@sitime.com/=0A=
=0A=
Thanks,=0A=
Ali=0A=
