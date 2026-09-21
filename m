Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA72414422;
	Mon, 21 Sep 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021492; cv=fail; b=IzfrFDvE8dWh5+ZyxFVvMG+AwbevwgMxgh7AMWKsVrDcId8XNpYgHI86eNBgKwV3XYpami8dyeQQRznkbJL/WqQxkr60opMxwlv6bfKkwodDIYF9Ko6Iucvg7n4C480CIig/TkdI3uMDVCCjVO+Qfsyd0MZ7CLwDlratKmu+b78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021492; c=relaxed/simple;
	bh=oZpMqZOpWUrGZN/xJv1zBrPSUAhiQk1Z7tj4bRVZ488=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qzup1etOR7SQPyNlfCB8J69oYmrYdsSJYfBGTHiKKS8fezAPMLFQM5bFDRN4lVtV7GMWMAXtqKIXVWP6XNJy0wi/3QXmlmxgLt3PCHRSNjrDtUUeXtpXhwZWoA60qQe4mtlKRmzB+kuR+ICoPmcy1xUpRnOk0hZ+l5AhP1jB9wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=ggyButXM; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=M/rjGnXj; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="ggyButXM";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="M/rjGnXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=ZYaB0wu9kT2XQP3cGBtzP1VPNqqWKzggmiV2PAfKUgk=;
 b=ggyButXMptUZKhkdu1oskvdfJ14ewMbhcP9XN5dYTH6SXD1BOt0Zxqb/biXIQ5qwcsOfMQT5imAD8jOkBZFHQqNrlZA48oMWiZFfwcStIrMqb2apVSqAppQCQkZsBAwMO84p1ZQvjQ/ifYn+40H0I2pdK+VejgG6SVTLW3RuE+F/50EHtteyTfPv0+r5A1DrA2zshu/mGQ5p4PQSu/bz/D6wM/D/5l2mjHC0nb9gd+teEWD0o2BJUUqaFHCeSi0/2GcemRAwiSHLtIjuSiIPG7um2Jxf+C0fuUR4VyUJP21/L8G4xcZyznx1grkgr9WBDRrRk8JFtre0hp+T/j4LVw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020140.outbound.protection.outlook.com [52.101.193.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 2630F940097;
	Mon, 21 Sep 2026 20:11:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tS116KtME8615AEzMxj3k+Hv7VmSKMaCLXb2rOn2f8QKhLcupOD2dYAevIpOSzXbfqsDNlGf3p6SeYRAZCkv1DSprRdA/xZf6ArzopXP+qT86VmcbtfjFzFaDho8WhPK9qdF3wb/0fl1jIGAd70E91gOW5fQE4l+1nvuPfXPduhqNWfBgmmAM4YqMHMDmsxU2A9aBOp5k12PYLuzULKJYXbtqbtsxbjV3sAVvD/Cm8HaxIX83Zdlwe1NegX656MUxNNy24ibGfc+BCwOAwi76szfANOo2Wr90udGM5qTwQf82Em3YNJodwcJdBJS9pDUPoTjPjpaRpyQ8hLkbzl8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYaB0wu9kT2XQP3cGBtzP1VPNqqWKzggmiV2PAfKUgk=;
 b=np8gzUOqcpDRavp2JH0dflU+2dUHpdB9hjTb3ZQQIPNkyaPN/qxi2Miow+W5J8Va+rQOhAXJe/A2gRwmLPc9e6SbCn82F5NFTRrnbYSs1ZVaGHK29F/sAkSqXef83fZl4I7pBeg0EcJ5/0acNU9YyqAX9Qp7t8wRmbgKR9jVdqtcW+80tza48501w0bR4QDaq5db/K7jktVJDkqFThoW2BJCloi2kBAVzqDllXeAE/zrD6w1//hjY+zZ5o2EuqIpiZ9CmIMlLmKQzreanLCPUuXBextPBJqoLwgxY6XeKG1LokKmxTQV7lEln1ieuZ4MNbErpfD0KlBE1P5kBOEMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYaB0wu9kT2XQP3cGBtzP1VPNqqWKzggmiV2PAfKUgk=;
 b=M/rjGnXjze4+t8yB53458g6etWH9CoNhXRzo88Gt1wzb7EmiR9vf7jNMTGDLtUdmI15R+WECbDp3tOmafBnAh5vBVPJjuILmDRpGBT0fn5GR7JaLm2whuBXqQdOPpyLdSwU0vVs4sH7Z50RbbF1NkkPj8JFP62xnQClk2ks1g4ySmPQQvAExELr1E9Q8TLMaEE3v+n5W373DRrzcQ/bqOa6RFCp/YAGhcUSPHEDvYG7LlmnFJdGxKdcfigs1x1gwPq0SbqcSwqGAoRT6oYfjnORSNQcaZp5N6RV9p6Kjdk+meSWv0l2hhRwZO8HvQ6oBCq4fk10ywVvwQ+IZ/czfIw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by DS3PR20MB7783.namprd20.prod.outlook.com
 (2603:10b6:8:2df::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:11:13 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:11:13 +0000
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
Subject: [PATCH v10 06/14] dpll: sit9531x: implement input pin state on a DPLL
Thread-Topic: [PATCH v10 06/14] dpll: sit9531x: implement input pin state on a
 DPLL
Thread-Index: AQHdSgVZMNXNlyK8zE+dqQB+q0teIg==
Date: Mon, 21 Sep 2026 20:11:12 +0000
Message-ID: <20260921201108.42676-7-arouhi@sitime.com>
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
x-ms-office365-filtering-correlation-id: 86a8810d-2580-4b83-849f-08df181c7c13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|5023799004|38070700021;
x-microsoft-antispam-message-info:
 212bxKF+a2jaiKmwERDfE/1U75KZaV7MSjAqTxZMLHA/O8RTWVWGRO/bznVU8fFkr9+RUU/cr3ARr1WmaI8ZvsCKP819F9BLtumEbWGIQWkpv1ZBpHPxL43aLtP/JwgsiNg8+eJlGsV7SBeN3hz1DTQfD3pNxyKxJq/vioYQ/sQ1CyDBpI/MhzPwbjgpYjFZs7/rj4xzJ+7tgnjb/6PBU5fUZcGkXU/JXZt/dDTX252d0xSK2RUzE/wTHVCdwqMRsg6KIU/UbBq48qyHma5xvvOsNs/erJfEfCavhHwHN5mwO3tQ61cHEa4RXw9aijm1CdIDSq58ENiw7K3Nj3qFQKzCv6c6b2MbKTkjStTgVdfSJhFercbIUy35rPjbi/trOiLiQE/62C3TpMq2HPaDEVSjjeWGTCVrNCf0pnWLwTS3LV97Z73RZfqNE1TZYQWXnM6szOtO+E4bvTQxV/EK1IfRGo4jtf4Xlv3RCV1GFazqCO2KUp6mZ5QMZH0foyq5V2UKguEmdd4wsEU/g1fLNPygcw7T/LtazrZD7aBcA24Cdja6tN6fXP5DvpCEQyb7Il+a3vClVhdFb9RgHyijdpi0a1IwIl4Qp6gKUeL+6flyL/dd+wgfLBk4dYIgADxWpyB0hUgNb5xEbKAmvpjdW8etrFppjLOdQBw+FfDK2xcUjxwJpNb3BMdjwY9gfGcsbzFG6wK7LrF9+1BqrkHIHRDX7L1mp5A0GUommpnAIg8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(5023799004)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?h1oDVgIpt4Lqm5TNA1F8CTJI1B4fg7S/3IJx2A8P6L3HTRIQ0VByGTuxRQ?=
 =?iso-8859-1?Q?BaYXCyw7eAcCHgbjgBVhEBpNlfxUdQ5mGcEy2vLxor3dpJ4jwqM+ubaIv/?=
 =?iso-8859-1?Q?/r5cvTmPRXjw1Dn0DyCHiFMSilLkBGBmILbeX6urPMOu9hNbX9nZwK0uII?=
 =?iso-8859-1?Q?k+QpI2NaSA2KTVkF04zhWCmLdqJmvMYHRQzjiP/n0ai+EsvnyEDMA56oBU?=
 =?iso-8859-1?Q?zj9OTD45SZwOCLrsbtBHcpuXAZ9wCbAY3E98TeMWn9SMOHClsUWKWZiuOn?=
 =?iso-8859-1?Q?j1dWtM8z/xDecrWd6bUsFJQhitpNyTaIsZDsUaOC8LXgABWpFTlmMQwXrm?=
 =?iso-8859-1?Q?aGz9HfU+UrWXIEpJZPS/uClUu+IXtCrYy2aoolF2d4Mh4w0n/1jy0tEYjY?=
 =?iso-8859-1?Q?++MWowRxE9utjj4ZKTeQYfCliMmk3N1S4trjFTgZ9zQOCgP0kXobqGxhyl?=
 =?iso-8859-1?Q?dJ57QkikI32SMSdJLmBAR5xBP4kMkIYCpcEnbN8KFNjtLPOJAIQWevXJj2?=
 =?iso-8859-1?Q?bIoC6lIwtQd6lsFPU5xtfDvgmQkCWARl+iKnKmfdUv0LssCMnwAcdHf37s?=
 =?iso-8859-1?Q?pfHj/vd/qXNSAc9L59CFkUSMxTfokNGKI7e7EFENAJTAvwaGXhjj8HlI8q?=
 =?iso-8859-1?Q?Q/tKSprFMzDBlRqsEmguajDdATL8/+27ZsqvLWlPQcbIHEMbq8qd9HaCDP?=
 =?iso-8859-1?Q?JU8uvogbnvOrsE+ePPyZiQk4tTvmIfSIWJv4cUrEXMUjbqmW3E8nt0Z3TP?=
 =?iso-8859-1?Q?BVoEGC76vC0fFfOYiqvj8ah7hNanQTzXy3BEgmgOF+m0zT2orVOLAavYlW?=
 =?iso-8859-1?Q?SCs0iPB8YZYBIJeicGB23/hW0i21L1EgXl0jMGZFgym0u1I1/sIs6X07eX?=
 =?iso-8859-1?Q?CvI0UwqmR97gnUOsurTLxkWwS4CGdkQfQMvmnLN6C4/yAeEkSZ1zFe5oBI?=
 =?iso-8859-1?Q?MsW0a+/vtZmfu2oDnR+RPkopHUEkl2PWQCIe/kVPwQxi5OWfsCu9Fhyx36?=
 =?iso-8859-1?Q?I8jJdXr4lS4gZaMwfqxCeolkv4Zi2YbDCZEAkd7vtatUpVPN66aJ2he541?=
 =?iso-8859-1?Q?BHV0spwpgSLpgRdG15WV7oYZbubOmD91z/JJJK4hR6yyq7DT5tcVoMp3MV?=
 =?iso-8859-1?Q?1rM8hoqSGlU48wYuo6HsmjEToUQ2NFS2+K8uAlV+ag+t6mQPdjFmqrfbyd?=
 =?iso-8859-1?Q?qFiakEc8P+RX/1uCj4s/EWVx1QqX/75UUO6j7f2lrXOqQ1eeKvubl9ODd0?=
 =?iso-8859-1?Q?5jkQbOhLEtXYiG+vqcWsdZhih2hGRm4iB7Tcl93E3PNeW2ErMwdVw43Pz6?=
 =?iso-8859-1?Q?xcXOFa2kSSLPzBDt2cyqtyv525FyyRHdr/d6stiBDlFk8nzLMP4b43Kwjx?=
 =?iso-8859-1?Q?YTvkR3YFB4d70huHyum8RRSZ8Lq9SyrfYD4fCatwXn7578U8MN7k5tworw?=
 =?iso-8859-1?Q?1wntzj9hfyK2COiL68Dr6Bu8G9C3EWXEbpOKURmqa2ERGSSplVkOKGrzYc?=
 =?iso-8859-1?Q?SJPbPZOYhMzdP9P+NhQr4rSbBmD2yS3Aiv1/QFJ9z9zq+QICDFyACPbGUr?=
 =?iso-8859-1?Q?ZaG9VYIT09d6qUnI8r+mmu8/NgYtyBkkuOL2BBceFNN1QMRV9ebPtTgv9U?=
 =?iso-8859-1?Q?kfyO7mwm1SZ4OCFg0EkNgv8N33l8hPMt4VFx7oxH97U3Uzo+iPmwJBseIw?=
 =?iso-8859-1?Q?jsOeD4d5GUtVw6dqTEYAlBnzCalfdcFyN3HdbYSDaZQ/gCrhgbLT/htLdM?=
 =?iso-8859-1?Q?wnWhakg6XkJ46waJIarpMZr+l3ETVMHPwAfK7ZAPPEekjW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	xBHpOmJ0OYn6kj3aLL23YNRqIp/qPg71uPMn3/YZliC3p0aRr6KK7co+ta4SBSzaW3+rDWL2s5uBHHRYU4aFMAVJRrOct+P2nQMB/jm1To0G/wvBTbBU8YR402AXaCREiCyq/z2CUXHfpE6JvCTWysEt/3JErnpg41eGdBqIe3ZMOWzHs5jTgMOrroyxi3Eg1K5P7q4hrLipOI3N1SobyTgFLh6HsvA/uaM6GkSvBtM1WX5kpAU4UC0YERTo5sxW+yoA3qVIbNmgs/oPwrQOygCeYEIaFj+6F1rGiEX8toeQ+5OVMdXDI0ReywznP1s/xUzqnR7Hjo1P34RHRu9Bnw==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a8810d-2580-4b83-849f-08df181c7c13
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 20:11:12.8990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T+H79sPkl6uZHFuhcOwWGpF+r8hqwJ5F+gzSpt0mV9DJH6JQNVqsXqvl9iuP+N5ItDyXkbWwdU/f2ODvdAmIgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR20MB7783
X-MDID: 1790021479-ks_S3iC9ddZ6
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1790021479;ks_S3iC9ddZ6;<arouhi@sitime.com>;ee4c095510f4a2bc549243be2f087a38
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
=0A=
Report and set whether an input feeds a given PLL.  The device selects=0A=
its reference itself from a priority table, so membership of that table is=
=0A=
what "connected" means here: an input in the table is selectable, the one=
=0A=
the PLL has selected is connected, and an input absent from the table is=0A=
disconnected.  Selected, not locked: how well the loop is tracking the=0A=
reference it picked is what lock status answers, and a PLL that is=0A=
following a reference it has not settled on yet is still following that=0A=
one and no other.  Setting the state therefore adds the input to the=0A=
table or removes it, and the table is read back rather than remembered.=0A=
=0A=
Removing the last one is allowed, and empties the table.  The four-bit=0A=
slot encoding has a value for that: two of its codes address a fifth=0A=
input pair this part does not have, so a slot holding one names nothing=0A=
the device can select.  A DPLL whose table is empty has no reference to=0A=
choose and no pin reporting itself selectable, which is what a request to=
=0A=
disconnect the last input means; lock status follows the loop from there=0A=
without the driver writing a mode.=0A=
=0A=
The pins fall into three roles and only the first answers this question,=0A=
so the contract for all of them is written above the operations rather=0A=
than left to be inferred: inputs and the inter-PLL sync destination take=0A=
part in selection; an output and the sync source are driven by the PLL and=
=0A=
report whether they carry a signal; the crystal is fixed and always=0A=
connected, since a PLL cannot be told to stop using it.=0A=
=0A=
Rewriting the table means forcing the PLL into holdover, waiting for it to=
=0A=
take, writing every slot and releasing holdover again, all under the=0A=
device lock -- ten to twenty milliseconds.  The device has no way to=0A=
change one slot in isolation, and holdover is what keeps the loop from=0A=
chasing a table that is momentarily inconsistent, so the sequence is the=0A=
cost of doing it correctly.=0A=
=0A=
Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>=0A=
Assisted-by: Claude:claude-4-opus [chat]=0A=
Signed-off-by: Ali Rouhi <arouhi@sitime.com>=0A=
---=0A=
=0A=
Notes:=0A=
    Changes in v10:=0A=
    Priority table coherence: a table that was written only in part is put=
=0A=
    back rather than latched; the mask describes what reached the device=0A=
    rather than what was asked for; a slot naming no reference counts as=0A=
    free space instead of as a source; moving a priority collapses the=0A=
    duplicate entries a disconnect leaves behind, and a slot the collapsed=
=0A=
    table cannot express is refused rather than turned into a different one=
.=0A=
    =0A=
    Removing the last reference now empties the table instead of being=0A=
    refused, so a DPLL can be left with no source.  The slot encoding has=
=0A=
    codes for an input pair the part does not have, which read back as no=
=0A=
    valid reference; every slot gets one.  No mode register is written.=0A=
    =0A=
    Connected means the device has selected the pin, not that the loop has=
=0A=
    locked to it.=0A=
    =0A=
    The receiver is gated on its own state rather than on this DPLL's claim=
,=0A=
    and only a receiver this request turned on is turned back off.=0A=
=0A=
 drivers/dpll/sit9531x/core.c | 604 ++++++++++++++++++++++++++++++++++-=0A=
 drivers/dpll/sit9531x/core.h |  10 +=0A=
 drivers/dpll/sit9531x/dpll.c | 193 +++++++++++=0A=
 drivers/dpll/sit9531x/regs.h |   4 +=0A=
 4 files changed, 800 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/drivers/dpll/sit9531x/core.c b/drivers/dpll/sit9531x/core.c=0A=
index 6f19dab89bee..84c1f86e6d4c 100644=0A=
--- a/drivers/dpll/sit9531x/core.c=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -206,6 +206,94 @@ static void sit9531x_input_get_regs(const struct sit95=
31x_dev *sitdev,=0A=
 	}=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_disable - disable an input reference=0A=
+ * @index:	logical input index (0-N)=0A=
+ *=0A=
+ * Sets the force mask bit and clears the state bit for the given=0A=
+ * input, effectively disabling it.  Register selection depends on=0A=
+ * the pair's signal mode (SE/DE) and the lane (P/N); the bit within=0A=
+ * each register addresses the input pair.=0A=
+ *=0A=
+ * Both writes are attempted even when the first fails, and the first=0A=
+ * error is returned.  Neither is rolled back: the force and state bits=0A=
+ * only mean something together, so a transient bus error can leave the=0A=
+ * force bit asserted over a state bit that was never programmed, and the=
=0A=
+ * error is what says the override is not to be trusted.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	unsigned int force_reg, state_reg;=0A=
+	struct sit9531x_ref *ref;=0A=
+	u8 pair, val;=0A=
+	int rc, ret;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (!rc)=0A=
+		rc =3D sit9531x_write_u8(sitdev, force_reg, val | BIT(pair));=0A=
+=0A=
+	ret =3D sit9531x_read_u8(sitdev, state_reg, &val);=0A=
+	if (!ret)=0A=
+		ret =3D sit9531x_write_u8(sitdev, state_reg, val & ~BIT(pair));=0A=
+	if (ret && !rc)=0A=
+		rc =3D ret;=0A=
+=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	ref->enabled =3D false;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_enable - enable an input reference=0A=
+ * @index:	logical input index (0-N)=0A=
+ *=0A=
+ * Clears the force mask bit for the given input, returning it to=0A=
+ * hardware default (enabled).=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index)=0A=
+{=0A=
+	unsigned int force_reg, state_reg;=0A=
+	struct sit9531x_ref *ref;=0A=
+	u8 pair, val;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (index >=3D SIT9531X_MAX_INPUTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	ref =3D &sitdev->ref[index];=0A=
+	pair =3D sit9531x_input_pair(index);=0A=
+	sit9531x_input_get_regs(sitdev, index, &force_reg, &state_reg);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, force_reg, &val);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+	rc =3D sit9531x_write_u8(sitdev, force_reg, val & ~BIT(pair));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	ref->enabled =3D true;=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /*=0A=
  * Output enable / disable (Hi-Z control)=0A=
  *=0A=
@@ -368,6 +456,92 @@ static u8 sit9531x_prio_slot_get(u8 val, u8 slot)=0A=
 	return val >> SIT9531X_PRIO_HI_SHIFT;=0A=
 }=0A=
 =0A=
+/* Place source @src in priority slot @slot of a register value. */=0A=
+static u8 sit9531x_prio_slot_set(u8 val, u8 slot, u8 src)=0A=
+{=0A=
+	if (slot & 1)=0A=
+		return (val & (SIT9531X_PRIO_NIBBLE_MASK <<=0A=
+			       SIT9531X_PRIO_HI_SHIFT)) |=0A=
+		       (src & SIT9531X_PRIO_NIBBLE_MASK);=0A=
+=0A=
+	return (val & SIT9531X_PRIO_NIBBLE_MASK) |=0A=
+	       ((src & SIT9531X_PRIO_NIBBLE_MASK) <<=0A=
+		SIT9531X_PRIO_HI_SHIFT);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Commit a priority-table programming sequence through the Page-0=0A=
+ * programming directive register.=0A=
+ *=0A=
+ * A small change update is all the table needs.  The NVM-bank and=0A=
+ * loop-lock directives that the output system issues do not belong=0A=
+ * here: the former programs non-volatile storage from the efuse and=0A=
+ * the latter only means anything after an escape to the PRG_CMD=0A=
+ * state.  This matches the documented input_priority_sel() procedure.=0A=
+ */=0A=
+static int sit9531x_prio_prg_commit(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	int rc;=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, SIT9531X_REG_GLOBAL_UPDATE,=0A=
+			       SIT9531X_SMALL_UPDATE_CMD);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(1000, 2000);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Fold a source code to the lane a DPLL pin actually represents.=0A=
+ *=0A=
+ * Differential input pairs expose only the P lane as a DPLL pin.  A=0A=
+ * priority table entry encoded as an N lane for such a pair must map to=
=0A=
+ * the P-lane source for pin-facing operations (membership, priority slots=
,=0A=
+ * add/remove/set lookups), matching sit9531x_ref_pll_mask_fetch().=0A=
+ */=0A=
+static u8 sit9531x_prio_src_canon(const struct sit9531x_dev *sitdev, u8 sr=
c)=0A=
+{=0A=
+	u8 index =3D sit9531x_hw_src_input(src);=0A=
+=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return src;=0A=
+=0A=
+	if (sit9531x_input_is_n(index) &&=0A=
+	    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		return sit9531x_input_hw_src(index - 1);=0A=
+=0A=
+	return src;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_present - is a source listed in a PLL's priority ta=
ble=0A=
+ * @input_idx:	input source in hardware encoding (see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ *=0A=
+ * Answers from the membership mask that every table write and every poll=
=0A=
+ * refreshes, which is what the pin state getters test.  The priority slot=
=0A=
+ * cannot answer this: a source that is not in the table reports the lowes=
t=0A=
+ * slot, so the slot value alone does not separate absent from last.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev, u8 pll_idx,=
=0A=
+				 u8 input_idx)=0A=
+{=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return false;=0A=
+=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return false;=0A=
+=0A=
+	return !!(sitdev->chan[pll_idx].prio_mask & BIT(input_idx));=0A=
+}=0A=
+=0A=
 /*=0A=
  * Rebuild a PLL's membership mask from the source codes of its priority=
=0A=
  * table.  The mask is what the pin state getters test, so it is refreshed=
=0A=
@@ -375,11 +549,20 @@ static u8 sit9531x_prio_slot_get(u8 val, u8 slot)=0A=
  * per poll from the read-back in sit9531x_chan_state_fetch().=0A=
  */=0A=
 static void sit9531x_prio_mask_build(struct sit9531x_dev *sitdev, u8 pll_i=
dx,=0A=
-				     const u8 *srcs)=0A=
+				     const u8 *srcs, u8 written)=0A=
 {=0A=
 	u16 mask =3D 0;=0A=
 	u8 slot;=0A=
 =0A=
+	/*=0A=
+	 * A table written only in part is not described by the values the=0A=
+	 * request carried, and there is nothing here to describe it with=0A=
+	 * instead, so the mask it had stands until the next poll reads the=0A=
+	 * table back.=0A=
+	 */=0A=
+	if (written < SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return;=0A=
+=0A=
 	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
 		u8 src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
 =0A=
@@ -390,6 +573,107 @@ static void sit9531x_prio_mask_build(struct sit9531x_=
dev *sitdev, u8 pll_idx,=0A=
 	sitdev->chan[pll_idx].prio_mask =3D mask;=0A=
 }=0A=
 =0A=
+/* Attempts to release a forced holdover before reporting it stuck. */=0A=
+#define SIT9531X_HO_CLEAR_TRIES		3=0A=
+=0A=
+static int sit9531x_prio_table_commit(struct sit9531x_dev *sitdev, u8 pll_=
idx,=0A=
+				      const u8 *srcs)=0A=
+{=0A=
+	u8 val, slot, attempt, written =3D 0;=0A=
+	int rc =3D 0, prg_rc, ho_rc =3D 0;=0A=
+	u16 reg;=0A=
+=0A=
+	rc =3D sit9531x_update_pll_u8(sitdev, pll_idx, SIT9531X_PLL_REG_HO_CTRL,=
=0A=
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT),=0A=
+				    BIT(SIT9531X_PLL_HO_FORCE_BIT));=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	usleep_range(10000, 12000);=0A=
+=0A=
+	/*=0A=
+	 * Two slots share a register, and this writes every slot, so both=0A=
+	 * nibbles are known for every register but the last -- build those=0A=
+	 * bytes outright.  Reading first would raise the question of what a=0A=
+	 * read returns between the write and the latch, and the answer does=0A=
+	 * not matter if nothing is read.=0A=
+	 */=0A=
+	for (slot =3D 0; slot + 1 < SIT9531X_PRIO_MAX_SLOTS; slot +=3D 2) {=0A=
+		reg =3D sit9531x_prio_reg(pll_idx, slot);=0A=
+=0A=
+		val =3D sit9531x_prio_slot_set(0, slot, srcs[slot]);=0A=
+		val =3D sit9531x_prio_slot_set(val, slot + 1, srcs[slot + 1]);=0A=
+=0A=
+		rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+		if (rc)=0A=
+			goto commit;=0A=
+=0A=
+		written =3D slot + 2;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * The last slot shares its register with a nibble this table does=0A=
+	 * not use, so that one is read first to leave it as it was.=0A=
+	 */=0A=
+	reg =3D sit9531x_prio_reg(pll_idx, slot);=0A=
+=0A=
+	rc =3D sit9531x_read_u8(sitdev, reg, &val);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+=0A=
+	val =3D sit9531x_prio_slot_set(val, slot, srcs[slot]);=0A=
+=0A=
+	rc =3D sit9531x_write_u8(sitdev, reg, val);=0A=
+	if (rc)=0A=
+		goto commit;=0A=
+=0A=
+	written =3D SIT9531X_PRIO_MAX_SLOTS;=0A=
+=0A=
+commit:=0A=
+	/*=0A=
+	 * Latch unconditionally: slots written before a failed write are in=0A=
+	 * the table regardless, so the latch keeps hardware and the cache=0A=
+	 * refresh below consistent with what was actually written.=0A=
+	 */=0A=
+	prg_rc =3D sit9531x_prio_prg_commit(sitdev);=0A=
+	if (prg_rc && !rc)=0A=
+		rc =3D prg_rc;=0A=
+=0A=
+	/*=0A=
+	 * Refresh the cache from the table just written, so a get that=0A=
+	 * follows a set does not have to wait for the next poll -- but only=0A=
+	 * for the slots that reached the device.  Describing a table that=0A=
+	 * does not exist would make the membership test answer for writes=0A=
+	 * that failed, and that test is what decides whether a failed=0A=
+	 * request gets rolled back.=0A=
+	 */=0A=
+	sit9531x_prio_mask_build(sitdev, pll_idx, srcs, written);=0A=
+=0A=
+	/*=0A=
+	 * Release the forced holdover.  Nothing else in the driver clears=0A=
+	 * this bit, so a PLL left with it set reports holdover until the=0A=
+	 * next table write on the same PLL happens to clear it, which may=0A=
+	 * never come.  Retry before giving up, and say so if it stays set.=0A=
+	 */=0A=
+	for (attempt =3D 0; attempt < SIT9531X_HO_CLEAR_TRIES; attempt++) {=0A=
+		ho_rc =3D sit9531x_update_pll_u8(sitdev, pll_idx,=0A=
+					       SIT9531X_PLL_REG_HO_CTRL,=0A=
+					       BIT(SIT9531X_PLL_HO_FORCE_BIT),=0A=
+					       0);=0A=
+		if (!ho_rc)=0A=
+			break;=0A=
+		usleep_range(1000, 2000);=0A=
+	}=0A=
+	if (ho_rc) {=0A=
+		dev_err(sitdev->dev, "PLL%c left in forced holdover: %d\n",=0A=
+			'A' + pll_idx, ho_rc);=0A=
+		if (!rc)=0A=
+			rc =3D ho_rc;=0A=
+	}=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_prio_table_read - read a PLL's priority-table source codes=0A=
  * @srcs:	output array of SIT9531X_PRIO_MAX_SLOTS source codes=0A=
@@ -414,6 +698,242 @@ static int sit9531x_prio_table_read(struct sit9531x_d=
ev *sitdev, u8 pll_idx,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_prio_set - move an input to a priority slot=0A=
+ * @input_idx:	input source in hardware encoding (0-11, see=0A=
+ *		sit9531x_input_hw_src())=0A=
+ * @prio:	priority slot position (0 =3D highest)=0A=
+ *=0A=
+ * Reads the PLL's table, takes the source out of wherever it sits and=0A=
+ * reinserts it at @prio, shifting the entries in between.  The rest keep=
=0A=
+ * their relative order: a priority change asks about one input, so the=0A=
+ * fallbacks configured behind it have to survive it.=0A=
+ *=0A=
+ * The table is what makes a source eligible for this PLL, so this only=0A=
+ * ever reorders sources already in it.  A source that is absent is=0A=
+ * disconnected on this PLL, and inserting it here would make it a=0A=
+ * selection candidate again behind the caller's back; that is a connect,=
=0A=
+ * and it belongs to the pin's state setter.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, -EINVAL if the source is not in the table,=0A=
+ * <0 on error=0A=
+ */=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio)=0A=
+{=0A=
+	u8 orig_srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 rest[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 slot, n =3D 0;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+	if (prio >=3D SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	memcpy(orig_srcs, srcs, sizeof(srcs));=0A=
+=0A=
+	/*=0A=
+	 * Take every copy of the source out first.  A disconnect backfills=0A=
+	 * the slots it frees with the lowest-priority source still listed,=0A=
+	 * so the same source appearing more than once is an ordinary state=0A=
+	 * of the table, and shifting from its first copy alone can leave=0A=
+	 * another copy ahead of the slot the request named -- a priority=0A=
+	 * the request did not ask for and the getter would then report.=0A=
+	 */=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)=0A=
+		if (sit9531x_prio_src_canon(sitdev, srcs[slot]) !=3D input_idx)=0A=
+			rest[n++] =3D srcs[slot];=0A=
+=0A=
+	if (n =3D=3D SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return -EINVAL;=0A=
+=0A=
+	/*=0A=
+	 * Once the copies are collapsed the source can only sit behind the=0A=
+	 * other sources the table lists, because the slots past the last of=0A=
+	 * them repeat it.  A slot beyond that is a priority the table cannot=0A=
+	 * express, and placing the source at the nearest one it can would=0A=
+	 * report success for a priority nobody asked for.=0A=
+	 */=0A=
+	if (prio > n)=0A=
+		return -ERANGE;=0A=
+=0A=
+	for (slot =3D 0; slot < prio; slot++)=0A=
+		srcs[slot] =3D rest[slot];=0A=
+=0A=
+	srcs[prio] =3D input_idx;=0A=
+=0A=
+	for (slot =3D prio + 1; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)=0A=
+		srcs[slot] =3D (slot - 1 < n) ? rest[slot - 1] : srcs[slot - 1];=0A=
+	if (!memcmp(srcs, orig_srcs, sizeof(srcs)))=0A=
+		return 0;=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_remove - drop an input from a PLL's priority table=
=0A=
+ * @input_idx:	input source in hardware encoding=0A=
+ *=0A=
+ * Rewrites the priority table with the source removed: the remaining=0A=
+ * sources are compacted toward the highest-priority slots and the freed=
=0A=
+ * tail slots are backfilled with the lowest-priority remaining source.=0A=
+ * This makes a disconnected input ineligible for automatic reference=0A=
+ * selection, not just gated at the input buffer.=0A=
+ *=0A=
+ * Removing a source that is absent is what the caller asked for already,=
=0A=
+ * so it succeeds without touching the table.  Removing the last one fills=
=0A=
+ * every slot with the code for the pair this part does not have, which=0A=
+ * leaves the device with nothing to select and no reference to fall back=
=0A=
+ * on -- which is what a request to disconnect the last input means.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ *=0A=
+ * Return: 0 on success, <0 on error=0A=
+ */=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 kept[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 slot, count =3D 0;=0A=
+	bool found =3D false;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		if (sit9531x_prio_src_canon(sitdev, srcs[slot]) =3D=3D input_idx)=0A=
+			found =3D true;=0A=
+		else=0A=
+			kept[count++] =3D srcs[slot];=0A=
+	}=0A=
+=0A=
+	if (!found)=0A=
+		return 0;=0A=
+=0A=
+	if (count =3D=3D 0) {=0A=
+		/*=0A=
+		 * Nothing is left to compact toward, so every slot gets the=0A=
+		 * code that names no reference.  The device is then left=0A=
+		 * with no source to select, which is what disconnecting the=0A=
+		 * last input asks for; lock status follows the loop on its=0A=
+		 * own from there.=0A=
+		 */=0A=
+		memset(kept, SIT9531X_PRIO_SRC_NONE, sizeof(kept));=0A=
+	} else {=0A=
+		/* Backfill freed tail slots with the lowest-priority src */=0A=
+		while (count < SIT9531X_PRIO_MAX_SLOTS) {=0A=
+			kept[count] =3D kept[count - 1];=0A=
+			count++;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, kept);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_input_prio_add - make an input eligible in a PLL's table=0A=
+ * @input_idx:	input source in hardware encoding=0A=
+ *=0A=
+ * Ensures the source appears in the priority table so it can be picked=0A=
+ * by automatic reference selection again after a disconnect.  If the=0A=
+ * source is already listed the table is left untouched; otherwise it=0A=
+ * replaces a duplicate at the tail.  A table that contains only unique=0A=
+ * sources cannot accept a new one without evicting another, so that=0A=
+ * case fails with -ENOSPC.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx)=0A=
+{=0A=
+	u8 srcs[SIT9531X_PRIO_MAX_SLOTS];=0A=
+	u8 seen[SIT9531X_PRIO_NUM_SRC] =3D { 0 };=0A=
+	u8 replace =3D SIT9531X_PRIO_MAX_SLOTS;=0A=
+	u8 slot, src, src_canon;=0A=
+	int rc;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	if (pll_idx >=3D SIT9531X_NUM_PLLS)=0A=
+		return -EINVAL;=0A=
+	input_idx =3D sit9531x_prio_src_canon(sitdev, input_idx);=0A=
+	if (input_idx >=3D SIT9531X_PRIO_NUM_SRC)=0A=
+		return -EINVAL;=0A=
+=0A=
+	rc =3D sit9531x_prio_table_read(sitdev, pll_idx, srcs);=0A=
+	if (rc)=0A=
+		return rc;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++)=0A=
+		if (sit9531x_prio_src_canon(sitdev, srcs[slot]) =3D=3D input_idx)=0A=
+			return 0;=0A=
+=0A=
+	for (slot =3D 0; slot < SIT9531X_PRIO_MAX_SLOTS; slot++) {=0A=
+		src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		src_canon =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (!sit9531x_prio_src_usable(src))=0A=
+			continue;=0A=
+=0A=
+		seen[src_canon]++;=0A=
+	}=0A=
+=0A=
+	/*=0A=
+	 * A slot whose code names no usable source -- a reserved value, or=0A=
+	 * one past the inputs this variant has -- is free space, and taking=0A=
+	 * it costs nothing.  Prefer it over displacing a real reference.=0A=
+	 */=0A=
+	for (slot =3D SIT9531X_PRIO_MAX_SLOTS; slot-- > 0;) {=0A=
+		src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		if (!sit9531x_prio_src_usable(src)) {=0A=
+			replace =3D slot;=0A=
+			break;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	/* Otherwise take the last slot holding a source listed twice. */=0A=
+	for (slot =3D SIT9531X_PRIO_MAX_SLOTS;=0A=
+	     replace =3D=3D SIT9531X_PRIO_MAX_SLOTS && slot-- > 0;) {=0A=
+		src =3D srcs[slot] & SIT9531X_PRIO_NIBBLE_MASK;=0A=
+		src_canon =3D sit9531x_prio_src_canon(sitdev, src);=0A=
+		if (!sit9531x_prio_src_usable(src))=0A=
+			continue;=0A=
+=0A=
+		if (seen[src_canon] > 1) {=0A=
+			replace =3D slot;=0A=
+			break;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if (replace =3D=3D SIT9531X_PRIO_MAX_SLOTS)=0A=
+		return -ENOSPC;=0A=
+=0A=
+	srcs[replace] =3D input_idx;=0A=
+=0A=
+	return sit9531x_prio_table_commit(sitdev, pll_idx, srcs);=0A=
+}=0A=
+=0A=
 /* XO doubler register */=0A=
 #define SIT9531X_REG_XO2_GENERIC		SIT9531X_REG(0x00, 0x2D)=0A=
 #define SIT9531X_XO_DOUBLER_ENB_BIT		7   /* inverted: 0 =3D enabled */=0A=
@@ -673,7 +1193,8 @@ static int sit9531x_chan_state_fetch(struct sit9531x_d=
ev *sitdev, u8 pll_idx)=0A=
 	if (rc)=0A=
 		return rc;=0A=
 =0A=
-	sit9531x_prio_mask_build(sitdev, pll_idx, srcs);=0A=
+	sit9531x_prio_mask_build(sitdev, pll_idx, srcs,=0A=
+				 SIT9531X_PRIO_MAX_SLOTS);=0A=
 =0A=
 	/* STATUS_1_GENERIC reports loss of lock, so invert it. */=0A=
 	chan->active =3D active;=0A=
@@ -893,6 +1414,41 @@ static void sit9531x_dev_ref_states_update(struct sit=
9531x_dev *sitdev)=0A=
 	}=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_ref_pll_mask_rebuild - re-derive the input receiver refcounts=
=0A=
+ *=0A=
+ * ref->pll_mask decides when an input receiver may be powered down, and=
=0A=
+ * the connect and disconnect paths maintain it by hand.  A request that=
=0A=
+ * failed part way through leaves it describing a table the device does=0A=
+ * not hold, and nothing else corrected it: a later disconnect could then=
=0A=
+ * drop the count to zero and gate an input another PLL is still locked=0A=
+ * to.  Re-derive every mask from the tables the poll has just read.  No=
=0A=
+ * extra bus traffic -- sit9531x_chan_state_fetch() refreshed the masks=0A=
+ * this reads immediately before.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void sit9531x_ref_pll_mask_rebuild(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	u8 pll_idx, src, index;=0A=
+=0A=
+	for (index =3D 0; index < sitdev->info->num_inputs; index++)=0A=
+		sitdev->ref[index].pll_mask =3D 0;=0A=
+=0A=
+	for (pll_idx =3D 0; pll_idx < SIT9531X_NUM_PLLS; pll_idx++) {=0A=
+		u16 mask =3D sitdev->chan[pll_idx].prio_mask;=0A=
+=0A=
+		for (src =3D 0; src < SIT9531X_PRIO_NUM_SRC; src++) {=0A=
+			if (!(mask & BIT(src)))=0A=
+				continue;=0A=
+=0A=
+			index =3D sit9531x_hw_src_input(src);=0A=
+			if (index < sitdev->info->num_inputs)=0A=
+				sitdev->ref[index].pll_mask |=3D BIT(pll_idx);=0A=
+		}=0A=
+	}=0A=
+}=0A=
+=0A=
 static void sit9531x_dev_chan_states_update(struct sit9531x_dev *sitdev)=
=0A=
 {=0A=
 	int i, rc;=0A=
@@ -904,6 +1460,8 @@ static void sit9531x_dev_chan_states_update(struct sit=
9531x_dev *sitdev)=0A=
 				 "Failed to get PLL%c state: %d\n",=0A=
 				 'A' + i, rc);=0A=
 	}=0A=
+=0A=
+	sit9531x_ref_pll_mask_rebuild(sitdev);=0A=
 }=0A=
 =0A=
 /*=0A=
@@ -1307,14 +1865,38 @@ static void sit9531x_dpll_pins_unregister(struct si=
t9531x_dpll *sitdpll)=0A=
 	}=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_input_pin_is_registrable - check if an input pin is registrabl=
e=0A=
+ *=0A=
+ * Split out so input-model changes stay local to this helper.=0A=
+ *=0A=
+ * Return: true if the input pin should be registered, false otherwise=0A=
+ */=0A=
+static bool sit9531x_input_pin_is_registrable(struct sit9531x_dev *sitdev,=
=0A=
+					      u8 index)=0A=
+{=0A=
+	if (index >=3D sitdev->info->num_inputs)=0A=
+		return false;=0A=
+=0A=
+	/*=0A=
+	 * The N lane of a differentially-configured pair is not a=0A=
+	 * standalone input and is skipped (zl3073x model).=0A=
+	 */=0A=
+	if (sit9531x_input_is_n(index) &&=0A=
+	    sitdev->ref[index].sig_mode =3D=3D SIT9531X_MODE_DE)=0A=
+		return false;=0A=
+=0A=
+	return true;=0A=
+}=0A=
+=0A=
 /*=0A=
  * sit9531x_dpll_pin_is_registrable - check if a pin should be registered=
=0A=
  * @dir:	pin direction=0A=
  * @index:	pin hardware index=0A=
  *=0A=
- * Only the XO pin has a complete pin-op table in this patch, so only=0A=
- * the XO pin is registrable here.  Other pin classes are registered=0A=
- * once their state callbacks land in the following patches.=0A=
+ * For input pins: delegate to sit9531x_input_pin_is_registrable().=0A=
+ * A pin class whose state callback the tree does not have yet is not=0A=
+ * registrable: the core refuses a pin without one.=0A=
  *=0A=
  * Return: true if pin should be registered, false otherwise=0A=
  */=0A=
@@ -1322,15 +1904,15 @@ static bool sit9531x_dpll_pin_is_registrable(struct=
 sit9531x_dpll *sitdpll,=0A=
 					     enum dpll_pin_direction dir,=0A=
 					     u8 index)=0A=
 {=0A=
-	/*=0A=
-	 * Only the XO pin has a complete pin-op table in this patch.=0A=
-	 * Other pin classes are registered once their state callbacks=0A=
-	 * land in the following patches.=0A=
-	 */=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
 	if (dir !=3D DPLL_PIN_DIRECTION_INPUT)=0A=
 		return false;=0A=
 =0A=
-	return index =3D=3D SIT9531X_MAX_INPUTS;=0A=
+	if (index =3D=3D SIT9531X_MAX_INPUTS)=0A=
+		return true;=0A=
+=0A=
+	return sit9531x_input_pin_is_registrable(sitdev, index);=0A=
 }=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/core.h b/drivers/dpll/sit9531x/core.h=0A=
index 3a12e1c6b330..033e1059bde9 100644=0A=
--- a/drivers/dpll/sit9531x/core.h=0A=
+++ b/drivers/dpll/sit9531x/core.h=0A=
@@ -229,8 +229,18 @@ int sit9531x_update_pll_u8(struct sit9531x_dev *sitdev=
, u8 pll_idx,=0A=
 			   u8 offset, u8 mask, u8 val);=0A=
 =0A=
 /* ---- Input enable/disable ---- */=0A=
+int sit9531x_input_disable(struct sit9531x_dev *sitdev, u8 index);=0A=
+int sit9531x_input_enable(struct sit9531x_dev *sitdev, u8 index);=0A=
 =0A=
 /* ---- Input priority ---- */=0A=
+bool sit9531x_input_prio_present(struct sit9531x_dev *sitdev,=0A=
+				 u8 pll_idx, u8 input_idx);=0A=
+int sit9531x_input_prio_set(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx, u8 prio);=0A=
+int sit9531x_input_prio_remove(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			       u8 input_idx);=0A=
+int sit9531x_input_prio_add(struct sit9531x_dev *sitdev, u8 pll_idx,=0A=
+			    u8 input_idx);=0A=
 =0A=
 /* ---- Output enable/disable (Hi-Z control) ---- */=0A=
 =0A=
diff --git a/drivers/dpll/sit9531x/dpll.c b/drivers/dpll/sit9531x/dpll.c=0A=
index 63c72bba51bf..4437c95f578f 100644=0A=
--- a/drivers/dpll/sit9531x/dpll.c=0A=
+++ b/drivers/dpll/sit9531x/dpll.c=0A=
@@ -286,6 +286,45 @@ const struct dpll_device_ops sit9531x_dpll_device_ops =
=3D {=0A=
  * FIXED role -- XO pin.  Always CONNECTED; it cannot be routed.=0A=
  */=0A=
 =0A=
+/*=0A=
+ * Report a selection-role pin's state on this DPLL.  @pin_id is a logical=
=0A=
+ * input index, SIT9531X_INTSYNC_PIN_ID for the INTSYNC destination.=0A=
+ *=0A=
+ * CONNECTED means the device has selected this pin, not that the loop=0A=
+ * has settled on it: how well it is tracking is what lock status answers,=
=0A=
+ * and a PLL following a reference it has not locked to yet is still=0A=
+ * following that reference and no other.=0A=
+ *=0A=
+ * Membership comes from chan->prio_mask, which is the priority table read=
=0A=
+ * back from the chip -- not a record of what the driver asked for.  The=
=0A=
+ * getter runs on every poll for every input pin of every DPLL, so it take=
s=0A=
+ * the mask the worker refreshed rather than rescanning the table over I2C=
=0A=
+ * each time; table writes refresh it too, so a get right after a set does=
=0A=
+ * not report the old membership.=0A=
+ *=0A=
+ * Caller must hold sitdev->multiop_lock.=0A=
+ */=0A=
+static void=0A=
+sit9531x_dpll_selection_state_get(struct sit9531x_dev *sitdev,=0A=
+				  const struct sit9531x_dpll *sitdpll,=0A=
+				  u8 pin_id, enum dpll_pin_state *state)=0A=
+{=0A=
+	const struct sit9531x_chan *chan;=0A=
+	bool active_input;=0A=
+=0A=
+	lockdep_assert_held(&sitdev->multiop_lock);=0A=
+=0A=
+	chan =3D sit9531x_chan_state_get(sitdev, sitdpll->id);=0A=
+	active_input =3D !chan->mode && chan->selected_ref =3D=3D pin_id;=0A=
+=0A=
+	if (!(chan->prio_mask & BIT(sit9531x_input_hw_src(pin_id))))=0A=
+		*state =3D DPLL_PIN_STATE_DISCONNECTED;=0A=
+	else if (active_input)=0A=
+		*state =3D DPLL_PIN_STATE_CONNECTED;=0A=
+	else=0A=
+		*state =3D DPLL_PIN_STATE_SELECTABLE;=0A=
+}=0A=
+=0A=
 static int=0A=
 sit9531x_dpll_input_pin_direction_get(const struct dpll_pin *pin,=0A=
 				      void *pin_priv,=0A=
@@ -298,8 +337,162 @@ sit9531x_dpll_input_pin_direction_get(const struct dp=
ll_pin *pin,=0A=
 	return 0;=0A=
 }=0A=
 =0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_state_on_dpll_get - get input pin DPLL state=0A=
+ *=0A=
+ * Selection role; see the pin-state contract above.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_state_on_dpll_get(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv,=0A=
+					  enum dpll_pin_state *state,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+	sit9531x_dpll_selection_state_get(sitdev, sitdpll, dpin->id, state);=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_dpll_input_pin_state_on_dpll_set - set input pin DPLL state=0A=
+ *=0A=
+ * Enables or disables the physical input receiver via Page 0x02=0A=
+ * force/state registers (sit9531x_input_disable/enable()) and updates=0A=
+ * this DPLL's Page 1 priority table so the state is honoured by the=0A=
+ * PLL's automatic reference selection, not just at the input buffer.=0A=
+ * Selection role; see the pin-state contract above for the states.=0A=
+ *=0A=
+ * The priority table is per PLL, so it is always updated for this DPLL.=
=0A=
+ * A single physical input feeds every DPLL, so the hardware receiver is=
=0A=
+ * only cut off once the last DPLL has released it: ref->pll_mask tracks=
=0A=
+ * which DPLLs currently claim the input, and the physical disable=0A=
+ * happens on the transition to an empty mask.=0A=
+ */=0A=
+static int=0A=
+sit9531x_dpll_input_pin_state_on_dpll_set(const struct dpll_pin *pin,=0A=
+					  void *pin_priv,=0A=
+					  const struct dpll_device *dpll,=0A=
+					  void *dpll_priv,=0A=
+					  enum dpll_pin_state state,=0A=
+					  struct netlink_ext_ack *extack)=0A=
+{=0A=
+	struct sit9531x_dpll_pin *dpin =3D pin_priv;=0A=
+	struct sit9531x_dpll *sitdpll =3D dpll_priv;=0A=
+	struct sit9531x_dev *sitdev =3D sitdpll->dev;=0A=
+	struct sit9531x_ref *ref =3D &sitdev->ref[dpin->id];=0A=
+	u8 hw_src =3D sit9531x_input_hw_src(dpin->id);=0A=
+	u8 pll_bit =3D BIT(sitdpll->id);=0A=
+	bool enabled_here =3D false;=0A=
+	int rc;=0A=
+=0A=
+	mutex_lock(&sitdev->multiop_lock);=0A=
+=0A=
+	switch (state) {=0A=
+	case DPLL_PIN_STATE_DISCONNECTED:=0A=
+		rc =3D sit9531x_input_prio_remove(sitdev, sitdpll->id, hw_src);=0A=
+		/*=0A=
+		 * The table write, the latch and the holdover release are=0A=
+		 * three steps behind one return code, so ask the table what=0A=
+		 * actually happened rather than reading the errno as "no=0A=
+		 * change".  A source that is gone from the table has been=0A=
+		 * released whatever else failed.=0A=
+		 */=0A=
+		if (rc && sit9531x_input_prio_present(sitdev, sitdpll->id,=0A=
+						      hw_src))=0A=
+			break;=0A=
+		ref->pll_mask &=3D ~pll_bit;=0A=
+		/*=0A=
+		 * The receiver is shared, so the last DPLL to let go turns it=0A=
+		 * off.  That has to happen even when the table rewrite=0A=
+		 * reported an error, or the input stays powered with nothing=0A=
+		 * tracking it; the first error is the one returned.=0A=
+		 */=0A=
+		if (!ref->pll_mask) {=0A=
+			int off_rc =3D sit9531x_input_disable(sitdev, dpin->id);=0A=
+=0A=
+			if (off_rc && !rc)=0A=
+				rc =3D off_rc;=0A=
+		}=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_CONNECTED:=0A=
+		/*=0A=
+		 * CONNECTED asks for this input and no other, which the=0A=
+		 * device cannot be told to do: it selects by priority and the=0A=
+		 * manual-active-select path is not wired up (see mode_set()).=0A=
+		 * Refuse instead of quietly behaving like SELECTABLE.=0A=
+		 */=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Device selects its reference by priority; use selectable");=0A=
+		rc =3D -EOPNOTSUPP;=0A=
+		break;=0A=
+	case DPLL_PIN_STATE_SELECTABLE:=0A=
+		/*=0A=
+		 * Gate the receiver on whenever it is off, not only when this=0A=
+		 * DPLL holds no claim yet.  The two are tracked separately --=0A=
+		 * the claim comes from the priority table, the receiver from=0A=
+		 * the force bits -- so a PLL that already lists the input can=0A=
+		 * still find it powered down, and skipping the enable would=0A=
+		 * report success for a reference that cannot reach the loop.=0A=
+		 */=0A=
+		if (!ref->enabled) {=0A=
+			rc =3D sit9531x_input_enable(sitdev, dpin->id);=0A=
+			if (rc)=0A=
+				break;=0A=
+			enabled_here =3D true;=0A=
+		}=0A=
+		rc =3D sit9531x_input_prio_add(sitdev, sitdpll->id, hw_src);=0A=
+		if (rc && !sit9531x_input_prio_present(sitdev, sitdpll->id,=0A=
+						       hw_src)) {=0A=
+			/*=0A=
+			 * Undo only what this request did.  A receiver the=0A=
+			 * loaded configuration had already turned on is not=0A=
+			 * this request's to turn off.=0A=
+			 */=0A=
+			if (enabled_here)=0A=
+				sit9531x_input_disable(sitdev, dpin->id);=0A=
+			break;=0A=
+		}=0A=
+		/*=0A=
+		 * Claim the input for this DPLL only once it is both enabled=0A=
+		 * and present in the priority table.  Setting the mask before=0A=
+		 * prio_add would leak the claim if prio_add failed, keeping the=0A=
+		 * shared input receiver powered even after every DPLL released=0A=
+		 * it.=0A=
+		 */=0A=
+		ref->pll_mask |=3D pll_bit;=0A=
+		break;=0A=
+	default:=0A=
+		rc =3D -EINVAL;=0A=
+		break;=0A=
+	}=0A=
+=0A=
+	mutex_unlock(&sitdev->multiop_lock);=0A=
+=0A=
+	/*=0A=
+	 * Leave the messages the switch already set in place; only a failure=0A=
+	 * that came from the hardware path still needs one.=0A=
+	 */=0A=
+	if (rc =3D=3D -ENOSPC)=0A=
+		NL_SET_ERR_MSG(extack,=0A=
+			       "Priority table is full of unique sources on this PLL");=0A=
+	else if (rc && rc !=3D -EOPNOTSUPP && rc !=3D -EINVAL)=0A=
+		NL_SET_ERR_MSG(extack, "Failed to set input pin state");=0A=
+=0A=
+	return rc;=0A=
+}=0A=
+=0A=
 static const struct dpll_pin_ops sit9531x_dpll_input_pin_ops =3D {=0A=
 	.direction_get		=3D sit9531x_dpll_input_pin_direction_get,=0A=
+	.state_on_dpll_get	=3D sit9531x_dpll_input_pin_state_on_dpll_get,=0A=
+	.state_on_dpll_set	=3D sit9531x_dpll_input_pin_state_on_dpll_set,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/drivers/dpll/sit9531x/regs.h b/drivers/dpll/sit9531x/regs.h=0A=
index 60495b6e0bd5..4d8eb3ceac9f 100644=0A=
--- a/drivers/dpll/sit9531x/regs.h=0A=
+++ b/drivers/dpll/sit9531x/regs.h=0A=
@@ -126,6 +126,10 @@=0A=
 #define SIT9531X_REG_GLOBAL_UPDATE		SIT9531X_REG(0x00, 0x0F)=0A=
 #define SIT9531X_SMALL_UPDATE_CMD		0x02=0A=
 =0A=
+/* PLL holdover control (PLL page offset) */=0A=
+#define SIT9531X_PLL_REG_HO_CTRL		0x6F=0A=
+#define SIT9531X_PLL_HO_FORCE_BIT		4=0A=
+=0A=
 /* One bit per input PAIR (bit 0 =3D CLKIN0, ..., bit 3 =3D CLKIN3) */=0A=
 #define SIT9531X_REG_IN_DE_FORCE		SIT9531X_REG(0x02, 0xE8)=0A=
 #define SIT9531X_REG_IN_DE_STATE		SIT9531X_REG(0x02, 0xE9)=0A=
-- =0A=
2.43.0=0A=
=0A=
