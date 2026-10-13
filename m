Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CE56260F;
	Tue, 13 Oct 2026 22:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791931019; cv=fail; b=CDNHCTUYN9rcZI6VMF0Ji6c8DO/n0tsOCth6WNwqFtp3BFB8nR2WMiLSAkh54352TJRe2uvMKj+LxDysMon+CXEXp554sPaWQuTF+qpB7kOU8AlwEsErfzqU55OvCvNE0e+wPfHggQMi103HH4FnSMtcfBIaqG7gsXsKEXU7p50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791931019; c=relaxed/simple;
	bh=c6fVrgEDZd9hlICqaMI9Cyu2S/inCIsBMJUjPX1Coug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dKTYNQ+33X7uFpAqIApLYv38kdAnTVgw4vDppeGqH+qpuoLI/aKB5CICLJaC/n8SThSUSnvFvpR5TRVTAVHrXAtO7vJVaTi/X1VdKNBX/Q6imCVQ85k4zOUAarIVGw5/p9ui4f5VbW7ZZb7gsW4dTErjHNg9kIJR6tlmaOhYbMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=GTDpfe/S; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=jRiuFyQh; arc=fail smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="GTDpfe/S";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="jRiuFyQh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=O5DAEj2M2OCQprwgxxNavDmzdkaDbHfAaWsMBufyg/I=;
 b=GTDpfe/Sgic6DmucT3MNm43Fj08dpXtWAaMvAFFMpYU7/FgKcNkKZLAbArq+C70rAI6xGNK4QogOhEmg4huVchT0yhqhLQIPgp93i8UfprIJjegQJXbttxYE5RnR1YhasRw+Zk41WHWHcitxCs2+BHAcMXk/lFQfFW5gRL6hDnnID5LCQCie9NSWpAVmkkQ9ql8S9oUSoqRh7owQBEn8ivno+QNPLAnnsy/iiBpYxbNNQ1KwSi+NPZUTeYajUogYxnMqyAoMLM4Uopl+VPXxVq8xnX+LKqCm/GRgYeCurBk7LxAwUX587klDcmwdXQUoY+czg6FZAH/pedaJ7N/OCg==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020079.outbound.protection.outlook.com [52.101.56.79])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8463998006F;
	Tue, 13 Oct 2026 22:36:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELb9GVnB81xTjvPCqQCulNFH8gyg6ciw7gg2sHfBQI6JUsqYErNZpv25lWsBJmliMBeGFLH1eg7QZDeoHYPjhH0fHZkzd2CETM37CdZA3NRcIX/wDj7mWBFc2MnweE3CPAbfnRh9YSI5YcFjze2afSW7elK0YUF1hi/VQjWYAGog2m109goidqME8lSI3N2gSreYC02O+9ZW7ubibJR/Pr9XyWnVeL8mwmPwvwv5yM1fhO7be8DLquPdK9sgkrb7sz0GdYu+yfobiXcV0gG8t6B/lAW1TwXMb9sApHTnPnP1RQKLolwRs9P3aW4th5/3d8Jui+3PkUS4zfAecdB/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5DAEj2M2OCQprwgxxNavDmzdkaDbHfAaWsMBufyg/I=;
 b=gYOGnIeAiKi5vxtvQhmTVA5igwIWTe6gqNSSuwu/xR0IGkI2naprdqgKNtfly2pUImhR43YZxaqRcveu3RzVkarAJdEEUdDBGGob4dXItPLr0SYCznr0N32h/LQk1wnUhuvmwDVLv2HoDbsZus3LuGJci/BDAzF5d+PuPlhOHo2QA5DaNckK9lDce2DA2USaz/x3RTlDLQy2UIC5Wk4SL5WkQzTEl9QMdGxnlbH3sUXfbXnuiDc9OsGKe4Irfpo/O3xQPCFZFgKbfshmF9YPbW79bb4Pr0B6bfQp+GOmK4DA81uws9PIlmPKb1WJFhOOSWgZ5fN7CHmq7X+b2pK30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5DAEj2M2OCQprwgxxNavDmzdkaDbHfAaWsMBufyg/I=;
 b=jRiuFyQhs8qeqXPLJyE9igyJQdBsPlxnaf07Dmb3eCipEf7mioGAgHhzryRoUraqGfYU9fEmvD12sg/Tr2ntIXpHVQ3qN9j2FIRkjWc+G64pn0W+DCMydWX3xaRiqV/NAKm1NmVy60ft+SC3Lat7CXRw0n5AQotD0yYP1jInSYwlEVZLw8rc2LwYCuzcsqlFz2cOyGAE/RrrHumqDbDtCTxd9aiWUupTe4wSkl07ZIm33TyBDyLz3KvKwtxKpifMeQTbeBv6rh7RG/MxHXaSMEKEawyxMbetNyS8/5/T5PN9XDk/z0NPNuRRr7KruaaAi7SyB36OuaecwWkNzGowFw==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by SA1PR20MB596672.namprd20.prod.outlook.com
 (2603:10b6:806:3be::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 22:36:43 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 22:36:43 +0000
From: Ali Rouhi <arouhi@sitime.com>
To: "ivecera@redhat.com" <ivecera@redhat.com>
CC: Jiri Pirko <jiri@resnulli.us>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Arkadiusz Kubalewski
	<arkadiusz.kubalewski@intel.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v12 08/12] dpll: sit9531x: add support to get and
 set frequency on pins
Thread-Topic: [PATCH net-next v12 08/12] dpll: sit9531x: add support to get
 and set frequency on pins
Thread-Index: AQHdWBx3uzXzPneuTU+peExtFWrEKrb7PlkAgADYDYA=
Date: Tue, 13 Oct 2026 22:36:43 +0000
Message-ID: <20261013223641.25560-2-arouhi@sitime.com>
References: <20261009183151.78497-1-arouhi@sitime.com>
 <20261009183151.78497-9-arouhi@sitime.com>
 <0051c3dd-6abd-4ff1-a125-7cace9fac6fb@redhat.com>
In-Reply-To: <0051c3dd-6abd-4ff1-a125-7cace9fac6fb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|SA1PR20MB596672:EE_
x-ms-office365-filtering-correlation-id: ae589443-2ca5-467b-33c6-08df297a7517
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|5023799004|38070700021|56012099006|18002099003|22082099003|6133799003|261009221727099003|261009220027099003|261009221227099003|261009223327099003|3023799007|261009223027099003|10067099003;
x-microsoft-antispam-message-info:
 YK3S809HXWiAUiXjEnJPTDlcxuXvo5BoMdyc8KYZGcymWEzE6iFkDa/IrIZx+rvHQoW2Ui6eMO4dNPjUtdtRywtU5cIzfrQN8dFGeBvHSYthPDEqQGLK3opEZYayDKLH97GNP60MUIPKREV8wZkK7csGhXRnUCA8uHsnK+R/8mNa6+Y2/0mJYqNflVI2gFZ0RE1j5pyIbjyMkMMnzwCsddFk3SwEhNGDcHRV+4UtKYsxi4F7zdi3UkVN83K6hJCOlJ1bHniCczS+WRAr+SUnEf3z/rfknBsGMnuy5/u/IWPcZ5189oufQSGL2gSagcvBORYXmsjMSkd3mx8obODKbEwNBcNA+SKUxCfr2tIY+OboknpjqbFDE6Lu8cBF8Ac5zv9mawGdjO0wSMbzB7wqioYKa66YON7sF+pm1yk7XY9M+LXiE7CAOhvuv/AGVlLvbvaD/WqV7o01aw6FYAN7H4hj2Zx378bgTAn+whI3bpspMYleTg5tEn9ms1AKRrt/J+mTZa+wBG+Y0gRARdAJpoo6oTPxgYAgxsHK2vQybJTQujRDYSbgFbWbRvjHTQARUe1pqjU3oPl7t2ylYZmxRDVSEG2USpAVpAOeFU9NcEXBv1bOjoju6YrAoZy1aBkw4PL+htLuwh7PvJoFeFVu0NI9PTnEnoCWG61KOMqCZsy4KwgVpavPxtkILSzd6uzXnG2XG1sM4vXx6V5LAaly8aUBxIFgPbmYUSXTyusMlX8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(5023799004)(38070700021)(56012099006)(18002099003)(22082099003)(6133799003)(261009221727099003)(261009220027099003)(261009221227099003)(261009223327099003)(3023799007)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Gcrf7IA2MZ0x63Dgx8cTYGhKconitDx3HwBg2LOL00wX/Y/ZEFeJzpGBdd?=
 =?iso-8859-1?Q?WR/BgE0IF2PoiJOmh9TGGBfeCduXPgmBdLepBD4nPL5d8iwjnSmJRmwCtT?=
 =?iso-8859-1?Q?PSaGOD6b2B7qHSKfsyY9KkyNxsTbBS8ZgqXaPo5M6l0GPVZ0ky/sOQIUSA?=
 =?iso-8859-1?Q?YpggMHZzW4kxLfRDD9z4IyxM3UiwJNLQQJCegGj7Ki4wPdaie4GYFl15O3?=
 =?iso-8859-1?Q?NpzQEkFTe7Z9qJR8MF7rw7jUdA838ltY61NkLqI2rUDKrN/O1r6dBARhK8?=
 =?iso-8859-1?Q?bqiBwaZmm/UuVlRz50CANNcoVol2qNEH73UYKrd48C4f/JFwoKGN/FEfOH?=
 =?iso-8859-1?Q?lhfNZa6augUgri7R5jUiBdYR8uVWsE4OsKd+AlA9DmRMbXrvyPstmPMti1?=
 =?iso-8859-1?Q?S2vblQF9F/GXunlaNwGibARWk/Y1QgzQPdiu0IPLGaRz/BpNm6IesqFfk4?=
 =?iso-8859-1?Q?lbyt4Z9YNexzq6ma0C+sAzZeU47mwohSUuC7+/g26OctGeE3pW6ta7A6fT?=
 =?iso-8859-1?Q?RBf5J1pSa+tpJOqUzOITBfjK26hPET7FE96fbiqRsoUpNNI7TB3ZFux6aj?=
 =?iso-8859-1?Q?4BWoFnj1cG4HANxvYViTRKIVZHHRCaGgNsFJyu8Dn3bx28pO1d6RjQ7+Lk?=
 =?iso-8859-1?Q?A1pc1c0tcHMRZraqu71qQy/+2Pk1gEAbYg/g5P2hvtBUzkO6VCyszYAL0q?=
 =?iso-8859-1?Q?CCPQf2lGpA7NwF81x4MXRyIO4tgOBVyaYp6k5qKrUtbBx1Zk3awWxrArc8?=
 =?iso-8859-1?Q?NjOpDhymKx11b9tfT37cCchufWJPqVHA6LLweqhuzw80syuSOMhkmqbnqD?=
 =?iso-8859-1?Q?zJKxEv1H6VO7BcqsKdowDIKc26qUledlgHG1W8/JBpwGeC1rnx9uRGfygv?=
 =?iso-8859-1?Q?52UxNTaf2+IWTlN/xx7AczZ9IfmgrBTQM3LXx0tOvl0vf7s3xJU0WgZtP2?=
 =?iso-8859-1?Q?/LJAnAXyK0WGmxvsBY4iPKqiXNQxfEYp+rpB5qVwoWubUbCLDW/LHF/9C8?=
 =?iso-8859-1?Q?qI6M4GTSgzpiWG9wrMG4Sq1z4sLFSLDG5MOXgqGZb2dxB9nXAoygKRCqZr?=
 =?iso-8859-1?Q?olaVnBsfp1yd1xqjoO+r5pjW4/aO3OZKTnSEaqrFqpLG9TALFVtWD7kCak?=
 =?iso-8859-1?Q?tXhymJnYgDqc4UAzRIkSm9gU3NL48n47j3YEU6Lj/fNdL2CGySJkjyxEVl?=
 =?iso-8859-1?Q?zQ7IPfIS2aUKDyveisvl/PreIvEqT0lfby7Jiludp1BmmhbiLDtlbCIbnb?=
 =?iso-8859-1?Q?JVU7ya3psPOp3aq3ntBdhQHY0keN7JmliQu90dQESHtcnMoomQ6tSdp9hX?=
 =?iso-8859-1?Q?X7HCO2d2+Xb42zF+GY8FOcvVgXnwOjNkIM+1Kjf69ds0Q3qZzaSdr2djP+?=
 =?iso-8859-1?Q?L6JNuILSliF/khfrtT6hA6kawvcw6T9j8ev5dO1FG381pQFYq4ebYsXmx3?=
 =?iso-8859-1?Q?R+Qn8TG9KCF1zF0hXlRSCh0BozEH9ZR8wDfbYbnEqLCJNGWWe0wdDYtHXn?=
 =?iso-8859-1?Q?0SyTVd061pcDC5zG3ci6DUX+bocEHd1oBuJrgpaBVnK08pYwIwD+CNeja0?=
 =?iso-8859-1?Q?xBBTcrDk75kPLiiSjQTumB0ml80s4I0JGC3iP/ALYtYo95A5Uxb1FdZ4c/?=
 =?iso-8859-1?Q?2JF9cHblEUWJ+D+Dkm1wtVuQak2RhtImw9QUCfDZpxGNOzFYsbyeTESZ8f?=
 =?iso-8859-1?Q?LxRKY17tA7OVsfxSQym7IY1f5dvVPUGPuzdkd82jhgYTs8skFSL2on6AwP?=
 =?iso-8859-1?Q?0GvkyUUlx+2gS1UhAchp3ostj+FMZH5em+4i8nP7zkzLqH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	I2qDwFkofi6mPPhyIPF/r204KB3BLilMXvVYwKHNQr9MqWvANhga4Igb01Q4PScyECWpUR1HvT4uMp51Bp+zni7GnwUWLgYHqtRa4Y4o966UBl3c/Li1EO7qwmChYb9qUmSn/I2/d+VEZp9YziLI82CWIPLmV97nYSDbZuaeTVacxl5YzrfdezFW5ldpvfhY8LzSRIF2UX+qyoWgGyNio7mWXrWQJPevlZT34PTRTMP4cU0sfl1k0RkJzKWDSVxXvEpzALcFtZmVFXjERgpVLjXRHBSvXUsCPJTq1Zv6ZP8Pg4g0KXiQoZVCoF1QMhVnacc+CgFyyD4hgxpEeGv+PA==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae589443-2ca5-467b-33c6-08df297a7517
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 22:36:43.6127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9i0tJPxO/WPHbxitibkYQmnuKcn03oWCWqZLZTEmqjeWhvCYs9f+VkU9s4cUXFiUjLJgVDSeAX+F0oWL7WShZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB596672
X-MDID: 1791931009-k-UPO7yMgXS4
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;at1;1791931009;k-UPO7yMgXS4;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
X-PPE-TRUSTED: V=1;DIR=OUT;

On Tue, 13 Oct 2026, Ivan Vecera wrote:=0A=
=0A=
> > +       /*=0A=
> > +        * An output's current rate is the one its divider produces, so=
 read=0A=
> > +        * it rather than assume the first entry of a list of the rates=
 the=0A=
> > +        * board supports is the one in force.  A rate taken from firmw=
are=0A=
> > +        * that the part is not running would be reported as current an=
d,=0A=
> > +        * worse, used as the output period the phase adjust quantizes=
=0A=
> > +        * against.  An output the configuration does not route has no =
rate=0A=
> > +        * to read, which is not an error.=0A=
> > +        */=0A=
> > +       if (dir =3D=3D DPLL_PIN_DIRECTION_OUTPUT &&=0A=
> > +           index < sitdev->info->num_outputs) {=0A=
> > +               u64 hw_freq;=0A=
> > +=0A=
> > +               mutex_lock(&sitdev->multiop_lock);=0A=
> > +               rc =3D sit9531x_output_freq_get(sitdev, index, &hw_freq=
);=0A=
> > +               mutex_unlock(&sitdev->multiop_lock);=0A=
> > +               if (!rc)=0A=
> > +                       curr_freq =3D hw_freq;=0A=
> > +       }=0A=
> > +=0A=
> >   skip_fwnode_props:=0A=
>=0A=
> This read-back sits before the skip_fwnode_props label, so an output with=
=0A=
> no firmware node, or with a node that has no supported-frequencies-hz.=0A=
>=0A=
> For such an output curr_freq stays at the zero-initialized=0A=
> sitdev->out[index].freq, so the current rate is neither cached nor listed=
=0A=
> ahead of the 1 Hz to 1 GHz fallback range.  Was the read-back meant to=0A=
> cover outputs without a firmware frequency list as well?=0A=
=0A=
Yes, it was meant for every output. An output the board describes=0A=
without a rate list, or does not describe at all, still runs at=0A=
whatever its divider produces, and that is the rate to publish. Sitting=0A=
before the label it was skipped for exactly those outputs.=0A=
=0A=
In v13 the read-back sits past the label, so each output publishes the=0A=
rate its divider produces ahead of the fallback range. The two INTSYNC=0A=
early returns move above it, since neither of those pins carries a=0A=
frequency attribute and neither has a divider to read. The comment=0A=
above the read-back says this rather than the old sentence about a=0A=
routed output, which was describing the restriction rather than the=0A=
intent.=0A=
=0A=
Thanks,=0A=
Ali=0A=
