Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC24AA020;
	Wed, 30 Sep 2026 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.129.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811444; cv=fail; b=or/MHhAgyhV5uJxZvELD2msVNjtE2687qrumuPSOG2vjlrg6xpWamo0t8TMugHs7VYoDSdNq04+6Mt8libvNLizOUws/iNx2OovVSmKSRkpzsCEX4ibc4uKUiy3WA5hh6sTvKJhhx/jNbBXV/Z4Dt+SxjRRjaVZZK5x7gYDys5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811444; c=relaxed/simple;
	bh=6BlZbhRiVCixNou/8YwrCfmBbpNaVszt/8stZV7cYmY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IFGlgaukA6FFUtAu+COncemI6fd35nho3yGu5ujkTVZt0GedvIJUgfBYgbBiwSjbYhvtCOuZZdSadsRein3kvhjZnFKHRYyrVdkeDKAvT2wE0SrfBjF9l9Gc+WbHBWa+r+iqVYds5keXNa2WdOUYHfFn9/vetJ2gHF3y+PE5Osk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com; spf=pass smtp.mailfrom=sitime.com; dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b=c8M0kI9x; dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b=EI0L23bt; arc=fail smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sitime.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sitime.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sitime.com header.i=@sitime.com header.b="c8M0kI9x";
	dkim=pass (2048-bit key) header.d=Sitime.onmicrosoft.com header.i=@Sitime.onmicrosoft.com header.b="EI0L23bt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sitime.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=mail; bh=JlllOoRUz5SDf+zBU1pG/3OR3MU5cWGkKd62Cd+HO2Y=;
 b=c8M0kI9xaxFES/Ht0oXX2f+Hs24xLkb8HuYlUJ5GVl5td09Sq2lCZDTY0KGrKlPCaS06i5dk6v2ao6L4WO51B23c7u5Wc6oIhsIeWc0KTDj9IOembfF+E9FOKhpHNuyT9EJn/XsvRoYBxUI8ChdIkAoOfRm6WJp0bOPQUrWHGbAePYdljbQZxBRyTQX+wat5/JwWGzXyEJ9LZx1YY1FqIhKqYIDqYX5VMiZe3wrY/IZg5dW0tOocX/LsVlEmfZKp1U6G20sS2gCtn5aYtN+Cv9LCzEF78/j0A4MGhNfK84L6Qhqiyz/quOOAoTZkwfv6RuRtVrtCy9/Vy7h8yuPflQ==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020134.outbound.protection.outlook.com [52.101.56.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 4676E100061;
	Wed, 30 Sep 2026 23:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkXD0PsY8YWvPACmzU7rmeVSl/gpCALtZsN9uqoxtUeJ1K9hff0fB+UOzYcFmcHR83/ZmqkdQKijF9rc0zvRh2+SQ64zssU/q7ACe/ip1W108WLxi1JmU9jBVRrLwkl6acVcVdw+x5sozejXepC1fMCdKql0DpPHM7zZgASwdm2RoegEX+lfn/KSXFbvPAERI4PMZwQVN1kLgILdQL8xDl9GE+h2ttQ0a9rXO4kCbRGk35PE05nbbmWrO8iahonLj8BCdZruI2yn09wO+RjIE1aGGf+8DL1q/uTl8KFF9MZgQ8LHuPjKM1hbn4F9PTCNJEG+xO+z6yY6ZJQ3S9J86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlllOoRUz5SDf+zBU1pG/3OR3MU5cWGkKd62Cd+HO2Y=;
 b=gZAw58z4wpwqEQsJSVtn4UsUpbfHtnQFuvtDSrYhiYaMlMdyhZF9AeqI/XeletRIgxVAUyY5bKXTiENlG0g7m4+8VQCEGsACTycdh1AUfF+G29g7NWV10Spl/htT7t1fF/m+NIVy8BXfKvY4h7/iyAeoI9b4DcXD1OdWi7mi8HL42kP2l/9fIahLqGDa4utQVRdQRIJhTkNGcJk5UaADCRbIGpwD4Kj0fDB856eL357ao0c8w3qk4SNz1liGhVcgISrUXosijPHchxCzHvDsDlsXBhgGxdkid6t3hrgP+Fvv0ft8YG4F085sl4i/a0gVXQPhDleyuUcbV+OAxoBPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sitime.com; dmarc=pass action=none header.from=sitime.com;
 dkim=pass header.d=sitime.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Sitime.onmicrosoft.com; s=selector1-Sitime-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlllOoRUz5SDf+zBU1pG/3OR3MU5cWGkKd62Cd+HO2Y=;
 b=EI0L23btLOgoV9y9rHJYp19MZ3mavnO/Ip6tmCToXV4hIo+GTE/Ju8gSh3bTJwCPIn43jiwljaDmvQ4qukcCujBnPOlQOqZXZhSSYNQ5kofuRylNClHRKCZt/764Rn8rWq+8j22xBT3gL28brqxzhpyg8+ZABKquQ6weMiqx/xjjRfHeVGgyskiZLHP/hA8q6NeaM/DX7nV2CW8CjUJiExZtk+v+B3T3SyLvf9OcHly3pDk/rOvTzXNstTYLZVMPMkB/cNXYmnHp4YbKXTpKRREO4hjJorItvdasdORV06Hpmd0qG8ZR+cb8Vy+MmIwUGOkN5PTekjG3xsq8AexpzQ==
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 (2603:10b6:408:3bf::16) by BL3PR20MB6748.namprd20.prod.outlook.com
 (2603:10b6:208:3bf::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:37:18 +0000
Received: from LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01]) by LVWPR20MB994915.namprd20.prod.outlook.com
 ([fe80::9551:3864:128b:8c01%4]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 23:37:18 +0000
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
Subject: [PATCH net-next v11 04/13] dpll: add basic SiTime SiT9531x support
Thread-Topic: [PATCH net-next v11 04/13] dpll: add basic SiTime SiT9531x
 support
Thread-Index: AQHdUTShebuE2pn/x0mY8/vS78K0/g==
Date: Wed, 30 Sep 2026 23:37:18 +0000
Message-ID: <20260930233714.87679-5-arouhi@sitime.com>
References: <20260930233714.87679-1-arouhi@sitime.com>
In-Reply-To: <20260930233714.87679-1-arouhi@sitime.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sitime.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVWPR20MB994915:EE_|BL3PR20MB6748:EE_
x-ms-office365-filtering-correlation-id: 223ce7a6-565e-4dbe-f8d5-08df1f4bc40b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|38070700021|3023799007|6133799003|10067099003|56012099006|5023799004;
x-microsoft-antispam-message-info:
 s13hF/xwyWYZEq5QXDy8fUMzaXCTonOqew2QH4JwcGiUD6qeSQK1JSbsMGU5W8r1m3Q4NJfbUY2fRfMaLiJNKo0Z66Y+9CjPZxmrtVPV0jL7nfYEYQen39u44fADAAcZLFnZdA0K4h8AgBr0weWlCCnhEIgiq7jCuqZOW7ePdGreX+sMb3rx7QohT+9pRAFs7199y0xb/a0kUKH4/oNivnwaVqUBKZP8q4HR+1j/PLt0PkeC6cvySnbo4I2ltytsjS1WBrOgiFLj74Pi+fDTr6XEMA8blntgMflNVxArWPtU1Q5wSZlTRIizDmvbfNGpFurctJ0BRRmAGkLAFBjmmPcUnAfT+Ism4lIKN+7CJYkgNZ2oXOWha6slfN8AWrugI21jbhHbSnkyuY6+8+O+l91MS7vB8rmWlOw8Wp86ypqtkDxKcE88DC6eJbeypu904onozGiagLHigyixRNX8zaJUHLybXKGpFegPpKtXmtAdzB6JOHH+Qeb+9q42VIRyxG2Um9M5aEPZOI/niVUfwV/SzuE/LyKvf+co5jql8EXRCTIWjWG6bGJ51b+t+nC2kjXo1ajoz8DY/kYFysL/L4GIw7tUMiSay5XlsMsqu8aDUxZMJzgDnqY3TQukAaRr+U1Lobpp6FpksfGrCSqXBh04mspQoQmYlk2sMBY4GcBARmORIgLYTEh5BRnICjwOESgU3cZp1zsRfhEI08nVPGjQH8xOsqHGoY9q9qYCYo0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LVWPR20MB994915.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(3023799007)(6133799003)(10067099003)(56012099006)(5023799004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7hiZbUbhxQX+hP0Wyz4C5qtW4GQWRBdSlMZxoI1D4k3IO+ZaJZ1WfagUDN?=
 =?iso-8859-1?Q?R6INFUmLjtqXUjRocU8w1NT3N/NuY2uEVzWaOTkx8mYA8DRNnX1xd8+E1o?=
 =?iso-8859-1?Q?ez4eeS0RXF1OmgdfH1zd5LYLPuSBiFpElMnY97jytUTscUlVuKgErdXEJ5?=
 =?iso-8859-1?Q?oUvju/U1NU7m9UcrqivP61/LpZUwjxQFY6XK56dOEvqV50v4E+x887IhUr?=
 =?iso-8859-1?Q?qJkm66Jj9UeBnIzwgfz8NeS/7V4KZ7xw1QBY3OMAH2OvRTFNnj1BA7UzcY?=
 =?iso-8859-1?Q?SAP0vihA+tD8OlKFhavJNkbXw12d2Q7lgDD+FpY9BLAvkYcVlMONZm3YGf?=
 =?iso-8859-1?Q?9to2fpXX7orBi3dnYmCYQ4t/KrNOasLJLj/A12a7qJR9C1L2gz+q1kSOyE?=
 =?iso-8859-1?Q?5dt7A8qjeoalqSZQUMN75yWNaH9NuyXQ0CyoPmOpfYQgyksMFuowfkx0Oa?=
 =?iso-8859-1?Q?jsYN5ADcbqLWg1JU71c0Bwbt+RdI5j9SgpAW8aRe7KgkWgSYx0h8Wu1K90?=
 =?iso-8859-1?Q?mKAiYDNO12WNSLqpAstYexG5k1Aop1/PKjI0tpgt/0PNVvopbMfbaQB7jw?=
 =?iso-8859-1?Q?2YDX+TdjkhT2T5Lm3TRJgBL/AU3SuCYWHhisEIA/2tXO0CbhXUz3fxVO86?=
 =?iso-8859-1?Q?ZDLnbr8Jl5ovasAYYr4VRu+XAZ4bQgfpzR7cbXplLhsKTAT3PPRuoAmZmd?=
 =?iso-8859-1?Q?vHRWE62m4mD3c6UwbM47+ucNiwhnTbSZp72YQKdoZZHqO+vjFOOXwEcOND?=
 =?iso-8859-1?Q?t5smDiBK0ElyrgQdoF3lIfzu6HVHDAohd4XucA0r9kZhLLFERlrZaLlUqj?=
 =?iso-8859-1?Q?7UcqkwsS6ZYTAZQdud4awmwJQZyCIeJKqqUVdqxa6t/FyoL3npLf1bu8Ho?=
 =?iso-8859-1?Q?G+wH7o7wNQNtzA/InJd+5Sf+cUXu5YVPmH9Hn1h97KerUlnywcbbvBYs4m?=
 =?iso-8859-1?Q?V70NoX/quTLQDd+/eZnBJpOX/fJzmarvlFdxYPSw/1S3ndUUOZGrAnZNa9?=
 =?iso-8859-1?Q?/7hI544EJXsrqhjXtbAPu0GIux4noNT06p39rsmx2WVkOhaPs5p/4uZXxw?=
 =?iso-8859-1?Q?SFyL9o+gUWrFoFk+EhISv7reJ5ALwWYVZ/OB/gLNJomOx9VGa9hIw81mro?=
 =?iso-8859-1?Q?sJ+ywStjEOq2s4DBeCwl6vzidXBLdcOBYtNMrrhMu5qU8xik8HMt/oqurI?=
 =?iso-8859-1?Q?0b6GyaR7BJd7dxIXcrnf2DhbqMofuB+PeEcwVNrNbiX9zS8N450lCDmFLd?=
 =?iso-8859-1?Q?/KcQLGuCJ61Jkm+D2aAid1qkRqaAiSfXOYb77ttFlx4Cd0rY/c0BejiO/R?=
 =?iso-8859-1?Q?/pGyaUA1nF4jSpzEn7hizpF1tK1cLQzoRrluu3Qm6sMxaSJqX9vVvGBI/e?=
 =?iso-8859-1?Q?kD30uJBIrUqxTcltPxzgFWFgpkj+iaj5dPmqIj/bsAKyFHG8+bMtx29qPU?=
 =?iso-8859-1?Q?exs4+xH65REgOSN+lTz1b8DpaMSt+PjB08ThSSGxUciJdw2HKnNSF5Y8WC?=
 =?iso-8859-1?Q?WmZ8BwTosw0etQJXb8SzYHpBn0FKPachME9nyBxqpLEyV1Cqq5AMhxRYfQ?=
 =?iso-8859-1?Q?QIZvLwJa05MFBbCL+dskuURyBLv7UNiXsB/cgXcb/WXD3NRpV5uonyUoZn?=
 =?iso-8859-1?Q?+oNBd5IUPElKyQdKv6L1XQim/VZmeJ6X+UvwUdJ5IJKcvqlqjdXAfhDcPR?=
 =?iso-8859-1?Q?8ViNElRhfhYRi/I5VX+fmykfbUIS8dEGkbXSZ4Ra9kZ1Vo4MWNyzE2CN1F?=
 =?iso-8859-1?Q?BGfHsAUGXQ0bi8q+nFjzveb8Cm009zFSTzkY6ODBuxh8+i?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WloPIhFUJFDnuMyMGMHMCnnROrrZPAfMufL2GOkyD6qC36IiX5D7PX+sOTueCIqvrRhho/8on6JCDU/lUGW6Dt8bHV/8shNxT1vHBpUk6umgeFCg/MSIIqCDQb0T5FEpzZYpNGfYftV0tzy02WuEG9Gx1yt6hyWW9UFZL2Ci68bNzDWithIgHIiSOon7Ke17BavGIlve3Gr3fRdzcITP4EKeE0BALvl2ylwQaLuyu4LDJakd5KHuiZ5YvKI7iA9RnyJoO5E5hU11b2U3GxOMyNYYhU8JsUfXg+uTdD7BItmJ0+zVSg3pmMncX/JHbegA3jkxmxONbfPSx8i2GnKwrQ==
X-OriginatorOrg: sitime.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVWPR20MB994915.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223ce7a6-565e-4dbe-f8d5-08df1f4bc40b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 23:37:18.1427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8fb55916-cf10-4b0d-96f4-cf3952657263
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gg8ASUbjGwwuZ1oEEouGig21/j4dT9MJA0nACseRwlsGwou79pnhePAz42W0lXspOnuQeYqeXRvebg6TJK6utg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR20MB6748
X-MDID: 1790811441-o9ciD7MahUHz
X-PPE-STACK: {"stack":"us1"}
X-MDID-O:
 us1;ut7;1790811441;o9ciD7MahUHz;<arouhi@sitime.com>;ba04557de9d2da8490f5f1e6de07b967
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
 MAINTAINERS                    |   1 +=0A=
 drivers/dpll/Kconfig           |   2 +=0A=
 drivers/dpll/Makefile          |   1 +=0A=
 drivers/dpll/sit9531x/Kconfig  |  13 ++=0A=
 drivers/dpll/sit9531x/Makefile |   4 +=0A=
 drivers/dpll/sit9531x/core.c   | 320 +++++++++++++++++++++++++++++++++=0A=
 drivers/dpll/sit9531x/core.h   |  91 ++++++++++=0A=
 drivers/dpll/sit9531x/regs.h   |  44 +++++=0A=
 8 files changed, 476 insertions(+)=0A=
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
index 000000000000..c7c14442df92=0A=
--- /dev/null=0A=
+++ b/drivers/dpll/sit9531x/core.c=0A=
@@ -0,0 +1,320 @@=0A=
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
+ * so nothing here is cacheable except the page selector.  Caching that=0A=
+ * one spares a read of it before every access: the range code selects=0A=
+ * the page through a read-modify-write, and with no cache that read goes=
=0A=
+ * to the bus each time.=0A=
+ *=0A=
+ * The cached value is only as good as the last transfer, though.  A=0A=
+ * transfer that fails can leave the part on another page than the cache=
=0A=
+ * records, so every accessor drops the entry on an error and the next=0A=
+ * access reads the selector again.=0A=
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
+static void sit9531x_page_cache_drop(struct sit9531x_dev *sitdev)=0A=
+{=0A=
+	regcache_drop_region(sitdev->regmap, SIT9531X_PAGE_SEL,=0A=
+			     SIT9531X_PAGE_SEL);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * sit9531x_read_u8 - read an 8-bit register=0A=
+ * @reg:	register in SIT9531X_REG(page, offset) form=0A=
+ * @val:	output value=0A=
+ */=0A=
+int sit9531x_read_u8(struct sit9531x_dev *sitdev, unsigned int reg,=0A=
+		     u8 *val)=0A=
+{=0A=
+	unsigned int vreg, tmp;=0A=
+	int rc;=0A=
+=0A=
+	vreg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +=0A=
+	       SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	rc =3D regmap_read(sitdev->regmap, vreg, &tmp);=0A=
+	if (rc) {=0A=
+		sit9531x_page_cache_drop(sitdev);=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to read page 0x%02x reg 0x%02x: %d\n",=0A=
+			SIT9531X_REG_PAGE(reg), SIT9531X_REG_OFFSET(reg), rc);=0A=
+	} else {=0A=
+		*val =3D (u8)tmp;=0A=
+	}=0A=
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
+	unsigned int vreg;=0A=
+	int rc;=0A=
+=0A=
+	vreg =3D (SIT9531X_REG_PAGE(reg) * SIT9531X_PAGE_SIZE) +=0A=
+	       SIT9531X_REG_OFFSET(reg) + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	rc =3D regmap_write(sitdev->regmap, vreg, val);=0A=
+	if (rc) {=0A=
+		sit9531x_page_cache_drop(sitdev);=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to write page 0x%02x reg 0x%02x: %d\n",=0A=
+			SIT9531X_REG_PAGE(reg), SIT9531X_REG_OFFSET(reg), rc);=0A=
+	}=0A=
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
+	u8 page =3D sit9531x_pll_page(pll_idx);=0A=
+	unsigned int vreg;=0A=
+	int rc;=0A=
+=0A=
+	vreg =3D (page * SIT9531X_PAGE_SIZE) + offset + SIT9531X_RANGE_OFFSET;=0A=
+=0A=
+	/*=0A=
+	 * A read-modify-write is a read and a write, and either can leave=0A=
+	 * the cached page selector wrong, so fail the way the single=0A=
+	 * accessors do.=0A=
+	 */=0A=
+	rc =3D regmap_update_bits(sitdev->regmap, vreg, mask, val);=0A=
+	if (rc) {=0A=
+		sit9531x_page_cache_drop(sitdev);=0A=
+		dev_err(sitdev->dev,=0A=
+			"Failed to update page 0x%02x reg 0x%02x: %d\n",=0A=
+			page, offset, rc);=0A=
+	}=0A=
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
